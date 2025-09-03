Return-Path: <netdev+bounces-219624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2DEB42658
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F2916F785
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F852BEFE8;
	Wed,  3 Sep 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcwnqjG3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DF2BE7A0
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915987; cv=none; b=AUA/UVgmF1b1MG4//tZq+zHWcaRBMI1wPYwMv87VCKnYrOrMHBtKmUB3qLmCCpchF+e6IHmPAo/N1yZtDVDJZvnZ3mpuaIK6Ob+s3prmXHUe0Nd4zdg7C9fGaFRzYZATlM8cbDv2Q036d29jPardQlDLipyHUAfe6Wn3/GCrGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915987; c=relaxed/simple;
	bh=npa6VTO3UD4EmfEg4HVC1uujU7lkywOp1bop//9kLe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se4Y65uGJlLny6bXDYxc1j1rhtTYXGFHY2Xg7KXhJk73/B/Ifj118IqqMdBV5qyil5+Gt2LkcieTtDkNfk5aAgyUgo5lRWVluAbyxt16PE5eGpI+0tCUBSyCfeWXmBATRO1yqX33n3LLrKUhe3K+Mc2//tZj3kklgvD0NyVuDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RcwnqjG3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx96U001019
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 16:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pKeGXm8jI+JpucgwsLhCt1MqYWl2JGrUgMOwCF0ZLRw=; b=RcwnqjG3gzZFzE5y
	qk0DpNv2Z9TZ/bvR+tO3S4pDWBBktCGCpsH1epbK0E1RpKxO2iLyG5xmhciO2pKt
	qCU+iB4l77rt009pAJYpZmWzNzzC6whn7GzU+IFxXVSxW7i2EG6Bmk/6gEBkPDT1
	DjE0WOfBwjNYbG+qwHdqww/EIEvnIk3fxh6yaPQE0JyHUAsOebQH28DzBNrKDLFO
	McOgq085DUVyLmPxGlqK09VDyxDvLJI2hZjlEn19Jbf5DaHLfVTtP0cxC/KWi3K4
	cfXSyFe7/lPyPeS5SZeC5FyxM/EE30UXGx+3w5XLDCQ8QoTjg8oU9f5gdl2InkCe
	zawcTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush348ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:13:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32eddd8a6so90741cf.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 09:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915983; x=1757520783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKeGXm8jI+JpucgwsLhCt1MqYWl2JGrUgMOwCF0ZLRw=;
        b=UdwoMRQWNfJdOF/tFgjXvvva8iWi3MfU2XukSBhfA5D179s2gwQbyGESyRJt6WRerz
         W08+enuG043DFqLabwSIsyLYiUejhEVAY+Pm8D4mrLYVWHDlB3ZVyH+vmcC2Rd11mXrn
         w2xCoMb5BS63dDA+8IT5z9tS+K2Gpag9DJB5e98H61fcly/za+RcKXSBIUGHgTrCagwn
         jQaT2tjZkmqqA9XEQmDMrsjdmpyTfd/GXhXj0RXoi/YY29zXo4HrVhlyI8Yd9ZXoXpDJ
         bDhMpcxCTHRHSj0dEI5g6E9RxZmPhSjfwbYnIDZ1geKgyd0/Bi8zndMJ9OLeTCv9QRuL
         3Mhg==
X-Forwarded-Encrypted: i=1; AJvYcCWCz8jO+ZHS39V1mn5PC6DMHJrAA7D7iCuybDiV0TXf/jkQ1bpGKPgxact58GtBjMT6w1te4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+xTNOJbZ3j9NAKxfvvoUZmLoltmd6sfUo/rhwiRECbdFEBaj
	QQFu8lrZxoWFtueSCAThBnQLiYPpznX5Ldcd4v3C2v4woFIKYTU1NNVOqc0hTaAmP0H7FGakdyB
	a9cwof26XoL6rFS/K34Sid31UHD/XGbv1DmPfSeZna3C4DjgzA679hpiArxA=
X-Gm-Gg: ASbGncvx5iaNImQoT8US0EfCmVR/nbWF5GTbclvO6Exx+CWAHPaak5a/Cl8LQ79lluY
	kBZrydrS3aXHUkFu9y/5qJIkLKl2tNXySH61kBXK7VsaxybMI0GfCHqF2JM3hu4jDwg+eWXUIO/
	/E/TeKWCkDX1VaGu4TnV+cfhDMOcVk0ZiRQMicUim0Jn+9sRatEUqoUciuj5VtholcsMioJrSH7
	tjYt5GyToDYdeS5HONGoM3bJgnR0ysLr9cQ0bM69GALg7yC4xt6kR9695+5mBPGCPTIS8bC4lA/
	l8rt1r1meJ1qt5EcBQB32I6LKiQjUSTVmGTb5ABMothP4KpjHcuZg0UvuXHOnLRpAGF0oYjsiVu
	BO3alBX7CfHqpron4Q7pKPw==
X-Received: by 2002:a05:622a:4506:b0:4b3:4590:ab74 with SMTP id d75a77b69052e-4b34590ba5bmr60324161cf.13.1756915982745;
        Wed, 03 Sep 2025 09:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfWwWchCPw1ePeEGx4qP5S7OYtJkgaeMl5VvODCf95CzdX3BdtWxnPTsVZ03+bkL8BPje0cQ==
X-Received: by 2002:a05:622a:4506:b0:4b3:4590:ab74 with SMTP id d75a77b69052e-4b34590ba5bmr60323761cf.13.1756915982100;
        Wed, 03 Sep 2025 09:13:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04110b94cbsm1003115266b.93.2025.09.03.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:13:01 -0700 (PDT)
Message-ID: <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 18:12:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and SDC
 pin configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1rrUfANDMZRZ
 SmKW3QMv9ESg84Dt+lpOuiP6kWKa0HFYHuJrdTyVfCNMcBvfly5qS93h/kKkJxOLFk6ZN1eqVCL
 s5DR5VaAGM5cOjrToAm7zpgE9a39kcxPG0wbma5XKabOx1HvdUMG18Y5Ab+Usryvx2iPWV3Ov4G
 kQdgkfDFMElZFvP4q2xtfLseQcPko2sV2HpasBkmImLWEIf/kkLXnVkVJEKewBg7KkquXJb7vjK
 wytGQtTK3Vme0IXxxPaIJWyyVmHJd6J7slLxyzh/bOYx6a+jyleCNuuv2cRHoNkN06xvUIof9Bt
 Tui3i6/yGNfcSK4R2OosFeX2a0CK99QdFQIiPSakfvGV1S312hPAkDm27NGTyJ8UEkZU+uOtXms
 NptzJTFr
X-Proofpoint-ORIG-GUID: KkgHzj77Imgx2XHNXY3TgmmiWBR15ZwO
X-Proofpoint-GUID: KkgHzj77Imgx2XHNXY3TgmmiWBR15ZwO
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b86910 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=onm5DRxEkm4ScgEcFVIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>
>> Introduce the SDHC v5 controller node for the Lemans platform.
>> This controller supports either eMMC or SD-card, but only one
>> can be active at a time. SD-card is the preferred configuration
>> on Lemans targets, so describe this controller.
>>
>> Define the SDC interface pins including clk, cmd, and data lines
>> to enable proper communication with the SDHC controller.
>>
>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 99a566b42ef2..a5a3cdba47f3 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>  			};
>>  		};
>>  
>> +		sdhc: mmc@87c4000 {
>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>> +			clock-names = "iface", "core";
>> +
>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>> +
>> +			iommus = <&apps_smmu 0x0 0x0>;
>> +			dma-coherent;
>> +
>> +			resets = <&gcc GCC_SDCC1_BCR>;
>> +
>> +			no-sdio;
>> +			no-mmc;
>> +			bus-width = <4>;
> 
> This is the board configuration, it should be defined in the EVK DTS.

Unless the controller is actually incapable of doing non-SDCards

But from the limited information I can find, this one should be able
to do both

Konrad

