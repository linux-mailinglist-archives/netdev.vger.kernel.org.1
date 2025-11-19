Return-Path: <netdev+bounces-240061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06626C70076
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD314F1706
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70436E576;
	Wed, 19 Nov 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8k7/lO/"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713836E542
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568297; cv=fail; b=NMd6q38vuIXMNDZk/1VbPEtQi2N9Du9gQ4syT/gYcY2H1s2T4x7UFpHWauxYiOd3CKXcuJELo5GSuLPrt927EyF85Pw+Q+vtpz9DBQ6AaZsUz9Y1yysS9AtqlzlRRqduJgfE8QP+AeapipmyZHvDO4f7gUL/Sj0UYAb9zrMUyzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568297; c=relaxed/simple;
	bh=790yDYjxKJJv/eltcogyOrFSHg3e4SHev5F4HjGukGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3M1vrlTiJnP/REaVqq87b76GjWzluBxYK/cqUV4xJ81Cl9B5KkYKyv3xsDkIkCDEs1oZ0r3FBroSS31yRF9fcLcS3OlJCwboLq/8umNVc/l6Xep6d8Idt2bBTkXbMqkpzY3TgnwvCG3rXa/hqKsEBbQBDbgTL3l5z7YKlrffuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8k7/lO/; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkYgrkCQE4zPq/1bP3mj9E9Mu8HKN7K7VUzxROzzIaXioun22oxYg1UQcsyVAfs+qC58gG5oYtFwn8S9Tro3V+BqmlbJByGIzf3+qh45MQw+bVL52jnQo+de+tEs1HhgWRXx4vHhaXmVKVxpCd4PmhDu00MTvucV0wbV4wqZpSYGm/gdPgaMCbYgvzwcDCnuXrDz+Bs7HKQYprtfdkFZ1Vy8Kx194z9mV1GULwtpYXD5JoE/+4hAaQJWjqoy0S8jUlBO6/a3TPegBUSlxA+6Kclz2ioPMMxqgavQ2PKCxIrg5V9Wb0iG8KrXMLUexeJP7eyoWad8QRnK9psDz80L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkhQ958lamgTNCqssvbBTKleMLwoGZFOxIFnGIPJK4I=;
 b=PuCuimSQqscASTbNFh4j/EVTWvLmnXR5j5t34dzjI9eA5NwGZ7THQjK/xeLFTi4NylCx3Er8yvJesSIHjZzcIQYOXL5R1l7dK/5s/CzPe9TMshYdJdfGrfxbR2TN/vT8FByTVOKss2SWd50FXCDaoGzsdhRas7liTiNzyUTb/nvpb5x4IhXSvtaA9syuBCr+mxefcJrWAI4Vi2NeRn7v8isxcN7osUJ8V5MUNbM2+Xb23UVcur+MYMr8/PHC+d2l0yEyOezbC8nDTusc7JnEOWU/xVAM8lpDsPqAEnjH59DA7PyMqzljYx2VJqSMQBxc6YhwGzWE1ktE4vPyzBwYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkhQ958lamgTNCqssvbBTKleMLwoGZFOxIFnGIPJK4I=;
 b=i8k7/lO/Qaa2CqNwlijdNEKcDTaLolIJjJ/ppu0IhX/Dluu0oyZYdBw4c1SmDqe6XN9IRECKIyv8w6t13x1chBf6w1aJZ5psxz+Gr8drg7JAHtlopI/eWRzTwxKyoho0MZAMKo4zUJxp37OLkBgU7YiYXWHO0HI8Azkae9hxnaJ4Ss1TvTttHbYq9LjY3o+lGtKwp5sI0mzGjCmd1pbNp19qjAtwp4gWRiMT55BroggO5SqDu2/difaTpI6/F7kzudpnbR8eyPGSm5tvw+VayxcVqPWKoxn8Hr/G0V7W6L/ZQwkn7BjiXbVovCFcnfCC1v5QQTnsjoyswtHe/ueiKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:04:51 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:04:51 +0000
Message-ID: <09ec83d4-dd9d-4430-a049-e590c830cd6e@nvidia.com>
Date: Wed, 19 Nov 2025 10:04:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-11-danielj@nvidia.com>
 <20251118164552-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118164552-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 526da33e-2574-4e08-2fb6-08de27855ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1BwbWI4YjJMR3RLRC9TRTZURHIrN3oxNHJNUGlpcDF2VllSaEJoa2doWjZN?=
 =?utf-8?B?aTlCQzhZcXEzUW9CbHpCQXovSlg3c3RVUE43czNOcVA2Z0huanNWNm84U090?=
 =?utf-8?B?azVJQlFESGZNc3R6REhKUGs3MVdvKzBkRjJaaVl2azdFd2JtbEIxRm80VDhv?=
 =?utf-8?B?NWZNZW5vb3lDK1drV0JzVnZTNndZbG9LUnh6Q0I3N2tYend2VTFMRkQrejJW?=
 =?utf-8?B?d3RPOXhTdU1QS3ovc2UyTzJQTFViRjU4c1ExMmFDT21KcjNTVHIvWUt4ZU02?=
 =?utf-8?B?ZThjdFVva0RMdSs5aEExcWpocUZ1L1RFTXJtRkpDRWhEMUdhRkpkMlZPTlp1?=
 =?utf-8?B?eWVjWHJtaFJ4QUQvOEI1d1B2ak0wS00zd2RvdDA5MWdjMENxTDZlc0VLL1lT?=
 =?utf-8?B?TnNlYjhnNjNlZE5aaFN4Qi90WFlmNmVnbUJmUXhsRGZuZXlhT3l3YWd1VjBt?=
 =?utf-8?B?TStIcE5Td1hsVjV2a1VPbE51QWUzRnBSWXhtZDNjaEp0dVRoaVFwZFVORGFo?=
 =?utf-8?B?RE5wUmJwRytKRWNYTlpmYXkxT3VCck5MdjBtaFlmb0xnVlV2THNxWVIyRGhR?=
 =?utf-8?B?SHkweTFiNnBFWmNDSkFzRnVHNUg2RmtreUh2b09CekpFSTZOK0VKd09zZnNQ?=
 =?utf-8?B?N1ptZ2NXTitGNUt5N0t3eWNTWk1kaHR3blcwLy90RXJ1bGx3RGsxYnNpMVQ2?=
 =?utf-8?B?eVV4M1BFa2lTZk4wV1QxQ0wrcDdkRmJlZkNGN2VmVjhlZk96VEJ2MGVTSG1x?=
 =?utf-8?B?RjlvQm1ua284dXMyMDMzZWZvSk1mRVdTQ2EvazNrcWg4QS9nblJQdktEVGlZ?=
 =?utf-8?B?SlFuWWFTaThNZkwrbGZwQTI0QzQ1N2poZU9ka3E4MitSdjFacXlua1VJekd4?=
 =?utf-8?B?VGVFTi94U3FUMG4zZTJacVlhS1ZFSXNJMUd5bGVsNHljWDV2cXZEdm9lSWxK?=
 =?utf-8?B?bWNKL0dMVlRpTzA1bXVNWXR2ZVpMVXFja2FzeDJqbW42L21ZN3MzT3dEbE1n?=
 =?utf-8?B?ZG9YV2FsWnF3SURBUWxHTExNUW9ESjJoMG1Ub3ZzTWN2Q3JOOStXSVlzT2dS?=
 =?utf-8?B?S2VtZ3JyTjFCNW5wWXUrc2g0bnMyOGczZ0s1YmVYbEQ1Qk8rbFc3YmVNNERq?=
 =?utf-8?B?ZlRwL0E0VjFCMC9CTjJybGpqVmswbHZpWDE0MUxCWThUdGdlVURSc2VLT3JX?=
 =?utf-8?B?VXVRTGJsc1p0NmJsL2JmbjRJSEhwTHhhZGpjVkZYM0M4cmF4UlkrRlQ4NXpM?=
 =?utf-8?B?dFhHN2dLWndhekozZG9pQzFwMDI5WDQxZUVlMUI5VDVMK1c2MVhQRjBSdUEw?=
 =?utf-8?B?SXI4ai8ycWJidzluZDlsUlR3Q3h0RHdRb3ZOc0ZCcThhNXJzSWlHT1BvR0ZK?=
 =?utf-8?B?Q3piZHVBR1VhUlNzMFdmUGpBTHljSUpGUU1ZZ2dvTThPR05Ebkc3dEdoNkV2?=
 =?utf-8?B?clhFT3R6a0c1NjlYb2V0K0FRRWV4RkNIQ2dtT0pUcEc2RlZuVjFnYjZ3YXJx?=
 =?utf-8?B?U21lRHk0b2FmdUhUWnJ3VmdrWUVNZWlJTmdoVkVGVmZSdWtQWklEb0pWWHRt?=
 =?utf-8?B?cDRoSXVTTEFUQlIvM2UrdWNtNFUxNEwrbVk4WmhSY3dmQlpPR3V4UU5tU3lo?=
 =?utf-8?B?dUtuOXRNTzEwNXErZ0dLQmRCNHhFeVpzSDNSZlJoMmV1ZVlGSDBaOVJFUmRm?=
 =?utf-8?B?aFo3YjBkb0JwMDI3a3FUajhDTTlaMkJWMHF3MlFsSDh5ZU5lUVJ2NnhDWXZh?=
 =?utf-8?B?WkdtUGpKS2JCd0I2MmdpUUptSlVjS2hxTVlKeFY1Um5BMkF6ZzRLMHdZWGN0?=
 =?utf-8?B?N3VQNWRjOGFpRHhGbXl6RlRSNW54dzJxQWtzM09pakF4ckhIUVViaU9keWpX?=
 =?utf-8?B?UUdPMnQ5Ri9JZ0xDMXlNenpDVWNmL2VQL3N1UStxTTBiYzRtZDQwNmVPcVV6?=
 =?utf-8?Q?SCvV1cZefDzCxhwxhFlgq/qu/sQtBOr6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFhrZzNOVVkwZUtZcHdzcUkxUUFsZVlNQWw1UEVHTlF4QnZIaUdXZWRhRlda?=
 =?utf-8?B?RzR5eWJ0ZWxjdXY3d3VRWGxkZ3RxbXhjNXpkRGZpSFZsekVwSzhWbFpIT1h3?=
 =?utf-8?B?VEtGYmRPL1dVU1JaQXZCOEE1b2ovUFhXUDRQL2pNbm1PRDhpN1FOSVJYdjlT?=
 =?utf-8?B?eHdYUnJONERNYTNHU1Jlak9JSndxVHFMVUM5SWxEeDdLcHNQQkR0S24xRUk4?=
 =?utf-8?B?RVYzYytPelJTZjEvWWs1TDROL0tRZmtQYXJ6ekt1UTlPUmM5NXVBeHhHUlVS?=
 =?utf-8?B?QU50VFZ3cDFkTkZhSXo4Tk4wSUpxZitJVW5yM3BWSWRqc1pBWkYwbXJ6a0R1?=
 =?utf-8?B?aUlmZFdDNy9OaXJqdXFmRTRoQU1zdUplNnFaNTRhS1ZiTE50Y2RKd3VaMFRt?=
 =?utf-8?B?RmZSRzA2c3Vqb2I1NitqYkM2UFY2R2VrNGo4dVBHNk5uM3EvcjJ1L2NtQ0tV?=
 =?utf-8?B?RHhtTE1jVmRTNG0vK2t1ZnZSbXR5WlZLRFBWOWwwV3lVdnZtbFV4K20yeDZD?=
 =?utf-8?B?NGZ6ZEdyNkplc1BLWHlSeTlYNnFoUjltWkdoeHprOHMxMU42aEhLSCtGU2do?=
 =?utf-8?B?RGZxc2YxU0kvcU1BYU0reGJ0WENFcnNhNlRjdUlpT3lzVk9VQUVGZTVDdFpT?=
 =?utf-8?B?Y0RqaVFDZ1VaZlNMM0xxNnlyczI4engwZDZQNHpLMlYwa2tGcWNhSVdzU3RE?=
 =?utf-8?B?ckVScXJsTnNnMStocGVPUWFTcVh1RTJRc1F0R3FPODlJc2N5dVZ1bWxOeUNX?=
 =?utf-8?B?ZFVCQnBqcXpCMk5jZnhsN09nWVNHQnRxWW1tVlpxZkF0RzNJblJXdkFzWmRK?=
 =?utf-8?B?OUF3dGtxNVBqWU1vdm9BZERmZnNOeStFaGUzZDZvS3Y1cXpxUW5LWWQvQmFm?=
 =?utf-8?B?ajU1Qk9MekZyclVUdXpMRFFsZVpkM2RIM0NYS2dzNUkyd2F4Z2JETXJqdVpo?=
 =?utf-8?B?RFFsT0JLWEhpWGFici9nLzQvdUlRaVluLzhpMlZnREk5NWJhTFdLWmk5SXBn?=
 =?utf-8?B?NVpUT1NYaHhSU25rQUhrWEtHSmtWWGZyWmNhM2QwNFU5OS9WWnZxRXQrMHcz?=
 =?utf-8?B?M0t0VTgwNlVET0hCalpzWkZDWWlaRmJQeXArb0lhbHVBdFVhcll1WFNBeWNQ?=
 =?utf-8?B?V1lyQ0JjRWkrcTNRWGcvK2Jkc2RPemM1RjM3dC9PYmVJRkw2dzU3ZzdiZVh0?=
 =?utf-8?B?YjAwU0U3VUQxM1VzV3I5eWdBMUVjc0pmVndGMU1STXJNMDN5aWdpR1pHVk9p?=
 =?utf-8?B?ZEdlSExhZFJnZkxRa2dxOW1qR1NGMk04aUYreS9HbmJvRmdzVTVYaUFSQ0Qx?=
 =?utf-8?B?S1U5eDhrak1LN3d0d0ZqUGFWNnlFU2YvZENqVTk0YVNaUDRMeVhTN0Q4NFJJ?=
 =?utf-8?B?WlBjTGN5MVg4RFNLTmY2WmRENWtyTDgwUWVmcHltUFNnREEvL05hend6MkJ2?=
 =?utf-8?B?QndDNjBIdkV1Y3E2ZUJzZEZzZExNMlg0WnNZb2FYK29raFFrWXVIWE40VDVD?=
 =?utf-8?B?bW1aVDJ5SDhPbVIraE9kd3ZwRjIxSmFDcGc2SWFxa1doRDArWlhldWJGVjR3?=
 =?utf-8?B?UE85Z3dlNk8yZTQ5NGRja3pOL0hPOVk5MlZ3ZXIzMXp5WThwRXZiY3FFTFJE?=
 =?utf-8?B?RVBYV1pHK0grWjdQSENqeTNpNU1mL3QzVzh2MlFFU21VWFdiQlRkZXlKamJa?=
 =?utf-8?B?d0Y4aWRaQWlyV0diWHVrVHRneS8vVkRaNXp1RnM3YUNjSWY3Ymh2UWh0akZ4?=
 =?utf-8?B?UXdYUFFkbGNUeVhqUzJHNjZYNm5EUit5QnluM1BiNUo1S2lQdk14aVNYRVB1?=
 =?utf-8?B?aFhtTjRPWnorckVqaS9DTVFRcXVSVlhsOW54TGV2dFB1czlHZGpTTEJtUjdT?=
 =?utf-8?B?UXp5ZUN2dlhTZkNzdTl4RklpdXFOTHNqVjJlc1k5a0NPR0FacS9JbFpCcjdD?=
 =?utf-8?B?eU5FSzkzUEY1NCsrVWRhMlZWS1VkTjd1UkoxMEpzTFFNSzhoZGFLR1pJLzFk?=
 =?utf-8?B?bWEwUXlWMC91cDdjaW5nZDlRMWhQVUpuU2IzNWYzZTFEWElFMEd0ZnBPVmRN?=
 =?utf-8?B?RGR1ZlMyV0p6OEV3RG9FejI3TW1oYm5oVVArRzNucytMUlE1NU1VSTNrTzVx?=
 =?utf-8?Q?SMIL6Vp4gRZ2E6JZHyeK/AnHM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526da33e-2574-4e08-2fb6-08de27855ec8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:04:50.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YUKp//nZjHbxY1cxln6xprfSlity9OW2DuCKTXfSo+1nTXHDC+j3MGyTN31mNloqSfnIvwC97KHbOApdlS9Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458

On 11/18/25 3:48 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:39:00AM -0600, Daniel Jurgens wrote:
>> Implement support for IPV6_USER_FLOW type rules.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
>> Added rule with ID 0
>>
>> The example rule will forward packets with the specified source and
>> destination IP addresses to RX ring 3.

>> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
>> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
>> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
>> +	}
> 
> so this checks mask then copies but parse_ip4 copies unconditionally?
> why?

Added a similar check in the previous patch.

> 

