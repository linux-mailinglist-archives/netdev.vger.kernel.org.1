Return-Path: <netdev+bounces-220338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD28B45753
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEC8580175
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77034AAFF;
	Fri,  5 Sep 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0r9UQ4C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67234A32C
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074233; cv=none; b=EVEE5qWGKBgDrg+K1gVCqs8rjvuBNBTtAKDPzSKCXR22C8pP3dqeJ0zGlgmaRgsghehkY+nnGQ+xlv3iwLDLxnN4ThnMYuvm8Bt5b+4DF0PUh6Suphb9SYzSCnIJ+KZ6ze/hkAOV7gJFkwPOeTR+IuFeI2N0HCeQNrEn9MD3qvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074233; c=relaxed/simple;
	bh=ErCJ6Ql1rDMt2vKVLJW9jn9Ni3tpQtFY2dmm34Q5uBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7+JNWFlCGbODU+tEYpJv4CrIWQWlSOyW8ZIbDrJGD/0CpcA3wGKOETnUsWnUMyGSki7CLgo+MH0orgm877BBfdPUkoIyYXtecfd/I4pL1pgFoUqegDLZjulkUt0abI4DE75g34XeqhUsB7bBsjC5VY/DcmHBWxMVE1gjwGRD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0r9UQ4C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857Bc2Q022162
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3CXvHZCGtK3JzFKnruevi9kzIT/zr8k7RvjkNKrle0=; b=m0r9UQ4CLWMjutZQ
	qETbEc2XdgjwRETjCNkkIMt0KynIg4Qxw3/QNyNYNWIoF5s6EQK+MmTf8jkzQ1KK
	SlRMk0Y2Cn+TAsMW10hykObKOX/tZ/7PRIJ7tLOoNGnN2dZOPm7XzgnJKyGOVZmn
	FC85p/oGlW/yqEQvbmqO7FTO01Wu5ktI+iuC31bDI8/ydyfM6taqlZaAw9dwc+P/
	oxO2b/8jg+eaF4roRMEgRimjFezbnlVumB4ywh+Sckr2BOFj5tMpQKwOK1v1VuKy
	T5Rysd6oAMP0z2HdnqLBFPgfl+tgqE8TIyZmPkO5h7HZHYWi8LupJLaQ6Q+ORNds
	oCOtlA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9ax25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:10:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso8111631cf.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074230; x=1757679030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3CXvHZCGtK3JzFKnruevi9kzIT/zr8k7RvjkNKrle0=;
        b=tULPAP/c1CWTKXbwhu6+UbKSKNPQGr8pRtodwhtbmL1ZHPR2uHi+6Gc3+h4d+Mhqg2
         PC4RFrA0j/KzqlTkFY7koPb3eiTJb0xr11DQjjRp62J6lZJsYMdABxVis7J8U+X8AOo3
         LxdeMJbiYjnhiR5Sfv+DGz0xEgcQ77dbZTJTZfyZK1/JXlRO064rtHN5Hq3a+Rga14Mx
         qqsBtzztf2h7n4htQVHZKXVRRoPq9gMvOWoE5ol1A2qQYf32kPdsyzi9cSuERh84l4K9
         3bqohYvZT37IeRZl5QhCALqjehSFO7xU7DxI4tI37vW/bJy38LYZli6hH6eTMsKUUHgo
         TGaw==
X-Forwarded-Encrypted: i=1; AJvYcCWRmQDIL/pWX9JtMxbfqRv0q5skc8ZOcO+U9BKa7qDBfDQRvSaAUJmeUOO2AvdU+LNk7ceXz38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGLY2xynJ5fnrsVx9Pik3UKQc84UA0HkXcqNJdPZoNhwxXUEW
	UnEmYe6gcNUNtur74EPs6le/hgC2/cVjoeyXMMNlz2z3K9ukZV/yoiIq1YlNeBrmjzkXaqtDGD8
	mTcZK4LTEbY6Y/d7iX71O6a+FpYTbrM6KngZuG1rLB2/+zVW15ee4SY+wyW54IdA98OQ=
X-Gm-Gg: ASbGncupsYD9gDjkYE4ejvTrQXYRA2CaJAJoe7y1CrTZsyJI135injW402T98q7yU9/
	M8WMA/6sw+nILHTWGLpjtpcBNYmPopDPrdyzDg39n+UacGV94xdkrZpWnmTReiWyjIrsOZiIkeo
	nGl6uNOQCWzy/4MOruO82NMccV6KfQETCZ/tide3lMLSzmA35cMPxG8DcNREqET5nkIeTYizBwd
	27sNlCzHAquvBlPsTLuZg7f6nhtWtFWZDUZKaxbhRM9xaNRxnz4MtKC1AzvXuSm/gUVaj4jpFNU
	RbclVhzm7nou5vy2RwZ9911FIq6fCbS8NXtdjAA3BV6kIZTP21Faz5tbx+I2dyFicebxTl0Z+Sy
	K4FVinKM80X8go7vNLS5sSQ==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr79002101cf.9.1757074230306;
        Fri, 05 Sep 2025 05:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/V1Ut9FoAm3PMIuMlaHnEJiGeKOqT+3I7Y49huAY9u92oCVKu3lzCxSzcPEtH0e3dxFF09g==
X-Received: by 2002:a05:622a:11c3:b0:4b4:946a:df22 with SMTP id d75a77b69052e-4b4946ae541mr79001621cf.9.1757074229739;
        Fri, 05 Sep 2025 05:10:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7caesm16131666a12.9.2025.09.05.05.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:10:29 -0700 (PDT)
Message-ID: <a61d5e22-6a0b-49df-a203-aa408856cf43@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:10:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ruS2jsw62h0ufqUWdjx9Iq5lvOf6XPfu
X-Proofpoint-ORIG-GUID: ruS2jsw62h0ufqUWdjx9Iq5lvOf6XPfu
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68bad337 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=eKh8lGy-H4yf2MGC_tcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX+S6KGG/UQUO2
 AvdxLcWLeUspZrUIWOIgLbqgyyv5oDrQ+mdZJCijveE2zuqaMm6VM8b/VciJuEkrRhivg0I2haW
 j9DdHiykANbuCgW0FR/zpLVdS3RzlBSedMpjEi1RECZckq+TTPiGba/7eNCAR/C7pJrtbJd0K8n
 A5c8ruo4qV5WU9a5T418pv9obAK9WhuOmlkZ+B1lR3v57/bG1+XGxgYXR1jLXcGffnPRChZHBcs
 l/BNCoWlGpyNIgc0roJG6P40CwnR3x4/PeIr/06gWBYmf+ge9nEJi5ktV3lNMV2a0fyJBdNbuoh
 LhY5Ljcuu9oJd4ZOp8PF6tCsydZNv6Zh72xyEV4KhL3yQoq6ENbbYaS/Gu8jdI2WEzHMlztgWEO
 RQv5841x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> 
> Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
> functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
> Additionally, support fetching the MAC address from EEPROM via an nvmem
> cell.
> 
> Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

