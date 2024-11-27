Return-Path: <netdev+bounces-147624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6409DAC48
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7188281E04
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7AB200105;
	Wed, 27 Nov 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S7SVsIe9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A6225D6;
	Wed, 27 Nov 2024 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727901; cv=fail; b=lIqQHYV3hJfBX8wjwOkRZRt0l1Kc2ifTyqA/6BZli0TjQahQcRVKH9h7o7GZ8xAJsmQHQkjRGySp/kV/StUEmuQYLi0bka7FjiW35b45Ee0mAV38NklcywdgapcG9b4NI/ouFqR+q5qwVEfTMAcFx7GvpZV6+m2tSLhdIkIVyew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727901; c=relaxed/simple;
	bh=l7hVnSwMNVfeVddpXo/WvfijnAQ+0Vgam68c52XpZxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KYLGdPpiHGqKBKhOeKlVcm4wKMdF+iiwqnMWOtGPvRGU50j+vnxBDeNU16u0gR+29O0ToUF+tP2ViHL46LDLEPk00MASeS9Pi4OgLyhyt/MHtRDVSkkPJN4XA++VTLynom2WraUk34OybXbYfhMphKZa5okzxpfIZWEPsi6qWks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S7SVsIe9; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9O400FX5j8mVyB6a1ek4sejjUYL3QA3Onm6x8t0hb4HIkIZ3eVp7T6zR33cw8osIIjvCkyQXo7KPimH1YHpAnLJwkOi+A1clxGnc/6sPU0cZWuPBJmIN5dABmn/1C30QJeFb4GXJuRTTsbR020SJa07U8dNTtHO3UrXBcyWXC6hnJFow93eerFWL+YPdsoMzoRpW/XWYgQL37nqjSD5u8yg0svg3X8O500i6DcMRLdG9G1QZ76l61BECJRL6XerWOapI/OmNznpI01qop4ULmv+JJO8iyuFb+rmXDkgQZfKLtMRi6KWq9Ame0W6pw2Gdli8L04/2qV50fuPhPD5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcyNMslLrM8fnw2IIxI/yhZXGuBvQCqVn1QoyYTbs30=;
 b=pWWz7LZ0z4sAHIOP5YIR6pNngtjNH97pat1+LysDTnjMvXeasg803UZolVihajWj7t3izn99Y8d0UX2Zxyj+pYBt6YFeo4Zxt65vVQEN/JFwwflxEz3nDsQZLFpCcv2EgzVwOJGt0/2zmQhxVAsZmCyFE5k8J8DgGpcUhHAWkmMRxRkofxRS8fM6Re/zos0yNBNjpLO3x4cUDfObDeyeBPeFSAAZFcvZ8A2mvgv05I9UkFYgkBAOcDPt3uzkyqWAXZajFwPZTFRbWto96SB7uHHdWsFsKnBiaB51n6RnWSsmmF8OgtuxfsazVnyuREd/9einKvsMYaQdau99ad1fYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcyNMslLrM8fnw2IIxI/yhZXGuBvQCqVn1QoyYTbs30=;
 b=S7SVsIe9BHEN5dcib79peuZUrOvC77RKhI7cZiKJiayGVrXHLOTY0YiqrDODwZ1hq7dOCg/Qe5qsBLI27gpQPO+bA6cdTQjXhWgAGOX3Mee76Ssl4/5GLWFRwxxVlm6VnqxWH9+L6ZgqtfWe2n4lRe2rPj8Ki0T/16eomerIupE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 17:18:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 17:18:11 +0000
Message-ID: <63353dd3-6527-6165-533e-90787a1ebea4@amd.com>
Date: Wed, 27 Nov 2024 17:18:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/27] cxl: add function for obtaining params from a
 region
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-27-alejandro.lucero-palau@amd.com>
 <Zz6haeBDWRHL2IPR@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Zz6haeBDWRHL2IPR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0634.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: d358fae9-e9e2-497b-0666-08dd0f077879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUx6OXRxVDd2YVZOdUNmeGJzNU5ERGRvQzFBaWd5MElvU2RFM05EcDhFRkxS?=
 =?utf-8?B?dWpvTUVKK1JXNnRHSGhkSlpkYUU5d2lZMVFLUmlOanFDZEtqQnkvZmpySEZ1?=
 =?utf-8?B?MDljRTJZeTVYUkpxalpRNllxNWVrbjVjdGdlazNKZFdEZWNJTXBwRGNDTk1V?=
 =?utf-8?B?Qkh3d1FsRkpFeVFYenJQM3EzRkpyNzBoTlQvWVZoZXRhVnpla09WY0p4WTRl?=
 =?utf-8?B?WjFPbzE3STRQQ2YxUVZaNzZ0SU4yUFEwQllwVG5EbnF3RzdPQlBLa1VQbEVQ?=
 =?utf-8?B?cUtsajQ1Tkt5N3dITXRGQ1VrbU4xRkxlZXM3ek1MUENxL0dZT3VkYXNzRG9Z?=
 =?utf-8?B?T05BemxKUGNEdHZtdTZZMTJ2TlJaeVVVYldweTZia0M0Qit4RlEzd3pjQkdU?=
 =?utf-8?B?Zjk1b0QxN3EvZ0VHOUM4NmFNMW1wdU1zQlVvYmRmYTdmN2dCUzhCMXd0aDlQ?=
 =?utf-8?B?alM5RXRlT3JRS0I3M2pZb1VYNHcySjNGR053WVJVTjNPd0J1aXhUdSszaEo5?=
 =?utf-8?B?Zlc1TnZPWFNJZDFSYmNxdnJYN2FyMjdySERqV0ZsUjMreGRQY2pnaU9qQzhW?=
 =?utf-8?B?dGxxY3BpblpzOUsxR0hDaWFLVmlOaHBDWVNUVmduRElpZ0ZvVEo1WDYyeXY0?=
 =?utf-8?B?VGs2aXNMTlhlZDNEWUNGREpJNXBuejM2RXA2dUNDeit4OEhick9mQmVUVUM3?=
 =?utf-8?B?d2h0dkhoM0FudjFkV1d4OE9mRjZnNTcwMGlJSVVBQWI1TzllSnZ6aUpUYSty?=
 =?utf-8?B?Q1lRbXhndkZxYm96ZTZHMEJteXdlV0JjY1BwTFFyN1BQanZKRnFHKy9QcURM?=
 =?utf-8?B?eWYwbE5yZ1dMcVRLUjMyQjVCLzFpZm56VTNEdWwzOEdWOG52S3NYaDBTbEtx?=
 =?utf-8?B?UVJoS2dZVEUzTnF0bGh1VnJtQ2VJS3V1UU9yUFZ2ckZoblB0RW5Kc0NocDht?=
 =?utf-8?B?QVo2U3c0RjBYZXdvS3BCbjdXbzRJZW93UkNYTEZidnJabFVFcWc3TzNlMUJw?=
 =?utf-8?B?aXNHbHN4ZEdiUXRKOTQrYWVZTFhhekQxVVhLTjRZR0UydXM1ZHpWQjBIWVRj?=
 =?utf-8?B?TkNGcTROc2poUkRtVVAxRFV1cHljTzJYckxTanlmU1A4L3BCd1VzM2ZBRFNM?=
 =?utf-8?B?c1ZIK1hLUDR1dldJb0U4Z3lLRUJ1UURtU1NUaldPT05vOG9DcGQxeEZzaENK?=
 =?utf-8?B?dVNXc1gwRW5GSVZ1SGlPSjZDOXVsOTQvWlhhOHo4S1JvbzB4eldDMmRYQzI4?=
 =?utf-8?B?U1ZVdVdwS2JXeWgwckpuTi9yL3pOenhYZnVtUkhLdlM5MlRVTmhDelhKK0dz?=
 =?utf-8?B?SytvMXpiVU9MT1pUc01ncnZ1NGxmNXNNYlJHUkNEeVBPdXduaDBnUXpRd3Jk?=
 =?utf-8?B?U0kvM2hWSGFxbzY1N1d3OFI5UFpIYlFXZ3pnNDhPZEM5L1ZuL3cxS2RIN0wr?=
 =?utf-8?B?d1dacFY0bUFzaGJoS1pqNktYRU8xUEVoNjZ1RFFJbEhvbjQ2cG0rQnl1QWRB?=
 =?utf-8?B?WVQyeW1mM0JJOHlVYlJyRGJnSWFDYm5mREEwVitLS014Ny9zK1RFbU9iZVBz?=
 =?utf-8?B?VkxZdUtXQndrVlNDaXlESFd6T011SkhodnI5ZXIxbTN5cVpGcTRxbERsdVAr?=
 =?utf-8?B?KzhUa2E1ZzJ1VVpTT3pYNk5aVG5keW5FeXFxYnVJOVpwYzFNeTJDMkkrUUl2?=
 =?utf-8?B?UUE5Y0Z0S01pZHRBZEJiYlgvNUdoUU0wNEVpSFFNRGVrK01KWk00STFZczBY?=
 =?utf-8?B?Qk8vWFZjOVJnNnhuOFo1d0h0Y1BFTkRaSWN6eHZUdUEwdTJXN2U0SFNGQ0ZB?=
 =?utf-8?B?cU05aElBbGk5cW82VjRTUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE14VHpUejQwcllVeUU3TjVPb25TSE55RTM0NUQ5aVBvaWtBbktqbENveVBk?=
 =?utf-8?B?dS9rcXYrcExIMXgxSS9uRlMyYzVFMXlqZTduV1BnU0VIQStxTkl1MC9Hd3Uz?=
 =?utf-8?B?SVZvSEJ4SGQxbVp3OUdmanQ0Y3BRTWdXVnpudk1KZ09qaWtPeE40ci9mVTFs?=
 =?utf-8?B?cm9XbzN6S3FsNGZKRHlQOW96OCttQTZGaEVOb252RjM4eVRKalRDMFBYSUVi?=
 =?utf-8?B?VGRud2tZeE0rNzRsZmwrZDZoelAxU21kaGlQVFoyYXlVakpTV1MzK3hNRzhN?=
 =?utf-8?B?UVpZYU5KdkExVWp6QytjOWRBZ0p3TWlYK2d6d1JjWFBXVDErYVhFanVSakhP?=
 =?utf-8?B?SHJLeExobzQybkV1dUlNdlllc0NCeDRnZkJPSEtwemU5alY5RmNSU0QrQmlZ?=
 =?utf-8?B?M3hoUlJ2K0lhYXBtVTVweTkxYW14U05jV0J5QkI0dElVNUZtTDd3YU9KT0Fj?=
 =?utf-8?B?cUVHVEFFWWZRa2FTaVp5S1dSTTFmMFluamFFdyt1ZU5TaWlvTjlIR1lUSm9m?=
 =?utf-8?B?R2YwR3pia3AvbGRZNEpEblFOeDEyRUQyU29yTHhCUHZ1TXg2akUvWnAzVk1k?=
 =?utf-8?B?NUZrajMzTnFMNU1RN2hOYTRHb0xCWHNWSjhJZXN1aEFINUZuMHpiWklFcWpF?=
 =?utf-8?B?QzdUdGM4U0psbUowQTc3MUZhcWtLOUlKTG1SdlpZc2RsSGNWeTlGdmExOXNk?=
 =?utf-8?B?d1dleVhoWDIzWVhVZ1NsZWVvTk42T1Y4QmZOajNyZUlzV3BYOHIwU3lVQ2hm?=
 =?utf-8?B?UXdVMStxZUJuRms0aXpYY2NxZlBoNnFtYW50Z0lKOFlRNHA2YWJVQVE4YzND?=
 =?utf-8?B?cVU5TXlteGs4cklJWEQ5UnJJVmZxWDdaeGZmdkpweEtjZ1FBazN2dExoYXQv?=
 =?utf-8?B?QjN5Q3h1QkJ5RWxKYzJuTjlLbUJsRUovN2hPWkZEMERCY25Ma2cxZkwyZGo4?=
 =?utf-8?B?Rng5cjVGaExTbVh1WVFIc1NyS0IvT0piRDRtck1BQWJFZEtCZnNtQXpFVnlv?=
 =?utf-8?B?d0ZXdmpGNE1Xc05GVWtrRlBJMnUvZTN3cFo1TGVSNmJGd3pRVXBiWmd0dlhH?=
 =?utf-8?B?dXZrQkluR3BTVmFvTVFJNmJ2QlBYQmpEMmhtcUNmUVBpaC8zSnN6ejVjdGRY?=
 =?utf-8?B?N1A0NUJxcXNhQlRkb2wrUXlSMUtQR0VOOE8xRU9JN2orRU5QcWZ2N2cxZmJ3?=
 =?utf-8?B?bWxpd1o3L0wySVZqSkkzaDhWWng1QnN1a3hGMTRwUm5haCt4SFRRM3lXZ2Jq?=
 =?utf-8?B?cVRhYzFmOFdGSm9vR3VrYmRRcFc1dnY3b2gzRlBJc0YzQWFMWHR6blhic1d5?=
 =?utf-8?B?K2I0MlVNeTUrcjlkZi9mN2NvVDM0MWVqRkpjaEpNZjk5aDFiSmExcWt4MXZB?=
 =?utf-8?B?eXArcllTWjBTckJNUkFhK0dVRlpGdC81WXVRcUdEMmt0N2RHMzFMR20vd25F?=
 =?utf-8?B?ZjdZcXZzbXpqd2tEakVqYjhDZC9rMW8yb1JQOTZZd2xZNEo5TmQvWlRsSVlG?=
 =?utf-8?B?VklFVmIxbFBCK0lQMUN1blk4Mkw2QkZ0aHIxRlRDaE9xdjhNMFdrVkJkNmcx?=
 =?utf-8?B?bGNRWFduU0RxZzY2cVh5b09uamhzYTBJZ2RyUTBQSnkrRWsyQlpSNExLS2R0?=
 =?utf-8?B?aWxhaGUwQ1ZqR1lkMXBNcGRSa2FLbUxSZjU2bE05KzhZRWJtSlhJdVBoOFJz?=
 =?utf-8?B?VWt1Wll5MXBhZjJ4ZmtOSSswZmNQTEtxdExRYnVmWkxBRHZBS3BUdFh5eFNC?=
 =?utf-8?B?VUo0ZVFLSVIrRGFIY2llNU9UNm5WdE9QdWo2SVZMNGp1N2NNRTQwTFQ2aHJK?=
 =?utf-8?B?eGtiemxvbi85cDNMVExYMnhZTUhLVnFPWFNOeVU0dTBiUlp5amRXdWpicjdV?=
 =?utf-8?B?NkZVWk1EQWs0cDJ3K2FmZktOTG9NTEhGZEFEc2NHQS9zUXVyMFZUeU5EeVNr?=
 =?utf-8?B?OXpGbnZNcmY1a3lSaGVHVXRWdXZQUCs4anlFbmxBWmpYWTBOWjhqNDUvL1Zq?=
 =?utf-8?B?SG5FR1lGRlRRWTJqQlY4ZmFkejByV2tzS2NoRzNNYXU4ZEZKaC9CRHFka1Q1?=
 =?utf-8?B?OHMxRy9YbDRVdms2clVWTmdDMTJ2b3N2akF3dmpqTzRDdHZCZjl0Wk1IRUhI?=
 =?utf-8?Q?AErGm0c5ZTD8+FrzuLm+J9yTF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d358fae9-e9e2-497b-0666-08dd0f077879
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 17:18:11.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy+3vU95a2xcMyhmqxC8N5Gcb0k+HeuWKHFdlPJkF8WxMUeyo7YuhRmCDtBxn+0gZOpfxEd7o0Ob741RpBwqcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649


On 11/21/24 02:56, Alison Schofield wrote:
> On Mon, Nov 18, 2024 at 04:44:33PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Add a function for given a opaque cxl region struct returns the params
>> to be used for mapping such memory range.
> I may not be understanding what needs to be opaque here.


The driver can not access cxl_region struct just using it in calls, what 
requires this patch as other in this patchset as an API for accel drivers.

Apologies if mentioning that here creates confusion.


> Why not just 'add function to get a region resource'
> and then add 'cxl_get_region_resource().
>
> Region params usually refers to the member of struct cxl_region
> that is called 'params' and that includes more than the resource.


I did not realize using params could be problematic, but I agree it is 
not how we should refer to what we are returning to the caller.

I think using Dave suggestion for using range instead should solve the 
problem.

Thanks


> --Alison
>
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
>> -- 
>> 2.17.1
>>
>>

