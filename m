Return-Path: <netdev+bounces-190755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356CEAB89F1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45631BC549B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159DE204C1A;
	Thu, 15 May 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZsoUZcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341021FFC50;
	Thu, 15 May 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320742; cv=none; b=utFixT2aPQ2GytGijHDuPxtbj4dqh/Vix03ixHlFPEn+N4KU1poaopUw3KeczJYf7f8Oxn+LjxcGIP8Ncaa+zuXs9l2EOrfumMbCNxBxngNlQOpBPmKj5vtrY9x3nk/Zg+YNaSOa8S0mMjZRFxOmPj8fz0ShCJyT3T8JiYQV7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320742; c=relaxed/simple;
	bh=7ffEw+ptMS7peJNS6GPFMcGsjW2HNANDVfhEBIaS0HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sra87tULCpxICIfj6ksu3uqx6GZhPRgTYEhXVfLwhx5nTLYAi6xBAfhXopuknid2Kra2q003W45CeaAdNhCAszTMMDsErVQeou4QlHNF/PcRZyJ3Y/ADkzF3S9mglx6tNbhtgTlkZ8umvym2/YI/5TAiV1Ufygyq/F3bnrmpI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZsoUZcd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad2490d7838so199968666b.0;
        Thu, 15 May 2025 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320737; x=1747925537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvffsbynJDZv+lCO17Qh9aP9Vq1i5+xxef3WNN/Cri8=;
        b=SZsoUZcdL1WWzmWtoqFsKw74Vuc/RdgHWxS0ImLzGGj/Ls5sCF7fd3V6ajxy7hbzcX
         wK1XbvcTHVmNX3UOFkx1lXezoIebQxfVkBMT7EQZ/EfvXZ/EO01wtgcBB7zwq77tOw9B
         Snvmt9jNtVfqrfVLvALIeYNZP62oqzNdd6HKUHcu54Dln+m94F10ctBpJbfZqF0xqm90
         EuWqXSYW9/mvOiFzBbXq3C5HirWL04ozfO8gtiw2Kgh6/iACQSBQ0oOfNwX/qd39xF8u
         fonN6Fa3JhZgoHC/js55IfHptixkYHHtgGbl21ookHKaKgNIO4bLNbX5QshSYpSA5aOC
         PrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320737; x=1747925537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvffsbynJDZv+lCO17Qh9aP9Vq1i5+xxef3WNN/Cri8=;
        b=Sg0M2gNCDZPjvYIVWO1pqzQb+BChUsdfuVz9TgJg7TG65FWwhUD7MdskV0NaVyLwoo
         JzA0csOn1yBBT+C2jEHA1GTQUYZilkJ3fc2twosVJuf/qIJn13VaVL9TwYR13xlpXwoS
         HxMN/Ay+Hl8184mE/QnpAMzn0bzf8mj31ZhRpDkxdaoHd6l0sj0Gbesep2qFCBCY6KHj
         yS6CZSudOdjAhoepf8l8vAT7j0dRTWLBmRMdkiiYOKnrh7jXvRierMM0faZ+x1BqawJN
         8kTyiR/o7BfsGcB/ofrqD2ISDjS59AUZ6deAW+L8LqivJLuzGYKB4yjWN2BJh8bpDAlm
         kzkA==
X-Forwarded-Encrypted: i=1; AJvYcCVRCI/DHRpDRug+oOnzvXqg45XKFEWu0OSgAPiQkXdqG5pCveualJDAuWEs15Vn20gikmjGhhdXWmNYBg4=@vger.kernel.org, AJvYcCXhbWNcAReQ3tLTqD94I9XYm6LDVY068ktCe8fUnO394Yi26Jvnml3I8T9Zy+nR8jpu4+hgW210@vger.kernel.org
X-Gm-Message-State: AOJu0YykhHaEk0QI3mM3sXFYE75YcM7wlRGiRXcBbc4m6CIxjYdFrCbk
	F6ZpSJVJdc5+L+2p9hn2BvOF1rsydd7QtubK/VoUAXB0AxZXLz7G
X-Gm-Gg: ASbGncvJc1oLDdKzQNE9CoYTWNtUAGUiL1o4Rs5Ufu5ZtdlO+N2FOD7c3+yU5rvbwKm
	L5/461WreIkw5Qw9ujHZMhY2GbFb/ZF1S58GERqKXi5mX9I+PztARVEZox+z+iySHh8xu7UXvzu
	E4z6ZZTD2p5C5dzS+Laa536ClBw4R99IO0H8XNYGFFONYecXpGUZXr6qkfdSKDycAqWQPbKNsDP
	0QeNqCWgSnON+CUz1agw/oYTRjG59EpHbZZZm+PuBq0X8XfZdrRXJTAHnj6FIjgRu175hc0PbCQ
	6CQ0FjjegnMeTkp6t1V26giAEic09zPZ7BwUTbyf1GsR1QYH+Lc6YCKWPJn0lA==
X-Google-Smtp-Source: AGHT+IEV9m289XRZjq5k94PrSxEo72xgluP61Apz2/IW6lpcrKev99kJm3l/NxC95pkz0+OmvTIbJA==
X-Received: by 2002:a17:907:5c1:b0:ad5:2d05:ba12 with SMTP id a640c23a62f3a-ad52d05ecafmr3050666b.46.1747320737071;
        Thu, 15 May 2025 07:52:17 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d275d9fsm871366b.74.2025.05.15.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:52:16 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v2 2/3] net: bcmgenet: count hw discarded packets in missed stat
Date: Thu, 15 May 2025 15:51:41 +0100
Message-Id: <20250515145142.1415-3-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250515145142.1415-1-zakkemble@gmail.com>
References: <20250515145142.1415-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware discarded packets are now counted in their own missed stat
instead of being lumped in with general errors.

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 64133a98a..d0c6b5d4c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2297,7 +2297,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		   DMA_P_INDEX_DISCARD_CNT_MASK;
 	if (discards > ring->old_discards) {
 		discards = discards - ring->old_discards;
-		BCMGENET_STATS64_ADD(stats, errors, discards);
+		BCMGENET_STATS64_ADD(stats, missed, discards);
 		ring->old_discards += discards;
 
 		/* Clear HW register when we reach 75% of maximum 0xFFFF */
@@ -3571,7 +3571,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 	u64 tx_errors = 0, tx_dropped = 0;
 	u64 rx_bytes = 0, rx_packets = 0;
 	u64 rx_errors = 0, rx_dropped = 0;
-	u64 rx_length_errors = 0;
+	u64 rx_missed = 0, rx_length_errors = 0;
 	u64 rx_over_errors = 0, rx_crc_errors = 0;
 	u64 rx_frame_errors = 0, rx_fragmented_errors = 0;
 	u64 multicast = 0;
@@ -3605,6 +3605,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 			rx_packets = u64_stats_read(&rx_stats->packets);
 			rx_errors = u64_stats_read(&rx_stats->errors);
 			rx_dropped = u64_stats_read(&rx_stats->dropped);
+			rx_missed = u64_stats_read(&rx_stats->missed);
 			rx_length_errors = u64_stats_read(&rx_stats->length_errors);
 			rx_over_errors = u64_stats_read(&rx_stats->over_errors);
 			rx_crc_errors = u64_stats_read(&rx_stats->crc_errors);
@@ -3622,7 +3623,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 		stats->rx_packets += rx_packets;
 		stats->rx_errors += rx_errors;
 		stats->rx_dropped += rx_dropped;
-		stats->rx_missed_errors += rx_errors;
+		stats->rx_missed_errors += rx_missed;
 		stats->rx_length_errors += rx_length_errors;
 		stats->rx_over_errors += rx_over_errors;
 		stats->rx_crc_errors += rx_crc_errors;
-- 
2.39.5


