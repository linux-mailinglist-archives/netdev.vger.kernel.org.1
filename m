Return-Path: <netdev+bounces-268340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIlpKB2SuGlhgAEAu9opvQ
	(envelope-from <netdev+bounces-268340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:28:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FA2A1F52
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 371F1301A7BD
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726137A49C;
	Mon, 16 Mar 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQDFGCP8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA06379ED4
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703694; cv=none; b=V+PU5o879DW9LTcsXTdwJjEsOTNX5ByxXB3ucvTtRbMK7W/u7+BPtz69YdtauR3Y+N/I9C7ORYRx3yoXW3w6NnaL8+1ukcA0Ta+Gh0wt80gAsZr5oO25sR5BKr+FZnOB2qXhgMaJUAkPFNEA24EBYEaOUG+8Qx4cI5bxFVEToS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703694; c=relaxed/simple;
	bh=DFeoIGpeGpPd8Y9tGCMjZ0K7fdB1gVfv3VkHksUekN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j6xry7lzE4WSdrmk4VCqiNjxqgkK2uyMwMGGHO2UXG7Qxo6BL7G1Pc5hnywdnAgLcs5fWwgf+eid4e0uZ83ETbKu2Z2B0ugk3qgoRH79HBNpwuLkM7dt9SCgU2SwYgugN3Km4dgGfS3kDa5vdJ0I29txm6t44t3fEuFpNVtARbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQDFGCP8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773703692; x=1805239692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DFeoIGpeGpPd8Y9tGCMjZ0K7fdB1gVfv3VkHksUekN0=;
  b=NQDFGCP8gecMgRzOwpjhBKVwkHVI/0AU4kU33gAXPAXb7wwoQosOGK5m
   70U4Oy509GANoZc1If4mYHrY8Ar09kLG+fQFbOZ4CmFzmhb5SK+mjhW//
   aOAoaHaZn2Vrs3JQa19XORAiFOcTvPMGMPVQZMGuI39nM3u1R6QfDnAcf
   U+1vhRSpckviu89Xj0IJdQOndA1Qd4FYS7l1lVdLklhld1GXPCDRUun3k
   et7inwo1V0PIlUUTJgShlWpAgnN8Uc9lTwcv28D6Pg0yUdMCahMkfwjxS
   TZsO8xHAc5flk1Js0vRN6n73A62u7vdaqsP2MbcRXxLhByOue7cramzvm
   Q==;
X-CSE-ConnectionGUID: R66xbeyuSk2zEc5h2RGLnw==
X-CSE-MsgGUID: xlCf4029THabKNiCfCuqxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74912805"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74912805"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:28:11 -0700
X-CSE-ConnectionGUID: PbfzmNsnSTatofHeTtxfsA==
X-CSE-MsgGUID: rjn7lNHgQjyZZ7Ue+5twlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="246842459"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa001.fm.intel.com with ESMTP; 16 Mar 2026 16:28:11 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	sgzhang@google.com,
	boolli@google.com
Subject: [PATCH iwl-net 1/3] idpf: improve locking around idpf_vc_xn_push_free()
Date: Mon, 16 Mar 2026 16:28:17 -0700
Message-Id: <20260316232819.6872-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20260316232819.6872-1-emil.s.tantilov@intel.com>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268340-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 693FA2A1F52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor the VC logic dealing with transaction accounting where
both push and pop_free are using the same spinlock free_xn_bm.
This resolves potential race when setting and clearing the bits
in the free_xn_bm bitmask.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Reported-by: Ray Zhang <sgzhang@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 113ecfc16dd7..21a6c9d22085 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -401,12 +401,18 @@ struct idpf_vc_xn *idpf_vc_xn_pop_free(struct idpf_vc_xn_manager *vcxn_mngr)
  * idpf_vc_xn_push_free - Push a free transaction to free list
  * @vcxn_mngr: transaction manager to push to
  * @xn: transaction to push
+ *
+ * Callers must ensure idpf_vc_xn_release_bufs() has been called (under
+ * idpf_vc_xn_lock) before invoking this function. This function must
+ * be called without holding idpf_vc_xn_lock to avoid nesting a sleepable
+ * spinlock inside a raw_spinlock on PREEMPT_RT kernels.
  */
 static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
 				 struct idpf_vc_xn *xn)
 {
-	idpf_vc_xn_release_bufs(xn);
+	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
 	set_bit(xn->idx, vcxn_mngr->free_xn_bm);
+	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
 }
 
 /**
@@ -428,6 +434,7 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 			const struct idpf_vc_xn_params *params)
 {
 	const struct kvec *send_buf = &params->send_buf;
+	bool push_free = false;
 	struct idpf_vc_xn *xn;
 	ssize_t retval;
 	u16 cookie;
@@ -514,10 +521,13 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 	}
 
 release_and_unlock:
-	idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
+	idpf_vc_xn_release_bufs(xn);
+	push_free = true;
 	/* If we receive a VC reply after here, it will be dropped. */
 only_unlock:
 	idpf_vc_xn_unlock(xn);
+	if (push_free)
+		idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
 
 	return retval;
 }
@@ -559,7 +569,7 @@ idpf_vc_xn_forward_async(struct idpf_adapter *adapter, struct idpf_vc_xn *xn,
 	}
 
 release_bufs:
-	idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
+	idpf_vc_xn_release_bufs(xn);
 
 	return err;
 }
@@ -619,6 +629,7 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 	case IDPF_VC_XN_ASYNC:
 		err = idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
 		idpf_vc_xn_unlock(xn);
+		idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
 		return err;
 	default:
 		dev_err_ratelimited(&adapter->pdev->dev, "Overwriting VC reply (op %d)\n",
-- 
2.37.3


