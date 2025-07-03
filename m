Return-Path: <netdev+bounces-203649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB20AF69B7
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4846F189D33C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB628DEF9;
	Thu,  3 Jul 2025 05:25:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A013AA3E;
	Thu,  3 Jul 2025 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520324; cv=none; b=E98JM7N264ndQfdFx4/kyh4/XZKIyG41rlZRTN5rhKG519NNwMsUWGfhVz84zSqrus1W8j4hjaTDnVf5gDQgXyFTMXrkJnuxeOPMFL6HJFW/dEmpGepI0alRaa9uJj0nfIm+R+86u/aI3F0/n7s3snn2HmsXo4raLK7ryABm9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520324; c=relaxed/simple;
	bh=tYSMB1/HKKU1iGw24W4Ac/5pddmmMa4Y5kgwGrxbLXE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gEwqlKCiElzWyIrPymS7zeDujCQRsiQdn8b7UhbB/aVm5+ssQ5RJxCuuZS4fyrrkgkpXx6i++qW2o9uW2donVW2ywAF9lKsKPx/uS8o9Ll1xplYf73pd+Mf6ZDaybhPnUVbSZSmp8L2IGfrp3X2N5TnJ10ezEQcnczsgsjm+ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wAXEEwYFGZoOzbaAw--.9161S3;
	Thu, 03 Jul 2025 13:24:41 +0800 (CST)
Received: from localhost (unknown [115.197.243.13])
	by mail-app2 (Coremail) with SMTP id zC_KCgCXiIAXFGZoN7dZAA--.37319S2;
	Thu, 03 Jul 2025 13:24:40 +0800 (CST)
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
Subject: [PATCH net v3] net: atm: Fix incorrect net_device lec check
Date: Thu,  3 Jul 2025 13:24:27 +0800
Message-Id: <20250703052427.12626-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCXiIAXFGZoN7dZAA--.37319S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?EjbRfQXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHuzd9MjVyyPJ6TZADBymyvaveGrJD+twvrqpBrrXdl0ok7gwD6Bxs4sQxZiwfzey8DhT
	zEajDmDktEMY54T241WVKUjJTMQVRzgKF9lnMIMw
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw1UAr4kCFyUZryDGF1rGrX_yoW7CrWkpr
	WUWFWDCr4ktr15JF4kAF1Utr17trWkAFy7uFWrJrnYy3WDW34UXr1UGrW2kry5ur45X3W7
	X3WDJ3WUt34jvabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

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
safeguard the casting. Since the *lec_netdev_ops* is defined in lec.c,
add one helpful function *is_netdev_lec()*.

By the way, this bug dates back to pre-git history (2.3.15), hence use
the first reference for tracking.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
V2 -> V3: add a helpful function to ensure the changes can compile.

 net/atm/lec.c | 5 +++++
 net/atm/lec.h | 2 ++
 net/atm/mpc.c | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index 73078306504c..46f0b5a00200 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -565,6 +565,11 @@ static const struct net_device_ops lec_netdev_ops = {
 	.ndo_set_rx_mode	= lec_set_multicast_list,
 };
 
+bool is_netdev_lec(const struct net_device *dev)
+{
+	return dev->netdev_ops == &lec_netdev_ops;
+}
+
 static const unsigned char lec_ctrl_magic[] = {
 	0xff,
 	0x00,
diff --git a/net/atm/lec.h b/net/atm/lec.h
index be0e2667bd8c..399726484097 100644
--- a/net/atm/lec.h
+++ b/net/atm/lec.h
@@ -152,4 +152,6 @@ struct lec_vcc_priv {
 
 #define LEC_VCC_PRIV(vcc)	((struct lec_vcc_priv *)((vcc)->user_back))
 
+bool is_netdev_lec(const struct net_device *dev);
+
 #endif				/* _LEC_H_ */
diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 583c27131b7d..48ce67a1cf4d 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -275,6 +275,9 @@ static struct net_device *find_lec_by_itfnum(int itf)
 	sprintf(name, "lec%d", itf);
 	dev = dev_get_by_name(&init_net, name);
 
+	if (!dev || !is_netdev_lec(dev))
+		return NULL;
+
 	return dev;
 }
 
@@ -1006,7 +1009,7 @@ static int mpoa_event_listener(struct notifier_block *mpoa_notifier,
 	if (!net_eq(dev_net(dev), &init_net))
 		return NOTIFY_DONE;
 
-	if (strncmp(dev->name, "lec", 3))
+	if (!is_netdev_lec(dev))
 		return NOTIFY_DONE; /* we are only interested in lec:s */
 
 	switch (event) {
-- 
2.17.1


