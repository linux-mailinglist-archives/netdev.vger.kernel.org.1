Return-Path: <netdev+bounces-268589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP53KgpIuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:24:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0752A9CA7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08E56304502E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE23BC671;
	Tue, 17 Mar 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BovfzstJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DE378800
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749988; cv=none; b=RzBDOWmvkaBFisN8BeJ1zXGCUcT7axqmIQSnVVjZwFKcVlZbqzZG3cLUMzsc3oHHSTdY5+tylhY1udhFDH0j3awSlsPelicckCjz7mRGa3BsKiYBLgA9sjD2SufMlMYS03PPAdZYNwBnQ2m7nHYJUJSNdo51V2KUFI7nTuVtRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749988; c=relaxed/simple;
	bh=s4JZjSbZQmE1mwQvqkXq3G7uBc8SZUl++ECGH/8/6oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQ/lGMqH8cgjnktxNok9izuidOOZwCpehOkceL5Wiz3ilr996jho+pVPT8OyyOiLwZy66qhCizYoExLBH5vrDRV12eRLoasUAcXh2Iq37gdMtZrz9nuc6QeBBGifRUmvwHNe2b6J6LTvCNgPxqJoWatgjGFAEi85jWQzoodvgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BovfzstJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2aecc6b0861so24724655ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773749986; x=1774354786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCHW5LCY6u+U/vsUxJTMq8Ol7b+zVLBPKYua+ntdkdU=;
        b=BovfzstJdxxcViSQBhPCZpXKmSQ0Qyto0b6UHuMyv+hvoNS6Sz6d4Py3klNAlA//2W
         R1CzNskiIEAp6yoR2FTCGtp3OL+FZzlr9j3zm2oEUWd7EpVR6HRehrw1MQuRWsqV6Ap5
         148yNGvENdYwDP0g2t2z3fuX6qqQmGURCByQGyogbw5opws49152LtPABFo/4C7FHkK2
         jXCynqmGkJ3wLP4OTWXIS9g7SpcsWTBHwUa+4OOuMvPWcbUHENqcuJbryrXq3Ww2sjZl
         14slzgsmwluX0t60aZvB3YGY9ptojFCVuWFxP7/saaeLmNwvm09njoJrffX97cjBZWSf
         L1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773749986; x=1774354786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCHW5LCY6u+U/vsUxJTMq8Ol7b+zVLBPKYua+ntdkdU=;
        b=F9xGKaUDa131uf8e7jDN0whhRNj0t85lwR4nf78bF3Lre01wUKDxX1oG4lNO4tTpo5
         cRCPMOnm69epZrooBDpPPwsxYOvuMdcK3xmo8IkYE7yYlF2h/EXFdclUbCtlQ2pcrH/Q
         RvyzDJRgBdQghhhqzVf32Nb2NaJSHsX7qd6A72YJyTSVhJcdI8DXA4wcxgTTqOChHlxp
         jeZHHmLtScIR6b6w9I2kP6btDVUvppEh8/dImaH6zZPRucvRXEQ1ZQCOmnET/eQHs/zj
         tWXhkL2mr2TUzkl9BlhjpdsX7lgQrkZY7XtH7yoffTVnI6uFaQ7Lc23NryImnrjCHNQE
         lA2w==
X-Gm-Message-State: AOJu0YxyFD4+Fnm02s6WZRL8O/Yic2NQ4RP8g5Kpojl3LDn9EiXGbui7
	7yFV90krCxzZnxiE/QoitjSMxv0jUxDDZbQQ8c1pH5GfwDa2RaxSZc9lSiYrgxQt
X-Gm-Gg: ATEYQzzEHwKSVGjeWAzSHO6R081bc6SoW5BmgzmLvAXu1ybZNR75sTwjGcZV5W2p3E/
	rzMfFZaYLyErjLALN3BrLnU+RUiQCNU8ETVTIEfiRoFdl27iYUVJQbsvYAGacI8D5gzupgZpYxB
	+38WI3eIcvIHSieLzApVjHua1AmyRlhNK/i/6IkpCocLfVbrk2xhycL8JryNTQK7yBZztZ2IVYs
	pKP3viRzXNd4o9jE5MR9WlYhoana2972uGkwqR50KGd6SrNdgp+TtsscZbG4c2hxyJXTxOfjKgR
	wB0hIY83VxpFlpKooBWJKv0onJIOu+pV/B+cye7IGhe4lrgtLDRJ05q3oFhpT3aKYBBbSsDlx8z
	A6NDgRSzH3KqUrVvqGRG9+YZ6ZOchVOKBlTcyJhmhboijIl/TRAizyRlABzcliTNW1QoH8P5imv
	Msgdh4KQMurmbLaWbg7fKNOULrWk6BPQaD9zy8wvnHeA==
X-Received: by 2002:a17:903:41cb:b0:2ad:dd69:76a2 with SMTP id d9443c01a7336-2aecaad02edmr177427505ad.31.1773749986356;
        Tue, 17 Mar 2026 05:19:46 -0700 (PDT)
Received: from XP-PC-yangg9.xiaopeng.local ([98.98.122.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05db37a8esm77980185ad.29.2026.03.17.05.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 05:19:45 -0700 (PDT)
From: yangg9 <cohenyang511@gmail.com>
X-Google-Original-From: yangg9 <yangg9@xiaopeng.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	yangg9 <yangg9@xiaopeng.com>
Subject: [PATCH] net: stmmac: Reorder cleanup sequence and disable IRQ earlier in reset path
Date: Tue, 17 Mar 2026 20:19:37 +0800
Message-ID: <20260317121937.109211-1-yangg9@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cohenyang511@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaopeng.com:email,xiaopeng.com:mid]
X-Rspamd-Queue-Id: ED0752A9CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The recent changes restructure resource cleanup in __stmmac_release() to
free IRQ lines, stop DMA, and release descriptors before stopping the PHY,
ensuring resources are properly cleaned up in the correct order.

Additionally, in stmmac_reset_subtask(), disable IRQ as early as possible
after acquiring the STMMAC_RESETING lock to prevent spurious interrupts
that could access device state during the DOWN transition, reducing race
conditions between interrupt handlers and device state transitions.

This improves the robustness of both the release and reset paths by
enforcing stricter ordering guarantees on resource cleanup and interrupt
handling.

Signed-off-by: yangg9 <yangg9@xiaopeng.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 124d7a00f9f0..fa06b2eb33f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4202,6 +4202,15 @@ static void __stmmac_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
+	/* Free the IRQ lines */
+	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+
+	/* Stop TX/RX DMA and clear the descriptors */
+	stmmac_stop_all_dma(priv);
+
+	/* Release and free the Rx/Tx resources */
+	free_dma_desc_resources(priv, &priv->dma_conf);
+
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
@@ -4212,15 +4221,6 @@ static void __stmmac_release(struct net_device *dev)
 
 	netif_tx_disable(dev);
 
-	/* Free the IRQ lines */
-	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
-
-	/* Stop TX/RX DMA and clear the descriptors */
-	stmmac_stop_all_dma(priv);
-
-	/* Release and free the Rx/Tx resources */
-	free_dma_desc_resources(priv, &priv->dma_conf);
-
 	stmmac_release_ptp(priv);
 
 	if (stmmac_fpe_supported(priv))
@@ -7331,6 +7331,9 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
 
+	/* Close IRQ entry as early as possible before DOWN short-circuit path. */
+	disable_irq_nosync(priv->dev->irq);
+
 	set_bit(STMMAC_DOWN, &priv->state);
 	dev_close(priv->dev);
 	dev_open(priv->dev, NULL);
-- 
2.43.0


