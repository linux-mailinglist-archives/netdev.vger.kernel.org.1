Return-Path: <netdev+bounces-303046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iWBuGBSJQ2pBagoAu9opvQ
	(envelope-from <netdev+bounces-303046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E27396E1FFC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:14:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=YVRdvuY9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303046-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303046-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61DD43030F02
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9A3EB0FD;
	Tue, 30 Jun 2026 09:11:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2433E5EF3;
	Tue, 30 Jun 2026 09:11:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810707; cv=none; b=mTKDQrzDw6nl4RqsEBkfVRVMbPB7SXT7KR2o2KUDYGC4LREFQastduLkHHODjCRm2jkz3YRKBt6v49KsEQZv+AF48ZB2CjFPkSngVZOjXrtkdsaZJBd8R0KNo1hubIbzqJsuJ/BrwjIXdFW3vUEgd+Qq2fx0z6RysZKvthQEmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810707; c=relaxed/simple;
	bh=wuKgzSZE39fhInSJ7YR6ABNUiVulUP/guj3fPxTsHnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWeeZRiWCpYnnX9sjXEK4CGVKaL31OHVHbKJL4pXeS/w6XsvqyHQiDQYsGshN0Ekz9NX4t+jwGHyav5K+DrNrJjrHYp0qLgkCddHw37PkCa8sLUS6psfRYx2bBoFhsCBWYzcwbA0h1U8v2P/keR4FTt1rjr/w44DlQrJBFAX2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=YVRdvuY9; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 41B3BE838E4;
	Tue, 30 Jun 2026 11:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782810703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKr78nSxDqjXSWyUcQbx5FqngWRX1roCEV6kxr0QOFY=;
	b=YVRdvuY9OE5OItO0qdMT+Ntb3+OB6D01/dqksxBmAVmyEAtkJUI514eALLYEXLSkFrj9jF
	sRZskZ55ITVkldqnbXQE6g+20jpUl0PKqYRu1mjurlfvHeKRx9mRBQ0kdM28DVx/7w/5qR
	fm3rxy/I4vb+6S3LIqb8UOq8HNM/CI6H+SQWsWE+ETVbZU83Cju5Wtgtk3hgh9rqksDt3b
	J4kfOp6H/taxDiOIVxkZBOhg772tcr28Be2AHHowvASt69Z9FU2HwSVvVYAILq8jvR6QUu
	LHiqraE3sjk5HQSki2gsahamTxo03LiTTVS56MK/3OksT7q6WgUD9PncEn7fHQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 0O55ZtbKzr_x; Tue, 30 Jun 2026 11:11:43 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 30 Jun 2026 11:11:43 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v4 3/3] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Date: Tue, 30 Jun 2026 11:11:25 +0200
Message-ID: <20260630091125.3162481-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630091125.3162481-1-github@szelinsky.de>
References: <20260630091125.3162481-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303046-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[leavitt.info,gmail.com,kernel.org,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E27396E1FFC

From: Corey Leavitt <corey@leavitt.info>

Transfer ownership of phydev->psec from fwnode_mdio to the phy
subsystem itself. The phy subsystem now subscribes to the pse-pd
notifier chain and manages psec attach/detach in response to PSE
controller lifecycle events, while fwnode_mdio loses its PSE awareness
entirely.

phydev->psec is attached after device_add() has made the phy visible
on mdio_bus_type, under a narrow rtnl_lock() that covers only
phy_try_attach_pse(). Ordering the attach after registration closes
the race that would otherwise leave a phy unattached: a PSE_REGISTERED
event firing during registration walks mdio_bus_type and either finds
the phy already added (and attaches it) or runs before device_add(),
in which case the post-add attach resolves it. The phydev->psec check
in phy_try_attach_pse() makes the two paths idempotent. Holding rtnl
across of_pse_control_get() is safe because pse_list_mutex is never
taken in the opposite order.

device_add() is deliberately left outside rtnl. Binding a phy that
itself provides an SFP cage reaches sfp_bus_add_upstream() through
phy_probe() -> phy_setup_ports() -> phy_sfp_probe(), and
sfp_bus_add_upstream() takes rtnl_lock(); holding rtnl across
device_add() would deadlock such phys (reported on RTL8214FC).

phy_device_register() is split into the public form, which takes the
narrow rtnl_lock() around the attach, and a phy_device_register_locked()
form for callers that already hold rtnl (the SFP module state machine
via __sfp_sm_event). This pair mirrors the register_netdevice() /
register_netdev() split convention already established in the core
networking stack. The _locked form runs device_add() under the
caller's rtnl, which is safe because a phy resident on an SFP module
does not itself provide a downstream cage, so phy_sfp_probe() is a
no-op there.

  - On PSE_REGISTERED: an rtnl-guarded bus walk retries the attach for
    every registered phy whose psec is still NULL. This is the "phy
    was enumerated before the PSE controller loaded" case, the root
    cause of the boot-time probe-retry storm on systems with a modular
    PSE controller driver.

  - On PSE_UNREGISTERED: an rtnl-guarded bus walk releases every
    phydev->psec that targets the departing controller before
    pse_release_pis() frees pcdev->pi. Without this, a phy still
    holding a pse_control reference would cause a use-after-free in
    __pse_control_release()'s pcdev->pi[psec->id] access, and the PSE
    driver module could not finish unloading while any phy still held a
    reference.

A bad `pses` binding -- an error from of_pse_control_get() other than
-ENOENT (no phandle) or -EPROBE_DEFER (controller not yet registered)
-- is reported with phydev_warn() rather than silently dropped,
preserving the diagnostic that the removed fwnode_mdio lookup used to
provide.

The final pse_control_put() of phydev->psec moves from
phy_device_remove() to phy_device_release(), so it runs only after
every reference on the device -- including the bus-iterator references
taken by bus_for_each_dev() in the notifier walk -- has been dropped.

Finally, delete fwnode_find_pse_control() and its call site in
fwnode_mdiobus_register_phy(), and drop the PSE header from
fwnode_mdio.c. The MDIO/DSA probe no longer sees any PSE-originated
-EPROBE_DEFER, so the probe-retry storm is gone and fwnode_mdio is
now PSE-agnostic.

Reported-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Closes: https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/
Signed-off-by: Corey Leavitt <corey@leavitt.info>
Co-developed-by: Carlo Szelinsky <github@szelinsky.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/mdio/fwnode_mdio.c |  34 -------
 drivers/net/phy/phy_device.c   | 168 +++++++++++++++++++++++++++++++--
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  14 +++
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |   9 ++
 6 files changed, 186 insertions(+), 43 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518265..7bd979b59f49 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -11,33 +11,11 @@
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/pse-pd/pse.h>
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
 
-static struct pse_control *
-fwnode_find_pse_control(struct fwnode_handle *fwnode,
-			struct phy_device *phydev)
-{
-	struct pse_control *psec;
-	struct device_node *np;
-
-	if (!IS_ENABLED(CONFIG_PSE_CONTROLLER))
-		return NULL;
-
-	np = to_of_node(fwnode);
-	if (!np)
-		return NULL;
-
-	psec = of_pse_control_get(np, phydev);
-	if (PTR_ERR(psec) == -ENOENT)
-		return NULL;
-
-	return psec;
-}
-
 static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
@@ -118,7 +96,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr)
 {
 	struct mii_timestamper *mii_ts = NULL;
-	struct pse_control *psec = NULL;
 	struct phy_device *phy;
 	bool is_c45;
 	u32 phy_id;
@@ -159,14 +136,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 			goto clean_phy;
 	}
 
-	psec = fwnode_find_pse_control(child, phy);
-	if (IS_ERR(psec)) {
-		rc = PTR_ERR(psec);
-		goto unregister_phy;
-	}
-
-	phy->psec = psec;
-
 	/* phy->mii_ts may already be defined by the PHY driver. A
 	 * mii_timestamper probed via the device tree will still have
 	 * precedence.
@@ -176,9 +145,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	return 0;
 
-unregister_phy:
-	if (is_acpi_node(child) || is_of_node(child))
-		phy_device_remove(phy);
 clean_phy:
 	phy_device_free(phy);
 clean_mii_ts:
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..f5febff4b00b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -223,8 +223,19 @@ static void phy_mdio_device_free(struct mdio_device *mdiodev)
 
 static void phy_device_release(struct device *dev)
 {
+	struct phy_device *phydev = to_phy_device(dev);
+
+	/* bus_for_each_dev() holds get_device() across each iteration
+	 * step, deferring this release callback until any in-flight PSE
+	 * notifier walk has advanced past this phy. pse_control_put()
+	 * takes pse_list_mutex, so this path must run in sleepable
+	 * context.
+	 */
+	might_sleep();
+	pse_control_put(phydev->psec);
+
 	fwnode_handle_put(dev->fwnode);
-	kfree(to_phy_device(dev));
+	kfree(phydev);
 }
 
 static void phy_mdio_device_remove(struct mdio_device *mdiodev)
@@ -1102,11 +1113,103 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 }
 EXPORT_SYMBOL(get_phy_device);
 
-/**
- * phy_device_register - Register the phy device on the MDIO bus
- * @phydev: phy_device structure to be added to the MDIO bus
+/* Best-effort attach of phydev->psec from a DT `pses = <&...>` phandle.
+ * Caller must hold rtnl. A missing phandle (-ENOENT) or a not-yet-registered
+ * controller (-EPROBE_DEFER) is silent; the notifier retries the latter at
+ * PSE_REGISTERED time. Any other error means a broken binding and is warned
+ * about, but left non-fatal so the phy still registers.
  */
-int phy_device_register(struct phy_device *phydev)
+static void phy_try_attach_pse(struct phy_device *phydev)
+{
+	struct pse_control *psec;
+	struct device_node *np;
+
+	ASSERT_RTNL();
+
+	np = phydev->mdio.dev.of_node;
+	if (!np)
+		return;
+
+	if (phydev->psec)
+		return;
+
+	psec = of_pse_control_get(np, phydev);
+	if (IS_ERR(psec)) {
+		if (PTR_ERR(psec) != -EPROBE_DEFER && PTR_ERR(psec) != -ENOENT)
+			phydev_warn(phydev, "failed to get PSE control: %pe\n",
+				    psec);
+		return;
+	}
+
+	phydev->psec = psec;
+}
+
+static int phy_pse_attach_one(struct device *dev, void *data __maybe_unused)
+{
+	ASSERT_RTNL();
+
+	if (dev->type != &mdio_bus_phy_type)
+		return 0;
+
+	phy_try_attach_pse(to_phy_device(dev));
+	return 0;
+}
+
+static int phy_pse_detach_one(struct device *dev, void *data)
+{
+	struct pse_controller_dev *pcdev = data;
+	struct phy_device *phydev;
+	struct pse_control *psec;
+
+	ASSERT_RTNL();
+
+	if (dev->type != &mdio_bus_phy_type)
+		return 0;
+
+	phydev = to_phy_device(dev);
+	psec = phydev->psec;
+	if (!psec || !pse_control_matches_pcdev(psec, pcdev))
+		return 0;
+
+	phydev->psec = NULL;
+	pse_control_put(psec);
+	return 0;
+}
+
+static int phy_pse_notifier_event(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	switch (event) {
+	case PSE_REGISTERED:
+		rtnl_lock();
+		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
+				 phy_pse_attach_one);
+		rtnl_unlock();
+		return NOTIFY_OK;
+	case PSE_UNREGISTERED:
+		rtnl_lock();
+		bus_for_each_dev(&mdio_bus_type, NULL, data,
+				 phy_pse_detach_one);
+		rtnl_unlock();
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block phy_pse_notifier __read_mostly = {
+	.notifier_call = phy_pse_notifier_event,
+};
+
+/* Core registration: add the phy to the MDIO bus. Does not touch rtnl or
+ * PSE. phydev->psec is attached by the callers below, after device_add()
+ * has made the phy visible on mdio_bus_type, so that a concurrent PSE
+ * notifier walk and the attach can never leave the phy unattached. Keeping
+ * device_add() out of rtnl also avoids deadlocking when binding a phy that
+ * itself provides an SFP cage (phy_probe() -> phy_sfp_probe() ->
+ * sfp_bus_add_upstream() takes rtnl).
+ */
+static int __phy_device_register(struct phy_device *phydev)
 {
 	int err;
 
@@ -1135,10 +1238,54 @@ int phy_device_register(struct phy_device *phydev)
  out:
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
-
 	mdiobus_unregister_device(&phydev->mdio);
 	return err;
 }
+
+/**
+ * phy_device_register_locked - Register the phy device on the MDIO bus
+ * @phydev: phy_device structure to be added to the MDIO bus
+ *
+ * Same as phy_device_register() but caller must already hold rtnl_lock().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int phy_device_register_locked(struct phy_device *phydev)
+{
+	int err;
+
+	ASSERT_RTNL();
+
+	err = __phy_device_register(phydev);
+	if (err)
+		return err;
+
+	phy_try_attach_pse(phydev);
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_device_register_locked);
+
+/**
+ * phy_device_register - Register the phy device on the MDIO bus
+ * @phydev: phy_device structure to be added to the MDIO bus
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int phy_device_register(struct phy_device *phydev)
+{
+	int err;
+
+	err = __phy_device_register(phydev);
+	if (err)
+		return err;
+
+	rtnl_lock();
+	phy_try_attach_pse(phydev);
+	rtnl_unlock();
+
+	return 0;
+}
 EXPORT_SYMBOL(phy_device_register);
 
 /**
@@ -1152,8 +1299,6 @@ EXPORT_SYMBOL(phy_device_register);
 void phy_device_remove(struct phy_device *phydev)
 {
 	unregister_mii_timestamper(phydev->mii_ts);
-	pse_control_put(phydev->psec);
-
 	device_del(&phydev->mdio.dev);
 
 	/* Assert the reset signal */
@@ -3981,8 +4126,14 @@ static int __init phy_init(void)
 	if (rc)
 		goto err_c45;
 
+	rc = pse_register_notifier(&phy_pse_notifier);
+	if (rc)
+		goto err_genphy;
+
 	return 0;
 
+err_genphy:
+	phy_driver_unregister(&genphy_driver);
 err_c45:
 	phy_driver_unregister(&genphy_c45_driver);
 err_ethtool_phy_ops:
@@ -3999,6 +4150,7 @@ static int __init phy_init(void)
 
 static void __exit phy_exit(void)
 {
+	pse_unregister_notifier(&phy_pse_notifier);
 	phy_driver_unregister(&genphy_c45_driver);
 	phy_driver_unregister(&genphy_driver);
 	rtnl_lock();
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 03bfd8640db9..18868bdd6485 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2083,7 +2083,7 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
 	/* Mark this PHY as being on a SFP module */
 	phy->is_on_sfp_module = true;
 
-	err = phy_device_register(phy);
+	err = phy_device_register_locked(phy);
 	if (err) {
 		phy_device_free(phy);
 		dev_err(sfp->dev, "phy_device_register failed: %pe\n",
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 0190fac33c78..611540df43bb 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -2021,3 +2021,17 @@ bool pse_has_c33(struct pse_control *psec)
 	return psec->pcdev->types & ETHTOOL_PSE_C33;
 }
 EXPORT_SYMBOL_GPL(pse_has_c33);
+
+/**
+ * pse_control_matches_pcdev - Test whether a pse_control targets a controller
+ * @psec: pse_control obtained from of_pse_control_get()
+ * @pcdev: PSE controller to compare against
+ *
+ * Return: %true if @psec was obtained from @pcdev, %false otherwise.
+ */
+bool pse_control_matches_pcdev(struct pse_control *psec,
+			       struct pse_controller_dev *pcdev)
+{
+	return psec->pcdev == pcdev;
+}
+EXPORT_SYMBOL_GPL(pse_control_matches_pcdev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..865b9baddb85 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2158,6 +2158,8 @@ struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
 struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
 int phy_device_register(struct phy_device *phy);
+/* Caller must hold rtnl_lock(); see phy_device_register() for the public form. */
+int phy_device_register_locked(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
 void phy_device_remove(struct phy_device *phydev);
 int phy_get_c45_ids(struct phy_device *phydev);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 78fe3a2b1ea8..d4310ca71a3e 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -385,6 +385,9 @@ int pse_ethtool_set_prio(struct pse_control *psec,
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
 
+bool pse_control_matches_pcdev(struct pse_control *psec,
+			       struct pse_controller_dev *pcdev);
+
 int pse_register_notifier(struct notifier_block *nb);
 int pse_unregister_notifier(struct notifier_block *nb);
 
@@ -438,6 +441,12 @@ static inline bool pse_has_c33(struct pse_control *psec)
 	return false;
 }
 
+static inline bool pse_control_matches_pcdev(struct pse_control *psec,
+					     struct pse_controller_dev *pcdev)
+{
+	return false;
+}
+
 static inline int pse_register_notifier(struct notifier_block *nb)
 {
 	return 0;
-- 
2.43.0


