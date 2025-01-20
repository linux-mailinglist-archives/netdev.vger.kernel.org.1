Return-Path: <netdev+bounces-159827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ADFA171AE
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E95188A820
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A21E47C5;
	Mon, 20 Jan 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="APPL+5I0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BE1E3DFC;
	Mon, 20 Jan 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394036; cv=fail; b=alIsSoWZZheS0sq9yIfgK11BzNNk9SM9pet7G8U50gbuPP6p59sa/oCDqsAgBHZu8DM6DKFctRMryK6zhqxB4pzOb6Wikp/vQEfkpUllYfVSCQ/NrCxbfELzlPZHI+0kdVhGZQdw/1hYoIQ0rSZGouQz/DjCTFf8z2+vx9Djjx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394036; c=relaxed/simple;
	bh=dw/ETGkjhFF59LTIW9v/qLvcfQ/q3ZQ9hcORaabjX1A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gDv5nnRR1ZWS1LCFaaUzb+MpgVzmL+ZDJhzmA+1crh2EqupBDTIoFgwfPKPubjznSrxLi8ki7np/PeEC1zcC49d5xW48rEfoXpX0BbwMYvP5XBbmmCUZIMI6iqduDz2EEPhY6JJus8/fIaeQsYtn9M8o+eQkYK+7XvuRRLx61Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=APPL+5I0; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3zlgbBoNi3vFxErysFbJlAx033lOq2XmoqTCbu+TjkvGW0SwDHE2lS5bI9VwK1bM0ZwpSskWm0JfxNKDSO3KiNaZGUnV/NnsjDDo9bI9FoAIvV/6BmQIXlpoorCbjDwsNdNugiOWz17N7Jce0+NH1ZT9oq+qZnQd3QAyg43uSFOlbLMZxOOf06fWOgN+GkvkFV0le4/3WbewsAocDK1GYyotwfqXsfIylXegTnX2PbLgjN+RTeE8x920SMDZdkmmLgdpc/rF0gDpf3QBCLozVHcVD4ods03Ry6TaQ5gWr0zEfD05Rkbqg6PPP9WyA1yeVcQmPkP1BiWFrs3xVkN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hVUpCAgFVdcs+skyz0xGOLcXigsfpxgb3YUZluQEm4=;
 b=wsNL3jwSgN+Qpiy4nTBOdB5YKjTUgaahXQh50qIhkcqDCMjIJaGauHhzXHYMyB8sHIDQD0M2cL5aSAHplrVzk0I+7i4W1EC4RH4gRKfMsXzm8ErJryAs3Ym11SVT/P2l9Qfan4lsGo5oabOGi/U1keBfch/S8KN9U8C/46cIylcNzF3e1vc0mWYkxjIyiAJNjleFh5wauqn92Fii7k3cZvcSA9RXs3z6htCC5ho9eNkVwiTPPM4u2U3hHkL+AWmIzdTAO117B99LJ51lKvNreSunY07VWTLmc4+ukJuxUM5ANbIehhEvw0xhSEP7kMwA7w72Z937ZJYkhF7d3BgRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hVUpCAgFVdcs+skyz0xGOLcXigsfpxgb3YUZluQEm4=;
 b=APPL+5I0askrwugB7NjonqTsWglvYAAMS5yhaUno3XiqJgFiox5abHFwgJSvt4b8G/U75SYnUMDSlMK+hrpVcFUKyE8fTFf2VBP1oOwrHxZqQhGjePAqQdcZcA93Savk5E51hm8v+P0lCNIB/iBnMNGXG4Bi2eCMmJ/gdJOx5b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 17:27:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 17:27:12 +0000
Message-ID: <56186794-e514-e606-8a3e-1b73bdee7bae@amd.com>
Date: Mon, 20 Jan 2025 17:27:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 14/27] sfc: create type2 cxl memdev
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-15-alejandro.lucero-palau@amd.com>
 <678b14cf84ccf_20fa294f4@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b14cf84ccf_20fa294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ec0402-4e39-484b-8dc4-08dd3977ad30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajA0MWlxRElENjRTd29pcnc1ZEZIZUxDVFVxNGYrSmN1M2tzUk9WS0hwK2FS?=
 =?utf-8?B?aUtJUWpwNDdoSVh5bUt4cWxCbW9hWGpvem5IS3VScUF2SkVqdnhlUE0ya053?=
 =?utf-8?B?UExuSWlReUt2OXlEN2pNYlpZWVNrREpyR2UzSk04VitiMXkreksxRXhFcUd2?=
 =?utf-8?B?VkhoT1JVN0tnblhIZG1XN2phbnpxRENhNURDN1Z1VkNZUGNoeWVkWDR6ZnJS?=
 =?utf-8?B?S3JXNFZqclhCcXk1UUswV3BXRytNK1pUSjZzMzAxZm5xZVh1WGJoRG50UmJa?=
 =?utf-8?B?MUtRSmNLWlhRZG95VDVXYUIwU1VVOW95S0pyNWR2RHd3SlhVWDZ5dlJHNnJT?=
 =?utf-8?B?Y04rWVprdDR0a1o3elBmbnlUTWh2aVZTbklWMkRDbk9ONm5EcVJlQ0dEWnJi?=
 =?utf-8?B?TzNtak5Vbys5WTlBVXlRQ1JaVmIrVFJGVU5pN0t1aFRNS0haYURTLzcwcHN1?=
 =?utf-8?B?N3BNTXFKN1YwZ1ZnWXdiUG9qU1JKeDlMQm1oZHIzU3d1OTV3VTRiRnc2OFNk?=
 =?utf-8?B?T2lYVEltazF1R21ZdU02bEtZSTlJZk9oRklJSHYyMloxSDc3VlNlUnE4YWRi?=
 =?utf-8?B?ZzZCbGp3V01Gc3FhOHFjaS9kSjhIWFp5bzB0UFUvTTgzUWxScVliOUo2R0kr?=
 =?utf-8?B?ZjE3WVNWazNvQkNoK2ovWTdMTXozVHdFVjNWYkZ3SjlkL0EwVyt5VDlwb3BP?=
 =?utf-8?B?TzltaGJ6S0EyTzQzTFd1cGlKR2RncTExOHhjM2E2aTFaWW9JMzZ2VkFEWnpu?=
 =?utf-8?B?aENYbHRKK3BZbFJEblM4Wm9qdHlxVFp3bndRdmpYdk5yMmUrbGpUcFZqYTlJ?=
 =?utf-8?B?eXI5SlJVYTlmNEt6WTBsZndmbG1idVlvMXJlRm5EMWczOUZNbDZmSG93aTFB?=
 =?utf-8?B?eFlJWi9jKzQ0ZGhPa2MyVkVsTVFiUFUxVXdkMjAySGt1dlE4TTRWME9PcTJ5?=
 =?utf-8?B?NVhZQ3dLRnZ5MnlGMVI2Y1gwM2dCWktKNjlpNndjSllwZ3pjbng2QThrREhk?=
 =?utf-8?B?Tnd5alZYdVUzdUd0cEMyWC9NVzdUcjZBcEQ5L05CSEdUbDZJK25uK0pZYWk1?=
 =?utf-8?B?dVl0MnVsd1c2YXdTeDFIU2JHZzNvOElSeE5PNEFlaVlqUS8wQnU2NUlCNUNM?=
 =?utf-8?B?eFNIMm0xQU16eHNjUi82NUtGdGl1NGNsY3JGOVBvc1U5K1Fac3FZMFpSSGRV?=
 =?utf-8?B?VXVNM29NRE02S1A3WmdlbWFEZXlrYkhReWp1MHk0OFBNQ0VIOUhtZURrbGh0?=
 =?utf-8?B?Q2hSYjBHTTF1K3hmWlRIMXdNaDhvdStQRElkSDZnN3h5TFA4TVlnWUxQb2Nn?=
 =?utf-8?B?VzhNREhBOEZJR3l0VFhnNU5wN2pmcUdjTi9OdlVSK0ZUbENVaC9OZ0JoTFFX?=
 =?utf-8?B?VStzZ2hNcERodjRlVWNGNmNCaTg2RGR3YzBUZGErNTVQWlZtaGNsQTV2SW9I?=
 =?utf-8?B?SXd0djNXWUhSUU00c201Q1RpZ0dzSTRraFY2Q1htTGM2YXRUTUdjL2QvMklm?=
 =?utf-8?B?MWNnVytXZE0vWlF5a3NnRXRsUlBVMDhvUmYwZnFraEU2THJTOXIzZWRUamdK?=
 =?utf-8?B?a09ENG42cWdicTVvdk42d0xPRERIdVFNV0psNzRWNVVLZ0VQbHpHZ2N3SWpL?=
 =?utf-8?B?ZnhTSnJqaUxiYXVNQ0hZcFJNL2pyWEpST2U0REVweUExZjUrVWtVM0hrdS92?=
 =?utf-8?B?b1BkNTRybDB1YU9uVkVpVGNvcldvNWtWYmF6Z1NEbmhvSkk5REVUUHFMWDRi?=
 =?utf-8?B?VHVpZG1QdVpONDRDS3B6bEg5UmVtVUswaWFybnEvb0Q0QlBBK05DR0hoZlAv?=
 =?utf-8?B?c2JoN1Qybnk2eEhvNDZCUHlpR2VMN1BaSHJhRDlnbndGMS9CTXpDb2Vtdmhy?=
 =?utf-8?B?ZFpLS0JwekJrSXV4bWFPR3gxNG1qTlRDOFZVVDRaRGZQMERXSWVLK1J4MnJm?=
 =?utf-8?Q?WPruRXnBJk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHAyKzlpN3paditvSDkxR1N1YlYvWTRUWkdRbGt0ZjlHTDVuMzM2ejZJUG9N?=
 =?utf-8?B?MFM2T0sxWi84bG5UaU0xSEFzWXRabjVkV0J6U0kySnJKb1FybWJTMFlZTmdR?=
 =?utf-8?B?RElTLzFUbm1uWlV2Kzh1YU0rZDNqSDBib3VvR242bVZsVXJJQnFxQWlUa3la?=
 =?utf-8?B?VEdCMi9kVlhiaXFzZGIvWUwzVWtrK0dSUm53ZCtNclRsUlBzVloxa21KZkxN?=
 =?utf-8?B?aFhTbVQ3VC9ZMHRyRUZEcVVaN3BjMDR4NEU3WmRXdlVTbmMraEo0aWRhZDFS?=
 =?utf-8?B?QUxnbk14MXNJNG9YOFZnOTZhc0FaMFVaK2dxb2pNb2ZQem1JNkRmbUt4Nnha?=
 =?utf-8?B?SHlQRWVEVjI5U0R3NDk3L2F4VEI3QUpHSFFqYy90VHRtbDJJQ09zT0d4R3hp?=
 =?utf-8?B?WERhT0RNWmdsZEN4SWxwd3pyRDc5VHptRW1VK1o2RXJjaHFYMnFZdjV3VE5T?=
 =?utf-8?B?aHlDMXc4YXloQTRFUGt5cldzWFkyS3hWdFlQYkp3amx6MEZwRzBBM2NLaWhN?=
 =?utf-8?B?NnZLbjFlWkZWcnhtazhqOVVNNFdUclR6empHQXdzSjBXdi9WQ0dyaXo3SS90?=
 =?utf-8?B?Q0dZQk43SjRqWUcxbStGTy9yZVBTbFQ1NTBLeU9QZ2xIU0dlUHB2SEduOXhS?=
 =?utf-8?B?YU8zMS9UdXh3ZW9TRWUycGF1VnFiRUNvMHhVQTRYdmJObUI2WW5aUnQweHQv?=
 =?utf-8?B?M3JNQVgvMGFGSXdvWWE2TmJDeWNUVmsySVVERnpFd2Y3c05kT3BGa0xCSFN2?=
 =?utf-8?B?VTUza3ZDdlJSQ1lKTjIwejV4UEkvZ2c5RTV0UkRxMjZSVlFPTC9TaCs2V2wy?=
 =?utf-8?B?U2FURnA5YzRDV2RGQVh0SkNpK0FQN240dGViWDhTellqQmxtRzBHWFM5M2pE?=
 =?utf-8?B?VGJoV3oraW9SdmpPR1JYNnZINmNaS0hPeXBPYUVzbm1pMHpObjd5cWRycFNo?=
 =?utf-8?B?ZXNiVmxvTkF5RDVrbHY5OURhTjRkL2R3cHNHbVNjTGZTY09yeU1XSWY3Qjky?=
 =?utf-8?B?QUxweE91ZnBrVEY0RjJVdEJVaVhjS1F1bGxldldZdDBFcDVFY2g1K0JNaklS?=
 =?utf-8?B?aFAyNjJhZnpwVDVXM3JqaXRDZ01zQ3hNaTBld2NzU1V3YjVSdW12dVVaaTEw?=
 =?utf-8?B?NjAzcitNaDZOZkJ3R3RYSHlKVVlYY3Npb1RvVmpRblpzT1ZFeVFRV0xVZkQ5?=
 =?utf-8?B?aENVT2IvRmVKMlAzNFRHYkJrcWh5dHNzM2JkUlE0NXhkRzFoYXBKWVl5Ly9h?=
 =?utf-8?B?elVGTTVEUnZoU0IvK3Rrb0lOMDM4SzcwWjZmRm5yZ0pJWWJQRnV3eWZtdDRv?=
 =?utf-8?B?QjNNTENDczNlUzdNTnVycWI2QVRtcGVsRWxaRm5oNjk3aStFaEQvZHBPOTc4?=
 =?utf-8?B?UDRCbGFIWC9sQXlYZWllUmRpQWt5SGdEK2cyWnZTOWI1RmFTMzRTeXJ5S2xV?=
 =?utf-8?B?N0dQT0hCOVVSYUZQRXRUWndER1RWejMrZTROUDE3NGd5V1pndlRWb093ZTN0?=
 =?utf-8?B?cmUyZytsQ0VabHpNb21NQ2FEbWszL2xadVpRWXpHYlA5dmVMOE1EOTdGcElP?=
 =?utf-8?B?VEVuMWdrTGVIKy9BZVZyMittc0VMWFBVazY0aEtvWi9Qa1VML1FkU0xUUUdl?=
 =?utf-8?B?d0xPUXBTeG5FUUJ5L0IxcjdVZWpQa0g0OXFMSkx3THNSZUdvaVVhV29pc2t2?=
 =?utf-8?B?RDZwcGxGelpVeTRCYUpIRVBzU200Y21rcDNtQzMzLzhLWHRwMFJWc1l5S1hV?=
 =?utf-8?B?QWF0R2lEdWtqOXdGVVZOd2RLaU12azc0eDR0UW5ZcFF6SjFKWmpTV256R2x5?=
 =?utf-8?B?UXJxT0tObVBGODZENkU3cGR6K3MwclN6d2Zjb0pCcTlmK3Y0QVE4Wk9oNEJt?=
 =?utf-8?B?VHFWbEd1Q3U3UWVZQUdaWXB2NUNzVXdGOW9aY25BNEFQT3hWSG00eENoOUFp?=
 =?utf-8?B?bVU5Yk5kV3h6SjFWUWJmVWV4K1RZT0lrSFJCWkhDOG42blByaXJFcS9UOFZi?=
 =?utf-8?B?MStxWnZFdWhkWkVNY1FpUDBSNjNkdkNGQmptWDZxYmUzeExHWDRQamNOMC9m?=
 =?utf-8?B?MEljcGZTQnhBN043WkdSY3ovNVcwWDc0MkU2eUlkUkRhV001ZVZoTXd3THIy?=
 =?utf-8?Q?B3LH6Uq8/XudoYq1X1x/yjAPO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec0402-4e39-484b-8dc4-08dd3977ad30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 17:27:12.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzzhPthF1O+ziumtl03Ll7aJJ94UWsP/3Y3n+rYRxjfkTDON0E9PWh4gyhMh26mMLn8k8yF7sRISmgLUbjcsGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355


On 1/18/25 02:41, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl API for creating a cxl memory device using the type2
>> cxl_dev_state struct.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 911f29b91bd3..f4bf137fd878 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -96,10 +96,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	 */
>>   	cxl_set_media_ready(cxl->cxlds);
> It is unfortunate the media_ready is just being used as an
> offline/online flag for memdevs. I would be open to just switching to
> typical device online/offline semantics and drop the "media_ready" flag.


Not sure I understand the semantics here. Note our device, as the 
related register being optional, has no way for asking the HW about this 
(by CXL means), mainly because it is not necessary. I guess this 
hardware state is there because it can be needed, but again, not sure I 
understand media-ready vs memory online.


>
>>   
>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed");
>> +		rc = PTR_ERR(cxl->cxlmd);
>> +		goto err_memdev;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   
>> +err_memdev:
>> +	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>>   err_resource_set:
>>   	kfree(cxl->cxlds);
> In general a function should not mix devm and goto as that is a recipe
> for bugs.
>
> The bug I see here is that devm_cxl_add_memdev() runs the teardown flow
> *after* efx_pci_probe() returns an error code. That happens in
> device_unbind_cleanup(), but when it goes to cleanup endpoint decoders
> and anything else that might reference @cxlds it crashes because @cxlds
> is long gone.
>
> So if you use devm_cxl_add_memdev() then cxlds must be devm allocated as
> well to make sure it gets freed in the proper reverse order.


That is true and I think it is easy to fix, even with your changes for 
patch 1.

I'll show it in v10.

Thanks!


