Return-Path: <netdev+bounces-189310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33807AB1910
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6127B18955AA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6C22D9E6;
	Fri,  9 May 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hssfuO1C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFB1CF7AF;
	Fri,  9 May 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805417; cv=fail; b=ZN/8H4g6VRejtUb4BgMhwea47i+SwU8mz43Zss2rqvqJnNF7fN1iPv2N3iLhG159ZRqkY9gaNyj1uMWjTLwTXGq+khs3WZRU1PcvX8OyQjIQZvLfjzTnBWLcp10K+ERZlX11scwgXvXVZeWw6Dk8KsmucpS34CUQv61SHgHLPEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805417; c=relaxed/simple;
	bh=yHJWXvMKQFztb7OxQJpFM1G0A2c/P5yepMRZr/Sd5BQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dT6TsPF/GJxc4UDaY9Z0smIGrdQd2znXgWcfBCuU/vjsQvD4g5Vs7TLbcq2/CnppLF3KujGw+HqiqfwhqtbxixpehXRMPslVbxdMoKecf2M21ax6EBQVbyJj4tcXIB31S6PO7/+xI3MyBLdB4XxHOQsWNYo5vcD78++IKGBYxt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hssfuO1C; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCedQFq+34kjhsJpv79nV0qw8K96e7tQjJFaXVaedDw046icoh9vXT5+FaKNXAObADKPYZR1fDb0n6j+4uInEkAzl/YmqiB8bdxtNB5TySLj6aeMPuqtkFfoVdPvt56UC7CeKuvsCmmfbKL0afO27ZoZ4mGDdlTF6W4hYnvAPtYgb4BFTe9U+2EgtmFox0b0jJvuSzaK+nTGaYvfLJbJvbO11CwJlNT4nUcAOkNbReeSs6mRz8MAcn/VWCVFZ6BA7jg5NJOPYE0c84qShq4HCOoHD831kIjCb+GIRm9ZzjFgDFwjLSKExqYJf4/1KbwQs6BkFSmr38u9q4P9l0xUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXLmoIK1lItxCP/J2JgkdLDBc5y3wM1kzJk3r6UwS28=;
 b=Kaml0m1ZUvmJ4Fs04NEZY5j/7HPyMAlvtVwN6Etc0g4ZU75VF8s2od/MhTXoGeeWU/V91tZiQJd7FtOlI0s5i72hxVBGTKYnTsX/okfFi0JQMecLKg8qTvj2IZTJ3m4c0e25DU8IUS3mmlL7MAC0fmM3whQMvlbgMHxQ6eOKj+F+TGCF7pdv3rslR61rZYYasLB8GmsrlB9kahIWdsshCUxK6Bjx5a+nudE7j6BuSszfupypIO88lJi4Aow5Sfytcv2/ZlhXfiFEGRS91APROy4x1hrZ77oCJTBWTA7DxwtbBB9QRs12dYG5vrJmgJq1omevyBXEkx73LrcmvGgptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXLmoIK1lItxCP/J2JgkdLDBc5y3wM1kzJk3r6UwS28=;
 b=hssfuO1CMADs2uK4BX0KXRGpOSjEVHv2PafoTtZDGU5CW7gz70Nn7aVpYlvSHWtMdP9y1eCW+qIpECsyj9FgL17BvfT5eTSVRYmc56eEAvOOepQRgBgJgWTjl/cYndP7KeoMueUD8pOFEF98Tllr52vnjn3vNYQbAjfWda5XKEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 15:43:30 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 15:43:30 +0000
Message-ID: <1196f552-493e-4b72-be72-a21309c07380@amd.com>
Date: Fri, 9 May 2025 21:13:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] amd-xgbe: reorganize the code of XPCS
 access
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
 <20250428150235.2938110-2-Raju.Rangoju@amd.com>
 <c962b740-4cbc-4d1f-9dda-02820dc54daa@linux.dev>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <c962b740-4cbc-4d1f-9dda-02820dc54daa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF0000017B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::46) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb3963b-53bd-4eb4-6465-08dd8f103f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWZocFkycnNXMUI0QkRMeityWjBkcVo1eVRmQUl0c1V3MzAzQm1EWlAyeElK?=
 =?utf-8?B?emV2THF5bHY1cS90UHdMR1ZvSWF4a0tKZlYrT0RNeHkrb0dEd3E2TTN1UmNL?=
 =?utf-8?B?dkVsQ0xJb0VsS21OQ0l3U2xQS1N4Uk52RVlnb0VIR3V5ZEc3SEdlb0VzdGFt?=
 =?utf-8?B?MERyTlpyZ0dMRTlzNHBkNVVJY211Smo4dUxhUEJvNmRIZVRkVGFoTUp1V0ow?=
 =?utf-8?B?Qmc2aG4xeDAzVSt2ZjkrVWRkNWxDQVFydkg0cUo3aU91aGNqM2NydWRvUUJQ?=
 =?utf-8?B?VmhpM1VTQTk3Z21VZE1zTGxQNVg0TG5CeVVheEVvV2U3Y3VnUkxjRHVCNWcr?=
 =?utf-8?B?V25sS0tMMUJiWk1Md0dBUFBrazJmYksvZEd1TkFWL0s0K2NvUkY0T2xkRUNz?=
 =?utf-8?B?RG9pR1UxNEZFTVlZOEx0VGdVVngrQXZyWnZWVWtIK1l5Q2lLcm85SjhIczlU?=
 =?utf-8?B?bmRFYWFScUlMSlBEUk5ldHcvSGFiVlBvMkZRQWdMTWVCZDBEajdLOS84dzd6?=
 =?utf-8?B?ajFRYW5aNndqb2FwNEJvR3pDS3VoRzByaXlIRW1lQi8xNXJlSzBjT3EyRm1y?=
 =?utf-8?B?R0ZrSHJTZStFUVNHY1ZBWE84TFNoLzZjdUphUUtPam43ZERLdUpPMGpOc2lw?=
 =?utf-8?B?MkdaUVRjemJLQWhyRkxqSzcya1YzeWNVRndkeWhrQ2tFUUx3L1U5MTdMVjBP?=
 =?utf-8?B?UjZBbnk1THBYMkhsa2xsT0k5d3lhMFdaTnhtdTQxeGE0K0NqQjVlUVhEdVVh?=
 =?utf-8?B?S2g0RGNVNldUTk8rdFNqemJWUHJ5S2E2UW5SRXV6cUlxYkp1SituMnpCcUYy?=
 =?utf-8?B?d0FSOVlZMHFEbnkxNlJndEREMzZvNlgzV1c1VTZ4bmhCMGxYS3VIZnNzYnRq?=
 =?utf-8?B?RUt2d1RjZE9jZmloVWFod25YNVdxczZUc3dQNjBkdzZJWkJhQ3pPSzhVakJO?=
 =?utf-8?B?RXpOOWNodUxWb1E2ekNVbjllU3RGNjd6SWd3Q0lsUTBzSTJIYTBvcldMaFk5?=
 =?utf-8?B?cmVTYUNZamRYYmR0ZVFCVTJPWTRySFU0L2tuQTR0TnV1RkViaGt4QVo1VE9G?=
 =?utf-8?B?M2plbWZiWWZoVzFsb1hmTDl3NlUzZnZZa3p6bis5dmdib25MeG9hdU5manMv?=
 =?utf-8?B?WU56YTlwRHZ3QVFYRUtYa3FsMlQrNXZ3QmJNY2Z3M0I5SkZoS25Gd0x3RHpL?=
 =?utf-8?B?b0tKb2J0MC9QV0poTDBjS1hSK2pHQzZ0TUdORTNQejZZUk5BOHdxeEZadDRK?=
 =?utf-8?B?UlBJQjgyaFdOTFhJbzZnTGVIUXVUNTd0Y0daYlJIanpGOVhBSVhDV1dObDBK?=
 =?utf-8?B?Wnc0WWdTQ0ZNV20zQ1J0YzkxamNEM3JraDFIV2w5blJMWnp4Z1dpR2tmSjJN?=
 =?utf-8?B?Sml4K0xVWFVjSGY1N0o4bys2V0QrRU9ueDBTcVVjYmFrMzJlSHFLMDlBbTRT?=
 =?utf-8?B?enQrNDZLN0Y4Vkw1NEdGRHpZbGpEL2lkalo0VVNGL2lmOU1iSWVjSENDK2NJ?=
 =?utf-8?B?NmVhY05CUFVydWozdktCdFJ4dzZaR0tiUFNabnNQdWtsWE9hdVVmeEVmRFFu?=
 =?utf-8?B?U2pTRXFxaXBuYVZZVTNlMEZJaW5yVDJTMGtRSWR3bzQxK0ZBeDlHSmpUMEtl?=
 =?utf-8?B?bnFza3FxaEFVTFIyY3pYMEdBQVp6NnI1RGhybmhpOFRWMmRwOHVTWjFIaFBr?=
 =?utf-8?B?Yk9hNGd4MGt0RnlWakE1d29aMGZRMmtYa3E0RWRlMm4zNUpCTUk4NUp6T01p?=
 =?utf-8?B?R2NzVmxJTS9CcjVZQkJZOTBrNHZsUENqZm9NSVlPcDFCUVJWVEduSzBpc240?=
 =?utf-8?B?cE9YVlBHemR4aWV0VDJFVkVwb0JtbC9DNFNrQmU4VGE4QjN5TnZPUEVhaUg0?=
 =?utf-8?B?eG5YMGNLcndBMHV6NEVuVWtyTGlhY1RyTkx6M3ZsQjFFb1Z1WkJoejFuRWNI?=
 =?utf-8?Q?7wI8VEe7HN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTJWK3B2VXo3OUhERE0xUTNmdTBBZVhKdktOQTVSVGhtRXVqeVVGanNIRkNI?=
 =?utf-8?B?YXJrdkFzZ1krOEh6OTdMQ2lTZm9OWjEzakFQQUVEZlovMnBVMkwvSTRTVUdi?=
 =?utf-8?B?SW5lS0RVcy9FSTFDYkJxRVRPZCs0U2pHbWZ4RUVVWlFqK1lYWk1OaFUzTnhB?=
 =?utf-8?B?TWRwYUpheWpCa3QwY3hhMmZzWDdjay9SY0FBMDZpNVp2NFUwa2NCdlo0WUl6?=
 =?utf-8?B?SGl3ZmwwVndiS1dWOTJUeW5WVkx0cDNEUTRPT1lsRnFKLzExNmRHME1QU3ZL?=
 =?utf-8?B?K0d6bElNYXRtditnYm9KTlEzZVRJSjI2VXRRRXdYVEppQnlaL3JkOS93b1Uv?=
 =?utf-8?B?UHdUTVRMTTdBbUhYMFlCNGVtbEM5QzBhSUhPSFE4azZVaVM1VTNFTDBhN2Rh?=
 =?utf-8?B?UEZtM0gwYW0xaitXdXBmN3hsdEdXRjlmOUFBQ2tOZmhpVmx1a0FjSXArSHBX?=
 =?utf-8?B?T3RZSkNZUjRlQ3FiME01MU9aWWR6bTlOQ29vL3N2TC9EemI1cWUvTWJjWEhy?=
 =?utf-8?B?L0RxblkwQmtyUktUbkFRSC9XUEZ6YkM2YW9KOFBHY0IwbDh3ZEhXQXlGVjhH?=
 =?utf-8?B?dTlOUzlSdm1zbE01Z2hrM1JOQmJFQ3ZleWs1bUQySkdGS3JGWldiUU90NTRI?=
 =?utf-8?B?SjZjWDJaSk1jckZiQ0RCT2F3Sks5dEkwMjYxYko0a21yVWFONHN4UUt0RzBM?=
 =?utf-8?B?QjNUUXhIeVU0emo2Zk9keGZHTVdrbElHaFBmZHU1TWRJNUMwa0JxYUpFbXZB?=
 =?utf-8?B?aXI5aGRpYml4dmtycjJPcUhMOXJOOEJmbGtBaGM3NHFsSk52OTUyOGxPUmNQ?=
 =?utf-8?B?SW16eFQyREk4SGFVd21ZYUxlaVBkV0VQZ0JSamVwQUdldHpjM2hvVGpLU0U3?=
 =?utf-8?B?Z0wwMUswd1I2Qm1iSS9MZ0MreVh1TW43UWJhS0doQit6QjZuMnFhYi9vRGlD?=
 =?utf-8?B?NjBTYUNIRml5ank0RDhHOVVsWWxJZ3MxVlU3TitZNXZBL1NvY2NpeU5EMUQ1?=
 =?utf-8?B?aVEzZUZOM2l2U3hDTWE5aW5kbEdMaTBPckpDS3kzbWV2bTlQWFlMdlFzanlN?=
 =?utf-8?B?ZEFGcHhMUDdYbmhkZkIvODhOdlduS3NqSm9LN2tSWE11V3BNQUZhOVcvbTRH?=
 =?utf-8?B?NDkxNGd1ZUxUNnYwS0NLRWkwaFJnNDFQb1BhTi8vU09kRTljSE01d2pUL0pQ?=
 =?utf-8?B?WnpBSVpXRXltUnVlcStoZCtiVEFidm12aC94SFcrYzBNVzBIVGw3TnFSN1Yv?=
 =?utf-8?B?WU1VK0VCbGhzMWFCSXZJYjQrd2FvVmR4Qk1FYVNzd3kvSTlvY1o3Ni8vRjFO?=
 =?utf-8?B?eHF1MVl2MmRZRHplVU1GMEJrbnlWMGtCb0I0R3ZTQVhoUjRwTDdUTVcveUEr?=
 =?utf-8?B?cUYxRVBFajdGNU8wTllXT09RTG94MEtGRFRtd3hMdGxhcXRRdGlReTRXTzdw?=
 =?utf-8?B?QXpUOVYrYXp5S1lpL0VoekVINVBGR254WllkV211YWtXamg0NnIxemRwOUtZ?=
 =?utf-8?B?ZjBweXZUTzhyYUl6R2JVdFpqQUcvcXVhRUNJYWdNQWNob1kyaXpqTEEzMW5H?=
 =?utf-8?B?ODR6MmhkVGp4SWIxOTZ3eHIzNEdiMW9qc29xbnk0eGtxcGJwcEQzTCs3bkdn?=
 =?utf-8?B?eHA2QWFXNUg0VHJONytkUlFlVW42QWxtU055bS9DTzU3NDQyUlFZM2VjWWFi?=
 =?utf-8?B?OFgvU0RsZStrNEZ0SlNuTks1MUl2bDFCMjRVVkQ0OUttNUc0YnFCT25ndG1G?=
 =?utf-8?B?M3J4WFlONC9ETGNSR2FSckcyd2I0enRsaGVVMFFQZHU2aUxCR0RDbDFvbGxD?=
 =?utf-8?B?TTBzMUh4SkdtN1BtLzh5aUp6dThBYzkyb200RjhXVmZVMXh6My9kVGU5cUl4?=
 =?utf-8?B?QjgzT09CcU9MRDhMcHVJL1NKaDZhcTB1V2c3LzVMNmdPa1EvWXZ4cEE3dHRo?=
 =?utf-8?B?cmhwSEtBUzV1VHVOeE9CTmdKVFQ4OC9YdjBtUUtkaVBhKzFHaS90RlZ1Z2c4?=
 =?utf-8?B?Z245TFJoY253SnN1amdaQ1FvNlpjL0pNZElrcEx2ZTYyTE04dFJCd2dVN1Vt?=
 =?utf-8?B?RWJSbWczRWMweVhpZzMvNlBCL0Y4NTJ3ZVVHVzJLcXdoSHdoWFUxaWRsWDZh?=
 =?utf-8?Q?OGI+XlwBpDAujpfUdYjPvn17Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb3963b-53bd-4eb4-6465-08dd8f103f1d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:43:30.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQKyLcl7VhlA+hRZTGFsAcwE6wXvIr0u/qO9DMjUgVigHNZjsRBqyiDxrN5o4RNm1L4jJ8ubFUzjozgVKVh8bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999



On 5/1/2025 4:08 AM, Vadim Fedorenko wrote:
> On 28/04/2025 16:02, Raju Rangoju wrote:
>> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
>> be moved to helper functions. Add new helper functions to calculate the
>> mmd_address for v1/v2 of xpcs access.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>> Changes since v1:
>> - add the xgbe_ prefix to new functions
>>
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 63 ++++++++++--------------
>>   1 file changed, 27 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ 
>> ethernet/amd/xgbe/xgbe-dev.c
>> index b51a3666dddb..765f20b24722 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -1041,18 +1041,17 @@ static int xgbe_set_gpio(struct xgbe_prv_data 
>> *pdata, unsigned int gpio)
>>       return 0;
>>   }
>> -static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>> -                 int mmd_reg)
>> +static unsigned int xgbe_get_mmd_address(struct xgbe_prv_data *pdata, 
>> int mmd_reg)
>>   {
>> -    unsigned long flags;
>> -    unsigned int mmd_address, index, offset;
>> -    int mmd_data;
>> -
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    return (mmd_reg & XGBE_ADDR_C45) ?
>> +        mmd_reg & ~XGBE_ADDR_C45 :
>> +        (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +}
>> +static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>> +                      unsigned int mmd_address,
>> +                      unsigned int *index, unsigned int *offset)
>> +{
>>       /* The PCS registers are accessed using mmio. The underlying
>>        * management interface uses indirect addressing to access the MMD
>>        * register sets. This requires accessing of the PCS register in 
>> two
>> @@ -1063,8 +1062,20 @@ static int xgbe_read_mmd_regs_v2(struct 
>> xgbe_prv_data *pdata, int prtad,
>>        * offset 1 bit and reading 16 bits of data.
>>        */
>>       mmd_address <<= 1;
>> -    index = mmd_address & ~pdata->xpcs_window_mask;
>> -    offset = pdata->xpcs_window + (mmd_address & pdata- 
>> >xpcs_window_mask);
>> +    *index = mmd_address & ~pdata->xpcs_window_mask;
>> +    *offset = pdata->xpcs_window + (mmd_address & pdata- 
>> >xpcs_window_mask);
>> +}
>> +
>> +static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>> +                 int mmd_reg)
>> +{
>> +    unsigned long flags;
>> +    unsigned int mmd_address, index, offset;
>> +    int mmd_data;
> 
> Please, follow reverse Xmass tree ordering

Sure, will address it in v3. Thanks.

> 
>> +
>> +    mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
>> +
>> +    xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>>       spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>       XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
>> @@ -1080,23 +1091,9 @@ static void xgbe_write_mmd_regs_v2(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned long flags;
>>       unsigned int mmd_address, index, offset;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
>> -    /* The PCS registers are accessed using mmio. The underlying
>> -     * management interface uses indirect addressing to access the MMD
>> -     * register sets. This requires accessing of the PCS register in two
>> -     * phases, an address phase and a data phase.
>> -     *
>> -     * The mmio interface is based on 16-bit offsets and values. All
>> -     * register offsets must therefore be adjusted by left shifting the
>> -     * offset 1 bit and writing 16 bits of data.
>> -     */
>> -    mmd_address <<= 1;
>> -    index = mmd_address & ~pdata->xpcs_window_mask;
>> -    offset = pdata->xpcs_window + (mmd_address & pdata- 
>> >xpcs_window_mask);
>> +    xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>>       spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>       XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
>> @@ -1111,10 +1108,7 @@ static int xgbe_read_mmd_regs_v1(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned int mmd_address;
>>       int mmd_data;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying APB3
>>        * management interface uses indirect addressing to access the MMD
>> @@ -1139,10 +1133,7 @@ static void xgbe_write_mmd_regs_v1(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned int mmd_address;
>>       unsigned long flags;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying APB3
>>        * management interface uses indirect addressing to access the MMD
> 


