Return-Path: <netdev+bounces-130980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3998C50B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F61F23CFA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639351CC178;
	Tue,  1 Oct 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GWC9zxHF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870C1CB528;
	Tue,  1 Oct 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806008; cv=none; b=SwvIhLFGL/ixRElewld4tE+dYZwyc4ZO6PONnS3QJH8kSbXyOAydMTUK1Kpg/B7EkRFPKw24IDLn04elI/zSY2iRaoCDFuOzZSveU688sa8Z2YL7v9EtAxfllm5oOzffK/dHYd3JVkp19gT5JoGieQL2v7L+jQym0+fDhuaGb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806008; c=relaxed/simple;
	bh=sGERUoRBGIn3s+1m0KNjKqF37uQb1Q2AWGvBDUyHOSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ONg10sxWRnfGhFe2wveMrwo3T8txr8ZfcYMHll0+EWlprzAmf3pZNo5U+22vSsiekOwgGKsj8WJJ3rKOe4UsObv4mm/ogDY2NCdH3x8T+LxghZk7PXcJvkWHQnAV5FR4DSN8YrV6hAMPxcI9A/IAR8g+936bWfSIRuzF37IOclc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GWC9zxHF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491C0J6r024372;
	Tue, 1 Oct 2024 18:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sttvC99VzBQWS7KIJuP8gcEc/RE4hjyzzWLScjWVS6M=; b=GWC9zxHFY9fUIoVQ
	BzmjUCpSSqhmERIQs2t1kkkssNSH+pCiv9LsLi70iobg2PXUfLTYDUdyzMLqZ13g
	IYBwvIgJgZcEiyveUYTHlP5QeiPWsc/VmCSxIv+BiHzlCLW/epL67Mfwm+JZ2Rgs
	D7WPz2O8GCB06ZVurdRY90OEXDZs1Br9K3vvJ5X6irtuV00XZKOxu3eGHXzimZ+Y
	FQqxKzt+xkYd8ANF0ueHBCxbxE0KWPIB08cSxtSzlLuLQiF3jB/DFadLpXDnJngQ
	EvnX44um6UxijMNy2+InOXGq56kAuIIa+w0wNmUlkffNclXNv814X2xRZLPicG0L
	Gyws4Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12sbwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:06:28 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 491I6RDq020347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 18:06:27 GMT
Received: from [10.110.91.1] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 11:06:23 -0700
Message-ID: <2a79c0c7-710d-4037-9e90-b9a677e3ebe1@quicinc.com>
Date: Tue, 1 Oct 2024 11:06:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
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
References: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
 <20240930223341.3807222-3-quic_abchauha@quicinc.com>
 <Zvvkd1Xi4/rmWQRf@shell.armlinux.org.uk>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <Zvvkd1Xi4/rmWQRf@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W1z64i67pvtaM-JLtsdQzfrzZYFNP4GM
X-Proofpoint-GUID: W1z64i67pvtaM-JLtsdQzfrzZYFNP4GM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010117



On 10/1/2024 5:00 AM, Russell King (Oracle) wrote:
> Hi,
> 
> On Mon, Sep 30, 2024 at 03:33:41PM -0700, Abhishek Chauhan wrote:
>> +static int aqr111_get_features(struct phy_device *phydev)
>> +{
>> +	/* PHY FIXUP */
>> +	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
>> +	aqr115c_get_features(phydev);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported);
> 
> More or less same as the previous. The comment could do with shortening.
> I think for this linkmode_set_bit(), it's not worth using a local
> "supported" variable, so just put phydev->... on the following line to
> avoid the long line.
> 
Noted!
> Thanks.
> 

