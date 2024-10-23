Return-Path: <netdev+bounces-138154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A89AC6C6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611C61C20BFE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FEE194136;
	Wed, 23 Oct 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aS1TaKQ9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F0199384;
	Wed, 23 Oct 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676312; cv=fail; b=E9p35MzeiqIaHihLaWtv4DLkDY5m4+ZemqQemVOaW2EQUAoOENPDVSdFngcQhfPQcwUcca7AT2kC7M02xYhjohwLhpTDsakQ6e4QBrC8GRHOrjqRbQRkvzhaQhdh/XBqy0VQf/etLD+Wr7rKvWgYJ0qo0BZYSZ3UBADcP3SIt60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676312; c=relaxed/simple;
	bh=nTcJkiT8sMkqITAbTMCXpsWaNPf3mfAowAQoXqysuJc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f42XQ0sbnkBTuB+8k3QCoDIq94Je/qCrucejj7Y5ICtHl+vZJpbikaHXyr7fVhdoj1FQUACD3UmQOBl9ox1nDxSELnUpdqo7LJjbr14itCu5apGhuNf1Rbg9lzSL41C6xfP3n+hAPHqC9yapRlOvFyy/ATeme1y54NfloRsE3Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aS1TaKQ9; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS/kpzziQre//P3w0oLAg832oJyd3j3kATMVXUYtqxMFBMc1275VS5l6EGRDjm7KZufyw4+IMS2iR4/RVibfNw8v4aa3uKrdAT2x5z6/yHHez4i/D4hMp6Vrnwxxsn/OtVwlHd9JylrJfhN/T9mwtdqZaOTDGbFzXtsZGcjR3qe+MthyTS0hsRPsVlLNxpFy4A6APdIA8Y5XeesRJ7WAy3L6WTHrAMopXetsII2BHeGAVbUHCa76KTXSK9zx/M00iAzTgA4AU7p3jnUHIB4prasixNPSUzODJGd9NjGSea3VAxs0YsEfBEBUJMg2LMr/SvtReU2jbiXexcmWdmZxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpWIn/fg2lsKcdkOD1+TW+fDdXETFjKqGDhkT4c/1PQ=;
 b=SWD0yDzt7LKMrTXfTjeR0xBaXoO/ft4CG/kmNSlgN1Qfs93PHj1VJWKtVlKbtUg693K5Rx6vjo2qeirtSMGhFKTjQNpLB0pN55dI6yRcbu/uEL0WUQff6i6kyExdYihfn4hsBGs2LGDe16gEkPv45QAC1cEdEkS7hl8DlPybdyiZFBGv1qchIX2jvIp4tLkiz4IomVunUAeImEMDJXKjatvJsZOykzjs7i/q5AacK5Hh8WiChn7g2Ukw02bSLXzrEsx//ojqFUqr05ZxvALDjbktnsY3vC34mgNKsBJgrlx9zUDu1si39U0CsIP24YL67NWqeuiqLToGktjMrSl5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpWIn/fg2lsKcdkOD1+TW+fDdXETFjKqGDhkT4c/1PQ=;
 b=aS1TaKQ9iXd4yMb11kU6+b0ICadQn3NCQ7QEcMAYXBiz7stwwFSbFFD/GLlmi+dRasMSF+6MIZSrICuyyBdU4+eU7rqx75fTDfK9t9SQPSl7HA8CAVhtQhvSwNNuK330t4vGRfpvCT3Fwi/zLKKlTOF/q9hNKkJPlOKeWeNUwbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 09:38:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 09:38:26 +0000
Message-ID: <86522c97-350c-9319-6930-01f97a490578@amd.com>
Date: Wed, 23 Oct 2024 10:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/26] cxl: add Type2 device support
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <fb2d7565-b895-4109-b027-92275e086268@redhat.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <fb2d7565-b895-4109-b027-92275e086268@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0485.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::22) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: be82dee1-e9f7-471a-edfa-08dcf3467197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTJ1d2t6SzkvcmRxb0dkSngwTXo4blo4QmxhUTJ5Tjk5S0pNTnlFajAvcHVO?=
 =?utf-8?B?R3dETk8zUlJaNk9rTmt4N3E1VUpzWll3djlSWm9vMlNPQlRiUXpxMStvVm80?=
 =?utf-8?B?K1lac292KzdxYVVsMks2aFpoM2hpSUhjSGFrR2ROTjNxa0ZmdWFlelQ1MnpW?=
 =?utf-8?B?YVJKQUJ6YTJDMEpVWi9nVmhLekE2dlBCMkRxZVRxTFhXcHp5K1FNY0R5YVkz?=
 =?utf-8?B?bm5lMWZxdTVYekxYNU9tRXRQNVVhbzNFYkE3QWo2ZmVnK1hvcnhpNEYwYUQw?=
 =?utf-8?B?Z1ZZZStiMHFxVVlxVUtGeDY1c3M4bWJoNGVTQkFGTy8wMmxQSkN0cjN5bWRr?=
 =?utf-8?B?U1RKV29ROW9NL2ovRDJ4MGxHZVFGRHpZWC83MTVMTlYzS1hHN0hlK0tQeVBo?=
 =?utf-8?B?aHNwSXlHaldIRk96ZXFBdFVOcG5pZnF0U2xzbFVySlFUZENRZnRiNkp4RFFt?=
 =?utf-8?B?WG9TdWNHN3BRUllxdGFubTFIWjh2NENpU0tKNXRNT0FDenc5STJETHdHK0hY?=
 =?utf-8?B?SnBJS1dGdC9BNERPa2Nod0JPN3lpdTgvcHB6WmVvUEplZmliRnBaNks5OFZu?=
 =?utf-8?B?NDRjbTJnS0lGMnA4QXBkT1RQeGltdis2VVY2Z3JDZVpVZnZ1QWRZc1JRNk4v?=
 =?utf-8?B?L3RPdHc0YlRIdHdlQVpLNUFhK0NaYTBscWthT1JOTTBienhiOVJ6MDUxdDNi?=
 =?utf-8?B?azdiUjZyT0tnQUw5RjAvRldEQTlneXMrbGNrSDRuZ0t3Tk1BVlZaUUFvbmZp?=
 =?utf-8?B?dVVPcHFhVll4aElQTlE4cHk5V0FnOWlsRm1oMVJTcENwaS9lN2dyV0lrbVRH?=
 =?utf-8?B?Q3J4UTRFWEsxa2QvYVFhOVVPSlhubVI3UWIzTG00VC9uNFVrcUdaRkdlbmlp?=
 =?utf-8?B?a2ZrZ3VKZm11Q2N0OVYrV1BpUFR1QUVDYWRPVWVhV3NsK0NYQ01kTzZDNXMw?=
 =?utf-8?B?dnFVeXIwT3V5cFVoUVY1V3NkeG1vRHUyTGhCU2NnTTZjZCszUEo5clhaRlZI?=
 =?utf-8?B?VS85T3htc0djbFNuL3Y1Y3YyalppblVLRVBWTVh4eWNQRElIRzNVa2JWWG40?=
 =?utf-8?B?Q0VabW5PKzBMQm5pS1ZIUmRFUmZISHhsNDNENXBXM2EvSDN0bFl1anVGb2Y2?=
 =?utf-8?B?Vk4yVSt6RTIvd3V2Rm5lcm54cldwUTVTSFhabXl3MjQ3VVl0bHNuWjdsSi9Z?=
 =?utf-8?B?ODg2dGNON1RYM2s4RnpKb2pRQVdjekpOVGxTUXU2UElabFN3MjllNThGNGRq?=
 =?utf-8?B?d1FGRlRGRklFNkhiZXp1NWt3cUcwaDB6a1kyUFhOelBqRVBrb0VFRnBHckpZ?=
 =?utf-8?B?NDF1TmhHbC9XeUR6MEFEazhiL0V2aVoyZ0NwMjlmNlFpSGhZcUc3aU55cGVq?=
 =?utf-8?B?eVdkMXdpWG82YjNFUktHNGpoMjBUSHNtcVN3aGMvTDRERXl5aFVFRjMxdk5D?=
 =?utf-8?B?cWtHVHY3NEgvWTl2cmRyV0xObXN0QUtVODVvM3BzaStFV1ErWHg2clNQQjVt?=
 =?utf-8?B?TDVXSkc1U29uY04vcFhOK1NxVzl3emxqTkxNdmsvVHNZZEF5bjJPZE5CWnJT?=
 =?utf-8?B?UmdNSWxsamFzMXRVVEhwZG1NS3BvcEFMOGJqS1ZaYjRWeGpJNHpGNDRJYndN?=
 =?utf-8?B?ZGxlcWFEb2RSR2N2OS9QT2lTS2dtdlFiTU9LRWQrUWZZVitUdklXQ09yUk1N?=
 =?utf-8?B?TkV1aXFHU1liTThlNHZjWTJ1ODl2YUJpZ0p1akRHZS9LZk51bjd6R2xsZFE5?=
 =?utf-8?B?TGxzV2w0cEVSRnF2aHhTOGQ1ZEFzYjZ3aGIzNmpDR0VldWhsTWFmU0NKbzRE?=
 =?utf-8?Q?Ecw2dKMAdQN1WdJvAvtMmAv7nWb5BnLbT1VDw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBFSVlQR0Iydy83c25qVnJ1ZUpmemg2bE9Nemp0S1JSdlkzcUxTWEZja3l0?=
 =?utf-8?B?TVhsZEw0Ym1YVHdYVUR4dndoajJtWUIxc3VrRkoxNVYxREZnRStrU2RMeHpZ?=
 =?utf-8?B?cjkwd0ZCL2Y4S091aUZ4Wm5Pcnl5WU80c1ZkSTV1SklCNWZuYUh4TW5qT3FR?=
 =?utf-8?B?WTZtL09ydHpUZDJaNXlnUjNIdE1mTHowR01sTS8xbUFuVDc0WHFNUnZEdGcr?=
 =?utf-8?B?ZUVPcFFDOXRlS3Uwc29HTEpMdlZlOElQWE1XVzdoRnZYUkt0Y3E3anRzYi9U?=
 =?utf-8?B?cmVncG9BQkU2NmNLZUZNQjBBbzA2Z1p0V3l1SC9rZm5PekcrQ251cElaWWlw?=
 =?utf-8?B?MHY5azVYeUk3SWl4M2lJVEsvc20zNDR6cDlaNy9QMVlPWDVvbXV4Ym04bUtD?=
 =?utf-8?B?MVd4TUF4eDI3bEdqbjNUN2ZHcHpOMkpIUWZSc1lOcVhTTklGRTdqTXl0N0ph?=
 =?utf-8?B?aDY0aTV4d20rOVNZVnp2WURYdHRTd3lhK21ZMTFqR2hvMnE4Y01tN3Q1UWJm?=
 =?utf-8?B?OFBGaFZkV3JidURyVUd4RUQrdndFbkhrN3ZuSU5kL2RwRXdQY05DQXd6dFpm?=
 =?utf-8?B?elhnYm8xV2pvbGY4Z2t0OSs5K3Jvc3V5bncwZER2d0x5U0lWU3M3M20vUDkx?=
 =?utf-8?B?cGtpMEYyMS9zMVdtZ3dOUldBayt1NDRVbk9ETUV0WnhNa3d6Z0czNWtxQ0VV?=
 =?utf-8?B?Ky9ETlJaVXVOMDVsRDVsVXZCYjJ3eFo2WXdwbTBVVE03L0hVUTRLRFNUYk1R?=
 =?utf-8?B?eU1PSG5xYUVVdUo2SkNOQ2JNZS9TYUZjcGdSaGlJOUN2dzRkdU0xaEowMVJR?=
 =?utf-8?B?dDlMU2xKaGNROVpOQk96bjJPSGRIWUliZlhwL2hzc256Nnk3OEIxUE5hYkFO?=
 =?utf-8?B?OWpRSzFEUXlKQUJHSytsL3J5TW81a21HQjY5RVNQK0hIWmtna0Y0V29mT1E4?=
 =?utf-8?B?RXpiNmxqajN0M2JLdjIwNmw5NjJtWFB0UjRIdkMrcTBUWHV3dkp3RzQ5RnlJ?=
 =?utf-8?B?VU0zYWdONnJubHp4ZTdpcUZzbERJVDdIUzl2ajlheTFvWU9GcXdYeXpSWENP?=
 =?utf-8?B?ekZ0MTJSQkk5NllWWUl2eExLcks5Qnc1bmNXbjd6NmNDYWtlMnNDdDhXZ1RI?=
 =?utf-8?B?a0FBSVFrSUZoMVZpUGJ0bzRoQU4xVG8rV1A5QWFTVzFybnB2N2tYeGs3KzA0?=
 =?utf-8?B?VFpoTEFJRldYdDQvWW9kbjB3MDZTNHNtbjRZcUk0aFVOZ0MvckNuYThCb2E4?=
 =?utf-8?B?c1JtZTFralBDZkRnR0RpVmE0UHJKeHQ4aDRSSFpuSnhZZ3lQL25Wa1pFUG9W?=
 =?utf-8?B?SGRCb3pPbWFxa3RwN2ZLS0U4Y2Q4RVhyL0RRcVRCUHJtdVREcCtIMGVXQ0t1?=
 =?utf-8?B?U3k3Ukx1NkhyVkg4eHhrQS9lRVRFUk50eThlQTdzNVkrTUFaQXZnSnEwRVg2?=
 =?utf-8?B?SVVMZ2U3S2NBczY5cjJwOTNOMTdrT2xOaExYN2RKRkp1Q25RMW9Oa3EvTEZL?=
 =?utf-8?B?MmZJQmg1R1orTWR0L0dhSHRWaCtERys3WUZVN1dKT3R5cDcrZk5GbnFMRkVQ?=
 =?utf-8?B?VW1oT0V1Y256T2xpUEd3UGRaTjVwRDA4RlNOaVVheUs1OXErR0dvak1rOE1Y?=
 =?utf-8?B?VDZHMzVRUCtzVW96VndLNGNFTDFxck9KMFVtQ1IweW8wckJtZEZ0S1hybEYz?=
 =?utf-8?B?ZmxOV2RSVHdSakNsQ3hWWGc1dnBqd1ZGYU9ndGpQci8vdFpvZHY0M0JPc2kw?=
 =?utf-8?B?M1ZxS2JERiszUlBURDA2MHVCUDhIM0ZoeUdYSGVJUGFoVmJzcGV0eDFVT1Bm?=
 =?utf-8?B?ZHJEcmh4WDVMcURFTEVaL3QrNWFHWXErdnhLamsxclRodk15WmZrL2dtZHZn?=
 =?utf-8?B?VTRLVGVzRlNCMlhmMWpKN2JmaU90YmRnNSs5ZHEveDkxWVplT1NoalBoWDFN?=
 =?utf-8?B?Zmxtc292UWprU29MZDBIQTdnYjRJYXpJejFnRnlsU1l4SzUxalFrTWdUaEpN?=
 =?utf-8?B?OEw0TDQzL1NQY1Z1Tzl2SUtPbklLL1MzNmRkSUQ5a05kazM1YlFlbFl0ek8x?=
 =?utf-8?B?TVcrcG9OTC9TTndtMVUyOXpTdU9UOXAydmRzY2ZTWjVvRXhJNE02by9CNmJk?=
 =?utf-8?Q?4OdSb3w4RtyWW1DF8zpvrfZbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be82dee1-e9f7-471a-edfa-08dcf3467197
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 09:38:26.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eoq0/zgorbSVaWjQjYF8zFz32LIx/hdRbYamR/MPEfkk0lIA6XRTECpZqe89CzM7Rl6DL9UfSjr36XBsa0kgsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524


On 10/23/24 09:46, Paolo Abeni wrote:
> Hi,
>
> 10/17/24 18:51, alejandro.lucero-palau@amd.com wrote:
>> 2) The driver for using the added functionality is not a test driver but a real
>> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
>> buffers instead of regions inside PCIe BARs.
> I'm sorry for the late feedback, but which is the merge plan here?
>
> The series spawns across 2 different subsystems and could cause conflicts.
>
> Could the network device change be separated and send (to netdev) after
> the clx ones land into Linus' tree?


Hi Paolo,


With v4 all sfc changes are different patches than those modifying CXL 
core, so I guess this is good for what you suggest.


Not sure the implications for merging only some patches into the CXL tree.


Thanks,

Alejandro


> Thanks,
>
> Paolo
>

