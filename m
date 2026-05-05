Return-Path: <netdev+bounces-284229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMR5FzCK+Wnh9gIAu9opvQ
	(envelope-from <netdev+bounces-284229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C94C71A1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 08:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADEEC30091EA
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1323C3439;
	Tue,  5 May 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJfkUmny"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C443B6C19;
	Tue,  5 May 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961513; cv=fail; b=ax2v3PxLQB/2uEqQcgyfi74vLGHNnxwi6FhtjE7MyxQ5nFhpzZMMhrsx9Ldiw46xyruK3rDTkUcDLZRkV4/to0TJbickKtWlOpW3/hxj4tAkzGgbXE3365+Y3Ezm58zTFh3XaBYg/3P2wj6sGMhA7klhAPzYdrob0X8D6aXLIAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961513; c=relaxed/simple;
	bh=eGMNYbNb6rw7WZkzuP+JN8ead/dF55E1eSjPqmbj1MA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=St7SFqH8aZCotPRJ4OiLqa0MgiB9rWAa2ZQ4Ra7hGBVP434tAIAnmSZNCk/lDrpVLQNOu1nOcA9Uek47bvGyOQSQiOCeBIAAd0ZifCXjbjswqZjs9hWTQjiTz+HelckJIorED1IgioVnkuMSxcWMeJrxXorOewmbO2w9Ffk1REU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJfkUmny; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777961510; x=1809497510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGMNYbNb6rw7WZkzuP+JN8ead/dF55E1eSjPqmbj1MA=;
  b=nJfkUmnyP0zzysLPBJRaKCozeHe/j6wckt8+TgURTSTCsQW3ha6sa2SD
   OuCX7l/dXg8Y1Mr89mzreTDQMOQY3ZV/JRrzV0PJDJ7DhauUCwhcLvyQG
   zVPjxUTFDLRogdUB8WBsE8JM/PiEUWDryYODMIUlDZCCyUL2GysOO8KaA
   b65TdVjn/ytoAKJ/xh+LDh9PDTHxw4ZkJYlAE9rZyooiBP9W2LlSmGz53
   ZDw+GnLlgjzHOD/Cdjcd7YfQftFjpoCEtGwCOdIUFS3OQcx2T1ZtFwRgZ
   V81x6O0SKs/WS6Kb9rRcNVmteCChYSgdMh/UKDOn8gIrgahHil4HB7Hp0
   w==;
X-CSE-ConnectionGUID: 0qtcnM/EQhS15j2iyk98jA==
X-CSE-MsgGUID: O0KrDz0mSx6HA3yH+0zIng==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78873031"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78873031"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:11:49 -0700
X-CSE-ConnectionGUID: x8ZbY53oQsqQZhLDxYjaVw==
X-CSE-MsgGUID: fArr7SrhTX2EI14aFU1Ksg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240020026"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:11:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 23:11:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 23:11:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 23:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XD/rGfzbGUgcFoIIBl7jeO5RQEW9rqZDJFJ8UgNrAC2eLrRsq9flcttb8IvlJO5P+0jKAysFYj8jE59LaqiCFnzjwBjK3eCzkQB8Wy4DWxAPTqhdwAyLEbxKfr23ZEqLAU5yBR9m2HA5nrtJF2t/unKUpsE4k0J0JcsQov9a0Avmg5sLM46VQdKTBHTkhqourUeGQcZRrD6APJ2ac2G6uD0cBi/YdEc9lH7cj/VcrLid4Ymla96eL0HANheMn01VnCDCYyhKZ4auieXSpxB+D011S4bePAb3oqF2PiNrI+SxXk2Kw5X+25PlTmOJTKIcGlg99+aoWkDuu0SS5uRDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGMNYbNb6rw7WZkzuP+JN8ead/dF55E1eSjPqmbj1MA=;
 b=mGSS0cWrus5JitcpwOpEyOzxwdc6fwaZQWxHs/vcW4ikt5hL28BOW9U1OLb4mX+NjrJUHY1H4Hows7wQfckHPKHcbxITVh/iNVSTEZlcKVMAH6v16gxjxC4bUk29qGZJXR/DtQC4UlJs0iVgO+yI0fTKgCUWCJQBYksUoAzmd1hagzJ/9vimtqfLQYm8Cq+wVgipZ0qCqggWSsTL/gNGZyjhtjMlaO/+epsXFCvSWE1I9pmobxgqABTzhVEKTPCIdLllH3GsCANPGpHIIP26ElW9sBgmJ++5gN+qQmIA6wZTwRqULHUZf4riUZ+ZVz/AZ2Hmt3DiGnr7Y+UK9mB0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:11:44 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:11:44 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nitka, Grzegorz"
	<grzegorz.nitka@intel.com>, "Vecera, Ivan" <ivecera@redhat.com>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Mekala, SunithaX D"
	<sunithax.d.mekala@intel.com>
Subject: RE: [PATCH net-next 07/15] ixgbe: E610: add ACI dynamic debug
Thread-Topic: [PATCH net-next 07/15] ixgbe: E610: add ACI dynamic debug
Thread-Index: AQHc2TUopRqpVuTcFEWz9EAyocU0yLX7kIYAgALpGoCAAH3hEA==
Date: Tue, 5 May 2026 06:11:44 +0000
Message-ID: <PH7PR11MB59836EE9D046D0E2AB187110F33E2@PH7PR11MB5983.namprd11.prod.outlook.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-7-6f27ae1cd073@intel.com>
 <20260503020636.4114758-1-kuba@kernel.org>
 <7505d7e3-4686-457e-a79e-776c634e9edb@intel.com>
In-Reply-To: <7505d7e3-4686-457e-a79e-776c634e9edb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|CY8PR11MB7338:EE_
x-ms-office365-filtering-correlation-id: 3f952ab9-1288-4659-53f3-08deaa6d2ec6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: DViUI/QspT39sFLl43WlKNa7ohjTreqHHncahci8mJSyBbzm5jmu1sA164WjsQLCX+KRpJeY34ma2C96uDKd8zz4mi4wvnrDgdc2P5feLleatTqAM17x8/RV3lGUFIK9bA5lokuhcTKQXBjuzdz/P+gtJSt7SB6CVhp3K4rJWtussIMEv4DEmoHbPYZEvOM9EqivOpWR5KTabVHqh9YFSZH3vS95B91FYp0PqwcjEIPvTc1MMZmQMbMeag+h4c6QQXqWrdNqqShH7/0oCLzGgsPli9THs/pxPzxvsBNZoM2f7VyFRbva67N+8l5A9EsVz3yZJrYEl2A+Cc60BPEqW0y63wjp08MXRgespaU3JjSNmlotXd4gTIHNX3D/0mQyCIOn8ZMTu7RzPGQGHQedz7R6+xA1kZMAukKsT5UGzypBY5lgz1Vn+l4vvAsnYrACQY4TiG64ImPFRKkq+AjphBNZYQ0Qi6T52Io9u4Q/J4DSWVuJPNplaCGBJCzS+Xg/JTwTncsImNSBJaZP3P1uHPSrd5xwr9AFNlTz5zjSQACZmleIc/8cKV0O+QgdqWStESkRA0XiW8kUna+is91n7H9y8gjyNl2/IqipaBaVGaKrzneyGNhP9pQKt/bZtCQuK4kETORTCloGzRxO8t1lOdDtySlo8XCtmOujRmUa1DcnuJptRoF18/ntLN01oZS/ADWb7ojUkMvtgEdcvN9YoBE+zBgf3u5HH32Bu3n/5V7dGTmDuzGhcql7Qs9GNhiN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2oxWlNUbFhaeTNKbnQ5eFhRL3I4alNUYXNnWklJZkxaakQ3eTZjMEdOVzla?=
 =?utf-8?B?VnBVaFNYdVc0NUVlNzhvdytkVjR2Q2VFMDgwRGpOaWNrbDdVUFpLdjBDTG5J?=
 =?utf-8?B?RnY3UExqM1dHMWNvUmdlK0xTbGUxWjBwQVNOakI3VjFxaGFNQnE1UUpBRDl2?=
 =?utf-8?B?V2lKU0NRL1hzTndhVXZ1Y3NIMEpZY29sRVpaSGlhdW51U1FRYW91OTM0dHUr?=
 =?utf-8?B?N2N3NERnTXRISGwzUmVvdFI4d0tRRmgvMDdYVzB4ZXVvYVY0SE41TkNNdzhh?=
 =?utf-8?B?ejVBR0J3b2cvSDFEbzN0YVlnZDZiN3FCeEFpTkxqN1IxcENtOEQ2UHFSTVF1?=
 =?utf-8?B?VmF3RVZZZVBSUWdkblZqMHBnRHZmQXpPVmRXNUVIQjY1cHdxVk9HUHZQc1ZH?=
 =?utf-8?B?OUVNSkU5SjliQU5ZeWs3eUhBUWtUeERJbmpISStHbXhmeGRpQ2lseUUwQ0Nz?=
 =?utf-8?B?VldZdkU5QUpOV3RwOUg3TGphWnB2bmlMRGorKzMybmhHY09HK2RjVnVBZG80?=
 =?utf-8?B?cTVBU3gwQi9mS0tZZ0hXYmN2Ym5TR1ErV1pqS0NMQm5tS3dJcEJLZXFqSFQw?=
 =?utf-8?B?dXpPQVFkWExTc1ROaEpxWHMyYmcyYmpOcUNPSUV0QWVaVVg4bDBuWHNNRUdt?=
 =?utf-8?B?N240V2NEZ1FKYytVV2lvOVh5WWlPdXIyc1NkVk0vdnhQRE43OVI1Tkl2NFpw?=
 =?utf-8?B?Q21kQ0dRb2JXOGtEb3F4STBtSGtqazZVdHcvRFRuMnNkUUZ5VEdaMFZHUjg3?=
 =?utf-8?B?RnBZVEdvMEdTL3BBK21SWkNSMW05MDFLMEV2L1hmUHFYYTVLejZNS08yZGdK?=
 =?utf-8?B?UEtZRmlQWWJib2NTaFllYUo0b3UzSUNIK1c3SFRTb01QWEZqNmRqbldoRkN5?=
 =?utf-8?B?SUFsS1A0ekE5eXZveDV0VjVwemNiTWNTQllJcHBrclNJYVFMYkJqTlYzRGhs?=
 =?utf-8?B?eTJDdHA3OU1TblBxZnFDT1BGNEU4YUxtdVVGZ0xSbWhXTCs3MThjelo2VTAv?=
 =?utf-8?B?bE9oNWk4KyszOTJ1TFpKV1NrS1Fydk4wNGpzalZrS1p5b0xqTlh6MCtKNHJC?=
 =?utf-8?B?U3d1OWNHNVZnMHYrTWhabS9FakJsNVVqcFlEanpCb0FGWTdyMkkvTTA4Z1or?=
 =?utf-8?B?Z2hLQ1NDSlNxMnNnNjRVdjNLa3B4R25oWVRLM2V4RGZQNVBFa3lxZGNqUm5J?=
 =?utf-8?B?L1piVTlnQnF2ejh1YzZXSGttaEdHVHA4dzZuVHhDVElTemcxWkIwdjlDMHNB?=
 =?utf-8?B?U0tWbkZaMkVKeGo5eGZZWnl5WXgwRXBjS2VJUlJ1NWRWV3c4UzV2dEtueCtC?=
 =?utf-8?B?WWNoT3hrY1NnTE42Q3YxUEJWQWdBWjVhdUJSSVNCTWcrR3VVUExoWmFGekF4?=
 =?utf-8?B?QmRMSjlqUk9EdWs0YXdGYnE0VVFKOURveFRpeU5SeEFtRlVuMmNrbFNFSW5k?=
 =?utf-8?B?NjdFd0dPVEJISEdjbENVL0RIeHVMWjVNdFBkQ3pmQmtQbDlEWVNoQnNCOU9r?=
 =?utf-8?B?OERVNlFiMUdFS0Zza2plVitlTGVkelcwY2EzNUN2NEVuVWFxRHBhaStwdWJs?=
 =?utf-8?B?eVNNVjByeVZETnhXZFJMcWhDczBCbVJQT0tqeEUvOVdFTm9qcGpoVWdNbjZG?=
 =?utf-8?B?QzJwNDE3K0lSSjA3SFhYWnRUVEVnQXdLWUduZWxjakJwY3ZJSG5FR2UrZjA0?=
 =?utf-8?B?ekNQSEw1MGNscU5HbTdtS254NzJFLzdiWUgzZDhZQXZqcFJnRWRCNmZUajVS?=
 =?utf-8?B?WjJyTi95MXhKWVdmbEhkd0hBTmYrYTdhd0ZFa1lOb3cvd1F0Z2tYTkhNZkhp?=
 =?utf-8?B?M1kzbkpVUm9FMjhkdG0yZTlRSUN6aDBWa05DNWJhWlNjbHB0VGc1ZnJQSnZp?=
 =?utf-8?B?ak45cVluakpnTU94UXZrOTgxcEUzeG5uK3VydE1IUFd1Skgyc3c5YkorVGpO?=
 =?utf-8?B?a1VSTlJDZTBaQmJ3MlkrNUNQRUw5VSt4V280YWJLN1E1RHZhMmxuaHRBbStx?=
 =?utf-8?B?dnpkSHJVaEd5RGg5WXZoclFqcmJFUUFMeHY3eGtYRUFyTCt3eUJnaGoxVEZt?=
 =?utf-8?B?bGpicGlGTkREUG80aHB0M2hEczhZUjlvQ0xHVTZYYmlwZy9ueFg4amhDbEFn?=
 =?utf-8?B?Q1pKSDZjUEMxUmtKNkJyM1Iydkc5ejkxWHdNQUFyaVl0S3MxbnI4SkFZeTVN?=
 =?utf-8?B?OGE0YVBpYUFqSEF4OVhXQUpacmZSZk8rVlhZQitSdHozbWVSS0F2ZUFuSkYz?=
 =?utf-8?B?OXJaaXNPa1Q5UFBqN2pIZkx0TDVCenVoTlk4TEExQ2tqZVlmOGpsdEV4QlZm?=
 =?utf-8?B?UWNhdTZUdGlPdWloaHNLOWVmbFhYNWxmei8zS1JITHBOMXhvVHg3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TOxXD06odcVB5S0GDcSyag6tgESxGedP/GGLwEHQD3ORmd8N768fYER7uPf9axsE0lqlHvda/v2w1Z5HBUqwCstXwbq8I6NnRXBlBwLCeGij/Wp9sGX6AV1sOayrlUwahhr6SI+I19Smb1IV2X1hQk6m0M/J1iK2HLDS0HPUXH6TGWT9n9gWNA8O1ikhUmQvQ6qdIHPPtrf4jONdRsorXiDpBx60uNdMdDX3SCvyi6IUtmywQ/Oh7jB9lRVGGzYyVHKCf5IZFhuMFUxmOuZ5JpflA15vVX2/K9DLxi6u3qjuU452v4AiiVnw1ws+NZ4SMNFv+cR0U5ljjtODOVKijQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f952ab9-1288-4659-53f3-08deaa6d2ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 06:11:44.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OvD3k4OB9cMAHzjFgSq1EwuFB5Eu0u5FgfC159oVPBmUpYdO4zF1pKZ8YYfv9i3vtl/KNKHRRpTkh70fc3dclUtuElJnegUD8k4dWc5ySo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1B9C94C71A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284229-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS2VsbGVyLCBKYWNvYiBFIDxqYWNv
Yi5lLmtlbGxlckBpbnRlbC5jb20+IA0KPlNlbnQ6IFR1ZXNkYXksIE1heSA1LCAyMDI2IDEyOjMz
IEFNDQo+VG86IEt3YXB1bGluc2tpLCBQaW90ciA8cGlvdHIua3dhcHVsaW5za2lAaW50ZWwuY29t
Pg0KPkNjOiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29t
PjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBn
b29nbGUuY29tOyBwYWJlbmlAcmVkaGF0LmNvbTsgTG9iYWtpbiwgQWxla3NhbmRlciA8YWxla3Nh
bmRlci5sb2Jha2luQGludGVsLmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7IG1pY2hhbC5zd2lhdGtv
d3NraUBsaW51eC5pbnRlbC5jb207IEphZ2llbHNraSwgSmVkcnplaiA8amVkcnplai5qYWdpZWxz
a2lAaW50ZWwuY29tPjsgTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRlbC5jb20+OyBW
ZWNlcmEsIEl2YW4gPGl2ZWNlcmFAcmVkaGF0LmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeiA8
YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwgPGFudGhv
bnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgV2Vncnp5biwgU3RlZmFuIDxzdGVmYW4ud2Vncnp5bkBp
bnRlbC5jb20+OyBLd2FwdWxpbnNraSwgUGlvdHIgPHBpb3RyLmt3YXB1bGluc2tpQGludGVsLmNv
bT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IHBtZW56ZWxAbW9sZ2VuLm1wZy5kZTsgTWVrYWxhLCBTdW5pdGhhWCBEIDxzdW5pdGhheC5kLm1l
a2FsYUBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAwNy8xNV0gaXhn
YmU6IEU2MTA6IGFkZCBBQ0kgZHluYW1pYyBkZWJ1Zw0KPg0KPk9uIDUvMi8yMDI2IDc6MDYgUE0s
IEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3
IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1hbiBzZW5kaW5nIHRoaXMgDQo+PiBlbWFpbCBoYXMgY29u
c2lkZXJlZCB0aGUgQUkgcmV2aWV3IHZhbGlkLCBvciBhdCBsZWFzdCBwbGF1c2libGUuDQo+PiAt
LS0NCj4+IGl4Z2JlOiBFNjEwOiBhZGQgQUNJIGR5bmFtaWMgZGVidWcNCj4+IA0KPj4gVGhpcyBj
b21taXQgZW5hYmxlcyBkeW5hbWljIGRlYnVnZ2luZyBvZiB0aGUgQWRtaW4gQ29tbWFuZCBJbnRl
cmZhY2UgDQo+PiAoQUNJKSBmb3IgdGhlIGU2MTAgYWRhcHRlciwgYWxsb3dpbmcgQUNJIGNvbW1h
bmRzIGFuZCBkZXNjcmlwdG9yIA0KPj4gZGV0YWlscyB0byBiZSBwcmludGVkIGludG8gdGhlIGtl
cm5lbCBsb2cuDQo+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaXhnYmUvaXhnYmVfZTYxMC5jIA0KPj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aXhnYmUvaXhnYmVfZTYxMC5jDQo+Pj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aXhnYmUvaXhnYmVfZTYxMC5jDQo+Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aXhnYmUvaXhnYmVfZTYxMC5jDQo+PiANCj4+IFsgLi4uIF0NCj4+IA0KPj4+IEBAIC0xMDYsOCAr
MTg1LDEyIEBAIHN0YXRpYyBpbnQgaXhnYmVfYWNpX3NlbmRfY21kX2V4ZWN1dGUoc3RydWN0IGl4
Z2JlX2h3ICpodywNCj4+PiAgCQlpZiAoZGVzYy0+ZmxhZ3MgJiBjcHVfdG9fbGUxNihMSUJJRV9B
UV9GTEFHX1JEKSkgew0KPj4+ICAJCQlmb3IgKGkgPSAwOyBpIDwgYnVmX3NpemUgLyA0OyBpKysp
DQo+Pj4gIAkJCQlJWEdCRV9XUklURV9SRUcoaHcsIElYR0JFX1BGX0hJQkEoaSksICgodTMyICop
YnVmKVtpXSk7DQo+Pj4gLQkJCWlmIChidWZfdGFpbF9zaXplKQ0KPj4+ICsJCQlpeGdiZV9hY2lf
ZGVidWcoaHcsIGRlc2MsIGJ1ZiwgYnVmX3NpemUpOw0KPj4+ICsJCQlpZiAoYnVmX3RhaWxfc2l6
ZSkgew0KPj4+ICAJCQkJSVhHQkVfV1JJVEVfUkVHKGh3LCBJWEdCRV9QRl9ISUJBKGkpLCBidWZf
dGFpbCk7DQo+Pj4gKwkJCQlpeGdiZV9hY2lfZGVidWcoaHcsIGRlc2MsICZidWZfdGFpbCwNCj4+
PiArCQkJCQkJYnVmX3RhaWxfc2l6ZSk7DQo+Pj4gKwkJCX0NCj4+PiAgCQl9DQo+Pj4gIAl9DQo+
PiANCj4+IERvZXMgdGhpcyByZXN1bHQgaW4gcmVkdW5kYW50IG91dHB1dCBiZWluZyBwcmludGVk
IHRvIHRoZSBrZXJuZWwgbG9nPw0KPj4gDQo+PiBXaGVuIGJ1Zl90YWlsX3NpemUgaXMgbm9uLXpl
cm8sIGl4Z2JlX2FjaV9kZWJ1ZygpIGlzIGNhbGxlZCB0d2ljZTogDQo+PiBvbmNlIGZvciB0aGUg
ZnVsbCBidWZmZXIsIGFuZCBhIHNlY29uZCB0aW1lIGZvciBqdXN0IHRoZSB0YWlsLiBTaW5jZSAN
Cj4+IGl4Z2JlX2FjaV9kZWJ1ZygpIHByaW50cyB0aGUgZnVsbCBDUSBDTUQgZGVzY3JpcHRvciBk
ZXRhaWxzIGVhY2ggdGltZSwgDQo+PiB0aGlzIGFwcGVhcnMgdG8gcHJpbnQgdGhlIGRlc2NyaXB0
b3IgaGVhZGVycyB0d2ljZSBhbmQgZnJhZ21lbnQgdGhlIGJ1ZmZlciBvdXRwdXQuDQo+PiANCj4+
IFsgLi4uIF0NCj4+IA0KPj4+IEBAIC0xODMsMTAgKzI3OCwxMyBAQCBzdGF0aWMgaW50IGl4Z2Jl
X2FjaV9zZW5kX2NtZF9leGVjdXRlKHN0cnVjdCBpeGdiZV9odyAqaHcsDQo+Pj4gIAlpZiAodmFs
aWRfYnVmKSB7DQo+Pj4gIAkJZm9yIChpID0gMDsgaSA8IGJ1Zl9zaXplIC8gNDsgaSsrKQ0KPj4+
ICAJCQkoKHUzMiAqKWJ1ZilbaV0gPSBJWEdCRV9SRUFEX1JFRyhodywgSVhHQkVfUEZfSElCQShp
KSk7DQo+Pj4gKwkJaXhnYmVfYWNpX2RlYnVnKGh3LCByYXdfZGVzYywgYnVmLCBidWZfc2l6ZSk7
DQo+Pj4gIAkJaWYgKGJ1Zl90YWlsX3NpemUpIHsNCj4+PiAgCQkJYnVmX3RhaWwgPSBJWEdCRV9S
RUFEX1JFRyhodywgSVhHQkVfUEZfSElCQShpKSk7DQo+Pj4gIAkJCW1lbWNweShidWYgKyBidWZf
c2l6ZSAtIGJ1Zl90YWlsX3NpemUsICZidWZfdGFpbCwNCj4+PiAgCQkJICAgICAgIGJ1Zl90YWls
X3NpemUpOw0KPj4+ICsJCQlpeGdiZV9hY2lfZGVidWcoaHcsIHJhd19kZXNjLCAmYnVmX3RhaWws
DQo+Pj4gKwkJCQkJYnVmX3RhaWxfc2l6ZSk7DQo+Pj4gIAkJfQ0KPj4+ICAJfQ0KPj4gDQo+PiBD
YW4gdGhpcyByZWFkIHVuaW5pdGlhbGl6ZWQgbWVtb3J5IGZyb20gdGhlIGJ1ZmZlcj8NCj4+IA0K
Pj4gQXQgdGhlIHBvaW50IGl4Z2JlX2FjaV9kZWJ1ZyguLi4sIGJ1ZiwgYnVmX3NpemUpIGlzIGNh
bGxlZCwgdGhlIGxvb3AgDQo+PiBoYXMgb25seSBwb3B1bGF0ZWQgdGhlIDQtYnl0ZSBhbGlnbmVk
IGNodW5rcyBvZiB0aGUgYnVmZmVyLiBUaGUgDQo+PiB0cmFpbGluZyBieXRlcyBhdCB0aGUgZW5k
IG9mIHRoZSBidWZmZXIgYXJlIG5vdCBwb3B1bGF0ZWQgdW50aWwgdGhlIA0KPj4gbWVtY3B5KCkg
b2NjdXJzIGxhdGVyIGluIHRoZSBibG9jay4gQmVjYXVzZSBpeGdiZV9hY2lfZGVidWcoKSBjb25z
dW1lcyANCj4+IGJ1Zl9zaXplIGJ5dGVzLCBpdCBsb29rcyBsaWtlIGl0IHdpbGwgcmVhZCBhbmQg
bG9nIHVuaW5pdGlhbGl6ZWQgDQo+PiB0cmFpbGluZyBtZW1vcnkgKHBvdGVudGlhbGx5IGZyb20g
dGhlIGtlcm5lbCBzdGFjaykuDQo+PiANCj4+IEFsc28sIHNpbWlsYXIgdG8gdGhlIHRyYW5zbWl0
IHBhdGgsIHRoaXMgY2FsbHMgaXhnYmVfYWNpX2RlYnVnKCkgYSANCj4+IHNlY29uZCB0aW1lIG9u
ICZidWZfdGFpbCwgd2hpY2ggd2lsbCBwcmludCB0aGUgZGVzY3JpcHRvciBoZWFkZXJzIGFnYWlu
Lg0KPj4gDQo+PiBDb3VsZCB3ZSBtb3ZlIGEgc2luZ2xlIGl4Z2JlX2FjaV9kZWJ1ZyguLi4sIGJ1
ZiwgYnVmX3NpemUpIGNhbGwgdG8gdGhlIA0KPj4gZW5kIG9mIHRoZSBibG9jaywgYWZ0ZXIgdGhl
IGVudGlyZSBidWZmZXIgaW5jbHVkaW5nIHRoZSB0YWlsIGhhcyBiZWVuIGZ1bGx5IHdyaXR0ZW4/
DQo+DQo+UGlvdHIsDQo+DQo+UGxlYXNlIHJldmlldyB0aGlzIHJlcG9ydCBhbmQgc3VibWl0IGEg
bmV3IHZlcnNpb24gb2YgdGhpcyBwYXRjaCB0byBJbnRlbCBXaXJlZCBMQU4uDQo+DQo+V2hpbGUg
eW91IGFyZSBhdCBpdCwgcGxlYXNlIHJldmlldyB0aGUgZm9sbG93aW5nIHJlcG9ydCBmcm9tIGEg
cnVuIG9mIHNhc2hpa28gSSBkaWQgbXlzZWxmIHVzaW5nIGNsYXVkZToNCldpbGwgdXBkYXRlLiBU
aGFuayB5b3UuDQpQaW90cg0KDQo+DQo+PiBjb21taXQgMTk4ZWMwMzg5Yzc1NzEyNWQ5MDc5NjQ3
YTZjOGFiYTM0YmEyOTA0OA0KPj4gQXV0aG9yOiBQaW90ciBLd2FwdWxpbnNraSA8cGlvdHIua3dh
cHVsaW5za2lAaW50ZWwuY29tPg0KPj4gaXhnYmU6IEU2MTA6IGFkZCBBQ0kgZHluYW1pYyBkZWJ1
Zw0KPj4gVGhpcyBwYXRjaCBlbmFibGVzIGR5bmFtaWMgZGVidWcgb2YgdGhlIEFkbWluIENvbW1h
bmQgSW50ZXJmYWNlIChBQ0kpIA0KPj4gZm9yIHRoZSBFNjEwIGFkYXB0ZXIsIGFkZGluZyBkZXNj
cmlwdG9yIGFuZCBidWZmZXIgaGV4IGR1bXBzIHZpYSB0aGUgDQo+PiBzdGFuZGFyZCBkeW5kYmcg
aW5mcmFzdHJ1Y3R1cmUsIHBsdXMgaHdfZGJnKCkgY2FsbHMgb24gZXJyb3IgcGF0aHMuDQo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX2U2MTAu
YyANCj4+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX2U2MTAuYw0K
Pj4+IGluZGV4IDY2NWE5ODEzZTI1MS4uYjY4NjYzNmJlYjkzIDEwMDY0NA0KPj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX2U2MTAuYw0KPj4+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX2U2MTAuYw0KPj4gWyAuLi4gXQ0K
Pj4+IEBAIC0xNDcsNiArMjMwLDcgQEAgc3RhdGljIGludCBpeGdiZV9hY2lfc2VuZF9jbWRfZXhl
Y3V0ZShzdHJ1Y3QgaXhnYmVfaHcgKmh3LA0KPj4+IAkJCXJhd19kZXNjW2ldID0gSVhHQkVfUkVB
RF9SRUcoaHcsIElYR0JFX1BGX0hJREEoaSkpOw0KPj4+IAkJCXJhd19kZXNjW2ldID0gcmF3X2Rl
c2NbaV07DQo+Pj4gCQl9DQo+Pj4rCQlpeGdiZV9hY2lfZGVidWcoaHcsIHJhd19kZXNjLCBOVUxM
LCAwKTsNCj4+PiAJfQ0KPj4gWyAuLi4gXQ0KPj4+IAkvKiBIYW5kbGUgdGltZW91dCBhbmQgaW52
YWxpZCBzdGF0ZSBvZiBISUNSIHJlZ2lzdGVyICovDQo+Pj4tCWlmIChoaWNyICYgSVhHQkVfUEZf
SElDUl9DKQ0KPj4+KwlpZiAoaGljciAmIElYR0JFX1BGX0hJQ1JfQykgew0KPj4+KwkJaHdfZGJn
KGh3LCAiZXJyb3I6IEFkbWluIENvbW1hbmQgMHglWCBjb21tYW5kIHRpbWVvdXRcbiIsDQo+Pj4r
CQkgICAgICAgbGUxNl90b19jcHUoZGVzYy0+b3Bjb2RlKSk7DQo+Pj4gCQlyZXR1cm4gLUVUSU1F
Ow0KPj4+Kwl9DQo+PiBTaW5jZSByYXdfZGVzYyBpcyBkZWNsYXJlZCBhcyBhIGNhc3Qgb2YgZGVz
YzoNCj4+ICAgICB1MzIgKnJhd19kZXNjID0gKHUzMiAqKWRlc2M7DQo+PiBhbmQgdGhlIHN5bmMg
cmVzcG9uc2UgcmVhZCBsb29wIG92ZXJ3cml0ZXMgcmF3X2Rlc2NbXSAoYW5kIHRodXMgZGVzYykg
DQo+PiB3aXRoIGZpcm13YXJlIHJlc3BvbnNlIGRhdGEsIGNvdWxkIGxlMTZfdG9fY3B1KGRlc2Mt
Pm9wY29kZSkgaGVyZSANCj4+IHByaW50IHRoZSByZXNwb25zZSBvcGNvZGUgcmF0aGVyIHRoYW4g
dGhlIG9yaWdpbmFsIGNvbW1hbmQgb3Bjb2RlPw0KPj4gVGhlIGxvY2FsIHZhcmlhYmxlIG9wY29k
ZSBhbHJlYWR5IGhvbGRzIHRoZSBvcmlnaW5hbCB2YWx1ZSBzYXZlZCANCj4+IGVhcmxpZXIgdmlh
Og0KPj4gICAgIG9wY29kZSA9IGxlMTZfdG9fY3B1KGRlc2MtPm9wY29kZSk7IFdvdWxkIGl0IGJl
IG1vcmUgY29ycmVjdCB0byANCj4+IHVzZSBvcGNvZGUgZGlyZWN0bHkgaW4gdGhpcyBod19kYmco
KSBjYWxsIChhbmQgdGhlIG9uZSBpbiB0aGUgDQo+PiBpbnZhbGlkLXN0YXRlIGNoZWNrIGJlbG93
KT8NCj4+PiBAQCAtMTgzLDEwICsyNzgsMTMgQEAgc3RhdGljIGludCBpeGdiZV9hY2lfc2VuZF9j
bWRfZXhlY3V0ZShzdHJ1Y3QgaXhnYmVfaHcgKmh3LA0KPj4+IAlpZiAodmFsaWRfYnVmKSB7DQo+
Pj4gCQlmb3IgKGkgPSAwOyBpIDwgYnVmX3NpemUgLyA0OyBpKyspDQo+Pj4gCQkJKCh1MzIgKili
dWYpW2ldID0gSVhHQkVfUkVBRF9SRUcoaHcsIElYR0JFX1BGX0hJQkEoaSkpOw0KPj4+KwkJaXhn
YmVfYWNpX2RlYnVnKGh3LCByYXdfZGVzYywgYnVmLCBidWZfc2l6ZSk7DQo+Pj4gCQlpZiAoYnVm
X3RhaWxfc2l6ZSkgew0KPj4+IAkJCWJ1Zl90YWlsID0gSVhHQkVfUkVBRF9SRUcoaHcsIElYR0JF
X1BGX0hJQkEoaSkpOw0KPj4+IAkJCW1lbWNweShidWYgKyBidWZfc2l6ZSAtIGJ1Zl90YWlsX3Np
emUsICZidWZfdGFpbCwNCj4+PiAJCQkgICAgICAgYnVmX3RhaWxfc2l6ZSk7DQo+Pj4rCQkJaXhn
YmVfYWNpX2RlYnVnKGh3LCByYXdfZGVzYywgJmJ1Zl90YWlsLA0KPj4+KwkJCQkJYnVmX3RhaWxf
c2l6ZSk7DQo+Pj4gCQl9DQo+Pj4gCX0NCj4+IFdoZW4gYnVmX3NpemUgaXMgbm90IDQtYnl0ZSBh
bGlnbmVkLCBpeGdiZV9hY2lfZGVidWcoKSBpcyBjYWxsZWQgd2l0aCANCj4+IHRoZSBmdWxsIGJ1
Zl9zaXplIGJlZm9yZSB0aGUgdGFpbCBieXRlcyBoYXZlIGJlZW4gcmVhZCBmcm9tIGhhcmR3YXJl
IA0KPj4gYW5kIG1lbWNweSdkIGludG8gYnVmLiBUaGUgaGV4IGR1bXAgd2lsbCBzaG93IHN0YWxl
IGNvbnRlbnQgZm9yIHRoZSANCj4+IGxhc3QgMS0zIGJ5dGVzIG9mIHRoZSBidWZmZXIuDQo+PiBT
aG91bGQgdGhlIGl4Z2JlX2FjaV9kZWJ1ZygpIGNhbGwgYmUgbW92ZWQgYWZ0ZXIgdGhlIHRhaWwg
bWVtY3B5IHNvIA0KPj4gdGhhdCBpdCBkdW1wcyB0aGUgY29tcGxldGUgcmVzcG9uc2U/DQo=

