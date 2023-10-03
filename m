Return-Path: <netdev+bounces-37643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416407B66E5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F0AF62816DD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF620B10;
	Tue,  3 Oct 2023 10:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43443208B0;
	Tue,  3 Oct 2023 10:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68061C433CA;
	Tue,  3 Oct 2023 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696330620;
	bh=L2ltrDergf8j+6fN/XHH5Y2TY5o3ImTEqYPcQIDDz74=;
	h=Date:From:To:Cc:Subject:From;
	b=XI3o7enOreh7fRsdaT70e9scAOoD65yQRBnHI6PYbVcep0ISwndyOulaRdbTy/VTF
	 0U9drLcniIQyOtYmnZjHHNM0cX3J1t8xX/uazdVob2up4RGkLBhod76s+s1+iDsUQL
	 dN01yQ2zvr8ECqcQnAVSH8KQUr6SsXxDNNXQsqYQc/jksSmHJx3H5yk3pf2c9Y2a1K
	 17BlOVCZDoDyXgKR5wmI0VclvNtJLyP1+ntRipJp4kFsqTQ25kh3yl4FCZrhpVs9r3
	 1XOq2udkA3et5rTP2CVa8jqSzPzCLPjh2xg2J+ExgVfpFV75GBtuH+dKAgZWo1qYOW
	 GmIlJrrfFpuTg==
Date: Tue, 3 Oct 2023 12:56:54 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rohit Maheshwari <rohitm@chelsio.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] cxgb4/ch_ktls: Fix undefined behavior bug in struct
 chcr_ktls_ofld_ctx_tx
Message-ID: <ZRvzdlvlbX4+eIln@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`struct tls_offload_context_tx` is a flexible structure, which means
that it contains a flexible-array member at the bottom. This could
potentially lead to an overwrite of the objects following `base` in
`struct chcr_ktls_ofld_ctx_tx` at run-time.

Notice that flexible-array member `driver_state` in `struct
tls_offload_context_tx` can grow up to 16 bytes:

| include/net/tls.h-170:
| #define TLS_DRIVER_STATE_SIZE_TX  16

| include/net/tls.h-173:
| #define TLS_OFFLOAD_CONTEXT_SIZE_TX                                     \
|	(sizeof(struct tls_offload_context_tx) + TLS_DRIVER_STATE_SIZE_TX)

| net/tls/tls_device.c-1119:
| offload_ctx = kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);

Fix this by placing the declaration of object `base` at the end of
`struct chcr_ktls_ofld_ctx_tx`.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: 34aba2c45024 ("cxgb4/chcr : Register to tls add and del callback")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update changelog text: mention -Wflex-array-member-not-at-end.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZRvyysCUTqA7aXN4@work/

 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
index 10572dc55365..35e34e3db663 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
@@ -68,8 +68,8 @@ struct chcr_ktls_info {
 };
 
 struct chcr_ktls_ofld_ctx_tx {
-	struct tls_offload_context_tx base;
 	struct chcr_ktls_info *chcr_info;
+	struct tls_offload_context_tx base;
 };
 
 struct chcr_ktls_uld_ctx {
-- 
2.34.1


