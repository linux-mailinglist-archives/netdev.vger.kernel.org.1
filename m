Return-Path: <netdev+bounces-222858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C1B56B3B
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6523B5B92
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CDA2DE704;
	Sun, 14 Sep 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQrVfDyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F370278157
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874675; cv=none; b=OgnGaC9KCzdyKm9MacP1CEOHk9tJANAiPkFVW6CzZHr+62erQ6jDu6ZKBN4lKyFAP/3hSZnSk/Ew9sBMayF490m0sV6s1OK5oNxA9sPLVz2Otkc7s7eYsZAkx7D9TvuDS0VQZ4pkRf072z9L+1wqJYhNie/S1rH5XY5FavaY9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874675; c=relaxed/simple;
	bh=hlVIDWDHCPjEuC1vuLoMmRL4KsevmOFTtv3gSNI6JAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTgzOBDVEqXYJeHhUXMwlzTG+S6qTJBd0DJK7WJFzF7YU6A5EZMmS55ZQpcbwLGvTeiPgRkMwRZfPWS5UCcYDW5gr5BY5fAOVZvOfeij863jlaKzfHiOR0oyb5H+mTBDd5NNd6LbSuAhkm8CSayRfsLrTQm6t0OsqOCZvJ7vIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQrVfDyT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2739966b3a.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874672; x=1758479472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJoarhscg/bd5gj/01c/KD7zFwsiQugi81p4DTjaNh4=;
        b=NQrVfDyT+MuFGaThCgySw5HPXmvqxwEyIJFu8lqhLo5U6Xa439JkfKKVTmLz9GBhfo
         Dt2RyU1/BD0f8btdLq+ChtQmp31HwruQdXiJdTR1GA0FWx1c+Lwx5RPIwgIL8OHhY9Q8
         mEgTMDjem6XpuYIwS+Moqd4MpJOfyvxvqpSGkliTpuzgYiIuDr3ORpg4JfL9uk1qURo9
         0pdOxUUpAI7j/BddTmjILAnpX9+S6kUGwUwcNjsBM7uQp3dQZW23l7NGBfIeGcZ7bpS1
         ENHAOl2qtmngduOg39bkD0zLRynaPupvPy/NvbEAIOji1Yn3GGySPRv43bCXM7w1BHoJ
         qWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874672; x=1758479472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJoarhscg/bd5gj/01c/KD7zFwsiQugi81p4DTjaNh4=;
        b=SkVgkiIHzQ3xdP6crpv10kccyUSpnPHX1l4DA+VbhCKHYk/rerUmvr55efQWt3ZXWS
         1OJKqF2nwYMgKhtR8R+QE6WTVjHtCWw7CS6Rj1Ook4f8xISQrgvExYh5kcxe+T7j2nxk
         awei4KrpfUCm+2d93SoM+z5ao94OenqXVxUJKgnbS4HS3ZUl18caKQbdE7z4q7FT8o8+
         HgpPLTNhb0NzoG9n+oK8dvk0XeIdCM2o0odmcL7EBddwh/Xx9SpmFqLAohC8FpC8s5Tx
         arTVt5cNVtAZCGfg/SGJ6pUAx7bGBZUVAZ8v7OVY31+ipPrn1r2Ts5GbOfR7zswYmBbF
         UKVg==
X-Gm-Message-State: AOJu0YyU/DsRCkHUEScBmSlNG6H+o1yBMY57ZNOIJ2Ue3maoUAhdABBa
	PSw/ffOh0S+siWxH32kCrU9x/1P4y1hhE/9a1LCq8M4BxOe/KrA8Ax8F
X-Gm-Gg: ASbGnct56ZdJzHYUTGoH5lKCCw3FIKFfpAUBBPMgj2SlyqG99b2Kg9VaehPsoRTCWbs
	3zMBZ83tfny/eE6j9XqYGZoZGixOpvd7nMYdg4owOu2u3gEUP/wak++xoHQ3wr6uALsrfAh0EgE
	/SIZRiM6L7R8LIT2gVmWhh9mJ/3PdVmzmxo2qeZQrvAssTEAnB666ty8iw4HZe3iNKCFkxeGy5A
	jlZPG5Um6NvKkRVR0vdbi42MWxQDpZDco6//bppEU+NDQBNHVNS0W4NbVUn5aMkNEl7LKndGhgR
	1CoebtFGkbClxV3pSee2qFZQyqj9oMbdQjZg2YjOTKpyYld6tvMdYxLkQPxvYz8Q7FOfTUP94u9
	1uJZqKe+0bMMdcoEEQGWH+tSRxWM69ftZsotgoHJehfddTeTlODssZftT
X-Google-Smtp-Source: AGHT+IEUFU4BYFN9o4D9Viii5u2+CmO2YQayD59XKN8HcFLpmj2+2aDTFKDY0y/rzl+8+RCxZQYAkA==
X-Received: by 2002:a17:903:11c3:b0:23f:f96d:7579 with SMTP id d9443c01a7336-25d260795c7mr102687595ad.37.1757874672454;
        Sun, 14 Sep 2025 11:31:12 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm71760225ad.127.2025.09.14.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 11:31:12 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2 1/2] net: dlink: fix whitespace around function call
Date: Mon, 15 Sep 2025 03:26:53 +0900
Message-ID: <20250914182653.3152-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250914182653.3152-2-yyyynoom@gmail.com>
References: <20250914182653.3152-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary whitespace between function names and the opening
parenthesis to follow kernel coding style.

No functional change intended.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..faf8a9fc7ed1 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -970,17 +970,17 @@ receive_packet (struct net_device *dev)
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
-				skb_put (skb = np->rx_skbuff[entry], pkt_len);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
 							DMA_FROM_DEVICE);
-				skb_copy_to_linear_data (skb,
+				skb_copy_to_linear_data(skb,
 						  np->rx_skbuff[entry]->data,
 						  pkt_len);
-				skb_put (skb, pkt_len);
+				skb_put(skb, pkt_len);
 				dma_sync_single_for_device(&np->pdev->dev,
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
-- 
2.51.0


