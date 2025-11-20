Return-Path: <netdev+bounces-240492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D922C75887
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6266929F87
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38F2FB0BE;
	Thu, 20 Nov 2025 17:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411B221577;
	Thu, 20 Nov 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658264; cv=none; b=ZWCPUagNRPlWkDSTA6sz+VBd5lfShH8hFpZpk5lTHlK8GJxy7q5RiMmlk95QH4wZgBVRoO7dxRkJE8y1w4cRlNlRpDJWovH46FyldKBdODBILht0AcZHV4wyXXc1ikGp5yTG7D5jRsgJ+ADRGgdDsFwY7+0xkQSxUbrxLLoiA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658264; c=relaxed/simple;
	bh=2a0j4JQ/jKsNJakb4NdDaVRPae0JCBR0EQdS8zujqv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWUsCFIlLebuvUqhda+z7Zaozv10JZfupvTll0qh0iI9grepnO/9uSAYCDl2OKvrq+GL/Rp3WImj7oAB0U6oHJazcVNqpqc+bGHi9+WoFR/Sd5WXWwNhw32iRPy333xDPr6TXkTU7s4H3oKeuxggVD74p16I8HolRdI2vR9JR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC4Rz1HZqzJ46CH;
	Fri, 21 Nov 2025 01:03:27 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id EC80214038F;
	Fri, 21 Nov 2025 01:04:12 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:04:12 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Guillaume
 Nault <gnault@redhat.com>, Julian Vetter <julian@outer-limits.org>, Dmitry
 Skorodumov <skorodumov.dmitry@huawei.com>, Eric Dumazet
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipvlan: Fix sparse warning about __be32 -> u32
Date: Thu, 20 Nov 2025 20:03:57 +0300
Message-ID: <20251120170401.3811591-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Fixed a sparse warning:

ipvlan_core.c:56: warning: incorrect type in argument 1
(different base types) expected unsigned int [usertype] a
got restricted __be32 const [usertype] s_addr

Force cast the s_addr to u32

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index d7e3ddbcab6f..dea411e132db 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -52,8 +52,8 @@ static u8 ipvlan_get_v4_hash(const void *iaddr)
 {
 	const struct in_addr *ip4_addr = iaddr;
 
-	return jhash_1word(ip4_addr->s_addr, ipvlan_jhash_secret) &
-	       IPVLAN_HASH_MASK;
+	return jhash_1word((__force u32)ip4_addr->s_addr, ipvlan_jhash_secret) &
+			   IPVLAN_HASH_MASK;
 }
 
 static bool addr_equal(bool is_v6, struct ipvl_addr *addr, const void *iaddr)
-- 
2.25.1


