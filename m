Return-Path: <netdev+bounces-129248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2497E75A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E89828144A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5A18E374;
	Mon, 23 Sep 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GrZ9HJxj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE318E059
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079395; cv=none; b=quMk/R5jmZ6mzapPavwH/cFxQ+uj8dQ5QorJdQDnWAM7JeJmx3GWOf6uOeDeEP8p147GMdyGBKg8O/3h+f5nPONJfOONmXX3kIzQa8lofe/p7FtJb/2lINrBvQCDm5oMZL5KWn1qX40vFjmLM50BtAsFllnz+LPJuuyfoLivF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079395; c=relaxed/simple;
	bh=9pshT8c7mKx5skh9j8TQV1rhnobVXGDkNqHqksnLr2M=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bmasYjfSJhEkFidJzZcNphnpIWRt0DqhgoqcflUC59nvpNsjtLWI7YXhFG9S46JV9eyHhHSIOn18OFgUL8UFpDdYrK3gbKjVkbJcJsPSMvkS+dDfNy8tZwO6MkC1txJG7dIGqHv2zWcQeI/py2JtJWRlj1lymsrpQb88MrPVPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GrZ9HJxj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MMwLJ6010089;
	Mon, 23 Sep 2024 08:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:from:subject:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	TXseeauF0v7swd/63T6FcKzGvSycKZhQ0aiiQ3MXjfI=; b=GrZ9HJxjsrUJL22P
	dDC+QhioubJU/fQgomkZ8/+Kti2hxJzglnAN5IjOYwfrA6nvBkeE0TYKHJjERqP8
	A3lWZytxqtXmGeOV8SxQrYk/fRmmP6+frfVqIhrp7+oOPVw4+oS/fpS5Jg77shin
	QRh/oezCca6Yf5aDlRZ9l0SPRrNCU0AQEYhtPAUrNVidLootp8UJcXFeUsmRcMl1
	K523vFIw0JwahOJ29ZOaKGx+QCZDKU9ErgbPRcOkC74CglPLGu2JECZhXQ51azWr
	v8BDShQNqyraxP5DxPUjHzuvrrVfgSM5HdyndowOlJb9AB0upr1YyGn3K8lkK4VM
	yq55mw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna2gdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 08:16:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48N8GJPk015333;
	Mon, 23 Sep 2024 08:16:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna2gdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 08:16:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7kwhx012524;
	Mon, 23 Sep 2024 08:16:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpncr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 08:16:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48N8GHf546858508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 08:16:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C4D5804B;
	Mon, 23 Sep 2024 08:16:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0656C5805B;
	Mon, 23 Sep 2024 08:16:16 +0000 (GMT)
Received: from [9.171.49.240] (unknown [9.171.49.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2024 08:16:15 +0000 (GMT)
Message-ID: <a4cf0e03-98b7-49a5-bbb6-040fc41aa2d6@linux.ibm.com>
Date: Mon, 23 Sep 2024 10:16:14 +0200
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: Cong Wang <xiyou.wangcong@gmail.com>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
        Jan Karcher <jaka@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
 <ZuTehlEoyi4PPmQA@pop-os.localdomain>
 <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>
 <ZuUDv8PLR4FHg+oC@pop-os.localdomain>
 <ad8da8d1-4ae4-41e2-a047-e4adc4c044f5@linux.alibaba.com>
 <027597ba-4dc8-4837-975a-be23babb710b@redhat.com>
 <c0e266d6-3421-4d48-a3fc-7757bfddf0fa@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <c0e266d6-3421-4d48-a3fc-7757bfddf0fa@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: geWesxLvCUqYUVtFv8KuAFX9TEGd4rfD
X-Proofpoint-ORIG-GUID: sScRTU1W2yZkr8y1GQmx3LwN2YBVQ98l
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230060



On 19.09.24 17:46, D. Wythe wrote:
> 
> 
> On 9/19/24 5:30 PM, Paolo Abeni wrote:
>> Hi,
>> On 9/18/24 04:23, D. Wythe wrote:
>>> On 9/14/24 11:32 AM, Cong Wang wrote:
>>>> On Sat, Sep 14, 2024 at 10:28:15AM +0800, D. Wythe wrote:
>>>>>
>>>>>
>>>>> On 9/14/24 8:53 AM, Cong Wang wrote:
>>>>>> On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/12/24 8:04 AM, Cong Wang wrote:
>>>>>>>> From: Cong Wang <cong.wang@bytedance.com>
>>>>>>>>
>>>>>>>> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
>>>>>>>> RCU version, which are netdev_walk_all_lower_dev_rcu() and
>>>>>>>> netdev_next_lower_dev_rcu(). Switching to the RCU version would
>>>>>>>> eliminate the need for RTL lock, thus could amend the deadlock
>>>>>>>> complaints from syzbot. And it could also potentially speed up its
>>>>>>>> callers like smc_connect().
>>>>>>>>
>>>>>>>> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
>>>>>>>> Closes: 
>>>>>>>> https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
>>>>>>>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
>>>>>>>> Cc: Jan Karcher <jaka@linux.ibm.com>
>>>>>>>> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>>> Cc: Tony Lu <tonylu@linux.alibaba.com>
>>>>>>>> Cc: Wen Gu <guwen@linux.alibaba.com>
>>>>>>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>>>>>>
>>>>>>>
>>>>>>> Haven't looked at your code yet, but the issue you fixed doesn't 
>>>>>>> exist.
>>>>>>> The real reason is that we lacks some lockdep annotations for
>>>>>>> IPPROTO_SMC.
>>>>>>
>>>>>> If you look at the code, it is not about sock lock annotations, it is
>>>>>> about RTNL lock which of course has annotations.
>>>>>>
>>>>>
>>>>> If so, please explain the deadlock issue mentioned in sysbot and
>>>>> how it triggers deadlocks.
>>>>
>>>> Sure, but what questions do you have here? To me, the lockdep output is
>>>> self-explained. Please kindly let me know if you have any troubles
>>>> understanding it, I am always happy to help.
>>>>
>>>> Thanks.
>>>
>>> Just explain 
>>> (https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f)
>>>
>>> -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
>>>          lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
>>>          lock_sock include/net/sock.h:1607 [inline]
>>>          sockopt_lock_sock net/core/sock.c:1061 [inline]
>>>          sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
>>>          do_ipv6_setsockopt+0x216a/0x47b0 net/ipv6/ipv6_sockglue.c:567
>>>          ipv6_setsockopt+0xe3/0x1a0 net/ipv6/ipv6_sockglue.c:993
>>>          udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
>>>          do_sock_setsockopt+0x222/0x480 net/socket.c:2324
>>>          __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
>>>          __do_sys_setsockopt net/socket.c:2356 [inline]
>>>          __se_sys_setsockopt net/socket.c:2353 [inline]
>>>          __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
>>>          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>          do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> Why is that udpv6_setsockopt was reported here.
>>
>> If I read correctly, your doubt is somewhat alike the following: the 
>> SMC code does not call UDP sockopt-related function, so the above 
>> stacktrace refers to a non SMC socket and the reported splat is really 
>> harmless, as no deadlock will really happens (UDP sockets do not 
>> acquire nested rtnl lock, smc does not acquire nested socket lock).
>>
>> Still the splat happens we need - or at least we should - address it, 
>> because this splat prevents syzkaller from finding other possibly more 
>> significant issues.
>>
>> One way for addressing the splat would be adding the proper annotation 
>> to the socket lock. Another way is the present patch, which looks 
>> legit to me and should give performances benefit (every time we don't 
>> need to acquire the rtnl lock is a win!)
>>
>> @Wythe: does the above clarify a bit?
>>
>> Thanks!
>>
>> Paolo
> 
> 
> Hi Paolo,
> 
> Thanks for your explanation. I did not question the value of this patch,
> I just think that it did not fix a deadlock issue as it described. What 
> it really does
> is to avoid a false position from syzbot, and also has brought potential 
> performance
> benefits, which I totally agree with.
> 
> 
> Last week, we also discussed this issue with Eric. In fact, we already 
> have a patch
> that addresses this problem by modifying the lockdep class of 
> IPPROTO_SMC. However,
> I'm not entirely satisfied with this change because I prefer that 
> IPPROTO_SMC socks remain consistent with other AF_INET socks. So, it 
> appears that this patch is the best solution now.
> 
> Anyway, I support this patch now. But I believe the description needs to 
> be more accurate.
> 
> Thanks,
> D. Wythe
> 
> 

I like the idea with the RCU version and it might solve the issue what 
the syzbot reported. However, I also agree with D. Wythe on lack of 
accurate description regarding this issue itself. That means where is 
the knot and how the RCU version solves the knot. That would also help 
people solve the similar problem later.
@Cong Wang, could you please add a bit more description I mentioned above?

Thanks,
Wenjia

