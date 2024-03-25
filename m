Return-Path: <netdev+bounces-81568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA9B88A4AA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C69A2E6738
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A6F18E0D5;
	Mon, 25 Mar 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCPZ6bbx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD481AD545
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364301; cv=fail; b=EAOAyDiwySydNasbJOOYze97J3jb5orID/W2zbSOLjflRbBYVv+ypQqgFz9ZFqSISaJUxRB+mSXhNEYiC+51KJHBVMjYvSOgxDdmkbm+bzclD98gd19jFyNVf84hfOGWvfc0S6gUWQoHHiz6KFkPKfLLpmoCOtlKE8H/eHSqiVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364301; c=relaxed/simple;
	bh=zVz50duWob3Sygof177HWLZicWBU3dsQ+ZyUqTEGUpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N68Aox3fU1qeEeJRHV7rKsaxb5Gq2KClGJY5UA+2K07Un3Ih7KY1n4rxvAz9fFInWDT52xjWaORiPifud86zcgAJEVIeGHOhkd3nFzegFeipFKzKu5EOEURzuEo0PUvMRv5Y41LC32UukRXTeSAl9yhdSi4yBximpZNj00SZ7hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCPZ6bbx; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711364299; x=1742900299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zVz50duWob3Sygof177HWLZicWBU3dsQ+ZyUqTEGUpE=;
  b=KCPZ6bbxGBweSgdpKQn7cTop+jjf6CmN3XmxzXxFVQvYS9p1G2EhI4Ch
   wMxT0X8IEWIb5IcyXWjeZGpSzOW6+K3uIZZ+RMs4PwfMYwYqZ4HYeqlYH
   5AXBbXt5i+aiq3acOFHaeZbixXxli2JxWWGVv+AzombnBFsD4Gc43++0n
   XKjgxU5qGmvNJa61lilrbXaqfSsDq/xwlo3xcEcjlGpuL+P78wrCsCRYm
   LsYX/B6IctGIf5oC3kz2MdFCTf3HYIcDakRjVOVgCqu0AqDKfWwW3aTVM
   gf/Q/bNWyigkqxSDu7gAeLg1iAyE4DLoHZfQSMaemFXOu+4vpcVm4kV5a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6293105"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6293105"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="16245254"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 03:58:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 03:58:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 03:58:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 03:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVcinlwDnNE0IRHi3fsQWb4ray0xP6p/z2YEVQW7ifDoPhct9OxKl9dXenc7MT3/GPmDfmAIXm1mg3gkd/8lEOgFeg3nI5AVxagpmL/8f2l9B+F3xU0X/ou9DPwdIv7Unu3YPTqqe2+WMuhaCmuDFyDvZtpsPkB4hvS+D7LZCKObdYOaKGnpUUbaintr8/vx7vYETHC/WKN3+AUew4w2qBGbbsG19zdBfHoIBd7K1o0aE0hFETLueqOjHHyLyJAwGv/vIABuFeifa9pqSKnbiCoJm8croScUNbpGLuqy8eB3ttUiDDnJnYffLh16+zzynMbVa131Vp2/QxN4amqVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVz50duWob3Sygof177HWLZicWBU3dsQ+ZyUqTEGUpE=;
 b=gBn7sSCw/II75MZSRij9MYQ590YEfukbylpztcAogNLYzL1Gm/vooV3xKdNJgCpGtpDST3WawOIFWtEic5ECX+JOSFUzylkXt9JrsE4Na8OAziNkZz2+pCLOB2+hqhENMhKlIcIqP+Z7/pf6CQjL8ztbe5Cczyc1J4+vZeZtiGSkBGxDOMAWV1dFsce2b14b/jADGy7qPKV1bjTx2pw92TW//HWR2SyxhoUp7VLZdpem1WjTrPpBiAKQ4NEof6kQdjZ3VejHr78gxF9ogDkoGIUL4sW2+YQaRVM6ZM+6i9qDnacoHlY/urDWdipf8ZXZVSee00rI2sgrFyCD/NnmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:58:15 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::85:b53f:9a2b:e2a9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::85:b53f:9a2b:e2a9%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 10:58:15 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix vf may be used
 uninitialized in this function warning
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] i40e: fix vf may be used
 uninitialized in this function warning
Thread-Index: AQHadS4zMERROOCcoUaA+SjR4o5LILE1gCQAgAAbHwCAEsDygA==
Date: Mon, 25 Mar 2024 10:58:14 +0000
Message-ID: <PH0PR11MB588064233A6D761E9ED93E1D8F362@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20240313095639.6554-1-aleksandr.loktionov@intel.com>
 <1fa71d41-dc3c-4c1a-8b6e-70aa4c9511c1@molgen.mpg.de>
 <SJ0PR11MB58668956DC932D7C8E25B487E52A2@SJ0PR11MB5866.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB58668956DC932D7C8E25B487E52A2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA1PR11MB6097:EE_
x-ms-office365-filtering-correlation-id: 09987c07-1939-4de3-7591-08dc4cba788f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFS0poCFZBXwRA6EWJQOgdUqHnqDt6x3/rk534OwNLv/L4ZoPJJBAqO6zGYJOctbFuZR0MIipOYVaeB7G7kIDA3oOCzuikFBNsQwxYLGFTD+Zetol10oMLYma9y90Chd5M79NUoGxEDfVoP0csSJva0k3USOORuszsSI4EF4ZY5uYIVJPrqqzyZl+HVZB2bsd0m67A57gVj3ycTsMr8uHTPJB/PDp3nLdMrJaX79o7V6KcylpK9TxSMftpIGIDzeGYIdAeGs6lM3dIXErIXEgCKzmQ+53rngm//lioanQZ6YlflgKH8xEvnUd1liSm4Qzzae4+2vlkDykSdm4n8fe/TUh6eolk6UtC4Y19zHcNFI78ldpMyxBYOTZj5MxJowTU828Z93tybftm92R9JoXKJrt1lga+ziK2vXywxpdsvIFyGll4VGVt/WvWmKAyB/X7y39rqkYan0QtXuNN4oyyTqJ2XhL7v4a+hPf/avrLvt3y08JJvuS4rPMwaKMTsDc2eayK2xDypJXAOLr7Q10Co5AnbsmbTx0bWZN55/S2L7NVsBFqXjbKJcEqcfK7gwtOqwKh56XuSv+jDLePdGkMQIXWthQ56AxDnFr0qbkBhj9sbhEYm55iex3sqGqNJXrsNSIa453DklIrNanA/LduYv3QPVV2XawnZc4Cg2afIMCcfWQnEtZWKWMlYSlq0t1Q4ob+2kNUdRyG14dUQ0CKqXOM9QVequ3L9iPHdPPdA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjU5YzRrMzgwdFpvMXd3M25Fd3FsOGgwRVRVQjFSamltYTNxdFQxengzOWdy?=
 =?utf-8?B?cEIzeENDd1NSNzZVZi9YanlQSFl2VVpibGY3b3QwRVNsYkJLOXZoMEFPVWl6?=
 =?utf-8?B?Mlo5aUxvQTJRNSt4VTNHRTl0Z2g4RjVJYjVMSGZIWWU1L1NxYzlQMGhSK01Q?=
 =?utf-8?B?M1BoTHNvUWNoZ3ByWks1TUxtcUtETTdBM0RXUDVMaGRwcUVPbXdIcTBYWFg3?=
 =?utf-8?B?bW1ha3B1MkZ2MGQ4SWdMQWxPaDhkN3FxK21ncDZubjNJUGs4UmJtUVN1TFVE?=
 =?utf-8?B?U2tJK3FtUkxQb2tEWG1CU0xIQ1BoS1hBbVYrRjFqaEJGRjY2RVdERjEzek9Z?=
 =?utf-8?B?U2RJQ2plT3FxSWhlNEM2ak1nSXhRc0VzdzlTZmJZQ0hON2VLMDFIWFlSSTEw?=
 =?utf-8?B?c3kyTTNYV1ZMazVoQ3RIbWhReFFNaEtYTjhLcDgwZGNXS2ZwVWYvalk3RlZl?=
 =?utf-8?B?ZFc4ajZKc3prNjFqNlFaRHJNYXI4SjFOYkF5OHhoTHVwM0wwSzJWZGoxTTly?=
 =?utf-8?B?M1JEamtCaWhQcTdubzZMeXdESzlibjdoQnhPV1dodjdiWnZhUVRsMGRZWkUw?=
 =?utf-8?B?MmFYUnV3QnJjcE5uU2lzeGx5ZGgrMjhWdTdHdkZZQ3BCRWNGemJHWnl3ZXJG?=
 =?utf-8?B?VDdEam11d3VIblZWaC9MNjcxN3IxN3JuMG16WVZLMHQ1bCsxdDlVSWpPZnUr?=
 =?utf-8?B?WVljVkxBdFc1dkFDS1FOek9uMVdRUFJaOFNKVFF1Z3lUOUltM2xsQURFUExP?=
 =?utf-8?B?blM1dmhXNXlEODdieUkzQmM2NmpxdkJ2UDl4ZGx4NWJqckxaT3FHNHRqdUNm?=
 =?utf-8?B?VUprZXh0L3cxb0hublR1T0l5M0F3NlZMR1V0dkpKUXpnbS96Rnh5RTNxKy85?=
 =?utf-8?B?L2V6ZWNyWU54em56bjRxZkZJd1Qvc3lCd1MyZVZaWWVFaTdGdTJXRzZ2MzAz?=
 =?utf-8?B?Rk9qQ2V1bDJsR3B5NFlzQUZFbTFta3pDMUxBVC9zUHFGRWtmcmhVYS9uaG8z?=
 =?utf-8?B?OUhudmI2K2IybDRvNXhnL2xvOU91a2hzL1NzN0U0QjZZcER6Q2F2WjdqUEdM?=
 =?utf-8?B?T1g3ZXRpbkUweTVHdi9QeS85Snh6RUU3MGQ2cFRRZzVZTHdHeG5ORElYUkxh?=
 =?utf-8?B?NlhtdHBoM1pYWTJvZHFVb2wraGpUbGtpM21ZSmI0S0lISkZUQVJFRmg4S0lr?=
 =?utf-8?B?YjdPYzVKczh6UHFzbmxsUnU5L2FWcVpIQmpWaGZ1T3BNa0ZQNmhWOUU2YnJN?=
 =?utf-8?B?cVZxSG5UajZIQU1jTHJ3N1ByOU5SVU9pNzRXNmRXdmp2ZFhBVUxRSVJ5UWtJ?=
 =?utf-8?B?aXBFNjRDZytvSVl6T0MyVEN6b2FBZXhqSmhyS0N2eUtSL1hQR1BpZGhmdWMv?=
 =?utf-8?B?eTJsS0doNlNOa016a1FwRTA4MkMxa2x2MVJPKzN5ODdBaVlWSDU1L01zdGcr?=
 =?utf-8?B?UHg1YzVCbTdVZ0o5K0svcmdPSkxldEtTcEdqM0RRU25oa1YyWDcyejlyZjAw?=
 =?utf-8?B?c29aTllIYUJ5Z2VrV1B4dGxXaEFHM1B3THhVR2toTHh1NHdsTHFJT1VrMm56?=
 =?utf-8?B?a08vL3B1V0ZNQlNSaHFhS0dKVFVISy9yOWV0Mk01ZVYvWVV3eGdUd2s3TWpR?=
 =?utf-8?B?b2FySzBRWGtDQ05XRnh5aE5pbmJRU21qTWJsaVAzMjJzZUg4cXpmM0RoRVpI?=
 =?utf-8?B?TTFCMkdFTEZvYVBGZHlTQWlHSWpPZmRFemNGQ2h0ajFuWEgvRjRzY0pDVE9I?=
 =?utf-8?B?WE0ydzZpRGV3WE5tOUtqOHRxb001dnFCN1E3cGMzWVJ6cmh1Q1orcGVBMFUy?=
 =?utf-8?B?cHl6Q3FJOUZkdkZ4aWEzcm03WVVncmp0UnZaVTFEMkRzbWJkSWlheGN3dlI2?=
 =?utf-8?B?bEdCbFFiVmIyYmN2MTd6RGxJVFlOeWpCS3JRckl3Qmp0SVdsRzJ5S0d5cjVz?=
 =?utf-8?B?ZmFPWHpDcHpHOUFNRSt0Q1lJOFJPbVhkOUoycHNveFdGaG1reUVyVTRHUSs1?=
 =?utf-8?B?MDlyTk5QRjYycFNuRHJTV0l1bEM4cngxVC9pVGFBYzJmbVlWTWNjSHRpamk4?=
 =?utf-8?B?eVNla2I0UGIxZklXdFRWTVN5NzlZNnl4QkNtOGRybEdJZTgyNGRSNHI2eVJM?=
 =?utf-8?Q?QLt4qDJJ0YxfjqPanQ+Ey9Uzr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09987c07-1939-4de3-7591-08dc4cba788f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 10:58:14.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/kwUEq9UkrgaFJ3CiecdkOiOU3psDZeUY1UEQvomWb7DEoJ3AZSKP8cDo0n8731BcExnMv4jXJ5avrCjEW+LLWp0BuU8Co24aSqkyZiR7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gTG9r
dGlvbm92LCBBbGVrc2FuZHINCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMywgMjAyNCAxOjM1
IFBNDQo+IFRvOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBDYzogTmd1
eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS3ViYWxld3NraSwg
QXJrYWRpdXN6DQo+IDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+OyBpbnRlbC13aXJl
ZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgS2l0c3plbCwNCj4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV0IHYyXSBpNDBlOiBmaXggdmYgbWF5
IGJlIHVzZWQNCj4gdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIHdhcm5pbmcNCj4gDQo+
IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBhdWwgTWVu
emVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAx
MywgMjAyNCAxMTo1OCBBTQ0KPiA+IFRvOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRy
Lmxva3Rpb25vdkBpbnRlbC5jb20+DQo+ID4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vv
c2wub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtpdHN6ZWwsDQo+ID4gUHJ6ZW15c2xhdyA8cHJ6
ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEt1YmFsZXdza2ksIEFya2FkaXVzeg0KPiA+IDxh
cmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV0IHYyXSBpNDBlOiBmaXggdmYgbWF5IGJlDQo+ID4gdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gd2FybmluZw0KPiA+DQo+ID4gRGVhciBB
bGVrc2FuZHIsDQo+ID4NCj4gPg0KPiA+IEFtIDEzLjAzLjI0IHVtIDEwOjU2IHNjaHJpZWIgQWxl
a3NhbmRyIExva3Rpb25vdjoNCj4gPiA+IFRvIGZpeCB0aGUgcmVncmVzc2lvbiBpbnRyb2R1Y2Vk
IGJ5IGNvbW1pdCA1MjQyNGY5NzRiYzUsIHdoaWNoDQo+ID4gY2F1c2VzDQo+ID4gPiBzZXJ2ZXJz
IGhhbmcgaW4gdmVyeSBoYXJkIHRvIHJlcHJvZHVjZSBjb25kaXRpb25zIHdpdGggcmVzZXRzDQo+
ID4gcmFjZXMuDQo+ID4gPiBVc2luZyB0d28gc291cmNlcyBmb3IgdGhlIGluZm9ybWF0aW9uIGlz
IHRoZSByb290IGNhdXNlLg0KPiA+ID4gSW4gdGhpcyBmdW5jdGlvbiBiZWZvcmUgdGhlIGZpeCBi
dW1waW5nIHYgZGlkbid0IG1lYW4gYnVtcGluZyB2Zg0KPiA+ID4gcG9pbnRlci4gQnV0IHRoZSBj
b2RlIHVzZWQgdGhpcyB2YXJpYWJsZXMgaW50ZXJjaGFuZ2VhYmx5LCBzbw0KPiA+IHN0YWxlZA0K
PiA+ID4gdmYgY291bGQgcG9pbnQgdG8gZGlmZmVyZW50L25vdCBpbnRlbmRlZCB2Zi4NCj4gPiA+
DQo+ID4gPiBSZW1vdmUgcmVkdW5kYW50ICJ2IiB2YXJpYWJsZSBhbmQgaXRlcmF0ZSB2aWEgc2lu
Z2xlIFZGIHBvaW50ZXINCj4gPiBhY3Jvc3MNCj4gPiA+IHdob2xlIGZ1bmN0aW9uIGluc3RlYWQg
dG8gZ3VhcmFudGVlIFZGIHBvaW50ZXIgdmFsaWRpdHkuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDUy
NDI0Zjk3NGJjNSAoImk0MGU6IEZpeCBWRiBoYW5nIHdoZW4gcmVzZXQgaXMgdHJpZ2dlcmVkDQo+
ID4gb24NCj4gPiA+IGFub3RoZXIgVkYiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRy
IExva3Rpb25vdg0KPiA+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gPiA+IFJl
dmlld2VkLWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraQ0KPiA+IDxhcmthZGl1c3oua3ViYWxld3Nr
aUBpbnRlbC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogUHJ6ZW1layBLaXRzemVsIDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2MSAtPiB2MjogY29tbWl0
IG1lc3NhZ2UgY2hhbmdlDQo+ID4NCj4gPiBUaGFuayB5b3UgdmVyeSBtdWNoLiBObyBuZWVkIHRv
IHJlc2VuZCwgYnV0IEkgZmluZCBpdCBhbHNvIGFsd2F5cw0KPiA+IHVzZWZ1bCB0byBoYXZlIHRo
ZSBleGFjdCB3YXJuaW5nIHBhc3RlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gVGhl
IHdhcm5pbmcgaXMgZXhhY3RseSAidmYgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlz
IGZ1bmN0aW9uIiAgaXQncw0KPiBhbHJlYWR5IGluIHRoZSB0aXRsZS4gV2hhdCB5b3Ugc3VnZ2Vz
dCBtZSB0byBkbz8NCj4gVGhhbmsgeW91DQo+IA0KPiA+IFvigKZdDQo+ID4NCj4gPiA+IC0tLQ0K
PiA+ID4gICAuLi4vZXRoZXJuZXQvaW50ZWwvaTQwZS9pNDBlX3ZpcnRjaG5sX3BmLmMgICAgfCAz
NCArKysrKysrKystLS0NCj4gPiAtLS0tLS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBQYXVs
IE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiA+DQo+ID4NCj4gPiBLaW5kIHJlZ2Fy
ZHMsDQo+ID4NCj4gPiBQYXVsDQoNClRlc3RlZC1ieTogUmFmYWwgUm9tYW5vd3NraSA8cmFmYWwu
cm9tYW5vd3NraUBpbnRlbC5jb20+DQoNCg==

