Return-Path: <netdev+bounces-202462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1557AEE02F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE6B18858EC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58B28C013;
	Mon, 30 Jun 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EOIf5Wpx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640928C00E
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292531; cv=fail; b=sQNpz8DHvhLqzi0b85anqwCkVmydFDXCzxuAnirQNT1128PJXMETqyJrnIDWccc8Ea5j88h43yvufv5MtLq+4yY+stbayMA36OdEcEbkctPi+NndHRPVw9R1Z5+AGHApS4wiwU3rus6u+4fucDjRrihjYnf6eqDjG789i5CIR2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292531; c=relaxed/simple;
	bh=KnjtOf4CJuJagzt2B/fUijwp+MJLl/bV6xJQmrVjZbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0IaquSY3xwZ+CG0eDSwHtHZe3YKgp9ATU+Guipn7Rp6zJ57Vidr9II1KD5t3de0DtpeWlQ4VJGqWI4kLM7KiApH93ynh1z5oX/LbLrURwcKV5QWpsOtu3BnLCl1eszOCBzogkKsFTT5rFPEwxvg3vYwougfyebSsnZxhln6Dzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EOIf5Wpx; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yk5qyG/wwpzXVlU9yKCY3ZwoTa5+6j3+UQ2Q5+ZYHiISvDgwA41TRGIdqHU5AeiuAPWDbfBtamBs3IchiTYotSc1PACXFX1r2xR2dt0AuHWSLDoNGF7q0PIMuGwgiY2cNHWAmNMdY1Eg4eTxhxjLC3z9jP/bUmCuUIJNhzdVjn2R8c/L632BWR/SmU9f7vFOxi3R8mAMPOLVd/JkSo/vh0JbAcxXhMH7t65bDM7tNaxvEsvDJ/RxUVI9eSXiGpIYPfoCOLX8OFD/CrScjJb7Dj6v60vPjidfoRISDE4jxmO+9IVk9L6zvGrLb89s4UrJWJT5SOktm/HZAvXUKNpX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCs3+vjvop7JtqpsrJC1ErZSM3pZ8871ZHCdYgywa+4=;
 b=Hi80+WEvcFE+DsQv/IWefFoalDOBV121VLUH9YDQhZhnq1rD5DSYpHHPyzbfOnpsc/39xPjH7wa1vpeypgFDO6VUzE/BCXRM0F1kBSgQkfrK6vES07k1yygO5Rpl8mjn8mhS20zkkzDpitqqMM9Nec6agVXn4T43GKK1HLzHop9scaIVBPVrH2QtK28FLowLMZ0g5m2uJWK8L5kd5Q40ePyxOgAPHqX36z5Kt5b/mH1FAKHTgH5P5UB7F1O+IZEk10OoFPnHKoQLcYcbqfO8cHf58bjlnbLsZhE60LXg8yGAyDkcHNnBDAdfKmKH+uERJUOTa8wjhtHUzMpT+pN6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCs3+vjvop7JtqpsrJC1ErZSM3pZ8871ZHCdYgywa+4=;
 b=EOIf5Wpx9KO5Jj02XTH7ShzAENLoan7dMw/AVVD4LH0fRBVU4Wn2gDILFSHszG7qaRY6DrRCzVafo3DVlQDGFKGsBIJYiTWf7TvNylU7DRPtAz4hB6G5hP2nztZ7kCrgYzgMsBR17IZAj0ubWiOCbTgIt2HBCojdDoZ/uyLCeDs23LmjhCbL3LNCczOwUAJvAWO+la85GJlTtnMvHNR+LqKhcwOsuUBMKVQIhCKnYvQ9TfHXAlxaU8ayIL2/gUkVmLiormJ/WnKGgmJpxWsW4hMNgyRn+7MCwca1KtSRJ4kEJ4j4+t8DwiThTtqEgBZFdQEC9sXxYGNk4EQJrLx+wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:46 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:46 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Mon, 30 Jun 2025 14:07:29 +0000
Message-Id: <20250630140737.28662-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e97ac7-fdb2-4270-c815-08ddb7dfa122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bg8XfLyjOXhgshyo0cNC2zhiT4TFmuqBztKPA54GCPaCC16yvRHt/HMlJzEL?=
 =?us-ascii?Q?ifdMXSV8EejSsknv1kc5aABMWlM/j9tTqixFsEG7TkB/htX3h7nsTHQ5yQe5?=
 =?us-ascii?Q?pqUI6o7zuJ+PKLb+or0hxyU0HlV0A7AM8IMISfpttZ2/0tIjrZ6nRKMCrUEv?=
 =?us-ascii?Q?SJZGPRfABWATJE/An3ulUX8c2aGQ3XJTxhl7UDKLcHzP8lSaS3xzppLRAOTf?=
 =?us-ascii?Q?A0acbcB9FCxJFTOxiLxlq6JBcyrqPHWYzInFBzU6FVVPdU20n0gQTlMPreE5?=
 =?us-ascii?Q?go2Of9QEnvr9yZ2sjWdoGmyP2ouasQVbE0yZ7ylvhPSMkLMgwooXnQnVf+kY?=
 =?us-ascii?Q?luDZwCdlEitJoa5gRPgeme71G00De/UvyoM7kSryNAu4WtrifEnG6RT3f+rn?=
 =?us-ascii?Q?9F5Z6q6Qu4xnOgTAc+MlKH6tGbNCaL2O1ArLctYQWS7hO5U+aP37m2Yg9/eo?=
 =?us-ascii?Q?GawYquOfHFbemAOMdP6OEyWuImVB7mF5mIcwIgZ5I4YDNo4f8r8HEoAljyl+?=
 =?us-ascii?Q?8MFwFjRbETigcXLFFUog/1nRAwW/HAHpOqEWmnT2HVPoe9iRZ2baJlAizMzi?=
 =?us-ascii?Q?FL1cWbeFZXjRhtQQFX/fnNCPKw138yQaGMvf6qBIs2C+LV/qZ32RC/De8Slo?=
 =?us-ascii?Q?7iOA3gei/2uP9PHFnKABwu8CIGCID0Wz2kMFy4wkyv2fD+Luz8bR+TwBj7RQ?=
 =?us-ascii?Q?llKv6nGUO5btExg+y7zztoiYSNNEA4ITRu/9khzIyDC2ZuLew2XbZDElMdVB?=
 =?us-ascii?Q?BPKW0GndzUswUWnuZVDxzTLjbQRoVcxU7lliiFcfuIz4p4wlf7frTmja8IZC?=
 =?us-ascii?Q?ZpFe+ZSVD5YjOeJnELISHu+gytXA+LefAEKk8qy3qJMPVFG24PYruVpoat4f?=
 =?us-ascii?Q?W35Lxko7x2ziyDJBTOHanlwEngWk0+kGt/vGfD8476PMjz96N+D5kEzpKxGN?=
 =?us-ascii?Q?T8hYWnAayADyqUeDK0uEn8il8XVor8xIikAMd/D9I+RdqG4e2Y6N8LacqWtY?=
 =?us-ascii?Q?QYGQf2YSYezD+bvnhGlmY1MTA9Slz4P2w1PELi97I2pEOy9ddPkqY3KpcVow?=
 =?us-ascii?Q?a3L+Dj9Z3cfz3QKIchPLPnXUJIlQxcbM1cCgp8h4q6YiUfbdp3XYGe6KkD4z?=
 =?us-ascii?Q?jtGIucoA0LOIfI6wDpxDIQDjoEwkxAG/A38luTAwOLTCIC50mO6Xx6T4lbBa?=
 =?us-ascii?Q?xGy0oo4EU2DILKlEQGjrCUpmQTjUYBpgK+EuefwsYFATi+hKJky/OPf1Bg1W?=
 =?us-ascii?Q?Ct0spUDQTraSctxtpxfoOokKz9yeCgoNJCiuQNB3rFawX0p7UwKvk2vS8MNu?=
 =?us-ascii?Q?K08RR6JTmU0YrcSniqHoj9LOQA1T3JesqopBlPVVu8MOLWbA591UzLPvD9ty?=
 =?us-ascii?Q?HxaVvUV0gFLo3wLlt+x0L8b4t6nwSrHZgK7hx6RcUvVnglo/B/xAB4ZPBI1y?=
 =?us-ascii?Q?NI9Tmx4EJG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/0t+C4uXYiRb7YKFB2dkx1beOR4FvzKUpERpAgtJEz8C5AVG7mniEo/zhbF?=
 =?us-ascii?Q?rK7cUpU+cFC6sR3moniok/w7Xe73ImvU5+jbboMsDQgpOWTYlv4SOswekqIj?=
 =?us-ascii?Q?UOrqx+2qSnpbbg2x3rZ1j9j2nCWodsrSgbER1YqR9T9mJF7ziM5G/b35gWrI?=
 =?us-ascii?Q?5Fv5ako1oPhVQ2TzHYYFn01zqEe93kCNHGDw20iBt7yO2WDYX5cZrXn1NCzn?=
 =?us-ascii?Q?HzK644osmXk9r3j+1zqk584BVp7rFZ1/mkF4BuEQjgiDywFgYJuoTO1XEoUz?=
 =?us-ascii?Q?FHvxkVDm6411gRDSfXaNDuhTdsavAsDhx6vtAxzrPcOjfA3PUNtoms6VlvAh?=
 =?us-ascii?Q?yr3nBN9YEquEFpbilwxJabzHwPDa1nrv/Bp1hAahtRTGhPKTE28vj6cFIt0i?=
 =?us-ascii?Q?aNvfZZhX8HptwI73CI3S1r6FXLNwE1K6KlzpBlLZ8+YtdqpnHdyxnf5CsU/s?=
 =?us-ascii?Q?L4pMroI0RHq/48VfX0YsV4GAiDPg+9kAvZG4AsO5B3aFS+HBVYDmayYDM5GB?=
 =?us-ascii?Q?rRES6xeMj6HYjXnTiEif9+1n7XcoSybVDi6SEJl80hjdi3j8YtHBz+i1Ic5t?=
 =?us-ascii?Q?lQJ3+A4Z5wRk+3un7euagxhB6kgg0ttkBJ+V6HUEUxvMao9cM24kwpJE9AAP?=
 =?us-ascii?Q?NgsoaUcZl5MX/VBU2034E2fsydvIWqf6j0TR/jrIybsVUgF7i1FlQkQoLwlf?=
 =?us-ascii?Q?rPaUkBVeUxZ7d41PuWrx/kcaxATJQw2KVrPtQ63i+T5R5gBb0Bfg7JO/6iHV?=
 =?us-ascii?Q?SJXmiPVeDbrF6paJ1nEEMSeq1ftwizv0mCncqkc1LXgYaGdXlduW3gBFhLih?=
 =?us-ascii?Q?Ol9h04PVTKAy7J9velkJKrkvlgNzWcky1y37iJjvursWN3rZJgRZdyaav7BX?=
 =?us-ascii?Q?MgVfOsgaa8D3NCxJzXwIjsgnnKCy5IgFa+TU8UTDQdlVLNOxbVH3ef5887Y3?=
 =?us-ascii?Q?F2ogx6KA57yZhLJ5fsUEE+oupPw5QDB6Av6oBR2fljIEkhEJ+W0pcDwMfLtk?=
 =?us-ascii?Q?d/vaK3FI7hUeVAMk4UbbCAo6Lzq3ZxgIKw+8vqva7G+askn0njKs4f1JcwF5?=
 =?us-ascii?Q?MJfEEyP9oA9LcNmKzuyQTNLqlNl9l7TD1vFDEBucdRf0xu+x1/hQzomc+Bn2?=
 =?us-ascii?Q?XbTEEwoy67pTk7E/cSxTB/a/Neh6qCWHC5dHWtXEl1stek0EwPWzarh5UuOP?=
 =?us-ascii?Q?LtUnyseuB7kUsBx8Vd91BRmwy8b1enRXIiX8qGHW/9l0TV3amEkODgaLJIoL?=
 =?us-ascii?Q?sICl+evapCAu7LZ6LdmEU+Tecaznk5K1kQH86dWKN2y2qwbxpmdpzbStQfq/?=
 =?us-ascii?Q?G1srxg/3bhWCrfpG54kAtN3cv5eiNYeibq2zxKfOe3uGBM2JKFmKFLknfhYI?=
 =?us-ascii?Q?BsSVArzJFh2/KYdGXvDy/WIiAUOBNxsz8gapR/qhpaU3yiD3s6qyplj0nlAi?=
 =?us-ascii?Q?8cdFh7YPtENI2mwvu28KS0ie90uerWAyiyCIcZ6hnUuFyu1mpUmJGxDK4CYm?=
 =?us-ascii?Q?94BWoFoc2avD9ZYpSsj7aWBaTOgqFinyr/tR9uVinmfbx7f+GtJexSQR6TVS?=
 =?us-ascii?Q?YyZ76ifhktRHcSvjtffxHlJkWkD6vlZnDHneyV/Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e97ac7-fdb2-4270-c815-08ddb7dfa122
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:46.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQScAFatuQkZMSgv6WsDUYFkpe5KgDiVEHtXVbOuzS9zIhboJndov0uNxMW/lCTXx7FUCheYR/yomQroOMxYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 77 +++++++++++++++++++-
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 57476487e31f..a1b437b91c4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -294,6 +294,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index b071df6e4e53..4ec55b8881a9 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -265,6 +265,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -821,7 +822,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -870,6 +875,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -905,6 +923,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1245,6 +1285,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
@@ -1486,6 +1527,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_SHAMPO(mdev, cap) \
 	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 0e348b2065a8..c4f957e5fe94 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1598,6 +1598,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
@@ -1625,7 +1639,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3772,6 +3788,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -4024,7 +4041,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -4055,7 +4074,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12505,6 +12525,8 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE =
+		BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12516,6 +12538,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12890,6 +12913,21 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits
+		nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12903,6 +12941,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12925,7 +12970,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -13283,4 +13341,15 @@ struct mlx5_ifc_mrtcq_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index fc7eeff99a8a..10267ddf1bfe 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -228,6 +228,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


