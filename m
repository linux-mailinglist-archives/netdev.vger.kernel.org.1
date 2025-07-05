Return-Path: <netdev+bounces-204297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F8AF9F2B
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B2A3AD5D7
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E2286D5B;
	Sat,  5 Jul 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cF0ow0Mk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-73.smtpout.orange.fr [80.12.242.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846123AD;
	Sat,  5 Jul 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751704565; cv=none; b=uD1w3XjAgqv5L4+P1SSsc/sysCcZN0T6bO2V2zTyS+bquUe7V50nQKQbQYQYR2BlJWbdQgyCmF6SEdTm1k317pR76do+uZ/YGbFYq8l/EMNFDFdgRtq8ThycQ43gYgrMTLXAy9HDs+Z02k6R1FzeGIpX6jmpZV9U9nx4l/f8Cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751704565; c=relaxed/simple;
	bh=Cn0VWrYKwf8V6uYejsIP+/3mvamaPCvfi5zjmIbd94g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esEzW6NyU3Um94cHsetKnqx450NvlKIXaM6SV0MSE19+Nv9537vup9JJZ+AYNNJbon/hZY9CJ/+DRoJWeHKhume+vUSmqy6qNqSRHL/7BeyNgInUwRCl8qVE2e7GWCVJzBuTUaQ793bWF+E0wBb7N7hdA8ZuM79fPNkvkofg0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cF0ow0Mk; arc=none smtp.client-ip=80.12.242.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id XyMCunIdc3HAMXyMCux85J; Sat, 05 Jul 2025 10:34:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751704491;
	bh=bZ2e0OGLx3B1xnxgJsmUQMNOM9BBR0+6G+mi7LokNx8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cF0ow0Mk+vKo0i7MXgUtpEOsNiSg/EqNpyVO5xtB2DGhRDbSJb+yPRjQoa3h+IbIo
	 Q5f7G2PnB/Uqq8/s1VsxYbEcVImyFXJmcSEivXu/6IvwWRfh8613zFQOtWm87ZDplo
	 sUzYPZMf5TXsaatv+ywMe26H0XR+DSrXCdGaEFvfmmJedqFosv3F5CeQQxAKAgVa6q
	 7HN3dvmIIjrFEHqqMWjgVYBOHGYY/e28mf3Hs31hPhZtKM6FXIegxEQNkoEf7eWm5C
	 yLGQ3RQyLknnkAxvmNLP/s7pJosT1WsjYaHlSz8GxbpNrqbpHGFj8pt980/R6/V5PE
	 j0d4uq3fe1J2w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Jul 2025 10:34:51 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
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
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 net] net: airoha: Fix an error handling path in airoha_probe()
Date: Sat,  5 Jul 2025 10:34:32 +0200
Message-ID: <1c940851b4fa3c3ed2a142910c821493a136f121.1746715755.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful airoha_hw_init() call,
airoha_ppe_deinit() needs to be called as already done in the remove
function.

Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v4:
  - Add A-b and R-b tags
  - Rebase against latest -next (because v3 now gets "Hunk #1 succeeded
    at 2979 (offset -12 lines)")

Changes in v3:
  - call airoha_ppe_deinit() and not airoha_ppe_init()   [Lorenzo Bianconi]
v3: https://lore.kernel.org/all/1b94b91345017429ed653e2f05d25620dc2823f9.1746715755.git.christophe.jaillet@wanadoo.fr/

Changes in v2:
  - Call airoha_ppe_init() at the right place in the error handling path
    of the probe   [Lorenzo Bianconi]
v2: https://lore.kernel.org/all/3791c95da3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr/

v1: https://lore.kernel.org/all/f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr/

Compile tested only.

In the previous iteration, this patch was part of a serie (was 2/4).
But it should be related to 'net', while the rest of the serie was for
'net-next'. So it is resent as a stand-alone patch, as a v4.
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index af8c4015938c..d435179875df 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2979,6 +2979,7 @@ static int airoha_probe(struct platform_device *pdev)
 error_napi_stop:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
+	airoha_ppe_deinit(eth);
 error_hw_cleanup:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_hw_cleanup(&eth->qdma[i]);
-- 
2.49.0


