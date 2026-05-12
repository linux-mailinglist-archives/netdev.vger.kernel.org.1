Return-Path: <netdev+bounces-287136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPpWGxs0A2oA1gEAu9opvQ
	(envelope-from <netdev+bounces-287136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:07:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB819521F65
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D993207404
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A73A83A0;
	Tue, 12 May 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OVnexRTV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC863A71A1
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591205; cv=none; b=UtiBaHippNbkmfGXgX3PSiuRWqyTeSFlCXR3CQBquuELvkog44fqxCw9WpCOUXaqXn/3x3VfUB68WMJWzc0wbSSxWIYPDN3ECNCWryWyiZRuKlSQ3u99yUs0oxu83RUz4wYb3OWalATBjeeDFcaG4U+Ja3pGihp7UN3PVjbQsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591205; c=relaxed/simple;
	bh=P5cb/SjaUr0s4lFVoqM0dRnXHwfEXlzzATfg0MdfsFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ocDllRvtkx+mx99lA5ARswYQKt5J5DLPGWqaKD6hc47wbICY812MpZ1y8aJY1vjDNutjrWt4FDLJxP73HNwAnmD0D9VukVwv7oXLZ7Ufk+sDy6uZ/jq5kYbFwrpFxdXssE+wM6tH7BL4QCFDqnbaC3/+U1axXw3q+LuMvSEo0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OVnexRTV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 415804E42C19;
	Tue, 12 May 2026 13:06:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0EEE560646;
	Tue, 12 May 2026 13:06:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AA3211AF8CCD;
	Tue, 12 May 2026 15:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591200; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/t2ZMXBql4PpayUhBsLupcYfIHY/7tMm/L5V8tBA7MU=;
	b=OVnexRTVD7ZpUyj45SxE4jcBkwTYGN2wZTbDSMpgTWsrHBMsXm+iBPbWHxAlC8qwT4qyMl
	x9u4+hmbg0T6zLoJf/A50KR1M+X1dWl/+dJ3iVnbbjHAQcmWfYYnT7RjcQYXUGZ754uVZg
	WLgegGtjz+Asqkh1FWU3dHIaIpFrrCUJTJazMZCXDuS3cYg0jyolRO//2o8ZlHZdIq+3UG
	EBaDCuAN7pkomGFSzDwiwzpjDLyrZk5I1zwHT5dUtNYa0uZ51mNmvcq4kmxVQ6d1/McmY6
	2gAfD7IAnDRWQWFgNL1l77asR0wGkdWtQvvAt6/x2lBo0qLqDjbAusEqOZbuAQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:25 +0200
Subject: [PATCH net-next 03/15] net: dsa: microchip: bypass dev_ops for
 change_mtu() operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-3-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: CB819521F65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

MTU changing is done through a common function that redirects the
treatment to a specific ksz_dev_ops callback. This layer of indirection
isn't needed since we now have a dsa_switch_ops struct for each switch
family.

Remove this indirection layer in MTU changing for KSZ switches, by
directly connecting the ksz_dev_ops :: change_mtu() implementations to
dsa_switch_ops.
Remove the no longer used change_mtu() callback from ksz_dev_ops

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 12 +++++-------
 drivers/net/dsa/microchip/ksz9477.c      |  6 +++---
 drivers/net/dsa/microchip/ksz_common.c   | 10 ----------
 drivers/net/dsa/microchip/ksz_common.h   |  2 --
 drivers/net/dsa/microchip/lan937x_main.c |  7 +++----
 5 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 10ab89ff93b65..dd603e7f1a639 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -188,8 +188,9 @@ static int ksz8795_change_mtu(struct ksz_device *dev, int frame_size)
 	return ksz_rmw8(dev, REG_SW_CTRL_2, SW_LEGAL_PACKET_DISABLE, ctrl2);
 }
 
-static int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
+static int ksz8_change_mtu(struct dsa_switch *ds, int port, int mtu)
 {
+	struct ksz_device *dev = ds->priv;
 	u16 frame_size;
 
 	if (!dsa_is_cpu_port(dev->ds, port))
@@ -2226,7 +2227,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
 	.exit = ksz8_switch_exit,
-	.change_mtu = ksz8_change_mtu,
 };
 
 const struct ksz_dev_ops ksz87xx_dev_ops = {
@@ -2257,7 +2257,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
 	.exit = ksz8_switch_exit,
-	.change_mtu = ksz8_change_mtu,
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
 	.pme_pwrite8 = ksz8_pme_pwrite8,
@@ -2291,7 +2290,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
 	.exit = ksz8_switch_exit,
-	.change_mtu = ksz8_change_mtu,
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
 	.pme_pwrite8 = ksz8_pme_pwrite8,
@@ -2332,7 +2330,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz_change_mtu,
+	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
@@ -2392,7 +2390,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz_change_mtu,
+	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
@@ -2452,7 +2450,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz_change_mtu,
+	.port_change_mtu	= ksz8_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 11e6fd1f46ce0..f21a05a86b483 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -45,8 +45,9 @@ static void ksz9477_port_cfg32(struct ksz_device *dev, int port, int offset,
 			   bits, set ? bits : 0);
 }
 
-static int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
+static int ksz9477_change_mtu(struct dsa_switch *ds, int port, int mtu)
 {
+	struct ksz_device *dev = ds->priv;
 	u16 frame_size;
 
 	if (!dsa_is_cpu_port(dev->ds, port))
@@ -1790,7 +1791,6 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.fdb_del = ksz9477_fdb_del,
 	.mdb_add = ksz9477_mdb_add,
 	.mdb_del = ksz9477_mdb_del,
-	.change_mtu = ksz9477_change_mtu,
 	.pme_write8 = ksz_write8,
 	.pme_pread8 = ksz_pread8,
 	.pme_pwrite8 = ksz_pwrite8,
@@ -1839,7 +1839,7 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz_change_mtu,
+	.port_change_mtu	= ksz9477_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index cfca29007e36b..eb13d548ebff9 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3342,16 +3342,6 @@ void ksz_port_mirror_del(struct dsa_switch *ds, int port,
 		dev->dev_ops->mirror_del(dev, port, mirror);
 }
 
-int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (!dev->dev_ops->change_mtu)
-		return -EOPNOTSUPP;
-
-	return dev->dev_ops->change_mtu(dev, port, mtu);
-}
-
 int ksz_max_mtu(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 80b3f2483e36d..0aa83c75c40a1 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -434,7 +434,6 @@ struct ksz_dev_ops {
 		       struct dsa_db db);
 	void (*get_caps)(struct ksz_device *dev, int port,
 			 struct phylink_config *config);
-	int (*change_mtu)(struct ksz_device *dev, int port, int mtu);
 	int (*pme_write8)(struct ksz_device *dev, u32 reg, u8 value);
 	int (*pme_pread8)(struct ksz_device *dev, int port, int offset,
 			  u8 *data);
@@ -545,7 +544,6 @@ int ksz_port_mirror_add(struct dsa_switch *ds, int port,
 			bool ingress, struct netlink_ext_ack *extack);
 void ksz_port_mirror_del(struct dsa_switch *ds, int port,
 			 struct dsa_mall_mirror_tc_entry *mirror);
-int ksz_change_mtu(struct dsa_switch *ds, int port, int mtu);
 int ksz_max_mtu(struct dsa_switch *ds, int port);
 
 bool ksz_support_eee(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 19e444cb0a74a..feaaaafeace61 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -430,9 +430,9 @@ static void lan937x_config_cpu_port(struct dsa_switch *ds)
 	}
 }
 
-static int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
+static int lan937x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 {
-	struct dsa_switch *ds = dev->ds;
+	struct ksz_device *dev = ds->priv;
 	int ret;
 
 	new_mtu += VLAN_ETH_HLEN + ETH_FCS_LEN;
@@ -725,7 +725,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.fdb_del = ksz9477_fdb_del,
 	.mdb_add = ksz9477_mdb_add,
 	.mdb_del = ksz9477_mdb_del,
-	.change_mtu = lan937x_change_mtu,
 	.config_cpu_port = lan937x_config_cpu_port,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
 	.enable_stp_addr = ksz9477_enable_stp_addr,
@@ -770,7 +769,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.port_mirror_del	= ksz_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz_change_mtu,
+	.port_change_mtu	= lan937x_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,

-- 
2.53.0


