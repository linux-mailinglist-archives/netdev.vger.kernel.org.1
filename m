Return-Path: <netdev+bounces-222803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DDEB5628C
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14038481803
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C221859A;
	Sat, 13 Sep 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzT1G6/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22950212569
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757788122; cv=none; b=ZXldXMs8bwHJhGCYL9TeP6XFFOwTiMg8dAQp6b/c7AeZjgYlTcPKszgPQq0OebZLW95xbxVhy6LZvqZa/CRU38tIdh7HVGn4R55VfPrN6AG8Ls7Qw2EMOE7+P/SvEPMWP2rp91lYe+RzGJpAqnVoFmFwPxPdbwbS9Z4GlhLwkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757788122; c=relaxed/simple;
	bh=gKcQeUu8cSavcrreJY9MpCvt84gelAsJxkM9T047X/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvV3wmW5y6UF141ylljujQzy4qZONjhECHSFh3VP+lX5WDGVM3Zuoj96inVePesmEI8Mirzn+ViGyUcBtHwNARu+wkSkmKbLhOubnd1XbCabF9ltf2jgBd/k0UB54QteZBqZen7Oz826RGIPbE6qIsTsPt+5C76MznaGIUzYNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzT1G6/c; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-72267c05050so25427647b3.3
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757788119; x=1758392919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nCFUKUNYumkIxFj5PydzJTHinQbopV5LDcYIB4n3Xw=;
        b=bzT1G6/c0AAIXet2nYBXQaLljAsfF8Zq6D65Vn5p3UcIMA7rRypprkWZFwnUMADc85
         UzcNU8eQ1XC+NVvF7U0w71cJcXixrY0ql2mX8CfgVO1aRWbFR3OXjya9H4fp6W3HFaNf
         /QBjyxmc+nQQ2Hk8AqPrI6U8e8ubXmcYweenKH5PYLVThL0r26d/u9R6Zl60OngRxnsP
         7XU2x5uKmhvBagMKK6fo/qpC+O4BEsyZLDZWENHv6NuFsOBSZShqGb8dYzddAkbt2nOd
         BQ8oO4OkwcX8PkomvPRB88mUnR/2R5iQoPgkXJW+mkCFUISpMRzeFO1i1tPbcgIJIpL4
         6QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757788119; x=1758392919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nCFUKUNYumkIxFj5PydzJTHinQbopV5LDcYIB4n3Xw=;
        b=URtqhk9FpWCmjdWx67/xFPYbjtoAflt6P8v5pI4Z2sU26FO3TaS3xqphvo/m3fm1Jx
         ZOOWUuvlm3ZgON8t2qUoXdB6iwPV5ZK67iMLH8kdqsAm3cMMwLcwDGUVWWHWpJ1coc8R
         X5BL2vBJHAdtStuNodj+DwwdSbwVIOXovd/peZZLYSCxpMdDUQdfFoGUqCFbrfpzMfVK
         U9k12aA2At+jFrJ1I5oLQHqyDCoHYQdqRNs3EoOB8JYYsxnMSPMi571Nd8LeuPkMM7hG
         53upyzSUcxjSMUHyxNHLcobzzcBGQIBhHATCOquXUXkZC+8WR5hExV3iq3vycShmTFfk
         MeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc2N4pwkvEdEFX5h7qYmXuYtkDEhG9fvoQEh99i4ozLGGI9E/u/wmrO4JNqi4ZS1CKAGmdLE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKJgCXkogCaX26I2GWeHE4m/f3SfvQiNOg4mPeESJYbpkvBPe
	uG4XiAknw7kUwv2MdfmD+Wrc0O9JTqjpE9MwbsG+eN054ZTfrrgJXtvc
X-Gm-Gg: ASbGncurY7uNsknw6LT2GSbaeAAwWBZdKegy0bZ4c8lPtGWjs9/xfBJUFXD6vuoccLI
	v8SApZvHvMJsRvnPT+JJFRUsFYpyq9DN8PfXc7xR98lMZDrFEfRsGtJE9w9QbQP31gT3TSSFLKG
	fHlJjP1dhhpEXPzAu6nSULT/talGZeVl7aO/7VLbxaXTjkmemJ12n8aTF0YO0zlguinVhYH+GCy
	R10dqL2/rS5vdVMlgPwPAn0CU9OW2X6Nk1+bN5N7IqR4lElCi6fOdNJrLQXeBpFN2q6FcE2fimW
	6nLS6TzxioWx7vemGBf9BUA/iyOVxialXIOk9zyxOukn4784zpHoA2f+FJSxTWcUT3JDc3DKZQD
	hqg++vp6+5oCsR8wIb01NASg5nxrR4qQHSTjPYoW8P0DIw8RIb49CYhz7BKzJRMIAv9FO
X-Google-Smtp-Source: AGHT+IEr6TyIbto1lC165e2SsnhAZ4im9LgfNIlYS/9s75aaY/CPhmgjgyslAAEUaftUYJeDHyRk9Q==
X-Received: by 2002:a05:690c:e0d:b0:71f:b944:100e with SMTP id 00721157ae682-73065cb1982mr69611127b3.53.1757788119092;
        Sat, 13 Sep 2025 11:28:39 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79a8c8f7sm19966357b3.69.2025.09.13.11.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 11:28:38 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Andrei Botila <andrei.botila@oss.nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] net: phy: nxp-c45-tja11xx: use bitmap_empty() where appropriate
Date: Sat, 13 Sep 2025 14:28:36 -0400
Message-ID: <20250913182837.206800-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver opencodes bitmap_empty() in a couple of funcitons. Switch to
the proper and more verbose API.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 550ef08970f4..fc897ba79b03 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -926,7 +926,6 @@ static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
 	struct phy_device *phydev = ctx->phydev;
 	struct nxp_c45_phy *priv = phydev->priv;
 	struct nxp_c45_secy *phy_secy;
-	int any_bit_set;
 
 	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
 	if (IS_ERR(phy_secy))
@@ -939,8 +938,7 @@ static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_en(phydev, phy_secy->rx_sc, true);
 
-	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
-	if (any_bit_set == TX_SC_MAX)
+	if (bitmap_empty(priv->macsec->secy_bitmap, TX_SC_MAX))
 		nxp_c45_macsec_en(phydev, true);
 
 	set_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
@@ -953,7 +951,6 @@ static int nxp_c45_mdo_dev_stop(struct macsec_context *ctx)
 	struct phy_device *phydev = ctx->phydev;
 	struct nxp_c45_phy *priv = phydev->priv;
 	struct nxp_c45_secy *phy_secy;
-	int any_bit_set;
 
 	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
 	if (IS_ERR(phy_secy))
@@ -967,8 +964,7 @@ static int nxp_c45_mdo_dev_stop(struct macsec_context *ctx)
 	nxp_c45_set_rx_sc0_impl(phydev, false);
 
 	clear_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
-	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
-	if (any_bit_set == TX_SC_MAX)
+	if (bitmap_empty(priv->macsec->secy_bitmap, TX_SC_MAX))
 		nxp_c45_macsec_en(phydev, false);
 
 	return 0;
-- 
2.43.0


