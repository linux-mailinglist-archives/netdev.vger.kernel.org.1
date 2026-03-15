Return-Path: <netdev+bounces-267956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JJUMCcMt2n4LwEAu9opvQ
	(envelope-from <netdev+bounces-267956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:44:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 401B22923F8
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CAA300C82E
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2C372689;
	Sun, 15 Mar 2026 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="UDtr+lpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937692264A7
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773603876; cv=none; b=NdpX4BV8lXeezIRgyeYlOXsDHdauC2xU/ZSZiftV1P0oAlyaZfcStItzmLHNq4GEBRUsZKReHL04zS5OQJXhWTd9uH/GS4gR8pqmZneKiwcjJIDGdAWcxJMXekFFmOatEASy5/+QxU8MQTbz9g1AChcFmVLTwLNOoZXixLtBnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773603876; c=relaxed/simple;
	bh=28lD2rM8n+jSuYNXIMh5HC05mHTu40WVs5trqvzKg0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARNrBbvDsJYygSjwteICCls7b0bGGKTOuX833JZLo0CYkU+sMZj9YsM67PL/aEUeq9WkcpoKtbAkPpaaf3jVq66tu8hpqa7yu9yxCwyzROUz8XQiI0iSQ2GOw1fQT4hDCBRI3hqMzKDLxRBKnj2smp4TihZ1Km+3WWPAH5nU2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UDtr+lpq; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271195d2a7so438712c88.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773603873; x=1774208673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yYsTafHnvLzwH325mKhSnqifh+Fojch7qFIE6cN8d0=;
        b=UDtr+lpqxSSpbF7ErIihgRjrDZmvoWLUxE2eDEO5F94v3X+Q1vgFdkQDMIZytMfZ9m
         qwOQesd99/DIdftxaDyiFD8wkKO3YILdNEDUBpTk9VcTc8+DACed1RC8ib/aatSmgZAY
         BewEmeurbgAU7dNlKSTk8pPYszINiP8fm0mIDy4SaOIbxG/uhSLkqlAK3lOXNLglPLuM
         qow8Ets1pX5zOhu3HoNi0nnCRy2ruc2CllQ5+SSLJZXDKOoZNkP3YsvenBbypWMQFdpr
         kgauKv3pdPM+a5X34pi99NpjpEVR1gthhfa/Ev1vNjNAbB1tezp1vl2EPQqHXYg25xXJ
         oCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773603873; x=1774208673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yYsTafHnvLzwH325mKhSnqifh+Fojch7qFIE6cN8d0=;
        b=QKxMIPVHavzVKDiSefMOzbKEdXXhntsZmtEsrytFnMH18iKcr8cQq1EX6PlqiuXQeI
         Y0iXtg6pOqJlVKCKjxA3OkLVeC00w9CGfZU/0JvDl7hmumohcm64cnl8g3wHKANqWzly
         dWxVXOPbKYM7A+ewaYM5B8dkOo2yrlX5WWIM2eKzi7sKauso89mP7LjXFgVbHXCd+qNU
         cZk1rpo0d+K1LFyr2eGRgMq/WstZFn2b97OZaxoLrwcfbkBxiDPGIVGQUJCKc8XQSnCn
         X5HnjWVkyVzDYKa9T8ezfevayfjAJk6iR/XUeLt5RdqdYxdTonn0wJ6du0ml0dtiidHw
         NGHQ==
X-Gm-Message-State: AOJu0YyxQKkNnYCLm+U2JrjBupSz5np8vDi9uJ8nDqNQOnYM/oIijYam
	DgqmWASaKOrhwME1KIutrHVXTDVsvI+ZGmtZmtcIGKIUXeH/z6Ce0kv44NSLS4I3/F7/qtCSg3E
	cEnYjzA==
X-Gm-Gg: ATEYQzzq9DnL4Ci2IsARa0I/f1hXfFFchXogHF+O+3movqUBPE2COJtcEGXSNa8CtkR
	i/49MEF4UWdajhuO3rOgWYLINqsHZy+B5NsqoPN28MbfoHyf/I6dYsPCxXWuBXjQjFJ6azAyCCr
	1yiari7pe6294hKnUPXR5ReYODdGhXd+J4W53YuMVYt/N1H4iCUoQ5RjPPnwKbxC3d+qeln4ot1
	/9AXRjbIbjs8Zqh2rIVU8vpoK/CmLuGp/bSlVJqEynCJ0XGNGbMnOevt1JETRlh/lMs+ey9RODl
	QtGHpxqC7mGaU5BdxgneymLdl3OiOOv0jV+ZtSljm7eJqrJ7Jg/eqTsrtmYwrs4QaA4VKl3g5kt
	QymAZ1cES8xKTVT69S7CBfPeKD7rcGl2eIh/guTaqBKMp306mpZ1VJwdBl0r3tWtClRl4Ae/hcL
	Zo1QX0zTxBowLo/8oj0cXwTx3JlMJPW2Hs8QSRkViiNObAcX6Dfjr+Zw==
X-Received: by 2002:a05:7022:4397:b0:128:d34a:320f with SMTP id a92af1059eb24-128f3d3be43mr5024017c88.12.1773603873356;
        Sun, 15 Mar 2026 12:44:33 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f639a160sm9675766c88.12.2026.03.15.12.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 12:44:32 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net: bonding: fix NULL deref in bond_debug_rlb_hash_show
Date: Sun, 15 Mar 2026 12:44:04 -0700
Message-ID: <20260315194404.579122-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267956-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 401B22923F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rlb_clear_slave intentionally keeps RLB hash-table entries on
the rx_hashtbl_used_head list with slave set to NULL when no
replacement slave is available. However, bond_debug_rlb_hash_show
visites client_info->slave without checking if it's NULL.

Other used-list iterators in bond_alb.c already handle this NULL-slave
state safely:

- rlb_update_client returns early on !client_info->slave
- rlb_req_update_slave_clients, rlb_clear_slave, and rlb_rebalance
compare slave values before visiting
- lb_req_update_subnet_clients continues if slave is NULL

The following NULL deref crash can be trigger in
bond_debug_rlb_hash_show:

[    1.289791] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.290262] #PF: supervisor read access in kernel mode
[    1.290494] #PF: error_code(0x0000) - not-present page
[    1.290724] PGD 102a98067 P4D 102a98067 PUD 102831067 PMD 0
[    1.291013] Oops: Oops: 0000 [#1] SMP NOPTI
[    1.291202] CPU: 1 UID: 0 PID: 145 Comm: exploit Not tainted 7.0.0-rc3-virtme #1 PREEMPTLAZY
[    1.291555] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
[    1.292058] RIP: 0010:bond_debug_rlb_hash_show (drivers/net/bonding/bond_debugfs.c:41)
[    1.292286] Code: 83 fb ff 74 3c 48 c1 e3 06 49 03 9c 24 f0 00 00 00 48 c7 c6 d5 aa 9d 83 48 89 ef 48 8b 43 30 48 85

Code starting with the faulting instruction
===========================================
   0:	83 fb ff             	cmp    $0xffffffff,%ebx
   3:	74 3c                	je     0x41
   5:	48 c1 e3 06          	shl    $0x6,%rbx
   9:	49 03 9c 24 f0 00 00 	add    0xf0(%r12),%rbx
  10:	00
  11:	48 c7 c6 d5 aa 9d 83 	mov    $0xffffffff839daad5,%rsi
  18:	48 89 ef             	mov    %rbp,%rdi
  1b:	48 8b 43 30          	mov    0x30(%rbx),%rax
  1f:	48                   	rex.W
  20:	85                   	.byte 0x85
[    1.293101] RSP: 0018:ffffc900004a7d00 EFLAGS: 00010286
[    1.293333] RAX: 0000000000000000 RBX: ffff888102b48200 RCX: ffff888102b48204
[    1.293631] RDX: ffff888102b48200 RSI: ffffffff839daad5 RDI: ffff888102815078
[    1.293924] RBP: ffff888102815078 R08: ffff888102b4820e R09: 0000000000000000
[    1.294267] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100f929c0
[    1.294564] R13: ffff888100f92a00 R14: 0000000000000001 R15: ffffc900004a7ed8
[    1.294864] FS:  0000000001395380(0000) GS:ffff888196e75000(0000) knlGS:0000000000000000
[    1.295239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.295480] CR2: 0000000000000000 CR3: 0000000102adc004 CR4: 0000000000772ef0
[    1.295775] PKRU: 55555554
[    1.295897] Call Trace:
[    1.296031]  <TASK>
[    1.296134]  seq_read_iter (fs/seq_file.c:231)
[    1.296341]  seq_read (fs/seq_file.c:164)
[    1.296493]  full_proxy_read (fs/debugfs/file.c:378 (discriminator 1))
[    1.296658]  vfs_read (fs/read_write.c:572)
[    1.296804]  ? _raw_spin_unlock (./arch/x86/include/asm/paravirt-spinlock.h:40 ./arch/x86/include/asm/paravirt-spinlock.h:72 ./include/linux/spinlock.h:204 ./include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:186)
[    1.296981]  ksys_read (fs/read_write.c:717)
[    1.297132]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[    1.297325]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[    1.297553] RIP: 0033:0x41c9d1
[    1.297693] Code: f7 d8 64 89 02 b8 ff ff ff ff eb ba e8 f8 14 00 00 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 8d 9c

Code starting with the faulting instruction
===========================================
   0:	f7 d8                	neg    %eax
   2:	64 89 02             	mov    %eax,%fs:(%rdx)
   5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   a:	eb ba                	jmp    0xffffffffffffffc6
   c:	e8 f8 14 00 00       	call   0x1509
  11:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  18:	00
  19:	f3 0f 1e fa          	endbr64
  1d:	80                   	.byte 0x80
  1e:	3d                   	.byte 0x3d
  1f:	8d                   	.byte 0x8d
  20:	9c                   	pushf
[    1.298516] RSP: 002b:00007ffdd99e07d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[    1.298834] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000041c9d1
[    1.299163] RDX: 0000000000001000 RSI: 00007ffdd99e07f0 RDI: 0000000000000003
[    1.299483] RBP: 00007ffdd99e1800 R08: 00007ffdd99e0740 R09: 0000000000000014
[    1.299786] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdd99e1918
[    1.300106] R13: 00007ffdd99e1928 R14: 00000000004b0868 R15: 0000000000000001
[    1.300419]  </TASK>
[    1.300523] Modules linked in:
[    1.300667] CR2: 0000000000000000
[    1.300820] ---[ end trace 0000000000000000 ]---

Add a NULL check and print "(none)" for entries with no assigned slave.

Fixes: caafa84251b88 ("bonding: add the debugfs interface to see RLB hash table")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/bonding/bond_debugfs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 8adbec7c5084..8967b65f6d84 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -34,11 +34,17 @@ static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
 	for (; hash_index != RLB_NULL_INDEX;
 	     hash_index = client_info->used_next) {
 		client_info = &(bond_info->rx_hashtbl[hash_index]);
-		seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
-			&client_info->ip_src,
-			&client_info->ip_dst,
-			&client_info->mac_dst,
-			client_info->slave->dev->name);
+		if (client_info->slave)
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM %s\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst,
+				   client_info->slave->dev->name);
+		else
+			seq_printf(m, "%-15pI4 %-15pI4 %-17pM (none)\n",
+				   &client_info->ip_src,
+				   &client_info->ip_dst,
+				   &client_info->mac_dst);
 	}
 
 	spin_unlock_bh(&bond->mode_lock);
-- 
2.43.0


