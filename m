Return-Path: <netdev+bounces-129567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBC984874
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91B71F23694
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333617BEA2;
	Tue, 24 Sep 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pTvh3CMA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972A1946B;
	Tue, 24 Sep 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191100; cv=none; b=keFO5VR365K/QypCoi1ukWf4aT0X6VvlhXgO9AM53Hxh6XmY6Z/olOkEwcBzWqQywXQYvL+w/wACNbHL8P3nbkXfvB4dP0ToHDvYj2W4yT41rDSdHC7bWf6kUkjp0cEFb4QNVwzPXh4cL7vFJ57Y+e75fNOcVnl7yg9B4ND3r+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191100; c=relaxed/simple;
	bh=bBUeiHSyLfbSLeD2OeyHJT8x9p3+QnZoatg0bHu9JTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZJDHOmUuwyeSFentS9WvGNdWICtug6coO4u/sWtmLweIAXUtlYg5orMb6YDiuYHMALZY8lvb9YId61TA5rA5Ued/NZVDQ6q793L6OATBXh1JFp9MDYBBRc9Mf1RjYeH+BgcpGfub48bbFFuM+sAFHky7kqCMujpsf/Jg2j1sidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pTvh3CMA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8IDd9011870;
	Tue, 24 Sep 2024 15:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuR2U/ld3I3Q5sMdJL50QJmDNR7F92UTG2AzkTxedsw=; b=pTvh3CMAd2GBMERu
	iAtdabX9MyyHupJwUuIjxQLmTM/G3xC9XfpwQihHrVeVKW3LLlLoSHcqbH1pDDmm
	DZLHkkV4YjwFMhooYKUG3eMCaK7O5QWSvwd4WxEUDkHPxzWQNoGTOFK4kkfIJ1yn
	sTOiaQPPw1SK/e0H9eJZauFny0ZJofewRDDNU8MLUWm155kDLb+l9wajoqewjv7Q
	KC4b6Q6dO0bQDWQvGOUkXbnGY7KwSKusVxml70R1TpMrwn5u8uyDilNv1YxRRO0G
	XZRTXPi6VhNFCKWXNj837V08TLn4e2E9BBOYCUhYfzpjdYCHqgYf3NmsAPmTzvfD
	Ok6RgQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6s4yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:17:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OFHl1R031426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:17:47 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 08:17:43 -0700
Message-ID: <a599d7ac-b712-412c-9034-e0f35d3451d8@quicinc.com>
Date: Tue, 24 Sep 2024 08:17:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>,
        Brad Griffis <bgriffis@nvidia.com>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Jon Hunter <jonathanh@nvidia.com>, <kernel@quicinc.com>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
 <20240924102433.3ff11d20@fedora.home>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240924102433.3ff11d20@fedora.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HzSvG1ZHoNRzcFPZKtQggQYwrrRB_xE8
X-Proofpoint-ORIG-GUID: HzSvG1ZHoNRzcFPZKtQggQYwrrRB_xE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240109



On 9/24/2024 1:24 AM, Maxime Chevallier wrote:
> Hi,
> 
> On Mon, 23 Sep 2024 22:52:51 -0700
> Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> 
>> Remove the use of phy_set_max_speed in phy driver as the
>> function is mainly used in MAC driver to set the max
>> speed.
>>
>> Introduce custom get_features for AQR family of chipsets
>>
>> 1. such as AQR111/B0/114c which supports speeds up to 5Gbps
>> 2. such as AQR115c/AQCS109 which supports speeds up to 2.5Gbps
>>
>> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
>> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
>> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
>> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
>> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>> Changes since v1 
>> 1. remove usage of phy_set_max_speed in the aquantia driver code.
>> 2. Introduce aqr_custom_get_feature which checks for the phy id and
>>    takes necessary actions based on max_speed supported by the phy
>> 3. remove aqr111_config_init as it is just a wrapper function. 
>>
>> output from my device looks like :- 
>> 1. Link is up with 2.5Gbps with 2500BaseX with autoneg on.
>>
>>
>> Settings for eth0:
>>         Supported ports: [ TP    FIBRE ]
>>         Supported link modes:   10baseT/Full
>>                                 100baseT/Full
>>                                 1000baseT/Full
>>                                 2500baseX/Full
>>                                 2500baseT/Full
>>         Supported pause frame use: Symmetric Receive-only
>>         Supports auto-negotiation: Yes
>>         Supported FEC modes: Not reported
>>         Advertised link modes:  10baseT/Full
>>                                 100baseT/Full
>>                                 1000baseT/Full
>>                                 2500baseX/Full
>>                                 2500baseT/Full
>>
> 
>  [...]
> 
>> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
>> +{
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
>> +
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
> 
> Can this PHY actually support FIBRE ports ? What you must list here are
> the modes that the PHY can support on the LP side. I'm not familiar
> with this PHY, but from what I can see from the current driver, there's
> no such support yet in the driver.
I will update this . I have seen the databook and i dont think the Phy supports 
FIBRE. 

> 
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
>> +
>> +	if (max_speed == SPEED_2500) {
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> 
> If the PHY is strictly BaseT, then you shouldn't specify 2500BaseX as
> supported
Noted!

> 
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +	} else if (max_speed == SPEED_5000) {
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> 
> Same here
> 
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
>> +	}
>> +
>> +	linkmode_copy(phydev->supported, supported);
>> +}
>> +
>> +static int aqr_custom_get_feature(struct phy_device *phydev)
>> +{
>> +	switch (phydev->drv->phy_id) {
>> +	case PHY_ID_AQR115C:
>> +	case PHY_ID_AQCS109:
>> +		aqr_supported_speed(phydev, SPEED_2500);
>> +	break;
>> +	case PHY_ID_AQR111:
>> +	case PHY_ID_AQR111B0:
>> +	case PHY_ID_AQR114C:
>> +		aqr_supported_speed(phydev, SPEED_5000);
>> +	break;
>> +	}
>> +	return 0;
>> +}
> 
> You could define one .get_feature for the 2.5G PHYs and another for the
> 5G phys, that would avoid having to modify this single helper for each
> new PHY.
> 
Noted!
> Thanks,
> 
> Maxime

