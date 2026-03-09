Return-Path: <netdev+bounces-265645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IiPOSr8rmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:58:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0BC23D348
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C901330255ED
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4B3E9F9A;
	Mon,  9 Mar 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JqeDgNP/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JqeDgNP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A713E9F6F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075403; cv=none; b=a3Ai9jbH2arQhJf1TZ45lfRasI4IO3lyDdLYh6itaeX3ODz1hiLPRhJztyCa/Zv1pf7HOrDtnKYttjVGTf6i4UZKtNrJvPTrMGmAyQgq04T068aJDwzCqT5+8dhjhl4rUeG7TeNL/Nk6EodyOlQVlpnKpcRXwAA4ivqPBy0H+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075403; c=relaxed/simple;
	bh=f8Ezb1HGJZjqP6xdd3vQrN95inIqT/jtiWwSRyxg1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey27BbLqDc7qg1gxW5Aoc+SST3j6sb8IID/acUR8XwDgTAGruR+uNO2NTXTlev6VqYve/+4PGMdC3Rue4qS6DbYJmrQNAp/czYr0rbLKx/TDa8l2Zv//mFgXj2YhGtwhLjgjZxtFe1j7c4JlsA2pVeCWrR6crGalD0SFd5KA1PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JqeDgNP/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JqeDgNP/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 882BA5BE4F;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLSf/PcMC7QaOrZENtjYQLb4KpdtII/S31mefidnsnU=;
	b=JqeDgNP/c0NhSUXz/BX98EahniNkLJtyOPlKG8MK3mxYI3aPjMUptJNhE4acaJbYv4uYwj
	Dz6AD6PiudbVw0PhcjR7fwA2jejqtCynpgrjnuPEB6C3Q2QFzgc2xEDjCOatwTlUyHRgB8
	lh7ox91bLCBr82MXdKldNil5NyPKW4s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="JqeDgNP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLSf/PcMC7QaOrZENtjYQLb4KpdtII/S31mefidnsnU=;
	b=JqeDgNP/c0NhSUXz/BX98EahniNkLJtyOPlKG8MK3mxYI3aPjMUptJNhE4acaJbYv4uYwj
	Dz6AD6PiudbVw0PhcjR7fwA2jejqtCynpgrjnuPEB6C3Q2QFzgc2xEDjCOatwTlUyHRgB8
	lh7ox91bLCBr82MXdKldNil5NyPKW4s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 686073EFDA;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AtbGLj7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:24 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 07/13] net: usb: use cdc_state in struct usbnet
Date: Mon,  9 Mar 2026 17:53:30 +0100
Message-ID: <20260309165614.861929-7-oneukum@suse.com>
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
X-Rspamd-Queue-Id: 9D0BC23D348
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
	TAGGED_FROM(0.00)[bounces-265645-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.981];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Remove private copies as now a central state can be used.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c  | 6 +++---
 drivers/net/usb/rndis_host.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index c24c14702f4b..dafc2462be98 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -85,7 +85,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8				*buf = intf->cur_altsetting->extra;
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = usbnet_priv(dev);
+	struct cdc_state		*info = &dev->cdc;
 	int				status;
 	int				rndis;
 	bool				android_rndis_quirk = false;
@@ -327,7 +327,7 @@ EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
 
 void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_state		*info = usbnet_priv(dev);
+	struct cdc_state		*info = &dev->cdc;
 	struct usb_driver		*driver = driver_of(intf);
 
 	/* combined interface - nothing  to do */
@@ -365,7 +365,7 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
-	struct cdc_state		*info = usbnet_priv(dev);
+	struct cdc_state		*info = &dev->cdc;
 
 	status = usbnet_ether_cdc_bind(dev, intf);
 	if (status < 0)
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..6aed29dfa021 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL_GPL(rndis_status);
 static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
 				int buflen)
 {
-	struct cdc_state *info = (void *)&dev->data;
+	struct cdc_state *info = &dev->cdc;
 	struct device *udev = &info->control->dev;
 
 	if (dev->driver_info->indication) {
@@ -90,7 +90,7 @@ static void rndis_msg_indicate(struct usbnet *dev, struct rndis_indicate *msg,
  */
 int rndis_command(struct usbnet *dev, struct rndis_msg_hdr *buf, int buflen)
 {
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = &dev->cdc;
 	struct usb_cdc_notification notification;
 	int			master_ifnum;
 	int			retval;
@@ -290,7 +290,7 @@ generic_rndis_bind(struct usbnet *dev, struct usb_interface *intf, int flags)
 {
 	int			retval;
 	struct net_device	*net = dev->net;
-	struct cdc_state	*info = (void *) &dev->data;
+	struct cdc_state	*info = &dev->cdc;
 	union {
 		void			*buf;
 		struct rndis_msg_hdr	*header;
-- 
2.53.0


