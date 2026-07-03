Return-Path: <netdev+bounces-304559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id og78JJG+R2pIegAAu9opvQ
	(envelope-from <netdev+bounces-304559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:52:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10070313D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:52:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="g/WuQAuD";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304559-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304559-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F7343074FE6
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C253D902C;
	Fri,  3 Jul 2026 13:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BA3D647C;
	Fri,  3 Jul 2026 13:38:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085920; cv=fail; b=F4ZM8Uq/S6j+TUg1WpWC20v06TWpoIQHzP8xoIf3NzBZiZ1uJbxWg4pjU4zXFhpkHGOClHqfvZmLrzm0CHiZss4KpUe8Uidpb6ndgKrlzbvOM+wn7KjNeObzWdjN4jaCfnunVPrJ/pto/YStu7S05wtNA50uNlxmP/7TzdZ9N5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085920; c=relaxed/simple;
	bh=A2w7sBcoTJTJMGqewl0T3bowZHbfYaKiDOeAzYBPtdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtFDLNojEIeraKZ0DzKDOuD4NN9rEy5yO5bNSsNidFHg6eurY214X0KcUFEAercuNdj43LxIpxgSbUqwXwGV6fBLhj20x75KkYH2W4a4cq9TD/on8CuMIL+hKTzsZ4vXGGZhF35YV08Bwy8ukxYRBAb4ZTGOO8CQiPdPx3jxRYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/WuQAuD; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783085918; x=1814621918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A2w7sBcoTJTJMGqewl0T3bowZHbfYaKiDOeAzYBPtdQ=;
  b=g/WuQAuDuoIn1ibrWl2xINVYeGa8lMO/N7bTYfwH9RS/JbroXa2PcwQC
   8w2AwJTFr8cPLS4IZhsRS505bzPKsFMQ5QwC5t6uC72PFOiZjMP/lKSGV
   OMRzX/iPQt77uuSwgdbvdlaMEbB9w4pQa4TZ/xaHCq+mPswzErKwuD7Ur
   birF9v+tx6oo5yCT2eSLypb8JAziKsFhdi7fBdmrBLRBPAZc0GjxC3gxj
   nglqs8uUoeEhoK603dFRuMZcb87k87S6kZajwy7iKKoUXNJ7etjsbz+++
   g7V/o/spBWx4cHtu7HlIBeTm1KqyP1jjNpq8bmX5sqFi5Kvhmk6oEQ/lx
   g==;
X-CSE-ConnectionGUID: rAtcedduTNiZ7M53AYBh0A==
X-CSE-MsgGUID: tKaSxO6xQP2Pw6HHdr7lxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83969999"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83969999"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:38:38 -0700
X-CSE-ConnectionGUID: z8dGigHIQ/yjmJWK4eiKjg==
X-CSE-MsgGUID: qd6470tGQAmNHb+/d3z7tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="277448012"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:38:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:38:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:38:37 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hal5vX3394ll+2Ysf+xdF/dpZJ1mH6QJX8aXeHIBA3W6/zRmRX2XWKQeGfz0j0qNlb7pmpUJp/OMcTLr1Lq1oDNLG3E0517IliNDd8XFZO5M/YMr6zQzO743fgnF/pbvyYYzOWkrvrq7RwMMNdiAGCVuxbuho95VGwAe6IQ5AMqlszCh4w2DSwQNYfekPLYKWykeQgTZCL+V+1gIV3T5I/bYvIT7bpapfH/ca48pW5esBcMxmm/8CH+F9Da6BVt/E/9O9rG+C5dODN95Ync588z0vAp5M4fGZ2XAHo4DAJys4fru26KM7LCZdYS1b8uWjCgLWUm7QNokV3XgZ1FUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2w7sBcoTJTJMGqewl0T3bowZHbfYaKiDOeAzYBPtdQ=;
 b=GJPqzp+zrm4tromnBwfrKDQrmmwa69sYtBEO9ze9c5SQrgxkv0LqLUNkqDTSTxnLlUi0YUEsz+WFLVA8IULIVCQm2b80+mjmv8q5fpL8epYRjUP1G1v5os6ZHCohGF7gxzPERUIOmUINUGIUtHR3mNBz4tw+jqEziyFRftQkrDN/+4CYwAZqEc1Zut7I2olrncKxwthIu9qnPrDklUFX+NCgwmm8ogUcW422yKb+2cnHplj86ywLlRQ/o/uHLxmFr0bvFYvzucYoy9ZIA/TRfhR+ebgyoJdn4ux1k3m004KcRhDO/I8SYV7b9K5hTLcnN2vzT3fxgw4uGk+6yGZGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by SJ5PPFC35D45AFD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::853) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 13:38:27 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:38:27 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 09/17] net: dsa: mv88e6xxx: Get Product ID when
 enabling RMU
Thread-Topic: [PATCH net-next 09/17] net: dsa: mv88e6xxx: Get Product ID when
 enabling RMU
Thread-Index: AQHdCsFm6hmExPetMEmrp1L0p2ttGrZbzKUA
Date: Fri, 3 Jul 2026 13:38:27 +0000
Message-ID: <PH0PR11MB59026868D02BF8EC4FBFDD24F0F42@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-9-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-9-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|SJ5PPFC35D45AFD:EE_
x-ms-office365-filtering-correlation-id: 45592e11-da51-4885-9bb9-08ded9085cc7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: nd5Iy2bZpohcdAyiTxtFn/T4cvqcKh09Zh+gSb7F1KJxKWJeHRnwxmHSrM8vrKKKV9jQfAyAs47Jf/onecbAw8BecxnH70509MDxFKEf7Qi6dBJD8P96NyCKXAWfN/1FfrfzkIdLl3hzbubuvaL9WLQhux5iUVXKMHZhDOsxIZs/fncOW72uQ5gts2qtI5ME0wAR39ncv4wQsK9npVVz10LXwSwIjhUJk/+oeKZUvjvXLnOv/M5i8JJqWxFfZOKQ1apddIIB9Z+UZd9bD3soZOWO8mJ6nILEu/9vlMDcxe3QdglhWPNfvfYiIxZm+mpacXOWIaUilJ1sFAV2WusDFFNdEh0Mlrg+c0f6X3NLdqLRHYSBBReAYYwVYCvr9TQGhFJABXcmn/r9nrLvw5DKf9ooLgfc1OXJSUd2qtsiR1cyTWe0G2+Y8/IKFIjYaqlVc3rY5Sst52jnGA8ySPDMIAOBGifHIcXHTcFk2DjxqurGLbh8ZZrC/WFfX9WLlZ27DIkBEssTTh+X3KjNnq38yZ4fJJTSECsES5z/5IQixP+7fLZE/0y5ITkGRSwmuakh2IGABEO1jRdzI3IvxExir9PK6iHuiF7W/IRO2+Vva7IMMghHHFlXFEBZKqGR+4Py6L0zSYYz7jfInIeEw6yZ34X7O39y+t7Xys+9occILUzE9qYHp/YAQwxOQpDjMN4iEHpaH5Yv3BaDv82gQLlSV5YFUKJO94gj6FY1CJ675Bx+xbrA4cbGx3QthJLb1uxH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTBUTFJ6Sm5zZ0ZPTmcvMGh0TmFqc0xxcUhTczZCSmdieHpHOE9VaVd6YzJS?=
 =?utf-8?B?cmRjWk1mK2I4TlZPNlRiUnVDRmgyQnpVbGVsTktYQ0dId3VWOTNKcGVRZVBJ?=
 =?utf-8?B?N0ZuYnN3ZDdpRjlKSmFVMmlRTE4yKzhpdUxQRWJ6cHBKT3BlR0JKVFpqZ3RI?=
 =?utf-8?B?M2hCeGdPM0wrMHpzS0RwWGZVNDRET08yTVAvTjc1MjdZY1E4Y0dHSmwrNWxs?=
 =?utf-8?B?dEUyanJ2QW9ZWlZ2YWt2Q2xHcEUxNC9vWVZ1NDhBak52ZE1EdXZJUndETnIr?=
 =?utf-8?B?eGthbURIbFFtSlN6OGRZRjkrdHl3Mkp3TFArNVZ5d2sxL2tWQ1I2dGllRmpI?=
 =?utf-8?B?WGRRNjVFN1FTQzJOcGQzRCtiYmlKOVBXS1NaSmtTNkZ5cE9VajZCYVMrRUp4?=
 =?utf-8?B?bmNjZEpaSXRkU1ROTmQyQnVyVVM1cWx4MjIyLzNYUFU1TlhSZGFjVzBIWGx3?=
 =?utf-8?B?dkYrcko2SDUvU2VhdE1FekFyTVpJcS9oZnZlRHQzRXA3U3Z6ZzY0emdMZitP?=
 =?utf-8?B?a25qNzdPQWVzaWpIbFNKV2RQODlqdzNJK0cvQW04U1pHd1MvcWpnTWJveHg0?=
 =?utf-8?B?VTZWc3EyR0RrQmh5NjdWd1ZZY1F0eFpQczYrdUhsZlJGR0Q2MzRvbXg5Q2x5?=
 =?utf-8?B?dUF4NGJLV2JvckNmN2ZveFdIdS9tRmpIcG85MkJkZmlxMXFRUUJQczFBcm91?=
 =?utf-8?B?cHhndmRFZnp4SnQ5bjNQUFFPbkFLaTdWR1VSTUh6NlRCbTQ2eTdZODZxbE1y?=
 =?utf-8?B?NDNMZHA4WGtoOHRjanZPcmtJOVAzUndnNDRJMGhsN0ZtdzZETGtPbjlmK250?=
 =?utf-8?B?UXFjeWRIQXRINHlVTXdWTFBEeVdRR0VUWnlscm1tV1QxSzNSbkxIUEFQRnlI?=
 =?utf-8?B?akhYdkVzTzluTVR1SE9qSjExaVFxWjVDODBmTWZpT05UdDRRZkVPZlRHWnl1?=
 =?utf-8?B?a1Nra0gzUFRNR05mMjhpRzZpcXBPTm9vMitNc09RUVo4OXNMVEZwNllMaDdB?=
 =?utf-8?B?UmNYRHFFcDFMVEZtWWVVQmlFVU5pTTh6VWhlQkcyRHpBYUowN1Bsa3FVbWkv?=
 =?utf-8?B?TERLdktRUUFUdWR3NEoxbWY5Q0ZPdnJ0ZEFORVdCOUFyYzEvS093dHJsTjBk?=
 =?utf-8?B?R0Nrc1Q1ZjZGaW9VRmxlT0drTW1abHJQWVFPOWg0MEpQWWJwU2szQXl6b0l5?=
 =?utf-8?B?V1M3cElTMDkwNXROQTFzOUdKVmJZMHM2UEtEb1BSa0g3cFRSbk9wbzBrVDEx?=
 =?utf-8?B?Zm95MVVGNC95cEFjUEZ0U3pLTzAvL0FMZWJjcXhUbDc5UkpNWFh6V1J4b2kr?=
 =?utf-8?B?TXJMWFYvcndyUGFjWlpabCtXL2tYcXVPeUdGTlZFdURhQnlRWll2S2FXT1dv?=
 =?utf-8?B?andvYjJ1YUJYKzhQM1VES0RLWDJ5eTl0VTJmUFNoMklzMk9iK29NTjc0bmhn?=
 =?utf-8?B?cHRkT2tESTgvWlBEUGJqUU96bHZWUkZTWUJNWGp1eVhOUzdZVjRDdFM3bXpJ?=
 =?utf-8?B?R1d1Z2RIWURsRmoxWTBrL1FlVExSbGhpV3Y4SnJXWkI0cWcwUjVsOVM0Vklh?=
 =?utf-8?B?azArTW52UVpmYVZhVTExQVJVRjZyY2JkNmhTbDZSZndLVG1kTU9RZ05hVG9C?=
 =?utf-8?B?REpJaFVBd28yRXJWdkRTbjJLU2w2WUdzUzdZYWVnU2U2YURpRjZ6aWhrb0Jy?=
 =?utf-8?B?UkxWSmFBS3ZmWVR1Q2xaSDIxQTNVbjFKYmxoK1d6TGdkMDA1UEFJdEdGUlU2?=
 =?utf-8?B?Lyt4RmNQWVU5LzFTdVc3U2k1aU4ySFVsZDlvWGZ3ejcrZDFTbUNSbXQ0NXkz?=
 =?utf-8?B?MU1aS0ZabWh0dnduclQvRXdiVEZyY05lZWFtRElwUFA0K3FmYnV6ZFJrVTA3?=
 =?utf-8?B?VWJiTFpwbXNBSXFFUmZMTjNGcU90c3lIdGQxU1krZXZONW9PbmV6N3RHVklk?=
 =?utf-8?B?aDZXMEUybXI2VWZZaGNhc1VXNGtENk5LQzBHZS9EWkhJWXVUVGdrcmJPL2la?=
 =?utf-8?B?U05ObW90a00zdmM0cWc5a1hyNlJqK3doeUhZaURaZTduQzhkWThiOUxzQjNF?=
 =?utf-8?B?UWE5UTdUbGJlaTk0Ym5RWHI3NXVyK0N4RWN6SWFOWStHOFlQY0FXbEpQaFVN?=
 =?utf-8?B?dzZBYUtJbjZhY1NNUzNqUkoxWHBJWEtwY21WbmgwNzhmcDNkaWcrd1pBdnc5?=
 =?utf-8?B?T0NBYmZVaUZ0M1hsREs0dUw5MVRDUC8xTzdxSU15dU11clU2RkpnVFpGUHd2?=
 =?utf-8?B?OFlXN0ZYRjlnbkNURk1jNmR6c3RwVExtK3AwWVV3dmdlMm5HWUNxb2E1L1pl?=
 =?utf-8?B?a3pqcjREdks2cE95NDJma085VFJEQXdnWnNYaE9TdjlCdkRHNUhMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: euSSTOJYNHkDstoA2ehaJfQiGXOGqCkF2aIrlXPh2z3P9e6rLxjpniYyQdI7YVk8orbIhvqrrxw7+b0kF7BiZoBOSlv64VuP+4Vi3TMHDw8jd7qMciB9fFMtqyoj7vwFFNwsSn8YSJl9o2buattUI6U44hgs8dCa/hMvTHrevh0ndu0+ezH1hbglAaNZWVn+liUl3nN645iOF01lUADrARJhYD+lbVdmGpqfQG32bOWUTGVymF0/9X+ygXCKfJUeIj78QVoJ7S5OfSIXIMUMGhL8g2/F/dae9ZodKMpT6y/ZOQVMtMdzvxRXNronYxQWnxNyntrQuQSdMTJbIHPHyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45592e11-da51-4885-9bb9-08ded9085cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:38:27.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZcigchAeA4XJt7EkqqiWIi85e6ye0iKypc8yrF+f7L1tNzj9HsA6vtn0pacRmp1TMBH/nTEzeybj+kiRXBp37bWTtx8SkmNvmuVGj6yfJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC35D45AFD
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304559-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,padl.com:email,PH0PR11MB5902.namprd11.prod.outlook.com:mid,vger.kernel.org:from_smtp,lunn.ch:email];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A10070313D

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCj4NCj5Gcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+
DQo+V2hlbiB0aGUgUk1VIGlzIGVuYWJsZWQsIGl0IGlzIHJlY29tbWVuZGVkIHRvIGdldCB0aGUg
cHJvZHVjdCBJRCwNCj53aGljaCBpZGVudGlmaWVzIHRoZSBzd2l0Y2guIFRoaXMgaXMgdXNlZCBh
cyBhIHRlc3QgdGhhdCBjb21tdW5pY2F0aW9uDQo+d2l0aCB0aGUgc3dpdGNoIGFjdHVhbGx5IHdv
cmtzIGFuZCB0aGUgUk1VIGNhbiBiZSB1c2VkLiBJZiBzdWNjZXNzZnVsLA0KPm1hcmsgdGhlIFJN
VSB1c2FibGUuDQo+DQo+VGhpcyBjb21wbGV0ZXMgdGhlIGdlbmVyYWwgaW5mcmFzdHJ1Y3R1cmUg
dG8gc2VuZCBhIHJlcXVlc3QgYW5kDQo+cHJvY2VzcyB0aGUgcmVzcG9uc2UuDQo+DQo+Q28tZGV2
ZWxvcGVkOiBNYXR0aWFzIEZvcnNibGFkIDxtYXR0aWFzLmZvcnNibGFkQGdtYWlsLmNvbT4NCj5T
aWduZWQtb2ZmLWJ5OiBNYXR0aWFzIEZvcnNibGFkIDxtYXR0aWFzLmZvcnNibGFkQGdtYWlsLmNv
bT4NCj5TaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+U2lnbmVk
LW9mZi1ieTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPg0KPi0tLQ0KPiBkcml2ZXJzL25l
dC9kc2EvbXY4OGU2eHh4L2NoaXAuaCB8ICAxMCArKysNCj4gZHJpdmVycy9uZXQvZHNhL212ODhl
Nnh4eC9ybXUuYyAgfCAxNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+IGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvcm11LmggIHwgIDExICsrKw0KPiAzIGZpbGVz
IGNoYW5nZWQsIDE3MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L2NoaXAuaCBiL2RyaXZlcnMvbmV0L2RzYS9t
djg4ZTZ4eHgvY2hpcC5oDQo+aW5kZXggOTQwYWU2OTg2NTlmYy4uMDczMDBjMjVjYmQzNiAxMDA2
NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L2NoaXAuaA0KPisrKyBiL2RyaXZl
cnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5oDQo+QEAgLTM0Niw2ICszNDYsMTUgQEAgc3RydWN0
IG12ODhlNnh4eF90Y2FtIHsNCj4gCXN0cnVjdCBsaXN0X2hlYWQgZW50cmllczsNCj4gfTsNCj4g
DQo+K2VudW0gbXY4OGU2eHh4X3JtdV9zdGF0ZSB7DQo+KwlNVjg4RTZYWFhfUk1VX0RJU0FCTEVE
ID0gMCwNCj4rCU1WODhFNlhYWF9STVVfRU5BQkxFRCA9IDEsDQo+KwkvKiBSZXNlcnZlZDogYSBm
dXR1cmUgUk1VLW9ubHkgbW9kZSAoZS5nLiBNVjg4RTZYWFhfUk1VX09OTFlfRU5BQkxFRCkNCj4r
CSAqIG1heSBiZSBhZGRlZCBoZXJlIHRvIGluZGljYXRlIGEgc3dpdGNoIG9wZXJhdGluZyBwdXJl
bHkgdmlhIFJNVQ0KPisJICogd2l0aG91dCBhbiBNRElPIGJ1cy4NCj4rCSAqLw0KDQpBcyBmcm9t
IHdoYXQgaSBzZWUgaXQncyBub3QgYmVpbmcgZXh0ZW5kZWQgd2l0aGluIHRoZSBzZXJpZXMsIGNh
biB3ZSBkcm9wDQp0aGF0IGNvbW1lbnQgYW5kIHVzZSBzaW1wbGUgYm9vbCBlbmFibGVkL2Rpc2Fi
bGVkIGluIHRoZSBwbGFjZSBvZg0KbXY4OGU2eHh4X3JtdV9zdGF0ZT8NCm9yIGFtIEkgbWlzc2lu
ZyBzb21ldGhpbmcgYW5kID4gMiBzdGF0ZXMgYXJlIG5lZWRlZA0KDQouLi4NCg0KPisJcmV0dXJu
IGRzYV9pbmJhbmRfcmVxdWVzdCgmY2hpcC0+cm11X2luYmFuZCwgc2tiLA0KPisJCQkJICAoZWRz
YSA/IG12ODhlNnh4eF9ybXVfZmlsbF9zZXFub19lZHNhIDoNCj4rCQkJCSAgIG12ODhlNnh4eF9y
bXVfZmlsbF9zZXFub19kc2EpLA0KPisJCQkJICByZXNwLCByZXNwX2xlbiwgdGltZW91dF9tcyk7
DQo+K30NCj4rDQo+K3N0YXRpYyBpbnQgbXY4OGU2eHh4X3JtdV9nZXRfaWQoc3RydWN0IG12ODhl
Nnh4eF9jaGlwICpjaGlwKQ0KPit7DQo+Kwljb25zdCBfX2JlMTYgcmVxWzRdID0gew0KPisJCU1W
ODhFNlhYWF9STVVfUkVRX0ZPUk1BVF9HRVRfSUQsDQo+KwkJTVY4OEU2WFhYX1JNVV9SRVFfUEFE
LA0KPisJCU1WODhFNlhYWF9STVVfUkVRX0NPREVfR0VUX0lELA0KPisJCU1WODhFNlhYWF9STVVf
UkVRX0RBVEF9Ow0KPisJc3RydWN0IG12ODhlNnh4eF9ybXVfaGVhZGVyIHJlc3A7DQo+KwlpbnQg
cmVzcF9sZW47DQo+KwlpbnQgcmV0ID0gLTE7DQoNCm5vIG5lZWQgdG8gaW5pdA0KDQo+Kw0KPisJ
cmVzcF9sZW4gPSBzaXplb2YocmVzcCk7DQo+KwlyZXQgPSBtdjg4ZTZ4eHhfcm11X3JlcXVlc3Qo
Y2hpcCwgcmVxLCBzaXplb2YocmVxKSwNCg0K

