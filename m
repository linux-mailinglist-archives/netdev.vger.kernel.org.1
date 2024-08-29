Return-Path: <netdev+bounces-123021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA8296378F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C551F2360C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BE134D1;
	Thu, 29 Aug 2024 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ids7cP/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AD4C62;
	Thu, 29 Aug 2024 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894305; cv=none; b=E8MVUUNK2ADo4WcscNPWpR2kLT84O6DcvpZMjl8TPNRGWDoTjcEUsld+4CTpJkpoQ9TpwOZ/HkU2jSo0CLZWkXMTw7vnNRl79cK9RtHeqFalWEvFSxI2/UxBhwmqct0qqotoYBzTA9tCVk5i3y8MWIIxDFxXsLm6MvF0z5qjhkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894305; c=relaxed/simple;
	bh=nNQPCpdivYne4QbVOMfu9c9aQK37GCHKyRy0+DUeEFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv5tn7b9LF18MvftMJj0Vx9mtubkBtsxf3hbmEkBXCgbo6bjF0eOdab4BtJ80+ocQdNNEcE3XqqNzVxoq59dF7SrpGyWAvHGBIC7sQkRdD7iEcHR4YjcQopPECDPgNO+STMTG11QzJrAJMJHAf1G5yznBrIFXoDJW5uZThjmAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ids7cP/c; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724894304; x=1756430304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VFJu8fyWP5bQ3bCV96e4oyKqBdNaTYZNXDwbn6Fy4c4=;
  b=Ids7cP/cklWGk9YTOf++HApMXY6UIWeTC8T7qzLMqvpZ/wpffH/OWpCE
   S8ZRSBERQAhybHG/hKpimLsXu0UxIiIXVKTBwAvYSZNEisBzlTNro4MqI
   YGwQG+RCCKqDll4hYrzMcDUVLjFoUTocqUZoB0wa+sUfi9vf73n0p3sGj
   0=;
X-IronPort-AV: E=Sophos;i="6.10,184,1719878400"; 
   d="scan'208";a="429889089"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 01:18:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:63524]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.242:2525] with esmtp (Farcaster)
 id b7be642e-e2a5-42f6-acfb-593d18a8f59e; Thu, 29 Aug 2024 01:18:18 +0000 (UTC)
X-Farcaster-Flow-ID: b7be642e-e2a5-42f6-acfb-593d18a8f59e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 29 Aug 2024 01:18:17 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.146.184) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 29 Aug 2024 01:18:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xli399@ucr.edu>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gouhao@uniontech.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <quic_abchauha@quicinc.com>,
	<willemb@google.com>, <wuyun.abel@bytedance.com>, <yhao016@ucr.edu>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in sock_def_readable
Date: Wed, 28 Aug 2024 18:18:05 -0700
Message-ID: <20240829011805.92574-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CALAgD-41QZdm=Sj2N4QyYyeNY1EMq6DKY+q7647-53ysZEs8ZQ@mail.gmail.com>
References: <CALAgD-41QZdm=Sj2N4QyYyeNY1EMq6DKY+q7647-53ysZEs8ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:38:59 -0700
> Hi,
> 
> We found a bug in Linux 6.10 using syzkaller. It is possibly a null
> pointer dereference  bug.
> The bug report is as follows, but unfortunately there is no generated
> syzkaller reproducer.

quoting Eric's words:

---8<---
I would ask you to stop sending these reports, we already have syzbot
with a more complete infrastructure.
---8<---
https://lore.kernel.org/netdev/CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA==EVh+O74VHGDBNqUoA@mail.gmail.com/

(unless you have a repro that syzbot doesn't have or you are confident
 that this is true positive)


> 
> Bug report:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffc90000006af8 EFLAGS: 00010046
> RAX: 1ffff92001572f0a RBX: 0000000000000000 RCX: 00000000000000c3
> RDX: 0000000000000010 RSI: 0000000000000001 RDI: ffffc9000ab97840
> RBP: 0000000000000001 R08: 0000000000000003 R09: fffff52000000d3c
> R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc9000ab97850
> R13: 0000000000000000 R14: ffffc9000ab97840 R15: ffff88802dfb3680
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 000000000d932000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  __wake_up_common kernel/sched/wait.c:89 [inline]
>  __wake_up_common_lock+0x134/0x1e0 kernel/sched/wait.c:106
>  sock_def_readable+0x167/0x380 net/core/sock.c:3353

This seems to be caused due to memory corruption.
skwq_has_sleeper() has NULL check.

Recently I saw some reports similar to what you posted and that seem
unlikely to happen without such an issue in another place.

