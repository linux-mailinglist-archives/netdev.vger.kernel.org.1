Return-Path: <netdev+bounces-234573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2AC237A6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 07:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 201254E11EF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD593016F6;
	Fri, 31 Oct 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EOozPxme"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE030100B
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893828; cv=none; b=TPR0lS8Ow5BdE6l2LUZJs3zSgh1qmxGd3pkcY/uHNoEubIW/lGRK3xzr4v2KAZLSHjxXixMyP8/OISakguLz/TjaOae53KHej0bQiN2IXDf54DXNPr0jmsJxzepNZPHTvkzixewgIekSHWv+JvsgtugBnTuGb6DhDNlwpEURuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893828; c=relaxed/simple;
	bh=cmKtJcr6TnTzrcOdxZCVtt3W6JnVisOE0WqG2Tp2xes=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+HIx8tk4iPEaMcjj6gzK1xqO+YuaiGcNt9BwW/Cj9Rp9/D8NzTqzhTcseYiolukURLQo9YoG1fkhXwOp9FlmEtnj+SW/liakm5eqsOYkHmytKzYjzBYolQqpRTsNm0VcdHqGQttTzypSwntzZjafkKnFWRrsyhZkAZbxYmmWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EOozPxme; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UMtf3n3479622;
	Thu, 30 Oct 2025 23:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YGyV1ZEWFJrg/1g8nSpn4HDsh
	7ZrvLEODqbLcpgceuY=; b=EOozPxme8G9yRodtJltHi2z5yx9Po1JmzpCdpzyzg
	7zivCWktWhhgZ+oxM1I9haB1zZ93VKP8GstQ6KQcgR43j6UlnwSe2ScROTuWVRqo
	gycvmhlTNLPtPkeBYZlx4Jiqv7JELMDqPej32018881i3/sQPpYl/8of0HrVQz5U
	Ec0PGsiYK8lBQW9kJJ8rTMc7yOBbvaNH5uMvoVwAR35aiW4pHJdBBIGmm+vxAnr/
	BP3wEClYEmFtSJuzYOk6dKJWQ3nEpVOg9WabuK/pPtDteoZqJ0N6zENAWKeTMEEf
	6Gn5ic5hmnsc0+QnGJNZHQjqwcjDSlIS2x7k4Eqcs+CnA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a4h84954p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 23:56:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 30 Oct 2025 23:56:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 30 Oct 2025 23:56:49 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id DE63D3F70BA;
	Thu, 30 Oct 2025 23:56:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:26:30 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
        <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
        <witu@nvidia.com>, <parav@nvidia.com>, <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
Message-ID: <aQRdnj99v64Ozvj/@test-OptiPlex-Tower-Plus-7010>
References: <e25c6c0c-1e2a-48c2-9606-5f51f36afbf0@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e25c6c0c-1e2a-48c2-9606-5f51f36afbf0@bytedance.com>
X-Authority-Analysis: v=2.4 cv=S/LUAYsP c=1 sm=1 tr=0 ts=69045da4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=M5GUcnROAAAA:8 a=T3QjdYLm3BN4P3liTpoA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2MiBTYWx0ZWRfX8yb8AC/t2ch+
 2nKSDWOr1/tGq5LeEa82dRSe0myDObjje/0XGBAqsgqoucFQETQMm2+xl7pgtSAmTIhm6NmuZPT
 x+01h8wfWMJASV2eHvY36uSaXiVJfK+hFfUeM4UL3vCvUHAjA9FDyNcIgqMXmTOoETRLXK+S3U9
 Q9q6OiCVFGIGFPJi0+eTwCSQBaWHUipr7VIWLFQtm0zPM5gugezkG6KJwDvIJg76CZXSebPpGNI
 dKAbzz4okwnUYlvBccIBRzc7Wgz95zhakYhxtf1pgWrO4ZKouOefi8u3zvnLK+XfV38XreBeyG7
 8QSpOKSzB6d1FPsiNChV0m50O8v6KJRuZF4ogbwURkpCrz+3YhRfBhwkx54iBH02ADR3kbuUmgv
 xrP1swv5UknVFSVr25y4AF8eXb242Q==
X-Proofpoint-ORIG-GUID: dQQnj1JZYmDXkoMq8oF28hlcaAJNtjYb
X-Proofpoint-GUID: dQQnj1JZYmDXkoMq8oF28hlcaAJNtjYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01

On 2025-10-31 at 06:12:50, Zijian Zhang (zijianzhang@bytedance.com) wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> When performing XDP_REDIRECT from one mlnx device to another, using
> smp_processor_id() to select the queue may go out-of-range.
> 
> Assume eth0 is redirecting a packet to eth1, eth1 is configured
> with only 8 channels, while eth0 has its RX queues pinned to
> higher-numbered CPUs (e.g. CPU 12). When a packet is received on
> such a CPU and redirected to eth1, the driver uses smp_processor_id()
> as the SQ index. Since the CPU ID is larger than the number of queues
> on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
> the redirect fails.
> 
> This patch fixes the issue by mapping the CPU ID to a valid channel
> index using modulo arithmetic:
> 
>     sq_num = smp_processor_id() % priv->channels.num;
> 
> With this change, XDP_REDIRECT works correctly even when the source
> device uses high CPU affinities and the target device has fewer TX
> queues.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5d51600935a6..61394257c65f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -855,11 +855,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n,
> struct xdp_frame **frames,
>  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>  		return -EINVAL;
> 
> -	sq_num = smp_processor_id();
> -
> -	if (unlikely(sq_num >= priv->channels.num))
> -		return -ENXIO;
> -
> +	sq_num = smp_processor_id() % priv->channels.num;
>  	sq = priv->channels.c[sq_num]->xdpsq;
> 
>  	for (i = 0; i < n; i++) {
 
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com> 

