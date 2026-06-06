Return-Path: <netdev+bounces-296086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFbRF9DbI2oazwEAu9opvQ
	(envelope-from <netdev+bounces-296086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B664CF1F
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:35:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fmMbt1Zd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296086-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296086-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D69307835A
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF4318140;
	Sat,  6 Jun 2026 08:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F431716D
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 08:30:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734643; cv=none; b=as2aIhvAuEjL0JZ8d93Uvpy2TmzTv+GZkJnXbYdbm4ocj0Oj9t3w684uvwaLdstnfdFBHO3uIhBm5H8/X5PKQxMchAU3nAZCKyvsYCpWx4R7WK4ly8YBoYIE78KnOXfp9dRlNEgTXVAWpDAmdCLyZcN4Qfk/tIsXPjv7y7DPJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734643; c=relaxed/simple;
	bh=dFIA2Zo6kvFyZdl49iU4RnHwCtjUifECUpJAch6RC00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwLVOiwJf4N3g4RAdgWJv523ueliKLe2ucp+xiiHEU2bCPcj4qTGVG4kKMbH6elz/LDuIUu/sN7cNqhS7G/jfA4UpZ9xdrS+Brjll43bIKPOMBfTjogm917iz8V3wnVkBWCQD8Tbsb4AqULAxaydX8VHpvOV1DwFSZVipyRvwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmMbt1Zd; arc=none smtp.client-ip=209.85.221.176
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59ccf81e74bso865587e0c.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780734640; x=1781339440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfNRZXZTyDLV4FmlagGMV/ZnfjtVuTWnD/I597PQ5jc=;
        b=fmMbt1Zdhz/eA/7ifJef6UKpyH2RBZi0NR1gfiksdKhPKiEw6X4r3qcXiC4ny/xIYA
         kyZiabhLEjdnwpENZX7eAtxEyz/occBSILW7g3nKnIcTpv5l2l0QeuuhrJsFpPgekC8q
         FAk9BbonPjNB3kUyzVgOpoZTlzPXfYxYHmbsAQknjINftYjl0DFNGdaAqwdNKEMFUZYI
         3VJ/MCWLiGoPLhHG403tM05FHQgzalz24HRTs1oW+QBPQj8fSmw6O6XeagQsRz+w2FcY
         b/bcJ3DTAa+yINAV6/m5h8lhMMaohH4xA5ayu16Ussw+ra7Y47zCkoojjtPiOHENEiUK
         zERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780734640; x=1781339440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfNRZXZTyDLV4FmlagGMV/ZnfjtVuTWnD/I597PQ5jc=;
        b=QcyyYF0sdZxF/wmEK02ofN/U524jWnPr6bdMzuDsb0peTjnjLKccgUGqfERUt4N/Lx
         m8WL5XTeN8CDgi5eZUp2fWebR7TC7d6x9zEGR2kfjEoze5QkuGCpfKe+1s1+j+eLM+I/
         kQzGzRTB+ZiBZDgxFk6rPjwjiS8HNarOIY53Nou5KXxjkSahq98m4Iivka1+9IQJZm8P
         6CqGC4sbptyC1CyC4IETjLNZm1Reyb41kmCThoWEhElL+zr1p7GGjlOtWl/OfAgBGzf4
         fS61XKCRUHOwO75nP9E9Sh/0QA+eBVxkzLGA0IuSjeVWAYgHbIY2B543zkq7O1KRcj4I
         fs+Q==
X-Gm-Message-State: AOJu0YwoAxqopQGeiMr+Ku7EkLaGUY5R8rDe9y5dIgvEBduzeM47hRYZ
	e2u7WS2zwY0gtlGpZP3Xsy5zwTdcRYSOZ7bzJuAJvp4lnnEVC0yduUM8BNZXpZIG3Ts=
X-Gm-Gg: Acq92OHdCeKv08xKtRB8F86/QLb3oJWDJpdB9M1+mhVwBbvsEDl59U52BCTEorcyZuX
	XLSKtufpMZfvjGHfOhVfrxUP7nk3CdSQEVnaGMn7XXNvimOfFyCng9uknkt8CxOawGyeCi7ryX9
	xlV9tEZVcpOG1H0Owte+ACdZy3JeAm25COXqY/4vHg++/XLz7TV9/1282Lhy8uml0WWQstYfjB2
	jgQtB9uS3fkLEqIOD66pCZyfmSmvreLB5hP3H6AG46t2ClTcx9e+A4UZmqQ+Aa4dvObQV3oviSo
	AyJQKhXALEtY1sY6VRORoTgx5E6HQv0zIuBe8DRK3Nuz8L29W3Sw4ZTowfXNuvBJUCHxzVja59X
	AfPDL5Alx9m+wVomKJHiDxt6u0kry+sKeKv3EBavxML6U76CfNOqaHLPu2ye+DIXsjKoBPuTrHp
	1eyql2Rjg2F5T5JnynVPzEEmnqTBiJmCQaPRWrHjGJSGiVLfWv4w==
X-Received: by 2002:a05:6122:4b05:b0:5a0:9ad4:7016 with SMTP id 71dfb90a1353d-5ac57e02261mr3187734e0c.10.1780734640203;
        Sat, 06 Jun 2026 01:30:40 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d233sm9630281e0c.10.2026.06.06.01.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 01:30:38 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 06 Jun 2026 05:29:32 -0300
Subject: [net-next PATCH v13 8/9] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-realtek_forward-v13-8-b9e409687cbe@gmail.com>
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
In-Reply-To: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B14B664CF1F

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Implement hardware offloading of bridge functionality. This is achieved
by using the per-port isolation registers, which contain a forwarding
port mask. The switch will refuse to forward packets ingressed on a
given port to a port which is not in its forwarding mask.

For each bridge that is offloaded, use the DSA-provided bridge number
for the Extended Filtering ID (EFID). When using Independent VLAN
Learning (IVL), the forwarding database is keyed with the tuple
{VID, MAC, EFID}. There are 8 EFIDs available (0~7), but we reserve the
default EFID 0 for standalone ports where learning is disabled. This
fits nicely because DSA indexes the bridge number starting from 1.

Because of the limited number of EFIDs, we have to set the
max_num_bridges property of our switch to 7: we can't offload more than
that or we will fail to offer IVL as at least two bridges would end up
having to share an EFID.

All ports start isolated, forwarding exclusively to CPU ports, and
with VLAN transparent, ignoring VLAN membership. Once a member in a
bridge, the port isolation is expanded to include the bridge members.
When that bridge enables VLAN filtering, the VLAN transparent feature is
disabled, letting the switch filter based on VLAN setup.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h        |   7 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  47 ++++++++-
 drivers/net/dsa/realtek/rtl83xx.c        | 169 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   7 ++
 4 files changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 0f70ce185174..a6863f757c50 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -127,6 +127,13 @@ struct realtek_ops {
 	int	(*enable_vlan)(struct realtek_priv *priv, bool enable);
 	int	(*enable_vlan4k)(struct realtek_priv *priv, bool enable);
 	int	(*enable_port)(struct realtek_priv *priv, int port, bool enable);
+	int	(*port_add_isolation)(struct realtek_priv *priv, int port,
+				      u32 mask);
+	int	(*port_remove_isolation)(struct realtek_priv *priv, int port,
+					 u32 mask);
+	int	(*port_set_efid)(struct realtek_priv *priv, int port, u32 efid);
+	int	(*port_set_learning)(struct realtek_priv *priv, int port,
+				     bool enable);
 	int	(*l2_add_uc)(struct realtek_priv *priv, int port,
 			     const unsigned char addr[ETH_ALEN],
 			     u16 efid, u16 vid);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index dd8c0c2f12ba..683836328899 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -1568,10 +1568,44 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 			    enable ? RTL8365MB_LEARN_LIMIT_MAX : 0);
 }
 
+static int rtl8365mb_port_set_efid(struct realtek_priv *priv, int port,
+				   u32 efid)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_EFID_REG(port),
+				  RTL8365MB_PORT_EFID_MASK(port),
+				  efid << RTL8365MB_PORT_EFID_OFFSET(port));
+}
+
+/* Port isolation manipulation functions.
+ *
+ * The port isolation register controls the forwarding mask of a given
+ * port. The switch will not forward packets ingressed on a given port
+ * to ports which are not enabled in its forwarding mask.
+ *
+ * The port forwarding mask has the highest priority in forwarding
+ * decisions. The only exception to this rule is when the switch
+ * receives a packet on its CPU port with ALLOW=0. In that case the TX
+ * field of the CPU tag will override the forwarding port mask.
+ */
 static int rtl8365mb_port_set_isolation(struct realtek_priv *priv, int port,
 					u32 mask)
 {
-	return regmap_write(priv->map, RTL8365MB_PORT_ISOLATION_REG(port), mask);
+	return regmap_write(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+			    mask);
+}
+
+static int rtl8365mb_port_add_isolation(struct realtek_priv *priv, int port,
+					u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+				  mask, mask);
+}
+
+static int rtl8365mb_port_remove_isolation(struct realtek_priv *priv, int port,
+					   u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8365MB_PORT_ISOLATION_REG(port),
+				  mask, 0);
 }
 
 static int rtl8365mb_mib_counter_read(struct realtek_priv *priv, int port,
@@ -2378,6 +2412,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (ret)
 			goto out_teardown_irq;
 
+		/* Set the default EFID 0 for standalone mode */
+		ret = rtl8365mb_port_set_efid(priv, dp->index, 0);
+		if (ret)
+			goto out_teardown_irq;
+
 		/* Disable learning */
 		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
 		if (ret)
@@ -2567,6 +2606,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
+	.port_bridge_join = rtl83xx_port_bridge_join,
+	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2592,6 +2633,10 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 
 static const struct realtek_ops rtl8365mb_ops = {
 	.detect = rtl8365mb_detect,
+	.port_add_isolation = rtl8365mb_port_add_isolation,
+	.port_remove_isolation = rtl8365mb_port_remove_isolation,
+	.port_set_efid = rtl8365mb_port_set_efid,
+	.port_set_learning = rtl8365mb_port_set_learning,
 	.l2_add_uc = rtl8365mb_l2_add_uc,
 	.l2_del_uc = rtl8365mb_l2_del_uc,
 	.l2_get_next_uc = rtl8365mb_l2_get_next_uc,
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 7a9a2363d81f..61921f914a57 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -328,6 +328,175 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
 	gpiod_set_value(priv->reset, false);
 }
 
+/**
+ * rtl83xx_port_bridge_join() - join a port to a bridge
+ * @ds: DSA switch instance
+ * @port: port index
+ * @bridge: bridge being joined
+ * @tx_forward_offload: if the switch can offload TX forwarding
+ * @extack: netlink extended ack for reporting errors
+ *
+ * This function handles joining a port to a bridge. It updates the port
+ * isolation masks and EFID.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge,
+			     bool *tx_forward_offload,
+			     struct netlink_ext_ack *extack)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u32 mask = 0;
+	int ret;
+
+	if (!priv->ops->port_add_isolation)
+		return -EOPNOTSUPP;
+
+	if (!priv->ops->port_set_learning)
+		return -EOPNOTSUPP;
+
+	dev_dbg(priv->dev, "bridge %d join port %d\n", bridge.num, port);
+
+	/* Add this port to the isolation group of every other port
+	 * offloading this bridge.
+	 */
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Handle this port after */
+		if (dp->index == port)
+			continue;
+
+		/* Skip ports that are not in this bridge */
+		if (!dsa_port_offloads_bridge(dp, &bridge))
+			continue;
+
+		ret = priv->ops->port_add_isolation(priv, dp->index, BIT(port));
+		if (ret)
+			goto undo_isolation;
+
+		mask |= BIT(dp->index);
+	}
+
+	/* If we support cascade switches, it should also include the
+	 * downstream DSA ports to the isolation group.
+	 */
+
+	/* Add those ports to the isolation group of this port */
+	ret = priv->ops->port_add_isolation(priv, port, mask);
+	if (ret)
+		goto undo_isolation;
+
+	/* Use the bridge number as the EFID for this port */
+	if (priv->ops->port_set_efid) {
+		ret = priv->ops->port_set_efid(priv, port, bridge.num);
+		if (ret)
+			goto undo_self_isolation;
+	}
+
+	ret = priv->ops->port_set_learning(priv, port, true);
+	if (ret)
+		goto undo_efid;
+
+	return 0;
+
+undo_efid:
+	if (priv->ops->port_set_efid)
+		priv->ops->port_set_efid(priv, port, 0);
+
+undo_self_isolation:
+	priv->ops->port_remove_isolation(priv, port, mask);
+
+undo_isolation:
+	dsa_switch_for_each_port(dp, ds) {
+		if (mask & BIT(dp->index))
+			priv->ops->port_remove_isolation(priv, dp->index,
+							 BIT(port));
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_join, "REALTEK_DSA");
+
+/**
+ * rtl83xx_port_bridge_leave() - leave a bridge
+ * @ds: DSA switch instance
+ * @port: port index
+ * @bridge: bridge being left
+ *
+ * This function handles removing a port from a bridge. It updates the port
+ * isolation masks and EFID.
+ *
+ * Context: Can sleep.
+ * Return: nothing
+ */
+void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
+			       struct dsa_bridge bridge)
+{
+	struct realtek_priv *priv = ds->priv;
+	struct dsa_port *dp;
+	u32 mask = 0;
+	int ret;
+
+	if (!priv->ops->port_remove_isolation)
+		return;
+
+	if (!priv->ops->port_set_learning)
+		return;
+
+	dev_dbg(priv->dev, "bridge %d leave port %d\n", bridge.num, port);
+
+	/* Remove this port from the isolation group of every other
+	 * port offloading this bridge.
+	 */
+	dsa_switch_for_each_user_port(dp, ds) {
+		/* Handle this port after */
+		if (dp->index == port)
+			continue;
+
+		/* Skip ports that are not in this bridge */
+		if (!dsa_port_offloads_bridge(dp, &bridge))
+			continue;
+
+		ret = priv->ops->port_remove_isolation(priv, dp->index,
+						       BIT(port));
+		if (ret)
+			dev_err(priv->dev,
+				"failed to isolate port %d from port %d: %pe\n",
+				port, dp->index, ERR_PTR(ret));
+
+		mask |= BIT(dp->index);
+	}
+
+	/* If we support cascade switches, it should also exclude the
+	 * downstream DSA ports from the isolation group.
+	 */
+
+	ret = priv->ops->port_set_learning(priv, port, false);
+	if (ret)
+		dev_err(priv->dev,
+			"failed to disable learning on port %d: %pe\n",
+			port, ERR_PTR(ret));
+
+	/* Remove those ports from the isolation group of this port */
+	ret = priv->ops->port_remove_isolation(priv, port, mask);
+	if (ret)
+		dev_err(priv->dev,
+			"failed to remove isolation mask from port %d: %pe\n",
+			port, ERR_PTR(ret));
+
+	/* Revert to the default EFID 0 for standalone mode */
+	if (priv->ops->port_set_efid) {
+		ret = priv->ops->port_set_efid(priv, port, 0);
+		if (ret)
+			dev_err(priv->dev,
+				"failed to clear EFID on port %d: %pe\n",
+				port, ERR_PTR(ret));
+	}
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_leave, "REALTEK_DSA");
+
 /**
  * rtl83xx_port_fast_age() - flush dynamic FDB entries learned on a port
  * @ds: DSA switch instance
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index 6c1cfeea4b6b..dcb819fe567f 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -21,6 +21,13 @@ void rtl83xx_remove(struct realtek_priv *priv);
 void rtl83xx_reset_assert(struct realtek_priv *priv);
 void rtl83xx_reset_deassert(struct realtek_priv *priv);
 
+int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge,
+			     bool *tx_forward_offload,
+			     struct netlink_ext_ack *extack);
+void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
+			       struct dsa_bridge bridge);
+
 void rtl83xx_port_fast_age(struct dsa_switch *ds, int port);
 int rtl83xx_port_fdb_add(struct dsa_switch *ds, int port,
 			 const unsigned char *addr, u16 vid,

-- 
2.54.0


