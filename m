Return-Path: <netdev+bounces-42396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94D7CE8DC
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF616B21225
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729913DFF8;
	Wed, 18 Oct 2023 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jnBrn3U/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36FB3DFE6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 20:29:06 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95F71725;
	Wed, 18 Oct 2023 13:28:49 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKPf7b005991;
	Wed, 18 Oct 2023 20:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=w4lv6LPBChPxhlnjQXqBLjFAsycxLp+f8TbKWcoIXOQ=;
 b=jnBrn3U/tbk65NKJmn03JgBoVriKZFMYS1IjCMKhLItk994zVIdm/3zHv/A4WS6tEpMr
 LPQNze5tb3kyZpyIaVv+IeasLL5KuWytzRQ37s7Etw2pUFsbKw4IZI1Zk08rK7Uk3327
 DG2ushMDt9cm/GuB7rNk7xRqnLdsXpI7rY7tJkvYt+cNWPJ/E7syaqookUtQI53kJlTa
 C4/t0aMkMU+fPkEJTx1zzVkrlLEIyfWwbAJRR/FAlBakokINKTA6ih8IC9irEmLJMlc1
 FR11Tqv9cIGsyVYjQXxBQk5N/H8XEFvfx9tqxgLwPdGm4XNJ/vOmQiTdTW8d8NTdIYTy GA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttpcr8bt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Oct 2023 20:28:43 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IKQOOr010172;
	Wed, 18 Oct 2023 20:27:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttpcr853q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Oct 2023 20:27:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IK6H0h012855;
	Wed, 18 Oct 2023 20:26:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pykyfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Oct 2023 20:26:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IKQSU337880476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 20:26:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30FF558055;
	Wed, 18 Oct 2023 20:26:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B97A58056;
	Wed, 18 Oct 2023 20:26:26 +0000 (GMT)
Received: from [9.171.53.134] (unknown [9.171.53.134])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Oct 2023 20:26:26 +0000 (GMT)
Message-ID: <ad5e4191-227e-4a62-a110-472618ef7de1@linux.ibm.com>
Date: Wed, 18 Oct 2023 22:26:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
Content-Language: en-GB
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
 <bdcb307f-d2a8-4aef-bb7d-dd87e56ff740@linux.ibm.com>
 <ee641ca5-104b-d1ec-5b2a-e20237c5378a@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <ee641ca5-104b-d1ec-5b2a-e20237c5378a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2DtDiJKL36EGAKaDx7MWIfUFAWr2KdHM
X-Proofpoint-ORIG-GUID: RMBk6rVwiO5WiLs4sI0Kpaw5WZOLeIBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180168



On 17.10.23 04:06, D. Wythe wrote:
> 
> 
> On 10/13/23 3:04 AM, Wenjia Zhang wrote:
>>
>>
>> On 11.10.23 09:33, D. Wythe wrote:
>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>
>>> Note that we always hold a reference to sock when attempting
>>> to submit close_work. 
>> yes
>> Therefore, if we have successfully
>>> canceled close_work from pending, we MUST release that reference
>>> to avoid potential leaks.
>>>
>> Isn't the corresponding reference already released inside the 
>> smc_close_passive_work()?
>>
> 
> Hi Wenjia,
> 
> If we successfully cancel the close work from the pending state,
> it means that smc_close_passive_work() has never been executed.
> 
> You can find more details here.
> 
> /**
> * cancel_work_sync - cancel a work and wait for it to finish
> * @work:the work to cancel
> *
> * Cancel @work and wait for its execution to finish. This function
> * can be used even if the work re-queues itself or migrates to
> * another workqueue. On return from this function, @work is
> * guaranteed to be not pending or executing on any CPU.
> *
> * cancel_work_sync(&delayed_work->work) must not be used for
> * delayed_work's. Use cancel_delayed_work_sync() instead.
> *
> * The caller must ensure that the workqueue on which @work was last
> * queued can't be destroyed before this function returns.
> *
> * Return:
> * %true if @work was pending, %false otherwise.
> */
> boolcancel_work_sync(structwork_struct *work)
> {
> return__cancel_work_timer(work, false);
> }
> 
> Best wishes,
> D. Wythe
As I understand, queue_work() would wake up the work if the work is not 
already on the queue. And the sock_hold() is just prio to the 
queue_work(). That means, cancel_work_sync() would cancel the work 
either before its execution or after. If your fix refers to the former 
case, at this moment, I don't think the reference can be hold, thus it 
is unnecessary to put it.
> 
>>> Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD link 
>>> groups")
>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>> ---
>>>   net/smc/smc_close.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>>> index 449ef45..10219f5 100644
>>> --- a/net/smc/smc_close.c
>>> +++ b/net/smc/smc_close.c
>>> @@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct smc_sock 
>>> *smc)
>>>       struct sock *sk = &smc->sk;
>>>         release_sock(sk);
>>> -    cancel_work_sync(&smc->conn.close_work);
>>> +    if (cancel_work_sync(&smc->conn.close_work))
>>> +        sock_put(sk);
>>>       cancel_delayed_work_sync(&smc->conn.tx_work);
>>>       lock_sock(sk);
>>>   }
> 

