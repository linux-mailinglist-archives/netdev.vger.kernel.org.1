Return-Path: <netdev+bounces-245738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54881CD6A17
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 17:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE673022AA2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D856326D4B;
	Mon, 22 Dec 2025 16:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306127A103
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419728; cv=none; b=RLfBpVax+FyDW54y/1+wqskO0eunp0Jbmk8Xj6zX/xd746t8ClSgj5e9bsl3OMLb315UqDowqIJotWjR5anGbYZglH6DlfTm8aNJZvt4Mt3uGcq8XzcWDFcdeS00gzNuWquXZfbp7XkLNALlfpctDX8wOxxW3JHuHHmGt3Wr9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419728; c=relaxed/simple;
	bh=XP/dY8RnNlz7cQ91LtEg5lUtZbiwBCSohE3LI9cBdQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vkn7gVf0OI2NKGl337wcMkNTUoJCEjfDVvz+gqt/lHBpOnSZj9BYqyPXnk4VjyvmT2wvqD+tnnG2zuXI+iALLiO7vLPz3THkRJaF5ETObrbI4mA5bVPFdZ3ad0ilssHK7hSFiVo6Czkw69mLu2LGiv+i/ykVd2N1rs8xqdzjwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6d3676455so1873933a34.2
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 08:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766419725; x=1767024525;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyZg86sigq1gMHsuNeTho1/FwyX760bGjSc75ceM6vw=;
        b=o1mqSScQYbvNmb9swCIV5TA/RLDZ0p9FQvOnSteMx2omlJ5p59WJWg9MaJweCzP7f+
         qfidItzJMiuWX5VvOI5bXqWkA2lcClYPv2tzTej9cIx7O/YYnX4Jak0qnO4Y1oYtOivm
         G/D0wDD+M2s2ArBPBp3fQfxp2DNTGRaKu0jSrqnesyrPXvY07UuL9GIGjrFDqfiXbUuh
         vjracitxCqQCe9J3NvkB26GHAD3RlE80ECySSUAEZzLk1cv1BIiYdP2OlROdTuZOis1/
         49P29Z3JofCW0qQXB9RAvsMQTAY2+pymRQPP6beY4qHUX9PUrfIb69MvAY4z0GpJ/Fqv
         8xXQ==
X-Gm-Message-State: AOJu0YxrnX/3Bug5D7wAyTIKfm56lOll468nMFWJ35cE78IwVzyc2wYE
	Z6wWkIfz0/e96Ubnug0dDKwF6waupjfxokJuBZCJmFpM8f7lNTcDtqWP
X-Gm-Gg: AY/fxX5Vt22y+PT6Fi7h1+qEgiEMYRa0HR8h9kgMCKloyOc6QUZbSmw4QDyHyRh+3At
	pjxDYQRs9ROadLfAQzftBjUh6Urddd/jrBQE9zsm7MptICQyDx4ep0AQvGWW4njWZWYEdutQVYN
	fu1/B0vvyJIbJt4I3jUUa0Ll4s8+ameA/WYUy6QYA03RDRe5jOXJU3E2ONpUiR4sDxJfwIinS3F
	fYSxHYeHdev4l39EypPBOL6mC+qlfpNWKOyjyfJbuzbztKRtLozLuqkvidINKaxO299M1mP4ypH
	0+zHSTuGWtuY+ycbuxwNFuA9atc3JQuU/5kIcbbYHCJWbMCy1PEw845uz/fqiv8aIs3R5y+duqf
	LxKlUI16SOezUrOyxhbkE1p/stLGSFnptI6CNlPMdbkAVmDNwLispfHRp/8S06FHviY9kQmoHgB
	pQyQa2XAFMIFSjFQ==
X-Google-Smtp-Source: AGHT+IGV9jTfvLuDHm6IUAINCmnrI/nMYseqUSC5TAOi+jja5agqOaacIYROhfs88S9nISNt7xZ/ew==
X-Received: by 2002:a05:6830:438d:b0:7c9:5a1d:333a with SMTP id 46e09a7af769-7cc667f3d57mr5586499a34.0.1766419725107;
        Mon, 22 Dec 2025 08:08:45 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6680358asm7793046a34.30.2025.12.22.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:08:44 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 22 Dec 2025 08:08:40 -0800
Subject: [PATCH net-next] net: stmmac: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-gxring_stmicro-v1-1-d018a14644a5@debian.org>
X-B4-Tracking: v=1; b=H4sIAAhtSWkC/yXMQQrCMBAF0KuEv26gDVokVxGRNJ3GEZzKTJRA6
 d1FXT94G4yUyRDdBqU3G6+C6IbOId+SFPI8IzqEPhyHEIIvTVnK1eqDs67+0E8pj0tO82lE5/B
 UWrj9wjOEqhdqFZe/2Gu6U67fD/v+AU0f2wJ8AAAA
X-Change-ID: 20251222-gxring_stmicro-40bac6fcad86
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=leitao@debian.org;
 h=from:subject:message-id; bh=XP/dY8RnNlz7cQ91LtEg5lUtZbiwBCSohE3LI9cBdQU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSW0ML0A27ygUM+WxlW7UZuOgWF9A2oO34iVxt
 5+BqpDIdIWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUltDAAKCRA1o5Of/Hh3
 bYabD/4yHWJBxsgp/SieMEC85QSre8XYNcjUQGQSaXsb2FhE2sw5AfC/tz1gpWD3u31nFmsHzjs
 ZvsAd3vBCzuOZFQ6283RyqgIgvtnc8cCBFmfl5LFq6CWGOCwZH2hLJv+0pCB+NBHrcr4eBUsbSt
 x3Udr7nTZhsUhasX2/GtOITpRiA/uljSyx9iyA6+yRiOaUxR9ug7rfwFqodkA9WlNmENMXFV/1X
 K0oBL3oSeGvpWyShDaZ7Ip7jfPC5JjK8pseksKMs+cVe2/rgWXSOJ3PW2SaRqiGAO8Rt+yu6B/d
 xqaMm3GCo1Gg7kbudJEavDT0lJUl9VtaY/mw3R7rU+NjEcBqIJPA+Kf8sZVG/OBYhOXYf/SMMIa
 vkgQh1WixjXSZ3j1OsqMSHx1e86566z361Q56LndWJvu1DvrHpkg7t6FNS1vcsGpKsZ+UVFnKKd
 vTTclUMc8EFxuIk0qzdJIwz94FNyAbwhJffg4w8wiF7TSH4AlumCTW/1Fu3jkmMDGF/juiMfO24
 bYLOJ7lHNGP/cVe2wb23mvXvRSLrB13RoMUihQ+Ky3VMAj1+gX0dL1nPtcqO7lX6AAHqVbmjSlY
 NxEwpqkqZj7fU06EtVPZWAjcLW+nhvmTYm5jh6Dolm4wFA4AC792zBRatMT/NDPxh/xM6FnE1LZ
 tlZxvb7IAvsIdYg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the stmmac driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc for handling
ETHTOOL_GRXRINGS command.

Since stmmac_get_rxnfc() only handled ETHTOOL_GRXRINGS (returning
-EOPNOTSUPP for all other commands), remove it entirely and replace
it with the simpler stmmac_get_rx_ring_count() callback.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index b155e71aac51..c1e26965d9b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -914,20 +914,11 @@ static int stmmac_set_per_queue_coalesce(struct net_device *dev, u32 queue,
 	return __stmmac_set_coalesce(dev, ec, queue);
 }
 
-static int stmmac_get_rxnfc(struct net_device *dev,
-			    struct ethtool_rxnfc *rxnfc, u32 *rule_locs)
+static u32 stmmac_get_rx_ring_count(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = priv->plat->rx_queues_to_use;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return priv->plat->rx_queues_to_use;
 }
 
 static u32 stmmac_get_rxfh_key_size(struct net_device *dev)
@@ -1121,7 +1112,7 @@ static const struct ethtool_ops stmmac_ethtool_ops = {
 	.get_eee = stmmac_ethtool_op_get_eee,
 	.set_eee = stmmac_ethtool_op_set_eee,
 	.get_sset_count	= stmmac_get_sset_count,
-	.get_rxnfc = stmmac_get_rxnfc,
+	.get_rx_ring_count = stmmac_get_rx_ring_count,
 	.get_rxfh_key_size = stmmac_get_rxfh_key_size,
 	.get_rxfh_indir_size = stmmac_get_rxfh_indir_size,
 	.get_rxfh = stmmac_get_rxfh,

---
base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
change-id: 20251222-gxring_stmicro-40bac6fcad86

Best regards,
--  
Breno Leitao <leitao@debian.org>


