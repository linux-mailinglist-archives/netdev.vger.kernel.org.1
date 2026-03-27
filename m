Return-Path: <netdev+bounces-272530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPfhF7x0xmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:14:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB33440CB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD10B30F6978
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFA394493;
	Fri, 27 Mar 2026 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="B/OOvF8M"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F239446B;
	Fri, 27 Mar 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613481; cv=none; b=qwtQWPHK4pph4HOL3BSpoYxvZlJYLOb5/hg9sYdTetPGmcJR/ahEDg72yqFu0LReMXkJld0tamjGL9phQEp/B0OlOwFIzNBZa9YwHdAU+ieq3hSBfHHd18+Ov6ecRkyYxYLZQNhAPY1wgLl6eYsorQQbtVqtRaSfDFnfRkFBa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613481; c=relaxed/simple;
	bh=YY4T7TMmhyRQpxW/75bfS5G1j7/95crLSD2DQXKDiKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW7MHaFEXebHwhWWVPdv5FMXyVSzfs8KKSQECJ5lpccABBufNp9sp/JLprxb5CvlbToiIc7ia68UTNPLEZW52VieYlfgBYr7ojw53AGywNfUH/O8UsRJ7TxT2pYlCbCw2bHSCd+ahsMtHOq+NwAWK99+s1htdi0vmbJmsQfcNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=B/OOvF8M; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=apXZKXvCe246XzEzdOO4RcC0tVH8jgumRDPcWbMAkMU=; b=B/OOvF8M5iueTvQa1njuh7bF+x
	j57U/mqzWTsoc5W1yYDfg6ofxkgF+OxqLV6UPFBUNr2vdbxahvzyf6HI6smhIBoaT9Up08Nh2DZf9
	8KUeyOLQLSHC4TQVNGkO+xo55s0uR+kUdGUJrrJ0kiDGGDfSqBiY1L7SpiGQSohpbZQ+Ol2iDCjmi
	ZskwWy2Ica8DAeZVsScv3iZ6PzVlAkdij4D1+ynFP0/VmmjqpdqS1uvobJPeiS6h9h9LmM+gCk4Is
	kYE+q+gZCeTLZZyfPhZikGsQDz60PdH2jlMQTZgCJGNo2btlrNNIe8W/zm5EXYaKGWHKPrW5NV7zf
	ouOHmd6A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w661k-000ANU-0B;
	Fri, 27 Mar 2026 13:11:00 +0100
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
Subject: [PATCH net-next v10 07/14] net: Proxy netdev_queue_get_dma_dev for leased queues
Date: Fri, 27 Mar 2026 13:10:42 +0100
Message-ID: <20260327121049.334562-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327121049.334562-1-daniel@iogearbox.net>
References: <20260327121049.334562-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27953/Fri Mar 27 07:24:46 2026)
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
	TAGGED_FROM(0.00)[bounces-272530-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid]
X-Rspamd-Queue-Id: BAEB33440CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Wei <dw@davidwei.uk>

Extend netdev_queue_get_dma_dev to return the physical device of the
real rxq for DMA in case the queue was leased. This allows memory
providers like io_uring zero-copy or devmem to bind to the physically
leased rxq via virtual devices such as netkit.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/netdev_queues.h |  3 ++-
 net/core/netdev_queues.c    | 36 ++++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 748b70552ed1..d14a45a13b40 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -380,7 +380,8 @@ static inline unsigned int netif_xmit_timeout_ms(struct netdev_queue *txq)
 					 get_desc, start_thrs);		\
 	})
 
-struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
+struct device *netdev_queue_get_dma_dev(struct net_device *dev,
+					unsigned int idx);
 bool netdev_can_create_queue(const struct net_device *dev,
 			     struct netlink_ext_ack *extack);
 bool netdev_can_lease_queue(const struct net_device *dev,
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 177401828e79..9a945d74c3a7 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -6,27 +6,47 @@
 
 #include "dev.h"
 
+static struct device *
+__netdev_queue_get_dma_dev(struct net_device *dev, unsigned int idx)
+{
+	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
+	struct device *dma_dev;
+
+	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
+		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
+	else
+		dma_dev = dev->dev.parent;
+
+	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
+}
+
 /**
  * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
  * @dev:	net_device
  * @idx:	queue index
  *
- * Get dma device for zero-copy operations to be used for this queue.
+ * Get dma device for zero-copy operations to be used for this queue. If the
+ * queue is leased from a physical queue, we retrieve the physical queue's
+ * dma device.
  * When such device is not available or valid, the function will return NULL.
  *
  * Return: Device or NULL on error
  */
-struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
+struct device *netdev_queue_get_dma_dev(struct net_device *dev,
+					unsigned int idx)
 {
-	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
+	struct net_device *orig_dev = dev;
 	struct device *dma_dev;
 
-	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
-		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
-	else
-		dma_dev = dev->dev.parent;
+	if (!netif_rxq_is_leased(dev, idx))
+		return __netdev_queue_get_dma_dev(dev, idx);
 
-	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
+	if (!netif_get_rx_queue_lease_locked(&dev, &idx))
+		return NULL;
+
+	dma_dev = __netdev_queue_get_dma_dev(dev, idx);
+	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	return dma_dev;
 }
 
 bool netdev_can_create_queue(const struct net_device *dev,
-- 
2.43.0


