Return-Path: <netdev+bounces-139863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904E9B476A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC84D1C224BF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4720898E;
	Tue, 29 Oct 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V0SDFEmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEA207214
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198904; cv=none; b=bpxqzJOIsyPsG/oC3nCYXdq+8l+S7mU6WaWcUlOVzTu7AsuYeCzbzsswVUC7cp8JKxxT3xTXj/Jxsx48kvWtp/oXnFBMHNaBNC96yRYbGCnCWssKeekV6sQghdi2jiP9SpQwn4S9t+0/XlvIG+ZwSqEA4NEJWonT1LkbkEQ19/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198904; c=relaxed/simple;
	bh=HPD74dFTUJVw1Mb6Tnva6vXx0/GeHnn2miLgqXGsZMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZ83flsXvGRGrzS53aUIVKipHY8Pr3ySjqF48pevXKEUT+3o3a2LkMWX7cWSfRat0Y5lfHkgFr/LdXCRYMuCjaaq00mJw7hfnvcCPSF92JhfzMUdqr49bTdO2ub+fPCb2GTK1ii/RNHhevOGiadnOJb1GUYCD5KGB6AQp40/o9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V0SDFEmw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so50762785e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198899; x=1730803699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu9wUpES03z5zwq1pp4zWiW8qVio/9Hy3DajQ5KhjlI=;
        b=V0SDFEmw2RFO7CgIDWaRwwWqmmuHe5D8oFomMAEhvNCAKJYJfeVLZFNIqwuV71Aqkd
         d205wpobFN7NxQ5t2nUm+ciw+XcWY8QaKZV0IFAtA3Yn65FoyuG9cC9vSqnwcWZyDeSY
         +eqfAh0XRFDDd5iZJyStC9bMb8XTAVasOWYnShT9A073f9wmrYYRJsJ3LvPImr9gkzQ6
         MrvVo76Azm/rrwRZRLrdrIkXZqvV7j1IHG2WLzTwzoK0Tzkf04B/8Vw8TQwzsiBPQFbz
         5xYPZA212uXv+aBCHJxeS7VE+dp2TjzOVuK7L4OEHqnjMUOU6+EyJSipfYnRMbqQYhbF
         xYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198899; x=1730803699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9wUpES03z5zwq1pp4zWiW8qVio/9Hy3DajQ5KhjlI=;
        b=wQ2cvWMgvI/GZbtvkynBkxCAne2rMd8ITFsMF5xnrOf6CWQRZoEWftdLhBqEo1NIae
         LfA3s51iHRDoGz0RHEHfmsq5eLiHen8VYp0J32fsY6DlUKAs6zruTu4rdt/td11M0fGq
         lzpLLBQp1Yz0UZ3hZil3sKJ+Z+4vgr4ibpdSu5CbcYtwPggSra40ulf8B5Bw0jzuR5BU
         hBdsHN9rUK8ZdOa67LDnmF1FYeqgjSybi1RU7qUAoyvetRE2OI9XZl1sqAkJddUFR4Em
         Vbe0RahzW8aRHsJjGxu8Dz601O5xBrWAoZmOkB2OtGG0RZjREzpFbLoDX8hxKAQJhxvN
         lfYQ==
X-Gm-Message-State: AOJu0YyUxFvuVCngvDIlzWZhFo4cgudIHsLN+oqG8Z9GS8qMb+5uwR2S
	IbzzNgr711S9b3jqwW68YgtREtX3q9i9iLB+ByMDF7gx/xELSJeXjRE6cQGKzFk=
X-Google-Smtp-Source: AGHT+IH3k3bMFAURwAdpClM+9REw7MkXQ+U170sEupJFSHjEjW45CJvqhcrVUf+Px4PBZj/bL5r6wg==
X-Received: by 2002:a05:600c:314a:b0:42f:8287:c24d with SMTP id 5b1f17b1804b1-4319acadbbemr106017665e9.21.1730198899405;
        Tue, 29 Oct 2024 03:48:19 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:48:18 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:29 +0100
Subject: [PATCH net-next v11 16/23] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-16-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=HPD74dFTUJVw1Mb6Tnva6vXx0/GeHnn2miLgqXGsZMs=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOkKe7ObpJYE1qjuEsjm4dIs+WxaH2Lqs8f2Sl3orWCZ7
 x8mnovoZDRmYWDkYJAVU2SZufpOzo8rQk/uxR/4AzOIlQlkCgMXpwBM5Ncv9r9iZ+7+VzwXoTwx
 KCqUny9xbtNVc/7C9DMpPpmLDyrdiNHtvbXalbVDXIjB/7dV5YEvU58f3FI22e2W9dMEfaaPvjb
 HPTUizQ9xBHNGTAuSZ4wvN936SvDNp9UXRRf9TCt15bJ+lvbve/znAlGvHeZ39YM8vf831TUemc
 XW2qn1YK9Gs9vWfcuNFcUvieUtrPqtku+rEtJrnJ3deynl2tbnVXHH9l9/pDRdIZ1JUHfiYsF7N
 j0rjrzQ5e/aPZHr8hTZF4WhV2z6dqn7Rz+JD5qYF26uy/VQUPNTxXeGaTn3fWee8tDt2L4t5tjv
 M8ZCXpbzkrJDgrOc+5KeP7muHZDRGB6pzdoa3LW57UwCAA==
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
index e8a42212af391916b5321e729f7e8a864d0a541f..3f67d200e283213fcb732d10f9edeb53e0a0e9ee 100644
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


