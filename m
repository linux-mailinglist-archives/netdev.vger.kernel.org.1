Return-Path: <netdev+bounces-204188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE2AF96A7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA548739D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026061D7E37;
	Fri,  4 Jul 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LBEMPx0I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF319C54B;
	Fri,  4 Jul 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642515; cv=fail; b=sPkpUYVVhJbvuxFg0kZXWNebgaiiBmgb+Qw0kh/41rpslMrBggW6qF7vy/1dbSwXIBsmy0KnZP8s9qO0ErNTEC6YmuF7T9xpcL3Oqnb4iiV5G6D2Tk7Jmk7lAp4CvX3QxbFpNW2XCPtHLEycgZjFjnpoSD5s1vsBbYAqbeN8epA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642515; c=relaxed/simple;
	bh=c8XiOBnTdNaK/v+L0u3va6qEBaLDTKbEBQhLHUXjicg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vu/zI7k8i+7F4VJLb4FlwAhn757dRwk+rVvBr56I787S8Vqp8ZWNov+z7W/ZUiSD6z5YdXCUbFHcJ6rsqczEZLlcSMhOH2iY1m7MWTgAhWumJGyGW59FDmmZSegJQJkUJfPeJHLDHbSs4ETr0ciLAASIvvqPOdThbFqnk0f3ojg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LBEMPx0I; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu7cd1eR8v1kRpA5wKCd8TVE45Ki1/JC5tL/X8L/PufQzRquAM7UqVHp12qxHWrjK4/vyMU00lAJ0NdNJHlJX3QCE9WUiBYppR25uj72mcwWn3Jaxzx0fKC+LHfxQG08CC3bDhsWhE2IxqoVjWthjz4PulYlo37rMQA5PXfHq+e87v7xyT66zPDuinx4twHZ6aDPBm3dfJx1ACGQ6M6fTTQ6B36SokmOh88krrCjbXciLNoipU/VHw0NsedxgnhUh48TKLn7wr4P624+gnBGl3L+jM0TMmJQuxDqpqwCepYVXTKsgZi5QLfmMKn/4k7mLzYhO/CYifuqPQHm0SD8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZM+v+4Ga6jgKDozGq0dQeQHk5t0f0sAUCXa7NAR1Gk=;
 b=Acn9LAIg4nqMJeJZHwu1xZ3JwDzArg16xXTzbAEzQgaEFFh2kJIlXfX/beLQtmjDNid3FFqm1RfopRBmXGm0SB3wwTfEz3QLV4funaxakcLkdUAZ0Xn59FXK3wH+tB07Yb8VAl/Y/E+7I3t7g6xTOnRpuFC1MhKMNGyqJv/KD66sANxLbsIuVY03Z3I8FhaxfZdhpppPu8JbeEuHX2OszwuR7HHnJolGm+zyXXJEPT7Wta2Zq7ZXodeKxthpXIK7ej+V74Xtyny59DiDyLHUBUTmQBNaXQ0oN+D38ivFZ1DWxBnZVKX7dCUAaH0BOBLmidJwnEUIaxIObidYPABnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZM+v+4Ga6jgKDozGq0dQeQHk5t0f0sAUCXa7NAR1Gk=;
 b=LBEMPx0IcNjGYDZVJh+jKs/9nu+PPmNz2QjD5iyQLWhFDWfK6hF/csLknbFLwl8sIkBVlIP0cuz8RGaD9mBEpx1uIyzAc12u8aAYNPGIlqUSQvPIoZUqmgItim4SauhfBlNEK4B0CgIyFUX8B6fu9ik5gon+SYuKDfohdFu+XVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PPFFEC453979.namprd12.prod.outlook.com (2603:10b6:20f:fc04::beb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 4 Jul
 2025 15:21:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 15:21:50 +0000
Message-ID: <e6997f81-cb9e-4e8f-a333-dbcc42c0c56c@amd.com>
Date: Fri, 4 Jul 2025 16:21:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 13/22] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-14-alejandro.lucero-palau@amd.com>
 <5b3f6c11-c51c-4f24-98c1-3d5ceadf4278@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <5b3f6c11-c51c-4f24-98c1-3d5ceadf4278@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0341.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0571f92b-9056-4716-a040-08ddbb0e7f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWROekNEM1RLUjdOU2VvWThYUEl6MStkdUE4d0tFUzZkemVBSTR2U0RPTlh4?=
 =?utf-8?B?Zktld05kYmc3elZ0OXJjZW54eGVxMHk4S3NNNFhoajJBREJuZFdxQjFKUXNR?=
 =?utf-8?B?WGNJL3lSYzIrTGF4REtwT1dWSXRMUndvWWtocUlxRU5kN0Z0NlRzdFhrejh0?=
 =?utf-8?B?RzkrYWlDNElxY0VHa1dMdlc2bkpFSVQwelRKTWt5RkQvQUlYTmdrQ0E0SE1N?=
 =?utf-8?B?Um16S1VRalpWcStPa0d5bGY4Y2FFSCtZREJoaDhlRC9SYjVGOEtxQjArWUw5?=
 =?utf-8?B?NGtLR3hpb0pBOEpvYXVHUXcvYUVtcEhKYi9FcTdNOUswdXVHN2VGS3ZMc2Iv?=
 =?utf-8?B?dCt3bkxzUm8rMFhWWWFjZGhBT0tWVW14a2VYZXc4UWZ3cmNYZTBaRzZmS3NC?=
 =?utf-8?B?d1dNdG81c0RobG5DelRadzN4aTdjb0VlMGRVM2F1VHUxcGY4aDRPTzc1M2pV?=
 =?utf-8?B?ZURuYUdITUNYNkdLd3NkbW9hNGZRMSszdzBBSC9JUlZDckNLRFNzOFljQzZl?=
 =?utf-8?B?ejV2UmY3c3VndTRkRkNsQmpjRHFvU1FOcU1neW9GOGZEaFZPcFd0eGRjWTRZ?=
 =?utf-8?B?QmpiY1BxVU12MTZ0VE02VWlFbEJtTnFFazlKZFphaVZRVHUvTmljR0JrOFda?=
 =?utf-8?B?amQzR2ZMelF4NzBRUEVCRmRmaGFibEQxdG9qaGhBdytXUGZpeDBldHR6TVhp?=
 =?utf-8?B?SnUyaW92eVhVRVgwMFRhUGM3Mzl0OU9vcnpsc290dU52c0dVcEVTNWp6bG85?=
 =?utf-8?B?ZmVQak5XeSt6OERBcGV2enV2U3ZXcTNsVEIwd2gvSmJDU1l5UWs0cXM0ZjUw?=
 =?utf-8?B?alprSDdpYXFuL2NHcytGZkp1bC9lSHU2T20reDkxUUNCZFgzeXc3U1VYWXN5?=
 =?utf-8?B?d1habDBpM0dNZjNNNVdURVZJSVMvaVJma2lqbHI4QzJRMVp5S3cxZ0tUMTB6?=
 =?utf-8?B?cC9RKzhFNitrZXA0MlAxRWpSTEhXS2VUMlB3WElBRWg4cVlSUlpwc254b3Nx?=
 =?utf-8?B?YUJKWHF1aVo4SllSb1VJemdLZ01FTWNUZ3gzOTZRNWxPUXkrUHlCeUdJRGMz?=
 =?utf-8?B?K2ZKRVBzRGdLbURNOXIxUnkyZlBNcEsvRi9LQ2VhQVRHWldjZGZtcmViTVBC?=
 =?utf-8?B?UTQ1UkdpNHlBRTlQZDZnbWx5a2ZWQkludWJYWHRhSUFqbndZSm5rVHY3TSs5?=
 =?utf-8?B?cWFGZVhKK2dZOUxpa1M1N0Zvb3YzU0xodXBqTmtvYzNSNHB2NEt5OXI5aTAx?=
 =?utf-8?B?Q0F6WnVITXltWUlONzNpeGRscXM5djRxSDNhVG9pZHFubUg1MFBnN2FJbmx0?=
 =?utf-8?B?Q2M3aGhGMDFqUFZJeGtXT2hmSTcwcmlFSEVRZmdUaVpIbkZSMlU2a25wV0lD?=
 =?utf-8?B?RVhwMnhSTHFjNTBtNFpUYWpuUmVCOTFva3dNSGxYTTArWVdhY291RnpWbURa?=
 =?utf-8?B?S2pzNlpaQTMxd1VvbUZvZHlCcDNaUkxFc2l0VzZBbzl0QXIvMmhGWjAycEox?=
 =?utf-8?B?bzFzdGxtUWJQT09lalRnUEtQWGltbi9qZkJJRU1rL0Q3TkdPQjB0OHBNMWls?=
 =?utf-8?B?bko3T0duZkVQRTRwZWU4RzJONjM4d3NNNlo0ZUJBN0NiMEdKb1pOSG4wRFRh?=
 =?utf-8?B?UUlEWnA3L05DMkxJVmpVVHJZUG5mYUxCY21nVFNQeXdBTWUvQ2craFZLeVFv?=
 =?utf-8?B?MWhkb1N5aGI0akQ5eHN3VnJxdGVSWExtV3BwdDRyWDYxSXVGeU9zZmtYRnVQ?=
 =?utf-8?B?R1M3U05IWnRyU01YZEs5ek80d2hlQ1BBYUNoRjdlc1Q2Wk80QU9rUGRyZWNk?=
 =?utf-8?B?eStnUXBLWWJIUktmNVRnL0NEUVN1dHhjRk5KWXd5NFFzUVFJM2Joc2ZzazBq?=
 =?utf-8?B?ak9QdkYyMmJmeU5paXlwSUcrYVRCaVNzazZhNXh0M24zWG9ZMzNoazdhZlNx?=
 =?utf-8?B?V2lvc1doRmpaQ04xL09qeXN2OGRSNHdGN0NKZDlpTWM5MzZMZ0o1RlRTSTRu?=
 =?utf-8?B?VGxvdG9rNGJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFRSXYxQWRYcGtUVnNSU21DTkJ3bWIrUmNRdkY1cFpxbkFSL0MwQ2VScDBp?=
 =?utf-8?B?cG56TmZmYjNlSFhXalNPeHM2emxOZG41TExOcDZDZjlENzhCZ2w2NnhVdi9I?=
 =?utf-8?B?Ty9PV29sRC9ldFNYczJPaXVveHJRV2htd2ZyU096UkFTWEJzcUJ5aEc1TmpM?=
 =?utf-8?B?RjdKUEsyZ2JKejQ0ZGlxUGJSN2xkTWFqMk52cE9QWDE0YU9IN2FOdnZHOGgv?=
 =?utf-8?B?RHRuODNldUJoanlvVU0wZVFESGtyU0hhTzM3YkUrRk1PdUlobU5mR0phTlUv?=
 =?utf-8?B?Wmx5bUR2YnRoNlQrSEI0TkNFNWRRMk9EUDBHMkY1Sk00Q2pnS0IrRm5hcDJN?=
 =?utf-8?B?ejJEaWM3dCtJaG0wNW12THZ5WVp3OWllV2xWdHNMOEtzNlhGcU9oMEVEVnhC?=
 =?utf-8?B?TktNZWZaaG1kb25UYlpPclNHV2dPVWh6VjFpcTczODZCeDExd2hRcVRveU41?=
 =?utf-8?B?VUpXd2ZBRE1nNWpvNG90ZTAwUEJoSmxHNlR4RGwzM1BJazRaQk9LcEs4TGFF?=
 =?utf-8?B?TktPV3NUUVlhb3pvZDJIZEhONStoQjA0WUx1Z25XdTI3NDZlTWpIQzBuczdz?=
 =?utf-8?B?UlUzbFRiREcvelN0M3k5cXNEdHdOK09OMVZlcTRkazhackVBaG1meGRydG5S?=
 =?utf-8?B?WGo4V0R2bGJKS2ZpanRhZERzM0pldXFZdTNKMGVJRUZuYjNoQ3IxWjJScXRL?=
 =?utf-8?B?Z1kxOEl1ajVkVGlReXRvd3F3RFpQSVhrcGJidyt5NHJtcmhKOVNKYmJ6WUZN?=
 =?utf-8?B?VkdONVptRXhHenB2L2lmak1walA1NmxBUHpjdWoyTWFPR2pTRTFybHgwWUxN?=
 =?utf-8?B?NXhqNHJxem53bGhMaktCajlLWnhmcUp0c2l1cHdTODk4VG1GSWRYdnRzcDBT?=
 =?utf-8?B?Q291L1NaU0s1VkZwTDNJZ2dwV0oyU21FVTNKakZzeGova0RWN2htci9MNFlC?=
 =?utf-8?B?MkpQNUpGUFpCd3hZR3hYQ1dBd0lERHRXalcvV2RyM0tvK2JXL1IycGw5b1Yy?=
 =?utf-8?B?Zk5aNk1jcGdDd0VYUVNFbUxQbyt2d3RTV25JbTRKSGdVQmt5SWJxZ0ZraTNl?=
 =?utf-8?B?cjVNV3lnTnBvZ043NHVLczNvMmY1WlhrdWN4MkNYS1N0WHV3bWhrZXpPOE9W?=
 =?utf-8?B?MnJraU5nQXhBMlRBQThiOVloMld4VTlQUjdVNG9vVm5LRlNxa1NYK3VZMU9U?=
 =?utf-8?B?bVhhR0wzRDgrdEhzRU9pZ3ZMQWdlT3hWODlGMk55NmdtYTBKVGJ2SmZtcC94?=
 =?utf-8?B?em9ya3VIWURqblAzYkhhalBUaEZZUkJFUmgzajdkNXdiRmd5MzA0OVVMTXI5?=
 =?utf-8?B?VkF2a3VsUFp2Y2VvRXpESHRraENOVExYUDZRYTNPbHorSTlJT1piQUpnVFIr?=
 =?utf-8?B?djNhTEFQZlR0Z2haTE44bytxai9kMGluQ3FPaThXbVdmRDBhaUhJZUVycW9S?=
 =?utf-8?B?OXplZFp0YmdtNm5xQTlTZVowRXNlWUxXaldmMnJxb2ZZWU5HRlNlSVVseGww?=
 =?utf-8?B?bk1Qbk5LdGcvZkQ2RjhMZWZxVDkzeCs5VW9uVlZIMUJhZDh4OXVGNzRPbURh?=
 =?utf-8?B?SkxDbERwVCs5dmUrWjZ4NHNTYnIvQmFNbWRQaS9UeUNWa1FocVd0bXU0ZExN?=
 =?utf-8?B?aHo0RE1uTTQvU1pYTXlVLzVlNHdWLzFVa0Z1djV3d2RxZ3Z0RUlJZkNGZjFx?=
 =?utf-8?B?b3g4MEJnSGY5YUsyUlpXbDBsYXYzTk5HQXVZTTRHcnNxWnVvbjF1TGpaNStL?=
 =?utf-8?B?dURpeUM3bU1MQWtSSzk5NzNMYnNiYXN3YVhUbzJRZlFwUVBET2M0ZjlLdnM3?=
 =?utf-8?B?UEdoMjhhTWdtS2RRcjBLU0NZR2JmUTZXQ0RZUk5qYXllQ1Vrdk13bTRqek1w?=
 =?utf-8?B?MHRtNXRLbWtMclpFK0tGTUpFYTBzWDV1UTRTRGxyWjk5UDhLRlNDVHNlZ0NG?=
 =?utf-8?B?QnNJS1c5SVpRaDI3T1Z3TVJja0d5T3hCZ05BL2pUOEE1M2JKUm4vRVp2dmpr?=
 =?utf-8?B?RUNqeXdxKytkU1F6U1lzTlZRWU1EWFhxeUFPSUwvWlJqWjUxZkIzbkEwMkFR?=
 =?utf-8?B?TkVyV0J1ZkUwOTIxdnJETnYxOUZpS3ZvaDRiRDZCSHVqY1V2ZE1kSDFzTEIz?=
 =?utf-8?Q?2Qe6FC88YiXSyOqJbPtVO/RCw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0571f92b-9056-4716-a040-08ddbb0e7f9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:21:50.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smnHLYwnHvUysQ4Dljy8GCiztABQ1kRuY/MYiOYHQD7Lo8AlgX7gnBPgQ7geWYQ1JuclL1CfB2/58XoiHdY7kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979


On 6/27/25 21:46, Dave Jiang wrote:
>
> On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace.
> cxl_get_hpa_freespace()


OK


>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/hdm.c | 93 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h      |  2 +
>>   include/cxl/cxl.h      |  5 +++
>>   3 files changed, 100 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 70cae4ebf8a4..b17381e49836 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -546,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>>   	return base;
>>   }
>>   
>> +/**
>> + * cxl_dpa_free - release DPA (Device Physical Address)
>> + *
>> + * @cxled: endpoint decoder linked to the DPA
>> + *
>> + * Returns 0 or error.
>> + */
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_port *port = cxled_to_port(cxled);
>> @@ -572,6 +580,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   	devm_cxl_dpa_release(cxled);
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>>   
>>   int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_partition_mode mode)
>> @@ -686,6 +695,90 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	if (cxled->cxld.id != port->hdm_end + 1)
>> +		return 0;
>> +
>> +	return 1;
> return cxled->cxld.id == port->hdm_end + 1;


OK


>> +}
>> +
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
> Probably ok to just use guard() here


OK


>> +		dev = device_find_child(&endpoint->dev, NULL,
>> +					find_free_decoder);
>> +	}
>> +	if (dev)
>> +		return to_cxl_endpoint_decoder(dev);
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but it could not be available
>> + * due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +				cxl_find_free_decoder(cxlmd);
>> +	struct device *cxled_dev;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!cxled) {
>> +		rc = -ENODEV;
>> +		goto err;
> return ERR_PTR(-ENODEV);
>
> cxled_dev is not set here. In fact it's never set anywhere. the put_device() later will fail. Although the __free() should take care of it right? The err path isn't necessary?


As I commented with Jonathan's review, I'll fix it.


>> +	}
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return cxled;
> return no_free_ptr(cxled);


Yes. Thanks!


>
> DJ
>
>> +err:
>> +	put_device(cxled_dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
>> +
>>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>   {
>>   	u16 eig;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 3af8821f7c15..6e724a8440f5 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -636,6 +636,8 @@ void put_cxl_root(struct cxl_root *cxl_root);
>>   DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>>   
>>   DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&_T->cxld.dev))
>> +
>>   int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>>   void cxl_bus_rescan(void);
>>   void cxl_bus_drain(void);
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index dd37b1d88454..a2f3e683724a 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/node.h>
>>   #include <linux/ioport.h>
>> +#include <linux/range.h>
>>   #include <cxl/mailbox.h>
>>   
>>   /**
>> @@ -247,4 +248,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>>   void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc);
>> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   #endif /* __CXL_CXL_H__ */

