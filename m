Return-Path: <netdev+bounces-225885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87EB98DC4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DE4169012
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07A28643F;
	Wed, 24 Sep 2025 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u08hGiGn"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763B28727C;
	Wed, 24 Sep 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702362; cv=fail; b=Eo9I9P4KicpRmiRWNjlibfvjX3Vyd6NJY9I2PG26n0i+ouqRb23uMs8fxwmoQo8ZqumPMY1sBWJ5k0eH1LpV5DlzMvx4JVEBvCUadv5Q8zhETmEEPq5Y+9MEycd0TdgELv3vQSJjGTS+R4RQJ7uyLriphg7sHZBjnncqDQ1E22Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702362; c=relaxed/simple;
	bh=f/kc1LZAJZMmEAUAYGTegXe24vFD4mIsPfV2X7pNYQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rMCnimY8kva6Ulvhz1J9xYa687qcnE9HSK1jezjgte3gqZeHXwHQMSP00aLgooeLuU1Fv7OCOOsy0VjflWdA5wVbs0gBGTFKXT9YMynyZX5ZprhEkGUwM48Cmh9H0IF3PgudVOIDiUewWLDTv20YuimmHVLhlVqIHOpi85EEYSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u08hGiGn; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYw1h0+19Re9WAEFp9/sE9ds4m8Zy94WC48zFi0mzr41MGKpfAphZhsOUw+V5jwT06PcX+nrOdWfkPt6mZkbAqofWUUdWWqDOGLVIK2BkULCE8MPhwsp5amNrLAJXnUC3xEEHcgCKmMLvnfKKiRvhNSDpRXSzAbQyH+41//jon8MU/JG5bNtFaeAzCMB5sgUGaT6KYZBlxFJE/weHagbiTkWBNCDYZ+etQlR6SA+frO8IG+fAoKXwZYehEvfNAuQwA7uSCGqd53uJXabBsas1IW+CTZeKW6K0FwweBT5bPuhr2I0g9GiLkAx5GPmuJv/zMZRYTcFB9U69Ynn3Gn+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rabdDCqQGrOB/QVNm9xj11D4Z66FP8vdGRx6QAYLo1k=;
 b=NC6esUwC6OydDDwTNa5IoZbzur+lWjoSCLyR8LDNAmB6p1UXlKqzerrwXRvZX2wKr9DTGwgrO/tzGMhF11nlsagMp80kD2cScRe4iknZaO6X3b7QIIciXqQ193hjZLaPZrTgxjb8gwpRrDFMGjzQymbPHoBjj7uCLi2B4G8CmxoMbnLS8IEl4tNK0tXX9C15t0eyuT+LOEZuL5NQ8FCeaeuqh/YQrFJVHauHTZUJwEmiTAnNCKogQdkfDhvoW7xDT7PxcJ/mmub7EtQxw5WUczlWU01iTPyMIz/GsQUmmTaymVIWz4OGDij04fxDI+f4zTXtqsRR54I4VqRjpr1L6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rabdDCqQGrOB/QVNm9xj11D4Z66FP8vdGRx6QAYLo1k=;
 b=u08hGiGnAcSdl0RV64bKpD6wTlYcL4XGVeUoDSDFvCwWE9Fj7EyBes0SCck6MWq9Mp5ee5LsE3ay41WwQELa/bTRPHV9cfrQQmwafoRltGS9GGqRQywxcwqCxyOB+8qqFnzoQlXAtikrN3Wzqer1Fwn33+1OETJHDEWWzB7wsNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 08:25:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:25:55 +0000
Message-ID: <765f9f24-cb26-4eb6-9a44-b215c5ca2a6c@amd.com>
Date: Wed, 24 Sep 2025 09:25:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
 <20250918120348.000028a5@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918120348.000028a5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8c7952-1d94-4109-b11f-08ddfb43fae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTduajVXNy96RUxHcE5OaXNNdHF5MjI5Y0N2NTE2ZjRGKzlKbllMZEVCTi9h?=
 =?utf-8?B?MDJYd2NUQjFkSTY4bmRYL2xhZlp6ZC9YaHpaL3lycVJRS2tRcHE1ZFgxOW04?=
 =?utf-8?B?T1IyWWtBc2loSE1hSDFUQ2FLdS9rL0dsREJZNHdkSkxHejVpdUJxNGJFRXBj?=
 =?utf-8?B?RnJGS1N1OEFFNDBhV0tvTWtyQnA5bTYvdnp2Tm1SZDNuQnJJN0tyeEJvUDdn?=
 =?utf-8?B?UkdhWmhxVVpkUTI3S2RQSnRrTGdhNWgvNFNXSFAvOWtCdHVMTEVJdGNEUGtO?=
 =?utf-8?B?cjNaNFA3Unh3akJqTC9SWi9QbmY5UlJna3Avd1Bxd1EwdlVFeFFkKzlCSExI?=
 =?utf-8?B?bU1aeXM3VHN6M1pYY0ptMTFYVUxZMzJhWnljNURFN3BvTGo4bFZsSGxId0Q5?=
 =?utf-8?B?Um5kYTRmb0Y1MkVxNGl1MzBRVk1YNTNsRGRlOXdMOHk3NW0xK3YyeHJaVEor?=
 =?utf-8?B?QjFUMkxiN3pmVHhvRU5UcCtBc29EbDVEbzhKcUV5ZXFWbXpwb0trQy9MdWV2?=
 =?utf-8?B?bThva3BhMDVDWms4c1J1aE1Vblo0b3J5dXBTbmREMWpXb3gyUnk2U0lmbmFv?=
 =?utf-8?B?dWNJV2JJWHA4WVhHV0IwZmErYkFISEVNWTlVZThGSWpIR2NabXo0NU41L2d1?=
 =?utf-8?B?bkE5czZETThLSkNhazJJVll6RnYrS0YwbHBQRi9Ecm9IYnRidkF6cFZYaVNL?=
 =?utf-8?B?VEZ6dGdkK0RaOStTRGgzbmZ0N2xrQVNsR0tlS1l5KzNGR1VTdXUxRkNRdFZP?=
 =?utf-8?B?TU1nZmR5UWliQ2hUdkhzL0pRT28rSlIzUDN6MUt0dzhvdVMzdC9xK1ZPdXMv?=
 =?utf-8?B?V2x3dHh6MXlRdlloUlpaSmRiVXNTNGtza1QxNEtJam5HU284N2lTaENYaDdJ?=
 =?utf-8?B?dk1TMG82OFZsT045OEtnV3hkejJXUjIwZkVPMUNQMWNTdWZ2blNVVU1uWDRH?=
 =?utf-8?B?dVBpSldITmNnbm1PTUJUQVBiUmtneCtCSE9talgyUldVNnFVV01Ld21FRksr?=
 =?utf-8?B?N2hGSStCMXlZaUpMUWQwbTRnQ1UyVmd5TE82QTB6cWxpTnMxcUd2YXJaK2dx?=
 =?utf-8?B?UUNKRWxVUEpGWXRQblpvN3VvSzBJUkNwZ1g0ck5mdFl4WmtGamVLQ0Urc0FF?=
 =?utf-8?B?aURiTmhIVXlhNVhYUk5pZnFVLy8xcWJoOWJnSnlUQVFuWHVZOUQyazZsMEl1?=
 =?utf-8?B?WktCaVFLUVEwTERpcFNaeUpwT01nUVVMOHp6ZTJRVjhsTStBNzJiOEo2U3gz?=
 =?utf-8?B?RXY0M1FCYTRLeTJFV011cGY0WUJLbDQ0Y3QvREdPVEJSYzNpT2J1bUpBdlZR?=
 =?utf-8?B?cGtiUzhoUWZPWlFPU2NuM0hySjJ2OW1jM01GRFFWK1YzYklyZUdOcHVaODM4?=
 =?utf-8?B?S291Uzh3Y2hYeGV3TVRnN0dQMlh1UVdSd1IwWS9vQTUxclo0TWRzaG5sbG1t?=
 =?utf-8?B?NkpiWUg0QUh5QnU1ODlxdjZJdWVEZEZ2c0R4Z3UyaXBJeG9tM3NUTFdDVDNq?=
 =?utf-8?B?UUZJazMwaFVuQ2V2dG5sQVcxZlNmbDdyQWUvQ0U3RXFwMUVMZ2NMU1V0TTZO?=
 =?utf-8?B?NXE1ampRMUx1LzF2bi9Udlk4dGwwakVjSjA3Z2VRZjBuaXZMbHp6Y1QwU2p2?=
 =?utf-8?B?YkJvaXd4RVYxdjFYU3VzdmZDWGJIK2loT1k5RUI3Wnl1aW5YaHZXUVBOdE1z?=
 =?utf-8?B?TjllVjhWeERmL254eUtOYzFkSU9WbWlVQ0NVY2tXMG1yaUZRTlVIRFpwMzhV?=
 =?utf-8?B?UlR1clNrV3VrMTYxRnVUbWVBeTVLT2ZkNDNaOUdlYmk5QTVxM2kvNDJlTmEy?=
 =?utf-8?B?N3QveWxEbDJRRDJ5U2ZDMmowSmdvNWR1SzhLK2ZTT2N2aGo5dXJzbmxvNlFH?=
 =?utf-8?B?eGtvb1BjOXBnYXhsc1ZMYXJxYU0relNiTmdMWTVscjRIRDN0bXRyTXNwRlg2?=
 =?utf-8?Q?LEWrN8/+B+I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGhtOTgvSlVUSjdkT3h5U2llMW5ONU9tUGtFL2xyVVk0ZDhJN05zenc3Ukpv?=
 =?utf-8?B?Y2Ftd1k1MDBVeWUrcG5Tdng5QTRhTDhsRGZ4Vk5NUjY3NW5iNjlvRUZ5RU13?=
 =?utf-8?B?aWk4L3g3eWFkR2dLKzkrZk5wR0p0MGRNM1BCR3pBZGV3eHhIOHo2SEVNTmp4?=
 =?utf-8?B?Y2hRV1IwM0N1dEJIQ0doZXRlc0xwUHNHZEFlMzdzZFNYT3dNYVZRTWxlN3lP?=
 =?utf-8?B?UnFjL0ZKQ3pzbXlWTWRBTmRTUnp0TXJTM2hWVmkrQXV0SVBad1krS3JKU3J5?=
 =?utf-8?B?VUFDclVaYzVGcGZIbXRSVmpwMXFTeVJIOVllaFFZNlVKTzhidHVNZE5ocjFY?=
 =?utf-8?B?NjdFWlZ1OGtxOUxFTERsbDlUZUFzMVpCZE5xSzBlVGdtN2VBMmtZZkRlTlNj?=
 =?utf-8?B?VW1Nb0gzaWhZNGdURjY3Vkg2MzJ2MFVVSjkwcEplSTNIMDNXaW1kOUplM0VO?=
 =?utf-8?B?a0dIamE2Q3lXT2xyQVdYclNPcFhyMEVGQjN1dHlpbG83NHlrRDcrSEZaMWJI?=
 =?utf-8?B?azFLaGZ0M3o2eEh0U1NESzUxZ3ljNUlJcURkSEFZVkZuc29jNGR0Vm92UGR4?=
 =?utf-8?B?a3l2RXIvM0t2Yk5RZUI0bkE1V0QwNEtaNXowaTBiTTZUYStFaUFSQnNjaFQ4?=
 =?utf-8?B?STFocG5USVJCUnA5UGtBQTZjUUhXSUJZVllocjJCZXN3R2dqS0N4MGdIZVFS?=
 =?utf-8?B?TG5FYldZazhEeEZwWDBBRy9FdkhLNWV0VnpRMndQT3dDSm9ndFNLQ21TVGl4?=
 =?utf-8?B?MjVSVllYYUJKaUhVSkZVemlDNDljNFZTMFpRN0taaDQvUGpBSDRCSlJPT3p5?=
 =?utf-8?B?cHF6cjIvM1YvVXIrWCsxTjBDdCtPUnMyeHpYa2wwaVIvTVhGUmNvNXNBcUFw?=
 =?utf-8?B?dmtHWTFvOUE5L3dzSXhrb2dGbStVVytwOHlGcDMzc2FGRmt3Q0ZZajhHN3FN?=
 =?utf-8?B?dTBOMzBZZmI4ODU3REdnSFNPMjNiMWxtUmEvT1NSU2dYaHZsKzhpUlc2NVAw?=
 =?utf-8?B?SGhLYzBRUTdUQzJneWwyMVkvN3lVQzFRMDNzY2JwR2t4QisybFdEcFJQNmxY?=
 =?utf-8?B?NWdTZGdPck9QbWhQRnozOEtKOXRTNEVyL0JuT2dmZndoZ2xaMXhoeGw3YnEx?=
 =?utf-8?B?OFgxZmRyZHZ3WVhlZjNReFdNcGhUZENNWVRFT1hwQjBxVUEySnc3WHJYRFVD?=
 =?utf-8?B?RVY3RDhPdzJEelkzckZCU3pzZkxyUzhFeXlsaDhOMGM0ekUwNENoRURNZ2dw?=
 =?utf-8?B?M05xcVEvVkFiN1h6SjR2bVRZOUpLQ2QvRWlLbzJNdk9qdkxlbDd5WHBmTStF?=
 =?utf-8?B?anptUEZoK1MyQmplUTArTm02a3B3M2cvK2lDM0p1VWYwMC83NlNJWlFTcnJW?=
 =?utf-8?B?c2dJeWJBY2oyWlFpQ2tPUVdBdXhIVXp5b3UrRzFHSjg4Wk9Gdk83amFpMjZT?=
 =?utf-8?B?NWd6UkhzUXV5SkNqMHJLbzV2T3RGSmpvdEw5Y2RjQzJmSnFuTkNKb2xBQVNP?=
 =?utf-8?B?SzRyUk56VFo2a1IyZkRuYU1QQ0o2a1NYS1Z1OXlOOVd0WUNNbFNpZFhiVi9G?=
 =?utf-8?B?YVNRWjlVVVRRME1wMzVsc1E3OHBNMUVjZGduUTJVbVQ2dTlHQUg1WVIyNm9n?=
 =?utf-8?B?T1Y2YkZWMlZ0Q0o2RE5wWDh1amVFa2ZXVjFHU2RDOXNzUEZQcE5vN3M2bUgv?=
 =?utf-8?B?bXFyVjlPckxuTWdTUlJITEcwL09TUUtEV3F4bExIdmFzOStuSDZnUWdOTjkx?=
 =?utf-8?B?a3kxWXVuTkJveUp3TXBTejlmNHNMWDRicFUrNjhpVGludG5jRU1WNFdPdzhj?=
 =?utf-8?B?QzM4YkMrVXcrVUFhdENPUlM1eDkrWU9uZ3hQRjVaeWFSaGtnUVp4Y3VsczRR?=
 =?utf-8?B?NWtwYThzUTVkM3pXWXI0N3RKNTNYYUUrUmFuS3NpOTNtMk5reGROWXNaS0V6?=
 =?utf-8?B?NnRRMDcvdHdVS0QrdFFYY29ZN1hrcWZuTldFUUpIS3RNcHVwUHVQTDlmU3Y4?=
 =?utf-8?B?OE1VMjZNcW5vMkliVFlCNnAzZG5HWGFVNXNab1RWNEt6K013TTk2cjhnbWlm?=
 =?utf-8?B?bFJ2emU4WkhRaDV3d2I1TkYxRTI4THM2KzlUbGZrMWFyalBSRE9pTkxzZXNG?=
 =?utf-8?Q?EHyXpSwI2aAhMi7pPVNRl/0kh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8c7952-1d94-4109-b11f-08ddfb43fae9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:25:55.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrLx0NdCZrVldTF9HXSUk1sO8/M1xDyYQGgpJI3WDjHZxINc5kTy77X7qPlzF4hdA54m/kTOtobuHXnctek5WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294


On 9/18/25 12:03, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 10:17:30 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Export cxl core functions for a Type2 driver being able to discover and
>> map the device component registers.
>>
>> Use it in sfc driver cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 56d148318636..cdfbe546d8d8 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2025, Advanced Micro Devices, Inc.
>>    */
>>   
>> +#include <cxl/cxl.h>
>>   #include <cxl/pci.h>
>>   #include <linux/pci.h>
>>   
>> @@ -19,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -45,6 +47,37 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxl->cxlds.reg_map);
>> +	if (rc) {
>> +		dev_err(&pci_dev->dev, "No component registers (err=%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
>> +		dev_err(&pci_dev->dev, "Expected HDM component register not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.ras.valid)
>> +		return dev_err_probe(&pci_dev->dev, -ENODEV,
>> +				     "Expected RAS component register not found\n");
> Why the mix of dev_err() and dev_err_probe()?
> I'd prefer dev_err_probe() for all these, but we definitely don't
> want a mix.


I'll use dev_err_probe here and in following patches extending sfc cxl 
functionality.


>> +
>> +	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
>> +				    &cxl->cxlds.regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc) {
>> +		dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * Set media ready explicitly as there are neither mailbox for checking
>> +	 * this state nor the CXL register involved, both not mandatory for
>> +	 * type2.
>> +	 */
>> +	cxl->cxlds.media_ready = true;
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 13d448686189..3b9c8cb187a3 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> +/**
>> + * cxl_map_component_regs - map cxl component registers
>> + *
> Why 2 blank lines?


I'll fix it.


Thanks!


>
>> + *
>> + * @map: cxl register map to update with the mappings
>> + * @regs: cxl component registers to work with
>> + * @map_mask: cxl component regs to map
>> + *
>> + * Returns integer: success (0) or error (-ENOMEM)
>> + *
>> + * Made public for Type2 driver support.
>> + */
>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>> +			   unsigned long map_mask);
>>   #endif /* __CXL_CXL_H__ */
> 		       struct cxl_register_map *map);
>

