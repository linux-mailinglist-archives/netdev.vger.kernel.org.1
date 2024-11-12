Return-Path: <netdev+bounces-144141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7969C5BAA
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7871F2215E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CABD2003A7;
	Tue, 12 Nov 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rfn8N77g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CC1FF046;
	Tue, 12 Nov 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424735; cv=none; b=VC2LskgDez8dFjEDyMinCZ6sqW9s/latmYj0mG2bS8uL8RiL8utk6Fdg+I85kJmCLU+hN4ghcvtaPM7DH7a0mspqqEGT3LtKttDRO0UUETPk1XwU096PLhADv1LwB1UJyyCQExa+cXY414BWZ68frNMc53Wyt8Z251jdgTc9q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424735; c=relaxed/simple;
	bh=afmbmlqFcLrOAU7ve7A4Q8S3Gx5MaqFvD1hecGB7rZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMuCMmHc9DWCUBMQt9oV8VbKYvxwCsMzMEVMiUapoxHr3MlXRjI/RgD8pBPEuy+/avSEXae5AOHv0sgdSALIdRSx6a6AeijVqmfuu9RKTDYM3HxSxL9FrJYcRRvIzq1TxoHeQAO4Fd+zGxtBkD5CLeOwOqGg0kSpgAwPKLZcwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rfn8N77g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEex09008433;
	Tue, 12 Nov 2024 15:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MOb0mH
	pw2LkyIaErpZMtj9sw/+stYEKTQoIOJtGWeOw=; b=Rfn8N77gOfrVLnIdVkcnLe
	rPHVkaS3y65RelUbvTpSrRq6fqvp3NHR01MymySIaJetL91S/C9bdrPse7y7Jqc8
	ohfnZjHjL83uqxktPto6mWecKAhXvC1US3m4iXOsPxvZYCij2mxJgFaMZcSnnFZV
	OK9tmhI6AYQyAmPqfrroF/G0VOu/1P8ByB0D8NdqSZOJlSSC+I9CKRncNGTSr/I0
	c+mhfGZPjQPPnCtAHtPzEoAl5KQ1xT+k8LvMLUPtB/ZVto0g8eDOqyDWPF4X5s5K
	5UdDZmY7JF10/r45loiG7wqADTWSnlMZQ6iwKCIhs5Q2zMyCpzvFE0exZn12XbDw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9020755-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:18:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACE607V029698;
	Tue, 12 Nov 2024 15:18:49 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjkt62t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:18:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACFImLI55902522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:18:48 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE6C58056;
	Tue, 12 Nov 2024 15:18:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30A9158060;
	Tue, 12 Nov 2024 15:18:48 +0000 (GMT)
Received: from [9.41.105.143] (unknown [9.41.105.143])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 15:18:48 +0000 (GMT)
Message-ID: <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>
Date: Tue, 12 Nov 2024 09:18:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] vsock/test: verify socket options after setting
 them
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-4-kshk@linux.ibm.com>
 <bltkmoxf6xsknimf6ccrxuritfc3ipxhbqkibq7jzddg6yewcv@ijcc44qmqsm3>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <bltkmoxf6xsknimf6ccrxuritfc3ipxhbqkibq7jzddg6yewcv@ijcc44qmqsm3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZHas1wz7eyCTrodpZGt3KSa4wFbzx7el
X-Proofpoint-GUID: ZHas1wz7eyCTrodpZGt3KSa4wFbzx7el
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120121

On 11/12/2024 02:58, Stefano Garzarella wrote:
> On Thu, Nov 07, 2024 at 07:17:26PM -0600, Konstantin Shkolnyy wrote:
>> Replace setsockopt() calls with calls to functions that follow
>> setsockopt() with getsockopt() and check that the returned value and its
>> size are the same as have been set.
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>> tools/testing/vsock/Makefile              |   8 +-
>> tools/testing/vsock/control.c             |   8 +-
>> tools/testing/vsock/msg_zerocopy_common.c |   8 +-
>> tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
>> tools/testing/vsock/util_socket.h         |  19 +++
>> tools/testing/vsock/vsock_perf.c          |  24 ++--
>> tools/testing/vsock/vsock_test.c          |  40 +++---
>> 7 files changed, 208 insertions(+), 48 deletions(-)
>> create mode 100644 tools/testing/vsock/util_socket.c
>> create mode 100644 tools/testing/vsock/util_socket.h
>>
>> diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>> index 6e0b4e95e230..1ec0b3a67aa4 100644
>> --- a/tools/testing/vsock/Makefile
>> +++ b/tools/testing/vsock/Makefile
>> @@ -1,12 +1,12 @@
>> # SPDX-License-Identifier: GPL-2.0-only
>> all: test vsock_perf
>> test: vsock_test vsock_diag_test vsock_uring_test
>> -vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o 
>> util.o msg_zerocopy_common.o
>> -vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>> -vsock_perf: vsock_perf.o msg_zerocopy_common.o
>> +vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o 
>> util.o msg_zerocopy_common.o util_socket.o
>> +vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o 
>> util_socket.o
>> +vsock_perf: vsock_perf.o msg_zerocopy_common.o util_socket.o
> 
> I would add the new functions to check setsockopt in util.c
> 
> vsock_perf is more of a tool to measure performance than a test, so
> we can avoid calling these checks there, tests should cover all
> cases regardless of vsock_perf.

The problem is that vsock_perf calls enable_so_zerocopy() which has to
call the new setsockopt_int_check() because it's also called by 
vsock_test. Do you prefer to give vsock_perf its own version of
enable_so_zerocopy() which doesn't call setsockopt_int_check()?


