Return-Path: <netdev+bounces-220343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1DB457D7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2513A1C68
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8834F486;
	Fri,  5 Sep 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThIs20tG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166C34F466
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075188; cv=none; b=A7lxaAJuEazB/dafT3TbyP9gZHvSPUWmMBn4pOktzdQe28Wn80UsL8pZhHsnUPsvPx4/u8Gwexaf9UF4zYO9IBMbvaZG75T5JO/ilZGRtNOLQ6uLeBFDRFCL7Vfejl604aXJQknJh5kPtU93XvNJJR9W578H2yzbvw7EIFURMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075188; c=relaxed/simple;
	bh=JkUf2vIGxOiyFPoVNdwA17YFnAIws6TxkLfW0TPXFlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkPzJTGNY69XrX/aw75oyWrqZSYxOO+7W50G7NkiHtHMozmCkYGG7wAyCXNACxJCG156YCChnaTwJVcZc/U5TWFcXLv3ARAkYrw1LD71rj1pKvMO3Zegqo87Imrx4fZt9coifUSm3CE8Ty6xq/bDCMNeB2fxfFaTw03xQKANWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThIs20tG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856oTFx008141
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kyI0487W0JqbBUoFU2qAu9jSBfGKKX4t5Zjxjpcd4FU=; b=ThIs20tGdSL4xOLh
	zGd7ULBE2BUErfKiBlNO5oeUXwhrBE5DtRFI2Jkq4mM86mMQcoAuB/N9FtJc4kjD
	5mfvZW3bdqw0RouzAjSFZkcxe2BNrVv16FrN9wXzRhj+DnWzGAH3xS/jPi5LUJ92
	oOg++dYIYcYZ1M7VsEv2krWlmLwpFZ4/a7kSpqFc+XIG3GUr10Y+y7AbD87x5MAD
	O7Ei1ghpuyNUCV3HRSOU+epkRljIFcBTI9qcB+tmk4io0y9wVxKl1GjPMmLAaYj2
	ONYPAV4BUGdA1EOMZfdQPN6jCvjHZNuWi0Q5nh9rHV1ZyIehNux6vnrz+NAn748c
	TtxMhQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmju243-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:26:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b307e1bef2so5856751cf.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075185; x=1757679985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyI0487W0JqbBUoFU2qAu9jSBfGKKX4t5Zjxjpcd4FU=;
        b=ae3gZy9u0IIDsRuTh7HsePcOGJpp8j4h+LhzX9d8Y4qZYNTzZ6Gag9LmGcDWZOjG2n
         3G/RyE4pZ5scr6v1WcrBhMyc9pojzMM9SiQxtu7zWoaxndvhE8JPcDArTA/zi8iWIZ1N
         ND/uOxElJI8Z3xpe2huo8jWqdcgkA38h2Co+FgDYOOZTRtMhcQ+P3WFkei8ex28q1dLY
         9TNYJfga5+kCcHiRnaQm4dXMg27iNw1sH186mHKIRTue1J99ZWQOT2tvOgQA1ZSDsnV9
         6SYzKnxUgSGpiolvmKNPM+m7lEU/sx4LA9lvQIlzWakkddMa+9OjnVZHGno3K46AWlLW
         f8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW74Xyosx/bTE4lBSvCdH52RzqoF5nNkSIVr98oV9rXUen1tG3SWeUPb+DsHSCO94tr6QbIg8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9DugeqxzbZWPFRGr0o5XruLxVDL6/XBgNuDPIDoDRRVBBiRB
	CwuSSbQj5DZcfAHbWh4Y10BkcYXjNrrbHmFqFXDy+TOGPNpqG9V9hjjTdSjrz+b49CUiaBYjSKv
	C/YzBRufbDcn/ugQyfaAdXWtK7Mfqe1u1vLCGmXEjGzYy0n/7K5T+o5NVxQg=
X-Gm-Gg: ASbGncsboeyCA/T4uYfYRJl+6+Q/uI3M3VeDprbTwu9i9ZBzERzxMywUV8tk69L3nyA
	kABMadrCVq9Ffbvpt18Tf0BqRb/Rwpx9MzZJySPQOp90hyzth7Ro3jG5qeZmLCBBen05mY469AZ
	Fx/B8rfECd1iOKxsI4q8QaAlncWjG+4Ehg18r8sFoPgjac66pvQVQgGOzZcVTueIo1vG9MQ6o3l
	/t8+tPxLP20Q3y8NqoyP27bfLGYzLHp38f0jvAFCbLnAmth1EFNxkfC3+AG9F77qWAP7r781ERA
	aZAL/bWZYa+IF/J+o34Lwsp4HP+GhO5uJqzjjyAd2dACkFRXrNY5yEI8NK7y/R/izvqJk6pFTy3
	KpNxFgj/0PT7lRv/k8Ka8Fw==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60505311cf.2.1757075185034;
        Fri, 05 Sep 2025 05:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHIZ1IK9XJ4FfWiCBoKZm9Dc77t4hxWRO8SKHBZ1qvz1azh9QEBjD3+6lYU1NQiV7h5+pluA==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60504851cf.2.1757075184359;
        Fri, 05 Sep 2025 05:26:24 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm1546636466b.12.2025.09.05.05.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:26:23 -0700 (PDT)
Message-ID: <34d9ce02-5711-42ec-913a-772ee744b7e4@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:26:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
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
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-10-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-10-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68bad6f1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B3P4ua6ZyXwAq7e7NPAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: exC2mWlGYo-4d082v3GANit9-Kme4dWM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXy8X8zd2lJAsS
 rwt+IB4V2s6IAe8Njpsrraj9biZ7c95uzRgCqWToHHC0Eq4fpXgeDw8lVfJ0qYA/YxMmeBluMW/
 yn3vOOgRzqAA466LeA4flEF9aX4M3W8bq28O+ETWDemyKnrUvwqr39jHZVdQq/R+PMQd5eBJVBI
 CCx2cwydsacluDa0faaL6Tq0AxWoikl/379mQqY7ZvawMa8rXi5f0XAFgmHO8xgORZmDmgJAxpe
 nzgQAxoQlILyNYwHvhm7G4OHV3IVxTxbPVYD++OodEK6rKHV1SweG3OQwpMr9Jzy3QYAPIlCgfg
 1lGqPGWVMQi8C1Le9XDBzuhpvh2dpvMuX26kcU3+a5S72PNolOLPABTQ4XXx/nY799qJOBbLSBb
 +yuJBjQQ
X-Proofpoint-ORIG-GUID: exC2mWlGYo-4d082v3GANit9-Kme4dWM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> Enable the first USB controller in device mode on the Lemans EVK
> board and configure the associated LDO regulators to power
> the PHYs accordingly.
> 
> The USB port is a Type-C port controlled by HD3SS3320 port controller.
> The role switch notifications would need to be routed to glue driver by
> adding an appropriate usb-c-connector node in DT. However in the design,
> the vbus supply that is to be provided to connected peripherals when
> port is configured as an DFP, is controlled by a GPIO.
> 
> There is also one ID line going from Port controller chip to GPIO-50 of
> the SoC. As per the datasheet of HD3SS3320:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
> pin low. This is done to enforce Type-C requirement that VBUS must be
> at VSafe0V before re-enabling VBUS."
> 
> The current HD3SS3220 driver doesn't have this functionality present. So,
> putting the first USB controller in device mode for now. Once the vbus
> control based on ID pin is implemented in hd3ss3220.c, the
> usb-c-connector will be implemented and dr mode would be made OTG.

Hopefully that's somewhere on our todo list

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

