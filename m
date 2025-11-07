Return-Path: <netdev+bounces-236633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5AC3E803
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC53446FA
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A45246BB2;
	Fri,  7 Nov 2025 05:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bUYbPEpz"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F218027;
	Fri,  7 Nov 2025 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492868; cv=fail; b=q+PaFbjLnBIDI4AdCVVeSA4V1pWX3Ob8bLzagKFhdBQfrYLizWa4CH9dsqmUTFZ/5yPTDPVpVcSx9oRv1AL+blL3IQe8kpc7ulrEyhOBgy3h/i4AedYxJ6G05olfEp43rmHNFPsMcNQlb1TjE4lo9uStog8kIul82KRCYtBx6Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492868; c=relaxed/simple;
	bh=42aLsQWPX9GpvrJ4VchRNpQfGSYqWtift4CFE7srJTA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G2l9Rewg8WJq45FpiKqHJ8qciioQvs1hXNgyD4eRD9CcKxhDPLx/ee3QSW966BJm7vPkUnomsnEGKeqD0414r/Pd+DrSXDBv424hV7kPXnSYxGckZt5G/+wv1KiARz9CcwC/JRcnIZWMAnmZXaIzVf/SyRbbKMzlzJk5UinZtwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bUYbPEpz; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf6VPvewMzo+Lacw5dYokA4TbWivRbzN+GKHd9hNs6+L1DhiDZckDvnrCo7rs4sapJd+pbUEcTB9HqLy1nnPZbb98naZPSwdNOl7FN6QQmtmaHENvFPpQInGAmIwkIveJCBVxakD5STdq8ty1DP4iwvg2oS15dqNuOb0LnhdfLZcb3BjHsK9Lx0cSH8PzRb1XsSSGC3TayfLzOW8L+8EhWLCWQwKGV6NJkMnpCf05Aq4xnXSWIL9Y1exlkZSb+BcGgrA/Rgd57VLj+C6f5DQx6rz4mMvGkWgyDLTT54b1vH+32R28wnOLzWOzVcr2xb31Nn2AigPkKiLMvMKD/qnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVPGlQJ0M/KRbfyvK17QhtW1ZSvAEC0y3fEim22WwMc=;
 b=ZA3boQVt85bHpMyYI6+n+ldga7OeIcFOWPEEMFx2prTeIkVgREct+dMrG8rXpUHuq1r4mhQ5EMM1eJ1iYdI5te8U8zdWXzHDl7Ojsb01aULx6PlSsKt7v7pyK1PwKKSN1e9ZkY6RskX6ryd6GAyoqqi3yQmS1clhnjWfvLAc/qy75m9iQxSkpQn6xy1WY/wsIMCdcD9ZYAmTcEtSfxG6fYNWEfGlPMBL9p8QGuxQ6pOXyo93ZBA4f4IOt33KtTzPac1tR8eeXol0yEh0ecgufFt3CL7Tw0tLx5+lsgVyg2Amu9tg9PkPFIpGvUDEHehLHjpgSHFKF1mqK64XUq01fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVPGlQJ0M/KRbfyvK17QhtW1ZSvAEC0y3fEim22WwMc=;
 b=bUYbPEpzDrnii/2SAobzotAmDN6M6ZPCtf4QHqrXUhPXpqkp5j+fd7MIkwcVnhlaQOZa1MTRLWxgE4u61nPxea1SMZ1xrV+TixWycJmgIalc1didueZ2M+ztX88b4LocaCLtfbNM5TMs6YS+7jaXrzr1JmTXoxnzqCfxMq+660QPxEMwB5ltZigUseOR1U3rK2bJCAvuAldw/INfXXvUG8pVgRSs+uhUJjzt8+dfe046ivB3VIt7PmXzEt55qMtmZMAVsVdtlGDpGfl/jFVU5032az/QRxc9wbcgipOvrW2m8dBOcXNAb3gGuiW5cvZ0hjR2LkIaAf/0WYrzNa/fkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Fri, 7 Nov
 2025 05:21:02 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%3]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 05:21:02 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: irusskikh@marvell.com
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: aquantia: Add missing descriptor cache invalidation on ATL2
Date: Fri,  7 Nov 2025 13:20:48 +0800
Message-ID: <20251107052052.42126-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5ba6a9-7d16-46cc-aef8-08de1dbd7119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FtD79VETZGtBEpYV4nV81OHslcrWO4miica17Naem6WbaiRRfdTqts3Z3gJY?=
 =?us-ascii?Q?sjXKgbW8PJr08RdiTH4m+xAGBGt7djxOlkR/gvsbAEL7bCTFtdsb3b2j2tTG?=
 =?us-ascii?Q?MDBlLLuH2H5v/GLptJ9kPha0zkyZQx7hqP64yogdojlZOrjJwFtrsAP84sxu?=
 =?us-ascii?Q?AyRuD3fToTTIgluO5QUT3z6JMkE1AVvhfzYIWNcFm7g+3VhkxWNn03PrLh1f?=
 =?us-ascii?Q?hTFMPxYSKUSkgP37Mqy9QUp4W1VETdjKSglC0+tBDaWNysIvvJqY+Qh2iSek?=
 =?us-ascii?Q?jfsLh+3sxVQ8o3hLjoqWFath9Q6oroWAbVMY+46wsRCKw9dwgu5v6evheC0I?=
 =?us-ascii?Q?OzR9QaEnV1h6neX3XfNO34h+FFYPTMD11qfIHlEenL/dgyWDXS3emQwU9QgY?=
 =?us-ascii?Q?99h3/dvU1c57Kwyh+lvAKqQp3iXvwuFVBIip6rYPmouwKEWgjTeRTqXbMAcY?=
 =?us-ascii?Q?wmDFEgRGn/XmmjqUhE3kDCPhIPA640a0RzeKpeK7h3+pqZgPJA/8sdHgSQFO?=
 =?us-ascii?Q?tiS1rfzj2IgSOUN6IR7xQUylmYO52E0pIF+bTF3fnCBpbx8J6xe6HVlZ5FCa?=
 =?us-ascii?Q?oAwOTXbzB3GsAC1bh28LQVLPIDsGzr52Tcu5bZBouxPpoIWbgtwVNlklirpO?=
 =?us-ascii?Q?URdA+ppEAC4G7OaaSRoWGPPwczayDgrgaBi+Q2R76rufim8MFAOAhuPg3kK4?=
 =?us-ascii?Q?nr0wG18TSpWGUosjpuAhCL5fY+sW3Vw8OOVGbWYtmjkFrY018PQ10xQKIG52?=
 =?us-ascii?Q?RAYMHuyA4hHMO906bLwJRKsMX3SuZnRecPHzjJSorFmHfnBfFGy04KJ/xFWD?=
 =?us-ascii?Q?IF6cZqfl7Kz4hjmFOPb7Ti8dT0P7f2HE4aQC1LrUMxwb8Ta/jqNLURYyFbuc?=
 =?us-ascii?Q?TrYSavsfhQgHomhYJFJwRrDMiqyEt+vy7X7jZh7e/KO45B25L4kxAO31M3m1?=
 =?us-ascii?Q?19BMhUwMxoUJ8i+dU2OyZaHXpu0taumMVhJ8h4acp33RUW56pVvkuo5o6H5n?=
 =?us-ascii?Q?bqX2Q3i9cdnoxt1XD8OUfYP28bP2AnMXO73p9EsR+VDWtj3DP3e3x3hENFWR?=
 =?us-ascii?Q?Tvz/l09ATaMRlt7fK3Xbe0qTYMogq4mENzv60vAR9HVHBQIVce/4su95TT/s?=
 =?us-ascii?Q?l3IB35/5xGgDC89W+SszBYfCr6QLBSAzg78roHHCwbwD9Kde9wL3t1tdtUfr?=
 =?us-ascii?Q?zElnM9AVwoNnF1U595KATTLuupSLiTByUQoSbcpUw244PKvKK0qoCkdi8ik9?=
 =?us-ascii?Q?yCawa/CKxUwurd7PMbjt8l3XzNiF4nT+IcTTHDfMxAfx5wjNwJ/ubpAt7Idi?=
 =?us-ascii?Q?cWVEKhfKoo47IIt5nnM6PaZkq8rvKdqpNl/1EU1r2jXldN2fniqj0f8g7W1d?=
 =?us-ascii?Q?MyAJ2Le+N8Yn8XUCWDU+Wszyr0YgEoa3g6nJ6Cwn6XY04Gp4Yytj4v3HsX2V?=
 =?us-ascii?Q?p2sZqGg5pWF/mnw8ScY3Pb3aG1VmelnW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ouakD30LhlZHUTlJdVbNlrKHAX7NULpbCG60zNFy6nKjSr1SJ3MNURlEuZM7?=
 =?us-ascii?Q?AAO6qdcrTPKYhiONufhPUfP39kPEfK7Fhm7zZ6Qamkg0ylroCc1REv1WA/wp?=
 =?us-ascii?Q?PVyFMA8rJps2px2XJGCIf/Hz19rmS7TsBSSH9bE9pPmlLMf7d2Utcoh/tlr5?=
 =?us-ascii?Q?ZkM+VdFgsAjG/c6bDmJuvsWBqJxZCdViAj0nKR7apjIT/j+//vXKEeSPyKSr?=
 =?us-ascii?Q?gIdD2jCtthJd2PJAEqqRF4KFa0wW9ZZj/C0/Ea7uJldz8l3ieHqusvwkHze1?=
 =?us-ascii?Q?5KXfWHH/DkYlrSEASWNfw+JD9PhkSiZUR99Vwl0xX4Y1VmL18qSscd0qSiLb?=
 =?us-ascii?Q?5VHn+U7dWnbc1kxV3WzroSsx9thfX8lRPLLmRF/F07VHcCxI1hjc0YoL/Rlw?=
 =?us-ascii?Q?pgCGA5Ka56PWHC2Cz5kb/S5AaEesWA18rb56AQ1PZxpPe9KGFSwFb8AKpw0r?=
 =?us-ascii?Q?dco9K9IUurUaOFVmUy94/uN8MEFkzlamruGoq57pUu67BJiAWlu3HEf9yiA3?=
 =?us-ascii?Q?3lwDKzQUuYyELc3JZJ6v808I0XDZ2jJPgyaj4REzIlmv7YAoWvQiiawD3GT4?=
 =?us-ascii?Q?GZjhHo8M3K3Ubhd/GVnRWr47qq9ZQwuQ7sgGXYN44O7k1FNJxUEj4wg7Yoqf?=
 =?us-ascii?Q?f9CBrubZyGJeFIAzDXew129anoFf2dm7gH6QlV0cB1vJtQK0+xlRVUZzHCtd?=
 =?us-ascii?Q?5O2bHQRv2gLYe97fzE0UfQA9zFZ7s9hwIsJF69WrO4P1yuKebk3xUBw2MZP3?=
 =?us-ascii?Q?KqLtKen+RXI3g2PyC1QmEqHPaKmu5w9OUQNYlKP0mXKcFEYlzEbVejJ/nshM?=
 =?us-ascii?Q?aPRWZuO4EinSY5Lyjy+nsQT7BMJzSby+vzzNdsCaNhFhGK/lRe5JZIMVLu+N?=
 =?us-ascii?Q?j07K0Qt9FKJfLo5mlbtFZ5i5a5XVfEKmBEI8REZt2LS1pUWhYZxDsOE1gq8W?=
 =?us-ascii?Q?uT9zP3MEefz1RtutmKRTT7Wntd67boGVRzkrdfV+oyFYbpidQsT+WyUFPNTg?=
 =?us-ascii?Q?GiZQQVg48FMU/bcXF9nJOWboBMbG4U9y+YVuC3l2wBuSp5b+q25b/As+ukvm?=
 =?us-ascii?Q?67N2v1Vn+05OtE4nXTezdBmko5i4+IoUc/SFPnQ8pbB1f0GUUtDuKveXY4ig?=
 =?us-ascii?Q?6IY09/DlF0ivPu201dWFv9xiTF8lT2tfbzuS5hoYjD7NDxNhVltrUGG8Zsq4?=
 =?us-ascii?Q?ZqaMqrKCG4SSlRM0ugDHdzliAJyUESxXaq8bVvAdJzDkkeYCcZpq11fR8JAB?=
 =?us-ascii?Q?DQObBM5BRO+IAdhBAhHaAylL1oBJUEMVSgtiaJN8mIcXvX8JVj+/VIu4J7xF?=
 =?us-ascii?Q?hzZ6V53LFJay4SqdriU/BvIZ6LFYfkBqh8/KsCY7VOknzYKrWjP22S4wD1+z?=
 =?us-ascii?Q?ZIBO36SoLcSn6gFn7D0llQLeB0/f2KxSa5Mb2ILX46mydyTGt4hvtq8OLKem?=
 =?us-ascii?Q?xMI+ZQVcxJKS0al/4xjLn4RN1Z/Ay8Gn1WxmnLYJAiaOhmfRhb2Vri/TAlu9?=
 =?us-ascii?Q?oL2F74e3mWu8bEAhhJ8AoZ9ZfoUbUSePp+PIYsWzWsKSJ9Ve3aI6JtMBg0Zi?=
 =?us-ascii?Q?V57GCfvNPmPuns4TUHOzaUQTgh7E3AB3hgD1k+Zb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5ba6a9-7d16-46cc-aef8-08de1dbd7119
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:21:01.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlGtNhoNPc5KP9UaDSpSudJxxnyKXYp9XK+dG7x7aMRLbsMjfC+kIbPAkinPW4AvbjFd03mjXWUV3TY1QXaxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

ATL2 hardware was missing descriptor cache invalidation in hw_stop(),
causing SMMU translation faults during device shutdown and module removal.

Commit 7a1bb49461b1 ("net: aquantia: fix potential IOMMU fault after
driver unbind") and commit ed4d81c4b3f2 ("net: aquantia: when cleaning
hw cache it should be toggled") fixed cache invalidation for ATL B0, but
ATL2 was left with only interrupt disabling. This allowed hardware to
write to cached descriptors after DMA memory was unmapped, triggering
SMMU faults.

Add shared aq_hw_invalidate_descriptor_cache() helper and use it in both
ATL B0 and ATL2 hw_stop() implementations for consistent behavior.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 .../ethernet/aquantia/atlantic/aq_hw_utils.c  | 22 +++++++++++++++++++
 .../ethernet/aquantia/atlantic/aq_hw_utils.h  |  1 +
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      | 19 +---------------
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       |  2 +-
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
index 1921741f7311..18b08277d2e1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
@@ -15,6 +15,7 @@
 
 #include "aq_hw.h"
 #include "aq_nic.h"
+#include "hw_atl/hw_atl_llh.h"
 
 void aq_hw_write_reg_bit(struct aq_hw_s *aq_hw, u32 addr, u32 msk,
 			 u32 shift, u32 val)
@@ -81,6 +82,27 @@ void aq_hw_write_reg64(struct aq_hw_s *hw, u32 reg, u64 value)
 		lo_hi_writeq(value, hw->mmio + reg);
 }
 
+int aq_hw_invalidate_descriptor_cache(struct aq_hw_s *hw)
+{
+	int err;
+	u32 val;
+
+	/* Invalidate Descriptor Cache to prevent writing to the cached
+	 * descriptors and to the data pointer of those descriptors
+	 */
+	hw_atl_rdm_rx_dma_desc_cache_init_tgl(hw);
+
+	err = aq_hw_err_from_flags(hw);
+	if (err)
+		goto err_exit;
+
+	readx_poll_timeout_atomic(hw_atl_rdm_rx_dma_desc_cache_init_done_get,
+				  hw, val, val == 1, 1000U, 10000U);
+
+err_exit:
+	return err;
+}
+
 int aq_hw_err_from_flags(struct aq_hw_s *hw)
 {
 	int err = 0;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
index ffa6e4067c21..d89c63d88e4a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
@@ -35,6 +35,7 @@ u32 aq_hw_read_reg(struct aq_hw_s *hw, u32 reg);
 void aq_hw_write_reg(struct aq_hw_s *hw, u32 reg, u32 value);
 u64 aq_hw_read_reg64(struct aq_hw_s *hw, u32 reg);
 void aq_hw_write_reg64(struct aq_hw_s *hw, u32 reg, u64 value);
+int aq_hw_invalidate_descriptor_cache(struct aq_hw_s *hw);
 int aq_hw_err_from_flags(struct aq_hw_s *hw);
 int aq_hw_num_tcs(struct aq_hw_s *hw);
 int aq_hw_q_per_tc(struct aq_hw_s *hw);
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 493432d036b9..c7895bfb2ecf 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1198,26 +1198,9 @@ static int hw_atl_b0_hw_interrupt_moderation_set(struct aq_hw_s *self)
 
 static int hw_atl_b0_hw_stop(struct aq_hw_s *self)
 {
-	int err;
-	u32 val;
-
 	hw_atl_b0_hw_irq_disable(self, HW_ATL_B0_INT_MASK);
 
-	/* Invalidate Descriptor Cache to prevent writing to the cached
-	 * descriptors and to the data pointer of those descriptors
-	 */
-	hw_atl_rdm_rx_dma_desc_cache_init_tgl(self);
-
-	err = aq_hw_err_from_flags(self);
-
-	if (err)
-		goto err_exit;
-
-	readx_poll_timeout_atomic(hw_atl_rdm_rx_dma_desc_cache_init_done_get,
-				  self, val, val == 1, 1000U, 10000U);
-
-err_exit:
-	return err;
+	return aq_hw_invalidate_descriptor_cache(self);
 }
 
 int hw_atl_b0_hw_ring_tx_stop(struct aq_hw_s *self, struct aq_ring_s *ring)
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index b0ed572e88c6..0ce9caae8799 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -759,7 +759,7 @@ static int hw_atl2_hw_stop(struct aq_hw_s *self)
 {
 	hw_atl_b0_hw_irq_disable(self, HW_ATL2_INT_MASK);
 
-	return 0;
+	return aq_hw_invalidate_descriptor_cache(self);
 }
 
 static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
-- 
2.43.0


