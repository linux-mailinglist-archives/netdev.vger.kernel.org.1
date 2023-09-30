Return-Path: <netdev+bounces-37151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1E7B3ED4
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 868D0281FAB
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094AE17EC;
	Sat, 30 Sep 2023 07:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CE17E9
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0279AC433C7;
	Sat, 30 Sep 2023 07:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696059397;
	bh=u+Q2YBbAuaGWTrcSYtmRkLm1uMagIDTTzw8E5LMr6DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/eB9Ij7lq/cTWTCAvkOVWa0S/19CAD++XnB9YNCmV0jmYiYJB9y+IweeBFa8hOs5
	 cniVGLlJnSeTSM82T8xaLthgsjQNikQAkcfKT74c+ut06MZ03ZT9O6Ic11BchgzoQv
	 A28kLMY7Oc6yhkL/RMA9NLG99+/+55fVouNtP2v6RwKTRVdXGFd3JIrv1iFmA5jx/M
	 2l6Pk8pEo0bcDVn4NkTMX9s2qWYRzcuRN+CSCLfhHqjOeFydIvXRmGSma0+kjbfcCb
	 H8/QcRJnz2m+5pQkCwaEond8SLbLL/QLVItHFNxwq15peUwzwNMICuenN2taFpjWrb
	 cw32fmVbfos7Q==
Date: Sat, 30 Sep 2023 10:36:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <20230930073633.GC1296942@unreal>
References: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-mlx5_init_fix-v2-1-51ed2094c9d8@linux.ibm.com>

On Fri, Sep 29, 2023 at 02:15:49PM +0200, Niklas Schnelle wrote:
> Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
> reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
> called in probe_one() before mlx5_pci_init(). This is a problem because
> mlx5_pci_init() is where the DMA and coherent mask is set but
> mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
> allocation is done during probe before the correct mask is set. This
> causes probe to fail initialization of the cmdif SW structs on s390x
> after that is converted to the common dma-iommu code. This is because on
> s390x DMA addresses below 4 GiB are reserved on current machines and
> unlike the old s390x specific DMA API implementation common code
> enforces DMA masks.
> 
> Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
> probe_one() before mlx5_mdev_init(). To match the overall naming scheme
> rename it to mlx5_dma_init().
> 
> Link: https://lore.kernel.org/linux-iommu/cfc9e9128ed5571d2e36421e347301057662a09e.camel@linux.ibm.com/
> Fixes: 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload routines")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: I ran into this while testing the linked series for converting
> s390x to use dma-iommu. The existing s390x specific DMA API
> implementation doesn't respect DMA masks and is thus not affected
> despite of course also only supporting DMA addresses above 4 GiB.
> ---
> Changes in v2:
> - Instead of moving the whole mlx5_pci_init() only move the
>   set_dma_caps() call so as to keep pci_enable_device() after the FW
>   command interface initialization (Leon)
> - Link to v1: https://lore.kernel.org/r/20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

