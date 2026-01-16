Return-Path: <netdev+bounces-250517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 386CAD30CFB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98F5A300C624
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A937C11C;
	Fri, 16 Jan 2026 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6C2gL6H"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413DA36AB4D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564981; cv=fail; b=r/fKsDekC1OwfPIa8d+6uiQtTNU7zavCJFbY9y34uRaf+LbaMm4ijjwAT55zcYeh6pTTwtLA7V7gwqBWIc6qYSvOZ1g/Dy+GAgEaVvZ+D1kKYKU93ahXfyYbgvnOWus5hij5lVAD0zwlaEINGaLY7Hn2GkzgdAPGl4QnNN6uzwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564981; c=relaxed/simple;
	bh=G595R8RlKB9pWPCMcVsWFD2ISYQTYrNSgApvvoE2JqY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=g0/jznEuFOEx0k9ArgvfamcbL9KwMkosXxrwy512bo9Frs3kE8iLrd61WNuthFpgObYGT+7vvP44PebD/QrcfEieNp5EA1GQKOQL1WP9DX1l5mU26wflx2TWt16KMwarQsc5+kv0aoCe+niqDMIYQ0Lk5zT80OHEXoWM9zFRaFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6C2gL6H; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcEfnVGtEaYfaor1mdrXYRIW+7aTZz6HQlAwfxGVgXsNPe3g5hz4V0Br/g2PULJjiwmDHqQOyKnDRG4Z58hGiQEq9VVmJHfCKU9d7lQnrA8viQwrhAsncph+CzFKhORae1kNwFUX9soCkDVmrk69mvr/BEKfGNekCgnBdtsuH/VyVcgpNOo9M5M4BQbTGHWPrNpR8um5KR+hkEy9TKcAt8z6UTqgNlKiInlIWIjrep/WwpG6ppFxDeynXKah76ECfOQ9/3+EqEU5/beh9sByIqh8Lv9ohysRyEg+av8EWYXaNlF2+nIb8XW8RejlJuO3BjAMTfiteDFEiR/2GtUfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BSIZZXnSNwN1p9I7buTbij3PcMKjibWF3OuBbgX9EI=;
 b=uf0uzgTkU0+Llosot3WWBMbJ0Fayf1mNk4VBPEl6eqhM7c53/tCQv4ojArVN7FUVuKUohIW88+g9YrUznmwbWy8HkKVTFadqJdc9F9O0RioQsOUci0a6xAxXwQ6tLnwBaVmeNZCp6XrBWThgK/4qJ8LH7aKS7NWhPQLeV3nY/+ZjueWvgrLfYU2ZeB4o5eHhb52T+/D+STc+atNIMMIcwMjxjG6ln5X+yD/8ZQqbRe4sRy98SP0F+s6cUdISuAfBdLqO6waWkLMwfeZOfcwjmu59FtHqQYZZdvXEvBDrifS+yt3+NRQahIGk6HDwA9bqBes2Q/MeN0H9glmY6vLTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BSIZZXnSNwN1p9I7buTbij3PcMKjibWF3OuBbgX9EI=;
 b=r6C2gL6H680gLrtgZ873oh5RKphBRSRORAPjSD8tcRUvw1UitlVXtrnB7rPl+I/4/oTuLsxU5Xepmiu5fo7XVbNo8QSCLwJTuaS8ckXX9d+mGhCHzlFJq5hKfyRfOfz8lSpBK6Fv5Al0dhW85T83NgJ75gSYVZJ91FgXNTH+nMWK6zZPltl6tlcYPPABSpXbkqZJvICLgS5biQP1bL+3+SoazvO0KYcxSTZT7CIc6BfZDlnEEQCGKT6wwWymo2+IUDiiZEP5DXHLzKqHBk4WxI3LL7VnGrnpJscmkaO4vxY5t910tjDoJGbaXAZ884kFh/mTsbOwyjXaAMBGgKLvEA==
Received: from DM6PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:100::18)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 12:02:53 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::5f) by DM6PR03CA0041.outlook.office365.com
 (2603:10b6:5:100::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 12:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 12:02:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:02:42 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 04:02:35 -0800
References: <cover.1768225160.git.petrm@nvidia.com>
 <accfea32900e3f117e684ac2e6ceecd273bd843b.1768225160.git.petrm@nvidia.com>
 <CAAVpQUAoo0JBCPgf_Mc4cO2tpUmn0=Rn7aiUj0Q7HiHWRyoWpA@mail.gmail.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>, Francesco Ruggeri
	<fruggeri@arista.com>, Stephen Hemminger <stephen@networkplumber.org>,
	<mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 1/8] net: core: neighbour: Add a
 neigh_fill_info() helper for when lock not held
Date: Fri, 16 Jan 2026 13:01:19 +0100
In-Reply-To: <CAAVpQUAoo0JBCPgf_Mc4cO2tpUmn0=Rn7aiUj0Q7HiHWRyoWpA@mail.gmail.com>
Message-ID: <87o6mt6a0f.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: f140829e-17c4-4e0c-bfbe-08de54f72dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk11Zkl2eEJiN2pVN1l5K3NDUjl2ajZ0NlZHVGhsMldJZkxJL2tETFdlYU9O?=
 =?utf-8?B?WFRuWXczQWNObzdOS1FyT0lOaVp5QU9FY1l3MGtVZkJ6dDRTMUE4VW42K2tT?=
 =?utf-8?B?RWlmNFBNcUJ4Wk5jM3NkdHJaTUpvYnptY256Y0Rqc2NSbm91TDZXTXkvTWls?=
 =?utf-8?B?djFsd054b1RmanZDMVp2Wkl3OTVFMHFRbGpzMG1pRm1TQm5GRWx1aHE3TFZu?=
 =?utf-8?B?Yk1saXZLUWxjTkE1emVrNERJc0NSK2loeDVOaGpVN2lRUTBwUDFzT3FabWty?=
 =?utf-8?B?MWdmS29KK2Q3TmpNN3ZodUozMFQrcElhTXpXSWo3Y21ndHc5Y0lMMEg0K3cy?=
 =?utf-8?B?S3dDMys2OTZKcVRvTkVJcGlIKzd1Nk1palBTY2pQNXNyQmgzcWdDaHhhRmRt?=
 =?utf-8?B?d0pwSXVTaUtWejhvWm9BUmhIRmNkS1h3MEQ1Mi9tbXNaTzlKUEMzdGV3RGFN?=
 =?utf-8?B?WDZwSnFaWTIzeVBLd2daVzJyS3QvZ3kza3kzbDVHd1p4cWx6S0llbGdvc3VX?=
 =?utf-8?B?ZFZvOTRlOXFGQzVURENnQ0dpM2x6QXJPTWtNdVNsMGg1RDZPaG02a0hBSFZL?=
 =?utf-8?B?RlIvOGgzMnV1dkozYmt5SzF5M2hWTlBveGlkWm4ybS9sKzVTMnNTYTUwQlZr?=
 =?utf-8?B?OG1ScDg5QW1majJyaFpYME83YkQ1NG1UcGlteWdXRUFBZXhWVWl1SmNJcE45?=
 =?utf-8?B?RHgwR2Z2aUcvNHhBOWZtVlYyVGFJdlJZYkJ2UXZOSnI3R2g5RXNCZ2NsN2Ry?=
 =?utf-8?B?RmI1eXozankzbGNBcGdSNlV1MXZJTDdXVjIvcHlPQmRNb093cE1tcmxFYUxD?=
 =?utf-8?B?bFN0b1pBcm1Qck50SW4yR2Q0dERSR05aWVZaU3ZsbFBXMjlFb2tiRWNhc2d0?=
 =?utf-8?B?MUVvV29MSmtBLzA5UTBCYkZTaFdXNFRmNHVrYTE5bFEzYW5sdWJZMERvZFlT?=
 =?utf-8?B?ZjB0aHUraC9CZy9ycXg4R3oxajVRYzR3UmxlNi9zWGNremp0Rk5HQ01NVlZY?=
 =?utf-8?B?M0JWWXVRMWwrekJCcTJIUVo3bkkrdWp6WGlVVWY3a3RKUGIyYnREcmMwWHlp?=
 =?utf-8?B?bkJGaG9DN3l1UnZuRGhLTkpobmpxd2pDYTVYb3ZzQjluYytSSWFzZUdnS0k2?=
 =?utf-8?B?NUl5cHhvZDR0d29OSEVtSUdPN01WN3crNHhPSXJTeWg0K1NLQVV0dzNKVDE5?=
 =?utf-8?B?V3lmM0s0ZHBtcWVKTjNJcEtvckgydUNmTUUxQXpaZDlKWExrOWgxaGllcWlE?=
 =?utf-8?B?RXRXRjdodmVmWGVVam9TZ1llZms3SG1wdFovTEtIUS8zbk15MHRHVjNCTm01?=
 =?utf-8?B?Yk0wbVRaTHFKY0hGNnI5OWRXekM5cmRqanlOR05Jb0xDditqbHVacUFuajBk?=
 =?utf-8?B?TlpqMWIrV3padHY4UDZpOFZJTzI2ZWFRZVUyeEVsNnBQV0M1c1pHOHdjSEFR?=
 =?utf-8?B?N3BOckFkWWw0YzZEa0x5YmFmaGlyTHRRME9sYWJ5TlFjTncranJJVFlUQWQy?=
 =?utf-8?B?Yk5rVTdVeGR4OUFhbW1aYWhBODZ5U0pXQzNJYWVtU09NYVBRem5yL2srM0pi?=
 =?utf-8?B?OVdzcFZpTFYzMUlqMWtyejV1OUVla0dLdmFyckdDUWs3alo3WldqN2ZLNThX?=
 =?utf-8?B?WEIrTEtDdTZFU21mMVUzb3VJNWRMRFVlN2xSYkQwYTAyd1ZRa1pjS0oxL2RG?=
 =?utf-8?B?dk9YclBhbkpwRlBORURlWjVPKzZXdmJXei8yQm0rSmgzOG81ZXNnUUl1ZGdF?=
 =?utf-8?B?dWg2Qk02Y1RRSGpHa2Uzd1JDT0ViTEZJSXBZSk9JRm10b1ZkRnFUS0RrTC9t?=
 =?utf-8?B?NWc0N3dxNlNWUkZzSjQ2and5NEVqdUFTL0tlRndZb3NFVnFpTW9lQlczckg3?=
 =?utf-8?B?WE12Q0dqbjVMS0FmSnNDNExscEdTaHUzdTF0dS90L3hnYjN2NEVwOHI0aDNz?=
 =?utf-8?B?Z3dOSGVQYlhOdFBBRXAzOWtlVFA0V053SFd0c0JURnZPUXJ0NHJJb093eDEz?=
 =?utf-8?B?ZUJkelFTWk9aQklHSzFIUEdxVEd5bEJWczRSc3BsNkpyTWdoRXNTVEtscjdD?=
 =?utf-8?B?ODl2YUxGdVJQWUZNRW9CS2g0c0tMdloxeEFTUjBzNjZFZnRydUFueVQrQ0gv?=
 =?utf-8?B?WUdpd0VoazdBTDI0QUtERkJWTGpiZElPcHYxSXZLMG84VnNNTk5Ha0F5K0tJ?=
 =?utf-8?B?ellyU1JOOTlnMGFZWnpTc0V1VEV0c1ZKWW9PMVRoZmZFOUtucFZacU5yMG9H?=
 =?utf-8?B?VXVFZWhjdTRkdzVQajVTL09WeWtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 12:02:53.2804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f140829e-17c4-4e0c-bfbe-08de54f72dbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785


Kuniyuki Iwashima <kuniyu@google.com> writes:

> On Wed, Jan 14, 2026 at 1:56=E2=80=AFAM Petr Machata <petrm@nvidia.com> w=
rote:
>
>> @@ -2684,6 +2680,20 @@ static int neigh_fill_info(struct sk_buff *skb, s=
truct neighbour *neigh,
>>         return -EMSGSIZE;
>>  }
>>
>> +static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
>> +                          u32 pid, u32 seq, int type, unsigned int flag=
s)
>> +       __releases(neigh->lock)
>> +       __acquires(neigh->lock)
>
> nit: Does Sparse complain without these annotations even
> a function has a paired lock/unlock ops ?

Actually it doesn't. Should I respin for this?

