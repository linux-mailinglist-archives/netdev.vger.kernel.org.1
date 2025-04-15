Return-Path: <netdev+bounces-183044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1360A8ABE7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0263F1740DD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB382D86B5;
	Tue, 15 Apr 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PieH4Z4u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896B253931;
	Tue, 15 Apr 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758822; cv=fail; b=oMowgl67JlqrQKHcUghs83nF7TgrvY2O803e43RaiWSf/dUz8LcKZLBsITH9hXKuisYyg0wm5NKqNdPMgriUZNfugHLqkiQgnblZjS7iCcY7aJwK5mHQF1N/85jIchQ43b+b5MyL3X2NAWnCZ48FGM2zS1YM1gCONT3x1XsActA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758822; c=relaxed/simple;
	bh=8/Ce5C3O0UPG79ai0SkXHiZYYj/EMHUOaxK11yXzmMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ATcxGidtbkF3vW6rWbACi/AZT8tbixnQxO58NRGsHS5Hz57Q9S9vK+GHCgcEcxNJFQP37CatihzWZYUEoc+MG0EREfYlFRTc9kbLB3x3MXxR6Zujk0ZASh0yPSwwS4jan3G2ADPw3Ii61LN7qBGhV6osieMoDeS8duf/+sp72p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PieH4Z4u; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWG2pzLSCnorL2f4h/OQ5OxPRStLjTrzVDlFgxK1+93tdiJ3O49N7SDT+iZQyLdUN2+2SXHWpRhyMy6nRVMaiVD7l2nXd7+ePaBSBfYnSqYuMWYtX5a7p8LrYT+/ktzKcF2Il3R4ksRp8pgXnqSNdZzzS1B+8X5NfUc16KT2+AQmQRhH9E32w7tQxMXAH2/19rBvzaqJqYVXKjRptGooAk1jhZPAmWagszewc48Xqssd4dt2r1xjE+RR1i/DMNR+c25MJpWX3oZd6RmqHwfQpEQ7OctxZsgt2nhuVVnJL0BXuo30L9HnnQEg3s6++Du3sSXSoxbT6uZUUilx7JgyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZBpJ0h7CYOJngMp8p4oI86J9yTkwN4oxRW2FVBlcvk=;
 b=YG8xjSP0uLbNRyva8vOqco/mfhEjCAPmoA+WGJHDR9P3XcdJI0vn7yAPk8KPDiQKFN673BTAWfDRPsqb+UEJqdmEv/bMJt/QejGUsciHiziBO3GT87MjAfYZ3PmQuAWKj4XGiwhfoANsrf0d7gbLFXg8q/uNNcwbvdwIA5Po9gNMeNfWgPz2Sw9Pn+GSEX+sMqrAIxaOJCTRb7ZhDxMwOQQL5WsB888b+/tuESRWAetzvAxuh5JBmgqUPOWdbhXIZ4XgWv6kDIL1HSunmTltadZLv8Gu6taY1avNzgZKTN6NYRGcuQQ+qAxKJOp2l9xQezvrQpBma3HRhSpVOn0Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZBpJ0h7CYOJngMp8p4oI86J9yTkwN4oxRW2FVBlcvk=;
 b=PieH4Z4uH4l6Pv1lvSG9GsrMBZ0NhgDIupCs4edM0RJkFx0KM90MFx+/msuMDNy56tU1MglEZOOH9Xljpl19wzssOw0XXMjqEpd2CxlpEmDRy9QQLS9QUWEbLyjKzgmYFzq47b2pxnVyVMVapu+CsASdsmr0QfiBq4VwVQpYmZ0=
Received: from SN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:805:f2::27)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 23:13:37 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::ad) by SN6PR04CA0086.outlook.office365.com
 (2603:10b6:805:f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Tue,
 15 Apr 2025 23:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:13:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:13:35 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 0/3] ionic: support QSFP CMIS
Date: Tue, 15 Apr 2025 16:13:13 -0700
Message-ID: <20250415231317.40616-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: fa89be78-ee59-4942-0cc8-08dd7c732697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7lZaU71jWWOJbp8gn8P1Lfv3rmlkkhvzETwGtcslDTa53nz/PNyUr6NpScH?=
 =?us-ascii?Q?vXW4+8MxATgODMq6HAazXccVHhaJCYlK/HnF8RUJ8KYU8xpL5qwTLXt5uTaU?=
 =?us-ascii?Q?C7/GbONSXvdQ3GjQMBZSi89jG+sNv6FdEWvyJX6UkvRabjNx42ybsyVP50Um?=
 =?us-ascii?Q?U/m/uNjknp4NoTUUrb/1InArQSq7rQNKhESDnMVDE1FaL8rH5I1EwwQOsBGi?=
 =?us-ascii?Q?9v2vYOP47FmnHMEEWT3vyhOv24eOSXYeSmnJU0PYM64/OzrHJWl09/N4SMub?=
 =?us-ascii?Q?WE4pwJDzH3G9aE3QC7ZHPOkIzhmsnUCN4QUKMTJqBGPQEvHn0nLxRe7QLMz+?=
 =?us-ascii?Q?B8G98q0ceGUTciWAlKULo6tdwM+YrwZf12HA/Iw3Z8wOCh6q+YWOoFo9sWqO?=
 =?us-ascii?Q?0sGXh2NHHxDYFAWGiUtv3gbyEZszG4fbUIh4d1Wdl5NBIgjJT9v+77/giXz3?=
 =?us-ascii?Q?c1k3W+jg1k/1TH0Wgz6CnXQhdjlGjO6CHwcRKUF925gC9leV/X12qWd2ImsC?=
 =?us-ascii?Q?t4LObaLnHYAPFHPk57iNhBlurEElb9aVdH7xzYTi+Blehl48wQyX3wr8yDlN?=
 =?us-ascii?Q?1iDUuNer2QLAjLp/zOLRLwcD7aV3ykPrRmo/IJDDPO8Qgqqbv1OuNEG/GWla?=
 =?us-ascii?Q?1tcYBif5RmxVwtrLqUY8p2E3EJJaowXR+sTEZQWxyj1/nIMRlfG19xq680m2?=
 =?us-ascii?Q?WN2Opa4o3PP/gVlSvXWf8nQ667g587kNb7T2dsdAmJOHpYPICR85mJD8BB6x?=
 =?us-ascii?Q?Puv3A/nBd+ctzgaheXCxi87r6R8GqahpZEYVm0gvyQeEHclIx4QaEBV2JeyM?=
 =?us-ascii?Q?04t3Npr5Fao22UqccRbhaihraH3DF3df209TdTkxbeV2uL1P1Ac++YvSnLDp?=
 =?us-ascii?Q?CNuul2Q2SY5GiOcpbcLw4XqbK/pc7KiMJYJ8h5vJAOg61f5iNLgUA5WtqhLw?=
 =?us-ascii?Q?rtkpw6cJMA5HzwgFIasRBSjwCRVNKFMl0ko1PkdjE5BbUhkeheWJXffNWZre?=
 =?us-ascii?Q?Nau91jpwVE8HekR80X4opYMIc4O1NS4HkquMXfAAexqosCZMG7mecsiEmMpG?=
 =?us-ascii?Q?2U2nd93WXwyJ4iHVDe9kkQtnJcnHHcRNXrAi13pK1InAyiQ4sItxrdecFWLi?=
 =?us-ascii?Q?Lra0/LBeGfTaF4utNmAaTRgPm7LFudZK2p1vcYrlzQloyvmLtxLJHijof+SY?=
 =?us-ascii?Q?yvf6M5fYUBykrOkChGTf8EfQfokjUSc7LqAO1rrQLJn80M4IG98NMmfYX4a+?=
 =?us-ascii?Q?SdbaK8WSCnssnBFR2t0jCWm6or7RbIRlIyt/xnFaQC2MbdBItZXC1mZHJQrE?=
 =?us-ascii?Q?5sHvlZpWlb2VJhfMAK6q6QF8AnlR5aJdXJfY3/qwe/PQWeQeOwnoIRlAaixL?=
 =?us-ascii?Q?kUeTUZq+p/Rv1AVSGDWDjlTFKiNcMQGP5NoQV1HDlX2rn3E3iA3OAhbyeQM0?=
 =?us-ascii?Q?/wB75R3kVorcbPC8dd5lwQfIZ7T9kRX01KGuLB78TSUOwms4LZCziEP6WjPK?=
 =?us-ascii?Q?3kAQ9CmjYyu07/F8vjm9M7e36KQkBN5AxO6L5HT0EnZT8u18SC5oq7MVVw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:13:36.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa89be78-ee59-4942-0cc8-08dd7c732697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

This patchset sets up support for additional pages and better
handling of the QSFP CMIS data.

v2:
 - removed unnecessary index range checks
 - return EOPNOTSUPP for unavailable page
 - removed obsolete ionic_get_module_info and ionic_get_module_eeprom

v1:
https://lore.kernel.org/netdev/20250411182140.63158-1-shannon.nelson@amd.com/

Shannon Nelson (3):
  ionic: extend the QSFP module sprom for more pages
  ionic: support ethtool get_module_eeprom_by_page
  ionic: add module eeprom channel data to ionic_if and ethtool

 .../ethernet/pensando/ionic/ionic_ethtool.c   | 99 +++++++++----------
 .../net/ethernet/pensando/ionic/ionic_if.h    | 17 +++-
 2 files changed, 63 insertions(+), 53 deletions(-)

-- 
2.17.1


