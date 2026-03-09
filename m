Return-Path: <netdev+bounces-265644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Id+Nq/9rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:04:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1B23D51B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72AC3087454
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3403E9F82;
	Mon,  9 Mar 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g/vakyoj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g/vakyoj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633A3E717D
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075403; cv=none; b=uTsyb09e3+vZt/2qPPQ97Wm2R/OPTsCm1h8cehqE7B4y5D+aQAP3am760mIODY0IXXT+vVO2ki7qYIHqSEp0f0HROvcvE+JhfDlQXU3Ao4RX8f0OPHdxUCeabMcFam8WgnOZyI9v0GHO9opdK/8YCsodvmbMHze2A8UI8nBfLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075403; c=relaxed/simple;
	bh=3IdCnAjLr8FZ5s3NOw+9wGTOcaDc9/4rwLaV6nyEQWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VECGyTT5fSLLglKGt258Z6J38jimpUAbEhwL/ZP8WgWbDh503q8I38rMlDEUDOGT6nnYrYscSoHz+slVnhxqJz+uy9690NH93dy5f29v/8YjeTB01ttHHLmKEjaxa8OPft8qbhSSD2o+GoyA1cQ91JS+52GIgor8Sinb9Jpmqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g/vakyoj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g/vakyoj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D21A4D23B;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naVP/+NdJq1iqFZZ7n6p5XqAlZC5hrfJeWBiGmQFMGU=;
	b=g/vakyoj1jSqbGYNZSzF8rZwcu6iznW6Z6yhM2r3qE76FrSNe1BzJhP18tQ2OaJl+iukU/
	0i5sQRRhmJ0iVg1CpIN9mwF1lbfF5nLTtKMwebVCY7TgUKLmpjoWvRYY7t60LjOqkDIEDg
	HzR9/Zti1i0/Uakf0YfDoRRt+8xGWkE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naVP/+NdJq1iqFZZ7n6p5XqAlZC5hrfJeWBiGmQFMGU=;
	b=g/vakyoj1jSqbGYNZSzF8rZwcu6iznW6Z6yhM2r3qE76FrSNe1BzJhP18tQ2OaJl+iukU/
	0i5sQRRhmJ0iVg1CpIN9mwF1lbfF5nLTtKMwebVCY7TgUKLmpjoWvRYY7t60LjOqkDIEDg
	HzR9/Zti1i0/Uakf0YfDoRRt+8xGWkE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D41F3EFDA;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yI8LBrj7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:24 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv5 05/13] net: usb: use accessor helper for usbnet private data
Date: Mon,  9 Mar 2026 17:53:28 +0100
Message-ID: <20260309165614.861929-5-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309165614.861929-1-oneukum@suse.com>
References: <20260309165614.861929-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 61E1B23D51B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265644-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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


