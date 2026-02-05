Return-Path: <netdev+bounces-257050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CuPE5xWhGlb2gMAu9opvQ
	(envelope-from <netdev+bounces-257050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:36:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE900EFF5A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C13A73022F70
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C4360751;
	Thu,  5 Feb 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkrymLC5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB54348445
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280526; cv=fail; b=gR75EBhSkUPgOAde+zfCyezNQVRnrchMFq4BaS+GBQ0hpkplRFfLvbN/FraHiWLpC4l4FqDJFA5W423iycTxmEAH2Ug0SsQdLjezen+qyZcQ6vZbFxYnD8u5cBXjM2HQhJEGDHeHjK8PmyEutGfjbFQiOQYVfReX1RY2BbzwD2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280526; c=relaxed/simple;
	bh=L7M9NnzalyGQXeau7b2RSzTCjGKnVayPapQJ3sMHJkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F/iifTBK0eUzqDh0n4Y5bAkPZR0AVCkVfXGgEd/7SvMsAVHGJ+hWDXaCKeRlR51iIqMMAETQ2jnzieSRizykEskbfZPaK41+RH254nuV1WcktnigN5dqjvsj9iFrCWxeDwyP/vO4GBsTALNHMvC8KUg6RDE1O/zJ02/UbRgdpPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkrymLC5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770280527; x=1801816527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L7M9NnzalyGQXeau7b2RSzTCjGKnVayPapQJ3sMHJkM=;
  b=nkrymLC5xLF0ksobgLUE6szx7Scrz2eqSHNLoRyMYu8syNgvQ7wgGAe4
   iwI5+8yDX8WCLN07G4Dk0mU8RgE2e8Ce2fdWHJkV5dg/WhaAEWpUO+FkN
   kGy6hhfBWy5VSOqlvKiN55zYQJ2f2sQKNMvNCNSV/6FcVGuFqv1w4ZliG
   xoDXo4zKlz8aIIesSdNb2rqQF49s0hdLRPKMHGMC03LhGeyqf7Zr8vvDo
   7HNyD3cBR9RpfSiqh7TiBeyDNhoaQc3oDSjRe4tdhXzCPgS2hH0qQilW9
   VQ//mF+JSiYIKV6BTTQqIFOJHT0z3EA8N6Yk1Il+4+bJdcBS6EIkstYXX
   A==;
X-CSE-ConnectionGUID: TvPuYkr1TSiJrG+YNILyUQ==
X-CSE-MsgGUID: PrewP2F8SrS3K236fbNZ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71648350"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71648350"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:35:26 -0800
X-CSE-ConnectionGUID: HROPaApSTpeSaVbbvPv0xw==
X-CSE-MsgGUID: K/lxmHOXSYuDXSZ2/E9ZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="241113804"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:35:24 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:35:23 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:35:23 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:35:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIYZH+QzLl2ZsCSeh3F6N6dK7QEHqfRzv7rIX0Dt4obawRe0p++GCPwqzOvMUtXR2fMwzghLleKLkup486GCYuDj3LTggf6cqXFoFGEf+Hi5JEhLiDPhdvFBhjlKz7NnYtdehqlR16d12BFmpeLfDOZacP9VccJHdBDjWR1xcSB8xS+jjHIXfbljTUnPwUBX1+4CkHFcVm60RNbuxPY8mYgVcczdml5ZfvtmqPG7x/fBhk2HABRlSDZbJ1YNj5rqtdfGs5snLKfGolG/mPbq8i9FxiGLU5Tvj4d0VRiw5XpshYXwIChPzSjdtOOGEDNYL1SlYfcC2wsECoifPghKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7M9NnzalyGQXeau7b2RSzTCjGKnVayPapQJ3sMHJkM=;
 b=nd8xZ409duKbeWU9hylF3n0qlhaVgMMJgWsmxwi4xRim2Aem+22sKgdkavgx3gWV8ksu6TZ7yg7ACIBWnuTHw2YEpc8uk+0fdJt3PTg9SeJREPeDKL6vf6rjFNb5tKrrwXRMODMGhbCd01X5a7Qh/Tk7AAotOtAvCdtuDWHikUnoyJh9qw/ilVvO2XEf2f7uTa/wnj5cpZ7fDALQgTaMl38Sj4iLjEwpsfAZy6AdyoIj7WGiJgyWsa3e83RCyiMeYMAkF4HE3L6pmkgV2Yni4qpPi4wkGp9MI+U41GD/U5w2n0x4vfI5/S/fGZtxWPdQkEWUq8C717A3gxJOe5wGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by PH3PPFA07D87DA6.namprd11.prod.outlook.com (2603:10b6:518:1::d3e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 08:35:16 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:35:14 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Andrew Lunn <andrew@lunn.ch>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "horms@kernel.org" <horms@kernel.org>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ixgbe: e610: remove redundant
 assignment
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ixgbe: e610: remove redundant
 assignment
Thread-Index: AQHckUV103CEppPE1kS2hLMQE2/gXbVpa0+AgAAHSYCAClx24A==
Date: Thu, 5 Feb 2026 08:35:14 +0000
Message-ID: <PH7PR11MB59833D1AE8A3EC0AB6F87901F399A@PH7PR11MB5983.namprd11.prod.outlook.com>
References: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
 <60e6bfa6-4267-4d33-9987-24b87c0d0091@lunn.ch>
 <8b146fee-a63e-4e22-a1c1-eae052786e66@intel.com>
In-Reply-To: <8b146fee-a63e-4e22-a1c1-eae052786e66@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|PH3PPFA07D87DA6:EE_
x-ms-office365-filtering-correlation-id: cd8f5716-1969-42ff-0a36-08de64917c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Sy9YcVBDUWF4R2t0dXowOVdjTm03c3pvL0l6ZVZpTlh2T3RzTlJMeGIybU5N?=
 =?utf-8?B?aTJTbHpkSXdFZzcxbW9kZ2V1MFE4VXpXdkkyaXFjMjA5VlkvUmlLcGZTeUZN?=
 =?utf-8?B?eXlQVUpJTHNhNldGejlyemVKVzlhTVNCaExiYWdQT2ora3l2cEd4VUVGdE4x?=
 =?utf-8?B?OUtaV0VBMnc0KzRPQ0lkenNkS1c2bCtNamh5STFwYlE3Q0dlOERqQ3FSb2dj?=
 =?utf-8?B?L2NmcVppVWJTVEVKdjJ4Nm95VElCeFBDR2xFSVJEOXp4U3dIU0YwMkc5SDhw?=
 =?utf-8?B?TWpGMy9MQWppazlaUFVRMUtDbUdjZXBQZ3hIek1jdTVBNzNLOVU2RGtjR2VC?=
 =?utf-8?B?dDZtOHRCakxqbTRRenp0YjRwNmRhWVc4dEFlV0oxUWdLMkpvUnZIM0xvdDND?=
 =?utf-8?B?ZW1ObThCdVh2WDl6a0VmeGljQkpSV3pmNkRZRE5ENVAvQWhvVlQwM1FTK2Nq?=
 =?utf-8?B?Y2pDVytiNmtpV3VhbXpMZjNweHBOZUhRaThPVkZCRUNVK1NFdXBpNUtBZVRI?=
 =?utf-8?B?VlE3Y2RsZWtQNkJwYU9hUHY4N1JHb01heExzNk9HdXNMa210SEx3VlhCSm0y?=
 =?utf-8?B?c3I1OFdObWtQK2NzOTZBNFJQU3dBY01FNlRkV05XdnhrL0l0WERldmNCbFBq?=
 =?utf-8?B?d1dBbmlnVTBiTklVZjFVaVZyYUppQTNmT3Q1MnByOW1DR2ZCUGl2QmxHMDNH?=
 =?utf-8?B?Q1hrU1l0SFhyekpnK0VLRE5GRVg5ekN1MWFZSjB3QVJBS3RybXdzbGlJcUsx?=
 =?utf-8?B?dUFud3RQblQ2YktNQ0VIUkRUT3BoNXdqQXBzTlRsdW5IUGdLNmJaclNoeTRq?=
 =?utf-8?B?OXdOUVBIYU5sclhZblJ3VHJQTzVKQmpMRE0wN2pmS0pobStsOWR1eW9pdVdw?=
 =?utf-8?B?bm91ZmVuaHBrQzRQanFaYThEUXNKTWFUNTVRRjM2TU1DYkVBaWczQkZ2cDZ3?=
 =?utf-8?B?b21wWTBvYlZ5VjZnM1dRRjBmSnJLcEpIWm0zc0RWc1V0K1paekVVOWNGSklj?=
 =?utf-8?B?bkhUSHkrM2xCOHJCZ3hnKzRHZGRRWkY5S0FzNmdiYXIrNlplbHhXUWZCYlVS?=
 =?utf-8?B?d05OSmpTelI3YStFMTYzQWZWMmZKbTBxZTNVRWtqOWVkaDIxcURxOXBoRXV3?=
 =?utf-8?B?NEw4YTVBN3FoTnh0UGN2TTJEeUlSWGJhWTVlUkhWcWdPbmxTZnVRcWhHejFO?=
 =?utf-8?B?K1U1Zi9NV1p4S2d1SFJpRHN5WktoM1RQeFA3M2R2T2NkUWhkVzFwaWRxMlhR?=
 =?utf-8?B?MkMzZ2lWT09CWkxydTR1dDVYWlRENy9MMFFDdGxyNWZrM2FacGkxUi9yWkRD?=
 =?utf-8?B?YjEwSUpDeDN0a3FFV1RRMzRleldhUS9qSWIvdjdMc2pWSjdHay9qQVNjOUh1?=
 =?utf-8?B?Q0UwQ2duOUwwcTQ1TEcwQTRQVVpIRXl3QjFlOGJCSG4yZlVVQXdTTEx0V1Z4?=
 =?utf-8?B?ZEZ3azBISU9xMHNkOGFWc25OcU5QNHBzajB1TE9qaHlsSkdEUEJNRENVQlZl?=
 =?utf-8?B?eStTWEJ2dldybW81czRlVDd2eDNIL2RIWmJZZWZJRHF0aWEzS3ZRZEdWNFVK?=
 =?utf-8?B?bldEdjFzTDdSNkJONkxncUR2UW4zODQ2Y1lta2xPZzRZTHR0Q2RWWmc4TVY4?=
 =?utf-8?B?NHpzd2ZLSXhjU1hlOTVLQ25qYlZtR0ZNTDA2eWlBYjJsWTRrWlpneGM5TnFv?=
 =?utf-8?B?bW82SUpSVXdEbzRSK1MwcFJqbG9yWmRJLzFVUEp4ditHdUZCTGJKaVg5QUNk?=
 =?utf-8?B?RStuVmRWMFYzYy9HMlltOXdlVmtjN1hMN21XK3lIenFUNm93UHFIUUNDVHBz?=
 =?utf-8?B?Zk1hWGRlaXlJdlFkQ2VZVldpd2prQUVObGpiWHhGcVk3eTVDb0F5QWI4NCtl?=
 =?utf-8?B?cVcyQVptVm9TZi9kMFZpbzRsdDV1cHRhbkozcFlHVnd1cFYzSnAvbHE5UmFP?=
 =?utf-8?B?czJzaDlXWkZUcG8wZWdlcG9SVEorZkM2cHBzUEVUZ2ZCQ0dZK1EzMjV0UkRX?=
 =?utf-8?B?NXUvZ0VGbHpHY0hMclFyNnVDSHZSWGkvMElNeENzTmJtSGIxWFpwVlFpNFYx?=
 =?utf-8?B?YlRJZEZqTkJqN1VtZG92azNnK1djTm0vYktmYlRFUE5mbE9mVXNFUHd3SXh6?=
 =?utf-8?B?Nk8zWjNsSDVPVmpmTW8xQVZzMThrM0V2cFJhUHBJOVpWaDI3WXllYkt5Snph?=
 =?utf-8?Q?59LJ97xtsSPZdzjURKVMlYU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG1TWFQvZkhpUFN4aDAvZHlSN0tOWHJTUHMwTTZzZS9iZGVXemZXSFIrTzcv?=
 =?utf-8?B?eUJkdWpzVjExVUVEc2xSZVl2cTZoNmNEQlJSNlo3VWdsMWpMZ3dCMDhpc1Zt?=
 =?utf-8?B?S1lYQlhuUnV5R01UbFRHU0MvekFtcGFERVAxdHdoZWRVMHFwWW5sRXFKdzNx?=
 =?utf-8?B?bmNCVFR1U0ZRWnovUXNJUkdIclVGSU5ra0hzVTkvRjJTMTVyTlkySTBnYkdv?=
 =?utf-8?B?b1Q4NkV3V1U2Q3R1eG9WNEg3YWRqOERycFoxeUI4TDFNcTQzT1lNVGhXMEg0?=
 =?utf-8?B?ckVDdzFUNG9BbEduWSswV0taUUhQcUtLRzZzZ2tnU0Y4dWpKSks2cWVjVVdj?=
 =?utf-8?B?a00vYUNjaVFjRzY1djVFbzAyQUpwSVZOZnJXb3JBUnRtNkI2MElIZWJFaExE?=
 =?utf-8?B?TmNkcFEzbGQvOGVHTWY1MFQrZUtsNWVsVFFDbHhqMXpYU08za3JjOW5YcXQ0?=
 =?utf-8?B?dVVMNWthdzJWaWg2QlQ5VE9peFFqTVhYeW00UHZLcUVLUlZ5ZjJLQjV4Lytl?=
 =?utf-8?B?VU9ITGRFTXpEMzRMeDZpcXdYK082L2FGczFuRHZ5Zko3RE9BdE9IU1gybXZB?=
 =?utf-8?B?bUE0ODF3Tk5wZUE2KzRPWXJmQnVCTG5vTWdOTUUzUzBGWkRhdmduVmdERkF6?=
 =?utf-8?B?OXQrLytrbGhEU2dJdUlJc05PaWdybU9BS3Z3VEdxUytsd2k1THBUUm1LTmUx?=
 =?utf-8?B?Y0RYNnNseHEwc2t6YzNhdlc3QjRLN20yczRtVnFxb0RDNW5ZZ3IrN21mNDNu?=
 =?utf-8?B?Z3k5K1FJWW1rdlZuaWRucWFZdnN4S3ZBTVNLbGRuRXV2S2RjeVVGVUExakY4?=
 =?utf-8?B?a3BjS0FCZ2VxWGpVRmNpUUxZblRFc0RjeTBUeHZPWU1UVzV4RFNIVjlWSGhZ?=
 =?utf-8?B?Rm11am4walZ2WWlLY3JwRll3cWNBS1ZpYldtNlF3bXhQV1ZPOUQwdUdWbWdl?=
 =?utf-8?B?blYyVzhNbW9HZjcvbVFvM2RNQmg0VmJjUC9UUFprUFhCaEJDVTdXVlFFd0l4?=
 =?utf-8?B?RXpMcjRjT0RMc3hURTlCZTF2akxhYStva0NXSmt0L25XYTZncnBiaVJlTUQw?=
 =?utf-8?B?enFCWVhJZVNhMVBLaEpnclpEWmdOMU1ITmU4VDNjdmdNOFhrakt5R25CbC9q?=
 =?utf-8?B?UU94bkFpeXRvQnQ2QXhWMG91dGR4L3hVZmxwc0d5NU5LWVg0eUdVTk5oQUFZ?=
 =?utf-8?B?SWdoN2Fpc3FyN3VYeld0RFhKNnRUZXRMQ3JFeXZKN2pTNWtkcWl0ODdEZW10?=
 =?utf-8?B?bmNNMlA3UDhzM01RK2xlbmNhYmlqZkVubFVON0hVU2d5T3pEMUtoQkpNemNl?=
 =?utf-8?B?SjVXNDVpNDJFV2xZRXNtMjcvb1lkL21pbjhJZ3FTSHZ2WjE5a2dQTmFUdWh1?=
 =?utf-8?B?L2EySE5mWUpiUTBwVVZ3OU1ZSUhoRHRMQmFWVlU3d2ZxeEdqdUZwbnN6ekxQ?=
 =?utf-8?B?TG0rZHFvNGM2M2JhM0xJeitOZEUrOENzcWQ4NjZhTFpUT252bXhmY0VyUjVO?=
 =?utf-8?B?R2ZjM3VWZFdOeDZGVFZwUjBwY3hPMGM1bWNicUpXYnhFbnRtaUF1QVlpbWFQ?=
 =?utf-8?B?UG9Jam83SW9zZHNvcVpjRmJxb3RMZ2hyUW1rcEd6ZlBlakhzNndBbS80eE56?=
 =?utf-8?B?VGgwcm8rTlBuUlZlY3dNZVNocmFtOFpkcmtJK1ptRHQvajNIdHZoVjVNS05O?=
 =?utf-8?B?MEZ4K1BhdUNqa0ppK0ZPOVZlbjc3SEJzSlM5c3Nxc1J2Rld5U041YU1Sek5s?=
 =?utf-8?B?WWdrNHJidG5RUm1LRjhuK3BMR1NSRGtQbUs3YjdiS3c3Smd6K0tDemVtdlZj?=
 =?utf-8?B?clB1VjJIU0tHa0R2MFZiUEZ0Q3pQWVRaaFUrNTNDQ0UrekxvaTNTcWduMnZF?=
 =?utf-8?B?MDV2NnkvTGxsQ3ArZVZCd3JyUlJteUxxQndUaThNUndlY0VQZDBCeEM2bHVw?=
 =?utf-8?B?VGppNzlpOWZON3R5UWhHbTgza0VTc1ErS1Q4cXBzU3EzbFlEWFFvOTV3aS9r?=
 =?utf-8?B?UjFWU1RYd29YaHc5eU5wd2lEY2ViNDJmMXVYWi8wRjFqYkRCWmU5QkFPT1BE?=
 =?utf-8?B?QWdnKy96MG1razNhckg4SUNjUHRwb2hBOURkdXVDeFVjT05ialN6eXFaUmpm?=
 =?utf-8?B?ekgyWXlsSzZLV0ZKMEpuY0xaU1FrRk8xVVBSdzVjbTdsUi9sM0phQ3p5Q2k4?=
 =?utf-8?B?SGI4aFRxb3F5ZDRuQ0Q4ZFFVZ1lTM0UvL1E4RGF1eGdLZGh1clJqRk9TRzVM?=
 =?utf-8?B?V3g0M1Uxc0FRSmxSdGwzVmQwdXExb3BFa09zRGtPWTdzTDMvelNpZ2lSVmVh?=
 =?utf-8?B?UkZhOE5ZempRdmFwUTNyU3h5ZnpqcWExeDY3Rmcyb2hCN3l0MkljQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8f5716-1969-42ff-0a36-08de64917c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:35:14.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7ySRxrpfoWdkdx58eZXO9Dmnl/GrWzoSJorVyRI9pswozOSamIsqOvanORHP82N9LHyChPYGvbLdN55j8QusAPrNcRaRhegweyF1G4FH1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA07D87DA6
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-257050-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[piotr.kwapulinski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BE900EFF5A
X-Rspamd-Action: no action

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS2VsbGVyLCBKYWNvYiBFIDxqYWNv
Yi5lLmtlbGxlckBpbnRlbC5jb20+IA0KPlNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI5LCAyMDI2
IDc6MTEgUE0NCj5UbzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgS3dhcHVsaW5za2ks
IFBpb3RyIDxwaW90ci5rd2FwdWxpbnNraUBpbnRlbC5jb20+DQo+Q2M6IGludGVsLXdpcmVkLWxh
bkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYW4uY2FycGVudGVy
QGxpbmFyby5vcmc7IGhvcm1zQGtlcm5lbC5vcmc7IHBtZW56ZWxAbW9sZ2VuLm1wZy5kZQ0KPlN1
YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHRdIGl4Z2JlOiBlNjEw
OiByZW1vdmUgcmVkdW5kYW50IGFzc2lnbm1lbnQNCj4NCj4NCj4NCj5PbiAxLzI5LzIwMjYgOTo0
NCBBTSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gICAJLyogUmVhZCBzeW5jIEFkbWluIENvbW1h
bmQgcmVzcG9uc2UgKi8NCj4+PiAtCWlmICgoaGljciAmIElYR0JFX1BGX0hJQ1JfU1YpKSB7DQo+
Pj4gLQkJZm9yIChpID0gMDsgaSA8IElYR0JFX0FDSV9ERVNDX1NJWkVfSU5fRFdPUkRTOyBpKysp
IHsNCj4+PiArCWlmICgoaGljciAmIElYR0JFX1BGX0hJQ1JfU1YpKQ0KPj4+ICsJCWZvciAoaSA9
IDA7IGkgPCBJWEdCRV9BQ0lfREVTQ19TSVpFX0lOX0RXT1JEUzsgaSsrKQ0KPj4+ICAgCQkJcmF3
X2Rlc2NbaV0gPSBJWEdCRV9SRUFEX1JFRyhodywgSVhHQkVfUEZfSElEQShpKSk7DQo+Pj4gLQkJ
CXJhd19kZXNjW2ldID0gcmF3X2Rlc2NbaV07DQo+PiANCj4+IERpZCB5b3UgbG9vayB0aHJvdWdo
IHRoZSBoaXN0b3J5PyBXaGVuIGkgc2VlIGNvZGUgbGlrZSB0aGlzIGl0IG1ha2VzIA0KPj4gbWUg
d2FudCB0byBoYXZlIGFuIHVuZGVyc3RhbmRpbmcgd2h5IGl0IGV4aXN0cywgc2luY2UgaXQgbG9v
a3Mgc28gb2RkLg0KPj4gDQo+PiBJcyBpdCBhIG1lcmdlIGNvbmZsaWN0IHJlc29sdXRpb24gZ29u
ZSBiYWQ/IElzIGl0IGEgdHlwbyBhbmQgdGhlcmUgaXMgDQo+PiBhIGNvb2tlZF9kZXNjW2ldIHdo
aWNoIGNvdWxkIGJlIHNldD8NCj4+IA0KPg0KPk5vcGUuIExvb2tpbmcgYXQgZ2l0IGJsYW1lIGZv
ciB0aGUga2VybmVsLCB0aGlzIGFwcGVhcnMgdG8gaGF2ZSBiZWVuIGhlcmUgc2luY2UgaXRzIHN1
Ym1pc3Npb24uIEkgdGhlbiB3ZW50IGFuZCBjaGVja2VkIHdoYXQgd2FzIGRvbmUgaW4gdGhlIG91
dC1vZi10cmVlIHJlbGVhc2VzIG91dCBvZiBjdXJpb3NpdHksIGFuZCBpdCBsb29rcyBsaWtlIHRo
ZXJlIHdhcyBvcmlnaW5hbGx5IGEgQ1BVX1RPX0xFMzIgbWFjcm8gd2hpY2ggd2FzIGRvaW5nIGJ5
dGUgc3dhcHMsIGFuZCBhbiBlcXVpdmFsZW50IHdoZW4gd3JpdGluZyB0aGUgZGF0YSBpbiB0byB0
aGUgcmVnaXN0ZXJzLg0KPg0KPnJhd19kZXNjWzFdID0gcmVhZF9yZWcoLi4uKTsNCj5yYXdfZGVz
Y1sxXSA9IGNwdV90b19sZTMyKHJhd19kZXNjW2ldKTsNCj4NCj5JIHN1c3BlY3QgdGhlIGJ5dGUg
c3dhcHBpbmcgZ290IHJlbW92ZWQgZnJvbSB0aGUgb3JpZ2luYWwgdXBzdHJlYW0gc3VibWlzc2lv
biBidXQgbm8gb25lIG5vdGljZWQgdGhlIGV4dHJhIGFzc2lnbm1lbnQuDQo+DQo+T2YgY291cnNl
IHRoZSByZWdpc3RlciBhY2Nlc3NlcyBhbHdheXMgcmVhZCB0aGUgdmFsdWVzIGluIGhvc3Qgb3Jk
ZXIsIGFuZCBJIGNhbid0IGltYWdpbmUgYW4gT1Mgbm90IGRvaW5nIHRoYXQuLi4NCj4NCj5IbW0u
LiBCdXQgbm93IEkgaGF2ZSBzb21lIHF1ZXN0aW9ucy4uLg0KPg0KPlRoZSByYXdfZGVzYyB2YWx1
ZSBjb21lcyBmcm9tIHRoZSBkZXNjIHBhcmFtZXRlciBvZiB0aGUgZnVuY3Rpb24uIFRoYXRzIGxp
YmllX2FxX2Rlc2Mgbm93LCBhbmQgIGl0cyBkZWZpbmVkIHVzaW5nIF9fbGUqIHZhbHVlcy4uDQo+
DQo+V2UncmUgY2h1bmtpbmcgdXAgdGhlIGRlc2NyaXB0b3IgYnVmZmVyIGFuZCB3cml0aW5nIGl0
IHRvIGEgYnVuY2ggb2YgcmVnaXN0ZXIgYmxvY2tzLCBhbmQgd2UgZG9uJ3QgY29udmVydCBmcm9t
IExFMzIgdG8gQ1BVIG5vdy4uLiBzbyBvbiBhIEJpZ0VuZGlhbiBzeXN0ZW0gdGhpcyBpcyBnb2lu
ZyB0byBub3Qgc3dhcCB0aGUgdmFsdWVzIHByb3Blcmx5Li4uDQo+DQo+V2hpY2ggbWFrZXMgbWUg
dGhpbmsgdGhlIG9yaWdpbmFsIGNoYW5nZSB3b3VsZCBiZSByZXF1aXJlZCBvbiBCRTMyIHN5c3Rl
bXMuLiBCdXQuLiBldmVuIHdvcnNlLi4NCj4NCj5JIGRvbid0IHRoaW5rIHdlIGFjdHVhbGx5IGNh
biBqdXN0IGJsaW5kbHkgY29weSB0aGUgdmFsdWVzIGFzIGNodW5rcyBvZg0KPjQgYnl0ZXMgYW5k
IGJ5dGUgc3dhcCB0aGVtLi4gVGhhdCB3b3VsZCByZS1hcnJhbmdlIHRoZSBmaWVsZHMsIHNpbmNl
IHRoZSBzdHJ1Y3R1cmUgbGF5b3V0IHVzZXMgX19sZTE2Og0KPg0KPj4gc3RydWN0IGxpYmllX2Fx
X2Rlc2Mgew0KPj4gICAgICAgICBfX2xlMTYgIGZsYWdzOw0KPj4gICAgICAgICBfX2xlMTYgIG9w
Y29kZTsNCj4NCj5UaGVzZSB3b3VsZCBnZXQgc3dhcHBlZCBvdXQgb2Ygb3JkZXIuDQo+DQo+PiAg
ICAgICAgIF9fbGUxNiAgZGF0YWxlbjsNCj4+ICAgICAgICAgX19sZTE2ICByZXR2YWw7DQo+PiAg
ICAgICAgIF9fbGUzMiAgY29va2llX2hpZ2g7DQo+PiAgICAgICAgIF9fbGUzMiAgY29va2llX2xv
dzsNCj4+ICAgICAgICAgdW5pb24gew0KPj4gICAgICAgICAgICAgICAgIHU4ICAgICAgcmF3WzE2
XTsNCj4+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgIGxpYmllX2FxY19nZW5lcmljIGdlbmVyaWM7
DQo+PiAgICAgICAgICAgICAgICAgc3RydWN0ICBsaWJpZV9hcWNfZ2V0X3ZlciBnZXRfdmVyOw0K
Pj4gICAgICAgICAgICAgICAgIHN0cnVjdCAgbGliaWVfYXFjX2RyaXZlcl92ZXIgZHJpdmVyX3Zl
cjsNCj4+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgIGxpYmllX2FxY19yZXFfcmVzIHJlc19vd25l
cjsNCj4+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgIGxpYmllX2FxY19saXN0X2NhcHMgZ2V0X2Nh
cDsNCj4+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgIGxpYmllX2FxY19md19sb2cgZndfbG9nOw0K
Pj4gICAgICAgICB9IHBhcmFtczsNCj4+IH07DQo+PiBMSUJJRV9DSEVDS19TVFJVQ1RfTEVOKDMy
LCBsaWJpZV9hcV9kZXNjKTsNCj4NCj5JIGFjdHVhbGx5IGRvbid0IGtub3cgd2hpY2ggaXMgImNv
cnJlY3QiLCBhcyBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHdoYXQgdGhlIHJlZ2lzdGVyIGlu
dGVyZmFjZSBleHBlY3RzLCBhbmQgaG93IGl0IHdpbGwgZ2V0IGludGVycHJldGVkIGJ5IHRoZSBm
aXJtd2FyZS4uLg0KPg0KPk1heWJlIHRoZSBieXRlc3dhcCBvZiBlYWNoIDQtYnl0ZSBibG9jayBp
cyByaWdodD8gYnV0IEknbSByZWFsbHkgdW5jZXJ0YWluIG5vdy4uLg0KPg0KPlByZXN1bWFibHkg
aXQgZXhwZWN0cyBmbGFncyBmaXJzdCBhbmQgdGhlbiBvcGNvZGU/IHdlJ3JlIHdyaXRpbmcgaXQg
dGhhdCB3YXkgbm93IG9uIGEgTEUgc3lzdGVtLi4gQnV0IG9uIGEgQkUgc3lzdGVtIHRoYXRzIGdv
aW5nIHRvIGJlIGJ5dGVzd2FwcGVkIGJlZm9yZSBnb2luZyBpbnRvIHRoZSByZWdpc3Rlci4uIHNv
IG91ciA0Ynl0ZSBjaHVuayB3b3VsZCBlbmQgdXAgcG90ZW50aWFsbHkgcmV2ZXJzaW5nIHRoZSBm
bGFncyBhbmQgb3Bjb2RlIHcuci50IHdoYXQgdGhlIGZpcm13YXJlIHNlZXM/Pw0KPg0KPkhtbS4u
Li4uDQpJJ2xsIHdvcmsgb3V0IHRoZSBzb2x1dGlvbi4gTWVhbndoaWxlLCBwb3NzaWJseSBpdCdz
IGdvb2QgaWRlYSB0byB0YWtlIHRoaXMgcGF0Y2ggc2luY2UgdGhpcyBjb2RlIGlzIHVubmVjZXNz
YXJ5IHJlZ2FyZGxlc3Mgb2YgdGhlIGZpbmFsIG91dGNvbWUuDQpUaGFua3MsDQpQaW90cg0KDQpb
Li4uXQ0K

