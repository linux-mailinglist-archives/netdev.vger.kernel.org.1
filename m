Return-Path: <netdev+bounces-290686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DfyAFn/D2qLSQYAu9opvQ
	(envelope-from <netdev+bounces-290686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484FB5AFC82
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4ED03025730
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B33806D8;
	Fri, 22 May 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX1FiX4v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E228F948;
	Fri, 22 May 2026 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433130; cv=fail; b=YvWHKibVpfv9oPrpnRJR7PgAVVtSodk3oS7rcK/rLVcmjO+B7RatFGHjWe8LRxl/QCBRqsu6O4K3VfeEkR4GTvpyvLlI7vwdjESNvbUt/dxjP3kp0Xtl6I6Dlw+fb0hxiuqKQjqW+vw9iKJN5eIby1IMmQT4ZMSEP8bPU2Dc7s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433130; c=relaxed/simple;
	bh=cjCmzt/kGtNw7pYPY6DSX2yr29jIs8IIr4rrnf9WsDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B1Y173wf2upUAaA9KD+2Ht4BcErQ2bAkIFqfU0FIMSie+FkxR1VfdAFZCrNoWOKdEJQ1uraYOwQjjyrPdVByQp+F3LxpCDyAPqcNdyH67QODXQdvMN3niXyYnfvHv5zDzFnTEc82NpkG837SVbK9w6vLaOU1TD/KMG6nQzsoMbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX1FiX4v; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779433130; x=1810969130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cjCmzt/kGtNw7pYPY6DSX2yr29jIs8IIr4rrnf9WsDQ=;
  b=TX1FiX4v4Vyv26mF6s0xKEWpB41RZO1aCilxEEPWrJndMrSuoODkMGd1
   MMFRpJHtHkgWJ1YDI7dsv6B5I+zg8sHV68qih/tWWma+/LmrNgeyjOfXE
   qT+4maiwOdQaiEK2koiZQgXRGxetjbL5052d244lOToZJ09QPoOpsPgqm
   2SmaRnUF0X1lEU5QfiegEy/nTbBSYVxJ0j4Nssnamb5aKU9zHgWrHZze3
   kSveuVIfuyp3BicmR9/A5ibdL45ZeCc1TJEtna+DtnSqY+jAl8WqwDPs6
   Qew+WFPjICOafA8FFNmA2IjGvsEWj5dmZTroWfsPDuED09W2vPG0TtJGE
   g==;
X-CSE-ConnectionGUID: fkRFKDmmSMatcg+1Cjhr3g==
X-CSE-MsgGUID: /8N3/y6qSneoD4+LsKe13w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="79393138"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="79393138"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:58:49 -0700
X-CSE-ConnectionGUID: 6billvHAS9W4+IgNMJaW/w==
X-CSE-MsgGUID: mN6uE0EJQs693hZUsMAlbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="264656925"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:58:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:58:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 23:58:48 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC8i9e2q8JNBe4GRsCBy20M9gw/fu+6yLrqfWadLU72bYWdOj7ZxHVmMPoqEJ/dWL3Gz37q8XGKy+quiFR7oAlF3Md60xvyMGFq2gDMgNmCjdKylrZG+yGzRSe5FL7V6TvVuyRLASgp7MfBgMGaVs8f+nJ6tq/gaz60gXa/31JUghSjP5Hjd5iUasOpUAl15Zh+LiDwaTSaI0s5Hg0Yd80e0KoteDMxaKcdduF2j+5YS4epeg2KJFXGDTO5Mp6dhBujHB3ZYWF0r7blKfuuBUOa88DlNfg5Hzm33ihbTCFku3olbWhN1QPrJHrdAMlvka+JJZJKinqLwAcxOt7l/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjCmzt/kGtNw7pYPY6DSX2yr29jIs8IIr4rrnf9WsDQ=;
 b=KuxElSxWmrWRFJDZveLpQ97FJhrBE0C+zc8wFGHyTp1W/rZ3fvRVI0aNvgBdmlCrnzpNbTae+RvWygw+bFQsZbeBcWH2liUvyreOULhIV4GpmwoYP7DGb+kfdiHsgcPW0XCgspTYsT3DgmRVbLqgJrKQrFIaNLzkKGHEnmZZFTwdd8EweDwfIep41gO4DzJ96nSn6qSkuHCAJN51O05fJ6buzWFX/DMbadDjLrNibke/VRPNb2FavcZmQdsWsDCGtjqFY7Unnl4bzPv0q0R1SQwxUP5fvDdQK1nXZisIDv+5ITJByajZytjJZwlOmjVn0OXLiIyJ4O1Klj4hDlZQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:58:44 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 06:58:44 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, andrewnetdev <andrew+netdev@lunn.ch>, davem
	<davem@davemloft.net>, edumazet <edumazet@google.com>, kuba
	<kuba@kernel.org>, pabeni <pabeni@redhat.com>
CC: intel-wired-lan <intel-wired-lan@lists.osuosl.org>, netdev
	<netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next] net: e100: remove redundant
 static variable initializations
Thread-Topic: [Intel-wired-lan] [PATCH net-next] net: e100: remove redundant
 static variable initializations
Thread-Index: AQHc6bfChoNVkZDjq0SvwEsycjDV+LYZnVZA
Date: Fri, 22 May 2026 06:58:44 +0000
Message-ID: <IA3PR11MB898674A58535ECD2979C0BB3E50F2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
In-Reply-To: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB7953:EE_
x-ms-office365-filtering-correlation-id: e3cbdd3e-8e72-47ab-2087-08deb7cf9095
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|921020|38070700021|11063799006|6133799003|22082099003|56012099003;
x-microsoft-antispam-message-info: sWshKsSnbtpRnis9H6M1SByRtI1Kx6OY5T63l8vyEkqThtcDB81Lg4nNo+or3JKkz1kuEBDaStf3ebiDTBPteV6aYExIn43gczFOVFnSTtYxLFfbmARJw456q8Cu+6ckGxVRWf+7sduXFStoIHw4kzkRpZK/jk/Z2D0/PHBv5Y+sBldjSVAhddOtvgdpKnJRBpqVSSB2NgtFLuqs23xT0c2epEKBRnLEd6778eJSBOzOruH8Gz19orwajXzW0Dn5DLXt9hvn0a8U+ugje2WecncRcOkol6LTPwgoebuu90WPjdq+iVYvyZLQSSoC2NbhEelun8tmgEO9GyOsrgTYwQuYYknbU1BrP5YCPYjiCNJ6P5KrMPiMyg7hTvYkzMpq5X2boqLzNVhK7TNUGQQSKRAq6Z/zdBqaX7emqj6rgoK/fVJ+pKIQM97miNS8uCKdwQsxUCwFrl9jB2v3JRInhCUeQ2KvUa0Ra1A8e5iWdLVYubt+GJC8Nl+fF1p/I3DdAjQFggGM302GhwZ+eGgEvD9JqcIt6f5smQ6V2mmo5ZRJpsmswctqPUGdToiMFj/oKWrYTrdRp0/ltot6Ay08uXITPjulqZ7awKq5bsYjmEVLIyMf+ny76k3CojWsV7bFAty3WYt0MrzBDLmuIiehwHCvxCp5+IgHkUAniUT3bgKmONEl9TcJ3mAXZWPcsDCQOmcOdwgvBzT0YIKBMiLzulEovf326xIQuGIoDcMtsTHczmAkNFwzYyX887+zn0tJ0ZHwQ6GLfMrrj84fppnviw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(921020)(38070700021)(11063799006)(6133799003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnkzUzJ3d29ZaUVtRTg4dEpGL01GMFhPbFN2NDlvWW45dGQ1djZwa0diK3gw?=
 =?utf-8?B?aTluMCtXbm9zaERGaEhlNzhaL2J3anMyMThOUGlpV3lFd0ZTVU9LR3ROUFFK?=
 =?utf-8?B?NUZHUWlWWFUvS3hPT3BaY0trajBPd2lJZlRVQlY1VlFLSitmRFEyaTl0RHBa?=
 =?utf-8?B?cVlVRlZhVTg3NERaeHVmTzU3QVU1WlhJYnZMazhienRxM2pNNlFtaU9Nd0li?=
 =?utf-8?B?T2NWek51ckprbGlKMUVaRGs2dkpxUnZ2cXlnWDlWRzVXTzFiVlZFQmtxb1lG?=
 =?utf-8?B?WnMwMEllYVRVWWxoRjUrb2RuUGFKQ09QWFZXWmN4WWtrYWtiWE9NaXhQamR0?=
 =?utf-8?B?TlBhZG9CWE9BV3BRL2VrSzlPK0NDNmkyNzlENXh1S3FWeEQvMG5aZ29UWHhI?=
 =?utf-8?B?RTlvc0JOVHpHS1NGZjd5Ny83cWdlRjlkS0lWK1EwRE9oQXh5K2YxLzl5RXY4?=
 =?utf-8?B?NDBlZXNOa2ZTQkM4QjRLcEc4QUZtSDZwSElZRVErRCtadHpxMFAxM0Fnc0N4?=
 =?utf-8?B?NVh3RXpXemdrZk5NZUtySlVVKzZzQ09qV0k2dEJRc1BIa0w3d3IwNHE0Tk5R?=
 =?utf-8?B?NjYvWHpVK0hEQmE1U2ZSVWgxT3BSSWJ5WmIwVWtzSUpLUWhodlhTTW9nckdu?=
 =?utf-8?B?cndqQ0tOQ1B5STN1WG5kSTg4TlpZc016aHoxUEp2TjljWkVjZDM4c2tScTRa?=
 =?utf-8?B?bC9ocXIralJzbnhnZ0l2OHlEb0NPVkdYVTU5R3NsbHY5aGNyOHBIRWlJblpC?=
 =?utf-8?B?cEUwZU9NYXBJWGF3bVk5V0tRdGdVMU1mM25yNGt5Q29NNHUyKzZkMHJnVEl6?=
 =?utf-8?B?bGtkSnFPVzQyZGFOdHNBbTNzbVVObHlXYStKaFdjWXZZd1B1VmxGOUh3K290?=
 =?utf-8?B?cTk5Ty9lUCtubUw2OGVCR1Vkb1IrM0RZeC9yekxybEg3RzRqZXBsZ3lDdkpj?=
 =?utf-8?B?dHVRZ25hTEJyS2dLL3oxakN0dTdvT2NjTHpEaFRzSW8wdDY1R3d3bG93WUNM?=
 =?utf-8?B?M2QrZExvZHpubjZuRjZIazk4cUl1bFlka0dORmtTaTBkNjBUMDdvRHI2SGpW?=
 =?utf-8?B?ZEgvWG5lQ2V1YTVta3VLdDlxNDdnVlk1MzcvTEtPcTUzQnlyWGFHZ1ZTdmxG?=
 =?utf-8?B?RlQ3VEorcFBqbzNnZ00rb1gwUVVjc21KQUdjcjZrUjdlSS9rR2xQVVdTL0py?=
 =?utf-8?B?dUE1QmNITzRsS2NZNFIvOGRWT2t5NlNDZWpTM3E4OXJ1TjA5Qk1uNjhmZ0NZ?=
 =?utf-8?B?YThkTGI5Y2pVMThkSGgvOVBwME5zZDc3RzNhNzFFcXhkSjNpTU1WUWt3cC9H?=
 =?utf-8?B?TGJwK0pZNXNJcENPY250ZU90VXI0YVFLUG9qSUVXM2V1Uk54dTB3cjQxTmdo?=
 =?utf-8?B?MUJTN0d6a1dUbWRaQldTNlNISXd5NFZoRFJtRHFsQ0JsOTl1WUgxdUVzNzE3?=
 =?utf-8?B?Y1NKcTF5TXljRm95K1pHdzM4T1dZUmdLQ1VWY1JKa0JuQVNyTDRhTTNNTE5i?=
 =?utf-8?B?UlVhSGUvdldCNVM1c1lNN2JjdkJYT1Z1U21jOTJ3TktWczcrVC92cWxWcXBj?=
 =?utf-8?B?OXBML2xJbkJmK0xNMHdLM3k0c05WSkt4WTBIUkdjd0V5eUVkYnc3UmZTU0pE?=
 =?utf-8?B?RFVYMk1RRkpPcUlIYkFFRk9IWU9DSTNLTGZpQ1NONWZUY0FDZFJHSnh5MkJV?=
 =?utf-8?B?N0sxT3d5M0ZXdGtmY0FhMnZDUzhnK2RudmhXc256OFAxMDRKMXJ5TlUreW9M?=
 =?utf-8?B?bEtraERKeXdUN1JQOFVkMC9EQkpvbHZ1VzFzeFpyL3I2dDZ5TWQ2N0dEaENx?=
 =?utf-8?B?S2RKb1hoeENXQVZMcWQwR1hoUmcrZk9jZFQ1Ti90TC93ZlR2Y3pyRkRBaHFz?=
 =?utf-8?B?QmRZTnAxMWRaR3pVYTc0R0t1YUFxY2FmVmF6Qk53dGE0dnFteTVoZS9MNi9E?=
 =?utf-8?B?OUZhSmQzUDRDdlI2clhVMzB1M0FrZ2lWZERtMXE5MElaZlZQQXEwRWZBWVpi?=
 =?utf-8?B?UDZMVDdiWkZGYk53REpKMmU1NjlJVHYxOHVlMXdnNzlaN204NDFTM1hMNkNB?=
 =?utf-8?B?aDBrT3p3eGF0NXRLTjdtcjJQbGd2V1g4RVZmNnR6dGl1dHhsZDFEMnpyZGRY?=
 =?utf-8?B?TFcxSnVnNTcyMDB3clJ2UmRNSUY3NndnRnU0RjA5V3V3YVBqZWJOV0drMHZM?=
 =?utf-8?B?RW91ajd6VkJ6RmVWS0hzV1JEMFNWd3BUWlZFV0pUVytUb2I5L2ZFV2hua2RR?=
 =?utf-8?B?S2hKUXRzSWtjZ3pKd2wxV2lQZ2hxZ2ExVWNSczVVdnNZTmZLaHordFBhbGcv?=
 =?utf-8?B?NU0zNjN1bmVmdUlBeEhUYzk2NUlqcklQb3RKMklvZDFIdzFGVzJ4UUtRUUFV?=
 =?utf-8?Q?GV1dNGqLIan1klLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: d8C8hJ7ATRLgZMUdGnUZVa8ZFM2yOCUtxz/JRd24S/FcB7QtU52ODcdNJZem86d+2ZmNPC9BYVdUCmBFZEXpV1G0A18vJv1l11qyaITkGuNWaMPtM4fwpsAkD8J40QUx/PWmbtKLEeqi00l0Yka7w9r732fEDzwxXzOgT3pdL0JVtJZuUJR7TiAjv2mMZSul+XaSwPmpbE7JdOPrrZI1+qiNryQwOtF85+U2ne5bD4rv7grcrrUvFhIjkTaPBxMVEmEQ4MSCIPXtKqqs58fV3EdiHPws+unrDiZoKQOwPtHImi8xoh48Pwf6J8Q4QYaLur21kbtLIugWJQjEfHisrQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cbdd3e-8e72-47ab-2087-08deb7cf9095
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:58:44.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOfjk2lhtEj6sq8OIRPZp5nD87xzPpeXAcyq9o+aHNRhnob7kaMqMeN3G9PQZnAZtPIG65AfPIBUAy58XdLyEa66IbzzeTBaW0wL72IFtms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,zohomail.in:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.466];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 484FB5AFC82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQXNo
d2luIEd1bmRhcmFwdSB2aWEgSW50ZWwtd2lyZWQtbGFuDQo+IFNlbnQ6IEZyaWRheSwgTWF5IDIy
LCAyMDI2IDg6NTMgQU0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVu
QGludGVsLmNvbT47IEtpdHN6ZWwsDQo+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBp
bnRlbC5jb20+OyBhbmRyZXduZXRkZXYNCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IGRhdmVt
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgZWR1bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+
OyBrdWJhIDxrdWJhQGtlcm5lbC5vcmc+OyBwYWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPg0K
PiBDYzogaW50ZWwtd2lyZWQtbGFuIDxpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZz47
IG5ldGRldg0KPiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BB
VENIIG5ldC1uZXh0XSBuZXQ6IGUxMDA6IHJlbW92ZQ0KPiByZWR1bmRhbnQgc3RhdGljIHZhcmlh
YmxlIGluaXRpYWxpemF0aW9ucw0KPiANCj4gDQo+IEZyb206IEFzaHdpbiBHdW5kYXJhcHUgPGxp
bnV4dXNlcjUwOUB6b2hvbWFpbC5pbj4NCj4gRGF0ZTogRnJpLCAyMiBNYXkgMjAyNiAxMjoyMDoy
MyArMDUzMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIG5ldDogZTEwMDogcmVtb3ZlIHJlZHVuZGFudCBz
dGF0aWMgdmFyaWFibGUNCj4gaW5pdGlhbGl6YXRpb25zDQo+IA0KPiBSZW1vdmUgJz0gMCcgZnJv
bSBzdGF0aWMgdmFyaWFibGVzIGVlcHJvbV9iYWRfY3N1bV9hbGxvdyBhbmQgdXNlX2lvLg0KPiBT
dGF0aWMgdmFyaWFibGVzIGFyZSB6ZXJvLWluaXRpYWxpemVkIGJ5IGRlZmF1bHQuDQo+IA0KPiBG
b3VuZCBieSBjaGVja3BhdGNoLnBsDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBc2h3aW4gR3VuZGFy
YXB1IDxsaW51eHVzZXI1MDlAem9ob21haWwuaW4+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvZTEwMC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2UxMDAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2UxMDAu
Yw0KPiBpbmRleCBiZmFjZjg3N2NhNDAuLmJkZGRkNDMxNWNiYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2UxMDAuYw0KPiBAQCAtMTY3LDggKzE2Nyw4IEBAIE1PRFVMRV9GSVJNV0FSRShG
SVJNV0FSRV9EMTAxUyk7DQo+IE1PRFVMRV9GSVJNV0FSRShGSVJNV0FSRV9EMTAyRSk7DQo+IA0K
PiAgc3RhdGljIGludCBkZWJ1ZyA9IDM7DQo+IC1zdGF0aWMgaW50IGVlcHJvbV9iYWRfY3N1bV9h
bGxvdyA9IDA7DQo+IC1zdGF0aWMgaW50IHVzZV9pbyA9IDA7DQo+ICtzdGF0aWMgaW50IGVlcHJv
bV9iYWRfY3N1bV9hbGxvdzsNCj4gK3N0YXRpYyBpbnQgdXNlX2lvOw0KPiAgbW9kdWxlX3BhcmFt
KGRlYnVnLCBpbnQsIDApOw0KPiAgbW9kdWxlX3BhcmFtKGVlcHJvbV9iYWRfY3N1bV9hbGxvdywg
aW50LCAwNDQ0KTsgIG1vZHVsZV9wYXJhbSh1c2VfaW8sDQo+IGludCwgMDQ0NCk7DQo+IC0tDQo+
IDIuNDMuMA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+DQo=

