Return-Path: <netdev+bounces-206174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046FB01E58
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799D95A5F82
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835E2DCBF7;
	Fri, 11 Jul 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYERQJLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F72D97A2;
	Fri, 11 Jul 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241918; cv=none; b=cr1Z5jRaKXwJmNo0pGxZ1i+6TH20ukTSxSC+jeEBbrJJp5XU4jUXnR5ZxjpZJxyfPeKtqUlzwSY8vzBr7rWD4YOf/F7b66IsgoO9WdgBQpn4C5zHxcwwA9B5dMqYybaElUUsTfqkugKod/yOlyPXblY5YB0Hot4U82Sp7DxCpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241918; c=relaxed/simple;
	bh=gRYeWY8Ue9r1jN9YT5ewnploOKjK9ri5RO9mKqQvmVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y02/07Lj4QV7jO33fb/Vq0eU0JwaMvRIg2Til+k7jVdPxc9PJ4L5jIt1klN6hj7Z+bzJOoE5+KZN4oAm7sUEn7w/QBFfC1+ML5veyiRekxI4t3iTmi13jRzqAE49nzngV/0iASUGZlqeHnO4YP1h9BhN+vydWzR/sn+igFmZ+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYERQJLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1684FC4CEF9;
	Fri, 11 Jul 2025 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241917;
	bh=gRYeWY8Ue9r1jN9YT5ewnploOKjK9ri5RO9mKqQvmVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UYERQJLkSJKOTk5V7QJ/3A+QDttYxwbWTbb/D3nGl4j2G2ydS2cqmdvjcE/XOqJk5
	 TCsCTR7TwYbP06k7ifflZTo0EJWFRRPJOz2x1lD0xunGK/Y3jYO4EOx9YNOHDFiXIT
	 K750YtN2FULM+apYWbs1duI6j9XlpKJyRv5MCqiFepksD5N7QGu8sUiHm4LniI5Jp9
	 yapUlRKZtIRQtAE7zd7p3QkHxlB+9o9O72wLv+bVwbmc/5a4OOrRvlLki7E2P15PM3
	 gLFU7vloO0Ma+2qWXzh0Ly/cf5jEesDHJOieuLGUyGIGRz3rjhyKOkb796T3tG29Lu
	 JDYPgjHaY1g0Q==
Date: Fri, 11 Jul 2025 06:51:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "almasrymina@google.com"
 <almasrymina@google.com>, "asml.silence@gmail.com"
 <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <20250711065156.0d51199e@kernel.org>
In-Reply-To: <CY8PR12MB71956FF1D74C1EAE3401891CDC4BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
	<20250702172433.1738947-2-dtatulea@nvidia.com>
	<20250702113208.5adafe79@kernel.org>
	<c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
	<20250702135329.76dbd878@kernel.org>
	<CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250710165851.7c86ba84@kernel.org>
	<CY8PR12MB71956FF1D74C1EAE3401891CDC4BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 02:52:23 +0000 Parav Pandit wrote:
> > On Thu, 3 Jul 2025 11:58:50 +0000 Parav Pandit wrote:  
> > > > In my head subfunctions are a way of configuring a PCIe PASID ergo
> > > > they _only_ make sense in context of DMA.  
> > > SF DMA is on the parent PCI device.
> > >
> > > SIOV_R2 will have its own PCI RID which is ratified or getting ratified.
> > > When its done, SF (as SIOV_R2 device) instantiation can be extended
> > > with its own PCI RID. At that point they can be mapped to a VM.  
> > 
> > AFAIU every PCIe transaction for a queue with a PASID assigned should have a
> > PASID prefix. Why is a different RID necessary?
> > CPUs can't select IOMMU context based on RID+PASID?  
> It can, however,
> PASID is meant to be used for process isolation and not expected to
> be abused for identify the device. Doing so, would also prohibits
> using PASID inside the VM. It requires another complex vPASID to
> pPASID translation.
> 
> Tagging MSI-X interrupts with PASID is another challenge.
> For CC defining isolation boundary with RID+PASID was yet another
> hack.
> 
> There were other issues in splitting PASID for device scaling vs
> process scaling for dual use.
> 
> So it was concluded to opt to avoid that abuse and use the standard
> RID construct for device identification.

I see, that explains it. Thanks Parav!

