Return-Path: <netdev+bounces-222765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB9B55ED5
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 08:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA601CC20D7
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91A2E6CB2;
	Sat, 13 Sep 2025 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu3CWZJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C615D1
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743439; cv=none; b=QhdrkmiEWr9nE3bsw+ES/W24Uv0Q8GS8YJvq9Z9RuD7kL+sPlaOHunOeco9bfjYmoOo4VOncSBLNUlsUkKeolU7XFZH1FSQqhLXw+cM51IocWK7AlH2KIYeuBS4ewjwoF2tvceCgtpX5vYYA1CblC/mPL6OdDNJjdVxyhhDQ/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743439; c=relaxed/simple;
	bh=ix31eSL81pFOW9vzIfsqnpRQ/OW4z+xiuCQH9UQniT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnEmkFm51FQd+6XVb4iIpsoklSW55RQK2btWT/6vVE/AyeTmZ2b0TlhGugArQL+qnDpx8/3maWNeoO/ybmFEkzB2+q/JWmOlm7IMPzyQDRhs3MFHJmIewvVfj5TpJQVq4nY8s7cuz4cbuOq7OegzTu9FLeRsvakq6MP9szibaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu3CWZJB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445826fd9dso31598815ad.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757743437; x=1758348237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41Zu+8Pun+PpMd8x6mUjfEY70mK6ipIOPQyqQYxTK8o=;
        b=lu3CWZJBKw3WJX2GSKt1JXsZg67FitL42bfcsDg+psVq8AmVO1mi9sjARyYlvckT9a
         w+tceOy40a8yRz/9RAspkZ/4fUBdIzwPZjPqI/LvjM4HkTEe/dCiGn/8hWe+C2PS/Ju2
         dLEMjGMbQATPpqdijYjTUPvzAwWdmZJJd5tty25J+noivjKErHmq9a3XC+9RfNqrH1C0
         qLmKvL8aj38ICSi7gCHO9j+WzY+zOsppzSgIDv8KwxedJpEhGqKd48LarTXrmLP5xc2f
         vlPJsAWD201OVL6Jkrev0cFDsYfy65UXHzGDgrtqb7PfafWjyL8ZVBKo70XGbQ4vZUk9
         Oacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757743437; x=1758348237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41Zu+8Pun+PpMd8x6mUjfEY70mK6ipIOPQyqQYxTK8o=;
        b=KURckbuzPxqmsyqzluBzG2lzVAx5BCag1Gykg9j0012z2HTGa0BluS/xYriEM1COSM
         LWKFg/wRgZkx0P+SeqkGG92NHt1G/2KwYYONCfNwI6iY22mTQmaOyswobBvVRxAvs4bb
         yScIBIOp2kOSbCtIiBSTGWIbvSZfeGp0dAniqCebtLjExGQYiJJvC53LUR26fC4r9g3q
         obl0uBuNUVjOp//69alkLneIniLybMJqXw8GciaPk59GbWc799+LhUNR99JdYS7CDZbw
         ldiMsbrjw2PR9N4rsA6DEgPDtHQ02FwGjOZ+SOnrf2s1bDLSq+zFt6KPsX+ZEAC/LuqQ
         d4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyCC06A3vwpnRmxhO0XWMEGa2vwABqVGLJsH1NqrQ8MyqD2IlAHtXXM+ZopgvS9x9fIbSu06A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIrHZCnD6Sc7TGikxWb2hImJLZLFOQpg5qwA8a0iHzOxQcQB3
	/j0aVraSWW99DzidulO832erlRzkH8ZxuI/kQaznI+0eDrBwJaR2YM/ZN0bMog0nXD4=
X-Gm-Gg: ASbGnculjL9hgJCbkxpVw4xPQ33R+92Lbf51cFM7zH8ki5Q46S2afMhbDnn8DejlgN6
	h/eqxxHfd9GT+Mxt0P1klfRI0NDeAWnFuHLuSonz6h8QjSIOr+w+aay/wXH6ZaNEMpzgI9ZGBJQ
	6PMHjTOe+ts3XdJPgSKi1yRkp76wpHgwsKHVrbFU+MzRIpB/GKD1Kuy9NbA0oqRQVFdL/f9WQ3U
	SrPAy1IvcdWKBO42iOh+S0/p+fLuv1OcWhQBTIPU4qDR17irkb6bF6yszQDYyWSGSFr8DKlNG+X
	Ouys2/usJ7tiwu29x4KnVTOtvHbNpcTeero7qDRd8CHI0Nww4UtE4WQKCTVELxf1OVR5O+nwUmj
	62lTgfnnqIgrswNEozjRlNP1SxFN70YsM8SqI9W18VR0KjTnusCMlSQ3igT1AchXF6V4=
X-Google-Smtp-Source: AGHT+IEAfgG7M/u2SSxRv4ShiDR+vJqe2T44IbROgBQqdm+3/74ZEJbrOuuf/pP7mig0OgSHGmTtqw==
X-Received: by 2002:a17:902:ef46:b0:24c:da3b:7376 with SMTP id d9443c01a7336-25d261781d4mr59102455ad.26.1757743437016;
        Fri, 12 Sep 2025 23:03:57 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae29aefsm66340855ad.118.2025.09.12.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:03:56 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure
Date: Sat, 13 Sep 2025 15:01:36 +0900
Message-ID: <20250913060135.35282-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`netif_rx()` already increments `rx_dropped` core stat when it fails.
The driver was also updating `ndev->stats.rx_dropped` in the same path.
Since both are reported together via `ip -s -s` command, this resulted
in drops being counted twice in user-visible stats.

Keep the driver update on `if (unlikely(!skb))`, but skip it after
`netif_rx()` errors.

Fixes: caf586e5f23c ("net: add a core netdev->rx_dropped counter")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
changelog:
v1: https://lore.kernel.org/netdev/20250911053310.15966-2-yyyynoom@gmail.com/
v2:
- Correct commit reference in `Fixes:` tag.
- Fix incorrect commit message.
---
 drivers/net/ethernet/natsemi/ns83820.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index 56d5464222d9..cdbf82affa7b 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -820,7 +820,7 @@ static void rx_irq(struct net_device *ndev)
 	struct ns83820 *dev = PRIV(ndev);
 	struct rx_info *info = &dev->rx_info;
 	unsigned next_rx;
-	int rx_rc, len;
+	int len;
 	u32 cmdsts;
 	__le32 *desc;
 	unsigned long flags;
@@ -881,8 +881,10 @@ static void rx_irq(struct net_device *ndev)
 		if (likely(CMDSTS_OK & cmdsts)) {
 #endif
 			skb_put(skb, len);
-			if (unlikely(!skb))
+			if (unlikely(!skb)) {
+				ndev->stats.rx_dropped++;
 				goto netdev_mangle_me_harder_failed;
+			}
 			if (cmdsts & CMDSTS_DEST_MULTI)
 				ndev->stats.multicast++;
 			ndev->stats.rx_packets++;
@@ -901,15 +903,12 @@ static void rx_irq(struct net_device *ndev)
 				__vlan_hwaccel_put_tag(skb, htons(ETH_P_IPV6), tag);
 			}
 #endif
-			rx_rc = netif_rx(skb);
-			if (NET_RX_DROP == rx_rc) {
-netdev_mangle_me_harder_failed:
-				ndev->stats.rx_dropped++;
-			}
+			netif_rx(skb);
 		} else {
 			dev_kfree_skb_irq(skb);
 		}
 
+netdev_mangle_me_harder_failed:
 		nr++;
 		next_rx = info->next_rx;
 		desc = info->descs + (DESC_SIZE * next_rx);
-- 
2.51.0


