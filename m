Return-Path: <netdev+bounces-108283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5791EA46
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A92282550
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC517165D;
	Mon,  1 Jul 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlQ3vBw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D284A32
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869104; cv=none; b=jKsn8c2mjxCr3FqJc1AMXHO4lSZFuBRG7FAAwwS7KBCwR/bSYoHSbN01VTWzhDvvomp1pCdYxFyi+CfIhdK6BSFZ3gbJ3RdyKmIm06eOXw2GM06/z1SdM9rw1F/a/anvdsrOXTAMFf3IyG4YivDa7tu8qRGcusIxtHAIMWSM4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869104; c=relaxed/simple;
	bh=L+DbI12cljPaAa7910IB/ecv+v//6gFWlfUZIhwemgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbMMUgQgjmrCUd8VhI9ILfXSlBkSmHn0Fi8cZmN/WJ75zNeWBrvMPxLZzyQ0AIWeECzBrHCoQQB81SNz/f6zTf9pVbmPbgLLimCWjOt+OSwEokvql1Ru2RqA0c4mLexijMefl5V4tp4oxS8ozSwfm3FboW9IyKO789nrXCwC/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlQ3vBw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4541EC116B1;
	Mon,  1 Jul 2024 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719869103;
	bh=L+DbI12cljPaAa7910IB/ecv+v//6gFWlfUZIhwemgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tlQ3vBw/gHfPcMzc1he5mJydlTC4mtF1wqH7r0xI2+6uxo40Bze84NTSrir8/WP6I
	 QXmGzMDDHF/w/QbudR8IoEsoOFk/6a/GW8B8kajgjxDIono4QH8YgeibgamOXRv61H
	 kPS0ieddz6naRu/A91ZVy+EkwEXb1FTn9Bu9Hvv/Hycj5E/2H5mx1kotzN2GRrHG7o
	 T53WJvX2ApCnab9UDux15G+9OIPDmAjkFKxN4ywNj4TSmw2niEb9jbPWxBsHRCgqGi
	 lApj+64/YXJBHmuHZXBu2ykJ2vezmfm+/dPojjv8Ov0S5xu+PVLLZ2lfyhOcVIixE6
	 +QbkxLlH/IqbQ==
Date: Mon, 1 Jul 2024 14:25:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rushil Gupta <rushilg@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 willemb@google.com, hramamurthy@google.com, Shailend Chand
 <shailend@google.com>, Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [PATCH net-next] gve: Add retry logic for recoverable adminq
 errors
Message-ID: <20240701142502.1a831c74@kernel.org>
In-Reply-To: <CANzqiF7TQW2yUM14XS68CxM35yJpq8DCRJRonMcyfTpfatBtMQ@mail.gmail.com>
References: <20240628204139.458075-1-rushilg@google.com>
	<20240628180206.07c0a1b2@kernel.org>
	<CANzqiF7TQW2yUM14XS68CxM35yJpq8DCRJRonMcyfTpfatBtMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 10:56:27 -0700 Rushil Gupta wrote:
> > Since Jeroen is a maintainer of this driver, and you are not listed
> > in the MAINTAINERS file I don't understand why you're the one sending
> > this. We can't teach everyone at google the upstream process one by
> > one so I'd like to request that only the listed maintainers post pure
> > GVE patches (or the folks who are heavily involved upstream).  
> 
> I could not find one single documentation that says only listed
> maintainers can post pure patches.
> Authors of some of the recently accepted patches were in fact not in
> the MAINTAINERS file.

It's not documented because we have to resort to it very rarely.
The escalation path is - remind of the process -> request that
someone knowledgeable reviews the code prior to posting -> limit
submitters.

> I am sending this patch as I was involved in getting this code to the
> upstream-ready state and testing it internally.
> However, if other GVE maintainers wish to follow this rule; I am ok
> with your suggestion.

