Return-Path: <netdev+bounces-133426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC6995DCA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC2228761A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B5166F1A;
	Wed,  9 Oct 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBb09Fhs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE7166F00;
	Wed,  9 Oct 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440981; cv=none; b=AufHaRJNLcJDCbAhHm0MUbstrogpZ3sMi/qd/RTSU7WLXjdQhXCk9GLI2O0lQhoPXe2NgOz3mlt2vw3LNqEWpAsCKKXJmF5YwVF5qM+dEAY3HjwNRTTt/gHXXw3r9ZhP+MOxBIrrlzjzVVX53/Ny3suu0Hq3/ACHJwksD7OQuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440981; c=relaxed/simple;
	bh=0ZgJtJ+TjXiHcGPlxVYxhjDteuWSfgfQg0cBummbs2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RhjHi73jKpw+fkhAfDZeHwvhYjD+mW7BsA2pYXUL3QveRq+iF12n/xqqJKLy3986lBcr9vb5L0wgw5JO3yOj9MdSNvQ1+JgCEftJHQYmXBkvK282fVhbP1TBGV+LpTOTq8sG/1b5uCfLwnWTpLjaeEiwIHbGPdTdKI0BSLALA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBb09Fhs; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so304533a12.0;
        Tue, 08 Oct 2024 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440979; x=1729045779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDoqXpsFl8RNldAVAwpbrbVadRrwiVLnsOpDQV2p6FU=;
        b=eBb09FhsSuMtyPwmydxO+8DQH+x7dGX7+pK7BgUHUCl9IeINNRERJnlZcxZFJDccxE
         CpHwBuz6xikej+VWNLJYZ81BaUKWoBgqrz6PtZJOaGt32iHPNBNDIUZ5qvLu/DGWfB9d
         cyaDIrBpw9mtT9P7mVG162/CyUdC5VtvVFLK+1qf+7snf7MyWjqBdIHIqatmhzHNW/KS
         e5PDtACBUgTCkdsPDvIsUwL2CTiWjqqezONGeHR6B7x8DEZlt8rngQYcRvOeHcztA+63
         GbAF5znZxCKq1muIrRJKhF9pO9vGiTJs2mu7vWN6cW32lPffWcNW9JJkD5hddixg7rYi
         sb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440979; x=1729045779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDoqXpsFl8RNldAVAwpbrbVadRrwiVLnsOpDQV2p6FU=;
        b=Ua4j232r3i4f9rLEiO+5V/xkQ1J3xpeOMx98nuSqI0b3Hr2rgLSpZHAIv+dJlu5muL
         ip32Om+zuqj9S3o7Eup/7n0II1zepyOTNqqKYHnHV4fDBj+dXUocXvmEQlyYQV1tnw0L
         hwY9TOmfaseJkMPbR/gyjOVJSL8w11kqGEqUE4GZCXctX6A4dYDfoLQlqTBcf/Lne8zu
         wQFozBY8EeT10DpsCBQ9SaZbe6ZYu0UoFCk7kFfydEElzEWHgEvNjjS7MhgjyKDjVis6
         V6d2EYu1pmTJtljlAp9g5JGjHJCBL1cscJyoT86YMNm1PYh9nAy+W+lxYhuDkC01zazA
         mGmg==
X-Forwarded-Encrypted: i=1; AJvYcCWzMjIuKIjuO5kLI3bdiQ0idhrbDaj02gAXeF8NrKzQ/rgawg0s0dtsDFhbyFXKAw73r+QDP8iK@vger.kernel.org, AJvYcCXtNei2XISTIxzy2HsGhBgW0UOnu2NDfHxajQ0l6nicSOk2/Hez74UCm30wJf2C47gb7wpFoYVtg4oRslU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1YLtRjd4N32gM1nrWk493b7iaP5+sSUV1TjovJFvNhqv6Qwj
	MWecZ7hEXni/Lv/DI5tS2OrffLP3uJwNuWKZjWnfMc/FwTStJgiq
X-Google-Smtp-Source: AGHT+IEZicIJfJ4Otx0VliOjFPiPU10M2fkxD/CGDiT/CoxU+eCrV7IYk2nrZBNFO/KrE6Y+1YcTzQ==
X-Received: by 2002:a17:90a:eb13:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e2a0757524mr1871609a91.2.1728440979160;
        Tue, 08 Oct 2024 19:29:39 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:38 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v7 06/12] net: vxlan: make vxlan_snoop() return drop reasons
Date: Wed,  9 Oct 2024 10:28:24 +0800
Message-Id: <20241009022830.83949-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_snoop() from bool to enum
skb_drop_reason. In this commit, two drop reasons are introduced:

  SKB_DROP_REASON_MAC_INVALID_SOURCE
  SKB_DROP_REASON_VXLAN_ENTRY_EXISTS

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5:
- rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
  SKB_DROP_REASON_MAC_INVALID_SOURCE in the commit log
v4:
- rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
  SKB_DROP_REASON_MAC_INVALID_SOURCE
---
 drivers/net/vxlan/vxlan_core.c | 17 +++++++++--------
 include/net/dropreason-core.h  |  9 +++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 34b44755f663..1a81a3957327 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1437,9 +1437,10 @@ static int vxlan_fdb_get(struct sk_buff *skb,
  * and Tunnel endpoint.
  * Return true if packet is bogus and should be dropped.
  */
-static bool vxlan_snoop(struct net_device *dev,
-			union vxlan_addr *src_ip, const u8 *src_mac,
-			u32 src_ifindex, __be32 vni)
+static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
+					union vxlan_addr *src_ip,
+					const u8 *src_mac, u32 src_ifindex,
+					__be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb *f;
@@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
 
 	/* Ignore packets from invalid src-address */
 	if (!is_valid_ether_addr(src_mac))
-		return true;
+		return SKB_DROP_REASON_MAC_INVALID_SOURCE;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
@@ -1461,15 +1462,15 @@ static bool vxlan_snoop(struct net_device *dev,
 
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
-			return false;
+			return SKB_NOT_DROPPED_YET;
 
 		/* Don't migrate static entries, drop packets */
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		/* Don't override an fdb with nexthop with a learnt entry */
 		if (rcu_access_pointer(f->nh))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		if (net_ratelimit())
 			netdev_info(dev,
@@ -1497,7 +1498,7 @@ static bool vxlan_snoop(struct net_device *dev,
 		spin_unlock(&vxlan->hash_lock[hash_index]);
 	}
 
-	return false;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 98259d2b3e92..1cb8d7c953be 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -94,6 +94,8 @@
 	FN(TC_RECLASSIFY_LOOP)		\
 	FN(VXLAN_INVALID_HDR)		\
 	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(MAC_INVALID_SOURCE)		\
+	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
 	FNe(MAX)
 
@@ -429,6 +431,13 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_VXLAN_INVALID_HDR,
 	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
 	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */
+	SKB_DROP_REASON_MAC_INVALID_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_ENTRY_EXISTS: trying to migrate a static
+	 * entry or an entry pointing to a nexthop.
+	 */
+	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
-- 
2.39.5


