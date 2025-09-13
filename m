Return-Path: <netdev+bounces-222801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B3B5627D
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53E6487DE7
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F222212568;
	Sat, 13 Sep 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKngJ2y9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253C2DC796
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757787230; cv=none; b=QRRX4fGz/6FSAfvW58/9rKhwHONPPua5sp49GCIjHBDUt0RZCJd1vm67Ca6AxH3x3oxVqHMY+W2xwb90AkBRh9q2zXE+5EHN1U3cICMCYvCfcQmBt4/ks9+uosHkmt5mAv3wuy+tYx50LU1OidftQkuYPj7VuZMyMeBiA5tp0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757787230; c=relaxed/simple;
	bh=3rzaM2X/zFTxRZBZgEHTS2j0+xkHtGU3DGTzIAZHWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CV1AssVpt4iUCV4XZKMWUo+DxIdw7q3cpfTh9CNZjRwwzIcRJLQwFPgBXAGkYXpePLF/d0Xl+ZrV0E+QjcPFsx8FgK7POaRPkTFqV9OjAe0+Hyu0/Sx/LG9TTrYyhAJPqKVG3tEw46OW+E0huf4B3aYFNTZgoUShC6aqaPwlhEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKngJ2y9; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-72e565bf2f0so22548157b3.3
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757787228; x=1758392028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqC6tk+ZfLggMyonbV+QWYHVZPiMQwp/bc2dZEheebg=;
        b=FKngJ2y9BuPcidAcNLHInK8z3ZE40mdZbhYHrjtZLqW8NRmjkc0bYkNvW2xtKq4U8x
         FaqhGRiNRqhTxNder2f1gUXu5+oapnqXyxRBNAzzhrmCwl7l0MsL1jaxEsCoCMkGjd/E
         NcRWrJXaV6Ki/0cx4nR80Q58QiOgk0y26x94RhuZOpJmvq9qZ2v+tvEevtzyINmNK2qV
         IMGF2sefTS+xM07Yz1TqnhGxGvmXGjUBnYTJLIa2k+UwMrtQwY5g1mvcgPtxAHBVaair
         rxGUsNVTzoTiO1kfK7xyMD0vC78D87eB5c5apSd8pDHcUeL8zSgD9bgoI5r225bfciF2
         A/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757787228; x=1758392028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqC6tk+ZfLggMyonbV+QWYHVZPiMQwp/bc2dZEheebg=;
        b=KJsvKw46xpgKZMWcFAYSqwzi7GqbKPhUYgtVuOHJeQC15YfgRq6f5kDXLv3Ok6z6Ys
         DjwEUXp4GsWmYNENKNOlExbLUpSWbkTA5zDti4T8ZDofiyWkzrjGi0ukbewPt2gpcpil
         gwx8ef7BKz9wUt9m/1zdnmIRjwJQF8ZVpiIg10dzsFWzh1zKiqE479pR9ZCnmJdpvgfw
         qg4Ed5Ja3+fuyZw+5ii8zb7KoWLE919TM5jCMAIC76L6a4UPaesFJhn3yZD9xLpGJUCp
         56jj+/cF9xnXxZrCzj4BwUsM1YAVcqppfKZvPqFuBqlly7CHOyBYQc9qQ56E0VZRNRQ4
         9nFQ==
X-Gm-Message-State: AOJu0Yz35Zw96u3dy9YMog21yBhVc7X4v0heX8dXieyLSx2PVBfrQiAM
	uo5zw0R+BYXvWikmAdJivgDk7Fu5SIYMzYLj8dxt2Ho+A5GnQfstgIbG
X-Gm-Gg: ASbGncsMJUDViEOFNKcK6APCGEYfHlskehcEmwMTVe45bSxHscbF/iY/g9u5G4YYT3I
	hNfsKDtSHDoKEtxY33kiDlXMnFV9Ii8MeFdyHkL4aJzsleG1G5q8+wDpRxdypHIYXqcncikd4x4
	I4L7taspCwS+ZoGM3+xQ75kDhHu/cESlPGPWHFBGQuViqAS6eiWqKFCpIa9YyNuzQ1IhGcv5qGd
	X8y3vRk2gGQekqqcTuIxPqma8d5o/9GfkHaisoIRdYT1K98n9h4jX/iXTm+y3d6Kw/Zg+DObKjl
	iwQy02BLjOpdh+xiLk1SBjakP+BBdMeempWfEUSirF5b3KM8CoYN9UQvWmQDSW62d1rKMbTly0s
	aww99Csbvrzv8mhALMKNjlHifv0XtmFOnbpRAGIlQZ3LT6XEbIK5helzU6yBgtCXVCZ6/Inz2zS
	iFZRo=
X-Google-Smtp-Source: AGHT+IGXmfP8lhQsAEr8A4H+juDqXUoD1IEZHDk4WG2eYBTmnl9v+NYkqBaumyp94fhbs4FlMP4+2w==
X-Received: by 2002:a05:690c:610e:b0:71f:e5c5:5134 with SMTP id 00721157ae682-730645316f8mr70119117b3.33.1757787227704;
        Sat, 13 Sep 2025 11:13:47 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76928fe2sm19907537b3.25.2025.09.13.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 11:13:47 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: renesas: rswitch: simplify rswitch_stop()
Date: Sat, 13 Sep 2025 14:13:45 -0400
Message-ID: <20250913181345.204344-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rswitch_stop() opencodes for_each_set_bit().

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index aba772e14555..9497c738b828 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1627,9 +1627,7 @@ static int rswitch_stop(struct net_device *ndev)
 	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
 
-	for (tag = find_first_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT);
-	     tag < TS_TAGS_PER_PORT;
-	     tag = find_next_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT, tag + 1)) {
+	for_each_set_bit(tag, rdev->ts_skb_used, TS_TAGS_PER_PORT) {
 		ts_skb = xchg(&rdev->ts_skb[tag], NULL);
 		clear_bit(tag, rdev->ts_skb_used);
 		if (ts_skb)
-- 
2.43.0


