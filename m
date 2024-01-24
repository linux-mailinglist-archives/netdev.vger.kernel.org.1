Return-Path: <netdev+bounces-65371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F583A3FB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ABE1F2CF83
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4B17577;
	Wed, 24 Jan 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGVqDNlO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224A17981
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084366; cv=none; b=pUqeSXsPFcmnPizZBkV1rm0yCyUvKSIhDHhUlfnqdlgAh7gVaGARwF8AKKsByY2HTtcSQIWXZzZSab6aKeQMWXdL/BePSckAbSRpYwQS+db/Plw5DKK7iZzS+3ZVziR01uGzHoEDlO/qiRqsIlDFDPZC9MQ3Yif6FiD8mcGE1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084366; c=relaxed/simple;
	bh=PjhP0ty/XS8ftOladW2pA+IKxh62A5osh5tBpeB0hTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmU7uaHP5V0k8y4HF0eGBix+WZ8cltJPt8Wb1RFw4+7y/qAPT2glH5MVh1YQQI1MNEIzpJT9QMCfjB44bZK8KcLObFgIbxl5Q46F1IiU1TA6bl8HUl1DZLbuAai9PavMqA4ZJqmsWdBTkScEnq+EnYzddmpxSXVaKQ/llluobt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGVqDNlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBA9C433F1;
	Wed, 24 Jan 2024 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084365;
	bh=PjhP0ty/XS8ftOladW2pA+IKxh62A5osh5tBpeB0hTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGVqDNlON2/mYL/wFSa3p/LXXO/XzHId+waI1slut18aQ3ArfGTlZ/CdXWGyi4bEc
	 CweRjcgR6EwcK07foTSl5UeYpQRx8LpuvGFt7hrTItNgOKjuZcxODnCczWmGPNMnb2
	 gouXeTQP/n8u3Ek/UtL2t73ukdeSxpr0P7eZuA1r8UmVTRimM/dHRtE+dv64jCv2Xp
	 J4xK8bSAfnnoD6RZjBhtxf+MdhjZPIbI1SVpuGd1grHd8pbDEhS2/NXRyi4MRsQWUM
	 isbaV6AyDAn51FEbjyCyDOx3E3/mHC23gPQ+ftWQUGCqIF6pWpCCBTpLKJCpPQDLp6
	 I+dYC7mjfeQrw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Simon Horman <horms@kernel.org>
Subject: [net 14/14] net/mlx5e: fix a potential double-free in fs_any_create_groups
Date: Wed, 24 Jan 2024 00:18:55 -0800
Message-ID: <20240124081855.115410-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
fs_any_create_groups() will free ft->g. However, its caller
fs_any_create_table() will free ft->g again through calling
mlx5e_destroy_flow_table(), which will lead to a double-free.
Fix this by setting ft->g to NULL in fs_any_create_groups().

Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index e1283531e0b8..671adbad0a40 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -436,6 +436,7 @@ static int fs_any_create_groups(struct mlx5e_flow_table *ft)
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
-- 
2.43.0


