Return-Path: <netdev+bounces-233064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BEBC0BB67
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86A8B4E4758
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A627AC21;
	Mon, 27 Oct 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="etvgMVAw"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449571553AA
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533439; cv=fail; b=lNFb0F3XfJWvEuHzIeoMBXGtABM55WLnrCymRoFUp303ygX+OfBm2yNyoyJLLkrB0qsYpserYuAKrEsAGFboUvSVhfunycf+czICApsmJ/PlI5XQiRkEUtKSeS0e1xCVxT6c0PLXjkvBb5Bhwc0X+vTG8Y8Kx2O8GxLOe9cGVmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533439; c=relaxed/simple;
	bh=sNhdHUW0eDexGRCKCnURvSmaYNii5fo1nE7vnCQ1Reg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nc6DV7y/e/zhozVFBYbRYbYdQJCwEVtZ1gUQ6UYrPQo089FYMiLZDSP5ZOJHrkgXuyGlpWEBcm+wQIsWx7f0SUv8knvr4ZZ2CGai/xSOYJKZn1VYZtTYo626NctaX1QusbeFa55MLaM3ZL30le/vo0Q/CCsq2xoUV54Yr1357RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=etvgMVAw; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ73hP0O+lwiC3TfZ5XvI5Y+/lzSfap+Suljn0OuCRz6C7MJV4hAmWro5BeGpd56eB7GTgKDPF0XqjMB/xDscx53/JH+pbrN69YQNFyVmI+UOX2A3vhZpYEG5eP+TRttCTmU0jNfgFtyD1+SV9NldzzKfma3qr2vLtUZ9s2A5cK7ZSH22IeH7vlN7GAJYVXLXZoGx2VOQO1e8JXfEAOgJXLoqjDXVnEupwLb/3LKa5ojqLRJlkbjR5bK2R7otH+lNvy3zS6dfyymyocZo4xQF4FUUq6tWL9j6BQJK2JOPKgbHRKS9mvTfH7jbbcqxkK+bGktVRS9TIre1hRvJgCH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zVaI8WmWaP8lDI60dynudoPuTCO3uYlAAng4aJD6mM=;
 b=bChc+6C4Ti5A/v2fneUFOO7/azPQfiGvppXQMr6zgA5OPwr/Rfr95b8HquK7euznyRBYbgJrBD8pd0BSwv1RHheZ/h4m8gPYKqyQBWVIjGT/71amq8cCikdTSlNJqmMFDVTHktTt5dODl45NagN6V+Sv6CAWFS+T9PPfMYTXchtTKmzw0JtsCwnaKNL06wjD4DeNhCmrVeAK4kBTQPVVNNPKR3f2Db6URx0OuntCdQprOfb4wqtVGq+dgGB7DiL4ptSmNLEqMnRJx36T7s5c/GLzMinpKWI8aiWriZb2ljio2ltRpV+kWc2Xho2hHgt6VLK5LXpXAHXP5Vj1J+pGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zVaI8WmWaP8lDI60dynudoPuTCO3uYlAAng4aJD6mM=;
 b=etvgMVAwyZPj7C/tv8JXg59whIsQiXc4G9MdM1FgV3SfGrvAlpj3gJScBWf/PboMjsp+67Ps5ozb88961/NSuflT7oSvBeejs03CGQztt9Y8l+istpQmLApvNHO71uv7btLZEFxbUEx2K38oSpfZTK7xWkDPDar8scbR+6nahnw4BRt+72yTf6yC0mer4J6H6mfHVn3AivD6kZ8IPE3nLqRywES1M0AjVWA9U4x7VR/9oIX8eKDBbRJVsdcFVpJZh6cKhsUNSON4UQrXDMmkWbdG8mVHxvRX+W+G7nqan6qMiQ0hVVbSVNEDfQmLd7Iatud8rkqr/aKVFKPMf27B7g==
Received: from BYAPR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:74::34)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Mon, 27 Oct
 2025 02:50:34 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::4d) by BYAPR05CA0057.outlook.office365.com
 (2603:10b6:a03:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.9 via Frontend Transport; Mon,
 27 Oct 2025 02:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 02:50:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 19:50:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 19:50:16 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Oct 2025 19:50:13 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH ipsec v2 0/2] xfrm: Correct inner packet family determination
Date: Mon, 27 Oct 2025 04:40:57 +0200
Message-ID: <20251027025006.46596-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2b0d7a-7307-431c-3053-08de15039a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gy0mnc4buDpx1zvqcZjijdKL93QPzN99vri5w/qT0DaThhgCT0mXrb7JrgP5?=
 =?us-ascii?Q?TrSeNjbtbZe5H97QEh6FZBAU207bU0Rz3Zf/rPP5A2jaYuALav0or7UmRnor?=
 =?us-ascii?Q?PcOxKJKQ3u+xbDYx+0Rv/xK6w1iFSL/koRqIGCrPQ+2r9YbODurz3RiATu8o?=
 =?us-ascii?Q?i7PB7dWeMI5jkg2XM4SFiEcUpH8Nz/570it7vihh9jDsB/a3X+p7+YsIyEZg?=
 =?us-ascii?Q?OjG6oPAdABEwCgKWycRJK+JoB3hKLxguN5ZgPvzHopEdhTJOHMawAalLD6W2?=
 =?us-ascii?Q?Nhh9/Weqlb+lH63AkiczAHZ/hx+CHlTzjYA9jzbsQx4AYUa5SBy0GfEIGPLF?=
 =?us-ascii?Q?pIz7PLyVa0H8zMvZxwz2JFTlXUV5Tqbeoxs1nRpLyap95MFOLeZF56Vev3gq?=
 =?us-ascii?Q?zUdU0B8MAhhy2Add0lh5cD9n2GZPnYQZugU/JlvHyxAM87C8crg8jNR5vPYd?=
 =?us-ascii?Q?BZmbGx0wtnDOMQ74zLBnUnuJMy/OrYaqKqsDlzcvqDLIKamb4I8R5yUA/ubo?=
 =?us-ascii?Q?FsPWWLSF55rBq/apLQ7sEkEntvXyG7x9PxFL1+0U2KY7UElsge/ky7cbH/1r?=
 =?us-ascii?Q?NFgT8fXpGD+pqGGS03F3iOG32f7urbdeC7h3J2UMxQmF+2bSgtw1h9EUhbcq?=
 =?us-ascii?Q?xHcFcCp0vJDozPNCCKqhurwUbHTY4ReDlA/h83x+45tl4/8mzAFe1i4KpzbN?=
 =?us-ascii?Q?/xu+RNgL8/91Vd2THrsanOKHjHFGbScVh62jbaD+8N4osEH93HF1SP5ZCZgj?=
 =?us-ascii?Q?KS4GBM29MT5+5fSHowCwPDBr9JYOR7wPqYhdRN/ytidykB6TIq6QLDCZ4x31?=
 =?us-ascii?Q?lM42SUFyvLk5AHyyUDUdfFIQahmTOnyLow17bmR2OkQDzBlkinPsw4gNOWF+?=
 =?us-ascii?Q?wPaBBeBtxfaQQGbkKHmcOSGHt2DVKQ/26SRA08ES20IhLInvIXBigOq5hmGk?=
 =?us-ascii?Q?Rfr8s0Ymp1M4vjSZquOFbEVDN6n0rTu7JdAvYmIi7SUUezSlVObI+Anie4fs?=
 =?us-ascii?Q?ur4qnoxFR4hmIiY5lzI6u4APh5rSehOSAFbCwgkPkB8eRloRysoEqnSitL2F?=
 =?us-ascii?Q?Tdr6vujrwrpHUAoaDtZkBGlw1+A5tKihAXninEczJdZoOlXn1dGjSuWDUZbJ?=
 =?us-ascii?Q?dqbD7PHQrYdUCaoqjtWrtV523DA9g17mYRgallvt61KmRPA/abTbF3FAPXG8?=
 =?us-ascii?Q?5XD68NOuFFeqtO0XejOU08m9mgUefjZDESjcf2lTLXahEZTB35cOqtocXpk/?=
 =?us-ascii?Q?8DK3GSo1gWMooqFfrJCpPpMY/25J/goKG8oGa32wKFCE7943hfKQqbj/xKwG?=
 =?us-ascii?Q?RzMKqgUYpVeRxoo6DHr+OnkyrW/+XFqECDU5XO/eMmLggPZNsTChegzz0dN4?=
 =?us-ascii?Q?bx/eNmnM2jzHsQ5w3Znogpovet6xKz/TaoXxTXkkffDvLnLnrWLv7u8iRvL2?=
 =?us-ascii?Q?fBSiAPj28qxJdjGOvXq5wM6ZdIP+jx7I80H6ecKAysDhlNAatHRvU+0mxo8A?=
 =?us-ascii?Q?pGeT++nIAbP6dK93p1XKYNrDPYM2IOnZXLA9ufV6FbFRkVEOHIilJkSmO+/z?=
 =?us-ascii?Q?KigVFuJ+Btm6mICwcBE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:50:34.5159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2b0d7a-7307-431c-3053-08de15039a08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362

This series contains two patches addressing issues in the XFRM
subsystem where the code incorrectly relied on static family fields
from the xfrm_state instead of determining the family from the actual
packet being processed.

This was particularly problematic in tunnel mode scenarios when using
states that could handle different inner families.

V2:
 - The original first patch was sent separately to "ipsec-next"

Jianbo Liu (2):
  xfrm: Check inner packet family directly from skb_dst
  xfrm: Determine inner GSO type from packet inner protocol

 net/ipv4/esp4_offload.c | 6 ++++--
 net/ipv6/esp6_offload.c | 6 ++++--
 net/xfrm/xfrm_device.c  | 2 +-
 net/xfrm/xfrm_output.c  | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.49.0


