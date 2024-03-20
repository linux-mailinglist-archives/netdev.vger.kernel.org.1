Return-Path: <netdev+bounces-80838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC13088139B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B682838AD
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D760953392;
	Wed, 20 Mar 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="DZgAYkXG"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3951C2A
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945780; cv=none; b=JpbOdS+4goSci8rfcwYLo3WaqLF5YjkX76LF8XTCBLmZC6waKJoHLUNRxXggoHOOG9Rsui+GYsD2yiPPLryEtRyOkjS3XldDkKxJ/fBWX2rN4S4A1wuAfSWKfFY7PcbUR6pxl3gWoiOBe4H9af6FPlmDBTI4nrZ4EC2GAsJCE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945780; c=relaxed/simple;
	bh=FVupAo+cSrbzqgRgohX4zj8QK5LLqbcIs2vDhEC+9es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ+QegdtR0c6R/76g5NKNVRmpUTeXZ+dFmKNZrxwkvK6cTEh54kxrQ8JAwL6nIcZ/GsJ/fmsMtnf5M4p1g4bjwgdMcgFa8CrHYLbyYY7dVTZ8rVlMDGVV573RqqhCj58xcd9xQlqopEmbICp1+6Z5RhncWcearhdS2RDNZ2y3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=DZgAYkXG; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202403201442587776c5713f6b79131a
        for <netdev@vger.kernel.org>;
        Wed, 20 Mar 2024 15:42:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mT1ZqN3HVk2/tJvY22Xtc/ZtSAN7kqkeHXbh9Kuw+D8=;
 b=DZgAYkXGICl+YimvupFzRUcGT/hp3HwqL6KdiQsmwBmpFhRqzddiuI0pZO9J4vOZZomS2p
 rnxpcFyhlrBIPGGkSfysdj/6dFh9Up72PhSXXgKFM6dMwQ6WIui8a26BJjQ4MwIdlOBC7K0r
 LIz+++RwjDJy2W1DQLIbIGaInU5do=;
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
Subject: [PATCH net-next v5 07/10] net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
Date: Wed, 20 Mar 2024 14:42:29 +0000
Message-ID: <20240320144234.313672-8-diogo.ivo@siemens.com>
In-Reply-To: <20240320144234.313672-1-diogo.ivo@siemens.com>
References: <20240320144234.313672-1-diogo.ivo@siemens.com>
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


