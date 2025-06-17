Return-Path: <netdev+bounces-198432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0EADC286
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D843B63F2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A528C013;
	Tue, 17 Jun 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CEP0Wv4C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522118DB35
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142663; cv=none; b=AeKAA6HVPlUsN42Qig7a08BsJ8bSCqPhU0c46l46mVH20nagHXD4jetCZpn6kAkUYhMBSlrz4w77tIt5mFHbawUOEWe9KMyhcVhpzRtKBL9qflqpz7PnL/GGBzWFsJ4g6IYhO2fun7dYFa++HJ7iAPt45ppP0fUz6wRAO0oZVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142663; c=relaxed/simple;
	bh=s6HAUhzdcjBTH5N6HL5nzo0+yWQLeAKY/JsmYxqSn1U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHOZfpy5ThcpSzUrn7c9K+AiEwIsYfQ+ITOXb0of+ubh6VNcivsn1tkSinZNd7xg7sgITcvIs215Y+s283OHRCkBfxO26sy2DQ45oDVndRof3bV/1Hy/VEz38aq850VZHuR+TQsmJ8uEkblW5/cTmpulLcnOeCZ0prsCkweEu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CEP0Wv4C; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H66fSr015226;
	Mon, 16 Jun 2025 23:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=pj+w+/23u8q+7wAymaqpDD//B
	vpzQwWEJT5hBFRB3lc=; b=CEP0Wv4CTIirnTr/Nnyhl9w6UeXn7hbdTRQUT35Ti
	KgYsGmgmE6jBamZyohWffsZ82KK6beuQb/5mFteIOBrs+UMseg5ErkX33mK6CKyR
	qseTUNMoyrhf6H8CX/lz62dgFJcGGvLbi8RIqvyiKYldqnzLrxhwjyLRRenLo1ki
	FpP6rd/7Rk/Mbyx0TwUmSiCPGaQHspc3uIC5D29dAJ6A8Nsqar3VcO0JcsMu3IEo
	FiruGy4i6XCo5vZft8IU3jgpNtZ9qfsAEcXS7pKDdJw5GBmANntiTfcWWENxuwTQ
	+rzFrvkVw2cubtCtHsKTYBQhG1SnhtO8Xb43KxovrzaGQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b2t8r2hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:44:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 23:44:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 23:44:06 -0700
Received: from 9fd6dd105bf2 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 83B1C62676C;
	Mon, 16 Jun 2025 23:44:00 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:43:59 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <shayagr@amazon.com>, <akiyano@amazon.com>, <darinzon@amazon.com>,
        <skalluru@marvell.com>, <manishc@marvell.com>,
        <michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <bbhushan2@marvell.com>
Subject: Re: [PATCH net-next 4/5] eth: thunder: migrate to new RXFH callbacks
Message-ID: <aFEOr8LLQfXb2IRU@9fd6dd105bf2>
References: <20250617014555.434790-1-kuba@kernel.org>
 <20250617014555.434790-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617014555.434790-5-kuba@kernel.org>
X-Proofpoint-GUID: d-1tVkEtNTu8YSSJ-lT3E_atdeWvKLf5
X-Authority-Analysis: v=2.4 cv=U9aSDfru c=1 sm=1 tr=0 ts=68510eb7 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=6XRS-J3MCNQQ1mQmCCoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: d-1tVkEtNTu8YSSJ-lT3E_atdeWvKLf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1MyBTYWx0ZWRfXyOk2Cc7Y1Ool 7eERQFRnSDUti7CX4g7ux3mrd848qzx8cH+dUoRe9R6rh0K94krTkfQvE8lyXxLbjLJS2mP5Bf7 /ARTVdIPFEloKvAb29NQ/rv6pbrIVaf/AaBSJJbH6jOa+tPPigMzjbqfKGPGtYFc9xARnExYKeC
 yX5BzApt90EW1k8RBNCLWYwomoU3CchBrejnia69CqO+hlkT7xZWKur0j9To9IcnTBAtmrgsZGR vuWGKJV+q7ouVZRtcpnp0gm7LcXYEvjqTM9q0ZaxRwSuFDYA86pL6Ml2RY8mf9K5VzHv/T8kJpy 2SpfQCiKX0JvygcLrlm/QmY/2J3LY9j1y3qA53ZmJhHS7Thnb+Jt/DTeAhBUTC5LSS1ljnssKvs
 V4trjfRJ1+a0KdQbOODwskS8uQcoiSe/Y9frHbTVWnbQOw5+0srtQrV8ymZO2aYxE4wX7Yee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01

On 2025-06-17 at 01:45:54, Jakub Kicinski (kuba@kernel.org) wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> The driver as no other RXNFC functionality so the SET callback can
Same as patch 1, as->has

Thanks,
Sundeep

> be now removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/cavium/thunder/nicvf_ethtool.c   | 37 +++++++------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
> index d0ff0c170b1a..fc6053414b7d 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
> @@ -516,8 +516,8 @@ static int nicvf_set_ringparam(struct net_device *netdev,
>  	return 0;
>  }
>  
> -static int nicvf_get_rss_hash_opts(struct nicvf *nic,
> -				   struct ethtool_rxnfc *info)
> +static int nicvf_get_rxfh_fields(struct net_device *dev,
> +				 struct ethtool_rxfh_fields *info)
>  {
>  	info->data = 0;
>  
> @@ -552,25 +552,28 @@ static int nicvf_get_rxnfc(struct net_device *dev,
>  		info->data = nic->rx_queues;
>  		ret = 0;
>  		break;
> -	case ETHTOOL_GRXFH:
> -		return nicvf_get_rss_hash_opts(nic, info);
>  	default:
>  		break;
>  	}
>  	return ret;
>  }
>  
> -static int nicvf_set_rss_hash_opts(struct nicvf *nic,
> -				   struct ethtool_rxnfc *info)
> +static int nicvf_set_rxfh_fields(struct net_device *dev,
> +				 const struct ethtool_rxfh_fields *info,
> +				 struct netlink_ext_ack *extack)
>  {
> -	struct nicvf_rss_info *rss = &nic->rss_info;
> -	u64 rss_cfg = nicvf_reg_read(nic, NIC_VNIC_RSS_CFG);
> +	struct nicvf *nic = netdev_priv(dev);
> +	struct nicvf_rss_info *rss;
> +	u64 rss_cfg;
> +
> +	rss = &nic->rss_info;
> +	rss_cfg = nicvf_reg_read(nic, NIC_VNIC_RSS_CFG);
>  
>  	if (!rss->enable)
>  		netdev_err(nic->netdev,
>  			   "RSS is disabled, hash cannot be set\n");
>  
> -	netdev_info(nic->netdev, "Set RSS flow type = %d, data = %lld\n",
> +	netdev_info(nic->netdev, "Set RSS flow type = %d, data = %u\n",
>  		    info->flow_type, info->data);
>  
>  	if (!(info->data & RXH_IP_SRC) || !(info->data & RXH_IP_DST))
> @@ -628,19 +631,6 @@ static int nicvf_set_rss_hash_opts(struct nicvf *nic,
>  	return 0;
>  }
>  
> -static int nicvf_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> -{
> -	struct nicvf *nic = netdev_priv(dev);
> -
> -	switch (info->cmd) {
> -	case ETHTOOL_SRXFH:
> -		return nicvf_set_rss_hash_opts(nic, info);
> -	default:
> -		break;
> -	}
> -	return -EOPNOTSUPP;
> -}
> -
>  static u32 nicvf_get_rxfh_key_size(struct net_device *netdev)
>  {
>  	return RSS_HASH_KEY_SIZE * sizeof(u64);
> @@ -872,11 +862,12 @@ static const struct ethtool_ops nicvf_ethtool_ops = {
>  	.get_ringparam		= nicvf_get_ringparam,
>  	.set_ringparam		= nicvf_set_ringparam,
>  	.get_rxnfc		= nicvf_get_rxnfc,
> -	.set_rxnfc		= nicvf_set_rxnfc,
>  	.get_rxfh_key_size	= nicvf_get_rxfh_key_size,
>  	.get_rxfh_indir_size	= nicvf_get_rxfh_indir_size,
>  	.get_rxfh		= nicvf_get_rxfh,
>  	.set_rxfh		= nicvf_set_rxfh,
> +	.get_rxfh_fields	= nicvf_get_rxfh_fields,
> +	.set_rxfh_fields	= nicvf_set_rxfh_fields,
>  	.get_channels		= nicvf_get_channels,
>  	.set_channels		= nicvf_set_channels,
>  	.get_pauseparam         = nicvf_get_pauseparam,
> -- 
> 2.49.0
> 

