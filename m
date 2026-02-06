Return-Path: <netdev+bounces-257488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFwrJtqfhWlKEAQAu9opvQ
	(envelope-from <netdev+bounces-257488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:01:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112AAFB35A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3204D30A4B16
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE27346780;
	Fri,  6 Feb 2026 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYEYAbHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF501346765
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364551; cv=none; b=k4n97m/VxWI8+CChs79xHWo4O35gK5vs0dEQGxKNCC5Z9RJLoHb/5BiuuvPzScJclcD+FKrZ69aIo4GiLcFLGh9z7Y4vhLPlRxcA4dq6w5aZ3YmR5/xO2GXEv+w4yqey+nz1RrkXJirYHs/MNucIFmFVbxs6W2ktaVjBzg5F7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364551; c=relaxed/simple;
	bh=v2d1blaGRcf8ijbWbljWEUVT02oGtckSRGq8JJ6vdwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFkAhWn6QqJ8DXKLxI3J2qBMxyia7uGEPuuaSd6rTNqhcD9KKzDEB6XdbgV3XKsec3C/a+4HNFlslPJA6Gpkc4Q/Q6xqcQPBp0poovSCV3eGgywdcEkW8p+Vo4aIrMr5F+eKD7P8NtrtFgYDZ0KP6a1eSSPEPDKflQPvT/N/toQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYEYAbHZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so1524885b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 23:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770364550; x=1770969350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ye++DxatwQlokJ3JNJAjWad+kly5kE+X16yBsy9Mh4=;
        b=WYEYAbHZxO8uUwgFazqD6CBgeTIh2xv2DpcqTfZ2WLX+ue5Ss3uTMbnYMOfGWUYDln
         AXyd6gu2QzhH0qClVBl8J7zupWUwBXYn21VDf2HfIBDfBsGXVTDuoFNG0BnQJ1kjHOmQ
         fs5zmBS6Pab47JUghQnBdUK2n0W63zebQIkwZsx/7XtgURXjOe47yy1cuNN5Tkxu5cTP
         V3ZNJRj8AbfeU9Cwr/LTfsEsGrLEYDidjB7hwaglt8MFS6sdgrSTzzG0As48Pewt/0if
         HSC+GX3rvvEpbNyDNzPuCYnrXy0nynlctdySde7HvgBPEM1YDuNa1ErjpZHiUtdRCwRW
         t5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770364550; x=1770969350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ye++DxatwQlokJ3JNJAjWad+kly5kE+X16yBsy9Mh4=;
        b=J4/tndTkUySgRazABgteepVPYDMVxAmFO0BTpeozCui9fa2Mq27dpZboBI45Xn6vB2
         1xs7vUCR6LPizPTJHWfuA5dlS36f0Gqdwi/OjX2Ji6zJHNAdPTn4qngBeqpc7Mf787k6
         //ji24kH200Y3p1ZNiGZWHgq6SBbgqHFxIgUqDeTxgeJxEzbyO99VU+BliT5rOlGrvuJ
         RLLGYRN/83b2HUPBRg/GHkqBkrrlnefEjJrSnla+/o3T9HAOKxss8WZtD/pDVN8SC18g
         I8uKC4C/mj0D5zxSnWABKxIq1kQR4arAAtrHIuJjsZmjVjrNMG/Yfj77tZGmX1DYxFj/
         SbhQ==
X-Gm-Message-State: AOJu0Yz+TqzF/j3WVrX9J8Fb+snKjUZ4xUy1X93PX6kLK8OEIyewvx8V
	Ebubg9FW5oWwbCvqg4XK87+lIFMx4PB2kXrQ+M8pDqS0QayNELg/ETFArAXAMFlq
X-Gm-Gg: AZuq6aKK/ga8QhiTZeO5kLEs6neUJCaBOree+85JzCu9z0iWXTeyLfIaRhhPUyQK+Hr
	Z+JFTOwNhiC4iKPxpko7Dd+aCqtIKShlP7rhbRamlhb9C8GBeihcjCLBjOLwRjhj+LrpI/EcOu2
	Wb/eIQ7cjEwTm2BVaLwd0A1GTCQJdPGeDiHgO3WoV7ir7q6qyRi6JNlYdr6TlYmTCZNosurSezs
	few/5Efa85QmT9hwMtSBW/GNVAHU7C6WUZehXksCq8ZlgbhXmwHb0w8LJ5YpPeq5Sib9qNPQ8Iz
	1AYpVK+S75xE15TILD8KjaRAyo4ZX48OgG+mWUqtcsDUToR+ZlR5SMT+PHzwOb8s3jTzGdP7B89
	jBEN6o/+t9sYKVocwZNt+VqIYjftWHSNcnv3zgbaPi6xiw85EnlkAK7b4ygUTBvX1P/twmUwtFT
	x/+M1SIBM1KrMbKLsS8Jgfja15Bw3rnwrytksBPA==
X-Received: by 2002:a05:6a21:138f:b0:38d:f623:f876 with SMTP id adf61e73a8af0-393ad41a179mr1704979637.79.1770364550083;
        Thu, 05 Feb 2026 23:55:50 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:1250::1d3:c3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5249a0sm1391881a12.11.2026.02.05.23.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:55:49 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Yang <mmyangfl@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: dsa: eliminate local type for tc policers
Date: Fri,  6 Feb 2026 15:54:21 +0800
Message-ID: <20260206075427.44733-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-257488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 112AAFB35A
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

David Yang is saying that struct flow_action_entry in
include/net/flow_offload.h has gained new fields and DSA's struct
dsa_mall_policer_tc_entry, derived from that, isn't keeping up.
This structure is passed to drivers and they are completely oblivious to
the values of fields they don't see.

This has happened before, and almost always the solution was to make the
DSA layer thinner and use the upstream data structures. Here, the reason
why we didn't do that is because struct flow_action_entry :: police is
an anonymous structure.

That is easily enough fixable, just name those fields "struct
flow_action_police" and reference them from DSA.

Make the according transformations to the two users (sja1105 and felix):
"rate_bytes_per_sec" -> "rate_bytes_ps".

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Co-developed-by: David Yang <mmyangfl@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v3: https://lore.kernel.org/r/20260203172207.98533-1-mmyangfl@gmail.com
  - move struct flow_action_police standalone
v2: https://lore.kernel.org/r/20260131045821.3451873-1-mmyangfl@gmail.com
  - use Oltean's version and export struct flow_action_police
v1: https://lore.kernel.org/r/20260126061340.757543-1-mmyangfl@gmail.com
  - fix DSA core only
 drivers/net/dsa/ocelot/felix.c         |  4 ++--
 drivers/net/dsa/sja1105/sja1105_main.c |  4 ++--
 include/net/dsa.h                      | 10 ++-------
 include/net/flow_offload.h             | 30 ++++++++++++++------------
 net/dsa/user.c                         |  5 ++---
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 9e5ede932b42..5d34eb82e639 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2003,11 +2003,11 @@ static int felix_cls_flower_stats(struct dsa_switch *ds, int port,
 }
 
 static int felix_port_policer_add(struct dsa_switch *ds, int port,
-				  struct dsa_mall_policer_tc_entry *policer)
+				  const struct flow_action_police *policer)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct ocelot_policer pol = {
-		.rate = div_u64(policer->rate_bytes_per_sec, 1000) * 8,
+		.rate = div_u64(policer->rate_bytes_ps, 1000) * 8,
 		.burst = policer->burst,
 	};
 
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 2a4a0fe20dae..71a817c07a90 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2841,7 +2841,7 @@ static void sja1105_mirror_del(struct dsa_switch *ds, int port,
 }
 
 static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
-				    struct dsa_mall_policer_tc_entry *policer)
+				    const struct flow_action_police *policer)
 {
 	struct sja1105_l2_policing_entry *policing;
 	struct sja1105_private *priv = ds->priv;
@@ -2852,7 +2852,7 @@ static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
 	 * the value of RATE bytes divided by 64, up to a maximum of SMAX
 	 * bytes.
 	 */
-	policing[port].rate = div_u64(512 * policer->rate_bytes_per_sec,
+	policing[port].rate = div_u64(512 * policer->rate_bytes_ps,
 				      1000000);
 	policing[port].smax = policer->burst;
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6b2b5ed64ea4..656990365798 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -216,12 +216,6 @@ struct dsa_mall_mirror_tc_entry {
 	bool ingress;
 };
 
-/* TC port policer entry */
-struct dsa_mall_policer_tc_entry {
-	u32 burst;
-	u64 rate_bytes_per_sec;
-};
-
 /* TC matchall entry */
 struct dsa_mall_tc_entry {
 	struct list_head list;
@@ -229,7 +223,7 @@ struct dsa_mall_tc_entry {
 	enum dsa_port_mall_action_type type;
 	union {
 		struct dsa_mall_mirror_tc_entry mirror;
-		struct dsa_mall_policer_tc_entry policer;
+		struct flow_action_police policer;
 	};
 };
 
@@ -1110,7 +1104,7 @@ struct dsa_switch_ops {
 	void	(*port_mirror_del)(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror);
 	int	(*port_policer_add)(struct dsa_switch *ds, int port,
-				    struct dsa_mall_policer_tc_entry *policer);
+				    const struct flow_action_police *policer);
 	void	(*port_policer_del)(struct dsa_switch *ds, int port);
 	int	(*port_setup_tc)(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type, void *type_data);
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 5637747019c1..70a02ee14308 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -231,6 +231,21 @@ struct flow_action_cookie *flow_action_cookie_create(void *data,
 						     gfp_t gfp);
 void flow_action_cookie_destroy(struct flow_action_cookie *cookie);
 
+struct flow_action_police {
+	u32 burst;
+	u64 rate_bytes_ps;
+	u64 peakrate_bytes_ps;
+	u32 avrate;
+	u16 overhead;
+	u64 burst_pkt;
+	u64 rate_pkt_ps;
+	u32 mtu;
+	struct {
+		enum flow_action_id act_id;
+		u32 extval;
+	} exceed, notexceed;
+};
+
 struct flow_action_entry {
 	enum flow_action_id		id;
 	u32				hw_index;
@@ -275,20 +290,7 @@ struct flow_action_entry {
 			u32			trunc_size;
 			bool			truncate;
 		} sample;
-		struct {				/* FLOW_ACTION_POLICE */
-			u32			burst;
-			u64			rate_bytes_ps;
-			u64			peakrate_bytes_ps;
-			u32			avrate;
-			u16			overhead;
-			u64			burst_pkt;
-			u64			rate_pkt_ps;
-			u32			mtu;
-			struct {
-				enum flow_action_id	act_id;
-				u32			extval;
-			} exceed, notexceed;
-		} police;
+		struct flow_action_police police;	/* FLOW_ACTION_POLICE */
 		struct {				/* FLOW_ACTION_CT */
 			int action;
 			u16 zone;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..5697291d43cf 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1459,8 +1459,8 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	struct netlink_ext_ack *extack = cls->common.extack;
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_user_priv *p = netdev_priv(dev);
-	struct dsa_mall_policer_tc_entry *policer;
 	struct dsa_mall_tc_entry *mall_tc_entry;
+	struct flow_action_police *policer;
 	struct dsa_switch *ds = dp->ds;
 	struct flow_action_entry *act;
 	int err;
@@ -1497,8 +1497,7 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_POLICER;
 	policer = &mall_tc_entry->policer;
-	policer->rate_bytes_per_sec = act->police.rate_bytes_ps;
-	policer->burst = act->police.burst;
+	*policer = act->police;
 
 	err = ds->ops->port_policer_add(ds, dp->index, policer);
 	if (err) {
-- 
2.51.0


