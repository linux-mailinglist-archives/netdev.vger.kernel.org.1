Return-Path: <netdev+bounces-206857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268CB0498C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 23:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC6A3B9040
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109BA1D435F;
	Mon, 14 Jul 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9dPfx6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1571487F4
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528677; cv=fail; b=BCOpMk7yBnK+w/0EvgrpoMEp6IBU4Z7UqrjWfIbZ9knVFVdENs93ECmeEiJ73UBNXUyT7fxX9Ph+ox4e7tonxSkgTkijDjCZTcFzKMkPtghuvgUoL5kT5t6VW8tTVPcb1Q4ofEVrZPIcnk0Q9coruk0KXJJU/F3Tsp/vPcVIpzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528677; c=relaxed/simple;
	bh=yq3MMZdI7DSyFVaAEWD2WcolGj2g9lJlk3IcO0e41LM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yuo+hyJC8zINbDzYvPKJbekWRd9juJfOrMz39MetcgWGP9f1supUOMgtOYMZ0Yg0yToDlrVnEORuK1zctfxfTPOgYzA6XVHdNywUZn1EGq4fqZdXvTjWCkkn52+m740ba8p5YQpON17De3Ql/7OK4hJWRg3htzLFxmU2appr3PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9dPfx6Z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752528677; x=1784064677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yq3MMZdI7DSyFVaAEWD2WcolGj2g9lJlk3IcO0e41LM=;
  b=f9dPfx6ZnH18hEhEh3+qrVL2lqrgq39Gv/MZDpDVz19Xq02BQD92T7pt
   PQQWxH1DIGNbujldpmZ1Zwr1RHQQDqP/UAUarjBFyV4cYU1qzVGxY/QEU
   hd7BkCErqPJZoVxwT0g7CXRm41tjKW+uNXNYQZrLmGo43zjkAYDQtJUx6
   cNTPdAfcR6BHDqW7QdMk9G/+C6jEQk9eh8sWfUCmUcdtNbjEwJ+B9o865
   dZ5/03gDpUAknB3ZpFElhQW2qzslgDpWReWgLXoKgPpZjwqa15MUwvZ+9
   Utf9fhAolAqaWjGTQu+5DlGh4lrBJa7/RNybVVsHr3jJPNuzDtmmi4mKq
   g==;
X-CSE-ConnectionGUID: KeuxCgdkRDyHyo36uVujYg==
X-CSE-MsgGUID: XpuFIGzESZelb1AE9NSkAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42360136"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="42360136"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:31:14 -0700
X-CSE-ConnectionGUID: r9/RCX4LSVmAU8ydC5nVlg==
X-CSE-MsgGUID: Mw+3NZV+RNiVXhDhCb27Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156438873"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:31:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 14:31:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 14:31:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 14:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbFmM7/9wai9RIOPkaCoMDxmaZOzifnckKRdvnJbpd0dl+L07yoHwDy51gKoaKGmsTvOu26fVM8y+o2Mp/GnkogFMeeb6IeTBPpAE8esdNBbmTk9tAJ37nihxZeknfOWl4rreYX10fEtqV6NFl06YIn+aLjiQADJTxTf9LlwkTqJuxwQAePBpWOZpB7QriWEQN1GK4G3+UnBMiJUJfV5OrDtWpd45GFi24vIce4taRglXqYY8OYPDP5ysC+XChsMIZi2eDqT8TNFmr5c6X9/2L2/ojKfzZIqyt6JwIufpTeLj8bJaXSaAFf81ipRoSmdnVCtSMX0HfPe9V20rbD9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq3MMZdI7DSyFVaAEWD2WcolGj2g9lJlk3IcO0e41LM=;
 b=Z0CCVlcQosmTw4x1Im/Uykxy/TNoTPEWzSL3VxvYLBZZ4mzM6EAOxJt7MSQvnCP671JH7QSd6c4cAmNUqwJPO187Z4WqzXDjFg1FfnD1PWlc3+4+Xq3OIVsSCbVjUJbDf/rWwhEaJXwHpuICC1K+XzEaQipzn9Rid9nkHYswPeLSfc5H2ekfBjlcRCw8r8ROdvDUa0UeVkSfIvPbGbkUxcAbdCzMYM7qny83aXLmWtDytyCjDTb+5Fe8ZoDwDqaMw9GK+m+T8kTkbmNzUR2C5Uqad05lp8FoUy70uack76YSVyICQYYqb0MOOEchhxoVmFdCyOlrORq8w+Ejh4rZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6337.namprd11.prod.outlook.com (2603:10b6:208:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 21:30:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 21:30:53 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, "Lifshits, Vitaly"
	<vitaly.lifshits@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Thread-Topic: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Thread-Index: AQHb8XyOmbnSV1ix70KIdXbovE533LQx3R+AgABLnVA=
Date: Mon, 14 Jul 2025 21:30:53 +0000
Message-ID: <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
In-Reply-To: <20250714165505.GR721198@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|BL3PR11MB6337:EE_
x-ms-office365-filtering-correlation-id: e6238e31-5b3b-4112-2e8d-08ddc31db61d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGdEbCtxLzg2aEs3YlZrVFE1WjFCenJVZjl4VEFydE5yNVJ6bWJORThrbWlK?=
 =?utf-8?B?d1ZQRWZMbnhZZmtQTUtQZVZKbm5hM3puZVhTVlNKdzJUeHlJd2paYVljWFR6?=
 =?utf-8?B?Y2pwb3ppdlZac0hNRWxqQnhQSUR2M0prL0FEK2M1NnVRNzQ2cndpNWQvK3FW?=
 =?utf-8?B?Zk1zdnZIQUY2dlNYOG8xZDJ4M0ZWVHUrZTkrRW96TmQ5UTRER2F0UEZCRldj?=
 =?utf-8?B?YzZSTTRDUzIydjRHMHBNTFRYZlRwMGRnWVMzVVlVWkFFNWQvVXh0Q0NxZW5O?=
 =?utf-8?B?SUovdkZ2YkRmZWhaYWtycjdicUpvNUZucnpmcDNDcDBKVmdyL05VT0Q4a25X?=
 =?utf-8?B?ZXdXYmg5dW9Tb3ozVkFyNDhxY1g5VXMrU2hIZE9rMzREeGpHdkg1WnhrV0Zy?=
 =?utf-8?B?aXU1SlR2dFE5dkxYMllGcytQYTh5cys0WHdNUE1kRms4bWp1ZWxXZWR2aVUz?=
 =?utf-8?B?a085TlQ0RmNvZ0R3SHJNK2IwZUJLNkkvOHI3cmdZWGg1M0p5azBiUytlbDlh?=
 =?utf-8?B?Z0tXVER0SENFTlR5eWxQd0pldXAyMDNJcW5NNXAvQ2RZYWR6Y0IwTG1ZV0pk?=
 =?utf-8?B?aStaT3VwM2NwYU0zc2VRbmRGQi83OUIzV0VKa2dOMGdSVjA2WkxFa3ZkMmJZ?=
 =?utf-8?B?ZmJYYkE2TFVtWGZjcWR3YkNxeDc1dm5KdGd2ZWZJZDllU2dNdG15ciszbnRl?=
 =?utf-8?B?L2t0MjUrQ1dSeUx4OE9LQVU0NWZFeDRHbkFPbUpwSG92RGgvTS9QUmkycVVa?=
 =?utf-8?B?UXcwTlhNQlI1TFpGb2x6ZmpqNUM0RTJUWERIc2xER0s4b0liUHZXZk1VS1B4?=
 =?utf-8?B?UTM4RFovZVUzMDlIQ2RXc2FpYm1KT3JHRW8rRlV3S1BDdHNZWGJvdVlmSito?=
 =?utf-8?B?SUJVRUIweXBwNEpmV3oxeTdaUmZhK09VMWt1RGxRaUQ3TWxXeDNuM2hIN2xu?=
 =?utf-8?B?L2hMeGZTQTdVb0loQ3dSLytzM3RyczBnSEt4RlRYSWExMFpqeG9iaXcxaUhN?=
 =?utf-8?B?WTNYRDlHTzdiUEYwc2d5SnRyQk9USGcraEVYeTcvQjU2UmIrR0JqN2d4ZjZB?=
 =?utf-8?B?Rk0rOFA3SHRta3JHUTRmU0l3c3Zrb0NCUWltcVdYVWlMMCtEaVR6KzFrMGIv?=
 =?utf-8?B?ZGtsbDJOeitJd2VmZjNPbUxVM1ZrRmpvK3Bta0duM0RBbzI5bml2cnJOZWR6?=
 =?utf-8?B?RWliN0xPNGJoUUFjQXBocmdnZWpBQWJ4U1pmRlYyang0L0J0bWNiQVNyc0pK?=
 =?utf-8?B?NDNxL2EvZWF5MmtjK0haKzBpeDdCSW5nOFJpa3c0SzlVNkJ2QmoyeFZEMEd2?=
 =?utf-8?B?Rkx0YURBQ3BqZlk2cVY3K2hNWmxreTdueVVTNkhscUdOd09lbDNsallUdkxj?=
 =?utf-8?B?bTVuUVcwSzhnQUNHNzhzZVJ2Z3VQaGJHZHlwSEl6SXlJUnV2TXc4YzZHdy83?=
 =?utf-8?B?alBrbGFCK0pqK0lJYThiWEpwbjc0QkFBOUI5MDVhenVtZEExNkpsWXl0VmVY?=
 =?utf-8?B?L05XRUtob3Zrdlk4OEVrdXVzT2Fvam5vd1p0K2tlTzBGRHdIL0ZKUityeUI3?=
 =?utf-8?B?UWR3c1dTRjZtK1VLUy9mWFZjUzEvTHRHbGRVOTNUaUlpSUN1aFRscUJhRE9B?=
 =?utf-8?B?Ulh2WE8zb0R5MGpqWW5NNDBJK2g5azFqMlMwVDg3L1FmU0dVWlV0aFNzWHVY?=
 =?utf-8?B?UExRZUV5MjdjTUltQ1RXTUVWV1JrenVVVEY5eHVvS1B6bFlYYmN1WHBYa01I?=
 =?utf-8?B?TUROekwwSEhjMFVGcUl0SVhWcGZSM1dkbURSV09pKzd2dk0wV3VTMWhjaVph?=
 =?utf-8?B?YmpSN3I0SGxHVTFiNmpCTE9pME9aa3U5dmR4YVN5amhUTnl4VWd2YnVTaGwv?=
 =?utf-8?B?UndLZ01JczJIMVlIM0lpMS8wdXNxZmoxWkxUaDR3a1Q4MkgzOTRHTENnUUgy?=
 =?utf-8?B?TjBjVTB3RW4vS3hwMndlaDUzOUJPMWdQcDM2U1RKTWVJeTQ1cVZQNkNjZ1ZX?=
 =?utf-8?Q?9TkgjG4sXI/NC9U2w7C6nB6WVU0/hs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2lRVStiaEJKMXJMdlpLL0FVbGt2aHJLNWJCU1lwYzhJOC9WV1ppZlhidkVF?=
 =?utf-8?B?QkFWamtoTUxEUWxzR0piY3JUL1FaM1c4WUwvOTRxellpTFRUZjBWTnI1WGhP?=
 =?utf-8?B?VWVmWTI1azhPVklSUVU2azBpdVJtRjJ4MUN5am9DcVBYak1STkozK0s3N3Er?=
 =?utf-8?B?Z1c5YkdDcGE3bGdrOWlabmNlVXBpM3FuMW10NXNvc011eHk3QTRib3o4Nmor?=
 =?utf-8?B?MEdvU1JnemhSc0VuMFNtMVE5eHIrYnIvd05mcEc0elZ1aytuWDFZbnVQWE1w?=
 =?utf-8?B?RTYrekk3YXFiWDFuV2daSHc0MytRM0VhZ2s5OWtHZjVKUlNHVEZyc1pwTkFK?=
 =?utf-8?B?MnJwSEVjNGdjS25KaFR6UW5LaDNUVTN6bUx2SUEzSTgzNGdXcjgwZkFVVHR6?=
 =?utf-8?B?TGoyQk9YZkIya01rdHRDUHNWUGxNZWlWSFlhUUpFdER5YjQ4TGNIMk1LVmJk?=
 =?utf-8?B?MmxUSWxqU3BmNWZpeTArRUNsSHA0TFAxM3NCRVkwd0JQamVrVUNWV3U0YmRQ?=
 =?utf-8?B?c25ScWVGMnRsS0xmeE8zL0RBNzliZkZzWnI4N3Z4WGY4aFBIYzhrZU0zOFFH?=
 =?utf-8?B?VWoyRkoxb1VoV1ZvRFBkb2k1dlA0bndyem1RS3RHUWlCbmlVMVlobTE3UzVS?=
 =?utf-8?B?VktYZGZKWkRYRlk5QldtS1JvOWUzRlNNenZKYW5rYU9yL1JHaFlqRG9MT1BP?=
 =?utf-8?B?ckR4bzlrVXBTVUJjOHNwb3g0R3AvbGdlSWJPaTZNL29yVnBhS2htSHJBS3V0?=
 =?utf-8?B?OFhqczRrbTVSQ0swdXJSZkw1bERZaGl2QmpzMHo0T2dpTGZycW55ZHBvM3JZ?=
 =?utf-8?B?K01oREgxWTdoWVh5THFBeWlrbnBsRlcwSGZqelAxOHR4eEJlMVJMS3VVVW54?=
 =?utf-8?B?bnZqY0hUamRvSGdvM2hseTlidlhmQ1FJZkw2NnJwOW1JZTZmZ29EelRBRGFo?=
 =?utf-8?B?K01QRmw1dys1RzFpcVdVazNDbUU2b1hrSFhDUWdCQXlyT3VjSE85cmJrOHRV?=
 =?utf-8?B?aXJIdEpmYXNaMDd2STJjZ3Z6ZXhQK3RreXM4Zy9jRU5TK2lwTEJncENLNUdP?=
 =?utf-8?B?Y3NzczIydTNzdjAzVnFxR3lxbm1CUTZKWFc1a0hoVVRmdE4xSFA1cmlISUFG?=
 =?utf-8?B?ci9DSXZaUXFaR3RKZTRSK1l4b0JRZ3oyQUUwakpaZkpEOGNoZ1hEai9WWm1F?=
 =?utf-8?B?bTJDWlE5VEUxUmc3K21OTExoZnZUQVZEYWxySXhWN01MSnhqRENBUVFzS3Z6?=
 =?utf-8?B?QnRtSU1ocE9VY2JOZEZkT2llcWZObUlUQm5HS04xbjNNeGdrWHhVSjBFbXRi?=
 =?utf-8?B?NllqOUIzN0I0bis2UUQ0ODhhelVXM0NHSElib0NIUVVkamVDQUJUUjZ2T1V4?=
 =?utf-8?B?VjUrdGp0VGdFS01UdWZocFJLamhuemc3T2ZhSXJWaHQ4ZkRnU1AveGZYN2NQ?=
 =?utf-8?B?YmEyRUh2VzVjVnFidWQveDBPRloyUHcveXJ4emV1SHpFTlRxR2c0T3V4cmxR?=
 =?utf-8?B?ZGRKMGJCaEhNQ1ljSVduajUyamR6akd1MDEwbllPWnpzeEI0VGc0aklHTlhQ?=
 =?utf-8?B?Rk8zZ0xTR3NmbW9jN0tubThsemxjL25sckFZTDNtTXI5TXQ2RTljRmV2TVZs?=
 =?utf-8?B?c1RQNkREVXM3elYwSWt1T1ppcUZXUks4T2NDSy9BWnI0b0dhaSt0UGIyYWgr?=
 =?utf-8?B?Nkc0R2xDZS9hVlFlS0dIdjhpdzBhK3hCWFVNWlFkS0trTUs1S3oyN3h2d0Mv?=
 =?utf-8?B?VlIrTFBtMS9lRHU4MWt0STJVT0lpYmRCYnIvaFN5c0kxZmhsWTVBL3VzSVVn?=
 =?utf-8?B?SEt2VmhoWjYxTVBvRXhyb21IZnNPK0Z5cHZRc2trYVFRck5kTEpFeno3VlBi?=
 =?utf-8?B?a25FRmQydTZoakZ1L2tJZUZKV2djT1dhSmhDWXZKakQ4YUZLbkt4SlpIblZm?=
 =?utf-8?B?YVZ5ZDRGNjRGQkJpYzNSNFFpZnBBVjNXdjRIclMrRitPcG1nKzlaUDBkWW9l?=
 =?utf-8?B?UDZiODVNVVphN2hOaVVTRHBHcFhLbVl2TDh2Y0RFc1dDVW5rUHBZR3A3ZitU?=
 =?utf-8?B?Y2JreGZDa0VRTkVKQURNZ0dpVHNxOEZWZE54b09lVnJ4Uzg5ZkEyQ3V3Qmxu?=
 =?utf-8?Q?SbR3MyGHwgWShEi3Pz9bBzQCT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6238e31-5b3b-4112-2e8d-08ddc31db61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 21:30:53.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QGmlQCsrHMvf8/k6ozrZ47oIrHBS64eHTyIKVJbv2QzfsTDVMjNbnMettt2WckcjdDle1qPneuukTSjGeNmeMqtIcK5Lsnd7RwnOEsfT14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6337
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTQsIDIwMjUgOTo1NSBBTQ0K
PiBUbzogTGlmc2hpdHMsIFZpdGFseSA8dml0YWx5LmxpZnNoaXRzQGludGVsLmNvbT4NCj4gQ2M6
IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgUnVpbnNraXksIERpbWENCj4gPGRpbWEucnVpbnNraXlAaW50ZWwuY29t
PjsgTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsNCj4gS2Vs
bGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UkZDIG5ldC1uZXh0IHYxIDEvMV0gZTEwMDBlOiBJbnRyb2R1Y2UgcHJpdmF0ZSBmbGFnIGFuZCBt
b2R1bGUNCj4gcGFyYW0gdG8gZGlzYWJsZSBLMQ0KPiANCj4gT24gVGh1LCBKdWwgMTAsIDIwMjUg
YXQgMTI6MjQ6NTVQTSArMDMwMCwgVml0YWx5IExpZnNoaXRzIHdyb3RlOg0KPiA+IFRoZSBLMSBz
dGF0ZSByZWR1Y2VzIHBvd2VyIGNvbnN1bXB0aW9uIG9uIElDSCBmYW1pbHkgbmV0d29yayBjb250
cm9sbGVycw0KPiA+IGR1cmluZyBpZGxlIHBlcmlvZHMsIHNpbWlsYXJseSB0byBMMSBzdGF0ZSBv
biBQQ0kgRXhwcmVzcyBOSUNzLiBUaGVyZWZvcmUsDQo+ID4gaXQgaXMgcmVjb21tZW5kZWQgYW5k
IGVuYWJsZWQgYnkgZGVmYXVsdC4NCj4gPiBIb3dldmVyLCBvbiBzb21lIHN5c3RlbXMgaXQgaGFz
IGJlZW4gb2JzZXJ2ZWQgdG8gaGF2ZSBhZHZlcnNlIHNpZGUNCj4gPiBlZmZlY3RzLCBzdWNoIGFz
IHBhY2tldCBsb3NzLiBJdCBoYXMgYmVlbiBlc3RhYmxpc2hlZCB0aHJvdWdoIGRlYnVnIHRoYXQN
Cj4gPiB0aGUgcHJvYmxlbSBtYXkgYmUgZHVlIHRvIGZpcm13YXJlIG1pc2NvbmZpZ3VyYXRpb24g
b2Ygc3BlY2lmaWMgc3lzdGVtcywNCj4gPiBpbnRlcm9wZXJhYmlsaXR5IHdpdGggY2VydGFpbiBs
aW5rIHBhcnRuZXJzLCBvciBtYXJnaW5hbCBlbGVjdHJpY2FsDQo+ID4gY29uZGl0aW9ucyBvZiBz
cGVjaWZpYyB1bml0cy4NCj4gPg0KPiA+IFRoZXNlIHByb2JsZW1zIHR5cGljYWxseSBjYW5ub3Qg
YmUgZml4ZWQgaW4gdGhlIGZpZWxkLCBhbmQgZ2VuZXJpYw0KPiA+IHdvcmthcm91bmRzIHRvIHJl
c29sdmUgdGhlIHNpZGUgZWZmZWN0cyBvbiBhbGwgc3lzdGVtcywgd2hpbGUga2VlcGluZyBLMQ0K
PiA+IGVuYWJsZWQsIHdlcmUgZm91bmQgaW5mZWFzaWJsZS4NCj4gPiBUaGVyZWZvcmUsIGFkZCB0
aGUgb3B0aW9uIGZvciBzeXN0ZW0gYWRtaW5pc3RyYXRvcnMgdG8gZ2xvYmFsbHkgZGlzYWJsZQ0K
PiA+IEsxIGlkbGUgc3RhdGUgb24gdGhlIGFkYXB0ZXIuDQo+ID4NCj4gPiBMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9pbnRlbC13aXJlZC0NCj4gbGFuL0NBTXF5SkczTFZxZmdxTWNUeGVh
UHVyX0pxMG9RSDdHZ2R4UnVWdFJYXzZUVEgybVg1UUBtYWlsLmdtYWlsLg0KPiBjb20vDQo+ID4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvaW50ZWwtd2lyZWQtDQo+IGxhbi8yMDI1MDYy
NjE1MzU0NC4xODUzZDEwNkBvbnl4Lm15LmRvbWFpbi8NCj4gPiBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9pbnRlbC13aXJlZC1sYW4vWl96OUVqY0t0d0hDUWNaUkBtYWlsLWl0bC8NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpdGFseSBMaWZzaGl0cyA8dml0YWx5LmxpZnNoaXRzQGlu
dGVsLmNvbT4NCj4gDQo+IEhpIFZpdGFseSwNCj4gDQo+IElmIEkgdW5kZXJzdGFuZCB0aGluZ3Mg
Y29ycmVjdGx5LCB0aGlzIHBhdGNoIGFkZHMgYSBuZXcgbW9kdWxlIHBhcmFtZXRlcg0KPiB0byB0
aGUgZTEwMDAgZHJpdmVyLiBBcyBhZGRpbmcgbmV3IG1vZHVsZSBwYXJhbWV0ZXJzIHRvIG5ldHdv
cmtpbmcgZHJpdmVyDQo+IGlzIGRpc2NvdXJhZ2VkIEknZCBsaWtlIHRvIGFzayBpZiBhbm90aGVy
IG1lY2hhbmlzbSBjYW4gYmUgZm91bmQuDQo+IEUuZy4gZGV2bGluay4NCg0KT25lIG1vdGl2YXRp
b24gZm9yIHRoZSBtb2R1bGUgcGFyYW1ldGVyIGlzIHRoYXQgaXQgaXMgc2ltcGxlIHRvIHNldCBp
dCAicGVybWFuZW50bHkiIGJ5IHNldHRpbmcgdGhlIG1vZHVsZSBwYXJhbWV0ZXIgdG8gYmUgbG9h
ZGVkIGJ5IGRlZmF1bHQuIEkgZG9uJ3QgdGhpbmsgYW55IGRpc3RybyBoYXMgc29tZXRoaW5nIGVx
dWl2YWxlbnQgZm9yIGRldmxpbmsgb3IgZXRodG9vbCBmbGFncy4gT2YgY291cnNlIHRoYXTigJlz
IG5vdCByZWFsbHkgdGhlIGtlcm5lbCdzIGZhdWx0Lg0KDQpJIGFncmVlIHRoYXQgbmV3IG1vZHVs
ZSBwYXJhbWV0ZXJzIGFyZSBnZW5lcmFsbHkgZGlzY291cmFnZWQgZnJvbSBiZWluZyBhZGRlZC4g
QSBkZXZsaW5rIHBhcmFtZXRlciBjb3VsZCB3b3JrLCBidXQgaXQgZG9lcyByZXF1aXJlIGFkbWlu
aXN0cmF0b3IgdG8gc2NyaXB0IHNldHRpbmcgdGhlIHBhcmFtZXRlciBhdCBib290IG9uIGFmZmVj
dGVkIHN5c3RlbXMuIFRoaXMgYWxzbyB3aWxsIHJlcXVpcmUgYSBiaXQgbW9yZSB3b3JrIHRvIGlt
cGxlbWVudCBiZWNhdXNlIHRoZSBlMTAwMGUgZHJpdmVyIGRvZXMgbm90IGV4cG9zZSBkZXZsaW5r
Lg0KDQpXb3VsZCBhbiBldGh0b29sIHByaXZhdGUgZmxhZyBvbiBpdHMgb3duIGJlIHN1ZmZpY2ll
bnQvYWNjZXB0ZWQuLj8gSSBrbm93IHRob3NlIGFyZSBhbHNvIGdlbmVyYWxseSBkaXNjb3VyYWdl
ZCBiZWNhdXNlIG9mIHBhc3QgYXR0ZW1wdHMgdG8gYXZvaWQgaW1wbGVtZW50aW5nIGdlbmVyaWMg
aW50ZXJmYWNlcy4uIEhvd2V2ZXIgSSBkb24ndCB0aGluayB0aGVyZSBpcyBhICJnZW5lcmljIiBp
bnRlcmZhY2UgZm9yIHRoaXMsIGF0IGxlYXN0IGJhc2VkIG9uIG15IHVuZGVyc3RhbmRpbmcuIEl0
IGFwcGVhcnMgdG8gYmUgYSBsb3cgcG93ZXIgc3RhdGUgZm9yIHRoZSBlbWJlZGRlZCBkZXZpY2Ug
b24gYSBwbGF0Zm9ybSwgd2hpY2ggaXMgcXVpdGUgc3BlY2lmaWMgdG8gdGhpcyBkZXZpY2UgYW5k
IGhhcmR3YXJlIGRlc2lnbiDimLkNCg==

