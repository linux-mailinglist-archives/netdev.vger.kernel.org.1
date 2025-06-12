Return-Path: <netdev+bounces-196840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6EBAD6AFE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC0D1BC38BD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F13222596;
	Thu, 12 Jun 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KodJYzWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E02153CB;
	Thu, 12 Jun 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717473; cv=none; b=NIw5xLxuRD5dm0eGOiz5qvtIPErj+v0yH9c3iknfivcMlt6unmvMeQE7AGeiCFfwTVnC9lOrtfD/BHuHg5iTtKnid32zauAnc4JBr/u5iAtemdd0/qHiRmyv5rgepprNMLbiCxgB90AFmnC1NNh+r4gfF+t/Fsfvq1xZi+8JQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717473; c=relaxed/simple;
	bh=SKX3n2KoR80sFyL3CjqAFbZXtMNIYMCK6lq2ckC9GpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDU+O+ed3EehPrLQp0TBM0aVrlhNdl5xMVLAxVGYMnelIqJU+MfvImGnioYdA7Awpc+ZiN3VWdo5Fgw8wdit/6Lv1QrRhfyzduTwxb+7/yRMNcAgcF6E13ViLwVTJaMPp5ufb/LgeiGxBV5nje2R9FtCuiGXnrFNP+7q8GrM7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KodJYzWC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce671a08so3660185e9.3;
        Thu, 12 Jun 2025 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717470; x=1750322270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5xNmkaWi31kNs6rrCrNFgmQp9qCyUxpgbVRh/iX7yU=;
        b=KodJYzWCojkYFBCJbBR1eVNJAUmytmnRq006OIDTrqyznFhzVL3Z2mXSpf8r1SNyT+
         K4DpFgea7i+jp3b+pJW66/4HprUCf9rE9jXqfFT8zZoIlM6C4RNGwaokXEGvDi7lwxRz
         PEsEGpPnW8ooOcmDukyeBSJ6WDe7Fm1Ox7cLKsRY04KH3822+MWNj7Z5x03aE/be59Hb
         gy9/finhNvxT5idFgilw02T1sqQhSjNnxzlGAq+s3Hh1yOq74XIVafvbT54P8YAqYgfo
         uXlDKrPT71etNAnDnB3riizyNtdwxxJCsiRH59VfL390QlL8aQRbSVw3aDVYRuU5mb6V
         3dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717470; x=1750322270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5xNmkaWi31kNs6rrCrNFgmQp9qCyUxpgbVRh/iX7yU=;
        b=pMXW1cgr4ZxdSWqCMLkBGdG+gEIwlzbHEUH0UbsA9Kmf/EW/vV2YUBaiMXfMKZWSo8
         ZOjE45J1efyJ9778EruMoK+G4TsEAulEQQFM4WAFG7xREo7xMSVXS5O/OsHz41P2n8+c
         KLaVRjav8rw0oVpO8twVUSlIaq/bVAwKfUxbBy+NuIqS4B+4IsQNU55HWutdUKTuWWQQ
         xFaw25foGAJ4PNhI65FQz6N37ztKmH43X6geDxg2d0JZ12QccBwY7glGsRWgqKKHwIZH
         kRutk//2Td7jJgKAWtTXvWIKHNIEsRHKdS8pXPKP2USg6tg9haH8YQ8la3/OMwwaagWu
         4UVA==
X-Forwarded-Encrypted: i=1; AJvYcCX8lHutJNh7gkodB47XxPd8f95pZj1ZU5FjQQWPCLc9wKOvU1EhnOjMAOQSelYG06CfG0LdXOt8r1nEm7o=@vger.kernel.org, AJvYcCXJ51nKS09ymO5WIjyYDbo+vu8Ys45JboQZTH4H7SD00sCfnmN6UArcwdWEQnTbZLjugIzDt3Zq@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmT3RTOoQB400RsM80AMhuqjaEvo0SUACFu9SVgfu5RgX233W
	o4r9hud5SJ5+Arqcov8FVKgGGRMSSQ9Jmp2dPvC468fQeUArVglb8Ou8
X-Gm-Gg: ASbGncsU7vhN3/I/02CRR+u68+yV1mGaHk9CK6B3GaAi3Jae8/5fRJQXlzro4yDqzXK
	ggQyGQj4dxE7trdgsO/cA2MI2siVCnFnppoVOUu+58XPRQ2eRZnvA+HWiFJlMXLx2ctiB+SJ0yK
	sl/0992hGamV2kp0F76pChSoBZnwFctgvdTHlQcp0MoGgpXrxxNZEk+Y4Co54X3hNI3cR9wuiNz
	UNBfA2EI889UX3legrWrfHNpG+hKbcogg6GrqJ1O1r9m37obUwrTnxcIX2ZaXCbQ7PMD7+noFOm
	hXex7wltJRdf+KW07GCq3OE7ZEqgmAbP55lzevsGIp3OUp/s7djkFnLeBQQhg1xHzXpbYha+RXk
	v+TV0LaUkt5XLnyH3Xp9TiOWJwmnuiGq6G14d2QuN2LWId3cFwgkIQ8k4S7aA1Fm/hwhk0TG/uC
	W7dg==
X-Google-Smtp-Source: AGHT+IEHHIv8NuVLbcZZ8JAv4BOM12zfMynMkKdvMKGpcsUDQS6Di6dzulDkZ+SzMZCqZfX3tx+6TA==
X-Received: by 2002:a05:600c:3b1c:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4532d2adaa6mr18267825e9.11.1749717469571;
        Thu, 12 Jun 2025 01:37:49 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:48 -0700 (PDT)
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
Subject: [PATCH net-next v3 01/14] net: dsa: tag_brcm: legacy: reorganize functions
Date: Thu, 12 Jun 2025 10:37:34 +0200
Message-Id: <20250612083747.26531-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
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

 v3: no changes

 v2: no changes

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


