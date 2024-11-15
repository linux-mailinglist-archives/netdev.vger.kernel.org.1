Return-Path: <netdev+bounces-145407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCFD9CF64D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4A21F29A97
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658871E3760;
	Fri, 15 Nov 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeLpSbuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6D1E2848;
	Fri, 15 Nov 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703392; cv=none; b=eDks5pnIM2BZenSvKg64N5J5UO7yQnQ8rdQ+XO1AP6kgAFCwbo5r6lzGf9EjFS30Fm3XzX+yDXThSVzII8d+UuqP0a4cw/D/+S24z1pp5y4k4dRv2+y4L7NIAxQvd6RUELK6BTDkHhoXBmK3k1oINiOPh1NYsSqYMLvuASP00PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703392; c=relaxed/simple;
	bh=HMpjdv/bdsXxaQkhI5GYNDu/DBHhpSw2rmWGbNPhfqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UuhwBUjCJuhTbl6mJptZYE4dnqSa+6d/6gXND5CqTuCxRA/nHWs8SHz4Ft3qLGfU+BQUTb9cdrEdt1937MCs48IwiQDHWbhCB39tkJwrbcGgHSwm9J4EYdFsXbsLymuG2O6MKjAzBG1ZkQczPHwkRJS6eZcQB4qzaEkef5QWhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeLpSbuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AEDC4CECF;
	Fri, 15 Nov 2024 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703391;
	bh=HMpjdv/bdsXxaQkhI5GYNDu/DBHhpSw2rmWGbNPhfqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PeLpSbuER+I2/r5q3PCIifda93s7fpLsXNBI4oQZu8p6/mR4+AboBV1Z3DydsHhPs
	 PQSLm/ZAf14MkoGv4OkMWZmlYgnoXBavzf9DpnT/MyHRbPxar+SVRC94Rt9a+zBT3h
	 Fh+eNi0KAM/BxRNfDQqKlD/KGmyghXBzLXNl6bkSdMMh0lQ0xr+nCOX/rXHwGI8rzj
	 InrfH5SbefkXsWh7UW4fPaQn8pa82VgqMHRqOGQpqZHGdWVxlhpSTuNeBB0kmN1u8M
	 OeCybIZUsn95+p9JjlvWIVjpOKdup/5D/FX57nf6Yq6JC4X5Zvc7OSLM5btdBtdEUe
	 TLWqSbxCIQ8XA==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Takeru Hayasaka <hayatake396@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] Revert "UAPI: ethtool: Use __struct_group() in struct ethtool_link_settings"
Date: Fri, 15 Nov 2024 12:43:04 -0800
Message-Id: <20241115204308.3821419-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115204115.work.686-kees@kernel.org>
References: <20241115204115.work.686-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=kees@kernel.org; h=from:subject; bh=HMpjdv/bdsXxaQkhI5GYNDu/DBHhpSw2rmWGbNPhfqc=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnmmyIk8r96VO2KE5lgtGfjl99Fb6peaZ7ktyqKmfJ+V jub01+fjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlMZGP4w/3sYMXytXM8bpbd 28AvGNAnYnvCVYX3bE7P5ND56RLNrxgZji2dM/tCs+lu/kM8P/XCn80ySo9O2MSys6uepVv3CX8 bEwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This reverts commit 43d3487035e9a86fad952de4240a518614240d43. We cannot
use tagged struct groups in UAPI because C++ will throw syntax errors
even under "extern C".

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
---
 include/uapi/linux/ethtool.h | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index fc1f54b065f9..c405ed63acfa 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2511,24 +2511,21 @@ enum ethtool_reset_flags {
  *	autonegotiation; 0 if unknown or not applicable.  Read-only.
  */
 struct ethtool_link_settings {
-	/* New members MUST be added within the __struct_group() macro below. */
-	__struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
-		__u32	cmd;
-		__u32	speed;
-		__u8	duplex;
-		__u8	port;
-		__u8	phy_address;
-		__u8	autoneg;
-		__u8	mdio_support;
-		__u8	eth_tp_mdix;
-		__u8	eth_tp_mdix_ctrl;
-		__s8	link_mode_masks_nwords;
-		__u8	transceiver;
-		__u8	master_slave_cfg;
-		__u8	master_slave_state;
-		__u8	rate_matching;
-		__u32	reserved[7];
-	);
+	__u32	cmd;
+	__u32	speed;
+	__u8	duplex;
+	__u8	port;
+	__u8	phy_address;
+	__u8	autoneg;
+	__u8	mdio_support;
+	__u8	eth_tp_mdix;
+	__u8	eth_tp_mdix_ctrl;
+	__s8	link_mode_masks_nwords;
+	__u8	transceiver;
+	__u8	master_slave_cfg;
+	__u8	master_slave_state;
+	__u8	rate_matching;
+	__u32	reserved[7];
 	__u32	link_mode_masks[];
 	/* layout of link_mode_masks fields:
 	 * __u32 map_supported[link_mode_masks_nwords];
-- 
2.34.1


