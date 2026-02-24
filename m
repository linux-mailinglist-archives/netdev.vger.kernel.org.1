Return-Path: <netdev+bounces-260510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLmRMmWenWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:49:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE7187362
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3D8306115A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E454E39A7E9;
	Tue, 24 Feb 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vPQ+4wXT"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04237FF43;
	Tue, 24 Feb 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937291; cv=fail; b=CEdO2TSXoxT5sTNCsItV+QqIKoJYK/MrovX3eJW8RKnUVTa/c7poBUXL1HEPcviTsXm8rWxCMPuQ7NSQW2koILsGXARVNazoYaaKNemo1j4lcYhV0Ae2omet1//NLvhlgqLSOgdh45Nr7CXmDMzC6+6Rrj2BWZCLg/+MxioxhfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937291; c=relaxed/simple;
	bh=12Xy9+XSkPXDGYfgVNLJJn4mmRL9zHn4YYLaEztVurQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aaD+N4Y7Jlvi3W5fkB33UGVwyKXJjOBOc/9Q+sSGRu+mGtKa8z+UeyQsewK+PWxC/iIBYradzt7Ykr/4M6LoesAgdNp9vBNBd3NuuEsJ+ttDbxnTrKMUSuA4Xc86K8nAASHb/ErgVohQhJr0hpnC7I5Q3uW+/FnrdrCZ9LYFqTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vPQ+4wXT; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCjvWz/btvQdfdSvAK2H1X0G0wGezMq/RKwpymYV1hse2Cw3Vr+04QUKyt6i4sEpStROdTOAYUTU+Vwci9UttftIh5wkKC2DpC7AA0gmumjaLGkcab4nDOo94zQVmM57+e71Tk5asyRpL1C6Rn1+rXSsOtVeIVpnVPW9+9HF471Lhxb4c17jXDCod/+a4X34IAteYj+qZREqHuPHdP0i5+d8ILwUfxHFEt9tnyc8Yd1F1QcZR9LOpN36hFhNhpRH90WZdxwBTUPPNSgkg+hSFkYZgc3u1YkNpdFRH7mxXdrLa3ie8ePhIK5DAckvtmBl7NSVx4uhIxyL+AzGwaf8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA4IRi0Df62BomVkKrmJ7Km3tkoHgv/+pl0VoYzl0pQ=;
 b=rckpEEPxzokHHoxpkmTXDoJtcI61P/aVSPWxeprol22f3WA7pFPXmcgLKZUoiL8BMOUneMmpRP0JOZGQKwgMetmyI84C1Zq/Cjye5PO/9IBpNrKICnKX7ueE+3Z2hVV332l/GmbqNWKWd6es9um6BdvxKIO7Az/4J3Kr+4XjuysDDQrO6ojda4kDLTrJRK4vW1fDzSz23JXYTZy8VyX382Mr/AxE1ruIeqEZL8uhSLoZr50T++7HA4VOE2L0A+eWCvQmsHyAO6XcuPMrK8oiZf5/MNi+w2FEuk/Gy01o27A+Rx3UXDG25V6lj7XBYwDfhItizq6WgaBJOMA9DRoJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA4IRi0Df62BomVkKrmJ7Km3tkoHgv/+pl0VoYzl0pQ=;
 b=vPQ+4wXTnwScIPstgC/vgsRAiOV4Q0MTeYUeZOFZZ5WbvX3x9o3ZuV5XXHJyysqSaO8lKCFDyWlZ9f4y3+loHROlYlXIbbunOoYH/hWpHrzltWttwS5FZbCsm9/Tr0jGwR756sclE53U7Hy7op4hnbW7moSITuDEiLkMcjT/VbU=
Received: from BL1PR13CA0396.namprd13.prod.outlook.com (2603:10b6:208:2c2::11)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 12:48:07 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::35) by BL1PR13CA0396.outlook.office365.com
 (2603:10b6:208:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 12:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:48:07 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:48:07 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:48:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:48:06 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OCm6jM2255786;
	Tue, 24 Feb 2026 06:48:06 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61OCm59s020521;
	Tue, 24 Feb 2026 06:48:06 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <haokexin@gmail.com>, <vadim.fedorenko@linux.dev>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <horms@kernel.org>,
	<basharath@couthit.com>, <parvathi@couthit.com>, <afd@ti.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v4 0/2] Add Frame Preemption MAC Merge support for ICSSG
Date: Tue, 24 Feb 2026 18:18:01 +0530
Message-ID: <20260224124803.3634808-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f165ca5-da0d-42e2-b46b-08de73a2f5b8
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNr7BXRZQzOs/aRCjY6NcmDguWAlRpeygxTlqSg3ISRu6x4Z8U4t0UQfL8ol?=
 =?us-ascii?Q?O3g5Qu8FmP4MwRwhKFvOeuOz8MWHE8ZVe8ryOTRflfSFEE9s/9GI21sNbrVd?=
 =?us-ascii?Q?klD7O8uU3Y0cIY/SapZTmWI/T6nwAEuAsyYSAj1OuAl5s1kFQX7u6hn/SYJ4?=
 =?us-ascii?Q?uxIXcLtM+T+XxrF5ui/BpajS7h/FFw+YP6NJ7BW8Z1qowk6O4+CQUknRu1dK?=
 =?us-ascii?Q?B1xvj5dYDvb3lv8Sor4lguSfJJCWJfi7yKnQQ5uZqk6FrCYq8AUh3v3nTXD2?=
 =?us-ascii?Q?gBhKfV4mF45+NmQo2G+wwwNc8ihGULbtko2G9QzoiYSylSQT0i6WixcoiZ6Z?=
 =?us-ascii?Q?JXX3jVYuKHf9JxbycegWCQjYqJ2yt63P4/wZGySLNU9jfIQSYAwkPF9frgxO?=
 =?us-ascii?Q?v9l4cAyf8FhVe+Swwyd3M9YPCj6+qCGizUZRsSxj0wsnA2Hw8+QXE8ki6pCQ?=
 =?us-ascii?Q?0Z+Qu7yjWwe8Y5fy3G+d5rWDzwT3dUsKPYhKOP49TLGViX8gChDnxvIyqFhu?=
 =?us-ascii?Q?CPNQLCmXEHTAf+jcYyXYry7jUdAuJlOhA081IAq6FHan1+szdtifqnG+AN94?=
 =?us-ascii?Q?eskwn1rKH2UQFiufep7BACmNoaUYGbg9WMzUzLi9Tvmh2rfgi7u6q/Fhv8hN?=
 =?us-ascii?Q?+iPkhTJHq4dthUDcryvsO8nBWqnbqSRtgQczeQvDkDgn3qh+fiC1dHleKkpm?=
 =?us-ascii?Q?sx6lKX2s08+qrt/vI+sNl40/g7j6LWpQmU/RmqQjtTTipAp+EglUUjHGbSM8?=
 =?us-ascii?Q?7Y9ShO6nHFYO6d5FQC0Bs8zSuvpfJbndfnOIUAaAggmseBYnxCFoHYPQi4HV?=
 =?us-ascii?Q?QL4O6v7gbsukiATPBi+V9y58CHbQ+YAA2NBppPJ9Inrj9R0DXfoYflG+JBE4?=
 =?us-ascii?Q?K/HQOuFPgPsJWR2SMZmxRfp1vmjxHJr/HkT/pHYE5j+ltrKk+qEMG8QS4pjB?=
 =?us-ascii?Q?2XY7UUREgFLU8tFsUMIKsKhwjYSRZsH2ThAk1bWtKXv1EnKshK1aRl/gYZ4X?=
 =?us-ascii?Q?41ys92X/jlMfo93WZjfUo5Up4QAngVyOq4iKY8mpx3zsqbNf2rigHZaNgTmd?=
 =?us-ascii?Q?cofxIWrF+pfewrygeTZ4aSspS+TDQNoQDIhpNVlMdbAKTm//nAJhYfHQRhUZ?=
 =?us-ascii?Q?/QnfAZ1dUs814B5hTcSzCm4LaY+gqBJWfWVs6IkT16irV3VHH6QoY5169LNc?=
 =?us-ascii?Q?owAlvBDfVUCSj9lADxv2IMpeMbtrGsFDu0sitQqH+3COmU0OGKdwiv4TeZY9?=
 =?us-ascii?Q?5u2oOY7HnjaHId9B3aIK5Q9aqqz//j7eU1gJ6ypjudYhw1KsRiIjW77mAjxq?=
 =?us-ascii?Q?7ACSLy2VRUTy6XJ2zlOYdDMxJuZr3TrnsbIIz6psp/b3Cj6c9Uq4sD5oiRuf?=
 =?us-ascii?Q?mnExnlLbk0IJlhCsyU/MuziNPeGxVAuhD8tzP97/eSuIKTUshk/ThOFXTMBo?=
 =?us-ascii?Q?siy8hzv/8tcnlXI5oh3ni1nrKqWv8doKVGr83A6jGHe1BYfG4GVlGkCnRwUW?=
 =?us-ascii?Q?6BK6H4aYTCXCJ3zWcvbsN7tf0P595P2X7jz0GpMIiAtN6dGmXMHtc4Wm87Fg?=
 =?us-ascii?Q?f2nCztz8kxCW4gPgSqj6+OsGf9KYWhP+zgvPK6oqUqFpHzbS6JnT5uhsjo45?=
 =?us-ascii?Q?KtBs9mRGSwLjMUgmuvuX32c7JT9pXl8UwHMtTYgqWSyzTXVwHnfYnl0C9qg0?=
 =?us-ascii?Q?jBxo82BWukqiPUEGqZ3069x14qY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NTOho7GLZOa/00HHpVhA6PPlilKnfo7JoiscwOWeij2kQeSwXqJHPUhFRx/GNdbwR7RnnN1O8cPDe/TBRRsfaRD+4EWfgwP9N1KJhEaH3FoZPDf+arTgU1n21eMjzdRY7XvxA9tsZXOetmZ0JIZ3oB4k1JTNjnNc0nEBDvL6tKHzvukCEv1sZKNUJW8NoBGyXMOZs7RlBoVYr09XT7+tPzrc3IAdyPJ+lEjDoHpvBWSbcAXKBmgzIW4fmxL6bk5QyF+dB4cujvVCVLejljVHM1YLvqImKYYujfNtbG3CZ4RlKQwZaYrD+7/vcEjF25bQa7TOABjbkXcOxhMFo9bn+FB+hNcnUyFZ26Wj7pVIu9CgYZKjuvdEsOO6QjLb3qvaHoXtwilybWymM3AIrupttfQw/w9IBvjit/kmEyGU5itPJp0kqKNOptPUuz7FpRwu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:48:07.6398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f165ca5-da0d-42e2-b46b-08de73a2f5b8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,intel.com,ti.com,kernel.org,couthit.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260510-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 47EE7187362
X-Rspamd-Action: no action

This patch series adds QoS support to the ICSSG PRUETH driver.
The first patch implements mqprio qdisc handling and TC offload hooks
so userspace can request TC mappings and queue counts.

It also integrates a driver-side mechanism to program the firmware
with the IET/FPE preemption mask and to kick the firmware verify state
machine when frame preemption is enabled. The second patch adds ethtool
perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
.set_mm and .get_mm_stats so admins can view and change MAC Merge
parameters and retrieve preemption statistics.

v3: https://lore.kernel.org/all/20260205184747.2451816-1-m-malladi@ti.com/

MD Danish Anwar (2):
  net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
  net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   9 -
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  98 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  10 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 223 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     |  80 +++++++
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   1 -
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |   5 +
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 10 files changed, 426 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h


base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.43.0


