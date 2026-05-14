Return-Path: <netdev+bounces-288108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KYUFcFXBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF83547B5E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5B14301A51B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A01F0E34;
	Thu, 14 May 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WonRFtuG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311137DADB
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800556; cv=none; b=UcoHQyfiUTKobUxuRFpSyEKUIwTsaeyK97adfOeJhYWEPyZ4iCZ0yAylkWwRlbKXiXGTA7OyBasF/3d65up5oboFhKgiyniWP3QTcP2neTvNNpOr6NP2yKEuXuJ6S7hR1M1Ba+1XPsC5xZ/9Cug6W9pCmo9khRp5qIk2EwunJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800556; c=relaxed/simple;
	bh=INHi0oQhCJljYg2qgCQRBCX6er0uGg6nv/0gY2fgYqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3um1bhSw2TsaN4vPOxi2KGj78sg+7RsA/qpyG89aVxx/wq9w5wRH0NUudcHivGNDPoX3zIGyODyZlPe1DnqXRBQSrq9CzUQKcEpVZrvTt0dy+ZfxyVcvhR+1PHLfE3S0vLuXhBALqfdT6v0YKg3H0R+egmqaiUoxnTgcJkTtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WonRFtuG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso76914445e9.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778800553; x=1779405353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtblgMv32vI1J57gtwkVkfrAXa6vWUwTnfvDWt7hRnc=;
        b=WonRFtuGQM6hVjUGg5GV3uKTZzXEDobQIY78KRnbnIo+aLTZs9hNjSDO6GQa8c+LCn
         s47qiGmxcQBKz/SWsc/wJzvNfeEbrSwhD3xzWdgp2G8RFbVCJ8g8xu7JOS9p+FEGGSG1
         IgFmB8/WkRxVkpgPPx4DAlGB5L1R8/hWRvyTVb6fSO/sQfwY9RSM4m9fqlez19/GmtVH
         Unn8ZiazUaQE3CnJVmxCnrWcwmqgI/CFuqNlavJE15cUOUJBySx41qozO0Yq+GPaeAXL
         Fm5iFhj4SDkOL+rcs2SCkzRg+dVI+N5Y+2h5Mx5/yyIjhUA3yC4q4Tkc8m9Vi8MsO2DO
         xKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800553; x=1779405353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mtblgMv32vI1J57gtwkVkfrAXa6vWUwTnfvDWt7hRnc=;
        b=VUsS+sMOJEpFLwjwvuOEG2U7iKuGz2f37pepI0WKGLYEz3fe02jQdRn9PavFrEneh6
         NTU5SPrWSd7g7/Ot0S3E5TExtcaFXbqTK+LoukEGljYDURxq0N2dupxk3LsjrRLB2uzH
         jetodQ+acUUTZ7d5iXcqEme28oOUBI6mJjuWTZze4A1QkOy0aq5hQkUEEXqO7bLk3it6
         yivV4To3Fq6sCM6SXWLlfbX2P9M3tXqy+EjQ6mXEFi5jgx5eHRvBcbcC1yPH/gpZYY6F
         j5qEUl3G2sUeb5YRmWRLpjDi+UJ56TSPTSfDmGA7rEmq0bl1us0EzIJYkqwMsmXYQk94
         qhvw==
X-Gm-Message-State: AOJu0YxQTUWjvexU8cUhvqc4MeTFK3i2H4Wm6Fi6yCN3zY44yLNYqOo0
	j073iphTdclW3ldbOkpSS2j9A2ZZ1AAtoccVwS8r5HeixsKd5OxD7TtM4axh4bq8WmkPxJwJuLk
	zckVgSbl0MEwzTb+AT4018diVKXoPACxB0u4sxqtr+lJXNVoaS8NWF/P83CiMrGfxrK4=
X-Gm-Gg: Acq92OH6th+x0aDRIc6GiIFVk4KCW5zfG0abOc9KSytuYd+LsDyapA9P8gF8ZqzGIAW
	uADgitHOHQeNNevXzCRP6NG7O8QJw3PF0e7DekuCMunoPFFQaiRE7wReXTE5HCXPg1rGIGVBYs0
	AwLROrXrrgAdZoXqK3SNIF/Puf5Su508QvF8lAJxMRs0PZroDUuiR6rNEDRMKWYbIcUTO8ge3JG
	Ck8csUNvaCd0lA8wcBKeQWDeu/Dxcu+SAUd+ed86nOZAOmU/Z7ZBh+K7ZBilcZ31DkGGqOW0IVq
	j/cMpTv1lB59r/8naVWqN6w8O1FpBP4rsvR3KXGDqHPBsG2Z27bxKsbNWBDq/T6ZHPT/FDqbp+G
	a6tnJwhwMBVgnQpD0MqLYCwXKxuaTK9YdlWSr8AmWo4wdhMZxOmim9aiPa93CdiknFsXkvzxB48
	M+UGKS3RKHxuPh86GOPRXreq/PrDRHyQEmNS52MIpXHhZdAg==
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48fe63263dfmr16564225e9.16.1778800552894;
        Thu, 14 May 2026 16:15:52 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a628:d33e:601:ebb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39155855e9.1.2026.05.14.16.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:15:52 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 5/5] ovpn: disable BHs when updating device stats
Date: Fri, 15 May 2026 01:15:44 +0200
Message-ID: <20260514231544.795993-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514231544.795993-1-antonio@openvpn.net>
References: <20260514231544.795993-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEF83547B5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288108-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:email,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

ovpn updates dev->dstats from both process and softirq contexts. In
particular, TCP paths may run from socket callbacks, workqueues or
strparser work, while UDP receive and ovpn's ndo_start_xmit path may
update the same per-device dstats from BH context.

Add ovpn device drop-stat helpers that disable BHs around
dev_dstats_rx_dropped() and dev_dstats_tx_dropped(), and use them for
drop accounting.

The successful RX dev_dstats_rx_add() update is already covered by the
BH-disabled section around gro_cells_receive(). For the successful TCP
TX dev_dstats_tx_add() update, replace the existing preempt-disabled
section with a BH-disabled one.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c    | 12 ++++++------
 drivers/net/ovpn/stats.h | 16 ++++++++++++++++
 drivers/net/ovpn/tcp.c   | 10 +++++-----
 drivers/net/ovpn/udp.c   |  2 +-
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..a6b777a9c2d9 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -201,7 +201,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	skb = NULL;
 drop:
 	if (unlikely(skb))
-		dev_dstats_rx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 	kfree_skb(skb);
 drop_nocount:
 	if (likely(peer))
@@ -225,7 +225,7 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
 				     netdev_name(peer->ovpn->dev), peer->id,
 				     key_id);
-		dev_dstats_rx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
 		ovpn_peer_put(peer);
 		return;
@@ -301,7 +301,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	rcu_read_unlock();
 err:
 	if (unlikely(skb))
-		dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 	if (likely(peer))
 		ovpn_peer_put(peer);
 	if (likely(ks))
@@ -343,7 +343,7 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	 */
 	skb_list_walk_safe(skb, curr, next) {
 		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
-			dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
 			kfree_skb(curr);
 		}
 	}
@@ -414,7 +414,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (unlikely(!curr)) {
 			net_err_ratelimited("%s: skb_share_check failed for payload packet\n",
 					    netdev_name(dev));
-			dev_dstats_tx_dropped(ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(ovpn->dev);
 			continue;
 		}
 
@@ -440,7 +440,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	ovpn_peer_put(peer);
 drop_no_peer:
-	dev_dstats_tx_dropped(ovpn->dev);
+	ovpn_dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
index 53433d8b6c33..3a45b97c0056 100644
--- a/drivers/net/ovpn/stats.h
+++ b/drivers/net/ovpn/stats.h
@@ -11,6 +11,8 @@
 #ifndef _NET_OVPN_OVPNSTATS_H_
 #define _NET_OVPN_OVPNSTATS_H_
 
+#include <linux/netdevice.h>
+
 /* one stat */
 struct ovpn_peer_stat {
 	atomic64_t bytes;
@@ -44,4 +46,18 @@ static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
 	ovpn_peer_stats_increment(&stats->tx, n);
 }
 
+static inline void ovpn_dev_dstats_tx_dropped(struct net_device *dev)
+{
+	local_bh_disable();
+	dev_dstats_tx_dropped(dev);
+	local_bh_enable();
+}
+
+static inline void ovpn_dev_dstats_rx_dropped(struct net_device *dev)
+{
+	local_bh_disable();
+	dev_dstats_rx_dropped(dev);
+	local_bh_enable();
+}
+
 #endif /* _NET_OVPN_OVPNSTATS_H_ */
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 82809b016f0a..433bd07a4f1b 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -152,7 +152,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
 	schedule_work(&peer->tcp.defer_del_work);
-	dev_dstats_rx_dropped(peer->ovpn->dev);
+	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
 }
@@ -298,9 +298,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	} while (peer->tcp.out_msg.len > 0);
 
 	if (!peer->tcp.out_msg.len) {
-		preempt_disable();
+		local_bh_disable();
 		dev_dstats_tx_add(peer->ovpn->dev, skb->len);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	kfree_skb(peer->tcp.out_msg.skb);
@@ -331,7 +331,7 @@ static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
 		ovpn_tcp_send_sock(peer, sk);
 
 	if (peer->tcp.out_msg.skb) {
-		dev_dstats_tx_dropped(peer->ovpn->dev);
+		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 		kfree_skb(skb);
 		return;
 	}
@@ -353,7 +353,7 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	if (sock_owned_by_user(sk)) {
 		if (skb_queue_len(&peer->tcp.out_queue) >=
 		    READ_ONCE(net_hotdata.max_backlog)) {
-			dev_dstats_tx_dropped(peer->ovpn->dev);
+			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
 			kfree_skb(skb);
 			goto unlock;
 		}
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 059e896b4a2f..8811aa9eedeb 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -125,7 +125,7 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 
 drop:
-	dev_dstats_rx_dropped(ovpn->dev);
+	ovpn_dev_dstats_rx_dropped(ovpn->dev);
 drop_noovpn:
 	kfree_skb(skb);
 	return 0;
-- 
2.53.0


