Return-Path: <netdev+bounces-165271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28FA3158F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E377A2F64
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914C26E62B;
	Tue, 11 Feb 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6hROUo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410C26E621
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303070; cv=none; b=HViXxByjUdK7BhgtN+BbEq8C+852BWvAZk28yq6hMyN3Y+3DKc3fm6nmz0oXUeVfu5DA9DvvTTK6i/y39zyXD4pOQhLptTPASwNxFHnVIyb418YdfkbSurYIVLxWpdW0g8dvR0NHB7xTE8k8SznAvXRuaSv2/GOWG1l+hvEArZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303070; c=relaxed/simple;
	bh=B5Bj9x6sFxtUYDmfCTGMugB62bYX/E0CWtdX74dh0CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbqyhUuO8nRLyQNDALSiJgQuTxOxtaHrffHMp7z6fgFWu1jpC41gtO4SzIIwOYJj7cKMRTSkXHtISs3+KHYRrlvOb64OwFPZ6e+f1qHcskGkIJdVqFnZmw37b1VukJJkAJglkRIUV9uIKd5SVV5lSsS87pH/An8fM01e8t+AJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6hROUo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D315C4CEE4;
	Tue, 11 Feb 2025 19:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739303070;
	bh=B5Bj9x6sFxtUYDmfCTGMugB62bYX/E0CWtdX74dh0CQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6hROUo7LOwkIBkEMRcEuf47Z61XIlDnIzavKnpnkrQF9jpnwKICi3D6+aSnYAn+q
	 i0/KAyewhR6AFXyu8KHvJoey7eFeDPcSHeEUL7NYqtPcRiPVC4SBmIVslW90NchDqZ
	 9YUDUhgwtdBGNd/pDkuMlqYSUzydRM8W43fqoOHB9FLAtKWxNNFNhVEM8W5ITYCDSq
	 CpfZ+zx7vmDce3FshuHSOqFpjcGcCeUhcp5kWvpnjl9++5jds5//SrCzuu3P2j53c9
	 jGKhELEcZxj4Je4DrLX1SeKx6FHIt242SzN+Odb64QYTFNtU8/b9kaG30tKNLxffh9
	 ZudPPzucXAROg==
Date: Tue, 11 Feb 2025 11:44:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
Message-ID: <20250211114428.6dc9c7e3@kernel.org>
In-Reply-To: <8eab9a5a-ce82-4291-8952-5e5c4610e0b0@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<20250205031213.358973-2-kuba@kernel.org>
	<8eab9a5a-ce82-4291-8952-5e5c4610e0b0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 21:18:46 +0200 Tariq Toukan wrote:
> > -	if (xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, queue_index, 0) < 0)
> > +	pp.flags = PP_FLAG_DMA_MAP;
> > +	pp.pool_size = MLX4_EN_MAX_RX_SIZE;
> > +	pp.nid = node;
> > +	pp.napi = &priv->rx_cq[queue_index]->napi;
> > +	pp.netdev = priv->dev;
> > +	pp.dev = &mdev->dev->persist->pdev->dev;
> > +	pp.dma_dir = DMA_BIDIRECTIONAL;  
> 
> I just noticed one more thing, here we better take the value from 
> priv->dma_dir, as it could be DMA_FROM_DEVICE or DMA_BIDIRECTIONAL 
> depending on XDP program presence.

ack!

