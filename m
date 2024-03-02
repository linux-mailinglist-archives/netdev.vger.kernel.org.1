Return-Path: <netdev+bounces-76790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3586EF07
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30177B22894
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF912B80;
	Sat,  2 Mar 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6D0s1lk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740912E4A
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363013; cv=none; b=ByVUdjzIAJDwWOIPr9mvRLDMbmTan16q4hnQGWL13fBWY/Co/3MJzwi0Jx3zVsaaXHFDSGV1JS4+5CPLWnlgYmixQcKTK32d50ft03cI/l8vuJ3JEi6lVsyHxv/Qjp4FYKTAcKSfvUJ8y8v/2eOKC9BEipAZxLKJIXv+Of3zh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363013; c=relaxed/simple;
	bh=PpqABxeDDg9ys4JtXwZkNf2wUeYEgR+GbwRLVDSgfCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVN3ll0zDia/pgFmBP4bT08dZxuEZ4bW+6Re1fYNOpdMyQAZ+a5E6PguEEUCDyaqfTwDnMjLnKvMFYcU/efi7/Uanm+HkyNEW0qwsl5dS0Tsfw1kV9k5yBjnnxo+rEUHYEMbAdgJpiNPfmqCKFtG7K7fQgi/POcUSNbSJIVLLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6D0s1lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1772DC43390;
	Sat,  2 Mar 2024 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363013;
	bh=PpqABxeDDg9ys4JtXwZkNf2wUeYEgR+GbwRLVDSgfCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6D0s1lkpIfJzhtedUj4Rx9QhVcw+ytiamRadWBXC27abxwnH0rHzr/XimInVov6R
	 cA5/wiRntBd/uNiB5XVWM9KhTr7hU+iB2jWrSPNLQCtRiFMa3luxEnS+HqitmMtG0B
	 OSWXC3FlBz3efi1UIj61tHrRewo40Dx4dOv3PEh8spgs82qT+gwobRJ73MotKbk6Dj
	 esqPfhoXAOekEdFS4Unln4SqU62oHiyNXt52bM8Ekzq/Gl/R+m6Aq2pF2jSuDery9E
	 EPSklXsaC46d9VxuJDIEedDzhWnNFN5n/OD50/rD3qrAb9pMv4ByjnBVYbMh9jRNtR
	 DkWMRtY890jIA==
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
	Aya Levin <ayal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net V2 4/9] net/mlx5: Fix fw reporter diagnose output
Date: Fri,  1 Mar 2024 23:03:13 -0800
Message-ID: <20240302070318.62997-5-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aya Levin <ayal@nvidia.com>

Restore fw reporter diagnose to print the syndrome even if it is zero.
Following the cited commit, in this case (syndrome == 0) command returns no
output at all.

This fix restores command output in case syndrome is cleared:
$ devlink health diagnose pci/0000:82:00.0 reporter fw
    Syndrome: 0

Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
Signed-off-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 8ff6dc9bc803..b5c709bba155 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -452,10 +452,10 @@ mlx5_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
 	struct health_buffer __iomem *h = health->health;
 	u8 synd = ioread8(&h->synd);
 
+	devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
 	if (!synd)
 		return 0;
 
-	devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
 	devlink_fmsg_string_pair_put(fmsg, "Description", hsynd_str(synd));
 
 	return 0;
-- 
2.44.0


