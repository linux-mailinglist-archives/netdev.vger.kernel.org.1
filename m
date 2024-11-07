Return-Path: <netdev+bounces-142782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41309C056C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F3B23233
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9420F5C4;
	Thu,  7 Nov 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dJc8nwBW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2B1EF0A2;
	Thu,  7 Nov 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981600; cv=none; b=eNvFnjUvTvso+BEWc5TMh2MbHBR5Iga0/Fxujf+fzkOvNBTEU40ouq4VTOKqThP+8v+fkUUJXUx3soXCu5f+fFuL+YvSvVIa070DJUsp41PPhfngqkNVTigpO7guN9kyNt/zZclEYHR9NTHemBE55xp7GjhrYPhoA+vR3hz3a5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981600; c=relaxed/simple;
	bh=5HkENyU/mXnI0vymwFwn4toNd8urotXCsTDg5G3NN4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjOfgndzHy/fhqgXlsfKS3Lf5ReYWLE8ndZlyXTrZvq9Z7ixNCBwsC+WHi7VFvXTNnnf46ffi/Ww6jE85mYzxk5EfgfK3Do9KCzlqyM/w5389jlagO+BkkGDEiSLgh/M1vGdUxDA7plv027H19lOyFZXde9oYqYG/ti4pLR4lIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dJc8nwBW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A77lu5d024485;
	Thu, 7 Nov 2024 12:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGrvKO6WetQbAviRFql6yE789UtuDEEjlFlK9GG7xJc=; b=dJc8nwBW+Xqp9ui5
	7tZI2M/jti/iRHERq1kOUhlHsI2+e8382wIZzZ7Kl44UG8ogxE2jHnQiiCKuE1RQ
	16js4JZH71QeC4g+KYfQDl9E7rRywYZ+OL3CsgeTbFrM/+J+bUlwpjZlLa1TaJ7i
	yGIu5oNBH0epCZnjJg8tcFJHjjzVmfGwP9fSJRZifkcxW3TSprUg9jumbv96YUtN
	L7bFl9V92/YKUEz5lhAMYgr5TqecKPAIoLgu3iZsL+AxUWWjEJFp90lx/RWBXPvV
	VIBXRNAZwaGPErjuA599kn6Cdk2u1C0qQN+oLvEJ7KS1M4V221i2jOXnOmQLjEcT
	Ta9MnQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r2ugvbtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 12:13:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7CD16s018925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 12:13:01 GMT
Received: from [10.253.8.252] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 04:12:56 -0800
Message-ID: <9b2c6c35-cb72-4680-a59e-8515a3995b53@quicinc.com>
Date: Thu, 7 Nov 2024 20:12:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: pcs: Add PCS driver for Qualcomm
 IPQ9574 SoC
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_luoj@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-2-fdef575620cf@quicinc.com>
 <8f55f21e-134e-4aa8-b1d5-fd502f05a022@lunn.ch>
 <ec76fc73-79e5-4d09-ac4a-65efa60874fe@quicinc.com>
 <3677dee8-f04f-45f0-8bfd-dd197ec71616@lunn.ch>
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <3677dee8-f04f-45f0-8bfd-dd197ec71616@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BKT4tY0CMCeKZLvKV3u4ijDo1OTf-Omg
X-Proofpoint-GUID: BKT4tY0CMCeKZLvKV3u4ijDo1OTf-Omg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=556
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070094



On 11/4/2024 9:43 PM, Andrew Lunn wrote:
> On Mon, Nov 04, 2024 at 07:14:59PM +0800, Lei Wei wrote:
>>
>>
>> On 11/1/2024 9:00 PM, Andrew Lunn wrote:
>>>> +config PCS_QCOM_IPQ
>>>> +	tristate "Qualcomm IPQ PCS"
>>>
>>> Will Qualcomm only ever have one PCS driver?
>>>
>>> You probably want a more specific name so that when the next PCS
>>> driver comes along, you have a reasonable consistent naming scheme.
>>>
>>
>> We expect one PCS driver to support the 'IPQ' family of Qualcomm processors.
>> While we are initially adding support for IPQ9574 SoC, this driver will be
>> easily extendable later to other SoC in the IPQ family such as IPQ5332,
>> IPQ5424 and others. Therefore we used the name with suffix '_IPQ'. Hope it
>> is fine.
> 
> So are you saying after IPQ comes IPR? And then IPS? In order to have
> a new PCS design, Marketing will allow you to throw away the whole IPQ
> branding?
> 

OK. We will convert the name to make it more specific to the 
architecture. 'PCS_QCOM_IPQ9574' can be used to signify this type of PCS 
within IPQ SoC family. The driver will be re-used later for other IPQ 
SoC using same architecture, with minimal driver extensions.

> 	Andrew


