Return-Path: <netdev+bounces-218630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3EFB3DB12
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D193B10C7
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9126C39F;
	Mon,  1 Sep 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HYP9ll/7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30F257431
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711950; cv=none; b=BcvKPcqxWBWXCtl9DUJUwMdNVnOvswGz76hR1yHBzpyLkK9EzxD/5HTSsbCKPiYiibRbJGlb0tms0BM5Wk8vm24kIjSkkTwvfTDmtD6/DauiviRR3MA0Wl3wrJQs0kqT5fsLYZq17720bFW4R5yX2lfTZH0ssR5hCLA2/IIq2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711950; c=relaxed/simple;
	bh=F5R6Iq1fDvWzFsz5EtD5oNEHgiIIRaHeikdhwFrZG4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5stczRzUzkeLN/Ke5Qjbx/lG/R4hU0j5205WLHKu/EAqxGqZ7V0meJatQqQ/UCTFpwKzS+oQI+4wwcXo4/IZWzbNjYtj8KFSAmMGnDWqI8VvF+bKhwjRpg6V3PXMHVO1oWW9uexDb4obbCulj2mQ1t+oQzljLBFlswx4kfkzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HYP9ll/7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VMeK81023350
	for <netdev@vger.kernel.org>; Mon, 1 Sep 2025 07:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZ+Ooiams+niZP/GRLaTE4p1f4RS97Go1GVLkiPlXls=; b=HYP9ll/7X85Pi8ZO
	2tr10OLZntKWfnDX+Tsr+cOwg8NIxeMUY7WOIfohzWfBNfZENE9oc/fhCKShk65W
	W3VT2uueeTwR9MJGYkE3t0Obs+bv1Dkg7c6gVSh7zGrASYZPd7WixfkivUvfUf2U
	27QRecb9aSCTeYnNmyAHraQIKTvHn2EJG3wbIWwqNE2b+jeVCYWwkeWnwB0O0iZu
	iFfSV8Qs+14aSDpvsd9oRcjsfPSoIx39AFpyWB1FJP1gUT6hHIjWZhtJx+gELlQY
	D7DWNJSKETf8bltrtDRvLL/Wx9b4r1F8jgI9JB4aDeyynGArZsvXZyudmwt8NVJe
	5yGF8w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjbrdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 07:32:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457ef983fso85240885ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 00:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756711946; x=1757316746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ+Ooiams+niZP/GRLaTE4p1f4RS97Go1GVLkiPlXls=;
        b=Gm7gYZ7TFSv32bweRf21olMplGg0HS1Pt69B/oSC7uBWXfo7VoU0Fr1ED1n4jB62es
         OtTg0B4WKnMasQ44FvkgcSHWqLDKQcx4DSvlO+oPBF/uy/4jGXhpXUYL9an0Jkxhyykm
         Cx9iFzjQc+ZMBFAh8aWWD75HiOy07XBJicxgPVzUZHYL+PVdopZrOK7Xx/VtMf9chATT
         W1HEHmpusA1R2xslE8wntOHQZHZjexd5WtkebdzpIJ6RnPiJ9mv9cKsRT7CcDBMUyQdF
         kKE2Tt+V73FSH9jiqg/JGXUdmqEp4wnzXZXbKIOwQEjbXwUUj6iiCvCDQYw5wDspPv6X
         uCWg==
X-Forwarded-Encrypted: i=1; AJvYcCU2FLjHclSvDiw57C5lvm7ENtJ0VqDMGR+pIr4CjFk43Bo+heOYPzrb1jtmXGwldH4jDrM92sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5JKmwWdM1DoG6IOF0BLemAPq5S92il99rD4Vjv9NCNgy/otuZ
	I9aZ62EahlmAudCLiibVa5IJuYkhANOOcnS5yr8wwBkiw1ewaB5atn+H15xonEBcvKQqDK7D4PP
	Vp+gX+CEz/fPHSzk76WPCmn408EgloqDWT182SVyNx4jLG+NTqmLhEL/QRLA=
X-Gm-Gg: ASbGncsxFTTWcOdrr6JFosOh2Hi6A4dXUSKzfolxODIzTh0YnMSSnGK1bvvCXemqIoO
	eDlLLOJPplamH7ETiEWE0/jNagHfOPxflPiiQe4j6jllzsf2k6aiHvksiwJEPwTTXw3a+5ZhHqd
	bJzieOKaPBXQxaR17snthExiv4pJhcaAQFYk1GbApyan1RqmPNf2acxUMcfG4nwUJWXHZBBqdJr
	6d1+OhBU6pqE3UoUlFzA1Fvdd5WQA7sCWSJgVl1OuGwfkX6ZYjfrAWNQ9WAKhS3cpIxJaAW4Lgk
	DvzsmzCDT1SKjO+G8g5wvXoK/HRPPg0T09yRdU0OMKNm0NQbFoY6/hl9QsLA2EmS9tUN1U+GRqZ
	B
X-Received: by 2002:a17:902:f68e:b0:24a:9de1:84 with SMTP id d9443c01a7336-24a9de1030fmr64567675ad.58.1756711945891;
        Mon, 01 Sep 2025 00:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlKBC80+If+5G39D8/JZqU6YH3SFXfdt5RXWBFBrHWH36lZhe2OSCNImdLgr/xGn5A7J2C7w==
X-Received: by 2002:a17:902:f68e:b0:24a:9de1:84 with SMTP id d9443c01a7336-24a9de1030fmr64567385ad.58.1756711945330;
        Mon, 01 Sep 2025 00:32:25 -0700 (PDT)
Received: from [192.168.1.5] ([122.169.224.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e042asm96144465ad.146.2025.09.01.00.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 00:32:24 -0700 (PDT)
Message-ID: <ed3a79e0-516e-42f4-b3c6-a78ca6c01d86@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 13:02:15 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>
Cc: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
 <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
 <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b54c0b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=cjl4bvUVK5mvyAfiS3wwZQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=IOVst45bHqDw5aB5Pk8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YH7XPiS9DHJtl6jYwb7Cd7d4VhCoa0dE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXwzQm5SDvfX/e
 BEIWV1Q47cXhXhYuaQHaiVc5kTZ/R+xzxGStpbyXzvjngrWGQP1DZLEX4hDfUEh6aj0YZykYw0+
 x6c+h5ww7JnbkoA0bMQjjvDvvDRLdSB32JwJLsUgT4mfRyCvb00kedE0gEA6inBuTHdDTHsgmE9
 uIYv3BSM0RZF2xzwUdcDadzi4d2hQfDDRj6iOsqiV/bChqxntqbbSePrILbKasfxomTu33kzP8Z
 PYMNHRzie73n+i171N0XVGD1h4b4EZL5vGFoLFI+b3WebB2wNUWQ00K+kq/6XrIFq8jMpp36/XP
 5zHXeo+hw9kYjdM3ah2vK6HPeFxW/MInPU5yGqjt9tM1vD0cOUAUdm7YjWXPVdS0QgH6df7iwzZ
 gF9fEI4F
X-Proofpoint-ORIG-GUID: YH7XPiS9DHJtl6jYwb7Cd7d4VhCoa0dE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 8/29/2025 9:54 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
>> On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
>>> On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
>>>>
>>>> On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
>>>>> On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
>>>>>> Enhance the Qualcomm Lemans EVK board file to support essential
>>>>>> peripherals and improve overall hardware capabilities, as
>>>>>> outlined below:
>>>>>>     - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
>>>>>>       controllers to facilitate DMA and peripheral communication.
>>>>>>     - Add support for PCIe-0/1, including required regulators and PHYs,
>>>>>>       to enable high-speed external device connectivity.
>>>>>>     - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
>>>>>>       GPIO lines for extended I/O functionality.
>>>>>>     - Enable the USB0 controller in device mode to support USB peripheral
>>>>>>       operations.
>>>>>>     - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
>>>>>>       Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
>>>>>>       firmware.
>>>>>>     - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
>>>>>>       and other consumers.
>>>>>>     - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
>>>>>>       Ethernet MAC address via nvmem for network configuration.
>>>>>>       It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
>>>>>>     - Add support for the Iris video decoder, including the required
>>>>>>       firmware, to enable video decoding capabilities.
>>>>>>     - Enable SD-card slot on SDHC.
>>>>>>
>>>>>> Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>>>> Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
>>>>>> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
>>>>>> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>>>>>> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>>>>>> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>> Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
>>>>>> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
>>>>>> Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>>>> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>> Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
>>>>>> Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>> ---
>>>>>>    arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 387 insertions(+)
>>>>>>
>>>>>
>>>>>> @@ -356,6 +720,29 @@ &ufs_mem_phy {
>>>>>>    	status = "okay";
>>>>>>    };
>>>>>> +&usb_0 {
>>>>>> +	status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&usb_0_dwc3 {
>>>>>> +	dr_mode = "peripheral";
>>>>> Is it actually peripheral-only?
>>>>
>>>> Hi Dmitry,
>>>>
>>>> HW supports OTG mode also, but for enabling OTG we need below mentioned
>>>> driver changes in dwc3-qcom.c :
>>>
>>> Is it the USB-C port? If so, then you should likely be using some form
>>> of the Type-C port manager (in software or in hardware). These platforms
>>> usually use pmic-glink in order to handle USB-C.
>>>
>>> Or is it micro-USB-OTG port?
>>>
>>
>> Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
>> controller for the same. Will be enabling relevant dts node as part of OTG
>> enablement once driver changes are in place.
> 
> Which controller are you using? In the existing designs USB-C works
> without extra patches for the DWC3 controller.
> 

Hi Dmitry,

  On EVK Platform, the VBUS is controlled by a GPIO from expander. 
Unlike in other platforms like SA8295 ADP, QCS8300 Ride, instead of 
keeping vbus always on for dr_mode as host mode, we wanted to implement 
vbus control in dwc3-qcom.c based on top of [1]. In this patch, there is 
set_role callback present to turn off/on the vbus. So after this patch 
is merged, we wanted to implement vbus control and then flatten DT node 
and then add vbus supply to glue node. Hence made peripheral only 
dr_mode now.

[1]: 
https://lore.kernel.org/all/20250812055542.1588528-3-krishna.kurapati@oss.qualcomm.com/

Regards,
Krishna,

>>
>>>>
>>>> a) dwc3 core callback registration by dwc3 glue driver; this change is under
>>>>      review in upstream.
>>>> b) vbus supply enablement for host mode; this change is yet to be submitted
>>>>      to upstream.
>>>>
>>>> Post the above mentioned driver changes, we are planning to enable OTG on
>>>> usb0.
> 


