Return-Path: <netdev+bounces-46608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788A7E55EC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891E71C208C1
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A956171BB;
	Wed,  8 Nov 2023 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaFGueZ0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8D171A7
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:08:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E41BDD
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 04:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699445321; x=1730981321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g3/chuHoB+a4VgeolRlUJsq82m1MKDIu03nIQ6WsjxQ=;
  b=gaFGueZ0ymTpVcuC8t8zS26M0dEZG3wiHRknH6UNQ0OdIhkkUPzeQhXT
   xXwu57ffgQoZ0us/Uivba/YNb9cYBQOfPicCsGhXnS2RaaRxaw0sU4qNh
   dxbbwWvV462t38dcH9VmbL6UaUKgCsJ+c0GhVtitDEFiTwf51oIq8tgn9
   HtDHUU7j4AWSHOdOx3K8haYi+bQ9PeDR/WjO1CUq6JBGvbm315OAMc+GS
   tlOkvpTPSa0OMh6T+mPOAwPd/Ioj3sKwl5gIglZujz8ZMs+DQTCPuF5o1
   yJmcGaOxdQfMbhVgYmyNV6np7UeGFchmrnaiU554IGNqdKb/tVRVomMvs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="393663762"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="393663762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 04:08:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="853720877"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="853720877"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 04:08:34 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 04:08:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 04:08:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 04:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfC+mlU0Y756LfhpWkKXR8fjLspgKd+9v/2A9RFbwKxjPHoXxAS2huROPhzOnIWhCOGNbvzEfVKNIIyNatebvxC1+YUOZ43UyeX0W/+tEpqiWyppv/Ojx/6GloxqQsPDzEet4ow7QFEvU+6sSE1rAunwti/3ArREAZkhD2rwH/jgDBqXiwPUe6xiZmWkMVMzZKgmDFyx2ftuCAGRZWee9bHXeCGMmivaffPU6OPKdbqAvN9q29v2pLA6VDwQ8CVRlzKo2Ck8P7S2nBWpTtwY2tCDkbZWaGWXpyVcz8sTrw4jhki0iJkAzOQmtpfoXRxqF5jYnnefn8VbdKuY2jslww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3/chuHoB+a4VgeolRlUJsq82m1MKDIu03nIQ6WsjxQ=;
 b=FGQYrj9TY3Ahkj/zbSppSSEE0YiMGyoQA+tsabJT6p1WDqux5aUg6rDFFDk5FbpSNGVwuYGN0pax/plrGzO2iWyNrRRIsKg63Y0uxwzpfKrHxtDpAO4n+YqolydUWXFUhj7QVv5udgpNvdBp0HFI1AZDvFs+Kc1cFL+GAv+7+YFVEO81sQ1RJzWuQLWtyIfOxANtJ2bPw1DTA+AebA84yNLJE+1kddByMLg2YRMUH234KqG1k+9vY+LkBHT/4bsHESBb3Tora8Wvh+c2vs0KKMUkSvX8yInMAHWmF9rYxyqiKgGCQvs9dnj6zV6mJ6oVvRxAVOFRkmnmVR9+v0zgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 12:08:31 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 12:08:31 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Thread-Topic: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Thread-Index: AQHaEi9O+MhpyYqtOE+7KgFNzKw5JbBwSy0AgAAHGIA=
Date: Wed, 8 Nov 2023 12:08:12 +0000
Message-ID: <DM6PR11MB4657E75C585584960CFBD09C9BA8A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
 <a0d2089d-9392-3028-1265-efcfbfad7ab1@intel.com>
In-Reply-To: <a0d2089d-9392-3028-1265-efcfbfad7ab1@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ0PR11MB5814:EE_
x-ms-office365-filtering-correlation-id: 0400ce6f-bc47-4bf1-333d-08dbe0536143
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ryt9DqQPKTsZrc61FG64edWmv7HlQQ9IIB/tQYtRDFX3LZ7HcQKOcmO83OXRvcJ+qxfz/xBWu68dxbccIXP/mio2voC7TPC9A1hH1ddce7psbD7lNEGRiSacxcyGc8O/Fdr0+u122BjDVSCj5dp9E+yrOgmMwYrNTK4/YRdzQeTbNPSzPUiPKcBD432U3qn1R6TsPSiF6EX/1w66ANRoHzJhEmT3VmXPtt1fflxnD6RGZzVm+ODLs1BwxUnSuAqUJywtebkffZiGUvEf8rOYRbn22pWXdGHyuL4PMLo4IuPjF/7+uT0YFYOz4ynWQVb8Px1+l+0lN2y7Ztot2tPPIBSOTfKuxYK2Z4QEm/W2dpFyeSshWxDQVZ9Op3s7D/rbcj9OK4py/M8K5Wlw7vC3FWtpSDgqB5Uq7Pq5avh0p8T5gvxmgMnPDVgWggpXONMy7rpwB+l611f/BOz8OLXfLstyFk8C4Nf+54OYy7ROFn+7zbuD29Y/smWccQpVvpOmebYvNcBU7A8gQDa2FuNkFHRBgMIZhTHxhmw8UsXYySAOmBI8SguTwJeO01Axav8oUCNHvAnhq9X04fICeu6B3duNeaIEHSI2CJtF5yFT9+Fx3Tkr8ZPIryLxiTTBSLZx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(316002)(55016003)(66446008)(7696005)(6666004)(9686003)(71200400001)(6506007)(122000001)(33656002)(86362001)(82960400001)(38100700002)(5660300002)(4326008)(2906002)(478600001)(26005)(83380400001)(52536014)(76116006)(38070700009)(54906003)(8676002)(64756008)(8936002)(41300700001)(110136005)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjRETGt4bjA5Y2VlLzBETEU2S0FHQ2M1RGh5WEFuYjZVemY0Wk41SzZwYXVB?=
 =?utf-8?B?VDlDKzBYcHZUU3dnaXRnUG5FMlo2cEJ3OVdCN2krdXZVTnhhdnR2RE93TEtI?=
 =?utf-8?B?TThoalhNdUFpeUh0Y0o3M1lXYTltQ1pXV2U2bVVIY0tIYy9NTHVoY01vSGtJ?=
 =?utf-8?B?R2FqbTRQS2ZNQllzbjRmRThqYmFxdGxhSEVEd3dUK0kxT3FrNzBkam1iT2xJ?=
 =?utf-8?B?VCswQmJ3K3B2VG9LbTF4SlJsR0xQajE1T05UVnV4T1R2SmVwZDBFdVIvTCtU?=
 =?utf-8?B?Z0s0dklPcmpERTlEL2hNYVE5UlkwbDREWGljRXdlVHVaOHZXbnR3Z3doUGZv?=
 =?utf-8?B?WGwva0IySytRVytCSnQ1bjRqdTh4SGZPWTJaVitERE02UUFIL0RMUG5mRlIr?=
 =?utf-8?B?OHJwU0sxUzJFRmhjdXVNaUwrL214R1FIY3hPK3pJSFV4b2tzYU0zblNNQ0pV?=
 =?utf-8?B?cG1Pd3BDN3B4a3BQeXFKMVJVZUE2YmlvRFdpYzdUUWJjeGo1ekdoSXRUcWJs?=
 =?utf-8?B?TDFreHl0Ly9lTkhHMXRYNEdKZU94MTZNcE9yemMvK1k5OWZ4UlljQmFia3Vx?=
 =?utf-8?B?QksyR3RHRHRVQ0lEbVdSZTVTcnNacnM3WVE2N3VHdU8raUcyVFcyeXQrWXZJ?=
 =?utf-8?B?QmVyS05aVnZoSHVrQndKVlJNcXhsMnBSZGRPRGhuU2RwZ29XTjkzWTRnakNq?=
 =?utf-8?B?bHY3RytNUWhzcEtwS0VaSnFsd1NtYWtLRUc5R2thOHF0U1ZSaklhYWdaMnNE?=
 =?utf-8?B?Y0o3RnNMbXRaMk5hbDdrc3JQU21vWk9pLzk3OGg1VGJrWDJORVlUQzNqT1pI?=
 =?utf-8?B?K25DS0RRNEFiVjczMjdsQnZNSEowUGRveTZGRHhYY0V1QThLY2lPWVhndlJo?=
 =?utf-8?B?OEphUXJaRVZlTjdnVkhCZGRTa3RqaVpXZVFqTENJWGhpUUlsTmFvK2NndEtj?=
 =?utf-8?B?NlNZMjk4QnBRWGNVOXdPTkhiUHdTTDhwSUFGWkhJd3Q1R1A0cFI0V0x6OUlP?=
 =?utf-8?B?U3MwcHZ0R3MzaVd2OHRoVzhCSXdTZWJ1WWo2T0lFWVZDTm9pV2xlTDBZNlRL?=
 =?utf-8?B?SHpZaUJPSHFzam9iYXVqYVlzQWpQRUpma1YwMkt1SWRtazdham9ybzYvazlr?=
 =?utf-8?B?STdONjd2cm92VEJWUDR2WE5ieFJjRnFUa1dWUnE3THZVMVdiUUM3dlRFd2g2?=
 =?utf-8?B?eTBuOXlSQlVTR1h3eVJuSEVId3NPbDNXZVk2ZDZBREk3Z1d0ZmRTbjArUkll?=
 =?utf-8?B?NHlKRnNxQjArSSs3V2Y0SnlkdmF5Z3ZlUGN4a0NhMmdJdXFXN0o3eWZGQzFx?=
 =?utf-8?B?cmh1enpxczVES2pRK1ZlSUhRZlcwVnZaNXRVYzBCWUVYZEZIallDMVd4anpG?=
 =?utf-8?B?OVBTbFdmQlRLTUR4Wm0zTmtzckx0OU9BY2VGQmVyNWdwbzhPL1lCaHcwUUZ1?=
 =?utf-8?B?ODFPUXJDeGVVdWkwVDc5bWdkUkp5T0hnSHIvckJSbkhoOERaZXovSnRDWTkz?=
 =?utf-8?B?V0hRc2lyREtjUUtJY3RqUkZ3NkZpNHRUdzhCU1htUUloWWRQOXBIQk80VFJ3?=
 =?utf-8?B?eGJFVVJJM3hRbzV1TjZKVzUwZkdGdk1uazI1TU1kK3VIdkgyT2pjM0VOVFNU?=
 =?utf-8?B?VjNIa2l0c0xnenQ2ZHljSGkvZUNoV3VyTXl6bkxLSm1tSVVuQmZIclVTcDlR?=
 =?utf-8?B?Zkw0UnkrTktBM0cwMVJHS0tUUG9vT21WUThwL1p1WFd5TXFpY2dhZEdWendH?=
 =?utf-8?B?dXlQVW5YZUxmbjg5cERpYkx5MlZMbUM2bURmZXBySE5QUkMvSFBiTy9oc0hk?=
 =?utf-8?B?M0VEMzFDT2tVOUlWZkx4QlNKSnozQ01ISVBnYWl0R09kTmFpUmlXOFdXMlQv?=
 =?utf-8?B?SzgzUFc1Znk5OWdyeW11ckhxWGlmZWVwbHlwYkcvY2d1SEhJekp1SFUyWW5V?=
 =?utf-8?B?bnVBRU8zNDRkbzBMbWREdG8rVlBhZDJFakhQa2tDRThwQlpjZUJ4dTROejIr?=
 =?utf-8?B?QWNRdXAxN2ZvMWdPam5LRzNyQTY3Ym1RdU5qMmhtQmdjemlJdEVTbEVIRnFY?=
 =?utf-8?B?SkJFNEw0V1hNTEJTaXh3dEdNK2cra2NKdTZ0VzRQNEl2bTVSZGZPQU1CeE1Z?=
 =?utf-8?B?WG5GcGg0SjZMdnhCUzF2L3lqR29PdEtZYnhLNlptVXFpOWI0enVtblZvQ2tx?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0400ce6f-bc47-4bf1-333d-08dbe0536143
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 12:08:12.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp9OlzBS0mhQRZi+y9aDvpX7zLnYX/4VjBbQSTzsLiTcExU+4d/Vzf8VgUv2DhZYxeDDCwBE1BOI4Ujf8l9fp8mUX0Z42hG+ylw5Msd4YQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
X-OriginatorOrg: intel.com

PkZyb206IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+
DQo+U2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA4LCAyMDIzIDEyOjM2IFBNDQo+DQo+T24gMTEv
OC8yMyAxMTozMiwgQXJrYWRpdXN6IEt1YmFsZXdza2kgd3JvdGU6DQo+PiBEaXNhbGxvdyBkdW1w
IG9mIHVucmVnaXN0ZXJlZCBwYXJlbnQgcGlucywgaXQgaXMgcG9zc2libGUgd2hlbiBwYXJlbnQN
Cj4+IHBpbiBhbmQgZHBsbCBkZXZpY2UgcmVnaXN0ZXJlciBrZXJuZWwgbW9kdWxlIGluc3RhbmNl
IHVuYmluZHMsIGFuZA0KPj4gb3RoZXIga2VybmVsIG1vZHVsZSBpbnN0YW5jZXMgb2YgdGhlIHNh
bWUgZHBsbCBkZXZpY2UgaGF2ZSBwaW5zDQo+PiByZWdpc3RlcmVkIHdpdGggdGhlIHBhcmVudCBw
aW4uIFRoZSB1c2VyIGNhbiBpbnZva2UgYSBwaW4tZHVtcCBidXQgYXMNCj4+IHRoZSBwYXJlbnQg
d2FzIHVucmVnaXN0ZXJlZCwgdGh1cyBzaGFsbCBub3QgYmUgYWNjZXNzZWQgYnkgdGhlDQo+PiB1
c2Vyc3BhY2UsIHByZXZlbnQgdGhhdCBieSBjaGVja2luZyBpZiBwYXJlbnQgcGluIGlzIHN0aWxs
IHJlZ2lzdGVyZWQuDQo+Pg0KPj4gRml4ZXM6IDlkNzFiNTRiNjViMSAoImRwbGw6IG5ldGxpbms6
IEFkZCBEUExMIGZyYW1ld29yayBiYXNlIGZ1bmN0aW9ucyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBB
cmthZGl1c3ogS3ViYWxld3NraSA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPg0KPj4g
LS0tDQo+PiAgIGRyaXZlcnMvZHBsbC9kcGxsX25ldGxpbmsuYyB8IDcgKysrKysrKw0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZHBsbC9kcGxsX25ldGxpbmsuYyBiL2RyaXZlcnMvZHBsbC9kcGxsX25ldGxpbmsuYw0KPj4g
aW5kZXggYTZkYzM5OTdiZjVjLi45M2ZjNmM0YjhhNzggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2RwbGwvZHBsbF9uZXRsaW5rLmMNCj4+ICsrKyBiL2RyaXZlcnMvZHBsbC9kcGxsX25ldGxpbmsu
Yw0KPj4gQEAgLTMyOCw2ICszMjgsMTMgQEAgZHBsbF9tc2dfYWRkX3Bpbl9wYXJlbnRzKHN0cnVj
dCBza19idWZmICptc2csIHN0cnVjdA0KPmRwbGxfcGluICpwaW4sDQo+PiAgIAkJdm9pZCAqcGFy
ZW50X3ByaXY7DQo+Pg0KPj4gICAJCXBwaW4gPSByZWYtPnBpbjsNCj4+ICsJCS8qDQo+PiArCQkg
KiBkdW1wIHBhcmVudCBvbmx5IGlmIGl0IGlzIHJlZ2lzdGVyZWQsIHRodXMgcHJldmVudCBjcmFz
aCBvbg0KPj4gKwkJICogcGluIGR1bXAgY2FsbGVkIHdoZW4gZHJpdmVyIHdoaWNoIHJlZ2lzdGVy
ZWQgdGhlIHBpbiB1bmJpbmRzDQo+PiArCQkgKiBhbmQgZGlmZmVyZW50IGluc3RhbmNlIHJlZ2lz
dGVyZWQgcGluIG9uIHRoYXQgcGFyZW50IHBpbg0KPj4gKwkJICovDQo+PiArCQlpZiAoIXhhX2dl
dF9tYXJrKCZkcGxsX3Bpbl94YSwgcHBpbi0+aWQsIERQTExfUkVHSVNURVJFRCkpDQo+PiArCQkJ
Y29udGludWU7DQo+DQo+V2hhdCBpZiB1bnJlZ2lzdGVyL3VuYmluZCB3b3VsZCBoYXBwZW4gcmln
aHQgW2hlcmVdPw0KPltoZXJlXQ0KDQpUaGVyZSBpcyBhICJnbG9iYWwiIG11dGV4IGxvY2sgd2hp
Y2ggZ3VhcmRzIHRoZSBwaW4vZHBsbCByZWdpc3RyYXRpb24gYW5kIGFsbA0KbmV0bGluayByZXF1
ZXN0cy4gRm9yIG5ldGxpbmsgcmVxdWVzdHMgaW4gdGhpcyBjYXNlIGl0IGlzIGFjcXVpcmVkIGlu
IHRoZQ0KZHBsbF9waW5fcHJlX2RvaXQoLi4pLCB3aGlsZSBhbGwgdGhlIGRwbGwgc3Vic3lzdGVt
IGludGVyYWN0aW9uIGZyb20ga2VybmVsDQptb2R1bGVzIGFyZSBndWFyZGVkIGluIGRwbGxfY29y
ZS5jIGFwaSBmdW5jdGlvbnMgd2l0aCB0aGUgc2FtZSBsb2NrLg0KDQpTbyBhZnRlciBhbGwgdGhp
cyB1c2UgY2FzZSBpcyBwcm90ZWN0ZWQsIGp1c3QgImhpZ2hlciIgaW4gdGhlIHN0YWNrLg0KDQpU
aGFuayB5b3UhDQpBcmthZGl1c3oNCg0KPg0KPj4gICAJCXBhcmVudF9wcml2ID0gZHBsbF9waW5f
b25fZHBsbF9wcml2KGRwbGxfcmVmLT5kcGxsLCBwcGluKTsNCj4+ICAgCQlyZXQgPSBvcHMtPnN0
YXRlX29uX3Bpbl9nZXQocGluLA0KPj4gICAJCQkJCSAgICBkcGxsX3Bpbl9vbl9waW5fcHJpdihw
cGluLCBwaW4pLA0KDQo=

