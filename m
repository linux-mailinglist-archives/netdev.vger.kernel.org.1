Return-Path: <netdev+bounces-304209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S21mGsB3RmqnWQsAu9opvQ
	(envelope-from <netdev+bounces-304209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB36F8EF5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:37:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=G0eei6P5;
	dkim=pass header.d=suse.com header.s=susede1 header.b=G0eei6P5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304209-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304209-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9575330317EC
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B064E378C;
	Thu,  2 Jul 2026 14:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F294E3792
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:32:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002749; cv=none; b=WkqxN1aBL1CEtkL+3VlGbgRc3iiwl56wLHKvR/YnRNc6d2jPdVNhp2Z4Bz3P8O2ILa5+xNU4qg0TBypcoL4DxYqhRi+uofOZ5oxItABWgY4l2ALojo6yx1ku1LF3vjYlJsQhSMsT7KCvz5vX6I72Ky0i972sWQomBrDKVrWirV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002749; c=relaxed/simple;
	bh=p5LEF0TpeuJUKX9WSanvmmAQejWqAwoFRjpWjPdXn3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clzac1JMdhRiSC4GlaQSPotFiFOAUbKJNBSv8kSm5ARqSYmiUiYgqDSJn1zA3kHhbYdaoUBp3b41LL/f8R+Ww75ExoA4Shk+k6Hxls5Ix8JTFkZ6zW4sj9/ea8ANTv2Pnz6rV3nWN7X14A8nMKyqiEO9tqAUQ78khBeN5zSS9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G0eei6P5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G0eei6P5; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0972F75DB9;
	Thu,  2 Jul 2026 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783002709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enu0+TkL5+FOi84prkYHDpdzqlXme7u+bi/VxlIaI6M=;
	b=G0eei6P534pl2JlQdhqV2KYe6Q44BNp6VHV6cnQ9Jzqi5c+8CP/sWcCykfsNWBkK1CKbpx
	6vsXg7k6bOTkIhMoe9KaxhLiTm9lvUPkf9Lcm8JuQcr2CBTLeh7jVhMTDdW7N5Hu2M6cE/
	l2lPkbOch4+zGwNG6h33kqiMXUrzZI4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783002709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enu0+TkL5+FOi84prkYHDpdzqlXme7u+bi/VxlIaI6M=;
	b=G0eei6P534pl2JlQdhqV2KYe6Q44BNp6VHV6cnQ9Jzqi5c+8CP/sWcCykfsNWBkK1CKbpx
	6vsXg7k6bOTkIhMoe9KaxhLiTm9lvUPkf9Lcm8JuQcr2CBTLeh7jVhMTDdW7N5Hu2M6cE/
	l2lPkbOch4+zGwNG6h33kqiMXUrzZI4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C40DD779AA;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8GfdLlR2Rmr0MwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 02 Jul 2026 14:31:48 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shaoxul@foxmail.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH net-next 4/4] net: usb: use cdc_state in struct usbnet
Date: Thu,  2 Jul 2026 16:25:33 +0200
Message-ID: <20260702143142.890654-5-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702143142.890654-1-oneukum@suse.com>
References: <20260702143142.890654-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304209-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61DB36F8EF5

Remove private copies as now a central state can be used.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/cdc_ether.c  | 9 +++------
 drivers/net/usb/rndis_host.c | 6 +++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index e688fb99c61d..76ad4ffa950a 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -85,7 +85,7 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8				*buf = intf->cur_altsetting->extra;
 	int				len = intf->cur_altsetting->extralen;
 	struct usb_interface_descriptor	*d;
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = &dev->cdc;
 	int				status = -ENODEV;
 	int				rndis;
 	bool				android_rndis_quirk = false;
@@ -336,7 +336,7 @@ EXPORT_SYMBOL_GPL(usbnet_ether_cdc_bind);
 
 void usbnet_cdc_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cdc_state		*info = (void *) &dev->data;
+	struct cdc_state		*info = &dev->cdc;
 	struct usb_driver		*driver = driver_of(intf);
 
 	/* combined interface - nothing  to do */
@@ -374,10 +374,7 @@ EXPORT_SYMBOL_GPL(usbnet_cdc_unbind);
 int usbnet_cdc_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int				status;
-	struct cdc_state		*info = (void *) &dev->data;
-
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data)
-			< sizeof(struct cdc_state)));
+	struct cdc_state		*info = &dev->cdc;
 
 	status = usbnet_ether_cdc_bind(dev, intf);
 	if (status < 0)
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 5e39d05a2d7b..d539654687c3 100644
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
2.54.0


