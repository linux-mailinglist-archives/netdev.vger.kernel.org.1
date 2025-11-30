Return-Path: <netdev+bounces-242834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10304C95443
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4804C342096
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 19:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E32C15AB;
	Sun, 30 Nov 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfg32BGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081E229B12
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764532323; cv=none; b=GJSOzMzrFhUWI7N96w+3Fu4tmS354wa+aSkMXItG46ztbz/Eop3x6fKUIMsoM9Euew1xhdvAN9gpLikjpZGpaNabeZw1KgEZh78ZJzwp00xLP5OvlAZmTSZeFjM1hojtertbsWo5lufxicsXdKlSVK8F5RcgBOcRPVltZSjjpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764532323; c=relaxed/simple;
	bh=KWBzc2p2M9xed8ruLMYJXFllVygEW9BBNPyn4AcpHr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrWhPx+OYM1uJBGVx6v07+jlqsYoRVyK/xSFPBJulERZSX2IPASGT4+HnfGb1+XYG3/mZWKLc2Vk/VAOKKQ7m+InqgXhhSMN4cz1/iHCi5vysvrju54QIBGvW0rzCRgCRXPJznz3wW6EN5jicHspdhLHSKa3LlSQAG38cgy72f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfg32BGk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so34014015e9.3
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 11:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764532318; x=1765137118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DEo1+0Da+YijlU/Zfn1c1EqlK38ud5yDKP0+nxdYn8=;
        b=Jfg32BGkgJ3QMmZqakk/Wk8k5stJxzOBT+yONlGIbIv6Ni55sTg3XTLuask0oIVv2o
         aivIOOpj8J9842jYO+JggrtETRBctS/RFU3ufrIQp+jqj/qiFUQ+dJSRyVHNz1wIayOp
         Dd2g09/XjH/C7OvUpk+tfMMbpcah93B/3b46qBt0yjkZhNmI7IZaie4EdgOmu9YR4Js4
         YkWkaBzObrKLUau3L4xRfOpemHaM7VUSWS6YxP9cf2JGS6ro2uLmRi6Z3jlXnLNVgDCV
         IXPHXqX3gY6fMnzZ9xoLSE3oYJ+j4NQNrmqnDDX0NI2GQYIKdEvaZuvT+LIExHqL6cDo
         +4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764532318; x=1765137118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DEo1+0Da+YijlU/Zfn1c1EqlK38ud5yDKP0+nxdYn8=;
        b=wXKrvdMGwr6CFpJ70YJu39U+NeY23jD9fxFAFZFRCtLA926tDEt95hzCA6A34Vov8d
         1DbDDSRY3+ng8zae2Asq712jCPcmLi5RPnbhuf0bsrepV7iL/Qh8i+dOdRroOuMvTybV
         2mv3Z7qHOkVLKfpF1iXVMSKxsyemLkbtsvzLBaHR5JPfULuJ7ZBIHm2ksqmGUDdCJvPj
         +NrP+SjQdLLx6I5QZFgHQV3obqt6FGlTvaD1SQOBbvhLaf1UUjr6kScIILlhymhHkIco
         G9YwUN2wyBC5TgK4grvTOjy5C48zD8EZAkhkt7pX7KMiQb0AzdpnJVZdq+roEmFKm5aX
         LFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVbeccHMxS6YdDHYUQyqTPhn55by+K/sREI5GZEFqyWs8AcVy+UtIZQevVmleYDILTzWtKuViY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzrrcHfXW57uRnqVpFetqFC/rP+KrNhTeDPSx4gtjd0L58dWl
	Tc8occcTshZKPgRA3bfXtFo9XESIasg1uXyNMZJa/fhDj+wJLvm6v4VFMZRZeQY=
X-Gm-Gg: ASbGncs7vhzYQ/tNR6DunP+SqOD2oDkZNIwJDU7QUm7If8JGQ2nN7CbNA6XfYdEB/gy
	++9MSdV+ZBp4neiH8W8CqNfGj/XoCzRQoOjB5rwKD6EHDEj0NxMSRVgRmgHdwsXDC6O0C1avBBd
	9J9/k/VTrQnP9wgiTWsWWeEgNFGA5W33EthliEdUvl0NsznqwS0wnDR3++4VGBQ98i6vajUPnRa
	OmUkod5tGLACb/xLkTP/vsrPDssE8wWP0m4lfb+wwyHuOhZqeCes7x/YVAIuQomCvzwohq+FbZW
	tEJB7zybzyxbWv+BO4tu5uroMRTGg8BefxQ/TuJxRbKAyzBWRbQe4RSRVjDLGOVScc14Bm4RaUs
	LhLjRoB1ZbQhOOEEvPuMkJLEKOBZi5DUBLQqkGlB+T3Ldj+V9Xk7AuKfSEbome4cN9bSD1yZEBs
	gO5ITy5tPMvb9hER/t2xsRQROdL+2H7xUfKt139Wk+hppYdAKWFksMMVTd/HveVj3H4geu
X-Google-Smtp-Source: AGHT+IHpMEnKorixDu8qIt6p2z3sKWM6DYKhdWytPD6KeENQCqF5f7FvWF1BtO+epXxKsRq5U6IKMw==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-477c1142268mr303410735e9.20.1764532317801;
        Sun, 30 Nov 2025 11:51:57 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:c379:32d5:1107:4f59])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4790b0cc1d6sm258597365e9.12.2025.11.30.11.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 11:51:57 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Geoff Levand <geoff@infradead.org>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	fuchsfl@gmail.com
Subject: [PATCH net-next] net: ps3_gelic_net: Use napi_alloc_skb() and napi_gro_receive()
Date: Sun, 30 Nov 2025 20:41:55 +0100
Message-ID: <20251130194155.1950980-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the napi functions napi_alloc_skb() and napi_gro_receive() instead
of netdev_alloc_skb() and netif_receive_skb() for more efficient packet
receiving. The switch to napi aware functions increases the RX
throughput, reduces the occurrence of retransmissions and improves the
resilience against SKB allocation failures.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Note: This change has been tested on real hardware Sony PS3 (CECHL04 PAL),
the patch was tested for many hours, with continuous system load, high
network transfer load and injected failslab errors.

In my tests, the RX throughput increased up to 100% and reduced the
occurrence of retransmissions drastically, with GRO enabled:

iperf3 before and after the commit, where PS3 (with this driver) is on
the receiving side:
Before: [  5]   0.00-10.00  sec   551 MBytes   462 Mbits/sec receiver
After:  [  5]   0.00-10.00  sec  1.09 GBytes   939 Mbits/sec receiver

stats from the sending client to the PS3:
Before: [  5]   0.00-10.00  sec   552 MBytes   463 Mbits/sec  3151 sender
After:  [  5]   0.00-10.00  sec  1.09 GBytes   940 Mbits/sec   37  sender

 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 591866fc9055..d35d1f3c10a1 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -364,6 +364,7 @@ static int gelic_card_init_chain(struct gelic_card *card,
  * gelic_descr_prepare_rx - reinitializes a rx descriptor
  * @card: card structure
  * @descr: descriptor to re-init
+ * @napi_mode: is it running in napi poll
  *
  * return 0 on success, <0 on failure
  *
@@ -374,7 +375,8 @@ static int gelic_card_init_chain(struct gelic_card *card,
  * must be a multiple of GELIC_NET_RXBUF_ALIGN.
  */
 static int gelic_descr_prepare_rx(struct gelic_card *card,
-				  struct gelic_descr *descr)
+				  struct gelic_descr *descr,
+				  bool napi_mode)
 {
 	static const unsigned int rx_skb_size =
 		ALIGN(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN) +
@@ -392,7 +394,10 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	descr->hw_regs.payload.dev_addr = 0;
 	descr->hw_regs.payload.size = 0;
 
-	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
+	if (napi_mode)
+		descr->skb = napi_alloc_skb(&card->napi, rx_skb_size);
+	else
+		descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
 	if (!descr->skb) {
 		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
 		return -ENOMEM;
@@ -464,7 +469,7 @@ static int gelic_card_fill_rx_chain(struct gelic_card *card)
 
 	do {
 		if (!descr->skb) {
-			ret = gelic_descr_prepare_rx(card, descr);
+			ret = gelic_descr_prepare_rx(card, descr, false);
 			if (ret)
 				goto rewind;
 		}
@@ -964,7 +969,7 @@ static void gelic_net_pass_skb_up(struct gelic_descr *descr,
 	netdev->stats.rx_bytes += skb->len;
 
 	/* pass skb up to stack */
-	netif_receive_skb(skb);
+	napi_gro_receive(&card->napi, skb);
 }
 
 /**
@@ -1069,7 +1074,7 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	/*
 	 * this call can fail, propagate the error
 	 */
-	prepare_rx_ret = gelic_descr_prepare_rx(card, descr);
+	prepare_rx_ret = gelic_descr_prepare_rx(card, descr, true);
 	if (prepare_rx_ret)
 		return prepare_rx_ret;
 

base-commit: ff736a286116d462a4067ba258fa351bc0b4ed80
-- 
2.43.0


