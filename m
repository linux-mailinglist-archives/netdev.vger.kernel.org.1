Return-Path: <netdev+bounces-13599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C457E73C28A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EEF281E51
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E7C1549E;
	Fri, 23 Jun 2023 21:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD371549C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 21:20:12 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70676359D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1b2qOiijM2SOFY49y/T4nNKOOzZTttGdtrLG5Lh64bI=;
  b=uyu8z8wzWEtEgebrWGzG9i5oWEcHT9BaIjP0Cs8YqJ4Dnb9025dIo99d
   UntoRq5hk/R+vCjtxjxaQzUluEwwNY91uXDdnCSwbykFbM7jOIMaPWqbb
   mmDU8w2Ro+9cTiPSvq7ACpxLUR8sUeZ+2YhiHhuPAojA3G8yl102Og3hU
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686176"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:13 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: keescook@chromium.org,
	kernel-janitors@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/26] net: enetc: use array_size
Date: Fri, 23 Jun 2023 23:14:49 +0200
Message-Id: <20230623211457.102544-19-Julia.Lawall@inria.fr>
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
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/freescale/enetc/enetc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9e1b2536e9a9..7231f8ea1ba4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1790,7 +1790,7 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
 	res->bd_count = bd_count;
 	res->bd_size = sizeof(union enetc_tx_bd);
 
-	res->tx_swbd = vzalloc(bd_count * sizeof(*res->tx_swbd));
+	res->tx_swbd = vzalloc(array_size(bd_count, sizeof(*res->tx_swbd)));
 	if (!res->tx_swbd)
 		return -ENOMEM;
 
@@ -1878,7 +1878,7 @@ static int enetc_alloc_rx_resource(struct enetc_bdr_resource *res,
 	if (extended)
 		res->bd_size *= 2;
 
-	res->rx_swbd = vzalloc(bd_count * sizeof(struct enetc_rx_swbd));
+	res->rx_swbd = vzalloc(array_size(bd_count, sizeof(struct enetc_rx_swbd)));
 	if (!res->rx_swbd)
 		return -ENOMEM;
 


