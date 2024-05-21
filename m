Return-Path: <netdev+bounces-97262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494528CA5DE
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D371F21042
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B758BF8;
	Tue, 21 May 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iWApvB+X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337A8814
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255458; cv=fail; b=HGuVzZ+nAooWEXMsmJI3LlsElRDwlD9RxXYnSpwM1p1AUtpDqOq/SdjJ4OEiwewRgNq8cyfmBQUs5Y3DfBDCibGLO0UtRCK2ttHaYTrL+J+uFRDtyGUpOLPW2iiZ1fwLKCpwo7lRRirX9+Iw+X9FMnH4zkVo4GR5CATgW//qzLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255458; c=relaxed/simple;
	bh=8io1D34vvFYPrm0s1WMIiBXE/oE8viP5FT1WwTTjkGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FglAd5zpoxwzWxB1RgT44o0eGDg/g63lY+K0BdlO7RzpsS0a0DGCyGUHEvRrBXx7mUGXfKKft2rm8ffvEagytENg2JbkOPkpaIVFlTdpx1iM3SP79p29h8c+EaXmmOPqfLz/8ZkcRyGXm2er//v9wgIb8Shd6+OMV7755318w3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iWApvB+X; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G17qWmUeO4QNQlvWevEHkY5SmQjxusggKlRGyvunw4iAOrsdV1CJiyMtdhJeifh0bG8Jsk1fqE6t0tAN6efUfiNIujTtQP+z8+b9HMECQT7KaluRE6dSowOe8CCrDyvEZa9Pf7vj+gIsdAmSQN7m55jV9fw6oPT4QfEABZREOjCkFM+hLIb9r0ahtRv1DpDlRMAnEpS3Sh72MS47vcrGrBcWJNj/59bYQsGx/lSSXPcP0o/tTNPw8PT6KqbM50PC40aq7mUho2AKBgHBzzeYWg2y30ijcEejsf9U+Id7Af/vf7lgFGgUJT+nVUQX+5TY9LjhcVAizxnbQpfDMuww1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk8HPfHMbVk8QdHxnV/Y8z0KKRwvm4xPSxdJrdFPf5k=;
 b=FiwR6lMx8iqEClPWRx2ydf7g43pZmX7mNsQHx9ZFtpfYW3jpJeIkAwLlcWtI5QJ+v6AoqwfJ8Ttf6hQrLkHnLcmte7sdhbjmhP1qFb2wfsVSV5OIh/hQZWmziCuWVSCzNuSGSOWIRkJ4yflRXwyu3z037VtN4xZbHA1kHguqr+EeQuRFBv5N4NMjLwysNG8GLMNLpUmYl7b3clUr0OtaeQGRkUWpN4Gv7RqVz7iZCkwbrfodwRGE/ZPaS9kthJfuje01Sqkpe0BTv7w0jMV2IevxEbhuLxu3SABX2f011oJYiEIIq2qsJjR4byksDD4wDOYhhdw616uOAh/Hs6Q4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk8HPfHMbVk8QdHxnV/Y8z0KKRwvm4xPSxdJrdFPf5k=;
 b=iWApvB+X+tqbKkW3g7IKUkaVvzVoZ8iuYeaS4Oyld2w9sLGDw374405yU1amaeIW+qmVbeV6mIv3sm/mM/+ipSp4uTcQDwpSnKL/3TE7XQoqflT1+/f5jNStm1bZWxUY2+T9S94XcuQaw36XfiXPFO+rxDhXmRvQc5EYv0ziv9k=
Received: from SA0PR11CA0015.namprd11.prod.outlook.com (2603:10b6:806:d3::20)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 01:37:30 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::45) by SA0PR11CA0015.outlook.office365.com
 (2603:10b6:806:d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Tue, 21 May 2024 01:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:30 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:29 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 0/7] ionic: small fixes for 6.10
Date: Mon, 20 May 2024 18:37:08 -0700
Message-ID: <20240521013715.12098-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 75efd8c3-ed8e-4954-ce4c-08dc79369481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W74wUAVTMAveaobvpB2dy8joyM+rz00vvIm2mvyG17NlR1wnfMUEmhJ/vzDV?=
 =?us-ascii?Q?f8Hy+9uzAKjBQuhr6w+X40j98dbLsEQL2WHcSC9U4N5GbtRQxemzei9p2CfY?=
 =?us-ascii?Q?Rbi5i/qPNDjfqF8zFFK1KBRZVYM3/p+kk9krJWlhFO4sjVjwx9qTzBMHkZp9?=
 =?us-ascii?Q?cz7Lr4TE9SRdv15GAioLC1sKn/M2I77MJ5kFnZL7J5lGtDlFOPpjWEBJYJ0f?=
 =?us-ascii?Q?umkt5zaU+9RerStPbyCh8YoGAqiQqz7nleHZOmmQ1MmhDCHvld5Jx1HipJ4i?=
 =?us-ascii?Q?GSCODPlJhtT8tvlv+hFJnXvi5RUItcZBd9jzjSPBvNqEKVEke35E2PJig38w?=
 =?us-ascii?Q?wUeMhXd1MiG5vXOcocwg0FQbIfVPRPS+BhDuGnDNvHofi3rq01g0OiSUJB2t?=
 =?us-ascii?Q?p6hoqrvlMS2M6oHLwLdUbZkb49L4c4dHP7bf7PW+kZEkauHfQmU5GGq+nxU+?=
 =?us-ascii?Q?puuyMEvTcKSt7bcwrdNK/CIQpr9Cov3ykiVUWkC9FZH9GWPqzvfmRKHUZPVO?=
 =?us-ascii?Q?yMJp9R6oKBOR6mVJ7A/9ahVOYZcf+xRoblz7uREqoCyDy5OrS3U+5D5jhXHD?=
 =?us-ascii?Q?QsHS6GzAXhO7jYBsdmZxLW4FCFt1p3FyIccseiTMgV61Q56gwrF6EgX50Upx?=
 =?us-ascii?Q?Ty3mbCQZYw9t5IEBbwIal8RQ8K/pj6URE49ttER7DHeFItTV0OZdtLW2309g?=
 =?us-ascii?Q?svkCXi3BP3gcV4wGBz1zRxSZp+04WrjvXr1vyRNMaR8IthqdJRx+dVPbmZQY?=
 =?us-ascii?Q?BPkbTOPMineBlxV+Gsj+6Na9h1vOfRmk2tAxExqKNPzFqBQkUiJ4/a/xURKr?=
 =?us-ascii?Q?k1KMQD7a4AG+oEu/UfZ29bNVg7q1CFTooCVScfieOBToUfdJ5SlN/FAhi8VH?=
 =?us-ascii?Q?5Oe8QUdJFn7X0Vl1CTT/U7st7Jp3O1ALkYw+u4rS4mPMbjVNv02286kJ10qY?=
 =?us-ascii?Q?ycPx17xWfp6HcBKfwYTMbWoHCoSymvG3aq4Iz+I+I72sA6lskd9WHdnlHYj9?=
 =?us-ascii?Q?RUVPkyS/Jrar5J2CkGa5V0I+ce5eNFAOLpIYZyEranG02cePth17nYeR9sl0?=
 =?us-ascii?Q?bq7HNIAo6/nqUpZSXi5loJ7Y3wLQIl9zhr4S+QMW9YD8wKiCc8tqpfZwkZJt?=
 =?us-ascii?Q?OKZNE4LOy0zW3rvMBmjb958Vo/yKlhOX3N0Sb4lqngRIcfcaTL8ICsfX9KOw?=
 =?us-ascii?Q?1ev/KcGZl1mylYiC0ANfOO8zsOgXDseRkjb5N0NfJxtb7Dqxvs8VDzQJ7/PG?=
 =?us-ascii?Q?mbTDvPgIEQksanvzCPURz9By89p4y7V0CPr7zAcKf/mRiCQDJBrN9OX9pRxe?=
 =?us-ascii?Q?cE03K87D+so0mrGZ2YqfZzEttKhPecH4d9GulRAvGbdZJP4m6QK4tQAoRCRh?=
 =?us-ascii?Q?zIhlIvGV0GyyIavCB76Cg/cxKUWk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:30.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75efd8c3-ed8e-4954-ce4c-08dc79369481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

These are a few minor fixes for the ionic driver to clean
up a some little things that have been waiting for attention.

Brett Creeley (3):
  ionic: Pass ionic_txq_desc to ionic_tx_tso_post
  ionic: Mark error paths in the data path as unlikely
  ionic: Use netdev_name() function instead of netdev->name

Shannon Nelson (4):
  ionic: fix potential irq name truncation
  ionic: Reset LIF device while restarting LIF
  ionic: only sync frag_len in first buffer of xdp
  ionic: fix up ionic_if.h kernel-doc issues

 .../ethernet/pensando/ionic/ionic_debugfs.c   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_if.h    | 237 +++++++++++++-----
 .../net/ethernet/pensando/ionic/ionic_lif.c   |   7 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  32 ++-
 4 files changed, 201 insertions(+), 77 deletions(-)

-- 
2.17.1


