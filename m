Return-Path: <netdev+bounces-34167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B97A26FA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF191C20932
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9ED18E22;
	Fri, 15 Sep 2023 19:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8418AE7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F84C433C7;
	Fri, 15 Sep 2023 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694805104;
	bh=IIDXBilgYAneCN/K2/MuOtg+9tUcnGL2d4QYXB9Cw5E=;
	h=Date:From:To:Cc:Subject:From;
	b=ROjc3G6vf0mbKgyCUv2ffJE3OCLUUI8UgG1FpZlN7sUBj3U60h82ohjf+dQwDwIr5
	 mjY3eC4WjOluKDZUZWZ/s+prYh1hQe/ABLGpmi87IQttMOGklRePtm11Jplsi7WdOO
	 sgbXBJ4cZfXfMyhRk/ByV8r7qJWs3Z+h7yOwIiy+Cfjro97ozQLM71Z7G58QLqHcnD
	 hrRfPRja3Lp2hBof2+z43xZ2PDB0aweG3K/ab3U5qd7WHrIjZbr8R6OQTFdcn5uq22
	 do8ziQM5OrWT97WPF/CWRyYMAtOjvVT907dQSdZ0ltR3AZV8zj8+lHi2I7q+1q+91d
	 yazLwwwgtzFdA==
Date: Fri, 15 Sep 2023 13:12:38 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] tls: Use size_add() in call to struct_size()
Message-ID: <ZQSspmE8Ww8/UNkH@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1fc295b83b5..270712b8d391 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1487,7 +1487,7 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	 */
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(ctx->aead_recv);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
-	mem = kmalloc(aead_size + struct_size(dctx, sg, n_sgin + n_sgout),
+	mem = kmalloc(aead_size + struct_size(dctx, sg, size_add(n_sgin, n_sgout)),
 		      sk->sk_allocation);
 	if (!mem) {
 		err = -ENOMEM;
-- 
2.34.1


