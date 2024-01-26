Return-Path: <netdev+bounces-66309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1ED83E59F
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CAB282873
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AD55E6E;
	Fri, 26 Jan 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opU9tb8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC05579B
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308625; cv=none; b=gC0SmGmVWsSeM+1/S5DNy/OwtHP0RMfHmccGyXYEqUQj2I+8SWxaTcIYAvngFTCTMbVzQZ+Lpd4GeKUYLbFAY+ZnX0GCt3YF8S588u9ezHdQQxIdc4iQFnOI4oef1IEGC41BN/sOSI+NT0cSF5nlAywv5Cgs+zquzD6MTlHCy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308625; c=relaxed/simple;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnRLHaGJkTXsczDYAvB4uBJnz1WdR2ZNcFQ1l/o4aCN0b2V80FTmck/cg+coWpXlvYjd5MHWsbcA3faX1g1+UqizT3G0yh9V5lsFyB5YgyCRcP0343+Z+OMMpZu8xBMjacb7tbPqSXD2fMoQDWKimI0aTvFNRsq+u9xTSeAEez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opU9tb8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C3CC433A6;
	Fri, 26 Jan 2024 22:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308625;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opU9tb8IQnFx5HOWdknzCUW945Xet0F8blv4JE4KAR14DWvaudjCPH6EUnLAvTPgp
	 TdRs2XEQR3w4LfL2b5va1Hw7R/8GyGdhSJhVmMmKuPgACn5EZV7c041fzgdwswH+gB
	 FMZJ8/KDHzHx0Y61so+ip1tQDuXkpduwGTI8LYZLcDrkMOdESQ2fvHPKXHvbo6iN8E
	 CVV3XK5qu0Hs9ylaQGMM0ErL2N0Uzm+EDXOLoamrlrN13QVhA59tVEl6cw65UMh3oL
	 IqYv12fRslfPr11pqBPjNK9Ejn1gnwqNfDvzDcrpytEFVcNxXt8uYKwDIfSwwLhuIY
	 psNoZu6gKx4pw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net-next 12/15] net/mlx5: Change missing SyncE capability print to debug
Date: Fri, 26 Jan 2024 14:36:13 -0800
Message-ID: <20240126223616.98696-13-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223616.98696-1-saeed@kernel.org>
References: <20240126223616.98696-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

Lack of SyncE capability should not emit a warning, change the print to
debug level.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index cf0477f53dc4..47e7c2639774 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -210,7 +210,7 @@ static bool is_dpll_supported(struct mlx5_core_dev *dev)
 		return false;
 
 	if (!MLX5_CAP_MCAM_REG2(dev, synce_registers)) {
-		mlx5_core_warn(dev, "Missing SyncE capability\n");
+		mlx5_core_dbg(dev, "Missing SyncE capability\n");
 		return false;
 	}
 
-- 
2.43.0


