Return-Path: <netdev+bounces-238038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04AC53171
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9042E358D27
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB0A33C539;
	Wed, 12 Nov 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C7siJ55K"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828A2BF00B;
	Wed, 12 Nov 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961224; cv=fail; b=Lmi0T0bTgmfpFpxkgo/p6sElDuiQZidByBavqGt02VsX+xf42X6fbVWbU8zlfaX3z36RPlBgM5u000pbP8YydBbB+N9TJ/HtGyvokPm+cp3CYQyUbMu8p6uYOG6j8QpR2hoZrggpT8RONOnqrofrB8/kTYSQNnstZ9nSpze+984=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961224; c=relaxed/simple;
	bh=2w8tm7aovLLeZyiapfbyBjVBpyPx5RddOgsJhJDt4pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CPjwC6bEPo2+k+uVovYHkIelYRjcwiJg6deIP+XLV2duJHVteywYrY7z6s47l8s1arMG5JK+J+y6x4hLVUvHObMS25FgkTxfgSsVUz/cCIvG0PAFlGtVhTgDw4JMHX+DLsOlBUW3hZAKTlx6YLtwD+tuSEJ0q7t6IUk7TAc3Zc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C7siJ55K; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l67UqKFyhaNfSDrvUde5YgPYwekuZFOOkQzZ5yTZFDZsNMT67oZGtXzIH2bov2wRz14cga+hWWasXuJNWv9JIVj0xJKV3nLPYavQ32Etxy6FsI2upvEMzAJqRX3rhUUMhk1C/QWnBZOpw9+DKeDD0QSjHMuod9VF5ujvKI/00MwyDrNsRU6oRNlPTOoYJCwnp0fALgrcnYwdQev8Xrva7a3UK4gi1HfmJvbzK9JgInQP2w9vFPn2ahPsWlBnfdSp8wEbK7fO1bDCNGgWWDTwVaE7WKmbbZCUvIdVt7QLeQY5CZl+zUbrxtBqqp1wAIEQrCwAYMSoURu1IyoLPjccTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BASooSZnhLVsTprrF9AkKOA1yfy0Yqp9oD8QDMOwJKY=;
 b=EwOCjXB/JD8aSqrEn3iuy79FkMUDFg+BYprHFRtvbUYtfhVd+yx1Dnkttb+cSfFpwJ/uNIPfB57P2ov73P7q3CeNIX3fgpIAO+wyzGiLmemi5kYDmf0HxaxPSCoyNSew1mirTyLtyquMbDHugpnz7kl/7Z906PDAPFp3sUkMm65H5cQuuKTI1bJQiueCAhUwUe/s1N6fTs4ZhfK451+tl27Dq6sqolFxkpV08eucJ7dKbC5yYytyvmxSKf4qlx1KRtbO05ucNaZ1riEMW7dI9FQb+Ebb0posCkQ/L5gGEf5hJ4kM3j6PrNIn6niv0b2rzlmawT+6JBi25A0H/bOUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BASooSZnhLVsTprrF9AkKOA1yfy0Yqp9oD8QDMOwJKY=;
 b=C7siJ55KLi7ok7CoxbY0Nmw6/Q4FSjynpjIgQWsoAGIGTCQzpeteFU0Im/1WTt6gsFFMzlJpbLtDIKxQGqnXCf3jFwh0cTtBRPqiPmyCwOBKAUrogVQ6aCB438qy/ql6P6BdJkdncXU5ufYKn5K+LPpj+0jV3qHLZ9YZl58jxg4PzgjrbSAc47Y05J6GqM2oyTnjRTHosN4FtXaMeusH2DGEcVEpgz+K6Vm0PqYeU6QN7p2sDo2kiBF7tFhUrjj+Lf7e7IIGLuBUNVedjbcXZSDNelzLGN/lD9b5pXz4Ms12yCGVeytIeQskI3TJOWWIvUn5Kv3I6OrUbPqUS8K6TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:27:00 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:26:59 +0000
Message-ID: <ad338b41-fcf3-4861-8106-93e6d013451c@nvidia.com>
Date: Wed, 12 Nov 2025 15:26:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: fix napi_consume_skb() with alien skbs
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-3-edumazet@google.com>
 <7460a188-3a74-4336-ae03-c88e21ffc1ca@nvidia.com>
 <CANn89iJBgaoVuQL7jgKwRJd8drpXYTLdGrJUpP9KVrzsPGK_Zw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CANn89iJBgaoVuQL7jgKwRJd8drpXYTLdGrJUpP9KVrzsPGK_Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0449.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::29) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd1a9f6-7ba6-4216-72e8-08de21ffec2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEFERFhsUm5sMEdTM2IrQmFyZFlST2xMY1JQNW9YYUg3UmxzUFRLMTJCR3Bt?=
 =?utf-8?B?MzM2YjRRK1hNcTRtVjVEVkYrUGkyZGJyZ1FoN0VrcExCRWw3aGRSaUdkWEZJ?=
 =?utf-8?B?cU5lNU5SNnpyT0VpandVemFDOTB3NTI4K3hUR1FDUjYxbEdlREVPNXhRdzZq?=
 =?utf-8?B?dFZ4OWlsTFBJRTlTNnhjbmdBZ25aSENTSlhUZDhaY29rR2RJVHcvYnRwUkpB?=
 =?utf-8?B?Z2FVdnBiT0psQjBJakFlZG4wM1NNTEtVdTVvVUdrR0tMU2tIVGxqMUFUdWxE?=
 =?utf-8?B?dHNCR2hKZVdYMnlWOVpUNWQ2c0F2WWRYUGJPN0Jydk5BM1FTbXlqWURDWlE1?=
 =?utf-8?B?N2k5MU1EN291YUt2b0YzdUgxWitqRFlSY28zWVJza0pudXEzdDhCdXk0aTdU?=
 =?utf-8?B?elJHTUJ6cHEvL3FoU1BMMFJHanQvMVpLVjhuMGZpeUZrWlVGY0ZVZGVpOVpC?=
 =?utf-8?B?NnlodDJSK0JHcEVlRFJaN1ZGSzg5bnBScDZwU2g3SllFU3NESlZkOTJxZTMy?=
 =?utf-8?B?SlZPdjExekwyVFpXQVhOblhLeUJwdmp3d0dzRHBoejROTUVFSWJ6NUNQZG5V?=
 =?utf-8?B?WHEzczdJVXY3UkpxdkxRLzhyTlJXZUtsaGlWNWtwVkg0cXRhRlo4VmVTY0w5?=
 =?utf-8?B?ZUl5WEQ2eW1pQ0Q4cXpBS3VWTDdBcXBtK2dNY2VBMnhjVGRoRDdwQkxxbHZL?=
 =?utf-8?B?MXpCQlA1cDQ5TTNQYUFxY014eFVIQkptT0xqRHk1VHY1bkp3VXUrcGlvdUR1?=
 =?utf-8?B?d29xZm5tUVM5UUxpbFoycUxBcWN5ZFN1NnIxOVBpU3ZobE5IQVY1MWkvUUhQ?=
 =?utf-8?B?UVNXQkhINEVGYmJNODRSS0M5aTV1MFBzYndsdUtKdTJnMHNXNjdIdDhKL1Ez?=
 =?utf-8?B?ai9ySXNqSHdBM2lQb3o3cytzUGdLTFZLMHBGMlA5R3UyaUxpSnMwMWw2TGV0?=
 =?utf-8?B?a0cwSmVlcnVoOXlXNFJRYjZpbjJ1Tm5rZUpRdEdhVHB3WFQyYkgvY2w4bEUx?=
 =?utf-8?B?UTlqbTJ0V1E4WGMvZFJGbWpIWnFycllDdkhWN1FpU0dQbUI4aFBHa2pnM1Y0?=
 =?utf-8?B?ZEQ3SEhkd1BCZ1h2U2hKeFE1M1h4UlB3c0NLalkyTXpBNWhwR0hjRFFjNjIx?=
 =?utf-8?B?VGtxSm5Ucmdpd1RnOGc0eThuZXYyUFhwdmtZd0NoMk9EYW9NbG01ZXZDVHhC?=
 =?utf-8?B?T2dxNXRyNFJTRnJ1SG5seGZ6Zm1QVGYvTjlOeW84RmNuNWtjTTBwKytxZkFI?=
 =?utf-8?B?elB1UlpyVWJORVk0WWtHN05WdDY3NEVtenN6YS84dlZ0OE92WGo4eU56TWVK?=
 =?utf-8?B?L21uQmhjdDBYUVIyNjJrWUVOc01OSkRoRXlnU201YmJFanJ5RS9EOW1lZ0RC?=
 =?utf-8?B?QkxieUxyYS9Pank1UGx4dHFOVVc2bmlQRVhUTmtqQmZYUkpFWGE4bGtJYXZw?=
 =?utf-8?B?cTU2ZFE5V0NYZlIzQy9MdVJsY2xMQzl3VGhpTCsvN3h0VUVJN2lvd3ExT1ZY?=
 =?utf-8?B?RHZvRWtLL1prLy9WdkwxOVBocXF6ZnYrZzdjTW9TekJyMmJweDArSmpybjZE?=
 =?utf-8?B?Z2NzVnlyN1VWSjRPemtkdEdJVjh1b05xUm55S0VPUE5wU3U3aG5YT0xOOUZC?=
 =?utf-8?B?UHFyL282WVRTd05FdTl3aE1xL0cxcW4wYldjUkV1ZFA1ZHp3R0dJOTlOWTVI?=
 =?utf-8?B?VmhqN0hUTUs5QU4zN3ZiZkkzSjhkQ3F1SFd1ZE1wN0hXenlpZTNKdnpxMVl6?=
 =?utf-8?B?andHYXlreUpUN2tDNG0vT2pDWHUvYWtNbVc4ODJkdVFDdlZTVVdScFUxMHlx?=
 =?utf-8?B?bDQ5UmpLRi9kcGhZSldieTNETGI4QUdnSW1aVXFJN0pqTjhRL3ZMMHdPRzVL?=
 =?utf-8?B?dnB4dDllbkxiTzRiclNNcGJZejZPTmZ0d1pMNDdJa0Y4d21uYWIyWnhOZVZo?=
 =?utf-8?Q?suUnOkYls6/U9ruiZZnbhGy8WLagB05Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFRYUG5vL2RDWlVLVWtQc1ZkTHFFV0hJZi9USUZtUndlMXFGb0tPbnJzd3pI?=
 =?utf-8?B?WEdzVFBQTFBRVjhMZGc5UEdPS2JDWGdaUFFibXRyRUthTkZDbWRKeGxhVmt3?=
 =?utf-8?B?WVhjUHNuOE14N3pRUmZ6bEpKUDA0RitRemtzWHZuWFJzcTQ4Q1VrK1FzbUU2?=
 =?utf-8?B?bEEvVXlBc3FHakRjMHRYaVcyZGYwK05aVm1pblZvZUVnbmMvem12ck0zZzRu?=
 =?utf-8?B?SGRSaERqam4vdU0wR0FlamNWUDNkdWpDTklNaWNWN01UREV5WjBNcnN2Q2g2?=
 =?utf-8?B?LzZIa3l3VmpZaGVCSnNKME5sb3dPQ0VodVpvOWp4VWZFRDUzV3VMK1VkUkxP?=
 =?utf-8?B?QnlmMDZlVm9ncGxIZ0t0MEprTHRCSHI0NExJNEhoRWcycXYrZVJ5MlFHM2NY?=
 =?utf-8?B?UnI4eG1EeTVHNERjY2lLNTBjY01pRE1CMFBiM1pCYXJWWlpZNHRFcnRVZ2M4?=
 =?utf-8?B?V3JlMmxwVUdUM0tMZGRYdzI5N1NYeWVwUDFxQ3JHM2NSa3RGM0JTb1gwUStq?=
 =?utf-8?B?N24yQTYzYWxjM01TY09LNlhwNXFvRGlkVDFmMitiQVpkZEp2dHozeWk3SFZ6?=
 =?utf-8?B?NUExTTlmbm9kVWR5dU1ER1d0RDA2cVkvMzhVT0dJd2VoNS9DejBUNUFwS3Mr?=
 =?utf-8?B?M2w4WG9XMHpaS0RQT0R1YUE2a3BReW9xYWhSS0ZEUWJUVWdCZDB4ODZlU0l5?=
 =?utf-8?B?V2ZuLy83a29wSFRKbFVzUC9PbGh4c3ZIc1dodWs0Qkk2dnZseEM0bUx6cHRT?=
 =?utf-8?B?WWdzaGdSbG9oV2dROFVUOTNlOWpWdFNRNWkxSWttdmQyQndma3ZVeEtXKzFW?=
 =?utf-8?B?SlpSb0FGOHBQcVZBV01QT0NDQVhHYlNwZnJzYzFSRStLQW5Hb0NKRWZyOUFM?=
 =?utf-8?B?d2lvTE55aDN2RWlISjRYc0NpNDZ3cHBZZFFqKzJWV3lHK0xnckNpRndkRGNH?=
 =?utf-8?B?T2lwZGVpN0dKbVZmNGRtNTJ4K1VKNkVNczdNOTQxKzFhajRaTkRTbG5GWEx4?=
 =?utf-8?B?bzIvTnJ2KzhuSklqaHRiYWNBejF1RzVpdHV0eFh5NXV1N3p1ZHYwb095MGla?=
 =?utf-8?B?U0wrM0g3UWtydWNxWWxjODlNblRMK1g0U2NyQURLYTJOdW10ZEcvUndiUlAx?=
 =?utf-8?B?K0hPV0paMW1oMWlrOGRmWERKemszTGR5dTgwUUpwRXlBRFBUN28zbzkyRGpM?=
 =?utf-8?B?WWIvTndCRWh0RUkyb1FvTUI1ZkpWVE40MVo4Mit3TitJVHRPaG5nWERDYXpL?=
 =?utf-8?B?ZEt5cWhkNDRZVlF4eVVhOTNUSFNuUjdzeDlOcTV3MWloMmR3a0FDeER2MldP?=
 =?utf-8?B?T1o3RFN5MDFiSFBWZk9neGY1R0VEenVxVGZXTGtCUkZXM24zY0gyc0xmNDlL?=
 =?utf-8?B?Unl6eXJ3Z1V5TmxmOG1WY2Z5SC9kbUh5dWozdXFCRE1ha0VqNXJROGtUVVhq?=
 =?utf-8?B?L3czTGdDVTBkcktMM2YrNGtmVmJWSHlUbmJla2xGYXhUSzR3bGVHVnlYeS9V?=
 =?utf-8?B?L2JOMWRwdHJxNWxMLzQ0cmNwaHA2V2VyTzQreEs1eXpnUGtVZFlkS1duTTdP?=
 =?utf-8?B?Z25Za3FhZC93OEZUcGtqOFBoT0RyWlVPNU5pQTllOHFLUksxRDVDQjJxeEFY?=
 =?utf-8?B?RGhScHdLbnArWU05dU96Qk4xWXA1NWxHZG5uY29SdW5aSWl0b1hJdVVzc3hG?=
 =?utf-8?B?UEFDcmJOTFR3c0g5eEZxeFlUOGpyaFk0SEg5dEZNNVdkdm4vVnVGUlhUNXdT?=
 =?utf-8?B?NDUvbTZXM3hCZzhsclJrSUNCc1B6cTUvUytVWi9iaWhKdFBXRnlIYStYWWk0?=
 =?utf-8?B?S25HOE1tanJoS2ptZndSNmNTOEVpQUMvYVcrb1lxYWlsQmZQN0piK2Z5ei9I?=
 =?utf-8?B?OHVMVHRZTWhnUE54dHg4bEJvTkJDcDZPOWJDMUVadHR2UUY1TFArV055aG9Y?=
 =?utf-8?B?UVNrMkQ5RXl2S1Jwam00Y210WWp1d29YNm5NUUdkeEl0UVJGUDhDUysvd0Ex?=
 =?utf-8?B?OXZ1SXJvUk9RbE9jbDNpZVpUOXJILzJ2Y09Rbk5JVk8wNTBUMzljZ05YbzFo?=
 =?utf-8?B?NVdXSnU1bFFySE8zZzltM1FsTWhOZGtOS2hWYS9Sb05sUHFkTHZKSjBPZDlQ?=
 =?utf-8?B?Y1RFOWpxSTdnVEs2NlplOGExa3IwMGthOGVsQ3JTM0QveUhyMUUxSml0T3hP?=
 =?utf-8?B?UjJFcDdteXQyYVMzRkpMTkhBclA2a1ltbEZDRmlhVVVqR0hTeWNTS28rMzJ2?=
 =?utf-8?B?MXdnS1VGdy9zY3lvY1B0T1Uxb0xBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd1a9f6-7ba6-4216-72e8-08de21ffec2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:26:59.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTBytSKL160sHxmzC9oKf6kb4HyNTvAiESFtdBjuUXPv0W2a9luqFk9Gl4oMb4e3NJ/S/s83LkFX+ZUp/yIKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856


On 12/11/2025 14:08, Eric Dumazet wrote:

...

>> I have noticed a suspend regression on one of our Tegra boards. Bisect
>> is pointing to this commit and reverting this on top of -next fixes the
>> issue.
>>
>> Out of all the Tegra boards we test only one is failing and that is the
>> tegra124-jetson-tk1. This board uses the realtek r8169 driver ...
>>
>>    r8169 0000:01:00.0: enabling device (0140 -> 0143)
>>    r8169 0000:01:00.0 eth0: RTL8168g/8111g, 00:04:4b:25:b2:0e, XID 4c0, IRQ 132
>>    r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
>>
>> I don't see any particular crash or error, and even after resuming from
>> suspend the link does come up ...
>>
>>    r8169 0000:01:00.0 enp1s0: Link is Down
>>    tegra-xusb 70090000.usb: Firmware timestamp: 2014-09-16 02:10:07 UTC
>>    OOM killer enabled.
>>    Restarting tasks: Starting
>>    Restarting tasks: Done
>>    random: crng reseeded on system resumption
>>    PM: suspend exit
>>    ata1: SATA link down (SStatus 0 SControl 300)
>>    r8169 0000:01:00.0 enp1s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>
>> However, the board does not seem to resume fully. One thing I should
>> point out is that for testing we always use an NFS rootfs. So this
>> would indicate that the link comes up but networking is still having
>> issues.
>>
>> Any thoughts?
>>
>> Jon
> 
> Perhaps try : https://patchwork.kernel.org/project/netdevbpf/patch/20251111151235.1903659-1-edumazet@google.com/


That does indeed fix it. Feel free to add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


