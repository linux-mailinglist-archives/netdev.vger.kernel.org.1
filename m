Return-Path: <netdev+bounces-217124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D501B376CF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA777C0EB2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8D199931;
	Wed, 27 Aug 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lu9R20El"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA235966
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257628; cv=none; b=KSBbDBkbwmNxcNK4DZDvd1IdRfvRvDn1QAWvkWGnnoM+WVe4JLb0eJnYMZpW4gVzEd288sXVELLCg2GgTDDR7kICyEmUcKZBxnsyRtsDdlRUEPFsLeWxPZefS6q/nVQ6JGkUEuMbJKQZNQJ2qSK+wKDJ4iZ2lEIC/nx2GPDwALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257628; c=relaxed/simple;
	bh=poieTlsyY1cLQWGzxhRq7UJJusIqma5TDI0g2OmhCPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCkKVAOPxfiKfkH+CZDF4NLH/AcNojFlFKG1SW1M8lpeAJ9RppWlfN+fHuk9B8cFX/ePRw/In6YucWHe8FdY6YMh44bvI13/7rX1kyz0PtSYKg6z9bQJteB002VkoCXyvUu+tNJOKuE8JActnQAgKY8msAp+UUbMyb7VA/86E/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lu9R20El; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QMwWZA018085
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w/Xn+WN5sZN7Gioa60k8DdWJ
	ObxIkjRSuxFZ7uva++I=; b=lu9R20ElEb4wMvM0fGhG2Sc/xNgy2iMWZqhMH4F/
	hDHUsf9UZIqF7DmKCCLFmHYzTS4K6M8JJ01mG8YJ2BsetXgiN7VuCy2dMWBScBOW
	zSmaJQscYtA9Ggxwu+k817ax+pVwKYmnrc7b0TZ0DLp7U0HEYlgLtwaXQrITcShR
	2pj9XIzTYsrZoilKT0T8zdGz0jMBuVCaI3sTNH9jmvFaPYCi4JU2LI05UPXRxQkG
	GBqHT1YC6dQeCQ+5B4nG6ZmoiWyoEyV0B1P0enflkwgRyEqk3xauxOGGYoJZd0oh
	pu+ljD2VpkY0X5cye4DtSG+AMrRwBlp3PLlVKk/zJ9U7/Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5untrsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 01:20:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70da6de66beso42937456d6.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257624; x=1756862424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/Xn+WN5sZN7Gioa60k8DdWJObxIkjRSuxFZ7uva++I=;
        b=BMIYxw+8dTwollf6neXUQcDkMMtn/fXic06lC4f+fU1JXnShtakql5tjmRLUEBTxH9
         BXq2ZfEJJBokOOJTtFZqFDVY+66t1s6KDpR5Pwvc/wf0McdFsxtdzIV82grZ7JLpU4JP
         WkIMh4DwkNPE4yJ1BY/IFHNZBFoVtEYHzDFC/86K9jN5ntNSaKVnWl6K+WxMBFCRsYik
         fSwKERTEaGZFTnCD0+Od4hHGg+64SyCujpZ1Y1cztSNPs9yiFmwpRYSybZyNcqYIWOP5
         k2ps3ig+Gg2/aDqeLqITDvDReP8C47Of0TzV1aMCR44+ymetZT7HMnAWbIINIkWEWcWr
         CwJA==
X-Forwarded-Encrypted: i=1; AJvYcCV0BeLk+m+nbqdPx5oaKtR1OlTlZmuEd8Y9Eh3m50RKJ7/FPYRFRa+jf38Gxew7fx6wI3iMm0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHub09+/iUT+knKOBO7kW3vwj7ugv9f9pVWR+Wih/OjUG7Hz4U
	qvoaQ747++HASSXGwF9gCG0Chg8rVDcAnHDol3Ks0XsalLibeS4TTKrnMm4yLtvIfxaCbWoFhff
	L/CjiDQXpW6o4zs5WyRn9vtgAI3l2mjYJsJYhwwYBhsNunzmpf32PBHpN8Js=
X-Gm-Gg: ASbGnctExzIhNX1ll9IBGh10QtZW0Woh7vyDo9bOj/5R9Kpk//SBeCZO+lFjoamJmgX
	EdhOMxeB40tOIaMEOLHc8pD4NwNhM9aX5jZFWqN3OXYMHtEpPjW0to4XXDk1Qd1NgWpUJscHheA
	MGWzF+1/m1hTLy9qQm//ehLg1Bl/PHcvpBt8TYh47EpuDorLDgMkyjbVoCAwgoQnqxJYpoXXl4b
	09YJEGWApZj5whXtTdEsOydZakjE2I2A6BE5KuS4DR7JWWDLO1kfu78zMgwyXEyiDwJIHW8k9dC
	/0/pzmeDT04g+j4H6cTvnqYn9kt85dHTuf3aC/LIYgo+/oktxlmWqwp1IBhj0d0yrCbqXDBRqsl
	U80Yuvmc4YanlNk7c08723uJE9lQ+XDNyVCHWNfsrxQizmpWb9mJ8
X-Received: by 2002:a05:6214:5013:b0:70d:a9aa:cf4d with SMTP id 6a1803df08f44-70da9aad0edmr158898326d6.18.1756257623952;
        Tue, 26 Aug 2025 18:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj7mqvlBJ1auHCNj37evOwAu64GQSmzOL1BDuqIdwslMygY6vB1q7fRLG4+OgUF4zumDU1lw==
X-Received: by 2002:a05:6214:5013:b0:70d:a9aa:cf4d with SMTP id 6a1803df08f44-70da9aad0edmr158898066d6.18.1756257623302;
        Tue, 26 Aug 2025 18:20:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e60a67bsm24910871fa.73.2025.08.26.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:20:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:20:20 +0300
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
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-GUID: x9sNqIXjpJaEKT6fDHFhBw18xr2g2u_a
X-Proofpoint-ORIG-GUID: x9sNqIXjpJaEKT6fDHFhBw18xr2g2u_a
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ae5d58 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xnlQaYUteIq3HUSXtOEA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX924n9bzFrZUW
 1k0LOkCDzzXYzkoJFLmd3831S32H5bnH0L25tuaCiIkEHRGij9OSoMlRvVoOdxu0beYP1r5voA6
 NB/3MJUZcbu735x1lUVUuKWopAuvvbF3UGNjjojt3ERIHte3fMk9hlUozBLpYgST3mKvvGRTmW0
 5UcCoFmEwogUlHvTeOjrZjznLZ8olSgspXer2Og6WF+E67HtXaZvNruCuKo/ljpEpkxeeix2QXs
 6vXdr68GhMZIHlTcVNfvaDH1lEdCm5WOCXYMDvL2+oZ9n7kLhEM74Cvm3ZK/ez7OWI4New38HE3
 Na2G2JWN5GZlewyngK5MG4ecg1UKezS1zN+xUXxoT7eMSmNoVA4itDEH0KoBMNNh8v+DkbUssxr
 TGb9WIoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Introduce the SDHC v5 controller node for the Lemans platform.
> This controller supports either eMMC or SD-card, but only one
> can be active at a time. SD-card is the preferred configuration
> on Lemans targets, so describe this controller.
> 
> Define the SDC interface pins including clk, cmd, and data lines
> to enable proper communication with the SDHC controller.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> index 99a566b42ef2..a5a3cdba47f3 100644
> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>  			};
>  		};
>  
> +		sdhc: mmc@87c4000 {
> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> +			clock-names = "iface", "core";
> +
> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +
> +			iommus = <&apps_smmu 0x0 0x0>;
> +			dma-coherent;
> +
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +
> +			no-sdio;
> +			no-mmc;
> +			bus-width = <4>;

This is the board configuration, it should be defined in the EVK DTS.

> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			status = "disabled";
> +		};
> +
>  		usb_0_hsphy: phy@88e4000 {
>  			compatible = "qcom,sa8775p-usb-hs-phy",
>  				     "qcom,usb-snps-hs-5nm-phy";
> @@ -5643,6 +5673,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
>  					function = "qup3_se0";
>  				};
>  			};
> +
> +			sdc_default: sdc-default-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +			};
> +
> +			sdc_sleep: sdc-sleep-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <2>;
> +					bias-bus-hold;
> +				};
> +			};
>  		};
>  
>  		sram: sram@146d8000 {
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

