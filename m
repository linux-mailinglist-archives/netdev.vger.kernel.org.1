Return-Path: <netdev+bounces-256069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAh9FuJQgWmLFgMAu9opvQ
	(envelope-from <netdev+bounces-256069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A644DD3695
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43FB300FEDC
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203C257824;
	Tue,  3 Feb 2026 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfrBXVhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CF242D7D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082525; cv=none; b=KavcGNMS9FU0ARr8A7m6OCciSa9LYFPWNMfpy6XrdXmjUjy1pAXq5uy9heawlpozdDglfIM+1Kc49hIc3h8SZNF4j2FPX9oEkf8AsLajf7sCaXBTGLLgrIYBim5SbsrH9EnuQwHpm+VgQsgTigf6n5qXVbsxgtVnXYzWCDw4r8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082525; c=relaxed/simple;
	bh=ubSZqGD8KRndaDPZhuNufGseCCQS66dakXBWku1wSdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkF9oCLeX0xxCKZcXNH69/BRIStNXTSOFeo5LOT+HDOX6N/gCs/whnIxQcwtMmg4uv3INlzhmnub4OI+jfsEZe8wNC0FeQepfQowFKktUadZn3g68qqF/VNFJRyBHGNma27HZSkvN87ByxG+QppAB1hwImIah2RVx1B9tQPuL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfrBXVhx; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b72e49776eso9256013eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 17:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770082522; x=1770687322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3o1VZHLx2eNSPx1eYPORrlHqiSo63azfjpKSmRzw8U=;
        b=YfrBXVhxhSDyFYe6LPikB7cxtehhEqHb13QwD/O1pLO+SoCeO7GYLyoiYDMS5VZ3NA
         JVej8tte6M/XmYaNSeRQyLYBjJAg2IWWyMJH9wyzEnPmJDrIRHU0EqCoKFjTYlZXhz0p
         xraRzjS+B25l2jEl4OdCazSQUK+eNuebFfBfgP/EH3yAU22AElPmpKcVOjdeiFs8puth
         LCEGD5lkFTNtFwwidTgiXNe14klRmAWrSj8puybRD7YQu1AeioLjitV2feyfft+dEXIh
         iZb9KO0AtNDYZWXiZMxzVgAHHtPB9eILaF40ZlG2gCuXABPZI1lto/N1Nm5cpcUDKJZ6
         7eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770082522; x=1770687322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3o1VZHLx2eNSPx1eYPORrlHqiSo63azfjpKSmRzw8U=;
        b=BH+1oCTBjWbAMxSsN7U9NCP8eW2OmM6KQPpoFWCA5OoQAhSmybNVriSL2lLe2Dl1jm
         uw9R816T42lPFEUE4vwH+jwklMF78Y/9a1j1oUOhjNv6jKYHMs9j64fpllfpiZqMtYIt
         EqqjjvKuXcrSrftX4fU2eObVibqWtYC5ZYq0M0zTsLyAFCW3tbcwPR5p1yBMl8d93UTe
         JhstY0XZK3YEB0AKYzdqsF11I5AIVC+tyKJJA2syf1GATW3Wv49noYBlgNPcoANDdazv
         QrCJldq9C8IkiWMRh9M7wKTjEvXKQEvkJ254s9T6qbn0rJm8TQuLg4FbEcGe7OSwKcsm
         ct0w==
X-Forwarded-Encrypted: i=1; AJvYcCX7+T2iCUv27tPl6tmH+ts2nNz2E4FwHONw314L+ltunEM+gUqi51D19HQJr2LfU235KzpiZlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxpEpjhsi5Z7S0HKDaufTfHiFNoVB36E900bpk5wbyKioBJ46
	AvEdR9lX1LaC9P9MN9zRJY5kIrubTZmSVBHrhILLTHm40Iwkt8qzKsHL
X-Gm-Gg: AZuq6aK87xHMKjorvo9Fv2rbMnA7wS1n95ztDCR3WCEU5jaQx/LWZh+0KBlNOSNNHAn
	pIwh4eY6rvRvaw//CeOGjCL0oqt4aI+6Z8sjphltZqPKEfBP7w2sMNJWsPGyLDFim55wdD3uCJI
	e1qqRuofCSCVgVIWfo2iFqGjd0ihrfdZj2rNLd44iynx8Z0Uz2OgX1yPTTKP5pyau+9cJxbfimd
	OQYMBgIoo0O1tzXyGnJFUvuEruHAUbvPQpr/GDKiL2yur6x3h+99LolN4Isz509TLCBql6fYN2+
	YmYwmuZsk6OUy446IocSe7z0CsOdXyM7x0s3JKvv9js1RsU7rvtz1R98bGYCzNTJWWKD/obPRBU
	nDgvXWkHcJnoAV+VtvRR0t1qlDRbuRNAGXB3u2M+SmZPANsunPK+GYorTQ7OcoM2sOC7BnuEEd5
	awVsvB1TE8YK1lap0SX7H6RuO01AzroDfJabjy1EpTn2NfL1Xrk9uo/ifPM+zMFpDpc2h0ML3hh
	9a2oOumJij4/OSwaLIg38JVHx2uNtMFycRo8i3LgMabLgYvN6ZBoaeitU0hdEmkgo/0i07hgarJ
	q9oW
X-Received: by 2002:a05:7300:fb83:b0:2b7:143a:9a8f with SMTP id 5a478bee46e88-2b7c863b842mr7317354eec.7.1770082522361;
        Mon, 02 Feb 2026 17:35:22 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe707sm21613380eec.18.2026.02.02.17.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 17:35:22 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v4] net: usb: introduce usbnet_mii_ioctl helper function
Date: Mon,  2 Feb 2026 17:34:55 -0800
Message-ID: <20260203013517.26170-1-enelsonmoore@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,shawell.net,suse.com,linuxfoundation.org,pengutronix.de,online.de,piap.pl,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-256069-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A644DD3695
X-Rspamd-Action: no action

Many USB network drivers use identical code to pass ioctl
requests on to the MII layer. Reduce code duplication by
refactoring this code into a helper function.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev> (v1)
Reviewed-by: Andrew Lunn <andrew@lunn.ch> (v3)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v4:
Rebase on latest net-next again
Changes in v3:
Rebase on latest net-next
Add changelog
Add received Reviewed-by tag
Changes in v2 (not numbered):
Resent with maintainer CCs

 drivers/net/usb/asix_devices.c | 11 ++---------
 drivers/net/usb/ax88179_178a.c |  8 +-------
 drivers/net/usb/dm9601.c       |  9 +--------
 drivers/net/usb/mcs7830.c      |  8 +-------
 drivers/net/usb/smsc75xx.c     |  4 +---
 drivers/net/usb/sr9800.c       |  9 +--------
 drivers/net/usb/usbnet.c       |  8 ++++++++
 include/linux/usb/usbnet.h     |  1 +
 8 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index d8744291d843..7eb6e86adb16 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -97,13 +97,6 @@ static u32 asix_get_phyid(struct usbnet *dev)
 	return phy_id;
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
@@ -190,7 +183,7 @@ static const struct net_device_ops ax88172_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= asix_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= ax88172_set_multicast,
 };
 
@@ -1269,7 +1262,7 @@ static const struct net_device_ops ax88178_netdev_ops = {
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
index 9e5649cefcbc..c8e0f8868210 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -259,13 +259,6 @@ static void dm9601_mdio_write(struct net_device *netdev, int phy_id, int loc,
 	dm_write_shared_word(dev, 1, loc, res);
 }
 
-static int dm9601_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
-}
-
 static const struct ethtool_ops dm9601_ethtool_ops = {
 	.get_drvinfo	= usbnet_get_drvinfo,
 	.get_link	= usbnet_get_link,
@@ -337,7 +330,7 @@ static const struct net_device_ops dm9601_netdev_ops = {
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= dm9601_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= dm9601_set_multicast,
 	.ndo_set_mac_address	= dm9601_set_mac_address,
 };
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index 3a551ad363d0..d6698f30218d 100644
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
@@ -468,7 +462,7 @@ static const struct net_device_ops mcs7830_netdev_ops = {
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= mcs7830_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode	= mcs7830_set_multicast,
 	.ndo_set_mac_address	= mcs7830_set_mac_address,
 };
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index fbc9d796f605..1a61a8bcf5d3 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -743,12 +743,10 @@ static const struct ethtool_ops smsc75xx_ethtool_ops = {
 
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
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index e3f6233e5866..6fd33a5b2279 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -469,13 +469,6 @@ static int sr_get_eeprom(struct net_device *net,
 	return 0;
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
@@ -668,7 +661,7 @@ static const struct net_device_ops sr9800_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address	= sr_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= sr_ioctl,
+	.ndo_eth_ioctl		= usbnet_mii_ioctl,
 	.ndo_set_rx_mode        = sr_set_multicast,
 };
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 9280ef544bbb..41b95b04143d 100644
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


