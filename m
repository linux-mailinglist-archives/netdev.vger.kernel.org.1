Return-Path: <netdev+bounces-211751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EFFB1B798
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FF1625A29
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9027BF6C;
	Tue,  5 Aug 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kv7ki/X0"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B427A461
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408122; cv=none; b=N0H0H/8iCwbudsJ7Cam0mxYUZQZD6JAJc8Cn5HjzI3XcEShsbqdoU7623WB0/SBwBowEmtcV0+BmQJYjqLE+mHTrU41Era9evlhQYN+ZRViZPcz3dhjzOqfsnoukZp9OYM9qhUQsFCWfvUXL+y7vxjDKN/zO4QXs9f+mJw06U/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408122; c=relaxed/simple;
	bh=JINeEfUReHlNfN4Ns88LU3c1dRlUKvpggMNQDivnrWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMRHnZQ+hla86mzpyN8/ukOnOmdRMlv1WdCmtOJZz9DXu/CaccqsDsICRCs8mNjpEcAstYWxOtLa584b8IhsWu2bdP5jOBhSx1fEKklxfjQAOBlV/AYDkmO6rSx2A8ICJn4P8E39bYCTuWOdmuxOYs4f8WCv7ZRenTnrg2JGOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kv7ki/X0; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754408118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e10nwhxIlKlTQ6jthVLQK0vr7NmPf1h0C4lBIa7W+ls=;
	b=Kv7ki/X0PsflZN88cFaLMLhtxUkWt33JZfCUJy2KKmgkrUzome7qbHV+B0GVsLHaEA5OT/
	aeIplRfGiARRhVYpjErSdPpFn1oajrNuN2Z4dvYiQ1aTtjz4+QsTycLeW8ZzPj+JOO9F8T
	SRNadM2VR3ZT0ExfqMqPD5agQPvkq4E=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v4 4/7] net: axienet: Simplify axienet_mdio_setup
Date: Tue,  5 Aug 2025 11:34:53 -0400
Message-Id: <20250805153456.1313661-5-sean.anderson@linux.dev>
In-Reply-To: <20250805153456.1313661-1-sean.anderson@linux.dev>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We always put the mdio_node and disable the bus after probing, so
perform these steps unconditionally.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index dd5f961801dc..1903a1d50b05 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -302,19 +302,14 @@ int axienet_mdio_setup(struct axienet_local *lp)
 	ret = axienet_mdio_enable(bus, mdio_node);
 	if (ret < 0)
 		goto unregister;
+
 	ret = of_mdiobus_register(bus, mdio_node);
-	if (ret)
-		goto unregister_mdio_enabled;
 	of_node_put(mdio_node);
 	axienet_mdio_mdc_disable(lp);
-	return 0;
-
-unregister_mdio_enabled:
-	axienet_mdio_mdc_disable(lp);
-unregister:
-	of_node_put(mdio_node);
-	mdiobus_free(bus);
-	lp->mii_bus = NULL;
+	if (ret) {
+		mdiobus_free(bus);
+		lp->mii_bus = NULL;
+	}
 	return ret;
 }
 
-- 
2.35.1.1320.gc452695387.dirty


