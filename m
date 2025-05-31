Return-Path: <netdev+bounces-194500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74654AC9A7E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904EA7AA5B6
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70CF23ED74;
	Sat, 31 May 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwcmad6X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A723D2B5;
	Sat, 31 May 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686407; cv=none; b=frwrSn82fMpBhSoF4SJ0/58PAQxw5kCw6krHxXp3c4nNQcX+Tq4k30nruw0CMqpRWxtQ597VP+3x75RGlF7hBsegNHk9U50uAgLL8whF69Qnn2EK+jXM2BekAIHW9M28VZindGurzv5UXvtWWfJAx81Y6a+UUy0Zn1aQbY+SgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686407; c=relaxed/simple;
	bh=UPogUaLI9GrsYx9+mRcPUzXyxH5KbPYf6iaCZrW/0jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARITbzg9duGIX+Ou43eG3Ea8aOC7JBnJT1J93dj8fNtT26VYai8Mf/qal3tWaAi93N/x3z0qTWSi3ovFmC7s004JvprRilSEtRCIvWFakPw3sLRRwkHO+i1anT8Mztw1yws1hXZviDIsttihGe2jtGNr3jcv0s8E/CzXYMbJKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwcmad6X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so225495e9.3;
        Sat, 31 May 2025 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686404; x=1749291204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFjP+Zg2G7kOQyTgmLTCQiSpHEqYR0UFFWfR0NRaGZ8=;
        b=Gwcmad6XjjRsW14e/rITfMYfuN2ph3Jc/E7isE+JS0oqcuftMbpI11Hv6VQhS628+K
         KQOngNrk13AQL1TnNJB2qL9pXkax47rdyDuLkRstGRhW0V2CSulrHFgeeFly24504jU8
         gL4jk3XcVd9W/8uimcXX0x2h/v1DeHHc6JGNAW5H2V+ooXJWUjdtlv8GFU2oaCAXAMYH
         qwcqXGji28TPTIxlpcKb80oTRSu+mWCFYKZzA6r8q/eH+RPvAFGPYjxuM+78K4QspE5X
         n/RFdTxykJ1QJ/UTd/iubFD/jr2XCMHpi/5cfb3C3iADH3lpiAc3Oqx2S/TgfTZdCF26
         7r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686404; x=1749291204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFjP+Zg2G7kOQyTgmLTCQiSpHEqYR0UFFWfR0NRaGZ8=;
        b=nr9qY339rAb43xUrzVcQB/XJIwfv5M5mV3Tb+2CaryhlwW9Nq/uQs4p6ulnVkkUnDW
         WLCVdA5m/zVygWqkTyT+UJ4+meshpUtISabRGX6jBoMPYqoUguvwUx8t/vU7yxBGsu2L
         BkYhCaANSwQcMahWeAkbQlWbN7UIqq+2L73Te4pPfOlX2gF7cK0h7LWtYYjLtUbuPenc
         +1JrM6IVGO1bw/iimp97BgkbeJeSitAmCTusQCoi68Y0O0690Xxc+1O+7IDtrh07oRt9
         m5A16QQWqjY/3MnZj0nkPJmMvhgFWHeNyMaDMhJh6KiKRX/pqh8lXwvAuAdSNpY+riLZ
         /SSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmviKpqpCvoTx0CJjSuPvKaqTU3XSwVXgeaJB8+SCuBMCYuoV4jUod6P8YNKEXK/tQxRC+5pKTz827+PQ=@vger.kernel.org, AJvYcCW8WBRVYv2etEGDOVzzlAZ3t8PfYXrk+NCRKEOfWJ60WnqsZv7XNR/TXcPz7cdmNMdcoiUu1XNp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKsVNS+si6klrxR3Qm08WoVmHo3lQlRymknks1ynKlzsY6KHr
	4XYU0RxdNXpyj2PsDnfanrpfuoymVXjzbfprb5yM51fSy/e27f3e3wS95CJ5+g==
X-Gm-Gg: ASbGnctls9CaG1MDsUISsQ7kSORftadx4eb+YbVrFVQSnUf1SQfTnnUk6GRq0VioLWx
	wfV5fM4Gb3Yio3r4heVPMRyqNr/6Z0JaoBUqF6ch1xbopFG8e8+A97EYA0JRr5alhW6WjdoNofg
	8vXdgeaK4Lnc3pWbYXNFPHN+EnLpQ7SHoH4/fYtdphuG9HXIRJ3DvuZxxTv6wvtuffCjfWFEitT
	t4qM5Hn2H1+TNIG80reHo/CRyjl/p7RWTBM557VDcj5R7Nxt6Ugbh6nHC0K2q6gNTYJ9DYIetTu
	jyvMVAsPvZPRieXutR3V9a8L9+hWKUNuSBErGQeRfysgW+/69v9qZVcdDrhXg4AXzNFnu4X50l9
	J4ckQ3+UeaMzonleLgWX5j4ROz9ql9TyoPz+gJIpKj5YnLNZIeh6r
X-Google-Smtp-Source: AGHT+IEOdLROqZFhvh5vTjcQwbtV3FTLF/vN2D5rahFk2RZc1AswBX2qrnbhU0CeB+VezLLn39NS5g==
X-Received: by 2002:a05:600c:8206:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-450d8867115mr44456465e9.23.1748686404015;
        Sat, 31 May 2025 03:13:24 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:23 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 07/10] net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
Date: Sat, 31 May 2025 12:13:05 +0200
Message-Id: <20250531101308.155757-8-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement GMII_PORT_OVERRIDE_CTRL register so we should
avoid reading or writing it.
PORT_OVERRIDE_RX_FLOW and PORT_OVERRIDE_TX_FLOW aren't defined on BCM5325
and we should use PORT_OVERRIDE_LP_FLOW_25 instead.

Fixes: 5e004460f874 ("net: dsa: b53: Add helper to set link parameters")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 21 +++++++++++++++++----
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index fd0752100df8..387e1e7ec749 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1278,6 +1278,8 @@ static void b53_force_link(struct b53_device *dev, int port, int link)
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1302,6 +1304,8 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+	} else if (is5325(dev)) {
+		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
@@ -1332,10 +1336,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 		return;
 	}
 
-	if (rx_pause)
-		reg |= PORT_OVERRIDE_RX_FLOW;
-	if (tx_pause)
-		reg |= PORT_OVERRIDE_TX_FLOW;
+	if (rx_pause) {
+		if (is5325(dev))
+			reg |= PORT_OVERRIDE_LP_FLOW_25;
+		else
+			reg |= PORT_OVERRIDE_RX_FLOW;
+	}
+
+	if (tx_pause) {
+		if (is5325(dev))
+			reg |= PORT_OVERRIDE_LP_FLOW_25;
+		else
+			reg |= PORT_OVERRIDE_TX_FLOW;
+	}
 
 	b53_write8(dev, B53_CTRL_PAGE, off, reg);
 }
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 896684d7f594..ab15f36a135a 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -95,6 +95,7 @@
 #define   PORT_OVERRIDE_SPEED_10M	(0 << PORT_OVERRIDE_SPEED_S)
 #define   PORT_OVERRIDE_SPEED_100M	(1 << PORT_OVERRIDE_SPEED_S)
 #define   PORT_OVERRIDE_SPEED_1000M	(2 << PORT_OVERRIDE_SPEED_S)
+#define   PORT_OVERRIDE_LP_FLOW_25	BIT(3) /* BCM5325 only */
 #define   PORT_OVERRIDE_RV_MII_25	BIT(4) /* BCM5325 only */
 #define   PORT_OVERRIDE_RX_FLOW		BIT(4)
 #define   PORT_OVERRIDE_TX_FLOW		BIT(5)
-- 
2.39.5


