Return-Path: <netdev+bounces-40855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8287C8E0C
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 22:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F1B20A75
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10630241ED;
	Fri, 13 Oct 2023 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUM6fagd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0A1428A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 20:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE53C433C7;
	Fri, 13 Oct 2023 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697227262;
	bh=Mel2kZZh4stKwUIxVFTBJV4b0rb1lzz9bFjD9C4XiUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZUM6fagd1YUucDswGFOHE4nUnF5ecpiK2+6JQ2/RiVS3sXJrlUPCGamGrTet/I5uS
	 n7kQ8mP9HGcHax/H9fea7l5tjNMhcs/rDhdS90CJCnSxNyc2pMXAViJ7CHKS48/UuO
	 Id/N1nwfJ5pIFuFe5Me69cc/xMwv3Cwgg6Mfo0+sOg8NGhQZErIgETT60g8jfpLi1B
	 5JK3ze4q54Zi+XW3Cu6E6XUsVzvAW8RWWNToB1Najx5TUgE5R5BJKPd+XN6J0FB7fj
	 9mJy//CEoxgvjuwUwuzbqdK8aVcTpYfP7KKSBartGwZyNMJ0C+zv4yQytMnqKRPuVT
	 mmIGQ0OYaF33g==
Date: Fri, 13 Oct 2023 13:01:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231013130100.0d08fb97@kernel.org>
In-Reply-To: <ZSl5OS7bFsg/ahCK@nanopsycho>
References: <ZSQeNxmoual7ewcl@nanopsycho>
	<20231009093129.377167bb@kernel.org>
	<ZST9yFTeeTuYD3RV@nanopsycho>
	<20231010075231.322ced83@kernel.org>
	<ZSV0NOackGvWn7t/@nanopsycho>
	<20231010111605.2d520efc@kernel.org>
	<ZSakg8W+SBgahXtW@nanopsycho>
	<20231011172025.5f4bebcb@kernel.org>
	<ZSeOq+I+Z12E/oRC@nanopsycho>
	<20231013083945.3f6d8efe@kernel.org>
	<ZSl5OS7bFsg/ahCK@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 19:07:05 +0200 Jiri Pirko wrote:
> >> Not sure what obvious bug you mean. If you mean the parent-child
> >> lifetime change, I don't know how that would help here. I don't see how.
> >> 
> >> Plus it has performance implications. When user removes SF port under
> >> instance lock, the SF itself is removed asynchonously out of the lock.
> >> You suggest to remove it synchronously holding the instance lock,
> >> correct?   
> >
> >The SF is deleted by calling ->port_del() on the PF instance, correct?  
> 
> That or setting opstate "inactive".

The opstate also set on the port (i.e. from the PF), right?

> >> SF removal does not need that lock. Removing thousands of SFs
> >> would take much longer as currently, they are removed in parallel.
> >> You would serialize the removals for no good reason.  
> >
> >First of all IDK what the removal rate you're targeting is, and what
> >is achievable under PF's lock. Handwaving "we need parallelism" without
> >data is not a serious argument.  
> 
> Oh there are data and there is a need. My colleagues are working
> on parallel creation/removal within mlx5 driver as we speak. What you
> suggest would be huge setback :/

The only part that needs to be synchronous is un-linking.
Once the SF is designated for destruction we can live without the link,
it's just waiting to be garbage-collected.

> >> Not sure what you mean by that. Locking is quite clear. Why weird?
> >> What's weird exactly? What do you mean by "random dependencies"?
> >> 
> >> I have to say I feel we got a bit lost in the conversation.  
> >
> >You have a rel object, which is refcounted, xarray with a lock, and 
> >an async work for notifications.  
> 
> Yes. The async work for notification is something you would need anyway,
> even with object lifetime change you suggest. It's about locking order.

I don't think I would. If linking is always done under PF's lock we can
safely send any ntf.

> Please see the patchset I sent today (v3), I did put in a documentation
> describing that (3 last patches). That should make it clear.

It's unnecessarily complicated, but whatever, I'm not touching it.

