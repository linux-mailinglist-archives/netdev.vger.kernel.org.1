Return-Path: <netdev+bounces-174196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F14A5DD43
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14411189978B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66623E354;
	Wed, 12 Mar 2025 13:03:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from birdy.pmhahn.de (birdy.pmhahn.de [88.198.22.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7A1E7C2B;
	Wed, 12 Mar 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.22.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784612; cv=none; b=kU4oU7zLwJ0v37mH6W0kbNZhWGFT6wGz6VbkbaXo3d9a0vDSyyxuZJBqFx9/hVYCN37Qs1owpFPafCcT34mi7TEGCv+LPYgRL8vbg9qmHgJfNkUkN8HFSS1mbulK9viLQ8C4HwvfAx/FmVcVUUj4CagoCO7PV5CEaNeb2iIEDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784612; c=relaxed/simple;
	bh=urFl68uoAji+L/OZmu9MC+PGlUjZURSh42gOnWDdFzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jhKlx+K/SEp3eTO2dhQBkH+R4ZDB8QF50XDTX8q3Yqo1zIlzUraXULTbt/5/4jX9KX/mnbjXEqumcQERZGI1gRFBBO81y3+N1DvsAlqgLAsTjIcUZuBTGBGMUgSYujlna4rYhwZ6UUSjZ6DD99T9B5Dei6fODsQ9BwFN4iUfdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=avm.de; spf=fail smtp.mailfrom=avm.de; arc=none smtp.client-ip=88.198.22.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=avm.de
Received: from birdy.pmhahn.de (p200300e2774a7B00F7f5672D647b4c86.dip0.t-ipconnect.de [IPv6:2003:e2:774a:7b00:f7f5:672d:647b:4c86])
	by birdy.pmhahn.de (Postfix) with ESMTPSA id 4565B220261D;
	Wed, 12 Mar 2025 13:55:29 +0100 (CET)
Date: Wed, 12 Mar 2025 13:55:27 +0100
From: Philipp Hahn <phahn-oss@avm.de>
To: netdev@vger.kernel.org
Cc: Philipp Hahn <phahn-oss@avm.de>, Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Schuermann <leon@is.currently.online>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v3]: cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock
 quirk
Message-ID: <Z9GEP/TksqEWFbkd@birdy.pmhahn.de>
Mail-Followup-To: netdev@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Schuermann <leon@is.currently.online>,
	Kory Maincent <kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Lenovo ThinkPad Hybrid USB-C with USB-A Dock (17ef:a359) is affected by
the same problem as the Lenovo Powered USB-C Travel Hub (17ef:721e):
Both are based on the Realtek RTL8153B chip used to use the cdc_ether
driver. However, using this driver, with the system suspended the device
constantly sends pause-frames as soon as the receive buffer fills up.
This causes issues with other devices, where some Ethernet switches stop
forwarding packets altogether.

Using the Realtek driver (r8152) fixes this issue. Pause frames are no
longer sent while the host system is suspended.

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Leon Schuermann <leon@is.currently.online>
Link: https://git.kernel.org/netdev/net/c/cb82a54904a9
Link: https://git.kernel.org/netdev/net/c/2284bbd0cf39
Link: https://www.lenovo.com/de/de/p/accessories-and-software/docking/docking-usb-docks/40af0135eu
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
V2 -> V3: Move `net-next` in subject.
V1 -> V2: Prefix subject with `net-next:`
V1 -> V2: Add additional Cc:s
 drivers/net/usb/cdc_ether.c | 7 +++++++
 drivers/net/usb/r8152.c     | 6 ++++++
 drivers/net/usb/r8153_ecm.c | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a6469235d904..a032c1ded406 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -783,6 +783,13 @@ static const struct usb_device_id	products[] = {
 	.driver_info = 0,
 },
 
+/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0xa359, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+
 /* Aquantia AQtion USB to 5GbE Controller (based on AQC111U) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(AQUANTIA_VENDOR_ID, 0xc101,
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 468c73974046..96fa3857d8e2 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -785,6 +785,7 @@ enum rtl8152_flags {
 #define DEVICE_ID_THINKPAD_USB_C_DONGLE			0x720c
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2		0xa387
 #define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3		0x3062
+#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK		0xa359
 
 struct tally_counter {
 	__le64	tx_packets;
@@ -9787,6 +9788,7 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
 		case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
 		case DEVICE_ID_THINKPAD_USB_C_DONGLE:
+		case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
 			return 1;
 		}
 	} else if (vendor_id == VENDOR_ID_REALTEK && parent_vendor_id == VENDOR_ID_LENOVO) {
@@ -10064,6 +10066,8 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927) },
 	{ USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0c5e) },
 	{ USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101) },
+
+	/* Lenovo */
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x304f) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3054) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
@@ -10074,7 +10078,9 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x721e) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa359) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0xa387) },
+
 	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
diff --git a/drivers/net/usb/r8153_ecm.c b/drivers/net/usb/r8153_ecm.c
index 20b2df8d74ae..8d860dacdf49 100644
--- a/drivers/net/usb/r8153_ecm.c
+++ b/drivers/net/usb/r8153_ecm.c
@@ -135,6 +135,12 @@ static const struct usb_device_id products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&r8153_info,
 },
+/* Lenovo ThinkPad Hybrid USB-C with USB-A Dock (40af0135eu, based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(VENDOR_ID_LENOVO, 0xa359, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&r8153_info,
+},
 
 	{ },		/* END */
 };
-- 
2.34.1


