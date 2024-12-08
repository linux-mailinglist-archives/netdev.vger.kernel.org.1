Return-Path: <netdev+bounces-149967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795459E8471
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF2B18849FB
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7171459FD;
	Sun,  8 Dec 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="qJwWDtA8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DD13B780
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651415; cv=none; b=UUE1gDIFD4NJXAuxliPPmCE016hm5iMCEqG4kMch25ytKkSNBg/KJlEP/9maeM21GJzrOIvKwoptWjmhJza7inTmKkObrgd7IMXQzlsHmaEqyltQb0rpqd8CZais/jJIGXWQGEKO8z6bINIsuUQknofKoQ6sE4FHjTzEsmrzOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651415; c=relaxed/simple;
	bh=SI27lQ6ouPyc6VSvj6mijRBvLjbpSdfHHV2X5cxHAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmXVwE2ZEf6NIfcKN3BJ2g+obLp+jzebcKXVT4oSFTrcvJF/Pj0XvJ/q9moCb/nbmH5asdB+13ke0LQqoxJcerd/T/cT0c4P4GSbmSMCnnpg0WP6aCRp3FLHsRJF7BOMqpe1aqTpDmSpVSvKa2DfNG5SfDaFP5jM56A7j86T+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=qJwWDtA8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so36930131fa.3
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 01:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651412; x=1734256212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=qJwWDtA8HYNQUxBJnk5UQAwTob5KH7pl9B6Ae1iyRzoO/77/FJsXTu9ch/SrstK+wl
         YL1AEeug/zISOaQddiI2/m0qDpX+tiAo7chTJRhzLKKx0LYBIbTIexPJELJ5onZ6aOnk
         GTYW3mu4Dwnz73cDbodVXNHQaQYh5Zvw3gOZCnnsVmqeJw1D5yAj/g2p8sUPcX0C1l8c
         GgW8bQx2xYQqT/6ix2CLR8nAvNYrQw7TvihpnwEkdKRAefcK5Z4ohY5kbgXRSs5Mrs80
         bdN39B/e2cCwhUGOjb1I9w5ZuJVNMsttzqIe7Dh7qJkZDIRWOfLvNvj9gRPwGcmCaJOr
         XiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651412; x=1734256212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=u9wVOjn6GzTW2k91Nqi/ZuHh2h2KOAwtKLLbjqFCUFtpm9Ylp7CzJLsUFRKQuojw0l
         Ct/AZ2KZz9Cui0eASyY8UhgmV+mad80eyadvXj+VBQEoRl4PDvVU1gbon99akpnMhan/
         hx2sLWU/7QgV16Lu528QlufvddAafr1b3jxG4PSXyO3Abv2aMj843wc30OfxIxH0moTy
         7LcA3tIjn8idts6mUBdtIuInXxCbSloQ+a4oTDd2iCg4o/3NcKwojCIiCI0HsJyMN4m7
         iD7A8jjj+gg/afWgJrLP0QNutrIq/oZ6sUntz2xunl0GkHybUdVkuH9oCKU1x8pVcDjP
         WNOQ==
X-Gm-Message-State: AOJu0Yz5GzsF2zffJ07MEQuSzt13G6ArAaotgKTg7hhZOjgOJZoSf6TL
	KJVXc/j4ZSMVNiFZMWyblyuzLrjo0YsyMPev8AsO0ENtRtlMkVR55Z2rkVzZbgk=
X-Gm-Gg: ASbGncvqhgCYMV+kY26npDKDeGnxigbEHNY5j/xnQBjNGAZIS1KyyqFasKIpudAqvdv
	6ZxgQLgNmTJQ3NfLtPRi1eIzXLrqbNhA/mAdfh2qdBOCgZ0036cluv/iYsbpzoZFM6QncFVD08y
	bsAnsBhEA9VjfErxjJam43lp6/ykIGpwnxp41YJdQ97GhySXrBNHRvKCADKI80766q+HGKxp+EU
	qHLtwZbTVfyd3cOzlRQRgSPdk9tTiTwslTLm993x486ytLqrrLZfNNoEorDkKGR
X-Google-Smtp-Source: AGHT+IGmOlhACGEiwReXdOmA2tPXqwQWewjxb6Ay7meV1g237ucqsf808iRNKjO6hZpq9iuPGcdG5g==
X-Received: by 2002:a05:651c:1586:b0:300:3e66:5881 with SMTP id 38308e7fff4ca-3003e6658cfmr17033281fa.7.1733651411640;
        Sun, 08 Dec 2024 01:50:11 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:11 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 resend 1/4] net: renesas: rswitch: fix possible early skb release
Date: Sun,  8 Dec 2024 14:50:01 +0500
Message-Id: <20241208095004.69468-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
References: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending frame split into multiple descriptors, hardware processes
descriptors one by one, including writing back DT values. The first
descriptor could be already marked as completed when processing of
next descriptors for the same frame is still in progress.

Although only the last descriptor is configured to generate interrupt,
completion of the first descriptor could be noticed by the driver when
handling interrupt for the previous frame.

Currently, driver stores skb in the entry that corresponds to the first
descriptor. This results into skb could be unmapped and freed when
hardware did not complete the send yet. This opens a window for
corrupting the data being sent.

Fix this by saving skb in the entry that corresponds to the last
descriptor used to send the frame.

Fixes: d2c96b9d5f83 ("net: rswitch: Add jumbo frames handling for TX")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index b80aa27a7214..32b32aa7e01f 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1681,8 +1681,9 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	if (dma_mapping_error(ndev->dev.parent, dma_addr_orig))
 		goto err_kfree;
 
-	gq->skbs[gq->cur] = skb;
-	gq->unmap_addrs[gq->cur] = dma_addr_orig;
+	/* Stored the skb at the last descriptor to avoid skb free before hardware completes send */
+	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = skb;
+	gq->unmap_addrs[(gq->cur + nr_desc - 1) % gq->ring_size] = dma_addr_orig;
 
 	/* DT_FSTART should be set at last. So, this is reverse order. */
 	for (i = nr_desc; i-- > 0; ) {
-- 
2.39.5


