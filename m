Return-Path: <netdev+bounces-197719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E18DAD9B15
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB221898AB6
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621F1F4CAC;
	Sat, 14 Jun 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPbHsoKI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D071F30AD;
	Sat, 14 Jun 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888008; cv=none; b=Ckq8IDz7xvsFbgNLZYr7IzUSVqdUKqh12MKZNUmozq8lJ8xvEdr1klM61BdZDSYnW9Zg2Y/kQRRXHDNhzW9Pu8i4D1wiGIROybKZTQBnhhNO+xTPw24ilyQhsyiLnC3Js/A+GdEvughm9XFEgZMzqmUszlIQMj+7zQB6AL5+hIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888008; c=relaxed/simple;
	bh=0zq/TBMQ0h6/euIYrbBmM05NhQPI9XGhBj8ed7ggSEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pesr/9cGtRdkmVXwO6rhrlmL50PCMsxIaF6XngaK+KP4LMqKUoJMPLHv5ML5XGNTyfG8wSRpWP/AA2P2pDtxaW/hvQH2rk34BZVGp7VVZ/8bkzo65j3BvdrrylaoyZYEcHsvewmRCoW+sLn9KLZVvCzxQwCAP2m/RRaAPF3/OFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPbHsoKI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so23680375e9.1;
        Sat, 14 Jun 2025 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888005; x=1750492805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2mrrQAJP2ZT0f72PJf2BD+Zq1hLndIkmyPUWVMOj4U=;
        b=bPbHsoKIATv7CXeBYYytCYBupLfp42sO+k5CiZKrBsHKFHgSwvC0cNtQFwsriEKItd
         DbxJLPE7ZbsvmKF4fb45oz32qGrDwNSp6Qo7STrajtAeCwbeU8+NgNxjSOvqZQN8mhSd
         U9vDgzVBAeFOrAmswro6pHMd/oQ6XwFVjjt3G/8Pw5mYtvxYBA3YlNa1CC0G9KofphUX
         4turq8QuJjgRBuZt1BxYpS9rFWm6Xow68lX2RgFOW2aYxEYJ6WsYOJrX3GP/CSEEbkrN
         lI2aQ+9pTZaSb/KoL+Tk3A3FMbCQTcnWf5NQA2j7os3AalrDSBW60/zg22nlkpvPJnVW
         wRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888005; x=1750492805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2mrrQAJP2ZT0f72PJf2BD+Zq1hLndIkmyPUWVMOj4U=;
        b=nXOnbnMr+d3oTUgDiEgTnqNl/Lp65PJG4/fpBHMaPUOYcJIjPfHLsK+Ctq5zg6RnEC
         fONVpDRN92JtIg4RlQSB1Py0J30sIkDjqzXytnoEOHO6U6nSJ+DlBd3R9auXAeaOkbEN
         qHkv6LNzXZiW3vhWp9fsiYTHVQBuVoSZaIzb5ybnf0bJLWeKlJ6OP5+KbwPGbpsyt1pj
         /Lj6j90s9SWs7Vg89Z0HFQXv+qF30KzeYj66I7dmK5tkPa7D2SmGiWEgP7zVWW7GLcEK
         1q41OaxgVsr0stmq3amLxwL38lLXda88hUse34XOgd3qK2948VVaSDn8a+WpFUe2eDFq
         ggoA==
X-Forwarded-Encrypted: i=1; AJvYcCV1TpFRO4xPnRq+G1fLXlKbo19Mqp+4rOti2WBIRI5p4RH0bvFtyL9tXgZlqp7b6UKXM3JVbmaobrCyG0w=@vger.kernel.org, AJvYcCXNq1rQ4RF1GWOr4DYLI/CmjvnSccGF6+o4oYv3I3r2o9QaGKkgEGsGceNPqjYBwHmIaFd3VmjD@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsam/DIo94JaRwwzfOjuQXrG4eqQ43sI2b4sL2daNgLZ8WfGP
	LF2dsvFULmiXUEvdsz6CdvbgsMKlW/zyOvf29N3NuGzJoGtP+qd7MKsX
X-Gm-Gg: ASbGncs7qIZgvXTlse2I8wUT1yFlvtqnUvRD9DV6cXEbAw8XCCcHSzf8YwhFED9QYyi
	xHp4Ux7dZYcrZ37kF2qfy1a+AtpCxeWFIQ6yT0f0rc7t6DWZq3OE5VADfXHkySPQV0JdKRW7rgd
	7mIwYxSTf5QGwWr+3RphbQ1g4ohOKn9yDp1Lyh9o32A30u9U1PvssmNGLWTj84NxVxQsIWgjoX9
	a4hXvymBAVq8OVQ48FxqIWUDaTJL9drN0p3RU1uYqetvMut0I1EjS3tNxgt1tRxY86+kOFjqUWc
	fTMtXBQHv5ZfIT7/lFG7cmhIY08QsXpSbkoO80Ywbdb+R+ySNZQacXdSDAOT4vyzkqvFKPIJwSP
	QBxOzgbM/qRf0SvTi8k3We9Kls+Iwisuw/+/Tgoz7FIuond7QV8Hw9NV40mgGTCI=
X-Google-Smtp-Source: AGHT+IE7mQE+jvBl8Tin5bL2po4lvYhyUmsLvlHwqbaV9ncV5YD81UfnXoofYrKq/uso8iHGuFhnvw==
X-Received: by 2002:a05:600c:1549:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-4533c97c5eamr25773535e9.16.1749888004695;
        Sat, 14 Jun 2025 01:00:04 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:04 -0700 (PDT)
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
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 01/14] net: dsa: tag_brcm: legacy: reorganize functions
Date: Sat, 14 Jun 2025 09:59:47 +0200
Message-Id: <20250614080000.1884236-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
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

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 net/dsa/tag_brcm.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

 v4: no changes

 v3: no changes

 v2: no changes

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index fe75821623a4..9f4b0bcd95cd 100644
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


