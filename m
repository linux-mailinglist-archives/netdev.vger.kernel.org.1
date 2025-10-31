Return-Path: <netdev+bounces-234725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80EC268AB
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037C23AE179
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755034DCC2;
	Fri, 31 Oct 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmK3nULs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EE23D28B
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934603; cv=none; b=TEE9BVZunKZO5+FkgWy6bUPcI2/8u9Tb+/CRAVuL+T4TX7IsJucnVVT4YlC0J2k2c2HUJd/uYe8s9risFc/tAAdFyZdS9Loggb8o+0ndatZT3GkpHaIStoaf/mVbRxfzb98xTQDAfDNG53i6fakVWNUCGVlXMH5xwuOS/OPBUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934603; c=relaxed/simple;
	bh=JnGr5vUYfVAVza81n1ZuarMPqOm1k7qNnjeylSO/u4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB5x4jCveBKlPwLVV0FUPpdhuZJJPHiE34h9GQo0wIW/1SV6r0G6j2ZJEd9g3+mPDl+JmIAYc1fWAvTTYWjTOkjWQHf1hT9Pz71SaGX+vJPcN4gah+wpmPy4E6VAengzd1nalhduppccBgzgYgj8H2oryTQAIPMeWHoi0SG9KwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmK3nULs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E322C4CEE7;
	Fri, 31 Oct 2025 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761934603;
	bh=JnGr5vUYfVAVza81n1ZuarMPqOm1k7qNnjeylSO/u4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmK3nULsKWb4OBVjVEIiQPxIWECn/zWUWrH03JI1dsV8J6T8ZSr5nuNescmInN8K9
	 HYZ319GYROw8OfkDz2RIMOzkw3A2gnGjKgJKXtTuG2RvvOI7q01uk5C86vC3qcdPnT
	 Z2CbDx/Yy7siPbUNnEJM/SSyRNAWzcsSpIOhH6YbuAF5wFeUvU2dzoXC9xgeDj+nzE
	 Q7HznMnBwHtZTvBwlEytqTpb76ij7EVPGxwlIFTwKG+Yb8FxST0jYignNsySn0zLCo
	 plMd3mzLB03sIZSkDRzK7oyh8y0NsfFB3bUMxVKw5Wc45xk+qnCiRMs24BQKQ1eAWf
	 cYWPbbEMtIU4w==
Date: Fri, 31 Oct 2025 11:16:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <20251031111641.08471c44@kernel.org>
In-Reply-To: <aQR2Z51Q45Zl99m_@lore-desk>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
	<CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
	<aEg1lvstEFgiZST1@lore-rh-laptop>
	<20250611173626.54f2cf58@kernel.org>
	<aEtAZq8Th7nOdakk@lore-rh-laptop>
	<20250612155721.4bb76ab1@kernel.org>
	<aFATYATliil63D5R@lore-desk>
	<aQR2Z51Q45Zl99m_@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 09:42:15 +0100 Lorenzo Bianconi wrote:
> > > Hm, truesize is the buffer size, right? If the driver allocated n bytes
> > > of memory for packets it sent up the stack, the truesizes of the skbs
> > > it generated must add up to approximately n bytes.  
> > 
> > With 'truesize' I am referring to the real data size contained in the x-order
> > page returned by the hw. If this size is small, I was thinking to just allocate
> > a skb for it, copy the data from the x-order page into it and re-insert the
> > x-order page into the page_pool running page_pool_put_full_page().
> > Let me do some tests with order-2 page to see if the GRO can compensate the
> > reduced page size.  
> 
> Sorry for the late reply about this item.
> I carried out some comparison tests between GRO-only and GRO+LRO with order-2
> pages [0]. The system is using a 2.5Gbps link. The device is receiving a single TCP
> stream. MTU is set to 1500B.
> 
> - GRO only:			~1.6Gbps
> - GRO+LRO (order-2 pages):	~2.1Gbps
> 
> In both cases we can't reach the line-rate. Do you think the difference can justify
> the hw LRO support? Thanks in advance.
>  
> [0] the hw LRO requires contiguous memory pages to work. I reduced the size to
> order-2 from order-5 (original implementation).

I think we're mostly advising about real world implications of 
the approach rather than nacking. I can't say for sure if potentially
terrible skb->len/skb->truesize ratio will matter for a router
application. Maybe not.

BTW is the device doing header-data split or the LRO frame has headers
and payload in a single buffer?

