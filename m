Return-Path: <netdev+bounces-128866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8197C1E3
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA14B21A07
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F01CB331;
	Wed, 18 Sep 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j01zjPxF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF939178CF6;
	Wed, 18 Sep 2024 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726698277; cv=none; b=sguTurXaCtpVZ3mF4nolFrHEWX8cUIglTK8tyOtF8zbda5qSeNULjOddpaiiOT9WoW86+S+m8UFKYtwSQZFyw7XomGiztD4i9iG0EP8BekC1JkWN45Z70mP9Io4rke6a0tnz07dMbYX66M9jUfHnSsllAkKcOIl6ROPao3mnE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726698277; c=relaxed/simple;
	bh=UkbYhEXHxm4dmtDZj6n0+zM3/1JtpT4UoTfmtsLqVQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I1TNssM9qsLO0S+ISZUVXXupsMORlQ5TjrCW4GJtVrYC9C+bPjPorU3XfCkusr24DOa6Lncxea7jC+0LwJGnEXACD+e58DRmBZLMpeSlTabVdKojuvX5ncI10SGjETsGr7AJuswrS/9KhEC76YfhnEU5tTukmXqYApwYIrBBY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j01zjPxF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IA8f9W010095;
	Wed, 18 Sep 2024 22:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yMdmzNEgXNc3SOK6yWjXAfP6dRxeU2NsOaQkS8cXojQ=; b=j01zjPxFA+7ZuccD
	fbs+V3T0F/BWNlhm19zE/G5ifK1gJh49YXYaRS8Fj/0fcqFVsEvHJik398bjBwPd
	Xmgdmg4lXnF0zsdWsWbCrhRZbz0AZILCJOC2XFlcZtDsQQ09J0g1HqFGsHZMPO/S
	C+5+BjMVCWsHY34JF8ajqrHtAMvYpT7yF4HVsaikM2movc87UdZHDw1RoEMOr/uP
	LaQdAEc5WySviyNeuNRuaNpoTfuMdK2R//t8sYHZ48ZWGSqRCSwwifTAFe/Amao2
	pgKwd0kV4AIVKkY9GP/c7+n/xvaf3WABFsJ/G2Zcj+AsoTxAYZNqmq+9k2eRw8cB
	D7FOig==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hhbahw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 22:24:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48IMODJJ017413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 22:24:13 GMT
Received: from [10.110.34.108] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 15:24:09 -0700
Message-ID: <a4a4f5e2-f925-442c-b262-629de63022ba@quicinc.com>
Date: Wed, 18 Sep 2024 15:24:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Maxime Chevallier
	<maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>,
        Brad Griffis <bgriffis@nvidia.com>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Jon Hunter <jonathanh@nvidia.com>, <kernel@quicinc.com>
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
 <20240913100120.75f9d35c@fedora.home>
 <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>
 <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
 <ZulMct3UGzlfxV1T@shell.armlinux.org.uk>
 <1c58c34e-8845-41f2-8951-68ba5b9ced38@quicinc.com>
 <1ed3968a-ed7a-4ddf-99bd-3f1a6aa2528f@quicinc.com>
 <473d2830-c7e0-4adf-8279-33b91e112f80@lunn.ch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <473d2830-c7e0-4adf-8279-33b91e112f80@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Trulk6ZhZabLLo_6_5wT3BBIeiU3kUBT
X-Proofpoint-ORIG-GUID: Trulk6ZhZabLLo_6_5wT3BBIeiU3kUBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180149



On 9/18/2024 2:45 PM, Andrew Lunn wrote:
>> Russell and Andrew 
>>
>> we added prints and understood what the phy is reporting as part of the 
>> genphy_c45_pma_read_abilities 
>>
>> [   12.041576] MDIO_STAT2: 0xb301
>>
>>
>> [   12.050722] MDIO_PMA_EXTABLE: 0x40fc
>>
>> >From the PMA extensible register we see that the phy is reporting that it supports
>>
>> #define MDIO_PMA_EXTABLE_10GBT		0x0004	/* 10GBASE-T ability */
>> #define MDIO_PMA_EXTABLE_10GBKX4	0x0008	/* 10GBASE-KX4 ability */
>> #define MDIO_PMA_EXTABLE_10GBKR		0x0010	/* 10GBASE-KR ability */
>> #define MDIO_PMA_EXTABLE_1000BT		0x0020	/* 1000BASE-T ability */
>> #define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
>> #define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
>> #define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */
>>
>> [   12.060265] MDIO_PMA_NG_EXTABLE: 0x3
>>
>> /* 2.5G/5G Extended abilities register. */
>> #define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
>> #define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */
>>
>> I feel that the phy here is incorrectly reporting all these abilities as 
>> AQR115c supports speeds only upto 2.5Gbps 
>> https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen4-product-brief.pdf
>>
>> AQR115C / AQR115 Single port, 2.5Gbps / 1Gbps / 100Mbps / 10Mbps 7 x 7 mm / 7 x 11 mm
> 
> One things to check. Are you sure you have the correct firmware? Many
> of the registers which the standards say should be Read Only can be
> influenced by the firmware. So the wrong firmware, or provisioning
> taken from another device could result in the wrong capabilities being
> set.
> 

I did check with the hardware team and the firmware loaded is 
AQR-G4_v5.6.7-AQR_Marvell_NoSwap_XFI2500SGMII_ID44842_VER1922.cld
Only Marvell folks can tell me what is inside the FW. 
Let me double check with Marvell on this and ask them why is the phy 
reporting all these PMA capabilities. 

> You might want to report this issue to Marvell, but my guess would be,
> they don't care. I would guess the vendor driver ignores these
> registers and simply uses the product ID to determine what the device
> actually supports.
> 
>> I am thinking of solving this problem by having 
>> custom .get_features in the AQR115c driver to only set supported speeds 
>> upto 2.5gbps 
> 
> Yes, that is the correct solution.

> It would also be good if you could, in a separate patch, change the
> aqcs109_config_init() to not call phy_set_max_speed() and add a custom
> .get_features.
Let me raise this patch in a day or two for upstream review after 
testing it out locally on AQR115c 
> 
> 	Andrew

