Return-Path: <netdev+bounces-220937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F566B497F3
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE716F562
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6E131984D;
	Mon,  8 Sep 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbjPAJVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D43191B1;
	Mon,  8 Sep 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355074; cv=none; b=CfFvPLeIa2uMwt54/KUK020tg1o+BMV/V45NX2WE/erY4eP70F2iHcaiqAPLKMaO3tQF6obbrCVyeA+vLtCimZcgqzN61ocTg4wHsDGXDHlxN2ZalOL7fz4VopILX2RtDcHgVhDrh3dVUu3I9qq6uZM6O3hWPOctJB+gh4PR7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355074; c=relaxed/simple;
	bh=coKgeanaUZ3X4I0jziHLWfdNIN3UjLw9i/nP+qWcjHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ik1P3yRUuge3DXXlrBEK1aoqCAGMGpm1ayMUBZdlepC469gQRxvsbh/VjSV1Pcr0qrjO9sz+XVREumPapabFlegjyXZVW9MqTFgMLP9TymOkn6fGamaA8Hylj6A6iCZVmMKMo1JwtcSgwGTKhj4VQBlM6w/o1+Vt4W1Wp57tqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbjPAJVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF70FC4CEF9;
	Mon,  8 Sep 2025 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355073;
	bh=coKgeanaUZ3X4I0jziHLWfdNIN3UjLw9i/nP+qWcjHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbjPAJVj+Ccx1YTKZrvpsRHmbAEV0P6asEw8LJwiUJ/hVodfJHuxDiEB3U2dkEI6y
	 NTrL18E/0x2Jj9reBGahfUtLqFZ1Wa/eCATTh3aKxaayBbifCy28Ra3bLf+7Q6EXTw
	 Pik5J8qfj9NUWYfYNH0lduTRBKe3ig+seqEi6d/kwdYzNW9r8yWKhbFC5y6tfcFBi4
	 moOY7NR8iN5YVDsDwm1noOE0ecXRsjYZ8/IcataZX+EvcYAdtea4C3JS63q4LbPKYs
	 jyt5oWNZVdgHo23+YafzlHasx82rfYbudDXTErU+BYqMH7c9xbNMJmT3Zk1go8JWEP
	 JaZtukR2iu0Ag==
Received: by wens.tw (Postfix, from userid 1000)
	id 5666E5FF5A; Tue, 09 Sep 2025 02:11:09 +0800 (CST)
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
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH net-next v4 08/10] arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
Date: Tue,  9 Sep 2025 02:10:57 +0800
Message-Id: <20250908181059.1785605-9-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908181059.1785605-1-wens@kernel.org>
References: <20250908181059.1785605-1-wens@kernel.org>
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

Fixes: c6800f15998b ("arm64: dts: allwinner: t527: add EMAC0 to Avaota-A1 board")
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index b9eeb6753e9e..e7713678208d 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -85,6 +85,9 @@ &mdio0 {
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


