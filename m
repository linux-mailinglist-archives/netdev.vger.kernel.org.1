Return-Path: <netdev+bounces-300533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tHAuBB9VNGptVAYAu9opvQ
	(envelope-from <netdev+bounces-300533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 508066A2893
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BnqO1XVW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300533-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300533-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD4F63068906
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD934CFC2;
	Thu, 18 Jun 2026 20:27:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEC348886
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 20:27:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814465; cv=none; b=hzg+hoe6MzsuTC4kuy0bFlbRXtF9fAct0z+Ga0LWj1myUlZC4O+JrS9e2cri82Dci4cKx/uVqs+tFW78NqkZDCX4HOQtkLRW1iQpzJBOTTDK3DGrr3WmcOq2FXDdPcToTtiKYELFYiFSeaAjc8aiao3vzJd7DCnCAlBk9YoMeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814465; c=relaxed/simple;
	bh=cQb83nzma77f5jVycxwjFQGG8/RUV9DbAldYk3ZVTyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhrWJxFassPxORZc8Id7MS9tvcnH4tfNTcjdapYIJeHSIS7lBvTDjXont4V11H6V14h5GwUulnyHiLOxbjb5ZpDx43qMGeXc2ILQNrVMihzCFC5VwuZV51pG1QcGgAzLSKDynCrwp2lnc9Vgd6foVw+vjfrJO0w/TepmpAtvxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnqO1XVW; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84536e2857eso990652b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814463; x=1782419263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Cxc3eqfUfVomReKEfvMWsuz23pqV3FLMBJ4q65cog=;
        b=BnqO1XVW2tPVsIcSdjqALkd65gPFbB3egvbsKQrir940f8lrbnrKT6H5Lk0gghnjeY
         FwqopXsrsOYLmFVjg0cziB8JG3CFmCgSLklnVpfN+CShdC5Wrxg0J4UtzS9UX9ud6fFn
         oy+8PMR28MV1+VqIux9LoL5LPVSO/L8NCmj9e/vRobAIaxTaCZ22Wr7QLhDaUB/Q5c2I
         issFRk00OyA8VBeS4Xj0nv6lJjqA8GVeNo8holPq2U6hvKGmf1RaBXrefp3vNlUUKszX
         xEzi3BkqnpOJrDg19WpTL6oDkxi3zrnhpzc1MiWXEXFG40SQTcIdcvELIxpJkHRJF5BS
         xrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814463; x=1782419263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4Cxc3eqfUfVomReKEfvMWsuz23pqV3FLMBJ4q65cog=;
        b=BfdKD4QJMY9OMKq2Tw/hG/AgSTtq6pn/E8GaFYnSiQt1vyTRbPy75BbzRycnMi7v/G
         KAH//VX9Wf8o933h6umMWajJY+PydDbyrELvI7OvPE+VniM9UN1e96/WJQ4g2026T45g
         onLRqKwx9pXfzA7sM1QEV1+kC4cEc+kilbfDyeI1/eCvSAReyR9ybDAA2CcYylfqqvWv
         npVlnvG1dUZrg1UMUdCj/bQMWuwtYDL040+R7pTyJrsz5YirpgflDdWGRDP3ijxg8H1U
         qediYfqiivz0VYSLNvteQbikVqgGrCCQ2ct7nmXk9McYnpdtQ6UlzQqkI+f7Uu2UYJAh
         JnjA==
X-Gm-Message-State: AOJu0YydVbxKt6bmLh3o03e4EHoRphHN+ZDC5kUZDfIxvW08zSnuGNWU
	ImJXOLpiQMKJwFqjMP3DQDxqdEFmgK5rzJL45MQE82X+Ck6Nm3vWJ1OYjvS5i+Qr
X-Gm-Gg: AfdE7cnFb2AdUyf3PH81Ex456ezDvQ0iftj4+uJsbNR38AMls2i3kroTeWBPUsfE+7v
	oETfcz89AFqY4SmrzYVD/xF3LIz2Vd0P2PFoYra1/TembbjtmFLqJ4JIUuTHNL2Fv5DnZe6VNAO
	eGweIaVFul1tU4dkHXR2f+LTjgHVQ9qYTyRvA2IXK2tDqemsGqqN2rHZDPMnh91uJfWUNyRpYCO
	0Nj9dGR3nV+7eOk+FQbcWtRJIO24nz9DtwobhMmwnj+GVhqfAgiBXc59VDrJ1FZo1CB/esrfaAo
	WE8fbKvL31ljH4x5T7PdG/99F1PBCPRYsBYyBQmNOUWbvYkCGsHgteEjtyhYQun869kCPHHkbZ2
	0XCrEpPT09FHzLeZxF0zESSxibUyQKNfgmklPrSrbHNBXpBTuuQfVyPhjWXkHtmgK8fXSLU7jlg
	wiKlH1krwM3qY6tcMoQxt+3TRcfwUgSJUXrTg6DnFQy2X6o2dGd2Q=
X-Received: by 2002:a05:6a00:124f:b0:845:31a6:d84c with SMTP id d2e1a72fcca58-8455087488cmr574357b3a.26.1781814463160;
        Thu, 18 Jun 2026 13:27:43 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845536758ddsm3590b3a.15.2026.06.18.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:27:42 -0700 (PDT)
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
Subject: [RFC net-next 3/4] net: dsa: motorcomm: Dynamically allocate port structures
Date: Fri, 19 Jun 2026 04:26:31 +0800
Message-ID: <20260618202716.2166450-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618202716.2166450-1-mmyangfl@gmail.com>
References: <20260618202716.2166450-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300533-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 508066A2893

With support for LED introduced later, struct yt921x_priv will be 17k
which is not very good for a single kmalloc(). Convert the ports array
to a array of pointers to stop bloating the priv struct.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 95 ++++++++++++++++++++++++--------
 drivers/net/dsa/motorcomm/chip.h |  3 +-
 2 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 6dee25b6754a..d44f7749de02 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -548,11 +548,14 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 {
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct device *dev = to_device(priv);
 	struct yt921x_mib *mib = &pp->mib;
 	int res = 0;
 
+	if (!pp)
+		return -ENODEV;
+
 	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
 	 * to keep its consistency, since we have to read registers one by one
 	 * and there is no way to make a snapshot of MIB stats.
@@ -609,9 +612,8 @@ static void yt921x_poll_mib(struct work_struct *work)
 {
 	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
 						    mib_read.work);
-	struct yt921x_priv *priv = (void *)(pp - pp->index) -
-				   offsetof(struct yt921x_priv, ports);
 	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
+	struct yt921x_priv *priv = pp->priv;
 	int port = pp->index;
 	int res;
 
@@ -643,10 +645,13 @@ static void
 yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 	size_t j;
 
+	if (!pp)
+		return;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -685,9 +690,12 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 			     struct ethtool_eth_mac_stats *mac_stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	if (!pp)
+		return;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -721,9 +729,12 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 			      struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	if (!pp)
+		return;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -750,9 +761,12 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 			  const struct ethtool_rmon_hist_range **ranges)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	if (!pp)
+		return;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -786,9 +800,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		       struct rtnl_link_stats64 *stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	if (!pp)
+		return;
+
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
 	stats->rx_over_errors = mib->rx_oversize_errors;
@@ -822,9 +839,12 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 			   struct ethtool_pause_stats *pause_stats)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_port *pp = priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	if (!pp)
+		return;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -3332,15 +3352,20 @@ static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
 
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
@@ -3397,11 +3422,14 @@ static int
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
 
@@ -3954,11 +3982,16 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
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
@@ -3977,9 +4010,14 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
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
@@ -3989,7 +4027,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
 			port, res);
 
-	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+	schedule_delayed_work(&pp->mib_read, 0);
 }
 
 static void
@@ -4574,6 +4612,23 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
+	for (int port = 0; port < YT921X_PORT_NUM; port++) {
+		struct yt921x_port *pp;
+
+		if (!(BIT(port) & (priv->info->internal_mask |
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
@@ -4682,7 +4737,10 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 		return;
 
 	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
-		struct yt921x_port *pp = &priv->ports[i];
+		struct yt921x_port *pp = priv->ports[i];
+
+		if (!pp)
+			continue;
 
 		disable_delayed_work_sync(&pp->mib_read);
 	}
@@ -4730,13 +4788,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
index 555046526669..950a5799f8b6 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -929,6 +929,7 @@ struct yt921x_acl_blk {
 };
 
 struct yt921x_port {
+	struct yt921x_priv *priv;
 	unsigned char index;
 
 	bool hairpin;
@@ -964,7 +965,7 @@ struct yt921x_priv {
 	struct mii_bus *mbus_int;
 	struct mii_bus *mbus_ext;
 
-	struct yt921x_port ports[YT921X_PORT_NUM];
+	struct yt921x_port *ports[YT921X_PORT_NUM];
 
 	u16 eee_ports_mask;
 
-- 
2.53.0


