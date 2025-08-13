Return-Path: <netdev+bounces-213369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6345B24C95
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF317BE2AD
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D992F5338;
	Wed, 13 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6YkdF24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB82EFDA5;
	Wed, 13 Aug 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096948; cv=none; b=I2BWTDyZt4DOClRfTEheRXELFOYmJYy80qSsF2oN6c84Q9ioIvPAjolBhx0SVIxoXMWq2m2u1V/AtxNm+BRNJi2VQv1M0clZ104fwe3prwO/+fsEavZ50sjFQ/DIrfsRWBFy4pT0uX5AoN9QSBZwJOFSd/Ghxd682Er6RY8ZGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096948; c=relaxed/simple;
	bh=tDfUpZExKmJMXStQh2fTARqlHOrlMBEVmIQj8qTNpp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JORQtQRv7n6RAbqZblovdZzQ2bmPegp3dpyaIBlryM55gZFr+qD9t5TpldmRn29BuP3pTOfmJ/7zFoDbKaBTL5nuM8pLi/529NiG2ZZ7A8Ne+htT4KEkAjHWecaiVl7CZZEilQjUJmaVIkunUYzuyXWe9ngvoaUbXO8tjZ3phbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6YkdF24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A210BC4AF09;
	Wed, 13 Aug 2025 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096947;
	bh=tDfUpZExKmJMXStQh2fTARqlHOrlMBEVmIQj8qTNpp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6YkdF24uls3iDY1HAv8Weghhp2cN67nZBA70lqLv1r2uhk3tRVBWlfJ/B3gQ9i/p
	 +YwcjV5ob/61OwEq9MLS2tjY1Q1VRbmBrWQ7pKE2NCusSJMxni3Q6SRI8fhy9QbIew
	 18J96Kf4ueIjFH4GHiaJM71wSeXxvezTPTnrVFElmQq0a5G4AsAltbN11F2+vaOffz
	 oNUG3Lv3JeLFpkcC2NjBtJKBCOb35MHNIhARhHYG0daIFjCZNhCkF+4OsC1K4xup+A
	 Bd9qI2lZozR+KsuX9TIeFqb65lzs/ZHIeAhxYL63irKbFbvJ8OWVtxTx83EE0rWvIV
	 5TctEyHhXm86Q==
Received: by wens.tw (Postfix, from userid 1000)
	id 27E2B5FEBD; Wed, 13 Aug 2025 22:55:45 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH net-next v2 06/10] arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset setting
Date: Wed, 13 Aug 2025 22:55:36 +0800
Message-Id: <20250813145540.2577789-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813145540.2577789-1-wens@kernel.org>
References: <20250813145540.2577789-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The external Ethernet PHY has a reset pin that is connected to the SoC.
It is missing from the original submission.

Add it to complete the description.

Fixes: acca163f3f51 ("arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index 70d439bc845c..d4cee2222104 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -94,6 +94,9 @@ &mdio0 {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <1>;
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
 	};
 };
 
-- 
2.39.5


