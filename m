Return-Path: <netdev+bounces-256377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMUHJMsvgmlFQAMAu9opvQ
	(envelope-from <netdev+bounces-256377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:26:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 310BDDCC2D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36780305F672
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688323AE713;
	Tue,  3 Feb 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksiHnGVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04317325711
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139491; cv=none; b=g7YxZhEcRpgf35X+m2I0X7HS9xK5qEQBORmmN1coZ1iFeXQRH+Z6joRBhHBLcetegie48k2xfjaqC+7VISzRqKGZan5910G7RO68URBHc0018oz0y2ZFbEvkLL1VgeAoCUQXAmtGTF7UEEp/i2S670n9Y+f8cCM0n5LFwxl2Tr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139491; c=relaxed/simple;
	bh=NwQadxIsbAVicBdlN5JoSnhWAwdMRsWYGibuwLb2uqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCw96I6VdKTP4auL5Dy8khQfqGTmu8UWsW92tOj9b2s6fcSx2UGUYg3sFgzrn69p9PKFUt3xWeXtefiQb8YbhtBxdDyMGHJd5ztRz+JlDFQy6OA5hZBm4/ZSe8cIt22iU2K0LZ96SMB/E4D8YZSnSPkpCjSe3fu2H4oDlPT25UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksiHnGVP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8a7269547so56963565ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139489; x=1770744289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LF/dpo4BeQSytcLLWoC5FgkTqSqyB60iXXH6RwLfoVg=;
        b=ksiHnGVPU3C4rLF57d2ord97g3XGYtyds1LuQFPD1dTYgVmPn9u8Hhkx1pBel8P+Db
         47qB0tetJINtuIoAee7tuQUBp/zLBsOAMgdlWoB5VAWKqqe3DmgiZaG2+lvDn0xh28gX
         Qg2veIOHW7xEIveCjxMG4BjhZepdj4wOJ31m9Rgu1GNlem+X7ut+Zyw6nZI+yEGkQI1A
         6SFkeWr0IRNw5Z7x8qTpAFvO2RfOhsZjrL/CcEMFRaluaMWWMNGLJkEjpwdy61XdRPz1
         qTvW0u369Zo0xSV00FDFmdxtG/dC7GntccY4RpFfECwNvTbUsh3Nisy4TsKvg0/3rIVj
         3lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139489; x=1770744289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF/dpo4BeQSytcLLWoC5FgkTqSqyB60iXXH6RwLfoVg=;
        b=Vfpp0GnYVi9KNQM7glGNLAIPrKsHKrf8yuDT8xrRQuqg5FPjl8Cvf5o4KnrcyMRDWh
         7woKQLV0Ev2UTQ1ZeQaWIGZ86gqNfI3Cp8V9FlkckFdAe1zga8X636v7iiq6Noc4JtEq
         ryqEcY1rA3EbcKagFTp/kOYYN/rfDVxehsIkmhg7yAUBFG5OdzFdT3YOgH02dfm6iOQR
         siXQExRnc4HDCuznzFA0BSwJMhgV/2qTtSyWXe1+B/zZlP9bZv/DQK5rJNYX9JFiX2lH
         zlFO3e1bsCawGfenNtqyCWUQtzxHcvKU0dTjkx6TIVSKlaTM4kWW2RgENrKw/FSNqATS
         Fnlg==
X-Gm-Message-State: AOJu0Yy5lVNMblbu6S1jcdrcoX18OOEJ2mUgOPp77UsjjhDV6dbbuENU
	397uV4FNYDBKoPvKEUfY9Ysi8evauKMkYGgzqM31RgBK15tbZCBmlq+rP+DMBPw2
X-Gm-Gg: AZuq6aJbKrEFeYHpeCOVqTgALum4vpsgycrhlH2H6GtstarXmM+0ynvKHBkT2KRu1r9
	w4slJ6VhOSeaVBS9nbuG3pDqLo5UOFb451uQvjJsG+P3Kt8cSaId6yosk/pyI+UY0BSyqcfc6EH
	FSVp8MCGq645PLi9kC2A4GBop1wcWfhXKx9JLhZhlaDeNsngFohvdlXUb9sIuIcngHYQMUipFmm
	GkLB72d3T+Z828raPW7x66WUf8tMdmUpRPXSybJL49J8tgipINju+zVXEED844Wa0yoWVQ0a10a
	4r4cPt6uKFdsR8Jv4Ej7+xO+bhvktVWvhoCMvt17KNcmlA7RCQhPZJWgHH4jFhlVN9qvBrlfoyU
	f+oWDPvMTdNdJgmVAsCyiaQItF8F1uhvwjQHZVkjZyhkkyJBUqQ8aUwvL0ssXCjbQKmudjVZktb
	mD8hWOHy6HBjXCA+tt7/PzCXH1nzsLQ25tx9bY6aDOA6ifQqtEtx3vowem8lT+9u9qzOn3OvnHd
	qEDm4Kw4YZqPaV/Oe+EzDg=
X-Received: by 2002:a17:902:d585:b0:2a9:2942:e15d with SMTP id d9443c01a7336-2a933cdbaa3mr472525ad.5.1770139489167;
        Tue, 03 Feb 2026 09:24:49 -0800 (PST)
Received: from d.home.mmyangfl.win (tunnel997320-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:2c7::2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933966f12sm506025ad.76.2026.02.03.09.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:24:48 -0800 (PST)
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
Subject: [PATCH net-next v3] net: dsa: eliminate local type for tc policers
Date: Wed,  4 Feb 2026 01:22:02 +0800
Message-ID: <20260203172207.98533-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-256377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 310BDDCC2D
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
v2: https://lore.kernel.org/r/20260131045821.3451873-1-mmyangfl@gmail.com
  - use Oltean's version and export struct flow_action_police
v1: https://lore.kernel.org/r/20260126061340.757543-1-mmyangfl@gmail.com
  - fix DSA core only
 drivers/net/dsa/ocelot/felix.c         |  4 ++--
 drivers/net/dsa/sja1105/sja1105_main.c |  4 ++--
 include/net/dsa.h                      | 10 ++--------
 include/net/flow_offload.h             |  2 +-
 net/dsa/user.c                         |  5 ++---
 5 files changed, 9 insertions(+), 16 deletions(-)

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
index 596ab9791e4d..a2b1b752958a 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -275,7 +275,7 @@ struct flow_action_entry {
 			u32			trunc_size;
 			bool			truncate;
 		} sample;
-		struct {				/* FLOW_ACTION_POLICE */
+		struct flow_action_police {		/* FLOW_ACTION_POLICE */
 			u32			burst;
 			u64			rate_bytes_ps;
 			u64			peakrate_bytes_ps;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..df25a8891c01 100644
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
+	memcpy(policer, &act->police, sizeof(*policer));
 
 	err = ds->ops->port_policer_add(ds, dp->index, policer);
 	if (err) {
-- 
2.51.0


