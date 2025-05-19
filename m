Return-Path: <netdev+bounces-191525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B25ABBC75
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3771617C541
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B8275875;
	Mon, 19 May 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUg6FKUT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D827511A;
	Mon, 19 May 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654411; cv=none; b=Vz2T8z/M86l69ctm1liSzPLcIvP/4jtbfENMwtr6cgnyAH/FZ9LsUcEc3Ea/k0w+RxXOH9PhhNRmWhekAGDKxTY0rx6Yk2XMXOeT08gmFuLBp3OTFsqjsgffmh+Zy3DL+kdPkSWdKjIfHXqnLrvnY8cl6iGFEtFruCVGEYsCbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654411; c=relaxed/simple;
	bh=87iKkLfHDWurifoIYFdRryS830tTcwW0mUOg8L1P/VU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2rIeShpdEgB9M49AgMSER+WSykRtDpt0RqgM8mF36cUzF/csyW8eILhG89W1G15AmoeeyfSR5IRPnERC3GgtLubrIdOnuirmv635+jKNrV5cbLrdEXjAgDtS6EaxIHbq14NzKQROZ5izcueKBiQNPJYk2Bav2ZHYAu6DEsk9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUg6FKUT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-601968db16bso3997967a12.3;
        Mon, 19 May 2025 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747654408; x=1748259208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INC5bJWYoO9R/F0r49itfvLWOGjhXDzIMzhVgMDo0TU=;
        b=MUg6FKUT5rKtVpBiH03G1h+tWxFX6Q2zEhd0ZaUPq9ZK+kqZz22xkKSz8UdcuI5f0q
         kxDxu/IHlHxL2YUMIYmE71uSASdEMjr053xhgVIxeuAl9ahGqFQOMKAduHzM3uoMQzSL
         ZbEXUTk0RTj6bSD9ZMnJ+h75QrFLSxqEjSgUHxy6aGaTiWhRukA8S9d589zcg0AtpXyE
         miks7BnX006wL62oRWZlUbLXlkkvqrVSv8ZRS/OKia4Yd1PXArPdZu0XBgQrdy+zi3lB
         xRf9J5WBGhaoK2q32E4VTRBJlc7oJSweWttzTDvKbti5Xl6RMwvU2AwAIwjKLnbvYAR/
         uaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654408; x=1748259208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INC5bJWYoO9R/F0r49itfvLWOGjhXDzIMzhVgMDo0TU=;
        b=iezoqwBYKKHv2pSVzuIU3qB3YNIFU3am5ICqEE3pjeN7agFJ1KzBssf2Q0nS62dTdu
         i8VF4OGp5n6yt7p9t3ZcujxHFY6pugN0DQEkjjHLn95ntcqtoVTC+x1hBSXi1Q1rvuvv
         +vQMZPUi+cptFzx/WZ9zqiUoOkIJnGttRAy2bzia/szuQaFTbnWExB3VRdNz9XCvG/YV
         9HSw8Vop+s/wQW10citpKGOwvaicU6DhAbznVpT12R9eqsUb9BgaNtCPBsvb1GhMaDdA
         zEgnVnXpDzAGRHHBpyIU28/bnjjxN8Vn6t4jkM+nLeVyc3OaPWmNFj94N0fx+IEeAs7G
         jOdw==
X-Forwarded-Encrypted: i=1; AJvYcCXiZ30kfdWl3506OnUktHYaHqHtVluk3J8RjpWme2dmSrMg7E2Wt0R7/GfPXhdhX8zU2wwzn2B8TAYFNro=@vger.kernel.org, AJvYcCXz+mj42UD0dEUMxHs6vBqBoLGvzaTIS/UtRWUSbJWzpYefX+iNkwGooR/HbXxZHTDxriFgqGj8@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtcs5kHKoiDIS4dfVbxT7hzDt1a2Wg97lWOd0UQOGiAiAIkQL
	+l1m0OHkj1kUzrsYx+VrSat58n0OXk9Q7H0kuF0OtEC9kZtiapz/C40+
X-Gm-Gg: ASbGncvsrOP31l6sSPPWi34YQeQCFfIJ1PvSGQjL1LHyzVWrHTV2OqUrQfBX2OCBQrk
	xGkoz08k7ghixHTMqI8pHdlB/xbSmJOLNHV9Zxh2PUAcFwIlOheu5pRDmNJ4tdfTFjJ8FPFNQs8
	3wqg+M6Fc36sYgikOGDuId0ZmaRBQTOPjvZOzVCv2oiKzZJkZVFES8pj3DYlWB/+K3Cvv+vM4K9
	PWIixQUZBHeYU0nVIrb+cdXxqEvxGsLsPtDymful+OFQIB7Y3LR+RGyfJt6Yhci17XUJRfC68CI
	DdvDL5mIkJ0C0dBbt+59pga8UtmbtNa33nXVKAkEYj4aC0Jmbm26mOd9HjI5LGWQXCrtPgp6
X-Google-Smtp-Source: AGHT+IF2YJTXpPWNC3MEzTqyK3ZfaiXI+5MpJQHhfzBXOoeOKQ9QTJk1dZ1mdt+zrPsNSbrEiTetGw==
X-Received: by 2002:a17:907:7fa3:b0:ad5:468d:f981 with SMTP id a640c23a62f3a-ad5468dfa0emr912179866b.7.1747654408016;
        Mon, 19 May 2025 04:33:28 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06bc66sm574279266b.46.2025.05.19.04.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 04:33:27 -0700 (PDT)
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
Subject: [PATCH v3 2/3] net: bcmgenet: count hw discarded packets in missed stat
Date: Mon, 19 May 2025 12:32:56 +0100
Message-Id: <20250519113257.1031-3-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519113257.1031-1-zakkemble@gmail.com>
References: <20250519113257.1031-1-zakkemble@gmail.com>
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
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 ++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 101ba6b2f..578db6230 100644
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
@@ -3577,6 +3577,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 	unsigned int start;
 	unsigned int q;
 	u64 multicast;
+	u64 rx_missed;
 
 	for (q = 0; q <= priv->hw_params->tx_queues; q++) {
 		tx_stats = &priv->tx_rings[q].stats64;
@@ -3602,6 +3603,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 			rx_packets = u64_stats_read(&rx_stats->packets);
 			rx_errors = u64_stats_read(&rx_stats->errors);
 			rx_dropped = u64_stats_read(&rx_stats->dropped);
+			rx_missed = u64_stats_read(&rx_stats->missed);
 			rx_length_errors = u64_stats_read(&rx_stats->length_errors);
 			rx_over_errors = u64_stats_read(&rx_stats->over_errors);
 			rx_crc_errors = u64_stats_read(&rx_stats->crc_errors);
@@ -3617,7 +3619,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 		stats->rx_packets += rx_packets;
 		stats->rx_errors += rx_errors;
 		stats->rx_dropped += rx_dropped;
-		stats->rx_missed_errors += rx_errors;
+		stats->rx_missed_errors += rx_missed;
 		stats->rx_length_errors += rx_length_errors;
 		stats->rx_over_errors += rx_over_errors;
 		stats->rx_crc_errors += rx_crc_errors;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 27d4fcecc..10bbb3eb8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -170,6 +170,7 @@ struct bcmgenet_rx_stats64 {
 	u64_stats_t	errors;
 	u64_stats_t	dropped;
 	u64_stats_t	multicast;
+	u64_stats_t	missed;
 	u64_stats_t	length_errors;
 	u64_stats_t	over_errors;
 	u64_stats_t	crc_errors;
-- 
2.39.5


