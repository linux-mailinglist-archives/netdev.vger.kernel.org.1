Return-Path: <netdev+bounces-270637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM7TAAmBwWl2TgQAu9opvQ
	(envelope-from <netdev+bounces-270637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:06:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD692FADDD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60E2C310709F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23BC3CAE9B;
	Mon, 23 Mar 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmTbnGaV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754713C9EC8;
	Mon, 23 Mar 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287672; cv=none; b=acJLEV/XUclAl5VRBJwQQMrIHqiKjzY8c6WFJb7Tej2DimGVQdWHgHrW0vNBiMUr/8Sn+W2hVkiHa3yRXmS7rcaY3kkpjCP/KZzZDPfs7pNsFcGP5/5h2ySxTn1PeXUShin7EMY7K3bn9md39BOpbrebGwMxlIMzu8E1f5jlLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287672; c=relaxed/simple;
	bh=f89MZan3iUCMImpwFJMAPlV8Oa0551rEAwn3TXkL7pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSQugHGh0ZrHHeGd2TF8aiPmf5qXPwgdFzITyGNue11LjLRvMHzAeS/Nw5G07cf+VZ9BTR+Vyo877P3CDOiT5D9qI/62Nx9DKDENtGOHVLZ2zd4/a81AD+2oFy+xDnDfR6ftC7uPKlVmCwmrDI2p1S38jaMYjkjS18vuWvUj/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmTbnGaV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774287666; x=1805823666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f89MZan3iUCMImpwFJMAPlV8Oa0551rEAwn3TXkL7pI=;
  b=QmTbnGaV8+2bzhkSZnD4EQ8aMEMxYJ2nDR53msKMISmC8/mUdEuYfuuo
   rd/L9QhHeTzAPZOp8aEtsWE37sdGjQRmuEl/NpU6nMKHnyEzY5JUxZVMo
   +5Vy8eCGZCuL7YvEX7RgQFBYP9ViJtWBoZs3PuILDFwJ8QlXF9jsgLdS9
   v3aGi7SBcLFP25eUSecJQ6mHgKN8Cw8gSaMhWDntX7qBrbusdz4c/g+Ek
   AO4/H+NtA7plvjprWPLYolWg5Bizclr9xrvu1yrXb2yn4oUbB5B+X0fo3
   5T+s9FdDl+lM1V2kl4lLmeyZ7HQEZEZDtxMQB0KMWlBAAapThnbia5tMl
   Q==;
X-CSE-ConnectionGUID: CJetOlDZT0KnS57v74Z9wg==
X-CSE-MsgGUID: c38d4x37ThmvdOAL0QvtuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75484644"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75484644"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 10:41:05 -0700
X-CSE-ConnectionGUID: SqoOOJ9SQWazPZr4A4rryA==
X-CSE-MsgGUID: wBVtjHzRTz6xy0Od+kV8kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228576636"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 23 Mar 2026 10:41:00 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E83ED312FB;
	Mon, 23 Mar 2026 17:40:57 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v6 03/14] libeth: allow to create fill queues without NAPI
Date: Mon, 23 Mar 2026 18:40:34 +0100
Message-ID: <20260323174052.5355-4-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260323174052.5355-1-larysa.zaremba@intel.com>
References: <20260323174052.5355-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270637-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: ACD692FADDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Control queues can utilize libeth_rx fill queues, despite working outside
of NAPI context. The only problem is standard fill queues requiring NAPI
that provides them with the device pointer.

Introduce a way to provide the device directly without using NAPI.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/rx.c | 12 ++++++++----
 include/net/libeth/rx.h                |  4 +++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 62521a1f4ec9..0c1a565a1b3a 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -145,25 +145,29 @@ static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
 /**
  * libeth_rx_fq_create - create a PP with the default libeth settings
  * @fq: buffer queue struct to fill
- * @napi: &napi_struct covering this PP (no usage outside its poll loops)
+ * @napi_dev: &napi_struct for NAPI (data) queues, &device for others
  *
  * Return: %0 on success, -%errno on failure.
  */
-int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
+int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev)
 {
+	struct napi_struct *napi = fq->no_napi ? NULL : napi_dev;
 	struct page_pool_params pp = {
 		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order		= LIBETH_RX_PAGE_ORDER,
 		.pool_size	= fq->count,
 		.nid		= fq->nid,
-		.dev		= napi->dev->dev.parent,
-		.netdev		= napi->dev,
+		.dev		= napi ? napi->dev->dev.parent : napi_dev,
+		.netdev		= napi ? napi->dev : NULL,
 		.napi		= napi,
 	};
 	struct libeth_fqe *fqes;
 	struct page_pool *pool;
 	int ret;
 
+	if (!pp.netdev && fq->type == LIBETH_FQE_MTU)
+		return -EINVAL;
+
 	pp.dma_dir = fq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!fq->hsplit)
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e..0e736846c5e8 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -69,6 +69,7 @@ enum libeth_fqe_type {
  * @type: type of the buffers this queue has
  * @hsplit: flag whether header split is enabled
  * @xdp: flag indicating whether XDP is enabled
+ * @no_napi: the queue is not a data queue and does not have NAPI
  * @buf_len: HW-writeable length per each buffer
  * @nid: ID of the closest NUMA node with memory
  */
@@ -85,12 +86,13 @@ struct libeth_fq {
 	enum libeth_fqe_type	type:2;
 	bool			hsplit:1;
 	bool			xdp:1;
+	bool			no_napi:1;
 
 	u32			buf_len;
 	int			nid;
 };
 
-int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
+int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
-- 
2.47.0


