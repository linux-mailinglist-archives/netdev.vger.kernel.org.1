Return-Path: <netdev+bounces-93573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0D8BC555
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588DB1F20FEA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAB481DF;
	Mon,  6 May 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bCKN4ABX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2D47F78
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958157; cv=none; b=FGfFrSLI/18tqosU5pjWbCyPXdPu0m3+ACFBjS1q2UA/qupngPnYrWEic30qJ5l5LTHD2VQtHX/ON/fbXyRtXWQfYhPIxf9CqHpy4xMNRIluPqse+aZoZARy47p4rbf90k50lo9QdP2zzE4IUWdw9E49gSzQq4XvIK9/WUBhQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958157; c=relaxed/simple;
	bh=F8kyr000cFz65oRobkQZRb31+65eix8neLbdbDd4e3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuGChpUeJUQiX1fmRP7C5OjwR2JwDUgvmoCa5iDf+UgbZZBF7NK9pzwnSpVytpeEWiq/Au0y9cetO5PtXyNelu6amx6tg2ofLQwN65JIW4cbk8/3DZZZOaQTf2+RUuLrU9D/kFp1YSy62fk7IZ6t/BFsowt6QyOqwMhBMp089YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bCKN4ABX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34e040ed031so1088406f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958153; x=1715562953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwlqE8sC/pQspqmYFTNh8Zc/M9L9r3yOH4x74YfpnDA=;
        b=bCKN4ABXB46hWcEU5pcY1qy3Q7GuS/AIgkLPp+gJCQ4hJWleIKN3jKzHbv5buSHVy8
         kp1u0Q10TfoLd5OYf7Nx0vRsjs5Jp9DP6WVWV1KwKF3PA9IrY6JGavOSIcslUQD5lq2K
         N53vHCv/Nw4LWLY+igKRLcgBpGvFG6QimIIDFMvlP/nqVojB4VoZxiD3T6fxyfA4pLa8
         ik0Ky3QKsmjQVY8G1Z15paxW6d9JzZz70k7qiieHr3QtG6dnAaBpy4oDs+Gu84yAh9fb
         IRCYIjqHQ+axO1e9vsGM8WcLGgbSIE7/tOCdV5BvnTEhJYu1dg/pfdVHiT1AjZTJcyyO
         PHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958153; x=1715562953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwlqE8sC/pQspqmYFTNh8Zc/M9L9r3yOH4x74YfpnDA=;
        b=IAhAY3kjGBoEIlSQh2vQXA2TXjlt/3Y8uu29u4h+S1NLmH5bjfej6vhP6+4sXLrfED
         KUMQwGtb7JQfmIyvDRfhxgnoal4y4e/wsFB1xtcSkLKMLJIkdu6tnC8UnUlmzH2Db4F6
         yvNpxAF236keIsxRKxNb5SiH7kyo9nCK27nV5DdDLnPXReq+xfcCjDNFr7gy7R6oWtZk
         kwNaegDmqaFA985MFpWvBdNCF1EZ0dwop4H/KYbsP7Czyr6/G7r3w4c/Y7nyh48AdI9m
         bY5X/7tIQep6TRVxaSa1lOBjtDgE65qkT2y/4QYvW+yuo8HPfoIZAzXmjGQjDHz23zrJ
         Qw3A==
X-Gm-Message-State: AOJu0YwQkMqDbnkdGzN+mUQiqJ5Cdvu49JkJ9UaVQxZnz/OmZO1kXSkU
	vipKTd8n03cGuuyiQnVbwlwbHNeaZ65z848avj1MlHT3pPDuDYxYK7eqchi8o0B2yp2kzhGmXub
	4
X-Google-Smtp-Source: AGHT+IHn7XrN56TkatrCENgOg0h3x+8phOhNVYK+HzPsVV7runAs7biWbye/y5N43u61jrbMOQfwPQ==
X-Received: by 2002:a5d:4442:0:b0:34c:e9b5:d746 with SMTP id x2-20020a5d4442000000b0034ce9b5d746mr5535248wrr.6.1714958153775;
        Sun, 05 May 2024 18:15:53 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 17/24] ovpn: add support for updating local UDP endpoint
Date: Mon,  6 May 2024 03:16:30 +0200
Message-ID: <20240506011637.27272-18-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
 drivers/net/ovpn/io.c   |  4 ++++
 drivers/net/ovpn/peer.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 2469e30970b7..19ebc0fbe2be 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -218,6 +218,10 @@ static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* note event of authenticated packet received for keepalive */
 	ovpn_peer_keepalive_recv_reset(peer);
 
+	/* update source endpoint for this peer */
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_peer_update_local_endpoint(peer, skb);
+
 	/* increment RX stats */
 	ovpn_peer_stats_increment_rx(&peer->vpn_stats, skb->len);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 79a6d6fb1be1..e88c2483450d 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -518,6 +518,43 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
 	return peer;
 }
 
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
index d5b63c07408e..df2b1c93dead 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -273,4 +273,11 @@ static inline void ovpn_peer_keepalive_xmit_reset(struct ovpn_peer *peer)
  */
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.43.2


