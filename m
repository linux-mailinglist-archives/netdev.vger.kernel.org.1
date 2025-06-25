Return-Path: <netdev+bounces-201089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08739AE8168
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261C74A1803
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EFA2D8DA8;
	Wed, 25 Jun 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R4hLu/Zd"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E612C1593;
	Wed, 25 Jun 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850869; cv=none; b=i7fV7xgWUxtQ6nSNdkinleE47eF2YrK/WN14hzDNLnP8fTMiJlFWHgCMuDOjQmHOGQIF50drDEfe80vGua7fzD+qmiJsDmKFlKcU+2i1ddIIkhxMbHy02tKF2oGsgLdc+zRIx3FFPGUnZ4d/Pks+qyCwJNHDZwIL53mnnlWZg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850869; c=relaxed/simple;
	bh=tUBUS8L5+iumSEl+Rz/RByPAUBdM4Q+AQKNmpgoPMtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YREr6XWoof7+D4kzE0x8UXzXt8aNVCL4lMwk8n3SmsPoL81GVkDkGMp+ABffEWGfr2hMsRQxUM47MY5pZb9wi70ucj1Dv7oPT1gFjGdatx9eKLFQDe2wqY7g8hVokULnXwd6i1kSuHhfeCLX16qrw552vaC/ryufbhCyjVZJmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R4hLu/Zd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55PBRS5j1446138;
	Wed, 25 Jun 2025 06:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750850848;
	bh=idVFkt7cnluflCOveKTDLS+cfYhjfiIZ5VvODsfNDwQ=;
	h=From:To:CC:Subject:Date;
	b=R4hLu/ZdXPB/+rrdsiPT2/WMnh4+w74/0cHDWfM50SOQlTFFGSGwOqUEMTUJEALUS
	 L/kJH86NIYEju4UAeEYzSS3+ajEDx2sPuhgvhxlpMfAS84SaFGKdjciovgeEeu83Gg
	 vw535cNUbyuW47ZV1gYOa6tl4AtDMxQqssGDNuFU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55PBRSc92620656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 25 Jun 2025 06:27:28 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 25
 Jun 2025 06:27:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 25 Jun 2025 06:27:27 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55PBRQrL3559324;
	Wed, 25 Jun 2025 06:27:27 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>, <jacob.e.keller@intel.com>,
        <jpanis@baylibre.com>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info
Date: Wed, 25 Jun 2025 16:57:25 +0530
Message-ID: <20250625112725.1096550-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

While transitioning from netdev_alloc_ip_align to build_skb, memory for
skb_shared_info was not allocated. Fix this by including
sizeof(skb_shared_info) in the packet length during allocation.

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on the commit '9caca6ac0e26' of origin/main branch of
Linux-net repository.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f20d1ff192ef..3905eec0b11e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -857,6 +857,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 	struct sk_buff *skb;
 
 	len += AM65_CPSW_HEADROOM;
+	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	skb = build_skb(page_addr, len);
 	if (unlikely(!skb))
-- 
2.34.1


