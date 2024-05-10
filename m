Return-Path: <netdev+bounces-95594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407CF8C2BEA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DD52833C5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 21:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC4713B5AB;
	Fri, 10 May 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJcryAtv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F71BDC8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376659; cv=fail; b=AyKtwvZTuUR6obS6IoF3nqo0/BWiVTs5Qig9vWUX+7z8VB6kJJPxbABrGtteEJxYyAZbX3iMdaXvUP+Bzihmtk1sbkovsJ3O1cdb6YgUUfh8SH4pr21zuKr7bYRKjy0OQu2Xh0GvrvCMTkREn1IpNJynnUPO4lvZ/bC0PePWCnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376659; c=relaxed/simple;
	bh=ACwNuY9zCOTDRyZHDjemFIEgwb0WU84gAAFqFTrj7Sg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QL1z82ZtGyEjfbLjA1Wst7qXMuurGTw0Db89aqcuKCm/j8CHPkf0ELufiiZFsKcQ02V7VouvbTpzgB1iIaTpaSSeVrYtrzussbEOG83yHAPebrjOpgacopUPqnq4N5qeXVqDpOVoZpaJOgJe56vzyVZxdEXEyE2otX1/Xb3GhRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJcryAtv; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P59gE9fgdj9X4Sxn/1D9TXct9CjPu/0b9bk01vxUeeLCopnC0CFmFIppeD4U3oxvhl+lhLcPcmQVDAPJTp3A53TmYQXJzt6wp5S70+S5lppDX0ZCMNrUuPJRfhJ0QRAUMvcdloTeOeeBlUOT3vX3qktGK/I1olhbjmXcAu8maTMhhP7qDaMKqZHuU0T4ceRoIzJoDr0PIhK0l6nEBqc9z5Bn6ZfVa40nBE3h+OS8ccVQD41jbJzGP4eInAi7xkCsNk1ezc6dnahFJXO5Mjd6epk4stlA0smZdL8sMYCYAP1kzgi87Usa4VhOO1ebL0yRBgC98U709Bw7LIf8OCKeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Hwfq3fU6Jry05VemNfxzOmLPlQlwEo+YvW9HInvLU0=;
 b=US96HAofyeC8lm7047Am76ZTKf2Z//6VHryDiP1goJfOdM0TQub6/HhDD7iLYbc8BvypIjyJXG9zygP0KPoFlpC+6blhTTkXe7+xd0+AI53FmbNi+4AfNWdiQIoY0mzRTwMF/3OyWcz5HaRlQ4JVSVykdN8ZORwXYOWAjrMJzqlDwg0AtdaPCF0FQNmeq1PQqtBByVBEr6qSmw1u56Ktl2lMGwu+WuZryOtfCkNz0XOR/J46arUfJ1dh7+7Pe10QCMDGlPUjSPj4/CGj0zAD/ppptqHQSsPg+BjeK6oYYMd1TIz7NNcQj07ACUnM8x9IyXKdzKsvOy4UG3Qo1S1ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Hwfq3fU6Jry05VemNfxzOmLPlQlwEo+YvW9HInvLU0=;
 b=XJcryAtvUuGHv1ndF4XseCpHugxdl8pDRLPCa1NkSJuqWIwiJ112z0RH58AF9oW0Q79d2UtYdVEKwJSd+dFNSUV0znynjm2QgLfocgwYnQs+Ahji525KTjnd85IkHzB27d0DFa2qQdDo1u46++0tpx8RDf3S+vuf3pQDR14vbsKGm4e1pm57nHJy/HIzJgr3N3OltocNHIOl6c3xhYDw52+qLjaAF89DNTU63FN5UX6R1UINUtTpwo/mnZ30M5fsTvssvBU1cVTc2j0xbg/VNj2uJGv0fsB3cRqTFmjfjD3Um76uzgcnMEWum0F+w23s75zgclBs0FUFfGVhPolClQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 21:30:54 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 21:30:54 +0000
Message-ID: <a053a34a-b014-45ca-87bd-425570f16da1@nvidia.com>
Date: Fri, 10 May 2024 14:30:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
From: William Tu <witu@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <20240506203207.1307971-1-witu@nvidia.com>
 <20240507212436.75c799ad@hermes.local>
 <e4478663-bbae-40fa-bc85-bbd75e83a37c@nvidia.com>
Content-Language: en-US
In-Reply-To: <e4478663-bbae-40fa-bc85-bbd75e83a37c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0112.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::14) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcb162a-deb6-4856-da4b-08dc713878c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qzl1SGt0ZzZxZHpRT1RicEdsV0QxOURkNVMyNnRtM29rNnZ5WU5UTWZEak80?=
 =?utf-8?B?Q1RWejlIZ045NnlYU2wzWHRtT0V5Q1FmMGJSMGYwQkVSSVJXWUl1dCt5NUJl?=
 =?utf-8?B?VGFzYnd0NXkrWUxJZ3RoeUsxS1dIdE9XQ2l5VmZobmgwWkx4b1BVWTdiZlhY?=
 =?utf-8?B?a3hqZmM4bUxZcHZBMTdBOGhZZ1ZWUDRjQ2taQndKV0NQVml4U3BwclJBbXps?=
 =?utf-8?B?ZGl1ZytvYmxXWHJBV2dBZkEvcnE5RDNXcVh0N1lHaHhjYzAyTGU3NmVsV1du?=
 =?utf-8?B?ZlZQcUVLaTZhdmsxSUlyVEdoZkpJNFpPa3hRRUhNWGZZSzVQenRoL280L0xG?=
 =?utf-8?B?dkgzbVZxNzZuL2pjb3BSNDFBUzhJKy9OQno0RjJIZGVDN0FDT1BPQ3Z6VE55?=
 =?utf-8?B?MFJZOEVYbStpSHZBZHpZeUlWSmViNWFXeTJkRHhrd1VWdmtOQ21XemU2MVFh?=
 =?utf-8?B?RTZEQUx4VExHQ2dNMDBXRW5paHEvb2ZSSE1jSWRjVGpSS2VEa0kvQ3F1Vnll?=
 =?utf-8?B?aTRvSklGajY1ODh6aG9jQ0ZnSHc0QkVqY3NYc2pKSnpsWjNiTEFvZDBIbTky?=
 =?utf-8?B?NlQ5ays3WVpnUDdkNzMyNXgxdUNjY2IvWGdhRHZJWnJyUGI1RFVHQVNFazNy?=
 =?utf-8?B?NXlvT2FPcnZQMEh1Z1RSOFZQcnkxZFY2SXNoaW5wdEtMQlI3YXZxcENjSjNR?=
 =?utf-8?B?a0hqMmhTZVJYbjNXRGNyMlkzMlFmaFIxQUs1U2VONXBvQkJBODZGMytmNGRT?=
 =?utf-8?B?VHN5UWVxSkZCUmdKMzl6QkZCcDVUMzhKejlHMXoxek51eko5R3k3SVd1Nm8x?=
 =?utf-8?B?WTJKa3d1WkNvdm83Zk41VE50L2ZYdDFrMkV4TWEydUt4Y1YxZC9GRWZYLys3?=
 =?utf-8?B?U0Y0clFvc0YvanhDN293R1MyWDVQVktaMTI4OEpqdlNnSXlhK28wRmVzTUpO?=
 =?utf-8?B?bjY1ckwwSlBIRnFQUlEvcHd4Szh6TUVLVFhXMm5TREJFK1F6ODNIL1owNUQ1?=
 =?utf-8?B?U2xDK2FBWkduMi9BMTZVeEl0S0ZObmxiQnJjb0s5amdiL0VVaWhUaEtOSjUz?=
 =?utf-8?B?UzM0U1NGbDZZRjJGVXhKQ2xmbkxqOENyUXVScTFEZ0R6dVlrbFNNSFRERnFL?=
 =?utf-8?B?aFpjY2NJRWtFVHBXNEltcFRVTVphaUkvaGFYWkF6cXRwaFJBclcydmdEY2pt?=
 =?utf-8?B?MEVITWNmZ2JuK0JROS9heXpPVW5IbnROM0ExYWxRQ1NJSTNIR2o4azBjM2xH?=
 =?utf-8?B?MU5tcHFxTElaSWs4alVzcEUxSXNKMDBkb3pjZ0FEVk9OU3Z5ZGZjbncxWUE2?=
 =?utf-8?B?S1BZUnhYa2VNNGs5a3RpcE4xclg3L0wrTU8vUlpBdU9IM25ESzRBQ3F6MUFT?=
 =?utf-8?B?U3YvZVFRL0xwSlNORjN2UEEwNzNneHp0NEVGNGNyTGZHTmxsUThiZjBFbzdn?=
 =?utf-8?B?TGg0YUpCUkc3NGJKM0t2SzhhU085NDZYTUtMWnZLOVNKK3dIdnhNbDlMWFBw?=
 =?utf-8?B?bWtxbk1JWVBRU1Rwc1dJOSs4elNWQmdqRTQraFphcUpsM1RTOEN0VFVPQ3ZW?=
 =?utf-8?B?Y3hvd1Fub0UweHFwUFRNenVtY093dDBmRVdMQVFFQjM5MFd5L0MxaUJwMUxJ?=
 =?utf-8?B?QzBzRGZweGovUkZiSnFNcmgvTEpUTS9nTTRJVVRwc1ljaTYxS0o1dDZkcFJu?=
 =?utf-8?B?Ym1DNjVwQ3NpWWJBanlmSEhJT2h6bVRMR1VHTnd0SlZWcmNpNHV4UWtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGNXQ1RUVXh1WTVxOWxZQTU2dHRSOHQ0dGIrd2RNRVNJbEtCcjVhZldEWncz?=
 =?utf-8?B?U3hIN1ltTlpIN2h5VkovcXRlb0dJNTJTMWxCUGhOZDN5RFpEdXcrWXd3NGp3?=
 =?utf-8?B?SENUNHpWM2Q0RUI2WGRQTS9iWEplL25BUXMzR1AyZGEyclZoWTR4dWtRWlNU?=
 =?utf-8?B?MTVzNHlvRXQwV1UyVW9Rb1Nwa2kxUVZ1OTFkdHVsWkhmd0pHYzRQK0g3b1Fk?=
 =?utf-8?B?NFBBMXRqNlRMQjBYMDlSMUVSVFBmVDU2ellwWk85R0lSUkQvRnFWaFVVc1ls?=
 =?utf-8?B?anR2WGltZG9wbXRmS0pCZVBsWnM5cHVEUCsvNWF3Q0hTN2JyWlo0N2JuVG1U?=
 =?utf-8?B?dU84Mk5FdDFaOHVxNGVLbUM3eW5SZkh0YTNHZ1NKT3dVVjRhNDU2bXFCT1RR?=
 =?utf-8?B?R21BclFSd3pQN3FSc3pIMFZ5MHBZd3ZGbjJCNXVWZ2NkNTFrUVFydGRMMS9O?=
 =?utf-8?B?alBOMDFlQll0ZVVyV2ZXejlOdnh1OGhHdzMxY1F0ZTZnZWF1L3hMMXJPbTF5?=
 =?utf-8?B?UU81VlhUSHRHcmNGc0Q4VnBGM2gyb3FOMHpWVTVrcGh3M3lQcjB5TUQxNUJl?=
 =?utf-8?B?V3RpVk1sQkNIV2t6YmNpUXVNM01PdWdHYW91WDUrL0gvYXNmK1p1RkJEVW9T?=
 =?utf-8?B?N1NVUkp6V1RjNFNPWGhEdndIeXZUeWcwSG5RbWNycGFNVjMrUGd0US90UWpF?=
 =?utf-8?B?SUF0dGZtMkhUVzB5dC9RVmlZQ3dKQUI3SE16Snh0UzBOSVlCdDhyakt6TWow?=
 =?utf-8?B?RHdTZXlsbzVuenNaSEs3MVVUcWQzNjJqZ0sweVZnYld5ZC9EazBxQ1E1NFcx?=
 =?utf-8?B?TjRLZ29EUVJNTlZ2b1lBUTAza3lDNSt0M2NLa3FiaUp6NEdWRmt3Z3c0MkU5?=
 =?utf-8?B?S0JzVU1XMFR4Vm1IQjUrM0x1WDVqcGhheEIrTTFlSWxGZlEzcUZNeGRXUWRB?=
 =?utf-8?B?UmJmc2k0VTF5TTFmdlBkYmU1L05MVldHVDJUNHBnNzZsU0RpdkhHelI0Wm9N?=
 =?utf-8?B?R2Z3S240YU5rZVIxbVRXcE9LcnJjSllNL0x4VUpKUTdYR2lCbXZVKy9SM2RJ?=
 =?utf-8?B?UEpIdkxCSTFYZmxQUlNyVDI2RmRHS2ltTjBZRTV0T2lMRlpuYVAxTHd3T2xP?=
 =?utf-8?B?cDhPZ3JoRTUxSzFUL01VdVM2SnpSMDZIeW1wNFpsWG5JZ3pOcmN5eTFmaDVU?=
 =?utf-8?B?TCtIcy9BTmxTSkwwVEtDbUNueFRCNS80ODJDS1MvTlJLTVVTN2ErdTRVNWEx?=
 =?utf-8?B?OVNRUzlNR3NqaG13NWV4cVU5Z0dkZ3ZoNUhoVlZpSHlYaU5TdVlEQnFpSE5s?=
 =?utf-8?B?Zm85VkRjMVVkYStybEdOTFlQSkNPN2NUSm1PS1pLNThiZWlDQlNwTDFsNG94?=
 =?utf-8?B?SnU5TDN6K0txdHhtL2xhRjNLYVRGWnJuWUVJR3BFNE1aUktrNktXbi8rSXdN?=
 =?utf-8?B?NUU3Sy82NUNuS0dDMFh1R2d3T0pkay93ZFZmanViUitWQXJXMFRPRmE3SldQ?=
 =?utf-8?B?TFdaZDVBN1JLdStQL1VVZHl2TzEwemdVTkRmUEFPTkZ2aFNDWEpSQS8xYjhi?=
 =?utf-8?B?RTZJdndmT3UydVZxb0V1alhCL3laSEtpQ0t5ZURlRVIxSHRuZ2g0OHBzZEtX?=
 =?utf-8?B?MTFCbDMyUmFaT2had1JYazkvY2ZycUpnanA5MzJZU3hoS3ZhREVBbHQwRGhZ?=
 =?utf-8?B?czl0cWlnOUJ0dFpwSHF1N3NsaG1qcFZMUFVJZXkrQ1IxdGQ0b2ZvcEs3eTVs?=
 =?utf-8?B?czQwN3BpZGpmUTNnc2J4bWVpWUdaRTN1QS9Tc0I1R0NEOGp4ZVY1anhVUkVh?=
 =?utf-8?B?RWFKTWdobzZHVUgzWVRRRFJucmhGQmM5NlNZR0xkeWQ4SnIzUWtHOEdrOFBp?=
 =?utf-8?B?Mm9iUkg2amJGM2R5enF2dlRmS3pwbWs4TGRYOWFGUjg3WUpPY2RHa29VVzlM?=
 =?utf-8?B?aVFEWUdiVXRDbVNNcDdNbE8zT3hsM3hBSWhqUmhmSVBWcUpRb0hDQjVSakVy?=
 =?utf-8?B?R05jSnBEOGFzOFBKdGJlMVB1TVhLL0VycGU3OXZNV1ZQY0ltSTJ2dnBlVGhy?=
 =?utf-8?B?bG5tSzJTVG8vcWhBTFplUUFxeFJrRzdsYVJQVG9LVnZYUnNGcUh5bXkydUFa?=
 =?utf-8?Q?TgoAwsHplNo3tbDFeEMTxTXOu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcb162a-deb6-4856-da4b-08dc713878c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 21:30:54.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjGyDipE3HPTUdk5L+usegLEGQUUR3i4khdVlGfK2e3MonousMA3MYK13Jo5PI2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164



On 5/8/24 8:27 PM, William Tu wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/7/24 9:24 PM, Stephen Hemminger wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, 6 May 2024 20:32:07 +0000
>> William Tu <witu@nvidia.com> wrote:
>>
>>> When a system has around 1000 netdevs, adding the 1001st device becomes
>>> very slow. The devlink command to create an SF
>>>    $ devlink port add pci/0000:03:00.0 flavour pcisf \
>>>      pfnum 0 sfnum 1001
>>> takes around 5 seconds, and Linux perf and flamegraph show 19% of time
>>> spent on __dev_alloc_name() [1].
>>>
>>> The reason is that devlink first requests for next available "eth%d".
>>> And __dev_alloc_name will scan all existing netdev to match on "ethN",
>>> set N to a 'inuse' bitmap, and find/return next available number,
>>> in our case eth0.
>>>
>>> And later on based on udev rule, we renamed it from eth0 to
>>> "en3f0pf0sf1001" and with altname below
>>>    14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
>>>        altname enp3s0f0npf0sf1001
>>>
>>> So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
>>> devices + 1k altnames, the __dev_alloc_name spends lots of time goint
>>> through all existing netdev and try to build the 'inuse' bitmap of
>>> pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
>>> every time.
>>>
>>> I want to see if it makes sense to save/cache the result, or is there
>>> any way to not go through the 'eth%d' pattern search. The RFC patch
>>> adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It 
>>> saves
>>> pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
>>> scanning all existing netdevs.
>>>
>>> Note: code is working just for quick performance benchmark, and still
>>> missing lots of stuff. Using hlist seems to overkill, as I think
>>> we only have few patterns
>>> $ git grep alloc_netdev drivers/ net/ | grep %d
>>>
>>> 1. https://github.com/williamtu/net-next/issues/1
>>>
>>> Signed-off-by: William Tu <witu@nvidia.com>
> Hi Stephen,
> Thanks for your feedback.
>> Actual patch is bit of a mess, with commented out code, leftover 
>> printks,
>> random whitespace changes. Please fix that.
> Yes, working on it.
>>
>> The issue is that bitmap gets to be large and adds bloat to embedded 
>> devices.
> the bitmap size is fixed (8*PAGE_SIZE), set_bit is also fast. It's just
> that for each new device, we always re-scan all existing netdevs, set
> bit map, and then free the bitmap.
>>
>> Perhaps you could either force devlink to use the same device each 
>> time (eth0)
>> if it is going to be renamed anyway.
> It is working like that now (with udev) in my slow environment. So it's
> always getting eth0, (because bitmap is all 0s), and udev renames it to
> enp0xxx. Then next time rescan and since eth0 is still available,
> __dev_alloc_name still returns eth0, and udev renames it again, and next
> device creations follows the same, and the time to rescan gets longer
> and longer.
>
> Regards,
> William
>
>
Hi Stephen and Paoblo,

Today I realize this isn't an issue.
Basically my perf result doesn't get the full picture. The 19% of time 
spent on __dev_alloc_name seems to be OK, becuase:
$ time devlink port add pci/0000:03:00.0 flavour pcisf \
pfnum 0 sfnum 1001
real 0m1.440s
user 0m0.000s
sys 0m0.004s
It's just the 19% of the 'sys' time, not real time.

Thanks for your suggestions
William



