Return-Path: <netdev+bounces-52741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E70800007
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A052E281B7B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B7138D;
	Fri,  1 Dec 2023 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL+dykhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F6C133;
	Thu, 30 Nov 2023 16:14:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332d5c852a0so962672f8f.3;
        Thu, 30 Nov 2023 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389690; x=1701994490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfZOawQYQNHqU9ZIBqp6/PMD5jOFrh8dAxaGlSct1Og=;
        b=FL+dykhWQ4ZSqV5/x7Wn7K8cFzAEKi9QQLwXYscHPGGqGqlYGR154qzpNrHORKGYF0
         Noz6LchtQdQ0ADDS8VJW/N2JnCHhXGDX+DU83YmrmF9kTCT7DV2y8X2RVD5c+Hts64N1
         etdnBG/Ro56KOfOhj/PngNIvdNLQisZuxS2VFoT0Bt9MCnJrHWqw4TIgRLKKwuOJ9SIr
         LcVCnExUzBbXavwLvOFOLDTXetLjvPfaUDCSsYGy6DxZrh3QcOmV+tTzKYJo6m1zgltI
         armakfJUWte+3Ibrxxp0Sf30ihO509RX0HvTd/IBC31A4U/cWVdqoArG5G17EkS9xBrI
         GaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389690; x=1701994490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfZOawQYQNHqU9ZIBqp6/PMD5jOFrh8dAxaGlSct1Og=;
        b=Fhdw4R4Qo24XS8XPZfGoVWw5WPu/rn8evDPp4IkuqG9jd46nenEHIv2Lm4HMhJ9rAN
         wvHQ/IzTUi6UxhA7vUrHnnpLi1NXPA1fa1R57yk4f2lBARlWplZJnOvsd+bytPnECG8k
         o6VbdeOkX0P/BOfw6qRVSbaZERFDmU/ocNxNZRkqop7fupng4/sI4cdh4eXQLurK5Zti
         +26tw3NCUtoSp80AenYLWM7T0vM7MJuDs05wyMQIyl5MbP7M8xHaxqOc4wtqmTG0VRmQ
         Juz9vDQRv90hnff8AzmELOgKXFJ7dh2zCtHsAEfAYlmrELOs94maoNa5idYh6XWPbsBz
         pOcw==
X-Gm-Message-State: AOJu0YxJvTAymQbMQX2oL2p94tDbihW78N3RqQLWLIYn7wXOeu1f3EaW
	ZHqOOL9d0gBqmFK5+++/vt0=
X-Google-Smtp-Source: AGHT+IG/twidJaUWlUWAiSD8uGlObqLx0Ig1UdraooC+IUrT3e/SH0UT8hm/oEW5ge+/bwhAFqjinQ==
X-Received: by 2002:a05:6000:1372:b0:333:2fd2:5d42 with SMTP id q18-20020a056000137200b003332fd25d42mr203533wrz.116.1701389689788;
        Thu, 30 Nov 2023 16:14:49 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:49 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 01/12] net: phy: at803x: fix passing the wrong reference for config_intr
Date: Fri,  1 Dec 2023 01:14:11 +0100
Message-Id: <20231201001423.20989-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201001423.20989-1-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix passing the wrong reference for config_initr on passing the function
pointer, drop the wrong & from at803x_config_intr in the PHY struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 37fb033e1c29..ef203b0807e5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2104,7 +2104,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
@@ -2134,7 +2134,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
@@ -2150,7 +2150,7 @@ static struct phy_driver at803x_driver[] = {
 	.resume			= at803x_resume,
 	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
-	.config_intr		= &at803x_config_intr,
+	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
 	.cable_test_get_status	= at803x_cable_test_get_status,
-- 
2.40.1


