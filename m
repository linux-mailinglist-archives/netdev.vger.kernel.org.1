Return-Path: <netdev+bounces-206802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B6B046F2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B63BA65C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA4267AEC;
	Mon, 14 Jul 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHQCd3V0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AB26562D
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515630; cv=none; b=SPxPGM7GEKx/jSSHxbDhGokr+uxXcAjjMbfnyVGjT3rSkptiq08U4FhfHWylkU1KyahjN2/0kRAjp5BDskAYFccbB6Ai4fmSll4n5QInWptuHYLikFLB24HHmV+BZ4lqrCl2clRGOa05tqoObhlrvXu6oiDvzCwFY4SyUBlXhxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515630; c=relaxed/simple;
	bh=YvsJN12SAY9OQ75DnDkBYqvaW6o0cntTB75m162ikOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzhh8mofUWCAgR2rjbioYm3uPigcqAofvYuwe6HlGESSRkNxnfTquJfsLRGq24LykFofZuzFuZZ8Oo6I0sqX90NcMAq3ikXbjpJa8IeeKd80e3vcCrqc+EQeTJQ+vHBBhLpI7ELENt4E6ZgAU3XPOGfNvCK3Zn5EoY3Czg5bWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHQCd3V0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSRv2012419
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fK6x+ly3xuI/2lAjrk6WHaK2Wj/VJnTiR8SzPU9LGHk=; b=YHQCd3V0Cae+VGUk
	84WIQIRbGymyYAmUvvD4+fCmV2kNvPOF6HVlOqX5DLwSrU6S70yklbcgbE/4BCL+
	EeN22p30ny++MTzzLnKEHGe51UUxwLOAJgUuS0WGNTIrTLnNOgIaKUYRn7yRh/Tx
	8OKLguXe81zaLvLUDJjY3O1ECX5PfZYGD5s8C70atShXlot5Y5W5hClCDa5B2Pp5
	Y4LD/R6L5paSi+da7NqbFjTDzxrtyETwZQO1CVwYdabfMwdbt8ue2kWMe43HHnJ6
	aGbxmaWCbzrXJk1NG2zKXdHN99bw12m1k7OrE9pgmYJ+zy2yL0Hy88DqR2D03cTL
	g/1Y/g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyg7ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 17:53:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fabe7822e3so3006386d6.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 10:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752515626; x=1753120426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK6x+ly3xuI/2lAjrk6WHaK2Wj/VJnTiR8SzPU9LGHk=;
        b=KvBYJf79N/NQUrYyOOmEedK6GbmuM7Rot15yFSKvAd+oHgZQ/OvSbVRduO0aEL1Q6b
         cFfHRa70OpcjZP1nZ7/3Me6XBdtJUeL1MCI5ys3JFWhkC9G9Cgui5wRShFARXTcUxlgM
         9cPiOe0q0Idt5tXwqJyO1F1huWOsg3TeQC6iGdSZHhyN2yYFO/Q4EAu95DvNXaB5128h
         pzVSXTXkzyawa3ueYDBjgFYCAxCl+1vvQpzm2yc69Z+ZE6JSKClsTzhQd+035x7hZy1C
         rhvKfKQXeax0n4mKzcYw0WBSctsQJCDdW0sEaym1gnsEBh0ECEwe48633sFKSJCdnCgK
         zhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOdgPht7iE+T9UOgWhiDEYZBiEBh0HSFbYxV8ovPCFbF2Plhlk0QCAhLxMya8T3JUizmI6n6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNDpiI9Wnfso7hh9GeG8x9nUEMvX/X/6JoL6YVnbYjQP3dfhQ
	ak4IIHu3oC/wE+3tx194BE4ZxZk+EC27YpFVqOsiZItZ3zYS2iI54ElTqbT7Z6/7t/dErk/YfEu
	EB35Ya3gwxu/CGEu2T/zYIyXdYtEHIeiYfYPpeilAE4zw3R2VX4nWQ6mjrew=
X-Gm-Gg: ASbGnctIZjm00PHSemszBiblSa/WgbQIcivHDFbICld4UCvDz+v2a91nHSMHLd2M1+Y
	fVb4Ng+f5bl5f8cHTFhY4ZDY5yOMi0wn/K9xq8JByQU7763XnbXfPsW1fMbLbQ5cs5Er/XM7rBi
	u9L0CQ8hQHnmYEoaXf3Kkuah5tzP+x9P2MCM2I2hzk3scPIKieh1hYWMyD3q8iKef9Myr8prkF+
	ggxZW2PBTsj6WONtWd//fqTLqiYZgutUnxf7vYiSsY8fqLyOpMQV+AvzkUv65WgUc0avDPYr9ko
	rAYgt637r0/0eQup/8yL2iduujdwIwJHjsLbt/OD96MvHjiJ41pe+uMwgMiLb9ZBSy2j2RSaUQ/
	lpBSl+yfDjc1Ciad8wRU7
X-Received: by 2002:a05:620a:618f:b0:7e3:2d1d:bda5 with SMTP id af79cd13be357-7e32d1dc30fmr148797685a.9.1752515625436;
        Mon, 14 Jul 2025 10:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH33J/OmI1AFTIjnQFvLICqDRKARWzq6lcWnIeXIfJs1esBEhAy06+UMvKScpJWaDTw5mOsbA==
X-Received: by 2002:a05:620a:618f:b0:7e3:2d1d:bda5 with SMTP id af79cd13be357-7e32d1dc30fmr148796485a.9.1752515624920;
        Mon, 14 Jul 2025 10:53:44 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ec04sm6252166a12.60.2025.07.14.10.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 10:53:44 -0700 (PDT)
Message-ID: <bf78d681-723b-4372-86e0-c0643ecc2399@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 19:53:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alex Elder <elder@riscstar.com>
References: <20250527-topic-ipa_imem-v2-0-6d1aad91b841@oss.qualcomm.com>
 <20250527-topic-ipa_imem-v2-1-6d1aad91b841@oss.qualcomm.com>
 <97724a4d-fad5-4e98-b415-985e5f19f911@kernel.org>
 <e7ee4653-194c-417a-9eda-2666e9f5244d@oss.qualcomm.com>
 <68622599-02d0-45ca-82f5-cf321c153cde@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <68622599-02d0-45ca-82f5-cf321c153cde@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sUIflDT1flekZifh96BH26olfdK-5C0y
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6875442a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=kRKpuzDA6j_fRx5RDl4A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExMyBTYWx0ZWRfXxY9vot5GeJ3x
 n3aXwD7wnhjjeJAEVpjXcJb4bgixKQP/qnQzGggtvjXupSyht86x9WJs8ox6XHLCIe8I6MYJwSt
 nu4Rtiar6POS7u59AuSWD1PpkwP67Gu8WryyCujYzYxF5BQaiVD72HBU/toFFkfcfE1q3nE07TA
 nbsCMsVUF5ruHMNCRIIen3NityFegFJTiZoiZTqUwMvZIUL7PhfK9Co+rceaLXfiC20O73QEnOL
 b/PfZH9MGWLO4Bjz+uKxi6apuwXpk0Fs03cxTqj1RoKddMHyYlZz3xzZuNIdGkkLnSUI1XgLNJp
 LuE2gl/eUk5YIECkzafS9Oeh5n7VpRejsq8cSDdLKelCYKra91jFlmO2Bh6xBp7yT343ljQy0r3
 I4eproTsnNymMkpJj3Sc4aQOah5dx1TjuunTX8YvDtanl4yI6CwpQsndy/vjmaeQqfZiIDvn
X-Proofpoint-GUID: sUIflDT1flekZifh96BH26olfdK-5C0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140113

On 5/27/25 1:42 PM, Krzysztof Kozlowski wrote:
> On 27/05/2025 13:36, Konrad Dybcio wrote:
>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> index 2711f90d9664b70fcd1e2f7e2dfd3386ed5c1952..7c882819222dc04190db357ac6f9a3a35137cc9e 100644
>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> @@ -51,6 +51,9 @@ properties:
>>>>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
>>>>  
>>>>  patternProperties:
>>>> +  "^modem-tables@[0-9a-f]+$":
>>>> +    description: Region reserved for the IP Accelerator
>>>
>>> Missing additionalProperties: false, which would point you that this is
>>> incomplete (or useless because empty).
>>
>> How do I describe a 'stupid' node that is just a reg?
> With "reg" - similarly to many syscon bindings.

Is this sort of inline style acceptable, or should I introduce
a separate file?

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 7555947d7001..95fbb4ac9daa 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -67,7 +67,13 @@ properties:
 
 patternProperties:
   "^modem-tables@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
     description: Region reserved for the IP Accelerator
+    additionalProperties: false
 
   "^pil-reloc@[0-9a-f]+$":
     $ref: /schemas/remoteproc/qcom,pil-info.yaml#

(fwiw checks are happy with the above)

Konrad

