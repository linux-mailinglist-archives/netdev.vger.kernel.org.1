Return-Path: <netdev+bounces-227877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39550BB912D
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 21:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA493BF40F
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F61F4CA9;
	Sat,  4 Oct 2025 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="ams0vU+J"
X-Original-To: netdev@vger.kernel.org
Received: from out27.tophost.ch (out27.tophost.ch [46.232.182.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF23594B;
	Sat,  4 Oct 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759604958; cv=none; b=RvnVcLAEAIBy50AkRjSPtvOh/C7iAKzJGBGwxpPYVrnueF/8Eh+YSOA31pU3OchveGD1Nbuq89Nldtzi8FDZkKn0fIEDZQpsnR6F0yxpyOCRhPpmVDN4Hk69QxMXck0tdL5yp+6A7wZP6SYaTaCCYnuvEUME8HDFhqwfayGzFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759604958; c=relaxed/simple;
	bh=X6IIicotpxiTjeoPJBOLMa2XyxFKKyq85+MMJKh6TRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kndp5BPvik6G2AO3lI2da0Kaqf9RYiMcYhNZkb+i/fLV8CGBHRxME+FVmLyPOE44jsTbmyH9dN8rdLViAy6TXkknKCTYSJBZf8TUAjAtVN+H1IAP970Y5u4TNPPtXuxXesMy473fATjQT8yaMFoeGpu0fSCeteC6P+sCFbx8eR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=ams0vU+J; arc=none smtp.client-ip=46.232.182.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter4.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56dB-008dZE-6y; Sat, 04 Oct 2025 20:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YaOWx/fRrYI9KzDtweomNbmir7rK6cpG0e936mryXyw=; b=ams0vU+J3avJOjmYYIHahV6jBv
	YZQwFXltCafPhC/s6YMephkGeOp8dZoii0iB41YZtjYpvW77rQ5o2jY+EYnVO3OS7RgPBpG9EKa1H
	SIMrnf/765U4SqPYO3+p/HjPrFSklrzLzmZM0bv4h/IXQt2HHdFoXdnOy8w+uF1rVTzk1MT5UVgLd
	htsTuSCsfzno7MYijOr9ORzD7tvnEk63yT85RW3rq/rJveoGRayCQ7mu02sr+fHu4MW4NgTB7cv42
	WIwIiUMDkCb+v52FFhllTJSuFJD3ZA/e9bB6ld/yfuRn5+Yev180vPqMQydQKW706Utbq3eOkp6db
	hWcMq1Pw==;
Received: from 82-220-106-230.ftth.solnet.ch ([82.220.106.230]:60199 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56dA-00000001wpX-3DdC;
	Sat, 04 Oct 2025 20:05:14 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] net: pse-pd: tps23881: Add support for TPS23881B
Date: Sat,  4 Oct 2025 20:03:51 +0200
Message-ID: <20251004180351.118779-6-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004180351.118779-2-thomas@wismer.xyz>
References: <20251004180351.118779-2-thomas@wismer.xyz>
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (1.28762366459e-05)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVi2akg9UvFd2ua6fN7K9qw7pAicyIPYL+A
 xiWia1vhbSu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zLf8
 ktPpXAA3CeWTUS9HatGeCqjodN89yZ5dSG6xQt1sCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wdel5pGtBZGkILbtkwjuL+TU9W7vD
 6C469DIPe8wH3iOJTcWsqU26dvDcYIYzaKVPzizNp/gleLRyr2ddmlcu+i1jPgDrl7KDWN+JeAU8
 1aNgksp0UtIrN0U07614AkdB++MTbkn6z1fsm8NoMVdUr8MDPUrsZkS8fIjQg/OlnCq9AIC5Z5Eo
 vuL59tfrqmU9AeFRYyZjHLqYAy4+QNNyid5H8SumKJ6G2ITZ1QpN+fKlKhj6uW6qT1824h/4yzd+
 H8TZI7fFfQwiuwD2LcLdqjNFmtMtCFuKzK3WYzvpld0/yccMnl06aHo07R+V2VbvDXc+galx1KGI
 Pp5jnkiI48S3blKfwQpggXpr4ijI5V97nizzgiBlcUwLhZK/ZHw1RdpNQJ37uqLsFt7+YGhJkDU9
 4+PQCJgyeQ5hmX4W3XfjuZq3ey7jWD75mz2FgepuKE1QHL+v8HSjw4E9FZ48n35YGxLcRm31r7HJ
 L906rtNSlbyOZqJAl0NcWR3h5RCCpdhlI2FswyUM1YB4pb6NihzVEQJD0k3NJ3BxI7jJWMBode2U
 Svel4Ph4LtRWGzmVykX/svZHtlcv4/x61HBbxR8gr/U0flMcy2Vi/IcBgY4ane5tOXPRIqHUx6+W
 zGK5Hg6zly/hm7kTCa25PmFuNjYUvwsQEI5UkfpCg7AUhDMCPBbeqGTYbMVyDujNe4sJRauodX0r
 OWGdLvp0AmQc5PA08uQ3B+geyZWhLXoJPBYE7fs8i/Lg4VMmqeqQOhF8kMn3arb1xVlaLjgbxjTB
 gAHkgTtbIGX4Gktj7c2CONolFYbP7eetTUcNPZF8UuWWRQPHxHs4uWfEMXRAPK2SKfClf4PqAkNV
 ZDxegoc9+nSx1zi/m+kogemLltU8nWR6eNXl1Kc2a+wlKs+ogYIxcMllcGL2FYQA/TYqr07UQr9N
 8YzZ1OXdAJhrEGn8vjZdfatsJHAzgC46MYYXOcKJkR5mWDA3wLMqtkpqhq8QHjwHB17Mh03hOC2D
 8X08bmfUo2hx63fUqSBCUpmH010fZI9bHEjTkiJxSPqFbdrqtFE8gK0UxPGon/0gulkiYXfVWWO3
 KRWMcR+Z5yTvtzkwsDU=
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

From: Thomas Wismer <thomas.wismer@scs.ch>

The TPS23881B device requires different firmware, but has a more recent ROM
firmware. Since no updated firmware has been released yet, the firmware
loading step must be skipped. The device runs from its ROM firmware.

Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
---
 drivers/net/pse-pd/tps23881.c | 65 +++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index b724b222ab44..f45c08759082 100644
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
+		/* skip SRAM load, ROM firmware already IEEE802.3bt compliant */
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
 
+	info = device_get_match_data(dev);
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
@@ -1449,20 +1473,26 @@ static int tps23881_i2c_probe(struct i2c_client *client)
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
+	if (ret == 0xFF)
+		dev_warn(&client->dev, "Device entered safe mode\n");
+	else
+		dev_info(&client->dev, "Firmware revision 0x%x%s\n", ret,
+			 ret == 0x00 ? " (ROM firmware)" : "");
 
 	/* Set configuration B, 16 bit access on a single device address */
 	ret = i2c_smbus_read_byte_data(client, TPS23881_REG_GEN_MASK);
@@ -1504,7 +1534,14 @@ static const struct i2c_device_id tps23881_id[] = {
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


