Return-Path: <netdev+bounces-203023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45DAF0290
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D7B4E496A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174B27EFF3;
	Tue,  1 Jul 2025 18:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5081B95B;
	Tue,  1 Jul 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393469; cv=none; b=WeLh969WV7Y2OhoWN8lB74xbLwmjRVUYhGwIPa8w3LVW+e1SwEljrlpVBCkLjqQhxT5oC4LnEbVboo3YJs8i2muD7I3xf83debhwVgYRWdoJp2P8C/QStSk3uSqOZQolZWW6V73AGPIYscHA6xuQ47S3iByRpTxKZdl80YydDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393469; c=relaxed/simple;
	bh=0YKtw3CEvePUjY+ENACCaBsqZrvuh0fbi7t6dSBt414=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OtCMxrQ9pb+v45MYOE7sE6F+VVdMUb3dCewrfVw1lZGtkVQwctLBEfOWx5RzUIgPLPL8mkSkCklfiyw6zM6V5GAbOxSvs19Mcwm5pmvF3nEl4eGrRUcozX51X/LQW/uefVaVKR1nxM1/iDmDQ9tsk0Ec++PipGXwXnhGoeTTJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso10662362a12.0;
        Tue, 01 Jul 2025 11:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751393466; x=1751998266;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwVlUmBYZyIOOFNL+O2LCn5cdARUsByb//UShdLPdtA=;
        b=vsgYO1wkR9H3Z76ZbyK8aDbywZ9bwtdQ4hvjp2aiE+sq5/y1p82AbtyUlM0uO7Fm4L
         eYMKVdMePMaYTDFEdbbONGfCsKOwWcP5BECu8PqqdHlOHcYicsyuNDM48yCgA2h0oj3i
         i+vJbFZk/mGfQ0KdmPSCiiaMQlg3Bh7tz6DYBU0M3zucVmli7jXR9yj5gOD/VAmBj5hH
         u7SwR1I6Odp/t8PfqjtcRgFM5T0tY3X5jEbM5qnmpYqr+YxYYbd6zg5pF+FfJkR15yRp
         tOGzWUM2jUIZzGgFNzs2ETUqvl8zbMTkmLnuFD92SaZlpDS3/KMQm2eWw6/BC0J4dIM3
         aWNA==
X-Forwarded-Encrypted: i=1; AJvYcCXz37y6epWuKXuK0YF8G2XjPab7HIh02gxkoPZn3ael9HYgTFkJOe1frmve73W7zhbftezbINgg0ierirs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww58CmT3XVsc2dNiymq7Q9gGNO14ms6B1M1lJfj39xlv42vaLC
	K2WtFBUWDR0xVYpc1uXvNTS5Qq5ILvvPAZdFYrA9RmdYqb8QcRryXEeFRR8UDQ==
X-Gm-Gg: ASbGncuSQhyfjnrPF84jl2D0zsvWTmZtzaJB9tMG1tNwSy/1zy1tAOJtu++gipRGxAH
	LgpJRaTxgw2+qK+2iiQHz9PUMF4B14Ys0BQpyB1mVjuSeuq0xPjUD4EZevzr1JvashzN8iEjOEi
	Bbrmh0uvze5Adm4Bf8yhMbO9bvK4/+TYvAKHYEGXo/ukh666kGuGoRhdM2Mo3z9QXz9qoXiEM0h
	pGQvLt4/IwoNubiNqeAEKt6J1yANGS17eDdcOnx/NQtzLYXHi5hd7D/XRGVzP+D9qukwEan4vdx
	zZ1k8mKbkTolcB7gkmQNZAOWQV7z0Fb+SiE/ryS1OfysF78sz+Vl
X-Google-Smtp-Source: AGHT+IGwS89J5/t4C1gaXE7hpJ3orVPl9gS4wuCfhDbmR9srNzjcCGoOus+SMSXcGa/PM+H0DRIlzQ==
X-Received: by 2002:a05:6402:350c:b0:607:ea0c:65b2 with SMTP id 4fb4d7f45d1cf-60c88e64bfbmr16502118a12.31.1751393465035;
        Tue, 01 Jul 2025 11:11:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bb1d8sm7920490a12.6.2025.07.01.11.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:11:04 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 01 Jul 2025 11:10:56 -0700
Subject: [PATCH net-next] netdevsim: implement peer queue flow control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-netdev_flow_control-v1-1-240329fc91b1@debian.org>
X-B4-Tracking: v=1; b=H4sIAK8kZGgC/x3MUQqDMBAFwKss79tAmqChuUop0prVLsimJMEK4
 t0LzgHmQOUiXBHpQOFNqmRFpFtHmD4vXdhIQiQ463o7eGuUW+JtnNf8G6esreTVuLdLPtyH3oe
 AjvAtPMt+rQ8oN6O8NzzP8w8Ry135bwAAAA==
X-Change-ID: 20250630-netdev_flow_control-2b2d37965377
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dw@davidwei.uk, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5091; i=leitao@debian.org;
 h=from:subject:message-id; bh=0YKtw3CEvePUjY+ENACCaBsqZrvuh0fbi7t6dSBt414=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZCS3BOgyvPWdAulX0JKI6Ju30hr0G0CQPLnWZ
 wo8GKlAKIeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGQktwAKCRA1o5Of/Hh3
 bV3EEACkHNd/pDNazodCq/jaXnz1HWwTsFCWgxFs2loZNtLjdqzjHoQgETwK/ZZQ1hqbkH98BsO
 gI63ODI4cZ9MSQEtBkOh9Sxgck7ZXfpdBCL5vvSIG75Nqxl7u9vVd4VseeJmHqbJZ5LgBub+ch+
 6bYnNeEIXY/cZSgp9zOj/8tuRydy7URf7nwCevi8yz52ekKCiJiKT3/Rl0jHpn+BUN8vSIb3HAG
 KfdArSOg+Oq7Dle7pjhy4acgv2r+E0PZHC2qw956HQ1+Cy5xAyZYrxa3kvTUj9YZMbbLF31DBGU
 O/SF6WkIYzUPO+UuxBcyC3utGIPgfGoWBqREOD+mshMJ6e9MLztL0SsDoFx+U3WbJfex+vS/MZO
 gEedGWFTfNiBX52CUtoH3Sc1ztC17m/OIy8HEHcgvxXm8GJxhmy49rtFRddQPH6hoM/sbSBNidn
 3Rd78xg8MXocwvm7pPdAl0YGqG/Fw7b+18eJdBaEkF6CSb62M6jAxwAsaAvAV4J9HloZsBS86b7
 N6B789PDbGuTn50ZSawYNwt+3fm9lMI89TexTrSWzhVhYmYNVrw2yrCsFrhJW7Eakd0Q9Ywl84Y
 Fb5L/zFezxXUCDguhk9/mCiiWgFDd03o6itOLfCqFDX1HFrupRwjYHG7K57CU0Nus9jOEk0Yl7m
 TcmbYJvg5Pyqjow==
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

The flow control only activates when devices have matching TX/RX queue
counts to ensure proper queue mapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/bus.c    | 16 +++++++++++
 drivers/net/netdevsim/netdev.c | 62 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf85..44f3e2f673c16 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -323,6 +323,19 @@ static ssize_t link_device_store(const struct bus_type *bus, const char *buf, si
 }
 static BUS_ATTR_WO(link_device);
 
+static void nsim_wake_queue(struct net_device *net, struct netdev_queue *txq, void *unused)
+{
+	if (!(netif_tx_queue_stopped(txq)))
+		return;
+	netif_tx_wake_queue(txq);
+}
+
+static void nsim_wake_all_queues(struct net_device *dev, struct net_device *peer_dev)
+{
+	netdev_for_each_tx_queue(peer_dev, nsim_wake_queue, NULL);
+	netdev_for_each_tx_queue(dev, nsim_wake_queue, NULL);
+}
+
 static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
 {
 	struct netdevsim *nsim, *peer;
@@ -367,6 +380,9 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
 	RCU_INIT_POINTER(nsim->peer, NULL);
 	RCU_INIT_POINTER(peer->peer, NULL);
 
+	synchronize_net();
+	nsim_wake_all_queues(dev, peer->netdev);
+
 out_put_netns:
 	put_net(ns);
 	rtnl_unlock();
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2dc..43f31bc134b0a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -37,9 +37,64 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
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
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		return;
+
+	/* TX device */
+	peer_dev = peer_ns->netdev;
+
+	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
+		return;
+
+	txq = netdev_get_tx_queue(peer_dev, idx);
+	if (!(netif_tx_queue_stopped(txq)))
+		return;
+
+	netif_tx_wake_queue(txq);
+}
+
+static void nsim_stop_peer_tx_queue(struct net_device *dev, struct nsim_rq *rq,
+				    u16 idx)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	struct net_device *peer_dev;
+	struct netdevsim *peer_ns;
+
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		return;
+
+	/* TX device */
+	peer_dev = peer_ns->netdev;
+
+	/* If different queues size, do not stop, since it is not
+	 * easy to find which TX queue is mapped here
+	 */
+	if (dev->real_num_tx_queues != peer_dev->num_rx_queues)
+		return;
+
+	netif_subqueue_try_stop(peer_dev, idx,
+				NSIM_RING_SIZE - skb_queue_len(&rq->skb_queue),
+				NSIM_RING_SIZE / 2);
+}
+
+static int nsim_napi_rx(struct net_device *dev, struct nsim_rq *rq,
+			struct sk_buff *skb)
 {
 	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
+		rcu_read_lock();
+		nsim_stop_peer_tx_queue(dev, rq, skb_get_queue_mapping(skb));
+		rcu_read_unlock();
 		dev_kfree_skb_any(skb);
 		return NET_RX_DROP;
 	}
@@ -51,7 +106,7 @@ static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
 static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
 			    struct nsim_rq *rq)
 {
-	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(rq, skb);
+	return __dev_forward_skb(dev, skb) ?: nsim_napi_rx(dev, rq, skb);
 }
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -351,6 +406,9 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			dev_dstats_rx_dropped(dev);
 	}
 
+	rcu_read_lock();
+	nsim_start_peer_tx_queue(dev, rq);
+	rcu_read_unlock();
 	return i;
 }
 

---
base-commit: f6e98f17ad6829c48573952ede3f52ed00c1377f
change-id: 20250630-netdev_flow_control-2b2d37965377

Best regards,
--  
Breno Leitao <leitao@debian.org>


