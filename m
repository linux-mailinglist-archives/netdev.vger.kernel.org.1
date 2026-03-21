Return-Path: <netdev+bounces-270211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L+PNA6evmmKUgMAu9opvQ
	(envelope-from <netdev+bounces-270211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:33:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDD02E589F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E44FB300C30E
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C238AC70;
	Sat, 21 Mar 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MsglYiEY"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020078.outbound.protection.outlook.com [52.101.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C029B20A;
	Sat, 21 Mar 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774099980; cv=fail; b=a10IMjRVtRM9TwwU6yk0W+snwrr2MgY9FtT4B6DIfnPwUHUwCazVpE+2fwZRFVuq1tx7mY1FVYp2lafhzWHas6c1ln02LwFLsOhJmRGWbUBYrYU08PhhkeUfagq/0u6WWf/dxynlZfYASzx1pTH2HIIfjMvXPEyNeUEVVJ/omRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774099980; c=relaxed/simple;
	bh=KnNG8da0o+wQ557zK/GV30pxKoLlM/s/tIOSTcUfav8=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=FGtahyCsOesj3GS7aUSIRNL00v3TJmW4y1RCJNrcSMZ4lkRaDsT/W1av0HCmsNCB4I3h9cXA0LhDRbCUY1lI8ymDWzGH1B+LSuGvnJ75sqZk42Aftn7toBfIlBmHNdj26poLMO80Z+MdU9uNwKH9rjxYLdSrVHd7wiLMx/Xj2yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MsglYiEY; arc=fail smtp.client-ip=52.101.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFYBsuDP6/2Rh7eBTuSwfjPic988FWFbL1e24z7gcR6jznkay5JGl7PsCF8PHN26StW+oHk6lg+qVBs4DVMo/3qv/ARdftDh7pUxFVWVrOKfJZIvZsEksuNoA9rfVeeY6oakth0bG+hgO4E70Gs642MPxDOKRQdvnyaPaiYLDpwl+l6JGeLRUJ+0quCU4Ue63ApgXxCAaFxqnVUs/DKk0U2ZZLkAmuib9PQbogSolJA7EcHeYgyt2OpNNmp9iYrdyDXhuq+AdXjsovsaCQqjY3/1CnPMLpT6fSqFdQGxPUDXIxx2rofSPFwvHQCxKuhX50lR7DC3U4zffjhjuiq3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq7pTxGpINBkuHcCHo/+wu74sh2yxRbCbu27hLadyxM=;
 b=SvZk5y9Pn1FUvKacbbZ54kCUIdLZPLO74qjrbvE8WGqNEUWYvmWUQ6k8TgkIeVAYYobHggyDcpLdweIUZh1ADFK6x/Wmj4w3/cinzhzmZX7q0rzGcESp8uiBZTv+r8+KFl8+jAmjcC7s8bm4KVsDJwxduxzMO5yP8y3LUJ9yDv/N1JY5mZZ/05cMNNplmRUDDRYE2VoCVKTA35xmsXw+byW9dO9yx0sHrL4JAuHTnk/g11RDQTmU9LMOIm3P1uEDBJGjHpoPW//aF8ZYI7Ih5Kp8jnLVCXqtTcCevFVy81VMisAeaCV72aZjDd6mnFv26V1kmMQnvzIIVxUsSSle/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq7pTxGpINBkuHcCHo/+wu74sh2yxRbCbu27hLadyxM=;
 b=MsglYiEYZ+K7vj1suxebCsH9l8AOrXyXOiiTseNnMLI9sgF6g5Ddht+R2XLYMURwo+a6wsSBDTY3172c0e9xxCTlM7CRDR6yyuhElKsu3HO5Fx2BURp37o/KjiFAcXp8ljH5YrhwIApPauZ/RyxfHQW0DJq9M3vyC+OOq5KM4Yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3621.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 13:32:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 13:32:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 13:32:53 +0000
Message-Id: <DH8HYCAIRCZD.2DXSNBFXXT6ED@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Waiman Long" <longman@redhat.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Yury Norov" <ynorov@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
X-Mailer: aerc 0.21.0
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <DH8HDA6Q6FU3.3JR57W97IO1VE@nvidia.com>
In-Reply-To: <DH8HDA6Q6FU3.3JR57W97IO1VE@nvidia.com>
X-ClientProxiedBy: LNXP265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::30) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6edf1b-c17e-4567-f002-08de874e5b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DawczSFBUzNWpnkJNijfZ56cVSiREUu8Ht1DtGAmxnANTvQQW5R1Q7SSBqo6fyv8xDImwPNuunpZQ8aXJ52PScP0xZRExrL8P4W9CNmIPw9t8201+SETAUPA8mdga0PJknGyiuV3U3CuGzMS8WzQW6wUhIwR9FqLZf0zh6rN4B6EN0jLY9FEpxamIkVFkJPxxtOZnQWqpRaR3SC4TbDqWMAQMHqCI4RgdbmzvJTs/Fem3bSHYUFkH51HVrN3NGBL7JFtqCz8ZW2KLxzw80AV17Wwv/XOg62oJyJ5V5x9e189V3U7P4D9sixU1RLkuy2W+BejDyEAkNHtigpxbZntze/ri94D/hhzw0D5vL5MQCGR8a1gFcFy6Rfz8S/y0v+SGmQ7/ikhcRETmjd4hStVJAcbYiGM/uuemoj8yfg3YDKGLQUrB4qRTYJpoZgTrOwo8muCQ7x6oq3uYHmSergbFnXsgWAGFYtdkuPcFli/OvUTySheK/T7ZL49OlT2gkDVsEvWx7fZ6oKCMndQrIwF+Zpb0qEvBTLXZQseMmnNeURiJ0Hof8/TGl5svNY7leC7wqCyy1YfUcaAzso5kfZCHTFBKJomCuBA6saXzIuREsli7KDJg3w2oK4sj5IGdjaKxdtTT5pc+jgM8pVAZruz/VqaSTC8HuCrTL50GBSUceJHRvtpud4pauGGGgSSXAsixR44yQvbsfwiziUq1XgTDu4fhu5jWn+urCIk4HrUnZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWdnUU9hRmNRUUl2d2svK20yYTBnY3Fyc2NvUGZvUHdDNTJPN3BiUURpSEll?=
 =?utf-8?B?czV4Q0VnWGhPdFlMRlNEV1BMaXhJQTdrcjV6OURDOE5md3FYRUVHU3k2THNU?=
 =?utf-8?B?TWUxSEY4ZmxyUndQU3ZsUnlER0w5UXVsK05DVTZ1RTNVTStQS09YTmU4ZGpF?=
 =?utf-8?B?bzNRTjlJMTA5SnRVdXlMZytibEl1aUJrR1k0ZG1OUEFKK2tDQm1qcFFhem85?=
 =?utf-8?B?azNEdHdBZWtJVHhlYnFOclJ2YytpL29QUy9uancvandhbitILzBjbitqN2FW?=
 =?utf-8?B?TGlkTXh0cVlNWTBjY0Z0bnViSkgrOHZwN282eVJIbGxyQWNEbFdLeWk2ZFdl?=
 =?utf-8?B?SGFubXJ0azdHaW5iSHVuMWNMMkpDVk9jajVwVDY3d3cyb2d4N0Y2OHNrbVhz?=
 =?utf-8?B?djZmZ2FlUVNlZG9VODhUekRuL1NGQ0xBVnNnTklLYjJnNHFIUkpKbTVYUnhG?=
 =?utf-8?B?cllqRDk5cXY5QjFveFNwaktZSnlQQ1BTejRjREpucDg5QnM0Zm5nVm5NcUk1?=
 =?utf-8?B?ZkhOMDdYVDNKR2VEVWgzN09ad0c0TnB1RzFHVGQweEppUmhoTWJQNlN5NG8r?=
 =?utf-8?B?cEQzV1dkZ3Y4eUVlVEpQazNRTzl0MlF6WlZNRitCeDZDQ3ZITlZleXVybk5P?=
 =?utf-8?B?VEJCaWRucGIzY04raktMZzIxMEJwTW1lcndKcFpabFN4VkZYTHFXSncvUWRo?=
 =?utf-8?B?blZsMXh0WjdkdnVPTW1hTGVueTlPaHdXSVZkWU5qSGwvYzExOXJ3aGZXOUlx?=
 =?utf-8?B?UWxBUUs2RWllbVA4ZXVjaGl2aHQyNVljckZWdG1CakJocHVHVWN5U1RaUy8v?=
 =?utf-8?B?K3RjSlNTMXlDT29xZzA3aWpoaTlwVkJidEdab01NZmdGVWFyNENGZnJRbitP?=
 =?utf-8?B?TGFSVGFkU3BudDFlTFlDdVFvZ0NaMGE2MjhUQWxsV3U3RFk4cE1uenJ2MnlM?=
 =?utf-8?B?TVJDdnRqem1xNEFpTU1BMk5kc3BOY2lUdlcrbmZnSVZWUU1uSmg5YWhadnBS?=
 =?utf-8?B?ZHRZN3UrcHByRVdJVHcrM2lNcmt1SHdBdjZZekFPOE5tUUNOZmJXN3dvK1NN?=
 =?utf-8?B?S044SDZnZk8zVGNVMjZaU3pnUEtPQTNrN3NBaHdPL3BQc3AwWGMvelYzS21F?=
 =?utf-8?B?Vm9DRm5tTTBnVTlmOW0vQUVadXhJaWsxR1NUYmN2YzRVY1JKRE9uMU5KQnhT?=
 =?utf-8?B?S2ZmaUVFQ2MyazFCdzlFZHFERFk0Z2dkRlc4WWU1OGtQa05EcFN0aURQR2Fp?=
 =?utf-8?B?T2w1RHd4MGVTNFNOaC9oMmdQbWc3Y0ZGbDNtYm9iMGVIYnc1a0hPZkFzbk9u?=
 =?utf-8?B?YTY0RWU4SkZSclJSSmR3V1Vpd1M5UFNQOWpSczNtR3JTci9RTEdVV1dnUGw5?=
 =?utf-8?B?M1A1TG1KZXJ0QVlJU24vMUpLMmpjM1lRa0pNYThXVTBaanY3OUhuajlUeEZH?=
 =?utf-8?B?NXptVjJQSk5IcENVYWVtNUR5R1BISkRkU3VONjJLZHdjeFM2WERVMVdOUCtK?=
 =?utf-8?B?WHhkdS8vSjYyMzJRbVhFZjlTKzM3TEJ0ZU9jSThxblQ1TTlzaEVxVXE0NUFz?=
 =?utf-8?B?aGNYVnlobEx3Rnk4VnBrMWpCVE9mK3ZHLytFc3U0alc5aE5Cd0NIMkF3eWkr?=
 =?utf-8?B?dkM2WjR3TzRIYTVoc3c5SjJ1V2tNa0R5VXppakxqV0ZrNEJZWGNZMUdwbTMz?=
 =?utf-8?B?WTNtb1VCZ280WjJxTkJXQjFMbHZ4WWtxYmxXWDdtM05MczR3VkYwNkMwUGN6?=
 =?utf-8?B?NUlaWGJtQm5vUnVSZ2puYmRjQ2NGKzNoSHhSK1cySG5NTFhRQ2ljditURTli?=
 =?utf-8?B?bXNkM3RSUHZuQ0dja01pekRqTkZpNHVUWit0YWt5RERJaHRCSU16VlN2L3Bp?=
 =?utf-8?B?MEN5ckYram5lS2h0YVdPb0Nwd0pQKzc3cDc1cGZhNWRDT29xOGR5T1VwUGh4?=
 =?utf-8?B?YmJ2L0wrVTBjbW1wVFo3VithNnR6OVFySklwbW9ybXFEMlZzRWN2ZVhrWW5x?=
 =?utf-8?B?SmpPZEU3bVM1UzgzVzg3ZzJ4ZkthVmpqTVBtcDVUSlVpV1p3UWtRbU9CaktC?=
 =?utf-8?B?YjdZYk5GUlovU3VyL3FVazhmRExaeVpGYmlmbnNFYUg3N2FlWktOVWlrMjRO?=
 =?utf-8?B?MnB6T1dDd2RKYTlYYksyaWU0RlViTkxwOTF0TThKaWJBZEM5cExLN0czOUY1?=
 =?utf-8?B?MmtiS0s1UUFYd2c4bkFEcDhoRlhQTEVnQTBqaHAzZUxSR3plbVRqN3RxbWdC?=
 =?utf-8?B?Ukk4cFdyT3d5N0E2Nm8rSEVTMms5YTVWbERZNTZYVHk5WlMzVW5pOEVUVkVq?=
 =?utf-8?B?UUFySXcrSHI0VGVJQVNKTDA2SmJPQXpqenhuVDRQVytWYW8xN0dhQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6edf1b-c17e-4567-f002-08de874e5b00
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 13:32:53.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjwKe/UPw1pVpUs8/DCgeNKVh6WBgvkOVm6JEK3ZR65vc8HZyWC1ErIMDTctjUsRF3hlvbQoySYSWYj0jnnGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3621
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270211-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid]
X-Rspamd-Queue-Id: 8EDD02E589F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Mar 21, 2026 at 1:05 PM GMT, Alexandre Courbot wrote:
> On Thu Mar 19, 2026 at 9:16 PM JST, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> Given the macro scoping rules, all macros are rendered 3 times, in the
>> module, in the top-level of kernel crate, and in the prelude.
>>
>> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
>> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
>> re-export inside `build_assert` module so the top-level items are hidden=
.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  drivers/gpu/nova-core/bitfield.rs    |  4 ++--
>>  drivers/gpu/nova-core/num.rs         |  2 +-
>>  rust/kernel/build_assert.rs          | 19 ++++++++++++-------
>>  rust/kernel/dma.rs                   |  5 +++--
>>  rust/kernel/io/register.rs           | 19 ++++++++++++-------
>>  rust/kernel/io/resource.rs           |  2 +-
>>  rust/kernel/ioctl.rs                 |  2 +-
>>  rust/kernel/net/phy/reg.rs           |  8 +++++---
>>  rust/kernel/num/bounded.rs           |  2 +-
>>  rust/kernel/prelude.rs               |  3 ++-
>>  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
>>  rust/kernel/sync/atomic/predefine.rs |  2 +-
>>  rust/kernel/sync/locked_by.rs        |  2 +-
>>  rust/kernel/sync/refcount.rs         |  8 +++++---
>>  rust/kernel/xarray.rs                | 10 ++++++++--
>>  15 files changed, 61 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/b=
itfield.rs
>> index 16e143658c51..c3e1235ad7fb 100644
>> --- a/drivers/gpu/nova-core/bitfield.rs
>> +++ b/drivers/gpu/nova-core/bitfield.rs
>> @@ -170,7 +170,7 @@ impl $name {
>>      (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) =3D> {
>>          #[allow(clippy::eq_op)]
>>          const _: () =3D {
>> -            ::kernel::build_assert!(
>> +            ::kernel::build_assert::build_assert!(
>
> Given that the `build_assert` module now hosts 3 different assert
> macros, have we considered renaming it to just `assert`? Otherwise the
> naming implies that it is more connected to the `build_assert` macro
> than the others, which doesn't seem to be true.

I personally view them all as variants of BUILD_BUG_ON, hence the name is
`build_assert`. I thought about `assert`, but to me that feels like it's go=
ing
to host runtime assertions.

I won't be surprised if we're going to have `assert` module in the future t=
o
host families of

    assert!()
    warn_on!()
    unsafe { assume!() }
    ensure!()

etc..

Best,
Gary

