Return-Path: <netdev+bounces-160362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6462A19627
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D3D3A3C19
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFCC214A60;
	Wed, 22 Jan 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dy+rNJJd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF99211475;
	Wed, 22 Jan 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562212; cv=none; b=ouxv7DBPTHZvyadEubsZydi5+ehSk9uHCOD22fmLCRTNoLGQTDVfms1koWF5RsaSY9kW4tFNY9fX6XFK3cG8+WTwXmxlEKxovqHMrxaS5dUdb3uta11UbJGIEDuIF8mjtHo8TlGs+iMgI50Xbv3/ITVbVQ91wHoNakgqC70mRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562212; c=relaxed/simple;
	bh=aqdibNwe76PSAV24tw255yBtzuvhkL3OJVGpjLrtZ3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OHCYfhN17GeWwc/JbGjkaQGhFeCjkXWwNK2Y1n8ms2v0CzXKFbMviN65/pTQpdE96Jr/JJkUC1bF+OhvTfCUC+GKDWVwryCHeg3ejYO/eX3aax8K+PGAxBdT8pvUnyNV2zJDbn0nrvEd+0a9bmwMMvC8JBrNpmmdN6RGcC470lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dy+rNJJd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFeuLY014610;
	Wed, 22 Jan 2025 16:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WDDwYV
	o0oK2H1oE/7TU1Y5wqdTMMwE7SymsR+ajnAVg=; b=Dy+rNJJdobcKvZSl4vp36d
	iLzpako95A25bRk04GuElVB/AkmvGRkIT3eyWJE743t6oC7Kd6rf41e4GUNghbqO
	oaII0U7LyHmEcQrNkE07hBAIAuBBYnm+2dRkEo2ogdbT6T3TSCU8n7WqXfpjBbwC
	X652XyVz9s1gqPBdJiWDu2DgBpngEQiZcMEir2k+Fnh7mUVOdlofztg8tzwsjDxJ
	N9bcSGx1hNVjxYdibt7ULxWCulVqu2tUUW6p7xk+AkIvuL3XNH03IIv8fq97Xlif
	BGafs5OmTryk0/YBZQX96mgAf4UvlAYdsA3WQ2y+LPa+hnbJuZgOiKyGn8mcFaXA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44atg82wnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:09:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MG5OR2021615;
	Wed, 22 Jan 2025 16:09:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44atg82wna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:09:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MFR5QW021012;
	Wed, 22 Jan 2025 16:09:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1gtpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:09:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG9bvo27984592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:09:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A4C558050;
	Wed, 22 Jan 2025 16:09:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C8CF58045;
	Wed, 22 Jan 2025 16:09:36 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:09:36 +0000 (GMT)
Message-ID: <7a5bc530-e0f1-4eff-b94c-84d2085014c1@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:09:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] ARM: dts: aspeed: system1: Disable gpio pull
 down
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-11-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-11-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3M9PPVUxmKAK6536TZfitgZEgaK3q5-G
X-Proofpoint-ORIG-GUID: xGldRKnDKFDPJFO2rv_gc2eeN72-t08S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Disable internal pull down for the following GPIO lines.
> - GPIOL4 - Reset PCH registers in the rtc.
> - GPIOL5 - Reset portition of Intel ME
> - GPIOL6 - FM smi active
> - GPIOL7 - psu all dc power good.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 9abbad07c751..3cf45a39acbe 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -355,7 +355,35 @@ &uhci {
>   	status = "okay";
>   };
>   
> +&pinctrl {
> +	pinctrl_gpiol4_unbiased: gpiol4 {
> +		pins = "C15";
> +		bias-disable;
> +	};
> +
> +	pinctrl_gpiol5_unbiased: gpiol5 {
> +		pins = "F15";
> +		bias-disable;
> +	};
> +
> +	pinctrl_gpiol6_unbiased: gpiol6 {
> +		pins = "B14";
> +		bias-disable;
> +	};
> +
> +	pinctrl_gpiol7_unbiased: gpiol7 {
> +		pins = "C14";
> +		bias-disable;
> +	};
> +};
> +
>   &gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpiol4_unbiased
> +		&pinctrl_gpiol5_unbiased
> +		&pinctrl_gpiol6_unbiased
> +		&pinctrl_gpiol7_unbiased>;
> +
>   	gpio-line-names =
>   	/*A0-A7*/	"","","","","","","","",
>   	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",

