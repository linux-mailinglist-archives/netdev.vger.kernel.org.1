Return-Path: <netdev+bounces-280636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GJ+CmvK6WnAkAIAu9opvQ
	(envelope-from <netdev+bounces-280636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D63B44DF9B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245FD307A5D9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E32DE6F8;
	Thu, 23 Apr 2026 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="h+7lDWvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64C2ECD32;
	Thu, 23 Apr 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929017; cv=none; b=FO4JtCu62tzeIJv4MQwlXRGYKfbOc2Okfvn5RrjVjCilb44mE3cvDLLTVllKVHCNaXYgudTVnzPp+irRRg8q5yuyG3C0iDaG3lkVzBzU9qxvrWmFwXo4ly4Z/+hOf1+FjdIKZxS4vtzVbpqgJO06KbpQlhlnK8q6uuxhJmE1PRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929017; c=relaxed/simple;
	bh=2q2Ht1T4JW4DHF8OgvK6JxL3ji+OL2Cil+OTtz7ITI8=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0rxD2LRXmgbz6/POJXaAG++/a09YDldGLpbl2bSox89FPCSJyG+/s6GjZ2Fv9f3pF1j+PHIqeQzSIOHmG7se7iK5VGwa77pF4v3B+EkxMXDj5VS+HSIxKLZrcvE1yWPQ0aXQbi3uO0N/a8YP3RKAB0Igslv0cemZQv/ieKqG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=h+7lDWvA; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776928999; x=1777188199;
	bh=8BPE33mdf0YTUZNZ1J3DbxAruLByJV6Jr4w045J0KKU=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h+7lDWvAeiSc5dCybMxjcq66yd9mfYDPnOX4Q5RIuGRXbdJjupxfpoPhZUKfxAq8O
	 DvSOP5e5+0RkSlPs5tylEgpuwxn94iKZM6qaRTWxNNOjMh51xpA90f/LjtZa2lSfoN
	 sw1aYt4/CTZO0PlQ3NK3DHqbJgRIf82pZkK0eWUVGv+hnXfDJ5zmQlPEyK+miXNtDG
	 GxAgCEFXCVqPX6y7ZMbI7GJj5Tn/tLoeaV/A9nIZXOiG5CQtWTovXW0RzVnRRdUhYN
	 R7dsTcxHnelVP1KZBVC1ifiJsipwKTNoPHSvkRDtaIjPlcdqk0LmxjI7F5jgd2R6/T
	 nRkpNNaduZv3g==
Date: Thu, 23 Apr 2026 07:23:13 +0000
From: Corey Leavitt <corey@leavitt.info>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
Subject: [PATCH RFC net-next 4/4] net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook
Message-ID: <20260423-pse-notifier-decouple-v1-4-7d4856f686f6@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 5f66f2e8f185b92ad7784f3fcda0573da8580689
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280636-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leavitt.info:email,leavitt.info:dkim,leavitt.info:mid]
X-Rspamd-Queue-Id: 7D63B44DF9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Transfer ownership of phydev->psec from fwnode_mdio to the phy
subsystem itself. The phy subsystem now subscribes to the pse-pd
notifier chain and manages psec attach/detach in response to PSE
controller lifecycle events, while fwnode_mdio loses its PSE
awareness entirely.

Split phy_device_register() into a public entry point that takes
rtnl_lock() and a phy_device_register_locked() variant that assumes
rtnl is already held. Callers that already hold rtnl (the SFP
module state machine via __sfp_sm_event) use the _locked form to
avoid deadlock; all other callers use the unchanged public API.
This pair mirrors the register_netdevice() / register_netdev()
split convention already established in the core networking stack.
rtnl must span the full registration sequence through device_add(),
not just phy_try_attach_pse(): a PSE_REGISTERED event firing between
a narrow attach lock and device_add() would walk mdio_bus_type, find
the phy not yet on the bus, and leave it permanently unattached.

With rtnl held across the full registration sequence:

  - At phy_device_register_locked(), phy_try_attach_pse() attempts
    an of_pse_control_get() for phys whose DT pses phandle resolves
    now. If the controller is already registered, psec is attached
    before device_add() makes the phy visible on mdio_bus_type.
    If the controller is not yet registered, the swallow-error path
    leaves psec NULL and relies on the subsequent notifier event.

  - On PSE_REGISTERED: an rtnl-guarded bus walk retries the attach
    for every registered phy whose psec is still NULL. This is the
    "phy was enumerated before the PSE controller loaded" case,
    which is the root cause of the boot-time probe-retry storm on
    systems with a modular PSE controller driver. Because the
    pse_controller_notifier is fired synchronously, a concurrent
    pse_controller_register() either (a) completes list_add and
    releases pse_list_mutex before this function takes rtnl, in
    which case phy_try_attach_pse() finds the controller in the
    list and attaches; or (b) fires its notifier during this
    function, in which case the callback blocks on rtnl until this
    function returns, then walks the bus and finds the phy fully
    registered (attaching if psec is still NULL).

  - On PSE_UNREGISTERED: an rtnl-guarded bus walk releases every
    phydev->psec that targets the departing controller before
    pse_release_pis() frees pcdev->pi. Without this, a phy still
    holding a pse_control reference would cause a use-after-free
    in __pse_control_release's pcdev->pi[psec->id] access, and the
    PSE driver module could not finish unloading while any phy
    still held a reference via module_put().

Introduce phy_try_attach_pse() as the rtnl-guarded helper used by
both the register path and the notifier walk. Holding rtnl across
of_pse_control_get() is safe because pse_list_mutex is never held
in the opposite order.

Expose pse_control_matches_pcdev() as a predicate so subscribers
can identify which of their held pse_control references target a
given controller, without leaking the struct pse_controller_dev *
out of pse_control opacity.

Move the final pse_control_put() of phydev->psec from
phy_device_remove() to phy_device_release(). The kobject release
callback runs only after every reference on the device has been
dropped, including the bus iterator references taken by
bus_for_each_dev() in the notifier walk, which means by the time
release fires no concurrent reader or writer of phydev->psec can
exist. The mdio_bus_type klist is set up in bus_register() with
klist_devices_get() / klist_devices_put() (drivers/base/bus.c),
which bracket each iteration step with get_device() / put_device()
on the underlying struct device; that reference defers the release
callback from firing until the walk has advanced past this phy.
Keeping phy_device_remove() unchanged avoids introducing a new
locking contract on its many callers (sfp, fixed_phy, xgbe, hns,
netsec, bcm_sf2, mdiobus_unregister).

Finally, delete fwnode_find_pse_control() and its call site in
fwnode_mdiobus_register_phy(), and drop the PSE header from
fwnode_mdio.c. This removes the probe-time -EPROBE_DEFER coupling
between mdio and pse-pd that caused the boot-hang regression on
systems with a modular PSE controller driver and a DT phy with a
pses phandle: the MDIO/DSA probe no longer sees any PSE-originated
-EPROBE_DEFER, so the probe-retry storm is gone. fwnode_mdio is
now PSE-agnostic.

Fixes: fa2f0454174c ("net: pse-pd: Introduce attached_phydev to pse control=
")
Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
 drivers/net/mdio/fwnode_mdio.c |  34 ----------
 drivers/net/phy/phy_device.c   | 144 +++++++++++++++++++++++++++++++++++++=
+---
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  14 ++++
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |   9 +++
 6 files changed, 161 insertions(+), 44 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.=
c
index ba7091518265..7bd979b59f49 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -11,33 +11,11 @@
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/pse-pd/pse.h>
=20
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
=20
-static struct pse_control *
-fwnode_find_pse_control(struct fwnode_handle *fwnode,
-=09=09=09struct phy_device *phydev)
-{
-=09struct pse_control *psec;
-=09struct device_node *np;
-
-=09if (!IS_ENABLED(CONFIG_PSE_CONTROLLER))
-=09=09return NULL;
-
-=09np =3D to_of_node(fwnode);
-=09if (!np)
-=09=09return NULL;
-
-=09psec =3D of_pse_control_get(np, phydev);
-=09if (PTR_ERR(psec) =3D=3D -ENOENT)
-=09=09return NULL;
-
-=09return psec;
-}
-
 static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
@@ -118,7 +96,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 =09=09=09=09struct fwnode_handle *child, u32 addr)
 {
 =09struct mii_timestamper *mii_ts =3D NULL;
-=09struct pse_control *psec =3D NULL;
 =09struct phy_device *phy;
 =09bool is_c45;
 =09u32 phy_id;
@@ -159,14 +136,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 =09=09=09goto clean_phy;
 =09}
=20
-=09psec =3D fwnode_find_pse_control(child, phy);
-=09if (IS_ERR(psec)) {
-=09=09rc =3D PTR_ERR(psec);
-=09=09goto unregister_phy;
-=09}
-
-=09phy->psec =3D psec;
-
 =09/* phy->mii_ts may already be defined by the PHY driver. A
 =09 * mii_timestamper probed via the device tree will still have
 =09 * precedence.
@@ -176,9 +145,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
=20
 =09return 0;
=20
-unregister_phy:
-=09if (is_acpi_node(child) || is_of_node(child))
-=09=09phy_device_remove(phy);
 clean_phy:
 =09phy_device_free(phy);
 clean_mii_ts:
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c2cdf1ae3542..7948800e6e49 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -223,8 +223,19 @@ static void phy_mdio_device_free(struct mdio_device *m=
diodev)
=20
 static void phy_device_release(struct device *dev)
 {
+=09struct phy_device *phydev =3D to_phy_device(dev);
+
+=09/* bus_for_each_dev() holds get_device() across each iteration
+=09 * step, deferring this release callback until any in-flight PSE
+=09 * notifier walk has advanced past this phy. pse_control_put()
+=09 * takes pse_list_mutex, so this path must run in sleepable
+=09 * context.
+=09 */
+=09might_sleep();
+=09pse_control_put(phydev->psec);
+
 =09fwnode_handle_put(dev->fwnode);
-=09kfree(to_phy_device(dev));
+=09kfree(phydev);
 }
=20
 static void phy_mdio_device_remove(struct mdio_device *mdiodev)
@@ -1102,14 +1113,102 @@ struct phy_device *get_phy_device(struct mii_bus *=
bus, int addr, bool is_c45)
 }
 EXPORT_SYMBOL(get_phy_device);
=20
-/**
- * phy_device_register - Register the phy device on the MDIO bus
- * @phydev: phy_device structure to be added to the MDIO bus
+/* Best-effort attach of phydev->psec from a DT `pses =3D <&...>` phandle.
+ * Caller must hold rtnl. Errors are swallowed; the notifier retries
+ * at PSE_REGISTERED time.
  */
-int phy_device_register(struct phy_device *phydev)
+static void phy_try_attach_pse(struct phy_device *phydev)
+{
+=09struct pse_control *psec;
+=09struct device_node *np;
+
+=09ASSERT_RTNL();
+
+=09np =3D phydev->mdio.dev.of_node;
+=09if (!np)
+=09=09return;
+
+=09if (phydev->psec)
+=09=09return;
+
+=09psec =3D of_pse_control_get(np, phydev);
+=09if (IS_ERR(psec))
+=09=09return;
+
+=09phydev->psec =3D psec;
+}
+
+static int phy_pse_attach_one(struct device *dev, void *data __maybe_unuse=
d)
+{
+=09ASSERT_RTNL();
+
+=09if (dev->type !=3D &mdio_bus_phy_type)
+=09=09return 0;
+
+=09phy_try_attach_pse(to_phy_device(dev));
+=09return 0;
+}
+
+static int phy_pse_detach_one(struct device *dev, void *data)
+{
+=09struct pse_controller_dev *pcdev =3D data;
+=09struct phy_device *phydev;
+=09struct pse_control *psec;
+
+=09ASSERT_RTNL();
+
+=09if (dev->type !=3D &mdio_bus_phy_type)
+=09=09return 0;
+
+=09phydev =3D to_phy_device(dev);
+=09psec =3D phydev->psec;
+=09if (!psec || !pse_control_matches_pcdev(psec, pcdev))
+=09=09return 0;
+
+=09phydev->psec =3D NULL;
+=09pse_control_put(psec);
+=09return 0;
+}
+
+static int phy_pse_notifier_event(struct notifier_block *nb,
+=09=09=09=09  unsigned long event, void *data)
+{
+=09switch (event) {
+=09case PSE_REGISTERED:
+=09=09rtnl_lock();
+=09=09bus_for_each_dev(&mdio_bus_type, NULL, NULL,
+=09=09=09=09 phy_pse_attach_one);
+=09=09rtnl_unlock();
+=09=09return NOTIFY_OK;
+=09case PSE_UNREGISTERED:
+=09=09rtnl_lock();
+=09=09bus_for_each_dev(&mdio_bus_type, NULL, data,
+=09=09=09=09 phy_pse_detach_one);
+=09=09rtnl_unlock();
+=09=09return NOTIFY_OK;
+=09default:
+=09=09return NOTIFY_DONE;
+=09}
+}
+
+static struct notifier_block phy_pse_notifier __read_mostly =3D {
+=09.notifier_call =3D phy_pse_notifier_event,
+};
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
 {
 =09int err;
=20
+=09ASSERT_RTNL();
+
 =09err =3D mdiobus_register_device(&phydev->mdio);
 =09if (err)
 =09=09return err;
@@ -1124,6 +1223,8 @@ int phy_device_register(struct phy_device *phydev)
 =09=09goto out;
 =09}
=20
+=09phy_try_attach_pse(phydev);
+
 =09err =3D device_add(&phydev->mdio.dev);
 =09if (err) {
 =09=09phydev_err(phydev, "failed to add\n");
@@ -1133,12 +1234,32 @@ int phy_device_register(struct phy_device *phydev)
 =09return 0;
=20
  out:
-=09/* Assert the reset signal */
+=09/* If phy_try_attach_pse() set phydev->psec before device_add()
+=09 * failed, the caller's phy_device_free() -> phy_device_release()
+=09 * chain will drop it.
+=09 */
 =09phy_device_reset(phydev, 1);
-
 =09mdiobus_unregister_device(&phydev->mdio);
 =09return err;
 }
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
+=09int err;
+
+=09rtnl_lock();
+=09err =3D phy_device_register_locked(phydev);
+=09rtnl_unlock();
+
+=09return err;
+}
 EXPORT_SYMBOL(phy_device_register);
=20
 /**
@@ -1152,8 +1273,6 @@ EXPORT_SYMBOL(phy_device_register);
 void phy_device_remove(struct phy_device *phydev)
 {
 =09unregister_mii_timestamper(phydev->mii_ts);
-=09pse_control_put(phydev->psec);
-
 =09device_del(&phydev->mdio.dev);
=20
 =09/* Assert the reset signal */
@@ -3962,8 +4081,14 @@ static int __init phy_init(void)
 =09if (rc)
 =09=09goto err_c45;
=20
+=09rc =3D pse_register_notifier(&phy_pse_notifier);
+=09if (rc)
+=09=09goto err_genphy;
+
 =09return 0;
=20
+err_genphy:
+=09phy_driver_unregister(&genphy_driver);
 err_c45:
 =09phy_driver_unregister(&genphy_c45_driver);
 err_ethtool_phy_ops:
@@ -3980,6 +4105,7 @@ static int __init phy_init(void)
=20
 static void __exit phy_exit(void)
 {
+=09pse_unregister_notifier(&phy_pse_notifier);
 =09phy_driver_unregister(&genphy_c45_driver);
 =09phy_driver_unregister(&genphy_driver);
 =09rtnl_lock();
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bd970f753beb..d19fe0f30c5d 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1932,7 +1932,7 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr=
, bool is_c45)
 =09/* Mark this PHY as being on a SFP module */
 =09phy->is_on_sfp_module =3D true;
=20
-=09err =3D phy_device_register(phy);
+=09err =3D phy_device_register_locked(phy);
 =09if (err) {
 =09=09phy_device_free(phy);
 =09=09dev_err(sfp->dev, "phy_device_register failed: %pe\n",
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 82125502a8e3..a0667324a029 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -2016,3 +2016,17 @@ bool pse_has_c33(struct pse_control *psec)
 =09return psec->pcdev->types & ETHTOOL_PSE_C33;
 }
 EXPORT_SYMBOL_GPL(pse_has_c33);
+
+/**
+ * pse_control_matches_pcdev - Test whether a pse_control targets a contro=
ller
+ * @psec: pse_control obtained from of_pse_control_get()
+ * @pcdev: PSE controller to compare against
+ *
+ * Return: %true if @psec was obtained from @pcdev, %false otherwise.
+ */
+bool pse_control_matches_pcdev(struct pse_control *psec,
+=09=09=09       struct pse_controller_dev *pcdev)
+{
+=09return psec->pcdev =3D=3D pcdev;
+}
+EXPORT_SYMBOL_GPL(pse_control_matches_pcdev);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..865b9baddb85 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2158,6 +2158,8 @@ struct phy_device *fwnode_phy_find_device(struct fwno=
de_handle *phy_fwnode);
 struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwno=
de);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c=
45);
 int phy_device_register(struct phy_device *phy);
+/* Caller must hold rtnl_lock(); see phy_device_register() for the public =
form. */
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
=20
+bool pse_control_matches_pcdev(struct pse_control *psec,
+=09=09=09       struct pse_controller_dev *pcdev);
+
 int pse_register_notifier(struct notifier_block *nb);
 int pse_unregister_notifier(struct notifier_block *nb);
=20
@@ -438,6 +441,12 @@ static inline bool pse_has_c33(struct pse_control *pse=
c)
 =09return false;
 }
=20
+static inline bool pse_control_matches_pcdev(struct pse_control *psec,
+=09=09=09=09=09     struct pse_controller_dev *pcdev)
+{
+=09return false;
+}
+
 static inline int pse_register_notifier(struct notifier_block *nb)
 {
 =09return 0;

--=20
2.53.0



