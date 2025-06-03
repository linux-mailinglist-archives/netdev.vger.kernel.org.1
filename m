Return-Path: <netdev+bounces-194716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35668ACC1D6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277271890569
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECCA280338;
	Tue,  3 Jun 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Pzvzk5+V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DE280A2F;
	Tue,  3 Jun 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938201; cv=fail; b=iAjdbWdvNfi2p7Vye32WwneGucL7IZB7a7F6r2s8D4QEHeufwGf+QfXflSmq/IOYcXJBjC3/bWWntd0o+uUW+s+CtWXL3ivLv/p3gT0OOEZDCSCUagunjufxhodQTt8RJ/5dW7dhfZe2aj/fqBG5yl8S4kWFYpHBrAwYbUcKeEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938201; c=relaxed/simple;
	bh=fk7LirMYmCoi10saU5u4gx32LIT9qzfafpOWdS0a/AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3jx0c9ZuxEwdMJJe3MugMIiDYf7PTElM34VA0E+7Q58h/7aYzFnV1TrIXFDiQv6fcKPXxP+U1kzthmKjj03HSJIBOarpKBiNhPbq2RMXlJBbnBJvkuynfLm5VtQ7+BaUBQF+n7pe4W6V7LHCpJRjlIEIeNaXSjnLtMh2LdVJcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=Pzvzk5+V; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrOPDQr2cX8ZLxfsk655ysMQcDXb0r1LU4ewY+yYoyglBfRuHhytOZtk7vOXFsAVkkn9tE45AwVNM/BtFqlkQx471VIVwNjFAXHtbQOo3DERjJIMazcSBUOF1NE/F37wCCcGU6EMRKyEXjulVzrGLvE2GF3A4q0zhg8kvb5Xxw02fYeCwH1PPXNoS7kN5mj9KbJ/dhDtGBQ/rAwo3k6e+ZzbrL/1jIFhwsH2Wzp5sdrv8LxkqNq/6ruezaAUFHojE4YOyRHVDQNyf4EwWWDidI2hKhyEicn4IYToZkT+y2dsqtw9DOx7siiFZYXsNPde4hp7OtDLYggs1Hzzvj1QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6QdSHRQibY5GhEPYBs11/eRb5U50DqEtSR6+Z646mc=;
 b=NBEaNtPUu68BPO8y7TOolhZXzQD/lZiDOvuuyugN5WAj5OiLOdSv1GZ6AmFpLbiDgM6+2Pnhi3MJUG9TRC7gX9LRsEtFTTQxJtrXLLsUuRIEaGtikp3LDFldeOd+9BbmHqpLn0seWLJHVhfnCEDyuB/ZVhfwWlE6eWv8hTrEz8hmGGnA86iNRyrNXr4lLFa7uezPvkV/L5Ax3sVohWEjE7mTelodaERE9Ox1QVPFoW4DEQgb95J7lCa1ryw9gHhqweq6DVdDwESntGMn0lt61rfrIEdVQ1S4Q2pf5g22JiIzKr+OATtTCXxcV6oLDzkKSeS85IUsOSgK77HbqXn8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6QdSHRQibY5GhEPYBs11/eRb5U50DqEtSR6+Z646mc=;
 b=Pzvzk5+VckQ4c//1TpKbTW+HZR7uZnZ6oy8XGGJzcBZQD4FcNpbweS7Krzz9tFgnY+3+EoJI3suf6lfp/f1mKDXEqmXm7ZJhrkJAIzNtpSJpxEjbucBkShBKdkRH/ujnIZ/vGTBsYW3xYSy9ETBHo1RnoiSzDg+lcajFiSvKO54ojbPSkWoSbUmRkXnFMgp9Vv402yxQHzwIRupwyu3sl0CPpfKeQfiZPRmYeQwsfBS6o2oIp6REATdBwY8MrKUkqn/PnmLVYGwU8oInXSQM9U7N9JKT2bkZXucK3jb0ltQjfnlZvJdF/bN8G/N68fM2Gql755RKS/FLx1nQozyQMw==
Received: from BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15) by
 CYYPR22MB4313.namprd22.prod.outlook.com (2603:10b6:930:c7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.40; Tue, 3 Jun 2025 08:09:56 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com (2603:10b6:a03:94::4)
 by BYAPR01CA0038.outlook.office365.com (2603:10b6:a03:94::15) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24
 via Frontend Transport; Tue, 3 Jun 2025 08:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 08:09:56 +0000
Received: from 56525d0f2b9b.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 72556CFB7B;
	Tue,  3 Jun 2025 11:09:53 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: horms@kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: brian.ruley@gehealthcare.com,
	Ian Ray <ian.ray@gehealthcare.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] igb: Fix watchdog_task race with shutdown
Date: Tue,  3 Jun 2025 11:09:49 +0300
Message-ID: <20250603080949.1681-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CYYPR22MB4313:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21e9bf95-3b70-4c08-bab9-08dda276074e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKQA0d+Ltk5DvIIrvCg79ltA8D9sUgZdyMfMRXs85stj301CVLGATyHDacB5?=
 =?us-ascii?Q?fc/2mtMKUypvwZgbrVe7npI4Q1HTLJ6TrCOLVZOH9E8QIUebJbG4tg6gBr+u?=
 =?us-ascii?Q?Zp47roHfxVPnPRmVqPRtsP8dLis/hoTV26mhhtlu9Ik7HI3i782fl+rOFj0j?=
 =?us-ascii?Q?oXllMbU8/cT1QGqdlEM8UvUZy9+XfVC2rJI+TzBFvK1udN8TftW996os4/3F?=
 =?us-ascii?Q?qSk+sNxEgCZcuz4XlRM+KjnnrVZyuTRoWzzVMGMOU61ZhI82Cpu6kmpJj7CS?=
 =?us-ascii?Q?D7zs+nXU6MaREJABQg0NfBByMmdd6NXB/60ENVakiD2F9TEWqZ0/G6TxY1dY?=
 =?us-ascii?Q?kE1mhbAqfa75HG0guBTdug3VXA2MqlhOJEZYSubl08AtazgM7PcsN9qarzw3?=
 =?us-ascii?Q?sZEzd++iXdaJVZO4wBfdGuY8MInP/atkLHwaBB8Jfbjm3qSBHIRQ1Nq/YozS?=
 =?us-ascii?Q?DtR8fKNWG0FdZ7g5VkOlKaLfq0wYJvvKR8IbGQWIQnrlh5TjbGQSItioY49Z?=
 =?us-ascii?Q?zmYSTcb8FPIfWp2dCAtomk/jw3v8Hi2rcMtubIUK8XsAFJuUQfrQMM8iHVm6?=
 =?us-ascii?Q?kc1/49YqT2csDbAI/Hu/X3wplJGOgjvOs9j+VEjHt0YUo+fAMVposyer+E42?=
 =?us-ascii?Q?F+mnzqDo0RF/Nj0xCspZbZSVDNcjF1dFe5Y6qNOseCsY7ef43VUGTg/pbK7m?=
 =?us-ascii?Q?cSXX5F2A8wMP60hWd3Tabm5l1HJyWo58lI+nSSX6lpN8N5jdoZvwhMRdRcg8?=
 =?us-ascii?Q?Erwd8IoPW1KepB5icNC6JbIlsDMsRI7LJvFBUrliV3Hm9Gu5pZjz9N2eHhoz?=
 =?us-ascii?Q?bx8S6brES0HZHP40RMOHS/EfFNoUQ8XC0a2ke0GcBWgu/rXMVK39yjJcG/1E?=
 =?us-ascii?Q?xykdtTt0wPRHdKGwJqPjltHGqOrWYd7AFyYYQsK7++ozY4qYMVtxdtk5Q3yv?=
 =?us-ascii?Q?S7+4wQM3IRhYhDF0qBmayQHPMWqwIs9uPTSPYTMVug1BI3B/WXMY676TnJ2k?=
 =?us-ascii?Q?KGYDayOZ+XkihmIdHV0NL/TKkWuaLf/amtsUkEDjaFa+v7UsCYKvCVfY/laL?=
 =?us-ascii?Q?wgjx5VkxS2QAYB+ryb1VW4MMLqujL0HwLEIEWL6swwRmgoX0kOvnKQlXSo6B?=
 =?us-ascii?Q?7bKLrok2nSrHT7qK1TY9PLh9p9U9Tr7E0LeBXuwNhDhGIDTTKQB0+PVTiiXq?=
 =?us-ascii?Q?RCv0KV7tBNxicB+smJjrbk5jwCZhZbyRz/l2SpsrZr18Ou8nkb3Q92hMUs/1?=
 =?us-ascii?Q?4QOcZt5o0LUZDP1+A1tJ4fw3E//qqqCY8kZI72hklmsGiIFtxs8aO8yXdfSY?=
 =?us-ascii?Q?ppv+qPhmfUTWMaRRv+Ge79uT+JYr5mteU5DmkFLVQLe96fNol+hFDTyODbQM?=
 =?us-ascii?Q?xpTrXEDwjrS6z7RkzKwtiIu6oew0dogUolzXCvT5xlK8G1df9/hbTeRaRW63?=
 =?us-ascii?Q?H9JEcXWKrpfU4KioRtWAgoBOHUZaXlJhlWIkPVPfPQCxMUy8kQjTAmUVo2v+?=
 =?us-ascii?Q?yn/kYkTPTrmkVgPoipDPbFbTgtfZ5k4HCUVh?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:09:56.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e9bf95-3b70-4c08-bab9-08dda276074e
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR22MB4313

A rare [1] race condition is observed between the igb_watchdog_task and
shutdown on a dual-core i.MX6 based system with two I210 controllers.

Using printk, the igb_watchdog_task is hung in igb_read_phy_reg because
__igb_shutdown has already called __igb_close.

The fix is to delete timer and cancel the work after settting IGB_DOWN.
This approach mirrors igb_up.

reboot             kworker

__igb_shutdown
  rtnl_lock
  __igb_close
  :                igb_watchdog_task
  :                :
  :                igb_read_phy_reg (hung)
  rtnl_unlock

[1] Note that this is easier to reproduce with 'initcall_debug' logging
and additional and printk logging in igb_main.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
Changes in v2:
- Change strategy to avoid taking RTNL.
- Link to v1: https://lore.kernel.org/all/20250428115450.639-1-ian.ray@gehealthcare.com/
---
 drivers/net/ethernet/intel/igb/igb_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9e9a5900e6e5..a65ae7925ae8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2175,10 +2175,14 @@ void igb_down(struct igb_adapter *adapter)
 	u32 tctl, rctl;
 	int i;

-	/* signal that we're down so the interrupt handler does not
-	 * reschedule our watchdog timer
+	/* The watchdog timer may be rescheduled, so explicitly
+	 * disable watchdog from being rescheduled.
 	 */
 	set_bit(__IGB_DOWN, &adapter->state);
+	timer_delete_sync(&adapter->watchdog_timer);
+	timer_delete_sync(&adapter->phy_info_timer);
+
+	cancel_work_sync(&adapter->watchdog_task);

 	/* disable receives in the hardware */
 	rctl = rd32(E1000_RCTL);
@@ -2210,9 +2214,6 @@ void igb_down(struct igb_adapter *adapter)
 		}
 	}

-	timer_delete_sync(&adapter->watchdog_timer);
-	timer_delete_sync(&adapter->phy_info_timer);
-
 	/* record the stats before reset*/
 	spin_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter);
--
2.49.0


