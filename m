Return-Path: <netdev+bounces-69333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6BB84AB3D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1F71C23981
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1715D1;
	Tue,  6 Feb 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW9sI6ux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8D1392
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180945; cv=none; b=Gyud1g/npH6dPwDueRNqOdKnbDlFDdHrQvmLattr/sycRHZtthbU6PD+b+YaXfrse0VIeYRCqsbhSQZhKfDaKidg+gizz/XUYVSyDy2wyQN7RVNhtMxGI9xvyXvMd7Ae04SPfwv1q43jbzpuHFff70lnpmlCoqltkXn0Tu5l9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180945; c=relaxed/simple;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nobtH+siSlOg7+IOgz3NT1hgPH63odDNtsKZUXbtkoewh1kLLbJDdXQG7c8a/jLo3kllIjn1aPIIVnUCjaKOcWbO/BquIgkkhNyuts6r6zas5mhgwOUIexpQ2x0D4RkS1NzzYTJ/KgrdcfI+UrASMMFlEpNcWultsNTtOBDYGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW9sI6ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CC8C4166C;
	Tue,  6 Feb 2024 00:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180945;
	bh=7OiCGCkl9Ca0tDBUYpf/oaXUUZrI6//IIvPbE00HcoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iW9sI6uxqfFA9/Fqelk7r4DO8fJ1Qhho1XUf78u1qKcSBjrG7Ck9ISXVrL2ynNrtj
	 s6k6cySMs+zPH/0PJ9om2eJKlSCW2TlbTbqJTLj3yTcLfdqjbdNbEKsZQutOJ50kyF
	 SEqNf0nAjH7z6u98tjgBvumdSwbkZC+5xUNj1d9PV/Kj+shyaZxKEnrkOA3fV4ay4O
	 BoSgH6miD9xTHMM9YfAW+iX4HV/ysE0d3IGxWzQwn3wXweLMNq6mcOaBgf0LFmle+F
	 iLEX6/xcZcSQQUkPZmr5d5k5IPJA02cbF/UNLuV4uVDY5Hv0fu8grtXxaxIjYNUiFw
	 w6vwqlhv0d7Iw==
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
Subject: [net-next V4 12/15] net/mlx5: Change missing SyncE capability print to debug
Date: Mon,  5 Feb 2024 16:55:24 -0800
Message-ID: <20240206005527.1353368-13-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
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


