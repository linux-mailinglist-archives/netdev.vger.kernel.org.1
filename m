Return-Path: <netdev+bounces-46398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0BD7E3B60
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C8A1F21756
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DD2D7B2;
	Tue,  7 Nov 2023 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="euHsOw7p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CC1FA6
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 11:58:29 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736A129
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 03:58:27 -0800 (PST)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231107115824f32b912308a34441c4
        for <netdev@vger.kernel.org>;
        Tue, 07 Nov 2023 12:58:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=T0U1ehnEjbJ/WZ+hydu7gZvoFo6UcN15DJYXnc+ncjw=;
 b=euHsOw7puSIQYsJs0NVY2XcgVozNDK0WpYmQQJXOZAiBUnhhlZhWgqej1UJiqccC5SOrP0
 izc6aTU955IGCGurhmAhJxP0klERjVPxcCTkk7/s5Oh2sIH6Oo2tfD9hBFp9I3e3/PXinvjA
 2YEiZcXVpTNP9OsQZ3ILcO6KPyuQI=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	danishanwar@ti.com,
	vigneshr@ti.com,
	rogerq@ti.com,
	grygorii.strashko@ti.com,
	m-karicheri2@ti.com
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com,
	netdev@vger.kernel.org,
	baocheng.su@siemens.com
Subject: [PATCH net] net: ti: icss-iep: fix setting counter value
Date: Tue,  7 Nov 2023 12:00:36 +0000
Message-ID: <20231107120037.1513546-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Currently icss_iep_set_counter() writes the upper 32-bits of the
counter value to both the lower and upper counter registers, so
fix this by writing the appropriate value to the lower register.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 4cf2a52e4378..3025e9c18970 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -177,7 +177,7 @@ static void icss_iep_set_counter(struct icss_iep *iep, u64 ns)
 	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
 		writel(upper_32_bits(ns), iep->base +
 		       iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG1]);
-	writel(upper_32_bits(ns), iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
+	writel(lower_32_bits(ns), iep->base + iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
 }
 
 static void icss_iep_update_to_next_boundary(struct icss_iep *iep, u64 start_ns);
-- 
2.42.1


