Return-Path: <netdev+bounces-266636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC49B2xjsWnQugIAu9opvQ
	(envelope-from <netdev+bounces-266636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B09263C2B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E881630300C1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E36357739;
	Wed, 11 Mar 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O4eh8fHS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0C2836BE
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232977; cv=fail; b=oaIw3HjXsAQRMFrKljwqnx6yDx4zo+vbqMOMUYGCPNk/yzTuxD4dLk4qT3hblzD9VOCsk01lBinWYh3w3sUXFNMh1v2v6ev2BLE/uHNsLK1RFluU/zCry80N4xZN68J2ZFCFwevSo1ej7feFmNfnoELT5sK9IbA9dg9xfBnSR7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232977; c=relaxed/simple;
	bh=kHgfPhGT7X/IMcgvLkOmF0WKdpEpxAsmqrw7T3Ph0VE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umxbR2pXmwMJFKrEJGSvUtssRu+PZhgQ7DyPZALoDk77SSBYsALQyViZGsq0OuSmX4yXuqQgowDiSZDMNqG+YB9mXuxTQqVvqXDn5Xkr6Z2N5xQ7SotKaki8HazXY+LAbbXwhYOz1DFfO6n37RAKekyWk3Qs16tBintvy13o530=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O4eh8fHS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773232976; x=1804768976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kHgfPhGT7X/IMcgvLkOmF0WKdpEpxAsmqrw7T3Ph0VE=;
  b=O4eh8fHSJMgiQ6X52v8KJNNMKTd9Bu2MVOgI3sktBoHH9EBmuKSLUGIj
   9kPxWrfMrjF8oh9xRLzSk89bPKy6xO5bjdmeibXLy1d30O5OWTwBSxNOl
   pkIAvokW09KUIVBW1Sh+5qhTJfX5csc/UVE+z8oi8x2g9LVFWU21xF+sU
   MCAzjlRuN8HahzLcEAUbPwO1NEjpKqjlV98USfpdMDMQFVMja6ms/1zlf
   j5WxpzuK1FFlZ8U7SRmAjqtIZuz7beNouA8qKqvf7ZmXQ+K0fOHa9LRfB
   pTI5TZBMrdlhSzu4qI3iL6nnL+1sEztmRsyvwkRFia1+HTAtRdbAPrtiB
   g==;
X-CSE-ConnectionGUID: T9ITqjg6TTq/fOJTiFTJHA==
X-CSE-MsgGUID: r3XlQUN+S6WskHI7Z7kZDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74417605"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74417605"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:42:55 -0700
X-CSE-ConnectionGUID: woFRVVANQfqaSm34NC+9ZA==
X-CSE-MsgGUID: wsmdYc6mR6qzvYhGGXRt4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="243468040"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:42:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:42:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 05:42:54 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCNL15qMRF2KFb+imfZv7GuIRJ864Ilb+bB0i4LnVua6C19PwxoMIO7Wv8UP9sooHoOx2sdlEfRv7RNU91B90+dMjYL/sVNoafZMurYp9JrAedTdICXID1/J3PqIVpWS4dYoKZYIrOgGzWU6TfLKvqPgmOdcxGCONqQnrvHFb8qfFfrSVun/o8022dZfXw6gtswiBu6FaZTD7YHtx89VkWf5oszBKqSnCanyRrAR3LnmlWR3AfBolsF6g4ZUQJGFovs/Te7k/FB+1/X5E+Be7ePmZc+ArIXfrf6XfBG6JH3lMVTyN4b87QUM9wfy0KIk1Id3jb1wmi8+qbOmJKreCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHgfPhGT7X/IMcgvLkOmF0WKdpEpxAsmqrw7T3Ph0VE=;
 b=RTSIPYI45P+J0SC8kkjWDRgQdbB3lExbT+Y/ADFh4lSrlYN52YQmon2uJN2OBs40YRU2G/RC050/k7kSXdRYoCsH3elVmMjhUVIUiaxTOQetLhU6EKiIoDnT/n0+dtkIPcLWdhT06kgTz1dz5mvPABmn+EkpcR4oCLFum3wF6yPHy6wEAHjIP/GCQogMuQ/CW5xUGXbXPKTsOSviLXZ0RITzoPe0Yo2xeZjE+WQxwO8btqnXNZtqINYMj/TfwnIlkrYTUVdB5RYvg2ztOMKVem09Tg83rJ4ufob0Q5G9myuUZwU+lZFAdUqtwJTcDZlwP2VxFFU/LVjRIX4eGikAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by DSWPR11MB9559.namprd11.prod.outlook.com (2603:10b6:8:36d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 12:42:53 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:42:53 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported flags
 in ptp_clock_info
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported
 flags in ptp_clock_info
Thread-Index: AQHcr86Xy2U0MgoCgUGFZQFkE41emrWmZZQAgALj2jA=
Date: Wed, 11 Mar 2026 12:42:52 +0000
Message-ID: <PH0PR11MB490492AD301BFC6F7C3D952C9447A@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
 <530f6250-549c-46b2-8c53-3e91f843f6c2@molgen.mpg.de>
In-Reply-To: <530f6250-549c-46b2-8c53-3e91f843f6c2@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|DSWPR11MB9559:EE_
x-ms-office365-filtering-correlation-id: f58ee61d-a68e-43e8-86a3-08de7f6bb659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8YQHhaDN+KP+5m/Xh8tiNhYasEW5FKXxlBLNJOuUbKSczAK2JgQupuqLAx56RxpC6mcYdgGSj7DlyZfDjRkFzW8lGKTejVccUYGUwrCgfgCdZtiiAY6xcgD/I13MwwN3x3AB3lTiIWsuCErKh72RHiQiFVhuc+KcWN9UXxkgqfoJ2BrQ4WeThJK7ocJjZioOOTWBnoiXMmP2M1/UoAl9zmXNacu0rhHjyHJGEScyYzC6TykhDW3o5Pw64XUF0EY9/7Zx+OTwEFtlglDyIOwutpyDwyMp9X+pXEgM5gJn1Mzk5PVaWRXSYPZDxzkO4W2kkYAFBV+RDO0iJb/pBksUV1fIZTCrdhMO4zqeEKh7EDV8ibdLrrb23Hel1Z9NhcyJE5RiF1E0MS4Cfb5xnMjMkKp+F9wjeK6E1rZAuueo1PPUtUFYDjN4JOHi7RU/GFA54kBTKOIrk7whxqzj0kmh81QtIFo/gT340IudPhJ2Y0uWVUTx0woYwMHoTExYKm/wVVbdxyGKYMNgWiEkv0eIP8QryFmydSRd5GLjBK3zepnfzjKTQqp4X3tNt+6iLYyeHuAOoHfa32fMTmUUJ5FwhwwukRx8i5JOYmqzsKjl2uAAJfkQCSrERJE/c16zDTPapz4W5S5JoJDWP0hbwEhKasnDtE8gWpFjiwLRVi4tlqvXG813XiIc/hxuIgtlixQWBf+dkpHo9ndT82jzH/UrQI1NnCUJfxT37bsLqmn5QZBlsGKDPXoF8sEpuoM3habYEGAZb4LecqY5JGzRKe+2/pK4TbYjeEfEUCcmnevAMyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUJPeU9ONEdXMkVUVktQanJsVDRXUEdzQmlTNGV1dE5Fc2lQOEJOc01HM2k4?=
 =?utf-8?B?U2hraWxFWkx0QnZRcVZpT1FGK1lrdk9GYUt1NWl6VUlvalBXM21RTTUvTGd3?=
 =?utf-8?B?dW5tUUIrbTZHOTdOM3dsZmdoZVJKTG1rY0hHRzcxclZPeWFzVHUxdk1zTWJa?=
 =?utf-8?B?NHNBcU5IdGpzdEV3Wm5Pd3VoM3lpQjcvSjNkRFJQVE5iMXpteUk0RVB0R1BS?=
 =?utf-8?B?RDE4TThodUlXYXBteFllSzMzaHY2MVBUUEtoMWRqNDB3N3VjQnYzTkk2TUFV?=
 =?utf-8?B?M1AvNnh6SWZBQW83T3VuZnIzTDA3SEFTRS9vWDVja1ZyelVxRU5TSWdJejVp?=
 =?utf-8?B?RnkyQVBkaWFTL3VSNThnS3ExN1lwc09GaXFQdVF1aG5LZGE2Y3ZBNE1Ta1Jw?=
 =?utf-8?B?eG5zbTJKRDkyOFJyUzdSQ3F5eXJGTmwwU2srdE54WXVGUDV3Uy8yOHIrbmhp?=
 =?utf-8?B?T0MzNkJmb0pSc1dKdVE4MVRLNHp5MTNFeHRFWmF5TWg0VkNRQ2lPN1hXamla?=
 =?utf-8?B?Sjl4bzE5Z0EwVGFlVUlkVFpZanR5R3VweWNNN2tIb25NSVphREpLaXFxTHNM?=
 =?utf-8?B?R2h5Q2R1TDlzZVkwSVEwYmFOUGZsZDNnVTI1b3ZiUEZ3ZVU5WGYrR0xyUU1C?=
 =?utf-8?B?TWVjTzZYM3NqRXB6T3JmSWR5Q2o5VlFjR3B4VkhyWHV2QlRDd1V0WktsaTl2?=
 =?utf-8?B?SW5nTk5iWkZwVVUyZFRaL1FXU0tGcGpSSnNHZFlJVnRqLzh5cTkrZVVYc0Rm?=
 =?utf-8?B?RzFqY0trOG5XRGlJZ3c2TUtONHdPTHNHU1dSR2t1NlI2TnBLVG5HaHN5Ylo2?=
 =?utf-8?B?RUt4Q0lKcjREVThhL2o0Q25LOTV6Rm41ajQ3TTZVdVlJWmZYUWNCdHQ3Qlh0?=
 =?utf-8?B?YmNGRnZYK3kveWI4elBIS1hTUDJqQUdZbzk2Si9rd3BzSTdGWTBmdFhMekdo?=
 =?utf-8?B?ano3RmpkNFRvQ0FRWjJjL2R2S2llcWpGWEp4S1FpVFZmM2lYS0JKYUtCbXJq?=
 =?utf-8?B?ZWdpSUF0MmVNMG84aHpvL0xmT0hScWF3RFk3ZmpoVjVOTEVJdjhNaXRGZEZ5?=
 =?utf-8?B?VENZVWxBckUwakVYSHF0UjVOQVV2cEZJOWN4RWZiRTZTdTdWS3pROWljcEcw?=
 =?utf-8?B?bm5QdU5LTnRRdGdybHByaWVPMUxtcTlveXloOVhtNTlwYjZHbUVwK05iYU91?=
 =?utf-8?B?SndHRnM0Y25ML0RyYk9LaXhrL1dVWXB6cFlaS1htT3VES2ZzZUZMbEdjSXhu?=
 =?utf-8?B?aUJFekNpN2kzcWZSa0dzMWNoU2dCbGhFN1BPY25Zc2Z2QXA3blBvWVdxRFgy?=
 =?utf-8?B?VkZMYUMxT2srWGh6cVNVaGx3Y2Y0cWZaTi8vNWpjSkdvUXJmelR6Vjk4c2w4?=
 =?utf-8?B?U1o2YTUxU3hpc1B5SGdQY0pLY1djNVZKTDhNdWVHZngzWTNBdHM4bGN2T2ZY?=
 =?utf-8?B?Y1VvOGVxdEt5aExmRGFnTEdoRUJMU1BsZm1OZzB2OWVaeGVDMU5GdkNxSzJG?=
 =?utf-8?B?eFRWSGVlNkdqNDdDTDdaeDZydXpMVFdWZ1VBeTdUb09YY0h4Y1REcFlpY2Qw?=
 =?utf-8?B?UmtxeVMzQ25nZjB0dlBMaGlKYzZVNHc2Yi9OWms0YUdVaUlyZE9WUytueU5k?=
 =?utf-8?B?ZzJYdmt2WHN5dmRRVjdyVndyeUhQdWRtWGpOM0ZKdDQ3N1lCQW9JZStnRS93?=
 =?utf-8?B?b1QrVm1UcHZwMUlRUlYrS1l0ODlmZmV1Q25HOXlURXp0cHJ3d3VqU21CV0Fp?=
 =?utf-8?B?MHU1YkhBOGp2aWtYS1JWQ25tUWlxdWk2aVFza3FWOFd5elF0UUxmWDZRYVRG?=
 =?utf-8?B?aGlJMEorbitLY2ZlNFdQQllKbTNheFNVMjZXUmhZdkpabmNFa1VQUmkrRmc5?=
 =?utf-8?B?d1lMdjh5ek9wbFg2ZU5MWmFsWVVlR0tlY0lmV29FdVRNaXRQNEdIVUZCc1dE?=
 =?utf-8?B?K25RZGpBT1NNUjV4TGVFaWdnY3QvNldnU2JZZkoyUE1ESEJXY0FIcHd4d01r?=
 =?utf-8?B?WFIwanpiQ0dVeVVndG5CNEt6VUVnSzRwdG9pdXJyYnVxd1QxamVEMk80U1Yv?=
 =?utf-8?B?TzIwRnNsUFhFOVg2N2x5VzhnQW84VDVOdjNPS0R1dWJOZjk4blgwR1M3UVBx?=
 =?utf-8?B?bHBkR2lQRzY4SVhhdC9FRDRtZmYwOEhGMXJTRVNnOGxEMGFJQXg3b2dBb0lp?=
 =?utf-8?B?UFlMYk1LNHptMWY3dkhNYUpYOVVyWkNPMmkzQVdhcjBnY0t1RWxHZFFsTGtU?=
 =?utf-8?B?dEV0bWJ6aEoyK0xoZDhUMVovVzRVSGlwdVdtZVVPL0xvTWVqaEpVWkZOMkda?=
 =?utf-8?B?RHhIVTBHQlFFQzhqbUxONzRLdjYvQ1RHUUZDd1R0d1lYOUNzU3A3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tc0vNti7pCSEcdvMJh2YEkxkE6cr9RlGgVNvK67xQhdV7KQ7TnYl4oKeXetB2M7fQvrQ1cLKobZCYw+dw3k8EBhyRutfeJE2IkW1BhAM4f9U68XljfJ5H7BesfXkAJh/NwjRQG0Vq1GbIxvP4fyq/niCZX3YuQiRevNOBDWh36JWvfyP4j8jXAoC2XT7c2p2jSTaSN9pkLUTVAeY9jF7oXMwyTYvwE53LXjeonnWZrzmYmMgbCOG9z5fBegXGtYFglE8mzo6MfFk0uYVsitVXtTlhDFsGEB0FWaJK4TzvvkpbaigWnaB1p1PRK1dx/YbNQIscvoDqU8MeYOWZby7XQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58ee61d-a68e-43e8-86a3-08de7f6bb659
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 12:42:53.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4rmscI7stHk3wf+OklMFunAmoo4Bk1G4y0GT2Z0n4j4zgF5DhSbGZOk8CPWDF1pZ8ii+qdHuuzUaopKtgVie2r2xqYEsHxC8CfkMFShWwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9559
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 95B09263C2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,PH0PR11MB4904.namprd11.prod.outlook.com:mid,mpg.de:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:?];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[intel.com : SPF/DKIM temp error,none];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_TEMPFAIL(0.00)[intel.com:s=Intel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8
cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDksIDIwMjYgNToz
NCBQTQ0KPiBUbzogS29yYmEsIFByemVteXNsYXcgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29t
Pg0KPiBDYzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHRdIGk0MGU6IFBU
UDogc2V0IHN1cHBvcnRlZCBmbGFncyBpbiBwdHBfY2xvY2tfaW5mbw0KPiANCj4gRGVhciBQcnpl
bXlzbGF3LA0KPiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4NCj4gDQo+IEFtIDA5
LjAzLjI2IHVtIDE1OjExIHNjaHJpZWIgUHJ6ZW15c2xhdyBLb3JiYToNCj4gPiBTaW5jZSB1cHN0
cmVhbSBjb21taXQgZDlmM2U5ZWNjNDU2ICgibmV0OiBwdHA6IGludHJvZHVjZQ0KPiA+IC5zdXBw
b3J0ZWRfcGVyb3V0X2ZsYWdzIHRvIHB0cF9jbG9ja19pbmZvIikgYW5kIGNvbW1pdCA3YzU3MWFj
NTdkOWQgKCJuZXQ6DQo+ID4gcHRwOiBpbnRyb2R1Y2UgLnN1cHBvcnRlZF9leHR0c19mbGFncyB0
byBwdHBfY2xvY2tfaW5mbyIpLCBrZXJuZWwgY29yZQ0KPiA+IG5vdyByZXF1aXJlcyB0aGF0IHRo
ZSBkcml2ZXIgc2V0IHRoZSAuc3VwcG9ydGVkX3Blcm91dF9mbGFncyBhbmQNCj4gPiAuc3VwcG9y
dGVkX2V4dHRzX2ZsYWdzIGZpZWxkcyBpbiBQVFAgY2xvY2sgaW5mby4gT3RoZXJ3aXNlLCB0aGUN
Cj4gPiBhZGRpdGlvbmFsIGZsYWdzIHdpbGwgYmUgcmVqZWN0ZWQgYnkgdGhlIGtlcm5lbCBhdXRv
bWF0aWNhbGx5Lg0KPiA+DQo+ID4gaTQwZSBkb2VzIG5vdCBzdXBwb3J0IHBlcm91dCBmbGFncywg
c28gcmVqZWN0IGFueSByZXF1ZXN0IHdpdGggcGVyb3V0DQo+ID4gZmxhZ3MuDQo+IA0KPiBBcyB5
b3UgcmVmZXJlbmNlIGNvbW1pdHMsIHdoeSBub3QgYWRkIEZpeGVzOiB0YWdzPw0KPiANCg0KVGhh
bmsgeW91IGZvciB0aGUgcmV2aWV3ISBHb29kIHBvaW50LCB3aWxsIHNlbmQgdjINCg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFByemVteXNsYXcgS29yYmEgPHByemVteXNsYXcua29yYmFAaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3B0
cC5jIHwgMTIgKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV9wdHAuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaTQwZS9pNDBlX3B0cC5jDQo+ID4gaW5kZXggN2JjZWE3ZDk3MjBmLi44ZDc5NTg2OTIy
MzUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBl
X3B0cC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3B0
cC5jDQo+ID4gQEAgLTYwMSwxMCArNjAxLDE4IEBAIHN0YXRpYyBpbnQgaTQwZV9wdHBfZmVhdHVy
ZV9lbmFibGUoc3RydWN0IHB0cF9jbG9ja19pbmZvICpwdHAsDQo+ID4gICAJLyogVE9ETzogSW1w
bGVtZW50IGZsYWdzIGhhbmRsaW5nIGZvciBFWFRUUyBhbmQgUEVST1VUICovDQo+ID4gICAJc3dp
dGNoIChycS0+dHlwZSkgew0KPiA+ICAgCWNhc2UgUFRQX0NMS19SRVFfRVhUVFM6DQo+ID4gKwkJ
aWYgKHJxLT5leHR0cy5mbGFncyAmIH4oUFRQX0VOQUJMRV9GRUFUVVJFIHwNCj4gPiArCQkJCQlQ
VFBfUklTSU5HX0VER0UgfA0KPiA+ICsJCQkJCVBUUF9GQUxMSU5HX0VER0UgfA0KPiA+ICsJCQkJ
CVBUUF9TVFJJQ1RfRkxBR1MpKQ0KPiA+ICsJCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gKw0K
PiA+ICAgCQlmdW5jID0gUFRQX1BGX0VYVFRTOw0KPiA+ICAgCQljaGFuID0gcnEtPmV4dHRzLmlu
ZGV4Ow0KPiA+ICAgCQlicmVhazsNCj4gPiAgIAljYXNlIFBUUF9DTEtfUkVRX1BFUk9VVDoNCj4g
PiArCQlpZiAocnEtPnBlcm91dC5mbGFncykNCj4gPiArCQkJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiA+ICAgCQlmdW5jID0gUFRQX1BGX1BFUk9VVDsNCj4gPiAgIAkJY2hhbiA9IHJxLT5wZXJvdXQu
aW5kZXg7DQo+ID4gICAJCWJyZWFrOw0KPiA+IEBAIC0xMzQwLDcgKzEzNDgsOSBAQCBzdGF0aWMg
aW50IGk0MGVfaW5pdF9waW5fY29uZmlnKHN0cnVjdCBpNDBlX3BmICpwZikNCj4gPiAgIAlwZi0+
cHRwX2NhcHMubl9leHRfdHMgPSAyOw0KPiA+ICAgCXBmLT5wdHBfY2Fwcy5wcHMgPSAxOw0KPiA+
ICAgCXBmLT5wdHBfY2Fwcy5uX3Blcl9vdXQgPSAyOw0KPiA+IC0NCj4gPiArCXBmLT5wdHBfY2Fw
cy5zdXBwb3J0ZWRfZXh0dHNfZmxhZ3MgPSBQVFBfUklTSU5HX0VER0UgfA0KPiA+ICsJCQkJCSAg
ICAgUFRQX0ZBTExJTkdfRURHRSB8DQo+ID4gKwkJCQkJICAgICBQVFBfU1RSSUNUX0ZMQUdTOw0K
PiA+ICAgCXBmLT5wdHBfY2Fwcy5waW5fY29uZmlnID0ga3phbGxvY19vYmpzKCpwZi0+cHRwX2Nh
cHMucGluX2NvbmZpZywNCj4gPiAgIAkJCQkJICAgICAgIHBmLT5wdHBfY2Fwcy5uX3BpbnMpOw0K
PiA+ICAgCWlmICghcGYtPnB0cF9jYXBzLnBpbl9jb25maWcpDQo+IA0KPiBSZXZpZXdlZC1ieTog
UGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gDQo+IA0KPiBLaW5kIHJlZ2Fy
ZHMsDQo+IA0KPiBQYXVsDQo=

