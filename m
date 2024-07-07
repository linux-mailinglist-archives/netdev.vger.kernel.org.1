Return-Path: <netdev+bounces-109684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3999298CB
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95131F233BF
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9D3F8F1;
	Sun,  7 Jul 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="jfVMmP4R"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19D2E3E8
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720369047; cv=none; b=umdH5dz3lo2j7cI/IM8hGn5EmysXfhnPpczJ3dsF1zlL8eNvPjg6zGdP8N5lkwpnvgE7xphHRvffO8pDJqsFJPLwX5YKmebY8FmUqqV09v2PR0+5eRUQB4B6H4TUp/pRul5cm9mBo33KoWMNVw7pHhHb88wzi9xp30vgZjXdP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720369047; c=relaxed/simple;
	bh=Ypg8gp/D4iemXgpjuuQlmklQUpAwSkbacxj8LYyasN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nH3GGAFc6z/LZmI/FrwV59SZvDjwe+DlkekL1frBNTWUPeMGSfY2eWvTwICccg7eWbvCmwtrucr2wXrkTVxuHTJRzbugZCHMUJ3ppbtH/MZG5uwmiH5ueBRYcc8WU+dwqFZHyP8P1zoEfK6JRtf5nsVI8qWHviQ6kd0VT1ZFO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=jfVMmP4R; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 7077 invoked from network); 7 Jul 2024 18:17:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720369042; bh=IMNlr614g68M9kRzk9PBlas2EwOEEWQ13OgX9uD/Z5s=;
          h=From:To:Cc:Subject;
          b=jfVMmP4RMW5ge1xWtaxEbcGKs171v7sI1X6wnR0EOJOD0DzffBuCwIVKxnBZwEmSX
           /cGPRH+6sUAz4r7LyRHtzKW37rDS/RxK1/OoNAO3dF871yYGGBoLseBeK7ZwtonUBM
           WvSzf/GnmXnqq8J8hwaJ+PiiPwB9dtsfmW8xW1PI=
Received: from 83.5.245.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.245.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 7 Jul 2024 18:17:22 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de,
	olek2@wp.pl,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH [net] v2 1/1] net: ethernet: lantiq_etop: fix double free in detach
Date: Sun,  7 Jul 2024 18:17:13 +0200
Message-Id: <20240707161713.1936393-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240707161713.1936393-1-olek2@wp.pl>
References: <20240707161713.1936393-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: efe9c2d3e8557673fba190ec7c1f9b39
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UePk]                               

The number of the currently released descriptor is never incremented
which results in the same skb being released multiple times.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Reported-by: Joe Perches <joe@perches.com>
Closes: https://lore.kernel.org/all/fc1bf93d92bb5b2f99c6c62745507cc22f3a7b2d.camel@perches.com/
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/lantiq_etop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 5352fee62d2b..2a18e473bac2 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -217,9 +217,8 @@ ltq_etop_free_channel(struct net_device *dev, struct ltq_etop_chan *ch)
 	if (ch->dma.irq)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
-		int desc;
-
-		for (desc = 0; desc < LTQ_DESC_NUM; desc++)
+		for (ch->dma.desc = 0; ch->dma.desc < LTQ_DESC_NUM;
+		     ch->dma.desc++)
 			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
 	}
 }
-- 
2.39.2


