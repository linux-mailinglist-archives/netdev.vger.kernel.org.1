Return-Path: <netdev+bounces-219649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44AB427C0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCD7A7760
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E6320A13;
	Wed,  3 Sep 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FK8sRegv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B7242925
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919819; cv=none; b=i6B7Tc6d4o8LthIczfd9C6q3u1ll9iQ4G+rrXoqQQERQUFryIs9U6K4RDGmH+h+02zB+drc/t6RDhdYwaPlj6e8XB2tDgLgtIMROkwGFPHdmrhaYozlFO0r/ikd/IIb3cOjjtUwlOU/N0cmA4yHAB58YFFygG3wH5bztXSzA2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919819; c=relaxed/simple;
	bh=nqlFhZhzUZ+Vy1SQPrseXFrBMF8Y98aiCpXePUraDik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6jFrN+oGv1UNONnBHcqiUd3jRA17QTanh/6nYqlyNOOgbLMx1xjvKG+e/BAVHmXQo86ddJEWAB2GZnEdJr2/28QZoTcOHuA2TkQcpZKM4Mu3Djk1Wkz2bQLsMAVqppcoDRvfc26WoTsFLDc7EYRsEC24h+INg6zCpkks3pp5Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FK8sRegv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwof7021252
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 17:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z7peoZhXj/0Yo2bV05F9I7qJDdTJs3fB7ALaWzJ/+MY=; b=FK8sRegvj+nzad/G
	x4nwE2u1SOyjQfNpCwU4f8nF2eyv2gn65se1ATns8YjKgpa6WqQniAvLdySSC2So
	ytM0qWhSipr0DmresAQA1/+GZ6Jj0Lxw/MybC+Ey2Wd9KiSFSwf1oiRRYjVccMx6
	8RxIEwk8WF8/FoQqDiXOs0DFOgBd9VWM9BqO0c6p0CXx/fLS4n7QUwJQMWG+aowr
	IsjKFBIEnnN5xQAWcalfDQrhTt/ZFQwsy4/+fTiLX9RMsx/8l/h2SME67nh4DbSR
	BUU0UzIY3qQpvozGjYSZrLjYkr4fhrBj6Tb8Wc5z/iM6py7qRkFDXDSSkw44Lf6/
	ZReCeg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0emrf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 17:16:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso396331cf.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 10:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919816; x=1757524616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7peoZhXj/0Yo2bV05F9I7qJDdTJs3fB7ALaWzJ/+MY=;
        b=MVz9TzBssqZPdsnSGVCyPtUZg7sF7aGsc3IBAL3zjxcgXTxVSQa9RNwPs9GI2SdWDg
         GvKMKNGHRF++iXJY10f2TXo+cCmh+UHIYncJN8rMKiMfArdZ9X8bw8WzFEoe3sbPpTc4
         OZQmcPkxXBfcXHItmPzp/EABT2TSicGrb3cn/bTz8qRYFZ7vmIN4uxmvWtQ+MbVlosxZ
         25WV0GS6dmn4VoB7aHcc+f+Ja0A3Yv3pTC6VADxrCh27kvb5GGZPJmGS/Du/xXQMV7I6
         /JP4rv1MRBAKAZ4zAzwHVOsQ/IdTOFLWul0qGH/+lyEjfRMDe6xZY26kl5h5PwVIz8OC
         uhWA==
X-Forwarded-Encrypted: i=1; AJvYcCUB28RbaKrF+G4g3avWXJZrpoP654jULUWGyX4b4K91Y72VOjyBnl6RQzxe/ZWhcmrBDECU3no=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnHvomoyX6ZwtTO8sRBhVAxYTH2VthQ0Y4qD5zKPIviHJrXV5
	25gzUysEXJdlHoQx63kyHcqOiuWRIOhWaXLKhFuqYLlvML1N5tG3v8/QE5+jgaGF9xP25oi2S7E
	Wy+rhADilZoEDMpHiHnN1XJImc3B38ww7zKHcpw0JNeeym9uwq9FVuG91kvw=
X-Gm-Gg: ASbGnculGuiOURwWnSvVeo2R0rLslFjFwa2uUhwWEJGi1EpirgGdYpn6BSBZcoFUjnk
	Ga7otB6pi1LjjAwX1nKcZZw5DxoIrnm/SiXpnU9sqbRaBFWgFyZIL5rzlJOS/bq+EpAsb2Rteiv
	VwgRqjYZ6wS6R+688f+JSF/4oAhxq1oTtBTZnSx4ZVWqqurvW0mCENH4T4RoJqzmxjquTZ9zGcM
	j1fPkvrD3buMiwS+DMx/Bicc0wzyP+bNRl/GZLiBYe2Cvtk5gsnKSNIwNAa/18GCmMzW8z+LWF5
	eqtUY1kdj23+DQVWoiwT5PxJPHKU+rnWazoo0ABCu3kb7FjWt7BUurI3Vd1MDljvoHnY6QO+nKq
	TulQibuUoyfli0UFJRFg3hA==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr165737241cf.4.1756919815386;
        Wed, 03 Sep 2025 10:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzufSNCOLJcAHJBeXbkcXSuchMY9E0g8OI9XBOLb45HVfhiGviTYDOVr814FhPcFk6atK3Vw==
X-Received: by 2002:ac8:7f53:0:b0:4b1:2122:4a51 with SMTP id d75a77b69052e-4b313e59df0mr165736731cf.4.1756919814748;
        Wed, 03 Sep 2025 10:16:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e50fbsm12023875a12.38.2025.09.03.10.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 10:16:53 -0700 (PDT)
Message-ID: <7234085c-55b6-4131-acb8-a4ec097c6668@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 19:16:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WxncyGQTLs3kF9YZ3o_LmhnG_4GAHuX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX06vBQ6Y8mnRB
 04sAb4UjAovJ196f1bYB/BHaa8zdTIEl3wVbWBwwaxgTjEMqNx2FrgufffxVKmZrIp47Nc8/IYg
 GyQ9swz0anpyCvdWWzUXSdmbepqfg4s03V/wOQp/n8PtIMUL+UBqMW7LeHXGFrYdjUH1ZS4hPPg
 VR9xyDbod//O/jD5cenEkN1RgnNuxWddlqTLp8MbzJ1PXm3hppBBPBQYwjlXGb0fjCDgRAZ3Pvw
 PfcQYzYWC+Uvw+tNDdMyy06POfU23yA2jh0M86tewtX2NhvOqT9F8Ip//VuluEsqk7f6ZkAAC+e
 ZeKtIGdAbjIzPk1waww3CwvvPjY0szhpGB7Z3kNX7grLozn7npdfgkX0H8YTCkS+8/YPIaEy6nO
 A8KKZDmg
X-Proofpoint-ORIG-GUID: WxncyGQTLs3kF9YZ3o_LmhnG_4GAHuX5
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b87809 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=_TSgDihk_Fvy7NELKkkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On 9/3/25 6:28 PM, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>
>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>> This controller supports either eMMC or SD-card, but only one
>>>> can be active at a time. SD-card is the preferred configuration
>>>> on Lemans targets, so describe this controller.
>>>>
>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>> to enable proper communication with the SDHC controller.
>>>>
>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>  			};
>>>>  		};
>>>>  
>>>> +		sdhc: mmc@87c4000 {
>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>> +
>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>> +
>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>> +			clock-names = "iface", "core";
>>>> +
>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>> +
>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>> +			dma-coherent;
>>>> +
>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>> +
>>>> +			no-sdio;
>>>> +			no-mmc;
>>>> +			bus-width = <4>;
>>>
>>> This is the board configuration, it should be defined in the EVK DTS.
>>
>> Unless the controller is actually incapable of doing non-SDCards
>>
>> But from the limited information I can find, this one should be able
>> to do both
>>
> 
> It’s doable, but the bus width differs when this controller is used for
> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> only what’s needed for each specific usecase on the board.

If SD Card is the predominately expected use case, I'm fine with keeping
4 default (in the SoC DTSI) with the odd user overriding that

Konrad

