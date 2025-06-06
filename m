Return-Path: <netdev+bounces-195340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27EACFA84
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 02:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF913B0A23
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 00:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CE1CD15;
	Fri,  6 Jun 2025 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CJWI6RUb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44EC3D561;
	Fri,  6 Jun 2025 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171178; cv=none; b=W+xFeMz2EFJRfXolZ1FyWDF+c6+rG/BOFOLP9+vPJ/h2zuFcxQj/dMTLlpcTqL8PYOZQfJooa8t24+CV8zdFSAZCCjqhz56Yk0grzY+PioU8kg9NaDrn5TxNOX89xdVL9u367F7Qz28vWdmFDjuz8hidX8xo8/75Qn70NaW13Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171178; c=relaxed/simple;
	bh=Ik1Fw3F0XanXVkM0jekhSVT5jZ+5NwKGBT3QF8vLSOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SWfjnfF+6N9xa2YL+CUQmn9cAT+vp3sxEH84/UdsqRaXeLHSnXBYcaTp6tCGejip0ae5Sh0SILWjDlaxlCHIs5slf2H/PjP1ABuoZL4e2c2KXLA6TdCo9m15vJ/+pitAvmnp1kUAmzRrTb40vpBZySebJo7RaOYrqpm1jO5gq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CJWI6RUb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555H7ki7032409;
	Fri, 6 Jun 2025 00:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zSxoMBdBswj1CbChfEjsnvEL7i6rzJ1B84E7R2jk0Po=; b=CJWI6RUbYOM23pbq
	2HshlRCF0DgbHADOdFkGzywKm795SNm+IyFCQd+NR1gp7FPEkBff2OMqNx2ONRXZ
	gWbIl6JBdb0J27yDyP4CiEgk+6DFl5GYBcaLrkuhrkHS5lXu4gioISZjQXmnT4HK
	0x2u/YdDZdHr13tgK++JSm803lfbbmJoqoSeLBsnsoRRu7iE4OWFOkT1j91X0oB8
	HbZCULx8cKPT0m8ytIQPyhOCidBow9W1+EAe+If68hw1sIzubBXgA4DbdcuO4h/E
	LXdovG/pUvbwdx6p9qSpGPfpjyHk2plsKg5wzuLp0Xd1348lwQhf+qW/nhbwFLAb
	zHF4Iw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfv1x8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 00:52:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5560qXrX026260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 00:52:33 GMT
Received: from [10.110.52.127] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 17:52:32 -0700
Message-ID: <808b7ab5-dc30-483b-81cc-397f14683963@quicinc.com>
Date: Thu, 5 Jun 2025 17:52:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
To: Wei Fang <wei.fang@nxp.com>, Russell King <linux@armlinux.org.uk>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "xiaolei.wang@windriver.com"
	<xiaolei.wang@windriver.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Sarosh Hasan <quic_sarohasa@quicinc.com>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
 <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aD_-xLBCswtemwee@shell.armlinux.org.uk>
 <PAXPR04MB851003DFCAA705E17F7B7117886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <PAXPR04MB851003DFCAA705E17F7B7117886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=68423bd2 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=jZjJzmEmTJcjZ5Ws:21 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=P-IC7800AAAA:8 a=z4TUXN5pqTJVFUMHeqsA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: mp45imXsio4OTjR_y5_28M_lJJNgpyWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAwNiBTYWx0ZWRfXyChimZBUjNx6
 kS9MkTSF1/ZefrHHUKnVRi4xPpWrFEuLgptTlX1z42wxjaGiOJbGcgzZCdDrJ1QmNBeWqs03U3z
 TZuDfSFKVasPPjLDfuMe60+6PtoQWqIAV+4yDl9XE3F+LOd2tFU7NTV4/4xIJcAH8BKOln3YgkO
 GKzXUMaz8DDSlxoEkwoam9cmImekTQ24gSMGGlBelgFNX9mdKvnW7ks2TEBNeJLF+XVrFU+wILd
 Fo97DgazqYCEo95dcIHSbfvh5j5YUeXq+rc3q3e0qtc1PXWm9vxLvi7S2QIga+4RxwpXX3KZzlz
 W9t+SSAXZ5c6z0XISae0zL5wxoHVMfkuV9Ic38JeJs2tUkNInnlhWPMEfRo6axSxKTq5lBFBv2F
 1JcODTTyoAlt/BK5YAWVvLBOENCv0Y5c97HA8UlNvtIz+ufzccn/490zFnu6VT6N+dZvsN6b
X-Proofpoint-GUID: mp45imXsio4OTjR_y5_28M_lJJNgpyWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060006



On 6/4/2025 5:08 AM, Wei Fang wrote:
>> On Wed, Jun 04, 2025 at 06:00:54AM +0000, Wei Fang wrote:
>>> I think this issue is also introduced by the commit bc66fa87d4fd
>>> ("net: phy: Add link between phy dev and mac dev"). I suggested
>>> to change the DL_FLAG_STATELESS flag to
>>> DL_FLAG_AUTOREMOVE_SUPPLIER to solve this issue, so that
>>> the consumer (MAC controller) driver will be automatically removed
>>> when the link is removed. The changes are as follows.
>>
>> I suspect this still has problems. This is fine if the PHY device is
>> going away and as you say device_del() is called.
>>
>> However, you need to consider the case where a MAC driver attaches the
>> PHY during .ndo_open and releases it during .ndo_release. These will
>> happen multiple times.
> 
> .ndo_release? Do you mean .ndo_stop?
> 
>>
>> Each time the MAC driver attaches to the PHY via .ndo_open, we will
>> call device_link_add(), but the device link will not be removed when
>> .ndo_release is called.
>>
>> Either device_link_add() will fail, or we will eat memory each time
>> the device is closed and re-opened.
> 
> Below is what I find in the kernel doc of device_link_add().
> https://elixir.bootlin.com/linux/v6.15/source/drivers/base/core.c#L711
> 
> if a device link between the given @consumer and @supplier pair
> exists already when this function is called for them, the existing link will
> be returned regardless of its current type and status.
> 
> Therefore, it will not create new link each time the netdev is re-opened.
> 
@Wei, 

We were able to verify the suggestion what you gave us. 
No crash is seen now. 
Should we raise a patch or shall we wait until this is clarified and 
Russell has no more further questions. ? 

I am okay with anything. 

>>
>> If that is correct, then we're trading one problem for another.
>>
> 

