Return-Path: <netdev+bounces-274754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI1ALEn4zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:14:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61938F13B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7933A307839C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D103FB064;
	Thu,  2 Apr 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="l/GuXUWd"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200A3F8809;
	Thu,  2 Apr 2026 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171463; cv=none; b=AuTUu8Vz/S9vDF95LwJGilsUc6XGxYkFmFfa/o2DkEmW4y1Q+5X+dyUNX14RU91906E7Qe8uC1bI9ksE91OO3MUWEEJyEoouq6RbC9XAjTacW+BOgUoWvAqzwU+wHEjw1xjw8Cl2TuZD/RrMKoowrjNeJna89IwwDf95F73Hjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171463; c=relaxed/simple;
	bh=qEL1WHnyMLupb89aYe7aVfVkfN0xk1C1/aIHns41CIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv7M4VKz7fGq/fbXVBV0nyILL19flBEBNW9ik89Af/xveRBSt2RdDirYCpDVqQ6FOLxBsNC6L9vgVeXS0coiL/apFlYfNMEo2uoF4tpCJuK7JPWKVkwjdjq4zlZifOWTMb3uN5ByIPmHZ3V/OEmBT++/kwK3p+wFLJ1VDMoj1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=l/GuXUWd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oMGApRAYIXv/6tn2pbPTWFFn930x9ka3EWkjD0AMmRo=; b=l/GuXUWdAwmvpjzR8LrVMtjtHy
	m9g+uvsrHxkSN25z4Gk02Ghtr2ItC5BM4xYKkuomwmh9HavZWh9bD6VG4jNRicvY0UlaPYUU/MYEi
	yS7z++CckMeV3zugw3MAvXMtYWLLa4AFcEw2hR/cbRbOoa6vyEm+tGf20RZUQJELjNnDmp/IrlUJN
	XWdzl14B/l0QNxDK31pt1eaDziekTpL/ngFHISpRBuIf/5ydBm+YN2I8zBtnDliT5T4q2mnrvvKQ5
	qQsX8vcG2R42D/9nFQm/6qLr1R6c/unYHeyrUcSIu6qFe57Z6RSXfUkMhdCJikuy5yPUTuk8A6F12
	xoK4RBCQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w8RBQ-0000ml-1c;
	Fri, 03 Apr 2026 01:10:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v11 06/14] net: Proxy netif_mp_{open,close}_rxq for leased queues
Date: Fri,  3 Apr 2026 01:10:23 +0200
Message-ID: <20260402231031.447597-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402231031.447597-1-daniel@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27959/Thu Apr  2 08:25:45 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274754-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid]
X-Rspamd-Queue-Id: 9D61938F13B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Wei <dw@davidwei.uk>

When a process in a container wants to setup a memory provider, it will
use the virtual netdev and a leased rxq, and call netif_mp_{open,close}_rxq
to try and restart the queue. At this point, proxy the queue restart on
the real rxq in the physical netdev.

For memory providers (io_uring zero-copy rx and devmem), it causes the
real rxq in the physical netdev to be filled from a memory provider that
has DMA mapped memory from a process within a container.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/core/dev.c             |   4 +-
 net/core/dev.h             |   7 +++
 net/core/netdev_rx_queue.c | 104 +++++++++++++++++++++++++++++++------
 3 files changed, 95 insertions(+), 20 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f0a83a09477e..f8cc8667dff4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12339,10 +12339,8 @@ static void dev_memory_provider_uninstall(struct net_device *dev)
 
 	for (i = 0; i < dev->real_num_rx_queues; i++) {
 		struct netdev_rx_queue *rxq = &dev->_rx[i];
-		struct pp_memory_provider_params *p = &rxq->mp_params;
 
-		if (p->mp_ops && p->mp_ops->uninstall)
-			p->mp_ops->uninstall(rxq->mp_params.mp_priv, rxq);
+		__netif_mp_uninstall_rxq(rxq, &rxq->mp_params);
 	}
 }
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 6516ce2b5517..95edb2d4eff8 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -12,6 +12,7 @@ struct net;
 struct netlink_ext_ack;
 struct netdev_queue_config;
 struct cpumask;
+struct pp_memory_provider_params;
 
 /* Random bits of netdevice that don't need to be exposed */
 #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
@@ -101,6 +102,12 @@ int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
 bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
 bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
 
+void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
+			      const struct pp_memory_provider_params *p);
+
+void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
+			       struct netdev_rx_queue *virt_rxq);
+
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
 	struct hlist_node hlist;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 06ac3bd5507f..1d6e7e47bf0a 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -28,6 +28,8 @@ void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
 	netdev_assert_locked(rxq_dst->dev);
 	netdev_assert_locked(rxq_src->dev);
 
+	netif_rxq_cleanup_unlease(rxq_src, rxq_dst);
+
 	WRITE_ONCE(rxq_src->lease, NULL);
 	WRITE_ONCE(rxq_dst->lease, NULL);
 
@@ -200,24 +202,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
-int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
-		      const struct pp_memory_provider_params *p,
-		      struct netlink_ext_ack *extack)
+static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+			       const struct pp_memory_provider_params *p,
+			       struct netlink_ext_ack *extack)
 {
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int ret;
 
-	if (!netdev_need_ops_lock(dev))
-		return -EOPNOTSUPP;
-
-	if (rxq_idx >= dev->real_num_rx_queues) {
-		NL_SET_ERR_MSG(extack, "rx queue index out of range");
-		return -ERANGE;
-	}
-	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
-
 	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
 		return -EINVAL;
@@ -264,16 +257,48 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
-			const struct pp_memory_provider_params *old_p)
+int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		      const struct pp_memory_provider_params *p,
+		      struct netlink_ext_ack *extack)
+{
+	struct net_device *orig_dev = dev;
+	int ret;
+
+	if (!netdev_need_ops_lock(dev))
+		return -EOPNOTSUPP;
+
+	if (rxq_idx >= dev->real_num_rx_queues) {
+		NL_SET_ERR_MSG(extack, "rx queue index out of range");
+		return -ERANGE;
+	}
+	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
+
+	if (!netif_rxq_is_leased(dev, rxq_idx))
+		return __netif_mp_open_rxq(dev, rxq_idx, p, extack);
+
+	if (!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)) {
+		NL_SET_ERR_MSG(extack, "rx queue leased to a virtual netdev");
+		return -EBUSY;
+	}
+	if (!dev->dev.parent) {
+		NL_SET_ERR_MSG(extack, "rx queue belongs to a virtual netdev");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = __netif_mp_open_rxq(dev, rxq_idx, p, extack);
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return ret;
+}
+
+static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+				 const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int err;
 
-	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
-		return;
-
 	rxq = __netif_get_rx_queue(dev, ifq_idx);
 
 	/* Callers holding a netdev ref may get here after we already
@@ -294,3 +319,48 @@ void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
 	WARN_ON(err && err != -ENETDOWN);
 }
+
+void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
+			const struct pp_memory_provider_params *old_p)
+{
+	struct net_device *orig_dev = dev;
+
+	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
+		return;
+	if (!netif_rxq_is_leased(dev, ifq_idx))
+		return __netif_mp_close_rxq(dev, ifq_idx, old_p);
+
+	if (WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &ifq_idx)))
+		return;
+
+	__netif_mp_close_rxq(dev, ifq_idx, old_p);
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+}
+
+void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
+			      const struct pp_memory_provider_params *p)
+{
+	if (p->mp_ops && p->mp_ops->uninstall)
+		p->mp_ops->uninstall(p->mp_priv, rxq);
+}
+
+/* Clean up memory provider state when a queue lease is torn down. If
+ * a memory provider was installed on the physical queue via the lease,
+ * close it now. The memory provider is a property of the queue itself,
+ * and it was _guaranteed_ to be installed on the physical queue via
+ * the lease redirection. The extra __netif_mp_close_rxq is needed
+ * since the physical queue can outlive the virtual queue in the lease
+ * case, so it needs to be reconfigured to clear the memory provider.
+ */
+void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
+			       struct netdev_rx_queue *virt_rxq)
+{
+	struct pp_memory_provider_params *p = &phys_rxq->mp_params;
+	unsigned int ifq_idx = get_netdev_rx_queue_index(phys_rxq);
+
+	if (!p->mp_ops)
+		return;
+
+	__netif_mp_uninstall_rxq(virt_rxq, p);
+	__netif_mp_close_rxq(phys_rxq->dev, ifq_idx, p);
+}
-- 
2.43.0


