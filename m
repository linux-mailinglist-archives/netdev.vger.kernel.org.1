Return-Path: <netdev+bounces-273952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK/jIozLzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:38:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E52376103
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6011931248C9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6929383C99;
	Wed,  1 Apr 2026 07:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF51367F31
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028838; cv=none; b=gyrmSr6bW3ZBdF0sSWtvAXpkv8U8a3N7J9bz6je3sJ2YdD4EZTSYlP5xhopOG3HXnndHcbvIolC42rDfNCNrz+clXFSNwmz72HeQyRxwRXezrxCgkNbOT6JbkptnHJ9fg74eN5u/WuIMHz/VmAsgkpinuesBADFR0ce0FvDSYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028838; c=relaxed/simple;
	bh=migbb/8FUb4/HzK/8zwo5lR0u1Zrd2aghHIXVPoz45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqK3Okxg8Lca2iip2RpTDOrK6jNX93Es0PdcGv7VBj08hEHwukHUI7IDyaagySKN/e5kThLuI2bbuFuw3OkOvwUzmNxQSzD658kwBSUHFFHFURPeCue9eD+aNVMEPoT0MKNRDBQ6tkn/JyxyObwy/UNrR9tJ+kMCsVK5uUXhEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-00076f-JS; Wed, 01 Apr 2026 09:33:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-003Ahb-0t;
	Wed, 01 Apr 2026 09:33:41 +0200
Received: from blackshift.org (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E1C65513377;
	Wed, 01 Apr 2026 07:33:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/6] can: mcp251xfd: add support for XSTBYEN transceiver standby control
Date: Wed,  1 Apr 2026 09:30:12 +0200
Message-ID: <20260401073338.5592-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401073338.5592-1-mkl@pengutronix.de>
References: <20260401073338.5592-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-273952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.650];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: 08E52376103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

The MCP251xFD has a dedicated transceiver standby control function on
the INT0/GPIO0/XSTBY pin, controlled by the XSTBYEN bit in IOCON.
When enabled, the hardware automatically manages the transceiver
standby state: the pin is driven low when the controller is active
and high when it enters Sleep mode.

Enable this feature when the 'microchip,xstbyen' device tree property
is present.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260321135031.3107408-3-viken.dadhaniya@oss.qualcomm.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 37 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9c86df08c2c5..92a86083c896 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -764,6 +764,31 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 }
 
+static int mcp251xfd_chip_xstbyen_enable(const struct mcp251xfd_priv *priv)
+{
+	/* Configure the INT0/GPIO0/XSTBY pin as transceiver standby control:
+	 *
+	 * - XSTBYEN=1: route the pin to the transceiver standby function
+	 * - TRIS0=0:   set output direction; the reset default is 1 (input),
+	 *              which leaves the pin floating HIGH and keeps the
+	 *              transceiver in standby regardless of XSTBYEN
+	 * - LAT0=0:    drive pin LOW => transceiver active (not in standby)
+	 *
+	 * All three bits are included in the mask; only XSTBYEN is set in
+	 * val, so TRIS0 and LAT0 are cleared to 0 atomically.
+	 *
+	 * Pin behaviour by mode:
+	 * - Config mode: controlled by LAT0 (LAT0=0 => LOW => active)
+	 * - Normal mode: hardware drives pin LOW (active)
+	 * - Sleep mode:  hardware drives pin HIGH (standby)
+	 */
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  MCP251XFD_REG_IOCON_XSTBYEN |
+				  MCP251XFD_REG_IOCON_TRIS0 |
+				  MCP251XFD_REG_IOCON_LAT0,
+				  MCP251XFD_REG_IOCON_XSTBYEN);
+}
+
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 {
 	int err;
@@ -796,6 +821,12 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	if (priv->xstbyen) {
+		err = mcp251xfd_chip_xstbyen_enable(priv);
+		if (err)
+			goto out_chip_stop;
+	}
+
 	err = mcp251xfd_chip_set_normal_mode(priv);
 	if (err)
 		goto out_chip_stop;
@@ -1805,6 +1836,11 @@ static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
 	int ret;
 
+	if (priv->xstbyen && offset == 0) {
+		netdev_err(priv->ndev, "Can't use GPIO 0 with XSTBYEN!\n");
+		return -EINVAL;
+	}
+
 	if (priv->rx_int && offset == 1) {
 		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
 		return -EINVAL;
@@ -2271,6 +2307,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->pll_enable = pll_enable;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
+	priv->xstbyen = device_property_present(&spi->dev, "microchip,xstbyen");
 	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
 
 	/* Errata Reference:
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 085d7101e595..d3f4704e2678 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -672,6 +672,7 @@ struct mcp251xfd_priv {
 	struct gpio_desc *rx_int;
 	struct clk *clk;
 	bool pll_enable;
+	bool xstbyen;
 	struct regulator *reg_vdd;
 	struct regulator *reg_xceiver;
 
-- 
2.53.0


