Return-Path: <netdev+bounces-134691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D899AD38
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AFF1F27829
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819E1E9079;
	Fri, 11 Oct 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu7ISXP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7521E766D;
	Fri, 11 Oct 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676598; cv=none; b=EXMKb1GijsNm1R0GpNogSUUe3yCbD16v3r4KGmP8N4rqEF8xSnJk7z57aGjI+5jX7jFBHAUE5tqqXtjJ2NM0S8pDgzB9d7h2QbMzIFFKo1Dx/CzsoAeBdtlRGZeOhjnBuYJLn4nrN83OjVyU3h17soRVZjUka8667f32KS443fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676598; c=relaxed/simple;
	bh=Q+2VmB7zmwm1vNofxnzfIwwJAhE9qy4N4+vT35MU/DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVYFqG3n/LcK/VyYRtnr1h3cXY5zjtG5CAt9dthko+MB4NHw2PvowIQHpmqVv3ZN/+VIoT3UDsaC+HC43ZezTLbAts+sX6zP8AzX9LCCizI9BSBmxexmDw2oJu7kBIjgz10epPP7vtrfqm1fmeSPGmYByZ/MNQj+b2iz937R+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu7ISXP4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71df468496fso2228028b3a.1;
        Fri, 11 Oct 2024 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676596; x=1729281396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8hI452n5jGYTy09LuqtDFWI02BUPHpDd5D1l/Si5SU=;
        b=iu7ISXP42LWfEzeZgWIZeK/ZNsRY6kxXO3DroVp4Gxhxz+09s6cmRNiTmMGG5+sjZ1
         MGzpg4shHHbsbIzSgeNFjgEQo0+45rZBkpBxVUVhctL8JS2R2vltBYih2/DRD6YFy7Cf
         WqvMMq5V7qe7PELECoU8HUBSr+IrgX+IwuM0d8yJ0j61+Wv5jX3ZZQ9FoLRJWkoYBz40
         JBnJyEZON3sJJH4FsKbQBGS1lClgwb60yYzp+YeC4iOtl5q+Q01T+iCvuYxSsT3bS/Ht
         W4ullV8bRTkDF3wwuN1u+GiBHrdoAIeoUUK8a2vSJHJi3FWU2uaJBXSkGsSKnuJZ0FTM
         aSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676596; x=1729281396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8hI452n5jGYTy09LuqtDFWI02BUPHpDd5D1l/Si5SU=;
        b=q2PrS76xvNtEOHkr/qFICDmQ+nHCBvWYdTWRf/9XqUUMUJoEWOOLlhOEi/e6CoXuod
         /D7abM63/ACUTlV/GIks1Vd0MM9Hupv23ktizm9dqia9xCGVIKxbhuuxYAjo+S88dJf5
         P3aRyBUXKsvDYF5HAG0DmK+ibYuzdBndsGH332zP9P8XX8GE3pk7dDDFIvYhsCHHZJby
         6AdpBevQoyHoNtqLZJfOZTIADAbZ7S+iOshPWkvk2rtO9d9gZQYUh9d9x2FS9C7TXF/n
         WKAvaDbULBGUSnQrHjKaeETbITnf++Bf2ZZI1mSn/xXhuTy5eA6hO9xalcxjQFvOZeOp
         ayrA==
X-Forwarded-Encrypted: i=1; AJvYcCVesPNkCuFdV8PL7XiIOPDx4tZH2bvuC/GSG8kSlX5JdtSQBaoSlt2V1T2xnOY6GT/AKJDeQ/7l9q+0n3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2sOGB4TerUqwoLXbhFuNUPt3M0pKE/NN88PJ7F++vG1ssBC2
	HMVfk6b+VO34XWVrqFF4xqYVdmcwlIEqST72irYm6XSw/PygiCauxqMv/3v7
X-Google-Smtp-Source: AGHT+IGJVzIq8XjXkrMRO8UiphyJSQ5kK/ZaUXkNpMjkU8CBPHmpUJoc+tx8Q3qJizT56BjCuoKyDQ==
X-Received: by 2002:a05:6a21:6e4a:b0:1d8:a9c0:8853 with SMTP id adf61e73a8af0-1d8bcf3bd6amr6957438637.23.1728676595598;
        Fri, 11 Oct 2024 12:56:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 7/7] net: ibm: emac: use of_find_matching_node
Date: Fri, 11 Oct 2024 12:56:22 -0700
Message-ID: <20241011195622.6349-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
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
2.47.0


