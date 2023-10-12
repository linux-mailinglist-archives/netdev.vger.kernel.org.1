Return-Path: <netdev+bounces-40195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E37C61A4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1632282439
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAB1362;
	Thu, 12 Oct 2023 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/WpbGib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AAB19B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A28BC433C8;
	Thu, 12 Oct 2023 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070026;
	bh=l3n0Alj1Oit+8TZY1uFqKPCGdJ5IVAWaWLxHe1nqPbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L/WpbGibGwZEr8gGCJhGUmTnewWT2I8snE0rzssQdacDPjr3ae4LE3IiCDqj0PEk2
	 84QRXTnDyuO93O2Kp5ARRNjpnrUGjeEsCT545mga1OAR2KBxHZZhvmLMW1Wz30zucY
	 gd2eM54COmWiQ3nHFEzMNqCHaqrzfbOAi0Rgp7yIEvZWjZDAI6aGuxSLjnuiLTCWYD
	 YLYqvL5eSmCjTi+OXEez+neIC2lrqBi+Ysz32hF8P1Bf5UDhNqkLAZJNYziOtmJm0J
	 xSr5yYZ+PcMSuXSVIbuvufF0jdyUH7U5sja7fFE9gJs51qEn4YhfLbWaUyWXOA4++i
	 z9ix2QnORNvzA==
Date: Wed, 11 Oct 2023 17:20:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231011172025.5f4bebcb@kernel.org>
In-Reply-To: <ZSakg8W+SBgahXtW@nanopsycho>
References: <ZSA+1qA6gNVOKP67@nanopsycho>
	<20231006151446.491b5965@kernel.org>
	<ZSEwO+1pLuV6F6K/@nanopsycho>
	<20231009081532.07e902d4@kernel.org>
	<ZSQeNxmoual7ewcl@nanopsycho>
	<20231009093129.377167bb@kernel.org>
	<ZST9yFTeeTuYD3RV@nanopsycho>
	<20231010075231.322ced83@kernel.org>
	<ZSV0NOackGvWn7t/@nanopsycho>
	<20231010111605.2d520efc@kernel.org>
	<ZSakg8W+SBgahXtW@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 15:34:59 +0200 Jiri Pirko wrote:
> >If parent is guaranteed to exist the read only fields can be accessed
> >freely and the read-write fields can be cached on children.  
> 
> Only reason to access parent currently is netns change notification.
> See devlink_rel_nested_in_notify().
> It basically just scheduled delayed work by calling:
> devlink_rel_nested_in_notify_work_schedule().
> 
> When work is processed in
> devlink_rel_nested_in_notify_work()
> There is no guarantee the parent exists, therefore devlink_index is used
> to get the instance and then obj_index to get port/linecard index.
> 
> notify_cb() basically sends notification of parent object and that needs
> parent instance lock. <--- This is why you need to lock the parent.
> 
> I see no way how to cache anything on children as you describe in this
> scenario.
> 
> 
> >Parent has a list of children, it can store/cache a netns pointer on all
> >of them. When reload happens lock them and update that pointer.
> >At which point children do not have to lock the parent.  
> 
> Access of netns pointer is not a problem. 

The current code is a problem in itself. You added another xarray,
with some mark, callbacks and unclear locking semantics. All of it
completely undocumented.

The RCU lock on top is just fixing one obvious bug I pointed out to you.

Maybe this is completely unfair but I feel like devlink locking has
been haphazard and semi-broken since the inception. I had to step in 
to fix it. And now a year later we're back to weird locking and random
dependencies. The only reason it was merged is because I was on PTO.

