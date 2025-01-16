Return-Path: <netdev+bounces-158771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A71A132CB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BDC166457
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505C19343B;
	Thu, 16 Jan 2025 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W8IuDHzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86C192598
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006809; cv=none; b=JqSukvTeq0oO2WTgnOOkxOc6KZfpwyN1zBv2gucdPNcra8uIh/iLH/iPHlqDRTQrQ4OCP8P4NIbFvvhIQooi+9pNV7OOLJ7T8JJEZ4x2UJse/JckpqtaKjge+2HvhPNZGF12RnOlz9hqp65AzkFoqMF2sCR4gV3NzJnyEUE0E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006809; c=relaxed/simple;
	bh=mVwktbWSoWFP1usMOPYKCXwzUeeubnCUrVQ2w9l1YuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQv13/dAktLoGLD4GttcHjzUfSa1aMA9GTe9R2tBB1YU9ZOqoe/gWkIysz9LLVMGho5eHHIDySQIrznatcoHACXuWap1cXkJzkFU/zz9iosnQIlq8ztBUJxyPxpWQOfU0Ety8uMOhFaagauzqjYk+MhtYYPeW3yInFwEx3qY9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W8IuDHzq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21669fd5c7cso7395625ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006806; x=1737611606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC/KHeKZrs1tP54amz5eEuxLD6Mq90VAvd7Bs8DlJ+8=;
        b=W8IuDHzqCQSok1vUWamvq63rULHrmt1A/F775C09EjKjhEwSa8c/zip+VYutvPsW77
         zIFSpp3ShLwE1KuLMPbtgfq5+Zr2UZvSWa+P3PmBb2p2LcMR1VPKauF9Gs0P6GBYhjRY
         bzH4655x9QpzIpxWW/s2PO5BX/h8Aer6RdDMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006806; x=1737611606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC/KHeKZrs1tP54amz5eEuxLD6Mq90VAvd7Bs8DlJ+8=;
        b=QPraHw8C8HCNuOvRwefJcPRlihd2VnB2ZjftnEIe4qNVgYYWY5AJ5PfohF9jYvVy91
         16PIGSPSxd+0+riw2f1rECkjFXjSgG5Ge4BaoVnK+geltAqwu1vbYEqW7mVqF8cRjEQM
         BM66ZF8GNYB0bskRMQxsWKijuu2FKcNmtWNyaCYwxBWGvdVWh7itJ/3lgjGPzazuMint
         EERiFo0hViLD3pWJ2QylPjcVCz8tTTUKqVpuMcEkc069bGK4+0hVV3CMHjKORLhjKb9q
         L7r2Rs3AkzvZJVAN2DWZg7q0qjPTNgwE9+6rXEVdsVFAZ6vMzw+kgjTz2MiUlknrl1Tn
         hVyg==
X-Gm-Message-State: AOJu0Yzpn6lHh1DOSmqD9YqOg4VmqOOdKZenMYGwrbJfbYpbhi8idHeM
	fmXAvuy4uboR9chhiNSxoHgJ2Y+zuH0BQ+ylBOuWq+ya6ads3T1KVztkzZFLqX4Y6aBeI6BRQRN
	qQgnHxrlz2pvreIZYuedecUHtOPK21Z6VfaA8cGq8MecjkZdmgSHPAP4hyCp6YQZM047ZUY/6Zq
	IY05vECjFO4PE384/GT3wskiGs4rYk5kUNgdI=
X-Gm-Gg: ASbGncsAqH5e701j0GuAwI5MNXksv1AfWiTwB6gdFADk/rP/aFpc01L0vJvh3cm5XRN
	vvvmlIYyEeuOfAGaJLpwDg1Ff7d2CbFfpMmunVdsph1xUV3mZBGqunkTjSLkqxFVpK8E7kOjgu6
	8l9jOVatL2y5mPgV+c4yjliiZZG0GStE0RTkTE2lhaU0tSiG5MlR8oR8pvVsEWsNY3lKd2GbWzt
	/Cz/VBGjIVTc4bpYUI+8F82l3X03HKklg3yOE2Q9N2GcxGL9RLdAMs7G72CyuIf
X-Google-Smtp-Source: AGHT+IGntTkOMJEdO2lJ/RT1ILNh9iXtgR2mfbiueSHch1JtTC7D230UEJorte+y+OkqI+IHqifhdA==
X-Received: by 2002:a17:902:e5c2:b0:215:b33b:e26d with SMTP id d9443c01a7336-21a83f55103mr529430015ad.21.1737006805997;
        Wed, 15 Jan 2025 21:53:25 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:25 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 1/4] net: protect queue -> napi linking with netdev_lock()
Date: Thu, 16 Jan 2025 05:52:56 +0000
Message-Id: <20250116055302.14308-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116055302.14308-1-jdamato@fastly.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

netdev netlink is the only reader of netdev_{,rx_}queue->napi,
and it already holds netdev->lock. Switch protection of the
writes to netdev->lock as well.

Add netif_queue_set_napi_locked() for API completeness,
but the expectation is that most current drivers won't have
to worry about locking any more. Today they jump thru hoops
to take rtnl_lock.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Added in v2 from Jakub.

 include/linux/netdevice.h     |  9 +++++++--
 include/net/netdev_rx_queue.h |  2 +-
 net/core/dev.c                | 16 +++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8308d9c75918..c7201642e9fb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -690,7 +690,7 @@ struct netdev_queue {
  * slow- / control-path part
  */
 	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
+	 * Readers and writers must hold netdev->lock
 	 */
 	struct napi_struct	*napi;
 
@@ -2458,7 +2458,8 @@ struct net_device {
 	 * Partially protects (writers must hold both @lock and rtnl_lock):
 	 *	@up
 	 *
-	 * Also protects some fields in struct napi_struct.
+	 * Also protects some fields in:
+	 *	struct napi_struct, struct netdev_queue, struct netdev_rx_queue
 	 *
 	 * Ordering: take after rtnl_lock.
 	 */
@@ -2685,6 +2686,10 @@ static inline void *netdev_priv(const struct net_device *dev)
 void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
+void netif_queue_set_napi_locked(struct net_device *dev,
+				 unsigned int queue_index,
+				 enum netdev_queue_type type,
+				 struct napi_struct *napi);
 
 static inline void netdev_lock(struct net_device *dev)
 {
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 596836abf7bf..9fcac0b43b71 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -23,7 +23,7 @@ struct netdev_rx_queue {
 	struct xsk_buff_pool            *pool;
 #endif
 	/* NAPI instance for the queue
-	 * Readers and writers must hold RTNL
+	 * Readers and writers must hold netdev->lock
 	 */
 	struct napi_struct		*napi;
 	struct pp_memory_provider_params mp_params;
diff --git a/net/core/dev.c b/net/core/dev.c
index 782ae3ff3f8d..528478cd8615 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6851,14 +6851,24 @@ EXPORT_SYMBOL(dev_set_threaded);
  */
 void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type, struct napi_struct *napi)
+{
+	netdev_lock(dev);
+	netif_queue_set_napi_locked(dev, queue_index, type, napi);
+	netdev_unlock(dev);
+}
+EXPORT_SYMBOL(netif_queue_set_napi);
+
+void netif_queue_set_napi_locked(struct net_device *dev,
+				 unsigned int queue_index,
+				 enum netdev_queue_type type,
+				 struct napi_struct *napi)
 {
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 
 	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
-	if (dev->reg_state >= NETREG_REGISTERED)
-		ASSERT_RTNL();
+	netdev_assert_locked_or_invisible(dev);
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
@@ -6873,7 +6883,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 		return;
 	}
 }
-EXPORT_SYMBOL(netif_queue_set_napi);
+EXPORT_SYMBOL(netif_queue_set_napi_locked);
 
 static void napi_restore_config(struct napi_struct *n)
 {
-- 
2.25.1


