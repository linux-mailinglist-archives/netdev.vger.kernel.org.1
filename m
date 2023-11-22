Return-Path: <netdev+bounces-49979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD37F42E0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832631C20A04
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E6756470;
	Wed, 22 Nov 2023 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lKuq8ARl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E97D54;
	Wed, 22 Nov 2023 01:53:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B03D1F8D5;
	Wed, 22 Nov 2023 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700646790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rm8efB2h0EFnzH7RsJ3ZTEZxJII9oswUgWhpjX9sfK8=;
	b=lKuq8ARlpZKsRWzZkvMUc9uj6EAtjV9LraR6K8GAfwsQUMnor2Bsg0Dsj+7eK/Vrz6pfBv
	HYBYLEdHWzYCqtbeALZ1QEe1jp243kmOEG5/xSQNmS2u4k1Q0omO4TO2TyvU7bxqeQJp6/
	WTg9uUGQZ5V43gWLS/dutlh8jJ9efC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E869313461;
	Wed, 22 Nov 2023 09:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pYwFN4XPXWUBBQAAMHmgww
	(envelope-from <oneukum@suse.com>); Wed, 22 Nov 2023 09:53:09 +0000
From: Oliver Neukum <oneukum@suse.com>
To: dmitry.bezrukov@aquantia.com,
	marcinguy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2] USB: gl620a: check for rx buffer overflow
Date: Wed, 22 Nov 2023 10:52:22 +0100
Message-ID: <20231122095306.15175-1-oneukum@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 6.90
X-Spamd-Result: default: False [6.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[aquantia.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[28.19%]

The driver checks for a single package overflowing
maximum size. That needs to be done, but it is not
enough. As a single transmission can contain a high
number of packets, we also need to check whether
the aggregate of messages in itself short enough
overflow the buffer.
That is easiest done by checking that the current
packet does not overflow the buffer.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---

v2: corrected typo in commit message
 
 drivers/net/usb/gl620a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 46af78caf457..d33ae15abdc1 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -104,6 +104,10 @@ static int genelink_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			return 0;
 		}
 
+		/* we also need to check for overflowing the buffer */
+		if (size > skb->len)
+			return 0;
+
 		// allocate the skb for the individual packet
 		gl_skb = alloc_skb(size, GFP_ATOMIC);
 		if (gl_skb) {
-- 
2.42.1


