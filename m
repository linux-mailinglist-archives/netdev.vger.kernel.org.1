Return-Path: <netdev+bounces-211875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508BB1C24A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7803B53EC
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7A288533;
	Wed,  6 Aug 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fpVeMQ+x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C312882C0;
	Wed,  6 Aug 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469483; cv=fail; b=E8in+8kJ1UryT9pIelZPcczl3m694XTB7r5XfGZYY2P78pBP+S27ki36J4/NX07fqae2jYYu0wl5gbkvc8bjPRHk0HM1t8orgtvHYXnWc/l0jQktmNlEgGZHqCk5LQJIwKELjPlqfCXTJiRO114yhmaSxSQkb9UUwTGEg4yAOGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469483; c=relaxed/simple;
	bh=N1lK6tSMnk3ap18/P+R3aItMgXfBmdQqEfzCgB+Pcts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAfn/mp3XmMo0/pUmuK8HTwVA7pWpm3Nnub9tEozB1TAjl2vk4IGEMvc2ES2+nT3nY+Z+m8xqfIgX34p4WxFFBgZq/ikTlovu0gMA5QZ/yQ/w5U3mNhQLVqswoU4j0YN6EO8txtjmYVgDsbvznRLfm1BJzf9wgW86L4h3tOs5O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fpVeMQ+x; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a757Wxic5cSK1+dCL+CcShdpZMsIAw/FXJzMmnALMn6DbWoIJon61xjpia5iqqP1ZCEr53CBBRYXyFCPQQE+RQ1j0pQnwG2L1eBIgJp0Tm3fXAFTp1cO3JUlkOOwuxi3A22hL1CMsC13c3eJXMh68fl1+RvdApqLuM+Z5mn8nEFCBJaCzxeA/7lBP/XXxCh1+/tgNIFD/+/caYutYiCNmhs3aewvYfkgNffGcor5EvY597p6/yofRPFLSkjeKi6rlLukxzNhGHskm9ofJCZkj/RtP2m1KuFNMGHOnhMDg1C2LHw+MICtRo5NFsNnNFc2D6wYwF7zKe/wZVjGTIMCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADboDenRMy92C6uldr/9Mb6IssiqEFnZI1jA+8ljfPI=;
 b=kUK4/9xgI2caUd83TQh/zd+tfY9CIyGo6/VzDv31CimI7X7sfR1QjuloeEU/h/RryqHzhvCzTyT+ftnG9BI5NYEMhAuPtuXEYQcI43aMipztvh3ach0DYkvmXdGM/ie4LfQHxBNuZU+Mn8M3E83UwPjB+I6W6I/O4SLrjUXog3epm2TwfFCJL2VCCb7SMHTjyQdsoy9MS9Nlv5AU9izqUJPr5QJyZiJdOqYlrdPanzNYjBQq8kYtMiNIVPXu5OF/BlaEnPRDuvz56mctyx0fZ0tTRaAD6lDFl0iIwuPIiBE6G6MiB24IWEqWp7oq+9CYRoUv2n/vUwGDJ+SOTo0f1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADboDenRMy92C6uldr/9Mb6IssiqEFnZI1jA+8ljfPI=;
 b=fpVeMQ+xfdXV1gCguqdNEPu124uOL74go8zba1GeHq8BeJ0f56BFZw9zpYXtr8lijoqOfUkef/fw4peOzaVqUmT6zNcdI6vc024/4ykGpYxSdHgS7S55ZXwksWNRf+yxHjd9ypC0PtsUyprCkl2NhNO1E9Xk6fzFOO9slK6TfVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 08:37:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 08:37:55 +0000
Message-ID: <5488b215-63aa-4188-a569-118d356a8c32@amd.com>
Date: Wed, 6 Aug 2025 09:37:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/22] sfc: add cxl support
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-3-alejandro.lucero-palau@amd.com>
 <68840230b1338_134cc710044@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <68840230b1338_134cc710044@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bf9b6a-2789-476b-cc08-08ddd4c48a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2dxRGV4YTY1b0RMYlhkWWhweWFIdkJrd1cveCtnSmlMNWhlMXlkYmhyNGVk?=
 =?utf-8?B?eU0wQk5PR0RCRTJjN2ZsUkc5WTlYcVNMR3NBZ0trVXJDWmRxUFZTZTVwekda?=
 =?utf-8?B?Wis3cEQyZGNCV2dFS1BRNWFVeEoyMXNIRE5XcWhvYnhVTG02Vm9JdTFXQlQx?=
 =?utf-8?B?N3ZueW9aK1pTaGxWZzdkZm94WWZrK2VoZm5qY2wrelRZRTM5RHR5SVpWd09r?=
 =?utf-8?B?WlNqaW5kc0NIcFJiTCtpTUtYZ2FxRFNJZlJVTTBrV2NZb3BpL0RBN3BjdTZz?=
 =?utf-8?B?VWU1aFQ4ejk1S2tjTDZIMWF1RTNLU3FtZFE3dGc1U3lsc0t4eU5ZaklmcGcr?=
 =?utf-8?B?VEZiUUVFMFFOUjl0RFNXbkN1c1FZMGFYcngwaXRCVkpFaFZEU1M3V1cwM2o0?=
 =?utf-8?B?Qm40WURjOUZvQ1pFcms5WWdjUC9yN0F0YlBZa3RyVGxLekdnTXM1aUpQaVZu?=
 =?utf-8?B?R1lZdW11Z0ZSaFRBQjFCR2hVK2xVODdwckdxYkl6VzlaRmxXY0swNVVKV3FL?=
 =?utf-8?B?TGlBRFJadjFBUVlLWmFtRm8xQkN6djA4NlFmVld1cmgyTitEN3BCOFRHVTcv?=
 =?utf-8?B?QWx2RERja0hrUzNZYUVoQVlKeVJpOWR5ZG9VeUlvUWFPdkNEQlp0MVlKcmZT?=
 =?utf-8?B?TXZGV0gvVWFPSG5wb2ljZ3dEbURVSUR1SUlTT0liK1RUS1ZmSlpsU2tDRmJo?=
 =?utf-8?B?T1FydnFjL3hyOEtkRUpOSVVTUFoyZ3RkcllWLzZ2K0xpKzhMdG5XbytRY0do?=
 =?utf-8?B?Ym80V2RpY2Ezak9rWVRkVStjOFNZU0VoTnFUVi81VGQvREx0THBnQlNZcVpy?=
 =?utf-8?B?T3ltQXRCUzhuNGh4TDgveVZBQndxK2JvNHkvbXRha3p5L3V3SnptUUlnMk1Q?=
 =?utf-8?B?M1h6am5qVmgyVzVaZ3lmQ1FLYlZIRk55Sks3akUyK3lNTCtOSGtReVdjcGFP?=
 =?utf-8?B?dWhtZ3J4M0p1ZlFCdE1nZms2a2ZhQnFSMlRzbXZxQWU0Q2VkU240ajU5b1V1?=
 =?utf-8?B?TFlsTzgxMHFnMFBsM2RjMlJRWG0yVjdLZmhQQ1BWSEMvSHEwTmh4UFR6M0o0?=
 =?utf-8?B?ZVY3TzlFSFNDVWpibWVKMlV2bTRGMFk2N3BJRnlCU2k2eHVnS1hDWWJXSC9Y?=
 =?utf-8?B?MloyUjNTVHZLTEwxL1lSc0pweGZSN2JnQ0lqUzdlUWpEOHk2UVNXWG1GT3dZ?=
 =?utf-8?B?dmx6aDI4cDFCNTcyaXJtRUxjazFPTS9RalNuUFlEejNjallPMzRudUcxRnND?=
 =?utf-8?B?YnpxQ2kwT3M3Q0c4T0l6Tko4Tm1YTnpkN3B0cXdoS1dxU1R4TkFNYVhMN1FH?=
 =?utf-8?B?bU9KRXJ0c1dxcjNEbWlKanpLMTFyYk13S2JOWmVGUEhXZ2plQmhVL3djY2du?=
 =?utf-8?B?NnhEbnltNDQ5S2txMUVsclBaMU11Skl6TTR4KzVBazYxUU1VTjBCazlUa3Mx?=
 =?utf-8?B?emo3UzR2TURQWmsrSkFWaGEva2cxa3FGbEpmN1V3eVdMRXBMMWhXNjNqTUlN?=
 =?utf-8?B?RjB6aGZGNnZvU2xvWnEvNTVTSERub2Rxekc3RGRCRkNwcEx5YThoN0JDaGxi?=
 =?utf-8?B?dHV3RExIclNHVCtlcFk4ZUZPcjN3NnlyaDNINTlMSzR1cGJRTmRlaEJJYlhu?=
 =?utf-8?B?cmV5YjJ0N2NCRlk3SnVvcWp6bmdCdnhQRlVDazJqQVlsUjFMeFl1WFFWeW5i?=
 =?utf-8?B?UXFlOTdSSDVQZXBpVHUzYzNQbmpHLysyK3g3R3hkK2ZHcHlOZkd1U2l3L1lq?=
 =?utf-8?B?alJKWmczZGdkS0FtaGYvSVVNdHlURDRQak5TY3BQWkg4YmppbEJVV1VtaVRp?=
 =?utf-8?B?aERWSDZIOHBVVTIwZDhMc2U5UlBudG4xeHhHN1V1bGNkT2pMeDY0bVppRzdt?=
 =?utf-8?B?RnJGZEhLTTFuZXNOY1RyUXhzWU9zM2hOTFpsY3J2UFZEMk80ZkZOWGJKWTJW?=
 =?utf-8?B?VFFLc1dGRm9mMWhveFQydkpqUVErTzdUSytZMVFEK0RXSmdqOW5QQk05b25S?=
 =?utf-8?B?Rm0waTlDNEdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R09vMlZHdGZFQy9DanhrK3ZsZHIvbW02NXk4WkRwWkZOSTArNHR2bVB5bEYw?=
 =?utf-8?B?K1lEazZxY1J1SktkYlFrZDdxa1Fuc1NsU2FwS0V1VHRialFVNzJ6T3NhT1BR?=
 =?utf-8?B?SnA4RC9uMmxFdVVoQ0lYRHFOYkxTcnhtRW1LYkVrSzJNTEFhcGJQZ0JJd1Ro?=
 =?utf-8?B?MU1JaXVldWZWcVF4eSt4OC9tOHVhVWVrdW1zRFNnWDcxRzZ3cFBpUW1GVG9I?=
 =?utf-8?B?U3BTV3VqaWU0M1pRRFdPRkxLaFgxZnVDeXdPU1VBYm0walcwUXRXKzJrMzho?=
 =?utf-8?B?alk1U0N0REdhbHJXTHVER3ptSjdIS0ZHemNMbWJCZ2JtaWVlSjZUYSs2VHdx?=
 =?utf-8?B?SFQxSlBWQXFZUTFSWFFSaEJpOWFuR0VQVUhTZFdJY3VrS1NzbUVGbTljeEI2?=
 =?utf-8?B?ei9MbjJLZjh5dThiUTFvODU5dUxBaVZYWkVEcHhqZU81Qk1UQWFuN3dMWmow?=
 =?utf-8?B?Qm5kSlNad2RWTTB6MktvVjBzRjhNd0lZUnRhckZzZTVIS2phRldQdkxWSWJu?=
 =?utf-8?B?QmgrdWdmTlN5Q1F0bW82cksxVHdMaGJHOVRrQXVKQ1EvTzJIMjFWZm5sbUJU?=
 =?utf-8?B?aDFYcWh2T0lRczJGcVdqUkIrYVEvZW9LTnpJQWxMSGY2cFVpaERqdXdiRkZq?=
 =?utf-8?B?YUFrV2U0bDQvbTBrRWJ3SXdqYnM3enBXMThyakZNOTA0d2VtRHBPRU04eG9R?=
 =?utf-8?B?aWdHbWhicWhNcndMVmc2NlY4eWlmWklGRklQaWEyRllGYzNmMWV3N2RGaHBP?=
 =?utf-8?B?V09mbnlaV3l1RXQ3eE9NeWZPeXJ5S3dlSmJ6YzZYVmdOaWRhRVY5NDRVWVh6?=
 =?utf-8?B?YW1zc2c5c1pTbXhkckdlMm5KYWlZRmJqSzFzclQ2K1l4aHJBSFJXTGtJL1dB?=
 =?utf-8?B?QmtQSDZmbzhmR1FyUXMzRmd1NzVkWTFlRVJsTXJ2QS93YjdhZWUxTFZuWC95?=
 =?utf-8?B?c2RrQWl6NzJ3aWRneGlqQmlwdm1GZGpXL0JiSG5vQmNPN0dPUXRucDJ2OUhx?=
 =?utf-8?B?MldjclV4L1NxWUR5b0lXZGR4c0RyVXZtOGVLN3dNNHEzdzJpLytaVmlxMFlz?=
 =?utf-8?B?QmQ1dGFPNUY3ZzVZTyswMHc1ZGFIN1lvbzZZUWZYcjVveUtlMVZvdlo3L3NU?=
 =?utf-8?B?KzF2VG1jT3VGZjB1L3JVSTg0aE5TYUF0aHRHbFo1OE5BeS9DYlRqUWR1SWhO?=
 =?utf-8?B?V0g5eFg3NzZ3V0tJajJBU0lHR2l1V1daOW9BWWJyMnVRY3JNdDN5YllZVGtt?=
 =?utf-8?B?RWJjbXZ5QWhkUHJCRWU5d2lPUS9uWGEzUzZIZHg1ek0vSVI4VkphSzZsY21V?=
 =?utf-8?B?SS9TcERHWmtmdlZnYjJNTXQvMnpTazRsT252OFN4bE0zTHdXdFd0amladGJ0?=
 =?utf-8?B?Z1FOMGk2cG5vSmNSajRQcG1xSUZWeVYzMmpzU002ZVFXaVVaZ05xcXNobERh?=
 =?utf-8?B?MkoxeGlQc1hBU0NtQ3hMbkdZZGpIa3ZkYWtLdnZnSGpiSWZxQ0RsK2hKSjdT?=
 =?utf-8?B?UTR1S1Q5VVB1ak55b21HSFJ4Q1Z4bUNNeU5vREY4VERKZW5OZitmRHFBejgy?=
 =?utf-8?B?MWJON21ObEdDVW9KbXlOYitpZ2kxaVQzZUNCQ2YreGxvdDc0SDQ1Qi9RbVRm?=
 =?utf-8?B?aGRzQi9DeHhKU2pqOEwwZGdoZGpSa0ROcDVnS0VabFZ5NnVJbE44K3pIaTJo?=
 =?utf-8?B?Kys3QkpFeGN0RDZ6OVpXSkltOFZZN01OVmkzWk1TTkZvTGpnaVVuRDJQb29p?=
 =?utf-8?B?VndkQnhNMTU3KzRxblhsWml0ZHBSaGh5STFmQ2F6dzVjZWlzdEk0ZFNOSnRy?=
 =?utf-8?B?azVWdncvYlRETXAxak85WGV4RVBqR2VRWmZjK0JZNnVyYndQak5WRDZ5WmE1?=
 =?utf-8?B?ajhwanlCNitUdng0dC9nd25zMENublF5ekZSQWZ2a1VBazBQQm13T29mMEJz?=
 =?utf-8?B?bWhNKzhjTGdWZjI1WXQrdXNtVFg4eUdQTFB4dllmVkZJbDVvaHVNVktnanpD?=
 =?utf-8?B?R3BvUU83ejJ2T2ZvN013amRtYWFMNjlXMU11L3BIVVBvVnVLd2VXRWdnZ0ow?=
 =?utf-8?B?cUdxSzJnQ0svM2Z4MU9UMXJROUF4WDI1UjJDd21lTS9Yd0EvdTZIMHVweXBX?=
 =?utf-8?Q?AUTfYwE2/rSqVGRd291L/a5Hy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bf9b6a-2789-476b-cc08-08ddd4c48a0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:37:55.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMZm2JYetbMpRocCtOKDdCvbIvPWIV+B1JjqI9xvOPO6lqad+8V6+56lGqlxV4uDuJd1vSGFsx6kKvI4CyPuyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793


On 7/25/25 23:16, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
> Looks ok, I do feel it is missing Documentation for how someone
> determines that this support is even turned on. For example, if
> git-bisect lands on this patch the end user will see SFC_CXL enabled in
> their kernel and:
>
> pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>
> ...in dmesg, but the CXL functionality is disabled.


Not really. There is an empty efx_cxl_init defined at efx_cxl.h when 
SFC_CXL is not set.


>
> Not a showstopper, so:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


Thanks!


more comments below.


>
> ...but when you respin patch1 do consider adding a blurb somewhere about
> how to detect that CXL is in effect so there is a chance for end users
> to help triage CXL operation problems.
>
> [..]
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..f1db7284dee8
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
> Per, Documentation/process/license-rules.rst SPDX supersedes the need to
> include this boilerplate paragraph, right?
>

Yes. I'll remove it.


>> + */
>> +
>> +#include <cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	u16 dvsec;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
>> +	 * specifying no mbox available.
>> +	 */
>> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
>> +					pci_dev->dev.id, dvsec, struct efx_cxl,
>> +					cxlds, false);
>> +
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	probe_data->cxl = cxl;
> Just note that this defeats the purpose of the
> devm_cxl_dev_state_create() scheme which is to allow a container_of()
> association of cxl_dev_state with something like a driver's @probe_data.
> In this case @probe_data is allocated before @cxl and the devm
> allocation of @cxl means that it is freed *after* @probe_data, i.e. not
> strictly reverse allocation order.
>
> It is fine as long as nothing in a devm release path tries to walk back
> to @probe_data from @cxl, but just something to be aware of.


Right, but I have to live with current sfc driver design, and I do not 
think there is a good justification for changing it for this case. But I 
agree the idea is to have such container_of functionality which 
hopefully will be used by other drivers.



