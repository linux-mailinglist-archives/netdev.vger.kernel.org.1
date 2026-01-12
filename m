Return-Path: <netdev+bounces-248905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2FD10DE3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15101303F798
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B436330324;
	Mon, 12 Jan 2026 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O3goAySt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78E32E757;
	Mon, 12 Jan 2026 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202877; cv=none; b=FDmZA5BALniRy8zmKmon1HViS7naZf/6WST2JRwHQ4J53VxTJC1RyAZiwvotd7NRxdOqmwuXDko753M+lzyLT0B7QnhXwuU25FhlEoI1PtFzCRq2eu+3rTRdMzhTos/rHOnpBuzbqlrCWCKvkro4wJxRLgTlt8ArBM1WSyxFatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202877; c=relaxed/simple;
	bh=Bila9EuaXMoHNK6qCjh4nSG7lsqxC+46BQ+8RPCZs7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXIq28Z8ZcJ73hFYJnOF3GmetvY4Ss4kmzv6hBYKxGPnxGLhzSXXUneg3i8MHvnlVnUJ8NXJ4kb8YIuwHtWP0pKGS+zXcROtN8uJiKncMJzPaETheFdmxZcrwyH1HbwB77xfokCz5nQ3jgzVDVUlv7h3K0bfiBUtNU2ktMNS8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O3goAySt; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C1Omj13965543;
	Sun, 11 Jan 2026 23:27:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dQVolbGjgwu4T+eJ0792uEqBz
	ovywMuqxAgl0WS8YYs=; b=O3goAySt8MA+y062ufWBiTW4le+Hf+zMjJ4Ms5Gh+
	jpyJDqDQbhGrgx0fGHvqOfeaXCsM3JZ0uRryQXXdQNxWMPsvGr1Vh5f9r/glsYXd
	UjeNX19WtvrBYOoVLxDO5aHxR1kyj7/PxQmKCU4vzNjpu7HyF/cm5AeX28m7h+tC
	G9isgt9Yk+JMn9aqaMhw414e+xhCuW2PjGbZCfM2dK4WeQ/J7ko4z2lgh94kd/23
	XgzLLO48UVaLaMtJ5gSgO8fOlbC7T7lf+zf9ixJF5t6S0Etp2k8RL0sYfBG1V0tf
	bOqJG6i45VxpXKBlmc244rkCQiq+K7vuR9weMyWgQcmzA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bm8dbhre4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jan 2026 23:27:05 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 11 Jan 2026 23:27:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 11 Jan 2026 23:27:04 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 207CD3F70A3;
	Sun, 11 Jan 2026 23:26:58 -0800 (PST)
Date: Mon, 12 Jan 2026 12:56:58 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Breno Leitao <leitao@debian.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Cai Huoqing
	<cai.huoqing@linux.dev>,
        Christian Benvenuti <benve@cisco.com>,
        Satish Kharat
	<satishkh@cisco.com>,
        Dimitris Michailidis <dmichail@fungible.com>,
        "Manish
 Chopra" <manishc@marvell.com>,
        Jian Shen <shenjian15@huawei.com>,
        Salil Mehta
	<salil.mehta@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/8] net: octeontx2: convert to use
 .get_rx_ring_count
Message-ID: <aWSiQvjrnoERU+e5@test-OptiPlex-Tower-Plus-7010>
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
 <20260109-grxring_big_v1-v1-1-a0f77f732006@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260109-grxring_big_v1-v1-1-a0f77f732006@debian.org>
X-Proofpoint-ORIG-GUID: FUQZNnPFRAzlgylrK9KgzEOe5WcbiVto
X-Authority-Analysis: v=2.4 cv=DNKCIiNb c=1 sm=1 tr=0 ts=6964a249 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=M5GUcnROAAAA:8 a=qGjx7ovgRGVa4dltdMwA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: FUQZNnPFRAzlgylrK9KgzEOe5WcbiVto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1NiBTYWx0ZWRfX7lU1Zp7cSScW
 URCJe3if7csBiNTU8EFwhP5XEpNjRb8KODSzCMCy/dDceYrSEr7dVQw1BaAghLkzQ88MthQgM2H
 0I6vWDZJWzpJDqcSJsvOZGRjjJ+hYzwY6c4wuismGQhXyHAlH++sFgJkvPC7zFSpwk1/UdiUKsY
 3840nFaOYJCse19S086BDO+7sKrqCdc5054gWwOTToeXtMbbrFxx9xWpSisqjQ57Z+udSJoFZut
 Om6v+yFEhK7TdSwPCMNdN69U0qSPm2kh6JOqJuoI3/RfedGL55jrzfrCEy/PQnG75QXk3tk636b
 6wGb6U06ooNrAWKnofAZL1+oL6RGhtHqi8rAJb3tlS0Uo6QBVuYA4bkM/eOEsdMinchlo7hgHFq
 kteJ2OftOKewpxrhAKDSEDalTaaOmVAyVUoL58qyTpVW7G7EOOW3+t8YrW42jClmrdZeu8YlDa7
 MG4kP90pMHqfpQVJSmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01

On 2026-01-09 at 23:10:52, Breno Leitao (leitao@debian.org) wrote:
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>

   Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index b6449f0a9e7d..8918be3ce45e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -568,6 +568,13 @@ static int otx2_set_coalesce(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static u32 otx2_get_rx_ring_count(struct net_device *dev)
> +{
> +	struct otx2_nic *pfvf = netdev_priv(dev);
> +
> +	return pfvf->hw.rx_queues;
> +}
> +
>  static int otx2_get_rss_hash_opts(struct net_device *dev,
>  				  struct ethtool_rxfh_fields *nfc)
>  {
> @@ -742,10 +749,6 @@ static int otx2_get_rxnfc(struct net_device *dev,
>  	int ret = -EOPNOTSUPP;
>  
>  	switch (nfc->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		nfc->data = pfvf->hw.rx_queues;
> -		ret = 0;
> -		break;
>  	case ETHTOOL_GRXCLSRLCNT:
>  		if (netif_running(dev) && ntuple) {
>  			nfc->rule_cnt = pfvf->flow_cfg->nr_flows;
> @@ -1344,6 +1347,7 @@ static const struct ethtool_ops otx2_ethtool_ops = {
>  	.set_coalesce		= otx2_set_coalesce,
>  	.get_rxnfc		= otx2_get_rxnfc,
>  	.set_rxnfc              = otx2_set_rxnfc,
> +	.get_rx_ring_count	= otx2_get_rx_ring_count,
>  	.get_rxfh_key_size	= otx2_get_rxfh_key_size,
>  	.get_rxfh_indir_size	= otx2_get_rxfh_indir_size,
>  	.get_rxfh		= otx2_get_rxfh,
> @@ -1462,6 +1466,7 @@ static const struct ethtool_ops otx2vf_ethtool_ops = {
>  	.get_channels		= otx2_get_channels,
>  	.get_rxnfc		= otx2_get_rxnfc,
>  	.set_rxnfc              = otx2_set_rxnfc,
> +	.get_rx_ring_count	= otx2_get_rx_ring_count,
>  	.get_rxfh_key_size	= otx2_get_rxfh_key_size,
>  	.get_rxfh_indir_size	= otx2_get_rxfh_indir_size,
>  	.get_rxfh		= otx2_get_rxfh,
> 
> -- 
> 2.47.3
> 
> 

