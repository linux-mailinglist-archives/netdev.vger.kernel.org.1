Return-Path: <netdev+bounces-209027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA19B0E0C8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830153A2964
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCB2798FE;
	Tue, 22 Jul 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RZ41+X5A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CD2797B2;
	Tue, 22 Jul 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198888; cv=fail; b=BP+1HBemI1/VEOoyONIyyZa1Cxx8dY1t2XmUj/UAMniQe+bh9iRdaafap4qe+9EUrY64/LvtL8HJ6h8/5QwWfbOC+UX1jJs+koRsSqYSSI4dJgyj3FGrzmBycpEZ8pQSwmI85jDM7uGfYq5df0kwUDsk+Lb3AxY8FijKySnLdpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198888; c=relaxed/simple;
	bh=lSsN9Dk+sppOV3leczY399YPFvCvstxhJI5/9N7+9JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD054z+bMz9EDKIcjWjiUJmupSGHLI8UirnhNgxtRlcKcEJisd7kUhh2IBruD6UPjl1+fjqe2ceVT4lPm/sMSLOe3AjWacIU9TPe7IbQKyPDq830mJ4qCbPE1NbK9M1k9tRvh85Be+qKcIA7uv05tNqWiO9HauEocOEPGbJZbLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RZ41+X5A; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWvuIDRsyABv0YziSjFSsEcs1fAdSOy00BPcYmcD7+y9O0kLm6aJCiCFwbSoGtUtgXI4u7gDbZN9MutQ6LC7IKLsZfd37evmEJnoqnlvxS/TwUw+RQexVQ+QQWMUweKifPuLQGJlsLdgqCUDew5y2sU/ncZ96DUpHwenQBmeg6v+1i6Sho96t74VtCDTv2WP0oIMecFOPWmubkHyyRv0rcGXwZBaSpb5E3eXRIQbPHNbBdYp2NSn8JOCSbH7CABJDtvte0LadI1og9VUeU7D3wNvklz6MNRDGARtutLLmcxGrDrMHOevwzmpRBRerNtG65eboZ1uBSZ1aOpSH+CJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze8BKKgEKKKWF0qDdNJGmMqYA6yQ5CRMNUHLUSomBJA=;
 b=ZtYkobfmStFHy9eq/YA9Xjov+pqJLdAZRsx/QkLKrCmSdzLdG5Lq2/KMMMnxM4vIEzbEdMcle4qHs8iHub2ACf7OeNQAX25d7Oue5Glz32wDVbxWzSMrLBvMklkVhLEAQolpx1TgWkWPqQhz2Dqk0U0MxYLVVYseIW01EzC7IiTO5fUL3FC46YJ3ik6DaKwgf1Acbo6P7LFKjj83UqbHIslqJR03B9R6OS/SdabgsbtqT3kwK0hiD9P656mCJfVnCwk/fUMOabnUPzp9/J3DyHFd4ZD8zQwVUvAfydQ+V0+OHtiYhRvpN2AvMkBBfVtAzNqp1snEeViPNN0JBhQOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze8BKKgEKKKWF0qDdNJGmMqYA6yQ5CRMNUHLUSomBJA=;
 b=RZ41+X5Ao+rrA92cQddW3GqY4EpJxFXTzMeIVo/zpNo7IcwZ9StUuah6UINKcpV5s1Kja/jhdCtrk97lpT7rl7kY4cXirPsE/J+u/dF5+9lkQgzkNgDnIGncNsv4caAYz7lJeHtx0uKlcyV76F7UNcQnjMa5L8OUxuk5UWf4BSI=
Received: from BYAPR01CA0006.prod.exchangelabs.com (2603:10b6:a02:80::19) by
 PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:41:24 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a02:80:cafe::9) by BYAPR01CA0006.outlook.office365.com
 (2603:10b6:a02:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 15:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 15:41:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 10:41:18 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 10:41:15 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vineeth.karumanchi@amd.com>
Subject: [PATCH net-next 1/6] net: macb: Define ENST hardware registers for time-aware scheduling
Date: Tue, 22 Jul 2025 21:11:06 +0530
Message-ID: <20250722154111.1871292-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: a2395631-8c64-44a2-9902-08ddc93636cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z8fd6Rbs5QlVgaTR9hmp7yG/IKgQt49KXXXNU5rFlnKnU6RaKeirWezq3otn?=
 =?us-ascii?Q?NLALR8K7UG2hIsFVf/kdLgmvkNV9Nd2LuVbiIkpRz4fXFfQL9YPjKMGTyINE?=
 =?us-ascii?Q?43GSOB+Koii8P1hsNSbwi5Yo1S5T7XxHJPPWIXXLQT22xUGAvpe9PcoKkq2L?=
 =?us-ascii?Q?0u1Sdhd5t8JjNriMtybl8zt0fZPr44XBMx5dzzh0KlRMcPME4BXmOZkEJCCC?=
 =?us-ascii?Q?AUT3DMFdKa8kF9/nXvPeTLZYMiOLwT833m/T0wLw5RVsjEY5WeAaqCYF1PmI?=
 =?us-ascii?Q?xmTkLfivRCnLZCScVJ5JxgOuo71iY7TOne5Km3cipVqn67ErF/d8lxsXCSM5?=
 =?us-ascii?Q?3W8E3hdz8UPC3fmGkxuNElbxvR3eXQVjYkvxEzxOCgO7WrDfLDqOs3akXGaZ?=
 =?us-ascii?Q?RqIjHl/b4354uuGvWXRsupM/mDHopIgxsxxH5BB/xwmImHzoqAZbbIZysW7r?=
 =?us-ascii?Q?5TEuogOcf5QLhorvgqoBgCy+F27dJR+gm0nLlVUjYEG75HmKtqbGyswVfLx0?=
 =?us-ascii?Q?Zb424LKf7XHRxcJ0a54Eg7AtW7G0Ujuq/TQvT1bLlGoIDzHvVvdi6tbaFCHH?=
 =?us-ascii?Q?3AztJJWR1EyDDaDbxaV9B62ryaIzbWIYj7vK0h9NgTN8pwpT8tqK7LOi59cO?=
 =?us-ascii?Q?UbKluwU4Fo58qlEyX1juMkF1BQHJFLxSIgslYqCwpudJIiXd+F9wf0MN7Wcs?=
 =?us-ascii?Q?djatHjMWPbziJhvtJOdCZLM2qNrxBxHsaGBaexaA4OmK1Bt2K8LcRqYDmLOq?=
 =?us-ascii?Q?dEiGkNLDX+6oT0bgYbB+Iz4xwt/Os7We8zPy6rDeK6p/vFQEo7qM2/Xycqiy?=
 =?us-ascii?Q?GtYNrX5eSa0hMsXXFR2K8OpKxAAjSuf86gyDCFcZa/2q9ZxeyX0kVEeYnlMO?=
 =?us-ascii?Q?7G+Ycbb1egkePQ+RqcAOKHYg7WeyOyBIQVc/HEYFY0Zmu+SO313MOYyudMOQ?=
 =?us-ascii?Q?7C7lffz7ZWN+6KtALsRpQH9Uje2SBcxaSYuGzPan5jlnhtzS0Ka27AHZrqCl?=
 =?us-ascii?Q?ybiWNSCyNgN2gTFPWVkIJwBzQkCsjHLxKFQd3lfmgAI1VBiCb9aDgSUnedni?=
 =?us-ascii?Q?zSm/BuYisBSB2fm6mEu/oKuCHbtlwj9GtgXWnLFIM5X+0z+8KDopV31ELrvO?=
 =?us-ascii?Q?+R/sKnuqhZ3nygmiDbI5THORjoLIcn9U+yQJ5HQoS07NWoCXhG4hEiz3x2+A?=
 =?us-ascii?Q?2d7VXf5b7VA0eVJ8fpaAu751Nf+J7e3SupAoAlSF7EQMphcdbhri8Cn++FKp?=
 =?us-ascii?Q?O+5PcNN/k5Zy7DKU1IkHxGFL+9+xjbPqvxJtwCZQ1lYZfB5K2aZLWDYKA93C?=
 =?us-ascii?Q?fBNTzXl1gMJi10BI4IuCDao8+ue0GrnsEYV2vhMTyYXXxxUq0OjHFc2eIK7U?=
 =?us-ascii?Q?fqQqPDVh80C/r32ydvhxCBomrhkPMwMuHMc8kj9Gt2EYNMppig/k2vZIyA0y?=
 =?us-ascii?Q?X1F0qMnHr2Ax6jYq9b0rO17VVt5k7fFWRU+YnXv63Dk++pUoOCj9fyVwaQcH?=
 =?us-ascii?Q?RzYtyzuIvhbj6pJBsZxZmbmuYGBJjUJhU6Cy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:41:23.9921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2395631-8c64-44a2-9902-08ddc93636cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185

Add ENST (Enhanced Network Scheduling and Timing) register definitions
to support IEEE 802.1Qbv time-gated transmission.

Register architecture:
- Per-queue timing registers: ENST_START_TIME, ENST_ON_TIME, ENST_OFF_TIME
- Centralized control of the ENST_CONTROL register for enabling or
  disabling queue gates.
- Time intervals programmed in hardware byte units
- Hardware-level queue scheduling infrastructure.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c9a5c8beb2fa..e456ac65d6c6 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -184,6 +184,13 @@
 #define GEM_DCFG8		0x029C /* Design Config 8 */
 #define GEM_DCFG10		0x02A4 /* Design Config 10 */
 #define GEM_DCFG12		0x02AC /* Design Config 12 */
+#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
+#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
+#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
+#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
+#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
+#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
+#define GEM_ENST_CONTROL	0x0880 /* ENST control register */
 #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
 #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
 
@@ -221,6 +228,15 @@
 #define GEM_IDR(hw_q)		(0x0620 + ((hw_q) << 2))
 #define GEM_IMR(hw_q)		(0x0640 + ((hw_q) << 2))
 
+#define GEM_ENST_START_TIME(hw_q)	(0x0800 + ((hw_q) << 2))
+#define GEM_ENST_ON_TIME(hw_q)		(0x0820 + ((hw_q) << 2))
+#define GEM_ENST_OFF_TIME(hw_q)		(0x0840 + ((hw_q) << 2))
+
+/*  Bitfields in ENST_CONTROL. */
+#define GEM_ENST_DISABLE_QUEUE(hw_q)	BIT((hw_q) + 16) /* q0 disable is 16'b */
+#define GEM_ENST_DISABLE_QUEUE_OFFSET	16
+#define GEM_ENST_ENABLE_QUEUE(hw_q)		BIT(hw_q) /* q0 enable is 0'b */
+
 /* Bitfields in NCR */
 #define MACB_LB_OFFSET		0 /* reserved */
 #define MACB_LB_SIZE		1
@@ -554,6 +570,33 @@
 #define GEM_HIGH_SPEED_OFFSET			26
 #define GEM_HIGH_SPEED_SIZE			1
 
+/* Bitfields in ENST_START_TIME_Q0, Q1. */
+#define GEM_START_TIME_SEC_OFFSET		30
+#define GEM_START_TIME_SEC_SIZE			2
+#define GEM_START_TIME_NSEC_OFFSET		0
+#define GEM_START_TIME_NSEC_SIZE		30
+
+/* Bitfields in ENST_ON_TIME_Q0, Q1. */
+#define GEM_ON_TIME_OFFSET			0
+#define GEM_ON_TIME_SIZE			17
+
+/* Bitfields in ENST_OFF_TIME_Q0, Q1. */
+#define GEM_OFF_TIME_OFFSET			0
+#define GEM_OFF_TIME_SIZE			17
+
+/* Hardware ENST timing registers granularity */
+#define ENST_TIME_GRANULARITY_NS 8
+
+/* Bitfields in ENST_CONTROL. */
+#define GEM_DISABLE_Q1_OFFSET			17
+#define GEM_DISABLE_Q1_SIZE			1
+#define GEM_DISABLE_Q0_OFFSET			16
+#define GEM_DISABLE_Q0_SIZE			1
+#define GEM_ENABLE_Q1_OFFSET			1
+#define GEM_ENABLE_Q1_SIZE			1
+#define GEM_ENABLE_Q0_OFFSET			0
+#define GEM_ENABLE_Q0_SIZE			1
+
 /* Bitfields in USX_CONTROL. */
 #define GEM_USX_CTRL_SPEED_OFFSET		14
 #define GEM_USX_CTRL_SPEED_SIZE			3
-- 
2.34.1


