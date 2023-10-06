Return-Path: <netdev+bounces-38615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE57BBAC4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E9B2823C7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4986266CA;
	Fri,  6 Oct 2023 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlNdoc4K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B322EFC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3C9C433C7;
	Fri,  6 Oct 2023 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696603723;
	bh=S93LvOU1CKbDaBjxEm6t05wR9R5agBOs0aTrpTBC+Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlNdoc4KFQDG+xiHQM4gqzoWUEeIxBIijnS+VIMnnDmZnAullLCe7h4eB9RvZFjnD
	 goE9sqNY73N2VBBcxz7OlXDzVEBd/Ui9Z7PSkh2hjBqNzpIAbxl23riydDBSVItP8g
	 rUvuckRXHkGFgWOXUS3QMqbMbOo26jAtjot+lfMug1VKoHuonG3nsn70DQmbCSaOFK
	 1Tot4whn5FU4RyRVRg9y2fzjqDUfEWnF0w92Udh52OCZxjhD6nIYJxQ1lh34ObfHXK
	 E6hABHyLrGkvoyZLUExO/e6V5oQm+VyRXs1NrjlBAk5PEEvyi9u/kgYLn2b2dBaL07
	 Nyos2NbY/0OWg==
Date: Fri, 6 Oct 2023 07:48:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231006074842.4908ead4@kernel.org>
In-Reply-To: <ZR+1mc/BEDjNQy9A@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
	<20231005183029.32987349@kernel.org>
	<ZR+1mc/BEDjNQy9A@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 09:22:01 +0200 Jiri Pirko wrote:
> Fri, Oct 06, 2023 at 03:30:29AM CEST, kuba@kernel.org wrote:
> >> @@ -310,6 +299,7 @@ static void devlink_release(struct work_struct *work)
> >>  
> >>  	mutex_destroy(&devlink->lock);
> >>  	lockdep_unregister_key(&devlink->lock_key);
> >> +	put_device(devlink->dev);  
> >
> >IDK.. holding references until all references are gone may lead 
> >to reference cycles :(  
> 
> I don't follow. What seems to be the problematic flow? I can't spot any
> reference cycle, do you?

I can't remember to be honest. But we already assume that we can access
struct device of a devlink instance without holding the instance lock.
Because the relationship between devlink objects is usually fairly
straightforward and non-cyclical.

Isn't the "rel infrastructure"... well.. over-designed?

The user creates a port on an instance A, which spawns instance B.
Instance A links instance B to itself.
Instance A cannot disappear before instance B disappears.
Also instance A is what controls the destruction of instance B
so it can unlink it.

We can tell lockdep how the locks nest, too.

> >Overall I feel like recording the references on the objects will be
> >an endless source of locking pain. Would it be insane if we held 
> >the relationships as independent objects? Not as attributes of either
> >side?   
> 
> How exactly do you envision this? rel struct would hold the bus/name
> strings direcly?

No exactly, if we want bi-directional relationships we can create 
the link struct as a:

rel {
	u32 rel_id;
	struct devlink *instanceA, *instanceB; // hold reference
	struct list_head rel_listA, rel_listB; // under instance locks
	u32 state;
	struct list_head ntf_process_queue;
}

Operations on relationship can take the instance locks (sequentially).
Notifications from a workqueue.
Instance dumps would only report rel IDs, but the get the "members" of
the relationship user needs to issue a separate DL command / syscall.

