Return-Path: <netdev+bounces-171442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE65DA4D00C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221BF18980F2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB51714D0;
	Tue,  4 Mar 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NXqPvD4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092B149C7B
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048480; cv=none; b=niiYIAVqnZS2PSQ+KBAVBTyLM0Hr7ebVvCNEToWdNZOeAos4+ZEGfp4BpmB5Rh75MlHl9qjUJSOqd78e8hvi2hi4Rgu9wccZ4eYVKw2r9zV9ngXVUOxbdJwafnwF9NxDiDgYHn1v4yzRBUyYdTfXqicoJkrfRu5JRXWwDoM8XHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048480; c=relaxed/simple;
	bh=Gdx+ga7Kg9utryLtMIwUq5B8ze3Vn6uLAsU89hzDsGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjMWghWIydiYE/SLn8Q1gs/qYvTQGF0DAJ3GBPoZvp1zR3oE2v2RjPH4qXpqTaiW9Pd8ICung8quTByKE2bkfzq/DAfepCSbzcnvTGqhLXzZsqSon+xlC3kSWaBN6rUEuAuL+BKQB5Pg28GlmoMcXUYBEjR1oBGqZ8TmW/dBPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NXqPvD4j; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390eb7c1024so2853572f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048476; x=1741653276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8Dq0CU9BwsF+U6ZdLEg+O6FLopDZdSX3C0bz4GxARk=;
        b=NXqPvD4jkXynxEL3oZ58R+1GxDZylOMP+3wR+466f1DkEoOtGiUivcA1xFnzUWGawj
         Z1INlDcxvfXGJfBnH9sjAtTs/tm+cVavm2lbPo+S8Mh3Np9oVBldRouOyBqNlugHNKyg
         qSi3OaylOWxozgmXWCMTgA8lYXt5fiF/UP1jj191+u7TmHzPRF3z21vxYm0ecAz8KR0H
         EhU11vurE6Y9ftUmXJOm5EgAgmFeNrty+E6v6PZgjJpnuq7AG3fX19VLFXX6Ye/vf2A2
         /i9pTBRzI4PmYZEDPmQstqs1B1loPDeDtEQQCcZvinN8y++eRYr3I4ONQidIbEU/zZIx
         IarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048476; x=1741653276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8Dq0CU9BwsF+U6ZdLEg+O6FLopDZdSX3C0bz4GxARk=;
        b=U4g3dn5hrVeVcx6sJRRvQPs632GMGwFKyo/o7/zrDajuRwmZClcLIWB7PveKRuWvEV
         jYUpoBCpumIFPOiRRGoWxWQufy1W7SBNAhAJ4sPcWLQSYrpsS7MaWECugBKWvVUkBmPY
         9RpFdROd70nOzCrDhCKVykdW+HhP8aEy1V/vdrG6J7jK5b3ok86oxuIg7NEfFbI5aSoT
         hKlxtolEIEnFXm5N1mxe0qnrtTAjVl0ge0V7wiQ3jpuKbkoWNDi0SXC42l59v3HAhXLN
         K+3BAPLKb+0GYTVq9q/8lsVgZEcVpKzjFRpry73rB9EImqrw+71OVc2kSOysiIaWs3lq
         hNHg==
X-Gm-Message-State: AOJu0YxEeztVB8E48PbQ3smrz+GOZo8RCaa3W92yYkvOEk1N16pKLXev
	sVn8coJF+aCgdOIEy7p4XfUKscGqJTaNfsVkKH1wWESZfMMaJKa4zV66DNLOCNY=
X-Gm-Gg: ASbGnct7ZqvAWN/pg32MTKEBL7E9x5smEkm6AO2GAPMdoC3hwAza6nhP6xfg+7Brn/n
	CWpFl/g5OFr6shM1HZH3mP2Sx/mOkIWWHCqQZlRt46h0c9mZ7loMUQRxXJqFLVGy8ruG6E+6y9M
	S7uClRquUBJPdzsluwzM98uMrLkq8RiRchx1vRbo6IZNpZrmJpOdslTKNGiPYodoR+c2UUkrcVd
	2DYV14aWpc2NFP8Mhh34Yzkb2+19NI7OMCdXGveM1lt0thYm/xZeer4XZFN9vBbqLkHJzLWPWMH
	9c5I6e6gFCtGHeTuKLbQhAIs+fUszR1FArH79jYD4Q==
X-Google-Smtp-Source: AGHT+IEGCMUHfDu6+u4QeoIhOciphi4zBSatpjkg70RijDOVZ2XDqT8/meBeTDhTHAsA23x+rI43iQ==
X-Received: by 2002:a05:6000:1868:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-390eca34b15mr12158935f8f.42.1741048476082;
        Mon, 03 Mar 2025 16:34:36 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:35 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:37 +0100
Subject: [PATCH v21 07/24] ovpn: implement basic TX path (UDP)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-7-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17322; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Gdx+ga7Kg9utryLtMIwUq5B8ze3Vn6uLAsU89hzDsGE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqPbgfKzI/7PPL7ZeupTKlYgcchftNdCEnnd
 aAmlyf4CVOJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 h8GFB/4m1wwyVOI1ZZmW2VQko9VKbVPcZtglVM+jVZnvexj239IJZh5HqCk7+6WkgNb+oPhP4p2
 y0wbW3pbzDF3jfJY1zJ/tzdKFdqmNfrPN8INsqeQfERagQm8Nr/v+hGwGPbICQC66swr3xZRcGQ
 /+ItI/cbv1TbaIWaW+RbjzwMI1XWoN6p60oY5JBHpoqfbxphLcZhPkgBGJjfRvWKffzkQpiOgSD
 32N+dcUPUDTMGxw7fwUWfZz1m4ZiyKe3YFa8HGhpXKV6+oN3T+0w/FfRaa0ZdJSyEVfnTIGiCv/
 tDDusQDHEauO1U6jotYDq2t7Ih+ds3nx/+vQoypUWocKM8gn
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Packets sent over the ovpn interface are processed and transmitted to the
connected peer, if any.

Implementation is UDP only. TCP will be added by a later patch.

Note: no crypto/encapsulation exists yet. Packets are just captured and
sent.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/Kconfig       |   1 +
 drivers/net/ovpn/io.c     | 137 ++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c   |  32 +++++++
 drivers/net/ovpn/peer.h   |   2 +
 drivers/net/ovpn/skb.h    |  55 +++++++++++
 drivers/net/ovpn/socket.c |   3 +-
 drivers/net/ovpn/udp.c    | 236 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/udp.h    |   6 ++
 8 files changed, 468 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index dfd1ad96230317c4118b63c9c98d0a631f6cbb21..b18ff941944e2e92aa769d1ebbc3d1782611fc06 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -120,6 +120,7 @@ config OVPN
 	depends on NET && INET
 	depends on IPV6 || !IPV6
 	select DST_CACHE
+	select NET_UDP_TUNNEL
 	help
 	  This module enhances the performance of the OpenVPN userspace software
 	  by offloading the data channel processing to kernelspace.
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 4b71c38165d7adbb1a2d1a64d27a13b7f76cfbfe..94b466bf2ef70d60d3e60d9820b64877c44f2e51 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -9,14 +9,149 @@
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 #include "io.h"
+#include "ovpnpriv.h"
+#include "peer.h"
+#include "udp.h"
+#include "skb.h"
+#include "socket.h"
+
+static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
+{
+	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
+	struct ovpn_socket *sock;
+
+	if (unlikely(ret < 0))
+		goto err;
+
+	skb_mark_not_on_list(skb);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (unlikely(!sock))
+		goto err_unlock;
+
+	switch (sock->sock->sk->sk_protocol) {
+	case IPPROTO_UDP:
+		ovpn_udp_send_skb(peer, sock->sock, skb);
+		break;
+	default:
+		/* no transport configured yet */
+		goto err_unlock;
+	}
+	/* skb passed down the stack - don't free it */
+	skb = NULL;
+err_unlock:
+	rcu_read_unlock();
+err:
+	if (unlikely(skb))
+		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
+	ovpn_peer_put(peer);
+	kfree_skb(skb);
+}
+
+static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	ovpn_skb_cb(skb)->peer = peer;
+
+	/* take a reference to the peer because the crypto code may run async.
+	 * ovpn_encrypt_post() will release it upon completion
+	 */
+	if (unlikely(!ovpn_peer_hold(peer))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return false;
+	}
+
+	ovpn_encrypt_post(skb, 0);
+	return true;
+}
+
+/* send skb to connected peer, if any */
+static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
+		      struct ovpn_peer *peer)
+{
+	struct sk_buff *curr, *next;
+
+	/* this might be a GSO-segmented skb list: process each skb
+	 * independently
+	 */
+	skb_list_walk_safe(skb, curr, next) {
+		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			kfree_skb(curr);
+		}
+	}
+
+	ovpn_peer_put(peer);
+}
 
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct sk_buff *segments, *curr, *next;
+	struct sk_buff_head skb_list;
+	struct ovpn_peer *peer;
+	__be16 proto;
+	int ret;
+
+	/* reset netfilter state */
+	nf_reset_ct(skb);
+
+	/* verify IP header size in network packet */
+	proto = ovpn_ip_check_protocol(skb);
+	if (unlikely(!proto || skb->protocol != proto))
+		goto drop;
+
+	if (skb_is_gso(skb)) {
+		segments = skb_gso_segment(skb, 0);
+		if (IS_ERR(segments)) {
+			ret = PTR_ERR(segments);
+			net_err_ratelimited("%s: cannot segment payload packet: %d\n",
+					    netdev_name(dev), ret);
+			goto drop;
+		}
+
+		consume_skb(skb);
+		skb = segments;
+	}
+
+	/* from this moment on, "skb" might be a list */
+
+	__skb_queue_head_init(&skb_list);
+	skb_list_walk_safe(skb, curr, next) {
+		skb_mark_not_on_list(curr);
+
+		curr = skb_share_check(curr, GFP_ATOMIC);
+		if (unlikely(!curr)) {
+			net_err_ratelimited("%s: skb_share_check failed for payload packet\n",
+					    netdev_name(dev));
+			dev_core_stats_tx_dropped_inc(ovpn->dev);
+			continue;
+		}
+
+		__skb_queue_tail(&skb_list, curr);
+	}
+	skb_list.prev->next = NULL;
+
+	/* retrieve peer serving the destination IP of this packet */
+	peer = ovpn_peer_get_by_dst(ovpn, skb);
+	if (unlikely(!peer)) {
+		net_dbg_ratelimited("%s: no peer to send data to\n",
+				    netdev_name(ovpn->dev));
+		goto drop;
+	}
+
+	ovpn_send(ovpn, skb_list.next, peer);
+
+	return NETDEV_TX_OK;
+
+drop:
+	dev_core_stats_tx_dropped_inc(ovpn->dev);
 	skb_tx_error(skb);
-	kfree_skb(skb);
+	kfree_skb_list(skb);
 	return NET_XMIT_DROP;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 0bb6c15171848acbc055829a3d2aefd26c5b810a..10eabd62ae7237162a36a333b41c748901a7d888 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -294,6 +294,38 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	llist_add(&peer->release_entry, release_list);
 }
 
+/**
+ * ovpn_peer_get_by_dst - Lookup peer to send skb to
+ * @ovpn: the private data representing the current VPN session
+ * @skb: the skb to extract the destination address from
+ *
+ * This function takes a tunnel packet and looks up the peer to send it to
+ * after encapsulation. The skb is expected to be the in-tunnel packet, without
+ * any OpenVPN related header.
+ *
+ * Assume that the IP header is accessible in the skb data.
+ *
+ * Return: the peer if found or NULL otherwise.
+ */
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
+				       struct sk_buff *skb)
+{
+	struct ovpn_peer *peer = NULL;
+
+	/* in P2P mode, no matter the destination, packets are always sent to
+	 * the single peer listening on the other side
+	 */
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		rcu_read_lock();
+		peer = rcu_dereference(ovpn->peer);
+		if (unlikely(peer && !ovpn_peer_hold(peer)))
+			peer = NULL;
+		rcu_read_unlock();
+	}
+
+	return peer;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 29c9065cedccb156ec6ca6d9b692372e8fc89a2d..fef04311c1593db4ccfa3c417487b3d4faaae9d7 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -80,5 +80,7 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
+struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
+				       struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
new file mode 100644
index 0000000000000000000000000000000000000000..9db7a9adebdb4cc493f162f89fb2e9c6301fa213
--- /dev/null
+++ b/drivers/net/ovpn/skb.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_SKB_H_
+#define _NET_OVPN_SKB_H_
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+struct ovpn_cb {
+	struct ovpn_peer *peer;
+};
+
+static inline struct ovpn_cb *ovpn_skb_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct ovpn_cb) > sizeof(skb->cb));
+	return (struct ovpn_cb *)skb->cb;
+}
+
+/* Return IP protocol version from skb header.
+ * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
+ */
+static inline __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
+{
+	__be16 proto = 0;
+
+	/* skb could be non-linear,
+	 * make sure IP header is in non-fragmented part
+	 */
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		return 0;
+
+	if (ip_hdr(skb)->version == 4) {
+		proto = htons(ETH_P_IP);
+	} else if (ip_hdr(skb)->version == 6) {
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			return 0;
+		proto = htons(ETH_P_IPV6);
+	}
+
+	return proto;
+}
+
+#endif /* _NET_OVPN_SKB_H_ */
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index 0a1ba3f75aa7438502dec4c86dcef8637d5ebffa..a4a8686f2e2995dca163d5b96c6c897b86434967 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -190,9 +190,8 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 		goto sock_release;
 	}
 
-	ovpn_sock->ovpn = peer->ovpn;
-	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
+	ovpn_sock->sock = sock;
 
 	ret = ovpn_socket_attach(ovpn_sock, peer);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 91970e66a4340370a96c1fc42321f94574302143..ae76ae6d372f565715a39ee24e3fba14f1c1370e 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -7,15 +7,249 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/udp.h>
+#include <net/addrconf.h>
+#include <net/dst_cache.h>
+#include <net/route.h>
+#include <net/ipv6_stubs.h>
 #include <net/udp.h>
+#include <net/udp_tunnel.h>
 
 #include "ovpnpriv.h"
 #include "main.h"
+#include "bind.h"
+#include "io.h"
+#include "peer.h"
 #include "socket.h"
 #include "udp.h"
 
+/**
+ * ovpn_udp4_output - send IPv4 packet over udp socket
+ * @peer: the destination peer
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.saddr = bind->local.ipv4.s_addr,
+		.daddr = bind->remote.in4.sin_addr.s_addr,
+		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_dport = bind->remote.in4.sin_port,
+		.flowi4_proto = sk->sk_protocol,
+		.flowi4_mark = sk->sk_mark,
+	};
+	int ret;
+
+	local_bh_disable();
+	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	if (rt)
+		goto transmit;
+
+	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
+					RT_SCOPE_HOST))) {
+		/* we may end up here when the cached address is not usable
+		 * anymore. In this case we reset address/cache and perform a
+		 * new look up
+		 */
+		fl.saddr = 0;
+		spin_lock_bh(&peer->lock);
+		bind->local.ipv4.s_addr = 0;
+		spin_unlock_bh(&peer->lock);
+		dst_cache_reset(cache);
+	}
+
+	rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
+		fl.saddr = 0;
+		spin_lock_bh(&peer->lock);
+		bind->local.ipv4.s_addr = 0;
+		spin_unlock_bh(&peer->lock);
+		dst_cache_reset(cache);
+
+		rt = ip_route_output_flow(sock_net(sk), &fl, sk);
+	}
+
+	if (IS_ERR(rt)) {
+		ret = PTR_ERR(rt);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    netdev_name(peer->ovpn->dev),
+				    &bind->remote.in4,
+				    ret);
+		goto err;
+	}
+	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+
+transmit:
+	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
+			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+			    fl.fl4_dport, false, sk->sk_no_check_tx);
+	ret = 0;
+err:
+	local_bh_enable();
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+/**
+ * ovpn_udp6_output - send IPv6 packet over udp socket
+ * @peer: the destination peer
+ * @bind: the binding related to the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
+			    struct dst_cache *cache, struct sock *sk,
+			    struct sk_buff *skb)
+{
+	struct dst_entry *dst;
+	int ret;
+
+	struct flowi6 fl = {
+		.saddr = bind->local.ipv6,
+		.daddr = bind->remote.in6.sin6_addr,
+		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_dport = bind->remote.in6.sin6_port,
+		.flowi6_proto = sk->sk_protocol,
+		.flowi6_mark = sk->sk_mark,
+		.flowi6_oif = bind->remote.in6.sin6_scope_id,
+	};
+
+	local_bh_disable();
+	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	if (dst)
+		goto transmit;
+
+	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+		/* we may end up here when the cached address is not usable
+		 * anymore. In this case we reset address/cache and perform a
+		 * new look up
+		 */
+		fl.saddr = in6addr_any;
+		spin_lock_bh(&peer->lock);
+		bind->local.ipv6 = in6addr_any;
+		spin_unlock_bh(&peer->lock);
+		dst_cache_reset(cache);
+	}
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	if (IS_ERR(dst)) {
+		ret = PTR_ERR(dst);
+		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
+				    netdev_name(peer->ovpn->dev),
+				    &bind->remote.in6, ret);
+		goto err;
+	}
+	dst_cache_set_ip6(cache, dst, &fl.saddr);
+
+transmit:
+	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
+			     fl.fl6_dport, udp_get_no_check6_tx(sk));
+	ret = 0;
+err:
+	local_bh_enable();
+	return ret;
+}
+#endif
+
+/**
+ * ovpn_udp_output - transmit skb using udp-tunnel
+ * @peer: the destination peer
+ * @cache: dst cache
+ * @sk: the socket to send the packet over
+ * @skb: the packet to send
+ *
+ * rcu_read_lock should be held on entry.
+ * On return, the skb is consumed.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
+			   struct sock *sk, struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+	int ret;
+
+	/* set sk to null if skb is already orphaned */
+	if (!skb->destructor)
+		skb->sk = NULL;
+
+	/* always permit openvpn-created packets to be (outside) fragmented */
+	skb->ignore_df = 1;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind)) {
+		net_warn_ratelimited("%s: no bind for remote peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	switch (bind->remote.in4.sin_family) {
+	case AF_INET:
+		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
+		break;
+#endif
+	default:
+		ret = -EAFNOSUPPORT;
+		break;
+	}
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * ovpn_udp_send_skb - prepare skb and send it over via UDP
+ * @peer: the destination peer
+ * @sock: the RCU protected peer socket
+ * @skb: the packet to send
+ */
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+		       struct sk_buff *skb)
+{
+	int ret = -1;
+
+	skb->dev = peer->ovpn->dev;
+	/* no checksum performed at this layer */
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* get socket info */
+	if (unlikely(!sock)) {
+		net_warn_ratelimited("%s: no sock for remote peer %u\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		goto out;
+	}
+
+	/* crypto layer -> transport (UDP) */
+	ret = ovpn_udp_output(peer, &peer->dst_cache, sock->sk, skb);
+out:
+	if (unlikely(ret < 0)) {
+		kfree_skb(skb);
+		return;
+	}
+}
+
 /**
  * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
  * @ovpn_sock: socket to configure
@@ -31,7 +265,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 {
 	struct socket *sock = ovpn_sock->sock;
 	struct ovpn_socket *old_data;
-	int ret = 0;
+	int ret;
 
 	/* make sure no pre-existing encapsulation handler exists */
 	rcu_read_lock();
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index 1c8fb6fe402dc1cfdc10fddc9cf5b74d7d6887ce..9994eb6e04283247d8ffc729966345810f84b22b 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -9,6 +9,9 @@
 #ifndef _NET_OVPN_UDP_H_
 #define _NET_OVPN_UDP_H_
 
+#include <net/sock.h>
+
+struct ovpn_peer;
 struct ovpn_priv;
 struct socket;
 
@@ -16,4 +19,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
 
+void ovpn_udp_send_skb(struct ovpn_peer *peer, struct socket *sock,
+		       struct sk_buff *skb);
+
 #endif /* _NET_OVPN_UDP_H_ */

-- 
2.45.3


