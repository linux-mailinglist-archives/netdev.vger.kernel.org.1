Return-Path: <netdev+bounces-75504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD2B86A28D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0271C25896
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E755C1A;
	Tue, 27 Feb 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="JTeKJLJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5155766
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073227; cv=none; b=TrPPcd/Jql50M3CiCmRA9Knn2qD4al2aK63Ieq5Mn4N58Che/ib4Ri8XHZgbh/ZJxhdm5y8H50FAKIz5jdRPDB4pPSKnBU2Hur4Kds2HY0kN7GZDu41L6YEhZeYJKUAxJHclutHcGHRaV6xBx3yN+Ei/yD3ceAIfwAU7x7nZRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073227; c=relaxed/simple;
	bh=Z2rmd3olQxtYsxNHqI9FuDUsRcwmpdv6TmF3ZRMYdI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liZ6u+n7XG0eU1ea8DXwDF9VBUoOJVjucTPsCAHHmVJyNyx51Py3QOo+pDcSCzC2imPUqpLve4dag9DsuK5Smv4c7VQLqz0f6I9WG3ZT1tChwx1F4XKhqrPvb72d6xLOKBXkUMqiZ74ufl2u/YjAvERd0NH7HL350xH6DmvteZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=JTeKJLJ7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512f3e75391so4003339e87.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709073224; x=1709678024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvcgEv2vgegZQKsZl8rq0fWkak5mQob7diqDo6DYaYE=;
        b=JTeKJLJ7xPwhW39tUra4PUnqcxdB77GQQsxw3m4J11idn36vdf6uWvzxCuf4c5uKEG
         adctGRN2Pk0UAwHiqIU8SkYzGGkrL8veEzaERTVeI8mV5V5fA4bc5GGV71Hhd3zjRdMV
         3+N7RNFyQ90m92nY+S8aaeNgOhIkY7fmozgBogh7C5aWWVEG+txBPmE+KP0BCnqt5Yiy
         CeIe6QmYyQRWmOUH1Bmtf/Y9WrRuAXPQB+NM91hLrKndII1HW7LsKx2iO5hRv+uFKinm
         5pNlG00ZVqyIniUIqPl0G38z9nt/qMX6UHwV4awAxwMUzu6kJfOLNV+OUdkOEGU+RwxE
         A+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073224; x=1709678024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvcgEv2vgegZQKsZl8rq0fWkak5mQob7diqDo6DYaYE=;
        b=cUCnEvUQRO8ZFbfHYgE9608WPZxt4jnCnWMSehdi7rB/Mqb/Sdjjrz3ORE851hn1Dv
         yuxWC0OxuWwXAK/c2P2uUm1dF7CkpKVSufPn30M1rEPNCNvf0UTrfaAZfxRuHGLN6+nC
         CaLJl9fxE62xUs7ch4tf1pXTnhnkzqHBQavMze8yyqyJzut/qaHWe842jKS5N/KOmyDy
         EG9yrnRdmzzFF/bT9q0oaZjGX8pshaSs7SQ8khNAQwwHjQM+zc8WPeA9D3by9AZm4Izg
         SnWuudvk7yOgntAAbwlVxNkc/RweF3bH6mIuK9mEo6Arc8vw7AdlO0OvinymT3N4VwPP
         k2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWFhEydJvwtr3wOBnQxW5iy1jTkO3HSAbvm3hh1Fx3l6cLpYJbqL5PgZZvdwYoOiX7lHZxbWEJsa08Bsp/0p7TUoBoyRt+C
X-Gm-Message-State: AOJu0YwUbvp6zVCFJ4oDCoWC3HtRAtO881reBkbKMN0BBbfM+HYXi8MR
	cIf5AnRWEuKciIHE/zqkGUeMCmNlvINEwQ82SYV0tf9iXW0irZ4T8kCZQVtuNPs=
X-Google-Smtp-Source: AGHT+IH8Yq3YNEG5XDt+iJFs3uQzQZ7salK4U9XnZFL/bNpRsFCLSF/EQtY43j3Aj8n10WKijVs76Q==
X-Received: by 2002:ac2:5e86:0:b0:513:1385:c943 with SMTP id b6-20020ac25e86000000b005131385c943mr1483275lfq.40.1709073223705;
        Tue, 27 Feb 2024 14:33:43 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id jp11-20020a170906f74b00b00a437b467c92sm1195860ejb.177.2024.02.27.14.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:33:43 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [net-next,v2 2/6] ravb: Make it clear the information relates to maximum frame size
Date: Tue, 27 Feb 2024 23:33:01 +0100
Message-ID: <20240227223305.910452-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223305.910452-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240227223305.910452-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The struct member rx_max_buf_size was added before split descriptor
support where added. It is unclear if the value describes the full skb
frame buffer or the data descriptor buffer which can be combined into a
single skb.

Rename it to make it clear it referees to the maximum frame size and can
cover multiple descriptors.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index aecc98282c7e..7f9e8b2c012a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1059,7 +1059,7 @@ struct ravb_hw_info {
 	int stats_len;
 	size_t max_rx_len;
 	u32 tccr_mask;
-	u32 rx_max_buf_size;
+	u32 rx_max_frame_size;
 	unsigned aligned_tx: 1;
 
 	/* hardware features */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c25a80f4d3b9..5c72b780d623 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2684,7 +2684,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
-	.rx_max_buf_size = SZ_2K,
+	.rx_max_frame_size = SZ_2K,
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
@@ -2710,7 +2710,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
-	.rx_max_buf_size = SZ_2K,
+	.rx_max_frame_size = SZ_2K,
 	.aligned_tx = 1,
 	.gptp = 1,
 	.nc_queues = 1,
@@ -2733,7 +2733,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
-	.rx_max_buf_size = SZ_2K,
+	.rx_max_frame_size = SZ_2K,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
 	.gptp = 1,
@@ -2758,7 +2758,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.max_rx_len = ALIGN(GBETH_RX_BUFF_MAX, RAVB_ALIGN),
 	.tccr_mask = TCCR_TSRQ0,
-	.rx_max_buf_size = SZ_8K,
+	.rx_max_frame_size = SZ_8K,
 	.aligned_tx = 1,
 	.tx_counters = 1,
 	.carrier_counters = 1,
@@ -2967,7 +2967,8 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
+	ndev->max_mtu = info->rx_max_frame_size -
+		(ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
 	/* FIXME: R-Car Gen2 has 4byte alignment restriction for tx buffer
-- 
2.43.2


