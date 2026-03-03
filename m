Return-Path: <netdev+bounces-263246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OHdCNP1pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081871F1D13
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 996B430185FD
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C647DD5C;
	Tue,  3 Mar 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d/6YYIqB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YLsc1bRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF1430BBE
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549581; cv=none; b=Fpuq2J7rZ+kxwvMia6rLEon/EKXuFVZrOR0SHFLlezbf7hIDoPdezkZ2cbtET9W/pMKwTnHh0g/gymOkiBjF4JP47SjEsh0pTW0csmtnApqJ+NbuZLoiiQr7uOhneKkwiYyKCw69HdcW2GUXtROi9ytQwJ2I5bsFdX0mtff+ues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549581; c=relaxed/simple;
	bh=CcR/2Yr4zgcKxcfW0Ia0AtEA7Hy9hMZkjPA/DMhuWd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsPXRlftMTcbPQvrCzms/iJ6ALZ3jAbX8gs4sdw9tUMKlFvSLOP6M4TvFZK7LNa1LgHcA+nXPqgaK8Uk/dNFRyCoNIu5ugcw6it3cFE77lM5emIeodXtW9RkTKbrXy6SLvjAVe8kQ573/YTttFBruqKyNSzecMUQuuRsb2XOhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d/6YYIqB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YLsc1bRM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8C515BE06;
	Tue,  3 Mar 2026 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jN8/fM1WCVAxQoWADbyr4cBrM++5CI6ZzPtq1HXgPz8=;
	b=d/6YYIqBFLe2GBi4nZ+6Qp/g20PRyYgOtQjdkCEikHr5WI5uTCP21l9rLRd0pXTuFZmor7
	ebC5QJWR9CVwDycnAL2CCkiDqd6ZWcPVx5H1z/Qgq47tPcBQdjscCBaVfYcMXHqayAFtz7
	lMYCydhxqvWAVFHin7LZdYMdIdumKZM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YLsc1bRM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772549570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jN8/fM1WCVAxQoWADbyr4cBrM++5CI6ZzPtq1HXgPz8=;
	b=YLsc1bRM01XPt+aHkj3wmt3RojZq2ghOcczaymXEiAWYw7pRS3updYyO+PuUs5ccgB3bIe
	vzfs0j6wsu0yrRMoOcQxZD0DHG23oiIwoVqB1CwsmPhaoFlcvOn+fbBsWFpAfbYI546D9T
	4QUPNRHziBeFjqZIY1ywvMuz3dhDZ0c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 986423EA69;
	Tue,  3 Mar 2026 14:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGgbJML1pmmPKQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 14:52:50 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2 01/13] net: usb: usbnet: use proper ep number macros
Date: Tue,  3 Mar 2026 15:50:21 +0100
Message-ID: <20260303145242.1377514-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
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
X-Rspamd-Queue-Id: 081871F1D13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263246-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

We have macros to retrieve endpoint numbers now.
Use them.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index ed86ba87ca4e..d1edb710a5ed 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -149,10 +149,8 @@ int usbnet_get_endpoints(struct usbnet *dev, struct usb_interface *intf)
 			return tmp;
 	}
 
-	dev->in = usb_rcvbulkpipe(dev->udev,
-				  in->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
-	dev->out = usb_sndbulkpipe(dev->udev,
-				   out->desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
+	dev->in = usb_rcvbulkpipe(dev->udev, usb_endpoint_num(&in->desc));
+	dev->out = usb_sndbulkpipe(dev->udev, usb_endpoint_num(&out->desc));
 	dev->status = status;
 	return 0;
 }
@@ -232,9 +230,7 @@ static int init_status(struct usbnet *dev, struct usb_interface *intf)
 	if (!dev->driver_info->status)
 		return 0;
 
-	pipe = usb_rcvintpipe(dev->udev,
-			      dev->status->desc.bEndpointAddress
-			      & USB_ENDPOINT_NUMBER_MASK);
+	pipe = usb_rcvintpipe(dev->udev, usb_endpoint_num(&dev->status->desc));
 	maxp = usb_maxpacket(dev->udev, pipe);
 
 	/* avoid 1 msec chatter:  min 8 msec poll rate */
-- 
2.53.0


