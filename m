Return-Path: <netdev+bounces-201403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F8AE9513
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EE91C270F6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EDB202990;
	Thu, 26 Jun 2025 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xAT64G2u"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5919D07A;
	Thu, 26 Jun 2025 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914765; cv=none; b=rwx4IaW3ZNloYQg2tj0uReudcUPx5qyfpJtiGMwjFK7cZi375RtCjiWJexu40oaKAE9YGK3NUUGrY4KRrJ+zagP5Rys+9FZk2cXyLbI5vVWeRhCc1477jWwhtZ3cHPGAEJbCqmQBOpsnZ/myTLpk+pC6Psno0qmz1i8lbQgcYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914765; c=relaxed/simple;
	bh=GK9PFc4+ENomB3smPxI3RWkAIBy0mRwcazR32hNudzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fo6hH9Vz1FWFJlC9LFvZL1Eu7Ho0kL3q/t75WDBJzd2S8AEABeJD6bmMBlRzPd822KI2ran89QJnW03956KEEIdbjOd2+ZMFCnWXz/lPaANkCDfd37eWu3EivM8TeGxuQUBEMfcXFTNINGpQEjZnXAp3avn6sjC65FUOfiFBg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xAT64G2u; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q5CTOg1647971;
	Thu, 26 Jun 2025 00:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750914749;
	bh=RsKjgIvdpHJg3gLCjdxUcehR+v57g5h4k4rBcDGpB7o=;
	h=From:To:CC:Subject:Date;
	b=xAT64G2uPgZW/rEA0mENQUtBN/eOvi+aSdxp+NAzHeEtGQVVgK+y52IDESfOCbGgF
	 vFzsh+hfQLJsonUblgrKhUWZs4kR6eJbkPKfjJi5pyimzUXqJxRgud1QBhVes4rsdQ
	 pRrM894ChAoQ4fAk6GnrQs+91eAdwl7hz4CcT/kQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q5CSsA1670831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 00:12:28 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 00:12:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 00:12:28 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q5CRJD419823;
	Thu, 26 Jun 2025 00:12:28 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>, <jacob.e.keller@intel.com>,
        <jpanis@baylibre.com>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss: Fix skb size by accounting for skb_shared_info
Date: Thu, 26 Jun 2025 10:42:26 +0530
Message-ID: <20250626051226.2418638-1-c-vankar@ti.com>
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

While transitioning from netdev_alloc_ip_align() to build_skb(), memory
for the "skb_shared_info" member of an "skb" was not allocated. Fix this
by including sizeof(skb_shared_info) in the packet length during
allocation.

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on the commit '9caca6ac0e26' of origin/main branch of
Linux-net repository.

Link to v1:
https://lore.kernel.org/r/598f9e77-8212-426b-97ab-427cb8bd4910@ti.com/

Changes from v1 to v2:
- Updated commit message and code change as suggested by Siddharth
  Vadapalli.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f20d1ff192ef..67fef2ea4900 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -856,7 +856,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 {
 	struct sk_buff *skb;
 
-	len += AM65_CPSW_HEADROOM;
+	len += AM65_CPSW_HEADROOM + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	skb = build_skb(page_addr, len);
 	if (unlikely(!skb))
-- 
2.34.1


