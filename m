Return-Path: <netdev+bounces-128860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81E97C161
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 23:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346DD1C20E86
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3171BBBEA;
	Wed, 18 Sep 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lae+472E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767CD15853D;
	Wed, 18 Sep 2024 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694862; cv=none; b=EFNrV+USG8k673A3Ij1HdKYoU2t1PU/XjZT/ZdVVNHXj0Mx3+OAoSISpMU9Va034wOcLZiz1bWUBiylXR5Uivp1aXyoKp8Of9kwcKVMLCrQg81wSmI+4XlUzco/b8P7TxgQAxR0daxmuj5Pd2UjngWsTKaeWqglzUGzM29F2JcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694862; c=relaxed/simple;
	bh=MQwqzx34OpVfik+49BlpDfhPKyrShvp6+I8o0VxehMY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Oq7pnr4YSi0rcBmO0fIWv0zSEm5U8BeU7+71LspgeJ/ydy+T3SnensVpxnx8ZrmYg+Tvfr2iVuS4cKfETHtEeLri2F1LQYQj8TjaRy211duvdQAZ0R1NEBbC8L7+RMfQhOCVSehDVMPZGtallr9lDO3xzDYTMBDLDRYLfxYlTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lae+472E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I9sb6N013720;
	Wed, 18 Sep 2024 21:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vw6J8wwAYarOWn5eFEbgaFg8WcFi8QcGR0rQuGS3E60=; b=lae+472E6PY1eduV
	hDHA361ZRnc4q8/NZ5/sFwWVm/MDimsPUMBCQpexYGzs6n8I0SgaSySV8Aw7BhgT
	5QB5iby2PXbfBk3jUgpmk5sLi/H9k94yjHYCkVvgL0hPjkR7jAU5m8mb4F472HZw
	eqvaIRqcP/urSmt6iinkTzUqOCedpL8JEhotskjnmwGF/U6+3BtppKoismxRtD9w
	TT62Zz1WgpaMw1Kxfh3xUwY9GtPlwLJ7dt4fZc/S235MNqY4KP9ypcLgEQx1POa/
	azHZfLv9p/DRjUVETGfcE0+E98d/0qT8z/nIvwRLxwZcIQO1RzMAWF8NSiUOoBNH
	RKA8aA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j6uawq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 21:27:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48ILRGZS010700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 21:27:16 GMT
Received: from [10.110.34.108] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 14:27:12 -0700
Message-ID: <1ed3968a-ed7a-4ddf-99bd-3f1a6aa2528f@quicinc.com>
Date: Wed, 18 Sep 2024 14:27:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
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
Content-Language: en-US
In-Reply-To: <1c58c34e-8845-41f2-8951-68ba5b9ced38@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y05Ab8g6odJrNlWKuNPHwN_N2L4D7uac
X-Proofpoint-GUID: Y05Ab8g6odJrNlWKuNPHwN_N2L4D7uac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180141



On 9/17/2024 1:57 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 9/17/2024 2:31 AM, Russell King (Oracle) wrote:
>> On Fri, Sep 13, 2024 at 06:35:17PM +0200, Andrew Lunn wrote:
>>> On Fri, Sep 13, 2024 at 09:12:13AM -0700, Abhishek Chauhan (ABC) wrote:
>>>> On 9/13/2024 1:01 AM, Maxime Chevallier wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, 12 Sep 2024 18:16:35 -0700
>>>>> Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
>>>>>
>>>>>> Recently we observed that aquantia AQR115c always comes up in
>>>>>> 100Mbps mode. AQR115c aquantia chip supports max speed up to
>>>>>> 2.5Gbps. Today the AQR115c configuration is done through
>>>>>> aqr113c_config_init which internally calls aqr107_config_init.
>>>>>> aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
>>>>>> supprts max speed of 2.5Gbps only.
>>>>>>
>>>>>> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
>>>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>>>> ---
>>>>>>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>>>>>> index e982e9ce44a5..9afc041dbb64 100644
>>>>>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>>>>>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>>>>>> @@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
>>>>>>  	if (!ret)
>>>>>>  		aqr107_chip_info(phydev);
>>>>>>  
>>>>>> +	/* AQR115c supports speed up to 2.5Gbps */
>>>>>> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
>>>>>> +		phy_set_max_speed(phydev, SPEED_2500);
>>>>>> +		phydev->autoneg = AUTONEG_ENABLE;
>>>>>> +	}
>>>>>> +
>>>>>
>>>>> If I get your commit log right, the code above will also apply for
>>>>> ASQR107, AQR113 and so on, don't you risk breaking these PHYs if they
>>>>> are in 2500BASEX mode at boot?
>>>>>
>>>>
>>>> I was thinking of the same. That this might break something here for other Phy chip. 
>>>> As every phy shares the same config init. Hence the reason for RFC. 
>>>>
>>>>> Besides that, if the PHY switches between SGMII and 2500BASEX
>>>>> dynamically depending on the link speed, it could be that it's
>>>>> configured by default in SGMII, hence this check will be missed.
>>>>>
>>>>>
>>>> I think the better way is to have AQR115c its own config_init which sets 
>>>> the max speed to 2.5Gbps and then call aqr113c_config_init . 
>>>
>>> phy_set_max_speed(phydev, SPEED_2500) is something a MAC does, not a
>>> PHY. It is a way for the MAC to say is supports less than the PHY. I
>>> would say the current aqcs109_config_init() is doing this wrong.
>>
>> Agreed on two points:
>>
>> 1) phy_set_max_speed() is documented as a function that the MAC will
>> call.
>>
>> 2) calling phy_set_max_speed() in .config_init() is way too late for
>> phylink. .config_init() is called from phy_init_hw(), which happens
>> after the PHY has been attached. However, phylink needs to know what
>> the PHY supports _before_ that, especially for any PHY that is on a
>> SFP, so it can determine what interface to use for the PHY.
>>
>> So, as Andrew says, the current aqcs109_config_init(), and it seems
>> aqr111_config_init() are both broken.
>>
>> The PHY driver needs to indicate to phylib what is supported by the
>> PHY no later than the .get_features() method.
>>
> 
> Noted!. Makes sense. thanks for your review, Russell. 
> We are in the process of figuring out what the phy chip is reporting as 
> its features. Once done i will raise a clean patch for upstream review. 
> 

Russell and Andrew 

we added prints and understood what the phy is reporting as part of the 
genphy_c45_pma_read_abilities 

[   12.041576] MDIO_STAT2: 0xb301


[   12.050722] MDIO_PMA_EXTABLE: 0x40fc

From the PMA extensible register we see that the phy is reporting that it supports

#define MDIO_PMA_EXTABLE_10GBT		0x0004	/* 10GBASE-T ability */
#define MDIO_PMA_EXTABLE_10GBKX4	0x0008	/* 10GBASE-KX4 ability */
#define MDIO_PMA_EXTABLE_10GBKR		0x0010	/* 10GBASE-KR ability */
#define MDIO_PMA_EXTABLE_1000BT		0x0020	/* 1000BASE-T ability */
#define MDIO_PMA_EXTABLE_1000BKX	0x0040	/* 1000BASE-KX ability */
#define MDIO_PMA_EXTABLE_100BTX		0x0080	/* 100BASE-TX ability */
#define MDIO_PMA_EXTABLE_NBT		0x4000  /* 2.5/5GBASE-T ability */

[   12.060265] MDIO_PMA_NG_EXTABLE: 0x3

/* 2.5G/5G Extended abilities register. */
#define MDIO_PMA_NG_EXTABLE_2_5GBT	0x0001	/* 2.5GBASET ability */
#define MDIO_PMA_NG_EXTABLE_5GBT	0x0002	/* 5GBASET ability */

I feel that the phy here is incorrectly reporting all these abilities as 
AQR115c supports speeds only upto 2.5Gbps 
https://www.marvell.com/content/dam/marvell/en/public-collateral/transceivers/marvell-phys-transceivers-aqrate-gen4-product-brief.pdf

AQR115C / AQR115 Single port, 2.5Gbps / 1Gbps / 100Mbps / 10Mbps 7 x 7 mm / 7 x 11 mm

I feel like get_features for AQR115c is reporting wrong modes and hence the 
link is coming up and is negotiated at 100Mbps. (Misbehavior from AQR115c)

From the MAC perspective we have ensure our max capabilities are 2.5 Gbps 
by setting the below from stmmac driver 
phylink_limit_mac_speed(config, 2500);

I am thinking of solving this problem by having 
custom .get_features in the AQR115c driver to only set supported speeds 
upto 2.5gbps 

let me know what you think ? 
 

>> Thanks.
>>

