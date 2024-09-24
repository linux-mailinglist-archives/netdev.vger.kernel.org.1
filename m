Return-Path: <netdev+bounces-129569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA6984879
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0321C20C81
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D51A76C1;
	Tue, 24 Sep 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EJI9RWgp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCD1CFB6;
	Tue, 24 Sep 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191162; cv=none; b=RHHnjpchtadYWZHzus5ueewQDAyiC+njdI4RXR4SCmNHP5Xg+4t5Sw18iJzzc2WJlEYprf0q/E1sFwOVklxuuKyPq8POukRGr8Lv8ouM1O1eV3TCS9+s50CJgL+RcCrk+z/WaRQLufVxhvRh4yawuZmVykpkaSYvdKKRHV4ybM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191162; c=relaxed/simple;
	bh=PELF48R0mqXI826wHMnbQLtjIEuSSWWQgGcU6i9/t6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l+5yBLl7dEy1XVL8cQAWSmuX/AebIWo79koim1J/9WrFYNO8bijSmtgNH5HnolHmCEk/aKY0yCU4orlIXL8obOoMKkzTu5rmUQePV3O0tCuPUoPxAoWe8lQGa4jCJMVDIByDNWt5yvbPw0wwVkf80EMG3stOVEt+Dp+Sv3B4kN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EJI9RWgp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O9eq8o024446;
	Tue, 24 Sep 2024 15:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VNOYT4MdVO/21AUn7nh8yCalPGpx8OxYHYqurZKH24c=; b=EJI9RWgpME5ShbSo
	bNvnKPbORBrQ/d7FBEf0+zjAXWl5S0xkoAu7zZvsBZH9mPpF5dWGtrhgHJf8zTE9
	Ybx32eh0aEXBaPr1s9pggTiDe0fTl7GOK/CX451N27fVdbJHsYrjbhboWizMspBl
	L4gxR/bAkkCynJ3E3J1480HY6v9lzlV70mB7u7dd2yzp2072NiREs/2F18KWKbuL
	Bm4pBB/sPEv8PMLur1xCwABCIz3R0DZMcrGcyX2qoTrL9S/XH3XOFoI6XDURipOP
	EZK7Iu8ltsjnttnzT3W3H/75hSKtcDhBKZKXa8qkagPUitArInQ2jRiwF288IX3K
	hjz5pw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6s58a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:19:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OFJ0me017533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:19:00 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 08:18:57 -0700
Message-ID: <c39b1012-238f-4a00-9405-c6ee3fd01ce3@quicinc.com>
Date: Tue, 24 Sep 2024 08:18:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <kernel@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
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
        Jon Hunter <jonathanh@nvidia.com>,
        "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
 <5b4110c2-ebd2-4beb-bd52-f2e15c5bb88b@intel.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <5b4110c2-ebd2-4beb-bd52-f2e15c5bb88b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OiRWk-AY1WSk1FnwuAJgM86tYfYR6CmW
X-Proofpoint-ORIG-GUID: OiRWk-AY1WSk1FnwuAJgM86tYfYR6CmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=751
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240109



On 9/24/2024 1:46 AM, Przemek Kitszel wrote:
> On 9/24/24 07:52, Abhishek Chauhan wrote:
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
> 
> I'm not sure if this patch is -net material
> 
>> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
>> +{
>> +    __ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
>> +
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
>> +    linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
>> +
>> +    if (max_speed == SPEED_2500) {
>> +        linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>> +        linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +    } else if (max_speed == SPEED_5000) {
>> +        linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>> +        linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +        linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
>> +    }
> 
> instead of duplicating, just make the lists incremental:
> 
>     if (max_speed >= SPEED_2500) {
>         linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>         linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>     }
>     if (max_speed >= SPEED_5000)
>         linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> 
I will try to optimize this in the upcoming patches based on your suggestion. 
>> +
>> +    linkmode_copy(phydev->supported, supported);
>> +}

