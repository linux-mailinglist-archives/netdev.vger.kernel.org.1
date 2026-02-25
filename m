Return-Path: <netdev+bounces-261078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIVnLbJmn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:16:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3F19DBDF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38823306CF44
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8D30F7EA;
	Wed, 25 Feb 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUUAsdQh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D91256C8B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054156; cv=none; b=f6tXdw4d7rHlS/Q5lXKwikZhp2zkoGKh7mnfvIzjfPGAcAiMCKXQUohQGqlSyK0T+6pr81aE5QW9lFMP8w4sukpdk4nvUPBIvFT56A45xSOgaYIM88xzwJpNTLNl1hf8CHdf3i5QGR/yk8A3PMYDFZ/kGFk/J7e/zSIP9WERWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054156; c=relaxed/simple;
	bh=Z34bwvel0RpcobJWAstqKkfjl9+YASEUgsWohQiR8AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWv48YusdDhLvRQWBKDtztqbUaBLYmUQEiSFlleIVgc96oCjkx6F/elYSefXbrcVJZmwqhSRB4iy1lQQElYWBg0wTDOMeeLCvV87TOXW+YzVhd3JXb0YiqP9gDepzxLQQ40q2/n5TpL0NhMe1mNy573Rr1ZbN7VVmmNiEQYEMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUUAsdQh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054155; x=1803590155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z34bwvel0RpcobJWAstqKkfjl9+YASEUgsWohQiR8AQ=;
  b=FUUAsdQhNIV6CzfwL9JvuBQoaR6jLfsj9crQtwvJycQoqZBbt9yn80hf
   Buf7t0jMXkCn6AeP1Zw4b619koU8omtqz4k67P9nfbB5wNxfsr7ap6DeW
   o2IeAwCIo2XnVVvaUkJIaycDsfbHGlbS6TT/hE0prdUZ9FaSJuYEtxYwP
   Ahs1FY/tT37Cfso4KcFqm3Zc8aagw7AR1U8UnSiQsqN/mlpVRjp9jcrAO
   EzBEitkeqrHyt/q9nYkMIJJ4uFdYAvmJi4ETVkGX34S0dyls8hk36vIi7
   YhoySSlt/xO/IdaOMU5da2s2hJ7d7C4QjSd3yPQYzaXNVJrZTGhfd3dYN
   Q==;
X-CSE-ConnectionGUID: iFJcidugSGi9d+mhCe5Jfg==
X-CSE-MsgGUID: lTWF4xuCRQCxARDovkjCRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013757"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013757"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:54 -0800
X-CSE-ConnectionGUID: /dob1ojsStKN2r8r5X3ahA==
X-CSE-MsgGUID: FiQRfTBbRfSArpVWKMoLIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349680"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:53 -0800
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
	joshua.a.hay@intel.com,
	brianvv@google.com,
	decot@google.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 01/12] idpf: increment completion queue next_to_clean in sw marker wait routine
Date: Wed, 25 Feb 2026 13:15:32 -0800
Message-ID: <20260225211546.1949260-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261078-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CB3F19DBDF
X-Rspamd-Action: no action

From: Li Li <boolli@google.com>

Currently, in idpf_wait_for_sw_marker_completion(), when an
IDPF_TXD_COMPLT_SW_MARKER packet is found, the routine breaks out of
the for loop and does not increment the next_to_clean counter. This
causes the subsequent NAPI polls to run into the same
IDPF_TXD_COMPLT_SW_MARKER packet again and print out the following:

    [   23.261341] idpf 0000:05:00.0 eth1: Unknown TX completion type: 5

Instead, we should increment next_to_clean regardless when an
IDPF_TXD_COMPLT_SW_MARKER packet is found.

Tested: with the patch applied, we do not see the errors above from NAPI
polls anymore.

Fixes: 9d39447051a0 ("idpf: remove SW marker handling from NAPI")
Signed-off-by: Li Li <boolli@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 376050308b06..761a77510467 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2348,7 +2348,7 @@ void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 
 	do {
 		struct idpf_splitq_4b_tx_compl_desc *tx_desc;
-		struct idpf_tx_queue *target;
+		struct idpf_tx_queue *target = NULL;
 		u32 ctype_gen, id;
 
 		tx_desc = flow ? &complq->comp[ntc].common :
@@ -2368,14 +2368,14 @@ void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 		target = complq->txq_grp->txqs[id];
 
 		idpf_queue_clear(SW_MARKER, target);
-		if (target == txq)
-			break;
 
 next:
 		if (unlikely(++ntc == complq->desc_count)) {
 			ntc = 0;
 			gen_flag = !gen_flag;
 		}
+		if (target == txq)
+			break;
 	} while (time_before(jiffies, timeout));
 
 	idpf_queue_assign(GEN_CHK, complq, gen_flag);
-- 
2.47.1


