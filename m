Return-Path: <netdev+bounces-219499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A39CB419A7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F983BE1CE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CC2E7BBC;
	Wed,  3 Sep 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jf0xQhBq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42B2EDD40
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890759; cv=none; b=YAxwvkjeVCoLqbSdEf89dXuCOsMqFsp2jlwejRZeoVjcfoFYjMlp38sg3YN+Jm3+XpR0DKOvmcmjyObu4YEYV1DP5bf9Igo8rnjg//reRcYoolH2b3ViyvdZDcbJkZ3x8GeudtSUmJJJGG4tOoU+Vnu1bVdaiqqDU1SXk/uvij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890759; c=relaxed/simple;
	bh=cxe3hMIZT+QIzC3aj+rChBvHjYo+TmkIeIvbyWzTbkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m08znRwmisAbYCLkknlL3nqK0gMWh6yjXSuM4k9EWnWiVCLtYme83KcELWJGvoqInB8RejSkYJMSv75DBqTEpjuq54xgZjE+V1OTZH1ANjOrSs6uTHJFgSuuU2Nd45vsDfvMij7Wr/qqO6FavbFo0EQCrbkGvkmzUcdyltBJ208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jf0xQhBq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58324Pqf027197
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 09:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OVGKJk2Lv/6cSlW8nPZxFi9+cu1Hs+eu77TPY89OEGI=; b=jf0xQhBqJU+sapDh
	N6+sOWZCLRO8J3HeukJaEd2cSVumV+Eneich3byzeYvhiObYn8nPanpNe5myqkNJ
	1tMDZkVuJaBnmIXx2o6Hj7o9+/7q6sCAtiqfYjA7aAGgFGhVQWnzh2yS4MN/Unh4
	rG2rKdwbOkk/la6Wf3Vm6l5XaMoTwM2pZpR/x7ZF+iAxxeJH0lohjUOsVBAJmmnq
	nePQ88QiPYui2PR2w/7dpUh5omGNq7eD790xPQiPr0vvQKQ9bJlnPrTN3/3q8B7j
	AO99OiN2rVy7bM5ctgPfiazHgqkWBqt64bJ5XNMqoBqHkPYYyCHY9HjZ4+qsJACI
	b8yqNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv32hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 09:12:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b4aa90c20so17009045ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 02:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756890755; x=1757495555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVGKJk2Lv/6cSlW8nPZxFi9+cu1Hs+eu77TPY89OEGI=;
        b=WxkQZ0p6oplZN1kGrROwUpHK+5ACuOu6jMv18WEXEL7AlWk+2azYZH/L5WurQkrtjZ
         AVZxt//NABrRS+tfVGeg3KT5EGM6l3VOUcbaq+Y3/+ZcSAVYWIVNHB4bx9b+XxtOFQFo
         iuU6LP+y96w8U/08FxwoDZTbszvxmD9aIUUh/zyzom85QkkKo4s41IfpKsl83BJojGJK
         NMlmrgqas7a120zoy8JyBHacCk16tv97dqMLr1h+5wLyxrihj48WMuNmPgtHBSlMgRMX
         cHUjb7oRkRZJByaz1GHTmYHlGgGU54I6K0RWaj0vlo1x7O6i0ihFF+vTnbK0ngrQ6j2q
         Yy7g==
X-Forwarded-Encrypted: i=1; AJvYcCWZDjT/uTeOqbuxHK2Dn5G2pKKNdz3htjWOjBbvR9TQDNeWRqtyfnlq+GzfJyRQ72tv1hbgYSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNBbKIKMgLIEtsEx3GpSeIlQ+Z4coyCBUynNWBXuIa0xgcdP/
	OWzFINogfrJKGQm2kKnf+bAQcNTDtpQf9zNwUJVXhz3/8vZVbx0+Qo+ciGcotsKyk2H8KLrlJCz
	CvrfucTzVnlt5eEaU+qKUmdXQsNn5hErImK0HsZM1Xxs0JyPwszb3o16AgIw=
X-Gm-Gg: ASbGncszHU2eRot+qDYhkwCkxI3TxIte+nJ1yEQHTAGb8lxhNujWLyIlEB2scnpORnP
	SJsFjmqbb5QcrfsH7ZJM4hIdd+mTL7mOpjf3kPioW7uM+n0cgcL1uK7y1aE5LrH7VgI0v6XaxMU
	N+DIlLKm9MdB8U98Tj25E206VnrSUP9imb4o3TzqbQEKIzuSVT+/yZlxZdVpBA4gGdjdZK1eAcp
	Q/5Ra89JbZOduGBn4UTEDryFKa7zXIM2DQD7AUotszMk1qIF8qfNoK/umk7CCjojI5Sfeuvtz40
	ZbiuQlVQ0D9qVMhN8f4bkzGSC0sfRJE0idhYRZezQfBLwFRfcYrq0VKtEseQGwgUm/RrsG3z1w=
	=
X-Received: by 2002:a17:903:2444:b0:24b:1163:552d with SMTP id d9443c01a7336-24b11635af4mr81492535ad.11.1756890754845;
        Wed, 03 Sep 2025 02:12:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlxwNjUEHkil6HdnR5uUPgdOQXVoh/CYspkYZQI/7DHUgrQ4WqIWHgmci0fhFLFnnqV0FVUg==
X-Received: by 2002:a17:903:2444:b0:24b:1163:552d with SMTP id d9443c01a7336-24b11635af4mr81492055ad.11.1756890754229;
        Wed, 03 Sep 2025 02:12:34 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e71a8sm16644559a91.15.2025.09.03.02.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:12:33 -0700 (PDT)
Message-ID: <d6816cc6-c69e-4746-932e-8b030ca17245@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:42:25 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Monish Chunara <quic_mchunara@quicinc.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
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
 <ed3a79e0-516e-42f4-b3c6-a78ca6c01d86@oss.qualcomm.com>
 <ly5j2eodrajifosz34nokia4zckfftakz5253d2h6kd2cxjoq3@yrquqgpnvhp6>
 <ctwvrrkomc3n6gginw2dp5vip7xh5jhwbi5joyr64gocsm2esb@4zfpbvvziv5i>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <ctwvrrkomc3n6gginw2dp5vip7xh5jhwbi5joyr64gocsm2esb@4zfpbvvziv5i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX0AjGdvpGnQHy
 Bq9mr0h7Yo22o1GWMCObp0HHma/O/8Xi2XW0vIP7FhVRsC08ym4iCUola90fYALzaHIUkGJswMD
 PXoRCLJ0w3kkbjD35IlCQ0pbYDJaeydpbwgwfMsIXuzTLn26wBHbxwGY2v3K//Hs7yguPmzMIDT
 I9MvrbhF/sXWHRRZ64zIY4xqNFYX30dD8N2M5DW69fQD62cc0Zp3jGwrpwS+I9m70aMRa6n+8qz
 ONxsEHG0P7nVsAKc1I8XJnthiTibHh+dWybV5it8BkwzLjxn2/6DBpy1VtMJ+quEWwrh7ahRcvR
 a+10vLrzesol+O0knbVeq68lW0QZICpke06CZt2OXotKvDU4MGFmdHn+oLtfr5iiPA7YQUK99hX
 JmNfMs+H
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b80684 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=V5NJ_6AyxSgfeeEKDpIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IWIfOs5bSvoytofpqsv_zSnRi8dGC3pd
X-Proofpoint-GUID: IWIfOs5bSvoytofpqsv_zSnRi8dGC3pd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031



On 9/2/2025 10:46 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 02, 2025 at 05:34:27AM +0300, Dmitry Baryshkov wrote:
>> On Mon, Sep 01, 2025 at 01:02:15PM +0530, Krishna Kurapati PSSNV wrote:
>>>
>>>
>>> On 8/29/2025 9:54 PM, Dmitry Baryshkov wrote:
>>>> On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
>>>>> On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
>>>>>> On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
>>>>>>>
>>>>>>> On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
>>>>>>>>> Enhance the Qualcomm Lemans EVK board file to support essential
>>>>>>>>> peripherals and improve overall hardware capabilities, as
>>>>>>>>> outlined below:
>>>>>>>>>      - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
>>>>>>>>>        controllers to facilitate DMA and peripheral communication.
>>>>>>>>>      - Add support for PCIe-0/1, including required regulators and PHYs,
>>>>>>>>>        to enable high-speed external device connectivity.
>>>>>>>>>      - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
>>>>>>>>>        GPIO lines for extended I/O functionality.
>>>>>>>>>      - Enable the USB0 controller in device mode to support USB peripheral
>>>>>>>>>        operations.
>>>>>>>>>      - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
>>>>>>>>>        Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
>>>>>>>>>        firmware.
>>>>>>>>>      - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
>>>>>>>>>        and other consumers.
>>>>>>>>>      - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
>>>>>>>>>        Ethernet MAC address via nvmem for network configuration.
>>>>>>>>>        It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
>>>>>>>>>      - Add support for the Iris video decoder, including the required
>>>>>>>>>        firmware, to enable video decoding capabilities.
>>>>>>>>>      - Enable SD-card slot on SDHC.
>>>>>>>>>
>>>>>>>>> Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>>>>>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>>>>>>> Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
>>>>>>>>> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
>>>>>>>>> Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>>>>>>>>> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
>>>>>>>>> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>>>>>>> Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
>>>>>>>>> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
>>>>>>>>> Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>>>>>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>>>>>>>> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
>>>>>>>>> Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
>>>>>>>>> Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
>>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>     arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
>>>>>>>>>     1 file changed, 387 insertions(+)
>>>>>>>>>
>>>>>>>>
>>>>>>>>> @@ -356,6 +720,29 @@ &ufs_mem_phy {
>>>>>>>>>     	status = "okay";
>>>>>>>>>     };
>>>>>>>>> +&usb_0 {
>>>>>>>>> +	status = "okay";
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +&usb_0_dwc3 {
>>>>>>>>> +	dr_mode = "peripheral";
>>>>>>>> Is it actually peripheral-only?
>>>>>>>
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> HW supports OTG mode also, but for enabling OTG we need below mentioned
>>>>>>> driver changes in dwc3-qcom.c :
>>>>>>
>>>>>> Is it the USB-C port? If so, then you should likely be using some form
>>>>>> of the Type-C port manager (in software or in hardware). These platforms
>>>>>> usually use pmic-glink in order to handle USB-C.
>>>>>>
>>>>>> Or is it micro-USB-OTG port?
>>>>>>
>>>>>
>>>>> Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
>>>>> controller for the same. Will be enabling relevant dts node as part of OTG
>>>>> enablement once driver changes are in place.
>>>>
>>>> Which controller are you using? In the existing designs USB-C works
>>>> without extra patches for the DWC3 controller.
>>>>
>>>
>>> Hi Dmitry,
>>>
>>>   On EVK Platform, the VBUS is controlled by a GPIO from expander. Unlike in
>>> other platforms like SA8295 ADP, QCS8300 Ride, instead of keeping vbus
>>> always on for dr_mode as host mode, we wanted to implement vbus control in
>>> dwc3-qcom.c based on top of [1]. In this patch, there is set_role callback
>>> present to turn off/on the vbus. So after this patch is merged, we wanted to
>>> implement vbus control and then flatten DT node and then add vbus supply to
>>> glue node. Hence made peripheral only dr_mode now.
>>
>> In such a case VBUS should be controlled by the USB-C controller rather
>> than DWC3. The reason is pretty simple: the power direction and data
>> direction are not 1:1 related anymore. The Type-C port manager decides
>> whether to supply power over USB-C / Vbus or not and (if supported)
>> which voltage to use. See TCPM's tcpc_dev::set_vbus().
> 
> Okay, your Type-C manager is HD3SS3220. It drives ID pin low if the VBUS
> supply should be enabled. Please enhance the driver with this
> functionality. You cann't use the USB role status since it doesn't
> perform VSafe0V checks.
> 

Hi Dmitry,

  Thanks for the suggestion. Sure, will take up the task of implementing 
vbus supply based on id-pin in hd3 driver.

  Also, will move to otg once that is implemented in port controller 
driver. Will keep it in device mode for now in this series (or its 
further revision). Also will make sure to document it in commit text in 
next revision.

Regards,
krishna,

