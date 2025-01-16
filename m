Return-Path: <netdev+bounces-158929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5A5A13D51
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12E11674C6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E0322B590;
	Thu, 16 Jan 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n0efISJt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0E22A7EA;
	Thu, 16 Jan 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040261; cv=none; b=eVf9E9KHFWzzNSRoLJ8P82qrhpD2qXMGtnIHUEwkV/d0ZRq3pWwX9+CydeGglxzbkRFIgFWUKX36DabGC2urB8w1NwSjNIgYyQvZZs39nlDScApLAi5Lh5bJHbGkc5VQwZLPii2NU4M0dEj0bC3rFjsXYlFpGYFdUAbcjFEUTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040261; c=relaxed/simple;
	bh=9kMsm7jJrAx1IN2gYEC8j2oi13whyI4ysY2MoDYfRaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueLYPik5lDfaAKsRNpqXcyPYwe3KG4UY5p4CPFHmFjsq/SrYr2mDzA6VzGdTQISogqUL+aXYyco75ejAB53omVr9BV8tMlwjNgBEAyOu3V9Hzaysr1MsrIYYIiWFuuKZMeU8kXMpcyYGh6Gid7QqOyo1eOIjOKlHOMYTC1xnIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n0efISJt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDcZFT005641;
	Thu, 16 Jan 2025 15:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9kMsm7
	jJrAx1IN2gYEC8j2oi13whyI4ysY2MoDYfRaw=; b=n0efISJtYoPTmwZACD9/JJ
	XR81H59ZXaOeB7D2dq086jXjSvKCxh9hP/TFVOnwxlEbQsW7CHOpMvtOzcVHauv7
	jFhouCJKKMDGucfkTuOeZERwV3IKAqvdy/Rraw8JYwg02apXtvsLP655zsCxLkAX
	22ee1523s/7IDZrB7UOOsR0D8vMV0bdCd80YBqnsQIbCrbHK/4WUt8V72eLmGTya
	v05WwLOmklixfCXLaRWxPwFjR1BqvGyefx8zVF8CmPFuGLmmUXfRW0dcsrEly1hW
	j4HphjMFuzUAWs3oXxVE3rEMJH+m717ZPb1PqnBazJrZXf0gV9o1MPogpQlT89tw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkck4b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:10:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GExBFG017832;
	Thu, 16 Jan 2025 15:10:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkck4av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:10:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDCw1w007994;
	Thu, 16 Jan 2025 15:10:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yned0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:10:14 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GFADIJ21299764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:10:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E665B58054;
	Thu, 16 Jan 2025 15:10:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A815803F;
	Thu, 16 Jan 2025 15:10:11 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 15:10:11 +0000 (GMT)
Message-ID: <8a9724b0-440f-4647-9505-058717f7ee07@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:10:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250115142457.GA3859772-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TC-QwuyWLELS3rwujChq29wvqC7RmVnh
X-Proofpoint-GUID: vg3ZPGERppcMA5dqf5ZuhwOkDOxlsLVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=717 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160114

Hi Rob,

On 1/15/25 08:24, Rob Herring wrote:
>
> I was about to say that, but this matches what gpio-hog.yaml defines.
> Why we did both, I don't remember. We could probably eliminate
> 'hog-[0-9]+' as that doesn't appear to be used much.
>
> Long term, I want to make all gpio controllers reference a gpio
> controller schema and put the hog stuff there. Then we have the node
> names defined in 1 place.

Ok, choosing suffix.

Thanks for the review.

Regards,

Ninad



