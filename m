Return-Path: <netdev+bounces-109742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E8929D06
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688BE1F216FA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F318EBF;
	Mon,  8 Jul 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibq9UCLz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FCEDF
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423645; cv=none; b=f3JaLTJ/pvkJt04hNZf2U8/AtCDg4TauSrlEZJ+q37NRv6XkzwYK3YWa0CFj4C6CvulSolIoRzDtLlN5bamzHwoHMuMgYl1FMSkD0LUKNYvmZx2qplt+MAYuCtPHqN+qkYlfL25UpZTtWa+p3mTz7Y90NVyhdnqDPBRaPqyc07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423645; c=relaxed/simple;
	bh=EhRmNsACtKcNmHdQ25slnGNCA6sxoDZKmMDUjVqcQFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=abZamifoxuVeLhE9GVAvxLInXbWIyhB4YX+2fDLByWDO34P+tPcJ0pAAHS4fSUw3m652o3je+AB3+tT4v66J2dqBPfrQw+K4tIben/sCZ0YUFw8s2zlw7BkT3Tiz3wDgEuB4DDKVfdhARebQrrfUqf1z5uqyGPuLWjX+Xv5rI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibq9UCLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A10BC116B1;
	Mon,  8 Jul 2024 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720423644;
	bh=EhRmNsACtKcNmHdQ25slnGNCA6sxoDZKmMDUjVqcQFw=;
	h=From:Date:Subject:To:Cc:From;
	b=ibq9UCLzWBTluXOlVPSGDaAZdHoUWzjPUGJfrhxc4INVw3hWSIb8D59r+xMW2d04E
	 nuoppiRYB4qNDLA4OHh+9SvFjW2+lW7JE8YZSqYcX9VOOfMKmwqzCShNWzd8AN5mmW
	 pYgS7rXVyOQTODZ0nQdEfw2G0jGIjbE4dj4y3oz2zmNPiUcZjD7Oe3lOQTqS5ERDdL
	 Mli6LZEHrriZy7WQv3AygWopNpS4GEmjbjGMe5u1tbnpZol+aSPHz1K5IXyUJvlVUC
	 DRiK2DK3slwyPlrdh/CZ/vH0DJEdx5gSiKfFzsxt+cWdVTjFKwTmqN5e8xL36copu4
	 72ELLSpVM0ilA==
From: Simon Horman <horms@kernel.org>
Date: Mon, 08 Jul 2024 08:27:19 +0100
Subject: [PATCH net-next v2] net: tls: Pass union tls_crypto_context
 pointer to memzero_explicit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-tls-memzero-v2-1-9694eaf31b79@kernel.org>
X-B4-Tracking: v=1; b=H4sIANaUi2YC/22NQQ6CMBREr0L+2m9aUgRceQ/DAmGARmzNb0NQw
 t1tWLt8eZk3GwWIRaBrtpFgscF6lyA/ZdRNrRvBtk9MucqNKlXBcQ78wusL8VwV7VC1RsEUPaX
 FWzDY9ajdySGywxqpSWayIXr5HDeLPvzf4qJZszL1pSp1N6B+3J4Qh/nsZaRm3/cfk4Hsz7EAA
 AA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
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

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Added Reviewed-by tag from Przemek Kitszel
- Updated to use sizeof(*crypto_ctx), as suggested by Przemek Kitszel
- Link to v1: https://lore.kernel.org/r/20240705-tls-memzero-v1-1-0496871cfe9b@kernel.org
---
 net/tls/tls_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 90b7f253d363..6b4b9f2749a6 100644
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
+	memzero_explicit(crypto_ctx, sizeof(*crypto_ctx));
 	return rc;
 }
 


