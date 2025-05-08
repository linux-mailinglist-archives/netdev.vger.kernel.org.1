Return-Path: <netdev+bounces-189015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8CAAFDE2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E484E6994
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DEF27A139;
	Thu,  8 May 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ku7444au"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCA2798E4;
	Thu,  8 May 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716068; cv=none; b=XZXkRjJPltJNrxvNBCfAZhMDdYw45J3COl/tdbjIF+lVODsJ+CJ7T33+PBl3uA5vrYUQXL/Z3Cr4fNGAM+2R7XuwVFEmRlF7W6IEQAdCr1nj4Hms0P43ZbXXH8dBWH8wvCh/6hsC6COMMZC75GhYfCrbcUxioN7l3eLaxs4DmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716068; c=relaxed/simple;
	bh=M5PGQ/81FcXsM5OrfduFnyxRkv16lPBzhB3xz9YYNQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6NiwE9gWJo3kpumpUxO92xcPGV1mOTL4KJeHZN497oVgOOJUnMD1iqbNzGc+kRzDvxS+HmewajKx/vwSfQqhgM3VHYPSn1+WeAojjKeAmIgJlEZelkOJf1SWX7UwdjVa5CzS2CPZ5XvD4UTyZ2l0rivEC8tI8jz3YJvupzGrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ku7444au; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id D2cYuomdl816KD2cjuwCox; Thu, 08 May 2025 16:53:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746716001;
	bh=zfJ0cCHapeNbyNAgsQ8Z4q12xaRaql+ZZwG0MaR9T48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ku7444auv/NyhVOhgZW5hxKgFMj295PSUl9uFoLDmzbekZTo1iBYoddoOQ5F1alUm
	 8TVBJiRkpI8kinjpS7CqesW8BkNWl1tUcWhQQwQv8EMjbSwXJP/IifAa8to6Eoid5C
	 1x9hDbDhXlKnvu+ei0omsFqHeXlsdG0PmU0POOdIqyQu9Jp/3mF4FVbBf4L5sJHtVF
	 CQPxYyeewZMIIg22zlZS4zPbO8qGnTQZ2gVhEtwTXcQ+d9W7QFu0Mur6Sj6uTdHR1O
	 4l494WCLcLPAze8TmRGdADIG6DI4CJWKutsQqCxqTFGUos9j0IkF4igF8KWnAFPrMr
	 bJO/bq5le0bew==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 May 2025 16:53:21 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/4] net: airoha: Use for_each_child_of_node_scoped()
Date: Thu,  8 May 2025 16:52:27 +0200
Message-ID: <88143d6af26b32066c92b5ba81d8e08c55426ebe.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use for_each_child_of_node_scoped() to slightly simplify the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
  - New patch

Compile tested only.
---
 drivers/net/ethernet/airoha/airoha_eth.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d435179875df..2335aa59b06f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2886,7 +2886,6 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 
 static int airoha_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
 	struct airoha_eth *eth;
 	int i, err;
 
@@ -2948,7 +2947,7 @@ static int airoha_probe(struct platform_device *pdev)
 		airoha_qdma_start_napi(&eth->qdma[i]);
 
 	i = 0;
-	for_each_child_of_node(pdev->dev.of_node, np) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
 			continue;
 
@@ -2956,10 +2955,8 @@ static int airoha_probe(struct platform_device *pdev)
 			continue;
 
 		err = airoha_alloc_gdm_port(eth, np, i++);
-		if (err) {
-			of_node_put(np);
+		if (err)
 			goto error_napi_stop;
-		}
 	}
 
 	return 0;
-- 
2.49.0


