Return-Path: <netdev+bounces-40445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF47C76BA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2744F1C2114E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612703C6A4;
	Thu, 12 Oct 2023 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT5gyaUE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F773B29F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07519C433C7;
	Thu, 12 Oct 2023 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138881;
	bh=sCKW1lulrN47qnO06iR1/PFLTCfQeGivHQvENFLnd44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OT5gyaUEQsH1irkSoB+SluhmCIh/Xk4ZbfOMZHO6Y7b1ArwHMuXfvOutPF8qxrWyF
	 ykqwfJ2hKSCQf96bhCRcVWX4m45b/ak0nfWhBYFUSch0bYDWVTkmc+i/G/iOANQ3AS
	 plSa1i8en6o0mzvWBx5bbZvU75kUfoESZOnHcDntU8wwr4enIDvPGVQBbGNUwsLa9i
	 GdnFx8pd0C+392cPTC67SUMMuthajFPkpvV+A0z2tlUc3WYJ5ckbQRqapm0A0QST3B
	 BnEUfRjt4KbIbi/4ETXd0mxOF0C2p71x1a54rc2FEoXZV29+3HpfK0rzNXZ0nBFaZz
	 T6G/YTpc8YpRA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V2 08/15] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Date: Thu, 12 Oct 2023 12:27:43 -0700
Message-ID: <20231012192750.124945-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 7d9bbb494d95..101b3bb90863 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -507,10 +507,7 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 
 	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
 	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
-	if (IS_ERR(port_sel->outer.ttc))
-		return PTR_ERR(port_sel->outer.ttc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
 }
 
 static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
@@ -521,10 +518,7 @@ static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
 
 	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
 	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
-	if (IS_ERR(port_sel->inner.ttc))
-		return PTR_ERR(port_sel->inner.ttc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
 }
 
 int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
-- 
2.41.0


