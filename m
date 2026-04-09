Return-Path: <netdev+bounces-276886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OmMBaRh12l6NQgAu9opvQ
	(envelope-from <netdev+bounces-276886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D23C7B2F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87D06302AC0F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F63A5428;
	Thu,  9 Apr 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7Nr9jCU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RonBwuNu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBE35B632
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722644; cv=none; b=q8RNXjxgJxL3sPahSKB1El7NmzqvMcPKV6XZKDpPT7G1TdmdiZ57c8oxQdZspaz4fhUpvu2blG5Wt3g3DE960I5NKa0Uy2GayFjcbxjnBP+s/8zmdESNuNr9ImoJEViyG9ZLbSeeF8qlNUXbAhlXFd79lYIo7ivIS/bcbixZJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722644; c=relaxed/simple;
	bh=totwhvENBNF8lsaeZIFlYkhK0o3Zzv788+2z2zVDsxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZktf4ZGYIlG/vp4mgTnvTRYtoQuUr+iEaqyWgaNN+rWUWQ/9YHXVmRRdX1lXRmAfesV27m77xwgR7Xzca8TUmMxSOzIb7v/6eQImubqGqDWraQHDSXq0++WevFx4iLhIl4jmOKx1p/vpSElScJadTFtD/lL4wYRi6DdQG+z1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7Nr9jCU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RonBwuNu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6397AcLB674213
	for <netdev@vger.kernel.org>; Thu, 9 Apr 2026 08:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BxSRWVJFhTfuq67blrqNau+EN28Vfo5z6oDilIcjPXw=; b=Q7Nr9jCUxLE1/9Cv
	8+8t5mFirrIPGARD34c7q7wvTtvoBuqgUeJJhhdHu5wlwzy14r4QUl/Rc68bLO7/
	oLnkT9imU2Nvh/WXejsNrbqxNxbHbq/a2wZ96hW16aH9RVF1uedupq4Pu02YdL+N
	18B1iNfogLMTijIRHVHxNcZgYKGGP1LQ9MyPapQofNhojAQtK986UBfDk2PT6XEZ
	LdVG85U8kbp/kuvLAq5KihkTX2FDLcc0Tkb/KIbeAI7BgQLZdZsq5yzMAFrvTS9D
	l5OwFyMZEasRgx97wjZQC4LCvzO4+bJLiFfHYI+hHjcapEwXimBUM1prHU5ku60h
	UouXIg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtbmu3ta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:17:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a016b99579so2913646d6.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775722640; x=1776327440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxSRWVJFhTfuq67blrqNau+EN28Vfo5z6oDilIcjPXw=;
        b=RonBwuNuQbAlfSaTsVsn3q++8CRlamQciXuAZ2S++vQmsusAjRIvrqsQItszdAeiny
         vo73vMupaMGG3seng/wZKSovvvxQfa0c2BRRISrAYNpKyjkovK9DTcCJE+HkdTo4XeGk
         2QR8nKZxIB3oyxnW9kGDYwIYN8QSGjBmZSKhpzLPxrR1HiL3ccWFIt3+TK9M3PuGozHg
         sOBcUy2huipm6jgbUwn6YpDA8xYE+pPE7EiqGK6T1Hy4uhTyoid2aOFS0qnlaoFXgb3Q
         Afclo2QRmyaB2UB7QbPVtKw76MQ9RuJXTB7NA1c0ui9+/9XLsxTWRVHYjf7VH9k3eEVJ
         fCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722640; x=1776327440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxSRWVJFhTfuq67blrqNau+EN28Vfo5z6oDilIcjPXw=;
        b=gAAIioUi+lLcMKbLhLJcRlOgykI/xxd0se/2JuG4kWsix6j89dw1QuMqtmOV+8ot1y
         7/imYFS/T0BEsiG+g/ZBVIxtRS9GqfyIZqoCIZjhrXTw98Oc3I2VXA2Z/JJ6tuopfwuJ
         SOQQ+8Pf4XDXZRyjBjNH+ANq/ZP3g9h2zvCH/Th9B8rmJIlCZDjbiPJdj4DtyovRhpjo
         PAY8PMSRDFtjdvFQPWyXifRNoPgdrCkY5mS6mYYSZr4SbsJ53E1HwnfE8Prb+NNdS1yl
         mo4XkW620z7jgfPgwt4ci2wCkfRUG0W9UAnb+5Xq3pQARsJOJ/tkoahL8k5VQJhe+MpX
         e2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUgoAWABegZWlmw6nkahv51FWpnjcIoWslw2U1Vay+XmRl87oea5LpFe/B/HMQZiKRKdvwXPF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkcoImpEuApq1WRJTVTHTDNIc4dMHmYVn9UdYjwsD5zN0S448
	Y4aNB4iLu9AK/GzQ0AJrQ2RgBi4g6kBlPHtfh4bGke5JrNLrHGoXI9q5lDl43Wv2pAQq9f3D122
	iZgOQLnMFMZomBMgo5Er7QQPsNbIo1WSJrQjNpk97Bing7qQJhjGfV+0brho=
X-Gm-Gg: AeBDievHx3S2M1in+ct1z1kKfMSh1d1L5CY2N9NPqA1mhbYSrI2f4Fk5AjAQn1d9dYI
	N03JfBeH+0+BuCpWEzet5MHoI+cehbgK3cLFci1NwzmB+9N+9LiluMkuixj9AJxs961buGGzsJl
	zsY2iXsdnE8eh8YFGocvKiuWpKXcTX6FLein+4gbQoWcz6sayZ9rDFCKvMnC825i0uT+EkS2ZZc
	Buzdt7IlYatiKJqRflYRA4mnlUFKsIzINKElUpsNtjVHKYor8J5n+/9FH8GKQMGQs91Iw5ulRvL
	BChFZ+p1BMo9n3x9Sl+94KlHaaYowvqoNbYipwQ2bJzdJC7HAsevawFTOAtiNiy8oar2j0RvZi8
	gb+PI7swMU1+k3mEBrdzdxRmsCE299OxeY6wgu9zsEql0T27hDugnM6p0h+blNxpuTv35jmVcbI
	HX1w0=
X-Received: by 2002:ad4:4eaa:0:b0:89a:732e:f805 with SMTP id 6a1803df08f44-8ac640bdf61mr79343636d6.7.1775722640109;
        Thu, 09 Apr 2026 01:17:20 -0700 (PDT)
X-Received: by 2002:ad4:4eaa:0:b0:89a:732e:f805 with SMTP id 6a1803df08f44-8ac640bdf61mr79343426d6.7.1775722639737;
        Thu, 09 Apr 2026 01:17:19 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99fc09sm721173566b.17.2026.04.09.01.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:17:18 -0700 (PDT)
Message-ID: <4c5a5f3d-c1c9-4b49-a045-3c2994adefc5@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 10:17:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
 <20260409-ipa-fixes-v1-1-a817c30678ac@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260409-ipa-fixes-v1-1-a817c30678ac@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: taz6kyDjqjetc51xfPuWyRgr1Df51pmj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3MiBTYWx0ZWRfX8RmDF7yw2Zim
 fDqkU5zb2Sz6srkmapwxmwcxo4S5JH4sHpgjH7I4pobtLq/aS+vBij1BcaSFXx00eIkb9AENwR9
 fmNVDODThXcxJx6WXlEwqfXmLCtdfLTafpLLgL+u8dEHbqYBQ/TCAdb9D8ny5ro0Mxyzz4QfepA
 d9gV3qeGrzZ1wA/fDFaTDq5+lyyMGn6cfS7iXsZ2+TWUAdA5SkgDKAgN7hteIvUvsLQIYWnWiJ6
 4D/wkEmjzaSbzZAo1sqpxdIwB29E3xhLfWgI+VCiITCjpWrvH9epIpfnAu/F/eEtYB5ZQyetBGn
 SIXL2LMYWHBi5HKG569kvStWycWzbNAInBuw8g1Jz+8nbSZwAYjrZLKu6MNO3yfXXhPJ5lY6/+Q
 mtmojZXLl2CZHMEYqBGICEiW7SkkHBSS8yeHqcyLB4CFVQ634v9u7C2rqOHNGKMRVZfEM+H5+MB
 HuALEZKHHhqyXJ8+Bvg==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69d76090 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=3mzYr_IWz7iMthFhtCsA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: taz6kyDjqjetc51xfPuWyRgr1Df51pmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090072
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276886-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,sashiko.dev:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A67D23C7B2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 10:13 AM, Luca Weiss wrote:
> The 'val' variable gets overwritten multiple times, discarding previous
> values. Looking at the git log shows these should be combined with |=
> instead.
> 
> Fixes: 9265a4f0f0b4 ("net: ipa: define even more IPA register fields")
> Link: https://sashiko.dev/#/patchset/20260403-milos-ipa-v1-0-01e9e4e03d3e%40fairphone.com?part=4
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Ha, nice!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

