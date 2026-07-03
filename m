Return-Path: <netdev+bounces-304399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2dgAD0JlR2qhXgAAu9opvQ
	(envelope-from <netdev+bounces-304399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:31:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F86FF8E8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:31:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=1KDu1o9l;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304399-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304399-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01F7C3033ACC
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1772369991;
	Fri,  3 Jul 2026 07:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464C368D7F;
	Fri,  3 Jul 2026 07:30:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063846; cv=none; b=Qg1tkhhWJk1o0+HtElDmWWyggEFw5EZbeH++E/j/jYklXf4HMXmfPqT2RFk3JP997fgnTGXBBHntlwzRRtSndba8ZnbWGlG2GJhO3uPlOAZ0VVy/7DNCZvijmUsvJt3ebd70vLEYJs+vmC3GKoKMhSwzP2VJ7+Gwz9z7bCnfLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063846; c=relaxed/simple;
	bh=UTOQ9J4BiN1s+IOvb1LvCQoaAWLpGxsQ0N8FjkpSWWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlDCQQmQQWgfXY8V25Z7uOK3giN/iobFcX9RwJoKsC3lQAxo6BDySy3ZbmbRbAxTBpJ+fg6JFG9d7mX43PfZlHDtEoVuuXGtMplZ+rOSWDdBsVhBg5VOCWCM3XV7r8GYVXB6+HDD1ecughUxDRPsvM5nivC1d5IG1HbOqB7bqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=1KDu1o9l; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 085C460C1E;
	Fri,  3 Jul 2026 03:30:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063843; bh=t3wtTvvgLKf9P/izHmVyOxSLBI4mVvaUGQe2kUv8vRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=1KDu1o9leBVNYOQcnd7g8A2BYDyZKFoXtRDbO6DaIQjECh9viAVdbUZslA6uUg2LT
	 JdM0x8+h2lqv/OVNUeDHYI5hUtxz74SMfrf+5vrrjyXdpuvZ+cDubqcXyE8wO9yLV7
	 zGFSH9i++FIbsJ3J8WWc57kYC7dnzYgoyF6x0dQ2R8mudyrIVmPvnYL2To6g5qx3/u
	 1N2Okfw/ivtoqh41NfW487LzDfEgfN0zMNBiEaxG4KO3A7QkJW689iFaI08WuZyv/Z
	 riP5Hp8A6BQ0ui3rzPpLia2t8CffxmD3Pg4eDgen//CdZpm9eTAbljn7jb+h4ZOWNA
	 GOG0URJQG1lqw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:21 +1000
Subject: [PATCH net-next 02/12] net: dsa: qca8K: Move queuing for request
 frame into the core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-2-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=5912;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=s08gFyzfWv+OaSgCU/RrUyKVfWplBykfnc91IW4FjBE=;
 b=P6HzPqjdrXG3GclBS6TnyPQ1yFkgc76MTgOnxW9JDoGNFn2FyfuJ/PFQ7WJ1b+PL4zYs1M2tD
 o9QN6DzhGzBDfA9XklxhDOxxknM5/j6Z1SMIkwomGDz7YYxUMXsIVRs
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304399-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:dkim,padl.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C06F86FF8E8

From: Andrew Lunn <andrew@lunn.ch>

Combine the queuing of the request and waiting for the completion into
one core helper. Add the function dsa_rmu_request() to perform this.

Access to statistics is not a strict request/reply, so the
dsa_rmu_wait_for_completion needs to be kept.

It is also no possible to combine dsa_rmu_request() and
dsa_rmu_wait_for_completion() since we need to avoid the race of
sending the request, receiving a reply, and the completion has not
been reinitialised because the schedule at decided to do other things.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 32 ++++++++++----------------------
 include/net/dsa.h                |  2 ++
 net/dsa/dsa.c                    | 31 +++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index fe6fb69b6f92f..4da6094552f1e 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -337,10 +337,8 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
-	dev_queue_xmit(skb);
-
-	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
-					     QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+				 QCA8K_ETHERNET_TIMEOUT);
 
 	*val = mgmt_eth_data->data[0];
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
@@ -387,10 +385,8 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
-	dev_queue_xmit(skb);
-
-	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
-					     QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+				 QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
@@ -595,10 +591,8 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
-	dev_queue_xmit(skb);
-
-	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
-					     QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+				 QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
@@ -695,10 +689,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	qca8k_mdio_header_fill_seq_num(write_skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
-	dev_queue_xmit(write_skb);
-
-	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
-					     QCA8K_ETHERNET_TIMEOUT);
+	ret = dsa_inband_request(&mgmt_eth_data->inband, write_skb,
+				 QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
 
@@ -730,10 +722,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		qca8k_mdio_header_fill_seq_num(read_skb, mgmt_eth_data->seq);
 		mgmt_eth_data->ack = false;
 
-		dev_queue_xmit(read_skb);
-
-		ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
-						     QCA8K_ETHERNET_TIMEOUT);
+		ret = dsa_inband_request(&mgmt_eth_data->inband, read_skb,
+					 QCA8K_ETHERNET_TIMEOUT);
 
 		ack = mgmt_eth_data->ack;
 
@@ -757,8 +747,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	qca8k_mdio_header_fill_seq_num(clear_skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
-	dev_queue_xmit(clear_skb);
-
 	dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
 				       QCA8K_ETHERNET_TIMEOUT);
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 9b0c109b3058a..6b5aeb99ec3bb 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1357,6 +1357,8 @@ struct dsa_inband {
 
 void dsa_inband_init(struct dsa_inband *inband);
 void dsa_inband_complete(struct dsa_inband *inband);
+int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
+		       int timeout_ms);
 int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms);
 
 /* Keep inline for faster access in hot path */
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index dc4e5cdb2f5b2..534e391fac7b5 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1856,6 +1856,37 @@ int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms)
 }
 EXPORT_SYMBOL_GPL(dsa_inband_wait_for_completion);
 
+/* dsa_inband_request - send an inband request frame and wait for the reply.
+ * @inband: inband state for the switch
+ * @skb: request frame; ownership is transferred to this function
+ * @insert_seqno: optional callback to stamp the sequence number into @skb
+ * @resp: buffer to receive the reply payload, or NULL if none is expected
+ * @resp_len: size of @resp in bytes
+ * @timeout_ms: how long to wait for the reply, in milliseconds
+ *
+ * Serialise against other inband operations, transmit @skb and wait for the
+ * matching reply handed back via dsa_inband_complete().
+ *
+ * Return the number of response bytes copied into @resp (0 when no response
+ * is expected) on success, or a negative errno (-EOPNOTSUPP if the conduit
+ * is down, -ETIMEDOUT if no reply arrived, or an error from the completer).
+ *
+ * Cannot use dsa_inband_wait_for_completion() since the completion needs to
+ * be reinitialised before the skb is queued, to avoid races.
+ */
+int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
+		       int timeout_ms)
+{
+	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
+
+	reinit_completion(&inband->completion);
+
+	dev_queue_xmit(skb);
+
+	return wait_for_completion_timeout(&inband->completion, jiffies);
+}
+EXPORT_SYMBOL_GPL(dsa_inband_request);
+
 static const struct dsa_stubs __dsa_stubs = {
 	.conduit_hwtstamp_validate = __dsa_conduit_hwtstamp_validate,
 };

-- 
2.43.0


