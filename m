Return-Path: <netdev+bounces-223900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A619B7EB7B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9532A1C0461E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFCF305E09;
	Wed, 17 Sep 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MIaj6d43"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE23305E28
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096421; cv=none; b=iBFOmOK0PxeiXLSxuoFjZpR9+4MESqZEgK7PZZyWF9F8rbA9lxJQSXGi0kUAKzaEHpIPgWXuB1DOjegb9oCW+GQ+SWPidLDEhQkTzP8qKdUv4k6okpXxl4BkCQUh3VQPEBb/G6zcleDOwovDK4J4VOoXjn2+pGR3hlvkD8F0tBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096421; c=relaxed/simple;
	bh=99E/Q8dl1z6a1fSwTsa33XnQl0e7pN1bDPF/vKPOGmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncJEdAPtDqpTTIQyZEX+KW7fNZXLv0TJAIKpgYrOO/CILGCi5RMr6TDtlPSxMjKHDWA3yoBW88Vwim89wHmpNwqwQRqcrOZkM3/ParPZTtlANsnorzNw7p4wBI1io7XR6rvDwl8K5K2B3I+oyBNaw2rWeZxED8fnpRWOfb6lND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MIaj6d43; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H5QdUh031523
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c4+1T7hrQrCbgIKXWS+wJqveQlpBa3wYZt9yOaHwkvU=; b=MIaj6d43UK9ZQSx8
	agM81e5wqoSWBC63D43WjsF1gm5IB6k/xb2BpVZo02QhE//HDj4YZ0HW4pKmu6K4
	aBDGT3bH/DZIWE5OLCyG7elAqlIIaR9pO5kL+zq2+Uaq/raR82fc0MvpWJOAC/A6
	I6qnI2kA6wvFxm+Iz42kP1C15JzKsqH5jKlFIvI7h7hhWtNLPcMcTdpZbXLQADtS
	y/3kf/z0catX7heqa8vF7T0miUEZknxZ99Sc7Jhry8IApYEKsozHOqTGI8vkraD3
	hrseruWwNV7XY02zlHATrDUAUvvXqkTdl/8tkjyZMWyc6W4rbvXFNx9vEo/cA8yH
	w/bkWQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu1hqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:06:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2681623f927so4243585ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 01:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096418; x=1758701218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4+1T7hrQrCbgIKXWS+wJqveQlpBa3wYZt9yOaHwkvU=;
        b=n1G0UIZo9qqBp3X7t5IE7i0sxJKJ35v3TmeuJ+MJOlxPeEgIshU9BhqhwS/EiwnqW3
         bNHQNdHPm3bMGpwSBE/6czyebGcCVCtTzooEgUXOfZuRcv9vQEWuz2waXMbKbzoxy3UI
         eFfY6NNU33rtB17tm9GYS2ENVbV/+rtMG7JxCj85VW9bStQVZ52u+oePteqTkkGabpYj
         mZBZv/I0rkRN1m2g/4AgJyUIAYwvgKDU6ry+gfQueeF86XGtfqJ9m0jUjF9+Pez6ClSs
         v7sMiynsVuQ+a5wRLzny0+C9TR5Jm2x5i6fk1feuFvbqsoDujJWJFTfWkfZEeVKJHRqc
         rDMA==
X-Forwarded-Encrypted: i=1; AJvYcCXcLgECsbWR6mv881DRgp2yP6lZ8YA6oZHo+nCbySZXl/ffh5IrCf8UNbfgUAiXpt1oZl9hWL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJngpczVrpiXSluh4r5S0yWRk8z3QRVndwCxH/P0zcipZX4bIz
	dHc+zpe16wd40ErFrMqFV+oVZfq928DNuAMKQx2apxGPehdeMlHrUvjqSeaJc1bij2EYaFy7OZo
	VzcZEZVv6ZfwHFfydmbXOaWrCZHr6cYJdEntbvrTs3bEnvEvHAykPPncekMU=
X-Gm-Gg: ASbGncta3yh4473Wl1rtUVw7lIcWYkkDOg4vYqApz99IzpqiXAU8Gm4R6Pg468ZeFSf
	AWFieTc6JUdIrqy6feq+Xg36a7K0Hr7orTwrBghQRyu24alt8jfNQDFqueFCF9i1M67LdGgj7Tp
	bjxAIUBKFNHdYqbiDEXZOq2w245TiFN4JOHV5W0YphbZALa7ffqmJAZvuCMhzqTRfiltQnI3mRG
	XKB7PxlEXhVanNFJpyoAdyUgQXVZPwjn2TrnRse2vEoQbmWIWpBVD2ipO/xFdJuzUyZ3cTIYUhm
	SMFzXOGFfsIScZF8dte+1xF65f5ZQiZQsq57LKrCLTHo0cKj6nCmIOc=
X-Received: by 2002:a17:903:8ce:b0:24b:1609:5e2b with SMTP id d9443c01a7336-268119b3b6emr16788385ad.5.1758096417023;
        Wed, 17 Sep 2025 01:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5UMbMaWJIzZ57Vql1tJjVuAN5j2QcuMqGy0y+1atO6oPbE3RHp/4BjwtArBerLWUYCCdoJg==
X-Received: by 2002:a17:903:8ce:b0:24b:1609:5e2b with SMTP id d9443c01a7336-268119b3b6emr16788085ad.5.1758096416585;
        Wed, 17 Sep 2025 01:06:56 -0700 (PDT)
Received: from work ([120.60.54.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm1177088a91.18.2025.09.17.01.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:06:56 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:36:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Subject: Re: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <h2t7ajhtyq3vivbw67tifrn73i4zisicoktsgab76zptxre6at@vl2q4d6i3lms>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX72wqi4Lo4ZAR
 u+MRJ5/hFJ2qEpmEZ4NlNMHbjWh6VgCk8bATC5EpM2F9sTu7XhPEQjUO8ONbxbX8FMqvd/CU4gG
 kzyvo5kc7apj7aVVeE20HHWGAf2NlSn5B6+Iml8v+KX3NMVVGAK+6/H+WIPuG3HqcpaUj3Lc7Ox
 nmRz5Iz1h8VPjKHjo67CSEPqCjzsIPdSYMhbUGLuhBLgG+InKeoKN495SqyX1/NVHOJdoJHQ6uv
 ft488Uoe0RyPTi5BV1lwuvaGppbFYjEu11jDL1S5SQeLoW5Ib0BoJ9yLcePDnkuSduw2xNx/Po4
 wU6Os4o/2ag8crAbmqKsYHVu11EkfRNC5VGuzWqdrMqWU0pLIcfSJ9Qs8x+74+ooe8HZFSTwOAY
 dv04g6M5
X-Proofpoint-ORIG-GUID: PHOqwFt7tD5FQl6UxbUTqtjAyCQowZwu
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68ca6c22 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=zfGe9qrPU0lfmTaoSSnydg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=qGp1FZVzPMbQ2NxWyGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PHOqwFt7tD5FQl6UxbUTqtjAyCQowZwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Tue, Sep 16, 2025 at 04:16:53PM GMT, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 

Where did you define the supply for M.2 connector? We don't have a proper
binding for M.2 today, but atleast the supply should be modeled as a fixed
regulator with EN GPIOs as like other boards.

- Mani

> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index 97428d9e3e41..99400ff12cfd 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -431,6 +431,40 @@ &mdss0_dp1_phy {
>  	status = "okay";
>  };
>  
> +&pcie0 {
> +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	perst-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie1_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l5a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -447,6 +481,54 @@ &sleep_clk {
>  	clock-frequency = <32768>;
>  };
>  
> +&tlmm {
> +	pcie0_default_state: pcie0-default-state {
> +		clkreq-pins {
> +			pins = "gpio1";
> +			function = "pcie0_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio0";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pcie1_default_state: pcie1-default-state {
> +		clkreq-pins {
> +			pins = "gpio3";
> +			function = "pcie1_clkreq";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		perst-pins {
> +			pins = "gpio4";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		wake-pins {
> +			pins = "gpio5";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &uart10 {
>  	compatible = "qcom,geni-debug-uart";
>  	pinctrl-0 = <&qup_uart10_default>;
> 
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

