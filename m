Return-Path: <netdev+bounces-165207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26FA30F45
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6307A148B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488E2512DF;
	Tue, 11 Feb 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ungWO8mZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435123D69
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286564; cv=fail; b=E7Xipc6Q1uF2TmWCcwASZhMRsil+MjUzlV6nF9N0RlNeebi7QYDpI9nEmQV8AOVr/E1ca5AtqgGDcOhGOowf+AHoaulzqGns5l0h6vxfy5Tb/ZpZBw+AfW650NFN2+nuGOAwviWPi7FrqsKcB7OOhSKsAwST1aNN1rqWdcBagOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286564; c=relaxed/simple;
	bh=34sXKA6fUmBhnsgDe7AlWGyUpxSLmg7+vFQ+efu2WWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2YSv6agE2nxXPXfIoPFKBog2G1M0EUE3CaOPxfTr5qh5+uM9pv8b8wkdCfuoHIHaF7Odt1qMtMkQ1nDcLP3OBnmt2/WjqmjvMPiJjWhiK5ZZUNbBrQX/FafFZzULAeQAgvSd5OYwtWvgN/kdJK0SYFWPDf7Y/1NApnSngNWCfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ungWO8mZ; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlZWMrKZAdY8zFzfI1oNJNl6jIVkOgSuoVPBQUj6Yje8rH8/qXIJmJT35pwo7+/ENa9+GzECASPJWolc8pbKc9nWwJM94MrXS5Or0MZlirA4QM3c6dzG/Rm8Tq6j6/d5O5+HHP1pooL5zegycmaNgeoy7qBXtKQAgqMn7z1P0UA0TqJuoWEASTS7TzGKgPrK9XPFMj3YAF+4azasTHOq1TSkPab0qXdPxj466DbNn3fj/Rm64xug3n6xf051BI+1OzRiKlOevbXjNwRnXqSJ6yKgQOTZjCBtZ9BgY5mIQ0s7L6pGteH2KxIb6sawe9TPzDQOTXf1k6fMyaw/Ru6uDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbfmyJEB7kZPgZ56cv5TubF1WqCRvlPbE4S/IjXs4bM=;
 b=KzP1YQa4dFdtbE7Nc0d762AePewitsmMt3FfAlVzdEnUaoRSRBKq2/CeQleH4+yYS9Y8Sw1sWJgz2YEvC1YMB7po2vWku17pOtrnVuj1o/bjwz5da78pfQ7Ww+K5f/Zx/zJxfNd+bv5zuXNzCliJTkrYEx9Z3fhZgmvfN3pD4oOiq+MapKp5f9CzxCgp+6p8VpPFzlWSCE+fuO0xXx12ScvHhIc2eUIv/iTXH7QteeuR8zJcD450SAIh4Z++5m7w7W7SV2tDwtrtZsKm1qyRUfigp9kkuhsEWdCAGqCZgu2ST1Vi3vO9ZQTP9HVrpqiHrXgTFFLiUkMAyQMqVvGsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbfmyJEB7kZPgZ56cv5TubF1WqCRvlPbE4S/IjXs4bM=;
 b=ungWO8mZeV1DkNbasviybRDeXBQqvj7N36sX32it9CapXrBv4WaQWyQ65UlaZwXcm3dzjkxul/JGLSz1RypKHNj1l4+H3g608KJUbmkrKzIUmvfztZyGJSIuf8i3/loUaY+uMkUdeYEpEywIhekQYLaRANSAhp9eaThnNYz7JeBMtHiIRaZbZz7ol9ZmDQaohsuCQ7xEC3lp0ZnfsBDnheUJbdPgHQxzU3DvywXxLC+25msAId4fe+L63XHgCVeD+bIuHSzFSOMvI5rypxu0lal09wq0+B4Kfi5nsnShsKjuZGoMF+eDkLpAl8AEGVrnIW7Bgk0fw2+6q6NJvcnTzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 15:09:21 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 15:09:21 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v2 1/3] posix clocks: Store file pointer in clock context
Date: Tue, 11 Feb 2025 17:09:11 +0200
Message-ID: <20250211150913.772545-2-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211150913.772545-1-wwasko@nvidia.com>
References: <20250211150913.772545-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3218b263-fbd3-43b0-d203-08dd4aae0fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGNiaUdZV1AzR00wN0hjMHY4c2VaUlFHcmpBYU1FZlRkYktBNy9pcVllTjdT?=
 =?utf-8?B?Y3pELzhrL3BuMDhDRmc2V1VWdCsxbkt6bFh0alVSVThIWm9Gbmx1Rkoxa0o4?=
 =?utf-8?B?RHpFcE5qV0Njdk12c0N3RlNmMHJ4RjFYanhXTDhkaUVDSTY0YzhDUkxvd0VG?=
 =?utf-8?B?cjBFbm9Xb0t3amJFSmsxZTlNaUpIekd3bnk2MUJRU0tzSnhNQ0M2UUVhKzd0?=
 =?utf-8?B?N1lGK2NkTGhmT2ZyU25jVzhFOU5BYW1uS1RJUTl6djhGb3NNa0krRjlpeEd3?=
 =?utf-8?B?VnVPbldRYnRtT0wzSC8rc0hUM1NuTHlvdlJ0d1krdk0xdUQ3dC9pZnNyWGtC?=
 =?utf-8?B?aWNxcXdhSUFXQ3JhUlRVUUtaYWFuL3MrZDcxNjFDNGVTd1VON1ZnWXFhUU1a?=
 =?utf-8?B?SnVVdjdnOG9ndFdEdlRLb3UwMmE3YndlcW5KbElLQi9HZFZhaHp5Tm9ua2p3?=
 =?utf-8?B?M0FXTS9wZHczcHZKSEhPbFplcUIrOThZUDQyN2hMa3JNQXloTFNzanVud0o5?=
 =?utf-8?B?cllnL1pWSDZNakV1ZGtwV0g4bGlXREoyU2FjM2VhVUtlOFk1UXpXZVpabExi?=
 =?utf-8?B?Ymp0WVNNR0pGL3dFL29ZNkhQZVU1UGFKQzgxZlU0SkN4Z2VlYTNJcFMwRXMv?=
 =?utf-8?B?OTMvM2Q1bEYwaU9xZ1pzOUFKRGc4UGJIYm9CeHM3cmdUOUVWcFh2QWVHMTdE?=
 =?utf-8?B?MElCNVRLUzNYeloxUDFYcFFsYzl3ZDZ0bm5aY0NLNXhDcWFGdjhGNGxqMEd0?=
 =?utf-8?B?WWVlQ2lCK0k3T2xnTnJqWkRIWU5ndVJrKzZKa1dBaHg2b2RLcjRqSjhaZmdk?=
 =?utf-8?B?ZitrQ0Ntc2lweUhvUXZaNjFTalV2aHJGZCs2M2VkbytTbk1aQ2p5YkNWOG9R?=
 =?utf-8?B?Qk1kOGQyWkpyNStvSTlzb0tzckdVYkE4ekc4NzNLOVo1MEFLRjVYRDFhQk8y?=
 =?utf-8?B?d01rN0o5MEtqMFordmZ1Um5OVDdoRUt5Y2RLaldISjlRYXhTN1FvcitJTlI0?=
 =?utf-8?B?QWtyVkVjZHR3RkVaR2VNTFZSZEJ3WStVdS96cmc2M1BMVThyOEtiNWhDaUZD?=
 =?utf-8?B?N29YdDZod3ROclhHRzIvTERBZTZwL0VsWTczNVZ0Vi9LVk44Y0ttRytGRUNN?=
 =?utf-8?B?em5KU3RzbmVHREl2NXc2U2E3UmpTYmVnaXJlVDBCcUo5OTlaUGZLN0ppNnZq?=
 =?utf-8?B?TkxqZE51V3VMbTJqenR0TUh1Z2xueVpOM2NMdE84L1NMaVNtOGt1ZWwzOXRV?=
 =?utf-8?B?YTRNNkdodFYvaDk0QXRwclMvRkc0OGlsd0JlOVBWaVE5ZFBHck5xdnNnTDAz?=
 =?utf-8?B?WTZxU1UxMWhPN1lycU93V2VheUx2cVVUT2lGMWtyZzg5L3J6VEgvQUlDWTEz?=
 =?utf-8?B?OG9yNVBRK3BDL1dwWEtadUw3aVFRT0lKV2kzd0pLZ29GVTdOdWFSbW4wSjh3?=
 =?utf-8?B?R254dVNCT3ROSU1VcEdiS1NvWktjdmRkTXpWVEMrNkZ2T3lGVTRaOFlxOW83?=
 =?utf-8?B?SDNwaHR6MUJzeW5TbDFtQWVUNjRuQ1BFWFl6SUd6amdhRWtvdU41K2NWWlh3?=
 =?utf-8?B?WFFNMjlLdnErbkFqUngxcWhxUjhIc0NZeVNYaXRVcmZzd1Z5VUtMUkNSSTFD?=
 =?utf-8?B?dW05cEpXWHh0SnVBQk94Q0NUbmZrOGhqT2h1b1JLcDNuR3N3OWlLUWlveE1l?=
 =?utf-8?B?Z2hHS2E2S2lLK1ZaVnBBdWpKS0V5Z2dWVEZWaUtHMW5XaWUvUWhkYXV5QUVa?=
 =?utf-8?B?VkFIYzVhMUp5c1pZME1XbHI3S3l5dTQ5elRpWlN3eDRyWk82WmJhNHZyRkJm?=
 =?utf-8?B?V3ExOXBSaUVSUEsyWm5MUzVZMS9JYk9oNlMzVW9BNno4U0ZLOFFnVm9aRHpw?=
 =?utf-8?Q?ffzWaM5C2OcQ+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2JLVkNzb1hlb3RxVXhvc1lvTmV3YWNncWJvWnFJTGNERTBTUURtS2VXSE5I?=
 =?utf-8?B?NllLVm05dS8vT3RCdzZGTDhIUnhQQjMyOXNoNmI1RllRMzdxK3ZaOFdlZ2FZ?=
 =?utf-8?B?U1VuR3dWbURlV3hPQ0dhTUt4R2FsZ2dKNTZYQUxEMStMNDlIK1ZUbUVHcW9H?=
 =?utf-8?B?dFZDbUcwSW1RYklyQ3E2NTFRdEhsZ1dlUlJ6QUR4UGFObW93M0hMRXRib0ta?=
 =?utf-8?B?M05yN1Y5dkNnTk9LVWV1K2l0SHJjT2FKOXFFa2djT2IzSC9VbHdWenpoQmRR?=
 =?utf-8?B?OEdac3gyTjlqbU9SbHlFNjNGTFcrVFV1T3REY05PNTM1anV3am9JeFNNaDdL?=
 =?utf-8?B?NnlhYTNaUHFEVzl4UlEyNGNVSDU5OG43eSs4QXUzRlNUS3lydjZJOWo4bUl1?=
 =?utf-8?B?cEZWK1NoMS9VaHU0c1cyYmczUTN1c053YzIwZzhEdElZTzB3ZHR4dkprMVg2?=
 =?utf-8?B?Y2ZicFFpelJMR05FVkFkcUkxZ0dYTFhkYnN0eWRCdnZOQ0Fld0xnTHhNaERm?=
 =?utf-8?B?RTZRK3hzdFI0ektadkdZVlh3dENEREJCVHdIV1hKTEFva0VkNDRjdEZhTG9y?=
 =?utf-8?B?cXdEamVVWXJ1STNsMEZFSFhsQVo1QnNCeHlnUjJ6dHJJVGFtaGNmbGlKVlJv?=
 =?utf-8?B?ekYxUUVlU1NoRDRPa1BMOXlFaGdRaWtPVERUbS9tTlRkWWRsQksyU0lyMWE2?=
 =?utf-8?B?UUJVZFAwY3M4eUNyL2t3bDJrYy8zOWJSdkM0U29WdndWZ3MrQnRWQ2phdUdZ?=
 =?utf-8?B?Mm5ZVUdYMWIwTUhpTVRud0pQRis2Tk4xZVNsK3ZFZlBRU3BPTm1aNG1KcXB2?=
 =?utf-8?B?RmdERkUrbUlhdDBib1hOQXIrY2JNM1FkUnRUYmwzbXowUWFqWjNyTEF0WFR0?=
 =?utf-8?B?VllmT000VWNpYnZpYlJwakZGa3A4eTNOK2JYMU80RjUzMzREVEFSZ0VjY2x4?=
 =?utf-8?B?d0U0RFpwd1hydzRkeDllSmczdWQyUmtZVlluSDI2Q2t2NWowZEIrRGVqRE81?=
 =?utf-8?B?WTZxcVdDcmxpVGdZUEo3aVp1UVk0OXZhZFBnemtRNFhhY0RESDlzOGpkRlBP?=
 =?utf-8?B?ekxoRS9NWE1KU2t5eG82emxqeE53dEdaaGVjWk55K1o5SkZlVm55bkkrazJN?=
 =?utf-8?B?MWJvZG5seVVDWCtWUEpxUUVJdGtiZUkwc3cyU3RrSFNkS3RrNDRhUjRmc1RW?=
 =?utf-8?B?WlFyNWRNNldJTzI2WDJWdFNYVE0vdmtwVzRVVk1KbHZSQWV0b1RaMFIrNUZD?=
 =?utf-8?B?anVRRmd2MXpiUGhwY0R3eGYwQnBONWs1WjNqUm1rb0d0TnJWbkdFZnhkeW9U?=
 =?utf-8?B?TUsrbmovSzByUm8vRGhnSG1FM29TRW5PeDBXMFFrblBSd3RDZzR0T0VYTUZn?=
 =?utf-8?B?WE01RVcwNEJWQ3dvM3JSeXlVRmFuS01sQVEvTk5DM1BLMGM2WVFybHE0QW9X?=
 =?utf-8?B?aHB2VzJFOHEyRnpkckdqNGFLUUdnZUpEdE1nd082eVlDZFY1Um9mSUFNQjZh?=
 =?utf-8?B?OTF3NE9LQXhMT2dTL0cxeEtiR1BleHJPVEhGdVB6T1F4TUtLTFNMMm5QZ0tG?=
 =?utf-8?B?cGNmbkR6cTRWdGRPVGhYYkVtenRJY3l0L3ZpMklTbTdxbXZCL0MrdmRtMkpG?=
 =?utf-8?B?cUMvZzJOZmNVb1JCZFpjVFF1cHhuZmY0SkYvWVErWEd6T0sveFhPOTl4aW1z?=
 =?utf-8?B?cWZuaU54K1RTbkpqbHZpeTc0WXcvNzhlMEUzS3J6KzB0SHpKSDBkdmpxVk4z?=
 =?utf-8?B?c2swOE9yNXhTM0hNUXp1Y0UrbWR0R1MwZWhnd0R1TEgrVWp6MGdrMTRjZGNu?=
 =?utf-8?B?SmlCelpub2ljYmhzSTlpaEJBYlMvVDFUMGFIZFpiNDdmaWdPU0QvUWJmOWxR?=
 =?utf-8?B?Mk8wTDYvNmVWakRiRHlTSVM3OFRNRVVpbCtjOVorYUswNFhvN1huVjBIb0hO?=
 =?utf-8?B?TDB5SkJpMDNNWUc2RllzSFJJWWMyMEVnUW12SmlGL216MjR0V3BMNEp5all1?=
 =?utf-8?B?amZheHd0eS95WjUwUDVvSTFMSjhFK000U3RwY3B3TFd6aFk2a1F0SzRwd0tS?=
 =?utf-8?B?TTVDa0Y5RjUxNU5VMXk3UmpoYlFnb2VMbFE3QXdiS293MlprNGNhYkppb3dn?=
 =?utf-8?Q?X4XMrd0JAJqbM5fj/z8XKD4uz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3218b263-fbd3-43b0-d203-08dd4aae0fe9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:09:21.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28ncL7b4Ayvliz0xe2BfxL8ik74xb5yp1jOV13/Lpn3rG6z7bRhxfZLaCZyfxtA4NiuynA/yLAQdYQ5QJw+naw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

Dynamic clocks (e.g. PTP clocks) need access to the permissions with
which the clock was opened to enforce proper access control.

Native POSIX clocks have access to this information via
posix_clock_desc. However, it is not accessible from the implementation
of dynamic clocks.

Add struct file* to POSIX clock context for access from dynamic clocks.

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 include/linux/posix-clock.h | 6 +++++-
 kernel/time/posix-clock.c   | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f48920..40fa204baafc 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -95,10 +95,13 @@ struct posix_clock {
  * struct posix_clock_context - represents clock file operations context
  *
  * @clk:              Pointer to the clock
+ * @fp:               Pointer to the file used for opening the clock
  * @private_clkdata:  Pointer to user data
  *
  * Drivers should use struct posix_clock_context during specific character
- * device file operation methods to access the posix clock.
+ * device file operation methods to access the posix clock. In particular,
+ * the file pointer can be used to verify correct access mode for custom
+ * ioctl calls.
  *
  * Drivers can store a private data structure during the open operation
  * if they have specific information that is required in other file
@@ -106,6 +109,7 @@ struct posix_clock {
  */
 struct posix_clock_context {
 	struct posix_clock *clk;
+	struct file *fp;
 	void *private_clkdata;
 };
 
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c..4e114e34a6e0 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -129,6 +129,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		goto out;
 	}
 	pccontext->clk = clk;
+	pccontext->fp = fp;
 	if (clk->ops.open) {
 		err = clk->ops.open(pccontext, fp->f_mode);
 		if (err) {
-- 
2.39.3


