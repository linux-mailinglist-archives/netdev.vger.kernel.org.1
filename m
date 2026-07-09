Return-Path: <netdev+bounces-306203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4jUEMlOPT2q6jgIAu9opvQ
	(envelope-from <netdev+bounces-306203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:08:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3943730D3F
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:08:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TSsgez+H;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TSsgez+H;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306203-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306203-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 936AC3004411
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A1422547;
	Thu,  9 Jul 2026 12:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5042252C
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:01:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598504; cv=none; b=Voo/RNqJ6C4mU+zre5pwy34nbuAxbyebFb8WvFwFvUGk1/H9yXhkZDRIs0RQCdjboej01GFxH/wx4rJ5BZ3gVt74+zbBF9Dr0ltCYCSanxkrAkwspfL85nT+dBfk5LfxUJyN93nb+6tmHVWJsyPbU8/60vdffqsGq63tVvXrO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598504; c=relaxed/simple;
	bh=R7mxBYm7QXxFHYEmZZipEBOPywDA2/cB/RkNuUbKF4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXlGgeB/5K9500JzuGN1GefhucKFIsyMotxlXrfIUEm9SnJ+LvnFzdtzOJHGS3ij42WWEAChUH1Z2ChwVSkELnXkj/ILBezUNLJGihG2O/jooMj0CCVxv/O3Am46aFYQkymojI274JpBL0xz0Gx9l4ipjkza3fzF0QjEfD4TeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TSsgez+H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TSsgez+H; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0902F761BE;
	Thu,  9 Jul 2026 12:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783598481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3VxfLZef5FP95RENfFmhUdB0Qomc8ikbs+fE3FDzxc=;
	b=TSsgez+HafPi3W82/m3go+xFnSZvVV+YXzColqTJEI435naX6jwc9O47ShmSaYjms92WO8
	aG/MMgEuW1mzlkxp3+aaHA8u1Mi7eLzn82w4G3FdOB/6p19Ijokq2ZybU2a1PFDrRJanel
	zUlJHkY2jyOUrf2fuqc/2cFRFMP5zwA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783598481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3VxfLZef5FP95RENfFmhUdB0Qomc8ikbs+fE3FDzxc=;
	b=TSsgez+HafPi3W82/m3go+xFnSZvVV+YXzColqTJEI435naX6jwc9O47ShmSaYjms92WO8
	aG/MMgEuW1mzlkxp3+aaHA8u1Mi7eLzn82w4G3FdOB/6p19Ijokq2ZybU2a1PFDrRJanel
	zUlJHkY2jyOUrf2fuqc/2cFRFMP5zwA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0BB9779B5;
	Thu,  9 Jul 2026 12:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sNUKLpCNT2pEWQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 09 Jul 2026 12:01:20 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	manuelebner@mailbox.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 net-next 5/7] net: usb: move exported symbols from cdc_ether to usbnet
Date: Thu,  9 Jul 2026 14:01:14 +0200
Message-ID: <20260709120116.1423033-5-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709120116.1423033-1-oneukum@suse.com>
References: <20260709120116.1423033-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manuelebner@mailbox.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3943730D3F

Move the rest of the symbols to usbnet, so that the cdc_ether
driver does not need to be loaded as a library.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c | 372 ------------------------------------
 drivers/net/usb/usbnet.c    | 356 ++++++++++++++++++++++++++++++++++
 include/linux/usb/usbnet.h  |  17 ++
 3 files changed, 373 insertions(+), 372 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 76ad4ffa950a..6bf6538f3468 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -19,378 +19,6 @@
 #include <linux/usb/usbnet.h>
 
 
-#if IS_ENABLED(CONFIG_USB_NET_RNDIS_HOST)
-
-static int is_rndis(struct usb_interface_descriptor *desc)
-{
-	return (desc->bInterfaceClass == USB_CLASS_COMM &&
-		desc->bInterfaceSubClass == 2 &&
-		desc->bInterfaceProtocol == 0xff);
-}
-
-static int is_activesync(struct usb_interface_descriptor *desc)
-{
-	return (desc->bInterfaceClass == USB_CLASS_MISC &&
-		desc->bInterfaceSubClass == 1 &&
-		desc->bInterfaceProtocol == 1);
-}
-
-static int is_wireless_rndis(struct usb_interface_descriptor *desc)
-{
-	return (desc->bInterfaceClass == USB_CLASS_WIRELESS_CONTROLLER &&
-		desc->bInterfaceSubClass == 1 &&
-		desc->bInterfaceProtocol == 3);
-}
-
-static int is_novatel_rndis(struct usb_interface_descriptor *desc)
-{
-	return (desc->bInterfaceClass == USB_CLASS_MISC &&
-		desc->bInterfaceSubClass == 4 &&
-		desc->bInterfaceProtocol == 1);
-}
-
-#else
-
-#define is_rndis(desc)		0
-#define is_activesync(desc)	0
-#define is_wireless_rndis(desc)	0
-#define is_novatel_rndis(desc)	0
-
-#endif
-
-static const u8 mbm_guid[16] = {
-	0xa3, 0x17, 0xa8, 0x8b, 0x04, 0x5e, 0x4f, 0x01,
-	0xa6, 0x07, 0xc0, 0xff, 0xcb, 0x7e, 0x39, 0x2a,
-};
-
-/* We need to override usbnet_*_link_ksettings in bind() */
-static const struct ethtool_ops cdc_ether_ethtool_ops = {
-	.get_link		= usbnet_get_link,
-	.nway_reset		= usbnet_nway_reset,
-	.get_drvinfo		= usbnet_get_drvinfo,
-	.get_msglevel		= usbnet_get_msglevel,
-	.set_msglevel		= usbnet_set_msglevel,
-	.get_ts_info		= ethtool_op_get_ts_info,
-	.get_link_ksettings	= usbnet_get_link_ksettings_internal,
-	.set_link_ksettings	= NULL,
-};
-
-/* probes control interface, claims data interface, collects the bulk
- * endpoints, activates data interface (if needed), maybe sets MTU.
- * all pure cdc, except for certain firmware workarounds, and knowing
- * that rndis uses one different rule.
- */
-int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
-{
-	u8				*buf = intf->cur_altsetting->extra;
-	int				len = intf->cur_altsetting->extralen;
-	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = &dev->cdc;
-	int				status = -ENODEV;
-	int				rndis;
-	bool				android_rndis_quirk = false;
-	struct usb_driver		*driver = driver_of(intf);
-	struct usb_cdc_parsed_header header;
-
-	if (sizeof(dev->data) < sizeof(*info))
-		return -EDOM;
-
-	/* expect strict spec conformance for the descriptors, but
-	 * cope with firmware which stores them in the wrong place
-	 */
-	if (len == 0 && dev->udev->actconfig->extralen) {
-		/* Motorola SB4100 (and others: Brad Hards says it's
-		 * from a Broadcom design) put CDC descriptors here
-		 */
-		buf = dev->udev->actconfig->extra;
-		len = dev->udev->actconfig->extralen;
-		dev_dbg(&intf->dev, "CDC descriptors on config\n");
-	}
-
-	/* Maybe CDC descriptors are after the endpoint?  This bug has
-	 * been seen on some 2Wire Inc RNDIS-ish products.
-	 */
-	if (len == 0) {
-		struct usb_host_endpoint	*hep;
-
-		hep = intf->cur_altsetting->endpoint;
-		if (hep) {
-			buf = hep->extra;
-			len = hep->extralen;
-		}
-		if (len)
-			dev_dbg(&intf->dev,
-				"CDC descriptors on endpoint\n");
-	}
-
-	/* this assumes that if there's a non-RNDIS vendor variant
-	 * of cdc-acm, it'll fail RNDIS requests cleanly.
-	 */
-	rndis = (is_rndis(&intf->cur_altsetting->desc) ||
-		 is_activesync(&intf->cur_altsetting->desc) ||
-		 is_wireless_rndis(&intf->cur_altsetting->desc) ||
-		 is_novatel_rndis(&intf->cur_altsetting->desc));
-
-	memset(info, 0, sizeof(*info));
-	info->control = intf;
-
-	cdc_parse_cdc_header(&header, intf, buf, len);
-
-	info->u = header.usb_cdc_union_desc;
-	info->header = header.usb_cdc_header_desc;
-	info->ether = header.usb_cdc_ether_desc;
-	if (!info->u) {
-		if (rndis) {
-			goto skip;
-		} else {
-			/* in that case a quirk is mandatory */
-			dev_err(&dev->udev->dev, "No union descriptors\n");
-			goto bad_desc;
-		}
-	}
-	/* we need a master/control interface (what we're
-	 * probed with) and a slave/data interface; union
-	 * descriptors sort this all out.
-	 */
-	info->control = usb_ifnum_to_if(dev->udev, info->u->bMasterInterface0);
-	info->data = usb_ifnum_to_if(dev->udev, info->u->bSlaveInterface0);
-	if (!info->control || !info->data) {
-		dev_dbg(&intf->dev,
-			"master #%u/%p slave #%u/%p\n",
-			info->u->bMasterInterface0,
-			info->control,
-			info->u->bSlaveInterface0,
-			info->data);
-		/* fall back to hard-wiring for RNDIS */
-		if (rndis) {
-			android_rndis_quirk = true;
-			goto skip;
-		}
-		dev_err(&intf->dev, "bad CDC descriptors\n");
-		goto bad_desc;
-	}
-	if (info->control != intf) {
-		/* Ambit USB Cable Modem (and maybe others)
-		 * interchanges master and slave interface.
-		 */
-		if (info->data == intf) {
-			info->data = info->control;
-			info->control = intf;
-		} else {
-			dev_err(&intf->dev, "bogus CDC Union\n");
-			goto bad_desc;
-		}
-	}
-
-	/* some devices merge these - skip class check */
-	if (info->control == info->data)
-		goto skip;
-
-	/* a data interface altsetting does the real i/o */
-	d = &info->data->cur_altsetting->desc;
-	if (d->bInterfaceClass != USB_CLASS_CDC_DATA) {
-		dev_err(&intf->dev, "slave class %u\n", d->bInterfaceClass);
-		goto bad_desc;
-	}
-skip:
-	/* Communication class functions with bmCapabilities are not
-	 * RNDIS.  But some Wireless class RNDIS functions use
-	 * bmCapabilities for their own purpose. The failsafe is
-	 * therefore applied only to Communication class RNDIS
-	 * functions.  The rndis test is redundant, but a cheap
-	 * optimization.
-	 */
-	if (rndis && is_rndis(&intf->cur_altsetting->desc) &&
-	    header.usb_cdc_acm_descriptor &&
-	    header.usb_cdc_acm_descriptor->bmCapabilities) {
-		dev_err(&intf->dev,
-			"ACM capabilities %02x, not really RNDIS?\n",
-			header.usb_cdc_acm_descriptor->bmCapabilities);
-		goto bad_desc;
-	}
-
-	if (header.usb_cdc_ether_desc && info->ether->wMaxSegmentSize) {
-		dev->hard_mtu = le16_to_cpu(info->ether->wMaxSegmentSize);
-		/* because of Zaurus, we may be ignoring the host
-		 * side link address we were given.
-		 */
-	}
-
-	if (header.usb_cdc_mdlm_desc &&
-	    memcmp(header.usb_cdc_mdlm_desc->bGUID, mbm_guid, 16)) {
-		dev_err(&intf->dev, "GUID doesn't match\n");
-		goto bad_desc;
-	}
-
-	if (header.usb_cdc_mdlm_detail_desc &&
-		header.usb_cdc_mdlm_detail_desc->bLength <
-			(sizeof(struct usb_cdc_mdlm_detail_desc) + 1)) {
-		dev_err(&intf->dev, "Descriptor too short\n");
-		goto bad_desc;
-	}
-
-
-
-	/* Microsoft ActiveSync based and some regular RNDIS devices lack the
-	 * CDC descriptors, so we'll hard-wire the interfaces and not check
-	 * for descriptors.
-	 *
-	 * Some Android RNDIS devices have a CDC Union descriptor pointing
-	 * to non-existing interfaces.  Ignore that and attempt the same
-	 * hard-wired 0 and 1 interfaces.
-	 */
-	if (rndis && (!info->u || android_rndis_quirk)) {
-		info->control = usb_ifnum_to_if(dev->udev, 0);
-		info->data = usb_ifnum_to_if(dev->udev, 1);
-		if (!info->control || !info->data || info->control != intf) {
-			dev_err(&intf->dev,
-				"rndis: master #0/%p slave #1/%p\n",
-				info->control,
-				info->data);
-			goto bad_desc;
-		}
-
-	} else if (!info->header || (!rndis && !info->ether)) {
-		dev_err(&intf->dev, "missing cdc %s%s%sdescriptor\n",
-			info->header ? "" : "header ",
-			info->u ? "" : "union ",
-			info->ether ? "" : "ether ");
-		goto bad_desc;
-	}
-
-	/* claim data interface and set it up ... with side effects.
-	 * network traffic can't flow until an altsetting is enabled.
-	 */
-	if (info->data != info->control) {
-		status = usb_driver_claim_interface(driver, info->data, dev);
-		if (status < 0) {
-			dev_err(&intf->dev, "Second interface unclaimable\n");
-			goto bad_desc;
-		}
-	}
-	status = usbnet_get_endpoints(dev, info->data);
-	if (status < 0) {
-		dev_dbg(&intf->dev, "Mandatory endpoints missing\n");
-		goto bail_out_and_release;
-	}
-
-	/* status endpoint: optional for CDC Ethernet, not RNDIS (or ACM) */
-	if (info->data != info->control)
-		dev->status = NULL;
-	if (info->control->cur_altsetting->desc.bNumEndpoints == 1) {
-		struct usb_endpoint_descriptor	*desc;
-
-		dev->status = &info->control->cur_altsetting->endpoint[0];
-		desc = &dev->status->desc;
-		if (!usb_endpoint_is_int_in(desc) ||
-		    (le16_to_cpu(desc->wMaxPacketSize)
-		     < sizeof(struct usb_cdc_notification)) ||
-		    !desc->bInterval) {
-			dev_dbg(&intf->dev, "bad notification endpoint\n");
-			dev->status = NULL;
-		}
-	}
-	if (rndis && !dev->status) {
-		dev_err(&intf->dev, "missing RNDIS status endpoint\n");
-		status = -ENODEV;
-		goto bail_out_and_release;
-	}
-
-	/* override ethtool_ops */
-	dev->net->ethtool_ops = &cdc_ether_ethtool_ops;
-
-	return 0;
-
-bail_out_and_release:
-	usb_set_intfdata(info->data, NULL);
-	if (info->data != info->control)
-		usb_driver_release_interface(driver, info->data);
-bad_desc:
-	return status;
-}
-EXPORT_SYMBOL_GPL(usbnet_generic_cdc_bind);
-
-
-/* like usbnet_generic_cdc_bind() but handles filter initialization
- * correctly
- */
-int usbnet_ether_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
-{
-	int rv;
-
-	rv = usbnet_generic_cdc_bind(dev, intf);
-	if (rv < 0)
-		goto bail_out;
-
-	/* Some devices don't initialise properly. In particular
-	 * the packet filter is not reset. There are devices that
-	 * don't do reset all the way. So the packet filter should
-	 * be set to a sane initial value.
-	 */
-	usbnet_cdc_update_filter(dev);
-
-bail_out:
-	return rv;
-}
-EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
-
-void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
-{
-	struct cdc_state		*info = &dev->cdc;
-	struct usb_driver		*driver = driver_of(intf);
-
-	/* combined interface - nothing  to do */
-	if (info->data == info->control)
-		return;
-
-	/* disconnect master --> disconnect slave */
-	if (intf == info->control && info->data) {
-		/* ensure immediate exit from usbnet_disconnect */
-		usb_set_intfdata(info->data, NULL);
-		usb_driver_release_interface(driver, info->data);
-		info->data = NULL;
-	}
-
-	/* and vice versa (just in case) */
-	else if (intf == info->data && info->control) {
-		/* ensure immediate exit from usbnet_disconnect */
-		usb_set_intfdata(info->control, NULL);
-		usb_driver_release_interface(driver, info->control);
-		info->control = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
-
-/* Communications Device Class, Ethernet Control model
- *
- * Takes two interfaces.  The DATA interface is inactive till an altsetting
- * is selected.  Configuration data includes class descriptors.  There's
- * an optional status endpoint on the control interface.
- *
- * This should interop with whatever the 2.4 "CDCEther.c" driver
- * (by Brad Hards) talked with, with more functionality.
- */
-
-int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
-{
-	int				status;
-	struct cdc_state		*info = &dev->cdc;
-
-	status = usbnet_ether_cdc_bind(dev, intf);
-	if (status < 0)
-		return status;
-
-	status = usbnet_get_ethernet_addr(dev, info->ether->iMACAddress);
-	if (status < 0) {
-		usb_set_intfdata(info->data, NULL);
-		usb_driver_release_interface(driver_of(intf), info->data);
-		return status;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(usbnet_cdc_bind);
-
 static int usbnet_cdc_zte_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int status = usbnet_cdc_bind(dev, intf);
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 14e9f1b1e0a2..ce932c81382e 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2369,6 +2369,362 @@ int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(usbnet_cdc_zte_rx_fixup);
+
+
+#if IS_ENABLED(CONFIG_USB_NET_RNDIS_HOST)
+
+static int is_rndis(struct usb_interface_descriptor *desc)
+{
+	return (desc->bInterfaceClass == USB_CLASS_COMM &&
+		desc->bInterfaceSubClass == 2 &&
+		desc->bInterfaceProtocol == 0xff);
+}
+
+static int is_activesync(struct usb_interface_descriptor *desc)
+{
+	return (desc->bInterfaceClass == USB_CLASS_MISC &&
+		desc->bInterfaceSubClass == 1 &&
+		desc->bInterfaceProtocol == 1);
+}
+
+static int is_wireless_rndis(struct usb_interface_descriptor *desc)
+{
+	return (desc->bInterfaceClass == USB_CLASS_WIRELESS_CONTROLLER &&
+		desc->bInterfaceSubClass == 1 &&
+		desc->bInterfaceProtocol == 3);
+}
+
+static int is_novatel_rndis(struct usb_interface_descriptor *desc)
+{
+	return (desc->bInterfaceClass == USB_CLASS_MISC &&
+		desc->bInterfaceSubClass == 4 &&
+		desc->bInterfaceProtocol == 1);
+}
+
+#else
+
+#define is_rndis(desc)		0
+#define is_activesync(desc)	0
+#define is_wireless_rndis(desc)	0
+#define is_novatel_rndis(desc)	0
+
+#endif
+
+/* Communications Device Class, Ethernet Control model
+ *
+ * Takes two interfaces.  The DATA interface is inactive till an altsetting
+ * is selected.  Configuration data includes class descriptors.  There's
+ * an optional status endpoint on the control interface.
+ *
+ * This should interop with whatever the 2.4 "CDCEther.c" driver
+ * (by Brad Hards) talked with, with more functionality.
+ */
+
+int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	int				status;
+	struct cdc_state		*info = &dev->cdc;
+
+	status = usbnet_ether_cdc_bind(dev, intf);
+	if (status < 0)
+		return status;
+
+	status = usbnet_get_ethernet_addr(dev, info->ether->iMACAddress);
+	if (status < 0) {
+		usb_set_intfdata(info->data, NULL);
+		usb_driver_release_interface(driver_of(intf), info->data);
+		return status;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usbnet_cdc_bind);
+
+/* probes control interface, claims data interface, collects the bulk
+ * endpoints, activates data interface (if needed), maybe sets MTU.
+ * all pure cdc, except for certain firmware workarounds, and knowing
+ * that rndis uses one different rule.
+ */
+int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	u8				*buf = intf->cur_altsetting->extra;
+	int				len = intf->cur_altsetting->extralen;
+	struct usb_interface_descriptor	*d;
+	struct cdc_state		*info = &dev->cdc;
+	int				status = -ENODEV;
+	int				rndis;
+	bool				android_rndis_quirk = false;
+	struct usb_driver		*driver = driver_of(intf);
+	struct usb_cdc_parsed_header header;
+
+	if (sizeof(dev->data) < sizeof(*info))
+		return -EDOM;
+
+	/* expect strict spec conformance for the descriptors, but
+	 * cope with firmware which stores them in the wrong place
+	 */
+	if (len == 0 && dev->udev->actconfig->extralen) {
+		/* Motorola SB4100 (and others: Brad Hards says it's
+		 * from a Broadcom design) put CDC descriptors here
+		 */
+		buf = dev->udev->actconfig->extra;
+		len = dev->udev->actconfig->extralen;
+		dev_dbg(&intf->dev, "CDC descriptors on config\n");
+	}
+
+	/* Maybe CDC descriptors are after the endpoint?  This bug has
+	 * been seen on some 2Wire Inc RNDIS-ish products.
+	 */
+	if (len == 0) {
+		struct usb_host_endpoint	*hep;
+
+		hep = intf->cur_altsetting->endpoint;
+		if (hep) {
+			buf = hep->extra;
+			len = hep->extralen;
+		}
+		if (len)
+			dev_dbg(&intf->dev,
+				"CDC descriptors on endpoint\n");
+	}
+
+	/* this assumes that if there's a non-RNDIS vendor variant
+	 * of cdc-acm, it'll fail RNDIS requests cleanly.
+	 */
+	rndis = (is_rndis(&intf->cur_altsetting->desc) ||
+		 is_activesync(&intf->cur_altsetting->desc) ||
+		 is_wireless_rndis(&intf->cur_altsetting->desc) ||
+		 is_novatel_rndis(&intf->cur_altsetting->desc));
+
+	memset(info, 0, sizeof(*info));
+	info->control = intf;
+
+	cdc_parse_cdc_header(&header, intf, buf, len);
+
+	info->u = header.usb_cdc_union_desc;
+	info->header = header.usb_cdc_header_desc;
+	info->ether = header.usb_cdc_ether_desc;
+	if (!info->u) {
+		if (rndis) {
+			goto skip;
+		} else {
+			/* in that case a quirk is mandatory */
+			dev_err(&dev->udev->dev, "No union descriptors\n");
+			goto bad_desc;
+		}
+	}
+	/* we need a master/control interface (what we're
+	 * probed with) and a slave/data interface; union
+	 * descriptors sort this all out.
+	 */
+	info->control = usb_ifnum_to_if(dev->udev, info->u->bMasterInterface0);
+	info->data = usb_ifnum_to_if(dev->udev, info->u->bSlaveInterface0);
+	if (!info->control || !info->data) {
+		dev_dbg(&intf->dev,
+			"master #%u/%p slave #%u/%p\n",
+			info->u->bMasterInterface0,
+			info->control,
+			info->u->bSlaveInterface0,
+			info->data);
+		/* fall back to hard-wiring for RNDIS */
+		if (rndis) {
+			android_rndis_quirk = true;
+			goto skip;
+		}
+		dev_err(&intf->dev, "bad CDC descriptors\n");
+		goto bad_desc;
+	}
+	if (info->control != intf) {
+		/* Ambit USB Cable Modem (and maybe others)
+		 * interchanges master and slave interface.
+		 */
+		if (info->data == intf) {
+			info->data = info->control;
+			info->control = intf;
+		} else {
+			dev_err(&intf->dev, "bogus CDC Union\n");
+			goto bad_desc;
+		}
+	}
+
+	/* some devices merge these - skip class check */
+	if (info->control == info->data)
+		goto skip;
+
+	/* a data interface altsetting does the real i/o */
+	d = &info->data->cur_altsetting->desc;
+	if (d->bInterfaceClass != USB_CLASS_CDC_DATA) {
+		dev_err(&intf->dev, "slave class %u\n", d->bInterfaceClass);
+		goto bad_desc;
+	}
+skip:
+	/* Communication class functions with bmCapabilities are not
+	 * RNDIS.  But some Wireless class RNDIS functions use
+	 * bmCapabilities for their own purpose. The failsafe is
+	 * therefore applied only to Communication class RNDIS
+	 * functions.  The rndis test is redundant, but a cheap
+	 * optimization.
+	 */
+	if (rndis && is_rndis(&intf->cur_altsetting->desc) &&
+	    header.usb_cdc_acm_descriptor &&
+	    header.usb_cdc_acm_descriptor->bmCapabilities) {
+		dev_err(&intf->dev,
+			"ACM capabilities %02x, not really RNDIS?\n",
+			header.usb_cdc_acm_descriptor->bmCapabilities);
+		goto bad_desc;
+	}
+
+	if (header.usb_cdc_ether_desc && info->ether->wMaxSegmentSize) {
+		dev->hard_mtu = le16_to_cpu(info->ether->wMaxSegmentSize);
+		/* because of Zaurus, we may be ignoring the host
+		 * side link address we were given.
+		 */
+	}
+
+	if (header.usb_cdc_mdlm_desc &&
+	    memcmp(header.usb_cdc_mdlm_desc->bGUID, mbm_guid, 16)) {
+		dev_err(&intf->dev, "GUID doesn't match\n");
+		goto bad_desc;
+	}
+
+	if (header.usb_cdc_mdlm_detail_desc &&
+		header.usb_cdc_mdlm_detail_desc->bLength <
+			(sizeof(struct usb_cdc_mdlm_detail_desc) + 1)) {
+		dev_err(&intf->dev, "Descriptor too short\n");
+		goto bad_desc;
+	}
+
+
+
+	/* Microsoft ActiveSync based and some regular RNDIS devices lack the
+	 * CDC descriptors, so we'll hard-wire the interfaces and not check
+	 * for descriptors.
+	 *
+	 * Some Android RNDIS devices have a CDC Union descriptor pointing
+	 * to non-existing interfaces.  Ignore that and attempt the same
+	 * hard-wired 0 and 1 interfaces.
+	 */
+	if (rndis && (!info->u || android_rndis_quirk)) {
+		info->control = usb_ifnum_to_if(dev->udev, 0);
+		info->data = usb_ifnum_to_if(dev->udev, 1);
+		if (!info->control || !info->data || info->control != intf) {
+			dev_err(&intf->dev,
+				"rndis: master #0/%p slave #1/%p\n",
+				info->control,
+				info->data);
+			goto bad_desc;
+		}
+
+	} else if (!info->header || (!rndis && !info->ether)) {
+		dev_err(&intf->dev, "missing cdc %s%s%sdescriptor\n",
+			info->header ? "" : "header ",
+			info->u ? "" : "union ",
+			info->ether ? "" : "ether ");
+		goto bad_desc;
+	}
+
+	/* claim data interface and set it up ... with side effects.
+	 * network traffic can't flow until an altsetting is enabled.
+	 */
+	if (info->data != info->control) {
+		status = usb_driver_claim_interface(driver, info->data, dev);
+		if (status < 0) {
+			dev_err(&intf->dev, "Second interface unclaimable\n");
+			goto bad_desc;
+		}
+	}
+	status = usbnet_get_endpoints(dev, info->data);
+	if (status < 0) {
+		dev_dbg(&intf->dev, "Mandatory endpoints missing\n");
+		goto bail_out_and_release;
+	}
+
+	/* status endpoint: optional for CDC Ethernet, not RNDIS (or ACM) */
+	if (info->data != info->control)
+		dev->status = NULL;
+	if (info->control->cur_altsetting->desc.bNumEndpoints == 1) {
+		struct usb_endpoint_descriptor	*desc;
+
+		dev->status = &info->control->cur_altsetting->endpoint[0];
+		desc = &dev->status->desc;
+		if (!usb_endpoint_is_int_in(desc) ||
+		    (le16_to_cpu(desc->wMaxPacketSize)
+		     < sizeof(struct usb_cdc_notification)) ||
+		    !desc->bInterval) {
+			dev_dbg(&intf->dev, "bad notification endpoint\n");
+			dev->status = NULL;
+		}
+	}
+	if (rndis && !dev->status) {
+		dev_err(&intf->dev, "missing RNDIS status endpoint\n");
+		status = -ENODEV;
+		goto bail_out_and_release;
+	}
+
+	/* override ethtool_ops */
+	dev->net->ethtool_ops = &cdc_ether_ethtool_ops;
+
+	return 0;
+
+bail_out_and_release:
+	usb_set_intfdata(info->data, NULL);
+	if (info->data != info->control)
+		usb_driver_release_interface(driver, info->data);
+bad_desc:
+	return status;
+}
+EXPORT_SYMBOL_GPL(usbnet_generic_cdc_bind);
+
+/* like usbnet_generic_cdc_bind() but handles filter initialization
+ * correctly
+ */
+int usbnet_ether_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
+{
+	int rv;
+
+	rv = usbnet_generic_cdc_bind(dev, intf);
+	if (rv < 0)
+		goto bail_out;
+
+	/* Some devices don't initialise properly. In particular
+	 * the packet filter is not reset. There are devices that
+	 * don't do reset all the way. So the packet filter should
+	 * be set to a sane initial value.
+	 */
+	usbnet_cdc_update_filter(dev);
+
+bail_out:
+	return rv;
+}
+EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
+
+void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
+{
+	struct cdc_state		*info = &dev->cdc;
+	struct usb_driver		*driver = driver_of(intf);
+
+	/* combined interface - nothing  to do */
+	if (info->data == info->control)
+		return;
+
+	/* disconnect master --> disconnect slave */
+	if (intf == info->control && info->data) {
+		/* ensure immediate exit from usbnet_disconnect */
+		usb_set_intfdata(info->data, NULL);
+		usb_driver_release_interface(driver, info->data);
+		info->data = NULL;
+	}
+
+	/* and vice versa (just in case) */
+	else if (intf == info->data && info->control) {
+		/* ensure immediate exit from usbnet_disconnect */
+		usb_set_intfdata(info->control, NULL);
+		usb_driver_release_interface(driver, info->control);
+		info->control = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
+
 /*-------------------------------------------------------------------------*/
 
 static int __init usbnet_init(void)
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 79f48eb388ee..b3a77078fb10 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -16,6 +16,11 @@
 #include <linux/usb.h>
 #include <linux/spinlock.h>
 
+static const u8 mbm_guid[16] = {
+	0xa3, 0x17, 0xa8, 0x8b, 0x04, 0x5e, 0x4f, 0x01,
+	0xa6, 0x07, 0xc0, 0xff, 0xcb, 0x7e, 0x39, 0x2a,
+};
+
 struct cdc_state {
 	struct usb_cdc_header_desc      *header;
 	struct usb_cdc_union_desc       *u;
@@ -304,4 +309,16 @@ extern void usbnet_status_stop(struct usbnet *dev);
 
 extern void usbnet_update_max_qlen(struct usbnet *dev);
 
+/* We need to override usbnet_*_link_ksettings in bind() */
+static const struct ethtool_ops cdc_ether_ethtool_ops = {
+	.get_link		= usbnet_get_link,
+	.nway_reset		= usbnet_nway_reset,
+	.get_drvinfo		= usbnet_get_drvinfo,
+	.get_msglevel		= usbnet_get_msglevel,
+	.set_msglevel		= usbnet_set_msglevel,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_link_ksettings	= usbnet_get_link_ksettings_internal,
+	.set_link_ksettings	= NULL,
+};
+
 #endif /* __LINUX_USB_USBNET_H */
-- 
2.54.0


