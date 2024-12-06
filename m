Return-Path: <netdev+bounces-149803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F79E78B2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F7B16A1E9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650F201023;
	Fri,  6 Dec 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="yeBXnInn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFA1F37CA
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512609; cv=none; b=qmELlo4dcD6FjlGPDhfwkW0z4nHMCenvebslevlfH900Vgjft/KSKk6pia8NBs94WQRylDEIFAoA9CuhmIgOq+7M7fEfMHm+R7Kt/aWpvZ7VMEhlT13O5yhx4AJRQcvJ4+dnwvvXN28mySsXkzBqCTUEXfjbHasAnTMGoobgreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512609; c=relaxed/simple;
	bh=wXdUfPDZdTp7uaCmZH8pm7BfzwNL7Ba4+AgLadvA+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW+XwlHPkjw7cuc7GrTVfQp/2x6R5Nk3hIO+aKZKE+PRAvlpILVz8Nym64MOJaXdgOqNbdUYaRR2uDw5BGpz3dKR3LALUG5dom6KNDnKutJqgjpyq0A6z0yXu8WibtMqUkobLE16eiUuw2DOUdMwrKLbR54l2KZNe8Tz3j7BjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=yeBXnInn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e22458fb5so2263075e87.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512606; x=1734117406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=yeBXnInnAHebowSy/6LEyx7rq+2F8MuBDzcc1z9TOClxRX2vm2dhFsm74sRLYze3JY
         CCvlYdZhyyMpNd3qVz0f4wGnSBuOlg3OiDuSvlfXlKlv3FNFk7A8+5k6CoQwAKLCxLwS
         BQYgOFOwDp1DISzdf/XpE9OlW8cD6iJsZQtoNj2gPRSeM+iwJJWpbXPb4c40hDK6zI2B
         thmWBcqLu1ipi0WzMlCWIwReByfskL43prk4aPAjIAjDQlhvM3D71VB7X+qTHUOVO58f
         7Xx+SuJlBTv0R9WOmVdIDUTePB7qnTm+R6JuVT+fgTsz438ps68HJZKLOkKPF07eLVK9
         k4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512606; x=1734117406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=givsxBIvL7nAq6nhW6HZd5TX6cEB8XnafiT1cYc5nGB4jsb8RxY60Z+4PbMkXxK36K
         I9yB1pURtiHywo6+CwOltrtlnl7sURII+266ShvMCKih/A6WubEv6cgFhMtIyYrspQw5
         CerJkpfGqTNnNWqMrCnFIaqJLxp3bhHeY2biDmwOyk/13nMgA85AyqNM8W0GboD1snVS
         x3YaQP4/4FFUs2fEAsdL21/3zMLh81RS6v0Ez8qCrlPtePyZ6K/VX3weTybNVOmDoYt7
         aV3NFMEyph3yCNuG6+5cCxSJKhno8Uy+BU3BvYRhYtH/FRtLi/0hIc9lbczb6WJ/GHMA
         rvuw==
X-Gm-Message-State: AOJu0YzVAE24p1zkQhoUwBddeHS+j1/PVF5M9qhKmgW09j5c0Jvqj7Qp
	630Uo1Y5L14QgXe5+lkVosQms8wwu3vpBwOZpzK8rUNQnvODLzVuOo5EhjxJ7mg=
X-Gm-Gg: ASbGncvxzcP8LSV6aNNhkZ6fMXCk0cC/KUZ2RRKJru8OY7RMVG4glJSm0Dgi8MBB8DT
	DbcyhJknAGEVT59inWymxyI+II9a2z3wsB3XP727V3mFQlfskZk3mRGzMLmOtcRJg723N2R3h17
	bBF44vWAc/QAYYzZJELmj5ltG7ZKAiOjweMajmDsURMJX8vWtEBuPALdoxehbuidOw7lFhVwLjM
	O0DPpaPFX/Gxo7KJi+HulvKJJTUtfaUN+5xDBJd68wWK0eAJU6X5pXTS2G/i33P
X-Google-Smtp-Source: AGHT+IHuzHk6NLkXAtdHOqa5qip3aYMDDKdLV1Lp1l1D6ZrIJKd5dbtyB1JS3gM+1Efv+f3BgNnv7A==
X-Received: by 2002:a19:6450:0:b0:53e:3729:eae8 with SMTP id 2adb3069b0e04-53e3729ed4amr728856e87.19.1733512605591;
        Fri, 06 Dec 2024 11:16:45 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229bae3bsm575973e87.127.2024.12.06.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:16:45 -0800 (PST)
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
Subject: [PATCH net v2 2/4] net: renesas: rswitch: fix race window between tx start and complete
Date: Sat,  7 Dec 2024 00:16:40 +0500
Message-Id: <20241206191640.1416-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hardware is already transmitting, it can start handling the
descriptor being written to immediately after it observes updated DT
field, before the queue is kicked by a write to GWTRC.

If the start_xmit() execution is preempted at unfortunate moment, this
transmission can complete, and interrupt handled, before gq->cur gets
updated. With the current implementation of completion, this will cause
the last entry not completed.

Fix that by changing completion loop to check DT values directly, instead
of depending on gq->cur.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 32b32aa7e01f..c251becef6f8 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -862,13 +862,10 @@ static void rswitch_tx_free(struct net_device *ndev)
 	struct rswitch_ext_desc *desc;
 	struct sk_buff *skb;
 
-	for (; rswitch_get_num_cur_queues(gq) > 0;
-	     gq->dirty = rswitch_next_queue_index(gq, false, 1)) {
-		desc = &gq->tx_ring[gq->dirty];
-		if ((desc->desc.die_dt & DT_MASK) != DT_FEMPTY)
-			break;
-
+	desc = &gq->tx_ring[gq->dirty];
+	while ((desc->desc.die_dt & DT_MASK) == DT_FEMPTY) {
 		dma_rmb();
+
 		skb = gq->skbs[gq->dirty];
 		if (skb) {
 			rdev->ndev->stats.tx_packets++;
@@ -879,7 +876,10 @@ static void rswitch_tx_free(struct net_device *ndev)
 			dev_kfree_skb_any(gq->skbs[gq->dirty]);
 			gq->skbs[gq->dirty] = NULL;
 		}
+
 		desc->desc.die_dt = DT_EEMPTY;
+		gq->dirty = rswitch_next_queue_index(gq, false, 1);
+		desc = &gq->tx_ring[gq->dirty];
 	}
 }
 
@@ -1685,6 +1685,8 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = skb;
 	gq->unmap_addrs[(gq->cur + nr_desc - 1) % gq->ring_size] = dma_addr_orig;
 
+	dma_wmb();
+
 	/* DT_FSTART should be set at last. So, this is reverse order. */
 	for (i = nr_desc; i-- > 0; ) {
 		desc = &gq->tx_ring[rswitch_next_queue_index(gq, true, i)];
@@ -1695,8 +1697,6 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 			goto err_unmap;
 	}
 
-	wmb();	/* gq->cur must be incremented after die_dt was set */
-
 	gq->cur = rswitch_next_queue_index(gq, true, nr_desc);
 	rswitch_modify(rdev->addr, GWTRC(gq->index), 0, BIT(gq->index % 32));
 
-- 
2.39.5


