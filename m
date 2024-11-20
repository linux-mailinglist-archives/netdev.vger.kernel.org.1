Return-Path: <netdev+bounces-146505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C739D3CAC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88941F2237F
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744271A76DE;
	Wed, 20 Nov 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4luEX6C9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EB1AA795;
	Wed, 20 Nov 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110309; cv=fail; b=AlYWC4G4l1oJRr7yr+aRwn8dJbCIGbetB8LgDO+aA7tBystx/MY2ytashvzneA+hCmriHMjJF9+zavRbUDBdMyit11U5xYitFjgcprgEdrEuiC0p//nPq9cKu7FPRig96CHwfWgHyi1xt0xfIIdTGU7wo5sc5ipBHZq1ZpKZuqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110309; c=relaxed/simple;
	bh=FTfuxO4RYd54ji1qdEGom180ZvxfizZjrhtKx4yRkR8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpth9YDRLn/liXXCgwRpckJT22nnPJ0D0zU1qiKeDiImBDLjc4DfFHl5LO9i30qK8ilnnTV6jXL0PdVf7O84ULbsa0JgrvgLVcWjCmxCqkDQErTtMGDwOkeV/HiddttG91bIqsOmrUi37/FksRBmFzHAQvIndnnhx1JOwwGIcQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4luEX6C9; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlgqNIkpc0/VabLAhZlr/fhgHHv9iKC7L78WNg58aVbQHGpXviMclJmZdj2bgDyGP2wWScAaq//X0/Oincktw610bssZxExbdksdyY/UmqfpxhY4L4JPfMws9rRBzswyo56Pvn01ZrYDKn2iykQD+Q4HOGbBEJGH+cymzHy6qVhk1OCc6UhZZRkNOOHbV4Ty2P1FfNiNY1NCCtGXk/k6Bq+00eshOQRprDWf9Z3wJr1B8dbL+TDR6ryGzeg9F94uIywbO3d+ykWrOGQDlLT+PWO8aPwaWegvaMG/ZWEYKEuxjWnS0s7gNItMjbJeB4z3bBxSNTYCf9gYhK+lVF5dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8Qe4LJ23atAc9byjILlYjF62H9rDJTc4UDmOlw6Nfo=;
 b=edJYy/1vfeXD2rhGTeK/tjyPXtBZIhinNGbHLxLRgGtyD/vWzne0/s9b1cembYpczT97s/tFDdmdiEuPI7ScdqbjhV86wt/cgRxbRjeCG6Lm55hDYnosQSpN8KSIFNMA7ISjKgrHXk7t7Qpz+zWfZwKm4bHGNbP57rMB62CnHFBEjZY9ZR+mhCDOJO75mGwf32xkXaG4jKNl9xkI2b+e+1awdKNMfOMeURZ/80BAlJetXNlJIQi8C9U3R4iK1a/qAZs9yl45OgssCu9v8kWDfZhWDg7JjTxreyThRc+hhGdAmxPs5hIincXhDFwvACUFs1OUaYAYXdi/o0Jh7L8XxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8Qe4LJ23atAc9byjILlYjF62H9rDJTc4UDmOlw6Nfo=;
 b=4luEX6C9XC2oJGp4hRcGfDYG8j2CWG6IDC3/uFrlH+nvMF1OMApKLaqrfMDGsyNG96626AMT1wBbgEUqeNYHMSf6gbYlDYlB1sCj+kQ+EH24MfoAcAY4Cjtz7eifk5aTB0AetK0H+0pYYRYCBSGA7axHKfcw4UuDcT9P3kQJqIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 13:45:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:45:00 +0000
Message-ID: <49d8edc2-f2fe-a89f-216e-b9cc0c915f0e@amd.com>
Date: Wed, 20 Nov 2024 13:44:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
 <bc2a587b-5f24-4834-a38c-8bfcb930bcda@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <bc2a587b-5f24-4834-a38c-8bfcb930bcda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0139.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 591cc574-cdad-454e-c9af-08dd09698746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0h3MFV5UDF3THpHM2dodEdEZC9aWTJwREN3aDBmYkJZY3N2dHNJRnh0ME1B?=
 =?utf-8?B?d29nN0tZYlA5QmNOMHJvSXdJSDd2OWpXSUZNY3hnRyt3WTliOGNQMGFOSWxZ?=
 =?utf-8?B?ZUgzdW1Sc0MwcDFWai9WOGRMWVl5NWQyRUl0NlNzSXlxRWV4YkxGNVlLY0dp?=
 =?utf-8?B?a1ZGNmM4ZEZ4dnd3RlM1K3p3bXRncTkzWktER1VrNzJZSnRpZFc4TXJpMjNz?=
 =?utf-8?B?TVhjc0Z0Q3JiUHNOVWo5OEZMTktiZnRiWVN2STNzWU02QXhmWElTUU14d3NC?=
 =?utf-8?B?V3NuSm1BOTdVajRHdGNYaFpEM2h2VmpDUGtpZXNSTHdGTjErOFIwNDRPeFZ0?=
 =?utf-8?B?Z0VMTTJkK2E1UW9SL3NHd0dVRVNXQjRralR1N3FObTBYcm02b3lwN2NlNWRj?=
 =?utf-8?B?Tzk3RVN5T2FqVUhqa0N3SkxrWWFNb3NBdkVidGM5T0kwN1dEaFhLRkdJNS9X?=
 =?utf-8?B?bTB2bTkvZ05mTDhSTXl3QmZyOGJjd3BRdVowb25FWGx4RVkzYklIYnVoZ2Vr?=
 =?utf-8?B?a2ZRVG1mWVgyV3h5TndkUGhYbFJiWmkwOGZlWno5SXpEc2xDYks1K0phZnM1?=
 =?utf-8?B?cStldmZkS2NsMEJxSGhnam16aStndnVFVnJ4Vy8wbDg3L2x2emNpcGZ3ME93?=
 =?utf-8?B?N25hWWNZYkFaOVZMb1hDNXV6R0kzL1JCbjUyLzZzdXVDeDA5SU1lemFveGk3?=
 =?utf-8?B?SGxUcTZJekNYYXdUWXIrcjFsR1pmcmE5ZHdZN1BjdnczNXVFbDcrVjBIWWl6?=
 =?utf-8?B?eDMwODBWLzNTaUJNQm1GdXlIdUI2ZG5BeHYrRk1RRUVJTkxIKzRURU02UTJx?=
 =?utf-8?B?S3VUVXU5VW9GdVZzNEFOaFRLNnNIT2xzcFhEMXovNjI5SjRpVStOQTFHUU02?=
 =?utf-8?B?NTdiaEFTaGtTTXJESFJ1MWx1UGp2bUZNK0hwMUVHWDNDNnZEOU85NlZLanlT?=
 =?utf-8?B?Wit5Si8ya2ZldGpPN0VkL3kwRlU1aTV6S2l2THkxakRmdnAvWU8yaTk3MU9W?=
 =?utf-8?B?VXpPZWkzdEVYa05yVGxXUlNEdUx1OS80WDhuZHpKSkxQQWZrZkdxOU90RXdU?=
 =?utf-8?B?VlNLZ1dFRE0zN0Z5QlVZTWllU3o0ZEhrdDJUQXF6TnFzZGdYY3FmQmNqd25h?=
 =?utf-8?B?RFlIY0x4T0R3VVJGNVU5MzVsSC81Z1ZPT1hkWEs1OXVQZUs5YlZjNDVFc29u?=
 =?utf-8?B?SUg3anNtRGZOQ0pML3VCSjk2aWhvZytpYk1DL2dlMmFldGZyWFMvWlhlSW9R?=
 =?utf-8?B?R3hZTW55NE5GaDA2djRNUE1Yalp0RHg3a1VGWUpObFZNc0NjQnIyQWpPSElx?=
 =?utf-8?B?Zm53TzdOekQ3NisyS0Q3NXVuYzZabVorUDIyTnZ6Q3JHT0hhblRKelVCT251?=
 =?utf-8?B?NC83bTgvV3FhRW5JWlFLZXNxS1BOOFFGbzFheDZ4YTFRbHJWditXS3lqNjhL?=
 =?utf-8?B?anRJdlV2ZmU2dEU2a3JWbW5BRUtnRzZHV3RIV0c1cHJLRGZudlFjUTIvcU9X?=
 =?utf-8?B?cWFOUCtlRjlTZmNuMUxQNDB2TWs4d3NIRjdYU1Y1YnJnQ3M2UVNpR1dWUGw2?=
 =?utf-8?B?M0dBVGk5ajBCNUhkMDgzdHZoQkJndytqcDBOUGN4MUpsMjVrWVl5Q2tBY2hk?=
 =?utf-8?B?U3IrNXZjRE9sSzFRd2hHUW9BV1poK3NHQnhwZDFZMXBIRFNHM2czclFGSW1n?=
 =?utf-8?B?Zmh4aXRlZzkwekRuNnFyT1FVcVdVaVFGWmdIQkpLYTd1UzRLa3VyMUw2bWlt?=
 =?utf-8?B?SmZJalFiYS8rU3ZJbUJiMkp6eU0yL2NRRFE2QTJZa29leWJQbVJzOUZabDFX?=
 =?utf-8?Q?W8OdLPYlnPcIkvvNaGxtcyC8iOV7NP+TNE57Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUdwV1BsSDdKMXRIV2l2Tktyc3NsMGNUYnRhYTFZTWRscU5kWkphSGRWdVNl?=
 =?utf-8?B?eG1TaWJacGN1aGhMallZT1FaaWlwN3BmM3B1VmNhUVUxV0JRaEFhTmFCekQ0?=
 =?utf-8?B?UDVtZTBrcFVHQzQvbHB3UHhoNDA1MTBYd09KTGRqNkQ0d2REUzlGNDZaTFkz?=
 =?utf-8?B?ZThOTUdnK0dUcFVBVDFlNXg3RVZuWmRqNnlrTzUxWENwMDBUYlE3NFV3VWFw?=
 =?utf-8?B?ajhrT2dHeFMzZy9Xd3RMY0sxVU5jZUlnVnZKOU9TWTQvNExFRnRmNVdPd0pK?=
 =?utf-8?B?M3JJUzBPdVB6ZUpOcG56MVhENS81TWVoS2hCUnhOaHVpNVRiQU5tMmtUZ3dx?=
 =?utf-8?B?NElXdkdaaVJTRFI0ZEFJTU1wOHBpOVpva3ArN24rOVJBcDMvbXZJMk9JUHh5?=
 =?utf-8?B?dnFqT3lQdGRRRjVNQjBFUzRoTU84cWtvUzEwOTE5QXlZYzhpRVBRT01tNDVs?=
 =?utf-8?B?TlhsMnJEM2pUZC9idHFtZ1Z4d3V1dmZlTk9rbVA4dzYxOElpeG1qMzQ1cjMz?=
 =?utf-8?B?M29EUTZZNWtWcGg1VjlhSTNCcUh4SWdlM2VxRkR4OHdiWGE4OVpKM3NPbFJG?=
 =?utf-8?B?ZTVsa25SeHg3Mm9BS1JPQmxlR3lBcjdDZnB4TlBxRXk5NkpVRzFodnpjc0V3?=
 =?utf-8?B?MWMrN0R3K3Z1Y2Z5bmZCM1A3V2ZqS0ZVQ01SdlFZK2hyVGpUN2FuUlBkRXUr?=
 =?utf-8?B?R3FhdWc2M1lYZU54R3Y0ZEcvbmlhNzdCejlxL2lCNElDeFdvd0dmNWdTdm93?=
 =?utf-8?B?SzByakt2bTZWeUNlY0lkSWx3Um9zaXkxMHBZbDl6OUV5aG53UjVIb09rMW1j?=
 =?utf-8?B?VHRmY1M4b1hvTncrZ1RpWlBBWlE2V29wbnEwMWk2VnVNbWF2U05FalYxV3V4?=
 =?utf-8?B?NjFWc0gzRjREcW04TzNsRUZXRE9VUUZLNyttbUFLQ0RPNVdXQURzWjEzTm1q?=
 =?utf-8?B?dEZMTzRuUHBhUWFZcGRwS2gxbHh6aDgxSXRldGNjWUM5MnJtQnpGQi9VTFJH?=
 =?utf-8?B?TkE4M1pSSGNVUTBtL3NuWk1HQ2VwbDNhSE5LMC9pTnZnNFFydVBCTlJrY2p4?=
 =?utf-8?B?T0NXait3ckUzQnlibzNyYm1VNHo1enZVeTZzYnpxM0hicCtnMmlyeWJYendZ?=
 =?utf-8?B?ZkN6MlJxS0o0aDBpU1BHaXk2WmhWeGhuNitJVHh4MFVHTUFIVzFRTElER2Nx?=
 =?utf-8?B?S2VsTnlONEZMVFdxZDVrMWIwK2dmQWVxZ0xTL3BiZnhuWXA3VTdCZmJtWkdM?=
 =?utf-8?B?TCtrMHlraHhvL0lMcmdnZmg3Q01oN0QwdFRLTXVKSDc3R0d1N0JmWXRQRWFv?=
 =?utf-8?B?Y3NaZ1pqS2hhVGhxQkQ4eHZ0TjNVSHY5L2ZLanpYanZrdUY1a0dFVXBMMUxD?=
 =?utf-8?B?T2hGbjRmM2JZZ1AyTjZlZWN5djlwY0pHaHhWTEE1WU54ZmFPN09zQ294SzQ5?=
 =?utf-8?B?a3p6dHpzZWVMUlJDQlZLSTFOcUtVVE5tRld5dUd6dG91QVZoMFhDU2NYQk5Q?=
 =?utf-8?B?S1JiNkQyeC91QzVzUUo4RFZXOHFQREpxanVBWm1SR3ZyRHBMb2lza3NTT2FR?=
 =?utf-8?B?NFRIckVtVndBRXJsVVpJMjRyVnlCdnZ0eFh0Z0lXdjNBMG1mUGt5YUhUYTFS?=
 =?utf-8?B?T3NJZExhWElLZ0J2YkNBRzBQcndDSkpLSmZTUitiS3Vab0ZMTWR3T3BuRDc1?=
 =?utf-8?B?N1lJODZUYzU5Ni9LdmtpTk9DektRRlkyTkZzU0V1cGlkajlac1Zla2x5VTBW?=
 =?utf-8?B?ekJhci90QUVxUXl6MGFtc1l5YzlGZDBzRGcwUTUrMnNkNllHaUNkdjV1OEY3?=
 =?utf-8?B?RlZZME55VUUrenh2aTNXTVE2QnZucHJ3QzlScCs1U3FwWHZBaGk4b01QVmQr?=
 =?utf-8?B?TzZXb3hYUk1sRTZNQmhIM3lzdVZsWVFZclJJcFdaY3lCWjZTaUVxUTRlR1U5?=
 =?utf-8?B?KzNCYytYV0QzTUFhRGl6NTNhNEQ3cWx1Q1lQdmdqVzRGalZMeVR0YThKbWVN?=
 =?utf-8?B?UDM0WStVSUdvd1B3ZnlhYTZDZVVmYWViNnV1NjlDaUlaeVorMm80ZWlCVGc4?=
 =?utf-8?B?cENqay9ObWsvcHNHcVBlQW1zR2wzYktWRE1yUTliZVJlLzIzK1owTEUrcGpJ?=
 =?utf-8?Q?wZ6SxA630kutJQsnkW+o//bbs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591cc574-cdad-454e-c9af-08dd09698746
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:45:00.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5FDLXcn3bfpLMIlcYxCX7Zdvoz7iXKGWp4T6FANc6n2cfpVtPOiqwVKRksDpX8sLEQvbzqBnijCP1JpypdMEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123


On 11/19/24 18:00, Dave Jiang wrote:
>
> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource_contains returns
>> always true.
>>
>> Add resource size check before using it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
> Should this be broken out and send ahead of the type2 series?


I could. This seems not a problem though until the new code coming along.


> nit below
>
>> ---
>>   drivers/cxl/core/hdm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 223c273c0cd1..c58d6b8f9b58 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   	cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if (resource_size(&cxlds->pmem_res) &&
>> +	    resource_contains(&cxlds->pmem_res, res)) {
>>   		cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if (resource_size(&cxlds->ram_res) &&
>> +		   resource_contains(&cxlds->ram_res, res)) {
>>   		cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
> } else {


I'll fix it.

Thanks!


>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>>   			 port->id, cxled->cxld.id, cxled->dpa_res);

