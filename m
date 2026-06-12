Return-Path: <netdev+bounces-298692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pLIAJp4WLGqwLAQAu9opvQ
	(envelope-from <netdev+bounces-298692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:24:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5AF67A246
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:24:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cv3g0Tg1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298692-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298692-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC8EE318B78B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C485C3839AD;
	Fri, 12 Jun 2026 14:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472336A009
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274189; cv=none; b=GhhowXBWLwpIPvpVSvZue9EfIVscD30XR68Q/maYk8+kZ/scJB6OWdlqtEoJPpIGJzE0cMZvfIcPhJoOQrBDPZ+J4vSOJCZDDPwnVTM2NsYZ2P/WjGs48K3wkcWGR8r4QTKkc+95ElIIF1ob6lNb0mpWE4Txs/kfRujpc/aVBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274189; c=relaxed/simple;
	bh=ZlCilVCFuNTSzQuhC3uOTZ2K2TehxYjvEW1U8TLtYFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlDb+1i4qsiUowHr5cCQ6bKp+g04R70GQWcY4CLDVfSRPtmsaCsPtZ97jRCUskXfuAmhc66qB+e4ykK+IB9DnX9LoEnOSUNWkTy2YvEYth7mOmA7qkDmnkq9AvHh8QvR4ODmLqh2+cDkgZgpBYuLVmX8vPvy/C5yLB3i4WwuhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv3g0Tg1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBEA1F00A3A;
	Fri, 12 Jun 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274188;
	bh=op2/MKJpjXPN+W1svG4CW0inGTk6ACXTbxEGTnVwzTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cv3g0Tg16SXQbGkGaLJR6/zTiJU5Ky58reCBlG4ppv4naUa80T/Hw0bJ6Ax2mW96E
	 OFuANentsj6KKoavwpi/Sdo/Ti+BlYQtJ3lCUPOLRf6hWrNxP6qVjGHIMm+K7tZGjr
	 5EZoITQMnngLK1Pe405S+OYzJKVIc3D+HZSEYtw5HYfL1jmvxh1WhmlBAem6d6ucq6
	 eXg2GYbSz05e/F85GWSRx+EnsiKOpw/HOIsEWuOcd8BiWvHmcJyCnCdMSzNks6IrT4
	 0rXOfPV1h0deZpJtiEvVDxHSlL6r7j+uZAfvCchw9EmflZQ7BkarBjpfIwYdeRFou2
	 1KFSdyHTYbZMA==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 12 Jun 2026 16:22:52 +0200
Subject: [PATCH net-next 3/4] net: dsa: realtek: rtl8366rb: Disable STP
 learning on all ports in setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-rtl8366rb-improvements-v1-3-9232286fc20c@kernel.org>
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org>
In-Reply-To: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bang-olufsen.dk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298692-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D5AF67A246

When we loop over all ports in the switch .setup() callback,
make sure to disable learning on all user ports. This is what
is normally expected and what the RTL8365MB is doing.

Move the code around to accommodate for the new call.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 74 ++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 64215a0d5d6d..155bf0010d5f 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -820,6 +820,40 @@ static int rtl8366rb_port_remove_isolation(struct realtek_priv *priv, int port,
 				  RTL8366RB_PORT_ISO_PORTS(mask), 0);
 }
 
+static void
+rtl8366rb_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct realtek_priv *priv = ds->priv;
+	u32 val;
+	int i;
+
+	switch (state) {
+	case BR_STATE_DISABLED:
+		val = RTL8366RB_STP_STATE_DISABLED;
+		break;
+	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
+		val = RTL8366RB_STP_STATE_BLOCKING;
+		break;
+	case BR_STATE_LEARNING:
+		val = RTL8366RB_STP_STATE_LEARNING;
+		break;
+	case BR_STATE_FORWARDING:
+		val = RTL8366RB_STP_STATE_FORWARDING;
+		break;
+	default:
+		dev_err(priv->dev, "unknown bridge state requested\n");
+		return;
+	}
+
+	/* Set the same status for the port on all the FIDs */
+	for (i = 0; i < RTL8366RB_NUM_FIDS; i++) {
+		regmap_update_bits(priv->map, RTL8366RB_STP_STATE_BASE + i,
+				   RTL8366RB_STP_STATE_MASK(port),
+				   RTL8366RB_STP_STATE(port, val));
+	}
+}
+
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -900,6 +934,12 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 
 	/* Start with all ports blocked, including unused ports */
 	dsa_switch_for_each_port(dp, ds) {
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8366rb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
+
 		/* Start with all ports completely isolated */
 		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
 		if (ret)
@@ -1320,40 +1360,6 @@ rtl8366rb_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static void
-rtl8366rb_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
-{
-	struct realtek_priv *priv = ds->priv;
-	u32 val;
-	int i;
-
-	switch (state) {
-	case BR_STATE_DISABLED:
-		val = RTL8366RB_STP_STATE_DISABLED;
-		break;
-	case BR_STATE_BLOCKING:
-	case BR_STATE_LISTENING:
-		val = RTL8366RB_STP_STATE_BLOCKING;
-		break;
-	case BR_STATE_LEARNING:
-		val = RTL8366RB_STP_STATE_LEARNING;
-		break;
-	case BR_STATE_FORWARDING:
-		val = RTL8366RB_STP_STATE_FORWARDING;
-		break;
-	default:
-		dev_err(priv->dev, "unknown bridge state requested\n");
-		return;
-	}
-
-	/* Set the same status for the port on all the FIDs */
-	for (i = 0; i < RTL8366RB_NUM_FIDS; i++) {
-		regmap_update_bits(priv->map, RTL8366RB_STP_STATE_BASE + i,
-				   RTL8366RB_STP_STATE_MASK(port),
-				   RTL8366RB_STP_STATE(port, val));
-	}
-}
-
 static void
 rtl8366rb_port_fast_age(struct dsa_switch *ds, int port)
 {

-- 
2.54.0


