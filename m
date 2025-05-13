Return-Path: <netdev+bounces-190218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA674AB59B1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E69B4A4982
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0202BF973;
	Tue, 13 May 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hG/ZvkgX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B382BF967;
	Tue, 13 May 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153278; cv=fail; b=WSsFZUVHDDzpdwU1HKdo5rEdI7fU8gv9Hi/YWxAeot/UWhH2et4iiQ3SRUUYePAy5jBdGKRyaxZJJikosf+ifmzUPOPA+iceT6KQiFT+0GOcD2dkQU7LOEdS+d+slWQBm7YlAAcJQEEhtB0qaRGVvsVgu8+AEeJVUDLI0cLWDDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153278; c=relaxed/simple;
	bh=IwFQ1hWqNlGCoyTxmcKVN6GK9U5tBOY1Lw6fqdxYprQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WU7rwjtxrTE6RDS7INsp2qW14zmdS1LpQfwPPbjtdRAm4+wPDD1AuYARwprpB7xQiMxbZG4cL2szt/zVIyTQeeXCMyJ5X/GWTvuoYK/JocAdghAjSXfhHs9kjpPEuW1mzpbuLbUu+Eufiy7UAyHgJo77WqVI4QLujduxI4/wD5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hG/ZvkgX; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR8ktd65yrCYmCye1FmaMSw+yNK6c6yAzmWy5GJO8qcC+movkC8sbBMVun4aB8Qt3Noz9xk3ATvmi42QlBu7aCAeuay3AlqQdHhCfBG6PGt75Nv+Ow1K72tDVPDEP6g9kSZ3CWLEv0YUuItRC5RqJnSh5eaVBfRwl/JWMzB6FWzXzGJ9gmBb2Qajg+lGz08i5Djf03EhVs9bX6L2MBlpeU7IW7HUfcugCOb5S+jQ6rrFVc5Fvq8zEwFUBYDPgwZn3lkAfh+qXZs1V6BUIHEZT21FppUEksq9ysybomP3UVqNMDWknuFlnVS73dT9z8YH/TW1T/oTFBIZebjrNFKaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lacY73dIuJiO72gI8tREhqellG67v2aX9td34oRbi/8=;
 b=j4lKTbDxQ9R2FtSRGtlSCEzqylESaYlX/HvsGQZbls8LhPL7DkuKLiZX2Oxb8ZjVXQEFYc2YFlJuCvh/e44ZutyuoRh7CZ01y3M5Lr8Te3InXQniioo8TIy5EsILRS/lcRr8nexwP40zvMCVPWes0cOtW4DAq9gddKLMBhABreZv5Bwn/xZ9kVz8cL8O6Y29Tusds4Sks21fnhVzQj3X2GWktPZ69Nr7WAKkFiG2LHjqRNtfoD6Lz8kxMrzw0qied0R5vVDuL9TlY5gMIwkBVytxdaPCU1Xdcb6UVhMNnYAehltxT3IlwkpqBjesba9j4r5tV7Y4ekEMRSYU05jAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lacY73dIuJiO72gI8tREhqellG67v2aX9td34oRbi/8=;
 b=hG/ZvkgXWM4gy051TdPVv9/ZOWF/RmPCmCWKPKObCQhbLxHnbn4UrGsfgRx8V8hnUb/G3BgIwsAYp2t8zZM0S9znadJFVVklDqayZN4isYw1T3ThDkP+oyIMHPAK5rKaH9O1sqfxWcI6Fy8AN+pkiup1Tv5XHDcT7Dk6efMKHNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 16:21:13 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 16:21:13 +0000
Message-ID: <0891ceea-64fa-4ae7-9a7b-d91c967efaaa@amd.com>
Date: Tue, 13 May 2025 17:21:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/22] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
 <59fa7e55-f563-40f9-86aa-1873806e76cc@intel.com>
 <8342ea50-ea07-4ae8-8607-be48936bcd11@amd.com>
 <ef2782e6-74d1-48e8-8159-069317bf6737@intel.com>
 <fd9888f1-ee5d-4943-89fa-32d6e0fb61a5@amd.com>
 <7447008e-3579-47d4-9f90-28d18429d532@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <7447008e-3579-47d4-9f90-28d18429d532@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d801b3a-8731-461e-c74b-08dd923a2db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjRXR3ZkR2FOei9mdnlWNWRLMTBOR1JpMjc5RGFGaWFZZnhiRmF6eEZ0OEJY?=
 =?utf-8?B?QjkwUHZ2UUUyWlEzQzVUT1Y4QkhwZE1TL2RvWlc4MFBEVXVlMHpNbmFWMWda?=
 =?utf-8?B?aXFxYk43bHozNXpqQ0c5TFBNY0Q3eUVuVmVrallvZno5ZkJjb3d6N2phNUlm?=
 =?utf-8?B?RU01TmpnZjNDemlFTkY2M1lZRlJob29KaGs4K3RVZFlncVhwNHlUSzlOTFg1?=
 =?utf-8?B?YUxFSnVhUUZHbFZVYllXQ1F0QWQxN0c3eXRZc0xDT2pKSjZCYlp4UzQxOS91?=
 =?utf-8?B?MmxCVVJ1emYwYWNPMlpZUmhGM0ZxTTcybTUxT2tpMS9hTDdXM3FWT2lqbG53?=
 =?utf-8?B?bkhvekpuem8xcXJVT1V5SHNjMUVxc2NRNFdNNk85L0Uwb3VMaWZjanhCdTRm?=
 =?utf-8?B?OTJlcHV2R3liKyt1Rk9IWDVnK2NTc1ZQUnRXMFdUYXhRMWlNTnQ3dW1OanYy?=
 =?utf-8?B?NFFkNkJJVGlmdEowbjNqQmpPSlFuUDZ4cVZCY2RJWVI1Ris0ejVycTNyYkJ3?=
 =?utf-8?B?T1ZUL0VrYzFFWkxaWXhEektXSXNUelY2TTY3T1dhc3RYU2JJMTJkUy80aDJs?=
 =?utf-8?B?YnRaeFA3d1o2RlNKTHRicFB5Y010cEFOajVlUGhybGl4anQ4dnZXc2FGT2Vi?=
 =?utf-8?B?NEV2c0RKemJ4S3h2elc1Rm8yMkFNeEQyaHU3R1lXdFpic0dJK3FyeW9iZWdh?=
 =?utf-8?B?RFBkYzZDYThBR0pwRVI3NExyM3RSSDR5R0x5VU80UGVIN1BmVW84TjdHS3VX?=
 =?utf-8?B?RktZcVJENFBEVk1VaTJXazE4N25lcGl5THBlRUxoS2VuYnA3QzEwN0RoaGFL?=
 =?utf-8?B?RHUxOUY4UW10dTh1ajlBVHNlbWJWUmxxZE91dHJNU1NOSHZ4YlZIaEtscWNh?=
 =?utf-8?B?ZU5NSGtsOE5RYWh3bHBQNjA5d1g2NGU2Ui9HWDJla3RCUCtqOWtQdDNEZ0JK?=
 =?utf-8?B?WGFLVjlVRHFCakVFd2xzSjMreDlBcEp1QzU3eUNLcUltWlNoMVFLazkwTi81?=
 =?utf-8?B?SWl2RXpjTTFSaGFNSWR1R1diZHdjaWtpQzZ3MUYxa0dJQ3hqY3NxR0o1ZjJR?=
 =?utf-8?B?VWhiY1NDNDdHNk5qMzc4NlR6TjE0VE1kbWJCdWl4YzBUV1FrU0tOQ3V1b3Ja?=
 =?utf-8?B?dms3ZmRsTGkvSGFUWnl6MUFFVC9iVnRFQlIzNy9VOEVRbHMzampland0djlm?=
 =?utf-8?B?a2JwREFyRmF3ZDFGWGR2cE9FeHRRUkJaaDlvVmV4d2pnNFdUclhMUnVaclhP?=
 =?utf-8?B?Y3BvWUpFUDFDcXZLeEkrM1J0N0p6N0pNc0pWazk0UzZUc3R1QkJLcDRTak5X?=
 =?utf-8?B?Ly90NFRmNEhZOGVtNlZIK3VDMXArSytpWnJlZFlyZXhjZ0RpdHhvMFRySTJu?=
 =?utf-8?B?eFB3SEJwTnoxZk51UkFJdmU5cE80dFZNakFTVVNEcXdMY3laKytWNHdCOFVX?=
 =?utf-8?B?MmlKWHoxcm40dFZYYTRubVVrRU9FZk05eEpDZWxqSHcyNjIwMXVBVE5FVjRl?=
 =?utf-8?B?ZVRMVExpU0xDNHEzNGs0NEhQL0dOTlZXWkhmSnZQYUQ2SFhhdmtOVjZtZDZL?=
 =?utf-8?B?LzNDU1J0RWVKRThRQ25sL2trNVc5VDZHaStKbVJiLzhxbHp2Ymd3azlPbDJF?=
 =?utf-8?B?bzBRNmlpNDcvcnU0Ym9XT3p0Sm80UDRHd3NwenlkSHQ1Uk93QVFYZEZQVXVP?=
 =?utf-8?B?UGpYR2VqY2poYVVKbmczN1BveUZJN2pRcnppbkZLL1dzU2h1b0huMFFCa1h5?=
 =?utf-8?B?S2IxL2d6eWZrYkgzUlJpeWtudlNjSjZKWGNzZlBJKzkwSzdXYlRXdkRRRGlO?=
 =?utf-8?B?cFM4UHJJY0x0Q1UvU0t5QnlPL1l2Z3l2SGVaSy8rV2JDK1B2SUhXK3pCR29s?=
 =?utf-8?B?ZGQvRERFZU1PbGhiNEFFMmFIQ3VoNTNtYXltcXBiRC9HQ1l1UVRaaUUyUEtm?=
 =?utf-8?Q?TlaE0g/1yeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFYd3ZsUW9nbTFHUU9wcHFJdW5JYkRDWVV2ZTBFcXhGZllBbm1leVhFb3B6?=
 =?utf-8?B?bkFCQ21EL3VKK2JNV0FJVlE3OUlreWpPUlZxS0NSZUhDb1dBV0gwbkdZM1JF?=
 =?utf-8?B?L1NEZEI1OHcyVng4ZmZrV0o4TUd4TWE5VmwvN3JLMVRRMHZIdHNTV29kNnhm?=
 =?utf-8?B?T0dSbDNVRXR2NFI5TU9NYkM1Z0ZvN08wandGbEt3d0JsajEwZ2JhSUtiWUN5?=
 =?utf-8?B?Mkc2SVdmaGllbUcvcVF4VlpVTm5sRXVSRUdIR1I1SnFydTdCTnE5bU5WRnZy?=
 =?utf-8?B?dnhLSUY4dmQ3S2x3WU1pbCs3dFFnR004WTNmT0U1Qy9XRVBzSWIraStndEo3?=
 =?utf-8?B?QW1TM201OVBqZ0t6UkhabDNrZW9MVEh0aU5JRlZ5aTFsejVSYjZCRWNOM0tT?=
 =?utf-8?B?a0lzMEQzb0dSYUoyNjltaGQ4ZjFLUlZlcVBFZ0lJL1hEN29zY2ZKTnRKZFhU?=
 =?utf-8?B?YWdMSVNZcHROUE9wcEFPN0REUURMenZza1Yvczg3c01nSWord003V21xMTd2?=
 =?utf-8?B?a1JDcFVHSkN4RTlGTVZhR0FCVWpyVmt1ZldkYVg0Rkw5YkF6M1JCdWFNTGQr?=
 =?utf-8?B?cWJDQUdLdFc0UHM1VW4wV0k2cDNGRzFlb0hvVSs4R0FibFJGWUMwczR0aUxq?=
 =?utf-8?B?cFlYMERFNmdvaFJ5QWt3L0VXaVQzUlZORTlKN084bDFLcVpaY2RldmFvYVpy?=
 =?utf-8?B?ckRUcUpWUEx1VXlZUWdNMFQ5cjdtd1E0V3FrbkFpZ3g0c3EwVlN6T1E1YW9m?=
 =?utf-8?B?R2FUNzV6eXA2clBEeG5PazdVd1hwTHZWYkF3NGxRdExnSzlMSW5jQ0ZuVHlY?=
 =?utf-8?B?L01TNVNabmkzNkpyL3EvUXZvV1ZPbUo1Wmp2N3Y0Mk9GVytuT1hPbTZyREZv?=
 =?utf-8?B?b1ZLNE1LV1IxMGdod3VWelZ1Y3FTeU54MHgyeEZYSzZuVEk3VnUrcElEWHdv?=
 =?utf-8?B?Mktha3RwZEFXUWZtTUJocmN5TjRCWXpScmUyNTZIcGM4a0ZsKzlLOWJPa1F6?=
 =?utf-8?B?MkNSL1dCZkp6U3dsRjJKS2pVZUJSU1RRRTA2MEJJSHVERHRkZDkzVnJ0aTRk?=
 =?utf-8?B?eCtVRm92am1mQ3d6cFlFUkZLUlV4S1dGVGYyTDRYcHRtNU4wOTRBa1BoMlE3?=
 =?utf-8?B?THM4bHY2SXloWjhpUzA5WjVWdWR1OWhQWmNZT2tuWnV4bUlhamM3UTJZZ0R3?=
 =?utf-8?B?amZuNVZxSkwzRloyRytIckY3OGhLNVZaQXVYTGU5bWxkR1NSaVpUYVh5QnhM?=
 =?utf-8?B?aVlFMi9MQTU2VGxxVzBtQVQxUzlwd3FoRXN4akFVOGlwalZ4NG9uOHhuUVpV?=
 =?utf-8?B?SU9pSlFTUmVlZ0l6dTFaZDVtYVlWMWo0UVczZklTWTg1Mjl3bWdJRHFXdGN2?=
 =?utf-8?B?RmZwKzMwMkV5Q2tIS1lZSTJZaFdUTUhua1NuYVQzV3RzekRTVWpIRmMzWm1t?=
 =?utf-8?B?NTFnQkpZOGVBRjZUNms5VmJpaGcxSTFLdTBjL3pBZXZ6dGVEZWhSQXJMOG5O?=
 =?utf-8?B?QU1OaFQ5aXE3L2s2NDFCL2dqYzRDU29ZMm9YQjdSNmlzNzVjTWRRRG5kWGFK?=
 =?utf-8?B?YnlvQTNESnhydC9zTGJVcitRazBzLzRvRVV1Vkp6SjF2MUZUanYzeGlTaTNh?=
 =?utf-8?B?VGQ0MGdkZlR6WTFkNTg2SWk1MUlWR2JIVzl5dWNDMzF1U1MrS3pUM3NxVTRV?=
 =?utf-8?B?L3pISzBlUU9IWklMRkIzNFdMK3lGaEhiaFAzbGZIVmtvaEhLL3JuREM2enY0?=
 =?utf-8?B?bllsRTlJRFBFUHdRaHo2bEJneTdVbDNTdDl3Qy9FR25DU0J1T21SSXpWMnBs?=
 =?utf-8?B?SEdldGh1dlBJZVdlVFQxbWcwMGk1QVNaM0MzZ21RaVRqZERoUEFha3JPbzEw?=
 =?utf-8?B?Snp1clQvVHBCVEpzUXY4S0hmRStwbWZjL1g4T3MwVnpVc1dwRXpDY0ovMytP?=
 =?utf-8?B?RmpuM2VUa1Zpb0pnY1luOGpDS1BtUWRobFQvM005dU13eExJRU1qaG9iV1hq?=
 =?utf-8?B?bFZ5dTJRZm1xWGoweTJSa3BWT1N5MWZvQ2o0a0RLRlpnaWpVOTU4dytHaDYr?=
 =?utf-8?B?NUxvMGtVZWpSV21SNFIwQ3NOSm9Jd3lKeGxKL3VoSjdrUFRGMTcvRlhJdGhH?=
 =?utf-8?Q?wtC4+zw2E/+O+gWQMpnUzgDjw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d801b3a-8731-461e-c74b-08dd923a2db5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 16:21:13.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8muFMfcgpEkBnbQYRFJRe7RiS7iyftlQ/HAO/YfPcXnl4ER2x9LOspxSi18U87VFji1L1ov6x5XsrGh0mljeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585


On 5/13/25 17:04, Dave Jiang wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> On 5/13/25 8:24 AM, Alejandro Lucero Palau wrote:
>> On 5/13/25 16:13, Dave Jiang wrote:
>>> On 5/13/25 1:12 AM, Alejandro Lucero Palau wrote:
>>>> On 5/12/25 23:36, Dave Jiang wrote:
>>>>> On 5/12/25 9:10 AM, alejandro.lucero-palau@amd.com wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> v15 changes:
>>>>>>     - remove reference to unused header file (Jonathan Cameron)
>>>>>>     - add proper kernel docs to exported functions (Alison Schofield)
>>>>>>     - using an array to map the enums to strings (Alison Schofield)
>>>>>>     - clarify comment when using bitmap_subset (Jonathan Cameron)
>>>>>>     - specify link to type2 support in all patches (Alison Schofield)
>>>>>>
>>>>>>      Patches changed (minor): 4, 11
>>>>>>
>>>>> Hi Alejandro,
>>>>> Tried to pull this series using b4. Noticed couple things.
>>>>> 1. Can you run checkpatch on the entire series and fix any issues?
>>>>> 2. Can you rebase against v6.15-rc4? I think there are some conflicts against the fixes went in rc4.
>>>>>
>>>>> Thanks!
>>>>>
>>>> Hi Dave, I'm afraid I do not know what you mean with b4. Tempted to say it was a typo, but in any case, better if you can clarify.
>>> I use the tool b4 to pull patches off the mailing list. As you can see, your series fail on rc4 apply for patch 18.
>>
>> But your head is not what the base for the patchset states. I did work on v15 for working with the last patches in cxl-next so the HEAD should be:
>>
>>
>> commit a223ce195741ca4f1a0e1a44f3e75ce5662b6c06 (origin/next)
>> Author: Dan Carpenter <dan.carpenter@linaro.org>
>> Date:   Thu Feb 22 09:14:02 2024 +0300
>>
>>      cxl/hdm: Clean up a debug printk
>>
> Ah yeah it's better to rebase against Linus's RC series rather than what cxl/next is for me to pull things. Otherwise it gets messy if something has to change in the cxl/next series and your code is based on that. So if you don't mind please rebase against upstream rc4 and I'll attempt to resolve the conflicts your code has against Robert's cleanups. Thank you. Sorry about the confusion. That is the lesson I learned last merge window with all the fun with the 'Features' code.
>
> DJ
>

OK. I'll do so now, so should I keep v15 with another base or a new v16?


Thanks

>>> ✔ ~/git/cxl-for-next [for-6.16/cxl-type2 L|…138]
>>> 08:08 $ git reset --hard v6.15-rc4
>>> HEAD is now at b4432656b36e Linux 6.15-rc4
>>> ✔ ~/git/cxl-for-next [for-6.16/cxl-type2 L|…138]
>>> 08:08 $ b4 shazam -sltSk https://lore.kernel.org/linux-cxl/20250512161055.4100442-1-alejandro.lucero-palau@amd.com/T/#m25a578eb83108678737bf14fdba0d2e5da7f76bd
>>> Grabbing thread from lore.kernel.org/all/20250512161055.4100442-1-alejandro.lucero-palau@amd.com/t.mbox.gz
>>> Checking for newer revisions
>>> Grabbing search results from lore.kernel.org
>>> Analyzing 25 messages in the thread
>>> Looking for additional code-review trailers on lore.kernel.org
>>> Analyzing 955 code-review messages
>>> Checking attestation on all messages, may take a moment...
>>> ---
>>>     [PATCH v15 1/22] cxl: Add type2 device basic support
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-2-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: 563: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>>       ● checkpatch.pl: 773: ERROR: trailing whitespace
>>>     [PATCH v15 2/22] sfc: add cxl support
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-3-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: 213: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>>     [PATCH v15 3/22] cxl: Move pci generic code
>>>       + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-4-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 4/22] cxl: Move register/capability check to driver
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-5-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 5/22] cxl: Add function for type2 cxl regs setup
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-6-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 6/22] sfc: make regs setup with checking and set media ready
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-7-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 7/22] cxl: Support dpa initialization without a mailbox
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-8-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 8/22] sfc: initialize dpa
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-9-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 9/22] cxl: Prepare memdev creation for type2
>>>       + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-10-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 10/22] sfc: create type2 cxl memdev
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-11-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 11/22] cxl: Define a driver interface for HPA free space enumeration
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-12-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: 133: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>>>     [PATCH v15 12/22] sfc: obtain root decoder with enough HPA free space
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-13-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 13/22] cxl: Define a driver interface for DPA allocation
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-14-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: 127: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>>>     [PATCH v15 14/22] sfc: get endpoint decoder
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-15-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 15/22] cxl: Make region type based on endpoint type
>>>       + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-16-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 16/22] cxl/region: Factor out interleave ways setup
>>>       + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-17-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 17/22] cxl/region: Factor out interleave granularity setup
>>>       + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-18-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 18/22] cxl: Allow region creation by type2 drivers
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-19-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: 126: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>>>     [PATCH v15 19/22] cxl: Add region flag for precluding a device memory to be used for dax
>>>       + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-20-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 20/22] sfc: create cxl region
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-21-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 21/22] cxl: Add function for obtaining region range
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-22-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: passed all checks
>>>     [PATCH v15 22/22] sfc: support pio mapping based on cxl
>>>       + Link: https://patch.msgid.link/20250512161055.4100442-23-alejandro.lucero-palau@amd.com
>>>       + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>       ● checkpatch.pl: 219: CHECK: Unbalanced braces around else statement
>>>     ---
>>>     NOTE: install dkimpy for DKIM signature verification
>>> ---
>>> Total patches: 22
>>> ---
>>>    Base: using specified base-commit a223ce195741ca4f1a0e1a44f3e75ce5662b6c06
>>> Applying: cxl: Add type2 device basic support
>>> Applying: sfc: add cxl support
>>> Applying: cxl: Move pci generic code
>>> Applying: cxl: Move register/capability check to driver
>>> Applying: cxl: Add function for type2 cxl regs setup
>>> Applying: sfc: make regs setup with checking and set media ready
>>> Applying: cxl: Support dpa initialization without a mailbox
>>> Applying: sfc: initialize dpa
>>> Applying: cxl: Prepare memdev creation for type2
>>> Applying: sfc: create type2 cxl memdev
>>> Applying: cxl: Define a driver interface for HPA free space enumeration
>>> Applying: sfc: obtain root decoder with enough HPA free space
>>> Applying: cxl: Define a driver interface for DPA allocation
>>> Applying: sfc: get endpoint decoder
>>> Applying: cxl: Make region type based on endpoint type
>>> Applying: cxl/region: Factor out interleave ways setup
>>> Applying: cxl/region: Factor out interleave granularity setup
>>> Applying: cxl: Allow region creation by type2 drivers
>>> Patch failed at 0018 cxl: Allow region creation by type2 drivers
>>> /home/djiang5/git/linux-kernel/.git/worktrees/cxl-for-next/rebase-apply/patch:644: trailing whitespace.
>>>    * @type: CXL device type
>>> warning: 1 line adds whitespace errors.
>>> error: patch failed: drivers/cxl/core/region.c:3607
>>> error: drivers/cxl/core/region.c: patch does not apply
>>> error: patch failed: drivers/cxl/port.c:33
>>> error: drivers/cxl/port.c: patch does not apply
>>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>>> hint: When you have resolved this problem, run "git am --continue".
>>> hint: If you prefer to skip this patch, run "git am --skip" instead.
>>> hint: To restore the original branch and stop patching, run "git am --abort".
>>> hint: Disable this message with "git config set advice.mergeConflict false"
>>>
>>>
>>>> The patchset is against the last cxl-next commit as it it stated at the end, and that is based on v6.15.0-rc4. I had to solve some issues from v14 as last changes in core/region.c from Robert Richter required so.
>>>>
>>>>
>>>> About checkpatch, I did so but I have just done it again for being sure before this email, and I do not seen any issue except a trailing space in patch 1. That same patch has also warnings I do not think are a problem. Some are related to moved code and other on the new macro. FWIW, I'm running those with "checkpatch --strict".
>>>>
>>>>
>>>>>> base-commit: a223ce195741ca4f1a0e1a44f3e75ce5662b6c06
>

