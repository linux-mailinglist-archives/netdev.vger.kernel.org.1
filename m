Return-Path: <netdev+bounces-198435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF72ADC295
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C7F189635F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DD23A563;
	Tue, 17 Jun 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ynbzpb72"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2A199924
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143031; cv=none; b=bsTfSLj5wesfNbnLBwMnTaqDuhtzTQXX3znv7JKflqDaxXWR5U/AxLSbpGLUilxr4Ge8WkJ4OayKuAtIT3WgeqISaDE1OCOnDsCcC32mquqxrkfT4G6ViDJdw4w86AavGq+8LKIcoun3PHHHSWeab8fvkv1+498k0Qk1COI1Le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143031; c=relaxed/simple;
	bh=71D4YddiYCO3TFo0y1qqne8u2YwDNvItGiLR//slroU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjEBnyG8JNtzchHB+OjH9tmdd3K6I565vI/jXVTKiUMkFB7xsCm51QVU2/Gcau6Gzw3rFFIiLgVGrpRph0HoBJzS8U9cTd3mO91D+5m53lyCEAU2G/HSdNUQCg+RdJEOZP8h4ep/cEL0ZyaEiUnSFESbyRlwh+sQIvOxNgtb2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ynbzpb72; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H66fTF015226;
	Mon, 16 Jun 2025 23:50:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=OKWjSiBg+V0peigwC8kUh8MNP
	042Pz67Eh2HR/KKcCg=; b=Ynbzpb726JO+W6a1NazoduEiPKJyzCWvoChLoxpqn
	SgF/uYtV3XzrMHLO916EVy0kMOez1NCSIQNU3WhFWZFCT8vk15eAVlKn979SDeia
	LxNdcHCWUxXokH/8brLgxDMOP5UiZRoqBV8xkspzsWE8QxCKgHBF0QnmBBpdT1ny
	Erd7MYrNvBrcrmn3z5/w7sv/au1SygHRcq9RnTs2Ax+0DG+A40MRFvEYxMoZ9Bcf
	HMSj545i6FldRRjcgzRjfLX1zgiQhmTy+adnCOH8+X7Sh68M2PwrEikzrlG/FKYD
	rl/aqtcvBIxoiDYK1fYoSRbyRUHAz9geNfH+D7BgMtNcA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b2t8r2v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:50:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 23:50:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 23:50:18 -0700
Received: from 9fd6dd105bf2 (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 99469626768;
	Mon, 16 Jun 2025 23:50:12 -0700 (PDT)
Date: Tue, 17 Jun 2025 06:50:11 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <shayagr@amazon.com>, <akiyano@amazon.com>, <darinzon@amazon.com>,
        <skalluru@marvell.com>, <manishc@marvell.com>,
        <michael.chan@broadcom.com>, <pavan.chebbi@broadcom.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <bbhushan2@marvell.com>
Subject: Re: [PATCH net-next 3/5] eth: ena: migrate to new RXFH callbacks
Message-ID: <aFEQI00XSUK4OQ39@9fd6dd105bf2>
References: <20250617014555.434790-1-kuba@kernel.org>
 <20250617014555.434790-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250617014555.434790-4-kuba@kernel.org>
X-Proofpoint-GUID: Z9iRdwEpe-osFfqTXGjAY3GTtdNjhjTv
X-Authority-Analysis: v=2.4 cv=U9aSDfru c=1 sm=1 tr=0 ts=6851102b cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=swC05sAzBtFbNkWB2TsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Z9iRdwEpe-osFfqTXGjAY3GTtdNjhjTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1NSBTYWx0ZWRfXyWlwFak3GJNK YJtsrjb+pIIbka2lEGIHEkz70NrDy/96lnIw2/6V+MOwC7YW0zuBfzNRIuto5C0UYCFZsODHH5k VyguFoCmVJUVgdaHuBWxRuT9aPZneqfsvFxjOdJ4GBZjSKjnJJZofH/mc6QznLgMO53sOtWLqDe
 zow0wnZ3hx1J/jvsTjn5AxFdbzlmBnYdgAuvz5xu3y4lKHgsDD0F3toOVTvI1/kLuzWCwDcXTaY mSeoJTABOC1nAyZch8uzhNuhH2b81glzIf8nAY1ELFdyBykSDwOuTVtYnn+u9VAnMNbWdRZ/pSG kkpYjgq9EmuJwbP+FNeJmenYdMQxdOiEiODMJn0+oISGuSOafX0OIzYEIQEIEqQFKIun5Q6hvwL
 nNm56hYwDp3NCgGWfidBy3zfuIt1DN7o2+F2AfoOmXmFWY/HWGxU4xuUxBnic3y4NmiX0wbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01

On 2025-06-17 at 01:45:53, Jakub Kicinski (kuba@kernel.org) wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> The driver as no other RXNFC functionality so the SET callback can
typo as->has. Apart from this minor typo entire patchset lgtm.

Thanks,
Sundeep
> be now removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c | 39 ++++++-------------
>  1 file changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> index a3c934c3de71..07e8f6b1e8af 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> @@ -721,9 +721,11 @@ static u16 ena_flow_data_to_flow_hash(u32 hash_fields)
>  	return data;
>  }
>  
> -static int ena_get_rss_hash(struct ena_com_dev *ena_dev,
> -			    struct ethtool_rxnfc *cmd)
> +static int ena_get_rxfh_fields(struct net_device *netdev,
> +			       struct ethtool_rxfh_fields *cmd)
>  {
> +	struct ena_adapter *adapter = netdev_priv(netdev);
> +	struct ena_com_dev *ena_dev = adapter->ena_dev;
>  	enum ena_admin_flow_hash_proto proto;
>  	u16 hash_fields;
>  	int rc;
> @@ -772,9 +774,12 @@ static int ena_get_rss_hash(struct ena_com_dev *ena_dev,
>  	return 0;
>  }
>  
> -static int ena_set_rss_hash(struct ena_com_dev *ena_dev,
> -			    struct ethtool_rxnfc *cmd)
> +static int ena_set_rxfh_fields(struct net_device *netdev,
> +			       const struct ethtool_rxfh_fields *cmd,
> +			       struct netlink_ext_ack *extack)
>  {
> +	struct ena_adapter *adapter = netdev_priv(netdev);
> +	struct ena_com_dev *ena_dev = adapter->ena_dev;
>  	enum ena_admin_flow_hash_proto proto;
>  	u16 hash_fields;
>  
> @@ -816,26 +821,6 @@ static int ena_set_rss_hash(struct ena_com_dev *ena_dev,
>  	return ena_com_fill_hash_ctrl(ena_dev, proto, hash_fields);
>  }
>  
> -static int ena_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info)
> -{
> -	struct ena_adapter *adapter = netdev_priv(netdev);
> -	int rc = 0;
> -
> -	switch (info->cmd) {
> -	case ETHTOOL_SRXFH:
> -		rc = ena_set_rss_hash(adapter->ena_dev, info);
> -		break;
> -	case ETHTOOL_SRXCLSRLDEL:
> -	case ETHTOOL_SRXCLSRLINS:
> -	default:
> -		netif_err(adapter, drv, netdev,
> -			  "Command parameter %d is not supported\n", info->cmd);
> -		rc = -EOPNOTSUPP;
> -	}
> -
> -	return rc;
> -}
> -
>  static int ena_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
>  			 u32 *rules)
>  {
> @@ -847,9 +832,6 @@ static int ena_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
>  		info->data = adapter->num_io_queues;
>  		rc = 0;
>  		break;
> -	case ETHTOOL_GRXFH:
> -		rc = ena_get_rss_hash(adapter->ena_dev, info);
> -		break;
>  	case ETHTOOL_GRXCLSRLCNT:
>  	case ETHTOOL_GRXCLSRULE:
>  	case ETHTOOL_GRXCLSRLALL:
> @@ -1098,11 +1080,12 @@ static const struct ethtool_ops ena_ethtool_ops = {
>  	.get_strings		= ena_get_ethtool_strings,
>  	.get_ethtool_stats      = ena_get_ethtool_stats,
>  	.get_rxnfc		= ena_get_rxnfc,
> -	.set_rxnfc		= ena_set_rxnfc,
>  	.get_rxfh_indir_size    = ena_get_rxfh_indir_size,
>  	.get_rxfh_key_size	= ena_get_rxfh_key_size,
>  	.get_rxfh		= ena_get_rxfh,
>  	.set_rxfh		= ena_set_rxfh,
> +	.get_rxfh_fields	= ena_get_rxfh_fields,
> +	.set_rxfh_fields	= ena_set_rxfh_fields,
>  	.get_channels		= ena_get_channels,
>  	.set_channels		= ena_set_channels,
>  	.get_tunable		= ena_get_tunable,
> -- 
> 2.49.0
> 

