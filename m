Return-Path: <netdev+bounces-298871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cdd0I9WuLGrWVQQAu9opvQ
	(envelope-from <netdev+bounces-298871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:13:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA767D6CE
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298871-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298871-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AE0B301AF20
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E902620DE;
	Sat, 13 Jun 2026 01:11:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF81DDC1B;
	Sat, 13 Jun 2026 01:11:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313114; cv=none; b=AE9uIx/fDNN645WC+pgnwbYLsGtIcS743RQw0spIG0wED/2mKWMuJRJ2YFdzYjUAAD+/3FYBjNxhSPw4gfICGYKKfqYY3aDiXruAjxCxAjYaZWRzo9yO+SJ7p90hbS6nFk7i07d2N9hydnPV/7Qt5lf4SAcDt5az9BBOJyDlSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313114; c=relaxed/simple;
	bh=1Te8BP1iWT8QcjludWx5mT0shlRl2rRcP0tM7hxSFfA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpGvTmmzWZYDzpQ0ObKjyxcJvGXdaKID0zhjNsIDH+nQH/QEuvHf89HJUbNgZXb4bfJvNUkfbEy8au1RBR06GyuXCESS5CMjcPJByrDefXbGl+4MpIhgkJ31RQfNFxDOMvOUdEnwWpD1ztxK/4uSekuCLwG0aBJwHaWQ6W8LHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYCuZ-000000007ND-3RCH;
	Sat, 13 Jun 2026 01:11:47 +0000
Date: Sat, 13 Jun 2026 02:11:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 8/8] net: dsa: mt7530: implement
 port_change_conduit op
Message-ID: <8dd8cfe32bc8e38b92c49e30a6255090fb0998fb.1781312667.git.daniel@makrotopia.org>
References: <cover.1781312667.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781312667.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298871-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[arinc9.com,makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,makrotopia.org:email,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93AA767D6CE

Allow changing the CPU port affinity of user ports at runtime via the
IFLA_DSA_CONDUIT netlink attribute. This updates the port matrix to
forward to the new CPU port instead of the old one.

Limit the operation to MT7531. There, trapped link-local frames follow
the per-port affinity, as the MT7531_CPU_PMAP destination mask is
further restricted by the port matrix. A conduit change is hence fully
honoured by the hardware, for regular traffic as well as for trapped
frames.

The MT7530 switch, including the variant embedded in the MT7621 SoC,
instead traps frames to the single CPU port set in the CPU_PORT field
of the MFC register, regardless of the affinity of the inbound user
port. With user ports affine to different CPU ports there is no
correct value for that field, so per-port CPU affinity cannot be fully
implemented for trapped frames. Routing a WAN port via the second SoC
GMAC is conventionally covered by the PHY muxing feature on these
switches, which bypasses the switch fabric and does not involve a CPU
port at all.

The switches on the MT7988, EN7581 and AN7583 SoCs only have a
single CPU port, leaving no other conduit to change to.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: extend commit message

 drivers/net/dsa/mt7530.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index c96420c291d5..2f3e734b9f53 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3206,6 +3206,34 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt753x_port_change_conduit(struct dsa_switch *ds, int port,
+			   struct net_device *conduit,
+			   struct netlink_ext_ack *extack)
+{
+	struct dsa_port *new_cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct mt7530_priv *priv = ds->priv;
+
+	if (priv->id != ID_MT7531)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&priv->reg_mutex);
+
+	/* dp->cpu_dp still points to the old CPU port */
+	priv->ports[port].pm &= ~PCR_MATRIX(BIT(dp->cpu_dp->index));
+	priv->ports[port].pm |= PCR_MATRIX(BIT(new_cpu_dp->index));
+	if (priv->ports[port].enable)
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+				   PCR_MATRIX_MASK, priv->ports[port].pm);
+
+	mutex_unlock(&priv->reg_mutex);
+
+	mt7530_port_fast_age(ds, port);
+
+	return 0;
+}
+
 static void
 mt753x_conduit_state_change(struct dsa_switch *ds,
 			    const struct net_device *conduit,
@@ -3317,6 +3345,7 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
 	.setup			= mt753x_setup,
 	.teardown		= mt753x_teardown,
 	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
+	.port_change_conduit	= mt753x_port_change_conduit,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
-- 
2.54.0

