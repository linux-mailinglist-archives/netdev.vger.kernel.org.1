Return-Path: <netdev+bounces-122432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A03A961466
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F9928328D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46551CE701;
	Tue, 27 Aug 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMGxfofh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255A54767
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776926; cv=fail; b=eCGwcaM+sdJfPUSojukuPBfs0tl3/zLyGjVQ7CZmLmv/qVBZzoDq/xnEKJ5xeS2KBO1QVsBdB/BnTkD4ik0UFufPaj6iCgmqnufUUdH8Qqw7ZESmBMs7ye/DiVK+sFRzOwCBuN3rw2ErqWEzEwJTkCdYRqA9FHKwV38ljotFDi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776926; c=relaxed/simple;
	bh=St4gMV9I+Rh7TZkOCL44l59eShFjfieTRfMe6Dt0TwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CpzCRkt8mCS/JxfG062448DTeEKc3IztlsfQseMjQtsQIvk6wIWKQs3BkNBcYuuPVUOMAQjqC6yrGUNeBvbU35FcbkWj74Uxovvcc0Dzcjs3eKtgi/bCx481GmVUisKgWi03M+FGw1w/T9BJDZ7bEK/ze+fbSJhzL1fYqzpQKT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sMGxfofh; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO4rBlDdKGKzKTaLJ2WLAcgNKrBAQsjFbVxxUJnMuO/Azgi8vn0ZCJeG3mcw9diLNTfq+wQAPheQzeU5uRCwpGyc1lYXXFYp3Eh0jIAHxH97oVoX0rFaCT8aB2BFyHwx7jEaLvUm5timPXmU0kMdUAZFdg9s2nkdnP/ui5XeEVJaK82X5xC84kI8uSu8cZSYb62NfuBLKzbRrSWOvD3sbc6HpU30rqnUxAreY1qRmE6N+aqhdY7sxdWzV4QSkyemCLU0t79e1iQ9OLQhYOwCDFowkh0nHe34jPHqi7ict/5ifK9g+Ak46SJkle2IC5pafdlNijVKMk5pBForo1J4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMULgVJe1OvKybehasRE3w+Lzr1Bhpfls9C4MDWdDF0=;
 b=BljTQtzOwc/efM3OS6sKZri6F/SDJsBqAyuMDDICFweazBSNTP5HveDLUGmFnk8EKVojqSUviVSWb9gsiGsMWkzF93LE+FeELJCD5mXIuOGwFhtWkCidNr35AxfDc88W2sVcPTV5H+RHJS68qG8JrhJxRQ6pO3C4XOuOGQIEk1jtK8mLJN/n+faUT4kSvUH/vqQ+CEJFOVln88wYSm+2CKXHyIz5U4vHgq5dcB067KG/fWDx/UN7sxDaLPBMviWhI4urMszQM5WuunDrrFgPXZrHPw/qwLaCVueEo6a+7Re/r92hfT/r6w50Z3uWP+zFSbEN120Z5R/whyiVAGXIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMULgVJe1OvKybehasRE3w+Lzr1Bhpfls9C4MDWdDF0=;
 b=sMGxfofhks9GJdkJoBb25jRE4uf7EuUy+d7+ugPMXCLCqN/1KE52opUSD+r6B8uux7DtYvmG+1Dfsgc+CnEeyg9ZlbluBJx5uoNuwfCjIlFXWSxp4RQN7sKVUvbD/qLg8EYhHVAiSGuDOh3nhaZNbUE3A9glEfZTftKEHC7BKqLUnSSJf1W5EA8KexS1HmmSJGlBywWYsk8LdLeMwHylmNZm3CaAPWZb2SgTrHFHaDdK2qEIQkuB5pgqXCPtOr7Hky1BzZaS0FkKtxFjd2atrqeG/RfIcmg3i4JgwoiVWXuvCmztmW6aJtZQ8LQJPiwRz//3oPfTkAiKvX6hyUOsNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:42:01 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 16:42:01 +0000
Message-ID: <d66b079f-c6b7-48c5-ba6f-68cc3e43d1c7@nvidia.com>
Date: Tue, 27 Aug 2024 19:41:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
To: Jakub Kicinski <kuba@kernel.org>, "Arinzon, David" <darinzon@amazon.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>,
 "Chauskin, Igor" <igorch@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, Parav Pandit <parav@nvidia.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
 <20240811100711.12921-3-darinzon@amazon.com>
 <20240812185852.46940666@kernel.org>
 <9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
 <20240813081010.02742f87@kernel.org>
 <8aea0fda1e48485291312a4451aa5d7c@amazon.com>
 <20240814121145.37202722@kernel.org>
 <6236150118de4e499304ba9d0a426663@amazon.com>
 <20240816190148.7e915604@kernel.org>
 <0b222f4ddde14f9093d037db1a68d76a@amazon.com>
 <460b64a1f3e8405fb553fbc04cef2db3@amazon.com>
 <20240821151809.10fe49d5@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240821151809.10fe49d5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003837.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:20) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a05d7e-f962-44fb-0de0-08dcc6b72c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFJWWGVhbWk2blI4LzZUSy90NHBDSnFlSGpHdDZnaXBJS0dLeTFUYmFjenQz?=
 =?utf-8?B?SllxVGhqQ1RtOHlmT0xEaWlkTVpRbTd5WnJvT3gyWkMrQ1Jhb1NvZWQya1Nt?=
 =?utf-8?B?VE1FWUQxOFJrM1RBeWxEY2FPdjh4ajU1Tmw2R09UTlZjS1RjNEt4ZFN0eVNP?=
 =?utf-8?B?K253czU3eDN4aGx5cG1lUmRhdFJRbys4QkhaSWNDYmwwRm9GYWo0VDJZbUwv?=
 =?utf-8?B?bGF3ZVVsVVhCcThqRG5TdjNFc1NYVGZ6RU0wM1BGclN2dkRKTERqWVhrSE85?=
 =?utf-8?B?NEozYVUxN2JNaTYrZVNCY0ZVK1RZcGZMQmd0T0JQeXBFYjlYRjRFbDJaNTBV?=
 =?utf-8?B?dUwvNzllTFQzYmEyL3d0NHhoYUJaQmtTODZkdFYvOUZ3UnRyMGg3cE81U2g5?=
 =?utf-8?B?MVFmV1J0R2tZV3ZvREpuRzVnbW5BdVJldWJxVitsMGlXZ2ZreWVjNTBrWi9X?=
 =?utf-8?B?bi9sd2tGZXdUZ0Z3OUFzeTJIUXVLclZPZTBpWGVmQU8vSVF0N3czQ3lRZGYw?=
 =?utf-8?B?NlBOaWV6aXYycVJhWE5jeDY3S3RpNDVEV1B4cmQxSVl1QVNMOG82ZSt4N1My?=
 =?utf-8?B?ak81RlN0cy80L0N5RmhraXVER0RacURwZFZFOGMwdkR3NzQyZWlnSmsyVG9L?=
 =?utf-8?B?UVovdnpVRk1UejFvYmNZQTlJWHorRDUycFBrelMxTHhXNFVVbnl6eWcwVmpC?=
 =?utf-8?B?czROS2E5YnQ5WUQ4TGJRMzJZcC8vSUF5dVlTMzRzQUJHVHU5RjNmNUhtOVZ3?=
 =?utf-8?B?MStZMTB2Y2c3N2RGSmlTa0hIVk43VGVEWWdVUmpYQkdoRnZFenR0a2FYc3RH?=
 =?utf-8?B?M1RLejU5VElmQ2xYcUF6Y29NaVVSai9rQjJqNkgyVkVxMjQwQ3JheGhMQXdz?=
 =?utf-8?B?WG5iSWdrR0pNOXFoKzhiUzNFNFFiZWtpUTdqNTZJZmZWcWtpQXFJWGNuK2pH?=
 =?utf-8?B?S1d1Tm4vVjNoVU4zL1ZBZVVSWElnd0JCTnJSVkJsNVRweTZGblBuL1k1VXpW?=
 =?utf-8?B?aURreVZCQ0laOEdnelJqRWliR2g5d0JQK2NpdVdGUGFwTWI0OHFOTDEwdzJt?=
 =?utf-8?B?V0hTdDF1bEROVmFIWWlpNzdHZjF0ZkJaRGRKNkI5dEVHb2oxb3hrTkJqd2dV?=
 =?utf-8?B?S2dhN2R2UFRjcVRHZDU4dE53M2JJN3dWcGp4Q3BaWWRkcVZvOXNkQUN5eHVR?=
 =?utf-8?B?N3Z2Si9wNndJRWpTU1pEOEJ0U3RFU0NwV0xnTzZkZHRGVzEvRFNmQVV5aTRk?=
 =?utf-8?B?OHg1S2hUTmtvY0V5QnhVQjc3Mk96UGpKNkpZWmF0Nm1ESENIWnJJaWZLQ0Jq?=
 =?utf-8?B?eGlxcmtZTGlqaXJLeFFNSG5tTHhuSnZicmpYWEFwVUY3YW5VZGVSSENOYjlZ?=
 =?utf-8?B?OVFMOU9TTXo1aDdvMzBpZzRJUWZBTGJWRHZUMWtEaDQ2MEl1c1ArZklHUTA4?=
 =?utf-8?B?cG42MUdTNXJiU2lEUEk2R1hIQkxQT1pCbXMyVWpzZmNJYXU1Mk1jYzg2Qmht?=
 =?utf-8?B?N0xFcHJtamtWOUc0a1dTaDF6U2tEVTJwdENnOS8rbnFZcGcvNUhOVlVrSDEz?=
 =?utf-8?B?NnZibmorNytsVnhNZVM1cnJGZDVCOHpEQlhQK3RFbkZOOGh6cnQ2OUxOay94?=
 =?utf-8?B?TlF5UTU2SHVYK09GbDc5Z1NkVzdjSHNWdWczRmY5azlKdWZ0RTRuRHVxc25j?=
 =?utf-8?B?RmZTamxLaEtvOW8waWhmdXNQRzVhYnZBSkJ0V2RBVEVmWWMxVllkVWtLMXlR?=
 =?utf-8?B?THdNWExaMGUyelM2MVkyMWdHblQyVFNDRlBINHRma3ZibXRSRkFUYkxTNk5Y?=
 =?utf-8?B?T0lWM003cmRqOFNhZmxrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnNIRCtVNnhjV1FEY2Y1enZVWHRqS3FFQ3VkMWNSUGR1NkNSam9uMktUdkpT?=
 =?utf-8?B?di9FMzFCQzJNYnhHN2E4NUZsVlAvL3BXMEpsUXJ6TmlieS9SeEtCNnlTc0Rn?=
 =?utf-8?B?RHVmTG5WNWFZcHR2K1VHam5iV0JwYi9qa2JBUURNRnYvYUdIMnRvL0M3OHY4?=
 =?utf-8?B?MHplanVHZy85N25EZ0ZCQUd3ejFaV09lK09NalEvd3BXbC90SnluY0xLOXBz?=
 =?utf-8?B?V1NVOE1QNDI2eUdhbFo3Ykk3Rzh4SGkwYzNaYUpDaFBsL3lydDVucWQ3eTA5?=
 =?utf-8?B?WTE2R1lBVnN3dmc2YUgvQXNRa2t5Wk9OWUxzMFkxNk83Z2JLVVh4cjBQVTgv?=
 =?utf-8?B?Z2dzL3ZGTEJFUHBQOXF4K1ZpOHFjbG42Sys3akZ0c25TMFA5VFg0OEtNV3k2?=
 =?utf-8?B?NnVVelUxVVdzTVBaSHBzWHlOckJDdllKNFd5R2h5TDFQa1BEYWFuY2gzTTNV?=
 =?utf-8?B?alhjb3ZsTU9uZEdnWExPa3FKaDJWN0VIWExCQjdoMFk4cFFOVGc2QjJLbU54?=
 =?utf-8?B?K1pZVXhNZllZeHdsc3cvdmQ4SHBlcG1DTSt1RzZYQkU5ZjlQRDcxSDBRZzU4?=
 =?utf-8?B?aW9yTzNhbW1BbWEzQTFKS3M3MSt2SDU5dEowbGNSVzBySkhBYnQwQzQvcUYw?=
 =?utf-8?B?TXRCSllWRDhXMTJtY2gycXRtMDFkZDBwYmV4RGZXTERpeGxWQ2dHMUNUc2Zz?=
 =?utf-8?B?bkRaSkJISlJHalBDSTI2ekZsWXlNK0VZcUtWanROK2ZKblE1TkpnRlFMQW0v?=
 =?utf-8?B?RUpaOUlkZnFvRE9HNkFTS0pCakdPUXlPeUJsWU1JNzhvRnE3ZUxvTmVLdUZM?=
 =?utf-8?B?RHBQSDlMWkE5SXRPcnNwMmVIR3NGOVFRcmxmS0FTNDJFYUtXY0tYR3pudHY5?=
 =?utf-8?B?THo1MU1BdndvYlNVemFVRVhaZkszMzNweXo3RTRPczNPejhlajhEcmpMRS84?=
 =?utf-8?B?dXA0N0tSbjBBYnU4ZStWR3lTSXBKWTl5bjVGeFlha0dZcmhZQ21QY0ZhYVo0?=
 =?utf-8?B?TDFZZndlTm9lKzJvZENwRFRzYzV0NUVrSDhBUE8rV202LzRkeWVZZVorb0dZ?=
 =?utf-8?B?aWRjSFBDZDlDeEkyak9zM3pYM2MzUDNlWkpjOEJoSUNVQ3JZczVOYXhlMy9H?=
 =?utf-8?B?MnNYcFRpbjREeVVTeGYveGRWWVg0eE4zYTV0SmxCNnFnK28yUWFkaUg2djg3?=
 =?utf-8?B?eGRySUZ6cXkxVnBKQ21CcTZBM0IwWHpLcVhaS1lSVGhva21pMlh4UVZPL29s?=
 =?utf-8?B?SnRBQkJ4TWJuRkh3TlZVNlhwVmNjYnJiS3E3MXlGdGpJbG1XeUpWOHhGdXBn?=
 =?utf-8?B?N1JtUnJCTmdYVFpNZmM2UGJOQTNLdlgyb29xU3paOGtYc09OL21jeGVQcDJn?=
 =?utf-8?B?N3hXZkZGcUJLZVFUbFhoZW5DQnIwVnFnb2JvZnNGYmdscVViNHBpeFpPTGlM?=
 =?utf-8?B?ZFFENUNSc2hHVVhqcUsyZHU2UVRKbjFTVU1zUitOeTJSUndOME9ub2MrVGlJ?=
 =?utf-8?B?QURaL1ZVTUcwU2w5VTRWTnZITmI5VDRFbytiVVBSZlAxRkV4US84dUR4TlQ0?=
 =?utf-8?B?VHFxZjRWeDl1cXpoNmFJYWQ5UTVoZ2dFVkNEVlBEU1NEODl2MGkzL0hGNFNn?=
 =?utf-8?B?c3dPZnoxdE9BZy9FZDVSOW1vUFZYQWFqN0xsR0Uva2hNbmZ0QzFUTU9OT1JR?=
 =?utf-8?B?L1F6M0FtRzlBWWd1dEh0S0R4WTlZS3FRYStBM2JMdVcwSzYyYXEyOXhDQkE2?=
 =?utf-8?B?N05BcFcxcEh0bnJCTXdsODRzM21YNm13a3pSNWRKeGduQVg4NTBnVUgvb0RG?=
 =?utf-8?B?Zk00SXczRThKUHhZcmZFdWIrZzNXZzBWcytYdXBhcWxXdUFxWEgrM3dMRE45?=
 =?utf-8?B?K21UY0V4QnlpeGgwVUVqVmxSYTN3TkRGTzhwcGE5YmgvSzFQT1k4SDhrZE1p?=
 =?utf-8?B?R2NRcUl0eGhWZlZGc1BvczdPZ0FZek41aUtGVkpJWXVhdHB4bkhDY1hmUUpk?=
 =?utf-8?B?b1VWTjRiZDNvQlBpVm92Tk1QZ0ZSKzZVUDJra2FSSkFKZE1Nbm9iWWJremNO?=
 =?utf-8?B?YlBad3FXR05QaFlyS2MzY3Q1Sk4yeUZmMDhiRHBHWnd3RTZmNjZBcDRXMmVX?=
 =?utf-8?Q?pIx/TkyGmOJ6jpBeZiU/KK5M2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a05d7e-f962-44fb-0de0-08dcc6b72c8c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:42:01.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kir1BuylGA2p7xVoPsykc1aiYkUIcf+DDEQRdOdlKNFarW6eK29Jyf3LQxTOf/zk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

On 22/08/2024 1:18, Jakub Kicinski wrote:
> On Wed, 21 Aug 2024 18:03:27 +0000 Arinzon, David wrote:
>> I see that there's no feedback from Xuan or Michael.
>>
>> Jakub, what are your thoughts about my suggestion?
> 
> I suggest you stop pinging me.
> 

Note: my reply does not mean I like/agree with anything I saw in this
patch, nor do I mind if it gets merged eventually.

Still, given that the counters in question are already exposed through
ethtool (which was very unclear from the poor commit message/cover
letter) it's kinda unfair to hold back a patch that changes the way the
counters are queried, or adds an additional counter which so far no one
objected to.

Perhaps David can show some good will and help sort out the virtio
stuff, or push his team to expose counters that match the netlink
semantics, but this should've been the "blocker" when they first
introduced these counters, now is too late.

