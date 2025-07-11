Return-Path: <netdev+bounces-206212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2933B0224F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AA91CA260A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4C2EF9C9;
	Fri, 11 Jul 2025 17:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43757219A91;
	Fri, 11 Jul 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253628; cv=none; b=DtEzTZAmFCzvN06CWZ+JVUabfyN3Wz68ORsyRcPOhhCYCu2KLouclK/9418ZAXckaU08ZGMj966o0DqAh2BvrvVPgu/hL57LkTIvnAiFc3/Y5kzmhjNiN1Vbp/ertTF6kg4aB2Rl5VWwsIjhKKEIFrTabXvB0zWCKKYm7WTcmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253628; c=relaxed/simple;
	bh=4+q2RrFArN5BUaP53yFVzUX1RuoXv58PDG9QO9loeNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AYN78XNJYAY/ujLd+p9PXIoqvE3BV08Yc36Q7z26nlfjeI3Q/TRJ0ojv1FWGdlVFiYFbV/fWB5U8HR5R4AxZrzXGAp9vI8+ZcSY+vAVD4QLZeeHvK+EPWRGDm7htkYVb2CRxeS2pNpHvW2etJ5XMSybKhTmVp7HdCZz1Qs6QjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso415969466b.0;
        Fri, 11 Jul 2025 10:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253624; x=1752858424;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKPWFxQCXKDcGznRpXbuav95dpMmtVl5vm+395N2KKc=;
        b=RQHzCvMs5y2aekVf3VWYMC41hZozDaqrEMGt7jfuhHwm9OAmD5EeLTezDUy0TaZmLm
         ZvsSDqGnvbXH+iMghSKLJmfylrGXBhLivXKVqf9yEekgssMIXYWvFgmOCoo/ueKjdnXx
         7IGDWUJAoAb3jSTDE1p2hV8rGZSX3YUOUsJfGHs7AWSHE6BX3s/JQUnFgwD04BeUA2es
         c/vcPaYPiJVyqWVKxW0hpliAtyRphqIH3UubX4iqt8UT4LO8pimaQ9n8jtr+ExYRJiRB
         enw748UrtZcmhs7i+Wh14An0p6/GPSIbpg0LPGu8psZ3JR58m28R6q+7jfiRKTPBjDMh
         p5AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSW1mLE8MHeFRtEUJNGVLZSM7wUC/K891lr2MLGUuNhzwQSJcmoKMMDa820/4da3qwgEXY7QxVts6hNVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuEY9FN0psk/NhYpmUVwabnB1EEBGYUNl1Qh5WNEv73rWdKb64
	vVmFJ9cGTq2QawDmbwfXaho8zD689kUwmh4aFNgFD6K7NdLWlRgLeW+T
X-Gm-Gg: ASbGnctuZ8TkhNyPGSySmQMzEb0IouPM2H7E49mzd5x7a9yjPu3xRNHqrnyIUUzYOZN
	StHzXt5KUeYP6/4gABW05eDMfS/PzvApeuh66TOuBBYurgS9dPDzH9uSekKiEJNx2pohF0WcHEs
	M6PUwNTOatuam/+bGrkyZTZq5O8XbT9US+saOd4N1izy723SfP56w8Jr6tAY4jalXjJ8lVNohQz
	/CkYtfNUr+ZPyQYNi43jV0bRt/iC8keGBU7+D25sQiYu55zXVfMnSsd5tPbXPI5X+3jkkpS56Wr
	1yP9u/85QKkdp36GtgskTGmUdk64wYetEV8/x47xsxouKzQiTXARTl0dkBwBIQDkXQ68+mEtoAi
	bmv+jc0Mxp3ZWZB3EnXpsWC4d
X-Google-Smtp-Source: AGHT+IHth8tcEIRt6ZDS2lF+RWeEr7Pa+YSnxYIDlJWFtPSSbMO601EB9AqJxQevbqyNwwdYItef/g==
X-Received: by 2002:a17:907:3d0b:b0:ae0:b7f6:9d76 with SMTP id a640c23a62f3a-ae6e253ffd7mr892692466b.28.1752253624084;
        Fri, 11 Jul 2025 10:07:04 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829629dsm325561266b.138.2025.07.11.10.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:07:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Jul 2025 10:06:59 -0700
Subject: [PATCH net-next v3] netdevsim: implement peer queue flow control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-netdev_flow_control-v3-1-aa1d5a155762@debian.org>
X-B4-Tracking: v=1; b=H4sIALJEcWgC/23N3QqDIBiA4VuR7ziHP5XY0e5jjCj7KiF0qLhGd
 O8Djzbo+IXnPSBisBihIwcEzDZa76AjsiJg1sEtSO0EHQHBRMNayajDNGHu582/e+NdCn6jYhS
 TVLptpFJQEXgFnO1e1Ac4TNThnuBZEVhtTD58yi7z0ousGL+UM6ecippJoWej+cjvE452cDcfl
 gJm8YvIa0RQToeRMVlzo435R87z/AIzvTVABgEAAA==
X-Change-ID: 20250630-netdev_flow_control-2b2d37965377
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dw@davidwei.uk, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7072; i=leitao@debian.org;
 h=from:subject:message-id; bh=4+q2RrFArN5BUaP53yFVzUX1RuoXv58PDG9QO9loeNQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBocUS29xSkLXx9Y0Zad+bOjHtSHXgIcvMUUiD2C
 2DE+X1NrWyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHFEtgAKCRA1o5Of/Hh3
 bWAaEACUU0U0wTDVf8n9sX6Hdck0G7dk1vCE2hNSAM+D64liMce2r1d6QemveorgYHlZjKNWGdN
 /f4XczbNCCruLLV/3SyEpJ/+jS+/9a8cAPsBechbkZlmTNYAYw5keWj8N8IcP04186sGqBDTA8g
 kf1NTM7ZXa2Bzgzt/OpTzg48GW7D9yt8etYes4usZl5e8mUeILr6h4eTHiZKDvV5CZ0Y5zDXReP
 sNICO/CEiEGG6yzGaaOHB+g1QQLmQPpRcOcOZMhg5ewM+HdB+6G1cvv2fo5N8JHeLKklFmgwtEg
 t3+DiN6MjzDTsLI6azmR6u/Zw09XeDB3lhg72DqeIAGnIsWeYP82/+lf7qJvhUxhKT041F7odHL
 g7/1JrLc7zZ5YdAQoAUd5UFs3Gw3/HQU3XAWmQ/pq59Mibnz5YIHOey6XLEQ+eCgArCT4OSBo1O
 QIyOaHGl7mz0fOc8uerbkYVJJHPr6rMCBd2fMWsO/1re7OHSzHs3dnxIyQIbjrepYmIKMjVuzTY
 OHow+CpmOxQ/srwpiA0exYaFTHmrUKaKXa0RM5KazWyiYfH4teJyggONV8cxwqfOXkqQx8nwBqy
 ft02fMVAWoIc0IkslVAELsXR4+zXl2j+zLWBqEEhLB1Fe3FcibdEeyGRZ27TTjw401eHAM80lJr
 wdch00wsXiSj5eg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add flow control mechanism between paired netdevsim devices to stop the
TX queue during high traffic scenarios. When a receive queue becomes
congested (approaching NSIM_RING_SIZE limit), the corresponding transmit
queue on the peer device is stopped using netif_subqueue_try_stop().

Once the receive queue has sufficient capacity again, the peer's
transmit queue is resumed with netif_tx_wake_queue().

Key changes:
  * Add nsim_stop_peer_tx_queue() to pause peer TX when RX queue is full
  * Add nsim_start_peer_tx_queue() to resume peer TX when RX queue drains
  * Implement queue mapping validation to ensure TX/RX queue count match
  * Wake all queues during device unlinking to prevent stuck queues
  * Use RCU protection when accessing peer device references
  * wake the queues when changing the queue numbers
  * Remove IFF_NO_QUEUE given it will enqueue packets now

The flow control only activates when devices have matching TX/RX queue
counts to ensure proper queue mapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Wake the queues if we need to in nsim_set_channels() (Jakub)
- Remove IFF_NO_QUEUE (Jakub)
- Improve function parameters (Jakub) 
- Link to v2: https://lore.kernel.org/r/20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org

Changes in v2:
- Move the RCU locks inside the function (David)
- Use better helpers for waking up all the queues (Jakub)
- Link to v1: https://lore.kernel.org/r/20250701-netdev_flow_control-v1-1-240329fc91b1@debian.org
---
 drivers/net/netdevsim/bus.c     |  3 ++
 drivers/net/netdevsim/ethtool.c | 21 +++++++++++++
 drivers/net/netdevsim/netdev.c  | 68 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf85..1ba52471f3fbc 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -366,6 +366,9 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
 	err = 0;
 	RCU_INIT_POINTER(nsim->peer, NULL);
 	RCU_INIT_POINTER(peer->peer, NULL);
+	synchronize_net();
+	netif_tx_wake_all_queues(dev);
+	netif_tx_wake_all_queues(peer->netdev);
 
 out_put_netns:
 	put_net(ns);
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 4d191a3293c74..f631d90c428ac 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -101,6 +101,22 @@ nsim_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 	ch->combined_count = ns->ethtool.channels;
 }
 
+static void
+nsim_wake_queues(struct net_device *dev)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer;
+
+	synchronize_net();
+	netif_tx_wake_all_queues(dev);
+
+	rcu_read_lock();
+	peer = rcu_dereference(ns->peer);
+	if (peer)
+		netif_tx_wake_all_queues(peer->netdev);
+	rcu_read_unlock();
+}
+
 static int
 nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 {
@@ -113,6 +129,11 @@ nsim_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return err;
 
 	ns->ethtool.channels = ch->combined_count;
+
+	/* Only wake up queues if devices are linked */
+	if (rcu_access_pointer(ns->peer))
+		nsim_wake_queues(dev);
+
 	return 0;
 }
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2dc..48da5d4b3a89a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -37,7 +37,53 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
 #define NSIM_RING_SIZE		256
 
-static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
+static void nsim_start_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
+	struct netdevsim *peer_ns;
+	struct netdev_queue *txq;
+	u16 idx;
+
+	idx = rq->napi.index;
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out;
+
+	/* TX device */
+	peer_dev = peer_ns->netdev;
+	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
+		goto out;
+
+	txq = netdev_get_tx_queue(peer_dev, idx);
+	if (!(netif_tx_queue_stopped(txq)))
+		goto out;
+
+	netif_tx_wake_queue(txq);
+out:
+	rcu_read_unlock();
+}
+
+static void nsim_stop_tx_queue(struct net_device *tx_dev,
+			       struct net_device *rx_dev,
+			       struct nsim_rq *rq,
+			       u16 idx)
+{
+	/* If different queues size, do not stop, since it is not
+	 * easy to find which TX queue is mapped here
+	 */
+	if (rx_dev->real_num_tx_queues != tx_dev->num_rx_queues)
+		return;
+
+	/* rq is the queue on the receive side */
+	netif_subqueue_try_stop(tx_dev, idx,
+				NSIM_RING_SIZE - skb_queue_len(&rq->skb_queue),
+				NSIM_RING_SIZE / 2);
+}
+
+static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
+			struct nsim_rq *rq, struct sk_buff *skb)
 {
 	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
 		dev_kfree_skb_any(skb);
@@ -45,13 +91,22 @@ static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&rq->skb_queue, skb);
+
+	/* Stop the peer TX queue avoiding dropping packets later */
+	if (skb_queue_len(&rq->skb_queue) >= NSIM_RING_SIZE)
+		nsim_stop_tx_queue(tx_dev, rx_dev, rq,
+				   skb_get_queue_mapping(skb));
+
 	return NET_RX_SUCCESS;
 }
 
-static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
+static int nsim_forward_skb(struct net_device *tx_dev,
+			    struct net_device *rx_dev,
+			    struct sk_buff *skb,
 			    struct nsim_rq *rq)
 {
-	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
+	return __dev_forward_skb(rx_dev, skb) ?:
+		nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -86,7 +141,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
-	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
+	if (unlikely(nsim_forward_skb(dev, peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
 	if (!hrtimer_active(&rq->napi_timer))
@@ -351,6 +406,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			dev_dstats_rx_dropped(dev);
 	}
 
+	nsim_start_peer_tx_queue(dev, rq);
 	return i;
 }
 
@@ -864,10 +920,8 @@ static void nsim_setup(struct net_device *dev)
 	ether_setup(dev);
 	eth_hw_addr_random(dev);
 
-	dev->tx_queue_len = 0;
 	dev->flags &= ~IFF_MULTICAST;
-	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
-			   IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->features |= NETIF_F_HIGHDMA |
 			 NETIF_F_SG |
 			 NETIF_F_FRAGLIST |

---
base-commit: 5fa1fa9184ef1af929ae49c715d4a25667e84df5
change-id: 20250630-netdev_flow_control-2b2d37965377

Best regards,
--  
Breno Leitao <leitao@debian.org>


