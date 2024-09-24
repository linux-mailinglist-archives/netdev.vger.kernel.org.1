Return-Path: <netdev+bounces-129570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97BD98487C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AC21C20D78
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4EF1A76C8;
	Tue, 24 Sep 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e5qVcR/V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFAEEB3;
	Tue, 24 Sep 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191223; cv=none; b=tdeaPn/jH+2kubFF7OAOHqbjbWE6GZwSLR8jaGjwjOuLrSPxcZNufdiZSE3oksX0tkfyilF/qfH3XVLIxD40jTEMvGCSVPQ/HwQ26CP1Qp1eIrdLLPhkQQqys9HDzTTQzGDBZrtgf3KecH8xBh6P3PCrhH6UYrGESqMMzh4rA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191223; c=relaxed/simple;
	bh=xh/ZBi1/6defA6gKOipipF9FYVymG46KI7tKxPWOQsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qd0HUSLHz2xWmzuu/2984T05TcG4KSgH5lAlwXk9zf/Pob0LQZ3fIAxN2lZy7ZKRT6h4XE+ISSSU+kgCqu6/uy+KGyR6qSc2ow/MUAcSgbncoKw3gZ3xEi7obDWz4Styx4zDxWmZdQi4TU8Rk9/rv0lGTq/Qs2IaXesqk7f4Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e5qVcR/V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O9fjnK023720;
	Tue, 24 Sep 2024 15:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2S2GiOZZc42HtYtXp1LEi4ri88uyniKURTl4EJXC6w4=; b=e5qVcR/VOFnpV0jr
	jGhaLnrGbuJ30suRDto38HV2uYcIs4bevBXu9Rts3jg9oDxX4jNh9//GzNPVkshT
	HnbQhgJ4UrlR72+8GoVpkXwwKdf148pjVrOU5jBtNsNM+IYNGEdvjkTc1ZtPQJe2
	rfOZ4ZGNiw3GKxnZ6FgmZGEPNFt23+0NFqfo4P1r/udzKpVwKfXpfp4enL3Y2ady
	6JxNoxmENOCXNlxt2U7PD8lsJK3+NFYO7gh5r05eKmuHgEYqn98HV8eQ5nEsMB0c
	TA1zWgJB5SbO+PhYYjNV59a77yBpER2ctSwFbZmvgM6267pBlWWZHmntS83YfOVl
	mWY2wQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skgn9ey2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:20:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OFK13X001228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:20:01 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 08:19:57 -0700
Message-ID: <32ce1fd1-5bf1-4772-9a1a-4089fd87e3f1@quicinc.com>
Date: Tue, 24 Sep 2024 08:19:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
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
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <8a6611fd-bd7b-4d32-8cea-ea925a9979ab@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g1lyJ5Atw1Sa4EZuTmKqh9Qo76vXf6Lx
X-Proofpoint-GUID: g1lyJ5Atw1Sa4EZuTmKqh9Qo76vXf6Lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240109



On 9/24/2024 5:04 AM, Andrew Lunn wrote:
>> +static void aqr_supported_speed(struct phy_device *phydev, u32 max_speed)
>> +{
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
>> +
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
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
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +	} else if (max_speed == SPEED_5000) {
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, supported);
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
>> +	}
>> +
>> +	linkmode_copy(phydev->supported, supported);
>> +}
> 
> So you have got lots of comments....
> 
> Please split this into two patches. One patch for the PHY you are
> interested in, and a second patch to remove phy_set_max_speed() and
> fix up that PHY.
> 
Noted! 

> Also, i would prefer you do the normal feature discovery, calling
> genphy_read_abilities() and/or genphy_c45_pma_read_abilities() and
> then fixup the results by removing the modes which should not be
> there.
> 
Sounds good! 
> Take a look at bcm84881_get_features() as an example.
> 
Thanks Andrew! 
> 	Andrew

