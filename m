Return-Path: <netdev+bounces-73045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6C85AAE9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41218282B6C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EB48782;
	Mon, 19 Feb 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Sck9Zx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99D481DB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367015; cv=none; b=YegXFpH49ecKHttOFleNxX+DHqT+jnRglpbfMPBKJqtAk8tk9d1cBT3IEUgjs+Ncm9R447gnDc0iLo2YzA/9BI3NaQ/n/DugcYV6vpZgFiNf0SynazqphFZSZvVjZtB/VITtlgqTKYvK+2gBRbA6LBl1e5ijOnRdy9ypv4a6Mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367015; c=relaxed/simple;
	bh=ebSFEy8F0Gke9fNlkcrSL4FNIak5iY+E245RQtTKbNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdWNcoDOdnV+p6hQfJDWMTu12bmbQW+1QUgbgUM82g7gs8+G9kVZvkliZZRa6ddYj3fhSikhYDXBH8PPQTCe5lf8c03VPG5DqKKjYUvzIYYoWTMoIGkQjN5AC4EJLGYfScBab1Z7u9g/WUQZf1ePON7Ws8bCUAzwu1U/52jTehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Sck9Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C0C43390;
	Mon, 19 Feb 2024 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367014;
	bh=ebSFEy8F0Gke9fNlkcrSL4FNIak5iY+E245RQtTKbNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n/Sck9ZxSy2rB19845C2PUse9AbIx5yTS2syogAUnnafrwZ8B2eOxZTQhXDxh8KwW
	 dzsyxjzN9Su2lRoHM1J85WVGCYMoynsO+OFObeGURyEzW6TikteYkiMF6BpI7/8Gym
	 8kop7aUIQN5detxO4wPZekDLr2cCsPjaMXRvI9HZhyMgv/BmUiFLFeKZkfZmXeHqPa
	 dWIXryXE++CgrSr61XdM2hpRg6p42+R+DWMuG2pd1mKtT4BSoy59WgTIOvrQqnr4L+
	 tigcty/lkIBXhiZakwefavEGR0pYIuMWujskGcMtsTXDFAPiiteVWSOGZi8tL7dX87
	 u9xxjlHfA/5nQ==
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
Subject: [net 04/10] net/mlx5: Fix fw reporter diagnose output
Date: Mon, 19 Feb 2024 10:23:14 -0800
Message-ID: <20240219182320.8914-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
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
2.43.2


