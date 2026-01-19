Return-Path: <netdev+bounces-251065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8BD3A8B8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45CF3306D37D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CF315793;
	Mon, 19 Jan 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lOiF79zd"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80EE31353D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825579; cv=fail; b=lPb4sBUrKOzP766V+SI/bPhAoFAjyDVAizdgu3Oq5sz2TOcQdmrKERsw2+ANRrCwmkYtisb5ujXVQsAalrZE1+M1QPJ2aTWhD0JNyZ8x5QeUDThlEWS9zgdrqNZxzKwrEcDwvTAgmDOrRgjGdRefHkhzeuJ/KwJzu3U+Ja5fQvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825579; c=relaxed/simple;
	bh=2Q2R2hmIrNIE2UMCsa4Gi03NNnTgJxvQFmXvfOHEhno=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pMBw4khXvUoqDqy1vZLwLG8MPbWx84L1ADyKXaA6zkDzQvNP0btq6SaK5/qj1pjpbb2tQ3Q2igYdnJggijnEFQzAxshosM3mRds8mTItNntsSYY3X9AyXl2B0Ha+cQaYfzIurQyS2gva+JmBNvAHt0rCAcP8ZfsxR7xUuObxDM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lOiF79zd; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elRDaujYetVHCaVby2MBo5A/DneLC9hmR18kO1lO8M0rpVNozVAfLdd2A9yxAOgtt9fE4JCMB+ArJMMNkI/gx9Z+iVey6NYtetfuTrxrqzyVo3FuYPwx0OvcGJUwuq5WAduV5z0zbYSzl8fLpm+Z0k0y3a9RblJE5caoMqH3PaNwRFmi9I9zFJvAKRihaknYZ8j/he/1XNlQG/ZE2c3YrYNRI0U36IX4EDcmlnbokFkw3fTnM84eiBwwZOSpHRlUhtO/pQb6T35EdHCfGlO7ahN6USSQHyemazAR74JAYc+SSEFF8JGjENPLlwr0M4zfx1AwiPlQNd3U5jMdJ1xpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvWpPK0OTlmZEmF8Fzz2BT4+9Urzdb0iMELGXVLd4dE=;
 b=gOdSKCv8GHIBqSRgEnpsYmf/g7cW/TkWDqkO4xKW+w6liZkmk3ynROLitv3b6JOvbeot6yZuXrdHfV25VpQBJWrGRiyrHDfG1mmfjMjK2mYvMyryYRSrTYG0K1GJ7tiRogDTroW7v5lTsW6zM+Oj205JOQumM6/pZKIwa4Cga4uV2K9BQ7JUPIV/R4IDYaUug0fpnI1Eu8O1waID9StaPEyqe4344aC+VUL3nn105zFjRy/4nOGh0UAUxj/CsKfYxxX+uk2QlfpXx5sOroQOPOp6SgwVZKL7Xm4SsmeQKz87BPsz0D3CVLMD7Yibis5dhBapR4ih9jIgixs2sA0ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvWpPK0OTlmZEmF8Fzz2BT4+9Urzdb0iMELGXVLd4dE=;
 b=lOiF79zdl6god4P/g2N1SIyYXin4E1AjGD/WNqnNNkKJetAMYu5xzGi62rWvedpA4WFpKHvuGrNLw/RqKDHo9F4KV7zb6ROCAkWomUKFmRq6p92tl66ZqGzAYrdDSsUkOhVDTyCxf+L8PEMks9NxSKRCkCmgDkMvDLMAawOMfSn9HXf98P9z0rXXWD03gClzFIKF5l6ue3sc03K4ELgbNVasjCjfM5Wt5YkF0M8hRVKOWZVu+FqTkavbHHC+vhH9FlWUqanjutUS9vEy1tTk9K61xzFUNIKHc6UgDSOMOXYud7oJGWdh/KCyRIP9pCeyqB2NK6itHHxKSvXRjamN5Q==
Received: from SA1P222CA0048.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::23)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Mon, 19 Jan
 2026 12:26:12 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::65) by SA1P222CA0048.outlook.office365.com
 (2603:10b6:806:2d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 12:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 12:26:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 04:26:02 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 04:25:55 -0800
References: <cover.1768225160.git.petrm@nvidia.com>
 <accfea32900e3f117e684ac2e6ceecd273bd843b.1768225160.git.petrm@nvidia.com>
 <CAAVpQUAoo0JBCPgf_Mc4cO2tpUmn0=Rn7aiUj0Q7HiHWRyoWpA@mail.gmail.com>
 <87o6mt6a0f.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Breno Leitao <leitao@debian.org>, Andy Roulin
	<aroulin@nvidia.com>, Francesco Ruggeri <fruggeri@arista.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 1/8] net: core: neighbour: Add a
 neigh_fill_info() helper for when lock not held
Date: Mon, 19 Jan 2026 13:25:36 +0100
In-Reply-To: <87o6mt6a0f.fsf@nvidia.com>
Message-ID: <87a4y9iyb4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b3de0d-3946-4458-fe19-08de5755ee64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzZPUXJiWWIwZzFSazBJc29rc1BsMUJTYjFuWElZbGNONmJvNzNINDFpTHZV?=
 =?utf-8?B?bTVMWDNpUGJ5M2t4b0pudVJBZW1iNXFWeWVPMHdnYkFUL0hMUDI1YkZyUGlw?=
 =?utf-8?B?Vzc4a3I0UVpJalNYdUtqN3NaeW1Gd2NpWmNseVpKMHZ3YTlDbHBWc2JUbjJI?=
 =?utf-8?B?Zm5SRnQvZElmQmJLVjg0MkkrajdBK2I2YWdwY3NmdHlYdjBPVGtSc2UrUSta?=
 =?utf-8?B?TFNsMlFWaFR4VjRabFpncVRuT3F2Uk9lb2ErT3N4TGZuRDk0WEN6YVJPRDZx?=
 =?utf-8?B?cnNTRG5RcDRFb0NGNEdkQXJuakZtSElYMnZ3b1doUDNqRHpaeW5OK09adG9G?=
 =?utf-8?B?MkxKVm5CbzkrZFpvL1RKZ2pVcnF2SzB0Vy9ILy9lNzRNNEIrV0lNVjV3TWJX?=
 =?utf-8?B?QUlMTVRwTmlJYytkdnE0Zi9GK3JWQVJ1S240NlBRSHVzTUJhYllRWXF6UmxJ?=
 =?utf-8?B?emlQNjRyZHJZQmRINHR0dGd5SElMUStzRzF6UEFmZVZDOUtxUkEzYlhCTnc0?=
 =?utf-8?B?ejQ2R3UrZmlLRE1MVDF6QlRGZkFSZCtFZGZsUk9oTVQ3aVQyVDhnQkFtZ0ND?=
 =?utf-8?B?T1A0RTBPaGRDS25MVGVLVFAwR2VLeW5JK3RXb0tVOG9nbHc4WjdVL041RTVl?=
 =?utf-8?B?T0dNRFlweGdjb0s5Y1Rna0dxNm9KTEJlNDFQRU1nL0ptUGVUWDkzZzdWekZU?=
 =?utf-8?B?VVN4RXB5UUNxUXRJeGhuNTRNVFovRU9HNGZwQU1uWDA2dVlXbnN0RXM4REJq?=
 =?utf-8?B?U1JqbGpucjZ5Q1RlZ010OVk1U0c4TVdSTGp4djlrclFyQi9XbFRtVlhZMFFZ?=
 =?utf-8?B?WWk0ZSs2TENPSlBiU01ETiszY3lpQ1hjQWlJTGpkaE5uY3FmQllIa1Z6R29N?=
 =?utf-8?B?QTZuT2UzUkZmTXgxVGZ3ejBKeVZtZUhRbWpOaWdWZm5iRUZHNDVTV202Z2Rr?=
 =?utf-8?B?MHdvcGZZczQ1aWtPY2dWcXJiVEo4alhXelZKQk5zQVlOcld4YXN0eXJWYmI1?=
 =?utf-8?B?eUd0QThMeUhuaG5YbzRWc1h6SDhxQkhZMDJuVnRCQmk0UFpieDFtbjR2Q3VM?=
 =?utf-8?B?bHRjN1lDM0lVVDFHN0RnanliSmI2RDNCeUYrclFmaDlWVHhHRjBlbm1Rb3hT?=
 =?utf-8?B?NnFzUUdRdkNxMjdmeWpIS0tLdkNwTjBSZUMwNkdHVnFXN2lsbW9od3JJWC9a?=
 =?utf-8?B?RHlTT1NhN0NnOCsvWjB6NS8zeE1Vdi9teEJ0QkpGWlpvOUVJMnh6cTc0M05h?=
 =?utf-8?B?NnJOeDdTaDNMYWhiVVFQRk9JUG9YOGpPeDJ1YTVBd0lUTlVabWNyNlJPdDVi?=
 =?utf-8?B?dVdoNmN4WVdsZTR0b292bCtvRFNuVnNKenhsK1BHYW5XeGRJdW5oZFpVU0hU?=
 =?utf-8?B?bTJmbFZSV3BGd21lejBwZEx4Nk1icnNXbGYvYkRWNDdCc1BJd3luMHVlZzFw?=
 =?utf-8?B?WThYN1dvUjZldUlYdGt0eEdyem1qY1BlMFF3YThGbjVGZzNQRDhUZ3lqd0R2?=
 =?utf-8?B?V1FoUUpFMFdVcTc4SHMwZllEL1FlMlNEZnFRbER0ZDFpZjZnUWJ3c3BHdHd0?=
 =?utf-8?B?UmpHQ3FCMmZ0bmt1Tjh2MWxzcngwZmRuUTZyZlhMUUNBQ3lUUmVkbU5KanJk?=
 =?utf-8?B?bXV3ckxvSWpHUTVibHQ2a0o5bzl6K1c5QUhsR2cxeU8zeGpjSEVoNW54ZjBk?=
 =?utf-8?B?MkE1K3Y0V0s5MitrMXFUUlNOejk5SGMzQjBNN2lUZVNJS1FCRENYUlZ5ZW1s?=
 =?utf-8?B?SUJqU01QaGUray90RmhMbDZFSGEveUVqT01tQUk2ZTJDYkJ4eFdoTkpwM2Rs?=
 =?utf-8?B?SnVlcHA3OS9YUzkraW9LY2xMbzVsUDQrZ0JkTlQ3blE5aGxoNlBqZ2tFaFF1?=
 =?utf-8?B?anBQaG1mOWVIRlBCZTdSeS90SFRjdG50VUNuMDd1RmJUYlhxQXZ2Smd3cHlL?=
 =?utf-8?B?c1ZXeWpsYVJLQ0FFRGJOY05POGFiY29HR0JtYWZYTXVrNFNkTTVpdWNCVzJk?=
 =?utf-8?B?SVZaUTRQYS82N3VPWksyd0VHUm1jM2tXU2NWZUc0WW5mMXJ4WTBxRmpkb2ti?=
 =?utf-8?B?SVBxU0VBNnJWdWJWRnZmeEpGWmlFVCtiR1JnZTFyMDRlRUJFbWVKSGs2SDht?=
 =?utf-8?B?bnBrWG1YYkhINi9GUHkxa3dIUHZJTzFHK1hIV0h0MGlTT0IyZ3ZueVpTdGE1?=
 =?utf-8?B?ekRlWFA3Rnh5ZTFUY25NMk5vUkV1b0FWSkFkQ1hUcGtYenJGRHpQbGR3d0xN?=
 =?utf-8?B?RXRpTGlaYlkzUmpiblFpNVRHb2Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:26:11.5115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b3de0d-3946-4458-fe19-08de5755ee64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162


Petr Machata <petrm@nvidia.com> writes:

> Kuniyuki Iwashima <kuniyu@google.com> writes:
>
>> On Wed, Jan 14, 2026 at 1:56=E2=80=AFAM Petr Machata <petrm@nvidia.com> =
wrote:
>>
>>> @@ -2684,6 +2680,20 @@ static int neigh_fill_info(struct sk_buff *skb, =
struct neighbour *neigh,
>>>         return -EMSGSIZE;
>>>  }
>>>
>>> +static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neig=
h,
>>> +                          u32 pid, u32 seq, int type, unsigned int fla=
gs)
>>> +       __releases(neigh->lock)
>>> +       __acquires(neigh->lock)
>>
>> nit: Does Sparse complain without these annotations even
>> a function has a paired lock/unlock ops ?
>
> Actually it doesn't. Should I respin for this?

I'll be respinning anyway, so I'll include this as well.

