Return-Path: <netdev+bounces-216083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE5B31F9D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760551D01609
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D55352091;
	Fri, 22 Aug 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MuTKyEDi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96723255F27;
	Fri, 22 Aug 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877084; cv=none; b=Sumt/UyIkfrlmYzZt+eYXt0JepnQ/KIbT8nOdD3M/6gD5FcSlNPcxU8OasjX6c5mdCKM9eQFO0P68wsj7gBCCCEssbofsq1UUNbWXz4U2bacTbch75fIIqX08kfeOmOd8StTgnTQSnjdRGVr6Jn0rF54y6rqVS8ANiYG3kWvyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877084; c=relaxed/simple;
	bh=zTh2RQmsWjHi/W1F00068YysELVrAeFQd288EhULw5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKxoHvhLNF4vTbJrTLVDQ1K8HCG1UIuyzuAc142hFUviWRPfaeasMKhsVy69XzsWQP0SpjvDNEKTdp8XZBvBN+Sl4Rr+O2y120dDI7KiLHbX1NLrCXfQxmtSQQ1oXks3cJqe/BNnx/AgWhb+FNuQTw6a/yiUpTv2Rx0SQm+g6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MuTKyEDi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E4ED34E40BD2;
	Fri, 22 Aug 2025 15:38:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C071A604AD;
	Fri, 22 Aug 2025 15:38:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34C261C22D6AD;
	Fri, 22 Aug 2025 17:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755877080; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iQBT0xYYoJCEm5eXAEloAFRIdH+1WIddcidbneBHGHs=;
	b=MuTKyEDitUzw5CmkYkGFlUdOszfyVN9c8xMWnRobVYtbLXmPYb4NYgaQ2r6wR8i1oJFobn
	D+SGmX3MEFvkanxUE/fLxxw1kUl0XoGgfVEE+ZHCc8AEqaNlGCxKMJ5gY6d4SRALDwBJS/
	DnvodW4LCKVCCD2SAy5T69u7sLd2i0gdlrcby105y23SKBfcYrGjvfnnCUpliFGC/VOL2Z
	rjwLiWTABer0/9vwn0n/wMi0v6UH1N2vo5b9zoTOw+yeD7ywmfHFTCmgkk768Okvj4gbYP
	YQuaLzv1L1aV4AmNOyOQD9BU2aJbrDuYTehqqXORfdwVn5vAIFOPg1zoAYyjUQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 22 Aug 2025 17:37:02 +0200
Subject: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface for
 configuration save/reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
In-Reply-To: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add sysfs attributes save_conf and reset_conf to enable userspace
management of the PSE's permanent configuration stored in EEPROM.

The save_conf attribute allows saving the current configuration to
EEPROM by writing '1'. The reset_conf attribute restores factory
defaults and reinitializes the port matrix configuration.

Skip hardware configuration initialization on probe when a saved
configuration is already present in EEPROM (detected via user byte 42).

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 151 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 8b94967bb4fb..202e91ec9b9a 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -30,6 +30,8 @@
 #define PD692X0_FW_MIN_VER	5
 #define PD692X0_FW_PATCH_VER	5
 
+#define PD692X0_USER_BYTE	42
+
 enum pd692x0_fw_state {
 	PD692X0_FW_UNKNOWN,
 	PD692X0_FW_OK,
@@ -80,6 +82,9 @@ enum {
 	PD692X0_MSG_GET_PORT_PARAM,
 	PD692X0_MSG_GET_POWER_BANK,
 	PD692X0_MSG_SET_POWER_BANK,
+	PD692X0_MSG_SET_USER_BYTE,
+	PD692X0_MSG_SAVE_SYS_SETTINGS,
+	PD692X0_MSG_RESTORE_FACTORY,
 
 	/* add new message above here */
 	PD692X0_MSG_CNT
@@ -103,6 +108,7 @@ struct pd692x0_priv {
 	bool last_cmd_key;
 	unsigned long last_cmd_key_time;
 
+	bool cfg_saved;
 	enum ethtool_c33_pse_admin_state admin_state[PD692X0_MAX_PIS];
 	struct regulator_dev *manager_reg[PD692X0_MAX_MANAGERS];
 	int manager_pw_budget[PD692X0_MAX_MANAGERS];
@@ -193,6 +199,24 @@ static const struct pd692x0_msg pd692x0_msg_template_list[PD692X0_MSG_CNT] = {
 		.key = PD692X0_KEY_CMD,
 		.sub = {0x07, 0x0b, 0x57},
 	},
+	[PD692X0_MSG_SET_USER_BYTE] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x41, PD692X0_USER_BYTE},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
+	[PD692X0_MSG_SAVE_SYS_SETTINGS] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x06, 0x0f},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
+	[PD692X0_MSG_RESTORE_FACTORY] = {
+		.key = PD692X0_KEY_PRG,
+		.sub = {0x2d, 0x4e},
+		.data = {0x4e, 0x4e, 0x4e, 0x4e,
+			 0x4e, 0x4e, 0x4e, 0x4e},
+	},
 };
 
 static u8 pd692x0_build_msg(struct pd692x0_msg *msg, u8 echo)
@@ -1266,9 +1290,12 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	if (ret)
 		goto err_managers_req_pw;
 
-	ret = pd692x0_hw_conf_init(priv);
-	if (ret)
-		goto err_managers_req_pw;
+	/* Do not init the conf if it is already saved */
+	if (!priv->cfg_saved) {
+		ret = pd692x0_hw_conf_init(priv);
+		if (ret)
+			goto err_managers_req_pw;
+	}
 
 	pd692x0_of_put_managers(priv, manager);
 	return 0;
@@ -1722,6 +1749,104 @@ static const struct fw_upload_ops pd692x0_fw_ops = {
 	.cleanup = pd692x0_fw_cleanup,
 };
 
+static ssize_t save_conf_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *save_buf, size_t count)
+{
+	struct pd692x0_priv *priv = dev_get_drvdata(dev);
+	struct pd692x0_msg msg, buf = {0};
+	bool save;
+	int ret;
+
+	if (kstrtobool(save_buf, &save) || !save)
+		return -EINVAL;
+
+	mutex_lock(&priv->pcdev.lock);
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		goto out;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_USER_BYTE];
+	ret = pd692x0_sendrecv_msg(priv, &msg, &buf);
+	if (ret)
+		goto out;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SAVE_SYS_SETTINGS];
+	ret = pd692x0_send_msg(priv, &msg);
+	if (ret) {
+		dev_err(&priv->client->dev,
+			"Failed to save the configuration (%pe)\n",
+			ERR_PTR(ret));
+		goto out;
+	}
+
+	msleep(50); /* Sleep 50ms as described in the datasheet */
+
+	ret = i2c_master_recv(priv->client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		if (ret >= 0)
+			ret = -EIO;
+		goto out;
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&priv->pcdev.lock);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(save_conf);
+
+static ssize_t reset_conf_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *reset_buf, size_t count)
+{
+	struct pd692x0_priv *priv = dev_get_drvdata(dev);
+	struct pd692x0_msg msg, buf = {0};
+	bool reset;
+	int ret;
+
+	if (kstrtobool(reset_buf, &reset) || !reset)
+		return -EINVAL;
+
+	mutex_lock(&priv->pcdev.lock);
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		goto out;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_RESTORE_FACTORY];
+	ret = pd692x0_send_msg(priv, &msg);
+	if (ret) {
+		dev_err(&priv->client->dev,
+			"Failed to reset the configuration (%pe)\n",
+			ERR_PTR(ret));
+		goto out;
+	}
+
+	msleep(100); /* Sleep 100ms as described in the datasheet */
+
+	ret = i2c_master_recv(priv->client, (u8 *)&buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		if (ret >= 0)
+			ret = -EIO;
+		goto out;
+	}
+
+	ret = pd692x0_hw_conf_init(priv);
+	if (ret < 0) {
+		dev_err(&priv->client->dev,
+			"Error configuring ports matrix (%pe)\n",
+			ERR_PTR(ret));
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&priv->pcdev.lock);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(reset_conf);
+
 static int pd692x0_i2c_probe(struct i2c_client *client)
 {
 	static const char * const regulators[] = { "vdd", "vdda" };
@@ -1788,6 +1913,9 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 		}
 	}
 
+	if (buf.data[2] == PD692X0_USER_BYTE)
+		priv->cfg_saved = true;
+
 	priv->np = dev->of_node;
 	priv->pcdev.nr_lines = PD692X0_MAX_PIS;
 	priv->pcdev.owner = THIS_MODULE;
@@ -1808,7 +1936,22 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 				     "failed to register to the Firmware Upload API\n");
 	priv->fwl = fwl;
 
+	ret = sysfs_create_file(&dev->kobj, &dev_attr_save_conf.attr);
+	if (ret)
+		goto err_sysfs;
+
+	ret = sysfs_create_file(&dev->kobj, &dev_attr_reset_conf.attr);
+	if (ret)
+		goto err_sysfs_reset_conf;
+
 	return 0;
+
+err_sysfs_reset_conf:
+	sysfs_remove_file(&dev->kobj, &dev_attr_save_conf.attr);
+err_sysfs:
+	firmware_upload_unregister(priv->fwl);
+
+	return ret;
 }
 
 static void pd692x0_i2c_remove(struct i2c_client *client)
@@ -1816,6 +1959,8 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
 	struct pd692x0_priv *priv = i2c_get_clientdata(client);
 
 	pd692x0_managers_free_pw_budget(priv);
+	sysfs_remove_file(&client->dev.kobj, &dev_attr_reset_conf.attr);
+	sysfs_remove_file(&client->dev.kobj, &dev_attr_save_conf.attr);
 	firmware_upload_unregister(priv->fwl);
 }
 

-- 
2.43.0


