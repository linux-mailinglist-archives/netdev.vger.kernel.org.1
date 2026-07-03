Return-Path: <netdev+bounces-304429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /yjfLGJqR2rkXwAAu9opvQ
	(envelope-from <netdev+bounces-304429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:53:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005066FFC4D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:53:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b="zP0xZ24/";
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304429-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304429-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217AB30CCB8E
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2C370ACD;
	Fri,  3 Jul 2026 07:47:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BD36E47A;
	Fri,  3 Jul 2026 07:47:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064841; cv=none; b=dzXf2v/3sKIKPUGnmAWJKx/6MVc3FwqBYPb3By5zvU//JuA8aEH5B0rc/2aR6wSc5u2mWnGBlBXzGUaGQsHSNfifr3UBIWsEjRqX+0OzIzEkhAv6dnQjkLxLTIkGqJGJPQcZUNqFEafWDuLnqvnPE7oZjsYALh/luxJsxH3RGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064841; c=relaxed/simple;
	bh=1/CXYLygFfSGiImNSMUDbUscII26rhZ1NOaf0/xa+5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAE8Mn59VlVQyNO2HmfeKPb5c/YN1YnobPcFNO2ICN6hQG2jaqu3gupEFJZbT9wqfl9LSxQcdu9TqQkxaxTQxOJLrFbv2uE7n8kvdeALr2nUdN8BRKpA2Tf1MQWNXv5d9Yjd0idWtnDuNCwv/ZH6ePuKgXse+FWfX1FajB+NQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=zP0xZ24/; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 4C0C060C0B;
	Fri,  3 Jul 2026 03:47:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064839; bh=8TIjk6Pnyvlv5Fo93rKGV8mOYnXt33g6tJwvmNEhSLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=zP0xZ24/rReJlusdKgeohS3sqQ9jjEGhvCD2YDLSRpSQKjwoJiHuH3IDO8f9KNmoL
	 RFT+wxL8j9/uivPl5n7L4es50wfPlCUQzK6DcbtujYYRjay3vPr2DIk9NxQPlNwMKK
	 NoawHePExS8uW8e2BsnkCAUkZXwNmJeZk2ROR6toBq95vXZ2/JPsMyqOMcRzWqXhh+
	 qriUy5owvaUcnN8w6YO7L5G/XdVbYVUgBub8/D5QtoHZu02tV2Inh++RvkL3Def9AV
	 XUhS0FrXyVYo8lDNTu0TsR/U7WAxh0lmoCFsOBkuyyT0B8FsCpHvtzSz9iRUwS+5Vl
	 Q4dsT7JlsWbNg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:42 +1000
Subject: [PATCH net-next 08/17] net: dsa: mv88e6xxx: Add sanity check of
 received RMU frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-8-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=3899;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=qgr39fMhvgTTz3ETrk/OjFwMcglv2wp3SlYztlqJUvg=;
 b=McqwKq4ncg+wxqc227cpiU6hSHqyPotZFT9Fg5Lvyqmgbolrl1Ke0QFmYfS0s1Xuaq/2Wh64F
 s9tMZBc3sfsCNrJJrJlW4NaZEB/yrQQZtJrhiiG8oPCd01Vyb1mlJSI
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304429-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 005066FFC4D

From: Andrew Lunn <andrew@lunn.ch>

The received RMU frame is expected to be addressed to the MAC address
of the master interface. The sequence number should also match. Two
formats codes are accepted. Add these basic sanity checks, and drop
the frame is they are incorrect.  To aid sequence number checking
introduce the use of the DSA inband helpers and its data structures.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  2 ++
 drivers/net/dsa/mv88e6xxx/chip.h |  1 +
 drivers/net/dsa/mv88e6xxx/rmu.c  | 42 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/rmu.h  |  9 +++++++++
 4 files changed, 54 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index fe0d0eb8f0813..88cc2326ecc0c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7462,6 +7462,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out_g1_atu_prob_irq;
 
+	dsa_inband_init(&chip->rmu_inband, U8_MAX);
+
 	err = mv88e6xxx_register_switch(chip);
 	if (err)
 		goto out_g1_vtu_prob_irq;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 76958b588a908..940ae698659fc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -460,6 +460,7 @@ struct mv88e6xxx_chip {
 
 	/* Remote Management Unit state. */
 	struct net_device *rmu_conduit;
+	struct dsa_inband rmu_inband;
 };
 
 #define TCAM_MATCH_SIZE 96
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index bae0ca6564f7a..49d67d512fb0f 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -53,4 +53,46 @@ void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
 				     struct sk_buff *skb,
 				     u8 seqno)
 {
+	struct mv88e6xxx_rmu_header *rmu_header;
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct net_device *conduit;
+	unsigned char *ethhdr;
+	u8 expected_seqno;
+
+	/* Check received destination MAC is the conduit MAC address */
+	conduit = READ_ONCE(chip->rmu_conduit);
+	if (!conduit)
+		goto drop;
+
+	ethhdr = skb_mac_header(skb);
+	if (!ether_addr_equal(conduit->dev_addr, ethhdr)) {
+		dev_dbg_ratelimited(ds->dev, "RMU: mismatched MAC address for request: rx %pM expecting %pM\n",
+				    ethhdr, conduit->dev_addr);
+		goto drop;
+	}
+
+	expected_seqno = dsa_inband_seqno(&chip->rmu_inband);
+	if (seqno != expected_seqno) {
+		dev_dbg_ratelimited(ds->dev, "RMU: mismatched seqno for request: rx %d expecting %d\n",
+				    seqno, expected_seqno);
+		goto drop;
+	}
+
+	if (skb->len < 4 + sizeof(*rmu_header)) {
+		dev_dbg_ratelimited(ds->dev, "RMU: response too short (%d bytes)\n",
+				    skb->len);
+		dsa_inband_complete(&chip->rmu_inband, NULL, 0, -ETIMEDOUT);
+		goto drop;
+	}
+
+	rmu_header = (struct mv88e6xxx_rmu_header *)(skb->data + 4);
+	if (rmu_header->format != MV88E6XXX_RMU_RESP_FORMAT_1 &&
+	    rmu_header->format != MV88E6XXX_RMU_RESP_FORMAT_2) {
+		dev_dbg_ratelimited(ds->dev, "RMU: invalid format: rx %d\n",
+				    be16_to_cpu(rmu_header->format));
+		goto drop;
+	}
+
+drop:
+	return;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index c60f32480e317..69cd3c2636f3d 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -9,6 +9,15 @@
 #ifndef _MV88E6XXX_RMU_H_
 #define _MV88E6XXX_RMU_H_
 
+#define MV88E6XXX_RMU_RESP_FORMAT_1		htons(0x0001)
+#define MV88E6XXX_RMU_RESP_FORMAT_2		htons(0x0002)
+
+struct mv88e6xxx_rmu_header {
+	__be16 format;
+	__be16 prodnr;
+	__be16 code;
+} __packed;
+
 void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 					const struct net_device *conduit,
 					bool operational);

-- 
2.43.0


