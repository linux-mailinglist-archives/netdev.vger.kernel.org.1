Return-Path: <netdev+bounces-14016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689B73E67A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1488A280DE8
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63722125BC;
	Mon, 26 Jun 2023 17:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923E1107
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B10C433C0;
	Mon, 26 Jun 2023 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687800786;
	bh=jOrTlMy4ntYLqOupRyjV0fJum9P6/3X5EZ6BwbUYnwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tVczjgAhH+k25sxhcGMmkvZAKZJVy36Wnki9byQMyCh8M/KM/S3e+LiCTbGO2DRQc
	 ZFSbh0fghAHurbXBlIS9Bsal2BWGSeco2bkWO246wmBwd3LBBQRal68wgP+iI2y63v
	 dsywhm+RKLViuRetzKuhbxjkGVMXVX+mr/hKt0jTBcKMT0isFqipJDRrt6QQHi0/2o
	 ocAEb2MO+t9+KWxIA4DT5d6E95tNxK4uFBsCjuYypCaBQ7SvgFnUvdFe7QEOEW8CfW
	 Pvg4gbvi2aNnTsK5sABQhkAy4cMfc88t8Ebr6vwNbB7Nhz41X7N38jRtmHinftpzcj
	 4GAYboRChvswg==
Date: Mon, 26 Jun 2023 10:33:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net] ibmvnic: Do not reset dql stats on NON_FATAL err
Message-ID: <20230626103305.3d8bb0b5@kernel.org>
In-Reply-To: <25e42e2a-4662-e00a-e274-a6887aaae9d6@linux.ibm.com>
References: <20230622190332.29223-1-nnac123@linux.ibm.com>
	<20230624151911.7442620c@kernel.org>
	<25e42e2a-4662-e00a-e274-a6887aaae9d6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 10:45:38 -0500 Nick Child wrote:
> On 6/24/23 17:19, Jakub Kicinski wrote:
> > On Thu, 22 Jun 2023 14:03:32 -0500 Nick Child wrote:  
>  [...]  
> > 
> > Why are you trying to clear this bit?
> > 
> > If the completions will still come the bit will be cleared (or not)
> > during completion handling (netdev_tx_completed_queue() et al.)
> > 
> > Drivers shouldn't be poking into queue state bits directly.  
> 
> Most likely, yes there could be some bytes that will get a completion 
> which would clear this bit.
> 
> That being said, it is also possible that all bytes sent to the NIC are 
> already completed. In which case we would not get a completion. The 
> ibmvnic driver sends its skb's to the NIC in batches, it makes a call to 
> netdev_tx_sent_queue on every time an skb is added to the batch. This is 
> not necessarily every-time that the batch is sent to the NIC.

If packets can get stuck in the driver that needs a dedicated fix.

> I am not sure what number of bytes causes dql to set 
> __QUEUE_STATE_STACK_XOFF but I do know that it is possible for up to 15 
> skb's to be sitting in the queues batch. If there are no outstanding 
> bytes on the NIC (ie not expecting a tx completion) and the internal 
> batch has 15 references per queue, is this enough to enforce dql and set 
> __QUEUE_STATE_STACK_XOFF? If so, then we must clear 
> __QUEUE_STATE_STACK_XOFF when resetting.

You should only be doing the batching if xmit_more is set, really.
And xmit_more will not be set if core is about to set
__QUEUE_STATE_STACK_XOFF. 

With a correctly written driver STACK_XOFF can only be set if we're
expecting a completion.

> I had a feeling this would raise some eyebrows. The main intent is to do 
> everything that netdev_tx_reset_queue() does besides resetting 
> statistics. Setting a "*STACK*" flag in driver code feels wrong 
> (especially since a *DRV* flag exists) but I could not find an 
> appropriate upper-level function. I suppose an alternative is to read 
> this flag after the device finishes the reset and sending the batch if 
> it is set. Is this any better?

AFAIU you shouldn't have to clear this flag. We need to reset DQL when
hard resetting the queue because we may lose completions. But if no
completions are lost, STACK_XOFF should be left alone. 

Just clearing that flag is not valid either because qdiscs will not be
rescheduled, so until some socket tries to xmit next packet the data
already queued will not move.

