Return-Path: <netdev+bounces-266945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE53NGF9smkcNAAAu9opvQ
	(envelope-from <netdev+bounces-266945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:46:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB626F1DF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F793027B78
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35223750B3;
	Thu, 12 Mar 2026 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfpsD2Yw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mfpsD2Yw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CDC1C3F0C
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305182; cv=none; b=sdSumHiPDq9xw/LkzV3IJlcLIibE55PA5jkLYaJSMp1+cgr+EwZbc5gGJiTuDKEhC3jiozP3cLc9n7E1jFRFGiDxPgGyfnI2uYDbGBXHLTosrv7KFXyLV4/Uh2nMRpunfpr2Zyv1uLxZW7etKnG9CtOsjzK6L6xgA2RvB3Knb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305182; c=relaxed/simple;
	bh=lRneqrBse5iE4f5KN0Vi0p7riTduE91DU2hkP3wHz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYiyCvMExIB5m5EZunF4YLuVgfws4HYReVrLG2BWt5KRb2ofD+bChh7l0Zah4c035fRD3xN/JqFUQ1pSmas+4GE2tGgzYo9D6Qq+mg8vvhkpDYGJPdqrvCYfOmoaKrJzLhvgkuTSSQv/bWMBPwf1G+L3WkFt+QSg7ZEbI82w4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfpsD2Yw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mfpsD2Yw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF8C05C0A9;
	Thu, 12 Mar 2026 08:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773305179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pEJJ+p96t4oQiCAzM1jGrjr4e8RntKOJTw3Pgh8Z8xs=;
	b=mfpsD2YwjiZ6hjT31ix3XF5moLOhAK5FkCdMpa7uwB3toauLiI1aI2DvixNkL55ntnjEMC
	+OpGQQWRMYIlnvGIsj2mOP9/SFMqyfHwDKJXCuovlIFrR5VjTxAjgvk4ql/29x/buP8Jpx
	U8YGL3rx8+dKksUwQ6yW9PVCv4ycM0I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773305179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pEJJ+p96t4oQiCAzM1jGrjr4e8RntKOJTw3Pgh8Z8xs=;
	b=mfpsD2YwjiZ6hjT31ix3XF5moLOhAK5FkCdMpa7uwB3toauLiI1aI2DvixNkL55ntnjEMC
	+OpGQQWRMYIlnvGIsj2mOP9/SFMqyfHwDKJXCuovlIFrR5VjTxAjgvk4ql/29x/buP8Jpx
	U8YGL3rx8+dKksUwQ6yW9PVCv4ycM0I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 950EC3FEA0;
	Thu, 12 Mar 2026 08:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id adFFI1t9smkTewAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 12 Mar 2026 08:46:19 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 1/1 net-next] net: usb: cdc-ether: unify error handling in probe
Date: Thu, 12 Mar 2026 09:45:32 +0100
Message-ID: <20260312084612.1469853-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266945-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FEB626F1DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

usbnet_generic_cdc_bind() is duplicating the error handling
multiple times. That is bad. Unify it with jumps.

V2: Update error logging with every cause a unique message

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c | 54 ++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a032c1ded406..a0a5740590b9 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -115,7 +115,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
 	struct cdc_state		*info = (void *) &dev->data;
-	int				status;
+	int				status = -ENODEV;
 	int				rndis;
 	bool				android_rndis_quirk = false;
 	struct usb_driver		*driver = driver_of(intf);
@@ -169,10 +169,13 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	info->header = header.usb_cdc_header_desc;
 	info->ether = header.usb_cdc_ether_desc;
 	if (!info->u) {
-		if (rndis)
+		if (rndis) {
 			goto skip;
-		else /* in that case a quirk is mandatory */
+		} else {
+			/* in that case a quirk is mandatory */
+			dev_err(&dev->udev->dev, "No union descriptors\n");
 			goto bad_desc;
+		}
 	}
 	/* we need a master/control interface (what we're
 	 * probed with) and a slave/data interface; union
@@ -192,18 +195,20 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 			android_rndis_quirk = true;
 			goto skip;
 		}
+		dev_err(&intf->dev, "bad CDC descriptors\n");
 		goto bad_desc;
 	}
 	if (info->control != intf) {
-		dev_dbg(&intf->dev, "bogus CDC Union\n");
 		/* Ambit USB Cable Modem (and maybe others)
 		 * interchanges master and slave interface.
 		 */
 		if (info->data == intf) {
 			info->data = info->control;
 			info->control = intf;
-		} else
+		} else {
+			dev_err(&intf->dev, "bogus CDC Union\n");
 			goto bad_desc;
+		}
 	}
 
 	/* some devices merge these - skip class check */
@@ -213,7 +218,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* a data interface altsetting does the real i/o */
 	d = &info->data->cur_altsetting->desc;
 	if (d->bInterfaceClass != USB_CLASS_CDC_DATA) {
-		dev_dbg(&intf->dev, "slave class %u\n", d->bInterfaceClass);
+		dev_err(&intf->dev, "slave class %u\n", d->bInterfaceClass);
 		goto bad_desc;
 	}
 skip:
@@ -227,7 +232,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (rndis && is_rndis(&intf->cur_altsetting->desc) &&
 	    header.usb_cdc_acm_descriptor &&
 	    header.usb_cdc_acm_descriptor->bmCapabilities) {
-		dev_dbg(&intf->dev,
+		dev_err(&intf->dev,
 			"ACM capabilities %02x, not really RNDIS?\n",
 			header.usb_cdc_acm_descriptor->bmCapabilities);
 		goto bad_desc;
@@ -242,14 +247,14 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	if (header.usb_cdc_mdlm_desc &&
 	    memcmp(header.usb_cdc_mdlm_desc->bGUID, mbm_guid, 16)) {
-		dev_dbg(&intf->dev, "GUID doesn't match\n");
+		dev_err(&intf->dev, "GUID doesn't match\n");
 		goto bad_desc;
 	}
 
 	if (header.usb_cdc_mdlm_detail_desc &&
 		header.usb_cdc_mdlm_detail_desc->bLength <
 			(sizeof(struct usb_cdc_mdlm_detail_desc) + 1)) {
-		dev_dbg(&intf->dev, "Descriptor too short\n");
+		dev_err(&intf->dev, "Descriptor too short\n");
 		goto bad_desc;
 	}
 
@@ -267,7 +272,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 		info->control = usb_ifnum_to_if(dev->udev, 0);
 		info->data = usb_ifnum_to_if(dev->udev, 1);
 		if (!info->control || !info->data || info->control != intf) {
-			dev_dbg(&intf->dev,
+			dev_err(&intf->dev,
 				"rndis: master #0/%p slave #1/%p\n",
 				info->control,
 				info->data);
@@ -275,7 +280,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 		}
 
 	} else if (!info->header || (!rndis && !info->ether)) {
-		dev_dbg(&intf->dev, "missing cdc %s%s%sdescriptor\n",
+		dev_err(&intf->dev, "missing cdc %s%s%sdescriptor\n",
 			info->header ? "" : "header ",
 			info->u ? "" : "union ",
 			info->ether ? "" : "ether ");
@@ -287,16 +292,15 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	 */
 	if (info->data != info->control) {
 		status = usb_driver_claim_interface(driver, info->data, dev);
-		if (status < 0)
-			return status;
+		if (status < 0) {
+			dev_err(&intf->dev, "Second interface unclaimable\n");
+			goto bad_desc;
+		}
 	}
 	status = usbnet_get_endpoints(dev, info->data);
 	if (status < 0) {
-		/* ensure immediate exit from usbnet_disconnect */
-		usb_set_intfdata(info->data, NULL);
-		if (info->data != info->control)
-			usb_driver_release_interface(driver, info->data);
-		return status;
+		dev_dbg(&intf->dev, "Mandatory endpoints missing\n");
+		goto bail_out_and_release;
 	}
 
 	/* status endpoint: optional for CDC Ethernet, not RNDIS (or ACM) */
@@ -316,10 +320,9 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 		}
 	}
 	if (rndis && !dev->status) {
-		dev_dbg(&intf->dev, "missing RNDIS status endpoint\n");
-		usb_set_intfdata(info->data, NULL);
-		usb_driver_release_interface(driver, info->data);
-		return -ENODEV;
+		dev_err(&intf->dev, "missing RNDIS status endpoint\n");
+		status = -ENODEV;
+		goto bail_out_and_release;
 	}
 
 	/* override ethtool_ops */
@@ -327,9 +330,12 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	return 0;
 
+bail_out_and_release:
+	usb_set_intfdata(info->data, NULL);
+	if (info->data != info->control)
+		usb_driver_release_interface(driver, info->data);
 bad_desc:
-	dev_info(&dev->udev->dev, "bad CDC descriptors\n");
-	return -ENODEV;
+	return status;
 }
 EXPORT_SYMBOL_GPL(usbnet_generic_cdc_bind);
 
-- 
2.53.0


