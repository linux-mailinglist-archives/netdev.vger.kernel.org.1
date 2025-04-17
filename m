Return-Path: <netdev+bounces-183732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C005A91B99
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4379018857E2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB4423A9B1;
	Thu, 17 Apr 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QNFdmQ04"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAF12B93;
	Thu, 17 Apr 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891661; cv=fail; b=RGSEpkR8x+4MDD8rZnn3erN6Qc+6ohqfPDeHOl+Ry+n/M4mRFy8z+ZH6qx0hL2zrSGv0vUO0qYl7AWWyyDBnaEjc8mG5o1kUkMu0lLmrBTIozZQSe9fx3eCo0vUFDqTXEiLkMWTBIfEmk62z+unqmSZjZ/zxlJFcblUKN5ydOmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891661; c=relaxed/simple;
	bh=Wa00Me+JgnuXpQ5zjQLFHdk8dvR5Ns9Fj5fzrzByOzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W1b0fYf7gnNN3xT/w3CPjk4xtYA0ctO8sabuzcIUjLTT53G/8lDUg1fo+1xd30rU7+Pxs+KTzD4J2gy/Gwh+2J09HGo5yxx2WwkpMFQyXlLJ1miw+P84vsdtD9mpQ+fUbyXyiDX9WBOMOEy53Fybmx9N18yDf7iDZYC89GKAZjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QNFdmQ04; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja50o+Jf+x30PKj0Ypsl2umeySwXDczd6elhw8x+MyfocRRClCQ+znROl0dbydllniyqPhn4Ik10FaTHuzJb+B6LgZXqBgzDsnh2OJdLBBd2MNtJq+oMqHLgFqjd8ETA/lgofHGOqzH9IKURK92fmvpmn7iywq1uOiM5fVq6vnzRXLTGN/ifVMAXomiCDBbZMnLMUzPQPJGvcsVI6tTi9XsaoLLK4GztcDpvBqpB6EQlq2sNTyOnM8uuJXGWti56/ITP6ql28H352Ao1lOwA5qBBGaCxYwzvhlf2gdNQmug20Eql2iFYLyAFfl2spDENkHWL3LoET+UE0JA9MOSPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lgQ2dRD6Jacod7fftT26ywEkYRS4IJtX3nUDqfDHfI=;
 b=Y/E+P1Bawknm+b5sTmWPhehxkCY7fy4pk/DjjUXqXtDCm/5dU6697nmDQmcE/aqvjCG8fp7tfvgX+cy+/UlCqdVJaHZXzPvI95cT3sIxbkzO0cYFYKtn7x/utyAshMXj7aC/vf8TEbsc/g8l3ruS28+SCeld7f9XM2UokEMLkYR+fRPTUK6lSyM4wXyRlsp0IC/jcwC76gmmSlgtUJNMH/cIRLXwybM9ajZvPD4p7qG50p8ac6xPKhwaqSJpwtp+AlTLUI8gUYZvEmRkYw+asvrjhCELs0GlpI2p3CEmVkD/O4grWL+2vVrCZjIeqvzNyQ1qBymmQQLfaefOCcY96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lgQ2dRD6Jacod7fftT26ywEkYRS4IJtX3nUDqfDHfI=;
 b=QNFdmQ04zpHTpWWc1tEpcy6YcExoM2tZQkaFHxDFZ024JeUc/3+ZH6FglJ8ijowZ2rXzM73jBVSIJNcwvSFvfHYete1jFv72PDygUYx1YPWf53Ld5EOKqwqAzIKC2L+qN18DSygEF701gmEdtD/AcHBqD+B3x6PgLnALF+msa9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 12:07:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:07:37 +0000
Message-ID: <f31ad04e-90da-4de6-9065-5ff9fd1d20ba@amd.com>
Date: Thu, 17 Apr 2025 13:07:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/22] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
 <20250414151336.3852990-6-alejandro.lucero-palau@amd.com>
 <20250415142150.00000f9d@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250415142150.00000f9d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: eed645aa-9269-4137-0518-08dd7da87193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDd6SWFVcEdVRzBvOGE4MWJuaXFoWWVSclo3NWxkSnRKUXlTVXpyMTdGNEE0?=
 =?utf-8?B?V2pDdDZPblppMnZrTWluYk5Ec0llcHEvOEZpVXhhVW80WjV6QWpzR2Z3QjdQ?=
 =?utf-8?B?cGQ3ckE4emk0bTRyU2VzSVpZdStHMEJHWUtwWEtqK29nbWVIRzdMT0tSNThD?=
 =?utf-8?B?bGhOOXpqQnRrQmd4eVE5Q1Yzb0p6dXJ2VFc5QU1zN2g1b3J1SkppbC80U2Rv?=
 =?utf-8?B?MlRBMzJQdXQ5NUxtR2dmWkh1bkgyM2V4Vk9KcnpCaThvcDFEVUM2NjZlQy9z?=
 =?utf-8?B?ZXYvb0ZtVUFNcFNDd0hTSTRmOWpRdGUzUTd3QkkyRkc2YnY1clczdi8yTXlu?=
 =?utf-8?B?Mll0MFlCeGFUWlF4eFZBSFg2aFUxbWx2UEdXUCtSc3N0eTNWMDU4eHhlbUFm?=
 =?utf-8?B?QUV4M0xnTG9xUDExUU9MdzNSMm1xQUdRenM2Z1NRSVQ4am82VnBCZXhTUFhD?=
 =?utf-8?B?Mi9wVFNTYzUrWHk2YmtHWnEyRUNObDUvNUt3bVh2QjNSRlNJZTRGNkN4Q3Q0?=
 =?utf-8?B?Z2lyYlBSUzBKV1BBcWk0dTJGRG1YTHl1ajlROEF1QStLbUljWXQ2N20rYS9h?=
 =?utf-8?B?SFhtRk1VVFlTS2FNcW5rRXVpVkVTMFduRS9JaWtFdkdqZFRpenJITC9xM1p3?=
 =?utf-8?B?c0Q3Wld4d2pQREw4TTBVYVFSclVORXRmZkNjekNvQWsyU29mdm04Uy9UcTJq?=
 =?utf-8?B?NXhTTE5JTGhHaW1nak1idlVtNG9xSWxRZVNyN3RDdlNvd21oRlZ6TGY4YUdp?=
 =?utf-8?B?dzZLdmU4NzQvdDRTcy9hL0EyWENOTzhNWEpPWnlzblBaQjZneFM3WDc2N3BF?=
 =?utf-8?B?WEpjY3BWRmNXTkVUYWlWUjBxZlN0NGJ4WEFxTXVJQ1NqOGdZeWtaYWFWekIx?=
 =?utf-8?B?dDJ2N1B4cW5kOC9mb1U2MVBCUW1Zby83YTNVQ2pDdlR4aDRHSnVRcjQyM0VS?=
 =?utf-8?B?cnpiL2JNK1FjcEJjcEdXYTAvQjE1MUtyUnhETU9CUmRFbk1WeXNoNVJ6WGVJ?=
 =?utf-8?B?RklTM0pscTFUNXh0ZHFnN1R1bGduZUlQa0dJSDNZUGJnMUE2QWR0eXlyT01v?=
 =?utf-8?B?USt6bWZxMmdIaE1wY3hacExURk9RTnNQKy9TVGJScW12dG5HNFlub3VXSkwr?=
 =?utf-8?B?NDMxN3hUbktCTExJaGQxMDRWVmxkVlc0OURRaUdvdDBXS05iU1I5cnZUbHkv?=
 =?utf-8?B?UmVTV0FXQkZ3UThoRU03bk1pUFFhVUc5YkhJNERGUmhOMlRjSDVhZ1lvQ1Q4?=
 =?utf-8?B?TTRCRm5UbC9nNytNdmN6bWhWODZndmROWlZzaFRWRTQvTXdKd3p6V1RKUWUy?=
 =?utf-8?B?TVdnQkJZcGh3QXRJaHp5RTZ3NjdQNFpRdGhlOHJmYTNCOGFoajlRVTNVaWQ3?=
 =?utf-8?B?L2ttNGpCWXc0ZThRQ0N1WklEeFhCOGdwdFdLZjRHR1BBSWNsVlRhUEFhS1BK?=
 =?utf-8?B?Tkx2Wmc0eStrSnVZeXpjMHczWE9iZUFUcC9SZEVvNmRVcFNFR1c0d1pzaVZv?=
 =?utf-8?B?R1NQb0V5cjE0ZkFWM1dxS01MeWZpS0h6MndzZ3BxanpKR0ZZbkpDWmc2b1JG?=
 =?utf-8?B?c1hLR2d4czBpQy9uQS9pQlBpVThrMFlTdDhvQVh3bG53eWJYeklMcFFGbEhR?=
 =?utf-8?B?RElBMG9MdkRtaVBCaWt0OGJRcTZsV2pYdnVkZDgyUXNQc0RVTzd1QnpqeTBL?=
 =?utf-8?B?bWw2OXVmOCtXS1haV3VBWmNvU0F4QjAvMURLUGt3dUdSMURwU0Rzam8wT3hE?=
 =?utf-8?B?VHNlanp1U1pveDg2SjRRcjQ5d3RLWTZpNThkZlFIMTk4WnkrOTZaNUFKYWsr?=
 =?utf-8?B?SWRqQkUwZlNLOE9nbjRhbWp4V1JZMmFXSmF1VThzU0tRbUZkNWQwd2FPcGQz?=
 =?utf-8?B?U200bmpNWkZYZWNSTGFYYU42YmNXTnY1YTFVaU90ZmI4MEUwcHBrMC9zcXUx?=
 =?utf-8?Q?YKcQUsbnWA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhkRFJWYlNQUDdDRktwNkJlWE8xbWg2WkNmVHJYaU1veXZLRW1DeEpBYVFV?=
 =?utf-8?B?Smx0STNvWlBXVWlWZ2RrSjAxOU5lZ2dDaGM1UzBSY08xOXhmNHduaWpVMjcr?=
 =?utf-8?B?eGlZYXRsWjV2MkRGSzNDTFVtRXdhdC9CbVh3SktnSmRvdm9xTFZWVXpndjU2?=
 =?utf-8?B?TW9heHBOVDVBSTErWWZ0RVhJZkJCWmthZmsrS3ZwOGVHdkwzTWM1OGt6Wng5?=
 =?utf-8?B?b2REdkgyM1JuWE1zblpjRGVSZFp1UXRoY0JRa0MvT2cxZTVqZjhTa0hUbEoy?=
 =?utf-8?B?ZGI1VWZoUEZkbmxJZEExYjdtN2tkVzd2bVgxK3NZcDdiSUVjWHFtU3NQcW5y?=
 =?utf-8?B?bTEvZ3RZZlRaKzlOMHBkejVnZXVocElzR05lRExXdDlyOTFDdk84VjVMM1NL?=
 =?utf-8?B?ellQLytrTUlDdGNybEhiQmRyQ0QzVnJvaWRHTncyUUZFekFTZEdvNllvWUZQ?=
 =?utf-8?B?OWt0aWtvOWlabVBFMnNCV01KczQ3ZGFVVU81VTlrZ2piN2VxYXk5UWJSd0Nx?=
 =?utf-8?B?eFZDamVkN3ZGVzYzV0kyQ29pRis5MDFLNmRVQW4wK054NUtmMXhyZjNEVllQ?=
 =?utf-8?B?bnYxbVExUmRjb0MySE1GR0ZhOWU2cXlwTU5KelR4VUdMNEZuT2h4NWdTSkRP?=
 =?utf-8?B?LyszdE5ZcEVzOXBhaldxSGdHU3pNR09OVHFRZHI0cU5mMnFVbm9pZnBYWE5N?=
 =?utf-8?B?bnQ4eFA4dE1keUVieGVXSms2V243TXB3WURnMGNLMVlkYy81bTlYd3dXUUwr?=
 =?utf-8?B?TjR4K1FVd0VLTkdubk5kTThJaGpibWpwRFdCREhBejJRYlFnVU56ejNsL0Qz?=
 =?utf-8?B?RUdubFNJUW4zQzlqcmVNMXdPVGRrOElhcm16VEdhWGJEV1FmeW9hZHU0VlRw?=
 =?utf-8?B?YjE1bFJGbWFZWmk0dlIyNHpIZWd0WFV0M011dHpPaXNhOGQ5WUlHM0FZbFBn?=
 =?utf-8?B?Mk9ybGxQMkNXS0tlTFczanFXaTZJQjFiVnVROUEwVzZ0L05QK25jMGs1TW1o?=
 =?utf-8?B?bWlVL3JLVzFsVGk0ejdiZ0VvdE5QQVFmT3FSVGtzYnRtQ0JXc05MVmhFczM5?=
 =?utf-8?B?UEtEUnBCVGpGbno4TFBmL2x4NzhjVk1uVWdsbGpDSUpWdEI3SzkwR29QS0Nj?=
 =?utf-8?B?Sjl2RjVIbU10NmRpSVV6SURDZm1IaUFNd0dia3lxSEVKdDk0OUprdWw0dzlO?=
 =?utf-8?B?VkY0NTVIaEZjak9XVDBNMy9GVnNJQjhCdTRMSWFVL0ZCTkRNMWxmK0IvR2Vt?=
 =?utf-8?B?WDg1VHB5ZTdJRFNkbE0xY2ZLUmtEamJJYkNZaCtGd0ZqbTBtdmVZdWp1TGIw?=
 =?utf-8?B?d1JYQlVMdjM2S3FveUZiQ08raitaY3lVdG1Tdk1kNDJmdXVzRExCU1NBWkVD?=
 =?utf-8?B?QmZmSklycmJiSEk3ZVhZdVpvclJIQmxjZ0hTdjFLS1o1eXRJZW44Mk1lUFhY?=
 =?utf-8?B?VW9rWmFWQUpJT1NzMDV5RG52b2JtVlY3TGRBUGFNanZ6N1F5MjFoYkN2eWt0?=
 =?utf-8?B?SnJsYWhCckdWQy9SSVpwVHFhUytJQ1ZPY2wyMFVOUmVJd1FhdU9PdXhDekpU?=
 =?utf-8?B?M1Zwdlg1eU1HRkhoU3lZMFdSRWh4RkdwWjlQNGEzaFVaOEVCVmcxbEp3VU1I?=
 =?utf-8?B?V3RCeVZRSXVuZkZaVzNEVVF2WTZMQ0RXVUpNcnlSY0FIOTJNOUFlZFlkNHJt?=
 =?utf-8?B?K2dkV29ub0h2andjUHhVb25OT1VPRVZMTDMvNHBqVDR6c0tCc1dreEs5cS8w?=
 =?utf-8?B?ZCtRbkYzYk56MjBBeHY5QytRYTdXeUJEaTlBSWdwUkhvaGdOL2lwQlVDNG4v?=
 =?utf-8?B?OS93cU1sajVDUytEamhoTXBWLzBvTWE2Y254dmt0Nm9LK0laeUQ0TEJwRlpG?=
 =?utf-8?B?MkQzMk1xdXFqR29UTHcxbitZaUJvTUdxbVB2YkcyWVZLeWJNSTJzYVRoMUlB?=
 =?utf-8?B?eE01alE2SmVHeVdEcHFkNUFabWdWakZRaDU3bGhCVWN1eVRvWXJMQzZwRXNi?=
 =?utf-8?B?bmFOWUpMeVdFakNoUHN0anhLbnFUTXhVRG5oMTFMaDVqOWh3dXAzRFc4dGZT?=
 =?utf-8?B?cG5lYU1EWkVzS2xNT3QvYWRTYmRrQnNTSGprMVdpR0xGUFNZaFJDaUd0OU9o?=
 =?utf-8?Q?aWack0+yMHSH/UxJcd3D4PHCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed645aa-9269-4137-0518-08dd7da87193
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:07:37.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcDm3Ff0oCa8a5oOUDtyfGnmJlAFf4fdRiBKkNmPDK6DJhDMYsGbNaISilWrI6EtoIlu3n32XtLONOi/m35YUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374


On 4/15/25 14:21, Jonathan Cameron wrote:
> On Mon, 14 Apr 2025 16:13:19 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Export the capabilities found for checking them against the
>> expected ones by the driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
> One trivial thing inline.
>
>>   drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  4 ++++
>>   2 files changed, 56 insertions(+)
>>
>>   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>   {
>>   	int speed, bw;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index afad8a86c2bc..729544538673 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -231,4 +231,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
>>   struct pci_dev;
>>   int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
>>   		   unsigned long *found);
>> +
>> +struct cxl_memdev_state;
> Why have this here?  only cxl_dev_state is used.


Right. Some leftover from previous versions.

Removing it.

Thanks


>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
>> +			     unsigned long *caps);
>>   #endif /* __CXL_CXL_H__ */

