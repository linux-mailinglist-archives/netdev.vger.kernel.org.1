Return-Path: <netdev+bounces-193610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A03AC4C9D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3A73BBF44
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766EF255F31;
	Tue, 27 May 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fB9yk8K7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC9248873
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343645; cv=none; b=GtAkGvIXAWQMUv8ZXm2lYqs2U/9LxRYu5q2ny+ru7nT7REK38dy60R80Bz9LKXQoLvtNalfzhpDirDNLOiI0HeedeKI4ubskz+iJpUypmXTBDNfEPTrK9418Ma4StYpqFuojSGYGZO1Ek9zhg7wTOh7BBQpgVzHS1boELK+0UNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343645; c=relaxed/simple;
	bh=U6pKDs2mOQBNxfLvwMT/KbWRi6T7oO/1foUXXEwPqko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5GpoV3ZOgGAZiB92HapBytIkv2FwEzdalg2OcFIpjjAooCnCryzSqg4Q3JLH7OACZKIeib+WAZgeliSmcfDnZkM0X6uiX8V5s57FqFL+fRcuD5F/4d0F8zp1fFNpGzx/J1YD+11Y48ITsGM9UbJZ+U1n43ifvjxZuYB9kIOUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fB9yk8K7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RAXAHN023876
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zgVk85DAmmpZs++PLF2UBmQ+DGiZz0Emih1vTSs5OXU=; b=fB9yk8K7uV8T/fq6
	DO1Ni/h8nKW7CNmKL96zZ1bf0epG22PvNYkhTmno5rDgk2+OzHSmXigIIm3o6foz
	To1Zppqw6y+7fKH3A7LscpMUJupwr8dawfyi5Bme2vi+Kpd710uu6Q+xnccmYqOi
	4JeaueW7dj/+EOHecWjN+hTYCctbSWZSwPDu1rkYZM/EjDp3tKY7Wzq/YVi+sN0U
	C09I7hiprznbgkEu8dGez2ivfULrCi6jNbVXtpMJnPy5pi4se76oAOTQg0Q4o2BC
	gt2NzvjoRe2w9fdG+fFoBsSEiz9Xgr6XEf3fC1hQsaZX6gVzenwRUZu0BunRdCNJ
	2Z1uzQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vjpk5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:00:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47ae9ed8511so3076611cf.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748343642; x=1748948442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgVk85DAmmpZs++PLF2UBmQ+DGiZz0Emih1vTSs5OXU=;
        b=n8TMcZmYYwVkMxeV/gxEtgDGbRFVt4NzFwM57RyXGTjUat1V8PztBd5KA7Md2UtOqg
         R3lzx5VFekeIjxhKSBU48ql/Xb2yJulw4QvVSEBOOX3FeP/u5iFPMXKvgsFW70x7TUUY
         1soD/Df6W26fBQvVBeCz8JiJJgYhAvvy/b0YHt0Yoa71/fQOnd+DZK8F5KZuQSODUoeU
         he6o1jH8+BWudPxEC+YOvKCygR9L0pwq8EIZ0ze/qPFFfOT/3HDh9dCsMQ+UBFpscq8m
         qMaC9IOynHhWM1/gB5SA8mLYActttlSZT7EkWM7cyyc5kTRWm34zYBEuv+nQpl0nEsCG
         SRAQ==
X-Gm-Message-State: AOJu0YyB5GPZHcGMclGm2sCwCgeZWvwkRKtr0w5huNVapjhDAhdGteos
	eadS3XtDpFn9JhNRgnALDKVrlUJ/S6N2h3OEN+aCpRROC9HqBClNcp5n0YmHF+RiN7OwLzHOIgY
	NMcQHa+EOBfAdbHkNjfHByoU+zuUB/4rH0jMBwN5hOHFqyjbmwdZuhhr0OiQ=
X-Gm-Gg: ASbGnctcLHTA260guny+elwhFspXeCAOd10SNmDQsDig5eVqxGsg9W/U7y5Qz8a1HRP
	Jrjk5heG5nooGE0qrkE1zgzmzGmXunLCtG+ikkxlf4NWFOyb5sxVwEA6pM1xLACNoLaeVbWvUcZ
	xK9UcCoNpagOdat5WVWteUBG2SGBzaRjE44aCd//pNZGyq1TC13ZKxgyLMmEB4bLJORZHMA4xEu
	wPXJP6uQCo2Uvm10egncFlwPqyS8D/esitFlJ6i2YC9LdORf1uSrvXHMT5hl7V6EaslXkDUq5PG
	gs6PiVqbvDNYWIKJ9w9xB+PwAWiq8cLC3ClVRDWzkUbRqYW0E5BKmkMcTVB6A14iPQ==
X-Received: by 2002:ac8:7fd4:0:b0:471:f437:2973 with SMTP id d75a77b69052e-49f484b59a0mr63741711cf.14.1748343641574;
        Tue, 27 May 2025 04:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+5TD+MYI12ASNGgNhrVbg3teRggfUA7Nt0ihpblmSv3AXfO5j1mU3F1jH13ruzx816Fmvxw==
X-Received: by 2002:ac8:7fd4:0:b0:471:f437:2973 with SMTP id d75a77b69052e-49f484b59a0mr63741331cf.14.1748343641067;
        Tue, 27 May 2025 04:00:41 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad88d055609sm100472066b.28.2025.05.27.04.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 04:00:40 -0700 (PDT)
Message-ID: <337068fa-adc2-478e-8f3f-ec93af0bb1c6@oss.qualcomm.com>
Date: Tue, 27 May 2025 13:00:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: gcc-ipq5018: fix GE PHY reset
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
 <20250525-ipq5018-ge-phy-v1-2-ddab8854e253@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250525-ipq5018-ge-phy-v1-2-ddab8854e253@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=68359b5b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=qC_FGOx9AAAA:8 a=UqCG9HQmAAAA:8
 a=rZqdB0JiAKPJAkIg25gA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: 3fjK06Rqz0573myCNiQCUjkdAvmOjf5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX+y/kT+RociAt
 NOCJRGPbqI/rpnyy+HB/GIeqA/w+8wfyWJiruj8uZUYPPzwbwESOWs3AYpkyZh0667fvFqziRfj
 rZl/SEM4TNWPfgkBUVjMY/dU7syEknx74LfWEZ6kDS54CWZlM11yIFx+8TPVVHNtTS3jNqGF9x6
 owKDaiWLGOoP/eKeI69zVkIrEuO7eukJEnE2VIBOEDGGwH1mo543HVIIsa/Wg5QegEcKXr1C8aq
 SjjHZzey4bnGfIr7zsg75XD7BXY39jFr7Ux6kXrcunPGZZMDN7liRboREorU/gWy0fwa2YPBNXX
 K2FKJsSvzaCrsiYKiNoVMW1e15Smx/wMi/kBcsN995V5J1pQv1rWr0OjNCx3VvzT+LBM2001MeX
 Yt9gxLo+L495S1kb/bJn51t4S88OaXGJ0yuFqeSqM564Eht31TiKvWqv9JFqPWi7qLaUBFUK
X-Proofpoint-GUID: 3fjK06Rqz0573myCNiQCUjkdAvmOjf5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270090

On 5/25/25 7:56 PM, George Moussalem via B4 Relay wrote:
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

The computer tells me there aren't any bits beyond this mask..

Does this actually fix anything?

Konrad

