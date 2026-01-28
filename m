Return-Path: <netdev+bounces-254286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF1xGuceemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:36:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D8A2DEC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63FE5304FC1A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A3D36073E;
	Wed, 28 Jan 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZhAsmkuU"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DD350A14;
	Wed, 28 Jan 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610890; cv=fail; b=XPoZJQsdLV22HmgAUN7Zb7YDFGCKelG1CGdh47uEDsJjty0hHWLzFqeiErf8+Ifrj9W096VbAJq7pHzxVwIrFjEmtntLzdDglMUyNdaTY46LIY3D2eXb/pu3xR+nK5PptaCTTdAkzhVaEJqJERnuGN0YLrilZWAXC4oK3pCVb9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610890; c=relaxed/simple;
	bh=rJt7iRk3i1fVuAGbLdpTUDtl5bvD64FeJKOCKyBtaxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHL/R7t+2+ObiguJK+Yr0/Sl+eh2c25EAXfHAXke3ILgzAfEQKVckMlQE6XWhJILjuy1xRGB3rxg+OnJVEAjXvyp3mWACmsQTOTxE53ZNeBDl8i1kUEUhdyN11yrT/0g04VxkPMRxFWsMi2nzzZ49YPs8DPOGklUpAMKeP/b5r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZhAsmkuU; arc=fail smtp.client-ip=52.101.83.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUVg25O1R87lAyOrElzP957Om8RI1+Fh5uQ96t/V8W9NUEWkj+C6lORbYzX7B/3MMBTJ7IZ6VEznoYnZu8wcLj461UrcZWi+4LzzvFFitIKk3Uyor7yPfQahMqgAbCWwMJpAWucDbHkkJdyFSq4Tviq/5iDIZ2r6cW98IzS5WdbxOxb12x+J3AmwG4f3/K3xzbhc36PsU94SDEkUITRMhhZPyKAVwLtJ2VDa/ORMkdA5yDQzunIWFD0IG+tYipT45IPaPk/iw4VglnAxPnx+Ib92gIX6O54a51TXik674A70QLwBcAsDyWWm7eoXk55pAYkWrIWvChMda5ii0jJk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzau1NZLTf+7VMtQ8FXQasOBSgpwrvl2QgU2HQPCtnM=;
 b=nlqGHxb90TRXGTK9vacNsPjr+LIhGuGC+Cag/SHHeLh6fsTd5/UP3K3T+574eGdnTo0U6QdR4PyKwDMbjjibgHSydXDEZpXDHifruRxLo5b2g70UI0p9JRoKSfp+a1uSXQg+R3iR9gJPZBBSmAEJoD9SOZBWqpXIFHDQlwuU3YQU+aBorKst1BglnAS7RsRWKFQTEbWXYKQDbGUaxmH93suw4c7w/Sfd6HCYE1BnGD1WEKtMvUWbH8KXzCnaQ9I4s1Aj5BqrVU8e/QMY6cbrUcxXKNb9ftbUCeUxFCjBzwy5v5GZzFSSliWpxDoLiSAaOaqcubVJ6B9opjsO5relrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzau1NZLTf+7VMtQ8FXQasOBSgpwrvl2QgU2HQPCtnM=;
 b=ZhAsmkuUbXSyRNOgFklLtGfzbSXOnsVPhUAfbjqBuVmebIiS4BLnEBD+1A1NmLGJhi7dBbSiCWznSM+6n4tq5mFN81Dl0IAgGdx5DMK3fQhLAoUie6Auku28TGwNj+BcTPtG1dyZ2fk4JmrSHkvSzKUTdfWzrlDK509T4tke6oWbSlAU66Y3zIfaKo22zf5fIsQy4uL0+ZKAaZe91Eo832e01BJ/gON4ppW3uV6c18FstkXvUMI/fUQxkUDD4Py3hBlu9HwNWBFSZ+HiPuqPZFVB0vnU0PVUjxJb5itbm/L52RC4h6dC5o/iWqCiZIXbyvGF9bxLCWYkEpI90uMxBQ==
Received: from AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27)
 by DB9PR07MB9052.eurprd07.prod.outlook.com (2603:10a6:10:3d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:34:42 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::7a) by AM0P190CA0017.outlook.office365.com
 (2603:10a6:208:190::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8158923708;
	Wed, 28 Jan 2026 16:34:40 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
Date: Wed, 28 Jan 2026 15:34:21 +0100
Message-Id: <20260128143435.15708-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|DB9PR07MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: da0bceb4-b621-477b-b1cc-08de5e7a5fde
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eWNUT3pkQmIxWmhsSGVjS0NuRmZLcXFZVXFFSytJcEtYTzFab0RMNGVvUnBk?=
 =?utf-8?B?RU51M0QrdVBPNlRlcTFJZnNHaVZ5OEhvN3JadE9xQ3NpZi9sbVNNQ2RQWWtD?=
 =?utf-8?B?OUJ0Z1c1b2lZZURBT3E2Sk9hTDhJcVU4RThnWFNxTWw1d01xdHo2ODNHTEFu?=
 =?utf-8?B?YzFzSVhQV3Y4ZnRJSU9sZ3pPVC9IcFZMTGJXcnd2R2F5aFJYS3VkSTZoWFUv?=
 =?utf-8?B?bGNKc1BIOGV2ZTB2a2htTVNGSkVSWDZIb0pFMHhqeEFxa0w4WVJmcXRRdDhm?=
 =?utf-8?B?emx3QndybytFcnB5RU9pME1TbzRsUWNBM2hUZU54VVVkYjlPVlkxNlVudCtn?=
 =?utf-8?B?UTIrTUVWSWVqOGtKbDBDTjhic1g4aDRxSUk2bWlZcGFnQUlIdTZGaVJGKzBI?=
 =?utf-8?B?d1FubXdObk1keDFpeHVka0R1cU1lN3ZTUUlub0pWRXJiUVpTOXhUNVIxNDI4?=
 =?utf-8?B?cW9NZzhlaGVYa1RhZFVSaU10WWZTN1BHVFRlNnNNNVdZdHVLR0hrMkIyWVpL?=
 =?utf-8?B?YTc1Z1dwME9mb1RnT3RmdVRoaml5MDM2TjREQ0VTdkJPT1ZNV1J5RVNldmt1?=
 =?utf-8?B?MDEwTjJEVHBRREEvNkx0Y3BzR0FIQmh5enlBbFJ0bXIxU1A1S2xJb3RMakth?=
 =?utf-8?B?YVorRkUwWk1qRUozZ0RMb0w3V2t2TllPWG5mY3MxKzI1dnNXRkVVVkVCK3Jw?=
 =?utf-8?B?akNTQzZCTUloOFEzQUxMMHZrQVdHWWNyWlorSHYyR0V4VWR2NjhRYWV1SVEw?=
 =?utf-8?B?NDgzcThuZUJzYmxIdFQzMVEyWnNKUjdId0IwWWdBdmk3ZjA5MUU5TVdrbVds?=
 =?utf-8?B?aDFwL0lGYmMyRS8yQjBBUFFOaVBjT0dDUGIwc09MV1ZFS3V6U0ZyY3NZTzZm?=
 =?utf-8?B?T1BoYzg2OGJyZmVQNlNieWpuZm1LM3ZWc3pEUnFmYlhWTmIwaVFoYnA4OHJa?=
 =?utf-8?B?YTVBT01nUnNVKzJwRnRjcjZhNmhHSXlJN1VoYk8xNXlIS05lbUZ3cVRQYzEv?=
 =?utf-8?B?WjNSVnB4Z3Z5bWE4eVkzWk84dDFQeHBxbDJHWkdBNDBlWkV5ejV2enI5ZFc1?=
 =?utf-8?B?bkFoL0U2Z204Z21zKy9oWHNzZHdRcEtNdGYxRTIreFBTemhoQ3ZtbHVYVEU4?=
 =?utf-8?B?MEZsZ2NYeUpKYjdOU2FKbnJ2bnVDNXREbDJleHVQUHczZUJ0RDFOMTZwbHhl?=
 =?utf-8?B?MHEwSys3RGRneUV6QWIzYUtzYk1tV0U3aXQ5MlJ2WmVDUzNBUEF5eEg2S1E0?=
 =?utf-8?B?c1ZTY3dmYlZ6VVhIWXUwcG1TMEhqVnhYUFBxeGpBNTJMKy94YlRjQitGWjMz?=
 =?utf-8?B?cTluYmlydnljemI3LzBycUR3R0EwTzZUZVhpekNLbUZzVldsSDZ0MGYvNEUw?=
 =?utf-8?B?bXF3cUFWcDIweVZMWjljZlFkb0RBOVRnemhIb1V3dzgrS0FxdzhnQXpkYmhB?=
 =?utf-8?B?eFpqNWt1TUovNTR1UDJHWTM1R0N0Vi95bEtGNnpEMGN3R1dYVW10QXQwNlJB?=
 =?utf-8?B?ejZ4bWkvZjFCaURCMkxDZXNCejBDL0FqekpvUjZoc3ZTSmxrd0M1WW82U1FQ?=
 =?utf-8?B?TUY1U05zam5Deml5RlZVaGFTZUtlSmFkcXkwK1VacFNhMkFsdENlaTRzZlcv?=
 =?utf-8?B?bnh0cDdHYTRqM3hjWGE1MllSTG5IM3J5TXlJRTg3Wlg3Mk5aNmVmVHUyUlNH?=
 =?utf-8?B?S2RWZkJGdS85a1M5MWdSY05vb2dTdkRiWHRXMTYzV2FTNUdNdjIyaHlPeVJB?=
 =?utf-8?B?aUlvQmx4cWVQbUpmUUpzTU9xb3NhK3BGMFpYUW5EdURJWE4vTE1aOFAzeGE3?=
 =?utf-8?B?a244amtRZ2I3cXdoWXNxTlQvbEdIUk9IK080RjlRMEViOExWU3ZUN01EMmtO?=
 =?utf-8?B?WDVLSXArbmc4TFhTaDNQMHRVYkFxV1BLWnM1bndmK0ZQR1V0ME16cUhBaUNN?=
 =?utf-8?B?aW8zQ1pIaTFRTzlDVTh4dVJsQ0tkbVBudnBlRnkrSkRZUURLZmlsMFRVZU1q?=
 =?utf-8?B?UHQxZFBZVVV5aTdOTmpIU0NHK3JHdk44Q1ZIb2dZRFRqS3YwaWpRbUhENUVq?=
 =?utf-8?B?aERqMW82emFQVnhyNDVUMDkxN3pDZ1I1c0VyN3EyTU91OFUreUNJVXNrN2tk?=
 =?utf-8?B?RlVRQnArM2R0OXNGbXpBRkZTbWR2V0plMW40L0pOQVVZRGU4QlcrZEszOTU0?=
 =?utf-8?B?NGtFd1ZUNlJXNEwxZnEzcUNEYURXV1RaMlZqU3E4T1FTcGtsbnhHV1lxSW1Y?=
 =?utf-8?Q?xN169o5fCcDBwcet8wI5o6SGYQUuPI+dbv1cZbh5Ls=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 1aqXiJOfsrsVp41q3C0sI7lVuDuCMbJxqNpXhe85kqlVAPi0pweFO3Py2RDiYeYfA7Rys/g77dX9PHfkn0oIOca50di7Is7Xw1TGhtwB3iHTIvgJYdUKXQi88vAvVpumgIHm3RVND8YzX3z/HsAGhm9e6D3B9vyeuMEBIq2xDzuxzgA7piQDedt91cadHBqVLM/aem0fARwmWv9GEMG4ByT7Jm8i76EQYNb07iZNm4uwdLjsKULlJXBEkMzwMm8DWZBxaHH66x4x1ieH0AnKHKqcvk4uuiBHCGy31Uhaw+J0qERawng+XIKqpuKx5hPG/dvpEo77R4sJWWy2exwdA8TBOeSSZvtLyS2VFOEe4EYNVSxyHu8rVZyQOuEfLW50nddhWXdQPwQtRAU6GORALUo1w4IOkgWGbGkPfEQcjovm2wrwXEm+p8JsXvkLqq+3
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:41.9956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0bceb4-b621-477b-b1cc-08de5e7a5fde
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9052
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254286-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 138D8A2DEC
X-Rspamd-Action: no action

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 367b491ddf97..fbc514d582e7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -342,6 +342,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d95b5b8c1ffc..a0569e89f580 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3476,6 +3476,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5249,6 +5250,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9e91ddbc6253..5fe0e1d2c076 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


