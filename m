Return-Path: <netdev+bounces-126801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DB97290A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC40B1F24F53
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF416A955;
	Tue, 10 Sep 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XR0Ahpgr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0BBA42;
	Tue, 10 Sep 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947718; cv=none; b=uWjbViT0hW/IaCXYkoRvXJu4uEwxejXAz1qu51Zxr2tPs3aYpu8L0COXKTKPtPBFg1DSp0yVeo90Afou/yGDXzhW8PmxeXvNFhxFz0nwYtYUqRhQa02Zg/TQSw6ecQJuXzQI7KosqR4ym5HQNk9hKrNG1m5LfziwP/JC33WWnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947718; c=relaxed/simple;
	bh=jCMOo32aAOxhSAoezhGNiFwU189v3QtxX0IEdyDCFu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9DP1zY08w5fDL036pqdX7qXHtA+ebnbxiPwnx3UXBC4A9xaNkCV7i0xBvxub3OPhosVe0iVF0cwZ2mBqYglMhWp6oODudaZqyYo+ZeJM/zSe9h3DrE7tGiltSlAFbEnZwGsDp8ahaCx0DoID2r4C6fYe4LAt8BdE8eZBopGCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XR0Ahpgr; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725947707; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q0yviRGBPKBitFi3hppGbYn4wyovmBxnZN0o6fY+fTo=;
	b=XR0AhpgrPGx+V5N9odCp8VPNAGsnAdtUj3PhGllWurwvFAQ8nUn1BHt70F/ddcfaAWe6lVgWNqTWnHGfbJuSD0bss4SgmRcochoFQ6xzHfBOqLbNyd9a9VOoXcwWCFmUdWQ5N4l2yciWEZLQBKtWzIN1XH1oVhDmF4QRex/nbOw=
Received: from 30.221.149.60(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WEj560t_1725947705)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 13:55:06 +0800
Message-ID: <02634384-2468-4598-b64a-0f558730c925@linux.alibaba.com>
Date: Tue, 10 Sep 2024 13:55:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
To: Wenjia Zhang <wenjia@linux.ibm.com>, Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>,
 Dust Li <dust.li@linux.alibaba.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <0000000000000311430620013217@google.com>
 <0000000000005d1b320621973380@google.com>
 <CANn89iJGw2EVw0V5HUs9-CY4f8FucYNgQyjNXThE6LLkiKRqUA@mail.gmail.com>
 <17dc89d6-5079-4e99-9058-829a07eb773f@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <17dc89d6-5079-4e99-9058-829a07eb773f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/24 7:44 PM, Wenjia Zhang wrote:
>
>
> On 09.09.24 10:02, Eric Dumazet wrote:
>> On Sun, Sep 8, 2024 at 10:12 AM syzbot
>> <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com> wrote:
>>>
>>> syzbot has found a reproducer for the following issue on:
>>>
>>> HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into 
>>> for-kernelci
>>> git tree: 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 
>>> for-kernelci
>>> console output: 
>>> https://syzkaller.appspot.com/x/log.txt?x=12bdabc7980000
>>> kernel config: 
>>> https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
>>> dashboard link: 
>>> https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils 
>>> for Debian) 2.40
>>> userspace arch: arm64
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=1798589f980000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=10a30e00580000
>>>
>>> Downloadable assets:
>>> disk image: 
>>> https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/disk-df54f4a1.raw.xz
>>> vmlinux: 
>>> https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinux-df54f4a1.xz
>>> kernel image: 
>>> https://storage.googleapis.com/syzbot-assets/99816271407d/Image-df54f4a1.gz.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the 
>>> commit:
>>> Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com
>>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0 Not tainted
>>> ------------------------------------------------------
>>> syz-executor272/6388 is trying to acquire lock:
>>> ffff8000923b6ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x2c 
>>> net/core/rtnetlink.c:79
>>>
>>> but task is already holding lock:
>>> ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: 
>>> smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064
>>>
>>> which lock already depends on the new lock.
>>>

I have noticed this issue for a while, but I question the possibility of 
it. If I understand correctly, a deadlock issue following is reported here:

#2
lock_sock_smc
{
     clcsock_release_lock            --- deadlock
     {

     }
}

#1
rtnl_mutex
{
     lock_sock_smc
     {

     }
}

#0
clcsock_release_lock
{
     rtnl_mutex                      --deadlock
     {

     }
}

This is of course a deadlock, but #1 is suspicious.

How would this happen to a smc sock?

#1 ->
        lock_sock_nested+0x38/0xe8 net/core/sock.c:3543
        lock_sock include/net/sock.h:1607 [inline]
        sockopt_lock_sock net/core/sock.c:1061 [inline]
        sockopt_lock_sock+0x58/0x74 net/core/sock.c:1052
        do_ip_setsockopt+0xe0/0x2358 net/ipv4/ip_sockglue.c:1078
        ip_setsockopt+0x34/0x9c net/ipv4/ip_sockglue.c:1417
        raw_setsockopt+0x7c/0x2e0 net/ipv4/raw.c:845
        sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
        do_sock_setsockopt+0x17c/0x354 net/socket.c:2324

As a comparison, the correct calling chain should be:

        sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
        smc_setsockopt+0x150/0xcec net/smc/af_smc.c:3072
        do_sock_setsockopt+0x17c/0x354 net/socket.c:2324


That's to say,  any setting on SOL_IP options of smc_sock will
go with smc_setsockopt, which will try lock clcsock_release_lock at first.

Anyway, if anyone can explain #1, then we can see how to solve this problem,
otherwise I think this problem doesn't exist. (Just my opinion)

Best wishes,
D. Wythe





