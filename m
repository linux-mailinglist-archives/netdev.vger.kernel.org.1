Return-Path: <netdev+bounces-104744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBCB90E3AA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952DF1C22280
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C56F2FB;
	Wed, 19 Jun 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YmmKJhhy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA750280;
	Wed, 19 Jun 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779512; cv=none; b=EzsHEf+P9LtQa5Shi4dH2n39MUZCnyRIq4LGsZn0pLcQG1f9stwxwszOHsyssB0Q4S2Dj+qLrCsl0zPKobI26x/j9cPTUKVsTK5rlt5qxUaHM3Y3Eqo3PJv19oDP2Ma16oHAJNL9aaNX//aNsrMdYVZ+NOwO4lzQcF4ABfbHlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779512; c=relaxed/simple;
	bh=P/NG24g5CSvJ6QZhArAef5FhFBYfQFIbCbKT0+9eQ4Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UowsUrizGFnC4ZhdpOgZ75LdzDsIP11F+HaSVbiTvki2WFYOb4liPMiGg08ku87Ytqggpiza/pVUaKv7fqq3e39S+0yrNEI64kpmpz91rcIdnmSEAUFLHXj1y+2xpi+mggebI0rhX8YMg6Q17mMsFFrgHaXVqhMSsPk/914O9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YmmKJhhy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILbj6E025049;
	Tue, 18 Jun 2024 23:44:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	zNPxCMXvXFQ/XPnxovAj2nPmInvtEMcPu2BzcZ+63Y=; b=YmmKJhhyy/3JpcuYB
	N5ytcahIWKuYr/mwlNKcVB9oRpLIfMjZ2rEaZDhloUe9pLmeSbUIoRNSfc1zDhr6
	rKhPaRNFOEaXP9eIrY4x8mK6P5vL4QpMzzDasYKbSuTyRm29z/WtSxw/kVXW6Ufi
	WjItoYNH48GZgc5LulIrRu6KNmib1MkZUBAPp0+LyjcgyEeauqTqcC/hKgXaLhsJ
	MkvGjFttm1YzVVG2XVkJpBvdFlsQW3qGVMvU1yTxA2rvsa2Nk70kVSxvokKJTmZd
	Xk8MS9jy1OYpKF2GrynXRTNH+w0bGbFcXDEJoP0WRjJqbtUxAIPmbtspdOZ9fq2b
	AJ7AQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yujap9dyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 23:44:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Jun 2024 23:44:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 23:44:42 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 208FB3F706F;
	Tue, 18 Jun 2024 23:44:37 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:14:36 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
CC: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <20240619064436.GA1191293@maili.marvell.com>
References: <20240617113841.3694934-1-kamilh@axis.com>
 <20240617113841.3694934-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617113841.3694934-5-kamilh@axis.com>
X-Proofpoint-GUID: TB8XUTCyNFihKLoM0VgCZ_pfK25VIJm4
X-Proofpoint-ORIG-GUID: TB8XUTCyNFihKLoM0VgCZ_pfK25VIJm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01

On 2024-06-17 at 17:08:41, Kamil Horák - 2N (kamilh@axis.com) wrote:
> +
> +	if (brr_mode) {
> +		linkmode_set_bit_array(phy_basic_ports_array,
> +				       ARRAY_SIZE(phy_basic_ports_array),
> +				       phydev->supported);
> +
> +		val = phy_read(phydev, MII_BCM54XX_LRESR);
> +		if (val < 0)
> +			return val;
> +
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +				 phydev->supported, 1);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +				 phydev->supported,
> +				 val & LRESR_100_1PAIR);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
> +				 phydev->supported,
> +				 val & LRESR_10_1PAIR);
> +	} else {
> +		return genphy_read_abilities(phydev);
> +	}
> +
> +	return 0;
nit: Could you move this return to "if" statement and get rid of else part ?

> +static int bcm5481_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +	u8 brr_mode;
nit: Reverse xmas-tree.

> +static int bcm54811_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +	u8 brr_mode;
nit: Please apply reverse xmas-tree comment everywhere applicable.

