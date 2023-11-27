Return-Path: <netdev+bounces-51261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6447F9DD3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6457A1C20D4D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85436134A2;
	Mon, 27 Nov 2023 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="R9lHQTMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DF10F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:41:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50baa3e5c00so2301175e87.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701081694; x=1701686494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKjdRgLrUCqiZ/8TfWkcZK9DEDOrOby/F2DvMdG0zJo=;
        b=R9lHQTMi4ZgR+K9FugU2LsSbOl/GWgS1qUowGRx2RQkxwidbUCjgxLQbqWH5jhaYPh
         MDjCZZN7xMoSKTpnBkoDFycsxJQ3w3omnbsBf1PowZ4qRi8rJK4c3CqsU2O58A1/DDLC
         3LRovJGZUYcnJCW4vjAd6qOZQIhVkAOCno9v6BSqWfZ9FpHukpJER0DgTiWALbUdWZDU
         VEnYS9kRsb4VS/+LHsickC9oyzgewv772dqGOzsl0uPZUjHpd01jhCX5Vndex7pz8QT0
         KubNSSXWEzHZT4BJdrkdtIE2uXnKmqWc+p16fcg926ilxkCuH2ZeaOVB6HCsQxy7uhUk
         S5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081694; x=1701686494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKjdRgLrUCqiZ/8TfWkcZK9DEDOrOby/F2DvMdG0zJo=;
        b=hoGPJSEUriV7B1mPX/Brqeg2XEA+9HB7mGaYoRNOvnKN45LD3aA0PbJuckOkZNDR6o
         4YU78te03uZdSlT4fZ2qk86JcNLoFE23n7nUHXbjyqfCJBBl+akf3Ym7wMCQe4xcqY5A
         WPQYEzcf0+UskC1imom7MPBxsCd7lmVoJjk/Wd2wJh7jn3Gql8nuhlyz8Ll0+50SkIZI
         FtooJz8Bob7gSM2UQ1gJ+rjLKBBbKJ3JOmb4Obc8xSfGbAg7AnZz4UF3pgnRjkGrz0BB
         YeXhiuExaEvjiXxSiw2XHfLhbdgzxqV9d/YI5t15y7iMSA9HRL5+3QDod/FB73vGibuE
         Aipg==
X-Gm-Message-State: AOJu0Yz1Yo4Rc3F7X4cQOHabQxJMAytYAVD4dHVnoc0smKwP9T8cG+0l
	yQziPA8LXc2ieVKt5EarGQBbcQ==
X-Google-Smtp-Source: AGHT+IGpNy1Ibi0FzBM2TdCbpskcep8VoY2/zMQZle6Qf1fQQIRpXPQUsG+Ui6vhUO22lNXw/l/Duw==
X-Received: by 2002:ac2:4c4b:0:b0:507:a9e1:5a3b with SMTP id o11-20020ac24c4b000000b00507a9e15a3bmr5493090lfk.0.1701081694278;
        Mon, 27 Nov 2023 02:41:34 -0800 (PST)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004fe1f1c0ee4sm1432070lfc.82.2023.11.27.02.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:41:33 -0800 (PST)
From: =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 1/3] net: microchip_t1s: refactor reset functionality
Date: Mon, 27 Nov 2023 11:40:43 +0100
Message-ID: <20231127104045.96722-2-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

This commit moves the reset functionality for lan867x from the revb1
init function to a separate function. The intention with this minor
refactor is to prepare for adding support for lan867x rev C1.

Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
---
 drivers/net/phy/microchip_t1s.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..ace2bf35a18a 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -213,7 +213,7 @@ static int lan865x_revb0_config_init(struct phy_device *phydev)
 	return lan865x_setup_cfgparam(phydev);
 }
 
-static int lan867x_revb1_config_init(struct phy_device *phydev)
+static int lan867x_wait_for_reset_complete(struct phy_device *phydev)
 {
 	int err;
 
@@ -234,6 +234,16 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 			return -ENODEV;
 		}
 	}
+	return 0;
+}
+
+static int lan867x_revb1_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	err = lan867x_wait_for_reset_complete(phydev);
+	if (err)
+		return err;
 
 	/* Reference to AN1699
 	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
-- 
2.40.1


