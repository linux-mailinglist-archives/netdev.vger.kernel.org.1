Return-Path: <netdev+bounces-100387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F28FA56B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182442860C3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3413B592;
	Mon,  3 Jun 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ox8EWjwv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE8522E;
	Mon,  3 Jun 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452997; cv=fail; b=De7VR6VcMNmi/elnBsF2PdQ9Q2I8njG9QvjMZe89kfazY4MQ/ytZhFsjRNnv83SzQYptfCCYFGl5vF1sAEL2QgmYDvbM67NGfDtglPJosKWoLxRqGs2GWezf2/BaYGHY4E27FXGsowQwshr+3BHRSrUlALZMkL/LxdybMY5Zscw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452997; c=relaxed/simple;
	bh=7NOWscgzxUOFM8tUVcebMHSJaCojTg5UwexzJhSaIfs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3bXA8Ctxtv6iX1Jfmki1n1Jkxt1f4lsufB8uD5xgkMwBrppZ+Ra55BDP2CmM5bfIBXqfcCq4QO060j1yzTfZcvUvey++V5MljQWT0LfmWlMb3dVFvyl1HKIm4fuMyHtvGJZjs0X1ccgLQfh6JKn6Zk0weKQSsD3Ljke1BddzCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ox8EWjwv; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvB5Vab8gMlHMOFeuA+vvSSuT7BJ+T5uJf4iFhkPZV9eaGgmq/cjuvSIBwe5FgDiK2Uvg5njoOQBYVBx6tVgziS4JOrsjQhuJfrrr39tkKFZCURtqKcZ1A/iUk03jra5OTt2AHvq9SZoztZrjymzSRhq/0BiKrIZUShj4uey8eSVnwizy7I1JxOsuzeg2eJNI9u4F94tcfr7P/RmFvImg9Bx7DiOK5oSIgGWwl5XxadzdF7aOxobak0wTG5UuCmi/fs6aa0BKelDmPkx4secpqSPEUm6dI656t8q8Jy//9EtW0AeygvHp9Qh8mFJ8Us1IMnpQ5xqTxx8Uup7y24j5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVVBmdHm+phPVukryq+rUWcflCKLxkqqKTKUODVwyJE=;
 b=QLjJ+N31LBWdnTT2ccjvB7M0wQP/W570UTI9KJQv2cm0WChC8cvhSxZpR5qhhgWSl5KwAO7REPq6FlQAOHDnb/LYvocfsr5SweAx0x8GtKfkVUuO+lIQqeM1WHHOM73f3vO+YPThx+9ZuC3ck3Sa570nDyX9OLJ3q4ufUA8CG8qVHLRMa67o6lRR/k9a5pEEBo88vCf0+9kI4a5q43/Tv6sjlc1qFFrmMMr4rbJDyrXwsoz5K8lUo3KryrteYQgCnAdKUwy4bjwOacBgl49TxrI40dycRR9qMuvOM2o+qid5D8ApOKQ6068Tk5Ar/c4sC4DgzJ03wrp6yzqaZFfNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVVBmdHm+phPVukryq+rUWcflCKLxkqqKTKUODVwyJE=;
 b=ox8EWjwvq6pZRXwHquf2RazF+73GlovLLG2wESLFukqnO14sDTATzgpFXStTp2CGetDce9KKVadEXEUCMWzGnDBg1vcR+s6g9zTrWbMgn002i1cdm2eWBZWKH3SL0LP5h9MbBmawedKj2tw+0dC1TWHsfkXO95OsCqqyfEt4TtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Mon, 3 Jun 2024 22:16:33 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 22:16:32 +0000
Message-ID: <2a8c0faf-5e56-4140-977b-da312136435f@amd.com>
Date: Mon, 3 Jun 2024 15:16:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ionic: advertise 52-bit addressing limitation
 for MSI-X
To: David Christensen <drc@linux.ibm.com>,
 Brett Creeley <brett.creeley@amd.com>,
 "supporter:PENSANDO ETHERNET DRIVERS" <drivers@pensando.io>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:PENSANDO ETHERNET DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240530214026.774256-1-drc@linux.ibm.com>
 <20240603212747.1079134-1-drc@linux.ibm.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240603212747.1079134-1-drc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ce898d-91e3-45b2-af9f-08dc841ad32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkVScGdVa1FBNis0M3NoRTRBZDR0dElWWnV3dHVsMnV0bVYwQyt6aGlDTURw?=
 =?utf-8?B?K1UyWUZZei85S3BKRHNQZUNOZUdwc3o3cVE4OVB4SUpNQ3VnOE1GQ011T3g2?=
 =?utf-8?B?SGJBOWQ2aCt3UWJ0UllRUkl5N3lNSmJRR0xOcVFEYlZxbnJWMk1FeU1XRjAx?=
 =?utf-8?B?WjB5VEMweTBhUHI2ZTV5NUpDY0lwajFXQnBqM3VjVklNZmdQU1NDbWN4WDd6?=
 =?utf-8?B?UjRYRTNGNExOU3Z0a2ZCRldOMnlDUldkRmpVL3JiVGJkeEh0S1JNSFpKaW50?=
 =?utf-8?B?am5XdkR3TENPSHcxSG00NzNiRnVuSFNPNysvSC83dy93enRHMnoyZzVtYStt?=
 =?utf-8?B?UURSZWlrelVlT1JVRlZQZ3JuNFpHaU5CUzA0d25SemlOdWhmUW9obHRRS2xi?=
 =?utf-8?B?bCs5NUQwQStPSHBsUXQrVmlXM2psQTU3K3lmaW1JM2VML0Q0eGtiemNkSExS?=
 =?utf-8?B?NnRuS3p5SGlycGlrL3FhM1FFb2Z4MVJzejQzS25SNTdXZjJRZTFSdmZnNVRS?=
 =?utf-8?B?ZmRPT3paZVA2eTZHRGJOd2pMYWI5aXZKMnBMRktLWURCK0dIeFlOck41Z2Ri?=
 =?utf-8?B?Y2V3UXpkUGgwRE1EK1RzRS9LdDljR0FqL2dpa2IwR2l2ME9PYVFGcXlqdUor?=
 =?utf-8?B?REtFVVJza2s1N2NTVnA3NmIyY0VJSlFGY2o5L2h0OUFsZHhGS3NURmpLNHFa?=
 =?utf-8?B?N1Awc1FIdmtPYVB4cFZJd2x1QTJQTGNudE9FS2dXMndUbFgvWDZwYjZXVlhk?=
 =?utf-8?B?N1pyUm9xelZyODRwTmRrVWRzSFhPa1ByUFNITkFlcWV0MFMxNkdqZTRIUkFJ?=
 =?utf-8?B?QXVmdHcvMDJ5R3pJWWY2S1ltTjhCcnhtNlZuUDB0b2FqSzZTY0NUSGc1YVZt?=
 =?utf-8?B?NGNOdm9PTk5LK2ZRdy9rUnRPYm12R0V1YVFBWmJMUlVnb0I4ZU1BQlp0RUtn?=
 =?utf-8?B?cllTVkFLS0t3Rzh0WkV6eFl6K290RUQ1QWhOTUtmenp5TlU4TW1DWFJCampO?=
 =?utf-8?B?c3dRUEl4d0Nkb1hIaHdTNUp5Qk0zcTh1VGtFSEttNGtwQngreG5BSnZXbmM2?=
 =?utf-8?B?UW5ERURmTzBtZW1zR2dBd29MSlFvbTU0WjNzUUNCdkJmMmlIVFNXT1VneXZt?=
 =?utf-8?B?TFB1WTlNSDhvczdILzRGNWplbE9BNGIvN3ZzUW9rYmszOHV2eVBJWnVHL0NK?=
 =?utf-8?B?cWM4MjcxbHhHcE5WK3hrOWlubG81ekp5R1VLTzh6VXZGeU9YZFcxTDRHRlhF?=
 =?utf-8?B?bVFyRFhwOWlrdVRmMFMxeEFTc2FCZmtsaENkckZQUmIwZU1pYVg4Y2RVOGRE?=
 =?utf-8?B?a3d5M1d5c21kaEJMNGtaNDIwbXNGc1hMTFo0Z09McmJnYnhOU0JTYjNOaGxv?=
 =?utf-8?B?MS9Na0JwOXZ3ZkRqVkpXT1o4enhLdmUzN05NbHkwVWFyNVl2ZVpWaS9yRHhH?=
 =?utf-8?B?L0Y5Y3FOeVRadHcwM1hXcGwweHZyekRhY1Vtb2FvZklFNGMrQjlSL3Rnd2NI?=
 =?utf-8?B?am4yWnJCeDZGejk1YjEvVzVSaTBDRW1wenFrL0wyZXZibENCNVBHUDVsRzN5?=
 =?utf-8?B?anV1U2R1aklYckZBZVUyVzExbkdrd2RpdGxBVDZ2UENIYjdpSUx4cE9JK3lU?=
 =?utf-8?B?NGZLd2puUmdqSmRJUzJWU01vbjlab0lKelY1OHQxeUpqL2JuTTlzK3FZM0Zy?=
 =?utf-8?B?NXcrNUtkaTd6T1VOU1J3QmlkUVBGT3JlNS82M3BrT3RkcXlleTUrY2NRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STM5YXdSSjhMVjRFa210Y0c3SmVsZ3NXNW9tQXpsQ0RJK2ZCWVAybXVGbzd3?=
 =?utf-8?B?WmxIY3FNWHY5NndUdGZYQjNDdVQvQ3JrMVhmcFYwWXZpUnNXWnFZTFlZSVRH?=
 =?utf-8?B?Qk4vdVZpWmo0aVVEcG02YVZtRnNIdWh3NW9hS1BOSFJSdTFMTW5Ud2xDU3Fv?=
 =?utf-8?B?N3B3UGdWaURNRG8zS2tyMDEzMjdYdW5KWXV5aU9NN1llTVd1aWl1a3VPcnFE?=
 =?utf-8?B?VTFtV0VwaENkcXJSUWlYdmdUQkxOa1dhU1JBNk9OWFBGcmFvbjUrVXJRSmEx?=
 =?utf-8?B?eGxVZ0taQ1FJTE9ES2toVFZERFZxbXZ3dXlrYktramdzcHBJUy95czNvM1I5?=
 =?utf-8?B?Q2pJL295YUhPdFBkKzZIMStNZnRUNU53aGw2dmY5QWdoNHBWcE5iY3JIMTFB?=
 =?utf-8?B?YTRvV05CTGxKd1RIOXVWZ1dORk9pRlV0VEJBYVZtOVEzaDJSaC9tNGxUSDFJ?=
 =?utf-8?B?eldtaTc1cjlRWGJGZGcwL2ovc2RRZDRVSjJsbGg1ZTRuYTcwcWNURVFHQXkr?=
 =?utf-8?B?ODhtdmVLQ245YnA0UW1jUFIrclBlOGZXWXVNQ1dFKzd2dEVCYnoyRkNYaTlY?=
 =?utf-8?B?eWxtRWREMzk0VFVtb3BmY3M3clJxbVJWeFNTdjRBMHlqVUlPalJCUHJvcXFT?=
 =?utf-8?B?Y2tCUTZxZm93Zmh4SVpUd3lHV1psMC9rVXlpZmJMZ3JyMW1KYk9nMUdvOTAz?=
 =?utf-8?B?WC82OVM3eThCTjZCVzRieTMwK1FCZEVoRFpUb1VhaVgwN3ZsZ002bFltb3ln?=
 =?utf-8?B?a1NEVmVNem1ZdWhoVGt4eENMTFJwZDBoWUdMZG1keFlvRzRaZTN6ZFpqb3hs?=
 =?utf-8?B?Y1RLODc4UzZWbDZpN2hwSGRTZFpTRGsyOWhtNmRNRENieS9rcTdzemNHTS8r?=
 =?utf-8?B?NmYydGVHRFYyTnJtOHFGYWdEWitaNUxNYURxTnU0VUdZc3crOS95NmpFdGVa?=
 =?utf-8?B?bjljUXRiaGpwckJEa3dFMTBTdXRpNDVpOUx5QUhpalJlbHQvbzZoNTB6NEdv?=
 =?utf-8?B?Zjc1Tmlub2Y1RWpvRkNyVllkSTlxUXd6SVFxU0VnQ3NleUVCQkVzU2RpVzhL?=
 =?utf-8?B?Y2FsSkxuaXhMZ1Qyay94aThaNm4vTXRxeWJBOFo4VUpQczR5dTk4OXdzSldh?=
 =?utf-8?B?ZUx1eWQzdExNTDNpNkg3c0lhN201bHNRTGpHc1pZVEZvcWhWdDh6dGp4SjVv?=
 =?utf-8?B?Sk00YjJhb1RveUp3NmN5NVllMVd1R2hTVzhyNE5DQVYzTHErbTAxQzkzOEk0?=
 =?utf-8?B?Uk9RRDVPTURhbjVDMzJsaDUwL0w4eC9vUk5kNVJEcGxlS09pNS9CYUxaaWVn?=
 =?utf-8?B?YmluU0lRenNWckVGZTNPdXBmcElZVjNxVktpWUdsOGdyZ1VJWkUxWjNDRjBM?=
 =?utf-8?B?VDRvVktKSmVXZ1VQbjhoL2V3YndieVhLVDVSRXRrakhJWXVhbUNkN1h5SEUv?=
 =?utf-8?B?M1Rsa25RYnA2KzlFSWJjK0owdFJQbGNjMWZZZW4rVWpnKyt1cVJnR1JybnhU?=
 =?utf-8?B?QTZheVBJTXdkUzkvVHM1ZzMyYi9YWmVzV1RSdE1EaDkvenhDRjBWcWNkUG55?=
 =?utf-8?B?SHNKQnFyQ1F3WVU4Si9oRkM4S0h1eFMwQ1VoWmFMQ0hISXhJQlNjb0tOU0pO?=
 =?utf-8?B?bTV3aWZ5SFZ6UXBzUFBpU2lJZWh6ckY4QXdmbThmd204TEI2ODc4K1Y0bFZ2?=
 =?utf-8?B?M2R5K2VJRituQW1sOEp4U1FxS0dZVExzUUUwUlAzcTR5bCtmdzlTUjBybDJq?=
 =?utf-8?B?cVFBd1RYNzdZRGZUWm9Kc0R5VmZNVUd0NG42bnVqRnB2bHVUYlI0WXVVQzZh?=
 =?utf-8?B?TzZkTVRMUVRKSTJkZXpubXQraEs0SlBIUlNZbTVKWVlMbGhtOW1LOVBPYXg3?=
 =?utf-8?B?NkpnazFORkFUSmhKdEVtM00vdmFJZWVjeUpGWExGeFpLZ3ZIazZ4Qkl5cFRG?=
 =?utf-8?B?RzlFUUhDQzJUNVF0ekJ1akNPS1VmQWhPZnVQT0JGMHhnVjVFYVRkQUp1ZUJm?=
 =?utf-8?B?dlE0K2Mxa3dSYXorR0ozUE01YjBwdS82M2s0Q1pGNkREdk5hWEpzZTRUQmRN?=
 =?utf-8?B?ckFmQkZyOE9za1dHMERGaFlPVi9IeG1KOXI0RjdPQ1FDMHhNR3hDTWxHMmVF?=
 =?utf-8?Q?HO3YyJIQrsmfc0ouuKu4kQJ8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ce898d-91e3-45b2-af9f-08dc841ad32f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 22:16:32.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxSKn1/fv4pI7B9AoIBWKzu+KsNN5giExLsbR2GqcLfSpaQop8Aw55SVSCJJq4j9BhXqhrYYENVg6FhCRqfGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

On 6/3/2024 2:27 PM, David Christensen wrote:
> 
> Current ionic devices only support 52 internal physical address
> lines. This is sufficient for x86_64 systems which have similar
> limitations but does not apply to all other architectures,
> notably IBM POWER (ppc64). To ensure that MSI/MSI-X vectors are
> not set outside the physical address limits of the NIC, set the
> no_64bit_msi value of the pci_dev structure during device probe.
> 
> Signed-off-by: David Christensen <drc@linux.ibm.com>
> ---
> v2: Limit change to ppc64 systems as suggested
> ---

Works for me, thanks!
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

>   drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 6ba8d4aca0a0..a7146d50f814 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -326,6 +326,11 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                  goto err_out;
>          }
> 
> +#ifdef CONFIG_PPC64
> +       /* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
> +       pdev->no_64bit_msi = 1;
> +#endif
> +
>          err = ionic_setup_one(ionic);
>          if (err)
>                  goto err_out;
> --
> 2.43.0
> 

