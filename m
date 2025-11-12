Return-Path: <netdev+bounces-238008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EEC52B2E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DDBF4F1754
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484342550AF;
	Wed, 12 Nov 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7Ei2ge+"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403521ADC83;
	Wed, 12 Nov 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956223; cv=fail; b=WmVBgAsaTmjG9hkh9YSWVLjg1NIYihFDb9nI19PWJpXayvlfn24mOpx98n0I+pgR6mJ2ZTKYlDxW4cnpVb4/nvS/sv+T4n83RZ7NMYyjjt2I5o9nGLodGl+AfcbK/yod3iFPX/Bwm7tZ4PsEN3kSpPiu3sCBeQwO1jKA0vloLTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956223; c=relaxed/simple;
	bh=f2C2Ond+i0iwSkBjQuqhdJ83V+jUu6IngcgH7KKrVfg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b0JxG7YtXxkPtRMQawMle7bu5liRVWhyQG7Jt6YAD1fxN5lyGq/oU9NPFacIZ0MXZbiIEB26DVoi3KagHhQyH8dUs3S8nUwFKVgPdc12eL9K0U6d1S593yr+nhMPIsaYhbr6VI9FG/9vGQXkwjNErdUWa0s006Oy/RjtrwMcYTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7Ei2ge+; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrUGkoCpxTgTARY5tBg85Irxh54Qy+KYAPW+hZn9uSswTbsyQBiNOzkT/53bbOxJDWPenE3UYeMzQ41gX/zpj36YlXXlPA+24tlamnLwvwqJdKY0c4DD9m2ezavPLoXfj0+EuNSfXxtIr582CeP2aIyohAk2/7dEq1pkwdbo9x7p7DCIKKQ1y7LpF51XBfDPdaoKgm8G+zPHBk6gfmANV8A4XY5S7Aya8+6TRzP5Hnt38zsdogAzyT9TLoxLCkOMVrn9rBAf/ux0I043KNACmtQzEjtmMv6VcpIQYSPBEvCem0iColutQx4UM70FFMZQEUPtdY4RVmUsK+Pms6+YSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fobXrx5Zn193mTMQnHCx+jswQXfMnyiVuPO+3P/+0ek=;
 b=f7M/1Hj0BFgoPh6q23yQHgoVxCamOK+CmY5gClU5nhvYiUyQJChhjnq89peaDSndzlFlIxQ0xdnbkJvXohxJFo80HmDVsffI3mMLzsv4q+gI+AWXFf96qkBP2qlzQl0GS5YHMpo2+RI3KvNWLfSgUN/FKOjuBuWVegxxtSf3CnFk9DO1/KY/W7oXqsnAfXG+dbzfScvXY0Fl66g/b9EN2dhJcHtv+r7u/FYepLeNcfGjjeKYA8Jx3ZW2rp8vfUI90RdXoiI49QekpE1hoThGUnYFguTasELL9uR6YopaPPpDTSM2wsybr555YM9f4RSO8aFXUquKqHvoNIZIq7vFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fobXrx5Zn193mTMQnHCx+jswQXfMnyiVuPO+3P/+0ek=;
 b=r7Ei2ge+mg0Ynd0uiiAHroQD/Uu4fmeZDrRxCOkzhK1v5Wi7oVR7UAHyXJqlX3JGgUxXvZiv5OGkpZ3ekFZ/2Biq6l6mXmUP4jDyOQS1plRoHA+mdECbyKSPfxqOYM4dlgM8RlSkIYRhdDqkGY5vQBlMmqqrbF0GoSblHBzPW8zR49COleo5P1Tt5sS2LOcwujCIbEq0Wv9Ho3Bx+Mla0o6s+xNshSjpwrW/nwzR5l1o1iNmkfVA5AIwQf669jnNZrrgglQSPMJAqbUnJA0MCLrnszJK+gbWeJP8BUBlQ+kRosWOVRqD9MzHoLKEEND3vBpJyuZ2gKBid+hIgay9uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:03:36 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 14:03:35 +0000
Message-ID: <7460a188-3a74-4336-ae03-c88e21ffc1ca@nvidia.com>
Date: Wed, 12 Nov 2025 14:03:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-3-edumazet@google.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251106202935.1776179-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 222b6319-bd4c-40e3-28af-08de21f4457f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0IwQXZva1dTL282ZmNIOVZ1VHJIVmFSM0VzVWNyMmFrU1hyRk04ZTJpSmJq?=
 =?utf-8?B?bGdBS01MZ1lEcUo0Z3ozZ0drT3JFbSthUit1dW9LNlAzdTVBYVMwQlBtMmU1?=
 =?utf-8?B?dWpPeUNtcStUVS9zMG9aUDZTVkJ0M2huSk1xaUtYMmp1VFd0dXVZcStwWkVP?=
 =?utf-8?B?L04yOXVoYkZRb3pRcDdIMVlqamk2bkF0TFR5UnBqK21ZSWpBMUJvY3NYcUdN?=
 =?utf-8?B?ekl3SHhhbTgwSFp3UUFjN0ZwV0RoMTg5WXlaYzQxV295U1g0a2ZSZHhjNldo?=
 =?utf-8?B?ZkFuRk4vdm1jUmRSMW9BczVLREpDM1dBaU9QRnMxSVVBc0orZ0tqcXFadDQv?=
 =?utf-8?B?YjEwdndUTGxoYUVKSzJucldDWmlkUTM1VGpwN0FNa3hpeHpteFNMdEJYaHE1?=
 =?utf-8?B?dUFvNlJpRk5SK3h6MnhLMG5FS3daeFhiUVVib2UzTGE1S2czaHo1cWR1a090?=
 =?utf-8?B?OVdWZEg0Y3owaTh6TXFTTHdHL3BJQzZ1cEVrTnQzMUdwOEF0elVteTBaUWJu?=
 =?utf-8?B?dVU3Nng3bFc0dUhsNXdBbnV6UWZ0UlJiYTdkeHZkTC9NYlpSTDgvUHFhaUlZ?=
 =?utf-8?B?N1JXN2liKzhYdFNmRXFFdk41SXVnb2VuNWpiU1d2amN2TUhTbGh3SkNZMzdL?=
 =?utf-8?B?dTFrVUw1cnRydXdmRkhUV3lrRTJrZi91Y1JIOFZ2N3A3dnJLUWFsQmJEMFV4?=
 =?utf-8?B?TWJ1RmZOZVFHL0JKNXpud2pWcFFCQ2Z5U1FGKzd1ay9MT0QwSGg4dkNaZ1Nv?=
 =?utf-8?B?VHg3UU9pUlRSRUV0MmhrOVFTUHprbzQvWDBwdU1VQjQ4Rmh4NjFnRlN0Y2Vp?=
 =?utf-8?B?T1Y3WHl2MlJDTDFZNytWODlEZWFhRC9ORjBlU0VRUlBla2lNaW95Rk9TakdU?=
 =?utf-8?B?bldHMWltQmhkT1JyTlpkL24rZ09NYjNVMVcxMFUwMWtSakJhL2dqV0VGU1B2?=
 =?utf-8?B?TDN1Tm14S2lLM0hUNzlBSzhFT1A4ZzZBRlBWbUpLdmtWZmdZY002dUgwdUJG?=
 =?utf-8?B?ZDVmSFBZSWh4TFVBK0RKMkVlUlp4T3pxcDJDZEpLeGNleDlPR2NodHVpTzNk?=
 =?utf-8?B?dkNhK21rS2VQZy9xREE4RGY4LzNHcG1uUVZUekk3c1dad2hZUVRMMUV4b1Np?=
 =?utf-8?B?dHdJKzBOYVVBbm5UQUNPNmFWU3dQT2NOOTgvUEZtWFJCdG8xSHkyUWc5WXlX?=
 =?utf-8?B?UlF5bUVJeGdLdEgxVEtMME1WbldyazVzNXRTeDN2Nkh1QW5KN2oxRlRZcTRH?=
 =?utf-8?B?bGhVWForbXBHalkwS0RMV3R3ZnVaQ0ZieFJFYTQrU3M4dmRReWJJNU4xZUZ3?=
 =?utf-8?B?eGIvZG5VQmhhaHpPSWRzRlhMQkhIalZqKzBHdjF3S21Za2RXVGZySS95ZEtR?=
 =?utf-8?B?T2J0eGgyTEpGZDFObWpzZ0ZjSEFVMVJtdUdpRHFTaGEvZzBrR2lienZDVDMz?=
 =?utf-8?B?MHJheU52c0xLZG1uL05BaURuS3BHU3RhQlYxUDBRSEliRXZKY05iL3BQS0lT?=
 =?utf-8?B?bmkrL2xsaVBGbk0wNkJiZzJuNnAzMU1RaFBGRGxJRTZtTzQ2bFlRbmk0cDJh?=
 =?utf-8?B?aHdMVm5hY1E2UmpJNnhiVXFYd3dXa055WEFWVlYyVmJLN1pSSng1d09MVWZG?=
 =?utf-8?B?TUg1WFhrTXdyL05OWkZZdzBqSFJpK0NSbGM4SkhhdDN0QVEybk1Ua1FldTJz?=
 =?utf-8?B?VlZhbVpJamc1NElKQk5BMEtjR3R2VHV1b3VEbUFURFVuN2lUeWhQVi9xSjRU?=
 =?utf-8?B?YzhlVVV4VXovUUVSVnR0cHhzV0U1RTQySGNXakc3OTdEdFJVM1BWd25DcitN?=
 =?utf-8?B?UFljb1ZyTXIvaDRKYzlVY3NXcEpVZTVRQ2JZc041bVNNanVFQStrcndTYlZr?=
 =?utf-8?B?ZUY0a1RUQXltQldTb1FBTWwzUnZHQ2NoVk9FZlRmSEVuNVFXSUxmZ0VkVG5j?=
 =?utf-8?Q?ZrDTLsS/CDtut+JdPYl7LbUdZVoB0oZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnI5VTdQeHNLc0pQTFdGVkVvWmUxMk1sdUVKRVdSMDVPUEJzd3BRYWQzLzRB?=
 =?utf-8?B?K1hpZzlkams3UTlZeDJiUEs1ekd5eFRSNkMzSnd1K3E0ZURLcHhVYnBwZVFy?=
 =?utf-8?B?ZVVZc216TktBWHFOMmo3eU9TZHdnR1RRWkpYSGltU1A2V2dEZlhMcEFzaThm?=
 =?utf-8?B?VXcrWHhvYnNNWm5FVHdGTUtsSElOQ0Q4bnAyTE43Z2ttTlkxdHlMQjdFV2xR?=
 =?utf-8?B?emZ6eG9NMzUzN3AyVTZpdUZ3ZmxWQjRvcERCUVptelNTc28yZCtIUzFtb3JW?=
 =?utf-8?B?bjNpa3YyNVpmbXNCYk5LVEtHbGtTcVRGTDBadXorV3c1YnNXRzM3OTBzT3ZJ?=
 =?utf-8?B?aU9aRExDcXhaTk0zMGI5ZWdNVndQc1ZsSStHdE1pUzJGVlNzb2ZOSjlTMldn?=
 =?utf-8?B?S21wajVvODQ0SjZWRy9Wd1pIdC9uQlFEVVpyQXlIendMbEFoMWJTTEQvekZH?=
 =?utf-8?B?M3Bzd25HM3NBLzZwTmxPMy94TGtxM24rVmswK1ROWnUxYlVzOWhyZGx0a1lv?=
 =?utf-8?B?bys2VWVSTEw1LzhzQWpmc2tZV1VxRlFER3VYdU0vKzg3c1NUSnF6NnJVSVk2?=
 =?utf-8?B?Mml1K2FsdlZTRlBiamlQMjBwbUxBNEVJUlVYSzMxcHpCdjduQ2RpdEpMeHlO?=
 =?utf-8?B?RkZGSG0wRDJlc3AwOFNZRFJ6ODgwWjJUMnRvaUc3T08yR2prQVF4c0NmQjRM?=
 =?utf-8?B?bGI3NkNDc3FWRUovdWl0SlJvVzBZdTBHeEgzdk4wREVzOTRIU2M1NCtrTlIz?=
 =?utf-8?B?c0VZWDJ4R1RQcStDOEtpZm4wNlRWaWY3V2ZPUkx1WC82RXpJYWt5N0VRVmY1?=
 =?utf-8?B?alRra2Z4aG85akNXUkVtOWJvVS9qYWllUHVjVkZWY1lvYm9ZRFpodVVkMlJm?=
 =?utf-8?B?Smg1M0ZKbVVyY1ZiMkpuNUhtY3dha2NGYlpPVmQrR0R2dFpBd3VNVzIvNHJS?=
 =?utf-8?B?TUNpWXpwQUs3eE1CODNERGZLazdGYjBWVFRQTHF3N3FJTXZwMWVlWHZOTzU2?=
 =?utf-8?B?a1E1cWhtM3NtMXNYMlNadE13RDRjSnE2Nk5oSUNBVnIwZVRoY0liS3UyZzA3?=
 =?utf-8?B?WjZiaG9QUHhlc0o1NnQwMjExdVV2aG1NancwUGdmZWRrTlB1THZWN0JuM3hw?=
 =?utf-8?B?Q1Y2QS9pNzZMRmhVR3hQbStOcEsyd0k2TWVmNlc0cVhKcGUwSkQ2U05DSzVl?=
 =?utf-8?B?M29sL09FeStDdWZpQjQzOGs5Tkp4R09ucXArblhrYzEzeEFnTFowL0h2NmRK?=
 =?utf-8?B?SXFEY2tYT24vbjExTWpCL3AwUVBLekhuM1RFOGNwUXIveW5NTC8weXNudVBN?=
 =?utf-8?B?ZDdEcjBWR294Y2VjVC9hazcyZktRSHg2VDhYcjROQWJCQ1FFQXZSVTVMM3ZR?=
 =?utf-8?B?QjdTWkxKNzZMTkgvUXgvWE5heWxYTE43anFaOXJHLzNEZFp2Z0U1cXJCMnZt?=
 =?utf-8?B?Tmt1RUNZOEdZWExwRHE0c3VTcE9xcitEV1N0RHpCZjhpSkFyUmg1d3BLak1Q?=
 =?utf-8?B?L0dod2JyM1BTcmEwSjdLZGllcFN4OVU1TDYxZGxBRzVpSkJ6eXJaUTBrNklJ?=
 =?utf-8?B?RTFrQ3B2WXlFTnlkRlUzN2p2QlB6NlNGMHhIV24rTk8rdXN1YWtNWUNjbi94?=
 =?utf-8?B?OXhuQjlWRXUvWUVZazdWOERRTFFleGxYN0ZrWnBqZ3Z3Wk12UTUzeUMvWTZZ?=
 =?utf-8?B?VUMxV3U2d2srQjBFeXpXazRRZUZHUUlmMjRkVm9WUnpMQ3VDaEllN2p3UWNJ?=
 =?utf-8?B?Rkg5YzdNTWdkYUNKSlh2bDdSTlJTODgzUUFvZ2tnaG1kUE4rbkkrcVZWaDBp?=
 =?utf-8?B?d2w0S2d1T2xOZjR1NVgvNXZyWUhSYWhFR3J2SFFjQkVKaU5IWkhlcGxUUWNN?=
 =?utf-8?B?VWQzUitqUzRzZzdXZzU5U2dZc2RTeEZENEpPRXJIOFdUTEhuaHVTamdtNGR2?=
 =?utf-8?B?eE5kbUVZdHY2YVZPU2UySUVlaXc2QjhTWEJvbUUzbnUvWjNoNFFwSnVWdXA0?=
 =?utf-8?B?L3ZqdUM2SGpBMVA0M051OVYzdnl0NjhENVRoTGhzeXFuTHVrRHFxbE9FTXlQ?=
 =?utf-8?B?UDNiQTdSZEdmYXEyNmVoQStuejFvelFNOWNBN202bllOZHFvbmpMT1lQa3ps?=
 =?utf-8?B?U3BkTWFWcHl6TG1TRnNmazRCMk43ZVFzckVrMWRXMWc3OUhmTDRYRVJzeTFt?=
 =?utf-8?B?TVlWNzNpR2ZJSWNwQ2xPc015a3N1VlN4Mjd4TXdXS2h4OE44ckU3Slkyekhu?=
 =?utf-8?B?K2VMNzJtU0R2N2ZlTERFZjJwWHl3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222b6319-bd4c-40e3-28af-08de21f4457f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:03:35.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3fUTpurrl76i+Sc3HLhgJy8cB2JO8yydeGW8NhdibAXlIF9OgoVNcU0H0wsewTMbHvoEU7rOx7o3/I7Zb2qBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203

Hi Eric,

On 06/11/2025 20:29, Eric Dumazet wrote:
> There is a lack of NUMA awareness and more generally lack
> of slab caches affinity on TX completion path.
> 
> Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
> in per-cpu caches so that they can be recycled in RX path.
> 
> Only use this if the skb was allocated on the same cpu,
> otherwise use skb_attempt_defer_free() so that the skb
> is freed on the original cpu.
> 
> This removes contention on SLUB spinlocks and data structures.
> 
> After this patch, I get ~50% improvement for an UDP tx workload
> on an AMD EPYC 9B45 (IDPF 200Gbit NIC with 32 TX queues).
> 
> 80 Mpps -> 120 Mpps.
> 
> Profiling one of the 32 cpus servicing NIC interrupts :
> 
> Before:
> 
> mpstat -P 511 1 1
> 
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> Average:     511    0.00    0.00    0.00    0.00    0.00   98.00    0.00    0.00    0.00    2.00
> 
>      31.01%  ksoftirqd/511    [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>      12.45%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>       5.60%  ksoftirqd/511    [kernel.kallsyms]  [k] __slab_free
>       3.31%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
>       3.27%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clean_all
>       2.95%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_start
>       2.52%  ksoftirqd/511    [kernel.kallsyms]  [k] fq_dequeue
>       2.32%  ksoftirqd/511    [kernel.kallsyms]  [k] read_tsc
>       2.25%  ksoftirqd/511    [kernel.kallsyms]  [k] build_detached_freelist
>       2.15%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free
>       2.11%  swapper          [kernel.kallsyms]  [k] __slab_free
>       2.06%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_features_check
>       2.01%  ksoftirqd/511    [kernel.kallsyms]  [k] idpf_tx_splitq_clean_hdr
>       1.97%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_data
>       1.52%  ksoftirqd/511    [kernel.kallsyms]  [k] sock_wfree
>       1.34%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
>       1.23%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_all
>       1.15%  ksoftirqd/511    [kernel.kallsyms]  [k] dma_unmap_page_attrs
>       1.11%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_start
>       1.03%  swapper          [kernel.kallsyms]  [k] fq_dequeue
>       0.94%  swapper          [kernel.kallsyms]  [k] kmem_cache_free
>       0.93%  swapper          [kernel.kallsyms]  [k] read_tsc
>       0.81%  ksoftirqd/511    [kernel.kallsyms]  [k] napi_consume_skb
>       0.79%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_hdr
>       0.77%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_free_head
>       0.76%  swapper          [kernel.kallsyms]  [k] idpf_features_check
>       0.72%  swapper          [kernel.kallsyms]  [k] skb_release_data
>       0.69%  swapper          [kernel.kallsyms]  [k] build_detached_freelist
>       0.58%  ksoftirqd/511    [kernel.kallsyms]  [k] skb_release_head_state
>       0.56%  ksoftirqd/511    [kernel.kallsyms]  [k] __put_partials
>       0.55%  ksoftirqd/511    [kernel.kallsyms]  [k] kmem_cache_free_bulk
>       0.48%  swapper          [kernel.kallsyms]  [k] sock_wfree
> 
> After:
> 
> mpstat -P 511 1 1
> 
> Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> Average:     511    0.00    0.00    0.00    0.00    0.00   51.49    0.00    0.00    0.00   48.51
> 
>      19.10%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_hdr
>      13.86%  swapper          [kernel.kallsyms]  [k] idpf_tx_clean_buf_ring
>      10.80%  swapper          [kernel.kallsyms]  [k] skb_attempt_defer_free
>      10.57%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_clean_all
>       7.18%  swapper          [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>       6.69%  swapper          [kernel.kallsyms]  [k] sock_wfree
>       5.55%  swapper          [kernel.kallsyms]  [k] dma_unmap_page_attrs
>       3.10%  swapper          [kernel.kallsyms]  [k] fq_dequeue
>       3.00%  swapper          [kernel.kallsyms]  [k] skb_release_head_state
>       2.73%  swapper          [kernel.kallsyms]  [k] read_tsc
>       2.48%  swapper          [kernel.kallsyms]  [k] idpf_tx_splitq_start
>       1.20%  swapper          [kernel.kallsyms]  [k] idpf_features_check
>       1.13%  swapper          [kernel.kallsyms]  [k] napi_consume_skb
>       0.93%  swapper          [kernel.kallsyms]  [k] idpf_vport_splitq_napi_poll
>       0.64%  swapper          [kernel.kallsyms]  [k] native_send_call_func_single_ipi
>       0.60%  swapper          [kernel.kallsyms]  [k] acpi_processor_ffh_cstate_enter
>       0.53%  swapper          [kernel.kallsyms]  [k] io_idle
>       0.43%  swapper          [kernel.kallsyms]  [k] netif_skb_features
>       0.41%  swapper          [kernel.kallsyms]  [k] __direct_call_cpuidle_state_enter2
>       0.40%  swapper          [kernel.kallsyms]  [k] native_irq_return_iret
>       0.40%  swapper          [kernel.kallsyms]  [k] idpf_tx_buf_hw_update
>       0.36%  swapper          [kernel.kallsyms]  [k] sched_clock_noinstr
>       0.34%  swapper          [kernel.kallsyms]  [k] handle_softirqs
>       0.32%  swapper          [kernel.kallsyms]  [k] net_rx_action
>       0.32%  swapper          [kernel.kallsyms]  [k] dql_completed
>       0.32%  swapper          [kernel.kallsyms]  [k] validate_xmit_skb
>       0.31%  swapper          [kernel.kallsyms]  [k] skb_network_protocol
>       0.29%  swapper          [kernel.kallsyms]  [k] skb_csum_hwoffload_help
>       0.29%  swapper          [kernel.kallsyms]  [k] x2apic_send_IPI
>       0.28%  swapper          [kernel.kallsyms]  [k] ktime_get
>       0.24%  swapper          [kernel.kallsyms]  [k] __qdisc_run
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/core/skbuff.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index eeddb9e737ff28e47c77739db7b25ea68e5aa735..7ac5f8aa1235a55db02b40b5a0f51bb3fa53fa03 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1476,6 +1476,11 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
>   
>   	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
>   
> +	if (skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
> +		skb_release_head_state(skb);
> +		return skb_attempt_defer_free(skb);
> +	}
> +
>   	if (!skb_unref(skb))
>   		return;
>   

I have noticed a suspend regression on one of our Tegra boards. Bisect
is pointing to this commit and reverting this on top of -next fixes the
issue.

Out of all the Tegra boards we test only one is failing and that is the
tegra124-jetson-tk1. This board uses the realtek r8169 driver ...

  r8169 0000:01:00.0: enabling device (0140 -> 0143)
  r8169 0000:01:00.0 eth0: RTL8168g/8111g, 00:04:4b:25:b2:0e, XID 4c0, IRQ 132
  r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]

I don't see any particular crash or error, and even after resuming from
suspend the link does come up ...

  r8169 0000:01:00.0 enp1s0: Link is Down
  tegra-xusb 70090000.usb: Firmware timestamp: 2014-09-16 02:10:07 UTC
  OOM killer enabled.
  Restarting tasks: Starting
  Restarting tasks: Done
  random: crng reseeded on system resumption
  PM: suspend exit
  ata1: SATA link down (SStatus 0 SControl 300)
  r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full - flow control rx/tx

However, the board does not seem to resume fully. One thing I should
point out is that for testing we always use an NFS rootfs. So this
would indicate that the link comes up but networking is still having
issues.

Any thoughts?

Jon
  
-- 
nvpublic


