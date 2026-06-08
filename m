Return-Path: <netdev+bounces-296613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IVPF23bJmq1lwIAu9opvQ
	(envelope-from <netdev+bounces-296613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:10:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA7F657DC5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IUDGn7ji;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296613-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296613-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 264E730DA248
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C83E6397;
	Mon,  8 Jun 2026 14:41:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84D3E51E2;
	Mon,  8 Jun 2026 14:41:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929713; cv=none; b=s9Md29OKSn4PDWqec+/UDrapIk1xcet6Fa2APuq9Ej86TukmbgljCvAXSKHfwH4MYjeFqj9W9U6AZVTh/5BKZ8VXDZZTVA40rAkeMqhkdguAE+Ol+BoOWiJ37mkiksm8LNqqFBHJOTtRTGEJZ579hFKkalrX3/LNfKjZ3MZ2Cow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929713; c=relaxed/simple;
	bh=mTbyhIholkZ30Z2A4J6bovHL49jLL3MFMRC/eEyAhis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okzs/wGetttq38WgDOWDXVUp3p/lvAV99RuiEZaXGwqlkvm8nr+t2/L5z60bQRcMcnAPs4qsMx1wmOCurjifh9iuTcJCFwFa8nmA8rCE8DGy0I049YWMfTqYdL+ut5yxRpHniuSxyumQlK/+9DR6Gip7RNW2ZCjL3osMYLv2BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUDGn7ji; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929711; x=1812465711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mTbyhIholkZ30Z2A4J6bovHL49jLL3MFMRC/eEyAhis=;
  b=IUDGn7jix5gGZPfc5xEIEA0JJmtv9+tSrp8uppPZiEtCYC3BLIhCcbbf
   NX8zSoQAYJtDbjadYO1TKrLx30R76XEW26r4FRfbBw7Ynjw49nPnbvecX
   n0yCq0bLFasFAy7T3YeSRUKN3wYrZdcdUPjPM4qnjYOTwS1fO2k5sUYba
   CEeOutjH8nx+6Zhy4P/jy9yaMpFdVcEI2iPINMvIvCb9vAqF7KvElvrbt
   7MtenWTCno4m1lU2PXcCSBh7OqVjRtd7z99qms9xgpjG3lvp3qJosyTqL
   eAJUJCJ00r3C80OfV7iVItxGRUYFIcqZKo9vNt+VFFwerlStkPINLOnHG
   Q==;
X-CSE-ConnectionGUID: MbnLTyauT0mseNrxjLEqJQ==
X-CSE-MsgGUID: 7nopPWkGTRaWl7gYI4aXyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81642017"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81642017"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:41:48 -0700
X-CSE-ConnectionGUID: MREiGR3rR1abFJRBNduanQ==
X-CSE-MsgGUID: hU8RDQcUT269SCkQk6m4EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249489741"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2026 07:41:43 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 380F928795;
	Mon,  8 Jun 2026 15:41:41 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
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
Subject: [PATCH iwl-next v8 07/15] idpf: remove unused code for getting RSS info from device
Date: Mon,  8 Jun 2026 16:41:12 +0200
Message-ID: <20260608144127.2751230-8-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260608144127.2751230-1-larysa.zaremba@intel.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:larysa.zaremba@intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BA7F657DC5

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
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   4 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 107 +++---------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  10 +-
 3 files changed, 22 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f6b3b15364ff..d744db0efd3f 100644
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
2.47.0


