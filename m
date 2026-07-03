Return-Path: <netdev+bounces-304403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id va/fIWhlR2quXgAAu9opvQ
	(envelope-from <netdev+bounces-304403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:31:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5B6FF91B
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:31:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=SiwtdE20;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304403-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F409301B032
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCD436A017;
	Fri,  3 Jul 2026 07:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABB36AB7B;
	Fri,  3 Jul 2026 07:31:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063867; cv=none; b=vFErYs3ymuTYgo8RrPlazW6AZiqEXvScVtWl+vRGLMp6YjLfWlCDO7j/7UPrzYyMDMp8hwult4w788jzPNfjJpS4vtzD5S1QBsjv1x11DgVM0orlB+gmvaCpVrc1IBpXg4Y/SV2RG2pvf41/iEgTYZtZ2LfLlPcgp35PCz2PKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063867; c=relaxed/simple;
	bh=p8cQXoUs+//ICDNt7pwm6vKOnBu1cPx5y/cf5zdBJt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+AD0/0DSO7CZvk2K/28//MJVXkwBFhRV9/dW9Hy92A+ydkqZymi5ITIm14CCjyQXphjeQBQCrgzcttFuW8lNTLRMI3HpI7Wj539OB+OW0GcRVX5s+nwkLEsoLKSbbhqc7TTiGooh1vHIj24u37L6z4Rf6CJWEA+veilQyPNYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SiwtdE20; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id B1C4C60C04;
	Fri,  3 Jul 2026 03:30:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063864; bh=LD8aJup3GxLaJEx9XLoXPZrAni6SD5Yjgh/sscj8mMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SiwtdE20fBsDARXmOjB/RaOEraZAgJe7NUcGcfovbI27aY6JXZMiXx5IZyRPwlbPk
	 ygxWpfXk8QKXeJGCQhXlZN2AzMQQ2i+N0IEXYqpm1pVHO0v7J/dXdCRN2Ot0rO/024
	 ieli6ZDkqlp/0ohMOosVfiWJNkq5abMXNB3B4k+z0e6vWJtILfsGFyhd7WuEohrCBP
	 j6BmyrgRWNRvFkUzqdnczbMrY6JBZ/KceF0GiFhrY6iVL22wPrAtHxfNvEZXnh6/t3
	 qkU2plJbefk/og2+sYF5N4e88Q+K10ZPaxn3EYbRXbEcpD5CnodnRO75Tn30FtGp5D
	 t9Buu2jp23yuw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:25 +1000
Subject: [PATCH net-next 06/12] net: dsa: qca8k: Refactor sequence number
 mismatch to use error code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-6-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
In-Reply-To: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=5721;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=HTwib/S6lAhzSsdf76IE7FLyrM2TcajaSQn+7o5lGXk=;
 b=j13IeURhbjy3zKGKv71klPpSTDHio+5H1QsU8Y9cNZsLsZXCsGC2gXI8Y5FUdzrKFkr91e3Tp
 UXyrtpIhLAoAkLZiagkh62bH5EVVAHXWk+eBtnjL0hthI1yA0cH8oCE
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304403-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:horms@kernel.org,m:f.fainelli@gmail.com,m:tobias@waldekranz.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch,waldekranz.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,padl.com:from_mime,padl.com:dkim,padl.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41E5B6FF91B

From: Andrew Lunn <andrew@lunn.ch>

Replace the boolean that the sequence numbers matches with an error
code. Now that responses with the wrong sequence number are dropped,
this is actually unused in this driver. However, other devices can
perform additional validation of a response with the correct sequence
number and potentially return -EPROTO to indicate some other sort of
error.

The value is only safe to use if the completion happens. Ensure the
return from the completion is always considered, and if it fails, a
timeout error is returned.

This is a preparation step to moving the error tracking into the DSA
core. This intermediate step is a bit ugly, but that all gets cleaned
up in the next patch.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2
-ret -> err
Extended commit message warning the code is ugly
Point out it is not actually used by this driver
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 49 ++++++++++++++++------------------------
 drivers/net/dsa/qca/qca8k.h      |  2 +-
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index fc5070402188e..499cc8ef5ddea 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -314,7 +314,7 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
 	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
-	bool ack;
+	int err;
 	int ret;
 
 	skb = qca8k_alloc_mdio_header(MDIO_READ, reg, NULL,
@@ -333,8 +333,6 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = priv->mgmt_conduit;
 
-	mgmt_eth_data->ack = false;
-
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
@@ -343,15 +341,15 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
 		memcpy(val + 1, mgmt_eth_data->data + 1, len - QCA_HDR_MGMT_DATA1_LEN);
 
-	ack = mgmt_eth_data->ack;
+	err = mgmt_eth_data->err;
 
 	mutex_unlock(&mgmt_eth_data->mutex);
 
 	if (ret)
 		return ret;
 
-	if (!ack)
-		return -EINVAL;
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -360,7 +358,7 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
 	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
-	bool ack;
+	int err;
 	int ret;
 
 	skb = qca8k_alloc_mdio_header(MDIO_WRITE, reg, val,
@@ -379,21 +377,19 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = priv->mgmt_conduit;
 
-	mgmt_eth_data->ack = false;
-
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	ack = mgmt_eth_data->ack;
+	err = mgmt_eth_data->err;
 
 	mutex_unlock(&mgmt_eth_data->mutex);
 
 	if (ret)
 		return ret;
 
-	if (!ack)
-		return -EINVAL;
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -577,25 +573,23 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 			struct sk_buff *read_skb, u32 *val)
 {
 	struct sk_buff *skb = skb_copy(read_skb, GFP_KERNEL);
-	bool ack;
+	int err;
 	int ret;
 
 	if (!skb)
 		return -ENOMEM;
 
-	mgmt_eth_data->ack = false;
-
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	ack = mgmt_eth_data->ack;
+	err = mgmt_eth_data->err;
 
 	if (ret)
 		return ret;
 
-	if (!ack)
-		return -EINVAL;
+	if (err)
+		return err;
 
 	*val = mgmt_eth_data->data[0];
 
@@ -611,7 +605,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	u32 write_val, clear_val = 0, val;
 	struct net_device *mgmt_conduit;
 	int ret, ret1;
-	bool ack;
+	int err;
 
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
@@ -679,21 +673,19 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	clear_skb->dev = mgmt_conduit;
 	write_skb->dev = mgmt_conduit;
 
-	mgmt_eth_data->ack = false;
-
 	ret = dsa_inband_request(&mgmt_eth_data->inband, write_skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	ack = mgmt_eth_data->ack;
+	err = mgmt_eth_data->err;
 
 	if (ret) {
 		kfree_skb(read_skb);
 		goto exit;
 	}
 
-	if (!ack) {
-		ret = -EINVAL;
+	if (err) {
+		ret = err;
 		kfree_skb(read_skb);
 		goto exit;
 	}
@@ -709,19 +701,17 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	}
 
 	if (read) {
-		mgmt_eth_data->ack = false;
-
 		ret = dsa_inband_request(&mgmt_eth_data->inband, read_skb,
 					 qca8k_mdio_header_fill_seq_num,
 					 QCA8K_ETHERNET_TIMEOUT);
 
-		ack = mgmt_eth_data->ack;
+		err = mgmt_eth_data->err;
 
 		if (ret)
 			goto exit;
 
-		if (!ack) {
-			ret = -EINVAL;
+		if (err) {
+			ret = err;
 			goto exit;
 		}
 
@@ -730,7 +720,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		kfree_skb(read_skb);
 	}
 exit:
-	mgmt_eth_data->ack = false;
 
 	/* This is expected to fail sometimes, so don't check return value. */
 	dsa_inband_request(&mgmt_eth_data->inband, clear_skb,
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 1054ba1c7e590..4c055aef674c2 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -394,7 +394,7 @@ enum {
 struct qca8k_mgmt_eth_data {
 	struct dsa_inband inband;
 	struct mutex mutex; /* Enforce one mdio read/write at time */
-	bool ack;
+	int err;
 	u32 data[4];
 };
 

-- 
2.43.0


