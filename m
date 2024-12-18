Return-Path: <netdev+bounces-152978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EC9F67D5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FF7189097D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700161ACEBA;
	Wed, 18 Dec 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wrxQi78n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4B178368
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530495; cv=fail; b=GRFLHhF2YM4udp6IMEUPt0zX8tuUdfOpE7+v/cPA3AX+8A7XXIKtmKbpYEpyl8NGDynkBmtL0+yIymG5pg4Ju6kZzIljIN/I8aIMoM5ml+UPq4iyQ2YFgOFJl4URj/OIAO9PsXhGiNycpO6XfEYRaOCi2hCVoNXtv+p7DO459Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530495; c=relaxed/simple;
	bh=GnyO1iac/WrqMbTmOG0vSHgYGX+7CaVE4WmZvEL1a8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yhz4McOUq0ukANij84AOtiOohAjYYeiXqwDNLkweUCTcAuyXzjfu6HbfMufUKKgkI/DQRUS7rxsG7wrtHm8kAPztU3SAF8WaslKG6l3X9V4nYLdXfBf37mYNeWgO6w8EixOTW5WLeUxg08JAvcA9vajTtEVaZ4Q6kTG/Jei17iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wrxQi78n; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZ9GcbG5MXHmKy/f+n37gBDqp8MBWIFrjc1WqTHz59LFxgiO08Kx6FSnsgR2EXeYGBp2RG8R0PlNZeu7GEgzZ/uSW3tI9/+v570NfabybuLBcLRxDtmzh3HWdqGohRGTugVQZ52WEUIL27oU4Pq6XWxfWmhzUg/wHwUEsCf9qL9jmEE4xJhLuiubABJcFxWs2cgNz+3YxkyXvL9Jx8T2YRyAEMpwq4iwVqjBWHxJmg1Zh1TUaTCqBuHyj2iBbdVio0RHvhOslivBTh1tCA4CyJwXDlx4Hk7ukH1X4BX6elMt2TX5r+lq7r6llgKxMfbEROk2gtETnDwwUvUUKSthAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRBTHpiwTHAZbZZyHew4e2S2UF5vxZUitxZVYQ1OJek=;
 b=i2tAH7lfnhW7teGDzwMMjgYta9u/HuOtVd75hyHJJCy0CKg6KnT26/KVjLKWMi6edzxUczqHKlcJeWMbfSppvGMISi4rCBqNBOEKndGYZULoGFsP+Me1GBMEjoh9iU84wKhjc6zzpDW5tzWpAQU08DNMWLy1YVFN5i4blg9xGeDgiuZVO+lVUSa0wlLbnqDqic0wlrJWI/GqE0fzPgcBiaQvh0ZTO2zZhORWZgUTqyhAszPGKhWWwG1WXx41x6aDnnEqjNbzqK37btjk+3wdBbOnBJ7+1od0uLHvCcEEdmwAiizlmbB3J0/mU0Mmm1h1BxhniV7SMRcYQW7jLEcucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRBTHpiwTHAZbZZyHew4e2S2UF5vxZUitxZVYQ1OJek=;
 b=wrxQi78nRBmTVh4pj8bPzowpC2SpACPUs4HLw1k4gNEz1oaUmFmJbAfbCjQsPklqNU53tGmMuOeBLdzKRJHFsACPNeVchm3oLCPJXziGFb5zelNlfRAM6uO0qXEVkeP03KLkRam1NZSaYZyhhhojP9HRVA/rodqpF0e51Rn23Kc=
Received: from SA1P222CA0031.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::11)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 14:01:30 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::80) by SA1P222CA0031.outlook.office365.com
 (2603:10b6:806:2d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 14:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 14:01:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 08:01:28 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Dec 2024 08:01:27 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Andy Moreton <andy.moreton@amd.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH net-next] sfc: remove efx_writed_page_locked
Date: Wed, 18 Dec 2024 13:59:30 +0000
Message-ID: <20241218135930.2350358-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: e86acf7b-2b14-448c-90ad-08dd1f6c7904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9xniDU7dTrHL2U5GXBUdG36Ybl/mevL+HbSROaQN8XKqD3S3+ec3FYSQ/b9D?=
 =?us-ascii?Q?H4bf+ItQlgalLbpBeY4eBG3bJ5OkT4yq4UIZ0JU5DoNKNcSGOZrR7iYDYZMb?=
 =?us-ascii?Q?Cy1X0HC0OSwiUMjByNEVjGXxlOexh1SZImcvy11dKMfvBdwLL8cDEWppm4nw?=
 =?us-ascii?Q?3UBg61NJxi4wNs7mW2kU87B9YZGRLV+ogYjb0x4YEWOxzyQyzWeNBMcExG92?=
 =?us-ascii?Q?bDn7BD6NbxJFPeAEGqyXJLgZs70/UV4p94KWfDT0piwabUTDTLJ9rMFX/Nqm?=
 =?us-ascii?Q?bZnumfuYwKO1AIHITZJIl85Q2qKtPYW6m8ZG+bmtLaSMHFdjK2CxY3g89TLB?=
 =?us-ascii?Q?ENHU8El/T5+ylZSE3X2PZJObDVJRBezugk78VPxnf/9EI81mStsE/1DHfg3g?=
 =?us-ascii?Q?jaO/ypraRs3E0pL2gffEHABnPz2MjC2YrRt6GL9R5vagQ7Qd1Y2BjkKvwm0W?=
 =?us-ascii?Q?mE01/AmRGsPKuHvmpUyk6h9HtKtiGbaMe1mY/dzeBz95fwIqq9w1BZpNWZMb?=
 =?us-ascii?Q?rlrD56kGR2eW1tWFp3VuHXe1HZAKJaaVpS8BJ3AQ7qYH8hTR8lGw7sWxV48O?=
 =?us-ascii?Q?/4jatpjLVRZSc/MqBRbFWf67hgz8bvVlc/wP9nQnZCThAYUhgdFHAksotq3e?=
 =?us-ascii?Q?qUG+RTJhEi7Z6+mZ/L3PQUqBDoljjD/pAWd/PUAV22NNPlqPyobDbUu7b6ic?=
 =?us-ascii?Q?g1gWPltM4mnDjekZ6ggy/lVi0nEslpCqcEV80HujIykhp3gtzGgzfvv3JAlE?=
 =?us-ascii?Q?x/gHPt3srv/0O78N1NeLbjhCRBQ+JuE9mRjKySMUpmd+DekbkLeEDK9MHHSN?=
 =?us-ascii?Q?+WNg2Rf/DODlzKCxVnR83KJgmGMZEhOgSq36B6yIwXFbrdQyJFXPR5pLvrFH?=
 =?us-ascii?Q?NK83t/SPznzMezrqVhjHiD3rbByfaYYQX5k9i5PbOKmCBD66QTlXgb/9GFvn?=
 =?us-ascii?Q?I1Q8ACMZrV1DozTG639C3euGqJjvuUh0D2vrhNQCoeZHjmFzwMEJVB2nTtZT?=
 =?us-ascii?Q?ABt88Mc0r4ZzsLVciBlyhQw96TtxmxgLS8NQtIZV/U+LlZmp/RaTaFAg6zoX?=
 =?us-ascii?Q?dFmyk3FZMuzVcSV3S279kzjPGLZB5lUqYBmVgFqRvJIH8yeDaYBXMv9spKaZ?=
 =?us-ascii?Q?cE9a+mBXrI6R5GIMQ7UMhFSjNIPxuJTANukQtN9fUdwutXAAAFBaIl6HhQ4B?=
 =?us-ascii?Q?ppphtr3k6zDWOcVjc1+a26pw/iuZM4tduQJdM6zb2Q/42izBwjKi7o750DHC?=
 =?us-ascii?Q?o1r2y/0U3lANnamrezszMiYV4u847ch/ycXqECY0ZImT+/VMAa4gLpSwiznL?=
 =?us-ascii?Q?jX206ireCFeLs5e9pfBIeg08tMhZx3pYSnKObheQtTm9+odF6Y5ilT7yMwDf?=
 =?us-ascii?Q?CvXq1fC+pJFM86D9yKMqn+p6YwIF89v7BPvoCGb39ZemlrglFbPRXiePpS2C?=
 =?us-ascii?Q?3c8bu48Hsntdr2T2RXxfDUPOuhW/pFH3IV9Hn1vRz5BLwqHfcGJxXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:01:30.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86acf7b-2b14-448c-90ad-08dd1f6c7904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

From: Andy Moreton <andy.moreton@amd.com>

From: Andy Moreton <andy.moreton@amd.com>

efx_writed_page_locked is a workaround for Siena hardware that is not
needed on later adapters, and has no callers. Remove it.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/io.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/net/ethernet/sfc/io.h b/drivers/net/ethernet/sfc/io.h
index 4cc7b501135f..ef374a8e05c3 100644
--- a/drivers/net/ethernet/sfc/io.h
+++ b/drivers/net/ethernet/sfc/io.h
@@ -217,28 +217,4 @@ _efx_writed_page(struct efx_nic *efx, const efx_dword_t *value,
 					   (reg) != 0xa1c),		\
 			 page)
 
-/* Write TIMER_COMMAND.  This is a page-mapped 32-bit CSR, but a bug
- * in the BIU means that writes to TIMER_COMMAND[0] invalidate the
- * collector register.
- */
-static inline void _efx_writed_page_locked(struct efx_nic *efx,
-					   const efx_dword_t *value,
-					   unsigned int reg,
-					   unsigned int page)
-{
-	unsigned long flags __attribute__ ((unused));
-
-	if (page == 0) {
-		spin_lock_irqsave(&efx->biu_lock, flags);
-		efx_writed(efx, value, efx_paged_reg(efx, page, reg));
-		spin_unlock_irqrestore(&efx->biu_lock, flags);
-	} else {
-		efx_writed(efx, value, efx_paged_reg(efx, page, reg));
-	}
-}
-#define efx_writed_page_locked(efx, value, reg, page)			\
-	_efx_writed_page_locked(efx, value,				\
-				reg + BUILD_BUG_ON_ZERO((reg) != 0x420), \
-				page)
-
 #endif /* EFX_IO_H */

