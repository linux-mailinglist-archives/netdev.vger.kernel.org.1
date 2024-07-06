Return-Path: <netdev+bounces-109606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48D92915F
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 08:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF8D281652
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 06:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFF518E06;
	Sat,  6 Jul 2024 06:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E61B813;
	Sat,  6 Jul 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248621; cv=none; b=U/oMPhdKEmaX0Dw5xeMS4Sz3J2KPg25jPZtql6CguoocD5lUGWrvFl6Zxs4OTrJNbQs6CMfTjdmGUtYfRpqU8DJhljTUwIiXISYb2AO4Qq6sO7Ngt80E7SdxJ/Xk1gZBRaaZgaZFYaJyl7cIFgeGkU1C2lIRSD4PVFoi5MCtI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248621; c=relaxed/simple;
	bh=5MS9rJ78/RT9kgdiRXH/5IXlRvtRiHkHLpbDOxHfKMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICoKkweJuD8JJP9wL2tu56RtApaBG7vO/EW7TW+xiLQ/PfCgB0XAduLu9JmyVlhYHwRXW/Z4j3iEeqI/B3d0Tfvsb9af1V9ay1HQiyRUl1c2Gx+mUYUcnClY1RKLd+NJvg7nP4N/GuCgK4Jt2liFgUT55JvEExi1z7Qi3IDdhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WGLWF0d5Nz1j69g;
	Sat,  6 Jul 2024 14:46:01 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 94ECF1A0188;
	Sat,  6 Jul 2024 14:50:09 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 6 Jul 2024 14:50:08 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<steved@redhat.com>, <kwc@citi.umich.edu>, <cuigaosheng1@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] gss_krb5: Fix the error handling path for crypto_sync_skcipher_setkey
Date: Sat, 6 Jul 2024 14:50:08 +0800
Message-ID: <20240706065008.451441-1-cuigaosheng1@huawei.com>
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

If we fail to call crypto_sync_skcipher_setkey, we should free the
memory allocation for cipher, replace err_return with err_free_cipher
to free the memory of cipher.

Fixes: 4891f2d008e4 ("gss_krb5: import functionality to derive keys into the kernel")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 net/sunrpc/auth_gss/gss_krb5_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 06d8ee0db000..4eb19c3a54c7 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -168,7 +168,7 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
 		goto err_return;
 	blocksize = crypto_sync_skcipher_blocksize(cipher);
 	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
-		goto err_return;
+		goto err_free_cipher;
 
 	ret = -ENOMEM;
 	inblockdata = kmalloc(blocksize, gfp_mask);
-- 
2.25.1


