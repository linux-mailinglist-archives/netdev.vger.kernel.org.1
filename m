Return-Path: <netdev+bounces-166893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41ADA37CBC
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462DF16CD49
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF6192D68;
	Mon, 17 Feb 2025 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUnM760H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C25136349;
	Mon, 17 Feb 2025 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779529; cv=none; b=m6PpgTrHLV41AEt9Nfsa+ndLYQJj1PZ4q9Z7i9xDAwTsCzHZXmDF1c4kVjmBfVREF6iHjPPUfMJiFC9jhXD+mySYhxwnQ0haFDIY0GY3Y1PC///skzhBOfn6rQmfNIqZuja52RFWKW1SxZvTrNvFKqfKUrWJJoOZR3FxhD36UKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779529; c=relaxed/simple;
	bh=OMIoFmFWm2sfT8wT+Re6zWof5GckgfQnPWq4lIWZ2yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVHpo1bQJerHyw7Fr7sNEh8Hd3sIwvBTownAD5M+M/c2YfBPQuLGui7JPdtHeN4zUFOm0biEoCJIULQQk3iHPU9sYe94N+PbnYmZ9JBn0tzuwWkZD4LDf8cD1GHi6GFuWuAqU19tgYTKE1bR7R2p6vLJVHpJkqlEglbTf6VvpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUnM760H; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso1203991e87.3;
        Mon, 17 Feb 2025 00:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739779526; x=1740384326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQi4mORfT0+OYYtZW4OGb4jsOQc58oWzL2xUZHfteFw=;
        b=aUnM760HNlsdBiDk9cRdS6K7kuZm7DmMyjWFkK3yNWmHE5FX/IQWS+Tdf/P/cqbqor
         ITl1uQTkP2utxp6CnWCpHhBr5OBPA1RnpKUeO78E64rTMSuAqsTOuMnV56TLsdMKi4Y2
         6Kbk86IAT02SJvanAD79CVUgY5xSi28e99pEsJOi6s9yUBMaIpp+IotU6zgDw+cqmgW/
         /2P43mydoobJjglA+YWoagZfa76b/SVwey50QrHKsNrdaewdPYh+nwC+flBKJx2X9Zn2
         vwOVZ8IcJAlKaZVkAY3E6z5lZargDP+bnZi3SUiN/EGCCQ2UjkdiRiHjdgXBKVPra6cG
         690A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779526; x=1740384326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQi4mORfT0+OYYtZW4OGb4jsOQc58oWzL2xUZHfteFw=;
        b=JsCsrgFm8U/3xzhPIDb/AnsioEDM7zr0iYCUgYWIH+EENaolIzErPEexDalh6wFmgg
         Lz29MNru6k/KRQEab6e/awHMgAa6bxlepA8c++VXXYG69wXa7rw7b/Cz2By2E2Nkzy6z
         xeouqdM6Hqx8nfVSekJQzQ9p3AQ33nImxhy7LrmnNlp5reqmvz1k3nuBDqYBvFpKINCs
         ouZrkxN/BtnjNdQII78jgVx/uPQvXTbG7hWmmL0unQrVCh6PWVKUEaZUVu1debg8D1Wm
         XSuvxF4hZrUf8daYrBIQKxOqrcDfgWRevaCErK+1yfVjvbXAOdd+Uwtipecrq+KTaLc/
         2P3w==
X-Forwarded-Encrypted: i=1; AJvYcCX+0rKM15DXANrhBn0M5bpG6cVm3q/RGA/7v3MqYmY7A1TqlzFjkJp13dHAFAx8D4N1iA8xDvXA6G6U@vger.kernel.org, AJvYcCXEvpkdqIEj6EWHPLSryE5/gjcoK70kY8ZsijgzfTf8WXKvqzRd5yfuVEt7udqLyjr6K8rlECdx@vger.kernel.org, AJvYcCXTGTwADLQiCHiSQxWKBl1UvTpzq4KNkZDMcLsLNfOQpNT6j2A4k4IyCxkZHK+VAZSGzcPP1eAsPAzNP2MQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmuQZ+hZYt4wqR6j32zh9buZeyXaANFaZfbshfm+8IAx6WFEt
	vneyvP65Hp/SUc0KMiYlpu0UgOQLT44k6VXwgHyGLPJdTXhvtNPN
X-Gm-Gg: ASbGncuzFKiZYRl6NcZyS1iH5LxxLt+kO4TmXCKAapEa3r/KZXqvFsQfjmi1fKCvG3y
	5fqpo2Pote6MgqWvhDtIcmyh8FtDFkLuRjyR/GSm4cFfbnXE30Wzv0XK5O7i/G+58EfRlL+n0U1
	XRbu7E1le2BFU0lGcDkvvop46zHr/dXCxtGIMmufuJpFagqkBySELdjA5JJBylsZJ0euYgwttYV
	g2AfhlTlv3TjNjRsTAG/sIq44zb5cEzHgHuAWVg8ApL/0niRiBLmtpwAyQDHQyImd69rmTIHnUp
	1WiKtFsCRDRLw5vd5hL99g6scjTTBcK8
X-Google-Smtp-Source: AGHT+IGqppfZnBg+OjgAztdKo5lIW/qOPjMe01qqPddlwh752WgFhMfRj1J3WLEiBI79t4joqqJEQg==
X-Received: by 2002:a05:6512:2823:b0:545:27b1:156 with SMTP id 2adb3069b0e04-5452fe5811bmr2558765e87.22.1739779525795;
        Mon, 17 Feb 2025 00:05:25 -0800 (PST)
Received: from clast-p14s.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452848ed13sm1173028e87.255.2025.02.17.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:05:24 -0800 (PST)
From: Claus Stovgaard <claus.stovgaard@gmail.com>
To: claus.stovgaard@prevas.dk
Cc: Torben Nielsen <torben.nielsen@prevas.dk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: dsa: b53: mdio: add support for BCM53101
Date: Mon, 17 Feb 2025 09:05:01 +0100
Message-ID: <20250217080503.1390282-1-claus.stovgaard@gmail.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Torben Nielsen <torben.nielsen@prevas.dk>

BCM53101 is a ethernet switch, very similar to the BCM53115.
Enable support for it, in the existing b53 dsa driver.

Signed-off-by: Torben Nielsen <torben.nielsen@prevas.dk>
Signed-off-by: Claus Stovgaard <claus.stovgaard@prevas.dk>
---
 drivers/net/dsa/b53/b53_common.c | 14 ++++++++++++++
 drivers/net/dsa/b53/b53_mdio.c   |  1 +
 drivers/net/dsa/b53/b53_priv.h   |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 79dc77835681..61d164ffb3ae 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2409,6 +2409,19 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
 	},
+	{
+		.chip_id = BCM53101_DEVICE_ID,
+		.dev_name = "BCM53101",
+		.vlans = 4096,
+		.enabled_ports = 0x11f,
+		.arl_bins = 4,
+		.arl_buckets = 512,
+		.vta_regs = B53_VTA_REGS,
+		.imp_port = 8,
+		.duplex_reg = B53_DUPLEX_STAT_GE,
+		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
+		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+	},
 	{
 		.chip_id = BCM53115_DEVICE_ID,
 		.dev_name = "BCM53115",
@@ -2789,6 +2802,7 @@ int b53_switch_detect(struct b53_device *dev)
 			return ret;
 
 		switch (id32) {
+		case BCM53101_DEVICE_ID:
 		case BCM53115_DEVICE_ID:
 		case BCM53125_DEVICE_ID:
 		case BCM53128_DEVICE_ID:
diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
index 31d070bf161a..43a3b37b731b 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -374,6 +374,7 @@ static void b53_mdio_shutdown(struct mdio_device *mdiodev)
 
 static const struct of_device_id b53_of_match[] = {
 	{ .compatible = "brcm,bcm5325" },
+	{ .compatible = "brcm,bcm53101" },
 	{ .compatible = "brcm,bcm53115" },
 	{ .compatible = "brcm,bcm53125" },
 	{ .compatible = "brcm,bcm53128" },
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 9e9b5bc0c5d6..0166c37a13a7 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -66,6 +66,7 @@ enum {
 	BCM5395_DEVICE_ID = 0x95,
 	BCM5397_DEVICE_ID = 0x97,
 	BCM5398_DEVICE_ID = 0x98,
+	BCM53101_DEVICE_ID = 0x53101,
 	BCM53115_DEVICE_ID = 0x53115,
 	BCM53125_DEVICE_ID = 0x53125,
 	BCM53128_DEVICE_ID = 0x53128,
@@ -188,6 +189,7 @@ static inline int is531x5(struct b53_device *dev)
 {
 	return dev->chip_id == BCM53115_DEVICE_ID ||
 		dev->chip_id == BCM53125_DEVICE_ID ||
+		dev->chip_id == BCM53101_DEVICE_ID ||
 		dev->chip_id == BCM53128_DEVICE_ID ||
 		dev->chip_id == BCM53134_DEVICE_ID;
 }
-- 
2.45.3


