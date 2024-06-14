Return-Path: <netdev+bounces-103575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE3908AFA
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE36428B321
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C1195B27;
	Fri, 14 Jun 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O/PecpHq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F341190477;
	Fri, 14 Jun 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365412; cv=none; b=GeC1ZfhTqTZ1oi/CDC6KADwOEKEFzPvFqHk6U2xOzWtLSv9ZoBlVghqHdhO2JMlNCcRJUCPRgtGZzGEEMM7lbZtVRsvI71quzvGJjxwdiVtuoT8er68p3S/h9hAACP1q39/WLUBw+FY/9byUXZOlOpCBycXk87oj35B/r1RaN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365412; c=relaxed/simple;
	bh=k4jOz68cr3QBxL7jfiU33d7ijkFWxyUA+lWLMTbTPew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hLFBLM+tENEXlwoRuD5WKBh+sm4nMRKZQe5eSPVZz5udpuw4Dz8EWkaX4rcA86Bl9Ig3V/O540MPlCpad5RKs5sh8qf9c2Qzbq7oEStbUFrKnDsd4PNltuONw3xkvXalvSXsmoknZJZSHhzD53yFt1/gCBWCT+Oa+QJ554yhg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O/PecpHq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E8qgmD029245;
	Fri, 14 Jun 2024 11:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5A4qaAHQTdpQy2ZjCteC8YaOj/mS8IZfor+Tma9QTGU=; b=O/PecpHqRfCKkCNt
	rBHjQBgsvqIfBbKRKYhWJYzPOYV58qmmz8lRtO9hRDhrgpk2jSNXKa8ST0alBUWF
	jc1xsVwNpvUK3aDsZC3NG09HdjY0+jcd5W+TEh6Azg1W0ehfRI41C2umdJAqt+0U
	+c2Kc31zODMDzfHM3NBsbEj5YUeOeUVfjbY8dqMib3dsReZsZEf0Fn4nbKO2Puna
	XuhSm1N/MV4ayPznA8cufLGNFqTm8yVsQIFmvKkpe+LU+Nbn7WGWIQ3Yj86Lw0Fy
	xfRPK1WEB2Z541sQJ43vvz+dv0sQlet3lNGpPxFiUcLOAgtsIbaSFfI45PdmUY+e
	K2ipHQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q29r9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 11:43:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45EBh34k027519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 11:43:03 GMT
Received: from [10.253.35.41] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 14 Jun
 2024 04:43:00 -0700
Message-ID: <7f54113a-e2b4-4b7f-91fb-7e60af9ec2cf@quicinc.com>
Date: Fri, 14 Jun 2024 19:42:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: introduce core support for
 phy-mode = "10g-qxgmii"
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <corbet@lwn.net>, <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20240612095317.1261855-1-quic_luoj@quicinc.com>
 <20240612095317.1261855-2-quic_luoj@quicinc.com>
 <Zmqlvn2gOlxoy5Gm@shell.armlinux.org.uk>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <Zmqlvn2gOlxoy5Gm@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2NzmHcTlbFTFW6drlpWeEcwMADFybwRz
X-Proofpoint-ORIG-GUID: 2NzmHcTlbFTFW6drlpWeEcwMADFybwRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406140081



On 6/13/2024 3:54 PM, Russell King (Oracle) wrote:
> On Wed, Jun 12, 2024 at 05:53:16PM +0800, Luo Jie wrote:
>> @@ -1865,7 +1872,8 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
>>   	if (phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
>>   	    state->interface != PHY_INTERFACE_MODE_RXAUI &&
>>   	    state->interface != PHY_INTERFACE_MODE_XAUI &&
>> -	    state->interface != PHY_INTERFACE_MODE_USXGMII)
>> +	    state->interface != PHY_INTERFACE_MODE_USXGMII &&
>> +	    state->interface != PHY_INTERFACE_MODE_10G_QXGMII)
>>   		state->interface = PHY_INTERFACE_MODE_NA;
> 
> It would be better, rather than extending this workaround, instead to
> have the PHY driver set phy->possible_interfaces in its .config_init
> method. phy->possible_interfaces should be the set of interfaces that
> the PHY _will_ use given its configuration for the different media
> speeds. I think that means just PHY_INTERFACE_MODE_10G_QXGMII for
> your configuration.
> 
> Thanks.
> 

Hi Russell,

Yes, for QCA8084(pure PHY chip), only PHY_INTERFACE_MODE_10G_QXGMII will
be set to the phy->possible_interfaces when it works on the interface
mode PHY_INTERFACE_MODE_10G_QXGMII.

I will push a new patch series to remove PHY_INTERFACE_MODE_10G_QXGMII
from this work-around validation here.

Thanks,
Jie



