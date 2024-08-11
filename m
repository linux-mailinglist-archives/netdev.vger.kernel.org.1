Return-Path: <netdev+bounces-117540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C694E3B1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 00:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9AE1F221CE
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42257165F12;
	Sun, 11 Aug 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Drozbat7"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021098.outbound.protection.outlook.com [52.101.70.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4F157467
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415504; cv=fail; b=ex3BjJ4c1ksIgvNTy6PzGcHa++6pUpDbB025iD72JvqockLOzeC/8Ey6hpq/iWyVw8K/SXkFjvS36+7lcg6oVuNiGJkReDRihhn52JN7+v8E3rJx9Gi9/MmPlWNO2Skq9OxS/dcfvRlb2u2NNB+xwz/klhPa81t+HpEOHswUfcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415504; c=relaxed/simple;
	bh=RV/WreNB83bncpMEWO60BcPB2Fuya41geQin6BiC94g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biNHl0yJV3KmFvZio3qyw3Ce6nGKib88p4eCTjclr1kuxyU5/xf6pr7b8Z2HidfHB0TJmQuh3n0MIgy10IuP2yttlDOFgwQupA77vtnxXTFs5fUBvUr06VIthHc0ujiBwFmwKmTK2n6aki78drbvrt0U3na+BMBumKfQ4vep6aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Drozbat7; arc=fail smtp.client-ip=52.101.70.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5qZHnRr1qOiixmSD5eK3sOzilj21a9vPL+m0eNgM246e4MoI80u/uPXiy7fQQVUNmhT4/lCjlDQq0TfKnPMlTbKsTmRlbzSfI7t0oqHbqa6AT9TfidwlTJtGX9zCa9uoiBRQ46ZFk8vfhZc3zpUCwsVhwI2oXS2gB4lyxo2jHZHhCVnGy9NcjQ5tXyYCoMTIT8fpLjmthHNLlsf2gU8/owxsTTnzqFWjWNBgyWZvLfdYDXIZdXLMd2XU1Y6jpbVtVv1RKUTaPcBMf6DjsfemnDkKTY7hO0/jxQ1309l9v6xPp2gLdFBZdsgcyZTCQILzegKsbX4r1O/2GqTBG4j/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aa1T/Ao+sNjbiUp6f24HdPzi4sjRH7qvE9ObuvmUUk=;
 b=ci3mQl49pQveoiHs2WscKDSKcnj3OAftdbZBbZczB+3/aog57N3UgXN+G0ZHf1C7ezc3uXFnfkO8IvZHjb2QsP7ZZP7jIt2sOTjRz7mZROW6vKNjX+9nYRiKqcO+hLxCjtdlwpAh0zwWs4DmFV1T2Nvubrodgo6mlVkyfG1fI2gcBUv2fFParFvrCvtYsdgVcoND8FxFTYwCJIVi9h9X12QjixVjnctIcElAjcXx8cGNfGaOwd8Y6vxYy3PiN/VRt3piJ5hmfI8/sjAedItybIhRulyennavLU3JuElsYY1kkcd7kX7m3JbMNcNk3TtiZHxwTw+zSWD9bkjEegPweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aa1T/Ao+sNjbiUp6f24HdPzi4sjRH7qvE9ObuvmUUk=;
 b=Drozbat7u7T3D2cbq17U6xCSLpHD8ljoHOCU50VOsFKQjJ4IkJNXq2nt6a+VV4p3l6leydekhwyoFBjQ8kNB4DHRaI375apbTfRPn9tEXAQOiVtR4Bp0Swn1P3ydUwLfvn0MzhzKnKdWVpLofxRl5eDRI6wUseqcNCArkfqWXC0=
Received: from DU2PR04CA0337.eurprd04.prod.outlook.com (2603:10a6:10:2b4::35)
 by AS2PR03MB9879.eurprd03.prod.outlook.com (2603:10a6:20b:547::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 22:31:36 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::bd) by DU2PR04CA0337.outlook.office365.com
 (2603:10a6:10:2b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Sun, 11 Aug 2024 22:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server id 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 22:31:36
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id E7CE27C16CB;
	Mon, 12 Aug 2024 00:31:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id D8F4C2E488E; Mon, 12 Aug 2024 00:31:35 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH 2/2] ss: fix libbpf version check for ENABLE_BPF_SKSTORAGE_SUPPORT
Date: Mon, 12 Aug 2024 00:31:35 +0200
Message-Id: <20240811223135.1173783-3-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240811223135.1173783-1-stefan.maetje@esd.eu>
References: <20240811223135.1173783-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|AS2PR03MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: df30d9de-ba47-48d6-6e2f-08dcba555c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Szc1bmRVeXVYRVdub1JDU2tJazBGdldsNkVJUDJyZC9yQjZOaTZEaVRHcVhu?=
 =?utf-8?B?SnU0ZEd2dnQ1QzFCMlNpL2h6bUdBU0xvc3lWRFhzS2FrMDZ1K2xkU2gvajV1?=
 =?utf-8?B?c1hzVmF2dkVlQnc1enkxOGQ4R2MyU0VSamhtcDREcnhzdGZWVmozT3dCRzhW?=
 =?utf-8?B?bGJvSEN1T29CNWk3aEo0NlFEd08yQW9KOUdxM0RvVTR3YWJBdXJTR1FZQncw?=
 =?utf-8?B?ZVhCZUw1TmxVYnlCUlRPVnNoN2dESTBkWFhKd2RYQ0Q4MmpNODg0cjlvV29l?=
 =?utf-8?B?ZkJkWndzSDc0UXJNSmVFSXFYMnZFVlJHaUh3YnI1aDRoeWRIaTlCNndyTWZp?=
 =?utf-8?B?N1VEZVFJUjI0ZEQwc2NDbWlHYUo4T3ZBWEhGWFNZR2oxeVovYSs2Uml5M2NC?=
 =?utf-8?B?OFg5MFJRZGtaQTJwdEUxMlhKM29QNWkybE5kUXk2RUhiSEhmL3JKS2lMTlE4?=
 =?utf-8?B?QmQvb2RMa3hHelhrMDdCR3YwelUrN3V5bVRYcVdISVpoZ0ZsUHFQeXRTUlBO?=
 =?utf-8?B?YnNxOStLaHFaeFdEeGh5d0U0bUxMTWpwVDNhTUtUemduQ3FBZ1FIVmZpQUVa?=
 =?utf-8?B?V3p2SEx4U1hDQjhGTnkxQXhwbVZ6S3hkbVBMd0FiRzNFSlBKd0h0NEdxdXpz?=
 =?utf-8?B?WjdDdzlTdW9sTXB1RVNmNWNYWCtoYnA3Y2ZaSnlmV2hzRlVCeG9zaEhTVHU3?=
 =?utf-8?B?bEJIMk1mRGFCVTR3NkFIMFBjajhVWjVWNGxOdkxDTUl3TlIzNDBkUDFJMVRR?=
 =?utf-8?B?MlAvSmFIRE5Ld280Ry9VS094clZ5b0krSkJBaUVWRTgzM3BKb0JUTlFIdndF?=
 =?utf-8?B?ckY1d0k3VDZpeFM1N2RrR1BsbURLejRrN2YxWHo3VTZiRm83M0lsdFlsWDZK?=
 =?utf-8?B?Ti9DMzh4dkx4VzZZTzdLUFg2aURLbXlnTkgwbXc2UjhWbHRFYUkxWWtzSW1i?=
 =?utf-8?B?M2xSRElaNEhyamNLYnBvd256bk5raFR1OGcwckF5WllDTkRIZ1VEeHI2T0VU?=
 =?utf-8?B?cUF2VnFLSWZjVG0xOEY2RTdEVzNqRDBIQlAvL21Fbjl4V2M5THZJdEZ1Q2Vm?=
 =?utf-8?B?UG4rY001aE1nUVZsQm1MSEhjb0pSVWs2V1JDR2hYQWFiZjkxanRkSW9WekNV?=
 =?utf-8?B?WHNILzg1RXdiakpabGdLd2dxaHByc1ExUlI3elFLcWZZaHFvKy93K2lBdll3?=
 =?utf-8?B?dmdsWHJ4dFA2L2ZiY0FmblJuY2duQm9XZWsyWTdwaXlBb0NNMGcyNjlKSmpV?=
 =?utf-8?B?eVZyaWhJRitrMURjVXJSRFpMc1ZTVjhxMDdkM2cwdm9yOHlHRWtBbmExZDRQ?=
 =?utf-8?B?MWJGZjZmVVFyb1lsZU8zWG9OaVdlaHlxR1EvVFJWYzhMcktmY1BVNlk5OS8w?=
 =?utf-8?B?ckZuMTFneW43MU1ubnRCY1pPVTI4bHIxbGhiRUhPd0dHRXJkcmtGWFZUTUhx?=
 =?utf-8?B?SE1zOENkVmFUdUZTQkhJVVRVM3VUTjZ0WENYcmFZdzRyL0NTVmt2dWI3Zys3?=
 =?utf-8?B?OEh6VVlNcngvVWxhaHgxL0creUNzVjdtT2FpMGx3SEdCN1ZoSHpQaHN2VUdL?=
 =?utf-8?B?cWFVajJ1MEFYWjg5N3lhYjJ2V0sydExZeEhhZ1FPcmlOVXRJTklScDVWZ2Ri?=
 =?utf-8?B?ZDk3Nnl5a0dLT2RLdGppWk5FRDdkM08wUm4xTWc5eWhLc1luNUN0RDlnRnBx?=
 =?utf-8?B?QWltb1g3ZW9LTXlmZ2phWnp1c3YrYmlSSTZkUE5DQ3RDZkU0cmk1Qm1EdzI4?=
 =?utf-8?B?bG4veFJCd21vUXloZ1YzdlRnTVFqZm44cGdDQ1BLRXRHQzdCb0lweXB3WEE3?=
 =?utf-8?B?QW0xaHdFWVFYR3FEZHVjbVE2QVVqY3h4NUJ6c1pZSXgraS9pRXc2VE1iSjZQ?=
 =?utf-8?B?TVNCVk9Ea1p5Y0M1bnhVWTZ4SVdTTHJoT3hoZURsejVuTFhuQVJYRjVqSkxD?=
 =?utf-8?Q?AWUT7doBXriMs4HuS79eS+3TrmBpg/9Q?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 22:31:36.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df30d9de-ba47-48d6-6e2f-08dcba555c56
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9879

This patch fixes a problem with the libbpf version comparison to decide
if ENABLE_BPF_SKSTORAGE_SUPPORT could be enabled.

- The code enabled by ENABLE_BPF_SKSTORAGE_SUPPORT uses the function
  btf_dump__new with an API that was introduced in libbpf 0.6.0. So
  check now against libbpf version to be >= 0.6.x instead of 0.5.x.

- This code still depends on the necessity to have LIBBPF_MAJOR_VERSION
  and LIBBPF_MINOR_VERSION defined, even if libbpf_version.h is not
  present in the library development package. This was ensured with
  the previous patch for the configure script.

Fixes: e3ecf048 ("ss: pretty-print BPF socket-local storage")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 misc/ss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 620f4c8f..aef1a714 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -53,7 +53,7 @@
 #include <linux/mptcp.h>
 
 #ifdef HAVE_LIBBPF
-/* If libbpf is new enough (0.5+), support for pretty-printing BPF socket-local
+/* If libbpf is new enough (0.6+), support for pretty-printing BPF socket-local
  * storage is enabled, otherwise we emit a warning and disable it.
  * ENABLE_BPF_SKSTORAGE_SUPPORT is only used to gate the socket-local storage
  * feature, so this wouldn't prevent any feature relying on HAVE_LIBBPF to be
@@ -66,8 +66,8 @@
 #include <bpf/libbpf.h>
 #include <linux/btf.h>
 
-#if (LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 5)
-#warning "libbpf version 0.5 or later is required, disabling BPF socket-local storage support"
+#if ((LIBBPF_MAJOR_VERSION == 0) && (LIBBPF_MINOR_VERSION < 6))
+#warning "libbpf version 0.6 or later is required, disabling BPF socket-local storage support"
 #undef ENABLE_BPF_SKSTORAGE_SUPPORT
 #endif
 #endif
-- 
2.34.1


