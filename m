Return-Path: <netdev+bounces-263250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJItLA/2pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:54:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7D41F1D5D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC9E7302AAC8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546C374E79;
	Tue,  3 Mar 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fsv+8roz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KtTAK8P2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38147DD61
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549593; cv=none; b=fokyDcjjME78QrEcQyFQh9gqKh1c6af55hEptV2XPs6SjjZakBj3V0tUmwMClUve38C56qohZrMmz1xX8XcLHuh7mFiACvei3kSlypnItZDYmLqMQL72xmZfrOq4d5lCNdqiX1Qdgvop+i81LWvapssmQyWFBo9TRCtsCI6R8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549593; c=relaxed/simple;
	bh=3IdCnAjLr8FZ5s3NOw+9wGTOcaDc9/4rwLaV6nyEQWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPBT403FL1sK6ioVxz3wuPh2kB6MrqeaB06YAw9EMOH8sMJq2OOCtq8fOW/3ZBSVwJzputkutM6BlFgIY6OfIi0xHp9PbYvdPLC39eIdFyyYzZWZP71SBvPhyIJ0PwyGwnX8V81BPj3zv+ZdJ/Sqi7EXrnSyQ0gyKvgVWYbuu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fsv+8roz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KtTAK8P2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EB295BE17;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naVP/+NdJq1iqFZZ7n6p5XqAlZC5hrfJeWBiGmQFMGU=;
	b=Fsv+8rozebto+Y6qIm621FSr8qq0i3wnAyThsPGlTzEqnR7oCxBNwgnvK4qHHNtF1IYYhA
	VrrfOfsFgJGf8k8GeR26KlmJykbG6iJI0rZLiqVzCNgbNb/bCemxMYLccCPxHXX4yhIu+n
	SDhbh+fDbgEEk9y06yxxOcQYMVN5XQU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KtTAK8P2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naVP/+NdJq1iqFZZ7n6p5XqAlZC5hrfJeWBiGmQFMGU=;
	b=KtTAK8P2qlA2B7+nfEOdpnSuJZHNw4bTE68QDm3el5D/OKCVtIS0kwXu1gDNtmHqaqO8d6
	y7R0agmIFIlqoqBMHLuAsxnVV+eJwxWFonXY4K/s+CNfABKkyWgPXi22h5bIDKHPLmGD+e
	8FMfYnrx3MUXyIERXv14YpYrbjyJQl4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43CA23EA6F;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CHlbD8P1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 05/13] net: usb: use accessor helper for usbnet private data
Date: Tue,  3 Mar 2026 15:50:25 +0100
Message-ID: <20260303145242.1377514-5-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303145242.1377514-1-oneukum@suse.com>
References: <20260303145242.1377514-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BA7D41F1D5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263250-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use the new accessor function.
No functional change intended.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/asix_common.c  |  2 +-
 drivers/net/usb/asix_devices.c | 16 ++++++++--------
 drivers/net/usb/ax88172a.c     |  2 +-
 drivers/net/usb/cdc_ether.c    | 12 +++---------
 drivers/net/usb/cdc_mbim.c     | 18 +++++++++---------
 5 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e57655..add6493d4001 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -441,7 +441,7 @@ int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
 void asix_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	u16 rx_ctl = AX_DEFAULT_RX_CTL;
 
 	if (net->flags & IFF_PROMISC) {
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index df0bcfedddbc..979ee0110822 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -118,7 +118,7 @@ static const struct ethtool_ops ax88172_ethtool_ops = {
 static void ax88172_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	u8 rx_ctl = 0x8c;
 
 	if (net->flags & IFF_PROMISC) {
@@ -331,7 +331,7 @@ static const struct ethtool_ops ax88772_ethtool_ops = {
 
 static int ax88772_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	struct asix_common_private *priv = dev->driver_priv;
 	int ret;
 
@@ -361,7 +361,7 @@ static int ax88772_reset(struct usbnet *dev)
 
 static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	struct asix_common_private *priv = dev->driver_priv;
 	u16 rx_ctl;
 	int ret;
@@ -455,7 +455,7 @@ static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 
 static int ax88772a_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	struct asix_common_private *priv = dev->driver_priv;
 	u16 rx_ctl, phy14h, phy15h, phy16h;
 	int ret;
@@ -987,7 +987,7 @@ static const struct ethtool_ops ax88178_ethtool_ops = {
 
 static int marvell_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	u16 reg;
 
 	netdev_dbg(dev->net, "marvell_phy_init()\n");
@@ -1018,7 +1018,7 @@ static int marvell_phy_init(struct usbnet *dev)
 
 static int rtl8211cl_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 
 	netdev_dbg(dev->net, "rtl8211cl_phy_init()\n");
 
@@ -1065,7 +1065,7 @@ static int marvell_led_status(struct usbnet *dev, u16 speed)
 
 static int ax88178_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	int ret;
 	__le16 eeprom;
 	u8 status;
@@ -1163,7 +1163,7 @@ static int ax88178_link_reset(struct usbnet *dev)
 {
 	u16 mode;
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	u32 speed;
 
 	netdev_dbg(dev->net, "ax88178_link_reset()\n");
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 6b14bce2a552..f9b4364e0a0f 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -260,7 +260,7 @@ static void ax88172a_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 static int ax88172a_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->data;
+	struct asix_data *data = usbnet_priv(dev);
 	struct ax88172a_private *priv = dev->driver_priv;
 	int ret;
 	u16 rx_ctl;
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 505a653d9482..c24c14702f4b 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -85,16 +85,13 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8				*buf = intf->cur_altsetting->extra;
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = usbnet_priv(dev);
 	int				status;
 	int				rndis;
 	bool				android_rndis_quirk = false;
 	struct usb_driver		*driver = driver_of(intf);
 	struct usb_cdc_parsed_header header;
 
-	if (sizeof(dev->data) < sizeof(*info))
-		return -EDOM;
-
 	/* expect strict spec conformance for the descriptors, but
 	 * cope with firmware which stores them in the wrong place
 	 */
@@ -330,7 +327,7 @@ EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
 
 void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = usbnet_priv(dev);
 	struct usb_driver		*driver = driver_of(intf);
 
 	/* combined interface - nothing  to do */
@@ -368,10 +365,7 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
-	struct cdc_state		*info = (void *) &dev->data;
-
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data)
-			< sizeof(struct cdc_state)));
+	struct cdc_state		*info = usbnet_priv(dev);
 
 	status = usbnet_ether_cdc_bind(dev, intf);
 	if (status < 0)
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index dbf01210b0e7..5522dc137d45 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -43,7 +43,7 @@ enum cdc_mbim_flags {
 /* using a counter to merge subdriver requests with our own into a combined state */
 static int cdc_mbim_manage_power(struct usbnet *dev, int on)
 {
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 	int rv = 0;
 
 	dev_dbg(&dev->intf->dev, "%s() pmcount=%d, on=%d\n", __func__, atomic_read(&info->pmcount), on);
@@ -72,7 +72,7 @@ static int cdc_mbim_wdm_manage_power(struct usb_interface *intf, int status)
 static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 
 	/* creation of this VLAN is a request to tag IP session 0 */
 	if (vid == MBIM_IPS0_VID)
@@ -86,7 +86,7 @@ static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 static int cdc_mbim_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 
 	/* this is a request for an untagged IP session 0 */
 	if (vid == MBIM_IPS0_VID)
@@ -143,7 +143,7 @@ static int cdc_mbim_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_driver *subdriver = ERR_PTR(-ENODEV);
 	int ret = -ENODEV;
 	u8 data_altsetting = 1;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 
 	/* should we change control altsetting on a NCM/MBIM function? */
 	if (cdc_ncm_select_altsetting(intf) == CDC_NCM_COMM_ALTSETTING_MBIM) {
@@ -195,7 +195,7 @@ static int cdc_mbim_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void cdc_mbim_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 
 	/* disconnect subdriver from control interface */
@@ -221,7 +221,7 @@ static bool is_ip_proto(__be16 proto)
 static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 {
 	struct sk_buff *skb_out;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	__le32 sign = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN);
 	u16 tci = 0;
@@ -411,7 +411,7 @@ static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_
 static int cdc_mbim_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	int len;
 	int nframes;
@@ -506,7 +506,7 @@ static int cdc_mbim_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	int ret = -ENODEV;
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 
 	if (!ctx)
@@ -534,7 +534,7 @@ static int cdc_mbim_resume(struct usb_interface *intf)
 {
 	int  ret = 0;
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct cdc_mbim_state *info = (void *)&dev->data;
+	struct cdc_mbim_state *info = usbnet_priv(dev);
 	struct cdc_ncm_ctx *ctx = info->ctx;
 	bool callsub = (intf == ctx->control && info->subdriver && info->subdriver->resume);
 
-- 
2.53.0


