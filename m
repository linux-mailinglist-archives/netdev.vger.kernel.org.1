Return-Path: <netdev+bounces-138708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A79AE99A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08CE1C228B6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42171E7C0E;
	Thu, 24 Oct 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dMru5HTw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC11EC00E;
	Thu, 24 Oct 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782059; cv=none; b=r7I/2DonxqIV2l1ePNCpw8mmksV6sWbdMPmqxJDQ+9twe7O6UPQxphEQvLJQI/HNwLGhcTV71VjIKRWV8FbPRUVvntUwM8nBVStC5HR5n9MNjVYuccRE4p6DLYlv7ZAiPfte7gUvUDfexsAoSf2vVzooigquMaYx8PemtlcAV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782059; c=relaxed/simple;
	bh=VLi7J97j1lguyS5wR5Z4qXdPZl1d6UXv3b8uw5oPRxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5R2EJ4vcR2UUSheVywUqxniaKo4XnsFmbwqDd9YyKoGtNoRaJLKOws4xb/Ko/ev97QqYTO07Yp4hUr0jmJPqMxldhZ4eCG5vHe4muTnMBnTnppKFNIqY82t49OqrKO6CjAwbNOVt9mrYjsBpQqZJUVMoykbkTX14kEG1WRJOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dMru5HTw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OAQHr0020092;
	Thu, 24 Oct 2024 15:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3saOTO
	MFvcMM6rYt5g+R5K3d9d71mTmwQjKmfdHGvnU=; b=dMru5HTwJDt7e+Pp7ZWs7i
	di0YALl79zYqToC7nOmyaF63mXn1iAPRDlKp0mE2VqBPsYvnwoTQn1Z/RCIe6qhe
	O7FpQ1RjQSW01ibNrkFQIisJnPm5+B0n8lJ2EGreQEznsfWstE996HmdB7ta/3FW
	dnTCECg7fWx/YFz/escJ8BBjym0IPz3RMGWOiTbL/qSkJkUyTMCnt07vAXLfoZOa
	Q93FpVtfKYPwZ8yNWoCL06FHeH7IhMuCfC7UsI1/m+mYUw74qSVHCJ1OEKkU22rC
	VL+ntZg5O6ddW0x2O7J3F8/H0Zv6ygms48O99NH6pVPpH5dyc4vG+XzEA/pk5wsw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajs62p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 15:00:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OECOMV012632;
	Thu, 24 Oct 2024 15:00:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfgy0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 15:00:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OF0lCq14549560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:00:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9882A58056;
	Thu, 24 Oct 2024 15:00:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 726FB58052;
	Thu, 24 Oct 2024 15:00:47 +0000 (GMT)
Received: from [9.41.105.143] (unknown [9.41.105.143])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Oct 2024 15:00:47 +0000 (GMT)
Message-ID: <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>
Date: Thu, 24 Oct 2024 10:00:47 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20241023210031.274017-1-kshk@linux.ibm.com>
 <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lImtREhiYzU4CwnZ-WSl1s8o801zO3US
X-Proofpoint-GUID: lImtREhiYzU4CwnZ-WSl1s8o801zO3US
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=560 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240115

On 10/24/2024 03:43, Stefano Garzarella wrote:
> Other setsockopt() in the tests where we use unsigned long are
> SO_VM_SOCKETS_* but they are expected to be unsigned, so we should be
> fine.

It's actually not "signed vs unsigned", but a "size + endianess" problem.

Also, looking at SO_VM_SOCKETS_* code in the test, it uses unsigned long 
and size_t which (I believe) will both shrink to 4 bytes on 32-bit 
machines, while the corresponding kernel code in af_vsock.c uses u64. It 
looks to me that this kernel code will be unhappy to receive just 4 
bytes when it expects 8.

