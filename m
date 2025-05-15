Return-Path: <netdev+bounces-190756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17348AB89F5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0344A07E44
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D2205E2F;
	Thu, 15 May 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drY2wyQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2C1F8F09;
	Thu, 15 May 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320746; cv=none; b=i3gFXocJfeMOnilMnRKSIduxkQJDIjlIcXwUfOVcYrIQHk2MYswV4rKzfOjp8Y9xCMGIC/F/Zq/cAM0dH3ybd5E99rYKsY8Np+MLye3iUpxSdwewQ7Rb/6GCRjmW0dFcXq6xeNBtStA6eC+OmmicjikSmBErPskpXioys9DAiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320746; c=relaxed/simple;
	bh=mr5eN8kDDujcymHMecpSJ6P6WIBjSLa0r0ZCXb+95X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6Xe1MmMR4yw/FscSe0HLUSqWDGnAIZ2rOC4MgP0cQjD5IYUPFT4k0ldW9t/NoRQJS8m9wPx3ihevTtTfmxKNuPErhVgao6lUd71Bvo+g7AfI0GsFxzhMB50U7jqiH7xuZ9Sx9q7PCcBw2AWxfSDRhcL3Rf86rmlN9k5Xhhe4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drY2wyQ9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad238c68b35so193928066b.1;
        Thu, 15 May 2025 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320743; x=1747925543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqWQ4T2nQ1xuhm/I08cl/zAkrwJKQvzmwnNYg7uixA0=;
        b=drY2wyQ9Wqkv7jDNxAsRsFsVqcB0FWm2vm2h6MSj2BD0Ut0IF8WyBiyTgxh/831nMZ
         u8Tp5+1I80rwo+Xl1CIvF2Dw1ELLO4LKFLGenB2NHyL4gXm3zd9WOyCja4f39edelzXI
         3/XHVWrkfDYJZRXDMw4RXaneXJzmatSeFFBp/tN33TZio/4fSEL8UUR8Nb6G2l6LBHsK
         BvUbkm7giqJtfkx0XyBJ5cxxnW5Y81ORSCMcdR/9OQHuaP5nXZvegkKxJOCzYeL4ilgf
         wvjRJLRcEvaWSCnu2CxGU9O5aCSeyq5AiaYghQXxYSpsaYjdG2rtn3QIisZG2nExw8gJ
         d2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320743; x=1747925543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqWQ4T2nQ1xuhm/I08cl/zAkrwJKQvzmwnNYg7uixA0=;
        b=aEsfCTFyq7HDXRoyx2YMnGbSlPEu3Il3ONUnoXbEA6hK/cAvWU2uLqeYcG9Wq6FU/C
         MC2Cfjdn2+2B99WsDFrZHcoOW0vU+h377e6QG3V6QKwBjhSIA4rIeDhbbXQnn00ToQg+
         +kR6/eqIXcSE7SW0Cykz9Y9/fxabqiOPmbHq6MtifNZtsFTakzg7mUk87c96aBTdYCQp
         Cv6vtr50O+TwEw/h7IkUdWZ4EAyRJUCakmJniKLdBL7OZPgZjUb3ylqVPbPQQGy7oOon
         7T2n1QV776dfRvUfFLbjsdmc9PMDwnz/clvSD436oDhMoTwDHwup2GHPo7cmnYJGWwa1
         Ov+w==
X-Forwarded-Encrypted: i=1; AJvYcCVBr6e90N4gXmmT0Szq0rNB2eoUn5/fu8DCJhGHnGroKSQpX+Vhe019LcY+gOyYXwgbDxeZgL15BLGQwec=@vger.kernel.org, AJvYcCX9xFt7ip5DluG49Ffvf6KoRBGmDItkT/nl74/O2ta0DRrc6UfZJIfqgaH0s2VhCIf+PhV0aZSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GgLVQANNF8IfZgkRJ8mo8yTF/G8tk4qtuGLGupQg3mJE8oEw
	pbck3diloFF4FnLU88pgdhuqPcywjUFbhePeF6xSj0+debCw8odr
X-Gm-Gg: ASbGncuPO+qGMlgRDFBk7ZihHyyKqvbyaZm0z/G7UZ0FAX/kazPW0rOmfe2beBLkuP8
	f/AJYF0l1VRAtqNoqsMpY3gXtdRPey1DUPJ8CMxvofhCMikp13SFyKeRRa010FrpajXKQP349s1
	eNehlYI/mhn8aJ2/mkKpG4d/NKt9OZA270QH5gl4VvyByeYskPvtbzK7s9Fjg5ECN/yjJR7374d
	05EFRHRsDSnfA0D7J3OPapUdIqbFqzlrCfbTfGLu6EZ+fHliXXod1rVM7/utu1cqp0NBr0lhUie
	bx2rqCnwIkdU6ddIGzUOfHOBn0oLmRNW1FTz8cR+Ptmk1knTn0uzBl0YazF+CQ==
X-Google-Smtp-Source: AGHT+IEfE3FRqZ+5JKYy1hLeEyiCcglI8CUTeWPDh897m7vydljAH740Y/LC1+zq3IhEF93yuoKWXA==
X-Received: by 2002:a17:907:c409:b0:ace:5461:81dd with SMTP id a640c23a62f3a-ad515d7a850mr247977366b.3.1747320743060;
        Thu, 15 May 2025 07:52:23 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d275d9fsm871366b.74.2025.05.15.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:52:22 -0700 (PDT)
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
Subject: [PATCH v2 3/3] net: bcmgenet: expose more stats in ethtool
Date: Thu, 15 May 2025 15:51:42 +0100
Message-Id: <20250515145142.1415-4-zakkemble@gmail.com>
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

Expose more per-queue and overall stats in ethtool

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d0c6b5d4c..5f227bf2a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1029,6 +1029,10 @@ struct bcmgenet_stats {
 			tx_rings[num].stats64, packets), \
 	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_bytes", \
 			tx_rings[num].stats64, bytes), \
+	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_errors", \
+			tx_rings[num].stats64, errors), \
+	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_dropped", \
+			tx_rings[num].stats64, dropped), \
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_bytes", \
 			rx_rings[num].stats64, bytes),	 \
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_packets", \
@@ -1036,7 +1040,23 @@ struct bcmgenet_stats {
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_errors", \
 			rx_rings[num].stats64, errors), \
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_dropped", \
-			rx_rings[num].stats64, dropped)
+			rx_rings[num].stats64, dropped), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_multicast", \
+			rx_rings[num].stats64, multicast), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_missed", \
+			rx_rings[num].stats64, missed), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_length_errors", \
+			rx_rings[num].stats64, length_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_over_errors", \
+			rx_rings[num].stats64, over_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_crc_errors", \
+			rx_rings[num].stats64, crc_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_frame_errors", \
+			rx_rings[num].stats64, frame_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_fragmented_errors", \
+			rx_rings[num].stats64, fragmented_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_broadcast", \
+			rx_rings[num].stats64, broadcast)
 
 /* There is a 0xC gap between the end of RX and beginning of TX stats and then
  * between the end of TX stats and the beginning of the RX RUNT
@@ -1057,6 +1077,11 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_RTNL(rx_dropped),
 	STAT_RTNL(tx_dropped),
 	STAT_RTNL(multicast),
+	STAT_RTNL(rx_missed_errors),
+	STAT_RTNL(rx_length_errors),
+	STAT_RTNL(rx_over_errors),
+	STAT_RTNL(rx_crc_errors),
+	STAT_RTNL(rx_frame_errors),
 	/* UniMAC RSV counters */
 	STAT_GENET_MIB_RX("rx_64_octets", mib.rx.pkt_cnt.cnt_64),
 	STAT_GENET_MIB_RX("rx_65_127_oct", mib.rx.pkt_cnt.cnt_127),
@@ -2412,6 +2437,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		u64_stats_add(&stats->bytes, len);
 		if (dma_flag & DMA_RX_MULT)
 			u64_stats_inc(&stats->multicast);
+		else if (dma_flag & DMA_RX_BRDCAST)
+			u64_stats_inc(&stats->broadcast);
 		u64_stats_update_end(&stats->syncp);
 
 		/* Notify kernel */
-- 
2.39.5


