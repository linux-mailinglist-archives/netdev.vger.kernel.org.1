Return-Path: <netdev+bounces-303115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M+EIEUKpQ2rqeQoAu9opvQ
	(envelope-from <netdev+bounces-303115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EE76E3A1C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:32:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="CKY49s/g";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303115-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4778E304774E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43433E3C5A;
	Tue, 30 Jun 2026 11:19:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B93EA962
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:19:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818393; cv=none; b=IS7Dg54Sn9rYTwueFTKpmREzr0tED9ADVf3bst/6Qu7hjJxsoGAauYs+iK37dAv5SN052qxCqZVhXEJhCUeolLmww9HP/rdAQuxTHvtMWUoLIQkas7VNHYb0yRMOUzEJutsbOX5Hz1Ovr79FtSkswOKpJKP7MSG4ZXnfzSkRhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818393; c=relaxed/simple;
	bh=9SQSa2lndL91crLT50aovAsfxh0Gj2zHfRJAMccp9ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dV5g7Zbt4eCv7z/zEZISlyfdkx1K9cmxw6CgDhlCj1ZminoYwbZtWHPWxxINW8U3eciGA39MfU4lYciTJmJkfjqtuvUFM4B1xIubG4ys4ff9zEC2UigT+ciK9zK06FHvDiaoFHKZUXHbkZ0Qyq4A/TCMjzfwOGPOIPuSAsASGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKY49s/g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E01F00A3A;
	Tue, 30 Jun 2026 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818392;
	bh=WXMm0GByJ8ckgmNhY27Iw1au8xjrtbDfFsApmsKjXWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CKY49s/gJpkGE2KiUoDx9XjwZbrnYMxoFfchm/AWEUfQWPPB8fyi9m0K600e7FFe1
	 xzzXGc5rbPx1DiVWhfVqoPIHipiJivgvp8SFUQdsxpP6ZKRq8Fbu7xtO10O/UGeOfW
	 Ydpl1dPLQ2c4xOqA17LFmHNbwnWHx7C1FbFoiXpQiHmfCWzbeSmgWVwxKgSRUU7dCT
	 Z52NdzEEKIutqeXt/T7X4GVYXW3qPAWWhoqyAxgCE9v+bSxSIXMVE3t9LExPDn3i7i
	 Ri9oSLQtJa5TCGtZwec5zc5D4TL0K1SVtINHFY0zGZmuXlcK1qE5USikLlwLtW+0XC
	 kS4GMd2WNdYVA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 13:19:41 +0200
Subject: [PATCH net-next v2 1/5] net: dsa: realtek: rtl83xx: Make learning
 optional in join/leave
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-rtl8366rb-improvements-v2-1-05eb9d6a37f5@kernel.org>
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-303115-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37EE76E3A1C

Mostly to make it possible to add rtl83xx support piece by piece,
make the port learning callback optional in rtl83xx_port_bridge_join()
and rtl83xx_port_bridge_leave().

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl83xx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 71124ecca92f..90843d52c5a8 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -356,9 +356,6 @@ int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
 	if (!priv->ops->port_add_isolation)
 		return -EOPNOTSUPP;
 
-	if (!priv->ops->port_set_learning)
-		return -EOPNOTSUPP;
-
 	dev_dbg(priv->dev, "bridge %d join port %d\n", bridge.num, port);
 
 	/* Add this port to the isolation group of every other port
@@ -396,9 +393,11 @@ int rtl83xx_port_bridge_join(struct dsa_switch *ds, int port,
 			goto undo_self_isolation;
 	}
 
-	ret = priv->ops->port_set_learning(priv, port, true);
-	if (ret)
-		goto undo_efid;
+	if (priv->ops->port_set_learning) {
+		ret = priv->ops->port_set_learning(priv, port, true);
+		if (ret)
+			goto undo_efid;
+	}
 
 	return 0;
 
@@ -443,9 +442,6 @@ void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
 	if (!priv->ops->port_remove_isolation)
 		return;
 
-	if (!priv->ops->port_set_learning)
-		return;
-
 	dev_dbg(priv->dev, "bridge %d leave port %d\n", bridge.num, port);
 
 	/* Remove this port from the isolation group of every other
@@ -474,11 +470,13 @@ void rtl83xx_port_bridge_leave(struct dsa_switch *ds, int port,
 	 * downstream DSA ports from the isolation group.
 	 */
 
-	ret = priv->ops->port_set_learning(priv, port, false);
-	if (ret)
-		dev_err(priv->dev,
-			"failed to disable learning on port %d: %pe\n",
-			port, ERR_PTR(ret));
+	if (priv->ops->port_set_learning) {
+		ret = priv->ops->port_set_learning(priv, port, false);
+		if (ret)
+			dev_err(priv->dev,
+				"failed to disable learning on port %d: %pe\n",
+				port, ERR_PTR(ret));
+	}
 
 	/* Remove those ports from the isolation group of this port */
 	ret = priv->ops->port_remove_isolation(priv, port, mask);

-- 
2.54.0


