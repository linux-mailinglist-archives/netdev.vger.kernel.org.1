Return-Path: <netdev+bounces-304402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nOJmKZhlR2rCXgAAu9opvQ
	(envelope-from <netdev+bounces-304402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6E6FF959
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=0xGj+Ytm;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304402-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304402-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C33C7305696A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31E369D40;
	Fri,  3 Jul 2026 07:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9D368D7F;
	Fri,  3 Jul 2026 07:30:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063863; cv=none; b=LgBP2f8wwVvdyNwknUk7nBMOgwsfYBnNYnobX2AhE+5xznjjsMtCGhd5Z7G7yaeDiSWRldsjI+WGph5c046f41jwYu/m+DdVHS4aNC2nwrv+db3BXWUy8zIVghFRze8h+piMAlpGfW4dUXOUHQ2G3C/ThCeHAIBKKhheTj/c8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063863; c=relaxed/simple;
	bh=7IzCvZKhRaQ1tfzZMWleKT3BzIxFTtHaP20ZnDDCjuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwTQZkN1VZ7itgca8vGm+Y/mAtXFtTU4Ab8HjgDXkfNOYcT5Spo7EOMpXGs31HJNGMfuRDs5MVnKhlR8FKzKeHk+jvk2QwLIWexvnIxNVOqGg7m3k3J03/pUr+g8qxB+MkO/Ei5kIpTZLM5O13MmlRo1VRiWrHcyOCUsNoqjRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=0xGj+Ytm; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 85E7B60C1E;
	Fri,  3 Jul 2026 03:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063859; bh=E9/34/2dakZpafmdHYwrjiSTCpfibWXLDSM4VO7yCSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0xGj+YtmKxzcC1nP4Dd1pkRsydrnQy7DO/nm0hdzywFf5zBIfzFKeOoHgLrElXVwB
	 6K6R12VQh6pH8kr6h0ByUtz5ztSvBvl5L2SIECItmcX7I+mFMLzHzFgC5Xgn9zboPz
	 tZXWFzJRQgyZoVsM6/ol+RjQSyltPQLd+jXdJP2QqAgU5P96vC09Rsnu4xHA5NfhDc
	 5dBQNPQP8BLJF2sI+BVvGUl97IFcN1UmNR2KUfOobVe3tomKgSnbzPUX6sPuW0X725
	 Qh6NR51lo/CtL4Fe/4+A9iolWON9/LvS5KO3xBDDKOHU5FoSzQfzhbdv1t7FExMaBr
	 7nNwfAKN2iH4A==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:24 +1000
Subject: [PATCH net-next 05/12] net: dsa: qca8k: Move request sequence
 number handling into core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-5-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=7538;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=UkBkklUMplRFlOcjd6gKayQMemqa1w/l+6/UA3HMpp4=;
 b=/MSa+L9CmeML6hbiPkKtb2qq6Mm9ssHYdzvI+OuhyA97BEvRmUC00xe5fnWXvZYlAWO2P6wVZ
 8pueWKnVp6JBzhS+0kaSVjIQ9WYGGdL1PIHMDN40bjJq1I/dB1mRWRa
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
	TAGGED_FROM(0.00)[bounces-304402-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0AA6E6FF959

From: Andrew Lunn <andrew@lunn.ch>

Each request/reply frame is likely to have a sequence number so that
request and the reply can be matched together. Move this sequence
number into the inband structure. The driver must provide a helper to
insert the sequence number into the skb, and the core will perform the
increment.

To allow different devices to have different size sequence numbers, a
mask is provided. This can be used for example to reduce the u32
sequence number down to a u8.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 29 +++++++++--------------------
 drivers/net/dsa/qca/qca8k.h      |  1 -
 include/net/dsa.h                |  6 +++++-
 net/dsa/dsa.c                    | 16 +++++++++++++++-
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 3b3fe96016176..fc5070402188e 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -186,7 +186,8 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 	len *= sizeof(u16);
 
 	/* Make sure the seq match the requested packet. If not, drop. */
-	if (get_unaligned_le32(&mgmt_ethhdr->seq) != mgmt_eth_data->seq)
+	if (get_unaligned_le32(&mgmt_ethhdr->seq) !=
+	    dsa_inband_seqno(&mgmt_eth_data->inband))
 		return;
 
 	if (cmd == MDIO_READ) {
@@ -332,12 +333,10 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = priv->mgmt_conduit;
 
-	/* Increment seq_num and set it in the mdio pkt */
-	mgmt_eth_data->seq++;
-	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
 	*val = mgmt_eth_data->data[0];
@@ -380,12 +379,10 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	skb->dev = priv->mgmt_conduit;
 
-	/* Increment seq_num and set it in the mdio pkt */
-	mgmt_eth_data->seq++;
-	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
@@ -586,12 +583,10 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 	if (!skb)
 		return -ENOMEM;
 
-	/* Increment seq_num and set it in the copy pkt */
-	mgmt_eth_data->seq++;
-	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, skb,
+				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
@@ -684,12 +679,10 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	clear_skb->dev = mgmt_conduit;
 	write_skb->dev = mgmt_conduit;
 
-	/* Increment seq_num and set it in the write pkt */
-	mgmt_eth_data->seq++;
-	qca8k_mdio_header_fill_seq_num(write_skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
 	ret = dsa_inband_request(&mgmt_eth_data->inband, write_skb,
+				 qca8k_mdio_header_fill_seq_num,
 				 QCA8K_ETHERNET_TIMEOUT);
 
 	ack = mgmt_eth_data->ack;
@@ -716,12 +709,10 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	}
 
 	if (read) {
-		/* Increment seq_num and set it in the read pkt */
-		mgmt_eth_data->seq++;
-		qca8k_mdio_header_fill_seq_num(read_skb, mgmt_eth_data->seq);
 		mgmt_eth_data->ack = false;
 
 		ret = dsa_inband_request(&mgmt_eth_data->inband, read_skb,
+					 qca8k_mdio_header_fill_seq_num,
 					 QCA8K_ETHERNET_TIMEOUT);
 
 		ack = mgmt_eth_data->ack;
@@ -739,13 +730,11 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 		kfree_skb(read_skb);
 	}
 exit:
-	/* Increment seq_num and set it in the clear pkt */
-	mgmt_eth_data->seq++;
-	qca8k_mdio_header_fill_seq_num(clear_skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
 	/* This is expected to fail sometimes, so don't check return value. */
 	dsa_inband_request(&mgmt_eth_data->inband, clear_skb,
+			   qca8k_mdio_header_fill_seq_num,
 			   QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
@@ -2080,7 +2069,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 		return -ENOMEM;
 
 	mutex_init(&priv->mgmt_eth_data.mutex);
-	dsa_inband_init(&priv->mgmt_eth_data.inband);
+	dsa_inband_init(&priv->mgmt_eth_data.inband, U32_MAX);
 
 	mutex_init(&priv->mib_eth_data.mutex);
 	init_completion(&priv->mib_eth_data.rw_done);
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 938f2c9ff0cac..1054ba1c7e590 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -395,7 +395,6 @@ struct qca8k_mgmt_eth_data {
 	struct dsa_inband inband;
 	struct mutex mutex; /* Enforce one mdio read/write at time */
 	bool ack;
-	u32 seq;
 	u32 data[4];
 };
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6b5aeb99ec3bb..cdf2487397c2b 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1353,13 +1353,17 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
  */
 struct dsa_inband {
 	struct completion completion;
+	u32 seqno;
+	u32 seqno_mask;
 };
 
-void dsa_inband_init(struct dsa_inband *inband);
+void dsa_inband_init(struct dsa_inband *inband, u32 seqno_mask);
 void dsa_inband_complete(struct dsa_inband *inband);
 int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
+		       void (*insert_seqno)(struct sk_buff *skb, u32 seqno),
 		       int timeout_ms);
 int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms);
+u32 dsa_inband_seqno(struct dsa_inband *inband);
 
 /* Keep inline for faster access in hot path */
 static inline bool netdev_uses_dsa(const struct net_device *dev)
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index f6ae11b06b4ab..98a75ee08f011 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1834,9 +1834,11 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL_GPL(dsa_port_simple_hsr_leave);
 
-void dsa_inband_init(struct dsa_inband *inband)
+void dsa_inband_init(struct dsa_inband *inband, u32 seqno_mask)
 {
 	init_completion(&inband->completion);
+	inband->seqno_mask = seqno_mask;
+	inband->seqno = 0;
 }
 EXPORT_SYMBOL_GPL(dsa_inband_init);
 
@@ -1875,11 +1877,17 @@ EXPORT_SYMBOL_GPL(dsa_inband_wait_for_completion);
  * be reinitialised before the skb is queued, to avoid races.
  */
 int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
+		       void (*insert_seqno)(struct sk_buff *skb, u32 seqno),
 		       int timeout_ms)
 {
 	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
 	int ret;
 
+	if (insert_seqno) {
+		WRITE_ONCE(inband->seqno, inband->seqno + 1);
+		insert_seqno(skb, inband->seqno & inband->seqno_mask);
+	}
+
 	reinit_completion(&inband->completion);
 
 	dev_queue_xmit(skb);
@@ -1891,6 +1899,12 @@ int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(dsa_inband_request);
 
+u32 dsa_inband_seqno(struct dsa_inband *inband)
+{
+	return READ_ONCE(inband->seqno) & inband->seqno_mask;
+}
+EXPORT_SYMBOL_GPL(dsa_inband_seqno);
+
 static const struct dsa_stubs __dsa_stubs = {
 	.conduit_hwtstamp_validate = __dsa_conduit_hwtstamp_validate,
 };

-- 
2.43.0


