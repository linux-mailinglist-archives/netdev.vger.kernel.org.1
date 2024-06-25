Return-Path: <netdev+bounces-106620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E036917049
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CC61F225A1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148A17B438;
	Tue, 25 Jun 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnAtlYtj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D6179203
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340124; cv=fail; b=DwmCRIkPp8MMRnjBpmSZ8Aimm5QetPlFYRnelfkMgmxpsrvii0vSg7nAbTTQ2vgJi+7x9foPVp+U0+Sw1KIaqmr90TceXj+QX9X55w7DLem5HEvu0DLDPqQ5op9RkqCg15PboC6aBHwUx1BgGpA59Heg+RrbYfB2XxXjX+3fPE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340124; c=relaxed/simple;
	bh=iFtqx3DhUe06XDrWBbrtOuBmfIqUDtxP4VzuLe9x+1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p2kJxbiBHbtAPk/zdq+bDQ09ao9cd9iU89daK5YYOBKx00ma7f6veleA3cloFsZKsZd2aqGhub4Y931W9D0Co0lmWaj1SpMQP24JdYHlCade+YkM5XK2TZeTTJhIHisFgDuNlYvKGcFsTWDW11XkODYYFXpe9xIgMHXLnPKCfgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnAtlYtj; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEX7Gkg0pYKZQaDx2jdfGW1GFI5OQquqgnjJ6f0Ute1cgbpyNdVd1189sbxxdVvHFq5IOETWyyPfHAeJDIGiXFNy0hV0+U+XbtuE2rZ2JKK+X6Gr1BREPWKVYjS4kGkFMiYdkp58rWgtN28VpxxgsjvOUFUW5c+s8vxt2blf6uG6NWZYeXhS6oQmrL/dk0yw6oAZflk4+0L/mVluHTKQXSi2eyNMQptgRNrtnAdtS+LntI4v1WGniSdAgc4Rvn9FT+xTqBxsxugQF0A8XavpxV/co8PErgdzSvt1C6kWT1ooMgsv5KABEgR0Ip9OFZBYMs9RKjKm8FmdIjr60MyiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghqx51RAIBzPLqfMMXDc1aF3LpTMRdXHmJMFFPwmRVM=;
 b=I3ORD2C6fi4AvH1unmX84780T/wC85b59ef57rZSsI8lR+iFy0c9EXho/ei0OeLQskP3QOHn/fA0/inY2kmiKlJ/e+JAQ4K+6yYKAQoxJ3+KjFXOgmsc1MWylcy7GGX0dSNj3/qfFsFq4OKvyQpCgRFFiMlhcRSvprl4RjsAkbeNTSC4rHA1tWTjiT0hP/MOjcbqBhwHm0azEu48dDeq3km8KXLPgWj8YtpW4eXXfyRFzdZZbdtk+d1Pnf9Lj7z+yELnHuECKfztrF0/WrFjj6bmolI04AmnAvW14IgNVAzTRbp8Tm8OjJDj9KFoifazCoaMjg/+aN8QMUn3kqmh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghqx51RAIBzPLqfMMXDc1aF3LpTMRdXHmJMFFPwmRVM=;
 b=BnAtlYtjuWtu6qx6iyllZepjIJj0nJdX6Qp6TMizqAYqcJeadTq/VuKj/k+rf5wf7pCMSA/QjE9o1HHsihNuJFDvFtw1uugmL9lo5F6h/Ep+9CUMn8CskOdMUqVzk+PRolqbKIOJto2zmn+f1DhXQj4+/StqEpr7lTUU0zc8woE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 18:28:36 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 18:28:36 +0000
Message-ID: <25fd96cc-10ce-4ef5-b668-b54d130a0996@amd.com>
Date: Tue, 25 Jun 2024 11:28:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] ionic: convert Rx queue buffers to use
 page_pool
Content-Language: en-US
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com
References: <20240625165658.34598-1-shannon.nelson@amd.com>
 <CAMArcTUG9C--vX2xPoi4C73vJ5uDy5=FeU3r=eUnxmvwQQHQTQ@mail.gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <CAMArcTUG9C--vX2xPoi4C73vJ5uDy5=FeU3r=eUnxmvwQQHQTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: d1add13d-e94d-41ff-3f7f-08dc9544a078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkZBSnlhbndvNnljK0RpUzIrS3dBVTRUSVpUUUtWTC9JRjZuQ01KNjRlcUVx?=
 =?utf-8?B?ckZvbzNKanFKVCs1eXRSSkMxWnN4NFJhTXloOVJjWGlYZU5FcTB5ZlMxY3ZF?=
 =?utf-8?B?cUtYaTVKTHNwcHNQUnlMeTZUeThZdGRnc2hQUmx6ekF4c2ZNQXBPWWhIdHB0?=
 =?utf-8?B?dFBSN2FLS3lxWHNqc25FUkMySkZYaGxQOGVJdFhhdlZSMS85S1N3clRmUzB1?=
 =?utf-8?B?aVR5OGlwaXRBaXZNd0JEVlFhQmJhY2x2ek5SK0FKZlBSMEFaeUFYZVJCU2tH?=
 =?utf-8?B?cjFQQmdtS0VCbnNhTzVodXZHVE1BbDdkcG5NUzhTRDZIYjYrM3FYKzF6S2RU?=
 =?utf-8?B?Z2JqUWJxQ1pCeHV4NlR0a0tHVnlleEdON0xMYlEvMHNTU00zRjU0VjN0alcw?=
 =?utf-8?B?aDU0SGxINlBCK0VrN0FuT2g0WVdzQ25Celh6NzlRdHpIRE1jTDJIeUYyZFZr?=
 =?utf-8?B?dXhNVDJUenY3NGRaTWNGd1dMc2tiaGpvdlp5UzVWRDM0NUxCNHZqREUyZFFX?=
 =?utf-8?B?MkxyL0x6U2dVdHdSSjVWU2NocnNRUXd2Mm83d0FDcExUM2tOTFI2NGN0c0RN?=
 =?utf-8?B?MnJwaXRFWjVCOElyelRyZ0J4QzhjcmZKNmZlVGpnK0Z0aGJiaTduYmlWemk3?=
 =?utf-8?B?a0UwZkg1bFNUbmZvK1puMVNMbS9BQk1UeHIzSFhIU2pHbDl0YTBzYlErTFRH?=
 =?utf-8?B?cDd3OUM4ZjZEeGpCbW1xN3Ezc0tMam9zM1VQc2U4SDRxWHdvRnRNK25CUkdy?=
 =?utf-8?B?MTF3YzVaNy9RQnhpbWJZemE2VzFUbHNBcEdJMnpvVGhjUE5VejJXRlZxR3Zo?=
 =?utf-8?B?bm9PSGZsS0JzUXMrSk9MczIyNStGbEJNWCtlQkt6Q1QrdktLSEM5dFZPb1Rv?=
 =?utf-8?B?SU5tQWk1TURNaHBaMkhNbW5CL052V1BUMWFSa3hxdktVMXRsOUduR0d0c25m?=
 =?utf-8?B?OGlhRGM4akdOYlZUTFFrUEpPMG12R0MweFRabjE5Q0t1SGduY3ZUTEFwdExz?=
 =?utf-8?B?WngzS1FRRGxseHd3cnpGV1duSVZvZmNOTTROdlo2V0h3L1ljZWVrYUxtN3Vz?=
 =?utf-8?B?ZTlSbURzZm9EZC9iNCtpZ3kyK2xaRm42TGc1THFPdC9Hakh5cGVVa1RKQUlX?=
 =?utf-8?B?UjRQbnFsMGhTOTFVbFk5aXk4QVU1aXRXODNMWGlVdXM5cFZxOWpud2tMNnZN?=
 =?utf-8?B?SHZHU1JyRXVpWEY2cDBBZ3ZDZVhHTHdpVnk2Lzhla0tSZVdHT2hQeFl4YWl5?=
 =?utf-8?B?SHhnQmZFSTBtSGh1dFdGTXVhTUVhMER1ZGlFY2VHU2RiaFpBRGg3bFg3bHp0?=
 =?utf-8?B?eVdOeXZURVlpTzJFYXpSZXhDZHkyNGtEd2tXcWU5UG9YUDVJQkFWRU50Ylp1?=
 =?utf-8?B?WlpRQXI1czgvNUloOGdvelZwMFRVOHl0bzRYNHN5ZEhlRS9FZmo3ZUM0RXA1?=
 =?utf-8?B?ckViYUF1dkd5SWt4aDEwT3dhYVpOM3BlOVdTUzVuaWdSM0lsZ2JaYkk5bERE?=
 =?utf-8?B?MFdtOG5mb2NJNnBWZ3pSQ2dudzJZZUZjSEFraVBIUVlQc0V0SjZ0T3A3aytu?=
 =?utf-8?B?VzFGQVErY1dLenhCZ0J1SEtBK0dDdmg2c01oaHhWam5MSk9XZmc4TUp5WE85?=
 =?utf-8?B?VFZpdi9VL2lQRTh6WEtwMTM2ZW1jMkdKV05ZN1YybXJCK2hzcHVUN2c5QXI5?=
 =?utf-8?B?NVFISCtzVFJUbDJTT1RjTnBLK240N3VmU1FBZ203bW1RN3dHOXl0Z2ZiR29J?=
 =?utf-8?Q?4D75aramXEpNa0kGFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkxSTUF0R0ZaU2t5U3Q5NGM0LzVXRTdkY3RBTEFoYWZ3dEpxWWRaVkIwNGVE?=
 =?utf-8?B?YUZhVzI1Z0ZpUWFDNTd2RWFzc1ZtTTM1TlROUHMrZkZQekI1KzlGaW93Uytz?=
 =?utf-8?B?Mm02NWNMcE56N3FPd0pJaXhzY3dKRE84R3BuUG5ONFcvYW5ndjFjRUJDanFY?=
 =?utf-8?B?Mm0xZXNOT2VsekdobUJMRGhuenlCWitTTllwTDhEcmtRbmYrQk9pN3hia2ta?=
 =?utf-8?B?R3pQZ1AxY3lLR0dyOUtweldIYVc3OFQ3eGVaWWMwcHNkTGJGeXJOM25FcHVi?=
 =?utf-8?B?YmtPRG5GRjlzSE1BVkZmLzhscURjQmNmK0s1YVhPQ0tWSWZQZU5lcmNTUjJE?=
 =?utf-8?B?eEdnYUVoeUNiZnl3S0l0ZDlyMGNSdjdJbFZMNzlMa2JkYWNHYzJKckFENFYv?=
 =?utf-8?B?b20rQ3MxRG94RnJ4eHk4ZFh0Rmt6Tk0wN1p0bjRqK3k4YURmTXdCYVpxWFJY?=
 =?utf-8?B?ZVJVZEdvQ1UxYVlFRGhQM2xuZ000WTFGRXNLTXp5dmwvVk12VlBEL1NaeG9o?=
 =?utf-8?B?RnZMTkVyVG9HTHJkaW0za3RnWEQxSFJpOFk1eWtGOFVXUlUzUXNhbk9wMG1Y?=
 =?utf-8?B?d1NiOEhQMU9NVWdNL1pCYzZ5TnlUSWR1L2ZpSmtIVlVZQWU0QzhjeDVhVzNy?=
 =?utf-8?B?V0JESE1aQy91dVh0NXM5dUZYMDBSTU1TUDJVUU9yYVFlNXl2cTZ4dUhnYWFI?=
 =?utf-8?B?QjFtWHF3NnlnSHpXL2R3bHAyYVNORVRJVFQ4YWt2YnBlNkYyYkt4STRnc2NR?=
 =?utf-8?B?NmJTbVIxdE53ZU1Wd0xoUUx4dThvR3FSaVg2ZVlxMExwbXYyalhMVVVLUDdx?=
 =?utf-8?B?WGNoK3JvSDZHYW1OQTY4OU9aSlBTTVpjOVFYTG5lQnViaVpOalhmUmNzbVdx?=
 =?utf-8?B?bzByWXpLOE9JUW9ZVEMvZnl3Wndva3FVT0JnaXlUeUc0aEZ2UU1WWE5Kc0ds?=
 =?utf-8?B?VlZGbThDWmQraU1ham5lWmxmZmd6eFoyOVhrZzRHVW5YdldzZXFLUm8rTFRV?=
 =?utf-8?B?bmNuNmNjbU4ycjZYYUpMNnc4M0IrN2ZxbXpVOGtuMjl0Q1hwSjZvYXJxb2J4?=
 =?utf-8?B?RUtPUXRMVjNQb0pyRWhHN2Y2T2FVSVFmODd5OEw0N0RpeWEvaHVUY0dGL0Vo?=
 =?utf-8?B?dm92am1YbW9maTF5NUdBVUFHVEl3ZDB1ZFVyeEJ5eU9Mb1hnaWd6VzZlRW9X?=
 =?utf-8?B?U3RUZmFsRUIwSjZxMDgwTldONzBHQjFadnlHZXY5aUY3c3ZwNURkRnRuVkFO?=
 =?utf-8?B?QWhMUi9TRXJMSy91N3RFb25Kb1QrZU1waUNkaCtoK2NKQ3NmNTBRYjNqR0ZT?=
 =?utf-8?B?Q2NZdXRMMnkxS0ErbjNONFRUM2c0NHlpOEdlRjZTUEJUa3U1dUN5aC9ZY1E4?=
 =?utf-8?B?bWFwZTFucmEzcUZEQkliTU9mcmMxdWxoVUFkdnFRNlBqclVsSmp2a2l5NVg3?=
 =?utf-8?B?dzFQV2FITHN2NTlreGpzTHFQSHZuNnBxek1mS2c5MForbk9ZVWx1TjdDR1FY?=
 =?utf-8?B?VU1JbDJoWitZQnQ4K01JNGljQ1N3Z2tPUDNtUVB6MUlpcU5BcjZqcUI0Z0lY?=
 =?utf-8?B?MkhBK2h6eGhXdFVGNFg2b1BxNnlvS3NhLzV4TVpWUi9SU1hZRlFPd2d4clRi?=
 =?utf-8?B?WWRVMnlEQU51NUxVUDRncjJrUnBFWmI1ZitWdGZ1RXdaSjdONHNwdXZnT3gz?=
 =?utf-8?B?aUlCdm1rYU92QjZadUZnUEhkbFdrWW0yODZ3MEpBSHNUSjNvLzAvWmVIdk9i?=
 =?utf-8?B?R2d6dXpsWTBZUU4yWmxhUEQwckVCQ0FjMVFkMG9RTlgwRTNIWm8wMXF1enp1?=
 =?utf-8?B?bndmVWg4MHh3S3lrNjhyUzQvVHc1SURCbEJaTXhXZnZJb2hQWEYvNkRRWWh2?=
 =?utf-8?B?dWU1RHpUeDVpODh3Und2am5SdkxtRTdIN1U0QVZmVjZReFhsSE9jSlUvRWtH?=
 =?utf-8?B?bCtiMGFLZW5sWVBtTjgxaW1iZWZvaWxhVVd6Y0V2aXdBRWo1ZTNWeXpTcGpa?=
 =?utf-8?B?TmV3eDhkb0xjYkJ6cEFhTE9iclFPUWRRSzNwT2hMV3RsdHlGQUlQandKNnNy?=
 =?utf-8?B?cXJmRGtyZ1BscEo2V2t0ZnpEZFY0YVBlVW16SFVQZGt3Um5nNVFiLzcxTGM0?=
 =?utf-8?Q?JgA+IBN7cpPz5OeefKAMmdQQ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1add13d-e94d-41ff-3f7f-08dc9544a078
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:28:36.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbeBDugs5eWFIFQuxlRdd9ov4rvzPNxN+oSnN50v2tOAuZ9G8kdWQydsmkiAQwwnE/JIIgoMsJB0RDAeZrB2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

On 6/25/2024 11:12 AM, Taehee Yoo wrote:
> 
> On Wed, Jun 26, 2024 at 1:57 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>
> 
> Hi Shannon,Thanks a lot for this work!
>> Our home-grown buffer management needs to go away and we need
>> to be playing nicely with the page_pool infrastructure.  This
>> converts the Rx traffic queues to use page_pool.
>>
>> RFC: This is still being tweaked and tested, but has passed some
>>       basic testing for both normal and jumbo frames going through
>>       normal paths as well as XDP PASS, DROP, ABORTED, TX, and
>>       REDIRECT paths.  It has not been under any performance test
>>       runs, but a quicky iperf3 test shows similar numbers.
>>
>>       This patch seems far enough along that a look-over by some
>>       page_pool experienced reviewers would be appreciated.
>>
>>       Thanks!
>>       sln
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/Kconfig         |   1 +
>>   .../net/ethernet/pensando/ionic/ionic_dev.h   |   2 +-
>>   .../net/ethernet/pensando/ionic/ionic_lif.c   |  43 ++-
>>   .../net/ethernet/pensando/ionic/ionic_txrx.c  | 318 ++++++++----------
>>   4 files changed, 189 insertions(+), 175 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet/pensando/Kconfig
>> index 3f7519e435b8..01fe76786f77 100644
>> --- a/drivers/net/ethernet/pensando/Kconfig
>> +++ b/drivers/net/ethernet/pensando/Kconfig
>> @@ -23,6 +23,7 @@ config IONIC
>>          depends on PTP_1588_CLOCK_OPTIONAL
>>          select NET_DEVLINK
>>          select DIMLIB
>> +       select PAGE_POOL
>>          help
>>            This enables the support for the Pensando family of Ethernet
>>            adapters.  More specific information on this driver can be
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>> index 92f16b6c5662..45ad2bf1e1e7 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
>> @@ -177,7 +177,6 @@ struct ionic_dev {
>>          struct ionic_devinfo dev_info;
>>   };
>>
>> -struct ionic_queue;
>>   struct ionic_qcq;
>>
>>   #define IONIC_MAX_BUF_LEN                      ((u16)-1)
>> @@ -262,6 +261,7 @@ struct ionic_queue {
>>          };
>>          struct xdp_rxq_info *xdp_rxq_info;
>>          struct ionic_queue *partner;
>> +       struct page_pool *page_pool;
>>          dma_addr_t base_pa;
>>          dma_addr_t cmb_base_pa;
>>          dma_addr_t sg_base_pa;
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> index 38ce35462737..e1cd5982bb2e 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/cpumask.h>
>>   #include <linux/crash_dump.h>
>>   #include <linux/vmalloc.h>
>> +#include <net/page_pool/helpers.h>
>>
>>   #include "ionic.h"
>>   #include "ionic_bus.h"
>> @@ -440,6 +441,8 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
>>          ionic_xdp_unregister_rxq_info(&qcq->q);
>>          ionic_qcq_intr_free(lif, qcq);
>>
>> +       page_pool_destroy(qcq->q.page_pool);
>> +       qcq->q.page_pool = NULL;
>>          vfree(qcq->q.info);
>>          qcq->q.info = NULL;
>>   }
>> @@ -579,6 +582,36 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>>                  goto err_out_free_qcq;
>>          }
>>
>> +       if (type == IONIC_QTYPE_RXQ) {
>> +               struct page_pool_params pp_params = {
>> +                       .flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>> +                       .order = 0,
>> +                       .pool_size = num_descs,
>> +                       .nid = NUMA_NO_NODE,
>> +                       .dev = lif->ionic->dev,
>> +                       .napi = &new->napi,
>> +                       .dma_dir = DMA_FROM_DEVICE,
>> +                       .max_len = PAGE_SIZE,
>> +                       .offset = 0,
>> +                       .netdev = lif->netdev,
>> +               };
>> +               struct bpf_prog *xdp_prog;
>> +
>> +               xdp_prog = READ_ONCE(lif->xdp_prog);
>> +               if (xdp_prog) {
>> +                       pp_params.dma_dir = DMA_BIDIRECTIONAL;
>> +                       pp_params.offset = XDP_PACKET_HEADROOM;
>> +               }
>> +
>> +               new->q.page_pool = page_pool_create(&pp_params);
>> +               if (IS_ERR(new->q.page_pool)) {
>> +                       netdev_err(lif->netdev, "Cannot create page_pool\n");
>> +                       err = PTR_ERR(new->q.page_pool);
>> +                       new->q.page_pool = NULL;
>> +                       goto err_out_free_q_info;
>> +               }
>> +       }
>> +
>>          new->q.type = type;
>>          new->q.max_sg_elems = lif->qtype_info[type].max_sg_elems;
>>
>> @@ -586,12 +619,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>>                             desc_size, sg_desc_size, pid);
>>          if (err) {
>>                  netdev_err(lif->netdev, "Cannot initialize queue\n");
>> -               goto err_out_free_q_info;
>> +               goto err_out_free_page_pool;
>>          }
>>
>>          err = ionic_alloc_qcq_interrupt(lif, new);
>>          if (err)
>> -               goto err_out_free_q_info;
>> +               goto err_out_free_page_pool;
>>
>>          err = ionic_cq_init(lif, &new->cq, &new->intr, num_descs, cq_desc_size);
>>          if (err) {
>> @@ -712,6 +745,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
>>                  devm_free_irq(dev, new->intr.vector, &new->napi);
>>                  ionic_intr_free(lif->ionic, new->intr.index);
>>          }
>> +err_out_free_page_pool:
>> +       page_pool_destroy(new->q.page_pool);
>>   err_out_free_q_info:
>>          vfree(new->q.info);
>>   err_out_free_qcq:
>> @@ -2681,7 +2716,8 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
>>                  goto err_out;
>>          }
>>
>> -       err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0, NULL);
>> +       err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_POOL,
>> +                                        q->page_pool);
>>          if (err) {
>>                  dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model failed, err %d\n",
>>                          q->index, err);
>> @@ -2878,6 +2914,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
>>          swap(a->q.base,       b->q.base);
>>          swap(a->q.base_pa,    b->q.base_pa);
>>          swap(a->q.info,       b->q.info);
>> +       swap(a->q.page_pool,  b->q.page_pool);
>>          swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
>>          swap(a->q.partner,    b->q.partner);
>>          swap(a->q_base,       b->q_base);
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index 5bf13a5d411c..ffef3d66e0df 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/if_vlan.h>
>>   #include <net/ip6_checksum.h>
>>   #include <net/netdev_queues.h>
>> +#include <net/page_pool/helpers.h>
>>
>>   #include "ionic.h"
>>   #include "ionic_lif.h"
>> @@ -117,86 +118,19 @@ static void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
>>
>>   static dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
>>   {
>> -       return buf_info->dma_addr + buf_info->page_offset;
>> +       return page_pool_get_dma_addr(buf_info->page) + buf_info->page_offset;
>>   }
>>
>> -static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
>> +static void ionic_rx_put_buf(struct ionic_queue *q,
>> +                            struct ionic_buf_info *buf_info)
>>   {
>> -       return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->page_offset);
>> -}
>> -
>> -static int ionic_rx_page_alloc(struct ionic_queue *q,
>> -                              struct ionic_buf_info *buf_info)
>> -{
>> -       struct device *dev = q->dev;
>> -       dma_addr_t dma_addr;
>> -       struct page *page;
>> -
>> -       page = alloc_pages(IONIC_PAGE_GFP_MASK, 0);
>> -       if (unlikely(!page)) {
>> -               net_err_ratelimited("%s: %s page alloc failed\n",
>> -                                   dev_name(dev), q->name);
>> -               q_to_rx_stats(q)->alloc_err++;
>> -               return -ENOMEM;
>> -       }
>> -
>> -       dma_addr = dma_map_page(dev, page, 0,
>> -                               IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> -       if (unlikely(dma_mapping_error(dev, dma_addr))) {
>> -               __free_pages(page, 0);
>> -               net_err_ratelimited("%s: %s dma map failed\n",
>> -                                   dev_name(dev), q->name);
>> -               q_to_rx_stats(q)->dma_map_err++;
>> -               return -EIO;
>> -       }
>> -
>> -       buf_info->dma_addr = dma_addr;
>> -       buf_info->page = page;
>> -       buf_info->page_offset = 0;
>> -
>> -       return 0;
>> -}
>> -
>> -static void ionic_rx_page_free(struct ionic_queue *q,
>> -                              struct ionic_buf_info *buf_info)
>> -{
>> -       struct device *dev = q->dev;
>> -
>> -       if (unlikely(!buf_info)) {
>> -               net_err_ratelimited("%s: %s invalid buf_info in free\n",
>> -                                   dev_name(dev), q->name);
>> -               return;
>> -       }
>> -
>>          if (!buf_info->page)
>>                  return;
>>
>> -       dma_unmap_page(dev, buf_info->dma_addr, IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> -       __free_pages(buf_info->page, 0);
>> +       page_pool_put_full_page(q->page_pool, buf_info->page, false);
>>          buf_info->page = NULL;
>> -}
>> -
>> -static bool ionic_rx_buf_recycle(struct ionic_queue *q,
>> -                                struct ionic_buf_info *buf_info, u32 len)
>> -{
>> -       u32 size;
>> -
>> -       /* don't re-use pages allocated in low-mem condition */
>> -       if (page_is_pfmemalloc(buf_info->page))
>> -               return false;
>> -
>> -       /* don't re-use buffers from non-local numa nodes */
>> -       if (page_to_nid(buf_info->page) != numa_mem_id())
>> -               return false;
>> -
>> -       size = ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
>> -       buf_info->page_offset += size;
>> -       if (buf_info->page_offset >= IONIC_PAGE_SIZE)
>> -               return false;
>> -
>> -       get_page(buf_info->page);
>> -
>> -       return true;
>> +       buf_info->len = 0;
>> +       buf_info->page_offset = 0;
>>   }
>>
>>   static void ionic_rx_add_skb_frag(struct ionic_queue *q,
>> @@ -207,18 +141,19 @@ static void ionic_rx_add_skb_frag(struct ionic_queue *q,
>>   {
>>          if (!synced)
>>                  dma_sync_single_range_for_cpu(q->dev, ionic_rx_buf_pa(buf_info),
>> -                                             off, len, DMA_FROM_DEVICE);
>> +                                             off, len,
>> +                                             page_pool_get_dma_dir(q->page_pool));
>>
>>          skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
>>                          buf_info->page, buf_info->page_offset + off,
>> -                       len,
>> -                       IONIC_PAGE_SIZE);
>> +                       len, buf_info->len);
>>
>> -       if (!ionic_rx_buf_recycle(q, buf_info, len)) {
>> -               dma_unmap_page(q->dev, buf_info->dma_addr,
>> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> -               buf_info->page = NULL;
>> -       }
>> +       /* napi_gro_frags() will release/recycle the
>> +        * page_pool buffers from the frags list
>> +        */
>> +       buf_info->page = NULL;
>> +       buf_info->len = 0;
>> +       buf_info->page_offset = 0;
>>   }
>>
>>   static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
>> @@ -243,12 +178,13 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
>>                  q_to_rx_stats(q)->alloc_err++;
>>                  return NULL;
>>          }
>> +       skb_mark_for_recycle(skb);
>>
>>          if (headroom)
>>                  frag_len = min_t(u16, len,
>>                                   IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
>>          else
>> -               frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
>> +               frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
>>
>>          if (unlikely(!buf_info->page))
>>                  goto err_bad_buf_page;
>> @@ -259,7 +195,7 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
>>          for (i = 0; i < num_sg_elems; i++, buf_info++) {
>>                  if (unlikely(!buf_info->page))
>>                          goto err_bad_buf_page;
>> -               frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
>> +               frag_len = min_t(u16, len, buf_info->len);
>>                  ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, synced);
>>                  len -= frag_len;
>>          }
>> @@ -276,11 +212,14 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
>>                                            struct ionic_rx_desc_info *desc_info,
>>                                            unsigned int headroom,
>>                                            unsigned int len,
>> +                                         unsigned int num_sg_elems,
>>                                            bool synced)
>>   {
>>          struct ionic_buf_info *buf_info;
>> +       enum dma_data_direction dma_dir;
>>          struct device *dev = q->dev;
>>          struct sk_buff *skb;
>> +       int i;
>>
>>          buf_info = &desc_info->bufs[0];
>>
>> @@ -291,54 +230,58 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
>>                  q_to_rx_stats(q)->alloc_err++;
>>                  return NULL;
>>          }
>> +       skb_mark_for_recycle(skb);
>>
>> -       if (unlikely(!buf_info->page)) {
>> -               dev_kfree_skb(skb);
>> -               return NULL;
>> -       }
>> -
>> +       dma_dir = page_pool_get_dma_dir(q->page_pool);
>>          if (!synced)
>>                  dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
>> -                                             headroom, len, DMA_FROM_DEVICE);
>> +                                             headroom, len, dma_dir);
>>          skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info) + headroom, len);
>> -       dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
>> -                                        headroom, len, DMA_FROM_DEVICE);
>>
>>          skb_put(skb, len);
>>          skb->protocol = eth_type_trans(skb, netdev);
>>
>> +       /* recycle the Rx buffer now that we're done with it */
>> +       ionic_rx_put_buf(q, buf_info);
>> +       buf_info++;
>> +       for (i = 0; i < num_sg_elems; i++, buf_info++)
>> +               ionic_rx_put_buf(q, buf_info);
>> +
>>          return skb;
>>   }
>>
>> +static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
>> +                                 struct ionic_buf_info *buf_info,
>> +                                 int nbufs)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < nbufs; i++) {
>> +               buf_info->page = NULL;
>> +               buf_info++;
>> +       }
>> +}
>> +
>>   static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
>>                                      struct ionic_tx_desc_info *desc_info)
>>   {
>> -       unsigned int nbufs = desc_info->nbufs;
>> -       struct ionic_buf_info *buf_info;
>> -       struct device *dev = q->dev;
>> -       int i;
>> +       struct xdp_frame_bulk bq;
>>
>> -       if (!nbufs)
>> +       if (!desc_info->nbufs)
>>                  return;
>>
>> -       buf_info = desc_info->bufs;
>> -       dma_unmap_single(dev, buf_info->dma_addr,
>> -                        buf_info->len, DMA_TO_DEVICE);
>> -       if (desc_info->act == XDP_TX)
>> -               __free_pages(buf_info->page, 0);
>> -       buf_info->page = NULL;
>> +       xdp_frame_bulk_init(&bq);
>> +       rcu_read_lock(); /* need for xdp_return_frame_bulk */
>>
>> -       buf_info++;
>> -       for (i = 1; i < nbufs + 1 && buf_info->page; i++, buf_info++) {
>> -               dma_unmap_page(dev, buf_info->dma_addr,
>> -                              buf_info->len, DMA_TO_DEVICE);
>> -               if (desc_info->act == XDP_TX)
>> -                       __free_pages(buf_info->page, 0);
>> -               buf_info->page = NULL;
>> +       if (desc_info->act == XDP_TX) {
>> +               xdp_return_frame_rx_napi(desc_info->xdpf);
>> +       } else if (desc_info->act == XDP_REDIRECT) {
>> +               ionic_tx_desc_unmap_bufs(q, desc_info);
>> +               xdp_return_frame_bulk(desc_info->xdpf, &bq);
>>          }
>>
>> -       if (desc_info->act == XDP_REDIRECT)
>> -               xdp_return_frame(desc_info->xdpf);
>> +       xdp_flush_frame_bulk(&bq);
>> +       rcu_read_unlock();
>>
>>          desc_info->nbufs = 0;
>>          desc_info->xdpf = NULL;
>> @@ -362,9 +305,15 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>>          buf_info = desc_info->bufs;
>>          stats = q_to_tx_stats(q);
>>
>> -       dma_addr = ionic_tx_map_single(q, frame->data, len);
>> -       if (!dma_addr)
>> -               return -EIO;
>> +       if (act == XDP_TX) {
>> +               dma_addr = page_pool_get_dma_addr(page) + off;
>> +               dma_sync_single_for_device(q->dev, dma_addr, len, DMA_TO_DEVICE);
>> +       } else /* XDP_REDIRECT */ {
>> +               dma_addr = ionic_tx_map_single(q, frame->data, len);
>> +               if (dma_mapping_error(q->dev, dma_addr))
>> +                       return -EIO;
>> +       }
>> +
>>          buf_info->dma_addr = dma_addr;
>>          buf_info->len = len;
>>          buf_info->page = page;
>> @@ -386,10 +335,19 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
>>                  frag = sinfo->frags;
>>                  elem = ionic_tx_sg_elems(q);
>>                  for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
>> -                       dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
>> -                       if (!dma_addr) {
>> -                               ionic_tx_desc_unmap_bufs(q, desc_info);
>> -                               return -EIO;
>> +                       if (act == XDP_TX) {
>> +                               dma_addr = page_pool_get_dma_addr(skb_frag_page(frag));
>> +                               dma_addr += skb_frag_off(frag);
>> +                               dma_sync_single_for_device(q->dev, dma_addr,
>> +                                                          skb_frag_size(frag),
>> +                                                          DMA_TO_DEVICE);
>> +                       } else {
>> +                               dma_addr = ionic_tx_map_frag(q, frag, 0,
>> +                                                            skb_frag_size(frag));
>> +                               if (dma_mapping_error(q->dev, dma_addr)) {
>> +                                       ionic_tx_desc_unmap_bufs(q, desc_info);
>> +                                       return -EIO;
>> +                               }
>>                          }
>>                          bi->dma_addr = dma_addr;
>>                          bi->len = skb_frag_size(frag);
>> @@ -493,6 +451,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>          struct netdev_queue *nq;
>>          struct xdp_frame *xdpf;
>>          int remain_len;
>> +       int nbufs = 1;
>>          int frag_len;
>>          int err = 0;
>>
>> @@ -526,13 +485,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>                  do {
>>                          if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
>>                                  err = -ENOSPC;
>> -                               goto out_xdp_abort;
>> +                               break;
>>                          }
>>
>>                          frag = &sinfo->frags[sinfo->nr_frags];
>>                          sinfo->nr_frags++;
>>                          bi++;
>> -                       frag_len = min_t(u16, remain_len, ionic_rx_buf_size(bi));
>> +                       frag_len = min_t(u16, remain_len, bi->len);
>>                          dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(bi),
>>                                                        0, frag_len, DMA_FROM_DEVICE);
>>                          skb_frag_fill_page_desc(frag, bi->page, 0, frag_len);
>> @@ -542,6 +501,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>                          if (page_is_pfmemalloc(bi->page))
>>                                  xdp_buff_set_frag_pfmemalloc(&xdp_buf);
>>                  } while (remain_len > 0);
>> +               nbufs += sinfo->nr_frags;
>>          }
>>
>>          xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
>> @@ -552,14 +512,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>                  return false;  /* false = we didn't consume the packet */
>>
>>          case XDP_DROP:
>> -               ionic_rx_page_free(rxq, buf_info);
>>                  stats->xdp_drop++;
>>                  break;
>>
>>          case XDP_TX:
>>                  xdpf = xdp_convert_buff_to_frame(&xdp_buf);
>> -               if (!xdpf)
>> -                       goto out_xdp_abort;
>> +               if (!xdpf) {
>> +                       err = -ENOSPC;
>> +                       break;
>> +               }
>>
>>                  txq = rxq->partner;
>>                  nq = netdev_get_tx_queue(netdev, txq->index);
>> @@ -571,12 +532,10 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>                                            ionic_q_space_avail(txq),
>>                                            1, 1)) {
>>                          __netif_tx_unlock(nq);
>> -                       goto out_xdp_abort;
>> +                       err = -EIO;
>> +                       break;
>>                  }
>>
>> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
>> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> -
>>                  err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
>>                                             buf_info->page,
>>                                             buf_info->page_offset,
>> @@ -584,40 +543,35 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>>                  __netif_tx_unlock(nq);
>>                  if (unlikely(err)) {
>>                          netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
>> -                       goto out_xdp_abort;
>> +                       break;
>>                  }
>> -               buf_info->page = NULL;
>> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
>>                  stats->xdp_tx++;
>>
>> -               /* the Tx completion will free the buffers */
>>                  break;
>>
>>          case XDP_REDIRECT:
>> -               /* unmap the pages before handing them to a different device */
>> -               dma_unmap_page(rxq->dev, buf_info->dma_addr,
>> -                              IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
>> -
>>                  err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
>>                  if (unlikely(err)) {
>>                          netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
>> -                       goto out_xdp_abort;
>> +                       break;
>>                  }
>> -               buf_info->page = NULL;
>> +
>>                  rxq->xdp_flush = true;
>> +               ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
>>                  stats->xdp_redirect++;
>>                  break;
>>
>>          case XDP_ABORTED:
>>          default:
>> -               goto out_xdp_abort;
>> +               err = -EIO;
>> +               break;
>>          }
>>
>> -       return true;
>> -
>> -out_xdp_abort:
>> -       trace_xdp_exception(netdev, xdp_prog, xdp_action);
>> -       ionic_rx_page_free(rxq, buf_info);
>> -       stats->xdp_aborted++;
>> +       if (err) {
>> +               trace_xdp_exception(netdev, xdp_prog, xdp_action);
>> +               stats->xdp_aborted++;
>> +       }
>>
>>          return true;
>>   }
>> @@ -639,6 +593,15 @@ static void ionic_rx_clean(struct ionic_queue *q,
>>          stats = q_to_rx_stats(q);
>>
>>          if (comp->status) {
>> +               struct ionic_rxq_desc *desc = &q->rxq[q->head_idx];
>> +
>> +               /* Most likely status==2 and the pkt received was bigger
>> +                * than the buffer available: comp->len will show the
>> +                * pkt size received that didn't fit the advertised desc.len
>> +                */
>> +               dev_dbg(q->dev, "q%d drop comp->status %d comp->len %d desc.len %d\n",
>> +                       q->index, comp->status, comp->len, desc->len);
>> +
>>                  stats->dropped++;
>>                  return;
>>          }
>> @@ -658,7 +621,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
>>          use_copybreak = len <= q->lif->rx_copybreak;
>>          if (use_copybreak)
>>                  skb = ionic_rx_copybreak(netdev, q, desc_info,
>> -                                        headroom, len, synced);
>> +                                        headroom, len,
>> +                                        comp->num_sg_elems, synced);
>>          else
>>                  skb = ionic_rx_build_skb(q, desc_info, headroom, len,
>>                                           comp->num_sg_elems, synced);
>> @@ -798,32 +762,38 @@ void ionic_rx_fill(struct ionic_queue *q)
>>
>>          for (i = n_fill; i; i--) {
>>                  unsigned int headroom;
>> -               unsigned int buf_len;
>>
>>                  nfrags = 0;
>>                  remain_len = len;
>>                  desc = &q->rxq[q->head_idx];
>>                  desc_info = &q->rx_info[q->head_idx];
>>                  buf_info = &desc_info->bufs[0];
>> -
>> -               if (!buf_info->page) { /* alloc a new buffer? */
>> -                       if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
>> -                               desc->addr = 0;
>> -                               desc->len = 0;
>> -                               return;
>> -                       }
>> -               }
>> +               ionic_rx_put_buf(q, buf_info);
>>
>>                  /* fill main descriptor - buf[0]
>>                   * XDP uses space in the first buffer, so account for
>>                   * head room, tail room, and ip header in the first frag size.
>>                   */
>>                  headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
>> -               if (q->xdp_rxq_info)
>> -                       buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
>> -               else
>> -                       buf_len = ionic_rx_buf_size(buf_info);
>> -               frag_len = min_t(u16, len, buf_len);
>> +               if (q->xdp_rxq_info) {
>> +                       /* Always alloc the full size buffer, but only need
>> +                        * the actual frag_len in the descriptor
>> +                        */
>> +                       buf_info->len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
>> +                       frag_len = min_t(u16, len, buf_info->len);
>> +               } else {
>> +                       /* Start with max buffer size, then use
>> +                        * the frag size for the actual size to alloc
>> +                        */
>> +                       frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
>> +                       buf_info->len = frag_len;
>> +               }
>> +
>> +               buf_info->page = page_pool_alloc(q->page_pool,
>> +                                                &buf_info->page_offset,
>> +                                                &buf_info->len, GFP_ATOMIC);
>> +               if (unlikely(!buf_info->page))
>> +                       return;
>>
>>                  desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info) + headroom);
>>                  desc->len = cpu_to_le16(frag_len);
>> @@ -833,20 +803,31 @@ void ionic_rx_fill(struct ionic_queue *q)
>>
>>                  /* fill sg descriptors - buf[1..n] */
>>                  sg_elem = q->rxq_sgl[q->head_idx].elems;
>> -               for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++, sg_elem++) {
>> -                       if (!buf_info->page) { /* alloc a new sg buffer? */
>> -                               if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
>> -                                       sg_elem->addr = 0;
>> -                                       sg_elem->len = 0;
>> +               for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++) {
>> +                       frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE);
>> +
>> +                       /* Recycle any "wrong" sized buffers */
>> +                       if (unlikely(buf_info->page && buf_info->len != frag_len))
>> +                               ionic_rx_put_buf(q, buf_info);
>> +
>> +                       /* Get new buffer if needed */
>> +                       if (!buf_info->page) {
>> +                               buf_info->len = frag_len;
>> +                               buf_info->page = page_pool_alloc(q->page_pool,
>> +                                                                &buf_info->page_offset,
>> +                                                                &buf_info->len, GFP_ATOMIC);
>> +                               if (unlikely(!buf_info->page)) {
>> +                                       buf_info->len = 0;
>>                                          return;
>>                                  }
>>                          }
>>
>>                          sg_elem->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
>> -                       frag_len = min_t(u16, remain_len, ionic_rx_buf_size(buf_info));
>>                          sg_elem->len = cpu_to_le16(frag_len);
>> +
>>                          remain_len -= frag_len;
>>                          buf_info++;
>> +                       sg_elem++;
>>                          nfrags++;
>>                  }
>>
>> @@ -873,17 +854,12 @@ void ionic_rx_fill(struct ionic_queue *q)
>>   void ionic_rx_empty(struct ionic_queue *q)
>>   {
>>          struct ionic_rx_desc_info *desc_info;
>> -       struct ionic_buf_info *buf_info;
>>          unsigned int i, j;
>>
>>          for (i = 0; i < q->num_descs; i++) {
>>                  desc_info = &q->rx_info[i];
>> -               for (j = 0; j < ARRAY_SIZE(desc_info->bufs); j++) {
>> -                       buf_info = &desc_info->bufs[j];
>> -                       if (buf_info->page)
>> -                               ionic_rx_page_free(q, buf_info);
>> -               }
>> -
>> +               for (j = 0; j < ARRAY_SIZE(desc_info->bufs); j++)
>> +                       ionic_rx_put_buf(q, &desc_info->bufs[j]);
>>                  desc_info->nbufs = 0;
>>          }
>>
>> --
>> 2.17.1
>>
>>
> 
> I tested this patch with my test environment.

Well, that was quicker than I expected... :-)


> 
> 1. XDP_TX doesn't work.
> XDP_TX doesn't work both non-jumbo and jumbo frame.
> I can see the "hw_tx_dropped" stats counter is increased.

Interesting - works for me in both cases.  I wonder what is different.
Does your test XDP program swap/edit the SRC and DST mac addresses?


> 
> 2. kernel panic while module unload.
> While packets are forwarding, kernel panic occurs when ionic module is unloaded.

[...]

> 
> 3. Failed to set channel configuration.
> "ethtool -L eth0 combined 1" command fails if xdp is set and prints
> the following messages.
> [ 26.268801] ionic 0000:0a:00.0 enp10s0np0: Changing queue count from 4 to 1
> [ 26.375416] ionic 0000:0a:00.0: Queue 1 xdp_rxq_info_reg_mem_model
> failed, err -22
> [ 26.383658] ionic 0000:0a:00.0: failed to register RX queue 1 info
> for XDP, err -22
> [ 26.391973] ionic 0000:0a:00.0 enp10s0np0: Failed to start queues: -22
> 
> Then it prints the following messages when module is unloaded.
> [ 174.317791] WARNING: CPU: 0 PID: 1310 at net/core/page_pool.c:1030
> page_pool_destroy+0x174/0x190

[...]

Thanks, I'll take a look at these later this week.

Any comments on what you tried that DID work?

sln

> 
> Thanks a lot!
> Taehee Yoo

