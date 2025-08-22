Return-Path: <netdev+bounces-215989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85005B3143F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CD3B02D5F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977F2F6581;
	Fri, 22 Aug 2025 09:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C932F5461
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855634; cv=none; b=V3JyFVDvOuPz9CAyleQSbx0hEFp1KBmLYFdrg8jYn2fSXw2Fq0ZPmldubrwKcmcVdBuYFjceiUXLZnKEghRDWw43bYKpLK+rLXPgStRD9NaIyfWduCQ1w5a/YHm9htpOJslqZwMfnzCQVHKwFjd1SE/xYfM9k7fWYahgqDbhXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855634; c=relaxed/simple;
	bh=Mfh6IznOBaQuafYVuPQLNT0TvqF/soo23QMczzfIN7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCsY2lF+5/bozW6qXJx3BDMUkXL3Mu8DeB4T9eFEOP2AXsxIclEW9pbuBjSKIYtQ16U7Kw6qqNKDIVMtvo4/ltiR4UA3IvwBUX5621NJKCraeqc5wQAmSKM0MpxEHOemYNOVKeuC9n/Azr371HvGYWaZZQXBSxud5ePG3lWDrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEF4921D7D;
	Fri, 22 Aug 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D323C13A31;
	Fri, 22 Aug 2025 09:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oOxBMc05qGihMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 22 Aug 2025 09:35:09 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 1/5] net: cadence: macb: Set upper 32bits of DMA ring buffer
Date: Fri, 22 Aug 2025 12:34:36 +0300
Message-ID: <20250822093440.53941-2-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250822093440.53941-1-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt,netdev]
X-Rspamd-Queue-Id: DEF4921D7D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

In case of rx queue reset and 64bit capable hardware, set the upper
32bits of DMA ring buffer address.

Cc: stable@vger.kernel.org # v4.6+
Fixes: 9ba723b081a2 ("net: macb: remove BUG_ON() and reset the queue to handle RX errors")
Credits-to: Phil Elwell <phil@raspberrypi.com>
Credits-to: Jonathan Bell <jonathan@raspberrypi.com>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v1 -> v2: 
 - Added credits.
 - Use lower_32_bits() for RBQP register writes for consistency (Nicolas).
 - Added Fixes tag.

 drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd..36717e7e5811 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1634,7 +1634,11 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 
 		macb_init_rx_ring(queue);
-		queue_writel(queue, RBQP, queue->rx_ring_dma);
+		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+			macb_writel(bp, RBQPH, upper_32_bits(queue->rx_ring_dma));
+#endif
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
 
-- 
2.47.0


