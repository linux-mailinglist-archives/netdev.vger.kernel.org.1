Return-Path: <netdev+bounces-131311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD698E0C1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57E81C23CBA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360A1D26F6;
	Wed,  2 Oct 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lpA3bHFQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEA1D1E7C;
	Wed,  2 Oct 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886556; cv=none; b=V4C2XTGAmhgy5XxqvRbAT+S/wo2e1Sh4hsfA1TXLgBW8syFLG2JfbIo+imY3HfgZoMybw0XjbUz+aPDD4Iq5TSa0rW3oIKqLWl67EyucX+drQwLB4CdsfkEkbxKPoGHJg3zGqt0l073inzbAZhFgyp62HLLvOWT0g1moj8XQHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886556; c=relaxed/simple;
	bh=m5UVg9uMgWclNQ0ZC+nkcUjkJnAqUFQoCJthQiR5YHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aq74WJDcwnr30joLXS0xJYnCwi9l1uMUcKNbvSqxBAQHSTO5SOUXcl8IoOFlnQs4fgxiMqZuv1somR31mI8xiZ8Fnl2LkKFL9svbhg2gZDL9mUeAG51NCDUjnefc9/usUmJ+SgVmAMLEN9uBL/QcXlA9S2x16rWZY+yflRQJOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lpA3bHFQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3DE71BF209;
	Wed,  2 Oct 2024 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpBR8isuTmda5r4Ct+oNS3fZY4wF7+uxDTZEDgK+/Ng=;
	b=lpA3bHFQlmDafRf+NTzsXKa/h3ajO6D+MMX54qfWddn7TymIXi5CUK1NMb9vLv9pMs8aK7
	9NWuUJhSnhQxzijRF6oaxezjZdyP/5e69TNJuBMVZTk7apk7WwapSVgs/rZ01MWGOGxpPY
	NZkJavfqmWXcZO+tUvxf2isiD2RkWc43dPQAuZYz0Y4MJMDhsI8bbrrBM+XiwGGgbQoXpv
	y4peffTbaXkBWs2iq9vF0PRcXmL8Pz36VcKtNm5gG4I1xcIQJAVRXMvd7TtqmFlNp6zye5
	0BzWbPShKIJ6UwZLeFmaorSXB/G3d1RDfze4LN/V0K9bNedxO7FaeNUlywsVWA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:28:05 +0200
Subject: [PATCH net-next 09/12] net: pse-pd: tps23881: Add support for PSE
 PI priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-9-787054f74ed5@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch extends the PSE callbacks by adding support for the newly
introduced pi_set_prio() callback, enabling the configuration of PSE PI
priorities. The current port priority is now also included in the status
information returned to users.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index e05b45cdc9f8..ddb44a17218a 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -22,6 +22,7 @@
 #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
 #define TPS23881_REG_DIS_EN	0x13
 #define TPS23881_REG_DET_CLA_EN	0x14
+#define TPS23881_REG_PW_PRIO	0x15
 #define TPS23881_REG_GEN_MASK	0x17
 #define TPS23881_REG_NBITACC	BIT(5)
 #define TPS23881_REG_PW_EN	0x19
@@ -408,6 +409,24 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 		return ret;
 	status->c33_pw_class = ret;
 
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_PRIO);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	if (chan < 4)
+		status->c33_prio = !!(ret & BIT(chan + 4));
+	else
+		status->c33_prio = !!(ret & BIT(chan + 8));
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		if (chan < 4)
+			status->c33_prio &= !!(ret & BIT(chan + 4));
+		else
+			status->c33_prio &= !!(ret & BIT(chan + 8));
+	}
+
 	return 0;
 }
 
@@ -925,6 +944,42 @@ static int tps23881_pi_set_current_limit(struct pse_controller_dev *pcdev,
 	return 0;
 }
 
+static int tps23881_pi_set_prio(struct pse_controller_dev *pcdev, int id,
+				unsigned int prio)
+{
+	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
+	struct i2c_client *client = priv->client;
+	u8 chan, bit;
+	u16 val;
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_PRIO);
+	if (ret < 0)
+		return ret;
+
+	chan = priv->port[id].chan[0];
+	if (chan < 4)
+		bit = chan + 4;
+	else
+		bit = chan + 8;
+
+	val = (u16)(ret & ~BIT(bit));
+	val |= prio << (bit);
+
+	if (priv->port[id].is_4p) {
+		chan = priv->port[id].chan[1];
+		if (chan < 4)
+			bit = chan + 4;
+		else
+			bit = chan + 8;
+
+		val &= ~BIT(bit);
+		val |= prio << (bit);
+	}
+
+	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_PRIO, val);
+}
+
 static const struct pse_controller_ops tps23881_ops = {
 	.setup_pi_matrix = tps23881_setup_pi_matrix,
 	.pi_enable = tps23881_pi_enable,
@@ -934,6 +989,7 @@ static const struct pse_controller_ops tps23881_ops = {
 	.pi_get_voltage = tps23881_pi_get_voltage,
 	.pi_get_current_limit = tps23881_pi_get_current_limit,
 	.pi_set_current_limit = tps23881_pi_set_current_limit,
+	.pi_set_prio = tps23881_pi_set_prio,
 };
 
 static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
@@ -1106,6 +1162,7 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
 	priv->pcdev.nr_lines = TPS23881_MAX_CHANS;
+	priv->pcdev.pis_prio_max = 1;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret) {
 		return dev_err_probe(dev, ret,

-- 
2.34.1


