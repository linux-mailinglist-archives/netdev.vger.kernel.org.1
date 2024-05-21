Return-Path: <netdev+bounces-97264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79138CA5E0
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AF2811CB
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8335CA40;
	Tue, 21 May 2024 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KafY5Vac"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16758BA53
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255460; cv=fail; b=NAOXNzYt4z659+b6QdXd3bL7SODo/4uzjcFdTKK1VNcy89snwCAcjpCZt0vvRkNQ6n8MPt23lfvWmw2D9cS7oafO5CcmFMi0AhT/EH7iY+YwJm6Y0b6AVbLDgyf9pSinQgy+IYrQYmsHOeFdrs5d4D8PpnfvXxU86udfvLkmW2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255460; c=relaxed/simple;
	bh=Q8AGQAd/dtisSBkDKR83Cd+8wC3tkQDcZhgrUVvAsAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLydjGQLnMU8XELg5diwqE2Lc5NetuydUkDaIDE+bQzFEqVRAfgHSxawmNoc6uuYvzVJH69dBm2RwZTmMmas7JbFidqNtYbbQ4U769Vb7JgcPpNY/70gdnOuNKHK8cya6huhmYGD16kvb/FSWhNRBFNMhwp/GaF2JqC05e7Erko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KafY5Vac; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzb10Wtr9Gc9WeK7uoj6xS7zXOWgz+f4cNuPNQvOi79lyFvFx/g+AkvPFlw9SZoXKg/MPXpuWhrq9Dz//cHePZWvFSuWHKSt+QmJPOF0mMfEYJpre6yO11FiuTzRTZJM0uzQV0ZW3eSuZrum6HKu+txba7PcdpPMhgeZ87X8HUZh7n6xGoKi50+W9AVop55eYckDk3+XK0hzHdAJtHUL/Y1WAuHjsal4lI12zfH8IPZ1iXwLYVxGbF0KDhg9mEM0joniR4rSJm4UQ6Yb4C0PtxkX59owhv4mJ2kTS/kTCTXGY3YZQ/Bc3qUi3P3t0PNsRXK77Rmj/KPs0Rbis6y9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAgHaq3l55BGZKmi6QA7g5Zkfwsk7SQBZH7PepXnwzE=;
 b=RJfAxvxjL42g4IU+keVSsvI0B/vBiqlZJadCiJ26g7n71jDSDlMm95JzYZg927PJ9sHuWzQmItHBCDKlWCUsZ93JJqTtXK7+DrE9Wunjc2Nbydd62AGHJKEDKzVrDjFsNRbbituPG86qlwipulyxijwIJGpJ2xHx4HVwvbY9iSt59N1cuXEveibVB9BftgPne03RpSuw65k0wKMjGgCvk0qfzlyRqHDXf+BcSSFjbwO7PtgGCOaNvb0H8NgloocZmlcmbxDMIx2cahuTmARm3SKJ9K0jz4udCkj/ZphdMNx0aMXXKR9AvWkpgMoLC18Rcqewa8ZwNJZVUGTaeX7ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAgHaq3l55BGZKmi6QA7g5Zkfwsk7SQBZH7PepXnwzE=;
 b=KafY5VacxMC3audS4JFk1wOiSsaYpW5aVCH6QU2DD1gzSzQVtrhR9eGaXdrLXRrprEXio88ZWhx6Nz2xh/fJ/3XdS02hG8AcfSJlwcIeFWqToj+dgJMyu/6IxhUAP/bvP4ZF4FycTZhOsPxMHZrkOMpdelVrnlSn9dpbfHTjw9I=
Received: from SA0PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:d3::9)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 01:37:35 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::32) by SA0PR11CA0004.outlook.office365.com
 (2603:10b6:806:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Tue, 21 May 2024 01:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 01:37:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 20:37:32 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 3/7] ionic: Pass ionic_txq_desc to ionic_tx_tso_post
Date: Mon, 20 May 2024 18:37:11 -0700
Message-ID: <20240521013715.12098-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: da6beb31-316a-4362-7306-08dc7936974f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3r+uw+18IF5rggl9niURcxDKdWAruqpYDeJbUBmiI33JkicDil0IIMXvpAOj?=
 =?us-ascii?Q?MtZ7ViesALphugoD2tz3GFb4iS5OeIWOjkHZTTZwQWpM6juiY3KGYF+AQPwK?=
 =?us-ascii?Q?R4v2yzw7P3PpeLLPKGPS+Hd9OdcDk0lKhdsp8w8cHuMAJNDQlLQSFKJxNl1+?=
 =?us-ascii?Q?Gy4pV1nPcFsxnVVPobueR0wmzDX3fsvcmWTQHtKJnIsoQhCItnLFToBHTvX/?=
 =?us-ascii?Q?FyunUpP1HONSqQG70L9lsulXrYx82dxhQHSK3D6uAtrtco8jmyDNAjl7QBbS?=
 =?us-ascii?Q?DrGuG0qNqUxYTBfr5viXRGoNDrL1RqP5XQ+BDJiqxmACsKKfmWRX1L5wpded?=
 =?us-ascii?Q?jSxqAkuFA3RXFbAL6yUePoSY4cdjH3KhyV5QqOKKIXjZnX3oleSiBJMQVL0U?=
 =?us-ascii?Q?/c0k88vPHU9SatFMMN5nBk00c43vH3PpeiydbmFkWXzNA6r7zQGom+AcZTRF?=
 =?us-ascii?Q?riWptM8O+gPU8lRImVSYDqMlJJ4LIB/g3k+6b2S60fYQbWcSn08XqShu5gLg?=
 =?us-ascii?Q?vhT+hc/3mrbgLA0DEcmqREUxuhJhWZ8nsp5fIEpE9+pUefzPZt89rmQCll9O?=
 =?us-ascii?Q?hTjoJBV4KErxq+LarxNrgDGYW/lEsvMWwfH+nbQL+BzjvZL2+bFRpS4lvERN?=
 =?us-ascii?Q?ltMbRjDKU/N4cbFjrH0epdVCn/2qopUcu2FJUiFVdc0r5Zj4Rhw094FcPbRq?=
 =?us-ascii?Q?dSnYt9x950mxp7FniyPF4qVINYb+StVKK7ua1Ae217Unvi9QUdJ19VWy+WhH?=
 =?us-ascii?Q?iiKj/7UP0xpQIMPkUEpQRs0IcAsfdUZoUH+GpwxCKRaZYnYmD0YJFCtRJNxI?=
 =?us-ascii?Q?cMmFp7QlGyNvNAH17vjpeM0W4HrZOoDWOdW2JFPOQqqVpNHAHzKB8tGAiWaw?=
 =?us-ascii?Q?csp0WpWRdoHGV6V8p5FQJrI3J1itWmi3e7Qsxcl6j9u6GMrFyws8q4W2zJoj?=
 =?us-ascii?Q?G4Q7AXKnRkpfgo0MKAt8MjP1XTkQNZkejFW/418VDcvcdDYRQNgAIp5U1/Ww?=
 =?us-ascii?Q?4T6Cx+5axQIUUVwHqz7aBXceMDX3P9TqjI86KWIqMUwFE4OKx+TjOWosC7KM?=
 =?us-ascii?Q?BjmPyzI5h+LhmxOCI78+Vfztl/OdHEsmoqCKj3qWXCrwEgNVSGd8T41yNLqE?=
 =?us-ascii?Q?mBPPK/17uwb2hcQJP6V3CR+EVaudycxzNEzmOQXpH7YwBBXok1/DzHzM34B+?=
 =?us-ascii?Q?JOP3bO4Hp5Tqi2PUdTRd2DkgRJoA6/vpVQUDk2uy/FCS3V8j2lI7RnQjATpT?=
 =?us-ascii?Q?i5pgOduh/YdS0lS04nGMXWIzGZEPizOqcxKNh4YA7BA+inBcnHjqBE139mWV?=
 =?us-ascii?Q?lz/Qx6qdfwdiiPW7ho9a45XZez/B8bFHSjQKr434QB5eMpw0UT8EXkwAECac?=
 =?us-ascii?Q?VuOoLOsbFQ5Wacu5VeT8Ihr24kwb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:37:35.2904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6beb31-316a-4362-7306-08dc7936974f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

From: Brett Creeley <brett.creeley@amd.com>

Pass the ionic_txq_desc instead of re-referencing it from the q->txq
array since the caller to ionic_tx_tso_post will always have the
current ionic_txq_desc pointer already.

Fixes: 40bc471dc714 ("ionic: add tx/rx-push support with device Component Memory Buffers")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 5dba6d2d633c..c6aa8fb743be 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1357,7 +1357,7 @@ static int ionic_tx_tcp_pseudo_csum(struct sk_buff *skb)
 }
 
 static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
-			      struct ionic_tx_desc_info *desc_info,
+			      struct ionic_txq_desc *desc,
 			      struct sk_buff *skb,
 			      dma_addr_t addr, u8 nsge, u16 len,
 			      unsigned int hdrlen, unsigned int mss,
@@ -1365,7 +1365,6 @@ static void ionic_tx_tso_post(struct net_device *netdev, struct ionic_queue *q,
 			      u16 vlan_tci, bool has_vlan,
 			      bool start, bool done)
 {
-	struct ionic_txq_desc *desc = &q->txq[q->head_idx];
 	u8 flags = 0;
 	u64 cmd;
 
@@ -1503,10 +1502,9 @@ static int ionic_tx_tso(struct net_device *netdev, struct ionic_queue *q,
 		seg_rem = min(tso_rem, mss);
 		done = (tso_rem == 0);
 		/* post descriptor */
-		ionic_tx_tso_post(netdev, q, desc_info, skb,
-				  desc_addr, desc_nsge, desc_len,
-				  hdrlen, mss, outer_csum, vlan_tci, has_vlan,
-				  start, done);
+		ionic_tx_tso_post(netdev, q, desc, skb, desc_addr, desc_nsge,
+				  desc_len, hdrlen, mss, outer_csum, vlan_tci,
+				  has_vlan, start, done);
 		start = false;
 		/* Buffer information is stored with the first tso descriptor */
 		desc_info = &q->tx_info[q->head_idx];
-- 
2.17.1


