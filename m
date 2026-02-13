Return-Path: <netdev+bounces-258588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I1bEuP0jmnDGAEAu9opvQ
	(envelope-from <netdev+bounces-258588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:54:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E08134BA6
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 10:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 427743008C8A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CC34F24A;
	Fri, 13 Feb 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHv9LA+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2912DF146
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976476; cv=none; b=XM5PBvnwxLwbHhkVrvn1Uosfky1zAhbEcvuRm6zH5/T/UX5xld5SqhhGwGjq95sWdT68Zjvl5U7V56bj+rvHgEGzzIaYKdPDUt4bN8fiz8ERpHq5eVUgpt3yNkVeznCxEycHqenkR/xq8S6R5J7UnC1QAtRL03p9S/2RA4XbwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976476; c=relaxed/simple;
	bh=qjCrcgKWLqWVf+xZnQVDVlOl1FeiM3aLH8iSB3vJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujIKHwfbiSSUsrfBrbICiBn0ZWgtrtBOfJN3IMZT5M/IOw5Erh2b1L7j9IBCuv9hKKc6a+5KY5H2hPTDjnavBEFM08blGArVXx90TO7oM5uuiAoLK8RdOccNP1UDzhwoItrGrpUHVptb3V2v0CQplGV3PRNK4H3MJlWDVGzG4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHv9LA+A; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so283878a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770976474; x=1771581274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+HrwJwerGrer0mpwrMP1Hb4zjKqG4nWhdr3lbn8nE8=;
        b=IHv9LA+AW3Z4vrE9HbywfcLhIB8l8+DvVv+Uhmx0TG6c81+q1Z9GFoVScF3rFaxK7S
         YVdMaubp0uUwSsYQqtPCbGnglVT4GoMVLv0nglpoJHYV/GGbDmhpBn57rnhWULQeVcO5
         9Ef/bVweJBtnDMUd1/c0/ZGPKfijnB929vsbCwcE15u4VaqaTGNWBdmKQAQBpNpy3tSQ
         SqX6tpA+5pjl+xb5iaSHsRB8Tbn0EJGZLCzDPLaF/PKKq3VL6ogcA5nUc2QFZNHBfT3n
         RaMoTleSFLA9ZhVxIZ7s+bruOsG8MiP+nQR9yG4nuKfJ0hWxOmGjqVW8mAvoyr2+A4J0
         WzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976474; x=1771581274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+HrwJwerGrer0mpwrMP1Hb4zjKqG4nWhdr3lbn8nE8=;
        b=HRWO+6CV/9vWbUB3aV++tB/ij5yS3pBFDtH/tJbPeo5S1aP5WXO3UDkOs/wONt0B2G
         56sHXMgMM0CFy+BYQgltxDzsOjOeoGWdlJQWytXWAXriWThh4I9kpUC57nLZa6mtVhmO
         ietaJ6hGR9VC1dmg3sIdjS5LPrmexXdSsxFFbt1/V5QVvzzmRxknGg+0cawN6CiXLEuh
         rywN0SWA3jmtq/u1jyQXR0Sb2f/ToF1Y3G4o/QsA6g5hpAvHDMU01foarlNKamV/dZHB
         OYafOtvnHSp0lvBkvE31VnvSNnNCopVKlg4VEKXT8LHBieoQzPXqOj/IQK+ZutWleDdd
         SyiQ==
X-Gm-Message-State: AOJu0YwKzET0ntO1mjhIHlIL7N4puVDyLNu6a+nzkS4znYHeP1rYDGQT
	nFt1NN49SXgL9qvtNh9IlonmT3wVsvtr4AgPbpqKFgZ9Z+QMIdiSjBGZkqVX5kidrw8=
X-Gm-Gg: AZuq6aKJ2BvKlWcAyzeQc9IVTpbeyviY9qJAb1v40f+SxJLaAiAoVFDyj+FkE35k1HS
	ytpLAIHiI+B3kHDnwdxKePR7p41qjWJ4BkU2UOTywOWlO3F8YBqPfj/TrUsgmsAfpQdjrj/kj8F
	joaROwtGq3CO1vAFvN+PPsSaFMcZNonNto8ZOty9nTC4cMjXoifcsVgHyPU9mKJolghT7cIekNK
	z9NBVNNxfJU5sg6ievQ5nPzbZN2v6U3tToA6Gi2RYOIQfPjmftF6/YcjK7igegVg5G0uJM24r8R
	aNUYjZxbmkoGpapR/QKMLYxTFthx6g4V4KtlzHAwnw2kU0sYgGEjGhBQ21+asEwS5o5Zuxj4074
	q4loiCYkh5YTd29GFCvjk38/DCk0h1qA1CVq52BhGNBGRo5GTl+gYQ/9kFSvD/8gz+VVITogHAi
	Nb9V/lqv0sVlT0uH5+3wf3cxcSDs9GbDyt7cVo7A==
X-Received: by 2002:a17:90b:1a86:b0:353:38c8:b612 with SMTP id 98e67ed59e1d1-356aabe68cbmr1527483a91.12.1770976474425;
        Fri, 13 Feb 2026 01:54:34 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e1981797csm6880456a12.34.2026.02.13.01.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 01:54:33 -0800 (PST)
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
	Liang Li <liali@redhat.com>
Subject: [PATCH net] bonding: alb: fix UAF in rlb_arp_recv during bond up/down
Date: Fri, 13 Feb 2026 09:54:24 +0000
Message-ID: <20260213095424.84636-1-liuhangbin@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258588-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 63E08134BA6
X-Rspamd-Action: no action

The ALB RX path may access rx_hashtbl concurrently with bond
teardown. During rapid bond up/down cycles, rlb_deinitialize()
frees rx_hashtbl while RX handlers are still running, leading
to a use-after-free detected by KASAN.

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
[  214.315318]  ? __pfx_rlb_arp_recv+0x10/0x10 [bonding]                                                                                                  [  214.320975]  bond_handle_frame+0x166/0xb60 [bonding]
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

The issue is reproducible by looping ip link set bond0 up/down,
where rlb_arp_recv() can race with rlb_deinitialize() and dereference
a freed rx_hashtbl entry.

Fix this by setting recv_probe to NULL before calling
bond_alb_deinitialize(), and then calling synchronize_net() to wait
for any concurrent RX processing to finish.

This ensures that no RX handler can access rx_hashtbl after it is
freed, while preserving the existing locking semantics.

Reported-by: Liang Li <liali@redhat.com>
Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 47f13d86cb7e..8e1057a2a061 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4314,9 +4314,13 @@ static int bond_close(struct net_device *bond_dev)
 
 	bond_work_cancel_all(bond);
 	bond->send_peer_notif = 0;
+	bond->recv_probe = NULL;
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


