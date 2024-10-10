Return-Path: <netdev+bounces-134148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79959982C5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0791F23C24
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469001BC097;
	Thu, 10 Oct 2024 09:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040A1BE86E;
	Thu, 10 Oct 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553741; cv=none; b=KRsD7jbCdngvQvJ3AczuK7fJ21lmfMg55lqhju321TIB6kWrWy3f+Gj76DYcn5+QRAttanpNijl3mPLwQSk/a3Z7ZCF4NivS8PV9iqwYsBMozalEQJs4atBNr6XWC16vIXxQwFFQ0J4z+soyKr86r1oyYUltLEIQ24Tpljpc6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553741; c=relaxed/simple;
	bh=PnF5N+fRjfIewioC2YVgyK7Bm6+yYBPxwH7/N1QgHLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cXzuhm7L0LM/0M19r0CK55A3rArW12N254F5euXSB4pty2DdhcPnY0EYylSv+iMpE39QPHQugx2cYvu4LKxmmSr/JzquiP1KYPXa55uSbzRp7wz3bWtb6v5AIk6GG5pQSI+T9gOV/lJJ8FA4YXJ1mr7lA7uW7JUw36zEMpiRv2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49A9mCMT030328;
	Thu, 10 Oct 2024 18:48:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49A9mCwE030323
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Oct 2024 18:48:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7fbdb7db-57c3-47b8-89ed-da974d03f17f@I-love.SAKURA.ne.jp>
Date: Thu, 10 Oct 2024 18:48:12 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [apparmor?] [ext4?] INFO: rcu detected stall in
 sys_getdents64
To: syzbot <syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Network Development <netdev@vger.kernel.org>
References: <6707499c.050a0220.1139e6.0017.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6707499c.050a0220.1139e6.0017.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean

This is a printk() flooding problem in bridge driver. Should consider using ratelimit.

#syz set subsystems: net

On 2024/10/10 12:27, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1083b380580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=17bc8c5157022e18da8b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f7d27980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483b380580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2ad9af7b84b4/disk-fc20a3e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1afa462ca485/vmlinux-fc20a3e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/75c0900b4786/bzImage-fc20a3e5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com
> 
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5244/1:b..l
> rcu: 	(detected by 1, t=10503 jiffies, g=5253, q=1466 ncpus=2)
> task:syz-executor116 state:R  running task     stack:18800 pid:5244  tgid:5244  ppid:5243   flags:0x00000002
(...snipped...)
> net_ratelimit: 33488 callbacks suppressed
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)


