Return-Path: <netdev+bounces-121917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5D95F3A4
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B4C283C5B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D9189509;
	Mon, 26 Aug 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbGx9wE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0C179958;
	Mon, 26 Aug 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681607; cv=none; b=mMxNPhVCIklJVB7LZOp00qCFA7UBaz5h10xUGya1uGN4dYi6swghbKf7VlUaGEHHvzZnXp3vAuUdCSlhsS2gDyk5ZY8QLD/C17hv6EhV7nNQ/+N8pW0ZPcFba4O4GfaxY3VXAiXi6wTatEV8AwWSZjUaC9guY0vnEgYMs3s3GLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681607; c=relaxed/simple;
	bh=QCcs8wBKdqoYLMAkxvwXv3c4J0Jcy1GTkzyAT1NhmmA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kbb4vSZU71t8qDwK/uoPU0JzmcW2QGcxYCvK4/njE9JlGt6jBetGmhH7/FS6pH7TUKNNpmYVkfIfnzVY1l8dDsEnLPKdZKcEnzp3Yx5C5tZQkwiruyp/Z9zcDVhYbENyrck257XbxbH7yXH4ozeRGSMP9SZW96jKgr/RwmApF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbGx9wE8; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-4fd011819e2so1718754e0c.1;
        Mon, 26 Aug 2024 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724681602; x=1725286402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qLvDduxLo/EjlLkfP2KNa0QuhaooYIqxL+QpTS0QI6o=;
        b=NbGx9wE8dQvxlsNxuFJVa7g1foIaQPE44GxMqO+ACKr1xBolgxQJy5cnbDCtlRX3u8
         FAATBjapJuLm/P9P3SGDIMv2QrvP2pkKDNCXbBcJ0KO+Tq36QcaFwyS3DkvBWS4M68WK
         A/c0lsumGg+6TGUftymUgBl0xVg4MXjh7XXvYDSa+Q7TpERjXe2o6Fj0i1wQMuQDbhDb
         q4M3ihN3331aXaRLWaoOS0TsdZktT0QSHu0S+XM8bSqZiC5FsiJhq7WozYkQsdlVRxCK
         T400l+XwnpTOVtGZl/IhEOVum6t5Tl9iFu7DR5vhr+/xntNFIJYsm1yXiiXqzMDbQv5P
         7wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681602; x=1725286402;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLvDduxLo/EjlLkfP2KNa0QuhaooYIqxL+QpTS0QI6o=;
        b=MKrfKiGBc/JunkU8jwYR4Tx+bpSk0hPba3mztNF/fUiCbIo8XqmgvWQ4f8hBR458hr
         L/XsVQncKh2BC6GNlQIkq5UKKVH7Yy3K9yMJ8EHYjMoL3jELoyAHnXjVce9jnmzn4Muk
         oNXXJ3v0VfHgkO3OVNSWfJNwChmYV5unD5PLozkzTgiu0tg1ORgeG0CwFar1OxqVYbPT
         0La1atsWXv7fhdvQQJ9ICX1nOJJWK3pk2fbHGw/WX9MnrdPQT7JMKBjJ/8yyGbOw9qJK
         9/EcVfjLgZ7QytbGEmFbBvKPrlZHp/r5G4BDZPtR5fhwAzJ+q/WX5f2NJu7uOfmRJ/KO
         MiAA==
X-Forwarded-Encrypted: i=1; AJvYcCXfFpIO3sVkiPXHiBLo4ce99lO2FSfEm95X5+Xeyw6WlWananDh0OGfx86zs2Z0agK2c6A70Ep9e+kezzk=@vger.kernel.org, AJvYcCXrKuPjs+8JzmdDCTi1iWu7xaK0Ms+F8bN+DeSNvIyySFVdvfX/f5w4TeIlSvp5N7/Xr+4W0iMR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YIbtJerGXrZsRNUPOUABJV8DgrMrSYlLdL37oFi+zmAt1iB7
	mxVadkm4LlbvUV7I0FByZnNRnizNultDof6g9TlZp3VjB2fa2pvzpTf1wymCA06ZPqfD30TJCN6
	s117+xPHz2ES+DC1Bn4W2kCqGRKU=
X-Google-Smtp-Source: AGHT+IHcIv5BHcCN81gmKoWx97gc5E41BAIBWGM6feS9evej34u7UljxIBnPQiI3Fh2hx6u3PoR6wLfbC10zlcAKfLY=
X-Received: by 2002:a05:6122:2505:b0:4fc:e5c6:be51 with SMTP id
 71dfb90a1353d-4fd1a5180ddmr12751340e0c.3.1724681601476; Mon, 26 Aug 2024
 07:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Mon, 26 Aug 2024 22:13:10 +0800
Message-ID: <CAHOo4gJRxYjEmQmCv7HRq4yB-AX_0f=ojLmU8PWrmjEhkO+srg@mail.gmail.com>
Subject: INFO: task hung in unregister_nexthop_notifier
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Maintainers,
Our tool found the following kernel bug INFO: task hung in
unregister_nexthop_notifier on:
HEAD Commit: 6e4436539ae182dc86d57d13849862bcafaa4709 Merge tag
'hid-for-linus-2024081901' of
git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
console output:
https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436539ae182dc86d57d13849862bcafaa4709/6548016d46a859fa33565086216fc61c6696a59e/log0
kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/.config
repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436539ae182dc86d57d13849862bcafaa4709/6548016d46a859fa33565086216fc61c6696a59e/repro0
syz repro: no
C reproducer: no
Unfortunately, I don't have any reproducer for this issue yet.

Please let me know if there is anything I can help.

Best,
HuiGuo

====================================[cut
here]===========================================
INFO: task kworker/u8:5:133 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:21328 pid:133   tgid:133   ppid:2
   flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 unregister_nexthop_notifier+0x19/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/nexthop.c:3900
 nsim_fib_destroy+0x84/0x1b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/fib.c:1656
 nsim_dev_reload_destroy+0x16a/0x490
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:1662
 nsim_dev_reload_down+0x6f/0xe0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:965
 devlink_reload+0x189/0x780
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x195/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:509
 ops_pre_exit_list
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/net_namespace.c:163
[inline]
 cleanup_net+0x474/0xbb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/net_namespace.c:620
 process_one_work+0x95a/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3231
 process_scheduled_works
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3312
[inline]
 worker_thread+0x680/0xeb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3390
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:10:2961 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:10   state:D stack:22176 pid:2961  tgid:2961  ppid:2
   flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 addrconf_dad_work+0xad/0x1510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv6/addrconf.c:4194
 process_one_work+0x95a/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3231
 process_scheduled_works
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3312
[inline]
 worker_thread+0x680/0xeb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3390
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:12:2990 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:12   state:D stack:24208 pid:2990  tgid:2990  ppid:2
   flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 linkwatch_event+0xf/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/link_watch.c:276
 process_one_work+0x95a/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3231
 process_scheduled_works
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3312
[inline]
 worker_thread+0x680/0xeb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3390
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.15:8538 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.15 state:D stack:22752 pid:8538  tgid:8538
ppid:8404   flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 xt_find_table_lock+0x59/0x500
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netfilter/x_tables.c:1243
 xt_request_find_table_lock+0x2b/0x100
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netfilter/x_tables.c:1285
 get_info+0x169/0x6d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/netfilter/ip_tables.c:963
 do_ipt_get_ctl+0x160/0xa20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/netfilter/ip_tables.c:1659
 nf_getsockopt+0x7c/0xd0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x191/0x1f0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/ip_sockglue.c:1777
 tcp_getsockopt+0xa3/0x110
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/tcp.c:4409
 do_sock_getsockopt+0x2eb/0x7c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2386
 __sys_getsockopt+0x19e/0x280
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2415
 __do_sys_getsockopt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2425
[inline]
 __se_sys_getsockopt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2422
[inline]
 __x64_sys_getsockopt+0xbd/0x160
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2422
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7e410b1dae
RSP: 002b:00007ffeb165f818 EFLAGS: 00000206 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7e410b1dae
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffeb165f840 R08: 00007ffeb165f83c R09: 00007ffeb165fda0
R10: 00007ffeb165f840 R11: 0000000000000206 R12: 0000000000000003
R13: 00007ffeb165f83c R14: 0000000000000000 R15: 00007f7e411cac00
 </TASK>
INFO: task syz-executor.10:14670 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.10 state:D stack:19056 pid:14670 tgid:14670
ppid:14587  flags:0x00004002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 nsim_destroy+0x6b/0x6a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/netdev.c:773
 __nsim_dev_port_del+0x189/0x240
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:1437
[inline]
 nsim_dev_reload_destroy+0x105/0x490
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:1658
 nsim_drv_remove+0x52/0x1d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:1673
 device_remove+0xcb/0x170
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/dd.c:566
 __device_release_driver
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/dd.c:1272
[inline]
 device_release_driver_internal+0x443/0x620
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/bus.c:574
 device_del+0x395/0x9d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/core.c:3871
 device_unregister+0x1e/0xc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/core.c:3912
 nsim_bus_dev_del
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/bus.c:462
[inline]
 del_device_store+0x34e/0x4b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/bus.c:226
 bus_attr_store+0x79/0xa0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/bus.c:170
 sysfs_kf_write+0x117/0x170
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x33e/0x500
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/kernfs/file.c:334
 new_sync_write
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/read_write.c:497
[inline]
 vfs_write+0xbf7/0x10d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/read_write.c:590
 ksys_write+0x122/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/read_write.c:643
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5510ae84f
RSP: 002b:00007ffd5aafb000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe5510ae84f
RDX: 0000000000000002 RSI: 00007ffd5aafb050 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000000 R09: 00007ffd5aafafa0
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fe55110b0e5
R13: 00007ffd5aafb050 R14: 0000000000000000 R15: 00007ffd5aafbc30
 </TASK>
INFO: task syz-executor.8:14986 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.8  state:D stack:21312 pid:14986 tgid:14986
ppid:14792  flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 rtnl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x168/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1331
[inline]
 netlink_unicast+0x547/0x800
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8a5/0xd80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:730
[inline]
 __sock_sendmsg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:745
[inline]
 __sys_sendto+0x4b7/0x510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2204
 __do_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2216
[inline]
 __se_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
[inline]
 __x64_sys_sendto+0xe0/0x1c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc304eb1f16
RSP: 002b:00007ffe725fabf0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc305b14620 RCX: 00007fc304eb1f16
RDX: 0000000000000028 RSI: 00007fc305b14670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffe725fac4c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fc305b14670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.14:15021 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.14 state:D stack:22016 pid:15021 tgid:15021
ppid:14799  flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 rtnl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x168/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1331
[inline]
 netlink_unicast+0x547/0x800
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8a5/0xd80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:730
[inline]
 __sock_sendmsg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:745
[inline]
 __sys_sendto+0x4b7/0x510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2204
 __do_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2216
[inline]
 __se_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
[inline]
 __x64_sys_sendto+0xe0/0x1c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a5deb1f16
RSP: 002b:00007ffdfce2ad30 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f3a5eb14620 RCX: 00007f3a5deb1f16
RDX: 0000000000000028 RSI: 00007f3a5eb14670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffdfce2ad8c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f3a5eb14670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.11:15032 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.11 state:D stack:21120 pid:15032 tgid:15032
ppid:14787  flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 rtnl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x168/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1331
[inline]
 netlink_unicast+0x547/0x800
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8a5/0xd80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:730
[inline]
 __sock_sendmsg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:745
[inline]
 __sys_sendto+0x4b7/0x510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2204
 __do_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2216
[inline]
 __se_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
[inline]
 __x64_sys_sendto+0xe0/0x1c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfee2b1f16
RSP: 002b:00007ffe27811f20 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fcfeef14620 RCX: 00007fcfee2b1f16
RDX: 0000000000000068 RSI: 00007fcfeef14670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffe27811f7c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fcfeef14670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.1:15050 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:21296 pid:15050 tgid:15050
ppid:14801  flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 rtnl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x168/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1331
[inline]
 netlink_unicast+0x547/0x800
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8a5/0xd80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:730
[inline]
 __sock_sendmsg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:745
[inline]
 __sys_sendto+0x4b7/0x510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2204
 __do_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2216
[inline]
 __se_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
[inline]
 __x64_sys_sendto+0xe0/0x1c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a5d4b1f16
RSP: 002b:00007fff52efc0b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0a5e114620 RCX: 00007f0a5d4b1f16
RDX: 0000000000000028 RSI: 00007f0a5e114670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007fff52efc10c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f0a5e114670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
INFO: task syz-executor.12:15052 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.12 state:D stack:20176 pid:15052 tgid:15052
ppid:14790  flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 rtnl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x168/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1331
[inline]
 netlink_unicast+0x547/0x800
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8a5/0xd80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:730
[inline]
 __sock_sendmsg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:745
[inline]
 __sys_sendto+0x4b7/0x510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2204
 __do_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2216
[inline]
 __se_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
[inline]
 __x64_sys_sendto+0xe0/0x1c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e016b1f16
RSP: 002b:00007ffe129a67d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f6e02314620 RCX: 00007f6e016b1f16
RDX: 0000000000000028 RSI: 00007f6e02314670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffe129a682c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f6e02314670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz-executor.13:15055 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.13 state:D stack:19696 pid:15055 tgid:15055
ppid:14794  flags:0x00000002
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 rtnl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x168/0x420
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1331
[inline]
 netlink_unicast+0x547/0x800
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8a5/0xd80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:730
[inline]
 __sock_sendmsg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:745
[inline]
 __sys_sendto+0x4b7/0x510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2204
 __do_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2216
[inline]
 __se_sys_sendto
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
[inline]
 __x64_sys_sendto+0xe0/0x1c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2212
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf404b1f16
RSP: 002b:00007ffece51d6c0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fdf41114620 RCX: 00007fdf404b1f16
RDX: 0000000000000028 RSI: 00007fdf41114670 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffece51d71c R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fdf41114670 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz-executor.3:17661 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28208 pid:17661 tgid:17655
ppid:8419   flags:0x00004006
Call Trace:
 <TASK>
 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
 __mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
 __mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
 br_ioctl_stub+0x98/0x870
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/bridge/br_ioctl.c:402
 br_ioctl_call+0x65/0xb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:1195
 sock_ioctl+0x3a2/0x6d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:1295
 vfs_ioctl data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:51
[inline]
 __do_sys_ioctl
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:907
[inline]
 __se_sys_ioctl
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:893
[inline]
 __x64_sys_ioctl+0x1a4/0x210
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:893
 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7245eafb2d
RSP: 002b:00007f7246cce028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7245fece80 RCX: 00007f7245eafb2d
RDX: 0000000020005e40 RSI: 00000000000089a1 RDI: 0000000000000003
RBP: 00007f7245f0b4a1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7245fece80 R15: 00007f7246cae000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
2 locks held by systemd/1:
 #0: ffff888023b87340 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff888023b87340 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by kworker/0:1/10:
1 lock held by khungtaskd/30:
 #0: ffffffff8dbb8c60 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/rcupdate.h:326
[inline]
 #0: ffffffff8dbb8c60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/rcupdate.h:838
[inline]
 #0: ffffffff8dbb8c60 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x75/0x340
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/lockdep.c:6626
2 locks held by kswapd0/88:
2 locks held by kswapd1/89:
6 locks held by kworker/u8:5/133:
 #0: ffff8880162de148 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
 #1: ffffc90001b77d88 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
 #2: ffffffff8f7f70d0 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0xbb/0xbb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/net_namespace.c:594
 #3: ffff888011b360e8 (&dev->mutex){....}-{3:3}, at: device_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/device.h:1009
[inline]
 #3: ffff888011b360e8 (&dev->mutex){....}-{3:3}, at: devl_dev_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/devl_internal.h:108
[inline]
 #3: ffff888011b360e8 (&dev->mutex){....}-{3:3}, at:
devlink_pernet_pre_exit+0x120/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:506
 #4: ffff888021baf250 (&devlink->lock_key#12){+.+.}-{3:3}, at:
devl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:276
[inline]
 #4: ffff888021baf250 (&devlink->lock_key#12){+.+.}-{3:3}, at:
devl_dev_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/devl_internal.h:109
[inline]
 #4: ffff888021baf250 (&devlink->lock_key#12){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x12a/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:506
 #5: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
unregister_nexthop_notifier+0x19/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/nexthop.c:3900
3 locks held by kworker/u8:10/2961:
 #0: ffff88801a763148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
 #1: ffffc9000a1e7d88
((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
 #2: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
addrconf_dad_work+0xad/0x1510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv6/addrconf.c:4194
3 locks held by kworker/u8:12/2990:
 #0: ffff888015481148 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
 #1: ffffc9000a367d88 ((linkwatch_work).work){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
 #2: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
linkwatch_event+0xf/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/link_watch.c:276
2 locks held by systemd-journal/4679:
 #0: ffff88802605cb60 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff88802605cb60 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
1 lock held by systemd-udevd/4692:
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by cron/7830:
 #0: ffff888023b87340 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff888023b87340 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by in:imklog/7893:
 #0: ffff8880239bdf50 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff8880239bdf50 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-fuzzer/8352:
 #0: ffff8880006c1988 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff8880006c1988 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-fuzzer/8408:
 #0: ffff8880006c1988 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff8880006c1988 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-fuzzer/14879:
 #0: ffff8880006c1988 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff8880006c1988 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-executor.3/8419:
 #0: ffff88802b5a4168 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
 #0: ffff88802b5a4168 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-executor.0/8420:
 #0: ffff88801af48308 (&xt[i].mutex){+.+.}-{3:3}, at:
xt_find_table_lock+0x59/0x500
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netfilter/x_tables.c:1243
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
4 locks held by syz-executor.9/8462:
 #0: ffffffff8dcc73d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:635
[inline]
 #0: ffffffff8dcc73d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1672
[inline]
 #0: ffffffff8dcc73d0 (dup_mmap_sem){.+.+}-{0:0}, at:
copy_mm+0x402/0x2740
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1721
 #1: ffff888020228b18 (&mm->mmap_lock){++++}-{3:3}, at:
mmap_write_lock_killable
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/mmap_lock.h:122
[inline]
 #1: ffff888020228b18 (&mm->mmap_lock){++++}-{3:3}, at: dup_mmap
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:636
[inline]
 #1: ffff888020228b18 (&mm->mmap_lock){++++}-{3:3}, at: dup_mm
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1672
[inline]
 #1: ffff888020228b18 (&mm->mmap_lock){++++}-{3:3}, at:
copy_mm+0x420/0x2740
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1721
 #2: ffff88802236d718 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
mmap_write_lock_nested
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/mmap_lock.h:113
[inline]
 #2: ffff88802236d718 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:645
[inline]
 #2: ffff88802236d718 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mm
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1672
[inline]
 #2: ffff88802236d718 (&mm->mmap_lock/1){+.+.}-{3:3}, at:
copy_mm+0x471/0x2740
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1721
 #3: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #3: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #3: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #3: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
1 lock held by syz-executor.2/8488:
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #0: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
1 lock held by syz-executor.15/8538:
 #0: ffff88801af48308 (&xt[i].mutex){+.+.}-{3:3}, at:
xt_find_table_lock+0x59/0x500
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/netfilter/x_tables.c:1243
3 locks held by kworker/0:8/13624:
 #0: ffff888015478948 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
 #1: ffffc90029f2fd88 (deferred_process_work){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
 #2: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
switchdev_deferred_process_work+0xe/0x20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/switchdev/switchdev.c:104
7 locks held by syz-executor.10/14670:
 #0: ffff88801e7d0420 (sb_writers#5){.+.+}-{0:0}, at:
ksys_write+0x122/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/read_write.c:643
 #1: ffff888018bd1c88 (&of->mutex#2){+.+.}-{3:3}, at:
kernfs_fop_write_iter+0x280/0x500
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/kernfs/file.c:325
 #2: ffff88801b09ca58 (kn->active#65){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x2a4/0x500
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/kernfs/file.c:326
 #3: ffffffff8edb08e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at:
del_device_store+0xc9/0x4b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/bus.c:216
 #4: ffff888012ec20e8 (&dev->mutex){....}-{3:3}, at: device_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/device.h:1009
[inline]
 #4: ffff888012ec20e8 (&dev->mutex){....}-{3:3}, at:
__device_driver_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/dd.c:1094
[inline]
 #4: ffff888012ec20e8 (&dev->mutex){....}-{3:3}, at:
device_release_driver_internal+0xa4/0x620
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/dd.c:1292
 #5: ffff8880264ca250 (&devlink->lock_key#16){+.+.}-{3:3}, at:
nsim_drv_remove+0x4a/0x1d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
nsim_destroy+0x6b/0x6a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/netdev.c:773
1 lock held by syz-executor.8/14986:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
2 locks held by syz-executor.7/15002:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
 #1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
1 lock held by syz-executor.14/15021:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.11/15032:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.1/15050:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.12/15052:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.13/15055:
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
 #0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
2 locks held by syz-executor.3/17661:
 #0: ffffffff8f7e2768 (br_ioctl_mutex){+.+.}-{3:3}, at:
br_ioctl_call+0x3f/0xb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:1193
 #1: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
br_ioctl_stub+0x98/0x870
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/bridge/br_ioctl.c:402
2 locks held by kworker/u8:11/17690:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted
6.11.0-rc4-00008-g6e4436539ae1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/dump_stack.c:93
[inline]
 dump_stack_lvl+0x116/0x1b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/dump_stack.c:119
 nmi_cpu_backtrace+0x2a0/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/nmi.h:162
[inline]
 check_hung_uninterruptible_tasks
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/hung_task.c:223
[inline]
 watchdog+0xe5b/0x1180
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/hung_task.c:379
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 88 Comm: kswapd0 Not tainted
6.11.0-rc4-00008-g6e4436539ae1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kcov.c:209
Code: be b0 01 00 00 e8 a0 ff ff ff 31 c0 e9 c9 3c 6c 09 66 0f 1f 84
00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f
1e fa 65 48 8b 15 04 d9 79 7e 65 8b 05 05 d9 79 7e a9 00 01
RSP: 0018:ffffc90000eb79a8 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff8880241bc630 RCX: ffffffff81c5737a
RDX: ffff8880190e0000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff2870ee0
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888021bb2010 R14: ffff88801e896000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7245e29e00 CR3: 0000000066286000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __ref_is_percpu
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/percpu-refcount.h:174
[inline]
 percpu_ref_tryget_many
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/percpu-refcount.h:243
[inline]
 percpu_ref_tryget
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/percpu-refcount.h:266
[inline]
 css_tryget data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/cgroup_refcnt.h:45
[inline]
 mem_cgroup_tryget
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/memcontrol.h:808
[inline]
 shrink_many data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:4868
[inline]
 lru_gen_shrink_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:4954
[inline]
 shrink_node+0x288f/0x3850
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:5934
 kswapd_shrink_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:6762
[inline]
 balance_pgdat+0xba2/0x1880
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:6954
 kswapd+0x702/0xd50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:7223
 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
 </TASK>
==========================================================================================
This report is generated by reproducing the syz repro. It may contain errors.

