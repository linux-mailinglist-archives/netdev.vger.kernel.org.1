Return-Path: <netdev+bounces-271264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC4ZDTrtwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AB31BFCC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 909BF3046F94
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369231F986;
	Tue, 24 Mar 2026 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JotLllMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2732F749
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381889; cv=none; b=tNqv/SF56nyfVIf2owOVrKcrIFp8Sh8DFlgW8OfdomSMZTxi3eVpQ5M24O2ZTMTFSDqR55kaVtSUCgYL4NhdBfxgVqF6HP+FZYQI3iC41QqvaCQH0Zpom6grEVmNJfLUMPCy+qfpu4YVx7MILknLsEgBKx1Oa34E1ltRsqzVxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381889; c=relaxed/simple;
	bh=9IDUwuolSvIr+T1Bjwk9oOEvk4bCy/YalHCEXSfrE6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW5OWxAgVK1jqRyI8yFh2t7UGMiMnLcemMkQwu99lWSy8cfL8dCrt2+OMiwYHNfO3YFN6zo4Wwbu7TMbUtiOdPVBYpEvWwXW5i3f/Ykf3CVtCOib6uHQc7e0ZbZDyNbUkljPoVTQJGDIGeDWib7Z9xZs0THCTz2+p/xg8tJdcUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JotLllMm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso2119944a91.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381886; x=1774986686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG30QuGyPhv+dp7179rJ4vpIIfTuKiZcCpiUOnwWz2A=;
        b=JotLllMmgNW/JNzRtHe5zJRPqibN6/Baq4/q3NQDWBgR0XVc+RHGYcnRe7vEzMEcv/
         J87knsb2J+pbsXG+0DNDDAhB3WA5qH8xFXpjko4zINRSROr26AMt33yq99McV3EjYSy7
         kYZ+YaH5xy+LWmeKFqylLkT45+kvrm3aSY2vqn59cL6IcEhZTO4XQwirm0Kp53abok8t
         KhGJEk+1rgAJ31M+ZQRgkO5/A2BLyGhgIdX0ABRkDU1tn7vxyEkPrcDCjRBurNc4tqBV
         9dt7MZNrrGyk3v+F3VxgZ8UVbcnO+CN3A/miYyur9k6kiP2ch38p+Hs7rTWCv0cuU1th
         aO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381886; x=1774986686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MG30QuGyPhv+dp7179rJ4vpIIfTuKiZcCpiUOnwWz2A=;
        b=Bs2H8T8d2vbpUpeXowzLUL0kCYrol00qB8f5qKKCU7X14w+9/NDxdcgDBI5KnX+SHa
         wcwFaYSUo96xMwak56WckKQSBJekug5kq14xTcPIbpdHdGP+TOdAw2pzwVpVFuDRzZmN
         a6Ryrc7G40fyfMAGhnvv5QzuEC32Rgsnl6KAZuZnWZkiHO7mI7Ic/y9BMfwWp6Qm1iJU
         u9Y0BXoGNbn8JXGt8+k9V58JCZAHkiyo1Df3kAzN2P36oiP/sCDBLdximyoV/d2T1C10
         ciPkUhDu4366XEX1f3rqHoa//mdNereTsGAR81xjerCHBy/pr4chOLYIDEp3CFQ7GuPr
         wC6A==
X-Forwarded-Encrypted: i=1; AJvYcCVMKyqy84swipDXhqlKfnfwygBVWFTeS8QJABybDlpBq3RXztAX4TQXsJTiLouNLLepYXtEFiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD0YzzUO1s3wJAfN4wDJYaD79B4vA73s//xRxsMwQcUTd9iSu+
	4fkjVFEyfr6CeDbkoEIsZMgwJgYebSPJbeNRvePrZC+Q9d0hLJ3eklz0
X-Gm-Gg: ATEYQzyUA+f+eN4XqF6mvhWSEQ9c3WOgaCZ7WL2QuqQ1ticjGhQCnDK/qnSBK4RBRDP
	CE5XDCLfxROHiVto+0VCMDZe3a58Tu4AdVs7PwgZtp7/S4tCDkU2xMOrW82iaTnzqVb0CagXHap
	27DZ6Vmghr1nqiro/MhlUniu37BaMqwMsNxMJpjiIxgFVGMEoZvvGmN6pHAsctUF1JHAVGaq8XL
	skEgpCFWo3sMiYyaaCiKuhD40Qqhl8pADOC75VJDGhYp1JzQYjWhpMpnGMNWMPvhbzmrRhzPs1+
	w6+J4JY0nQP6Y55P96mACPkhNSbBhxlrFtYVtW+MUN+PYzHeh9C3l8y7HBcgieBQACUDG0RmYS6
	TZYJxajLR2TX6Jg+K+5koqxafa+t/wd1X5RtbJCyebtkUdCqa9y4DXNjDxsnniynNKECaic8hcI
	DyQjDyMjbqghFMTbD4GFkfNcVW
X-Received: by 2002:a17:90b:2f83:b0:35c:d37:6024 with SMTP id 98e67ed59e1d1-35c0dc851cemr461428a91.11.1774381886397;
        Tue, 24 Mar 2026 12:51:26 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c031403e4sm3910878a91.6.2026.03.24.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:51:25 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Mike Marciniszyn <mike.marciniszyn@gmail.com>,
	Lee Trager <lee@trager.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net 1/2] eth: fbnic: Account for page fragments when updating BDQ tail
Date: Tue, 24 Mar 2026 12:51:22 -0700
Message-ID: <20260324195123.3486219-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
References: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271264-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,google.com,redhat.com,lunn.ch,gmail.com,trager.us,intel.com,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 370AB31BFCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dimitri Daskalakis <daskald@meta.com>

FBNIC supports fixed size buffers of 4K. When PAGE_SIZE > 4K, we
fragment the page across multiple descriptors (FBNIC_BD_FRAG_COUNT).
When refilling the BDQ, the correct number of entries are populated,
but tail was only incremented by one. So on a system with 64K pages,
HW would get one descriptor refilled for every 16 we populate.

Additionally, we program the ring size in the HW when enabling the BDQ.
This was not accounting for page fragments, so on systems with 64K pages,
the HW used 1/16th of the ring.

Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 9fb91d4f3971..9cd85a0d0c3a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -927,7 +927,7 @@ static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 		/* Force DMA writes to flush before writing to tail */
 		dma_wmb();
 
-		writel(i, bdq->doorbell);
+		writel(i * FBNIC_BD_FRAG_COUNT, bdq->doorbell);
 	}
 }
 
@@ -2564,7 +2564,7 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 	hpq->tail = 0;
 	hpq->head = 0;
 
-	log_size = fls(hpq->size_mask);
+	log_size = fls(hpq->size_mask) + ilog2(FBNIC_BD_FRAG_COUNT);
 
 	/* Store descriptor ring address and size */
 	fbnic_ring_wr32(hpq, FBNIC_QUEUE_BDQ_HPQ_BAL, lower_32_bits(hpq->dma));
@@ -2576,7 +2576,7 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 	if (!ppq->size_mask)
 		goto write_ctl;
 
-	log_size = fls(ppq->size_mask);
+	log_size = fls(ppq->size_mask) + ilog2(FBNIC_BD_FRAG_COUNT);
 
 	/* Add enabling of PPQ to BDQ control */
 	bdq_ctl |= FBNIC_QUEUE_BDQ_CTL_PPQ_ENABLE;
-- 
2.52.0


