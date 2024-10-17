Return-Path: <netdev+bounces-136433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4459A1B89
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6044E1C21B5B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448F1C6F72;
	Thu, 17 Oct 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bU5sOo9Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="htHuMcaL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755B1C1AD6
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149537; cv=none; b=PgnkGCXEZstjowbtrCJxn3/nHxARj77VK2PetFn3d66KahwhA3ad+pou4dlx2wNf3J+WMCQUL8UIS6ZqWsQg4ofOggXKN29JVpxBOoHPv7hfYgaHsOggQ/MJKOhRjQm2TaDZmAC8sMuVW4/Mgak2FzFRRlgTxiRAJg1H6MnTfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149537; c=relaxed/simple;
	bh=aKEFclJGGxvslthLMEOP4GckCQDOh6KnKJfnnXArTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbvnZ8garhgL6DuB9B/LwfxzGSOjCYCfjp0qZLehwBwuHWqvnicU6/SfLm4h3wpxvedYvpiJJg2r3dRQEUqMbSDisIHsZsW/92PsmowDmuzefugZwrs/y1SobKOmCYr7JTlRCnCsl9L9FcpB+Uje2gs6Fk5Iw6GpPwU7FzTqG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bU5sOo9Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=htHuMcaL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D18431FEF5;
	Thu, 17 Oct 2024 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729149532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mVDx7hVHlcVR23xNcDwWqTbpy41fVb1AnT+B7+G1eBE=;
	b=bU5sOo9QuTFAbxttBK8u749flwCzcKKoa6JcROORQDOXctCO3lPb4Q3AItjhYbtCUcYlk8
	fn81DiuQ3WzJ/OYNeipG22tPuZVRBqtl2s/EAhm332v0LJlAu5wXwnixNjGaQttwv8wRVy
	cKhFaV7UTwghyh5fnDIqIuGITqKFjcs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729149531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mVDx7hVHlcVR23xNcDwWqTbpy41fVb1AnT+B7+G1eBE=;
	b=htHuMcaLjW1Lu9XnVA9aUhwj9F1Gm+gGfvjgbaP8pk2ppynlAu9wzFsvnttGuLNpBkWsXt
	ha2s9jlxviOR3mIx00cRrK/NsNQNcWnawz5ZWuY8M+rYe60koi07FYzDrFgvZEhiLgTXdu
	JPEiXiNCJXivZRGPLQ+HjPrWrarqr14=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A36C413A53;
	Thu, 17 Oct 2024 07:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /1vCJlu6EGeJIwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 17 Oct 2024 07:18:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>
Subject: [PATCH net] net: usb: usbnet: fix name regression
Date: Thu, 17 Oct 2024 09:18:37 +0200
Message-ID: <20241017071849.389636-1-oneukum@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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


