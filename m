Return-Path: <netdev+bounces-303119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aM4wBR6oQ2qLeQoAu9opvQ
	(envelope-from <netdev+bounces-303119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:27:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B266E3943
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:27:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bLoTbK5B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303119-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303119-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61D6130806AD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74506409101;
	Tue, 30 Jun 2026 11:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B4409114
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:20:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818405; cv=none; b=JGIMmRqZq1CKUBOduHpxZMPiuQFTYcyaGqP+Pjh3e59dkm5t4r/ij8FftYMoCEj3Waw04C4InudKfZB+/54Hnkcn5ysvRi6ymHW+TeIfWgg9cotZJXEURSKCfR+QXSy0gnkxedThRzmT2ao0n7cn8i83oqUYHHx8RjGzX7famT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818405; c=relaxed/simple;
	bh=AidSoGsogda1KqDRwFtomzKagr8WVTJhnTkAOgu5NDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+zwtks5hKyQ4dHn5h4ooVIAixfznCvwurSVL1IYN9Y9au9HbA8gemcE++tW6YtW9TbbFTw8ggHj6IKLOpVS+k9Wvq1iCHROWAUZ5qJ91GXEyEYd0yXB91vVzH2SNwfw72Cci3vybTrxHtO9Gnh7NK48X3wmL1FI8VwxMMCBZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLoTbK5B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3B71F00A3E;
	Tue, 30 Jun 2026 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818404;
	bh=Tryu5sfE4SJHsE1ea3lbZuUgtG+rceiGedIvSLuvS/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bLoTbK5BE8ZpV84e5mKy8oVEpYZyQZq9URIMv9Xpu+HtTpASME+Xhwgsi3wkCTD89
	 eyhbKZp1gCuVG5Z9nHoSZRCGgSJlts3TFLFKnNdG4szq8yH/Q3CcAjcWjKlH0Uo1Nr
	 g/IFz+nrj5lWj7tWnNitwTMyVVaP4sifE537IPrGPPWROxK0qK4v86h/G2LDsR0Ayf
	 i3zU9dTBsmV9irKDNoTevjyfsFFSP+MGC/yQy5K0DBN4R+9nR4HxcAJwluN4iiorDI
	 8FzGuQQATbkjEEPtOsLpo3BPH2WS5xmCoEuBzVq4xOWW6sJSJhXaZHNOjW7UDvokHe
	 vUNe7/v9/sZ9A==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 13:19:45 +0200
Subject: [PATCH net-next v2 5/5] net: dsa: realtek: rtl8366rb: Switch to
 generic learning enablement
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-rtl8366rb-improvements-v2-5-05eb9d6a37f5@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-303119-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79B266E3943

Instead of just writing the learning disablement register in setup
and a custom handling of BR_LEARNING, implement the generic RTL83xx
.port_set_learning() callback for setting learning on a port, and
call this in the per-port loop in .setup().

Instead of the custom rtl83366rb_port_bridge_flags() function for
setting learning mode on each port, use the RTL83xx generic
rtl83xx_port_bridge_flags() callback.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 43 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 155bf0010d5f..d2fa8ff6a5d0 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -854,6 +854,16 @@ rtl8366rb_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	}
 }
 
+static int rtl8366rb_port_set_learning(struct realtek_priv *priv, int port,
+				       bool enable)
+{
+	/* Notice inverted semantics in this register: setting a bit disables
+	 * learning instead of enabling it.
+	 */
+	return regmap_update_bits(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL,
+				  BIT(port), enable ? 0 : BIT(port));
+}
+
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -945,6 +955,11 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		if (ret)
 			return ret;
 
+		/* Disable learning */
+		ret = rtl8366rb_port_set_learning(priv, dp->index, false);
+		if (ret)
+			return ret;
+
 		/* Collect CPU ports. If we support cascade switches, it should
 		 * also include the upstream DSA ports.
 		 */
@@ -1037,12 +1052,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 			rb->max_mtu[i] = ETH_DATA_LEN;
 	}
 
-	/* Disable learning for all ports */
-	ret = regmap_write(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL,
-			   RTL8366RB_PORT_ALL);
-	if (ret)
-		return ret;
-
 	/* Enable auto ageing for all ports */
 	ret = regmap_write(priv->map, RTL8366RB_SECURITY_CTRL, 0);
 	if (ret)
@@ -1341,25 +1350,6 @@ rtl8366rb_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int
-rtl8366rb_port_bridge_flags(struct dsa_switch *ds, int port,
-			    struct switchdev_brport_flags flags,
-			    struct netlink_ext_ack *extack)
-{
-	struct realtek_priv *priv = ds->priv;
-	int ret;
-
-	if (flags.mask & BR_LEARNING) {
-		ret = regmap_update_bits(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL,
-					 BIT(port),
-					 (flags.val & BR_LEARNING) ? 0 : BIT(port));
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static void
 rtl8366rb_port_fast_age(struct dsa_switch *ds, int port)
 {
@@ -1810,7 +1800,7 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.port_enable = rtl8366rb_port_enable,
 	.port_disable = rtl8366rb_port_disable,
 	.port_pre_bridge_flags = rtl8366rb_port_pre_bridge_flags,
-	.port_bridge_flags = rtl8366rb_port_bridge_flags,
+	.port_bridge_flags = rtl83xx_port_bridge_flags,
 	.port_stp_state_set = rtl8366rb_port_stp_state_set,
 	.port_fast_age = rtl8366rb_port_fast_age,
 	.port_change_mtu = rtl8366rb_change_mtu,
@@ -1833,6 +1823,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 	.enable_vlan4k	= rtl8366rb_enable_vlan4k,
 	.port_add_isolation = rtl8366rb_port_add_isolation,
 	.port_remove_isolation = rtl8366rb_port_remove_isolation,
+	.port_set_learning = rtl8366rb_port_set_learning,
 	.phy_read	= rtl8366rb_phy_read,
 	.phy_write	= rtl8366rb_phy_write,
 };

-- 
2.54.0


