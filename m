Return-Path: <netdev+bounces-255624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPSEFnx3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C16AFC658D
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CA5300CE63
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5C2459E1;
	Sun,  1 Feb 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nAke3NGk"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EB23D2B1;
	Sun,  1 Feb 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961298; cv=fail; b=uKfRdorfqUoO7/kxQL87y1UyFN3BEQrSQwZEHnt9EHXtHtE6QTA6wR7UQO8HN+JEFPsvxFFkUvZNDGojfGiqEVARn3PDZnHua7O/fFPb9v7PfjBaDMB2WyuiUFF/sZ6dscY2RXcnRjglTvsXEBQz0QaZvlHQQMNJzNslFiKDizM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961298; c=relaxed/simple;
	bh=1AlGP00PIo1FAVoQE8aS3TIXZwQ1G54APfFZTjkGIwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCaoTLiWPWXf+DSRYchV4NOnlrjRwbLvJxcZ1hsTCg/3QslNLN+Uphz26lBPP2FXJj/vi2WHGhxJwSh13P0kCjxu4mHrVYbX39EhXRjEvSjwg2vumttUJPyoWu5wRWpwMUJ2bRcdBqGgEGp8CXGYCC47f6XljJ1+AkApKBj74RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nAke3NGk; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOfFVoeJ1aT8AfhYEc87oEtKeVqGnLpC7gezVYIVxAZCTJpTCIwOULlRG77ITru6Lsh0olcyXDVoJbyncWqxe8zSlqy7izPYNPOSDHWD9aVTqHndEqlmj7wgIEkk4L6fz/2Pp9cJ0jvDVVdifubp9iSBIsqtrani78oswy+a4Fp5Bwyj7ImlPut8ct2gd0JjdX1wfDKMTSbqX0jD6oFur7kMF8es/0Ei6aellHAeOMq7q58XD2fhGwsSmj4oQaTwr81VTks/sP4st0O0a3t2zw3FFcT4QAGafY7mA9k2TiY4q+OAxlReqg1qVQBk5DOL5pY9+XRDGn6p6S6tHbQLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRtcA5ojgu0HBaUqmOunEsg0eomAqnQMrxktXFf/1nY=;
 b=hLICTnM2ggqRgCAlewny/fGmFfCR8Bz6bNsnspPG/ISySiboN6HGxouvkM/3th3NA0Sv7vr9GJOy6pR4ic93ZPrwWhlSZEAmmus8sEJX2yOvAN7tM7FQoHBymQzTP28JVgEb2Xv4JdSbLe0QtmIjIfPMTmq0xcjL5YxNbkViQbKwINTU/I9ZEg6VJgSwgoloKRQWNw01/JRGbu/XUzFhDybLCq5lsV4bYtS274k8Bp8/+VWlrQll11vPBLUmouoLkA6HazD9TaLJ3HsB1yqwvUekD6kYPEfk1JOX10nZSKwKMQqTVPymJJ6yiE48gZaOwFxdMDxySKDeKCR0Z6efLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRtcA5ojgu0HBaUqmOunEsg0eomAqnQMrxktXFf/1nY=;
 b=nAke3NGkjYdFBJv4AwKACNGSrqbaUlZs1R4ZJyoaweK3s1NEJ4DBKtxCY+EuMHBuCLbBzmPgdh+goSb8fjBEcmV6KdTqcCAyCfLZH3dqV7G5mjW5UpDowwKS758snWqP2LAc4L43rwfOYVV/XywPYdNywJ1Scks4tg61d/4uoOw=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 1 Feb
 2026 15:54:48 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com (2603:10b6:303:85::4)
 by MW4PR04CA0161.outlook.office365.com (2603:10b6:303:85::16) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15
 via Frontend Transport; Sun, 1 Feb 2026 15:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:46 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:45 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v23 00/22] Type2 device basic support
Date: Sun, 1 Feb 2026 15:54:16 +0000
Message-ID: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 01361787-b72b-488b-118d-08de61aa3a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlFpSnNkaHYwQ01COWc1b3MwV2VEREc2SlJ2SlVSN05Wa3Q5QTF3RlkwTEcv?=
 =?utf-8?B?Yk5TVDVlTkJxWnhLZVhYMTAvNmF6QVlPN1VXOEhXUGpYajB3d0RBQmFUcFVW?=
 =?utf-8?B?MHJ5M0cxQk91TGl0VUlmOXpuOXFxRHd6NitscmswTnExNkNma2RxSEp4ZGd2?=
 =?utf-8?B?dStOKzdnNmduajZLZ1N3d2hydWIxSjlrRTJqNWhpejZuYXFDZTdUdzdLNi9O?=
 =?utf-8?B?SFozY2NZOGRzd1pSdTVEVjhqdXlMeFVEZ2I1cklqK0dNc1hxTTlwVHNiSC8y?=
 =?utf-8?B?LzVLN2lDdkNOMEkxM0tYUXpYbTk0VmhPVHdlUU04aWw2b3NzY0d5dC9OZ3Nx?=
 =?utf-8?B?bnU5WWh3a0xFQ3RQNGVsV20rQ1hQamlkT0ZkNjY0UnpUR2hNRTgwcW83ZU9v?=
 =?utf-8?B?bkxqbjhBaFRXMWxoSTh4cDRZSlVUYjdrNmM4T2kwNzJveXdDdzJ6NTh6N2ZC?=
 =?utf-8?B?RzQ0aWhmcUxncDNYZ2QyRU9PSTFvL1ZhQ2dtNGZ0U2thdHp2Mm04Yk41ZjJM?=
 =?utf-8?B?WTZtQXdXOTh1emNDREVjalhHRGxQYWFjNmd2SkxmV2JKWlIxeWh6a2hod1Vx?=
 =?utf-8?B?VjBEajR4TytKN0cxQ2pLVk5Xc1ZSY2tBS0QvVnV4cit6WHA5LzJvNTRnZ1Jh?=
 =?utf-8?B?bldFeHFTd0pTdWZub2xTQjkvdklMV0M0K1pUM0JSbVlyOHFkQ21WSHZjekpq?=
 =?utf-8?B?SXhkRGtsMEtRYmgxVlNjTGpKV2JaTmlwcytPVU81MXhoVXJNYWZMcUFkSDhJ?=
 =?utf-8?B?TUV2N29PejhlZmtFNWNXK3g0RC8rOTdYYlFCR0x4UTlCU3JlQkk4KzlaY3g1?=
 =?utf-8?B?V0VLOE4yRUJJRjd4TEJZOEo0VGM4ekRjOWgrM3M1WGJDaHhMSVl2TU92ZEFM?=
 =?utf-8?B?cm5zWXdtQUcrdTJvamhZODdobWZyVHM4QWVYWDRwbTI0b1praHl0S1l5Z2dD?=
 =?utf-8?B?LzhrS2Vzd3FBUTBXNk5wN2FabFUrMkVGYzFKZ3hQRFZqL3ppbUJNSmhVWmRV?=
 =?utf-8?B?Yld1c2dISEN4SFZhOEZZeDhUT0Zwa3RrOXR3TytzbEVQczg2c0JCa3dRV1la?=
 =?utf-8?B?ZWEyZjV1NnF4MklmLzRtYnpPbjJuZWEyOFMvSG51SC9pVnJGS3FUN0k3SnBC?=
 =?utf-8?B?RGdBeGdCelJFOXVmYTQrVVNhSGduYlNudTFMMW5IcGVxNTU0RFN6OVlyaWYy?=
 =?utf-8?B?QzFOTjRRSWw5a3k3UXNDMlo0eUsrUHRGWTVqY2VkcGlvWWJrTUhPUzF3dUtJ?=
 =?utf-8?B?bjY0MytIM3J1ZExldXFRaXc5MTZFcUZWcSt2TXFWTFp0Qnl4Qy9GalgrUHlz?=
 =?utf-8?B?NzhLLzJNU20vc3Y4dkNWZVlTa2lRNEI4Q3A3ZHVrUHNXU1N1bks3MUxHWmJk?=
 =?utf-8?B?NHY2UURyc2tBTkZlQW4wLzVWbEJCYWE2Nm94ektxWmhoZ0w5T3NuOFpGKzF2?=
 =?utf-8?B?akVuNDNIZ0ZNNnJDcjl3VUpEUXBXVzN2SE0xTnZzdzRqd3FmbktldWdzdEpy?=
 =?utf-8?B?NnE2WXVSR1B6VmtBZyt5TDlZVnQwdk5kRzMvbUkwWkhMcWhSZkFWUDlUTUwx?=
 =?utf-8?B?UnZIQ05POE1yb200NlEyOEVPOHlDcTA2UTArWk54cHpFVTdLVGlLNENOaDlx?=
 =?utf-8?B?ZW5sdEc3dCtKOUpmTisvbEpVZ05vY3pXNlRjT2VGcmlOODRVQnJKdms0OE1K?=
 =?utf-8?B?OGI5UGJ1UVNJdHNSYVc4TDZDaThUNDVsWDMyMmpacWd4SVFyRldFQnBSWWd5?=
 =?utf-8?B?dHNzWHdwbS80NUtSWlZHejZWOHdDTEpibWI5djBOTWtrZHBNWmpFdXhMeERZ?=
 =?utf-8?B?SElxZFpFb3B2MWRYalcrWUFidWh6MGUrMmZxWEFxSExPcm4zSlBYTEltYUZ5?=
 =?utf-8?B?eXJZNzVIb0ZBRDh0NmthWWUrckxaMXMzQ2l6K1lmTDk5Szc5b3FFNGFZYUM4?=
 =?utf-8?B?VjVtUFY1ekpmbFNNWWZGTDc5SzNGcHJJUHlBUkp5ZE4za2ZZYnVpSDdEQ1ZR?=
 =?utf-8?B?eE82SkN6aENkSnpVem5HdXRXZVhncjVySGVRRmFyZi8zdkJib293Y21SZUI0?=
 =?utf-8?B?WmNCWThsQ05mQlIyRmxQVUxyVU9aR2xCRzQxMWtaQ1R0cDM3ZmV3dEFVRjlz?=
 =?utf-8?B?cFBKeXRLaU9wWFJPTlpsRWhJbFVqcmZQYjJ1MkdjVUFxcC9JUmRDV1RCaHFk?=
 =?utf-8?B?TTdOU2dhZFdzdEJCd1ZMSzJDM28zL0gwSDNVcHYrcGFKSnk5ZmtSbGQ5UDN2?=
 =?utf-8?B?ek9hN2tZdzlMclk5V1BJV2h5dDB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PMutvdILJivDQh/LNtcn056xLpLIIqigPJdVskMPvbtGSjekeDtqBurqU1tZd0U9W4BFBzDGAYzb6bYRbBqtcG8DuU8O0A2HK9NrQ35/IZy8lVm5CRlRUk42TGN9wUfyQDLwcU4dE2a5dSVcxjhA9uAIlNwWi9edroNkoLbmhOshjwePeneHUpEI9tzZcOQUjaqjY57JxSvEZbiZfaCZpJyvdUnYBp9ObIUORmw5P5zF5lKKWtPFToUH+UhEEPe/Oo5qUipGwKAOI+0/SEIF/pXdiXYdfHzZ+YwdEeVkTyOEJVu+aHJGPUe0FoLzCGSxTkNd2hIdmcDG4i+iCe4m2OMnSwZtz1pmY1egMIyod55PM/EO4A+Pd/dnvh1Od9iGRRzIccPRImGSHtpEvwGfDaqix7sjSS96OkClAO+ysbUtz1MN5ko3e+8+jD96pYbx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:47.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01361787-b72b-488b-118d-08de61aa3a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255624-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C16AFC658D
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

This patchset should be applied on the cxl next branch using the base
specified at the end of this cover letter.

Dependencies on Dan's work has gone and also on Terry's as the only
patch required is now in next. The other dependency is on Smita patchset
but it does not exist such a dependency as that work will not avoid the
problem with Type2 and DAX/hmem if soft reserved memory. This needs to
be solved by the BIOS and Type2 UEFI driver for populating the CXL.mem
range as EFI_RESERVED_TYPE instead of default EFI_CONVENTIONAL_MEMORY
with the EFI_MEMORY_SP attribute. There exists though a dependency on
one Smita's patches:

[PATCH v5 3/7] cxl/region: Skip decoder reset on detach for autodiscovered regions

This is needed for the default behaviour with current BIOS configuration
where the HDM Type2 decoders will be kept unreset when driver unloads.
This is the main change introduced in v23: committed decoders will not
be reset. Previous v22 functionality supported first driver load finding
committed decoders but resetting them at unload and supporting
uncommitted decoders in next driver loads. This will be suported in
follow-up works.

v23 changes:

  patch 11: fixing minor issues and droping change in
	    should_emulate_decoders (Jonathan Cameron)

  patch13: refactoring unregister_region for safety type in Type2 API

  sfc changes: slight modifications to error path


v22 changes:

  patch 1-3 from Dan's branch without any changes.

  patch 11: new
  
  patch 12: moved here from v21 patch 22

  patch 13-14: new

  patch 23: move check ahead of type3 only checks

  All patches with sfc changes adapted to support both options.

v21 changes;

  patch1-2: v20 patch1 splitted up doing the code move in the second
	    patch in v21. (Jonathan)
 
  patch1-4: adding my Signed-off tag along with Dan's

  patch5: fix duplication of CXL_NR_PARTITION definition

  patch7: dropped the cxl test fixes removing unused function. It was
	  sent independently ahead of this version.

  patch12: optimization for max free space calculation (Jonathan)

  patch19: optimization for returning on error (Jonathan)


v20 changes:

  patch 1: using release helps (Jonathan).

  patch 6: minor fix in comments (Jonathan).

  patch 7 & 8: change commit mentioning sfc changes

  patch 11:	 Fix interleave_ways setting (Jonathan)
		Change assignament location (Dave)

  patch 13:  	changing error return order (Jonathan)
		removing blank line (Dave)

  patch 18:	Add check for only supporting uncommitted decoders
			(Ben, Dave)
		Add check for returned value (Dave)

v19 changes:

  Removal of cxl_acquire_endpoint and driver callback for unexpected cxl
  module removal. Dan's patches made them unnecessary.

  patch 4: remove code already moved by Terry's patches (Ben Cheatham)

  patch 6: removed unrelated change (Ben Cheatham)

  patch 7: fix error report inconsistencies (Jonathan, Dave)

  patch 9: remove unnecessary comment (Ben Cheatham)

  patch 11: fix __free usage (Jonathan Cameron, Ben Cheatham)

  patch 13: style fixes (Jonathan Cameron, Dave Jiag)

  patch 14: move code to previous patch (Jonathan Cameron)

  patch 18: group code in one locking (Dave Jian)
	    use __free helper (Ben Cheatham)


v18 changes:

  patch 1: minor changes and fixing docs generation (Jonathan, Dan)
 
  patch4: merged with v17 patch5

  patch 5: merging v17 patches 6 and 7

  patch 6: adding helpers for clarity

  patch 9:
	- minor changes (Dave)
	- simplifying flags check (Dan)

  patch 10: minor changes (Jonathan)

  patch 11:
	- minor changes (Dave)
	- fix mess (Jonathan, Dave)

  patch 18: minor changes (Jonathan, Dan)
  
v17 changes: (Dan Williams review)
 - use devm for cxl_dev_state allocation
 - using current cxl struct for checking capability registers found by
   the driver.
 - simplify dpa initialization without a mailbox not supporting pmem
 - add cxl_acquire_endpoint for protection during initialization
 - add callback/action to cxl_create_region for a driver notified about cxl
   core kernel modules removal.
 - add sfc function to disable CXL-based PIO buffers if such a callback
   is invoked.
 - Always manage a Type2 created region as private not allowing DAX.

v16 changes:
 - rebase against rc4 (Dave Jiang)
 - remove duplicate line (Ben Cheatham)

v15 changes:
 - remove reference to unused header file (Jonathan Cameron)
 - add proper kernel docs to exported functions (Alison Schofield)
 - using an array to map the enums to strings (Alison Schofield)
 - clarify comment when using bitmap_subset (Jonathan Cameron)
 - specify link to type2 support in all patches (Alison Schofield)

  Patches changed (minor): 4, 11

v14 changes:
 - static null initialization of bitmaps (Jonathan Cameron)
 - Fixing cxl tests (Alison Schofield)
 - Fixing robot compilation problems

  Patches changed (minor): 1, 4, 6, 13

v13 changes:
 - using names for headers checking more consistent (Jonathan Cameron)
 - using helper for caps bit setting (Jonathan Cameron)
 - provide generic function for reporting missing capabilities (Jonathan Cameron)
 - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
 - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
 - avoiding rc variable when possible (Jonathan Cameron)
 - fix spelling (Simon Horman)
 - use scoped_guard (Dave Jiang)
 - use enum instead of bool (Dave Jiang)
 - dropping patch with hardware symbols

v12 changes:
 - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
 - add public/private sections in now exported cxl_dev_state struct (Ben
   Cheatham)
 - fix cxl/pci.h regarding file name for checking if defined
 - Clarify capabilities found vs expected in error message. (Ben
   Cheatham)
 - Clarify new CXL_DECODER_F flag (Ben Cheatham)
 - Fix changes about cxl memdev creation support moving code to the
   proper patch. (Ben Cheatham)
 - Avoid debug and function duplications (Ben Cheatham)

v11 changes:
 - Dropping the use of cxl_memdev_state and going back to using
   cxl_dev_state.
 - Using a helper for an accel driver to allocate its own cxl-related
   struct embedding cxl_dev_state.
 - Exporting the required structs in include/cxl/cxl.h for an accel
   driver being able to know the cxl_dev_state size required in the
   previously mentioned helper for allocation.
 - Avoid using any struct for dpa initialization by the accel driver
   adding a specific function for creating dpa partitions by accel
   drivers without a mailbox.

v10 changes:
 - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
   memory after all and facilitates the setup.
 - Adapt core for using cxl_memdev_state allowing accel drivers to work
   with them without further awareness of internal cxl structs.
 - Using last DPA changes for creating DPA partitions with accel driver
   hardcoding mds values when no mailbox.
 - capabilities not a new field but built up when current register maps
   is performed and returned to the caller for checking.
 - HPA free space supporting interleaving.
 - DPA free space droping max-min for a simple alloc size.

v9 changes:
 - adding forward definitions (Jonathan Cameron)
 - using set_bit instead of bitmap_set (Jonathan Cameron)
 - fix rebase problem (Jonathan Cameron)
 - Improve error path (Jonathan Cameron)
 - fix build problems with cxl region dependency (robot)
 - fix error path (Simon Horman)

v8 changes:
 - Change error path labeling inside sfc cxl code (Edward Cree)
 - Properly handling checks and error in sfc cxl code (Simon Horman)
 - Fix bug when checking resource_size (Simon Horman)
 - Avoid bisect problems reordering patches (Edward Cree)
 - Fix buffer allocation size in sfc (Simon Horman)

v7 changes:

 - fixing kernel test robot complains
 - fix type with Type3 mandatory capabilities (Zhi Wang)
 - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
 - add sanity check when dealing with resources arithmetics (Fan Ni)
 - fix typos and blank lines (Fan Ni)
 - keep previous log errors/warnings in sfc driver (Martin Habets)
 - add WARN_ON_ONCE if region given is NULL

v6 changes:

 - update sfc mcdi_pcol.h with full hardware changes most not related to
   this patchset. This is an automatic file created from hardware design
   changes and not touched by software. It is updated from time to time
   and it required update for the sfc driver CXL support.
 - remove CXL capabilities definitions not used by the patchset or
   previous kernel code. (Dave Jiang, Jonathan Cameron)
 - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
 - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
 - Fix construct_region use of rwsem (Zhi Wang)
 - Obtain region range instead of region params (Allison Schofield, Dave
   Jiang)

v5 changes:

 - Fix SFC configuration based on kernel CXL configuration
 - Add subset check for capabilities.
 - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
   Cheatham)
 - Add option for creating dax region based on driver decission (Ben
   Cheatham)
 - Using sfc probe_data struct for keeping sfc cxl data

v4 changes:

 - Use bitmap for capabilities new field (Jonathan Cameron)
 - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
 - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)
 - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)
 - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
   MODULE_SOFTDEP instead.

v3 changes:

 - cxl_dev_state not defined as opaque but only manipulated by accel drivers
   through accessors.
 - accessors names not identified as only for accel drivers.
 - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
   (drivers/cxl/core/pci.c).
 - capabilities field from u8 to u32 and initialised by CXL regs discovering
   code.
 - add capabilities check and removing current check by CXL regs discovering
   code.
 - Not fail if CXL Device Registers not found. Not mandatory for Type2.
 - add timeout in acquire_endpoint for solving a race with the endpoint port
   creation.
 - handle EPROBE_DEFER by sfc driver.
 - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
 - factoring out interleave ways and granularity helpers from type2 region
   creation patch.
 - restricting region_creation for type2 to one endpoint decoder.

v2 changes:

I have removed the introduction about the concerns with BIOS/UEFI after the
discussion leading to confirm the need of the functionality implemented, at
least is some scenarios.

There are two main changes from the RFC:

1) Following concerns about drivers using CXL core without restrictions, the CXL
struct to work with is opaque to those drivers, therefore functions are
implemented for modifying or reading those structs indirectly.

2) The driver for using the added functionality is not a test driver but a real
one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
buffers instead of regions inside PCIe BARs.

RFC:

Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
expanders. Type2 CXL devices, aka device accelerators, share some functionalities
but require some special handling.

First of all, Type2 are by definition specific to drivers doing something and not just
a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
setup needs to be done by such a driver instead of by a generic CXL PCI driver
as for memory expanders. Most of such setup needs to use current CXL core code
and therefore needs to be accessible to those vendor drivers. This is accomplished
exporting opaque CXL structs and adding and exporting functions for working with
those structs indirectly.

Some of the patches are based on a patchset sent by Dan Williams [1] which was just
partially integrated, most related to making things ready for Type2 but none
related to specific Type2 support. Those patches based on Dan´s work have Dan´s
signing as co-developer, and a link to the original patch.

A final note about CXL.cache is needed. This patchset does not cover it at all,
although the emulated Type2 device advertises it. From the kernel point of view
supporting CXL.cache will imply to be sure the CXL path supports what the Type2
device needs. A device accelerator will likely be connected to a Root Switch,
but other configurations can not be discarded. Therefore the kernel will need to
check not just HPA, DPA, interleave and granularity, but also the available
CXL.cache support and resources in each switch in the CXL path to the Type2
device. I expect to contribute to this support in the following months, and
it would be good to discuss about it when possible.

[1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/

Alejandro Lucero (22):
  cxl: Add type2 device basic support
  sfc: add cxl support
  cxl: Move pci generic code
  cxl/sfc: Map cxl component regs
  cxl/sfc: Initialize dpa without a mailbox
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl/hdm: Add support for getting region from committed decoder
  cxl: Add function for obtaining region range
  cxl: Export function for unwinding cxl by accelerators
  sfc: obtain decoder and region if committed by firmware
  cxl: Define a driver interface for HPA free space enumeration
  sfc: get root decoder
  cxl: Define a driver interface for DPA allocation
  sfc: get endpoint decoder
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup
  cxl: Allow region creation by type2 drivers
  cxl: Avoid dax creation for accelerators
  sfc: create cxl region
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   5 +-
 drivers/cxl/core/hdm.c                | 123 ++++++++
 drivers/cxl/core/mbox.c               |  63 +---
 drivers/cxl/core/memdev.c             | 113 ++++++-
 drivers/cxl/core/pci.c                |  63 ++++
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/region.c             | 434 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |   2 +-
 drivers/cxl/cxl.h                     | 125 +-------
 drivers/cxl/cxlmem.h                  |  92 +-----
 drivers/cxl/cxlpci.h                  |  21 +-
 drivers/cxl/mem.c                     |  45 ++-
 drivers/cxl/pci.c                     |  85 +----
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 ++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 186 +++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  41 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 287 +++++++++++++++++
 include/cxl/pci.h                     |  21 ++
 tools/testing/cxl/test/mem.c          |   3 +-
 24 files changed, 1376 insertions(+), 425 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 3f7938b1aec7f06d5b23adca83e4542fcf027001
-- 
2.34.1


