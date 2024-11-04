Return-Path: <netdev+bounces-141514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EC9BB31B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D81C203AA
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA5E1B3924;
	Mon,  4 Nov 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M7koPf3j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FA1ABEC1;
	Mon,  4 Nov 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718922; cv=none; b=euK3yUE1vJRMXKK1E559s8ygTrAEf0paYzKDXclfmHT59+ENct1yWr+mb3Bq29aLDnq7rMR32a62r9WY8YdQO+C4mKlKUp2EGrvS2oM25MQAiQmMBW2W8NOi8aOiLs/L1BRiJi7/7HTZ7HxZ1/m7kFgnZGxKjit+dARICkbXBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718922; c=relaxed/simple;
	bh=2gIlUI7PdKKTWDXTSzufN9sRX+NITpJDNOa8IuBIsUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VvDUsLm0sZTGEO4Cpw7x6wloGLm9jknC8v8oA34T8340fCzThiMyLUMZJQ2L8zqGThZ5HvYNrZP0mZWurQJS6XvoAi0Q4Y73EabTxkD0cKtMO4CuAiW+2TK2760xCFRdIwGQqBcb5m2hF36eKAnR0r2KNZZ0Xc3xQVdrh6o6HgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M7koPf3j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BB2rE020115;
	Mon, 4 Nov 2024 11:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q3KRPy89viz3fpcXqHpGWIgbjdIp9ffw2rFAz7KIa98=; b=M7koPf3jiKP7Xa6+
	Q2xvzqKsxD9J4bgoccS0smZQf0WaUEsQiBlwOAuxRFkQ8da6odFjuv2NJkQz1GlT
	HK2Zi2lJTNDxHTyxSGgMzfbjpAemGrXM0vSv1acuDAIqJK1cC1kbDZlpPsK8udGD
	FWRhQ/NxkKIBhM+WfiSn1SbGTM+nrwH2R4WE+GTjfpojvYzqxkWjf/vkacOGz8/F
	GATw/lN2TrRK914tDrEt7ld1F5yPPbAGSiN5FSBlVgq3CLWqCTddk4qTWyMdWydE
	+TuLGaSd7r0082OYzAIOIq8FRs1fRJ9ug9e3sV/0WjcmsHI7xIIbGotMn6l1Nt32
	FGHUeg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2s3yf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 11:15:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4BF6jQ029070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 11:15:06 GMT
Received: from [10.253.14.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 03:15:01 -0800
Message-ID: <ec76fc73-79e5-4d09-ac4a-65efa60874fe@quicinc.com>
Date: Mon, 4 Nov 2024 19:14:59 +0800
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
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <8f55f21e-134e-4aa8-b1d5-fd502f05a022@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UHj-c7Jyh7MmmH0s4H82Aix-xfWtWL40
X-Proofpoint-GUID: UHj-c7Jyh7MmmH0s4H82Aix-xfWtWL40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=622 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040099



On 11/1/2024 9:00 PM, Andrew Lunn wrote:
>> +config PCS_QCOM_IPQ
>> +	tristate "Qualcomm IPQ PCS"
> 
> Will Qualcomm only ever have one PCS driver?
> 
> You probably want a more specific name so that when the next PCS
> driver comes along, you have a reasonable consistent naming scheme.
> 

We expect one PCS driver to support the 'IPQ' family of Qualcomm 
processors. While we are initially adding support for IPQ9574 SoC, this 
driver will be easily extendable later to other SoC in the IPQ family 
such as IPQ5332, IPQ5424 and others. Therefore we used the name with 
suffix '_IPQ'. Hope it is fine.

> 	Andrew


