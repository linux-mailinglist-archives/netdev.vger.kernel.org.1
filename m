Return-Path: <netdev+bounces-247976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8443DD014D1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 07:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA5130CF7DE
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552A341AC0;
	Thu,  8 Jan 2026 06:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB279330B07;
	Thu,  8 Jan 2026 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854838; cv=none; b=A7+H6Qw2hUh/8QByyg/Uz55WMCEetRAYVeaZEwoVNT7aybrVLZOra5ABzyyf0/yIhQ6+Ff5ntOEoNPThn6od0avMyB3mnqTgGYlatS/fb7XZDytbAStfeaAcfsrck9GsFap+zA5ogO9oJAja0bXmaN8RChmfOQ2Pp8ZaNPs8k9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854838; c=relaxed/simple;
	bh=WeOCucExIjQlrwVpPEHnUCV9xwI7ryLMMNZFlVl4+24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0UGg2WKlL4uWtMABs9H2yHba3zNmsCcHBMnE9fC14dBwt3NPg598A7ZAk7uJEJ53PzfzOR93qsAdEMV4QiaQoUYQDDJYIt7o5Cl3W593Em9xQxGHNrrJBzayTE19wCgar9daxNE4aaCqEVZDwdJgGm+SOoKAXUpGu8qDeBm0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Jan 2026 15:47:01 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 7552C20695EB;
	Thu,  8 Jan 2026 15:47:01 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 8 Jan 2026 15:47:01 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id 10D811757;
	Thu,  8 Jan 2026 15:47:01 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 2/2] net: ethernet: ave: Replace udelay with usleep_range
Date: Thu,  8 Jan 2026 15:46:41 +0900
Message-Id: <20260108064641.2593749-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
References: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() with usleep_range() as notified by checkpatch.pl.

    CHECK: usleep_range is preferred over udelay; see function description
    of usleep_range() and udelay().
    #906: FILE: drivers/net/ethernet/socionext/sni_ave.c:906:
    +       udelay(50);

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 4700998c4837..a3735d81a862 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -903,11 +903,11 @@ static void ave_rxfifo_reset(struct net_device *ndev)
 
 	/* assert reset */
 	writel(AVE_GRR_RXFFR, priv->base + AVE_GRR);
-	udelay(50);
+	usleep_range(50, 100);
 
 	/* negate reset */
 	writel(0, priv->base + AVE_GRR);
-	udelay(20);
+	usleep_range(20, 40);
 
 	/* negate interrupt status */
 	writel(AVE_GI_RXOVF, priv->base + AVE_GISR);
-- 
2.34.1


