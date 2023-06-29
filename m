Return-Path: <netdev+bounces-14640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14847742C95
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D111C20B35
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2B14283;
	Thu, 29 Jun 2023 19:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FC14A87
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C30C43395;
	Thu, 29 Jun 2023 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065281;
	bh=mauEmIibkSzi6T2wNkYsvsVxn/WfSz8lZ3dKZtW4dAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdRRWuHqv/p9PA4gEoFaPrCXEeRjkmN/A7NfDn7QO3tMtcELm1yECOn7PebH55rny
	 sGE+zrUUzdDrWwgcCpNouHvd1VvRiykreQ1RmH9TZKqmGwf2FkPXOtJf3Z8X3tHBJx
	 EIz9h4vJqeLc0Qu80hSOMzNWv/R9jZlX/TwjmZUojXv5XEV3OaYZwVjdAGs8azBpGV
	 lDOFvZKIupsUTTCU4y/uM3GjFT1pgZpyavrJ4M2cZ/8LB5DlxHOirnLv8yshZGXY6F
	 hq7jbsanIJ4mQiTuqIoFHPoyNjVRWHMNHt4WoMcZjbWc97Nxc8QNXjWP+21VIGgDl/
	 Fjep5PI1xGTsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josua Mayer <josua@solid-run.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	ioana.ciornei@nxp.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 11/17] net: dpaa2-mac: add 25gbase-r support
Date: Thu, 29 Jun 2023 15:00:40 -0400
Message-Id: <20230629190049.907558-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 9a43827e876c9a071826cc81783aa2222b020f1d ]

Layerscape MACs support 25Gbps network speed with dpmac "CAUI" mode.
Add the mappings between DPMAC_ETH_IF_* and HY_INTERFACE_MODE_*, as well
as the 25000 mac capability.

Tested on SolidRun LX2162a Clearfog, serdes 1 protocol 18.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index c886f33f8c6fe..5ab24f18026b0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -54,6 +54,9 @@ static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
 	case DPMAC_ETH_IF_XFI:
 		*if_mode = PHY_INTERFACE_MODE_10GBASER;
 		break;
+	case DPMAC_ETH_IF_CAUI:
+		*if_mode = PHY_INTERFACE_MODE_25GBASER;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -79,6 +82,8 @@ static enum dpmac_eth_if dpmac_eth_if_mode(phy_interface_t if_mode)
 		return DPMAC_ETH_IF_XFI;
 	case PHY_INTERFACE_MODE_1000BASEX:
 		return DPMAC_ETH_IF_1000BASEX;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return DPMAC_ETH_IF_CAUI;
 	default:
 		return DPMAC_ETH_IF_MII;
 	}
@@ -417,7 +422,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 
 	mac->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD | MAC_5000FD |
-		MAC_10000FD;
+		MAC_10000FD | MAC_25000FD;
 
 	dpaa2_mac_set_supported_interfaces(mac);
 
-- 
2.39.2


