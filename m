Return-Path: <netdev+bounces-57187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4F81250B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9301C2140A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7F63D8;
	Thu, 14 Dec 2023 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO3haGEe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507863C1
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4ECC433CB;
	Thu, 14 Dec 2023 02:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519729;
	bh=Vgt79KNSJqm4N6BOoHCRp+JwJR6taL4+yLZr+l9v2oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OO3haGEe2q6xg84xtqo073/xhzg6uS+HmwwHeuc/Nz9blazox6DHMDyK4XNbUorZq
	 zIZZmn+6SgVyQs+lGKAW6dyeB51UMqVZjKhX6z9aEqOAJmLmB5ToJbBYyZoHhfLrxi
	 McBvBC+1oYNCbVg+J5V5XjZGc4/bXhUfjKhDyh7c9+mdz5Xotxzz+AJ9WjHDHApOT/
	 vqBPSHa79hk1Ppjgvznei5OFsdbcSKLAl3S9Gj+LtoISYri+k9xPlWZ2K0rk2Tywhm
	 VglMHD2NbRkc2YAcGc4tfpNAYtTVniDPxG1zvqk6FlM585qu9HmeeuTbTQYtSWpNYP
	 NQJjq76YPQEpw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [net-next 11/11] net/mlx5: DR, Use swap() instead of open coding it
Date: Wed, 13 Dec 2023 18:08:32 -0800
Message-ID: <20231214020832.50703-12-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214020832.50703-1-saeed@kernel.org>
References: <20231214020832.50703-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1254:50-51: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7580
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/dr_action.c  | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index e3ec559369fa..6f9790e97fed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -1170,7 +1170,6 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 				   bool ignore_flow_level,
 				   u32 flow_source)
 {
-	struct mlx5dr_cmd_flow_destination_hw_info tmp_hw_dest;
 	struct mlx5dr_cmd_flow_destination_hw_info *hw_dests;
 	struct mlx5dr_action **ref_actions;
 	struct mlx5dr_action *action;
@@ -1249,11 +1248,8 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
 	 * one that done in the TX.
 	 * So, if one of the ft target is wire, put it at the end of the dest list.
 	 */
-	if (is_ft_wire && num_dst_ft > 1) {
-		tmp_hw_dest = hw_dests[last_dest];
-		hw_dests[last_dest] = hw_dests[num_of_dests - 1];
-		hw_dests[num_of_dests - 1] = tmp_hw_dest;
-	}
+	if (is_ft_wire && num_dst_ft > 1)
+		swap(hw_dests[last_dest], hw_dests[num_of_dests - 1]);
 
 	action = dr_action_create_generic(DR_ACTION_TYP_FT);
 	if (!action)
-- 
2.43.0


