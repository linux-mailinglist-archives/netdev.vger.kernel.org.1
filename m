Return-Path: <netdev+bounces-203146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5EAF0958
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D77B1A71
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA91B0413;
	Wed,  2 Jul 2025 03:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F31A08A3;
	Wed,  2 Jul 2025 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751427596; cv=none; b=JB3o+P4m91/JIfxAN/3S2IKLA+C4ccRnI7Ub0sLs2Ad2W84wOfEoPJjtFiddF+7e0v+URFWz7P2U/k2gcp6/0cZ7m81fA/uoPFb9juLiQMiDcXB8tv9ArpNvJ0MFPcfo/7mKzLYWMXGFs7YIdDMxEpUC41K0N39TDABEM20LoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751427596; c=relaxed/simple;
	bh=Uan4xQ9rDSH4MacMrfZlt+w28tKFCZ/00fg2L5tJp08=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=npfA8YJ7Bsty7HUe1kKhzcIfHM0vLVH7Szt3rIJrr8Xqpk7Kqnsg+t+YJyS9Kx5P6/9xOvrtm/7ztHq1N53ddSL5Mr0hcsHwHTSPf22Ff0Yipix89sGVdPcSAYxVybpKOx7tCF/GeY0+SI/EWVl9E5VX+mlx8g9W5T264SXhoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wDHNpwqqWRoktvQAw--.7682S3;
	Wed, 02 Jul 2025 11:36:11 +0800 (CST)
Received: from localhost (unknown [115.197.243.13])
	by mail-app1 (Coremail) with SMTP id yy_KCgBHCGMpqWRob8FTAA--.59589S2;
	Wed, 02 Jul 2025 11:36:10 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linma@zju.edu.cn,
	mingo@kernel.org,
	tglx@linutronix.de,
	pwn9uin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: atm: Fix incorrect net_device lec check
Date: Wed,  2 Jul 2025 11:36:00 +0800
Message-Id: <20250702033600.254-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBHCGMpqWRob8FTAA--.59589S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?IHBdlAXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHpkT0S87xKjFuOcc67InCDC0OVCv9nrmMj74PPDrrxq6slbJiBOEId8GVcCyYxliNoKB
	/H+sC2BH7dZySvUYaZ2VKUjJTMQVRzgKF9lnMIMw
X-Coremail-Antispam: 1Uk129KBj93XoWxXr18XFyUAr4rtF48ZF4kXwc_yoWruF1Dpr
	WUXF4DCF4ktryUJF48AF1Utr17trW8AF1UWFWfJr1vy3WDWw1UXr1UJrW7tr1Uur45X3W2
	qw1DJ3W8t34jvabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

There are two sites in atm mpoa code that believe the fetched object
net_device is of lec type. However, both of them do just name checking
to ensure that the device name starts with "lec" pattern string.

That is, malicious user can hijack this by creating another device
starting with that pattern, thereby causing type confusion. For example,
create a *team* interface with lecX name, bind that interface and send
messages will get a crash like below:

[   18.450000] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[   18.452366] BUG: unable to handle page fault for address: ffff888005702a70
[   18.454253] #PF: supervisor instruction fetch in kernel mode
[   18.455058] #PF: error_code(0x0011) - permissions violation
[   18.455366] PGD 3801067 P4D 3801067 PUD 3802067 PMD 80000000056000e3
[   18.455725] Oops: 0011 [#1] PREEMPT SMP PTI
[   18.455966] CPU: 0 PID: 130 Comm: trigger Not tainted 6.1.90 #7
[   18.456921] RIP: 0010:0xffff888005702a70
[   18.457151] Code: .....
[   18.458168] RSP: 0018:ffffc90000677bf8 EFLAGS: 00010286
[   18.458461] RAX: ffff888005702a70 RBX: ffff888005702000 RCX: 000000000000001b
[   18.458850] RDX: ffffc90000677c10 RSI: ffff88800565e0a8 RDI: ffff888005702000
[   18.459248] RBP: ffffc90000677c68 R08: 0000000000000000 R09: 0000000000000000
[   18.459644] R10: 0000000000000000 R11: ffff888005702a70 R12: ffff88800556c000
[   18.460033] R13: ffff888005964900 R14: ffff8880054b4000 R15: ffff8880054b5000
[   18.460425] FS:  0000785e61b5a740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   18.460872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.461183] CR2: ffff888005702a70 CR3: 00000000054c2000 CR4: 00000000000006f0
[   18.461580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   18.461974] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   18.462368] Call Trace:
[   18.462518]  <TASK>
[   18.462645]  ? __die_body+0x64/0xb0
[   18.462856]  ? page_fault_oops+0x353/0x3e0
[   18.463092]  ? exc_page_fault+0xaf/0xd0
[   18.463322]  ? asm_exc_page_fault+0x22/0x30
[   18.463589]  ? msg_from_mpoad+0x431/0x9d0
[   18.463820]  ? vcc_sendmsg+0x165/0x3b0
[   18.464031]  vcc_sendmsg+0x20a/0x3b0
[   18.464238]  ? wake_bit_function+0x80/0x80
[   18.464511]  __sys_sendto+0x38c/0x3a0
[   18.464729]  ? percpu_counter_add_batch+0x87/0xb0
[   18.465002]  __x64_sys_sendto+0x22/0x30
[   18.465219]  do_syscall_64+0x6c/0xa0
[   18.465465]  ? preempt_count_add+0x54/0xb0
[   18.465697]  ? up_read+0x37/0x80
[   18.465883]  ? do_user_addr_fault+0x25e/0x5b0
[   18.466126]  ? exit_to_user_mode_prepare+0x12/0xb0
[   18.466435]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   18.466727] RIP: 0033:0x785e61be4407
[   18.467948] RSP: 002b:00007ffe61ae2150 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[   18.468368] RAX: ffffffffffffffda RBX: 0000785e61b5a740 RCX: 0000785e61be4407
[   18.468758] RDX: 000000000000019c RSI: 00007ffe61ae21c0 RDI: 0000000000000003
[   18.469149] RBP: 00007ffe61ae2370 R08: 0000000000000000 R09: 0000000000000000
[   18.469542] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[   18.469936] R13: 00007ffe61ae2498 R14: 0000785e61d74000 R15: 000057bddcbabd98

Refer to other net_device related subsystem, checking netlink_ops seems
like the correct way out, e.g., see how xgbe_netdev_event() validates
the netdev object. Hence, add correct comparison with lec_netdev_ops to
safeguard the casting.

By the way, this bug dates back to pre-git history (2.3.15), hence use
the first reference for tracking.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 net/atm/mpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..96ea134e22fe 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -275,6 +275,9 @@ static struct net_device *find_lec_by_itfnum(int itf)
 	sprintf(name, "lec%d", itf);
 	dev = dev_get_by_name(&init_net, name);
 
+	if (dev->netdev_ops != lec_netdev_ops)
+		return NULL;
+
 	return dev;
 }
 
@@ -1006,7 +1009,7 @@ static int mpoa_event_listener(struct notifier_block *mpoa_notifier,
 	if (!net_eq(dev_net(dev), &init_net))
 		return NOTIFY_DONE;
 
-	if (strncmp(dev->name, "lec", 3))
+	if (dev->netdev_ops != lec_netdev_ops)
 		return NOTIFY_DONE; /* we are only interested in lec:s */
 
 	switch (event) {
-- 
2.17.1


