Return-Path: <netdev+bounces-307306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 67L4EzaIVWrwpgAAu9opvQ
	(envelope-from <netdev+bounces-307306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:52:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19574FED2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3757E300C7E0
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB5242910;
	Tue, 14 Jul 2026 00:51:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E719CCF5;
	Tue, 14 Jul 2026 00:51:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990288; cv=none; b=tbU2OLrERU8jc6mznjVKTiinjO/dTyVg0Neq0FgntUFJ31j3aWQIbAlf0AZgF3uirOAwbDcVaM/A+JE+aDnK/0QF7G6GgiioaoeHZWc3jWfCrYJtGffDndDggUTN6ZvVSOGEA3Z2I7UXgGHhsRN79RkOKiNo7aTygmRHYwXdkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990288; c=relaxed/simple;
	bh=BM9c6hMTpnL4QX8zUI+ike6CH7iodewiwLYQlCvNsyY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgaYu8PV8fswZ/w6h3/XAI9NnwO+wra50xtGWqUuqxLHDbjNnTHjYdJCuwSdyVIp81+aREhxEF9ARZoOjuY15N4ukFupMagKLBpppLc4FX7sOxwiXRA4Rb6r6QKHrCSCI1lL3Kl2XAxR743TVk6Y4to6OGkUpyJZI+peNujcAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wjRMp-000000001rn-1yPE;
	Tue, 14 Jul 2026 00:51:23 +0000
Date: Tue, 14 Jul 2026 01:51:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: dsa: mxl862xx: recover switch stuck in
 MCUboot rescue mode
Message-ID: <5ba0bcb7857b3feab1a754ce0a7daa5b3f240801.1783988826.git.daniel@makrotopia.org>
References: <cover.1783988826.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783988826.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,makrotopia.org:from_mime,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C19574FED2

When the application firmware image is broken (e.g. after an
interrupted flash update) or the sticky rescue flag is set, the
switch stays in MCUboot which only exposes the clause-22 SMDIO
interface used for firmware download. The clause-45 MMD API never
becomes ready, probe fails with -ETIMEDOUT and the user is left
without any way to install a working firmware image other than
physical access to the UART console of the switch.

Detect this state during setup by reading the SB PDI STAT register
via SMDIO: MCUboot signals readiness for a firmware download with
the ready magic. Probe this register first to avoid pointlessly
waiting for the MMD API on a switch sitting in rescue mode, and
probe it again after a ready timeout to catch firmware which was
still alive enough to accept the reset command but then fell into
rescue mode due to a broken image on flash.

In rescue mode, complete the switch registration without any user
interfaces so that devlink is available: user ports fail port_setup
with -ENODEV which makes the DSA core re-register them as unused
ports, while shared and unused ports succeed as their setup must not
fail for the tree to register. The CPU port works without firmware
access since it uses a fixed link and the phylink MAC ops do not
touch the hardware; mac_select_pcs returns no PCS in rescue mode.
Firmware API commands fail fast with -ENODEV instead of running
into the MDIO poll timeout, and the port enable/disable and STP
callbacks invoked by the DSA core during registration and teardown
become no-ops.

devlink dev info reports the running firmware version as
"mcuboot-rescue" so the state can be told apart from an operational
switch. devlink flash update skips the FW_UPDATE command in rescue
mode as MCUboot is already waiting for a download, and proceeds
directly with the SB PDI handshake. After a successful transfer the
usual reprobe cycle restores normal operation; after a failed one
rescue mode is detected again and the user can simply retry.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch, allowing recovery from a failed or interrupted update
    without physical access to the switch (Andrew Lunn)

 drivers/net/dsa/mxl862xx/mxl862xx-fw.c      | 49 ++++++++++++++++-----
 drivers/net/dsa/mxl862xx/mxl862xx-fw.h      |  3 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.c    |  3 ++
 drivers/net/dsa/mxl862xx/mxl862xx-phylink.c |  2 +
 drivers/net/dsa/mxl862xx/mxl862xx.c         | 38 ++++++++++++++--
 drivers/net/dsa/mxl862xx/mxl862xx.h         |  3 ++
 6 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
index b2c23ccf1370..88d53bea336f 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
@@ -92,6 +92,24 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
 	devlink_flash_update_status_notify(dl, status, NULL, done, total);
 }
 
+/**
+ * mxl862xx_rescue_mode_detect - check whether the switch sits in MCUboot
+ * @priv: driver private data
+ *
+ * MCUboot signals readiness for a firmware download with the SB PDI
+ * ready magic; only the clause-22 SMDIO interface works in this state.
+ *
+ * Return: true if MCUboot is waiting for a firmware download.
+ */
+bool mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv)
+{
+	int ret;
+
+	ret = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
+
+	return ret == MXL862XX_SB_PDI_READY;
+}
+
 /* device_reprobe() -> remove() frees priv while the work runs, so
  * the work struct cannot live in mxl862xx_priv.
  */
@@ -172,13 +190,15 @@ static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
 	}
 
 	/* Step 1: reboot the firmware into MCUboot rescue mode */
-	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
-				false, false);
-	if (ret) {
-		dev_err(&priv->mdiodev->dev,
-			"flash: FW_UPDATE command failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
+	if (!priv->rescue_mode) {
+		ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
+					false, false);
+		if (ret) {
+			dev_err(&priv->mdiodev->dev,
+				"flash: FW_UPDATE command failed: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
 	}
 
 	/* Failures from here on must go through end_magic so MCUboot
@@ -328,6 +348,10 @@ int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 			return ret;
 	}
 
+	if (priv->rescue_mode)
+		return devlink_info_version_running_put(req, "fw",
+							"mcuboot-rescue");
+
 	snprintf(ver_str, sizeof(ver_str), "%u.%u.%u",
 		 priv->fw_version.major, priv->fw_version.minor,
 		 priv->fw_version.revision);
@@ -350,9 +374,13 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 		return -EOPNOTSUPP;
 	}
 
-	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
-		 priv->fw_version.major, priv->fw_version.minor,
-		 priv->fw_version.revision);
+	if (priv->rescue_mode)
+		dev_info(ds->dev,
+			 "flash: recovering switch from MCUboot rescue mode\n");
+	else
+		dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
+			 priv->fw_version.major, priv->fw_version.minor,
+			 priv->fw_version.revision);
 
 	/* Close ports while the firmware is still alive so the DSA
 	 * core's MDB/FDB tracking is drained, and detach user ports
@@ -383,6 +411,7 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
 	if (!ret) {
 		/* lift the block to query the new firmware version */
 		priv->block_host = false;
+		priv->rescue_mode = false;
 		memset(&ver, 0, sizeof(ver));
 		if (!MXL862XX_API_READ_QUIET(priv, SYS_MISC_FW_VERSION, ver) &&
 		    ver.iv_major)
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
index a1b60fbacebf..57c2000cfee5 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.h
@@ -5,6 +5,9 @@
 
 #include <net/dsa.h>
 
+struct mxl862xx_priv;
+
+bool mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv);
 int mxl862xx_devlink_info_get(struct dsa_switch *ds,
 			      struct devlink_info_req *req,
 			      struct netlink_ext_ack *extack);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 7ba984e94d82..d6c0cdfa0e68 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -340,6 +340,9 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	if (priv->skip_teardown)
 		return 0;
 
+	if (priv->rescue_mode)
+		return -ENODEV;
+
 	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE)
 		return -EBUSY;
 
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
index b689652aa9b9..a5b6940b552e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
@@ -406,6 +406,8 @@ mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
 
 	switch (port) {
 	case 9 ... 16:
+		if (priv->rescue_mode)
+			return NULL;
 		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84)) {
 			dev_warn_once(dp->ds->dev,
 				      "SerDes PCS unsupported on old firmware.\n");
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index e643083d3938..b7385cfa5474 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -629,9 +629,22 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	ret = mxl862xx_wait_ready(ds);
-	if (ret)
-		return ret;
+	priv->rescue_mode = mxl862xx_rescue_mode_detect(priv);
+	if (!priv->rescue_mode) {
+		ret = mxl862xx_wait_ready(ds);
+		if (ret) {
+			/* the reset may only now have triggered rescue mode */
+			priv->rescue_mode = mxl862xx_rescue_mode_detect(priv);
+			if (!priv->rescue_mode)
+				return ret;
+		}
+	}
+
+	if (priv->rescue_mode) {
+		dev_warn(ds->dev,
+			 "switch stuck in MCUboot rescue mode, use devlink to flash new firmware\n");
+		return 0;
+	}
 
 	mutex_init(&priv->serdes_lock);
 	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
@@ -716,11 +729,21 @@ static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
 static int mxl862xx_port_enable(struct dsa_switch *ds, int port,
 				struct phy_device *phydev)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (priv->rescue_mode)
+		return 0;
+
 	return mxl862xx_port_state(ds, port, true);
 }
 
 static void mxl862xx_port_disable(struct dsa_switch *ds, int port)
 {
+	struct mxl862xx_priv *priv = ds->priv;
+
+	if (priv->rescue_mode)
+		return;
+
 	if (mxl862xx_port_state(ds, port, false))
 		dev_err(ds->dev, "failed to disable port %d\n", port);
 }
@@ -1338,6 +1361,12 @@ static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
 	bool is_cpu_port = dsa_port_is_cpu(dp);
 	int ret;
 
+	/* DSA reinits failed user ports as unused; shared ports must
+	 * succeed for the tree to register.
+	 */
+	if (priv->rescue_mode)
+		return dsa_port_is_user(dp) ? -ENODEV : 0;
+
 	ret = mxl862xx_port_state(ds, port, false);
 	if (ret)
 		return ret;
@@ -1629,6 +1658,9 @@ static void mxl862xx_port_stp_state_set(struct dsa_switch *ds, int port,
 	struct mxl862xx_priv *priv = ds->priv;
 	int ret;
 
+	if (priv->rescue_mode)
+		return;
+
 	switch (state) {
 	case BR_STATE_DISABLED:
 		param.port_state = cpu_to_le32(MXL862XX_STP_PORT_STATE_DISABLE);
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 64d91ad51936..5d21296561e3 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -323,6 +323,8 @@ struct mxl862xx_fw_version {
  *                      during a firmware flash
  * @skip_teardown:      discard firmware API commands during the teardown
  *                      triggered by the post-flash reprobe
+ * @rescue_mode:        switch is stuck in MCUboot; firmware API commands
+ *                      fail fast, only clause-22 SMDIO works
  * @stats_work:         periodic work item that polls RMON hardware counters
  *                      and accumulates them into 64-bit per-port stats
  */
@@ -343,6 +345,7 @@ struct mxl862xx_priv {
 	u16 vf_block_size;
 	bool block_host;
 	bool skip_teardown;
+	bool rescue_mode;
 	struct delayed_work stats_work;
 };
 
-- 
2.55.0

