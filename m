Return-Path: <netdev+bounces-133428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA4995DCE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F23287471
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E66175D4A;
	Wed,  9 Oct 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXYckZcv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E61714A4;
	Wed,  9 Oct 2024 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440986; cv=none; b=Ia1+GL6XcYAfIB5qa6dECsB7U4xBK+bXjxF3+7EihmCQX/F9Bo28SD1ZlNqoiyvr4RKr4jTE0bzwRJ26twIU+/nkZ3YWeLAC92IGR/Gehd+gTkzbFwdtXZyDP2MbtZUibe1lk2bMMAW956CY7jYY872RcuvPp5jowv3+dGiYRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440986; c=relaxed/simple;
	bh=4xIH7Aio0f4PBcaIE51Qch3dJo9N/MMWAobYuTWQmmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJH2r1lw15FJavvzHv9PUiRuM6pAgI39sYLa5FLBTQQK0zLDud+MK1NqL9ICYOtZVDjnc10AVoQ4wbLwUfffKviP7sdCK79h8ZfLvYkid+/Ss1Am794hbVhbhdqiXX0Z+crfgDL7BHE6t+bCx3fAWTeeMredVGGUoLpcnFLFjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXYckZcv; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e28ba2d96aso1048820a91.3;
        Tue, 08 Oct 2024 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440984; x=1729045784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQoyYqReGxg6xit/tJWU0LNVGXnn5CuHq60bShXa6OE=;
        b=ZXYckZcvmW0zYSipoRbGkTd3wgOklMtE2PPJA2v4nMfybHSMCGWw/JPZjSApcIEnz0
         ZmKlpOoOu9MuCKKM1Uh541j7R6abQDwVMI+fZsyKaWOkoNniuU6P2cEp4wVg4i+F9fHv
         qw8V7YwxDvA0IGy6lu5bHX6s+fK4TZ1ADbWXsKTgH4cJGOs/zdYDzUi2yPaGP0oW78je
         4F4v8ln3FiE/tOUS9AyQqnmt/nZLAMV7fxM+HJ62OVMB/YRSgI6BsHRfC8vct7ZCoKGM
         JhKjlf6M9cyIk1itpmSDWhL643OZocFgaXwZ4HoVXMue6he4vYYC3dKSyawafIOeFGg2
         aJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440984; x=1729045784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQoyYqReGxg6xit/tJWU0LNVGXnn5CuHq60bShXa6OE=;
        b=BCDYyhgulKidS+sxvnHwBqELdKSkjrtyKDsCDXNEKeA8jFqY5QPtLc6cAHM85PmoQv
         10UqK+k+WHwIG3PtaWvaSjXFKrzwZYwBjKIrK5xQSFYMlw7s7mzLvdTMC1fsQNjOdubg
         x6+1f2hDTo6QFempOCAlU6bo2KEfrZErComszqyRugqw/MNDHqKuGlO+4kgDmoxs7ezm
         fnmOGGC/ZB5GcAqSk2nAP8R4fe3kNZBrxtFjJ6TQ1DCvJsq39EpI9kGcXXw/oHHK5wiS
         syS7IDY+Yikmnaxq4Me0KKhpXcT9fif0v3zk30N+iYaptdJANlI7pfAo0/qY4r/dW9V5
         MwGw==
X-Forwarded-Encrypted: i=1; AJvYcCUaKEFPwKxuauTC5J0yjWUknAsTaowGVT4T97+KldZb3F368F+CIf4PjQDXxifyBRHU8bkn4vB7@vger.kernel.org, AJvYcCUkvE9Kod1WWdAIUazXLDi6GZNpXV4dIc9bTS8L3BSaJfB7tiumzYoQMPlG7JuKRENGFAxDzWbf2Cbb0yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMwrW3KbQRixb3V6qh4Lv7uKKkZaLecWJ2Q3WJMTSLqDZKsTm
	CdOK3WygIN9m5N06cL7vkKq5EzqKTniVv8wGbh/eBDc02Q1SnbR+
X-Google-Smtp-Source: AGHT+IHcvi5PnR39Ef4kXioKWX3qb43ZnLATfsF6eNlxApMNwEwu+bMTSMCk3eLp2HYAFibQTy3OYA==
X-Received: by 2002:a17:90a:bd97:b0:2e0:a508:77f2 with SMTP id 98e67ed59e1d1-2e2a2525fb1mr1226791a91.25.1728440983919;
        Tue, 08 Oct 2024 19:29:43 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:43 -0700 (PDT)
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
Subject: [PATCH net-next v7 07/12] net: vxlan: make vxlan_set_mac() return drop reasons
Date: Wed,  9 Oct 2024 10:28:25 +0800
Message-Id: <20241009022830.83949-8-dongml2@chinatelecom.cn>
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


