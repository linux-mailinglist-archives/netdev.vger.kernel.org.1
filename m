Return-Path: <netdev+bounces-169770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B85A45A72
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5567A7966
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AD238150;
	Wed, 26 Feb 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FUwQm791"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFE2459CA
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562791; cv=fail; b=ccIZurekpYz81BGdgqOaWsLjK/r4fcyfzHAxo/cLT2WG42+lWn8bDhHtX9GBzilYtm89WX/NwsUj01xFAKN3KlYwNtBqI5o2MpuOFuNhSWDcczCDozD+Im91sOBSfgWsDzGQEuXEQYNqiKjqj2o7AfriOoOTvzEui/jJ0yjn1VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562791; c=relaxed/simple;
	bh=2YZ5mXyRbfXm5w5dF3nagO6ys6LYgjlsJUtumFMPZxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Leo5RNeBxXe/mEAPCa23RBS58QXNlIfQdRXkOBbU+hffB/ZRwiVXRzwq/An0XBnuS7mpG+GDnSpRHdsnfY/QxGEkP1ah/F7oNsIo4CO5dwnz2GmMrRa0ivKYsB6P4BP+zQtTAIhNzH4FB2fYgk82WC9DNVyXaQ/IvEOiEncBW74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FUwQm791; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1Swdq4jsqA6z9KWg35viNtWGHnRQu5Jd2c/Ds7K96nwyjmLtx45loAFw/h3GaoHdAszsgeyw2b5kxPSs5WzlLgpFobKCxScOg+3x9Nr22p4eUuZkx9DghTvJx+DwmbFPsOSuDPoA1tknB9E94pLPNoV33vfyE7osEDCDJFjfEnXCNmgWQqPIxyP8dBgD8f7jYZNLBJdgGlL/Tdo40FxNVLuGIZ+cHJ7l5wtZpf9aSAXNwGV65eBUeosWzjNgL1o7gXNGE4Z8h1zxN/U1D3eOx65CPBSfQUEwxrMVdsk5imbMnX0lb3EFpeEH6E54lu2zXHxWSRqxvBA4UYP42PPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxecmR697fsmiXP7i1obhupNZo8zOUA2AsxlRmfPHHo=;
 b=kw3ZABESsZ+Ad0sJORo6HfPOHqLL9toAcKlW7fVYGlreqWq89XcjfH/AqGZQUmaTQmOE9RcQwXKyO3xFXE0FEnUMOkzKPTYdI1K/YMxv7j3LQfcgB6gjf5X0pt0PaZce9C7dh0eUxnz2jP1tdoS46QO4htabw+/zKi/oXmq3YaduSA+q4RRLihj59rCax3r+tXklqyvccNsaQKy4gFiD3LFD1qBBiK1mAaPPs3hARHUeRKaXLZFoBevCEC8NXflD7Yn8gUL2yrPMjJU+H1Ye8qz88z6nuSfsT+irXvo4ruRWLOR6+C6+fwbd6ohK5aBMG7PNoHn25aIwjeEl4E424A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxecmR697fsmiXP7i1obhupNZo8zOUA2AsxlRmfPHHo=;
 b=FUwQm791Ygk3ny3UIn//71fD191Qt3RhfrEOZBk5GS5i/LzEt0uJbRYu7MWPY6Jgl15yiryMHnnAiinLrOnrtQtRiib1c+6pgSGp6bPC/AoQdFgxNfVx0ZDsarvaVxRjnpLvri+kOPJgnnWGQx0PaZIR19jAihUFrTSzrc7wEi9xZ1NzD7GmjSlI9vR1CH0nOR1QFqhFzymbKUEDzqDKz5Iljy7/1LTkrhSR3Jsu4OZUPoE5tlSdwkheYePo31KKH9DIhHaboDTBDtSxTgyLFH3HPiHFQ6AuyISgcXaJwV2T0VqrPc9ZlMdzFwQ2/4eO5cqaOAKoGHLTYPG6MCKc5g==
Received: from BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 26 Feb
 2025 09:39:46 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::ac) by BL0PR05CA0001.outlook.office365.com
 (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Wed,
 26 Feb 2025 09:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 09:39:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:39:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:39:34 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 01:39:30 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 5/5] ice: dpll: Remove newline at the end of a netlink error message
Date: Wed, 26 Feb 2025 11:39:04 +0200
Message-ID: <20250226093904.6632-6-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>
References: <20250226093904.6632-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc45947-fda5-4a93-5573-08dd5649811b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxeSYhn0D9/pYWLaACiGormjIt10Mxez2n62/RwkShZImdFZhTkhDxjSNflK?=
 =?us-ascii?Q?JUHJYtMOQfuesj8pwqyumylqC51IE68wGJwOfM0OjcNKPUP78Gc1xwUdhuQ/?=
 =?us-ascii?Q?wcwF5mWfUNe5ELTwfT0uVAJJQjO2EP0Evu7RlEJR2VJ6bUu5WzdBqFx+jrED?=
 =?us-ascii?Q?b+JbodxES+evKInBqqoCeRfPRhdHGi2qKD1lAIMNuVqp9QdCTHQSUZpWyxk+?=
 =?us-ascii?Q?Y1nkPxiyTrulwBHwRSPxOTC1g1+7g8isjGI0qiD7WeVNsQ8RDlnUTgTmguHY?=
 =?us-ascii?Q?UiNr0Ty+6HZ8DqnQQTZc6r05/H3jPcMU5XHXrwjFhDgTWDRp0yuajLaoGsP5?=
 =?us-ascii?Q?GgsR2pH1+KfCcs7fFiBTcQ597CRx+vKnRMe2Kj8AVB1mCr852UhII1fH2VI6?=
 =?us-ascii?Q?2J40xrrfjxKtoAgYtuKGBxhCMe4YMcWL5CZkviGVIJ1XF5SoI+21327BAzt/?=
 =?us-ascii?Q?rm2KchEutfp/L1NcgVgPxDDUFeyNarRWl6Oq+eg/XJvWl1BHKWHGpv1DOwHB?=
 =?us-ascii?Q?lWPu0K4zHqWarQz3LDUyUPcjTJZ544FL1uNiMKoNMSZz/jhG473tS0Nx0Q/X?=
 =?us-ascii?Q?N5c+7mwXdwAHd4LxNwpGIykGnTg5yBYv5hiARdvnZqa4sfnmryc7N/YLfJWT?=
 =?us-ascii?Q?mtTOHj4C/tq6lY0LWKpwzwHFJPz1vhGGN+V9tElzjMk0PJbrK/sGovntbZRp?=
 =?us-ascii?Q?qdI4wZ435PThlyEnxpZSz1tetriR/yE8z4mpYB9COxMd7rQtfdiyf4AUt6SY?=
 =?us-ascii?Q?IqluRQI8vMa444nx7BwD+gJK/Qc/T1tpGMU/mS2kND3YoF9CbO5L5g8wk8mI?=
 =?us-ascii?Q?bs2pFVJySWuakMe+2QMsQy6aoh48gMJoEn+dIp3Yi7udNR/kf9lohuVjkKpd?=
 =?us-ascii?Q?PN3jbQIisUuSPgFi9RQLlDLav/5PFIAq3tKmcLr7PumcgRf0Ia+RbeIIGTAd?=
 =?us-ascii?Q?bvWiBFGKhHKm/i+4Hd3dITwamJAZlgQ5w3u0wcMztquHk57Ddx/vDTQdphzx?=
 =?us-ascii?Q?aP3qlkmCciXgbs3Hh6WS81Y48EOF99S28IX/R6IY5iAspQ9Yci/O3bwtkT9m?=
 =?us-ascii?Q?zbm8LmX+PfzHz3euGuSKTIr5KeJTZvl6GD6hNr0htE6NxQF44awDEQ4MTEHU?=
 =?us-ascii?Q?Ey0HGxe/kIcZizjKKm1K4nglNxIvvGsflaMd1BIPlxk6SppgSPdeMefDsMzW?=
 =?us-ascii?Q?jfjYwWBey+XXlGUmTjvLFN6aL2ZUa/fvr88JuqoIQ4gSkUiaA+sEkIjOg+xt?=
 =?us-ascii?Q?9jfRcaY/ThCO3dF6+JKBu/atGXHKO4XNhWl8DCQDa4mkhLGZ+/LJY2wRK7Am?=
 =?us-ascii?Q?1X19DLC1mUyD3NqWeQuy2jMcFbVGV86tJDrWf09lnR/sTAlwZyt3sptJEycN?=
 =?us-ascii?Q?VfvpwIAry7308F4mCkqVXbxKxXXTN5jIuzlHj6Gak8GkaOAqj/VhIb5sgs2d?=
 =?us-ascii?Q?zcLHpQkwit3MBer0Ehu/YqwZt1E+o1byVg9dusFtuaz4q9qn9pUIro1ep0mf?=
 =?us-ascii?Q?p92tBSCqsYp9Czo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:39:45.2788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc45947-fda5-4a93-5573-08dd5649811b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

Netlink error messages should not have a newline at the end of the
string.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 8d806d8ad761..bce3ad6ca2a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -95,7 +95,7 @@ ice_dpll_pin_freq_set(struct ice_pf *pf, struct ice_dpll_pin *pin,
 	}
 	if (ret) {
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to set pin freq:%u on pin:%u\n",
+				   "err:%d %s failed to set pin freq:%u on pin:%u",
 				   ret,
 				   ice_aq_str(pf->hw.adminq.sq_last_status),
 				   freq, pin->idx);
@@ -322,7 +322,7 @@ ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 	}
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to enable %s pin:%u\n",
+				   "err:%d %s failed to enable %s pin:%u",
 				   ret, ice_aq_str(hw->adminq.sq_last_status),
 				   pin_type_name[pin_type], pin->idx);
 
@@ -367,7 +367,7 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 	}
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to disable %s pin:%u\n",
+				   "err:%d %s failed to disable %s pin:%u",
 				   ret, ice_aq_str(hw->adminq.sq_last_status),
 				   pin_type_name[pin_type], pin->idx);
 
@@ -479,7 +479,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 err:
 	if (extack)
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to update %s pin:%u\n",
+				   "err:%d %s failed to update %s pin:%u",
 				   ret,
 				   ice_aq_str(pf->hw.adminq.sq_last_status),
 				   pin_type_name[pin_type], pin->idx);
@@ -518,7 +518,7 @@ ice_dpll_hw_input_prio_set(struct ice_pf *pf, struct ice_dpll *dpll,
 				      (u8)prio);
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to set pin prio:%u on pin:%u\n",
+				   "err:%d %s failed to set pin prio:%u on pin:%u",
 				   ret,
 				   ice_aq_str(pf->hw.adminq.sq_last_status),
 				   prio, pin->idx);
@@ -1004,7 +1004,7 @@ ice_dpll_pin_phase_adjust_set(const struct dpll_pin *pin, void *pin_priv,
 	mutex_unlock(&pf->dplls.lock);
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to set pin phase_adjust:%d for pin:%u on dpll:%u\n",
+				   "err:%d %s failed to set pin phase_adjust:%d for pin:%u on dpll:%u",
 				   ret,
 				   ice_aq_str(pf->hw.adminq.sq_last_status),
 				   phase_adjust, p->idx, d->dpll_idx);
@@ -1362,7 +1362,7 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 					 &p->freq);
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
-				   "err:%d %s failed to set pin state:%u for pin:%u on parent:%u\n",
+				   "err:%d %s failed to set pin state:%u for pin:%u on parent:%u",
 				   ret,
 				   ice_aq_str(pf->hw.adminq.sq_last_status),
 				   state, p->idx, parent->idx);
-- 
2.40.1


