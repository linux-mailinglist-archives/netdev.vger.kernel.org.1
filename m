Return-Path: <netdev+bounces-228741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB0EBD3840
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC5A3B9B35
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323323AB90;
	Mon, 13 Oct 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkvWaaKS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE12238D42
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365798; cv=none; b=oRwsZSWan7fJjYTjfWLoHVea10dg/1RU61/qdL4ZHbe9i5wPrr2SbwRgnDAPUn3+PfU1gYf1bc4sDIMfMpL9PQ6dDx9AbIChHlbeN3NGKgbj8hZQ/KgxbpwMsVkP9A7CLxyk/0NdDz4a9f4jSB2g1weh1EKmbQWtdkebypKdBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365798; c=relaxed/simple;
	bh=C38NliXvvb6uR3UBVTpdAevmxNu5WA07aZHQC+FR338=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MO9eQ75dFaUuBBLITRA6TmtuUXhdX76YqDwpSFHoTzKrSjY1drKUzdxfztUPluQsR0Sm2btsWiIgwa383sTzWGyO4jB0ygXXNLq2V5idHR84nNDGe7Su7UatXBdl0WOHpHuCm7GLfN+9ei0fKNT2H7rL2rRsuhPMv5N622rgpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkvWaaKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986F6C4CEFE;
	Mon, 13 Oct 2025 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760365798;
	bh=C38NliXvvb6uR3UBVTpdAevmxNu5WA07aZHQC+FR338=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nkvWaaKSqQs9P5RMopsoSbKSny1SCQc+6CI+/jI3f278qO2EbRlqglFl+VpNGB4dA
	 tO/AKYcU++WDUrJaB8yE9oNyaTF0X06XJASrSUM6/OsmZCzlFW2mnUZOfCmPOX6qy/
	 oMKFT0R9qR99l4ZW+xl4/HBCKae5vy4EPVhhnI+j20St+q53kOheYJ/u0hH9eyElls
	 iE49G1pCWvNyT34jMUgu7afgrvKWAJaDLJW6ZElOElNw3r2eecc9JstPEIaAczNzhs
	 ZdIeV9w7R9sUcWiiNwZA6sD//Ed5opkh/WNoXfiLGnMEpCrJSAWk0EmZmNimv5k8aM
	 bvtGsM8AMX/Bw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 13 Oct 2025 16:29:41 +0200
Subject: [PATCH net-next 1/2] net: airoha: Add missing stats to
 ethtool_eth_mac_stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-airoha-ethtool-improvements-v1-1-fdd1c6fc9be1@kernel.org>
References: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
In-Reply-To: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Add the following stats to ethtool ethtool_eth_mac_stats stats:
- FramesTransmittedOK
- OctetsTransmittedOK
- FramesReceivedOK
- OctetsReceivedOK

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 833dd911980b3f698bd7e5f9fd9e2ce131dd5222..2fe1f39558b80926439cc2f765eb5057464dd76e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2022,8 +2022,12 @@ static void airoha_ethtool_get_mac_stats(struct net_device *dev,
 	airoha_update_hw_stats(port);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
+		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
+		stats->OctetsTransmittedOK = port->stats.tx_ok_bytes;
 		stats->MulticastFramesXmittedOK = port->stats.tx_multicast;
 		stats->BroadcastFramesXmittedOK = port->stats.tx_broadcast;
+		stats->FramesReceivedOK = port->stats.rx_ok_pkts;
+		stats->OctetsReceivedOK = port->stats.rx_ok_bytes;
 		stats->BroadcastFramesReceivedOK = port->stats.rx_broadcast;
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }

-- 
2.51.0


