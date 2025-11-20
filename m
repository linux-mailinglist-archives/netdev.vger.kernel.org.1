Return-Path: <netdev+bounces-240495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F346BC75C02
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 540754E7AB9
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE11258EFC;
	Thu, 20 Nov 2025 17:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99236C0D6;
	Thu, 20 Nov 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659608; cv=none; b=bjXIot494OYdCePDmyj+PqgShGa4s0WQ8YNV021cnegle/eLIm+vOcQH3tYYOic7x2cXtgTn/3yPTSPwuyXERDeRS5VJPf2CFJquFnVw3edtPit7EnJTHf48zRj0p1ob/cPKI9JRVAaqOzIz5N1MXDoP8+gmb6TXNsW3A7IBO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659608; c=relaxed/simple;
	bh=b00G+EOecpV8fBd+0/uaZ2E3Shcz9iiVeFOn6ObGL7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ho7o8dKIa3OEvkdpy+vDUogsia/5LZmda+vJ97Y30nMDRFatVEBzung1luNhMbpuk6FCIwUEt62QnQfRGqFUAtzDYGRlu9u5OEqR29EgOJ6lX5kifwtoHFXQ1gyJI/fUxLvILVpqpgttQdgmEcZH+31ZZ3v5Cf1DVmJ0dGpgldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC4y747LvzHnGh8;
	Fri, 21 Nov 2025 01:26:07 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id A8EAB1402EF;
	Fri, 21 Nov 2025 01:26:42 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:26:42 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Julian
 Vetter <julian@outer-limits.org>, Ido Schimmel <idosch@nvidia.com>, Eric
 Dumazet <edumazet@google.com>, Guillaume Nault <gnault@redhat.com>, Mahesh
 Bandewar <maheshb@google.com>, "David S. Miller" <davem@davemloft.net>,
	<linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net-next] ipvlan: Fix sparse warning about __be32 -> u32
Date: Thu, 20 Nov 2025 20:26:32 +0300
Message-ID: <20251120172636.3818116-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Fixed a sparse warning:

ipvlan_core.c:56: warning: incorrect type in argument 1
(different base types) expected unsigned int [usertype] a
got restricted __be32 const [usertype] s_addr

Force cast the s_addr to u32

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
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


