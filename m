Return-Path: <netdev+bounces-149839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08039E7ABC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1B028451E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C8224891;
	Fri,  6 Dec 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UMAJ/9ul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CB221DAA
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519944; cv=none; b=JXpR0xZCyF56dVEdrAiIAWA7x86hGAdQ1zA/SxpWbBjqzNI9o6QH8r9/IviJhzF5mr1/TIxkCmNfKvDG9Qrko/2+K8LoebhfrncSFWAVdzIYG+DcAANIobj5AVa0Sr9htew5rpbBq4PAi2oNQiRjuLphP5sp1JbaAfDu0Uy7ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519944; c=relaxed/simple;
	bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QdYhLP+rEK32Q96EWLzyRNpgyTCm1IyOnzo+hLzr25BesZclKTARqVd3nvxx76V6efmr5dyQ1rpc4NmZMUD9xO7jkxCFiRKUTIHsLWo2aXeYuEsB3NxgNn72DoXv47Nu/79UlARK+1yDatN/R2B1OHZrx88jr53MPaRSKOuOMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UMAJ/9ul; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so24781265e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519940; x=1734124740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=UMAJ/9ulnl8QRuW7pZwQjJeSSiYEN0fVjOy3VH5OgYRfDDn3i3QtucPmfu1GE0CPJ8
         NxhdvKibQ8jM2UflSg+Tsemv8NdWw+uimCs6g5Zx76t6qWl59RFpcsFziqAYpHB+kMso
         5oaE7Q96CGgYboAnz9Q5C06YSI2E8r6Z1dvI93bPSv+ZP5fTIZBjxgMg4onO/r4L0iPl
         7w+PvZQGKIWhhX5NBA2q4UYVGe92/8NTZCGuQj5R6iuL4MCpf5JSyOlrFO3YeJMYz9m5
         huQBYrt+P4ZeeaXR/vawrZfsShADQSLm86sjyWqb2VSTiRdU999rA6zdq7lOzqfjjgcx
         Uu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519940; x=1734124740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=YAs9IAw6vfNstQterB/kf/cxOKJhwFSWLpJEAcS6S9hE7RAp2yklquqCNSJ/Q1Bgxx
         G19stsIzeRclC2/k5f3ss1QLvvv0PxJUtDZ9d61ZKE08qqo4Rs796kUNNLlls5fO9XEd
         7cPXEcAzqYoS8um4i8dB1KlieCBCMlBP990t6pHXLPRgkjvGc6o5aQYcRCPJ5W4vtywo
         h14+2NIOL8leGsmKbPoBY6VOInU/rU5C6UqtWn8BV2Hkvh/9/OEK0RQ5LKn7y+PkEkf1
         q3otEcj+ezk6J3XI//0aIgr1f45mepfvvnEbxwvSc4WNIZr2K6KrhvE1yrOfZ/pm61Eb
         KhYQ==
X-Gm-Message-State: AOJu0YyqAGAR+0gFmVvJQqpJ4KftjAigg4+qAp6a3PSAMq0o88umS+0m
	8SA/kZYtPRdulvJLnA0fo1OWT8io/hLkRXXXF/Juet3syivutvMyr/Hn030WYyc=
X-Gm-Gg: ASbGncu7f7zOkWLG97wJB0Pg7u0tjO3DxcK4H3I08OI3n3YfhgPbGGNaNsYS4AWttAY
	yEpeESwCEduomlVvn2WV/2LFIqNYLvmzF6Gw7zyRDM5/WUKqV/hMZRLSIwn53kRaVGGJZrm/EcX
	lWUC8V+KAdGDXDhRzCSMAWdUf0FmPCNsaQQAm15AWb07I3/AmeG3q/NMpQC6C/RZFvJwqgXh/UO
	aKf606xI7q1cGXYoaVOxIRWSche6C0naJqzZpQF3P6IQ5s4A8nU6TBQ9COPHQ==
X-Google-Smtp-Source: AGHT+IGu6qLY53C0yoO6aT+2nQymjktc9X77m8kuNJGtIHYDdrEE2bGIzUewngaCu8CdjcRxJXFXqg==
X-Received: by 2002:a5d:6da8:0:b0:386:1cd3:8a08 with SMTP id ffacd0b85a97d-3862b3325bemr3770534f8f.5.1733519940294;
        Fri, 06 Dec 2024 13:19:00 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:59 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:40 +0100
Subject: [PATCH net-next v13 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-15-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYPaFUu0WM9rmjYa1hIakLvis3UG4dB+ZkA
 cWt6/NXu9OJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 h2cuB/9bN3LXMG5OFVwkE3CFCaoewrE0mzZ4ZM2diIeWArrXH9Kxn9fBFG6OcFkk60k57ZPDsje
 vLo9i2p8G/jTWidWmKAAAjD93InJbIIfe5hFvu5Q5y5Bzr319nOpNpEOVdWSv0y+2AHQJKWwA1g
 a73wM/RCOJtW3vBDHN6MtIuxckta31w2uhfrZ/4ZXxU5hERGAZJhYO2kdLb4ownoJgIL8CVeKG7
 PCnOg20jiyBU65/dJ9BznTj2La3I6sJ7bIaypZONQKcaKysv5PH68mzZ9N+66MJDgEc3VdR29lY
 r6qBncZ/AST1K/7nHjRNhlLEFa8eS0kHNzefqW8yYXANfzes
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
index 168cec1cbcead962e921d29822fc0d9dec1f28a4..decc80c095d6a82787d42d0b4d50f85016e942ba 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -466,6 +466,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
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
index 4316051a12f0b8ada5110dd7aa71afedf29a0c2d..d12fbced1252f84665b084f7a24b6d515bed833d 100644
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


