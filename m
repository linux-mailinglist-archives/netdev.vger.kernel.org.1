Return-Path: <netdev+bounces-305853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ut+WMCdiTmq7LgIAu9opvQ
	(envelope-from <netdev+bounces-305853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EBC727858
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:43:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AZaRDU7h;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305853-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305853-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67184315DCEB
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A24BCABB;
	Wed,  8 Jul 2026 14:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80273B71C7
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:34:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521263; cv=none; b=hMs4RB9kJolythcs2MFWpz/gzGKzjZokRu2r3YCOpQMF2YtQds/YKQQmysfxTHQdVWnQNXUVAt+QSs1qpv3OO7K/A+PS78A7CXvsu6RJ3hjTwDNPrdG1sOLjdHz3024eGzPdfSUbCErwkB+vur+rSgFkQbkR9htK8Pi32QQh3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521263; c=relaxed/simple;
	bh=WBc5/6p3zTwCgODy+MFv7Tx3YTqZQNBHukSBiobNYOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sGQLqP9Ei9TVQVSsxQpatg9sh7OFj7DuwxuFyj/61mRp9EE7+98OM2tbN+99d+J3Ruh4qlMwf+YiirIlPJbOCz5Kgew+2k39bT2W2gJBcKwBdYVnSpwvnpJQhoaEYoguX/hVMYHcUUglXcCgowTNXFCkGUhotmkP8p+QCizW250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZaRDU7h; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84347ad88edso1105531b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783521261; x=1784126061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=urwnk6AEILAyT861SpE2b4pteus/YCwOK1b7DC6yhBY=;
        b=AZaRDU7hPWG+gCnkfwHU2/po4beerva/rUCXw6psVr3/MBeyZi3yij7hReBO0d9nX4
         hFtUTt4mwK00owmiVLJ965myPBzM+gmNi8z+I7hN8katMlZT3sim+vFyf3AMHkQIrU67
         qpiNY9+az9sO/1PRuysrt+PSTY+eM/pw+bGLibwffmZo97sOkimJolvHD6VaKtO19y2e
         7TNApxwkwPdU/z9RtWUvVcU75TxbjVyDWhEBiQbkXHpYNBGqfikVjF7rIZrudP+xnMr9
         JnlgBrUYUrkxzmu0oQQl2qe7THoHy2nT2xYggnzGCrAN5qbQrx0dHQz7b9/uUqxSasMh
         W46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521261; x=1784126061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urwnk6AEILAyT861SpE2b4pteus/YCwOK1b7DC6yhBY=;
        b=I8ziBW1HW4bgbcy8K4Nic4HfNchkDDfQAQmcSv33aPtwvi9fM9U3v6RECyV2baohfW
         q5lczd0PwBRzNlFXuczShClHMnFQqW9sVCchQRaBO6a+vl2/1VjzqWkKiqrEkk4QqD+L
         On3CVqDz1lbUWvMKbFlRzL6g+vMgzCDC1dOeWFJJSMSoukwWAyDR3EgRvVTLdl80uuGI
         XksrPOIfEGi61t0h1Hpnx9r8ImYAWM1nyRaFaF+4WiMDACnx3o9eESTS/OMK68i4c3cS
         O3nP0WRnRamTATijxdgVcv/6M7CNR40Q25oAs8B3ZgK/9r+HSZSTR+3jS66hKXGp2Pka
         Pafg==
X-Gm-Message-State: AOJu0YzTbQFU3MmMyw8kLSWk+LfeOTB+uxVwtIttuNEmXgIcC0PuyVMf
	SmDTtfrNQvmTfiyIlHgnu3de8kacP+qej7tZDrRQXDOkLeqxeLDhj+qxGaqldHHHBZM=
X-Gm-Gg: AfdE7claRKUiDxOLfEDI8L/efaxdIE7s2TvI90d4hPpkDrbXAGp0xgabobIHqveH67g
	avwE3wXZ0Sv316fUHnmC9Bw9uga/FSPH1HRDzky8sUXA5lQk6ngMqizAvK/1HbmSb1XrmitvPlz
	0N5pe9m70va3UI2YRYEFt9/HOTeA5PkZeNuRbp2jK0L6clOtFXlMTButqtjBJv3QKMHHYD9Vxdi
	S4Rw9q3SyRje+y/lVlpB7Awz6sijIuOMPr5kkHM35t2pRI8moDyl7YIQVrGMdAwuxc3QPqR1WiD
	5B3f+hUznP+TvO3tyAdye6VysRKQyOUR7nyXDNSHSV6ar+go4YbqtvB6ist1ZdktmjT7pqUNT1l
	qNuTGVOXcsgmyY0HCmsBGe4/b0z8Ck45bsn87T+kz85NwGR0It3v7HPCNzaI4/NNgCX7YJV3/mP
	WsS2Tp2V7HCZparMH8pShz5PQkylQGYSIb
X-Received: by 2002:a05:6a00:12e0:b0:847:8b11:5966 with SMTP id d2e1a72fcca58-8484323bb1bmr3093018b3a.1.1783521261084;
        Wed, 08 Jul 2026 07:34:21 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1b95:b995:f60c:5c67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483dc66f2asm1490035b3a.24.2026.07.08.07.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:34:20 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net] wan: wanxl: Only reset hardware after BAR mapping
Date: Wed,  8 Jul 2026 22:34:15 +0800
Message-ID: <20260708143415.3169358-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305853-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:khc@pm.waw.pl,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43EBC727858

wanxl_pci_init_one() stores the freshly allocated card in driver data
before the PLX BAR is mapped.  Several early probe failures then unwind
through wanxl_pci_remove_one(), including failure to allocate the coherent
status area or to restore the DMA mask.

wanxl_pci_remove_one() unconditionally calls wanxl_reset(), and
wanxl_reset() dereferences card->plx.  On those early failures card->plx
is still NULL, so the error path can dereference a NULL MMIO pointer.

Only issue the hardware reset once the BAR mapping exists.  The remaining
cleanup in wanxl_pci_remove_one() already checks whether later resources
were allocated.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/wan/wanxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index d4da88c771129..065c00c12cc16 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -514,7 +514,8 @@ static void wanxl_pci_remove_one(struct pci_dev *pdev)
 	if (card->irq)
 		free_irq(card->irq, card);
 
-	wanxl_reset(card);
+	if (card->plx)
+		wanxl_reset(card);
 
 	for (i = 0; i < RX_QUEUE_LENGTH; i++)
 		if (card->rx_skbs[i]) {
-- 
2.51.0


