Return-Path: <netdev+bounces-50780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4667F71D5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027D2281D8C
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC9A8BED;
	Fri, 24 Nov 2023 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kH4UucPe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70B92
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 02:42:48 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO9n8OP004670;
	Fri, 24 Nov 2023 10:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JhiWrn/spMGsQgphTKY7Pf/ETC6D6K2KEURl5eeKDKc=;
 b=kH4UucPep9By8Jl8M2eBIv8kWYpnWtjuvcEFq0SgD1GMTQYhPMNk/TT6vb2/5qKCCMQG
 RcmX1qdHzuksGtyeRl+xlrDMY3XV1qQ633JCxySV8Di6XawwqqH59VbSPoo9xibe63vo
 7KdL6wwrzSzQK79gUSDjKrG9wR/drjBvDAfWA8zoZvZJTny0OSdO32BvZftmmSQGWeCU
 Qa9AEa8wNoWsZ5ZH5l1AHlFEX9I+svMpha8FPJDlUfcAoNFA7F4FxREjGsaIoaQHHIgT
 nMed/ktDwN3Y2us8+l2gDEjeDX4yhBCAzMWzvG+KOIaQJyWhqleQQTK7GvKOyBKY3FJW oA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj4hwjm21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 10:42:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOAgZO2007028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 10:42:35 GMT
Received: from [10.253.33.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 02:42:32 -0800
Message-ID: <d1521892-f891-430d-8d4e-f229231fbe96@quicinc.com>
Date: Fri, 24 Nov 2023 18:42:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] net: phylink: improve PHY validation
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7-Cymxz8bkQowSbVmdy4gWtL_j_GRqPR
X-Proofpoint-ORIG-GUID: 7-Cymxz8bkQowSbVmdy4gWtL_j_GRqPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240084



On 11/22/2023 11:30 PM, Russell King (Oracle) wrote:
> Hi,
> 
> One of the issues which has concerned me about the rate matching
> implenentation that we have is that phy_get_rate_matching() returns
> whether rate matching will be used for a particular interface, and we
> enquire only for one interface.
> 
> Aquantia PHYs can be programmed with the rate matching and interface
> mode settings on a per-media speed basis using the per-speed vendor 1
> global configuration registers.
> 
> Thus, it is possible for the PHY to be configured to use rate matching
> for 10G, 5G, 2.5G with 10GBASE-R, and then SGMII for the remaining
> speeds. Therefore, it clearly doesn't make sense to enquire about rate
> matching for just one interface mode.
> 
> Also, PHYs that change their interfaces are handled sub-optimally, in
> that we validate all the interface modes that the host supports, rather
> than the interface modes that the PHY will use.
> 
> This patch series changes the way we validate PHYs, but in order to do
> so, we need to know exactly which interface modes will be used by the
> PHY. So that phylib can convey this information, we add
> "possible_interfaces" to struct phy_device.
> 
> possible_interfaces is to be filled in by a phylib driver once the PHY
> is configured (in other words in the PHYs .config_init method) with the
> interface modes that it will switch between. This then allows users of
> phylib to know which interface modes will be used by the PHY.
> 
> This allows us to solve both these issues: where possible_interfaces is
> provided, we can validate which ethtool link modes can be supported by
> looking at which interface modes that both the PHY and host support,
> and request rate matching information for each mode.
> 
> This should improve the accuracy of the validation.
> 
>   drivers/net/phy/aquantia/aquantia.h      |   5 +
>   drivers/net/phy/aquantia/aquantia_main.c |  76 +++++++++++-
>   drivers/net/phy/bcm84881.c               |  12 ++
>   drivers/net/phy/marvell10g.c             | 203 ++++++++++++++++++++-----------
>   drivers/net/phy/phy_device.c             |   2 +
>   drivers/net/phy/phylink.c                | 177 +++++++++++++++++++--------
>   include/linux/phy.h                      |   3 +
>   7 files changed, 353 insertions(+), 125 deletions(-)

Tested on qca808x PHY, the interface mode switched between sgmii and
2500base-x.

Tested-by: Luo Jie <quic_luoj@quicinc.com>

