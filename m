Return-Path: <netdev+bounces-240798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05732C7AA86
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15F9A3675F3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108634DB78;
	Fri, 21 Nov 2025 15:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390A34AAF3;
	Fri, 21 Nov 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740286; cv=none; b=JW5Y52d/Tqq+1QSNV+KJy+uaJRDHgz6QrE8B8IDmaCp34tdvI2wyU9zpyrHU0BuFmBZs9gZFwVc8oiucSueM0emo+3oaTvvWnbFOAUOeqPh1Fp/4FKCSywTckrQ+ytw/+8HBXOM9eN8PC71ifhQ/WjThs5o61Z5bBfTGtLba7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740286; c=relaxed/simple;
	bh=2a0j4JQ/jKsNJakb4NdDaVRPae0JCBR0EQdS8zujqv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yl2OBTFE8QfTUVBY6imFpvv965c3d6WlqSd8Ajcb3pQcevrflmDeEZhzBgSG380fMT+GlmVSwRpWRn0nFPam4ue2opYeu85FlvSj/2NhYN1ifbctbc2llHlX6f2Tspa08aK9So8js9hznlvg0bQS2UHeiToND+cY4pNXlDcdjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dCfnZ0X98zHnGjy;
	Fri, 21 Nov 2025 23:50:42 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 09F781402EF;
	Fri, 21 Nov 2025 23:51:19 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 18:51:18 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Julian Vetter <julian@outer-limits.org>,
	Guillaume Nault <gnault@redhat.com>, <linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 net-next] ipvlan: fix sparse warning about __be32 -> u32
Date: Fri, 21 Nov 2025 18:51:08 +0300
Message-ID: <20251121155112.4182007-1-skorodumov.dmitry@huawei.com>
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


