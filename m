Return-Path: <netdev+bounces-214070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA482B28123
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5035AE645F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218C306D22;
	Fri, 15 Aug 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v5abB8r9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BxjtYlhC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v5abB8r9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BxjtYlhC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B2305E37
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266372; cv=none; b=JfC2NhBKyJOc1FensL/7g8P0lVs012PZmqOWPQjl6snklYc6XYALmDZhfoCmEV6j/eJlOAs54uvhiE+7LyJvkRPKIwRDaABDeqGn3gTaxq5M4YBgmLumO1nM5QlVnFUPbSpL2KHSx7tTiQ0f7GI2CrB4shYI9I94tNh/5wxJoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266372; c=relaxed/simple;
	bh=62JJ3mcKCR4+G3GTfvetNzI+Q2IUgRjTuCgggk0c3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QboOFBFiecllBzmHCJCK+3I7Exk9GxIUqZqCIwBmGRuihZOHSAJx3bkwn7eCuSJ8jgOPlEzEvK4CoA2nm0TdmtPoaXUD/pUqBxc4X8Zvphkf1rlFDd9BJ6s7M36Aw3xtQHb+XUtPo2kLQ6JjcypTtJntddSOYozw0QPJ+RK3yqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v5abB8r9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BxjtYlhC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v5abB8r9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BxjtYlhC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 765B1211CA;
	Fri, 15 Aug 2025 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755266363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rATcQvZ0aWEqvospJ3OJNReLtH8/w3403mThJdsPTLA=;
	b=v5abB8r96do3bsUUsC7jUqqAdBoe2NUVjKczBhlQek8WjuCeaZf3AabqWcfxX1cBC70Pkm
	Zhv9yVIFhzEk3wzhhC3gWrYHPCcIiVxNWUZEzRuaYmXlUdlMxOMfPxLie7qWgNjo4UBgdk
	dngSDGnhpHXxFDuXrh1AoSLKYcEbd3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755266363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rATcQvZ0aWEqvospJ3OJNReLtH8/w3403mThJdsPTLA=;
	b=BxjtYlhCzY0h/iDDxIZHDSWHJgkgP+i74rrp+Zhrz5Z6+Xv9oddpRhn8C1WSLviXPxpDyk
	frLbbqN1JT8NRFBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v5abB8r9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BxjtYlhC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755266363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rATcQvZ0aWEqvospJ3OJNReLtH8/w3403mThJdsPTLA=;
	b=v5abB8r96do3bsUUsC7jUqqAdBoe2NUVjKczBhlQek8WjuCeaZf3AabqWcfxX1cBC70Pkm
	Zhv9yVIFhzEk3wzhhC3gWrYHPCcIiVxNWUZEzRuaYmXlUdlMxOMfPxLie7qWgNjo4UBgdk
	dngSDGnhpHXxFDuXrh1AoSLKYcEbd3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755266363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rATcQvZ0aWEqvospJ3OJNReLtH8/w3403mThJdsPTLA=;
	b=BxjtYlhCzY0h/iDDxIZHDSWHJgkgP+i74rrp+Zhrz5Z6+Xv9oddpRhn8C1WSLviXPxpDyk
	frLbbqN1JT8NRFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D1F13A8B;
	Fri, 15 Aug 2025 13:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wBxUGjo9n2jMfAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 15 Aug 2025 13:59:22 +0000
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
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 3/5] net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller
Date: Fri, 15 Aug 2025 16:59:09 +0300
Message-ID: <20250815135911.1383385-4-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815135911.1383385-1-svarbanov@suse.de>
References: <20250815135911.1383385-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLw7mkaud87zuqqztkur5718rm)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 765B1211CA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The RP1 chip has the Cadence GEM block, but wants the tx_clock
to always run at 125MHz, in the same way as sama7g5.
Add the relevant configuration.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 41c0cbb5262e..d3d5fcd42c30 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5136,6 +5136,17 @@ static const struct macb_config versal_config = {
 	.usrio = &macb_default_usrio,
 };
 
+static const struct macb_config raspberrypi_rp1_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
+		MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = macb_init,
+	.usrio = &macb_default_usrio,
+	.jumbo_max_len = 10240,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
 	{ .compatible = "cdns,macb" },
@@ -5156,6 +5167,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
+	{ .compatible = "raspberrypi,rp1-gem", .data = &raspberrypi_rp1_config },
 	{ .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "xlnx,zynq-gem", .data = &zynq_config },
 	{ .compatible = "xlnx,versal-gem", .data = &versal_config},
-- 
2.47.0


