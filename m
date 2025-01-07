Return-Path: <netdev+bounces-155981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3EA04806
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C567A0268
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154EA1F2C41;
	Tue,  7 Jan 2025 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ks7yKeuD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0A1F37B6
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270254; cv=fail; b=YPoZXMuLnOi1ytsBpSity2jH2yqKT1TIrsE78kmyvE/uZm4WnWVV6iA3o+xbveXEZgTsJYLFJSGlR01LIuL5JdbOSP2+n+BPLLQ9NJZYcwjieX2qHSABKX5J9YV4l0Xx+CkGP4LgZs3GE6ZHNFUqSe2WNiCKM9DLhVEWZ352Ewg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270254; c=relaxed/simple;
	bh=9sEhZjc2kRagOUM2hC2CqUZA4S/1TCg79tp+AmEFQ8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qaCF3UG8jdnbdOt1v3v6dfz8DdJtBJEfK8gjAeojtBefzLBM4LP/jblMPUAbXx/KpjoIY6gbEgRbG5AsHStebkb8i2V2PO56IDy30l6IpKMFxIDDmCISGlqQ+tBARAEriQpc/jEmdmNq5jwc1xcDz2Li0t0oikLRwodTJZVkXng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ks7yKeuD; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxy4LJV8f89AMssjhafZMbcUJZvf51kJ8S66SE6MmfkbiEsHTMRLHzZmnZI8ifF7qgQPSTkFyxanLpEIUvwhuR71LGNtDJv8OKXsVHbXw0FgclzHwx4QyIsHXbiaBtsF1TIXAKmJTsWxypWnt7b4rJScwvlrE+SX152X1KCf1pQk8R2Xnq3zXlWYP+UC2c2aSJRrlf69uCv0waVlxxApHglZzunkL0UMt1VOrS6gEN1/X63yrvXE1wFhGf2jQWOUzY8NQShVJ2UsDinoSR0RYi+LvYmAwpv+PbZCfxCAnSjyHZ+mpZ7csV15p/KLDKGx7LmD7u4Tggq6R3FDu9dayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTEDDGXSih9Ocg4kTeuLubS3Vhlx8VjmWIs6tRgyBD0=;
 b=iuEBDM0OXHX8uYOmz4WjuMmtpZi02azf/WZwvrWvoqEZWdmDEksmv4bDazC/o628RxQ4K552IBhlfA86R/WDw0XAmPUBZ5fBgvZS0hltbQpS70lxRsDV7Pi9vcgJ6130Ms2ncBz+k+mNlu9KvLynMYlfkszA2spTKPzVNsqL+44ZbvNh0NJ7+O8+t3UZjMDZ3diEe6R/OWtacSJtcZ1nwr488DX+ZonJb5NMns9ndCMzWS4dPlGnWPVenpXNXUTr9eEOjou0xgT4rrhizWYGlLiaNH/wRzbawgVuhrItTJ80kcUIYYlriwdm6pJkpA7IEjU6QIrl+BWYUA94Lk/xYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTEDDGXSih9Ocg4kTeuLubS3Vhlx8VjmWIs6tRgyBD0=;
 b=ks7yKeuD4wd/oC5/V0HX588qhnoso18zNlMPlzIUJEOIQg6MfOo28z5v0wqghrM3zP+Ssbmy3X5qI0xKOJ+fQYGplOmVAhNB7Fz7NLCqBJvBK3lwzdle/ndOPb7wKCx3yCuIOSjNuE7WquxRiRHBjJSfoCmAFCY0/Dcojt4tDvs2PPlm8Q9bzNKZ9u1BZl/DlhZ2jqGqnbFe3Mb599btygFmW47/faB5YRRwxMULpWltyD9wP1eP+9dPDmz0lAtJ+/Tf4Zda3tqm/hsZFVuqULAKsLQllMookCqDR7r4WZwPcJL7bO29zwIVgKv7IAjigxcakyUpMliUwHjuboK4Bg==
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:17:21 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::67) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 17:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 17:17:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:17:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 09:17:02 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 7 Jan
 2025 09:17:01 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH ethtool] ethtool: Fix incorrect success return value on RX network flow hashing error
Date: Tue, 7 Jan 2025 19:17:55 +0200
Message-ID: <20250107171755.3059447-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 21580c0d-c011-478f-57a9-08dd2f3f2502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3T1NQU5ecpqBqGWZ3rMIl4/SnNFNXtUFI6g/SkDUJty9rJi3SWGApG5tYzJQ?=
 =?us-ascii?Q?rJlzbhyB2knAmrBGaRCCZNcmPWHHjj+ySffbfQFQH3/wMoZA+o4egL3PStag?=
 =?us-ascii?Q?r2uE5jQhP1EQ3cDY9/osKPouyGBTP2H8Ne3vt7kDKByQhc/X65zkOGoJwbZ4?=
 =?us-ascii?Q?m5Nj9kgg/5HCTub/kWi6xfUvJH3Ty7N5qmqr+EhBehKufhBzFs/zaakvPGUS?=
 =?us-ascii?Q?X4xTcbnUvCnyPVw+c/LI9YD5qeCIhMMFt7VHh1j2MM/g3TTkejE6BQe9Igoc?=
 =?us-ascii?Q?cdrHd6/XF+zKAhuW/b2ArIhJY4HutfEZ5xEQJ7+MfsFbwPPeEcOVDupTXeNr?=
 =?us-ascii?Q?kLknTMfQjGNOD4Iq8KsURO0Poygeu2ZAV12LsfoAbJPdPiGphu09U28ctnz5?=
 =?us-ascii?Q?JWHkdGav2MJ4xYjWY0MRQOT6QPiV5jTAbYVP/m13a5TR4roFX0abffsM9aSw?=
 =?us-ascii?Q?vnTt69CY1OcMGrwVxulAahDKBXz/AiSTb9ph8XD6y5lkI4Dz+AVfIkylDgHs?=
 =?us-ascii?Q?FaZbXu2WNgnkESdLvcU5NxJChdavcabxtLkSumxHjDMc6XSwG2AL6vEDDsNW?=
 =?us-ascii?Q?k4gcu3jnk36DFulIzLR0XwWe6oU26QJwKwamC08a/6XZpQv+4H/br0xGURxb?=
 =?us-ascii?Q?xdJwM8zVZ32y6gYUb8h9sFJ6B3YwbO2ekxHg9DiWrhOZ7s06WLcBaB5PA1L5?=
 =?us-ascii?Q?RjggTpJXzBlGTgxphP0D1hkT22UXDhkAkTDrwmJw4cxnJtWaw3Jcr/FlByS7?=
 =?us-ascii?Q?9j/UMtDXUWOnH9fYZ/REyFSg5OI1erekcpT29HxE3sV2IJGKHvEPzuqoxBH3?=
 =?us-ascii?Q?wfGDQfktYgHocxYaqLuxWAgAOyXXg6rSSlce0UJpyBfV0unXjZJ1+Py61m+s?=
 =?us-ascii?Q?xcNhJ7zHdCZriN3H7B61JID3EVvnEHfogmxyFcWxs+UleLz7tnxkZSH6xTxA?=
 =?us-ascii?Q?CMn5PuWf3jt6JZn+ZtcrL5ge1HrpabT5JNGYTMpt/GdpUM4Yzl7GU6DmWf/g?=
 =?us-ascii?Q?FfLNqzmumB6IfyT8DrIndrOUBBljzCd3A0LEAL/VYYozn+B+k+wQzJBpnRrB?=
 =?us-ascii?Q?BSHwxx4qqfRAI8vGN3dhTmqoHHir1pu8zHFz23g61v/FCuoTt7rgYuu2ZQo1?=
 =?us-ascii?Q?5rduneCi5O7+SYUbWN39UCyPa4SJy94HgtEIFJsmKb1K4TAoYcXB3s3KX5g2?=
 =?us-ascii?Q?FGgMavsU7zUSg0rcHMiVbyrC+jha7Yc1moicWmy/yDzgvKD0+8HFkH2HcKs/?=
 =?us-ascii?Q?uJmlpcuDSqM7tYq7tuPKUhr4LzKnbGFG96GkpuEHtHrIdQoK1+OpadBmRvbZ?=
 =?us-ascii?Q?MpPUhYfJJ1aDxRjCEO1FM+fxSOFXHibw+8vilSt08g+qpKeef86Dy23WM4UH?=
 =?us-ascii?Q?NmpaWZUebvy0lhkBOP5EruFSRJYRi0rlnAskzxAkfbZBwPx8ANpg5X182G61?=
 =?us-ascii?Q?N4k5uiWAV6TFWWzf1oMgtsmdoH8mu4VN+ZbAyR5LRTfkb9oIDq+Qcn+tMP1j?=
 =?us-ascii?Q?akx6hVedtbLHwFM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:17:20.5427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21580c0d-c011-478f-57a9-08dd2f3f2502
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

In case of an error on RX network flow hashing configuration, return an
error in addition to the error message.

Fixes: 1bd87128467b ("Add support for rx flow hash configuration in a network device")
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 1cb5b9ecf094..a1393bc14b7b 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -3883,8 +3883,10 @@ static int do_srxclass(struct cmd_context *ctx)
 			nfccmd.flow_type |= FLOW_RSS;
 
 		err = send_ioctl(ctx, &nfccmd);
-		if (err < 0)
+		if (err < 0) {
 			perror("Cannot change RX network flow hashing options");
+			return 1;
+		}
 	} else if (!strcmp(ctx->argp[0], "flow-type")) {
 		struct ethtool_rx_flow_spec rx_rule_fs;
 		__u32 rss_context = 0;
-- 
2.40.1


