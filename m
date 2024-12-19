Return-Path: <netdev+bounces-153183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AF9F7219
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5602816D22F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AAE1ADFF5;
	Thu, 19 Dec 2024 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AiP3xnzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A521AAE3B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572559; cv=none; b=ZnxDteaNvj4+2+KVIIhF5LQu0u2zbmQwiQ/RpFOxqxF3x9eiI0hfs5rF40/BRpnQNxXO6kq4ahiFWb+Mbp4EIbYLIJ3cT4Vnt4TNd1GnEi71EyuoFw9DXAxu9Zm6XXDc5ek8WkXwYbA29FlAO35oauh/2cwl7sHmeiPmDca9tvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572559; c=relaxed/simple;
	bh=VAPwP0ND+/+1uiNTYTyRb5dZNF+tB/wOjSEeaQmrIbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAX1tdBp87mTnfLJA7vFQG+xjnlIX3Ma39vPv0NAsA5nrUxoZFzAIp7ZaFFMiAbuVwHTqjsE96NGT49OfeHaZah9KjM/j86SE8y0mB3QZPhTZpBX6OUtepn7mT1c7CKAx0lVj16HIGGH0xOp4LlAP+tWrkZF8LWSrHz5JPnScj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AiP3xnzZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so137668f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572555; x=1735177355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71K3bveKDC1L2h+3pjr0ZAS8X5H0eQHVqfTEUOB0SmA=;
        b=AiP3xnzZ8jdAE88Ib/wxg3sfCKxJE5LfVatSYeucBhrVMYV/alQgwvkbKXBNny00TW
         6MQM5a87ApXw24lX9AdwvlwC8U3/V5uq8akLGROqbU/4ervFtJ6tjWIXhyKIsjw1UNZ2
         PD2R8dUcFXm1hrLkTDueTHh6OlmDd317UsWwUgnESt1Xc065gsxtr7nUXSg72UhG2/Pr
         azA/13zyFwp5ne6bILD/PeRswAewYFjZaOnmm5mqf8awqXxfPP1ZqnVnLXVCZ+eEQmGQ
         nPt+frVRZQg8fmRFcnKU/L/yV3j1v1ZbKNQYLALMH5V2QjB3/CS2/GWtzCQOXyB4E9Y8
         QJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572555; x=1735177355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71K3bveKDC1L2h+3pjr0ZAS8X5H0eQHVqfTEUOB0SmA=;
        b=t5RIp6x6bQF8Gv36VVzqYZoDmFk+GnsrieVd1K8lmKMgGrH0+9JGwfEr9wz549CDHF
         wa1txckHAQ1x0ntgun7gI2FT29i2kDHMEZyuBJ2rrQJZiHtf+CBgrvRwqymoY3ZQPXrz
         BWUsVIj3DN+MFc3zFXZNEuIPV/o7KcatqvhmiutrKcdwwRYezVtofq38Wd8GOk/Aoq14
         TBmfLltfFONq0bItLFcEnUKJ8eAEPEk6TTfJR8FaQ83FxEHye2fx4yHjMMD1ITB7m65N
         nZQQ4US5cTegjVoX7IAxkyeCrqLsi9O6ds8QDYXPHFNvK3Y0RUeTk9B4w6RPyX2mQhzx
         18RQ==
X-Gm-Message-State: AOJu0YyX8zv7+28Rk9FccJr7pUwYvnOWozaf9dLForqWaP3gKxUb5CfE
	lszsB+uXvksn0z4Stp9XW1uARRbKGXetcUYOyHrrUZWAM1MmUTACBTW0hq8VcSI=
X-Gm-Gg: ASbGncviGu4ZIAkXJOegyS2BnxRdt7u20xyLHB9jPr0sp5Fp6ckLxukUA9w28gbAeW5
	FwzUpem4OaeDcnxBkP9cQWnnu7VwuRw59G+NJBMj47zCZ/1BoEwGQ8gQUbeLdaByClOeWdDTDAV
	dBtvBnzcFc4nA5QUWIgOmHi/g9/2T/9qdvhhi2hF/Gx9gGLXovGF2f7pu4CW57dDi6boixH6s08
	xQStsUKtK1WEAAzVBxhbm24rLggq1ZT2ofqdb6zFgrz/QOCr8xLNVWvrBPoTwRiyBde
X-Google-Smtp-Source: AGHT+IER03Zv7N1bOc3gTOhR0K14RNj9Um5Y4vXyVtDzBAGKb4Rb5giusVaduRRJp2NApuxvEb7FlQ==
X-Received: by 2002:a05:6000:186d:b0:385:f677:8594 with SMTP id ffacd0b85a97d-388e4dae534mr4399498f8f.43.1734572555563;
        Wed, 18 Dec 2024 17:42:35 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:34 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:13 +0100
Subject: [PATCH net-next v16 19/26] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-19-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=VAPwP0ND+/+1uiNTYTyRb5dZNF+tB/wOjSEeaQmrIbg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oWgS+VHR/thjZl/ElWuyxRVt0FlEFIIPK62
 Thifh5lOW6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FgAKCRALcOU6oDjV
 hzeFB/0W2Nl3moB4mh64eu3jJIg880o82q8367RO3w2F9ZnnS3Fz24VaZz53vSBWSOfsfO9LbPg
 S7isOnLBwMT79iOG6FqSlTshgZHkcilvJeC3BtoznRCh+Pts+HbdQs1tSM4KQsax0mjb8zKWG9W
 CrSjB0nZX9KT2Q46N3l7raSmwAAVcF+gVGujB2AV8KNzBeXzR9sfOHnYrH4s7ye8rEIJXCa0SsV
 RUXrQTSlfFmo2adSWRvLPSEjMci2GkWkZkZp/VPVghD0hP9pvHCJlVUjmbAfc0XRLHSVF+ibObp
 fribmHLJxKd7qkwJIQ+Mtwxd+TV3Xh3mB8X+MIAcHM4RGb0u
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
index 0f48e7dd8f9d3de1afdb1f3b7214556b428e9503..56c3788a2b4b8c2a85826b1b23fa84943e4cafbc 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -495,6 +495,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	ovpn_peer_put(peer);
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
index 9d85367912bef741f9692fa3ef16536ea314d16b..8e2dc1152d29d9a322361c7ad9b04cef07d18206 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -149,4 +149,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


