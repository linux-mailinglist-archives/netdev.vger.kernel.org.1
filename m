Return-Path: <netdev+bounces-174101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6ADA5D802
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E9A7A570A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841CC232377;
	Wed, 12 Mar 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bFaxteDF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2501DB356;
	Wed, 12 Mar 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767663; cv=fail; b=iF112HxCnGcH/wyLMrsz+uY1IayqLSoOop+sGGcDCJpAWWVk5zD5DFitltgRSe7uyFRSN2M8Bcb1Rk5dvfV/HuWtdIC7+2MuZFAVklMdp3/5/L3qdrCdfSE8yAWZN6rBz1AdzlMHhv/KXWcsnl/sxSXO3IzG2ITWE5z4tT+ZMnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767663; c=relaxed/simple;
	bh=ataLTyPU2zpZSVIBLdhYSs9AzIY0N1+QZukgryYMGrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=shG6eDXLpxGGPv6WleOpCXdH6oa60Duz9pMUYkigcwDqWsVNKa6hNwuZrd4D03QKsAQmKwTk/Vvg4fonjfSB9ZL8KYsW89i/8IoFSrotp85iBeSDhMso6Z4NM7QEHVtRkNnd2TQr8mXjq5LF8Rq6z/e/9eX+/w55lgPeGfeo3zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bFaxteDF; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWWK3ZI0ZbavpKeWLYEgXSCxpH5G5tnP7DPPT7Z2vOuIL+4NixMRXmrpCXfy6rB20Wa8OafzCnmLqfCDsnc3IVRac4Ym9QW9TI8yBl+msTE5eak0BGaXVPSR3Y8muAi9gF442Dapnu7xBNlwGHQQkJLsMAokoI0Ai3Qd8NIU1Iz0NrnmyFMprCDWbu614yVyDVDh87d18/QNMXj30iGqAxg/dwu6ncsUlfNewnWc6+yMaWDAL68MhI9lq/PH7hQN/sTXhZCpOpj4pLK2/SMaUhBcG+06bPJxGcKGNL44wM/mPrmi9q2wGPDWnL1XgplGtImSV3tx10Cp8INIkGKE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3MDenagkDtE0Bg9sbxaoO7RnKdrarXmGLOTm+i8mJI=;
 b=fsJ3S3S4wGr04W55kchjvOcspEjfZblEcY/HwYB724t1zkUgyNuID4SwveVppkgZHfey2MNmZ3YmHeGXr1mYoCxC8eJk2/0PyXWeKYLXuSz2h3VO/DpjivoREp9PxFAvwxSPl0tsX8lZJMtTEAw4BGPTsXRO3YHhhoPutt978OrxlrJMvXXXD+hTfFvVPMOco42bOs9uKF1ulabH8FxDSjnsUd1UngErzVPAX0bdCT3cynPRxZaZ/aSS97o2ldZcvggS/AcKnVYc/Q9FYO1P0MNc8IrL2HCD+rREOowSeucUTJNFUFnnQbJOXPxaM9AhBYyHBy+obd8HpwMFXqHxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3MDenagkDtE0Bg9sbxaoO7RnKdrarXmGLOTm+i8mJI=;
 b=bFaxteDFGb4vYk1+dhYSK73550p5hfoxn2WHArzfTlUDfbzB0WIuPneKCof+8sBw9HPL4toicAASEfmAokCc1bluZMjxeoXq8C1nsK/cLRNRuwUy1J9pp0r5aGZHU3Wl6bSvzvZ1lqw6iCblfsmVkeJL1mPQEN4WDZudecXXBTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:20:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:20:59 +0000
Message-ID: <17816473-c2e7-4b60-9595-3935e92e3301@amd.com>
Date: Wed, 12 Mar 2025 08:20:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/23] cxl: add type2 device basic support
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-2-alejandro.lucero-palau@amd.com>
 <bf26b669-860c-493e-8126-733615f47b13@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <bf26b669-860c-493e-8126-733615f47b13@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:803:118::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4b157c-a910-42de-f552-08dd613ed16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVhId2U2dW1iNTFCNUEwOWN0aDFsVW8xRk8wS2w3aWU0VG9lNGRENkMyTDM4?=
 =?utf-8?B?Y2I1ZHBTMnJKV0srWDRIQUw3SVZwdW1HWXlXSUpYd0hKcEpLRkxDV2w3Ynk3?=
 =?utf-8?B?OS9PNG5ldkV5UlplbjFldVhiS1pZYXFvajB2UXNuZUxvOHhlekZtS0puc2R0?=
 =?utf-8?B?TVlIT2pVb0FOL2ZSN1lvUVJpZnd1NGduNFhVY1d0Z3NER1UrSHBwYnRUWURH?=
 =?utf-8?B?RDZuOXBUMWNMZlBHazhrUnZUeUIrM2FxZmtrbjAyakhFaVRNR1hoNWdabDRw?=
 =?utf-8?B?RTcreklUaWRQaVFjeTd0bmVFblFQNisyYWN3M2RoYUV4ZW9tcC9ScmZZcW9J?=
 =?utf-8?B?OGhmOEJkSGlpaUpqTkRJUWsxVTBlaDJnV29FUCt1WHgrMWJieVk5WklwRnpJ?=
 =?utf-8?B?TFp1YTBsT09Zd3V0bDJ4aVR4MW5GSXNyUWJrUzBXNHprR0FvZnJ4Z2EzcTEz?=
 =?utf-8?B?MGFsak5BUnlYeWlwdDVDZDBuK2tZQVE5ZXJUTTZOZWNLZit1cXdtTEs4SCsx?=
 =?utf-8?B?UlFxNFRROXdRRVZKY3pxQSs5bDFSUnVzT29mQVdmR1Y4WUh2STJwOW1IYi9J?=
 =?utf-8?B?Q1ZjZzVYS0pPT1BLSUo1YnpZYWtuZU02L2IvK2lxNHhlUXdmdVBicVJEZWgw?=
 =?utf-8?B?TGRDY0k0akNQL1BWVmtCa05tS2hLK0R3dUFMNXVvVFZ2cHJ2Wis1djhuZ3VR?=
 =?utf-8?B?enl4Y005OEZRQldzWWR4cjRDbk9UWWhyUTlTY05qYi85RS9xaHV3cExma3My?=
 =?utf-8?B?UGw0SjkvemdzZ1hTMVZ2ei96Q3RLbElsYTkrK25hRlRhaFFibTJEcmN3T0FS?=
 =?utf-8?B?TXZrUGpYZHJkam9FVzJyQzBJNC96NmhTeEEyVlZPK290Nm1DdmNUaEJ0SUJk?=
 =?utf-8?B?VmxnTCtBVGJkdXAvTHlVUW9HWEk0aUdXbTRHKzVGSGhiWHgzVStxbUNxUUZz?=
 =?utf-8?B?bG9XM1pPUjhiVGg2dTB5c0dNb0Nibnp1cTFxKy9aNlpjM3UzeGt5YkE4MHp2?=
 =?utf-8?B?eURMeG5KZnlKU05FRExSeHYxRk9PNGZUNkxlMW1aTnlCTWtPSkM3Y3BCQWZu?=
 =?utf-8?B?YTNjQnU3SGZaNXBVM0todERKRlZBaFk2UTNDN0YrS1FsUGl6N3Y2bEVBV1Nu?=
 =?utf-8?B?aVBEWW5MT3FBZXExa2dEZW1pSzFwYmNyQlBOTG1tbUFkQ0crTU9ZWnJjTlMy?=
 =?utf-8?B?SVQvcXZVMTE4Wms4SVkyRG8vWnMzdksrRXJCSmg3MG1oSkttVHVmcGtnYzZE?=
 =?utf-8?B?WS9KY0puek85aGM5Snh1S1F2YUFDRWZZWmw1aUFuZmFrYTdtMHhlRUpzY0h6?=
 =?utf-8?B?UmFLdXJDNk9sOUN1b2hnK3FOdnQzYzdqbFpRWTVrSk5SNENKQmYwdGE3dndO?=
 =?utf-8?B?emxueGRQR1poMGhRVXFjSVZiMy9vMFJTNGVzZDMraHEvcDJEM2NBZmZ0NGZZ?=
 =?utf-8?B?NXI5R0psTFRqbzdyR1JqMTNYOExsaGNTNkduVjQyRG5ZOHN4OHU4L044R0Nq?=
 =?utf-8?B?ai9TUlJqdDJST25Zd1kzWUY4TE9TK0JjaEJheXE4K3ROUEtXaFlHWjVqRlAx?=
 =?utf-8?B?SmdUalZqdUppVUFJMGV2OVNLalQ1SFl4L1BSM3ZUSTAzZVVzeGt2QXJoSmZW?=
 =?utf-8?B?eDRJT2NCWGRTdEJzZGc2VDhic3JBZU5ZdnlSVW90RzdiU2N3SU9yMTIzMEt3?=
 =?utf-8?B?dFhLWmR3cnFsalJjTy9SSUN1cmNNOFhjNEkwZVZLQ2tlRzdobkthWVdjZHYy?=
 =?utf-8?B?bVJNWGhSVklrb21DSHdoMVh1RXZrRVdvNDErbVBLY1l3ZnpmaU0vVUFDT3NE?=
 =?utf-8?B?Y1RITVBmWXpCRFJQSmkxTzJ6MTUwVVlyZldsLzUyd1ZYbUkvR0lyRFNYWXVQ?=
 =?utf-8?Q?aJxN/1rncFrIl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0g3VUhGQnVMSzcyb3FVMFlHSUxyT242bnpVSUhLYk1xRkxkbCsxdTcxeXF2?=
 =?utf-8?B?QllmZGNzRUpMQytDblQ2anJOOUo3ZkVQYkZPNUdVempUT2tKQ2JsSC83bTJm?=
 =?utf-8?B?MHdrN29zSXNXcmkrNFczUWRLWmxLUmFRM0N3bXArbERTK1o0dHlscDdUY3l4?=
 =?utf-8?B?YmlCUFlHeHBEMkx5dS85L001TkxzbHZFQVovaTlPWlY2KzB2RWR6ZTZ1cURM?=
 =?utf-8?B?d2UzbS9YaUVDUUNnd2xZSHd2Tko1NnRhcWZoVmZaeXY3L3ExYzF3elZaeW1O?=
 =?utf-8?B?WjB6WWh5b2REbGpvUFUwV0pKN0d4WVNNa1hYYjhFSy9QVDg5MnNOQ0JkdWtB?=
 =?utf-8?B?cVVFTE5LNWVxUFFJMnVrR3hDR1d0SkFjU1BWUXQ5Snh0RTBCZWxRR2JZNzVO?=
 =?utf-8?B?QkZEM0JKU3VPdFI5TzFPZDVxTjNFYy9VMndIaGErQkJHOXpqWHNLeVpGNmUv?=
 =?utf-8?B?cXdSNzFiRmVKNkdUNXZkWVl3RUlRRFpCRjJlZnVtL3VtWmthUTJRUXV0VUFj?=
 =?utf-8?B?Q29od2dERjBTaE9qdkp2MXh1bVRFL3h2Z1RUNXA3WTdIdS9ZcGF1R0hKU0Ez?=
 =?utf-8?B?QjZyMXZSVXVrVVJKbjNybW5sV2hkRWg5TEZXQXRQbUlXWTg2VnBYQW00b1Z4?=
 =?utf-8?B?dWdtQ2M2NXI4Y3FLQ2I1OVNkaXBVa1NwUkdEL1UxbEhsWVZLZW1GRDdDelA0?=
 =?utf-8?B?ei9VWGhOeUt0UXpKZlFXYUpaWEJXMXl0TmZUKzBReHE4NE5pR1BoQzZwOEgz?=
 =?utf-8?B?NmxQRlpmUTY2cS84a3hFRkJIREZXdmVzWTZDbHJlZENFTUdEOEpvTEJndVVZ?=
 =?utf-8?B?QjNJemJ5V0t6UEphWVlnM1FZZWpHUXB3RUhzVFZyNmxxRVZjUlgzNjhpNFp3?=
 =?utf-8?B?S2dEdXU3SS9LM2Y2ZSt4Q1lZaytvWk5VV2pnNGJ6R3VLb2dJbGtzendNS1pC?=
 =?utf-8?B?UENkaVF1dkdHcmpjcVBTbENuNjlRSkN3bFdyQjhjaTZNRnVuaENxWlJUOEw1?=
 =?utf-8?B?WHVtWGFPd2ZYaXpSM3dTWTBjOWhHdzVOOHlpam9qbk12ald2NEhOeXF4bVRJ?=
 =?utf-8?B?WTFSNHVMU0FyQWtYVXBlUDRvd1p4QXBVVG1ZWGRYVXFuMm4ycEcrT3IrQ2tM?=
 =?utf-8?B?dERZNHpxbmVYYjBDcHNNYmV3cTJoNko4cE1FNFpvVSs5T3AvMlV4dlB3YXhq?=
 =?utf-8?B?cWhXRGJFS3NxaDRPRU9EeWJWZ0ZqQi9SMS9CaWxDZU5HbVB2ZlczOWFmd3M2?=
 =?utf-8?B?ckNiYnVLZ2hTS1hkNyt4RjdOalI0aU9NMndvSVBrNGpzYjVBRzZwRVQreTJa?=
 =?utf-8?B?djZWL3JVQVRabC9HZ1BmTjYxRjBwQngrSjU5UFJ2Rko2OHJWK2RxSXZHMDQy?=
 =?utf-8?B?Y1cya2QzYWEzQzBtcjhiZnFMMlQvL3RqbGMvM3VBR3BtdGFPZE9Ic3EzM3lq?=
 =?utf-8?B?S3JBUXJHTjloTmQ2Mm9tVzNEL0NvK2hwV0pMWUtKbmdoMVMyRFlDNjhocjZk?=
 =?utf-8?B?THhydGdNNXVyeW5Fakg2WE5VMERpbG43N25Ua0ZIV0krelFQOGp5RDJZRjBW?=
 =?utf-8?B?cXFNaEhmWTlxM3Z6SDFYNXQ3QjBxVHgzaCt3a3IrL0M5c3hwNEFlUFVORC9J?=
 =?utf-8?B?d2JORTB0dnRDNWNTWDkvM0lUUThCSFl5MjJGaE5LSi84RlJOZDVlbGVmMllX?=
 =?utf-8?B?TUw4eEROOVFVVFNURldMQzJFUk5DQUJ0L3JhRWloT2kwcGp6Ti9vVGpibVlD?=
 =?utf-8?B?Ky9xMUdWaytEVTdXbnBRYklHZS9ndEdUdWttZFFFY3JLSDVEUHB3RS8zbTZx?=
 =?utf-8?B?ZWdWVW04RHk0ZTRjK0NtZlNDQjN3TWN5M2QydUd1c1hpMXhEYkxUazBDOGM0?=
 =?utf-8?B?d05BQ0JhK2J3anpsOUtZbWpSYWx5TWFlRWg3VGM3VWUyMWx0Z3dXN0t2Mi9z?=
 =?utf-8?B?SVhZTFBxTWpGTVBiS2QrUnR1YVNLRVBKT3I2ZE1POWxCK1BPVkVYRm0xVlJl?=
 =?utf-8?B?dE5PVXFiSTRuYlN2SkNJZEg1Q0tsWEJJbDNwbmlENm93NjRvRm1BOGJnZFJH?=
 =?utf-8?B?N3htU1cvZzVDWkllemNHNWFQNU4vNmxNUTR5WjJ5MEtVN1Y5MzhUQ1RzNUNR?=
 =?utf-8?Q?x5fVdKgSgufbqrNa81HVqZ+UD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4b157c-a910-42de-f552-08dd613ed16f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:20:59.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkiqhkvj45RJlZGFCPZFYcfK1c2bpgS7E+zmOCDtpOQqG8McZDvGGXkeT9OTmv4nF6BKKdFb27Y3MesvdJukgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334


On 3/11/25 20:05, Ben Cheatham wrote:
> On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c   |  12 +--
>>   drivers/cxl/core/memdev.c |  32 ++++++
>>   drivers/cxl/core/pci.c    |   1 +
>>   drivers/cxl/core/regs.c   |   1 +
>>   drivers/cxl/cxl.h         |  97 +-----------------
>>   drivers/cxl/cxlmem.h      |  88 ++--------------
>>   drivers/cxl/cxlpci.h      |  21 ----
>>   drivers/cxl/pci.c         |  17 ++--
>>   include/cxl/cxl.h         | 206 ++++++++++++++++++++++++++++++++++++++
>>   include/cxl/pci.h         |  23 +++++
>>   10 files changed, 285 insertions(+), 213 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d72764056ce6..20df6f78f148 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1484,23 +1484,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec)
>>   {
>>   	struct cxl_memdev_state *mds;
>>   	int rc;
>>   
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	mds = (struct cxl_memdev_state *)
>> +		_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
>> +				      sizeof(struct cxl_memdev_state), true);
> I would use sizeof(*mds) instead of sizeof(struct cxl_memdev_state) above.


Yes.


>
> What's the reason to not use the cxl_dev_state_create() macro here instead? Based on the commit
> message I'm assuming it's because it's meant for accelerator drivers and this is a type 3 driver,
> but I'm going to suggest using it here anyway (and maybe amending the commit message).


The reason is the macro does checks we know for sure are not necessary 
for the cxl core pci driver for Type3.

But I have no problem using it here as well. If there are more opinions 
like yours, I'll do.


>>   	if (!mds) {
>>   		dev_err(dev, "No memory available\n");
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>   
>>   	mutex_init(&mds->event.log_lock);
>> -	mds->cxlds.dev = dev;
>> -	mds->cxlds.reg_map.host = dev;
>> -	mds->cxlds.cxl_mbox.host = dev;
>> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>>   
> [snip]
>
>> +/**
>> + * struct cxl_dev_state - The driver device state
>> + *
>> + * cxl_dev_state represents the CXL driver/device state.  It provides an
>> + * interface to mailbox commands as well as some cached data about the device.
>> + * Currently only memory devices are represented.
>> + *
>> + * @dev: The device associated with this CXL state
>> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
>> + * @reg_map: component and ras register mapping parameters
>> + * @regs: Parsed register blocks
>> + * @cxl_dvsec: Offset to the PCIe device DVSEC
>> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>> + * @media_ready: Indicate whether the device media is usable
>> + * @dpa_res: Overall DPA resource tree for the device
>> + * @part: DPA partition array
>> + * @nr_partitions: Number of DPA partitions
>> + * @serial: PCIe Device Serial Number
>> + * @type: Generic Memory Class device or Vendor Specific Memory device
>> + * @cxl_mbox: CXL mailbox context
>> + * @cxlfs: CXL features context
>> + */
>> +struct cxl_dev_state {
>> +	struct device *dev;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_register_map reg_map;
>> +	struct cxl_regs regs;
>> +	int cxl_dvsec;
>> +	bool rcd;
>> +	bool media_ready;
>> +	struct resource dpa_res;
>> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
>> +	unsigned int nr_partitions;
>> +	u64 serial;
>> +	enum cxl_devtype type;
>> +	struct cxl_mailbox cxl_mbox;
>> +#ifdef CONFIG_CXL_FEATURES
>> +	struct cxl_features_state *cxlfs;
>> +#endif
>> +};
> What happened to the comments for private/public fields for this struct that Dan suggested in
> your RFC? If you don't think they're needed that's fine, I'm just curious!


I just forgot to add them. :-(

I'll do so in v12 ...

Thanks!



