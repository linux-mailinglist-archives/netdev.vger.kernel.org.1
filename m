Return-Path: <netdev+bounces-161918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A541CA24A07
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540051884C1A
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EF1C2324;
	Sat,  1 Feb 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bt428S+3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804A1ADC68
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424912; cv=none; b=Uht09vhUdUsPRaog8T6k330MOZQ2gUfBz2YfbhpM9UaOirJ9vxA+xdmZTjfsnCC+daHsZPshyWTVB2V4ExLv7IQTH3+MdZ6FA738lFglMWiEsPUkkyRpnklyahbe4n3tVoKH1DK2auTZpXhSTrY2I68jkAWX3e+1pW8Gn0dMrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424912; c=relaxed/simple;
	bh=uSGnFtAub3eoq47/irBf/Ues9kJZ2R7qUHvedd7kXcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIe3TRfCzFpUrtGA1S4rtVjsGvDwajIXDarR8yBlHu/zY+LRm1YMLvsVMm0gcrxu7/WvtZ79TzRXqul/OXab2g6Q0juy+17tDweuIdFz674ikIsFiGSkJ33DpNwXZu140kX+uhBGjS7yrMiUc7oOLzoop09HR8aM488XI/yMubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bt428S+3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51180Lat002032
	for <netdev@vger.kernel.org>; Sat, 1 Feb 2025 15:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8n2dQUsAQR8BGbcIRrC/eRUMfmfG1kg18Uqsc42/YA4=; b=Bt428S+3uxH+vEzk
	tnDluDLTVPQSs6ciBolYDkA7uHbbln9oqYOG57YImHkpp5ZMl0letkUDsP/aA7q1
	+4zexevqo/jQRGjiTXd/TwV2XHBkO6VQAYP66XLS+JbTc7QJEvjsHI/fqRuLT5ko
	5SoZO4pbhbCOpqjWnSZ6u7VcxE0jfnGnQbSwntG+h81k4saZ3Gzi1VYMbjw37+uC
	W9KapccKfQZ+KguK95pnyNCX2DgSq50Fa+z2a5yPt5QK4FvsfuL1S42I8YDKj3cp
	8ziqcu38WFZf5AZjyljX+qjL5ndVD6BqWaZF1SGTL41eVf6tAQSbl1NdarzHlQf3
	c3ri6w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd6b13fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 15:48:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e20cb2ce4bso8978256d6.2
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 07:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424909; x=1739029709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8n2dQUsAQR8BGbcIRrC/eRUMfmfG1kg18Uqsc42/YA4=;
        b=IhKgYyyccLhX8Qzi73DvFE1X5IAiLCnywILLJyeA6mYt96l5WMwK7vBF4f9IbM/C+s
         G9GROn8GikfTeyLrac2PJ9TE7047K0QiaMe1dS3GV4djBUbnEEiqnLDa0vNNRq8IIZJ5
         tpbIo5UUFM8Oap/ToEanwKvzmYVYkbAoGZ8gsHY9htqWAXiAFGou2RZ1qf6hSP0zQpE0
         pJJjBRHxHo5suLLEGgy7SOHn80SmfDNAau0a+Ma57ruLEXjYv3z8oGRtsq1kVKapDik1
         wrddLDLrJPUh1XMi9KV9CU/uE0kdrG8hPKltl/XRIslkhMi/+cDPleYT29CYtOj/Rq3p
         wu1A==
X-Gm-Message-State: AOJu0YyqdTU2KRcGAXtUqsUp9GaEGx7JoijDQ5Sz81OAf/OJ1QLIVRha
	h5TVHRfKTl1zQw3xmSoMvxvZdDpk6D9iUJQsbBXPabnRHfj7CsOnQke8fk5wg7h4M2ohQYs5COm
	688igfMGrZJe+h19+pWj89rJBccG0qVV/vGmvrrSEfOkVGfY++QRJkEs=
X-Gm-Gg: ASbGncsrUX17XHaO9j3zDxVcxh1i4GMu9wude+LShH6318yPxPBN30001xQp2Q312BV
	fpi6iNt15XCYk4IXvbv+AbnMtnSB0YcIfVK5lGIf9k8DRxdJ7GOGveV192uzJ6aYiTMEJZcXmsi
	vRaZajw23SYVk0vr8n5WyBK2WBiwgyE6A78IOwNf/hQj9KsbyKC9DHDXXtAWJjJSVbe/pLu3Rae
	2OynmdZXk2xa+RLB+sEdYm42DZuCjHadCAk69H2NrQdheK7A+WFzbghHOSp85UKYHswLRaFEugx
	b3xMMTixDck3PVHZ9vQJrLDxw8aVTmmts51m7wrIDh+1vDF3DGJ7//FkGGI=
X-Received: by 2002:a05:620a:44ce:b0:7be:5020:6df1 with SMTP id af79cd13be357-7c009b93599mr574152085a.15.1738424909326;
        Sat, 01 Feb 2025 07:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxPpR9kTBzdbY+SmZntvSpbA0AmhKdf4LITbXaMdP95XvejXet1vO1PHrcj+dARpvQVLwZIw==
X-Received: by 2002:a05:620a:44ce:b0:7be:5020:6df1 with SMTP id af79cd13be357-7c009b93599mr574149185a.15.1738424908921;
        Sat, 01 Feb 2025 07:48:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff269sm453716666b.118.2025.02.01.07.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:48:28 -0800 (PST)
Message-ID: <30a82d74-a199-4ccf-997b-b8a6971cf973@oss.qualcomm.com>
Date: Sat, 1 Feb 2025 16:48:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: qcs615: add ethernet node
To: Yijie Yang <quic_yijiyang@quicinc.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com>
 <20250121-dts_qcs615-v3-3-fa4496950d8a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250121-dts_qcs615-v3-3-fa4496950d8a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9R0xePPPSe2MibRXg0wgTJuOWFLGj1-M
X-Proofpoint-ORIG-GUID: 9R0xePPPSe2MibRXg0wgTJuOWFLGj1-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=647
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502010137

On 21.01.2025 8:54 AM, Yijie Yang wrote:
> Add an ethernet controller node for QCS615 SoC to enable ethernet
> functionality.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

