Return-Path: <netdev+bounces-251258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C194CD3B6BF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CA13096D61
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9039282A;
	Mon, 19 Jan 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkRh1CPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996E392C2F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849238; cv=none; b=CO/Qrlp+o46Y+a0Xo3FFsNhB3AanXhVAJ/ngPmPDuRBV0+8EWI15ZV4TsBItY1K54HPf8hLEBiF5OCiVbaI2InMPg+HhSh7mvDGoRG7XDURPxrBvAc3TGUnCOriExrSYat90WFZTCb/7DfPiVs2bnozAgzJeImlymQhIBKyLRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849238; c=relaxed/simple;
	bh=qLMIT8Ws33pYlSoHCrt/RVncgm7aYhmOwxAU9uVlwHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuXBxTVOMv4+gf1rLf5flPExfwKnx93On8aLX8xQ6xbg29E8NhSpHSCRBc9Pf7M+vbkMuMwNw/adktkJ3uUZ3VhObdrqdRi4GzPJVdP//Kv0WhY59mwIH60NbR5xNc3I5AXcTi0OCaS8sbBAhUB4BfZwEY9Z2xtceiHqVlGKw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkRh1CPt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f42a49437so2267675b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768849227; x=1769454027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7W4ETZqG8skHoTE538RFRAe6Lb7JM/auRjP6xeCdlU=;
        b=lkRh1CPtM851nXsN7D3FPJoIWq0VMB8vGXyCizHLuO1Qgt0LdwbD3Ek28gZGolCCqG
         UqPHdqOfQwsM8BHPH8HNYssgDfjE58/d3ynGtCa8K7SDZxth67M1l7NKWx6o8QP274mx
         QV6BiBPklPrqboG0tHUmpH/PBNWH17XJWUQA/XTQuySy7ff5MJCC/H7jYDS3zNpVRNXx
         ahG4kbrE64jXpia2M0gi1jVJ/TXS+puV/LkCeEj33UK1e/kakfPJv9gXtEJNPdH6z2Xv
         7HgWMEpWUhmuv4H5Zk+zlIumRXco6qGxCSy0t1RROzsx37lXBI0+gY2vgsMEKDOcOjR6
         Gh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849227; x=1769454027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7W4ETZqG8skHoTE538RFRAe6Lb7JM/auRjP6xeCdlU=;
        b=RphaBnHCJLqq/ixC0Pi1I1uG5sHHRutMrUEa246PKhFgTn4uPOMYfhUi4+6rlGvyzf
         2BV07kQDo2sGyaSCRy/vZfV3+SaGZOc60q8loOUf27fZayMwlp2B91Ha8qc95/cKGg0a
         3pEYForaCEKO18i8tShFxM+0To3jA6SjkPl4+q0GXkqS7xGR6wpOzWYfl79oA+Bn0eeR
         X7Xpon8F32yY2QpYWPaGx448ZHfRNrarPkwy5DewkGNuctuRlxJlDE8hn2C2Rg9gaT8F
         85akW5yU+4OZV6GDOkmR6HGhR5n1Sz6e2xhXEtexMwRn2/XRqJEAQWCf0glfkurM/hw+
         wgLg==
X-Gm-Message-State: AOJu0YzgxZ1bRxjxrDGOysMPcTA0YfVD6HuoBE45iW5mR2IcrjXUXsHT
	aEisiB6Q+rZdM6Z0HrxmFdI9eZBnzrB7iuIyPwJIc5Sg/9TxOBBFL+GoG56L5A==
X-Gm-Gg: AY/fxX78uYuJ9rx/I2U5RMN7m3H3Hl6cw8TFvp+GHeSaHTOafqFUQxWM6ZUCh8EnBkb
	qdbVg6GtfR5LNIUCuaCoC5MmbBEASRi2OmQ1FLoAGlNuEMMiofSlxmUpq5J22LXbTo0otFe219c
	KDeGOvAYvEn90RT8ANyN46Dc/mRJVj8cnsjjK/cQA2MAaoyz2JwHFdlbWdUwjtgupehEMycv4DQ
	YEBZPXvJn1+KLj47viFsTNW/2VOhsPFiSzCp4az1gQGUbeaxJJeiyNfVaZ7aGnuJ7+I53dfGvio
	YRxVGXMko6USvyUyFoAPt+6Xb4oMN4VWXF02S9mJlFQzQsY1axhlssZchbRZPhmTzpEeHL/KBFg
	3HbqmFd6bCneKyTWjorP1El3NnXmhrSwjRPdpuiN5UwfaoQEW+NeknFLL37ahTtSKvYsuociP9c
	a9ZSkUzDa1w2dE0g1bCCPdkaIvQXcpkwkxkIczQRNs2s/cCYjAWg==
X-Received: by 2002:a05:6a20:3ca6:b0:35e:e604:f766 with SMTP id adf61e73a8af0-38dfe56a032mr11849536637.6.1768849226442;
        Mon, 19 Jan 2026 11:00:26 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b24sm9677431a12.28.2026.01.19.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:00:26 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: tag_yt921x: fix priority support
Date: Tue, 20 Jan 2026 02:59:29 +0800
Message-ID: <20260119185935.2072685-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119185935.2072685-1-mmyangfl@gmail.com>
References: <20260119185935.2072685-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The packet priority is embedded in the rx tag. It defaults to 0, but
adding DCB support to the switch driver will break the tag driver by
setting it to non-zero.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 6bbfd42dc5df..b93715a057c7 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -17,7 +17,8 @@
  *   2: Rx Port
  *     15b: Rx Port Valid
  *     14b-11b: Rx Port
- *     10b-0b: Cmd?
+ *     10b-8b: Priority
+ *     7b-0b: Cmd
  *   2: Tx Port(s)
  *     15b: Tx Port(s) Valid
  *     10b-0b: Tx Port(s) Mask
@@ -33,7 +34,8 @@
 
 #define YT921X_TAG_PORT_EN		BIT(15)
 #define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
-#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define YT921X_TAG_RX_PRIO_M		GENMASK(10, 8)
+#define YT921X_TAG_RX_CMD_M		GENMASK(7, 0)
 #define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
 #define  YT921X_TAG_RX_CMD_FORWARDED		0x80
 #define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
@@ -98,6 +100,8 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
+	skb->priority = FIELD_GET(YT921X_TAG_RX_PRIO_M, rx);
+
 	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
 	switch (cmd) {
 	case YT921X_TAG_RX_CMD_FORWARDED:
-- 
2.51.0


