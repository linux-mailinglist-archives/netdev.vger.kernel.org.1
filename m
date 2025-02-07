Return-Path: <netdev+bounces-163718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F1A2B6EC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABADB167794
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D0184;
	Fri,  7 Feb 2025 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X0N9xOuo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F85672
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886807; cv=fail; b=DRJUnl7rJq9SrTSO45kNi7vUCQMJ+H+SKugNDDfWhkTcDKQrX19Gi58wrA9FJwtOSw/46FY8eitGxCHmFcWfLENyFnLany4k4piNpiXsTbTn4iF1LYY8kWkVA0cTvfCN+J+/IitHcIqIDjIq0O8O1lhfZEzN+4zw1mfSOSG6LFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886807; c=relaxed/simple;
	bh=9vWlZNdKJLxt+iktzuzIU7ktVdiYpNvRwhgQprRk40I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bgz+IHTctPI9YE6Es4QZFQ0mq0zecZKaAf6gLLWOtdubnQ5Cy58qwglUc275BH7nrP1z1b1rxnZQ6L2XRqQyWYLwcY316Jg1Zoe7CKu1x5eEc5idq4yq9XYlVULnXYMyj6+QLG7BuLuwlVh6UH0+BxyvPvn/4G712FZQ8D2FwwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X0N9xOuo; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVcssDWcPzf3u80H9nqsLk46Oekep0XYD03AXHMa/knQ4Y3yjbmfZfTEYlN9jRk86aT6GC/+rapXiiymWgRkHwSV+yg8goMr+4+J9kgKxmAKhyP5srRFrWx3YUr8xFQjwNXeR5faC0uKgJnZPHi4eX4wrf1TUJh3/3hPW20UCo8cyzC6FSlHzQeGjcknOfnxP4Jss1jT6IDYvvTZZl0Ne+8z2aVYvUXybl5htE3yBXh4+4hsUhuJATvAKQWlriw0f/qC8dkxqByzqDzQ8QSlM0bdYnFaSMXXTW8B8ilrXW8dDPNU7WUkTt8ReqjQJH6IVBrAX6ovMfa1MDqmlF/PrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49L5eHc10UEjlReQDm89FUYXfZrO+VzBon+GwKQe/u8=;
 b=D1bekgpbu/viHiKreT2YO9ErJREOKjEo2SYg+HbIbswFtoJxaPIWYUVvxE7VBOmayATnJ1rgw/+9s1fA2y38jc9In2HKp3MziqPdIoI7PQ6xbfCKIO1VCEWa26T0kB72MpgQtap1R1LpDkeccldo8rHBy8tb0ReLm/GF2MA8ayTiDRxz6j08QJ26z6yuqPU6ob0a5B3JqztUnuDXoTdzTn3nVUbLvjNWigVmCMjJSigySOlPWuRXuGP5zbn3eV78BUrD6v7Jo2Xcs1iS6upZWVdWmz12zqwZN1ETOYG3yHodnAKyYnhETSXwrEUehLJwXam4xIDRWtrEP+FRvK/f0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49L5eHc10UEjlReQDm89FUYXfZrO+VzBon+GwKQe/u8=;
 b=X0N9xOuoQC0ihFuEJ3aql/fTDt398Cfx+PCgf4/obKTF8C4SIc70+XrQ9T+p1zf/VKJh2JT8N9ricu+5JXYItRL9MBUu6CVqpHEsb0AUfXrJk2rybdqX6il2hDAKtAnjndidzv8kZopYaj5HZ0I6NELYW11JXGFKZgBRtu+lXVk=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:06:43 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::bd) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 00:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 00:06:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:42 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 18:06:41 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/4] sfc: support devlink flash
Date: Fri, 7 Feb 2025 00:06:00 +0000
Message-ID: <cover.1738881614.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c5e55f-6079-453f-1c10-08dd470b4df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVU6jnNQa2wox5eQPFnzPxn6LL6emLBK0b+a9CUMk2Kv+aRRlGhIDMEcwI5r?=
 =?us-ascii?Q?N/9hf+k5OxM+4x6Dkmkkev2t6dzRQds2xAJPqU1pbxKje612T9oDaVpqX54q?=
 =?us-ascii?Q?hv5W1hji1alRinD8t2oeHQuGb8N5ZYGE3zhXGjid25vxzQ2wDD/guQvCYvZl?=
 =?us-ascii?Q?BvBpuWQNlyvhd7cw4N0SDXzBo8whZSUlqBqpHNA54cu19v9Q5WD2mabjvX1P?=
 =?us-ascii?Q?bUUBDmBY84/qLGSjRbu4qSmPjzIUfJjNmpVFl82dKljVikkBSMYe7piTFOCw?=
 =?us-ascii?Q?YPb42ZFin6vkt7bWtw2cfBu+05E7m2RvK8nhu028C+45dbKV4LVYjFLEuNJU?=
 =?us-ascii?Q?Pp1VjYdmKZnozZV53o7pQ2mZnuyr7OJDnwc2PB3PGO77Ay/yBVJlIBsTxVEU?=
 =?us-ascii?Q?XjjIam+Rb6aQ2H6orTzIQnns/AkiDF0pYxIolya+B8JidY5Ue5GxzYSLitEe?=
 =?us-ascii?Q?eWYvvZU277WX+Nr5furzdGbq1DvqUm1LZZDEUPPQ4dcml7+7SM9qSwBZCgwL?=
 =?us-ascii?Q?uEYf54aJbHmgkmUqpHyKpv4OioVFjjhCLvkEXMeRotymMeo2ICqOcVVVKufL?=
 =?us-ascii?Q?lo4JDeIw9cWx8IORnfgiWM+liPPuhYJEeyDOPCBFvsMF3Ll4fWDSUl99F0nM?=
 =?us-ascii?Q?BKflpGCQWn0DlltTj91xsFJeJ+fcQ9Pr74ijJDn18YPGfv5AvDPHTVfrIaCp?=
 =?us-ascii?Q?kGosQ6llWmVHmInHwJa9+DSlNqA2eXC7CYuVsngRGKFwSqh9UA5Rvuo+SMft?=
 =?us-ascii?Q?Es16omAv197T3CFb/z5cxzjXxz3IXMD9jcCUmoeMIrd7X438JSNSNxxLa+ZA?=
 =?us-ascii?Q?kTIFURSzMe8PmSnCSzX487Xjtesf5YTZuqEkk5bl72Au+mUihbiq24tqUsP1?=
 =?us-ascii?Q?92wEzjRdTjM35dSR8F2NZevVXr8ouSd2ZwMIvi2JZbUat2/aHW7w2/LfmNTO?=
 =?us-ascii?Q?bEolLom+8LqFgOkPRh0TUdlKmGyYUGszVx+6z6LTK4ihhK7nXikqXKIKzYMg?=
 =?us-ascii?Q?nqKKhLL/NvLt2YPwf0Qt+PDoE+sZAnlbai0UyAYg8Rx53tKU2YRwZFgpwRWi?=
 =?us-ascii?Q?s2z6+ZcCOyPoxMnqxn9bHjjNs35gMMAJhMK8LlHVPQGDankoOF70+DY05iqm?=
 =?us-ascii?Q?p2IIYxTg19BnTUPDHFRaHGRtD1vTX0yGncY0PJsysxaSRpe2Ttz2AQSTz5de?=
 =?us-ascii?Q?j8m4dLgKV/g+GQd6tpjGWHTB3buB2pERAP2H3f3tb+NVq3aynDndzHwDIfVN?=
 =?us-ascii?Q?cn6oJK3SZyV5qAfd7m66UYvvpBY4i24tqX9T0enUypqfMcyPRoG8DuC1QOz8?=
 =?us-ascii?Q?pB5tNzxxNa2TcA4mhwhds3iOuCXBqNis9W3z6ZS+rIKcCoD/agAzQTSiGOH/?=
 =?us-ascii?Q?s73l8OOBzmn8wTI/UwpXyOttmMzK/9qQJyRIEbZCDeBSbYyPU2j3QGtQPRYL?=
 =?us-ascii?Q?GOGTLEe/ZZUQnaMS7TntKpe9YIFIoqPa805guJKsBOyFcvdOzz3XIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:06:43.3169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c5e55f-6079-453f-1c10-08dd470b4df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665

From: Edward Cree <ecree.xilinx@gmail.com>

Allow upgrading device firmware on Solarflare NICs through standard tools.

Edward Cree (4):
  sfc: parse headers of devlink flash images
  sfc: extend NVRAM MCDI handlers
  sfc: deploy devlink flash images to NIC over MCDI
  sfc: document devlink flash support

 Documentation/networking/devlink/sfc.rst |  16 +-
 drivers/net/ethernet/sfc/Makefile        |   2 +-
 drivers/net/ethernet/sfc/ef10.c          |   7 +-
 drivers/net/ethernet/sfc/efx_common.c    |   1 +
 drivers/net/ethernet/sfc/efx_devlink.c   |  13 +
 drivers/net/ethernet/sfc/efx_reflash.c   | 514 +++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_reflash.h   |  20 +
 drivers/net/ethernet/sfc/fw_formats.h    | 114 +++++
 drivers/net/ethernet/sfc/mcdi.c          | 111 ++++-
 drivers/net/ethernet/sfc/mcdi.h          |  22 +-
 drivers/net/ethernet/sfc/net_driver.h    |   2 +
 11 files changed, 797 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.c
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.h
 create mode 100644 drivers/net/ethernet/sfc/fw_formats.h


