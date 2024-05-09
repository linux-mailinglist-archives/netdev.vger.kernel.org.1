Return-Path: <netdev+bounces-94885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CEA8C0EDD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFCE283660
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6B613172F;
	Thu,  9 May 2024 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEHlW0wy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529281311A0
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254304; cv=fail; b=YBE8E3YOtlhQEoJB4uexWEFDDOAxMgTmWw53K6EC4XXFjW5JJV/OOGBqH26ZsXkbEOlg6Q8W4/p3BAkgl8xglghrhmhV0UFMBGfxUOegJj0+ZnU7DYE4EX7+jvggLvV1WyDkA5xrpZMnAIWK2YkYGe4RofJAktrQgr5iM2Rdv7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254304; c=relaxed/simple;
	bh=74qneyqWlMghymUdoDfqxHUG6E+xzpTT1KqimUNnFpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ssxja3TJReKQImw/8Ck62dnvLhFHp+WQRWh3Ctp6Be7xO52VnTI+xkCyZuRuOWzRX3onoCM+gucyhG31fhs9Cniz9A9tO1yAntNnBADG9pJTVI04KK0eMV/rlgNCWPJ/OLnVf0kOkn/3L7dP7CjK7f0z5YJRLrVRpWddjFA++qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEHlW0wy; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE/sZjupQsUk/M5AGmhw+flo8dW653WAdbTHQQAZtLC7X+/FYb9Z6iDy+egIrzJ84M88SRM+DbMBDGL9oD1mJYDtUos6+5f8q78gdANVDjJ/V+cBiFjxAq158CavEsDDtL/cFRq3tWolhH9y3MyEN52PU8dGsvftN6+qbk06TPiONeGcpJPaS+LByRArdhx0OrlnIyhfkFsT82ywbMjlXGH3cBCQWPhPexUyb4PLLaiOd2AZNqbJ3vJ6/tKvC8w01E8O7wcd2wzYMzrCFAFXhJkiTZxuDkPSpJaIQropNigZa0dSs56OENSWL0sE7JSOZwu834Qq//cZz/g0oFGKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQqfcbXUJ4EKiMknVoTD0/B1CfkgdV+BMaqOwBNiAAs=;
 b=EtEgfBpFrX5a2MCVL7jfgDfVtaRrEXpEO8IFwE+er3uargh9rO5pdp+/foWUvdE9+8wfmgXIMVW5yG3SRfbaWyCtK20OBEfFIH+klp6e7vK98cZcHkJJucbef2+hINIelrVDjKle+W7Qwu32N8I7DAmn3fvJ9oWKHgEhviBElGHs/YA9j/tWPQ0AakgQzjLJCE0gZv7QvX5VuGuCLZfJIHnd1ptgPYuB9J3nt5ghQ8qyhQNGyMZoiOj/Lt0Rxo5xZsbSOfd4U3O5pkQsyTc/VuSUTA5xEQnXo6hKq3OdU9ivngX8CiMaqdHfY9MgF92sYH3UEFXQ6DsZylWSAQ3JWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQqfcbXUJ4EKiMknVoTD0/B1CfkgdV+BMaqOwBNiAAs=;
 b=AEHlW0wywPEamZOBABO++Ltm0Pq5LgGWHKZO2JqjVMeGo2l4RMhywu4ICgqEM95RQSHzNy1ZJ1p+MbyIVP+U+iw8TsXXc7ia/E8h3ALQsD2eSMqZDCKvs5FovZ/e7Tulu/11K8/IGlijFvPnZJ1RLZvce//smgggS9tKn1zz0zCtYGhHbqH9kXbdRFKlokXiYNUDATbzR9krsm6vh21KJKZab2O42mMgydjmrUaiy3Q3ciEJaU7c/vgjZ0wvSUsQb6n5oB/Oq6E+zR4MzgFZfH7x1rCLW7IE8eZhg7SjeSxFZQ/NQagTyRk2GZAzQ99UpJ3tUT5XP0saU0E4EaQnsQ==
Received: from SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::17)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 11:31:35 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:3c2:cafe::d8) by SA1P222CA0127.outlook.office365.com
 (2603:10b6:806:3c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 11:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 11:31:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 04:31:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5: Add a timeout to acquire the command queue semaphore
Date: Thu, 9 May 2024 14:29:50 +0300
Message-ID: <20240509112951.590184-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509112951.590184-1-tariqt@nvidia.com>
References: <20240509112951.590184-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b7df2c-1914-4e73-99f0-08dc701b94ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQePeTiacIS5AYteOqqD3is8m3grMX0zoFEwGb/6eyh5qruu1zgiKr6A9CbY?=
 =?us-ascii?Q?fggTCsgqFBc4bFC3slg7R+oMnS/Gl8b3WOCpD95K2BUO/5kFFc/xbJnwypBl?=
 =?us-ascii?Q?JXwSi6l3Zc1tth/6hSOIjXEwy3FpEwjsEeSCpeMLn5s36uze0Xf+z1fSvF68?=
 =?us-ascii?Q?ftrV4ychQvf6Xcrn2fyVW8iqrBb4SjjLmG1+RX4FLFKWLLQx2bbVtnBFq9Z/?=
 =?us-ascii?Q?0WPTnFynll/IHodncRu7Ss7zbb/NFgx0LZ8VuZTuspxDcffGLlks1/icbZwg?=
 =?us-ascii?Q?O4o/495elgTFcrH6SQgnhxubxoz65vZ1P8O2AgzFykRj5zV4K8rkAwEc74zu?=
 =?us-ascii?Q?0oHNtv/ElkVGODVVNDZRJcM2QnAGclnHRhCtlXDz0hrQlbek+B4QChVQybZJ?=
 =?us-ascii?Q?8GqgKL49hBvwKRx/l3ccasw1cN4cTfaGfqiKEXYnfQRryC2QnUNlovTDMb4D?=
 =?us-ascii?Q?1Sudt5Pi97BzxAGh50lBw9SyqSCAhaCpT1Yhhl/51q3YVcAX7yOXgRgfh0vx?=
 =?us-ascii?Q?xkLWchY74VJlCy7rZeOHVqE1cZ4+KsD9bbv+9b6fsBCO+q6hKL+SyWb01Cnr?=
 =?us-ascii?Q?f3cM2bR60yMvNOR4sxXr7JvIBPe52wm3mbwVuQxixJIq0QrLCgr/0xbGns9O?=
 =?us-ascii?Q?CXkv5zbV9rJyvuzm7R2L+ZhV2u78tjlI3uiLipTtimJ2beJy8HAvpeXu7Rxf?=
 =?us-ascii?Q?rPqhC9ChEqgbDZfXH0eKU4BEBXu7YwKjf9OrxMsK5HCBEjd5tD7Uh5zjQfT1?=
 =?us-ascii?Q?zdFrghoms+wo4ELL3LB3MeOt6mI70uq2D6DI6mQf+C0382XENnpucPM8snIz?=
 =?us-ascii?Q?SJWSOF6YhHn5SO1J1zNnHQLxFUbIy55SemHb01W7CsfkkPjKAVkrjFP7fGRa?=
 =?us-ascii?Q?RNmpam/ODaAYIqLF1xNdtPgOYkX2iCpBTp2XhmB8TYAgKthOwOSIRJ3uGP/+?=
 =?us-ascii?Q?kAGI3aU81Lt24mKPMCkY1J+GgbLBCZBzEXnxkijHOj2Vod1mczdNjBQJykip?=
 =?us-ascii?Q?ASygkb+m08FFbCK3Jv3DQhJVIi2OcfBAlRa27wslgL1X9n9ZygV4RAVNikWn?=
 =?us-ascii?Q?Zm+Gl0l+95EB2f9gcsm4mPcd4W83rsFMpqSxP3mnEwx4SC1c7qgQwsBHnXka?=
 =?us-ascii?Q?N+ibkySMqB2W8sOd2wQbDHLcS2TtPrSS78TO4NlHSQsDN+vMLrYw1SOfmWXw?=
 =?us-ascii?Q?1rABNEFoByfTsHk8W3isHY7T4IlgW9l5ysh3imWhLQbS9YXtbA/c6e1YqTFc?=
 =?us-ascii?Q?hTAz4Bqe2ZZX6KWFCH3Jhcanm6ZpdmI4QTrvsbudoY3WhfpX/b30HHcZwb92?=
 =?us-ascii?Q?5WfQHQivYcrRmhcSmXmpspJ3PYASFwYYQTGkG9zDiU6dqnt2LJnvhYE1uorO?=
 =?us-ascii?Q?5oeoGee81XleSERkcxIkDeVw4bMM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:31:34.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b7df2c-1914-4e73-99f0-08dc701b94ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

From: Akiva Goldberger <agoldberger@nvidia.com>

Prevent forced completion handling on an entry that has not yet been
assigned an index, causing an out of bounds access on idx = -22.
Instead of waiting indefinitely for the sem, blocking flow now waits for
index to be allocated or a sem acquisition timeout before beginning the
timer for FW completion.

Kernel log example:
mlx5_core 0000:06:00.0: wait_func_handle_exec_timeout:1128:(pid 185911): cmd[-22]: CREATE_UCTX(0xa04) No done completion

Fixes: 8e715cd613a1 ("net/mlx5: Set command entry semaphore up once got index free")
Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 41 +++++++++++++++----
 include/linux/mlx5/driver.h                   |  1 +
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 4957412ff1f6..511e7fee39ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -969,19 +969,32 @@ static void cmd_work_handler(struct work_struct *work)
 	bool poll_cmd = ent->polling;
 	struct mlx5_cmd_layout *lay;
 	struct mlx5_core_dev *dev;
-	unsigned long cb_timeout;
-	struct semaphore *sem;
+	unsigned long timeout;
 	unsigned long flags;
 	int alloc_ret;
 	int cmd_mode;
 
+	complete(&ent->handling);
+
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
-	cb_timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
+	timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
 
-	complete(&ent->handling);
-	sem = ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem;
-	down(sem);
 	if (!ent->page_queue) {
+		if (down_timeout(&cmd->vars.sem, timeout)) {
+			mlx5_core_warn(dev, "%s(0x%x) timed out while waiting for a slot.\n",
+				       mlx5_command_str(ent->op), ent->op);
+			if (ent->callback) {
+				ent->callback(-EBUSY, ent->context);
+				mlx5_free_cmd_msg(dev, ent->out);
+				free_msg(dev, ent->in);
+				cmd_ent_put(ent);
+			} else {
+				ent->ret = -EBUSY;
+				complete(&ent->done);
+			}
+			complete(&ent->slotted);
+			return;
+		}
 		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
@@ -994,10 +1007,11 @@ static void cmd_work_handler(struct work_struct *work)
 				ent->ret = -EAGAIN;
 				complete(&ent->done);
 			}
-			up(sem);
+			up(&cmd->vars.sem);
 			return;
 		}
 	} else {
+		down(&cmd->vars.pages_sem);
 		ent->idx = cmd->vars.max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->vars.bitmask);
@@ -1005,6 +1019,8 @@ static void cmd_work_handler(struct work_struct *work)
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
+	complete(&ent->slotted);
+
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
@@ -1023,7 +1039,7 @@ static void cmd_work_handler(struct work_struct *work)
 	ent->ts1 = ktime_get_ns();
 	cmd_mode = cmd->mode;
 
-	if (ent->callback && schedule_delayed_work(&ent->cb_timeout_work, cb_timeout))
+	if (ent->callback && schedule_delayed_work(&ent->cb_timeout_work, timeout))
 		cmd_ent_get(ent);
 	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 
@@ -1143,6 +1159,9 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 		ent->ret = -ECANCELED;
 		goto out_err;
 	}
+
+	wait_for_completion(&ent->slotted);
+
 	if (cmd->mode == CMD_MODE_POLLING || ent->polling)
 		wait_for_completion(&ent->done);
 	else if (!wait_for_completion_timeout(&ent->done, timeout))
@@ -1157,6 +1176,9 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 	} else if (err == -ECANCELED) {
 		mlx5_core_warn(dev, "%s(0x%x) canceled on out of queue timeout.\n",
 			       mlx5_command_str(ent->op), ent->op);
+	} else if (err == -EBUSY) {
+		mlx5_core_warn(dev, "%s(0x%x) timeout while waiting for command semaphore.\n",
+			       mlx5_command_str(ent->op), ent->op);
 	}
 	mlx5_core_dbg(dev, "err %d, delivery status %s(%d)\n",
 		      err, deliv_status_to_str(ent->status), ent->status);
@@ -1208,6 +1230,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 	ent->polling = force_polling;
 
 	init_completion(&ent->handling);
+	init_completion(&ent->slotted);
 	if (!callback)
 		init_completion(&ent->done);
 
@@ -1225,7 +1248,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 		return 0; /* mlx5_cmd_comp_handler() will put(ent) */
 
 	err = wait_func(dev, ent);
-	if (err == -ETIMEDOUT || err == -ECANCELED)
+	if (err == -ETIMEDOUT || err == -ECANCELED || err == -EBUSY)
 		goto out_free;
 
 	ds = ent->ts2 - ent->ts1;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index bf9324a31ae9..80452bd98253 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -862,6 +862,7 @@ struct mlx5_cmd_work_ent {
 	void		       *context;
 	int			idx;
 	struct completion	handling;
+	struct completion	slotted;
 	struct completion	done;
 	struct mlx5_cmd        *cmd;
 	struct work_struct	work;
-- 
2.31.1


