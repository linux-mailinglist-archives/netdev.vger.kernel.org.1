Return-Path: <netdev+bounces-13593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9773C26E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 23:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C03281E03
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D104134DB;
	Fri, 23 Jun 2023 21:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFD125CD
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 21:17:47 +0000 (UTC)
X-Greylist: delayed 133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jun 2023 14:17:25 PDT
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F72727
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6uQt9cKBk2Sag9c2YWWjAaGPZs3k3Hvob+itlodbJvE=;
  b=uUeK7v84Q78fePqXn2J06hqIJHU44vOesDD7hu1wYYvYAjqJ0J/cmLDe
   UQgoZjPb5/RNMRv/6e8PHGv3hzro41BQHfbx/RndVD2XB7GRo04sYh6fK
   tpHpLxNHWHvUskJqhO23GItuTkGYflimreyRkgYm+KNieGnnWye4tIA+W
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686160"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:10 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Veerasenareddy Burru <vburru@marvell.com>
Cc: keescook@chromium.org,
	kernel-janitors@vger.kernel.org,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/26] octeon_ep: use array_size
Date: Fri, 23 Jun 2023 23:14:33 +0200
Message-Id: <20230623211457.102544-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index 392d9b0da0d7..185b7e50ee77 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -158,7 +158,7 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
 		goto desc_dma_alloc_err;
 	}
 
-	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
+	oq->buff_info = vzalloc(array_size(oq->max_count, OCTEP_OQ_RECVBUF_SIZE));
 	if (unlikely(!oq->buff_info)) {
 		dev_err(&oct->pdev->dev,
 			"Failed to allocate buffer info for OQ-%d\n", q_no);


