Return-Path: <netdev+bounces-307437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cWQdNXshVmqgzgAAu9opvQ
	(envelope-from <netdev+bounces-307437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A047540C2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:46:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ACcewGrJ;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ACcewGrJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307437-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307437-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BC403022E81
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8738F621;
	Tue, 14 Jul 2026 11:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A039150A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029490; cv=none; b=SJU8rvbzSA/rJn3nBPdy+qHmDEbiEKi4Dhh/M0uchSryRqmARvAVJnF0KbAweVujrcI85ix/T3c6K8mEh8hfQAVt9mKxGt7dn6eE+mYgxMk7bpPk9Qqep1ShVXWyhqcoMJIjXF8Rzc4XVgQCXZpv4TctckaVJJTR7NRm+p09MM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029490; c=relaxed/simple;
	bh=Htl6c36B8dE9puLyF/oy3vogvxkI7f0K2VvzunfRNqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxh/tPRldhSn9M3HmUwoCNZZbAiGmQGyTKhmWlQ+cOBBTb9rYp8bsfOqvRavYuMjnQPUIIPVCIGhR2HnTdrwkys2iha2TnhmZve2S4ms+1MSV1AlPqb7fFi2WncgnuDbwVdrk7mTzHuULpd87CX/Qnb7vtsqaEZkOEkv27dK3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ACcewGrJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ACcewGrJ; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 809113E26;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2idcN/Q/emwBtFOQniHHb7bc/xbfDXc0WloxPi9y6hA=;
	b=ACcewGrJiBuLK6p780Z1lbn69ErixJCDjBzgZaqMLfyhmz2maPLwmnj4UgI4SzFjQ0hCmK
	TlgkFBvjh0AdAi/nmmXCiWQ8Jg5LYyyQq59vBpyimIpvv797DQRuX0SPep7m9BIpR6kOqO
	7Z8Y1b3+8dru4IfrBQXI8A9WwkQwVik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2idcN/Q/emwBtFOQniHHb7bc/xbfDXc0WloxPi9y6hA=;
	b=ACcewGrJiBuLK6p780Z1lbn69ErixJCDjBzgZaqMLfyhmz2maPLwmnj4UgI4SzFjQ0hCmK
	TlgkFBvjh0AdAi/nmmXCiWQ8Jg5LYyyQq59vBpyimIpvv797DQRuX0SPep7m9BIpR6kOqO
	7Z8Y1b3+8dru4IfrBQXI8A9WwkQwVik=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BF3D779AE;
	Tue, 14 Jul 2026 11:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IIqKESAhVmp+cwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 14 Jul 2026 11:44:32 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	manuelebner@mailbox.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv3 net-next 3/9] net: usb: usbnet: add cdc_state to struct usbnet
Date: Tue, 14 Jul 2026 13:44:23 +0200
Message-ID: <20260714114429.1073434-3-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114429.1073434-1-oneukum@suse.com>
References: <20260714114429.1073434-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-307437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:manuelebner@mailbox.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oneukum@suse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:mid,suse.com:email,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74A047540C2

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


