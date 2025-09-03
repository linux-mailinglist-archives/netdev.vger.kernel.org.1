Return-Path: <netdev+bounces-219554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F088DB41EA6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC955547B11
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AD2DA77E;
	Wed,  3 Sep 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYU+xiYt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CA284662
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901823; cv=none; b=mPXxEFRayUujPZaK8Xpxh21hbHP+76/MZ2CVOlz/w6jkD4EwAYhdHTHOR2VfeChYTgDPAJmP1Ms++UI8eBZHJofk2r0k76HwngArLfASJal5D20YVwM3+Ch0SdjPIG04VjpFaFENj0sjniHvWOwFAxOQhuLPpXrf0wXf9+VP2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901823; c=relaxed/simple;
	bh=T9zMBVSfXXkcPKE4WZiFLlE4rfzCAascmEHlP0GQHuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsuH+1DBRdquZuHi62S62Sz/e/DNIlrrTre8w9OTE3ObiFQj66nJ5V9QstyGXgf21sme816/zIGF6sHxMrdvzun2H/FlXLw/QRWFbyn+OhioMKGZAqi5Ltts3OHPLlvXXLrONOtdZRrZSW/Yo/8CqSibFBjuhjL/zVRx5lPiqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYU+xiYt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF1FR013805
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 12:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ylMxvgn2/5WfIAh5ue+ghLhJ
	nilgf124w34Bfp/g+Q0=; b=KYU+xiYtbGF16ZrnYQ30qSyxDrDHePo4wS4BDehd
	xZDa7FuTtBmztCwX2/BxLelgs45bcCSAdA9j42JfwuSLoG+3ivRmYQB/HjkJ9Ohw
	8oTsN1MEN8qm7wn9Y6qbX/JpDM9S3myjJzAzJCurU/iAqH9TbTI/wIVhfvC4dfke
	FSNwgdcwi39udkw7U9+6Nk2FpYj7vhBK5ooRoy6kXtrIvHDJYTDV5hYdIhstXQTZ
	jw78iRxKqKTRKZk9gzjbpC+43PhVF6MpICFQjkZG6jQHsmnK3gsuLVKp8+CHyHvU
	swMRUtp9telc5Ol7FfWNZVUdkkHhD9Qh2+nJASDzg7YOrw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv3qpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:17:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b31bea5896so42314981cf.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 05:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901820; x=1757506620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylMxvgn2/5WfIAh5ue+ghLhJnilgf124w34Bfp/g+Q0=;
        b=SnVqVoiBmACz8MVnhcfxyBTXJYaryqQkkA7HsLTcS+jh1WfwZ8OLFZl42g+mrSqnWu
         CM+2AcBsHsgrD1tEPgoOimPLka+lYHACfFM2SQ1D2RQjszC8R7y9i+/brI7e4La4o36a
         M0XU81BxS2blw3yOkTg7qzBTjpHinndUDSL8L/VqlSNsoCTd/EAH1GEPo9HNmVnxHDVd
         /OhxA8c16qwOL+MTDMMr/40shlFBRqmCZ1/3fofYjSHBXCrgs76aki/tB/udQ+k4JWIN
         bmWJhH+jXMmDgTxQNFMuRF1KtuOEITY5UxNA2fd/oQyHXbVC80Ytq3/xcysvmY7E0MQP
         gIHg==
X-Forwarded-Encrypted: i=1; AJvYcCUBLN0nOCEv4WRpmpnIy2jZyPQF/J5zBRu/0zU34s1s5nsJBmurRgCcXZdOdKdRiOHAtaqsUKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBTN6+I9Sc0KN4+FW4OOAEzi8mulsocjrO1qCvbHjq25zlXrK
	yWWZzqLPwImj/FTJ6fpG31n6zvXeChBYX3DgRJhoyvoWduDfRLWBClt3+6e/EKuzkpHDFCAVwF2
	cL2Sb3WY6efpq/2WoKJrXeiWhjDiRxV7gUgSuDvmvuYvFdp5tvl1piWse9+c=
X-Gm-Gg: ASbGncvEGDqJeGuvkzlZ2+eo9mSmFwsThYA5PX495nRArpW4bWPGn6oRGCoMo5W/oTn
	V5xZjPxvbx83QKEgQ/Inhww8IMKvPZdOpq1jOgSeacgVPvERA1IiiO3oPctYKC0bhkwnyVvEdUZ
	JgKuR+n7a+DvPtGxg2ZMfUwJJ57P5CJgk56gmFYg+VDSKWyvJalfhhGxpcYV9m/cLaZGCAn1gV+
	EIPlNfnDvJ6zfHh57XjUB4kKaI/oU0pahtMt/AeJFimcgR46wvQZbJEDRBDklnZDUMQEBY2Ajkz
	fhHlqQXr/xh3TgsZlt48uf59QuB408ib9uAZP+P+BuAHUGeXzt42VJYSL3oBER6fGvWbRBzbZ/z
	mw0XMFvj5wblxxn41xN03LTDEhmyq+KduWBsLZN1HT0IOfArRYYsk
X-Received: by 2002:a05:622a:1898:b0:4af:af49:977f with SMTP id d75a77b69052e-4b31d843106mr158036021cf.30.1756901819522;
        Wed, 03 Sep 2025 05:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf1JntwKpKDnqktzqn0jP9DtdNKaSUHktaQ51gxNmKUeO36CmdMwvJ8YX8+atEfF8/F8jfpw==
X-Received: by 2002:a05:622a:1898:b0:4af:af49:977f with SMTP id d75a77b69052e-4b31d843106mr158035581cf.30.1756901818930;
        Wed, 03 Sep 2025 05:16:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9c89sm482916e87.91.2025.09.03.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:16:56 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:16:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/13] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <olv66qntttvpj7iinsug7accikhexxrjgtqvd5eijhxouokxgy@un3q7mkzs7yj>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-lemans-evk-bu-v2-5-bfa381bf8ba2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX5XjiBKgRA6aO
 /wcAA7be1oy7KqMAaIBEMyvc4R9C5pBrBxY1g/oaKloCtSLS7CdjovhsCW+9uPd1HjdiX72duoL
 AliJ3nX5enjJ+mPrY6O8MM0G+a7R+RhWxPpcYRSHQnI0jTnEkvE3zmqdXEF/oXthLJExC2ITLFp
 k4NHJYyLeAmHOtdCiAkpXxhCSyNcb9lozsxHxIAHqXXDdN7oJJrQy2hkcnBvME0hg7zFY6e1jhp
 gbc3HVkGwIPNgYdcDXyIULapNwKxB2V6rzusHraZjI5boit+F0MlMuvY79denKFDEjFjghH2Yrs
 t1oSmu8/CIK20VJkq6NMB6r1BuoAjo5geXLM10T0eZLRluCM5b4vsDuQvsy/tpj8Al3FTuKs1BL
 Xb4BQ9xX
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b831bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DESvhSBXdVqio9EQXHkA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: YFGLiwZZzZpg9Z2cpN0JNK_pKUvBqOMM
X-Proofpoint-GUID: YFGLiwZZzZpg9Z2cpN0JNK_pKUvBqOMM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On Wed, Sep 03, 2025 at 05:17:06PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index c60629c3369e..196c5ee0dd34 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
>  	};
>  };
>  
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
>  &i2c18 {
>  	status = "okay";
>  
> @@ -367,10 +379,18 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&qupv3_id_2 {
> +	status = "okay";
> +};

You've added i2c18 device in patch 1, but it could not be enabled before
this one because it's a part of QUP2.

> +
>  &sleep_clk {
>  	clock-frequency = <32768>;
>  };
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

