Return-Path: <netdev+bounces-128185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3E978694
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59665B20974
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C17E563;
	Fri, 13 Sep 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vf7TKf9j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FFC4F20E;
	Fri, 13 Sep 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248157; cv=none; b=DRL5slRJZaimxQF2byZXkkSRciaQ/QflD8dfmj12xuCDaVqXrVOamj4f1dTopV2HeK/CL7xzfPChG3+513sa1NaWixPsIAPypP740dhG/5S1pm7lrNsfyxpj7zzXPrJdr9OxRz5hTpSZfbPKv6MVMule4a4VGIpqf1Ioy9JcJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248157; c=relaxed/simple;
	bh=s7eO93kg8ysBRRZfrfS1e3Z3WCkhxLWch1MA5EoLsto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P3ZQw2UTL1V0KrizBX9XadBxmlM2ffb2/JHiUBwxXsDudEN5Rz6krdySgNSIyLDKkHuOyU3L+BZ7hJ3FZ9EL85bpPGbX9bn/eT8llRDXjmfpoWs/eGOw6VzOSNYeFp9tDCBQDAGADakRlkpiFl+plMy0DkG3F26XPqDffSPQbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vf7TKf9j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DA9NGr032375;
	Fri, 13 Sep 2024 17:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZqhrEEqwuyfI/PMaelNfv0IQVewxxkYdfiJILt0Fpl4=; b=Vf7TKf9jdlJr7Mha
	J76hus+R4RDfROWBIrfVXC658gZFLoxKGuQGsmRoLKH0PxbtbdSQLG146nlDFUqh
	kmZo1/eb1DvsSngstvcoVtljMElh0LHsz6+4gpN78A5Qon3rDTbsVf8LhJvNKMTI
	UAxzAo4TCjN6Xz1i44NRpCX+SWYJgBl71HsIn1+/eS8GRFVPzjtRUyLU+wbBXaqL
	sHjmVfrGcwVx/Iqrz/WcYARldsxmfv2NK1JnntYAYo65aRGJyq+j56QtR9GAHRhI
	LZqJWc1Dkqn2xfDorXB4pxHKiY1KE6HH8EDHV7nVWvo11j4mLYleMnaCoj80xzkJ
	mnd7Rw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6t1q31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 17:22:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DHMCPr018146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 17:22:12 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Sep
 2024 10:22:07 -0700
Message-ID: <4b6addfe-5a54-41f8-9353-4541440950e9@quicinc.com>
Date: Fri, 13 Sep 2024 10:22:06 -0700
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
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
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
	<jonathanh@nvidia.com>, <kernel@quicinc.com>
References: <20240913011635.1286027-1-quic_abchauha@quicinc.com>
 <20240913100120.75f9d35c@fedora.home>
 <eb601920-c2ea-4ef6-939b-44aa18deed82@quicinc.com>
 <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <c6cc025a-ff13-46b8-97ac-3ad9df87c9ff@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bgYaCwxVRs7CJ1dCfy7Ejhft1EVVHW1-
X-Proofpoint-ORIG-GUID: bgYaCwxVRs7CJ1dCfy7Ejhft1EVVHW1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130124



On 9/13/2024 9:35 AM, Andrew Lunn wrote:
> On Fri, Sep 13, 2024 at 09:12:13AM -0700, Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 9/13/2024 1:01 AM, Maxime Chevallier wrote:
>>> Hi,
>>>
>>> On Thu, 12 Sep 2024 18:16:35 -0700
>>> Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
>>>
>>>> Recently we observed that aquantia AQR115c always comes up in
>>>> 100Mbps mode. AQR115c aquantia chip supports max speed up to
>>>> 2.5Gbps. Today the AQR115c configuration is done through
>>>> aqr113c_config_init which internally calls aqr107_config_init.
>>>> aqr113c and aqr107 are both capable of 10Gbps. Whereas AQR115c
>>>> supprts max speed of 2.5Gbps only.
>>>>
>>>> Fixes: 0ebc581f8a4b ("net: phy: aquantia: add support for aqr115c")
>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>> ---
>>>>  drivers/net/phy/aquantia/aquantia_main.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>>>> index e982e9ce44a5..9afc041dbb64 100644
>>>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>>>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>>>> @@ -499,6 +499,12 @@ static int aqr107_config_init(struct phy_device *phydev)
>>>>  	if (!ret)
>>>>  		aqr107_chip_info(phydev);
>>>>  
>>>> +	/* AQR115c supports speed up to 2.5Gbps */
>>>> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX) {
>>>> +		phy_set_max_speed(phydev, SPEED_2500);
>>>> +		phydev->autoneg = AUTONEG_ENABLE;
>>>> +	}
>>>> +
>>>
>>> If I get your commit log right, the code above will also apply for
>>> ASQR107, AQR113 and so on, don't you risk breaking these PHYs if they
>>> are in 2500BASEX mode at boot?
>>>
>>
>> I was thinking of the same. That this might break something here for other Phy chip. 
>> As every phy shares the same config init. Hence the reason for RFC. 
>>
>>> Besides that, if the PHY switches between SGMII and 2500BASEX
>>> dynamically depending on the link speed, it could be that it's
>>> configured by default in SGMII, hence this check will be missed.
>>>
>>>
>> I think the better way is to have AQR115c its own config_init which sets 
>> the max speed to 2.5Gbps and then call aqr113c_config_init . 
> 

Noted!

> phy_set_max_speed(phydev, SPEED_2500) is something a MAC does, not a
> PHY. It is a way for the MAC to say is supports less than the PHY. I
> would say the current aqcs109_config_init() is doing this wrong.
> 
>>> Is the AQR115c in the same situation as AQR111 for example, where the
>>> PMA capabilities reported are incorrect ?
> 
> This is the approach to follow. The PHY registers should report what
> it is actually capable of. But some aquantia PHYs get this
> wrong. Please check if this is also true for your PHY. Look at what
> genphy_c45_pma_read_abilities() is doing.
> 
> You might need to implement a .get_feature callback for this PHY which
> first calls genphy_c45_pma_read_abilities() and then manually fixes up
> what the PHY gets wrong.
> 

Thanks alot Andrew. I will get back to you with my analysis on AQR115c 
phy. Most likely the pma abilities are reported incorrectly. 


> 	Andrew     	

