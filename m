Return-Path: <netdev+bounces-104167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820890B647
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC861C21FBB
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3D14D43B;
	Mon, 17 Jun 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T8iE4/fI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A044847A
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641491; cv=fail; b=XNenw24q45weBdyF1aKB+fSBH9yVyNtL5MEA/TZQ63O87ik8nq9ARTearujueHAF7ooYY+sEuc/Msm4DkLCToN9LIbJX7Ur4UYH1plezW7nfuqUWavTgVQPyCdp1lcgvCEQDq/uifOozPy8QPRNGXgIFUBdGPLN8yfYF+hGiKEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641491; c=relaxed/simple;
	bh=OEUNDfSAMXdK1PSjZs5vmJ0jVJeP0/P3EboukHBXagE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8Nbb/XCbVujUd470CUIo/b/ShrPsOD9hv2RsZJRSMFY2gBqb6PD9PX6eio5UcoEq/rxzyy2SSHn/sptU5DOtXVxa23HLrNYFAfKUPXJ2YwVIgFcJ1fAI5H6Z0p0TFRs1JcAGycMzmwNIAtsSYRyOZafT3/U9f3hxDVg15ZA/dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T8iE4/fI; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMwEqp66f+mw1KOU+DLRuz2+OnvIKK5F1wTNqBKFpD3LNEhq4tyRRDHTNq2rdAOKzJoTWFrFN/wZQGLrUr43Qian5a4+KyzYA0ost4bChQ14M4pZhvK5h7d2ywTFgm7zK/IkDrVaWX4veaWCdhXQ5pZmb/8Kbvu84DH3V6daSfp2X7RvAG6vaEunExfs0BzTDlyC9AytxMvQBdNYB9jB1TsLyVSNc4ZQm2r7hgtJzF57MBqX8GDHEz4yaScDBLHToeqo5fd6mG+p2Q2Q61ce2XCZ8rTq2YL8xcNhMiPdunPjKke8U5xNBJsb566X1kL3+HJKrav8AzE9tx0Y5P7Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Q8Wgg6nwfO8W+ftTe8Ci4uSTXbGLIEd+hkjxlAyNU=;
 b=P93EVIKKUhb8XS7sjT7k8j9kOUC9fme89tIZJJxXSpn/cH9PD6GN8dVyiNZliqy/jCkTpPD0jp1VtriCt3XftUF8ArAM0xQwtX2C7JO0+aqyif8MSXxcSdMvT26xKhPykgeTbeQdRm0qP9Ogkz7vv0hhJg4qXcNy/GLag9bPb4h2CNyqGuEya1Dd04wTROOtuIRr/O34cUX2Z6ueQELp/So2fmpeYWXJFrnV3S4BJ+Qo520N+vjA43wy4CSp8zziARpwfSOkRPkY5S+4XKsQpyNfmA1Qcg03Pt/UTMh/49dp+S6USetLqHzi1vJKSfP39fYZzstQoJjOP7I7ltff/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Q8Wgg6nwfO8W+ftTe8Ci4uSTXbGLIEd+hkjxlAyNU=;
 b=T8iE4/fIyklEZ61Mq+Y9TQTJOY91fR8EgyG4sYgPShjfpndCSae0rGVKA+wNNYLmJJ7EQ+IByxZOW+6IWt/1n3Lcw3tI85XK5T9pf9yGZ1tIyqS3C5QWvPBmKKIAvABv6xDpE0XixF0cQuV5XnJEMyX8dbne3xV+kGhdmzzwRQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:24:46 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:24:46 +0000
Message-ID: <64876a57-9ac4-4725-8af3-67944ba6ea95@amd.com>
Date: Mon, 17 Jun 2024 09:24:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] ionic: Use an u16 for rx_copybreak
To: David Laight <David.Laight@ACULAB.COM>,
 'Shannon Nelson' <shannon.nelson@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "brett.creeley@amd.com" <brett.creeley@amd.com>,
 "drivers@pensando.io" <drivers@pensando.io>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-8-shannon.nelson@amd.com>
 <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <1cfefa13c8f34ccca322639a05122d6d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1d0716-1d73-4964-725b-08dc8eea00ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1dTdzFIbGNJN3VZdHg1MEFHT3VjUm9iZXpjU2s1NFA1SUw3czRDWnNXNGcz?=
 =?utf-8?B?ZkFua2JnTlAzSnRiT1prdUZlaVJid21xNkV3cEI4NTVGMjlmVHFpZmxVdEE4?=
 =?utf-8?B?M21iN3FNd3F5VHFxMGlNZ2ZJdCtRaDR3bXVwSVAzYzlLSCtRZXRMMWxHYnJS?=
 =?utf-8?B?TDNWMUFRMC9vdmxZdlZHRDE3bTAxMmNTWDBDdjlOcy9EMkNqWWFMZk5DTWsr?=
 =?utf-8?B?Y1Jrd1B5Z0hORnpxWis4MDFod2F1bnFwMXV1bHBnVzdDaFkxNSszNXhkN2RJ?=
 =?utf-8?B?MExvTUxFS3BIS0hPOGdiTVRWTEgrdEdyaWhoRU50Z3B4dVJMQ09ySlZuUjFP?=
 =?utf-8?B?ZGt3eGMxQURRK2Z2bllNY3lhbUFqbE5LRXYwbUdWUlJsclNweXpMWUtHemRW?=
 =?utf-8?B?SDFSOE44MU9KSW1ZYjduaHlWcmhlZkpBM0VpRzh6WlRtQXh4MU9SK05UcUsy?=
 =?utf-8?B?OURPQVYvelJSNHFzQVZQcUV2NWFSKzhuVlJNVVEzVXJTRnhPV3JETEUydUZM?=
 =?utf-8?B?Y2FiQjROb2FuSWxuUXhaZHRNeUxOTUVPWW5hMW16MlRxRUFHMXU5dXVuQ1ph?=
 =?utf-8?B?eWsrKzdvZkdnK2V4cHRyczV3aGJoTVNybFFwbkpGdTBxRmxDSk5YeU5WN2V5?=
 =?utf-8?B?N1U3WExTb2JTUkNsVFgvTzhNTGtVdkp3NFd5RSs1Y2ZCN3pZY2Uvam5FMlcz?=
 =?utf-8?B?Vm9uY1JFMWsxUHdzditJbWtCUTRPTG9hcDBxV1JndElUV3lFajdub1R0STRv?=
 =?utf-8?B?c1QyaFR5dWtGTWs3UUE0ejVYcnpQbnFDcnQwMXE4eWYzNjFFMzRxN0xraW1k?=
 =?utf-8?B?RlFROEpJN0RYSWl3S043NkYxSHV1ZHZoTTFuYkVMRXROaDY3STUydEtIYzYr?=
 =?utf-8?B?eEsvWlV4a0hmNTh6bEJkZFpPY0U0QmsvVlJUYW1OM1IwWXBnZVpYUGRnSnN2?=
 =?utf-8?B?aHhySlJlVTNERGJlai9KT2paZnJTT2EvYmZ4OWRNWUhnVGdOYTlOMXpNRXV4?=
 =?utf-8?B?ZkU5dEh0L0NBc2xiREFWME1NdC82MnlPMU16WmZMS0NneGdValBxWXpheGYz?=
 =?utf-8?B?ZmNmbDMxU2g3eDNieVNGdVhqUXFHSzU5V1pOcFhyVHpPSks1bmFka2xaaWty?=
 =?utf-8?B?T0h1S0ZQcTh1bzNHa2N5LzBSdHVpdnZ0eDN3SUJ4T2VlN1B5Y3JvUE5ManEx?=
 =?utf-8?B?R3haN0dFN1lJem5pVU5kMEorYzRPTEpUM0VJclVZS1BRbnJleEpKUUduMXE1?=
 =?utf-8?B?azFIbjZLRmdOTStmb2RydTM5V2J0OW42cnZ3N20vRHRzWXNwcnVzWmg3MnlJ?=
 =?utf-8?B?eWNwc2U1M0pNdWNjbkZBbHVtVTUzOGE4VUd1RVRzbENYaDV3NEpnd2dQTFNs?=
 =?utf-8?B?SDBNdUV5OHJPVTlhVUdmb3YwcEJZMUJ4bklyT2xSdkRwQVlNKzVFWGRsRU1H?=
 =?utf-8?B?VWdrSnc4NzdlTjAwUkpITUNzZVdCV0htTTJpSDNTTDRlNkV1NU5MbU8xak8y?=
 =?utf-8?B?citQL2JEVk0rVFR3TDFaZDB3UVlMVDc5QkpuYThXWTJPN1lCZkE5WFNtNXdO?=
 =?utf-8?B?U2I5RWJ6MGYzQ0x1Z3JFdjEyREpJZndqN1lSaDlCNXR3YUM4Y3lpZHVvZWto?=
 =?utf-8?B?VHZwVnlMM2VCT3JjUUxxTEdyMXdhS0xUckIvdzIwejU5Rm9wTGs3NWR2b0ho?=
 =?utf-8?B?eVlZYzNCSUhkdWlyQy83MDZaZitrZ0lGZUxMOWpESHI2clBTL3FlL0FsR2Rz?=
 =?utf-8?Q?Lo6us1CMPelfs2J06w43mUid+gwzbTR3pYwTaIc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzAzQS9rNncrbTlmQUh2YnJVeTJCOFdCWER1QWlEdnhmSXFOdTBwYys3QkZr?=
 =?utf-8?B?SkhGTDg3UjI4K3h2UlVCakIwMUFGUmpRSHhDZlkvSjl2SVoxOWdnOXFjeGpa?=
 =?utf-8?B?cFBRbm5YWURmL1d6LzZhUmFVNUpKakJSZDR6WWxER2JJL3NVOU1nNFNPYzgz?=
 =?utf-8?B?QjRLSEk4eVVEeC9kVHBMMURBUEQ4blRLM1FhZnhzeEMyTStRSGxBRmt5R2k3?=
 =?utf-8?B?NGZZS3ZhZXFDUkdpeTBTMlpjL1hXNUEwQUxEWHF0bzhrVDgyMzRra1c4SllV?=
 =?utf-8?B?M2NXVG1qM1NmQ2YzeUQ5YU1WaTVIVlhIMk9ib3pRc0xrR1FkVmVSalhxditS?=
 =?utf-8?B?YWxuREFOSWs5ZGdUN0FBbENhTnRLTHRuWTBYY0RWZE1pNWg1cXZ5TmptY2gv?=
 =?utf-8?B?cjdPUXk4TG5Lc3gvaytOSStvZHNWdUhjRUVGQmpUYUtSajVwb3N6WUNtWmRW?=
 =?utf-8?B?VitLWkNYeHVwZ2lrYlllUlQ0dVM5ZVBxSERXWGRBZitmRU1JZnlVQjlYSW5Q?=
 =?utf-8?B?eGU0dkZmQ040ek00NUpiVjRIdWtuUlpMSUgydnNpQjVGbGF1aU8xb0hLZmQz?=
 =?utf-8?B?WCtPbE93VGdBdUYwelZCZ2RkSHArbEw0SW9pWE82Tlpubkd4WHZrazQrWm8w?=
 =?utf-8?B?dHVKZElwbWphYWdSQUVFRjFGWFBjcTkzTUFBWEZPVndiYnlTdytNZXJJbGlQ?=
 =?utf-8?B?VFRra0wzWUJpbVdJQ3loZmlYQnh1VGhlM0F2QlZLTS9lYzVYUFE1VkNxSGJY?=
 =?utf-8?B?LzBoZzYwT215SzQxT1dOUWR4UmcxeVdNWi9KZXg1TEhvUGllTkFxVE5reGww?=
 =?utf-8?B?NDZqN1doSnNxc205cG8vS3JaeHdIWU10SEdBM0ZjV1c1d2dSWUxOb1JTRnho?=
 =?utf-8?B?cjJLYmduQjc5dm5HRkpkZXhaR0l6SWM3MmY4L3BXcCtLWm9CZHlKMUFVQ1JV?=
 =?utf-8?B?Ukl3QjlKVXBxc1BTdHg1RHdhK0RmeEZnamlONm1RTUZMelBGQzhYYXBUZ2xJ?=
 =?utf-8?B?UDZJSk8xU2NCbWdmdFV4SWRnQW1xY2lhV0F0eUovOUk5Wko1SG9BQXdGSllZ?=
 =?utf-8?B?VGszRWNkYjU4QkFMK2xVK2VtRHJaazIwWm0vd2VqcGlJNmc2MERodGc4MXhh?=
 =?utf-8?B?Y1I3RFlmcmZaWGtNNU1SSTZvWFJCSEZTaUVZVzhRVXhENE5BOWJWSXVjdVQv?=
 =?utf-8?B?eHBaQlUvNlYyb3N3NGdkYTlIdjNhTlpYNnI0Y2ZHNkluU0JlUk5ibHNlTytG?=
 =?utf-8?B?cHlSVkhEZEVqam0rNUVhTXpQekpwaUdXRzJLRmttM2h2SjNxTy9oL3Z1UHJi?=
 =?utf-8?B?TUVONDdnYlN0VVpPdUUyS2QyL09rSm9USXppZGZKbjdRQzREeTd3QWlNQ2Ur?=
 =?utf-8?B?WFNQT09xRW1DQ1VNaDFCR2pabTBKdmRhWjVwZVZEN0VCRnBFMk5xWVZWdE9I?=
 =?utf-8?B?aG9LWlhvMjRZRFg5N1dRR1NMZlQ5a1RkY1FZUnVMRk5YVlhPVHZ2UUJGUk9s?=
 =?utf-8?B?UjE2TUdsNmxHQTFjT3pUb2U0Tnh5elIyWmZzM2hqNzJ2Ym5pOTFQK2o2Y3Jm?=
 =?utf-8?B?ekdnUXE0WGlhQWlUZEltblErMW1yM2ZEQjJjMmtBYXJ6ZjRNb2h6bC9kRThB?=
 =?utf-8?B?S2pIM1FlSndEK1dKakVYM2FsMGRCa2I3T1NUaWNUV25YczAzN2NzUkZjWjk5?=
 =?utf-8?B?Z3lKT2ZUbnM4aldUdVcyT05pNlIvMFdqT1doM1A1bHNUMlhTMTByb3RqOWlX?=
 =?utf-8?B?SkF0YmYwSit6QzZxcEh6K0lCMitDa2plbjZCL0kyVk1GTWN3S3UzN0JXc1Yz?=
 =?utf-8?B?QXdJUkJVa1ZQOWxlSGFPVUpxSEZCc2JtM29VYU5EVktWS2Z6WEl2SjF5T2hI?=
 =?utf-8?B?Q0FmWnE5cy82cEJ3SW9oMFhXMjZSVGZqQ0oyWUJHSWpaSVBDRUQxdFdsVGpJ?=
 =?utf-8?B?VFZhcGw0NjJSVlVyYUhjNy9VSXZNVmNiM3lLMjEzTDFGb2dOZkNyb01hVTlo?=
 =?utf-8?B?clBXbmN6S1dYYmpQMHBYSWxOWTlCY21hWkZoSXRLS3NOeTg5U0R2MmJucTF2?=
 =?utf-8?B?eUhNUURrREg4WGQ4bTdiRkxWNVpWYnRUL055NnRmZHBnYTUwYVc5SCtBSTlF?=
 =?utf-8?Q?og7LufpZJULmP2FILtKANSndt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d0716-1d73-4964-725b-08dc8eea00ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:24:46.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLukC+OKeAsbbuvyLxcdI4Nx80f5q2q5Nppd48lLa6UM8KS8ypOqqvSU/0IjwG2z9UC9He123CIdshBohPswFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877



On 6/15/2024 2:20 PM, David Laight wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Shannon Nelson
>> Sent: 11 June 2024 00:07
>>
>> From: Brett Creeley <brett.creeley@amd.com>
>>
>> To make space for other data members on the first cache line reduce
>> rx_copybreak from an u32 to u16.  The max Rx buffer size we support
>> is (u16)-1 anyway so this makes sense.
>>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 10 +++++++++-
>>   drivers/net/ethernet/pensando/ionic/ionic_lif.h     |  2 +-
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> index 91183965a6b7..26acd82cf6bc 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> @@ -872,10 +872,18 @@ static int ionic_set_tunable(struct net_device *dev,
>>                             const void *data)
>>   {
>>        struct ionic_lif *lif = netdev_priv(dev);
>> +     u32 rx_copybreak, max_rx_copybreak;
>>
>>        switch (tuna->id) {
>>        case ETHTOOL_RX_COPYBREAK:
>> -             lif->rx_copybreak = *(u32 *)data;
>> +             rx_copybreak = *(u32 *)data;
>> +             max_rx_copybreak = min_t(u32, U16_MAX, IONIC_MAX_BUF_LEN);
> 
> I doubt that needs to be min_t() or that you really need the temporary.

IMHO the temporary variable here makes it more readable than comparing 
directly to the casted/de-referenced opaque data pointer and then 
assigning to the rx_copybreak member if it's a valid value.

We can double check that min_t() is required.

> 
>> +             if (rx_copybreak > max_rx_copybreak) {
>> +                     netdev_err(dev, "Max supported rx_copybreak size: %u\n",
>> +                                max_rx_copybreak);
>> +                     return -EINVAL;
>> +             }
>> +             lif->rx_copybreak = (u16)rx_copybreak;
>>                break;
>>        default:
>>                return -EOPNOTSUPP;
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> index 40b28d0b858f..50fda9bdc4b8 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
>> @@ -206,7 +206,7 @@ struct ionic_lif {
>>        unsigned int nxqs;
>>        unsigned int ntxq_descs;
>>        unsigned int nrxq_descs;
>> -     u32 rx_copybreak;
>> +     u16 rx_copybreak;
>>        u64 rxq_features;
>>        u16 rx_mode;
> 
> There seem to be 6 pad bytes here - why not just use them??

Thanks for pointing this out. It looks like I missed the differences 
between the OOT and upstream ionic_lif structure when reviewing this 
patch. We will take another look.

Thanks for the review,

Brett
> 
>>        u64 hw_features;
> 
>          David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

