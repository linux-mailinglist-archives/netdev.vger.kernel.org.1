Return-Path: <netdev+bounces-147623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576A9DAC43
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BE166D3C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6B200BBA;
	Wed, 27 Nov 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="srVLzHZp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652631FF7A9;
	Wed, 27 Nov 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727542; cv=fail; b=i1or2NQt3Oz0lNdWxlqPqR17piGFzKpbliK6L5uTwLbL1hfciaSlp7i2+vcBZVELuc2fjzUGNQMQTMkaji+Trqq2+2Bj5fYwmQtsAaX7jxGGiRqUx4VFcAsQVFbsARbGVo/fVCeghcgY3nMlNjpeTHIBaj3Adr3gxDPrz2iIEIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727542; c=relaxed/simple;
	bh=8mrhPH3teoS9IubNyyMcUsHmGZwkmMy/DiRaxkj5NAY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neiPYLR0Pukgqspgw2IJZE8rBPiYr6rXl4+GVGsBPzM+Ucb6PVGx94JSr4FD49nulxfNuJhmq6/DyjbxRDeNQp+wVJO6+qiXwlCE+8KIc2//kLAPKduaehj9AqE/0GLJ0O/7Seai4CoNjMYNFPn8o3evuj53GSYOewVqDUzIEOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=srVLzHZp; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZOfmfOm8BpTaZt4hykqCpq1Bq1C6xZIMZiWLCd+NmYdBPHiCCMcLolHf4Pz3DKL066Tqsx3uLDg2uJKtOE3oTqJXNcxiGYMrUfiVEq1i8f1sjGHe6oqotVD/tC2+TCCfkUSHnMtLlRhZYWH8vMYJUeVR4mBAzmHbmF3xkadNO3KuNsXRpNrryKTYG3rIqq7IYAap7dQdNTSE5Qbm2PJS9pOJbVjWncyJlOXcEg4p7aCyxzYWumbis5fBL9goH5sLFsiBbIkhe5UMoZZlM0g4Vpoj6VdlfoJkBCKPtXVqVZc+yD/3reLLxaXtYBFAF4qMwhpK+BchWBYIskhRhAqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItzRY/F4COfmLpB8KPFiXySEYC7MokmpHUTmhvMzJ3g=;
 b=QH3ToCFLxsqpcgJxdeSd5VBvgA+EZqYDbnxiIIhP+WP+7D9fIM+03tT33KLfegQpusOqQxtlahgsYhFJ93wT5gJKEGfJETDbFUvDN1G3Zsn+ytFBRj51wRyUwgHez5qv9dAo5lEwMk+hsWyYi/6qQZWOXoq1lB6faX06/i4YCQO7ry1cuT5rpOD3ASik94D+F0S40uFSPKAoCdQutqON+feEgyLIGWiTedqYZUbs/1a2FMihJ6qXnzTGD9inqM3JWt+JlwCZBWCpfxioiDa8L3hRZqCIHXRdFurdT5hJZvtx6BVWcpxZWlydV1Ja6JdsUnpg1zNuvu+vZ1TH13wmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItzRY/F4COfmLpB8KPFiXySEYC7MokmpHUTmhvMzJ3g=;
 b=srVLzHZp5bh8hVE+XFKf7O6CG/+7v9gRoBVYEdgxKNG5O9rXWMRANbn8bpb19BxMOWaqW7CUyrkBo7TIHxvAkrjcWNWsDU5BwGFYK4PKZ1mERmZwjCTuIJhf/ePHiA+j1ZpMZzEGjP+S+2FypIpvNHQ7bS0jRa657gu8lOyWXIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 17:12:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 17:12:14 +0000
Message-ID: <8b9de106-06bd-e8f5-fb53-3cdfae5ffa32@amd.com>
Date: Wed, 27 Nov 2024 17:12:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/27] cxl: add function for obtaining params from a
 region
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
 <57c05646-0d69-45d6-a20b-9447accc9c85@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <57c05646-0d69-45d6-a20b-9447accc9c85@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8b93f7-a1f9-4a1c-d507-08dd0f06a373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZibm1Wd2dPYzhkc2FLa2tFQ0JDaHE3WWJvbEtFQ0JUOS9PaE1WZ1c1RmhX?=
 =?utf-8?B?dXpvQlU1Q0ZiZjNRK2xCaGlEZTBUOTJ1V0RlMEgvQWhsc1pEeG8rTTJRK0J4?=
 =?utf-8?B?a0FUcHJGdFpzREZNWnFXSXhSSTlGaEllbjhhQ3JyeERjalNWT1RIWXNkOUVY?=
 =?utf-8?B?ZGtaUmg2SDVBVmtnOWlGWnN2QVZQcmh0TXdSaHlZaXc1NWJKZk5NMzduMUM1?=
 =?utf-8?B?ZGcya29jaDhIL0lwNTUxaUJBRmw0cHlaSFJ6azAyeDMyNjk0V0RWYTFnbG5R?=
 =?utf-8?B?MzBGalU5MENRUzhXL0xneHpQVjFaZm1vNlN1TVZyZHR6d0FCSGtKYmF6L3Nr?=
 =?utf-8?B?QkNIYStHNkdLMEJlamdvcDl4elZWaXpSWXVnbzczM0x1ZU51Z251WnBXQVMz?=
 =?utf-8?B?YmJOek9CRVRQT2htQXlJcERLeHRFNm5JLzlHZkpDNE5IWk9PNjlHRyt2OFk2?=
 =?utf-8?B?a0poRmxNazBlMlJCODU2N2VTUCsxa0hYRVFnejgyWVMxVHMxYmNvQmlyWGhx?=
 =?utf-8?B?V0VlYjQ1TnFBVnMvM2pXMGZaVVRvZW00b2w3eklpb2ZJVHFsK1pGTXFhMjd1?=
 =?utf-8?B?aVMwdjB1L21XVEhpekFsb3FwRXk2Uzlpb29qeHkzaGVMU1JjbnZzR3RSUm1t?=
 =?utf-8?B?RmZqcy91a256eGppeTg0NHVnNWlKREw3bWxsNitWbXVrOWhXMlduZklZMFBJ?=
 =?utf-8?B?VGZmcmNUS21SanRlVjYxTWQ0VXNmbzgvcXVwZmdiKys5czlyaHRLUzVVSW9N?=
 =?utf-8?B?b2toUGdjRjY3V0p5dFN3Q0o1enplaXAzbXJzTDd1OFNqd0F4L0UxREhOM3Ba?=
 =?utf-8?B?cjc3bURVSXM3bW9yU2NCejU0dW1VQ2JTVjgzdUE2aEFOOXNiZS9QM2E5TFcx?=
 =?utf-8?B?dE1ZQzl1MXVTRHZZRzdkT0pGamlFeTVLYVV1d21NVXVweXE3T0gydkNoZjVR?=
 =?utf-8?B?eDM2TnlITnF0bWVES0RndUhyZmVqdTBFcXdrQWJjUllNR3ZTbC9VNlM5SFhE?=
 =?utf-8?B?bWI3dmUrT25GK3BaemVqcHNLcDR6dC9GZ3JndjhIaGk0Yjh4a1VZMzhaaElG?=
 =?utf-8?B?MlEydm5KSy9MbHVoZkNmN1h3WDJkRS9TZk5zaVhIaVR1bmV6aVRaK2pCU3Rv?=
 =?utf-8?B?NWlwVEtHSkovMk9oUHlzR3R1OHhMbFZiQnAzbUVTMUJkNk94emVqU0pNUjRJ?=
 =?utf-8?B?QzVUdVRoeU9hcmhnSjJ5RHo3MXBFd3JXcDA0M2NXeHI5emZaWkNUOHg1ZEdQ?=
 =?utf-8?B?c1NPbjIyYUY0TUlsRmRlZDhtQkVtSjhhQ0hSb1lUaE1zMmN3a0NYbWZ0elhn?=
 =?utf-8?B?RGJnTG40amQzTkFlSWdycHU0QkxlM3BJdE5sbWpSM1F6NHd2SzRpMzJjaHdw?=
 =?utf-8?B?aWRDTEdXd3RjNmR5ZzBXL3FteXU5Y0xCaVJRbjV4eDl6eHdFM1gwNEgvVC85?=
 =?utf-8?B?Sng5djEzNDNOckwwS3kraGkraEwwN2lrNENBQlRUSWx6c3NYUjVFZ2dURmc1?=
 =?utf-8?B?T0s5THJobWFFR3AzYkpMT0w2RklUeC83UDNoZVJvRmNnRUc2WUZlR2VWbE9r?=
 =?utf-8?B?cXc3RktxQ2RhZUZwNG01SzJqenN6NDhhSVFjVVRIcWlETVhQc2QwL3NqMVk4?=
 =?utf-8?B?UUQvbEx3V1g0SXlaNUdMNUJSZThDZmVtaGFSL1c4Z09UNjY5U0ZHTWpKclZ0?=
 =?utf-8?B?a0ZlbUZSQVVJWmh2MnM4QVUySGdRbXJZSnZzTjdxa05JWm8rMFlwcnlCYmll?=
 =?utf-8?B?bi9LR1ZzMFpidVNkbG9nOTdZU2NXRGhUdjUrTkdJN2c2NUR1dnFWZ1cwaXlC?=
 =?utf-8?B?MmpsVnBYQ29hQWNWc0FaMVBKQU9OZE1nVi9mQnNjTEZjblNWZWVHOFRRM3NM?=
 =?utf-8?B?VnFOd3FMQ1hYbnpGV244S0tKRFNaVDdmNWo4ZDA4eDVFRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cytaQitTRkRjcGlESFl6SXo2ak9hWmhSU3JJRzRwN2t3eDZ3RmsxQmZvUmo0?=
 =?utf-8?B?QjArY0c3NHFtOVVsVmdCR3Y0aFFpVmYwTytaTUxhZ3pEdmFEYUppQ2JvSnNl?=
 =?utf-8?B?eUhRQWM5UlJRclBmeXZnVENzQjhmYmpkY2NaZm1sUlpES256bFdSdkJ6OEpK?=
 =?utf-8?B?WkFxZUt4KzRzZEs4VFVUaW5mNkxla1RURHZNekxIUTdmNEZOZGhhbi9vR1dR?=
 =?utf-8?B?eG55aVNkQWRNNzh5NWwyWURPclF4WXBVR1l5Lzh0bnpqdkNPc2ovVW84SDcz?=
 =?utf-8?B?ZEtwUHdQajFidEg5SWticHlKaEFBT3M0Q1NKcHR5R3A1QzliZ3d0dnNjNm01?=
 =?utf-8?B?RUMrVFd5Y2dza1hPVEFTa0gyeE8wazc1R29SQjU2aUxucjROVzdEQ1Y3Y1JK?=
 =?utf-8?B?RHNNV2UyUHJpREZxbENXclE0Zm80M05jSDBSZFJkenR0bjliMVhVUW9FMVI5?=
 =?utf-8?B?WGVkdXVJK0h4UnFUNlljc1RQMS93OUNQRjRkZU40TnJ5dmRLaU12TndUUDB6?=
 =?utf-8?B?Z1ludE42elJLYXRlMHozamY3ejh6cUptblI2Sm9ONmhNcFlyb0M2Rzk3d1h5?=
 =?utf-8?B?UVVUN01Idld0eDMyazNZU004OTRkWGJ1NkZDb2hwT1NibGs4dXhGREhmMnZ2?=
 =?utf-8?B?SlZIWERtZDR3MTd1MVdmbVpCZmdVaE1xTTRDL2VCN21WS290WnZDQm9TNWNC?=
 =?utf-8?B?S0Y4Wm5RaGdmbGgybTVUd0RHQm5ydDZJWUlsNVVyTnZyNURlaVF4MGRCT2Nq?=
 =?utf-8?B?WXhodzR1TUdYQ3d6eE5ZeFkzdW42NHB5UWFaL3gwaEM5S2F1SmtwVk9Hd2hk?=
 =?utf-8?B?OW9LaG5kRlcwbVBxc291WGpTWU1OK1E3SElKWmxoRTV0WnZLWTZ6NUg5NGxT?=
 =?utf-8?B?V1BlSWllcGwrWU1xTnAvVC9xajRjbHppNXRJbHFMS3FSL2xpWHk4SFNubEZG?=
 =?utf-8?B?bUhvcFNXTEo4YW9SNmVaWGYwcEVJRGduOEp1K0dDbHdtTmdJdzF2MHlIZ0NH?=
 =?utf-8?B?MWljYS9JRUIxQjdsWlNaQzdkcnpyTWVNdGNNT3V1YVkzdmdWeVdKd2lGQktj?=
 =?utf-8?B?NzAxcXpzY0t1RmV6T1F0UHl2cWZPODg3RHBhVUU0eGloQ044Y3YvcjVxUW1u?=
 =?utf-8?B?MlNHaTdnTWoycGpkY1hNWUFwclQrU3dEUFEzZHNraTdqVEp6MkZWYk1Yc1g1?=
 =?utf-8?B?VThBRTZDZTFMTHFjejBpRE1McmVncDFONHR3akVibGtIV3ZzK2JTL0R1OG05?=
 =?utf-8?B?TndQMTV5cUNLbEYwZUdhUFFUdFd3K2hQWmN2Z2JUZlBZRU5lTEZvZU1mMEZi?=
 =?utf-8?B?YlhyUTJuM1JxVWUrc2c4UVZGSVRJWmVPQ085OGpOcGlid0dZY2llcUtXZE5q?=
 =?utf-8?B?QlBIODNMSkl6d2EwUldKNTdYZTM3d01FNnEvQTlJaXhOSzh0alBJU3RqNDNC?=
 =?utf-8?B?YmU2RmVhQzN4azI0a056dHB6dko3bG1SbW5icm14WFExN3FxZVg4MHJKNVAv?=
 =?utf-8?B?Q0ZyNzFTRk1la0JFMG1oeDAyZEN0SVgzR1NRWWNPTUw5SzlBRC8rREIrbXlR?=
 =?utf-8?B?aysrRElhWTd0MUEyM25sYmNxQU02aG5HYVpSelhjT1pQQ1pOZHNOZjVuYkV6?=
 =?utf-8?B?SFpZYkFzdDkvZG92ajRjY3B5MzdnRWRWT2ZIdlY3QjlXS0x0WHZKRHJXRWxS?=
 =?utf-8?B?bGkrNE9GZTZqVzZ0dWRtYW9nNzg3cVliaW11dlhFOURoUDdrTHRTc3RFZjZS?=
 =?utf-8?B?UFZrMGk4L1U0Y05CYk5FMkMzMmF5Mk1tZVpkOTVSTk5Od3FjQWJNbEw4MU0r?=
 =?utf-8?B?dlVnYkh1VTlRNVVIRk44cnMyTTAzS2ZJZWZZOUR4Z3lqQWs2VjdLSnJoV2l1?=
 =?utf-8?B?Ukdvc0RxbTVoUUp1ZnBuRzA4akQyY1BybHgrRkhzZm0zcXkzbjh4NTZpSWxF?=
 =?utf-8?B?Z0FCRTBiZEkrU0VTRUtxeC8wRXpFazh3NUx6dGMycmdRYVFEU25TcmlNQU1m?=
 =?utf-8?B?UGRmeUx3VnZ3cmVXMVZQSUtrSVpjUXpWbk9ualZXUkcrNGdWdVBwZjF5MmQw?=
 =?utf-8?B?TnNyaVhiU21pd1lRQkFjUlArcE01allSOEV0TlBvZVhsbzE3RTR4d0lNdCtH?=
 =?utf-8?Q?DGCublRqYJR1W/nFSAPjb4K6+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8b93f7-a1f9-4a1c-d507-08dd0f06a373
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 17:12:14.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SOH46oDBPJeUg/Dtcmhcu4RBN0YZgIBWazK824socoaZE93kOqrGjVJWDU/6U0nKiVSp+BDTZrpMfjsHfsK/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267


On 11/21/24 16:31, Dave Jiang wrote:
>
> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Add a function for given a opaque cxl region struct returns the params
>> to be used for mapping such memory range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 16 ++++++++++++++++
>>   drivers/cxl/cxl.h         |  2 ++
>>   include/cxl/cxl.h         |  2 ++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index eff3ad788077..fa44a60549f7 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2663,6 +2663,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
>> +			  resource_size_t *end)
> Maybe just pass in a 'struct range' ptr and call it cxl_get_region_range()?


That makes sense, and that solves the problem raised by Allison.

Thanks


> DJ
>
>> +{
>> +	if (!region)
>> +		return -ENODEV;
>> +
>> +	if (!region->params.res)
>> +		return -ENOSPC;
>> +
>> +	*start = region->params.res->start;
>> +	*end = region->params.res->end;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
>> +
>>   static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>>   {
>>   	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index ee3385db5663..7b46d313e581 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -913,6 +913,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>   
>>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>   
>> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
>> +			  resource_size_t *end);
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong' version
>>    * of these symbols in tools/testing/cxl/.
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 2a8ebabfc1dd..f14a3f292ad8 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -77,4 +77,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   				     bool avoid_dax);
>>   
>>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
>> +			  resource_size_t *end);
>>   #endif

