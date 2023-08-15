Return-Path: <netdev+bounces-27655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE3077CAE0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C05281470
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620B101C0;
	Tue, 15 Aug 2023 09:59:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B376FA9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:59:32 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0879F10F
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:59:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 909EA20764;
	Tue, 15 Aug 2023 11:59:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phUWtVxFU538; Tue, 15 Aug 2023 11:59:28 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EC3732084B;
	Tue, 15 Aug 2023 11:59:28 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id E686A80004A;
	Tue, 15 Aug 2023 11:59:28 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:59:28 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:59:28 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7058F3184467; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/11] xfrm: don't skip free of empty state in acquire policy
Date: Tue, 15 Aug 2023 11:53:10 +0200
Message-ID: <20230815095310.3310160-12-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815095310.3310160-1-steffen.klassert@secunet.com>
References: <20230815095310.3310160-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Leon Romanovsky <leonro@nvidia.com>

In destruction flow, the assignment of NULL to xso->dev
caused to skip of xfrm_dev_state_free() call, which was
called in xfrm_state_put(to_put) routine.

Instead of open-coded variant of xfrm_dev_state_delete() and
xfrm_dev_state_free(), let's use them directly.

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    | 1 +
 net/xfrm/xfrm_state.c | 8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 151ca95dd08d..363c7d510554 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1984,6 +1984,7 @@ static inline void xfrm_dev_state_free(struct xfrm_state *x)
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
 			dev->xfrmdev_ops->xdo_dev_state_free(x);
 		xso->dev = NULL;
+		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 		netdev_put(dev, &xso->dev_tracker);
 	}
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 49e63eea841d..bda5327bf34d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1324,12 +1324,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			struct xfrm_dev_offload *xso = &x->xso;
 
 			if (xso->type == XFRM_DEV_OFFLOAD_PACKET) {
-				xso->dev->xfrmdev_ops->xdo_dev_state_delete(x);
-				xso->dir = 0;
-				netdev_put(xso->dev, &xso->dev_tracker);
-				xso->dev = NULL;
-				xso->real_dev = NULL;
-				xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
+				xfrm_dev_state_delete(x);
+				xfrm_dev_state_free(x);
 			}
 #endif
 			x->km.state = XFRM_STATE_DEAD;
-- 
2.34.1


