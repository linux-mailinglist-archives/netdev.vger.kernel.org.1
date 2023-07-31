Return-Path: <netdev+bounces-22810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0776950E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972261C20928
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1A1801F;
	Mon, 31 Jul 2023 11:38:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FF182A0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C6EC433C7;
	Mon, 31 Jul 2023 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690803525;
	bh=uidl4fUimwXietfKpV1dwJxCa9qfVHrQL0IdL98DeT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzWCUbpJ8t5gEacDnviEmMdxhTz08ixuHIau1xPcgUB6RbwYFCG66a3n8ZozsILt0
	 Ija1zyy9L/P/hSQzlmWuE+06tSRjoV0KIHqo10PnmknbDv8l5Rn5zQADfeTPK75yOj
	 jLfR6DwIgGj1TVFXCgZ9uNAaPLJ0gyqgdBhgMjR+yWUXE7PiinETPOAOvJ1/MMGuMD
	 KdkJI6qlSP8+qv6xE178C/TDHzLfkB/CUIyM9tt+Q1FWtnsXGH+m9fb2l3l8oqdE9t
	 zr+bOnQCQEaTGhnS6vQPrd3CHSjEyd85Fd2wC/vl4nVdhk8BhHvFW29iYXYlHz/tWQ
	 ZaFKkRHP5NaOw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec-rc 2/2] xfrm: don't skip free of empty state in acquire policy
Date: Mon, 31 Jul 2023 14:38:27 +0300
Message-ID: <f6883e3e9acc98bf7fe3ec74005d229a6b1c199f.1690803052.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690803052.git.leon@kernel.org>
References: <cover.1690803052.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In destruction flow, the assignment of NULL to xso->dev
caused to skip of xfrm_dev_state_free() call, which was
called in xfrm_state_put(to_put) routine.

Instead of open-coded variant of xfrm_dev_state_delete() and
xfrm_dev_state_free(), let's use them directly.

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
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
2.41.0


