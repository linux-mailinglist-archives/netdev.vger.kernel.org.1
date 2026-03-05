Return-Path: <netdev+bounces-264176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIeaCBoHqWlW0QAAu9opvQ
	(envelope-from <netdev+bounces-264176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:31:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66920AD16
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AF6B304945C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0C238166;
	Thu,  5 Mar 2026 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1C+Auk2"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3B21CA03;
	Thu,  5 Mar 2026 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685052; cv=fail; b=bmPWLFQ31fiNZfw19INd/s6W6loBDnH4hE9sbyebGPAH1dzKJB4Tcl+VGchbX/URwQBH72Y0MMczmEVUXcbkNfWmHfFbUgrpq3jqRmpNBg2bEeQUiE9vp4a/3LznJ2BJDDvsoL0VX9MT9yzhiC8MA0D4zDxHM6Ihq2ocE26jKy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685052; c=relaxed/simple;
	bh=MDoh9XorZwXNQ9Z8MdYsn+6HL8ATvFbUSWeJRhub+Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZykJlXYmPOzJ0YwazqZEwDDxAIAqPT6gJD2HioQ8zUScIAAbeKPtOZAirzqQX3q8aozN7MR0pT9YffAkttXTnUd653+jFz7viCZDgQchUJ0rAEQfkyBfK6q9kQBSi/6Csf6cYZU7tC7AyPbaJvHPo78UNm77OkBLxVBgGCPcGXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1C+Auk2; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7Ws42tC1Y3S/Bn+wnryXI+sSE9DI6LFoJda+UvoZUhjz1nitOj/ONWiotUSWGGNrxC6S4tqFyvG0BqwpiiFFGZeNfzaAV3DDejdQadxmLf7HSxPYx1eL/W9aeKF7DuF+SwsLtp83HOwCuaxayfdeo6Bdu58LPAGM2pvXuu62Ivcr+OCOTKiEeifI7Q97TCF8xrrLBwFYiTtXJi5RfckWeaYxoBzfM2nM0Oa6jnPCUp2fXr16w457Zy01vjMfJWsreWSF/n5K70OyBHh83aYgUNJMZ1kjiwpRFkzfqpCFiRaViDDVzabSEFCKTNQYE1x/Q0y7vvqNEeu+kUVR1nWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgiOldHZF8acyCanz7c4xusYDK52DN3aidndYtKD70I=;
 b=eaQyGIJR+PmdfpkyOmlsltiZuLwYqCm6L41ZJWIRXdG4ba4g9u1BvEmObz4CDHmFFjxvQ7xNtS6/HGxpKAqGToY2mTjD3d2JIZbgAQLOG6V9h69GYfkzX2uxxD8GynruTYBvNw5SZxO+oNvyzzqIs6hD8clZh6zGzAaaMYz3Arfw0PPYJ6V7TN74uHraMQDwaDgp/GEaN5gmd0XVd+bnG5WrmcSjj3pgwryv8OB4/xXT9A20nEIaQQnLseV2Ksi8YiSi+6KA9zORvX1pU5q/fRLuanZymB3Nf4d60teOzZ6HwKBjj28Rw2m2KfBJm9G9PBI6bV62hUPDJ+P7UWF00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgiOldHZF8acyCanz7c4xusYDK52DN3aidndYtKD70I=;
 b=i1C+Auk2nJ8zqCzkEZkR4gKKhweQFtbRqIK+MfFXWS7oDzj27DDJO4Z8ubHbehnnRhDd7+vlvV9M2ahVn/xcwMYmrFRz6C4zSNjloGFS6YFurh2438i013CCCvSbqq2TISDTDECYAofer1Fdsnvoce/ZdXIXNKEX2fpm0ZB803E=
Received: from MN2PR15CA0058.namprd15.prod.outlook.com (2603:10b6:208:237::27)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Thu, 5 Mar
 2026 04:30:48 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::3) by MN2PR15CA0058.outlook.office365.com
 (2603:10b6:208:237::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 04:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 04:30:47 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 22:30:44 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v2 net 3/3] amd-xgbe: reset PHY settings before starting PHY
Date: Thu, 5 Mar 2026 09:59:52 +0530
Message-ID: <20260305042952.835926-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305042952.835926-1-Raju.Rangoju@amd.com>
References: <20260305042952.835926-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: d28fcdff-d5c1-4a0f-e845-08de7a6ff97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	nzjfIfFtbKf6DYnDyjCOA3Y8eYNaMeoYOsDNh9pVnn6M6mQ5HGp7zkc8N+eLEVf6D0HKeQUbQRziCOtDs+7xG2FfVJVZrbXuYRdNYmBObbrNzwi99B8zwrj9wnh09ycGo88wqU90WkYEfe87WOvpl4OPuQCOn3Zc/qBDRucv5sT4LkycYWREtkfPHVIZmdglapuckVdfjBBrqpS3Xj7YXF5+ayoEm39OoEBc41Z52Y0izgdk4csYTow2QlLElIXYMuKmb5xXfM7lEcH2YSrrEQpPqAjTuTV9UYunCiuCqNkYZIORjHq5gnPsvQFekmn9yMsSRISrWNcTWV/iJIIXOnzjcvOAT3CjWLU3DFRleECr1TBkrm52/f0nq3B6EgHlDpFgQvgHz98epHx26HDatpOShmhJwF6lS3fj/5Q+7NjRulDswVs/u2dfXYliCVilQ4I12RrDeCZ67wTkSqkwtldS5euMWZBidYI8DiG7ZjhzEVvW4hpnNjC6Cf4ntMk6xv1WgF63R44pIZKd/1j3bgAS06pOInmvmFyRmsr0Hu1IB1wXOQ8LbqIkstyiS17A6hNEqZvSJuUGgJNAyNC9QCEKXKNMIXRx2SrDMySgyhLNGRXtb/lck6jGKFYWVj2RzJR5gGbo+axR+7DAoD8ghkgr4gdEQqPlKZWtcCmLGlYc7xZ02c0346ZDAylhu+hv/ObcvMq/9CPoyqpI/9Uql2LhQsDO7MLbu8A+rbK7aPcfofVU4HnPkzgslI43Wzjq32xS+TUFSvPaWEVFTKzsnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9e8C7DsatOporEYQQSSH46UySeu3mMS9XwnGI874Y/oMTTwbNK3ELpAjkYn1kzZf8NSd0wUTg5d4Mgv6E9UedbZpSMestKAmer6P6Mv650xLjJgylm49PJN+B0YQLaOW7yz++2v+airBQUIxnoT+utZCf6rraU441HrKRvAEg4qxfOdKjW/B2rvgeufdR0kswA7iWvLk4DXxlk+wwoxDiCyBy27JPLrGLu0qvtbRlrqAlqJcHJfskxRMQfc7NOCcPNaWlcvqAD0M1Ng1myQyYxfXeX4FvCxeIyydi6aIr1XChe75xSg1xRf2RZ0pzj05h5P4QnZDwN6H67FdSkbp+l89aU29mwqPEgOnEy/UZ+1fycrAwsiYfRyUHqbZgBEuyXE2tf/ppTPfZx714fsmx1YEAMNiV7VVcBSyhJBnyYx5W7h28vR/OQAje5VijhDB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 04:30:47.8359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28fcdff-d5c1-4a0f-e845-08de7a6ff97b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
X-Rspamd-Queue-Id: 8C66920AD16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264176-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


