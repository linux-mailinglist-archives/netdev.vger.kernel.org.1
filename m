Return-Path: <netdev+bounces-264941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BEDMidOq2lYcAEAu9opvQ
	(envelope-from <netdev+bounces-264941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:59:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4752022829C
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51786305E991
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BC36998A;
	Fri,  6 Mar 2026 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VUHXW0CO"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565F3EB7EA
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834213; cv=fail; b=nPrwzddYrsFUt0R8zGgFCEsxDc9HFDka/7FTg7mRtWqD8RyGyBpRj8yG2bE83WM5U7Ewrl1587j4+msfRj5coYQqtR8YhAP9H5JWGeCEluy65CISyobshiRJnt/kFjZ170hdlKDFiJw2Wmv1bthvsDxwYH+/A8JSNoH/tRCNnsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834213; c=relaxed/simple;
	bh=SZOUMgv98bMMxoE8Rw5mHSXIMLaf5gmzHlM+HiEXtDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uupMuhfO45aUlyXg68EecglSLgXVLX4CMBVzTh4BIe8WPLDD2QlnngkkGUTsRP+oYb23TMcbVP1mXL9frGrLPKCz50RenygoG4WuFTFhVgVEZrujGiymI9WXrsqxpMZ77chfAhnQSYYTVuy7dBwnAYiy6xiVIZvxWNIrbgNYYw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VUHXW0CO; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ureHCGO9l1WUF7eTZaou9fGWSI80wxisHf8zF2rdn7+6VQACRXcBl7X06QEpwNooePZG331nq7lPoBEkEa3OSCDmt5RPNzSsyJDmixS9mYifujAwRW9EGAg8LMtFiz9RPrXy7zIUK0J9rI197TI1l7LSHDuDCZK1GZL8VRB8uGWfwQTFYLgpytYnI/LQLAN4+FGEgprfBYrhVU8UeTr6nfDN2IJsFYUzuWr0EHGn60d5/0tSVDHc+n/o8lfTD8laQZ3u8BO5r/YsLO7xj3bFP29REZtz0KsGCT6nhMXsw8CGOjrPVL/gIpvB2n/wHd8DTmwZ/8H2A0efUtXTm32TEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEVT5Vtsx7txmMP4ObQqo645DeSLLswT31NL3HYC3gI=;
 b=ikcjALJKcuZBHHB15TUx+dLNiaWqmHhDMF3yQY6qWgoPfxylpLqpH+UlpL9PCDcY792JzsntCVd2spQYzYqQxszqNEHpBhd+CzghznwGj5g3kgxPPDu5Y37nvYC9c526+xJ1KL/qCeBuHXY/30i4IBQTAWog83dEnxxUrvr0HyQJeNj4eWgWB8EKPs9glgcqoxmdziBBawK2Yig34kpS9RkbopcJzCDAWmr6Ah/sM0ndllKvV1C91xepn7nluGKEHY82XFa0IXccvVb2IhaPgyh23EA8TW4lPwajxAAZgaeum+L3THkFIinIe/CvYj7PmJYTAhhq2bWt34l7yZUqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEVT5Vtsx7txmMP4ObQqo645DeSLLswT31NL3HYC3gI=;
 b=VUHXW0COfs5uvLwKyXDuQHIED0940/F2YcXQfzlLMMRFz9Qwlk1Jx9XnQEtJhqmcszPs5GveMTdnC8ThNFHoVXEM9jWqgISweUWYWXej91u1PWhwvQMeYp2VOmtRBzupSq6kwZ5pet1LgiPgiWLiUyU8XPDAHuigckaRPW2K+Ys=
Received: from BYAPR11CA0066.namprd11.prod.outlook.com (2603:10b6:a03:80::43)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 21:56:47 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::c9) by BYAPR11CA0066.outlook.office365.com
 (2603:10b6:a03:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 21:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 21:56:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 15:56:45 -0600
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next] ionic: Report additional media types from firmware
Date: Fri, 6 Mar 2026 13:56:34 -0800
Message-ID: <20260306215634.64550-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b19504-7d5e-473e-d36b-08de7bcb42ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	6Sy51XwkEbKRzqYNlaI7/84y0+4Qt7HVL7Ws/UXqx0OyqAsDsTmBSsZbJ0365OTgX4sKqioHHCDLxWrT/xfLTHPXshUANcbdp8H8/IuJZvVZ89jNz3tP+DnPW88D30ZHrxBRjuxDrhNds6p0gw4u3t73R7GIxXFBaHKHvCKDPU7/feJH/p13oU5+gXdmZqpSV8yhwcWj/bZxx8VCGHFwr3UoYFebVvlgbMRhGKLOUBaStPlNK58PymuncOJTdSIoR9ai50yIP6eI/N7GDb5Z4mvokIufmXzCXQ3H9sVmNVMUYNbKwYmHk9setAQw9NdbPX5AUFi/ChE89xoC2gmJqNWxSZzZcFEOnhParYERUgXHp4va1uoaOG7XNhktJTM7daomdjSxXU42Jj/LnvaGNLb4TfPCmnY3XpYp4G37KcI18MtSx0GY95UCazziQ6E5g2IwJht3/XLErm3N2HDYO8helo2EbcP2wHlXoJTXe4QADQ8Tm5AokxB8EOWXIhLqAUkqRIk6ILevN/DdcIZKGLQ+oyrhNsImatsYLYCQL77CzqFn6zpOWWW5hcCyqgr3tCYMaURLfkgB81ezhxlqgkztJJ9x8Sag7ULOsls82iRaHAn4XrTQXS2z2AfhC3x+L8c4hnmZeAVGll8rtqM4O9YjzW6pfR4X47bzq/4hEJYbe+BEieFZYIpVhuF2K5+rcAMe/LYur3NxwA1m3M+QtMahowDOTxdXNLtAFpT5vIrHOm/1xNcy8yQ5gQHEqxQgQDT1Y+8w0j21QlQox+mZeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7rEtPG+j5d3G+sozRNyPE3zYC2gRPf0s6OJXMVvU9qrA6ZjfqlytS/35KR0tTGct+Fn7filoi4mHj3KYUz6D3fz8Pzf5U0Xv2lgzUMPOR0jiNr4nj1rV4apiztv6nV5x+s4Fq7RILbAqDRt+KE1CT7/RuTX+L+DgcEa/TclzAvqM6TmfBDQ9PMuh7mcaFZHy8IRsYsvcs428AqfscE+yZpwU+VlHImg/pbV+dYUPO8wW3UfLOCijZAJNV0FAGXQKsTwTng4Krwrj7s41UjRLBnWHr2m1mT4MxUzY+XGGGpzzt5nAKuIcOwlZ6D0HDXkJdFqwfPf9E6EC828s8sx5GwHZzGqCMCHevIlQjs5YTI5xBuqvf6AxqZ9+25TfJeY4HCumWM9155PwK3Ku+nhkG/D9oZJ0CQZDyjxXJLYTjOYy6mbfvWicgDBVT44fcTBn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 21:56:46.3480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b19504-7d5e-473e-d36b-08de7bcb42ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
X-Rspamd-Queue-Id: 4752022829C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264941-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action

The device firmware supports reporting more media types than what was
there in the past, so map these new media types to existing ethtool
bits, which appears to be what other drivers do for media types that
match speeds but not physical spec.

And while here, make a very small cleanup in ionic_get_link_ksettings()
to remove some unnecessary code duplication.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 9 ++++++---
 drivers/net/ethernet/pensando/ionic/ionic_if.h      | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 1514c1019f28..78a802eb159f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -188,10 +188,9 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 	case IONIC_XCVR_PID_QSFP_100G_CWDM4:
 	case IONIC_XCVR_PID_QSFP_100G_PSM4:
 	case IONIC_XCVR_PID_QSFP_100G_LR4:
-		ethtool_link_ksettings_add_link_mode(ks, supported,
-						     100000baseLR4_ER4_Full);
-		break;
 	case IONIC_XCVR_PID_QSFP_100G_ER4:
+	case IONIC_XCVR_PID_QSFP_100G_FR4:
+	case IONIC_XCVR_PID_QSFP_100G_DR4:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     100000baseLR4_ER4_Full);
 		break;
@@ -212,6 +211,7 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 		break;
 	case IONIC_XCVR_PID_QSFP_200G_AOC:
 	case IONIC_XCVR_PID_QSFP_200G_SR4:
+	case IONIC_XCVR_PID_QSFP_200G_AEC:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     200000baseSR4_Full);
 		break;
@@ -232,6 +232,9 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 						     400000baseDR4_Full);
 		break;
 	case IONIC_XCVR_PID_QSFP_400G_SR4:
+	case IONIC_XCVR_PID_QSFP_400G_AOC:
+	case IONIC_XCVR_PID_QSFP_400G_AEC:
+	case IONIC_XCVR_PID_QSFP_400G_LPO:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     400000baseSR4_Full);
 		break;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 47559c909c8b..23d6e2b4791e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -1341,6 +1341,12 @@ enum ionic_xcvr_pid {
 	IONIC_XCVR_PID_QSFP_400G_DR4    = 80,
 	IONIC_XCVR_PID_QSFP_400G_SR4    = 81,
 	IONIC_XCVR_PID_QSFP_400G_VR4    = 82,
+	IONIC_XCVR_PID_QSFP_400G_AOC    = 83,
+	IONIC_XCVR_PID_QSFP_400G_AEC    = 84,
+	IONIC_XCVR_PID_QSFP_200G_AEC    = 85,
+	IONIC_XCVR_PID_QSFP_400G_LPO    = 86,
+	IONIC_XCVR_PID_QSFP_100G_FR4    = 87,
+	IONIC_XCVR_PID_QSFP_100G_DR4    = 88,
 };
 
 /**

base-commit: 1a9940317c1b46b7641af6b4b14c9d2509ac88b2
-- 
2.17.1


