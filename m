Return-Path: <netdev+bounces-135692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF899EEA6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210821C20B9D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BFB136E3F;
	Tue, 15 Oct 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dhHcEYyr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dhHcEYyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71461FC7C2
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001089; cv=none; b=Fgr4o6DF95cL+f9ep+0wTJbL2kMxI0wHaKm9Hv6XoohFseLhjDJlqmnaAtGGPM2tnRAWyLWruqvxwiXie+av/QjDhq1BW4vVfEVIAT0HW42SFJMZeAfp7oix2WPggyJaEDWZi4u1B6MCrCCBqO04KmNGu4O/V9+xzmsB+ATZO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001089; c=relaxed/simple;
	bh=aKEFclJGGxvslthLMEOP4GckCQDOh6KnKJfnnXArTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFNwvreuLCkrGNBdgA+t9+xyG6C7duv0voh5tJq27tfBNHVQLg1mmNd8QOqAn22b+KOW+Ypfkca5O26g8M7btntFFU0nrWIX1pkQCcHXKgHMlbUMJtax6/kkvtGfz+s9LXTimcTYpVVcVv+CMd5mhRkErETfWF/Hs9UKoiQ5asE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dhHcEYyr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dhHcEYyr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09BEE1F44F;
	Tue, 15 Oct 2024 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729001085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mVDx7hVHlcVR23xNcDwWqTbpy41fVb1AnT+B7+G1eBE=;
	b=dhHcEYyrP7S2g3Zjg+ZUjdCOV/D7C2GsCDT42aR2Z10YzeN+CqRlYx8Hfp9FIGOCPHnwNb
	DN9NNgpphlZ4x3RnQ2K1kpbZW5sid7azDouyUZ7nOyRxCuOE1Tb2Dj1YX8GyynLlsnyPkS
	e0rHlxPjsGHOGIX1OGHUetQRb6DTJIE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729001085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mVDx7hVHlcVR23xNcDwWqTbpy41fVb1AnT+B7+G1eBE=;
	b=dhHcEYyrP7S2g3Zjg+ZUjdCOV/D7C2GsCDT42aR2Z10YzeN+CqRlYx8Hfp9FIGOCPHnwNb
	DN9NNgpphlZ4x3RnQ2K1kpbZW5sid7azDouyUZ7nOyRxCuOE1Tb2Dj1YX8GyynLlsnyPkS
	e0rHlxPjsGHOGIX1OGHUetQRb6DTJIE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCEB713A53;
	Tue, 15 Oct 2024 14:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5MBhMHx2DmdJfQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 15 Oct 2024 14:04:44 +0000
From: Oliver Neukum <oneukum@suse.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>
Subject: [RFC] net: usb: usbnet: fix name regression
Date: Tue, 15 Oct 2024 16:03:32 +0200
Message-ID: <20241015140442.247752-1-oneukum@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The fix for MAC addresses broke detection of the naming convention
because it gave network devices no random MAC before bind()
was called. This means that the check for the local assignment bit
was always negative as the address was zeroed from allocation,
instead of from overwriting the MAC with a unique hardware address.

The correct check for whether bind() has altered the MAC is
done with is_zero_ether_addr

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: Greg Thelen <gthelen@google.com>
Diagnosed-by: John Sperbeck <jsperbeck@google.com>
Fixes: bab8eb0dd4cb9 ("usbnet: modern method to get random MAC")
---
 drivers/net/usb/usbnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index ee1b5fd7b491..44179f4e807f 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1767,7 +1767,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		// can rename the link if it knows better.
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
 		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     (net->dev_addr [0] & 0x02) == 0))
+		     /* somebody touched it*/
+		     !is_zero_ether_addr(net->dev_addr)))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
-- 
2.47.0


