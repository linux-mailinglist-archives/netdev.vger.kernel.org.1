Return-Path: <netdev+bounces-275355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBNBNPHr0GnCCAcAu9opvQ
	(envelope-from <netdev+bounces-275355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:46:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D348E39AD08
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0E7D3004072
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F41DDA18;
	Sat,  4 Apr 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYkj0Mv3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Arf8g6gg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07940DFCC
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299563; cv=none; b=FWPIVy9evwbE8aJrYmU8vb2Cs6EKdhagqreYnU8dXFwvTy2O8Wu4949KCvU08k+4+wTC/ZYlYVuoS54zVcdTRgLU6lQq1gL2lVtdFHvapzFcueQWCcGx0tKbTBOtj+5NFBzAJa5oocOL+0vZ8lAoyDJnIoygbXH/U/mTraaZ5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299563; c=relaxed/simple;
	bh=aYrePvcUXovVni1iKaDN/7closkAZNMqTpAbBEJxOfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eW7azpFk0cB0FvauFs4nUdDo3taLgzzOvUx1U2jvRh7SakawuLVaWAiNC4dGjfac60/W5DQqMG8Xqp0fvVz9C+3Kn0e9AB+0TcEeviK63+lRvtsTMsEi7iMLPwmtmmB/ZLiAxK9fyexNm1khwbJIbKz7s2c4EkrlhrTPCEQFFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYkj0Mv3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Arf8g6gg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344lrm0919994
	for <netdev@vger.kernel.org>; Sat, 4 Apr 2026 10:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nrB6L8Mc+M9ITuIoXIfhrZ7HpsY2bfsSBniy3AVQwQ=; b=TYkj0Mv3Nqq5yWGN
	e95H09u1INlnEd9yrD4q/HCLS7fC+ct2jX2gEO5mwHzpqrlOTZGX9pAA+KwP54M6
	KRbZbF0foqQOe1nDE4xRp4ZNA60hYCr7jSoNMvfzgMVmVNRwThV9FnywZMLS1DdL
	Xfz3t8z3m3Uy/XuVjPBuHTMNurBf+0Qbl89gwtzHES+z7X2+imNyEp5pyOF7Ygag
	rXFX2X9lwcrHs/OAszZ4i/PhXj6tIOiHlGh1EcxPfeBze+DgTIVBzq6/RhZ3lS6d
	V0Zjwkhan7QBVfmnWvzHn4QS9Vf61l8P0bjcHUmU649kNgEQHjAZcAqqr8mz7PN9
	TVNjFg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daux88hyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 10:46:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ab03332dadso7032365ad.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775299560; x=1775904360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nrB6L8Mc+M9ITuIoXIfhrZ7HpsY2bfsSBniy3AVQwQ=;
        b=Arf8g6ggki60AiFhi2ATRojuIERmS3eBn/Jmq9Gb4GThKDAq1EK8gKXxfOsn6ku29M
         9DuDwjSIoaRbhhX8VlTBbPVtYoidXNZp2Ab47XPHMUp/OudMldwnWjdBQbhMazKq2XEK
         MOOkawA2vndSh1Vr9wgk5bvwKNqvV5fp2MTym1lUyYk1RZVpd/Ik+gCYD0Bn+RqZBBPi
         NOV6e1FSqIK28xelz1KF3kJxP2k4A/9T+mrbMqdTcgnsELlbd6G3PpUVblZYCenEssr3
         zNwdaUy4NFkxQbkT2XcIU2mG/H/Y+7kte5VOK8G+6aqbPV1FDad3n80Q94huYcnpgy4z
         DlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775299560; x=1775904360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nrB6L8Mc+M9ITuIoXIfhrZ7HpsY2bfsSBniy3AVQwQ=;
        b=V/w12je2CnOe3+C2nrWAFgHN9mr+Fc1zyd9gFXvHJ0vkeyApWqSdupkC3moA7sBu1J
         Ij+0erSM6ZEt9MkKNVyJe9rqIz/lH7enX/hoDCe4cs2l2Ln5xoBRRCB5O2g5SugRYALQ
         Av2peZFaqV+OR9sDMhhuS6v8u2oJ8HUSZoBVO73GR/+rWSlVnQTP+artOccNdplZ3RHV
         f7KSqXqh7nE7hW+KOEz7NyUZVjHAmxcQXlOVwq32ojEisOCel68C8FTgJT6d20+G7Lbv
         WvuAZd+UYDbtmiLIad9eQ/SgYuL8nmLf9I+8aSWEe8kCx8Ydg01JHZkVtVdesO7LpZKL
         6S2A==
X-Forwarded-Encrypted: i=1; AJvYcCUoVaRMxa8D4uaKLc2By7mYgf/2NGEP33qzI6kAE5CYEpkDLSrtADiJC/ZhmRJjmCa7j/dV2X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HmkqXq2bDD0YxVvTgaZDe8DypuSErOsEhilPI85OTpDqxJvt
	P7DKLxicBJOZnlP6Y+szlI+f7f9/Ry79K5Ieq6GG1/Fd+gw+oHV0ct7WwEUATBKT/g5O740aJh9
	6gYiCgoV0dsSF7zVw/NL1916jGPXWNZXBwboXux+Klmt1h5fNDQGT79IXkgU=
X-Gm-Gg: AeBDieuIT5Dyw9KEUKSKEYct6078gXh8vilZPFwdWCyzVmEGMji80rv264aQ+6EilZT
	MKevlmmrvDcJajN4BW5Yo7vnYCiWWzMFCqelzBT+i2IKiA6g6k7FIZBsPdj1rnDZKu1DBq6D0pk
	sq9q9iYzRb7bCVGccuw+dunr1kNTxoumD1sT7DNzmxQOeR1NcCdzh2PWSNGaPwpJ4ap3vle2ksA
	mA/uPKLVt1cHmV++ZlRdeL1QDW/vBwrP9ZJuNMZcDUG24HR8JWNkG4j7Hr03nGmbp/ncwSRrUJO
	EKroOvDiRe/aQRP//SeVF7dk8lsfbVWDJ5Dn2y38kUKhWeYoIofXnF3RWaD2oObSNXDr/zueso4
	884bkh7DWN5xT+p/YZFEJkR2tebpQlR/HwpOaZgZFh5vCcZZGuA==
X-Received: by 2002:a17:902:da2d:b0:2b2:67ca:5ffa with SMTP id d9443c01a7336-2b2815d8057mr36572355ad.0.1775299560364;
        Sat, 04 Apr 2026 03:46:00 -0700 (PDT)
X-Received: by 2002:a17:902:da2d:b0:2b2:67ca:5ffa with SMTP id d9443c01a7336-2b2815d8057mr36572185ad.0.1775299559862;
        Sat, 04 Apr 2026 03:45:59 -0700 (PDT)
Received: from [10.218.41.33] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d20bsm83780095ad.16.2026.04.04.03.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 03:45:59 -0700 (PDT)
Message-ID: <4d32e86f-353c-4951-89ca-46aa49d60f76@oss.qualcomm.com>
Date: Sat, 4 Apr 2026 16:15:54 +0530
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
 <0f2612b8-5c44-4934-a625-27a66eeb7bdd@oss.qualcomm.com>
 <zyarcaimg67uivssnm4uxqiwc2jadolf5kx6moycwlbzhg4gmv@xa75wcpotzpr>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <zyarcaimg67uivssnm4uxqiwc2jadolf5kx6moycwlbzhg4gmv@xa75wcpotzpr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1cgndyRHFnn62n_cYjpKwpwclWfi__NW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA5OCBTYWx0ZWRfX/xvNQ08lsQOb
 oxYGdwAc2k28uGTZMCyPUgG1Mxs3fQYgguVNzoYNRoRlcV7pSTW9ngz7VVt2Ah6e9flt6m33OLb
 etTyJRWRGhg9BqyWdPneqJR1VeKi2Pp2RDR/sKgFliUlOUHmF0K19r+lUUReRbI+Okt0VzuPFBl
 Mix71m4zDsX6jDYzTyvy0xecQXrE4Napl+VuEm2BRE/ju3mKyHmVKKOG0uHlyvqkFxgtkgFYLFD
 LWBgDbt3ATlaeBdJ9u0N2JPcBIiKgYSvcUmSEXPu/z7JrnbrY6e5mbIgk7KMkDGDXUY7bZ1imoV
 4+ptFPaC66z302TPgu9i/ndXNpJccTFCP97bZzSDs2dt7JcnXcjZHcznIoPxOyEmTFJNtmcVmPl
 UPKQkEk44zyM2YjCpc6EOmumdTpyFtxqgO87H1EnizywT/wuaa45eB1cU3e7DzpIVuNmS5e4Cwe
 k3uYNb+hWS4/SHp3seA==
X-Proofpoint-GUID: 1cgndyRHFnn62n_cYjpKwpwclWfi__NW
X-Authority-Analysis: v=2.4 cv=AuzjHe9P c=1 sm=1 tr=0 ts=69d0ebe9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=tEkBMu-lKGZmCQ_eyYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-275355-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[umang.chheda@oss.qualcomm.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D348E39AD08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/4/2026 1:58 AM, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 04:14:28PM +0530, Umang Chheda wrote:
>> Hello Dmitry,
>>
>> On 4/1/2026 5:06 PM, Dmitry Baryshkov wrote:
>>> On Wed, Apr 01, 2026 at 12:14:42AM +0530, Umang Chheda wrote:
>>>> Introduce bindings for the monaco-evk-ac IoT board, which is
>>>> based on the monaco-ac (QCS8300-AC) SoC variant.
>>>
>>> If it is a different SoC SKU, should it be reflected in the SoC compat
>>> strings?
>>
>> Monaco‑AC does not introduce any S/W differences compared to Monaco SoC
>> -- All IP blocks and bindings remain identical from S/W PoV, Hence
>> haven't included the SoC SKU in the SoC compat strings.
>>
>> Hope this is okay ? Your view on this ?
> 
> You are descibing -AC as the main difference between the kits, but then
> you say that -AC doesn't bring new software interfaces. What is the
> difference then between monako-evk and the -ac variant?
> 

The major difference between monaco-evk and monaco-ac-evk boards is that
of power grid. monaco-evk requires 4 PMICs (2x PM8650AU + Maxim MAX20018
+ TI TPS6594) to support higher power requirements of monaco-AA variant
of SoC which supports upto 40 TOPS of NPU - whereas this board
"monaco-ac-evk" supports 20 TOPS of NPU and has lesser power
requirements hence 2 PMICs suffice the power requirements (2x PM8650AU).


> Also, from the naming point of view, it is monako-ac-evk, not the other
> way.

Ack, will change this to "monaco-ac-evk" in the next version.

Also, should I change DT name "monaco-ac-sku.dts" instead of current
"monaco-evk-ac-sku" ?

> 
>>
>>>
>>>>
>>>> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index ca880c105f3b..c76365a89687 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -918,6 +918,7 @@ properties:
>>>>            - enum:
>>>>                - arduino,monza
>>>>                - qcom,monaco-evk
>>>> +              - qcom,monaco-evk-ac
>>>>                - qcom,qcs8300-ride
>>>>            - const: qcom,qcs8300
>>>>  
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
>> Thanks,
>> Umang
> 

Thanks,
Umang



