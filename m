Return-Path: <netdev+bounces-304423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n2aJDHhpR2qjXwAAu9opvQ
	(envelope-from <netdev+bounces-304423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FAA6FFBA7
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=efmwG3tZ;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304423-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304423-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795363065E9D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689D936EAB1;
	Fri,  3 Jul 2026 07:46:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126F36E493;
	Fri,  3 Jul 2026 07:46:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064814; cv=none; b=gZj4+J9zOGnObiO9+QZMKD1a1l1CB0Vr4+vGgKhoIpY82IsdAHKwz0ie5YvJ9CG+tJ9cd6eyqW7FFRuLhLhyC0x8+sxX0MZHKpkso9pCA7VpCbYOzwttEHBjyYAWtoh4uauc9rCCnqQ8L+XTQ7wxbjgT0+S/7WIQjhhJH9oP1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064814; c=relaxed/simple;
	bh=Ubc7BlBoM2NOylwPsuRB36jii7yR41I0ACgC9QBZfDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/6US0YHXy3QikpsL0ScXSR8DPauSyXW44YH9fuS/b7d2FojxW+CHakRcXjaDSU4l5GzK9WrapoyHs6JhAvU70lQPrJ2mMASxVUWeVdlzMP60xdNajdpelXtbGCApQHwc7mmEWI870G47mtUvLC/kLLnnS9yjpIAj5goPPlHhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=efmwG3tZ; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id EEEE660C1E;
	Fri,  3 Jul 2026 03:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064812; bh=R7xEFjtxYLfIJ1z9X+ftxPlg65AQgqCVywuFkKVGGBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=efmwG3tZWjRBJzy8uertGNKji4Y5NdL+8cY/Cal1bne+iWowOBxOi7+/YpTmmLi8U
	 4K766ghWaWfr7kYO/8sStKr/6UuLglaNLHj1L/f/CodBn6zAW5+AMhhy+tqpVsjGkv
	 HJKEwvRe5C7vyKQtFWRUZc27QRctgbtJD9u4BqmPumM5lwJHZNB3uszQzOZ1R138yl
	 mgca2vYaaoGkIjhx7iTmb56AtSKXi45wqxyvJmDT8Z53nTv1///kRAwKmEGoYkP9i+
	 3FYzfAWuBMdb3HZ0ZWK5z8ZMiWo9jWoHVviMF4XgKfWnmzS/zLqpKQ3wyUe/fO99IZ
	 DWjGjpb36PhjA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:36 +1000
Subject: [PATCH net-next 02/17] net: dsa: mv88e6xxx: Introduce Marvell dsa
 tagger data operation.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-2-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=4053;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=fRe/dRX7K63+9czuAaR2kcpvTHO9qZyAG9BqEaTG/04=;
 b=IE9yz2tZzY3TExwb5D5A4fT9vhAVBStuntU+DrzGGeMESrHA3CMwPwQmU4ppDGOwNWojlc60h
 EqbX4MLVH9mA1Xy2/EF9/sDqDdZABS+yQB5JiIPmxb2B+pfMWZ5aKcb
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
	TAGGED_FROM(0.00)[bounces-304423-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11FAA6FFBA7

From: Mattias Forsblad <mattias.forsblad@gmail.com>

Support connecting Marvell dsa tagger to the switch driver frame2reg
function to decode received RMU frames.

(Note: during teardown or failed setup, tagger_data may be NULL when
a late FRAME2REG frame arrives.)

Signed-off-by: Luke Howard <lukeh@padl.com>
Signed-off-by: Mattias Forsblad <mattias.forsblad@gmail.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/dsa/mv88e6xxx.h |  8 ++++++++
 net/dsa/tag_dsa.c             | 43 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/linux/dsa/mv88e6xxx.h b/include/linux/dsa/mv88e6xxx.h
index 8c3d45eca46bd..1e9460d6f7782 100644
--- a/include/linux/dsa/mv88e6xxx.h
+++ b/include/linux/dsa/mv88e6xxx.h
@@ -6,6 +6,14 @@
 #define _NET_DSA_TAG_MV88E6XXX_H
 
 #include <linux/if_vlan.h>
+#include <net/dsa.h>
+
+struct dsa_tagger_data {
+	/* DSA frame decoded to be from the RMU */
+	void (*rmu_frame2reg)(struct dsa_switch *ds,
+			      struct sk_buff *skb,
+			      u8 seqno);
+};
 
 #define MV88E6XXX_VID_STANDALONE	0
 #define MV88E6XXX_VID_BRIDGED		(VLAN_N_VID - 1)
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index d5ffee35fbb53..5a95873e87340 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -201,14 +201,17 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 				  u8 extra)
 {
+	struct dsa_tagger_data *tagger_data;
 	bool trap = false, trunk = false;
 	int source_device, source_port;
+	struct dsa_switch *ds;
 	enum dsa_code code;
 	enum dsa_cmd cmd;
 	u8 *dsa_header;
 
 	/* The ethertype field is part of the DSA header. */
 	dsa_header = dsa_etype_header_pos_rx(skb);
+	source_device = dsa_header[0] & 0x1f;
 
 	cmd = dsa_header[0] >> 6;
 	switch (cmd) {
@@ -220,12 +223,20 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 		code = (dsa_header[1] & 0x6) | ((dsa_header[2] >> 4) & 1);
 
 		switch (code) {
-		case DSA_CODE_FRAME2REG:
-			/* Remote management is not implemented yet,
-			 * drop.
-			 */
+		case DSA_CODE_FRAME2REG: {
+			u8 seqno = dsa_header[3];
+
+			ds = dsa_conduit_find_switch(dev, source_device);
+			if (!ds) {
+				kfree_skb(skb);
+				return NULL;
+			}
+			tagger_data = ds->tagger_data;
+			if (likely(tagger_data && tagger_data->rmu_frame2reg))
+				tagger_data->rmu_frame2reg(ds, skb, seqno);
 			kfree_skb(skb);
 			return NULL;
+		}
 		case DSA_CODE_ARP_MIRROR:
 		case DSA_CODE_POLICY_MIRROR:
 			/* Mark mirrored packets to notify any upper
@@ -256,7 +267,6 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 		return NULL;
 	}
 
-	source_device = dsa_header[0] & 0x1f;
 	source_port = (dsa_header[1] >> 3) & 0x1f;
 
 	if (trunk) {
@@ -331,6 +341,25 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 	return skb;
 }
 
+static int dsa_tag_connect(struct dsa_switch *ds)
+{
+	struct dsa_tagger_data *tagger_data;
+
+	tagger_data = kzalloc_obj(*tagger_data, GFP_KERNEL);
+	if (!tagger_data)
+		return -ENOMEM;
+
+	ds->tagger_data = tagger_data;
+
+	return 0;
+}
+
+static void dsa_tag_disconnect(struct dsa_switch *ds)
+{
+	kfree(ds->tagger_data);
+	ds->tagger_data = NULL;
+}
+
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_DSA)
 
 static struct sk_buff *dsa_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -353,6 +382,8 @@ static const struct dsa_device_ops dsa_netdev_ops = {
 	.proto	  = DSA_TAG_PROTO_DSA,
 	.xmit	  = dsa_xmit,
 	.rcv	  = dsa_rcv,
+	.connect  = dsa_tag_connect,
+	.disconnect = dsa_tag_disconnect,
 	.needed_headroom = DSA_HLEN,
 };
 
@@ -397,6 +428,8 @@ static const struct dsa_device_ops edsa_netdev_ops = {
 	.proto	  = DSA_TAG_PROTO_EDSA,
 	.xmit	  = edsa_xmit,
 	.rcv	  = edsa_rcv,
+	.connect  = dsa_tag_connect,
+	.disconnect = dsa_tag_disconnect,
 	.needed_headroom = EDSA_HLEN,
 };
 

-- 
2.43.0


