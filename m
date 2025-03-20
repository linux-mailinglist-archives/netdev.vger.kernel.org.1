Return-Path: <netdev+bounces-176590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A55A6AF70
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1608E7AC907
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA771229B0D;
	Thu, 20 Mar 2025 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a3GJLttl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E41C68B6;
	Thu, 20 Mar 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504148; cv=none; b=KhqKUJyixa2F9/jn3VHoVnt4Cuc1Apy+MS75YcN289CUkSDnhj8m2Nz4/vR0yzzgiXyn1FdwQW/cw0nVkNFKhrFobQvG1CAlglauJesDLhhsXjcFlObV4iK+yVhAXoQaMC/IJgzuV58BODcfhikqcaZrrEqtT3WqHLqK/b3DSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504148; c=relaxed/simple;
	bh=4vjXiH0TWyBcMzjE/pO8RsYdnZX/LVEct70EIUmZKfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQEAxBfmUkGb/8Pq2wlEOAoAAYWwq701JsbZfMIizSrsqhdR7U3iY1E8BG7EB68juSa+Qt6lyjxNXih+uO1s5+No5xMVvNeCWJvOGwadr3h6dsIiNCSYR4kekbKxrx/FTaCDxnjkNfDrVEfz9ptX46WZ3g6LAioEWQLrKqJFam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a3GJLttl; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742504147; x=1774040147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PLtci6HNVFnoWpqyRfl0ED9P91Y7zsBKIaYQAKodKeI=;
  b=a3GJLttlDtWQhGiKziZpDJOY6hVmORYbwKTspOGOv8UQ9itikoAMfLiq
   e7XA6q21b495o6kUW3jG9/JKoiGdZGXpqzp5YFZyohac8jR+xj8Ko/ydM
   TAQOsxGjTAIiqa2PJ8LwQsbZDK+yL54GP0jXWJ+wwlfOdzGUJXh6LiZIV
   o=;
X-IronPort-AV: E=Sophos;i="6.14,262,1736812800"; 
   d="scan'208";a="180448497"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:55:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:39202]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.69:2525] with esmtp (Farcaster)
 id cae6fb19-d6b1-4da9-8de0-3ef89cb2c1f7; Thu, 20 Mar 2025 20:55:45 +0000 (UTC)
X-Farcaster-Flow-ID: cae6fb19-d6b1-4da9-8de0-3ef89cb2c1f7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 20 Mar 2025 20:55:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 20 Mar 2025 20:55:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xnxc22xnxc22@qq.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: Linux6.14-rc5 Bug:    INFO: task hung in rtnl_dumpit
Date: Thu, 20 Mar 2025 13:54:21 -0700
Message-ID: <20250320205534.54874-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <tencent_E5D983AC5A7B056F07B32ED79BFBCA1E8005@qq.com>
References: <tencent_E5D983AC5A7B056F07B32ED79BFBCA1E8005@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: ffhgfv <xnxc22xnxc22@qq.com>
Date: Thu, 20 Mar 2025 08:26:01 -0400
> Hello, I found a bug titled "  INFO: task hung in rtnl_dumpit " with
> modified syzkaller in the Linux6.14-rc5.

Please stop sending task hung reports unless you have a repro.


> If you fix this issue, please add the following tag to the commit:
> Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee
> <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
> 
> I use the same kernel as syzbot instance upstream: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&amp;x=da4b04ae798b7ef6
> compiler: gcc version 11.4.0
> ------------[ cut here ]-----------------------------------------
>  TITLE:   INFO: task hung in rtnl_dumpit 
> ==================================================================
> INFO: task ifquery:17951 blocked for more than 143 seconds.
>       Not tainted 6.14.0-rc5-dirty #17

Also, please clarify what diff is applied on the upstream kernel.


> "echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:ifquery         state:D stack:25008 pid:17951 tgid:17951 ppid:17950  task_flags:0x400000 flags:0x00000000
> Call Trace:
>  <task>
>  context_switch kernel/sched/core.c:5378 [inline]
>  __schedule+0x1074/0x4d30 kernel/sched/core.c:6765
>  __schedule_loop kernel/sched/core.c:6842 [inline]
>  schedule+0xd4/0x210 kernel/sched/core.c:6857
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6914
>  __mutex_lock_common kernel/locking/mutex.c:662 [inline]
>  __mutex_lock+0x1042/0x2020 kernel/locking/mutex.c:730
>  rtnl_lock net/core/rtnetlink.c:79 [inline]

Even when you have a repro, if it's related to rtnl_lock() or its
family, please make sure it's NOT triggered by too many threads
trying to aquire to mutex.

For example, this report is a variant of one you sent few days ago,
and you can find many rtnl_dumpit() there too.

https://lore.kernel.org/netdev/tencent_A3FB41E607B2126D163C5D4C87DC196E0707@qq.com/

---8<---
INFO: task ifquery:17618 blocked for more than 145 seconds.
      Not tainted 6.14.0-rc5-dirty #11
"echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:ifquery         state:D stack:22632 pid:17618 tgid:17618 ppid:17610  task_flags:0x400000 flags:0x00000000
Call Trace:
 <task>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x1074/0x4d30 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0xd4/0x210 kernel/sched/core.c:6857
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6914
 __mutex_lock_common kernel/locking/mutex.c:662 [inline]
 __mutex_lock+0x1042/0x2020 kernel/locking/mutex.c:730
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnl_dumpit+0x198/0x200 net/core/rtnetlink.c:6780
...
2 locks held by ifquery/17618:
 #0: ffff88800064a6c8 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+0x6f3/0xc80 net/netlink/af_netlink.c:2254
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x198/0x200 net/core/rtnetlink.c:6780
2 locks held by syz-executor/17625:
 #0: ffffffff8fecfdd0 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x2c3/0x640 net/core/net_namespace.c:512
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x30c/0xb10 net/ipv4/ip_tunnel.c:1159
2 locks held by ifquery/17649:
 #0: ffff88805d5fc6c8 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+0x6f3/0xc80 net/netlink/af_netlink.c:2254
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x198/0x200 net/core/rtnetlink.c:6780
1 lock held by systemd-rfkill/17664:
 #0: ffff888045e80f88 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:932 [inline]
 #0: ffff888045e80f88 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_fault+0xed2/0x2650 mm/filemap.c:3435
2 locks held by ifquery/17698:
 #0: ffff8880417046c8 (nlk_cb_mutex-ROUTE){+.+.}-{4:4}, at: netlink_dump+0x6f3/0xc80 net/netlink/af_netlink.c:2254
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fee5d68 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dumpit+0x198/0x200 net/core/rtnetlink.c:6780
---8<---

