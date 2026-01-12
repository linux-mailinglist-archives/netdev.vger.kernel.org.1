Return-Path: <netdev+bounces-249216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09817D15BE9
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7CB300CEFF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D131B117;
	Mon, 12 Jan 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zukxraCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7222311C33
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259411; cv=none; b=az/w4ln5MZmLWup4kx+a5Vi+a8/RBMmCgEB1cOWxC9R3TURJcN7AyeK/fyMzuTjD9SZCJCEFx7Yr1u8zxL3lAJWRt+Qc+4F4QfjAC/4UoQ0GG5WOsHjWRHnu/cWLSvDjlwYFhfFujr08DSRSGpZxnAfg45goGwWfCAD63OOFK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259411; c=relaxed/simple;
	bh=hSt66rCqqC73KbbbiO9lZskui0WT+x9BIB/TbYXiN04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/cWU/O4MrmcnEkzwYte9ruuHH1xGkN77ryO4uzT5lmn0tdx1B4N5eoI3I9+ekLZ7RuPU0VsbaArNAPf3k4vlj+Fzf8u6YsTSfTemsvTRfUwcaW3gWRjY+sqrU0+2O7/dcq5eOJFJoIAPYtw/wpsW6Yx8O0hWRa0aSD2/husxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zukxraCT; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b21d136010so1863285eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768259409; x=1768864209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ys9dvyGwIYrmKuQ4BRnJwsHizh4UyGAtZEMdFdAVXfI=;
        b=zukxraCTWDZAQPmozTvcQ7hQV9IxtM2+345IR+gm+GfCLPNApdfneh/AeO1j3n7nYx
         Tnz2g/jxbeEHoXvkCCmq61x6AbCmKYFh6fNsw96F4tn4pE2TMa2Qg1LMMih2pv4xvoYo
         MeaeUvBpt1qJooYYbVQLgGbhigIEV+Gvs58zvw2vJoTJgwglCSAUI1hCkqkdTcE6HnJ9
         3J2N/y4IwpMlqq4LQDyUCbALI0tbdQhrXV8S+zkY49Lus59FT7p/dIyAgi9jiRSqjc9c
         e3/0lU9CKWyOVEy2p7uym/q8H4fC4n5ZcZTQiwZhjftIDSk15lqw4A1Gxkhu4bjO7Jnm
         mg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259409; x=1768864209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ys9dvyGwIYrmKuQ4BRnJwsHizh4UyGAtZEMdFdAVXfI=;
        b=Sf6es6O7G0lN84VwiP4bIg2riVqQFOfC1t+wpkosVIDS7Ad641q2+nDAzuwCaGfRBI
         FhtbJSNanyWinAmuphOBumbMNcRBqmhal3n4vrVPRybh2I5sCbXCTiubWhunopEu0Oew
         3Xn9aFrtQTYfWMa6Niv+53EGDS03uKUUvqfNts0jK0KgqWY+uyzWCboZir2KYv43p/hp
         J4ZBEeQswMFxRJjROurX5+WtrtUXC7A8qCxyw8gVV72Bx8m/K4aYLN544F30NveYP6ha
         BlKtKPatK+5C6+6dlz0sGY2hz/Dwb+h1URJMmIvQy+ru2NgXv1ONjgH8Vob/5/hTcrvw
         mzEw==
X-Gm-Message-State: AOJu0YzoQqKJl68C3k5H14sgr3lF8iGbRud2oAXmbF8RhRc5IpBywuqk
	i1Os14KOPXhf2JyM6BfBIBr7dyO8Tp4HGIOpMSp7GSq78med2E6pvHbg16yEdgSnWGeaugLV5FB
	TRuArvQ==
X-Google-Smtp-Source: AGHT+IG2eLtwALIqRuLzTvWBZTR3JwnqCHU/cLQ/o7m/M8FDpJLzndU6O/Y0t/1rJsF81ci2jWQlHUXyLwY=
X-Received: from dlbtp2.prod.google.com ([2002:a05:7022:3b82:b0:123:2dd9:db4])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6286:b0:119:e56b:9899
 with SMTP id a92af1059eb24-121f8a5b4demr19013846c88.0.1768259409124; Mon, 12
 Jan 2026 15:10:09 -0800 (PST)
Date: Mon, 12 Jan 2026 23:09:43 +0000
In-Reply-To: <20260112230944.3085309-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112230944.3085309-1-boolli@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112230944.3085309-2-boolli@google.com>
Subject: [PATCH 1/2] idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL.
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"

In idpf_rxq_group_alloc(), if rx_qgrp->splitq.bufq_sets failed to get
allocated:

	rx_qgrp->splitq.bufq_sets = kcalloc(vport->num_bufqs_per_qgrp,
					    sizeof(struct idpf_bufq_set),
					    GFP_KERNEL);
	if (!rx_qgrp->splitq.bufq_sets) {
		err = -ENOMEM;
		goto err_alloc;
	}

idpf_rxq_group_rel() would attempt to deallocate it in
idpf_rxq_sw_queue_rel(), causing a kernel panic:

```
[    7.967242] early-network-sshd-n-rexd[3148]: knetbase: Info: [    8.127804] BUG: kernel NULL pointer dereference, address: 00000000000000c0
...
[    8.129779] RIP: 0010:idpf_rxq_group_rel+0x101/0x170
...
[    8.133854] Call Trace:
[    8.133980]  <TASK>
[    8.134092]  idpf_vport_queues_alloc+0x286/0x500
[    8.134313]  idpf_vport_open+0x4d/0x3f0
[    8.134498]  idpf_open+0x71/0xb0
[    8.134668]  __dev_open+0x142/0x260
[    8.134840]  netif_open+0x2f/0xe0
[    8.135004]  dev_open+0x3d/0x70
[    8.135166]  bond_enslave+0x5ed/0xf50
[    8.135345]  ? nla_put_ifalias+0x3d/0x90
[    8.135533]  ? kvfree_call_rcu+0xb5/0x3b0
[    8.135725]  ? kvfree_call_rcu+0xb5/0x3b0
[    8.135916]  do_set_master+0x114/0x160
[    8.136098]  do_setlink+0x412/0xfb0
[    8.136269]  ? security_sock_rcv_skb+0x2a/0x50
[    8.136509]  ? sk_filter_trim_cap+0x7c/0x320
[    8.136714]  ? skb_queue_tail+0x20/0x50
[    8.136899]  ? __nla_validate_parse+0x92/0xe50
[    8.137112]  ? security_capable+0x35/0x60
[    8.137304]  rtnl_newlink+0x95c/0xa00
[    8.137483]  ? __rtnl_unlock+0x37/0x70
[    8.137664]  ? netdev_run_todo+0x63/0x530
[    8.137855]  ? allocate_slab+0x280/0x870
[    8.138044]  ? security_capable+0x35/0x60
[    8.138235]  rtnetlink_rcv_msg+0x2e6/0x340
[    8.138431]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[    8.138650]  netlink_rcv_skb+0x16a/0x1a0
[    8.138840]  netlink_unicast+0x20a/0x320
[    8.139028]  netlink_sendmsg+0x304/0x3b0
[    8.139217]  __sock_sendmsg+0x89/0xb0
[    8.139399]  ____sys_sendmsg+0x167/0x1c0
[    8.139588]  ? ____sys_recvmsg+0xed/0x150
[    8.139780]  ___sys_sendmsg+0xdd/0x120
[    8.139960]  ? ___sys_recvmsg+0x124/0x1e0
[    8.140152]  ? rcutree_enqueue+0x1f/0xb0
[    8.140341]  ? rcutree_enqueue+0x1f/0xb0
[    8.140528]  ? call_rcu+0xde/0x2a0
[    8.140695]  ? evict+0x286/0x2d0
[    8.140856]  ? rcutree_enqueue+0x1f/0xb0
[    8.141043]  ? kmem_cache_free+0x2c/0x350
[    8.141236]  __x64_sys_sendmsg+0x72/0xc0
[    8.141424]  do_syscall_64+0x6f/0x890
[    8.141603]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    8.141841] RIP: 0033:0x7f2799d21bd0
...
[    8.149905] Kernel panic - not syncing: Fatal exception
[    8.175940] Kernel Offset: 0xf800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    8.176425] Rebooting in 10 seconds..
```

Tested: With this patch, the kernel panic no longer appears.
Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e7b131dba200c..b4dab4a8ee11b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1337,6 +1337,8 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
 static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
 {
 	int i, j;
+	if (!rx_qgrp->splitq.bufq_sets)
+		return;
 
 	for (i = 0; i < rx_qgrp->vport->num_bufqs_per_qgrp; i++) {
 		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];
-- 
2.52.0.457.g6b5491de43-goog


