Return-Path: <netdev+bounces-194392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC2AC92CF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4D11884B0E
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0323643F;
	Fri, 30 May 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feY9z7gQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61E2356BE;
	Fri, 30 May 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620586; cv=none; b=sA1x9MVqOmtzLI+AaQmzmopIwTK4P9ta2Co1L0NEV0XKsbRCqJldnzAakzncCE0LSnFW3zPNJ/KEBeSKCeNBENzbyXbAsdqah+j0s9/jcI7jU8Iwg33a6damar6Ksc8ly0sQhb/N+jBChkeepFgUOn+JrjnNRstpo8oZRWUNF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620586; c=relaxed/simple;
	bh=qGVe2Sln2lZ5DS3oePmUPKxMJcRvUY0cyNNi+F8dML4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOT22nZytbyyTamigwI7LQjuVKrXCzPcztShvuhPWtNsGXYQq4gOXBJRMzy+hDTqBfqEpecMzlJLMCWGQqyoacm1wZERVbfPWpiqAlbFmBMgKsO7Ga3EPARm1CXksl6LvxRnAL/mvl7g5h96asHah515dQpGXJyStIkHm0xRUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feY9z7gQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a37a243388so1800872f8f.1;
        Fri, 30 May 2025 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748620583; x=1749225383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnpnZZGWhP/hvV842g4qi0Tkz5DAZ7+/3p++MdVdR0U=;
        b=feY9z7gQPQ2iTvR2R4z6Cs5reR2hamSlWKxGjBUU1HjIClVvjwBOUr0iahgQk/JYLr
         RZgxkOtDOjv7Vu/TPDX45+PM9Fi+5qmArDSF3/z94t7SiNYYDSc+zc5u5L5g7xsCZLGA
         JYOoQfXFc67Fcx0TLcOOrVGHnXWT5dPjD8jGP99Sd+HhGghkx2agFePI4DXjEJEnKyQY
         QBNwqtDQruSKZ+60grva0lZwSYX5ityAWBAQJiP7mRu8aqn8aU+uEU28GKewztGCO6i1
         3dk0nGqsGESrHM9e5pZrGXEcG3Y62tQLS19ZL4aycLPJcdV1nWK9ZjWsSli2iwOLnkfJ
         OXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620583; x=1749225383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnpnZZGWhP/hvV842g4qi0Tkz5DAZ7+/3p++MdVdR0U=;
        b=EH3ZLv6f/Zwp5fsGthhegs8D+oraaLKP/BKvj2L8HEwyaal0kIIc4x1DTT9a9RR5xt
         DAWhzKikltxU7CilVf3BElz2pwSMaW4MKqxEdqQ8ikmBwykZeh4HxQ5cQHDDNMVVEFIg
         wbYehg1RVM7JLVT5h8+po4Pm4tL2mxnGCfg0T9K18M8gjm2k5D6abhjAw9IrGH5iNtii
         1h+OxWevWnq6XakgxtsDxeI0Ize3qb+0IRyTAoWzS1T+CqIE4ou2TWM8g094jBng4sGb
         zPzChA0kPV/naPKjCOnJYAEl4tw4HD9hE5U0VHLfN9ylMpv8WW2QaonMlVtHA3mr52hw
         HNRw==
X-Forwarded-Encrypted: i=1; AJvYcCVzBNQgONx7IoxJfYwlyOzb1svAldG00/PXtR4cmq3bTD1PG0L4y98rI9WWpYyQg6XZvz56dDbr@vger.kernel.org, AJvYcCW5n7Z1C5mu3qDWWoQ5mzSc/FAFLqawkN+cOPq6TZvABCqSugNCYXiryTdIAPwyEbdwwAgHtLiINca9tHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRiAjU/8Ssazrm06x9Oy8yh/+ZxxE334k0lJgIEysPaNjjiTS
	WdfK58OC7FC6K63ky5+D5cV0YW1SJSzBrkBEhB7jyPyqmvZyaiYG0Hy1
X-Gm-Gg: ASbGncu2yZIhHHWIgbcaxJTgu4Wvfd3PZ+o9e2/otY4IWdIPhg6tI2/n9SCp/9HIFEd
	Z+Ybz8ENkLVSN/uOlR1D/ewQnVDPGmzS096B5gcUe7OBnudNfo5AdH+VH2jt4ojye+mjfNs+T05
	CFWrLtI1jYzJRaPITRkc60LnOp9zIt+63PKEFqn4F0OnzvntjSLp7iKuqT/U5yUFkI3nasET+6R
	P3959s84BWBxgG+0GBXum3jZr5RngF4Yb57SJXouDRA0LVEA6SEo9IeN3soelt7W6GSRgGpSiO5
	4xRu2qGmaLqgQxs05EyCJnNgj3AQ3yuLdkdKujS+7TH9vyu+h/EeKoUtTqesNwZvDAej4hnfQBb
	y//TgMK0gXOW58E78qFmWCPIkClPOWxrFgiAsnroTfSLf9XiVIEx0
X-Google-Smtp-Source: AGHT+IFNrmg2n+vN69MjRMnwxa+hRMeHs9gY88J2oVbZ/UsT950YPnDzqxZXPFUd8PgrykvJm/+05w==
X-Received: by 2002:a5d:64ed:0:b0:3a4:e8c8:fb9e with SMTP id ffacd0b85a97d-3a4f7aaf9d5mr2779502f8f.49.1748620582536;
        Fri, 30 May 2025 08:56:22 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm5211620f8f.53.2025.05.30.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:56:22 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] net: dsa: tag_brcm: legacy: reorganize functions
Date: Fri, 30 May 2025 17:56:16 +0200
Message-Id: <20250530155618.273567-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530155618.273567-1-noltari@gmail.com>
References: <20250530155618.273567-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move brcm_leg_tag_rcv() definition to top.
This function is going to be shared between two different tags.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 net/dsa/tag_brcm.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index fe75821623a4f..9f4b0bcd95cde 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -213,6 +213,38 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM, BRCM_NAME);
 #endif
 
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY)
+static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
+					struct net_device *dev)
+{
+	int len = BRCM_LEG_TAG_LEN;
+	int source_port;
+	u8 *brcm_tag;
+
+	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
+		return NULL;
+
+	brcm_tag = dsa_etype_header_pos_rx(skb);
+
+	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
+
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
+	if (!skb->dev)
+		return NULL;
+
+	/* VLAN tag is added by BCM63xx internal switch */
+	if (netdev_uses_dsa(skb->dev))
+		len += VLAN_HLEN;
+
+	/* Remove Broadcom tag and update checksum */
+	skb_pull_rcsum(skb, len);
+
+	dsa_default_offload_fwd_mark(skb);
+
+	dsa_strip_etype_header(skb, len);
+
+	return skb;
+}
+
 static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
@@ -250,38 +282,6 @@ static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 	return skb;
 }
 
-static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
-					struct net_device *dev)
-{
-	int len = BRCM_LEG_TAG_LEN;
-	int source_port;
-	u8 *brcm_tag;
-
-	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
-		return NULL;
-
-	brcm_tag = dsa_etype_header_pos_rx(skb);
-
-	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
-
-	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
-		return NULL;
-
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
-		len += VLAN_HLEN;
-
-	/* Remove Broadcom tag and update checksum */
-	skb_pull_rcsum(skb, len);
-
-	dsa_default_offload_fwd_mark(skb);
-
-	dsa_strip_etype_header(skb, len);
-
-	return skb;
-}
-
 static const struct dsa_device_ops brcm_legacy_netdev_ops = {
 	.name = BRCM_LEGACY_NAME,
 	.proto = DSA_TAG_PROTO_BRCM_LEGACY,
-- 
2.39.5


