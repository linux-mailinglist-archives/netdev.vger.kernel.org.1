Return-Path: <netdev+bounces-68688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06294847967
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6AA1F27CA2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD512D773;
	Fri,  2 Feb 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2qoLrX/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995C12D76F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900953; cv=none; b=UXxC+QzZOQg/iHzzMV2Kep5XDnmpfndgwKGQsepIcZMVNCr4vKOKOCSO1b9h/mskPbPnZequCIEBn2SCVMGsg5NaaxySeFKckAo5Y2RmfA6klAgAlGIjD88KKwptznJi0McNQOc7skS0Us3qzInAGXxUGd1SOdQ/MzFW8nyfr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900953; c=relaxed/simple;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq8eWApqQC7bh6TarqcA6ulGzH+FTuTZzlGamsgUTc2hZKzhI2pnm/vEZtEtBirD+3vOr0VbhgW44j8MVkWwtHeGLf4ECsvpBsPRAOHXTz1Z0gLnuhNxdPXkzOjSSxTIJZKBnokGyCq00PRTFTIhuKf8tTO2S0VWtW+fzWueGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2qoLrX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A0C433F1;
	Fri,  2 Feb 2024 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900953;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2qoLrX/SCFgPkn7hpkHEQHCV5ZnhHieve7py+HIhMYp5BmnJyJA8y25x7LsugcCL
	 MVDm0SCfMwPHZ48/c6dSVSLvKNJvXJJHDGQZymQP5Vi1JIAqGowUXRZPDMWTX1Ujfh
	 vdNS4SUgllWlGyUpXBee44GG/dDqd1EHhdF95FXm4jqaccDU3s0JgDxjMhZ1QNsIfB
	 IltQdvQDUQFYlTyqPPZpH1PSlDj9f31Q8ZRbSvJWhwPnTPqjsxkwEFZAS33UiiPP0j
	 cplqUUBs/mpiStZKTgNvzRC6IHFZzSogm9MzPj3FrUmVro2G9s80HJnP5cwEdMCaa2
	 RIIstwXBRaCIQ==
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
Subject: [net-next V3 12/15] net/mlx5: Change missing SyncE capability print to debug
Date: Fri,  2 Feb 2024 11:08:51 -0800
Message-ID: <20240202190854.1308089-13-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
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


