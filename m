Return-Path: <netdev+bounces-124162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3309685A2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B13286785
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841F18592E;
	Mon,  2 Sep 2024 11:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48497347B
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274952; cv=none; b=Azhz/trWiSBi/hnwbXo0c4Q0VEDM6ziOvdCm1OQLtCDN2+ZatceGAQogLkUI7VCO2x+uKEdDoPFxrZhfGIn+9qJUKLpSOpjouhG7WQCueIRpeNWhxcXkeJuLhRWlHR7xUPEMtEPA2xPIXm6WUcTZ1Fa7OA69cPbVYqUOvchmJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274952; c=relaxed/simple;
	bh=bUJ4Lmy82f9DQ42QsZ7TRuD9XhnhvLOuu/xwVZxZEak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hapkJkLfKkzpZlUCxaPSHMTsG83jq/uEtn6dqPOgV8ylnvmzAjdQODHSxuqqkbyM504T1Wwya2pnGD/z6BlkEZYHq/Z0YWt+2DmZx4a2R1dmCXedPz3ZQbx/G4ny/b/8L5Y1qj8ZpPcEeayHr5wvf55Z0dZX6jrBSomf7DV3e/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy5Lj24jHz20nNX;
	Mon,  2 Sep 2024 18:57:33 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C3441A016C;
	Mon,  2 Sep 2024 19:02:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 19:02:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <christophe.jaillet@wanadoo.fr>, <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] netlink: Use the BITS_PER_LONG macro
Date: Mon, 2 Sep 2024 19:10:52 +0800
Message-ID: <20240902111052.2686366-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make it simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/netlink/af_netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 5b0e4e62ab8b..e369980e30e3 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -19,7 +19,7 @@ enum {
 	NETLINK_F_STRICT_CHK,
 };
 
-#define NLGRPSZ(x)	(ALIGN(x, sizeof(unsigned long) * 8) / 8)
+#define NLGRPSZ(x)	(ALIGN(x, BITS_PER_LONG) / 8)
 #define NLGRPLONGS(x)	(NLGRPSZ(x)/sizeof(unsigned long))
 
 struct netlink_sock {
-- 
2.34.1


