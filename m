Return-Path: <netdev+bounces-74564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D54861DF9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4370D2857FA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376EB159561;
	Fri, 23 Feb 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0SYEKYD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC4158D76
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720972; cv=fail; b=YibHWSFswns9WGrxaFmY3YQWFocCmaJ+f54dv62zAB6Etm7jPziqlIzTLOYfvS9O1H/oACNLaNRc1/5QJn6LGYvHg7hMk1VYmH+64+pK9LUqNN/tE3iQnZCibq+QvxlLKIQl4ixpnrC/sl8L1zz+NWaDXlHtBtStrRnO09Fxkdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720972; c=relaxed/simple;
	bh=8isdh4lzNNvR4oJ6GPDSLPo9KRaYpqMeiEp2ekmY4Xc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jY/VrPBtL33h8Zd4Nk4asNCzgTRcUt9oXokJXc5uUNSceL5gjtTATide8ZuwJugDjAYCdUtWaKzq45U6fElMkNzV2pqwxSCyDI6xT+yB0w3QbS84oFFbVVgD2PcVfnpmi+iNVcWA3UizJRzf9BKpV105KAod+H1xMAXahmnyWjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0SYEKYD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708720970; x=1740256970;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8isdh4lzNNvR4oJ6GPDSLPo9KRaYpqMeiEp2ekmY4Xc=;
  b=c0SYEKYDN2nvTMfpqLNMcMmLpq9eYLKCXSuyKiVMDvyZJR2fmUS0VxHN
   ++9kCp5EUC6lyNlmIORi+TdmmibIcdLSmzKjhvRh8yorovz121oCi3Eh2
   1bbv2BZy1amT/7nidRsH1iQQtQfD31L4skeoQUrzL4tShDA8IWoDPnElF
   OAa1TywyYJGNdoGuGYP1fONV7/bvZJ3B3UWbSCCQxZO31Ww9+cS3etg90
   x7kQll2nzPmCTJ6jo9Gshalb7LxO0noFx6qzag/Du8Ap4UD8C68zgyikK
   MzIl73AM9kziXpk3QPmry5opMJz8a7nz88AqZ6gprOeVSIFUPBwGDCD6/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="28492187"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="28492187"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="36791185"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 12:42:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:42:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:42:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 12:42:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:42:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae/b238FFKpwOWWU/cJuo+Lt3L4ZiJ0VjL0CDI7NeGAW9/MxXUmDaClwmsiREI05QbN+sWNTht8qbCccrr+pTcgnatk69cT2Q/nJkVpY4vxQO7207jXVdJO5jh5XHu80IHIQEMzwa/x1vtx+AIdYPc7Hsq0u/0MRHkVzlwuWzNscShCGSPg/b8mhNoy5vkgwQTd10iIpbKR+bUwdzpv2ajEjaIResHcI60S+K4Alyao2Rs+OCP/TMyCCmAxg+MrJiYnccdflZWrYQG5Q5lWB4PqB63AQapkTVahM+BCCYXBm+l968S8W4GZ9ismzKbFEeLBofw6X0DFyEigQ7CuLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpheXyhyUcTxvIiN7ANZhsgmGyoxdA1u6MK0075K3Mo=;
 b=bDXccVkNzZilQWpQkJtE00Z18D3DeXZAXpNygvsgASizQ6z7ytkRPFJAGwmxa3/Ao+E64giz9lwUsJZdmtHeUuqXN0ON1XvyKAMU6yUHDP8B0CCXcJs/fUhF+5p6HFw/RR7RoWWa6HAoBXcb32Vgf0IHj0H9B+8r0ZMXa1Rf7Ls0IBI3Bao+DkwmfYcemzIlUehu66qSU30ThiAh/UYkMEn6CAv/0JjZkmTY0jtygMOybg5ZnaAYXv3SMfLqqobO3fo8oGFmxtgbfBGlcWt0yjAOtSb0/W0ZvqiR3T4JjzqAV/WbRxptDQ1sTqglg+CLmaDaKcsy3QCwAXxjrBG+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 20:42:44 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%5]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 20:42:44 +0000
Message-ID: <246c7cef-91da-4a75-a29b-c2fca3954dd7@intel.com>
Date: Fri, 23 Feb 2024 12:42:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 3/3] eth: bnxt: support per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
	<michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-4-kuba@kernel.org>
 <7d89adc1-2d2d-4681-b6a8-166221639997@intel.com>
 <20240222173345.518d32fc@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240222173345.518d32fc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SJ0PR11MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a411cb-267c-43f2-add7-08dc34affcda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhO+VRYHgPoNsP1UqsSAAZL3yxCsYbA90Mxl7N/bHUwBvZ1lbqoF6hx2HAqBcsAcha2NfquqpQAuh1tVNvhS97TQA6rLjsBv9hVnaJoX1tuuICIe7vOu9eRL4HglfzvAu/ZJu2sPXDa4GKNocJDo9Vsad8+mpCNIeE8Suq9GGSa0L7wQWVAHN9/Q7vbl8fm6HtURu5X4hbOrfLTWbO5c3rDW+BNDzjw/2dvyIw4sr570WaKyKpQFy432US2SW+IS/G5RPQdtxai1vSMtTCT2QmmkNG6r5XRBzRNI7hl7DX/sRClWIyTH3xbuF7qUhmrt/Q1fwTgdeTdc/P0doh58SIDf/EppfylbItHZObs3Ei9w1KsT06jMbzusgt63kcEY8iDjh9KNP/qu4C9SYWp8EK3/ecvqUWuK6lGjsGUgbCs1d3S/RhHnWG4quHcWo4aSw9AL1yMzO1JOJot/sIDj/Xv0OU/p+lQ/2JM1SD6LV8eyuawbTa/DJphxeQxQc8fnL6XqsLXQMyrCllLPz4U7gMa3n9SAJjW/LFX61kdlR+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hDTHAyc2lmTUd4MWdLTTB5N21Zb2hjc0lWblhlbXFoYUZrek15bndGRFI4?=
 =?utf-8?B?aHVtRkRlbWJIVnQ0TEJYeHVJZm1sckpIKytwMWNKZE1yNlNoMlZZVTBseHdS?=
 =?utf-8?B?US9nK2RyUXlSS3VWZy9nd2h3bUZ1VDZ1dnNBcTc3aDNtM2ZqUjU2aWI1cUtG?=
 =?utf-8?B?UU1STFFxM1hJQzlzc0RUUmw4QWQ3OCtmcVozcDRBbWZzZDcvM1NJVEVHUlZp?=
 =?utf-8?B?ZFJabFJVMTRNUWtlZmNTR3N2V2lJRUlQRDFFU0lNc1gydGhYSU5YNUlpTFBC?=
 =?utf-8?B?UytWdlpPalAza3NValNLZUJjQ2g2RDNLVzdXZ21iSEtnVW9meHBLbTNLRUVy?=
 =?utf-8?B?WitqdHRhWFRpSENtYW1wZWl4THUzNEtkbHhyYkh6TURVRmQwb0o0NXhXeVM5?=
 =?utf-8?B?bVlHMTJ3akVBOFFwWjRBOG9Ha3orcGNMUWdOcjU4WjVuOGtXWUpaNG5jUUNz?=
 =?utf-8?B?djJ1SGhIeXZZdDZoNHlPZkRDVDdZbnZESUVOR0VBbDd4blBtY2xqV0NKaUdC?=
 =?utf-8?B?QTM5R3lxa3BkY0hPOVFxaUVXZmtkcjFWV1p6TDBCY0w5NytXYmFhemhNOE9K?=
 =?utf-8?B?aGFJckJSNDZFTFl5bjMvMmZiMTZtNk1pM0h6RVY1ZWNwRkowdzRCbjJ3REVl?=
 =?utf-8?B?eEk0YnFXaWMvYm9vV3dLYm5xcnBSVGthTXdWQ0VBc1lVeFI2K3VKTGdnNnZY?=
 =?utf-8?B?V2h6cW0zWkd2ajdoak9maUdMZUJUanpqKzQyT0t5aDlmN1BXSFB3UGhCMnVX?=
 =?utf-8?B?cUU2N2xkbk5BbVJtY0FLZ1YxNE91TnhBclZpdVc0TmlCSjFSeG9GOS8ydmpQ?=
 =?utf-8?B?N1l1K0Y0SW1WOU9MUzZGUTNyQ1grQUF4V1k1ZUVDSWw1RTA4djQrUHJoNnJ2?=
 =?utf-8?B?TjZWS1lOZUN4d1VzZEo4VWtoQlhXcTRFS3ozQmdtQUJCc0g4YkpqdXFhdDR6?=
 =?utf-8?B?RUloVGhaMTBuSXRPaXV4RW9jQkV4UEhvUm12RjR5ZkJ3VXFHVFR2dVRvSGlC?=
 =?utf-8?B?eUdTUGtqVXYvQWI3UHFOSUJQQ3lydEhyUmFWdUk2UTdtNHhyM09sak1KKzIz?=
 =?utf-8?B?TXVEMDNja0lQVjJlSkNsNzVoakFCdWhpZWJYRXZ2ZUhpTWpVTENMRWpDbGFu?=
 =?utf-8?B?bVFPbmdRenFUZnVaNzZhR29zamdJSGxzVnJUMkFWSjhEZHNZTnVUZkEzQ3pZ?=
 =?utf-8?B?eHk0SVdSN2RQOTJ0ZXhKUURXVDQ4QWtMbDNBRDNHZnJCcjcyZ28rTDhKUkNm?=
 =?utf-8?B?UElOMzBKdy9idlJWNzFlMDFVa0xobEEweHE2cTRDN3NhRi9Gd3Q5eCtqRjg0?=
 =?utf-8?B?ZTBUNkF2RU1NMHRBTVNLSzZGYnUra2ZUU3ljaFR5bHdsWFhkSVlEaFR0T3V5?=
 =?utf-8?B?Y3hMMlhLOEo1bE1xdTJUZlBqbWJjUVorM1N5OFVETENidHNDUGtkMnYwU3Z5?=
 =?utf-8?B?TkJsOHZwdjJYbFZlbjRvU3R4emlmdjhhY05TdmtqT25DK1pqeVNxeGo0Z05q?=
 =?utf-8?B?VXZnL3drUUdUNVdtOTJIb2pLc3pNSXNmRndMa2l0VUNwTUJ0ZDdPZy9iQ01Z?=
 =?utf-8?B?OGdwRnBGemdJN3R6eCtVY3RtVXR4eTIrZTNaYnMyOTdjWUpoWTZzUWZMWnMz?=
 =?utf-8?B?TTV6aHZMZmdxMXBtOXJDNFhDd0NFTjErRTcrR2FnYjd2dERoQ1E1a1czMkc4?=
 =?utf-8?B?QmFTWmpFVlQ0dmRyWWpGYTF2VFNkL1pKNGxEWURPYzdOMEZHVy9aVGVxaU1u?=
 =?utf-8?B?STYxVnFYUWJCUU5hN1NxNUlUR2NLaXQ5TmluR2NEdGdpQm12UW9ORHhacnFp?=
 =?utf-8?B?TlJwVlY2ampPK25BNE5HTFZPUHFEZTdPT3IzQVRzZFdiY2Y1d3V6KzhrKzJJ?=
 =?utf-8?B?T0IwNjhMRkZtcGFodGIzSitVSXhmZ2FNd3JHdkgrejRXMzlzeGtNRDFGZjBp?=
 =?utf-8?B?aTZ1eGxkbXVZeWdJSUxCS1IzZUNUdU0wd3c0cnlIWG41RW5rRzFLYnZxM0ty?=
 =?utf-8?B?OGNQdmUvUjBjeVJaam1HQWpjeWYwcko2d3QvekRyVjYwZG5CZ01oS1BQR0s4?=
 =?utf-8?B?VUpObHplRTBBeFNsUi9lU0ZvU0h2dzRnNnIxaldMSm5FZVlJR1QrZUEvS3Ru?=
 =?utf-8?B?Rm52c29tNmp3aWp3bGZ6NUgwTjJmVnVWb0pTQi90M2xlZEVKcEo4OEVzQXhC?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a411cb-267c-43f2-add7-08dc34affcda
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:42:44.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJG+XWbm0RLVPDpEx04GevPOc7QslnH645kANqZX7EMfn+NmoNn66gHIzpamPgj4yB4J+8nCcDIdf7BydBgntf5iCG0bn0LWMSjLkv0AHuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-OriginatorOrg: intel.com

On 2/22/2024 5:33 PM, Jakub Kicinski wrote:
> On Thu, 22 Feb 2024 16:29:15 -0800 Nambiar, Amritha wrote:
>> So, with projection: 0, the counters would remain unchanged after
>> reconfiguration ?
> 
> Yes, device level stats (projection 0) should maintain history across
> reconfig - some form of explicit ethtool --reset $ifc or devlink reload
> may reset them but not changing ring count, attaching XDP or alike.
> 
> Queue level stats (projection 1 or "queue") can be reset when queue is
> recreated, for some drivers doesn't matter but probably better if
> reconfigs reset them.
> 
> I mentioned this in a kdoc comment on struct netdev_stat_ops - the
> justification for different reset regimes is (1) to make driver
> implementations easier but also (2) because the main (only?) known use
> case for queue stats is to check if traffic is balanced. If we run with
> 4 queues and then bump to 8, and stats are not reset, the first 4 queues
> will have much higher counters. So it's hard to tell from a snapshot if
> traffic is balanced or not.

Okay, this makes sense to me and would be highly useful IMO to have the 
queue level stats reset on reconfigs, since ethtool -S doesn't already 
do that.

