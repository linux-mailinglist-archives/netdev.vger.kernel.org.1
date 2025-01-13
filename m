Return-Path: <netdev+bounces-157879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD56A0C20F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECA17A464C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237881CEE9B;
	Mon, 13 Jan 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZAkYxeR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796791CEE82;
	Mon, 13 Jan 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797805; cv=none; b=e61rGbA9B0EVU48DWRbWP7dFV2M03dj5zp61mn+VW0I8HGTYrHtUqy+4ZDPrz4bwJ82TEqbAqgYKNUdk6PF/JAG1RjLrF+GAnmHOVFYldIal45Xo0BCJvSORkVj+GYv8ocJXJDdctVwgdN2ZjB97uTqRF9fQ4OHTsQAfiucx9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797805; c=relaxed/simple;
	bh=si0Am3z1ySD/7sMN5BXMZqTFzU6+Bi1tKGoK1yRbr6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3xilsVWsXp2ZdD8y6WVAgO+G1uUSkXGVf7Qzr3sGUj0GqAh94FaElXsozQ298jzUxfrWBYm2OewpBfvCSph17mrh6IfGEKZxlGaNGQVpDWmjWX3pvT1eLPk4aqMYNoBBiNGltMP+qnLEHSjxUgIYn4UNWJYW5XQKZprPZPmiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZAkYxeR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6RQH019827;
	Mon, 13 Jan 2025 19:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d2GkHx
	4QTVyi0OT0e9WCdAsHm7vIJF8oUFztxZt5AGc=; b=QZAkYxeRygGqeVN9c7G6aC
	VQfBeFQJv+KDaQO5Evqaqn6I0e2OBBZ93ZR7D9tJGrT4eBkfZEus43CciAZxY+K+
	c8jTAB3BWVWfWITreEC5esAhLAAQF/ecC0k04NM4/ORRrIaArzY+KodddlSRwZ4l
	Wde9jcgksdLOfF7k+WATvcpalpCmm8fkq5z2i0o0UV8pesTWgQN2Bq66/URHNOHi
	1cmPbw58l9VA0yL1L0lqZhQykPRy8BSq6PeScZJy3qVC3WQcb2l+0A8moGCi5Oxv
	48awYrCyJZPIaLhDdTkocp5Hs0sGCebzn8cQY+/uk2hxNuUUvYLkZT+v5Qau1Vhw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a59hmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJnDAw017868;
	Mon, 13 Jan 2025 19:49:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a59hms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGd9gK016994;
	Mon, 13 Jan 2025 19:49:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjyrny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJnBIO29622810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:49:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165625805A;
	Mon, 13 Jan 2025 19:49:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6136458051;
	Mon, 13 Jan 2025 19:49:09 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:49:09 +0000 (GMT)
Message-ID: <99645919-6756-4442-ad2f-a9b353da22c8@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:49:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: net: faraday,ftgmac100: Add phys
 mode
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, conor+dt@kernel.org, devicetree@vger.kernel.org,
        andrew@codeconstruct.com.au, kuba@kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        andrew+netdev@lunn.ch, eajames@linux.ibm.com, minyard@acm.org,
        krzk+dt@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        ratbert@faraday-tech.com
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-2-ninad@linux.ibm.com>
 <173652497637.2952052.6627595246829829775.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <173652497637.2952052.6627595246829829775.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e2UR_H-XhwWAH3iBg0WOCRUvriLik3My
X-Proofpoint-ORIG-GUID: W526mhYllqjPLt3wkW7aqjCd7n_jLJWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130156

Hi Rob,

On 1/10/25 10:02, Rob Herring (Arm) wrote:
> On Wed, 08 Jan 2025 10:36:29 -0600, Ninad Palsule wrote:
>> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
>> document them.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for the review.

Regards,

Ninad

>
>

