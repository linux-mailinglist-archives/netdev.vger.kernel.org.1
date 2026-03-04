Return-Path: <netdev+bounces-263805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFvQLz4lqGl3ogAAu9opvQ
	(envelope-from <netdev+bounces-263805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55B1FFAF9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371B530B8269
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA5B3A63E4;
	Wed,  4 Mar 2026 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RIP6yxVd"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328C7370D52;
	Wed,  4 Mar 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627045; cv=fail; b=YRGkN1R8LgvbiLLx887Lui9I3GC1XSnwCBJI7L1/z8PWgFBjab+GFwEjfwezUbH9xQeRtlHndDkUx0dYlv2smH4g5eFPTVmzPxtheU8jrNK8pMm8yD0pppcyOI8VCpaOt1BmNv3HoAgNfe90Kats5erCii5SH4NxHm6bdqAXIrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627045; c=relaxed/simple;
	bh=4vMWbSMMlgebrvknDwJDU+BCzmYRO0p2S9OCZHoXHK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYtIKgbxHH/yP6rVeDFYSX64szkvfmojWvB49x3FsXCx0VrfFioWIrpLhh6hesKyO7ZSy2f6bzt7tlCl7HiVliTcZc3IcvDAHo0P1hOFyte3FpowVhTTtNO7MiVEYSFeECBdlzZYNupsvJldOpMkXZB3+imQjCZWs4tlCSH5bg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RIP6yxVd; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P924ISABG13VPuSe5JM+vxJgK+cU1SUXzvzh/kI1gSQJ811C5ri9lWWrTImwlTDpa/eXSjpK8I4U4hY7ib+S3DPWZAEYbTcUM4B5flPhXljswmutvN97x4J2Bn18Q/LkYeD4gMEp0yKAN6sILbrq/uFKkVwVoEHC03PgX+ZHONNx7T1r2nSqo7rRU0MCGf3L/A3Z87WutbvFC/gdTva12Miv0z+eLNLfBlMz0GUPZWSYmO0pJ2G4peY+RFm7CkOH+SqD+eN+PD1rWnKuSLZy7s8+9+LRYu0OpVkD5kfxXr2H2fFTg2sFSf0+7LjZJWVK3mpfLKLoApI/At9V1ZnJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TargNyUTnJJPTHkHQ7JsIMdEpxsLwSXcifNujEv2ke4=;
 b=RA2CuDyc0vHOA6NX97ZGDmSo+J/Y42tFu+k40Uy2oAyFEJ4tiPqZuk8DCv5esPL0y3A+Rn4Ibf650r7LlzmAiKrxRQn+2P8j96/PmBcLGId8lllLWDL3k1keY8s+63y7ewl0UbPlxPLdj1VhKuh88nrtu65vjiHSn8Ac/3kjYncQjlw5mY3ktgeHoOIcLYx2fR+ww6WxaeeVPCfv/lINnhEm34KE+YY8eRSQx6mhxD9Q4WRmU2GSRlwqBzXJdhnoEWU1Dtf9DrMS+3iAeZe2KKP2QVx+0+N7F6vqmbTP2siqneGRwYRHo8BSeWSsNRGqKvvf8uu1rtQklpBxVKZPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TargNyUTnJJPTHkHQ7JsIMdEpxsLwSXcifNujEv2ke4=;
 b=RIP6yxVduC/X3vbsQ8T7LI1Lm+C/LkdhYKxQruMsChMBxSl06BXNHDh9zzXKQLns3ab2effPywvsKCRv626E5OL0EKHWd+IiJwyEvkaHwqafmhFxzD8f68kq2mPBf5L84wJs66vwpx1jhlz5fKgWnyxncYEowR97AqFdRRa507g=
Received: from CH2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:610:4f::23)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 12:23:59 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::31) by CH2PR18CA0013.outlook.office365.com
 (2603:10b6:610:4f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 12:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 12:23:59 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 06:23:56 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net 3/3] amd-xgbe: reset PHY settings before starting PHY
Date: Wed, 4 Mar 2026 17:53:05 +0530
Message-ID: <20260304122305.812541-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304122305.812541-1-Raju.Rangoju@amd.com>
References: <20260304122305.812541-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a8cc4c-91c9-48b8-f5d0-08de79e8e9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	GXMeAcNCm8vOVDu3/o011mG1ByQronGsS3VGY1vTlCPbfbGhqaCLS4wYni7MuOd984JNPA4chAr+zwTo7Gs2PO/Lf2Y6GxaDu1yRd1eCaElhDPB/gp/Qcs4PsuNVgAcTB5AHwF+oLOxvJikI5g2fNQn6SZgBkuBVIOymFo8sqcHlcdodPQm1lqyAvGsYHQfieDfMaYXDfKfUK3YX/CfKPD+GpnCHISk5vGPSXGnvq2xrpo2Vn1QcwbmCXF6hpJlZOHvLYxuYqXf35YwtNpmMRhLLbj0nZwQ5T9MljFvLwpABy33EQDVrshonXtpDqkrXwAubcu0Cd56XuRIVziQtLLxfb20OnAKUvmZH8VIg+vU/EteDsktKWwkEa+P8XA1Gz9UBm9N6FMzl1xyrwsRrDSeTnrCiGpMizpmVVHU5824UK011maIjcsHrhc2oqUZ5843e4Tqza9Qe/HVnrMqUsu38Czq0RwB68zvMnjelfN97yQz6ECuD7SPKjGzbDUAjujVvuAZrA9oAy708I6qqYHkPo5/UzT75JZ+qK97z4ZBgONhMQsNWCKTZKBMh+iP/cDl2t1COKSKNsOTWK00sPKyT9+V3JZqoA5gQzXG95uH9LinHSMfv3UYueuMqg+Re5HP3piPEpFuNAvKLk5hxEwthDzQKXsCmn5HtnmcabfBcgUmQ/ftQHr6KXTjnKEPZls88+lPlqwxZx+BMrxYQ6sBXiq7EgWznUfpVyxd6Q+al+IgF2QLRSVrNXlW14BVCJvY74WJdjxrzGGDnFhatCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9dUxGhJtvjIg2Fk6bae9AWnh2lQ4/riw3QRrqA03xxgcHDZUI3zJf25eBGdDvuNBi2tS2NIknLHB5SaZzSUvx1KajkyopecKryb4ayCu5lkxKaLdt+AfG5pzSrYE76Ti62D8ba2tffDMgwAUQB+h8rPSdX7sGEfi3GS6AmZyFS7ctOaRcc9Y/leeadGR/HR/WZ7/7I7AFySfcX0wQ7CMjNjwVGGqOiLatIcKw5wZWnRTG4h752eF+BptJWIOV2Pok98ocrhHxT3+1bOrJbURejL0kbCgGrjVmqudDSGDl/z+sHCRJSjbVjqrDZDr2tjJPCw7kvApQ6Si+nxLWd5rc49WliZvFnCuY0CxxjaXSkggLwoLpr/f2qMPAe4ac7PFBjrIIbNVNdMRs8rStfA+FNjpRyX9PDuAkdvpBw3WSBF7EvYEnLroZKTWayPYJYLo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 12:23:59.1982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a8cc4c-91c9-48b8-f5d0-08de79e8e9a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
X-Rspamd-Queue-Id: 2F55B1FFAF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263805-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

commit f93505f35745 ("amd-xgbe: let the MAC manage PHY PM") moved
xgbe_phy_reset() from xgbe_open() to xgbe_start(), placing it after
phy_start(). As a result, the PHY settings were being reset after the
PHY had already started.

Reorder the calls so that the PHY settings are reset before
phy_start() is invoked.

Fixes: f93505f35745 ("amd-xgbe: let the MAC manage PHY PM")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 8b79d88480db..fd4f451efcb2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1271,6 +1271,12 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 	if (ret)
 		goto err_napi;
 
+	/* Reset the phy settings */
+	ret = xgbe_phy_reset(pdata);
+	if (ret)
+		goto err_irqs;
+
+	/* Start the phy */
 	ret = phy_if->phy_start(pdata);
 	if (ret)
 		goto err_irqs;
@@ -1280,11 +1286,6 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	udp_tunnel_nic_reset_ntf(netdev);
 
-	/* Reset the phy settings */
-	ret = xgbe_phy_reset(pdata);
-	if (ret)
-		goto err_txrx;
-
 	netif_tx_start_all_queues(netdev);
 
 	xgbe_start_timers(pdata);
@@ -1294,10 +1295,6 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 	return 0;
 
-err_txrx:
-	hw_if->disable_rx(pdata);
-	hw_if->disable_tx(pdata);
-
 err_irqs:
 	xgbe_free_irqs(pdata);
 
-- 
2.34.1


