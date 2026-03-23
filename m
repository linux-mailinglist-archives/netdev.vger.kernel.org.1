Return-Path: <netdev+bounces-270338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMxHKG+cwGnrJAQAu9opvQ
	(envelope-from <netdev+bounces-270338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:50:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B12EBA26
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7310300574E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF641F418F;
	Mon, 23 Mar 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQDEl3qQ"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9E1C84BB;
	Mon, 23 Mar 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230637; cv=fail; b=EVnSTzpDNeou2qKoI3MdDmIt2lVKcPR8ST9mhN0vLpw4PIYFRU60PdO97gM6BWVx1ipiZYTRwvesBdo1kfIpVx5jUutIhRLiobtgC5TPwRuCkQx6q2k+ANfwoUzjh4AWQcJrRn5qh2jf/ADl3ndgOowrCxzs/GsxuqZLWlsIlmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230637; c=relaxed/simple;
	bh=6GG75t52+MLecrltviAx+t2kpk8XwsaV7VqHdaZuI2A=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SJ0sVQobe1o/BN9lCF+NuCRMGnL0Uze2LmK76MEAaXi/Rp3kXlbSqg2sAPB5+oRcD/Cdjo07AnC38YQz/sJBVQ+qOE3MnZoD4eIbYn6gTxia2k2TmE9BCcBHq1RwCZM1fstRsx1sE27MLbURHOq+E79M/DWI8NVva4SEj4nJDm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQDEl3qQ; arc=fail smtp.client-ip=52.101.57.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRvA7Uw9fR4EVRYRsMi73MnB95U+0PnQIxxw6pLSX4Q5HceqYdIWlXEa4kwVrwtSnio/FPuTAnxQkIHnAU0WcEJ9tkjHezDA0Bgzi1dUEf6acK+rflobr8Lv9VL6K+USGn6fOvQUccVMtlejS+HTo2uXtGZb/1cXnxTxKJrUDa6/cW9jWmciZh8vMjft4JhQjBPmD3Uq5lWFvVjoJjYTHCT+07YbZtaESef3Nl27/LnPsnhzdb3g00ZpKz7CH/RZDvun6afYKFQNpAJw5k6NniJk4VMurVqZRQMwQDJJDaJu/ymuUJgkQmlGloGpG5Q2Gj0he4zM2akTgORa2mDrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GG75t52+MLecrltviAx+t2kpk8XwsaV7VqHdaZuI2A=;
 b=PFo1tS/YezxL77ailvr/l6vesQ2IhQq783ATFFtlaLlT9vS0Wvfi0GaVMUUBGhxfAKjDYl6eurDQVmoa0xB9qsfY4Np9L72ucBmTKRP7cHOzS3mIutX2eiimt1u2tDR8i94V7SvgV86eW6NcmfdOLLVMQZRPfZMt12q0aON2bedIWIrJo5LGkAgDL3xGFHiWoh0LaxBSlO3CsramiRn0v8A8IgNvZANO4w+y2n6I670tRTiSx26THFz/g5c2zocpSDwGQwP1ojUTAz4oKlrA4TpsgZR8N8ZnPg17/oYx35A6YFWYjaxYsicoE1RCEnI9aQCHWX9oI4pNDJ1DZhn1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GG75t52+MLecrltviAx+t2kpk8XwsaV7VqHdaZuI2A=;
 b=CQDEl3qQ7dcCL8tRNDjMMv1gi+zbxpQi1FFVTHn5NY6HFqXwd/oQ9IHMxVUgvVJG4/WN3lRG3mXePygF8k4nwphVjb+tlVmHFXlXmkVv3yI8jUZFEr/kch5paGMuoTXE3MG14ideB4/Q6jW33rq5XLpnw46FT1ZTj1t33XlLj1+Z60qOOkT++39myCGFzEk0Kc7YpWHyi0fXyTU9+iIhnZNJ6M5mFmDGkWqEdiKTQh0f6okLJTasa97qoMgqB+nbNChpP/+CeOUkNjYd0fXvMuM5mLyzxNp1vy4V/jLtEgooQ0J1EUcCagdEE8VEyVHlXmC2IilpGqpWaxPIRfAKjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 01:50:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 01:50:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:50:24 +0900
Message-Id: <DH9S9KS2O6DD.3PGGQ05VV2VYQ@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Waiman Long"
 <longman@redhat.com>, "Yury Norov" <ynorov@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
 <DH9RDC77E3NE.3F8BURMZ8INBX@nvidia.com>
 <CANiq72knM0_w_eHbu1qV2Ps8KbST6KcAZRtTH9FEd_5sRMqWdQ@mail.gmail.com>
In-Reply-To: <CANiq72knM0_w_eHbu1qV2Ps8KbST6KcAZRtTH9FEd_5sRMqWdQ@mail.gmail.com>
X-ClientProxiedBy: OS7P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:26b::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 1012046c-3ebc-42b7-13d6-08de887e8f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sLjZs5mm/GM0Lul3TuuMqjp0J30dzAgp9n3LdZwJzmVEpFPG1iXLGVtONGQSUnfJRUQUMnswJRSLtswiraWQw/0MyN3B7Doz8bfN5vGNvCZgr1Q4FE74XRSEEtMbUvHKzeS7BPKJGyA1enGzytI4YbxWcc/VofZ+p9I6igV1UFzKoj2H7uONdRPTCnZJBwjDziJYqn1PSP0HbybFYqBhUkBN0CQvhrIgyiziMLaU19QNSDp+xgvzNmQj/CixQPww2JnaWYf1pfAUPCsGJdqHTz3DUtJ6FkFP9QazgyFx0O2BFM+FsNcGp5vKJyuqdxYOyDNFH/AnQu4OTCX6hBSs57h0a3fgzXjYuBwJkZAlVakcT2ysf1eO80MCNNd9B4qEBsw4Jr4EF7AjLdFADRQj6+S1ltgkLRNKqmWAFjSF1cpdQ/wAtGyZtlJFSVQy2vWl+mBU2Z7dV8bisMvMSgYQXTG9e0jHncOmoMTmmgP5wKwxg4WWjnYjZ7S5KB7kcdWxerMDYgI7ohKK09QrElkldCvYtx62UClQpv9zRafRLam3okiWIiNLEJ80TpdArNZrDbXyp+6lAiSY8ZzgS0yjJ6oD8vq+MIIIYlwLWNGbpLlbTuIvUEHSbZOsiBUbUedJLF2LxMCgCKC48U1pFmiNaf6/xabBNWZPfRjJ7tEgqtmFJ3t0h87Xm3MVj8A1gBmd1yjFXJLv76rfiLb1tXwV2NWZclYc/yoigTNb9o39sQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c01CK0cvdS8yTWh0VjlGZTFyZWR5MWdYSi85WXg1dGFmeHRjZ0sxbnd3SFdj?=
 =?utf-8?B?YnphVzlrWDgwZjBUU25EbGozUVNGR3J6OUZSNUV1Zm5kSnptZi9VaHFGY1Bp?=
 =?utf-8?B?NW9FL0F0MXpDb3JHc3N5SURXNVpiSW5MMVlYQ0dCNzJHTjZ2NnNFVktOLzJQ?=
 =?utf-8?B?QnBKNU5MQnE5UGZVbWJCaWxOTFVtRDNXVkx3bk43Q2tIZ0FLbkt5eVFGbEE2?=
 =?utf-8?B?eWFONHFBZ05vR2d5QXRKbW1zMFdGSmVKdDU3T1h1UTk0Y2hueldGRVdSZ1ZB?=
 =?utf-8?B?U0FoWTBwcVhoZzh2UHRjdTRLSHlueTRiNzJ1SUo4ODV1Z0RmN0JxTVplbE5u?=
 =?utf-8?B?VW9pd3RrL2VVdGFlQXdwcVF6NFREc2JVU2R0YXJ1S3ZQcHJJVnJaaUNqMTBD?=
 =?utf-8?B?Ty8zU1FJc0JRdWhaMldxZTBPQkJTYUorSE9Bc1FsbDRoRHk3Tmh1WlRhazZp?=
 =?utf-8?B?RHVGVFBLU0FOL05RR2plR3VjclJIbUpnVzJyKytjUE8vMXZubm1zVDJBL25G?=
 =?utf-8?B?d2NJcXNBc09kSEErOGVXQ1NZaDdMTXlUcVlPdVRoa211dHpCN1RYYTh1VTFq?=
 =?utf-8?B?V3g3SVNEOFZNYVh0Yk1QOTE5cHZ2TGcyRDJmS0svWjJrVUh6RCt5bDJ4S2d3?=
 =?utf-8?B?bWY4eDhDczJqMjRMdDhBNEVCalU4NytvVXhxS1h0bVZaT0lzQjZmbWlGZ0NL?=
 =?utf-8?B?Y0JtTEZkTGxFTlVpTisrMmdJRjIvM3pkeGg1MC9uTlpUMzBXSTlWaUhGaWMy?=
 =?utf-8?B?QnlkTysyWGhZbFNVa0Y0VU42REZxVDRVNURhUHBtRWUzMWk3ekdvSkxmSXAy?=
 =?utf-8?B?UCtsTUdsRHNTY3ZsNUg3WHhkTXE2Y2U0SDYwODY0U280eHB2ZW5oaCtPcVZv?=
 =?utf-8?B?VVd3M25nMmZWU3ltTG9CaXFjaEdLc0ZtQlcvV0x2bVQ0Snd1Rmo5dW4wRHVH?=
 =?utf-8?B?cjFRNTg0MHBDZlo5aWMwK2xTcEYzYkFSbWQybm9yRCtiTk1QMFRkYWpTNWlo?=
 =?utf-8?B?d2kzc0RhMnNnVEJSS29DKzRRbDBxMjlOUzNMOGphdEJ2SFIyRFhMV25KWnYv?=
 =?utf-8?B?VC93Z1pFODVsbmJDMVA1UWE4eXhPeHREMFhBNXZtM3RkSThPL2s0bnhuN24x?=
 =?utf-8?B?bEtOUWlsR3Q5NFNGMyttbHBYRUdNYVVLcW4vRkJEN2FXa2QwTXE5a29xa2Fh?=
 =?utf-8?B?YXJBY1ZLYkJzTkZ4V3RnUXptMVRYWEF1Q2FkRHFQakRlU2V3WDV6Y0pjT0py?=
 =?utf-8?B?TllmTm5SdG8yRWsrRURYWFRVQUZSUEgxVkd6OWw3ZlQ5QVZpaTgrclFUN3hV?=
 =?utf-8?B?QUZNczk2ZmhTWk5KSzhKRXBrZXpRdDdoV1J0allqc2NvRHpFOEpuc3NGMW5x?=
 =?utf-8?B?Z2x4V0NCNkpuMldhQmdsc2FMRUpyU1NxSDlnSzRuYkFWNWFnSndKeDBwQ0dw?=
 =?utf-8?B?UXd2TVpqQm9GMm1qK0xwQnNRbWdDb05LZGFzcVk4Rmk4UzNQR3JmY25mYWJD?=
 =?utf-8?B?R1d2bS91Rk1RWWdELytCdEZFN3lwdThSY3ZESGpCMnNYTDljaGdSWGhEcThu?=
 =?utf-8?B?MTZZTmdPWEYya1FyWXNlcldWQkZtdjFKejVraDRiT2hESWU4Y2hCaXVUclZ4?=
 =?utf-8?B?MUdhb1Z0U2JCYXoxMDR3dWgxZW1CR2dzM1JJNlJtUys5NnJXbWhXejJ2QmtF?=
 =?utf-8?B?bEdCdWZsbnNZNHdLYXUxS09BNWVTUnRlOC9nN1pkL09sOTVFZ1EvWmluV0xQ?=
 =?utf-8?B?NVdsZmg5UkoxdmVGZjZTektTZGFJY3pxN3F4VTFmMEtSS0ViNFF6cDkvQ09B?=
 =?utf-8?B?czJNaFFwd25NTFNwa1JwLzhzeTFYWUNzL0g4d3UxUDVseG9Mdlp4SEJHOVg5?=
 =?utf-8?B?emtBYU04UHIyT1BCV2VQeFJMWDF4cG9naTBlNktsaGVENU5LOE1rYlpaVG1j?=
 =?utf-8?B?UVBuWEJ1TzFMSTBBa1pleGhkQWRHd0lOSkRtRXZMemJobUJNYTFPS0o0aXc0?=
 =?utf-8?B?V1d1ZWp6V2FTT1M4Tzg2aGkyL21DdDNLV3lDZENXUkNORzM0ckJ4RFpLbk9E?=
 =?utf-8?B?SVdBeTZ6bnp6YmJldVhvaVdYSnVPUVBVWHNUeGh3bkJ1dmlxVHJYWGlIcGJh?=
 =?utf-8?B?eEJ2dHBzaEpWaStHOVhOT3JqN3JVNWllZVZ5YlR6VU5wNnJYNUhsekgwa2px?=
 =?utf-8?B?UkpoTmxNTEV2ZmI5dzNnZ1hpRXB6OHhKMEI5VU9YSzE1aVRmYjJ3VVRQcDJC?=
 =?utf-8?B?VkJTTEY3U2l0R1daY1V3RFdjc0VJWEpDRzVuSytCU25yME1rWG9SZ3BhR3Rn?=
 =?utf-8?B?UGdmWlo0Snc4QktLRnhRbVhKaWRoVDFpYXpkUFl3QjlsQmIyeGpXVDA1SzZC?=
 =?utf-8?Q?obZb5YtrzuFgpKSjdxCxgGbtBjaF2B1K4iJi5CejuM6Q8?=
X-MS-Exchange-AntiSpam-MessageData-1: TYOyUomDeS9Wuw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1012046c-3ebc-42b7-13d6-08de887e8f08
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:50:28.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTQqhODN35gsgvuLXlqj+NUj4LMXvYdXN6K0MwZ1Bmra+iH7SqaV5AeWT0QGyaqZfb2PaKGhrWfmMGrdKFgRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,gmail.com,kernel.org,protonmail.com,google.com,umich.edu,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 096B12EBA26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Mar 23, 2026 at 10:38 AM JST, Miguel Ojeda wrote:
> On Mon, Mar 23, 2026 at 2:08=E2=80=AFAM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>> (sorry, assumed my Reviewed-by carried an implicit ack as well)
>
> Ah, I saw your tag for #2 and #3, but not #4 (nor #1).
>
> Did I miss it/them?

You are correct and I will have some more morning caffeine. :) I had one
question but the patch looks good regardless, should have acked it
preemptively.

