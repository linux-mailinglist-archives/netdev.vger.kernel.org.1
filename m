Return-Path: <netdev+bounces-304206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3cI3Emx3RmqDWQsAu9opvQ
	(envelope-from <netdev+bounces-304206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA506F8EB8
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304206-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304206-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EE430B00D3
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE14E3799;
	Thu,  2 Jul 2026 14:32:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C04DD6F3
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:31:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002719; cv=none; b=iMXAeqc4douezsvc4ZZGPC/RPylej0hgSeNbdpj8EplwvqvnsNm5Ptd00J76qghVTJyzUUZcUjHzLPeurTgMLgNXlnr05gfpUOyCSs+bBfVO8awjDdGDT+qRuHglGSECe9pCiLoEQv/92Y+yUSRJldX60lS3xipKBsUrctlq+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002719; c=relaxed/simple;
	bh=Htl6c36B8dE9puLyF/oy3vogvxkI7f0K2VvzunfRNqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN/wDd7LtjRW++StnrmGDRL5CT7+f/3cNDBQc+w8avZWrfCNtK9PCFnY+/WCh1liZcWT7OVOGMMFcE7wWGoA9MI7LzfNfW/bUWwBTcC4dxQiEiyQPYPwLdOEb9iBaHnGqrZE6zRj+OGTSA1J278UV4IceewMMNj3mgaCho16j+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF30B74237;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87995779AC;
	Thu,  2 Jul 2026 14:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0HQTIFR2Rmr0MwAAD6G6ig
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
Subject: [PATCH net-next 3/4] net: usb: usbnet: add cdc_state to struct usbnet
Date: Thu,  2 Jul 2026 16:25:32 +0200
Message-ID: <20260702143142.890654-4-oneukum@suse.com>
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
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304206-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBA506F8EB8

This allows centralisation of code using cdc_state in usbnet, reducing
code duplication. No functional change intended.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 include/linux/usb/usbnet.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index bbf799ccf3b3..79f48eb388ee 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -16,6 +16,14 @@
 #include <linux/usb.h>
 #include <linux/spinlock.h>
 
+struct cdc_state {
+	struct usb_cdc_header_desc      *header;
+	struct usb_cdc_union_desc       *u;
+	struct usb_cdc_ether_desc       *ether;
+	struct usb_interface            *control;
+	struct usb_interface            *data;
+};
+
 /* interface from usbnet core to each USB networking link we handle */
 struct usbnet {
 	/* housekeeping */
@@ -41,6 +49,7 @@ struct usbnet {
 	/* protocol/interface state */
 	struct net_device	*net;
 	int			msg_enable;
+	struct cdc_state	cdc;		/* too common to leave out*/
 	unsigned long		data[5];
 	u32			xid;
 	u32			hard_mtu;	/* count any extra framing */
@@ -211,13 +220,6 @@ extern int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
  * (notably, using multiple interfaces according to the CDC
  * union descriptor) get some helper code.
  */
-struct cdc_state {
-	struct usb_cdc_header_desc	*header;
-	struct usb_cdc_union_desc	*u;
-	struct usb_cdc_ether_desc	*ether;
-	struct usb_interface		*control;
-	struct usb_interface		*data;
-};
 
 extern void usbnet_cdc_update_filter(struct usbnet *dev);
 extern int usbnet_generic_cdc_bind(struct usbnet *, struct usb_interface *);
-- 
2.54.0


