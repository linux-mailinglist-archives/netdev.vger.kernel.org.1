Return-Path: <netdev+bounces-193641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE178AC4ECC
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F643ACAEC
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1472269CF6;
	Tue, 27 May 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nEfYdvd9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DDC2ED;
	Tue, 27 May 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349627; cv=none; b=bTnCwfM/QTstw5nfgB4aodZ5jM3VG3ZsuAayMRsm8qlWIVgXyBnvoNVjgS6Hr3wR0mJBVYFX5jsxQjGQ2DRTYOo7MncEvJ5fnwFuq7wDMXJ+75DtrRUvW4Wj2FDT9r/RMNoZtfoYOXMcgA1vhVROzs3ceDsxb//+fTmBNL7y4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349627; c=relaxed/simple;
	bh=UFYxLvLXnz2b6nESN++qfyBWIUKQClun0peTMmDwm4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZbn5lnFD7kzkzsCqO15LQtulLIVVQk+7sjRE1VHRE8w1lJMZNYcyFUM5RTNtOciK8mNLnB640s1VmwyTNXUyiRTSC/NGXhGu69//+wd8sdIyT+uxrGWEkneyyEfwDMIUvZ9TMHSq8Ttyrz3Z1sIQ7MqexhHgT/HZUw6759y7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nEfYdvd9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCErA0029147;
	Tue, 27 May 2025 12:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HPoY8V
	vbbzKkHM55bPaoXsYcK2nwbz0DzoWdBYk8FiU=; b=nEfYdvd9y4fHCpqa/hYK5f
	y84+euZcXJCUgpRNXUgIYP2U1VECSjAGNe/1XC3VSSqSD185subKufGT0Wn+PuQn
	nOLxY2sJc9iw/LUraAg+ZmE7cayjdOTMrj3l5JRz84fdHTje7G1hzJkOxVUeDuAn
	bjOY4TJaGK54js8rshP1XPuzhju9OTLmMCM7DbDkhRTY8sW03kWuA6opm978LW34
	Ivl8QDyiaOab6f+7yIUHT6HbyU1wXap1tO/YU+EMUMM2hS8EyOgmdgjNbn2xUSrb
	BfUgAiAStaFCAA/97p6WSNw6/q9mypZGpXP2v9CRFOtUFM1nvvR0AUhCNSMY8gtQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u5t0p8tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 12:40:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R8u2GK007979;
	Tue, 27 May 2025 12:40:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46uu532ade-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 12:40:19 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54RCeJVg27525720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 12:40:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0828258058;
	Tue, 27 May 2025 12:40:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A904C5805C;
	Tue, 27 May 2025 12:40:18 +0000 (GMT)
Received: from [9.61.246.68] (unknown [9.61.246.68])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 12:40:18 +0000 (GMT)
Message-ID: <4d23f536-bea1-49c9-98a9-b237e6aa0d9c@linux.ibm.com>
Date: Tue, 27 May 2025 07:40:19 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SOCK_STREAM
 SHUT_RD test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20250526134949.907948-1-kshk@linux.ibm.com>
 <CAGxU2F40O3xDSwA4m6r+O5bWoTJgRXqGfyMiLH_sMij+YmE5aw@mail.gmail.com>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAGxU2F40O3xDSwA4m6r+O5bWoTJgRXqGfyMiLH_sMij+YmE5aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwMyBTYWx0ZWRfXxJq5a+Ieb7OR K1DPtGUmMnP5rw5omznXdrOJri1ZNXVLxbmB85jXmChD3kDIRJs/QOK3uSK2bpKGk6Q3ZtD1s25 ZMTUzvlx0mJi8XMmTt7w/F/if4TgfWcaiIXDHIszoixrKVcaTyyu5KCz5BuChiuqnOGaVK/PY7d
 KyvBbp+66/RmAQWaII2x6UE0UtQX+MkUTuAw1MMfYjmGi3fRTYSJmDgA1U9wxIJZ9l8pXpDODqX 5coC1GPXElNyqKomtlvTcO1I5QzQcdjCargnuzrsh+yw2JonM/eDlXh3sw8bGVklmYgsxOFFdbd rKE0Re2BCMd5i1t2i6DoEeXT8PE1wMGGsRBExr2ceq9fKWyxDx1euaT0iEuwXp7lqYvziF8CP/W
 VauKklbzPIzIP9diIHX3WxzB9i8p+BuHJKaDjPfwZtLwz+ee7IVlL13yj+92ynwvN3pwgird
X-Authority-Analysis: v=2.4 cv=INACChvG c=1 sm=1 tr=0 ts=6835b2b4 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=4tGWxnr0_xZ9uz3X2MUA:9 a=QEXdDO2ut3YA:10
 a=0TW8CM1oYAoA:10
X-Proofpoint-ORIG-GUID: SQyfJiGMA-0kCPEk9ODezwVjLrGlcJ58
X-Proofpoint-GUID: SQyfJiGMA-0kCPEk9ODezwVjLrGlcJ58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=555 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270103

On 26-May-25 08:55, Stefano Garzarella wrote:
> 
> BTW I think I already fixed the same issue in this series:
> https://lore.kernel.org/netdev/20250514141927.159456-1-sgarzare@redhat.com/
> 
> Can you check it?

Yes, it looks like the same issue.


