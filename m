Return-Path: <netdev+bounces-208115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1478B09F97
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303D51C47E82
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B2298CC9;
	Fri, 18 Jul 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRxMhSIS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872A298987
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830900; cv=none; b=lkpW0SsEPh5HJKUqfVFJNCIgFeezrVDjvUalfJNuB94pdZa0L0yP4FKwCKbKxGsIP+E/fyeWkyknUrmVsCn7DqQ3FSHdP5LrjbcXGL6phtIlLUXkkFseL9IctQ517djsBTBUj6GEhhIIkTCDKHDhRiQ0TiLSW2MbzXOJ4eixwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830900; c=relaxed/simple;
	bh=NbnKZfzGqskNbEfXayr5hGk/GwKuQRNSeP/X0NfYCeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRMTmtHMi9fYpxUNbDm9QFgx7v9i3AwsWvzVGSZRq3UUGddZynMl/j05ZH0YLAMxziZE77Sc8Y7gx7iBrY6Eo7jEkfRJwkYp2+zIhmnEuU6igLSSCSm3prfc8RhmdqxMjW9HsFXkVMTkR+XXi7S9khoVB8x1wJI5YBYuCtGwQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRxMhSIS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I04QtR016007
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 09:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+VRe0Ju/sp1iGJc3RkyEXgFVAS/G2F4yjLjeyBrp8U=; b=HRxMhSISSIU/oC2I
	fbV7H+d23qjgP3ITqLd6VHqpcNpA1JPdwO4DhtdRFd/Cio4n93BywGXELX8Ck3/7
	oVixkQM2nHiG3W20ztqBz4RWvr9tIqpBucgGLvldcAcWgtaTQtDMRUSu6sNFdCAE
	1KGyGGtiiF64hAFz2wzmx4pUBusBkKAD4Z0n5VM2CVvQC22WEsfQ888XrCkz5/f8
	FZfNI8uuS3u+G6vJT18ZiEDtcmofujrxe5AuzCqElCrvxAnPjnoDY/SEzv5UdlUU
	/c50vngyayo0IQE83pyZfflmEy/Iz1Dk2VeNK5ck5hRu6UGamiuJk/LzLcylGzSo
	T81KzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc2tmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 09:28:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e2ced79f97so35533585a.3
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830897; x=1753435697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+VRe0Ju/sp1iGJc3RkyEXgFVAS/G2F4yjLjeyBrp8U=;
        b=CDxWNHkdRnyuLRMRORSg8BseIlQLEdDdcJzdQ25jlT7AtNwbXkHCsnQdOQfkJyLPRK
         hEXSoC+X0HF0scByOGDQYKlW7HX4Zzu1a7nIMj2inHznA9l2SewScYVI/5ZV79VnRPyZ
         wZ/9zWuXsxduLDUiIAkaiz9J5/UM2qzbBCkcnipK7mH+CfN/s3OaRFOkKi1TsngoQF/o
         nYBMqyw+pFaB3NEwoFUp+vn2EOBBip/GfpLsvldRSRYK1isDh+cyJN2POCFMEP6a0e3M
         6go7ELzaUZOlCcluMNZ6y7w2AKnNHWcitb8khUZ5wGKtLE8XTA3uUSLuLyaQusbIhpYz
         fe9A==
X-Forwarded-Encrypted: i=1; AJvYcCWRXF1eOKUHi8HZfkRyBjALM4V7q2+nSO2vYXEMYT7MJdqDb5+uaizE9X7aezvQhAE8Ph9I9Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpNWQXdgDExSMd5h/OwudqgIPUAocougFiSr3jB16tPWOfq2c
	nNLYyMhjkxdwceJcNpT+vDsV0ftjmada6aJA7QViigIL1PPjw4KS1f8hyipadLN9xHv3UbyLXft
	Upx6R37fJaQRor2UyuYsKeCR7ltcTlXh+J1Eh+yA9HSGz8kBMYsqJmC2FBhg=
X-Gm-Gg: ASbGncu+eFS+cp8IiVVmj2zyJri1wP56a8ywWQ9N/LpH30hEiCHctVZ2gpFn9zdfK/J
	BUrZz8JhbIVfeqitU/xZ+bJqP8JrAmPZJCSgMwRpedS6yu1POm2lroLB7NxpsLPDvW+Enq7b0UQ
	fVDcChHNe+csXYzUWiENb/3VDUmdfa8bMECBm3G7N5RqX7xILhX0gvPK6tKhaeibMqzV5tvg3g7
	bbT96nGd5YS0ifHzpZ1SuOorGiFLS4bmJ6EyqKxkZPxbCnQZW8RRjwn5XIBR3XKF7EGITWbAO57
	CgyTkzwMf8JEjQPzNYE+/z68cldt0tBRMOWLikYW5q8voC5ErXRHQ40HINxZzUD5FpE6TMthnuk
	mqAA66Xdt4YPKz6qOFSrI
X-Received: by 2002:a05:620a:4153:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7e3429d39b2mr559973785a.0.1752830897009;
        Fri, 18 Jul 2025 02:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC1R6EIQ1c6MEMXvvejqhCbTPlrLcU2EQqZ1eX8XkE7MU2u6NGRZ77ayYNHvIednR+yi5YWg==
X-Received: by 2002:a05:620a:4153:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7e3429d39b2mr559972685a.0.1752830896492;
        Fri, 18 Jul 2025 02:28:16 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907bb58sm696134a12.57.2025.07.18.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:28:15 -0700 (PDT)
Message-ID: <a383041e-7b70-4ffd-ae15-2412b2f83770@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 11:28:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Luo Jie <quic_luoj@quicinc.com>, Rob Herring <robh@kernel.org>
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
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
 <20250710225412.GA25762-robh@kernel.org>
 <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
 <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a13b2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VT5E6NTcuoebdF1Bc4oA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: JinupvJ3ZBopozvAQ967p_Wnp8oKXrOO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3NCBTYWx0ZWRfX2KJ7ceJKDlvy
 shrR7pWAvF+kgTMJjzx1scN1e2IUasaF9amac9jwTomYs6tIGKgs3MPNYYaLSV5dfedEY3LpkFD
 UR2UBdu/QJ0E7kf0gADqCA2KXpx02+ZkNhNHcUIIqqhG6GOcFuWPb8QwH9UYojESsEknT3gmRhP
 mO7pxoXeBELU43LLYfZPskwH9RhVoy/Zs5vV6Tty/1k6GFBVPyYNtkxeGsTt4xytfOrjmchGOpF
 3el+p6Ejr/eEzdNcWL+5vh5WStpolYbtE0WLV2A47XTQ/x+/PRk3r6SANc/76s83KdjjHxEJd4u
 d+Owucj5UGz3PPTte9U1AAotVUVzAoBP0B4U/QMxCxTeIM9Hf9Bl1Nds3WBcqt3Tb2Bu4cz5Svc
 9wWdoGIBdJfaHpmP2tIAw5XnUMzUhoP/PECC9lIqGvz62FrIUlf3UN6qxC51lmm02Yw9zfpJ
X-Proofpoint-GUID: JinupvJ3ZBopozvAQ967p_Wnp8oKXrOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180074

On 7/18/25 11:12 AM, Luo Jie wrote:
> 
> 
> On 7/11/2025 8:15 PM, Konrad Dybcio wrote:
>> On 7/11/25 12:54 AM, Rob Herring wrote:
>>> On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
>>>> Drop the clock rate suffix from the NSS Clock Controller clock names for
>>>> PPE and NSS clocks. A generic name allows for easier extension of support
>>>> to additional SoCs that utilize same hardware design.
>>>
>>> This is an ABI change. You must state that here and provide a reason the
>>> change is okay (assuming it is). Otherwise, you are stuck with the name
>>> even if not optimal.
>>
>> The reason here seems to be simplifying the YAML.. which is not a good
>> reason really..
>>
>> I would instead suggest keeping the clocks list as-is for ipq9574 (this
>> existing case), whereas improving it for any new additions
>>
>> Konrad
> 
> Thanks Rob and Konrad for the comments.
> 
> "nss_1200" and "nss" refer to the same clock pin on different SoC.
> As per Krzystof's previous comment on V2, including the frequency
> as a suffix in the clock name is not required, since only the
> frequencies vary across different IPQ SoCs, while the source clock
> pins for 'PPE' and 'NSS' clocks are the same. Hence this ABI change
> was deemed necessary.
> 
> By removing the frequency suffix, the device tree bindings becomes
> more flexible and easier to extend for supporting new hardware
> variants in the future.
> 
> Impact due to this ABI change: The NSS clock controller node is only
> enabled for the IPQ9574 DTS. In this patch series, the corresponding
> DTS changes for IPQ9574 are also included to align with this ABI
> change.

The point of an ABI is to keep exposing the same interface without
any change requirements, i.e. if a customer ships the DT from
torvalds/master in firmware and is not willing to update it, they
can no longer update the kernel without a workaround.

> Please let me know if further clarification or adjustments are needed.

What we're asking for is that you don't alter the name on the
existing platform, but use a no-suffix version for the ones you
introduce going forward

i.e. (pseudo-YAML)

if:
  properties:
    compatible:
      - const: qcom,ipq9574-nsscc
then:
  properties:
    clock-names:
      items:
        - clockname_1200
else:
  properties:
    clock-names:
      items:
        - clockname # no suffix

Konrad

