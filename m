Return-Path: <netdev+bounces-75161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF8868624
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7180A1C26C5A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD0EAF1;
	Tue, 27 Feb 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="OlF53CLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9A5C89
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998122; cv=none; b=WN6Q36lBuVYJoDz0RxizQnqcgpifM7ivILS2+qOARkWvsqWrNGSdAiyHOA3mhMekPsG9I2EEJBlzrafyONMcrH5+at1RFkWUlX6A2+OXR/ZTST6gdGUEyVsBCxei9e4rTKndfr5CsSTR0vUcRYcp9Bj4dtwdDXqij/Va+s/DhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998122; c=relaxed/simple;
	bh=TxWvqhdKyCdWcAgdV1E1upYoL6nk1uGlgpZBn0ku1TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqVrPBBBCNJ0D0K8d0h9lhOQ4USNp3U5MpgRGocYUlRA35XlpEdCcj4XuAQlhqKK+F/HEH2OOSV6JsFX6gslI1cGI2l3VPnu2vmDlzLLslEBCCoAu5qsGsi/uISS0NoQlLVVCbF3Vy/t+3fdfbyyrcZs/1lgNYf202srcgts3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=OlF53CLh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a3371133so12808305e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1708998118; x=1709602918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Njr01eXaTmzMyHGNg6x9jCbyB5dpG3QCfY2Mg3WPEc=;
        b=OlF53CLhQsY7VvtEztbmmTJ3176GjHDyR+j81SqbhN+Ocj8to8oW+C+0IqINgLtq20
         KfrtQff7M7alb2sCrEJoHknUFp2w/Ipx/SDIxl2OW5UXZBJLUyBLRMaCljcKiFfYBTZ9
         mxbcy0izHyV07bycBlrMLOimFLTcekUFiLQpGr3IXr+NazysfFLJ9d8ndJF1kQ2Na9kc
         9PEcWVyhSoGByJbKsW/G4zl1lQIwWk9QN3y1Oe2LhK0RTjPmm0ikSw2cPgjgg7sCMvXA
         7bqeCpo9K2R1NZYHmiMSvXKva1PwtukZxKZP1wIvN3d9UVP8q9fd9hzCgo9F4UMYV3l8
         tVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998118; x=1709602918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Njr01eXaTmzMyHGNg6x9jCbyB5dpG3QCfY2Mg3WPEc=;
        b=suM6N9hkTbfmEq/98kx8vBmRa0y+CdotQvUfWkMZdjARx8OnWx4Z9w/CO0/XQjxefB
         Nz2skWRNMpj3a3dZLMiiobpC9rq6jatwZCVNA5vK8FSVl2DrZJmjpwEIKfaE+Y7UwVI5
         aQcGouN7evkznZ1Xm/UAmroVz28l00phY9OxsVUbmRHVsRcYGmQcrsQSLeTjirv1XqXu
         oCf78GmhnzYuulx1u3TAAZ7yKako3RKCAay/jTtUnbNBkk+vzMKE0egzqYcO/8EMqJy1
         lsjvSbZBsWzmypYdCuWaxdkc53aTjlp6apKujDW6GKYjA/bCoh5D9fodx9pbowg1wwsU
         ao1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpciD7INWhg1oHtV0OtpUQeAXrnH7q21StzIb0/hYLIvd+Sw42bawec2ZtFPQNaYAqQJ1a2FiZrrsrILwe2VZvbbB6q6Es
X-Gm-Message-State: AOJu0YxjCPGDzIaaNx73nUb4aIe6unr/iGBJEbHWmaoDIxxCkZaYEKW6
	yMVyTCjLSvxABPUb7uU+3aEK4gFKZCy3grAfHtEbEz9M8KJ2yNdZXEndqUhr65U=
X-Google-Smtp-Source: AGHT+IH+AZTMUsb862Ep8x+r5lTFIK5YwBiR2B+KnTFT5lDKD8GJoaR17NJtWoNoqWyevW6z22BOkg==
X-Received: by 2002:a05:600c:1553:b0:412:a206:ad16 with SMTP id f19-20020a05600c155300b00412a206ad16mr4801157wmg.12.1708998118323;
        Mon, 26 Feb 2024 17:41:58 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id w15-20020a05600c474f00b004129860d532sm9827918wmo.2.2024.02.26.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:41:57 -0800 (PST)
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
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 2/6] ravb: Make it clear the information relates to maximum frame size
Date: Tue, 27 Feb 2024 02:40:10 +0100
Message-ID: <20240227014014.44855-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227014014.44855-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240227014014.44855-1-niklas.soderlund+renesas@ragnatech.se>
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
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index c25a80f4d3b9..3c59e2c317c7 100644
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
@@ -2967,7 +2967,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
+	ndev->max_mtu = info->rx_max_frame_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
 	/* FIXME: R-Car Gen2 has 4byte alignment restriction for tx buffer
-- 
2.43.2


