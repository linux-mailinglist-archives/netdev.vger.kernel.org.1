Return-Path: <netdev+bounces-159050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B744A14387
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9598F16A246
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE124224E;
	Thu, 16 Jan 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ek/0N0/d"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD97236ED6;
	Thu, 16 Jan 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059911; cv=none; b=TNMpFEzRgmHgaxE6s7uB7fK/wlE1oahXKchPpVx+PGG3Top3NjWf984bksvsoiSvw2+FEhxMX7oyxUTjZYKKcOcNOMYW/CcMhu6QRPW6IclV4qCq+tCauNVCpjDgEFzvO5R2grfg7iivJnUudKOcjIrs+4hwxhxgsgHLdwGcOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059911; c=relaxed/simple;
	bh=zlsnNQeZ6ITgaVjZOYsoogAkcodVJQOFZef1bu912lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABbcpYAH1F0A2dVUPsVa0lSVbYtmbod4SJ2DGmczaPs69whoBI/AXNKbMwG0WecdbxK22xxEulqmm9U8T4zHIYt4QaDN05WGa0WsSzh2sPc9uDG2iF62lyHLVSSgXa/iNprWZkEAAilsemGw8ISAmEjKCiZCiVuTaMptnS9dZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ek/0N0/d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEN71W004842;
	Thu, 16 Jan 2025 20:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XOwUUj
	+9Al5+mspF1UWIyD+W6CPpDiMR74J1EVLvCzs=; b=ek/0N0/daEP783QrNb5L2O
	VajxIFEIdCTOl48UZCAc7XcL+4Mkjh6yRTvCUVJhAK+fQf/7JmQSaHq+daxaWeRS
	lTk9TnZAiuiDq4ghdSRJuBI/mP92Ovc6joOGhmZLomMvRh4Sq0fL0zyiciaC5oBd
	P2E+cl25X9GecJTjdD9+/+B1h5sGezk73se5vK9SBbSlw7roVgCcOAhjBK8HQhT0
	l5wgAX+mih2CVThNsfeV3CKWay2nQJ9EYRgjF1oSA4h/2aV6kgbLbnFdOLeFMmXT
	yqTiI9Q4rI+J99/VsHm1cwD/3iF2+TU6i/BSdy/jVPlHZvKvko6JdZ+nwiwgXnyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhcqg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:37:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKXJSW010145;
	Thu, 16 Jan 2025 20:37:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhcqff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:37:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GHdmgL007519;
	Thu, 16 Jan 2025 20:37:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynfmw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:37:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKbi2L24445642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:37:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A3658055;
	Thu, 16 Jan 2025 20:37:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B075804E;
	Thu, 16 Jan 2025 20:37:39 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:37:39 +0000 (GMT)
Message-ID: <c61740c8-8dd3-4d59-8553-1dea4cbd5c93@linux.ibm.com>
Date: Thu, 16 Jan 2025 14:37:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com,
        linux-arm-kernel@lists.infradead.org, edumazet@google.com,
        joel@jms.id.au, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org,
        eajames@linux.ibm.com, minyard@acm.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <173689907575.1972841.5521973699547085746.robh@kernel.org>
 <35572405-2dd6-48c9-9113-991196c3f507@linux.ibm.com>
 <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pDZnXta5jIEiLEPhuvleI218uMy8Px8J
X-Proofpoint-ORIG-GUID: c5p-lEQ3kr5JODh2EUhlema0DIXGbz0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=547 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160151

Hi Rob,


>> I am not seeing any error even after upgrading dtschema. Also this mail
>> also doesn't show any warning. Is this false negative?
> 
> I believe this happens when a prior patch in the series has an error.

Thanks for the response. I have sent a next version.

-- 
Thanks & Regards,
Ninad


