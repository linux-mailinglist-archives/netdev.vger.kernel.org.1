Return-Path: <netdev+bounces-274753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DYJIcf5zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D580A38F23B
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C38BB3083760
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078B3FADE7;
	Thu,  2 Apr 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OkGS8oqz"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CB3F1667;
	Thu,  2 Apr 2026 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171463; cv=none; b=VblKnLln5uFVaQRa8YGAOx2jV+OI2ZaZ6fKG7VHjxO2Eb7QtGzTpadvDhsnKW0a41DqHbeGzOlQo+CNwm03gkVor+XPiQgGIgGXJyzsUuQlncdkV4L6aKek7e2j9KiBO9wYcEYDu2YWja5RWFyvxEmUJ2nsL+euo1K592BQEguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171463; c=relaxed/simple;
	bh=i+g0vC4eFoI6yao3/LrtW0tAIHtLsyRVDczUsOokHZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JU30tiJgoNXjMA0ei6xapgkBFIo3EEZfIY0EGXVEZ8R96UVUjTyxIABDGwzdgcb0aQPuWIpiQJxXWhkYeYY4dLjtYhKFXTB/LMd0khRSoL2oKDRtlbIqH2a4WLAZroTkwWALHlH6XufeH8XvGxZxdv6AjoKj2lkq6N8qzY2j1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OkGS8oqz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GnY28wpFkMbn93yfj9OXJLREKu4h8R7relqWa3gv2cU=; b=OkGS8oqzxqIvSiNy66F+2odBUd
	eScvssMHn/Tkc6mDhwiCzTq3Ava2R1HlBoKk+xkr+dv3E+hlyBKPd/vbFgSE8EYIKeaiftvbYgf7c
	cB5u9h510CzXcd2heH6VUZqhfnvwoL5mrydnAbtwtOHwC1SEGKyB7nl3OhttNhKQ6xjf8eadqAWTu
	/ntpKm2jou1P40/hkXnHqic7ZHAqUVrar0/Ftpatxt0jOoS2b7PE5GyMKwFe9OTGtfTZjjiTAQ+Tw
	y2hLjPveEbbJ8cz1WrWUOgInhb9CuuELy3SD8gr1vT7EQZAEHp933PkzQ/SgEJgxsWpmiWi0NZkTg
	tt/N7jIg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w8RBR-0000mw-1o;
	Fri, 03 Apr 2026 01:10:41 +0200
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
Subject: [PATCH net-next v11 07/14] net: Proxy netdev_queue_get_dma_dev for leased queues
Date: Fri,  3 Apr 2026 01:10:24 +0200
Message-ID: <20260402231031.447597-8-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274753-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid]
X-Rspamd-Queue-Id: D580A38F23B
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/netdev_queues.h |  4 +++-
 io_uring/zcrx.c             |  3 ++-
 net/core/netdev-genl.c      |  5 +++--
 net/core/netdev_queues.c    | 41 +++++++++++++++++++++++++++++--------
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 748b70552ed1..70c9fe9e83cc 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -380,7 +380,9 @@ static inline unsigned int netif_xmit_timeout_ms(struct netdev_queue *txq)
 					 get_desc, start_thrs);		\
 	})
 
-struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
+struct device *netdev_queue_get_dma_dev(struct net_device *dev,
+					unsigned int idx,
+					enum netdev_queue_type type);
 bool netdev_can_create_queue(const struct net_device *dev,
 			     struct netlink_ext_ack *extack);
 bool netdev_can_lease_queue(const struct net_device *dev,
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index d3ec63c83d0c..f4a7809ba0c2 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -829,7 +829,8 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 	}
 	netdev_hold(ifq->netdev, &ifq->netdev_tracker, GFP_KERNEL);
 
-	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
+	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq,
+					    NETDEV_QUEUE_TYPE_RX);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
 		goto netdev_put_unlock;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 515832854251..056460d01940 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -976,7 +976,8 @@ netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
 	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
 		struct device *rxq_dma_dev;
 
-		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
+		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx,
+						       NETDEV_QUEUE_TYPE_RX);
 		if (dma_dev && rxq_dma_dev != dma_dev) {
 			NL_SET_ERR_MSG_FMT(extack, "DMA device mismatch between queue %u and %u (multi-PF device?)",
 					   rxq_idx, prev_rxq_idx);
@@ -1153,7 +1154,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	dma_dev = netdev_queue_get_dma_dev(netdev, 0, NETDEV_QUEUE_TYPE_TX);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 177401828e79..265161e12a9c 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -6,27 +6,50 @@
 
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
+ * @type:	queue type (RX or TX)
  *
- * Get dma device for zero-copy operations to be used for this queue.
- * When such device is not available or valid, the function will return NULL.
+ * Get dma device for zero-copy operations to be used for this queue. If
+ * the queue is an RX queue leased from a physical queue, we retrieve the
+ * physical queue's dma device. When the dma device is not available or
+ * valid, the function will return NULL.
  *
  * Return: Device or NULL on error
  */
-struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
+struct device *netdev_queue_get_dma_dev(struct net_device *dev,
+					unsigned int idx,
+					enum netdev_queue_type type)
 {
-	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
+	struct net_device *orig_dev = dev;
 	struct device *dma_dev;
 
-	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
-		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
-	else
-		dma_dev = dev->dev.parent;
+	/* Only RX side supports queue leasing today. */
+	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
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


