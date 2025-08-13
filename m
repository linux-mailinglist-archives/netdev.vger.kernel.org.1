Return-Path: <netdev+bounces-213194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC4B24190
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9645629AE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6982BEFFF;
	Wed, 13 Aug 2025 06:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E7293C5C;
	Wed, 13 Aug 2025 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066786; cv=none; b=iyRavxt3eLa7GJ5ZlItZLpI+4+PU6yTuaeVFHXrMV0Gw21aG78a977Tk47UDTdw5MuOP6VBGB/6ykRXd77xa2JdgqJajV87L7X38j3xPtDscAn3yBsbGa/IHNrtoGpLHbRuD+YYNFynJRIgFp1FzGVZT1SSV5wQu8lcT2JGFbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066786; c=relaxed/simple;
	bh=RSgauVDnKP7beFc0uda4hrGRgYoMAjulOowiUnwWYgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6tpvxKW4uHRuhHV6e54ilJbdgc1Zu28njXI1+A+g2tq7g2D7Z5scTvbLNSea/vAunvJYPYJY3XJE9Js7lVdi0ElZQCpGLNm0AyPr9jpDZ4ymesPjW5tYewP3pECpQS4PfHlmN0XHXiiXoUfjbsWt1dD283xjJ4+RXBDSoFCD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 Aug
 2025 14:33:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 Aug 2025 14:33:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Wed, 13 Aug 2025 14:32:57 +0800
Message-ID: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for configuring RGMII internal delays for the 
Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to 
distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration 
units differ.
The device tree bindings are updated to restrict the allowed phy-mode and delay 
properties for each MAC type. Corresponding changes are made to the device tree 
source files and the FTGMAC100 driver to support the new delay configuration.

Summary of changes:
- dt-bindings: net: ftgmac100: Add conditional schema for AST2600 MAC0/1 and 
  MAC2/3, restrict phy-mode and delay properties, and require SCU phandle.
- ARM: dts: aspeed-g6: Add ethernet aliases, update MAC compatibles, and add 
  SCU phandle for delay configuration.
- ARM: dts: aspeed-ast2600-evb: Add rx/tx-internal-delay-ps properties and 
  update phy-mode for MACs.
- net: ftgmac100: Add driver support for configuring RGMII delay for AST2600 
  MACs via SCU.

This enables precise RGMII timing configuration for AST2600-based platforms, 
improving interoperability with various PHYs.

Jacky Chou (4):
  dt-bindings: net: ftgmac100: Restrict phy-mode and delay properties
    for AST2600
  ARM: dts: aspeed-g6: Add ethernet alise and update MAC compatible
  ARM: dts: aspeed: ast2600evb: Add delay setting for MAC
  net: ftgmac100: Add RGMII delay configuration for AST2600

 .../bindings/net/faraday,ftgmac100.yaml       | 50 ++++++++++-
 .../boot/dts/aspeed/aspeed-ast2600-evb.dts    | 16 +++-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       | 24 +++++-
 drivers/net/ethernet/faraday/ftgmac100.c      | 86 +++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h      | 12 +++
 5 files changed, 179 insertions(+), 9 deletions(-)

---
v2:
 - added new compatible strings for MAC0/1 and MAC2/3
 - updated device tree bindings to restrict phy-mode and delay properties
 - refactored driver code to handle rgmii delay configuration
---

-- 
2.43.0


