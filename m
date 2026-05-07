Return-Path: <netdev+bounces-285337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC4rHIGW/GneRgAAu9opvQ
	(envelope-from <netdev+bounces-285337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A134E96B7
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95BE6300B504
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B653F0AB2;
	Thu,  7 May 2026 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJDSTxCs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B13F9F36
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161261; cv=fail; b=CBslOmjAtrQveYiU+r2KHcDnn/xqkmW/CHaukFOclXrQ+wOuS+bVvULeG44mUMrtxGpYGiuXHF72I/0W/YiumQMC/OoBl1Em5EYSpkYg5jiUS5zWWQw2n6JTkzuY+7Gz3lEehchMhoaz/QSf3teMAJWSjZnx3LhaiWjx5xLNYrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161261; c=relaxed/simple;
	bh=7xfNWICNz/T1VeiPcEs1hF6MoBj0ZQxgMzPJK+TIFGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIY9MCZ3iC7Xg1TiEbIIF3EXcsFZqLXYjBIcwts+AvHxTJS+6xNVNTGo9Omf1L1Vm1Hu1T+4PUXU8Bmop5VVPSWEgPXwI4/A2mCrNkKyruiDbi6O2URIPDVFhC6f76dX4DXwUPH/diN4T4KgPdFVpqS3+HX+B1yRSPvnnauFWY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJDSTxCs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778161259; x=1809697259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7xfNWICNz/T1VeiPcEs1hF6MoBj0ZQxgMzPJK+TIFGA=;
  b=XJDSTxCsuLo5oM7gmlYfE5n45D8lTah0UuGR41+8W/j4vGSZ9lkhJRpT
   6TxADvn82xB0y5HYaAqKu8X66HEFuHqMtzF7mSaNqTdnwbetjbi02Cld9
   z7+MjRQ6y0xbTCo04zJrmoOz9OeJJyvggTSwuhWUa7c282xj+nkiDnQF0
   NFRCsTfWjWsqvBI7uEpiKaTnJEHyH8vsHUIfwlkcJnwb3ye0szAF9bmYy
   V+2usPhsK3PpmtQIt2rTJkq0EeshwQygUxmcAyZf8Wo1V88jLwWtH5qQY
   7kvIaOiqL8nLzByc4XrKo+KUjhXbTBTcc9SyrWyCnCU1JisReG3B6Evbn
   Q==;
X-CSE-ConnectionGUID: jHi3A0w5TTu0cvVPQSAzug==
X-CSE-MsgGUID: 9Cy0ps3DQ3yjIWuSlsNsMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79102696"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79102696"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:40:58 -0700
X-CSE-ConnectionGUID: gkJSIvBcQq+ExWi09wo0Xw==
X-CSE-MsgGUID: 2Wot9z1PRxKjKVp808JxiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="259900905"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:40:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:40:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:40:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlQ8mG0wlwKOdqaFInEVEl6LXHvuaeEG4uAn6mfDjl3vqbhVKlxRbSwAFapCbEi9I+qSUJGk+smoGcPdvePeI750wMuJrZVEz8RnpA4/Hu4e5YtX7cf7UTUY7TfDgA2rsY62fzMSJkA9TZawg6Ybk31kf9qgsAkGufyNy8iT6TJ0t+bO6uKPjNQD7vqsTuQ5LxErqKZVS+pQq/mzIMnw3RAMOZr5AlDuSQdGqWnKYGI3vXoq/aSY/y56IKQkbxx5HRyrnCGEq07oLjfWw8vka6avzuZ6AKa3xTIsZHkXOSxwsh8a3gimAYFu9lgqo03n98J/tb5baRCzwJxJuz+b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xfNWICNz/T1VeiPcEs1hF6MoBj0ZQxgMzPJK+TIFGA=;
 b=F/eCLcL7FqJOvnYjWinb30oAgPpv6pzsIq4vtKx+A9xZJZyS0eWoPDwoZxnxIiXuYSHQZTtUX7QmPqst/0rFp3Nyv2khrNRZJpgxCkp1lFUwpUNTgzYJ5y2LL2POqC1IM86CdNC9fIKyXSTy1/5ciGkK9DfBPGbx+DGVqVyYx9vseiN1mwjoGVKBCkTclwE2u2NEulxYXR3BKS4gWQ8+zSj3i5HB9PI3vlpPgHecaMYHqh1fhDzvAyUU896ZeOGme4nRrV71AjBqdI3W8BitwMsiWfHG86NI3+cNXB6YMAmG06v6mnme253Qg1c3nNw1Wp0m7MfJ5Hhoy0F6s0RChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by PH7PR11MB6425.namprd11.prod.outlook.com (2603:10b6:510:1f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 13:40:52 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%7]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 13:40:52 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: add SBQ posted writes
 with non-posted support for CGU
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: add SBQ posted writes
 with non-posted support for CGU
Thread-Index: AQHczMq5GIeP3G7MukiDrkPmLuuG7rX+pXoAgAQNkYA=
Date: Thu, 7 May 2026 13:40:52 +0000
Message-ID: <PH0PR11MB4904D0D583767208A879A576943C2@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260415112706.1562382-2-przemyslaw.korba@intel.com>
 <85ec6953-3a52-4ea6-9c74-d798bf5ecce3@intel.com>
In-Reply-To: <85ec6953-3a52-4ea6-9c74-d798bf5ecce3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|PH7PR11MB6425:EE_
x-ms-office365-filtering-correlation-id: 3bbb85bf-77a7-4f9c-2748-08deac3e41ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: kkQHPKgRz88dsOqQESZ4h3bknKezRytk2jJVSFQmwftdCdKhgV0L3CVacFyNc5LVqFuCAbF5qnRIfjalMmNQ+WQieWCLx+ZXHG3twBS44pSx6PGn/FDX9vlBddx/olxjAwvxc/ePOjx6WjxtPa8RO7/hD+HUqM4afV48UJ46Tnux6ymNf9ScJQErzDyfs0RkTm0WYLa5rJ3cKorRim1gtoT9wK4pXafuSxESewR8cxV7Puz/37yS6aXM3aZ2zrWeL4LDo5BH82InMe7nXbsMTUYYdEXtvnMk2M9rYDSEzs3mqp9IThejbqrptTt3ZeooqpDhHKbnRgQRNnHZo9AbXXVyZHy+HDSAOODhX1Ax3xihPVBKsfVuDQZ70iU2tdn+hJWjpur6vgd+LTbyInZuXY+h4Ft/2YfHa0BCm1oe1Thct9ZkO0oWgTsNKY15JpOLOi2A3TXd8ASjkc0INd3y5FvJhQPq2qlhvAlq5gTz5NtCmuweOHwpzILvqoe8jgZMv/LZTZd3kiwh80hNAdoPEIv0VY0gq/9SOzl8AbAPcqb6iR/lt3h8KZbC0C+z3v5MfLOEM9wZbSiT/xFtZAPyvfjlAwxIMn8BRfEK8I2/9CdwOseQMJYKDxHLSnVcY49YPo9yiuqlOSFB649xCrzMv2+e/QJ95VmJn+/RGY5/oyjx56xwoYblayuGPXHkUSSAWlDuBRy59WZqNWNgQe20v1lyRw7yybYdCvghEQ5lHlKG9bIUNd3DW7abl7ZkTdKK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW52OGhMZTU4c1FjOE5TOXh1S2dtVFhtdHJTbXVJWmtXR3VCL2FGQzA2LzBU?=
 =?utf-8?B?aVZweFd4VjJGYWp2bk9Pd3dWbHErN3dzcWRwVmxrZEdTb3BIdjRPazlZNVkx?=
 =?utf-8?B?aWNma3RsUUZrUStyN1NkRmx2SWVlcndXQjZUZEtJcnpjTUErbjlqRFdhay92?=
 =?utf-8?B?QlRaK2JOdU4vZFQrbWc3dTZ2SEhtRjVnUXZZM1daajdjaG0xbGlDSXlFdUsz?=
 =?utf-8?B?SCtTT0Rwd1dzdUNhSWVyYVd6cnZUYlZpVE5wV1lUOENGZ0lRYk5IcVhiNEwz?=
 =?utf-8?B?Qm9IZHNreGNDekZKTmtwa2RBN3JNTzBiV1NoeHBBTTVuUHZMdlBRaWdVNXh6?=
 =?utf-8?B?cEF4V0paOVlpRWdLWVdiWTR5RXZnREhVTUNnUTRwSDRsWnFRdkl2T1hhVU9N?=
 =?utf-8?B?RTh6TDlwcklWWis5VkhwQjZIclRYWmNuL3dlR0NFQjV3VnBZQW5lMDVkOFVH?=
 =?utf-8?B?alV3dEUzdVoySFRMMGVjck0wMlZXY0lCZzkwR2tJZktXdjI2SUxHWkZDSDB3?=
 =?utf-8?B?a2ljTXVhKzdERlpERzhsYmxIMXc1elZTcUxtOHNVVWJHeU5wYnc2ZGJhMWlL?=
 =?utf-8?B?cFFLR3l2M09HdVM5SUw0ZlVEQzhMaFZaVUhHMlVhNGJVVm1ncGROUDVwOHVq?=
 =?utf-8?B?VnB5TEFZVHByRzBNcUlUYUdzTjg3YUFpQWJaUnVqRVJmdnFHa2o1eE1YWkNB?=
 =?utf-8?B?RFRoZDgvdEZ4Q1hsQktFNjhjVVVXU2dKR0EyQXhaTXZ3OHdENFgzNS9BNEFP?=
 =?utf-8?B?Ujk1N21aS3N1cTV1VzBzQzdvdEpDNDZsZk1SdUo1cjI5Zk03cCtWbk4wZ2w3?=
 =?utf-8?B?aXU0Z1d3bll0U084eG1yWFRXeVowa0QxT3BCRUFZRmorUjB6TE1nZ1RFbmRJ?=
 =?utf-8?B?RlFFMHZrOVhhVzlqdCtmeUFTTlhMS0ExemxrenNTbmFrQm9TVXYzWFhqMXJr?=
 =?utf-8?B?Z3dHd1A3TFpZcFF4NTlnaC9UR0RqZjRscE9wTDlrL2xvMzlkQTlTMzJBZ01U?=
 =?utf-8?B?MFR1bm9HTFNkVW5TZUdvN2x0YVBSdTlHN0Q3UkZ6WWxoRElhMUdDM1lSbVVN?=
 =?utf-8?B?OElEaWlMM1lYdXREdTNNcUhzMWdOaFVZNGwyaVRwSXNJUEcrdmNxcm5IRjhM?=
 =?utf-8?B?bTR4UjZvckk5NXVueEtTZ2F0aVlDMnhXcW02V0FnQ0Vlc1ZNMU42RzYvL1pJ?=
 =?utf-8?B?dGZERS83V3hWQVJZUkpYVVMycTZVcFUzUldZVFJqTW4yU0I3U2pUWURkcDl2?=
 =?utf-8?B?SUJxZHNqUTN4VFQzZTArVUJqamM2ZDhrYzEvWlcxZytJSzNDOHE5ZFNpOUo1?=
 =?utf-8?B?RVBlNVZ1bFdrZWtYRWNoSzlEVHRMaFNvOG5SSjlRVFFNcHMxQ1pYaTRpNjBO?=
 =?utf-8?B?TFhWcXlLb0dPNlVjbDRZRWFKVG55bS84U1BxWWdyQi9Zb2lnSGkwTDBmZzZC?=
 =?utf-8?B?VWNPd2U0ZkVxT0VXbDZrMmZpUkg3Yit1SWN6eWpJWC9kdWxHSFhsaGorV3J0?=
 =?utf-8?B?dXJMb1c4NUNqU29xTFM1TlIzNVk4b1lLQkM1czVMbHpyYXdlS3B3a2hsRkZK?=
 =?utf-8?B?WnAwNXV3SkZpQy9SU3k0bXRhQjZmdGkxRWRscGxCVDBKamc0ck4rOVI3TTdo?=
 =?utf-8?B?YXlqdXQxS0Z4bFdPRkRpa251ekJCZ0hFSkdZUnFkTGIzVVJzTEs1UzZpTjhO?=
 =?utf-8?B?aW1QZFpxNUduVlVGdVBxV2Q1RGM3bGlFWlNLeFJEdm5ORWNHYytTU3dpNi94?=
 =?utf-8?B?L00vc2p4d1RFVFNOM2xsYjBxYitjTFZndHBvQUMrNnRic0lyVW1iQzQwaHdX?=
 =?utf-8?B?UVVYWUZ3aU14UkxXMGVlckNSZVVNNDdzajJaNVliMUNwV3ZwT0ZHcTNQRzRs?=
 =?utf-8?B?Z0t1aXZsV3pDcGtJZjhmWFIxTGZoS0pUL2plNjFXSC9WSDNGZkFHMGd4Q0xC?=
 =?utf-8?B?ejUwTmhJUUhQZFM2QSs2SFFWc1dYaG43dUF5c001S1FPdi9IMURSTVM4K0c5?=
 =?utf-8?B?b2k4OVlWa0lrQVRldmpjT2VlTENPT0owalRRcG9adXlYWmU3OUIvM211YTh6?=
 =?utf-8?B?bFFtMlhzWjJLM0swd0FLRk5SdDFoN2xXSDRvdmJWOXE2QmxGNmxuejdhV0F2?=
 =?utf-8?B?NlFvWk1POWcrV0xsM1dxVmRxNU91dVliS0ozZStienNqR2xQWGcvbEQzNXZt?=
 =?utf-8?B?aG1ZSUs0S09jSVhjUFZ5bk0rbW40NnBjbjVHTXBCTEFBbWZ0U1VVZ3RFcHA3?=
 =?utf-8?B?QVpkakJJUE80UlVaa21yWElUTDl2TUh2dFdjOHpxdS85dHJoMEZVNjZWMmwr?=
 =?utf-8?B?bnNMQjl3VXZRZVhHdXhvNkF4elJiMmdNZHVFM0w4QjBuTFJqdmpuMWtROWJR?=
 =?utf-8?Q?YL25vjOM7itkToph1OQqrjj4dnoq+6E2xrXtUvufSB0V/?=
x-ms-exchange-antispam-messagedata-1: Mf3/opV7oUiugQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BNVVFh/Ivf151ORQG9/9xUJ8PWuuA528jmxXcI7CHtoWZFk8O8DefISucHlS8rfQ4O6FaWFW86YaEfOnXQVY3Axzr+1ax7xbXS2UT8mJMutrN6uZCZpH4U2E1EZaToZXDSB4zy7xqAlAZ8vBNLdeNCDf1EJWgVPdjiunR7B7NOqd3TyLIr1iDqDZ3ka1rhLigIDbC8AojHa389sa2bQmNSfF2OshFhWLNzXsaIGLGgdjtsrChOEP86FObrqB/xUlyPWoq7/RDPKY6Cp3y8tYNSwdZQq97PJZZc6hq2iTew9G5ZWhQbYwZR7KsvG1DEeoSSJ7x3Z0tnaak0HOwpkMYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbb85bf-77a7-4f9c-2748-08deac3e41ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 13:40:52.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GsFuhhd3JcbTcofXeTNBo4XVqoAycta747t4SM/q6oPc+BXYE1rJnbDsWoj1MS8j/72SKCKdouNomnkLGdvYoogdtqhfXLksOoADR/kxGck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6425
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 65A134E96B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtlbGxlciwgSmFjb2IgRSA8
amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgNSwgMjAyNiAx
OjQyIEFNDQo+IFRvOiBLb3JiYSwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5j
b20+OyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29t
PjsgS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47DQo+
IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEt1
YmFsZXdza2ksIEFya2FkaXVzeiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0XSBpY2U6IGFkZCBT
QlEgcG9zdGVkIHdyaXRlcyB3aXRoIG5vbi1wb3N0ZWQgc3VwcG9ydCBmb3IgQ0dVDQo+IA0KPiBP
biA0LzE1LzIwMjYgNDoyNyBBTSwgUHJ6ZW15c2xhdyBLb3JiYSB3cm90ZToNCj4gPiBGcm9tOiBL
YXJvbCBLb2xhY2luc2tpIDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT4NCj4gPg0KPiA+IFNp
ZGViYW5kIHF1ZXVlIChTQlEpIGlzIGEgSFcgcXVldWUgd2l0aCB2ZXJ5IHNob3J0IGNvbXBsZXRp
b24gdGltZS4gQWxsDQo+ID4gU0JRIHdyaXRlcyB3ZXJlIHBvc3RlZCBieSBkZWZhdWx0LCB3aGlj
aCBtZWFucyB0aGF0IHRoZSBkcml2ZXIgZGlkIG5vdA0KPiA+IGhhdmUgdG8gd2FpdCBmb3IgY29t
cGxldGlvbiBmcm9tIHRoZSBuZWlnaGJvciBkZXZpY2UsIGJlY2F1c2UgdGhlcmUgd2FzDQo+ID4g
bm9uZS4gVGhpcyBpbnRyb2R1Y2VkIHVubmVjZXNzYXJ5IGRlbGF5cywgd2hlcmUgb25seSB0aG9z
ZSBkZWxheXMgd2VyZQ0KPiA+ICJlbnN1cmluZyIgdGhhdCB0aGUgY29tbWFuZCBpcyAiY29tcGxl
dGVkIiBhbmQgdGhpcyB3YXMgYSBwb3RlbnRpYWwgcmFjZQ0KPiA+IGNvbmRpdGlvbi4NCj4gPg0K
PiA+IEFkZCB0aGUgcG9zc2liaWxpdHkgdG8gcGVyZm9ybSBub24tcG9zdGVkIHdyaXRlcyB3aGVy
ZSBpdCdzIG5lY2Vzc2FyeSB0bw0KPiA+IHdhaXQgZm9yIGNvbXBsZXRpb24sIGluc3RlYWQgb2Yg
cmVseWluZyBvbiBmYWtlIGNvbXBsZXRpb24gZnJvbSB0aGUgRlcsDQo+ID4gd2hlcmUgb25seSB0
aGUgZGVsYXlzIGFyZSBndWFyZGluZyB0aGUgd3JpdGVzLg0KPiA+DQo+ID4gRmx1c2ggdGhlIFNC
USBieSByZWFkaW5nIGFkZHJlc3MgMCBmcm9tIHRoZSBQSFkgMCBiZWZvcmUgaXNzdWluZyBTWU5D
DQo+ID4gY29tbWFuZCB0byBlbnN1cmUgdGhhdCB3cml0ZXMgdG8gYWxsIFBIWXMgd2VyZSBjb21w
bGV0ZWQgYW5kIHNraXAgU0JRDQo+ID4gbWVzc2FnZSBjb21wbGV0aW9uIGlmIGl0J3MgcG9zdGVk
Lg0KPiA+DQo+ID4gVG8gYW5hbHl6ZSBpZiBkZWxheXMgYXJlIGdvbmUsIGxvb2sgZm9yIGFuZCBj
b21wYXJlIHRpbWUgc3BlbnQgaW4NCj4gPiBpY2Vfc3Ffc2VuZF9jbWQg4oCUIHBvc3RlZCB3cml0
ZXMgc2hvdWxkIHJldHVybiBpbW1lZGlhdGVseSBhZnRlciB0aGUgd3IzMi4NCj4gPiBUaGF0IGNh
biBiZSBkb25lIGZvciBleGFtcGxlIGJ5IGFkanVzdGluZyBwaGMgdGltZSB3aXRoIHBoY19jdGwg
b24gRTgzMA0KPiA+IGRldmljZSwgZm9yIGxlc3MgdGhhbiAyIHNlY29uZHMgdG8gdXNlIHRoaXMg
bmV3IG1lY2hhbmlzbS4gV2l0aG91dCBpdCwNCj4gPiBjb21tYW5kIGJlbG93IHdpbGwgZmFpbC4N
Cj4gPg0KPiA+IFJlcHJvZHVjdGlvbiBzdGVwczoNCj4gPiBwaGNfY3RsIGV0aDEzIGFkaiAxDQo+
ID4gcGhjX2N0bFs0NDc4MTcwLjk5NF06IGFkanVzdGVkIGNsb2NrIGJ5IDEuMDAwMDAwIHNlY29u
ZHMNCj4gPg0KPiA+IENoZWNrIHRyYWNlIGZvciB0aW1pbmcgZm9yIGNvbXBhcmlzaW9uczoNCj4g
PiBlY2hvIGljZV9zYnFfc2VuZF9jbWQgPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3NldF9m
dHJhY2VfZmlsdGVyDQo+ID4gZWNobyBmdW5jdGlvbl9ncmFwaCA+IC9zeXMva2VybmVsL2RlYnVn
L3RyYWNpbmcvY3VycmVudF90cmFjZXINCj4gPiBjYXQgL3N5cy9rZXJuZWwvZGVidWcvdHJhY2lu
Zy90cmFjZQ0KPiA+DQo+ID4gVGVzdGVkIG9uOg0KPiA+ICAgLSBJbnRlbCBFODMwIE5JQyAoRlcg
dmVyc2lvbiAxLjAwKQ0KPiA+ICAgLSBLZXJuZWwgNi4xOS4wKw0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogS2Fyb2wgS29sYWNpbnNraSA8a2Fyb2wua29sYWNpbnNraUBpbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUHJ6ZW15c2xhdyBLb3JiYSA8cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraSA8
YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhpcyBkb2Vz
bid0IGFwcGVhciB0byBhcHBseSBjbGVhbiB0byB0aGUgdGlwIG9mIEludGVsIFdpcmVkIExBTg0K
PiBkZXYtcXVldWUsIG5vciB0byBuZXQtbmV4dC9tYWluLi4uDQo+IA0KPiA+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2NvbW1vbi5jICB8IDE4ICsrKystLQ0KPiA+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3B0cF9ody5jICB8IDY0ICsrKysrKysrKysr
Ky0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vfc2JxX2Nt
ZC5oIHwgIDUgKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAzNCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pY2UvaWNlX2NvbW1vbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9jb21tb24uYw0KPiA+IGluZGV4IGY4NDk5MDk5NjUzMC4uMmNkM2Q2ZDQ1MGE5IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9uLmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2NvbW1vbi5jDQo+ID4g
QEAgLTE3NzcsMjMgKzE3NzcsMjkgQEAgaW50IGljZV9zYnFfcndfcmVnKHN0cnVjdCBpY2VfaHcg
Kmh3LCBzdHJ1Y3QgaWNlX3NicV9tc2dfaW5wdXQgKmluLCB1MTYgZmxhZ3MpDQo+ID4gIAltc2cu
bXNnX2FkZHJfbG93ID0gY3B1X3RvX2xlMTYoaW4tPm1zZ19hZGRyX2xvdyk7DQo+ID4gIAltc2cu
bXNnX2FkZHJfaGlnaCA9IGNwdV90b19sZTMyKGluLT5tc2dfYWRkcl9oaWdoKTsNCj4gPg0KPiA+
IC0JaWYgKGluLT5vcGNvZGUpDQo+ID4gKwlzd2l0Y2ggKGluLT5vcGNvZGUpIHsNCj4gPiArCWNh
c2UgaWNlX3NicV9tc2dfd3JfcDoNCj4gPiArCWNhc2UgaWNlX3NicV9tc2dfd3JfbnA6DQo+ID4g
IAkJbXNnLmRhdGEgPSBjcHVfdG9fbGUzMihpbi0+ZGF0YSk7DQo+ID4gLQllbHNlDQo+ID4gKwkJ
YnJlYWs7DQo+ID4gKwljYXNlIGljZV9zYnFfbXNnX3JkOg0KPiA+ICAJCS8qIGRhdGEgcmVhZCBj
b21lcyBiYWNrIGluIGNvbXBsZXRpb24sIHNvIHNob3J0ZW4gdGhlIHN0cnVjdCBieQ0KPiA+ICAJ
CSAqIHNpemVvZihtc2cuZGF0YSkNCj4gPiAgCQkgKi8NCj4gPiAgCQltc2dfbGVuIC09IHNpemVv
Zihtc2cuZGF0YSk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+DQo+ID4gLQlpZiAoaW4tPm9wY29kZSA9PSBpY2Vfc2Jx
X21zZ193cikNCj4gPiAtCQljZC5wb3N0ZWQgPSAxOw0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGlz
IGNvZGUgaW4gdGhlIHVwc3RyZWFtIHZlcnNpb24gZG9lc24ndCBoYXZlIHRoZSBjZA0KPiBzdHJ1
Y3R1cmUgb24gdGhpcyBmdW5jdGlvbi4NCj4gDQo+ID4gKwljZC5wb3N0ZWQgPSBpbi0+b3Bjb2Rl
ID09IGljZV9zYnFfbXNnX3dyX3A7DQo+ID4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhpcyBpcyBi
YXNlZCBvbiB0b3Agb2YgImljZTogZml4IHBvc3RlZCB3cml0ZSBzdXBwb3J0IGZvcg0KPiBzaWRl
YmFuZCBxdWV1ZSBvcGVyYXRpb25zIj8gVGhhdCB3YXMgZHJvcHBlZCBmcm9tIHRoZSBxdWV1ZSBi
ZWNhdXNlIG9mDQo+IG91ciBkaXNjdXNzaW9uIHRoYXQgeW91IHdvdWxkIHJlLXN1Ym1pdCBhIGZp
eGVkIHZlcnNpb24uDQo+IA0KPiBTaW5jZSB0aGF0IGRpZG4ndCBnZXQgYXBwbGllZCwgdGhpcyB3
b24ndCBhcHBseSBjbGVhbiBlaXRoZXIuIERvIHlvdQ0KPiBzdGlsbCB3YW50IHRoZSBwYXJ0IHRo
YXQgZml4ZXMgRTgzMCB0byBnbyB0byBuZXQ/IE9yIGRvIHlvdSBqdXN0IHdhbnQgdG8NCj4gaW1w
bGVtZW50IHBvc3RlZCB3cml0ZXMgYWxsIHRvZ2V0aGVyIGluIG9uZSBwYXRjaD8NCj4gDQo+IEVp
dGhlciB3YXksIGNvdWxkIHlvdSBwbGVhc2UgcmUtc3VibWl0IHRoZSB3b3JrIGVpdGhlciBhcyAy
IHBhdGNoZXMgb3INCj4gYXMgYSBzaW5nbGUgY29tYmluZWQgcGF0Y2g/DQo+IA0KPiBUaGFua3Ms
DQo+IEpha2UNCg0KSGksIHRoYW5rIHlvdSBmb3IgcmV2aWV3IPCfmIogSSB0aGluIGl3bC1uZXQg
d2lsbCBiZSBhIGJldHRlciBwbGFjZSBmb3IgdGhpcyBwYXRjaCwgc2luY2UNCndlIG5lZWQgaXQg
YmFja3BvcnRlZCB0byBvbGRlciBrZXJuZWxzIGFzIHdlbGwuIEkgd2lsbCByZS11cGxvYWQgaXQg
dG8gbmV0IGFzIG9uZSBwYXRjaC4NCg==

