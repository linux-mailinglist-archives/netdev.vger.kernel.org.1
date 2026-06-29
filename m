Return-Path: <netdev+bounces-302790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 72POMIy6QmoeAQoAu9opvQ
	(envelope-from <netdev+bounces-302790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F36DE131
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PhKwMIEI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302790-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302790-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE7030534E3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D96396567;
	Mon, 29 Jun 2026 18:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A302396D03
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:32:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757934; cv=none; b=q11UkSJuCpRIS5nnDxv6KjSybVvlhFpcuWAZyWY+U52J535J5Rx0PoZj2XhBFppHb0WOyrYb+8U/U1XhfTl0YVLL/pclM99uZtEcFzmeIS95XW2Xsuc5+gu82t4G/JAj81m/kHGYYaOIS3N70ejklpV0idgJEyLt9q93W+sJlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757934; c=relaxed/simple;
	bh=8V1/+6II2TI5Au9Kfi+GxcdN87odRgJBmz6/IPFP3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSiW9BdRnhSJaMoXJnBhUG4lky0CwfTFIgbsWD59E/ZJXRTXX59LRp97ZQTEjBhatyO1mEjDTMo8XTp2Y5zrJIOdJkkNZ6opa2yQYP8KttN3Xf8VDCWUxjISxUtTbmvpvyl8h6MZE7rP6zZol4hSRQl+F3hCKMw9aeIEn28G3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhKwMIEI; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b965c1c4so1814660b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757932; x=1783362732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sowV28yVt/O0es4KIa9/04Jr+Ql4quyc5zbG9K94W4Q=;
        b=PhKwMIEIaG/yLMBXci5EgbBZHWM70duuNng58qoCKEPcARU4xNWunM4jImIygymVJw
         NzKm6TVPrRB5q16b4lxhuxrVBtALZDMpEP0hACwXET3kqrNVOyNMrTzaZbtrxxxdJV4Q
         xVooACTyxqbwa7g0nD4vkDp+aomD347SmMJLfEKZJv0yegrF5eLFduZj1pF7bPV/fBkw
         S5BbohjEhqw5lUe4t7fNzVImOnBZiG24u/o7p8SBxTFpRD/2y5p5xVU2js3h4l9tD57E
         BFK+i4+Qq1tSYDCoFGxGeNQ7BRrAgGeTSD7JuZccXCicXoNqThY2FNueYzt0P8PHRyU/
         zzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757932; x=1783362732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sowV28yVt/O0es4KIa9/04Jr+Ql4quyc5zbG9K94W4Q=;
        b=H0NqpdcUJlBnbMmHXW0FkSKQYLriLDjWbfBVdGjwKpVqIJHJJg5O4A+mOviBzr6LK6
         1hQubqxMEDxXGv4vIAirCx6kdOXMiqmRxyZepEVNdmsO3UUHPC+bE5cISQSEMay6vek4
         ED259eCtVtuZbwGe5/DD1peZmWWpuijynmNCQOP1rWnmocUmkgFA0g6M2Ck9jM1v8T6O
         PnN/9UqoGq0wr8FnUKE2LOfUIg3bYrGmRyLR9HOif/KU7YOh3GqPw6o+zGqko8eAJSJm
         ghls9gEyRSVFlMgyhmeeVJ0c/uz3iBFLNk4SRrAW7Qqmor6SnRj7kra9XsEEro72ewxB
         qWPg==
X-Gm-Message-State: AOJu0YxUJfa25Io+I9WZHZumdWSzifse1IWYU9qXoIJAFVfj0O2qIIJ7
	QCTjjFzDJoWyOgXuANwFdQ6uL102dhqfjHoZvsK6IgeToaanhQeVPwZtpftOw7g/
X-Gm-Gg: AfdE7cm8utOhjQ1H7yZ5word6OT5bQmQRpUa+NgBWa3U3bi4gw0lr0zOMz1iPzHTr0Z
	kbpJPA2LUlR9tbEb189qXT1g1oBPaMx6Ao9lH7NF5u87A1z+t3VaQr8YXKAKxQw3I+U+gexazmH
	10fe/wBps2HIsZqt2304UdmiI0edIbzoIHzyvhJgOfZcVjhHwb3nmaSqHtAxRU6ZyAjb3Z3VysR
	aKkKdp+Ijte6sEB/7XbF4MySwBNlso5iQSOKZq/bqJOvHpa+Iq4iBgFzRPEp/OcPX5k/Y3m57j3
	/Zvezri8eVBUykrosx0XtKu4MoDCqilBILP5uK4hNf4MvXE/9JnsLHP7e5+H8q8re5H8IydV/n9
	Dd/z1cWqg9HOkExer51kYMqgf3aTc3KOL6v9R3AojmaVz7m5avhmMLVO6JOjOVTUE4Du2Z7J7R2
	e47CsyZLm6H+iM2AzLcNexoMZqTEvTLVoTWvCKQA==
X-Received: by 2002:a05:6a21:62c4:b0:3bf:49c8:f73 with SMTP id adf61e73a8af0-3bfc52b1d7emr550314637.35.1782757932056;
        Mon, 29 Jun 2026 11:32:12 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95aa99sm224754a12.17.2026.06.29.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:32:11 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: dsa: motorcomm: Dynamically allocate port structures
Date: Tue, 30 Jun 2026 02:31:34 +0800
Message-ID: <20260629183137.541341-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629183137.541341-1-mmyangfl@gmail.com>
References: <20260629183137.541341-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail,mib_read.work:server fail];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A1F36DE131

With support for LED introduced later, struct yt921x_priv will be 17k
which is not very good for a single kmalloc(). Convert the ports array
to a array of pointers to stop bloating the priv struct.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 119 +++++++++++++++++++++++--------
 drivers/net/dsa/motorcomm/chip.h |   6 +-
 2 files changed, 94 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 6dee25b6754a..99d3c33e197b 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -548,11 +548,15 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 {
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct device *dev = to_device(priv);
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib *mib;
 	int res = 0;
 
+	if (!pp)
+		return -ENODEV;
+	mib = &pp->mib;
+
 	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
 	 * to keep its consistency, since we have to read registers one by one
 	 * and there is no way to make a snapshot of MIB stats.
@@ -609,9 +613,8 @@ static void yt921x_poll_mib(struct work_struct *work)
 {
 	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
 						    mib_read.work);
-	struct yt921x_priv *priv = (void *)(pp - pp->index) -
-				   offsetof(struct yt921x_priv, ports);
 	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
+	struct yt921x_priv *priv = pp->priv;
 	int port = pp->index;
 	int res;
 
@@ -643,10 +646,14 @@ static void
 yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_mib *mib;
 	size_t j;
 
+	if (!pp)
+		return;
+	mib = &pp->mib;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -685,8 +692,12 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 			     struct ethtool_eth_mac_stats *mac_stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_mib *mib;
+
+	if (!pp)
+		return;
+	mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
@@ -721,8 +732,12 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 			      struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_mib *mib;
+
+	if (!pp)
+		return;
+	mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
@@ -750,8 +765,12 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 			  const struct ethtool_rmon_hist_range **ranges)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_mib *mib;
+
+	if (!pp)
+		return;
+	mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
@@ -786,8 +805,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		       struct rtnl_link_stats64 *stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_mib *mib;
+
+	if (!pp)
+		return;
+	mib = &pp->mib;
 
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
@@ -822,8 +845,12 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 			   struct ethtool_pause_stats *pause_stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_port *pp = priv->ports[port];
+	struct yt921x_mib *mib;
+
+	if (!pp)
+		return;
+	mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
@@ -3332,15 +3359,20 @@ static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
 
 	isolated_mask = 0;
 	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
-		struct yt921x_port *pp = &priv->ports[port];
+		struct yt921x_port *pp = priv->ports[port];
 
+		if (!pp)
+			continue;
 		if (pp->isolated)
 			isolated_mask |= BIT(port);
 	}
 
 	/* Block from non-cpu bridge ports ... */
 	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
-		struct yt921x_port *pp = &priv->ports[port];
+		struct yt921x_port *pp = priv->ports[port];
+
+		if (!pp)
+			continue;
 
 		/* to non-bridge ports */
 		ctrl = ~ports_mask;
@@ -3397,11 +3429,14 @@ static int
 yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
 {
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	bool do_flush;
 	u32 mask;
 	int res;
 
+	if (!pp)
+		return -ENODEV;
+
 	if (flags.mask & BR_LEARNING) {
 		bool learning = flags.val & BR_LEARNING;
 
@@ -3954,11 +3989,16 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_port *pp;
 	int port = dp->index;
 	int res;
 
+	pp = priv->ports[port];
+	if (!pp)
+		return;
+
 	/* No need to sync; port control block is hold until device remove */
-	cancel_delayed_work(&priv->ports[port].mib_read);
+	cancel_delayed_work(&pp->mib_read);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_down(priv, port);
@@ -3977,9 +4017,14 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_port *pp;
 	int port = dp->index;
 	int res;
 
+	pp = priv->ports[port];
+	if (!pp)
+		return;
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_up(priv, port, mode, interface, speed, duplex,
 			     tx_pause, rx_pause);
@@ -3989,7 +4034,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
 			port, res);
 
-	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+	schedule_delayed_work(&pp->mib_read, 0);
 }
 
 static void
@@ -4574,6 +4619,26 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		struct yt921x_port *pp = priv->ports[port];
+
+		if (pp)
+			continue;
+		if (port != YT921X_PORT_MCU &&
+		    !(BIT(port) & (priv->info->internal_mask |
+				   priv->info->external_mask)))
+			continue;
+
+		pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+		priv->ports[port] = pp;
+
+		pp->priv = priv;
+		pp->index = port;
+		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+	}
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_chip_setup(priv);
 	mutex_unlock(&priv->reg_lock);
@@ -4682,7 +4747,10 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 		return;
 
 	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
-		struct yt921x_port *pp = &priv->ports[i];
+		struct yt921x_port *pp = priv->ports[i];
+
+		if (!pp)
+			continue;
 
 		disable_delayed_work_sync(&pp->mib_read);
 	}
@@ -4730,13 +4798,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	priv->reg_ops = &yt921x_reg_ops_mdio;
 	priv->reg_ctx = mdio;
 
-	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
-		struct yt921x_port *pp = &priv->ports[i];
-
-		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
-	}
-
 	ds = &priv->ds;
 	ds->dev = dev;
 	ds->assisted_learning_on_cpu_port = true;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 555046526669..9aecfe7343b8 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -851,7 +851,8 @@ enum yt921x_fdb_entry_status {
 #define YT921X_UDF_NUM		8
 
 /* 8 internal + 2 external + 1 mcu */
-#define YT921X_PORT_NUM			11
+#define YT921X_PORT_NUM		11
+#define YT921X_PORT_MCU		10
 
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
@@ -929,6 +930,7 @@ struct yt921x_acl_blk {
 };
 
 struct yt921x_port {
+	struct yt921x_priv *priv;
 	unsigned char index;
 
 	bool hairpin;
@@ -964,7 +966,7 @@ struct yt921x_priv {
 	struct mii_bus *mbus_int;
 	struct mii_bus *mbus_ext;
 
-	struct yt921x_port ports[YT921X_PORT_NUM];
+	struct yt921x_port *ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
 
-- 
2.53.0


