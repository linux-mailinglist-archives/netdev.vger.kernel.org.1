Return-Path: <netdev+bounces-193611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBDDAC4CB7
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19537A8E22
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2C255F3B;
	Tue, 27 May 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZpL8r9p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FC23E35E
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748344061; cv=none; b=l8pX8Ju0zXmDLF9d0RTOY3ODNIsXR1BhyWQBFAF6mA741QZJrHmJOYSZdubaglnk68/E9du4d0d/fKrSeKEZ9t610MUHSIHGgNqvNfW1s10BN13xubLVCVUARUaCdrJhU0IdsfaSiHWqHIOlHxsMFA4NhpH+D8IMTQBsT2V4Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748344061; c=relaxed/simple;
	bh=TNReqZJtGZrLCB/0a9vyiLrnegGFn1EY2RVuNpQQfr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOs6R6OXP9Rq52iXLNdN1HMHzq2N+fbV+8JDLPjCYJ0lS3Mi6/s0f0Xb2TBTy9XOONKVryMtuId2bPoS7KYTgR/vheBeXbcxIr7+hEiF4Ks0cwNwk/UJjmzNkYyAw0kvzPF46pMunLjTMoJvoKGGcpw0HkVAachDFGQMq4nbWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZpL8r9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R9Ykwf002109
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BfZwm7UuVCY1J5Eelkp5Sukme55QSpM1Z7PhgulTTQg=; b=pZpL8r9pC5UTxYBJ
	xNNKVLvvDxBI8ddwAvlHO1ECGoDSOvxPywgH0EaeLByqPJNcM15bmjCUdDCg2efx
	kNr4TFYJUyGeni3IQ1N1cYMtMzbaJWuNdhVcoL8960IWh7aVNEUUOFL6CJgUI2g8
	uxYu8eV5NT02ZrGPoToPf3f48ybiRoMSm0kU2UVtGwobhDVyna6tmQlZyGeueKwL
	xL/ocr/23Cheu/l5AbkyQR8iIdmTc1XEFvrlZU0S8Gc7F1WT7P+LzPHaEUNrIWiu
	5zL/7DnQlLnxMr5RHFtoUlKz5x+U46gWsQdUuA6qW7xSQpSF6NbxWGkjLePd3W/H
	kyhHIA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavkr8up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:07:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f2c8929757so10283206d6.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748344058; x=1748948858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfZwm7UuVCY1J5Eelkp5Sukme55QSpM1Z7PhgulTTQg=;
        b=AROawxKzqtX0NwThC62tCXOGX9kivSfMiYynbHj4ReIA5lqy5rnGAzPVVg7onWBVk5
         ITTd3j0qth4SNnD5UQNRJYm/X1b2FXHiYMY1ueCVVZjMttEmV5GCtDrmel4UvAn+QVMU
         mwpiYEPOdp0kosFGarO26+/fDdU8nLCxqQ+l9iolVdqRfKrGnbQCuZxDW2Yy0wbJP8q6
         h87PFS5SwGVucfoDkDm7MyYNVuDOBoTjhzLTyc9fKy+yYS0qeq+iRPzXpygEFh9LHDoa
         +EZY9Vpu8aSTXHSUvfKYc3m5vEfEct/sX6hDT2atZs10Oj1uuTnSz3iLbD8jxUguLZTW
         K0/g==
X-Gm-Message-State: AOJu0Yw2ldzKKlDUWNz0I4gS11sXIgKbGK9L4nK79j9FysyndvWP3fkh
	+vF+fHcK+PSJqm/WdiCk0o2fUXjaIxhg3GnxKXzdJ1FAtW57HWijn0yqDJLA7BQsCs/MlUmuhEG
	T3kY5vQLsXpDHGxiFohZdBuLaheVuOSBlwwLjvdzobZ+WytKH3qDAITOifJA=
X-Gm-Gg: ASbGnctflGNSY/xNvw8kR0xk0VKwRBN5PAvyIJR+LNH9e9/kJAvhKufQ7y3mkmAr6nA
	Rs32JuwQRCTyau+k++RNhpJVtclENvHLsgeYVG1vNSlSGDFOMCyQz4hla5NBq8/sL+quqb6P4SG
	8RIssM11idFCKcxTaxIx+iEn2hnDPDoD04toT5KZUF8huDRIadiUJURpKPj9wVg9gQAc8C9JnD9
	9ZF79OI4U6ldb9dmwWE5IB0afUuWi4bO7Pdakq9uZejhW6F/bY/rGsbv3hPxseHhdIJLiHVoVBF
	Zd3KD7ibWG0A+ltRoCqAZXLjexseP2QengM3f0mDScBZcRc4mP+UTA4dvS9YQJbGpw==
X-Received: by 2002:ad4:510f:0:b0:6fa:b77d:704 with SMTP id 6a1803df08f44-6fab77d1cffmr2652536d6.11.1748344057717;
        Tue, 27 May 2025 04:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2mKwizuWDXJ5NdWrLqc5LyJuz7xwEsnJFxxBO/LKm/++ub3xsNb3IaRFYXiD6DzRKNQZ0JA==
X-Received: by 2002:ad4:510f:0:b0:6fa:b77d:704 with SMTP id 6a1803df08f44-6fab77d1cffmr2652406d6.11.1748344057291;
        Tue, 27 May 2025 04:07:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ca5basm1813835766b.161.2025.05.27.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 04:07:36 -0700 (PDT)
Message-ID: <9e471d88-1ace-47ea-b1c0-cfb088626199@oss.qualcomm.com>
Date: Tue, 27 May 2025 13:07:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: ipq5018: add MDIO buses
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
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-4-ddab8854e253@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250525-ipq5018-ge-phy-v1-4-ddab8854e253@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CtBtoFWHDivTPOedb2bjjb1eTH6UgawZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MSBTYWx0ZWRfX47vVVx7nR4eb
 I+Tfe+NkYTvNFophW7fkX4PGoBMODOV9QYHQ9D+JvMJ3F/m3wKOfvZEgLgU9W7dvFMNdys4+dPf
 lzjygGuVd5ZWrR1wZGmg6FAAQpCQeVjixlRBF2dx1sSye48Q4vwJ0G+mxH5mxsZK7qwIxEytiJF
 WafNtC76VU1PJ7QZ3mU6JN5UmXRZcMjXDFb6NMc5an6V61NGUdd6XfdUl4VkCMkvZtDJWmD81kT
 C1VzPK39IzVsjVT3mxLEcQ/aE9sJTywLJaJ9IjHZ/tOZRTM9PmyzdTZcKdMzeOb2ZMVjxtFhrxO
 KzXgvBS8SfIVzWKV/OVyRR12n0Q9lCxPEoa4Sv5cavviqtBNRZpoEWlXxV0ffCl+QswoBHKk/DC
 6cUMf/T37b1TXah8ilpNRZINDMdzRm7sYzOTOG1E788im7cjUytG1q0knBJB6iCS3CYgTMnH
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=68359cfb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UqCG9HQmAAAA:8 a=0Nq9bldXOn-2tuYZYJwA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: CtBtoFWHDivTPOedb2bjjb1eTH6UgawZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270091

On 5/25/25 7:56 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> IPQ5018 contains two mdio buses of which one bus is used to control the
> SoC's internal GE PHY, while the other bus is connected to external PHYs
> or switches.
> 
> There's already support for IPQ5018 in the mdio-ipq4019 driver, so let's
> simply add the mdio nodes for them.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 130360014c5e14c778e348d37e601f60325b0b14..03ebc3e305b267c98a034c41ce47a39269afce75 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -182,6 +182,30 @@ pcie0_phy: phy@86000 {
>  			status = "disabled";
>  		};
>  
> +		mdio0: mdio@88000 {
> +			compatible = "qcom,ipq5018-mdio";
> +			reg = <0x00088000 0x64>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			clocks = <&gcc GCC_MDIO0_AHB_CLK>;
> +			clock-names = "gcc_mdio_ahb_clk";

I see there's resets named GCC_MDIO[01]_BCR - are they related to
these hosts?

fwiw the addressses look good

Konrad

