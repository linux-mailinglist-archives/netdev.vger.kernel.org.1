Return-Path: <netdev+bounces-254303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BoKFtsgemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:44:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDEA30A3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F3233006105
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C98361DB6;
	Wed, 28 Jan 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZY2pvS+X"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD723D2A3;
	Wed, 28 Jan 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611480; cv=fail; b=RbqDbcM7ln2Z8JRG0BcKuwIT05P7gNLhZ2Q9vFmj6JNeK2tSTBQLKzWqfPVePHUP1j7jlN2tFY2qMmQjK/S9KbA6CrZvTJlBX2GQyWqTbCmncNGyMhetew+OULdvCCRLVRzWWJ+7mm5UP9mo1B3Zs/thwYMGkyHHNLXXXx9SSsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611480; c=relaxed/simple;
	bh=5LNox9qT0BDRyZ2FSiGtro3pwBRTC+PAuWI7/ip2wSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qGfLbIt2d9kZB9QKN5dFpy7FIhS+vcbIojojiToVumy8Cv4UfDsL/PFglk2dId3sdhydnREBpBKdBkYLAznv2uUijyh1oq6N1F/w5goZyCJoFHsC47tnd+s8BDDjsfrNxFrR7yAzYpde0IBjbgmIVuz59IyLZLvb3UaHeD87LoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZY2pvS+X; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbw0HvlWAYuVx1FaR03TVJD6OS9RPPLXKeCOsd6thozgCfctfU+BgAiSTxy0Vge7be8/NoGV1BSmj42EErX30VpafPNGysFcGushYpo54Y7EINdamwpnKjYyHbQL9EpwdnlTNfYnBsifD9RM+bALyIuqvWfGHUjvH7H4BjndPUqauwmP76wlJ4HJGpvvFCe/EY07oLeBOwoRYGT5v/bu5TaKBhhTiC20NuutTv45z0Mo7GVnEj1lP4YgPjxLqJfU7NsweEnliwA4PezZmeRmUiFvROMERBPu1bWPQa/pYl8oXf2rxutF0rpIsEuQLcL80hDcon22jFBR7Z5fkGFRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9btS462nZ6cuDSWraq3I0fGAkNTRHTIRyxLCQP1q2vc=;
 b=U3gKLkJy5OPG7f4o/+fDeT9c7FJMMvGl6/N0Rl2OmTkwikD3jQWzUW+Ob1/lW031rwxRxbc0WDqF5hSlD791MwXPgtmqO2oG1zxLNUYwcgYOqaabSAQ05SDEbgUF62EAXVrjq79cRffS9WR/r2I++5/9dR/h3ICCuhTJCoTchOgqfxlc1D4VFxIlpfPguvE+xV3dqn2cYPZ0l3LKJWNZDG3KpMKUG0BcU6RJa4A7dDM3OQYMiMvJGTAsf1CswCSBHaDYVf0Wpwjwm9CCVTS2ldEsnDZAOKye/zDye3v3bBZQTMBKShFaGxy8ZE45TKVIv8Pekexa5dg2E5UNUTZzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9btS462nZ6cuDSWraq3I0fGAkNTRHTIRyxLCQP1q2vc=;
 b=ZY2pvS+XGyGmZyMA2t7mnDIV8bIKaH3DENUSo7hbq3FprF82u62532IkwTMsHm+yMJlqTlnu699wWfMtL7RTM6PdsKUTRygV1RVfDwjDFCZdHQLgXzAkSgJUH4KbfBI22N96vr6mp8YChg4Se5LSOtgdjOxRLH9+0OFVLPUJrHUIe0rOLxZgLKEqp02inAKTBKK2u6+lyCxTRJ8EpvZhs1VKJVVqSsHyXKFgMsKpvNUmoHr12Dw7rWHSSVohOVRUi1EY5PkUxvALS3c6yEl7qO0YURZmaXXkIjC/A5QWNz4dXs7wbCt/tffr4UPzyf7wKE3TcMYjd5QWZMCV1NMl9g==
Received: from DU6P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::27)
 by FRWPR07MB10266.eurprd07.prod.outlook.com (2603:10a6:d10:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:44:31 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::6) by DU6P191CA0020.outlook.office365.com
 (2603:10a6:10:540::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Wed, 28 Jan 2026 14:44:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 845FE201CE;
	Wed, 28 Jan 2026 16:44:29 +0200 (EET)
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
Subject: [PATCH v1 net-next 0/3] ECN offload handling for AccECN series
Date: Wed, 28 Jan 2026 15:44:23 +0100
Message-Id: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|FRWPR07MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 8345a86f-a8cd-42b6-2bda-08de5e7bbf08
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TjIvM0I1RHBjZlNucG1UL2ZRWFFkbjIvdlUzOENIMDFWODdSOE8vNU95TTVK?=
 =?utf-8?B?SkJIZEdka3RPSDhxZWExWmY5Vy9rSlFNVWNqWDlDbWxpNjMvTEVQcGNFVGdj?=
 =?utf-8?B?djhFWEVadE1WUzNHQytKV0tHWE1qbnNzSlU1NUFnMmc0dExaZVVkVnZwemdW?=
 =?utf-8?B?c3ViTUpqU2tSUXY5d3hucWU4WXJ3ZVVXMkV4QmRZV1BXN3k4RXlEeHpaZ1Rl?=
 =?utf-8?B?V004L014OTloWWJzQS80QnFXOUlnWjYzdnJzQjUwZ3FmdUFvTjdDeEtiZ1cw?=
 =?utf-8?B?Y1NsbzhnMStzWGo5cXJVR1h5eTVHWHZUcVFPdGhISEJ0b21HNE1tN010dkJt?=
 =?utf-8?B?WTFqUzh1cWNOQzNWZEVBOFFidmdxN2tBb0UwdjZGakM5WmpKSS9DRFVMN3Uz?=
 =?utf-8?B?a0pkSHphTURKcnV5Y2pRa3V4QmNjVEI2bmo5U3dCT0RhSkVHY0U1SVNsbXJY?=
 =?utf-8?B?VjFFYnhWbUNGaDZaMEtvRUowMEN2YW1rRmR0OHRyYWdIQ2hHYnU2VXZLcVRI?=
 =?utf-8?B?bENWUTZVRmRHWkJXSXJ2QTEvMWRkTmw5NkFGbm4vMWRPVjR2YW9ldmgzZ0du?=
 =?utf-8?B?U2NRcTZWYjZhVk5RRURnSDUvRC94Qm9ESFJ3Tjd2RVYxUmhGT0VBWlVieHB5?=
 =?utf-8?B?aFhIZUkrRENZTklkWmtlbEhBbDBha1l5VG0zMjBhY1hSblVQbm9lWHBOM1Vk?=
 =?utf-8?B?WnVXclp5SklHZUJjWnlRNE96SGdJZTFDOWFWV1BpaTFoK00xMG42SFdwT1Z6?=
 =?utf-8?B?M0tGS3NYMndKVW03KzBmYXVjRjhpMDBYa2xlUk1HWU92RWJsWkljbXk5Wm84?=
 =?utf-8?B?SmNmaWNkQ0dkQzdyUUNBbTZDZW9lenpGVVJ5V2NCc1NSVHFZUUthTTF2K2JM?=
 =?utf-8?B?eEVJVm12NCttL2hzK2VUTnlZVWNDMHl5Q05EZGpHTUlTMDRoUzdiSko4TkIr?=
 =?utf-8?B?bTM2MVc0NmtDVGRQQkxzSWRrdVE0TFlONzcwV2ZzcEVKczJjQjk3ZDZVVHll?=
 =?utf-8?B?NXoydUg3eEdNQTk5NFFiWk9tR3liOG9KWWJpdkxXNWJzMXh2YXo4dXIwK1pt?=
 =?utf-8?B?R1NFaU9YemJWWGJMMlBOa05iNHVhU05tTU5USHp3MjBRSWpjZjJCV0YyNDFw?=
 =?utf-8?B?a3VVSFFrRlZSZEhWbDhMRHV4SSsxQkw1VHpKK2N0aFVReHp0clhldDQwM0FX?=
 =?utf-8?B?d1ZaN1dlSk4vUVo4UHdHcG5yWTNIRHo0L0E1R2ZQMm5pN2JiUUEvS2xPb2N1?=
 =?utf-8?B?dkJpMFM0M01nWWM0YlhOM1FTajRrWmh4RlZuUE15ZjQ4L081RkYzSWQ1YytN?=
 =?utf-8?B?cVB6SUt2b2dUVVJHMjdxMnduRVBSOGdOeHdoVUNYaStUb29KZExlUGFXU0xz?=
 =?utf-8?B?dndpM1lWeFFOR2FMeVJLUm5JN0ZuTzJtMWJUT2UxSGpmVFJ4Tk9XZnQwcFZJ?=
 =?utf-8?B?aDJERGd0VmRyOVptOEpUWno3cFQwNFprU2lFUlMzdmtLZ0wwRUZIcWNkbENS?=
 =?utf-8?B?UUJMNEdGa1lOUXRQVWlqdVY2Q3lISlBIWjVwaTdNdHduR01QMWNma2E0UmZW?=
 =?utf-8?B?Ym9kTXFLeDVCazVQVXBxUkdrR2REZHk5STBPK0oxbnRPeER4OFF0ZVVxQytG?=
 =?utf-8?B?WHFLN1d0V2t5VzNoQ1hQbDZHQWFtK3prbWErS2RtSGY0UjNhRm1vRy9zU0dM?=
 =?utf-8?B?T3o4ZlN1ME56RlY0bDZ5cjFlSjVjb2FWeUl4Z3VEZERjWThkNjNSQ1dCQlZn?=
 =?utf-8?B?RDBhNDhBcWk1NXV4cHFub3JOaG5PR3pFNFozczZVR1VzTkdwb1Y4VXFmV2tr?=
 =?utf-8?B?eUgvSC9PVnlHZjhvcFBvQ253SzIwc2t4ektuV2UrZVhvTHI3N1pPeGtod0xR?=
 =?utf-8?B?aksxTjgrMkZYYzFjU1REYm1VNXBLYU9VTUlDaGdCQlpYUHZHYk9ZSUt2RG9U?=
 =?utf-8?B?NDdDaVJ4cnl1bC9nRllxY2RFbjFTd2VHdXlYOE5xOVgyUFpmUm1lS0tXM2w2?=
 =?utf-8?B?SUsxNXhvRlNaeDJRZS9zdmhRSmk3VmdRTnIzcHdOYVFrbTdic3kzQTJINllv?=
 =?utf-8?B?THRPUk10MklneFZrWENZQmx4WFAvNWhYMjZwVEtIN0lzbHlQQW9IV3BFWDNr?=
 =?utf-8?B?NWJyUjJyRi8xbklDU1c1SkQ1YTlNMVJBaUo0Sjl6b3dNdVIxaVkxMEVHTEYx?=
 =?utf-8?B?cjFOZ0hrNjB0S1FoVmdTTnVOQXE5S0I0VHNlQXE4ZDFyUkhQYnpvdVFvZUlo?=
 =?utf-8?Q?ExPMF6IPbl3hoPT0zncGEyh38nO912cjDNEUApEh5M=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 u2dtFDMpq/2uD7D/KuXUBy8IAgoJnGRkhN/K6FgbVr4fNutXWiJ9zVXsl7Ak1//xAn+AO5JZcit0NVeVF2sR/2fDw5t1R9NILIdT7AdP6qSpLj5mwq86oxtYs6gShYIxW1a9m+zKCeBR1PDIJ5lXaW3Cy41NHBRu/3UA4y1Sl10jlbJ/t7iK4G5c21cq843pURvPLuyXN15SM+SpIBFPKNP5T2iQ5Tp8wFPXv25xNa3duZ3+scPxiXpBP1RIxNguHIzwgxQd8U24U2HHrlNz2x7MOZRMU48iIUTK++eUZInEtdaQ4M8ly5Ww38Tw9PBTPCj0TW8bnqo30hL9wZuomriNF2Gik+gVM5d6eO9MZHlSBK3GCUEbb1BrUquabF07xrMhyf85DqpB/uxv0H/iSb446WurnClXhemdLpy0/7eoQ1B6Hr0TTyGkM5eRNrZM
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:44:31.1114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8345a86f-a8cd-42b6-2bda-08de5e7bbf08
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10266
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254303-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8DDEA30A3
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v1 ECN offload handling for AccECN patch series. It aims
to avoid potential CWR flag corruption due to RFC3168 ECN offload, because
this flag is part of ACE signal used for Accurate ECN protocol (RFC9768).

Best regards,
Chia-Yu

---
Chia-Yu Chang (3):
  net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
  net: hns3/mlx5e: avoid corrupting CWR flag when receiving GRO packet
  virtio_net: Accurate ECN flag in virtio_net_hdr

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  4 ++--
 drivers/net/virtio_net.c                        | 14 +++++++++++---
 drivers/vdpa/pds/debugfs.c                      |  6 ++++++
 include/linux/skbuff.h                          | 16 +++++++++++++++-
 include/linux/virtio_net.h                      | 16 ++++++++++------
 include/uapi/linux/virtio_net.h                 |  5 +++++
 7 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.34.1


