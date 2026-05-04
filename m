Return-Path: <netdev+bounces-283727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBVUEKVP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:49:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED04B9A1B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A35301E6D9
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572C30FF2A;
	Mon,  4 May 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfGwnj5P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JhvaUY4M"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDE30F52B
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880746; cv=none; b=kDE3bEUcDvwZfv1eDal3JYO1dYxJsyQs9UtL8ncsIdgkjP4Yc+GqpGBjjwHfuWHsvS6itjAE1xIcK6r2WairhDp9q2kNCwo74WBKyFBr0UU85X5TQvbejp8Gec8ysjlUd7IIobIF6Ehidqv7SyESdHB+MRQqSGWesFQVKTEcSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880746; c=relaxed/simple;
	bh=/NX+up7++QBsfX+DKkSvYEgv8gH3v/yxVfCr6DOJpno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGZYcUL9mN+lnnq/sz/YXW4kzhOIennnBPAsxYPoeOmUBBywaTpg/H5GRgXfiqFrlHbVR6FMzJzc5+XemLLTwDp3XaUic0+UGBtxjMmpr9phCyG1YWGcuLYW8pDqUNFlOKnYkuUMl1110DZUyaY1ag3GvbfNCyAMUFu9o+hgJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kfGwnj5P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JhvaUY4M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DTSt3505366
	for <netdev@vger.kernel.org>; Mon, 4 May 2026 07:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2FEhjnVz8B3YbTK0kWp6u8teq7DGCVzqV0sQmkfjGa0=; b=kfGwnj5PujYZ3NxA
	XVs9AaHavli2R/NrFOAeups3Ah/W9UJhAQnunglsHgdt78u4aCTIEiXgoiN5IMs/
	4xVBz/psEr+cLbsp+hF3cxSkb0C+VdO0x8wD1PutYG9vmNpM7Xns32ODjaLNbNq0
	IGUNkXgG6Z1OuoS5Jnnxq4oJqyN1mqndUAmFgSDRXEosdcehmtLQMebQTR1YF2nr
	GG9PF79Wd3QkfiaHAcjs9lenN3vcKdPQzXD0/rUI+le8+TYsKKDpLS4vw/vjQqoq
	9wDSmu5fK0uKqaZsRsyu80g6UrjRNeC8ZxpkGMkFcWb3w2PRocmgjljMxVdDTj60
	gHzRPg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw6yfd3ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:45:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f9429f49cso4869340b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777880744; x=1778485544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FEhjnVz8B3YbTK0kWp6u8teq7DGCVzqV0sQmkfjGa0=;
        b=JhvaUY4MH5Ful8gNW90AIExiEZwIhKxj7l8bsH3e3e50nNyTVIIfWLx3MJeuo2Zy2E
         AmSpi0lwQOd2mJQzMa+VkXXhOIz+J5ANDHJl0WqM0JjiWEUsY/rmBdV8RK3PADl6S/qD
         cpEPW7Zbbju/6P+N5Hy+pQB1CCuFCdCJ5Z8A0vKDABFIU6orof/mKCR80sqgLv9Uup/x
         GieDmaRO3z/qeiV6Q7pW9jJRmlpQdqrtjrW7qJsPIU4jT0rOPs+AE1yqC+rGvcBz6vbX
         eWq6fIOmuJd6pD1RhAFq5jeNBZwFHniERg+ZguY8G3uoPmliyCwWEqCOqwJlS77COCAF
         2leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880744; x=1778485544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FEhjnVz8B3YbTK0kWp6u8teq7DGCVzqV0sQmkfjGa0=;
        b=NCSvoq+azHpkbqBPBVjhBeYLV+D41UhbWVvNWPE15krdZK1UuR+LE0tJH2AqQc8umy
         kwckisbs4IX609itGZR/gQm7l1NZOR+DCl6Z58cqfgF2gW+fq7xgEA++0Uv7xYBYlgdO
         f/PffNCZkPW18YCki2xDAJNW2VAxoe6xvkwOBoktUHBspH2qSj18MesBkcMBgp/15CsS
         0yMjZZwn5Mmk2MyICbs8QZeBmOzb6SPR0gdotcRyHJRkVqiW4qSS0OZ/oHmMWLfuNfDl
         sg1Zfvue9n6kuij7mxzp3Bp3bk4BBWkaiwi1Zs6TkgmCqpc3XllYaJ1GL7wDFE11OsTC
         eWJg==
X-Forwarded-Encrypted: i=1; AFNElJ/j1fXi49W6zRD2/qGEQxvMZ3nBpP1rWvVH25WUo5aM2m8jBsLdYhV8cx2fisBKtzHiHMLzqUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc19/d+4sRD2lrI3MOJy0U4p23rt4IVu0bmAPhcLPqudRfGG9H
	fEYLWijvuBhPtGLRPKy5cwgPVNm0CxNUEYVlgy7ii6EOlL6fXk02kEUMV7FsIl3x1vgGjsdfOuh
	z2vukQO4A3Xb/Gvrz427vlBoU3UfBrZu1slqP717s5XprzcouoWkCQqS8wUk=
X-Gm-Gg: AeBDietv1S6KHqljYt/pXJ+V7VrbpL6M+3FNpiFiRq9Oq4rtqhan6ebo5QUUBd13+dW
	3rabwSCKUsLgnthXRtlhuNW9r03Z2XAPYeL2/3TfHUrq7+wHB+9s3hEbqF6dusNOkhI3HOscSNv
	ZaooEnHuaXD7GZNLsOEJ33e1c99dIa/Ee120zac0313ygQd9taoxwk4ko/5WDemrOC9V29blR5j
	zgLM5WRVIHJQ6/gOevoKaOhF+P+f+V/WGuIMmQY9l7/ziPv74lVVGt6ZWB5zz8VhMQVSdL+RAxK
	KgNop1d8BnkU+A724mWO+yt1G8kLokUOcv9KSB3jMQ7YEZA7Wt3Gs2J2797G/VftzQ0XP4tiIFj
	3rJ3zFVFdz+ews1YRyTOnPwws0/mDW2dq24HBpIN5Upbi2j+c20wkJnTL6DQ=
X-Received: by 2002:a05:6a00:369b:b0:834:df57:9d6b with SMTP id d2e1a72fcca58-8352d28bc1fmr8161743b3a.24.1777880743569;
        Mon, 04 May 2026 00:45:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:369b:b0:834:df57:9d6b with SMTP id d2e1a72fcca58-8352d28bc1fmr8161727b3a.24.1777880743078;
        Mon, 04 May 2026 00:45:43 -0700 (PDT)
Received: from [192.168.1.143] ([59.96.95.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b543b0sm10299368b3a.53.2026.05.04.00.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:45:42 -0700 (PDT)
Message-ID: <82bf6986-f3c9-487e-89cc-366bdf92022d@oss.qualcomm.com>
Date: Mon, 4 May 2026 13:15:36 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Document Shikra Top Level
 Mode Multiplexer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com>
 <20260429-shikra-pinctrl-v1-1-1b4bb2b3a8d6@oss.qualcomm.com>
 <20260430-esoteric-badger-from-hyperborea-1049ef@quoll>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260430-esoteric-badger-from-hyperborea-1049ef@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XsHG6gtZXGeDYojfVOTlnXt5AxRmfCfu
X-Proofpoint-GUID: XsHG6gtZXGeDYojfVOTlnXt5AxRmfCfu
X-Authority-Analysis: v=2.4 cv=QY5WeMbv c=1 sm=1 tr=0 ts=69f84ea8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=d18XUvOkrfNYrh/LwM53Ig==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=2V555Vb6lIzm2OLpEQsA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4MyBTYWx0ZWRfX3utzDpQV7Lw9
 zqvuCy0wQktg/PUZnSFsxbKllFjiSVQomw08tNZRTFPKZdAOmMD/2XvAgqTky0Ave9klu8SWsgT
 99Lc/HkMWNwC00V3G/ol/J6veqVgK26vcQLyU4eAFf6Ur310BBRajJ0JeE2dGYCtBMeSa3lj7Ti
 hdxQ7lKhV3IDURpWPKwosUwdd8HZoxLh/9rfiDdTmxnnIHw8UrwYxyL4UCMk0r6AwbCDPbJqQsl
 7nworJIzzIzQVsYAi/wV/PmanEBLQUdWu8RiSTUGnHjntv1MBxUvgtEtrzqWMkEC8ftNz0F9QgV
 Ub5qpnrKd18TrpCiNntsk8EUW2ixN1KRtWgsRC9R4uv8K0lrU+itjStFv5BnB3wXX9oN69ZellW
 DTXYnAG8rPXyyAnFrvMW7eHHbb2pZZR0ffhaRvnZbHpKtxO9EYZpJvn54t2R+Klflitj1/9C8FK
 pyWFAhZ33D6P1g80wcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040083
X-Rspamd-Queue-Id: D6ED04B9A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283727-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/30/2026 3:42 PM, Krzysztof Kozlowski wrote:
> On Wed, Apr 29, 2026 at 06:41:56PM +0530, Komal Bajaj wrote:
>> +properties:
>> +  compatible:
>> +    const: qcom,shikra-tlmm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 83
>> +
>> +  gpio-line-names:
>> +    maxItems: 165
> Further pattern said you have 166 GPIOs.

Thanks Krzysztof, you are right, it should be 166. I will fix it in the 
next revision.

Komal

>
> Best regards,
> Krzysztof
>


