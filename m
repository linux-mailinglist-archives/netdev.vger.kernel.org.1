Return-Path: <netdev+bounces-163619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7AA2AF4D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B35C188BA48
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D86E18BC26;
	Thu,  6 Feb 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HWv+bbO3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533518A95A;
	Thu,  6 Feb 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864089; cv=fail; b=jFtfI5OFEJ+mGtNw5WqKOZs1+d2jTqEZHcN3Rrx9jdbV0MsnBAKfhn1ILvZy4mTvQre/ED7mu+/oAl/lTRVdNCcn8RMvViuJfWBsyTiDst4STL41DD6bgFpBGAJOD0naRVF/dTpaXBoxS6s3qe2ZNRVDUyT4u3qtzYl/NPtP1rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864089; c=relaxed/simple;
	bh=9etGA2MWvGenOZQXrJCd+Lku/VnRoSZRSGVLnYNPL5o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kODBI5C2mqy542BqVjZjUjkrnhL4gIN2nYNHSzN70BGrHKVQFkosaN705xaAj9o1VjkW6IakQfhNfFkCaXiev1tJ62l5p7uhf5mfoRoUdJAJFZECg+4qva8mXOJSnKZDu6l9Jnl/1qNxf22jXcXXDADpWmthNPJOWRleUS9mTGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HWv+bbO3; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt/r06lcBNjRN7ziSwuaXu6I44cnn9+F52Ydgi4MmI9O2Lmc5/n/3CP1v7tlpmBk7JBg60M6SBJ7pDU3pN5soPJIWhXnXkicdw6ihS7egxYn5n/ujapZmS7I+Nm4MymWf1wDXcPJSL9YMCmIzwTzCT99/j2OFwh5m2Zybp8AYw/1HrC17Z/cFwjiUR3CHWWW0/jEPo1Gtf9uCg8GDXBLTUKcgRIcQmulS5RdT3QIODrM3l96Dp0Xsk0eWzKdZdVdhkP2EDsLfPBz2H+kbAlGQ5ir+MBbRryFA+/+Lcc8r47axCTjy064kH/LBB2esDwzC8aF6PgENo5BPSkMuN5cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax/8TX8YZjJ77u9nm0l6ZVTg8qb12+007yEamMf9PaU=;
 b=gDry5A6GK6S58ovIbGc6LwvrNejzbmSkXBWPpw0RDBAJQqSN7TkspCJzqAY1HhJTNtUseRp/6fVvjYnIPd5WP3nJMyecGfoh1e3T6gLPp1n0bGWR71T/z+rEnJHbKrEgY++zfXwnsyxFTeQucB3zmqa181TVwvFVlApa2lTbF1cx4c7smnQx84rBttGpL9jsBsFmhg1Z0Eb7rGnPiWju2/SsxvU98RGTqt3Cpr5zyiRlej8XuxTqr27Zta84ZFq7pTD1FwptVR4x3Ms+Sz9QBC9Xxr2F6cn7mgCnDdOzxh11Un6RC1DfuGIqlvkL7UB52uxuDszZeVsQTLA+RfDdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax/8TX8YZjJ77u9nm0l6ZVTg8qb12+007yEamMf9PaU=;
 b=HWv+bbO3IO/ArfHRz0nKjUV4OQojYd5t5jf1w0qKESYx0qasN0OlQmGUe05gitlP+EaSCZ2g2xNoX2vZtramFtB5uR7aFVECJW4xVJeb+yfoJn51X0Wd4ImYWeReE5TjbDX/ehpxXcl0P6x3w716amGUd4MVyswL7ib8DgCNUfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 17:48:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 17:48:05 +0000
Message-ID: <5151f770-da13-4db6-a02c-aa2acb9e486e@amd.com>
Date: Thu, 6 Feb 2025 17:47:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/26] sfc: use cxl api for regs setup and checking
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-7-alucerop@amd.com>
 <67a3d8cfaafd_2ee275294cb@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3d8cfaafd_2ee275294cb@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fa45ff-7415-4576-154c-08dd46d6689d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGxHNkFBQ2lBYTVqT3VyTnRudXh1R1g2UVJ2eEI3OEFxam1CQ1JxK1BJckkx?=
 =?utf-8?B?VVdvS0dLTVpoSE1ZekRtV0Jta0VlUXhxRzg4OTlQS05jYnpFLzhpTkdCclFV?=
 =?utf-8?B?ZGhYSEtsNTZCNkd0M2JjRUNtd2lCMGN0SmErS2JuRmZ1Rmk4b0RXakxEUDVx?=
 =?utf-8?B?c2pyT1dDUDNjMHVOT2xBbnRZWDUvbldzNG9HeTY3Z2o4MXVvbGRkT05vNnFx?=
 =?utf-8?B?d2preERsQS9ZQ3Z2KytyS0lMcy8veGdKMExSU05sVHdHMmxJTUZ1UmdlcmRN?=
 =?utf-8?B?aFltZ0dhVmovV1Bqb0pLZDB1TDJHSHB6VlpYeWxSN3FrVGN1TjhmeXpjcHJz?=
 =?utf-8?B?UFZQY2F0cWpMK0NUdnphSmN3M0ZPLzBoalFRNkwzMUs1Vmg3am1QalNjMjll?=
 =?utf-8?B?STdwRTNOQWZXV3dtMHlCb3FjcFREZDVPbGg5MlZuTEpUdGZzLy9ibFhPbC9U?=
 =?utf-8?B?ZEdtcEIyRFdhUEZ1MUlORWJ0VlZSWmpPTHM1NDVPNTdxRkMySEU2OHB1RFJl?=
 =?utf-8?B?TGFZT3gzVGRuUDdNbWFhQlgxb0NkOHEwYkdMYU9BVUFmdFdaNEwzVXBqOFh2?=
 =?utf-8?B?L1lFaVFqUVJjKzNPOGwrbGpjTmRuUFdDbUhQZ3ZXMlNsK0NHdjRPSk9wTERr?=
 =?utf-8?B?MEVUYUFxZGNtNjJjM2d1WmlpelBtUWFNRVp4MjkzZjNvMlpZMGVOQmlkaTdW?=
 =?utf-8?B?TWd0TEVnbklvRDlCNzlPajBHVHZMN2lxNkJiSTNEbXp6b3JBWmVIN3htWUR1?=
 =?utf-8?B?S1dHWFoyVXdCcU1LYk8wTW05cnBFakZhRFJXVG01b2VENkNUSzZBa1Fqc2V6?=
 =?utf-8?B?Z2ptN3VQUlcweEhYMm1Gd3ZWT1NOeER3RkVOUWlhZjlLNm1PQVdLWUs1Yjln?=
 =?utf-8?B?WlBnWEVHNFptaHhQUll3NEd6TEJKWTkxNmNsODM4UzRSSmQ4b1NBRzJTbjlt?=
 =?utf-8?B?dUNkUEJoSXFiMXorK29VRW9mVm1iZjJ0OVFOUUJQTmN5MHM5ZVZXMEJYODI0?=
 =?utf-8?B?NzFMUk9hTlJlOXhVdlR5RW81akRSQlNpRDMxbnoweEUvbVovVzZMMVh6SEl3?=
 =?utf-8?B?WW4vWktON04yYU04YWlGdjIzT05IUU0yQlFtYlRGU3I0Y0pWUmhHaUFMbUI4?=
 =?utf-8?B?amFRM2xUbWtLblp1UXJ3aSt1RytXOHYzcG94TzRSc2htRzVRTFljOGE3ODlu?=
 =?utf-8?B?WEIvM1dpQXhXa1lYVW9BTitINytVRVd4WFN4ZnVKaUVTVzRaUm9ROXZtYk1x?=
 =?utf-8?B?a3h1V3pCYzF5REozanNQaHFTT29SZWxYZllxOXZDdGxNNjZnTEhCWE56SklF?=
 =?utf-8?B?ditNZlFlRXVBZFY2SjdjSzVGbmI0SlZqK1pCMSs3WEhLUUp2d0ZZQU1tYXdt?=
 =?utf-8?B?VUh3ajJpRlR6VTNGQzVIVE1MdkpjT1ZmZ2l2eDU2SzlZQUpybmtlbkJlejk3?=
 =?utf-8?B?ZU16RERJV2hVSm1vei9MckNFRHJWRlhkOUNBNTRBeXprNGlCNU1abzBOKytI?=
 =?utf-8?B?U1Nwby9QU2FJd2p2MERqbTlPM0dlWkxObWd4NFRUS1BQNmkrL0E0SE9zMzRO?=
 =?utf-8?B?RnpWZUJIT3JoQUVTeUVzOXZ6UW5xZk82Q2dZWEVPNkI0K3QrbkNveUxRdHVa?=
 =?utf-8?B?alNUQXd1Z2ZnZjh0K3RMbzZUUlpIcmQwT09WWjcrUk1ERXBPMFFBcFZQSUtT?=
 =?utf-8?B?VXBjQ215ZXMrdGcyK2hXQ29MaFEyTmZFTmt1dUt6RWVtdDdyUFJKdGRkalVB?=
 =?utf-8?B?YWl0YUwvMDJrc0xrTXFqU0R4Wkg1K1R4YndZVE5QbmtndXlIYmw4R3VXYTBQ?=
 =?utf-8?B?cEQzc1lEMmJGY1NPQzdiQ0hDV0VFQ3NwR1pzU0lWZ0FvZDNNeUQyQ0JVMlht?=
 =?utf-8?B?RDhsaE5zMFo3enZqcmFSMVY4b1dmZzdCREZOMlJHa0JGQnN4cE9NSEc2S3Y4?=
 =?utf-8?Q?5qqgWK3a/RQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hxZllFb0IyNzVTUjNwSFdLcHNueDVYQUZrSkRFTG0xWG5YSzk1bmFVZnk1?=
 =?utf-8?B?TlpjYmR6UWlFUzZIdDZ5b3MreWw3S0Vud0crbTBUdlpwQXluUk9SRXFiZWxH?=
 =?utf-8?B?K01vQzIyVFRMNnVVQ3RwQXJiTDJCVkNmSmhJR0FnT2F0SDIxVE1HemJ2b1ZR?=
 =?utf-8?B?eHF2YWErcmtPWlBabkJ3TjBnRUx6elpUd3BSOHNBSTZqQmswdE1LaEtSdFB0?=
 =?utf-8?B?NDZmVjAxeUtiem85SUJWdWd1WW9LZnVPYkZ4K05KZWdJSFRCSTNBdndzRWI0?=
 =?utf-8?B?RlQwR1NMODUrUG1TN2hya3pyWm9SSHMrQmRkTjZqeTFHNC8wanlBamVORTZo?=
 =?utf-8?B?NEVBbjlDYXJFWGgzZGdnZFJKR3p6UnVXcU5YZ1dlQUtXclRaTERXT0JSUjht?=
 =?utf-8?B?SVc4UEJMQUNmRW5KZzI0RW14Z1hoT0lmUUErSnZWdEg4RlQ3aW5XeHJkWWdX?=
 =?utf-8?B?dmR6eVcyK2N2QkZxQWpKOVJSR3h5OHN0WDdtb1dGRTN2aThJUm5jK0IvQnI0?=
 =?utf-8?B?VHNXTnVORTNucFZzODByS3VwYWhiK0hjeDZaT0xCazdIWU9hVjlUVE1aeHc3?=
 =?utf-8?B?Z2dVQ3lEQ0x0WVE4cDNWb0ZxdGx3WjdCOGRnR0x6bUVVOFRwV2lvOXl1N1Jt?=
 =?utf-8?B?V0hIMWVxYk01TmZzdmR0UkFSbzdib2Z5b0VJNWFZWUk4TTBkaWFXZStPVm9C?=
 =?utf-8?B?VU53aE80dEc1ZDNwVjVzbXF4OVVXQklOc3FibE44c2hOMHFJNm5HM3ZUdzZ3?=
 =?utf-8?B?amVTMlRuWVFNbXlBRWQxNkpSdHVteTQ3TmlGV3JjS29XdnFZUHhvK1ZHWHBW?=
 =?utf-8?B?dGp0ZjROTlNzUlJDNUt2eWtzYkhmcUpSdGduK2xsTDllMkNiNFZ6WElqbWFK?=
 =?utf-8?B?b21IVjdBZmt2NFlEdkZHUnNOdHUwaGN2andVcmZoOEl3eS9kUFNKOGd6YW1j?=
 =?utf-8?B?RzZwb3BUMEJ1K256MCt1ZEpNcHplT2FoR0szeHFBYTR0clI1TEJmTk1QdjdX?=
 =?utf-8?B?RS9yVDRxU1JOekFIWUNvMi9GcDBId0tiL0YrV29ZYlEyM0J1SlBqWU54bnNk?=
 =?utf-8?B?T25IWGsraDNKbG5pb0pCYzJMWW16TEtYZXY0OHdjcnAwVUh4RXZZRDRQYmRF?=
 =?utf-8?B?T1NjcG0ySlY2N0ZXL1RJSVNhRlY3UGEvenFqclBjaWo5OTBEZVRQQ0V3QmVJ?=
 =?utf-8?B?dkNOczAra2EyTWp3R3ZsRG9Zc3VGNmpCdHh0bDd0anFwRVZwUEM4NlpFQ0Mw?=
 =?utf-8?B?a3dXUlAxWHFDVjdodkxxYnZCLytmUFpjL3h6OHBYUjVRZisyRW9mc3NtM0hn?=
 =?utf-8?B?MS94OGNtK3Fna2UyNTE5MmpSZE9yMk1sU1hLV0wvNDZBN3VSVTltMFFMNUta?=
 =?utf-8?B?WHlpVENiVE1GZVd1aC9OdklXeVNPYnAyeTFScFdLVGJiL09aZ3V4SnZ2UkNU?=
 =?utf-8?B?MDNFNXd2Lzkya2xjK3Q4NjFaTFdJZVR3U1VrZWFrb0dSNVNYdHZDQ0hxcXhu?=
 =?utf-8?B?cmpWcUhYaXpZUWFNeG5WTW1jQ2VFWG5vd016S3ZQNGtPY2FjVVZJMjdxYldR?=
 =?utf-8?B?ZDRMNTNOMkJTeTBaWDcxSnR1clJ6QlA0NXd1R1U4aTBZUUk0KzNvQ3l4SlFB?=
 =?utf-8?B?UU52eEtxVWZrVUhZQnVwZDNkSEo0NDZDR05tbXBMS0Z2aC9EUGE3dkhRSHZJ?=
 =?utf-8?B?LzRROGRBSXdGdyt0YUNvWDUzcU9mcjQvNWYvZGN3NWdvWTVWY3FVOW5FV1hU?=
 =?utf-8?B?SldNYnFlcHhOdDE0YWxIbFFmUkQ4TTc0S0J5MUpucEQ5WTFYdENlcVFEdkRJ?=
 =?utf-8?B?eTR0RHBrSmVQS1J2THpzdEJDa2Z0dlAzUDUvQ0FHL3ZENmI1cFpuby9kYUdX?=
 =?utf-8?B?YytMVFIxTVFOZGRNOTVGVWNvSUwvcW11U05KaDlNNHZvdGxNbmV2d2lsMC9k?=
 =?utf-8?B?K01YNWJtRjA4cmpoT3l0OHVrZFJJbDd1TVpjTlZnWGc5R0wrOUxHZk9PbVJH?=
 =?utf-8?B?SEJZdWFsVjZQd2l4VUhsN0JJSU51MTFyVkwxOTNkUEZsSUZydWNqL0tqRWVs?=
 =?utf-8?B?eU9tWGFPeXloR3BJSm9iOEhmUCtJUkgzUHQxTmY2Qk16TkJ4VWNzMDVQM1Nk?=
 =?utf-8?Q?exIPF4JzmEnLmREBxn79aTD+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fa45ff-7415-4576-154c-08dd46d6689d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:48:05.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbRJU4WFBOohTfqttfsUlptpBumZMd+Gj3nwgfgT5yZCfsjMTU/l1YA17QJwxQil+VqYVqAMhnYGgZQidRRzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143


On 2/5/25 21:31, Ira Weiny wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> I'm still going through the series to better understand the over all arch
> you need.  But I did find a couple of minor issues so I'll make those
> comments straight off.
>
> [snip]
>
>> @@ -46,9 +50,37 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmds);
>>   	}
>>   
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
> Why set HDM x2?


Something went wrong applying the patch.

I'll fix it.


>
>> +	set_bit(CXL_DEV_CAP_RAS, expected);
>> +
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlmds, found);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		goto err_regs;
>> +	}
>> +
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
>> +		pci_err(pci_dev,
>> +			"CXL device capabilities found(%pb) not as expected(%pb)",
>> +			found, expected);
>> +		rc = -EIO;
>> +		goto err_regs;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> +
>> +err_regs:
>> +	kfree(probe_data->cxl);
> Is this freeing what you want here?  AFAICS probe_data->cxl is not set
> until after the checks work.
>
> I think this is best handled by using __free() on cxl and no_free_ptr()
> when setting probe_data?
>
> Ira
>
>

Yes, that is right. I was eager to submit v10 and made silly mistakes.

I'll fix it.

Thanks!


