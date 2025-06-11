Return-Path: <netdev+bounces-196623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92286AD596E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5751117EB16
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D62BE7A6;
	Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWzeTQ7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA532BDC3E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653996; cv=none; b=UIj2arTit4ujI4BxqYPnQ0vPPrSIGNfCXTOz+GqtcnMvzC+6piXGFbWMyyIF5ilcvZkazd9Tpk8csHzJUFPziVLT3GzhCZCAk38MnwvvV4WCEdkBC1cJ8R7UehiNXmvk06aLByodNopCt2D7qi02flym/ej+sEAn42uQqSbSZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653996; c=relaxed/simple;
	bh=b+MjG+O8o+fa39WBcsootOjm2wE5aI/RYXAF+EDnoqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paBA9iZNxiG9zl3+Rd0CfBf57XikhtViAlo6d+6/JWqKB/IRJQDj1NnQE4pcafCRVxJ5l9yBANoNeTg44v1u2xq8cOiSBWKIu6I5UXiYLKud2vxGAtubaZsrgdtny/JwPjR8aPZ+sJ5h5uid8Yh9oF1qoa5aV2xgIJ2dJL9bPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWzeTQ7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34707C4CEFB;
	Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653996;
	bh=b+MjG+O8o+fa39WBcsootOjm2wE5aI/RYXAF+EDnoqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWzeTQ7okaDGtCn1iXEMWSu+oJumh/38fYFxIwvqTLFSR0wgv6U1VHLwSbNXX+/En
	 JxywmV3jTuKtGzoOMpb/Nq2AIa1mP9ckeCFU5bp7DaTGg1/XJrpXlbqHBp+pFsNhwy
	 PaCN9d1BKnwEh3Pijs3gF0yebYxE3c4uyk+A/R/mKwIBd6WHGlqqjU3ct9FbohbUTV
	 niviNUW5Yj6tfpqPnZbMC4LbNunU/nn5qEPBi94eU+WIBwjOqY5N6WEwDM5zrvubVB
	 xZ8FiObMreu3IaP7irBxFr1Jhl5ebmnNFg4M8rIufh0mmrhcuGe0HFY4b06udTs1XP
	 9mw/OnDhOkhRQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	jeroendb@google.com,
	hramamurthy@google.com,
	marcin.s.wojtas@gmail.com,
	willemb@google.com,
	pkaligineedi@google.com,
	joshwash@google.com,
	ziweixiao@google.com
Subject: [PATCH net-next 5/9] eth: remove empty RXFH handling from drivers
Date: Wed, 11 Jun 2025 07:59:45 -0700
Message-ID: <20250611145949.2674086-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're migrating RXFH config to new callbacks.
Remove RXFH handling from drivers where it does nothing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jeroendb@google.com
CC: hramamurthy@google.com
CC: marcin.s.wojtas@gmail.com
CC: willemb@google.com
CC: pkaligineedi@google.com
CC: joshwash@google.com
CC: ziweixiao@google.com
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 6 ------
 drivers/net/ethernet/marvell/mvneta.c         | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 3c1da0cf3f61..a6d0089ecd7b 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -798,9 +798,6 @@ static int gve_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXCLSRLDEL:
 		err = gve_del_flow_rule(priv, cmd);
 		break;
-	case ETHTOOL_SRXFH:
-		err = -EOPNOTSUPP;
-		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -835,9 +832,6 @@ static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u
 	case ETHTOOL_GRXCLSRLALL:
 		err = gve_get_flow_rule_ids(priv, cmd, (u32 *)rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		err = -EOPNOTSUPP;
-		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 147571fdada3..feab392ab2ee 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5014,8 +5014,6 @@ static int mvneta_ethtool_get_rxnfc(struct net_device *dev,
 	case ETHTOOL_GRXRINGS:
 		info->data =  rxq_number;
 		return 0;
-	case ETHTOOL_GRXFH:
-		return -EOPNOTSUPP;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.49.0


