Return-Path: <netdev+bounces-37642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5107B7B66D0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4DAD8B209AA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61302031A;
	Tue,  3 Oct 2023 10:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11291F168;
	Tue,  3 Oct 2023 10:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE85CC433C7;
	Tue,  3 Oct 2023 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696330448;
	bh=0cPg/g9l5wi2azSbvT6fsYacFP0mkqp/bwFYc7a8Fw4=;
	h=Date:From:To:Cc:Subject:From;
	b=nMK2TiL/Fz7K5bEEz0fXBjnhoobDkzVdSItGSU2zz1BalGpxKHh4pHVDhJe7S5RdV
	 Ozl+WZgrMFWZtFv2ZqSgNlm4BQK2iEg1CyIiE+vs5TqT8TY57g6TxSE8WZmorcMoZa
	 n81gfyQS0ABqWA8ASiyxqu8ynYv4x9Mis+bd6OI//QkQkzjAOkizbwPi7yR4kM8Dsv
	 PdjLH7nyzHaOVvMqEzUg/8Clh+I74kO/bLKk2w55ayWULYpIIZBaWqaJMLeESHRhBO
	 8a2hec7y5wLTDUEZhUsSPdsBLSpx5TdlwixdWRDFurv9FnaiWH2Et/Nz+DjBFL0SFE
	 nodU2AT6zNfiQ==
Date: Tue, 3 Oct 2023 12:54:02 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rohit Maheshwari <rohitm@chelsio.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] cxgb4/ch_ktls: Fix undefined behavior bug in struct
 chcr_ktls_ofld_ctx_tx
Message-ID: <ZRvyysCUTqA7aXN4@work>
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
tls_offload_context_tx` can grow up to 16 bytes at run-time:

| include/net/tls.h-170:
| #define TLS_DRIVER_STATE_SIZE_TX  16

| include/net/tls.h-173:
| #define TLS_OFFLOAD_CONTEXT_SIZE_TX                                     \
|	(sizeof(struct tls_offload_context_tx) + TLS_DRIVER_STATE_SIZE_TX)

| net/tls/tls_device.c-1119:
| offload_ctx = kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);

Fix this by placing the declaration of object `base` at the end of
`struct chcr_ktls_ofld_ctx_tx`.

Fixes: 34aba2c45024 ("cxgb4/chcr : Register to tls add and del callback")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
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


