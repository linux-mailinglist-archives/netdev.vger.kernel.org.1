Return-Path: <netdev+bounces-97266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7513B8CA5E2
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF46FB222D5
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC682BE58;
	Tue, 21 May 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bbswHQZo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44600B656
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255473; cv=fail; b=LsNqtUUv03wlWS8qu/0hkv8cVZtDzkK8d19RcjHjDxpZFAggAbfC2ImO3IWxEHgfK6SvZ/v+STQGY8It3q3JlkbZ9WuOgRFlmIP/i29LpAWOVKfMYzKD6lCY63zmYegvOGbX3N3GkDw4Av8eauiYOkfpgCRHuHDIX0uBBfBImjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255473; c=relaxed/simple;
	bh=IJCG3ZZdN2sAEDt22VJeHKXmaYi4hHubyQ9ojFAHHi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unILXf6GN7uA3IqZ0VXApbU87KgAdrTRN199HzOZADuIHAS/HZOPEqbl5ih8jR2CcmnUB5fm1srQDAwOxYD/ay3S+wIJJuHhgH5o+FV33aV8YEa9XKxvyH+l5tUqZOGvuCgmMprAjCTGyMcK+JMPOISpam1sGZ3MPUePs2izpGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bbswHQZo; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTCOlQuqHPP3Bxr+irpCQT+PkGhE9ixz/VCoN88Oe+YLaj0ioGNPZtoRwdiOZJQQcOrtpu4dGYrT3Qw0974t9nP6k5W+LkviZPc3f9a7yUEoeL17dg02bVOfY7Eiao0uhau5u6bygz0RA+ah53UVdmJM2YkC+NYY6rRlQc9UZ+bmkVl3Yy1kGd0J4lllFMbCbjiEidDlO9tvtSWH6naTzA07DSMNXtc+rksFRTKCeEHCT5E5Ijh1GiUsVx2l5tj5woBL4VWp5QGSoW4KRH1RMPUjCGaJUmbIZQSoLlqW/9Elc0sRoD6D1X6JHUeKoxxBzFs6Pe3KHvMxAa82pn06Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjodDpIBYMKLsFUmpMfTto1WqvZNRB6j8VwT0gu7Ouc=;
 b=oRHGsyIJrSkrbDYFgheFMVb2+a0FI/goWdk3VbV0yYzQAopveJJRzeKs+urIM6bKdG73WO2L0ijX1Krxsb7cX1CYktAafcOzan/s9JMW+9Q0Bld08SiEqy95rjXNeMBOutXc8phR/lTtfWlhAC7Y/QdlRQvDbL1mdIaAmZVGHr7jPUrXq6xvYzeXAbBID2BkurDkmzwbTjAtDm7DwhF/Cy8PT7ayP+aZh9JfzXLA/fWSrRgKXgl/wCQr+u36Eu4bbHogoWetS3gigiVWpaXQJ7UMWiRqMIVV1UWVbM7KMiX/EpN4H/BdKQuMqQiGTy3aDlOl4xqQJRXy9aed27zsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjodDpIBYMKLsFUmpMfTto1WqvZNRB6j8VwT0gu7Ouc=;
 b=bbswHQZoqg/7YQOsDn5EppHJ6kcyApuEXczAcmY0LtWJ0yPqglziX6E26xK+OoXdCWhtvQEUVWZzL2CtoBlJmBnGjMbuDc5o1QJV98z7vwnB0c4XdJlQzCgi720kGPY6kpjrC2O8A8wEbejkra6GNbdIF5IoOq+KxBEfn4ytqZ0=
Received: from SA0PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:d3::33)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 01:37:49 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::e4) by SA0PR11CA0028.outlook.office365.com
 (2603:10b6:806:d3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Tue, 21 May 2024 01:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:34 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 6/7] ionic: only sync frag_len in first buffer of xdp
Date: Mon, 20 May 2024 18:37:14 -0700
Message-ID: <20240521013715.12098-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240521013715.12098-1-shannon.nelson@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e7020b-9787-46c2-c392-08dc79369fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9ZnQe6C+db5V942Tipl9nsp0/TReRRNRR1gwQYTw6BBCmJszsrEAr0DiRhI?=
 =?us-ascii?Q?P6WnFgvByyBTik71hkbcbVgo131clqOLa8LCMqEGAYFAsDUv/EG36JuJ5BGt?=
 =?us-ascii?Q?qyCXjp8fju6gl0PdRZgfcj0gmvzS3f0IppWFCN0ch7RcLkAmPmCNoRyUKbev?=
 =?us-ascii?Q?zgPc6wypNZX4hMjNN+yOAB80LXlpyOHhGsByqkeXuGKO1iZ1R7hhkbhNpoUd?=
 =?us-ascii?Q?Q/udx+BxdvCsCXyWwURSQo7c203Men68mutHLbZaofo0LS6/bd/wxlQuMw5U?=
 =?us-ascii?Q?tgJHrJW9eHkQvHd4MdfJeiVbrdKAI4R6ogOcF9GPdXGfARUQrj9ErbARR4iP?=
 =?us-ascii?Q?ktEg+15WYP9rZH0il6sOuirp9LBX12Sjp+ThoeCStWU2uK4UcUzsMhF3tXIH?=
 =?us-ascii?Q?LaA9giDVPDD1BQzIhkIy4Cd07zzg4xF1e9XBm2yeG26YGi7d8c9wDmmqJcX9?=
 =?us-ascii?Q?h7QiaL3dVrkRUV4Y1UQ1X1Wdg/qwgiwLwSijkHDqWzoYLBERIGke4PU1Jk+F?=
 =?us-ascii?Q?pq/u2UNpW49fZ+/VJ/PpBEkMRAFfeVktlMtqzwNzZzqqfq0HpiHKyxqRISC/?=
 =?us-ascii?Q?9KB7xx2EHGS8qRtJ+xfqopzQzX6o9y9c/UQYf+EZNb0pvhatDRdT2hMQyf+1?=
 =?us-ascii?Q?8XSGtgaiS1bTCuecsaiagGiTrC1CDMx7loMj7BkVTljb9F0qYy4OZjlMlztX?=
 =?us-ascii?Q?Z6C1fPv5+E1obdwEZz/7Lo46mVATW3ENCQRXlhK6pRJW+TciRhaqQnCAcTWv?=
 =?us-ascii?Q?hZnsX4D+g7VYgbg3v1hNuI0rnIrrgJPjuGPzF6Wm2Roqz6FOqeMuTYtp4MkB?=
 =?us-ascii?Q?H7nsQsUYbD0fwKJ1LLiQevz819P6JJAWAszq6hP/mqeN3SEZUSEzrjVe8eyR?=
 =?us-ascii?Q?whpgSw9lOc1yV/RU63zvTsIV73A/PbIlQYPQVOEfWDoP1cHSluzM39KSiYzM?=
 =?us-ascii?Q?rI9aLd7+oAH1bQdFaH1p5uUvpVbaAN6FD20JNmftO26ihAOJFIPYiYjvKy9Q?=
 =?us-ascii?Q?kjr0IbCjgbUn6IS4RtNbnuFFuG15rs+gWfuPxlrMwjTx5RYip+eI7t8KVnlP?=
 =?us-ascii?Q?ZPYxujkZMdJkyjVAMCsUDK+ZlsUS67/QW5805ObF/ogxF7h/KQi70AZPDelZ?=
 =?us-ascii?Q?e3TcNxxOWtrvdk6sCfASFpA2hVt9MIn8rwcbRLq0AHKJlkkbkbAaIc4GmLeP?=
 =?us-ascii?Q?zwaRqCUvcDUSEiHk0igxZl5GPlnFxKT4XSye8trGsZ+QCXE+ctn6K0nKycC0?=
 =?us-ascii?Q?ZHrcppW6iCp0aej9N8L//Rk6Vajd9dyjR0X1VUDpYGVassGVDfaAnIZ4JIjD?=
 =?us-ascii?Q?+48kjpw+AwZ6boo2UHgUtE5zEeanYjKpInU+rPIwS2W8R46sb6JYbbD+kh4O?=
 =?us-ascii?Q?b/keuqxuKsK81evuWcbl6n21nAVJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:49.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e7020b-9787-46c2-c392-08dc79369fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920

We don't want to try to sync more length than might be
in the first frag of an Rx skb, so make sure to use
the frag_len rather than the full len.

Fixes: 5377805dc1c0 ("ionic: implement xdp frags support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 14aa3844b699..c3a6c4af52f1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -502,7 +502,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			 XDP_PACKET_HEADROOM, frag_len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
-				      XDP_PACKET_HEADROOM, len,
+				      XDP_PACKET_HEADROOM, frag_len,
 				      DMA_FROM_DEVICE);
 
 	prefetchw(&xdp_buf.data_hard_start);
-- 
2.17.1


