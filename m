Return-Path: <netdev+bounces-259811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLCAAWYPmWmjPgMAu9opvQ
	(envelope-from <netdev+bounces-259811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:50:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9D16BC7D
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8683300898E
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B032470D;
	Sat, 21 Feb 2026 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI5EBjhg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5C31B122
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771638626; cv=fail; b=RXhexKcSljNOHzeRXv2WUMwLAYhUJaP1X+GfDlNi3Pgv+vJI2rXweXJJdXu7mas4ZDCorGpWvRd2hY+Jfta3Ipi/fddjT99OoSiolDzB02s/db3i9QuN0gQxnMh8evWbObLUdUAMWexwBN+77dDxrg297ty/GdCIgI0YVHy/ucQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771638626; c=relaxed/simple;
	bh=VHBDblEmB1JUJfBUlwtdcJjOyDCEo/KsjLiztuxm+qA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YfkFFEj21a0vzSsPGgWahuxg4KYKNKZPC9bdxM4Eo29xodxUYpwDN0kyYC/zxWDox/6FH42l4+XIUnlP1vTfVP5pu5/7I0fYUJANvwp5/6ICSH57G9oASNPGIn+gMpoHC/bSTho/oAieyZAP4HlYJ1mmi0bWVIavKrlDbESZewc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI5EBjhg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771638622; x=1803174622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VHBDblEmB1JUJfBUlwtdcJjOyDCEo/KsjLiztuxm+qA=;
  b=OI5EBjhgZcH8FYXvr8JLgGujTrAhH6xGRNu7kZXrqSAKNmTymldwyQeQ
   YpR3WkyzOWLJiuwyQHR/XbTORQv4W8KSHYtgVigDs3QV0wLZSAv06zDth
   lOR+mZ39jVkpKYqVKpKkXrjFLHoyKIo8e+7YPSa32RJ4MDZFctQ3buipU
   tA3XrIs0HQsTPgvs//XgTPgKKqZUAoHojksEnMSzTd6fgDApOtiYmrLRn
   wg2i0YLMWgiQy9/8C+JfMZm5iUJvu0aPdsndXRnBZj4GMgMn6s5DSnPHG
   DCyclgT5lnlQQ9EJp7AC7PIZ3J74R8Z7FPLTYlbLTQBZCyu5vWq5VU9DL
   Q==;
X-CSE-ConnectionGUID: fFWA+Jy4Q8uQx1K+pGSf8Q==
X-CSE-MsgGUID: h5RVt2sWSY290Nv1MzhM8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72715202"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72715202"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 17:50:22 -0800
X-CSE-ConnectionGUID: JO32p1i4SrOW4Q4dTWyrxQ==
X-CSE-MsgGUID: 4wPR9NXvQS68TLgedwCFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="252706199"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 17:50:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 17:50:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 17:50:21 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 17:50:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrIYhu7nq3Exkkc540aZgRjLGHx4XvlkkUfHbOyWBKrmyoeQN/WF4G05cGgdJrMm84TE53znCWe85gOhyKYW1xt/ZwCgBIOAHQjnGnqU/Hy7gp6ObVQuJnMpmEnsMZlAjcRebE6J406UbIkeXlo2PXmSZm2NZbLOIusWYhiVLrSQM6o4YcA0SISdb7Nzjzgc+8qZLRKqAEaYydOth/tqgKWQfC0lfCvmGHJAFk8LfVBXbkIA0WQFOqZuqPBCDtVlQOSGGUI59S/G/qimIllF2f2sL1oh5evEFIVYvxJFK5gNxHot8KIIe5yv+mDGe5ChVrXdO20jFw/aT01ovvP8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZmCYsLxm7LHN4b0EbRsmWrQ4Tg08pg5Fb8gMF1bidE=;
 b=SN40tJ3/vH8dc/NqZeziYoM1I56L/cZnB64CEFDxaZjkfSAMJbdnmatcWML2VnS6M3CZ+IJKF4utYHdhunh4dWAmS0xPsLs0lmeFrr8+hNNbVgg9aN8Q6OnthzgndroDhGho27+NFdY3lHQjQM9TIwmQhCMrvCZY1z3R6OpJ/Vmz3vom04KYyYjuRq5JcGPSV8969XU4ltspSdW67epZzNcEs8CgqkM9/nDfaAikrQOkwf9r3qvLv00vCW2khV+vHpABUSz+AZVA4AwpPcTIa5vMbryUlMk3mOY32WkYThwHVdlKEYZxmlhrz8MwUxYzI6gBFabTtid7q8AfRUhjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by SA3PR11MB9487.namprd11.prod.outlook.com (2603:10b6:806:47e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Sat, 21 Feb
 2026 01:50:20 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%6]) with mapi id 15.20.9632.015; Sat, 21 Feb 2026
 01:50:19 +0000
Message-ID: <81f91e12-599b-49e7-9299-cfecb994cb6f@intel.com>
Date: Fri, 20 Feb 2026 17:50:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 iwl-net] ice: fix potential NULL pointer deref in error
 path of ice_set_ringparam()
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Kohei Enju <kohei@enjuk.jp>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alice Michael <alice.michael@intel.com>, "Fijalkowski,
 Maciej" <maciej.fijalkowski@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
References: <20260220184031.60113-1-kohei@enjuk.jp>
 <IA3PR11MB89864DB144A3D8990E6512D5E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <b57460ab-d523-4e2b-ada3-4d338dea6701@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <b57460ab-d523-4e2b-ada3-4d338dea6701@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::8) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|SA3PR11MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 307e7d9b-915d-4527-1566-08de70eb9181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzRBMGlWbkVYY3NtVk9wREpvOTQ5N3ZwWFEvRytWMzJpdHhFODl3VDBYem5Q?=
 =?utf-8?B?UjBqcWNqZmZ0dTBQMzdta0xhTkRiWnJ2cEFwYmpJNkRzeHAvM1FOTUYwSmJY?=
 =?utf-8?B?N1lDKzdTbnJSdTg3ZGVsR0l5dVlQcDVhWVY5OVI0aVk1a3liR3NwMmhmYlZP?=
 =?utf-8?B?R0RRNkt0NE5TczMwN3YydHpkeXBHQUNjTUZOckY5UXllNG5CR0tzZU4vV08x?=
 =?utf-8?B?dFFvaXM0NWNCM2FDdlYxUldadytpQ0luSmpPU1ZCZk1LdEdZL0ZWWTV1bHh4?=
 =?utf-8?B?TTlGMXFWZG5wT1ZIRkVKbEZEL0NHb2VUc200ZzcxNi82UTNSUDR6RkdpTXND?=
 =?utf-8?B?T1JtelR1TWdhbktxOEdHZW9GRjZ2am9RbkxNaFZDdWZYV2ZmL2VTTmx5cnAv?=
 =?utf-8?B?MWJOYVN4WGJXMVFZRlFoWGxNRi9Eck5qYzliNW5vZlhFbFpvTXRxQzdib05n?=
 =?utf-8?B?cmpvc3ZkWlU4cXlMNXI2R0F3SVBsY0cvaER4SjgzOGwzenlWdGp1djVUTDQ0?=
 =?utf-8?B?VldaVlJWRTllQ3hxQjJ5dFNsQlZYR3NWUmg1cWphS0JUSkVwdUdhMEJQWWx0?=
 =?utf-8?B?THUxT3lIQTVwUi84YkJ5cENYQlRuNDZoRGdIeWxBUGZrUHpxTnBvejJrZjdP?=
 =?utf-8?B?b3BmRjNGUG51eEZIOGs2L0pvblc3R1YxSlVaa0NRWWdRZXAwOXdnSkJQczRX?=
 =?utf-8?B?TVRiaVovUFExTmdvc0NveFA0YlU1ZHVSbElzTHl1aWUzYldPcVdKNm5PR3I4?=
 =?utf-8?B?RlhnQVVVNCtYWitZS1lWZko4R0hPcEhqdDhKMTk5MVdOYXNxZ1dhQWxxdkJQ?=
 =?utf-8?B?NjZKQ1hiRDN6N0w5dG0wVERuQ2NQVTFiRnlHV0I5MEdPNEYzSWFGWjA3NGN2?=
 =?utf-8?B?NEVTelZwdUVWYUVYZzZ1YWU5ZTlrdklWWCtTa3Ird2pVcXpFOFk5LzNoNkln?=
 =?utf-8?B?ZjZhY2ZoNThvQ0k5Vm9MdTY1QnRYc1BjRFY0eUgxd21zQ2Nva2JYQkFLbmZJ?=
 =?utf-8?B?TUJhdHFOMW1aalk3VmlmSDg4UjcvSWQ5UG5acWFTdDBJeW11ZVM5bFNpME5H?=
 =?utf-8?B?ZjhQK1BKd2JGbTM5SU92V2xWTGZtMjcrbEtaZ1lETUpEcU41Y2ZmK1BCZ2Rn?=
 =?utf-8?B?R2JCMnh2elhaMk01M2RWcU8rVFBsdUdmSnV2Q2pmVnhmM2dkUU5nUWV4dDg2?=
 =?utf-8?B?Y2lPdE1YSHB6aDFTdE1EV05rUWxGNWZYQndCQXk4OTBScFhDS3VPZTFWdm04?=
 =?utf-8?B?RHArc1g0T0tnbncxdGFsMG11TUR2ZCtSeGpRMnY4YlBxUWtoQnFwcjhZdjRW?=
 =?utf-8?B?N0ZoNW5WSGhiMzJ4ZmkvQjNlcnBPUGpwdDgzTzR5WXFpeUl4Y0hQdFFoWG9V?=
 =?utf-8?B?cEIySkIxVXRvUEFVOWZtZklpbHBrRWl1NnMxMmJyWXYwcTVRZmJST1plS2M1?=
 =?utf-8?B?SU9ja3o0UHIrOHJaT0l0SVR3UGFBVm52RmlTQTh4c0liM0dsZ3Y2NG54S1Fh?=
 =?utf-8?B?dko0eDJCU0JvQ3ByRFpDZVFtVTU0NmxDMStMeEVCa2lwRnI4QmtJWUhGNXM1?=
 =?utf-8?B?cnpRcUtyMGlmWmtuSW5IQk00UGxxdGtVR21ybHljRzJSV2NpeHRLd1EvVEVB?=
 =?utf-8?B?NW8xMC9DdXNtQUpOZ2NxdmZRclNvOHhIcFFleWI5STYzRDdyck9CR3lTVkFM?=
 =?utf-8?B?NGFiRU5paVRXd2h4WVM3ZTFKeXBPclN1MFowZUVqKzFGa2VCY21XS0xHV1Nt?=
 =?utf-8?B?ZS81b3poUnZ3QS9HWEMyQ3JoUm0xUWVoUmZpcHFHdUJoYWY0QjJyRmhFWE53?=
 =?utf-8?B?aEZVeUlHNGxuRWw1REVBcVAxVTZvR050dWtvdTF6Z2U3SXdBcFBKOG9TYVZK?=
 =?utf-8?B?UFZybXZOd3cxUFVGeE9rR1RWSWRmWnpUUkp0NVhycnlUdm5TelRUL1Znakls?=
 =?utf-8?B?NU1sUDlJZEZXR0lyd2RZVXkrV2lTOUhUNEhmVEJmempmcGwxdDZ6cnZkVndK?=
 =?utf-8?B?alYyNVlWSXRlck1ZSzRnRjZleG5GUUlrQk8xd3JJSU4zbEx2YmhURVN1cWk5?=
 =?utf-8?B?R3N6eC9UV2NaZXZrWncvdVA1WU5OU2Z2aEEyTkgyOE1POE8rbXZmWTNtZmJx?=
 =?utf-8?Q?CkPs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlhYmtsVXZkNkx1RjV6WG14NVNBRFB5aUphOUtLRjhMZENCNFBlRmljdFdh?=
 =?utf-8?B?Qnh0ZkpiL3F4VGFib0xwNjNCNjNXSzNzcURHSHN1WUtSZ1V3QWhKbTZEME1x?=
 =?utf-8?B?OXpYTGR0dDQxdVZwRnNRWncwRGVWSStLcmYvYzhibjJHaGlZM25nVitieEtv?=
 =?utf-8?B?ajk2OXpnN2VjbUZqMkw0OHZuT21CMVM5bmV4dVMveVpRRmtuMzZ6M21XKzM0?=
 =?utf-8?B?bkNpS1VMbitoeEVaRTRxWGdUL242eHltVmFHcGhSVElYejVicVdTVGg2bW1k?=
 =?utf-8?B?c1BCQ3lGd0cvZmphUnIyZ1pJSmRPKzFEbWs3VTdqSC9UYmxsTjF3UHpaNWJo?=
 =?utf-8?B?cmplRkV1dnlORXoyQU1vUElhUE9pNkMrRWMvMHF6THJjNTBnSzl5LzJaZWFS?=
 =?utf-8?B?K21UUENjaFNsQ3ZIbTZtSi9VSklrOXdFa0VQanhITDduZkdHTnZZMlZtV0ln?=
 =?utf-8?B?eTJPbFhhOXJPc05BQ3IraWVzQUEza3VFVDYrckdUZ3BGVVRPOHBjeTFuNUdP?=
 =?utf-8?B?QTlsSWplWDc1UVRZVEp6VmlwemNZbzlJY1BWcFJBRnpmSWRock8xS1F2cnBC?=
 =?utf-8?B?WDZCTVJqYU1FTFNBL0xBRDdVZFBFTDBybWxYTEQzUWlCSW1jbmtqUE51OWNH?=
 =?utf-8?B?ZTdFb3NwZVBiL3liZGFxckpLeHBnQlM1RnhTWW95ZkdCNjdWNnp5TWYza1lj?=
 =?utf-8?B?WVAyR3BmQVJaWXpiYnVZUWRVOUNNTndPYzFQUmI5M3NiUzRzUm1GdlVIZVdH?=
 =?utf-8?B?S0RrL2J3Qlhsai8xSUxjTFdKYzZQeHNrSUM5ZkVJeGZudU9PTUVDMjEvb0My?=
 =?utf-8?B?SXhXZG8zUXYzOUVQbHU5eDM2cFlKQnRxcXllTEZrMFFNZk5FazdPQlhTUGp2?=
 =?utf-8?B?NlRmbUs2bG1CTmNvUWxleGhqK0tBeUczM1U5L0tYR2hYMlhJb1NBZjlCdXkz?=
 =?utf-8?B?Nnd0dk9KMUI2Vm9sb3gzc0RiK2I4ZUl0UUFmSWU4aDExbXpsR2Z1UHVGTlFP?=
 =?utf-8?B?M3NmQSttQ2pmOUg3ZWZwdVVETjRwaHIzSFpFb1Zldjl5cVJUYlREL3htZEVt?=
 =?utf-8?B?b1RFNU9lZG1xMG9FRTE2cHZwdHBqbjNJVHVsZmIxUlpCUG5DekgrbzJwMnFM?=
 =?utf-8?B?ZTY4ZGpMNCtPK1g1Z3UyZDhwaWM2dHpFTkZSZFo5WjVqN2FBbXdsR2UwM0lv?=
 =?utf-8?B?YzdiSXZhbHlXRVo3VzFSSHptZ1REUnNjNS9mQUU2SGx2MklRZU5QOEFDT21M?=
 =?utf-8?B?QWlhZHU4WllsazY4ZTNaWFEzSC8xTjB3UTN6anQrWllLeVkvSVNvK1Exeis1?=
 =?utf-8?B?ayt0TUorY0Jta2s2ZjRwcGJnanluemVUU0ZEVHVWUFNwaWpKZWlTYWpCZVVa?=
 =?utf-8?B?d0MvblBWdThrSGgrZ04zT0RtV1lUa09LaHhXb0x4WFJBT3A2MW9qazhJUFA4?=
 =?utf-8?B?WTZBUkg3MWczV2xDN0tqVGF3UlREYXBUMHJvQlcwVytVMWNPL2kzcUw2b2h6?=
 =?utf-8?B?akJVaGlFV1gvRFlkeFEyaW84VmtHUE1UWlhWakI3UzlnMUhwNFhuVzd3NmFt?=
 =?utf-8?B?Y0s3b241LzhrUUtnVDFSejJtWVRYRnR2bWljdWRpOS9GNERVT2o1THN1Si9G?=
 =?utf-8?B?bHV4SS9JMGpRSFNaT3RSVDJUbk9KcHJBb1IzVWxQV1MzeWVzWHo1SDQwQno2?=
 =?utf-8?B?c0xKUHF2NG5qSmZHeXVENXNRR203VkhFM1FkYm1IQWw2cjJvbVkxSktHbTFH?=
 =?utf-8?B?RXRMVXpENTM0YVh1ZUllbDE3L0tFQW9mZTAreEpqWjZNSkozS2k2YVd3RDRB?=
 =?utf-8?B?N05BcGxsM0JwK2pXc3hQMWpnYUtBRjdVWjdPY3VyNy9FRkI4RVlDUS9OZ0Ji?=
 =?utf-8?B?TVRLUEhZRWxaNEFkbCtRZG9kTSt5TmZYWW5tbTI5c1ludHlzZFlXaFBLZWJW?=
 =?utf-8?B?dGxkRjBVRWZhTEs5NmdVYkJGVUxJRWNZeU1HSS95blZPY0NRNEU0emU5ZWRK?=
 =?utf-8?B?V25RRklHU1BzTG8rQ2pIczM2RnVkME9aWkdOREx4aC9nQlowZ1YxeEhremYr?=
 =?utf-8?B?WVQrbWlzSHJlaHpGRzQ4eHMvbmtVOEtwWFhBOXdDbVNBK0VYd0MwQVpsWUVN?=
 =?utf-8?B?YzFLYnlJK3N2dk5qc3BkeGJSTUtPQ2NtYTZpUmw3dXRxVGRsWE9uTWM0Rm1l?=
 =?utf-8?B?VFROMEJNemRrNUpZVUxzN0lPNi9mYW1KNURVVlNQd094amVyS0VlUEMvWkho?=
 =?utf-8?B?U2lVQXRRcEJPTmR5VmhxclQ1aUx6cnU2R0c3VVo5aU9GWFdGdFVjVktKc0Ix?=
 =?utf-8?B?aDBzK1R1U2QvUHhOdUQ3Umo1RHdxSHFJd0lKVVpnOGN1ckZSVDdnUUZlRDZM?=
 =?utf-8?Q?KEkn3C9iQ8jn5Kww=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 307e7d9b-915d-4527-1566-08de70eb9181
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 01:50:19.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eD1h/cYMgPdErncyMYXhPVdO7jy1sqz4rs8lfK1K8WPNlHa7na51aK3ZaKJvQJbU70+1MBx40SCST03F3yIYCpVVU2bUGqc2wVBxbQe2rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9487
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259811-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8DB9D16BC7D
X-Rspamd-Action: no action



On 2/20/2026 4:35 PM, Greenwalt, Paul wrote:
> 
> 
> On 2/20/2026 12:04 PM, Loktionov, Aleksandr wrote:

...

> Also, per Alex's comment, please target 'net'.

Since this is for an Intel driver, iwl-net is the correct target.

Also, as was responded, this works off changes that are only on 
net-queue at the moment.

https://lore.kernel.org/intel-wired-lan/20260220204526.7514-1-kohei@enjuk.jp/

Thanks,
Tony

