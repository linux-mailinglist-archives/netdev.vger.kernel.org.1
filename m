Return-Path: <netdev+bounces-110465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5792C82F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B041F2451C
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5648C1E;
	Wed, 10 Jul 2024 02:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9241443D
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576860; cv=none; b=RmnEl7bYHE2tqlFLHgeg1LipDX5GqKtkV2Hwyu2rsKcV2EJ4pnnKnRG23C3IsJiWKD5iC1Ofo17caEnNeJ1WBAAh4cdJRtgBosWJhG3gKYLsjKPZvg/R9mtCKWmNb1ZlAvXHI1dK7CDYX2ZDFAQyJGlowaOxHTQ078z71EzVhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576860; c=relaxed/simple;
	bh=LDtYRLFV00IHIZrhFOYj5A7kohAV6yxrkjRiyud830g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OEw4ObyD3ODYnKmvKtX1bSmP30o08NgbFy+wn/3MHdWy/xGwqvrC3cSC8mhKKChGycyrt4foseGZPbzIuTNXK4o8KiO/HBovjxcdyYzg2/4FCqzMyOqeqYiEadrsD7oc1VLZH5Ac7ZghX+G++zrTwGlbTnhoBY+FOGnS+S443Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJgv94672zxVvZ;
	Wed, 10 Jul 2024 09:56:21 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 57659180088;
	Wed, 10 Jul 2024 10:00:56 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 10 Jul 2024 10:00:55 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <dhowells@redhat.com>, <marc.dionne@auristor.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<cuigaosheng1@huawei.com>
CC: <linux-afs@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] rxrpc: Remove the BUG in rxkad_init_connection_security
Date: Wed, 10 Jul 2024 10:00:55 +0800
Message-ID: <20240710020055.4116034-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200011.china.huawei.com (7.221.188.251)

If crypto_sync_skcipher_setkey fails, we only need to return the
error code, It is not necessary to trigger the BUG directly.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 net/rxrpc/rxkad.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 104bb1ec9002..75d291ada9e8 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -114,9 +114,10 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn,
 		goto error;
 	}
 
-	if (crypto_sync_skcipher_setkey(ci, token->kad->session_key,
-				   sizeof(token->kad->session_key)) < 0)
-		BUG();
+	ret = crypto_sync_skcipher_setkey(ci, token->kad->session_key,
+					  sizeof(token->kad->session_key));
+	if (ret < 0)
+		goto error_ci;
 
 	switch (conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:
-- 
2.25.1


