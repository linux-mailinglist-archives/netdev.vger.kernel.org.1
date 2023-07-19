Return-Path: <netdev+bounces-19116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E9759C86
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A082B28197C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF91FB5D;
	Wed, 19 Jul 2023 17:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B941FB30
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:38:06 +0000 (UTC)
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377018D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1689788283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxAHiS1dMKUPvSOrNPg4ns2JBXqCwmJKuYUyY8qtwHk=;
	b=Wd4OY+qO6nBD2HkK5guU9IEeUMwjsI3Qcb1L/r++vZ1mD+VzVZcFOazWPh3Hsg1w37vH4P
	t26j0RyWO4HhfxsT8zTX9Sp3jv+XxXs4LuHydAjvYzTxOGgqry9Eg5r+zFcFcY78P5zxin
	M6LxRL3EghshoUqDJZ8OOLI9CuiEpMQ=
Received: from g2t4621.austin.hp.com (g2t4621.austin.hp.com [15.73.212.80])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-vkySPCFzPUOsuizxogouvw-1; Wed, 19 Jul 2023 13:38:02 -0400
X-MC-Unique: vkySPCFzPUOsuizxogouvw-1
Received: from g1t6217.austin.hpicorp.net (g1t6217.austin.hpicorp.net [15.67.1.144])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g2t4621.austin.hp.com (Postfix) with ESMTPS id B083426F;
	Wed, 19 Jul 2023 17:37:59 +0000 (UTC)
Received: from jam-buntu.lan (unknown [15.74.50.248])
	by g1t6217.austin.hpicorp.net (Postfix) with ESMTP id 174AB65;
	Wed, 19 Jul 2023 17:37:58 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hayeswang@realtek.com,
	jflf_kernel@gmx.com,
	bjorn@mork.no,
	svenva@chromium.org,
	linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is enabled
Date: Wed, 19 Jul 2023 17:37:56 +0000
Message-Id: <20230719173756.380829-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
References: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
in U3 state. If it is not, and the host "disappears", the chip will
no longer respond to WoL triggers.

To resolve this, add a notifier block and register it as a reboot
notifier. When WoL is enabled, work through the usb_device struct to
get to the suspend function. Calling this function puts the link in
the correct state for WoL to function.

Fixes: 21ff2e8976b1 ("r8152: support WOL")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
Changes since v1:
    * Add "Fixes:" tag to commit message

 drivers/net/usb/r8152.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0738baa5b82e..abb82a80d262 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -20,6 +20,7 @@
 #include <net/ip6_checksum.h>
 #include <uapi/linux/mdio.h>
 #include <linux/mdio.h>
+#include <linux/reboot.h>
 #include <linux/usb/cdc.h>
 #include <linux/suspend.h>
 #include <linux/atomic.h>
@@ -876,6 +877,7 @@ struct r8152 {
 =09struct delayed_work schedule, hw_phy_work;
 =09struct mii_if_info mii;
 =09struct mutex control;=09/* use for hw setting */
+=09struct notifier_block reboot_notifier;
 #ifdef CONFIG_PM_SLEEP
 =09struct notifier_block pm_notifier;
 #endif
@@ -9610,6 +9612,25 @@ static bool rtl8152_supports_lenovo_macpassthru(stru=
ct usb_device *udev)
 =09return 0;
 }
=20
+/* Suspend realtek chip before system shutdown
+ *
+ * For Wake-on-LAN to work from S5, the USB link must be put in U3 state. =
If
+ * the host otherwise "disappears", the chip will not respond to WoL trigg=
ers.
+ */
+static int rtl8152_notify(struct notifier_block *nb, unsigned long code,
+=09=09=09  void *unused)
+{
+=09struct r8152 *tp =3D container_of(nb, struct r8152, reboot_notifier);
+=09struct device *dev =3D &tp->udev->dev;
+
+=09if (code =3D=3D SYS_POWER_OFF) {
+=09=09if (tp->saved_wolopts && dev->type->pm->suspend)
+=09=09=09dev->type->pm->suspend(dev);
+=09}
+
+=09return NOTIFY_DONE;
+}
+
 static int rtl8152_probe(struct usb_interface *intf,
 =09=09=09 const struct usb_device_id *id)
 {
@@ -9792,6 +9813,9 @@ static int rtl8152_probe(struct usb_interface *intf,
 =09else
 =09=09device_set_wakeup_enable(&udev->dev, false);
=20
+=09tp->reboot_notifier.notifier_call =3D rtl8152_notify;
+=09register_reboot_notifier(&tp->reboot_notifier);
+
 =09netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
=20
 =09return 0;
@@ -9812,6 +9836,7 @@ static void rtl8152_disconnect(struct usb_interface *=
intf)
 =09if (tp) {
 =09=09rtl_set_unplug(tp);
=20
+=09=09unregister_reboot_notifier(&tp->reboot_notifier);
 =09=09unregister_netdev(tp->netdev);
 =09=09tasklet_kill(&tp->tx_tl);
 =09=09cancel_delayed_work_sync(&tp->hw_phy_work);
--=20
2.39.1


