Return-Path: <netdev+bounces-239814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC02C6C9D0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2425386299
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE22E92A3;
	Wed, 19 Nov 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJrmKzdu"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61A28C2DD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522848; cv=fail; b=ABzwyq5mMug1CS6bxHzl8HVXwhL0k4oZbsNrrS5nE3VlYA6k/N/cwizfDzI0auPYKupzgHdowuAFBiDmv4129H6rTwX9u2/QgtXTYddyp3HGHIZdTFJU73a2ZABwDfPB9QN8h9+OZmry59gijBM87BJ+vRS0dtGySyw2ei3VhhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522848; c=relaxed/simple;
	bh=Tg9iInHMEzjg7UTualXeEDU7dD8TymUQBLqh0Nl4PRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jO3K762KPXx65C8Qs8cwXPwMLb5fIRX2YDbgDGnUnNP2gHg0gJDRxPCTuaicNbqLHU7nz90igI+vgZFvM3u7+sJel01WB8W5BaN7sjKx/PUbcArTgPxDOVhu1bz9lQddDLXgjnzo7CCOG1jN9rq4Qm9Z212GJCkGGc/J3rvXWk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJrmKzdu; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPfkOPgz51oItEDBAnbTwyG6uMPXAZvVcqR3dO6pWEL/pniAVyTBpcVFqY4WipqQaVoiZm1zzG8e/gSSnCpSMAo0U4BcfU0E6fARkAilAY6F22hdXaKJLQu8/i3gP8wKkYi/o7hgyefyJxmnWhRXq2SQ6pNlGhS6FMm2YMlmzdzcAmng1sY6gVPe1bnpmnkmUTeSQp9aXTuAN5zz3f2y7Cta35enYAza0yg9PTZhXRhLw8I63KwBOZ8aU2wp2I7EYcBZvF5WmEymP1f3jwtJv5VNHVJfGwK7PrjsNGQD6m/cSlvsS2wlCW9sCVfYzY/jIXpCCp9n/N7yDKmS+amT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PklMLtSucO9VmgUqf2c0Z+YnKiRqCl/I+mZbu4P5+Gw=;
 b=D7hFVWEH3c90/c6fwYOKMS4rwPLSL6il5htw4dE8q/qa2Og+C4uISWGLIPiUdjlx1T+e33fJGangsK9a0I3FYrVH0+SkoLzc38KlYCefs5TlBku9Ln3BADXeR1I90+rRD18HJCM6g9z64hS8wg/vB/IcpjicZ9mRMXwhBO5yaNa1oBQ4BQiJwLPkrCOKxGisbBuZNqbf6s1GijlvFBON0VoWc1Eow1k/7atw8qJoU8t674euFfHueb/8XcWIlGOAn85Ct3q3HtZh41zFTS1phYvC9SMu6ddf8fm002hKA8pcfx0k4kvfzbR+cn/v9W9gaD7rI2F2AsQN6dBk5WllNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PklMLtSucO9VmgUqf2c0Z+YnKiRqCl/I+mZbu4P5+Gw=;
 b=KJrmKzdu8PzYjq1lxxh6whmwLJyyoyVYu3mRw208Rl/ENn4w+cLSRB3pjB4E3LUxTjbiT9dHbYY9ldRMtEF8tRVwgz3Z6IFbeHTC4A+KBNYEXz4RGjd6Z66pXbNY47YZfMGzfaQRjnxrJCj1d54jSMnnMNloCsfiqiQJ3/Ys7tAV2r02IaVq/fHj+TpjphilM/ao7JgkWaCSm+2pSZDkQDEvtD6aCJCd14K/mbpvHz2y4z1S9jUqwpejOx+vmkopEwnHN0PWRyDuvO1huYmY4yjIm3cs2vzQM8n8vQmozvh4imvOSR9C6pR/aYbufGacV8itk+a3wFoZWu9amAIkXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 03:27:24 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:27:24 +0000
Message-ID: <b4692b58-3bb3-42fb-8436-84b38c6b04a8@nvidia.com>
Date: Tue, 18 Nov 2025 21:27:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/12] virtio: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-4-danielj@nvidia.com>
 <20251118163249-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118163249-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:5:337::26) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 5700a365-0aed-4ef2-cc81-08de271b8ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUk0bE10U3hDMVVYU1N2cjVyL2lSWjkwM1BxQ1F0Vkx4WUVRckJscTFzc0ha?=
 =?utf-8?B?VlNHc2FOV010N3ZnbllDejZ2L09WQ1ptTU1UalNOcHVtMTh2Q29tZzhCeXR4?=
 =?utf-8?B?SjI5N2VLVGxhMnZEZDArQi9ha1ZRSFFyZ1ZpRVZ5MEhDZHd1aTVCUkFxek84?=
 =?utf-8?B?dFRpRnJQQnhHMERjWndraFpGQzVmTXVobkRPbmpySWhHbGY3czhsK21JNmRv?=
 =?utf-8?B?d2k4NVV4WWNiZklId2gxd1ZscjlKZEQ1a3h6aXZ3OFVETXJSZFVnaXFoS0g2?=
 =?utf-8?B?ZnZiWC8yV3hndzlxZ2NLQ0p5c1RKb0s1V2UvbndVeWJ2b2lISVczV3JSTlk1?=
 =?utf-8?B?bzc2eEdnbVZsVENvZElOWUJDSVkrcWdSbWN0WDdkRmF2eGpvYWwyZlppVU5y?=
 =?utf-8?B?bTNwQmMwYWlYNUxOQTBoTjY0V1pkWUtnTEN6ZHl0QlFVcUN2NWtIbDBnd0Fr?=
 =?utf-8?B?OHV0RUJuTFZ1YktxeXZYbUZzaW5Ba0VwSFV0MjVXZjFQUGlTWmdMTzM5dXZR?=
 =?utf-8?B?WW5aUkU3TjRLYUwwM21hWkFHS0VXNHpHTjZRMzRGczY5L3dOR0R5TW5Dejl6?=
 =?utf-8?B?a2FraXBNaG9BaDFiT3FFSGl3L1haK3VQc29PUTJVc0ppT2VNUERmSUZIZ3Rt?=
 =?utf-8?B?cndtTkJHUDNKWitxVFVseU5YYXdCblg5cVpOQ3dZaU9kdUoyNnlRaDNHWG8z?=
 =?utf-8?B?Zi9yTzJiQjhDSWhFUjdUSVpvajBaMEVESGtOdmc0cHgvMmd2V3VTSEY4SVk0?=
 =?utf-8?B?ZmNlenluTmRWaFJuVWxwRHkrZEx6NnFCQ3NuS25maWFWLzdwNXZqT094V3lS?=
 =?utf-8?B?VUJyekVyZ3Y3YUlBckZYeENyZUQvYWtDSncvYXp3eUFBL0FvUnp0SVNaMm4y?=
 =?utf-8?B?K3ZQVmwrTlFMSDdHNUhJdUUwZlk0T2NHWi9lNlV3WWFIM0R4V2M0cE5ZR0ha?=
 =?utf-8?B?OTdDQ1h0bXEyOER3eGVQYkE4TnhBa3pseXkzMlMyaTVuOTZHbDRSTnNhNFpZ?=
 =?utf-8?B?WmM5MlNJdWlWZDB3bjNPc2NUM2NEYlc2T2N2OHNQaG5UVFRpbVdhQXREVnYx?=
 =?utf-8?B?MXN5OWRLNlVIZlJueDBGaU90S2I4MEthL0M4V2JIaEhFS3A3YVl0eUJhQ3Mz?=
 =?utf-8?B?QjZhQ2UzYmFRc3l1ZWJtbVpLdEZheW5NNUtCZlJpZFR1bkNvRWpaVzVCajFu?=
 =?utf-8?B?VjcyZHJXOUxzbVBZbStqM0IvUk5DOUw5cHpLcnNId0xQc2FTMkllb3JyLzAz?=
 =?utf-8?B?WmtUdDZxVVdEQnNaY3BGM0tUc25kZGdCY0NXUEtCY3ZtY3NWYmt6eDBYaUlL?=
 =?utf-8?B?a28wTEJwank4MVFSMWVDZm42ZGM4TENPdmx1UnFkVXFNeDBLVGJsYXZEZk5I?=
 =?utf-8?B?VVZ0ekY2VDdDUkNucWxmQlB6TERqQmlxbC9mWmlvNGl4dzlieVdTUkdDdkhW?=
 =?utf-8?B?TWhyMmdqMHNsZWRjNE9vV2RQU3FGMEJMRzhpZkpXZmlXY1M3UEhVYTJZa1ds?=
 =?utf-8?B?Rk53NjZNZ2hkTXRQM2t0eTZUbURTWTFYUzhhWDcrQjBPd0YrdncrbkRXTU1Y?=
 =?utf-8?B?Z040cHBqdmh6VU5SdHlHZTdNWkloaWtRblBnTHBiTjZ1dlpwZkhoMzJxVWdn?=
 =?utf-8?B?SHpJMXI4cXdzTjRUeWxxYlhKSnpyWDBCa1VLL0FibGJadHFuSG5rZC9uZUZs?=
 =?utf-8?B?MU5SUTFTbG9vdXRyWkpUMXJpbmYyVWpkQVF6Njh3aU53TXBtbDZtc0IrM25W?=
 =?utf-8?B?Sml2eElzS2s2M2VFcFBTMmlQNE1pOTV5dStWWmRNVENwUEZoQ3pyVnFwVnB5?=
 =?utf-8?B?KzNZdFN0YkxTa3o0d3oyNGJaSFR5OWY1RWZDNDRoVmJoeFJPQkVEYXdBUU9K?=
 =?utf-8?B?encwcE5YNEQ2Z2pMbzZJMDVwdCtCemxtVDNrL0ZQZGVlMGJIOUJJN29EZms0?=
 =?utf-8?Q?Y1sDMy4a2/asCFWPGY5qhedO1ard+NRB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUoyRi92WFA5WERMUUJqU1A4cS8xRTR0ek9GQmlhanJIK3JwbjQray9KTytt?=
 =?utf-8?B?VmhBSGFyZnNQZG1Ybi9yRDZJVVI5MGs5Uk0vNkRMbUdHSzQvTmRKOFBlZVF5?=
 =?utf-8?B?R2tmM3A0UXhoczRkSFZpdCtIRVR5bDRLRW5DWGVOeTRqd2NQc2E0NlVLTkd1?=
 =?utf-8?B?dlJBQjFoRUg1eExaNmh5dWJNcHdvSXMwR0VTV3JOUHBPcFE3OXZJQkM3eFN0?=
 =?utf-8?B?M2ZGWDZRelllaEVZWnhDTjIyMU10RjQyWmNYalc0NzlVK1kxL1lEb1ZRc2J1?=
 =?utf-8?B?R3FsZFA1SW9UNjVmR3ExRGsyQjc5SXFSTDR2SGdOazZvdDFiTW9pYytHbU51?=
 =?utf-8?B?V2JkT3lZNGhBbHZCSHppb0FsaWJhNWZ6TTFpbVZkTjRtVjd6Ym9LdDdhbktx?=
 =?utf-8?B?d201a2RVLy9HMmtrZXlqVWI1b1ZxU0RzOW9VS0xBK3pUSjJ6TnNjUDUrOU80?=
 =?utf-8?B?ZVJJSjNjc25xcDhWRmQrNmJIcFNmRDhJVzZJR1dYZWhPeTkxZzRiMU1OZXVx?=
 =?utf-8?B?aGptVW1TS1BFTUhoOC8xSGc1N3pJWFUvaGhOVU9pT0lmTWVPc1VUVXVXdGl6?=
 =?utf-8?B?MFMydVhNdEtvQVk2bmV0UC9jRGpJck14OEdYazNPbkJUS3krVmJzeklwQW0z?=
 =?utf-8?B?c20xZFBLcFZIeGltVU9wZGErNnR1a2pRS3dsMytqVkVCMHJrYlVQUmJmS25Q?=
 =?utf-8?B?bEVEamVPa2Y0UU1WTDlhaUpHNUxwUTJQS2ZZR1lDbkxPTEg2L3JyaGw5blAv?=
 =?utf-8?B?enplZjlaZFNEY0grdFY0ZWVnQkVUU0FUNmhsektqMlVBaWl0UE1SZGhnYXFC?=
 =?utf-8?B?WHpubGVHRXF6d0tlc2xZdFF4UFBNK1BEV3ozVDZtWVBxazkvdzNLRUltVzhS?=
 =?utf-8?B?bkJ0NERYYUoxUGtsSmNKbHhYa1lBMkdrRnpyTUMzNlVmNFNMTXJBc2hHTGFY?=
 =?utf-8?B?YkhiKzVBNlBLMlY0Y1dkWi91TFFsWk4xUlRvZXg5UERkY1BpYXpaN2JWQVpi?=
 =?utf-8?B?Q1h6TXpXVTRhclNqK1VEcjQxd2I3S0lRS3RnZWxQQWZxaGpyQVRHVS9QQXFN?=
 =?utf-8?B?dG9XVFFkc2s3RUNVbDMycE05bVNMa054cU5KZVZYSWllbCtFUTJ5bVROeXJv?=
 =?utf-8?B?NmpJZGxQcTViYkkzUGVGMmhiL1FrQXRiMllaWmI5SGdsdHBuSUtCVzFPeTRR?=
 =?utf-8?B?SnZlWXUzZHJZYUJsNzdMdGRod055SFNMYjVHRzEzaHRxTDV6OWtMd2dZV3Zq?=
 =?utf-8?B?aHJ1MkovbjJ4RzlCYzBzR2N4VzUvUnAyRVIwVkFYdHFTcFNlVVhvSC9jTUpH?=
 =?utf-8?B?cUpqc1RaRUlSbWpTR3RyYUI2aWVPTmI1UXJjajVoamdaZm51NjZxMVI1N0sv?=
 =?utf-8?B?V0ZuZlk3ZDJuYTNnbWpjdmUva0tZZmdqMmpCc2MyK2dqL2tzMzRpckFVUXl5?=
 =?utf-8?B?MmxYeHdtTXdSK1RCaktlaGZHSWVLYTJ0ZGFlRlJXVlVwSTRSY1dYbFJqSHZh?=
 =?utf-8?B?UmJNQmxRSkpSVEpEd1pZQnFuNjIxYXZVMlc0OE5qMTV5SnU3Nit5MnV6VE51?=
 =?utf-8?B?Y2tBWXJzMVQ5Z0pkM2FneHZ1dXRTUHpVTFlMdHhFdnQwbnRyZ2V1TlBHempO?=
 =?utf-8?B?WUovZTRSQ0tTdHV2RUFLRFBaR3RnbEoyYXVrRWdUR003SVNmd096NGs0eUJr?=
 =?utf-8?B?WVB4bVRvU2NJcGpkdFplSVlULzcwelZlRHY0V2hadkVWM2Nydk5jRnhtbU1M?=
 =?utf-8?B?aDhBbXVZUUk5bWpVVnorVGNldEFRcXdPdm5OM3NObzFIVkxrWXp6VFNnWE55?=
 =?utf-8?B?TGg4VHJDOGhYMGFTamF6RlBIc0hSU1NBcm0vMG1xdDN5S2t3SkxuejZNSUQv?=
 =?utf-8?B?ek00ZW5YNngweS9BRWxUR1o5MVE0WUZXZUpUdWpRSXJ5UWJVTDdYYkhnWVdX?=
 =?utf-8?B?TUJ6UmZqb1kwNU5qYkhHbzhjaGk4SElaWXR3bmxYQ0lnZkxkdjNGNHFiM1Jm?=
 =?utf-8?B?bklHZjA2SitGN1NUZHlKYUdpRytyU1hSV2VrNmFOcWJHS0tIdU4zNGszZE9u?=
 =?utf-8?B?dUpYa3JPTHFFUlFmQk9JbkZjbU9FUUlOaG5UU0huS3l6Z2JrWGthOEkxaVVZ?=
 =?utf-8?Q?L/y1Xc+80VSwPrIOt7yDAWuc7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5700a365-0aed-4ef2-cc81-08de271b8ecc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 03:27:24.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gCh9OUePTTRSNHZGd6T2RQFBqNxGXexXSvLSM4x8p9VW1C15ZvmWfbXgM0LyYIBTgWgN1qXhr4QAiFo3gvVlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

On 11/18/25 3:42 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:53AM -0600, Daniel Jurgens wrote:

>> +#ifndef _LINUX_VIRTIO_ADMIN_H
>> +#define _LINUX_VIRTIO_ADMIN_H
> 
> 
> Guards normally come before #include - there is no
> point in pulling in uapi/linux/virtio_pci.h - just
> extra work for the compiler.
> 
> 

Removed the include.

> 
>> +
>> +struct virtio_device;

>> + */
>> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
>> +	(!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
> 
> while this works if cap is a variable, it will behave
> unexpectedly if cap or even cap_list is an expression.
> 
> A standard practice is to put all macro arguments in brackets:
> !!(1 & (le64_to_cpu((cap_list)->supported_caps[(cap) / 64]) >> (cap) % 64)))
> 
> 

done

> 
> 
> 
>> +

>>  #define VIRTIO_DEV_PARTS_CAP 0x0000
>>  
>> +/* Update this value to largest implemented cap number. */
> 
> implemented by what?

Removed the comment.

> 
>> +#define VIRTIO_ADMIN_MAX_CAP 0x0fff
>> +

>> -#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
>> +#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP, 64)
> 
> Don't you mean VIRTIO_ADMIN_MAX_CAP + 1 here?
> E.g. if VIRTIO_ADMIN_MAX_CAP was 0 we would need space for 1 capability,
> right?
> 

Added the +1, it's the same result either way here.

>>  
>>  struct virtio_admin_cmd_query_cap_id_result {
>> -	__le64 supported_caps[MAX_CAP_ID];
>> +	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
>>  };
>>  
> 
> I feel it's worth explaining in commit log you are changing a
> uapi structure, and explaining that it is safe.
> 

Done

> 
>>  struct virtio_admin_cmd_cap_get_data {
>> -- 
>> 2.50.1
> 


