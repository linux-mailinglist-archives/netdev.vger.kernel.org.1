Return-Path: <netdev+bounces-183903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE3A92BFE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5319E7BA1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3D1FF7C5;
	Thu, 17 Apr 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fgPvjA7N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B014885D;
	Thu, 17 Apr 2025 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920022; cv=fail; b=A/VJBiC8Vg8SZ1/Sa9ex57Zo71Uo+tSnY7H4s+pLskAfSTDhZa8S8O5zTN8l8Z696/F/Y7aL/0G13BJYBTac9W1VaRCUvlCqASFaXB50dJhvAE/ulA9wDKtu4jhPxBXfSIJB8W6teAHrrCqiRFrxU1tcOrLyAeHhTnUNAKFEaMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920022; c=relaxed/simple;
	bh=PG92pXDY05/72MVOqCtbwlDzwBTmvlLtYMeaAbsPqOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxfSSrXzEjXH3yc513Bc6l6TctZWQeHUCXKBa2XoL6kXbtEMXuItoBgO9ORyQvhaz+rNCD7EXAiVh653bOF4vhc9/iLGIbyneLTLDBKcjEsplnKUKcoVp2bkaB3ZZ61ABRENyKLPOBvPiQD2sHI/gPtaOucReLoyDSFog1khpRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fgPvjA7N; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJRInt012990;
	Thu, 17 Apr 2025 13:00:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=PG92pXDY05/72MVOqCtbwlDzwBTmvlLtYMeaAbsPqOA=; b=
	fgPvjA7Neg+vpFBXpQztID8qchLGpJu5+1Lo3u8Vpd/bpE/qpVvDst8jcgXDevIZ
	1Lsg5DixhpmV6XsJXW2rOXksw2HlbA0o0HBRoGEZKiE8BKVCE0cNkWVo0kNC64Of
	UYsndx5Pbeyj3Wtzv5jkdu9pKUZXlAg3sg6p+x9w3bCtN89OzCT3lDhWxAXl0rTx
	CiozBB8LaTgy8qIYrwSoy7SYBMzmCCRuYEEVtiQF9I+/zn1eh22AEnteE+7SvRnB
	QQLrxVRes/5BckjVGdTdm7/6dQ4I8dKlMb8eRhpTE6pE0EFG8IFSydet2JnDzgB1
	KxLDGH6E1+vs34FfrM7XHA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4633jp2xcg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkS3FgLU+dDYy70J5JJF5Cig3ndWCirX71umUL49hK86lLbC1UMUSoEQBR4XPe3L6p1gjkbLboyKFaW8xmmAe4yJmvK0Qa3vZzyzKM6wpWJRwFSWMhULFr06uNwpD0xasLR5qdNJazfU5I1sBTJgSk52kLY/I/xjW6eA6dZxjwGVydyt4UhhbFAVTQcrZpJHgP5u5L3I+V/mensAUJQ0dKsZUD9JDxeV17xgrmlmTLcJ5dKCclOROpMrn0qVfyYM7IDqv10HAxZYEK1aTh3uiqTtZDM46geWkIRE0v64jH4P+N5rEPHBivcIEEnW0xvruvD7NkljK5hbgGCWxYJRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG92pXDY05/72MVOqCtbwlDzwBTmvlLtYMeaAbsPqOA=;
 b=St6LT/n2aQulXhbiaUagXictXdEMTWG2s/I14Le8cSp99ulaamwL2CV0Uddur8fbVAVsIKFM9+0muUkEKpdPZPe1sjmD/A57u7Ugl8lzRXBhn066LImblujr/tIsTIRYbioAXCLqsEvFBO8VqV9StwospkQ7rCAmLAIR7goCpjhqs00FzJAbT3ybKSS83Onj+lL5udA81bFx+wJdpRIR1VidS7Fsj2uHnVE6dAXoNinBMWeILslqxN7SFgU+VnBqACXNa1xUZi4mtPcLrkzv8HX6R5BB3H5LiQJ8iK0Nd5NOBGcycYhbPr+CFlDRmsqvTbThS+nzFAOa9sozJ1izPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BL1PPFF6F37B74B.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 20:00:13 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 20:00:13 +0000
From: Song Liu <songliubraving@meta.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Paolo Abeni <pabeni@redhat.com>,
        Breno
 Leitao <leitao@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami
 Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Thread-Topic: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Thread-Index:
 AQHbrwUHpR08jPFxa0WeDmIG+BoIGbOnbecAgABNhYCAAByQgIAAJ1EAgAADEQCAAEY1gA==
Date: Thu, 17 Apr 2025 20:00:13 +0000
Message-ID: <B5B46BE2-C4D8-4AB8-BEBC-E0887C9B175D@fb.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
 <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
 <4D934267-EE73-49DB-BEAF-7550945A38C9@fb.com>
 <680122de92908_166f4f2942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <680122de92908_166f4f2942a@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BL1PPFF6F37B74B:EE_
x-ms-office365-filtering-correlation-id: 5250f19a-a6a4-4490-a4d9-08dd7dea776c
x-ld-processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXgwYUtvT2wvRFBWblVlMVc1d0hNemRMaGkvS3U3R1g5QzNJRERNVEtHUEE2?=
 =?utf-8?B?aVRLaGJ2eUczQUo5NHpicVhuQ1doMWFGdDZKTkRHUEdhVHI0dXRkTzdHTTgy?=
 =?utf-8?B?WDFSNnhhaGxtdEdPdEFHdjVUbGhHcmxuT0RJdGVYekpoZmlJcys5VkYzVDIv?=
 =?utf-8?B?L2JncVBuWGtrN1pHWVh5Y3lPODZUN3JQd25iOW1ZTnFkd0NEODk1VHRHZXhG?=
 =?utf-8?B?TFlyVnRETlY1VUd5TmN3MU5wQTVYYkRtYThlY0VoZFBzVHJZbDhkaW5LeVF0?=
 =?utf-8?B?RUZvemx5dUNZU1R3emQxNGJTRTFNN0p4cnI2aXoyWjJYYXp6d1Q2d2J0c3Qz?=
 =?utf-8?B?SFVmZHJPYm0rNE1JWnovQ3d6Qmo5N2o2VG1EUWJvNkpMSDdJZEdtZ2dvVXlq?=
 =?utf-8?B?Qm9OYW10UVhFSWw5M0hCN2xhR1o3OVNSbEpFZjFCR3Y3VFM0LzA3QVM5K3o2?=
 =?utf-8?B?a1lSWk02QXhXdjRXYk9DNWZ6ZEJwTUFUNm9JbFFsNnAxNDE1enZtdVMyRHNi?=
 =?utf-8?B?UDNGaEhsc3JWOHFYSW16Yi94RVN1Q040cXI0N0ZDaWlzbTkrTEE4cjdjYjZU?=
 =?utf-8?B?WGVUL2g0ZWViZHdwZE1Ed3FkRm1zZmxOQTl4VXRWNHB5V21jTWp1M0lKcFBw?=
 =?utf-8?B?UkVKQXgyTUUvQ0lhM3ljcEFCMXRyMDZBUmZOQlI3OFFXNTBWZHdNYWhWZ3lF?=
 =?utf-8?B?MjVqUzB0WWRWdkIvamRlZnpleE0xdkNFSXNnOENtanFTRnRWSWJYUGJzbzF5?=
 =?utf-8?B?elB2a202ZFJIbi95ajFtMzZZNVE2ang1QUFXaUpnelJacEt3QVVoWFM4ejdT?=
 =?utf-8?B?Snk2NS9CQnNaMnF4bzltNVZoNE1NeEFNNzVLTzB4NXUrUGw4V1BRcW9OSno2?=
 =?utf-8?B?ZUZyY2FNL0FmUW1IY0t0a08vUllZeW5vaHpIVGdPTVRGQzhmS0hNMGpnbENX?=
 =?utf-8?B?eStDWktuSXN2VVlteHFFU3hYbStZd3ZEcEIzNVZnMk9pdHN5aGFCaStmdVlh?=
 =?utf-8?B?eEFDcEtGZnJSYmZ2L0lONHJnZ1dDYlh3WXlkbUR2RHdaNHRUbFZxMTBlWjZE?=
 =?utf-8?B?OWRsMElqZ2l0T1V2YnFDUC9XY3VJVzA1RWlYUlFZeTdPVXpWRnJvdTc1U3h3?=
 =?utf-8?B?YUNlYXJZQXJtWXZmV0EyN0JSSDJEdHUrZGtqVzJmTUlwRC9PRmRWUy8vSjB5?=
 =?utf-8?B?ZU5VeWl2d2ZRMC9JSW5jaUlKaUd2YjMyRWRpVVBGWDJLaHVITTJQb1NvVmR4?=
 =?utf-8?B?dVNrb2JBR2V3aysrRDVCTHFpWjNwMW5PenplUjBzOWpac0p3QkRNeXVzNkc5?=
 =?utf-8?B?ZFZMNHZUM1dpZU5ITWQ3RFN4QjdtdXQrUFN5NkJ6b1R5OXM2aHluUDJLclNu?=
 =?utf-8?B?UGFXYUtrZ1BtV0M0VVY2SlNIdHQvSGdXbkFIK211Uk9iaHl4OXorTkhSNitE?=
 =?utf-8?B?ZkNyU2E4ajJFaGI5MTAvUVpkUmRWenJKQWd6MkVROHIxQzdxVmRLaDI4TWVT?=
 =?utf-8?B?SUh4UHpCSHJEL09SeTY0TndLak81c3FDcGwwbGlJWjBrN2VhUEowQU04ZlF1?=
 =?utf-8?B?NWN3czVlblMwUWxhOSs4TG9aalh1Vk9ZWFVkUTFTQmtyZ0xCZ3phNXVJYUVK?=
 =?utf-8?B?bDVVMUtsSXlFSVRDZkVGQXFVMkRadTZRSkg0N3hQT3lFRkxqdHB4YStrNGxE?=
 =?utf-8?B?WC9BT1oxNkhvVjAybW9sNk9DWEI5WkN0aGtLN2FPUlpJRmowN294bDIvcEZq?=
 =?utf-8?B?T1lNaEJON29wcVhCWjE4S1l5UmYzeWtnaUdoeWh2VWQ3YThDQm53ZXNKRkcr?=
 =?utf-8?B?T0VmTVpxSXJKbU1kOGg4YnlPaytzOWJwYmlQcWxaT3hFWEFMd2x0ak9nNjNX?=
 =?utf-8?B?YnAwS2ljcFUzbjVYSUdZeVJiUGIwZGh5RWd4YnVldytETmRkTE5nQmFJRmx2?=
 =?utf-8?B?bjJGVWFRVzdUK3B6bTlFMmN3allHVkRWRzU3aFdqbjBZOENwQVQ0VU1NcGFt?=
 =?utf-8?B?aDFUcXFGN0R3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFBEYlBtU1c4RTdPUGFnSEZJNkNIcUpjaGFNYmI5d2V4NVFnaDhpUDV6d2s4?=
 =?utf-8?B?Wi83TkcwWUx6MlBhZFVpZ1l1Sk1uUW1wNWlYdFFodElCVTBPMXY2ak4rMWJn?=
 =?utf-8?B?OHJPc29EbFpJZ25MdWswb29nalNtTFk3MVhxSERFWi9seU1GYURZNXZjWi95?=
 =?utf-8?B?YjA5endETW1KMC93VkhOY3lyL0h1UkdJY2kxbUpxSFc5SVQzWjgvVG5JTkln?=
 =?utf-8?B?OGw1SXlPaHR4RGh3b3N3SzFldlVNdUhLRWhyYmlmamtTeW1SdDhjZ0l3Y2ZH?=
 =?utf-8?B?Z2xIUzVWb1liRkErcXBHdGxkM3BEUi9ZVnNjRjNRY3hWTXU0NjNIUWgyanBS?=
 =?utf-8?B?UmNSTGFDcW1qSTVON0xrMnU4Y25GZzByeXFpN3ErbmsxWTc3aXVGVURzV1dm?=
 =?utf-8?B?SStJamQxcndUQXVlcG5qWE9sYlB5MHR3cURvbDN6YWdhSkhtQW5IVFkrZjNt?=
 =?utf-8?B?Z0FrWnhkbWdjZit3ZjFVazVMcFRrRDRtakhheEgxbjFBa2QveTM1VE5BYS82?=
 =?utf-8?B?TjUyNXNyaHZzNlZnUHN3dUZsOTlwV1RrRmZ6dTBENmZrYW1mWTBUVWl6MG56?=
 =?utf-8?B?TGNoa3dHdHJzcUJzVnF2UmdyN0VQVC8wR0EwQTQxYnAvRmo0RG1OeWxmRlQv?=
 =?utf-8?B?NXdTOXR5WmpSTkxjN0F2b2RPbGZxbEY5cm5Lek11cGMrRnRVYURKTkc4VExH?=
 =?utf-8?B?M2phL01ZRUdjTVZaazJDNnVSWWVBUzNnaUwreUVGdUpqV0ttcUYzU0xtQnVr?=
 =?utf-8?B?NWp4VjNMNjdmWVRBbHg4V2QxL2NNV21OdVd0Nlh3NXJJWFdiT0p6V25PdDYy?=
 =?utf-8?B?SnJwWkdDcityTzBWdmZ3WUVONU4yUDUrcWRJaVZWdS9uZXVGcVkrQVhkL0Jm?=
 =?utf-8?B?M0Z4bHl6dVNqOW52amdGZ0tkb1V0eElGenBzVGZXQXJZNy9RaVVvdjNMR2Jx?=
 =?utf-8?B?S0QwVGtpc0VzNUppUWdUN1JreXE5V0RHSkRwQitNNjFXY05zYitoaUp1bHhs?=
 =?utf-8?B?TFllRjViaGRtamIyc3ZZTW0rZWt3QkpyTkRTT2VlQmRHNmhvcWFYT3ZFTUI5?=
 =?utf-8?B?UkNFWVZJSTZxODlvdWdwVHpwZTZqdnEydHFRVkZSbHc0UEgwQm0xSDRwcnlN?=
 =?utf-8?B?dUlCM0JCQXU3UlpObmpJcHhCQ3IyNkNEdkNpcUF2MUtSaFFjV0pHTGpTZFhx?=
 =?utf-8?B?eWcxRWg5a3hTalI5L2t4bVVQZUpiQisvTWlHOThyOE8zcVJUOXcyVDRnRmdD?=
 =?utf-8?B?YVNJZlRCblVqWU94SXJIYWU5dnNKVnN4emZBclFuVkYvZlN5a1VjTUgwaDhN?=
 =?utf-8?B?UUhvSkRGYlhFL1FpZmZJN0ZsTGp6VHJkVjRqVjk2UFgzV1E4UmlmUDZLZ3g2?=
 =?utf-8?B?Ry81Q3JINnNDOHA5dlRDRmFTaWFlZ3VwVUNwQkpPK2NETnh5MGtRejFTcFd0?=
 =?utf-8?B?N3BCM3UvN1hBQ0h2cGViTFFnUGw0ZDB3VUdITzc0enRnSlU4cklXd2xwV0FH?=
 =?utf-8?B?RmNoKzlyLzJERGJRUVNtQ1oxVDlReUNNK0RGVGRIZjFKUlRZS29JcHF4ZWd3?=
 =?utf-8?B?bnU2RXUraDBOSTM3L3RSZEJBb0lTd1prSklhcmxxMVhrQlRLOTJ6L3FlZjBN?=
 =?utf-8?B?V0NPbDlnR3N2aERiQ3VxZllGdmt1U0MvQmswTjdvL013dGVFNUdYT0Q5R2FJ?=
 =?utf-8?B?SHFEdTlHSzRqRUozYVhPcnN4eG5sd0tobjJUL2lGcittVWRBR3hsRnlrbXpm?=
 =?utf-8?B?SlR2b0s4NUt2STdHN0M3RFQwcWJZamE0dDFuZnNBUUdzOTZwNEh0WVltUmIv?=
 =?utf-8?B?cHczeEdqR08vYnRPZ296YWhuVXluM2V3aHhpa3hPRVVwOFptSk9yanVnMWhu?=
 =?utf-8?B?dmxnM2FlUHRRVDJOcjVOcUNjVFl3N2pnR1JSeWxoRHplWHVHVndlM3M2ZzhP?=
 =?utf-8?B?Z2hmaTdZdnp0VGdkdWZOR3JWWHprWEc4TmZiWVkyMDJNNVlYRytDWFc3RTAw?=
 =?utf-8?B?TmFxNllZd1lhRVFqWm95UEp6QTI4eEJhNTU4dU5UZFk3NUVaMlBEZ3B0enRw?=
 =?utf-8?B?cFhCSTVkaVdlMzh0eWJFcGRIa3VweTZJdHRPNGdOckliZUlHVHZic0ozTWFh?=
 =?utf-8?B?a29ZdjE2OFc3WXBuaXFtcE9xL3hoZEN5WCsyZXo1QjltcklqRGxJdzN5U0NZ?=
 =?utf-8?B?TWZXOEFzYUhiejNJRTQ5YXZwR3J0UzdEY0hyR3k3N0xqek1PRWZiSTc4T0c5?=
 =?utf-8?B?RkNwd25yQ0hQbi9ZMWRuMXZMbVFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D1D5B7B2855744F81E2CB6C6518E81A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5250f19a-a6a4-4490-a4d9-08dd7dea776c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 20:00:13.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDEwiT2YE0JwqGr9U2O5dQdCA3+pverp+SENgkaa8PVU7QjeVj+l9bRnFaHsJHNQcE9XBJmYiMHjGvqLwyVhxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFF6F37B74B
X-Authority-Analysis: v=2.4 cv=QvVe3Uyd c=1 sm=1 tr=0 ts=68015dd3 cx=c_pps a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=2vkfRT-M2VwAaVMp708A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9pF1F9GgQHCPAJxG2MpQ6XyTHmUyhzoE
X-Proofpoint-GUID: 9pF1F9GgQHCPAJxG2MpQ6XyTHmUyhzoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01

DQoNCj4gT24gQXByIDE3LCAyMDI1LCBhdCA4OjQ44oCvQU0sIFdpbGxlbSBkZSBCcnVpam4gPHdp
bGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gU29uZyBMaXUgd3Jv
dGU6DQo+PiBIaSBQYW9sbywgDQo+PiANCj4+PiBPbiBBcHIgMTcsIDIwMjUsIGF0IDY6MTfigK9B
TSwgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiA0
LzE3LzI1IDE6MzQgUE0sIEJyZW5vIExlaXRhbyB3cm90ZToNCj4+Pj4gT24gVGh1LCBBcHIgMTcs
IDIwMjUgYXQgMDg6NTc6MjRBTSArMDIwMCwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+Pj4+PiBPbiA0
LzE2LzI1IDk6MjMgUE0sIEJyZW5vIExlaXRhbyB3cm90ZToNCj4+Pj4+PiBBZGQgYSBsaWdodHdl
aWdodCB0cmFjZXBvaW50IHRvIG1vbml0b3IgVURQIHNlbmQgbWVzc2FnZSBvcGVyYXRpb25zLA0K
Pj4+Pj4+IHNpbWlsYXIgdG8gdGhlIHJlY2VudGx5IGludHJvZHVjZWQgdGNwX3NlbmRtc2dfbG9j
a2VkKCkgdHJhY2UgZXZlbnQgaW4NCj4+Pj4+PiBjb21taXQgMGYwODMzNWFkZTcxMiAoInRyYWNl
OiB0Y3A6IEFkZCB0cmFjZXBvaW50IGZvcg0KPj4+Pj4+IHRjcF9zZW5kbXNnX2xvY2tlZCgpIikN
Cj4+Pj4+IA0KPj4+Pj4gV2h5IGlzIGl0IG5lZWRlZD8gd2hhdCB3b3VsZCBhZGQgb24gdG9wIG9m
IGEgcGxhaW4gcGVyZiBwcm9iZSwgd2hpY2gNCj4+Pj4+IHdpbGwgYmUgYWx3YXlzIGF2YWlsYWJs
ZSBmb3Igc3VjaCBmdW5jdGlvbiB3aXRoIHN1Y2ggYXJndW1lbnQsIGFzIHRoZQ0KPj4+Pj4gZnVu
Y3Rpb24gY2FuJ3QgYmUgaW5saW5lZD8NCj4+Pj4gDQo+Pj4+IFdoeSB0aGlzIGZ1bmN0aW9uIGNh
bid0IGJlIGlubGluZWQ/DQo+Pj4gDQo+Pj4gQmVjYXVzZSB0aGUga2VybmVsIG5lZWQgdG8gYmUg
YWJsZSBmaW5kIGEgcG9pbnRlciB0byBpdDoNCj4+PiANCj4+PiAuc2VuZG1zZyA9IHVkcF9zZW5k
bXNnLA0KPj4+IA0KPj4+IEknbGwgYmUgcmVhbGx5IGN1cmlvdXMgdG8gbGVhcm4gaG93IHRoZSBj
b21waWxlciBjb3VsZCBpbmxpbmUgdGhhdC4NCj4+IA0KPj4gSXQgaXMgdHJ1ZSB0aGF0IGZ1bmN0
aW9ucyB0aGF0IGFyZSBvbmx5IHVzZWQgdmlhIGZ1bmN0aW9uIHBvaW50ZXJzDQo+PiB3aWxsIG5v
dCBiZSBpbmxpbmVkIGJ5IGNvbXBpbGVycyAoYXQgbGVhc3QgZm9yIHRob3NlIHdlIGhhdmUgdGVz
dGVkKS4NCj4+IEZvciB0aGlzIHJlYXNvbiwgd2UgZG8gbm90IHdvcnJ5IGFib3V0IGZ1bmN0aW9u
cyBpbiB2YXJpb3VzDQo+PiB0Y3BfY29uZ2VzdGlvbl9vcHMuIEhvd2V2ZXIsIHVkcF9zZW5kbXNn
IGlzIGFsc28gY2FsbGVkIGRpcmVjdGx5DQo+PiBieSB1ZHB2Nl9zZW5kbXNnLCBzbyBpdCBjYW4g
c3RpbGwgZ2V0IGlubGluZWQgYnkgTFRPLiANCj4+IA0KPj4gVGhhbmtzLA0KPj4gU29uZw0KPj4g
DQo+IA0KPiBJIHdvdWxkIHRoaW5rIHRoYXQgaGl0dGluZyB0aGlzIHRyYWNlcG9pbnQgZm9yIGlw
djZfYWRkcl92NG1hcHBlZA0KPiBhZGRyZXNzZXMgaXMgdW5pbnRlbnRpb25hbCBhbmQgc3VycHJp
c2luZywgYXMgdGhvc2Ugd291bGQgYWxyZWFkeQ0KPiBoaXQgdWRwdjZfc2VuZG1zZy4NCg0KSXQg
aXMgdXAgdG8gdGhlIHVzZXIgdG8gZGVjaWRlIGhvdyB0aGVzZSB0cmFjZXBvaW50cyBzaG91bGQg
YmUgDQp1c2VkLiBGb3IgZXhhbXBsZSwgdGhlIHVzZXIgbWF5IG9ubHkgYmUgaW50ZXJlc3RlZCBp
biANCnVkcHY2X3NlbmRtc2cgPT4gdWRwX3NlbmRtc2cgY2FzZS4gV2l0aG91dCBhIHRyYWNlcG9p
bnQsIHRoZSB1c2VyDQpoYXMgdG8gdW5kZXJzdGFuZCB3aGV0aGVyIHRoZSBjb21waWxlciBpbmxp
bmVkIHRoaXMgZnVuY3Rpb24uIA0KDQo+IA0KPiBPbiB3aGljaCBub3RlLCBhbnkgSVB2NCBjaGFu
Z2UgdG8gVURQIG5lZWRzIGFuIGVxdWl2YWxlbnQgSVB2NiBvbmUuDQoNCkRvIHlvdSBtZWFuIHdl
IG5lZWQgdG8gYWxzbyBhZGQgdHJhY2Vwb2ludHMgZm9yIHVkcHY2X3NlbmRtc2c/DQoNClRoYW5r
cywNClNvbmcNCg0KDQo=

