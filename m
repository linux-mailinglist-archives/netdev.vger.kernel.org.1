Return-Path: <netdev+bounces-247602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E20CFC44B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6330D3032AC9
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2226560D;
	Wed,  7 Jan 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG0rAEGB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62007254B19
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769091; cv=none; b=i0lDSyxRYI8eVjLFDvyzOSnq7O9d4A/x3gxPP8MD7/EjJ49NOnzxir4IZ3hVSj0MhrBaGa7/76k1Aij+M34uLw6PfuS86gd32ApyXpvYv7Z9SBuvcNNOGhJLQQzlKtlFWBCPMsh6K7xvHABZ+B6zF3NiDDdGbzL13Wc8QHqIpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769091; c=relaxed/simple;
	bh=5QY5FIMgCIVLSJg31pbSboDlIXV7DjUI6dGloa0mRIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0uIYXqC7c4nohdIL1q5ONtQIgTKVwD8xC46HrXPWmrwZF9OnY/wM8sLT8IXr40/B0djYgwCgeoQiITyyf6y4SbiAP7YjdpcdE79dQKFXH3YuZLS3Hbzs7SO3Mw7rnHDl6SBDUBxVytIP2WO4eqHFV2T/a7VZemK5YgIQOlL8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG0rAEGB; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11f36012fb2so1468955c88.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769088; x=1768373888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzVpwGkuo2wK1NCO3TJEGzaN9YYfSDBDSl22TYC6BeU=;
        b=UG0rAEGBhjnd0r0vHDI0828cwihCpbMA8u2LZEVTrGiSYeT5qGwyYgfmG79N9ihowW
         DBTv/CCPVR1yuN3OsAvxFaUDhYlGkCz2zMmsvIjPRIrP/zlVe/4rT3+qM6xvZk3xGvbV
         QqxHdV2ImN1qafqCmZ1jjF6It0O6pqeR817r0MVD4jRGQdv6Ey8TPCQmcJYLEA2jP0NM
         vKOpvXeyg8nKPtskqlAvr50E2JQ2Ido6Zgg7sxOMuI814e1oIk0K6cyK4HYqjvQMVRfV
         Vr9/toaa2DnlKA+l2vYbE8ma7RCEPPMZDuVlJTFKmc4QS9seHJEMhmoBCERP5lU8XVwC
         1HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769088; x=1768373888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzVpwGkuo2wK1NCO3TJEGzaN9YYfSDBDSl22TYC6BeU=;
        b=n+jZWk3aoSMiT5rPd4sgtSmUDujzCD5WWyDpzKgXRBZO1TmOKTldqCTAWFj9p148d6
         Ygc8N3+MWPrOT3er6hLRHiSwkqot8GcTrCjkWnt8gIWdWBPd7rxAsmsQN0E+9r78Kvut
         wxTWZqgixmcHj6Krtxr47NmfygsSl/KB8Ep7f3bRYjkWbxGaEWUC+Ws7CLfudRI8f88H
         jOXcIdamxpSWxCXmFZ0zEgX7d7VrF0BtRM6t97RA6w6Kp8S5E8cwey+Ud1GXyovzmRzZ
         vdp9cvIPGUMtZn42Lje9SYe3LVM4eDoNKRqufoYntWN5qBITcWByNiOCceaS66kueFak
         430A==
X-Gm-Message-State: AOJu0YwSMrDjpCRF+kipOhiSTk8z0R140QxL4+dDPHpIuzg8tpRdfbNV
	o5ibvr1PCzgI1Edx+cF1yIJAEGcY7rQNzM2+nc4RyqrfGXdshDnYpjqRbRSxk8xf
X-Gm-Gg: AY/fxX6KSRhGI0SesMrrvDYMnn0RYpbthfVtycRMvjWCMxeAASV9RpvH76CDOYQBymX
	+A2rXlLeVB5FUfVbbTwTrZS5OqQuQNFb9n1BXM44bdVBFq882kn9cBttAkHyru9pq/eSEioNdrA
	lRRXcTe0fVfmACOhilQ3Bf2sNpb6lDU2g2Dlh7XmkuwqnFZoefBuKTMvQeftAgavJ6lPuKTtV3F
	T/w8Ep43sDIpRISvTgdlqRxokEVYQ3YwAj9wrvJODPOTkmfXxfxjCLSjQolupPhQ3Mm9/equ7de
	mU5LHi1IVPsISHvrdzU+tBCL/eEfg4Dky6y4AvMtsRqCauzpc/wO2VAZojkEf13/Y4ybxXcFeXX
	WUOoa2jYtyzMyRdNeumPtUe4mL7n0oPjvTatDCBeTCcGeWrWo2rTOAuxBhNf2Z5e4PpJ4BQO3mP
	53TCqzlRnu+OoabAHShkw5ZyIb0MC/h/RYohn1FfuHvv0659DLFxhV2gXL80v+v+3WMMTZOluA0
	XgjU/nGij1vRJZtzzw+C8tytCGBIRRGD1fbz4vNlfioj1dn8sT/RVvcEAlDgnvrsGFyCR3YeAIi
	OArdgaWzyh99K2c=
X-Google-Smtp-Source: AGHT+IHetqul1KehGZbGZc45AEYoK+TSIbCNtbiB8DmsLKfsrYXODgpvqKBFom0gF3DIrBh7aBvMhw==
X-Received: by 2002:a05:7022:41d:b0:11a:342e:8a98 with SMTP id a92af1059eb24-121f8a3172fmr1531888c88.0.1767769088175;
        Tue, 06 Jan 2026 22:58:08 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm9145379c88.2.2026.01.06.22.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:58:07 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper function
Date: Tue,  6 Jan 2026 22:57:48 -0800
Message-ID: <20260107065749.21800-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many USB network drivers use identical code to pass ioctl
requests on to the MII layer. Reduce code duplication by
refactoring this code into a helper function.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/asix_devices.c | 11 ++---------
 drivers/net/usb/ax88179_178a.c |  8 +-------
 drivers/net/usb/dm9601.c       |  9 +--------
 drivers/net/usb/mcs7830.c      |  8 +-------
 drivers/net/usb/smsc75xx.c     |  4 +---
 drivers/net/usb/sr9700.c       |  9 +--------
 drivers/net/usb/sr9800.c       |  9 +--------
 drivers/net/usb/usbnet.c       |  8 ++++++++
 include/linux/usb/usbnet.h     |  1 +
 9 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 232bbd79a4de..9f6d6ddbbc4b 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -104,13 +104,6 @@ static u32 asix_get_link(struct net_device *net)
 	return mii_link_ok(&dev->mii);
 }
 
-static int asix_ioctl (struct net_device *net, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 /* We need to override some ethtool_ops so we require our
    own structure so we don't interfere with other usbnet
    devices that may be connected at the same time. */
@@ -197,7 +190,7 @@ static const struct net_device_ops ax88172_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= asix_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= ax88172_set_multicast,
 };
 
@@ -1276,7 +1269,7 @@ static const struct net_device_ops ax88178_netdev_ops = {
 	.ndo_set_mac_address 	= asix_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= asix_set_multicast,
-	.ndo_eth_ioctl		= asix_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_change_mtu 	= ax88178_change_mtu,
 };
 
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index b034ef8a73ea..0e9ae89b840e 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -847,12 +847,6 @@ static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 	return ret;
 }
 
-static int ax88179_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(net);
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 static const struct ethtool_ops ax88179_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
@@ -998,7 +992,7 @@ static const struct net_device_ops ax88179_netdev_ops = {
 	.ndo_change_mtu		= ax88179_change_mtu,
 	.ndo_set_mac_address	= ax88179_set_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= ax88179_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= ax88179_set_multicast,
 	.ndo_set_features	= ax88179_set_features,
 };
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 8b6d6a1b3c2e..d31094d4af5a 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -273,13 +273,6 @@ static u32 dm9601_get_link(struct net_device *net)
 	return mii_link_ok(&dev->mii);
 }
 
-static int dm9601_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 static const struct ethtool_ops dm9601_ethtool_ops = {
 	.get_drvinfo	= dm9601_get_drvinfo,
 	.get_link	= dm9601_get_link,
@@ -351,7 +344,7 @@ static const struct net_device_ops dm9601_netdev_ops = {
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= dm9601_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= dm9601_set_multicast,
 	.ndo_set_mac_address	= dm9601_set_mac_address,
 };
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index fdda0616704e..1aa57645f9ca 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -325,12 +325,6 @@ static void mcs7830_mdio_write(struct net_device *netdev, int phy_id,
 	mcs7830_write_phy(dev, location, val);
 }
 
-static int mcs7830_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(net);
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 static inline struct mcs7830_data *mcs7830_get_data(struct usbnet *dev)
 {
 	return (struct mcs7830_data *)&dev->data;
@@ -473,7 +467,7 @@ static const struct net_device_ops mcs7830_netdev_ops = {
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= mcs7830_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= mcs7830_set_multicast,
 	.ndo_set_mac_address	= mcs7830_set_mac_address,
 };
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 78c821349f48..cbc7101e05a6 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -744,12 +744,10 @@ static const struct ethtool_ops smsc75xx_ethtool_ops = {
 
 static int smsc75xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 {
-	struct usbnet *dev = netdev_priv(netdev);
-
 	if (!netif_running(netdev))
 		return -EINVAL;
 
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
+	return usbnet_mii_ioctl(netdev, rq, cmd);
 }
 
 static void smsc75xx_init_mac_address(struct usbnet *dev)
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 820c4c506979..1c5a809eed87 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -243,13 +243,6 @@ static u32 sr9700_get_link(struct net_device *netdev)
 	return rc;
 }
 
-static int sr9700_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(netdev);
-
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 static const struct ethtool_ops sr9700_ethtool_ops = {
 	.get_drvinfo	= usbnet_get_drvinfo,
 	.get_link	= sr9700_get_link,
@@ -318,7 +311,7 @@ static const struct net_device_ops sr9700_netdev_ops = {
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= sr9700_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= sr9700_set_multicast,
 	.ndo_set_mac_address	= sr9700_set_mac_address,
 };
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 57947a5590cc..df267e792aae 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -485,13 +485,6 @@ static u32 sr_get_link(struct net_device *net)
 	return mii_link_ok(&dev->mii);
 }
 
-static int sr_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 static int sr_set_mac_address(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -684,7 +677,7 @@ static const struct net_device_ops sr9800_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address	= sr_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= sr_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode        = sr_set_multicast,
 };
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 36742e64cff7..dbe0345ae63a 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1085,6 +1085,14 @@ int usbnet_nway_reset(struct net_device *net)
 }
 EXPORT_SYMBOL_GPL(usbnet_nway_reset);
 
+int usbnet_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
+{
+	struct usbnet *dev = netdev_priv(net);
+
+	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
+}
+EXPORT_SYMBOL_GPL(usbnet_mii_ioctl);
+
 void usbnet_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
 {
 	struct usbnet *dev = netdev_priv(net);
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 2945923a8a95..b0e84896e6ac 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -290,6 +290,7 @@ extern u32 usbnet_get_msglevel(struct net_device *);
 extern void usbnet_set_msglevel(struct net_device *, u32);
 extern void usbnet_set_rx_mode(struct net_device *net);
 extern void usbnet_get_drvinfo(struct net_device *, struct ethtool_drvinfo *);
+extern int usbnet_mii_ioctl(struct net_device *net, struct ifreq *rq, int cmd);
 extern int usbnet_nway_reset(struct net_device *net);
 
 extern int usbnet_manage_power(struct usbnet *, int);
-- 
2.43.0


