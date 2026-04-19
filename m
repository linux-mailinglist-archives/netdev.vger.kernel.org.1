Return-Path: <netdev+bounces-279605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB2YAHMs5WkEfAEAu9opvQ
	(envelope-from <netdev+bounces-279605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 21:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52941425403
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E93663020A64
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 19:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DD2FF170;
	Sun, 19 Apr 2026 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJo7bLQP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28632E1EF4
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776626789; cv=none; b=pfvOKDvrMcVrH72W3wltF3ZFIcCKSH5altZ5KjPBbJw8eTp4xqh8nHby28ss8WSFIT2KzztW5OF2v8FbJu7SZ2RpmQoHAEKXxs36Tm7HBVq9rA3nzhG6Lh3OOGfiSFfPgutVWcofbKUo5NkgCT61wBCZ45oE47Y+Su7iBIwjjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776626789; c=relaxed/simple;
	bh=m8DcrGxrZc9awjTMCxUkOTUB79YPdqd40L3PhS6dwaA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BQL7UxRTnCxkJaAC3jISGFOoHzul2ibarrMl1T9l1DSxzHO8r2tpZ0tvtaFtpa8qnVWfkKMOaG6sySqLKdiIvyOoxPO1g36DYD5/Suy9J9nxOb8H79JkN3pwoKuyzUzKabmz0n2cRDVLnq0vtCSzceowVN7gnav6CfkA6/OWuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJo7bLQP; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so2441503eec.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776626786; x=1777231586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YmTe5QrSAhWmElkBtUPNEfvUQd8uWx+pL52ZTzPTjRg=;
        b=fJo7bLQP4sHAbr/iBkMAeXQR4etPZZLhdUgDbCkRkfTTMw3HdcX6ABJmPRvk9oyhtw
         lbzvDHC6x97JloUtw5GIUoO2phrd+kAh8QTB8RyFVXSDFufhwA7XauDZRCHKzRvsR1Bg
         KG0cpMdpxm8U9rUSOmEdxWckIT+LQmf9Piq0IiKQWLHWPs1ivlV92R6DaJ8X2AaxLYm2
         bepkbVDTNsE/FlbOMcp6cHARbcNs4Pv5qoaCN5pzWbudaCqf99mVOScHiUANs1ATBrVm
         QeoJxymWQk7Z+DWrVVtG5mypfjIJY77Nd7ASB5cDzYBhcqKGHZNR22kSQ/B6docDQDMH
         3QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776626786; x=1777231586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmTe5QrSAhWmElkBtUPNEfvUQd8uWx+pL52ZTzPTjRg=;
        b=Q4ifQ1h1G4xv3Iwo+LcZM68aOSZygrkVazGiA7bZmIAENsyTVJmVvxnOMrCrxgp09y
         Sbr/Z74hUptXeSpwYBbd7R3QOup9iwNVA8pzpAyhAupKKCFt08I2Duv9tzxjWM8XbOx2
         DOuiJ2Jas/pbMIhG8BKiOd7MZWix6XfNNE1edCD2vQt0YsMWwux//CjjIgRDGMuxunwt
         qkTjlJwptiOCJHI7BOmVh5aDRy+HgnmHxfOdmtutimGd55/Cnrc12wcyJtiyyhUBrOZm
         67M8pza8sslb811coG/VB33u8L8Qfrx5vVDNvyUEsz4o7uq/gzEMr8aX5sf0INUSM2gi
         uGXQ==
X-Gm-Message-State: AOJu0YwLukrxi7GBDaP/3p1VTHCcSE1HxIwbIZRAqZhPHT3JGY3Y1vyv
	Njy9fO4YPQWSGPGEYI1DVIDfyzW1cJf4nUq7N8x1cmg0HQeBK23/li5IAa5kN3HZ8KZ/I9XpcZJ
	Rv1EGPg==
X-Received: from dybtv6.prod.google.com ([2002:a05:7300:f486:b0:2d8:5b05:964b])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c05:b0:2c7:3a7:c792
 with SMTP id 5a478bee46e88-2e47a1027ecmr5364749eec.20.1776626785796; Sun, 19
 Apr 2026 12:26:25 -0700 (PDT)
Date: Sun, 19 Apr 2026 19:25:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419192555.3631327-1-boolli@google.com>
Subject: [PATCH] idpf: do not perform flow ops when netdev is detached
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279605-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52941425403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
handling a reset") prevents ethtool -N/-n operations to operate on
detached netdevs, we found that out-of-tree workflows like OpenOnload
can bypass ethtool core locks and call idpf_set_rxnfc directly during
an idpf HW reset. When this happens, we could get kernel crashes like
the following:

[ 4045.787439] BUG: kernel NULL pointer dereference, address: 0000000000000070
[ 4045.794420] #PF: supervisor read access in kernel mode
[ 4045.799580] #PF: error_code(0x0000) - not-present page
[ 4045.804739] PGD 0
[ 4045.806772] Oops: Oops: 0000 [#1] SMP NOPTI
...
[ 4045.836425] Workqueue: onload-wqueue oof_do_deferred_work_fn [onload]
[ 4045.842926] RIP: 0010:idpf_del_flow_steer+0x24/0x170 [idpf]
...
[ 4045.946323] Call Trace:
[ 4045.948796]  <TASK>
[ 4045.950915]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 4045.955293]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 4045.959672]  ? idpf_set_rxnfc+0x6f/0x80 [idpf]
[ 4045.964142]  ? __die_body.cold+0x8/0x12
[ 4045.968000]  ? page_fault_oops+0x148/0x160
[ 4045.972117]  ? exc_page_fault+0x6f/0x160
[ 4045.976060]  ? asm_exc_page_fault+0x22/0x30
[ 4045.980262]  ? idpf_del_flow_steer+0x24/0x170 [idpf]
[ 4045.985245]  idpf_set_rxnfc+0x6f/0x80 [idpf]
[ 4045.989535]  af_xdp_filter_remove+0x7c/0xb0 [sfc_resource]
[ 4045.995069]  oo_hw_filter_clear_hwports+0x6f/0xa0 [onload]
[ 4046.000589]  oo_hw_filter_update+0x65/0x210 [onload]
[ 4046.005587]  oof_hw_filter_update.constprop.0+0xe7/0x140 [onload]
[ 4046.011716]  oof_manager_update_all_filters+0xad/0x270 [onload]
[ 4046.017671]  __oof_do_deferred_work+0x15e/0x190 [onload]
[ 4046.023014]  oof_do_deferred_work+0x2c/0x40 [onload]
[ 4046.028018]  oof_do_deferred_work_fn+0x12/0x30 [onload]
[ 4046.033277]  process_one_work+0x174/0x330
[ 4046.037304]  worker_thread+0x246/0x390
[ 4046.041074]  ? __pfx_worker_thread+0x10/0x10
[ 4046.045364]  kthread+0xf6/0x240
[ 4046.048530]  ? __pfx_kthread+0x10/0x10
[ 4046.052297]  ret_from_fork+0x2d/0x50
[ 4046.055896]  ? __pfx_kthread+0x10/0x10
[ 4046.059664]  ret_from_fork_asm+0x1a/0x30
[ 4046.063613]  </TASK>

To prevent this, we need to add checks in idpf_set_rxnfc and
idpf_get_rxnfc to error out if the netdev is already detached.

Tested: implemented the following patch to synthetically force idpf into
a HW reset:

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4fc0bb14c5b1..27476d57bcf0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -10,6 +10,9 @@
 #define idpf_tx_buf_next(buf)		(*(u32 *)&(buf)->priv)
 LIBETH_SQE_CHECK_PRIV(u32);

+static bool SIMULATE_TX_TIMEOUT;
+module_param(SIMULATE_TX_TIMEOUT, bool, 0644);
+
 /**
  * idpf_chk_linearize - Check if skb exceeds max descriptors per packet
  * @skb: send buffer
@@ -46,6 +49,8 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)

 	adapter->tx_timeout_count++;

+	SIMULATE_TX_TIMEOUT = false;
+
 	netdev_err(netdev, "Detected Tx timeout: Count %d, Queue %d\n",
 		   adapter->tx_timeout_count, txqueue);
 	if (!idpf_is_reset_in_prog(adapter)) {
@@ -2225,6 +2230,8 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 			goto fetch_next_desc;
 		}
 		tx_q = complq->txq_grp->txqs[rel_tx_qid];
+		if (unlikely(SIMULATE_TX_TIMEOUT && (tx_q->idx % 2 == 1)))
+			goto fetch_next_desc;

 		/* Determine completion type */
 		ctype = le16_get_bits(tx_desc->common.qid_comptype_gen,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101..ba5da2a86c15 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -8,6 +8,9 @@
 #include "idpf_virtchnl.h"
 #include "idpf_ptp.h"

+static bool VIRTCHNL_FAILED;
+module_param(VIRTCHNL_FAILED, bool, 0644);
+
 /**
  * struct idpf_vc_xn_manager - Manager for tracking transactions
  * @ring: backing and lookup for transactions
@@ -3496,6 +3499,11 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		switch (adapter->state) {
 		case __IDPF_VER_CHECK:
 			err = idpf_send_ver_msg(adapter);
+
+			if (unlikely(VIRTCHNL_FAILED)) {
+				err = -EIO;
+			}
+
 			switch (err) {
 			case 0:
 				/* success, move state machine forward */

And tested by writing 1 to /sys/module/idpf/parameters/VIRTCHNL_FAILED
and /sys/module/idpf/parameters/SIMULATE_TX_TIMEOUT, and running
idpf_get_rxnfc() right after the HW reset.

Without the patch: encountered NULL pointer and kernel crash.

With the patch: no crashes.

Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index bb99d9e7c65d..8368a7e6a754 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -43,6 +43,9 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	unsigned int cnt = 0;
 	int err = 0;
 
+	if (!netdev || !netif_device_present(netdev))
+		return -ENODEV;
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 	vport_config = np->adapter->vport_config[np->vport_idx];
@@ -349,6 +352,9 @@ static int idpf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 {
 	int ret = -EOPNOTSUPP;
 
+	if (!netdev || !netif_device_present(netdev))
+		return -ENODEV;
+
 	idpf_vport_ctrl_lock(netdev);
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


