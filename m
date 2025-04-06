Return-Path: <netdev+bounces-179453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B76A7CCA5
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 05:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C0C3AE60F
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A633985;
	Sun,  6 Apr 2025 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="em6MfLL3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECA1BC4E;
	Sun,  6 Apr 2025 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743910117; cv=none; b=WskxKOtSfrB2Bad0jLKTi45k05IeTd9y4Benjxj3vZjABBidT6LX93ZGlLPdmEV1fmqH6WhmCRIb9QOtCA9Ke5KwmbilbEKhrnNzWGgWH//nGhw4ji7PxHGdrxIsuFBbkCNQjObk4dUf9GWN5NDy2wPwXuNCJlhnhSvqtaigMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743910117; c=relaxed/simple;
	bh=t/Yg3BNAcvcTml8PVZNIk3Fl7fuRGg+0g9S82GAcBjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBrS/Sb5WiLJNA+tLQksb5iqf7bDw8ysRmpgMSjT850Qu3Fuqnwd46HkYxrt/0CQYKR1Wgmea0bHM69VhwW4sdt3Z89onOH2br6bxMKxRG3atH1EvuEIq850tjLsnOkupmQfPZL6EaFJZSYLbBuwg+QgT3PRPviapmlY44mqI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=em6MfLL3; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743910115; x=1775446115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=arGBmDCcstDUnG73wpr7EPbld6FjR9TUCSNWc075De4=;
  b=em6MfLL3m0gryeabb0LtA315De7ydKHUSeHjvmE0/Htr8Pkh4LOHCnUo
   fxMlo34CKLKhq64EzLyE3TbSbrvFAZKB6HsM8VXtWbWdF42ucITOPjtJ6
   +zna40DQFPWeIXLU10xHGrt2KDMY/oSBSBC2xHpJRs0Wa5u9CypKVsr6S
   E=;
X-IronPort-AV: E=Sophos;i="6.15,192,1739836800"; 
   d="scan'208";a="477873759"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 03:28:31 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:39330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id 47ea4d36-8342-4c3b-89d1-b9a7a7c9070b; Sun, 6 Apr 2025 03:28:30 +0000 (UTC)
X-Farcaster-Flow-ID: 47ea4d36-8342-4c3b-89d1-b9a7a7c9070b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Apr 2025 03:28:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 6 Apr 2025 03:28:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <guohui.study@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <willemb@google.com>
Subject: Re: general protection fault in addrconf_add_ifaddr
Date: Sat, 5 Apr 2025 20:28:06 -0700
Message-ID: <20250406032819.65634-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAHOo4gK+tdU1B14Kh6tg-tNPqnQ1qGLfinONFVC43vmgEPnXXw@mail.gmail.com>
References: <CAHOo4gK+tdU1B14Kh6tg-tNPqnQ1qGLfinONFVC43vmgEPnXXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Hui Guo <guohui.study@gmail.com>
Date: Sun, 6 Apr 2025 10:31:00 +0800
> Hi Kernel Maintainers,
> we found a crash "general protection fault in addrconf_add_ifaddr" (it
> is a KASAN and makes the kernel reboot) in upstream, we also have
> successfully reproduced it manually:
> 
> HEAD Commit: 9f867ba24d3665d9ac9d9ef1f51844eb4479b291
> kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/.config
> 
> console output:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0bac07a7b69ecfe48ab5575d/repro.log
> repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0bac07a7b69ecfe48ab5575d/repro.report
> syz reproducer:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0bac07a7b69ecfe48ab5575d/repro.prog
> c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0bac07a7b69ecfe48ab5575d/repro.cprog
> 
> Please let me know if there is anything I can help with.
> Best,
> Hui Guo
> 
> This is the crash log I got by reproducing the bug based on the above
> environment，
> I have piped this log through decode_stacktrace.sh to better
> understand the cause of the bug.
[...]
> [ 90.201985][T12032] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000198: 0000 [#1] SMP KASAN NOPTI
> [ 90.204525][T12032] KASAN: null-ptr-deref in range
> [0x0000000000000cc0-0x0000000000000cc7]
> [ 90.206275][T12032] CPU: 3 UID: 0 PID: 12032 Comm: syz.0.15 Not
> tainted 6.14.0-13408-g9f867ba24d36 #1 PREEMPT(full)
> [ 90.208522][T12032] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [90.210452][T12032] RIP: 0010:addrconf_add_ifaddr
> (/data/ghui/docker_data/linux_kernel/upstream/linux/./include/net/netdev_lock.h:30
> /data/ghui/docker_data/linux_kernel/upstream/linux/./include/net/netdev_lock.h:41
> /data/ghui/docker_data/linux_kernel/upstream/linux/net/ipv6/addrconf.c:3157)

Thanks for the report.

netdev_lock_ops() needs to be moved:

---8<---
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c3b908fccbc1..9c52ed23ff23 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3154,12 +3154,13 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
-	netdev_lock_ops(dev);
-	if (dev)
+	if (dev) {
+		netdev_lock_ops(dev);
 		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
-	else
+		netdev_unlock_ops(dev);
+	} else {
 		err = -ENODEV;
-	netdev_unlock_ops(dev);
+	}
 	rtnl_net_unlock(net);
 	return err;
 }
---8<---

