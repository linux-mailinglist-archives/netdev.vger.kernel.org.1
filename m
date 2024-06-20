Return-Path: <netdev+bounces-105379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A8910E76
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA38285B36
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8EC1B47A6;
	Thu, 20 Jun 2024 17:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C31B3F20;
	Thu, 20 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904390; cv=none; b=DTRJN5YZD2lXBoCVMF7FGVNVFRgRef38l4KJRetQ91966nvoS4r6ZfeFaX/XRBUIdl9lH0POIk0ELEeQlHgdCGzvQM1n+egpr3jhDLAyJA/U2C6JIfqQy8XkrBQUdNnb+jY+pyA9ynqQ4c21Vm83q2I5GxIcWisQqLh5UWwT0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904390; c=relaxed/simple;
	bh=BIG3IdgzLqLpVof7URKdPMLEz+6z8QlvjSJwuwcRHnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi7PIvkeuHNSZdbOzNNsOcVgqZIRLQeeUrkBPUUelZLsvSm83YQwxb8eGtG5Rb0UXYM06+mMPCL6KSO9V0ZtKbTUiLRi+v7DS6q6z6s394CugiIHnm10WFlBFB1xFndK+6RUyAEoan/v8f6OG/g/t5yMAOB6Dicj2QlOnX5zKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id 4095C1FC64;
	Thu, 20 Jun 2024 19:26:21 +0200 (CEST)
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next 1/3] net: dsa: qca8k: do not write port mask twice in bridge join/leave
Date: Thu, 20 Jun 2024 19:25:48 +0200
Message-ID: <9e5682c68a4930dae2e277b9cecc8b8ec97ba2af.1718899575.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718899575.git.mschiffer@universe-factory.net>
References: <cover.1718899575.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qca8k_port_bridge_join() set QCA8K_PORT_LOOKUP_CTRL() for i == port twice,
once in the loop handling all other port's masks, and finally at the end
with the accumulated port_mask.

The first time it would incorrectly set the port's own bit in the mask,
only to correct the mistake a moment later. qca8k_port_bridge_leave() had
the same issue, but here the regmap_clear_bits() was a no-op rather than
setting an unintended value.

Remove the duplicate assignment by skipping the whole loop iteration for
i == port. The unintended bit setting doesn't seem to have any negative
effects (even when not reverted right away), so the change is submitted
as a simple cleanup rather than a fix.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 drivers/net/dsa/qca/qca8k-common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 7f80035c5441..b33df84070d3 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -653,6 +653,8 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 	port_mask = BIT(cpu_port);
 
 	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (i == port)
+			continue;
 		if (dsa_is_cpu_port(ds, i))
 			continue;
 		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
@@ -665,8 +667,7 @@ int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 				      BIT(port));
 		if (ret)
 			return ret;
-		if (i != port)
-			port_mask |= BIT(i);
+		port_mask |= BIT(i);
 	}
 
 	/* Add all other ports to this ports portvlan mask */
@@ -685,6 +686,8 @@ void qca8k_port_bridge_leave(struct dsa_switch *ds, int port,
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
 	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
+		if (i == port)
+			continue;
 		if (dsa_is_cpu_port(ds, i))
 			continue;
 		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
-- 
2.45.2


