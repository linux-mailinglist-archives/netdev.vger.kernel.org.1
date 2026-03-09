Return-Path: <netdev+bounces-265647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BGILPX9rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:05:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBF23D551
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5901E308C12C
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC03E717D;
	Mon,  9 Mar 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NWStC1Mt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NWStC1Mt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4C3E8C6F
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075412; cv=none; b=WVX+r3yWvfRKtQymxvmVSoUuK+Hp911YeTFkolABTsTxSRSrEJXtacifISWkn81r+QdvKJYTb+2Pg0I67rgRt8uUHegCutZD4rQTZBF9iZvYtv/x7podSTqn2SCu8V7Fk4guv63/uE2SPpm8AcyQ/km8kQuTg5/0qz6sg6H4ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075412; c=relaxed/simple;
	bh=SKwscCFhkRkWAEkHP7Bf/xEi1e6bolPPjdvBVmQngaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV9IZ1/vnOhJWE6cMg/4Z83vjIagMJh9smrGacZmdrh6GLdYEmYBni08C+5kltDOypvit2GbaXm2rWm7TcXtK+T76yt3PbT1CaCtJ6Bpa+M9jDEeRYdHxxZvctZMpFpK9GCuRJDict4MnqggWDTvzXmho9AtFfPZK0iuJf3zIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NWStC1Mt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NWStC1Mt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62CD34D24E;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9NN7nS+ZF5iB2eP+TT56PvoPMPMAryFYQyR358z/nE=;
	b=NWStC1MtRf+9UrflSrWMKZRkqMTmkbcMdRHUJaax2uuHymVj84rQvyy441rV7jSCrbTSux
	+UwxicuQ1BHCAutz00StakutKg3thdbxwVi98pngl30KdnJUumyxzmUkqGe6Zt3psI0xOP
	o5fBu7gy2dommCYyzamVqPm9LTb1Upk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NWStC1Mt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9NN7nS+ZF5iB2eP+TT56PvoPMPMAryFYQyR358z/nE=;
	b=NWStC1MtRf+9UrflSrWMKZRkqMTmkbcMdRHUJaax2uuHymVj84rQvyy441rV7jSCrbTSux
	+UwxicuQ1BHCAutz00StakutKg3thdbxwVi98pngl30KdnJUumyxzmUkqGe6Zt3psI0xOP
	o5fBu7gy2dommCYyzamVqPm9LTb1Upk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 429583EFD8;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPMoD7j7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:24 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 06/13] net: usb: usbnet: add cdc_state to struct usbnet
Date: Mon,  9 Mar 2026 17:53:29 +0100
Message-ID: <20260309165614.861929-6-oneukum@suse.com>
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
X-Rspamd-Queue-Id: 4DBBF23D551
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
	TAGGED_FROM(0.00)[bounces-265647-lists,netdev=lfdr.de];
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

This allows centralisation of code using cdc_state in usbnet, reducing
code duplication. No functional change intended.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 include/linux/usb/usbnet.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 4a97845be62c..766862427620 100644
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
@@ -215,13 +224,6 @@ static inline void *usbnet_priv(struct usbnet *dev)
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
2.53.0


