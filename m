Return-Path: <netdev+bounces-253051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLyuB618dGmr6AAAu9opvQ
	(envelope-from <netdev+bounces-253051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:02:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CAB7CF1D
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F61D3006B15
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A51184540;
	Sat, 24 Jan 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJmdP0/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC217C69
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769241770; cv=none; b=WXScfQ3rCpv3+ftfWmH/9VfQoOZB92mRFQP/LLfXf7cpKZEbgoU6+iiMTKtdf/ilUM4bbVWmfUWmBPSgnVjwZAP/aUi3mASP3rrv9Tf7m6pzHRkI9ERWQGetpVokdrN4PFVsUMsYnPqC7+3uLO7c0k/rV5urN2evj7reO/ECk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769241770; c=relaxed/simple;
	bh=ILVeAJyDZ0GM+ajIvnY420ls01RTNY0HVLZTaSGmOqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGAEpqOKCHVDBqsL5Qi52aIvkmiVKFSDG+OsVw+Nl+WqsxGPcG3yhf0Upoei+4nBmV8R/PQ3m9XeW2LdSfutKN8tWO1ltA1xccMdqEhHDK9A/lDDAOlFCAR3kj7ePV1D28jwYhlLQoHNr5J+CGnv1+1U6fQXVRsdfS2iPhqkbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJmdP0/m; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so2974399eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769241768; x=1769846568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QnDpU1bcNPne+nLGvcZgxoFDJikZoZAKPxEBzia2BE=;
        b=nJmdP0/mebF/LtU0CrCtiJY9UOTSnIbhFTwaiWfraMXpZSJuQTfIWrkjDeOp/+oQot
         dqPouhyh/I4TqZXeonDMPJiGA7XlTvQ3+mf1s2T+i8TMRtssA5gm9t5ZXW7KJQH2bNwF
         jM5dtIjUW97BLp/J3BC4qGBnZLsNPfD1FlRF+RqC51SwG4XNupJi5warQxCIALl9J4ZC
         YIaplp8TM0sYRbhlq+F+6yEu6dhEjR6GVgclu99qF7cmrQu9el/iCYaXB3fwy+I8FfPv
         0WXR8X5oLOYaVfgi2TunH6aI1JAeLMykgcPnnpPml59jIVZv/qMqRy/8Bml1Qn6hfEGk
         s1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769241768; x=1769846568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QnDpU1bcNPne+nLGvcZgxoFDJikZoZAKPxEBzia2BE=;
        b=H1Z7xRyVyKP/S7AzuLKLnXn0UFBzsCJ4tscsIle3/gc22FL7YYdWYvLLJp179SnQrR
         bpzpE2Wvo2Xejdyq0v6d9BBHjoynoh4sTFnRRcxYcTllR3TEEF83VsHmNtCyuA7lk8fE
         t0CgpxZV2TuWwJPdAJ6bd8OyZitcYbC7OoMnZ3lLrrV6KA6njj4jvoUTWTUeTPWuvnNe
         HY+C2d8OK4NQObi8N5y5bAXCBwl58EC/d0ZJGXM3xR3bkwgUb90T6Anw13KnguZPESaK
         LP92My9X7gpL0/TE9jANVFlTrd6UsX2vzMQbyfpygrp9bh9VACr3bMNtjt0aDAJyV3M/
         5Mrw==
X-Gm-Message-State: AOJu0Yxn49YXAAqlnJbI+rFtMWiVseYwReMhdhhEn4fmjKeacxNy5JA0
	9p8i1c50/8OjsZ12yihCN7SPyG+vtCQYEVxsBeRLaAxonjK2+tB30YgS8jQLGM4e
X-Gm-Gg: AZuq6aIQiI+yaIYwo7kw7XpHtSolPmE996eOjmnf1kjUlZwr+r5EC1Ys1PFEYhf2egS
	GBL+5SMK0SpxGjOwR/9GAiTRc21iB+uGnYgCyXSjgsQFfbJYWUr3eGUio2rHWrp93T8AOhV39Cs
	X6eL9bNQtu9SSVKNMw7+ThSVhn73Gd37CudAPEoT/SZ911cps/SF7AORt95X+XnP+fPEwtgCTIy
	qCiO1lq/FQIK/CZCIW0s9LHbt4GJY3ImBTXMC63uTIK8v0/pw/HOUND5acS3veocKSTHJ42ulpr
	zU7oqOiAiq6QyyB+NVwe2lKJQXi3sLh3vLHb/BCo8h57D3+P7M2sOq99JwdDwzri/1t21WlX4PE
	Um96Eot1r9t6ohRHMRJ2MJ8XzX9uA9Mp+FmwxVIG7N6vtOBwFR31r5w7JUHPkNEYc23B2j01TJC
	oK1NaYAlzN2KLU4tFnvCCPDCgmeWbDBYWOJ41fyij/ew8mInEp70gL6f+JgI5XqCP0vWdwRrReO
	77Y0qWQWhQU8Lzz1KVSF8gZyjNLJlWI3WzBKFDMkkK5jdxgjLwRtMhb9Wjq7Vu7XskSdDFPo2eh
	bdXs
X-Received: by 2002:a05:7300:cd87:b0:2ae:5e93:b6d with SMTP id 5a478bee46e88-2b739bce92fmr3538846eec.38.1769241768331;
        Sat, 24 Jan 2026 00:02:48 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6f5d10sm6548172eec.15.2026.01.24.00.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 00:02:47 -0800 (PST)
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
	Steve Glendinning <steve.glendinning@shawell.net>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper function
Date: Sat, 24 Jan 2026 00:01:15 -0800
Message-ID: <20260124080136.75619-1-enelsonmoore@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,shawell.net,suse.com,linuxfoundation.org,pengutronix.de,online.de,piap.pl];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-253051-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 97CAB7CF1D
X-Rspamd-Action: no action

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
 drivers/net/usb/sr9800.c       |  9 +--------
 drivers/net/usb/usbnet.c       |  8 ++++++++
 include/linux/usb/usbnet.h     |  1 +
 8 files changed, 16 insertions(+), 42 deletions(-)

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
index 2b4716ccf0c5..a31ad425a23d 100644
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


