Return-Path: <netdev+bounces-307035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DDNKNY2QVGqcnQMAu9opvQ
	(envelope-from <netdev+bounces-307035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1BE747EA1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=jrnNd1rc;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307035-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307035-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D92304C621
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D801369990;
	Mon, 13 Jul 2026 07:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BF368D4B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926699; cv=none; b=qcjISf1VYWSuO0F5xP5NlqCH15zvwWerrhnwkrCctsRDcNdtwa3omIaSYqQuNJSrXcJ7AoAZubHstTBFNdT1lYCiHQJXN9OaJTEz+EqzRPQNwYZ1aVsuDoiLxd++GjhhKNXK3zCMEHE1Tx3ZR2ygPVV/ToGPUT2K4Jd2Omn6zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926699; c=relaxed/simple;
	bh=P5TH9CzfbS5dkSpvlLQ1d15P7EmXyIYvCH7xhBfxBOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzpdrR2e/KqJd4J0T9sEj5Zs0FPe1PtHtlAmqm3D4sp+P+O5+4t2aN77Tlswg1pqQhqj4+M9LPu/uyuqggpDFg3PkhVAgZSr0uXFZHn0/ceQgyp6kGNq+0fsS+twiYNHk/2qxckSrKrDujdsSN522kN6qRuEEOY6HZXhncIzE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jrnNd1rc; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0A7DD4E40D83;
	Mon, 13 Jul 2026 07:11:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D240460341;
	Mon, 13 Jul 2026 07:11:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 491A711BD3A35;
	Mon, 13 Jul 2026 09:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926690; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ix/aq7vTMxcCHYMxpuabfOhDU7m0NOPjq6CDnvxJ/Lc=;
	b=jrnNd1rcHK3Y8edr87+t1F6GUZO3TW0Wtuw2Ahsg+4P6Dn8v/smdQq4zPvUDAkE9GmHLke
	lPPqu7oEHYLIJe7Pu3H4apGsBcoRfgw5CZf1m4E211q3m8WKPdVET25w0HXiRCcfxPSZp7
	x4TxhJFKp5tyJegeZPjGqAGDBkpNIqfxDcGirCF6iV+d4miqMbYnLogN35U+J2pK+bUD+8
	un49Jzb+vGxCUVn0QwaLboJWXOH4zZafKEK7if7WO/ngiy8lfnVJ09Aq6DSdruE339HacE
	ZwdSVO8G5Y4sIlZtWMRzMP+z44kJHATKYvcNReQiaAawoijXLMPRfYzrkLsSDg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:21 +0200
Subject: [PATCH net-next v2 02/10] net: dsa: microchip: split
 ksz8_config_cpu_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-2-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307035-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F1BE747EA1

ksz8_config_cpu_port() is only called twice, once by ksz8_setup() and
once by ksz8463_setup(). It contains a ksz8463 branch that could be
avoided in the ksz8_setup() case and a ksz87xx/ksz88xx branches that
could be avoided in ksz8463_setup() case.

Create ksz8463_config_cpu_port() that only handles the ksz8463 case and
remove the ksz8463 specificities from the common ksz8_config_cpu_port().

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 73 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 5ed63f425013..3bbca6f9cfc5 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2029,6 +2029,50 @@ static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
 		KSZ88X3_PORT3_RMII_CLK_INTERNAL, rmii_clk_internal);
 }
 
+static void ksz8463_config_cpu_port(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *p;
+	u8 fiber_ports = 0;
+	const u32 *masks;
+	const u16 *regs;
+	int i;
+
+	masks = dev->info->masks;
+	regs = dev->info->regs;
+
+	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+
+	ksz8_port_setup(dev, dev->cpu_port, true);
+
+	for (i = 0; i < dev->phy_port_cnt; i++)
+		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
+
+	for (i = 0; i < dev->phy_port_cnt; i++) {
+		p = &dev->ports[i];
+		ksz_port_cfg(dev, i, regs[P_STP_CTRL], PORT_FORCE_FLOW_CTRL,
+			     p->fiber);
+		if (p->fiber)
+			fiber_ports |= (1 << i);
+	}
+
+	/* Setup fiber ports. */
+	if (fiber_ports) {
+		fiber_ports &= 3;
+		regmap_update_bits(ksz_regmap_16(dev), KSZ8463_REG_CFG_CTRL,
+				   fiber_ports << PORT_COPPER_MODE_S,
+				   0);
+		regmap_update_bits(ksz_regmap_16(dev), KSZ8463_REG_DSP_CTRL_6,
+				   COPPER_RECEIVE_ADJUSTMENT, 0);
+	}
+
+	/* Turn off PTP function as the switch enables it by default */
+	regmap_update_bits(ksz_regmap_16(dev), KSZ8463_PTP_MSG_CONF1,
+			   PTP_ENABLE, 0);
+	regmap_update_bits(ksz_regmap_16(dev), KSZ8463_PTP_CLK_CTRL,
+			   PTP_CLK_ENABLE, 0);
+}
+
 static void ksz8_config_cpu_port(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2036,7 +2080,6 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 	const u32 *masks;
 	const u16 *regs;
 	u8 remote;
-	u8 fiber_ports = 0;
 	int i;
 
 	masks = dev->info->masks;
@@ -2067,32 +2110,6 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 		else
 			ksz_port_cfg(dev, i, regs[P_STP_CTRL],
 				     PORT_FORCE_FLOW_CTRL, false);
-		if (p->fiber)
-			fiber_ports |= (1 << i);
-	}
-	if (ksz_is_ksz8463(dev)) {
-		/* Setup fiber ports. */
-		if (fiber_ports) {
-			fiber_ports &= 3;
-			regmap_update_bits(ksz_regmap_16(dev),
-					   KSZ8463_REG_CFG_CTRL,
-					   fiber_ports << PORT_COPPER_MODE_S,
-					   0);
-			regmap_update_bits(ksz_regmap_16(dev),
-					   KSZ8463_REG_DSP_CTRL_6,
-					   COPPER_RECEIVE_ADJUSTMENT, 0);
-		}
-
-		/* Turn off PTP function as the switch's proprietary way of
-		 * handling timestamp is not supported in current Linux PTP
-		 * stack implementation.
-		 */
-		regmap_update_bits(ksz_regmap_16(dev),
-				   KSZ8463_PTP_MSG_CONF1,
-				   PTP_ENABLE, 0);
-		regmap_update_bits(ksz_regmap_16(dev),
-				   KSZ8463_PTP_CLK_CTRL,
-				   PTP_CLK_ENABLE, 0);
 	}
 }
 
@@ -2332,7 +2349,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   storm_mask, storm_rate);
 
-	ksz8_config_cpu_port(ds);
+	ksz8463_config_cpu_port(ds);
 
 	ksz8_enable_stp_addr(dev);
 

-- 
2.54.0


