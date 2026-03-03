Return-Path: <netdev+bounces-263251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBGmBxz2pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:54:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C41F1D6B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C533084130
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216A47DD6F;
	Tue,  3 Mar 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJlY7rdg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJlY7rdg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1147CC8A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549593; cv=none; b=uAUPDB2mHSPcpq5sBLJKzt2+Lrjeymg+ZEJyLf4CoZ7SOyyvbU/PRGCooBvbccNQjvLg4wyWFNmSMTxKkBN4qq5avPEhdW4Ig+agYL8qIuHplm1wds9q3+1pT/Ww37+8tceAIO1X6LUBMzI/5j13l6ac0j60DjAx1iRc57x3aNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549593; c=relaxed/simple;
	bh=dDeUJX653FNU/AIH3YM5TRxstf+411RJPfY3vk3Ui9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUkN+9Co87VvAtf/Hz4+20ghmvuyFix/SHLbn3dlKQbVNoj497lHimcMI45vYfi2Qpo5SUAN7yTQfengSm932Bz2oervR7FO+TryH6xeW+7P+hcH2daR5SbtGyZfkezv+ImLq6aLy88RYIu4sl/Dcu/MEsdI5oRYUukXVIkNjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJlY7rdg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJlY7rdg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 421123F91B;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IVtmR4sLU/EB+OFBr4xMYkuAsfEj+dLA1J3A6Dsd9Q=;
	b=LJlY7rdgs19OGkJn7eFHxqoR2TjnTG1jOeefqbL84orfJJDyph+pyyrttbauPyPVmfFY9A
	zSq/9IpZ0wZTMnWOpHlj5MYAKuXo7JmRIP68HjZhcd3TgoLVd3eTBymPfnh6t2PQBCEvsj
	IvwUhZnirxTwKrfOg+LOP1HletWcCs4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LJlY7rdg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IVtmR4sLU/EB+OFBr4xMYkuAsfEj+dLA1J3A6Dsd9Q=;
	b=LJlY7rdgs19OGkJn7eFHxqoR2TjnTG1jOeefqbL84orfJJDyph+pyyrttbauPyPVmfFY9A
	zSq/9IpZ0wZTMnWOpHlj5MYAKuXo7JmRIP68HjZhcd3TgoLVd3eTBymPfnh6t2PQBCEvsj
	IvwUhZnirxTwKrfOg+LOP1HletWcCs4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22F9B3EA69;
	Tue,  3 Mar 2026 14:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WMM3B8T1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:52 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 10/13] net: usb: sierra_net: use dynamic private allocation
Date: Tue,  3 Mar 2026 15:50:30 +0100
Message-ID: <20260303145242.1377514-10-oneukum@suse.com>
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
X-Rspamd-Queue-Id: 8D9C41F1D6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263251-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

The old style private room was too small for sierra_net.
With dynamic allocation that factor is gone.
Remove handling private allocations in the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/sierra_net.c | 40 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 5a32796a7a89..ef373e402d51 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -187,19 +187,6 @@ static const struct net_device_ops sierra_net_device_ops = {
 	.ndo_validate_addr      = eth_validate_addr,
 };
 
-/* get private data associated with passed in usbnet device */
-static inline struct sierra_net_data *sierra_net_get_private(struct usbnet *dev)
-{
-	return (struct sierra_net_data *)dev->data[0];
-}
-
-/* set private data associated with passed in usbnet device */
-static inline void sierra_net_set_private(struct usbnet *dev,
-			struct sierra_net_data *priv)
-{
-	dev->data[0] = (unsigned long)priv;
-}
-
 /* is packet IPv4/IPv6 */
 static inline int is_ip(struct sk_buff *skb)
 {
@@ -317,7 +304,7 @@ static void build_hip(u8 *buf, const u16 payloadlen,
 static int sierra_net_send_cmd(struct usbnet *dev,
 		u8 *cmd, int cmdlen, const char * cmd_name)
 {
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 	int  status;
 
 	status = usbnet_write_cmd(dev, USB_CDC_SEND_ENCAPSULATED_COMMAND,
@@ -333,7 +320,7 @@ static int sierra_net_send_cmd(struct usbnet *dev,
 static int sierra_net_send_sync(struct usbnet *dev)
 {
 	int  status;
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 
@@ -410,7 +397,7 @@ static int sierra_net_parse_lsi(struct usbnet *dev, char *data, int datalen)
 static void sierra_net_handle_lsi(struct usbnet *dev, char *data,
 		struct hip_hdr	*hh)
 {
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 	int link_up;
 
 	link_up = sierra_net_parse_lsi(dev, data + hh->hdrlen,
@@ -431,7 +418,7 @@ static void sierra_net_handle_lsi(struct usbnet *dev, char *data,
 static void sierra_net_dosync(struct usbnet *dev)
 {
 	int status;
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 
@@ -560,7 +547,7 @@ static void sierra_net_kevent(struct work_struct *work)
 
 static void sierra_net_defer_kevent(struct usbnet *dev, int work)
 {
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 
 	set_bit(work, &priv->kevent_flags);
 	schedule_work(&priv->sierra_net_kevent);
@@ -608,8 +595,10 @@ static void sierra_net_status(struct usbnet *dev, struct urb *urb)
 static u32 sierra_net_get_link(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct sierra_net_data *priv = usbnet_priv(dev);
+
 	/* Report link is down whenever the interface is down */
-	return sierra_net_get_private(dev)->link_up && netif_running(net);
+	return priv->link_up && netif_running(net);
 }
 
 static const struct ethtool_ops sierra_net_ethtool_ops = {
@@ -682,11 +671,8 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev_err(&dev->udev->dev, "No status endpoint found");
 		return -ENODEV;
 	}
-	/* Initialize sierra private data */
-	priv = kzalloc_obj(*priv);
-	if (!priv)
-		return -ENOMEM;
 
+	/* Initialize sierra private data */
 	priv->usbnet = dev;
 	priv->ifnum = ifacenum;
 	dev->net->netdev_ops = &sierra_net_device_ops;
@@ -718,8 +704,6 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->ethtool_ops = &sierra_net_ethtool_ops;
 	netif_carrier_off(dev->net);
 
-	sierra_net_set_private(dev, priv);
-
 	priv->kevent_flags = 0;
 
 	/* Use the shared workqueue */
@@ -747,7 +731,7 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 static void sierra_net_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int status;
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 
 	dev_dbg(&dev->udev->dev, "%s", __func__);
 
@@ -764,7 +748,6 @@ static void sierra_net_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 	usbnet_status_stop(dev);
 
-	sierra_net_set_private(dev, NULL);
 	kfree(priv);
 }
 
@@ -851,7 +834,7 @@ static int sierra_net_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 static struct sk_buff *sierra_net_tx_fixup(struct usbnet *dev,
 					   struct sk_buff *skb, gfp_t flags)
 {
-	struct sierra_net_data *priv = sierra_net_get_private(dev);
+	struct sierra_net_data *priv = usbnet_priv(dev);
 	u16 len;
 	bool need_tail;
 
@@ -905,6 +888,7 @@ static const struct driver_info sierra_net_info_direct_ip = {
 	.status = sierra_net_status,
 	.rx_fixup = sierra_net_rx_fixup,
 	.tx_fixup = sierra_net_tx_fixup,
+	.required_room = sizeof(struct sierra_net_data),
 };
 
 static int
-- 
2.53.0


