Return-Path: <netdev+bounces-203005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91AAF015C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DA1C2529C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067B281341;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3b8YLwT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B91280A47;
	Tue,  1 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389090; cv=none; b=vCCdNc2Jw4Sn+b7iQ6EcAm7rq+fRqq8wS8EMJ/eq7/+MKVSLYFA2szC3++knIRB6SckiJXpnY3o9FnrEZ8YFmWpW8hH00uFVwRLAHKEDlGysAle47ro5BkwyEd6NUQZFlBdlz0A06TgXxvJ/5az2ZoGcLCswVSI+NCA9/DH4M8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389090; c=relaxed/simple;
	bh=U6fvNMCsGOs7GguX88DJTDBdJBFw0TBsVo/+de4qj2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ib1OkOJbrqC6jzybjoIMbnwzOr4GQSOhXZbmxfLuNWlMY3GQB16QSyGT7rjA4I3SwPt28sBTuMLxQWueIHlPcui35blgF/xkzSvyqnQ7s7IkHEbjXcqTYYI1J9ihlFyvVqCu/nCRdvi2Ex5Wavvx69tJLk59ddNl+deItpEr9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3b8YLwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E630BC4CEF1;
	Tue,  1 Jul 2025 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751389090;
	bh=U6fvNMCsGOs7GguX88DJTDBdJBFw0TBsVo/+de4qj2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3b8YLwTKxbahAbpltwNB2iIlZOrvvODQST3QVSVwG5GeDR5ICAJr84aVPmjf66pM
	 NN78mzr+OEvHnRQeoZ04dQwASpLaepWzWXKFNxUPsLaHpcTe7OpIb/ADdNNWHXjRHi
	 BiCZMTDL0ZCi/vYWL1nmBFbXeIThq0YjfCUJObJC8z/wTNTNAhe6OF6X9Dovs7g229
	 nOEY9eoE+a2zHYmr8EtgN+OsYQxmp3RrAjRyi8AwQVDje9sKdHIFrfNyur6AiSOP96
	 m9THrXlRArTtH+fLK0OGkEepv65ZvYVtWqI6xccDoqNoYwpjQPSVogxiLKGXi0pvVu
	 pYfCoIAspvvTQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 057D95FFF4; Wed,  2 Jul 2025 00:58:05 +0800 (CST)
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
Subject: [PATCH RFT net-next 06/10] arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset setting
Date: Wed,  2 Jul 2025 00:57:52 +0800
Message-Id: <20250701165756.258356-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701165756.258356-1-wens@kernel.org>
References: <20250701165756.258356-1-wens@kernel.org>
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
index 8bc0f2c72a24..c57ecc420aed 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -70,6 +70,9 @@ &mdio0 {
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


