Return-Path: <netdev+bounces-214285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F48B28C22
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 10:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E6E5E6EA5
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4323AB88;
	Sat, 16 Aug 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TWcE8zX7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FF1C5D4B;
	Sat, 16 Aug 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334758; cv=fail; b=PySaaKggoAjteIJfCiH94YtZ/CZOgXzTuxFGAW7P9uBt/ap9Tn60j6nFeY48DH5295Va5LvrznxeWoWMzuzV1TdHsxpGjzfxtWsMms7tVXJMdEqXSIE0zDjwrYhxoNUDvJKDfPvXosy8GE5iJikB97jYjcLDqRiGH9U4ABtgmYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334758; c=relaxed/simple;
	bh=4yf3Dl+1cFB4rSIwkorG2ACFlHm4qT6CK0QDj0LcLTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFYw0M837/MUr9XqdzIS24iX+QUW/SiSpLwH8JFnfe9EGVq79/fNPoF39tqpH69rrIZsdjHZ1FgKoTIQgDMX3lu6Kmgl6ZtUdJC1eJEeIrpzPL5DpKFuQQIeF3yuAccwUQpPH5A7N/mTk3gHca4IIefr/HV93NvJYzaQAzqa/PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TWcE8zX7; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E13/XK/otbSQrPFieBqQQ5/1MqE6RDCbPodbb0SXtG4n507N88yN1jP1lITLWY9aaxsYmsJXn5ISEEGQbObjHovc34W03cSOBCqzi19D67PhFozLH1IiDd1GBCWbhod+YkzmMO3K3vP4zXWo4FQcFu8YCtj6RQPGMNqIBsMUgX3UDgRiyqgqEo1CyZDndiMHPmvtolXfX++OUUwNo50aoFxmkkY4UnpsWI/fkcPV215c3OZR96MIhKc07LpsywGdaTbZylMd3s1B7QkpNcakW+xCokwCSaC0DfK/EF+43+RJO5wV8P+t7U2tBDVJdA+uyrwdDCkwrx2fGPb+VdcCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdQ9PPNoHkX1j8i0pJdDz/iAsOkFEHommm2Eu8xkjy8=;
 b=TwICEeRHSTU9Sj4Xj5H/fyMFvLR5eKoPmn6ivibfvXlmFM4ZRhYKOLnk2P1Le0Q7C8vYRK153DNA9wGw9gJ2Ilzim3JwjBD9attY/Z7oQYfXmZ7zx+SQcpATlcdA42/iZgqlDEyTkLuI6zrYxk/moUT9ah3IS8VzN6Xy7hfy6E6jBc7n9SvtEsVUR23RnOkhjLqsYRgK8/lvucn8mSYWBTDMGYtBGzhI78KA5pSiTidvnllmGniRqBPieXvTqi8PXKQhHj0xpYDBe7SoXI4Cudl7ZIwuxPgITkhQqTynj00f3+5Un+wPcmCyXZKbmfqXqQNxF27giiVm5ES3BNLHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdQ9PPNoHkX1j8i0pJdDz/iAsOkFEHommm2Eu8xkjy8=;
 b=TWcE8zX7qfKg/cQRbIO33FTcvuv6D7JZkuVxhwSUQHsu+JAva3JI8LcA7MgggjLaJS+YCT0TBUNnt9k/dcj4DvArijGEao1ouJVnsxEbWTpg4qZDU6+5kAWOKShrtIuMNpfY1DtIyZb+StTTB1Vi5r1XlMpOEkSLU2FNI1feEoMEQ/tliWUFf8B8O8uSJ+n9FAo51AxnBq6XnjbLdXizpL9M4A3jlI9O26h0CJsr+IbG90diKuvpGMFeKaD81jth4Qk9MDXCscOQ30dninOGSz7YhK09jTh5qeWUE0KxNsJcUW7n+YQ+F4OcKsFgOkjSkYIMZ6XCHjEeTIlzzcFQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 08:59:14 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 08:59:14 +0000
Date: Sat, 16 Aug 2025 08:59:06 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	tariqt@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues
 during bind
Message-ID: <nv2z4vvycay3eygcjfmxcqjgrftmmqm3nmesui4vjenexjbnvk@ll7km6oblghm>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
 <20250815110401.2254214-8-dtatulea@nvidia.com>
 <CAHS8izM-2vdudZeRu51TNCRzVPQVBKmrj0YoK80nNgWvR-ft3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM-2vdudZeRu51TNCRzVPQVBKmrj0YoK80nNgWvR-ft3g@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d31964-d2d4-4ead-95fb-08dddca32c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTMwRkdGdk1aTkV5KzNKbnVGZzEreGRPNTFUY0U3UlBWczRyRUpFWjRhaEUz?=
 =?utf-8?B?RkpjdE84eitOZ1dDR0ZrYzNGa3hzdXJ6c2h3bXIrRER3MkhzMGx4WGc2M3NW?=
 =?utf-8?B?Y3VFcnlNZElReHNISGhmdjJsd2s3aTZZU0tFU29ZNXd1VEpkQ1pkR1h0TmpH?=
 =?utf-8?B?Zkk2a25HSzFCeUQva1EwS0NpWHVnT2J1T3g2R3czT3VEWW9QSjF3cnphd3ZJ?=
 =?utf-8?B?OGNzNlkxRFFrK2QvS29kV3lGUVB5c2FvNHpwWEdkNTZDTkhaajRkU0lLMDlu?=
 =?utf-8?B?YkEyRFhqQStkRGlYSlBnS0MxZklMWnVtci95KzlnMGVybHVOU2FYY1Y1SmU5?=
 =?utf-8?B?NU90NEJvcHZCVWNVYUNpeUR6WUtUQWpkWndneGFzRzZxK0hyRnpLcCtXQVpB?=
 =?utf-8?B?bmlWeDNjbnN5Wmlod0FpNUlRS2tSWDd3WUxHdnJZWFJpWDNabmQ0dUxRSjRp?=
 =?utf-8?B?b3NTWFRjTFJjR1VScWZkQjBFRGt5UmI4Z0VJZTdOSzQwQjJzWHlNQUI2djJ3?=
 =?utf-8?B?Q3MzWFBoZDB6bDdXYjlDZ2JnOG1rZHhJdVNPai9reEFYVUlrdlIyUHNpWVp3?=
 =?utf-8?B?cEJZZHF2V0VtYnAvdm9STEp3aDVPMHAxL0pzREZzZU5KYldkV3o3TFZ3YXNL?=
 =?utf-8?B?YXVqLzZZRERJZVgrT05ZU3JmQXVnd0FrenBaa0pmRVVMaUN1ZCtoczUwQVN1?=
 =?utf-8?B?anlTNkhOUnlFb3lzT0RXNE5FQkpwck1najNHT0k2bm84SG1vUWxHMUVLSHFO?=
 =?utf-8?B?UHJ4d0tlenluOXFZNUU4czROSHJtc0RzZGNML2JBTWcvOE1ZMXBCVlh4OFBj?=
 =?utf-8?B?cW5WOGE2UFFsYVlVOUJyY1ZPaExaM3djdTVXTHRWek5WM3VzWnFrdEFyV05n?=
 =?utf-8?B?MHRBZXFmRHU4S0JuVjFpK3RJaFRJYllTT0RtTEVmbVBkUHlWZC81Y2c5REtv?=
 =?utf-8?B?eXV6ZjJHc3lzQWQ1UURWMHIwOXZDQ0RaNktqYThUZkRRdVJlNkVXV2cxRXUz?=
 =?utf-8?B?QjdPVklhNHdtM3JPUUhwcS80amFVUXBHa004MWRoVUJoZVd3N2RzOWNWNkE0?=
 =?utf-8?B?VjJKRVJ4V1JLQ3UzM3dybWtOM25TcDhUSkFoZzl5S01FaHdDWFpQMGRPTXZK?=
 =?utf-8?B?NGptYzJaWkw3cEdLM01wWVB6Vm1GSm8wR1BSd2dsejN3NHUyZnllSW51R2dh?=
 =?utf-8?B?NTVPVFJ3bHl3WDArcXRVZlowbm1NWjhnTmdKcXhRYitlaW1pREc4L3RMMEcr?=
 =?utf-8?B?N1VVTmhZLzNNZEZzQXdqMDN6VVlZQjJLUWMza1I1VWU0a3FRTW12Q2pBSFhP?=
 =?utf-8?B?a3VZMEhnU1hKMC9YTzBkVk8xOGNDNC9QTWRvZGgvZGxhVDRCeUUwcDFWSGE3?=
 =?utf-8?B?TGg5UU1qUndsOGprWEFvOFJxTUxVUUkrcnlMVkpOb2RaSHE2T3IzRjc5NUFv?=
 =?utf-8?B?dG96eHJTamR6SDJxQ3JHTllHcVVLRDlySitWWnRhSmM0UUVYTWQvaHpzdk1X?=
 =?utf-8?B?bWtZakErMG56cTF2bnNBeGtIVjZwWmM1ZWN3Wld6RGVTUnEvNm1wNjVTakFC?=
 =?utf-8?B?UzZ2VlBwRmFyUDJPa2ZualpUdTNRcEx4ZHdYRzJkSHd3d0tNMDRCM0dpSm4v?=
 =?utf-8?B?NU5FQVd5TXRMbWpHY3Q4REpPVUxBcEV5ZzdGcEp5OGo3RXpjZWtaMlViVDdN?=
 =?utf-8?B?Ny94blBuVmYybEMweUx0ZW40R1g3RTI1dUgxMGMraTVpSjVkdU5neHdDRkVG?=
 =?utf-8?B?Z0F3ZEdBOXJzcC9GMFNNVmFvWlFrTFlxQ0hkNWtZeXZEM1lLQXJtUFVpYnNi?=
 =?utf-8?B?V0RPL2RkMU9aWXhUSnBJclNJRGVjdytBZ0c1S3lEZm1YUTM5WVNEZFFaZmlK?=
 =?utf-8?B?YXlVRG9NM3UxRytwa3Zjdmkyb20yMGl1R2ZYeVk1UEQwZFdtL3liYUozSWZ5?=
 =?utf-8?Q?do5XrPN2Erw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXdjVWhyU1JJelFpTEZXV2RzLzVpT1JiOFFMR3ZnYkx1OW40KzVacVVmVk1P?=
 =?utf-8?B?cSswOWtPR05NTnAvTkRuemt6M2JSSTF4OFhCdnNHWXdvMjdHZDVUSmdTanFv?=
 =?utf-8?B?RWVaaEtpMUtjWkpaZTdEM2VVam1xbkdZVlV5clNRQlRzaXdOVjdIWHBsKzlQ?=
 =?utf-8?B?ZGxuWW9kcHcvR0F4bzV2ejUwK2ZLL2p3RmJpczc2SG8wWVRwMFU1a3RCU0Nt?=
 =?utf-8?B?bzQ5RzBubkdFNlBoNVZDb0Y4V1JoVUV0d2dnb096UUZqSnF6dUQxV2NhaUJl?=
 =?utf-8?B?Z0Y3WU9QVWY0ZDREd25UaFY5cFUzN2VBUHgvbmt0alhaR2tXLzllMnpRN29n?=
 =?utf-8?B?R0tDVk05ZDlySFZ5c1NLbTFPSHVUT3ZEOEo3U0hEYlFlVUVEN0ZMQVdVcitn?=
 =?utf-8?B?cG5qVmV3YTJYOE10TmpJb0x2VzBQYnM3SlpFYUV6dEZZcTZVZmc5K2ZuYTVa?=
 =?utf-8?B?enRUdmZSRVphb3doSmpzRmVrRFEyalN5M1kyTmNGVGFiekFOaXlyQXRBWUh1?=
 =?utf-8?B?VDVraGhQREwrZnF4K1d0SWxMQWxwY0ZqbVRNK1Jub2xYWFBvL3dJWWNqRWlM?=
 =?utf-8?B?eEp6UEpudTFWOEJVK2t2Z3lIK3ZLNVlZQmxuZ29SbTNubGl4SWdRWU1DdytL?=
 =?utf-8?B?Y0p1cDFLM2szVHo3elpRZUpIczcwdFlLY01oU1Z0UkkxVnRwdGJtTWZGS2hP?=
 =?utf-8?B?TDc5MXkwcWluemZUeWhsblVwbzdIckJJVGVtSUJHc1c1UmRJRkE5RTNselVs?=
 =?utf-8?B?STBrQWlOd0krTXBGeDZxTHkxM0dkWFBER3hpT0lFTGhzZndoelB5NEF6dVpR?=
 =?utf-8?B?QmppbTQ0S05hR0wzU0tnWXpuM0EzTys0MkJTaFlyL20wVjZOVEl2VUpseUlr?=
 =?utf-8?B?Qk4vRmVsd2FxM3NFZEptN3QwRHJTdUNuNWlMdHEySHJCcENBTXh5cXp0WWtR?=
 =?utf-8?B?ZUJiaXdNNHVhQ3RqaU1qUFR2bm12bWxMRjI3a1VnSWhYQjNQdW5yRk84bkVo?=
 =?utf-8?B?WmFxRWhBOXBBVlpFaU8rdVVKamptRlNoaHYwc0hKYWdnY09LN1h3dXhLZzJ5?=
 =?utf-8?B?RHNKbXdSN3dsdVRXRGxLOW9TZWZTbjVJWEFLVnpoakRzdUNINFgxMjk2cVl6?=
 =?utf-8?B?aXpjSHFsbXlpVHl4eGFZMXRmQlByR3JPcCtwK0drUkFZSFFwS3FSMU1iTm4r?=
 =?utf-8?B?RzdDYWF1c1pPLy8wbTgvMC8xN01SQ2RRdEdDS1RWQnZLSUtDTW5jdkpMUUI2?=
 =?utf-8?B?dWVTdll1dm02ODNEQ3hBcnBwY3J0S1hzS3pqM1N0N0NTUmUxTjhSOExKUUpn?=
 =?utf-8?B?bitEbG9OMzBJSHlWN3JNRUl4UWRYQlZzekZRYm1qVHc0a01RTFZIeXFFbjNR?=
 =?utf-8?B?NnRUQ1B1VUs5MXJibDZhbnpuY0dyb0I2anNLWUU2VzRkdTRoMEVaRUlOZk80?=
 =?utf-8?B?N2FYUDJaQWtmcHBYT0hOUXkrdjFZSWl4NmVscTFNWEpobDQydEF3VE1RSjZo?=
 =?utf-8?B?aXVNa2dpNDRsRFJoVmNoQjNFc01qM2lGNTBYblpTaFBIbjcvaklLMFYvcHEr?=
 =?utf-8?B?ZFloWWo4Vzl4dG5kVDQ2VEVqUzVxa242WkpRalcwZHk5bDNvTnE1WEdGMHpz?=
 =?utf-8?B?LzNRdWFEOHR2QnR6RmRObWkxb3pXai9GanRJeFBTRXFMbC9rN1NqOFdNNjFK?=
 =?utf-8?B?dVRhTTRIRThwNU1lak5pR0tuV3VwVnhWMXh6MG9WVXVlcDVvNmZRY0hzeUZs?=
 =?utf-8?B?bXdaTFRWN0FsODJkR1V4V3MvY0I3UVlvQnJyWlhCZ0lBN3NIV2VyRldGcFhp?=
 =?utf-8?B?QXh0eWpQZTRxblV0SDd6YVV6amY5VnFrVGNjRlNEaXZJQXdNcFluMFdURW9n?=
 =?utf-8?B?SnlpakRabHpjT1hUeVgzdDBkLys2MS8vMHREWTVnMitkNGJCWVZkL2dKTnFk?=
 =?utf-8?B?dnFqbmpuTGdsVDFRYlBXRDBiVjJ1eHFmcG1TNHJwdFZXTUpHQjFtOTNjNHNC?=
 =?utf-8?B?b3d2SC9HNDd6bGlyVEhTUnRnOG92NjdKb0NpY3VueUp5OVk1Y2hkL0Y3ekgz?=
 =?utf-8?B?Wk1GY1NDNjhFNGhySEdKYWtWWmpzQkd2TWY4bVRSbFhqZDFuNW5PSnM5b2tt?=
 =?utf-8?Q?hifKaiBrOsBE+oV05W4uqaDa0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d31964-d2d4-4ead-95fb-08dddca32c70
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 08:59:14.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAbQ1Lvpc70j+Lu6XRv2lg+uBJsbnehL34CykHGmKAaLVJpDLzAYUuQoSRk1XZMdRipaOmp6Gx41ZZ56ppXaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

On Fri, Aug 15, 2025 at 11:05:56AM -0700, Mina Almasry wrote:
> On Fri, Aug 15, 2025 at 4:07 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > Instead of reading the requested rx queues after binding the buffer,
> > read the rx queues in advance in a bitmap and iterate over them when
> > needed.
> >
> > This is a preparation for fetching the DMA device for each queue.
> >
> > This patch has no functional changes.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >  net/core/netdev-genl.c | 76 +++++++++++++++++++++++++++---------------
> >  1 file changed, 49 insertions(+), 27 deletions(-)
> >
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 3e2d6aa6e060..3e990f100bf0 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -869,17 +869,50 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
> >         return err;
> >  }
> >
> > -int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> > +static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
> > +                                    unsigned long *rxq_bitmap)
> >  {
> >         struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> > +       struct nlattr *attr;
> > +       int rem, err = 0;
> > +       u32 rxq_idx;
> > +
> > +       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> > +                              genlmsg_data(info->genlhdr),
> > +                              genlmsg_len(info->genlhdr), rem) {
> > +               err = nla_parse_nested(
> > +                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
> > +                       netdev_queue_id_nl_policy, info->extack);
> > +               if (err < 0)
> > +                       return err;
> > +
> > +               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
> > +                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE))
> > +                       return -EINVAL;
> > +
> > +               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
> > +                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> > +
> > +               bitmap_set(rxq_bitmap, rxq_idx, 1);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> >         struct net_devmem_dmabuf_binding *binding;
> >         u32 ifindex, dmabuf_fd, rxq_idx;
> >         struct netdev_nl_sock *priv;
> >         struct net_device *netdev;
> > +       unsigned long *rxq_bitmap;
> >         struct device *dma_dev;
> >         struct sk_buff *rsp;
> > -       struct nlattr *attr;
> > -       int rem, err = 0;
> > +       int err = 0;
> >         void *hdr;
> >
> >         if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> > @@ -922,37 +955,22 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >                 goto err_unlock;
> >         }
> >
> > +       rxq_bitmap = bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL);
> > +       if (!rxq_bitmap) {
> > +               err = -ENOMEM;
> > +               goto err_unlock;
> > +       }
> > +       netdev_nl_read_rxq_bitmap(info, rxq_bitmap);
> > +
> >         dma_dev = netdev_queue_get_dma_dev(netdev, 0);
> >         binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
> >                                          dmabuf_fd, priv, info->extack);
> >         if (IS_ERR(binding)) {
> >                 err = PTR_ERR(binding);
> > -               goto err_unlock;
> > +               goto err_rxq_bitmap;
> >         }
> >
> > -       nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> > -                              genlmsg_data(info->genlhdr),
> > -                              genlmsg_len(info->genlhdr), rem) {
> > -               err = nla_parse_nested(
> > -                       tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
> > -                       netdev_queue_id_nl_policy, info->extack);
> > -               if (err < 0)
> > -                       goto err_unbind;
> > -
> > -               if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
> > -                   NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE)) {
> > -                       err = -EINVAL;
> > -                       goto err_unbind;
> > -               }
> > -
> > -               if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
> > -                       NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
> > -                       err = -EINVAL;
> > -                       goto err_unbind;
> > -               }
> > -
> > -               rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
> > -
> > +       for_each_set_bit(rxq_idx, rxq_bitmap, netdev->num_rx_queues) {
> 
> Is this code assuming that netdev->num_rx_queues (or
> real_num_rx_queues) <= BITS_PER_ULONG? Aren't there devices out there
> that support more than 64 hardware queues? If so, I guess you need a
> different data structure than a bitmap (or maybe there is arbirary
> sized bitmap library somewhere to use).
>
The bitmap API can handle any number of bits. Can it not?

Thanks,
Dragos

