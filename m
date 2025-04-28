Return-Path: <netdev+bounces-186408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C225A9EFC3
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC2171BCC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B3266572;
	Mon, 28 Apr 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Wk8oJgFQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A8262FF9;
	Mon, 28 Apr 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841299; cv=fail; b=VCrnjZRZ+2KaphRjDz+p/eLxpvgFbxm3QNwBotZPP5zymirzBjk3cUtEksgWmKLTj5BArRpDJZTVUTQ5w01EGntWOUXVVMLTkAuBMlxD2ZR1uaMpSSsRHWJaSOoy+tf4ihPZF6mVUMadnCRkgwHMSlcf2AmRW7um9iFwYgTtmPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841299; c=relaxed/simple;
	bh=g4tcqT2SJXwUkvI99PwW8ESbmIxktOjJJvt+YWb57OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SU0D9GgClqUFj/br1dnyLcp/x98rtZLk62YlrBmSnsGUsm3uBALl80+fmWomvxzGeDksrIgRf2Bxav49rqAR18vWgGXIpXg1qrit3HRw/gZcDqxTHLoUaQH+UeSGlIO5luUGnguwiZlERAC3Y9pTixgoIYrRKV3Qnt490UMCelY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=Wk8oJgFQ; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgeQQCB9y843UeyuwEgLMXirG7BOlwQrS8HuDY1p9ScwajbmuqUK8WtWPuR4gZ4TXu0Ggn+75YBLWcQeqZlpZEqVL6OvRdYII1OkBLR9wV1wIOcKtmAIFxBUNrh4003smZZglssCQ2nTiKv5qK9Q6NP3t3PSS7j7qR37MnGdlIxB/HmIFmUwxSS/NRs8/PXgVfR6IOtyffBkOpL+CjbKlClW+nq5GdmZhaXh1SSqNdc/8I817hBzAUucqgJXObm3iEkRlRJxT+0yUUAVWfbPbUZNdQiq21WhHtbWTx9wWDadahw8QNVsxdCFciXxVQSwVqPskhxoBfD8h1z4CKga4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bii84k2PSsRjXh40KifrKxUEqiTjcBYHwDngS0hjXyY=;
 b=dos1JW9wkrbJaZCre9QeNntxsBl3tWq9vMEJ2ZZj5x+UhJg7pknLG6IgWM9LsB6wuwnnS21TrEf9m2s0C2OSLVY2zc7vOr30ONM3dwlCPBcXor+e9Cx2WiElI/Hhw1FDpz+69de7iZ8Dlzvjrfiy4S5jZFcc/VoyHwgbKuP1jtzPjfpa3ym0eUzNO5YcKIUo8TEap4vi5AWuVWbQ9H9brnNoo3I0bKziVGvt7xv6EdSUtuk+4r/vA1F4TxwxXcQ54WwzhRxPYy6k9mee0wvOolUmxA4f0EPwAR2Jm8pLKPXDkuUuAJKU49ywFizR5xY+dVCtMmSt9zi67pCkK7JbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bii84k2PSsRjXh40KifrKxUEqiTjcBYHwDngS0hjXyY=;
 b=Wk8oJgFQISz9pEodmkYiu8E799kaxwJ2GIPBpvn8y56K0euMkDsZMW3hyijBkgkY/oA6/SZKc5ihz8Kbg7//nCeUjUcvBn+3hM05cZGeygbj1iwC/qKT3sCB6ginloTVBuTmBFjTdzRG/crQu5/sOMFhZZ6ILuo1N2TXZ3XHQwLcYZpgQrpLJk31JS2gV6Dq9p1rcBZ8ahOV/ikpKIS1P5jUDjWhR5xMlc9sDh7OG2Fq0DW+0vHgKtHmOfw6t+lQJCIDF2DXHsQldTfEfxLwL1ZdDnuAtvS0nFHDTrCA2NiBA5w7y0wEcNEotSuTVrtmSGYxhSxvwasxM/a063fzPw==
Received: from CYXPR02CA0092.namprd02.prod.outlook.com (2603:10b6:930:ce::26)
 by IA0PPF72D6B8141.namprd22.prod.outlook.com (2603:10b6:20f:fc04::d2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Mon, 28 Apr
 2025 11:54:55 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::55) by CYXPR02CA0092.outlook.office365.com
 (2603:10b6:930:ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 11:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 11:54:55 +0000
Received: from 56525d0f2b9b.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 1AB7CCFB78;
	Mon, 28 Apr 2025 14:54:52 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
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
Subject: [PATCH] igb: Fix watchdog_task race with shutdown
Date: Mon, 28 Apr 2025 14:54:49 +0300
Message-ID: <20250428115450.639-1-ian.ray@gehealthcare.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA0PPF72D6B8141:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85f25c44-a405-4338-f26b-08dd864b7e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FAhU34PXalv17WLgh0/3HjLsSdxXfAaUBvnc3dNQ1lcPlD/6UbkPBgKVXwkW?=
 =?us-ascii?Q?7mi6pXW8beoY0ExMEO2ZnwLD4Nji9rMTvu3BAevchM2n+KdxzCkFYG5DdxE9?=
 =?us-ascii?Q?MaHfJI0Ga8hU8bYu3BvwD14VdbNF67bSywgw75Zkn6X+ngbTtQu3i7zBZEIt?=
 =?us-ascii?Q?pkiyr0pVx6PB5JY/e7+pMUDWqcoajlVxkH4yxfLaief3+zm8CnNdVmMNeC1D?=
 =?us-ascii?Q?99rdVGrH0GmNCSw30IOuaN47Kkj+k9F+XYaOswrm8iABZiOq4XLGd19n6PKF?=
 =?us-ascii?Q?KnIu6+idGMLq6ifJSmmaGqpgwZgu8EfbxDyFDp6irBKRKO7ARz4yoZXxlIsN?=
 =?us-ascii?Q?xpjkmpXC7lrgxm3WBXnI6pc6xewsillMK09jW92L6WnnMKCI1BjckOQzLCIj?=
 =?us-ascii?Q?UUnOEp4/ca4fskAT6QoNKZAhYt4lJ80ULnVcd72+cJlns50Fu/aoPsjwAD7d?=
 =?us-ascii?Q?J15VRqvaH2TQmgKkfGB8OJRNs3et7KP4/PrXUuchZ4EsgHutpC5OQO3BMa2q?=
 =?us-ascii?Q?g01msyFEbIVO8bVLllxbrlZb/y6x6PIv+pWgBFHEDemmb5EV0H9PMvCTlCgz?=
 =?us-ascii?Q?Jqj1b84mksLf5L/0U55E6YAAkOE4h2e/httdKYYxPUWzSwM4sZdmvbbmLc8Q?=
 =?us-ascii?Q?XL4VvqsL/G6aoB+Xgoz4GuqlHSK+IqBx2cECS3fO5Z0uuTFkclU29TGGsMpj?=
 =?us-ascii?Q?ZS468Vca1zt+4gJLqy5Tst6U588ZVKML8mH7m4E392FmTRR+jiaFpcBPSm3a?=
 =?us-ascii?Q?MdP9wcNAc5cCoiV9q0cwqTvFONDsd5cSOJxxqDnreDS8vT0TQ9iz7g1eE/BT?=
 =?us-ascii?Q?aXXSLoiTIpwhNSQwdWXYxQEHwYlXR/ZNUEBnVbOGSXI0jr90HKBtCv3jOSMT?=
 =?us-ascii?Q?3SmM+IQU2wZfbCUXEvfNPR/O48niq3dWr5yoBf2lGuBoWbBvPC6EViFNb4xd?=
 =?us-ascii?Q?E6fS5lf1QPgHBa5jZyRZ/Z4d3BRTk4KyOhJxm9QBIq53gTY5gsXfhmv3jzvU?=
 =?us-ascii?Q?bP5xIWHF0cVhGYrv2k2bw0FLW9vGCTnDIQHtGPhMHD9TX0AhOiPd3b/4Jh+X?=
 =?us-ascii?Q?pfMOPPR065RySWS3ZMuEft/BBEc0RgRGRpGtV75lD3j7PBcBmSlDeZ3bKqO8?=
 =?us-ascii?Q?udwqL8/7+ym9nRrpgBLTOjW+293rwPIDwrdB6MKcQhSC+lc3c3wUP3VVbo+s?=
 =?us-ascii?Q?B/jElae4TeHy9oQP725zUqTACqpv12OIMn2nco3AbCml3Sek7GbViaQRm2X3?=
 =?us-ascii?Q?RZJe/2vxGCEUh87GrU5zJDCXozgAE01TI8kiuysFYvOo46jw4cQM3Wk9XLCj?=
 =?us-ascii?Q?jwPewJnLl46AnjS122NJ8JEfk4JnMgsEd1skhlraIiXwxsOgMamo9eaH9zdd?=
 =?us-ascii?Q?RJdL1tDJW1MNtm1+YIAhg/nboiuUsVZiIYOPlqPrk5Ayp16G9TOBbb9R0Jw1?=
 =?us-ascii?Q?HHAgV/FCAPJ+HQ+NIU2/rHrsEzm/QKRNvLR5Au8BosbwoB0oVB6qpHmqnEgq?=
 =?us-ascii?Q?g3e6EiDZ2X5gF5b4d2lPme5cdhkOHZ3MAGtp?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 11:54:55.1689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f25c44-a405-4338-f26b-08dd864b7e30
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF72D6B8141

A rare [1] race condition is observed between the igb_watchdog_task and
shutdown on a dual-core i.MX6 based system with two I210 controllers.

Using printk, the igb_watchdog_task is hung in igb_read_phy_reg because
__igb_shutdown has already called __igb_close.

Fix this by locking in igb_watchdog_task (in the same way as is done in
igb_reset_task).

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
 drivers/net/ethernet/intel/igb/igb_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c646c71915f0..a4910e565a3f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5544,6 +5544,8 @@ static void igb_watchdog_task(struct work_struct *work)
 	u32 connsw;
 	u16 phy_data, retry_count = 20;
 
+	rtnl_lock();
+
 	link = igb_has_link(adapter);
 
 	if (adapter->flags & IGB_FLAG_NEED_LINK_UPDATE) {
@@ -5680,7 +5682,7 @@ static void igb_watchdog_task(struct work_struct *work)
 				if (adapter->flags & IGB_FLAG_MEDIA_RESET) {
 					schedule_work(&adapter->reset_task);
 					/* return immediately */
-					return;
+					goto unlock;
 				}
 			}
 			pm_schedule_suspend(netdev->dev.parent,
@@ -5693,7 +5695,7 @@ static void igb_watchdog_task(struct work_struct *work)
 			if (adapter->flags & IGB_FLAG_MEDIA_RESET) {
 				schedule_work(&adapter->reset_task);
 				/* return immediately */
-				return;
+				goto unlock;
 			}
 		}
 	}
@@ -5714,7 +5716,7 @@ static void igb_watchdog_task(struct work_struct *work)
 				adapter->tx_timeout_count++;
 				schedule_work(&adapter->reset_task);
 				/* return immediately since reset is imminent */
-				return;
+				goto unlock;
 			}
 		}
 
@@ -5751,6 +5753,9 @@ static void igb_watchdog_task(struct work_struct *work)
 			mod_timer(&adapter->watchdog_timer,
 				  round_jiffies(jiffies + 2 * HZ));
 	}
+
+unlock:
+	rtnl_unlock();
 }
 
 enum latency_range {
-- 
2.49.0


