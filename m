Return-Path: <netdev+bounces-14281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A040E73FEB6
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4742810C1
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0319501;
	Tue, 27 Jun 2023 14:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EC18C02
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:45:19 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11230F1;
	Tue, 27 Jun 2023 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fzSlg9RNv3R+3q3XKuXY+6o6TuoQBOkN0UNS+oRdi0g=;
  b=dpxRX6SKkutCFKOYF4CwCciL+V9U5RgWhgmvlkclZlRvImw5QJ17O2LY
   M9nttluQAh/UNtlB4llXPA7Jwu+IR5YR2l36V97hbUU6lLQSksCae62fb
   VSdf3WEpvEHszDLULnIk7nnYz+Z0KY2ThObKD3MYXOgxPiP06rK8g0GSU
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936330"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:52 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: kernel-janitors@vger.kernel.org,
	keescook@chromium.org,
	christophe.jaillet@wanadoo.fr,
	kuba@kernel.org,
	Brett Creeley <brett.creeley@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/24] pds_core: use vmalloc_array and vcalloc
Date: Tue, 27 Jun 2023 16:43:24 +0200
Message-Id: <20230627144339.144478-10-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use vmalloc_array and vcalloc to protect against
multiplication overflows.

The changes were done using the following Coccinelle
semantic patch:

// <smpl>
@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: Use vmalloc_array and vcalloc instead of array_size.
This also leaves a multiplication of a constant by a sizeof
as is.  Two patches are thus dropped from the series.

 drivers/net/ethernet/amd/pds_core/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -196,7 +196,7 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, un
 	dma_addr_t q_base_pa;
 	int err;
 
-	qcq->q.info = vzalloc(num_descs * sizeof(*qcq->q.info));
+	qcq->q.info = vcalloc(num_descs, sizeof(*qcq->q.info));
 	if (!qcq->q.info) {
 		err = -ENOMEM;
 		goto err_out;
@@ -219,7 +219,7 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, un
 	if (err)
 		goto err_out_free_q_info;
 
-	qcq->cq.info = vzalloc(num_descs * sizeof(*qcq->cq.info));
+	qcq->cq.info = vcalloc(num_descs, sizeof(*qcq->cq.info));
 	if (!qcq->cq.info) {
 		err = -ENOMEM;
 		goto err_out_free_irq;


