Return-Path: <netdev+bounces-270091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL+eC3XIvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:21:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD42E1B77
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB36E307D82D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EAC389454;
	Fri, 20 Mar 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="STyqM3HY"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A137416A;
	Fri, 20 Mar 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045130; cv=none; b=j14cAM7lBbSWWPhfRDi1QlMAJ84YHW0d8MtHgb/Ejw90lGQyhaV6fUoDZ9Vs/fbvKyGkw3JIc1orWcwuNULy9wk1gRLkwfWhBljcT0Udr/fAyBFZu68vmQgRsIr8VtxArxa8WDMsof03Z2gx3cJf5umS79uUsCpiYWt4kJJTtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045130; c=relaxed/simple;
	bh=RwNAOvQwh9t8CDdPG5sGY28ifTbCvfoQ1QJMUsWtrII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fkf6utAs4qxw4A9/o0w/1kEYRwajfOfpThMquPL1uGu9Bq8pfzpsltvLsBOlyzz2sKJW263QAkXRQxMdLYCxBt7Z9onl1iN7mKFLdYr783oLZHYuXh5+RFSHKZPXxPAqTK+c4v+wOB98orQm5qbt1mI8hpRPkQsQT0W0q8COL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=STyqM3HY; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6Su5fFOYtBqb5fkakDbNN1MfExKHkz/9+r9F5WAzx80=; b=STyqM3HY4IjZ3AsWLsL4gtXx5s
	YC3SzX1uRvCCyo8sfgmSrB6NNIVACnlRmSYe7uTDiAtMZ6M/wMyixEmd7UK9k9Eyy4SPBb63i/nmP
	uzo4Fbf2dJpS8/2975iScNr8YLGMOA3h+8usqDhnMi6XBgYr5cSj96b4+ZN6PJt1b4KRTeCbCzVPI
	EKGTKyysWahDQs+hLdABDPXq5/32gS1Q1gne8JNedLAafDkUHXtkMQOjGKvwDFly9TgIB/Xv0mHkj
	bDH8rlx5kdjR+UExtSYxmGJzws8CsfurBPqA+715/WmyMdTMCXoUrnsps/uU4TaCPmx6BjxUDBOe0
	sG83m/Ng==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAi-000GzO-2m;
	Fri, 20 Mar 2026 23:18:24 +0100
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
Subject: [PATCH net-next v9 07/14] net: Proxy netdev_queue_get_dma_dev for leased queues
Date: Fri, 20 Mar 2026 23:18:07 +0100
Message-ID: <20260320221814.236775-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320221814.236775-1-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270091-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,davidwei.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83BD42E1B77
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
index 567bc2efde6d..260558192ab1 100644
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
index 92a0b6b2842f..437e9cd0cc7a 100644
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


