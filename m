Return-Path: <netdev+bounces-255042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLjMHjRgfGl0MAIAu9opvQ
	(envelope-from <netdev+bounces-255042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:39:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1152B7F83
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5583014555
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370673128A2;
	Fri, 30 Jan 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lURW+nxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CF313558
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758752; cv=none; b=fMCe5XppvJc4+OEy07GQZ7emOZXgEDrx95u0852v2w4vwqihSoaOppvi+3F0Y3sMNiqO/0bglKl8ByJEJH0PZuoix/UvKrgC5auUDeHrY3FUmvsdGwxT9i1C/lKrnHfC8AY55cs1GzQ1PQZWFHSVEtnh5AoG51uqidIWscPNhyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758752; c=relaxed/simple;
	bh=947Ihnztamc5xCRw/MGVHd3zDD8SrHrHL7SG/64BBXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVq9twIZL2qL7HsdkB9TYX4q8DJ/2gpIVzprxdpoqsR7TUbqOVZJ/WPdjxSNO7Dyszz2JyA5TDl4mnYxxlNSUZu8HIwVZa2/0QSKDzsHc8vrFw0Y2MucyZS9N5wb7rgUn2uMgKLYBMbGNqoQXcuDMHX/FvII+VnSfDrN9bOvkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lURW+nxZ; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-11f1fb91996so173473c88.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769758749; x=1770363549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdVE2+FCBzVjnnVs+2tHZ0yjRqOVQO47L49tKgXTrYw=;
        b=lURW+nxZxDrOQa7lZUhD0XUexud1wi1OuRgsi25Jk6GOLuZzQ62A4r86skKx3ChuVi
         e/br+84UFV3Jb+UQTp8lz/wtpLDkKRtiID2tiN4qOI314ZqixT0DLALCtQmcDhsldRit
         OZXmq7MlXmLOEySZtauHf2y3McPTPDhx2TNUo5fre9xBgGjjcL4IkUgp2VJz/0dU4nTT
         uaXnICRaDiDdkBauRDq4U7joN8HuKTzGngsUDUSe+JgqRCFCLq7b+yAq5BHqlCatJvDU
         twVqRPuGYmKSHmyH9nQ04WgM70f7WoRhaVKG3vfXktqUkGSrKelYHGmauKJ1ud/fkEXu
         0X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769758749; x=1770363549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdVE2+FCBzVjnnVs+2tHZ0yjRqOVQO47L49tKgXTrYw=;
        b=J9+hg3fBhaNvcsv5WmuoXiFZlgjVdzv3SZyckyFtVdayBZpFYVivpeMoQ8aHy1ZuA9
         9ao2rvdMphFoXBR/qLS4xX5ofbl6dtGHwO/SP2/ZRUwp6g5XwueC4IVeouceDaJVv3du
         wdiIYw0fJc3s4+vBxe1AmwqcTE606jsbMYazORl3vXZw/M3wU2zBN0L66eUWDMNLknNx
         DcLbVq3Xonzw6BgsCy5xK0jakfRt0SvA/CwAfhfV5C9Baj62iTd8A+ajxhw9Utxu3XcH
         7LYbvt3PMt19IY6Ogtd+DVHE0IB4XX1u22HJbWPoqNglwyKqOVMisLAxsMeFKtzo1iee
         GnNA==
X-Gm-Message-State: AOJu0YxqsIwzYN/zdE5oP+6dT+owiE90cICTt3oH5B28+Gy4qe5iXmfY
	GR7oTP6d2NfAzf6xH9Zj4DE2y6gfDPH9TRk9tz7ISGmJxQknUCHBAqI449EP8RNP
X-Gm-Gg: AZuq6aJGyhe0MJq5eKr1tKPZu38F6/rmdV6kcEtYiLgEvex8QCdOM6SADhj/jz3tVpp
	yNzgTQQ6p2JIgkZalv9aQ5/NzW0B73GZlcaoQ323s1kwi8h7JhLOW8TpWpdP6HMqE91RreEIKSY
	+oy+MpQ2lQI24ps29w5dLBuVmOj9w3JU2Vkj4ljzaPDxoYKeSTaAHVTIAQLsT3f+gDPRexfz+/e
	Pin+wApZqs6IfQKFNIGK/gJc53tBQLu7QAoAM5fLrg7cypvQYBj8WWlcWpckcwT80HmTGDqp8ke
	c7Q34a102Zurm3J4tZgGAzY5Fke7RL7OnhKv/5vTQ4gLOLhbzZyGndIqxWYnpsxV2vk8tFpzpY3
	u9dx3CLpVg3sUGVvX8rS+3iCMrUUXGAsH0ZVPGufrkpA1JwwS0UmoLcQHKatwG2fB/3JYc9FCvJ
	6ZWssAMtjh9vWnvGLK6tzgt/VnS8AsC7ws22UZPLUSZ3HL7+aOpIOeRvyyPXfCV5DgRRRBiNwge
	PQXKdJNhLzLrURBJzn6NmOWPnJZIBr6XNJHwWVR/FQRiwP36DkN3CJfBBg5AT+iiP0a+kkNY/2n
	qX+n
X-Received: by 2002:a05:7022:2486:b0:11b:9386:a3c0 with SMTP id a92af1059eb24-125c1041f6emr983267c88.43.1769758749278;
        Thu, 29 Jan 2026 23:39:09 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm10187112c88.9.2026.01.29.23.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:39:08 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
Subject: [PATCH net-next v3] net: usb: introduce usbnet_mii_ioctl helper function
Date: Thu, 29 Jan 2026 23:37:49 -0800
Message-ID: <20260130073810.29090-1-enelsonmoore@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,shawell.net,suse.com,linuxfoundation.org,pengutronix.de,online.de,piap.pl];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-255042-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1152B7F83
X-Rspamd-Action: no action

Many USB network drivers use identical code to pass ioctl
requests on to the MII layer. Reduce code duplication by
refactoring this code into a helper function.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev> (v1)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
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
index c73cf52a65a8..a453e4275e2f 100644
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
index 5540f7ec4906..f040b9673579 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -266,13 +266,6 @@ static void dm9601_get_drvinfo(struct net_device *net,
 	usbnet_get_drvinfo(net, info);
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
 	.get_link	= usbnet_get_link,
@@ -344,7 +337,7 @@ static const struct net_device_ops dm9601_netdev_ops = {
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
index ee8c6c9d3962..d32b0f78ab33 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -478,13 +478,6 @@ static void sr_get_drvinfo(struct net_device *net,
 	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
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
@@ -677,7 +670,7 @@ static const struct net_device_ops sr9800_netdev_ops = {
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


