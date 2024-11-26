Return-Path: <netdev+bounces-147470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6109D9BA1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781A61666CA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444B1D89ED;
	Tue, 26 Nov 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gGhoME9J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB61D8A0B;
	Tue, 26 Nov 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639127; cv=fail; b=lIGKh/1DBzWkTvnWtkYKFcSqA/WI9k2rMz7NZ0iuS03jnF/8ViyQmn2YEiKbTzsspWZge3rhfC994yy3aZf8bIskRFCrauU9dBIK2Zc+ufkI3UeyUCyRWPGWfrh2lzqNPRRJwgHdpOkGJJm+o6omWGqC4vhGSyIziFEkBom6Eac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639127; c=relaxed/simple;
	bh=WaVbryhCqZ9/mHTHZUT5k8G5tBcd25IdhJxuvFNZKis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lqIw+E8r3EcL4a56Ep4PItzV/2VhsMeA4e22M1f453bTWN26y8J8s5ligSyHG/8OreLX3Z2FS+jjniNToqaqG7yz1dU3RslkPyvY4D3sk02+R9JuwYNtqDvlo5LF1q3qLBfWple0e6QZ2KJiauv3M0+0cWi4yi8IqLg8O3TdU5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gGhoME9J; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHE294loj52qEaR0lmFpNxWYBXWgK3VEvfp3peyPsKLvLMv1WbR8Pk3HvRamZOb4ZEmHP7sdVaKIRKsDJ1/wQQ+jYQhWCWi4jYaK+OxRju8WvywzhxO4+0vefo8KKWf3v9gZNdC24N12dGbk1cTVaCfLICv91qTRIU50MSPgA/u5SCDbBFF4apiozHsDkyYXSC/QN4Wcru3F9Sz4LCgAYD9BG5B+ZX5+5KxoKY982UTJiPp6ciV8JCfVPFDiJsJ+B3hdyUSCfuWPo147hkiBbpMreGIKbuOIpxGQaaUiYX6caaGqVlwY+P/k42j9bbPBUKY15leo84kVy9AqcMO2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qgsxKheYoSq7NqIxcPWmKCWV2l44bGMHtbN5cGyBw4=;
 b=E0TVFfLL594ELzVvL1GX7d2NtGCKGxUVGjMWrMWvNOVEkP5NtrZu5qlmDEl1x9joj8QcqbsmJvLFwPFWb0r5QU7sycY+2mfr2/EUZXehm+Qt0STqzxvqxZTk7t1Lt+y6Y7Cdc2tfUBLMJ9I6rfMP3V5QTzEoYYagQvBEhd77tv1br7AEgQaUX3vjx8VR+I6KrQHOne26Lc4EMp7a2c3ur2Xl0TgNnNOg7jbeGeohnm+3Vz4RC+CKtz+iTtP+SJjFt8Ohh0c4iLGvVsJtLmzsQKADIfD0R+7UsV3YW4I+hsWB+0oGqIafianXE/QWAREokgw0J/NwhA4izAahL2UDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qgsxKheYoSq7NqIxcPWmKCWV2l44bGMHtbN5cGyBw4=;
 b=gGhoME9Jx7SZqOQo6Ui0RrG2b503BPAT3K/8hALxwKWWa2VVYGueqAwXVk5EEfqyKM4maq72Ijbo5qtC5a/nRdEkUtVEPGvcMHiz0F1G8u6Dwu+5cxPOwHyvwmd/9GFRasy36C6YmHCfVlqpNjZLNxW6lbyyv8HRXOg/8e1bRRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 16:38:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 16:38:39 +0000
Message-ID: <86b493ee-021a-a1b8-2017-8718444e0a04@amd.com>
Date: Tue, 26 Nov 2024 16:38:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
 <Z0AKKKdMh9Q06X7e@aschofie-mobl2.lan>
 <6c039777-3455-eacc-8d7a-a248f7437c95@amd.com>
 <Z0Vjp3ndPODUSUYM@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z0Vjp3ndPODUSUYM@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DBBPR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: e785b534-c390-48b9-c15b-08dd0e38c803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVppaE04TkRQUzArMWQ1NGZjUFljc2JONjcvTXZNVzVuMGlVL055WnBxOEhI?=
 =?utf-8?B?UXJwKy92bk9HUHFDWEdGeld6ME12aGhxd0pvajB2V3lHS1I5cTJHd1F3cDZQ?=
 =?utf-8?B?SXEwWWZRQ0o4b2g1Qk5aWUpsaDhsOWQyTm9yWHJEQnovalB3T04yMXRpYTUv?=
 =?utf-8?B?KzZIUFE0bWtYZHF4cC91L1ZkMU9HdWFkTEZFM3k5cDhoZEh3VlBMU0tYVWgx?=
 =?utf-8?B?bklkQVJvUUJMMWkySGhQVHRNUFFjcnBBUEdyRUQxRU1meFM2Z0phdUpaamlK?=
 =?utf-8?B?TnlETFY0ZDhsaTIrK3NyeGtGcDBqQ1BVbGtKYjdwT0wwaDN3MkkwWWFzZS9x?=
 =?utf-8?B?UytEZjFjenlMNytRKzlCTXE0b3ZvVjZ0MlFLVXQ0NEhZTlNpNEg0NW5QajIy?=
 =?utf-8?B?NU9WRkNvbTA2aXZrcWNWQW5RMGNMbncrMk40NkczQVNhVjlKWjhEby93V3FU?=
 =?utf-8?B?RUhsVzY1Qm5CSmc3NmZRK0xBek5UdllyNlpFUllqZVhRRE5GY3BIalJITW1S?=
 =?utf-8?B?dTVrRld4MytDWm9GeSszRi8rNHNuQkxXelJqQzZqQVZBVitISmFDcjhvUXJk?=
 =?utf-8?B?VUtvNWVzNGhlZkk2NVAyNjIrWVlpVFh4d0dKeDlVVzhzSTI4MXhNUUJMQUpq?=
 =?utf-8?B?Y09BU1NFeFd4WThTY0NHRGlNVUIyWTloYjhLN0F5bkdIdVQ4aGIwZmE3L29i?=
 =?utf-8?B?bGt4RkFDYlZpUGVPTTRsMHNmeWdrMDdoU2U1UWNjbVgrdkk1QkJlVmpIbGdt?=
 =?utf-8?B?eGpUc2Z5RGlYSjVvbWYxTFRDdDl3d2JudmN4M1hBdFo2WTdhemh2VEFxM3ZL?=
 =?utf-8?B?RWRTMUFqVnpuNEtHV2pHS01haXpaUEsvbnhoRUpzdWF5SUlSZzlvWDhScG9F?=
 =?utf-8?B?V1Y1SmtERHR2dGpYTnc3RGNBWFlpaHZJcHBHK0xGVHl5WnRVYnIvYnROa3Y0?=
 =?utf-8?B?OHg4aVpyNDNiVkliNkxSQ1l4eUV1VGpITDJweWRudlFBd0dxUnp5clRxdmFr?=
 =?utf-8?B?LzJBQlFaczZFdzNCMnhuMVZzdmZmdVRDRlBZcmFmdGptZFVIWEl6NURGeHhY?=
 =?utf-8?B?aHducWRzeHFhZ29MWXJMZ1VSUmpveE5lSkhsbTJXZEY0eW56a0Fidmh2bWFj?=
 =?utf-8?B?M1JWTzh6YW5HQmV0N0s1VDB6S0VvRmFhMzltcXIyQ21ERjRBVGpLallLSVN5?=
 =?utf-8?B?UTVPR3p5cXcxdXRzNFlKOUhRM3VkSkplWXBzWXRoa0FKY0xxMVU0aTBoRXZ2?=
 =?utf-8?B?LzBGK2dZU3NzNGlKcllVRk5NYmVuUWFrUXcvNzh0MVY3VlkyYTdhOUhPb3Iz?=
 =?utf-8?B?YzNFOC9rc08ybVpTTW0rUHd6ajA4UWJiRnZUd3UveXgwQ0JlTVhIV0FKeUlk?=
 =?utf-8?B?am15bTNjb0ZSRS9wWnU1NDFTMTNkWEZLbk42M0t4dWFURE85UnFQUUwyOEpz?=
 =?utf-8?B?M3Q1dk9NeG9sakcvQkp6bmlZWGVxNzdxZ2ZqZE9uL1lGQm45R0RaRjdyTFQ4?=
 =?utf-8?B?dGNZZFk2QUlVc1gyQVl5NWgwVEFRTHZNam5FMlcrNWZFc3dEOWNEeTlJd1dy?=
 =?utf-8?B?cGtFYnBuMGZrM1dZckZsc2hwS2FQczQvOVcrWFNwcmZlMEdjZlRDUXVaTmJ0?=
 =?utf-8?B?QTBVaTRUQlJYbFJvWUhDTS9JSGRXSVd1bkhPU2VyaURhVnNsV3lkWlVvellH?=
 =?utf-8?B?dE1yeVgwOFltcTNMb1FnMlNPczVDQm1qdTJhTXo3cVpYT0tqNUlmNE9JL3M0?=
 =?utf-8?Q?09QwaR7VaMLzpWOhe+0ydEw6pp60XLyAH9Nqq8I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?citxRWdQOWExT2ZUZTNNQ1Z3bnJGQ2U2dWduYU5QYi9DLzJxMkdIbmhjRDFO?=
 =?utf-8?B?Z2I1K2tYNjhMUXJtUGdNMmI1RHVxZy9BR0UwbzV3WGM3K3RRbTJMbG5qTTdE?=
 =?utf-8?B?UUV4dElKa2k1aHViZFlCNEVaMlM3bE1iSFVSMEZ0WENtcEQ0ZkRxT2wzU25O?=
 =?utf-8?B?YjUxNmRXdkN1TDlPYitidG1hZUxMb2tXZVBydXVNMit6YjhXVllXUXdUbllY?=
 =?utf-8?B?NXhMVDl2M1pxZ1A4OFRnd1lybTdCSkdQdzBVL05NZ3pKNWpzVFBtRXBFUTha?=
 =?utf-8?B?UjcwbFlTQ2hvNk01eTZQeGo3aUw5NGl1RkpMUWFOZlJFRHE4TTNUdlZsMnc0?=
 =?utf-8?B?MzZaVStEZzYzSTIwanNtNjFUbndMdkhIR2E5aGVrcVFzQ2hXNStSWGN4L1Rr?=
 =?utf-8?B?WTlwSEdyZnRSUWdSRFNjaHNaUFJMaG5BSXRxYlZaTU8yUDBMekxydVgrcFJ0?=
 =?utf-8?B?eWpoZ2FJOWU2emJuWWpXZC81ZmJXZGp4OHBaVVkxQnEwTlZYNWprOC90RWdH?=
 =?utf-8?B?dUtRUnlZU3hrNTZoNlNidnVqempPUnZnREVEV20vYUpXYzJVRWFvRXVRY2tK?=
 =?utf-8?B?Mkdwai9jTkhTWURoWW12aGhJVVJsakVtZnJPK0xWMXBpczI3dFk2V0kzcFlm?=
 =?utf-8?B?cS9semV3Z2hBdHh4OEtaN1BxVmtodUp3bmZMcmlUbjFITXoyUnhocjVjZ0tO?=
 =?utf-8?B?WDBqWDAwZGJzY05ZYlZMajNEenZWdG5xU3IrV3p6VUk4NEZSY0pZWXM1OXJF?=
 =?utf-8?B?bitpK0J5dXFYNWNxNDRmdWpaVk5LR3J0VzN6S09NNS91WUFXR3VzY1JiMEFR?=
 =?utf-8?B?ZlBYZmRTVGRKdmh2aFJCTVhVeDdKM2kzU0hKZHdReW1JeGFaZ09PQlFyRjJP?=
 =?utf-8?B?QWxVNllaaE1RazhoWTV1cENkSGhtOC9OTFVNeldrSmhBamw3dlEybWdXU1Jl?=
 =?utf-8?B?M1J2VXE2UldpZlQwTUtGcHdsM2tFTlJ5VXFIdE1uUHI1M2ZVZmI3OWh3L0JY?=
 =?utf-8?B?OGx1bzM5K2NZaXNEaGJwRGUxMktZUEpLVnJhcE1LRFF2b0Y0VkY5SHlOUWpm?=
 =?utf-8?B?Z0VldDhSR2FHTlFCM0g4TzU1VURpaXJONWlzMEpOL2ZRNHY1aFV6TmdwOWJq?=
 =?utf-8?B?dDdoL0ZmK2YyaVRDRDBOL1V6QzV6ZVdHTVJYdVVUUUJ3YVpSRzVYR28zS2lB?=
 =?utf-8?B?L3pWeWw1ZTJvMjBSZXJrT21ObGJneU5RaGNyVGkvMUxvbW9xMzFCbnlKdjJp?=
 =?utf-8?B?dXJORnpnc29HcUtiZnZ5MFlmd3JnUHVLZWFPSzg4ZkFCdUt0emI3L0F3Y1hI?=
 =?utf-8?B?T2Q3OGdvTEt3UFQ1bm9UZ3pNTHk0S3hhRHRLUUxmM1ZTS2g0bXBybE1RZmVj?=
 =?utf-8?B?VFc2Yy9GV2NTZ0pIaytYcUNEQW42Z1pDWU9Fb2QwTzIvTldCckJrYy9jMDEr?=
 =?utf-8?B?bjZ1TXRTZlhtcjJ3cUt5d05uS0FhWFhOZ2VuVGhBT2t1Y2lZOHcyR0FUMHZm?=
 =?utf-8?B?WE1TY2NNOHRpYVZmeXc3bEpPT0d6V3NRejZOaXp5K1Z1bFVhbGVXWk01TWkz?=
 =?utf-8?B?VHZtc2FzdVNJZVd4TzB4eEJrZU9pTkM3c1p4c0RhWkczTGlqcW0waXZsc2Uw?=
 =?utf-8?B?WlozcWFwUXVXNWQvaGRhZ0Nya2lGczRGQmZ6NHlDckRyOTczU3BBZTdNUXJL?=
 =?utf-8?B?V2EvbXdRRUZydHZDYmxqVERxRVRuNncwWHlCbWtxSEE5amZOVVFRZ1liUENs?=
 =?utf-8?B?bVp6VEZXK096OWhUZk4xTGk2SWhlRnlDU1JFeDZYVCsxQlZKbjJvL3NmZVgx?=
 =?utf-8?B?RjE5NnBjWlRiRGg0bVJueFk2QTBwbDhkMWhNcGh2U2xiOUNJWFR0YmFsc3Fn?=
 =?utf-8?B?TmdmR3I0Vjd4MVNtTURBeHJZWVEwd2dIYjBLaXdJYzFtUFM5VHNWWGNsaGs3?=
 =?utf-8?B?b3hqQ09GWVBpZ3pmVnpFZHdRV1lLWTJGLzgwcFFOZGlnbS9yVGVYTFJ2d1Ry?=
 =?utf-8?B?Tnh0YWNTdW0yd0NMMFZVSFN3eHVpTkFFUDFTL2EvQUhVSU52TVU5N0JpSFNy?=
 =?utf-8?B?OFN5V2cybFo5cCt5TElqN3BEMWRVWWp5amRVTjJ4M004UVFWRmtHdFdSc2Uz?=
 =?utf-8?Q?Bv4WqKLqtcXLKuKl4p7rHIwbl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e785b534-c390-48b9-c15b-08dd0e38c803
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:38:39.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs0Baawe3MVg45mzeKCqueLgsMgJsh0zIbVZwhaEKLJ1oWOqtdfAM93X6gHGGldiRSyDVIV5md1kfTs4DF2OuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816


On 11/26/24 05:59, Alison Schofield wrote:
> On Fri, Nov 22, 2024 at 09:27:34AM +0000, Alejandro Lucero Palau wrote:
>> On 11/22/24 04:35, Alison Schofield wrote:
>>> On Mon, Nov 18, 2024 at 04:44:08PM +0000, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Differentiate Type3, aka memory expanders, from Type2, aka device
>>>> accelerators, with a new function for initializing cxl_dev_state.
>>>>
>>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>>
>>>> Based on previous work by Dan Williams [1]
>>>>
>>>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>    drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>>>    drivers/cxl/core/pci.c    |  1 +
>>>>    drivers/cxl/cxlpci.h      | 16 ------------
>>>>    drivers/cxl/pci.c         | 13 +++++++---
>>>>    include/cxl/cxl.h         | 21 ++++++++++++++++
>>> As I mentioned in the cover letter, beginning w the first patch
>>> I have depmod issues building with the cxl-test module.  I didn't
>>> get very far figuring it out, other than a work-around of moving
>>> the contents of include/cxl/cxl.h down into drivers/cxl/cxlmem.h.
>>> That band-aid got me a bit further. In fact I wasn't so concerned
>>> with breaking sfx as I was with regression testing the changes to
>>> drivers/cxl/.
>>>
>>> Please see if you can get the cxl-test module working again.
>>
>> Hi Allison,
>>
>>
>> I have no problems building tools/testing/cxl and I can see cxl_test.ko in
>> tools/testing/cxl/test
>>
> Yes that's the one. It builds it just won't load because of the
> circular dependency.  Sorry I haven't been able to dig into it
> further. I use run_qemu.sh [1] which uses mkosi to build the image.
> It fails at the depmod step and I haven't been able to dig further.
>
> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
> depmod: ERROR: Found 2 modules in dependency cycles!
>
> So, I'd expect it would fail at make modules_intall for you.


Linus's tree with 6.12 tag works fine for me. I'm doing it manually, 
creating the modules inside tools/testing/cxl and copying them to 
/lib/modules/6.12.0/kernel/drivers/cxl replacing the default cxl kernel 
modules by these with the testing stuff, and copying there the modules 
inside tools/testing/cxl/test where cxl_mock.ko and cxl_test.ko are. 
Depmod works fine after that and I can use that kernel+modules loading 
cxl_test.ko and cxl_mock.ko without any issue.


I have problems with the cxl next tree and the current Linux's tree 
uptodate, with some error when installing modules but not related to 
this problem you report.


IMO, it seems it is a problem with the cxl testing code itself, or the 
build, because I can not see a reason for the  cxl_core depending on 
cxl_mock except for those changes introduced for testing. I have been 
all day moving from one tree to another and doing tests, so I leave this 
to someone familiar with the mock testing sources. BTW, I think all this 
should be documented along with the CXL tree to work with. I know there 
are instructions in that cxl-test-tool repo but it should be a reference 
in cxl.docs.kernel.org about it.


>
> BTW - this happens occasionally, but usually on a smaller scale,
> ie we know exactly what just changed. I suspect it happens with
> only Patch 1 applied - but even limiting it to that I could not
> nail it down.
>
> --Alison
>
>
> [1] https://github.com/pmem/run_qemu
>
>> I did try with the full patchset applied over 6.12-rc7 tag, and also with
>> only the first patch since I was not sure if you meant the build after each
>> patch is tried, but both worked once I modified the config for the checks
>> inside config_check.c not to fail.
>>
>>
>> I guess you meant this cxl test and not the one related to  "git clone
>> https://github.com/moking/cxl-test-tool.git" what I have no experience with.
> no
>
>
>
>>
>> Could someone else try this as well?
>>
>>
>>>>    include/cxl/pci.h         | 23 ++++++++++++++++++
>>>>    6 files changed, 105 insertions(+), 20 deletions(-)
>>>>    create mode 100644 include/cxl/cxl.h
>>>>    create mode 100644 include/cxl/pci.h
>>>>
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index 84fefb76dafa..d083fd13a6dd 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -1,6 +1,7 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    /* Copyright(c) 2020 Intel Corporation. */
>>>> +#include <cxl/cxl.h>
>>>>    #include <linux/io-64-nonatomic-lo-hi.h>
>>>>    #include <linux/firmware.h>
>>>>    #include <linux/device.h>
>>>> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>>>>    static struct lock_class_key cxl_memdev_key;
>>>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>>>> +{
>>>> +	struct cxl_dev_state *cxlds;
>>>> +
>>>> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>>>> +	if (!cxlds)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	cxlds->dev = dev;
>>>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>>>> +
>>>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>>>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>>>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>>>> +
>>>> +	return cxlds;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>>>> +
>>>>    static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>>>    					   const struct file_operations *fops)
>>>>    {
>>>> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>>>    	return 0;
>>>>    }
>>>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>>> +{
>>>> +	cxlds->cxl_dvsec = dvsec;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
>>>> +
>>>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>>>> +{
>>>> +	cxlds->serial = serial;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
>>>> +
>>>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>> +		     enum cxl_resource type)
>>>> +{
>>>> +	switch (type) {
>>>> +	case CXL_RES_DPA:
>>>> +		cxlds->dpa_res = res;
>>>> +		return 0;
>>>> +	case CXL_RES_RAM:
>>>> +		cxlds->ram_res = res;
>>>> +		return 0;
>>>> +	case CXL_RES_PMEM:
>>>> +		cxlds->pmem_res = res;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>>> +
>>>>    static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>>>    {
>>>>    	struct cxl_memdev *cxlmd =
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 420e4be85a1f..ff266e91ea71 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -1,5 +1,6 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>>>> +#include <cxl/pci.h>
>>>>    #include <linux/units.h>
>>>>    #include <linux/io-64-nonatomic-lo-hi.h>
>>>>    #include <linux/device.h>
>>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>>> index 4da07727ab9c..eb59019fe5f3 100644
>>>> --- a/drivers/cxl/cxlpci.h
>>>> +++ b/drivers/cxl/cxlpci.h
>>>> @@ -14,22 +14,6 @@
>>>>     */
>>>>    #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>>>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>>> -#define CXL_DVSEC_PCIE_DEVICE					0
>>>> -#define   CXL_DVSEC_CAP_OFFSET		0xA
>>>> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>>>> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>>>> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
>>>> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>>>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>>>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>>>> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>>>> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>>>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>>>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>>>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>>>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>>>> -
>>>>    #define CXL_DVSEC_RANGE_MAX		2
>>>>    /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>> index 188412d45e0d..0b910ef52db7 100644
>>>> --- a/drivers/cxl/pci.c
>>>> +++ b/drivers/cxl/pci.c
>>>> @@ -1,5 +1,7 @@
>>>>    // SPDX-License-Identifier: GPL-2.0-only
>>>>    /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>>> +#include <cxl/cxl.h>
>>>> +#include <cxl/pci.h>
>>>>    #include <linux/unaligned.h>
>>>>    #include <linux/io-64-nonatomic-lo-hi.h>
>>>>    #include <linux/moduleparam.h>
>>>> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>    	struct cxl_memdev *cxlmd;
>>>>    	int i, rc, pmu_count;
>>>>    	bool irq_avail;
>>>> +	u16 dvsec;
>>>>    	/*
>>>>    	 * Double check the anonymous union trickery in struct cxl_regs
>>>> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>    	pci_set_drvdata(pdev, cxlds);
>>>>    	cxlds->rcd = is_cxl_restricted(pdev);
>>>> -	cxlds->serial = pci_get_dsn(pdev);
>>>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>>>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>>>> -	if (!cxlds->cxl_dvsec)
>>>> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
>>>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>>>> +					  CXL_DVSEC_PCIE_DEVICE);
>>>> +	if (!dvsec)
>>>>    		dev_warn(&pdev->dev,
>>>>    			 "Device DVSEC not present, skip CXL.mem init\n");
>>>> +	cxl_set_dvsec(cxlds, dvsec);
>>>> +
>>>>    	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>>>    	if (rc)
>>>>    		return rc;
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> new file mode 100644
>>>> index 000000000000..19e5d883557a
>>>> --- /dev/null
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -0,0 +1,21 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>>>> +
>>>> +#ifndef __CXL_H
>>>> +#define __CXL_H
>>>> +
>>>> +#include <linux/ioport.h>
>>>> +
>>>> +enum cxl_resource {
>>>> +	CXL_RES_DPA,
>>>> +	CXL_RES_RAM,
>>>> +	CXL_RES_PMEM,
>>>> +};
>>>> +
>>>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>>> +
>>>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>> +		     enum cxl_resource);
>>>> +#endif
>>>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>>>> new file mode 100644
>>>> index 000000000000..ad63560caa2c
>>>> --- /dev/null
>>>> +++ b/include/cxl/pci.h
>>>> @@ -0,0 +1,23 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>>> +
>>>> +#ifndef __CXL_ACCEL_PCI_H
>>>> +#define __CXL_ACCEL_PCI_H
>>>> +
>>>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>>> +#define CXL_DVSEC_PCIE_DEVICE					0
>>>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>>>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>>>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>>>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>>>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>>>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>>>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>>>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>>>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>>>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>>>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>>>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
>>>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>>>> +
>>>> +#endif
>>>> -- 
>>>> 2.17.1
>>>>
>>>>

