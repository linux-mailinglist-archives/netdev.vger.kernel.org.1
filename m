Return-Path: <netdev+bounces-239480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF7C68AF5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2076E354FD6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DF32E15D;
	Tue, 18 Nov 2025 10:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074532C95C;
	Tue, 18 Nov 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460062; cv=none; b=Cv4JEYa+7TELtJQKlwZCc3B9qHGYYmLpKQO0TGPzdhG5W+5GSm6L9bTdUodqnlgskeXh+zlgjOoTOKBu0cEAXvgIXHA60kHg+g1nasyafGNQ8KTBBJJIc91lPejMeHyNlYRSY7/9Ug4T5i0mm9OXxYROja5UdVU621t3U4OQrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460062; c=relaxed/simple;
	bh=zlQRJq7Ynh96NJwkubG4y2Vw/ze2BoLs+5JXTLgg/YM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wl0QrtSHdL0mjRCx25eFxvVqFJNaRcnmV+bzl6x+R9n3N5x2/uJL3CTmw53Cz7QWqSjac7zU6KYP9z/z1yYp/EeHjde8g5CxWGI4XwY0pSx9yIuinNiViIFlvak+TPiAXssTqzWW+yBUiOGwjKMJZAbmd8g9OWzn1keEid1TgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9g8c4kZwzJ46jP;
	Tue, 18 Nov 2025 18:00:16 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id B285A1404FE;
	Tue, 18 Nov 2025 18:00:58 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 13:00:58 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 05/13] ipvlan: Fix compilation warning about __be32 -> u32
Date: Tue, 18 Nov 2025 13:00:37 +0300
Message-ID: <20251118100046.2944392-6-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
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

Fixed a compilation warning:

ipvlan_core.c:56: warning: incorrect type in argument 1
(different base types) expected unsigned int [usertype] a
got restricted __be32 const [usertype] s_addr

Force cast the s_addr to u32

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 97107d9ce20c..f3f34581339c 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -53,8 +53,8 @@ static u8 ipvlan_get_v4_hash(const void *iaddr)
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


