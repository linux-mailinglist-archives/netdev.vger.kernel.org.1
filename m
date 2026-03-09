Return-Path: <netdev+bounces-265649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPeGFmf8rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:59:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2223D394
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48D4A301E5C8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3C3EB81A;
	Mon,  9 Mar 2026 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sQr7q88a";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sQr7q88a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7253ED11B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075422; cv=none; b=buriSBvT7clxSM4GWwPg6Jd27qoXRxFxIFSVZWYORAUSw2zKMwN59dtuxJWTss8a2UJTeMqINozc8hy3D+0xgTzPk4Bve3N6xNzq377OB5uhqww4nCQ50elpT2Iss5EiZoDN3Z0cys5Nkawz9674LNK/GE8HBKh2jlwsyHFcJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075422; c=relaxed/simple;
	bh=JWhLpEgV4+9VDBh3hnM3FZtbOym5QBjR/imvyX5KKgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6uz56gpTyN/nlAojnCxjMMcwZLb2Vb63adF7XWu/Wi5x6UFWVTZyJ2rdwNASr1R8TjYJJ2B8h4z53ezNRjJTflZp8oKnFPtwkRtlb789ecjErqlbjeDdSTJNyVDg+lSlk+CxwLeB4AUt4OQGX/PZkNwxX2xJ8ZgNY0AmV3Qomo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sQr7q88a; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sQr7q88a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0487A5BE5B;
	Mon,  9 Mar 2026 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Vrde8nZ7Pa8Jb9SxrcxuaTyKgBox9FHS4LUe+7t9wI=;
	b=sQr7q88aI870zq0FM6mCKiJyZXn9p3SZ0KygBelTb6h/AiyiAuiV4rcNRehonqyKf4LQz6
	PsNK+FHTNK53QQeHrZFW8yiRjKw6Q2tAfLFTu7P4iyeubDMfwOpMxAhEydhUBROlKzYvqW
	Crqu0LI4Xf3Ifw0jvPs6MS5wvZ6vMG8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sQr7q88a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Vrde8nZ7Pa8Jb9SxrcxuaTyKgBox9FHS4LUe+7t9wI=;
	b=sQr7q88aI870zq0FM6mCKiJyZXn9p3SZ0KygBelTb6h/AiyiAuiV4rcNRehonqyKf4LQz6
	PsNK+FHTNK53QQeHrZFW8yiRjKw6Q2tAfLFTu7P4iyeubDMfwOpMxAhEydhUBROlKzYvqW
	Crqu0LI4Xf3Ifw0jvPs6MS5wvZ6vMG8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8E0D3EFD8;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gA3fM7j7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:24 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 10/13] net: usb: sierra_net: use dynamic private allocation
Date: Mon,  9 Mar 2026 17:53:33 +0100
Message-ID: <20260309165614.861929-10-oneukum@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: F3B2223D394
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265649-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The old style private room was too small for sierra_net.
With dynamic allocation that factor is gone.
Remove handling private allocations in the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/sierra_net.c | 42 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 5a32796a7a89..9a721413bdf4 100644
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
@@ -653,7 +642,7 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8	numendpoints;
 	u16	fwattr = 0;
 	int	status;
-	struct sierra_net_data *priv;
+	struct sierra_net_data *priv = usbnet_priv(dev);
 	static const u8 sync_tmplate[sizeof(priv->sync_msg)] = {
 		0x00, 0x00, SIERRA_NET_HIP_MSYNC_ID, 0x00};
 	static const u8 shdwn_tmplate[sizeof(priv->shdwn_msg)] = {
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


