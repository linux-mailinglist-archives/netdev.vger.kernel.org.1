Return-Path: <netdev+bounces-277187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMtxKxlK2Gm0bAgAu9opvQ
	(envelope-from <netdev+bounces-277187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:53:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AC3D0E82
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65F8530059BC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5063164DF;
	Fri, 10 Apr 2026 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0wqclTl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2F3164B4
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782423; cv=none; b=Nzb3QY6p7OR7d0oIRIZlqEkV/lVXftO0DwmWU7EsxcMSv+HqusXLv18irzIsmIXeMJqfVXt9TkE8AyMkR9s2oANSmJaMKk9ClFmn/DcLYlHhLezL0vRCY8UyV5m8G9WwhFI/u6b/NF0jhku62gCB5Pj3LVFwglzWc5UxITHurbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782423; c=relaxed/simple;
	bh=NFvlA2k7ZKF5s/mKYTomnRlhSXaZ8Fq0qpjzk3gHunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flLK649bWkDskAHSTHJJPCxAcgv4sRYCfgJlRS0EonHabHyH410+DPdko3SuckOXjcaoaAESX0T21pVAgzR9XB2UfhOW5oDq06mHIPIX6UlEK6AeAYWNDdI31cZRxgxa50+e67ZSWsWQ5NnfOJo5f5d0Xbq63mXco0F2bT/Vpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0wqclTl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso23273725e9.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 17:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775782415; x=1776387215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnWUeY1tdgfii00Q939zG7kbngA3aJMynI2I8W/AA2Y=;
        b=E0wqclTlf+eY/313Jnc6m5kLpffMHDfX1pS6en6fq/EVrq/wUlPdtwomgoi7mP19ak
         sYzCbJkrOzK+60PkmueXyVSKdHH8nDLqpx/3lJ80Rhba8QM+QVjjUTE1DbUy8uqotJss
         s5PpQfhyZOnbJIlyfK9xAcx2GJ4R0lOKsmNt3H2AXxJ2eJ433QxLssaTDhjLBDCX6aC7
         J2XybdZrL5JexSmn2mNV2oJjoVc9GhoYi8ZraVMVwA5nI1jv+BUh95Os8QkAJ/KIjtjA
         nq/fCYZ16Uilbb/FwPLkIubsazIWUWYOryVFqHaac7JJcDDJW13UtK1h7Z+dpoM67SSN
         foyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775782415; x=1776387215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnWUeY1tdgfii00Q939zG7kbngA3aJMynI2I8W/AA2Y=;
        b=mVag94TnjnqCs97JUOYX25I1jPoCix6DadHCx4oMbJ7Fxn7riZz0Vvp6VZU6MuJ9l4
         9krXYIZgRAhPpktMiaqcZuN2TNGV52vt996Zdp0vaUDDQaV+Gelcz41np2Grxkb7bL7g
         Qm6FXI37GMYc8NaFd9wGfiqT1CpezNoopwXfv139X9Vp//rQUxSk0dUlqBAGKN0vyT+p
         fq/AGLQmzIYeM+3R82sKWeOquPQuAmnGo6Qzudu9KCsUwuz2biB13Ieb9xRnY7HbFk38
         83EtGs5pU7IDKvYfHoaS/midTxrDTXWLcKae7bRIqwN4MivZ2dp6kMhlpilWnRguJezg
         jSmQ==
X-Gm-Message-State: AOJu0Yy0HNYdws3anj81M2AzP4k70DP4XvQE1Y+/wRXGgebIY6h0bvMS
	FI03VO4ZgIoyeO0sTvu/BvCsM46t9O1FFWCkab5dH8z8rACF4RbplCTHFcqLGw==
X-Gm-Gg: AeBDietSHOkF5cWAqcsxa3sBF2iIOB3OAtbUxtL9mY70OS63ofoXd9z5Xw5zQ/oXE4o
	tnrgTFfKPtV/X7DN10tLNgSDwnqu84GcBePnZw2JySeEqmT2+So30rvnmbkcR5p3UQhmxqkMEw9
	qCkr9q5m4UnbknJ/MUXEyn+Q8pnsfrB8uHjss2l9ztQ51men/6B8VnZetdAJ1v33h7PvVmGU4n5
	1A5nmDe8oXkADY295NF8zLLlYUJYkfpdTzB29NWYu0nIv2JrXFPIIUFiwaC6rSsSL6+3NioTVgi
	LL6ajcaKOQ5ou8TXRyUUlB+/DOrAHuOm8+HTfKL5wtYHCNNW6zlw9RT0Vnr2yqJwMu2lf606QUz
	6tGI3uv6k9c6kfFcuuWDhLgi1ofU8y/UfX737NsWJIiPTvUhbOMHA8DhPtdHPdp1PuBoMGoWsnD
	WqguggIRd/qy3VpPDiXm7wyyo4
X-Received: by 2002:a05:600c:45ce:b0:488:a8f0:35bd with SMTP id 5b1f17b1804b1-488d67df745mr10284985e9.8.1775782414558;
        Thu, 09 Apr 2026 17:53:34 -0700 (PDT)
Received: from rpi5.lan ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm6502495e9.14.2026.04.09.17.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 17:53:33 -0700 (PDT)
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [PATCH RFC v2] r8169: implement SFP support
Date: Fri, 10 Apr 2026 01:53:31 +0100
Message-ID: <20260410005331.2045-1-fabio.baltieri@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277187-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabiobaltieri@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 376AC3D0E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement support for reading the identification and diagnostic
information on SFP modules for rtl8127atf devices.

This uses the sfp module, implements a GPIO devices for presence
detection and loss of signal and i2c communication using the designware
module.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---
Hi,

here's the rework of the v1 I sent as "r8169: implement get_module
functions for rtl8127atf", this is now implementing sfp support using
the kernel sfp module, using the support nodes as well, including
reusing the designware driver for i2c.

Module presence detection seems to work correctly:

[  555.853597] sfp sfp.256: module removed
[  561.628005] sfp sfp.256: module QSFPTEK          QT-SFP+-SR       rev      sn QT8250805132     dc 250806  

Had to guess the gpio input register offset (the out of tree driver does
not implement this), hopefully the realtek folks can chime in down the
road and other functions can be implemented too.

This is largely a copy paste of the txgbe txgbe_phy.c code, though the
pcs and phylink code is missing since as far as I understand it should
be implemented separately, so the sfp module here just reports the
status via hwmon and is stuck in:

Module state: waitdev

Just looking for early feedback, this is functional as is but I guess
it'll have to wait for the phylink support to get implemented first and
then rebase on top of it, and I guess a realtek specific variant of the
wx,i2c-snps-model property.

Cheers,
Fabio

 drivers/net/ethernet/realtek/Kconfig      |   3 +
 drivers/net/ethernet/realtek/r8169_main.c | 302 +++++++++++++++++++++-
 2 files changed, 304 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 9b0f4f9631db..ae936e1586aa 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -88,6 +88,9 @@ config R8169
 	select CRC32
 	select PHYLIB
 	select REALTEK_PHY
+	select REGMAP
+	select SFP
+	select GPIOLIB
 	help
 	  Say Y here if you have a Realtek Ethernet adapter belonging to
 	  the following families:
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 58788d196c57..77266de27656 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -29,6 +29,15 @@
 #include <linux/prefetch.h>
 #include <linux/ipv6.h>
 #include <linux/unaligned.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/property.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/property.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
 #include <net/phy/realtek_phy.h>
@@ -724,6 +733,37 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+#define NODE_PROP(_NAME, _PROP)                 \
+	(const struct software_node) {          \
+		.name = (_NAME),                \
+		.properties = (_PROP),          \
+	}
+
+enum rtl8169_swnodes {
+	SWNODE_GPIO = 0,
+	SWNODE_I2C,
+	SWNODE_SFP,
+	SWNODE_PHYLINK,
+	SWNODE_MAX
+};
+
+struct rtl8169_nodes {
+	char gpio_name[32];
+	char i2c_name[32];
+	char sfp_name[32];
+	char phylink_name[32];
+	struct property_entry gpio_props[2];
+	struct property_entry i2c_props[4];
+	struct property_entry sfp_props[5];
+	struct property_entry phylink_props[3];
+	struct software_node_ref_args i2c_ref[1];
+	struct software_node_ref_args gpio0_ref[1];
+	struct software_node_ref_args gpio1_ref[1];
+	struct software_node_ref_args sfp_ref[1];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -770,6 +810,13 @@ struct rtl8169_private {
 	struct r8169_led_classdev *leds;
 
 	u32 ocp_base;
+
+	struct platform_device *sfp_dev;
+	struct platform_device *i2c_dev;
+	struct clk_lookup *i2c_clock;
+	struct clk *i2c_clk;
+	struct gpio_chip *gpio;
+	struct rtl8169_nodes nodes;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -2411,6 +2458,246 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
+static int r8169_swnodes_register(struct rtl8169_private *tp)
+{
+	struct rtl8169_nodes *nodes = &tp->nodes;
+	struct pci_dev *pdev = tp->pci_dev;
+	struct software_node *swnodes;
+	u32 id;
+
+	id = pci_dev_id(pdev);
+
+	snprintf(nodes->gpio_name, sizeof(nodes->gpio_name), "r8169_gpio-%x", id);
+	snprintf(nodes->i2c_name, sizeof(nodes->i2c_name), "r8169_i2c-%x", id);
+	snprintf(nodes->sfp_name, sizeof(nodes->sfp_name), "r8169_sfp-%x", id);
+	snprintf(nodes->phylink_name, sizeof(nodes->phylink_name), "r8169_phylink-%x", id);
+
+	swnodes = nodes->swnodes;
+
+	/* GPIO 8: module presence
+	 * GPIO 11: rx signal lost
+	 */
+	nodes->gpio_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
+	swnodes[SWNODE_GPIO] = NODE_PROP(nodes->gpio_name, nodes->gpio_props);
+	nodes->gpio0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO], 8, GPIO_ACTIVE_LOW);
+	nodes->gpio1_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO], 11, GPIO_ACTIVE_LOW);
+
+	nodes->i2c_props[0] = PROPERTY_ENTRY_STRING("compatible", "snps,designware-i2c");
+	nodes->i2c_props[1] = PROPERTY_ENTRY_BOOL("wx,i2c-snps-model");
+	nodes->i2c_props[2] = PROPERTY_ENTRY_U32("clock-frequency", I2C_MAX_STANDARD_MODE_FREQ);
+	swnodes[SWNODE_I2C] = NODE_PROP(nodes->i2c_name, nodes->i2c_props);
+	nodes->i2c_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_I2C]);
+
+	nodes->sfp_props[0] = PROPERTY_ENTRY_STRING("compatible", "sff,sfp");
+	nodes->sfp_props[1] = PROPERTY_ENTRY_REF_ARRAY("i2c-bus", nodes->i2c_ref);
+	nodes->sfp_props[2] = PROPERTY_ENTRY_REF_ARRAY("mod-def0-gpios", nodes->gpio0_ref);
+	nodes->sfp_props[3] = PROPERTY_ENTRY_REF_ARRAY("los-gpios", nodes->gpio1_ref);
+	swnodes[SWNODE_SFP] = NODE_PROP(nodes->sfp_name, nodes->sfp_props);
+	nodes->sfp_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_SFP]);
+
+	nodes->phylink_props[0] = PROPERTY_ENTRY_STRING("managed", "in-band-status");
+	nodes->phylink_props[1] = PROPERTY_ENTRY_REF_ARRAY("sfp", nodes->sfp_ref);
+	swnodes[SWNODE_PHYLINK] = NODE_PROP(nodes->phylink_name, nodes->phylink_props);
+
+	nodes->group[SWNODE_GPIO] = &swnodes[SWNODE_GPIO];
+	nodes->group[SWNODE_I2C] = &swnodes[SWNODE_I2C];
+	nodes->group[SWNODE_SFP] = &swnodes[SWNODE_SFP];
+	nodes->group[SWNODE_PHYLINK] = &swnodes[SWNODE_PHYLINK];
+
+	return software_node_register_node_group(nodes->group);
+}
+
+static int r8169_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rtl8169_private *tp = gpiochip_get_data(chip);
+	int val;
+
+	val = r8168_mac_ocp_read(tp, 0xdc30);
+
+	return !!(val & BIT(offset));
+}
+
+static int r8169_gpio_init(struct rtl8169_private *tp)
+{
+	struct gpio_chip *gc;
+	struct pci_dev *pdev = tp->pci_dev;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->label = devm_kasprintf(dev, GFP_KERNEL, "r8169_gpio-%x",
+				   pci_dev_id(pdev));
+	if (!gc->label)
+		return -ENOMEM;
+
+	gc->base = -1;
+	gc->ngpio = 16;
+	gc->owner = THIS_MODULE;
+	gc->parent = dev;
+	gc->fwnode = software_node_fwnode(tp->nodes.group[SWNODE_GPIO]);
+	gc->get = r8169_gpio_get;
+
+	ret = devm_gpiochip_add_data(dev, gc, tp);
+	if (ret)
+		return ret;
+
+	tp->gpio = gc;
+
+	return 0;
+}
+
+static int r8169_clock_register(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct clk_lookup *clock;
+	char clk_name[32];
+	struct clk *clk;
+
+	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
+		 pci_dev_id(pdev));
+
+	/* 115MHz seems to result in an i2c clock of 100kHz */
+	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 115000000);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	clock = clkdev_create(clk, NULL, "%s", clk_name);
+	if (!clock) {
+		clk_unregister(clk);
+		return -ENOMEM;
+	}
+
+	tp->i2c_clk = clk;
+	tp->i2c_clock = clock;
+
+	return 0;
+}
+
+#define R8127_SDS_I2C_BASE 0xe200
+
+static int r8169_i2c_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct rtl8169_private *tp = context;
+
+	*val = r8168_mac_ocp_read(tp, R8127_SDS_I2C_BASE + reg);
+
+	return 0;
+}
+
+static int r8169_i2c_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct rtl8169_private *tp = context;
+
+	r8168_mac_ocp_write(tp, R8127_SDS_I2C_BASE + reg, val);
+
+	return 0;
+}
+
+static const struct regmap_config i2c_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_read = r8169_i2c_read,
+	.reg_write = r8169_i2c_write,
+	.fast_io = true,
+};
+
+static int r8169_i2c_register(struct rtl8169_private *tp)
+{
+	struct platform_device_info info = {};
+	struct platform_device *i2c_dev;
+	struct regmap *i2c_regmap;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	i2c_regmap = devm_regmap_init(&pdev->dev, NULL, tp, &i2c_regmap_config);
+	if (IS_ERR(i2c_regmap)) {
+		dev_err(&pdev->dev, "failed to init I2C regmap\n");
+		return PTR_ERR(i2c_regmap);
+	}
+
+	info.parent = &pdev->dev;
+	info.fwnode = software_node_fwnode(tp->nodes.group[SWNODE_I2C]);
+	info.name = "i2c_designware";
+	info.id = pci_dev_id(pdev);
+
+	i2c_dev = platform_device_register_full(&info);
+	if (IS_ERR(i2c_dev))
+		return PTR_ERR(i2c_dev);
+
+	tp->i2c_dev = i2c_dev;
+
+	return 0;
+}
+
+static int r8169_sfp_register(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct platform_device_info info = {};
+	struct platform_device *sfp_dev;
+
+	info.parent = &pdev->dev;
+	info.fwnode = software_node_fwnode(tp->nodes.group[SWNODE_SFP]);
+	info.name = "sfp";
+	info.id = pci_dev_id(pdev);
+	sfp_dev = platform_device_register_full(&info);
+	if (IS_ERR(sfp_dev))
+		return PTR_ERR(sfp_dev);
+
+	tp->sfp_dev = sfp_dev;
+
+	return 0;
+}
+
+static int r8169_sfp_nodes_init(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	int ret;
+
+	ret = r8169_swnodes_register(tp);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "r8169_swnodes_register\n");
+
+	ret = r8169_gpio_init(tp);
+	if (ret < 0) {
+		ret = dev_err_probe(&pdev->dev, ret, "r8169_gpio_init\n");
+		goto err_unregister_swnode;
+	}
+
+	ret = r8169_clock_register(tp);
+	if (ret < 0) {
+		ret = dev_err_probe(&pdev->dev, ret, "r8169_clock_register\n");
+		goto err_unregister_swnode;
+	}
+
+	ret = r8169_i2c_register(tp);
+	if (ret < 0) {
+		ret = dev_err_probe(&pdev->dev, ret, "r8169_i2c_register\n");
+		goto err_unregister_clk;
+	}
+
+	ret = r8169_sfp_register(tp);
+	if (ret < 0) {
+		ret = dev_err_probe(&pdev->dev, ret, "r8169_sfp_register\n");
+		goto err_unregister_i2c;
+	}
+
+	return 0;
+
+err_unregister_i2c:
+	platform_device_unregister(tp->i2c_dev);
+err_unregister_clk:
+	clkdev_drop(tp->i2c_clock);
+	clk_unregister(tp->i2c_clk);
+err_unregister_swnode:
+	software_node_unregister_node_group(tp->nodes.group);
+
+	return ret;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -5289,6 +5576,14 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	/* restore original MAC address */
 	rtl_rar_set(tp, tp->dev->perm_addr);
+
+	if (tp->sfp_mode) {
+		platform_device_unregister(tp->sfp_dev);
+		platform_device_unregister(tp->i2c_dev);
+		clkdev_drop(tp->i2c_clock);
+		clk_unregister(tp->i2c_clk);
+		software_node_unregister_node_group(tp->nodes.group);
+	}
 }
 
 static const struct net_device_ops rtl_netdev_ops = {
@@ -5675,8 +5970,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rtl_is_8125(tp)) {
 		u16 data = r8168_mac_ocp_read(tp, 0xd006);
 
-		if ((data & 0xff) == 0x07)
+		if ((data & 0xff) == 0x07) {
 			tp->sfp_mode = true;
+
+			rc = r8169_sfp_nodes_init(tp);
+			if (rc < 0)
+				return rc;
+		}
 	}
 
 	tp->dash_type = rtl_get_dash_type(tp);
-- 
2.47.3


