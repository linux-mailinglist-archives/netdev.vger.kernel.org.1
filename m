Return-Path: <netdev+bounces-49145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C0A7F0ED1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6751C213F7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410210A05;
	Mon, 20 Nov 2023 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XjO3vwgx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D17A7;
	Mon, 20 Nov 2023 01:17:29 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK9Fonc014279;
	Mon, 20 Nov 2023 09:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EmR6Z2ypc35GwwsP3ouedlNPCHaHpOXWFemzvEahzOY=;
 b=XjO3vwgxuqKo9jD4o7LQzDmAdarM5CljCUHd/g4lIy6iyIf28GtCq9CWypFZqFD8WJlT
 SQU2bTCG2fFbqGOpUva5srC09GI2UI5l40+rWb40cklkwtmaclzDNP0C5kkhFcCVaWgU
 e4s0jR4cmuK2XGAVXn0a6WUSXjngb8e0lVltnnlHB1/ObbuW3BtUo63pCs7m2vYvEAJM
 YDYCNSmnD9ZvS/mwLyEDc4fsVfdfsjN6haesmVfaFrrkwskD+x5+s6+ktsD+mQJPFwYa
 CJ9gTDXsllLlXbnizIqItW7rqEWavpr+Js6+EE2S3Tw25alrZuEh8Q2yh9b7xGaYN8td zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug37w2kby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 09:17:21 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AK9G2JD015516;
	Mon, 20 Nov 2023 09:17:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug37w2kbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 09:17:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7KMWM008904;
	Mon, 20 Nov 2023 09:17:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy8au0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 09:17:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK9HGfW18481700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Nov 2023 09:17:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FD9D20043;
	Mon, 20 Nov 2023 09:17:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7586D20040;
	Mon, 20 Nov 2023 09:17:15 +0000 (GMT)
Received: from [9.171.73.39] (unknown [9.171.73.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Nov 2023 09:17:15 +0000 (GMT)
Message-ID: <f648fe4f-c911-43c5-be52-1a6324f063a6@linux.ibm.com>
Date: Mon, 20 Nov 2023 10:17:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
To: dust.li@linux.alibaba.com, Li RongQing <lirongqing@baidu.com>,
        kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, Tony Lu <tonylu@linux.alibaba.com>,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
 <20231120032029.GA3323@linux.alibaba.com>
 <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>
In-Reply-To: <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oilDNoY0D3bOxOXVNidoXZXnzvNI7Ee_
X-Proofpoint-GUID: jvExDTAnAN6thdADU_uAL5MzoNMYG3-g
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_07,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=993
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200061



On 20.11.23 10:11, Alexandra Winter wrote:
> 
> 
> On 20.11.23 04:20, Dust Li wrote:
>>> It seems to me that the purpose of conn->tx_pushing is
>>> a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
>>> b) Repeat, in case some other thread has added data to sndbuf concurrently.
>>>
>>> I agree that this patch does not change the behaviour of this function and removes an
>>> atomic_set() in the likely path.
>>>
>>> I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
>>> So how can we ever run in a concurrency situation?
>>> Is this handling of conn->tx_pushing necessary at all?
>> Hi Sandy,
>>
>> Overall, I think you are right. But there is something we need to take care.
>>
>> Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
>> sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
>> without checking sock_owned_by_user(), which would caused a race condition
>> because bh_lock_sock() did not honor sock_lock(). To address this issue,
>> I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
>> we now defer the transmission if sock_lock() is held by the user.
>> Therefore, there should no longer be a race condition. Nevertheless, if
>> we remove the tx_pending mechanism, we must always remember not to call
>> smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.
>>
>> Thanks
>> Dust
> 
> 
> ok, I understand.
> So whoever is willing to give it a try and simplify smc_tx_sndbuf_nonempty(),
> should remember to document that requirement/precondition.
> Maybe in a Function context section of a kernel-doc function decription?
> (as described in https://docs.kernel.org/doc-guide/kernel-doc.html)
> Although smc_tx_sndbuf_nonempty() is not exported, this format is helpful.
> 


Tony Lu <tonylu@linux.alibaba.com> ' mail address has been corrupted in this whole thread.
Please reply to this message (corrected address) or take care, if replying to
other messages in this thread.

