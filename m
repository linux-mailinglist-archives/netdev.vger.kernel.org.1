Return-Path: <netdev+bounces-130475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8798AA5D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC3F1F23C5D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD4193416;
	Mon, 30 Sep 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ePygGdu7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F56193412;
	Mon, 30 Sep 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715338; cv=none; b=MFcun/3sFg7Fu/w6gW7BGQvUDbaG9wb4iNhyemkVQw1JBcQPVEWLt6ta1GpCDX4gJMwNFZrFy95oAx8BdeFCUWhiID3tGaEn+xP6Mm2jn3I91F4LF0lNt+/IBPNPtYJrhzSDb/eRDF+7Jja9XkwCDBgpTgTg+1+t1TixKZflwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715338; c=relaxed/simple;
	bh=luz6JeL08QB7kX1h6pt0bYUO/BYAHR0mr1Szwx4L7Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nEpLEfiTliV8ArCE05smihS62Hry8yMDYVwLv8w4leLw3drs8hU1qRBiinw65pXf1kKBuL5075eraQF/LozXYzOyQ5idiSLiLWeHVeRsCpNWLshJmh1x7nqo6s3/u4iiADNtH0uoj2SHLfH1/CSvtovMae9U+jR7btjHG/vT6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ePygGdu7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBjO80014513;
	Mon, 30 Sep 2024 16:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NSdlGLpd+rF74Tvbqd7tIObslAvZIOatLUNf6yuJxCU=; b=ePygGdu7PecwLSUb
	ohfM+QHoVhKUJ1o9Qt1JfFumY+PJ7+NnMYiMMrfw0Cqamk/MLoM+hrUBqYKK8RqB
	ubnxM+rhFYTEn3v3JkQZaTal0wWDusUfV/6yoxepmmk2RI++NNUNyYEs8kMyAHQ0
	yHiWTAyPR9uj/JANbpWwBGrb04EMryDAOGbO44k24IY+sav3oAIkvmRDDugKtwNt
	7RLI8l5Q3Wv0FBYnJWUy1opzsCvcHkWiDvY+DMNNupLhdir6VTCRrC7pCwyT179K
	7WTJJTUoYWphcKwau/oLiRTqdUEmo/QymI+2Ulz3cc6kfkKF4UJ0iFpZVK7U07ja
	op9ovQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xte0v59n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:55:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UGtBiZ013167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:55:11 GMT
Received: from [10.110.91.1] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Sep
 2024 09:55:06 -0700
Message-ID: <b5487e8a-53d8-441c-8752-ce6af93e12a3@quicinc.com>
Date: Mon, 30 Sep 2024 09:55:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
To: Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)"
	<linux@armlinux.org.uk>
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
        Jon Hunter <jonathanh@nvidia.com>,
        "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, <kernel@quicinc.com>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
 <20240927010553.3557571-3-quic_abchauha@quicinc.com>
 <20240927183756.16d3c6a3@fedora.home>
 <048bbc09-b7e1-4f49-8eff-a2c6cec28d05@quicinc.com>
 <20240928105242.5fe7f0e1@fedora.home>
 <ZvfQw0adwC/Ldngk@shell.armlinux.org.uk>
 <262e7702-68aa-40c9-aa2a-60a18b7f747d@lunn.ch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <262e7702-68aa-40c9-aa2a-60a18b7f747d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _qBGpYm9xQ82m3PNGVxwuEoc2SWevr2g
X-Proofpoint-GUID: _qBGpYm9xQ82m3PNGVxwuEoc2SWevr2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300121



On 9/30/2024 5:18 AM, Andrew Lunn wrote:
>> I think this is getting overly complex, so let's rewind a bit.
>>
>> I believe Abhishek mentioned in a previous review what the differences
>> are between what the PHY reports when read, and what it actually
>> supports, and the result was that there was not a single bit in the
>> supported mask that was correct. I was hopeful that maybe Andrew would
>> respond to that, but seems not to, so I'm putting this statement here.
>> More on this below.
> 
> Yes, i did not really realise how wrong Marvell got this. As you point
> out, it is more wrong than right.
> 
> My thinking with calling the usual feature discovery mechanism and
> then fixing them up, is that we keep extending them. BaseT1 has been
> added etc. If a PHY is mostly getting it right, we might in the future
> get new features implemented for free, if the hardware correctly
> declares them. But in this case, if it cannot get even the basics
> mostly correct, there is little hope it will get more exotic features
> correct.
> 
> So, i agree in Russell. Forget about asking the hardware, just hard
> code the correct features.
> 
> Sorry for making you do extra work which you now need to discard.
> 
No worries, Its better to discuss now than to regret later. I will 
make the changes accordingly and raise v5 today after testing. 
Thanks Russell/Maxime/Andrew. 

> However, please do keep it as two patches. It makes it easier to deal
> with regressions on the device you cannot test if we can just revert
> one patch.
> 
> 	Andrew

