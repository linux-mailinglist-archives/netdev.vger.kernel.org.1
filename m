Return-Path: <netdev+bounces-106088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A940E9148BB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E64728683C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7D713CF9E;
	Mon, 24 Jun 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="T1ekdUoq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965413B298
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228612; cv=none; b=YvAsOfC19QxL84OJxWCaUR1Ff5F411xUdVibl0o6N9Eh5wo9md4cxdsUg0YSWax1jGaVNPMWm1LcEGJrOYVJk+qT2bcIcg65CQYfDGF2gi/MKxgG01azKSD/DVzitxt9U1BxXaG1W+IPlFiknUSaP5tqQIqq7c7A4J7kwFa7McM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228612; c=relaxed/simple;
	bh=FA7VEIjRqnZjcT549vto+pTcyRXFzjLlz5FS0w7OJmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZk8haV8mzXanUsHSNdPVo90De4HA5S6/wTsnbtB+4AuJgvFTas1ewD8+NNb4qfnHkJrPBunvPW90luavIwaMYzVBEhzBZi4BPB6RLKD9AbuQZVLtVoHgZCqpf15RFYahfdiu+o5FzCB94OQ+KnEvKiepE7QdByJqRtGaCTvZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=T1ekdUoq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so1587178e87.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228608; x=1719833408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8uTbmk3ocTrLYyo6u3zNfATh6gPNw+QnMBZuw+eKbE=;
        b=T1ekdUoq8M5s/3//QpYNWMNAQt9B/wMPBvGJ5HeoioTH1ddHNek5zqbFCN4vyz9ogm
         LSQngzP5/f/n34w6wRMBY9bfa1HdOnVf4G3SsiAQDdrKg8iRIsf5REmvzqfesNs+vydP
         Bp3HvyuEMty+0OH7ZaExOyel3sagmLP5gedvBTiI5quj1O8jgVYugLytlBzErbg1ZOIz
         RvJSTpk0TELqdZYVhaGiT05mjeha3zd+xbmoC0AowHULlekr2PYne8Wa+jcQM2grHSm9
         T2iLSX283Zvyp780dfpMn3BsfyQtPtwX1KOwEnEV4tro9KR3T5ttV/WusmxpTVuHyRwx
         RftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228608; x=1719833408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8uTbmk3ocTrLYyo6u3zNfATh6gPNw+QnMBZuw+eKbE=;
        b=IK/+k2UxWXgv5cYEYB7+OwI/0n4e1LjmVyZlhzsigDhU6kUS+NYlC0gnR+6OY48FcG
         4rGMkGtGkfD0ljPh5gFr6wHUCI9Zu+HwVVOOFPbMqO26NlbhptJwcFSvqi0ZUMlEU5nt
         0jVmZbxVuPLfzln7lzRczqLxT13khjKbXhSnw18/UBay5rVuySMTtSiXWnX1UGbw7SgU
         O/jATONbB+uylEb2BYTR7qQm2bBIay8SY6mO6eMwZirpxEveK7dA4vqvr5xeUfeuWnE+
         ZkQtbwApwqp30skQfR31Cgw26aYOhVq1ATTYU40HeqBLJkElRZazBog4YFNfU/44U5bj
         IcMw==
X-Gm-Message-State: AOJu0YwjvFbCAeJSpAQYepQDXyT0a21sZ5KsbwzoEM0ckwWFj+iQf7Hu
	6xofnSyZgoM9z1eqnn5UtwXW1ORbXpwARifG92YLvVL6h/qmXYycV5q6qkYqIMTxbmRmEoFHcjh
	W
X-Google-Smtp-Source: AGHT+IFedsXeNBe8QO4XnS2KxIl12fojm3+5/CiLg7geJ9KGXBCWoFUNoIAllEsBbwESImu5JBqr2g==
X-Received: by 2002:ac2:4471:0:b0:52c:86eb:a2e6 with SMTP id 2adb3069b0e04-52ce063d744mr2946885e87.4.1719228608568;
        Mon, 24 Jun 2024 04:30:08 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:08 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 18/25] ovpn: add support for updating local UDP endpoint
Date: Mon, 24 Jun 2024 13:31:15 +0200
Message-ID: <20240624113122.12732-19-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   |  5 +++++
 drivers/net/ovpn/peer.c | 42 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index dedc4d4a1c72..9188afe0f47e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -119,6 +119,11 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
 	/* note event of authenticated packet received for keepalive */
 	ovpn_peer_keepalive_recv_reset(peer);
 
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP) {
+		/* update source endpoint for this peer */
+		ovpn_peer_update_local_endpoint(peer, skb);
+	}
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, ovpn_skb_cb(skb)->payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 289fe3f84ed4..ec3064438753 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -455,6 +455,48 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	switch (skb_protocol_to_family(skb)) {
+	case AF_INET:
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+				   __func__, peer->id, &bind->local.ipv4.s_addr,
+				   &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case AF_INET6:
+		if (unlikely(memcmp(&bind->local.ipv6, &ipv6_hdr(skb)->daddr,
+				    sizeof(bind->local.ipv6)))) {
+			netdev_dbg(peer->ovpn->dev,
+				   "%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+				   __func__, peer->id, &bind->local.ipv6,
+				   &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index fd7e9d57b38a..1f12ba141d80 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -189,4 +189,7 @@ static inline void ovpn_peer_keepalive_xmit_reset(struct ovpn_peer *peer)
 
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


