Return-Path: <netdev+bounces-275034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJsaMPS6z2kd0AYAu9opvQ
	(envelope-from <netdev+bounces-275034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:04:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92503944C3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A507A301E20D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FA392831;
	Fri,  3 Apr 2026 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0LII6uB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E83B4E80
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221247; cv=fail; b=uiSrpGrUCoZNBVN8h4PmrA1FrhbLE7U+XE8eSr8SOyb6Xw3wEIAjCsogad9e4EJtib+dMKeV+cld3o79ktphVjflZyGiLNWewggGZLaI3G3xS9Oy1a4RRPWUbTonTOnvLCwlOBr/iOBU+AOuta/kwfcDqAgVvtMuWgZcUGub/QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221247; c=relaxed/simple;
	bh=0ZHQjXNNWXgtmbInTkxeW+aF4jMwqG5UZLwNIcsi1Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXUlFNRGxNS8tMq+JeKtgjIlueL0ravEKrcJaBqqRbRVTMNMEE4S594jeT9uQa9Ud+edT0KPTiXdgdnq8y8FuYaR/pAiMgLpaCJf2mxvaCUeZG45h1oNH3cW7BmfV0HcFfL5Oo2BR2ZmeYSw0Fw4RoWH01uBBeqSFhgPFZ+Cni0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0LII6uB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775221244; x=1806757244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ZHQjXNNWXgtmbInTkxeW+aF4jMwqG5UZLwNIcsi1Ug=;
  b=Q0LII6uBPOh4YXcUYj6YxBEeSLexYcxz+GpoafTh8pZ9+oPvBf5gmblz
   K62HrrU5p7WiP1AFM1KdD3eCldov/H3wCnt8SnfDfqL5km3DJsdeN5ly7
   gxujevjeJdq4PuSEsoSboA9mFaU2CKUj5D6iuwpQbX9pCJC0pLzK5NeGG
   l879+PR5D4hqdo2kBo4FfXORwUmv/mYHeVRjhfBmZWyBUFpoqmg5/Y5eZ
   cVfIiOcaQh5/XNZylb55kHpMfRMND989xY9UK3ZdRT/e3g6dTex0A+v4h
   rFKSxcWGhYKK2+pQDsvajKehZWaHUOa9d7UfFm5iMqU6SC9zWhnMg1+vt
   w==;
X-CSE-ConnectionGUID: 06+9lu4nTEOQDdElxOKFkQ==
X-CSE-MsgGUID: /ptPPsOcSfavtEqvJFba0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="101734561"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="101734561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 06:00:42 -0700
X-CSE-ConnectionGUID: 0R+KU/M6SNmZCmXA7BgLdQ==
X-CSE-MsgGUID: Gp+2ujkXQsWCln50hCFGZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="232175564"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 06:00:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:00:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 06:00:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDkPhNgAJU18U33Y3VHiEb1HZ/JN5luB74p+aNVjwZ2fov/qpVnMDkw02yrU1tSp9fbu1H7eDPNz+8VFCRcVAK4dnwxES3V1dPw0ZUtuOdHt1LS3+kaWdjlRThMr4/5hk6/UiudzK7vcjrFVxo0CEDDKH6RqpufETUS7eya89hmq9iHcTYWH4LZxiQxUPgqziZrGTVlYuOIoPwZv3DlPmJNp+zv0gq2xGuF6afHBjmC0nGSqno9nTozTeRt+ViNo1EC16MIDUDnw3/ywH6OOTkrQXD0xu3SILVm0UVrTY2o1KNhpc5Y708SroSmmUfk21BigIarPwLshaal8t32UCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZHQjXNNWXgtmbInTkxeW+aF4jMwqG5UZLwNIcsi1Ug=;
 b=WAVW9zvzGrvtxJ7xv6xaPq3U03oLHk+HOgrQQ/gRhRys2BDHzW4Vx/0J7lDwbW7f3/MxEahu410+BY07Iuoumd9rU7KRi0hZUYQ/xiJjGglypSaXq0mX4DIf77hM2z1lxdj7GlO0bsiRbDFbG6CoOKOx/eeHl2Ifk/bkBFN8ggy3iARqHD7b5m7tXRA3K31cMhJufkCmx1MHtzmFSm1Vli4dJm2TRz0wPjZvClwoacDEF1fVeLfbXbRBAtze92e8lnb2YKcKYG3hlHzACWHh6guHjEBB/NTr6/HePu03ioPUlgYelCB0rMIrgm9dW+tXsJ0NFKNQtlHXqOeRvaDv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by SA1PR11MB7132.namprd11.prod.outlook.com
 (2603:10b6:806:29e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 13:00:33 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 13:00:33 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>, Thorsten Leemhuis
	<regressions@leemhuis.info>, "Berg, Johannes" <johannes.berg@intel.com>,
	Friend <netdev@vger.kernel.org>, Linux kernel regressions list
	<regressions@lists.linux.dev>
Subject: RE: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Topic: commit 0c4f1c02d27a880b cause a deadlock issue
Thread-Index: AQHcwOon+EXpRGfVfkKIJTxR0EbLd7XJePpigAICbwCAAaZzGYAAFfSAgAAVTuCAAAGWgIAAAuQg
Date: Fri, 3 Apr 2026 13:00:33 +0000
Message-ID: <DM3PPF63A6024A9E931C940F849C60FAF9EA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
 <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <2026040349-chowtime-freeload-5ca4@gregkh>
In-Reply-To: <2026040349-chowtime-freeload-5ca4@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|SA1PR11MB7132:EE_
x-ms-office365-filtering-correlation-id: 29f93185-f881-4a99-2731-08de9180fdc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hsX8+ICNDwRJkjnEW8KBfiT9sFrjWzxHw3ww2LCap0Cgk15+6bMBmDdiuZrvTbtaH8WumReEiGYcbPGgN3QG7OUSB9ac9tjTfxEIeqPHLg+BXcyzpyxkpCBqIUbCu1eBR8JpJKb1ujxehzY7Di8foNxSoW+/Z+BuytJ/WA3plZbYKx5b+wkHV0eZZJ6GVNzaGav4yLgxMH9WLxCiJrDedzSpkK6N/qLIu+MkQVXeYLxMyS1z+Jaxm3JQ0Zib1KE9N5BjZv0z+j3nP91NCMRNAnSW/HHk/+UlH4XeoCiVv3w1txX5vJiXDCQvpt8FNjSF8SYBQjCoqU0gHsKtZCagXLJyxHI5nQlPViWWlv6CzMG/l3oxBW1LXh48p866xe0vfO2uvBaWkHFFmdNRJV8OJxzJXqy5QQf8nvFlSBmor9jiFh0/UaRn3nC/yHQoSFBDd8Gk5Q3n/tYF/bpV1hOJv5NwYTNazqRr3Kn/OPIJWYz9FBEpfpUm//Ec9avMA8CbdyfogmiSUrspMVDdd0ZJRo+w7Y77TP98TuW3Dl/SBeE8dRzlr/KcyjBbaxFnv0VMhvfUquLdw6Yz75eu5m3iJAzzT3in54qSer5NCOU2vQ8WazSGqMEn3g5Oy6nqlaUdFIOzZeyPOSh45W5K0IkWamsuLjD+Vrp97/R+yk5oqplbNOeSwRwVBVDI0//a7kCGJicEXtuwv5l06QNbl9wv3fFGeixw65mhM8YIPpJwA/QRlXxycgRB6z+QDab2DPK7j7qB0RcV5f7vYMik5edlpeTtufcfviOggbuxCHDhq90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3BvOUhsWWdNZ25xOHRxcDB3elBwSGZSMGZVNGdZQ0o4SnVFWmltWExXNllM?=
 =?utf-8?B?Rng1Rjg2K205Q055Si8rTnN4VWJRRXdYTnNsN2FoNUFPcFdXdlZyeGpxZ3pI?=
 =?utf-8?B?VHlCZHhmZzJZYjhhbWFONnl2alR0Vmx3N0svZHN6RjY4bzRqb1V2ejZSa1Jw?=
 =?utf-8?B?K0FMeEhzY1NmUTd3ZEtCWEQzTHhEL0RkR0I5VnJMaXlTSTJjRHkwdFVVdkxl?=
 =?utf-8?B?QnMrUGhDcVNWYkw2Rml5UFNJTGFFak41SGQ2T0sxMUpyNGpUcUVCaE5Ubkdn?=
 =?utf-8?B?VDFRVzlHa1MwSXY4QTloSjI3bXhBcDd0WTlNSFdobkQrUVNmMW9MRmY3RmFn?=
 =?utf-8?B?dTIxZDd1MHRqSVVqbzI4ZWtlY2J1VmF2MTVoaGFiNEk5VG1uZmpXOGZOVXFW?=
 =?utf-8?B?cm1XNGdXcXRrWmdFeTBlWGgzNGZpVFZQVDVEaUQwU0hWQ0JJWEE3bmZuTEN3?=
 =?utf-8?B?K0ZFZGJHM1JyWTBibklRR0lmOU9FKzAvRjcwMmtoK2lqb3pXUzlJUDloV2Q3?=
 =?utf-8?B?dzZtNTNMRElGaXY1QmIxWVBjbTNFcE84NEV0Sm1DTmFCcVE2dWR5QkJJOVRm?=
 =?utf-8?B?OUVEQ1E1REFPbmswQWlEakoyWnk1cG11eHBOSEhjdjlzY3dEVitIN09OVXJp?=
 =?utf-8?B?dG1VVWFDNXNGSEIrdzF3VVhpdkdLT2dGTktheDE2dDZJRXJCaUZDVEJUL3dp?=
 =?utf-8?B?eWpLYkJURlhnYS9wV1BDQzhpZU9pRFVYREM0L1dNWVllVmVkUGxYdDB5ZnZE?=
 =?utf-8?B?NkxXWFpvalU4VU5xc3VtWEpod2hsV2R1TkRFbmNTQVgwS3hUVmVtK1JiMlhI?=
 =?utf-8?B?WjFEMThnczhjNnpqbkZwS0NqSVJsN0RIUFp3WU9JQ21tSjErdlU4eXVBdWY5?=
 =?utf-8?B?bTd6OEdoN1BBMHc1dlRUa09FSDk1UElGWUVGdFdMN3ZsRmFDY2xpRWp3T2hD?=
 =?utf-8?B?SUs2cGFIeW5POUFza1NtZEREbEt3TUJ4amlCVS9vYTRrVURac0RiSmhFcWpT?=
 =?utf-8?B?dFpINlVGNFQ2UHNXdmxuSi92WlBhdXpaZkxSdS9CcVgzK2gzWlVlMFU4SEg0?=
 =?utf-8?B?TWk1T1lIYWhjQmp5YS9Wd1kzdkN3M3VXcmhBSGRsK0p0RXBjNHhubzE3VnQz?=
 =?utf-8?B?UUNXVzdRMlFmOXovK0FlUVVjSzRkSDVZanpVUmxoWTRNWVhFWWxvaVdQQS9r?=
 =?utf-8?B?dFFyaWV2dFdPYmlEOU92SUFya1JaWU1sQjFtZlRjZDdkZVlaamM3elVvSjJV?=
 =?utf-8?B?Z3FFWEMrd2JsT2RDZmgvMUx0aUFQMUk0ZXJSSHVPeXp1ckVRYW5oTXY4VTJj?=
 =?utf-8?B?WFkxQ2V4NUlNUlpveTZxSXhlMjdSN0lJRVhBbEdpMzJWZ04zRkVMcEdDaWtj?=
 =?utf-8?B?Y0NzTjlTR1kvcDVIZWorcCs5RDUxS04vNzg0eUUwbDUvOHk3dWRNWk1Ta3Nh?=
 =?utf-8?B?THZ3S05UZURFRmdQaWNzS3V4QnMzNWhvOFp4MStWdVJkQ210UlBmVnpvbjlZ?=
 =?utf-8?B?TG5BSE44ZUJpTWlkWFFHUStQQzFMVlFoQ0w3MldleTdSMFNBcUlML0lsbkxN?=
 =?utf-8?B?a3BJWW13OTkvV3ZEWTlDSDc4QmMyNDdBbmhGbFVCalBMNjBpY21FSnFlT1M5?=
 =?utf-8?B?VjB4aFRTeURhVFVaaWRkcmJGK2VDVFlEU2w1T0RaenpRb0NtTCtDbEFTOTEr?=
 =?utf-8?B?Rkx5NWRyNmNuTTZ4eDc5aXpkQzdobGx1THJTVUI5YmVhd3lDTnZKaXpldGVU?=
 =?utf-8?B?WUpYRUFSQlNGK3IwYzYyVVNjK0ZNVjh5RGdBRUora29pVmplMDBiM2VxWEJq?=
 =?utf-8?B?U2NzaHBRRndmbG80dUtyalprQWpHdlBldlJSTTl2QzdhWE5nZGZKTTlxcGRq?=
 =?utf-8?B?MVhwVTM4ZVA3KzJMdkRWSlU0L1haNmZvc0o1S2N0QTEzSEFBeTNxUlp0Y3FK?=
 =?utf-8?B?eGt3KzloaE9HWitGL1BSL0I2SXVqU1dyWTVVOFQ2SmtYWE1WUGViZVFVeUpz?=
 =?utf-8?B?UVI0dXNsMXd1RUFzUXQxVXNHOW1TNCtsbFo3Y3poLy81cTNpcGRZZGh6dlhW?=
 =?utf-8?B?SmpQcHpJbG1wZHMrZDBJQjN4QkpwbVVLNk1GWEtmQXk1RVlJY0poNDJzbHhn?=
 =?utf-8?B?RmdFU3F6UW9NL2Eva1RCbzBtVzlmMmhHc091emxLejRKUjlTZUh6aXV2M0E0?=
 =?utf-8?B?T0VtcGtZNWVPNlV2aHowbnV0dTNoYmNQS051dTRkOS9NU1Z6UTEzYXdFM3M3?=
 =?utf-8?B?bEI1WVVwT0hsZzNmQ3Zhbm1GSUpGOVV1VWxmNW5ONkhnL1F0VXdMRStORFVh?=
 =?utf-8?B?d3hJL2hobDg5czgzVDEzNGx0cDNqbUxVazdXSU5mMCtvdnlkUHVPQm1HR2xW?=
 =?utf-8?Q?rE6JKDiNRP+R813o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M7x8oxtaUjyBPaAvIKtoZdLr2rtNEdOhy/MS0Dx1b0/g+8nQcGDW950OSaK+BaN+8pW0hrB3bMoI5MHFYSeumXWjPdAbLWb+uWYtS6DTCZ80NhDBYsRN2iglPEwoc4lDL4OtAF7PeHO3bgtivCmuBuox97ofz/mSTR5/At1z+u+18UFYtYCSZeb+uu8s2kDjju/11KPwwTmeiCFEz9c37evF5WE91nCl7e2pYPktWlDCtbZdt8p7kTCvLoNBvwb4bw3pbnXu0OgCxzYncUgE6SI6Fhc/mf7g3C8yxopLpM1nardyu0ORr4dvfOgx50MYxK5y71p+OtV3Vr+hGrfW+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f93185-f881-4a99-2731-08de9180fdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 13:00:33.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L97EzFdIrURCRctXawHogMFiOQZuTvOd3G+xayc4jPg3LJAWZ6fE8dEha4BVDM19BAJOSF7PbJJikm9Q/uwsIG36TjoxRWVF0s476GdJNA72ZY60kccyj/Zxt/Lsrucp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-275034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linuxfoundation.org:email,leemhuis.info:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B92503944C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMywgMjAyNiAzOjQ5
IFBNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5i
bGl0QGludGVsLmNvbT4NCj4gQ2M6IEhlLCBHdW9jYWkgKENOKSA8R3VvY2FpLkhlLkNOQHdpbmRy
aXZlci5jb20+OyBUaG9yc3RlbiBMZWVtaHVpcw0KPiA8cmVncmVzc2lvbnNAbGVlbWh1aXMuaW5m
bz47IEJlcmcsIEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47DQo+IEZyaWVuZCA8
bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IExpbnV4IGtlcm5lbCByZWdyZXNzaW9ucyBsaXN0DQo+
IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+DQo+IFN1YmplY3Q6IFJlOiBjb21taXQgMGM0
ZjFjMDJkMjdhODgwYiBjYXVzZSBhIGRlYWRsb2NrIGlzc3VlDQo+IA0KPiBPbiBGcmksIEFwciAw
MywgMjAyNiBhdCAxMjo0NDo0OFBNICswMDAwLCBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+ID4gU2VudDogRnJp
ZGF5LCBBcHJpbCAzLCAyMDI2IDI6MjcgUE0NCj4gPiA+IFRvOiBIZSwgR3VvY2FpIChDTikgPEd1
b2NhaS5IZS5DTkB3aW5kcml2ZXIuY29tPg0KPiA+ID4gQ2M6IFRob3JzdGVuIExlZW1odWlzIDxy
ZWdyZXNzaW9uc0BsZWVtaHVpcy5pbmZvPjsgS29yZW5ibGl0LCBNaXJpYW0NCj4gPiA+IFJhY2hl
bCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPjsgQmVyZywgSm9oYW5uZXMNCj4g
PiA+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IEZyaWVuZCA8bmV0ZGV2QHZnZXIua2VybmVs
Lm9yZz47IExpbnV4DQo+ID4gPiBrZXJuZWwgcmVncmVzc2lvbnMgbGlzdCA8cmVncmVzc2lvbnNA
bGlzdHMubGludXguZGV2Pg0KPiA+ID4gU3ViamVjdDogUmU6IGNvbW1pdCAwYzRmMWMwMmQyN2E4
ODBiIGNhdXNlIGEgZGVhZGxvY2sgaXNzdWUNCj4gPiA+DQo+ID4gPiBPbiBGcmksIEFwciAwMywg
MjAyNiBhdCAxMTowODo0NkFNICswMDAwLCBIZSwgR3VvY2FpIChDTikgd3JvdGU6DQo+ID4gPiA+
IE5vLCBUaGUgbWFpbmxpbmUgaGF2ZSBubyB0aGlzIGlzc3VlLg0KPiA+ID4gPiBUaGUgY2hhbmdl
cyBvZiAwYzRmMWMwMmQyN2E4ODBiIGlzIG5vdCBpbiBtYWlubGluZS4NCj4gPiA+DQo+ID4gPiBU
aGF0IGRvZXMgbm90IG1ha2Ugc2Vuc2UsIHRoYXQgY29tbWl0IGlzIHJlYWxseSBjb21taXQgZTE2
OTZjOGJkMDA1DQo+ID4gPiAoIndpZmk6IGNmZzgwMjExOiBzdG9wIE5BTiBhbmQgUDJQIGluIGNm
ZzgwMjExX2xlYXZlIikgd2hpY2ggaXMgaW4NCj4gPiA+IGFsbCBvZiB0aGUgZm9sbG93aW5nIHJl
bGVhc2VzOg0KPiA+ID4gCTUuMTAuMjUyIDUuMTUuMjAyIDYuMS4xNjUgNi42LjEyOCA2LjEyLjc1
IDYuMTguMTQgNi4xOS40IDcuMC1yYzENCj4gPiA+DQo+ID4gPiBjb25mdXNlZCwNCj4gPg0KPiA+
IFRoZSBjaGFuZ2UgaXMgaW5kZWVkIGluIG1haW5saW5lLCBidXQgdGhlIGxvY2tpbmcgc2l0dWF0
aW9uIGluDQo+ID4gbWFpbmxpbmUgaXMgdG90YWxseSBkaWZmZXJlbnQgKHRoYXQgbXV0ZXggZG9l
cyBub3QgZXZlbiBleGlzdCB0aGVyZSkNCj4gPiBUaGVyZWZvcmUsIHRoZSBpc3N1ZSBpcyBub3Qg
c3VwcG9zZWQgdG8gaGFwcGVuIGluIG1haW5saW5lLg0KPiANCj4gT2ssIGRvZXMgdGhhdCBjb21t
aXQgbm93IG5lZWQgdG8gYmUgcmV2ZXJ0ZWQgZnJvbSBzb21lIG9mIHRoZSBzdGFibGUgYnJhbmNo
ZXM/DQo+IElmIHNvLCB3aGljaCBvbmVzPw0KDQoNCkZyb20gZXZlcnkgdmVyc2lvbiB3aGljaCBp
cyA8IDYuNy4NCg0KTWlyaQ0K

