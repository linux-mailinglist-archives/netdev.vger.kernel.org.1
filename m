Return-Path: <netdev+bounces-65038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F74838F23
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE21F279A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC65F869;
	Tue, 23 Jan 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JXk7pOBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0D5FDD2
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014781; cv=none; b=IhIGwQWyBArRBDP4BJ9FGK5hxFtEA29CQPK6FD/qyJN9qCmvrdWkfy/KD0+2KyHXWQytTNd3Hd6ykw6n603yoZE+d8wYU61XRijDN7QD5HNmkxCyZRCvqJr/ozKSNm9zOg3cWbvngRXR7F70W2uxTOV+lDTSanZ2TNxJ6xb1UOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014781; c=relaxed/simple;
	bh=kAEoXOplVy5YWA3sBqf12QFlLVQhI4EiSxiILtHkle0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEkmhl+h/5/N/PS1j7ftSf2PvXt+ZCpNM6hE9XfkiK5M80SwVdTTnhVZRlUi1ZxrprGSHcovvsQAHuvOqmQlPRWWCsHVin3liF8KkE26W4zOGfhnbygPbZ3Bvwd6lBGVSoLqEN51GLwRHodfvk8rw0PW/8yulXGQKTTy12VHgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JXk7pOBJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e800461baso51108545e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706014778; x=1706619578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puI8SNnunhmOcoJT+z8Q27MsKtmovJKKV09skkr2C8U=;
        b=JXk7pOBJdHeuCsBSkLiiUaOaaDjgQpUj5lg+5t3xin6EbtzFj+e6NvBi2/8q23bD//
         WNZj0BSHcr23MPad0jisNp99NIEcPDlGOf8MdrG/aep56qSPQ26p5iEOkE2FK3qUpM/b
         tIcwmc4Z9aqWEK2Bi9Uzsv7WcNxVrBe8EDnWBnz7z9UbcBTA7iDZg/e/4EmHUxlAzknD
         2TD3O6erJ32BOTtAqeiUKLHu5TFH8bgY0nnYvSvtf/L05h0oD9NrEUbViI8SuX1Ue0Kp
         Hc8wLl8af3HzkZUJY4qBQF330j7U2KiRYWwmkjE6gBZyFVeEx/Dp3BsutsdMLrspIN+C
         5WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014778; x=1706619578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puI8SNnunhmOcoJT+z8Q27MsKtmovJKKV09skkr2C8U=;
        b=saNV3lygrrv/h1QbR9aIjx3gIyahX6tyyOH/CqtWyKOWhSMtlsDHwJ+ReG1rP5QV3I
         Ubur3+2y3jFRelkrl5i5rVwhaBl836+9n6WN7WOAY94R4AbJSsMffbu2KUhcFhg0otHZ
         s1QGjxq1hgp13toEiO6WU1hltLZY0yew/W8c3ghiaSgn4VZOsBUiSKfHa5rgwJ2vRj01
         oFE7ajbX2PDV7R0RErHMDEPdYroiXsfDSACK2OxQwCqIz3CYbbtP4xqkq3V4Vqmhc565
         D4sOZ1EhqqIF3b4jyyahiF0QfW+5JH5grVYzvVNOp217mgh3IZ8fWoHJJQgZLZ6qqToT
         QASg==
X-Gm-Message-State: AOJu0Yyy/69cwDY40JGyv5Mc2WRNKATh/dAQ2hBZZaqrctCxk74hgWyg
	NqDbTa2xmWAkUxF2INRati1ymd0skraK+6n8f2FAT6jpSbYoAp+uxsrlkm4muIQ=
X-Google-Smtp-Source: AGHT+IH2MT/KO/WgG/1Z1dx74VNrUdB2LnMBhRP6NCOQ+c98dRC4Y02BkxHXVAp2wxLBtaGUGsnpyg==
X-Received: by 2002:a05:600c:5204:b0:40e:8e61:3202 with SMTP id fb4-20020a05600c520400b0040e8e613202mr266529wmb.148.1706014778411;
        Tue, 23 Jan 2024 04:59:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm33655711wmo.48.2024.01.23.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:59:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 05/15] net: ravb: Use tabs instead of spaces
Date: Tue, 23 Jan 2024 14:58:19 +0200
Message-Id: <20240123125829.3970325-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in the ravb_set_rate_gbeth() function.
This aligns with the coding style requirements.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d054d1405cec..0a27d2741e8d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -96,13 +96,13 @@ static void ravb_set_rate_gbeth(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 
 	switch (priv->speed) {
-	case 10:                /* 10BASE */
+	case 10:		/* 10BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
 		break;
-	case 100:               /* 100BASE */
+	case 100:		/* 100BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
 		break;
-	case 1000:              /* 1000BASE */
+	case 1000:		/* 1000BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
 		break;
 	}
-- 
2.39.2


