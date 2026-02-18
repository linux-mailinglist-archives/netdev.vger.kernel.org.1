Return-Path: <netdev+bounces-259209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HL00J6FXlWlzPAIAu9opvQ
	(envelope-from <netdev+bounces-259209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 07:09:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C0153347
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 07:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712663017C1E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE962F691C;
	Wed, 18 Feb 2026 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEhHXiBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A1145FE0
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771394974; cv=none; b=BBsoUEznFNHtS6ouwoKBQiWUwH16WUxoEuvdxineWDCoCuUazin8rICwT1XPgpdoeE17gYTGwiQ4uC/B8b361apz+UYaOPHKX6IC6hSR/YF4kNCLoDOQs6Y+gdSHCWpl83bV+eTkMEZX0HjIAYdmiiIBLp5k1tFvzItJc9DKZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771394974; c=relaxed/simple;
	bh=jxE4ZZovQ0Xt+gVxMo7g+rjHEEUqizcbJLS7r/rNxHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlDIQhJMyuMdGM+vtbWadslL4dezCygtE85v4F/8oWFJmV1jF/4dihRZ2Nc9l/Th2oJnM3t3oo4fvCe5oNA+q668z2rdYpxr3xpTTnpGhyM80n/jhT473DTfBh+EqyMbPkwFdWDTkvAvJUDk/Gotm6qsV+53KtG4p2mEjLLSgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEhHXiBq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824a6f2d816so2368503b3a.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 22:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771394972; x=1771999772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqZkNwJNWRlmdbEs6MsNvUmX79hcKeCnemHaZLEDUCw=;
        b=NEhHXiBqePxS0VN0O+Id1G7bSbD05LX2qAVAS7PeJi7ROshck6uY2pWtey1Zp7pJCt
         lG0fUUMyw5Kx+hq/M7nhI8wofeRlTjjKLR2FfD47/75oy8cMnNB7rbPx7ux4HKuPYPXn
         P/MY1bmbbzgqLVH8yTTN4Vmi3Kp2Y3zdyKXS+dZQMwCWw6bG/vAL1vxVv3JHLemWEunW
         PSjv8FH7Y8qd+c/HLj8NcpHdqBreAUnBoJZM2iiK4ZvhASQYJsfp2ntb2vXlAmg723Li
         iFDWEzVBhckVZ4kujKz4jtC8RDTT4IEU73lAokeZ9i2so5VylwCjy23E/FOXLerPMdfW
         2lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771394972; x=1771999772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqZkNwJNWRlmdbEs6MsNvUmX79hcKeCnemHaZLEDUCw=;
        b=EwUVANgrItPUI24PDSBAZ81qx9WViXMGbfvpCCoS03k0jyNIvZ+PZbl8+8v66fzA5U
         exHN9MFGDKVsUHz066afAOERx7FnPlHUGyOBXMZbsVQGSlEnjPlwB0H63KXUOSAIb5fc
         DlKDkbZP0AmkCneCr0ZORFjLQX9cuayFpvecWVZtf2gBFAuofKHQ1Pz2QdbvlkJG5BSH
         z+hNCRQSdIGA9DysUQ571fOBKkNC0RkiX1peC9O4WS5EkqkxvwmNVAGPvNisNnpU8KRs
         OPH45k2d2+ygZCnFMNgi6EidH2wiTFuTG8k1nHKPlsXOPVj4sUCla5B6AGgRUsNgnbjD
         UONA==
X-Gm-Message-State: AOJu0YznW04kQ5uAuc9t0lEQUL0vE/GOjvKBoEAgY1fLAd3qhvH6sMEY
	m+B+r0pnpthc/ak+aU5JEnCDDTxBKL9QlwToM/9IrAtWi2ImsqhwV243HVmzenA9
X-Gm-Gg: AZuq6aLCzrt6n0sTsw/Vmu19AN43hBuxwaJhmw/fu3aVUij0K+c3/A3FfjAezLydiIq
	O9mgM71eWPV1ontQMl60GEL5RVe3BnW5kZGGptFWKvraRs9PoE68cytlI/8u3/vF9hAtW/XwtoO
	6Pwo7/cX8bexF9NkZfq59zrOh7DzBJVScr4bhPh393t7PqwAukhuFterMmI8uaGNHGyzqxDI4aS
	gvI/8BUG6LRackCmuANcPkMSuXjXB6IODD66rpOiixPy7bwkBXImuT1XF5Gs3hC1ywmxFuEj9f7
	LRovh5dyMu01yLOnhCkDhs1bzRgBic4FRo+GP8u0z0Lfbvc14KPdsAaOk5rsRAdu1Y73hzBVDJK
	Y/y7X3/xMvjc23LvZXaXPc/r7V7BWQaTdrQpF7+msjl8UFl7SWT6xiyDqzHAjXfQ1EixZ96eNki
	huJeL4lY2nY4pvKrPxRk0AhEd3/yI=
X-Received: by 2002:a05:6a00:1daa:b0:823:d8a:fa66 with SMTP id d2e1a72fcca58-825275019d5mr1035893b3a.31.1771394972506;
        Tue, 17 Feb 2026 22:09:32 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b6a3edsm15438902b3a.41.2026.02.17.22.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 22:09:32 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCHv3 net] bonding: alb: fix UAF in rlb_arp_recv during bond up/down
Date: Wed, 18 Feb 2026 06:09:19 +0000
Message-ID: <20260218060919.101574-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com,nvidia.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259209-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E57C0153347
X-Rspamd-Action: no action

The ALB RX path may access rx_hashtbl concurrently with bond
teardown. During rapid bond up/down cycles, rlb_deinitialize()
frees rx_hashtbl while RX handlers are still running, leading
to a null pointer dereference detected by KASAN.

However, the root cause is that rlb_arp_recv() can still be accessed
after setting recv_probe to NULL, which is actually a use-after-free
(UAF) issue. That is the reason for using the referenced commit in the
Fixes tag.

[  214.174138] Oops: general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] SMP KASAN PTI
[  214.186478] KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
[  214.194933] CPU: 30 UID: 0 PID: 2375 Comm: ping Kdump: loaded Not tainted 6.19.0-rc8+ #2 PREEMPT(voluntary)
[  214.205907] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.14.0 01/14/2022
[  214.214357] RIP: 0010:rlb_arp_recv+0x505/0xab0 [bonding]
[  214.220320] Code: 0f 85 2b 05 00 00 48 b8 00 00 00 00 00 fc ff df 40 0f b6 ed 48 c1 e5 06 49 03 ad 78 01 00 00 48 8d 7d 28 48 89 fa 48 c1 ea 03 <0f> b6
 04 02 84 c0 74 06 0f 8e 12 05 00 00 80 7d 28 00 0f 84 8c 00
[  214.241280] RSP: 0018:ffffc900073d8870 EFLAGS: 00010206
[  214.247116] RAX: dffffc0000000000 RBX: ffff888168556822 RCX: ffff88816855681e
[  214.255082] RDX: 000000000000001d RSI: dffffc0000000000 RDI: 00000000000000e8
[  214.263048] RBP: 00000000000000c0 R08: 0000000000000002 R09: ffffed11192021c8
[  214.271013] R10: ffff8888c9010e43 R11: 0000000000000001 R12: 1ffff92000e7b119
[  214.278978] R13: ffff8888c9010e00 R14: ffff888168556822 R15: ffff888168556810
[  214.286943] FS:  00007f85d2d9cb80(0000) GS:ffff88886ccb3000(0000) knlGS:0000000000000000
[  214.295966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  214.302380] CR2: 00007f0d047b5e34 CR3: 00000008a1c2e002 CR4: 00000000001726f0
[  214.310347] Call Trace:
[  214.313070]  <IRQ>
[  214.315318]  ? __pfx_rlb_arp_recv+0x10/0x10 [bonding]
[  214.320975]  bond_handle_frame+0x166/0xb60 [bonding]
[  214.326537]  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
[  214.332680]  __netif_receive_skb_core.constprop.0+0x576/0x2710
[  214.339199]  ? __pfx_arp_process+0x10/0x10
[  214.343775]  ? sched_balance_find_src_group+0x98/0x630
[  214.349513]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  214.356513]  ? arp_rcv+0x307/0x690
[  214.360311]  ? __pfx_arp_rcv+0x10/0x10
[  214.364499]  ? __lock_acquire+0x58c/0xbd0
[  214.368975]  __netif_receive_skb_one_core+0xae/0x1b0
[  214.374518]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  214.380743]  ? lock_acquire+0x10b/0x140
[  214.385026]  process_backlog+0x3f1/0x13a0
[  214.389502]  ? process_backlog+0x3aa/0x13a0
[  214.394174]  __napi_poll.constprop.0+0x9f/0x370
[  214.399233]  net_rx_action+0x8c1/0xe60
[  214.403423]  ? __pfx_net_rx_action+0x10/0x10
[  214.408193]  ? lock_acquire.part.0+0xbd/0x260
[  214.413058]  ? sched_clock_cpu+0x6c/0x540
[  214.417540]  ? mark_held_locks+0x40/0x70
[  214.421920]  handle_softirqs+0x1fd/0x860
[  214.426302]  ? __pfx_handle_softirqs+0x10/0x10
[  214.431264]  ? __neigh_event_send+0x2d6/0xf50
[  214.436131]  do_softirq+0xb1/0xf0
[  214.439830]  </IRQ>

The issue is reproducible by repeatedly running
ip link set bond0 up/down while receiving ARP messages, where
rlb_arp_recv() can race with rlb_deinitialize() and dereference
a freed rx_hashtbl entry.

Fix this by setting recv_probe to NULL and then calling
synchronize_net() to wait for any concurrent RX processing to finish.
This ensures that no RX handler can access rx_hashtbl after it is freed
in bond_alb_deinitialize().

Reported-by: Liang Li <liali@redhat.com>
Fixes: 3aba891dde38 ("bonding: move processing of recv handlers into handle_frame()")
Reviewed-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v3: Use WRITE_ONCE to set recv_probe, and update fixes tag (Jakub Kicinski)
v2: make the description more clear (Jay)

---
 drivers/net/bonding/bond_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 78cff904cdc3..55a960da42b5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4343,9 +4343,13 @@ static int bond_close(struct net_device *bond_dev)
 
 	bond_work_cancel_all(bond);
 	bond->send_peer_notif = 0;
+	WRITE_ONCE(bond->recv_probe, NULL);
+
+	/* Wait for any in-flight RX handlers */
+	synchronize_net();
+
 	if (bond_is_lb(bond))
 		bond_alb_deinitialize(bond);
-	bond->recv_probe = NULL;
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD &&
 	    bond->params.broadcast_neighbor)
-- 
2.50.1


