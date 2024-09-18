Return-Path: <netdev+bounces-128751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982C97B6C9
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 04:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A73281767
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 02:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5323627442;
	Wed, 18 Sep 2024 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sVKy+wKc"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996D3D8E
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626232; cv=none; b=g0g9Ef4KETiuaD9vhifGMIyJQj/xrfaO+ohXAWHC2bTZFRQh8XWH+YDEymSsexZ4uwlrcc/IJkb/PCRSpIaZrLmwHXsf/lbUaB7eIRIDykpqjLUhgWlsPTpZXSCZCGzghQtX+NHuMA9GFP1XzgadynWbdO5GeIKNV3RU3H3X+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626232; c=relaxed/simple;
	bh=ABT6rGN8TOPww8BfAd+4FFFiZKORE5iCUenViiN7gEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LruoHlEqO/MAYdEPiY2sE7eAz3nSatFO8cWTDWgX+gRo0AQ+amzlKOCD4kC5O5PjgUOroiyMrdU7Mq6NlBFGPqJZF9CjPoER7jTSOnXFAijcTZmBwblNtxBKaGQHWr8QQppxT7CTpLcM9pAALUYc49yPjfiFYUd+xFdkC6xQF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sVKy+wKc; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726626226; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JSGTfA6HBaAWlNaTQITKIfrl5ekOusFd9DdvS+ZqM4A=;
	b=sVKy+wKcJyTXU1h+46KN+gvlh8NULHBhWDcLVJBmvNVMbzllIYvZduwM5+b+DnQ4QvllT7FPlp7iDrc4LxjvhWIHs1iINxzQ3/g69VOi6PiZYZbQtLlUTV4BGSF/Cva5eBrh7awyQAvpB7MWBHD2z7Zbt4eHDxlHx6/vuLFdkMU=
Received: from 30.15.236.110(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WFCRkQz_1726626225)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 10:23:46 +0800
Message-ID: <ad8da8d1-4ae4-41e2-a047-e4adc4c044f5@linux.alibaba.com>
Date: Wed, 18 Sep 2024 10:23:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
 <ZuTehlEoyi4PPmQA@pop-os.localdomain>
 <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>
 <ZuUDv8PLR4FHg+oC@pop-os.localdomain>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <ZuUDv8PLR4FHg+oC@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 11:32 AM, Cong Wang wrote:
> On Sat, Sep 14, 2024 at 10:28:15AM +0800, D. Wythe wrote:
>>
>>
>> On 9/14/24 8:53 AM, Cong Wang wrote:
>>> On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
>>>>
>>>>
>>>> On 9/12/24 8:04 AM, Cong Wang wrote:
>>>>> From: Cong Wang <cong.wang@bytedance.com>
>>>>>
>>>>> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
>>>>> RCU version, which are netdev_walk_all_lower_dev_rcu() and
>>>>> netdev_next_lower_dev_rcu(). Switching to the RCU version would
>>>>> eliminate the need for RTL lock, thus could amend the deadlock
>>>>> complaints from syzbot. And it could also potentially speed up its
>>>>> callers like smc_connect().
>>>>>
>>>>> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
>>>>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
>>>>> Cc: Jan Karcher <jaka@linux.ibm.com>
>>>>> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>> Cc: Tony Lu <tonylu@linux.alibaba.com>
>>>>> Cc: Wen Gu <guwen@linux.alibaba.com>
>>>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>>>
>>>>
>>>> Haven't looked at your code yet, but the issue you fixed doesn't exist.
>>>> The real reason is that we lacks some lockdep annotations for
>>>> IPPROTO_SMC.
>>>
>>> If you look at the code, it is not about sock lock annotations, it is
>>> about RTNL lock which of course has annotations.
>>>
>>
>> If so, please explain the deadlock issue mentioned in sysbot and
>> how it triggers deadlocks.
> 
> Sure, but what questions do you have here? To me, the lockdep output is
> self-explained. Please kindly let me know if you have any troubles
> understanding it, I am always happy to help.
> 
> Thanks.

Just explain (https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f)

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
        lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
        lock_sock include/net/sock.h:1607 [inline]
        sockopt_lock_sock net/core/sock.c:1061 [inline]
        sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
        do_ipv6_setsockopt+0x216a/0x47b0 net/ipv6/ipv6_sockglue.c:567
        ipv6_setsockopt+0xe3/0x1a0 net/ipv6/ipv6_sockglue.c:993
        udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
        do_sock_setsockopt+0x222/0x480 net/socket.c:2324
        __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
        __do_sys_setsockopt net/socket.c:2356 [inline]
        __se_sys_setsockopt net/socket.c:2353 [inline]
        __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

Why is that udpv6_setsockopt was reported here.

D.





