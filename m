Return-Path: <netdev+bounces-130152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5066988AD8
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 21:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5370B1F22888
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3993A1C2435;
	Fri, 27 Sep 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UuqAXsFd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979541C1AC4;
	Fri, 27 Sep 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466208; cv=none; b=Wc+SWlQK7CbmEmabGsqR6VtemO88jkmCM8cmG836tx/EsilYJR2miuvRfqHNlibJO2DuvknNoPv08H3Y2g0PfaJNU6pHdjW0uTsjLd0nZtsveGWPVxFaeoi+jMsjpW4jX7FN6VMb0i7vKthzM5ZfSBBuWTMW7Qzn3IqBlJ84Wyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466208; c=relaxed/simple;
	bh=fCRW+m6LmxKtj1w6mA73cVlDXMaap/Z4KhK3XVQji6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G5zz4lx6dXYIr/8smIFMKI3GSzqKShD1Fze93FygXxJZQ8fRa4VFdQ0HNVh1gBKo4SaPJ9ASFliIxGO/LNIt+Ov9ddazMFTZw6DM6T1UVxiNoMjZrLSpoWQmoCzlZR8aopNhJ44jwPWDL3n8/vRMI9eaEpHRGiebXoxe0dq5xFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UuqAXsFd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RFNY6l020952;
	Fri, 27 Sep 2024 19:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	riuVibAcHN2TeSq86kZuy81O8eMVZ87ANRWLASxkiuY=; b=UuqAXsFdJThL0Yvg
	B7alqzAAkZPhVTo9s7ND2EbkE1PJpb/D7ie3AfjpYKWpRbizVzs7AmcylLmHOeLK
	nKKPsPAFD8IpjcFLYnDxFE3GxTcZrdWnCsGTqKQR8qMOibCBSK+3L1jLwkPVwxEC
	S21DEFnhCrsYsS2r4UTDBb4+AVdOm6Hr71+rh6FOsgo1I23vATh5o+5dfXDksTct
	rMW2JUjfO5Ffh8stV30nCzXKbc/0Nka/ysKgOCD6Kuw7F/DQ35ZKxs+5XfTfTQD8
	++RjTbgGc5aZ9xMoE8GW/VwaCFGptzWhNRYdcR/vOMPMDMw95rMYA7wAcf1bA23r
	64mKiA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sp7uv6da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 19:42:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RJgkmR026171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 19:42:46 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 27 Sep
 2024 12:42:42 -0700
Message-ID: <048bbc09-b7e1-4f49-8eff-a2c6cec28d05@quicinc.com>
Date: Fri, 27 Sep 2024 12:42:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
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
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
 <20240927010553.3557571-3-quic_abchauha@quicinc.com>
 <20240927183756.16d3c6a3@fedora.home>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20240927183756.16d3c6a3@fedora.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fqMA-LfAqd6mWR8PaVqMrTFFjnkkpibe
X-Proofpoint-ORIG-GUID: fqMA-LfAqd6mWR8PaVqMrTFFjnkkpibe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409270144



On 9/27/2024 9:37 AM, Maxime Chevallier wrote:
> Hi,
> 
> On Thu, 26 Sep 2024 18:05:53 -0700
> Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:
> 
>> Remove the use of phy_set_max_speed in phy driver as the
>> function is mainly used in MAC driver to set the max
>> speed.
>>
>> Instead use get_features to fix up Phy PMA capabilities for
>> AQR111, AQR111B0, AQR114C and AQCS109
>>
>> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
>> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
>> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
>> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> 
> [...]
> 
>> +static int aqr111_get_features(struct phy_device *phydev)
>> +{
>> +	unsigned long *supported = phydev->supported;
>> +	int ret;
>> +
>> +	/* Normal feature discovery */
>> +	ret = genphy_c45_pma_read_abilities(phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* PHY FIXUP */
>> +	/* Although the PHY sets bit 12.18.19, it does not support 10G modes */
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, supported);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, supported);
>> +
>> +	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
>> +	linkmode_or(supported, supported, phy_gbit_features);
>> +	/* Set the 5G speed if it wasn't set as part of the PMA feature discovery */
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> 
> As you are moving away from phy_set_max_speed(phydev, 5000), it should mean
> that what used to be in the supported bits already contained the
> 5GBaseT bit, as phy_set_max_speed simply clears the highest speeds.
> 
> In such case, calling the newly introduced function from
> patch 1 should be enough ?
> 

Well i am not sure about how other phy(AQR111, AQR111B0, AQR114C and AQCS109) behaved, 
but based on my testing and observation with AQR115c, it was pretty clear that 
the phy did not advertise Autoneg capabilities, did not set lower speed such as 10M/100M/1000BaseT
,it did set capabilities beyond what is recommended in the data book.

So the below mentioned phys such as 

AQR111, AQR111B0, AQR114C = supports speed up to 5Gbps which means i cannot use the function
defined in the previous patch as that sets speeds up to 2.5Gbps and all lower speeds. 

AQCS109 = supports speed up to 2.5Gbps and hence i have reused the same function aqr115c_get_features
as part of this patch.  

Also my plan was to make 1 patch but i got review comments from Andrew to separate it out 
and hence two patches with 2 different functions and removing the usage of phy_set_max_speed




> Thanks,
> 
> Maxime

