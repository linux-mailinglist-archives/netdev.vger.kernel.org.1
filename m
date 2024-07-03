Return-Path: <netdev+bounces-108660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2D924DF2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 04:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670A928121E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438074A3D;
	Wed,  3 Jul 2024 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MqodcdQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B01DA32B;
	Wed,  3 Jul 2024 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719974587; cv=none; b=FHc7mfP8+iAdpINGubvfe+XwIvhtRTr4d4vylh3qgX6SNrKvYg4CHfS/SSDvafVpvTY7oyAzGj9N3JRW25+frg4FYi8DiisK9NEIeu4hDZll3mv5EL7j+uZewV1+QZ4nKkrxkGieW8KiaOId806GVy61Tjp3yZAa72tWf7igEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719974587; c=relaxed/simple;
	bh=0+c8IamQc/JMP0Yy89b6rMfbUIOtGU6qGDJkh4JCqfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0OYYe684APSC+ls8cZGKBDslGVSnnno/a4oSXn2gwPIbBUHca4zuEXPYwP+AuTebw/zUQLDDFu/hARVwGeMST3nj4LNGkxMiWdxokCZK21aH/mR7eqat5p5VQg/G+D1b/PJdAnIw7MhMKktoq5J6Kr1XdxqLAXG67UM3IOihzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MqodcdQV; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719974585; x=1751510585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5IJUkVWImTRVEE1Lr4LGpvHulAgZFkW5TdFDxsW2jUU=;
  b=MqodcdQVv3klT0bUxSwTo+RLrOn2VtX/TIDZqQ24o58/nTx75k9IkuPn
   Gp/AwZnrHzy+BX/S2WZeAYIXWxrqpe4R0uHchoT6muZ5Tr0t3v8s375Bf
   b8SZ8O3W6b+otCYr6Ek/9TvHkONnIEzYjzA4NRRpy2f//U3m/3DDQs7Jv
   k=;
X-IronPort-AV: E=Sophos;i="6.09,180,1716249600"; 
   d="scan'208";a="407384094"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:43:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:52391]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.167:2525] with esmtp (Farcaster)
 id 3c320ed6-bed0-4404-822c-201001489b19; Wed, 3 Jul 2024 02:43:01 +0000 (UTC)
X-Farcaster-Flow-ID: 3c320ed6-bed0-4404-822c-201001489b19
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 3 Jul 2024 02:43:01 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 3 Jul 2024 02:42:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syoshida@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH net 1/2] af_unix: Fix uninit-value in __unix_walk_scc()
Date: Tue, 2 Jul 2024 19:42:48 -0700
Message-ID: <20240703024248.99131-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702160428.10153-1-syoshida@redhat.com>
References: <20240702160428.10153-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shigeru Yoshida <syoshida@redhat.com>
Date: Wed,  3 Jul 2024 01:04:27 +0900
> KMSAN reported uninit-value access in __unix_walk_scc() [1].
> 
> In the list_for_each_entry_reverse() loop, when the vertex's index
> equals it's scc_index, the loop uses the variable vertex as a
> temporary variable that points to a vertex in scc. And when the loop
> is finished, the variable vertex points to the list head, in this case
> scc, which is a local variable on the stack (more precisely, it's not
> even scc and might underflow the call stack of __unix_walk_scc():
> container_of(&scc, struct unix_vertex, scc_entry)).
> 
> However, the variable vertex is used under the label prev_vertex. So
> if the edge_stack is not empty and the function jumps to the
> prev_vertex label, the function will access invalid data on the
> stack. This causes the uninit-value access issue.
> 
> Fix this by introducing a new temporary variable for the loop.
> 
> [1]
> BUG: KMSAN: uninit-value in __unix_walk_scc net/unix/garbage.c:478 [inline]
> BUG: KMSAN: uninit-value in unix_walk_scc net/unix/garbage.c:526 [inline]
> BUG: KMSAN: uninit-value in __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
>  __unix_walk_scc net/unix/garbage.c:478 [inline]
>  unix_walk_scc net/unix/garbage.c:526 [inline]
>  __unix_gc+0x2589/0x3c20 net/unix/garbage.c:584
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xade/0x1bf0 kernel/workqueue.c:3312
>  worker_thread+0xeb6/0x15b0 kernel/workqueue.c:3393
>  kthread+0x3c4/0x530 kernel/kthread.c:389
>  ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Uninit was stored to memory at:
>  unix_walk_scc net/unix/garbage.c:526 [inline]
>  __unix_gc+0x2adf/0x3c20 net/unix/garbage.c:584
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xade/0x1bf0 kernel/workqueue.c:3312
>  worker_thread+0xeb6/0x15b0 kernel/workqueue.c:3393
>  kthread+0x3c4/0x530 kernel/kthread.c:389
>  ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Local variable entries created at:
>  ref_tracker_free+0x48/0xf30 lib/ref_tracker.c:222
>  netdev_tracker_free include/linux/netdevice.h:4058 [inline]
>  netdev_put include/linux/netdevice.h:4075 [inline]
>  dev_put include/linux/netdevice.h:4101 [inline]
>  update_gid_event_work_handler+0xaa/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:813
> 
> CPU: 1 PID: 12763 Comm: kworker/u8:31 Not tainted 6.10.0-rc4-00217-g35bb670d65fc #32
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> Workqueue: events_unbound __unix_gc
> 
> Fixes: 3484f063172d ("af_unix: Detect Strongly Connected Components.")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

