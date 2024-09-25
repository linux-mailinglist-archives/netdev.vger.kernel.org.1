Return-Path: <netdev+bounces-129636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAAD984F97
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 02:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30C01F24C1B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98592132132;
	Wed, 25 Sep 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DmO5pEV+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AC130499;
	Wed, 25 Sep 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225420; cv=none; b=AwoMsGomO+o9rWGn9AbePJz+DeHXmYrMofq9AKsjt3R2tYjyYslj6jVt4e/HqtiQoDFrAa5aWZ7XLohpZZ0zDqy6ptfogAYi1XSsPyCRve1obgzoP625CiqR48A4wcrH0rk8BZVPXA1gqDeDinPiewlNtz4lLMWSOBDfq/EKX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225420; c=relaxed/simple;
	bh=Uws1dxHoqnzaSsIhZL48rY8Ul/OpI8XzP0iBszrF4hs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=H716NR9jCk550fwCwJ0aHkcxyxM7ubR4mgOme3bCAc0rt5FY4qulWme8ZvxolsuwENc2r3MT/ZBi0W9AXh8aS7LMJFbUzU8jVgdwrELNe5ROuRU5E4Jy5zGafGZF1nXKZ1oKEhrh+iNI7RYknknYiFY1u+sFROuUyKsJCY7wPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DmO5pEV+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHGe9I028857;
	Wed, 25 Sep 2024 00:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iSDSrotjN09qXthKJBl3Sk0tZ3vcmu8UtJ8Iycp0Fwc=; b=DmO5pEV+SAOZ0AUD
	rEikWgnpZaj773AtbByqUM/fWAmYI9fovonbXUHr5o2OcbmPRHnR/d6/lrfN9Vss
	eNjZCJJzmwzWnTGFP+FN6UVLNDbgDYPHrdrbnD/22yrSDNEBQoNVTDRyMw0p6TQo
	2XNwJPpCk42SYhWFzHQ4OQdH3BGbLDdNhiNMZaTeV8/152u95JWXtSTsVW7db22q
	Wzt2OrCr44g/wwik0k9zR3eYHEhe/4wW24fUrRfxgG+lmYT/H6dXACB1L9hCiJqw
	YwOV8qgMKQAvWG+Azoz9nwMsf59aLofXmjXe/VD1kf1PtqH0LBP4VKV6/l/JGi8Z
	8h9T1g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh2k8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 00:49:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P0nt7Q027688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 00:49:55 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 17:49:52 -0700
Message-ID: <eb7e327d-996c-429d-a45e-2f3522d234a3@quicinc.com>
Date: Tue, 24 Sep 2024 17:49:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Brad Griffis
	<bgriffis@nvidia.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jon Hunter
	<jonathanh@nvidia.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        <kernel@quicinc.com>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
 <8a6611fd-bd7b-4d32-8cea-ea925a9979ab@lunn.ch>
 <32ce1fd1-5bf1-4772-9a1a-4089fd87e3f1@quicinc.com>
Content-Language: en-US
In-Reply-To: <32ce1fd1-5bf1-4772-9a1a-4089fd87e3f1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _wIK4WZD5yYCwkOXMflg3xRn4Qj6rQZy
X-Proofpoint-GUID: _wIK4WZD5yYCwkOXMflg3xRn4Qj6rQZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250004



On 9/24/2024 8:19 AM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 9/24/2024 5:04 AM, Andrew Lunn wrote:
>>> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
>>> +{
>>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
>>> +
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
>>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
>>> +
>>> +	if (max_speed == SPEED_2500) {
>>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>>> +	} else if (max_speed == SPEED_5000) {
>>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
>>> +	}
>>> +
>>> +	linkmode_copy(phydev->supported, supported);
>>> +}
>>
>> So you have got lots of comments....
>>
>> Please split this into two patches. One patch for the PHY you are
>> interested in, and a second patch to remove phy_set_max_speed() and
>> fix up that PHY.
>>
> Noted! 
> 
>> Also, i would prefer you do the normal feature discovery, calling
>> genphy_read_abilities() and/or genphy_c45_pma_read_abilities() and
>> then fixup the results by removing the modes which should not be
>> there.
>>
> Sounds good! 
>> Take a look at bcm84881_get_features() as an example.
>>
> Thanks Andrew! 

Andrew, (Let me know if this is okay with you)
On doing the normal feature discovery today I observed that AQR115C 
i want to document this misbehavior here for future reference

//Print added by me in the AQR driver 
[    5.583440]  AQR supported mask=00,00000000,00018000,000e102c

key points :- 

AQR115c supports 10Mbps(F/H) but feature discovery says no
AQR115C supports 1Gbps(F/H) but feature discovery says no 
AQR115C supports 2500BaseX but feature discovery says no 
AQR115C supports Autoneg but feature discovery says Hell no! 
AQR115C does not support 10GBaseT/KX4/KR but feature discovery says yes 
AQR115c does not support 5GbaseT but feature discovery says yes 

I have got 2 different FW from Marvell but none seem to help. 
I also got the confirmation from Marvell folks that Autoneg is supported but 
the feature discovery says otherwise. 

Here is the thing what i am going to do for now. (Let me know if this is okay with you)
1. Raise FIXUP for AQR115c patch 
- remove all the features which are not support 
- Add supported features which we really requires such as Autoneg/phy_gbit_features/2500BaseX/BaseT(Clearly see them supported in the NDA internal docs) 
Reference for other folks for information which is public :
https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen4-product-brief.pdf


2. Raise FIXUP patch by removing phy_set_max_speed and call 
- Generic function which sets speeds up to 2.5Gbps for AQCS109 (2.5Gbps max speed)
- Generic function which sets speeds up to 5 Gbps for AQR111/B0/114c (5Gbps max speed)

Both points 1 and 2 will be a patch series with cover letter. 



>> 	Andrew

