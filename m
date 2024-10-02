Return-Path: <netdev+bounces-131287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B517298E05B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E5A1C2304B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1C1D0F6D;
	Wed,  2 Oct 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DJJY7myM"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE11940B0;
	Wed,  2 Oct 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885692; cv=none; b=VLeSlGq5dRyQVtqRuKpvplT1oo5OwBrfMEr+f05qyLahdG86bq2A3qaQiMnxTXrNUDUngOtjObIsjNvZ9oZTUWiE6hPATFgwwqdVy07DG26LiEM+9GdBeMgDdUtia6hWN0mIMEVuFVRR09qCm/oTaEQvKWq50CWFpr6mhZkmPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885692; c=relaxed/simple;
	bh=tSaUcqD7eHSaObZjjijtJrsg0WBYhM+Yr7DGFDUV5w0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JI64+6TYleVzx3YrInJqkg8NsbVyHFtGEM2lyOwq/iREzweLcsjtix46524OOvtXe/Wc69f4deimMiENDspjbeVkxaCRJeLrM4Q8D3/8VZi4BIYRKTnROqFFLZN6aLYobmEvgxJdgnNZ7MBYXsyTqZsyGJcXZsrVZcslrd+UeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DJJY7myM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD912FF806;
	Wed,  2 Oct 2024 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4biLTBMISLiI3PaOwg9EOAFMZ2vS5JuARGkBYnVsXc=;
	b=DJJY7myMzwD0eFIM6O5nZZgsiKHs6nmFpJ25Mkh5PgLSrCZnPbsMFef8Z5gmZEwO7Dnx2Z
	CCK0vu74+h7DMpMF/W2QvExmrsCig/HdAnR/sX0k6yxTBXgCIEoU6C9ilFNF9rHGBFgu2B
	gO6QAxJI0u7pbA5wXiFQvYCm67846dJmmDmr0fTGGWQqornUGTCb2LPqEuw7Qhk/AUftX2
	Lr8ae/Ah4VHATEmkUYp/PoQJfyOu2tBxwW+TC6abHb5p3odwFcn1qQnkSrtHJaPOUhgwZr
	pfMzrs7KDR+qitBSFrVZfCfPEbgORE78ZwzERL+X62lhFNpppGiMnoKha4wibw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 02 Oct 2024 18:14:19 +0200
Subject: [PATCH 08/12] net: pse-pd: pd692x0: Add support for PSE PI
 priority feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-feature_poe_port_prio-v1-8-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
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
 drivers/net/pse-pd/pd692x0.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 0af7db80b2f8..3a4a9836d621 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -685,6 +685,8 @@ static int pd692x0_ethtool_get_status(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 	status->c33_avail_pw_limit = ret;
+	/* PSE core priority start at 0 */
+	status->c33_prio = buf.data[2] - 1;
 
 	memset(&buf, 0, sizeof(buf));
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_CLASS];
@@ -1061,6 +1063,25 @@ static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
 	return pd692x0_sendrecv_msg(priv, &msg, &buf);
 }
 
+static int pd692x0_pi_set_prio(struct pse_controller_dev *pcdev, int id,
+			       unsigned int prio)
+{
+	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
+	struct pd692x0_msg msg, buf = {0};
+	int ret;
+
+	ret = pd692x0_fw_unavailable(priv);
+	if (ret)
+		return ret;
+
+	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
+	msg.sub[2] = id;
+	/* Controller priority from 1 to 3 */
+	msg.data[4] = prio + 1;
+
+	return pd692x0_sendrecv_msg(priv, &msg, &buf);
+}
+
 static const struct pse_controller_ops pd692x0_ops = {
 	.setup_pi_matrix = pd692x0_setup_pi_matrix,
 	.ethtool_get_status = pd692x0_ethtool_get_status,
@@ -1070,6 +1091,7 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_get_voltage = pd692x0_pi_get_voltage,
 	.pi_get_current_limit = pd692x0_pi_get_current_limit,
 	.pi_set_current_limit = pd692x0_pi_set_current_limit,
+	.pi_set_prio = pd692x0_pi_set_prio,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
@@ -1486,6 +1508,7 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	priv->pcdev.ops = &pd692x0_ops;
 	priv->pcdev.dev = dev;
 	priv->pcdev.types = ETHTOOL_PSE_C33;
+	priv->pcdev.pis_prio_max = 2;
 	ret = devm_pse_controller_register(dev, &priv->pcdev);
 	if (ret)
 		return dev_err_probe(dev, ret,

-- 
2.34.1


