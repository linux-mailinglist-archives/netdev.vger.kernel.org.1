Return-Path: <netdev+bounces-304430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q36yMIdqR2rrXwAAu9opvQ
	(envelope-from <netdev+bounces-304430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2166FFC60
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:53:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=TRB9rMSU;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304430-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304430-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7022E30D6EBF
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E4C36EAA4;
	Fri,  3 Jul 2026 07:47:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382C3546FF;
	Fri,  3 Jul 2026 07:47:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064846; cv=none; b=O/MHOp7Qj0JSGPxLdT6rg7KsDnCN9t20bFN7I8cr18DtMCdGY/VSu2eDOFyYUmmS9+vwdrDmsSm4J4QoxaOUIAWHWf4+Cdn169YnbEDmSzY7NAhIQtyas/i+bbxK5c6HyO20XJlc70Peb82f8Vc3MF4WMlgix9y+EY2VsIOEEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064846; c=relaxed/simple;
	bh=rHqweq0CwiyzOhkY2treR0Z+SiSzYiKHhfoy27S2zPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8IyaJiJ1cyKpHfkEjttUMP/wRnLz/bjp8tFSPxJecWNk6TMeYKGrK9Y6mRqOBoyFE1ID9lLSZ4MGy4fr0HWBIRU/wNGo6tgDS2EFKFdjAG1oYLSIMudTyrvV4gQVrcPUveAohUdAaSynwqzGNYd+6U8Pwk4xm5m1OdR+dv+GOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=TRB9rMSU; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D316960C04;
	Fri,  3 Jul 2026 03:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064843; bh=4q3DokfFU+uqx8Lm1URlkC6fhCe/+EG7Om2eYq7Sk2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TRB9rMSU7jvkCYpXez62QYTqNV23PFLG5ygSeVDz2sh0aiNMi3s2+0KMBcmABWWUj
	 o+szN9rKYb4hx0tzSAqKFf+IUgWH3IQI6t1xAOPbL2AAVu4oO0B9jk8ZJWqSwNzQZa
	 2z1rca0FkXPHH3aEdLcHD1iVBffOlQd9CbvJwQsLHa+XlJG56EYuRmW3kAPjFkrlzf
	 rD0rbI91PJ7uZyqXbVx+MSGcYMwsSIo60V934OYfLx/asD+xjEJjwLO0SyGleYraMa
	 TqpvGpEJrXyWky1YKr795IsXXxvXtM5KlN487HZ9Ac8q6fOY6pxL24IFKcojy3rdee
	 rZBREwVEb1ktg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:43 +1000
Subject: [PATCH net-next 09/17] net: dsa: mv88e6xxx: Get Product ID when
 enabling RMU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-9-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=8397;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=DXdCJ+i+DZyk+zxSfsDPsCvmwMxH0gP6tyJZMinCU3o=;
 b=asyTOEZeWKByc5ZKIOKqdGnhbcABPq3xGI4pfuuG/3HDmvlwZt1S3TsSuDlenDHXNNtdZg5jj
 4GYgOx5RotIA/4TTDWiuLASTKb1e6P8U8Sz+01EWypbbSmeK1y43z89
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
	TAGGED_FROM(0.00)[bounces-304430-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E2166FFC60

From: Andrew Lunn <andrew@lunn.ch>

When the RMU is enabled, it is recommended to get the product ID,
which identifies the switch. This is used as a test that communication
with the switch actually works and the RMU can be used. If successful,
mark the RMU usable.

This completes the general infrastructure to send a request and
process the response.

Co-developed: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  10 +++
 drivers/net/dsa/mv88e6xxx/rmu.c  | 151 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/rmu.h  |  11 +++
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 940ae698659fc..07300c25cbd36 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -346,6 +346,15 @@ struct mv88e6xxx_tcam {
 	struct list_head entries;
 };
 
+enum mv88e6xxx_rmu_state {
+	MV88E6XXX_RMU_DISABLED = 0,
+	MV88E6XXX_RMU_ENABLED = 1,
+	/* Reserved: a future RMU-only mode (e.g. MV88E6XXX_RMU_ONLY_ENABLED)
+	 * may be added here to indicate a switch operating purely via RMU
+	 * without an MDIO bus.
+	 */
+};
+
 struct mv88e6xxx_chip {
 	const struct mv88e6xxx_info *info;
 
@@ -461,6 +470,7 @@ struct mv88e6xxx_chip {
 	/* Remote Management Unit state. */
 	struct net_device *rmu_conduit;
 	struct dsa_inband rmu_inband;
+	enum mv88e6xxx_rmu_state rmu_state;
 };
 
 #define TCAM_MATCH_SIZE 96
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.c b/drivers/net/dsa/mv88e6xxx/rmu.c
index 49d67d512fb0f..65e6bcf4ca938 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.c
+++ b/drivers/net/dsa/mv88e6xxx/rmu.c
@@ -6,11 +6,143 @@
  *
  */
 
+#include <linux/dsa/mv88e6xxx.h>
 #include <net/dsa.h>
 #include "chip.h"
 #include "global1.h"
 #include "rmu.h"
 
+static const u8 mv88e6xxx_rmu_dest_addr[ETH_ALEN] = {
+	0x01, 0x50, 0x43, 0x00, 0x00, 0x00
+};
+
+static void mv88e6xxx_rmu_create_l2(struct dsa_switch *ds,
+				    struct net_device *conduit,
+				    struct sk_buff *skb,
+				    bool edsa)
+{
+	struct dsa_tagger_data *tagger_data = ds->tagger_data;
+	struct ethhdr *eth;
+	u8 *header;
+
+	/* Create RMU L2 header. */
+	header = skb_push(skb, 2);
+	/* Two bytes of EtherType, which is ignored by the switch */
+	header[0] = 0;
+	header[1] = 0;
+
+	/* Ask tagger to add {E}DSA header */
+	tagger_data->rmu_reg2frame(ds, skb);
+
+	/* Insert RMU MAC destination address */
+	eth = skb_push(skb, ETH_ALEN * 2);
+	memcpy(eth->h_dest, mv88e6xxx_rmu_dest_addr, ETH_ALEN);
+	ether_addr_copy(eth->h_source, conduit->dev_addr);
+	skb_reset_network_header(skb);
+}
+
+static void mv88e6xxx_rmu_fill_seqno(struct sk_buff *skb, u32 seqno, int offset)
+{
+	u8 *dsa_header = skb->data + offset;
+
+	dsa_header[3] = seqno;
+}
+
+/* 2 MAC address, 2 byte Ethertype, 2 bytes padding, to DSA header */
+static void mv88e6xxx_rmu_fill_seqno_edsa(struct sk_buff *skb, u32 seqno)
+{
+	mv88e6xxx_rmu_fill_seqno(skb, seqno, ETH_ALEN * 2 + 2 + 2);
+}
+
+/* 2 MAC address, to DSA header */
+static void mv88e6xxx_rmu_fill_seqno_dsa(struct sk_buff *skb, u32 seqno)
+{
+	mv88e6xxx_rmu_fill_seqno(skb, seqno, ETH_ALEN * 2);
+}
+
+static int mv88e6xxx_rmu_request(struct mv88e6xxx_chip *chip,
+				 const void *req, int req_len,
+				 void *resp, unsigned int resp_len,
+				 int timeout_ms)
+{
+	struct net_device *conduit;
+	struct sk_buff *skb;
+	unsigned char *data;
+	bool edsa;
+
+	/* Capture conduit once: it can be cleared concurrently when the
+	 * conduit goes down (e.g. during reboot). Also guard against the
+	 * conduit being torn down out from under us, in which case its
+	 * dev_addr may already have been released.
+	 */
+	conduit = READ_ONCE(chip->rmu_conduit);
+	if (unlikely(!conduit || !conduit->dev_addr)) {
+		dev_err_ratelimited(chip->dev, "RMU: conduit device unavailable");
+		return -EINVAL;
+	}
+
+	skb = dev_alloc_skb(req_len + EDSA_HLEN + 2 * ETH_ALEN + 2);
+	if (!skb)
+		return -ENOMEM;
+
+	/* Insert RMU request message */
+	data = skb_put(skb, req_len);
+	memcpy(data, req, req_len);
+
+	edsa = chip->tag_protocol == DSA_TAG_PROTO_EDSA;
+
+	if (!chip->ds->tagger_data) {
+		kfree_skb(skb);
+		return -EOPNOTSUPP; /* can happen on teardown */
+	}
+
+	mv88e6xxx_rmu_create_l2(chip->ds, conduit, skb, edsa);
+	skb->dev = conduit;
+
+	return dsa_inband_request(&chip->rmu_inband, skb,
+				  (edsa ? mv88e6xxx_rmu_fill_seqno_edsa :
+				   mv88e6xxx_rmu_fill_seqno_dsa),
+				  resp, resp_len, timeout_ms);
+}
+
+static int mv88e6xxx_rmu_get_id(struct mv88e6xxx_chip *chip)
+{
+	const __be16 req[4] = {
+		MV88E6XXX_RMU_REQ_FORMAT_GET_ID,
+		MV88E6XXX_RMU_REQ_PAD,
+		MV88E6XXX_RMU_REQ_CODE_GET_ID,
+		MV88E6XXX_RMU_REQ_DATA};
+	struct mv88e6xxx_rmu_header resp;
+	int resp_len;
+	int ret = -1;
+
+	resp_len = sizeof(resp);
+	ret = mv88e6xxx_rmu_request(chip, req, sizeof(req),
+				    &resp, resp_len,
+				    MV88E6XXX_RMU_REQUEST_TIMEOUT_MS);
+	if (ret < 0) {
+		dev_dbg(chip->dev, "RMU: error for command GET_ID %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	if (ret < resp_len) {
+		dev_err(chip->dev, "RMU: GET_ID returned wrong length: rx %d expecting %d\n",
+			ret, resp_len);
+		return -EPROTO;
+	}
+
+	if (resp.code != MV88E6XXX_RMU_RESP_CODE_GOT_ID) {
+		dev_dbg(chip->dev, "RMU: GET_ID returned wrong code %d\n",
+			be16_to_cpu(resp.code));
+		return -EPROTO;
+	}
+
+	dev_dbg(chip->dev, "RMU: product ID %4x\n", be16_to_cpu(resp.prodnr));
+
+	return 0;
+}
+
 void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 					const struct net_device *conduit,
 					bool operational)
@@ -37,11 +169,22 @@ void mv88e6xxx_rmu_conduit_state_change(struct dsa_switch *ds,
 
 		WRITE_ONCE(chip->rmu_conduit, (struct net_device *)conduit);
 
-		dev_dbg(chip->dev, "RMU: Enabled on port %d", port);
+		/* Get the device ID to prove that the RMU works */
+		ret = mv88e6xxx_rmu_get_id(chip);
+		if (ret < 0) {
+			dev_err(chip->dev, "RMU: initialization check failed %pe",
+				ERR_PTR(ret));
+			goto out;
+		}
+		chip->rmu_state = MV88E6XXX_RMU_ENABLED;
+
+		dev_info(chip->dev, "RMU: enabled on port %d via conduit device %s",
+			 port, chip->rmu_conduit->name);
 	} else {
 		if (chip->info->ops->rmu_disable)
 			chip->info->ops->rmu_disable(chip);
 
+		chip->rmu_state = MV88E6XXX_RMU_DISABLED;
 		WRITE_ONCE(chip->rmu_conduit, NULL);
 	}
 
@@ -58,6 +201,8 @@ void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
 	struct net_device *conduit;
 	unsigned char *ethhdr;
 	u8 expected_seqno;
+	int resp_len;
+	int err = 0;
 
 	/* Check received destination MAC is the conduit MAC address */
 	conduit = READ_ONCE(chip->rmu_conduit);
@@ -86,13 +231,15 @@ void mv88e6xxx_rmu_frame2reg_handler(struct dsa_switch *ds,
 	}
 
 	rmu_header = (struct mv88e6xxx_rmu_header *)(skb->data + 4);
+	resp_len = skb->len - 4;
 	if (rmu_header->format != MV88E6XXX_RMU_RESP_FORMAT_1 &&
 	    rmu_header->format != MV88E6XXX_RMU_RESP_FORMAT_2) {
 		dev_dbg_ratelimited(ds->dev, "RMU: invalid format: rx %d\n",
 				    be16_to_cpu(rmu_header->format));
-		goto drop;
+		err = -EPROTO;
 	}
 
+	dsa_inband_complete(&chip->rmu_inband, rmu_header, resp_len, err);
 drop:
 	return;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/rmu.h b/drivers/net/dsa/mv88e6xxx/rmu.h
index 69cd3c2636f3d..a81af5a1ad762 100644
--- a/drivers/net/dsa/mv88e6xxx/rmu.h
+++ b/drivers/net/dsa/mv88e6xxx/rmu.h
@@ -9,9 +9,20 @@
 #ifndef _MV88E6XXX_RMU_H_
 #define _MV88E6XXX_RMU_H_
 
+#define MV88E6XXX_RMU_WAIT_TIME_MS		20
+#define MV88E6XXX_RMU_REQUEST_TIMEOUT_MS	50
+
+#define MV88E6XXX_RMU_REQ_FORMAT_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_FORMAT_SOHO		htons(0x0001)
+#define MV88E6XXX_RMU_REQ_PAD			htons(0x0000)
+#define MV88E6XXX_RMU_REQ_CODE_GET_ID		htons(0x0000)
+#define MV88E6XXX_RMU_REQ_DATA			htons(0x0000)
+
 #define MV88E6XXX_RMU_RESP_FORMAT_1		htons(0x0001)
 #define MV88E6XXX_RMU_RESP_FORMAT_2		htons(0x0002)
 
+#define MV88E6XXX_RMU_RESP_CODE_GOT_ID		htons(0x0000)
+
 struct mv88e6xxx_rmu_header {
 	__be16 format;
 	__be16 prodnr;

-- 
2.43.0


