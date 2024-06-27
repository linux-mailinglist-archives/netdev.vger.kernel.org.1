Return-Path: <netdev+bounces-107278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0091A75C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53F5B23F9C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7D18C334;
	Thu, 27 Jun 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MTJ3a/3B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D891891DA
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493697; cv=none; b=hIIR6EwWXuIhbvtqENjT1UOt0h7x1odUHHyvpWU4N1ytWwXZ0nNlNbgvi83TlFs9g5FbBUq1XqH9qJ1mGs46h+SGHqYVXOppH1001OM1boqSN1K7dBkiV/GlHGpkKFM8MmCJwmlAm1MvibIlKZxhxdteFpbkxbvVQdW/YjVfjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493697; c=relaxed/simple;
	bh=FA7VEIjRqnZjcT549vto+pTcyRXFzjLlz5FS0w7OJmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URlgmWJXZJz3f2DVZOTjw9mNz3F3uFj6VNIwkCL8A/O6lOFZW12xY1wFfbTcOqePTT9ghSK+zeyKkeKIurBlxzJqWku8OajXfruJcJMmHn4TeLgcTXX2w5PAHvIZEcxjhaK3Hjp8+0r/O9Tyn4LgRRLGSq6dlhjQQvWHnC9KLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MTJ3a/3B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36743a79dceso395960f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493694; x=1720098494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8uTbmk3ocTrLYyo6u3zNfATh6gPNw+QnMBZuw+eKbE=;
        b=MTJ3a/3Bmm47aoOihQYyOk0s9/l62zjuH+XBMYS90njK+UR0wT5pgK0eruTsq+L9o7
         8rmYlISUD5NuM4IF6aFhDhSz2jsjH5lT/TPVDBx+Fx67x6wOHImRAw8dEzepouOoGvJ1
         iEY5jEP2p9qBHSQ59acyYGi9MmBRCDo7b9+KgVnF061v/32k3XHEk2A3qzlQTswLxe/U
         vCMyVlZLJrvdmehmVeagN9Wqxsg5nY98BE+cNebAtJheYkgYM8oESEirUuWsMXeZPJYO
         1dXRAg0yZgaBhHjZ2ayMtHUtH4vnYyZHQ4kYqqqb9U3kGjEMz2+xQz/QAkehdgSFmiRz
         KVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493694; x=1720098494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8uTbmk3ocTrLYyo6u3zNfATh6gPNw+QnMBZuw+eKbE=;
        b=uRsjCCg7zm7MBQ3Jt2JMCaBEXaVkYv84NULireacoAXupN5dqGlKLSSaPoas5BA8MN
         GKf8amLih9kaemS2Hu2TbzGwRT4kiuImaxVPEz0XkAcj1apZQqdX0kt8jBtqjZwAuS22
         PshUqgoetdGrU3Ou3FjTh3hrISqhiR2HKKrc4whgVbkyRA+fYRexzp5vTe+7oAvm3O8s
         FWcmcmJ4kXGn5rWk5A8TOY0aAx7DYu5oeWnwtodkQYRHo6Q+T92NvsT/rPiXzIEahN8M
         NC6VYDxaS7jdE669SwVwzoe8FQEu5dbIWwRY8pjbC0mGcPXl6PsU7brQz/G9yQNllZb2
         4r1Q==
X-Gm-Message-State: AOJu0Yw2bz8y5qO4gMDi5scIxUnzP+5RU/RU+Z4KQ1sOviCODAqvCIIq
	CPThY5jeQcC9MRBgshkr8Xq2N8Xt7jsIpYHVPdcBeYELbQuwX8Uuo3W0Er5DNtjlueTG8vfkauk
	q
X-Google-Smtp-Source: AGHT+IE9TLqcf/wOvKG65tR6iMS6XTyg9fmvEyS2jcjSXFZf+ZIo8ko0bm2W1kpO4yNAeCdWteQ0iA==
X-Received: by 2002:a5d:4b02:0:b0:362:4679:b5a with SMTP id ffacd0b85a97d-367417aa130mr1736250f8f.16.1719493693944;
        Thu, 27 Jun 2024 06:08:13 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:13 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 18/25] ovpn: add support for updating local UDP endpoint
Date: Thu, 27 Jun 2024 15:08:36 +0200
Message-ID: <20240627130843.21042-19-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
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


