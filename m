Return-Path: <netdev+bounces-284152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FoALQ1L+WnC7gIAu9opvQ
	(envelope-from <netdev+bounces-284152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04014C5D03
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51E9A300BC7A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909A35DA68;
	Tue,  5 May 2026 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1ZNyh4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86463357A40
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945339; cv=none; b=uqUoj4+OFMxIit6cbYDLlqu0X1JnOC6bWSwtwhcSVhQ4Ijfvh55+k8QNsRNDmTli+OL5kQn/XdX+FSTn6gcsvSFqUMalFZqikD0PVukrCpgt2daEeWmGJMALa+OkLBHwcOv3x5fxQQzies7Xq+222s7K0VDK0Vl41PJVXT/BhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945339; c=relaxed/simple;
	bh=LkUNpoPrlYlPBwzPypDx/YLmnKafez5WSuI0Ke/g5Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JBniMqArNmSZjysPFV6QduYvi3DWaYdMIBJ3kf3/svdDP420vgz0luGQV4qdrCV8PDbO0ghkdJA26m55xUuZOZXtkYFSfnZ3in7zGadkzsjB2BZ+K8yNHGGPjqJZEJv/YzmcyFyyPpbisW8V4a7N2k1GueYhozFU8QoZhB5K1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1ZNyh4N; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso77636986d6.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777945336; x=1778550136; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNCiZlcXrmsFVrXzUpXqApJKpengJKHzXb7lYGwRWDA=;
        b=H1ZNyh4N/3KbIJIkAFhgHBa5qhDtc2AR65UrwMa1saZ7hFIGuUrKvvt0vt86m4UY2R
         u/Cp2ugpyGXk0Vjw7AY0j9kKTauo7qp/Soq/ad16T9l59KD7NNhNrA8h5XLd+HRZYhHr
         ss/WzKvTtANLVDz7IcL1DWrAVeeSNnS548FN8AaMYDs5PW0sei1OijTEv3ACvONqVw+b
         WYcrO1ZC7FdxvX5K+Bk19MVxVWt9IlJXCWGNzQKqZXCUkw55Ald+PCPhK8qnSE/0lxo6
         rZebCPzr1ERKvS8Eh7I07E7AyOXbUZS6DPjSUgV94hKIz4s359T4Zejs86pkDeemxk66
         2AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945336; x=1778550136;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNCiZlcXrmsFVrXzUpXqApJKpengJKHzXb7lYGwRWDA=;
        b=sXrkUukVOmYvkRJPOwwM/9whQA7gPK6t/B/JeoDmt0Mh8tK2Xx3ft5+AJqRnR/traJ
         PVnIxPYzQ524vQEN1gvSHDpcnKQZ+F5FMoXbVk8B+f/R4Sak3M0mQ4//OoBhrlBxhfSY
         q9MnurpCvNhXxIAGUscP0t7uNkSBJfkqbYAF5rjuSg47motTDD7mf5rNmWd2d1MlGaP8
         /cE0D5Y17jZi2rBUfyd0X21gMYHZZ22H8r54Y++LH8LuPvjnNI0hxJffAmJ+y5b7zFst
         WlQwgx6dI7yH9RIRaT/gyqPh2SGbjbncl6+Pe6MM3/ek8yeC8xpDJcOHN4SoEPuKzQap
         lQnQ==
X-Gm-Message-State: AOJu0YzGSmNtnLUCpjVKjpc4RtQukptWrcJkgQpoCL+XckRviSR8PgMr
	gLgDtfIvumCGnbUsluo0FIo3Th+V03U6PHgjj+4j+zBrOpoBkN4twbXJ
X-Gm-Gg: AeBDievEYsItGhptAg3MrxwIrJauybVmQZAEROaSPy63TJR6jFUjbPSWj48WPIPZIgS
	qVGuufYWUdItSmRTMYcrknbl1zzXEoR4xeb/1qeSMJd0wSuJ0V7NSo5lD/+MKTVYTjhjozk598V
	SPkVhgdB5SdRZ+bsn9SA8cgFEPdlwUNu2tZvNbTt1/1aqaQ0FuaymrG2u9LoHeQmsC/KJ+PItPx
	SiXHaXWJTe25rGHPLKr4xZrl103kgXfu38sgtK/BQb82gCz6ycRTaaJ7BNOMW/IXYZ9tclQGfJE
	8rjxyczdviv55hbshJZNWv+q9kjpOx/ZDdB83NAhG3nx511TnFgXYKG8zbuZowvl3lcQG4W7biI
	vLFcCluf1WFVhXr+PrUiWQWky+2nIqJsH7aLFao1L3RJbwI1l1rNen5d3PKOEpKtihqngFl3P48
	jdYPJp+grWrICtLuvgAmORuKnq99K4b6NM
X-Received: by 2002:a05:6214:258e:b0:89c:8669:18a5 with SMTP id 6a1803df08f44-8bade030272mr19038986d6.50.1777945336015;
        Mon, 04 May 2026 18:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:24::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538c13fc6sm134139796d6.4.2026.05.04.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:42:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 18:42:11 -0700
Subject: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
X-B4-Tracking: v=1; b=H4sIAPJK+WkC/3XNQQqDMBBG4auEf+0Uk0oKrnqP4iJOxjoLoyQii
 nj3gvuuH3zvRJGsUtCaE1k2LTontMZVBjyG9BXSiNbA1c7XjfU09EmZFi406E7OR3ZPfkUJgsp
 gyTLofnsfJFnRVQajlnXOx/3Y7J3+cJslS4Gb3vchSuD6PckaHjxP6K7r+gGJ++ucrgAAAA==
X-Change-ID: 20260416-fbnic-pcs-fix-26dc23c7deae
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B04014C5D03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284152-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

fbnic_phylink_create() stores the newly allocated PCS in fbn->pcs and
then calls phylink_create(). When phylink_create() fails, the error path
correctly destroys the PCS via xpcs_destroy_pcs(), but the caller,
fbnic_netdev_alloc(), responds by invoking fbnic_netdev_free() which
calls fbnic_phylink_destroy(). That function finds fbn->pcs non-NULL and
calls xpcs_destroy_pcs() a second time on the already-freed object,
triggering a refcount underflow use-after-free:

[   1.934973] fbnic 0000:01:00.0: Failed to create Phylink interface, err: -22
[   1.935103] ------------[ cut here ]------------
[   1.935179] refcount_t: underflow; use-after-free.
[   1.935252] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#0: swapper/0/1
[   1.935389] Modules linked in:
[   1.935484] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-virtme-04244-g1f5ffc672165-dirty #1 PREEMPT(lazy)
[   1.935661] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   1.935826] RIP: 0010:refcount_warn_saturate+0x59/0x90
[   1.935931] Code: 44 48 8d 3d 49 f9 a7 01 67 48 0f b9 3a e9 bf 1e 96 00 48 8d 3d 48 f9 a7 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 47 f9 a7 01 <67> 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 46 f9 a7 01 67 48 0f b9 3a
[   1.936274] RSP: 0000:ffffd0d440013c58 EFLAGS: 00010246
[   1.936376] RAX: 0000000000000000 RBX: ffff8f39c188c278 RCX: 000000000000002b
[   1.936524] RDX: ffff8f39c004f000 RSI: 0000000000000003 RDI: ffffffff96abab00
[   1.936692] RBP: ffff8f39c188c240 R08: ffffffff96988e88 R09: 00000000ffffdfff
[   1.936835] R10: ffffffff96878ea0 R11: 0000000000000187 R12: 0000000000000000
[   1.936970] R13: ffff8f39c0cef0c8 R14: ffff8f39c1ac01c0 R15: 0000000000000000
[   1.937114] FS:  0000000000000000(0000) GS:ffff8f3ba08b4000(0000) knlGS:0000000000000000
[   1.937273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   1.937382] CR2: ffff8f3b3ffff000 CR3: 0000000172642001 CR4: 0000000000372ef0
[   1.937540] Call Trace:
[   1.937619]  <TASK>
[   1.937698]  xpcs_destroy_pcs+0x25/0x40
[   1.937783]  fbnic_netdev_alloc+0x1e5/0x200
[   1.937859]  fbnic_probe+0x230/0x370
[   1.937939]  local_pci_probe+0x3e/0x90
[   1.938013]  pci_device_probe+0xbb/0x1e0
[   1.938091]  ? sysfs_do_create_link_sd+0x6d/0xe0
[   1.938188]  really_probe+0xc1/0x2b0
[   1.938282]  __driver_probe_device+0x73/0x120
[   1.938371]  driver_probe_device+0x1e/0xe0
[   1.938466]  __driver_attach+0x8d/0x190
[   1.938560]  ? __pfx___driver_attach+0x10/0x10
[   1.938663]  bus_for_each_dev+0x7b/0xd0
[   1.938758]  bus_add_driver+0xe8/0x210
[   1.938854]  driver_register+0x60/0x120
[   1.938929]  ? __pfx_fbnic_init_module+0x10/0x10
[   1.939026]  fbnic_init_module+0x25/0x60
[   1.939109]  do_one_initcall+0x49/0x220
[   1.939202]  ? rdinit_setup+0x20/0x40
[   1.939304]  kernel_init_freeable+0x1b0/0x310
[   1.939449]  ? __pfx_kernel_init+0x10/0x10
[   1.939560]  kernel_init+0x1a/0x1c0
[   1.939640]  ret_from_fork+0x1ed/0x240
[   1.939730]  ? __pfx_kernel_init+0x10/0x10
[   1.939805]  ret_from_fork_asm+0x1a/0x30
[   1.939886]  </TASK>
[   1.939927] ---[ end trace 0000000000000000 ]---
[   1.940184] fbnic 0000:01:00.0: Netdev allocation failed

Instead of calling fbnic_phylink_destroy(), the prior initialization of
netdev should just be unrolled with free_netdev() and clearing
fbd->netdev.

Clearing fbd->netdev to NULL avoids UAF in init_failure_mode where
callers guard by checking !fbd->netdev, such as fbnic_mdio_read_pmd().
These callers remain active even after a failed probe, so fdb->netdev
still needs to be cleared.

Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- instead of just clearing fbn->pcs, avoid the UAF by only doing
  teardown for netdev when phylink creation fails, avoid
  fbnic_phylink_destroy
- clear fbn->netdev to avoid failures in post-probe init_failure_mode
- Link to v1: https://lore.kernel.org/r/20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c406a3b56b37..4dea2bb58d2f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -826,7 +826,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netif_tx_stop_all_queues(netdev);
 
 	if (fbnic_phylink_create(netdev)) {
-		fbnic_netdev_free(fbd);
+		free_netdev(netdev);
+		fbd->netdev = NULL;
 		return NULL;
 	}
 

---
base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
change-id: 20260416-fbnic-pcs-fix-26dc23c7deae

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


