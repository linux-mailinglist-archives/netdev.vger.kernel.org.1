Return-Path: <netdev+bounces-109504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44609289E6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4CB1C2224B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9683149DF7;
	Fri,  5 Jul 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji579Q10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465113C8F9
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186889; cv=none; b=PU4GTd/i6VA+vZsoVGy0VUQeFE3/fEBT0GANo+yfllR9eg91epKy4onY58mQwl/4PZ0z9n3F/mI6+jPywnnz4oKlltenQFULPKtR5h4xLUhZ1fjxnFDmnlO3QLfOtbUXkeRIlFN12tX9gxk1rrZFeMesEhkuPba3+4TqQsDWXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186889; c=relaxed/simple;
	bh=rTT8w7flUJJ3q9vAXPE6yHGuV0sWJ6mO7qmCngvevr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=te3GaH54bwBT8S3u3zGyct0aNNAeMx/OHMA3LOJVzFWq2N14y3T1gIHV1+vxffc8Xd7uKQIm4OVLVw9Pu5JHg4eGxVEvj8fiBM59dDgfKi/j0GwR7XPjE007g+2FcPOK3Okttu93WaiufWPTtjVQSpzRXrAaYsHzd62HIZV2sH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji579Q10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4710C116B1;
	Fri,  5 Jul 2024 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720186889;
	bh=rTT8w7flUJJ3q9vAXPE6yHGuV0sWJ6mO7qmCngvevr8=;
	h=From:Date:Subject:To:Cc:From;
	b=ji579Q10YnbwrRU5IvYvtOCdsB/GyUgBju/2rd3mJfoOA+TEgqQlRcNEm7HL8V2DK
	 4Th8Aemsi0rucjwHqVe+yWINYRTCWUwJBYVxqYqFBheDQUeJ00B7tr5ItZcPXoMQ6C
	 sORerwnns1ldExBGMaH1+8cAozSQG++adhTwQasKWxGsuipd5yMoe+116PFqmVwLW/
	 /OVbBpiA3uPQmTODTKL1ITQXhvIRXtJ2qr+K0Ae+oZTeRu6Ox326caqP2OJwp+Booz
	 eRV73mq1ivzQQHZjvKgod66f/+Sy3Cou31OlZ/aMCjhNeSHBLslBKX3zHkPL0Z3mTN
	 Ubg5u0L8YNhKA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 05 Jul 2024 14:41:21 +0100
Subject: [PATCH net-next] net: tls: Pass union tls_crypto_context pointer
 to memzero_explicit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-tls-memzero-v1-1-0496871cfe9b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAD4h2YC/x3MQQqAIBBG4avErBuwUIquEi2k/mqgLFRCiu6et
 PwW7z0U4AWBuuIhj0uCHC6jKgsaV+sWsEzZVKtaq0YZjlvgHfsNf3Br7NxaraDNRLk4PWZJ/60
 nh8gOKdLwvh+xjTDlZwAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Pass union tls_crypto_context pointer, rather than struct
tls_crypto_info pointer, to memzero_explicit().

The address of the pointer is the same before and after.
But the new construct means that the size of the dereferenced pointer type
matches the size being zeroed. Which aids static analysis.

As reported by Smatch:

  .../tls_main.c:842 do_tls_setsockopt_conf() error: memzero_explicit() 'crypto_info' too small (4 vs 56)

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/tls/tls_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 90b7f253d363..e712b2faeb81 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -616,6 +616,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	struct tls_crypto_info *alt_crypto_info;
 	struct tls_context *ctx = tls_get_ctx(sk);
 	const struct tls_cipher_desc *cipher_desc;
+	union tls_crypto_context *crypto_ctx;
 	int rc = 0;
 	int conf;
 
@@ -623,13 +624,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		return -EINVAL;
 
 	if (tx) {
-		crypto_info = &ctx->crypto_send.info;
+		crypto_ctx = &ctx->crypto_send;
 		alt_crypto_info = &ctx->crypto_recv.info;
 	} else {
-		crypto_info = &ctx->crypto_recv.info;
+		crypto_ctx = &ctx->crypto_recv;
 		alt_crypto_info = &ctx->crypto_send.info;
 	}
 
+	crypto_info = &crypto_ctx->info;
+
 	/* Currently we don't support set crypto info more than one time */
 	if (TLS_CRYPTO_INFO_READY(crypto_info))
 		return -EBUSY;
@@ -710,7 +713,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	return 0;
 
 err_crypto_info:
-	memzero_explicit(crypto_info, sizeof(union tls_crypto_context));
+	memzero_explicit(crypto_ctx, sizeof(union tls_crypto_context));
 	return rc;
 }
 


