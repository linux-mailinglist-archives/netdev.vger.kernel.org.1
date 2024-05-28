Return-Path: <netdev+bounces-98412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027958D155F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCA31F22CF7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2015E96;
	Tue, 28 May 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="o0GPZJyP"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500217E90E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881528; cv=none; b=PZTn0uW1HOxHc3UId4AOwXxCn54l0lOkJ2yoRZKM3KmvD1sMOtSyuQDhSNISYD1wDK0TL1+pI7NIJkABDBhrCGDhR5RMnAEC3j9U6weOc3XBnh2KDvvbxNQpVo6GlIcba8IWJcnzkYff/ldxnMsdrmB6Z/uS+TARtHeUKjnAbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881528; c=relaxed/simple;
	bh=69pnDOooSWoneIIL7asnZdB6rjMjzIZNEBlhXG03Vg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhkR8ho5RgH8pvB9jgOiONxL5jpR+QJOJoJ7+fyGj7r90vkkDiwR7Rz5kvtRkmntm+8O0SPxd5xvcKkEjj3nBSfs2kpCuiM6V5cdfM2XOsnETjtEEa5IkELOj9r+ECgUXeXW1kvZm97BAN4BqP4SAlawooo3lriEWGtabWFZkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=o0GPZJyP; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202405280731558e30bf703b75d75f91
        for <netdev@vger.kernel.org>;
        Tue, 28 May 2024 09:31:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6uH31//u4Zw5BjG6LCUNvbW1gRwEIkKREfOnyiII6LA=;
 b=o0GPZJyPr+k2kMooKoy0zvlnwEZ1n9XvUxGN3x7QrtEcckIXWPcq1I+HtnLyuNG+Wa793U
 L6g4pJeGkYS/96vlcCBCv9TSyNTMX3Y1REVi1P1UOkBf1ZVwjMnxvo4imUaDW3KAzq/WmIUv
 ZO4u/QeawEZj75x526uBv2WSpBJiQ=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next] net: dsa: lan9303: imply SMSC_PHY
Date: Tue, 28 May 2024 09:31:13 +0200
Message-ID: <20240528073147.3604083-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Both LAN9303 and LAN9354 have internal PHYs on both external ports.
Therefore a configuration without SMSC PHY support is non-practical at
least and leads to:

LAN9303_MDIO 8000f00.mdio:00: Found LAN9303 rev. 1
mdio_bus 8000f00.mdio:00: deferred probe pending: (reason unknown)

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3092b391031a8..8508b5145bc14 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -102,6 +102,7 @@ config NET_DSA_SMSC_LAN9303
 	tristate
 	select NET_DSA_TAG_LAN9303
 	select REGMAP
+	imply SMSC_PHY
 	help
 	  This enables support for the Microchip LAN9303/LAN9354 3 port ethernet
 	  switch chips.
-- 
2.45.0


