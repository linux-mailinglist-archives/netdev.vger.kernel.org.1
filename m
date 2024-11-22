Return-Path: <netdev+bounces-146802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC4E9D5ECC
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0F5B243CB
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CF1DED78;
	Fri, 22 Nov 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LikYZeHl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BF1DE4D7
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278428; cv=none; b=dmlm/BGUZrVfSG5sp6vYKA8k1DIgqi8sophgsoDG6OM4Hyr0XXX/KPJmLrmaN/ZurdTjfcP3o7NCQPwgSWQezKrHlM+LLKqSWuIJn3TZt/zGADIWXy0FjMWV3Gv17Z81n2C2r6vVHP++4h+DbzeyNSo8VAaTVHGy5vM2S6lMRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278428; c=relaxed/simple;
	bh=4aiIpJh+eaWD1gIxrNVIvVmyVJxSvmNVIjIhN4N/AG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gL9K2/VC+/R304wHN/ZyGQkLkRTWOlmqUjm02SiZ7oI0bv7KUHiuDmtkDclgJq57jHG5I+zczzSwyB2YU2phtOrnvzIIZIzD7sDlTyKhAreaxJQDNtBzZgw6K+Go50PkJ9CU3jG1/lZOAktrG2EKY9ViwqnuZWdIz1QdkASF3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LikYZeHl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMBqiGH023455
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+wZgnTIzj6zzY7f1RVOrNUBpDHPvehTTFEmYM7pOCzU=; b=LikYZeHlygIePHea
	W2zu2mlbFotHL93VjTEWOlsvaRtkmZ2vo/v4hUhRglgAwN2t/arperusDMZbt1Zn
	81t0bIRs7+td6oa6IZOKeZkaLLnxM7J8KF7XzAHYSWMVovwS0rNN7wcY86nBeXqC
	G1wUCrGosXQTQqz+FbA/KPnTVl9iObtRNZIlJO8f4DTAnqvuQWnWZbTcgCcZAekg
	RKGBb/o//uk9xgMznAu0Z/CAKDalDlNASEPd2yengspNl24eZ9vY/HRdMHdvpPqU
	JnfPbY1K1ummTCW3agzvWxSDJItJyHislLObTOQ5HxzW9epKvBXfpagWkcggSt7j
	dFNLWw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2n53u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:27:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d41719160cso4689476d6.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 04:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732278424; x=1732883224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wZgnTIzj6zzY7f1RVOrNUBpDHPvehTTFEmYM7pOCzU=;
        b=HjN1bcdpjnrSAFlXxxPXpPY0P2HxhTr9e7odf7jhMucsRrlRA14D/oaub+oLmZeq8E
         P+HW0lxMQLABOz/fRyaEzZtrTrxuNe5I4LZBCLrAapxfJdgC9UwuIbXiRRph2854qRvq
         CitZ1nZrn2Z1wumE9PmPtdujs1q5y1T7usUDqCrvSs68QdgeDb8pF2e5H2jLLayEi9Tu
         MYNdDv8+1A5h26R/EgeZsMhMID4T8XOLe6PNFeB9fEG+3GJrP/0Bxl2HmwYM+LFX+3c1
         oT1boAKUcN1vKfs9CsHD8WsNL1x6u2voA9evgwjCzpHzTci+DEiIT8f/3CFVi+ZO6UsN
         fzkA==
X-Forwarded-Encrypted: i=1; AJvYcCU9OcXoUd2j9+TSKC4xV0QLQygxT87EO+Ap/99M8f4g0Ch0cb9JHXeX6ZWA5PfSh71dZNIRZsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxy5SXhgctMwepvmS2wxe/iUqzP6kERAETAkdldeTS2sUH+fmS
	ms0qXgplC7jMYzDweGpPyM17S8UBSIKGRuubh8fdUpzMnVAe28bQ+sIg+ubJu1/h7ILx/HYrTnT
	6+xjnEgo8gxldK97SjpRICP3pNWOXBcXO9tNgTeetjMqEIDtmZ5s7aXI=
X-Gm-Gg: ASbGncuqK5874WfNCK8buqeg5mb/QlB7Fki4rT5IAd5UhVRgIOqQoqyg4Ljm8NMAszU
	l0cN2hjbLjbYyBfblWmFZ2CtwWfOiZVX7ZSvs1nCWQL+/ipnN1YuS8ddm52uAGXAJOzVz8018Q3
	K6UlESAtAtCQ5+jx1NbRCjbkdXSsUeOfTv88CxcHDFWUIKQkoG4Op4DYLPyfzRwZvqtITjRsGZT
	xLI4ty1fdPZMcg7pzXV0jJeNl2g3AoX2Gf6dMwiM6+j7JwTNqhhJBKKu0bs0NFWZUkbC3JMgvJ6
	RUa6kXu4ySv+ZMldrGnUWS35+jeZ4A0=
X-Received: by 2002:a05:620a:19a3:b0:7b3:2107:302d with SMTP id af79cd13be357-7b51461660cmr166624085a.16.1732278423870;
        Fri, 22 Nov 2024 04:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAti18gerkPsJy9ehvlQkHYHYc+es+uoyJF0X67DaPecp+BaAqZTDlar6rEtD5dCOPx62iFg==
X-Received: by 2002:a05:620a:19a3:b0:7b3:2107:302d with SMTP id af79cd13be357-7b51461660cmr166622685a.16.1732278423450;
        Fri, 22 Nov 2024 04:27:03 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28dd83sm95189866b.25.2024.11.22.04.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:27:03 -0800 (PST)
Message-ID: <c2800557-225d-4fbd-83ee-d4b72eb587ce@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:27:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs615-ride: Enable ethernet
 node
To: Yijie Yang <quic_yijiyang@quicinc.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241118-dts_qcs615-v2-0-e62b924a3cbd@quicinc.com>
 <20241118-dts_qcs615-v2-2-e62b924a3cbd@quicinc.com>
 <ececbbe1-07b3-4050-b3a4-3de9451ac7d7@lunn.ch>
 <89a4f120-6cfd-416d-ab55-f0bdf069d9ce@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <89a4f120-6cfd-416d-ab55-f0bdf069d9ce@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zeKydyM31jMQL1B8Z3_eznwx5vD_2XM3
X-Proofpoint-ORIG-GUID: zeKydyM31jMQL1B8Z3_eznwx5vD_2XM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=803 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220106

On 19.11.2024 11:09 AM, Yijie Yang wrote:
> 
> 
> On 2024-11-19 09:27, Andrew Lunn wrote:
>> On Mon, Nov 18, 2024 at 02:44:02PM +0800, Yijie Yang wrote:
>>> Enable the ethernet node, add the phy node and pinctrl for ethernet.
>>>
>>> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 106 +++++++++++++++++++++++++++++++
>>>   1 file changed, 106 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> index ee6cab3924a6d71f29934a8debba3a832882abdd..299be3aa17a0633d808f4b5d32aed946f07d5dfd 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>> @@ -5,6 +5,7 @@
>>>   /dts-v1/;
>>>     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>>   #include "qcs615.dtsi"
>>>   / {
>>>       model = "Qualcomm Technologies, Inc. QCS615 Ride";
>>> @@ -196,6 +197,60 @@ vreg_l17a: ldo17 {
>>>       };
>>>   };
>>>   +&ethernet {
>>> +    status = "okay";
>>> +
>>> +    pinctrl-0 = <&ethernet_defaults>;
>>> +    pinctrl-names = "default";
>>> +
>>> +    phy-handle = <&rgmii_phy>;
>>> +    phy-mode = "rgmii";
>>
>> That is unusual. Does the board have extra long clock lines?
> 
> Do you mean to imply that using RGMII mode is unusual? While the EMAC controller supports various modes, due to hardware design limitations, only RGMII mode can be effectively implemented.

Is that a board-specific issue, or something that concerns the SoC itself?

> 
>>
>>> +    max-speed = <1000>;
>>
>> Why do you have this property? It is normally used to slow the MAC
>> down because of issues at higher speeds.
> 
> According to the databoot, the EMAC in RGMII mode can support speeds of up to 1Gbps.

I believe the question Andrew is asking is "how is that effectively
different from the default setting (omitting the property)?"

Konrad

