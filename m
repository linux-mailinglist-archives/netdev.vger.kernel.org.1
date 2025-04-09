Return-Path: <netdev+bounces-180963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2DCA8349A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADD51890827
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1C21B185;
	Wed,  9 Apr 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jbro53IK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78821F956;
	Wed,  9 Apr 2025 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241709; cv=fail; b=Oas1wFTH2AmFuhjD1qgE3jV1F5/XH6mN9SmYQ9PX69tguyU4DaP+2TpCz73ab2m7w1S9wC0/OneTOQcUbMfSBVWZIvpGFmARIS7nlX6ee02gfIEiUJH6X6VEnKzKiSs/56kZXSgI56vhIYK4i9a+37/s08jDDJGNryDH2yIu7sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241709; c=relaxed/simple;
	bh=EwTLZyEEJ984tuXpsSKPZ8DzfC9m57Of0UbZ1SMqWGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=baHqH7Xt0h79ERtlQ7qmuVbpWYtaZawMWgar5lyrRzBUoFF9Czyh8za5wqnEpLfTO1prMVxSa9ujwalwNmGBY0AYgKIZp+dsChjL5QgDeBOGcCq++b7fmOD9cTE/kTE0ezr5E6ne+z2r4Ktr1fMUtl5scxXeIsDDn2NdcjZj2sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jbro53IK; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz40K1UajCoiSn6gj17qGly/InhPVzvcX2bkq+PYLOD3qJIALOdY9UtY6OF69vAi0WFwYNEjvj0DRRnjemKwv08oY0LpBiEkL5vW7ERsZZ/lyPtQBXzCAUKB5i1+eBYOrjvkP6LZ/tBEDC0cDGXWihaLKDC/Jlqri1prehQJBoWPSlgwbX/JKErmk1unKn4qanjLO7wxokHUhG+E4z2kfKBhsn+AmFvx8MWO4IWzZG8UHNiAtqib00SDO+LV0D52hFRn0RO7C39FPx8RxYPvG3SquvOdfx8Ikf7rN9kn7w/rdDZAY8OKduFcKUFceICHTit4VKRMo6r9ptfAzRoNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PapD87pgRNW/JZkDAwsUX/iSV0ZGmWVOrtySnI7bhzM=;
 b=Yrwj+68ytbftrH35sWo1/y8h9R3BpNpBa83hUxeSAJbbbuS2gUvGow39q3/jHG1tDldzPQj/h/CIw2ukEdroPszCsj0pVX4Dcie3Lw+eM7P6z8WJk2IKJxCw3ercMH/gvDbqyg3pPNNaTFHliUEnUIMLTra2sRYwMQAkDq0CCmr3Ldh2vjQ1s/XYSaMuUNK0YH71KbFu1dgwrz42Mxeu7vprIBr8wNUkTgZxY88PytCJwM2ewToLutFJjFlf4A30BChyEW5BtRXq/MDrMwWLmGSa8KP+IylL/j1GNMFBVJqV4ryxd4wGas7NaITvjK4eaEHgyTKUXNhZTB5RGShd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PapD87pgRNW/JZkDAwsUX/iSV0ZGmWVOrtySnI7bhzM=;
 b=jbro53IKx2JquSXMEKJR0f9PuKkhGsiIsDr+47DbybAzVLhd1/5lVuwnp+0fWorQB2OkgoEvbnsiDONcH7A1is8allp9O3RGo59ujrwmXU0FGprDaXLX1xUZ8JhtX3R/2GQDoFrG0fFLy84bEDYNKjOSMER5yh85A0zotk6jZGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 23:35:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 23:35:04 +0000
Message-ID: <e30d9997-6fa9-4ada-89a9-0d4dde0fc3e4@amd.com>
Date: Wed, 9 Apr 2025 16:35:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] pds_core: handle unsupported
 PDS_CORE_CMD_FW_CONTROL result
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-4-shannon.nelson@amd.com>
 <20250409163420.GL395307@horms.kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250409163420.GL395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0059.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::11) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d7622f-72d8-4d74-4073-08dd77bf279d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzI0cGQ1cVlzWFJ4a05zMGhzSlBiY2xweVFId3g4UHdHSVl6YnFWakZUWUth?=
 =?utf-8?B?Q01LRDNkRlpIdVd4YWdZVHlYa2J2dm0raGpiZlFjWGxzVGtWY1BRM3UvcGFy?=
 =?utf-8?B?UERZS09rdVJNODg5LzJzV3EyYmNzb0pJMXpjUmRWQ0VLYVNyN3JDR3B3NzVI?=
 =?utf-8?B?VzJibk1Sdk5iZkJKajA5R0NCVTdNU2xuY21lTncwSk5UV05HOVRqclpKaUww?=
 =?utf-8?B?dUdzQVUyMmxFTWgzeTRJRlpKZU1sN2FScWZUVU5nOGdGQk1SRVhTL2dpTTlL?=
 =?utf-8?B?Z1lxVWoyby9zU3lBY2gzUVRaQnplU1NjUTRsR3FmK0NTQmkvdVdNMGxEdmth?=
 =?utf-8?B?Zml6NjlxVlZUei9CUnpLcDRPOHVVYldsdW15ck1hb0wycUhEamVnaEtDWGhu?=
 =?utf-8?B?QnFvaExmNGJtV3JQNjl5d0xKNkRISWkwZC80YjZwajNsMFBkbzhFOVpJVWFE?=
 =?utf-8?B?YmxxQVhmdWJiY3RFc2tGU3ZxbTUyd0JwUUZrTlZVWEphNG5nZlJKVFArQlg0?=
 =?utf-8?B?RFN5Zm5YVXBhTW5OemhNWnFoSDV6Umg2ZDE5alM5KzgySWgraUIrWkRpckJS?=
 =?utf-8?B?L1hlcDQ5L25PUHd5empkeHBBVjBFeUIvenQyNTIzMVczTWFYUHNBeWVSeWRu?=
 =?utf-8?B?eWhUYUNMUmE1REQreFNuWTlRc0JqYm5SMnNRRjJVRG04UEFPckFYNnpwTWxx?=
 =?utf-8?B?Y0lsclJtVHZKY3F0TmJKMVlYU3NPZlBmc0xtc09Vd0RQbCtGU3U2TE5NaUFK?=
 =?utf-8?B?ZUhXWTB6SlBQMlMza1ErQjRiMjdrU3MyZlc4MkxwY3dTMTZyelZiUjgzcEw2?=
 =?utf-8?B?WTFoTXd3WGlaRXZheTNEWEFOQmZoQWJkRm1vSG1uT0czcWRVL0JodWNTeHU0?=
 =?utf-8?B?Uk8rbTBSWENGbnZsc0hJVllFcU11L1V1SHpTbnhMRFlidExXZE1jaCtRcjQr?=
 =?utf-8?B?b20zNE81M3RlajJDZkN3dXJrMktWZGk2VjFreTRPY1dPK0FaRjdYczVldW12?=
 =?utf-8?B?YW1nTmRSdmtnR2xkdnU3aWJ6V2dub0tPUUlDdmpVdVgwYkhacjEwTHc1WE9r?=
 =?utf-8?B?MVFuQ1dBRklxSE5JcTJRdXFrTktSa3NVN1J0MXdLcHhiWEVvZTFZZjBJd2ZB?=
 =?utf-8?B?OWlvWkI3blpEMmhxdzdMQS9tUk9aWDFsREo3VzhXcmg3UE5xeGhmTE5Fb3ZM?=
 =?utf-8?B?TjUzQzlyUGZKYzRBWENqckRSbWF0TFpLVHJWYzY0S2ZqOFRPalhQZ3JDRWto?=
 =?utf-8?B?R2NJREthdUFOMGN1QmNrVURPWUdLNnVsMXFGamdIaGxYbTVwTGVyZUVtV1ZI?=
 =?utf-8?B?OVZXN2tpc3lhU2taSHkwRytYWmtpejAvUUk3Z1ZTRHNIZGFlTjFXTGVHUGIw?=
 =?utf-8?B?NitzWmMvMlNybjIyWW9RSzRCY21VcC9yLzdFUDRqUmZkdlQ3d214VG80emFT?=
 =?utf-8?B?LzZLZDBNazkyNnN5ZEZiblF3Uk0wM2R2dGtYcFhETTdJandncGt6Y09LdTB5?=
 =?utf-8?B?M2R0RDNadmRIY2RFYVlKN1B1cVF3T2lGUEx5NzEvS2NzakVBRW9oMFV2aUV4?=
 =?utf-8?B?R1pES3gvK21IZ3NvTE5Oc3hJREwzd0FJbUVyeWE0UG1MWEpCQjhYRXRCaGZZ?=
 =?utf-8?B?UWNhSEJ6ZmRYbnpMMmdDSmN1ektITTN4LzNoQ2l4N3JJeUNPdjVnVlB6Smpi?=
 =?utf-8?B?VkljQndWbGNNZCtaSFhNV29wR0xYVFpDa2pzOTJSSnhNM1lzSXpwYUcwa1p5?=
 =?utf-8?B?U3p0RXF0OTYxT1VLYzBMc1hTTG5oWjh4TWY0enFST0tucTgrczRLMnc0NVNn?=
 =?utf-8?B?K1ZoemRNNHd5NXdlQjJWUSt2S1ExTGtpK0sycGdBTkFMU1FkUjhHMTI3QnRQ?=
 =?utf-8?B?eCs0TC9SMVFycE9vSE8zRFFZcC9KNkJPWlVBclZ1V3dKMzAxTFg2ajRHWjBp?=
 =?utf-8?Q?teRDyPxk8g8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZ0Z1RIK3dLei9MOEpDcmtnRG55aWlCSmxXRkpGQitDOUkzRTZXbURiWWZl?=
 =?utf-8?B?VFdaRmQwZWY5RlZSbGM2ZGpORUFXL0tFSHZYa1NCV0locFRPT3JZZ3U1aHpI?=
 =?utf-8?B?emRYNFdENWJ5UDd5dEM4cWpyKzBXQTllOXFPVVM4cEFFUGRhN1hKbkloa01Q?=
 =?utf-8?B?T1hzVnZqYUQvT3hzalZua2hvZ0kvQjFuQXo5dE1MaW0xTWtRdEJvYnBaQkts?=
 =?utf-8?B?TDhWcm8vT2duZkR1LzRCQTRteUtpT2x6T2VyWXZpQlJZYWxSK3lVLzk0NzJt?=
 =?utf-8?B?WmMrbzA0dHlaVXhKRit3UWUvU3kxRTdDdXpuNDY1ZGNML3lUZ3g0ZTA3TTlJ?=
 =?utf-8?B?SWw4RVJMK01xbk4vRHcrNzRGZTA5S1FvTXBqZVR2YkxmcEhmd2NIQ3Y3SDdZ?=
 =?utf-8?B?Ri9ZMkZ2dzFvcEpZTWM1VzlDcmZKTVhCWm1EQlhlRk5BcmZnNjNKN1o1cFhk?=
 =?utf-8?B?WlI0SlN3SHRrTTFPbkY4OHJEeEpLT0FwOHAzUlROYms5NHFMRStWVFBnSWU0?=
 =?utf-8?B?VkUvSjJMeGZ6S1JvRkwwd2NjeHRzNHdPRGh5eVJoTUk3ZXU5dTh4SWdFRUY1?=
 =?utf-8?B?MFYwQ3MyZmlReDhuTTl6SmpXQ3VCcUxyaVFFS1R0am5yWGdVNk1FajgrdW85?=
 =?utf-8?B?Uk8yeE5iZ3lsT0tjMHhTa0l5ZDFVamRPZ3pWQ09Tb2hwdEVOM0NFYzk2YXN5?=
 =?utf-8?B?ejZyUkd2cmtaYlFHSnVFOHBOTXg3OXJHVHhLWnhJOWMzejQ1Qitrb0JxaXJR?=
 =?utf-8?B?Nk1yZGYxVEdEcVkvU3pyY3d4N2lEUVJobG0xaStwQWRrK3ZiNXJjUHNudkIv?=
 =?utf-8?B?SGhTWFFHam1aNTNtMzMxY2s0U0lRZVlEMnZNM3UrV1lvUFgrRmF2R0oyOVYr?=
 =?utf-8?B?WmxhVW5uRDdtWWNWVG9lRVZHTFkyM2RUYjh4Q1FBOExsTUN5ellVN1JtMkVs?=
 =?utf-8?B?M1h2TDEvSUZnTDVtTnFXUG13dkhLUHRGeTJlY0VGQVIvb1ZjTlVZbEt4OEN1?=
 =?utf-8?B?TDdaU0pLL0ZabThidGdBd1B6U3ZIL010NzMrcCt1T01vd2gzMlJmOHBTc0x2?=
 =?utf-8?B?dVFUd1Q0TmxBOC81Yy9YWGxEL2cxK1ZiMzhBUDk5SHJ0OWRIM04xbEMyYVVv?=
 =?utf-8?B?WGFuczBIejl1dVBndGY3QnUzTzM3NG9MaExJWHpXcTExd0JWMGxxU3ZUVGNC?=
 =?utf-8?B?dEwxMmhpVTA1VlZiWHhCQ09pZHlmV0dZdjlWZWJNaVFBMU1OTFRRbGhzVHRj?=
 =?utf-8?B?N1kvZkQ1S3o2ZGlEanZwZ1JZLzBXdmVGQWtORmViWWpZaUQzeHlLcDNGUDM2?=
 =?utf-8?B?bmlmQmxxTHBZSXJXYStMYXRLY01uU1RkckIyNHdLMENjMHZlZUk3U0hEUW9X?=
 =?utf-8?B?Y0RNY0tkai9IaHNDRk5mUElDQ1lUMXU3SHcvSXRVUGNQMUdLSnhKOFpKanp4?=
 =?utf-8?B?bi85Y1ZVaHV0T3M5NFZSUTR1dlp5NThPVDRpK0Yzb3JRakVMcVNrVmFkeFI1?=
 =?utf-8?B?eWdiVW5KR0h3VzFQV24vRytXaVZQR2xxaVpHRW80L2g5SGZ4SHIyNFgvSW5p?=
 =?utf-8?B?VTdsN081YXVMYnpJNFJqTkp1YWFXclFBRmtLTTB2cmRObnhtOEFkamNjWk9k?=
 =?utf-8?B?eHQ2YlRGTWxocTBRbXdEY2pHL0RlejlqRzNiU1lGVDZJOTZ3aEVuYk5KYWMr?=
 =?utf-8?B?QzJtdnp5bmFuRnEwYmNCOFI4Z3FJTU1KNFZBbzFnMDYzZmdMVlNSQnVwdGVx?=
 =?utf-8?B?Vys0RXdEdnpNSDA1SnJDSlRjUFVubVVXcnhSYm1qMEhwWEN2YU5pWFgvZmFy?=
 =?utf-8?B?dDhFWFFmcSs2dGI5VkQrV1ViY0wxNHpoNDN4Y0F4VkcwUGpKSXdvcG4wcVhX?=
 =?utf-8?B?cDhwUzNoZVZVUWMwbkhQWUNUNmhRNGwxQ3EvcTRSK2JhdXEzMzZXRlJ5ekd6?=
 =?utf-8?B?MENLRG93amxHMUlISVN6eXpPUXN0QmVOQmlvK2R4U3EyUk5JS2JNcVBQanc1?=
 =?utf-8?B?UDIrcXBnQjVDc251NG9mc0tsVjFjQUdDVWhoNXYvcGZOaDVkZ1pFV1NTUTdi?=
 =?utf-8?B?a3hMb1A4WTNpVGN1aEtOSVFpaC8zQVdCYjI2YkY3eXltSDhtUHlMc0N3SzlO?=
 =?utf-8?Q?hI2/9Sto8PZD3+kjvb0ez7zrC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d7622f-72d8-4d74-4073-08dd77bf279d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:35:04.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kDdNedJadVTHxp6EOfyvEwKwPRaeyj0RnaRlXHJZhGmfNXLHOOipvZG6QYz2q6XBz2fJl/E8g9BY8DLS1G4Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

On 4/9/2025 9:34 AM, Simon Horman wrote:
> 
> On Mon, Apr 07, 2025 at 03:51:10PM -0700, Shannon Nelson wrote:
>> From: Brett Creeley <brett.creeley@amd.com>
>>
>> If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
>> the driver might at the least print garbage and at the worst
>> crash when the user runs the "devlink dev info" devlink command.
>>
>> This happens because the stack variable fw_list is not 0
>> initialized which results in fw_list.num_fw_slots being a
>> garbage value from the stack.  Then the driver tries to access
>> fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
>> of the array.
>>
>> Fix this by initializing the fw_list and adding an ARRAY_SIZE
>> limiter to the loop, and by not failing completely if the
>> devcmd fails because other useful information is printed via
>> devlink dev info even if the devcmd fails.
> 
> Hi Brett, and Shannon,
> 
> It looks like the ARRAY_SIZE limiter on the loop exists since
> commit 8c817eb26230 ("pds_core: limit loop over fw name list").
> And, if so, I think the patch description should be reworked a bit.

Yes, you're right... that's what I get for pushing patches out while 
Brett is on vacation.  I'll trim that up.

sln

> 
>>
>> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> ...


