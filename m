Return-Path: <netdev+bounces-236921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BCC42392
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 02:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4180D3B0B3B
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4F286D4E;
	Sat,  8 Nov 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owVNnjE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA4145B3E
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762564267; cv=none; b=mF92NB4l3jprQdw/Y3duPthLB+Npzj4H+gQEHSFh27kI7V36vrKpicIql9o7XrH/3UZHAD1MUF09B3tbflcVVHDkRKFwv/UScUUTD7A8ats2jg053FX0YPEN7JEo+OUhducozrYupOrsdoXK0MFZeX2a7O77dFzUuHHh4AYRIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762564267; c=relaxed/simple;
	bh=vKvPEc0OL56xvPcMsxJFQrmcCo4e6Q05X9tUYOSx5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qa8JOLNProcVWdFwsSomtKsuCEyAe/gq6n1xK4wiiTR213u5Ril0AbHuRvgtSL996Fkkzs/okR9tEo//Bba0NnHFJA0xISB6Oy0jgAz5UBDITrBYMnM7d+IGll6y+XMeMXlw1/VGn5sfbbD+FBiDU6sgpzXkcvNfKMM9bRQnJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owVNnjE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC35C4CEF7;
	Sat,  8 Nov 2025 01:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762564264;
	bh=vKvPEc0OL56xvPcMsxJFQrmcCo4e6Q05X9tUYOSx5KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=owVNnjE7rpsR/fXVy5i3r/TrRDPynfRnlN1NADbVrhl52cS7clwQNTMMG1PYBZwd6
	 zsN/QkKp8g1wByCaab8YVZtJ1w/idgxBkfjBShJJDFjUwCll9g4fMp9a7E0EI5CY9l
	 hqx5OdAayvLn/LCYNF2xJ08qSVXJxter+bNwOI3A0h9EyQQBpILa/PhjzqBGgs7I0r
	 jZ09zNxBF8kj4s1sBU+w64/djiAKf+YWm47XsO2LGLr7gX9WXQqHQSkVTBJpn6MLmN
	 PuknKC7EFvyrraIzHidgPob8im5tyr7Acns0XfzuwqTYPkWuYuKC7PbX4LwwxwIcxZ
	 0Rt7Y1X3QxvTA==
Date: Fri, 7 Nov 2025 17:11:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <20251107171103.2ecda810@kernel.org>
In-Reply-To: <aQ30WmbN_O60vEzl@lore-desk>
References: <20250610-airoha-eth-lro-v1-1-3b128c407fd8@kernel.org>
	<CANn89iJsNWkWzAJbOvaBNjozuLOQBcpVo1bnvfeGq5Zm6h9e=Q@mail.gmail.com>
	<aEg1lvstEFgiZST1@lore-rh-laptop>
	<20250611173626.54f2cf58@kernel.org>
	<aEtAZq8Th7nOdakk@lore-rh-laptop>
	<20250612155721.4bb76ab1@kernel.org>
	<aFATYATliil63D5R@lore-desk>
	<aQR2Z51Q45Zl99m_@lore-desk>
	<20251031111641.08471c44@kernel.org>
	<aQ30WmbN_O60vEzl@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 14:30:02 +0100 Lorenzo Bianconi wrote:
> > On Fri, 31 Oct 2025 09:42:15 +0100 Lorenzo Bianconi wrote:  
> > > Sorry for the late reply about this item.
> > > I carried out some comparison tests between GRO-only and GRO+LRO with order-2
> > > pages [0]. The system is using a 2.5Gbps link. The device is receiving a single TCP
> > > stream. MTU is set to 1500B.
> > > 
> > > - GRO only:			~1.6Gbps
> > > - GRO+LRO (order-2 pages):	~2.1Gbps
> > > 
> > > In both cases we can't reach the line-rate. Do you think the difference can justify
> > > the hw LRO support? Thanks in advance.
> > >  
> > > [0] the hw LRO requires contiguous memory pages to work. I reduced the size to
> > > order-2 from order-5 (original implementation).  
> > 
> > I think we're mostly advising about real world implications of 
> > the approach rather than nacking. I can't say for sure if potentially
> > terrible skb->len/skb->truesize ratio will matter for a router
> > application. Maybe not.
> > 
> > BTW is the device doing header-data split or the LRO frame has headers
> > and payload in a single buffer?  
> 
> According to my understanding the hw LRO is limited to a single order-x page
> containing both the headers and the payload (the hw LRO module is not capable
> of splitting the aggregated TCP segment over multiple pages).
> What we could do is disable hw LRO by default and feed hw rx queues with
> order-0 pages (current implementation). If the user enables hw LRO, we will
> free order-0 pages linked to the rx DMA descriptors and allocate order-x pages
> (e.g. order-2) for hw LRO queues. Disabling hw LRO will switch back to order-0
> pages.

Are all packets LRO-sized when it's enabled? What you describe is
definitely good, bur I was wondering if we can also use rx-buf-len
to let user select the size / order of the LRO buffers.

But the definition of rx-buf-len is that it's for _all_ rx buffers
on given queue. We'd probably need a new param if the pages are
just for lro

