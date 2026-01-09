Return-Path: <netdev+bounces-248526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7133D0A9CC
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDB193032E85
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7AA35CBAB;
	Fri,  9 Jan 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHVb+DEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014A35E552
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968586; cv=none; b=CAwCK8MsgqvadyvXLDtJEWHHJTIqqrqEIShZaFox6kClDUcHVnTS8cQe9BKFHOg8K9pD7cnzma/5Dj+n4OzaUEm0G27iVkD31ezVrsSdL8BvtBHydkYBxsIct8EmjMVmtJym0DijORj7iUvL1duypJRymfP1cIazqxsUEctbOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968586; c=relaxed/simple;
	bh=IZX0GyFDL7t70J/Ljr/Ww9EPikfNIA5b00sjzTAqWpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5Jvhw2h2Qa4cMGMUpeimr3ynZSM5b6/RFPHhL4HGlcYt+aWIxfoxiKvHK2HhZz2UViColuRrcZNQXqjVRLydCyROSgMr5+x+wL8Jvhh1vQgiIsIQzNvu0UTIT0rNlnZM7+oscIEZrt6ghrPBTyu5UllfCBok9D9i4M2MOT3sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHVb+DEb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47774d3536dso28172145e9.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767968583; x=1768573383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJuTI/pP3gTuIvrfb63LlTSw7eNSK1HBmiLz7uaNHpI=;
        b=JHVb+DEbPsUUdQ3cNFP1ezBmkMcT6jWEl5c/QP7+37dKQ8hLV1AF7H/rMwKWV/a9ZM
         UE9atsV6eVXjU32O0N5KgQbBxRrUx/lOxzruizKkgSzrjPbhMGu3kJ6KqKVOsi6o71vY
         fMytUL9+E5YHW45k1zUrlXIELR0/4bqFs/Z5maZsTsoO2p3naxAE0QSmnzf8RzfTOZSF
         d0M9uKdkmCH9Ni6dPYT6wUKoEdjsj7w8xaSqgeuWOulBayCuKXdVRa0P2WHVeHkSp1mY
         Ny0QXLdX/Ze74F9C6rnsY2vL7D+6CXBF5V/K8IGJtq84JZGf48ha6zWXoQI7QYtFL59G
         YcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767968583; x=1768573383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GJuTI/pP3gTuIvrfb63LlTSw7eNSK1HBmiLz7uaNHpI=;
        b=Fj26yAJbBlfOHTsDvIKILVpwGhBZNhFJWkplrxdbjqG1q4JU9tUOO6LKwuBB9cOeNp
         L9n+eIWBhPsfbDpDFSRzdn/X3UchPWe2YGPwO333BW6+VPcoAeNkAGXnIlIL/lqV2OGJ
         lTGUwLRII0xiBoeAeYnIUdoXszOlyoUWq8vp6laf3NT3XWgc2UJL6lmm0P0gylpmrQZy
         Jy2LqGvX9rjpHzsjYzHOB9U+Kd63L0zkL0PdfZLMpWOUxh07+aAKugrM65+Lgu8ewVMq
         w+UNZ5wHHBrWpDEr94rVdTG3Ax6ouCVjYj+ZFq/CmTSeJHlF2rYPFx/p0NJNXdOkYbVr
         JMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURpUkaw9A4QKOGP/pxHLzHDjwX9PJwudIDn6FohfyoYPF/o2OY6wdga0XxfCNrPyZAuK/WNgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZbLdlv3t22XW0AXj0lagCNl7hSgVSRoiko/Qe8tRKXqvrnGJ
	7TD/PiSrO/58DOt2Ao62upqaE2kFWtUktACKqQog87oBqHNed6tsq5H8
X-Gm-Gg: AY/fxX5RJ249gYvWEDP7zwSa1ZGgqrbuSLDvEaaOmOgpkDmvYlNuj0kK/P/HeJZs6ch
	CGBOvqsltMW5CkIAJu7Shn+R9mMUKM9GG5jolwj774x3pYIMtgk5Q70BpJxQUy2J4mvTwdE4rvV
	2wHzigtOdCni2ZtHC5x/QImftoHpb0xCQ/nIVEwK/3X1UDbC2mFv7zO5Z45g3me6y96QGKMCmm0
	BLwG7UDkG8AdZ1k2JwTyfC0Q+K6Vb9hylfKDz6q7E9acQhRgu0znpQFWJOugC5gO6xyRunwdbbW
	Wn3YB4X/kyAeY+aYOqH7gOkiV0ngNcn0MVBfNk0Ry6Fsz1TNNHsU1NRcwUICnTIg6K2xbAm1Qrd
	tS2k1aYTeJCUTRRwNgJnttzhzKvzCHs6Rbvf2IOc13EjDW7mqzT1v1UflhXhpkA2Me8mHAXB33v
	mFnaWFXmeaD/7FLwYjCPQjwrq3VAhWRvJRSSHmUa1fjbrYAfiRq4tkMQAz7t9i0noaviGeev4KH
	AEqlifF6tXiBkHG/3FI830=
X-Google-Smtp-Source: AGHT+IHuqWKzRFHwggueYURnOwU1f6nLlo3Dx/aAg2AtNERz9s/rUtlR+rwtsB4ngafpJcpJ++sTBg==
X-Received: by 2002:a05:600c:3541:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d848787e3mr127679765e9.14.1767968583016;
        Fri, 09 Jan 2026 06:23:03 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a1e11sm61448855e9.19.2026.01.09.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:23:02 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 2/2] net: pcs: rzn1-miic: Add support for PHY link active-level configuration
Date: Fri,  9 Jan 2026 14:22:50 +0000
Message-ID: <20260109142250.3313448-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109142250.3313448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260109142250.3313448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support to configure the PHY link signal active level per converter
using the DT property "renesas,miic-phylink-active-low".

Introduce the MIIC_PHYLINK register definition and extend the MIIC driver
with a new `phylink` structure to store the mask and value for PHY link
configuration. Implement `miic_configure_phylink()` to determine the bit
position and polarity for each port based on the SoC type, such as RZ/N1
or RZ/T2H/N2H.

The accumulated configuration is stored during DT parsing and applied
later in `miic_probe()` after hardware initialization, since the MIIC
registers can only be modified safely once the hardware setup is complete.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No changes.
---
 drivers/net/pcs/pcs-rzn1-miic.c | 108 +++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 885f17c32643..cc090f27e559 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -28,6 +28,8 @@
 
 #define MIIC_MODCTRL			0x8
 
+#define MIIC_PHYLINK			0x14
+
 #define MIIC_CONVCTRL(port)		(0x100 + (port) * 4)
 
 #define MIIC_CONVCTRL_CONV_SPEED	GENMASK(1, 0)
@@ -177,6 +179,16 @@ static const char * const rzt2h_reset_ids[] = {
 	"crst",
 };
 
+/**
+ * struct phylink - Phylink configuration
+ * @mask: Mask of phylink bits
+ * @val: Value of phylink bits
+ */
+struct phylink {
+	u32 mask;
+	u32 val;
+};
+
 /**
  * struct miic - MII converter structure
  * @base: base address of the MII converter
@@ -184,6 +196,7 @@ static const char * const rzt2h_reset_ids[] = {
  * @lock: Lock used for read-modify-write access
  * @rsts: Reset controls for the MII converter
  * @of_data: Pointer to OF data
+ * @phylink: Phylink configuration
  */
 struct miic {
 	void __iomem *base;
@@ -191,6 +204,12 @@ struct miic {
 	spinlock_t lock;
 	struct reset_control_bulk_data rsts[MIIC_MAX_NUM_RSTS];
 	const struct miic_of_data *of_data;
+	struct phylink phylink;
+};
+
+enum miic_type {
+	MIIC_TYPE_RZN1,
+	MIIC_TYPE_RZT2H,
 };
 
 /**
@@ -210,6 +229,7 @@ struct miic {
  * @init_unlock_lock_regs: Flag to indicate if registers need to be unlocked
  *  before access.
  * @miic_write: Function pointer to write a value to a MIIC register
+ * @type: Type of MIIC
  */
 struct miic_of_data {
 	struct modctrl_match *match_table;
@@ -226,6 +246,7 @@ struct miic_of_data {
 	u8 reset_count;
 	bool init_unlock_lock_regs;
 	void (*miic_write)(struct miic *miic, int offset, u32 value);
+	enum miic_type type;
 };
 
 /**
@@ -581,10 +602,82 @@ static int miic_match_dt_conf(struct miic *miic, s8 *dt_val, u32 *mode_cfg)
 	return -EINVAL;
 }
 
+static void miic_configure_phylink(struct miic *miic, u32 conf,
+				   u32 port, bool active_low)
+{
+	bool polarity_active_high;
+	u32 mask, val;
+	int shift;
+
+	/* determine shift and polarity for this conf */
+	if (miic->of_data->type == MIIC_TYPE_RZN1) {
+		switch (conf) {
+		/* switch ports => bits [3:0] (shift 0), active when low */
+		case MIIC_SWITCH_PORTA:
+		case MIIC_SWITCH_PORTB:
+		case MIIC_SWITCH_PORTC:
+		case MIIC_SWITCH_PORTD:
+			shift = 0;
+			polarity_active_high = false;
+			break;
+
+		/* EtherCAT ports => bits [7:4] (shift 4), active when high */
+		case MIIC_ETHERCAT_PORTA:
+		case MIIC_ETHERCAT_PORTB:
+		case MIIC_ETHERCAT_PORTC:
+			shift = 4;
+			polarity_active_high = true;
+			break;
+
+		/* Sercos ports => bits [11:8] (shift 8), active when high */
+		case MIIC_SERCOS_PORTA:
+		case MIIC_SERCOS_PORTB:
+			shift = 8;
+			polarity_active_high = true;
+			break;
+
+		default:
+			return;
+		}
+	} else {
+		switch (conf) {
+		/* ETHSW ports => bits [3:0] (shift 0), active when low */
+		case ETHSS_ETHSW_PORT0:
+		case ETHSS_ETHSW_PORT1:
+		case ETHSS_ETHSW_PORT2:
+			shift = 0;
+			polarity_active_high = false;
+			break;
+
+		/* ESC ports => bits [7:4] (shift 4), active when high */
+		case ETHSS_ESC_PORT0:
+		case ETHSS_ESC_PORT1:
+		case ETHSS_ESC_PORT2:
+			shift = 4;
+			polarity_active_high = true;
+			break;
+
+		default:
+			return;
+		}
+	}
+
+	mask = BIT(port) << shift;
+
+	if (polarity_active_high)
+		val = (active_low ? 0 : BIT(port)) << shift;
+	else
+		val = (active_low ? BIT(port) : 0) << shift;
+
+	miic->phylink.mask |= mask;
+	miic->phylink.val = (miic->phylink.val & ~mask) | (val & mask);
+}
+
 static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 {
 	struct device_node *np = miic->dev->of_node;
 	struct device_node *conv;
+	bool active_low;
 	int port, ret;
 	s8 *dt_val;
 	u32 conf;
@@ -605,8 +698,15 @@ static int miic_parse_dt(struct miic *miic, u32 *mode_cfg)
 
 		/* Adjust for 0 based index */
 		port += !miic->of_data->miic_port_start;
-		if (of_property_read_u32(conv, "renesas,miic-input", &conf) == 0)
-			dt_val[port] = conf;
+		if (of_property_read_u32(conv, "renesas,miic-input", &conf))
+			continue;
+
+		dt_val[port] = conf;
+
+		active_low = of_property_read_bool(conv, "renesas,miic-phylink-active-low");
+
+		miic_configure_phylink(miic, conf, port - !miic->of_data->miic_port_start,
+				       active_low);
 	}
 
 	ret = miic_match_dt_conf(miic, dt_val, mode_cfg);
@@ -696,6 +796,8 @@ static int miic_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_runtime_pm;
 
+	miic_reg_rmw(miic, MIIC_PHYLINK, miic->phylink.mask, miic->phylink.val);
+
 	/* miic_create() relies on that fact that data are attached to the
 	 * platform device to determine if the driver is ready so this needs to
 	 * be the last thing to be done after everything is initialized
@@ -729,6 +831,7 @@ static struct miic_of_data rzn1_miic_of_data = {
 	.sw_mode_mask = GENMASK(4, 0),
 	.init_unlock_lock_regs = true,
 	.miic_write = miic_reg_writel_unlocked,
+	.type = MIIC_TYPE_RZN1,
 };
 
 static struct miic_of_data rzt2h_miic_of_data = {
@@ -745,6 +848,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
 	.reset_ids = rzt2h_reset_ids,
 	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),
 	.miic_write = miic_reg_writel_locked,
+	.type = MIIC_TYPE_RZT2H,
 };
 
 static const struct of_device_id miic_of_mtable[] = {
-- 
2.52.0


