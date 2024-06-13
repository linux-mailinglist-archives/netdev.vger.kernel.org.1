Return-Path: <netdev+bounces-103018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75578905FBE
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC6B281A4C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9460652;
	Thu, 13 Jun 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngwb8mI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A5171C1
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238744; cv=none; b=HHzdzDJ3Rug4xn4oAccv11htvWUGuz12pCIzUG5sI/dTJc/6XXCFhXp4Ata+a3bYCLnS76ACfnsnJTONAdkVG2RBAPqIqtm6xBCNvodMeFwrGhNCGEtmZ+J5WdDG9nuwwqVmrvh1X61zTS41E1Y6fT9CpckN8I2EvbBVPs8HT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238744; c=relaxed/simple;
	bh=CmBlsfAALNy9BI3JHhIDPVDzWhtgjOd2Mz9FbOSx26c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvokW8PX8zoJxe1UG37dHEiPF1XclCi1wdAAO/KbVyCYE9pWmk9yrMyNWPen+x3MgMF6sLnA0KbP47EtaY/8sSnS76rtjSIPzhbfU2DP+EMV2LjYxUXqkXcLkTu0M7CNopOSc85+pRjvaQD0mteiMHgY/pM0E7vCrDmveMFb3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngwb8mI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296F6C116B1;
	Thu, 13 Jun 2024 00:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718238744;
	bh=CmBlsfAALNy9BI3JHhIDPVDzWhtgjOd2Mz9FbOSx26c=;
	h=From:To:Cc:Subject:Date:From;
	b=Ngwb8mI+DjJMEpwCtBQwQQEeQ9wQaG32A8++cx2GaUAs6V4QOglYJ4OPlw66YpFLr
	 7EcH6RPX8E0IO74pm2GQUSSUSL9Ygk1r6Q5rJPWhKMSiXS4sFeVPFEqeQcOppAfAmG
	 IgnEcqQk9j5CuwJX+0FlkOUI30zhcbC6Ans/QSh6fVlRDjBe+TnPhdPptgq7XGfVo2
	 8H9gVe76RfYSDCJ7QJSCinZmlxIqQPWl3PdlOxQU05rryl46M83dbyZPJJrft9Zd6Q
	 78/ClGhJOFf4ZnjzXg904uL3ZOyyjOjuqSU/0/tTSJq9NkXhxmoiB2dDzTOQGwjokF
	 mAOy09v1vZEbA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next] eth: lan966x: don't clear unsupported stats
Date: Wed, 12 Jun 2024 17:32:22 -0700
Message-ID: <20240613003222.3327368-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 12c2d0a5b8e2 ("net: lan966x: add ethtool configuration and statistics")
added support for various standard stats. We should not clear the stats
which are not collected by the device. Core code uses a special
initializer to detect when device does not report given stat.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: horatiu.vultur@microchip.com
CC: UNGLinuxDriver@microchip.com
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
index 06811c60d598..c0fc85ac5db3 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c
@@ -376,7 +376,6 @@ static void lan966x_get_eth_mac_stats(struct net_device *dev,
 		lan966x->stats[idx + SYS_COUNT_TX_PMAC_BC];
 	mac_stats->SingleCollisionFrames =
 		lan966x->stats[idx + SYS_COUNT_TX_COL];
-	mac_stats->MultipleCollisionFrames = 0;
 	mac_stats->FramesReceivedOK =
 		lan966x->stats[idx + SYS_COUNT_RX_UC] +
 		lan966x->stats[idx + SYS_COUNT_RX_MC] +
@@ -384,26 +383,19 @@ static void lan966x_get_eth_mac_stats(struct net_device *dev,
 	mac_stats->FrameCheckSequenceErrors =
 		lan966x->stats[idx + SYS_COUNT_RX_CRC] +
 		lan966x->stats[idx + SYS_COUNT_RX_CRC];
-	mac_stats->AlignmentErrors = 0;
 	mac_stats->OctetsTransmittedOK =
 		lan966x->stats[idx + SYS_COUNT_TX_OCT] +
 		lan966x->stats[idx + SYS_COUNT_TX_PMAC_OCT];
 	mac_stats->FramesWithDeferredXmissions =
 		lan966x->stats[idx + SYS_COUNT_TX_MM_HOLD];
-	mac_stats->LateCollisions = 0;
-	mac_stats->FramesAbortedDueToXSColls = 0;
-	mac_stats->FramesLostDueToIntMACXmitError = 0;
-	mac_stats->CarrierSenseErrors = 0;
 	mac_stats->OctetsReceivedOK =
 		lan966x->stats[idx + SYS_COUNT_RX_OCT];
-	mac_stats->FramesLostDueToIntMACRcvError = 0;
 	mac_stats->MulticastFramesXmittedOK =
 		lan966x->stats[idx + SYS_COUNT_TX_MC] +
 		lan966x->stats[idx + SYS_COUNT_TX_PMAC_MC];
 	mac_stats->BroadcastFramesXmittedOK =
 		lan966x->stats[idx + SYS_COUNT_TX_BC] +
 		lan966x->stats[idx + SYS_COUNT_TX_PMAC_BC];
-	mac_stats->FramesWithExcessiveDeferral = 0;
 	mac_stats->MulticastFramesReceivedOK =
 		lan966x->stats[idx + SYS_COUNT_RX_MC];
 	mac_stats->BroadcastFramesReceivedOK =
-- 
2.45.2


