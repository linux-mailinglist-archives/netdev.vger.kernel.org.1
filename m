Return-Path: <netdev+bounces-148908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8419E3630
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984BBB26357
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1951991CB;
	Wed,  4 Dec 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgdJdSui"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A6194A59;
	Wed,  4 Dec 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302726; cv=fail; b=fxngD+PIsOw2LQwPOHnFOD0p7GMRTrqFpfAKLdnreHK3O5qjV7XHwC94jGwElz4Phvn+e3MldTl7cpCwFIzqa5AVb3rYydwB9X9/ELTe+guFYrGZ4LOIcLK+a/r/tpGGNNnkpbY1cg3ZoINKi+D0kx6Bh8mVf7iVjAkOa0hpruA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302726; c=relaxed/simple;
	bh=YdLvDVJogoaOs4OvAUcnB7YqsUBN8whAL2T0rx0+IQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uy0OVM62HaWjhYcsSgGda5hQ8GY+M77P3bwghXpRrAK3Rc8Be502iIdeNStnK5vg+teVfrPhd0AGKnsEzYOcn14jAJ1JENrtOKtVurQwNMb50WPHGxZOoC1vmKDhyt0zKZK8JW15HNXrLTfQ4txSewPWZ5oJNtqHQ+YYERr7rKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgdJdSui; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btwiSRL/TzJBeGXLAhQx3ZoN4JLTH4L9JJdj+LJOnDSL+CbPwOKhuvQ+RgNCR/af0kwwTzIhnCtVU9W+15uXjxxvmFHUImVn7C78GfKkjUPN371Zr4ZbzTbqU4GYAXIn/xuqvd9pqKMXffsv90W6BpwzeQJx2wvwce3OMsDQZ0etJmcNu4mAu3JSGbbHQizFNtzLMj3EKZzzvD+OjNNZz3hclShI2AFdaTU3p3pSDcrYlChf+AI0oFHEkt0oMZbB+zvCGWwsWHg2UpsZlXBUs7nvKVfUyXFL57+IuS0TXSRocam6KXm5EN206uoJreGyIA6DuLfauJUXvMepF22PRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M/dTgFN2WlIpnDsoRd0WSMlk05y/PsnChBH8jnY6AM=;
 b=reJC6KvxCg1vKMalERVF6aZ0wCfrJ3zNG5y/9LmYSRNmn/p2t8U12FOOR4Q/XC0gJITji/948IGFX98b9GkbnW9864xBsAA0YUvexoHUAJpfZ1sWaucUmtVKFOpSzEWKbYFUVqxR0dWIjP+Jc2U+waUzchQUg6bntTBfHRY/l/OFkb/0RtIaCsI9KkKonsjY6B7Kk17C6pMXp7q5gPxuC2reeCfOxG7BCr8MEXPrMyEx4BY9PaiJWuR6/U22bfJolmPORJcS0PAlLPPJQNVsGh5a9dCrCHECv79X6cGBRHYZUsXOYTW+dkJwhzkRMKsgHscmLM7eowVjKVv1g/0Gog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M/dTgFN2WlIpnDsoRd0WSMlk05y/PsnChBH8jnY6AM=;
 b=EgdJdSuiFc72qdoqwVOMZF4RDH6cEsQ1pmysAAztzBjWgLDGu59mvByBd2dnw8viujTwu2AXf84BKFdVMyiTmIeGPJVKayMCr9l5oQ4TwFvpRb+T3e3JtfuNXA03xlLe0QKECd3HYGCQWtCld76Xn6jnnN/zehP+foIoTwXlVXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 08:58:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:58:41 +0000
Message-ID: <bae25f0e-26c9-d051-731d-c87260cf120f@amd.com>
Date: Wed, 4 Dec 2024 08:58:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 04/28] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-5-alejandro.lucero-palau@amd.com>
 <Z0-MddhGPjtO91h_@smc-140338-bm01>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z0-MddhGPjtO91h_@smc-140338-bm01>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df065f4-1f0b-4eac-cf2d-08dd1441d9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWQ2M1J2QTZGRERvQ1ZjSW5RT0pxdHEySDFIaVI0dERnY3U1akM5elN5Ymcv?=
 =?utf-8?B?dk9oa20vczFnTUpBUElZbW5lRmZLa1NWY0pBQ1ErUE5wWU8vOFdrVkY5NCtK?=
 =?utf-8?B?TFN4UitHUzlFbU03TkdtR3JYN3BzVVRnWU9NZTFWemFWcjlJUG5KNWJCbkR0?=
 =?utf-8?B?U1hlTEhGWm9yTDQ3YzJkMnVJbDFZWkVyaktKdENqUE1wYW5oU1kvdGZab0Vz?=
 =?utf-8?B?UjNJOURNOFJ5UDlpSlZkQWVlTGVvUGwyNWZGejI5bXdOK1VScnhxWmltQlps?=
 =?utf-8?B?bkx6eVN0YzV3aXNtZ1FqM0V1cG9zOFV2cldRT3lPbkJ1Yy9xNTQ5dnYxVUYz?=
 =?utf-8?B?Q0VJdkhKc21nWFNCc0lQbjJITHEwNXVLcXZQb2V3SWdTcndLWElablZyb3ho?=
 =?utf-8?B?NjB5Qmd4c3FUTHJES09ra2F2bWc2TFNmcDI0VGlVOHpqNktySGxxYzZiUWR6?=
 =?utf-8?B?SFkvcllXMHR5WVF2bWl2TXdaUXl6TFc0TlhmOXVnNFgyL2FXR2poaGt4cHI1?=
 =?utf-8?B?aXdOS25yNGI4OUJoNjd1N1RjMGdJMnk5eFFwN0ZxMkozaEdabmF3Nk5JZnBa?=
 =?utf-8?B?b3M2M1dUNmgyb1ZnODVqRHFhaVdrYUltU3FmcWh2QWxEMHhxWWpLNEJnOE5W?=
 =?utf-8?B?QnlKR1AvTFd5cVpHOEpPZkdBQXVKVUhORlNjY0JDc1U1ZE9EZjkwRE52VWd6?=
 =?utf-8?B?M0VUazJacFg0enBuUWp5SGs1cnR0L3Q1SHZ0UjF3bUVaT05GRGtGQ3pUemFn?=
 =?utf-8?B?RThwekZKVmd6QUlHZDRZM2VHbjNaL29mRzd6VWltSDdEQzJHZWwxS1U2VnI5?=
 =?utf-8?B?aVNsaTk4NCs5NVdJNkd4TWszZ0xGeVRtN2UyR3ArczRrV01JZ1kxVE5mMmNZ?=
 =?utf-8?B?bmF3VEo2UUx1VDRmdGpKMTRMRjFUS2N4b2IydDdiZzg0dzZrWDBzMnJJazJC?=
 =?utf-8?B?cXRkb1VTQldGOC9jTGZQcnpiajhESU9JbTNkdEtHbVYzbUZORUF6dFdjMHlx?=
 =?utf-8?B?d05Td3ZaWGc3S1k5bjE0OFE0bGpKcVNuVlhPQkhjRnFKanU2cko0emhuU2x4?=
 =?utf-8?B?clgxR25aWENtU3hYRzliZmNJQXYxOW9Oa1RVb2tZQWVUUGZLejlRa3A5RDZC?=
 =?utf-8?B?alJMNjNOVkNsSS9Yc3c1Z1VSS2lNd3FSZysvWDN2bTJMVVkydml2eFFzKzV3?=
 =?utf-8?B?TUdoQWtCNW5pYytmMjlPcmF4YXh4dU9OMVl4dVU4UmxvU0dGejdsR2NwM0JQ?=
 =?utf-8?B?QmtnWm4zMjUyMThKT29KbWxZSTRCZEt6ZnpxVEVYNEhRSmp4RTc1ZWhzUU9V?=
 =?utf-8?B?UUh0bXBCWDZrYkRWMi9zNmx6bmJyQVBJTEZKODNCOFRONENiQ1dPYkUweVpj?=
 =?utf-8?B?REE1NXBqQmgvZEEyai9waWQxMWlKSGozcHp6NnY3VE1ZWVhiVFk4UkQrN25S?=
 =?utf-8?B?aWhyTjJpeEpsYXVIci9pUDFVQVlDTWNYV3JDUDU1cHVzZHloS3ZrMW5hT3Zv?=
 =?utf-8?B?aUxuT24xSHBYbEVlV1NXbzQ5WFVJTlNPL1JZT0pyY0plQWRhZlhKRHRXS2Fv?=
 =?utf-8?B?QmRCWk0yMHEvaG1JYk5lM2ZRRTUzMForcjBoZEt4UzJMamdsczV0ZUZzWnpz?=
 =?utf-8?B?c0RneEdZbjVjOWI0RFY4UXpkYkRzR1ZJWmRaYU5iaDdHdnMvVzZJQ1FVVmlN?=
 =?utf-8?B?WEcycWtxZGdvRm53bDVGbGJ3cytoaDRuUDA4UzNmazBEWGxvZTFhbGJTNkdl?=
 =?utf-8?B?clpMYnArODdMNHpRYW84WnhuNUlDNEc4SzV1TjZXM2hVQ09oZ1Fmc1N5R1VT?=
 =?utf-8?B?Yk1BVUhsNEN0RXI5Zjdidz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2grbi9iakxhcjBNSVVxbEhNQ3VHNzM3TjJCakxWaGtGbzM0SGJwV2Q3UUdi?=
 =?utf-8?B?TEpSUWxzaE4wVGh6cGUwVE9IalU1b01GQUVoUlhxNmU1akc5SWhQbnlnSFlT?=
 =?utf-8?B?OWNNelNxdDRuUE9rTzRyWHFMajlDcEFhWEJRamJXQVJiMlRuSnh2QmtLa1Ju?=
 =?utf-8?B?L3BwZWxRdi9keld0dDRkYTBEZS9JYmcwbmdPdjZyRGZjVldYeHJCQXhxb3Iv?=
 =?utf-8?B?VG5vRGFHM2NZcUR1azkvb2ZoUUlBVnBCVTY2bFJneXJ0TCtLNkYwaFMyeFNP?=
 =?utf-8?B?dDE0STltelZuamgraVpiN1pLVEROVU9SRzVkZHBFS1BXNjNzWS9pVlNGdDJ2?=
 =?utf-8?B?Q29wUzVleWxHYy9laHZpR2hnaTNhcGdjNVZZWEN4TUhJNGs0OGZPazBqOWRq?=
 =?utf-8?B?S01waWM5QUhsa2l2bG5melNZNG1OQVBvOCt2YzlHek5YTWZ1TU9xN0dJMk1G?=
 =?utf-8?B?YW5SUEFPM3Y4N2E1aXpCakVvbFo4eStOS3c3V2dmamFvblFsUkhNNjZiUVEv?=
 =?utf-8?B?anpRR3NpRDVuRzM3bnVZUTIzbUpxM0MyeHkwZGZEbFo0Z2RqWERVVFBVZXF5?=
 =?utf-8?B?YURRbWRXZVppaTdBK2FVeWp0Y3U4YVlrMEE4enUxa3RMZGRhNE81bytKcXAy?=
 =?utf-8?B?bERFZGRFank0VHVmd3lBVGdESVFPS3hzaS9FT0FMbWFwcnhrdDl6dGd2QlR6?=
 =?utf-8?B?dURzRHAwOTkxQU0va0MyVVU3eVN3MWJNcnVIUTE3M3JnQVNPSEhNZnhIZVcr?=
 =?utf-8?B?VkphVzZHZWJLcEhtNzRFVXJ0b1NaRmcvM3RwaTlBTnJuMXEyc0NBdXNiREdv?=
 =?utf-8?B?MzVYaDh6dDhGb0c3d1JHam1KM2pCYzRiTU5wWktrSXZ4eWszV2pieWtlR0U4?=
 =?utf-8?B?d3I4QkI5dlF0RkZvaEh4U3BKTXBjbG5WWEVXbmJRWDNyUy9vRWNuZUtyNkh1?=
 =?utf-8?B?MVBCaFdnQ2hXVTBxMUMxa2NtaGdBWWljUUdUQ2RlK1Z3dEdIVDg5ZkZRRXI5?=
 =?utf-8?B?VVo3eWlJZlNLNzVTcUhrSXV6RytzZzY4QUNmOExtOVRtQ1FhZ25BN2JWR0RH?=
 =?utf-8?B?ZHlUK2JZQVI0MkZrYjNMMHc2RXg2dHBTUW9samZQQU5vNzVoQm1CSHAvSGNZ?=
 =?utf-8?B?eHhJYkJFWHpOTzhxVThGczNuYVhEU0F0V3E2SWtrRmZUUzZjSXhzalNKVVZC?=
 =?utf-8?B?RlpLQ3BYTmZEUDd2Tmo3LzBVa281RGN4T2plai9TbUVKeElGaGU5NkNrZTRU?=
 =?utf-8?B?STFuMUhBa2ZwMmhwdjkwT041SmU3NGRSUmM4bFNBMi83OEJCZW1RUzQrSUpR?=
 =?utf-8?B?N2QzZFNSMmxYZWYvZS9IcnRsZU8rd1F2d1hrblA0MmcvNkcvTzRZTVRiUDBT?=
 =?utf-8?B?R1RXZDQxUkE2WDlOY21MNkRQekNEQUpNd0RMck42U1R2TzViaHVIZW5vMy9G?=
 =?utf-8?B?dnJCSVlNckxIUVpSUVBZOUVQc3lwWk5hc3ZZeEdLWnFka1BhVnM1OU5neFkz?=
 =?utf-8?B?bENJT2xROGczcjVERE41bGFOYjZDdExrZ0ExQTROZ1dYZFRvcXhHTWhkMVFM?=
 =?utf-8?B?ci84Q1ZJcjJvMUNSeE9EOGhiRGpOcGdxUnRIQWFqSTUyOXdrMXM4eDBHRGlk?=
 =?utf-8?B?am5zNVVrY1RidDYvTnJhYW4yVFVIQVlZdFIzOFlZR0Q5ZEE0RmJkdEZLL1pH?=
 =?utf-8?B?dHZRNFZaRVdROCtjUlRZYWVyZGpRWmFPZUJFbzYwcjZWb2tLRGNmSXhVR25u?=
 =?utf-8?B?Q1ZndEc5SVJuVXhHYTFWWWU2a1lnNUtTRko1Wm16Q2g1ZlFiaXRGQlByMVRC?=
 =?utf-8?B?K3lFM0pGdUI2b01pbEsxK0tlaGZYQVVBbUZ3aXkzVFFQWktEaWJ2aEU3YkZ5?=
 =?utf-8?B?bE1LNDBMTWN3MGdjcHJ4MnVCZVdVWnFJWFdsaDRsd29ncW9hSUF6YUl4TDJJ?=
 =?utf-8?B?VmRleHE1bENadHZiRGJDalBMNjRldFozRG1TeVRNZWFPR29vem5UQW1GMytm?=
 =?utf-8?B?RG5pWVYrSCs2SU5LR2M5TTR1YVRwdTBqQ3VpTjk3QmVzSm5ueTI5dFhweEZI?=
 =?utf-8?B?c05xNlduN051OXQwRGJHdW5WU1FhbFQ5TjhMMDdpTExOeitYd3RmZDhXRUhR?=
 =?utf-8?Q?AwmjncPTY+ctC0UPRy9jn9RF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df065f4-1f0b-4eac-cf2d-08dd1441d9a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:58:41.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6WPuFxbWCXF5fHOn5vP+i5VybwZcED+o7BfLfWIZpSdrthTwkdZJv0X58ZNhC2UL9FeLABYozhGoMUjIyD2eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638


On 12/3/24 22:55, Fan Ni wrote:
> On Mon, Dec 02, 2024 at 05:11:58PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization and allow those mandatory/expected capabilities to
>> be a subset of the capabilities found.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  | 16 ++++++++++++++++
>>   drivers/cxl/core/regs.c |  9 ---------
>>   drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>>   include/cxl/cxl.h       |  3 +++
>>   4 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 7114d632be04..a85b96eebfd3 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>   
>>   	return 0;
>>   }
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
>> +			unsigned long *current_caps)
> It seems "current_caps" will always be cxlds->capabilities in this
> series, and used only for the error message. Do we expect a case where
> these two can be different? If not, I think we can get rid of it and
> just use cxlds->capabilities directly in the function and in the error
> message below.


They are the same because current_caps is the way the client obtains the 
information, being a pointer to a capabilities bitmap allocated by the 
client.

The point being, the client can not access the capabilities from the 
cxlds as it is opaque for him on purpose.

If the capabilities check returns error, the client can show/compare 
those discovered by the CXL core code and those expected.

I hope this clarifies it.

Thanks


> Fan
>> +{
>> +
>> +	if (current_caps)
>> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
>> +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
>> +		*cxlds->capabilities, *expected_caps);
>> +
>> +	/* Checking a minimum of mandatory/expected capabilities */
>> +	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index fe835f6df866..70378bb80b33 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map, caps);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> -				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " : "");
>> -			return -ENXIO;
>> -		}
>> -
>>   		dev_dbg(host, "Probing device registers...\n");
>>   		break;
>>   	default:
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index f6071bde437b..822030843b2f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct cxl_memdev_state *mds;
>>   	struct cxl_dev_state *cxlds;
>>   	struct cxl_register_map map;
>> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>   
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +
>> +	/*
>> +	 * These are the mandatory capabilities for a Type3 device.
>> +	 * Only checking capabilities used by current Linux drivers.
>> +	 */
>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
>> +			*expected, *found);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_pci_type3_init_mailbox(cxlds);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index f656fcd4945f..05f06bfd2c29 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   		     enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>> +			unsigned long *expected_caps,
>> +			unsigned long *current_caps);
>>   #endif
>> -- 
>> 2.17.1
>>

