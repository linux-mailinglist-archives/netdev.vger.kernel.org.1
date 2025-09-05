Return-Path: <netdev+bounces-220337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4BFB4574E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7756A4E4B7F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D7C34A32D;
	Fri,  5 Sep 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGexhjM5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCA72615
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074185; cv=none; b=kwgEhTUM1kspP5fSErfQE4IvInHbg3GExECaIzr8Ev9gbRoOK313Ner6LXn7IH1oJ2p1QkzHJEMzPm+nAIA9/ZGhnTMblND6G9ghOwXG8+LGvCeG0JEGPsDkrKAHpD1elPtJLPIgyTrTywdVfTO4dg1zwhhZwPGDX2EqZ1yrmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074185; c=relaxed/simple;
	bh=YHBkz0h0Rvf+QBxHBQvEoOTPIUgICyaTi8a6q5BhBOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWprGsmdKdefzwAhfFZTVUTqmyA4OBU3sHsUAr5vrSHy+v/A0/e01vk2o5xD1R/807ngW7SwizN9w9Iwf8k5/p1DCjr13XIBsD/w3o2zhaD45wgRxMxItTioGNuPS7G8VsRXLwJsc8ismSL0nNq4++quSdLj/bBlFUGavSNQPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGexhjM5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5854pPpM018533
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 12:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V7ghSLZ7heKhs650IbAjk8nclyw1JeB2lIG1BpFKJVs=; b=IGexhjM5a/NcGRFU
	RYU2LhDskGj2CGBjAOpoBE0WjJRvqGwcGd2HzwHJbT7lk/0b5e8IGJrStHqnXJJn
	Kj6KfdUhKsTXhjQPJh9XmCSMIMoA12C0IzKMBzYZOHgkqjxvCwVz+3v4U7rbH34J
	8JMl34fntONWURRhf8MNHMJamDzuyllkoZLkxqyO+VMTLasqm+ni005ReUrcXCen
	PA/V25XUuD3HXfZcgNK41y8SR611oZfu7dQfjk3L1S4e9j3gO7kypAWy7GuJI2hp
	izI+QLtxPgP1DHkK/TP3F0OKajz65ckUuGYaDNOQbTuB388QUE7FSdzwgm5G5JCV
	UX3hQw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutxj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 12:09:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso8109081cf.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 05:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074182; x=1757678982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7ghSLZ7heKhs650IbAjk8nclyw1JeB2lIG1BpFKJVs=;
        b=m2+GCIuforPNAo0SqyS/2risn8PoocPbJxDNjFYlCODj7J2y6NlDvwu8F+tPqo3rzA
         bmWfkryjSjKSWX/0VfJT5H55hY5+r8WuzoF5L3L+5/Ddx1eSmzAMkrPamtmprudSpYvq
         biVH0BP6eF36iAq+yaxwP4Gpy7m9y38rnFK5417B9MO7AiGzucjc4l364fnYOD35Mxpe
         jbAc8YE0qqTr/H04GmANfF6pJglrO2MXzVzP/1ozcZDRCrJTbu2RhoKPoudwk4ja5nMK
         IZRIMXX162hxAn/g8iEjGgf6oFaqZanuSWbjdSOv9rsjf81lyCGLFSO9NUCXAFVHx98D
         MCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCmAIULAiencM2BrY0Osl2K7Axjq/AUWfqU4VORM4/q3nM0gmnkiZBUKbAtTtqmuoBgwygSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxzf5EfK095sAQGJ8cB9fKWAjVpG6AE/onURCxuSxqjmM0rHCr
	qhbDAESBLkJ9YYFGy1hm+Ii0k6XwIVhetvLmIkq+na6yCKhxqDYxTVrce/yWC0pAkeXSSDAF8S4
	Js3rkxl5AmfW6lFvN3EyhkoTxeV05GMWg1KVWsrRJBdqoA82fVsqPIFL8b5Y=
X-Gm-Gg: ASbGncubsr97jqDVJAru0XFMKrYI1gToUnSIBHUPvRvGuKL+Fbrq2P9Y+pB6owEo4X5
	frXm49Cte0B6u5XhLH6VYbQ7QU04uGppCI+L+TRaLtDwabyJcunwnJiWl02DrVLTOaH9X3rSvDz
	5RUrknOClNoNacVKJg1YIc1e6Spp1PGDd1op2MHHD4fkm1E3/Ne5gQdceNFW1mVZKxhVLzl7uqR
	EqyXD9sfREOzdcILdUH6tPh0/eH3oVFR3M34XrIK0Os91b7f4EyyXA3NSP0sQi9okWRxHX7tsj5
	VT+jq3uMbOnN2m0+uTIANFVpRbHt5CQoKlg/VgSGorH9orbv4O43jL+Bwqo6jVXt/nix2yqBefP
	73rh2QoCbwMKjzIwmSqot/g==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60014631cf.2.1757074181560;
        Fri, 05 Sep 2025 05:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/PGqXh2InjZaarOb7O9uqOEso5Jemelf0KIpqlrqz5P8qaKxyNGfd6p3aVvjCmjCOCb3Hsw==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr60014111cf.2.1757074180997;
        Fri, 05 Sep 2025 05:09:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040a410817sm1487836266b.101.2025.09.05.05.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:09:40 -0700 (PDT)
Message-ID: <9694f896-e1f8-427f-bdbf-225706338b7a@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:09:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] arm64: dts: qcom: lemans-evk: Enable SDHCI for
 SD Card
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-11-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-11-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JQEgeWuiZ_eaPiL9omzyUVdKqn-xTP89
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bad306 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=3hZAb_iNorm4NPqi49MA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX8pjBUzfdX7oA
 iMsubSAJHLAgIGSSjxlJrlnmzDS17pmlfW8ZrJpS4aSpKpQQEsUZNTg0JAIOyuAIGxfPfcbyD7T
 5AmWki9wE6yWj5++NZt+i6p7fsEcERh63kf731H9Yqd9zWqZNFJwQXsunaG1wV8lKy4F+dDBup2
 Mu7a8yTmmLLbc5uC4qaFZQAqFCGy8kidk+r3dsEwF52rn0TidleeFOzykR4CzMs6pz0Wq7wtani
 KUEd/GLNBMdlzw7wvcfniXtwz80CVzxCAbnQJ/81neF2TuZqJX114JSLK0CM40fUqePYcIoKU+F
 4VM71eh1agq05a+TMEnwxO+dnorVs0qXPjnP+2NaC7MD7AGLhct/eNBjWp0fKxRV6/o0Rw3hjbS
 gn+y+8dX
X-Proofpoint-ORIG-GUID: JQEgeWuiZ_eaPiL9omzyUVdKqn-xTP89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
> to support SD card for storage. Also add the corresponding regulators.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

