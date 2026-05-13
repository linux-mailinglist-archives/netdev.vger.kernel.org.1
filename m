Return-Path: <netdev+bounces-287668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFTwLcufBGqbMAIAu9opvQ
	(envelope-from <netdev+bounces-287668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0C536A44
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3D69309762C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11323D28C;
	Wed, 13 May 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npRkMkoU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2494921A1
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686506; cv=none; b=IwoqVDN2vu8+YRhlombMxkxioaWIHGZK0ADiXXTPMLgyVtwIVMODAoTTduacjL75+RaJxB1C8WYcIODO57vOUgnpfiGeT6zeA5MZHr1FBGycARsYqb3bJSYbb9hv5C6bIaBpLuX1ym6NqkpEWNa7TF+yjjTiTOArhqn+4x6nWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686506; c=relaxed/simple;
	bh=380OIoxziQ8FlKx1mJdOpqZlW6QTVqBF+ru5RUN6Y8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ak9DJKYNzHR7lgVkaatMHCEkq0QnnqrqcV+RSjqobfr3ZMg5KghcBO65vmNbgapdULtBR+OCD1n9De55mpEOvkdtmKvWw891USdLot5im78G2RHQuYeg53sTd24mRWdbhv1K150ddC2SHSCxW1wdShsR6nPanhLpq+B/yBASRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npRkMkoU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2babfd18435so35711245ad.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686501; x=1779291301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ruAzbMeVdqPrvuygkIYeYyoYSoRcGERUW0xC+xQv0o=;
        b=npRkMkoUGnX70IhNC8M/ofOyKtFVwAiVdmWCIefbzRBhb9ApUHkAZn/LSblKzBFCRA
         wlOTJp3WKEN6cxWpj32fSDOxvmJSFeTaxHXGELTCZkENr8/dsHQWW/BOJoD+RiPc4Wcn
         ZHiMizZfcam6yOMHqJjLkpz1EZFQxJlQNPObFaG3u+1Gc+WXSMhmbCySzPER2zv5gqNz
         0uWCMkz3b/u06VCJzxJY4G4G/nJghKTash9R/knJHy53JLg5TKFtcJ2Hdt+pZs+3b3bZ
         +pv541wOv/ki2bCzgMngHRTw55QDIm5EekSXN0fiV8dWHh5YU5mK2PsXZaii7QyhbjRg
         KZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686501; x=1779291301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ruAzbMeVdqPrvuygkIYeYyoYSoRcGERUW0xC+xQv0o=;
        b=R8xBlzNgVlBdEvd0lL1V37WrZkChBrChTY38FgzAxNZUwN/UeOJSjBVufLgg/IXUZL
         XYAy8Vvvzrrxe9exXAJv9VgfPnXaz5d7Y9mziQHzuxuLxneOiwWmjUIWxU7x3e+udaO2
         tAZiCxA5TwOT1jHPExj65geTgbaLVjoIUyCNGCmylztnd+42buEDjuu68EemZJPg+VzK
         SMcAhpIVNfxjwlXyWCFQ0rP819gW3vHa2b5zEjX1jj7rncG988pHcz7U456Lhb1hGOuz
         8tuAc8nK6rq9G+IuB9DHU79rYnSgnmJ6TJD/bEDOuHID3ckef8coc/j+K/PvdZ6UD1um
         XZgQ==
X-Forwarded-Encrypted: i=1; AFNElJ92EfveS0SIaHhKjNAqOaSKo3n5uKpNFyM1LU2Q6IhvYFIE9lTMzlf6RXazWPxiorFolTH5M1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4VOMAc82eHMjeo29T6kRNnwNap6Ef7rD6zTeuErvcNbVPQqa
	ejzxjxraQhVRcfSpQJsptU+bS6cs41xGdkbdI1mxQjP/heTzhuFXxbPm
X-Gm-Gg: Acq92OH4Hjb4dxMevz2us3oLrBWZGOp3T83j9oGUO5J0npsYEqdVM0FEjn+Na4vKjqA
	Q3MImUARX8cOsSNblDTwuUcbT5Th0hLRPgUidVqasiBE7UL0yeB5YfUDHqLOLn8+n+xme02vN9L
	5a711rykWInoQhEU+ErJEsGFxPO0yJwQOoUIo4TVZXgLjQ47HR4Q9LoVCsvnvfZrxRJLPxobtu2
	KQ7QzGxoMaoLgBaoxKbeQnYBfVSeyh23pYARZ1PNp8BOduRznAB+5aN8vSs9g18dA1eGIRU1zVm
	ygQuw/gNpR5ZGiQQHIEcMuKMlBi6+NwyWoqO6b1OSb/GDmx71AN+nQwsd0Cax/DyLlsWgNiP00o
	z94IgedRA7nNoUXHCSAt0RGKDiiPGCfS6FnE4+NdHD4mXZroiAikWGlFlCzrEnEj6KpFk/6CEuu
	KkC0uZEbCzu84VfjrQOG7CP58vsGN32+jkrRcXnh+lCOqCu4vBxPIaLcceEhCX5Q==
X-Received: by 2002:a17:903:f8c:b0:2bd:147d:c712 with SMTP id d9443c01a7336-2bd27133c75mr44261705ad.1.1778686500924;
        Wed, 13 May 2026 08:35:00 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27055sm173821065ad.6.2026.05.13.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:34:58 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH wpan] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 13 May 2026 21:04:12 +0530
Message-Id: <20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0C0C536A44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-287668-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cambiumnetworks.com:email,cambiumnetworks.com:mid]
X-Rspamd-Action: no action

ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
'4' as the byte count to kfifo_in()/kfifo_out().

This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
then reads back 4 bytes into an 8-byte local pointer variable, leaving
the upper 4 bytes uninitialized stack data. The first dereference of
the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
address and generally results in an oops.

Use sizeof(fifo_buffer) so the byte count matches pointer width on every
architecture.

The driver has no architecture restriction in Kconfig, so any 64-bit
build with CONFIG_IEEE802154_CA8210_DEBUGFS=y is exposed. Issue has
been latent since the driver was added in 2017 because it is most
commonly deployed on 32-bit MCUs.

Found via a custom Coccinelle semantic patch hunting for short-byte
kfifo I/O on byte-mode kfifos used to shuttle pointers.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ieee802154/ca8210.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..154af346c936 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -597,7 +597,7 @@ static int ca8210_test_int_driver_write(
 	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
 	if (!fifo_buffer)
 		return -ENOMEM;
-	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
+	kfifo_in(&test->up_fifo, &fifo_buffer, sizeof(fifo_buffer));
 	wake_up_interruptible(&priv->test.readq);
 
 	return 0;
@@ -2541,7 +2541,8 @@ static ssize_t ca8210_test_int_user_read(
 		);
 	}
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer))
+	    != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1


