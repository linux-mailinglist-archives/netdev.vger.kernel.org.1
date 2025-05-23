Return-Path: <netdev+bounces-193147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA10AC2A80
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4371B1B679A7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457129DB8D;
	Fri, 23 May 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZtyZr2yr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D31B4241
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029157; cv=none; b=mBOw8ayNBQSPJlQdfeDkl1+Hvawp0hMjWVVeTi5CP8RNZTfsBf+5ug3jChyHRFWjevQBxTUwH17N0xxaFNIHC/fzew4FZMBiHyOeneXL5ZkGSZTTABCIwaC/6ZqnzIDTsRhNZ7CEpL93FQ9PSd0ZqHhHi6F0/+RAUtevyrdFDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029157; c=relaxed/simple;
	bh=UwjCwu+hoD5QvbENA5EagwHCA8S9dgr+/m5BQ31GkaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGC7KFSWEps+3/dEp3mxRrf+ldoHUhHcW9yDIsT9TEME0mh0fwiFKk9vFsh7vRz4xzyhG16XY6LF7VGUcvyNql20x6EWXq6hXSLPKstbxTj59pTvEJgV0bo7IzxUJEx64PuoE7OediAI/uy4D8GcHv9CacL1SAbVNVJHE0ljwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZtyZr2yr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBKmH6020598
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z9XB99CT/fAlMSiqksbkH8KqSrgQ0U0y6auihnvVBOU=; b=ZtyZr2yr5RVArOcm
	8nBdyIX9wsKyw2R0Injxps3ytEooWWxhiMs9+O96j1MSkwXYFYzmkxuitdDjbfYq
	vYu3FCMcwUipDcbyT8CSYuPHJIHyJLg13YeNNMxQQamR24N1DYo9yeXMgdVJ3Qbb
	d2UejA9PSFktGRqVc5lf/3xNQxa9x/LwRd6xp8Rl21G6U4SXXNHyYJ0g38eI0VZN
	6W8nSnQI14TnIubBbB0Zs2eSNyyc/WhvGyAXRduAG8iJoy8t9cEp5Cx+CfE3QYe6
	DXT562RkCHduDgdsVBFPFZgkaZbpAUIwGj+Qk9JPXHftYKENlLd65Y1f8DU109SU
	uvKusw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s9pb9e5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:39:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4767b8e990fso139631cf.0
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 12:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029153; x=1748633953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9XB99CT/fAlMSiqksbkH8KqSrgQ0U0y6auihnvVBOU=;
        b=et3pyS6JI2vPcxY3akY33Ir0op56lWUqVIicaCqhNLWNrCLDFt86YTvVgDUnIjJgTa
         IeoqYoJvZHWg3rKJlIjv5Abu0/WUYaD8FuaziczOcmWtba1ZkAFIi9oQsNpStZAVOaHh
         +dwgrljJnXnP7kek+wwbYC8dAkXYB/cW7+p7g+fLxvcPPRmL3Yp9z85amc2Odb3/lxtH
         /nUqNhkasxICzbkjc5CjhwvtpogI6ElrF5NmA6NGjbfM9EG1Penxs/sM7oYfkj0lAZrN
         H1FXw9Rq3sRv256AmmOj11jhCGsEoUiuZgEAjhppGApA5dubZbFBKc7AzT/+Z1pmJ4XG
         Us8g==
X-Forwarded-Encrypted: i=1; AJvYcCUKu4Nc75/alJlTBKcflqUFdKGJ0S/KqQ2/HiIrGtSt3mZKxsUT7su7Pyel5acU1dAWw18SLC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWuRRhiEDP0PI1nON92bU5nz6yvbxRhmEszRZpXOi/WiW51Rf
	oYesW+jEhBq4LObnt32HC9BGvcXT0JlfnT8KzpKxadzu2wRP2L3RxVgMEIGLuZHSQ3uET2+I+XW
	KZVhV/ciTqHYZaZyUjJGCM2qEAKV5cDBi/tRMw4suVyuQsJnwxUWULQLd5hw=
X-Gm-Gg: ASbGncu80fmwAqd5LXOTD+0pim4432OGAom0O+w+hIjs1nyeMGc9WlTljJlC6xK3c1I
	lizUu7YWRH2RkSXI2HIRIU2h18y9Itjk6GJqocO18XTuW42XTWmri33tTjCaObF8yapMp3QRfg6
	OWhpV76HglMc6hyJkvfl6Hc+F1LDiAx4UWyFrObA9ZRdVy9CfaO61Z+D6xLYdeT24kq6kNSzI0j
	luG89mG1jWN9EEierA5fYDZaZ2N9leRGrNab3dbUHHWH2OHCFA7GCmfCDKv0yURvf/KBMfJK2HK
	bnzRZfYCbMGMhSaUcW/1ukT8R11apw5p7Eqcmq5CHWxdcw4BcRreW0ydi0Kl9DbPHg==
X-Received: by 2002:a05:622a:408:b0:472:58b:463f with SMTP id d75a77b69052e-49f4625a717mr2813961cf.3.1748029153108;
        Fri, 23 May 2025 12:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnPTlDiHsFRsc/53DfqBHHewY94m5nSrjK/NZWsZOAvwCTZUQy5z9CnHlIfIbegggC4dKHNQ==
X-Received: by 2002:a05:622a:408:b0:472:58b:463f with SMTP id d75a77b69052e-49f4625a717mr2813871cf.3.1748029152757;
        Fri, 23 May 2025 12:39:12 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d438c3csm1266798466b.88.2025.05.23.12.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:39:12 -0700 (PDT)
Message-ID: <76267be1-1ace-437f-9394-ee56d4e8ffb2@oss.qualcomm.com>
Date: Fri, 23 May 2025 21:39:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm2290: Add IPA nodes
To: Wojciech Slenska <wojciech.slenska@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241220073540.37631-1-wojciech.slenska@gmail.com>
 <20241220073540.37631-3-wojciech.slenska@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220073540.37631-3-wojciech.slenska@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WJl/XmsR c=1 sm=1 tr=0 ts=6830cee2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=wQ2JREbYfKbkpeN3qpUA:9
 a=fFxRHlyTGdwQsMLX:21 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: KpG0roFJMjBZGxVdYee7bBqCRSG3oG-d
X-Proofpoint-GUID: KpG0roFJMjBZGxVdYee7bBqCRSG3oG-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE4MCBTYWx0ZWRfX6qzoIEn9fHRS
 SMeY4ktPaunT0viqv/Zm5GqjSp6LYrrF2R5kceuvaKqENf6dXrrnw8/35q5IR/7HhBe66H3jqNS
 ovTw7wanazx+w60LFLoXrFCzvx1ESGCJ7FPrVCtzb/nCt89Or0DEtAJKh1M/5YuhzeDRiE19XzK
 2xTQJnrVkg72UAKskvP09XgJGI1/OXsbhTOjBRPIwqPqJcqbnAzX5mk0MX/SBk/Q2I9DDHmWcXC
 Y//F7GrhrLM1v8Vlpawyr/9J+Kp0BBFx3uskVUUoTZafGqwR6Gak1wci4LtFcDUMK8UFwbCyvNb
 20+/x0i6XlSy9mDdax5Tgc2SniVfTtXMnslYi+SAI50gRDKjMqaMLJBSjxb8x95ekDO7xezMPyp
 PuDak/jWj5+6LeTpl80LcGRde9xYyKtmdQbMkEBsyrBFMJYunXMaQXl6wz98YGt8/ep+zG0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230180

On 12/20/24 8:35 AM, Wojciech Slenska wrote:
> Added IPA nodes and definitions.
> 
> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 52 +++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index 79bc42ffb6a1..0d39fd73888a 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -428,6 +428,17 @@ wlan_smp2p_in: wlan-wpss-to-ap {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
> +
> +		ipa_smp2p_out: ipa-ap-to-modem {
> +			qcom,entry-name = "ipa";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		ipa_smp2p_in: ipa-modem-to-ap {
> +			qcom,entry-name = "ipa";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
>  	};
>  
>  	soc: soc@0 {
> @@ -1431,6 +1442,47 @@ usb_dwc3_ss: endpoint {
>  			};
>  		};
>  
> +		ipa: ipa@5840000 {
> +			compatible = "qcom,qcm2290-ipa", "qcom,sc7180-ipa";
> +
> +			iommus = <&apps_smmu 0x140 0x0>;
> +			reg = <0x0 0x5840000 0x0 0x7000>,
> +			      <0x0 0x5847000 0x0 0x2000>,
> +			      <0x0 0x5804000 0x0 0x2c000>;

Please pad the address parts to 8 hex digits with leading zeroes

> +			reg-names = "ipa-reg",
> +				    "ipa-shared",
> +				    "gsi";
> +
> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING>,
> +					      <&intc GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "ipa",
> +					  "gsi",
> +					  "ipa-clock-query",
> +					  "ipa-setup-ready";
> +
> +			clocks = <&rpmcc RPM_SMD_IPA_CLK>;
> +			clock-names = "core";
> +
> +			interconnects = <&system_noc MASTER_IPA RPM_ALWAYS_TAG
> +					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
> +					<&system_noc MASTER_IPA RPM_ALWAYS_TAG
> +					 &system_noc SLAVE_IMEM RPM_ALWAYS_TAG>,
> +					<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
> +					 &config_noc SLAVE_IPA_CFG RPM_ALWAYS_TAG>;

this last path should be RPM_ACTIVE_TAG - that makes paths involving the
CPU automatically collapse (as per the power management uC's decision)
whenever it's possible


Konrad

