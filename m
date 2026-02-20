Return-Path: <netdev+bounces-259621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJkuHPGtl2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:42:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DD163E9D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDC623053E24
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151F21256C;
	Fri, 20 Feb 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFyuqGx2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B361F09A8
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548036; cv=none; b=ZQmFIhgIDEcGwqfPFJdh5SmCEEo4ed28KuKSLwFpFBXoiRmJ6T1JelIZ7ZO3PcPL8CjDV15fHQspk7cUitiOI1BeQ92S4vQFFKa72jTJa2Wyiwk6rIf+EmciJbR1O0jtuA+Yu5daoRBR7FTSHTMgcEEXywJw4qpAO1gOft0NA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548036; c=relaxed/simple;
	bh=qyL79UJeXMoJ6TWFyEHTobY/AX7xlzv9jxB8XkisKjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgN9MZUYfvjrnX2OsaO1jWC79b8cJFgrdR1hUao/1mWXgFnvIB6EyWJfetSWibagbeyUkWugESmI7lL/egDJJngtAkwSpasNAllrHqG99CIMtyDYcsy0TEChxEh7ZH93Yn6dCskBl/zG9dZPWH6carSzppndCl7UlCsMn3w7p7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFyuqGx2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548035; x=1803084035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyL79UJeXMoJ6TWFyEHTobY/AX7xlzv9jxB8XkisKjY=;
  b=aFyuqGx2AtMWgv44c8MEoSjl7P2NPaX1f46eqOTk+xnNoWrgqVxW1Mul
   VW9/R67KQFJlDy/Qe3MUtZgVZ66nKuN0ECbKgVfiU7NjolVYLUtjOLj3p
   pXljg2jFO5NiUPYln9bjkLg2NB0m9mOHI7ZrlPMWvMbnAsPtn2Bwk9CO1
   oTAJe8Mh76Vrd9Wqnds6hhNO8GIf2AN+ChF0ZFthF4F7TKCf2No4YXi8X
   5+l3abGYV7PIi63mVtZ9XeT8thJub1WYwZG6JS4hLf95kCS/TtCygwFZg
   IDcnf41Opr410KyZulUzfzoMpw2Uia6KuY7NnEYiXZTnjfLqWxyaWMSCW
   Q==;
X-CSE-ConnectionGUID: II2xuxZpSKO8P/syRbMNqw==
X-CSE-MsgGUID: LbEmsBCNQgu5ixnQ7MciVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484175"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484175"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:33 -0800
X-CSE-ConnectionGUID: VbTc0exCRQO3d71001Efjg==
X-CSE-MsgGUID: n7ePzNJUSsOIBK6eRjW9xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850465"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:33 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Li Li <boolli@google.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	sridhar.samudrala@intel.com,
	brianvv@google.com,
	decot@google.com,
	willemb@google.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 02/13] idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
Date: Thu, 19 Feb 2026 16:40:14 -0800
Message-ID: <20260220004027.729384-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259621-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D14DD163E9D
X-Rspamd-Action: no action

From: Li Li <boolli@google.com>

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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 761a77510467..59aafadae3d0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1341,6 +1341,9 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
  */
 static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
 {
+	if (!rx_qgrp->splitq.bufq_sets)
+		return;
+
 	for (unsigned int i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
 		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];
 
-- 
2.47.1


