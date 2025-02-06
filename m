Return-Path: <netdev+bounces-163622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BAA2AF95
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B32A188D7FC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0819D8A2;
	Thu,  6 Feb 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/2aZ6fB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691B19D892;
	Thu,  6 Feb 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864695; cv=fail; b=m6dWFSSkdWK/PEXey/MVWfLDbJ3gC8CrVVju3VwIKkEyFNCPfw182AfXtGt3MF1Jzrf4eVI7mWx6KYxudP1OHRj/NG2xPCGjl+UN9J4q2Ls9d1XMKANHe9wHQhAzy63JIuaJrgNhzSKIWRlN/xAjHYLI5Og16qhU5vv9ZpN1Aw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864695; c=relaxed/simple;
	bh=XhpBaDbFrZ01qYRQRsegFCEzlC5bOnDY5JxfCpabwGY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rB2RP1PoGAABsW+E06XyeoJ22isitLKU4W8G8+2Q78HMKxyihlWEbZepRA94i9kT6Vh9FEFFdz13I5xtpj7PpjXJwcbRgby8zJ+1AbJejmk3w3ExM/LD5jwnbN7CtVbDpj7DOSv6r3rhRlPfxNkaa/VlWEoLaPFOLWhUmYqkMXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/2aZ6fB; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaQ+v2dVDmXWupOxTO4zD2tftuuTJrNuLJlFcXDshHcceCEZ1Czf05oKf7Eib3qQVjc9/55gssgkArClSLxlTP702S4G/99/QGS58/mrC6/Xq/ZVss8GsTt4DFj11QVLi8TaatlPvWOL9aISKGmiok/DQBG6Yy+ZlpV90O2aDnANRclXgzBpHeLT77rENFj2iqj2FVI8qAbh7ZIfuAQYyJQGxk+0kfftilTPz9RrvX9vZwY/ssRIoOvUHBMEqllNg4Vdn+f8ZfyjwfAWpvges4asf4maDcJ5YumN8Qg49Mim8uuwhCUDxBXYRRUZzzLx5DueRYzyso+r7jujdMy4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNFk9+1ZdttwlZQ8GTDzcYPHuew93c8U6vujRSMfZJ0=;
 b=a+df5HslEhF7PpnoV5KlQU1TIXHbomtDi1/oehTe2iJxfow9u0vOGirOzwfsMtNAGkedMqLYHo7K8Np/AkxTu2B1UyZ9PyY8he5a4Wgdbx5PvsKrWgcjGEiianzXcKq7jCCiAgFQVL2UppxPedYyQ9qAh4bH6CS+Gg7Qak2vnz7uv7phcnUxzbq9Z9gNTG80hyXY4T+Z4ei5p/Rg/5N6HgbZi8rN/P5J/FD7R4mbTXLGbYzvWp5Dzqc2hHxjXrA9Wo+ilkoDlB6C9HtQf9G/iyAT4xqoNkTv5gHWNcj9Dp6LSZCq1iI3ZxxuX2JSH0kSxl/PxUFGMc3nKtome89XiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNFk9+1ZdttwlZQ8GTDzcYPHuew93c8U6vujRSMfZJ0=;
 b=o/2aZ6fByecBvN/ALs5wTR1Xz/hJrIniA1A2yMnI4l90tuf8I+nDzBdLdv/IpybJoQ29Bs8X10U1qFOKpv87lgzv0OifurohBfrAsmpg7DS/d3t98FS7y0jQp5qFsMgqGqh86Sa7gqytdz7qm/dYh6Cc3yBQNkBiH9ozgPEQ7r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 17:58:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 17:58:11 +0000
Message-ID: <6c280b81-3d6e-484d-92e2-9758a4fcb747@amd.com>
Date: Thu, 6 Feb 2025 17:58:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/26] cxl: add support for setting media ready by an
 accel driver
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-8-alucerop@amd.com>
 <67a3db2f253ed_2ee27529470@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3db2f253ed_2ee27529470@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c89e29-c82d-40c4-ef3a-08dd46d7d23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkd6Uk1CWG1LT0ZpMWY5cW5JejdIZDJ0N3JLQ1E0QkRsemxiNUlFQVJ1YkZX?=
 =?utf-8?B?VWI1cXZMTWpBV01saWRyK29xeUhTTFlZblI4OG52bFRpMjd0QXgrMExhK1d4?=
 =?utf-8?B?K1FpWENHODNtSFdqNHBQNXFVbDNSK1RHdEVwWEtPMGNtcHlkaGQ1S3dGcGF1?=
 =?utf-8?B?R1M0R0hWeTg0ZCt5QldpUm82cUZJSVFJa25WNlM4aEVDbHQrUUFqK1dNcE9O?=
 =?utf-8?B?S1c3MkVZd0VkQTZkOG5ycGc5ZmZadWZVdDFyR1ZKRHNDQU41VUFvMVNCSjgy?=
 =?utf-8?B?RWc5dHdFNkFOb0ZtWjBQRFhPSWpvakJpYU9xK2VOVXcyNWNTaEJJOVEwZHZL?=
 =?utf-8?B?bjhxeXdZQ2FtRVM1M1BtYTJ6QU5OaEpNd25HQkJ1MmJQbnBEUlM1RU1MSWdl?=
 =?utf-8?B?Umdnbzl3UmVHTnAvVktyYS9CWnlGakdCcGhhbTZseGsyU040RGNvL2pyc05V?=
 =?utf-8?B?dUQyZW1xdEhaNWcrYjJIN05kL0R1LzhodWVUbHpUNXVRSXFpY2dXV2dRcEY4?=
 =?utf-8?B?SW1CSXBLQ0xkcWY5eTBGMThJZFBsemhjWjh2Z0o4bVFZTDJDb0V0d0l4d2lr?=
 =?utf-8?B?TGJ3RXo1Z3FJQXdFNUxtdll5azZoQ1FCZWtITk1RVlQrWGtPNmpDYUkwdGZF?=
 =?utf-8?B?WHpsUnJYMmZTUzBORG93bktTQVNGY0dHMHdhSkhFaU1jRlgwVTJheXZPZjN3?=
 =?utf-8?B?SERmOEljbWtyaW1HSWlya0tWRTh3R0RtMUlXQ2J0V09KTmFUbjhRRFpONFlu?=
 =?utf-8?B?OFR0U0R3VjZyQmd1UjAyczVWOXZYMWpvdVhOZHJZRFRFczdlUkxWSU5UUm5K?=
 =?utf-8?B?UlpDek1VL3NzcTZkUldaV3Y4K25LVnZCbmlCQmZUZGhrYU10eFFHWU16QW81?=
 =?utf-8?B?cHBxNHB5YkExdDE0UnZUYndLN2FQOERaczZvWkhMaXBhZ05CbElUUWxVRkNP?=
 =?utf-8?B?MXFENWlKcEF4VVdmcmVvbHhUM29zanM5YjVqdWlMM2F4Mmc5Tkp1cStDeTZz?=
 =?utf-8?B?TnljV2hUTTRjbFl5endUUUlOYXRGcnZmTitOeVRVZGRSV1ZoWmZmVzFITXlt?=
 =?utf-8?B?dklIbndseS9mSGpkckliTXlSZkNMMllGU2RzYTRyeWVwUUk2bHhDWGQvSysv?=
 =?utf-8?B?RXRTRGRyRDMzbkFrcTNFTW9wM1NwZUlkR1VRdVRQZDdXcWd5K0gwbjJwWUR3?=
 =?utf-8?B?NGhXMWtLaDF2OEZQb3p6VlI1RnI3dk9obDM1dU9ZeEo5YXlBMGovZFdkL1ZD?=
 =?utf-8?B?RncxU1hXdFhrQU5PTkZGVGdYYlY4S0hIRFV6QTlNanNaSXczWFRFQ3ZBcm9n?=
 =?utf-8?B?cVMwUnJmR0dLZkNha2tqRTZIZG55d1pxY3dUQzIvV3VsZ3dmZUlrSUJXRW5B?=
 =?utf-8?B?NW11MkFHT0tGNjcyVXFHMFMwQUZTT1NYVG16UnF6NUMxMy9FQ0JmdE9WY0xh?=
 =?utf-8?B?TURaVGNMSHlzTjIrNkU2UGR2TlhuaDZNNzBGRWRDYjg4UXl0Yy84aVBIN1pM?=
 =?utf-8?B?VDFkNzBPQ09PbVpnSnRiczJmcnJiU1lOY1J3cGRmQVRnd0RTWlNnMFVwYXBq?=
 =?utf-8?B?QnBLWVB4Q28raVc0TzEvbzBSc1NUYUlpZnk5Y09aa1hxZkZWOEpFSWFwR0l2?=
 =?utf-8?B?N20xeG5YczMzWWw4Z28rMDJFemYvMDJYQ2JwRnhzTjNVNUU3dnFlcVFFZ2FK?=
 =?utf-8?B?SjRwNDBZNEF4dlJ3MEdJSUswYVlEV1JYb1hoU0JMc3p1V1BzM0hPblZnZzNO?=
 =?utf-8?B?ek5pTjFCdE45RUs4RFJjZ1JKMEdOQjdZMzJnSGdHaEtaaFVMOGM4N3pBYWdy?=
 =?utf-8?B?Zm9xK2VBdUM5TjRDak5ham1xOTZUaEpNb3kwM0hodXVGN0JQSW1wRThXV2ND?=
 =?utf-8?B?Y2hOc1NKZmpsNnZhYlpLN21oVVBMVmlqRmJ3akRQVFlJRWM4aU9GeUJzbVEr?=
 =?utf-8?Q?HIBsPg+sEk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWNNQStVeHgxQ0JvZlpRcVM5M1ArbW9PbWJMN3hTNGgvUHRwbmxrOWtFOXpr?=
 =?utf-8?B?MWYyczBTNXZXd1RKYWx3bjJBUVlIUkNNQmhqdmdSb0NtbTNrdUg0aXp0clZu?=
 =?utf-8?B?SWZ1UGd1Q05VYnB0dFdSQjRCbU9iUlY4QWR4ZTFmbkpPMHlpVWNnTEVTY2l6?=
 =?utf-8?B?YXVUS3J0MVhqbERpbkpkOGRwdkdlRnVXTHU3Qk5zU0lMdDlkOFlsMVlrYnMy?=
 =?utf-8?B?QzhNQnRLTU5MbnUxZmxmMGNaUTlyVHJZWGhieHRvMHNXR3djcEZBV2pabGpP?=
 =?utf-8?B?S3FjNTQxdG01c3FpZGlBeVF4N0hxamphMHlzdFdzUUN0dFBsMzJtRkh4MXht?=
 =?utf-8?B?OHVIOGJ5cDJ3QXY2K0xGbmpSejVzNzlqK2dUbkxtQ2Ztd3NBU2V0UzN3K21N?=
 =?utf-8?B?LzBrQXMzMFhCRTFpMGJhQ3VqYTRzRUxrYkhocG85aC9hY3BCbHIveTFTNm56?=
 =?utf-8?B?ZUJvVVdmK3hRbys2eW1QUk1YdHhjbk1sTndIQll4SUJQZ1lTV2RBZGozSWlt?=
 =?utf-8?B?VUZyRnlVOWVaUWV6enVsc292NnBRVm1OLzVNV3FESm1PQ3Q0V3o0ekVESjYv?=
 =?utf-8?B?WGxVUStqb0x6OGF1TW9RNkZXQmF6VzFLaEI0eloyTmlodWhmVFo0blFhRnhW?=
 =?utf-8?B?VlhDWjhHYmxXelc0MWk0YTJQdEhrTzVXemx2ZGhQa1EySE1TeUJUVVFFZUpa?=
 =?utf-8?B?RnY4QXdmOTd1T3o2Q0pZak5JYlZYSFVudUFUZWZvU1NESjRIYklFQ1lzY2Rw?=
 =?utf-8?B?c2ZDd3ZUcTMvU3N1a3huR0cxbzc2RnJYcE5Zbk5seTE2R3NLbEc4bENQdnps?=
 =?utf-8?B?NzNqbGhSa000czhYWlQ3QVVDL0N2RnBEWUs5NUJqUDNUZHRNeEhhRmFwOEJx?=
 =?utf-8?B?TC9yczE0SnpZVUk3YWdmUStTa1lLUzZmTTBaVUhqYklxT0xPdEtORVBZRDhE?=
 =?utf-8?B?eTV0VFYyU3RiTG5xZUJBcSsxaXR3OVVvL2RxNEJJbUFldmEzN1V1b2EzTTF0?=
 =?utf-8?B?cFZ5STFRMlRYYzRyWkJiUXJyOWl3ZnNUdnhHQUdNVEdKSGlTUE5IYjFPSWE5?=
 =?utf-8?B?bVd1dFZNMk9ZYmhkQ3V2LzNuYU9Bb2w1ZFoya09tYnl5UUhYM3JXZ0IvSVk2?=
 =?utf-8?B?Sjd0dW03VS9XL1FCL2FST3RTV2VUYjFGWjY0eEwzL1o2UDRiV2pnQXphT1ow?=
 =?utf-8?B?clJyQkE3MjdBREExUXpQSUtBdDhSb2dhLzg5UGJJSkJZSnBmN2QrLzF0VU5p?=
 =?utf-8?B?UzF1amxDeHl2UGtBUXhxZHZaMTdBbjBaYk9VbVdpanRMOVFYZzd1ZkNtM042?=
 =?utf-8?B?SzFDYWtaZnI5d1ZBdktHZHh4TG9zNC9vL3VVeVFsaVVBUXhZUUxVMXZJNFMw?=
 =?utf-8?B?dU5URTFQc3Fja3EvMSt2SXlabHlQSU85aWx0RWpxZEREUXZPL05YS3RXSThM?=
 =?utf-8?B?SHQ3UUlSSlJrMjZDUVQ5M3ZYZzRUbXNDQzYveUVKNk8wenZpOVRsQ3czQmg2?=
 =?utf-8?B?YW1KQVQvZWJyb1cweDVIejYrOFBYekh5cHJjbHV5UUZKd1laQ3BOcE9vVzBV?=
 =?utf-8?B?aDlzMGYzMVB2WVpZcVIzcTBxR1FwRngrREU1NXIvVFNjamJXWEg2OEs4SGgr?=
 =?utf-8?B?eGxSNVgrQTVYdVZodkErT1J3cWNudFNzQlJsZ1FYN01ITTFYS3ZlT1N0c1py?=
 =?utf-8?B?d0ZUU3ZUWlVzYm1mcFc1L21iMU9yMjI1eVB1NTFPTmVrOHMyYXlKc3NZVkxv?=
 =?utf-8?B?OWtSOUp6YjNzY3pSbDUwWUdwUXZOMUFwdEFMMWN0cU52VjdDQkVrT20xTVow?=
 =?utf-8?B?VkR4azc1eitBNnA0bnFmMFMyRTQ4M1VTb204YTZMYVRTbFFnZkc5aHljeno3?=
 =?utf-8?B?a2wwclM5cjZqRjdEdFJlZ2JSakRtSG9ONmp2b2FHc2FFclY5enBRZXdqOW1l?=
 =?utf-8?B?OEd5b2NoZXBNQzVxZ1V3KytwbXd6dEgyMThqL0FkVXN0Ty9NUXozK0FZeDdE?=
 =?utf-8?B?RFRpWFBXNkhjT0FmY0xtK2JpNTZyTWdCQ1dhb2N0aUhFZ2hBY1dkV1FwK2Np?=
 =?utf-8?B?UHlubnQ1ay95ZkhSSXh2WDdHdFJtU1RwNERtNytRMkxzdXdSbERGbXE5clhj?=
 =?utf-8?Q?L5e+DOwnETchp+FFhw0rdM87n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c89e29-c82d-40c4-ef3a-08dd46d7d23c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:58:11.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ue0VmtlQ5QEw0yoBp/MnHnKk1qr2fUMQwDBuU6+Jk4bMj33rz1p2ToKFmEa6XIqyUZsw1/63KGWCMOTKOpqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504


On 2/5/25 21:42, Ira Weiny wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
> [snip]
>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 08705c39721d..4461cababf6a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -177,8 +177,9 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>>    * Wait up to @media_ready_timeout for the device to report memory
>>    * active.
>>    */
>> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>> +int cxl_await_media_ready(struct cxl_memdev_state *cxlmds)
>>   {
>> +	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
> I feel like I have missed something where suddenly cxl_memdev_state is the
> primary carrier of the CXL state for accelerators.  Here, like in a
> previous patch, you simply turn mds into cxlds?


Yes. It is explained in the cover letter. I'm not allocating a 
cxl_dev_state anymore but a cxl_memdev_state which contains the other one.

I did use original code from Dan and I did feel the structs required a 
new refactoring with the arrival of Type2 support. But I know have a 
better understanding of the code and structs, and there is no reason for 
allocating cxl_dev_state only for a Type2, since it is a memdev as well. 
It makes things simpler and cleaner.


So the reference struct for all the accel API is now the 
cxl_memdev_state instead of cxl_dev_state. For allowing sharing of 
current code with Type2 needs, some functions are modified for receiving 
a cxl_memdev_state now, what I do not think it being problematic at all.

I know this is a main change for a v10, but the DPA changes and some 
comments from Dan pushed me for this, what I had in my mind for a while.

I hope it makes sense ...


>>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>   	int d = cxlds->cxl_dvsec;
>>   	int rc, i, hdm_count;
>> @@ -211,6 +212,14 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>>   
>> +void cxl_set_media_ready(struct cxl_memdev_state *cxlmds)
>> +{
>> +	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
> And here same thing here?
>
> Ira
>
> [snip]
>

