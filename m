Return-Path: <netdev+bounces-295629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HGRhClxXImoOVQEAu9opvQ
	(envelope-from <netdev+bounces-295629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 06:58:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B21645147
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 06:58:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l73I2aiT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295629-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 659C0301237A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 04:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3FC3E556C;
	Fri,  5 Jun 2026 04:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD93B3884
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 04:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635453; cv=none; b=jdTz15t2D241b07jwmozubVnDZrR2TaRFUG69LeMITJY0QmSKoDjD/MuUinUKAvCHtJyR7XDq4hf6d5DWztKk1IOGIFhCYMxmzcU1oFZk+QQ55hooAeFnI3ghfCKc0F2V1QFUkvkPJGovffBGm7xWjk8EETdXF/v55vVOinG8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635453; c=relaxed/simple;
	bh=wfH3QxmUnVBTlnfk6kNVt1+XvZvEF26URa7GXF3xbc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls1JUk+YlDEs/I9kfvebpqZGNclhjExXRDcBZWyNaCh3J/alcn+vQ8aZGpUOemOCW/uO3FZTBFzoYjIVzBS9SQ5Ku79UrelZ83pAQMlubrUKD4iHNzNX+5K/b4gtcKswBECwhIjifveja5JDxidxsaTHMD3jdCkW6i4DAusrBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l73I2aiT; arc=none smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e0b3db3499so11339777b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780635451; x=1781240251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJj8Lf90oT+AYYRMsIsRxeRUBTjX28tbIoTLbV4p5WA=;
        b=l73I2aiTysFxMf3rXi7XDEv2jdfvYF/RtE0Ynq4NhPEFwTfmu3rbg9LeS5n/0zApSe
         +AbT8vjfkKB/usIODSkRhoGR2kgtXfp9oR3h99peFU7mfY9/6EKaBfGVVeaoYrtAXIJS
         ajYWfYi3ZykrbY3Bz4wjJl3Nz2ch7Z/3RUfW7WvpAjEHnyRp7iiJHXn3iflZxgohcArC
         KvrHt3hUrDFsFAbCiu08dSMqxbmoO1hXO2auVp+JSKVHYmrRZHzYfqBG9JF+6cqBLiMr
         Ado4aUAX+WaNWz0hyP8QMQlIZdDKFogRexU32WWSbxcxKTDSyfle9OPVNxHsWQQIMqrb
         Cjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635451; x=1781240251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJj8Lf90oT+AYYRMsIsRxeRUBTjX28tbIoTLbV4p5WA=;
        b=ECVT5nv9h5fB8K0KZ19P85jlGTDqkzyuvpkYSEyMMt5O/Y2tAEHwBZ+n8PbmiByqFT
         kEF3g8nEdT/sIrbss0EUIHHSCdIZUvmpU839z+Wk2UJfloMF4LXE3yTgR/LivyeVVhG0
         vwyqmcMnObqtD1tOT/sL75nP1j4pt+kns3rSXBDqx1pblD2qGcyzpjf0ofsp7th8fOzx
         Qrz5RtstSRK8EZTWBuz66WPWB4+revCTkWa9rOuV4VtIRzL0yQaUIYFwiQnc7sX1KHIN
         3KX5dT6TEMHpwkm89j3SqMFmMpfmCnNjz5FFqNv1NP2ITon8HbEMVksj0KQMm5q0+zXJ
         zeXg==
X-Gm-Message-State: AOJu0Yz2DfopSaYJiFIHq7+0ObsOHG+8XVHi/SmehAJMqRlLQdY3yTY4
	eBNNN78sWzBVQl3B6K88sMSr444MTVLZcTchH8Sp7kRg23ctrKFBGrCA
X-Gm-Gg: Acq92OFj8eP+K+/UZ889AkHn3yKHjEDwp7/YxFYT7qvJgIqjVPO1v//jrfKREFChZUW
	QCTSGvzQQp8fMGZ0Ed+jPo3UkAIbsbPVjFX/WZ57I0QBtJOUGPk1RUbvxQbyZlRgn4aPMdj+VvX
	+dDC+hrveJYePRlL/5Bn38f28AsdqSPuyhCY9Fn2EGkKUuUQ2RQc1yFlB+n/oZJ4cOf+fHJzaxo
	b2j3bhdBV89XUJ9eUFq1r0nBgrArdXdW4N+n6MPPAYHn3DgOHUvbQPCTtulBd4MSwMy5M2E+Mps
	gA12gtTGBEyMrcHMYGUOTuoSbydvEJn87kjwDuQPJRcLLYunJnOxi3WAd9soAlqyQ8OKAycE26o
	k55kSFY6yNu5A6xgP992eLSqm4LZL6goCAGjGJsf4ZRPTWnpzJ9hCU/A/EX86LxvS1mUw2iOnyO
	tcrXoYC192CTSQS9JTPhmRIFeVZcoPW8Xml1v/QrVyiQ5wJM33ug==
X-Received: by 2002:a05:690c:4588:b0:7dc:e96a:26d3 with SMTP id 00721157ae682-7ed0d8b46b4mr19074877b3.45.1780635451033;
        Thu, 04 Jun 2026 21:57:31 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm45840207b3.16.2026.06.04.21.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 21:57:29 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 05 Jun 2026 01:56:16 -0300
Subject: [net-next PATCH v12 8/9] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-realtek_forward-v12-8-78eb7b31df72@gmail.com>
References: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
In-Reply-To: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295629-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17B21645147

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
 drivers/net/dsa/realtek/rtl8365mb_main.c |  59 ++++++++++-
 drivers/net/dsa/realtek/rtl83xx.c        | 169 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   7 ++
 4 files changed, 241 insertions(+), 1 deletion(-)

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
index 7ddc8bed3992..bc397cdd6f38 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -290,6 +290,15 @@
 		(RTL8365MB_PORT_ISOLATION_REG_BASE + (_physport))
 #define   RTL8365MB_PORT_ISOLATION_MASK			0x07FF
 
+/* Extended filter ID registers - used to key forwarding database with IVL */
+#define RTL8365MB_EFID_MASK			GENMASK(2, 0)
+#define RTL8365MB_PORT_EFID_REG_BASE		0x0A32
+#define RTL8365MB_PORT_EFID_REG(_p) \
+		(RTL8365MB_PORT_EFID_REG_BASE + ((_p) >> 2))
+#define   RTL8365MB_PORT_EFID_OFFSET(_p)	(((_p) & 0x3) << 2)
+#define   RTL8365MB_PORT_EFID_MASK(_p) \
+		(RTL8365MB_EFID_MASK << RTL8365MB_PORT_EFID_OFFSET(_p))
+
 /* MSTP port state registers - indexed by tree instance */
 #define RTL8365MB_MSTI_CTRL_BASE			0x0A00
 #define RTL8365MB_MSTI_CTRL_REG(_msti, _physport) \
@@ -1559,10 +1568,44 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
@@ -2369,6 +2412,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2440,6 +2488,9 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	ds->assisted_learning_on_cpu_port = true;
 	ds->fdb_isolation = true;
 
+	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
+	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
+
 	ds->configure_vlan_while_not_filtering = true;
 
 	/* Set up VLAN */
@@ -2556,6 +2607,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
+	.port_bridge_join = rtl83xx_port_bridge_join,
+	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_fast_age = rtl83xx_port_fast_age,
 	.port_fdb_add = rtl83xx_port_fdb_add,
@@ -2581,6 +2634,10 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 
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


