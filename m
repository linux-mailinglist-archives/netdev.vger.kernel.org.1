Return-Path: <netdev+bounces-105734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB9912844
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F3281280
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6D38F83;
	Fri, 21 Jun 2024 14:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16128DD1
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981123; cv=none; b=ELpmOuxHaUoxpV2Hyormq6jSePwyRHZl5GihIxHptvepY7HRCxgTRNrJQtGKUY9dzXZiSPmHLir1aJjZUxZMWW5YbzDeY3KSEBSnFdgrZu3gXG9SQgNxq803pZ8LC4n5Jm2qpGrT2mYjiiynx1q+NTZoz9PcoNBJpnE8ZcW9SW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981123; c=relaxed/simple;
	bh=9LC7AFpzsypdF/je0j2fPv+EpS6IJOVD90KoMPdMqAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGaxqGT912L2e3NkN1y8LKuY2IzEvipzbOeoKt22nuCHx2WqN90yRNnJFtkX7gS6zCWFXY0A1rnrgYLljSJoRnhJbvKZfg9UoyfETV6qjMFpcrIhMucaVkK/AqPbgoKQin/AQFy/mbXa7BCFEEfXsPjbBsBEhmIu5KgVt0UYoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5970fcfD871714591023AA0CD.dip0.t-ipconnect.de [IPv6:2003:c5:970f:cfd8:7171:4591:23a:a0cd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 440BCFA14A;
	Fri, 21 Jun 2024 16:39:23 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/2] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"
Date: Fri, 21 Jun 2024 16:39:15 +0200
Message-Id: <20240621143915.49137-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621143915.49137-1-sw@simonwunderlich.de>
References: <20240621143915.49137-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

This reverts commit 537db05da2ca8ccc1243c9dd1d0c148b84aa0432.

This change seems to result in a memory leak / RCU race and the following
kernel splat when the batman-adv kernel module is unloaded:

```
[  112.208633] =============================================================================
[  112.210359] BUG batadv_tl_cache (Tainted: G           OE     ): Objects remaining in batadv_tl_cache on __kmem_cache_shutdown()
[  112.211943] -----------------------------------------------------------------------------

[  112.212517] Slab 0xffffe8afc0216d00 objects=16 used=1 fp=0xffff93f4085b4340 flags=0xfffffc0000a00(workingset|slab|node=0|zone=1|lastcpupid=0x1fffff)
[  112.212517] CPU: 1 PID: 776 Comm: rmmod Tainted: G           OE      6.8.12-amd64 #1  Debian 6.8.12-1
[  112.212517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  112.212517] Call Trace:
[  112.212517]  <TASK>
[  112.212517]  dump_stack_lvl+0x64/0x80
[  112.212517]  slab_err+0xe6/0x120
[  112.212517]  __kmem_cache_shutdown+0x160/0x2e0
[  112.212517]  kmem_cache_destroy+0x55/0x160
[  112.220849]  batadv_tt_cache_destroy+0x15/0x60 [batman_adv]
[  112.220849]  __do_sys_delete_module+0x1d5/0x320
[  112.220849]  do_syscall_64+0x83/0x190
[  112.220849]  ? do_syscall_64+0x8f/0x190
[  112.220849]  ? exc_page_fault+0x7f/0x180
[  112.220849]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[  112.224478] RIP: 0033:0x7f2ac8434977
[  112.224478] Code: 73 01 c3 48 8b 0d a9 94 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 94 0c 00 f7 d8 64 89 01 48
[  112.224478] RSP: 002b:00007ffe0adf6138 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  112.224478] RAX: ffffffffffffffda RBX: 000055db9018e770 RCX: 00007f2ac8434977
[  112.224478] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055db9018e7d8
[  112.224478] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
[  112.224478] R10: 00007f2ac84a6ac0 R11: 0000000000000206 R12: 00007ffe0adf6390
[  112.224478] R13: 000055db9018e770 R14: 000055db9018d2a0 R15: 0000000000000000
[  112.233961]  </TASK>
[  112.233961] Disabling lock debugging due to kernel taint
[  112.233961] Object 0xffff93f4085b4140 @offset=320
[  112.233961] Allocated in batadv_tt_local_add+0x297/0xa20 [batman_adv] age=15835 cpu=1 pid=755
[  112.233961]  batadv_tt_local_add+0x297/0xa20 [batman_adv]
[  112.233961]  batadv_interface_set_mac_addr+0xf6/0x120 [batman_adv]
[  112.233961]  dev_set_mac_address+0xde/0x140
[  112.233961]  dev_set_mac_address_user+0x30/0x50
[  112.233961]  do_setlink+0x261/0x12d0
[  112.233961]  rtnl_setlink+0x11f/0x1d0
[  112.233961]  rtnetlink_rcv_msg+0x152/0x3c0
[  112.241772]  netlink_rcv_skb+0x5b/0x110
[  112.241772]  netlink_unicast+0x1a6/0x290
[  112.241772]  netlink_sendmsg+0x223/0x490
[  112.241772]  __sys_sendto+0x1df/0x1f0
[  112.241772]  __x64_sys_sendto+0x24/0x30
[  112.241772]  do_syscall_64+0x83/0x190
[  112.241772]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[  112.245994] ------------[ cut here ]------------
[  112.246650] kmem_cache_destroy batadv_tl_cache: Slab cache still has objects when called from batadv_tt_cache_destroy+0x15/0x60 [batman_adv]
[  112.246668] WARNING: CPU: 1 PID: 776 at mm/slab_common.c:493 kmem_cache_destroy+0x14d/0x160
[  112.249584] Modules linked in: veth batman_adv(OE-) cfg80211 rfkill bridge stp llc libcrc32c crc32c_generic crc16 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver binfmt_misc pcspkr button joydev evdev serio_raw loop dm_mod efi_pstore nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg ip_tables x_tables autofs4 nfsv3 nfs_acl nfs lockd grace sunrpc 9pnet_rdma rdma_cm iw_cm ib_cm ib_core configfs 9p netfs ata_generic ata_piix libata psmouse scsi_mod 9pnet_virtio i2c_piix4 9pnet e1000 scsi_common floppy crypto_simd cryptd
[  112.256555] CPU: 1 PID: 776 Comm: rmmod Tainted: G    B      OE      6.8.12-amd64 #1  Debian 6.8.12-1
[  112.258457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  112.260410] RIP: 0010:kmem_cache_destroy+0x14d/0x160
[  112.261687] Code: 00 eb be 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 8b 53 60 48 8b 4c 24 20 48 c7 c6 60 d5 e3 98 48 c7 c7 b8 ec 2d 99 e8 43 0d d8 ff <0f> 0b e9 e2 fe ff ff c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90
[  112.265219] RSP: 0018:ffffb3b2806e7e48 EFLAGS: 00010282
[  112.266044] RAX: 0000000000000000 RBX: ffff93f4270a2640 RCX: 0000000000000027
[  112.267157] RDX: ffff93f43c521708 RSI: 0000000000000001 RDI: ffff93f43c521700
[  112.268268] RBP: 000055db9018e7d8 R08: 0000000000000000 R09: ffffb3b2806e7cd8
[  112.269418] R10: ffffb3b2806e7cd0 R11: 0000000000000003 R12: 0000000080012d00
[  112.270572] R13: ffffb3b2806e7f58 R14: 0000000000000000 R15: 0000000000000000
[  112.271699] FS:  00007f2ac8308440(0000) GS:ffff93f43c500000(0000) knlGS:0000000000000000
[  112.273001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.273923] CR2: 00005584ef830110 CR3: 000000000787c000 CR4: 00000000000006f0
[  112.275050] Call Trace:
[  112.275464]  <TASK>
[  112.275810]  ? kmem_cache_destroy+0x14d/0x160
[  112.276518]  ? __warn+0x81/0x130
[  112.277043]  ? kmem_cache_destroy+0x14d/0x160
[  112.277730]  ? report_bug+0x171/0x1a0
[  112.278315]  ? prb_read_valid+0x1b/0x30
[  112.278919]  ? handle_bug+0x3c/0x80
[  112.279467]  ? exc_invalid_op+0x17/0x70
[  112.280071]  ? asm_exc_invalid_op+0x1a/0x20
[  112.280741]  ? kmem_cache_destroy+0x14d/0x160
[  112.281603]  ? kmem_cache_destroy+0x14d/0x160
[  112.282489]  batadv_tt_cache_destroy+0x15/0x60 [batman_adv]
[  112.283373]  __do_sys_delete_module+0x1d5/0x320
[  112.284080]  do_syscall_64+0x83/0x190
[  112.284696]  ? do_syscall_64+0x8f/0x190
[  112.285315]  ? exc_page_fault+0x7f/0x180
[  112.285970]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[  112.286768] RIP: 0033:0x7f2ac8434977
[  112.287355] Code: 73 01 c3 48 8b 0d a9 94 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 94 0c 00 f7 d8 64 89 01 48
[  112.290282] RSP: 002b:00007ffe0adf6138 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  112.291465] RAX: ffffffffffffffda RBX: 000055db9018e770 RCX: 00007f2ac8434977
[  112.292595] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055db9018e7d8
[  112.293724] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
[  112.294863] R10: 00007f2ac84a6ac0 R11: 0000000000000206 R12: 00007ffe0adf6390
[  112.295982] R13: 000055db9018e770 R14: 000055db9018d2a0 R15: 0000000000000000
[  112.297103]  </TASK>
[  112.297465] ---[ end trace 0000000000000000 ]---
```

So far, after some debugging, the actual cause for this could
not immediately be found within the batman-adv code.
Therefore reverting this for now until the underlying issue can be
found and better understood.

Some additional debugging information and discussions can be found
on our Redmine bugtracker, linked below.

Link: https://www.open-mesh.org/issues/428
Fixes: 537db05da2ca ("batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 47 ++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b21ff3c36b07..2243cec18ecc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -208,6 +208,20 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
+/**
+ * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
+ * @rcu: rcu pointer of the tt_local_entry
+ */
+static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_tt_local_entry *tt_local_entry;
+
+	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
+				      common.rcu);
+
+	kmem_cache_free(batadv_tl_cache, tt_local_entry);
+}
+
 /**
  * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
@@ -222,7 +236,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 
 	batadv_softif_vlan_put(tt_local_entry->vlan);
 
-	kfree_rcu(tt_local_entry, common.rcu);
+	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
 }
 
 /**
@@ -240,6 +254,20 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 		 batadv_tt_local_entry_release);
 }
 
+/**
+ * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
+ * @rcu: rcu pointer of the tt_global_entry
+ */
+static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+
+	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
+				       common.rcu);
+
+	kmem_cache_free(batadv_tg_cache, tt_global_entry);
+}
+
 /**
  * batadv_tt_global_entry_release() - release tt_global_entry from lists and
  *  queue for free after rcu grace period
@@ -254,7 +282,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
 
 	batadv_tt_global_del_orig_list(tt_global_entry);
 
-	kfree_rcu(tt_global_entry, common.rcu);
+	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
 }
 
 /**
@@ -379,6 +407,19 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 	batadv_tt_global_size_mod(orig_node, vid, -1);
 }
 
+/**
+ * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
+ * @rcu: rcu pointer of the orig_entry
+ */
+static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+
+	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
+
+	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
+}
+
 /**
  * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
  *  queue for free after rcu grace period
@@ -392,7 +433,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 				  refcount);
 
 	batadv_orig_node_put(orig_entry->orig_node);
-	kfree_rcu(orig_entry, rcu);
+	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
 }
 
 /**
-- 
2.39.2


