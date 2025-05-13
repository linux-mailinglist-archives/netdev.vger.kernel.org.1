Return-Path: <netdev+bounces-190180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB0AB576A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B3417B851
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B042BE101;
	Tue, 13 May 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWKDkZ43"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737692BE100;
	Tue, 13 May 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147313; cv=none; b=ulQ76kodyCN0SJoVbQS76jvJ/r+HwgZRS+poTDYE85+4OuBYCJNGfS51d9rfV0DrZqg4cTjPk5Ggkf3Jf03X/zdszSLlXKwI/hR9NdyhiYbFDQ6MXh2mtPPQpVLCyHVYOexQeis1y5hly1D2Me/nIixUv+dvHSyFExjzpu/Ut6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147313; c=relaxed/simple;
	bh=Ta1VOb3JFrR4uLqIYluRSoPODEXu5Nl2ArRwe5+E3g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPeQB9LZ77KGeaeTkFTlo+OXPt3Dyfw1cC9rar1bn++MGcav+9phgbHJgIeD2qEPn9k18/dcAliErHKXQTLz6X5wj4YTu8Pp+OlkR1KbZ6+OsRGnauUiJwpUEprtjXeXJdE5slKtRetYvd4rLXqcXXrQeYxsAdqB+URQiUVYfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWKDkZ43; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fcf1dc8737so7201920a12.1;
        Tue, 13 May 2025 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147310; x=1747752110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsaGBIAwQmVTmuw2s6ILc5WhGz884w7UxCLCf4aI+Ho=;
        b=mWKDkZ43zHSYIWE5m3zHv/hx/fsqidi3190vUxUQKD+5EKQ+Jyi5WphRxQH6VUVvuS
         +fxu5d2sCM1RNjKAe9usI9zFMu1TzpfwboJW0mvc3fITqYhQ+Fd2dEYksj7Eh/asoXzV
         WAEl4wiXdKnBnmsq4qbNiEfop/YgCOOo/TtNr0bAV9xgLeWEe6VrOw6LEs+U/Dr4VaeD
         ku4TLezaT/CPGA4r8/nsUr/1vlgFDI36dKNxzyX8FPcrzrCFcMeQGBmxyfFKwTJUpp+6
         EIdKxM19QlFyjcD0rpN8NRo2jdYmox9/2zOfWLpoVONBKQNmdjXjA1h29UHETtKC9bAd
         K/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147310; x=1747752110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsaGBIAwQmVTmuw2s6ILc5WhGz884w7UxCLCf4aI+Ho=;
        b=pASvGcjW/qjA2YXC3aE+uQT4py9UVnJtlYy3aaypRFrMszhiSk1myZTGwd+v62hjK3
         0M6W5HejHzXJ69w/BurZx8I+ZZC+8PI0T25NNjADyXD6rbECVLk1mK8TB/EMBfrK/3yA
         gL3SYjPts41S44MZgYugx2xPUuCiIQwJP3Z1xWeDL84q5tjK0MDpBe/q6i56/YvjvYBW
         UxbnikQYoHPmB2Sscs1ya0UJJRmkYMWjUMAbYuC610KXJZXCfUu2knTZEIkCR+zbPr/T
         CnuXd8Rys4HrlXvSFAjf5ttu1cBGIEVIdQy6u3Irg/sUGUgzmstyBqbGKyUtfHRyExvS
         N5ew==
X-Forwarded-Encrypted: i=1; AJvYcCUAp5sC6uJzQ6yB5Jeq7RdJb8wtlrIYmwI/b1+ddhfsdc5y3QAkucJuLirPEFyNqMK4DYqBV9ZorBBXRjM=@vger.kernel.org, AJvYcCW40yLFejDpx9qpWwUoQGnukqkhF+Gi7vWen/N9QB7N2GAD+wAHbBxswrYRMrfh8nk09L/YACoI@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGy0Qx0irtcVspe3t8sP8c4lAgkMsQcljWyO0CIFY0CJh+1Gh
	fWXcVEm7ppG4cC5i4lI/Y2cswZXt8Odun+TrDyqm6F5TYvFeN0AR
X-Gm-Gg: ASbGncuvGdj38IhEcrD/n5egHQQSGskIH4m+gYCrIcPl3bKpc1/x1n2rKkereZDVAPW
	gL0vZ62vQf42+LOYhLRzRJ3LofC33Eiu+qmndyIX0MZl7TNxlH15MS3uWL+euYjJjRPQ12Rnyur
	5TOV7XtTku14EWbBmDf0BfsU2jsQCuESvsFlLlFVya4bWEbdzbl6o2LE80SeOo5pDA3F5jqRMor
	misImJRcMTQXama97aLxks6u/l0OoQTpVvVCC72kSz41RtGxBhFondEb4R1+gkeUnurigNPY9ct
	q3mEepKzZqkUIQ6H7ooTgTo9BPxe9uEf5vOak+rDzIhJRISea7/qfj0JFJEU71tC7Qieu6oQ
X-Google-Smtp-Source: AGHT+IHtUXtCUQDA66YPISmSA0d0Lh6xpiX6S1vJ8+DmjImVr8qvcleiH50BNv/+ql1V0/lb8OQEkg==
X-Received: by 2002:a05:6402:358d:b0:5fc:4045:7d79 with SMTP id 4fb4d7f45d1cf-5fca07e91e3mr15193356a12.22.1747147309208;
        Tue, 13 May 2025 07:41:49 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700e56sm7301556a12.57.2025.05.13.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:41:49 -0700 (PDT)
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
Subject: [PATCH 2/3] net: bcmgenet: count hw discarded packets in missed stat
Date: Tue, 13 May 2025 15:41:06 +0100
Message-Id: <20250513144107.1989-3-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513144107.1989-1-zakkemble@gmail.com>
References: <20250513144107.1989-1-zakkemble@gmail.com>
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
index 80ef973e1..80b1031da 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2286,7 +2286,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 	if (discards > ring->old_discards) {
 		discards = discards - ring->old_discards;
 		u64_stats_update_begin(&stats->syncp);
-		u64_stats_add(&stats->errors, discards);
+		u64_stats_add(&stats->missed, discards);
 		u64_stats_update_end(&stats->syncp);
 		ring->old_discards += discards;
 
@@ -3569,7 +3569,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 	u64 tx_errors = 0, tx_dropped = 0;
 	u64 rx_bytes = 0, rx_packets = 0;
 	u64 rx_errors = 0, rx_dropped = 0;
-	u64 rx_length_errors = 0;
+	u64 rx_missed = 0, rx_length_errors = 0;
 	u64 rx_over_errors = 0, rx_crc_errors = 0;
 	u64 rx_frame_errors = 0, rx_fragmented_errors = 0;
 	u64 multicast = 0;
@@ -3603,6 +3603,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 			rx_packets = u64_stats_read(&rx_stats->packets);
 			rx_errors = u64_stats_read(&rx_stats->errors);
 			rx_dropped = u64_stats_read(&rx_stats->dropped);
+			rx_missed = u64_stats_read(&rx_stats->missed);
 			rx_length_errors = u64_stats_read(&rx_stats->length_errors);
 			rx_over_errors = u64_stats_read(&rx_stats->over_errors);
 			rx_crc_errors = u64_stats_read(&rx_stats->crc_errors);
@@ -3620,7 +3621,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
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


