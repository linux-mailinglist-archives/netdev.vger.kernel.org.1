Return-Path: <netdev+bounces-217900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0E9B3A614
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157091C83FE6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ADC322DBA;
	Thu, 28 Aug 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6/z6yMr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552A3218C6
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398073; cv=none; b=GDutP6X+U54mN99rTHgM+kCfUoeDzSFDE7w/rWl67Djc+FCS+QWa2OTr+2Iv9deRUCEd89ksKNMISynll4QJ7ww0jIlmnzBAhqagrlbMcolk5u+RFbxldJL4PdqZyX0eVzwpcUZMNZIOJzsNq/n6zHHM5wpo+R8vrlClWu4Kc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398073; c=relaxed/simple;
	bh=vTIbUfp/TwWtKVCv1PBkdes53gCsIg9GIJLhd4qrAtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYV62gY9k5A7O6B1g+nLE7u8+CPxjjPSmDyA/lYPhyGZZOsCDQw1IragnEFChZcMnNl4Kwwn9pbIzc/dCVi+vvH11suaM4Mocj1EJJby0x4d3wuUs+UOEouupRPs8/ZA2qXjJVMenuYlqge6iEK+V0m8B+1Ne6u/jaANMmkO2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6/z6yMr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEe2D0031265
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	znAsb+ZopRvgTds/k9cU0hyb9L+YL0iI3cUXpo7Sukg=; b=n6/z6yMr2x4wO8ff
	1MQHumuiEMAEzF/ryFPkmifwGexjDIkRYnJFNGv806Z2cuxP1QA9RYtNW0FU2ZwR
	TzYcI6ay0DA0VrHLnQgSwte5HAUkGXmQy+1GP9vdpi61yDPCfHUMXZ4018IFqUcp
	bgN6RYYcnaExMR9TUvZ5mu+lv9UK+Vp7FRGgugYXg/69qqSjyx8MPhkHjQobUIIZ
	DX6av4rlEZOaARaIVD7g24PYfxHjTlykgHY5QMsLeCIAZ14D49wQqjSJvEHsp5/k
	hDPzdRjguLR+5XawKvUIthuZJJENfQMSdsMeeY3mfSi7lagd4lfI4r1DOQIMuUA0
	HIAULg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615ru2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:21:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-771e1451631so2299380b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398069; x=1757002869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znAsb+ZopRvgTds/k9cU0hyb9L+YL0iI3cUXpo7Sukg=;
        b=Iszb4qNsZKfAbhGVLngtIostpLiVbt0PdD90RXong6hPORIpQHZa4aTIoKZUV1JN+W
         aYxhSSWsYvItHVfIelii5QLXw9JRtnUUSdCQEe6OqeedGTg+O3URXxDmwsUDyisCrcJH
         l5dzwvGJFjuLsUxBZgkwXR9M1aEah+y1MdxueixL4naJ3rTMQbV72sWprIgnPbF7w9Ls
         jMvbxnhnWmo3TO7hk8dNnKvm5R+S6rf4gpaiczLs4SARIgIv5BfCKjfFi1DcPtVTHfz5
         bz51fANPyvlhfrGgD12JCBzM0cyuFq1xPW6tsTWMlV1xTxNbZxaf6lyH4IkaNnWluYa0
         kYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsqSJa4phOTuD5BH5027Ng4dGB1AaIIOthh/ZU/ekTD2oTHzfHN+UQVwAFcFmeZBhdbHYlwSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DapnHPp+jX/uI2eixe4se1DvLU1KTYx7zVGQymoDwYs9qfl0
	AJ3LMCAawKbBl/qiYfdJIdLbhk2ccqrc1LlK5jfFBSHhpu+bxt/2+jsvR5w2im7nVAh7nIwP7jz
	lD9Tis45xJL5mcucip95PyyYN/oekjFWdiwOERzWIREIUVO4wFNrsqhZLoHY=
X-Gm-Gg: ASbGncsbn8kOfapZoQoVeDxV51zGp0n4YGsCXBPkzyUj0WQ+Z1TY8ENqNMHc6ZePDP1
	ZpW4PDD/dh5h65JewUCuhZgNxM//EyrEAnvBb19DlLDVwu7vH/ap3tfMMYs7uwdGVCvLYS8jB8X
	6wo/95Z+5c3MHBe78S9gHo61UEW4nHOCvqdo4u2WJfrPZ/2rauwaKSpybED1rcOlKOx/52LPILj
	epdu7IGM93mAoqY1dxOtRXvxFFNrk5lnt5Tm3QKnV8DDHwMkoTDim7eNaUZdUQ5YEQusEiI5O/6
	R9nmRKPnB6/wChX4SDRZC1hTL6B0NkRN7RQuhrttKoSGzCynaxbWVT0FRNMeZhPQTfj/vwM6NS8
	AXT3hwUo=
X-Received: by 2002:a05:6a20:12c1:b0:23f:f7ae:6e3e with SMTP id adf61e73a8af0-24340b5b1cdmr36905314637.24.1756398069267;
        Thu, 28 Aug 2025 09:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExqmXUxvYw5B6SH7k7jHDWdLt86kgIQlso126aaCZiyRaXqp/vbw3rwGx74MyI6sC7Kdf75w==
X-Received: by 2002:a05:6a20:12c1:b0:23f:f7ae:6e3e with SMTP id adf61e73a8af0-24340b5b1cdmr36905266637.24.1756398068796;
        Thu, 28 Aug 2025 09:21:08 -0700 (PDT)
Received: from [192.168.62.36] ([223.228.107.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8ca240sm14446086a12.25.2025.08.28.09.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 09:21:08 -0700 (PDT)
Message-ID: <4cc22d40-d071-45c2-8618-3d93ae4797e2@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 21:51:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: lemans-evk: Add sound card
To: Bjorn Andersson <andersson@kernel.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-5-08016e0d3ce5@oss.qualcomm.com>
 <kckx3uwj2zdc4iagsxhb6osyv2ki7n4qubyldnvwokkkftda77@ixrgr7vapwxj>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <kckx3uwj2zdc4iagsxhb6osyv2ki7n4qubyldnvwokkkftda77@ixrgr7vapwxj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX5CIv2uUmL9DY
 b3c4T+RiXrbSg3LhLnD1YyJ1JyuY1urQwNa5U9kk3AIxUA9KbiNxe87wnSMdo6YVEAFXjTOTM7i
 gR+O/v4wyYV+KAuKc1MBKSqyNOWuKsIuJfmGg6+3NAUOdGsIaEIJpml5cmGqoukgtCT08HKGhOq
 NLtF2pFPCNpp557s5EwHSi3RAgUV7uJzW3QtRGoqrNk4velySBMOV8JSR1ILgc1QPtjhGVksV5/
 N1dKv51++cRSBeemhMLeOuRCh0TmYWwYhQblK9nqgCq2iWHlbI+ASPMdMBSkJefP0R+ozRhMr5q
 hVFroVHfO/mseXnX8Kw3kFeIA7QSo88Dg9quTafvhB1pzOPR5jEzdMODKQORJYR93rW7gmApkMa
 /XZcof4D
X-Proofpoint-GUID: 2vEBnkvvONSZ5C0MG8yDCD1Et6y7Ph1m
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b081f6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Tcuekwa6JFTrCABMbcRULg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=wk-bp5ZmwQyaC1E5B0gA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 2vEBnkvvONSZ5C0MG8yDCD1Et6y7Ph1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034



On 8/28/2025 4:37 AM, Bjorn Andersson wrote:
> On Tue, Aug 26, 2025 at 11:51:04PM +0530, Wasim Nazir wrote:
>> From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>>
>> Add the sound card node with tested playback over max98357a
>> I2S speakers amplifier and I2S mic.
>>
>> Introduce HS (High-Speed) MI2S pin control support.
>> The I2S max98357a speaker amplifier is connected via HS0 and I2S
>> microphones utilize the HS2 interface.
> 
> Please rewrite this as one fluent description of the hardware, not as 3
> separate things thrown into the same commit message.
> 
ACK,

Sure, will rewrite proper commit description in next version.

Thanks & Regards,
Rafi.

> Regards,
> Bjorn
> 
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> index 642b66c4ad1e..4adf0f956580 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
>> @@ -7,6 +7,7 @@
>>   
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>   
>>   #include "lemans.dtsi"
>>   #include "lemans-pmics.dtsi"
>> @@ -26,6 +27,17 @@ chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>>   
>> +	dmic: audio-codec-0 {
>> +		compatible = "dmic-codec";
>> +		#sound-dai-cells = <0>;
>> +		num-channels = <1>;
>> +	};
>> +
>> +	max98357a: audio-codec-1 {
>> +		compatible = "maxim,max98357a";
>> +		#sound-dai-cells = <0>;
>> +	};
>> +
>>   	edp0-connector {
>>   		compatible = "dp-connector";
>>   		label = "EDP0";
>> @@ -73,6 +85,46 @@ vreg_sdc: regulator-vreg-sdc {
>>   		states = <1800000 0x1
>>   			  2950000 0x0>;
>>   	};
>> +
>> +	sound {
>> +		compatible = "qcom,qcs9100-sndcard";
>> +		model = "LEMANS-EVK";
>> +
>> +		pinctrl-0 = <&hs0_mi2s_active>, <&hs2_mi2s_active>;
>> +		pinctrl-names = "default";
>> +
>> +		hs0-mi2s-playback-dai-link {
>> +			link-name = "HS0 MI2S Playback";
>> +
>> +			codec {
>> +				sound-dai = <&max98357a>;
>> +			};
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai PRIMARY_MI2S_RX>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +
>> +		hs2-mi2s-capture-dai-link {
>> +			link-name = "HS2 MI2S Capture";
>> +
>> +			codec {
>> +				sound-dai = <&dmic>;
>> +			};
>> +
>> +			cpu {
>> +				sound-dai = <&q6apmbedai TERTIARY_MI2S_TX>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai = <&q6apm>;
>> +			};
>> +		};
>> +	};
>>   };
>>   
>>   &apps_rsc {
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 28f0976ab526..c8e6246b6062 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -5047,6 +5047,20 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
>>   				bias-disable;
>>   			};
>>   
>> +			hs0_mi2s_active: hs0-mi2s-active-state {
>> +				pins = "gpio114", "gpio115", "gpio116", "gpio117";
>> +				function = "hs0_mi2s";
>> +				drive-strength = <8>;
>> +				bias-disable;
>> +			};
>> +
>> +			hs2_mi2s_active: hs2-mi2s-active-state {
>> +				pins = "gpio122", "gpio123", "gpio124", "gpio125";
>> +				function = "hs2_mi2s";
>> +				drive-strength = <8>;
>> +				bias-disable;
>> +			};
>> +
>>   			qup_i2c0_default: qup-i2c0-state {
>>   				pins = "gpio20", "gpio21";
>>   				function = "qup0_se0";
>>
>> -- 
>> 2.51.0
>>


