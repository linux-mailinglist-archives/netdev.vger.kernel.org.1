Return-Path: <netdev+bounces-304398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3h+gFzJlR2qfXgAAu9opvQ
	(envelope-from <netdev+bounces-304398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4066FF8DD
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=NDLFAvMc;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304398-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304398-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C1D7302514E
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090343403EF;
	Fri,  3 Jul 2026 07:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C3342515;
	Fri,  3 Jul 2026 07:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063842; cv=none; b=pi+NJdgaV75t1Di4XZyoN5iQH2DmGmQPW716Ithv2LBBuXVDtYbbnbiHK8eit6PLZeMzt83F6cq+vBk0LAbVaX9lWGiPRY47YoSS+tCExLi7IbOCLhXMmSuvFuPPvx0Fg9wCkYXzpgjzUJY7YVVblqiteOWHv8VMldi90BKcQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063842; c=relaxed/simple;
	bh=584RIdVK66emgTew+NPFB3g8/ZqQp+hqdJTWD1Iniek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy4aU5IiXoPzqY5GKOaQwCdDzyrgY+5//hd1armXz+yPsVr0Eaj3KPj5cqryBzkuZcTx8GjZs5UU7f1PJlq78wID84YqRj6RqST5qozBmFX1wG7hhcqVU5hbspWvaabuzjxJifqGMUyhXYA67KG8M5rSWN1dhiACWifVnLKDS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=NDLFAvMc; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D25D560C0B;
	Fri,  3 Jul 2026 03:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063838; bh=w14dpiyHqFvHM8ZGnw4AM8sVo1w5E90WyfjZPkC4/Eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NDLFAvMcnwWYMwzkB7Uo//RH70gB8hF3r292mRFtsYZ6r+rJuc+hpU/IjgnH7Cr39
	 y85sUgHqKqdHEKgnYJ16RdVJEvTzYAMH61wXtzYnduBlSqjvuKTyxGxlbX7IpUOmfs
	 10guHXeAC2Kzg9vwgdvLGts0sKIRg/j8UnoIFcNWsQNLX5wusF0Vp0sZEoxNpCt6mS
	 7ic2WTaCGMzkMh0vC//rQXtgA8wB9pZ+llQev+J+ZJQu6QjsQcOyGoDynlCBkiqPjn
	 fNRc5BUzBl32qESmh+wFdMkdn46mF0xbfJppIuAf5lS1G+p+A+GHcJxOcJeIVm6Jz+
	 2YYrdAiuVObyg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:20 +1000
Subject: [PATCH net-next 01/12] net: dsa: qca8k: Move register access
 completion into DSA core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-1-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=8911;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=wxh3rVieSL3oCuk6yi6sMOglmWe7YWS7VIdi7MEixpY=;
 b=WOmouhgEDtOll7MMFVK5W5c7xEP0nyJwMQ5c/iPV+a6PWOINfjH/eqsLkjC0/Dh5O6ED1kcEQ
 Qn2mUAzJcnKCzV9RNCL00n528kwFEWsTKG9dV4edQRmhoZwTr8VafyI
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
	TAGGED_FROM(0.00)[bounces-304398-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email,padl.com:from_mime,padl.com:dkim,padl.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF4066FF8DD

From: Andrew Lunn <andrew@lunn.ch>

When performing operations on a remote switch using Ethernet frames, a
completion is used between the sender of the request and the code
which receives the reply.

Move this completion into the DSA core, simplifying the driver.  The
initialisation and reinitialisation of the completion is now performed
in the core. Also, the conversion of milliseconds to jiffies is also
in the core.

The MIB access via left untouched because it is not a simple
request/reply protocol.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 43 +++++++++++++++-------------------------
 drivers/net/dsa/qca/qca8k.h      |  4 ++--
 include/net/dsa.h                | 12 +++++++++++
 net/dsa/dsa.c                    | 22 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b8623..fe6fb69b6f92f 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -212,7 +212,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 		}
 	}
 
-	complete(&mgmt_eth_data->rw_done);
+	dsa_inband_complete(&mgmt_eth_data->inband);
 }
 
 static struct sk_buff *qca8k_alloc_mdio_header(enum mdio_cmd cmd, u32 reg, u32 *val,
@@ -332,8 +332,6 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = priv->mgmt_conduit;
 
-	reinit_completion(&mgmt_eth_data->rw_done);
-
 	/* Increment seq_num and set it in the mdio pkt */
 	mgmt_eth_data->seq++;
 	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
@@ -341,8 +339,8 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	dev_queue_xmit(skb);
 
-	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-					  QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
+					     QCA8K_ETHERNET_TIMEOUT);
 
 	*val = mgmt_eth_data->data[0];
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
@@ -384,8 +382,6 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = priv->mgmt_conduit;
 
-	reinit_completion(&mgmt_eth_data->rw_done);
-
 	/* Increment seq_num and set it in the mdio pkt */
 	mgmt_eth_data->seq++;
 	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
@@ -393,8 +389,8 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	dev_queue_xmit(skb);
 
-	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-					  QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
+					     QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
@@ -594,8 +590,6 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 	if (!skb)
 		return -ENOMEM;
 
-	reinit_completion(&mgmt_eth_data->rw_done);
-
 	/* Increment seq_num and set it in the copy pkt */
 	mgmt_eth_data->seq++;
 	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
@@ -603,8 +597,8 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 
 	dev_queue_xmit(skb);
 
-	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-					  QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
+					     QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
@@ -696,8 +690,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	clear_skb->dev = mgmt_conduit;
 	write_skb->dev = mgmt_conduit;
 
-	reinit_completion(&mgmt_eth_data->rw_done);
-
 	/* Increment seq_num and set it in the write pkt */
 	mgmt_eth_data->seq++;
 	qca8k_mdio_header_fill_seq_num(write_skb, mgmt_eth_data->seq);
@@ -705,8 +697,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 
 	dev_queue_xmit(write_skb);
 
-	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-					  QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
+					     QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
@@ -733,8 +725,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	}
 
 	if (read) {
-		reinit_completion(&mgmt_eth_data->rw_done);
-
 		/* Increment seq_num and set it in the read pkt */
 		mgmt_eth_data->seq++;
 		qca8k_mdio_header_fill_seq_num(read_skb, mgmt_eth_data->seq);
@@ -742,8 +732,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 
 		dev_queue_xmit(read_skb);
 
-		ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-						  QCA8K_ETHERNET_TIMEOUT);
+		ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
+						     QCA8K_ETHERNET_TIMEOUT);
 
 		ack = mgmt_eth_data->ack;
 
@@ -762,8 +752,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		kfree_skb(read_skb);
 	}
 exit:
-	reinit_completion(&mgmt_eth_data->rw_done);
-
 	/* Increment seq_num and set it in the clear pkt */
 	mgmt_eth_data->seq++;
 	qca8k_mdio_header_fill_seq_num(clear_skb, mgmt_eth_data->seq);
@@ -771,8 +759,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 
 	dev_queue_xmit(clear_skb);
 
-	wait_for_completion_timeout(&mgmt_eth_data->rw_done,
-				    QCA8K_ETHERNET_TIMEOUT);
+	dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
+				       QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
 	mutex_unlock(&priv->bus->mdio_lock);
@@ -1728,7 +1716,8 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 	if (ret)
 		goto exit;
 
-	ret = wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);
+	ret = wait_for_completion_timeout(&mib_eth_data->rw_done,
+					  msecs_to_jiffies(QCA8K_ETHERNET_TIMEOUT));
 
 exit:
 	mutex_unlock(&mib_eth_data->mutex);
@@ -2105,7 +2094,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 		return -ENOMEM;
 
 	mutex_init(&priv->mgmt_eth_data.mutex);
-	init_completion(&priv->mgmt_eth_data.rw_done);
+	dsa_inband_init(&priv->mgmt_eth_data.inband);
 
 	mutex_init(&priv->mib_eth_data.mutex);
 	init_completion(&priv->mib_eth_data.rw_done);
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 9563388930325..938f2c9ff0cac 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -16,7 +16,7 @@
 
 #define QCA8K_ETHERNET_MDIO_PRIORITY			7
 #define QCA8K_ETHERNET_PHY_PRIORITY			6
-#define QCA8K_ETHERNET_TIMEOUT				msecs_to_jiffies(5)
+#define QCA8K_ETHERNET_TIMEOUT				5
 
 #define QCA8K_NUM_PORTS					7
 #define QCA8K_NUM_CPU_PORTS				2
@@ -392,7 +392,7 @@ enum {
 };
 
 struct qca8k_mgmt_eth_data {
-	struct completion rw_done;
+	struct dsa_inband inband;
 	struct mutex mutex; /* Enforce one mdio read/write at time */
 	bool ack;
 	u32 seq;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc102..9b0c109b3058a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -7,6 +7,7 @@
 #ifndef __LINUX_NET_DSA_H
 #define __LINUX_NET_DSA_H
 
+#include <linux/completion.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/list.h>
@@ -1347,6 +1348,17 @@ int dsa_port_simple_hsr_join(struct dsa_switch *ds, int port,
 int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
 			      struct net_device *hsr);
 
+/* Perform operations on a switch by sending it request in Ethernet
+ * frames and expecting a response in a frame.
+ */
+struct dsa_inband {
+	struct completion completion;
+};
+
+void dsa_inband_init(struct dsa_inband *inband);
+void dsa_inband_complete(struct dsa_inband *inband);
+int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms);
+
 /* Keep inline for faster access in hot path */
 static inline bool netdev_uses_dsa(const struct net_device *dev)
 {
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 9cb732f6b1e3e..dc4e5cdb2f5b2 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1834,6 +1834,28 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(dsa_port_simple_hsr_leave);
 
+void dsa_inband_init(struct dsa_inband *inband)
+{
+	init_completion(&inband->completion);
+}
+EXPORT_SYMBOL_GPL(dsa_inband_init);
+
+void dsa_inband_complete(struct dsa_inband *inband)
+{
+	complete(&inband->completion);
+}
+EXPORT_SYMBOL_GPL(dsa_inband_complete);
+
+int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms)
+{
+	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
+
+	reinit_completion(&inband->completion);
+
+	return wait_for_completion_timeout(&inband->completion, jiffies);
+}
+EXPORT_SYMBOL_GPL(dsa_inband_wait_for_completion);
+
 static const struct dsa_stubs __dsa_stubs = {
 	.conduit_hwtstamp_validate = __dsa_conduit_hwtstamp_validate,
 };

-- 
2.43.0


