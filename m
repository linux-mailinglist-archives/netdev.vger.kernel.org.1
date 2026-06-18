Return-Path: <netdev+bounces-300411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mfEiCqPRM2o4GwYAu9opvQ
	(envelope-from <netdev+bounces-300411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:08:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913A69F9FD
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300411-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300411-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7BFD30800D9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8EE3EFFDB;
	Thu, 18 Jun 2026 11:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228803E5A31
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:06:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780790; cv=none; b=F2qR0KGdGhrcUWkG5RjpFeKWFHFd3Dy72e5XEZZgXkqM+3R96xJjimhSVnkDhv44E8rqHj0xjR2RSZizVB1F3UoVzttaev8TnWA20+rpgSWkicA0kSwN2mDabND3CWeapqjiTLHeE0GLuR7flLRstjuZnaFJ/NrMzppcA3G/dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780790; c=relaxed/simple;
	bh=Q2/gPX351QT9J41evKl/wDt9TJNiRoYd+yFER/bglR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ2Zknu+NAQN1PZfDkl91byfUNRG5WSZWtmVGD2rE6NEfHb+HBSgaXNQq5oqiRBqNvK6x2/T0cbINYhgGgY+GO2gTeeC7zl+jNfFlS5HUzlO3PsMezeSPmzX9ypnHpPo98OVpIW/VTlwlHx1ZlNVgQFlct5G0epClmHeki2f1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C8B6D2D5;
	Thu, 18 Jun 2026 11:06:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 497A9779AB;
	Thu, 18 Jun 2026 11:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qEHJECjRM2q7TgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 18 Jun 2026 11:06:16 +0000
From: Oliver Neukum <oneukum@suse.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFT 1/1] usb: class: cdc-wdm: switch to kfifo for buffering
Date: Thu, 18 Jun 2026 13:04:15 +0200
Message-ID: <20260618110612.439021-2-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618110612.439021-1-oneukum@suse.com>
References: <20260618110612.439021-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:oneukum@suse.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5913A69F9FD

The kfifo code is more efficient and takes care
of memory ordering without locking.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-wdm.c | 62 ++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 7556c0dac908..83fc253f8c09 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -27,6 +27,7 @@
 #include <linux/wwan.h>
 #include <asm/byteorder.h>
 #include <linux/unaligned.h>
+#include <linux/kfifo.h>
 #include <linux/usb/cdc-wdm.h>
 
 #define DRIVER_AUTHOR "Oliver Neukum"
@@ -77,7 +78,8 @@ struct wdm_device {
 	u8			*inbuf; /* buffer for response */
 	u8			*outbuf; /* buffer for command */
 	u8			*sbuf; /* buffer for status */
-	u8			*ubuf; /* buffer for copy to user space */
+
+	struct kfifo		ubuf; /* payload */
 
 	struct urb		*command;
 	struct urb		*response;
@@ -92,7 +94,6 @@ struct wdm_device {
 	u16			wMaxCommand;
 	u16			wMaxPacketSize;
 	__le16			inum;
-	int			length;
 	int			read;
 	int			count;
 	dma_addr_t		shandle;
@@ -170,6 +171,7 @@ static void wdm_in_callback(struct urb *urb)
 	struct wdm_device *desc = urb->context;
 	int status = urb->status;
 	int length = urb->actual_length;
+	int processed;
 
 	spin_lock_irqsave(&desc->iuspin, flags);
 	clear_bit(WDM_RESPONDING, &desc->flags);
@@ -218,17 +220,13 @@ static void wdm_in_callback(struct urb *urb)
 		goto skip_zlp;
 	}
 
-	if (length + desc->length > desc->wMaxCommand) {
-		/* The buffer would overflow */
-		set_bit(WDM_OVERFLOW, &desc->flags);
-	} else {
-		/* we may already be in overflow */
-		if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
-			memmove(desc->ubuf + desc->length, desc->inbuf, length);
-			smp_wmb(); /* against wdm_read() */
-			WRITE_ONCE(desc->length, desc->length + length);
-		}
+	processed = kfifo_in(&desc->ubuf, desc->inbuf, length);
+	if (processed < length) {
+		 set_bit(WDM_OVERFLOW, &desc->flags);
+		 /* WDM_OVERFLOW must not be set after WDM_READ */
+		 smp_wmb(); /* against wdm_read() */
 	}
+
 skip_error:
 
 	if (desc->rerr) {
@@ -372,8 +370,8 @@ static void cleanup(struct wdm_device *desc)
 	kfree(desc->inbuf);
 	kfree(desc->orq);
 	kfree(desc->irq);
-	kfree(desc->ubuf);
 	free_urbs(desc);
+	kfifo_free(&desc->ubuf);
 	kfree(desc);
 }
 
@@ -524,8 +522,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 static ssize_t wdm_read
 (struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
-	int rv, cntr;
-	int i = 0;
+	int rv, cntr, done;
 	struct wdm_device *desc = file->private_data;
 
 
@@ -533,8 +530,7 @@ static ssize_t wdm_read
 	if (rv < 0)
 		return -ERESTARTSYS;
 
-	cntr = READ_ONCE(desc->length);
-	smp_rmb(); /* against wdm_in_callback() */
+	cntr = kfifo_len(&desc->ubuf);
 	if (cntr == 0) {
 		desc->read = 0;
 retry:
@@ -547,7 +543,6 @@ static ssize_t wdm_read
 			rv = -ENOBUFS;
 			goto err;
 		}
-		i++;
 		if (file->f_flags & O_NONBLOCK) {
 			if (!test_bit(WDM_READ, &desc->flags)) {
 				rv = -EAGAIN;
@@ -568,6 +563,13 @@ static ssize_t wdm_read
 			rv = -EIO;
 			goto err;
 		}
+		smp_rmb(); /* against wdm_in_callback() */
+		if (test_bit(WDM_OVERFLOW, &desc->flags)) {
+			clear_bit(WDM_OVERFLOW, &desc->flags);
+			rv = -ENOBUFS;
+			goto err;
+		}
+
 		usb_mark_last_busy(interface_to_usbdev(desc->intf));
 		if (rv < 0) {
 			rv = -ERESTARTSYS;
@@ -591,31 +593,27 @@ static ssize_t wdm_read
 			goto retry;
 		}
 
-		cntr = desc->length;
+		cntr = kfifo_len(&desc->ubuf);
 		spin_unlock_irq(&desc->iuspin);
 	}
 
 	if (cntr > count)
 		cntr = count;
-	rv = copy_to_user(buffer, desc->ubuf, cntr);
-	if (rv > 0) {
+	rv = kfifo_to_user(&desc->ubuf, buffer, cntr, &done);
+	if (rv < 0) {
 		rv = -EFAULT;
 		goto err;
 	}
 
 	spin_lock_irq(&desc->iuspin);
 
-	for (i = 0; i < desc->length - cntr; i++)
-		desc->ubuf[i] = desc->ubuf[i + cntr];
-
-	desc->length -= cntr;
 	/* in case we had outstanding data */
-	if (!desc->length) {
+	if (kfifo_is_empty(&desc->ubuf)) {
 		clear_bit(WDM_READ, &desc->flags);
 		service_outstanding_interrupt(desc);
 	}
 	spin_unlock_irq(&desc->iuspin);
-	rv = cntr;
+	rv = done;
 
 err:
 	mutex_unlock(&desc->rlock);
@@ -1013,7 +1011,7 @@ static void service_interrupt_work(struct work_struct *work)
 
 	spin_lock_irq(&desc->iuspin);
 	service_outstanding_interrupt(desc);
-	if (!desc->resp_count && (desc->length || desc->rerr)) {
+	if (!desc->resp_count && (!kfifo_is_empty(&desc->ubuf) || desc->rerr)) {
 		set_bit(WDM_READ, &desc->flags);
 		wake_up(&desc->wait);
 	}
@@ -1071,10 +1069,6 @@ static int wdm_create(struct usb_interface *intf, struct usb_endpoint_descriptor
 	if (!desc->command)
 		goto err;
 
-	desc->ubuf = kmalloc(desc->wMaxCommand, GFP_KERNEL);
-	if (!desc->ubuf)
-		goto err;
-
 	desc->sbuf = kmalloc(desc->wMaxPacketSize, GFP_KERNEL);
 	if (!desc->sbuf)
 		goto err;
@@ -1083,6 +1077,10 @@ static int wdm_create(struct usb_interface *intf, struct usb_endpoint_descriptor
 	if (!desc->inbuf)
 		goto err;
 
+	rv = kfifo_alloc(&desc->ubuf, roundup_pow_of_two(desc->wMaxCommand), GFP_KERNEL);
+	if (rv < 0)
+		goto err;
+
 	usb_fill_int_urb(
 		desc->validity,
 		interface_to_usbdev(intf),
-- 
2.54.0


