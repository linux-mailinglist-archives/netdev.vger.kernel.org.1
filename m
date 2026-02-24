Return-Path: <netdev+bounces-260429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FSyN4ZunWk9QAQAu9opvQ
	(envelope-from <netdev+bounces-260429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F667184870
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1C5531BB4C0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83136AB79;
	Tue, 24 Feb 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XW6Rfr1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761836C0DA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924751; cv=none; b=SGX4M2wC+NBsazwYlOlh0D3v1HFITXRb3x0jRM04XTTEwFp44BdqQY8xssTZBc6bg5OR0vk4Wy5mw8HIhMLQxlmMeEU4v2um6sVOqai3MgUMbbsEY649uaJjuhanyFiRFLIXEb9ozkD9DSVvqyn+Qa2nrdvUO/yn31JXpLO/WII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924751; c=relaxed/simple;
	bh=kYK6SZK/WNmdUxFBeEotcBGf1PSahyDBkSvij/yVIhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2VGgUYH5r6nuadvFDaPAZBIYVPEf3Qw0sUkzzvF2rnUF9FMEsy1w2jgDZgpxAm7FFKeDRa3EmAETPMxEwJWizcUQ6cUJeQhCXKNVtRO6u3ZBFNFUDp8qFxaKqaMJo7wke77evkI8+j8L91ahdWidaSyRxcm1VH7Kg2LUrZQy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XW6Rfr1f; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA488A3F88;
	Tue, 24 Feb 2026 10:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771924740; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ihdBebgSYrU0CQ4pyfCLGaLrNqGLAzqUg7DtWwB4pIs=;
	b=XW6Rfr1fa4L4KL+vsATX8OP63NfJqBBntC1aseZYLR19ebc+lEnIgLrvc2JGekg9y6VKrg
	gBZ5u/J7oT05tjjDbhDXlkxIwtCYvTSXPOG8e1Wa0K1+PO2a7yXOXiZP/dYf5bsoLpdAfT
	MLVmL03niYFr0mLKd/JKUSLylTqZB4LzmP07XUhOYYBOa/HTKWeaHaobdGQoz90Ohk4rQW
	Ut6KiYcXw9FIzEaLovCHvzUF7SVZkLcV+MWNBzrd2H6sGOOUbkVK8f6QMXTSK4UqnF0u3e
	rjRVkOCrBuNFrpHEm8ylnilnFinto4h5QPuqgtHHyLjSONJMVLVGWzwoFIfHmQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v2 5/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Tue, 24 Feb 2026 10:18:21 +0100
Message-Id: <20260224091821.47671-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260224091821.47671-1-nb@tipi-net.de>
References: <20260224091821.47671-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-260429-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 7F667184870
X-Rspamd-Action: no action

Enable IEEE 802.3az Energy Efficient Ethernet on the Raspberry Pi 5's
RP1 southbridge by adding MACB_CAPS_EEE to its platform config.

The RP1 contains a Cadence GEM_GXL MAC (revision 0x00070109) paired
with a Broadcom BCM54213PE PHY, both of which support EEE at
1000BASE-T and 100BASE-TX.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 87097100b88c..2bf27a266e16 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5516,7 +5516,8 @@ static const struct macb_config eyeq5_config = {
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.51.0


