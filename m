Return-Path: <netdev+bounces-234163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D958C1D6C2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 22:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ADDF4E3563
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10B31AF1E;
	Wed, 29 Oct 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="YQkCf5I+"
X-Original-To: netdev@vger.kernel.org
Received: from out11.tophost.ch (out11.tophost.ch [46.232.182.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCA31A811;
	Wed, 29 Oct 2025 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773060; cv=none; b=IMZPvcFG43VreR2+1qFc1fz+WDNH5yzJsbdVCwNgkqS/5KE2Ok6h+wuwBluOXl/YHvt+l3ucDKEFRcF4oSZnj/+Z34aR6PVeNVVn9Kvnzbx4Gi5DUfMm8rAja+C3xerE8XnbuufX/LQlrQu+ptap/q6tpVUkDxeMEJYB32EyBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773060; c=relaxed/simple;
	bh=5L7zNitMrCynopVaeYimqsTCTjTt+L910aX0TIOdi6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLqus4tzWWCl2o7o4NU3xWRxBa1dY4EFTFoC6SD3kS6kZPDoYICbTQ1u+8hhx5rBz4Qj93OI6uYr3Ow9ZDtKN85xNFr7nEYdtjRZPPSMx6Z4N9sZ/bM13lEnSxbhU0YUUQY7xt6OjQKwT4wnHClIofvfjQgTJxf0/bNlFb8pehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=YQkCf5I+; arc=none smtp.client-ip=46.232.182.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter2.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEDe6-007W5d-8q; Wed, 29 Oct 2025 22:23:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yoAKw2vS++tYIngxX0SuyCYOCpOStRoJkAwPCeP3S9M=; b=YQkCf5I+ALIN7oqrwtpZNL3eMm
	m+Nl9FV9gm7AHsTMjPI4v3Wx84dbclB46xwwyyATJomuf9SptiWTQa5qkCJD3AQG7i3cEP6pH3nob
	hWy1S5tPQgpusSA0sHAOH95KztZ0ITW1b6O/ZFG2sjE+CD6gorg/AqxHtvIb8Pr7My5P6a37cvJit
	fqVBrn2hfgvjmSmHwX7KpEj8foBcWUwKHQK1Ks2SK70uGhqZc4fHUXE13JX+JuHEa5fCb6RcWXrXk
	DdP6+tuyJgHpnoCsEzcehvfQJrmCRkY3kWDoJ3XLiT3s65menRrXVLwMjozCal6DdPskiy7U6355i
	40BDPL5Q==;
Received: from [2001:1680:4957:0:9918:f56f:598b:c8cf] (port=39522 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1vEDe3-0000000Bf5t-3hdf;
	Wed, 29 Oct 2025 22:23:50 +0100
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Wismer <thomas@wismer.xyz>,
	Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net: pse-pd: tps23881: Add support for TPS23881B
Date: Wed, 29 Oct 2025 22:23:09 +0100
Message-ID: <20251029212312.108749-2-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029212312.108749-1-thomas@wismer.xyz>
References: <20251029212312.108749-1-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (2.72480316127e-05)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVZQvGvn4K/7Zk8zu9RRyuPgK+PRbzytXp4
 k/nlUIXxByu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zE/7
 Q/NVRqfIOabVCFo92tiXjZljmnURpwhXdrCYLPTCCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYv0hq6Ot6Cbd9hg3807OZKQzthz0vNkOX8Em4cj6D/wdR983ISMXlZYfkTQnVvsLb89W7vD
 6C469DIPe8wH3iOJTcWsqU26dvDcYIYzaKVPzizNp/gleLRyr2ddmlcu+i1jPgDrl7KDWN+JeAU8
 1aNgksp0UtIrN0U07614AkdB++MTbkn6z1fsm8NoMVdUr8MDPUrsZkS8fIjQg/OlnCq9AIC5Z5Eo
 vuL59tfrqmU9AeFRYyZjHLqYAy4+QNNyid5H8SumKJ6G2ITZ1QpN+fKlKhj6uW6qT1824h/4yzd+
 H8TZI7fFfQwiuwD2LcLdqjNFmtMtCFuKzK3WYzvpld0/yccMnl06aHo07R+V2VbvDXc+galx1KGI
 Pp5jnkiI48S3blKfwQpggXpr4ijI5V97nizzgiBlcUwLhZK/ZHw1RW2vtunYtDoJKroVCwUDp7ih
 aBebofsQYy7uM//cA97r0u9hv6vc4kaDyrzZqOtFmK1bblyi1IQHML781Fw9zcg+brEB5tT8n2C4
 3qr6GPgBPePj0AiYMnkOYZl+Ft1345P9xZQpbwIfPGEkJ7JPA9m1MXnnxJmpdTzcav9Zei+nRAUa
 ZyvXYsGqun+gsnRrw9cqQ6eOFFZwao7/xkqL8SFLn/njN5eSj526f3kLYY1T5OizFD8wHF+OCza+
 k8F3h5b57iIXJcFWfgW9vfNN4J9ziRqBqIWqcU9OsvOjmYsTO6lGf94dXO5RbYSkVkYTk9CCMtzM
 bzqEtclFlLyp+exUU27PTl4PhGkfKkdwRPwXu3J+dYVP2195qubJ4gqr1hKOhcObZXWnkEw+6F9C
 GyZ44Q+DLPyX+MwClyz83U21vdxEpryD5dRQwVJRy59S49/2asmSeEn7rbCFmtlyFQtmzUzC/xba
 RN+VVj9DUh3TZXBi9hWEAP02Kq9O1EK/Tbf2/8vpL7yPXbArHUEGc233Y80OmAux3oN13+ztUzne
 lPksOlPd27Tf6L4y2yJOHolDOboZZUDh7jQajPahhQx+RFViJuI2LjmPuFh6Mem6TuJQIjD+/1YH
 vr6rTwNvlu5yIYYIEeILcVRr4wYNKSfJRGDMIez6j2IAdtaWfixj647lNwN4qOsSZg+fYhVZG4tF
 IS9w/C9ZAlaBtta5Gi5ak/yCah0K2qOyN9cETXcvLMBBWEBWT5ImHngsOZ6DSvxHvRZErPK++q6A
 c+xgiBi5JVKuVYa6QR3fZ9CNC7P9BW1oT5qIEWguCTF5tOP3jiRyYhI9XWnYQVnAKttrUvQ=
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

From: Thomas Wismer <thomas.wismer@scs.ch>

The TPS23881B uses different firmware than the TPS23881. Trying to load the
TPS23881 firmware on a TPS23881B device fails and must be omitted.

The TPS23881B ships with a more recent ROM firmware. Moreover, no updated
firmware has been released yet and so the firmware loading step must be
skipped. As of today, the TPS23881B is intended to use its ROM firmware.

Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
---
 drivers/net/pse-pd/tps23881.c | 69 +++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index b724b222ab44..76ec1555d60d 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -55,8 +55,6 @@
 #define TPS23881_REG_TPON	BIT(0)
 #define TPS23881_REG_FWREV	0x41
 #define TPS23881_REG_DEVID	0x43
-#define TPS23881_REG_DEVID_MASK	0xF0
-#define TPS23881_DEVICE_ID	0x02
 #define TPS23881_REG_CHAN1_CLASS	0x4c
 #define TPS23881_REG_SRAM_CTRL	0x60
 #define TPS23881_REG_SRAM_DATA	0x61
@@ -1012,8 +1010,28 @@ static const struct pse_controller_ops tps23881_ops = {
 	.pi_get_pw_req = tps23881_pi_get_pw_req,
 };
 
-static const char fw_parity_name[] = "ti/tps23881/tps23881-parity-14.bin";
-static const char fw_sram_name[] = "ti/tps23881/tps23881-sram-14.bin";
+struct tps23881_info {
+	u8 dev_id;	/* device ID and silicon revision */
+	const char *fw_parity_name;	/* parity code firmware file name */
+	const char *fw_sram_name;	/* SRAM code firmware file name */
+};
+
+enum tps23881_model {
+	TPS23881,
+	TPS23881B,
+};
+
+static const struct tps23881_info tps23881_info[] = {
+	[TPS23881] = {
+		.dev_id = 0x22,
+		.fw_parity_name = "ti/tps23881/tps23881-parity-14.bin",
+		.fw_sram_name = "ti/tps23881/tps23881-sram-14.bin",
+	},
+	[TPS23881B] = {
+		.dev_id = 0x24,
+		/* skip SRAM load, ROM provides Clause 145 hardware-level support */
+	},
+};
 
 struct tps23881_fw_conf {
 	u8 reg;
@@ -1085,16 +1103,17 @@ static int tps23881_flash_sram_fw_part(struct i2c_client *client,
 	return ret;
 }
 
-static int tps23881_flash_sram_fw(struct i2c_client *client)
+static int tps23881_flash_sram_fw(struct i2c_client *client,
+				  const struct tps23881_info *info)
 {
 	int ret;
 
-	ret = tps23881_flash_sram_fw_part(client, fw_parity_name,
+	ret = tps23881_flash_sram_fw_part(client, info->fw_parity_name,
 					  tps23881_fw_parity_conf);
 	if (ret)
 		return ret;
 
-	ret = tps23881_flash_sram_fw_part(client, fw_sram_name,
+	ret = tps23881_flash_sram_fw_part(client, info->fw_sram_name,
 					  tps23881_fw_sram_conf);
 	if (ret)
 		return ret;
@@ -1412,6 +1431,7 @@ static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
 static int tps23881_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	const struct tps23881_info *info;
 	struct tps23881_priv *priv;
 	struct gpio_desc *reset;
 	int ret;
@@ -1422,6 +1442,10 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 		return -ENXIO;
 	}
 
+	info = i2c_get_match_data(client);
+	if (!info)
+		return -EINVAL;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -1440,7 +1464,7 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 		 * to Load TPS2388x SRAM and Parity Code over I2C" (Rev E))
 		 * indicates we should delay that programming by at least 50ms. So
 		 * we'll wait the entire 50ms here to ensure we're safe to go to the
-		 * SRAM loading proceedure.
+		 * SRAM loading procedure.
 		 */
 		msleep(50);
 	}
@@ -1449,20 +1473,27 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) != TPS23881_DEVICE_ID) {
+	if (ret != info->dev_id) {
 		dev_err(dev, "Wrong device ID\n");
 		return -ENXIO;
 	}
 
-	ret = tps23881_flash_sram_fw(client);
-	if (ret < 0)
-		return ret;
+	if (info->fw_sram_name) {
+		ret = tps23881_flash_sram_fw(client, info);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_FWREV);
 	if (ret < 0)
 		return ret;
 
-	dev_info(&client->dev, "Firmware revision 0x%x\n", ret);
+	if (ret == 0xFF) {
+		dev_err(&client->dev, "Device entered safe mode\n");
+		return -ENXIO;
+	}
+	dev_info(&client->dev, "Firmware revision 0x%x%s\n", ret,
+		 ret == 0x00 ? " (ROM firmware)" : "");
 
 	/* Set configuration B, 16 bit access on a single device address */
 	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_GEN_MASK);
@@ -1498,13 +1529,21 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps23881_id[] = {
-	{ "tps23881" },
+	{ "tps23881", .driver_data = (kernel_ulong_t)&tps23881_info[TPS23881] },
+	{ "tps23881b", .driver_data = (kernel_ulong_t)&tps23881_info[TPS23881B] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps23881_id);
 
 static const struct of_device_id tps23881_of_match[] = {
-	{ .compatible = "ti,tps23881", },
+	{
+		.compatible = "ti,tps23881",
+		.data = &tps23881_info[TPS23881]
+	},
+	{
+		.compatible = "ti,tps23881b",
+		.data = &tps23881_info[TPS23881B]
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tps23881_of_match);
-- 
2.43.0


