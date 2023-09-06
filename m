Return-Path: <netdev+bounces-32324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6D7941DA
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746E21C20A05
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6E10977;
	Wed,  6 Sep 2023 17:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D610976
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 17:08:55 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD813E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:08:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3222820002;
	Wed,  6 Sep 2023 17:08:51 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Dave Watson <davejwatson@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt requests
Date: Wed,  6 Sep 2023 19:08:31 +0200
Message-Id: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1694018970.git.sd@queasysnail.net>
References: <cover.1694018970.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
 -EBUSY instead of -EINPROGRESS in valid situations. For example, when
the cryptd queue for AESNI is full (easy to trigger with an
artifically low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
to the backlog but still processed. In that case, the async callback
will also be called twice: first with err == -EINPROGRESS, which it
seems we can just ignore, then with err == 0.

I've only tested this on AESNI with cryptd.

Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1ed4a611631f..4f3dd0403efb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -196,6 +196,9 @@ static void tls_decrypt_done(void *data, int err)
 	struct sock *sk;
 	int aead_size;
 
+	if (err == -EINPROGRESS)
+		return;
+
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(aead);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
 	dctx = (void *)((u8 *)aead_req + aead_size);
@@ -261,7 +264,7 @@ static int tls_do_decryption(struct sock *sk,
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
-	if (ret == -EINPROGRESS) {
+	if (ret == -EINPROGRESS || ret == -EBUSY) {
 		if (darg->async)
 			return 0;
 
@@ -443,6 +446,9 @@ static void tls_encrypt_done(void *data, int err)
 	struct sock *sk;
 	int pending;
 
+	if (err == -EINPROGRESS)
+		return;
+
 	msg_en = &rec->msg_encrypted;
 
 	sk = rec->sk;
@@ -544,7 +550,7 @@ static int tls_do_encryption(struct sock *sk,
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
-	if (!rc || rc != -EINPROGRESS) {
+	if (!rc || (rc != -EINPROGRESS && rc != -EBUSY)) {
 		atomic_dec(&ctx->encrypt_pending);
 		sge->offset -= prot->prepend_size;
 		sge->length += prot->prepend_size;
@@ -552,7 +558,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	if (!rc) {
 		WRITE_ONCE(rec->tx_ready, true);
-	} else if (rc != -EINPROGRESS) {
+	} else if (rc != -EINPROGRESS && rc != -EBUSY) {
 		list_del(&rec->list);
 		return rc;
 	}
@@ -779,7 +785,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
 			       msg_pl->sg.size + prot->tail_size, i);
 	if (rc < 0) {
-		if (rc != -EINPROGRESS) {
+		if (rc != -EINPROGRESS && rc != -EBUSY) {
 			tls_err_abort(sk, -EBADMSG);
 			if (split) {
 				tls_ctx->pending_open_record_frags = true;
@@ -990,7 +996,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (unlikely(msg->msg_controllen)) {
 		ret = tls_process_cmsg(sk, msg, &record_type);
 		if (ret) {
-			if (ret == -EINPROGRESS)
+			if (ret == -EINPROGRESS || ret == -EBUSY)
 				num_async++;
 			else if (ret != -EAGAIN)
 				goto send_end;
@@ -1071,7 +1077,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 						  record_type, &copied,
 						  msg->msg_flags);
 			if (ret) {
-				if (ret == -EINPROGRESS)
+				if (ret == -EINPROGRESS || ret == -EBUSY)
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
@@ -1125,7 +1131,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 						  record_type, &copied,
 						  msg->msg_flags);
 			if (ret) {
-				if (ret == -EINPROGRESS)
+				if (ret == -EINPROGRESS || ret == -EBUSY)
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
@@ -1248,6 +1254,7 @@ void tls_sw_splice_eof(struct socket *sock)
 			goto unlock;
 		retrying = true;
 		goto retry;
+	case -EBUSY:
 	case -EINPROGRESS:
 		break;
 	default:
@@ -2106,7 +2113,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		__skb_queue_purge(&ctx->async_hold);
 
 		if (ret) {
-			if (err >= 0 || err == -EINPROGRESS)
+			if (err >= 0 || err == -EINPROGRESS || err == -EBUSY)
 				err = ret;
 			decrypted = 0;
 			goto end;
-- 
2.40.1


