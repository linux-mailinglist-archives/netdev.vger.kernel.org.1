Return-Path: <netdev+bounces-294310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cDplJf4PH2q2ewAAu9opvQ
	(envelope-from <netdev+bounces-294310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 344EF6309E8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:16:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=OJ1cajXJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294310-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 966C030DF01E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB1E3F6C2C;
	Tue,  2 Jun 2026 17:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712E37F8DA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420175; cv=none; b=qT6uUy3MlQqkRvcLPG3pgDbkOab65P6JMi225MFTDVD7TXD1DWzGC428EOhYVVY5Vpl763V7ZH00V0wN5n8IDHCN+Rfu55yVhT1uEtl+nG9LXoYIHbwNvOxL7GKlV0FuW/L62rMnHXiN0NhgTNIECakxirX3SSxTQ/F2iBCymis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420175; c=relaxed/simple;
	bh=nRj26T7zJ310GnaZVo8UWEecUe0vUxwCVUiciD4hn0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bihcffBh3B4R46YNeQHhL0pZ4sUS4g62f2Kc1xYqKFtPt5modnFTqyBG07IHJ53OIPGpkoFmaRKEouUNv7JZdzlT3Ge2HPGLH0yJArWU96/obmGqEDV/E9EYUBGK9Y8FhwYmBiKKRB0BrM72ksETZLbzCWL74O7AXK+2zc/yo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ1cajXJ; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780420174; x=1811956174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRj26T7zJ310GnaZVo8UWEecUe0vUxwCVUiciD4hn0w=;
  b=OJ1cajXJNmGfM4D15w46GYu8ozGgtCpvtQL4cSmKdq2rkGq7LVbdvN11
   ozVGZCyrh5SPKKwQpEgTKkgNe70CVsAc8KLy1bNN2Be1rtRXvbZTjNiFQ
   fmfxAaFeoAGcS8xwrEIsX6ARH/96rkg+cG7jyuqkLw64ftDx8XJ2KE/pp
   wW8TA3GhmqJ+urt9GsmgwcY6ht80OdWLyI0jjSMW6Uz/Mw2ltgDjEw9Tm
   y7GXV8KtP3WdP8/YSh+I2mQlCQrqweKl/Zmozev8QBtlqCmAiltkkGc9W
   +nhjWAZ/pLZN8N3vTn5QEJPa/UFAE/q3psVijrHzKBNvwaDo/JYrguZKw
   Q==;
X-CSE-ConnectionGUID: YmqIL4hcS5+NshV5JuveTg==
X-CSE-MsgGUID: HPMGU3NQQQa4551ztA/tkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81074148"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81074148"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 10:09:32 -0700
X-CSE-ConnectionGUID: eIZFWocMSZWcX3NyPrkXJQ==
X-CSE-MsgGUID: PLvp+a+aQoyM15xObdSinQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241475798"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa008.fm.intel.com with ESMTP; 02 Jun 2026 10:09:32 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH net v2 2/3] idpf: fix next_to_clean data races
Date: Tue,  2 Jun 2026 10:20:23 -0700
Message-Id: <20260602172024.2285947-3-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260602172024.2285947-1-joshua.a.hay@intel.com>
References: <20260602172024.2285947-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 344EF6309E8

As reported by Sashiko [1], IDPF_DESC_UNUSED() evaluates
txq->next_to_clean twice, and next_to_clean can be concurrently updated
by NAPI.  next_to_clean can change between evaluations, resulting in a
miscalculated free descriptor count that is larger than the ring
capacity. Consequently, netif_subqueue_maybe_stop() could incorrectly
determine there is room in the queue, bypassing the stop mechanism and
allowing active in-flight descriptors to be overwritten.

This patch is based on commit 9eab46b7cb8d ("e1000: fix data race
between tx_ring->next_to_clean").

Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Link: https://sashiko.dev/#/patchset/20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962%40intel.com [1]
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 3 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h         | 9 ++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf5..a0e3de3ed0a9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -558,7 +558,8 @@ static bool idpf_tx_singleq_clean(struct idpf_tx_queue *tx_q, int napi_budget,
 	} while (likely(budget));
 
 	ntc += tx_q->desc_count;
-	tx_q->next_to_clean = ntc;
+	/* Sync with IDPF_DESC_UNUSED called from idpf_tx_singleq_frame. */
+	smp_store_release(&tx_q->next_to_clean, ntc);
 
 	*cleaned += ss.packets;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 34fc85cbb3f4..9cc4fbd13313 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2073,8 +2073,10 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 	struct idpf_tx_buf *tx_buf;
 
 	if (descs_only) {
-		/* Bump ring index to mark as cleaned. */
-		tx_q->next_to_clean = end;
+		/* Bump ring index to mark as cleaned and sync with
+		 * IDPF_DESC_UNUSED called from idpf_txq_has_room.
+		 */
+		smp_store_release(&tx_q->next_to_clean, end);
 		return;
 	}
 
@@ -2111,7 +2113,8 @@ static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 		idpf_tx_splitq_clean_bump_ntc(tx_q, ntc, tx_desc, tx_buf);
 	}
 
-	tx_q->next_to_clean = ntc;
+	/* Sync with IDPF_DESC_UNUSED called from idpf_txq_has_room. */
+	smp_store_release(&tx_q->next_to_clean, ntc);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..8eadc2682c96 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -119,9 +119,12 @@ do {								\
 #define IDPF_RXD_EOF_SPLITQ		VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_M
 #define IDPF_RXD_EOF_SINGLEQ		VIRTCHNL2_RX_BASE_DESC_STATUS_EOF_M
 
-#define IDPF_DESC_UNUSED(txq)     \
-	((((txq)->next_to_clean > (txq)->next_to_use) ? 0 : (txq)->desc_count) + \
-	(txq)->next_to_clean - (txq)->next_to_use - 1)
+#define IDPF_DESC_UNUSED(txq)						\
+({									\
+	unsigned int ntc = smp_load_acquire(&(txq)->next_to_clean);	\
+	unsigned int ntu = READ_ONCE((txq)->next_to_use);		\
+	(ntc > ntu ? 0 : (txq)->desc_count) + ntc - ntu - 1;		\
+})
 
 #define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)	((txcq)->desc_count >> 1)
 /* Determine the absolute number of completions pending, i.e. the number of
-- 
2.39.2


