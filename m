Return-Path: <netdev+bounces-135963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD599FDF1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8D01C2448D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6F1B81C1;
	Wed, 16 Oct 2024 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e94d2SOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA01A3AB9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040657; cv=none; b=Xp3AgBiy0uIpgE85N0/HL8xdtzliotY2RdRkfbAjl6iAo2QLKA2ktxu/kcIXE56sqknJgE3rOfZDqzlpA+klzZ98mlLNdnqBXkFyjSKmcgvYvNC2i3ntAhs5GHA5FMBJfCVf+K0utzZo//I7w2r8euvoQnKvIDp7lAJW1sVBEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040657; c=relaxed/simple;
	bh=wcrv5vDIBCgquenyyeflyML2Rh+TBSULYHxIEBJctjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVbtCVmJ7GEqMs+wOOFKh90JaLVmfd8Q87A+iizcpH4b03AsHGfFPUx/yc+epuBtFmGAYaD4Lori/x72gR8dVEcpUjKz2kgr2khr+Srfz4hRAaQ2TmxfPIdIgt0tCVrs2PZotOaBSdoaCjY9M8eLMyMz2LhR2x185JiH88T3GZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e94d2SOy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so3684567f8f.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729040654; x=1729645454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChnIuUCSP0kqnENSs3HRLRGEcxuQeK/etR6vsQ0JSww=;
        b=e94d2SOykI4tZyMN+y7l6tD3n+l+NMgTzN+81qtZQ0MqQq9CgYbtBBlyrX9gDG68D4
         7F2CbCe82SaJRStKoQ3pL+3gPaUSfSfGZ2xmCwcyeJxDOrwMV5bqT7fpp0OE77Wlstma
         pxow/oiXd3Bwhu90s+S9GlYjqjU7nz897HIyiWv/C+Md13oN4Mx8eJFsPobIeOWhdrGY
         8zh7vBIBGXhfukzL42p77+6cQqG+G6qnmTaQ2L3xN8kSXt+WK68rjG2xWUiL6SdVml14
         yPTF6EXiHwHt+Ns/X/ay0EOW4eug914VlHZh9Q1foWzIDB6oZOdDEEd7d+CNVTCYTY8W
         3RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040654; x=1729645454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChnIuUCSP0kqnENSs3HRLRGEcxuQeK/etR6vsQ0JSww=;
        b=RkkuG0hrJySGpYewv9AeR2bckp5asXyqeIzm/TQQV65osTH6doPicZu56GS882+6Mc
         uMwsORsiDZhOTaYLb+JmRh+oNgZ0DPkq3kxSF6WpgbIuRxVdOfojxz5RgGLYIQgLjxaf
         klOZNtW8qkmeYeIFDBs5LT2g++KlJsTa5lXBEVVnguzrFKFzadj8b16L4oy4IlPCA1OT
         BZwd/nGY3Pueya0qUMsFc/VoW7vsgQYowEJbYRm4bO1GAaVWyohf5KeEt7Cm3hAsKc6h
         xy/r6QeEPl1nGVUhy9Kk0W4pSYZno+Des6zzhsHUA/4852LkXhUapyXQadXIZVr1mvba
         LtsQ==
X-Gm-Message-State: AOJu0YyeGXS8TQwvekDvil3CYTuyaiM35Lop8uLGQrN+LMnlMDFNKpOA
	m2bYkdrW8zoYnjnonvz+P6bkL+vv5V6c/Ec6FOvVQyUlfdCFBJlKOyPuu0mq6Eo=
X-Google-Smtp-Source: AGHT+IE7wXhjo5SnBaFKlMDPSjAWhWNI4DkLi1mcYGrN3mBifWUDVNxwRaCf0o64CPXroMk4Z5tP6A==
X-Received: by 2002:adf:979a:0:b0:37d:4ebe:163e with SMTP id ffacd0b85a97d-37d86d69785mr1327510f8f.53.1729040653767;
        Tue, 15 Oct 2024 18:04:13 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:4c1a:a7c8:72f5:4282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm2886765f8f.25.2024.10.15.18.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:04:12 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 16 Oct 2024 03:03:16 +0200
Subject: [PATCH net-next v9 16/23] ovpn: add support for updating local UDP
 endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-b4-ovpn-v9-16-aabe9d225ad5@openvpn.net>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
In-Reply-To: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=wcrv5vDIBCgquenyyeflyML2Rh+TBSULYHxIEBJctjY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnDxDwdn3sHTKgsc8bpNPW+2syO0oFdCBTe2XHs
 nQ4ck4gTCmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZw8Q8AAKCRALcOU6oDjV
 h5LdCACZYPdMqsOGmhv1PHvTJ+E30Nh8fsmf1xnVslUHiu4MAp+H6XpmhfCgrcq7YIYw4kSElBL
 9LSXybx0wZ8gc8eAXs/cv9sSzraAj5eGOXgET1dPjb/iYJ7HypKk6VUpjPrsMZDNQV3RmfZBtST
 WG5G3+ppce02F2l/65t1VCOaKyYN95kW7xNsiXxRS76EZAsHj8DWN/9Jolfr7bVi7D64MVkcB0L
 R2KSm2zuVLjVJcHScbWv8+0PQAa8LUU7of1NKk2IdOrTP6Om0tTBNS1VdEsZqkc+XWGbqOYpBZK
 w1P0noN8yKK0c/K/6kHgm9aJTgJhlIj8Pi7kzBad4IQOKAaC
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
index fa1883d12dfd6ce3e2ad1f9835f15aa7db5c8290..f3b20a561d614da98a8bee80272095b15bc6650d 100644
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
index 952927ae78a3ab753aaf2c6cc6f77121bdac34be..1a8638d266b11a4a80ee2f088394d47a7798c3af 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -152,4 +152,7 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


