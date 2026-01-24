Return-Path: <netdev+bounces-253057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC8xKNuPdGmw7AAAu9opvQ
	(envelope-from <netdev+bounces-253057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:24:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B97D160
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955CA30097D2
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2B23C51D;
	Sat, 24 Jan 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3GODyk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506701C862F
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246681; cv=none; b=BHfslbkKe26HunmejjjX8+ShxIlJf3Gs2In87WRvqK7P0xfMC0JJPPJuIWkm4NeApwjIxFfBE5Oc+cFF5z2g/Ek3fjPVpNrw2S9PgtxyQ6QpmQjAuXBEXCKbHvId4Sn7TXbcdAQ2+1jtktX5gFJKbMbOs/1GbaYcd2JiiZUXd1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246681; c=relaxed/simple;
	bh=A3VdFHDWyptU+T7aGV5Y8VJl7EmxziqvaVmObX2xLQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eI3QIPr5Go2cE+Irsuk0Ms/eq2vljbQU0RoERJ5LauTEG4r35FSBxmeXJd82xuPjKLp6pTOqKsPJcS7LQVZY3xp8FmpRhZ+dAcqu7LkD7tgAeo7SZDl0hOJFt4tzot4TrEYgrR/5Rbdzek2DRyK9l8o/8ZtmEuu2UqmLVW3F+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3GODyk5; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b7381d2d95so1001566eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 01:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769246678; x=1769851478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iA/XbJA75KM6WAaYfpAdE33BZoZEAPo2E+Bt+nTGRQM=;
        b=e3GODyk5pWCTm9VyIkXramR8fUCmROOKpAnkKu1kkUCtdtE3DKDYFEZ4cSmGCEj8TJ
         I1VYCPRgaoEg+WDxb7XcFOAmEu2AVuRrMsZJnN6eTnNJigMyw9tLr8B0XY/jfSfFHjv8
         Z2b35aUxPdN616z8UuMSz7z4S2Y33OCrQwzOPdTK7ksy/nbbWbm/NhZhz+zdckiSSonK
         VTUDqOUfAaBQToFPgvKaeu5Qi3GS1mu9+P2J66ycDIxFmKlmZUmKx+Nwyx1V07kLxbxb
         7o82geZT00MQCeVVNpGeIY89Rhzq1dAxWmHt5Bkt+kG/LxyURPxxQs7oDsDK758B07vO
         IEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769246678; x=1769851478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA/XbJA75KM6WAaYfpAdE33BZoZEAPo2E+Bt+nTGRQM=;
        b=hmL/ZLy1GNiy9Glrx3X0ujPW53Nx6au1jugUhb9+NQgQ7tZXY+FFyFfuJLDtNl1Lhk
         O3JoRHKth1WDDGfiG/MLfOLE8/0XQoahIZDjMkd+6ZuvyQIEhwsEP3nFplxPAi62un1F
         1QcBIiXGIz7iMtVbgcEP/cVx9eJdMtPV2jPEll+ZXY2FWkvD8DBY6CHuCB2otHGeXUde
         f8LONh/w9Zf87C1HL8czbcLXvLXW3Ra8eFjQSxLYJWGsSBxx0w/8uhndp6GJSV00JqP8
         9vEJAhYWiHocOIAosAL4KFbIDHIcf3LHrHyEu1Vi0RLV7MzoyEUhU5eRlzfpOYi7oCoc
         rmBg==
X-Gm-Message-State: AOJu0YymfTMRQzukMYzWfntaVDeF2UHCAtNP7oQmHFgaCP2+n3s8/WkG
	PBUSjYFUrYWmCFKrwizzgbWsHO4AIEF4klHuJ17u49O2gwcR1dn/sAYV+0gM/sjB
X-Gm-Gg: AZuq6aJ42iOlprj1lIEG26NWVNtrL1DYXsMtznTW6vz6cfKHxobQf3SHPlEJzc2Ll2C
	7ZB/eQqPk8oBjdbJAy0C0P4/UlIY6pqJmBoA/tB8TKRWT8TPZ6KX/kd5v4OyApdg76Yfy5/4o/T
	j8ZQvw8YZhuem8Kw2WERy/SbCmLucVn/9Xj7pS/XuJ+Z+Lwysn514ZDpCiifHOK5LYNMH+aldRZ
	8/uQ9DUG29gCN0T6tNupbVO/1BlA3pd//wRkx8PUKKdHfdfG6SKYKc5kmoAn0ZaXn7OJ6A82/k7
	l6L8n7BhSKNn/YUFFoZXHGUv78OI66hzzcjUAR+8mEsuDnGxIsxyFOJ5oBhNevI5+vE5kzgISBk
	JKb1tA1m/DZWkU4YhGVkZ3EfEJZYykFRZ9aCBuYi6+aIDLymXenBfHlFfO/vg+D1VHGBOVhMCIv
	gt93X3awTKUD35cmwkJpyk9+drsKDSHtKnA6JEp7j/Lxb/QvM3p8Zez7ULsemi1QTxD/WwSO9oB
	F6OhKtmH7XPkTbrNoufuXtm87xGVHFV5kmb7K2vSjc6nocbtYqeykoulojn/ltJI0PmargTeXeD
	evBF
X-Received: by 2002:a05:693c:2298:b0:2b7:20fe:821d with SMTP id 5a478bee46e88-2b7397b53b2mr3100623eec.10.1769246678311;
        Sat, 24 Jan 2026 01:24:38 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a692222sm6083544eec.6.2026.01.24.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 01:24:38 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH net-next] net: usb: remove unnecessary get_drvinfo code and driver versions
Date: Sat, 24 Jan 2026 01:23:26 -0800
Message-ID: <20260124092423.97481-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,nucleusys.com,fintech.ru,suse.com,piap.pl,pengutronix.de,online.de,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-253057-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC6B97D160
X-Rspamd-Action: no action

Many USB network drivers define get_drvinfo functions which add no
value over usbnet_get_drvinfo, only setting the driver name and
version. usbnet_get_drvinfo automatically sets the driver name, and
separate driver versions are now frowned upon in the kernel. Remove all
driver versions and replace these get_drvinfo functions with references
to usbnet_get_drvinfo where possible. Where that is not possible,
remove unnecessary code to set the driver name. Also remove two
unnecessary initializations from aqc111_get_drvinfo, an inaccurate
comment in pegasus.c, and an unused macro in catc.c.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/aqc111.c       |  5 -----
 drivers/net/usb/asix.h         |  3 ---
 drivers/net/usb/asix_common.c  |  8 --------
 drivers/net/usb/asix_devices.c |  8 +++-----
 drivers/net/usb/ax88172a.c     |  2 +-
 drivers/net/usb/catc.c         |  7 -------
 drivers/net/usb/dm9601.c       |  9 +--------
 drivers/net/usb/mcs7830.c      |  7 +------
 drivers/net/usb/pegasus.c      |  3 ---
 drivers/net/usb/r8152.c        | 10 ----------
 drivers/net/usb/rtl8150.c      |  3 ---
 drivers/net/usb/sierra_net.c   | 14 +-------------
 drivers/net/usb/sr9800.c       | 12 +-----------
 drivers/net/usb/sr9800.h       |  3 +--
 14 files changed, 9 insertions(+), 85 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 9201ee10a13f..0722050dbe32 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -20,8 +20,6 @@
 
 #include "aqc111.h"
 
-#define DRIVER_NAME "aqc111"
-
 static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
 				u16 index, u16 size, void *data)
 {
@@ -207,13 +205,10 @@ static void aqc111_get_drvinfo(struct net_device *net,
 
 	/* Inherit standard device info */
 	usbnet_get_drvinfo(net, info);
-	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
 	snprintf(info->fw_version, sizeof(info->fw_version), "%u.%u.%u",
 		 aqc111_data->fw_ver.major,
 		 aqc111_data->fw_ver.minor,
 		 aqc111_data->fw_ver.rev);
-	info->eedump_len = 0x00;
-	info->regdump_len = 0x00;
 }
 
 static void aqc111_get_wol(struct net_device *net,
diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
index 8531b804021a..cf97bc3d388b 100644
--- a/drivers/net/usb/asix.h
+++ b/drivers/net/usb/asix.h
@@ -29,7 +29,6 @@
 #include <net/selftests.h>
 #include <linux/phylink.h>
 
-#define DRIVER_VERSION "22-Dec-2011"
 #define DRIVER_NAME "asix"
 
 /* ASIX AX8817X based USB 2.0 Ethernet Devices */
@@ -248,8 +247,6 @@ int asix_get_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 int asix_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 		    u8 *data);
 
-void asix_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info);
-
 int asix_set_mac_address(struct net_device *net, void *p);
 
 #endif /* _ASIX_H */
diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 6ab3486072cb..4f03f4e57655 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -731,14 +731,6 @@ int asix_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
 	return ret;
 }
 
-void asix_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
-{
-	/* Inherit standard device info */
-	usbnet_get_drvinfo(net, info);
-	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
-}
-
 int asix_set_mac_address(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 232bbd79a4de..96fa5dc2b469 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -115,7 +115,7 @@ static int asix_ioctl (struct net_device *net, struct ifreq *rq, int cmd)
    own structure so we don't interfere with other usbnet
    devices that may be connected at the same time. */
 static const struct ethtool_ops ax88172_ethtool_ops = {
-	.get_drvinfo		= asix_get_drvinfo,
+	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_link		= asix_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
@@ -324,7 +324,7 @@ static int ax88772_ethtool_set_pauseparam(struct net_device *ndev,
 }
 
 static const struct ethtool_ops ax88772_ethtool_ops = {
-	.get_drvinfo		= asix_get_drvinfo,
+	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_link		= usbnet_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
@@ -985,7 +985,7 @@ static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
 }
 
 static const struct ethtool_ops ax88178_ethtool_ops = {
-	.get_drvinfo		= asix_get_drvinfo,
+	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_link		= asix_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
@@ -1642,7 +1642,5 @@ static struct usb_driver asix_driver = {
 module_usb_driver(asix_driver);
 
 MODULE_AUTHOR("David Hollis");
-MODULE_VERSION(DRIVER_VERSION);
 MODULE_DESCRIPTION("ASIX AX8817X based USB 2.0 Ethernet Devices");
 MODULE_LICENSE("GPL");
-
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 758a423a459b..3100fbe153c0 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -114,7 +114,7 @@ static const struct net_device_ops ax88172a_netdev_ops = {
 };
 
 static const struct ethtool_ops ax88172a_ethtool_ops = {
-	.get_drvinfo		= asix_get_drvinfo,
+	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_link		= usbnet_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 6759388692f8..5c7f19cbacf6 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -37,14 +37,8 @@
 
 #include <linux/usb.h>
 
-/*
- * Version information.
- */
-
-#define DRIVER_VERSION "v2.8"
 #define DRIVER_AUTHOR "Vojtech Pavlik <vojtech@suse.cz>"
 #define DRIVER_DESC "CATC EL1210A NetMate USB Ethernet driver"
-#define SHORT_DRIVER_DESC "EL1210A NetMate USB Ethernet"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
@@ -673,7 +667,6 @@ static void catc_get_drvinfo(struct net_device *dev,
 {
 	struct catc *catc = netdev_priv(dev);
 	strscpy(info->driver, driver_name, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
 	usb_make_path(catc->usbdev, info->bus_info, sizeof(info->bus_info));
 }
 
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 2b4716ccf0c5..43fae1959547 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -259,13 +259,6 @@ static void dm9601_mdio_write(struct net_device *netdev, int phy_id, int loc,
 	dm_write_shared_word(dev, 1, loc, res);
 }
 
-static void dm9601_get_drvinfo(struct net_device *net,
-			       struct ethtool_drvinfo *info)
-{
-	/* Inherit standard device info */
-	usbnet_get_drvinfo(net, info);
-}
-
 static u32 dm9601_get_link(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -281,7 +274,7 @@ static int dm9601_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 }
 
 static const struct ethtool_ops dm9601_ethtool_ops = {
-	.get_drvinfo	= dm9601_get_drvinfo,
+	.get_drvinfo	= usbnet_get_drvinfo,
 	.get_link	= dm9601_get_link,
 	.get_msglevel	= usbnet_get_msglevel,
 	.set_msglevel	= usbnet_set_msglevel,
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index fdda0616704e..3a551ad363d0 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -438,11 +438,6 @@ static int mcs7830_get_regs_len(struct net_device *net)
 	return 0;
 }
 
-static void mcs7830_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *drvinfo)
-{
-	usbnet_get_drvinfo(net, drvinfo);
-}
-
 static void mcs7830_get_regs(struct net_device *net, struct ethtool_regs *regs, void *data)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -452,11 +447,11 @@ static void mcs7830_get_regs(struct net_device *net, struct ethtool_regs *regs,
 }
 
 static const struct ethtool_ops mcs7830_ethtool_ops = {
-	.get_drvinfo		= mcs7830_get_drvinfo,
 	.get_regs_len		= mcs7830_get_regs_len,
 	.get_regs		= mcs7830_get_regs,
 
 	/* common usbnet calls */
+	.get_drvinfo		= usbnet_get_drvinfo,
 	.get_link		= usbnet_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index c514483134f0..7b6d6eb60709 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -18,9 +18,6 @@
 #include <linux/uaccess.h>
 #include "pegasus.h"
 
-/*
- * Version Information
- */
 #define DRIVER_AUTHOR "Petko Manolov <petkan@nucleusys.com>"
 #define DRIVER_DESC "Pegasus/Pegasus II USB Ethernet driver"
 
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 880b59ed5422..e8e6689d2c70 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -30,13 +30,6 @@
 #include <linux/usb/r8152.h>
 #include <net/gso.h>
 
-/* Information for net-next */
-#define NETNEXT_VERSION		"12"
-
-/* Information for net */
-#define NET_VERSION		"13"
-
-#define DRIVER_VERSION		"v1." NETNEXT_VERSION "." NET_VERSION
 #define DRIVER_AUTHOR "Realtek linux nic maintainers <nic_swsd@realtek.com>"
 #define DRIVER_DESC "Realtek RTL8152/RTL8153 Based USB Ethernet Adapters"
 #define MODULENAME "r8152"
@@ -8756,7 +8749,6 @@ static void rtl8152_get_drvinfo(struct net_device *netdev,
 	struct r8152 *tp = netdev_priv(netdev);
 
 	strscpy(info->driver, MODULENAME, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
 	usb_make_path(tp->udev, info->bus_info, sizeof(info->bus_info));
 	if (!IS_ERR_OR_NULL(tp->rtl_fw.fw))
 		strscpy(info->fw_version, tp->rtl_fw.version,
@@ -9950,7 +9942,6 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 		goto out2;
 
 	set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
-	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
 
 	return 0;
 
@@ -10145,4 +10136,3 @@ module_exit(rtl8152_driver_exit);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_VERSION(DRIVER_VERSION);
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index e40b0669d9f4..2f1f134b5b48 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -13,8 +13,6 @@
 #include <linux/usb.h>
 #include <linux/uaccess.h>
 
-/* Version Information */
-#define DRIVER_VERSION "v0.6.2 (2004/08/27)"
 #define DRIVER_AUTHOR "Petko Manolov <petkan@users.sourceforge.net>"
 #define DRIVER_DESC "rtl8150 based usb-ethernet driver"
 
@@ -785,7 +783,6 @@ static void rtl8150_get_drvinfo(struct net_device *netdev, struct ethtool_drvinf
 	rtl8150_t *dev = netdev_priv(netdev);
 
 	strscpy(info->driver, driver_name, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
 	usb_make_path(dev->udev, info->bus_info, sizeof(info->bus_info));
 }
 
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 36c73db44f77..3ca60ebdd468 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -12,10 +12,8 @@
  * Sierra Wireless. Use at your own risk.
  */
 
-#define DRIVER_VERSION "v.2.0"
 #define DRIVER_AUTHOR "Paxton Smith, Matthew Safar, Rory Filer"
 #define DRIVER_DESC "USB-to-WWAN Driver for Sierra Wireless modems"
-static const char driver_name[] = "sierra_net";
 
 /* if defined debug messages enabled */
 /*#define	DEBUG*/
@@ -607,15 +605,6 @@ static void sierra_net_status(struct usbnet *dev, struct urb *urb)
 	}
 }
 
-static void sierra_net_get_drvinfo(struct net_device *net,
-		struct ethtool_drvinfo *info)
-{
-	/* Inherit standard device info */
-	usbnet_get_drvinfo(net, info);
-	strscpy(info->driver, driver_name, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
-}
-
 static u32 sierra_net_get_link(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -624,7 +613,7 @@ static u32 sierra_net_get_link(struct net_device *net)
 }
 
 static const struct ethtool_ops sierra_net_ethtool_ops = {
-	.get_drvinfo = sierra_net_get_drvinfo,
+	.get_drvinfo = usbnet_get_drvinfo,
 	.get_link = sierra_net_get_link,
 	.get_msglevel = usbnet_get_msglevel,
 	.set_msglevel = usbnet_set_msglevel,
@@ -973,5 +962,4 @@ module_usb_driver(sierra_net_driver);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 57947a5590cc..1a2cce6f275e 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -469,15 +469,6 @@ static int sr_get_eeprom(struct net_device *net,
 	return 0;
 }
 
-static void sr_get_drvinfo(struct net_device *net,
-				 struct ethtool_drvinfo *info)
-{
-	/* Inherit standard device info */
-	usbnet_get_drvinfo(net, info);
-	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
-}
-
 static u32 sr_get_link(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -518,7 +509,7 @@ static int sr_set_mac_address(struct net_device *net, void *p)
 }
 
 static const struct ethtool_ops sr9800_ethtool_ops = {
-	.get_drvinfo	= sr_get_drvinfo,
+	.get_drvinfo	= usbnet_get_drvinfo,
 	.get_link	= sr_get_link,
 	.get_msglevel	= usbnet_get_msglevel,
 	.set_msglevel	= usbnet_set_msglevel,
@@ -872,6 +863,5 @@ static struct usb_driver sr_driver = {
 module_usb_driver(sr_driver);
 
 MODULE_AUTHOR("Liu Junliang <liujunliang_ljl@163.com");
-MODULE_VERSION(DRIVER_VERSION);
 MODULE_DESCRIPTION("SR9800 USB 2.0 USB2NET Dev : http://www.corechip-sz.com");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/usb/sr9800.h b/drivers/net/usb/sr9800.h
index 952e6f7c0321..98ac1c45740e 100644
--- a/drivers/net/usb/sr9800.h
+++ b/drivers/net/usb/sr9800.h
@@ -147,8 +147,7 @@
 #define SR_EEPROM_MAGIC			0xdeadbeef
 #define SR9800_EEPROM_LEN		0xff
 
-/* SR9800 Driver Version and Driver Name */
-#define DRIVER_VERSION			"11-Nov-2013"
+/* SR9800 Driver Name and Flags */
 #define DRIVER_NAME			"CoreChips"
 #define	DRIVER_FLAG		\
 	(FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |  FLAG_MULTI_PACKET)
-- 
2.43.0


