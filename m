Return-Path: <netdev+bounces-18471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6B37574D1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A65281262
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36A46A1;
	Tue, 18 Jul 2023 07:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3F5671
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:00:13 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF211B5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:00:12 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202307180700119d70f900ba493e0a1b
        for <netdev@vger.kernel.org>;
        Tue, 18 Jul 2023 09:00:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PD8Cxd3iso0BrKXzIfhGSHXoX5NHvZZ/NAIdVFvY1is=;
 b=NyFcNb5AdnTHf4Xa5Ttpy3Oiqe9zg5XKrAIUes29aSwCaeKUQESmjkTztDsir2MolSEfL4
 H6vrq09M3qNDIbZ70j5WCukaifIUN/keDVQTDrZMkyTyMITZoiE4Hvd5aMm5u2o+5GqqEjON
 4CRIF6ZXBtX2P+nOWGJ7r+KfiknIc=;
From: "M. Haener" <michael.haener@siemens.com>
To: netdev@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 2/3] net: dsa: mv88e632x: Refactor serdes write
Date: Tue, 18 Jul 2023 08:59:30 +0200
Message-ID: <20230718065937.10713-3-michael.haener@siemens.com>
In-Reply-To: <20230718065937.10713-1-michael.haener@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michael Haener <michael.haener@siemens.com>

To avoid code duplication, the serdes write functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changelog:
v3: rebased onto main branch
v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  2 ++
 drivers/net/dsa/mv88e6xxx/serdes.c |  6 +++---
 drivers/net/dsa/mv88e6xxx/serdes.h | 11 +++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 81fa66568e25..7e8aaa1383c6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4379,6 +4379,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4480,6 +4481,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -4751,6 +4753,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5164,6 +5167,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index bbf1e7f6f343..7e9b6eb11216 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -595,6 +595,8 @@ struct mv88e6xxx_ops {
 
 	int (*serdes_read)(struct mv88e6xxx_chip *chip, int lane, int device,
 			   int reg, u16 *val);
+	int (*serdes_write)(struct mv88e6xxx_chip *chip, int lane, int reg,
+			    u16 val);
 
 	/* SERDES interrupt handling */
 	unsigned int (*serdes_irq_mapping)(struct mv88e6xxx_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 5696b94c9155..b988d47ecbdd 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -25,8 +25,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 				       reg, val);
 }
 
-static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
-				  u16 val)
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val)
 {
 	return mv88e6xxx_phy_page_write(chip, MV88E6352_ADDR_SERDES,
 					MV88E6352_SERDES_PAGE_FIBER,
@@ -549,5 +549,5 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	ctrl &= ~MV88E6352_SERDES_OUT_AMP_MASK;
 	ctrl |= reg;
 
-	return mv88e6352_serdes_write(chip, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
+	return mv88e6xxx_serdes_write(chip, lane, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 9b3a5ece33e7..d3e83c674ef7 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -124,6 +124,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
@@ -166,6 +168,15 @@ static inline int mv88e6xxx_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 	return chip->info->ops->serdes_read(chip, lane, device, reg, val);
 }
 
+static inline int mv88e6xxx_serdes_write(struct mv88e6xxx_chip *chip, int lane,
+					 int reg, u16 val)
+{
+	if (!chip->info->ops->serdes_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->serdes_write(chip, lane, reg, val);
+}
+
 static inline unsigned int
 mv88e6xxx_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
 {
-- 
2.41.0


