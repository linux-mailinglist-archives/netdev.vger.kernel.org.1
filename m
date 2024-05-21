Return-Path: <netdev+bounces-97275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80D8CA65D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 04:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273D92820C6
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 02:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43961D520;
	Tue, 21 May 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ruI3bhyu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8ACC2E9;
	Tue, 21 May 2024 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259747; cv=fail; b=MvFwkkcvnMi2ESZYsJvYHm9NyIFhtUcR7IGT9IhgnjjKGS5k2ZbVqma9MbJmvwu9jHTnauBzW9YJnnYfBuJRnn0G8wiSh9xDGtL7MKE0hsvILvvZabuHVX7PfOZlo5pkILfTBPitYEWa6giJjrTAV3Sxd4Ga3WIZRy/8oxPc0To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259747; c=relaxed/simple;
	bh=sIcJihfCnVmU6fDU/yfIvXnoLRAb5vJH+SJpBa/Lbk8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hxc0VsIZGSUm33jg9vRAzYlo1wyfNI1W3o7lhQhd7ATjiV90N0L53HDPZDnbMsGmnbuFy+OTjtFdHz1ff+eTAy8kzQRD1l0WmJZMOAtcZ9OYnA8+Crm3kmxA5dGrvxmDncPXdccdFHVSlFZRashj2QMwMfD5maNfnlHqtRj3Pkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ruI3bhyu; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLcng7cVOOJGQgLoyTniQm7qKlTQMk3QhDhoKOOlBNFipcv9i/xu6yC80A0okbCf2NbAFv5bIXoBGPHdAMxMzGKaeXwuVSNYkE893XpFl3DtFUYY9C+/SrjIcp7NA7t2hHcKiMPcne6g6DeKHKieAlzLw0a/BxHBixPXUJLKfzZlRNgSlc2bjM2xWa5RdIgJDePDGfdFnngECOEp7uNRJj6RN8f0iYwXv9jspl1LXt+ZIDQFXMPVYndngGdBz7fXpWEjVwalh1jtEoSKBJ9bO5UqP8YPbFZMNBeT0pivA9/HudmXq20r7MFMPuW8lZlLjJ3ycwlazZ77+9jyGcG2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwiVaI3Cev0Elc2NGhorXezcOJzbXf7sPJrNi+vGs50=;
 b=ApLAopeArGYU6kE5z13ZQDnD4BfDXg2PzZX1Dz8pnJ8roMetxxgtuCt1Ne54TP0PNLHVLl/tx8bwxU7fS9r2n6Z5E2+m9mijr/YbeyByBCrrCldNaxe6galqX+7p+tC3gOwU7tB59fnFpchj/4fxwakNdbjRm0nenLxh94EVKAU9FjzmdJCCMxXlgYRt4hE+6YlMdaerG+m8AJ403MAhUJJaoHIHCfXBCLpBCgoE6R9jp6pxPsBeatdrVx+t7YAeMTuz9y8MrAs3009i4ED3o2mSXbVDR39K9xJIn3FW3H+UkBGmPSqaPIpFJb7Mvqlq0K5FWR4aVB8vRfMfz4nYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwiVaI3Cev0Elc2NGhorXezcOJzbXf7sPJrNi+vGs50=;
 b=ruI3bhyu2CcZKxeJ22rcea5SMugpX5vxTt/tQqEvqYFvyzCW1YyGdOOaN6m7C6FMp7Yq4xpdLWgAyR4vhltM/sBStiIDcMx80SGA5RheiSy2PKDvIGBwdmnUl4wqAuwqDU8rw3H5r0A5ANd2vj8nLt4Zp8JAznSbkrz13uRL9o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10094.eurprd04.prod.outlook.com (2603:10a6:800:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 02:49:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 02:49:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	richardcochran@gmail.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: fec: avoid lock evasion when reading pps_enable
Date: Tue, 21 May 2024 10:38:00 +0800
Message-Id: <20240521023800.17102-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10094:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbc2711-412a-468d-ecbb-08dc79409233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRwm6M/ES6zMnZAjSNj8Q1gANIdVxn4PqFILdiRZadhnvxTCvYFZNfyzcogG?=
 =?us-ascii?Q?aKWVtgKzWAc3YGsxXxKJpg/4IqhnkiBfU6JYFQREnEOwqgXodmaTdKsW7mk3?=
 =?us-ascii?Q?/xArzKJThBIXYftm5Ql7opdyTV/F0zCfU32EHcaxMqUzs7LW5Ek4j7VplCqX?=
 =?us-ascii?Q?wBz+73VnBlHFYrjgW5hA2Cx37EtwKgALXjZoPJisiqD9tdb/X2aWkphYhoxw?=
 =?us-ascii?Q?BGYdAIjNwWfG6IT0a4muXsu4rY9oJvPib/aq2yjw/S1j55L0gxWsav82+XjV?=
 =?us-ascii?Q?/C5msyVBopfs1umCBwjZTB88K/jwDSMpu+XDlsOQ+pcR7IhFZlU/YxrIdW8H?=
 =?us-ascii?Q?KjGuu5Cp1KI4PUgaxdvBb60eb5u59WrhGAvSytnT9eGRM7iwr+sfgmglDALQ?=
 =?us-ascii?Q?4Kv8JMs/7DfK1SeUm1KwaUhVBODTk8E8jnjEFJTRMN6Z9Z/7sQvcEYkNGWSk?=
 =?us-ascii?Q?Qq6xqSPfQLkCVmKSF9dxEmKZvQH/SZvFfqPiHpDDtidOXar/BNMYhlxZI7gX?=
 =?us-ascii?Q?56YJJtx2zygVVJ+YHEmwNEV2lIvxmXZlZV0VafI42/eS+GWb8S8+ylWGX8sh?=
 =?us-ascii?Q?533tSbk3BAaTJ/Y3b0ATJzlmdhB9pYOvfSXdXT1ea0APP/fuF+JNOQzfaVr0?=
 =?us-ascii?Q?6gwSdKCeQiRBIVVnXWnH9z5uy83yHp0ZRPK16IouAcjJL3O0P1CpJI+lu803?=
 =?us-ascii?Q?0E4TLfXWWkfxWA/07FfanWSjRzxKWnfSlcueTJV0hSGwpP7/XlZqqY3m9mTL?=
 =?us-ascii?Q?ENmSB2KCB53RG29fHB/uA/FyjoNLlKeXAl5zzqyf85ZVkWZh4fLLUvLdixGr?=
 =?us-ascii?Q?1DRo0sDSv1KO2wpkTuBTXDVThY4Xxzw6paZVZULH9UmYYucmp2W718Apbn5e?=
 =?us-ascii?Q?XmZrZ9Mlksgzt0fa1BMsvwf1Goz7F5pElyVlEB7oM0SbbIrjjF8qKUMMkmtT?=
 =?us-ascii?Q?FVgF3XmZFtMZV3rsWGPBToIiO7CVY2YGS6T0NfWilQXFdMzDGue2a3U+ADn2?=
 =?us-ascii?Q?VZRyD0KI7xNfsZMRd4WWWE+fQNpocivvWIgjYz2GhpE58TV4AAM2lUiC8hZb?=
 =?us-ascii?Q?RkTLEkA/COZThKa02lCjWr0Ewg63eNTk0xQGGJIxn0Je4zTMxKbDdQN0I/LJ?=
 =?us-ascii?Q?aCIT3EoV36CuekNoDhT/8gCHhFWwN3HHZR0CIPnOLbvNgNtJwI76tkpu59BW?=
 =?us-ascii?Q?qbncPPGIAnN6rdNa8ki3ihw9AGC2wnTSmZ9YZv/sLGAEc1za01c9WshZWInt?=
 =?us-ascii?Q?37R83nm4JzGKPPISRQMLksCYtO/eSuaC5dhdeB3FOOM/PqgMAblX13Yil0Hz?=
 =?us-ascii?Q?2qWSslNBqhp7ndBee64WhwbWlXDkNJOdAQ7UgJs0/CFe/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5woukFLKNDy1pBFOYbry7rw8ayA7DrVMV+EkjG3G6vxxU0Dmxje4jhrDF3Ix?=
 =?us-ascii?Q?XbpD+juqePfUJySi0dltcr0mFnYQdsyX8AHg0z6oeJZYmm9Z8gWOW2Vajthu?=
 =?us-ascii?Q?6fydqOdGhsPOHmcvXT4t+Eg3vWBrMt63Qx0qYO0/ZSNFsG+kjJRN3JhXGm3n?=
 =?us-ascii?Q?YU8wYfCD4gu/af1drdYqJrIYZnad/e2HM9+HvE87yJ9+HoK/lBcrmF7iCey+?=
 =?us-ascii?Q?OPZwPNhctcI80yuhLr0+2CMRRPUgfclA+4iN1rWSVw4yjnKYQXrvTyoVU/Ro?=
 =?us-ascii?Q?z5OLlsn5RCivbl/zOArDE40OTFP3e9SFPz2fJY0zxV6FrqUjvndtXjB+KKL4?=
 =?us-ascii?Q?PhiRiFyOJYQGVwdqCUzrIjWEgpOOXx0Oc7vsLKRaJFkukuX1sQ5cuczdyfJF?=
 =?us-ascii?Q?HhG7uAi/jPhh5hUURiE6fmEYiZD7w/rdeUSz28wYlViDc8a5q+BMgp7KxKnv?=
 =?us-ascii?Q?SR9zEW3o+rsigwcK49VoFhd/OPD0BLQ5vwWjzwnxia6WIA90ZYmq8rafBO+M?=
 =?us-ascii?Q?DEolZlngSp0wMsLarmbUTj1BRx96Z38XweZH0IiJ8o5GHPhpSDdH25WqlZHM?=
 =?us-ascii?Q?bVhxJGxXCuQmAdFFqoO1+HMg6cGFqw8qkbinbl3+3oiya3ULlPwkIVurqPH7?=
 =?us-ascii?Q?WEdA5jQ7gH/Z4c0ohDmpsD62BoIkkvnwo93BLbqTu2xXSf3KuxiMYE/kF8Sl?=
 =?us-ascii?Q?LxAw7UyWGspYELw+rJqNNCY1Hvpsoi+SaKO30+q64xYq6zpn3+LfiPyV1wcE?=
 =?us-ascii?Q?ZQ4d4z4OSBs8fBdwxfne15J0t/Mv/eeLuiiwjf9KKpuZ63htsbq0Rd42t8JZ?=
 =?us-ascii?Q?oWOSNlYrXBy6ly3h/vpM9c5LMNNPrDh2KXoFiu4D9ZAHAvF41tq9htFKkQdV?=
 =?us-ascii?Q?DQ8juYXvyxHsbOrBf0wl78LEVrP22XjpuQBHI4Y03qXmBKeXngQbZShAPjK0?=
 =?us-ascii?Q?WyTCYqSjwUTTESZ+BjGg+Wa+dQvLR7wGiqWh1QdcMRidBk2H6PjfwFZTSF8b?=
 =?us-ascii?Q?NFsdPVeMWrs9igVxsgE43rCzSgG9NV4u2iwq0YoVf4OrHnBEI2QTjLhX6dRo?=
 =?us-ascii?Q?UI500JlFHKhri4O5VdJH22w2+UJcmbA+HwbN6SpILzPoMoMcyGHKQPMhgz5V?=
 =?us-ascii?Q?4hrJqSTbBoo03H6VocvCMSrJ+knL0w7Avul+SazQ+5sXvr44h0GuW8xg+nke?=
 =?us-ascii?Q?VHQD6cXzW6DSUeVGZYegCLXHIOnE5TgsZd0rxLDRB7atZta2j4LN25zQLGCI?=
 =?us-ascii?Q?s9s/iHVBvfW3B6zAjguFywrzppUQvhdNBuTZpRVtYXzBaiKRxZqSjkszovG8?=
 =?us-ascii?Q?kbKXyz88x7mRv2bLizn8h6PEE6MAipo0TvII1gA9Iakru5fs2FKNHO+UGH8G?=
 =?us-ascii?Q?Qdas8exWYX57Aua5A17vKEbT6nrEKyngSec+NrCgoRUgzjcE+l/SEgZZNvD6?=
 =?us-ascii?Q?0FXCbBi7fqiygbJTMZoiN9wo3KJQ2b9FtXIxEhdnx1LJ9aNjy1y4GBZMPyIa?=
 =?us-ascii?Q?egCAJXFU7Sl8gR0RmsIt0eVRZjNcA9i4Nv+wL1OBTknCbCrUuQeaIbeFr0oF?=
 =?us-ascii?Q?jG/HkeV13QnEp01PhNflqTFe/UhSJ5V//wEliqsv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbc2711-412a-468d-ecbb-08dc79409233
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 02:49:01.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sFFmJwN7Y+/f573l79f7LkiqO82NRtdLTRPNsmBNpUXw2vCB9437BLibjIsol9THkoaT8PbWfWseGwwNJz2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094

The assignment of pps_enable is protected by tmreg_lock, but the read
operation of pps_enable is not. So the Coverity tool reports a lock
evasion warning which may cause data race to occur when running in a
multithread environment. Although this issue is almost impossible to
occur, we'd better fix it, at least it seems more logically reasonable,
and it also prevents Coverity from continuing to issue warnings.

Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
Moved the assignment positions of pps_channel and reload_period.
---
 drivers/net/ethernet/freescale/fec_ptp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 181d9bfbee22..e32f6724f568 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -104,14 +104,13 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	struct timespec64 ts;
 	u64 ns;
 
-	if (fep->pps_enable == enable)
-		return 0;
-
-	fep->pps_channel = DEFAULT_PPS_CHANNEL;
-	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
-
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+	if (fep->pps_enable == enable) {
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+		return 0;
+	}
+
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
 		 */
@@ -532,6 +531,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
+		fep->pps_channel = DEFAULT_PPS_CHANNEL;
+		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
+
 		ret = fec_ptp_enable_pps(fep, on);
 
 		return ret;
-- 
2.34.1


