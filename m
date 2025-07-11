Return-Path: <netdev+bounces-206152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE8B01BCF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E211CA665D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDA289E13;
	Fri, 11 Jul 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3GWZoan"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CF4A24
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236188; cv=none; b=nRhz5FyviLA8PrylelrZFRB6pYv23+JSf+3tOvtNia9XVjE6xFjARVc7YCL1U51slwkEauw23kBgOB6egq9z2YlPehNCzRR1e2f8J190wmXpQxuIKNZ95M6h7t8dXBazskJgFiWeJqWb8dTrlVo6hvTYLApD/PDTipnnUWLowPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236188; c=relaxed/simple;
	bh=jzx49LWasGFGGlxR7Ivay1UaWJmdLn3HEDsV3AUB9C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXZ1fy0IXzWFxQ9hEBlDk9DIG4CZZA1JRY0vYOvDoxgo8Y8E2ericl+lzX4t5w2I4D1MA+IkJ8rqYDG/VsC9xUpL5PvuGItQ7uLryEQAiyE31JUTo5n+Au5mUXt49XoFuDzrbJSvaZGrX9tjvqTnAmtLvLih3Jl6whJZQNBOiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S3GWZoan; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAbrmf021754
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Ptpi4wEY0VGWKqhP6TpsQQpNA7vOEtkh/zteGyElO4=; b=S3GWZoan6d/rpmox
	q4U0H4l9UhJz6raT1pEsDusqo+f417src7m+DQAdVZB7kQtM0gQ6fbZibMCLMqIq
	1QqgAhdm84nWqNbsz8yJj0/L45TNBFWPxv+CyUbL6Kva+qVU+6lxMl0dPitizGEs
	MCYmTVlYh7+LmkmuW4iyW1sfVK609ikHEnfRn0BgQ48Oifo2Bd5Bxo+uEwyDSHBa
	FuEKVYdf/pHAvU0XpV2a4POtgq4z2KkQNUypj7blCgJaHzEb2HhLcDvmBwXtXyru
	+PG09gTglWi0/wrXXO0K1QrGwIIE1xJJ3knryTZRJ5VYKOlPVNJw51ZLO0ht5JY8
	a+4ocQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b19hc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:16:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7dfe47423f7so7183985a.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 05:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236185; x=1752840985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ptpi4wEY0VGWKqhP6TpsQQpNA7vOEtkh/zteGyElO4=;
        b=CskZNdfCm8BU4Wa33Ne7OC9rTTq5L2eA2qInwzs3ynu3YDyaEJ5Jn4CTnK9pfGylUf
         6X+NL2/ZGHTU/ii+o7rZ0rprkoQKwVr83Ps8L818fmugCiQ1lpWtiH2FjGvktMZrzudY
         DKLlUF7GURaw7GcGb9UWoenb2FHproNtaJgf5WhlpIxX/7XBEvdeTCkqcUbrzonFaBec
         Jnte4KlNN/E4M/ZJwWuoJD5jznwMwax/L2faG19zw3aUxvF7A3XCY8nZuqcPi8tVG1jj
         jEhitezjk/cmL3ZvDAeGa6pPwqU5S9VYof3YEQ00Yk9C1TFzJk+1E851W4CqvEd+sw53
         meEw==
X-Forwarded-Encrypted: i=1; AJvYcCXn3JKrs4flKLsNTwytRNsVO/6cPw0oIiWa4UiwMzb+oGSR61szwMicS9a6Srp/uxyeWdi8wV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQUxDw0xxuNMSvXJftBQF0KidBXARIWxkw3shRjY3mcgKtvPv
	SJMjaObj1GDaigFAFN0aNqMAWIhO/3oIE3uckwDVVOh53NliJYOqG3YvjvyLjnVxiKDA9DC8RbW
	6Ka7qhS21nwe5tOiuRgPxjI2BFKSXJXSUE+traMA0q5RRumeqaYusynPTL1E=
X-Gm-Gg: ASbGncstR76rwV4in/uIUjQ+46OnqMLq80O1RsohQCPTc3PsOQLoEDycFBPgw5YzPuK
	al9D9ccQy9aUxD2D6LWxqXGOTp8LuoLpNF8NiHBPB7WowiSWCbKZXW5NMeGhLKv7Sj9J7ZvGsFh
	hLeQRTPEc5UnBon8B0PMwojLc0JJ2IotVJvS3o1TIaTwFn+RXCQCDmLQQv29DM6LcMnMukYfyvZ
	Qem/bbjHWp4ZAM3bZJ+I98h83lhhT3vZ3/RSs66rjtpNQzpgZzvimRKwQkrlmMsUlrmXNsyeBob
	U87L+uu0e3BF556fZ7VYDFW3FLV17jHbTovi1OWugAIoNvVCyFONg95Mc/MOXQlyRvvuvEgbHBC
	qPop/eRIySvvrhR7QmCk0
X-Received: by 2002:a05:620a:4004:b0:7e0:1c52:685 with SMTP id af79cd13be357-7e01c522468mr49298585a.5.1752236185085;
        Fri, 11 Jul 2025 05:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwKjT0BW3S+d8V+GzTuZSU/tPNQqmTbJ/pUFGmyL6fSlH8EpT5RkkPdl3aoxFddiWPJQIw9g==
X-Received: by 2002:a05:620a:4004:b0:7e0:1c52:685 with SMTP id af79cd13be357-7e01c522468mr49295685a.5.1752236184618;
        Fri, 11 Jul 2025 05:16:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8265bbesm286528966b.80.2025.07.11.05.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:16:23 -0700 (PDT)
Message-ID: <0ef83a1e-38c3-41bb-8fd2-c28565f2a0ba@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:16:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] dt-bindings: clock: qcom: Add NSS clock
 controller for IPQ5424 SoC
To: Rob Herring <robh@kernel.org>, Luo Jie <quic_luoj@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-7-f149dc461212@quicinc.com>
 <20250710225539.GA29510-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710225539.GA29510-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6871009a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=AWTENMeICeJJ9JQOPWgA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NyBTYWx0ZWRfX++NHqE8h3N/Y
 pKFoeXg3GtoWbFUD7fh9wPyXBWcA7wf4P/hImD8xqdJ0lGPd7TZ4BhB4MbFRleoMPsC9v3rbtcz
 LDmkSjYdAc/YiLsQm3UVLMM6tqZdhjNVioMIDw5bt43eu5oJbO/Tk+ip5hpaEnFzEbbCd1dUX10
 pYY3/AeYT1d8dqnFAg3H1b4I1kvB38ztbMU+/En3zVzRxM1Cwk78SEQVbmYRq5zGgByyOh+vFOu
 pcBfcU3KLn+WIZquSTHyRl4i5bHqmxUv5oozAge3Uk/YsBxPsQnIShVKRYMt3TH6CtyJsilhQO/
 8TdGLVN8DXDdKSM9KlrggSsK3nivYm9sOD+ikfY21eYuT1Hn9qfRBOqtHjqO6XF75F3rvJAdf2z
 imVAeHAzFFglIrwxlr1cp8j0ZzJm6ilBoefw0Jvq2NXAFmFPaURgjaztFiQMbKCQ45y5UX4v
X-Proofpoint-GUID: _J5Ik5he5H_eea4YuSRu4qcdm4xRONKb
X-Proofpoint-ORIG-GUID: _J5Ik5he5H_eea4YuSRu4qcdm4xRONKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110087

On 7/11/25 12:55 AM, Rob Herring wrote:
> On Thu, Jul 10, 2025 at 08:28:15PM +0800, Luo Jie wrote:
>> NSS clock controller provides the clocks and resets to the networking
>> blocks such as PPE (Packet Process Engine) and UNIPHY (PCS) on IPQ5424
>> devices.
>>
>> Add the compatible "qcom,ipq5424-nsscc" support based on the current
>> IPQ9574 NSS clock controller DT binding file. ICC clocks are always
>> provided by the NSS clock controller of IPQ9574 and IPQ5424, so add
>> interconnect-cells as required DT property.
>>
>> Also add master/slave ids for IPQ5424 networking interfaces, which is
>> used by nss-ipq5424 driver for providing interconnect services using
>> icc-clk framework.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---

[...]

>>    clocks:
>>      items:
>> @@ -57,6 +61,7 @@ required:
>>    - compatible
>>    - clocks
>>    - clock-names
>> +  - '#interconnect-cells'
> 
> You just made this required for everyone. Again, that's an ABI change.

In this case it's actually valid, but should be a separate fixup change

Konrad

