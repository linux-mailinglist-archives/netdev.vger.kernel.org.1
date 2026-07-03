Return-Path: <netdev+bounces-304404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IIKFEtVlR2rUXgAAu9opvQ
	(envelope-from <netdev+bounces-304404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67156FF984
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=tWbuUZIj;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304404-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304404-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B836830731CE
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98836A340;
	Fri,  3 Jul 2026 07:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72F36A01D;
	Fri,  3 Jul 2026 07:31:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063872; cv=none; b=Oe2a0xvJTwIU7u61zVoHcxS6k1Lj5ZMHX5f79OF2qdGbGkN3Uu8L9hLZDswhLJxP05jHj3WgDe42DfVq1U4gL/k8ozZ6lJ361LY0tk/REv2RbCDrzNmvmVkLa77b9vWBWKxWPZKVHkemi0qWOBPE2NeUlgNnrfGM6qTsD/vLoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063872; c=relaxed/simple;
	bh=urN44PONrrtXl+U2ptxmg5x5g8fCn/X/SVxccn2Uo+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NB70EeTIx2lau9MhWVQLFPqYbKMyafcNix6yu6nVCbNtl4muGfLIqtkzFhfxVtRekHbkz6GKypOxpUbjigny6GlyQgxyZzM6AcBrYFmj8lx4l50mkc19k1vP7I6ICObvTaat2exlnXU1JJ/EsqkupFNhlfOT/kdPd/Ia0TcKExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=tWbuUZIj; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id DD98160C1E;
	Fri,  3 Jul 2026 03:31:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063869; bh=h2Zi8BswpO1nA4q+h/OglqF7J1T5LkAJLQAFu7P+2W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tWbuUZIjWi74R1MxY4nZp+XtaoH3tCEy2vgRkJdjycpwtOE4+5hQs7QpVYuSdCkzG
	 OBSurXLGKLe2eVuMDG3KYep0L8fpPyOABhAeyQfPr1T/Gadh8/QEVGlXONFYkne1+r
	 LXzmutQpPH9GTDouonkzqBax/2j2UyFxPr0c89OLRxvf/oQPIVtXwJTHHyU2s+AM1b
	 TafGAn8Ii1ImZ7Tssfu8VLL2GQH0mifIB1PUzDA9PXxw8CwUQYkxdb+OS/vdFj1PTM
	 wDIdTAxrvVrhHv7kOm/ac0uTgTpNVYpZ2+tXA38SCZfoEnd7jYUnBd4aDJBTU5iJtf
	 0OkLsfQhPHqxQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:26 +1000
Subject: [PATCH net-next 07/12] net: dsa: qca8k: Pass error code from reply
 decoder to requester
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-7-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=9850;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=9xP+gng6Jcz7UsokZXwpzHW3IvZ79oZm5yUzdUw1nNQ=;
 b=u7OET9iYiGqvH2crD75a/ambNr9Mr983CSGon01JxgfWuq4PJ7Mq8Fmbbujlqn0WfiweMmlmx
 AeZvbAxImKcAE2cgG/TRvtPi2KZICxMgsuDecweqCX9ByeTmSDZIrl7
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
	TAGGED_FROM(0.00)[bounces-304404-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:email,padl.com:from_mime,padl.com:dkim,padl.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A67156FF984

From: Andrew Lunn <andrew@lunn.ch>

The code which decodes the frame and signals the complete can detect
error within the reply, such as fields have unexpected values. Pass an
error code between the completer and the function waiting on the
complete. This simplifies the error handling, since all errors are
combined into one place.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2:

Remove EPROTO if the sequence numbers don't match, drop the reply
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 70 +++++++++++++---------------------------
 drivers/net/dsa/qca/qca8k.h      |  2 --
 include/net/dsa.h                | 13 +++++++-
 net/dsa/dsa.c                    | 33 +++++++++++++++++--
 4 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 499cc8ef5ddea..ffa3b1ba23bed 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -167,6 +167,8 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 	struct qca_mgmt_ethhdr *mgmt_ethhdr;
 	u32 command;
 	u8 len, cmd;
+	u32 data[4];
+	int err = 0;
 	int i;
 
 	mgmt_ethhdr = (struct qca_mgmt_ethhdr *)skb_mac_header(skb);
@@ -191,7 +193,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 		return;
 
 	if (cmd == MDIO_READ) {
-		u32 *val = mgmt_eth_data->data;
+		u32 *val = &data[0];
 
 		*val = get_unaligned_le32(&mgmt_ethhdr->mdio_data);
 
@@ -213,7 +215,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 		}
 	}
 
-	dsa_inband_complete(&mgmt_eth_data->inband);
+	dsa_inband_complete(&mgmt_eth_data->inband, &data, sizeof(data), err);
 }
 
 static struct sk_buff *qca8k_alloc_mdio_header(enum mdio_cmd cmd, u32 reg, u32 *val,
@@ -314,7 +316,7 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
 	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
-	int err;
+	u32 data[4];
 	int ret;
 
 	skb = qca8k_alloc_mdio_header(MDIO_READ, reg, NULL,
@@ -335,30 +337,25 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
+				 data, sizeof(data),
 				 QCA8K_ETHERNET_TIMEOUT);
+	if (ret < 0)
+		goto out;
 
-	*val = mgmt_eth_data->data[0];
+	*val = data[0];
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
-		memcpy(val + 1, mgmt_eth_data->data + 1, len - QCA_HDR_MGMT_DATA1_LEN);
-
-	err = mgmt_eth_data->err;
+		memcpy(val + 1, &data[1], len - QCA_HDR_MGMT_DATA1_LEN);
 
+out:
 	mutex_unlock(&mgmt_eth_data->mutex);
 
-	if (ret)
-		return ret;
-
-	if (err)
-		return err;
-
-	return 0;
+	return ret;
 }
 
 static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 {
 	struct qca8k_mgmt_eth_data *mgmt_eth_data = &priv->mgmt_eth_data;
 	struct sk_buff *skb;
-	int err;
 	int ret;
 
 	skb = qca8k_alloc_mdio_header(MDIO_WRITE, reg, val,
@@ -379,19 +376,12 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
+				 NULL, 0,
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	err = mgmt_eth_data->err;
-
 	mutex_unlock(&mgmt_eth_data->mutex);
 
-	if (ret)
-		return ret;
-
-	if (err)
-		return err;
-
-	return 0;
+	return ret;
 }
 
 static int
@@ -573,7 +563,7 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 			struct sk_buff *read_skb, u32 *val)
 {
 	struct sk_buff *skb = skb_copy(read_skb, GFP_KERNEL);
-	int err;
+	u32 data[4];
 	int ret;
 
 	if (!skb)
@@ -581,17 +571,13 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
 				 qca8k_mdio_header_fill_seq_num,
+				 data, sizeof(data),
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	err = mgmt_eth_data->err;
-
 	if (ret)
 		return ret;
 
-	if (err)
-		return err;
-
-	*val = mgmt_eth_data->data[0];
+	*val = data[0];
 
 	return 0;
 }
@@ -604,8 +590,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	struct qca8k_mgmt_eth_data *mgmt_eth_data;
 	u32 write_val, clear_val = 0, val;
 	struct net_device *mgmt_conduit;
+	u32 resp_data[4];
 	int ret, ret1;
-	int err;
 
 	if (regnum >= QCA8K_MDIO_MASTER_MAX_REG)
 		return -EINVAL;
@@ -675,21 +661,14 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, write_skb,
 				 qca8k_mdio_header_fill_seq_num,
+				 NULL, 0,
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	err = mgmt_eth_data->err;
-
 	if (ret) {
 		kfree_skb(read_skb);
 		goto exit;
 	}
 
-	if (err) {
-		ret = err;
-		kfree_skb(read_skb);
-		goto exit;
-	}
-
 	ret = read_poll_timeout(qca8k_phy_eth_busy_wait, ret1,
 				!(val & QCA8K_MDIO_MASTER_BUSY), 0,
 				QCA8K_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC, false,
@@ -703,19 +682,13 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	if (read) {
 		ret = dsa_inband_request(&mgmt_eth_data->inband, read_skb,
 					 qca8k_mdio_header_fill_seq_num,
+					 resp_data, sizeof(resp_data),
 					 QCA8K_ETHERNET_TIMEOUT);
 
-		err = mgmt_eth_data->err;
-
 		if (ret)
 			goto exit;
 
-		if (err) {
-			ret = err;
-			goto exit;
-		}
-
-		ret = mgmt_eth_data->data[0] & QCA8K_MDIO_MASTER_DATA_MASK;
+		ret = resp_data[0] & QCA8K_MDIO_MASTER_DATA_MASK;
 	} else {
 		kfree_skb(read_skb);
 	}
@@ -724,6 +697,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	/* This is expected to fail sometimes, so don't check return value. */
 	dsa_inband_request(&mgmt_eth_data->inband, clear_skb,
 			   qca8k_mdio_header_fill_seq_num,
+			   NULL, 0,
 			   QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 4c055aef674c2..db89025b4243a 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -394,8 +394,6 @@ enum {
 struct qca8k_mgmt_eth_data {
 	struct dsa_inband inband;
 	struct mutex mutex; /* Enforce one mdio read/write at time */
-	int err;
-	u32 data[4];
 };
 
 struct qca8k_mib_eth_data {
diff --git a/include/net/dsa.h b/include/net/dsa.h
index cdf2487397c2b..50ac6f0aa2e67 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1350,17 +1350,28 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
 
 /* Perform operations on a switch by sending it request in Ethernet
  * frames and expecting a response in a frame.
+ *
+ * resp_lock protects resp and resp_len to ensure they are consistent.
+ * If there is a thread waiting for the response, resp will point to a
+ * buffer to copy the response to. If the thread has given up waiting,
+ * resp will be a NULL pointer.
  */
 struct dsa_inband {
 	struct completion completion;
 	u32 seqno;
 	u32 seqno_mask;
+	int err;
+	spinlock_t resp_lock;
+	void *resp;
+	unsigned int resp_len;
 };
 
 void dsa_inband_init(struct dsa_inband *inband, u32 seqno_mask);
-void dsa_inband_complete(struct dsa_inband *inband);
+void dsa_inband_complete(struct dsa_inband *inband,
+		      void *resp, unsigned int resp_len, int err);
 int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 		       void (*insert_seqno)(struct sk_buff *skb, u32 seqno),
+		       void *resp, unsigned int resp_len,
 		       int timeout_ms);
 int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms);
 u32 dsa_inband_seqno(struct dsa_inband *inband);
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 98a75ee08f011..3e480770854ca 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1837,13 +1837,27 @@ EXPORT_SYMBOL_GPL(dsa_port_simple_hsr_leave);
 void dsa_inband_init(struct dsa_inband *inband, u32 seqno_mask)
 {
 	init_completion(&inband->completion);
+	spin_lock_init(&inband->resp_lock);
 	inband->seqno_mask = seqno_mask;
 	inband->seqno = 0;
 }
 EXPORT_SYMBOL_GPL(dsa_inband_init);
 
-void dsa_inband_complete(struct dsa_inband *inband)
+void dsa_inband_complete(struct dsa_inband *inband,
+			 void *resp, unsigned int resp_len,
+			 int err)
 {
+	inband->err = err;
+
+	if (!err) {
+		spin_lock_bh(&inband->resp_lock);
+		resp_len = min(inband->resp_len, resp_len);
+		if (inband->resp && resp)
+			memcpy(inband->resp, resp, resp_len);
+		spin_unlock_bh(&inband->resp_lock);
+		inband->err = resp_len;
+	}
+
 	complete(&inband->completion);
 }
 EXPORT_SYMBOL_GPL(dsa_inband_complete);
@@ -1878,11 +1892,19 @@ EXPORT_SYMBOL_GPL(dsa_inband_wait_for_completion);
  */
 int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 		       void (*insert_seqno)(struct sk_buff *skb, u32 seqno),
+		       void *resp, unsigned int resp_len,
 		       int timeout_ms)
 {
 	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
 	int ret;
 
+	inband->err = 0;
+
+	spin_lock_bh(&inband->resp_lock);
+	inband->resp = resp;
+	inband->resp_len = resp_len;
+	spin_unlock_bh(&inband->resp_lock);
+
 	if (insert_seqno) {
 		WRITE_ONCE(inband->seqno, inband->seqno + 1);
 		insert_seqno(skb, inband->seqno & inband->seqno_mask);
@@ -1893,9 +1915,16 @@ int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 	dev_queue_xmit(skb);
 
 	ret = wait_for_completion_timeout(&inband->completion, jiffies);
+
+	spin_lock_bh(&inband->resp_lock);
+	inband->resp = NULL;
+	inband->resp_len = 0;
+	spin_unlock_bh(&inband->resp_lock);
+
 	if (ret == 0)
 		return -ETIMEDOUT;
-	return 0;
+
+	return inband->err;
 }
 EXPORT_SYMBOL_GPL(dsa_inband_request);
 

-- 
2.43.0


