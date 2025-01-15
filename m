Return-Path: <netdev+bounces-158661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1FA12E25
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89723A6B35
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496B1D5AB6;
	Wed, 15 Jan 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/aYYatF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02B8F77
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979397; cv=fail; b=M7ItgzEGHC6t/Z0TsAMRxECiAD8GiYsD7Xl+8lKk3B5QxvhDv6r1gL21IyKkftQ7Nr9MgOLvYsqLpMDKv0rP1kmQtLN5bUPNZ8YHZpEF8XPNfMBsWKSljAIbfhB2ggtbbSrXm9qU2b23K7aUNeaf+WBvsoOIuel+GmE4zV7ZYvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979397; c=relaxed/simple;
	bh=tsCSqbRKuDxmSPKY1PTMe8YrLQZ7KkrJQMItCa7kpPg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nfrfd1niLzAV1gowwNSoMgepAH6IbgX2h56qaeaYZOD1rp7qqsLou0N4dyAX2pqb8OCgDSQnpGYbNzGVqQ6jSTtc0xkPBi1lcdi6wShSrKwrrucGM+T5lmWaQZ/qtUBujJvupZV4Ww3P+uTZKMyDlVvorRGNKRO8Zl7zeDkyxXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/aYYatF; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqy9ZZKIH14ehHCsrWuCuL/lXMiwKa1t6yAqueelLTyHrwBf9jNdUXypr6KJiAFlIKRS+VdA7wtGk26ETgJMzMN+9SjkbVJp8wsLD1lLRQQguW+DKakCbIoyTpuOpXLPh+Bll4WR6ScvCuIgn7xdRFzYBQFah39B4tI8bhVsQWc+2fUXFzWveTtUES0u30eIcXtKTzEj4tmfSqL3rpQW+SrCGCqJE8V+aO/23KWub9oLxJDDMc2zd6G5y2Fd4j8z/6ZZa4qapD9+/WlxuYzogzOwTSEeOmxBhuFDRX2G+XPUejEv3SnnOvyoC9sCLW65uNseRYYa5uxxoN1MsTdGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZJwKSi65i9qVupabj1UfQbyVKnDMQ98avpZSlwMtSE=;
 b=AW654JmyQ1OFMm7tqJ5VdoHEkmmui5AQy0IDSzgZq0Hrp0Dlo2g0+yZKiTQ5Z7ydBxS7oIaTndx9NliKe2kYo4tJulmmn0AbDibGp2MIylcigd4tskcavGhYg2HIDImMtjS32OTWsQz1A34U2PBTax6cNTwdBbhinQE0Fj5T/1q+VyQb81tP6jTlWXVZzk/Sco/u8B8cXsCxFxUfwYSQ9dxOAopTlQ/VmbAT+LEDRV1OAn6ycLgiq+UhrMrTtKQ/pYRqvBeAMhhs2x1cJJbamk1URxz/wtpoS6DAwrl8fqJYRwALgq7yK/eUVseCT9VwVG1mall5Q14WBM7X8TLGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZJwKSi65i9qVupabj1UfQbyVKnDMQ98avpZSlwMtSE=;
 b=j/aYYatF6u7aYxxLC1wnqKfVxWXY9pKgKsnT+25EP2uBeMMgpV01mG+Kyb6SJx2LIR+hGvP5eHz6eQpKhaxqY2iOmo8CY4bUbRQ5mnwbAdaurzG0tgmfqpEaI5pvDElI2ayq2tkiiINhPXDdUPUf3ipkMYogOZlLB8Nec+FF+GrIq1/d9tcFZfzEd+tOH2IOxmFNGEkfF7TCJBF1a5/KOHFAdCrG6uAfev9LP+LsaH/s9Xf+Ean2YtX3Kyr94O9NrCIzo2X7H179Rq0lluGb0hgINJo2pfeSGCHVL4+gIjQaVJEb0XJpiV+u1q4BZxBJz0AE8HUCSeTOov7WUoecbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 22:16:33 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 22:16:33 +0000
Message-ID: <146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com>
Date: Thu, 16 Jan 2025 00:16:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in
 (un)?register_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250104063735.36945-1-kuniyu@amazon.com>
 <20250104063735.36945-5-kuniyu@amazon.com>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250104063735.36945-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0255.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::27) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 8242d7ad-73e9-453c-4f6b-08dd35b244a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1NDVTJZcW1vcENkRWFnMVRUdlk3U1hPMktwcDVnbGNBWHB2QWdxSWQ4L25J?=
 =?utf-8?B?TFVRNEVTYkFsVkNkTGx3ZmRXVTBRL1FKNjNadWZUYTIyaUpVZk1EUWpUL0JZ?=
 =?utf-8?B?SkZqMnpwVjdveERDMVo1YjNGZUZqNXJxODRUTGs4ZWJPdFVRV2QvWkdpS3Q3?=
 =?utf-8?B?eXE1S1R2ZWhSUER6OE1XQjJINGF2REI2NEhwVDIwY0Q0SDV0dTB1WGJJNWo0?=
 =?utf-8?B?bzdnZ0Q3eE5UQ3dIOTNoTnJYb0s2NTFtNVk1YTJkNVFYa3hLWUR1Nm53MTdP?=
 =?utf-8?B?UWo1Q0R4S3FhNkVTbHZxNzRmUFJYK20yRDh3ZjhjL1E5M0VpNEtCOGJCNUlr?=
 =?utf-8?B?c3NvdjFYcmRyQ01CRUY4YkV0dXlmN2d4TXEyNlVTblNpbHgrVjdtRHBxTnFZ?=
 =?utf-8?B?Y2RiWmtxNkQyWTVnT1ZNdjlnNTE0eHV5N0czOVVQb3VtdzZHUjRyRVZzamZT?=
 =?utf-8?B?YXUxS3F3VWRzWEJTcXh1UmdVVlJpVTlwZTlvbGdJV1RCdGY1NGVzOHlqZXZV?=
 =?utf-8?B?ZktJZUVaSkV4VFhyaWhlUW1ZRU00bVlpVkVhSmJ5cVpHYW80ZG03cFRzS2Rx?=
 =?utf-8?B?T0oya1Y0dkEyTW5xWE1laGlOWXR6RGh5MTNNazhmRHIrQWNRN3EvYklHeUhF?=
 =?utf-8?B?eExCRWZxamxlY1Z3LytPeHBpaER0NnB0V084OWpDYzZzaWt3bVpUci9ta3dV?=
 =?utf-8?B?bzZBYlV2VEZFYWtQeHp3c05FbUhWTGUvMlAvSWFZRTMzamJOdGFSa3BBSGpl?=
 =?utf-8?B?dDhNMlVxMVN6eFh5clRYcnZwRTFsaEZxQytMdm93WnZZNFdsNkF5em51VU85?=
 =?utf-8?B?MmdMZThHem9hVFhmNEsrNHpMcHJMbWhyTmJwUTNIM3lKOFJoRjZaZWxPZXZr?=
 =?utf-8?B?b2pBUmkyL2pPNTUyU0pZS0NMYzhuRW9IZ0NPT3VsbTdVVStMWVNCYkNicG9x?=
 =?utf-8?B?ZGR1Y0VmcERZUlpYZGZrR1ZrQkxlcjAyOVRKNGIwUTh3MlBoR2xpbGd0bXo4?=
 =?utf-8?B?NnhKM2dmUWoyQ1JTVC9MU3FaZFVBRExDTmVFVjJSWG9HU2ZoSzFsT2UrOUJC?=
 =?utf-8?B?RjR3dkVYemNOc2psbHh5bzBMVDFBS3B4V3VUTkxhQW5CTitJclhUQ1dCVEQv?=
 =?utf-8?B?RVI0aUJKWStjUzlNZ0pMclRIVTlCSEpBRng5YlpJeHExR0pmL2EzY002VlJ5?=
 =?utf-8?B?Skt4dGNMTExDY0RRT3NJRWxKQ3F0KzhMaGFiK0YxVjBBNTFMdnBuWng2Qjg1?=
 =?utf-8?B?NVhEbEUzOUx5eE5GQ2RJRElOWVdNWktmRVBseWozTm9FMnovM0huck5xTDZr?=
 =?utf-8?B?RE1PYWp6OTZlZ0VQUG9UTzNFSStGMm9KVGkzVlBuRkpOWDVtOG50YVJkYmdM?=
 =?utf-8?B?d1E5QjVIZ2c3MmgxbzZRZ0VZbXNiWWk5bjAyM1hSMFVmM25wRnJCVlBxSW1x?=
 =?utf-8?B?cm84QndkVm9OazRsamNDc2REaVBYWXdYZkhuV0dLZTFkUllsWmpnRlg4Y2Zi?=
 =?utf-8?B?WERKQU5sZnNHTGJiY1lSRXhXSDE4U1ZZTnphN0pTbWFFQTl2dCtQdnpkOXk1?=
 =?utf-8?B?T0hxek0xQTdLVDNxS1Iyd1cvaGNqQUFBalJ1cWxDeTA0aXFRNDhON1gweXVO?=
 =?utf-8?B?UFZEL1cwR2VOWUE0MFh3bzJ6UVBZOHNyTjBHUkJ5azJnN2k2aFA2emhGMjc0?=
 =?utf-8?B?WVEzL3p3VXlzazBSTWpGcnkxcTdGNW51VFN6VlB3TGRNSkFDd2ZvbUZ1WlNX?=
 =?utf-8?B?aSt3NjBwR2xaM2JVYUhmMW9xZ0xGVkxlRHN0b1c4Wm5OWElGWTlGNUFLa3VG?=
 =?utf-8?B?bjBNcGI5L3JoVXM3UzNyUjN1L0p4bnFZRVJUVlAwdXZXbVpkSm9vdVlLaHNY?=
 =?utf-8?Q?D3SMwGJ+HRmXx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWxyQnlCQjZ5c1drR3gyZjY1NFB0K2o3Zm5nUUJ4UXVOUm9NcHZjSmRyeTlj?=
 =?utf-8?B?ZXJkeW9NUEQycUMyS3JUMnBjb2ZuWnhCYXpCaTFFVkxpdjNBKzFSK2ppNExS?=
 =?utf-8?B?YmRia2JyUVhHWlhibW4wSkFHek5WdE5ac1dYSEk3Q1VhTi9waDhkTis1ZXVk?=
 =?utf-8?B?UVl4WnNmMmpneUtnVU1aSHE0SWpGODRTbWdqbElzZWFDWmd0ZG9nbG9QOEhN?=
 =?utf-8?B?MHZoSFlXYm12M01VL3ZabWcvM2had3liTTlXQjBKNmFCdDhBeTRUazBMa1ow?=
 =?utf-8?B?MHBLY1NzS3BtdTNBRjl5MUhBdkV5azh6YUJ4MmhqU2JZeFhvK3d1YkZDZEV3?=
 =?utf-8?B?clhzQXhVR0x5ekZKMGFXQk1DVkQxaHpjdXhPK0NqUDRUVmRNYjNlKzhlNDR0?=
 =?utf-8?B?c2E4NXBybkhMRDNJWWpuNWU3WEdabGozWEtpQnFDWklZZndxRjV4enNGMGZi?=
 =?utf-8?B?L0VhbGpxSE9EeWI5SjBWb1dnRVpLelArQm9odkJVdTlxUVpxL1FhN2ZidHpr?=
 =?utf-8?B?aENZWFFUK2YwZmdCK2JVQkc0ck9pbXJ0S0JNUW8zUjVGT2FYczFIbTJsSlk3?=
 =?utf-8?B?SkQvOHpCWDVHL2UwQ3NYV2QralFWN2JhVFJJRzQzMmUvYlRQZFZteDA1Qk5D?=
 =?utf-8?B?dzBzcFRRSndoN2g1Y0c4VFFPdFVjd1VWNE1Vd2I0cUtCNVM2TlVuc2k4Skps?=
 =?utf-8?B?SEovbUhGbk45eXUyOG9RYmZKemd1S2JKbUJoM2FqdG1xNWRXMGZ5YnRhMm1o?=
 =?utf-8?B?UnVuWWs1VXZmYnZXWDRGMTJQQ1l1d3gwTVNiUVhacUxoTWFubm1QNnZ0NFhY?=
 =?utf-8?B?OUtWRThFaFozN3Ira1pzZWlOZE5aanpIMlZFeENSR2s2UjVaQkkwRDZtcFNC?=
 =?utf-8?B?TzBqaENBcW9XVnZnNS9rT2NMZlJYUmNvNms2allyRmJraGZHcnJuUTNvcUZ4?=
 =?utf-8?B?ZFVtdkZ2dytOZ1p6VVJHNGdvdXU2OC9MS1NYMzgySEJRYjdOcWpXK2kvNmUx?=
 =?utf-8?B?OGVpemxxRFNaRTlCbkFoQXkrRE1ieUliY3l3R1NuT3AyQ1FRWWl6N1E2dmlU?=
 =?utf-8?B?VHlXblVNQW94OUVFdkMzYllQcC9tQXlWeTFTVkVxcDRDd0diTHVld3F1SHo5?=
 =?utf-8?B?bjVtSWlNSmlPbXZTakNGNFdJd3lnNmdsSkRTLytxd0JmUFY5bmFSclpNK29C?=
 =?utf-8?B?Kzg1SjkvcEhQdEdYbDVGSFc2MU05eEZOUkNMblNETmpjQ3d3V09BUW40dkdY?=
 =?utf-8?B?d0lMcDI5UTRrUk01QXdkK3NocTJpSXpBYW16NVlIRTI2cWY3UGxpWEdFcFB3?=
 =?utf-8?B?SUh3MWtudXF0eG1ScndIRW9MamFUdmk2dEJ0Mk5xZVI0L1R5bVlCSjZ4NS9M?=
 =?utf-8?B?czd1alphc2ZtS3Z0OGNGS1MrOEMwTWhHUGhQbDVieCtMZkNLSEtYSUhYNnhv?=
 =?utf-8?B?RDZwVEI3Q3YwNks0RGZmYnN0T21FUFQ2SSt0Q2dhbThiOHVBeFo1UUlBRzhS?=
 =?utf-8?B?bXFaOElTRVdDMjJIMm0xMy9PU1l4M3NEVlI1WmIzamRGYjlhSm4vZU9jUytl?=
 =?utf-8?B?bHByZHp2YjJVNU5iUWVyU1NQNmV5ak9WOE1raiszcSs1L3lDYnRIUFYvU3pL?=
 =?utf-8?B?NW1QYVZGeDZxazBGUFRtWWxOL25NRmRRbDhZSFB6N1lHdkthaEJPQjRTT0p5?=
 =?utf-8?B?V3NpcDVZUm90S0RGMzdkSjcrOENSTFdBVHg5SytlZE9QV2UzUklrdjJFNW9j?=
 =?utf-8?B?cWZvazgxWjc3REZOMVlycEhhSjdlUSs1TjRISmFtNUhqZHVKRnFqZTFmaUw4?=
 =?utf-8?B?RW02VFRka1VTVHdYb1E5WGpnTDVHN1NGU2Q1dlBpYS9Fdk90aTFWK2t5bVRW?=
 =?utf-8?B?ZkkxV1paVktMcTdPV0ppR3d5OXNoVDQ1MkF0SFJTb1Nwc2dUSDVoeEh5NlQz?=
 =?utf-8?B?eVlwbGJHRjdNU2lqaXUrTHcyLytBNjdnZ2sxVk9iZGhoRUVkMmFVZVZ2TVA0?=
 =?utf-8?B?bFVER0dHb2pWNTYzMVRjdnVscDJpejNIQytDSThscCtyTzh4Q2JIU2tWeW9R?=
 =?utf-8?B?Q0lodjBNdUNPUEYrZXd1Ylg4S3c5bmVKVnNvbXNwRVJzdStGL1JLTHlJTS9C?=
 =?utf-8?Q?QK/QAhSYcyH+VnWfkLhE+TauC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8242d7ad-73e9-453c-4f6b-08dd35b244a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 22:16:33.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n97N4pkBw5quvIoGR+EUsd4CHcpNGFF3Ss1HgbFK7hlJFEx3e4Kzx0IIiFOzSn4y60brkb5KiOh9FDbbA7HRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507

we observed in our regression tests the following issue:

BUG: KASAN: slab-use-after-free in notifier_call_chain+0x22c/0x280
kasan_report+0xbd/0xf0
RIP: 0033:0x7f70839018b7
kasan_save_stack+0x1c/0x40
kasan_save_track+0x10/0x30
__kasan_kmalloc+0x83/0x90
kasan_save_stack+0x1c/0x40
kasan_save_track+0x10/0x30
kasan_save_free_info+0x37/0x50
__kasan_slab_free+0x33/0x40
page dumped because: kasan: bad access detected
BUG: KASAN: slab-use-after-free in notifier_call_chain+0x222/0x280
kasan_report+0xbd/0xf0
RIP: 0033:0x7f70839018b7
kasan_save_stack+0x1c/0x40
kasan_save_track+0x10/0x30
__kasan_kmalloc+0x83/0x90
kasan_save_stack+0x1c/0x40
kasan_save_track+0x10/0x30
kasan_save_free_info+0x37/0x50
__kasan_slab_free+0x33/0x40
page dumped because: kasan: bad access detected

and there are many more of that kind.

it happens after applying commit 7fb1073300a2 ("net: Hold 
rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net()")

test scenario includes configuration and traffic over two namespaces 
associated with two different VFs.


On 04/01/2025 8:37, Kuniyuki Iwashima wrote:
> (un)?register_netdevice_notifier_dev_net() hold RTNL before triggering
> the notifier for all netdev in the netns.
> 
> Let's convert the RTNL to rtnl_net_lock().
> 
> Note that move_netdevice_notifiers_dev_net() is assumed to be (but not
> yet) protected by per-netns RTNL of both src and dst netns; we need to
> convert wireless and hyperv drivers that call dev_change_net_namespace().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/core/dev.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f6c6559e2548..a0dd34463901 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
>   					struct notifier_block *nb,
>   					struct netdev_net_notifier *nn)
>   {
> +	struct net *net = dev_net(dev);

it seems to happen since the net pointer is acquired here without a lock.
Note that KASAN issue is not triggered when executing with rtnl_lock() 
taken before this line. and our kernel .config expands 
rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not set).

>   	int err;
>   
> -	rtnl_lock();
> -	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
> +	rtnl_net_lock(net);
> +	err = __register_netdevice_notifier_net(net, nb, false);
>   	if (!err) {
>   		nn->nb = nb;
>   		list_add(&nn->list, &dev->net_notifier_list);
>   	}
> -	rtnl_unlock();
> +	rtnl_net_unlock(net);
> +
>   	return err;
>   }
>   EXPORT_SYMBOL(register_netdevice_notifier_dev_net);
> @@ -1960,12 +1962,14 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
>   					  struct notifier_block *nb,
>   					  struct netdev_net_notifier *nn)
>   {
> +	struct net *net = dev_net(dev);
>   	int err;
>   
> -	rtnl_lock();
> +	rtnl_net_lock(net);
>   	list_del(&nn->list);
> -	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
> -	rtnl_unlock();
> +	err = __unregister_netdevice_notifier_net(net, nb);
> +	rtnl_net_unlock(net);
> +
>   	return err;
>   }
>   EXPORT_SYMBOL(unregister_netdevice_notifier_dev_net);


