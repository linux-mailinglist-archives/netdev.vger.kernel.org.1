Return-Path: <netdev+bounces-55783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDED480C50E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F724B20B25
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714812137F;
	Mon, 11 Dec 2023 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxh6ZZL2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6691C13A
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702287925; x=1733823925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IC7bt6ut0mxCyiYotUxDRROCRGobU9nbIzkr0dQzs48=;
  b=gxh6ZZL2V7WxQJQHq02h1MUMZ4Qj5VFZxlWNcMJT34ratNJNRgjd7dn6
   Zgi7D32uIEvbzpTFwqUv2f195EVagUd82ECsSiajYclD2mDDlblfR1FYl
   9NMhajQcRDAS2cacm4gzn8WlZOH/zw43pW8wS7MFlApImDZQhll8SSI/q
   h86GSs/FdLhdm+rlsuIynlw1Nf6ON4VtxL8/T66SV3NLJqlbK6mx4r+ZM
   OnL1jfTIlHLKNeZAIcH/ep5goHrXDifbS7OSBg++iwuctowK1YQJjj9VI
   EusHwa3ImDKTeFfFOxLns1ak/V2mgvOz1l7dg8v0RF4rP25mYZL1IJ070
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="16173042"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="16173042"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 01:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="838963965"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="838963965"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 01:45:21 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 01:45:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 01:45:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 01:45:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4jkvYZ2KITZgHwwXf5Q9MoNHq3sR4rvpSy3KLCYT+NZjpRRf/AyJjWBdwWPfJ2hkDmDkMwxzXZ31URIUZn9/91cVfJHf5QL0vmCapVyMPvNdNu7mHvpifIKuk6afo+vJl1xl9m6oYAhrcJD5pyaYpdj2q72uncTuLtWTohkxf0IhPrM+Ar7U5hePUhadVJtVuzxmSXhv+aOeEUe7giFJotCedDvozcnU02AtDuH84U/a2mdgx2Ucvq5pEcxej55rVlU0a4V++fhXANwwmzYfSpCPJ4jkDOrmEUPfrwU3ON8KfBhGP9aINU5IQjCASn3z4dzeqXMKe91x4jtePMUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC7bt6ut0mxCyiYotUxDRROCRGobU9nbIzkr0dQzs48=;
 b=I2f9h+w5mj83SYIXLNElE4qNxAk2IMgLkyidNqE/wHIHLCrwpKbIzJ6NE/Y10kADDe9GjbJzWDqacoqAmXBgtKLV9Sp+xeXkK6MFQs/pajoSkoXi3DFrPMSAMvKsimcUqOSLEP7gTE4Yk++yhm6ACX0d6+225CyDm0c3TwzJI5xf2VlJLH59i2sunUfLgG7fJCwKlOM2LHhzF2dJD9WlQkRdbmK32SaAmSD9s2WOU0Aegb7W9co7zPUPeLwxM90GrZs3hT4ao+PmmuXTMZ56lGD5p00yUSQbGy9Qh1gsRFzTwluIcqkJO1zww9uPUYM3PgG4Q/OzSAIFPBvu404VDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2731.namprd11.prod.outlook.com (2603:10b6:5:c3::25) by
 CH0PR11MB5473.namprd11.prod.outlook.com (2603:10b6:610:d4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 09:45:19 +0000
Received: from DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::d315:1202:838:9b76]) by DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::d315:1202:838:9b76%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:45:18 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v3 1/2] ixgbe: Refactor overtemp event handling
Thread-Topic: [PATCH iwl-next v3 1/2] ixgbe: Refactor overtemp event handling
Thread-Index: AQHaKbbUapXDIsgTSkm9rVA3FeW0I7CfKSSAgASnxOA=
Date: Mon, 11 Dec 2023 09:45:18 +0000
Message-ID: <DM6PR11MB2731EFF4B5E7BDE8886EA913F08FA@DM6PR11MB2731.namprd11.prod.outlook.com>
References: <20231208090055.303507-1-jedrzej.jagielski@intel.com>
 <20231208090055.303507-2-jedrzej.jagielski@intel.com>
 <f63dca8f-0082-6e22-5ab5-3b940b646053@intel.com>
In-Reply-To: <f63dca8f-0082-6e22-5ab5-3b940b646053@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-Mentions: anthony.l.nguyen@intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2731:EE_|CH0PR11MB5473:EE_
x-ms-office365-filtering-correlation-id: 0d61c301-554b-459e-a9b4-08dbfa2de298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6LObJBFIIQCZ/mSFpyQc9C9I+Ge7g0NmsAMNXsbJeSuSHOfDNVxFjTWcL24JHiNlLdwN3u8vQR4+qzstGY9F7QQHKdoUbYBTinQZM2BAA/1itqzWw5w7wbPpfXLyjiqez8ZpVs4g2+MYhbU8UvuIq74YGiqvm9o2OkSLO69aESNiOv295t+brJ2FtwW/zWgHc45OTRiqdqkIqwVgDkSMfFpawl1BOPMCH7aUmicoR0jpoXOOItedG3/GXOJ4fcj8In9VoI9cPzVirKL1R2nL/kTya1shZwZ9OTU+hd5WAmvwSA5llcVbh3jNQZ7h/H3Xa8ERYIYszXe25nAIAvwPf+YI9NgvEisbbIU3TL10cyfbNOsCI6YFFxroP6lse710mSlwHIBRwpcjaeR+4AOZnpS4eVOcEuZUhx09KV/4enlKt40c7VsiqwwFOB30JdL6ZS1o9bLqcqEbInTZQs+Gs/U8aNfnTX4agNrwjmad0tqe/M7aTNL7lAhT1kQUrFNYH7d+2eoQkddjAWBIgNAnLaMYhBWfXSfk8tXeUVHNOIl6YLyuHo+YwTOubN5Ag+p8Hl455ZjYp0iAdjRh/LPWQqyDvAEbmeZey3oXA07cKDY0gAYoIiLKAROPI9AoowRU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2731.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(9686003)(52536014)(6506007)(5660300002)(26005)(33656002)(55016003)(38070700009)(66946007)(64756008)(76116006)(6636002)(66446008)(66476007)(66556008)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(122000001)(110136005)(316002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VitIbXFLUGdUZTBiNkZ5a3ZqSk9nRzZLbnNQS1pVczNnSUVuTWhDNGR1Wlox?=
 =?utf-8?B?SU5IaUZyS2xGUTFoY0EwZFRYbVBXTlBhd3FtMHNZZ2F2ZmttV0FFbDNoNkt3?=
 =?utf-8?B?SnNkdVc3TmdUTjl5QWRFN2tZTW1xbzN4QS95MC9CSHF0cHlKTDU2MTJvOWZU?=
 =?utf-8?B?ZUNrQ2ZuM3pkSVdzUTIrNU1NRFJ6bGVKa2FTS1ZLZ1NzdU9GVEtZQkEwYlEx?=
 =?utf-8?B?Zk9WczN0RnZOVzRKUm9mOTRzMHJYYy95TlJrQTdqNlZzYjhBaFV5aVdxZ2lo?=
 =?utf-8?B?am40WG1ReXJxS1hXUE9wdnJ1MnVoWXBTWGNjSkllcDQwSG92MlpjS2gvNWU1?=
 =?utf-8?B?OUtjaVJUY0NnSi8vRGJTVVR6VnE1TUNGNXZrazNuMXBTVDZZZDRybnRnblZQ?=
 =?utf-8?B?Q1NkYWhMbXFWdFVQM0xYdFZVcmpmcW5uNzFQYVRISzFGbTFxVlBtckpQZk1p?=
 =?utf-8?B?MXlxeFdTeFVFTGtQUVE4Q2pja1hzeU5xbUtIRUJlNDh3YldJZFI1OFZvb0Jx?=
 =?utf-8?B?d2I0UXQ2dXpMSVd2NW0rV25QR3lUZGtRMU9VR1ludTNjNUdvUmFvU3lCdEtS?=
 =?utf-8?B?aGN0aWdpbitnb1BkRzBkTWZCK1BJc3Q4aWd2ZFNiT1NCZ1R3MnlyZlBXbEl6?=
 =?utf-8?B?Z014bEFTR3ArdlJ1TTRCQ3FNN2NiWkViSGhsaGg0c0dDNkpCRmhLSmhHMXpv?=
 =?utf-8?B?blJoNE5Xc1g3a0dxZmpKS1l5dTdzTDYxSkhzeS92MEJtdFIrdUVSeHI5djIz?=
 =?utf-8?B?dHF5ZkxCS2UwcXpkZ09aemovRlE0ZE84WjlvTGt1aVZpdnVibHpCSGRrb1Y5?=
 =?utf-8?B?NHI1YWZZK2swZ0ZXbWpLVHJhbS9MbjI1Z3RpUmtLSWt3VDVHVDc0a1ZScE9T?=
 =?utf-8?B?aHRXUklVaDJHR1ExOXEycS9jU3V1SVVRcXpIVTBjelErZE5zdERwbHBkaGVr?=
 =?utf-8?B?V0tqZ2c3WHFTMXB5TGt0dXJ0Q2dLQUV2K25BNlJJSTFkWitta0I5dEJCS1FR?=
 =?utf-8?B?Y0s5R2lEY25pMVh5bitzNHVxempFQXc2U1pEeTdmalJndk1UYmFSbDMwaDdD?=
 =?utf-8?B?VUsvRGlQVUVCQlNLS0NONjJKbThNVFVSSE95WGZ4Z1FwUmtjN3lXNGk4dWwv?=
 =?utf-8?B?MkFRMzhNN01iMHE5WHZqQ3l6YWRsT0I2U3FFWkRFODdZTWxYejRHOGQ3cDVt?=
 =?utf-8?B?V0luU21wbEJObU1kS1RUZXFNWTROOWR5QmF2QW1qaGtSRWRaZ2p0QkhBUU5v?=
 =?utf-8?B?Uk5NdXVSY0VVVGVkbU1MQzNIdTgyZ1pVNVVXOTMwYjl5Sm1WdFdkVm5DcDY1?=
 =?utf-8?B?THMzRy9qbFd5NDR4OTZyYmNJd2ZrVTNzWElHL0xIb3pZQng5SkxwUjRBcklW?=
 =?utf-8?B?TzFuUFl1Tkg5Uzk5VVJMTkhid1NaSUhKWmV6OVZkd0F0aElDMnRodHczL1hR?=
 =?utf-8?B?NnhlaC8vZ05MeGlEQTBQMy9rVUpxRFpWbEZrYTVuOStIK3FrTThZa1Fqb0d2?=
 =?utf-8?B?SHlGR0ZLeTlUZzRNUkFXbHRmaVJaTVh6QW04V3NsZFd1WUkxQVZOYTN5emdX?=
 =?utf-8?B?RjRLQnQvT3dvd3V0RWVrQWtETlRUbW1ReXdod3JqYXVMT3dRV1dHZ0RSYkhZ?=
 =?utf-8?B?V2hMd1V5aCtmYTdsZ1hkMmRUSHYzQ0pzWEkydlY5VG14T3RtVW5NalJRTGoz?=
 =?utf-8?B?L2dZbVFPYnppMnI2ZExoN1FCdW95VG84UmpqY0NKUjJCeWticU02OWM1TEtl?=
 =?utf-8?B?UllpUlM3OHRnWFRNZGVIcnRFZllRSnoxQlU2VURmblRTMWY2YjM0cUh1Nkor?=
 =?utf-8?B?UTRGYWMyS0wyQU9sUEhEQlIyVnR0WHNrajZ0d2FqWW9NYWFuZEMrK01zN3VW?=
 =?utf-8?B?aXFiWFVCU0JJY0MwUzhMenZUYnpzKzNLTmI5cGVxWmtHSW9xakpIeFB0bjBp?=
 =?utf-8?B?REhURmdJSStsWDFvMDVob2YyOHQ4WlpyOXQ2OXRMT1VIRnAzZ0x5MkhEeElF?=
 =?utf-8?B?OWlTd21VVWpFeFByNFVXWDBwdk4xaHhNdC9Tc1NGZ3ZEY0xvd3lJN0RGRnBZ?=
 =?utf-8?B?NGJDL1AxcmVoU1pqc1pLWFY0bmtZOHphYkFpRlpJSGFnYUNLWGhQcW1uRmsz?=
 =?utf-8?Q?RUwLlGMRS/wba+E0WurTJot7b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2731.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d61c301-554b-459e-a9b4-08dbfa2de298
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 09:45:18.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VnSpEULQmXZ6koss10AKAihWmuhfjJxboJQA/ZQ+QWb+gleJyr+UCGPKQ5vlmuDZBTBewTJYAVb5fGkUdEsUKzhbghUp6cBvLd7tRbsQ80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5473
X-OriginatorOrg: intel.com

RnJvbTogS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4g
DQpTZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgMTE6MDcgQU0NCg0KPk9uIDEyLzgvMjMg
MTA6MDAsIEplZHJ6ZWogSmFnaWVsc2tpIHdyb3RlOg0KPj4gQ3VycmVudGx5IGl4Z2JlIGRyaXZl
ciBpcyBub3RpZmllZCBvZiBvdmVyaGVhdGluZyBldmVudHMNCj4+IHZpYSBpbnRlcm5hbCBJWEdC
RV9FUlJfT1ZFUlRFTVAgZXJyb3IgY29kZS4NCj4+IA0KPj4gQ2hhbmdlIHRoZSBhcHByb2FjaCB0
byB1c2UgZnJlc2hseSBpbnRyb2R1Y2VkIGlzX292ZXJ0ZW1wDQo+PiBmdW5jdGlvbiBwYXJhbWV0
ZXIgd2hpY2ggc2V0IHdoZW4gc3VjaCBldmVudCBvY2N1cnMuDQo+PiBBZGQgbmV3IHBhcmFtZXRl
ciB0byB0aGUgY2hlY2tfb3ZlcnRlbXAoKSBhbmQgaGFuZGxlX2xhc2koKQ0KPj4gcGh5IG9wcy4N
Cj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmVkcnplaiBKYWdpZWxza2kgPGplZHJ6ZWouamFnaWVs
c2tpQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gdjI6IGNoYW5nZSBhcHJvYWNoIHRvIHVzZSBhZGRp
dGlvbmFsIGZ1bmN0aW9uIHBhcmFtZXRlciB0byBub3RpZnkgd2hlbiBvdmVyaGVhdA0KPg0KPm9u
IHB1YmxpYyBtYWlsaW5nIGxpc3RzIGl0cyBiZXN0IHRvIHJlcXVpcmUgbGlua3MgdG8gcHJldmlv
dXMgdmVyc2lvbnMNCj4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
eGdiZS9peGdiZV9tYWluLmMgfCAyMCArKysrLS0tLQ0KPj4gICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9peGdiZS9peGdiZV9waHkuYyAgfCAzMyArKysrKysrKystLS0tDQo+PiAgIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3BoeS5oICB8ICAyICstDQo+PiAgIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3R5cGUuaCB8ICA0ICstDQo+PiAg
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3g1NTAuYyB8IDQ3ICsrKysr
KysrKysrKy0tLS0tLS0NCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAz
OSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2l4Z2JlL2l4Z2JlX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4
Z2JlL2l4Z2JlX21haW4uYw0KPj4gaW5kZXggMjI3NDE1ZDYxZWZjLi5mNjIwMGYwZDFlMDYgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9tYWlu
LmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX21haW4u
Yw0KPj4gQEAgLTI3NTYsNyArMjc1Niw3IEBAIHN0YXRpYyB2b2lkIGl4Z2JlX2NoZWNrX292ZXJ0
ZW1wX3N1YnRhc2soc3RydWN0IGl4Z2JlX2FkYXB0ZXIgKmFkYXB0ZXIpDQo+PiAgIHsNCj4+ICAg
CXN0cnVjdCBpeGdiZV9odyAqaHcgPSAmYWRhcHRlci0+aHc7DQo+PiAgIAl1MzIgZWljciA9IGFk
YXB0ZXItPmludGVycnVwdF9ldmVudDsNCj4+IC0JczMyIHJjOw0KPj4gKwlib29sIG92ZXJ0ZW1w
Ow0KPj4gICANCj4+ICAgCWlmICh0ZXN0X2JpdChfX0lYR0JFX0RPV04sICZhZGFwdGVyLT5zdGF0
ZSkpDQo+PiAgIAkJcmV0dXJuOw0KPj4gQEAgLTI3OTAsMTQgKzI3OTAsMTUgQEAgc3RhdGljIHZv
aWQgaXhnYmVfY2hlY2tfb3ZlcnRlbXBfc3VidGFzayhzdHJ1Y3QgaXhnYmVfYWRhcHRlciAqYWRh
cHRlcikNCj4+ICAgCQl9DQo+PiAgIA0KPj4gICAJCS8qIENoZWNrIGlmIHRoaXMgaXMgbm90IGR1
ZSB0byBvdmVydGVtcCAqLw0KPj4gLQkJaWYgKGh3LT5waHkub3BzLmNoZWNrX292ZXJ0ZW1wKGh3
KSAhPSBJWEdCRV9FUlJfT1ZFUlRFTVApDQo+PiArCQlody0+cGh5Lm9wcy5jaGVja19vdmVydGVt
cChodywgJm92ZXJ0ZW1wKTsNCj4NCj55b3UgbmV3ZXIgKGF0IGxlYXN0IGluIHRoZSBzY29wZSBv
ZiB0aGlzIHBhdGNoKSBjaGVjayByZXR1cm4gY29kZSBvZg0KPi5jaGVja19vdmVydGVtcCgpLCBz
byB5b3UgY291bGQgcGVyaGFwcyBpbnN0ZWFkIGNoYW5nZSBpdCB0byByZXR1cm4NCj5ib29sLCBh
bmQganVzdCByZXR1cm4gInRydWUgaWYgb3ZlcnRlbXAgZGV0ZWN0ZWQNCg0KR2VuZXJhbGx5IEkg
dGhpbmsgaXQgaXMgZ29vZCB0aGluayB0byBnaXZlIGEgcG9zc2liaWxpdHkgdG8gcmV0dXJuIGVy
cm9yIGNvZGUsDQpkZXNwaXRlIGhlcmUgaXQgaXMgbm90IHVzZWQgKG5vIHBvc3NpYmlsaXR5IHRv
IGhhbmRsZSBpdCBzaW5jZSBjYWxsZWQgZnJvbQ0Kdm9pZCBmdW5jdGlvbiwganVzdCByZXR1cm4p
Lg0KQWxsIG90aGVyIHBoeSBvcHMgYXJlIGFsc28gczMyIHR5cGUsIHNvIHRoaXMgb25lIGlzIGFs
aWduZWQgd2l0aCB0aGVtLg0KDQpATmd1eWVuLCBBbnRob255IEwgV2hhdCBkbyB5b3UgdGhpbmsg
b24gdGhhdCBzb2x1dGlvbj8NCg0KPg0KPj4gKwkJaWYgKCFvdmVydGVtcCkNCj4+ICAgCQkJcmV0
dXJuOw0KPj4gICANCj4+ICAgCQlicmVhazsNCj4+ICAgCWNhc2UgSVhHQkVfREVWX0lEX1g1NTBF
TV9BXzFHX1Q6DQo+PiAgIAljYXNlIElYR0JFX0RFVl9JRF9YNTUwRU1fQV8xR19UX0w6DQo+PiAt
CQlyYyA9IGh3LT5waHkub3BzLmNoZWNrX292ZXJ0ZW1wKGh3KTsNCj4+IC0JCWlmIChyYyAhPSBJ
WEdCRV9FUlJfT1ZFUlRFTVApDQo+PiArCQlody0+cGh5Lm9wcy5jaGVja19vdmVydGVtcChodywg
Jm92ZXJ0ZW1wKTsNCj4+ICsJCWlmICghb3ZlcnRlbXApDQo+PiAgIAkJCXJldHVybjsNCj4+ICAg
CQlicmVhazsNCj4+ICAgCWRlZmF1bHQ6DQo+PiBAQCAtMjgwNyw2ICsyODA4LDcgQEAgc3RhdGlj
IHZvaWQgaXhnYmVfY2hlY2tfb3ZlcnRlbXBfc3VidGFzayhzdHJ1Y3QgaXhnYmVfYWRhcHRlciAq
YWRhcHRlcikNCj4+ICAgCQkJcmV0dXJuOw0KPj4gICAJCWJyZWFrOw0KPj4gICAJfQ0KPj4gKw0K
Pg0KPkkgd291bGQgcmVtb3ZlIGNodW5rcyB0aGF0IGFyZSB3aGl0ZXNwYWNlIG9ubHkNCj4NCj4+
ICAgCWVfY3JpdChkcnYsICIlc1xuIiwgaXhnYmVfb3ZlcmhlYXRfbXNnKTsNCj4+ICAgDQo+PiAg
IAlhZGFwdGVyLT5pbnRlcnJ1cHRfZXZlbnQgPSAwOw0KPj4gQEAgLTc5MzgsNyArNzk0MCw3IEBA
IHN0YXRpYyB2b2lkIGl4Z2JlX3NlcnZpY2VfdGltZXIoc3RydWN0IHRpbWVyX2xpc3QgKnQpDQo+
DQo+W3NuaXBdDQo=

