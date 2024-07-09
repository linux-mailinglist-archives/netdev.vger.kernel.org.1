Return-Path: <netdev+bounces-110220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A114492B5D6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A5F1C20B2A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD83D156F30;
	Tue,  9 Jul 2024 10:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD3156F27
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720522162; cv=none; b=KNZdJcBP4km7/IaEd8IMBjIXu1dregCeq7opvkfuaihSaRQCg++UvlRNp4C8ATXpInXMhOImuOOJ+bKLkJT3vg1VDsv/x/p79ImrKGwC367cyvGUM9Kpztfgtk6jvCT7096lj2dv8sKijBjWxQx6MTr1adic3OqMQ9sm2weFFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720522162; c=relaxed/simple;
	bh=v1qiOxk10iyLpU7iRXpFXmVdnH2cxQoxw0GyWtCKKo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUNV2yo92GEaJmlUEOYXjhRYERJoL7xxV6nmePwKKd+4CcEMo2eD71V8JTEdfoM33jCNdCMr4L5JAalofPS7tHO1T72bVDCDKNsNkFcXSUwCwABYpsqfX+iXGpIHZR3FxwNj7ojBxeBHH8qELuM2VBzQHd2X7Uwlr7/B+g9zgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WJHkc4SClz1xtTy;
	Tue,  9 Jul 2024 18:47:36 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id EB2BF1A016C;
	Tue,  9 Jul 2024 18:49:11 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 9 Jul 2024 18:49:11 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <dhowells@redhat.com>, <marc.dionne@auristor.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<cuigaosheng1@huawei.com>
CC: <linux-afs@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] rxrpc: Fix the error handling path in rxkad_init_connection_security
Date: Tue, 9 Jul 2024 18:49:10 +0800
Message-ID: <20240709104910.3397496-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200011.china.huawei.com (7.221.188.251)

If security_level of rxrpc_connection is invalid, ci should be freed
by crypto_free_sync_skcipher, replace error with error_ci to fix the
memory leak.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 net/rxrpc/rxkad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 48a1475e6b06..104bb1ec9002 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -125,7 +125,7 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn,
 		break;
 	default:
 		ret = -EKEYREJECTED;
-		goto error;
+		goto error_ci;
 	}
 
 	ret = rxkad_prime_packet_security(conn, ci);
-- 
2.25.1


