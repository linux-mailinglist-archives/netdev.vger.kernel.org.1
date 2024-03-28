Return-Path: <netdev+bounces-81920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B188BB23
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 08:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B33A1C2C423
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7C74BEB;
	Tue, 26 Mar 2024 07:23:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3F1272A8;
	Tue, 26 Mar 2024 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437793; cv=none; b=bFHxPAn3ZB3xvDuzXj8JZRILLTyRREnGkrddhB9uUCyvyrnctSHHLmHcE4jAkEftywzNgPTeoFQh3Zkmb64n2i9CmIWzcexvGxAz7yIegam9a/m/7qUv7L7JnWlc8iKJKLHXFZNJ8sBB7ufm+uE0nARyoknZqg79B7dShji9eT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437793; c=relaxed/simple;
	bh=gVdqo+muMxJNWsSySfdIfRgy5LgJ/5g5dMiae7rkDRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2u8Q3DDU9LEbF0zWywyantk89cFfdxkdiMBh9c5gEBrENy2dK5pQ6ojQgp6r1c7QvHcQvQzEOhSfh5OKxPKe5zzN8/nhWTONYHqXYf7pb2QoPThy18+ZfI//gWTYpxkfyjRssuWt1bqGnUF/Cdscl15IZf176iS9+jrVfn4ddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V3h855hKhz1wnGj;
	Tue, 26 Mar 2024 15:22:13 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A792140120;
	Tue, 26 Mar 2024 15:23:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 15:23:01 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,RESEND] net/smc: make smc_hash_sk/smc_unhash_sk static
Date: Tue, 26 Mar 2024 15:29:52 +0800
Message-ID: <20240326072952.2717904-1-shaozhengchao@huawei.com>
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
 dggpeml500026.china.huawei.com (7.185.36.106)

smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
static and remove the output symbol. They can be called under the path
.prot->hash()/unhash().

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h | 3 ---
 net/smc/af_smc.c  | 6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index c9dcb30e3fd9..10684d0a33df 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -26,9 +26,6 @@ struct smc_hashinfo {
 	struct hlist_head ht;
 };
 
-int smc_hash_sk(struct sock *sk);
-void smc_unhash_sk(struct sock *sk);
-
 /* SMCD/ISM device driver interface */
 struct smcd_dmb {
 	u64 dmb_tok;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4b52b3b159c0..e8dcd28a554c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -177,7 +177,7 @@ static struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
 };
 
-int smc_hash_sk(struct sock *sk)
+static int smc_hash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 	struct hlist_head *head;
@@ -191,9 +191,8 @@ int smc_hash_sk(struct sock *sk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(smc_hash_sk);
 
-void smc_unhash_sk(struct sock *sk)
+static void smc_unhash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 
@@ -202,7 +201,6 @@ void smc_unhash_sk(struct sock *sk)
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	write_unlock_bh(&h->lock);
 }
-EXPORT_SYMBOL_GPL(smc_unhash_sk);
 
 /* This will be called before user really release sock_lock. So do the
  * work which we didn't do because of user hold the sock_lock in the
-- 
2.34.1


