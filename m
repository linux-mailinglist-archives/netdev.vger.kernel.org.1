Return-Path: <netdev+bounces-40399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE77C7386
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 18:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA521C20B85
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5A2AB57;
	Thu, 12 Oct 2023 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWlJSI0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D962AB53
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 16:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEB6C433C8;
	Thu, 12 Oct 2023 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697129716;
	bh=O8UY1DvSBTTGnjJ9XccnIy1wMqCD+BqiH+/36Y/1MZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWlJSI0PM5XU1MvuMXMhSDW/+KG+gbxWbms9N1wWVEH1VHrp+PFFEtMNA1F7TmINm
	 Vir1kvxAz3S+1cc+zoO7leMpyyRGnmRGzjtRhw9QTRvJ0KMNE9sN7RqKLK/wjOTbR0
	 ze0K4mY+siE80ZYGdCFyj5fcVc/tER/4FQYJnm/LG1IE2JmtmB+L+EDdD93plmDbOT
	 du6vLsLK2S6IIEku5xngpqCJKauULlg/U/LFlNjHCOu+HtyXVzlxkE8IsVY2wZMe+8
	 rDhYakUxcDXcf05AQGHpAX84l3Xa/U9F0OGH/13wuCux+RljgfU1sGrqIQXBBtZFdg
	 w+oZslObnrF3g==
Date: Thu, 12 Oct 2023 09:55:14 -0700
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
Message-ID: <ZSgk8huR9xCUHWBi@x130>
References: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
 <ZSbnUlJT1u3xUIqY@x130>
 <ZSbvxeLKS8zHltdg@x130>
 <5e7ec86d690ec5337052742ca75ad2ade23f291e.camel@linux.ibm.com>
 <ead14a91ffaec7b9e818edf735dbc18510d7915e.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ead14a91ffaec7b9e818edf735dbc18510d7915e.camel@linux.ibm.com>

On 12 Oct 13:39, Niklas Schnelle wrote:
>On Thu, 2023-10-12 at 12:53 +0200, Niklas Schnelle wrote:
>> On Wed, 2023-10-11 at 11:56 -0700, Saeed Mahameed wrote:
>> > On 11 Oct 11:20, Saeed Mahameed wrote:
>> > > On 11 Oct 09:57, Niklas Schnelle wrote:
>> > > > Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
>> > > > reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
>> > > > called in probe_one() before mlx5_pci_init(). This is a problem because
>> > > > mlx5_pci_init() is where the DMA and coherent mask is set but
>> > > > mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
>> > > > allocation is done during probe before the correct mask is set. This
>> > > > causes probe to fail initialization of the cmdif SW structs on s390x
>> > > > after that is converted to the common dma-iommu code. This is because on
>> > > > s390x DMA addresses below 4 GiB are reserved on current machines and
>> > > > unlike the old s390x specific DMA API implementation common code
>> > > > enforces DMA masks.
>> > > >
>> > > > Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
>> > > > probe_one() before mlx5_mdev_init(). To match the overall naming scheme
>> > > > rename it to mlx5_dma_init().
>> > >
>> > > How about we just call mlx5_pci_init() before mlx5_mdev_init(), instead of
>> > > breaking it apart ?
>> >
>> > I just posted this RFC patch [1]:
>>
>> This patch works to solve the problem as well.
>>
>> >
>> > I am working in very limited conditions these days, and I don't have strong
>> > opinion on which approach to take, Leon, Niklas, please advise.
>> >
>> > The three possible solutions:
>> >
>> > 1) mlx5_pci_init() before mlx5_mdev_init(), I don't think enabling pci
>> > before initializing cmd dma would be a problem.
>> >
>> > 2) This patch.
>> >
>> > 3) Shay's patch from the link below:
>> > [1] https://patchwork.kernel.org/project/netdevbpf/patch/20231011184511.19818-1-saeed@kernel.org/
>> >
>> > Thanks,
>> > Saeed.
>>
>> My first gut feeling was option 1) but I'm just as happy with 2) or 3).
>> For me option 2 is the least invasive but not by much.
>>
>> For me the important thing is what Jason also said yesterday. We need
>> to merge something now to unbreak linux-next on s390x and to make sure
>> we don't end up with a broken v6.7-rc1. This is already hampering our
>> CI tests with linux-next. So let's do whatever can be merged the
>> quickest and then feel free to do any refactoring ideas that this
>> discussion might have spawned on top of that. My guess for this
>> criteria would be 2).
>>
>> Thanks,
>> Niklas
>>
>
>Looking closer at the patch from Shay I do like that it changes the
>order in the disable/tear down path too. So since that also fixes a PPC
>issue I guess that may indeed be the best solution if we can get it
>merged quickly. I'll comment with my Tested-by there too.
>

Ack, will take Shay's patch then, Will add your Test-by and 
Reviewed-by.

>Thanks,
>Niklas

