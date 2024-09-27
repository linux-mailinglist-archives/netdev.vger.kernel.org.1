Return-Path: <netdev+bounces-130034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CBC987C22
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 02:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956121F248FD
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 00:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271676AAD;
	Fri, 27 Sep 2024 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AmXKzBzV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9D8493;
	Fri, 27 Sep 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727396302; cv=none; b=PJiYGDd8PacY6/anNjNa/fqg5WuXGSfJcxUDyyFoO7EcfG1bhpKTj7YMLO69huAuPfh5RkRbDX5KKMMHL5VxcA0+dpV8PRBLY65Pn3OsDM6D7LUGY48eRE/WSrsacV7VM83wOGEBtZvFUXsHVX7m8UxjaMxklnsxomrB31dY/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727396302; c=relaxed/simple;
	bh=2HOY+XtzKx8PdUWTpWdegVzmUzRS00BuFm/Q7+QgKtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pIzOpbSb3dxgzBUK/docb4nj1qhm4jcbOcB39Jn3vSSKgOmvNXFbAn0kLYRfZ1y6airt1bBR+r/wd8W68ZVLt2ISOMNynSNoTXZ7pRoKdZ0e5UlIQ6sUHozQMMkufUUc/gH2fpxwZ9r2gGUJ46i5uBy3UeysdciTV+XtTP+D/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AmXKzBzV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9fCU026555;
	Fri, 27 Sep 2024 00:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrnvhxbqRFeTXh6paRlpfiR2SwCI4Z58/6oWdIlLds8=; b=AmXKzBzVgEB+c6hp
	QcrJ7BnBrVpSSk9ZpvmKsdqCuaQMLJz22SuJxbxBsEdBeIu7tTcigvRJcwB6OwIf
	/K6HCyXBs9Ip5DFCKG3+i5wC7HYXxTcVPAa4Uu/oWkyfoYCQE/c6Lcu8ezly1GyB
	ojQ6u0L0O0G03UZUxLFS/2Of9qnZJFr7Yd2cagFXZWLW9NbiwbjD0cdunBowMu8o
	mziiF5ViUwnA6pbC7j/IJZ5LEvdS2Sp1eMlBqmj7yHclmkjpJ6mitkTozxCQDwzD
	9P8ZxURkchiTekD4FuSrolTzkP/hVwDZHrvnK5C0ySP5XvbE8lazsYwXdtuzTw0w
	TZsCSA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh9b8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 00:17:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48R0Hqn2001326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 00:17:52 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 26 Sep
 2024 17:17:48 -0700
Message-ID: <ed33f7a4-89b1-4090-bcb5-14f2d98cbd75@quicinc.com>
Date: Thu, 26 Sep 2024 17:17:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: phy: aquantia: AQR115c fix up PMA
 capabilities
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
        Jon Hunter <jonathanh@nvidia.com>,
        "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, <kernel@quicinc.com>
References: <20240925230129.2064336-1-quic_abchauha@quicinc.com>
 <20240925230129.2064336-2-quic_abchauha@quicinc.com>
 <20240926084222.48042652@fedora.home>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240926084222.48042652@fedora.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0uTlD4aqkwFWN_LW9TPCU-xR2Ju_EgDA
X-Proofpoint-GUID: 0uTlD4aqkwFWN_LW9TPCU-xR2Ju_EgDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=877
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270001



On 9/25/2024 11:42 PM, Maxime Chevallier wrote:
> Hello,
> 
> On Wed, 25 Sep 2024 16:01:28 -0700
> Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> 
>> AQR115c reports incorrect PMA capabilities which includes
>> 10G/5G and also incorrectly disables capabilities like autoneg
>> and 10Mbps support.
>>
>> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
>> with autonegotiation.
>>
>> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
>> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
> 
> [...]
> 
>>  
>> +static int aqr115c_get_features(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
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
>> +
>> +	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
>> +	linkmode_copy(supported, phy_gbit_features);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
> 
> I still think you shouldn't report 2500BaseX, as you mentionned
> it's a BaseT PHY. This is independent of the modes that the PHY uses to
> connect to the MAC. Although the PHY can talk to the MAC using
> 2500BaseX on its MII interface, it looks like it can't use
> 2500BaseX on its MDI (the LP side of the PHY). There's the same issue in
> patch 2.
> 
I Agree with you. I did some experiments today without setting the 2500BaseX bit and i see
the link still comes up with 2.5Gbps with autoneg on. 

I will rectify this as part of the next patch 

Thanks Maxime 


> Thanks,
> 
> Maxime

