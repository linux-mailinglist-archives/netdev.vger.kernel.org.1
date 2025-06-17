Return-Path: <netdev+bounces-198431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9EADC280
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEFDD7A7DC7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E028BA9D;
	Tue, 17 Jun 2025 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LnukJ7iU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650A5202C48
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142437; cv=none; b=kLHq++9Yg1yIdNL+lNtxNAx4B6Rlu2YwhZQyEwEbXKaLTLDYS23D7qPAGFJkGfOQ/GZ+9eRec5LR/VM+I7Wo7jwMvMTtPiodwIV0eH9FiL0fzSeBXPwyfeOfBE6nVay7+8zyjOlvLtB1K1Gn0c5AietA0zn9+m94MxjpadY/Exg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142437; c=relaxed/simple;
	bh=QEMsf/9LBqQ+iiofDP7BIu16RiNHiYTMWjJNcEdM97w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjPShv9INFuyrnrWJeMc5KtS68zO65h3YHydrywHUEGUg95NfxxPBOzgR7MGUH5d1abJode/UxMsuSxpRUbz5tfCEXgClTBV/zBra4PkLyZGiyom21GRXGyF88z5alMWr1FceFGoy2fF3AoTIJF22tg2InNFlFd8PMBZB7qFHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LnukJ7iU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H0KrEt010332;
	Mon, 16 Jun 2025 23:40:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=lgogii8q0dWXttmAfQ1TSlxC3
	0qkPWd5pLqE5W/WeU4=; b=LnukJ7iUL50r+UeR/bso+ShdZ+gt4gI/CXU6FhQ/Y
	yciXzXRVdJgX5EMvRCxHcKLtiXrN8HJvNBZnoz6R8R8uwm6fT0zVPgenOwjb+1Qk
	tlMgAWLanNwsYtVxkzSycasTMgp7ajd7sUG67vyRCwa5sBTcXRKmlBjdrhcNDgP8
	9ndnfZPHpcXzsCLEn3yaHlEgC6HO4yEAtZZ/oMvVBbrlrZpqSVw4iEf1kRQGcJLS
	RnhDPRLMvdgqyOiZrAHjJl2AU1VRztdqTuawgihRSNLYIBshhwRpARTDawAGNSpp
	MsYiDtjXjOcWsKBFEOZAaBerq1MV/uXq5Gg8XnsC+TCvQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47aw1krpcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:40:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 23:40:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 23:40:11 -0700
Received: from 9fd6dd105bf2 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id BA24E626768;
	Mon, 16 Jun 2025 23:40:05 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:40:03 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <shayagr@amazon.com>, <akiyano@amazon.com>, <darinzon@amazon.com>,
        <skalluru@marvell.com>, <manishc@marvell.com>,
        <michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <bbhushan2@marvell.com>
Subject: Re: [PATCH net-next 1/5] eth: bnx2x: migrate to new RXFH callbacks
Message-ID: <aFENwzdHRYbjW2WX@9fd6dd105bf2>
References: <20250617014555.434790-1-kuba@kernel.org>
 <20250617014555.434790-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617014555.434790-2-kuba@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1MyBTYWx0ZWRfX68XBE26nr1/M EF/eCn0QcgHiUvsYYDLz5lwxy38Rf7LLoer6WU7JPaVXGSaHV56/0uLZPHQ/+w9EKkq4rJOuZkP 4o9CT935sYdmnJav6YpDkNRHCRGOaOIx5GXOo/JQ0t4aD6c8VVcHKpCgBB6cOQuzupPaenCkDb6
 WnMt0FiMG7xuikhqqFFpnBH8G5gfRCiFQ/9Azg16m5xAy+whvIEPem8oo0taowXTLetHqOvV5jT hp75v4pSPQF7TvHrAqBKxs/4YtQlk7CBpCtTDg/ah8ZcI7J/LjfaM+0g2qwo0dvJQgDO5apgHVP tL7e/ciYFXw4LlBzpcoMl6/+7txjOwHp7Gd4RCu0F7jotRUZs5yJqnSVts2vRnYrZVmB4B4Zo1q
 PsulsYr28CaKDfqdndjbrMiy1YSvJcXKSPiInm/y4qjfDSoOnkvHa2lghV6xf5ILA7NnUfjJ
X-Proofpoint-GUID: pb8fikhCTGnaxyDppMfT6LpK4-4xgAKF
X-Proofpoint-ORIG-GUID: pb8fikhCTGnaxyDppMfT6LpK4-4xgAKF
X-Authority-Analysis: v=2.4 cv=VM7dn8PX c=1 sm=1 tr=0 ts=68510dcc cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=wm-N1OSg0VNqT-sHiGoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01

On 2025-06-17 at 01:45:51, Jakub Kicinski (kuba@kernel.org) wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> The driver as no other RXNFC functionality so the SET callback can
typo as -> has

Thanks,
Sundeep

> be now removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 33 ++++++++-----------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> index 44199855ebfb..528ce9ca4f54 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
> @@ -3318,8 +3318,11 @@ static int bnx2x_set_phys_id(struct net_device *dev,
>  	return 0;
>  }
>  
> -static int bnx2x_get_rss_flags(struct bnx2x *bp, struct ethtool_rxnfc *info)
> +static int bnx2x_get_rxfh_fields(struct net_device *dev,
> +				 struct ethtool_rxfh_fields *info)
>  {
> +	struct bnx2x *bp = netdev_priv(dev);
> +
>  	switch (info->flow_type) {
>  	case TCP_V4_FLOW:
>  	case TCP_V6_FLOW:
> @@ -3361,20 +3364,21 @@ static int bnx2x_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
>  	case ETHTOOL_GRXRINGS:
>  		info->data = BNX2X_NUM_ETH_QUEUES(bp);
>  		return 0;
> -	case ETHTOOL_GRXFH:
> -		return bnx2x_get_rss_flags(bp, info);
>  	default:
>  		DP(BNX2X_MSG_ETHTOOL, "Command parameters not supported\n");
>  		return -EOPNOTSUPP;
>  	}
>  }
>  
> -static int bnx2x_set_rss_flags(struct bnx2x *bp, struct ethtool_rxnfc *info)
> +static int bnx2x_set_rxfh_fields(struct net_device *dev,
> +				 const struct ethtool_rxfh_fields *info,
> +				 struct netlink_ext_ack *extack)
>  {
> +	struct bnx2x *bp = netdev_priv(dev);
>  	int udp_rss_requested;
>  
>  	DP(BNX2X_MSG_ETHTOOL,
> -	   "Set rss flags command parameters: flow type = %d, data = %llu\n",
> +	   "Set rss flags command parameters: flow type = %d, data = %u\n",
>  	   info->flow_type, info->data);
>  
>  	switch (info->flow_type) {
> @@ -3460,19 +3464,6 @@ static int bnx2x_set_rss_flags(struct bnx2x *bp, struct ethtool_rxnfc *info)
>  	}
>  }
>  
> -static int bnx2x_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> -{
> -	struct bnx2x *bp = netdev_priv(dev);
> -
> -	switch (info->cmd) {
> -	case ETHTOOL_SRXFH:
> -		return bnx2x_set_rss_flags(bp, info);
> -	default:
> -		DP(BNX2X_MSG_ETHTOOL, "Command parameters not supported\n");
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
>  static u32 bnx2x_get_rxfh_indir_size(struct net_device *dev)
>  {
>  	return T_ETH_INDIRECTION_TABLE_SIZE;
> @@ -3684,10 +3675,11 @@ static const struct ethtool_ops bnx2x_ethtool_ops = {
>  	.set_phys_id		= bnx2x_set_phys_id,
>  	.get_ethtool_stats	= bnx2x_get_ethtool_stats,
>  	.get_rxnfc		= bnx2x_get_rxnfc,
> -	.set_rxnfc		= bnx2x_set_rxnfc,
>  	.get_rxfh_indir_size	= bnx2x_get_rxfh_indir_size,
>  	.get_rxfh		= bnx2x_get_rxfh,
>  	.set_rxfh		= bnx2x_set_rxfh,
> +	.get_rxfh_fields	= bnx2x_get_rxfh_fields,
> +	.set_rxfh_fields	= bnx2x_set_rxfh_fields,
>  	.get_channels		= bnx2x_get_channels,
>  	.set_channels		= bnx2x_set_channels,
>  	.get_module_info	= bnx2x_get_module_info,
> @@ -3711,10 +3703,11 @@ static const struct ethtool_ops bnx2x_vf_ethtool_ops = {
>  	.get_strings		= bnx2x_get_strings,
>  	.get_ethtool_stats	= bnx2x_get_ethtool_stats,
>  	.get_rxnfc		= bnx2x_get_rxnfc,
> -	.set_rxnfc		= bnx2x_set_rxnfc,
>  	.get_rxfh_indir_size	= bnx2x_get_rxfh_indir_size,
>  	.get_rxfh		= bnx2x_get_rxfh,
>  	.set_rxfh		= bnx2x_set_rxfh,
> +	.get_rxfh_fields	= bnx2x_get_rxfh_fields,
> +	.set_rxfh_fields	= bnx2x_set_rxfh_fields,
>  	.get_channels		= bnx2x_get_channels,
>  	.set_channels		= bnx2x_set_channels,
>  	.get_link_ksettings	= bnx2x_get_vf_link_ksettings,
> -- 
> 2.49.0
> 

