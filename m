Return-Path: <netdev+bounces-190835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9806EAB908A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446A73B53BD
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0D27990E;
	Thu, 15 May 2025 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XiJhictn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17584263F5E;
	Thu, 15 May 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339753; cv=none; b=WHouqGnv7erKwAGHR9DSOEntWG/7OZwUbBtj+TUtn1undMipsuANkzJ6mtmH3S2RZoAefGSHf6t2jfRe+aalf6wASyNwabQEXhe+ue6guIW/ihWjbEEBf7wpn6c4zQFheeYEpBxixCaXlXMSMM/0Ncp4E0hzcQYh8RGQB+ww/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339753; c=relaxed/simple;
	bh=pM2/rituVspNE/+QanIb1bltePIE1U38WpgjrA9ee7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTDqEMOtx+W6QM1u/R5hwg/Hqzas354aNywAhJP5M1QC6cDcrnxHEM60kjzz3NBoUkwga3ZXnFkJePBT6hMik0PkvcbuKW67hD63o3nwhzw0hSxfJD7JylMAHDOm8x7clYT/ovbsCmpuhUma72jZfKEwEim8xxAUd82E5FTH4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XiJhictn; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id FekBuCN6oIqMPFekPugntG; Thu, 15 May 2025 22:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747339205;
	bh=9VMO2LRAf5h7BkfuRnV9EKcKqpImVHbFdSRbz9p/Fnk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XiJhictn2UmnfDfwrcC7D58HZGUBO8mKzeldPQxn8LDJsMx1wkOQU0MsiB2KZ4kVq
	 10Hpw2xwF782/Y60WN+CecmMDvWrLnwZAedpEgS8YXF9mOQaiWpSL9Fk5tQv/if4Jh
	 JhMWHyv7/L6yq0f7u5++mrly6T1MKrR/AzXVkGVIG1CPfdi04kP3nMANLrD1mTs7GX
	 9IOmsrTgI2+4DpSvDPFb9Gpeohr2UOl1Fxm6YoUHwSjbD6NEMIWIzsjmFd9gcz1IcH
	 OodvnwXtf2upn8ytmXrc/FcEhP19RVn0MYJl3CLNu5Jj4GG1U3gz9wwNQX2pFHd3hY
	 MEt5YKsE0SL1A==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 May 2025 22:00:05 +0200
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
Subject: [PATCH v3 3/4] net: airoha: Use for_each_child_of_node_scoped()
Date: Thu, 15 May 2025 21:59:37 +0200
Message-ID: <38143a6af2fb32046c92b5ba81d8e08c55426ebe.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
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
Changes in v3:
  - None

Changes in v2:
  - New patch
v2: https://lore.kernel.org/all/88143d6af26b32066c92b5ba81d8e08c55426ebe.1746715755.git.christophe.jaillet@wanadoo.fr/

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


