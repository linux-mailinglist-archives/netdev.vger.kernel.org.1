Return-Path: <netdev+bounces-153043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E99F6A38
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9978A188121C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23B1DED77;
	Wed, 18 Dec 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/nKDCzS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B95FEE6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536393; cv=fail; b=gjrhaGGkYhFsyHgjWwDJyE/pHXm3enY1jxjj63m5zFnYGEN9e5rhhQgR0WZS78+t+kwrXJBEtSnERwuQHaHJrimuvtoo+aBpWGL42q72+AMTlbNAJ4uewh9NGNKD/ifbkdCuBN92ZgiAvppKFo9W38JA5f9yPu157bBDawPjtX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536393; c=relaxed/simple;
	bh=uFLNXt5BGbYu5CR1198ALTYYrQ50p6KHmvb+Uq38kJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UENbTKiByMX6xT57lu29y8IGvRyy1kG17BpHc+I5pu9gk7ZBmmmQvk/mhCKmr4U8QCKpIsItrh0VMEIB58jXew0DI9Q5foiT4fp40f8RmjQOFEtlgJ2x0JHgjZ5AbQd3Mxy0lzylcBhLucUa2S3xJFc1U8je/+4xDhGxdhwF2uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/nKDCzS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734536391; x=1766072391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uFLNXt5BGbYu5CR1198ALTYYrQ50p6KHmvb+Uq38kJY=;
  b=f/nKDCzSIOxYfi2P0LDaiR6c0LkVHZgtg1FKLbQLtcvzvyBD1XrIl7TG
   D2Fg0zbjBHW8ROMbrctFgFFudYn19wg1tV8nCyZKnxuhvDF89hmemIO4q
   7mBlZkqLGwJpE32by21Qc9ZS64P4FqcQt5lsqKWlR5KdHvJjWLUjZkaAw
   UmrO5Acc9Ep9GrOs1p6o378VTRGY2gVoBismO+EkRhwSNIAVtgoU6WfPy
   2VeyxXiupeO7DvlblVZ2gM6xgkmDAzlLRygqDAQ2iRqtm15oaO4JRWY2W
   crVnebqLiUmprSww+Zv9yeNglPsxV2dPhufztQtVGI3sUs1U6IF0rBcMy
   Q==;
X-CSE-ConnectionGUID: des7jJP9RAuCQiXWnbiydw==
X-CSE-MsgGUID: n3/8SOgKTsymsWpgg2MDug==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38694338"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="38694338"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:39:13 -0800
X-CSE-ConnectionGUID: aVFonygqSjOu96rytH1HPQ==
X-CSE-MsgGUID: tJo2H+dRRC+0/67etz+D8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="102904110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:39:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:39:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:39:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xws9INoh5BW9Pcs1uJKoFEPsIHbkCJ7igJVRP3mYE/xmRED7JaU4Yblmc9xQRMa5/7Qz0ycxMGbd/grv9N/ZkNv+/AYPdcwQV2GHigKoOFIJb8h2rxnC4c0AmMBIZnA38XeXDc8RjJfpBfvPnasrkWJU2K7DV3sXYIf52oAecIDnpph5qY5ekxUldL7EJO2k047AhqEiAFpPuZ1QzIGS1oIvvIS/w0xhLJDL2106yv5jI/wysbecYtFQ/pTtdQgLI3LEp2e4hV84iTjRdkTG31us9U/09ERi/I4CfEq10nlyKURLYO/dY9iyx8FhNGYpChFtCPf/9McGWZzArEfVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFLNXt5BGbYu5CR1198ALTYYrQ50p6KHmvb+Uq38kJY=;
 b=RozzPp8u9WePe0Sz+/dTAo4IV9xXuWGEV+qc2lbj5qY1x99JYmJcng9UFGOTqfSpD3BYkrNb5kAnSEFWPpc51mKIdht6Wf8oMb7KLsAd2WOGWezFhpbghoQvxEwl34uCdE2k0cEVPYazJD42sc+3xngDspj1OCHOfOa/Mf7ptl8ThJaNIAVrZLbXOoP4+BzVk050OjxuF39sKopJmxhTgBqsdTQUTHTb8gtcUNhrU0jge0qvfc5s9UpoZIcFqfI7vZ+ty4BZSMv3izjEscw/7vMbBVFN6I5bhA3AyhdGqnx2T4CkUnreI1D+wP5+2x+w/p1lprUPrntN6vXXYoq1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:39:08 +0000
Received: from PH7PR11MB5885.namprd11.prod.outlook.com
 ([fe80::b1f3:809e:5b8a:c46e]) by PH7PR11MB5885.namprd11.prod.outlook.com
 ([fe80::b1f3:809e:5b8a:c46e%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:39:08 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
Subject: RE: [PATCH v2 iwl-next 09/10] idpf: add support for Rx timestamping
Thread-Topic: [PATCH v2 iwl-next 09/10] idpf: add support for Rx timestamping
Thread-Index: AQHbP/oDGfYSqo72NU6l/mYNuQteJrLObFWAgB3ZXzA=
Date: Wed, 18 Dec 2024 15:39:08 +0000
Message-ID: <PH7PR11MB5885BD1D700903BEFDC0B8FA8E052@PH7PR11MB5885.namprd11.prod.outlook.com>
References: <20241126035849.6441-1-milena.olech@intel.com>
 <20241126035849.6441-10-milena.olech@intel.com>
 <6749e251407f0_23772a2948f@willemb.c.googlers.com.notmuch>
In-Reply-To: <6749e251407f0_23772a2948f@willemb.c.googlers.com.notmuch>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5885:EE_|CY5PR11MB6283:EE_
x-ms-office365-filtering-correlation-id: 55dd4931-a2e2-41e8-1483-08dd1f7a1c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?blZBY3E0SWdzdDhjVVpLMXd1THd0cjE5K01tK0YwS0gzZGpaN0JxdTBKdmUy?=
 =?utf-8?B?K3pWakJJYlRrRk1jWXBkWitGU0lJWmNvTjYvRDZHOW1ZNFBxblAxRHhXT2RI?=
 =?utf-8?B?TFhJalNWVnlDNGowR2ZoWUF2QzNsUUxhZUFnbURaYTJnandENGNrTmhaTDRu?=
 =?utf-8?B?anVvZit3dTNDTkFJUlJsU2dNN1N0OEZrbDI3WTdwZlVKWW5TbkdPSUwxWHli?=
 =?utf-8?B?RHg3V1ZOUjhIei9WbVB3VGx1WlhwSEhQUHNqM2dZYSt2ZytKdk9idnNJaWxv?=
 =?utf-8?B?K0NsTW9mSHVvWHZrM0c3em5xTm5oWmtGTDhTM2h5cUVZSGlCOFQ0QnVHc0lI?=
 =?utf-8?B?QVdVZmN1WlpUL2RBSUlxWm9CdSt0TWJ5Q05ReEU3QUJZNFNGdFdoUU93OHRu?=
 =?utf-8?B?eHFQRGZMWkgwVy9pZW56SWhCYkVCOERoWlQwcStHNWNOZnFwMzR0UWJGa3Uw?=
 =?utf-8?B?YnZaeWU2YkVMNGN0WExSeDlrUHB2MmJTZEs3dkZ4eko5OGE2UDBMcmM0WCto?=
 =?utf-8?B?UWJBWXkvV3RIYTYxUWViWStlOVlldStBUUFMR0I2SnlOTjcvczV3bkNXWmpH?=
 =?utf-8?B?c1VUQUlJYWg4UVMrNUdnNGUxYkZ6emRWQVo1QWVibjNWbmxTM2w1alVRQ2gr?=
 =?utf-8?B?Q3M5MmVQcnliMThOa1gzUjA4ZkFwdjJyWnh2SWl1WGxzL3BtZTFjYXRpQzRm?=
 =?utf-8?B?N0FiSVphd0J3YTR0NGZNMEpQNVpsY0VuNXBLZ1lXdU14S3VuZ2RKSENOUDlW?=
 =?utf-8?B?YnUyLzByM013amVlU01kL3E0RjBVOXFJWUYzREE1NEVydUphaWMrcWpQS2Nu?=
 =?utf-8?B?QkltcGNvK2wwR2E3ZzU0NEFPNXhHSWhjczhLak1kV2pzWmhOemhpQ01yOVI5?=
 =?utf-8?B?a2VOQk16Q2R4eDViUjZLdGtmcStkaTgvU2JzSEVCQmVlRjRHbERxd1NCYmNr?=
 =?utf-8?B?ZWtYbmR0RnNYb2MwdzBjT09IMEpCLzhnRTNibUtKQjYvcStodXd5NC92cjd2?=
 =?utf-8?B?RElSdXB2aVZwUlduTm42Y2kzTFBGQUhjZ0VYcXZxOUk4aWdqVWdoU2NNYlBN?=
 =?utf-8?B?UUhYY0hnMkYvOHdlMEdvKy9xN0d4d1NBOGdXenQrWmIxM3FmNmtUTTNnZnEv?=
 =?utf-8?B?aE0xUHNMUTRzZ2JEZnlPUm9UZko0WUFxN0duVjBWbjBERlJETC91Y1hqUDBL?=
 =?utf-8?B?V0EvNERRT3VtL0M0dXlKSlRDQmRld25LbytqMmlzU2xGZ01ES0kycHdrQXRB?=
 =?utf-8?B?cHpYSjdENkR0MGU5bWU4WDYvcVNNeGkzZkRSVUlOSFN5ZWduTzIzZ1JmSlF5?=
 =?utf-8?B?RElOaFRCaHVSNkJiSHYxWUIrSTN3V24vemRwbURpdHBrdFB1RHBSRXp4cnNJ?=
 =?utf-8?B?UC9BUmZaYjRTTlRmbEpEZjQyYmcyNzd0SVY1K3dLNW9CKytCUnJadUV5U1Fv?=
 =?utf-8?B?aGMxZHZWTjdWcGxhOW9BaUd2NmZKRER1c2o0WTAxdnFYeTNGdXRaemJCa0ps?=
 =?utf-8?B?S0tRK3BXM0FvOXN4UXVpcnFQenE5WndjbllRdUVrSmE3MjJYSDZSZnBlUzNq?=
 =?utf-8?B?S2NycG1SbGVMZ3g5UytvdVM3Tmdzc3hBOEl5Y2xUc2tVdDh2WmdGcVVKOVUy?=
 =?utf-8?B?QjhaTEJFdDNQVVk4S29OTTQ0N3BsV1B6TWlwaEJtT3NCUFZGdU52c0xQUHNq?=
 =?utf-8?B?cVRQOFFESHBYZThWaEpKY1JnbWZmdm44ajl1eUp2cFFQdVA5VytSMmk3T3Rp?=
 =?utf-8?B?UnFISERLejE3M1BScEdqdWFWOHgzbmhHK3o3RS9QS2RZbnJvbVBMdW9LQ3Fm?=
 =?utf-8?B?eHdOdG1VVi8yT1NMNlRBZU9GT0JkbTFza3VwWm41MkFxWnJrd2h3cHptT3RY?=
 =?utf-8?B?QnhpZ08rVGdQMTRTMkt0aktlSmJTQ1hNTjdsNS9VSnR1TFc3ckdKZ2h1S280?=
 =?utf-8?Q?eZBMAjXUEucfzcUx9K+eTBN9ZouBhQ6E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHhDbUZhT1d1eXlEMVNXWlVOSDF4QXZCcHZJdmY4NjN0QWZIQzZUQkVYT3k1?=
 =?utf-8?B?ZGlHOUhRWjVkTzBWcU91dFB5c1lKTFhpYlpzWDNOMXArYys3eVFtOFdUOC9U?=
 =?utf-8?B?OTJzQnhoOG9pUG44eDEyaG4zL0lVSnV2MlBLR2VQbUFjYmVibUt3UXIrWmZF?=
 =?utf-8?B?WmRJcXIzRDIzV2JJZkg1L2V4TmZCSzVGVTNTZ1B3Mk54WE5RTm1DYWVxSlpI?=
 =?utf-8?B?Y1ZWNWJVRndvWXplK1dKOXNYWmlEQ0g0eDNSdUFXSi9OKzJSVFRUUFduNWp1?=
 =?utf-8?B?MmJCbXJJbldIUVRqWjdyYVhYWklOYmU4RlZrc0xSL2hIUlVtNENDQWlqSGFV?=
 =?utf-8?B?UnJncXNGbVZodU1tTFhPTitnNjlqYkREQ01sY1JCeExNRVNxbCszc3ZWR0Qw?=
 =?utf-8?B?b1MzSkRUR2xpb0prVThaS2IzaUVicWp0cjhCVE9FYkZuUG9CYmtXZndJeDJC?=
 =?utf-8?B?QjJacjd0S1ZmbDkrN3pmK3dzbE5Gc1VGTzVBUGtYWktPZy9CVlhxQWFWZnU4?=
 =?utf-8?B?RXd3TFNzUFZqdklpZDFYTDRQQlU1Q1FGV0hndDVQTk11ZTZML0dUS2xzRDFN?=
 =?utf-8?B?MjhTazM0ZUhsN01ETlNSTENuSGY0TGtmeU5DbU9jZGN2VE1oY1dXQXBGUjZx?=
 =?utf-8?B?NjJsYzBvamZ2QlFtQThRQk1WQmYwRk91T0JiY0hWNEcybm1KSVFPWEovRFgy?=
 =?utf-8?B?YnFjNzMzTktpRzlXUmNYZk1ZUTIrOGV6K1EyMTg4ZFloRFNMSGJ1VjJaZTU1?=
 =?utf-8?B?RVRwOXlCN0tUcW1XRzVaaUJ1R1dSeDcrZTgwNWdrYm1obFE0bFBDZzRYUTM5?=
 =?utf-8?B?UlhhbVdiZEdlN0JUdkVyazNPSDBFTUZXSFN3RjNJdFAzOHJXL1dIZjE5SnVz?=
 =?utf-8?B?UVlDRWszODV1RGRWUVl5bkpFeGZNWmxSUnNOWTVJWFhYNmV0cisvUmpOaG9j?=
 =?utf-8?B?MnRqalA2eWNET0s3YVZMQm5IbTZNU3RUelBnSGxCakxvNkVzZDVQWUsxNnlX?=
 =?utf-8?B?dnNRN1hmNVkyRlk1UTFwbVhJUC9nMmtub3hKeFdzemd5S2I5QTRRZlVYc0lK?=
 =?utf-8?B?NS9lTmVBelJsRURXc0xuWjhpaGdCUFlNdDRsdGpUVkRJcjFtSHYyV0J5U1BD?=
 =?utf-8?B?L0x5LzJqMTlnN01vZnNnNGM5WFUwODJTTU51R0FUck9DNG9DU2loK0RwS1JE?=
 =?utf-8?B?ZTVJcUErQzgyREh5YTh6UmxCQmFKTWVWVDdxU3V1ZDVpOHQ4WUMyd2lUajJ6?=
 =?utf-8?B?M0lQdXRRMWppRWUzRzUrLzA0MlZzRDM3M1VBZVByMjZOckF2ZThBUTE1WVVV?=
 =?utf-8?B?TnlBQkpmdHFCOG00R0dGcml0N3lhajRaYUJ1RSswNVJsTDc1dmpIRG96UlRZ?=
 =?utf-8?B?K2hoWkhHT2laREVMKzNyQkNha1JhQmlLZ3lXZ2EwVmVRUmx4MmpFMGw5Nkxi?=
 =?utf-8?B?T0Y3NGhaa3JQYXZpN3JoaUlQTVlnMjQ2S2dvSE1iUGMxWkFoeFRQTDFNMUdz?=
 =?utf-8?B?MS94S1lZYlh3cWZsNWNSSWZyQmpSTzBoTm0rMUprR0Vpb0psb1RudTFPWmlU?=
 =?utf-8?B?OXQzTXZ3RTFnZnB4MCtDN3dmdHVSZ3BHUk43MXg0THZXTVNJUnBIK0l5ODA1?=
 =?utf-8?B?elhJbDk4QUw1Zlg0bTFLbHVITmd1V0lCc2JKYml0enRRY2QxWitOZFFtY1dW?=
 =?utf-8?B?ODRlMFNEbjBFSGplUHdLY2xIbUlySVg4bUVBa2VCeDZ0Q1dvQnVkRDJDdE91?=
 =?utf-8?B?MkEyQkZLamp0YktIK3Q4K2N1NUhEMFZtSUo5TUNLV0l4M2xNUzVURE9RY2da?=
 =?utf-8?B?UkQ0REd3VnJMN0hGUkxkZTFWVGZyeWVGMkdKTnQrOXBjR1ZoV3JIQ1Y5ejVI?=
 =?utf-8?B?c3MrZ1dWWXIycHI1S2g3SkhvcDhyWjdVb1hwdTNaTHBRL2pKUkZkbTludENO?=
 =?utf-8?B?dThDelY0VHdkSFdCM25UMkhuRkpkK3BrejgyRVFDZk5IUDdNMHNmbjQyRmNW?=
 =?utf-8?B?bk5VMXhFMENIWUU4cFlQbk9Jb0lsY0NRK1ROQWl4RnBGZ2JDbW5sZFNIVllm?=
 =?utf-8?B?VzJXSUdrSENnM0ozMmhjcDc1SExKL2l6RFN3Q2w2RTQyTGF6OUR4ejZPWlVo?=
 =?utf-8?Q?OyGwXGiiv/dLMtGwdArlENCs3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dd4931-a2e2-41e8-1483-08dd1f7a1c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 15:39:08.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sx0hB1jRkr5tOl89Zg61GKluF0jzWrcqPF7lm2nwaLgkkVldDIxx+fImP6YyHbniyRR71txG6cz5FJmoaLYflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com

T24gMTEvMjkvMjAyNCA0OjQ5IFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6DQoNCj4+IEFkZCBSeCB0
aW1lc3RhbXAgZnVuY3Rpb24gd2hlbiB0aGUgUnggdGltZXN0YW1wIHZhbHVlIGlzIHJlYWQgZGly
ZWN0bHkNCj4+IGZyb20gdGhlIFJ4IGRlc2NyaXB0b3IuIEluIG9yZGVyIHRvIGV4dGVuZCB0aGUg
UnggdGltZXN0YW1wIHZhbHVlIHRvIDY0DQo+PiBiaXQgaW4gaG90IHBhdGgsIHRoZSBQSEMgdGlt
ZSBpcyBjYWNoZWQgaW4gdGhlIHJlY2VpdmUgZ3JvdXBzLg0KPj4gQWRkIHN1cHBvcnRlZCBSeCB0
aW1lc3RhbXAgbW9kZXMuDQo+PiANCj4+IFJldmlld2VkLWJ5OiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1pbGVuYSBP
bGVjaCA8bWlsZW5hLm9sZWNoQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gdjEgLT4gdjI6IGV4dGVu
ZCBjb21taXQgbWVzc2FnZQ0KPj4gDQo+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRw
Zi9pZHBmX3B0cC5jICB8IDc3ICsrKysrKysrKysrKysrKysrKysrLQ0KPj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmMgfCAzMCArKysrKysrKw0KPj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmggfCAgNyArLQ0KPj4gIDMgZmls
ZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+PiANCj4+ICsv
KioNCj4+ICsgKiBpZHBmX3B0cF9zZXRfcnhfdHN0YW1wIC0gRW5hYmxlIG9yIGRpc2FibGUgUngg
dGltZXN0YW1waW5nDQo+PiArICogQHZwb3J0OiBWaXJ0dWFsIHBvcnQgc3RydWN0dXJlDQo+PiAr
ICogQHJ4X2ZpbHRlcjogYm9vbCB2YWx1ZSBmb3Igd2hldGhlciB0aW1lc3RhbXBzIGFyZSBlbmFi
bGVkIG9yIGRpc2FibGVkDQo+PiArICovDQo+PiArc3RhdGljIHZvaWQgaWRwZl9wdHBfc2V0X3J4
X3RzdGFtcChzdHJ1Y3QgaWRwZl92cG9ydCAqdnBvcnQsIGludCByeF9maWx0ZXIpDQo+PiArew0K
Pj4gKwl2cG9ydC0+dHN0YW1wX2NvbmZpZy5yeF9maWx0ZXIgPSByeF9maWx0ZXI7DQo+PiArDQo+
PiArCWlmIChyeF9maWx0ZXIgPT0gSFdUU1RBTVBfRklMVEVSX05PTkUpDQo+PiArCQlyZXR1cm47
DQo+PiArDQo+DQo+U2FtZSBxdWVzdGlvbiBhcyB2MToNCj4NCj5TaG91bGQgdGhpcyBjbGVhciB0
aGUgYml0IGlmIGl0IHdhcyBwcmV2aW91c2x5IHNldCwgaW5zdGVhZCBvZg0KPnJldHVybmluZyBp
bW1lZGlhdGVseT8NCj4NCj5JZiBub3QsIHdoeSBub3QuIFRoZSBmdW5jdGlvbiBjb21tZW50IHNh
eXMgZW5hYmxlIG9yIGRpc2FibGUuDQo+DQoNCldpbGwgZml4IGluIHYzLg0KSSdsbCBjbGVhciBQ
VFAgYml0IHdoZW4gdGhlIHJ4X2ZpbHRlciBpcyBlcXVhbCB0byBIV1RTVEFNUF9GSUxURVJfTk9O
RS4NCg0KPj4gKwlmb3IgKHUxNiBpID0gMDsgaSA8IHZwb3J0LT5udW1fcnhxX2dycDsgaSsrKSB7
DQo+PiArCQlzdHJ1Y3QgaWRwZl9yeHFfZ3JvdXAgKmdycCA9ICZ2cG9ydC0+cnhxX2dycHNbaV07
DQo+PiArCQl1MTYgajsNCj4+ICsNCj4+ICsJCWlmIChpZHBmX2lzX3F1ZXVlX21vZGVsX3NwbGl0
KHZwb3J0LT5yeHFfbW9kZWwpKSB7DQo+PiArCQkJZm9yIChqID0gMDsgaiA8IGdycC0+c2luZ2xl
cS5udW1fcnhxOyBqKyspDQo+PiArCQkJCWlkcGZfcXVldWVfc2V0KFBUUCwgZ3JwLT5zaW5nbGVx
LnJ4cXNbal0pOw0KPj4gKwkJfSBlbHNlIHsNCj4+ICsJCQlmb3IgKGogPSAwOyBqIDwgZ3JwLT5z
cGxpdHEubnVtX3J4cV9zZXRzOyBqKyspDQo+PiArCQkJCWlkcGZfcXVldWVfc2V0KFBUUCwNCj4+
ICsJCQkJCSAgICAgICAmZ3JwLT5zcGxpdHEucnhxX3NldHNbal0tPnJ4cSk7DQo+PiArCQl9DQo+
PiArCX0NCj4+ICt9DQoNClJlZ2FyZHMsDQpNaWxlbmENCg==

