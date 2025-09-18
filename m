Return-Path: <netdev+bounces-215140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D299B2D27D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C7C1C23305
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0748258CF9;
	Wed, 20 Aug 2025 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gdoEGRrS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0E13B58D
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659904; cv=none; b=afHcL+NSK7qp5M3jeM0IhvektaCFX6yIVTOdoWLuBDJ6a9BUJxHOqnR6Ch3TaGsfJQup9fXge5h/viM38+owQbtmHdgM211TPZ6nu4j4rvZOCZC7Rg7FvQz3D9lFZy4KTDcto7jp9CdEZqSoTJfmbSrp03ImIjRyCJAttdIsDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659904; c=relaxed/simple;
	bh=cEMOtZbGfpEq1NXnNikHEI6Fk7Pu/vu+cfjaKIrEStE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5zq3iBMgzP7QLRr6DajQbUz/6+p7L962iN7jsMfzEdzH+2yeZUxkjUm3dELJEf/tsJu3rA8soPZ0+pPspil8sgLbfIipWeGpD/bbiKH5RoqFSmZNUuzC/mhh5rwFxkFDu6EChnw1t+/HkwurLk0DlpzJg+gFiwI0oza8l6Rikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gdoEGRrS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ojHS024584
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 03:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1N/ucuPVyTyuNbkPcCCW3UQru9In3TiK2iev/+oe3mM=; b=gdoEGRrSMiZHcCc6
	Oo5swe3fsHJEfhNQ9+pgvKJjnB8H0gCiv4Wfiz1NZw1JdjbBEBnykd0DDKRxIE+V
	VkOZxED24WT/zu4meCWY4MclmKfzkTwdlJmlNFH4pe0LQOnu5UUoATxq6Q9qCVlk
	thlNab6rJABofIEzlVHIVkuX0/B9h4qta4DgFKzcx2ABdd/Cua/ofVIXWds1sJ0s
	z2+ph3z5CDFp19I6hLEz4x6qd+wZ7+B2STwLp2ogEFsfaIAmF6GpSTE8eV/0ioOq
	zPx9tHwmTtQLvCc3KSdGQimJeMvzG98dn75hIdBgHUAigUTz5ZGIoQo/fozxbpbX
	VuuNMQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52906xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 03:18:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4765bf9ed2so289247a12.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 20:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755659902; x=1756264702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N/ucuPVyTyuNbkPcCCW3UQru9In3TiK2iev/+oe3mM=;
        b=mXaZw949RCu9xL/XTYY6TP6QyAZnLwa2mhYwpJC6FxUBOQrNmcaOHkyl5rj2c7nuYd
         wQ2xLNA1JEdeC6W+O5WQvP5v4TQnvjWBdOYraE5T8BmRHe7x9RhWRknUNNP9Rd6bBddJ
         VFze3cmxvf7HCaAqqnHSS2AAiY3BVR/qNNN+EPxrESvfJ273hbdnkqxFGYui4Pe0ETpu
         1S9CVxQbRDrAJpwhBh/m3J3xE7SB0epsAexbSZ7vA3m8W8HyTTyq3kA6LYvJwmZ+VaEU
         mPlm7/eCk8cL9HnRZT+1bgPRbGOq1+NKb7TZdJQAmXmZ5N7NqH3iq8SITlPaHyhEeDdO
         H9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbrmgogv9XcXI5I2Y0gGCw9Sidz80Jqg1Tv3OYqYqjpISjxynWKI5gJVFhie6dmT0BSgjuFGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+Cu4TW/fLf3GcNX5tE86y1HGC/dNi8dQk92xL/wOvdG7IPt9
	28c9Jwa73sUXp4boAmAkgyXWYww1imsw8F3mRvJwClxJZao2GyY94/dYbotTDU7pLRaNPXc0l5n
	nx3/dLn5rQgNabX3xuF60K73RllRiyQcBBqnlskmnHvI6SqKGnqGUMtwzcu0=
X-Gm-Gg: ASbGncupBnPx7Ow31uyMuqE35UFaEa6dUmLHHL3Cr9i6rI30RMn1wEp7raFESWAc7Gm
	9RaZ3YMQH7W/mVVWymD9wYM3WJiwdU7twvDbINFVlWn5oB95Dqv6sNX0pB4De6/vQuA/8NuT2fc
	1xRHtQYnAYqSXsPFtJt4MsTmUZrdr8qCV+798vbink5XSPwvqYSCFUSyA6jKcTkEQhSZGeN+rQv
	vZGumnjjU4gJdGmcf34nHkl4K2AEcRusBw1wOAuv5i4XqIlp+NiB4R/9GkHOEFsGnWhyBA9o3am
	2iqGebUTK/eQOdFV5QruPGkwEgqoLlWIh1g6ippfCio/ego5m9C+QwH8fYYGfUp9C0EjXdkmfZb
	zcczSxqo/rTj+YVnl+K4hAURlk1c/SrKp
X-Received: by 2002:a05:6a21:6d84:b0:23f:f5bf:35d7 with SMTP id adf61e73a8af0-2431b988debmr2421267637.45.1755659901656;
        Tue, 19 Aug 2025 20:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg42eG76MsaUYs0q0AlQR/5jkH+O6t3EbXik5YsVCq2cwrkly7cX1JNA8zlN9xV7ue3HTcKg==
X-Received: by 2002:a05:6a21:6d84:b0:23f:f5bf:35d7 with SMTP id adf61e73a8af0-2431b988debmr2421234637.45.1755659901283;
        Tue, 19 Aug 2025 20:18:21 -0700 (PDT)
Received: from [10.133.33.88] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e253cff5sm702559a91.12.2025.08.19.20.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 20:18:20 -0700 (PDT)
Message-ID: <648e5f1a-5945-4562-b280-c12d26ad65a8@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 11:18:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] arm64: dts: qcom: qcs615-ride: Enable ethernet
 node
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
 <20250819-qcs615_eth-v4-4-5050ed3402cb@oss.qualcomm.com>
 <813548c2-02be-40fa-bb6b-00c4e713d17c@lunn.ch>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <813548c2-02be-40fa-bb6b-00c4e713d17c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a53e7e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=TQ9DYVZ7-X13aS6S9P0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: DR-lPpWyK2QV5TjG8xsxt4jKmEYv_pIU
X-Proofpoint-GUID: DR-lPpWyK2QV5TjG8xsxt4jKmEYv_pIU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3G6b/DnJTo2Z
 FAUKM8P6dFFK4h+VX93g5Z1CQrmRdedVPaExK7JCbIp2S+oO8GQoIyuwMnTkZNshlPZ3CPYXKG2
 Ap2S9Q25kYA7M+0D0jLlIQov/DIcy9hDmV3dca4h6650vQo1kFkq0ETbV7rNf17yDOAe/eF9BEA
 wsCX+igK023E1XGbOm1SCg42JvemIGYOOGcIlLQIDDuujMg6ywCgWgtwK7Z5SW1NewQ3vjhZ5uY
 5pjXNs+RNIbJQZOA1Cti02T2c6BY7H3DuyfFj1DS3lCgdBQ5NX/1bs6UL0rXVFnVKOdwaW0w7sB
 4K9fnSRSvLOq0O5OODVOj0RwixFH9X+8+4vw/qiMmN/JzTsBadInVLcKHb1sK22bzlxq4BV7rtU
 VVc54yX72ysln2eS6/M7ka/uOraomQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 2025-08-20 00:24, Andrew Lunn wrote:
>> +	mdio: mdio {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		rgmii_phy: phy@7 {
>> +			compatible = "ethernet-phy-ieee802.3-c22";
>> +			reg = <0x7>;
>> +
>> +			interrupts-extended = <&tlmm 121 IRQ_TYPE_EDGE_FALLING>;
> 
> PHY interrupt are always level, never edge.

Thanks for pointing that out — I’ll get it fixed.

> 
>      Andrew
> 
> ---
> pw-bot: cr
> 

-- 
Best Regards,
Yijie


