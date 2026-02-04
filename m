Return-Path: <netdev+bounces-256715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M3sDZFRg2kalQMAu9opvQ
	(envelope-from <netdev+bounces-256715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF80E6CB1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAE30301EF06
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547F40F8D5;
	Wed,  4 Feb 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QkG0doqn"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580F40F8CF;
	Wed,  4 Feb 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213689; cv=fail; b=o+palJYWtl0Q5NG+YQRJMCgp2uCr33IyEpu8MjTJNx8+t/3qFeaoE87h3WMWHLhCH5+WJXR+Ya6ZOFRhfXO1asJ88XcEjWn3oy8HU98QuOB/70WXV2jspHTRz0dQ3tHyNKIh5Z3jw9FcHxMqfuxy1ZbRvwpwA8UYWNIYsAO7f6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213689; c=relaxed/simple;
	bh=VcUz0/mj1e+47DRZHD/IOZJdz54K7+mf76gQIp/951I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVYPE1lE6RwJ//FpsZUknKw3/oCvivhalZ7Ls30yWOobetY4KVsViUGQtlYkdz0TtrRLSx2D2WhP7rP406swBPY7HuXkhIh54xYfuGzcow3QuOoQKFBGfVfrNhC4Ld6s+DMAjyrIcktWMqLKZexNztMsufNxqS1SNtflmQLCGeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QkG0doqn; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTiPvCS1O/F9NZuXpCf/4Gvgf5nrFHhOOIpQFsWPqPbYzDV+UlkFiavjR7hMfVDjLG4D7VRQiaEyyDD5lNwUyverLfqqNvEzvHY/RkWNbn3/NDD3CqxldHvx+TGZviEw+We2ozbLXllaXz5GYl2j0QSCu/7H5jebbw/9q3pSPXUvxYRbCaEP/feJX2FQ9GFfZUwb+XtWeNQ5LgO42Ghazm3FmWBtYHyV1xA1l+eGH4526wkcTSh9humM6AIuPf11btF6InDZirvfHGZFVKMMZl5K8HLukfRpVqmxnBJy8TSG17zIkcKD4bVUgpLWolZWj5K2h3qpe1gth30g3IsGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78mnHSMNUOj87AamlUjI14MWy0hF3CqW20wJvk3a4gc=;
 b=s1LjmoW6qw/sLjFF6gqhLoZPKR2NQ08Q6Vo4Icd88Dhc402s5h1mtipYPzmCxw5yV+Cbd2N8rgHSpa+xvN1H09343WD7i+352fuLWFCaLRpZYwepGJ2moTIZ6dU74zemcdE8CekUDrah6+HWnNlbM+fch05AZAzQPAQHkHtQU5tY9G5C82iweJNIdROUmBOhdQeW5G1CwuMrCCcDCb8SsC/GRR8rC/enCV/x5gdjRxbRxxOlFgeGa4qVyb7y0gpCuBIlpnbShgHFSApQOtAc6xsblp+dsRlQBkNsxApduapSc7By6WMxSyd+E2ZD3C/zw2B5UraHWQ5w/gugM4oFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78mnHSMNUOj87AamlUjI14MWy0hF3CqW20wJvk3a4gc=;
 b=QkG0doqntUKC7cSwjG75STUyhvp6gv2vLJupqj3NTO9Ob+qWuCVETptx4HBl0f1Wf6GhXDowGJ5fA90MhWwT3cYYgwrFAzzV24bA3UAdF/Dum3OqUrDwSj+SUB7vDC6nv6MCev3hIJp13E/D9kh/ttTSxslHww5ovltSMGZ1/QQ=
Received: from CH0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:33::11)
 by BN0PR10MB4839.namprd10.prod.outlook.com (2603:10b6:408:126::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 14:01:25 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::11) by CH0PR08CA0006.outlook.office365.com
 (2603:10b6:610:33::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Wed,
 4 Feb 2026 14:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 14:01:23 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 08:00:55 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 08:00:55 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 08:00:55 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614E0t6Q1226566;
	Wed, 4 Feb 2026 08:00:55 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 614E0sQ3002190;
	Wed, 4 Feb 2026 08:00:54 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <parvathi@couthit.com>, <afd@ti.com>, <m-malladi@ti.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v2 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Wed, 4 Feb 2026 19:30:44 +0530
Message-ID: <20260204140044.4086725-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204140044.4086725-1-m-malladi@ti.com>
References: <20260204140044.4086725-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BN0PR10MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d006e0-fab4-46ae-250a-08de63f5e199
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afkAgahxq2ZVxBDFtxmDHbVi6A+VimRRTjYWKHzj/ju/N5fanaV1fvhiBq0U?=
 =?us-ascii?Q?RJz5AVZup9EtmBaoHYEZR6P8ehvp8M/l3ubp1dA22Q5WLSWldoYJoHanWsnn?=
 =?us-ascii?Q?jluu11qdPXCdasNu7a7zLRUd3gynTL31/V0UCoRF1uvg78Rf6/nHwmdwyZ/m?=
 =?us-ascii?Q?lrsPRff4SZxnrV786cTfsxZ3V9uH1ovb8KxqclPQrko9FK/Ha5jSGNmsR3KT?=
 =?us-ascii?Q?9w5NDdr0iOo6IeAL2ehHVAbZnnDkuocNF8sQyy38omzi7sjSejyl3f3/6++l?=
 =?us-ascii?Q?7aOo+3N1a/cr499mF5KqOd3faKTULflwUViNJxv+EZ2dAGPktFmLR0fJ+FWe?=
 =?us-ascii?Q?xCKujjFjfKRTtKpcl0iTLTakBuotrBtHYXvFQrSD1UDwP8iGhoEPM+acuTJ+?=
 =?us-ascii?Q?D8BlbWPUAJ6D+1zc3s5Ama9s3Gry6YJ2JXba9Vahwu0ZED1M2utim2Up3kG9?=
 =?us-ascii?Q?gAUHFmvwVLyjwM3/r5+JIKPfuqgHAxlJ9SaUqp5N0TbPS20+pmNP+DmZS+bi?=
 =?us-ascii?Q?TKy2Ojgk9VIMfzhnX3Atgen8xt3kKq+3u7i2zfgYiFN8BsaYMI76LCNMXJMo?=
 =?us-ascii?Q?rgsPHou3JtpBBjD4Sfpk0XDlQl73hbobUOtVbHoJkC37lN9Ob0rJE0O0zRMK?=
 =?us-ascii?Q?1gsHVQ2y0rxbBsscaTkfphGjl3RbYULttd1dJbvb3RIUVhcd5N76LfLcE3hB?=
 =?us-ascii?Q?hiaCnWHaGuvE+iycB3/X15P/k/uCWgSPSl09iD7583gflsZ6hn1D25PcGUa9?=
 =?us-ascii?Q?nLAjN1oc3aGgtRe3uMOiUQFQ7gu9SCYdz1L7ED8pZgb0cMIauuU93DhF/6IL?=
 =?us-ascii?Q?s9vNkKFUWNv7kDO7f8mw+ZZjCydnt6N9Q5Hw6uNzjuaoRfMtMsJbAmtGjGBR?=
 =?us-ascii?Q?996C7grvVoVpB/R/fWkRMnw3bDSe3YXtBIclKca241NaGQeuKUIqxf6J+vcV?=
 =?us-ascii?Q?y6WO8N5M7+Y/zGXRGqtZOEoBY5MAJe3+eu+ML5Hm5LqDV24XVmt4/PgdojEf?=
 =?us-ascii?Q?HDkkqTOW3yMiXNWPOB3jLZNU+Yww3Gb3BHw4KsXGcnrjUP027MIa8Djl5yTX?=
 =?us-ascii?Q?GoYYcvWTUxPKec0g2ctwIXw/TMweogOfrcy16r6u0OupLoiuCPsid5gBW41/?=
 =?us-ascii?Q?yojV2fz2amU+aFChoCDmkpxccKlSBp+i95Y8/g6bl8mdfvWcs+n9PQIvD6Mi?=
 =?us-ascii?Q?uuLP49/bYCf0BA0WFoGop2YrKXc9aEMHxa4vxXVht9QQ1shxKVyxqaouZSYU?=
 =?us-ascii?Q?1o1yGNtJ3xyFXLLyM0qNrqGjWq7EP3Cw6xL3BwGDnGnIQ7TaC+Ki+R4JbeTA?=
 =?us-ascii?Q?zbbQXlEV5KcQxAM4YSe6fsF/JSlBMyGfBay2xRALXskUc4Qls1OMXAcHCCPe?=
 =?us-ascii?Q?NfEXF8b3GTZsq+pvWvuHbvQYF5e9XDyboFB3Zcl5uWcfLWhqqa8u3ZJpCCyK?=
 =?us-ascii?Q?AZhR5k6o/GAJify+2jmyOjzVKjMsrG7+fMHaVI1zxK9PvKqevYSci1fsIJe1?=
 =?us-ascii?Q?IZqTyFJpBRKfkOLfPz1k9hxfduEdjuLR1Urcqw6rS2rrfBrtvunfOZkwu18E?=
 =?us-ascii?Q?+/UlKIXR51nMO5krGpMlTpBWVw3F4H4WbQd0eApf6Ffm3D6faRUnVGXpK/Mc?=
 =?us-ascii?Q?EC5XMEswIy9tvNd37IIdvURk5MsSZdXgs1SaYVHl7FVZIRNvAm3gYnXw0oGo?=
 =?us-ascii?Q?WGnkyNfuoRGBs+XtiXVGNLSkp+8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JDyWgd7ZVzAJbunT9NwLfZ6meugxToLWSiGPITiz01jKlUDDhbfotKkhQWAvssHvEJu3h7tif3J1+Qeol9iUAg8CoKU75PRNz4M/G/sjcP3FvRXwFdy6nVv0qxKUPncDEz5yZ6grWCKF63QzXQvsENYndRvI4c/Ll0ZIcd7Ii9gkCzu93udg/3wBN7b14H/Jtn2Egh45d+XQBIKjM43ZYVylWwR2zowOj7dysE8Vi180kfmUQBDWQ4DfeYgb/o1suaJAwZ6pMI36IA6FAF+qVmUHR3OqVy25rPf9UriHViOLDT14MsPZQk+ZM15SoTdSkqepHv1ePUOZ6DpnBSkdnPmCvCkDRAOCE8ZhZx4v8t7Z6zv0DJft5Ewft8roEO678j2J24Ex5erd8/y05WFaCT9aafFPagoJSsmT5fjtQDEa80Gmfjb9UV5pEErlRYv8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:01:23.5325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d006e0-fab4-46ae-250a-08de63f5e199
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4839
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256715-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: DCF80E6CB1
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

Add driver support for viewing / changing the MAC Merge sublayer
parameters and dump the Mac Merge stats via ethtool ops: .set_mm(),
.get_mm() and .get_mm_stats().

The minimum size of non-final mPacket fragments supported by the firmware
without leading errors is 64 Bytes (in octets). Add a check to ensure
user passed tx_min_frag_size argument via ethtool, honors this .
Add pa stats registers to check statistics for preemption, which can be
dumped using ethtool ops.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v2-v1:
- Following changes have been done as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>
* Add sanity check to ensure valid min_frag_size is requested by the user.
* Add comments wherever applicable w.r.t min_frag_size.
* Make it uniform to return all valures from the driver for .get_mm()
* Use ETHTOOL_MM_MAX_VERIFY_TIME_MS macro for 128
* Use NL_SET_ERR_MSG_MOD() wherever applicable
* Re-schedule the iet work thread whenever there .set_mm() get called
based on fpe_enabled flag.

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 86 ++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  3 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.h     | 20 +++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  1 -
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  5 ++
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |  5 ++
 6 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23a..3c4ff154f6d1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 
 static void emac_get_drvinfo(struct net_device *ndev,
 			     struct ethtool_drvinfo *info)
@@ -294,6 +293,88 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	state->tx_enabled = iet->fpe_enabled;
+	state->pmac_enabled = true;
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	/* 64Bytes is the minimum fragment size supported
+	 * by the firmware. <64B leads to min frame errors
+	 */
+	state->rx_min_frag_size = 64;
+	state->tx_active = iet->fpe_active;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+
+	switch (iet->verify_status) {
+	case ICSSG_IETFPE_STATE_DISABLED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+		break;
+	case ICSSG_IETFPE_STATE_SUCCEEDED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	case ICSSG_IETFPE_STATE_FAILED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		break;
+	default:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+		break;
+	}
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int err;
+
+	if (!cfg->pmac_enabled)
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+
+	err = icssg_qos_frag_size_min_to_add(cfg->tx_min_frag_size, extack);
+	if (err)
+		return err;
+
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+
+	/* Re-trigger the state machine to incorporate the updated configuration */
+	if (iet->fpe_enabled)
+		atomic_set(&iet->enable_fpe_config, 1);
+	else
+		atomic_set(&iet->enable_fpe_config, 0);
+
+	schedule_work(&iet->fpe_config_task);
+
+	return 0;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +398,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 7a586038adf8..1309af6aab78 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -45,6 +45,7 @@
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
 #include "icssg_qos.h"
+#include "icssg_stats.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -58,7 +59,7 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
 #define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
index 8aa79b68ad54..b18a93f9181a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_qos.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -55,4 +55,24 @@ void icssg_qos_link_up(struct net_device *ndev);
 void icssg_qos_link_down(struct net_device *ndev);
 int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data);
+static inline int icssg_qos_frag_size_min_to_add(u32 min_frag_size,
+						 struct netlink_ext_ack *extack)
+{
+	/* The minimum size of the non-final mPacket supported
+	 * by the firmware is 64B and multiples of 64B.
+	 */
+	if (min_frag_size < 64) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be at least 64 bytes");
+		return -EINVAL;
+	}
+
+	if (min_frag_size % (ETH_ZLEN + ETH_FCS_LEN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx_min_frag_size must be a multiple of 64 bytes");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 #endif /* __NET_TI_ICSSG_QOS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155c..d27e1c48976f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -6,7 +6,6 @@
  */
 
 #include "icssg_prueth.h"
-#include "icssg_stats.h"
 #include <linux/regmap.h>
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67..f35ae1b4f846 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -189,6 +189,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
 	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
 	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
 	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
 	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ec..855fd4ed0b3f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0


