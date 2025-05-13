Return-Path: <netdev+bounces-190181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C989BAB576D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D97B3F6F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AE2BE0E8;
	Tue, 13 May 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDOkP5IG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB99E2BE10C;
	Tue, 13 May 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147317; cv=none; b=a4rbPG2h3UsqHdZX5k0jydfxZQBibH7EFmZf+BetsgwFq5fv49lU0YV/hV4T7v2AIxx1y0L8m/hBjTwQ/voWVSwnU48ylltqzSrzlLBgbW0IFFz2CvWhuYpasLNIpI4PQPJHasC+gk51ydXstgDEi2PP1gOHnLXLaKvq55mN4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147317; c=relaxed/simple;
	bh=Mfe/o/ujk7XvMhycJvGf6PnnNtj9TPRT+Cu0bPP1/H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWgmOVlasK6AJXzTbT091xuCRAehwyvphAg7tGb+JTNZTcmLkzlJec4UsNmuAPbk6uJuquZnS9/vJUv7v78aJB8UYVwSWIMbMYm6o83L76w1Jw2tzlxsrNeE92ANnERtO+YLcJ5lf2UeBxwrPQ1l6+6gn9sxfHytJatp19T2C0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDOkP5IG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbe7a65609so9191908a12.0;
        Tue, 13 May 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147314; x=1747752114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzjcpGVlPiNhfCQy1SqonqHdDAwC7y+3thN4axNOI5o=;
        b=nDOkP5IGD3KHdAx7v4wcp9JacGfByfez8C/lXu0gyHhjDtOfTM9WXCsu6aSkWYiGz/
         MHXz36FyVcMAOeWI9NXjKuY3r/naTyqPagDIPD1IecqnxdBDFGJFSNH8ofGSaC0TmQxk
         gXBkoZPpZp12dvndPfLnKOZXxRmcdufUCVkv0VZILZcETjGajI9UbMSVcCfuHcvtpVuT
         JmfPwPfEkOxdBRdJUXCPn5JYGESSI/XGE3CjUsTL9gxBwKisLAC/h0ZSh0C3RMlBnsom
         ystagC44LuXRb52fWKIH18Ci8OM51GDKG0LZzbdrJPoTFG5/Raw5YJ2UqZ8mWaA0oBSH
         LW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147314; x=1747752114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzjcpGVlPiNhfCQy1SqonqHdDAwC7y+3thN4axNOI5o=;
        b=mLkNS9fupIouGq8NxMWobtqTE/xAZZ7EKXaPRa+Z53Zaq7CQ5PKeFqg/2s9DWq28rT
         7FTeEpu2t7i/+q0nlkyldKGDZPJDzOwx3TLTNZZlMZwUjf/Ti7opcrGjHQ9p5OyJgPVM
         gjzF6P1I1FI6XucdFeUnTLRPswIVSF54xDe9pbx855/FQTWDsyjvWYFn/2L6mktVnwKx
         aPWMNdMFOwfyNmrbbRkQtp9tTVsSStkW042y9eWsF0Y6DGMAFlMV2uJv0zT8KoOIMgKC
         mxqN5W4AOSBNxVRA/C1ktQ7U455fxxNg2Q68gM6q3byP8YVwc+if+vXfMBEt7VtnWJqc
         LA+w==
X-Forwarded-Encrypted: i=1; AJvYcCWsbbaQjoA9dZnmRyNrBHjaIBYMqMSBN+3VP0TYFYzzb/klV58spmjrdxJRPZns6Zqct9I7aQbx@vger.kernel.org, AJvYcCXWkqw5LBI763NR03jRR69uys2Jpd0i+u9x4moj3AUZp21V211TFFbv6ecvm7GFnrWU+mXofbtwEbTBHmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnGcceNg7RTRxUPAOWNdMeLatanHqTSXpExmvj8iWQr91VYdk
	tqowz4dw6q8xeoWNtUsRZYLHZ7qDXhQ/2ullEnmHtLP4oNnTWDOH
X-Gm-Gg: ASbGncvT2AiWYCdze4H8ASpCOOj6as7YmP42oUV3W2TM0e3xti9Fb3XSZgdNsdJJuQO
	iOL7nGahXCX4akUNdaTkD9bpq4ZQJ/9Y4jkyVwtHEVQid4ScjvUqY5GXBo6w22+lFK19Z67Oavl
	LLdkF1wfIif3J98RnelRbPJb7fnd7TUr4VZ6FxMAILRNvA6UaVrqOnvSgjeN9Xn7i8sAzRXKHcU
	cvVuzUwgKBH2y0T0Tg1kRk88Sb9Zc+B8ALqXCp6iTUUUdqvF+8/eHDg3e/a0tYQmubWyaSNXidN
	tG5qqtsacne+32s6x/tfWjB6+tm5ASv4ygM21R/Bj73Fry6piCtzBp20+sTMHQ==
X-Google-Smtp-Source: AGHT+IGa8HfcLnV5l28T4pdncKPX+8wlBf0z+xMRFl0KSOi65yCYhLtG1//h/VuXNDAMOEomitButw==
X-Received: by 2002:a05:6402:234a:b0:5fe:6e0b:aefc with SMTP id 4fb4d7f45d1cf-5fe6e0bb0e6mr7542848a12.26.1747147313932;
        Tue, 13 May 2025 07:41:53 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700e56sm7301556a12.57.2025.05.13.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:41:53 -0700 (PDT)
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
Subject: [PATCH 3/3] net: bcmgenet: expose more stats in ethtool
Date: Tue, 13 May 2025 15:41:07 +0100
Message-Id: <20250513144107.1989-4-zakkemble@gmail.com>
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

Expose more per-queue and overall stats in ethtool

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 80b1031da..ce224de45 100644
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
@@ -2408,6 +2433,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		u64_stats_add(&stats->bytes, len);
 		if (dma_flag & DMA_RX_MULT)
 			u64_stats_inc(&stats->multicast);
+		else if (dma_flag & DMA_RX_BRDCAST)
+			u64_stats_inc(&stats->broadcast);
 		u64_stats_update_end(&stats->syncp);
 
 		/* Notify kernel */
-- 
2.39.5


