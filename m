Return-Path: <netdev+bounces-265539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGH5A8zCrmmRIgIAu9opvQ
	(envelope-from <netdev+bounces-265539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:53:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331623936B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64401305CAB6
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E03BA249;
	Mon,  9 Mar 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RR7gO9C1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyfEUEOm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7008332633
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060532; cv=none; b=Enms3u9OUPGf3MCJggVvJ9enLmhWef9h0zo7KJq6m6kmBTWrCQ/ybYEBPqi5Lx7G1AksgONXqtLAQzCpDN6D2b8GuJfq2IBpud6CpzZzJHkH4v3oMYjZtRF4vOccdwbF/vt+cLUfnyH8grHiSnzqqWY6sCOtTdL+QojWReQzPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060532; c=relaxed/simple;
	bh=Y5kd0BpVqlM3kkl09x425U0/UWww+tmz8d+mKoGJP2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWYSOfrv0GZtPpNMF8pe03YQY/A6pGM2bIKjEZ2qDApUTdtl+qyd/lRcaeFHYTfiJAfxjD0j04hRLN7zNg1XI9ETHaSYbs+WNQ477F39EG6drV0wPzSCCGPRN3Klbd7ZSlm+acFTuiybxwAdh/KDH9SGEqAG9ljBrqik/evc3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RR7gO9C1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NyfEUEOm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629BMDno1577725
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 12:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9IvbB7hdB4ddrbj6m6ZCuupWLpqGAij/RgQK3K9jqHU=; b=RR7gO9C1UxWSXaFR
	NAKcDKJQ1KWvHwAQlLb6NXol4BL17Tosfg7DEs5npERBmv1Y7W+8OxKGkr53JPw7
	/4qkMd7doFi1a7QP3q0gvpcMVPRHFbMQui8fqyGqjgZjxsg0k8fbl3FBHE+YkFq6
	AkLhYzgDAKchg2tXXkLPlFE0WbsAgCSC8b+iPp6hCrQfO6kXGYL9fNpOpv1JYAVj
	9fX62gCxcBTkaWtRlhsw3Y6cNYkEaaNmWDt7VLAGcRtbPa/Ovh8vIzcH/EXYc1VD
	huAbErWGJ4C4qUz0NhVDYN9KTpL4oMWEv3Mmavc0cFxxuIm+bnrCeFxkZq8t4ha0
	t93z/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr9qewrh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 12:48:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd8dc8b434so41348585a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773060530; x=1773665330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IvbB7hdB4ddrbj6m6ZCuupWLpqGAij/RgQK3K9jqHU=;
        b=NyfEUEOmpy3jXUsTCZ3QQK+hGtfDmABIC38xYiCyqgVb0SBOgJRiouFj/qTYvBx5q0
         BzML/F+dyOaqPYCjTKXP2uq5qIvqHPEDTp9C53WPSE55QxhlJRL81tJAj38XR7+q5/6o
         FN3MwxH2WMoxwvftmA87e5js9cGNWfPQzAoeirVz7Z4XQJEe60U4zKbVsRK06tAYACgl
         QwZJG0qhmMr7inGnhHgvxvfugqFEIq08hITbBOG5uCuU71GBswJIglysZzxwSXcdIawD
         1szuY5DMQBcmX2j57M642IDS77bz5BJLQ6qAyIyUkJ1rWKpoCalyQDoZlU0/Mi5w8UT8
         f/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060530; x=1773665330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IvbB7hdB4ddrbj6m6ZCuupWLpqGAij/RgQK3K9jqHU=;
        b=ngXWbwvCfmfBVLBGWlJKw2WNDaDUa3iGqTyVleIoR7foOT+T5xnZS8xsneLB01ezUi
         jY+iDKNrcaTAcbM+JM1qGqvvaZOOOFujYg3qXOVEsgI6IPP+wohHgFXhBSLUw6VwXHqE
         31E5ADJ/KKrBo+PbQ9uwYi4DRG1I6F4bfPeA108E4FMs2/YXplD+p6qEpdp9Vw/Gzt+q
         s7sroyQ4wE5+Crv55N99cyvl4QfMe69SdQR5Su72au/D/Ki324y32Zw6xTSVSkWlmHaS
         TRuw29DIiBVY2sxg5ssD4gk1LoQfYDjpDCFOMp0MuXxUFwrA1mC+YtpYttqhJ48lbtU5
         Pazg==
X-Forwarded-Encrypted: i=1; AJvYcCUtmhONGs+LuK966xnS5HigHXBfBCDNwO46rPweLMoxH7kGgntVqUz5+GRXP0QcV9qXgLSKvPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pMj/A5yNKJkoa4/faUgk8PPH1iCnPK9v4ooOdvc78WkayAks
	zyeEUbdUOuzK7nQ4SwKmSHdvJ4355RCMiuI80ssxzXE0FrKxNyRyxnke4dFi6sNf/u+dI6lAokS
	NP/PS4KUKsWL6+M+ioeEAyVHLh7WZb2aqeXVgR/rNGmCNXqFgz4HveNrpPvs=
X-Gm-Gg: ATEYQzwy0miJpNzoRsorRKFAkFefL3RAf11hK5VAQ0uiX9npboRV0+o9NEPuVjDUJO3
	A2CG1sRDasegMiOSiqg6031nMYLkXPLROHCxzKYtIzA11XxLhKuv5sld8ra3rB7crb3yrOCpIZS
	avrWYHpomoWeN51DxIRybsNO7Rn0bAcBiTTlA6k41lypbIX4mNNrqT9MA1Krsy3iqNHLy/pDC09
	jFCN+fgip3K3gqVW+FvixABlSI7CS5GrNVAChv2Q7JiLsHTtRpiBFzw2cKt82fZvLyI9MRKe2C4
	m6okf1hj20pCRZFcnBKmmbnomhHP8aUDnxSsfq95gzxisKGQYGYc3v/HmhDvauk9+H9rzZqVest
	AMuz0+2G28IlW8TGUkO6N/mrJi1LxykvyHIUaYt11WBfgiuYEJi3y1xmSi1ncAYUQOoWmdbwPaD
	7l3F4=
X-Received: by 2002:a05:620a:319d:b0:8b2:fe27:d2ff with SMTP id af79cd13be357-8cd6d464fb0mr1107812385a.8.1773060530102;
        Mon, 09 Mar 2026 05:48:50 -0700 (PDT)
X-Received: by 2002:a05:620a:319d:b0:8b2:fe27:d2ff with SMTP id af79cd13be357-8cd6d464fb0mr1107810485a.8.1773060529690;
        Mon, 09 Mar 2026 05:48:49 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b970e8ac4f1sm2521266b.29.2026.03.09.05.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 05:48:48 -0700 (PDT)
Message-ID: <2d3da923-b39e-4340-97a2-bf93198540a4@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 13:48:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,ipa: document qcm2290
 compatible
To: =?UTF-8?Q?Wojciech_Sle=C5=84ska?= <wojciech.slenska@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20241220073540.37631-1-wojciech.slenska@gmail.com>
 <20241220073540.37631-2-wojciech.slenska@gmail.com>
 <5bba973b-73fd-4e54-a7c9-6166ab7ed1f0@kernel.org>
 <939f55e9-3626-4643-ab3b-53557d1dc5a9@oss.qualcomm.com>
 <CAMYPSMr2JCQCX69PGUk1=7=-YfBcyFDpqQ6tMQzFP040srBA7w@mail.gmail.com>
 <f141a098-efca-46f1-bc1a-433ff03915ca@oss.qualcomm.com>
 <CAMYPSMr=2WUvjh9+ZDRkgqq6B3=MB9xmwp4NkKnWpdnNiNXf6A@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMYPSMr=2WUvjh9+ZDRkgqq6B3=MB9xmwp4NkKnWpdnNiNXf6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pjbmvoYIKnVmrPKe7hPmsioIUnKzRXwH
X-Proofpoint-GUID: pjbmvoYIKnVmrPKe7hPmsioIUnKzRXwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNyBTYWx0ZWRfX2Vbumw9wtr+a
 EkTUMMe546Gg63UEkvPVJofu//guJ1AwjohegCIuaNWdXB3g60LuWMcF5PtjAnsqxPRLjot9oxs
 ND+vMi51OU14boQdre9jjg7fUerm8/+leJxpeOBI+TrkpGx9N6rvOTgA+EfA4pH6dJVNAYt5/K9
 FpWWdLTAqmpQLI12QO40JHK3OxD3ta/YECk9TEzY0SCbNZVPWTnwxnTYgtjl940RKSVuoJalG9e
 9kSNtByU42CQSo+j8NcHxeQfXTbAHhVP2pko0CCvzDAgGzowORwOzE5AQRKn4w4HPWFri2oZyA8
 /T/CKv2wCi59rxlbZMAROGAtdJh4f0FEyr+MDnZgM8CCnVkQU/KDs79KmJ25yawQq3qGDFb4PyA
 pu2XGsClEyLWEToagVuBEefdA2dGWMnGP5yZWqBm0z6VMOolLlxjQyYKUoPxwOlBFa6DBXGSrHc
 Vi0J9B1IyCfHchcBWWg==
X-Authority-Analysis: v=2.4 cv=dcqNHHXe c=1 sm=1 tr=0 ts=69aec1b3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KTMdOuuZfjdGBI-URmYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090117
X-Rspamd-Queue-Id: 8331623936B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265539-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/5/26 1:57 PM, Wojciech Sleńska wrote:
> czw., 5 mar 2026 o 11:54 Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> napisał(a):
>>
>> On 5/26/25 9:39 PM, Wojciech Sleńska wrote:
>>> pt., 23 maj 2025 o 01:30 Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> napisał(a):
>>>>
>>>> On 12/21/24 9:44 PM, Krzysztof Kozlowski wrote:
>>>>> On 20/12/2024 08:35, Wojciech Slenska wrote:
>>>>>> Document that ipa on qcm2290 uses version 4.2, the same
>>>>>> as sc7180.
>>>>>>
>>>>>> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
>>>>>> ---
>>
>> [...]
>>
>>> Once your changes have been integrated, I will resubmit my patches.
>>
>> That has now finally happened!
>>
>> Konrad
> 
> Nice, almost there :)
> Please also submit this one:
> https://github.com/quic-kdybcio/linux/commit/cc20384c4484507fbd18b8a01c79b5e7f5b6cf8a
> 
> With this small correction.
> +                       reg = <0 0x0c100000 0 0x2a000>;
> +                       ranges = <0 0 0x0c100000 0x2a000>;

This seems to already be there, char-for-char in the commit you linked
- did you intend to highlight something else?

Konrad

