Return-Path: <netdev+bounces-20532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F361675FF89
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BEA1C20BCB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD17F100D6;
	Mon, 24 Jul 2023 19:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95066F51C
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42E7C433C7;
	Mon, 24 Jul 2023 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690225640;
	bh=DPOv4l3Ji1NWknHd7jspJg5h0M6VoEI2H/nGWxgApXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1Dpwm5FFolD0v09BSo3cJjVLzeBFKA3uKdX2a4K7JN8pmhvjGXHFgDVuClhUYxdL
	 u4g2Sh2UaF5+j0/yveACYvWIohZeuN3NEFUGnKI2OnBKery4KbfyOLgXZNVO3QunMw
	 UxnnMgaQk5BHOk/NF/LHiS1tTAmr7zWsCijUc63g3QS3oHxJieTyDVRdPKQqtaDT41
	 B0z36nawyXH+QXSM5HkCkFSHeszyzYM93X7MyzlH+UwRu7smGjMev0/e11rPjm0NxL
	 i6Pm4ZR2l7or19zV1N4vDNQ7JYUsS6c423zbGVlUyJ61+r0GOP1arjCE+FNIP1I2BR
	 vDqr3kLur4lSQ==
Date: Mon, 24 Jul 2023 12:07:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 mkubecek@suse.cz, lorenzo@kernel.org
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <20230724120718.4f01113a@kernel.org>
In-Reply-To: <20230724102741.469c0e42@kernel.org>
References: <20230722014237.4078962-1-kuba@kernel.org>
	<20230722014237.4078962-2-kuba@kernel.org>
	<20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
	<20230724084126.38d55715@kernel.org>
	<2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
	<20230724102741.469c0e42@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 10:27:41 -0700 Jakub Kicinski wrote:
> > I still have some minor doubts WRT the 'missed device' scenario you
> > described in the commit message. What if the user-space is doing
> > 'create the new one before deleting the old one' with the assumption
> > that at least one of old/new is always reported in dumps? Is that a too
> > bold assumption?  
> 
> The problem is kinda theoretical in the first place because it assumes
> ifindexes got wrapped so that the new netdev comes "before" the old in
> the xarray. Which would require adding and removing 2B netdevs, assuming
> one add+remove takes 10 usec (impossibly fast), wrapping ifindex would
> take 68 years.

I guess the user space can shoot itself in the foot by selecting 
the lower index for the new device explicitly.

> And if that's not enough we can make the iteration index ulong 
> (i.e. something separate from ifindex as ifindex is hardwired to 31b
> by uAPI).

We can get the create, delete ordering with this or the list, but the
inverse theoretical case of delete, create ordering can't be covered.
A case where user wants to make sure at most one device is visible.

I'm not sure how much we should care about this. The basic hash table
had the very real problem of hiding devices which were there *before
and after* the dump.

Inconsistent info on devices which were created / deleted *during* the
dump seems to me like something that's best handled with notifications.

I'm not sure whether we should set the inconsistency mark on the dump
when del/add operation happened in the meantime either, as 
the probability that the user space will care is minuscule.

LMK what you think.

