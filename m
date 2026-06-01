Return-Path: <netdev+bounces-293505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ei5GPb0HGrxUQkAu9opvQ
	(envelope-from <netdev+bounces-293505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E377B618F7E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 04:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB2A303B5B5
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C4238C1A;
	Mon,  1 Jun 2026 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAfRBy29"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258723392D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282463; cv=none; b=r5j+xSg5hPbO+LkFpwCXm2bilfWQBMYQyb+y0fjJYawEbRN09RbWW3NWrYWxOrQOhNFLs3CiLVfL8VwjnanbGzbox9+XhjwoyEglrCveqeop3m9+YC4/N0oj+IyCx8BwweT4C4PHwgHgolpxEugvmC5zWxXuq85WuIL7D0r8DBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282463; c=relaxed/simple;
	bh=XlVsHS+cao84R2AV5Gma3U9wxEis1OGMG8EpN0G4vzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ThmHXlchEHCaH0Th8ABpeFsHPhskNJkmoGtSpEqBoNzATvZZ0lgwpsZJdGUmgb33GWRpW7jiTEwqi9iAMzw9Xke24/v82lNwVNg98o6cvDXWntT2QVRAWgvyIZ09+XVMzud0cWuval/3rpYgUXaMosMtBFGMEVjB/ONLTvYSaGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAfRBy29; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6607e80a846so434098d50.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780282460; x=1780887260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OI1DBPdFDMtYSULfLDCh2GCmY6nvCZEdKof9pqfYvt0=;
        b=KAfRBy29031ebEp0w7FbYt/n39xcOhoy1AjouwmNucni9Zm/XxosH5ZgRDS2DZgcXv
         wdpj/YXXMejEPPHzzeSJM/V2XNBuuZNl4EX6T8Q2s+ss4fj4bWyRduz71VUgGfImR9Q2
         S62yNSJ2yNR1Nmtvw3YNrLgMHLaUcAND/PJcVgoIPPB/IjqXY266xGosLaZpKKs5/fYg
         zHUaTnkyLJk79ZJ8scyMI4tvmN8NjQD+kAcARzYWKvdHmO882piyXC2DjJPUgjsLjeOy
         phOQ9/8QMgUQWvqbBBOvkBC2UY1De3Uqj6PSd5ah3ipWujH6EmJ6Dfo8zB3NNvPYr2++
         9BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780282460; x=1780887260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OI1DBPdFDMtYSULfLDCh2GCmY6nvCZEdKof9pqfYvt0=;
        b=jpdMCn14Hq0LGKO+SfAXh7czPIRUcmf26FjJsghwmkxhveNgh6Z4Ciyt/9YcSbNJCS
         t/ewbL6zmNZJ/7XGWWSOtvAQiYQ+qoIlXSWMupaRKbA9+W72dS131HtrfYaIV+fx61tu
         vEri1nXmLqLLQCOdr+Lp+e0VIDeQhV+tfmdVRJJpk5+yOdHtueUxCqrCf4aKCkV78nIb
         gl1gC8TxOfX4WTIZo4xcJNnNOpZmPNIcoW9ByjLxdR67yO4Oa8tRcIqJd2/Fs43OHO7R
         T6HvRSf9gekEmSpO5/KEtDSl224x4NT1VXV8EO/CROF/9e88Hs1Z8ni+hkg+lFYRQMtU
         dMMQ==
X-Gm-Message-State: AOJu0YzuovfkPjYdMDL9N33fkJtFb2mDMG11fHCjN/Qh0pY9cKVafMCG
	Bv4PeusHItLTuH66alT2ixC14gFmkEwTLmyQadjtcr2aw4lX8zucsIPq
X-Gm-Gg: Acq92OGXxhZ4FxgKo/JOyc/tsroBlwemY9ck6het8nRoj3PD2hepkklw7l+hwziT4Ry
	km/2YYc2mIqhyiURKQp3WdFLb9yslClwKiCrm7SsTvr3LpltU5Oh1LKn+1bssZMH/SUx7O+Jujx
	yB9EwLrzaDvzdYrlR/SqeLM9uT6O6ewVQ45ehuyVBK0ExQX/KqBkFoqYGZ4eegI3hERqK9DSn8i
	2vkkqAPmr0efV0G3jIHOQXDEcZbYOSCmPBLDt5+p0L6rV58QPIs1QqUPEB+ijoGmMmi5l/YBUEB
	hqwzJa4TG6SJQu5qaTci/ma+ePVs+83LoOrvdXLT92JJiIlmVNLeuQToXn8PKWogu2XFmCESX0/
	p80cClDzUtAGhgUFscr5KVLt94sTUdlFNa5c2zOJUYNRVx8jWUJ3d/ce907K1atDYqElIyLFYL6
	8+d88bxoN0awv05JhDliOIkdNworWLW+C/h//IhwGBGjcaB06WpuP20ygquODX
X-Received: by 2002:a05:690e:13ca:b0:660:5c38:8f3b with SMTP id 956f58d0204a3-6605f71a3b6mr7033277d50.53.1780282460148;
        Sun, 31 May 2026 19:54:20 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6606977ab05sm2952518d50.9.2026.05.31.19.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 19:54:19 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 31 May 2026 23:53:22 -0300
Subject: [net-next PATCH v11 7/9] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260531-realtek_forward-v11-7-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
In-Reply-To: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293505-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bang-olufsen.dk:email,linaro.org:email]
X-Rspamd-Queue-Id: E377B618F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h        |   7 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  58 +++++++++++-
 drivers/net/dsa/realtek/rtl83xx.c        | 150 +++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h        |   7 ++
 4 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index b9c4cbdd72fb..c271a15a9ae2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -112,6 +112,13 @@ struct realtek_ops {
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
 	int	(*phy_read)(struct realtek_priv *priv, int phy, int regnum);
 	int	(*phy_write)(struct realtek_priv *priv, int phy, int regnum,
 			     u16 val);
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index bb09d48d99ec..c170c7f23ca8 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -285,6 +285,15 @@
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
@@ -1537,10 +1546,44 @@ static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
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
@@ -2343,6 +2386,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
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
@@ -2411,6 +2459,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
+	/* The EFID is 3 bits, but EFID 0 is reserved for standalone ports */
+	ds->max_num_bridges = FIELD_MAX(RTL8365MB_EFID_MASK);
 	ds->configure_vlan_while_not_filtering = true;
 
 	/* Set up VLAN */
@@ -2527,6 +2577,8 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
+	.port_bridge_join = rtl83xx_port_bridge_join,
+	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_stp_state_set = rtl8365mb_port_stp_state_set,
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
@@ -2546,6 +2598,10 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 
 static const struct realtek_ops rtl8365mb_ops = {
 	.detect = rtl8365mb_detect,
+	.port_add_isolation = rtl8365mb_port_add_isolation,
+	.port_remove_isolation = rtl8365mb_port_remove_isolation,
+	.port_set_efid = rtl8365mb_port_set_efid,
+	.port_set_learning = rtl8365mb_port_set_learning,
 	.phy_read = rtl8365mb_phy_read,
 	.phy_write = rtl8365mb_phy_write,
 };
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 93bc47dfe7f7..ac9222f954ce 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -326,6 +326,156 @@ void rtl83xx_reset_deassert(struct realtek_priv *priv)
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
+		priv->ops->port_remove_isolation(priv, dp->index, BIT(port));
+
+		mask |= BIT(dp->index);
+	}
+
+	/* If we support cascade switches, it should also exclude the
+	 * downstream DSA ports from the isolation group.
+	 */
+
+	priv->ops->port_set_learning(priv, port, false);
+
+	/* Remove those ports from the isolation group of this port */
+	priv->ops->port_remove_isolation(priv, port, mask);
+
+	/* Revert to the default EFID 0 for standalone mode */
+	if (priv->ops->port_set_efid)
+		priv->ops->port_set_efid(priv, port, 0);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_port_bridge_leave, "REALTEK_DSA");
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index c8a0ff8fd75e..2481a1aaa226 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -21,4 +21,11 @@ void rtl83xx_remove(struct realtek_priv *priv);
 void rtl83xx_reset_assert(struct realtek_priv *priv);
 void rtl83xx_reset_deassert(struct realtek_priv *priv);
 
+int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
+			     struct dsa_bridge bridge,
+			     bool *tx_forward_offload,
+			     struct netlink_ext_ack *extack);
+void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
+			       struct dsa_bridge bridge);
+
 #endif /* _RTL83XX_H */

-- 
2.54.0


