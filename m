Return-Path: <netdev+bounces-226077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE667B9BC32
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E803A26CD
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92C26F29B;
	Wed, 24 Sep 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IESpIZT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32B243371
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743404; cv=none; b=bqRv1vGrKguHRTzWpYT++vXhXOTXvUHcRqpEdPW1PB/FqNu4c+9eVL8tTkoIy9m6WAlJlR7CLvigp3TIwo+tN/VX95V+O66WwzQUxQ5B3KJBQZgG1FexjDRUThnI/TkW32vmSC3QQO+lk6ENVZP+YpC92//ukAyBu5HOKRbXJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743404; c=relaxed/simple;
	bh=bgOFKhOa2FWYo562Qe96VqyIrFClhhfZ+uGmNKSUHtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gISwVAluVFixfIVU5pK8wmb9HVo+ZyAqA/JardQ0K9bsWoOk0gLP25Gxcp724g9IZFiA58/IsPzUdIBEYqj9moNY0Ox4o93nbqN8bipqZ7Vn8TrOymLY3K48NUtjBcpouPeyecOcJi0ZICK0IIVKAdtO2R2qgJYRA6SDoCjyi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IESpIZT1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72e565bf2feso2428327b3.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743402; x=1759348202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grTggvOxp2rPfpntWnbXc2BztQnD+0xNRsitXPVYx34=;
        b=IESpIZT1GUnTZPtjAo2Hny/vy13WmOjJkTcJl+pUwnKehE8FUBU9IcZC+tIDfCuWtD
         OD6A24rzLxmpwQqC009oscliQ0uCNedLg5mCPoomJ2ULre2dz8izLmpVyW5BLeTHqBfR
         E8EkqpDpdWUqquNFz+yQhYGmkELwAzkRF21J9G07OVmXGHMYNGOrFaYPHsZz3hvETW83
         clv29icNYswYG7wyFISYzSSEuRH1OhVYLiQGC3VhwLCo5UQ9b9OlgRyO/82LtxLA7ZHm
         evY1PuCmOwVgLqVPZZcW4P1LDvhi88cVRZ59HDT1nPm6wvZxS4/RimzykcqEmPWZ39QA
         R4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743402; x=1759348202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grTggvOxp2rPfpntWnbXc2BztQnD+0xNRsitXPVYx34=;
        b=EHaIMhPOlPgYemEqmL244hNBVOdkcQVpC3s0XLcLS2DtvTThHVNIUvMQcGr3MOQ+aa
         e0KchmyW45SqK45cW3lq0c56ja3c/XwaXXu5U4wwgW3uvmxDfYBGOt/9DpMKcvV2eG2P
         EvZWhgFL6DeSZVLOQ5yTzIPh/qT+MYHi0K51znPWlYl+JiZGagYdjMDJ68+4MWKGBS+/
         6bVUxq2a396Ty4z4vtPvReo/OYSLqVUZpnBU/OuTY0zjRqJZ8txWcngeSeIXvmQAVm4P
         HXDSvZd3utFyjz2o2Qz7moHF0J1y1esAsrjZeEHBAfOcQ+ISUezdCSeBJjeNzstEqa/9
         bBgw==
X-Forwarded-Encrypted: i=1; AJvYcCWcRM8UCDydQ9+gUuhSXa/XBh+OBhj7Cvk/WQ6fgkUqq4BtgnPkyEsbBqx7GjyrTeT+srleJmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWhwGz/U1kvkbtXRTZheEvWcVS437oc9ZegiC9G1PC01+R6KV
	r3SQrufCCiKC/UWS7D+vmrAV11pW7N1KqbK5Q0sNjVCc3S5cbOns1SSCiGRE0g==
X-Gm-Gg: ASbGncvifMYC/qmVXmKS3LrgqIgoun6Hum+ej7CwwACILx5JLroBDxLWlCvSqJYY39m
	0nN7cs4EwCk0dhmbdoBPdmewPeGoDspjkmxQQyNu1nd4bWjGDZA2DqjL83OqDdisI8HVx4WQYej
	FjBZkVEEWn4EQaVRg5KAfBTAHndEbZsmtOsYefNMJU71tSEIvZOPEdKrUN8i6QINlmJu9JdWT+w
	L8phOR5/FvrQnsCWeJ/ioJh15QkXYxwFxygK1I/A/7JQ5JbXZ6FRY3fsv8XtQXm/qwIj0HDBo3s
	+IkqTZTe03qUIKanFCNOGI8giI55TyFwSeUqaGNWfHjh7ydXMalLCR6ZApRh6Bl21fI/owO/Ljy
	4mlGaLNraJn+IzllzIwPt
X-Google-Smtp-Source: AGHT+IEEFEjvFj+exp+5TeKS/sMkiZVxTiN6+2Eany/eeQYnEHViGYcb8OID1bFoj5JQfs1lWOrwaw==
X-Received: by 2002:a05:690c:350e:b0:732:41ef:4025 with SMTP id 00721157ae682-764026bb147mr12587407b3.41.1758743401587;
        Wed, 24 Sep 2025 12:50:01 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd08b24sm6353337d50.8.2025.09.24.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:00 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/9] netdevsim: a basic test PSP implementation
Date: Wed, 24 Sep 2025 12:49:47 -0700
Message-ID: <20250924194959.2845473-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924194959.2845473-1-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Provide a PSP implementation for netdevsim.

Use psp_dev_encapsulate() and psp_dev_rcv() to do actual encapsulation
and decapsulation on skbs, but perform no encryption or decryption. In
order to make encryption with a bad key result in a drop on the peer's
rx side, we stash our psd's generation number in the first byte of each
key before handing to the peer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/Makefile    |   4 +
 drivers/net/netdevsim/netdev.c    |  56 ++++++--
 drivers/net/netdevsim/netdevsim.h |  38 ++++++
 drivers/net/netdevsim/psp.c       | 218 ++++++++++++++++++++++++++++++
 net/core/skbuff.c                 |   1 +
 5 files changed, 309 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/netdevsim/psp.c

diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
index f8de93bc5f5b..14a553e000ec 100644
--- a/drivers/net/netdevsim/Makefile
+++ b/drivers/net/netdevsim/Makefile
@@ -18,6 +18,10 @@ ifneq ($(CONFIG_PSAMPLE),)
 netdevsim-objs += psample.o
 endif
 
+ifneq ($(CONFIG_INET_PSP),)
+netdevsim-objs += psp.o
+endif
+
 ifneq ($(CONFIG_MACSEC),)
 netdevsim-objs += macsec.o
 endif
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0178219f0db5..1905c95967e0 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -103,29 +103,46 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
 static int nsim_forward_skb(struct net_device *tx_dev,
 			    struct net_device *rx_dev,
 			    struct sk_buff *skb,
-			    struct nsim_rq *rq)
+			    struct nsim_rq *rq,
+			    struct skb_ext *psp_ext)
 {
-	return __dev_forward_skb(rx_dev, skb) ?:
-		nsim_napi_rx(tx_dev, rx_dev, rq, skb);
+	int ret;
+
+	ret = __dev_forward_skb(rx_dev, skb);
+	if (ret)
+		return ret;
+
+	if (psp_ext)
+		__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
+
+	return nsim_napi_rx(tx_dev, rx_dev, rq, skb);
 }
 
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct skb_ext *psp_ext = NULL;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
 	struct netdev_config *cfg;
 	struct nsim_rq *rq;
 	int rxq;
+	int dr;
 
 	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
-		goto out_drop_free;
+		goto out_drop_any;
 
 	peer_ns = rcu_dereference(ns->peer);
 	if (!peer_ns)
-		goto out_drop_free;
+		goto out_drop_any;
+
+	if (nsim_tx_skb_is_psp(skb)) {
+		dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext);
+		if (dr)
+			goto out_drop_free;
+	}
 
 	peer_dev = peer_ns->netdev;
 	rxq = skb_get_queue_mapping(skb);
@@ -141,7 +158,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb_linearize(skb);
 
 	skb_tx_timestamp(skb);
-	if (unlikely(nsim_forward_skb(dev, peer_dev, skb, rq) == NET_RX_DROP))
+	if (unlikely(nsim_forward_skb(dev, peer_dev, skb, rq, psp_ext) ==
+		     NET_RX_DROP))
 		goto out_drop_cnt;
 
 	if (!hrtimer_active(&rq->napi_timer))
@@ -151,8 +169,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_dstats_tx_add(dev, len);
 	return NETDEV_TX_OK;
 
+out_drop_any:
+	dr = SKB_DROP_REASON_NOT_SPECIFIED;
 out_drop_free:
-	dev_kfree_skb(skb);
+	kfree_skb_reason(skb, dr);
 out_drop_cnt:
 	rcu_read_unlock();
 	dev_dstats_tx_dropped(dev);
@@ -1002,6 +1022,7 @@ static void nsim_queue_uninit(struct netdevsim *ns)
 
 static int nsim_init_netdevsim(struct netdevsim *ns)
 {
+	struct netdevsim *peer;
 	struct mock_phc *phc;
 	int err;
 
@@ -1039,12 +1060,29 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
 		ns->nb.notifier_call = netdev_debug_event;
 		if (register_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
-							&ns->nn))
+							&ns->nn)){
 			ns->nb.notifier_call = NULL;
+			goto err_unregister_netdev;
+		}
 	}
 
+	err = nsim_psp_init(ns);
+	if (err)
+		goto err_unregister_notifier;
+
 	return 0;
 
+err_unregister_notifier:
+	if (ns->nb.notifier_call)
+		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
+						      &ns->nn);
+err_unregister_netdev:
+	rtnl_lock();
+	peer = rtnl_dereference(ns->peer);
+	if (peer)
+		RCU_INIT_POINTER(peer->peer, NULL);
+	RCU_INIT_POINTER(ns->peer, NULL);
+	unregister_netdevice(ns->netdev);
 err_ipsec_teardown:
 	nsim_ipsec_teardown(ns);
 	nsim_macsec_teardown(ns);
@@ -1128,6 +1166,8 @@ void nsim_destroy(struct netdevsim *ns)
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
+	nsim_psp_uninit(ns);
+
 	if (ns->nb.notifier_call)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
 						      &ns->nn);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bddd24c1389d..60aafcf67f65 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -23,6 +23,7 @@
 #include <linux/ptp_mock.h>
 #include <linux/u64_stats_sync.h>
 #include <net/devlink.h>
+#include <net/psp.h>
 #include <net/udp_tunnel.h>
 #include <net/xdp.h>
 #include <net/macsec.h>
@@ -108,6 +109,12 @@ struct netdevsim {
 
 	int rq_reset_mode;
 
+	struct {
+		struct psp_dev *dev;
+		u32 spi;
+		u32 assoc_cnt;
+	} psp;
+
 	struct nsim_bus_dev *nsim_bus_dev;
 
 	struct bpf_prog	*bpf_offloaded;
@@ -421,6 +428,37 @@ static inline void nsim_macsec_teardown(struct netdevsim *ns)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_INET_PSP)
+int nsim_psp_init(struct netdevsim *ns);
+void nsim_psp_uninit(struct netdevsim *ns);
+enum skb_drop_reason
+nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext);
+static inline bool nsim_tx_skb_is_psp(struct sk_buff *skb)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = !!psp_skb_get_assoc_rcu(skb);
+	rcu_read_unlock();
+	return ret;
+}
+#else
+static inline int nsim_psp_init(struct netdevsim *ns) { return 0; }
+static inline void nsim_psp_uninit(struct netdevsim *ns) {}
+static inline enum skb_drop_reason
+nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+{
+	return 0;
+}
+
+static inline bool nsim_tx_skb_is_psp(struct sk_buff *skb)
+{
+	return false;
+}
+#endif
+
 struct nsim_bus_dev {
 	struct device dev;
 	struct list_head list;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
new file mode 100644
index 000000000000..cb568f89eb3e
--- /dev/null
+++ b/drivers/net/netdevsim/psp.c
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/ip.h>
+#include <linux/skbuff.h>
+#include <net/ip6_checksum.h>
+#include <net/psp.h>
+#include <net/sock.h>
+
+#include "netdevsim.h"
+
+enum skb_drop_reason
+nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+{
+	struct net *net = sock_net(skb->sk);
+	enum skb_drop_reason rc = 0;
+	struct psp_assoc *pas;
+	void **ptr;
+
+	rcu_read_lock();
+	pas = psp_skb_get_assoc_rcu(skb);
+	if (!pas) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	if (!skb_transport_header_was_set(skb)) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	ptr = psp_assoc_drv_data(pas);
+	if (*ptr != ns) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0)) {
+		rc = SKB_DROP_REASON_PSP_OUTPUT;
+		goto out_unlock;
+	}
+
+	/* Now pretend we just received this frame */
+	if (peer_ns->psp.dev->config.versions & (1 << pas->version)) {
+		bool strip_icv = false;
+		u8 generation;
+
+		/* We cheat a bit and put the generation in the key.
+		 * In real life if generation was too old, then decryption would
+		 * fail. Here, we just make it so a bad key causes a bad
+		 * generation too, and psp_sk_rx_policy_check() will fail.
+		 */
+		generation = pas->tx.key[0];
+
+		skb_ext_reset(skb);
+		skb->mac_len = ETH_HLEN;
+		if (psp_dev_rcv(skb, peer_ns->psp.dev->id, generation,
+				strip_icv)) {
+			rc = SKB_DROP_REASON_PSP_OUTPUT;
+			goto out_unlock;
+		}
+
+		*psp_ext = skb->extensions;
+		refcount_inc(&(*psp_ext)->refcnt);
+		skb->decrypted = 1;
+	} else {
+		struct ipv6hdr *ip6h;
+		struct iphdr *iph;
+		struct udphdr *uh;
+		__wsum csum;
+
+		/* Do not decapsulate. Receive the skb with the udp and psp
+		 * headers still there as if this is a normal udp packet.
+		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
+		 * provide a valid checksum here, so the skb isn't dropped.
+		 */
+		uh = udp_hdr(skb);
+		csum = skb_checksum(skb, skb_transport_offset(skb),
+				    ntohs(uh->len), 0);
+
+		switch (skb->protocol) {
+		case htons(ETH_P_IP):
+			iph = ip_hdr(skb);
+			uh->check = udp_v4_check(ntohs(uh->len), iph->saddr,
+						 iph->daddr, csum);
+			break;
+#if IS_ENABLED(CONFIG_IPV6)
+		case htons(ETH_P_IPV6):
+			ip6h = ipv6_hdr(skb);
+			uh->check = udp_v6_check(ntohs(uh->len), &ip6h->saddr,
+						 &ip6h->daddr, csum);
+			break;
+#endif
+		}
+
+		uh->check	= uh->check ?: CSUM_MANGLED_0;
+		skb->ip_summed	= CHECKSUM_NONE;
+	}
+
+out_unlock:
+	rcu_read_unlock();
+	return rc;
+}
+
+static int
+nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
+		    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int
+nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
+		  struct psp_key_parsed *assoc,
+		  struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	unsigned int new;
+	int i;
+
+	new = ++ns->psp.spi & PSP_SPI_KEY_ID;
+	if (psd->generation & 1)
+		new |= PSP_SPI_KEY_PHASE;
+
+	assoc->spi = cpu_to_be32(new);
+	assoc->key[0] = psd->generation;
+	for (i = 1; i < PSP_MAX_KEY; i++)
+		assoc->key[i] = ns->psp.spi + i;
+
+	return 0;
+}
+
+static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
+			  struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	void **ptr = psp_assoc_drv_data(pas);
+
+	/* Copy drv_priv from psd to assoc */
+	*ptr = psd->drv_priv;
+	ns->psp.assoc_cnt++;
+
+	return 0;
+}
+
+static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	void **ptr = psp_assoc_drv_data(pas);
+
+	*ptr = NULL;
+	ns->psp.assoc_cnt--;
+}
+
+static struct psp_dev_ops nsim_psp_ops = {
+	.set_config	= nsim_psp_set_config,
+	.rx_spi_alloc	= nsim_rx_spi_alloc,
+	.tx_key_add	= nsim_assoc_add,
+	.tx_key_del	= nsim_assoc_del,
+	.key_rotate	= nsim_key_rotate,
+};
+
+static struct psp_dev_caps nsim_psp_caps = {
+	.versions = 1 << PSP_VERSION_HDR0_AES_GCM_128 |
+		    1 << PSP_VERSION_HDR0_AES_GMAC_128 |
+		    1 << PSP_VERSION_HDR0_AES_GCM_256 |
+		    1 << PSP_VERSION_HDR0_AES_GMAC_256,
+	.assoc_drv_spc = sizeof(void *),
+};
+
+void nsim_psp_uninit(struct netdevsim *ns)
+{
+	if (!IS_ERR(ns->psp.dev))
+		psp_dev_unregister(ns->psp.dev);
+	WARN_ON(ns->psp.assoc_cnt);
+}
+
+static ssize_t
+nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
+		     loff_t *ppos)
+{
+	struct netdevsim *ns = file->private_data;
+	int err;
+
+	nsim_psp_uninit(ns);
+
+	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
+				     &nsim_psp_caps, ns);
+	err = PTR_ERR_OR_ZERO(ns->psp.dev);
+	return err ?: count;
+}
+
+static const struct file_operations nsim_psp_rereg_fops = {
+	.open = simple_open,
+	.write = nsim_psp_rereg_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
+int nsim_psp_init(struct netdevsim *ns)
+{
+	struct dentry *ddir = ns->nsim_dev_port->ddir;
+	int err;
+
+	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
+				     &nsim_psp_caps, ns);
+	err = PTR_ERR_OR_ZERO(ns->psp.dev);
+	if (err)
+		return err;
+
+	debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_fops);
+	return 0;
+}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d331e607edfb..07a655056bda 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7048,6 +7048,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 	skb->active_extensions = 1 << id;
 	return skb_ext_get_ptr(ext, id);
 }
+EXPORT_SYMBOL_NS_GPL(__skb_ext_set, "NETDEV_INTERNAL");
 
 /**
  * skb_ext_add - allocate space for given extension, COW if needed
-- 
2.47.3


