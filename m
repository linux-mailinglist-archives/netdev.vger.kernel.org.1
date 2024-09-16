Return-Path: <netdev+bounces-128501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F3979EAD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247B2281507
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720D3149E09;
	Mon, 16 Sep 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dCmAlngp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FB13DDD3;
	Mon, 16 Sep 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480045; cv=fail; b=Cc7yWHC43fh5oZ0giiuRTFhO6ZxR0TfTW6cG90XIEMzxzSU5ACuESjhJVR4wIQTPcylkNGQ6DY4v9CVtFUPpTFHDZqwSmwA0x+RgLxJbvx7wqDYxK03NXnq4c9KdNnGuC+i0f++xOwde7Gd8AOLKOOBwguZK7nNjGpJLWMxG8AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480045; c=relaxed/simple;
	bh=G8G4ViQYeeQDK1NWnbj9CkVF4h1h+TVh9Wy4ilJd6b0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lFmVv+93lEoSZpETy22uSOYJobiFFD3V42u+3QQfkKfHcK54y8J4VFgS25zI27B5chd/JxxEIJHqeBHKoxRdo95QFt+TLqXTh+zi4xSsjJeG3RCuf2fnhFKxfaX9d6xaaeeAM5co1tRnbugXQWbF115HfNW0fuVtZbQ4Sj2/EEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dCmAlngp; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhG4CmlOM1Cp0VvtSqFnE/Q0+RmP4DVJRysfk+btwUV1IVQn4G7/Nv/xUGJYaS+Ri7FV1cS8m4bsF1xo41kRWYEoH4zQhw/im0pPgKJles76G86oktue4MD2fHln3TYJEjA2VEy6ipQphpYEpQC3k/W85ChbrfpdA3IiPU3EzeSiRxIwloIBR1CrJ8wnEtbe5/HNXl+qWVXJfkQCX2ZPnPEnoV9CDEC29g6tY5jDqWrpBy6YeizbURVeF0suJqNU1e7P2M1g2q7xw0kmu7KD6kGO7EgNBuJgKTFtB16vHIN9EwTypEtsTELG2T55lf8kyfLKqmt9w9+DnlhtGvYwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG0meAGq+T1tOIV2EwClLR2FvWnmMIspYSCiOvvqs3g=;
 b=ZV8W9Xk1NyXbGyLUaQz79rDLb7I3DNQ2mvokZdHGu00dr7+fDgR9091TirkHUwwq4Qz1ab12L8juQQZCTplemXVeiQRCmCXClI+RZlSJco8DP6nonknWtXK9e52w8wtTajmoB1Tx+NOPGNkcDaL2oBvucJCebNnqwdUcy4Mex76iCS/jz8W7RQIRuEzXHIe1+M8TWM3Aw7va9hAUGZJGXCpyS5D7sxaEWNIHTao4lwrEhVcnZfS3vlqapKzRPAKr+wsV2obba/nRE3V2Fzf/CvuRSFb+zvU3AgrrY29rADvR274OKZD75I3mwqSmFUza0yhEw7Krm/WTrffNfDrMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG0meAGq+T1tOIV2EwClLR2FvWnmMIspYSCiOvvqs3g=;
 b=dCmAlngpT8wo5D/DbJ1mRxKdBESW51Tv4zCpfMSBYQ09W6qXCOps5Fc5X79r3i1JpSVgciBVAU6772/ftzCK2hZsli5UTmp5N8D6EeDkKifiAqSGGpjlOFb9LB3DWeyvQ57EeIT2XQaBQPtD4V/6mVpytTLNXpTgvOHpy6syyvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 09:47:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 09:47:20 +0000
Message-ID: <d9450110-6930-ecc5-3571-e3aa24351529@amd.com>
Date: Mon, 16 Sep 2024 10:46:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/20] cxl: move pci generic code
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-5-alejandro.lucero-palau@amd.com>
 <56f1a2fb-aab1-4ecc-98b3-bdcf0f37ec3c@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <56f1a2fb-aab1-4ecc-98b3-bdcf0f37ec3c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0159.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::20) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3ac0f3-7fd0-44a5-ce46-08dcd6348e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmh1cGNCM3BvbThUVkMzeXFBenQzOUhxTVljak94WlcxaFIyZHZNdGdnOVVR?=
 =?utf-8?B?WEhxV00zZ0lmbG1uVEwycUFrNDMyYjFTUEtjbEhYRlM0UlZUSFNlSUd5V2Nm?=
 =?utf-8?B?QjBXeVlSdzhJc1FPQ1h0S1RCc25LV1hFWmxnbkNjTVJtK1FFTWxQNEM5RWVY?=
 =?utf-8?B?WHdYZ3NxNlI3dUZXMnNPTUM1S2h0Rkx3ay9uOVJwbEVURW5PSmN4Uy92bk56?=
 =?utf-8?B?U2puRER0S2p6RXNkeGpMQ2lDaStmTHJwNXZoaFFTYTMyT2RTN095cyt5czNi?=
 =?utf-8?B?OTZ1YXNIUmZpRjI1eVd6amZHQzBYRjQ5ODc3UDAvK0pHRHNTaFRZdnYvbHNU?=
 =?utf-8?B?aFF4OWYzRHc2UVhCc01VODJJZlJwbDJOeUtwYnlqMGZ2WEphUjR5WVVSdlpI?=
 =?utf-8?B?TDNvanlQalpZS2hvNjF0cE5JT3J5Q2pnTlB0N2ZhaERkK3JYRlNzZ0RmZEYr?=
 =?utf-8?B?aG5KWXJRL1FKTU45RHFqOC9nbi9JM0Rqd0l1U0EyOFZYL2I2dWVGd1IxbkI1?=
 =?utf-8?B?S3pmK1JEMVN6V3pqNEpYcXRwVFJFWVpKbDlYNk4vSzg4dXBON3k2SFBOZy9z?=
 =?utf-8?B?OWpzUm0vdnRIVmNtbDVOM0hLdkNmeG94MEdUcVFQTXZOdXpGMUcyeXUyandQ?=
 =?utf-8?B?cnhCMkt1WCsrZXl2eXlRMUZ6MWhkZXhCRjY3K0hUNElGa1RvMms1bnVtOUx3?=
 =?utf-8?B?OEEyTHR3MUhqcGtxbUdNaHdnWFBsZG01eVVYam5LZTNkQVIrc0Q2a01mYVlr?=
 =?utf-8?B?UUxRaUpqWXluVnRnanpubWFKWDljNmlHL3F1YTlUSTNnWktrU2lUS282Vldx?=
 =?utf-8?B?RVNyRHk4VEVLNG45S3hodGhqY2dtZWxqN3BTdEk1bDE4UTBMUk13QlNCZDRp?=
 =?utf-8?B?UlAzcm5kR1QvcjkxK1lMeDFFQ1dzQWg4bTZINElXVVNORVovdFdLSmNhaWxx?=
 =?utf-8?B?amZuT0Jhd0JYNDdOdmx5azlZR2FzWVZxa3dCRVl5T2liRi9RaXRmY0hqd0FJ?=
 =?utf-8?B?eGJKNTVtb1l6UzJ1UEFsc1ZVVjhGNExDMzFjZDBvOG1PSyswa2VXNjkrZUVT?=
 =?utf-8?B?R05sZmovR1h1WnJsMUZPZWxMa3MyR3R6WHREWlRhdmtYUzJjb0pyUmVaTGw0?=
 =?utf-8?B?dHhxSnZUdkhpaEdUK2J6dy95NnF3TWpEYUNUYXdkUFdubzhoWkd4aGc1ditK?=
 =?utf-8?B?MkVkZGhLTkl2Nk03SnNKR2xhVENqMlluUTVjdjB4RDF2RjZubGcvMVZma1RZ?=
 =?utf-8?B?a0JpUm9GZ250dGFrVGJRcm4vdzBlV0Q2SlJHb0ZEanBQcUZSUE9SWkxYQ29s?=
 =?utf-8?B?VHlKV3RWdThVOTNDVXBMVktxR2ZzUjl2MkQxUU4yUDhLRTZqUDliU1FiVUg0?=
 =?utf-8?B?Szd6WGpPcjlDeUExR1gxa20yR3pjeGRBdWUrUXN6OVIwbGxiWUNBcTgzVVla?=
 =?utf-8?B?T0FlYm9ldm8zTXdSNlBjcDA4Y08vQWR4M3ZiS1pZUHR1K0o1ZDV4TlN0R3NR?=
 =?utf-8?B?blVRQ1ZJTTVPcEM1aUFKaW9xQWNiOFl6LzNLSEVuSHpLZjNpaG5tYmxVMGk4?=
 =?utf-8?B?Wnc0bE5oSUFQTE9FTzd3Qmh1cFREZVF3bHVHc1g2dmxYc0lZTjI3NzRMcG9E?=
 =?utf-8?B?UGNYd1lzT1JERWVwSnVyVFhtSm1hTE1wWmd6VlA0N1VJYkZZSUdCVHUyLzBt?=
 =?utf-8?B?ZkpoOWtOa1JORFhuU202TTRQaEJYcC9lTnFrNDZFVnBtZjVnSWprS3o0ZlZa?=
 =?utf-8?B?TzZOQzY3b0wrWDd4dzMxcTJVcjdvWUw4TzlBa2dNVERhejdtZHJhYXRBYWhV?=
 =?utf-8?B?ZFZJTmVRTmI3ekMzMWRXa0tZR1FITURaWmhyOUc3VHV4dkUrbXdXOHhETURN?=
 =?utf-8?Q?T6G2W+GkHEy4i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDZxTXdrUzNIdklmVktzZHhTdDdFV0ZWcXBmdFkrQTVTdWVNbkY1d0hDc3kr?=
 =?utf-8?B?RG55bU5YSHE2UWZMWVRUSVNtS21ORlcxc3FxZzZTYnBCalJ4ZWRsSXBiai9y?=
 =?utf-8?B?V2E2YWcyM3NJZk5iK3dpdFlKcTVvYlI4RUtaQmIzODViR09ObEdqU3AxOUk2?=
 =?utf-8?B?ckhPQ0tUb0sxdmRmWmhqWkxzbGFCUHdyVjRpemZKVGVoMjNScGcvc3hKSnZ5?=
 =?utf-8?B?SFdiZGZRQlVadUtGd1EwK3BXdXY3cXVSUE9vWk5LaUdSRldlNUZuaVV5Q2xZ?=
 =?utf-8?B?dG96Mmdpc1YrVHNEVitQeVhNYmpOYjI1dHhSbFdqWXNJd3oza0ROQUlRR2l4?=
 =?utf-8?B?NmRGeWxFMGhDUFJHNC9OMFU5UU8vaVBQVTdUS0xNbkFQaDJLOGtkckUxZWVN?=
 =?utf-8?B?WXMva05FcW5oVHdqMk5jcDN3RUhYSkE0VFhvY21JRk83eUlMR0FCTXdXY09X?=
 =?utf-8?B?OTBCRzRwc1NLZ3BpU1RrMEQ3amxjclp5TWRFUlpjZHBNL292WUNqTDZXenVY?=
 =?utf-8?B?SUZQTVg4cUVNczlxSEluRWdYM3BzQlFSZHhjVHE0Mld1WEgxaFJSS29lYk55?=
 =?utf-8?B?UFppaG1MMHJINGlVejF1SElWdjc3VTRteXAxa0VWazA4TXZ4UHpCSmhGRUN2?=
 =?utf-8?B?S3hVSk1odUFUaW0rd1NLYlR2aWQycFpBMUNqeHFONXNFZnVzUm1OdUdvcmpR?=
 =?utf-8?B?eTBZOENqdzNCK2J5NkhGNXVWaS9LWms1VXpvNUFpZysvOHJZT3JvSGEyWEs3?=
 =?utf-8?B?MC9jVXZSaU5Fd0dpSHg4TTQ5Y3N5TzcvRHhPcWVGckRBcEptb2VQb2lkT2Fk?=
 =?utf-8?B?QTRFazdSdFFaOGRDUUpEc3VYamxnbUNGZGFZbVRERVFSUkN0TE8yTElCdUkx?=
 =?utf-8?B?WTgwWis1d0hpdWQxSHJBQkthTmlQMmx4VEtQbVhkOW5IUU9hRGVnbUpJa0or?=
 =?utf-8?B?OWU5YkUybGJrSG1tVnpPdDU1SFo5SmNNOUUyd2lpOXBhSFJyeEZxZkc0RVkw?=
 =?utf-8?B?eFhrZXprYkEwZzR3UHcxMjhicXVlUHBSMFpRcURhdWNTU3FvM3g0WmpkcHBR?=
 =?utf-8?B?anRDblMvelduS2Z1ZHp4THJtbWtxdFNJdU96bzNIWi8reWltSHVTazkyNHE0?=
 =?utf-8?B?ekl4U2w4YWVJOGcvbEppNjFkdmtUU01tMU5IVVBjNjZXVEtJd1IvOHlBUEUz?=
 =?utf-8?B?blltaHhoNHJ1enNFenZlNDVPNUg0YSt6VUNnTWVZcVVwaWhYaGVnVGxMeWto?=
 =?utf-8?B?b0cyYm9iaGl3Y1A0aGhieGlET3RvY2VrR2V5aVV6eExHSmNvRGMzY29TVys0?=
 =?utf-8?B?ZStOdW9mTHdBakVWYlZMSVhEU1o3QVNvcEdVSjErZ0thL3JodU14bXB3ejFO?=
 =?utf-8?B?cStJTGk1YnJjdlRPNWRsaExialhvTS96d3hPOUoxck43MHpKZmZjSFpWMlJI?=
 =?utf-8?B?b25Ta0ZWV2NNUEFJYk40THgyT24yUU9kYzJMY2Qvdnc1SHBIRkdmMGMzS0h4?=
 =?utf-8?B?TzFTdFZHSkQwNFRkT3VkTzMwNXIwR1NTM3ByL3JGZzVqRG93cFE1cDY5TWxZ?=
 =?utf-8?B?alowblQ1MVFPay9yTXdPbHlCZVllQ2ZOMlhWeExEMTlXMytRekczbERtcG5X?=
 =?utf-8?B?QmtLVW4zVE9lUlRtS0EyeWhGK3pNNnd1QStaRkRVUThFZnJMNURjVDRSQzkz?=
 =?utf-8?B?YnRyU0FHSzMwS1BRZnBqRWozakZQck9YZFJrQTNaTm1mSGplTDExd2todkNP?=
 =?utf-8?B?SlVWTDZKVnRkVDR3NUJkVDlqYWFXbzhtR2VpQ25QbHliUi9wSXN4RVNLRjFl?=
 =?utf-8?B?aHRpeFlLQjhtLzdGaENzSjE3N0E0aWtuZGlEd2tsTzYxc0NUOUtTZFFscGJJ?=
 =?utf-8?B?MWNBMVAwNUE2M2d1UG1UdFFha3MzQ3B6dXU4WEpzWFc1a2VHZnk5bE05K1RX?=
 =?utf-8?B?TzFpV1hsQk9nVUFrTVp2c0VwcThKLy9Obll5WWVlU0JEKzJoK3c4Mzcwak1r?=
 =?utf-8?B?Y3ZhT3JRUXBmTE9hNjhKYUdhamp0YmpPb3YxTlJRU1hlSGsvMFRRTE5rSU9X?=
 =?utf-8?B?S0RGbUpJN3lKWTBDSDNOTEVOY3hBWHZ5L0ZJZVJjelFUb3l6QUVpY2RxWTlo?=
 =?utf-8?Q?3DI505Iih1YtuZRYzm2pmIxij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3ac0f3-7fd0-44a5-ce46-08dcd6348e50
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 09:47:20.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM534tS6L81WeOH48Hrztb3bb9RHTGOknpys5GHKLt04T/GgNAaaKwag0W3funDInBbNmWfUmqxlprD6pj6Mug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117


On 9/12/24 00:55, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move those functions required also for Type2 initialization to
>> cxl/core/pci.c with a specific function using that moved code added in
>> a following patch.
> Please consider rephrasing as:
>
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.


It makes sense.

I'll do.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h   |  3 ++
>>   drivers/cxl/pci.c      | 60 ----------------------------------------
>>   3 files changed, 66 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 57370d9beb32..bf57f081ef8f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1079,6 +1079,69 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>>   
>> +/*
>> + * Assume that any RCIEP that emits the CXL memory expander class code
>> + * is an RCD
>> + */
>> +bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
>> +
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map)
>> +{
>> +	struct cxl_port *port;
>> +	struct cxl_dport *dport;
>> +	resource_size_t component_reg_phys;
>> +
>> +	*map = (struct cxl_register_map) {
>> +		.host = &pdev->dev,
>> +		.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	port = cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> +
>> +	put_device(&port->dev);
>> +
>> +	if (component_reg_phys == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	map->resource = component_reg_phys;
>> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map,
>> +		       u32 *caps)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_find_regblock(pdev, type, map);
>> +
>> +	/*
>> +	 * If the Register Locator DVSEC does not exist, check if it
>> +	 * is an RCH and try to extract the Component Registers from
>> +	 * an RCRB.
>> +	 */
>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
>> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_setup_regs(map, caps);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>> +
>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>   			u32 *current_caps)
>>   {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index eb59019fe5f3..786b811effba 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +bool is_cxl_restricted(struct pci_dev *pdev);
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map, u32 *caps);
> Does this need to go to a different header like include/cxl/pci.h or something for type2 consumption?
>
> DJ


Next patch introduces another function for accel drivers which calls 
this one, hiding things for accel drivers and improving manageability.

Thanks


>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index bec660357eec..2b85f87549c2 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -463,66 +463,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   	return 0;
>>   }
>>   
>> -/*
>> - * Assume that any RCIEP that emits the CXL memory expander class code
>> - * is an RCD
>> - */
>> -static bool is_cxl_restricted(struct pci_dev *pdev)
>> -{
>> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> -}
>> -
>> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> -				  struct cxl_register_map *map)
>> -{
>> -	struct cxl_port *port;
>> -	struct cxl_dport *dport;
>> -	resource_size_t component_reg_phys;
>> -
>> -	*map = (struct cxl_register_map) {
>> -		.host = &pdev->dev,
>> -		.resource = CXL_RESOURCE_NONE,
>> -	};
>> -
>> -	port = cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
>> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> -
>> -	put_device(&port->dev);
>> -
>> -	if (component_reg_phys == CXL_RESOURCE_NONE)
>> -		return -ENXIO;
>> -
>> -	map->resource = component_reg_phys;
>> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> -
>> -	return 0;
>> -}
>> -
>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map, u32 *caps)
>> -{
>> -	int rc;
>> -
>> -	rc = cxl_find_regblock(pdev, type, map);
>> -
>> -	/*
>> -	 * If the Register Locator DVSEC does not exist, check if it
>> -	 * is an RCH and try to extract the Component Registers from
>> -	 * an RCRB.
>> -	 */
>> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
>> -		rc = cxl_rcrb_get_comp_regs(pdev, map);
>> -
>> -	if (rc)
>> -		return rc;
>> -
>> -	return cxl_setup_regs(map, caps);
>> -}
>> -
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

