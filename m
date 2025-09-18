Return-Path: <netdev+bounces-224272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91BB83551
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D781B26136
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF42E5B04;
	Thu, 18 Sep 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oA5miBb0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068AA275AF6
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180918; cv=none; b=FAajYGrrVUPpz6MY6ls5vyha/rmGzVadFeoMH2gPFaD/h7n5cFw8ge5SzMRqRqWzLfWygm82L/VnBYQAzBIWDg1xtlrbJQCjdEhcI3+lj+krSuFrHKv9C2OTk4ZC+gmHP8YPpEIoW+QNf9ZEDY/1ukHXfXh85AaQnrI90PRefE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180918; c=relaxed/simple;
	bh=3W6xoEEHHHy/Y1lDfePO7sM2QC15d51YZwVuwNiywUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHnvkiscgbGyaQDpGohtSFvA4CmDJudPv4UtWGUbclTAJt+8MjdkqzFRQVfX0tEtEPPE4ks94YAZvLBnYkwV1onW90beIKjeCSWXaaDprnhQS7qbxf1RiR+zSUqE5Qa33gw1n6YYm7X6TCL+GV0Y1M9Tig+QR/1XU86KCxsWL2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oA5miBb0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4NJBe028838;
	Thu, 18 Sep 2025 07:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lPJENc
	BFLUp4ILGVwI8nnb2tbNEICVZdszTh04QRZVM=; b=oA5miBb0eNGIh8WSXAAV2w
	s/OEWEIWGk3tM9gsL7qOcrc8TAHmw7WF/guddpmjr9gUldH92C5Mdysm6hSd6aAY
	8tcktULUaNGuCokt8fhumWPbW+jl4EE7sbRtCDa6THJ0kcLUOZQMMRqjpr4fX4ez
	zFv128w8yJODHcFkdc7lGA9j40TKmEuiCOXg3jRcHTApSmf9bYB3bd6lOIp47aj1
	xUTlozeTnigTwmgWIaDlfm8eYRr25Rf4VH47+F4Ph2tiYlxrGpd/rG30wz1k2e8Q
	RUFhRmsMdZeeEwv8Zp3lXzBzgTRq3w7vqlchIR9BCnC/5p0NzbToIrYRr6QAR3IQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p8qjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 07:35:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I7HqE9017750;
	Thu, 18 Sep 2025 07:35:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4p8qje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 07:35:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7A8Ax009367;
	Thu, 18 Sep 2025 07:35:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3n65v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 07:35:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58I7Z1Xp32965144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:35:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1FA5805E;
	Thu, 18 Sep 2025 07:35:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3C6458059;
	Thu, 18 Sep 2025 07:34:56 +0000 (GMT)
Received: from [9.39.24.159] (unknown [9.39.24.159])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 07:34:56 +0000 (GMT)
Message-ID: <a721adb9-caf1-48eb-b02e-8e5d1ce5f203@linux.ibm.com>
Date: Thu, 18 Sep 2025 13:04:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/7] smc: Use __sk_dst_get() and dst_dev_rcu()
 in smc_vlan_by_tcpsk().
To: Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>
References: <20250916214758.650211-1-kuniyu@google.com>
 <20250916214758.650211-5-kuniyu@google.com>
 <e1bae4d7-98f7-4fe6-96ba-c237330c5a64@linux.ibm.com>
 <CANn89iL39xRi1Fw0N4Wu6fbNjbbNjnYS4Q8BD3q+8HrY2XB_4A@mail.gmail.com>
 <CAAVpQUBJFpcBUgez6Pni0H2uQbeqLodDcOzvy+fPfGj6jgxh4Q@mail.gmail.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <CAAVpQUBJFpcBUgez6Pni0H2uQbeqLodDcOzvy+fPfGj6jgxh4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX3WAu5tq6itr9
 756rf2u1/DHIQQMFu8327QtEuPAyZyQfVzsHs3fKm84fGgT7nCULr3PsANoYzk89ERlfUlqz7g8
 EagsNYR7uiVqnaiqCkXZxPAhYlKuS2Le+f/m2hS560sqJipZ3rGrRD+rdSy3TAI9JYLRLFX+ouo
 EEL4gP6NdFJThE8hxMz7VLqiMaynprBGQ1RTIhxLThcusiU8DaWs/VrV4j52lwMduX1sJcLwK1N
 DzsQ43MYzgxNoQj9pp27EPxBJmj812VDbTmsXQF8SUNm5wX/JsJyRChc3P7uxwjRshWwl1iZSxM
 RwDmhT0ChX2+ZC5tc7WZt/WG9piiNH/HTzbcc68djdgOmqZ99Qbl3qnLCDOV0HnhCFsHdkuBSOA
 DQ5NH/DL
X-Proofpoint-ORIG-GUID: ne217kPjwbdS2meIKmRk8NN8lmxsEBVE
X-Proofpoint-GUID: ALVZ3PkIwX8sQ_a_J304-1cRF4FF0LuL
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cbb628 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=QTLmH3499XkOAwBMc_kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On 17/09/25 11:11 pm, Kuniyuki Iwashima wrote:
>>> On 17/09/25 3:17 am, Kuniyuki Iwashima wrote:
>>>> Note that the returned value of smc_vlan_by_tcpsk() is not used
>>>> in the caller.
>>>
>>> I see that smc_vlan_by_tcpsk() is called in net/smc/af_smc.c file & the
>>> return value is used in if block to decide whether the ini->vlan_id is
>>> set or not. In failure case, the return value has an impact on the CLC
>>> handshake.
>>
>> I guess Kuniyuki wanted to say the precise error (-ENODEV or
>> -ENOTCONN) was not used,
>> because his patch is now only returning -ENODEV
> 
> Yes, that was my intention.

Understood. We treat both errors as a single error here.

