Return-Path: <netdev+bounces-130035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04749987C25
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 02:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42D31F247DE
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 00:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6379FD;
	Fri, 27 Sep 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I5vkEqor"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A56AAD;
	Fri, 27 Sep 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727396401; cv=none; b=WpQRkQErZuah3Vk62TsdRzpj59f44PJAkqOzbLZxgkM4l+sf9IDIgefCjUX3c/+uXAe2mjixmebUqJrnerBlXi1nm2pmGipbRia1sy48BbuVQoU0exKRXnto5CiDKkENlcU1a5YtYBzh+KTKt2nFy8G6YNVxBOk1IOlI55T1AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727396401; c=relaxed/simple;
	bh=UuweBmSShn/gSeqrXCn4tgiXEHMtvUOLL0DVS0Qki/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DHro5aV39QW8Bd+6aLWorGE33+wRHVgXmeH+Bdyd263CqGKZFCZoPHfAGALAPqkvOg0hAdWwSvaYIjIQX8BMOJXhwKF2RSi7pwiHqo+9VCQpEAxE1TZQBi4spf+Noe63xyzNAfH0eAerL4XJWQmxKOn9TY/XZiySQX/HiDYryzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I5vkEqor; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QKu0pL011647;
	Fri, 27 Sep 2024 00:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WlFYqRzn7wRcZo/X7XdhtDJ+/Kr1HL0e2I8UPpVX54U=; b=I5vkEqorAYRQAB5P
	f2PUWHSY7fHFOwluAObBb+N7ghUfkckp+f9vQiOuDwzEBm5GPj+muAEZfg1l4jKj
	OrRTUlMX6KEnINkwq07OI/IUXYUSqRnMPVlDB07MAFS4wHpYmZspiDLi2eyAoD4o
	qRaZGGdiVAiUFoO7kosMZQX1yqH6vFVsViGdLOfUXixV87rdun+YmGeK9Ffff/b+
	Hw11+AzoG32st/Yk7g144qZpSVxbR7Jo0jazD1ETmvBhhHFy7JtXjbjSeqoSFCyN
	jya9Ka9uqBcpXZzFKn2NbUKbI2cfwm9+6zCm2ce2wGo28H8VLQ3Km2HcPDiu+wtb
	Da8djQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuf16mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 00:19:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48R0JZBk005364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 00:19:35 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Sep
 2024 17:19:32 -0700
Message-ID: <6c6fae0b-2328-4427-83a3-3391c63e1e00@quicinc.com>
Date: Thu, 26 Sep 2024 17:19:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: phy: aquantia: AQR115c fix up PMA
 capabilities
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Andrew
 Lunn" <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>,
        Brad Griffis <bgriffis@nvidia.com>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <kernel@quicinc.com>
References: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
 <20240925230129.2064336-2-quic_abchauha@quicinc.com>
 <ZvVJbakJ01++YHHG@shell.armlinux.org.uk>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <ZvVJbakJ01++YHHG@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fQz4ud-1lkg8TDR1giAaAZ9PbPBaRRlC
X-Proofpoint-ORIG-GUID: fQz4ud-1lkg8TDR1giAaAZ9PbPBaRRlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270001



On 9/26/2024 4:45 AM, Russell King (Oracle) wrote:
> On Wed, Sep 25, 2024 at 04:01:28PM -0700, Abhishek Chauhan wrote:
>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>> index e982e9ce44a5..88ba12aaf6e0 100644
>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>> @@ -767,6 +767,33 @@ static int aqr111_config_init(struct phy_device *phydev)
>>  	return aqr107_config_init(phydev);
>>  }
>>  
>> +static int aqr115c_get_features(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
> 
> Networking uses reverse-christmas tree ordering for variables. Please
> swap the order of these.
> 
> Also, I think this would be better:
> 
> 	unsigned long *supported = phydev->supported;
> 
> You don't actually need a separate mask.
> 
>> +
>> +	/* Normal feature discovery */
>> +	ret = genphy_c45_pma_read_abilities(phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* PHY FIXUP */
>> +	/* Although the PHY sets bit 12.18.19.48, it does not support 5G/10G modes */
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, phydev->supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported);
> 
> For the above four, s/phydev->supported/supported/
> 
>> +
>> +	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
>> +	linkmode_copy(supported, phy_gbit_features);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +
>> +	linkmode_or(phydev->supported, supported, phydev->supported);
> 
> Drop this linkmode_or().
> 
> You'll then be modifying phydev->supported directly, which is totally
> fine.
Noted!.

Thanks Russell. Appreciate all the reviews. 


> 

