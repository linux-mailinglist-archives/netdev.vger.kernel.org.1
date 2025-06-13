Return-Path: <netdev+bounces-197635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0EAD96AA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5543B23EE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB742397A4;
	Fri, 13 Jun 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GxUbBjjA"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C01EEA47
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847934; cv=fail; b=YFcRFMSc/3K9qwQjXkFmEZ57JgQJLXrPTj7YABR8dCYa6Ft+RxPr4zD2UCiZDb1c0mZtsi21p7AwPZP30gx6Xy7H/6PuUyNnBIk5jpcVSa8NyWNV87O8XaRPGEeHJ5kP2k4QTkzGuAW3lgyXKirSAJtNXpNKIH7227P7QpJeXBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847934; c=relaxed/simple;
	bh=EmiFKFjIOH3+kDFjRyMHkR/tb6Po6Q83oApd2fCgA6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QtO3mObmCwPiVzAo5KPhHaDbpDpKJw5Ikv5AKP9kBkY8WcYG3ZFsggLrS7U000297usGXsbI+mzKh2XpWIUSeMU/8LXixWGqDqlsHPdJwLB0URH5TqmI03FMXEZ6tkWS/pm1HllBaREaVHqxSLRL4/T2LyExWXEghLhBWFYlFnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GxUbBjjA; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAflm/4R5jow9BCsy0DiZgjEnyhtBuRM1fdpyf69qJ+5jpkc+X7UFayHVV8AiNEe8B1DHkGdJdMN6yQYaLeNQRPvtNW8mO38R8dIEAKSIkM1u+iz55IXP4fclQr08j4Mvi2WfMi/OYXalDw/bm43Uyc9rlUS0ST6QFIwwvn8YTWMI2gFHOQfOEQ67QRZkbVUKPBscQsaayLdoX2TKGkWh06dbf33JPzm/X+9oapBzeqvfJrdapUxag37j8PyAk9E+Rahdf3BxvRfHrkGS3j924g871HWIVQ5Zf/Bd2jkkjPqNnB/2NvXZmeTXCk2PsqsqnIfb4rT9ceXTDo8hNtUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtLF1U+Dqk8iyv0kmukFs3h2ov1vznWzCGluwubTUfQ=;
 b=iPZECACpO913GYmCeoOVaEOySWbzkk/Wfq3xlYOxDEe8vBv1vYM3+C0za0+fBpH8/Q/8c3z9F9qd5VZsTp8U5G9KNpw+exFmuBFj0UUW6KWq4u0PDNRN1HOrs4+JPviw4BwJGwr1Sfh4plDufKX8PsE48QCDoXZQFuP/OCU0kiql0QCxlk1uDa/+Vpc+r0Tjr7AJqsJnGuA7mwV5dbzSEkvM4iG54cAZ43WGyjCWSSobDR9RqCKfh7G8+XriK6x5GDiLI4kHx9pty8KCxf9Xt+w06BWcaVzDN5jIs9+4NSATBQVLCtm84GdAKGb09lCjzp/gj6i7KvdA+X2JonoUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtLF1U+Dqk8iyv0kmukFs3h2ov1vznWzCGluwubTUfQ=;
 b=GxUbBjjAmVj51UkPltPZjGl16ghGs3Oa5aigd5BJ5FficEAx0WyzLG41XBDpVzLxyN4XyyHN4LNbXrlh9CJ1IcFo4ULfqC0i0SYbKJsjFXYjxlgOntXM+p0+6F/VcRKAjLwSAoFNVaqz6hS6e44YoaxGR2BYqq6OIXxi7Os0EH50Qewk/A1cdlmvSXG8n6nPeSm/X0hRd4DgvkicEbY8YSjQtq2scbjwADKbHtjeQEkrMtEBKELw/4nZ/+5Ml3QctDrj8VSAuF7UlMl/GzFcAbX/XwmG99PLUVJaMxtncIGSmzSNRxkeB0BtyORqbgDtQmFEdkoQbiSFLI/9YOIkxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 20:52:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 20:52:09 +0000
Date: Fri, 13 Jun 2025 23:52:06 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, vinicius.gomes@intel.com,
	jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <20250613205206.fssf4bi4wjgyy53x@skbuf>
References: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
 <aEs3Sotbf81FShq3@pop-os.localdomain>
 <aEucrIuj7yxTX58y@v4bel-B760M-AORUS-ELITE-AX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEucrIuj7yxTX58y@v4bel-B760M-AORUS-ELITE-AX>
X-ClientProxiedBy: VI1PR06CA0185.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 38689fdb-1903-44ae-6bac-08ddaabc29e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c090MFBUanNGd3F2Umw3RTJUZEdXOVZwdE0wY1NNY2hqWDhWYVpwcG9BZXlR?=
 =?utf-8?B?akd6R003REc5SmdFbDNjaThONWM5eTcyWVczZjB3Q05aYmVua3pKVDBrQ2th?=
 =?utf-8?B?ZHA2Qy9ZV0FnckRkVWsxc2tVU3l4eEZMdnBtR0NiclBTWUluVzNLdHdISS9W?=
 =?utf-8?B?QkFVUGxSQ3Y5S0RUYXoxSXlhUGg4NWtqTzR3eG9kTmpLVklVZ3MvemUvNk0y?=
 =?utf-8?B?S1p4OFd1azBsODVkWFlTRngzckVYYU9JTG9iOU91NXpzR1RjRVJoTEVPb2V1?=
 =?utf-8?B?a09QS25qWk1heDgyb3RVWXQ0TnZXclN6Y29JSjhYdVozMThDaHlGTTRqYmJo?=
 =?utf-8?B?MTE1V3psRFFCbFNXTFF0ZFNmRzRxRTYrRkYrRFBvTFg1aitETnByZEtxb3Ev?=
 =?utf-8?B?cGxCVmE0N2FRKzl6KzdidnA4QnpjZmxDUHNuMHJnZm50QkViclVTR054aTF3?=
 =?utf-8?B?bGY3NlJQQWJ0TWZNOXFJcUVBbXJOYSszaXo3N21va0hKV01ldjc3bEp3N0JC?=
 =?utf-8?B?ejQ0T09iZDZVV2tJQ1ZhR0swNCtrUmIvSTJRS0paQkcvUU53RjludGxHSW1p?=
 =?utf-8?B?OVlqbFRxdTc1K2llRWZLRllLQnZyc1NyYlFWdkE4Sk1VUXlBd0d4T3Q4VU1E?=
 =?utf-8?B?WlRQWEQ5VXZPRm9jSXZqK2pTZ0cvWFpRK0hWakdoa3ZyaFhUMXdIcHlFMitk?=
 =?utf-8?B?ZHVZc2h2RlBJRENWOENrRTROV1ArRjZ3eE96YnFsSEF2TGlQY1o5WDdtaXdV?=
 =?utf-8?B?UUxSNmtTeUcwY09RM1ozNzR2UjBmYi9UQXVpKzNoa2ViMzBxby9mREdIS1o2?=
 =?utf-8?B?ZEc4M3pwMTBxL0pvR1l3ZlVlcUJuNWNlZzRuSC9sK3o3T084dTRtY1ZLbllo?=
 =?utf-8?B?YzhTeDhLZmVqSnV1YitrNkVBT2htNUVyMVQ3VWhaTlQzc0tLV085TEp2S2l5?=
 =?utf-8?B?Nzl1cHUzNGovdWJBZldBUTdvTGFXM0xRV0ZpbE9GaEpMUnpkNkllMXZpdVQv?=
 =?utf-8?B?R0ZsRFpwVG03SWJqOUVlT0pBc0RURVpVcmZUUzIrOFVOV2p3Tld0a1VRYVhm?=
 =?utf-8?B?WWdDV1luZ0p3MjJPeW1Cd0lWRmFOMUZiV1B3SFdQM3FoVlpFK1JRVENvOGhi?=
 =?utf-8?B?b212WHFWbFZITTRSZHdWSklaLys0T3pjMFhBTWdVd20zUW9xUG9VbUI4dlBh?=
 =?utf-8?B?OWd4TEREc2VRbng0QllYL1g4aVAyV25LQXRySkdLdkU5OFZCUXZjT1VFZFhq?=
 =?utf-8?B?ZUI5ZlppZlpvZTdVa200b1E5QXNMUnhQbnIwY3dLazRmWmNHTGtGd1Z5bmFL?=
 =?utf-8?B?Mm1BamQ2Z3FEWlFPeXJCRGVqNGp3cFFab2xyak5mQ2Z1bUZFM2ZYRy80Uk5y?=
 =?utf-8?B?aTlXOFg4UXM3VXpLalFBU01RU0RnZXRreitwdnFERTlQdWhtZU1yY3ZZb3Jj?=
 =?utf-8?B?K0JSbHdXMGN1NU82cWFoZGpDTFAreE94d29hSzQ4WjFHc1Z5MUNwOWhMSFVx?=
 =?utf-8?B?MThzSStVQnZqUWpzUW9XT1kzZ1NzUGVlMUZWZUZRem9UTkJPVDFoTFYxSnV5?=
 =?utf-8?B?ZkZBblRKZlNtaEE0MlBMeDQ3WXl6SEIyVEdZWml4d1RhNHBXTmVJb1BURVlE?=
 =?utf-8?B?aTVPbC84T044ZTBQTVQ5UUZWS3VubkxlQmkrWUNubE85ajZHYzcrMnBkRm1S?=
 =?utf-8?B?WWpuOE9JL3VjL25XUFlBN3cwckRpVjhrMmRBOUdUZ1dxY25GMTRMZUdvSzE3?=
 =?utf-8?B?b1JWRGZFRFp4bUpybGJWaE9laWNMdU9DeGpDdjQ5VElxZmVkbU1iWGR4OUhH?=
 =?utf-8?B?OC9oMVYwTEY3elJlZlRiVDNxNGdnUENkdCtsaXEydWEyVHE3VDZrS0JIdkR2?=
 =?utf-8?B?bEVZYjRGbGVoVWovbTVVaDdJR3dvU2tZMTVMUFh2R2Y0VzFWTGlzR1VyUTJw?=
 =?utf-8?Q?9sOadgzZ768=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9XSitodkNXZ0xhM0FTenEydGduR01vcGNIVzFtZ0JGTEd3Rkk2ZGxUbXRF?=
 =?utf-8?B?bmNCcWFWSm5UTlJxcGNwa0JtUTRHeU1tay9VVHNkUGpOTGRPc3dTcGtPVTg5?=
 =?utf-8?B?NFN4UUcyYjdNWjcrb1RiRVZWTll0T3B1KzlpeDQxNko1U09BeE5FTCtTemo5?=
 =?utf-8?B?eFhyWFNmbHhIL1dpaFVWMnpaYk9RT1NvOVJJZHA2MWhtQ2xnSko2Vi91UE16?=
 =?utf-8?B?eU1wRmtOZEl0V1prbSszVVBCZTFJWnFFODJtZE9wVDR5dk8wRkgxWnVVTGI1?=
 =?utf-8?B?ZEY2T2gxcnRUZVpmaDRhUUZnYU1qbHZUTW1VM29uYTBoQUVVY1ZRblNHWGFy?=
 =?utf-8?B?MjVwL2FjMFRwNTY2RExqOUhvaEJ0b0d5YW9DMU02YmpDQUlRcHUwaTdxK21p?=
 =?utf-8?B?TEd5SjM4eWd2KytUOGREYkZmNi9hb0hNL3E4cFd0NDFmM2JxSmVwNzZkWlVV?=
 =?utf-8?B?TzlkQmxPV2NLL3BpTVFKVURwc3NQcDVYblRlM3o0czVBME5YRmhRelo2MStk?=
 =?utf-8?B?QUZ3aHE2Y0lHcVc3WXYvRytmTWdlQy9TaEJYMktXNTdqNXY3Y3A2M2VFRDVl?=
 =?utf-8?B?UHFSK3J0WE92MkRuelAxZTFDWTk2cTRDNE4zSjVBTVRsZ0h6enhoZGF3UzUw?=
 =?utf-8?B?Z1Z3VVR5cG5Td0hQYXpLN2R0cXRTTnB3T2RKTUsvV2drZnptTlRiZktOVldj?=
 =?utf-8?B?L2EyME0rMjU1TjlwY0o5c2Y5RTBQQ3ZxN0JtWm5EQXNvYUcxVEg2eklrVU9Z?=
 =?utf-8?B?VWJMOVMzckk3RlVNSlZkUlhlSUxpemxMQ1F0OTNVOEJzeHhUamxmU1paU2U1?=
 =?utf-8?B?ZGUyNEZmL2MwYlpZU1JNbnU3WGd2Znh2N3FyKzhibVp3cGV0V0FVYlB2Rzg1?=
 =?utf-8?B?VDVVYndNK3BYU0gzMUx0Z0poVThZMWJRQVU1UWhuNDdNanBIMXlBZVU1OWkr?=
 =?utf-8?B?UTFXOWw0STdUM0l6MjVEYm1LUGVsZnhaM0RsZWFsdWF3bXhhaSttaE84ZlJ2?=
 =?utf-8?B?Vk5GZXlOTlliOGM4N2JDaWltYndVUWNwWEVaU1NtRm5XcmhCek82YldaKzVo?=
 =?utf-8?B?NnhDSnBudXpJeEwvZk50ZGRBdG1CV3pqb2FZOGZ1MjVZbGQ2TlFMcXBQd0xU?=
 =?utf-8?B?QmFKeSt1Y2NlSjZmcXkybzk0aFJlOXlqR1I2WDYzWHlyMnZ6SEFsQXdVT2Y5?=
 =?utf-8?B?MFhJV2MraldMWmJhK1FlQzZSWXp5YTVKUzZnSWdNSC83SWJ4V05hRFFZd2N4?=
 =?utf-8?B?aDMxc2RvVFFwZHJLb01Rb3FXU0gydHJLcTQydWl3SG5LV21jdnhZSG12cGRs?=
 =?utf-8?B?NXpFQlozZVpqdGQ2VzZIcUUzYjA3RXo3cGpTWWI0dlVKNi9rRXZDTFRyeS8x?=
 =?utf-8?B?QXQ4SzkrWFV0ejBPMzV1NW00QzdNOXFSOU04TmV1Zk9jUnZBNVlOazNhRjY4?=
 =?utf-8?B?UDJLam1sYkZTVmlZRWR5ajM2VjhhK1I1ak9iZFZQYjdkRENBdllRbkVLb3Bh?=
 =?utf-8?B?b3BPckdsaUR2amdrd2NGZkZWcHNCUXNMRXh0Q2xJOGFzM3FoQnFEb0l2UXlT?=
 =?utf-8?B?bitRaXpYSFpMQkRaWWVXemlramFvR3Q1bVY3UGFqbUhNUEc1N2pzZTFoc1N2?=
 =?utf-8?B?QlBCMEIzTDc1am45VlJqbmZJZ0VqWnZ4c0JueU0vRFVmRytwZm9lc01JSHZE?=
 =?utf-8?B?Y3FBZFNQb2hhUXhObVdaNnF6Q0VVNkxqTGxKdDJSVUJ6VFJKT0VpMmNZYURq?=
 =?utf-8?B?OTVFU1ZmWGpMSTdBUE9vWUtvSlVLd3lBSCs5aFBFZG91Nzhxa05RS1JDVmJD?=
 =?utf-8?B?anFUSnB4U3NTcW1tZGRhZGEyMExlSm1ubllsK01Db2lIbkFMRTVnN2g4NGZy?=
 =?utf-8?B?dnl1MU9GMDZ5Mk1TajlLNlFnY0U0RFFZU2dsdGpFTHdhK0hPbWdjSk84K1da?=
 =?utf-8?B?N2tmNGRYdW9ZY0RhVlI1SEVJaDNOSVVXcEd4emJaODJXSVlvbHBWaFYveDZV?=
 =?utf-8?B?VitiWkZTQ2ljUk9FaWM5Zml6aHVFUStvdWxsSWd1RVhLTVpFZ2lYOG5vYnV1?=
 =?utf-8?B?T1kzNTV6aXgvN3dRZUJXMTlPZU9JMlI3aFgrMjJaeDRBdUVDdllid0QzUkZB?=
 =?utf-8?B?eDI3dGVnSlB4Zlk4RW1tR0ZUWkE3em5NKzl2c1ZxempRZDlyV0RuVEVjZFBw?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38689fdb-1903-44ae-6bac-08ddaabc29e3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 20:52:09.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx1UHQ6swyrpuGRUEAMk2owx3NTJuxLSYXHWqLb2c0DFmWVm80zFaDOZdK7ZKJ/3iTQQIuKiKvzF+8dAJSM3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642

On Thu, Jun 12, 2025 at 11:36:12PM -0400, Hyunwoo Kim wrote:
> On Thu, Jun 12, 2025 at 01:23:38PM -0700, Cong Wang wrote:
> > On Thu, Jun 12, 2025 at 07:16:55AM -0400, Hyunwoo Kim wrote:
> > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > index 14021b812329..bd2b02d1dc63 100644
> > > --- a/net/sched/sch_taprio.c
> > > +++ b/net/sched/sch_taprio.c
> > > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> > >     if (event != NETDEV_UP && event != NETDEV_CHANGE)
> > >             return NOTIFY_DONE;
> > >
> > > +   rcu_read_lock();
> > >     list_for_each_entry(q, &taprio_list, taprio_list) {
> > >             if (dev != qdisc_dev(q->root))
> > >                     continue;
> > > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> >
> > There is a taprio_set_picos_per_byte() call here, it calls
> > __ethtool_get_link_ksettings() which could be blocking.
> >
> > For instance, gve_get_link_ksettings() calls
> > gve_adminq_report_link_speed() which is a blocking function.
> >
> > So I am afraid we can't enforce an atomic context here.
> 
> In that case, how about moving the lock as follows so that
> taprio_set_picos_per_byte() isnâ€™t included within it?
> 
> ```
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 14021b812329..2b14c81a87e5 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1328,13 +1328,15 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> 
>                 stab = rtnl_dereference(q->root->stab);
> 
> -               oper = rtnl_dereference(q->oper_sched);
> +               rcu_read_lock();
> +               oper = rcu_dereference(q->oper_sched);
>                 if (oper)
>                         taprio_update_queue_max_sdu(q, oper, stab);
> 
> -               admin = rtnl_dereference(q->admin_sched);
> +               admin = rcu_dereference(q->admin_sched);
>                 if (admin)
>                         taprio_update_queue_max_sdu(q, admin, stab);
> +               rcu_read_unlock();
> 
>                 break;
>         }
> ```
> 
> This change still prevents the race condition with advance_sched().

This should work.

And I'm sorry for the bug introduced here, and elsewhere, by assuming
rtnl_dereference() will be fine.
I mostly use taprio with offload, where switch_schedules() runs in
process context with rtnl_lock() held, not the software emulation that
changes the schedules from the advance_sched() hrtimer. Somehow the
different locking requirements for the 2 cases eluded me.

