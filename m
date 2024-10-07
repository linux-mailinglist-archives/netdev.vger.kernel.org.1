Return-Path: <netdev+bounces-132625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BF99281C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56351F21338
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16718CC0A;
	Mon,  7 Oct 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epeehRGn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DB18E059;
	Mon,  7 Oct 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293400; cv=none; b=HHF9NZoWAzNqymL1jIsgs74DIW1PhLwv3Pqjrh7iMkabtLhKJx7AXog9tzD6iUv5wWDEt4eAJDrwI3BbY6w6QLvYJ3D/MCqqnZcr9kERdMspjdaVcZQBZcSxTPOB28DxS03xkwwoJJYuQ2o7G5fzRvkEsZBlmiF3HOHBDIEtz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293400; c=relaxed/simple;
	bh=nOeB1Aeg56VFoCSsiPRR/EL6phxYSnYq1PT9srA6NcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgwLMK0xl8YZ6JZ4qasZYHfl3tOLQXKL8/HTIutd3fRPF8s4PQigPmqtqJMrRQjCIPCNxA+p5o3mo1oEUp+HBhIOCmCaB7QopuMHkXxYaNMGHMPyip0+du0xi/dZgPe/4WPiysFC2jGmorDmUY17TAPGj+rEoWDSWMdP/ojnRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epeehRGn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398e53ca28so4507231e87.3;
        Mon, 07 Oct 2024 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728293397; x=1728898197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=few0TOoiwaFHUOUB5YtAJUND9ZPE9FFc7kCFffYQGco=;
        b=epeehRGn5d3FxK8UvgyEHEGNmxBBnGkGDI8Jjik2fiUTNGLf2XR47XUkiDveby4oSb
         ICwFODz+cr9uVXF3Znb+nDzKcWbv9FehMObXzv/e7SIBCqEFKwUGO5mc8wbtNYZMAbDS
         THJ6ChOOMxir+wHEt8WyckHQrSG5ImrOrcRdiQG3gFrUOz1+v6MZSlC7hkEGZV+aGua5
         XsV4yj0f7QToV38HRvteRlr30ihyRlFRvbf//DQbcmtFQ/yeYNiWMGYsNrAZSCztMPIp
         PC+tGU7IHrZc6++W6p6P7Tb9whQ5V0pvGPwVbCt1cq6SfZ90+bl8cZB9hjnO2AD1Z5qh
         /x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728293397; x=1728898197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=few0TOoiwaFHUOUB5YtAJUND9ZPE9FFc7kCFffYQGco=;
        b=sPgaE2PIgOu+syc0vOVHqypzZxcEAVA3bGKx2izqnPDvorHpWp+Qpag1QhDbDPi9yp
         ul1UzbRph8lLf4xOOiNqI1jQSsve/Ppvat6zUsYM4x9y0V/PWwQAhWJjm4jSUhtT8v4c
         SmkwTI+OmnwV++YFpKNPEV+rG0AFX0/yWR7Q5FydlqQzHSrB21pLPYlJq6YtJk+anm+b
         WC423SebQrldjbhBEZTZCB+P7pjkCTaqp2Ogep1ni8VKBOYHVR3F0HWexTrertdeEVZ0
         PYnncGHW6Piuw3kcsNvQzDyVTwaMbKPEAVDF73cbfsCD9MOo/ebRRwxREUz1lcfwjEw/
         POxg==
X-Forwarded-Encrypted: i=1; AJvYcCU7foAx65OzsebDysPTD0ipVWbp0uM+fK/fvkrHLJ8YizGhEtYMoQYZ//nNHiK0ek1/OH9PhuiW@vger.kernel.org, AJvYcCW8JHag1dfd7xQdJHZacQFZNX0Kh0pe4/Ib4wARlvi0wyFeOqY+pvdH94DZqGn+3ETe8OqcN0nei/M/8HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtYiwXVu/RrDH/Vu5jDowvoEV2yAGODLivzBXtjYA2SG4wwAo
	jDenYTuJv6SUUtslsF6fDVf7GtXKg5gym9yKe+yWfnoXCM5xx3EfxrBYTYIzHANuFw==
X-Google-Smtp-Source: AGHT+IEV/aHdwMgOvLWNqvXxDq30jV/EhR1GwepiFNVpZQLui26iQfYE1jfXL60S8sQ0pdMSsPnJHw==
X-Received: by 2002:a05:6512:398d:b0:539:8d9b:b61e with SMTP id 2adb3069b0e04-539ab9de2f1mr5674108e87.44.1728293396666;
        Mon, 07 Oct 2024 02:29:56 -0700 (PDT)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2835csm763444e87.275.2024.10.07.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:29:56 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: Chris Snook <chris.snook@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] drivers:atlx: Prevent integer overflow in statistics aggregation
Date: Mon,  7 Oct 2024 12:29:36 +0300
Message-Id: <20241007092936.53445-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `atl1_inc_smb` function aggregates various RX and TX error counters
from the `stats_msg_block` structure. Currently, the arithmetic operations
are performed using `u32` types, which can lead to integer overflow when
summing large values. This overflow occurs before the result is cast to
a `u64`, potentially resulting in inaccurate network statistics.

To mitigate this risk, each operand in the summation is explicitly cast to
`u64` before performing the addition. This ensures that the arithmetic is
executed in 64-bit space, preventing overflow and maintaining accurate
statistics regardless of the system architecture.

Additionally, the aggregation of collision counters is also subject to
integer overflow. The operands in the summation for `collisions` are now
cast to `u64` to prevent overflow in this aggregation as well.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 30 ++++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index a9014d7932db..d61f46799713 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1656,17 +1656,17 @@ static void atl1_inc_smb(struct atl1_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	struct stats_msg_block *smb = adapter->smb.smb;
 
-	u64 new_rx_errors = smb->rx_frag +
-			    smb->rx_fcs_err +
-			    smb->rx_len_err +
-			    smb->rx_sz_ov +
-			    smb->rx_rxf_ov +
-			    smb->rx_rrd_ov +
-			    smb->rx_align_err;
-	u64 new_tx_errors = smb->tx_late_col +
-			    smb->tx_abort_col +
-			    smb->tx_underrun +
-			    smb->tx_trunc;
+	u64 new_rx_errors = (u64)smb->rx_frag +
+			    (u64)smb->rx_fcs_err +
+			    (u64)smb->rx_len_err +
+			    (u64)smb->rx_sz_ov +
+			    (u64)smb->rx_rxf_ov +
+			    (u64)smb->rx_rrd_ov +
+			    (u64)smb->rx_align_err;
+	u64 new_tx_errors = (u64)smb->tx_late_col +
+			    (u64)smb->tx_abort_col +
+			    (u64)smb->tx_underrun +
+			    (u64)smb->tx_trunc;
 
 	/* Fill out the OS statistics structure */
 	adapter->soft_stats.rx_packets += smb->rx_ok + new_rx_errors;
@@ -1674,10 +1674,10 @@ static void atl1_inc_smb(struct atl1_adapter *adapter)
 	adapter->soft_stats.rx_bytes += smb->rx_byte_cnt;
 	adapter->soft_stats.tx_bytes += smb->tx_byte_cnt;
 	adapter->soft_stats.multicast += smb->rx_mcast;
-	adapter->soft_stats.collisions += smb->tx_1_col +
-					  smb->tx_2_col +
-					  smb->tx_late_col +
-					  smb->tx_abort_col;
+	adapter->soft_stats.collisions += (u64)smb->tx_1_col +
+					  (u64)smb->tx_2_col +
+					  (u64)smb->tx_late_col +
+					  (u64)smb->tx_abort_col;
 
 	/* Rx Errors */
 	adapter->soft_stats.rx_errors += new_rx_errors;
-- 
2.34.1


