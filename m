Return-Path: <netdev+bounces-214995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC5B2C87C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16558562C0D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7412248BD;
	Tue, 19 Aug 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc7MWfWd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667461DA4E;
	Tue, 19 Aug 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617440; cv=none; b=g2MhK7tPpQjcIxI0P92OdLo0thyiUAX6kaIIzAalkI01SgPXDnWblDVfruhK0Pfzg8AY1ca+PBU2zEvcM4CRh28pB24A18maOQ/hESymtpGxVka1Hjkpfo5hj1iwsGSIVGImvP3R/i8w1YiZDpjXNCK3TvFPBW69i+a3MOa/DNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617440; c=relaxed/simple;
	bh=SiZ53A12CJ75yLR1wmI88DrZz0TyUleW7Tuc4Fokse4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDxC44mVhGO8osGhSc4tCJnXOlYlZZytdJNil3tF5n+Y6CSUk+8Ssni4IYERNNLoOx7OmFNknFNvdP2tQoOMDys+UYMMuink9w5fejz1Lc4z3CU5IfyKJzbmubhsAVRf+gPPKzllhFrAuL20mdaduzjuT1WoL32C/d6x94fR4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc7MWfWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B969C4CEF1;
	Tue, 19 Aug 2025 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755617438;
	bh=SiZ53A12CJ75yLR1wmI88DrZz0TyUleW7Tuc4Fokse4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zc7MWfWdAOS5e0tRM1n6pvBSeg4aU1PhtK88MBUqv1rAS7SlxVE3dYN2thkoSf81r
	 vzIie5UB7oO0D7+dDRHS/XmIsqBvjjXMXZ5Ff4NzX1sMRCtD17rwqMc89q5stekzm2
	 8XXJya3nkrajq5gYu8+9kUgqi1h3Sl0l3HsGCRKhxAw04iOqOaLe4ZK71nD7G20Wfb
	 KPQqwi5xYQScZyyxK0bWNOaDVUXfDb8xtS2h4BXiYFy8rAqFhEXDdEQj/fDCbPHu65
	 gClxYYhQ6HtFfFMlmNXgO2JP3qoOMjlGwwOpFzuRNQ7XxAR6JPLtkMUVpQKQYbCdm7
	 rE8xL7NoYqE6Q==
Date: Tue, 19 Aug 2025 08:30:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: almasrymina@google.com, asml.silence@gmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com,
 tariqt@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
Message-ID: <20250819083037.521e82d0@kernel.org>
In-Reply-To: <gessx5kiukxckwkjqmtrf7j52i42zzme2th4zmvleppnklt2dq@wif23q6f6cog>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
	<20250815110401.2254214-3-dtatulea@nvidia.com>
	<20250815101627.3c0bc59d@kernel.org>
	<gessx5kiukxckwkjqmtrf7j52i42zzme2th4zmvleppnklt2dq@wif23q6f6cog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 14:41:08 +0000 Dragos Tatulea wrote:
> On Fri, Aug 15, 2025 at 10:16:27AM -0700, Jakub Kicinski wrote:
> > On Fri, 15 Aug 2025 14:03:42 +0300 Dragos Tatulea wrote:  
> > > +static inline struct device *
> > > +netdev_queue_get_dma_dev(struct net_device *dev, int idx)
> > > +{
> > > +	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
> > > +	struct device *dma_dev;
> > > +
> > > +	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
> > > +		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
> > > +	else
> > > +		dma_dev = dev->dev.parent;
> > > +
> > > +	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
> > > +}  
> > 
> > This really does not have to live in the header file.  
> Alright, but where? It somewhat fits in the existing net/core/dev.c or
> net/core/netdev_rx_queue.c. But neither is great.
> 
> Maybe it is time to create a net/core/netdev_queues.c?

Sure, net/core/netdev_queues.c SGTM

