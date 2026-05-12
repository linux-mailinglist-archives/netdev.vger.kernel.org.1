Return-Path: <netdev+bounces-287339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF0UBjyuA2rT8wEAu9opvQ
	(envelope-from <netdev+bounces-287339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8555F52B181
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1DE63100263
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F4387346;
	Tue, 12 May 2026 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z1Dw5JwI"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF23A6409
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625886; cv=fail; b=QgqfX/gSbkDtHc9RrIqU4ZyjSBN1HM8ha8XczSVdiVKtv/V6LmsqFtZQjE5wDZCMCc3BIUNJFx3TQFIPjel2AjCAeAbj/kUse4txl2JoaMiKzrCxwbN5fvLI+U2e5TmsuZkpjB+n6k/jEpjKzc2bIaRW2icONPt0DD+BYnZR+8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625886; c=relaxed/simple;
	bh=E2Z4DlAvSIP+cjmtdUBabhica0U7vG1ZR0fxhA1ZPhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4P/mjhEe4CnfNHBeF4KttCnM+iUlCOiMeExLltSl7rfEOe94ZSuo3+qTFOYfvNO1ECj9SINFRYUIIczfAfLp5zHdDlVxSVHY7QOOBpgzz5nLBlHf6bgVYu2O5nJDnLyYFw34FnjcL/SoWYaOJHLj09/JPCXnaDQTN+IsGH7cPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z1Dw5JwI; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA5Frgf25Giv3WSWyr7aRZtKlCLKXIhNNoHW761UwEesrB/DkjgEV6bsPFYn76YGf5F1Nz1LvDx3+JHZTLvmMbLa3FqxPpIyvHGbr+rrdPAsjfz54ff+XSLQ6/gDaBO+nhcJTCtMtFJxgOWqr25ai+HHvQwuB45uViGHFtlDaP+16gGAtY9tzZ/dw4ohfs1m+aKSCAcY3zeSruIg6osSNIxgiHIZsE0j8yN1f34/F2/l7eVb88GcoWSosXN3rnuBCr4uCtiiF9zdeUAv7vzfvogMRZrx4tq4R6NBiSoSQK/fvHuc+DVZea6HTckPdJgc+eZRcS6bhgIXiR4q2P6l4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjhoeuu9sqNV+ktVqX7cNM8FIyqcJ0SvU7EhK/Cyd8o=;
 b=osfJcou5GTToNOFQJAxrRGSZCJJf3Dh89kI8tfQXR/uIoDEo9oVpsBEzwJtpxF1zJTZP9Ul0PJM3dPpYmuyjwyftOpU8sX2VJb5EKfcw9Vtl45Bz297kGHFt1yTq06/y8ldLwPcBTZUyUxrPy1u1H0eclNo0By4/+O3TAYJXFmaMi2NJ/aopx5HegbuSaVZ3bxEj84kwWFd9rPWuQQXctIEYe8AkvREBx+DIIP9elkYyy1CpZeSHF+2Z5itovTlh7RXj9Ytkkzwb76P2qnghy2IlzgNKuAn8E5odk/ZnVwxkkfXvirhIBZDGv9WCPBobsVNtfPyrEBu1/pke15JX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjhoeuu9sqNV+ktVqX7cNM8FIyqcJ0SvU7EhK/Cyd8o=;
 b=z1Dw5JwI+RFEaDlRzXOpO2WwXlIqTecS1Yf9gvm2Rucy6huZwP3Gmw8Flq0NToXlXMPP9bbKdharvoCEAd0zF4VZL5v9lkcZfX5gnm28InfKIV4hc/js6G2gDbdzf9F3zAwv84RLHU5c7qguD4OrhNbIiUd5iLCHOAxbjtV0zn0=
Received: from CH2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:59::27)
 by SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 12 May
 2026 22:44:40 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::ba) by CH2PR03CA0017.outlook.office365.com
 (2603:10b6:610:59::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 22:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:44:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:44:38 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 2/5] ionic: Get "link_down_count" ext link stat from firmware
Date: Tue, 12 May 2026 15:44:18 -0700
Message-ID: <20260512224421.25236-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260512224421.25236-1-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SAWPR12MB999142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2625ed94-da69-47bf-cdab-08deb0780d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	JQr373CmcmPanu0a5T8wl0eCeM2vy+5G4dWgd4koiWWohlT4B1/wO4oZCNhym/6S7Y4Y9tuV0khGn1ccYYI5IuY8ce0uuz0ngKtYOWdk7XmfSiexLtediMFpOvoU2Ntnlu/9Y+VnHWmiMHImhK37+3ijcqtZR5fhZPN8dEUz+Ip0E4IwFXgaitz9f3rY19Tf0qzWFlJj9vA+T481l5+dbQHODiHIwtpyUipL+Zl6avMRgAmf97AocQjBAQvKG+SHsavowkQ5316IzeOdZ4kD+auUjEF5j8x/boknk/LuD/kl+iSZ/PFyvPQivbQYn3Wl4ixFKlLKtUYRrnP1SDD3Ygx8ohQ6zb/P/bgWcvxwUbIrq8us/q7x9FBiK4GEv76qu2FeZ3koZGDtav9sK54kdOWZN12ucfEZfKAzPc22o7hVLoZfDvTPxdAlzuUTZ7+AZvV3UnpJDzzkst86BHwQLlk3U2Vx2VefG3ZEo9UOL8WKThs0l84duJjc0cp12ARmly5JxiLaAcBsA/G+Xr4zr1J6zqR+HI8aKh0KEO+fSo6H8DYfVKhMm6O9feVdUzh30mJ8jEQ+zIT+Vv8IqzTsDRCWu89jZ6TA0ZU3c+jk4+M9XrvO4thaZokzrgcPUWM4modDf5vwqeBelFKDNOS3x3Y72roRJqelsdoxce6dSb2je6wUOHYFn7jKRJ0kNkAFQNo+bMdXUCb3vxyn0cHEx+lNKD3xjRERHKk8BIgcYUI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FQ3ono844kkwto5Xs2pzlAbwH+P7BWDNlFedW3yJcRc1V3T+xP3MLdhocNFWtxciXX9V3Ug+JzKYNqk2xxElDrgEuNkSZptZ/dKMcaxV3lx8gZ4YeRrc7p8Xg9JawWW9kOoerg/kH0YzelOgsqrHe407EKLfzdpniMdbNGFXaJ10yHeMbX0w+fgx3ZaPAhriT5BebY4J7DyygA1HyhJUNa5ieuVOcHjnpG1ubKryunTkQIGWB4FF1xuhaug3KSAKp2GSBD7oA2qimChrW9QexYbUAsY9pKrChuhdhKogJp20h3fja5n+ulldgvsAVNWikVLMzJQKsQp7NEyvy7vQ8sN/5XhA9ZB2Pb0jnwGTTPbFu7o5PSJ5P5/qH6vyUMtZzR2C2Z8EysP8C4XLaHDNII52fsjSrtb+n326rX49yLSh5SsvEu/ZZ8yDwujucUB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:44:39.7662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2625ed94-da69-47bf-cdab-08deb0780d3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142
X-Rspamd-Queue-Id: 8555F52B181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287339-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The number of times that link has gone down at the port level is tracked
by the firmware and sent to the driver via regular DMA writes to an
instance of struct ionic_port_status in the driver's memory.

This statistic was never reported in favor of a driver-derived stat, but
doing it in the driver was never necessary since firmware had been
reporting it the whole time. Since it would be more accurate and true to
the description of the statistic to get this count at the PHY level,
replace the driver-calculated statistic with the firmware one and remove
the driver-calculated one entirely.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 11 +++++++++--
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     |  1 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.h     |  1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..cc2b294910f6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -115,9 +115,16 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
 				     struct ethtool_link_ext_stats *stats)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic *ionic = lif->ionic;
+
+	if (!ionic->idev.port_info) {
+		netdev_err(netdev, "port_info not initialized\n");
+		return;
+	}
 
-	if (lif->ionic->pdev->is_physfn)
-		stats->link_down_events = lif->link_down_count;
+	if (ionic->pdev->is_physfn)
+		stats->link_down_events =
+		    le16_to_cpu(ionic->idev.port_info->status.link_down_count);
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 637e635bbf03..eb7e552bc12e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -179,7 +179,6 @@ static void ionic_link_status_check(struct ionic_lif *lif)
 		}
 	} else {
 		if (netif_carrier_ok(netdev)) {
-			lif->link_down_count++;
 			netdev_info(netdev, "Link down\n");
 			netif_carrier_off(netdev);
 		}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 8e10f66dc50e..d34692462036 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -214,7 +214,6 @@ struct ionic_lif {
 	bool registered;
 	bool doorbell_wa;
 	u16 lif_type;
-	unsigned int link_down_count;
 	unsigned int nmcast;
 	unsigned int nucast;
 	unsigned int nvlans;
-- 
2.17.1


