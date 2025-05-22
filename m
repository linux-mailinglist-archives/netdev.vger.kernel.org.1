Return-Path: <netdev+bounces-192888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E28AC1804
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D417A7BBD2B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52128C2CF;
	Thu, 22 May 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgUEta2N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559128B3E4
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956628; cv=none; b=bTdqlY2nWY/ZfaP62kQVDOFIYloRu5PN76rI9TfPyyS3ugbsmL0xRmrf1qxlPTZ5zDISetx2XrBsoBDHUYdXVoTJld2Blq1ihYQzuKNIjjvnkYD32+xl6wJ9TzEBlL4MgnIzAgARSLxGLrXL9uMMsPphXB4jcs+CmgKTV2BR6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956628; c=relaxed/simple;
	bh=HF5QrWdVgrSLXQpRcVZ5nAwvebrBgOa1rmbw6B34qJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ux+ExrdfQoLQGJhf7RI3ppTJiy/hmnRMQQa94Yk4NgGC9QD1ws9xj9DTz903o+k4NDU3GfHXoV/ItPzS1aUitc5WzMMgAb+75kpDWTVugHLPAHZKP4vsUWgjqtrBtdZUBtihWlO9zDCsRE50RbO8qwjegVwMvOe8h+DT08xQlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgUEta2N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MG381Q029654
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q3S7RLpIsIxMBOGoiyFOVXm3dKhx5umFsjWut4uZe1c=; b=fgUEta2Nsa1+MVYX
	wal3WTKtrgDYGJTVrIy7KiRZy+pR8ESPx+Z6CE/+SJrp9YiBxWpc9utuErVedlzc
	XlYHDcxMaPm6Wzd9Q+drm5AMQpNjFQClG7ooxoGHDokG6UAi0EZ5MErXzy9orK0A
	Ie5jZ/AsKuC1L90Bti7xanmoJ11Ir48gDrRzLk83wQArJ6OfkDovkjeCxuClGd89
	/KxQRUboP+0V9kyVY5qao3Tw0ZHchlUo7hN7HVNvaq5THOV/UthGtf273PjYSGJA
	xSpj9e5AdyxprqlDN7QXV626ikj/cltfCFeTlWOs35Lg2Evbz7gBuYyK12zJMuQD
	k+qoHQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf484cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:30:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5841ae28eso222977785a.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956618; x=1748561418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3S7RLpIsIxMBOGoiyFOVXm3dKhx5umFsjWut4uZe1c=;
        b=G4fM6JqKBhz7Mw+o+wtLRpNfsOetbo7g1DJj23+JgV5GPToWYcxS0IJoDjuGsNxR96
         Cl4SXM/uhQWAAxGDHktx4eD72+Qm5Q4WZ9leNevdWwmidn+5XKu5w1kY3sl7sUMuQ1YW
         L4uWmOQYAK4GpJrGrIJYfYOOFedg7YsXad4uX++qmHBFyQ00yACSsImSivqiS3F++1zb
         4mxOeIVj5JT5OY3oXiUn+LGzlFIgi76dTJxoJYc+/6ZnFR2qcd3MUNYEeURl+ECeg/WD
         hA92yEXTjtinURC03HjinuYlDo2FMhHsyVn8kX1Aoy0vFP19FN0LduSL3uVrJIu3daBC
         3TKg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2gh6i/ofadZ4ty3lG4hmj7sF6AfQkbBflje6khtLZsWCesX9TmDFV2kQs/4a514nyQZPDlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyga26zK7NCbKe4rCNjPEs8TGBA67wIEngCvUy7rNp6/vkhKupl
	yWcxl+DFNfoOs0HcyZymnt6nAzEeRJkgNa8I6ZT6voXb9nC9mD5oWYKUokDG79Al7kdtJSYftL1
	xi4GaEp130TstBYawAEf0WD2bL7Ft1OsvB/nUVl4iwYGAim9H+T4i6uZDDuQ=
X-Gm-Gg: ASbGncshvKV+8CQh7lVmqDZwfMdlmNrEgCh4H7MvqS1Eyfou7CS1oCpwG7laVMJH7j9
	1oiSEa9c1ddCGZ//rslvd/mp15YQPiBi2kY7/kk8+ifUUmrGXhlOXMb4CfCAAjVf+4xoqdCHgyO
	HGLNeLCrSpsALwhn5MGWNZG2+YD/dnpHfCLKZunni7UemklyVQJ8dL7wg7twBj3hXSG/ZFya6UP
	ULDuccD11yOnpym39yemQUQfKmK0l0Qk1B95zt7+saFG59r6bqfuQyfqmVcroaQit/kSZOkb/81
	tyGCNH7jGN5V2DNH7QaS2vRdlHJI6yTGkdxA06a59qzyzIc3563+P55wTp+D8LrzRg==
X-Received: by 2002:a05:620a:6504:b0:7ca:e39b:946f with SMTP id af79cd13be357-7cd467db69bmr1630329985a.13.1747956618444;
        Thu, 22 May 2025 16:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVfs/zUSS/wDRxV0gfMgVCmzQmxVBhUAv6PGmx4J1KZxeoM12aqEKSbM8jmkq0L7vFU/1Xqg==
X-Received: by 2002:a05:620a:6504:b0:7ca:e39b:946f with SMTP id af79cd13be357-7cd467db69bmr1630325885a.13.1747956617809;
        Thu, 22 May 2025 16:30:17 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d502ec0sm11219928a12.31.2025.05.22.16.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 16:30:17 -0700 (PDT)
Message-ID: <939f55e9-3626-4643-ab3b-53557d1dc5a9@oss.qualcomm.com>
Date: Fri, 23 May 2025 01:30:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,ipa: document qcm2290
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wojciech Slenska <wojciech.slenska@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241220073540.37631-1-wojciech.slenska@gmail.com>
 <20241220073540.37631-2-wojciech.slenska@gmail.com>
 <5bba973b-73fd-4e54-a7c9-6166ab7ed1f0@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5bba973b-73fd-4e54-a7c9-6166ab7ed1f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDIzNSBTYWx0ZWRfX3YOD0CBJBmLy
 QLd6t6GfGD1HVEF/XVyZ5qpgxwAtezua6ut4dIjdW78T5/TcY+tyOPMTlYqR/bGtAUJE2r/SxsF
 1lPbGj+gpfea6nVNrKSDJzOR9iZJS5Qv5tpPb+Gmpe2DicsyR32KXU/NXxjaFGR+aU5otH5ohDK
 r1X0lWLb8gtRcy+N6z5G6xqDjB8xT7hnJQ7fOR63KsFZP0rEAkhj4jB4y2L8zHjTlaPxmZ5SR5C
 k2tKkc2ZDsToY5cAzbcRgPfRaYPzS1uSt4SMJTJfOd/PjrcI+fO5rgcdyoN1LtCEwnIdd+Liquy
 ZJnmE/rvGbkNuDSLDL5KG3vL1zO4xywioPeR8E2kg4HzXcB6xcNFxqMXsDaTlk8XR+OfK1IjdYM
 fuvQ9Z6RZ6ukgHVMSqEX39CztrVtLtfM/glf2ReZHh+aiaISY46evhZhVEE7TOfwjBPrboTv
X-Proofpoint-GUID: rnBZc8fXhHtcnrgLZ5EJA78anysOrsu5
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=682fb38b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=dm-21qZVQiDOrTl543EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rnBZc8fXhHtcnrgLZ5EJA78anysOrsu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_10,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220235

On 12/21/24 9:44 PM, Krzysztof Kozlowski wrote:
> On 20/12/2024 08:35, Wojciech Slenska wrote:
>> Document that ipa on qcm2290 uses version 4.2, the same
>> as sc7180.
>>
>> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
>> index 53cae71d9957..ea44d02d1e5c 100644
>> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
>> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
>> @@ -58,6 +58,10 @@ properties:
>>            - enum:
>>                - qcom,sm8650-ipa
>>            - const: qcom,sm8550-ipa
>> +      - items:
>> +          - enum:
>> +              - qcom,qcm2290-ipa
>> +          - const: qcom,sc7180-ipa
>>  
> We usually keep such lists between each other ordered by fallback, so
> this should go before sm8550-fallback-list.
> 
> With that change:
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

(half a year later)

I've now sent a series that resolves the issue described in the
other branch of this thread. Feel free to pick up this binding
Krzysztof/Rob/Kuba.



Patch 2 will need an update and some prerequisite changes.
Wojciech, you'll need:

https://lore.kernel.org/linux-arm-msm/20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com
https://lore.kernel.org/linux-arm-msm/20250523-topic-ipa_mem_dts-v1-0-f7aa94fac1ab@oss.qualcomm.com
https://github.com/quic-kdybcio/linux/commits/topic/ipa_qcm2290

and a snippet like 

-----------o<-----------------------------------
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
 						"ipa-clock-enabled";
 
+			sram = <&ipa_modem_tables>;
+
 			status = "disabled";
-----------o<-----------------------------------

added to your DT change

please let me know if it works with the above

if you're not interested anymore or don't have the board on hand,
I can take up your patch, preserving your authorship ofc

Konrad

