Return-Path: <netdev+bounces-124777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9396AE01
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C592867AC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12704C2F2;
	Wed,  4 Sep 2024 01:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC526FB0;
	Wed,  4 Sep 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414096; cv=none; b=WXhS3iI3phxErs3vskl95EzCb3reOTIpwIQurvWs6Ek3IVDCfA7YAtVUwtn5Cuq6vm2fNkXdl8yCgwsR6++CXwV1yg3UfaxptFXa5qhHRguXKgNPXY8IndAgd4xFNy65EwZ3jyht0cmk0CeYGYbMaXRAguPvK1RIhs26eEEDEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414096; c=relaxed/simple;
	bh=vz+2uzOAuKiK2Hy6nY/X6Bn4ROHbWI9apDYSJefU4SY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VjPin7bQzKajpSBHZpHe82vS/0MKIhJDzH9MKfEZoVlPjabDuQVOOf4+UyHs0vuvhje2NihofI3nclIECHCVkErGei4KWMUnUr6vgpewyB6BPyYqzw8nqQx+1S+dRVseRQzM+D+YmpglqbPZb24GHFp4r74zV3DV6kq2ak5YKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wz4vj0BgSz1j87V;
	Wed,  4 Sep 2024 09:41:05 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AC9341401E9;
	Wed,  4 Sep 2024 09:41:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:41:24 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
	<alexandre.belloni@bootlin.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kees@kernel.org>, <gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] net: dsa: felix: Annotate struct action_gate_entry with __counted_by
Date: Wed, 4 Sep 2024 09:49:56 +0800
Message-ID: <20240904014956.2035117-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add the __counted_by compiler attribute to the flexible array member
entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index ba37a566da39..73d053501fb1 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1733,7 +1733,7 @@ struct felix_stream_gate {
 	u64 cycletime;
 	u64 cycletime_ext;
 	u32 num_entries;
-	struct action_gate_entry entries[];
+	struct action_gate_entry entries[] __counted_by(num_entries);
 };
 
 struct felix_stream_gate_entry {
-- 
2.34.1


