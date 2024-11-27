Return-Path: <netdev+bounces-147610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026D9DAA34
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E2B21D4C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FAB1FF5F8;
	Wed, 27 Nov 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2h6V4/md"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2F1FECB9;
	Wed, 27 Nov 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719412; cv=fail; b=JlKsNAT0cQ0kCIYxONLpjERnBThYcsiDifm8Y3fRZ8xXQuc770w2NxBC2+Qo+rA306pDpO4IoVaowAa7oTp12la4oCaRAFffPIZtS6EbwYzkMvQloIcVumm2ktFY0+kwLLWmRYvk2Xglsm+FAfhhd9xBV98eeQqEIxfCVqv/53k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719412; c=relaxed/simple;
	bh=IzRZ+dEKYeJvKJ49Qt7VOxWkeDVSsxcaDo92kUhzPak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hR3dPZbmjJhNDHGV7wZH79eDBdQieZ1gjuwrKkfLVuBjD4fEY3ZxUi7dpA0qd3zTjHS52SmH1PKHWJ3qMPsJDx1/iLpkaxmOPacesiDVuimXzkS+czhi8f1bVzVkLmb3Ukbe9WEW6wN6oMEqpTB2RrBbBRudHoy0HvxoV/jm1LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2h6V4/md; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8AzaxdzETFge9ZhRlqmBgs8knSamhluyQYAe4797UCsP2QwOkyTi7H8XAJaprGEgcYydC66r3RkcF3o4MNF02bsbLiJvOIlF9fhIQdioSbL/9Ul0Ndve3+T5+a0r/pbvABlWaLLnxFBNO2RdBFGK/sZnUfp1qdV4UY0L3/90BKagNCb/nqWhOcWUzsGc/UaF8YU25eRZ/wCf1qQGdYwD0zJ4g4LXn3JPc0CgH+jyLCifBrhfWfQ8MlhH5hEvRFT1XHSoaApU2u5a7nAy/SzF568xCael1CR9eTuIG1E7Z4jOUj/DxhjmuIN/coHjP3g8JYJUnk5w3Nj1VBgEWAdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWLKcOuFm8N+eWbvJb8Hh1SQKpYInE174qTmKbLWtr4=;
 b=BZfa/1KqmlHD01G1ffbxdXYfYNHswglUy3zrMxIMrRdo3hNkcEYu5XUlPSuP264RPJn+PSTyZHEcmQ/l2XwQ5rCcYFOBhqpyJwgXvQeQDg404Lb0AVH0dwJkl6k+E9L9FzjDx7VdI6Z7QyXVQWgo9C9CK+zi4DZKX40WayC0nyam3DGYtXS8V/Rr4o3i110BhqAKkEoOrsvi25gEC6pjjiP2XKLDCqcmqUiIarP3uLxRAuYEI8E87HlKVQyYhsQtofsm4k8ne1BKe0Rn4o0quWLaCmWPo+m2hDTghpDlEf9dt4I8fDFHYmSlu3t6OWlL6iDLYrlpoiRgVTDLsTmbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWLKcOuFm8N+eWbvJb8Hh1SQKpYInE174qTmKbLWtr4=;
 b=2h6V4/mdy1x6d+WoiaSQNSCixYM+T2MbVg2p345LCDpcJunvMPUaeM9Sjh7yJxXFSa4pyArd8bqyfBdBbjIJ87VdnXu7M7eZ+ZdLvFEOYFQQl7gT6rc7VF6AGsTdkTb8K4dIudPmpCmxDQY8EhX44hehfvDq8/vqQlyONyJHWt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Wed, 27 Nov
 2024 14:56:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 14:56:47 +0000
Message-ID: <e532e691-3d2d-9143-1bf1-1c2e8ff98d44@amd.com>
Date: Wed, 27 Nov 2024 14:56:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
 <Zz6fI-EZYdS5Uw0S@aschofie-mobl2.lan>
 <67a1ded1-c572-efe0-6ba3-d21f5c667aa8@amd.com>
 <Zz-fVWhTOFG4Nek-@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Zz-fVWhTOFG4Nek-@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 5461f358-b3f4-42e7-b38f-08dd0ef3b716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW1HemlxK3VIOUpkZ21ROENHL0RrWTFSV2lHTmJESFJmNnZFVmNTelBRZml6?=
 =?utf-8?B?cWcwUVFPQ0w0WnhxcldlOVhaTEw2TzY2UFladlJ2NFBydS9IU0o2ZzBkemlX?=
 =?utf-8?B?c3p0aDhtQU1MbGJPTTdpVVhCMzhmMDRLK0xDNHNsN2Z2OEtla0JvcW1TcE1p?=
 =?utf-8?B?emllWXRuTVowZUdSQS9EeWlMSm1RZ25sZ3BEdEtJUS9SQk0rMDVUKzNWR1oz?=
 =?utf-8?B?Tk1HZWI2aTBVVTZudWM2bStBSk1KNWdBQ0lNZ1VsSGVLME5XN2E3V0xtSVJt?=
 =?utf-8?B?YzNIRU5MYmtuMGlXWHNVdmswUUNVVUxhSVBERzdJdHk5UG9KWjNxQ2drb2NZ?=
 =?utf-8?B?cTArcXdDSldqYytHUzM0L2FtVkl1NzhzU0JrU25qV3RNdTlNUGxBWXAzWlMz?=
 =?utf-8?B?Z3I3RTFUdU5tTnNLQnFWVWdYOTMrbjg2TGNvMUlSaWtHTkxVS3FzdWFFcUYw?=
 =?utf-8?B?eEU3QVFETkdzQ05tems5OEwyRXVXL3YzZ0hLdHozOG0rTXp1aTA2Sk93U3dE?=
 =?utf-8?B?eHpYQ1hlYkpEU0lhUCtackZoWFZpa3paNklYT3c1aEV2R3k0NzAyam1uU0RT?=
 =?utf-8?B?ZmExd0k5bnBSbldjWVFRZDJPeFJSUHdXMXoxSTBBMHUrLzg4RENjeU5ZN0tv?=
 =?utf-8?B?SGJCOUpwY2VlVUJnOUVMTEFZekQ0N1R4aXkxajdCV0hBTjdTWW41R3o3NFBs?=
 =?utf-8?B?aWpjR1R3RHg3ejd4VitwMk1lYW53bHlzQXloeTQ4T1M0Zy90MEczL20zOVdY?=
 =?utf-8?B?d2ErZmtNRXM5TGlBZFF5dk9jUURIUkhBT2IzbTZkczNEdkU1SnU3VkRzMjR4?=
 =?utf-8?B?em5DeUJEdDZOK21hZUcwRzFqS29KZ0hIWllidmp3SHgvMlk5eW8rK0ZDUHVn?=
 =?utf-8?B?K3h3UUZEVExEU1hiVlNsUWlsaCsxT0xtcEUzejU0SWRuY3V4cHF6M205Tit0?=
 =?utf-8?B?ckhUNXlVcFVWRHkzNldFSmdDWlhPakVjbk5jSXNZSnlBMVU4cjlveG5SQUlm?=
 =?utf-8?B?eit6SFhQU2JyZGFnc2hYSC9PTzhyK1owUlBHMzdITTZjNnZFdzlabG9mQ3Vy?=
 =?utf-8?B?TktnWFNGZ0ZscDVHU2pzY0pYbm9ERVB0NDdhcm1MRHZaamkyNGNHY2dwK2xL?=
 =?utf-8?B?MDdpTXFWemZvSEN0V2swak1UZEtGUE1PMFVpQmUrWUZiNTRaMGEyYWs0WXo3?=
 =?utf-8?B?ZTJmbHVwS1JYYzBJMlJ6M2tzN1MraFZSeUVnRmIzM3dMYlFXeEFsZm9scGN5?=
 =?utf-8?B?SWlNL0dDOWxkT1lzSS9pVWpBZzVRaTBXNTRrVW9tOGxnVjh0M1UvS1c5bTdx?=
 =?utf-8?B?ckNGQmVLNVB0RmE1SDl0cU44TXhYaGN3UmlUNmdHWHBVenJrMmc3Ym5rVVNn?=
 =?utf-8?B?ZERFbENWa1dYOE9TVnBSTjd0ekJDZ3hVTkd3b1p1SXYvaWJoekVHdHZJa0xH?=
 =?utf-8?B?cllFeUY1TVMzQW9SbWRHVkZOU2JWb1YyNjlyc2Z5RC9QWU80TW0vRXM1S3Ez?=
 =?utf-8?B?K0RXSkd3MGcyOTFEK1dqWGZIUk56UUVoc0hUNkJuYWs2aFpmVnVIQ0JETFJP?=
 =?utf-8?B?KzBYbFhFWldyVjJRbmJKQzhvUGNydkp2WjBzTGdzUERRN0I3YXNpUTJMSnNQ?=
 =?utf-8?B?TnduMzFiSUNIdmF0eHVCcXlyMVE1Rmd1NjBFZnorZFA3V3VWVGI2UFVhL2tR?=
 =?utf-8?B?S0p2cTdTZG5VZ3gxenhaYW9xajdMMnNYQjI2RTRBMWRtd01LWXFyb0lSN2dH?=
 =?utf-8?B?UWpHVG9OazllRWxyV29JNUxqZFN6TmF4RS9rNnZ6MkQwVGpSMXBuWGMvSzk4?=
 =?utf-8?B?TmNqRkRhU0tMUm9aSHkvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1FBMUJwUFBPNDZkYnlueXExVy82aWkwUVE1VUFhanFZSHM5L00xZ01YY3FK?=
 =?utf-8?B?TGZnN2lTcjBqcnowOFhKQ25TZVVNdy9oSDdsZGxZWWNhWmdMcHp6eWZEanhD?=
 =?utf-8?B?c3lUSDJ2b2xnT1QxWG16dFhKeEhFRnNZTlVYV0dmaURyV015ek9IMGNsTUI0?=
 =?utf-8?B?ek8wSS9CcmxueGJ1dlVNRHNMT0hLYkRiS2JXNjZVeXE3VEpQOEtwMmJjWkVO?=
 =?utf-8?B?TWRZWFBGRU9kVnR6RmJiTXZITDZiYjNlY1NEdkJaTUdmTDVEKzI1M2J4b2Rs?=
 =?utf-8?B?ZHl0cDA5UzgvbHVkNEU0TmRvdUdnNVJnTWRtZnp3NGllWHhCeW5UL09CTVFx?=
 =?utf-8?B?TXovZDQ4MVRIMUp3ZWhTMTBaeVNkRDAvaHozMk1oRnBTZVVidTRYOTkvZnJy?=
 =?utf-8?B?c2duaXpKRWlIVWhDWjF1M09zM3ZHckNTazUzbUpacUpvRk93WktPd3lDNFI3?=
 =?utf-8?B?MzRubktlRTVJU3A3QURKdm9jVHpxNlZhS3pMTUNqWUtuZUFmc1FLeXlPNDgy?=
 =?utf-8?B?TmU2SWNEVmhndSsrOXRoWWpwMnVCa1JUS050bHVBOEJPcTI3MDFMODZ2VWpS?=
 =?utf-8?B?Z1J1Z1lPeU9QTW5OYmhJbldwVWZGc3N5ZjJpZ2RYdTJwZGZmeWQyOWlOaXhT?=
 =?utf-8?B?NmthR1dhNEFTZXlDV3Nud3prQ3p3cjhQeUdsSVRkZENLWmh3UGptbWZ1YjFx?=
 =?utf-8?B?aGNxbk43WHNBaDNsNWZ0WDFWVlhDYWRFNFVhQmVtVmRDSkE5Q1g4YktmVlJT?=
 =?utf-8?B?QUVRdmRoaFUrR2FHQ2hITVVrSVNqTysxUWkrRGpOeWU2eHJ5Vjg1RWk2WkI4?=
 =?utf-8?B?SkZ4NXU2a21jMExJeWZBV1dMSDF2NG9Wdi9iWUdtdzQxYzdvbURDNVg3d1pw?=
 =?utf-8?B?a3g4VnJXclFUQkkrRElIMW5DK0RrbEc3dTNuWnQxZEZiZHFpWUJoM3VjWEht?=
 =?utf-8?B?SGMxdzE3enZ5anZVTXBJbWpRTmdSUjVyMmVxbmlIR0pKSU1TYkVLMHV1aW9n?=
 =?utf-8?B?SUtHQnAzbVR1OW55VzBYblg4aG1WMzNkUUNQbnZoeG9SeVh3YlJ2d3lWRTRj?=
 =?utf-8?B?OTNMeDFiQk1DU3RjTUw1MGQ5enZhelBvMDl5OWNNbnV0U0VLTDVZdXFTQTJh?=
 =?utf-8?B?d1o1Um16TytQUllOU3BOdDh2RkgwaGwxbGdpQ3dWM0pvVDBjc0k1Z0RPZWEw?=
 =?utf-8?B?WFdHWVduQkFCM0JETUtUVERlN3VucVhXRm9mQnFWSnZTL2taL1BLWjJ5SjFj?=
 =?utf-8?B?eWUzYlpHS1VveWxPcHFFYmZSQ2VkcDVTV1czTm9qdGc0d1dPSUJTaEtRK3h4?=
 =?utf-8?B?MUFZc0NVZ2l5bkdFN0g1WkZGMmwvRkxNa0xLRUo2OUJCRm5IZVRxVXRSZVVh?=
 =?utf-8?B?SVg2SHhibTEzOFp1MjY4K3lzS0Q2S3hmdnA0MitWVDFYSzcvcUJrQVlONWxy?=
 =?utf-8?B?a1BGVUxTUWJ6dmxOUXNXcTNkZ1ZEa2h0Y3RpM1NaUkhxSjJVM1I5WnBRSWZG?=
 =?utf-8?B?aXErNXNUSkpNUk1tdktrOGtwVUNGLzNwTngyTjVxeDhCTCtHaExFclo4WFEw?=
 =?utf-8?B?OUY0ZlYrNkpiR29mUG9oY1laTHZaRDlzOUI5ZkpLRGVYT0xVK2FBTmc1RkQw?=
 =?utf-8?B?Mzhsb3VNSDZSbmJmbi9mT3d2cGRPRFhXM1hYOGp0TmZXTnZxMTdtbDY0M21j?=
 =?utf-8?B?UnpJaVpham9obFVTdjdmSzlRbjB0ZVJKUUh0UzZsczVLMit0VXcvV1paS0Mr?=
 =?utf-8?B?Y3BCYkRvRFExK3lpcFZ0SE5RWWVBb2wyUGRGbWtQMzBKNGgxeGZuam5jbEZO?=
 =?utf-8?B?WGkxL0dzUVBZYXhGOFZNOGxuLzVXcThzcFM0Z1J2WlFtMVZNTEdIeTN4V1Jw?=
 =?utf-8?B?Ty9TOE5Jb2hJUEcya3JFTVgxZ2lGODVVQ1dqMDIrNmZwM2dLb3NiSy9sWS9p?=
 =?utf-8?B?azlqV1ZpTlF1UTVjcEJKdEE5elVMRXYxZ1ZqamtPUTRDZ2JZTFFFeisxZ0Vt?=
 =?utf-8?B?ZmoyTEVRSlB4WWdUdEJEcTFRVHg2RnFoRlhvNXpsTlZFRk51Rld6THkrSDZ4?=
 =?utf-8?B?M3NSQzZ2d0FTaStiQ05lbkJhdzUvZVBxeWFDc0lXc1BLd1lrcE9QZ3BLSWh5?=
 =?utf-8?Q?xkt0qb0WFAwVKjdESQQf5eEhZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5461f358-b3f4-42e7-b38f-08dd0ef3b716
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 14:56:47.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeHyktqj9bpB2StVWhlCKcA1+iL0/OaS1lYSGLAUSYWB0dGx9uosofksjGna6+0RAT2kHPyMns8qz/x55++m4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109


On 11/21/24 21:00, Alison Schofield wrote:
> On Thu, Nov 21, 2024 at 09:22:33AM +0000, Alejandro Lucero Palau wrote:
>> On 11/21/24 02:46, Alison Schofield wrote:
>>> On Mon, Nov 18, 2024 at 04:44:17PM +0000, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> For a resource defined with size zero, resource_contains returns
>>>> always true.
>>>>
>>> I'm not following the premise above -
>>>
>>> Looking at resource_contains() and the changes made below,
>>> it seems the concern is with &cxlds->ram_res or &cxlds->pmem_res
>>> being zero - because we already checked that the second param
>>> 'res' is not zero a few lines above.
>>>
>>> Looking at what happens when r1 is of size 0, I don't see how
>>> resource_contains() returns always true.
>>>
>>> In resource_contains(r1, r2), if r1 is of size 0, r1->start == r1->end.
>>> The func can only return true if r2 is also of size 0 and located at
>>> exactly r1->start. But, in this case, we are not going to get there
>>> because we never send an r2 of size 0.
>>>
>>> For any non-zero size r2 the func will always return false because
>>> the size 0 r1 cannot encompass any range.
>>>
>>> I could be misreading it all ;)
>>
>> The key is to know how a resource with size 0 is initialized, what can be
>> understood looking at DEFINE_RES_NAMED macro. The end field is set as  size
>> - 1.
>>
>> With unsigned variables, as it is the case here, it means to have a resource
>> as big as possible ... if you do not check first the size is not 0.
>>
>> The pmem resource is explicitly initialized inside cxl_accel_state_create in
>> the previous patch, so it has:
>>
>> pmem_res->start = 0, pmem_res.end = 0xffffffffffffffff
>>
>> the resource checked against is defined with, for example, a 256MB size:
>>
>> res.start =0, res.end = 0xfffffff
>>
>>
>> if you then use resource_contains(pmem_res, res), that implies always true,
>> whatever the res range defined.
>>
>>
>> All this confused me as well when facing it initially. I hope this
>> explanation makes sense.
>>
> Thanks for the explanation! I'm wondering if we are leaving a trap for the next
> developer.
>
> resource_contains() seems to have intended that a check for IORESOURCE_UNSET
> would take care of the zero size case:
>
> (5edb93b89f6c resource: Add resource_contains)
>
> and it would if folks used _UNSET. Some check r1->start before calling
> resource_contains().
>
> One option would be to use _UNSET in this case, but that only covers us here,
> and doesn't remove the trap ;)
>
> How about hardening resource_contains():
>
> ie: make resource_contains() return false if either res empty
>
>   /* True iff r1 completely contains r2 */
>   static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>   {
> +       if (!resource_size(r1) || !resource_size(r2))
> +               return false;
>          if (resource_type(r1) != resource_type(r2))
>                  return false;
>          if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
> 		return false;
> 	return r1->start <= r2->start && r1->end >= r2->end;
> }


I can try that. If there is a good reason for not hardening it, we will 
know.

Thanks!


> -- Alison
>
>>> --Alison
>>>
>>>
>>>> Add resource size check before using it.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/cxl/core/hdm.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index 223c273c0cd1..c58d6b8f9b58 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>>>    	cxled->dpa_res = res;
>>>>    	cxled->skip = skipped;
>>>> -	if (resource_contains(&cxlds->pmem_res, res))
>>>> +	if (resource_size(&cxlds->pmem_res) &&
>>>> +	    resource_contains(&cxlds->pmem_res, res)) {
>>>>    		cxled->mode = CXL_DECODER_PMEM;
>>>> -	else if (resource_contains(&cxlds->ram_res, res))
>>>> +	} else if (resource_size(&cxlds->ram_res) &&
>>>> +		   resource_contains(&cxlds->ram_res, res)) {
>>>>    		cxled->mode = CXL_DECODER_RAM;
>>>> +	}
>>>>    	else {
>>>>    		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>>>>    			 port->id, cxled->cxld.id, cxled->dpa_res);
>>>> -- 
>>>> 2.17.1
>>>>
>>>>

