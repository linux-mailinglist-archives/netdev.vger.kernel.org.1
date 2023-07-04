Return-Path: <netdev+bounces-15295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1C746A39
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FCB280F06
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A81866;
	Tue,  4 Jul 2023 06:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC151368
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:59:43 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A6711F
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 23:59:41 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230704065939ef38c74eef19f8d1c8
        for <netdev@vger.kernel.org>;
        Tue, 04 Jul 2023 08:59:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=naZsB+e+2/m4FNfzsyhDy9BbreIhpBNPwhPGxh/+8wk=;
 b=jfsgk4LxQW0tINDC2AhBc5k9yT1DmeALX45eXp5z8sMZvL85Z+BvmZL/dvFy2y84HAvaLC
 8ycK+RpWdDV4bChnGlHDeDjQD3rjY3VvVsx44d+MWxOqh7g1tDbpKf4vX0tQpjxfNNyOkGUt
 /cN8YPz7+dGan7v+Oae0Qy7eGsY6w=;
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
Subject: [PATCH v2 2/3] net: dsa: mv88e632x: Refactor serdes write
Date: Tue,  4 Jul 2023 08:59:05 +0200
Message-ID: <20230704065916.132486-3-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-1-michael.haener@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
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
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michael Haener <michael.haener@siemens.com>

To avoid code duplication, the serdes write functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   |  4 ++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  2 ++
 drivers/net/dsa/mv88e6xxx/serdes.c |  6 +++---
 drivers/net/dsa/mv88e6xxx/serdes.h | 11 +++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d2a320c6bed7..11b98546b938 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4375,6 +4375,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4476,6 +4477,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -4747,6 +4749,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.stu_getnext = mv88e6352_g1_stu_getnext,
 	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
@@ -5160,6 +5163,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
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


