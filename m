Return-Path: <netdev+bounces-297325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kYFrM+aOKGoKGQMAu9opvQ
	(envelope-from <netdev+bounces-297325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:08:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D101466473D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:08:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Xy8cTl0E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297325-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297325-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C3B0302B90B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986684C6F0E;
	Tue,  9 Jun 2026 22:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E30421F0D;
	Tue,  9 Jun 2026 22:07:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042866; cv=fail; b=ty+McpjYrsbnfz9ikqYusoxxzunR97tMsyuUezAQK8hR82umOU9TuW9iflKxt21t6lVfPKHrwGh54ZFBaqeFik0FEzNIBR6xBPIE/BLKPbj9XY4mi39ifQ/wdRtU94YHxzrYBfmw9L9hLNHWnIDq1eYdCxXcXTBtcjbK/+THp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042866; c=relaxed/simple;
	bh=QHC/RZZZ1pjq/A1jWWQ3GT6X3ToyIWmk9lg0BnANB8E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lgF2FnuakoYWWV2q/TjOhv9f1YFrqACFCFJGCATRpUqO/iJe1INHAWBtyFvjT1YhTXQwIOBkw3p8D9njsdsBNl93CnolV9x9leBqoiVvin3DV4jgNIsTylsqktrWBbvfNwnzTN739HTZEOLt+X5VVWM/MIhA3DR9Us97PEP3KRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy8cTl0E; arc=fail smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781042864; x=1812578864;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QHC/RZZZ1pjq/A1jWWQ3GT6X3ToyIWmk9lg0BnANB8E=;
  b=Xy8cTl0EGhEiaxzZ9d3VtjtnKa5UFNnlSh+6z43dVChDu7e4RTApkkuc
   b7kHZVOIWwbERVqTsQzjYl1QOO9gpwvj/TLZdHvqeHlueFP52w5vRkQSd
   w4OfvF0YooYpWluB5EBq4ZxtGo89ofB6RI0mQvIT5BYK/QTBedRDQy+R3
   sUqdq2laeWlGfHUe0cz5YynP6/RamOH7jUukzgHCSHwvRXUTqDjPemOYJ
   97jlbcgrHiLTzEVQd9lH+Yyq/weV6WPmlWdsLzn7HabpESn1LD+5csys1
   7zUUOTuSzUcgcluh9/etV7VhaCBF42wAHel7l5j+Mnk7UWZ0lITg2IleP
   w==;
X-CSE-ConnectionGUID: xndoit0YR2GEUasYH1Tcnw==
X-CSE-MsgGUID: z2vE4fDmRKG9zQ3SKOsFtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99398194"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99398194"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 15:07:43 -0700
X-CSE-ConnectionGUID: RN6QRyinT42q/tbQG4nrrQ==
X-CSE-MsgGUID: NkOTA+MaReOggm1B2WnGIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="247838379"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 15:07:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 15:07:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 15:07:42 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 15:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB61L0h0xEYmx4aM3eX8z0L3zvacK9LOc9cqRvc8pNbSshKKL/sepnqXHfZAoA5zDXgfPJy5Lew9GLlwZUwDHj3gWikYU0WU40yxwfpSJRo7QjlbSG7MR3i/xmIiJTTe6cWWOk8elRlkXiuV4biabNuCQSIA39pw0hXQlVB7p+V0ELYxuMcs3sJp178xm2VYNNQQ4zL/AzWsI12x4Q4q/ylufpe+Y9v+dp92sJwl5uV+P2Vo7jlEtxIJvvpGRhckvRF7oPEBBGcNUTz3e1vtPcneXRcYF1s8jxf2tIxH15htu/s6eqCnjvvQFHJrcHww3t+jBU53vzATw4rjOurU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rif3U0pXWv7g6kKf9i72N5SGdr7I0k4o5s9oDgqIHno=;
 b=Fij8GAMi3/1ylteC4bRcnlZjM/lTwbG1d9dOOvNaPYM8ksbK5g3BdG4JIOXPNejD5O/tXjGM6m4XWgIcZPvtUb08R8afUcoEKY/Wh7JpjQaf7NEH/5YPEVRbFNRcYdDW00TWsLIuZBEex5bFNHnQOaIe+zbmTroZeZgawreuMfXDZgLGxXYuFZUOXjtpcsQLdotcjVKg9hvqrJvrxVuYCnX1pmu3c66CYle4scuvtJmo4xsay/8Nnc2j2hsY4vGLkwCtkqs95XnBGyx0z4c8lg4kATOZq8NTFZe095k1XTRQeS+M6xo8Z3celHehl19+uWHUtBUU3GAIyTstc/9sPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS4PPF64C459891.namprd11.prod.outlook.com (2603:10b6:f:fc02::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 22:07:40 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 22:07:40 +0000
Message-ID: <53959e5a-1e9c-482f-ad4a-595e576c5ba5@intel.com>
Date: Tue, 9 Jun 2026 15:07:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibm: emac: mal: fix potential system hang in
 mal_remove()
To: Rosen Penev <rosenp@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik
	<jeff@garzik.org>, Roland Dreier <rdreier@cisco.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20260603230821.5619-1-rosenp@gmail.com>
 <f49d5ac6-ef78-4530-a420-d94e612581aa@intel.com>
 <CAKxU2N8oh03r2-zJhbOXF0Qqx7RzNSX=zq+i6Ld1c9YXJqDfKQ@mail.gmail.com>
 <20260608173638.74da73fe@kernel.org>
 <4575ae96-2084-4f96-8260-5025fd1ea7f5@intel.com>
 <CAKxU2N-0RnWV_BxQMX=ofcoH947L3icyKqReO7rf_4Q8tO2CSA@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAKxU2N-0RnWV_BxQMX=ofcoH947L3icyKqReO7rf_4Q8tO2CSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS4PPF64C459891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a54d1d6-19c3-4c5b-5697-08dec67385a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: /1oer6ZXsq8rp0HA/aZAG2qe5E90kJbAHY0bIXReH8IdQFCLBytX6i77Y/F+9rEw/uFAKE/SQ2HpkSkSpWvcXqzQA8N0AA9yK6waTXH9j+QwmLTqY0Tje09zB2Ko8QYBYy0j5MjbO2uPtysUaKZm2mieEL0EOWJGaGDc18tJRii8lwWUkqJWWMjvUaCzAXWYC0tzOIoyV6MdHiBdW2kSyS7OHvXmI1NlU3oufkeouJHHRpPXKx7Gav4L7uz3zcY0jy7ayKmfRMxcd/9U+SnhEcBWqbRV5SOBFbHFr2GjbPOQ7ULfBRMu/Z2b1OXakTyMm2vMOnmJzRVWs2FeKBESnXLeNiqzzagjRobT+A3YV1SY86i8FQngg0jNNSAhQQAnH08ZOeEiWDNcs83yxTWc6zBGxtGdUtabaNprdeAkYkvv+peIZH2YIUeWz4uHnDyCZ8wJ+NQPHpbWcGnRGD81nFK5fnJZuWeextELtOZoMDa6226qYxywAL+xxY08fqiS865GT0MzD2bHj0SQOUnmt6bL3ywc2b31T3Uty4Bz8T0YtFJxkNkcVTv/oQqavHzFW4Auc9uQpcyuqFlvxpeVpoGkWtxk6lfAaPcp855U2TAaQ1Vtp7OrJyS6fckkGXxOlQEWD3r2Lppd1oBcLJK5MPo7xbLOQ03a+MIDHvsrjwEYAVEHFnxZ36KDFD82Yy1ZWhEpOnaFb59ZO3WvwZzBfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFBc2szWTdYN2gyVDcrK3VTRkdEamhtNnorR3RWMzRJVlFlSDNVdGsxTDdK?=
 =?utf-8?B?TjZGVmV1ZjlFUUNLRVFKYmw0QmZrNk5nY01ZYXpMa0IvaE5HWjhEMmRnNXg5?=
 =?utf-8?B?T3plZlU0eHBPL0hXMXk4aE5KZjN5a05HbGp5VnVkWEZFUHVOclJ4Zm5kclNZ?=
 =?utf-8?B?ZzVMQUkzM0l6MTNhR3lYM05wMTZLS0VBRXlqeFlBQkxhbVFCZ1VkMzVBa0lL?=
 =?utf-8?B?T0pJSFZ1LzhVZWFkb1RuS1MzeWRCd3hIY1o3MFFKUDdZYnBxYnR0K25CN016?=
 =?utf-8?B?dkU0TU9yYXZOVlgwSUEvTVpWL3E3eC91SFNJSjNJbzA5OEIwQ1J2azMxYngv?=
 =?utf-8?B?WjVQUkozcDdEQlRYZlE0dHFUMitUUmZuNkFhUW5hWGNwUlExMUdCTk1zeG5R?=
 =?utf-8?B?R3J1TjllQkdGZE9SY2xYQWlRazl4VjJJb0FxcUc1YTZGRGZHaDliZzB2UlB0?=
 =?utf-8?B?Rm1qZlpkNm1uWVRmN0J2cDRkNEJsWW0ycXVFNXNwQ3dlYmxYVWJXRXM3bHcy?=
 =?utf-8?B?ZGFKcHk2YnRUd200VHIwbFBIeVN6S2JFUGV2UDhDQUc0OUxadUdGbTlXYXZx?=
 =?utf-8?B?L1k5bEVRUFpzM29qa1RxRUg5Q0xVT2dWM1gzVllZaXg0NHd4Mit3SmNPc3lM?=
 =?utf-8?B?clFadC9GZWJPNDVlcllwTitycFk0WkhHdEp0MEFFb3RmSHQvUnhYR2trZ3B0?=
 =?utf-8?B?OEx6L3BJMW9JdWJTUUdjYzN2K0tBOEl6Y3dpNmZrMFJxSUtRdFEzM2liNjR2?=
 =?utf-8?B?czF1NXVWdE5UT1lZQ2dCc2R2dXE5d0ZDTk1vaHVOY1ZEVVVpNHNrZlhwNkF6?=
 =?utf-8?B?OFJuQ3ZpcWxkMjhDdk9qNGFYK3Mxa0xqWTFDOE1HSElJSnVxaDBwR1pNd2xO?=
 =?utf-8?B?dVpLdkhtcnNZSEw1Y1Znd2tIcnIvU1B5RFhyNUozUWoxdCtLTkplVUxvM2x4?=
 =?utf-8?B?YmdiLy9ZMXhLMU9Jd004b3JZTzgzQnV2TkJuVnVUZnUrWnNpOGVQNUFhTkJ3?=
 =?utf-8?B?LytEVTFISk1aYit6SHpMOHpTSHlQR1ZvQ0QzSHEraUcxcGl6VzJzTTNPZEls?=
 =?utf-8?B?ZmROTXE1dDBGREJBazY2TG9yOTBjYXlkQUNaZ3hYNVN2NFhKbnMrZ2dpNHI0?=
 =?utf-8?B?RGQ0WU1EalJibkU3V1gwdXRyYTh5TDYzY2lPcnk5cC9MTGVkZE05OEFQZ3pp?=
 =?utf-8?B?eDVOMURTdUtHM0VoYXZVcnlIUytRWWVTTklZSG82T3VxZGt4RlZZc21JbURo?=
 =?utf-8?B?bm9rcjVRYUxCYWRKekdYcGVxRXR0WlVSVVpsQnljZ3FyUXVOYkd0aUZDYlR0?=
 =?utf-8?B?ekR2ajBCbGpzMkZML1cvNWZEb2MzZnJ6Y3lnZTdtS0dCRVlEYlNJZmRFM1NF?=
 =?utf-8?B?RXJaN1hubndnenhYYyt1WWFyOFhnSFhwdy9wdnJyME40TUNRb3J6S0lkRG5E?=
 =?utf-8?B?UWJaNkNkS1VpY3c3NVBQSjJhaWJQVnVkb3hGYjRIRHJMYkdENWlHcGRuVTlx?=
 =?utf-8?B?aDRwNFNVMzRYR0MzSnRNTkpvaFdoYlE2QVFuUlV6ZVJ1alR6ekYwWVd3ZUMv?=
 =?utf-8?B?aGpxT3o0NnZ2aTZObzcvbVB0NU1Oam9mTUljcVROcHhka0I3akJaSlJmeFFT?=
 =?utf-8?B?UnJXWXBmRm1pdTlOeGNyZjlkZ3dnWDNMR2c3eUcvQkZnNTlVQ2RhT3hnQU9j?=
 =?utf-8?B?VXZDam50aDU4NnpWWk4zL1ZNK05lbnJNWEFQWkZ6VmpVWUdESmgwSE0wNVlG?=
 =?utf-8?B?Wjg5U21OYjlhU0lUcUVUWVJFNklueHNENkdUMXFTM2ZvUXpnRXl1L3N3enoy?=
 =?utf-8?B?eTF0Q1VSTXdUSndaV2pLNVFGcTF6VWsycElrcVg3aHhqWjI3SUdWRndJZ2J3?=
 =?utf-8?B?NzhaUldxMW5FWmVXSENidFRuUVBkajJ1YkNnOUEzWk55bGFHcmU0NmZmR05x?=
 =?utf-8?B?Z3M1MHhPSjVqcFdUYzZOZWZiNDVLVTg0V0ZmZ1FRb0orVUVLZ3JhazhRMGJ2?=
 =?utf-8?B?RHJEZnBvYm1pdnVVbUhwemZLU3ZhZHdBc0pjNVE1K3BHdHV1NXBsWTdFR1F1?=
 =?utf-8?B?WWdvTU5JN01iR09zRmdONnhqckI4U2s1cEU4OFNWY3J2NTNDMUJybkJzQlhj?=
 =?utf-8?B?YmVmUUJKM2tZR0c2U1IzL0YzT2VpRFpXVGN4eFFFclFCZDF1SGpML2FZVExM?=
 =?utf-8?B?a1dDQi9BcjVjSXZERHR0b09iRjNwc25UTGhXUU5NUmlYeThuMDdUVFhPMEZ1?=
 =?utf-8?B?bkJ2M1FtME14Yk5sdjREVFlkZXhNZG5oUnlxSmNRdmNHNmNSaG1QK1ZqM1Ay?=
 =?utf-8?B?WmgxYjZmb3BUOE1JQ3RDOHNaa0RpNWQvSGN3R0dEcVNLY0pEVUI5dz09?=
X-Exchange-RoutingPolicyChecked: XSIVu26uedCkwmm2KD2cwWQ+6+gyxnbti6xqG/1xiEMCOgc3YWv11ppwFBNoDIHWSAWnUIKUedD+YtBrHxMfurU4Bn7iUT/kasQcQbNfVSZYF6oxvY99vT4vVS8LSrNvL0qNsYNtJjfgZTWRhV39EPhkNrwtgwbhQ9sPpFBlydTZ+kMBE74fnr7vMxKF3PdeuGXY7YdlUK/DmwTFAF1EE2MLQocIJLdmpOGTIwBSH6qHRZXYwVV6efnkZf1LRu8yreqCkkoTXq/U+CMq7fCV5fOSRJFcMuYGq+ucS/FZz15VibDreRooOzy7QPDp3et9APdxs78VWuhZ2GoXSCB5Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a54d1d6-19c3-4c5b-5697-08dec67385a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 22:07:40.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V5ji/cKQ4ayPd3NmIYtg7CAjS1KQIykTrkCstL70Dm6LTYyyfZR6qL1ef2B5F7hnPHobBlJeTwKtqNp923Pv77j2PaKNI3y9Jlx93+vqJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF64C459891
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297325-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D101466473D

On 6/8/2026 6:51 PM, Rosen Penev wrote:
> On Mon, Jun 8, 2026 at 6:14 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> On 6/8/2026 5:36 PM, Jakub Kicinski wrote:
>>> On Thu, 4 Jun 2026 16:03:43 -0700 Rosen Penev wrote:
>>>>>> -     if (!list_empty(&mal->list))
>>>>>> +     if (!list_empty(&mal->list)) {
>>>>>> +             napi_disable(&mal->napi);
>>>>>>               /* This is *very* bad */
>>>>>>               WARN(1, KERN_EMERG
>>>>>>                      "mal%d: commac list is not empty on remove!\n",
>>>>>>                      mal->index);
>>>>>
>>>>> This one doesn't make sense to me. The list_empty check does a WARN()
>>>>> indicating that this is not supposed to happen.
>>>>>
>>>>> This implies that list_empty should be true, otherwise we'd see a WARN
>>>>> every time mal_remove is called.
>>>>>
>>>>> But in that case, we'd have been calling napi_disable incorrectly in
>>>>> most cases where it was previously unsafe according to your claim.
>>>>>
>>>>> At best, this list_empty check is the wrong way to tell if the napi is
>>>>> disabled, at worst, this whole change is pointless.
>>>> I asked the AI. It doesn't agree:
>>>
>>> FTR I agree with Jake, the patch seems to indicate bigger structural
>>> issues. Then again I don't want to encourage the stream of patches
>>> to this driver so let me just apply this..
>>
>> I don't see how applying this discourages the stream of patches?
>> Wouldn't that be encouraging?
>>
>> Or I guess the patch "does" fix something (an extra call to
>> napi_disable) and you don't want to encourage a raff of future changes
>> to try and fix the overall structural issues? I guess that makes sense.
>>
>> I still don't follow how this fixes
> I don't either. But runtime testing shows it to be an improvement.
> 

If you have runtime testing to back this up, then please ignore my
objections :)

I think I'd be happier with just the removal of napi_disable from
mal_remove(), and not trying to modify the list_empty WARN block, but
thats only because it does seem obvious that the existing napi_disable
shouldn't be called there (as it was called when the last item was
removed from mal->list).

> Anyway, it seems various subsystem maintainers want me to fix
> pre-existing issues reported by sashiko.
> 
> I also got this feedback previously:
> https://lore.kernel.org/netdev/20260107185605.7932173f@kernel.org/

