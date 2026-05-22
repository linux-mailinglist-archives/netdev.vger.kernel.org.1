Return-Path: <netdev+bounces-290789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEUGMypBEGqwVQYAu9opvQ
	(envelope-from <netdev+bounces-290789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:42:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D65B32BA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D33073033D2D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DC3E9C03;
	Fri, 22 May 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivb3r9bC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6793D4131;
	Fri, 22 May 2026 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449565; cv=none; b=VXzZYWq3mtmsA7e1Udw/t93MWvS9lpSYP7v1dZ6jLLCcD3ltMmpJUfJNYJ/p6Ov8p2t6768+yzvt+ACUhSnV3PXHsHnbwCW2hGhw7hnOnrD4L8riAgWx1+zn5WS3sURaZN04ee6o5vJH/gMVvrC4mCrpITgEfC7fyhpyv/K0VMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449565; c=relaxed/simple;
	bh=ku8DBQRCIbZKc8iQag9r7zooL+B7U2bRLgO4QQyao7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K479C5yeUc+aA7e5YfZaJtZWjClTLoUGXSE6MOTDfS6WzXR38D0hFgXShFHgYC3Ur+21CDRO6sWPt7UqwXi0lMJb6u7Q4ngvMLbOcTHrO9LxcAnk8coPcSKSe52JB42RzYBKkA91znnfZJFNSOBH7Fv+y7ukRoZc26VhUAp77CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivb3r9bC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557701F00ADE;
	Fri, 22 May 2026 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779449562;
	bh=6zikfVjQRcLYEUZCe+ZKJoOY4gEgswqSMq69Lf0Fe6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivb3r9bCklaWI/M/ALbmUOQ9wjap6gYT+UXVQwSb0CoEILiudN1RSof17JJ4t4CZC
	 Dv48zLDiHVqbijBKFeu1AVpnuhIgjB00tox4QyUTAdTxHAsX87sj4CmtNaqaGYvXJk
	 zIAgAvwNEsm4ITQhUnzfs12xrvyKHrcqpvrJvlRGM8c/37QufLKa6dNS3Hx4kD47d/
	 Nj2mtn/F5Z9qXnxNCxe+vVWRur4Ejq9jNpGPg2/sGJKJNzJLAIH3/uSol9qfAXes5I
	 5FYEA6Y6cXpvwo+OunlfDbtLxF8hHir+LceQkjOdwt15dQUXHjwWzo9IvY8AS+lIqh
	 TwUzClvjftHEA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/3] fbnic: Support larger zcrx receive buffers
Date: Fri, 22 May 2026 13:32:21 +0200
Message-ID: <20260522113225.241337-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522113225.241337-1-bjorn@kernel.org>
References: <20260522113225.241337-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290789-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB5D65B32BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

io_uring zcrx can provide receive buffers larger than PAGE_SIZE
through QCFG_RX_PAGE_SIZE. Advertise the parameter and use the
configured size when creating the PPQ page pool.

The NIC still consumes PPQ buffers as 4 KiB BDQ fragments. For larger
zcrx buffers, allocate the page pool with the requested order and set
the PPQ fragment shift from rx_page_size, so one net_iov can cover
multiple hardware fragments.

The core validates the zcrx request and checks that the imported
memory can be represented as rx_buf_len-sized DMA chunks. Fbnic still
has to validate the rendered queue configuration against its own BDQ
geometry: larger receive buffers consume multiple 4 KiB PPQ entries,
and the PPQ must retain usable depth after that expansion.

Use the rendered per-queue rx_page_size on the normal open path as
well. This preserves a memory-provider binding made while the netdev
is down instead of falling back to the default PPQ geometry on open.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 102 +++++++++++++++++--
 1 file changed, 94 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 9a9675d04c16..57b3277fcd4e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1559,9 +1559,62 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
+static u32 fbnic_qcfg_rx_page_size(const struct netdev_queue_config *qcfg)
+{
+	return qcfg->rx_page_size ?: PAGE_SIZE;
+}
+
+static u32 fbnic_rx_page_frag_count(u32 rx_page_size)
+{
+	return rx_page_size / FBNIC_BD_FRAG_SIZE;
+}
+
+static u8 fbnic_rx_page_frag_shift(u32 rx_page_size)
+{
+	return ilog2(fbnic_rx_page_frag_count(rx_page_size));
+}
+
+static int fbnic_validate_rx_page_size(struct fbnic_net *fbn, u32 rx_page_size,
+				       struct netlink_ext_ack *extack)
+{
+	u32 frag_count, ppq_bufs;
+
+	if (!is_power_of_2(rx_page_size)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "rx_page_size must be a power of 2");
+		return -EINVAL;
+	}
+
+	if (rx_page_size < PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "rx_page_size must be at least PAGE_SIZE");
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(rx_page_size, FBNIC_BD_FRAG_SIZE)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "rx_page_size must be 4K aligned");
+		return -EINVAL;
+	}
+
+	frag_count = fbnic_rx_page_frag_count(rx_page_size);
+	ppq_bufs = fbn->ppq_size / frag_count;
+	/* The PPQ is sized in 4K hardware fragments, but the software ring
+	 * has one entry per page-pool allocation. Keep at least two entries so
+	 * empty/full ring accounting still leaves one postable buffer.
+	 */
+	if (ppq_bufs < 2) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "rx_page_size leaves too few PPQ buffers");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
-			  unsigned int rxq_idx)
+			  unsigned int rxq_idx, u32 rx_page_size)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
@@ -1596,6 +1649,8 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 
 	qt->sub0.page_pool = pp;
 	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
+		pp_params.order = ilog2(rx_page_size) - PAGE_SHIFT;
+		pp_params.max_len = rx_page_size;
 		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 		pp_params.dma_dir = DMA_FROM_DEVICE;
 
@@ -2018,12 +2073,19 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 
 static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 				       struct fbnic_napi_vector *nv,
-				       struct fbnic_q_triad *qt)
+				       struct fbnic_q_triad *qt,
+				       u32 rx_page_size)
 {
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx);
+	err = fbnic_validate_rx_page_size(fbn, rx_page_size, NULL);
+	if (err)
+		return err;
+
+	qt->sub1.frag_shift = fbnic_rx_page_frag_shift(rx_page_size);
+
+	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx, rx_page_size);
 	if (err)
 		return err;
 
@@ -2087,7 +2149,13 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 
 	/* Allocate Rx Resources */
 	for (j = 0; j < nv->rxt_count; j++, i++) {
-		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i]);
+		struct netdev_queue_config qcfg;
+		u32 rx_page_size;
+
+		netdev_queue_config(fbn->netdev, nv->qt[i].cmpl.q_idx, &qcfg);
+		rx_page_size = fbnic_qcfg_rx_page_size(&qcfg);
+		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i],
+						  rx_page_size);
 		if (err)
 			goto free_qt_resources;
 	}
@@ -2852,9 +2920,16 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	const struct fbnic_q_triad *real;
 	struct fbnic_q_triad *qt = qmem;
 	struct fbnic_napi_vector *nv;
+	u32 rx_page_size = fbnic_qcfg_rx_page_size(qcfg);
+	int err;
 
-	if (!netif_running(dev))
-		return fbnic_alloc_qt_page_pools(fbn, qt, idx);
+	if (!netif_running(dev)) {
+		err = fbnic_validate_rx_page_size(fbn, rx_page_size, NULL);
+		if (err)
+			return err;
+
+		return fbnic_alloc_qt_page_pools(fbn, qt, idx, rx_page_size);
+	}
 
 	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
 	nv = fbn->napi[idx % fbn->num_napi];
@@ -2864,11 +2939,20 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	qt->sub0.frag_shift = real->sub0.frag_shift;
 	fbnic_ring_init(&qt->sub1, real->sub1.doorbell, real->sub1.q_idx,
 			real->sub1.flags);
-	qt->sub1.frag_shift = real->sub1.frag_shift;
 	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
 			real->cmpl.flags);
 
-	return fbnic_alloc_rx_qt_resources(fbn, nv, qt);
+	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, rx_page_size);
+}
+
+static int fbnic_validate_qcfg(struct net_device *dev,
+			       struct netdev_queue_config *qcfg,
+			       struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+
+	return fbnic_validate_rx_page_size(fbn, fbnic_qcfg_rx_page_size(qcfg),
+					   extack);
 }
 
 static void fbnic_queue_mem_free(struct net_device *dev, void *qmem)
@@ -2970,4 +3054,6 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= fbnic_queue_mem_free,
 	.ndo_queue_start	= fbnic_queue_start,
 	.ndo_queue_stop		= fbnic_queue_stop,
+	.ndo_validate_qcfg	= fbnic_validate_qcfg,
+	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
-- 
2.53.0


