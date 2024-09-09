Return-Path: <netdev+bounces-126499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B84971886
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E0E284504
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433601B652C;
	Mon,  9 Sep 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="brtpyPGb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868113BAF1;
	Mon,  9 Sep 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882301; cv=none; b=lldn25x2syvRBF9GYVYoy8MNXk8IeXfV0Dhf7nXcJaCZxpnHaFsrpQRD9ZWVTdtXeMsYFyn1j1kzIfTyRfjz4mS4Hf48dDDhYluLiBzuqgQlKGguCYtJs9QOsRmehEVbMjw8eDSEB1YhiUhhyhBefU5ETJ/z+HyHCHx94052MRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882301; c=relaxed/simple;
	bh=cpxa115dSKPJK+fxDv23U7BAWj+yTmH1FnJt+cImBy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SXy/ntFwk3A5bOjOipnesPAbxDoq/mjLFneYUqeYIpAx8SNViA53MhO6jcn89pBK1ovlfJWlPxdRUNe+wkOZ6crZHaVPBWPR5/SXouwpI0I7MBVCrmIgjR6HPqojDtvEzxn1BsOaTZ8EN6ILVFCuTdcwi/4IdS546DOXkl39dRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=brtpyPGb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4895bkeo026280;
	Mon, 9 Sep 2024 11:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	EKpZJnWA+z1QHjipQrYWcV9tDnVXfz75oAnSOQxVmmk=; b=brtpyPGbWKM6eAiP
	sppUVne+hVHPTMgK1uGInJUWQKi3w7fIDoVBl9k7HE7duTuLIypq7ICr6+Gf35/n
	MHlG0VUl7kU2eXGsfNd6rg8tVvC/U2/CeYi5JGN4vL1zLcFOOV4WUPNy1PpuiXjQ
	RPLr2dJ82Xu4hvHssPj5PNkILABasnf1W41ESdmBz+tbsQfVN0TDIuOdrz26rqwP
	Zq1IUvbmXyrbabogE33/tkUIjgK1rebKYbOy+cz+lbUrLsm1ZPXH7IE3DenFVrNE
	tGJQH3WkacATD2/Ex4qsKaeVNXQiCQ2XfbPwBGdvhVpeceLTKyKFvcpidm4aXuyN
	n5/K1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8q1upe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 11:44:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489BinZ6027781;
	Mon, 9 Sep 2024 11:44:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8q1up8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 11:44:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4897knen032088;
	Mon, 9 Sep 2024 11:44:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nme3nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 11:44:48 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 489BilL342533362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 11:44:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB395805A;
	Mon,  9 Sep 2024 11:44:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA1358051;
	Mon,  9 Sep 2024 11:44:46 +0000 (GMT)
Received: from [9.179.2.30] (unknown [9.179.2.30])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 11:44:45 +0000 (GMT)
Message-ID: <17dc89d6-5079-4e99-9058-829a07eb773f@linux.ibm.com>
Date: Mon, 9 Sep 2024 13:44:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
To: Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <0000000000000311430620013217@google.com>
 <0000000000005d1b320621973380@google.com>
 <CANn89iJGw2EVw0V5HUs9-CY4f8FucYNgQyjNXThE6LLkiKRqUA@mail.gmail.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <CANn89iJGw2EVw0V5HUs9-CY4f8FucYNgQyjNXThE6LLkiKRqUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2pM3rl-ohOAC40ugpepdRdaOxNFS284f
X-Proofpoint-ORIG-GUID: 6BeQvvT677gVLb45C7THT4SZo4cg_ojM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090092



On 09.09.24 10:02, Eric Dumazet wrote:
> On Sun, Sep 8, 2024 at 10:12 AM syzbot
> <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    df54f4a16f82 Merge branch 'for-next/core' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12bdabc7980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1798589f980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a30e00580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/aa2eb06e0aea/disk-df54f4a1.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/14728733d385/vmlinux-df54f4a1.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/99816271407d/Image-df54f4a1.gz.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0 Not tainted
>> ------------------------------------------------------
>> syz-executor272/6388 is trying to acquire lock:
>> ffff8000923b6ce8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
>>
>> but task is already holding lock:
>> ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
>>         __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>>         __mutex_lock kernel/locking/mutex.c:752 [inline]
>>         mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>>         smc_switch_to_fallback+0x48/0xa80 net/smc/af_smc.c:902
>>         smc_sendmsg+0xfc/0x9f8 net/smc/af_smc.c:2779
>>         sock_sendmsg_nosec net/socket.c:730 [inline]
>>         __sock_sendmsg net/socket.c:745 [inline]
>>         __sys_sendto+0x374/0x4f4 net/socket.c:2204
>>         __do_sys_sendto net/socket.c:2216 [inline]
>>         __se_sys_sendto net/socket.c:2212 [inline]
>>         __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2212
>>         __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>         invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>>         el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>         do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>         el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>>         el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>>         el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>>
>> -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
>>         lock_sock_nested net/core/sock.c:3543 [inline]
>>         lock_sock include/net/sock.h:1607 [inline]
>>         sockopt_lock_sock+0x88/0x148 net/core/sock.c:1061
>>         do_ip_setsockopt+0x1438/0x346c net/ipv4/ip_sockglue.c:1078
>>         ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
>>         raw_setsockopt+0x100/0x294 net/ipv4/raw.c:845
>>         sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
>>         do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
>>         __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
>>         __do_sys_setsockopt net/socket.c:2356 [inline]
>>         __se_sys_setsockopt net/socket.c:2353 [inline]
>>         __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
>>         __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>         invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>>         el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>         do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>         el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>>         el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>>         el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>>
>> -> #0 (rtnl_mutex){+.+.}-{3:3}:
>>         check_prev_add kernel/locking/lockdep.c:3133 [inline]
>>         check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>>         validate_chain kernel/locking/lockdep.c:3868 [inline]
>>         __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
>>         lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
>>         __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>>         __mutex_lock kernel/locking/mutex.c:752 [inline]
>>         mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>>         rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
>>         do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
>>         ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
>>         tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
>>         sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
>>         smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
>>         do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
>>         __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
>>         __do_sys_setsockopt net/socket.c:2356 [inline]
>>         __se_sys_setsockopt net/socket.c:2353 [inline]
>>         __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
>>         __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>         invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>>         el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>         do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>         el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>>         el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>>         el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>    rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock
>>
>>   Possible unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(&smc->clcsock_release_lock);
>>                                 lock(sk_lock-AF_INET);
>>                                 lock(&smc->clcsock_release_lock);
>>    lock(rtnl_mutex);
>>
>>   *** DEADLOCK ***
>>
>> 1 lock held by syz-executor272/6388:
>>   #0: ffff0000dc408a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x178/0x10fc net/smc/af_smc.c:3064
>>
>> stack backtrace:
>> CPU: 1 UID: 0 PID: 6388 Comm: syz-executor272 Not tainted 6.11.0-rc5-syzkaller-gdf54f4a16f82 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>> Call trace:
>>   dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
>>   show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
>>   __dump_stack lib/dump_stack.c:93 [inline]
>>   dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
>>   dump_stack+0x1c/0x28 lib/dump_stack.c:128
>>   print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2059
>>   check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2186
>>   check_prev_add kernel/locking/lockdep.c:3133 [inline]
>>   check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>>   validate_chain kernel/locking/lockdep.c:3868 [inline]
>>   __lock_acquire+0x33d8/0x779c kernel/locking/lockdep.c:5142
>>   lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
>>   __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:608
>>   __mutex_lock kernel/locking/mutex.c:752 [inline]
>>   mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
>>   rtnl_lock+0x20/0x2c net/core/rtnetlink.c:79
>>   do_ip_setsockopt+0xe8c/0x346c net/ipv4/ip_sockglue.c:1077
>>   ip_setsockopt+0x80/0x128 net/ipv4/ip_sockglue.c:1417
>>   tcp_setsockopt+0xcc/0xe8 net/ipv4/tcp.c:3768
>>   sock_common_setsockopt+0xb0/0xcc net/core/sock.c:3735
>>   smc_setsockopt+0x204/0x10fc net/smc/af_smc.c:3072
>>   do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2324
>>   __sys_setsockopt+0x128/0x1a8 net/socket.c:2347
>>   __do_sys_setsockopt net/socket.c:2356 [inline]
>>   __se_sys_setsockopt net/socket.c:2353 [inline]
>>   __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2353
>>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>>   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>>   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>>   el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>>   el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>>   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
>>
>>
>> ---
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> Please SMC folks, can you take a look ?

Hi Eric,

Thank you for the reminder! We'll look into it ASAP!

Thanks,
Wenjia

