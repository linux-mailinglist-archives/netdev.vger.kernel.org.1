Return-Path: <netdev+bounces-205286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B7AFE0EC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27684E3DD6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285726E175;
	Wed,  9 Jul 2025 07:08:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145F26E152;
	Wed,  9 Jul 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044900; cv=none; b=BG46Q6sSfXtZHwXcrVlwf8uIyT9Qq1gdT6rS8ZFmFOxO353+pqSzhdsqZg5VEFji7Y/tusnQc8gI4F2m1rFJEMUJwklPIVCYDb5J3UGYOuh5ratKfejLN5xgo7ysTJcmx49ZpLL9qEe7jngYyKxO8sh/+J/8BYeesA9qymHuSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044900; c=relaxed/simple;
	bh=fJ4/PixeYGlPCd/DWRyXWkwVq2VpMj7eWmvJIGhyll0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8uLyObGTKwiGKImOOfBdvMAJGw202Gmi+MfXzZ1mfFLukVyMm67jyE2PzsBAEADdekr0NQZqmdMDqgfHFtGrPCvXbidJVbWNP27HwVtAvPBXDsRzmaN0TQIa7S1guYVhqSMQrSUUyp5p6LHBrkOpH8MlIpRmlf5BngU7UwN1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 15:08:09 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 9 Jul 2025 15:08:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v4 0/4] net: ftgmac100: Add SoC reset support for RMII mode
Date: Wed, 9 Jul 2025 15:08:05 +0800
Message-ID: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for an optional reset line to the
ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
the internal MAC reset is not sufficient to reset the RMII interface.
By providing a SoC-level reset via the device tree "resets" property,
the driver can properly reset both the MAC and RMII logic, ensuring
correct operation in RMII mode.

The series includes:
- Device tree binding update to document the new "resets" property.
- Addition of MAC1/2/3/4 reset definitions for AST2600.
- Device tree changes for AST2600 to use the new reset properties.
- Driver changes to assert/deassert the reset line as needed.

This improves reliability and initialization of the MAC in RMII mode
on Aspeed platforms.

Jacky Chou (4):
  dt-bindings: net: ftgmac100: Add resets property
  dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
  ARM: dts: aspeed-g6: Add resets property for MAC controllers
  net: ftgmac100: Add optional reset control for RMII mode on Aspeed
    SoCs

 .../bindings/net/faraday,ftgmac100.yaml       | 21 ++++++++++++---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +++
 drivers/net/ethernet/faraday/ftgmac100.c      | 26 +++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h     |  2 ++
 4 files changed, 50 insertions(+), 3 deletions(-)

---
v4:
  - Added more useful commit messages to faraday,ftgmac100.yaml.
v3:
  - Fixed allOf in faraday,ftgmac100.yaml.
v2:
  - Added restriction on resets property in faraday,ftgmac100.yaml.
---

-- 
2.34.1


