Return-Path: <netdev+bounces-32703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8017996D4
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 10:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8001C20B20
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6D17EE;
	Sat,  9 Sep 2023 08:11:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CD1851
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 08:11:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37519BA
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:11:22 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RjQZh5704zMl9k;
	Sat,  9 Sep 2023 16:07:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 9 Sep
 2023 16:11:19 +0800
From: Liu Jian <liujian56@huawei.com>
To: <borisp@nvidia.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vfedorenko@novek.ru>, <sd@queasysnail.net>, <netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net v2] net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()
Date: Sat, 9 Sep 2023 16:14:34 +0800
Message-ID: <20230909081434.2324940-1-liujian56@huawei.com>
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

If the operation is asynchronous and the encryption module returns
EINPROGRESS, do not free the record information.

Fixes: 635d93981786 ("net/tls: free record only on encryption error")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
v1->v2:
  Retain the current EBADMSG error info and add error handling.
 net/tls/tls_sw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1ed4a611631f..d1fc295b83b5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -817,7 +817,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	psock = sk_psock_get(sk);
 	if (!psock || !policy) {
 		err = tls_push_record(sk, flags, record_type);
-		if (err && sk->sk_err == EBADMSG) {
+		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
 			err = -sk->sk_err;
@@ -846,7 +846,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
-		if (err && sk->sk_err == EBADMSG) {
+		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
 			err = -sk->sk_err;
-- 
2.34.1


