Return-Path: <netdev+bounces-40115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC297C5D33
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1AB1C20D85
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984FD3A297;
	Wed, 11 Oct 2023 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig89jjbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B543A28E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D25EC433C8;
	Wed, 11 Oct 2023 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050566;
	bh=p5Aqye/cIt07/FsEkeTy4ySuRidXLXrlLwhsHjfE6s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ig89jjbS+S/Y6rn7rilEv05EonKQ7QJVCBTnsmEEOd7KF50WQrJX/EqqLg0EEFD33
	 Q1Vc/EkXLs8+j7JhixfAG9Id5XBPsvgxzxElbJbn43ToUMcibkSl1HlhwZb2N+hrwY
	 NNQZesN3ux5oYyQyIZ6pdd7kEbs4Eu0yNP0ZmQHwX9Q7KpWN37IyAMcqvEqc+NwE9Q
	 N7S7T30w1DDWI9TSFFSEO13RR5WHL5KhuZr2tFah2IZM8sssuNL1XbgEqMTQ6lpV7E
	 hcALxsrieoUdmLTjKbXeLxTO2HaDe58/NmhvWcSwNnSx7iLVL1wnJwadfUIQ5NRZu0
	 doYihVvW1stuQ==
Date: Wed, 11 Oct 2023 11:56:05 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <ZSbvxeLKS8zHltdg@x130>
References: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
 <ZSbnUlJT1u3xUIqY@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZSbnUlJT1u3xUIqY@x130>

On 11 Oct 11:20, Saeed Mahameed wrote:
>On 11 Oct 09:57, Niklas Schnelle wrote:
>>Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
>>reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
>>called in probe_one() before mlx5_pci_init(). This is a problem because
>>mlx5_pci_init() is where the DMA and coherent mask is set but
>>mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
>>allocation is done during probe before the correct mask is set. This
>>causes probe to fail initialization of the cmdif SW structs on s390x
>>after that is converted to the common dma-iommu code. This is because on
>>s390x DMA addresses below 4 GiB are reserved on current machines and
>>unlike the old s390x specific DMA API implementation common code
>>enforces DMA masks.
>>
>>Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
>>probe_one() before mlx5_mdev_init(). To match the overall naming scheme
>>rename it to mlx5_dma_init().
>
>How about we just call mlx5_pci_init() before mlx5_mdev_init(), instead of
>breaking it apart ?

I just posted this RFC patch [1]:

I am working in very limited conditions these days, and I don't have strong
opinion on which approach to take, Leon, Niklas, please advise.

The three possible solutions:

1) mlx5_pci_init() before mlx5_mdev_init(), I don't think enabling pci
before initializing cmd dma would be a problem.

2) This patch.

3) Shay's patch from the link below:
[1] https://patchwork.kernel.org/project/netdevbpf/patch/20231011184511.19818-1-saeed@kernel.org/

Thanks,
Saeed.

