Return-Path: <netdev+bounces-130734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78B98B5B3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF691F2220B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560A1BDA98;
	Tue,  1 Oct 2024 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6O+K916"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1291BD4E2;
	Tue,  1 Oct 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768120; cv=none; b=tviL+N3HYeIUi4Ezrld8gmanWetqYWsp3Gcm4D+DxuIEQi7nRB1rpZo+P9gdzlEQSRz9C0UyCJdu6egltfEPtARsKa5WcCuV1YWRbwYTDyKR2eKybgqzsPQbnHdeKr9+L+TaRdsHZCpnv2ugn87AHk/aOykITZ/m3SWGguibqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768120; c=relaxed/simple;
	bh=FBRZwyP4u4gW7pNLbfjZRSK3qJR19rpUewV7EwSvMQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cyywox27Dt11eq5VxQ46fGxVpX+vRzbVI3bbEbd8/4soocEw/jnLPJpt0132Ie3kWuP0kgI/Lz6OJlwk5a1hWBvanLYC4MkvZpAF0nAm7lYZtncDzV8f1payazb9s1sfMbc3wLv07R5XN05rwkoS98MHOZJ6DjPkVyXyp9zVpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6O+K916; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20b8be13cb1so19003815ad.1;
        Tue, 01 Oct 2024 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768118; x=1728372918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/nkaKX1KgrE/XGBRYIFDbeQa02MCHHf0bCdomncKSI=;
        b=T6O+K916ib6dxHsA8TErWKHtKRsISVvl8nWsLQh/4gJJ9cGXUD8kaNkyBfzdaN8znt
         g3E+F8q8Nv9V93XUJlEkT7sWb2ULZrg9rDKXerRRALhDgwHwraUPqTQCiiBfvUqICFJC
         UYZ6576BVna2MtXJbBGI6HJDdETBMVyl/+ghHE9mrIsi5cf4FVOf0ng8tCgE3h4E0bHf
         3xQoGBWgCj/y9v0JGUNv2tcmZtluNY4F2o9P1VnARAg/L4YvGM20tWzG3yVDglGBr8HO
         7+4uE9watHMDXltuUU1CicgPiTsnVFmmD+79t7xbdA4nOU3eaRRDceBCqSL1bvaPNnfQ
         2CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768118; x=1728372918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/nkaKX1KgrE/XGBRYIFDbeQa02MCHHf0bCdomncKSI=;
        b=Q+CEcSZOuaP746O6O/a1crdJclT8sHMXGNr1Te3yegg1o+MQbSA6vYDxpNr2PHW3SC
         yCcgU3uSMn0RsSbA0jyS3j+cQ/5KnSmOFqpqVW6xcVQqKJ6viAN5EMnWyyQQh7mLwLEu
         WLcC7BiDZptvC7RGDvkEBHPQ3e9fQiA7IIS4eGsYBXDgYrwRBAc+VehNb0+JdN/BShJm
         Wo5GtU39t4iOlMDqm6qSkNFNsKkPA7GeuA4nbG+uoTvs+tfGEcSSQ5si2pcWHfcTnOT3
         liDxGpKr+NLB8dU6TMGTFlYQn6qNx3r/KefAJ5DXI6Ik+Nld+0oQehQpkAjuMXP1zF51
         Tr8w==
X-Forwarded-Encrypted: i=1; AJvYcCXcXWDJKH0He6cQE+U2VATeAD1koBwgLE9yYZjDqtQvXcWeAyT0vkvzCdT52n0IXoUZ2w5YwwmfrtKwtKo=@vger.kernel.org, AJvYcCXnkNZDo546+w3/cA5h+AVIWJgLYCMjkGcTL4yZkV+N9L2RY6Kyswc4X25RePkakBmV0NJH4g1u@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvIK+4XCfOsrDuTSNMBNFDWZknrVqbJVTFye33MH6DZfVKzMO
	tYJAOGYAkOIWg0Q5lniT53kORaDSkiwmYG5BReTIfY3709IJXgcd
X-Google-Smtp-Source: AGHT+IEXZF4elInZGptvZ3BAr7MuQJEACHuM2+hM84iovmGT61NAZ33NFYnjvGvc/67pq+k60nFm6Q==
X-Received: by 2002:a17:902:e80a:b0:20b:59be:77b with SMTP id d9443c01a7336-20b59be09c4mr171947425ad.6.1727768118478;
        Tue, 01 Oct 2024 00:35:18 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:18 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/12] net: vxlan: make vxlan_set_mac() return drop reasons
Date: Tue,  1 Oct 2024 15:32:20 +0800
Message-Id: <20241001073225.807419-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_set_mac() from bool to enum
skb_drop_reason. In this commit, the drop reason
"SKB_DROP_REASON_LOCAL_MAC" is introduced for the case that the source
mac of the packet is a local mac.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- adjust the call of vxlan_set_mac()
- add SKB_DROP_REASON_LOCAL_MAC
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++---------
 include/net/dropreason-core.h  |  6 ++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 09b705a4d1c2..b083aaf7fd92 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1609,9 +1609,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
+static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  struct vxlan_sock *vs,
+					  struct sk_buff *skb, __be32 vni)
 {
 	union vxlan_addr saddr;
 	u32 ifindex = skb->dev->ifindex;
@@ -1622,7 +1622,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 
 	/* Ignore packet loops (and multicast echo) */
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
+		return SKB_DROP_REASON_LOCAL_MAC;
 
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
@@ -1635,11 +1635,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
-	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
+	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		return SKB_NOT_DROPPED_YET;
 
-	return true;
+	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source,
+			   ifindex, vni);
 }
 
 static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
@@ -1774,7 +1774,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		if (reason)
 			goto drop;
 	} else {
 		skb_reset_mac_header(skb);
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 1cb8d7c953be..0d931a0dae5a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -97,6 +97,7 @@
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
 /**
@@ -443,6 +444,11 @@ enum skb_drop_reason {
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
 	 */
 	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/**
+	 * @SKB_DROP_REASON_LOCAL_MAC: the source mac address is equal to
+	 * the mac of the local netdev.
+	 */
+	SKB_DROP_REASON_LOCAL_MAC,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.5


