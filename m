Return-Path: <netdev+bounces-259622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCOYHpatl2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:40:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E34BF163E63
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 538FD302AF39
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC082192FA;
	Fri, 20 Feb 2026 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2ICjlhk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281C207A32
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548037; cv=none; b=Dt4AXHP3mLhz5RSzFl+M+5KJD4jMsH/nlHt+ksCZG3iQqYfYEY/J9L7OlgVF6hGfO9EuLnoJ1bO5K+SaCNWLYxTWi03/KUOMDV/JNzYW8EKZKQkEBTeEIy90ak9mhxW6u7YzMuK5NrepSHNmw3QkfrroYgppRtvb/Un9XRnSB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548037; c=relaxed/simple;
	bh=/vffyUlQAmsbMfp5j4wknq7ghcrVBJYOsWrwIKr+Zzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlATI2SXW6HoAyw8cAXY3moD0A1O3zNwHnm1uHoMktZic5eJzReaYfypEdy78eI65mFGeFnouOtm3FhGR1SOvPkdONfVwaZWQv77Sua7iqkMJg8P3DH7VZ8t3+Y4tf0xgvIP8Iwt64/9L11w61EHYwUe+RA457KNr0ncc2eWszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2ICjlhk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548036; x=1803084036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/vffyUlQAmsbMfp5j4wknq7ghcrVBJYOsWrwIKr+Zzw=;
  b=b2ICjlhknBzELpEtm4Rb/gb5TxKmRkvaSLgkWGgsPdan6E//hinLNAHE
   jgxeMeJdzY4Pv90x01bkXgeUIjwsyLcOouUo5nrszHJ9q9kSr6I2dMeJL
   Skct8djsbD0NtRWGJsXQWpyer2kmbIdvKXTXmSwSjDGeObkK/h80s8mBc
   r3dFRbTz+f7Iv6SROeAKjD3oMS7BI+M0D0QC7AXO873QI2sy9AuBdBMFw
   R2peSh4QtpPery12TN972qLLkw3fWMMaIoswlLKTkHdvm02PahHAZoa9q
   u5IvsyOm3S94jCZ7KXbfKsY1+c28N3piYaN17KL+dowl+CrFiwofunXg9
   Q==;
X-CSE-ConnectionGUID: 1a9iXiRzR3mOAyYi9q4zfA==
X-CSE-MsgGUID: u5TOAiHYQHmgFa2yvTJcyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484182"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484182"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:33 -0800
X-CSE-ConnectionGUID: JpzznSVmTZ6KzQ0hgoaXCA==
X-CSE-MsgGUID: se/16jjwQuKdU+NiCxIdAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850468"
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
Subject: [PATCH net 03/13] idpf: skip deallocating txq group's txqs if it is NULL
Date: Thu, 19 Feb 2026 16:40:15 -0800
Message-ID: <20260220004027.729384-4-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259622-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E34BF163E63
X-Rspamd-Action: no action

From: Li Li <boolli@google.com>

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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 59aafadae3d0..7613f020b622 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1316,6 +1316,9 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
 		for (unsigned int j = 0; j < txq_grp->num_txq; j++) {
+			if (!txq_grp->txqs[j])
+				continue;
+
 			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j])) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
-- 
2.47.1


