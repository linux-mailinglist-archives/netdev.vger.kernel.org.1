Return-Path: <netdev+bounces-223940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9CB7D9FD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0002189596C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CD832CF6C;
	Wed, 17 Sep 2025 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MC897I1f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E029249F9;
	Wed, 17 Sep 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103469; cv=fail; b=ZKkMqLlshmCC8ArLRsGKVxPrXdG3+0c9Bnznx6gMRK8VVGI1y9ZxNUOHo37/6t5hjdAZdqRUfJOY36nJw80LLCaqYkzb/yVzj9Ajviwvnz7tQ6PrIQHZFoGYdjIeWL+4cnKDb/1/X/6VaaQwSd9vgbjP4sVbpbgYE7Ab2ZGJ0pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103469; c=relaxed/simple;
	bh=/UJ+Xfz/R4svQRXKXSyLPqWUPgZ+luVYleEFJksXstQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JpqzS9hICVxJGKR6qFYCjfV/t2PkhoiMtxX7nTzgL0rLYGkOQGh0yco5f0ZZK6tDX/0f/aJzEt67nP6dcihXJPsko+hdxSnm2WXDRLKsFI6PUKP8yt5VGJ75UBRboj35mB3bpG0otA0mSg2yLw1BCVsYBPKJFVjBPj8rKhck5Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MC897I1f; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758103465; x=1789639465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/UJ+Xfz/R4svQRXKXSyLPqWUPgZ+luVYleEFJksXstQ=;
  b=MC897I1fNDcdJrxUoXaWdSpoE85X6i/xXtUd9ILTLh4QQ4tQtA0HoH23
   5oAsochhbfVUxxppW2nbay/8/NgM+h3tkPCtD+4dRBpccpVrPYdei/NbY
   V72LZG1kKLXeGnZ/O5saRv7GV/0+JMInbQphh4NbPXkYxjqkZDq2119R8
   ZJaudSf4ZWrnJe839mP2lyusn9fi8D5OgjUGDuL+EC8sPhO/ysQyLFLWi
   vqff4Z+Bti6tRaeH9tIXjnpAD1R9PKgCGK6ZQ06dsQFWJIESu7j/jPRP8
   YfzNgwjMCuC8gVpIYB85yUpLt4+lru6LW3+KeUtJQvEyazJkMTHv27k6A
   A==;
X-CSE-ConnectionGUID: XaWEBxPTRIuCvRg9h79TKg==
X-CSE-MsgGUID: R9pZzbByRQ+mDD730DLwJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60273194"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60273194"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 03:04:24 -0700
X-CSE-ConnectionGUID: K0uAJOMQQr+c8VENhOlHgw==
X-CSE-MsgGUID: 4zVJffZ4Q2m1KnUbVTxvew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174310226"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 03:04:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 03:04:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 03:04:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 03:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuXZA43VWh7c6udpFl6GJuSmD68C0tcoPJWe087djpeBmHnkBwsIRbToM58HiHGCA6Hfknk5eIOKOwM7Ny0Eq/BWefzQ4cpWk9hzOwuwG8CULhozzd3NeRoT81yhUQfB6Y+bE3gqyhmsQ8PkEeLxSvIT75lEV3/I+5BMpQ5i3+ziyi6U4eUg/OV1T+uGLSJQL0VwxDfTsY+HsdFJUmTf8FtXgHtUaZn8TSDg/DoyW6oFVFRNlWxaezN8sSz8hGI1o+63CQAx0Z2+oazaegupigy5X3VwigIdAbZm6NshXNa2pAHntkWoU6YtxHqNICDrxDFSz4Vh2iL31gf44rTD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UJ+Xfz/R4svQRXKXSyLPqWUPgZ+luVYleEFJksXstQ=;
 b=idUBueMx5Jit9bnszMeTT/PP8LVl0Sxj/dcNLi+X1F2nltzgGuLTf76Z5B4MbzQBOA76A9RUcKl+FTpaD96y10ThdIJWp8diEwgMq8XV65jW2z7N6GoRaxcQ7aOmAXzgzB3EiLbRvmNPg9JgiieKsnyVBDtkqHjje8n4uWfnaiW2XE8UtpWpzHRmVUqqhefYo7F6EEuH9Qwm+G+ObZ+vTsL1rfFFI8NWEOmAuT0fitrtDrNtiA1dgzWHOMvrolbawfGP00moI+yD6BZMho4vJTm+H161qdyC66Koz0tQRYu0LGHdRo8RBSPTL9FmYk2Jau8DmAMPSX7TmmBzyZE+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 10:04:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 10:04:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Brandeburg, Jesse"
	<jbrandeburg@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>, "Hariprasad
 Kelam" <hkelam@marvell.com>, Simon Horman <horms@kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jbrandeburg@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: refactor to use
 helpers
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: refactor to use
 helpers
Thread-Index: AQHcJz6OS5uqOepTXECB8nKlwmCshrSXJjfg
Date: Wed, 17 Sep 2025 10:04:16 +0000
Message-ID: <IA3PR11MB89869AEFCB17E8B25E6C0345E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
 <20250916-resend-jbrandeb-ice-standard-stats-v4-5-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-5-ec198614c738@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB8058:EE_
x-ms-office365-filtering-correlation-id: a10a3337-3286-49cf-f57e-08ddf5d1900b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?YVVvYVhlV3RSSlB1TWRrd09Ua3ZmNWwvQk53d2d4dWNJNVZ6SmhseTR2Ungx?=
 =?utf-8?B?aTg3MTlETnc1U2hqcFZ5Ukw3UHkrTy9KdGJGakY3Q3RiTWVBYURPS3BxQndO?=
 =?utf-8?B?ZVowREs1SGhHdk9naXdkb2ZZdVd4anl2bmxGNXdzS1dsOWQ0c3lORXNMb3JW?=
 =?utf-8?B?Q01YVmFMS1pyMDJONnFheng4cm91c0VsdkV1cWpTeTJSWjAwYlpNWnlnQ2I3?=
 =?utf-8?B?MFFGbDlQYkhaS2xuTlRzS1ZMT1E4T0JMZzJDRk5MV2VMaTJ3dHFldTY1ZjJt?=
 =?utf-8?B?QjRvdmdIT1NKNDZnQ1Fmdi9zNG1lTUZHNitmSHN0bjlBKzM3ZGxXNGkzSmt5?=
 =?utf-8?B?RDNkNHd1aytIWWhNc2w1Zm9rK2tNSVhSRVpQakY2MEVmWEV4bTQzTDA4OFRX?=
 =?utf-8?B?ZzFqeW1KUHBRTHFnaE10aDZJNjN2ekc0S3RMckJNVFBWaHVmdGYzcW83ZWxy?=
 =?utf-8?B?eHg1TVlqQlprNVlaNWREN1pnZ0swTjNtZ3lDcDJkeFVPbFJ2Y3pZamMrMEpF?=
 =?utf-8?B?ajBWU0svRmRWbXFBeUNocE4yd01hQmFVZmo4b0tSeHBNaEVyZ3lEWkwrMWRo?=
 =?utf-8?B?NC9JaTBiNHdORlhUd1JibGxVZDhHS0M3ZUN3cURkTTFhK2NwZHpGcDlKZ2lH?=
 =?utf-8?B?ZFhTTEpCRGZ6MW5ERHhEbDIwdEFjUDJMTzRTVEdzSkZ6bHlVU1dqWnVvbUlZ?=
 =?utf-8?B?QjNBenRpeDNvQ1BiWWZUYlpQeThFYk93VGtjMkhMWnRGN1Q4WHdMcGx3Z1I0?=
 =?utf-8?B?VEtYSWVvRnZlYlVCeDNhTDB0ZlhQWTRnTzllYzZrUGUzVjN0bTNNUXd3b1U5?=
 =?utf-8?B?Z0NWV1NGdEtpYzVBL2JQMDRIcjJrcmpIL3hGeWFFeXNpOW9tWFI0ZER2Nzho?=
 =?utf-8?B?Q1F2UDNJbUpyT0hUWXpidERyR3VMNVN4dWdvekNyNU82WTF1M09xNjVScjRG?=
 =?utf-8?B?NUxmbEk5Qk9RSWlNakNTdG5XMjFMdXNTRU1maTJhUGEzb3RHRHJLYnBldTd0?=
 =?utf-8?B?dzFPbG1vUDRZYU05aHUyeXcyRjF3U0NmVkJmZ0YzSzEvb08rTmNyTVdvQ1RC?=
 =?utf-8?B?QktpMnFKVDFaQWRJQUdCaG1lRDZWMnEwNzVnMXJGbEYvUXBTbitKd0FoZWN1?=
 =?utf-8?B?cHU2YzROUlIrSTgwQzZ2Mk9pQWhpaEVNZHNDa2crVW1FQXFlSVVXS2tWS25T?=
 =?utf-8?B?eVl6MEdnUXNVWkhTc3R4SVhvTlNkek1BQWZVWWordjlpd3pOSFZBMVNWdHRL?=
 =?utf-8?B?WE1hOUxPMzFqR0dIMVdqMjRHQUdJODdWb3ZCYVYvMTl0TzUxdjAxa1d2SGph?=
 =?utf-8?B?Q01SRDkzM0E5UjNvbjM0eFpER3MrMm5MM0RHZVpYYlpiMy9BUTYwSkN3S05V?=
 =?utf-8?B?QjVwNUVCMXJ4RXRxRDhIVWdyejFrQk4vUEZ5Z1BjaTVRTUNHUitFZ290Yndy?=
 =?utf-8?B?ZlVPQnQvMHFBYTVjQTE2NkNGQkI0YmF4SnBsb1hwazV4MU1QVDhBcFJ5WVJs?=
 =?utf-8?B?WE1tMm90ZjZPazVwN2dkblJsUllXcUNSMDU3WWszaGNwTkhCeTE4K2N3ZmZk?=
 =?utf-8?B?QnhaNGFwZ3YzN3p4Z3AvTDg2cjM4UVJFY3JKSGx5Z3RzcHFEb3oxa0l4am1k?=
 =?utf-8?B?aGlWWGNtb1J1R0toQVJtbFNRNDVpS01NQm9QYnF4YW02UGdlSlp0YzJrZE03?=
 =?utf-8?B?TlNad1NQVjJLSU9jRWtlblBVVVluQlRjR1RhbDYxaWpMVDdNcm4yWURyRzVW?=
 =?utf-8?B?ek9kNmtaVWtxOVBXaXJCTE52Z2tCd3JMN2VibHpldmhNU2ZqeUpJdTd3YVl5?=
 =?utf-8?B?OC9pL1Fsa2ZEY1ZURXA3UW43UXp1N1U0b2JjdFNjUmpuT1ZlNWRBTHhDbkMr?=
 =?utf-8?B?ZWI3bG1VWUVsbkJsSlBOcThzVTM0a2w3dVA3bUlvaENVVEhKVGVzQkdFRElz?=
 =?utf-8?B?WGFuNGVGUHo5YU5XQjVvM0g0M3N5QmZKeTVmanFwSlZsOVpXQzdwU1FQVW8z?=
 =?utf-8?Q?tAvFPAhmx26QbVEVZYPHHQ00kSKIvs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGcrTGk3elFrNll0SHdUVVhFd2M2bWZEQk1TenhpWTg4MUJGTEtDT2F4bTV4?=
 =?utf-8?B?MU1IemFWazdPRmdwdUtrSmNIS0R3Q091TEwxYTVwQlRMUm5ZNDFEenU1QitQ?=
 =?utf-8?B?bVRUL2wreGFrbkk1NDJTYWFHMmdhaWkxaE1lckxKam5XZUsrd3JKbjNmeW5u?=
 =?utf-8?B?MnZxVXB5UEFBZ1hZMHBncWRnZUNZc1AyanNGOTlTb3cxQlJzZ1RVc28wdXMy?=
 =?utf-8?B?WURRMXd2Y054NmFoUE9PNDAxYklKRjRqUkgyRFlBYWljV2RaMi90ZnA4dDdT?=
 =?utf-8?B?aWZZZkdaWnlEQ0JQdEhhSm43NEhlcVduVmxaQ2xWQlh6ZnIxRElpUmZ6bEpq?=
 =?utf-8?B?SDhWRWJEZkx3amMzTGRPU1pWSmNkblZPTFo0c0VtTjJ0RGVOUVE5RzJhMkpZ?=
 =?utf-8?B?T3FLUFlIZHpHdEhidVFBWXJGeGhINFFkWFpSd3h0Sk1seFY3aHpSMXk1cGR5?=
 =?utf-8?B?ZTNvbkhJNUFET3I5cWRVRVRBVUVBb1VFZEZUVmtNelVpTDUvdGZxd000Ymxm?=
 =?utf-8?B?MDV2KzZzTUR4Y0FJd2cwUksvcUdQcGNDc2Nzd3ZlY3R6SEZGQ0ZzU3g2WXZO?=
 =?utf-8?B?NG1YWUVISVJmdGw4Y0FvOG5YZVUrSGl1blAzSnB6b0xXQTJaR1M5ZXYrQVkw?=
 =?utf-8?B?Z3lKWGlPVCtzRkVDSDRsc2JlNk9seVpXNEhaaDh0blNwUktLblI5NGIvM3h6?=
 =?utf-8?B?UmozbTdiNmJjMXZUQ3FCRnlaeGVtWGNVdVZrdGNOa0ViVGFZQTJ0UHBGNVBW?=
 =?utf-8?B?VTZIZDVWeXVrbk03b2FUb0twZGtzS3doM0JlWXRCT2NqT3VlOHBZMEwra0hr?=
 =?utf-8?B?ODJEbWducU1Ib0x6MGl1RXdqNWhLT3pCaXJ1Z3NSRjNLWjVzbGd6NU1nWWpm?=
 =?utf-8?B?OUJvZGZkVzZmSWFwK3ExWFNOcHQraGVyd1B4bVp3eGNjT0x3cllNUEF1akwr?=
 =?utf-8?B?b3JKU0lJdTZXQ0hrdHVyR2ZWcnZaWmhUZ29vVmswcGxHVlJhUE9yMEx3eFcv?=
 =?utf-8?B?TjdoRmZjM0J3RXBBQks2ZjZXcWxQQ3hGM0FJU0xkOUNtdDArejZST0crYit2?=
 =?utf-8?B?SnozVlRqVGthTzJ2bVN3T0ZxN3Z4cmc1LzVFT0U2QktOQlZUUHM4bVVER2pG?=
 =?utf-8?B?VWs4OGsvanM3andJV09Zak9QejNMQU5ob1pvTUJCZWVZaWthRFErM0UzLytB?=
 =?utf-8?B?eTlFc2tpdnNGc1kwR0JaSWg2U0pyMWNXMWlVUWU4ak9RdHUxeGI5U3BuZjRR?=
 =?utf-8?B?cEIvQ0ZqUzZuNWNCSnJvVjlSODRLY0lnS1FVNy9yaFRYSHE4QzlPUys5Q0M0?=
 =?utf-8?B?K3lsbGlxSGNseEIwODRhSnhGYmVNWThkZXE5bklVemVDRE5ZRnBzZUwycGNr?=
 =?utf-8?B?dU9XRXI1NEdDME1jYlhldDdaanpJU096bnk0RU4ySXlka1JDRUVLMU9wbFNM?=
 =?utf-8?B?ZTBNVytXK0FUNTdCRGJEMWx2MzVuSWgrZCtxZHkwMnlDZnNaVHBzWTE4T1Zj?=
 =?utf-8?B?dC82alczOTdVZC9GRVFnUmxUUFB5YWJXbVhSRjhmWlBMNzBENXhpNW0ycWlm?=
 =?utf-8?B?T1htVUNsN1BHVFFFdDNRZDA2a2hocDBqZXI0a0hBNlM3dWprRzIwY3JpaTla?=
 =?utf-8?B?Yit1WGN2UTVCWEpNQ29KeWlHZmE5Y0JOZm12cFRKbmhoelZDOVQ3RHJJUkto?=
 =?utf-8?B?S1JBUEpaZEJIYTloZ3R2RUZBcUdNby9rMHhHVDJrdlBKU0p4ZGVNYzNsN1Rz?=
 =?utf-8?B?N0tPaXNyYVMyMU5uUzdVSHBha1VqK3ZqZE1ZWnVlbzgxQTF4ZFFCTkp1TUVO?=
 =?utf-8?B?dWkvYUdtODhPTzNwRHF2MHZyZHlPOG9qYXVvbnJmeUd1aDJZS2d6MVFTSTRs?=
 =?utf-8?B?dmJ0OFhpUTk2UHdtMWNEWHBtZWU2TnNERmZTQ1R0cHd5S0k0VzkwanJXdUlq?=
 =?utf-8?B?ODB4bU5ZaUVTZGxMbWlHRGkwbUoyRVVzY2lFdEtRVFYxTmkwaTNXclJOWFVr?=
 =?utf-8?B?TGJIRVRQaExuUW8rVlEwUVBKZmE0Y2xqaHF6NUw4RkwzeXQrU3htSGFsN3BF?=
 =?utf-8?B?bEdPSkFEQlU3TkVzeFZPc0VhUGU4NzduOEkwb29sdEMvWDVFZlpRUzE1VDZV?=
 =?utf-8?B?YjhBVUV5YXVvYTYyZWhEbDAvSzU5LzRwK3dTOXNBcDJRN1NtQkIxQnNKVitZ?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10a3337-3286-49cf-f57e-08ddf5d1900b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 10:04:16.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLPT41Aa2KPzXcCAmWbnLmMUHptv78x8B9QrPwh7nj8EMgtvVyk6BsEYefa1+6/BI1bmyXwqqT+adJhhFRuXH9V7i3CbzVz5+OJZ5pDEooI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSA5OjE1IFBNDQo+
IFRvOiBCcmFuZGVidXJnLCBKZXNzZSA8amJyYW5kZWJ1cmdAY2xvdWRmbGFyZS5jb20+OyBKYWt1
YiBLaWNpbnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFt
QG1hcnZlbGwuY29tPjsgU2ltb24gSG9ybWFuDQo+IDxob3Jtc0BrZXJuZWwub3JnPjsgTWFyY2lu
IFN6eWNpayA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5jb20+Ow0KPiBSYWh1bCBSYW1lc2hi
YWJ1IDxycmFtZXNoYmFidUBudmlkaWEuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4g
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGNvcmJldEBsd24ubmV0OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGlu
dGVsLmNvbT4NCj4gQ2M6IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBp
bnRlbC5jb20+OyBCcmFuZGVidXJnLA0KPiBKZXNzZSA8amJyYW5kZWJ1cmdAY2xvdWRmbGFyZS5j
b20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2NCA1LzVd
IGljZTogcmVmYWN0b3IgdG8NCj4gdXNlIGhlbHBlcnMNCj4gDQo+IEZyb206IEplc3NlIEJyYW5k
ZWJ1cmcgPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPg0KPiANCj4gVXNlIHRoZSBpY2VfbmV0
ZGV2X3RvX3BmKCkgaGVscGVyIGluIG1vcmUgcGxhY2VzIGFuZCByZW1vdmUgYSBidW5jaCBvZg0K
PiBib2lsZXJwbGF0ZSBjb2RlLiBOb3QgZXZlcnkgaW5zdGFuY2UgY291bGQgYmUgcmVwbGFjZWQg
ZHVlIHRvIHVzZSBvZg0KPiB0aGUNCj4gbmV0ZGV2X3ByaXYoKSBvdXRwdXQgb3IgdGhlIHZzaSB2
YXJpYWJsZSB3aXRoaW4gYSBidW5jaCBvZiBmdW5jdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBKZXNzZSBCcmFuZGVidXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFBy
emVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4N
Cg0KPiAtLS0NCi4uLg0KPiANCj4gLS0NCj4gMi41MS4wLnJjMS4xOTcuZzZkOTc1ZTk1YzlkNw0K
DQo=

