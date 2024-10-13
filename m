Return-Path: <netdev+bounces-135011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D099BC4B
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E66F1F22FEE
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5B914F9E2;
	Sun, 13 Oct 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt4knkEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAC80027;
	Sun, 13 Oct 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728855244; cv=none; b=RB5av3v7ehTAHiRE9CUPOADygURLFwfLqUqzXMETB2O0EI6eI2qIMhBAptOjPPAFGubgVsIbFOQKMUzgRNRvRg8wHYggKklisC2XLgqz8Vw78BonOpcIKZO69YnEANy2Q6e4l32Sly9DbLbpE3ndfW8zvUc131q6gWnFig1Ib6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728855244; c=relaxed/simple;
	bh=zy9QIcZHwGlwMlEbmwL4jXr6ASVlwLHHZ48z3b0BAPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKeD8r41pOjnEfhKoyTE8CJz6zvBQG1g37p1RINjWE4/nig3vBatpOz1KWupGSMJnEgKQD+NE7ukiquV+gjsH0q8OpBrQPr8Kj79JZ5AL3/UopORquavJx4XBIt3/qBEi8Noh1vGr5Blqqsl09wCGO0lc/tOwYYbZllQwKQiTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt4knkEo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca7fc4484so13702165ad.3;
        Sun, 13 Oct 2024 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728855242; x=1729460042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nB1bZmyvGxTgHvpG7TUo9JYKjyZnq7O7z9cIIFMGfFs=;
        b=Pt4knkEoDHlmXGst8LBQ1oUJqo+4IRm/iBoyK/QApCRNwT41GMM6+iI1vRoMgHAvXy
         BYU2tpkApZv2H+omlB8GGEQj2HZczWIxLekRyi+Hep7DB3CtaZWFErv0Md6FcZ73i0xg
         5b/4kC+tKSa7LJ/YCoMlcazG6b9h0s5OpQFtsINtraP426peMBAD+xr1DQwpm8DjCAbm
         qW1G5tybsbByqqauQ/7C3Ho8dr5/1p9EZmBXZ1iEoqBFMP+WaoGSpUAPWsAGSlvOFBRU
         cVEYjuOlzEDkxwL8beaCTiV4f8EAlXpWTzYcrqTktpn5wYT3MsSjk6mpl7Iq2AddzASu
         +bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728855242; x=1729460042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nB1bZmyvGxTgHvpG7TUo9JYKjyZnq7O7z9cIIFMGfFs=;
        b=BrccJ0ZKwSGr0UiOhZb7pxP+KZaelNOuN9N8q+1YQgXKNQVXFbNU3yXwEPN4DiG3Nx
         quTmGyGW4P/ADI1jLI7XFrPP0VP8II3TQrqeK8B9v+FH+IGn5SRaG9YvyUMFbH1rclBp
         WDusEHcklHawiTJ6VwsOcl2cZVnp5rQ05ZULg3wS6+CtMdCPhQJgxYZzhP3njk/Z6diC
         MaAQ9pb4dyvTGIwehWKaqnHNl5bYZwsNOshzFmVotKv7HKYqnIYLBMd0b8VwOY816jnb
         N8iGEwh/5nvtBAFmqhyW6cvM0n8Pb3SKbu1A2AAyqiPsGgTeUNc4KQqg9zJwz+ram3+W
         aNhg==
X-Forwarded-Encrypted: i=1; AJvYcCVAqwvuELEt9Z5e5sxL5DOEemqurGddxobhIqKy9okFg/uxMlbmwR+T5ua2JOQK/4Rie7PXAGcnSiTv7HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMw3i5W9J4VDj98L7GYhaOtRZNcWMRslYOfR7M/SMNRNFwe97s
	Ki8Bs5BunDE2hMCh7zEOOjEz+tVPBvEjnPevEzckqB6aeoKFSTkNvf7KXA==
X-Google-Smtp-Source: AGHT+IEgi5051N/5Zun0iXakUIGf15GbwDgOYReUSIhbx5GOdMdeMWmLo94XReQKaUGGJula3JtIEA==
X-Received: by 2002:a17:902:ecc9:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-20cbb17d002mr114681165ad.4.1728855242001;
        Sun, 13 Oct 2024 14:34:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8badc3bdsm54136595ad.61.2024.10.13.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 14:34:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: bgmac: use devm for register_netdev
Date: Sun, 13 Oct 2024 14:34:00 -0700
Message-ID: <20241013213400.9627-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes need to unregister in _remove.

Tested on ASUS RT-N16. No change in behavior.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: added reviewed/tested-by broadcom.
 drivers/net/ethernet/broadcom/bgmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 6ffdc4229407..2599ffe46e27 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1546,7 +1546,7 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 
 	bgmac->in_init = false;
 
-	err = register_netdev(bgmac->net_dev);
+	err = devm_register_netdev(bgmac->dev, bgmac->net_dev);
 	if (err) {
 		dev_err(bgmac->dev, "Cannot register net device\n");
 		goto err_phy_disconnect;
@@ -1568,7 +1568,6 @@ EXPORT_SYMBOL_GPL(bgmac_enet_probe);
 
 void bgmac_enet_remove(struct bgmac *bgmac)
 {
-	unregister_netdev(bgmac->net_dev);
 	phy_disconnect(bgmac->net_dev->phydev);
 	netif_napi_del(&bgmac->napi);
 	bgmac_dma_free(bgmac);
-- 
2.47.0


