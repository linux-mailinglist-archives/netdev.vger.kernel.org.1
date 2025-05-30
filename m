Return-Path: <netdev+bounces-194445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA1AC97F5
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779F89E64B5
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C728C840;
	Fri, 30 May 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0BnDPAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97C286403
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646271; cv=none; b=fR2/e1K/+WTrqgMLYRH83Dcm+W5Dz0G2a3zNKaxUg4553bwsNrXC4pRDevre0eachn9zGq0+WY3U9MX2Teve983rDfSTvS6vpaNDAehcazM5KdlkPOXHmNEQLaqRNjrGvaaZwHxy81Hoj8Si3hFrZsuyyjlJ8+ATpD6CixKxGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646271; c=relaxed/simple;
	bh=byiZoh49SLANJUmSAfCqkOwCaNc9lAE28TTBexKKF/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+lOpsw52gfxWPXUoI3GLM4AQjiQ9Jt18Xj3yQQJ3RcoO8zujsTwB+cFxeG+OODf4IgsPMT/DF5+Co01+1dJz7xylv02o9qWkmAQ6ngsr+4PLwbAcKzv9egoT/8sCOPlD4vjIn6ECSM1lWmGgY3CptKwDd5kAh05+X3nplkQ/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0BnDPAQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UBnmx3016823
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 23:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dkCBS/+sevFscPkQYrCdD9qA2ujLMqx9Mjn5PoGA0mk=; b=V0BnDPAQ1cZA5vMx
	wrO+uwAWz8KFlXnstE/uufBrXfFTgi9pMy5ti7STYQH8q8NfAlgSoJywzRQ6RcaA
	6L4TJWa4Uz403dM51XNkHzP/9ei2iIwgXqq+mOW85fAgEex2hgHJ8sNILvHTUBtx
	QMmPQvrIfUhawDrBFMPX2VL8X4HSZYJ6jM24pYyOVnxGGOnTewosFWMUTitVV0hm
	KmSkZ/UPg4Xm8SkaQ6cc3gS7/f80g+dpbgrj3rRQ2grar1cbok/T3eBRMT7e4Nov
	M6dcZIyQItB+TI3kB95iWFi5BpBHlRQOo4mvsDGr9r4aZtKEZ+qjdWdfclyqhQkp
	lNnSrA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yc4ysskb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 23:04:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47ae9ed8511so5046001cf.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 16:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748646267; x=1749251067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkCBS/+sevFscPkQYrCdD9qA2ujLMqx9Mjn5PoGA0mk=;
        b=eMTQOQLq52y58bbUbyzVlCyk2Ak0L/7CdcSHoJgg2O75is+op6LzJbt0EjCP7E2udR
         tyiAWjByoCYE9RdonJx40SCvIeynASfJFHmPjG2ITVeGPvUN3TMU9l51MQN5vhunMqrc
         s/Y+jyytVuHoVKzDW94H7z4TKv5dYwKRttkYYahKPH3F/El8l247+vGIazUhLP8CfX4t
         8+cE39bSBamKorCDxfcupog54V2CCom/+EdZq/id6ZsinXEaCk/kKyfNyJrkJOKOiY4r
         hizp5S5asHPhsqmxZoxf+e2icgMg2q+aGDpNyj3s51F2w5s0Ji3pReSBHr0F0TjbqRpC
         6MHQ==
X-Gm-Message-State: AOJu0YyFr/0px6Unu4+qV04cRN5TyV8pzCFThOdDVYgawfKWHyWP9YQv
	0xV0DLZ+S2Ci35WotO08Bw1+mUd9wVn6goTL55hvmQRCv/j7u0223e3jZ/+L0xjfT6YoctoSRkn
	OeizhjNa/900LHIRL98Mf7ejwMsfB6gge2cuMatzZV+YoLFlSooGBtpK4QRg=
X-Gm-Gg: ASbGncsNj8Cz6n4TSz+6xAzw3EY4jUEEcge5Y1P7MMTu8XzqvfRJ5Zm7iLUZKYFr7BC
	HoiR0l2ktihNVEZJq1gmYiyls+KnVWDxQRYaro2xBu/kZJGgVpzs4cioEQZa7ZVC4vqDRKDDfG2
	dW3TwGuavizHdvNQb67gTVNkeXRQvpRZYbW4JY/UFQuFLj0XMReWJP6Sy2PsYUaBkDJbRReQp5M
	SOJVGGuyFTDPisI5fObI98j90NeP1Gsgm+JQ8eq0jb9Si1n8+rAWRvMCM6upGZV55KLFK/wlvpe
	ELqerPry3vXuy+gM1e0xSXoq1qiK4ePPJSMFIfupska5I+kklnz7itfg2iIXoWW0UaPznPuYhYg
	A
X-Received: by 2002:ac8:5786:0:b0:4a4:3cad:6378 with SMTP id d75a77b69052e-4a442fd5b4dmr24294011cf.4.1748646266908;
        Fri, 30 May 2025 16:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwEI1tzi2R7YfDu7oYyeYqxX/g+u3B+J1JeZ+9bSeOHb3HGbzLToYdbggmXX+xwNflLNapVg==
X-Received: by 2002:ac8:5786:0:b0:4a4:3cad:6378 with SMTP id d75a77b69052e-4a442fd5b4dmr24293841cf.4.1748646266428;
        Fri, 30 May 2025 16:04:26 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7ff075sm399104366b.37.2025.05.30.16.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 16:04:25 -0700 (PDT)
Message-ID: <ee3caba9-deff-462e-8117-f375882aaccf@oss.qualcomm.com>
Date: Sat, 31 May 2025 01:04:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] clk: qcom: gcc-ipq5018: fix GE PHY reset
To: george.moussalem@outlook.com, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250528-ipq5018-ge-phy-v2-0-dd063674c71c@outlook.com>
 <20250528-ipq5018-ge-phy-v2-1-dd063674c71c@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250528-ipq5018-ge-phy-v2-1-dd063674c71c@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDIwNyBTYWx0ZWRfX5TA5okBgW+S/
 0qpfAwPjE9Sh75fepNbHxopuk2s3zxtOhHaHjyNJe4AhobyePq0sfr9cLMfQHC3q18sVMRANIi1
 MzJYA4Ujh8Jhvw0vQxcEgGZ6hZCfuX1+koyI5PDFUqlSaNGulDEXwtApkIcSVuLWiDmOfIX+62z
 taay+Z7tkRzdMYZajAVUx6cvHGue2Pb2m2TIkMXBw04cnl0Yar07AaylW15cLDCM4NCaLfsaFKl
 uyje5YJ3xzunqFNY55dn4ZnVlyLs27Kx2+y448WoKzStHMFLX/2aQIJurJso/8q2ddnQcLof9Bu
 co9yymkYJfjl9htB3hqhfjNuOFmLPACkxpGFZlE8L20CsCB498owNQlZLlgJrwb9WrKuOKRk6Y2
 kj1Glp3jBvjUaV5fKMkV4M1lLMPlDd64iTFY61SzgwO1JSnKaPhQtobyLPVNNI+AXcXG2vy/
X-Authority-Analysis: v=2.4 cv=Ybe95xRf c=1 sm=1 tr=0 ts=683a397c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=qC_FGOx9AAAA:8 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=rZqdB0JiAKPJAkIg25gA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: V3ZL1DQGzzMPCJ2fAvO4ISKqtqUpzhAS
X-Proofpoint-ORIG-GUID: V3ZL1DQGzzMPCJ2fAvO4ISKqtqUpzhAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_10,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300207

On 5/28/25 4:45 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The MISC reset is supposed to trigger a resets across the MDC, DSP, and
> RX & TX clocks of the IPQ5018 internal GE PHY. So let's set the bitmask
> of the reset definition accordingly in the GCC as per the downstream
> driver.
> 
> Link: https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/00743c3e82fa87cba4460e7a2ba32f473a9ce932
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
> index 70f5dcb96700f55da1fb19fc893d22350a7e63bf..02d6f08f389f24eccc961b9a4271288c6b635bbc 100644
> --- a/drivers/clk/qcom/gcc-ipq5018.c
> +++ b/drivers/clk/qcom/gcc-ipq5018.c
> @@ -3660,7 +3660,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
>  	[GCC_WCSS_AXI_S_ARES] = { 0x59008, 6 },
>  	[GCC_WCSS_Q6_BCR] = { 0x18004, 0 },
>  	[GCC_WCSSAON_RESET] = { 0x59010, 0},
> -	[GCC_GEPHY_MISC_ARES] = { 0x56004, 0 },
> +	[GCC_GEPHY_MISC_ARES] = { 0x56004, .bitmask = 0xf },

in case you send a v3:

0xf -> GENMASK(3, 0)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

