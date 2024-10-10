Return-Path: <netdev+bounces-134359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82314998EAB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BCD1F24CB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F761E0091;
	Thu, 10 Oct 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P58KyRAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9541D0BA3;
	Thu, 10 Oct 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582280; cv=none; b=qSQJP0y80l/YN8nnC/q0wmd9IqJ4BEg3rY2Y7zPQS23c6EEKVidIEk8mEpWTaRFaxGWnIN9bBLIb6yKUOPQXt7mcsM4nQ8aqQmndg7gnOugUrOORApKeUKFnvizf66PgyC6GUkPY3KRu1Gkul8qkcD9j6l1BVcWr8KZrRTZNpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582280; c=relaxed/simple;
	bh=nttGTSgyEVPTWS7n4XZdeVO6CJF4ScHLOM5doeOV4IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfjCctuqczg9+bJ8XVufF17tIp35uOp5oT/kX9JLN+2tgKTGHy4uIC1QI6b/hvuaLPjLmoE2BC1bQTdizjnJxFuGSh6DlWrhInAwO0rhJ58RFIudHmYlLXmrvA1PfL9GUrk+LQI/C4gCHirVmpzmu6vzVLl+MXf1GyNAyMfhRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P58KyRAJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c544d34bcso11309555ad.1;
        Thu, 10 Oct 2024 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582278; x=1729187078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhwhRxeJtKkhLdaXr2bQEoCNtmrAgCvULfHrUXbH9jw=;
        b=P58KyRAJQiDcWzRx5TP0PglrItjkv7JtW7zAOCYNKc9ELdF/zzeKdNKsZL7Kae2fBZ
         c67BeoIJUQDij0c24c8ZbthRqdMEhpbomyCa4d/hE0fnqDvf6xq8BSHm7e86JhDfeBqx
         ROLTjLAMMYT7wpR2bgoTu3ehzSOU4PHJCuTvC0Kd/1cw+v4oSVW0AmvqID42dQsaFMJs
         LHiKASno5T+h3gWEHgFEdhXLVZ9CCnQIInUSVy8NPaKx528Z7Bmmlc3N1/3PKxq/s0oO
         /qcKM2uq+yvdZyRlTix9XtBGglHoCFq3ONPMnEBycRxZlfkO6g+glPIbRTPSVSnjbalB
         zHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582278; x=1729187078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhwhRxeJtKkhLdaXr2bQEoCNtmrAgCvULfHrUXbH9jw=;
        b=skkLEc+vZdjwb2eEllQ/1bgSIEf7CmxqYvEezrA72aKkUWjSx7kxfqunlylHEA8jwd
         U8tc8xZmKJ0wacZppjZSMLyE5nx5q/C9IYdLN3J9GttAD+Hj+Xp0NgCeTxImPwjllLxN
         zAeGeE9dnU0OLgigUpyw1kXrES42LBZRqUKLwftPP8ycsibzZ0kINIvVU8+YaOhCZiFB
         A2X9hF4/j9yoUcTwWxqlk9N75EuTkx58GJXWnLxqu4lWVlGYqED2nz24m3hLZw+5TGe1
         rH0MPc2/UHwbDEx+O782XeJ9zSWtfh07VmHLBIrLlJywmd14l/ss5B92/ht47Zx7Q16O
         8e4A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5LkNRt0d5HmwMFs53bxDuSUB5orK4uRM6IV1eiHpFRxZBDDdlX4HKtxoSFfIBp1wiVazvrfmS1vBtf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXy0g2BoTbPt9KXjAlRo7RrcB3FFJZZNrfbvwJTJpiOJa+oI0
	cTs5YKi+QCtptW7b9ZpJ3si8ktqHqlm0UzJ23avMG9gZgjaTRrAORr8bNcIi
X-Google-Smtp-Source: AGHT+IGgp/tYjenlyvreHhrTgC1PGkW7rcZCy2gP9yQh1JUqDZ0y0YSHbG2/4vzwG3V5Kdv/KCxnIg==
X-Received: by 2002:a17:903:22cf:b0:20b:7731:e3f8 with SMTP id d9443c01a7336-20c6373695bmr104753185ad.26.1728582277839;
        Thu, 10 Oct 2024 10:44:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm11826495ad.126.2024.10.10.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:44:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 net-next 7/7] net: ibm: emac: use of_find_matching_node
Date: Thu, 10 Oct 2024 10:44:24 -0700
Message-ID: <20241010174424.7310-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaner than using of_find_all_nodes and then of_match_node.

Also modified EMAC_BOOT_LIST_SIZE check to run before of_node_get to
avoid having to call of_node_put on failure.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index faa483790b29..5265616400c2 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3253,21 +3253,17 @@ static void __init emac_make_bootlist(void)
 	int cell_indices[EMAC_BOOT_LIST_SIZE];
 
 	/* Collect EMACs */
-	while((np = of_find_all_nodes(np)) != NULL) {
+	while((np = of_find_matching_node(np, emac_match))) {
 		u32 idx;
 
-		if (of_match_node(emac_match, np) == NULL)
-			continue;
 		if (of_property_read_bool(np, "unused"))
 			continue;
 		if (of_property_read_u32(np, "cell-index", &idx))
 			continue;
 		cell_indices[i] = idx;
-		emac_boot_list[i++] = of_node_get(np);
-		if (i >= EMAC_BOOT_LIST_SIZE) {
-			of_node_put(np);
+		if (i >= EMAC_BOOT_LIST_SIZE)
 			break;
-		}
+		emac_boot_list[i++] = of_node_get(np);
 	}
 	max = i;
 
-- 
2.46.2


