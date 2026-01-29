Return-Path: <netdev+bounces-254928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIRzOpbfe2ljJAIAu9opvQ
	(envelope-from <netdev+bounces-254928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF8B552E
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E9A3014559
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75436BCFA;
	Thu, 29 Jan 2026 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="H1/+K9CC"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AA36B048;
	Thu, 29 Jan 2026 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725737; cv=none; b=n2YUsitJjxETh9gWbY8MtJRJiAg8EqNwPniamV1Z0AynLyKzl3qYpcOomYBmA31MjPNI0BE0KOlOr/fjLihbL2JSJsanyhATdzcLcXAwBHylzwruwW/vBmqX9ZwhOMXNNuGTVCMVy3S/ka8LritRqcHlqEer6zAk2E1T1DxHdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725737; c=relaxed/simple;
	bh=QtzUHdvemOEtGXwtFMGlfXRLWTd5tfmkzF/JHada3uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtj84aA5TntzJkaRTx7PlI141WaaED+fzAyHIpO/bvE0yju05GFbw+6wN1pD0m0XrkZDC4y1HfbOSB1A+1SCub6WOpkll00sjSjWJAhd1321j8nCflWj02LYmz4iTcW3qv/xBoIo9B30WNmOb0OYeKODaDuTvDuRmphxYiYs6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=H1/+K9CC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w6O7NsX4BczszYoYFVZU2xFBasObioQYwXtP7O8vgMQ=; b=H1/+K9CCYpbuT+WRRTt5HcX3BX
	sr3qdM1q3A/fgORWjhn14PhUVt8bdmmM0mLFlb1EVJfYv2sZ3r7jc5XZcrIEl0T/eMSMvooANX4Ae
	14/WViY34eQBjUKnFYxnB4BS5vIhYJYdTkxlPTQtFNdFq93S0jr6K80Uwzledy0vOtPYVyEkcw9si
	jXDvOM4S0XQQepY2EfOfOwqPvnq9OYEjVrhtMAnm4BIipqU6fFFcUyTr0ZDrT0lCnWkNkhvmJt73Z
	HFWTlDyb+xM6bG9Mq19OWxmQ8PExeyJ8H9EMRS9eF+bpnPQ4Icg/Cm0uUoIlWtnJR8Aab9RkSDoLY
	G38f5Zrw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVC-0008p0-2y;
	Thu, 29 Jan 2026 23:28:38 +0100
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
Subject: [PATCH net-next v8 06/16] net: Proxy net_mp_{open,close}_rxq for leased queues
Date: Thu, 29 Jan 2026 23:28:20 +0100
Message-ID: <20260129222830.439687-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254928-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei.uk:email,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: 7DBF8B552E
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

When a process in a container wants to setup a memory provider, it will
use the virtual netdev and a leased rxq, and call net_mp_{open,close}_rxq
to try and restart the queue. At this point, proxy the queue restart on
the real rxq in the physical netdev.

For memory providers (io_uring zero-copy rx and devmem), it causes the
real rxq in the physical netdev to be filled from a memory provider that
has DMA mapped memory from a process within a container.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/netdev_rx_queue.h |   4 ++
 net/core/netdev_rx_queue.c    | 100 +++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 589192f67d97..0286c81fb156 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -75,4 +75,8 @@ enum netif_lease_dir {
 struct netdev_rx_queue *
 __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
 			   enum netif_lease_dir dir);
+struct netdev_rx_queue *
+netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq);
+void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
+				     struct net_device *dev);
 #endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index f30fe7550455..34e523f1e926 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -68,6 +68,29 @@ __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
 	return rxq;
 }
 
+struct netdev_rx_queue *
+netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq_idx)
+{
+	struct net_device *orig_dev = *dev;
+	struct netdev_rx_queue *rxq;
+
+	/* Locking order is always from the virtual to the physical device
+	 * see netdev_nl_queue_create_doit().
+	 */
+	netdev_ops_assert_locked(orig_dev);
+	rxq = __netif_get_rx_queue_lease(dev, rxq_idx, NETIF_VIRT_TO_PHYS);
+	if (rxq && orig_dev != *dev)
+		netdev_lock(*dev);
+	return rxq;
+}
+
+void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
+				     struct net_device *dev)
+{
+	if (orig_dev != dev)
+		netdev_unlock(dev);
+}
+
 bool netif_rx_queue_lease_get_owner(struct net_device **dev,
 				    unsigned int *rxq_idx)
 {
@@ -191,24 +214,15 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 }
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
-int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
-		    const struct pp_memory_provider_params *p,
-		    struct netlink_ext_ack *extack)
+static int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+			     const struct pp_memory_provider_params *p,
+			     struct netlink_ext_ack *extack)
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
@@ -255,17 +269,47 @@ int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-void net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
-		      const struct pp_memory_provider_params *old_p)
+int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
+		    const struct pp_memory_provider_params *p,
+		    struct netlink_ext_ack *extack)
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
+
+	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
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
+	ret = __net_mp_open_rxq(dev, rxq_idx, p, extack);
+out:
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return ret;
+}
+
+static void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+			       const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int err;
 
-	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
-		return;
-
-	rxq = __netif_get_rx_queue(dev, ifq_idx);
+	rxq = __netif_get_rx_queue(dev, rxq_idx);
 
 	/* Callers holding a netdev ref may get here after we already
 	 * went thru shutdown via dev_memory_provider_uninstall().
@@ -278,10 +322,24 @@ void net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
+	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
 	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
-	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
+	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
 
-	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
+	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
 	WARN_ON(err && err != -ENETDOWN);
 }
+
+void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+		      const struct pp_memory_provider_params *old_p)
+{
+	struct net_device *orig_dev = dev;
+
+	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
+		return;
+	if (WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)))
+		return;
+
+	__net_mp_close_rxq(dev, rxq_idx, old_p);
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+}
-- 
2.43.0


