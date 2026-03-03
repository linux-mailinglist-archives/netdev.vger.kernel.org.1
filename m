Return-Path: <netdev+bounces-263244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD+zDcn1pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:52:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C479B1F1CF6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE4243017269
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E947D94F;
	Tue,  3 Mar 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D/fPMy3W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tffnX/dL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C23374E79
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549575; cv=none; b=EAcYp9RbS9lJjboQY0ersenBtXpOQp81zLqGfKhqystEEJNFIccqhC/fpbNNFP92pT1uk/mNf4el/QmXqZDS7FLLpFkTrpb+JALCa11G4D5S7W1uUylq+OD2F9PdSJRfZZbg0OJRnY9zs5FlaUa5RrFs7ni+0xYnNQM0I/qBpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549575; c=relaxed/simple;
	bh=pWDmYaf8U+BiAjsMr6gFWstsk8KBcqbuJ7+Y7BINxyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6YfwX3gWuj33z4jMQ18/4TLAtcGEr/rWRo7t9ItsIi9fy+X/rN+s6th0+U7LyQjcRYmt5AKR5VsubXrZeDBXUQMGiFBzNJgeAzqSjoEniGk+jfjW0JSiWK+uFoQi/EO+aZ4ctkLzF6wS0erlGpJDd9qZYS5gbfolZOsg6mWRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D/fPMy3W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tffnX/dL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 425B65BE16;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlk/R2Ffl6mCZS3j4Gk8mUnFs2D54aal8KVVQu3vvwU=;
	b=D/fPMy3WDUAxbKH1dHS1JHiMr0TKpquA+Q5pDxNbZ1y+YI121ZqGjHA0tQUQLtGNM7gnxT
	ortXdAkgEw8B2rtyGwcr2/fadLitgZQRJ5EJJyK2L1oypBDjUOa5rMDYQAdMEJ1NfawUwL
	7IvnUNPoa87z7/HUeH1KSrEKo4hSBRQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlk/R2Ffl6mCZS3j4Gk8mUnFs2D54aal8KVVQu3vvwU=;
	b=tffnX/dLMhIG8hSwUMdJIhRBB5ASKq4sz5WQuiqYYkRJ0oX8B1TfkdtFF1A+pqrB+2Ysuh
	QBdly81qZZDPkdl4SQB+PdR1zlhA4N9DIx54BollY/qfKG4PEsH/YT/zV4Wwk7TR4MJCuh
	eFkEF6RP8GQV0SwGTt5CLBF+M/fMAeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19CD93EA6E;
	Tue,  3 Mar 2026 14:52:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IEuBcP1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 04/13] net: usb: usbnet: add access helper for private data
Date: Tue,  3 Mar 2026 15:50:24 +0100
Message-ID: <20260303145242.1377514-4-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303145242.1377514-1-oneukum@suse.com>
References: <20260303145242.1377514-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C479B1F1CF6
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
	TAGGED_FROM(0.00)[bounces-263244-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

Drivers should not need to go for the internals of
usbnet to find their private data.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 include/linux/usb/usbnet.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index b0e84896e6ac..4a97845be62c 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -206,6 +206,11 @@ extern int usbnet_write_cmd_nopm(struct usbnet *dev, u8 cmd, u8 reqtype,
 extern int usbnet_write_cmd_async(struct usbnet *dev, u8 cmd, u8 reqtype,
 		    u16 value, u16 index, const void *data, u16 size);
 
+static inline void *usbnet_priv(struct usbnet *dev)
+{
+	return (void *)dev->data;
+}
+
 /* Drivers that reuse some of the standard USB CDC infrastructure
  * (notably, using multiple interfaces according to the CDC
  * union descriptor) get some helper code.
-- 
2.53.0


