Return-Path: <netdev+bounces-249217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B298AD15BF2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 584EE3009D52
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305033C19C;
	Mon, 12 Jan 2026 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ynLTSRMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D2332EC7
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259414; cv=none; b=BhahcghurBUIOg4+xy0JbB9ms5VdGlUUnBmOVL25L4efhL1T+qXvGv/HmauQ087vaEV/ljuN2kBfthOVMWO8fGI9WAD2r/kAvNl7u4kZsmwU6LX1zSZIwGTx1sO0BIYtWapXR75KbZ1r0rsvftI0nSj8LX5f6brNNlztVIWSscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259414; c=relaxed/simple;
	bh=OVeV2T7Schb9tKEgL7V9yVfcDlLFjn7Kd/3QGB2jaS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iuOSVM9ox+jAxhVQPVZPp1ijt8XiwlMQ5EHK2ZDWoQ4aqdTWd0dnZ7u5dlv5J0AbytoVIJFus+qb1GH7kH0FEjp5WPORqHK061ESqWRBCGWFJj0vBSecCI/xPEbKYAFtBIGSWeYDjvK+kaYZdb6tTUbY/IWvdnaXemj1BNKXWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ynLTSRMj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-121adbf76c3so8991399c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768259412; x=1768864212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GtgZegM7FjbeyuOL5Y6kyqpA7dLG8bpU56qxoB17r0=;
        b=ynLTSRMj+oVwvUq+S4c/t9F6Khf+qqUpOqTQdsVGQvhVQCpCPUIGQrKkllgUHAb86W
         zF6w6P7T2kPMPPXIG6bGFJQMcBjPEuifRNGZzUZjc9HQSoriLxiPSLd10jFHNoySoh8M
         oOH1F4Gwh6S0t4RCe3MR0EAMHytZ7lVKgOhTXfyo4GG4RyrfaB5Ca0Z6yTccLRmFxzOx
         KsjJvGDKBIDE3NaBwd71dfflQPnu47WeuEpiSn9h1a+61wieRJQOkpJSWA5hiyNFYC4G
         9dCV99ps66o0Mb45QX5NrkV15F1q8cq+nML7HXp53f8xvW2PeEXootcss+hkQZYT3TjQ
         saMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259412; x=1768864212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GtgZegM7FjbeyuOL5Y6kyqpA7dLG8bpU56qxoB17r0=;
        b=uxJEo2m2L2IzWA+ubBxT7CKkDMPNHdGgZIoHmv0C4NWzYb/0RHitEsl1DR14m39mO9
         ZZgnCIFCqnlO9ABwEuZpp+bq7pMP0zIEBJcQaPRnhRNgCyQL5rCFNMm+7DV9p9uTSOtL
         dEl9HapUQOxpJ4/46AsXT/n8UxaLfu8uTmRURlyrKHzHqvQ+sHQuIfjT/3UozXR62JvS
         3eivlXFsRcLEhGpPKZnlqu9WIW6xO9uoLfJE/TFBFUlGFFDVxiOfLF2DPS2fRzgDM07C
         17oBHmkIZT4F9LUmtdGVahQt0PY29tB3W31HgNtuis67mT/kIeWACmB0ZpQ97WUq77hO
         kK9A==
X-Gm-Message-State: AOJu0Yy2umcPZsTkJZhh8FPY1uHRk3JY5hTsbhGnS6X4ZPbxCyTrvDvH
	YA4nvh/XJfCUK95TAKXBXQWb7bWqfn7t84QqnLNd9irTDr2je7GzM+5jwnMkkhf4FCwxWgPTgJu
	szCjuMQ==
X-Google-Smtp-Source: AGHT+IFUZfbTXF1Fw1Cvh/r4GdD8A92eVq9LwJaEBG9JrsMm9bSGeUApjkJeHgxbw+xleiw77AYeSVOJYO4=
X-Received: from dlbti6.prod.google.com ([2002:a05:7022:1b06:b0:11f:3484:4f15])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f90:b0:11d:c04a:dc5b
 with SMTP id a92af1059eb24-121f8b7a790mr16487972c88.30.1768259411873; Mon, 12
 Jan 2026 15:10:11 -0800 (PST)
Date: Mon, 12 Jan 2026 23:09:44 +0000
In-Reply-To: <20260112230944.3085309-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112230944.3085309-1-boolli@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112230944.3085309-3-boolli@google.com>
Subject: [PATCH 2/2] idpf: skip deallocating txq group's txqs if it is NULL.
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"

In idpf_txq_group_alloc(), if any txq group's txqs failed to
allocate memory:

	for (j = 0; j < tx_qgrp->num_txq; j++) {
		tx_qgrp->txqs[j] = kzalloc(sizeof(*tx_qgrp->txqs[j]),
					   GFP_KERNEL);
		if (!tx_qgrp->txqs[j])
			goto err_alloc;
	}

It would cause a NULL ptr kernel panic in idpf_txq_group_rel():

	for (j = 0; j < txq_grp->num_txq; j++) {
		if (flow_sch_en) {
			kfree(txq_grp->txqs[j]->refillq);
			txq_grp->txqs[j]->refillq = NULL;
		}

		kfree(txq_grp->txqs[j]);
		txq_grp->txqs[j] = NULL;
	}

[    6.532461] BUG: kernel NULL pointer dereference, address: 0000000000000058
...
[    6.534433] RIP: 0010:idpf_txq_group_rel+0xc9/0x110
...
[    6.538513] Call Trace:
[    6.538639]  <TASK>
[    6.538760]  idpf_vport_queues_alloc+0x75/0x550
[    6.538978]  idpf_vport_open+0x4d/0x3f0
[    6.539164]  idpf_open+0x71/0xb0
[    6.539324]  __dev_open+0x142/0x260
[    6.539506]  netif_open+0x2f/0xe0
[    6.539670]  dev_open+0x3d/0x70
[    6.539827]  bond_enslave+0x5ed/0xf50
[    6.540005]  ? rcutree_enqueue+0x1f/0xb0
[    6.540193]  ? call_rcu+0xde/0x2a0
[    6.540375]  ? barn_get_empty_sheaf+0x5c/0x80
[    6.540594]  ? __kfree_rcu_sheaf+0xb6/0x1a0
[    6.540793]  ? nla_put_ifalias+0x3d/0x90
[    6.540981]  ? kvfree_call_rcu+0xb5/0x3b0
[    6.541173]  ? kvfree_call_rcu+0xb5/0x3b0
[    6.541365]  do_set_master+0x114/0x160
[    6.541547]  do_setlink+0x412/0xfb0
[    6.541717]  ? security_sock_rcv_skb+0x2a/0x50
[    6.541931]  ? sk_filter_trim_cap+0x7c/0x320
[    6.542136]  ? skb_queue_tail+0x20/0x50
[    6.542322]  ? __nla_validate_parse+0x92/0xe50
ro[o t   t o6 .d5e4f2a5u4l0t]-  ? security_capable+0x35/0x60
[    6.542792]  rtnl_newlink+0x95c/0xa00
[    6.542972]  ? __rtnl_unlock+0x37/0x70
[    6.543152]  ? netdev_run_todo+0x63/0x530
[    6.543343]  ? allocate_slab+0x280/0x870
[    6.543531]  ? security_capable+0x35/0x60
[    6.543722]  rtnetlink_rcv_msg+0x2e6/0x340
[    6.543918]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    6.544138]  netlink_rcv_skb+0x16a/0x1a0
[    6.544328]  netlink_unicast+0x20a/0x320
[    6.544516]  netlink_sendmsg+0x304/0x3b0
[    6.544748]  __sock_sendmsg+0x89/0xb0
[    6.544928]  ____sys_sendmsg+0x167/0x1c0
[    6.545116]  ? ____sys_recvmsg+0xed/0x150
[    6.545308]  ___sys_sendmsg+0xdd/0x120
[    6.545489]  ? ___sys_recvmsg+0x124/0x1e0
[    6.545680]  ? rcutree_enqueue+0x1f/0xb0
[    6.545867]  ? rcutree_enqueue+0x1f/0xb0
[    6.546055]  ? call_rcu+0xde/0x2a0
[    6.546222]  ? evict+0x286/0x2d0
[    6.546389]  ? rcutree_enqueue+0x1f/0xb0
[    6.546577]  ? kmem_cache_free+0x2c/0x350
[    6.546784]  __x64_sys_sendmsg+0x72/0xc0
[    6.546972]  do_syscall_64+0x6f/0x890
[    6.547150]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    6.547393] RIP: 0033:0x7fc1a3347bd0
...
[    6.551375] RIP: 0010:idpf_txq_group_rel+0xc9/0x110
...
[    6.578856] Rebooting in 10 seconds..

We should skip deallocating txqs[j] if it is NULL in the first place.

Tested: with this patch, the kernel panic no longer appears.
Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index b4dab4a8ee11b..25207da6c995d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1311,6 +1311,9 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
 		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
 
 		for (j = 0; j < txq_grp->num_txq; j++) {
+			if (!txq_grp->txqs[j])
+				continue;
+
 			if (flow_sch_en) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
-- 
2.52.0.457.g6b5491de43-goog


