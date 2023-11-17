Return-Path: <netdev+bounces-48558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418BD7EEC92
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 08:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288911C20431
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE06DDB7;
	Fri, 17 Nov 2023 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE388194;
	Thu, 16 Nov 2023 23:20:00 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VwYll-M_1700205588;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VwYll-M_1700205588)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 15:19:58 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: saeedm@nvidia.com
Cc: leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] net/mlx5: DR, Use swap() instead of open coding it
Date: Fri, 17 Nov 2023 15:19:47 +0800
Message-Id: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1254:50-51: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7580
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
2.20.1.7.g153144c


