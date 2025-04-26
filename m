Return-Path: <netdev+bounces-186226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC93A9D820
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 08:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0BF16A6BF
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAAB192580;
	Sat, 26 Apr 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKpAYcXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B772F56;
	Sat, 26 Apr 2025 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647726; cv=none; b=bDLYOCrI4fGF+yvJr+nvO8eNvCDueRRwAtPVCKOttZ47VtGY67L38YD5qkDB84JTr1Xu+FNMoKdYJmUQzzOKg/8BMdvY/FtD2dIEb1TSRj8cxZygCtCOsHC8hg5Z8Kk+t4B0sAp+y3xMSmfybLXyPemvTnvvfwVJhlRdtp5pRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647726; c=relaxed/simple;
	bh=pDmSWif2PnPHWTzoG2vW+Qv4Dur2nh7NwT4S/9B8lEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FDkYYxiZgjzOmPgsO9vBedGZqOKxIeEPCL2uKmqs/XSq9KdGFf2b5y1uEkYIdU2ZGBm6yL5JQBep2/YK6c9fwZKFOqBh0Jmlk36hzaSwbOiUogM0iG4XJUBxx+iMpILWs9xBEwVHM/GDflhkHWdh+iVNEnbc+6fH/Lrjrs2nCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKpAYcXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C673DC4CEE2;
	Sat, 26 Apr 2025 06:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647725;
	bh=pDmSWif2PnPHWTzoG2vW+Qv4Dur2nh7NwT4S/9B8lEw=;
	h=From:To:Cc:Subject:Date:From;
	b=qKpAYcXhKhiBzho9FjLElV+K0BR7tLgY8kts7P2ssnvVeYWOupImQaoIfZM9RFjol
	 mSJGRt07+bpKKUOQbEk2DBzlxFKhtlZdKDfd9ewrcWK0qL3xst4MIaOTTkqae5Way9
	 +TCrRaMzscSd6urm2AMOeBrXIj7g7vU4I31OstuVFl2fkuWC5w+iyXKdanCWvLznsQ
	 wFp1LjbeCjj/K8RlGFX5WnjTg0QOV9vMzxIN+dumyIV49AqTKWrPYNlpHooeXobCgX
	 Q2smoDqxd0JUyAORAUd2KZ4oeXRpTf28kcTj4+T0axMyr6OLl34S6/ByHiOp5SNrAu
	 jRbHefZT+e+OA==
From: Kees Cook <kees@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Diana Wang <na.wang@corigine.com>,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Mohammad Heib <mheib@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nfp: xsk: Adjust allocation type for nn->dp.xsk_pools
Date: Fri, 25 Apr 2025 23:08:42 -0700
Message-Id: <20250426060841.work.016-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=kees@kernel.org; h=from:subject:message-id; bh=pDmSWif2PnPHWTzoG2vW+Qv4Dur2nh7NwT4S/9B8lEw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8FZlLvpZZubMoqUYlr+iI8/yja1trfDbq8dYtv+YUb M1QjV3fUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJHrFxkZFi9IE9XK3vPOyebp pqpVgZseM/c/SJqtz/rg4ZNmQcM/rowMC1ZMvuyjdCZm+vaeEAPd3erBmwyNCyUW2dYqSC/t3Xe MFQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type "struct xsk_buff_pool **", but the returned type will be
"struct xsk_buff_pool ***". These are the same allocation size (pointer
size), but the types don't match. Adjust the allocation type to match
the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Louis Peens <louis.peens@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Diana Wang <na.wang@corigine.com>
Cc: <oss-drivers@corigine.com>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 95514fabadf2..28997ddab966 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2538,7 +2538,7 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
 				  nn->dp.num_r_vecs, num_online_cpus());
 	nn->max_r_vecs = nn->dp.num_r_vecs;
 
-	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(nn->dp.xsk_pools),
+	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(*nn->dp.xsk_pools),
 				   GFP_KERNEL);
 	if (!nn->dp.xsk_pools) {
 		err = -ENOMEM;
-- 
2.34.1


