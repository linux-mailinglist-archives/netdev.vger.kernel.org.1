Return-Path: <netdev+bounces-163630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA7A2B12C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DAF188BA4F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4FC1DFD9C;
	Thu,  6 Feb 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="xiJCT3ry"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020118.outbound.protection.outlook.com [52.101.85.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1A1A3176;
	Thu,  6 Feb 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866492; cv=fail; b=uAdOom4JJDCjfuchgUgfk13/ptQrhe0dqBXLstRRNMWyXEDbUk2BqtIjo7xYJ0p5jihC50cNcJCGrEXXNl2ec/pYz1FQYZORve8fZw4qtg0V27+dDiUXnLvqn/GQwfAbgY+wF43CWEyCp4p1KEmdktAnNmBl3CnUOnF7yfAZvsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866492; c=relaxed/simple;
	bh=WJMYaGAimmasVua/xCJTDw6PA00s6dk2rscUlID+WxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JQzDo2GXtNprIrRePdBje13S0gDcrD+RaPBZ8Cgx7LH3Ua9s+FKKK9KTlHRoP3lVLPnmPqdsqn+vvvCFsSj4c2j8RfnxcNHcgWcQe9RFsERNptPgM1WkO+zr7GJX45CA33Ihi6dA1gV6vayTMtl4Y36Z0m0xnVrCED8rVLOI+dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=xiJCT3ry reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.85.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3Jlq7Ar1/AiXC+yKdTwAQ5TBibrZkjZ3e4GVv6L+WdOyxTpjcVUT0BSxaRCiqdnDpYjSwlgZ4GJR4Is8H9VGKlJsh+DYENWQ7pvY1jUuqMb6F2qt7mFO+FziNRDWLQ7GULJbHOJoJuzkVtDFxT1TDL8tl+EYbDwf1AaZc1UbVosEvd94XSqWhVXrgN1sd7wKSLYODNYVisrr2pN6aFfNdD8ogLSdWPuJMOd+iJUIAEqt/9jmXImn7L+LzPoZ5GLZBb7AyvHOH1LdF0tAOt6QS1GkEABjeEaUXBV0LHJukeO5+WgtllAoavA207rEhcdE4WLD5MR2MPzhP07qMMUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5NQom22poo03dqro0z8n5PvqKnQwzVeFdkwmrh2jps=;
 b=Wrx3h+hD/LYMl6OwS2P4uIZdG3aB/wES8ZVLkICmCl4Suu5bpJJoAElVQDREngmHAxeelI+kXbeoLpaHt6YiRZQlCNmVMs1GoWW3JnaLr04RtiUBd/u5mpWdon9laTvw/pCML2vw8Yq7q+fhp0GyisrlJB5nSRpwwF809Zz2g32cSUW6DSyWuJMMez5/vHeGtL6nClMNeNeUM50a+7ijzhRXcWrkMEYTZwWxEQaOoH/bH1qf/y8EUaqDOgzZOxh7oFcJ9L2gsA1/sDrfEUvHZrbyjojnAiPj/7dy5Ke7yf6p+RV7BbIwtiwrOxChWaoUz+pYcSnllelacNrq8qHrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5NQom22poo03dqro0z8n5PvqKnQwzVeFdkwmrh2jps=;
 b=xiJCT3rygci7+nEFmcUrqRNSWJs4D5T+Ne+9hH8P4I0d3CaDwl7vTeLOn5RsqXkBeLP0oHT6kTm0eTi0TgBLtjycY0inAuUTKDvuR0epJ78qHWmsnNnwPVJ3EVtf4dhhaDzCWfhr5ewXGEAtJGsf6SAAqy1nCWoztwKiyfVJ8ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from MW4PR01MB6163.prod.exchangelabs.com (2603:10b6:303:71::9) by
 SA6PR01MB9045.prod.exchangelabs.com (2603:10b6:806:42c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.6; Thu, 6 Feb 2025 18:28:08 +0000
Received: from MW4PR01MB6163.prod.exchangelabs.com
 ([fe80::c474:10df:672a:55d7]) by MW4PR01MB6163.prod.exchangelabs.com
 ([fe80::c474:10df:672a:55d7%6]) with mapi id 15.20.8422.008; Thu, 6 Feb 2025
 18:28:07 +0000
Message-ID: <b2ab6aa8-c7c7-44c1-9490-178101f9d00e@amperemail.onmicrosoft.com>
Date: Thu, 6 Feb 2025 13:28:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250205183244.340197-1-admiyo@os.amperecomputing.com>
 <20250205183244.340197-2-admiyo@os.amperecomputing.com>
 <99629576779509c98782464df15fa77e658089e8.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <99629576779509c98782464df15fa77e658089e8.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To MW4PR01MB6163.prod.exchangelabs.com
 (2603:10b6:303:71::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6163:EE_|SA6PR01MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d56cec4-6ae7-4d0c-770e-08dd46dc00c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXNJTEx6b0U4R1E0WHRla1VWbXR4UUdrdTJadlY3QnlMT1dLZDU0Zlh3blVx?=
 =?utf-8?B?SkxLSDJoQnZFWTl6aytsYkEvRzRSaGZkaVE1eURnMW5oeUJLK0R0TnR3Yjdq?=
 =?utf-8?B?MlJyejBCdUFyWnJ6clA3RjhqL3JveW55RHF2TXJ2TGZwUEtrdGV4TER5akQ3?=
 =?utf-8?B?OTFqaWdlWUE3eVFURVRyMXA5MGRLT0kwUzNRdU03RUJGTGhPdFVZYlNNWGdG?=
 =?utf-8?B?KzZCSUhQalIxUkxrMlVFOHhpeUNyMEtsRGQ3dnBQVlJrdWhSTWVGZFBYb0F6?=
 =?utf-8?B?cmRicC8vaCs0bnJWL1EydTE3dXlGcmUxbHlXcFVKT1FIZzE0YnRwd2JicnhS?=
 =?utf-8?B?SUZmYlFzMXJGc28wbVR5ajU5OHBOSk8xZVV6L2xYWUlldFpXY3JYb3MvUHRa?=
 =?utf-8?B?ME45blR1cmdtbmVyOUNVSUlXelg2RUx5Sm9qbnpWcE52R3VuenRRbys0ekVY?=
 =?utf-8?B?MzBPWVlWcGZDNTVJL3k0YzJEQXNxZ2VocGl3bEpSakppT0VKcW5Mb2luZnpk?=
 =?utf-8?B?MmxvQzJ4aWVsT1hqdmw1SjJndURFRlNWVjJPc1p2RGVLbEJyYVZkVTZ1bWVq?=
 =?utf-8?B?Njcyek84TW9wVTRkQm1ub1J3aFdWQVkxK0lKWEdDdXdVVUNkN3prcTk1bFVl?=
 =?utf-8?B?TkNzak1EbGpPQWFTRXo2Q2NzTThXVGE2Nzl3UXZpeFdBaEY0bGxHaWVRd0NC?=
 =?utf-8?B?UlJtRDkvazJKWnN3Z3NuVUhSTGhhNmpqZ1Mzak9yUFlTRWRlQXpyOWNoSnVi?=
 =?utf-8?B?ZnhiaE1OMXgwdWYzWE16VHY5blVFb2N6bjRZRlRVNlpyNG5OOElUTm00blZR?=
 =?utf-8?B?cjBKYjQrek5FN0xOU2phYTB4N3Z3MDR2Uk9kMCtEZGRnNXNaOWtXR3UxUHhY?=
 =?utf-8?B?eFczU0hpOFRqSXNqNUp5L0NTQzZieUVtek9IMUNtUndVcjI0ZEZ6QzlGV0ln?=
 =?utf-8?B?SGRHSmw1Y0FuZUFkRHBZU3g2MWc2OVNZVDFvVEpodHFsUGR4cjRUcmplbGox?=
 =?utf-8?B?V3paRSt6UTZuZHF2enRJbUZ0ZExDaGJRalhRenZBamY0dlJWM0hZMndvVElW?=
 =?utf-8?B?VFlkN05VQWx6RnUzYTE3RVFoTWV2eFdGQ2J1Y0IxNCtzYjZjcy9lU0xIZ09Q?=
 =?utf-8?B?bytMeEZGeUY4K1hFTjkzU0JiVVpMQ2JhblA2czNWRnloZThseE9UVGFDUUEx?=
 =?utf-8?B?bXlwK2x4cTN0bDBiRVhRVHUzTk5uWFh5WVRGQ25VaVhlamxrMkEvalE0ZThQ?=
 =?utf-8?B?Y0pxS1lMSWdycUhwZGdEQ0NFZzFtYkQxanE5WXdPOWFkZk5xeExGNjJTbTJi?=
 =?utf-8?B?ek44bnV4b3M5RUI5dEl6QU5wNmppamJXalQyRENkazFFQnNSbDduZ1ZYQlBZ?=
 =?utf-8?B?bTdwWXJEMlJ6bm9PaGYzMVY4eHB6cGVkT2dzSzc3dUY4N21mc2pwaEpoYVJ0?=
 =?utf-8?B?RzlEQk5pSTNrQm9oOFVGNXZHVDl0SkVjTzF4MWkwaDBoUDVhQUtBSDRSZ09a?=
 =?utf-8?B?QktYVnNWL3lERTE5Q2NJTlFzOTIzQzZGcjkrblZ5R3VPMCtsVmpncmJRUEdP?=
 =?utf-8?B?Q3ZnRTU4NXp6djF5RlRhc1N3NzVuREJoOStIMHpJbXZ5blFFOVZuZngzQ01i?=
 =?utf-8?B?ZVFPLzRwM1BwUCtwRkZlTER6TjVFeWt0R01RVUhoaGhmYU51QlB4Qy9OZmJy?=
 =?utf-8?B?UkEwR0hPNFJTM3dWRm1YeGExblRqZkY1NlBuc1pva0U1aktpZFRYM3YxYjU4?=
 =?utf-8?B?M1ZkS2xXN3h4eDNtN2duTU9kN1A0WVhFVDVtYktSMWJQUzRFVVY4M0pxV21N?=
 =?utf-8?B?b0l1amI2d2JkN1pTUFcwUFVqMjZOdGxLSHlKanBCZjI1WmZ1cHRwNjVUeEN6?=
 =?utf-8?Q?jKZ08x1RaifbB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6163.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEt3N2ZLK2ZCQXJxM04ycnNiVFZUQndaRlNlYXVTSkJ6SnBTOGV2VzhWT1M1?=
 =?utf-8?B?VFJzb0FGVldwSCt0ckcxZFhBNlc5UHdDVmlIVE5ZSVJjNllsUTF5QWc5NFRy?=
 =?utf-8?B?ejlDTDMvZEcyU1VoN3JQOElBVTFrc2ZXSkdpRnh0OXJOYVNZSFd0cDRhRUln?=
 =?utf-8?B?T1ptSWc3YStjWUlXSFEzNzBhYWF5YlFmQTl2QS9TTE9FVjBORjdFU1pLM2pB?=
 =?utf-8?B?RElCTjNNb0hkNFJQQVJuTnFlNnhyL0djOTd6Z0h4dnMxUGNXVjhkNVBISUtw?=
 =?utf-8?B?VDFLNDFlcHkxRWZsZmhvUW12Y05MYjVERS9MZm9DZ3dTTVlRUVJwS0F2SUNC?=
 =?utf-8?B?bExia2s4NTM5VkhrSGp4MmI0bmxuTm5yU0M4eEQ0d0kxbGo1cGlFc1pQRG8r?=
 =?utf-8?B?TThlTWxNaGtSWHpabFJvWkZLL09XSG44bjZpbTB0K1M0SDgrOC8zRjZqNFl1?=
 =?utf-8?B?QlhLZ2Y0MFBCbVVjMXQrOGJYWkhjVHpVanQ0amIveC85bFlzSkU5NlZGaWFI?=
 =?utf-8?B?Z21FUEFMa0k4dEs4SElaRktFK3ZRZTJla1d3ZEU3b0txa2V2SHVydk5kU003?=
 =?utf-8?B?RldVZy9Ickg3eGlwMUV4cXRTWktIczlCT095MzdhNkZWcURqNFhhdGh1VExy?=
 =?utf-8?B?TGZhaHVzczVsMlVzd2xjUi96L24rL0FGNDR6NmZOQlRtQW4yQm5jTDJ0NFpT?=
 =?utf-8?B?aUxGSTlGOFN1N09LSEQ4VzhHM3RVNjRnRUVVNzhOLzF2NnRFWHBDWnN1NXQ1?=
 =?utf-8?B?MVhKNHdGTmp1WS93dWJlUGFUcEhOY25KNmlwbE1IdlpLVGlqNDdXTWdBUm5O?=
 =?utf-8?B?c1B2UDE5NXo2VytqWllxSDY5Rnl5WkhjTjhHZDQxL0ZVV2tUYXFZRXBvL2tx?=
 =?utf-8?B?M08xQ21lL0lzRlRVNHlKN0NrbWx2cG9NQkYzUEpXRk1YYTJiZ3ZvSnlNT3Q5?=
 =?utf-8?B?OC84enFJZ3dOc01HSG9CMEJLRDAvMFNpemQvZU90Y1pUTktRcE51U005THd1?=
 =?utf-8?B?cTZXQnBWVjAvTUFKQlNMRG5hWkxmQWNvRy95N2ozeE5ORmt0VC9oeG9VSzJL?=
 =?utf-8?B?cjh1Q2NxNVhqcWlQa2dORlVheHE3SVhDa3VWa1d4TGxzQmp4L3R2TFVLWENZ?=
 =?utf-8?B?cEZ0My9VbC93WURRVDhvcjNhRXY3V2F4eXZpbkt2NkpmUnJkdXhpaWtzN3lM?=
 =?utf-8?B?eVl6T2Q1VXk3NWEvTnVBVjhqTWk3YjBob29PN3U0anpUbWRMQ2IrVkZ2THlQ?=
 =?utf-8?B?Y0wzdzgwNDVqcHRhNjgydUcvOUd2Vlh2cXlpVWZHbStDYVhubDR1ZW14clRR?=
 =?utf-8?B?Q2tQYThzYVBVNGc4a1dGdXpUYVh4MW52SXA2aWdJOVNVekdrNWRUUDFaR3JV?=
 =?utf-8?B?ay9mWUpVeHRhWGtRWWRmendac1hsR2RncWdUY2JoZFloYVJENkM0ZG1GRDFK?=
 =?utf-8?B?bDhnWENaNXNXblBoWWRtdnJLQVlrc0lrWDBGelB6WVVvU3lISlBScGxXK2lq?=
 =?utf-8?B?Z0hDUHozeWNBZnpkQ0E3bUZwUDEwSmxSQTlaM1BZNTJnQnhpcjJMTjkxNWdF?=
 =?utf-8?B?NDA3OXBZenRPdU51TVM2OXF6NnNzd1g5V3JJUUtzRmJGdmdodkxuYy85aUNq?=
 =?utf-8?B?Z1ZiSXc5d2lhb1I5eUdzZGRXbEVIK0FaNThwY3oxZmRiYXB5MEthZDgwTmZx?=
 =?utf-8?B?Z3oxajV0d2MzL1RxeHl6NDkza0wyc05HaU9YMEd5bWpnTDgyQnZmbTZWMzhI?=
 =?utf-8?B?aHFnaTZmQW03bTBycEUxckZpVWFyc2JZSGlUeU9hWWhpYnAySFIzMkxPTWtR?=
 =?utf-8?B?UExQT2s2K1pCaXRMaWNVMnFzVkJHN2VIR1MyTWt6a09XV1Irb3pieXV0MzIv?=
 =?utf-8?B?N0ZpcGZ0ZFZyWjZaNGxvUVFPOWZMNnFJVzA4L2V0cjRKcVVFS0ZaajNUcUhN?=
 =?utf-8?B?WG9SMzhqdDBEbVgrSXBWTis2TjNOYlp6TjN0d1oycTNNckJ4RmFmMWJyb25H?=
 =?utf-8?B?WWg1QWRLOWlnV2xJSEFGeXFZOFhDNDVEUXdTYkk0L1FCUzFDd3NlNHZMOEoy?=
 =?utf-8?B?TnZyL212UzRTUmJtZXZSbVUydXRMWW5rMFZuY3ZkeGlPZWdPRlZxUmVKZDdS?=
 =?utf-8?B?ZUVRUmhpdXdlZHJJSGhZZDBJMDNXNzdONk56VmFieGQ1Z2YyL3FhMnNzZ2Zw?=
 =?utf-8?B?SzlQTFVmYVl1MUVVREZYREVaRk0yekV4TmJieTFCTTZnT0pseGYwbFVQamFl?=
 =?utf-8?Q?qcnPQArC2Ir7P7tT/04EnzhPb2YTuEZVIofvn5nL3A=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d56cec4-6ae7-4d0c-770e-08dd46dc00c1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6163.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:28:07.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNk0VxVnBCHIVLxdSFZBe7vUp9xRUi6Sga8LD2AlkObXaJwa5cfaLhWDF5KxypwbR+yi+uKjA4cdhVYMLgVIUcKmi58d/ojBZ8tyVyZUJLySpgn/dUp8Fl33WkDt9pgj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB9045

Is that your only concern with this patch?  I think as the MCTP 
maintainer, your opinion is going to weigh heavily on whether this gets 
merged or not.  I am more than willing to spin up a new version of this 
but want to avoid unnecessary churn.

What else would need to happen in order for this to get ACKed at this point?


On 2/6/25 02:04, Jeremy Kerr wrote:
> Hi Adam,
>
> One minor note below if you end up re-rolling for other reasons, but
> regardless of that:
>
> Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
>
>> +       /* ndev needs to be freed before the iomemory (mapped above) gets
>> +        * unmapped,  devm resources get freed in reverse to the order they
>> +        * are added.
>> +        */
>> +       rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
>> +       if (rc)
>> +               goto cleanup_netdev;
>> +       return  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> You seem to have a trigger-happy spacebar; there is another double-space
> creeping in here, after the 'return'.
>
> Cheers,
>
>
> Jeremy

