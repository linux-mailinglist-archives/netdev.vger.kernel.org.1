Return-Path: <netdev+bounces-72069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072E856773
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C391F274B4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180A133983;
	Thu, 15 Feb 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="WSFCdqFk"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E78132C1E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010576; cv=none; b=r1AjskFZJaK5C81t+i7tkGN9RkMLjHbLRSS64UoeRTOcJaHJ9Dr/owRnZCl+DJAl8ghSurk/MGugj1ETQ3WN4ku0ny+VcGJCzWFBxNwjuAbUXaqkiQWtbYEqJm5YwHtw5yIpkXBv29i2PlRqSl8SpIlI0vChjfclkzE/b+5r0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010576; c=relaxed/simple;
	bh=FO7jRW8lFIFAdFgQNKkjdDeHv4Jt6uYAUDOvYJToSHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=do4oc6EbZKSHBvna+Le8CsQQ95XPkeWhg5cbVSy3c2FyRyBaalvXP88GEvAENco4mTLK5dXVBkwZyypL754QdWraYrc3F7m3nnNNXX1wzmvtSz3H+gjPXHhOpLg4HnoUvtTAXBocQAiDJYvPwOd4k1WKSd5sNOo5OO0JUFbLb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=WSFCdqFk; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024021515224313aee860e09d055415
        for <netdev@vger.kernel.org>;
        Thu, 15 Feb 2024 16:22:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=nuPT01weBKXw5lY3LWl5ewOYMWR86hkUe5K2ujILz3M=;
 b=WSFCdqFkdPSyf+CjiQLHiiidUlTGuRay8ha8SX2t903CHQ46BgNrhbhaw6UuE4YfmmO4+d
 PDH9bSM135kPuc0DZGbffXIfqyySQTjHJo4CwEv92g7EAq0HROIYM0Ar8hMqZbmtRMTVkXJW
 PH+Ij0JsMoNSZoE0LI8f3HN0q607A=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	jan.kiszka@siemens.com,
	dan.carpenter@linaro.org,
	robh@kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: ti: icssg-prueth: Remove duplicate cleanup calls in emac_ndo_stop()
Date: Thu, 15 Feb 2024 15:22:01 +0000
Message-ID: <20240215152203.431268-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Remove the duplicate calls to prueth_emac_stop() and
prueth_cleanup_tx_chns() in emac_ndo_stop().

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v2:
 - Removed Fixes: tags
 - Added Reviewed-by's

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 411898a4f38c..cf7b73f8f450 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1489,9 +1489,6 @@ static int emac_ndo_stop(struct net_device *ndev)
 	/* Destroying the queued work in ndo_stop() */
 	cancel_delayed_work_sync(&emac->stats_work);
 
-	/* stop PRUs */
-	prueth_emac_stop(emac);
-
 	if (prueth->emacs_initialized == 1)
 		icss_iep_exit(emac->iep);
 
@@ -1502,7 +1499,6 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	free_irq(emac->rx_chns.irq[rx_flow], emac);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
-	prueth_cleanup_tx_chns(emac);
 
 	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
 	prueth_cleanup_tx_chns(emac);
-- 
2.43.1


