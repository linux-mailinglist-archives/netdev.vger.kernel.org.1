Return-Path: <netdev+bounces-132476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDB991CD8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E7C1C215EE
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAE170A30;
	Sun,  6 Oct 2024 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPEQ8p4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92231662E8;
	Sun,  6 Oct 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197854; cv=none; b=b1mOtmBJdO/lEjOuZ/nxH7pil97rtDquVAeH5WQIyjiyGV8GbPt+JNyelRrztLnfpL//bCjdjUcl1OkArZ/7TNsNb/x6SfbpiG5m7gGp1BZA+vi1oincIBQMWc2im/9BUVhiVkT4tE5a6eIkaFGk9eCKcxb6WEWt8fuaxvck/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197854; c=relaxed/simple;
	bh=4xIH7Aio0f4PBcaIE51Qch3dJo9N/MMWAobYuTWQmmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nt+6dgVXcpMMI2YPYpXaSsYQoM5RagO3ZddAj9RYU+4EqfGYIRmm0L7EeU6cVT/iAu3xHhiuIq7NqHfNxl8EAVipteEZFAmpwNE2YPadSW6ijyyXTGcO/zIwvc9Po9Ii/7fZgDD5oG8ZtYqVyu+LyHFkESGc+uyQqmovhQLuxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPEQ8p4e; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20bb39d97d1so29392325ad.2;
        Sat, 05 Oct 2024 23:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197852; x=1728802652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQoyYqReGxg6xit/tJWU0LNVGXnn5CuHq60bShXa6OE=;
        b=IPEQ8p4eoYgmiWe7LWVS2qLBeF589xgohMveeq3R4OQ3CpiwCp+kaXA3wAks+ijxUh
         kH10UrRPPhrR3YnBCj+SoRa06FVgxHhvFmL0zHldDCE2ROhxssCWD2WsY6HYy1E4TRZr
         k13CAxIagEXZ8+UC93UMYVniMsUph0WNB7hCVvQj45hAtnqLFGaYkhPuNN2o9BgW0+Yr
         7ZOOf15q9+HTiXtuSry/cYyZWmmkd2L2/Vjhr+FosnQG2Uxo9QxnPwXrFxVsTksHU/Sx
         f29lbeQ12zELstPcJhMihI7pnXcIy8BwrCN0E0gcE3do2DVNydNDoBmrLj31iUT5QLdW
         GKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197852; x=1728802652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQoyYqReGxg6xit/tJWU0LNVGXnn5CuHq60bShXa6OE=;
        b=RW/jvr1mvZJ7nHHlcgzphJvoCCDgwjWJiIIqwoZbgY64tyfJs43zx4ZefF6rSnWYrB
         a4ZGaYOWJR0laydAfrkZwAThCIZzq9kW1DLJRXbQhWE/5S6BCtA1vMo+zLv7IHCw16Ep
         1VYZMtMrmJCj5BEF9TiG/M3h+xLFLbCqi9XqWwHBlNmGmQkh4pUr/TLaLHjXP+7hJMm9
         acey9TtkYt1poDNRVirkgA52K0DsQLFv6iigyxLfTed4J8QYIa1I8FCmTkl9A9ugtHP4
         d6NfOZI+J5OCsfGXrKbHCeFzJw1e5dj4uuaEFjXFRcYgSbQsRqPYIOomSwzl3pIlpj6e
         74SA==
X-Forwarded-Encrypted: i=1; AJvYcCWgSdAwIM3Re2HWVtzsaTuB52HAJZIV1bDuUvZyqQcQ8DR+UfoOx6XOkEGZCkANcUaKmnQqFmgTx1PGWnU=@vger.kernel.org, AJvYcCWgXE01d+A4wzG9SbCZgCQa0ftCruk51CratDYouJxJIAuU0xGFzU1v2yQjm4A/7Q4PAvYHFjv9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl69ZDP8wYd27hKq5+tfW0cpHkhPfD9zORpNw/8vNIdQfQF+Oz
	1nqU2sjcQSJ7Hs/Ezqntee7v/aEaBpMHrJqu2r70O4icHwYsevZR
X-Google-Smtp-Source: AGHT+IHZp64FJEgkxIjfb5hkwn93eyOxhXrd0JpIvjRjmLIKdf3Wrlpbxed7WIDkByJi9EMCr7yCWA==
X-Received: by 2002:a17:903:181:b0:20c:2e3:7139 with SMTP id d9443c01a7336-20c02e37166mr88595595ad.24.1728197851942;
        Sat, 05 Oct 2024 23:57:31 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:31 -0700 (PDT)
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
Subject: [PATCH net-next v5 07/12] net: vxlan: make vxlan_set_mac() return drop reasons
Date: Sun,  6 Oct 2024 14:56:11 +0800
Message-Id: <20241006065616.2563243-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5:
- modify the document of SKB_DROP_REASON_LOCAL_MAC
v3:
- adjust the call of vxlan_set_mac()
- add SKB_DROP_REASON_LOCAL_MAC
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++---------
 include/net/dropreason-core.h  |  6 ++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1a81a3957327..41191a28252a 100644
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
index 1cb8d7c953be..fbf92d442c1b 100644
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
+	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
+	 * the MAC address of the local netdev.
+	 */
+	SKB_DROP_REASON_LOCAL_MAC,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.5


