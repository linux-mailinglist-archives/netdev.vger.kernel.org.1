Return-Path: <netdev+bounces-304406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7xEyLQxmR2rbXgAAu9opvQ
	(envelope-from <netdev+bounces-304406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:34:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EAD6FF9A2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:34:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=EMsP8q2M;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304406-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304406-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D350308EBAB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866136A017;
	Fri,  3 Jul 2026 07:31:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFD35F8D2;
	Fri,  3 Jul 2026 07:31:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063882; cv=none; b=Ae5qjlPaqga/JXAL0u+hyfhJfenurOHRErSl1D3y75MeXOMRl3vMeMo6sfssO2PP+tXn5KKGwXxlYORIMDRSM4JlTa5TRF4uRZzIDNCEWzvFkOuJxVBgibkL5ON73gitEwyyu5ITTbe4xdDWwp+l6paED9KDMJ8u7zfIwwdS794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063882; c=relaxed/simple;
	bh=WpwvC+2knIbZ7sBvuMVm9173ocau/iisQMPFo+lVF6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFB1/jaf8v+Cyfx1JUlx5aeXYdjKvs5XSioqOkaPuawH/Z0eo6LjI9nC8zHA0/l2Mrg1xqoe0Nf4ekYLdQFaxzMJUUvNUAQt+KD3I55QplNmVK6n8/3drWqaeNaNpY0x5WRMOCmfAEbz9Lvd+T5Ynxau6HzqenrYWWWjcQPKYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=EMsP8q2M; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3B4BC60C0B;
	Fri,  3 Jul 2026 03:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063879; bh=pJobKabd55SDRxfRKd0jvP5/q5M6TOXT6E6GQbzQgUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EMsP8q2MeWdVIBPcXtINLO8zSBFdHGtm5eVqLoy5qiyIEiNbxwGQAhskZlO+op4ww
	 FqCEkBVPK0dxD53Ez5toZTNHpU9RzwZq6+W7fdbvNne+H630VXPe9ifHHOdoileOjb
	 LAr9FG1GWR36j9bqD6kLt/NgTHmnTN8TRKjvFc4dXNel9G7kscgR13xNhoEEQPbSv4
	 lF13PBPAnFPtX9ROnCGCro//xznMo057Ll5W7ONSBXBrz3g6Dm5je5eMIsB7LAExWj
	 ERZeMQnmizWLUuwsUqWxmJ7Gt+cVvdURCyv1waiL6dPUImtsCx+quUQAKFhtbKsHd5
	 MvBZEkHnBeQOw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:28 +1000
Subject: [PATCH net-next 09/12] net: dsa: qca8k: Move inband mutex into DSA
 core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-9-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=8402;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=V7NMH7BRZjLDXViaRTwAb9xh3YEEfiKYPon9BqeHWQA=;
 b=uqY7HPFKcMkaOf+98tdPpCdjkz71YimqiHhliz80gmDOWpunCkfK28P/m2G9ccpdr5nPScD7K
 qFIVkJG0rmeBDYp66vXuNR7uuiC0VKqBCZAtJbs/h+NNlGGDMev7lnB
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304406-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,padl.com:from_mime,padl.com:dkim,padl.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18EAD6FF9A2

From: Andrew Lunn <andrew@lunn.ch>

The mutex serves two purposes:

It serialises operations on the switch, so that only one
request/response can be happening at once.

It protects priv->mgmt_master, which itself has two purposes.  If the
hardware is wrongly wired, the wrong switch port is connected to the
cpu, inband cannot be used. In this case it has the value
NULL. Additionally, if the master is down, it is set to NULL.
Otherwise it points to the netdev used to send frames to the switch.

The protection of priv->mgmt_master is not required. It is a single
pointer, which will be updated atomically. It is not expected that the
interface disappears, it only goes down. Hence mgmt_master will always
be valid, or NULL.

Move the check for the master device being NULL into the core.  Also,
move the mutex for serialisation into the core.

The MIB operations don't follow request/response semantics, so its
mutex is left untouched.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   | 68 ++++++++------------------------------
 drivers/net/dsa/qca/qca8k-common.c |  2 +-
 drivers/net/dsa/qca/qca8k.h        |  1 -
 include/net/dsa.h                  |  4 +++
 net/dsa/dsa.c                      |  9 +++++
 5 files changed, 27 insertions(+), 57 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 94332497902c2..14371c3c9a459 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -324,65 +324,39 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mgmt_eth_data->mutex);
-
-	/* Check if the mgmt_conduit if is operational */
-	if (!priv->mgmt_conduit) {
-		kfree_skb(skb);
-		mutex_unlock(&mgmt_eth_data->mutex);
-		return -EINVAL;
-	}
-
-	skb->dev = priv->mgmt_conduit;
+	skb->dev = READ_ONCE(priv->mgmt_conduit);
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
 				 data, sizeof(data),
 				 QCA8K_ETHERNET_TIMEOUT);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = 0;
 
 	*val = data[0];
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
 		memcpy(val + 1, &data[1], len - QCA_HDR_MGMT_DATA1_LEN);
 
-out:
-	mutex_unlock(&mgmt_eth_data->mutex);
-
-	return ret;
+	return 0;
 }
 
 static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
 	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
-	int ret;
 
 	skb = qca8k_alloc_mdio_header(MDIO_WRITE, reg, val,
 				      QCA8K_ETHERNET_MDIO_PRIORITY, len);
 	if (!skb)
 		return -ENOMEM;
 
-	mutex_lock(&mgmt_eth_data->mutex);
+	skb->dev = READ_ONCE(priv->mgmt_conduit);
 
-	/* Check if the mgmt_conduit if is operational */
-	if (!priv->mgmt_conduit) {
-		kfree_skb(skb);
-		mutex_unlock(&mgmt_eth_data->mutex);
-		return -EINVAL;
-	}
-
-	skb->dev = priv->mgmt_conduit;
-
-	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
-				 qca8k_mdio_header_fill_seq_num,
-				 NULL, 0,
-				 QCA8K_ETHERNET_TIMEOUT);
-
-	mutex_unlock(&mgmt_eth_data->mutex);
-
-	return ret;
+	return dsa_inband_request(&mgmt_eth_data->inband, skb,
+				  qca8k_mdio_header_fill_seq_num,
+				  NULL, 0,
+				  QCA8K_ETHERNET_TIMEOUT);
 }
 
 static int
@@ -484,7 +458,7 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
 	struct qca8k_priv *priv = ctx;
 	u32 reg = *(u16 *)reg_buf;
 
-	if (priv->mgmt_conduit &&
+	if (READ_ONCE(priv->mgmt_conduit) &&
 	    !qca8k_read_eth(priv, reg, val_buf, val_len))
 		return 0;
 
@@ -507,7 +481,7 @@ qca8k_bulk_gather_write(void *ctx, const void *reg_buf, size_t reg_len,
 	u32 reg = *(u16 *)reg_buf;
 	u32 *val = (u32 *)val_buf;
 
-	if (priv->mgmt_conduit &&
+	if (READ_ONCE(priv->mgmt_conduit) &&
 	    !qca8k_write_eth(priv, reg, val, val_len))
 		return 0;
 
@@ -645,17 +619,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 * 3. Get the data if we are reading
 	 * 4. Reset the mdio master (even with error)
 	 */
-	mutex_lock(&mgmt_eth_data->mutex);
-
-	/* Check if mgmt_conduit is operational */
-	mgmt_conduit = priv->mgmt_conduit;
-	if (!mgmt_conduit) {
-		mutex_unlock(&mgmt_eth_data->mutex);
-		mutex_unlock(&priv->bus->mdio_lock);
-		ret = -EINVAL;
-		goto err_mgmt_conduit;
-	}
-
+	mgmt_conduit = READ_ONCE(priv->mgmt_conduit);
 	read_skb->dev = mgmt_conduit;
 	clear_skb->dev = mgmt_conduit;
 	write_skb->dev = mgmt_conduit;
@@ -701,14 +665,10 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 			   NULL, 0,
 			   QCA8K_ETHERNET_TIMEOUT);
 
-	mutex_unlock(&mgmt_eth_data->mutex);
 	mutex_unlock(&priv->bus->mdio_lock);
 
 	return ret;
 
-	/* Error handling before lock */
-err_mgmt_conduit:
-	kfree_skb(read_skb);
 err_read_skb:
 	kfree_skb(clear_skb);
 err_clear_skb:
@@ -1698,13 +1658,12 @@ qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
 	if (dp->index != 0)
 		return;
 
-	mutex_lock(&priv->mgmt_eth_data.mutex);
 	mutex_lock(&priv->mib_eth_data.mutex);
 
-	priv->mgmt_conduit = operational ? (struct net_device *)conduit : NULL;
+	WRITE_ONCE(priv->mgmt_conduit,
+		   operational ? (struct net_device *)conduit : NULL);
 
 	mutex_unlock(&priv->mib_eth_data.mutex);
-	mutex_unlock(&priv->mgmt_eth_data.mutex);
 }
 
 static int qca8k_connect_tag_protocol(struct dsa_switch *ds,
@@ -2032,7 +1991,6 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	if (!priv->ds)
 		return -ENOMEM;
 
-	mutex_init(&priv->mgmt_eth_data.mutex);
 	dsa_inband_init(&priv->mgmt_eth_data.inband, U32_MAX);
 
 	mutex_init(&priv->mib_eth_data.mutex);
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 13005f10edb7d..def2c44042d7b 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -499,7 +499,7 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 	u32 hi = 0;
 	int ret;
 
-	if (priv->mgmt_conduit && priv->info->ops->autocast_mib &&
+	if (READ_ONCE(priv->mgmt_conduit) && priv->info->ops->autocast_mib &&
 	    priv->info->ops->autocast_mib(ds, port, data) > 0)
 		return;
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index db89025b4243a..ccf92c85ccb14 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -393,7 +393,6 @@ enum {
 
 struct qca8k_mgmt_eth_data {
 	struct dsa_inband inband;
-	struct mutex mutex; /* Enforce one mdio read/write at time */
 };
 
 struct qca8k_mib_eth_data {
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 50ac6f0aa2e67..af16347a3d331 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1355,8 +1355,12 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
  * If there is a thread waiting for the response, resp will point to a
  * buffer to copy the response to. If the thread has given up waiting,
  * resp will be a NULL pointer.
+ *
+ * The lock is used to serialise all inband operations. It also protects
+ * the seqno, which is incremented while holding the lock.
  */
 struct dsa_inband {
+	struct mutex lock; /* Serialise operations */
 	struct completion completion;
 	u32 seqno;
 	u32 seqno_mask;
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 3e480770854ca..2a8d47eb58e13 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1837,6 +1837,7 @@ EXPORT_SYMBOL_GPL(dsa_port_simple_hsr_leave);
 void dsa_inband_init(struct dsa_inband *inband, u32 seqno_mask)
 {
 	init_completion(&inband->completion);
+	mutex_init(&inband->lock);
 	spin_lock_init(&inband->resp_lock);
 	inband->seqno_mask = seqno_mask;
 	inband->seqno = 0;
@@ -1898,6 +1899,13 @@ int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
 	int ret;
 
+	if (!skb->dev) {
+		kfree_skb(skb);
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&inband->lock);
+
 	inband->err = 0;
 
 	spin_lock_bh(&inband->resp_lock);
@@ -1920,6 +1928,7 @@ int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 	inband->resp = NULL;
 	inband->resp_len = 0;
 	spin_unlock_bh(&inband->resp_lock);
+	mutex_unlock(&inband->lock);
 
 	if (ret == 0)
 		return -ETIMEDOUT;

-- 
2.43.0


