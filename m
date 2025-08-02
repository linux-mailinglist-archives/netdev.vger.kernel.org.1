Return-Path: <netdev+bounces-211444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DAB18A81
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 04:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D21AA390B
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429619CC3E;
	Sat,  2 Aug 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp6QixMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2E1917F0;
	Sat,  2 Aug 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754102809; cv=none; b=uVJIFZ/6lPA8x5KcE3uQ1TzMdTMtlC7kqdig2nGVzFh34biA6sgms65oRUqAvzLaaVcR0oY134PKdZ9qahZlSDV8PkMkNdNQfhxEZOSGrPVzQ+sE0kQePurT3WNotK31rLjJLrb/6TEfI5aAr3u0fYRlw0664qjVylL6R/SI9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754102809; c=relaxed/simple;
	bh=CBRWugJOp0HWh4O1uxAbjFWkvcjAfo90Uk/yXGNiuvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anBA7IxVvQXZXWd4ihqEWnKZjt5051RZvhbI6fUqRK3b6p9Pw4QSC1JB+hvdUGkatFUDgfTud1O/4Txo9uP6MQ1RUBJ1lTiejkpXPpx/VVIE6wWGDzgJD9j5GMESdQH0a8G3V6AR0k9McohALIxFWFN8otbzXY6D6XWa7Pkho8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp6QixMf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso17105945e9.3;
        Fri, 01 Aug 2025 19:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754102806; x=1754707606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy5A+Unrm1WOpi3y5RSzodSnZ2nO/DZmik1djpd7RO8=;
        b=fp6QixMfx8ynnvJtwoo4zvGOyY3pPSxvKGSVG33MzJ1h2doTV/YY9+ruRjRjth+64t
         e8K9Cia/lmmGa/OqImsL8HscBb3DkqKOslcohQEi5g16oeYAm7IR56WxZUo49Jbtkhts
         O2MK3kGQ77d/LPcFO9hOzCbZF0E0P1zevIoJI/aS2NgrcI2qzkweOP1QYKvg7II0s441
         khbm6UCO21JMrcsBX2aKv4u+iaeWmKq5TEPJzvJ5ozfE7uCMbIUZDLKu+hHQqWEWsmx7
         8VByBZHIpr/LOcEnOTlB4aLZKfwk1swT23g9sLBiU20m87e2LHzyfVVQXGRWLqRq5KrL
         xSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754102806; x=1754707606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy5A+Unrm1WOpi3y5RSzodSnZ2nO/DZmik1djpd7RO8=;
        b=tKupPz2anpufAnlqPmkYIIF67p2ScR1bcHjQ27zH+sYHtivkXjtj90L4+4Aewt1hQ0
         u3jSgyRg4JXBu1B13LOiEls4hNwC9wC2OIU05ULVH8fD5y+3NnqDEnwZXQXXkTX4nzYH
         JNyqflQcIPHDH+q3EAPq0gqTtjMECLfrTm8NYU0rvmKT2/e7zNXzbRf3Ch1AT3qZafuY
         HkvaMVQvnEVoRjQHTt/TiATSeCJDe6xRaC9jwhzWOuULg8ZOTUx/2YTsZchRfOvlnPWB
         VbNASVLtjCU6RW7aML3Xr+aBUt4nqsZcw6zXsnsaKSqzxSsTShoudipe7ZoE7YI3hQC0
         LmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXegux7UxrcuiYC5n/2AMInpf4eZ5qGfoyHnk0cHBxfuQ8WN4v63IkhRBDBFLEpFw5N9RVLqO+ZqguvJIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1r27vEekY99MkMVd2UZ8r9e/fqHKwWxfRiW1PW2VSV5dumry
	t0P3OveUPbAahwL5iILbX/iSasjuE09vIjYTSTjE8Ti6fTbAA6fUYn6aGl3dTQ==
X-Gm-Gg: ASbGnctVOzZQmT81Uzfv/pwyg13HRyJ+XzvQOt2zY1OqLo55zCapCmSC4cXEtLCwkKI
	dPUgSo3hHOdYTmf+dhpUJybo7HNFUyospK9e3cw9OXpnQqytTdZawxX8AZhx8RYlx2S2TurwxlE
	40chVKo/dcUtmCNBjpkCj0lVjpoPyf7A/Va6p5e8Q2d3wPka5MBZ4fZq1gZSs168faiFjwtCgM8
	dV0iuYkzLb4fArMcc1AJP6nZPfuXABI50bhfVYTnqD5W9Ijh9W+hCf80hPbgIeO3eBeJLLnWLfD
	EggYA+/kNX0avNyoyfeA8gF3V+7ub3k0PJfhxQHsMlIwUBJnXTN8vqiUUpTz56VYBWZG4SqHK9k
	0khoFf3FiVSwd3NqCkOhI
X-Google-Smtp-Source: AGHT+IFgaYOugESTsPfQ+QwJblm6z4dfzGMvlR//kYHseURm805R2n5IlJGtjdOIFyd8Sv9R8F05Rg==
X-Received: by 2002:a05:600c:1c89:b0:456:2cd9:fc41 with SMTP id 5b1f17b1804b1-458b6b5872fmr10056545e9.20.1754102805336;
        Fri, 01 Aug 2025 19:46:45 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfeaesm133814155e9.16.2025.08.01.19.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 19:46:44 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net 1/2] eth: fbnic: Fix tx_dropped reporting
Date: Fri,  1 Aug 2025 19:46:35 -0700
Message-ID: <20250802024636.679317-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250802024636.679317-1-mohsin.bashr@gmail.com>
References: <20250802024636.679317-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correctly copy the tx_dropped stats from the fbd->hw_stats to the
rtnl_link_stats64 struct.

Fixes: 5f8bd2ce8269 ("eth: fbnic: add support for TMI stats")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 7bd7812d9c06..dc295e1b8516 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -420,16 +420,16 @@ static void fbnic_get_stats64(struct net_device *dev,
 	tx_packets = stats->packets;
 	tx_dropped = stats->dropped;
 
-	stats64->tx_bytes = tx_bytes;
-	stats64->tx_packets = tx_packets;
-	stats64->tx_dropped = tx_dropped;
-
 	/* Record drops from Tx HW Datapath */
 	tx_dropped += fbd->hw_stats.tmi.drop.frames.value +
 		      fbd->hw_stats.tti.cm_drop.frames.value +
 		      fbd->hw_stats.tti.frame_drop.frames.value +
 		      fbd->hw_stats.tti.tbi_drop.frames.value;
 
+	stats64->tx_bytes = tx_bytes;
+	stats64->tx_packets = tx_packets;
+	stats64->tx_dropped = tx_dropped;
+
 	for (i = 0; i < fbn->num_tx_queues; i++) {
 		struct fbnic_ring *txr = fbn->tx[i];
 
-- 
2.47.3


