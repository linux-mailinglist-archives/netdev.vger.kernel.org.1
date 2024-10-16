Return-Path: <netdev+bounces-136011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35AC99FF48
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330C4B22055
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C8117D896;
	Wed, 16 Oct 2024 03:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2899175D38;
	Wed, 16 Oct 2024 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048737; cv=fail; b=PVb9a21TlttRx2BJXhdJFUDh8hAZUQqq35H+l0XUQTZtng0EDq+Bt2Z3LGVn/aZdRT/BQqUuWH+MMnpyvSgPrd/GbCUxHjCF1DB8PMPuZzuRyZzcNUNHK3ThumGY+Hq+x2LHqmwKu0J6gxSoaKwsexFAn2GvMX5Wp1iS2s1kxZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048737; c=relaxed/simple;
	bh=u1Q10BFW/DyTkhUIIuFu4NjkdPUfdB33VsAzc4py3iw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U8CPMLoeY8Jq3mHSopIBCoJA7JvqEsG8ULDUk/hIZYn+Di/5C1mt0Lc2X/1qQ6up/tKAVQIh9++WykO26O3+R7PtAUgJGxA3dPnLVvgK249uDv3s3RHXa5zkN8d3epeV8UELAsJmBzTc+N01M6q/J46ooJUmlS/jGGUMnV/h/GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYoW3YhCu3m8Di7UsU3Qy3z0bR/wkGtepXyFizqBKwrFZzgNf/qowA24iStnqR0SjbJ720ZzkCmpl+2siiVB+VtbV4JU4gBEJNmzLwUXf7YLFlnNFvH4je3bMhPL4lwJRLRqxCu5Zz81qOtHJeFlP2TfWn/g27pmXb3RopoOHU4pV4KhfokU6ZvRtWKS3iI26/Vbl7ubGfNydZ90Dr3F4xCn3+KIYhOZUGUg8F8TY28eaWzKEoCTqTrRLyzzW1kDJpDg07IWtd/+Fm2KI2MkMXG1nC7fggtx+qHGEUSItEgsycZN+Oq0/miwW7HtsCCWFhMnI3QOmUj/yf0+7KwRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSwxmf8AL0xPfXwPmFBe2RI9rjc4dUwEgIEOSRVIIgk=;
 b=jYNC4ET/plsA7Tqdbr0IkefEDTdnvS1tu2o0rfgPtMI/oe4BSSzACujk/CQyYpOJg8wp03riKbcce4PZXuwpxYHdUdxGt0mBck2Cm74C//SgWZBQitP1Tm6/k8xym3Tcm/Yf9m0AWkY+Mng6CyZvaJv3FLJUXPgfozDCIambvay141x8V/IpbbTuIQOBlzyhyFShhesLvOyJSeRtU87O71KuWEegH3jLvdK1Q1/WZI5vq9Q4Qo8G3dwuX7999NJ+cYBQP3asvbS483aEDlG4krgTSJfXLA66KyhBC0EVTZM/9WMBkBmzPTvwSOed4JFxbGzE2tfM2g8CEo+Jo09t+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 03:18:53 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Wed, 16 Oct 2024 03:18:53 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: [PATCH net v2 0/4] net: stmmac: dwmac4: Fixes bugs in dwmac4
Date: Wed, 16 Oct 2024 11:18:28 +0800
Message-ID: <20241016031832.3701260-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0053.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::20) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1011:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fc9293-377f-4340-c01e-08dced9142e6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|41320700013|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	Mm5liCrycDHskuEacaBjSfOBpCviGJmWnOj+6ysmBL+L06w8+pdAAxAYsHpIiCN7y1wZc9hS2S8QGuVu9LD+jYXFcu8RE5L3hOqjbZ4EduWz4UZQXOpdvsH0+fEwhEV9UKSHqk7fXKE6CLY4pQEZotKtaKDeRqFo/Yug8TxMM/qVUyQCG8dIMIkH81xwGfs/stUY+hcWxdnMtkInbWQlmIMSOR50hu1swBKP2qO3wE/E+wCwWuOzPBnBMVZjwYQZsXVQkL9HjPC/4YEkuz6gIYTTrm+ICj/mIpiy5ShKpaMgxNaOqImrTK3gT5hDgSe2SS/oIePPgoOppYkamKmmi0JvsjFtTZGGbwQ9VH1qbKxZJd9jc7aBHLj7qgC7OF5YjOgzz1M8pL4eXvKXaUyn8LQU55pqtfOefR5WLXBJGlGP3VpV0N2AOG03c0QHbflDDYu4Ts7NMwSsn2WFZ28T3IxW4tQ3BFuMBDY4RNP/l1R7RO04lMeqiYuc1Kiz6Nxlf+FeE7t4U6gXoMiNY27HiWDtanfXJo1htFZN6cwU8/YtqyWv/+5jAjCw6upX6m7+/3ppz/rpiq2QivM25bsLNdosOb0M46RrO0RVQp6DsPgKwnOw+yfKAjz9+CeaHrG4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1AFIvn9SGdRTSsVqtjjlfWoc2eQzGQQ7vvj4YCba+nbKqsRsX90rs+UjyV8?=
 =?us-ascii?Q?WoeyCr/zmrkUpK55SWD0kE7vq9cuc5UnDDZgBySKuifmcc/YmBwNALzLywH4?=
 =?us-ascii?Q?o48ck8CjnriAUXDlTQ+NFXaby2CjMYJIZcjPIXKHzqAAU04KF5fPOnz1jZiA?=
 =?us-ascii?Q?UEXkwHxtKRXd9oJr3r+nk6jCpBJ8Vdn3ZEp+dP6ZdFF2TZnMeOWM3JB96+La?=
 =?us-ascii?Q?ykUCPdIEIZqtoCa2sIPSsPidqbZBeVRjebObkbFoYeyt70T12Ya2gJfGtWGA?=
 =?us-ascii?Q?Jr436mx9XDOmYuiggF/aRaW+D35q3W9rd5LdEAc2ZpC7WOp9oE+o+ARQhjb1?=
 =?us-ascii?Q?p3Jo0OGx26oonBqtbVIZtoL4U3wzEojTPxqvCE+rE5aH5bsny8tuElCUXLwg?=
 =?us-ascii?Q?9FAq48wrI864DnXLzVVYmmlVjl+q6/JSKyWS8cV/keg9CiUbbS1kBDr2la/Q?=
 =?us-ascii?Q?LBSbYMm3rhZa3tzIu/kgdlVC8m/ndq8qdpIZwMA4eqtZKjNpbuFciRKONdSP?=
 =?us-ascii?Q?a4Pzn0viAAqLyuLSB1JodMIA1k7QfJ9p35a15JNV4cIFZMIXJvIebU4Xp5m6?=
 =?us-ascii?Q?rNGWq1dAzMAUR5yv+upKD6jAf5vJtrbQPEcm212XzvIaKjjeu1S8WdP9qcXX?=
 =?us-ascii?Q?lOAKrkj39nDKL03TvXjqSW4yx8oretukPl99ruxaPnF6Tt+dUX/5BQBmVA8A?=
 =?us-ascii?Q?HwtduOOcDL+l7B4EptJT3GDEmMMDus6h3NqvE9I8C5lAvLL3Ejxvxma33EyS?=
 =?us-ascii?Q?hpjkdNWn3o9hlLN24rOis/CeGVWKp8Pl5fS+2btVWwNpki/xjRTdpv+F/TxO?=
 =?us-ascii?Q?QGS3r3QfPb8Cbu0XmfqfBJZPdPMvEPbxtXVfSY883I4la8mQze17uKX1+yyN?=
 =?us-ascii?Q?GG738h/LubmD+LJHYbKRmdfQgGfR+taJUJXAELaXdx3Kx85gcfwBCQYHDue5?=
 =?us-ascii?Q?NwBOrDrVcNg/NYJYbW33C8Vouj1imxaaWhOcxfo9CqxNcer3tcrL+hCPBmvL?=
 =?us-ascii?Q?yUQCHZDLzbLz6ZWOFkaD/0vrddO0GIX4Iag6bV15tUKz9GxSFufjBH6qi5Uk?=
 =?us-ascii?Q?Sa3Ki6Fb9cYIYv8Q/tE6VYBleH94R1QVLmKE5M+qQgySgS7jBoNi+w6w0vLd?=
 =?us-ascii?Q?1LhlFcgh6c09KJ5SfBU8ixmCLdSNkWaNJpFx3XU+o1/tSTnL865RPPXhh9/E?=
 =?us-ascii?Q?B7bswwBKkatgDdbJMBAKxQ8yBX/ECJGsZtKjLf2vrFs8fD7RZ3z7aVNDA1Dm?=
 =?us-ascii?Q?/IlptaeE2BsZjeeeYSnvUBn+bB4koWGHPeHSZOJlWySwiZ7LTc1gALa4okI7?=
 =?us-ascii?Q?94NI0ZiN+LxIrnsmtv7dgTwvnOVhrpTuoDJ8HgSbdCw/Uc+4pPKQsIP9rmLU?=
 =?us-ascii?Q?eiU5w1MFjwdXtQbzQie4FU2xU8nhoqZuj1y4BRpadHPs57KEEOJzMoHtVbtk?=
 =?us-ascii?Q?D5eKF1ZZzOfUEVBxeVD7J2O9yDTsGOlwX2B/76CyeUmG+2mT8AbzBH47sxLg?=
 =?us-ascii?Q?Doso0/x9fi02voACT/wXpMmLAlMTU2xEKBruoGcK6yMP9OVFXqZTzM88mwz1?=
 =?us-ascii?Q?WCBaCdeNo72O3biI2oVDSL+ME4rmCS5o/Yj6H23oMuT5zVPcG74+Hqvm5FsM?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fc9293-377f-4340-c01e-08dced9142e6
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:18:53.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qryjQIebNJno6daNtzSOVMqQpgBOTICZMSpNHnIEmctPCt189lZ1irQGcXcrQKu0Jnr1MORC+Ilcayy7UBor2SGdtXlQci6J2/FjQ0RltRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1011

This patch series fix the bugs in dwmac4 drivers.

Changes since v1:
- Removed empty line between Fixes and Signoff
- Rebased to https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
- Updated git commit description for patch 4/4

History:
v1: https://patchwork.kernel.org/project/netdevbpf/cover/20241015065708.3465151-1-leyfoon.tan@starfivetech.com/

Ley Foon Tan (4):
  net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
  net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
  net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal
    interrupt summary
  net: stmmac: dwmac4: Fix high address display by updating reg_space[]
    from register values

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 12 ++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h |  2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c |  6 ++++--
 4 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.34.1


