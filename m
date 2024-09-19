Return-Path: <netdev+bounces-128987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108A97CBB3
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5491C21C26
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63091DFF8;
	Thu, 19 Sep 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VD7PEkSA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3933D8
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760799; cv=none; b=mNkU0YRP2oH7sM3DNjsJKocTSp8MQ42pc1mYGzuoloh0V64p71yJPFLgle/f3W5PVe8INH9Wb4WgkensgyZx5islAImEnhmvL2aCjbUqRwubJfN5O6CBndf/4gr8KhfV509OPsGDTThfTLY+1dxPzvna2KQcePK3g+LS/+bdCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760799; c=relaxed/simple;
	bh=tnALQgMa2q+Hvhklc3SBadnuNhliLdTlAIZ67rcDRyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y11QAnSOaVFx1HSw5AP9uUd2rSFS45ZFTnPZU3QYsfO+A1FbNRlB5Osm53l/+TF20TJg2ibmunE2FgoiGP0r48NNx8GS5JMfvV39MxQ+hm0RAPENn5ISV59jfj/oVR7OOdh//YTTfLxNHd9z+b7503aSq5nljFxNvjuqLBmOnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VD7PEkSA; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726760788; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CnMemErj8nH1CjbXobJv1oUFnHQI4SxCdrGR6yW5rIc=;
	b=VD7PEkSAUL38XhiHpmQB1b8g0imVuEJjppNlJri43QSaOKwQwHNZr/Hccmrn57lZaJnk9sxoDjZVhMaRAViBmbixIGtq1NBpM+o1xRj+tK+zK44/zby3aBoXsQIMI/vD/bMSOaGd5Ha/lq+B01TCFvlkVUHOw6UB9p/BKnqqHiU=
Received: from 192.168.50.173(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WFI0nhO_1726760786)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 23:46:27 +0800
Message-ID: <c0e266d6-3421-4d48-a3fc-7757bfddf0fa@linux.alibaba.com>
Date: Thu, 19 Sep 2024 23:46:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: Paolo Abeni <pabeni@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
 <ZuTehlEoyi4PPmQA@pop-os.localdomain>
 <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>
 <ZuUDv8PLR4FHg+oC@pop-os.localdomain>
 <ad8da8d1-4ae4-41e2-a047-e4adc4c044f5@linux.alibaba.com>
 <027597ba-4dc8-4837-975a-be23babb710b@redhat.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <027597ba-4dc8-4837-975a-be23babb710b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/19/24 5:30 PM, Paolo Abeni wrote:
> Hi,
> On 9/18/24 04:23, D. Wythe wrote:
>> On 9/14/24 11:32 AM, Cong Wang wrote:
>>> On Sat, Sep 14, 2024 at 10:28:15AM +0800, D. Wythe wrote:
>>>>
>>>>
>>>> On 9/14/24 8:53 AM, Cong Wang wrote:
>>>>> On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
>>>>>>
>>>>>>
>>>>>> On 9/12/24 8:04 AM, Cong Wang wrote:
>>>>>>> From: Cong Wang <cong.wang@bytedance.com>
>>>>>>>
>>>>>>> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
>>>>>>> RCU version, which are netdev_walk_all_lower_dev_rcu() and
>>>>>>> netdev_next_lower_dev_rcu(). Switching to the RCU version would
>>>>>>> eliminate the need for RTL lock, thus could amend the deadlock
>>>>>>> complaints from syzbot. And it could also potentially speed up its
>>>>>>> callers like smc_connect().
>>>>>>>
>>>>>>> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
>>>>>>> Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
>>>>>>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
>>>>>>> Cc: Jan Karcher <jaka@linux.ibm.com>
>>>>>>> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>> Cc: Tony Lu <tonylu@linux.alibaba.com>
>>>>>>> Cc: Wen Gu <guwen@linux.alibaba.com>
>>>>>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>>>>>
>>>>>>
>>>>>> Haven't looked at your code yet, but the issue you fixed doesn't exist.
>>>>>> The real reason is that we lacks some lockdep annotations for
>>>>>> IPPROTO_SMC.
>>>>>
>>>>> If you look at the code, it is not about sock lock annotations, it is
>>>>> about RTNL lock which of course has annotations.
>>>>>
>>>>
>>>> If so, please explain the deadlock issue mentioned in sysbot and
>>>> how it triggers deadlocks.
>>>
>>> Sure, but what questions do you have here? To me, the lockdep output is
>>> self-explained. Please kindly let me know if you have any troubles
>>> understanding it, I am always happy to help.
>>>
>>> Thanks.
>>
>> Just explain (https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f)
>>
>> -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
>>          lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
>>          lock_sock include/net/sock.h:1607 [inline]
>>          sockopt_lock_sock net/core/sock.c:1061 [inline]
>>          sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
>>          do_ipv6_setsockopt+0x216a/0x47b0 net/ipv6/ipv6_sockglue.c:567
>>          ipv6_setsockopt+0xe3/0x1a0 net/ipv6/ipv6_sockglue.c:993
>>          udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
>>          do_sock_setsockopt+0x222/0x480 net/socket.c:2324
>>          __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
>>          __do_sys_setsockopt net/socket.c:2356 [inline]
>>          __se_sys_setsockopt net/socket.c:2353 [inline]
>>          __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
>>          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>          do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Why is that udpv6_setsockopt was reported here.
> 
> If I read correctly, your doubt is somewhat alike the following: the SMC code does not call UDP 
> sockopt-related function, so the above stacktrace refers to a non SMC socket and the reported splat 
> is really harmless, as no deadlock will really happens (UDP sockets do not acquire nested rtnl lock, 
> smc does not acquire nested socket lock).
> 
> Still the splat happens we need - or at least we should - address it, because this splat prevents 
> syzkaller from finding other possibly more significant issues.
> 
> One way for addressing the splat would be adding the proper annotation to the socket lock. Another 
> way is the present patch, which looks legit to me and should give performances benefit (every time 
> we don't need to acquire the rtnl lock is a win!)
> 
> @Wythe: does the above clarify a bit?
> 
> Thanks!
> 
> Paolo


Hi Paolo,

Thanks for your explanation. I did not question the value of this patch,
I just think that it did not fix a deadlock issue as it described. What it really does
is to avoid a false position from syzbot, and also has brought potential performance
benefits, which I totally agree with.


Last week, we also discussed this issue with Eric. In fact, we already have a patch
that addresses this problem by modifying the lockdep class of IPPROTO_SMC. However,
I'm not entirely satisfied with this change because I prefer that IPPROTO_SMC socks remain 
consistent with other AF_INET socks. So, it appears that this patch is the best solution now.

Anyway, I support this patch now. But I believe the description needs to be more accurate.

Thanks,
D. Wythe









