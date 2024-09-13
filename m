Return-Path: <netdev+bounces-128165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8184978582
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE1B28A861
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634D55898;
	Fri, 13 Sep 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MMxCv4/t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA6D502;
	Fri, 13 Sep 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243967; cv=none; b=hivM5JBfHC6hJfiKJj8b7thVjjUX83Hu3DCmHSJKr/JWF/uEsmJERcTgn3ZvLfgNWlLRTbpJ9dKxj6IxtuJpE+y4eqK3Sh5U6MpZ1HoajT+rIS5zrJljZ9qPF9rfuoM8K2UwVmsx17hVRi2Z0epFS8+xNtuUrtxuJuGKmwlhQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243967; c=relaxed/simple;
	bh=Kti/nI8A3Lc/CrgyzFVHC2w/El0YG7A+BYTtl2J2VpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MUgOj1okVsIClaZKyHZNLviRXu6fB+RTPKsYy3p9yY0WtMz9dBWB3Di8rzwAGHL0W2wBUygqbv68ky6Nxfe2LkQlrR5DEOWWSKgC/ukdi/Pt0HqsspoeVVbzFAiJ62/sBMNaVHjW1A7NEZ26iVqUkoPLPjLbB/Z14hU62ba0BUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MMxCv4/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DB8jCH015062;
	Fri, 13 Sep 2024 16:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5oee7uEn3PUnJcnzaCB78a7q+lMeop7BAMpRYyFLGQ=; b=MMxCv4/tDpiMpC8v
	TEGBkLj/w8VsRe0JX1mqjvnkd4ChkOd9ioAj73gTeKwt5kqAWl3eP1wRbUNfgCiP
	EYzyLBYXwt8NertY2e07jdCeKjuwLk2rhMod6zrAgsNQD1FxeyIdyjsVpHwaaB0T
	I/Y++78Jb0FRDI1x9kkYfN3hhB53W6qF34fXoeCM9I5t1dV/IiQsbg+knVbsiyaZ
	i717ZCcvnhY5rt/coP7FTm6qIiPm9oe7vpQsnBPxvwuw8rhQnwMeaHAgkw70Px68
	xPs9aGJXbcAOziUt371KJ2z3MH1AAO3pMGmcpDIc04dko9CLjcVkwf2DoAHT+pcM
	p6sPpw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6t1g6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:12:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DGCJkl030700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 16:12:19 GMT
Received: from [10.110.86.107] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 09:12:15 -0700
Message-ID: <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>
Date: Fri, 13 Sep 2024 09:12:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net v1] net: phy: aquantia: Set phy speed to 2.5gbps
 for AQR115c
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
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
 <20240913100120.75f9d35c@fedora.home>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240913100120.75f9d35c@fedora.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M13BG-6DXZiTpe_7g3xhUwcwd_VFZkTZ
X-Proofpoint-ORIG-GUID: M13BG-6DXZiTpe_7g3xhUwcwd_VFZkTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130114



On 9/13/2024 1:01 AM, Maxime Chevallier wrote:
> Hi,
> 
> On Thu, 12 Sep 2024 18:16:35 -0700
> Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> 
>> Recently we observed that aquantia AQR115c always comes up in
>> 100Mbps mode. AQR115c aquantia chip supports max speed up to
>> 2.5Gbps. Today the AQR115c configuration is done through
>> aqr113c_config_init which internally calls aqr107_config_init.
>> aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
>> supprts max speed of 2.5Gbps only.
>>
>> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>> index e982e9ce44a5..9afc041dbb64 100644
>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>> @@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
>>  	if (!ret)
>>  		aqr107_chip_info(phydev);
>>  
>> +	/* AQR115c supports speed up to 2.5Gbps */
>> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
>> +		phy_set_max_speed(phydev, SPEED_2500);
>> +		phydev->autoneg = AUTONEG_ENABLE;
>> +	}
>> +
> 
> If I get your commit log right, the code above will also apply for
> ASQR107, AQR113 and so on, don't you risk breaking these PHYs if they
> are in 2500BASEX mode at boot?
> 

I was thinking of the same. That this might break something here for other Phy chip. 
As every phy shares the same config init. Hence the reason for RFC. 

> Besides that, if the PHY switches between SGMII and 2500BASEX
> dynamically depending on the link speed, it could be that it's
> configured by default in SGMII, hence this check will be missed.
> 
> Is the AQR115c in the same situation as AQR111 for example, where the
> PMA capabilities reported are incorrect ? If so, you can take the same
> approach as aqr111, which is to create a dedicated .config_init()
> callback for the AQR115c, which sets the max speed, then call
> aqr113c_config_init() from there ?
> 
I think the better way is to have AQR115c its own config_init which sets 
the max speed to 2.5Gbps and then call aqr113c_config_init . 
I will clean up the config_init and 

Thanks for the review comments.

> Maxime

