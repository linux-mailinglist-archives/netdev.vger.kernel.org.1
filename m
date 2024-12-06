Return-Path: <netdev+bounces-149797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE29E7876
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CFD16D865
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17F203D4C;
	Fri,  6 Dec 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="An9K38cC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395117B502
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511647; cv=none; b=rGVcXiKQtv0rHjH5Ij4RYnd4CGpDtAoXMJNhOv8C9L/m4PHNPI3suPKfYPwLpCzMH4fCJ4rLwhuVrwyU0gyZxoqVTRoYsh9THV2ck9H+LiYb3FgG3WMNqAI67FpnzRA7asjoHVMhzm1POjevOeQE7qdy4lqCDjzB/g4r0e0Dd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511647; c=relaxed/simple;
	bh=SI27lQ6ouPyc6VSvj6mijRBvLjbpSdfHHV2X5cxHAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6hzoH4bxGV5uQvLDTf2JK9g48knKwfp0nOorOPSTLhqxWQM+jvwTXHUuwO4gImJmFt4P07+k4zrgrdhiMVpTic21PwHPBOIyfN9ahRCvgtDk53ri21E9gB8ZHh7MvYInWM+4iyNi92vTGFz6YGLpEhooogVPOXvJtbInzRaDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=An9K38cC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so19815231fa.3
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511643; x=1734116443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=An9K38cCeebXwLpU8bCqmEJrBomOqrqLyAEbSNfU5B1LcVFGHGcoTePkagOr9EooU+
         ztKAPCweLgsy27AP1Rzz64gf2Iy8pl8uUv+1twRJ2O+gKY+a0jYaHQ++Fn/yBikwAtjM
         vFuwi5irPwKRVd9L+4pAP2HcCv1J5uwFjkwLEXQVvq5bs1T27WiWPfs6AXPLWDEutQLP
         SJwpsErk307MnFV/g+wN3GtDb4f3G5h/FUHjfj/Wlqx2v9DifPtQGBCbikm7iIJQX1gw
         fxGRuw1sAsPHw6Tqq4OiLETw+ewIj4h76o1dUXpdTVxZnUjBVCdCQN6A5Sx5z7LLnbAD
         d4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511643; x=1734116443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=N/zGzVmiJmF25ZcWKmfCtvNoTY8yZllTvc2DTSV4GREe0QicQCI3iXTkmeO9V1jJdR
         /kDMlroYxAQyjQY6gTQPyZZ7ksOrBgjokd+gI8PyZrIuJECIigi3QoBYLB1J0pv0P3mp
         Ntp/R9ZrxErhJNMAmsj2R1E+ju1cdxa5nwHv6vXJmHWmAQVviAOTdbXV/25Bfdjwsvyu
         PH8KRDSGoTLkrNkrI6VaF4xj1LzaoUJEgRnJm5XBlCihM5RGybbp3PA/BSQritCWIhZl
         v+FvNuk3CrElPGZXDv6HRioyfq4mK5mWG1J0si5RzINJJn3qXi/r8afOeOw3/RKWOOwk
         TSpg==
X-Gm-Message-State: AOJu0YwmfLJM73zn+OctVhml8dU3ztD3veEmiVdpmJWDnJL3xDP5XEbn
	xPzmSuTh9fzlOPtymduBn7IF7HrP5iIoOo7WRIJsS8LTEBkf0AmMKSyDekM1d/g=
X-Gm-Gg: ASbGncttB+UQSBBxNbuw8yjR8NKSy+G7OWl6O/JGBFqYnf09FVNfD3Mlq5etze0nCjr
	LRwwxLueI4TKkyZ4RaKI6By1jj0xR1SDqyHyOQ8WTTvOZrs5XA2bEBm0qunYmho+cDsG6dI7Fh/
	/I93wjjETb5qADvsDIMYFh1aHTjMBPiQAJmYMVmO7ZAi8qC328OTj6YCC7Y2Oc3/W5UgWJxaD60
	sVN5TjGIKzk6qM2WsGtsybxIOZtB9/9TEZ9Gfn51oewRtWpAoF5L+PZOellPa3a
X-Google-Smtp-Source: AGHT+IEW2UU+jTNoTOcEYuuCfhMKM2BI21VZcY54iVxmn2QTSlWVK53wH/yWJXy8oWjj5yDpAga4hA==
X-Received: by 2002:a2e:a98e:0:b0:2ff:8f5f:1adf with SMTP id 38308e7fff4ca-3002f795a90mr13121781fa.5.1733511643070;
        Fri, 06 Dec 2024 11:00:43 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:42 -0800 (PST)
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
Subject: [PATCH net v2 1/4] net: renesas: rswitch: fix possible early skb release
Date: Sat,  7 Dec 2024 00:00:12 +0500
Message-Id: <20241206190015.4194153-2-nikita.yoush@cogentembedded.com>
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


