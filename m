Return-Path: <netdev+bounces-168388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC081A3EBEC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 05:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0233F19C4201
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D31E5739;
	Fri, 21 Feb 2025 04:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kG/4Bf/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0681CD1E1
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 04:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112882; cv=none; b=fI+4jSFF19ZUd/ZktWoZQx4BHLzmB1QZc8K5FDnO8uk8NNbIwT1VyHA3jvQH4A2O75Dn9DuRkNr7akadu9STQYpUTjRtObstAr9PMdhPQjhElpuwAvdO4+hlsDBEWNFi0dH3d3Ru4xQfQWOdDhW3+U0/NURiVn2SdtgTLCHfWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112882; c=relaxed/simple;
	bh=yZBzLTulDuENjgvBMoAdEvmoUNrie738av9NT3LazoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9pKxHIGsfKG2+c1w1246QarsNB0ubhrWLV+xQftcZhVDVC73FUHtnpFOHxBB7bQnRG/WlsPn8yH4H9x+WzPuX4iMB9TAvpJi5hGv/pwQILaJGo6llHlr2x+XLmsGJwA7zXq6q2UkTWM6K2W0uRmKeBSmpX84gNwE/Qn7Yq9LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kG/4Bf/c; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740112881; x=1771648881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LTNUnfaFVMXwsmTfppBwfDOKgNJfrLgoGjFn3OSgpq0=;
  b=kG/4Bf/co6Qv+wPrK1t6QUUluXfviKFu4AGktFNKexFerYGEOjB31zSW
   ioI8UIV5Y/u0P2hl7RY1ndIeviu6+6Sqp6bYE1It+OIKn73ec9KvZIjqs
   q4IF+qVcxca1Uvs8P3vzXv17kz8zp3gBVivOTLcXQHJIg85ybDMnDvHOe
   c=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="474083590"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:41:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30824]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id 2f3afeaa-31c5-4552-9730-564e8f49a582; Fri, 21 Feb 2025 04:41:13 +0000 (UTC)
X-Farcaster-Flow-ID: 2f3afeaa-31c5-4552-9730-564e8f49a582
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 04:41:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 04:41:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+30a19e01a97420719891@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: better track kernel sockets lifetime
Date: Thu, 20 Feb 2025 20:40:58 -0800
Message-ID: <20250221044058.82532-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250220131854.4048077-1-edumazet@google.com>
References: <20250220131854.4048077-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 13:18:54 +0000
> While kernel sockets are dismantled during pernet_operations->exit(),
> their freeing can be delayed by any tx packets still held in qdisc
> or device queues, due to skb_set_owner_w() prior calls.
> 
> This then trigger the following warning from ref_tracker_dir_exit() [1]
> 
> To fix this, make sure that kernel sockets own a reference on net->passive.
> 
> Add sk_net_refcnt_upgrade() helper, used whenever a kernel socket
> is converted to a refcounted one.
> 
> [1]
> 
> [  136.263918][   T35] ref_tracker: net notrefcnt@ffff8880638f01e0 has 1/2 users at
> [  136.263918][   T35]      sk_alloc+0x2b3/0x370
> [  136.263918][   T35]      inet6_create+0x6ce/0x10f0
> [  136.263918][   T35]      __sock_create+0x4c0/0xa30
> [  136.263918][   T35]      inet_ctl_sock_create+0xc2/0x250
> [  136.263918][   T35]      igmp6_net_init+0x39/0x390
> [  136.263918][   T35]      ops_init+0x31e/0x590
> [  136.263918][   T35]      setup_net+0x287/0x9e0
> [  136.263918][   T35]      copy_net_ns+0x33f/0x570
> [  136.263918][   T35]      create_new_namespaces+0x425/0x7b0
> [  136.263918][   T35]      unshare_nsproxy_namespaces+0x124/0x180
> [  136.263918][   T35]      ksys_unshare+0x57d/0xa70
> [  136.263918][   T35]      __x64_sys_unshare+0x38/0x40
> [  136.263918][   T35]      do_syscall_64+0xf3/0x230
> [  136.263918][   T35]      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  136.263918][   T35]
> [  136.343488][   T35] ref_tracker: net notrefcnt@ffff8880638f01e0 has 1/2 users at
> [  136.343488][   T35]      sk_alloc+0x2b3/0x370
> [  136.343488][   T35]      inet6_create+0x6ce/0x10f0
> [  136.343488][   T35]      __sock_create+0x4c0/0xa30
> [  136.343488][   T35]      inet_ctl_sock_create+0xc2/0x250
> [  136.343488][   T35]      ndisc_net_init+0xa7/0x2b0
> [  136.343488][   T35]      ops_init+0x31e/0x590
> [  136.343488][   T35]      setup_net+0x287/0x9e0
> [  136.343488][   T35]      copy_net_ns+0x33f/0x570
> [  136.343488][   T35]      create_new_namespaces+0x425/0x7b0
> [  136.343488][   T35]      unshare_nsproxy_namespaces+0x124/0x180
> [  136.343488][   T35]      ksys_unshare+0x57d/0xa70
> [  136.343488][   T35]      __x64_sys_unshare+0x38/0x40
> [  136.343488][   T35]      do_syscall_64+0xf3/0x230
> [  136.343488][   T35]      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 0cafd77dcd03 ("net: add a refcount tracker for kernel sockets")
> Reported-by: syzbot+30a19e01a97420719891@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67b72aeb.050a0220.14d86d.0283.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

