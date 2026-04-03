Return-Path: <netdev+bounces-274985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJR9OGmaz2lHxwYAu9opvQ
	(envelope-from <netdev+bounces-274985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96139364B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E81300A603
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30583932D0;
	Fri,  3 Apr 2026 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oEUmKtDt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SnB17/Ye"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E99637BE78
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213076; cv=none; b=esW2xKdC4bP2BuvcJofyQ9SgKFmPvBu2IC1i0vVXKM/TQRNzMSomoXLWuWjkROYMMdPFRkmiy033/qeeog/WGoUTci56M462xMpmRCDA47q8BD8sH5ZT2rcr38M/kwbk2aD2cayOjIJfj1HSZJJuMLU61n27ySwrxkCkwPq2lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213076; c=relaxed/simple;
	bh=i+5OV1UMLf0KsB6PFIHIGfzBNc9YjQNT7smSsDfyqFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REntMMZNVI0hcHRrpeikq1tZtwAa34QFEICEGRLyX3MwAvT2G40nmI5Pz0hpEKliLBxg04q2Rba1gTjQcD96F7tceaMlvAaRbVzadRtwzHWnVrXdV1UsMV1d/OLjVcO1xHVz2SE7VGLYbpA/rZHjUuXsij8YyKq8Gfd1oAOfyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oEUmKtDt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SnB17/Ye; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6336wbqT947709
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 10:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qp7jHdTewElQMOorsvsIFbf0ZsK4yvWuAEvmqGviOTw=; b=oEUmKtDtsoDZ/RsH
	KD8QPRgFr20LYSOEq2bQS6KF8110TysMJA9lQSdtWKmMWVnWqhn1a7gCqzCVQOTG
	RBB1Z0KILG593kuQTVD+SfJ9ukEBq/UNH4e9P4qUjt4R2Sw58LsXNEV/BIzZpr0E
	7c4b3rPP15y1gie7U7O2Nzn7iADLfFSbECB0/blXK2HkXdpghCMm/wELH3YL8Udh
	cfVr5EMc04l7RpP3UgkVmEZMdgSSKeZmfjC50lvxFNaXEjFEtIgpoJE8gD4IDwup
	vJD3FZStaYI0YO4EbFxmfFKZhf/xD9PWun+U1YtY7FAV7h7dOiRo9faLmAv39dBn
	FMWTkA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9xwfj9e4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 10:44:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b23eb4f94fso8783645ad.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775213074; x=1775817874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qp7jHdTewElQMOorsvsIFbf0ZsK4yvWuAEvmqGviOTw=;
        b=SnB17/YepJNySg8dflIXwCzcLmxhJcMYIDCOo/uj5DdTdGDAlWHKIjIBDwFEpxbcPX
         m1/fh1fleZSuYe175Z6YPphvFwAlHkjSd7oQOjLA11PvA9/jkS5gGpZFpEr0C75TmiUc
         ry4TpmJSgw2bvfNHkpoTZX1uXW+i4xcozgcvytw7Zl+ChIx0PrkvyIBGrV1HSBkpoMtn
         njAvMpkFJSbudYNVEvdLHr1Cji1XCSSpT5T+v1NTKaBGkOQ9VP4IYm/XYegEtatgyP57
         gzsK3rKlgbswAcqkCF+4C1zwUfhHRP9L5l41KqegP7Rs0Y8TGQNb2xm372OUtXpLgtj5
         U+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775213074; x=1775817874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp7jHdTewElQMOorsvsIFbf0ZsK4yvWuAEvmqGviOTw=;
        b=QrSde0Qyy2crMhwNuV0UyM5NF2K+laqK19P8vdRtxSnrYdoylnSdb11XT5Qd1xq1NS
         BViovsHhjeuNV8NgZtJ/7JxdAsbYnz50pSq5DONhJUhuGxNfXhlJfoaqYRKMC1iG2pzj
         zzlNUQKe7uEkxU8dY+hCiIYwXSBP0ffkR6vnVS7QAs95Vzr+K/B5Jq4gYaQUsKPWd4BI
         93F7NjjtukvPId+qIdOmOJMCBnL9PEjwCVGY2juEETt7gSQlFPCUD5ktn/OQj8M2JU+s
         iP4rZsbJM6Ku24LUYlabXQ05Q3767hEssq/ucGof/t2f+UBmEAL18X8oQ3bPOPTtHGTA
         XGbw==
X-Forwarded-Encrypted: i=1; AJvYcCWSEXjlZn2zE7tDudr+ZFoT4vawszR2EyznXgTl530GJovIdrb2tGP6PX2CWyHhcx5mW/x/XWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0Wpp9gxd47NOY1kKM6QSoGRUcU0thqxyiMDsv565MoXUimdN
	wEaqMG8MXzU3faa7ZPyKIJ67rgZd8VuxcQjnuFp3qUc4NUbKPz6B5svTHBIpXNPIIT2ciSuhVL+
	efd5eTly58Ab6PkG9VsATxAM2jnyEq8JEqnnpfJ2/DGJF7+bnkJgfi0qGA7U=
X-Gm-Gg: AeBDietTnxv+zmg+4kOjwAUUd0KzTC5uufzALPQ13mZp5GPMrt+h/2kmDKvcjX6QaVd
	zUMFue+h626USDEGfjJzJAkdJrwblPqX74y2zFyjRuqdxHgqcySMoBAtpQ3DpLYJdedEoAuBq8X
	8dWvtqMrwYTLqvkpwPHPyXt1GuIjh2m/02o8MCTy4QKkkvy/21U847s/hVgsIo2c9XSrGIWlvN5
	V+xXv3ZN5cNGSmHDFa45XvOoQaLgoJAx97HH0BQmQQVUMej6rpdCYoWY8LqSPOTRpqycO+1mLNj
	KUprvKCkV0V+NsyiHYjk491wQutuj6mYLJhs4jvsXR6ceSHV2Y4/IvwQW1j4wfBjEfKJhnqinc6
	MIiOThKrgi3XVPdYs7S2Ob4agjjY4iKdC/FfvwUpYpLiXAUg1qQ==
X-Received: by 2002:a17:903:3c47:b0:2ae:54b2:27d9 with SMTP id d9443c01a7336-2b2817ea307mr18235135ad.7.1775213073992;
        Fri, 03 Apr 2026 03:44:33 -0700 (PDT)
X-Received: by 2002:a17:903:3c47:b0:2ae:54b2:27d9 with SMTP id d9443c01a7336-2b2817ea307mr18234915ad.7.1775213073561;
        Fri, 03 Apr 2026 03:44:33 -0700 (PDT)
Received: from [10.218.41.33] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d55fsm72340455ad.11.2026.04.03.03.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 03:44:33 -0700 (PDT)
Message-ID: <0f2612b8-5c44-4934-a625-27a66eeb7bdd@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 16:14:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Add monaco-evk-ac support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260401-monaco-evk-ac-sku-v2-0-27b5f702cfba@oss.qualcomm.com>
 <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>
 <7baeajhlqv6ujiqzmknjw3h6qr4mdw6qdywhaczm3c42pzjiue@nsgcbd4jsba5>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <7baeajhlqv6ujiqzmknjw3h6qr4mdw6qdywhaczm3c42pzjiue@nsgcbd4jsba5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aTQ6pcG20DI679yeUMfnMFAHTB8J6gC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA5NSBTYWx0ZWRfX3eolUINRYedW
 Gt9wXfWbzDZeupOt4y47++4ppvj2v8rEd/kAu0eEsPgNqUyggMHzMcvFfJKmUUBauB5JFtaIjtj
 1/GF/EVkK+80XMrfTXxI7P5i7kBmFizLsqHQKxz6xXGR17AvFT8Zr+efo/Dc5DrT6BDMLPLNgPC
 j9majbDaQYQh797VVnEYEYcQTuwuCCcxL0R8/aikkRUyd7vul3vzq8PIJQ+WB7g8Uvpy+2DE8YF
 6DQdzoNdpM+VOAW7JwjlKdXs/lYRCj2hy6MiARRLAlHBYAF9LZKDCYMiXIMcwNHNUXLrZBOi90u
 aEuA6c/WzGvGqkEAA1BTOZiTkQRdJkgt+S09AWeUBiRXC5VWp6f34Q8URmhrqn1iB5b7dmjtzU0
 9a0cMoqocnZBCMyGalVqT7USbfwXh1TPVqcQpwvKnklccX56FEKa2TrxdIPZMrAp71q4cCuIGld
 ifO6VDxP0c90R53Jyxw==
X-Proofpoint-ORIG-GUID: aTQ6pcG20DI679yeUMfnMFAHTB8J6gC0
X-Authority-Analysis: v=2.4 cv=fOo0HJae c=1 sm=1 tr=0 ts=69cf9a12 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JE7w62522NqE47sMXtoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030095
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-274985-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[umang.chheda@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E96139364B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Dmitry,

On 4/1/2026 5:06 PM, Dmitry Baryshkov wrote:
> On Wed, Apr 01, 2026 at 12:14:42AM +0530, Umang Chheda wrote:
>> Introduce bindings for the monaco-evk-ac IoT board, which is
>> based on the monaco-ac (QCS8300-AC) SoC variant.
> 
> If it is a different SoC SKU, should it be reflected in the SoC compat
> strings?

Monaco‑AC does not introduce any S/W differences compared to Monaco SoC
-- All IP blocks and bindings remain identical from S/W PoV, Hence
haven't included the SoC SKU in the SoC compat strings.

Hope this is okay ? Your view on this ?

> 
>>
>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index ca880c105f3b..c76365a89687 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -918,6 +918,7 @@ properties:
>>            - enum:
>>                - arduino,monza
>>                - qcom,monaco-evk
>> +              - qcom,monaco-evk-ac
>>                - qcom,qcs8300-ride
>>            - const: qcom,qcs8300
>>  
>>
>> -- 
>> 2.34.1
>>
> 

Thanks,
Umang

