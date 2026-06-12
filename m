Return-Path: <netdev+bounces-298691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T5p5I40WLGqqLAQAu9opvQ
	(envelope-from <netdev+bounces-298691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D5367A243
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:24:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="T/60w/Zd";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298691-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298691-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E8FA31859B8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0AC3839AD;
	Fri, 12 Jun 2026 14:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDA36A009
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:23:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274186; cv=none; b=pRLuYKbwhrSZJi6XxQOF/UCSRKEfnmcDUVmUPnQN8wgz/VsHyyxx0jACPJmoAAboFPlbxunH+2ckmjSdmvLhJScQFPLZuiykZKE5jFQ/D9gDn4EMqfbpnEQvrF/L51auTAfqhffAksfubDtXsSfMgeaRFuuQtEcNSat3Gb2F4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274186; c=relaxed/simple;
	bh=rluss+5YDR4O0bFwl1cfcSjTU2LkdOqee+ktEHWmYzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLKQihMNLOIFSyB5MZoSEyIOc2OSWXTPqDM2v/cPTNNM3CIQXnspBTHQHKNLxn+NelMkPY99syMQYUubSz5Xt7K/HygIvrnxt5lv0u+R1BJuL98rbpry0+08WDL+4vcnag6Zcx4TL09OOyLnq5VNI3DSjL6GRyfAW0yyvynFQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/60w/Zd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6514E1F000E9;
	Fri, 12 Jun 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274185;
	bh=IL/M+02YLFpX7tAT17TcpAjtwtHVuSc5Ty1oEJtl6JI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T/60w/ZdHcRAQVfXjz/knuD7jZAvRwmciWerNDktpgh4bZm/qOclbHXkoGUQXuGr3
	 DBMNEL0EBXu/2o8JZlDvqVFS9xtH8TkBLK0LW/gPK+OmazH29q0vfDWCt0CSebiFOf
	 YwC6oCas3KBUmdQJh+krB8c2l/eJFUBWXEE0yFuxUoFuS03v4klhY+9bFvBAiR/84I
	 Tq93uE/ELWTyUofdLEfmIVYziHVmftp+eOW+iM450ZCHOWsR+DrJgaDabgDXy0hMM1
	 iXZbCfFGXcllpaP/0AbJX5U1cR84pfUH++PvlJ7xh9vj34ABLl+ZBq7pnVJMHixGB/
	 HfCBvC1P3PXJQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 12 Jun 2026 16:22:51 +0200
Subject: [PATCH net-next 2/4] net: dsa: realtek: rtl8366rb: Use DSA port
 iterators
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-rtl8366rb-improvements-v1-2-9232286fc20c@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-298691-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15D5367A243

Instead of custom loops for intializing the ports (including the
CPU port) use the DSA helpers dsa_switch_for_each_port() and
dsa_switch_for_each_cpu_port() following the pattern in RTL8365MB by
accumulatong masks for the upstream and downstream ports.

This gives us similar enough code to the RTL8365MB that we
can start using more generic rtl83xx helpers.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 49 +++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 8b57ef3bf03a..64215a0d5d6d 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -824,7 +824,10 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
 	const struct rtl8366rb_jam_tbl_entry *jam_table;
+	u32 downports_mask = 0;
 	struct rtl8366rb *rb;
+	u32 upports_mask = 0;
+	struct dsa_port *dp;
 	u32 chip_ver = 0;
 	u32 chip_id = 0;
 	int jam_size;
@@ -895,17 +898,47 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Isolate all user ports so they can only send packets to itself and the CPU port */
-	for (i = 0; i < RTL8366RB_PORT_NUM_CPU; i++) {
-		ret = rtl8366rb_port_set_isolation(priv, i, BIT(RTL8366RB_PORT_NUM_CPU));
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		/* Start with all ports completely isolated */
+		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
+		if (ret)
+			return ret;
+
+		/* Collect CPU ports. If we support cascade switches, it should
+		 * also include the upstream DSA ports.
+		 */
+		if (!dsa_port_is_cpu(dp))
+			continue;
+
+		upports_mask |= BIT(dp->index);
+	}
+
+	/* Configure user ports */
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		/* Forward only to the CPU */
+		ret = rtl8366rb_port_set_isolation(priv, dp->index, upports_mask);
+		if (ret)
+			return ret;
+
+		/* If we support cascade switches, it should also include the
+		 * downstream DSA ports.
+		 */
+		downports_mask |= BIT(dp->index);
+	}
+
+	/* Configure CPU ports. If we support cascade switches, this will also
+	 * include DSA ports.
+	 */
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		/* Forward to all user ports */
+		ret = rtl8366rb_port_set_isolation(priv, dp->index, downports_mask);
 		if (ret)
 			return ret;
 	}
-	/* CPU port can send packets to all ports */
-	ret = rtl8366rb_port_set_isolation(priv, RTL8366RB_PORT_NUM_CPU,
-					   dsa_user_ports(ds));
-	if (ret)
-		return ret;
 
 	/* Set up the "green ethernet" feature */
 	ret = rtl8366rb_jam_table(rtl8366rb_green_jam,

-- 
2.54.0


