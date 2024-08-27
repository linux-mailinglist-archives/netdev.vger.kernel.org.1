Return-Path: <netdev+bounces-122294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D79609A7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF221F23179
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE661A3BD5;
	Tue, 27 Aug 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YeWBhKJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7B1A38FE
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760421; cv=none; b=kXwJgUKNjuGHt2LvLJfBglIUgCDUpD4JIVzyrM9n1y7zgULHRqVBGSzWhrnapft9cmdQyzf+tFLK/B2jtnAj+RWLS47+Y0RbDp7MiPAXmBFFChXymaQnJgm9nBQRWWms26A3Y7vIGGJL5Wy/ctqKKA71Ke+xWxSQntjzGyxgQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760421; c=relaxed/simple;
	bh=iaWJ/ayVTU451ip54nZ8WDWlLRCbl5EjgLtjRxOO4s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy9PFZNA3ru2f2e1IWq1se3nzilJNXxvBWUAOS6QrPrNlzNi74khzBtDFbcpXOGxttJ/LCKwAF/W+mxTSwVlCC9VstGx9yuOhnmTr9qODI079yOXDUP7V6oAKFYSXmL2pIoE1mC9alMc/pUZQn7nb6zEHzPwp8XSHfbXMicwqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YeWBhKJU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718ca50fd7so3368527f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760418; x=1725365218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtQFaicIEBo2QJNBN8dDKfpS3FF569JiucQlBySol3Q=;
        b=YeWBhKJUi0K3wE8sN1u5Iavkh/rxzXjLEX8/qCTGtu9mtWFeNuyiCkmIksoP1uPiJ9
         9EGDL+fi7rAJanjG9EvdAiIvZqIob7Ij27GyC1tYFFUGX/kx/QU860PbxIq3XqQu9X6F
         AUMNe2SYBKggpsmgCM9BHFFVQR/QFj+fBYfuNqVr/pHqNnQrVLP7Q6ME8XCKnyUW/I6m
         Qfwc2ahI8RCCFzTxr9kLJkt94SvF6sdXW8Dwb68NPkE2f9/l+Rj79vvizwhfzSCn2yli
         ZKvcF6UYXYUhZhvWa0NooRTTXvqwngqNJvSwSKUJJNc9sIzObormRhvrfMkUNGsofzz2
         UZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760418; x=1725365218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtQFaicIEBo2QJNBN8dDKfpS3FF569JiucQlBySol3Q=;
        b=efGSXNhu9qd+iX3kmNz259kFq0Ozf/y3m3UFnztT1PsoE5d3hqsOJ5KfxMbfubnrBh
         zpo9Fq5EnMWSbIKUXkJcdvNXdxK8wryVbnhtn16b0/H3VLZ0px+0Q0IFpiOrV2KMrRc7
         17KJhLvbDw8KYWKsiSt0yKRdc5caScjuysGAzHiRpaiYICIHRjUVSKG8AzbIHioaHelA
         9cIYWhyvmFvQb4LlpRjIEDm/Wr0BnsqZWRWHKQAou0+1jeo/OhfiFj6l6FZApRrW4uy+
         6+fg81sosiX1pbYShmYTGQqQ4FaAsFe93d8IJT6jeHJndi/bZJaUJbFZ8e9EfxzHTWfZ
         ZAYA==
X-Gm-Message-State: AOJu0YymaRN7cXWiPH9Vy2nLIADHDd56l2L8s9dqYZfTf22Lmt2zaOwI
	ccC5nzqTKCV35kdfJ/TdidWkVNsmZMWzrPGaVRL69boJC3gwDUuJ19dAJr73h4EiXMqNgiNr6rA
	g
X-Google-Smtp-Source: AGHT+IGMqFCW0ZFLsSHtxcDLJSOzvY8nyFRDUgWVKVxKifMIVHlGaEU36oXB25jaGFh01zB+SsYF8w==
X-Received: by 2002:adf:b19b:0:b0:371:885f:73a with SMTP id ffacd0b85a97d-3748c826a7dmr1915164f8f.58.1724760417689;
        Tue, 27 Aug 2024 05:06:57 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:57 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 18/25] ovpn: add support for updating local UDP endpoint
Date: Tue, 27 Aug 2024 14:07:58 +0200
Message-ID: <20240827120805.13681-19-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a3f4f3231f3b..63e3e83b4fa5 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -416,6 +416,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
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
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
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
index b632fabf9524..2b1b0ad3d309 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -159,4 +159,7 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


