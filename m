Return-Path: <netdev+bounces-282798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLmII3g+82kGywEAu9opvQ
	(envelope-from <netdev+bounces-282798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897554A2371
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4185E3025E0C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280DA3DD52D;
	Thu, 30 Apr 2026 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ojUat8+/"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8D23EA89;
	Thu, 30 Apr 2026 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547859; cv=fail; b=CMk0aR5VI7fo4y+Y7M8gc+a1fQIAWhdplqR+3hyF4+1hz7gx3bBHLZM7mcSj+s94Et1O39j9dG/Okb/UArq7rRdGOShHPfCy14nVBfVYnm5ozFW6ZNpKMw6AHW/BqDiYpkuIEomh6axcbDKhkB250IJTefl5BOLXCCXqVnkh6BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547859; c=relaxed/simple;
	bh=41Tk0gUeuWPvAJyRQa+pWjoOSa13hAmf/+Yk5qnL/wQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RErEOIJg/3tUXVGkWjRCKbm79gKfaTmmKGCLI6KFAJiEfqfrELLOgTQHyzAg3zYn3M40BI7OATXFMQB1/I8wxfDnS2HQs/BomG5Qx2KqzL3Ou7cKNwavWCKmZSEkEVZjyMlDKs7syZfMZhd5CVYwGRczsVF9+83hXaFu8nKl70c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ojUat8+/; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mai1xaPqjBL+yFgjOpu5vtxEjdZHuOmbQz9X3wQqfqmQas+PdT2IsUn1psBSMc+ytnGKSSd5fa2DLlbchQG93LKobQQqe9kELUAwi2yd9Qi5MKtCvCiJpbdFvvGB5ebLfTptan+cmOX+r9ouONT1oJJVt6mJW1ww2/PBL2XvOXA4NbYTBwWd4PBmjzy1poPkt2q3WI9Qfir5NKzmTVlSZi9xNDU1uJNZehY+V1aAq+VD7mxAvrm6kAhX8S3UknxMPenrhwaguQWUP8DUqr6qlxkS/TMBsbGUBs5OP1qXqUUQg1qssY0P/3yf8bH27wZwxG3nPw+QdrBiMElROLBy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+UBH12pjfNxwqS0RoBvyUFQwL6rKVWN5GA14EfBt6A=;
 b=GOWwzl5Ok5zcAjbadKi7dKS55tWhhCjvnAPFQZeAMh86cHApReaRMrEFgJUo6l7CvFOb2xVWHRpzOCcqotEDlddPt7bUV7lJhCYZimEO5lkzg5uuWlPizIOg61iY8fJeX7g8vSi0+lX6mG/2ZZVM6DI0U9xlakYqw1jkHlGZL2JfOlJ6YZzchQeVCbSzEoa/1tpEJtLqhxXjV2bJavLVq2oP7jl2kYwsOS32oMBOT3jnw913e+noNm11DwiCapxli40N0WN2ZsEymqXUu7FKCv3y8zjUNws5IxQfxG/NY1HCyiRLs/mDv1HCsks602v4oeIGablnDhQ8VKWxc/uw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+UBH12pjfNxwqS0RoBvyUFQwL6rKVWN5GA14EfBt6A=;
 b=ojUat8+/ZCYrvbUYc9NuHQqWPs37Yr9/SYGoBByCXJ0ZZKfhdNMRRfElPnW0ozJSvhrGCzY7GiPOnmk+z6MYhRlYoLvdXa7tG6IMzFYPfVezU1nOOouBm8oBdsW1ymQFKkqcLj8B+k/4Diazxr5b1aI1YRL6GJvqF7P0lqgyeoo=
Received: from BL1PR13CA0371.namprd13.prod.outlook.com (2603:10b6:208:2c0::16)
 by IA3PR10MB8185.namprd10.prod.outlook.com (2603:10b6:208:509::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 11:17:33 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::3f) by BL1PR13CA0371.outlook.office365.com
 (2603:10b6:208:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Thu,
 30 Apr 2026 11:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 11:17:33 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 06:17:32 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 06:17:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 06:17:32 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UBHWRr1243123;
	Thu, 30 Apr 2026 06:17:32 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 63UBHVPK031193;
	Thu, 30 Apr 2026 06:17:31 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <haokexin@gmail.com>,
	<jacob.e.keller@intel.com>, <horms@kernel.org>, <m-malladi@ti.com>,
	<arnd@arndb.de>, <parvathi@couthit.com>, <afd@ti.com>,
	<basharath@couthit.com>, <vladimir.oltean@nxp.com>, <rogerq@kernel.org>,
	<danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v5 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Thu, 30 Apr 2026 16:47:22 +0530
Message-ID: <20260430111723.497113-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111723.497113-1-m-malladi@ti.com>
References: <20260430111723.497113-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA3PR10MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5b3230-d09a-48f8-60c6-08dea6aa1353
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|921020|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	puNJpbrgKqPfjtfO11K2q0t5U34jh0ZM2PAPIyljHmAiN1oXBSPwSK5xp03hadN3kb37ch09JcjOvGdGoyVaPv2oCHW5dBSyiZusOVUa5LPAa8072IHpd5gO1+eHoi65KuhKCxpF0fxkSugoo875qxifBf9WZzGX1hP56GTEkpEExWs9H9mAZem15Zw6M14LYnF3eQFTwrx4LD3L4bbhAW9UQH8kQXbDDrpv15wlvNiJtII+gcPKkFfA4sw1w1lmRqvimHrvLDUgfs5p1YARPA6pOnZ/LMW5BTEl4zGNaSk1S+vs/4TxTSpEZEfBmmVLsUUaZvxyZN15geic1hY6iIgiquZDpx7ks/sb7f9a0YJJD0EauSX1YVjrK7KpvuXe0a4QQT06I+9UPnbtXs0JOX9eiAAeH4YnZfNuew76Gc8nUlkJtHUa4NSaWt5CEd72CeCIj1sAoAsi1qNlgHbM4KabJJCxjfkT/A46qjBWFe40ljpQ4QoZmkYvL6JFMCNWIqAosQum+9qBChUg7YoTrZeVxEpoJVR3Adj4qUHsyI2YHs19igVWlKxKEj+dMzw7LqJqFmiDH8QriK0xHbEFIXauD/LNqXcGVK1Y3mwPwl48M0bADBs5HG+atN9DNXv1M625kG2l2weDdOH6cqn/AyhWDjiPySp8w0+LuBsThCBB4TAdVNDHk4yKnAUwfubJJZfokOXWVPNSuLUKqUE5BYRQoUJMMErnhDf4xtL17WkouDB+flFJPmfHrvhWvaFomLvNlkn3gdOKvjlXJ2sYvQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(921020)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cq/ehRqEudpsYr0vomHSuTxJ3eWk+Ueg3g/D6Dz9lVXp/qGgjv5JwJp08HXml0W20YUXSEFBBWsE2mRkvs7+LtB782pfZOhoI2U0vjOGJnWNU2ReGi3TcRiu2VmlvDKn/aNEHpJ9MNTZLeTDeAW8qmhWXrhVUIUkDcg75AeKjj5qWW4yGXkTGweEGLsoqyQ4EfJnLG+io40lGvnGXHtabVsVsNrKL3IfRueWBLtpieYNMYdml9PTaUQp2Np9sNKahY8nU9NMPMsdMi0RCFGIQm3fhDvcMrKTpCbLgooHd97SPGoLjdXK76kVnIYflnwsm0jVnOoP7XRpexebDaH15aXye0Hz1YeZjErAnF8Pkm9YESD/WvUN3hxWlqgDsUjjy0FMM2bRIWw14a/3N7Hhn68TkkHjbqUXOev8N6VmPiJFaRiQ7UgAMS5E+l93I7oC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:17:33.0916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5b3230-d09a-48f8-60c6-08dea6aa1353
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8185
X-Rspamd-Queue-Id: 897554A2371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,intel.com,kernel.org,ti.com,arndb.de,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282798-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,ti.com:mid,ti.com:email,ti.com:dkim,ti.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]

From: MD Danish Anwar <danishanwar@ti.com>

Introduce QoS infrastructure for Frame Preemption (FPE) support in
the ICSSG Ethernet driver.

prueth_qos_iet tracks FPE enable/active state and verify state machine
status via firmware-reported enum icssg_ietfpe_verify_states.
icssg_config_ietfpe() configures IET FPE in firmware, triggers
verify state machine based on ethtool MAC Merge parameters.
Polls firmware verify status up to 3 times with verify_time_ms intervals
and driver handles timeout by logging error and returning.

For MQPRIO qdisc support all queues are express by default later
gets override by user-provided preemptible_tcs bitmask via tc qdisc mask
Preempt mask configuration: Maps traffic classes to queue express/preemptible
state and applied only when FPE is active (Tx enabled)

Verify state machine re-triggers on link up/down events based on
fpe_enabled and fpe_active flags, and for memory protection, fpe_lock
serializes all FPE state mutations, preventing races between ethtool
config, qdisc setup, and link events

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

changes from v4(v5-v4):
- preemptible TCs are committed to hardware only when FPE is active
- Removed workqueue implementation with direct call to configure FPE
- Changed MAC verification logic to poll at verify_time_ms intervals
  instead of 5 seconds.
- Used mutex_lock whenever necessary to ensure proper synchronization
All the above changes are addressed as part of Vladimir Oltean <vladimir.oltean@nxp.com>
comments for this patch

 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   7 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 232 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  68 ++++++
 6 files changed, 311 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index f4276c9a77620..d19bcd25c9d07 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -46,6 +46,7 @@ icssg-y := icssg/icssg_common.o \
 	   icssg/icssg_config.o \
 	   icssg/icssg_mii_cfg.o \
 	   icssg/icssg_stats.o \
-	   icssg/icssg_ethtool.o
+	   icssg/icssg_ethtool.o \
+	   icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae2..1ac202f855ed4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b4..7657dc1015f0a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
+
+		icssg_qos_link_state_update(ndev);
 	}
 
 	if (emac->link) {
@@ -1652,6 +1654,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
+	icssg_qos_init(ndev);
+
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
 				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
@@ -2461,6 +2466,7 @@ static int prueth_probe(struct platform_device *pdev)
 		}
 		unregister_netdev(prueth->registered_netdevs[i]);
 		disable_work_sync(&prueth->emac[i]->rx_mode_work);
+		mutex_destroy(&prueth->emac[i]->qos.iet.fpe_lock);
 	}
 
 netdev_exit:
@@ -2521,6 +2527,7 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth->emac[i]->ndev->phydev = NULL;
 		unregister_netdev(prueth->registered_netdevs[i]);
 		disable_work_sync(&prueth->emac[i]->rx_mode_work);
+		mutex_destroy(&prueth->emac[i]->qos.iet.fpe_lock);
 	}
 
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b786..85f7017d2c8e7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,6 +44,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -254,6 +255,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 0000000000000..fc4b0ebc7d683
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
+	u8 preemptible_tcs = p_mqprio->preemptible_tcs;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int prempt_mask = 0, i;
+	u8 tc;
+
+	/* The preemptible traffic classes should only be committed to hardware
+	 * once TX is active.
+	 */
+	if (!iet->fpe_active) {
+		netdev_dbg(emac->ndev, "FPE not active, skipping preempt mask config\n");
+		return;
+	}
+
+	/* Configure the queues based on the preemptible tc map set by the user */
+	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
+		/* check if the tc is preemptive or not */
+		if (preemptible_tcs & BIT(tc)) {
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				/* Set all the queues in this tc as preemptive queues */
+				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask &= ~BIT(i);
+			}
+		} else {
+			/* Set all the queues in this tc as express queues */
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask |= BIT(i);
+			}
+		}
+		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
+	}
+	writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+}
+
+static int icssg_iet_verify_wait(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int try = 3;
+
+	do {
+		msleep(iet->verify_time_ms);
+		iet->verify_status = readb(config + PRE_EMPTION_VERIFY_STATUS);
+		if (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED)
+			return 0;
+	} while (--try > 0);
+
+	netdev_err(emac->ndev, "MAC Verify timeout\n");
+	return -ETIMEDOUT;
+}
+
+/* Direct synchronous configuration of IET FPE.
+ * Caller must hold iet->fpe_lock.
+ */
+void icssg_config_ietfpe(struct prueth_emac *emac, bool enable)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+	u8 val;
+
+	/* return early if FPE is not active and need not be enabled */
+	if (!iet->fpe_enabled && !iet->fpe_active)
+		return;
+
+	if (!netif_running(emac->ndev)) {
+		netdev_dbg(emac->ndev, "cannot change IET/FPE state when interface is down\n");
+		return;
+	}
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	} else {
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(emac->ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+		return;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = icssg_iet_verify_wait(emac);
+		if (ret) {
+			netdev_err(emac->ndev, "MAC Verification failed with timeout\n");
+			return;
+		}
+	} else if (enable) {
+		/* Give firmware some time to update PRE_EMPTION_ACTIVE_TX state */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(emac->ndev,
+				   "Firmware fails to activate IET/FPE\n");
+			return;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	icssg_iet_set_preempt_mask(emac);
+	netdev_err(emac->ndev, "IET FPE %s successfully\n",
+		  str_enable_disable(iet->fpe_active));
+}
+EXPORT_SYMBOL_GPL(icssg_config_ietfpe);
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	iet->emac = emac;
+	mutex_init(&iet->fpe_lock);
+}
+
+static void icssg_iet_change_preemptible_tcs(struct prueth_emac *emac)
+{
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	mutex_lock(&iet->fpe_lock);
+	icssg_config_ietfpe(emac, iet->fpe_enabled);
+	mutex_unlock(&iet->fpe_lock);
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct prueth_qos_mqprio *p_mqprio;
+	u8 num_tc = mqprio->qopt.num_tc;
+	int tc, offset, count;
+
+	p_mqprio = &emac->qos.mqprio;
+
+	if (!num_tc) {
+		netdev_reset_tc(ndev);
+		p_mqprio->preemptible_tcs = 0;
+		p_mqprio->mqprio.qopt.num_tc = 0;
+		goto reset_tcs;
+	}
+
+	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
+	p_mqprio->preemptible_tcs = mqprio->preemptible_tcs;
+	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
+
+	for (tc = 0; tc < num_tc; tc++) {
+		count = qopt->count[tc];
+		offset = qopt->offset[tc];
+		netdev_set_tc_queue(ndev, tc, count, offset);
+	}
+
+reset_tcs:
+	icssg_iet_change_preemptible_tcs(emac);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icssg_qos_init);
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_state_update(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	icssg_iet_change_preemptible_tcs(emac);
+}
+EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 0000000000000..083f248c557de
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+/**
+ * enum icssg_ietfpe_verify_states - status of MAC Merge Verify returned by firmware
+ * @ICSSG_IETFPE_STATE_UNKNOWN:
+ *	verification status is unknown
+ * @ICSSG_IETFPE_STATE_INITIAL:
+ *	Firmware returns this if verify state diagram is idle
+ * @ICSSG_IETFPE_STATE_VERIFYING:
+ *	Firmware returns this if verification is ongoing
+ * @ICSSG_IETFPE_STATE_SUCCEEDED:
+ *	Firmware returns this if verify state diagram completes verification
+ * @ICSSG_IETFPE_STATE_FAILED:
+ *	Firmware returns this if verify state diagram fails during verification
+ * @ICSSG_IETFPE_STATE_DISABLED:
+ *	verification is disabled by the driver
+ */
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt_offload mqprio;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos_iet {
+	struct prueth_emac *emac;
+
+	/* Configuration state - protected by fpe_lock */
+	bool fpe_enabled;
+	bool mac_verify_configure;
+	u32 tx_min_frag_size;
+	u32 verify_time_ms;
+
+	/* Runtime state - protected by fpe_lock */
+	bool fpe_active;
+	enum icssg_ietfpe_verify_states verify_status;
+
+	/* Synchronization: single mutex protects all FPE operations */
+	struct mutex fpe_lock;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_state_update(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+void icssg_config_ietfpe(struct prueth_emac *emac, bool enable);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


