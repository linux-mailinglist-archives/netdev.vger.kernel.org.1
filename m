Return-Path: <netdev+bounces-179589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD56A7DBCA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E323AAB61
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFCA235347;
	Mon,  7 Apr 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MKESJTei"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC6238D2D;
	Mon,  7 Apr 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023845; cv=fail; b=QL6uH/jDkedqPDHpIrDIFylzrPfV2BlCIdIYh49V7qitMhT6/a1ZOaIcvblvE71/qvYqewD3HbBjDDs26nf2bnjYtlRlVLiJgMAjmc6GHWr3GVJ+HYfZM6mAPdgk2NHbMc0B8ZclcLZ+AhBuVRmp0qf+AY/YlpNQF3s4n3TqXiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023845; c=relaxed/simple;
	bh=e2BKifCNyzAyOYZKHyrbSyfT9lI5I4vaF8hKTi9W1pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fBZliX4QNpHgSfxKu5f8VIArLxigYu2amfknhNZsV4b3hZzRlfTEPhFi5eQlMgt9ds0JUbjPL/MDna4+ayEeaud/AXMeAy/dYtAKkEATyrWl/pz2FsUTGqsiuoBdutxAdDLthif4Y7hnQ5cwm2D57Q4KLEOU2jI+4J1k9SZyP8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MKESJTei; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coRgRet4B3osbaCdCxNx5zsX9OVbCs8vzaPeMDU4vYN/LSqvVm9ZoMwnC9WkHn+HWpohm66oNWPH72zH1ditns/HdybZ9XtFmnYuGrIgEbIB/urn3wwZPHqtje1pudcRYZK3J3A82OVXC44VfnkhkNkblWfIuab8qgp/j+xOg8DO2MTmMyYkHw7BKhvQXR3qe19O/6P0q+7CNjvu+buouSiPeXZQ8vvTeX1rGRbpccDstz8K1tg79Tthy8jCjr459tRrgfXbPVn/6SqiuMx5alREpbxTpOQhk9eW9SH89iZo9OEdmSXMnsGccxnutcXWBxO8kHmhthCnuysJr50pAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mehi8XoHhQoEzEVH5BQmk1czRJlT2VtpBz0gKmmK+dg=;
 b=WQWCIstAvY5yhe3GjD4CpM3P4f10Dm4LWlKLEHUE03GuFyzrHKMy8uKmFzRLDdEfve6Vk9JeJNwIHJwVsLk75ncEm4i53cdDLp0cLYr7Qbi9OBgt7DdLZuSA8BYrNlZ1FIn3IFqaL0rz5Qnwgr0KivsYYA6WJylym05IuCRi2Osq4hP14NHKyxFLeGCreWQTEl2xK9Qx3CPwWIgWCB4P+GYB4OMwEOycuebTJdut53lLI8eVtS/rxnJvPKxIFfkMZiTOTv34bu/XQUjf2pWpsVwXaxvVjpiwAwEYQcpGPLQmfv8dDPIajQNcks5froPcLOyjFUsmlfHvhsKFJh8qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mehi8XoHhQoEzEVH5BQmk1czRJlT2VtpBz0gKmmK+dg=;
 b=MKESJTeiZobay8n+alvOsbN51dhYWfmkLDfcr/tKZCM1StBFTEAz6lNqEiQY1iWcfdYg5B3uT1MK1SRv5VfSpvJbnQ7ecKjNCEZnqXcsIvMZAiQlxX+72ihiUrdpyMl1CYy+3AGSzXtlu7lqgzmqpmUHofpKVSVXluS9/HuLzbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 11:04:01 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:04:01 +0000
Message-ID: <850c92e9-1662-46bc-9df7-15432645093f@amd.com>
Date: Mon, 7 Apr 2025 12:03:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/23] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-19-alejandro.lucero-palau@amd.com>
 <20250404174532.000071b2@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404174532.000071b2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e20af11-d408-4a35-b9a2-08dd75c3e714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2NoRVo5dUhCMjJNb3NNTWY5c3RFSnF3U2JpUTdiLzU5eUlRakE5S3hiVTRz?=
 =?utf-8?B?MmFER1pyQ0JUcklXUUhXdkhSRGZKMWJheEJBREtxS2F6N3R3RmdxWUFua3NC?=
 =?utf-8?B?RExFWnpnNjhrMmtrQXZuQnVHdVdwMmNOY0kwY2J6OW4vbVRvZHd5RzVndU9j?=
 =?utf-8?B?T1lWbm96TFVNNnhyakEyOENBU0JJMmNxZ01iYzBRN013V0lwTmZoK0Noakpi?=
 =?utf-8?B?MW1ZNU1TOVNPai82OHNJWUZWN1hsUUR6MUhTT0NJZnZiRnpZcnA4TVJsczBj?=
 =?utf-8?B?WHowVlN4UHpSTklDWThocnhwOURLSTIrUjlqOVJtbnhqOStjRzkwbVdnWTFp?=
 =?utf-8?B?TlN5bGRLWkxTbHRuNE9GM25HN09xSmthdFdxaXJkOWZXTjZCUmZCcmNpUTFE?=
 =?utf-8?B?TnovdjBzVUZSdWhGWHAwdFRvVHBDQUJoVlRVbTVPdzdsNVZpWFBtdlpTb2VV?=
 =?utf-8?B?SklhWktWRWliN3I5UmczMHBpYjBXUEhGRFBnNzJRUWY3NXZlZFJBb1kyUExY?=
 =?utf-8?B?TTdKQ3RySHZ6YXB3TEVzYzVweC81WmhRY0hRRk1kM3EwN2dmMWwxTGV5UDNu?=
 =?utf-8?B?WlJBMHcwQ0hSNXZVZHZqZVNNTXkvZlR2N2hoallUZlp1Yk9sa2dhQlNqRHRz?=
 =?utf-8?B?RGJBSWVJcCtpWE5UZGhIVmN2TmR4UWZlVkpubEJaYVRBU3g3L1dIWENXRkpj?=
 =?utf-8?B?eHJCamMwengwSVdtRHU1WEFKTG9FV3B6SHVaaE44WlJ4OStwYTUzZ3Q5YlhN?=
 =?utf-8?B?NUgxWVR6VTJsczREajhyODlvakpaSmpNQTJCK2FmUzhrVUpNU1Zld0UzaWJW?=
 =?utf-8?B?OXJWVG5zQmdRR3JBa0VRQkpMeUhrVGl2YmR3VzFabXUrTlAvenh4ODRyK05s?=
 =?utf-8?B?cHdxUUY0c1NCN3A4U09pRUNHaGxqVTdmY2ZIMldtNFJWSHJtVzhSWXRydW1K?=
 =?utf-8?B?MXd5MXhZS0trMmVpNFFoZVFmUWViL2ZUaElQZktpRnRZclgyUFJybnMvSmdH?=
 =?utf-8?B?Wm9VSHFUMU9tenhvTnQ4TmI3eVFJMFV1Z2NvK3JzNjVLQzdJZXVISDlKVWgr?=
 =?utf-8?B?WSswSGk4cXVRMng2MGIyeUIwNEtQTVh0aGtYOHROVm1qdGJHMmpiWnpoQmIv?=
 =?utf-8?B?NE80Q1I3MXA5bjBSTzk1Skx5dmJENWkyZWxEc0NQZE5aa3UrTGVXakZpRExQ?=
 =?utf-8?B?ZzBFYjJBZkQyRjlqM2xaY1RIalV1S1N6VmhMQ2NnZVRVeUdBeGdqOG9zMVZk?=
 =?utf-8?B?WlRkQkQzcUQ5TVVVZ1RWV2lNWmhHTFN4em51dmZoL2FYMFNsU2prZktQME5D?=
 =?utf-8?B?b1JYRTNOQmExb1daenVDdGlIdjBTcEJqdmljZDQxYkhYdVZSeEFtS2xsV004?=
 =?utf-8?B?SGpIb21oUExiTW90Y3g0TUt3dnk1Q3c5WmZKL1djRHNINGEwTEtVSGFkdWh1?=
 =?utf-8?B?S3NkY2xHMVZlNzk0S0ZZRDd4SElmWjlFaUloQzB5b1VydlNRQWUvT1B1TENJ?=
 =?utf-8?B?Q2FFNGRJSEVxVGNvZnNWMm5rMFhxMkgwMmM1Y1JWNGJCTkVmc3g2SzhoWElP?=
 =?utf-8?B?UXRkTHdIL2VCbWZqWExuTmdJTE1wWCtSeWVobTRiZDVoZDlTUGEvMDJacGp3?=
 =?utf-8?B?Qmkva2pvUEhmUWJtK2NxZ1IxaVNTblpXTGtZWllyc0l3bTJuL2FGNHRUTFFB?=
 =?utf-8?B?V2hwWnZ5MUcwSDIyNjgzUHBGMFFQdDg5OXJVR3V0NEFYcGNENHM0OGVORm1V?=
 =?utf-8?B?V0c4SlR6NEJmcHg3b0xGQXhGKzZsSTFVc25PUnlnWGFNaHg0OS9hUG9JY1dw?=
 =?utf-8?B?eW5sbDFUK3FWdE1oeHE4c1Z6bnlLZ2VsWDA3cmFGNE5vd3A4OCtlM1NVaDJV?=
 =?utf-8?Q?gQL0gKIkXSsjb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0M4bUljb3o0OUZwQnExbHFPd21sUmVOTGwxdVNpRStyWUhLRzdZWkUvcnM2?=
 =?utf-8?B?Q1F4TVJROG9PVjJKQWI5TUJ3cEFHWVZFSWNVSzFNZXNLUEpuMXFQY1hjTXhh?=
 =?utf-8?B?cUFwTWZ4bndTRUx1SlhUbzhhTUlFak00RldNM0Jpb2IrakhyNm1uK3lNNkU5?=
 =?utf-8?B?OGN5WDdiTTdIdVRjdWV3a3VLbjA2eXhwR2tVN011dXRqMTh3eE5zMmRtMWNP?=
 =?utf-8?B?bGN4WVAzaFJJVGRQKzJXMENNeE9SNXRIQy9HbTlWQzFwQXVKV2JyV251Z2Yr?=
 =?utf-8?B?cWxnZEVDSVcyS0dPVzVKeTE0Ny9GN2VMY2x4YlErWVo4OHR5SlRNQVF3UDha?=
 =?utf-8?B?ZE5QdjZ0T3pxMmdjMHQ2SGZSVHUyVU84ejQ5V09XRlorem53VXJtV1JSTzBy?=
 =?utf-8?B?NytlRmtKaWpWdWE3TFlJTlFIWTFlSklXN0phRzRwdHBpVjJsSVZQaGtwRTJI?=
 =?utf-8?B?eUcxTkpjNFlXYk5xZU93TVFEZXZiWHFxd3V2eUhTU1FtZ0d4NFRrbmJhUWta?=
 =?utf-8?B?WFJqZVV3TStzd0hRQ0o1Q2RHNHJpUG9Melk1UnF4bTNLcnJNWEI0UVBQTGlo?=
 =?utf-8?B?WUVWemhENlppZ2hTVWRqRkZLOFduekxJZk11UllPeWM4a0Fhc3BaSndMVWZt?=
 =?utf-8?B?Y0trZkpFTjZCQ0twU21iOXFJY2pyRmJkVnp2NCsyMkx1dzZhUGVkd2tJeDM4?=
 =?utf-8?B?NzZ2QSt2YlY5bDlNcWxNc2ZHSmdvZkk0YU8xSmpUR2d6amRmemdSYXNSRTF6?=
 =?utf-8?B?eXNERUI2c2k4eDJvQ2tXT1JwMWtiYTI2eXM0cUhWVktkU0RMMVBKUGwxcEtr?=
 =?utf-8?B?MnNXTG50UlIrUmM1c3ZZUXB0akpvNXU1SGwyVi80YldXMWR2eFBnQ3NXRVdy?=
 =?utf-8?B?bm1TeGZmQ3lBdGdQUGVPYllOYkNaVG1DQVdzanlYeUVGNEtpd3l0WklRSFhu?=
 =?utf-8?B?aUhJUVZJdmtNekNVK2tQTXZFWTZPQzB2RjM1eG9leW5aRng0OWFxVXlTTG1o?=
 =?utf-8?B?bm92YWJ3UFdBak9GN0hZWTFoZTBnaEUzbnYyTmRJZmNkdXl0Q0pXaE14d3JC?=
 =?utf-8?B?R2xRaXR4c1Vzbkd3Uk8rdnAveFUybVVVbDNCRko5RHdGbVoxMm1LdUVoMEl6?=
 =?utf-8?B?VWkvN3g1QTc3ejF0Z1MrRytJMnh5ZzN6WWhnelJOZHJFd0NjcUxmMTdjL3Fz?=
 =?utf-8?B?dXBaR2dwTGd4RGFSOGZ4SXFFOHc2V0V2OVI3cXhuUlBVUy8xRWZBMDk3NGRZ?=
 =?utf-8?B?MElWeVdlelBkTVB0blNWYU5JRFV3ajVHS21TRlUxQ0lsOTlNajB0aUhqcTBa?=
 =?utf-8?B?dUxoSVlQcUQ0ZUVzR3dIMWhONDBTRW9rNEQ3WkErZEN6QXB4M0N3UUhHenRG?=
 =?utf-8?B?WkxTbEIzdUs4M3loZzZSb2VYSkFONytwYXprWHRTU2NZZCtBS3Q5T1c4aE5y?=
 =?utf-8?B?OHJpSEhwUUl2RnZMZlQxSnp6VFBrSWxVZk5sYkZyYzI3UTVJV2NVL0VNbmVP?=
 =?utf-8?B?bU92djJKRWpWZ2ptTkx4YlE0clYzQ29BblVDTnhTOGxCQXRIVGN6c2JkMmU0?=
 =?utf-8?B?VzlQUjN0NTFSTFdDeURjdlp1RXplYWNha21KdFExNlhSV2l0clhXSnlKYllq?=
 =?utf-8?B?blNoWC9kYUxlUmUrYTEvbkZOS2k1WVRUSS9SVWR6SHNURmRZK05XdVRlZnE1?=
 =?utf-8?B?YVJoMFB0QmdpM1NJdmlrMXRremlqY2oyVlRyWTk2ZkE1WEUyMWpXNkZxSjVM?=
 =?utf-8?B?aWlLRmhoN1NMNDB0NVJzaVJQMlFIQnBzOTVSVFNtQzdnV0tGdlQwQ3FWbmor?=
 =?utf-8?B?OU1QYjR5Yk1CSXdFb3pNYXd6QmZQdDl3dDkyN0gyUWZPVVRxUVltV2hZMzd5?=
 =?utf-8?B?Q3pXWlBMNUw4N0N4T3k3aGx5VkhMZEpLck11UlA4cEYxazRPYVlPOVpJOWhB?=
 =?utf-8?B?MTZGOW05UDVoUjRMVThtTjltSGhEemFjUXhUT1ROeE1CQXgzeTV4OTR6TTJn?=
 =?utf-8?B?N2xEZWRuT0syYkpzODJRRmlBVEtsdUgrSm1PWktpQ1ZXQVFOckUzd0FVQjhY?=
 =?utf-8?B?Vmg3ekI1dXRnaloyMDhWL0dvczlPaUhTYVhpMno2djVLbjJSRU10akpnZ1NQ?=
 =?utf-8?Q?40duO1mjP4lVus9SjmotPxwSi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e20af11-d408-4a35-b9a2-08dd75c3e714
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:04:01.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21LZlTtw6TmtIROSbtZxKAmVkY8nk/XFdMUmFbHLq2yk7GC5FYE+GYUFjeCg/XIzC6HOplYB7GqbCj1PnHUAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281


On 4/4/25 17:45, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:50 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 135 +++++++++++++++++++++++++++++++++++---
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |   4 ++
>>   3 files changed, 135 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 892fb799bf46..f2e1d5719a70 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2310,6 +2310,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   	return rc;
>>   }
>>   
>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	int rc;
>> +
>> +	guard(rwsem_write)(&cxl_region_rwsem);
>> +	cxled->part = -1;
>> +	rc = cxl_region_detach(cxled);
>> +	return rc;
> `	return cxl_region_detach()
>
> Check for any other cases of this.  If we don't clean them up now we'll
> just get patches form those who run scripts to find these and that's
> just noise upstream that I'd rather avoid.
>

I'll do.


Thanks!


>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");

