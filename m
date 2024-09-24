Return-Path: <netdev+bounces-129568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FA984877
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EB21F239A0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A31A76C8;
	Tue, 24 Sep 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rlwek4s3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E941DFED;
	Tue, 24 Sep 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191114; cv=none; b=mPv1gVNezTJ6OHuTiT8BIgbKwn8QCqSKyjPiLPtki5f4DEKEvddGjPYBg3dumG/sM7KA8oE6ahdjFjPwkIq8/kQdIQPLBkFiV/FZssmUZZS1J/eiNEbV/BYRIw8BukvypgSTYCxVc44S+U2OSMciEQ1qrVoNNQiwqvxeIUgmuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191114; c=relaxed/simple;
	bh=kwMTyHtFYwABX9RFKg4vFzbdjIn5oapsafa3opbpdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kggAiAYnDYBPCCyZsjPcc9dUX92Q3lKrUFduN6Bs77AfbgXehgiMp7f0CvQBiqCFPIK/QAsDKINkYHLVMNbs2ltB41alaqaMOJGuUxONw45nEdXOihE7IlsiCRk2PwWQ1tM/nFAK9u2JD2XgHI+9W1WV7hKrepytglVpPTr5XuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rlwek4s3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O8M6q3002767;
	Tue, 24 Sep 2024 15:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CnXtyxiO++ZkvhDWikuQrDJGcEzI/77Yntd8OAwv0tw=; b=Rlwek4s36cYkaUB6
	21i/j1Rq9d6WmzJdnOv60EOvqLr+a64BfqLOij/tbQwDhcN5dWq/uG11w1ZEMc1G
	zAZfbvLr48QGC6wWX2/m5DDQs9UETo5J91NWcxcAd7HEFKD6k7fDCkjmvF/ooXwY
	vjvJBb1aicDzHo80Qpwx/4yvdXil3PuCACrq1ImM+gVq6S3lVdZAxl0ShGUG313Z
	B9XdbQMx6qmxgi2LH1LkEuTyYwR+gh7pDJO+kx+yXwYXAXoXhVk9eqUUC1ZTysN2
	7hkLd+YgyGg8SMQO2PMnd2WOvIV7Dh204tt3QyQ+ZgMa3U6xNf1KFSXE8+clHfU8
	FUHmrA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh17t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:18:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48OFID8w010726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 15:18:13 GMT
Received: from [10.110.100.83] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 08:18:09 -0700
Message-ID: <a6b9a56f-4bf0-44f3-bfca-f75bab1c1ca9@quicinc.com>
Date: Tue, 24 Sep 2024 08:18:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: aquantia: Introduce custom get_features
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
        <kernel@quicinc.com>
References: <20240924055251.3074850-1-quic_abchauha@quicinc.com>
 <ZvJ582mUDIIooMzm@shell.armlinux.org.uk>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <ZvJ582mUDIIooMzm@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pP0oEsKKK_cOMyC1nBof9kVCtKxRwGtr
X-Proofpoint-GUID: pP0oEsKKK_cOMyC1nBof9kVCtKxRwGtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=893
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240108



On 9/24/2024 1:36 AM, Russell King (Oracle) wrote:
> On Mon, Sep 23, 2024 at 10:52:51PM -0700, Abhishek Chauhan wrote:
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
> 
> Maybe consider using:
> 
> 	linkmode_copy(supported, phy_gbit_features);
> 
> It shouldn't be necessary to set the two pause bits. You also won't need
> the initialiser.
Noted ! Thanks Russell. 
> 

