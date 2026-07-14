Return-Path: <netdev+bounces-307440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qdj0KxQiVmrZzgAAu9opvQ
	(envelope-from <netdev+bounces-307440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7375417E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:48:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=n3FLQV0n;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DONg2CsR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307440-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17012303C5DB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44E3B4E84;
	Tue, 14 Jul 2026 11:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229413B27C1
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:44:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029500; cv=none; b=liJlI3oNlHcgl4i+D4NHwiPwRzxTpzHI+5xoIGhE1fU5mlbT/+PrhrxiNbPEHgJokBUHy8lO4Eao/fbKwCZSUt6XdUL7w7JTPJ7UgTA5zhO1k8ZMvN980pjjtENydep1CeUuqxnztk2KOZvzgmi9sP7uZw3bORxcsR4ZWMTAjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029500; c=relaxed/simple;
	bh=WN++4PiQVtaSIQZEGOz3Rbyzx8A7cSHakrZfyK6W5Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwOr2Vw1gWr5+0hfuXHi6UmcexSOkhtNx0nDrzNV1wnHmdr0e21HV5n+l6e8svlZOuxIIsj/Nw+WWVTcyQAzdMVDoLbEk52IEENdZ6DZaAo23WT+0shnEeaQfawiW70MvHJ/kT7lkiM+NmPSZdrANkshdDRIxnBhYcFblGiVAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3FLQV0n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DONg2CsR; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F29D977E34;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa8xfTrtdPUYc25tlb71+dHhzufOEBD9q7G/upAWK+s=;
	b=n3FLQV0ngu9sqVjcJ41UPysQUBDIU0Ww9YCK2Plf8ISE6HzMyfGir8th4c06qWYxVfw4G0
	mbb7YoTlOGFQDehtxEa4CrWwytupHqxSziyTzIr6sqOxSGSKL2R7T7dlqy3Fgx92GunUqH
	80GrXfo16AxOhOATrjs5q9XosUKE71I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1784029473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa8xfTrtdPUYc25tlb71+dHhzufOEBD9q7G/upAWK+s=;
	b=DONg2CsRG34pzwJDGKsADY5oHsjfXd7GJoRFCLrVSQVy45fFeqzABgjOWCnxhyOKa83BAz
	w7KVNsVwY5xxcz97xQjKeZjUSa3x8JuaVRVd82FM7zYeo8Nq40IBEwovWUfPsk3Dzf/MD5
	Ln2UdMzN3ACm5mZ9Xd75IhzdW98vbwY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDB86779AE;
	Tue, 14 Jul 2026 11:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJtVLSEhVmp+cwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 14 Jul 2026 11:44:33 +0000
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
Subject: [PATCHv3 net-next 9/9] net: usb: usbnet: corrections in the comments
Date: Tue, 14 Jul 2026 13:44:29 +0200
Message-ID: <20260714114429.1073434-9-oneukum@suse.com>
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
X-Spam-Level: 
X-Spam-Score: -1.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307440-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:from_mime,suse.com:mid,suse.com:email,suse.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76F7375417E

Correct grammar in comments.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v3:
- added to fix concerns about language in comments

 drivers/net/usb/usbnet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 0347f6887222..76bbbfb7a24e 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -2351,12 +2351,12 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
 }
 EXPORT_SYMBOL_GPL(usbnet_cdc_status);
 
-/* Make sure packets have correct destination MAC address
+/* Make sure packets have the correct destination MAC address
  *
  * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
- * device sends packets with a static, bogus, random MAC address (event if
- * device MAC address has been updated). Always set MAC address to that of the
- * device.
+ * device sends packets with a static, bogus, random MAC address (event if the
+ * device MAC address has been updated). Always set the MAC address to that
+ * of the device.
  */
 int usbnet_cdc_zte_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-- 
2.54.0


