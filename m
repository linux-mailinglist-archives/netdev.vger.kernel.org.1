Return-Path: <netdev+bounces-219966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E34B43F10
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C925A16217B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C19630C341;
	Thu,  4 Sep 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXt1iG0a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC730BF62
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996453; cv=none; b=cVJRKMeW/guQ9OTpHZ+6sGqVSELeerK5LNyBNNVwhJ+kgn5TsA+ZhBSyvPzhu2DVTeofns9Ygrt296bZlVqKV1PwgDhbsFh8tR7bc9zM5JGD48N424eA88dRvv2EhNj6hr0B/eMNiMLvFqakEfW1pj2ukEgu+x1W39EN7HN6qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996453; c=relaxed/simple;
	bh=9kGLZsuAUdIFYWwz5hLauSws155ufe/wyvzDGbTeJKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSatk6kT/jwPukfWgukNUjuqfPLPBmNa3rn5fFfm2vuNhMUHXS8NJ4y602O9P916NNzqpQpb+o51vBJ/RD++4yz/p0AHHKCYyEHQm9+x6dN7tX7fqptqls2TAk8VD476NKcCN435s7vmtjj5TNDGfSLdVIcUys5a7NfCUf3QB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXt1iG0a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7c8013973
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 14:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCrAy4VBSkToOvA1xqFBwYaPjkxY7aXwIQYFx4Hsorg=; b=aXt1iG0aMxe8G6oa
	9TMcp8SxOzjrLwZHlbrpP3ueeTw1RVsU7KX3aIPBqu1sE3S+G6kI+8Wp1JW/kGom
	WVOoPXF2346qLO0Zy4BzFyVsvo9BrrlLFrgcAj1gMHvDZl/ZAv8wZCcs3XpyC6xj
	eVABlJW79vRjLVHhRvm1vO1KTebmvcXBzzYaY/t8uHrZ7zWyAPPCDTxbCj6G3RCn
	dT6IYyFes2oetlcM+4sA8lmnZJlcW8qnb70LTM5haX9GVuBn63uKLqO9KHcRbnuE
	rBJIah4/IxGhB8OGZpB0LTPL1ASgwiJ79EYF9bGp+iSg6ggyKrCoqF4LJmfsnizf
	dB0QqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv7xuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 14:34:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3d3fc4657so2003231cf.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 07:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996449; x=1757601249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCrAy4VBSkToOvA1xqFBwYaPjkxY7aXwIQYFx4Hsorg=;
        b=vbdKDbm3vtadQjcJdvuwlEvjhMr0ZkneFHgvcnZ0BSp5oPu3uImd5hx9ilNHHvXZon
         pjSM73Za6zb/0MLBp3m11tVkzmhPVsj6bYgTNj6jarpBSNpgtEuDHPOM/8n7NoH6J/bN
         /m8cGOMlpbt2JZKqQk/HwM3GBynbL4NOQf71oUwjZvllsO1NKgF6XxHw852ZME6jzlfz
         Z5WGLaImEk9t8YucVRQkGpjXtUofu33UFg9txhoybGcPZ4n6xA0GDG5nBvVc+6ZfyED1
         v4GT9gnmH8y0EAu/jZpaHkAzFv7M7k4L9F1InnIeqT4rNFoSpwhtPtmBN7yTZZfD7bno
         UjNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqkesRRW+0gte8qDxHWnK4EBrDvIlPuY5yY+89aRo1CKpYw7LseTYX5LeBCg0iSPAvrcoNnFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOV04twqYAAD9g4xa0+91xrjG2U++mdcvjYcFByQgZjHLtqw9
	Qj4+Zc127mzbh+AoTuabpaVFHhhhpXPhLcyK+5zQ1R02imXVpl6eOUwFtN8xQgR1JXyjv3NXJVN
	XT/Lsh7DHHGo5kVonAnAxrl2Ac+TTTRx/3XbeSxdC0gt3hMEQpI0p+i3wtSM=
X-Gm-Gg: ASbGncszhD4o2PmRiBSkNWOPMd3oJLgyUTKZ3EG5Fx23wMPh10MgGNZ5ZQl9AKQMyeq
	vM43pe4hIXh75hC3Y83nbo3uURsdgSZzzhwhHiHDNZMxO0LmQAmdWd33EAloLcgkryyZLASiwmf
	y+ljXyDCyroi2slIDtb71Z4IMvhTZhkI8SAIGN7iU3DzRWC+HkHV3u3hjEcAyBibQowXl+yyupp
	E1l3OkRs0gxL+bo9qv712OQmooJ3xQhSLk6Pjm0qRUr5eE27F8HrR8HuTRimritNr3rlUP/74q8
	ztVtPhsagapPX8siAKLGy4b0aBs81633nM85fItEZZV2eHF67j4cEpgklqbskdThGZMTM2f3OrZ
	99muUOhNVhrM2F6lQJHOieQ==
X-Received: by 2002:ac8:7c55:0:b0:4b2:d981:9d4a with SMTP id d75a77b69052e-4b30e932ab7mr178894641cf.6.1756996448993;
        Thu, 04 Sep 2025 07:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrw5RFAVNLFohEcIYk+SdbuRFducNBzrRczOAhY4ohyswSH9BPbnDav5kTvXk4L0TpomNHGQ==
X-Received: by 2002:ac8:7c55:0:b0:4b2:d981:9d4a with SMTP id d75a77b69052e-4b30e932ab7mr178894231cf.6.1756996448330;
        Thu, 04 Sep 2025 07:34:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc579ba9sm14097959a12.52.2025.09.04.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:34:07 -0700 (PDT)
Message-ID: <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:34:05 +0200
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
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX4F+bEAYWGdxR
 oddnpsWYnx5Rfp9uaqxIjr1+ULqn2BE5sLfFQD7Gyg8muQoA7KrAfRH5s2t4oG9JVQNXv23aWiV
 F4Rw5RMXq8pBNSXuoBe5CKwQBxbbFovpZlZLaMCDaEztAEwM8Gzh0ZSrQBTBWfIuttLvIUuUc73
 QlRe4sbdK3OF1wUy+FKq6sbe7rmG1KY55Nn+oU1HH0R4Y4XROFalmoIc3PJXD+lwClIZQSmpTOp
 r2BH8Hq1N3pkl6tymET/jqg148uHXoI8cfiuHMTdegj9lkUM+D5NS+fxvoo30Zceqhk0QbPRQoT
 9nZT9K9JqbKLxLAU9KmFm0E01MQ9ijN4LFar3+er+yK8NvnzfDBLCeaPIiVZ71YvK4tEAeLaHRH
 IPb5lONJ
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b9a362 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=kWtGODYmnNjJKUQazbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NuZASPWRzXasDK4lQGXDQr5SUk3eokuq
X-Proofpoint-GUID: NuZASPWRzXasDK4lQGXDQr5SUk3eokuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>
>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
>>>>> This controller supports either eMMC or SD-card, but only one
>>>>> can be active at a time. SD-card is the preferred configuration
>>>>> on Lemans targets, so describe this controller.
>>>>>
>>>>> Define the SDC interface pins including clk, cmd, and data lines
>>>>> to enable proper communication with the SDHC controller.
>>>>>
>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 70 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
>>>>>  			};
>>>>>  		};
>>>>>  
>>>>> +		sdhc: mmc@87c4000 {
>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
>>>>> +
>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
>>>>> +
>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
>>>>> +			clock-names = "iface", "core";
>>>>> +
>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>>>>> +
>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
>>>>> +			dma-coherent;
>>>>> +
>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
>>>>> +
>>>>> +			no-sdio;
>>>>> +			no-mmc;
>>>>> +			bus-width = <4>;
>>>>
>>>> This is the board configuration, it should be defined in the EVK DTS.
>>>
>>> Unless the controller is actually incapable of doing non-SDCards
>>>
>>> But from the limited information I can find, this one should be able
>>> to do both
>>>
>>
>> It’s doable, but the bus width differs when this controller is used for
>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
>> only what’s needed for each specific usecase on the board.
> 
> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> properties inside the board DT. I don't see a reason to deviate.

Just to make sure we're clear

I want the author to keep bus-width in SoC dt and move the other
properties to the board dt

Konrad

