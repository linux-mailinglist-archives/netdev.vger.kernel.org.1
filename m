Return-Path: <netdev+bounces-207114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96254B05CBB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E305676C9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB82EAB8E;
	Tue, 15 Jul 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkTKQEiy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D292EAB80
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586142; cv=fail; b=FFrupnfLeOb7xQOcW6H9KGiKDxM7P9XQmt6gCMCsoK5krOyz2O5rFfIx9T30qYwHJesN3X/GVO1445DzalJvYSWJgF6GXHew7OJr4P0wDAc1AOvUmbdCh1FdzJcP0wXeWDmoTXDXy7iMG1fIBXxMuHj/dFTARgvsSdeQ8Mp7MNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586142; c=relaxed/simple;
	bh=AYzOwVy/92KbMaCV8KrYDCM/y7zWPcx/jYPUX4PRGDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jK+5ct1rA/7R/PooAovcDwcltW31Hht81FJRuM65kxziXSPy4oNokDd0tkGj+ZshYnVJBxg/oXOR3rxS0piEqptDl10jzcOiveOL37fEASXVgwMOtGuMtQ/KSm4LCjuL/CtXe0czDGj82Yxqi6vChbSSCRnGaAthMlA2/gD/fwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkTKQEiy; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1pxIs9XN4PWHOaDKXPblwVdW3HXnXRLBLLZ3dW0i4rq21BTW3FumJ5SxUsl4zSGJTbOQfbvQ4L5G/sY2gRGNdBr5vhI9wtaDJGXuvFVy4+XOF5GFxzAIA6qcGAgevNt1jICVmZp+9ZU1kyEoFCrvPXHmIyPc9kYKjAP0hDYh5UtChq2WzE5U7AzKWAkwc25j6+aJR1xyd7s5sjD3EarH73OcOPkJdtDOyAedjRYkLf8HFq47sPkNj5Jd02Pt+J/oAS1dYERj/Pb2q5cYM+D6tEcvlDxD4PSk1dXGBZRxyrX4NRwH02f0PrsTdjrJifpn08y2ua1ZmJPF4nbHI4RTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ItnNFypf0I3ON3xj553Z/2PwuE1Y740XmBsJY83guQ=;
 b=TmjXbjyzzgea8GDMEE+UIG663vslTw49wC8v1aVMKwou8fkYtFsbK6REBi2S+jwOuOA0N2EeVSLH9TJVUraF75waoNvx3TBuSszLxVrIoQHZtzBj031clal7/6GqMBimRYk8oul+2WH6Czrm32bDdMuYz7NubyBO3HAhSaKevZK6pNUCSfH00TehsRA9GnoHfr5FSCzNt6H8vSM5b0KFVd+whhJaAeFTxZcvCrbEOqkAW4EmcODaGG/WndHcnbJqsK21d9egBN3EeG6545FWJff5DCixxRkvzTwJ1vqKtfxG0F0D6nK4Et7kUPztYer/LaoW1Q0Ik+bc821EwuOi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ItnNFypf0I3ON3xj553Z/2PwuE1Y740XmBsJY83guQ=;
 b=lkTKQEiy1tEztcAvM33l5USHW5z64zCzxKyfXC7AnMokXgOVHYpjoU9xz2RBu70lg/uDglsj95YYLLafymII+6UDUdPFHLtCR+LFYk1n60+Objbtw9HOBNgqXYh51CF0NQsLeMFTSXzVd/qyRbzkuJEl020Yia8DwwSgcDMv/hYu51GpU+SCsd3hhyBUzrfPc0gC7HPy4o6QafPd8Rw/M3E73d1QlHCB2qJlcPmyF4/tUiZQPaFolFNCdk5CydEEkd2BLpz1fFm80T40BbVT8k8TNR5TpGHgcYUHrrrXs2u2zgEJwEmQ0hG3tsduocd2iJyv72pO5ms98oKAuuiYZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:28:56 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:55 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v30 10/20] net/mlx5e: Rename from tls to transport static params
Date: Tue, 15 Jul 2025 13:27:39 +0000
Message-Id: <20250715132750.9619-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: aae8ddaf-6024-4744-0edf-08ddc3a38bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EU1Lnh8TwLIb8JescCIusbXozeA07DjYlBAM8JkgNEPAX9rjK2YYkmp8xpUR?=
 =?us-ascii?Q?vaZjhoovG6pw/o5zeMOUFF0uECTYvbSq5wjidWGqhO8wXCf5LTzb2S4La18X?=
 =?us-ascii?Q?KvquvtN9ax4O2KtJXcrWyJyKSVZmGvpqHJVINQ9EwRZJU074aZAtPi0MIdGx?=
 =?us-ascii?Q?ZymRX2ewDNSNTk0QLGBfzcGnNED7RIhRa1qGMOw21dCvWFrrxiY4k9Dl27Ln?=
 =?us-ascii?Q?HSEXw64MB3fGyeaK1OqoheVYnED9+BVtfvqw32y/jgioqxbnbDptGMQ6wwVk?=
 =?us-ascii?Q?7eWWexzR0fWjWdMaTatIJTLZdns1U7+9cxH7AB6zxmyPFWSCUGkSQYDNfVb9?=
 =?us-ascii?Q?0wKWjimUHO5u+7ssTCJHVhSTYpf30xXcmsFjWABj5qg2rmwo6nZvCF3UjQNu?=
 =?us-ascii?Q?nno5WYvUMQ6D02dYK+bKWPn8VoZYl5s73nXxZG8sI515600cjQAXCt4OpXF+?=
 =?us-ascii?Q?N6McMThCCNdFoaIzaEzOlv+Js7yFon5lMUyfOmTkxU3rcUBI6WoQYWDVtGt8?=
 =?us-ascii?Q?y8XGuJ7ZzxSCgCau9BtbHiyxZNqj/bhZs5SCJ3N9/WGW5dqF8pr1nF2fVAZk?=
 =?us-ascii?Q?P3qQD/bReFvfpCvDcnfjBSRpay7taB6IPBr/X1MZkBoag+R3WUtOlKrc5+Sz?=
 =?us-ascii?Q?8fRnDZvzXewjFrXeDlPi7xc8lTMaoMB9U9SudCiAY6IVxyv6fv1DOFJDRUO6?=
 =?us-ascii?Q?iMm7fTMUWw0aszaPq7Mso0p3IrEkCEK/PFWwO61iOYWrwKuAAfmYGMB+Jq6I?=
 =?us-ascii?Q?2GSCoeEnkJJZ0TQrQ7k+vz4Kk/NpYMlKEBtUTha9dxm6WvoKeQ8RlAhBAivK?=
 =?us-ascii?Q?eJkGF24tMWiYtjzzPlUtwNVE8MJ4ztGtLeLLzlARw+M+D8ZtlbvXAynMiQr6?=
 =?us-ascii?Q?PmPHo5L03qTbEIMW+Vv3B3fw4sLC04O6bTWX/B5ZlPErgF4gLEqG4cjutauQ?=
 =?us-ascii?Q?Pt38AHItVMNP8IW3K+DuxJMYop6gg2l5P3os9JATfx/ubnDXGHsf+csw2DQE?=
 =?us-ascii?Q?yOOe+HYzjSCB7JDwImPhJbIqMdmuk14Ul7rEJWMEfKE7yigPx2SKaFr/96tR?=
 =?us-ascii?Q?e8+4MkA/cPNe7DzmErVLxs789Z5d8UsLpIGJKy3VEMapu4W32k/9/32ZnNKz?=
 =?us-ascii?Q?PM4pfmyOOpBWAiO+vaaQS4oCe/lPBwO6UJ/QHK4YugmSQ21R1D0+HSuApNYa?=
 =?us-ascii?Q?Z02Cbvfp0xEiOLWu9pu4mV/ePHdwTMLC+KnyAq6aZsgczrOrF1OR/th9uY5Y?=
 =?us-ascii?Q?JiAcpwxEsU5LqpJuVH082fFCgRWgaX6DX6LEHp6EQ6seKzPXxLWkrrZoFnzT?=
 =?us-ascii?Q?cQ02Gd3ifVBJRGav8A+pFbGeheWDcgidxGrY0B4RVyaUtP3QPUaH2XVBPay7?=
 =?us-ascii?Q?gMkh8St22n7McilRDqg+wkBf57geXR4NuGTvPDI79w2Ftf84IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r4D7VyI2wJ14jwY5npLbTbV/5XrIkC9UqDNX2hD+AL4nCs4kEIN/iXjvJdIJ?=
 =?us-ascii?Q?9Tt0UK4Sr81mwoknp6PGq9LIjeBXEtarhZVZgxFKPH8EE7fWixsQAc2XWey7?=
 =?us-ascii?Q?Fc3q55NXrJ4yb09f4dY6wmHlXmkmkqnVjc7BSCLUhxBxukCwp//2+Ozzkjq8?=
 =?us-ascii?Q?4H6BdFivSSxJvYyXyawMhuTbNRO4AzxKX3+VeT5DohCk2nVWkWJTUUst2c8z?=
 =?us-ascii?Q?nqxojouqc/zFV8o6hu7MXVQ/cfs1glovoUoyq/JgxAAwObrh9eC1nNi4m3de?=
 =?us-ascii?Q?3BT+bu5qIwaV+5rYY/LFjDRrOeVt8bPVjKs+QwXpw6wh6B6Mgpe0DUKb/6jP?=
 =?us-ascii?Q?4o8EV2m6JdUU1cOTGq75Fp/0xtnZRjeKbg0f3IZbPhriBKIUACvUWMy9KhXW?=
 =?us-ascii?Q?Wl1UlvoTPlEoY5CzhcXocwfuYzTvmRCzjGA5sqs+e2V3qmwqNtCmeB8ZM7vf?=
 =?us-ascii?Q?yYAU90T9t/RsP13UXea7MNttIjkK1K7tnbOM+rIz95xtVi06Wob8qZiNPvYt?=
 =?us-ascii?Q?fK22Fzx6DfBXqnlxPmfRugNK11pXwyVjsnWgpXRcwjEDVAxWkcl/OtxW6e93?=
 =?us-ascii?Q?SuE3qHVVX583aFlNgI6zbAK+wtVy5HUbBQqSJ6RjuKZtsOyDbgL22Ulbut02?=
 =?us-ascii?Q?Z0nT2alcpDfn8pHzpnhBQrRR5eAHMYfDTImLSN4DDSvH8g3pzfWFT3iKlY+0?=
 =?us-ascii?Q?9r5/5fitS58hH2i3phAFxao94yCLzaiNhqPUMujKJvmxd464HS7c/mC0UJ10?=
 =?us-ascii?Q?ENZZXvxPgt3Wq9lqRPqE+02sIkcSfPDQnjb/7fZHReh5bDCRsPNxQUQeaUeE?=
 =?us-ascii?Q?X54NiQXvaYCZdze5kLhv/qG3m20hh/bmkhSls2c32GQUZbd8xUeJtNxSk/AM?=
 =?us-ascii?Q?nhHTHhMjz5pF0IYwDvenU5j98gRoXQg+CtqVzrKjISpbbglfH4p99WHdnr1M?=
 =?us-ascii?Q?C2PZSppU6Py+mi6MhAOt+ZtfDcPdx9FkTB8uFtbi2NroRBGEU2W5XwpWJX3r?=
 =?us-ascii?Q?z+nToRFrdH4WtHUDpkHzMB5AzS1humeri9oCY8Pi/sDXgpw9kUuIff8s6z8h?=
 =?us-ascii?Q?bXVIAK7QSuumvnblyJdnXzFCSKKx/WzfWFLXor0mWxBKHKLdaIABTuk2ungA?=
 =?us-ascii?Q?HBrIK/0VHMlzFOoCxiGGIPTo7z5Vf6gw5Vr+Cbfln1T+ookxRWaF4ncwH8Jd?=
 =?us-ascii?Q?U+O1mjj6LL7pYkqHRZPOxWGLi3nArHHz6ALcXqWQAaK3XJp+pn/lpiB5U4AY?=
 =?us-ascii?Q?KwSH5Jcm4qrDyPXKM7lNV0dzgsHVhN1g5xK/Lpq2ftSfPOPRlSG/ZP6fR8X0?=
 =?us-ascii?Q?fmYGF7e1PZwJq1YSosaXgSZjk7qdB8b1weh911s/5ouMtUwhiZvpxtjXoX3r?=
 =?us-ascii?Q?FEIijVeA2OoEwRKQ07B9h2c9dpF3MLOawhPUrthFHwSas4lFEJn3ipDNs6cj?=
 =?us-ascii?Q?lgumzpMO+SD89xzxCied1FmJuM/mxHiIqGFyrmEgrKnXwclQr+JyltNe5U7e?=
 =?us-ascii?Q?djdoKVAO0BXfou4kEY4gOau+yaG0U9J5bEsTPuSJMCZ1yGzIyw38jabXihHA?=
 =?us-ascii?Q?hTJIf/xXw8BUIU5z6LQifz2OjQ+Utrw6IurYTjXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae8ddaf-6024-4744-0edf-08ddc3a38bcd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:55.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDd+fZbj7igBUCxwceoO6CDwP3hsMFxlJk/5rKdoFAtzQkL8xqmKVQpA9ayZrLVQwsd79p4mi3FdELDODIQRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Or Gerlitz <ogerlitz@nvidia.com>

The static params structure is used in TLS but also in other
transports we're offloading like nvmeotcp:

- Rename the relevant structures/fields
- Create common file for appropriate transports
- Apply changes in the TLS code

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/common_utils.h         | 34 +++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  3 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 +--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  9 ++--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 41 +++++++++----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 +-------
 include/linux/mlx5/device.h                   |  8 ++--
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++-
 8 files changed, 75 insertions(+), 51 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..b3efed916167
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_COMMON_UTILS_H__
+#define __MLX5E_COMMON_UTILS_H__
+
+#include "en.h"
+
+struct mlx5e_set_transport_static_params_wqe {
+	struct mlx5_wqe_ctrl_seg ctrl;
+	struct mlx5_wqe_umr_ctrl_seg uctrl;
+	struct mlx5_mkey_seg mkc;
+	struct mlx5_wqe_transport_static_params_seg params;
+};
+
+/* macros for transport_static_params handling */
+#define MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS \
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), \
+		      MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, \
+			 sizeof(struct mlx5e_set_transport_static_params_wqe)))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ \
+	(sizeof(struct mlx5e_set_transport_static_params_wqe))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT \
+	(DIV_ROUND_UP(MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ, MLX5_SEND_WQE_DS))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE \
+	(MLX5_ST_SZ_BYTES(transport_static_params) / MLX5_SEND_WQE_DS)
+
+#endif /* __MLX5E_COMMON_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..6787440c8b41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,8 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs
+			 < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
 		return false;
 	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..3c501466634c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -136,16 +136,16 @@ static struct mlx5_wqe_ctrl_seg *
 post_static_params(struct mlx5e_icosq *sq,
 		   struct mlx5e_ktls_offload_context_rx *priv_rx)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	struct mlx5e_icosq_wqe_info wi;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, num_wqebbs)))
 		return ERR_PTR(-ENOSPC);
 
 	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_rx->crypto_info,
 				       mlx5e_tir_get_tirn(&priv_rx->tir),
 				       mlx5_crypto_dek_get_id(priv_rx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 3db31cc10719..cce596d083a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,8 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev,
+			MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +551,12 @@ post_static_params(struct mlx5e_txqsq *sq,
 		   struct mlx5e_ktls_offload_context_tx *priv_tx,
 		   bool fence)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_txqsq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_tx->crypto_info,
 				       priv_tx->tisn,
 				       mlx5_crypto_dek_get_id(priv_tx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..fb21ee417048 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -8,10 +8,6 @@ enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
 };
 
-enum {
-	MLX5E_ENCRYPTION_STANDARD_TLS = 0x1,
-};
-
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
@@ -20,7 +16,7 @@ enum {
 } while (0)
 
 static void
-fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
+fill_static_params(struct mlx5_wqe_transport_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
@@ -53,25 +49,26 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx,
+				   initial_record_number);
 
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
 	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
 
-	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
-	MLX5_SET(tls_static_params, ctx, const_1, 1);
-	MLX5_SET(tls_static_params, ctx, const_2, 2);
-	MLX5_SET(tls_static_params, ctx, encryption_standard,
-		 MLX5E_ENCRYPTION_STANDARD_TLS);
-	MLX5_SET(tls_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
-	MLX5_SET(tls_static_params, ctx, dek_index, key_id);
+	MLX5_SET(transport_static_params, ctx, tls_version, tls_version);
+	MLX5_SET(transport_static_params, ctx, const_1, 1);
+	MLX5_SET(transport_static_params, ctx, const_2, 2);
+	MLX5_SET(transport_static_params, ctx, acc_type,
+		 MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS);
+	MLX5_SET(transport_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
+	MLX5_SET(transport_static_params, ctx, dek_index, key_id);
 }
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
@@ -80,19 +77,19 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
-	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR |
+					(opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords =
+		cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
 	fill_static_params(&wqe->params, crypto_info, key_id, resync_tcp_sn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
index 3d79cd379890..5e2d186778aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
@@ -6,6 +6,7 @@
 
 #include <net/tls.h>
 #include "en.h"
+#include "en_accel/common_utils.h"
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD     = 0,
@@ -33,13 +34,6 @@ union mlx5e_crypto_info {
 	struct tls12_crypto_info_aes_gcm_256 crypto_info_256;
 };
 
-struct mlx5e_set_tls_static_params_wqe {
-	struct mlx5_wqe_ctrl_seg ctrl;
-	struct mlx5_wqe_umr_ctrl_seg uctrl;
-	struct mlx5_mkey_seg mkc;
-	struct mlx5_wqe_tls_static_params_seg params;
-};
-
 struct mlx5e_set_tls_progress_params_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_tls_progress_params_seg params;
@@ -50,19 +44,12 @@ struct mlx5e_get_tls_progress_params_wqe {
 	struct mlx5_seg_get_psv  psv;
 };
 
-#define MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS \
-	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_static_params_wqe), MLX5_SEND_WQE_BB))
-
 #define MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
 #define MLX5E_KTLS_GET_PROGRESS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_get_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
-#define MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
-	((struct mlx5e_set_tls_static_params_wqe *)\
-	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_static_params_wqe)))
-
 #define MLX5E_TLS_FETCH_SET_PROGRESS_PARAMS_WQE(sq, pi) \
 	((struct mlx5e_set_tls_progress_params_wqe *)\
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_progress_params_wqe)))
@@ -76,7 +63,7 @@ struct mlx5e_get_tls_progress_params_wqe {
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_dump_wqe)))
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 9d2467f982ad..1f53befa2514 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -458,8 +458,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -467,8 +467,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 639dd0b56655..f4a5b814a8f4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12914,12 +12914,16 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
 };
 
-struct mlx5_ifc_tls_static_params_bits {
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+};
+
+struct mlx5_ifc_transport_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
 	u8         const_1[0x2];
 	u8         reserved_at_8[0x14];
-	u8         encryption_standard[0x4];
+	u8         acc_type[0x4];
 
 	u8         reserved_at_20[0x20];
 
-- 
2.34.1


