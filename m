Return-Path: <netdev+bounces-130979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25798C509
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F74B21E51
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8815A1CC165;
	Tue,  1 Oct 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="URUofUrO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187541CB528;
	Tue,  1 Oct 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805999; cv=none; b=ViOALA23BCj2AVZRHn8b2ee1AnRHoMbF+B26tFpAFRmIrkawUFy9iUMQa/rUJKtBSxteY5UQlg7ITsjf/m8O5gQ1n2jpUZc3WzJLV5IyqvQgDyjoCr2nXv/vCXxYWA/5nTtFktgVsfORWlVBXfk9IYeuecSs5gpXB9UfOTbMVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805999; c=relaxed/simple;
	bh=6/MO39JnjWeIgiRIR44AEBoR6NPVsoucyxdQqwTL+ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dYX2LCFt8nPYY9iteU8ZxkbXQamyno1szJ2nF89usi+hcbVOrlWxvsxDTcuOLGvg0663yqZi0FTSxV4IPXQnA8OxKQsQrfp6yeIATKNvKpLZ7ghNC401noLYZcQft0yQM5XFux4sS+RuwCOnwSrT8T6iIUORS0rk/0nbo//LsIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=URUofUrO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491AQF6G028588;
	Tue, 1 Oct 2024 18:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G8F1tU4tCgdTNbi4TeKMYFZ5lELSisS1ZXqy7flYE2A=; b=URUofUrONrK32vXK
	5X5DpYhWLQyymig7f+HdYYB52CiBrNtMK/x2P6DkOYJts75N/kJzd4z+GDV05DLr
	C7y4r2pJM2pbGVOy3GF9F7p0grUtqfKvGUexZbzJdoG9hEPx9rU3T7MkKZpWKFWW
	7icOPjrfc5nu4uokUVF/ogtsg7oEiUsezJ3c5Cf/GEdlrk+9MfzcLIv4e8nGkfTT
	Tq4aH8EFtuIPm2t62biscUmmzoQFx/bD4BjTafhEwNDlIZiJY3R89mQQxqZK8odL
	fqjbG675oR6FYKa5SBj27VScuLGMAltKLTICWbdJqQHpllgubUIlLUG1jjpqMNdY
	bV+bAw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xajfh7ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:06:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 491I6C6a002211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 18:06:12 GMT
Received: from [10.110.91.1] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 11:06:08 -0700
Message-ID: <56d123a3-542e-412b-ab15-ab29b49fe40e@quicinc.com>
Date: Tue, 1 Oct 2024 11:06:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] net: phy: aquantia: AQR115c fix up PMA
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
References: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
 <20240930223341.3807222-2-quic_abchauha@quicinc.com>
 <ZvvkEYYljV4IWlJH@shell.armlinux.org.uk>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <ZvvkEYYljV4IWlJH@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FxaeJUElWfXjfxb36mevXhN4kNa19rHI
X-Proofpoint-ORIG-GUID: FxaeJUElWfXjfxb36mevXhN4kNa19rHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010117



On 10/1/2024 4:59 AM, Russell King (Oracle) wrote:
> On Mon, Sep 30, 2024 at 03:33:40PM -0700, Abhishek Chauhan wrote:
>> AQR115c reports incorrect PMA capabilities which includes
>> 10G/5G and also incorrectly disables capabilities like autoneg
>> and 10Mbps support.
>>
>> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
>> with autonegotiation.
> 
> Thanks for persisting with this. Just one further item:
> 
No worries, Russell. Thank you for your guidance. 

>> +static int aqr115c_get_features(struct phy_device *phydev)
>> +{
>> +	/* PHY FIXUP */
>> +	/* Phy supports Speeds up to 2.5G with Autoneg though the phy PMA says otherwise */
>> +	linkmode_or(phydev->supported, phydev->supported, phy_gbit_features);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
> 
> I'd still prefer to see:
> 
> 	unsigned long *supported = phydev->supported;
> 
> 	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
> 	 * are not useful.
> 	 */
> 	linkmode_or(supported, supported, phy_gbit_features);
> 	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> 
> because that avoids going over column 80, and networking prefers it that
> way.
> 
Noted!

> Other than that, the patch looks the best solution.
> 
> Thanks.
> 

