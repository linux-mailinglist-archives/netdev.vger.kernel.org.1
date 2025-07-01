Return-Path: <netdev+bounces-202943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B9AEFCD8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875E83BA3C3
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C862277C86;
	Tue,  1 Jul 2025 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bcTxrDKV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B167277807
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380984; cv=fail; b=dwryC+br0xOba4qAmR8ClXGS/0YyZk8XJPm+IdWS08goGAokxsHDwzJ24GkAOemsiyPzHe6vjVuvDwE+KbXSacX2PrNx9iIr9jG1XCn3pgsUDr1tt2wCYxFz3PIQQeS3FtfNEMPB7AX1L+8FbaNJ1/UCLaq1atWPkwc5eFUSDX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380984; c=relaxed/simple;
	bh=/pBW0e6VW+aEQ70L39fM6xzB8lDhPTIpmYFgwD/1k0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grlRaQl6G6EQdNkK43z9rh4I85HCpB6M/3TXT+zBj7IFzwtfCxjotqQ1UZAdJRdEVHKV1wLtZ538P/Y7d/AJoHpX8NdeL2W233RIvKUaaLF6Uwyno7RGzg+ZACgGOfmIy159oi9nReixBlE7sFFPURk5fxUmo7enBoY2imKKRT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bcTxrDKV; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlhenvGSSCbK+kTxluWF24NYjNVhmeLUffreJO081Hlqyg1mySkLq4mU+1eslmfdcF/tIZC+J9E5V5v5l/jd5f10dCIhu341CaIfFVCLPdwzrpTqn9wKm6uJFAy7yrIRtFkzYtJD9FoWNMTEvmA5MrX+wlLHKm3Qe8Lr8aNEL3sSVf2WwV0YetPW3XLaYynM0gp4pJCAvBisCKM8IZ3jMtStG5OCpj5DfEli5lq6nt01FtG1RhmBt5vlj2x6JIVIGAG5HCBKfa6tUcOhGG8hFeTBosEG9ckRo+cotPzjpZxoi4qG8FLAetfASQe5K5VCWOsXePLKdm6fVhRu29hrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvaaJzBMMN0i1n5Rv4tqtM2QOTFyrEq2xvoEvpIDu1g=;
 b=rZQYiMs9V/8vohyVYO5nd2hp6gXQtIxcjAtaKYdw9XzcLfkym51KFTK2OSe641RVlmibAOkq0wjoZAEYdl3+kmlzUlF82qRRjx4sCiVA7z7swUfD0whZm64Yiyl/vz/i0KhhMXzRquFx8qUcn/tBJ/Afbh6mRMFLZLD/WAtNYM6k+gP/hJeCSNRg1b7AKrXiLzc2iCRzXPzklBcz/lLH6WHqeElJ8WZLb975LHIydwAFZX76AMqBTcOqGy8Hy3qriGdPCtTWUlX0VmTm9VZH+jF4ddzMBu0yd/CM+5ylOagpqfRo1JtQj1Wfyxvsv08+iqWPxmMvpchRjDN6WDoZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvaaJzBMMN0i1n5Rv4tqtM2QOTFyrEq2xvoEvpIDu1g=;
 b=bcTxrDKVo9JbjygWiLAVZW9k1FnYBbtZiPic2tL0nXB9H+9oUO/0uRJ9m7SsLdGGmIQfrdu29ZAYGGAIyd5zm1zgXtL3gz+XDJTuTFlqMIXq/aGekja8qAesEK4F9Wd2P3I7bVpoHImoXBDlguMiSU7UetYfBGAYZmdjR3QMTRG2pn/YdeevpKY8LDbxmTbtxPszKayD9jLonk72BLnaWevMDmQp/9JbH9f6cSpICgQtj9JhfcW8KIzKMINTOIGzu4D3XmhXG4Fehe9rdJXEQhDWoTi1OooAcmUT4MYS0XvsSi+c9uRC67zPElMTB3HQxG9HX8JaAiNXoU9oVF9bQg==
Received: from SA0PR11CA0165.namprd11.prod.outlook.com (2603:10b6:806:1bb::20)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 14:42:57 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::55) by SA0PR11CA0165.outlook.office365.com
 (2603:10b6:806:1bb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 14:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 14:42:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 07:42:43 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 07:42:41 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	"Ido Schimmel" <idosch@nvidia.com>
Subject: [PATCH iproute2-next 1/2] Sync uAPI headers
Date: Tue, 1 Jul 2025 17:42:15 +0300
Message-ID: <20250701144216.823867-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701144216.823867-1-idosch@nvidia.com>
References: <20250701144216.823867-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d7716b-e05c-4f54-73ec-08ddb8ad921d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWnEedbK+/7Z36J4CBxqQzVCFIWUwbSW/plO4pTpvfAIdgBRl4olmbN+5C4g?=
 =?us-ascii?Q?59Qwx+Rq+vIQMi4X15c31a+3xk1TLogz+57PAQ9mHgM5P2LaYb40cA3uFQpW?=
 =?us-ascii?Q?e+3GsnOYj/NflMHLCICHcSkhdmveaHZgn3pHmMa4Pkhj/LzVL/M8cyeZzEFV?=
 =?us-ascii?Q?Py0FwT7XmEC0mgn4IsE3rSDun/vvqKX3ZgZ1p5h8NnbIz05NN3hKP2N23GP9?=
 =?us-ascii?Q?+YtLpPL10zdj8TuKI5FKnD7dkwxeljf/I84R2RSmGDeKMfJ2iRgr6HlKaWMT?=
 =?us-ascii?Q?nzrIDRIt83iEkB4cdM8VYIRnAli1DGHt1lg8WRogYgzIFtMdPb1hVxsN4a6P?=
 =?us-ascii?Q?PEp2VIliPfEatFwrC84U9AyxjFs+b0/4DwHNxf3jqxCkLmdTH8Q+/nE5rOB4?=
 =?us-ascii?Q?fLVMfRYVA+MfB8qwtBH3kQ253uh/Y4DKdQXXFBtl3OxOFA5ZWxZFB3SKTx8Q?=
 =?us-ascii?Q?bP8QibOOuDTLOJl4A6xzgfTTxK2XcAcJDW7ggp0JChUCkqpnvyMX52/1O8Ca?=
 =?us-ascii?Q?ofx7hkXoEKCqydiIaYLYf/ndVonEDd5Y1PcBA1MXujeGRjauYyHXzrUnNC5n?=
 =?us-ascii?Q?yyjY3Ao2aAFKdNtuSfuBvc7vjbxca0ujIrGY/CM/mYUpHgdgq1S8UkglVjNe?=
 =?us-ascii?Q?NMXgZDS0Onvn+jv1x6HSr/9v2F9WT/5cUrkjjph7f1sKfKslEQkU5iGEbuHn?=
 =?us-ascii?Q?92jUSSZTNEQRCBzDOS8zNlaFkpbQVsEGPuMLJIrSRzZT3Q+1u7RLTEDuPaT/?=
 =?us-ascii?Q?Ktfjifh4CqmJLzatLAR0gdPG/FlbNI4PYw57BuKkXuy5usTL7usbYwYMewOx?=
 =?us-ascii?Q?RRKB08WqJHFU/0GGEDPd+0b2iZBahiI4qV4HkxFsBzYsO+kLYL+vFjMkIbR0?=
 =?us-ascii?Q?zm1waeCqdiTI21O+XWgW5pfqVNzQho4u1Hkt0hox4TAoZ6gKbXDUI5qIqXqU?=
 =?us-ascii?Q?QuUtuvztbsjrvIWzHR08TA5uECsvd8GX66vMspWhHWjwrvUtkACHCEisw3Er?=
 =?us-ascii?Q?tZiTNi5GDxMMjTQ6K1snLi4E4qa3ekG28J6bY1goHZOSanOvGEUB56MmhS5i?=
 =?us-ascii?Q?md6QlkaesRhdXU1Bxg2rok45fy4tO1cS42e2/g6AR1YajmOJhZ9TvxCLfh/8?=
 =?us-ascii?Q?SAdkYb6ZVt21P1EVwAqCZfYe6Pfx3l7LJxHpfgrE7Dqq+fRR+1Jsl19URoMC?=
 =?us-ascii?Q?nuBznzYFSiZLql3y6YNh9xrgi6qCiPqn/1obCfPYCgwn+2vSPV1StMLbDqkh?=
 =?us-ascii?Q?/JDW8alp68+D4MVVLjlWotrY+q6Ubik7AnlQvCb7Y+4gF4OJLoqOlh2jKnhA?=
 =?us-ascii?Q?cYkrPIROwQFCcK9PsgH6rQCCdhfziNFAkMK/c5Ihs3ayw/4oNaZGdVrG2wFQ?=
 =?us-ascii?Q?Q7/EyfdhfspxV4alDq1bbR5wEHHQpdePzrgpbg2r7VqR05OynLw/0FgrT5Fc?=
 =?us-ascii?Q?YHdYuaURG+bWoDWV0PH0ngTpouy2CgRPVjkPJr3YQbu8J0ThpC2fWleyebYE?=
 =?us-ascii?Q?TE06y+7qbpWU5BVIQhsAEq6GopVz/lcPCaDj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:42:57.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d7716b-e05c-4f54-73ec-08ddb8ad921d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/neighbour.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 5e67a7eaf4a7..1401f5730a00 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -54,6 +54,7 @@ enum {
 /* Extended flags under NDA_FLAGS_EXT: */
 #define NTF_EXT_MANAGED		(1 << 0)
 #define NTF_EXT_LOCKED		(1 << 1)
+#define NTF_EXT_EXT_VALIDATED	(1 << 2)
 
 /*
  *	Neighbor Cache Entry States.
@@ -92,6 +93,10 @@ enum {
  * bridge in response to a host trying to communicate via a locked bridge port
  * with MAB enabled. Their purpose is to notify user space that a host requires
  * authentication.
+ *
+ * NTF_EXT_EXT_VALIDATED flagged neighbor entries were externally validated by
+ * a user space control plane. The kernel will not remove or invalidate them,
+ * but it can probe them and notify user space when they become reachable.
  */
 
 struct nda_cacheinfo {
-- 
2.50.0


