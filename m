Return-Path: <netdev+bounces-84406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C245896D1A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9C2285A71
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E603142E6F;
	Wed,  3 Apr 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="WNQvrGOU"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977D139D0A
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141318; cv=none; b=jMOJVwmQCeDQ0JEXigwErgyxwfKqUdzOzbdvvox1Z+s9IfPtrn37GLDa0WZY4/a+UYxHNAu/WPFjZaCtM1Tt1f7owpI5TsriBqMqe5IeVRWdN+yRzG3cvOjnIKNCCozg/HF5kD92a6GqOaUMILBGRB8oPyujHvKmMa80Qu9/1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141318; c=relaxed/simple;
	bh=FVupAo+cSrbzqgRgohX4zj8QK5LLqbcIs2vDhEC+9es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhSMQdPsuH+am3lW/H47EHflsceYI9DLey66lJxj5r/Jixvq3NE2rTdBGCkGZYMuSEjyoCRVoaeAX1HAx1Q2dFsXgWdtkSIKIXo8423k2A0ZVjq2iTROlR/BYhxmXovPbr4krQ7iYze+JoCrVeSodhyT1OASdMxtfrRZpKIiiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=WNQvrGOU; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240403104833b14847bb06d787e500
        for <netdev@vger.kernel.org>;
        Wed, 03 Apr 2024 12:48:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mT1ZqN3HVk2/tJvY22Xtc/ZtSAN7kqkeHXbh9Kuw+D8=;
 b=WNQvrGOU1i8BlgE3MpUlB2mmsG+67QeTufrGEbrsFNVVbSwq6hNDGstk5ZH8jz9KyTS+5a
 KLHnCWWHhkFia/b5wYD6L6bWtTcFWISS3J53cy/Vz1G8q8oPURhlIS1xb1xpI+FuF2zQbHz+
 ozE/5onhzjBv8XKTvRxJCmrDD14b0=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v6 07/10] net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
Date: Wed,  3 Apr 2024 11:48:17 +0100
Message-ID: <20240403104821.283832-8-diogo.ivo@siemens.com>
In-Reply-To: <20240403104821.283832-1-diogo.ivo@siemens.com>
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

As SR1.0 uses the current higher priority channel to send commands to
the firmware, take this into account when setting/getting the number
of channels to/from the user.

Based on the work of Roger Quadros in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v5:
 - Restrict number of TX channels to 1 to avoid timeouts
 - Added Reviewed-by tag from Danish 

Changes in v4:
 - Add Reviewed-by from Roger

Changes in v3:
 - Address Roger's comments on SR1.0 handling

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 9a7dd7efcf69..ca20325d4d3e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -142,6 +142,9 @@ static int emac_set_channels(struct net_device *ndev,
 
 	emac->tx_ch_num = ch->tx_count;
 
+	if (emac->is_sr1)
+		emac->tx_ch_num++;
+
 	return 0;
 }
 
@@ -152,8 +155,17 @@ static void emac_get_channels(struct net_device *ndev,
 
 	ch->max_rx = 1;
 	ch->max_tx = PRUETH_MAX_TX_QUEUES;
+
+	/* Disable multiple TX channels due to timeouts
+	 * when using more than one queue */
+	if (emac->is_sr1)
+		ch->max_tx = 1;
+
 	ch->rx_count = 1;
 	ch->tx_count = emac->tx_ch_num;
+
+	if (emac->is_sr1)
+		ch->tx_count--;
 }
 
 static const struct ethtool_rmon_hist_range emac_rmon_ranges[] = {
-- 
2.44.0


