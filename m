Return-Path: <netdev+bounces-32184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9779358D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 08:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924A51C209CB
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63558806;
	Wed,  6 Sep 2023 06:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490C362
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 06:49:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E21CFD
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:49:16 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RgXvQ5Nm4zMl67;
	Wed,  6 Sep 2023 14:45:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 6 Sep
 2023 14:49:14 +0800
From: Liu Jian <liujian56@huawei.com>
To: <borisp@nvidia.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vfedorenko@novek.ru>, <netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net] tls: do not return error when the tls_bigint overflows in tls_advance_record_sn()
Date: Wed, 6 Sep 2023 14:52:37 +0800
Message-ID: <20230906065237.2180187-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I got the below warning when do fuzzing test:
BUG: KASAN: null-ptr-deref in scatterwalk_copychunks+0x320/0x470
Read of size 4 at addr 0000000000000008 by task kworker/u8:1/9

CPU: 0 PID: 9 Comm: kworker/u8:1 Tainted: G           OE
Hardware name: linux,dummy-virt (DT)
Workqueue: pencrypt_parallel padata_parallel_worker
Call trace:
 dump_backtrace+0x0/0x420
 show_stack+0x34/0x44
 dump_stack+0x1d0/0x248
 __kasan_report+0x138/0x140
 kasan_report+0x44/0x6c
 __asan_load4+0x94/0xd0
 scatterwalk_copychunks+0x320/0x470
 skcipher_next_slow+0x14c/0x290
 skcipher_walk_next+0x2fc/0x480
 skcipher_walk_first+0x9c/0x110
 skcipher_walk_aead_common+0x380/0x440
 skcipher_walk_aead_encrypt+0x54/0x70
 ccm_encrypt+0x13c/0x4d0
 crypto_aead_encrypt+0x7c/0xfc
 pcrypt_aead_enc+0x28/0x84
 padata_parallel_worker+0xd0/0x2dc
 process_one_work+0x49c/0xbdc
 worker_thread+0x124/0x880
 kthread+0x210/0x260
 ret_from_fork+0x10/0x18

This is because the value of rec_seq of tls_crypto_info configured by the
user program is too large, for example, 0xffffffffffffff. In addition, TLS
is asynchronously accelerated. When tls_do_encryption() returns
-EINPROGRESS and sk->sk_err is set to EBADMSG due to rec_seq overflow,
skmsg is released before the asynchronous encryption process ends. As a
result, the UAF problem occurs during the asynchronous processing of the
encryption module.

I didn't see the rec_seq overflow causing other problems, so let's get rid
of the overflow error here.

Fixes: 635d93981786 ("net/tls: free record only on encryption error")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/tls/tls.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 28a8c0e80e3c..3f0e10df8053 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -304,8 +304,7 @@ static inline void
 tls_advance_record_sn(struct sock *sk, struct tls_prot_info *prot,
 		      struct cipher_context *ctx)
 {
-	if (tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size))
-		tls_err_abort(sk, -EBADMSG);
+	tls_bigint_increment(ctx->rec_seq, prot->rec_seq_size);
 
 	if (prot->version != TLS_1_3_VERSION &&
 	    prot->cipher_type != TLS_CIPHER_CHACHA20_POLY1305)
-- 
2.34.1


