Return-Path: <netdev+bounces-162709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C2A27B77
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3C1617C3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDFF218ABD;
	Tue,  4 Feb 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PwrUb4y3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BB2163BA;
	Tue,  4 Feb 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698042; cv=none; b=pZ5Pz8sCM5okbRlSNDyos6Z4OoinrT5jxRfaBQrzhqxRf0GLUNLySapUzXXyCdxqvvPxArvSHIeVS1aV80PrAw1KIkmt2r648xI+sjpvm1pw00tPgCZ5E28i6iMDXnlRK0aDAi7cU6SYIS4HqeEw9SY1TX5wYuyafsihFocXWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698042; c=relaxed/simple;
	bh=935j198xxMOYZli3ZMj/non5C9e9cHIycLV8pKfOP8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VOzzCh1NIECVCtti1Zz/tmKBWi9eVPEiYMn7kGoVYt1nwKjbJF38T+s+zmv4VnVIyjaq35GcM+QRscZJTJAPXYlUoK2V30J40brKjYdROlcDH8mTXQ9mLdjYHoUxZFncVVZp54TEOyxK1sR1qMMW7SptQ+gllPXKWQz2//FXd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PwrUb4y3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEoDk029325;
	Tue, 4 Feb 2025 19:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L0+ep8
	JKH1qnWrvTGJ8l/LlGnrRt9fPRrJ/gx5Vk9ZE=; b=PwrUb4y3MmwnbtPg+ZzKUr
	+/8JqqtwjhhBk3mEKl0dmG8JHNmk3j4mjOgFhiCoGSqB0BSDM4zUnZoxqSPOcPiw
	8nlNFh+GDjKEKMBusvQZrDCYKzDHGh2Ylq2nC6ymV35pBYeDbCsjYmjNnsF6MELa
	2hmKFbN9QHOBSsfmbC5S6edM+YStnJyPAvtle8tg9x2Eq1P3mRTZx3rjaoVi1lb0
	gvIjQwtdwjSOSLRTP/su3jjdBeRFZspIag88OXEd4a+4vXh29uKJPoVZn8vUkDu2
	O6e9xEbDnatuWQ6ZACzjkrw6DWqrk//B9eIKZGooug3jErrfn754cG7JZ7uIOusQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k8y9n2fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:40:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 514JRPbB010902;
	Tue, 4 Feb 2025 19:40:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k8y9n2ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:40:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514JXoDo024540;
	Tue, 4 Feb 2025 19:40:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn55q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 19:40:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514Je4OI26739230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 19:40:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D765F58054;
	Tue,  4 Feb 2025 19:40:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E905805F;
	Tue,  4 Feb 2025 19:40:02 +0000 (GMT)
Received: from [9.67.69.251] (unknown [9.67.69.251])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 19:40:02 +0000 (GMT)
Message-ID: <66e2e5e4-5ce5-442c-ba0f-d12cbe79e868@linux.ibm.com>
Date: Tue, 4 Feb 2025 13:40:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] DTS updates for system1 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>, brgl@bgdev.pl,
        linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250203144422.269948-1-ninad@linux.ibm.com>
 <79b819b6d06e3be0aa7e7f6872353f103294710c.camel@codeconstruct.com.au>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <79b819b6d06e3be0aa7e7f6872353f103294710c.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BhN8vCZp0wt20C1zuEMO0Dx_nRHE2XX9
X-Proofpoint-ORIG-GUID: WZwPJdOGC93lfCtccZ-FJMqUiy-K5W1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=965 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040145

Hi Andrew,

Thank you for the review.

>>
>> NINAD PALSULE (6):
> 
> Why is your name all in caps here but not for the binding patches
> below? Can you fix that up?

Fixed in the version 9


>> Ninad Palsule (3):
>>    bindings: ipmi: Add binding for IPMB device intf
> 
> This one needs an ack from Corey if I'm to take it.
> 
>>    dt-bindings: gpio: ast2400-gpio: Add hogs parsing
> 
> This one needs an ack from Linus W or Bartosz if I'm to take it.
> However, it's also causing some grief from Rob's bot:
> 
> https://lore.kernel.org/all/173859694889.2601726.10618336219726193824.robh@kernel.org/
> 
> As the reported nodes should all be hogs the name shouldn't matter
> anywhere else (as far as I'm aware). It would be nice if all the
> warnings were cleaned up before we merged the binding update. That way
> we don't cause everyone else looking at the CHECK_DTBS=y output more
> grief than they already get for the Aspeed devicetrees.
> 
> In order to not get bogged down it might be worth splitting out both
> the IPMB- and GPIO- related patches like you did the FTGMAC100 patch,
> and then I can merge what remains (from a quick look they seem
> relatively uncontroversial).
> 

The warnings are fixed by different patch by Krzysztof. As there are no 
more changes then I will wait for other responses. If I don't get those 
response in couple of days then I will split it.
https://lore.kernel.org/linux-kernel/20250116085947.87241-1-krzysztof.kozlowski@linaro.org/

I am also planning to fix old warnings in the system1 dts in separate patch.


-- 
Thanks & Regards,
Ninad


