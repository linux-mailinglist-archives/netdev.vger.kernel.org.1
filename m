Return-Path: <netdev+bounces-218933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BEB3F07C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF682C1068
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42427AC43;
	Mon,  1 Sep 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLTNODoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7E221577;
	Mon,  1 Sep 2025 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762231; cv=none; b=U+CoHj+vv5ujFFWpBfl+E+cg5pEGqjE2GN3HiHm4y4TG0Yeg6zPSM7EhH6UvRVsDF/S41w9bVSuuAEkUqEAMCJz9fEFf694owt9K0Kr2dT5UhHor2GFQP9WaLaNMq7VEXs3+1d+V8lbnG5mwOl5lSchS81Iuw5OTTaVg3HjEe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762231; c=relaxed/simple;
	bh=dixjbpVuLrXLiVP7cOFBX3iJXj87gNGhR/B4QJGUIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eAgqSwuz09fpUPqTyp2L2tzDNFOMNVbZ5Chp2jbCeQHBehjnOygE5aLfQT0OyTFIljiwtHFxLNXZmgwbDc9BGWRWY/oxGT7s67Hp+5PVUuzn5dCglFyWBMKWrltv0MYeFM+3SmxaTZ/TQSc+3AEnTuph0ypQ8rO3mFt6wOxtbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLTNODoY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so3861882b3a.2;
        Mon, 01 Sep 2025 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756762229; x=1757367029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Buk597jvrgQ2xs9epW7IszzJTNW3HheS0YxncjEWE5o=;
        b=SLTNODoY1i9hqssKVsGn7dUoKCJwrO7nRGFJQv/d1SWIEqk0ddGMXEYR1wYxY8ZfDn
         vp6W5lKvbgVfmMQ7p77B0GJb0oWPS6nNrJI4nYytcG6XLQ3lUeC6B3b0YfUAWNPCaHmY
         /uyFfs0gogN5UfeWDZU2nzdXnPxEU6JsMxP5fL+EbJwfWtT6MkSmTwGyqbq62MtsnZuW
         UJzYMaj50eLAuJZY7cvGNXtdV42ssjCpa7QIOhKolQbwxBpi0Dqd/xzQU2TIJszpGeoY
         Kofb9XAzBme9VYe3cvJ0NO6F0r+boagH1UOJUHYzXln55FcxtRDp0To+KffaXQOEJm6j
         EZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756762229; x=1757367029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Buk597jvrgQ2xs9epW7IszzJTNW3HheS0YxncjEWE5o=;
        b=jg8ghBjndLS6VXJqenijDvkCC4zovS0+xfRenY0kypHOA6+zvD9I63WgF9NfUW7cAD
         ib3HzRPV90SlsxA8grqSvpYPClTy0NRni51DF5eS9yD//cJGMCZr91T1uHMEjh4nAjuE
         xbo7l9XtEXeKhIiNKRSKkwvtND3IWq3C87OrHQ1JBklpFKxE6ebsHOxOSckXbB8ipGc0
         eyOgZMeowF+O8EFmBllHaZSvSn1XkimNWWXnG4gAJj0utdipL4hc9Yv+4X+cTBe3nAv/
         jM2veKpzhdTHIVHnybvZzA4k1SfOsilAasPUNuYakN8U5juTUIaozD5lplD/pDqPDPGZ
         GtLg==
X-Forwarded-Encrypted: i=1; AJvYcCXAP31X3og8RLIGCLIfUMNcgFw1zI8oferSyckXEQ2UBz2vCxUyNfsonwakuq2P/el8mVjaOgeQ9+MvMaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpO0/K+nvo1MB8Td/WpA1lpIWqWqAeCm3jGyqFBAejC1DRU/x
	IZ/6knVoi6/StJL4ESWHsndCSn4f4rxV6u/+HcTd61el99uJ1XLWu5aRyzxqiQ==
X-Gm-Gg: ASbGncsRkHn7cs1Z4WIrw1dpCWcKm8bSP7XMErBINMUa1MW/QB1fmeS3TeXQMUhjKbc
	OIafUXgpL1Tw/0grf86wWsaBNNiAiX0EfBL6X6wTxB5Lq+eMdb1Bgtv+j6IEGRTrtKWnyo92LO1
	uatk713WBkaHuiAA5AD2d8fQaOZjD++ZRgcDViSmCYfQEaoDjoJEnFQc6KD4xrf12CELwQLp0Q+
	rtC85VlFfauypq5Hxui8y8M+XR+sxGfgX3/uxmKVwcLUqY2LOJVHCyLaBPUhIBVk/eny/OdxY/B
	AE+DDIKT3ay+EK5xeANjKvgo+HTjxZx82t+HjLOs6dW6sqx4M9WbVIAeryy4tX5BjNzpuS6qPhp
	X9kt+H6DwE1WnGhe7bh5yAhr+IZwGOpfCMYRX/fxNLy8nE/WzuK7t3Io+AAvk3KHggq6FhpmagD
	ZvG3i9nA==
X-Google-Smtp-Source: AGHT+IFN3sRBrYv7sa0/dX4BXu8HUXYGyswj8+xHvnww0Gcrn6J3aKcCx0FqnyXWEbmGXU3N6SSy4g==
X-Received: by 2002:a05:6a00:8d4:b0:76e:99fc:db8d with SMTP id d2e1a72fcca58-7723e1eee4amr9456360b3a.3.1756762228931;
        Mon, 01 Sep 2025 14:30:28 -0700 (PDT)
Received: from archlinux ([2601:644:8200:acc7::9ec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm11594055b3a.92.2025.09.01.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 14:30:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Daney <david.daney@cavium.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: thunder_bgx: add a missing of_node_put
Date: Mon,  1 Sep 2025 14:30:18 -0700
Message-ID: <20250901213018.47392-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_np needs to get freed, just like the other child nodes.

Fixes: 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/ethernet/cavium/thunder/thunder_bgx.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 90c718af06c1..9efb60842ad1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1493,13 +1493,17 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
 		 */
-		if (phy_np &&
-		    !of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
-			/* Wait until the phy drivers are available */
-			pd = of_phy_find_device(phy_np);
-			if (!pd)
-				goto defer;
-			bgx->lmac[lmac].phydev = pd;
+		if (phy_np) {
+			if (!of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
+				/* Wait until the phy drivers are available */
+				pd = of_phy_find_device(phy_np);
+				if (!pd) {
+					of_node_put(phy_np);
+					goto defer;
+				}
+				bgx->lmac[lmac].phydev = pd;
+			}
+			of_node_put(phy_np);
 		}
 
 		lmac++;
-- 
2.51.0


