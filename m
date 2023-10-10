Return-Path: <netdev+bounces-39633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B77C0335
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449CD28120D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76909225C3;
	Tue, 10 Oct 2023 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8mowFw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58237225B8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63A8C433C7;
	Tue, 10 Oct 2023 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696961766;
	bh=p1P3M9x27b0Oh9J9fosNp8f/t0MCauzhdR4ng/jVTAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8mowFw6EhhccQdDXhJEqzWht/VRB7woZWZNyyCsXmRk6PILXe63ScRIULkoiwdEG
	 TfISxJF/mAStEgv8Kkan3IBkTZGPoMSjlqgRMOoh0UqG57KOoT0LsF9Q2aoeCbS0iA
	 kIjP9PUeSR467f0Sk6iu15SUW5cl9NGssvygUUNy7H5jw5s/cEXADhVs7hIBIWQEOg
	 B0JJhcXEZa3djfDs9HOpYzOMmB7ljcOXOuC8WqlGLswEYZ/xI1eY6ePfQp0gd7sK2M
	 ZTAe0KIyh9E+LGvNqVBIflvKJFPxXHow6FA1GWjvRHKgTYQB6m4sTCZ7523FuecMwB
	 flFne0MiZ5BVg==
Date: Tue, 10 Oct 2023 11:16:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231010111605.2d520efc@kernel.org>
In-Reply-To: <ZSV0NOackGvWn7t/@nanopsycho>
References: <ZR+1mc/BEDjNQy9A@nanopsycho>
	<20231006074842.4908ead4@kernel.org>
	<ZSA+1qA6gNVOKP67@nanopsycho>
	<20231006151446.491b5965@kernel.org>
	<ZSEwO+1pLuV6F6K/@nanopsycho>
	<20231009081532.07e902d4@kernel.org>
	<ZSQeNxmoual7ewcl@nanopsycho>
	<20231009093129.377167bb@kernel.org>
	<ZST9yFTeeTuYD3RV@nanopsycho>
	<20231010075231.322ced83@kernel.org>
	<ZSV0NOackGvWn7t/@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 17:56:36 +0200 Jiri Pirko wrote:
> >You understand what I'm saying tho, right?
> >
> >If we can depend on the parent not disappearing before the child,
> >and the hierarchy is a DAG - the locking is much easier, because
> >parent can lock the child.  
> 
> It won't help with the locking though. During GET, the devlink lock
> is taken and within it, you need to access the nested devlink attributes.
> 
> And during reload->notify, we still need work so the lock are taken in
> proper order.

If parent is guaranteed to exist the read only fields can be accessed
freely and the read-write fields can be cached on children.
Parent has a list of children, it can store/cache a netns pointer on all
of them. When reload happens lock them and update that pointer.
At which point children do not have to lock the parent.

> It would only make the rel infrastructure a bit similer. I will look
> into that. But it's parallel to this patchset really.


