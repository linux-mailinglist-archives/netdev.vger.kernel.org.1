Return-Path: <netdev+bounces-163626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA69A2AFE5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C36D1881195
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2C13A41F;
	Thu,  6 Feb 2025 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Zeyjfy9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D423956F;
	Thu,  6 Feb 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865423; cv=fail; b=WK1gyHvo8VS0vsZvRGPVTPyTRes35AgpYLiM5BjcCiFxV3pQYDkNKV74FEOzyXQuxt/FKiGDK4BJew5KySjWyDu0eRLoc8eQDZ0Fe+iRGPLYwj0qG+MYiYonBEBC8aLYPp8ODZ4jfxeUrSvX/zrpniJW+7BmLC8mF6CmXGkUuHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865423; c=relaxed/simple;
	bh=ONe+cOvMaK6bh5MOk+W7R3baSV0pzEqRXP5eoZi3NuY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kKAhQwNy18QDRMYdCbCACnDBiVJmGdMoPLdniGV5AYmhGvUE2hsIUaVSkvQT9TCR/t4j7+lHSYliyNrjTK6sY8XQ9MzXh9ZyaUQiGSm/gjo/62YMZ0c4oB4qp2ecOZNGvk8u078kEQKS+465SwfmwX2Rw1GqXGNrTt1OLOQnZJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Zeyjfy9; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCYa57kw87fIifVbxVCk58Ih52G987YtCCt4Bv3EGpJADRPQg6UmQqPpz/wL35akwrpNBNAg0PrLNHHMikNUDAh6SdA5Rp+/T16pa9o5Pkg68GSrsAVT5508a9tPdN0yy59Qah6Qg5zjhQa89XyfEt/TxShQ5PKf/iA779CKzoMbDBOc5xEvbbcxBOppxtam+oK5zlF71cvYgDLSBNFjtReWDWlDzS57qKeIIg6BZDbvI0d/Fk2Push1yDYWp0LgeaQjrTjxrc2z4U2odxw/wqiqJN9F7bbQeeVqGqUtwryKVAuMj12kqDopQZweETp5i8gRgzKUJFXa6pmggxYU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUFjL1aGURZtnSuQzGMO6IHB5lzTUl0QOP8/hSE9ugg=;
 b=K9eSrEedyNW6jBqrtZSKvTtyit1u7UvRx73jU1lmsa6KZmd2n2hf2fWvtaJITVcgz8dddMVxiC4qJJXzWu/4p2NZoEpawnlEyj5aFhJID1W2WBEk84HH0W31p+/Df7PI3VBM03aLbdWtFissVQEwSb4KgIqUICHlPpqpuE8kWK/I40SP3FkOcjLAOJoiisBoR4E2exIEZsLMTm8+6jtBA0rmo4qGB4cMmVblfq3kz1ZwrWRjP9xKAlX8IkHhZZK4IK6BtS2wJuoyKyrkjqBqn633lm/lphttfqOgtlaY4ZO+n42NO1/BuzyJQAEBPZG0tDjSbW3g7qtlXG1g9TNH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUFjL1aGURZtnSuQzGMO6IHB5lzTUl0QOP8/hSE9ugg=;
 b=3Zeyjfy9Sn1qLBUilYywN22s2cu2Wxyt/xIJx8ABWgxnrglDIqCTNWRQ4Y0fe0A4iGbkK7/u1FWmwwjhPJZmufexr6tfSfuCZXFn5a3lQYgOpIqCbzMnTeyFwTT9TIiSaAe+g/Ye2caUPOm/q5w5hRVL4kpkMFFYsi08ynCfRlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 18:10:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 18:10:19 +0000
Message-ID: <9ce2dc57-ad51-4587-8099-60f568984b84@amd.com>
Date: Thu, 6 Feb 2025 18:10:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/26] cxl: support device identification without
 mailbox
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-10-alucerop@amd.com>
 <67a3dc0071693_2ee275294fc@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3dc0071693_2ee275294fc@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0286.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f99d58-1593-41a8-1f11-08dd46d983b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTN0d3dWdmoybUJDMGU0dnBmM2pVbG1weTAzNldoSnNJb1ZtT0NnN21odFYz?=
 =?utf-8?B?S2NjMy9qVDNsc2pSdG1WYlRMRnFlVy9ZRllpWDdIdFdvNVNZa3czM05INm1I?=
 =?utf-8?B?RnRuUmtxNnd0NzNjeW5zTEozaDVtNERjcE90L2VTKytGZWFZWjdZcGwyY0tV?=
 =?utf-8?B?SVdWTDUwTGlQRFJWMDJPaUc4NWFYMXhJcEdXR21NR0NrOGh1T0cvaW9OMUpp?=
 =?utf-8?B?SmNJVWF5NHpCRHFIT1g1b1lPemwvYmprdVB2T2lqaFhrNzhENGVjbGNWQWJK?=
 =?utf-8?B?UnM5RFVWNkpnUjRXbjc3WnFjOWRVaEVzUVk0K1h3aEJCSC9teUxrMVU0cDgy?=
 =?utf-8?B?dWlZTTN0U1NUeWx1bVM0dmovZkVJRThheHNPUW1HZ0hLajJYRkFzc2Q5aFgv?=
 =?utf-8?B?Ky80OXVaYnpTTDkvSG5SRkthN3Vjd3FYWDdneDRTZlF6K3R3M21WSGFkV1Jn?=
 =?utf-8?B?VjlLQ2EzZ3BPc29OMTRBM0tJM0JXT0pRbEVxQTFTQzhPV0VBOVduc0VtQmtl?=
 =?utf-8?B?YnQ0OHd4bk5SNFJZQXJMZWQvZlVYRjBMNGhRR3kxN1RBZXA1aEYzSk1yQ2Jl?=
 =?utf-8?B?QzZKTXJYU3Q1Q0lZRHBBbmp5WTZ4RG9SQkFSb202dDhUWXNJeXJHYXJtOTZy?=
 =?utf-8?B?bjNocW04S2p0d2NWdWx6MFFQUndyaDFPMi9xQ3ZQT1JzZE1hNm96cnhPN01V?=
 =?utf-8?B?d0Q3Z0dhOTJTdHhxeVdIZmphc2dKVWJ4OHZGek5vMU5ES1Ntdm10SUtYY25Q?=
 =?utf-8?B?S1pHaFNzRU90NmpSeFlMMDlTVWpGNzZldGl3bExMdVVtTFE5VFp1YnRiLzZZ?=
 =?utf-8?B?akwwNTZldHU5T0JaMEx6RXkrYjMvOUc5UHNqQWcvRzNUZXBOd240K2N4T3BZ?=
 =?utf-8?B?bXdCME8wRitCd3R2NW9jYm5IZzdYTEVFb2d2cldQQ3k0L1V4bFNhVER5VHJE?=
 =?utf-8?B?SXcwYTZUbGF4eTJNY2szR3dhb2FrdklGVEtXb04yaHRtWnRRRjhPVjlqdytL?=
 =?utf-8?B?VURXTzk1cXJRcEttUndOV0pCbEF0ay9YNFg3TGZyRU81OFhVMWZkMjdiVnZy?=
 =?utf-8?B?cjZpTndsUmo4QWVhdnZPdW0ybHE4WmI0Nm00OVM2YjN5NlR4cTNTcG9DbWls?=
 =?utf-8?B?UmR3QXZqbXFNbFYvSTB5aVRiekN3TnVCa01qSXpIUFJLVFFtRXZERkoxcXhH?=
 =?utf-8?B?K3NYcW5BWGJCMGVVQm9uM1AzZ0tCa0hsRnVkN3drczhhazRoMm9xa053UE1M?=
 =?utf-8?B?Q0M5aFRiT0NDMEI0WVBoV1V2V1pQYnpZQ09iYVFRT0NwU2VpOEJMVHBsbzdD?=
 =?utf-8?B?YjlGVHRsbGFzWW0vYUlpM0VpbHBFOFdHSEFISFlPNkFxUmZMZHNKZFBOc1k0?=
 =?utf-8?B?WUN6TlY5Z0NQbnJUY2dZWEM1am1iektmb29KTTVVU2JwNVFNYVYvZWU4Q1Rh?=
 =?utf-8?B?TXR2bW0vOHFVZDh2YkM0eDQ0T095QXJLa0dKUUt5ZGZDd0hOUjhKLzBqRmV3?=
 =?utf-8?B?TkdoVXYvS1JpODZiTWdHUzNSdUw1WGNSYVlWQUx5Tkx2SUo4dEFaa3lKTksz?=
 =?utf-8?B?MVZvREJOUlpIVW1tRExXbis3NzNuOFBjbU5rOHZrcTdVZm5heXlQOFhCVDY5?=
 =?utf-8?B?bDFncE55UjNQbFNHSDNvd0poTXMzb2VJdGZGSWxvRGt0ZldnNG9YRVJjekY0?=
 =?utf-8?B?eGlTOHdCTkc3ZHZnN2piOWlBYU1LcnQ1R0hKWVVMK3ZYZHdkNitrUHpBc1kz?=
 =?utf-8?B?bWRZTDlDZ2xjQlZJY1hoWVM0SU1xMklUM3ptNkUxWm5NaEtrbk5PdUNZMWhW?=
 =?utf-8?B?Mnc5QnlHMkszZks4bEduZ2hvZjNmLzJuN2J6bVFRV3BadFh5bmxHa1FoYmFm?=
 =?utf-8?B?eFZzc1gwQStDaERnNjM5dXRMRFdocnd0WmN4clNTT0paT1dVSlRNaHh2Q3c1?=
 =?utf-8?Q?uLX+oXsrwHY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZldaMEc2OHF4bzdObkEvaksvamVLK1FCMlF3M0pTQkZyYXZtenhPV0k3UVpR?=
 =?utf-8?B?NGpKamhGc0dtREVWNDR6cjhGcGQ2RkVwQWU0RkNYTmo5M1RrT0VqUDI5NzAz?=
 =?utf-8?B?RG40VmFrRlFJTDlTN2FhdW85cnZQdXNNWGozMlhiQUZydTQwOUJqNEZwanBE?=
 =?utf-8?B?UFZ4V1JYTFM2ejZhcnh6UHVyZloyeCtsRkpRU1lRMlVacHNDb3RhRU1YSERM?=
 =?utf-8?B?VWFCODBaVHdJZlFiREQvaVBDM3J1YWcxUllnR3A5WWJzT1NxcjVhM0xoMmNj?=
 =?utf-8?B?ajRtMGRTSlo2RmlidGYrQm1aeUxRV2Zrdk8rUHAxVDZVdzllMlVVUi80a3lv?=
 =?utf-8?B?MHAzSElreDVYazBIR282dEJKN3Rha2xoaDE0dzFLSHpZN1g2RWV3d2lUek5W?=
 =?utf-8?B?TjlvSkxYcTBvWmJuOEoxMkdEcTZ0cEtlaGQ1Q3E4RysxaGZhQzNWQTVNZ3lw?=
 =?utf-8?B?OVNqb1dvMTlJVGwwT1ZucDN6UVJqakY3Y2RIWmhzTll1MDZkNk5KOHJYSzUy?=
 =?utf-8?B?ZWUzRkxPZ1BjbEdTTDhBWnJlcjlEeFJNN1I1bm9FWmJkdWlVbUVYcHU4SUoz?=
 =?utf-8?B?WFNHTU5TcE9yL1h5b3NVU0JmTStvb2VTbDBtU3RsRVpiMXlIdU1TbEM0bXI1?=
 =?utf-8?B?aXl0SDNKelliRW9WM2ozUndEM1J0QytjUTFUODNMMU1ZQi9zc3l2NExNVHFP?=
 =?utf-8?B?cmRmekVzUUFQbDREYUtmYlEzQkdsRVVNblEwN200bjJ5b3JiV0RjekF0clZt?=
 =?utf-8?B?Z1Z3QzdnNVRnWEdlNitrMUhGNllZTnVDN29Ccm1ENDdlZWVBZTRwSTh1ZHV4?=
 =?utf-8?B?V0U5SkRuNU1rK0lFOXZ6bFR3bk0xWGZXWGE0UVJ6UzVxZHZNYkNZVW9JQjBX?=
 =?utf-8?B?VzExKy9GcFMvV2dGdnppY2p3ajU0c1JVY3Rya28zeHRqK05jeTRETG9QUURR?=
 =?utf-8?B?WERNVi9WM294WnBDbFFNNFRVTFUrR1p6SzZFZ2RRMzZiUWIrOXBLc2QyM1p6?=
 =?utf-8?B?TlhOLzlCekNpaFNPUlkybWlwSnpzdk5IbnFLVExHSEluWE12RVUrUWVUUGIz?=
 =?utf-8?B?cUd6cEU5T2M0SGVsM3R3aVNhcktOdW4wRWZYdSt0ZzlZU3MzMWNEZUVjZVlr?=
 =?utf-8?B?RmpiWmtHK2haN0V5VUxKU2lBSi82aDQ4TGtPZURuQy92Ni9KODdjMjh6Mm1N?=
 =?utf-8?B?TUhvc0wxV2cyYWREVjdnbWs1dURlTjNZeWpIRk1pWjJZYjlidWgyd0hVcmw3?=
 =?utf-8?B?OGh0YnRQZnk1SDIzbWhXb3hoRHI4cmJQS0lPVk51c3R3d2s3TCtFTXMxalJq?=
 =?utf-8?B?R1BsRXA0WktvL1JEM0NnRTNaL3NrSUZhRnFWa2pTSEZBTy9Ba0Jhd3c4SzI2?=
 =?utf-8?B?MDIrMHl1TWNsSG1QbytwTTlkUFd3ai94NTVKNmFTV0M2RUtjQlVqZlovQ2Zt?=
 =?utf-8?B?TVBTT1FIK253VXFRK2RiSU0rV25ZYlNCT0wrMW5XS1llZm5xK0NTanRVSDlv?=
 =?utf-8?B?blFBblVPMUZYOE40Z1RaTlMvNVdUbW9aRTRJSUFESGNBYmdJcjhuQWJzOGxF?=
 =?utf-8?B?UGZucURBNlBPQWh0SmtrOVhlTEtqZFVwUWJwNWRPVW55MFpIRXhIdGZqakF5?=
 =?utf-8?B?dFA5aGJ6MDZkTWlMMmh3QjAreEpNUlJ0WElXcWNhWThkVXozVlFyM2N4WEYz?=
 =?utf-8?B?M3kvQnNKekVXUjVJaWY3MHNjc1FQVnhFWEU2MG5CaGh0MWVCZ2xZaTloKy9s?=
 =?utf-8?B?YzhJL0dZNFZNZTgzQW05QmlMM1h4YUJxcWFvTmRhRTlXTHBkUHp5WWJLN21S?=
 =?utf-8?B?by9xcmx1TG02d3k0c09mQXVWdWhvVndOWDZHK3FJdzFsVVE2NWkvbmkwZmpZ?=
 =?utf-8?B?ZlZ3UGtyc0twNHNoSUtkQlNCQVRweWdERG1oZEtLN2thNVJObnRRRTl5aW1E?=
 =?utf-8?B?V3RFWm1ROTgxalZTSkJDUnhvVVRHSXVrTXkvRTFLU1NsR1Qzdy9yakNCVWM5?=
 =?utf-8?B?NUViNUlVRnYxSVg5Q2pTRmtKa1ROeVhZdFhNaHp0MkhKR1FlZWQwTjV2NFNh?=
 =?utf-8?B?R054TFVxZ3YxbGNMTVR5SHlXcHZSa2lSOW5MZjlSNW54dVcrZEhScjRkRFkx?=
 =?utf-8?Q?WL1MqVI67jhHp5OxwoaFB2vyA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f99d58-1593-41a8-1f11-08dd46d983b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:10:19.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+i38zXrPRVyEiRlJfcZdPuAo/IroUjUnpDLDtumxdX2oR87hwSfYiPLz5XDCLRqX2e/QJHWaUctyLGX4PVG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122


On 2/5/25 21:45, Ira Weiny wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params.
>>
>> Allow a Type2 driver to initialize same params using an info struct and
>> assume partition alignment not required by now.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> This is exactly the type of thing I was hoping to avoid by removing these
> members from the mds.  There is no reason you should have to fake these
> values within an mds just to create partitions in the device state.


Let's be practical here.


A type2 without a mailbox needs to give that information for building up 
the DPA partitions. Before it was about dealing with DPA resources from 
the accel driver, but I do not think an accel driver should handle any 
partition setup at all. Mainly because there is code now doing that in 
the cxl core which can be used for accel drivers without requiring too 
much effort. You can see what the sfc driver does now, and it is 
equivalent to the current pci driver. An accel driver with a device 
supporting a mailbox will do exactly the same than the pci driver.


For avoiding the mds fields the weight should not be on the accel 
driver. This patch adds a way for giving the required (and little) info 
to the core for building the partitions. So if you or Dan suggest this 
is wrong and the accel driver should deal with the intrinsics of DPA 
partitions, I will fight against it :-)


I'm quite happy with the DPA partition work, with the result of current 
v10 being simpler and cleaner. But it is time to get the patchsets 
depending on that cleaning work going forward.



