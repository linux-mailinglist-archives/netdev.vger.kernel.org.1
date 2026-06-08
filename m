Return-Path: <netdev+bounces-296469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vHEQHkacJmrpZgIAu9opvQ
	(envelope-from <netdev+bounces-296469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31F6553AA
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:41:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b=BmnD7u0j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296469-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BEC23101705
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED93CAE70;
	Mon,  8 Jun 2026 10:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6523C768B;
	Mon,  8 Jun 2026 10:09:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913389; cv=fail; b=bU07DdEXs7bB0sEtpjPSHW25yDpD7MaA3/HtQgqg8FTbbNC+GzaXcxIg9j5R78f98ScfBLG/zXkspJEjMKUMXQlqg6t5/J5ZFQJWc3+PlcoarFWZyot92xzrsdh8z4PdYTVqH7KE2CHY9LxCQX4w0Oa7gR0aeUX/6gk4mUgL/bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913389; c=relaxed/simple;
	bh=q23tTpcbts98h9vrxq9s5YNEjm0zJ2RrGi0MO1moz14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If3CCM+4JE+o6NxBQsx2iXui+JZQttPOO+HPbsqMdlpXKdcfvSmqgMIysFGHOmp/FqDQId4h2lMTAqVkgicRCHN93QYRIy26nuBuMZiOwX0eaShQqyNnBAghUiPsnTdjch+T8LnxUte9EqoLBANan6uDbwd+R6fz7KAjB6U8P9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BmnD7u0j; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP0I553QoX9iYlRB+9JOpDW6EPftwRBzpw6crKrwGH3bKUPrdgu9vup+XV+/wge+gyx99/UKex3t76VXHpGsjYOGEgMltYIeFUC5RAACvu/D1pHpFyVpt7GhYVvPO2bRMnqiBCoAPi+io/N6nmP+Xjmxe4/8wS0lBbP3ZpoK/BLPCmZV5Jrl4hBb5aP1thUv6zSg8iOWIftLOC90Q4zN9WYy1lGzEv6isXQ02AumfDpNNc+xogK6RKBmj8cWlsK1oT239y8Cm+5XOVhB5IT99TG6tX7ONaSjp2E0UueDfS/WBCIRKelG0TTAYjk4d+40kaDF3/KCOvb34d548frBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAc1xAuqrqBbaNGTCiUioRckoU10tWBV0WzMjQokYxU=;
 b=qxHsJW5903riVbIg0q6zZAo6dvGxd+V/6olA9XPGAYe8yjJOtlV31qpgQH/hEAybTtSwDuGDxmcrU65q0DMEadUaHHziXiQ9Xs2A04jLAi8SeNUDc5izsDS4KxfzTEZFUnWJGyMBEqoDdJwcQZ3FXcPwUh5meceuT7KHFkmWp1r5b+TBHmEgkPnGSC20Pr0qu+K/+Gwms1+huHjGuYuDinCGStXaOkazxz2Qp/tTjCqNR+rNh6SnCcb/RJbRSqjYybNE6CPPLg4ZQ7vOQwOjcGhRqbp80KA9Kp0jPd3TO7dctJgaQ7X9SbaTZqsFSB0+4QNmQ/Y3GC+cZnWXvvh9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAc1xAuqrqBbaNGTCiUioRckoU10tWBV0WzMjQokYxU=;
 b=BmnD7u0jHmvqBWGjxfHctVIU2TDb7Anq+VdokmtzRIpAc6/S5wodF98WNhcg69Mg/r2tA3OidBx1K7rvjHWYd4e1UUNwA+tjowCr8H09s4a5hXLW9ZzPk1/0OFKCMASCZuq7DuKrWXwOK3z+B032yF2tqWVTnqCaI/EGFpuju1M=
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by PH7PR10MB7765.namprd10.prod.outlook.com (2603:10b6:510:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 10:09:43 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::74) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via Frontend Transport; Mon, 8
 Jun 2026 10:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 10:09:41 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 05:09:39 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 05:09:38 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 8 Jun 2026 05:09:38 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 658A9cEn3995727;
	Mon, 8 Jun 2026 05:09:38 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 658A9b1v015195;
	Mon, 8 Jun 2026 05:09:38 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>, "Meghana
 Malladi" <m-malladi@ti.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	Himanshu Mittal <h-mittal1@ti.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Markus Elfring <elfring@users.sourceforge.net>, Fernando Fernandez Mancera
	<fmancera@suse.de>, Jan Vaclav <jvaclav@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v3 2/3] net: ti: icssg: Add static_assert to guard stat array counts
Date: Mon, 8 Jun 2026 15:39:29 +0530
Message-ID: <20260608100930.210149-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608100930.210149-1-danishanwar@ti.com>
References: <20260608100930.210149-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|PH7PR10MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: a26eec06-01ee-44fd-06b1-08dec5460ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|22082099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	fo/6OvJnmCOP/s5YB5rQZ6aPY+TlAzmpYzo0nZemT/5SlpTTDxrwAgjq4D5IS3lzKKzV4glQ8QX8pRAGGn5VXida8V7y2vfOqbMLpAed7de1xStZV339Hq0Db0WJk8LXyLs9pnMupCQH6JnlfH6Mlx5nyJH16ElL4SiyBQsgaatFBNJXjWnygsOKFqGfXyGrJdd749InOwsOH/7F+M0V/4rWm2tk+R6Xq+yGCcJbNMAQVjJu3vzoFCmqHsLsan1qlx9jaZ5HFzezAoxE3h3gbA1UCdrGlDMOs3r1ZVbmzQBHRfjIQzIGhAcfHUnwAvSNChTeHWSWUn4XnbY3djSpv0X2ve/TUqMryGVz4zsepZ0IQ+1aGjYHYRHTbQz6LlrJltQaRoumUWYlzu/kMMcXkAQZw890fgOrPvY0fCc/zvEF6Gc1OUDQePugU4ddmPl5Bo4xKlDydnisgEGkjXeVstaCMm28kpS32NwedbtsKgCim6JbbmlHh/zECFTrKSfJJjzxqBq9uwzv3tQ7xy3aopA50a6lHYMEbvDnbRlGn/paeChd/6mNMAdgn09Rf4UmxYs4jp4xCLJcKnbrph5ehXGjLhcS/3QOPgPtv+vGEbrh76gwQ8tbXav+bZ2yMdA4fHU7/WtoMB7TGJHjiokA/s8uXORjmngY3uCeM/qVQx0AbL3PU16pmfZIxzoSttbkiJRV5FwkL2P/bxv6Vj2L+CBltDvbbFCaQD2lFHUPmjQ9FOWQv1y4RPkrkIqO0lGnqCmTQUqgNg9No+ba8/nc/w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(22082099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	id5aPVzBbLHi3KDSA5Klu+LgAX5wdcqa92P+k+ejjnX+ROaTXsT3zJFlfe1D6OCfORFXDIrC0Wn2HfRMQK8hKUhrRe6TmO9zHwoDxipfpcehi2rHTr8hJgIFVmHcnU1e6P4rtdl1YrrZZFBopgvOSq1zDwCYnv/1IlTWZevsLeSfWz2arSL6DCny9E+4D73hDUWuq0Z3XFZQvj+BNWTNw1tcdSnSAuegoE++yx/hJYx/liJF2l1nIgBywIBKvZ3/ZnIy6vJuJ0uPDwxj6O0egRcn80EYAwq8YWJSIMp1n2DepGBD8QrxQzEIas5/jbtV9NJiRu24PZ7rKGwFAf6sy7Ethq6Phd/UW1H6phDMVzqyWJXYm9hGBduba3jotGB1ZxlTW8yQvSgPgiXgWkyLvODbhG6Y9XrlTcOobEdkUMOpV481KWpTqEVTj7qvGvAc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:09:41.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26eec06-01ee-44fd-06b1-08dec5460ea2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7765
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:h-mittal1@ti.com,m:liuhangbin@gmail.com,m:elfring@users.sourceforge.net,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:mid,ti.com:dkim,ti.com:from_mime,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296469-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA31F6553AA

Place static_assert() immediately after each of icssg_all_miig_stats[]
and icssg_all_pa_stats[] in icssg_stats.h to verify at build time that
ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS stay in sync with the
actual array sizes. This turns a silent miscount into a build error
should either the constant or the array be updated independently.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67d..6f4400d8a0f61 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -155,6 +155,8 @@ static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 	ICSSG_MIIG_STATS(tx_bytes, true),
 };
 
+static_assert(ARRAY_SIZE(icssg_all_miig_stats) == ICSSG_NUM_MIIG_STATS);
+
 #define ICSSG_PA_STATS(field)	\
 {				\
 	#field,			\
@@ -201,4 +203,6 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
 };
 
+static_assert(ARRAY_SIZE(icssg_all_pa_stats) == ICSSG_NUM_PA_STATS);
+
 #endif /* __NET_TI_ICSSG_STATS_H */
-- 
2.34.1


