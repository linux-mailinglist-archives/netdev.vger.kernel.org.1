Return-Path: <netdev+bounces-158172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5364A10C87
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A441889A5B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DC1D5166;
	Tue, 14 Jan 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TBwaapYb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91431D31A2;
	Tue, 14 Jan 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872863; cv=fail; b=YMInW/HpQqdPiGxTUqvsvepl4ic3bVuT6G58uUawqscUJbeh3KWANVqUFdoVpmxaNo1uVDHQglnFowuCxIerV6uoZQkkjOtvhQiKzHVtS/MJWG5y7SpDhBjzslgK/mC4dYa2ArIvyBawcrnt3ZuuDWDctHMuJejpo07SmzYOSIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872863; c=relaxed/simple;
	bh=JRT2gmvMDYs32JDESmGglEDllJadQVOsaTIe5EaFPZA=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyn/taMG29q8E66L2Iv4L6zDGGtcx8r+WnDBcAExHC74yR2xDZf5ml8A9w6NPVyu0OAJvMuEDvtROGTifQj7N9I68CqTSpSXe058gfFhNzzp7MIv/mroEcWxOObMpCf2FuhzntiE7HDrMODgW5s+ftt/M4Ml4s0V2v/lZvQ1Sso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TBwaapYb; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umvN0A8yMiHBaCPwbZAbqKgIwwqzZ4pErvdTYqgvRp3d3pr1ZtsZhwyqkjoYVOTkQEcQfre3kjEMIPmEZbvKWAEeiSRvJK+hUpQL1yHFKrKW8b33eBxsitD+lOgbzWCYSs4YmBihiiz6KeFkhrcE5clHonMKMVxxptV2GMya8kCTp46RCjHZSBW/jmFXzYMS2UJRTqzQzEcbDORnWKrg7MUynV34xROuIgbWOZ0ZQDPaQcg1jtaPVZLmCu/aTVuz48Tg7Jn1B0iXSPqT1hbinA0xfBoSxf6YrlSQn0WnnDHxCSA1PHkNiEyznJFGCpM/ZPGdaxcY5+OcS19u1E0wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6RHImRRm1gcm8HhAeOGXP+R0VzgtER4HGO0XZA523Q=;
 b=zR6/4NAsNZ5Zlm44iriMz3ARxdjtDxcWTGeEBQl9BwOGceB+CZJmLNCB06qh9oTpx4yHkcuLaKCHkRoHKsZBjQA2mxxTBrelePDrdyzR0VgFy0SYVsfuIWiApLIGEOqR2xUQ5up7xEOj/D6QBCjoyUgh5dSPgBR4xuiKa+OVzK9vOtLNYNaiyOsFppdyTlFWdjptDeNylzwgi2Cc+SAZVCifZNk/P0AJ+OJtlos3SiFr0SiBQZJf18UjqQXCTPGiXSpZ2KUO9HlsvqfHoLp+K/zZY0Kk29N1dkF3CspxpU7Ruzh+KF3ky0PCik8dNzphuXwaKia7OUHC7jHnhkUTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6RHImRRm1gcm8HhAeOGXP+R0VzgtER4HGO0XZA523Q=;
 b=TBwaapYbd98slkFA/cGNNZtvGGeNbTX4oJwQ2Uu+OkC72+NuOIHWbp/bTh4lHVLti1E6zDp6j7X8J0E173eOJDL6eBwc2XQaN3HqAWL0JvG0HHHcX74qOSgcG2Tj5yPY3gdvs3WFZNqs7MdsDH2Y+jgkuoCI5CBE1NAhhKaHPYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:40:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:40:58 +0000
Message-ID: <d1beb594-3bd5-b2c7-9753-4c1d8aeb52db@amd.com>
Date: Tue, 14 Jan 2025 16:40:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
In-Reply-To: <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 653475a4-5e15-4869-84f2-08dd34ba38c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUlhV1YrNkluSUdQa2RyTUdUWi9CM1ZCUWhHNzI0UUgrSnVvRnRvWmhCaHBH?=
 =?utf-8?B?dVVhVW5Da0trbVdHRnFWaWFOcVNvQnhUeE5JNDIyUDMyOGMvMnBmckFGbTZX?=
 =?utf-8?B?MklFL1BuVkRuZ0FxTG43SWpwVTNLM2ZkMFh3VnhOeElLWVRxbjFhek51cVFO?=
 =?utf-8?B?cENua1Vlek9XNjZLMHBmbi8weVFpZ0I1T3JXOG5qR0NyRU5Kb2tFODBCeGRu?=
 =?utf-8?B?UE1xdDhqb1ZIb1NEMXA5NGJheVNLN0xaYWo4RTRQSTUwd0g0T1lMcVowWStU?=
 =?utf-8?B?MHRwWDVDLzR6c2pwRkVvb1RlSjJPUnZWWDhoK0RmUGVTSlltWXc3N2dtZXAz?=
 =?utf-8?B?Q2xWWGtzbUc5VEpiNmNFcHdYYUZaK1drRWVVMFhURDd4WVdWbWFzMjB6TXY5?=
 =?utf-8?B?WXJ2aDdTbVFiVFZCS0RGZ21wdHhUMHNZWjl1TWozU3U0SG1Qc1lWUEFlaHMv?=
 =?utf-8?B?SFhJdHBPdExiZzN5WTJlZkZMeC9XQWlFeXJ6U21keGIxeGUydEJFWWJpS0R2?=
 =?utf-8?B?WTJEWXFJQzdkVHhQeWJmOWIrQ2l1ODhoYTFSc0JnN3pLaEFsemVyZ0JnaHBN?=
 =?utf-8?B?NjlNcUtDV1U2ZUlYTS9RdFJhYlI1YU5rV2JqNjh2ZmcyVWxuVmdCek5FYkw2?=
 =?utf-8?B?ZVBOYmJyeVdCTnlTZ2lTSnVFc0lmQ1FSV0M3RTBvVStvOUJkTitIV3NlRmY3?=
 =?utf-8?B?Ym8wbVpZL29YVUhob1BiRGlKL0szUDBvZTNQcFZ5bXZVZzRrZGFSLzZYR0lq?=
 =?utf-8?B?bmMxS205c0xlamZzWSt2S1BRWmVsTUhBUjJRa3N5eUp5MTVKcWxPTmJ2eU9F?=
 =?utf-8?B?Um5McXBhZVFRSDFmOHhhS0ZFNE9vL3d2S3VxSWdLQmNtbVNLWFZTTkJiSVlJ?=
 =?utf-8?B?QXdIVGpHRk9ra2RWTHFZWmRDMkYyd1NkSHM5cWc1SnBtVE9oa3Y5TzBITnNZ?=
 =?utf-8?B?UHZ1OHB1cW5SRkk3cHJYSURTV2YzUTJvV1VtVjBJWjdzVUlrOERadzNMT2NB?=
 =?utf-8?B?eGtOSUZNbE03NFZHdCtDbUgwcjFLSUNVTC9hZldkdEtFMmV5UWNWbk5HSWpx?=
 =?utf-8?B?Q0dNMVhqS0s2SXNWVGMzZXZKcHI3Mkk4cUw0ZGJRU2tacEFjRndzN2hOdThB?=
 =?utf-8?B?S0V5MkhSZkEwSTNlaFdCOWxSbHpGT2NkWkE0U21lbUw1ZzRIK1NoYkZ5Tk4r?=
 =?utf-8?B?VnU2MkVPZ1QyUUsrRHN3eThsNXhKQ3pMRzNJR1dnOTVaZkRrWUUyNFJSYTBq?=
 =?utf-8?B?QnlyRnpJSnhucHNvK3hJNzlhRDdBS25nZDM3bHM1OVByUUw0WHl1NzFFaGhy?=
 =?utf-8?B?K0ZBcnZmcWwrcjRUekJ5clBwK3NIOGUraXQyeklPV24yMUZnUFNHVVNuc3B4?=
 =?utf-8?B?WlJ1U1Z4b3lVSXFQcDhvMmFRbk1xMUhSU01aZzZqUG9obmVsQXlpd0lQTWN0?=
 =?utf-8?B?SzNCdFhralFYV0FIK3cwS1ZKb041WXFndUxhdnNqZFUrM1FWV1lWUmRUL0lG?=
 =?utf-8?B?anhRRTFXVWNROWcxKyt1UnhwWUdYTTdNMXM3Qk9uSkhrVFIvYmh6bU9WSjAy?=
 =?utf-8?B?blNlRExHWE5hUkZrRjlQZ3VJNCtRdFQxUFB0ekFvT24za0ZmUVdCdGFCRW1B?=
 =?utf-8?B?bkZDKzcvQXlXR3hxcjlROWtQN3ZZSHdMd1BNSjBkQ2lJV3F3dEQxR2gwdFFF?=
 =?utf-8?B?WjU5aExXOFVneXBOMzZEUXljUTRLS1dEQkRid3MvODVYK3pHVUJobVV6Nitj?=
 =?utf-8?B?Q3FGNkdGSEtJdUdGQnpKK2QwMW1XY0NSdDVvS3FpSER6am5hL0dFcmg4eFpS?=
 =?utf-8?B?MEVQREl5dEUrTU5qM0ZyUHdyc0o3MUI2Qnd5anRwMm5oaVBNZ3NFdSs3bldM?=
 =?utf-8?B?cE91NmU3Q1FjSzRDTHdqRmV6RlRaTmpNYXFxektTTzBQK2xuUDBSVVF4L0p4?=
 =?utf-8?Q?3OKNJN3dKmhDaSWt0yP50YtVrUiPvp6z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b00ySG5EbjdXSVNvaThlTDRQSUcra3NQeHM3N0lqM1BzM3FHU252K1FGbVlG?=
 =?utf-8?B?c2VGTE9QdXFHTm1LbFpKVG5oRkE0S1cxcEdhOHRwWmRIS2E5SUt1TVNBOFRJ?=
 =?utf-8?B?Z1N6QThYdlprWHVSYWl1Ri9QWVJuZTJCWUFtOGhlQlNNWVFnSy83b21OZTM2?=
 =?utf-8?B?WFJXWVg0aW9FSG1ybjNPNEFGR3VRbE0wUXFZTWhrbnlkTW56d0w0V1JNZnNU?=
 =?utf-8?B?QXlSWk1ZdVd4LzVpV3MvNlNtYmNmeEQvWXg2L2xKa1dpTjVSSVUreVFoZkJU?=
 =?utf-8?B?bnJGYzBQdlpxSlkrNkV2bGdId21BZjZaRGpEbVRQaGgzVXdPUnZUMzZDWE9C?=
 =?utf-8?B?S1B2Ym1vTExYOTdRanNibnVRMDBvRjN6SG54UTFtdUUzWE1lazRlTzhML3hF?=
 =?utf-8?B?NUVUVWdwSnhNNFcwUklxeUd6ZUJqa1U2d0xYUFd0RFFTaHVtWEFveUtnKzNs?=
 =?utf-8?B?KzhrS1h2N3VTaVBBRnBoTWRPbUlxL2dBSENWZExYZUowZ290Y1dUeXo0emhO?=
 =?utf-8?B?czkydGRZKzFZNEsyNWhNZk01Z3psQysyU1FyYUNUcWNjRDRtQm8zZ2g2ZERy?=
 =?utf-8?B?WGlZNGRzNktMWmhEYzh5T2JWcS8vUzEvT2xkZGFKR2Z0bVRqVEZsNkJyWjVG?=
 =?utf-8?B?YmJoZytXMDUyTUx5UzE2NEUwWVlvV3g4blI0RGlSTVNYVE1tU0wyTUUzRzJS?=
 =?utf-8?B?TDRJWklzNDRhWkYyamY3S3A4YVVEVzkyQlZYQkxYaEI5cHR1WjlUT3p1UHZP?=
 =?utf-8?B?aStZVXhtQm83dVlvUC94N1hQMWlVWWdqMUlCZUtPV2ViNVNFU0s3aE1HYTdw?=
 =?utf-8?B?RzY2TEIyZkJLUWpUSGJmRlRtZGJhZHhyMzN5WFprTFVkS1lYL05zMzBJVmlj?=
 =?utf-8?B?cTRCSS94OTk0aWNWRVpiSTlnUkdhVmVlVzdpdkVpQnFuSE9HbCtxelp4NS9u?=
 =?utf-8?B?VXY2M1VYeTBPOHBsYVgzZ2NzZUJxb3I0djFvTzFsZTVlUHh5Qk9kRWFqSXhv?=
 =?utf-8?B?QWx3L05mQWUzTjQ4NHoxTVo1TVdiSmxwaG5Kai8vNXhRdTZCK29wZEJzUW10?=
 =?utf-8?B?ZmFkN0pXeG1UWHZKUGk0YjlNb0RrS2YwdlQyRjQ5U3Qwa1BxUUkyRllCdWRu?=
 =?utf-8?B?MTV1bi9teVNBOGorV0cwVDMxdGNTamxMNU1ubDV4Yy9RbXZTTWI3d2JrSVNK?=
 =?utf-8?B?K2ptUzNkKzNyVVg2RUZmMDVYRzJNNFgyM29wR3V0R3dVWkMyaUt3dnpCTUZ2?=
 =?utf-8?B?Y3huSllSN0kwY00vRS9zZFE1RytMMDlpanlvalUzVzdnWVBZS3pOaFFEMHNx?=
 =?utf-8?B?cUdxRkRPNHZXSWlSYjMxRkRxVmdQd1Azb09vdlJxRXpGMjVoYlB6NW1GV3Rr?=
 =?utf-8?B?dGpsZFp0cVY2SVh3U0FNczUxcWJTdHdrSHRWY1VaN1N4NnJ1MEdxbXZxVkpa?=
 =?utf-8?B?NTZRTHQ1K0ttZG15VkJ3aytYeFUzUDU2SEJ3cW9vTWI4NU5scFhraUNXbkN5?=
 =?utf-8?B?U0pSamJJTWtYZ1Nva3hycjRpRjZOMWF5dTFSalVaQnlrUDA2UStsWHl1TU04?=
 =?utf-8?B?TXBtcXRKNWQ5VGYxK2ViSmZITWV5MzNUN3pOTE03bFlJVWxHbEhXdDg2K1o2?=
 =?utf-8?B?QjBNcklzL3JOL2V2NFlGUzZJTjN1TWFNbFlpdk1UYmNIQkhiTmc2T0tnOHM2?=
 =?utf-8?B?eHl1UW0rUFg4eEt3ZFYyL1NnZTFuRDZlNnFPNzJPaVJqZlRFZjI4VzJpZVZ1?=
 =?utf-8?B?SEhOT1BTaE43U091ODBjQlZaMVNLdWVmTGkzdklNb281YVNBeXZTWVJmSmhm?=
 =?utf-8?B?OVFMd0RLTnhKSlg3R3FnVEFNVnUrWGM5TENQVllFM0ZpcTRMOTAzMlJtc1FT?=
 =?utf-8?B?MWxHQzVsdG14TmRvdVBRWDA5Nlk4UEJSbGUxNy9ibjNhaVhQQ1d3VXY1cWlp?=
 =?utf-8?B?NjgxaHQ4RnQwNG12cmpKVzQyY093WUYrajFjdzcvcmduUFc3aHhGK29HY3N3?=
 =?utf-8?B?cXhGdGZldFNZM01UdERBRStpN05zYnNWYnZVMTRFNWw0OFJPWXBmR1A5eFdj?=
 =?utf-8?B?RTVuY0F6QXdpemtUNXppMnNXcVFua3d4UVl2SWJxemVlTjNFUHZLbXdBb3F4?=
 =?utf-8?Q?AvBJi0HfaF5X9INyEVMFBvt75?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653475a4-5e15-4869-84f2-08dd34ba38c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:40:58.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4cr4xWQ10weG81oiUUn0jVyuaKOrJqlQqC/kWmNGxfgjsgJYcAVwneEPErCXIxHXph85LIe6DwI+6D1ZtmpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023


On 1/14/25 14:35, Alejandro Lucero Palau wrote:
>
> On 1/8/25 14:32, Alejandro Lucero Palau wrote:
>>
>> On 1/8/25 01:33, Dan Williams wrote:
>>> Dan Williams wrote:
>>>> alejandro.lucero-palau@ wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> Differentiate CXL memory expanders (type 3) from CXL device 
>>>>> accelerators
>>>>> (type 2) with a new function for initializing cxl_dev_state.
>>>>>
>>>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>>>
>>>>> Based on previous work by Dan Williams [1]
>>>>>
>>>>> Link: [1] 
>>>>> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>> This patch causes
>>> Whoops, forgot to complete this thought. Someting in this series 
>>> causes:
>>>
>>> depmod: ERROR: Cycle detected: ecdh_generic
>>> depmod: ERROR: Cycle detected: tpm
>>> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
>>> depmod: ERROR: Cycle detected: encrypted_keys
>>> depmod: ERROR: Found 2 modules in dependency cycles!
>>>
>>> I think the non CXL ones are false likely triggered by the CXL causing
>>> depmod to exit early.
>>>
>>> Given cxl-test is unfamiliar territory to many submitters I always 
>>> offer
>>> to fix up the breakage. I came up with the below incremental patch to
>>> fold in that also addresses my other feedback.
>>>
>>> Now the depmod error is something Alison saw too, and while I can also
>>> see it on patch1 if I do:
>>>
>>> - apply whole series
>>> - build => see the error
>>> - rollback patch1
>>> - build => see the error
>>>
>>> ...a subsequent build the error goes away, so I think that transient
>>> behavior is a quirk of how cxl-test is built, but some later patch in
>>> that series makes the failure permanent.
>>>
>>> In any event I figured that out after creating the below fixup and
>>> realizing that it does not fix the cxl-test build issue:
>>
>>
>> Ok. but it is a good way of showing what you had in your mind about 
>> the suggested changes.
>>
>> I'll use it for v10.
>>
>> Thanks
>>
>
> Hi Dan,
>
>
> There's a problem with this approach and it is the need of the driver 
> having access to internal cxl structs like cxl_dev_state.
>
> Your patch does not cover it but for an accel driver that struct needs 
> to be allocated before using the new cxl_dev_state_init.
>
> I think we reached an agreement in initial discussions about avoiding 
> this need through an API for accel drivers indirectly doing whatever 
> is needed regarding internal CXL structs. Initially it was stated this 
> being necessary for avoiding drivers doing wrong things but Jonathan 
> pointed out the main concern being changing those internal structs in 
> the future could benefit from this approach. Whatever the reason, that 
> was the assumption.
>
>
> I could add a function for accel drivers doing the allocation as with 
> current v9 code, and then using your changes for having common code.
>
>
> Also, I completely agree with merging the serial and dvsec 
> initializations through arguments to cxl_dev_state_init, but we need 
> the cxl_set_resource function for accel drivers. The current code for 
> adding resources with memdev is relying on mbox commands, and although 
> we could change that code for supporting accel drivers without an 
> mbox, I would say the function/code added is simple enough for not 
> requiring that effort. Note my goal is for an accel device without an 
> mbox, but we will see devices with one in the future, so I bet for 
> leaving any change there to that moment.
>

I forgot to say that I will send the code setting the resources in 
another patch, as this seems to be what you prefer, assuming you agree 
with my previous comment.


> Let me know what you think about these two things. I would like to 
> send v10 this week.
>
>
> Thank you
>
>
>>
>>>
>>> -- 8< --
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index 548564c770c0..584766d34b05 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -1435,7 +1435,7 @@ int cxl_mailbox_init(struct cxl_mailbox 
>>> *cxl_mbox, struct device *host)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>>   -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device 
>>> *dev, u64 serial, u16 dvsec)
>>>   {
>>>       struct cxl_memdev_state *mds;
>>>   @@ -1445,11 +1445,9 @@ struct cxl_memdev_state 
>>> *cxl_memdev_state_create(struct device *dev)
>>>           return ERR_PTR(-ENOMEM);
>>>       }
>>>   +    cxl_dev_state_init(&mds->cxlds, dev, CXL_DEVTYPE_CLASSMEM, 
>>> serial,
>>> +               dvsec);
>>>       mutex_init(&mds->event.log_lock);
>>> -    mds->cxlds.dev = dev;
>>> -    mds->cxlds.reg_map.host = dev;
>>> -    mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>>> -    mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>>>       mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>>       mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>>   diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 99f533caae1e..9b8b9b4d1392 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -617,24 +617,18 @@ static void detach_memdev(struct work_struct 
>>> *work)
>>>     static struct lock_class_key cxl_memdev_key;
>>>   -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>>> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device 
>>> *dev,
>>> +            enum cxl_devtype type, u64 serial, u16 dvsec)
>>>   {
>>> -    struct cxl_dev_state *cxlds;
>>> -
>>> -    cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>>> -    if (!cxlds)
>>> -        return ERR_PTR(-ENOMEM);
>>> -
>>>       cxlds->dev = dev;
>>> -    cxlds->type = CXL_DEVTYPE_DEVMEM;
>>> +    cxlds->type = type;
>>> +    cxlds->reg_map.host = dev;
>>> +    cxlds->reg_map.resource = CXL_RESOURCE_NONE;
>>>         cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>>>       cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>>>       cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>>> -
>>> -    return cxlds;
>>>   }
>>> -EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
>>>     static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state 
>>> *cxlds,
>>>                          const struct file_operations *fops)
>>> @@ -713,37 +707,6 @@ static int cxl_memdev_open(struct inode *inode, 
>>> struct file *file)
>>>       return 0;
>>>   }
>>>   -void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>> -{
>>> -    cxlds->cxl_dvsec = dvsec;
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
>>> -
>>> -void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>>> -{
>>> -    cxlds->serial = serial;
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
>>> -
>>> -int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>> -             enum cxl_resource type)
>>> -{
>>> -    switch (type) {
>>> -    case CXL_RES_DPA:
>>> -        cxlds->dpa_res = res;
>>> -        return 0;
>>> -    case CXL_RES_RAM:
>>> -        cxlds->ram_res = res;
>>> -        return 0;
>>> -    case CXL_RES_PMEM:
>>> -        cxlds->pmem_res = res;
>>> -        return 0;
>>> -    }
>>> -
>>> -    return -EINVAL;
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
>>> -
>>>   static int cxl_memdev_release_file(struct inode *inode, struct 
>>> file *file)
>>>   {
>>>       struct cxl_memdev *cxlmd =
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 2a25d1957ddb..1e4b64b8f35a 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -4,6 +4,7 @@
>>>   #define __CXL_MEM_H__
>>>   #include <uapi/linux/cxl_mem.h>
>>>   #include <linux/pci.h>
>>> +#include <cxl/cxl.h>
>>>   #include <linux/cdev.h>
>>>   #include <linux/uuid.h>
>>>   #include <linux/node.h>
>>> @@ -380,20 +381,6 @@ struct cxl_security_state {
>>>       struct kernfs_node *sanitize_node;
>>>   };
>>>   -/*
>>> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
>>> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device 
>>> implementing HDM-D or
>>> - *             HDM-DB, no requirement that this device implements a
>>> - *             mailbox, or other memory-device-standard manageability
>>> - *             flows.
>>> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 
>>> device with
>>> - *               HDM-H and class-mandatory memory device registers
>>> - */
>>> -enum cxl_devtype {
>>> -    CXL_DEVTYPE_DEVMEM,
>>> -    CXL_DEVTYPE_CLASSMEM,
>>> -};
>>> -
>>>   /**
>>>    * struct cxl_dpa_perf - DPA performance property entry
>>>    * @dpa_range: range for DPA address
>>> @@ -411,9 +398,9 @@ struct cxl_dpa_perf {
>>>   /**
>>>    * struct cxl_dev_state - The driver device state
>>>    *
>>> - * cxl_dev_state represents the CXL driver/device state.  It 
>>> provides an
>>> - * interface to mailbox commands as well as some cached data about 
>>> the device.
>>> - * Currently only memory devices are represented.
>>> + * cxl_dev_state represents the minimal data about a CXL device to 
>>> allow
>>> + * the CXL core to manage common initialization of generic CXL and 
>>> HDM capabilities of
>>> + * memory expanders and accelerators with device-memory
>>>    *
>>>    * @dev: The device associated with this CXL state
>>>    * @cxlmd: The device representing the CXL.mem capabilities of @dev
>>> @@ -426,7 +413,7 @@ struct cxl_dpa_perf {
>>>    * @pmem_res: Active Persistent memory capacity configuration
>>>    * @ram_res: Active Volatile memory capacity configuration
>>>    * @serial: PCIe Device Serial Number
>>> - * @type: Generic Memory Class device or Vendor Specific Memory device
>>> + * @type: Generic Memory Class device or an accelerator with CXL.mem
>>>    * @cxl_mbox: CXL mailbox context
>>>    */
>>>   struct cxl_dev_state {
>>> @@ -819,7 +806,8 @@ int cxl_dev_state_identify(struct 
>>> cxl_memdev_state *mds);
>>>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>>>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
>>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device 
>>> *dev, u64 serial,
>>> +                         u16 dvsec);
>>>   void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>>                   unsigned long *cmds);
>>>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 36098e2b4235..b51e47fd28b3 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -922,21 +922,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>           return rc;
>>>       pci_set_master(pdev);
>>>   -    mds = cxl_memdev_state_create(&pdev->dev);
>>> -    if (IS_ERR(mds))
>>> -        return PTR_ERR(mds);
>>> -    cxlds = &mds->cxlds;
>>> -    pci_set_drvdata(pdev, cxlds);
>>> -
>>> -    cxlds->rcd = is_cxl_restricted(pdev);
>>> -    cxl_set_serial(cxlds, pci_get_dsn(pdev));
>>>       dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>>>                         CXL_DVSEC_PCIE_DEVICE);
>>>       if (!dvsec)
>>>           dev_warn(&pdev->dev,
>>>                "Device DVSEC not present, skip CXL.mem init\n");
>>>   -    cxl_set_dvsec(cxlds, dvsec);
>>> +    mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), 
>>> dvsec);
>>> +    if (IS_ERR(mds))
>>> +        return PTR_ERR(mds);
>>> +    cxlds = &mds->cxlds;
>>> +    pci_set_drvdata(pdev, cxlds);
>>> +
>>> +    cxlds->rcd = is_cxl_restricted(pdev);
>>>         rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>>       if (rc)
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index aa4480d49e48..9db4fb6d2c74 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -4,21 +4,25 @@
>>>   #ifndef __CXL_H
>>>   #define __CXL_H
>>>   -#include <linux/ioport.h>
>>> +#include <linux/types.h>
>>>   -enum cxl_resource {
>>> -    CXL_RES_DPA,
>>> -    CXL_RES_RAM,
>>> -    CXL_RES_PMEM,
>>> +/*
>>> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
>>> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device 
>>> implementing HDM-D or
>>> + *             HDM-DB, no requirement that this device implements a
>>> + *             mailbox, or other memory-device-standard manageability
>>> + *             flows.
>>> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 
>>> device with
>>> + *               HDM-H and class-mandatory memory device registers
>>> + */
>>> +enum cxl_devtype {
>>> +    CXL_DEVTYPE_DEVMEM,
>>> +    CXL_DEVTYPE_CLASSMEM,
>>>   };
>>>     struct cxl_dev_state;
>>>   struct device;
>>>   -struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>> -
>>> -void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>> -void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>> -int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>> -             enum cxl_resource);
>>> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device 
>>> *dev,
>>> +            enum cxl_devtype type, u64 serial, u16 dvsec);
>>>   #endif
>>> diff --git a/tools/testing/cxl/test/mem.c 
>>> b/tools/testing/cxl/test/mem.c
>>> index 347c1e7b37bd..24cac1cc30f9 100644
>>> --- a/tools/testing/cxl/test/mem.c
>>> +++ b/tools/testing/cxl/test/mem.c
>>> @@ -1500,7 +1500,7 @@ static int cxl_mock_mem_probe(struct 
>>> platform_device *pdev)
>>>       if (rc)
>>>           return rc;
>>>   -    mds = cxl_memdev_state_create(dev);
>>> +    mds = cxl_memdev_state_create(dev, pdev->id, 0);
>>>       if (IS_ERR(mds))
>>>           return PTR_ERR(mds);
>>>   @@ -1516,7 +1516,6 @@ static int cxl_mock_mem_probe(struct 
>>> platform_device *pdev)
>>>       mds->event.buf = (struct cxl_get_event_payload *) 
>>> mdata->event_buf;
>>>       INIT_DELAYED_WORK(&mds->security.poll_dwork, 
>>> cxl_mockmem_sanitize_work);
>>>   -    cxlds->serial = pdev->id;
>>>       if (is_rcd(pdev))
>>>           cxlds->rcd = true;

