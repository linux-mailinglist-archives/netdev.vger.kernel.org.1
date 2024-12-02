Return-Path: <netdev+bounces-148128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E1C9E087B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039E9B820E4
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FE20B200;
	Mon,  2 Dec 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="P0S7yx7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229020A5EE
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152129; cv=none; b=MU8zSo23Dis7ZpNX8XWwb6FyglrDI0VxvSK21RIqzr6HArwT4sWSmGRL0mMnsG8a9VmuBEQRRY5pFUqOqSFe0R3vga8iGrrBAOA5tM5CJUwwg1NNWnBGuL6+9s96Rw+MQ/XiVbK5Z1TfqrSN5DQxrPRH7OH4rxDXGZA5jNTbtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152129; c=relaxed/simple;
	bh=OdBK3/xyCzwJOGcy6CtLEeb8qE/dLS0KYlWLU1j8sLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sleNJZHQLVh2HorILL5eo0MzPzbOgohVtxeFwD3+YCdAIPIAl13bEVaNJh0A9gRLxYTddQQKWu2NNXFlsNZYJteF5VB71gDlPwvrdnxsdjZjWIUV9RybW79nxO/VOxXobEZmfLpVTGHU03oWvnsN2RytvzmlNBwJX0Raiex9RvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=P0S7yx7P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a95095efso31485245e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152124; x=1733756924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbJeURYFV+XkEUFvZdxRbKGSWDfB1xJgrN1rw3Dvxsw=;
        b=P0S7yx7PXHy+6olFsqhXOq2wHtk/XbhmBIIF1sFDgQ3OTTzRnQIdrj1bA3QOGED+ou
         eHqH78KCcIL0PCbhPdql28kYCkSyM4xUpQlVaGEykmzK++EMFwp59h/LkPkhO6qOU2mB
         lK/LiXpZQhRjgQlmjPXqKcNsBS/V2xs3y79aoA+iZjgHMtifAFqswPQGaFt0sGWhC8Nn
         /x02iioolSl9nRVyOYxkQB6h4hVohX80hNgUaZYJY+/LaaLFVdS3FajkjZ+Hxa6MYaOX
         28Bcjaia45iS4eEvqTnn1yGAn70vkkj6OPjsyfuPyJ1FAUQuE3WD9sJqylW46aXLZKvg
         Nt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152124; x=1733756924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbJeURYFV+XkEUFvZdxRbKGSWDfB1xJgrN1rw3Dvxsw=;
        b=T5Zo/esvH57ssuAPZpMLMdjd9iGrUYjTATg6UVjOMjW5risjs3Y4TLKsItjLxG3toe
         lrYF7ic4X+GH3OwAcBqGRzSlNPo7zpqZEohe6v+LOwA2mgL8KQdxRjrkGMqmORXPwS3r
         MVYQ1w6Ghq91IHIU+w7e+XAox1jthKOd6nU4/J+cQcC4VSTYT63b/X9mqfHtAq1X7knN
         i7fwNfIaLEGSIdUCGRPJcVc1ZD8A4HpJBcvN+EFtHHAhTlW2BefQNUxqbCSjk5elRlbU
         qgrOy2nbA8QgAK3p7WziV9ih0eK86W2oJbDqnESrb2d82n5b5OYGNL0oUyOsLk9R0D9a
         LiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBojdOeE7CMAg6g42FyscjBYdlrf4FcvBW4qz2t8uW1/P9X7NO09tnSsIMYXALHtzAZIqzLoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSd28i0xieO9IUHHN4O6y6+V5dReXRZb4m+ETTzMjf99imopt
	DiQZPqKxUiQ7GIfVVRqmC81ftp4RMIW3dBclV9a6M5MnwfX/+nJsiWnVYOym9zs=
X-Gm-Gg: ASbGncse3WEPznFTcm5xLfRCZ81zID6ekrwaENtNo2uSlnsx7ejKlyzwz5tXyQ73/AA
	jtDemfsnvxb5kDzLsm2+HAseeWQgwjtqrkqEeqmoBz07SbfpRoypWBq255YziT9e03ZqzCnb/cH
	WU8JILp8RoTpqibHVcRRCGQVs6z4AmIQPtHsoXU8ogpvSGG6GM9WuDYz72OublSBG6qybQWX8kX
	Wnyjx7qFLlVF122y3SCKsdXqVV0ecDUTxl9qq7G6Z4/rrcEShs2voPnrTas
X-Google-Smtp-Source: AGHT+IH1E/+inXI9G80H+Nd0qWm2j6ypaYNjfd6tduQbE3k8llS2CkzbbKiYOR6WfsjUtPTr4KGMZg==
X-Received: by 2002:a5d:47cc:0:b0:385:ee61:b9ba with SMTP id ffacd0b85a97d-385ee61bbf9mr5680417f8f.22.1733152122800;
        Mon, 02 Dec 2024 07:08:42 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:42 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:33 +0100
Subject: [PATCH net-next v12 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-15-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=OdBK3/xyCzwJOGcy6CtLEeb8qE/dLS0KYlWLU1j8sLQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1ng3eOnJxyjaRxKBFcUAzY+47IQmoFfMXCl
 GNfENE3N9iJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZwAKCRALcOU6oDjV
 hxagB/42JJCU7vmJoSsY1aHvxhriTLKmiE8KmAC3YtjvCXXtyrMYfPhujWKaVI7ATgsemFpZy1X
 lW9B97irOl0mt8J9D848c+nZyZNpnIwpLS184vtcAGzGRvWNwUpPCG5Z59ZbYgw0rLtG8uPK4Fr
 WYoVxYkDVTVSjCGwq12kyt3F3iQT6Cb/n/AqJomf/9Ju393dm5LltAQCzTtO/cecoJnXXbWVUn+
 KOgSwS9a5b36+h0P1HXF0ik67MLq6lZY45z+Z8R8Gm1USu/YXv429dHe1PUlTsGau2ltctqqo2t
 LIoJObk92x5/QE1/8uMjakm9tm2LKYGiF1optJdR55RndkaM
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 606a5c538d7918148dbb647d5e111d94f5759506..7df9fedd593a74e2349922557ce299a0fcf03038 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -450,6 +450,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
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
+	spin_lock_bh(&peer->lock);
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_bh(&peer->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index bbaabc73218948e3597dbc567a19b0a5823e32ff..196fa0a04f2db1986fffa6d51b42b68c9837c8e8 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


