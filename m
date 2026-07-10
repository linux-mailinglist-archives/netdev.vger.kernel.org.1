Return-Path: <netdev+bounces-306706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TJd5M1tqUWqMEQMAu9opvQ
	(envelope-from <netdev+bounces-306706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:55:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148573F3FF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:55:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gPwpuukd;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306706-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306706-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B1630465F6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB63CA48C;
	Fri, 10 Jul 2026 21:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2F3CFF50;
	Fri, 10 Jul 2026 21:53:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720412; cv=none; b=gNp+BOcwZyyseBk2YR6+oDpaOVjFzA7sxyf4S7LtLLPeti/db9N8rpRMt/tfwvVlauOK3G2621Y4qWB0Adrg/Kxfk1EwUKQ6Q5Gujk4UTvY+NNIs/oSHkf1+e+R5/4kppyd6cHzjy4Ry7FcVk1dNwotdSoaLe1u5T3FVyu0oJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720412; c=relaxed/simple;
	bh=iICm4+AWkjxkbVyaMmiU0eF7MYFp4R4xFwswvAwjIZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJs6OU6ne7ZGOJYdRcCWPeD4tuKuawenoYcMazaeBf/9Y1qXDUa0KeosJwJt5J8zS8RL5B7je/2L/XThSksEJnBathairqcQU4iCbuJUT8OpID8RYhBbqmmYkCGLrqsNBA52EX5+leRxYhJKr27Buz7VbC4yyARv8vS3+6LBVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPwpuukd; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783720407; x=1815256407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iICm4+AWkjxkbVyaMmiU0eF7MYFp4R4xFwswvAwjIZ0=;
  b=gPwpuukdbWvjk+xU16SR0djljHgcFFafp4L7zcKp4LuWQbfYhp3/1j7f
   9RUbCanjV0BbnTqEO1uBY+0XOc55MnKjLPteGvRoTy2kfoyqqI9rbbM4u
   j5l4nwrw6HyrFHKj6Av6oFOE8ze8k6RP/KbQC6dc3Asc7GU/93hF3NFEb
   mz128sZA4/cvujzYxXRGjq5gDOYGZas8fT5v1vg6oIJcxddm/pcAaJlXM
   25NQ7YmhZobAQL57K9T1XsGQugrYoAS6vRKtEmRiH0+yQf/yX6wseXK3V
   fhFQpuL5VyQpagCnSsnFzT8n2il2e7tFwJ5KFrafX+isNOZQ+631J7pdn
   Q==;
X-CSE-ConnectionGUID: GZABb9kVQMuPf/5tgRSYNw==
X-CSE-MsgGUID: sA6kZ5dbRACJAle4KlFwQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107220759"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107220759"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:53:23 -0700
X-CSE-ConnectionGUID: b0Ga8uBBQ+KlOCiFr87VRA==
X-CSE-MsgGUID: XnhoPHj/SRG1DiWmFWwoCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254494635"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2026 14:53:22 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v4 07/15] idpf: remove unused code for getting RSS info from device
Date: Fri, 10 Jul 2026 14:53:04 -0700
Message-ID: <20260710215313.1475803-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306706-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:larysa.zaremba@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2148573F3FF

From: Larysa Zaremba <larysa.zaremba@intel.com>

idpf_send_get_set_rss_lut_msg() and idpf_send_get_set_rss_key_msg() do not
handle the get=true path properly. Response validation is insufficient,
memcpy size is wrong, LE-to-CPU conversion is missing. Fortunately, those
functions are never used with get=true. Given how broken this dead code is,
it is unlikely to be useful in the future.

Rename idpf_send_get_set_rss_lut_msg() to idpf_send_set_rss_lut_msg(),
idpf_send_get_set_rss_key_msg() to idpf_send_set_rss_key_msg(), remove the
get parameter and remove all get=true cases from the function.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   4 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 107 +++---------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  10 +-
 3 files changed, 22 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..57fa58873808 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4679,11 +4679,11 @@ int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 	u32 vport_id = vport->vport_id;
 	int err;
 
-	err = idpf_send_get_set_rss_key_msg(adapter, rss_data, vport_id, false);
+	err = idpf_send_set_rss_key_msg(adapter, rss_data, vport_id);
 	if (err)
 		return err;
 
-	return idpf_send_get_set_rss_lut_msg(adapter, rss_data, vport_id, false);
+	return idpf_send_set_rss_lut_msg(adapter, rss_data, vport_id);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d4546d62cca9..a3c17f0e14f3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2847,29 +2847,26 @@ int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
 }
 
 /**
- * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set RSS lut message
+ * idpf_send_set_rss_lut_msg - Send virtchnl set RSS lut message
  * @adapter: adapter pointer used to send virtchnl message
  * @rss_data: pointer to RSS key and lut info
  * @vport_id: vport identifier used while preparing the virtchnl message
- * @get: flag to set or get RSS look up table
  *
- * When rxhash is disabled, RSS LUT will be configured with zeros.  If rxhash
+ * When rxhash is disabled, RSS LUT will be configured with zeros. If rxhash
  * is enabled, the LUT values stored in driver's soft copy will be used to setup
  * the HW.
  *
  * Return: 0 on success, negative on failure.
  */
-int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get)
+int idpf_send_set_rss_lut_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id)
 {
-	struct virtchnl2_rss_lut *recv_rl __free(kfree) = NULL;
 	struct virtchnl2_rss_lut *rl __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	int buf_size, lut_buf_size;
 	struct idpf_vport *vport;
 	ssize_t reply_sz;
 	bool rxhash_ena;
+	int buf_size;
 	int i;
 
 	vport = idpf_vid_to_vport(adapter, vport_id);
@@ -2888,72 +2885,34 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.send_buf.iov_base = rl;
 	xn_params.send_buf.iov_len = buf_size;
+	xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_LUT;
 
-	if (get) {
-		recv_rl = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
-		if (!recv_rl)
-			return -ENOMEM;
-		xn_params.vc_op = VIRTCHNL2_OP_GET_RSS_LUT;
-		xn_params.recv_buf.iov_base = recv_rl;
-		xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
-	} else {
-		rl->lut_entries = cpu_to_le16(rss_data->rss_lut_size);
-		for (i = 0; i < rss_data->rss_lut_size; i++)
-			rl->lut[i] = rxhash_ena ?
-				cpu_to_le32(rss_data->rss_lut[i]) : 0;
+	rl->lut_entries = cpu_to_le16(rss_data->rss_lut_size);
+	for (i = 0; i < rss_data->rss_lut_size; i++)
+		rl->lut[i] = rxhash_ena ? cpu_to_le32(rss_data->rss_lut[i]) : 0;
 
-		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_LUT;
-	}
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
-	if (!get)
-		return 0;
-	if (reply_sz < sizeof(struct virtchnl2_rss_lut))
-		return -EIO;
-
-	lut_buf_size = le16_to_cpu(recv_rl->lut_entries) * sizeof(u32);
-	if (reply_sz < lut_buf_size)
-		return -EIO;
-
-	/* size didn't change, we can reuse existing lut buf */
-	if (rss_data->rss_lut_size == le16_to_cpu(recv_rl->lut_entries))
-		goto do_memcpy;
-
-	rss_data->rss_lut_size = le16_to_cpu(recv_rl->lut_entries);
-	kfree(rss_data->rss_lut);
-
-	rss_data->rss_lut = kzalloc(lut_buf_size, GFP_KERNEL);
-	if (!rss_data->rss_lut) {
-		rss_data->rss_lut_size = 0;
-		return -ENOMEM;
-	}
-
-do_memcpy:
-	memcpy(rss_data->rss_lut, recv_rl->lut, rss_data->rss_lut_size);
 
 	return 0;
 }
 
 /**
- * idpf_send_get_set_rss_key_msg - Send virtchnl get or set RSS key message
+ * idpf_send_set_rss_key_msg - Send virtchnl set RSS key message
  * @adapter: adapter pointer used to send virtchnl message
  * @rss_data: pointer to RSS key and lut info
  * @vport_id: vport identifier used while preparing the virtchnl message
- * @get: flag to set or get RSS look up table
  *
  * Return: 0 on success, negative on failure
  */
-int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get)
+int idpf_send_set_rss_key_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id)
 {
-	struct virtchnl2_rss_key *recv_rk __free(kfree) = NULL;
 	struct virtchnl2_rss_key *rk __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
 	ssize_t reply_sz;
 	int i, buf_size;
-	u16 key_size;
 
 	buf_size = struct_size(rk, key_flex, rss_data->rss_key_size);
 	rk = kzalloc(buf_size, GFP_KERNEL);
@@ -2964,49 +2923,15 @@ int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
 	xn_params.send_buf.iov_base = rk;
 	xn_params.send_buf.iov_len = buf_size;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	if (get) {
-		recv_rk = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);
-		if (!recv_rk)
-			return -ENOMEM;
-
-		xn_params.vc_op = VIRTCHNL2_OP_GET_RSS_KEY;
-		xn_params.recv_buf.iov_base = recv_rk;
-		xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
-	} else {
-		rk->key_len = cpu_to_le16(rss_data->rss_key_size);
-		for (i = 0; i < rss_data->rss_key_size; i++)
-			rk->key_flex[i] = rss_data->rss_key[i];
+	xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_KEY;
 
-		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_KEY;
-	}
+	rk->key_len = cpu_to_le16(rss_data->rss_key_size);
+	for (i = 0; i < rss_data->rss_key_size; i++)
+		rk->key_flex[i] = rss_data->rss_key[i];
 
 	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
-	if (!get)
-		return 0;
-	if (reply_sz < sizeof(struct virtchnl2_rss_key))
-		return -EIO;
-
-	key_size = min_t(u16, NETDEV_RSS_KEY_LEN,
-			 le16_to_cpu(recv_rk->key_len));
-	if (reply_sz < key_size)
-		return -EIO;
-
-	/* key len didn't change, reuse existing buf */
-	if (rss_data->rss_key_size == key_size)
-		goto do_memcpy;
-
-	rss_data->rss_key_size = key_size;
-	kfree(rss_data->rss_key);
-	rss_data->rss_key = kzalloc(key_size, GFP_KERNEL);
-	if (!rss_data->rss_key) {
-		rss_data->rss_key_size = 0;
-		return -ENOMEM;
-	}
-
-do_memcpy:
-	memcpy(rss_data->rss_key, recv_rk->key_flex, rss_data->rss_key_size);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 972dd88cf3d2..7210dc7b426b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -208,12 +208,10 @@ int idpf_send_ena_dis_loopback_msg(struct idpf_adapter *adapter, u32 vport_id,
 int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
 			    struct idpf_port_stats *port_stats);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
-int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get);
-int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
-				  struct idpf_rss_data *rss_data,
-				  u32 vport_id, bool get);
+int idpf_send_set_rss_key_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id);
+int idpf_send_set_rss_lut_msg(struct idpf_adapter *adapter,
+			      struct idpf_rss_data *rss_data, u32 vport_id);
 void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
 			       u8 *send_msg, u16 msg_size,
-- 
2.47.1


