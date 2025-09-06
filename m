Return-Path: <netdev+bounces-220559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130BB468DC
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 06:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D21CA4814F
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C4726E14D;
	Sat,  6 Sep 2025 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxcX3hDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872F26CE2C;
	Sat,  6 Sep 2025 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757132024; cv=none; b=uT6/pm18PqLQwCUuFTdvyoAMgdMDnRyXRcCV0rxSfmgn+bYlY+iVNABRy7smJ3vPw10ZaxPsPnI0zbejOkW0eDxlT/PDiK/ndJ5XmO3rcoCEKM8KC9DqHi03FFEeBo/apIhDDEQJeZGC66ouPQnVDNQpxxVowr/UOkZTE5otljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757132024; c=relaxed/simple;
	bh=tDfUpZExKmJMXStQh2fTARqlHOrlMBEVmIQj8qTNpp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMHY519qOg+06vY7Nx4HxmoW0Je7Xa+YdoGc3VdpmGbM/xx706qpbsiEuLl3pXivJzk8Dq06M3Mssy6KjwQu5KyYF+cpyp0enRGxsE0PDUB+xnT0jBsfXxJ7FUtQOhwVWXKiGfXjMpe1dFRPAG1NJ0uBL1l9HvnotSgM8TEK8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxcX3hDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BB9C4CEF7;
	Sat,  6 Sep 2025 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757132024;
	bh=tDfUpZExKmJMXStQh2fTARqlHOrlMBEVmIQj8qTNpp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxcX3hDdhIcHU3lc6DId6MV315Sk7yYxVfYARSA80aE259q6UGqWfhpcdvQ0sSDMW
	 vw1uu7EhOf86FWBcj70eUuJ9tjOsPY6MCZNGXZRQUxX85V0Q0y4d+/lujPNMTEhnNt
	 0LZLQY8AuPtKB/8N3aoy/aEzMmwa6iQ6EQfJ07B0Uyxx9tzWn6CJZYsrzpkLhglHqK
	 sLJoe7ZZuMUA4hpYoh0MsrEFY8XOkCSc6pMjCrkFNoKnPKoi+tm1U1V3r/+LTuHmEo
	 XGnTuepdldm36U+VNpLSWxlkPOre2hll8LTqd30iQligkWtmm/w16k591RYns7Xenv
	 RuVsh29ymcmcQ==
Received: by wens.tw (Postfix, from userid 1000)
	id D59155FEF5; Sat, 06 Sep 2025 12:13:38 +0800 (CST)
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
Subject: [PATCH net-next v3 06/10] arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset setting
Date: Sat,  6 Sep 2025 12:13:29 +0800
Message-Id: <20250906041333.642483-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250906041333.642483-1-wens@kernel.org>
References: <20250906041333.642483-1-wens@kernel.org>
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


