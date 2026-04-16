Return-Path: <netdev+bounces-279137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBY5MrY84WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:47:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700B4144C8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFAD326CF67
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190A3E8C69;
	Thu, 16 Apr 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaoM3VaA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E133F8B1
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367908; cv=none; b=EDlQtN0ssfAzYf8he4CpsBDmgUHlYozE55MDzIie391cwnND642YGJmPtntELfxnqqs1epJS74pz+TSQI0MfXannRgLmVDtiiu74TpTcS/j12p/zdo2id6jxnArSFidE17iRB7HidFUgIQP6fex7wcWQIwO75+GJXqy5318u/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367908; c=relaxed/simple;
	bh=LM5hYuzMH6ffiS/N0TTnLjZ90DwI2L+DUWOWJuLqrTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=neLoNlAuRwRXBh1UJNWAyc4dPTGRA0Dm+3xaqyv9cpm495NndQfFA8Dh4v/3oM81Z+Pt7OpbhFk+XHO7CmJT6UFX0G/Ib1nE8wxYN0Ha9Axzg3mF/fHCs5QLnC8Jy0WN9YGtXk6s7vLI6zlL4ol095WzBy8WkEp94xlHovK/frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaoM3VaA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae4816912so56465485ad.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776367905; x=1776972705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgs7UR95RcJPPhoG4MVpZrEKO/rGvautchgjUBGmJno=;
        b=DaoM3VaA1751eGRsudp4OYoQ8XN4BHWCowvbsjyrldktx8em3khE9nlO9bipd0QAPM
         O3a9WtxRPNPrEhfoxo0ugBSgluAzNH2T3YDT8SYIsKFexQOYzeF6QPRsveHRuFdG9LlB
         pylyWFa29nr8PHExRDkHBompPbFSfgz55cktpblvcGTOnDPBwVOwTUnSQP7PR8GjWCS5
         1Q/L+e61bfOsq7GScW6LDD5k+AIcGDyMSSgaVzS1qfN/oe9WjeFA3gEllMmoS7I26vem
         pvL15jXXY2DbyT7x9LRC/AyxlbMf6lXHbQCYpTwNSRyqhpGruB5QBe7YptBC8dkzwlrO
         XmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367905; x=1776972705;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgs7UR95RcJPPhoG4MVpZrEKO/rGvautchgjUBGmJno=;
        b=N+OKjM8/3jjatTENCd/JM9fotOUGKMvuzM215mDAVujURjI9cuaMR5F5nYF5a09eD7
         vgq/N1uz0bvBA1Vvw/20lIH/q70hjqBlLxWK9IQwJ+JhJJjkV6dlkMp9Hps6swwLlwTP
         eX1emwk/vj0LSUInR5Y53+8ovTbGveeakwjSL+83heRs2LYzurq5XuVAyx67aDGKabN+
         XXNUyGwcXVt58oeJ2ZxYruY8SGHFiEdVrnxHW0cDyavFvjT7Sqr0zzpQ/K5TETJuWlru
         k1Or/nW+eFQ1lGebcENCegiKgZJEp76h5lrhUQV/q6nMPF0A9/GPozYbDN6tELFwX6Y+
         dRdQ==
X-Gm-Message-State: AOJu0Yz2y+y6MLd9vB0vRDMmJznGnAgaJL/521HbStqX9v555sUqWeBh
	QS6MuKs6+7oUixV++eP2igJ8mkneilZBDJqYUeTvFhbTE+oCf8yorex1
X-Gm-Gg: AeBDieslCXjdbWY4KnE+n85SE3S2YkhfoHJk6iEwZawiamhFsBg/CO98NAjyj04xfB5
	cGkVWBTsqeRCyRiwRExR9olWNChXFWo4DpZT4Q8PPDV4wzbsjzlK14NyUm3Bk/Or5Kn8pEUNXqJ
	+JmxJ4B8NMo42+YVMi7JZbtxI7yoC8jXcnPaZNlYhcvaBJQEjkMHkaHDMJ34rqOd12d6qgA8H/f
	OaL79cPOMzCggWdUC8mLspWqGJSfTcnbo5YvzkCfy/lJ7NCOCwE590yJ0nALL42xaWuiYVfmL1+
	77MzmBn86viEE5F1SbuNSCAzkbitTkCuOcA5ctqrrvFhquwqExl9rWUJ3sb+6w2hLMVbqdetAuE
	86nQ6gnIIqWzHW8Ydq1TXzq5ftoexRzDicIUVJuMoRxcz5Tcoo9ayaLQwM5hvc4w2ZdxFXGGM9a
	8jRXZem9paWP4kPDftUQpJFWD/vW1xiQ==
X-Received: by 2002:a17:902:9692:b0:2b4:5cd0:b6c3 with SMTP id d9443c01a7336-2b5f8f302a6mr2480875ad.29.1776367905122;
        Thu, 16 Apr 2026 12:31:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b1174sm78959915ad.70.2026.04.16.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:44 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 16 Apr 2026 12:31:39 -0700
Subject: [PATCH net] eth: fbnic: fix double-free of PCS on phylink creation
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-fbnic-pcs-fix-v1-1-ac4b6badeac0@meta.com>
X-B4-Tracking: v=1; b=H4sIABs54WkC/x3MQQqEMAwF0KuEvzZQ61ChVxlcaJqO2XSkFRHEu
 wu+A7wLTatpQ6QLVQ9r9i+I1HcEWefyU7aESPDOB/fpA+elmPAmjbOd7EMSP8iYdFZ0hK1qtvP
 9vii6Y7rvB1x3v81kAAAA
X-Change-ID: 20260416-fbnic-pcs-fix-26dc23c7deae
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279137-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 2700B4144C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

fbnic_phylink_create() stores the newly allocated PCS in fbn->pcs before
calling phylink_create(). When phylink_create() fails the error path
calls xpcs_destroy_pcs(pcs) to release the PCS, but neglects to clear
fbn->pcs.

The caller, fbnic_netdev_alloc(), responds to the failure by calling
fbnic_netdev_free() which in turn calls fbnic_phylink_destroy().  That
function checks fbn->pcs and, finding it non-NULL, calls
xpcs_destroy_pcs() a second time on the already-freed object, triggering
a refcount underflow use-after-free.

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

Fix by clearing fbn->pcs immediately after the error-path destroy so
fbnic_phylink_destroy() skips the second call.

Fixes: d0fe7104c795 ("fbnic: Replace use of internal PCS w/ Designware XPCS")
Assisted-by: Claude:claude-4.5-sonnet
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 09c5225111be..50240e6c2ee9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -237,6 +237,7 @@ int fbnic_phylink_create(struct net_device *netdev)
 		dev_err(netdev->dev.parent,
 			"Failed to create Phylink interface, err: %d\n", err);
 		xpcs_destroy_pcs(pcs);
+		fbn->pcs = NULL;
 		return err;
 	}
 

---
base-commit: ccd8e87748ad083047d6c8544c5809b7f96cc8df
change-id: 20260416-fbnic-pcs-fix-26dc23c7deae

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


