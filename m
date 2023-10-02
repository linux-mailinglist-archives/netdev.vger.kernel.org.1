Return-Path: <netdev+bounces-37427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348C7B5530
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 004602831B4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8E10A1E;
	Mon,  2 Oct 2023 14:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732E1A700
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 14:32:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69330AD;
	Mon,  2 Oct 2023 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696257154; x=1727793154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DAt/clDwQ/abgQdJLpl7wv4dYDEV8jSvafUDn6V3VLc=;
  b=IFfG1foiRAWtl6RjFq3SfEKy7pO8ROdarRTX/09vdjn+wpmeP/rRufrp
   WfD2i9B7x4ULWqjmkw80lkNJPYtf4EspckVqWVw3M/wNzAfLwJre8QPHY
   UU9nbedZHwBgyng9IW4yGSJ5HCpVxlA4yRECkGdacYstmOWwBXkgVx0RS
   qchO9acK2ICdN373kGMdS7A+RyZKXvLkSHhqBflPMu7sVmNsP5eQdi95W
   wyvQqCtN2uanVL/GQUk2RV4UoXgbf+3OMPZssDNzXD7vhFcmrkUfVyX6f
   GJ3ftlrdymbXf7GA6KnKu+9crG09b2lEVIvJA9N63zPih8hr3TZP0K/IA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381537135"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381537135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="866513949"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="866513949"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 07:32:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 07:32:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 07:32:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 07:32:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 07:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/R7kpRLJ1Ja94hnJez7/qqCWenaKPuk7km/8DD37pCGnmNTwkS66gD9U2jFmBmfVOEOTXtNnbimvPXM5Iqpf8oBjsKne3fCNW8lQvXiD/HTbyZ5etWxWLv4ql032qaxN+8FrvQsYgN99xcNN9kxOI1s3e7BAgeAX0Cc3F6PmwBigy07dJBRAc8Hvfh7bRDpYBoNBU6ReSPuysBm5sv/P7Vf+XoOys7SwcT9+XP1c+a+e3I1oB8w1tl8l4andL+WVjnjo54BtZ06UwHQbRa5pX1VwnBZYBmN6QGsv6By9Mb00v4fIwnEGLGmZPct15eRwv6p9iuq5ZfRPtVci3IQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAt/clDwQ/abgQdJLpl7wv4dYDEV8jSvafUDn6V3VLc=;
 b=Fjn2wZrla2F8JNCTKouxrdVfUWvOYT81wcOTzx7VwGJKVfk4J4cZ5aoAUSpoFxWcaWnEvp9Udb1gNRf7v2ue0dD9Oy8FzY2OgqymGmd6mPVByAqQbrk6uD3NPuR20QTxIQ9fGAeny0cFwETBLGH2aZujqAutA9zpzmg5uq30kfDp0ka6FrUHqKMWrtKfTK6tuHUlQ8+pwGDxEvqmrxSEwqKJmKhDuAYbYi8ebeqHABQxrpWJz6ybXcZts4Nk7ozpiIv44Ohz+orqJDzeiOMvbDEE257TGDSSy1/t/qm8ebKM3oF1I8JVw0rtYo4G52W3N8hGX2k8JgB9yK/44rBqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.25; Mon, 2 Oct 2023 14:32:30 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f%3]) with mapi id 15.20.6813.035; Mon, 2 Oct 2023
 14:32:30 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next 3/4] dpll: netlink/core: add support for pin-dpll
 signal phase offset/adjust
Thread-Topic: [PATCH net-next 3/4] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Thread-Index: AQHZ8STYBdXle/Bxd0eyxPCX/7DD6LAu+R+AgAebAaA=
Date: Mon, 2 Oct 2023 14:32:30 +0000
Message-ID: <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
In-Reply-To: <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: 9979ad44-9e0a-4bbb-279f-08dbc35468d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kLDWa/z2bOyc9t2XGrExXPm/6b4zhRArHgAMD0b4Z376zza8Oj4cKwVG9jpAK+23FJjw0vToCGP1XJ1jnjfDUDiFMAE74IlDC9F8qHS9Begg7MmymbBATt8sNJ8QtAbHq/0GcvNLakBFTMRT2IspR3m04mWzDBYYwL6mSToNQrR39QJxk6dJeuXUIHFMS0mCBiSp6Ixp2oR7as8LQHVMFGfKA6O8hzx4gLVZAClTEKQrJkOLiWSE8MNy3+6OV3mbksudGzf5/NcGvOEN7mAWTC9pQtSg6N++/jVyj3rCKjY0V0ysFPFGrUL1COwr9rkZDoM9aJ96PjZCoRriOW91ODALu6odNtBC2Hb47fzd1Iaf266efZNStIipxxTCAmjQZoRzJq1uRGugNpQyDzCYpZRZucjFckCoZIlAhzOLEtTX5dl5vZJRqmXt9vMr+2p2CEeBDKpkVTKkPLroZ7IP2MM/HVaTZlXp4eScAlZnUlIr2nLo4weW6TcGxrsEAkCi7BuyBqtZtabY2MQ5R6fPYUkrTSxnvbmvg7qrL8FKTnHrAKBHNvUAML4oMztZJplHKnzgMF/Vg7KgpnJSQg/ruJI3kGGC+jrp4lNpNwHgDsrtcuKI7cIAFr5xhbHcq7T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(83380400001)(86362001)(33656002)(38070700005)(38100700002)(82960400001)(55016003)(122000001)(110136005)(64756008)(66446008)(54906003)(76116006)(66946007)(66476007)(66556008)(9686003)(316002)(7696005)(6506007)(41300700001)(478600001)(71200400001)(52536014)(5660300002)(8676002)(8936002)(4326008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0ZpZmtwQkxxc3gzWEs0QWVJTm01allhS3plZ1R3N2x3YUhuQ1hYTTltMlhq?=
 =?utf-8?B?OFBWOFVLY3l6RDlvbWpmaFBobm4zWC95WXc5U2UyNDkrYUFWU0gxVGE3OUFl?=
 =?utf-8?B?N1lwTjB1MnRaZlMxL3JqMUdJaW93MGZXQ0ZRK1cvYTRlOW5Sa0pnSVlQdm56?=
 =?utf-8?B?QmRuNFc3dWZSRWNDWVpzWVV5cVdYRjlvWWVibnNiOFlZZUtNSzVJdGY0MG1V?=
 =?utf-8?B?em9IQmVBTGtyakIrSXYzL21NUzFjMDRlMWJtbXdDdzU3NUVrNldiUld1dkdL?=
 =?utf-8?B?R2N2MlN3bTd2V3hDcDRNV0k4dXFnR2YxcUprZm1jaEFsOWV2WGtrSjVWZFBl?=
 =?utf-8?B?anJoK0pmdnhtY1c2VDhqMlV6TmlEck1SSHk0NHRNSVpjNVRMU1pGYXlLSWZJ?=
 =?utf-8?B?Q2pKeEo5WlJhYnNmZ2JPTm4xbUhyT0N5QjNjYWo4cHNUYUhBYjFYbGd5OWZ4?=
 =?utf-8?B?MmhKTFFDRU03NkdVWUpzRmg2WE9pb1dIN250THBwa3BWd2YxVmdUM1dZekNX?=
 =?utf-8?B?TWNMMGNKQkcxN013MFR4bCtSNm5pQnhyM0pzaDdOb2t1bWoydEN1dEQ1L20v?=
 =?utf-8?B?bTd5RE9Vc2ZxQUVoSDBIZStJZ0xzekJ5Z0dSYjZqV0h5YW1tcncxMWpZYllu?=
 =?utf-8?B?aW4zUGNLREhPcWhnMlJFLzZPNnhGNUxjNnlGOUZEeWc2VUhKbXlsWDR0cnBs?=
 =?utf-8?B?bTJDT1FtM3I0dndjczBBRENvTEtpODMrN0JndEVjWkh0cExMazNqUG1nUkUx?=
 =?utf-8?B?NmplTWhaSzRaYWxtcSs0cGdrNmhzd0MveXQrYVRvVjk2TGRSeHJSVHhVN0xY?=
 =?utf-8?B?R3J5eVdYOTgwZWdTajBSK0UyUjJxeEhNREM1ZFdsNC8vdVFRV0VFY2tHR0xX?=
 =?utf-8?B?bVpZM3dsbVZXOFgyR2ZybDJNMWJvTmZaQXdVVnY5MDRxUE1Qam81VGorNUFh?=
 =?utf-8?B?eTZicTFacGkwK2E4UlhpRXNIVzRZV3pCKzJFQXdwZnNxODc2WWhLUjhENkVV?=
 =?utf-8?B?K290TndmWjhseGZNWk9VNEx1Uk1lS1RadVU5SzJaSzNWTGhITHVBSFhQMWQy?=
 =?utf-8?B?ektiRS9rNm5FV3h4am03WlQxMThnOS9uQlRyTUdJR1JxMkh3SGRJdDdlaTBn?=
 =?utf-8?B?T3g1dTQzdG8zRlBTSFdTRTVadmNnN3doREpZSnR6VjZGUVp1dVYyWlZZTEdE?=
 =?utf-8?B?MVprVWx0SmVFdXVXbklEQnFBaU9ob1Fhc0dNeDN4WGoyQUwwNWNUcENoUjB3?=
 =?utf-8?B?UDZJTHFVc2dOd1M2NXhuZWZkSzFlU2R4bnpYcUJ3amgrVWlsTFppd0RCQkdh?=
 =?utf-8?B?ajR1TGhKY01URml4K0Z1V0hpakhtUlJVc3hNK056RDRWci9tbVVIQVVTK1RF?=
 =?utf-8?B?dVRnaWkvdmRZMXd3WUlkUlluZVBIV0xUaWxrdXpwZ1A3T0hHSzl4VllhY21l?=
 =?utf-8?B?ZEJ2T1NlTklLVnZxeGZyOFg0RkdrVkhtaXI0c0hvV0V6UDNHM1hYWmdrdUxt?=
 =?utf-8?B?QjJCVDZxeis0WGJ1d3FyYVZnQmpQSUJWeTR1blJMQlNUZVlxbTVSaXdkQ3No?=
 =?utf-8?B?K3VpclVEUGROMmFsZ3VnQkhxaWl4b3UrZ2h2VVZTNFV6ZFZXUGw0TGtXNWdZ?=
 =?utf-8?B?WEkyNmo5eXRWNkNPTnRTbHJscEtLUXQ1TFdMZExxb1gzLzZ3MG1jb2FGSmJj?=
 =?utf-8?B?Z3QxQWlkR0l0ZlhxZDdDc1pWWDRuT282RWk0Vm1nTmZ0L29QZ2pOUTNMREw4?=
 =?utf-8?B?emEvOXF4anRDNThzcVlkVm02N3RnRGdZOFp5dkU5ODcrOGpSdHpXci9jcmtB?=
 =?utf-8?B?ai82c1cvS2I5MGlGY3h3YjRHZkpqNVNtMVBLZGxjMUJTaVdCT2taS1hPTEZQ?=
 =?utf-8?B?SkhyQ00zWnZzdTRTSVR3ZGlDaVV2c1V5RDNNSG5rZmw5Vnl2cThZNzQ1WmZk?=
 =?utf-8?B?VjMyM2FFbll0bEpKdTFEMWRzejNOR0x6dFJ3QkR5ODE5T1h6Q3BNbEdvNUtv?=
 =?utf-8?B?cnMwb2NnSWVBcWhWcTFqRFdWVmdHWVZYOElIcFBNSVZ1VFZvQ1pFYnNNVWFu?=
 =?utf-8?B?ZXZCSGljR0JYV0lnamVYSjBjdmJ6dER0a1hpdE1QanYwc09sdUJpK3hqMThQ?=
 =?utf-8?B?VzdqamdubnM1Y0xnS1YyMHYvbEVweHJiTVpzODV1cHRFcEUvaXluUDhUVUo5?=
 =?utf-8?B?NkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9979ad44-9e0a-4bbb-279f-08dbc35468d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 14:32:30.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWDhj7YS0xmTROpVBSzUZOqAfWHrT2H2Xr0aYPh8xMhcJiHbm3sx+X1N1A/nvUvRhMDyYilsrmCS0YoGM52KrRzdbIFv9P3K9X5ziaIfCCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PkZyb206IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj5TZW50
OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA4OjA5IFBNDQo+DQo+T24gMjcvMDkvMjAy
MyAxMDoyNCwgQXJrYWRpdXN6IEt1YmFsZXdza2kgd3JvdGU6DQo+PiBBZGQgY2FsbGJhY2sgb3Ag
KGdldCkgZm9yIHBpbi1kcGxsIHBoYXNlLW9mZnNldCBtZWFzdXJtZW50Lg0KPj4gQWRkIGNhbGxi
YWNrIG9wcyAoZ2V0L3NldCkgZm9yIHBpbiBzaWduYWwgcGhhc2UgYWRqdXN0bWVudC4NCj4+IEFk
ZCBtaW4gYW5kIG1heCBwaGFzZSBhZGp1c3RtZW50IHZhbHVlcyB0byBwaW4gcHJvcHJ0aWVzLg0K
Pj4gSW52b2tlIGdldCBjYWxsYmFja3Mgd2hlbiBmaWxsaW5nIHVwIHRoZSBwaW4gZGV0YWlscyB0
byBwcm92aWRlIHVzZXINCj4+IHdpdGggcGhhc2UgcmVsYXRlZCBhdHRyaWJ1dGUgdmFsdWVzLg0K
Pj4gSW52b2tlIHBoYXNlLWFkanVzdCBzZXQgY2FsbGJhY2sgd2hlbiBwaGFzZS1hZGp1c3QgdmFs
dWUgaXMgcHJvdmlkZWQgZm9yDQo+PiBwaW4tc2V0IHJlcXVlc3QuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogQXJrYWRpdXN6IEt1YmFsZXdza2kgPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNv
bT4NCj4NCj5bLi4uXQ0KPg0KPj4gK3N0YXRpYyBpbnQNCj4+ICtkcGxsX3Bpbl9waGFzZV9hZGpf
c2V0KHN0cnVjdCBkcGxsX3BpbiAqcGluLCBzdHJ1Y3QgbmxhdHRyDQo+PiAqcGhhc2VfYWRqX2F0
dHIsDQo+PiArCQkgICAgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKQ0KPj4gK3sN
Cj4+ICsJc3RydWN0IGRwbGxfcGluX3JlZiAqcmVmOw0KPj4gKwl1bnNpZ25lZCBsb25nIGk7DQo+
PiArCXMzMiBwaGFzZV9hZGo7DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiArCXBoYXNlX2FkaiA9
IG5sYV9nZXRfczMyKHBoYXNlX2Fkal9hdHRyKTsNCj4+ICsJaWYgKHBoYXNlX2FkaiA+IHBpbi0+
cHJvcC0+cGhhc2VfcmFuZ2UubWF4IHx8DQo+PiArCSAgICBwaGFzZV9hZGogPCBwaW4tPnByb3At
PnBoYXNlX3JhbmdlLm1pbikgew0KPj4gKwkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLCAicGhhc2Ug
YWRqdXN0IHZhbHVlIG5vdCBzdXBwb3J0ZWQiKTsNCj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4g
Kwl9DQo+PiArCXhhX2Zvcl9lYWNoKCZwaW4tPmRwbGxfcmVmcywgaSwgcmVmKSB7DQo+PiArCQlj
b25zdCBzdHJ1Y3QgZHBsbF9waW5fb3BzICpvcHMgPSBkcGxsX3Bpbl9vcHMocmVmKTsNCj4+ICsJ
CXN0cnVjdCBkcGxsX2RldmljZSAqZHBsbCA9IHJlZi0+ZHBsbDsNCj4+ICsNCj4+ICsJCWlmICgh
b3BzLT5waGFzZV9hZGp1c3Rfc2V0KQ0KPj4gKwkJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4NCj5J
J20gdGhpbmtpbmcgYWJvdXQgdGhpcyBwYXJ0LiBXZSBjYW4gcG90ZW50aWFsbHkgaGF2ZSBkcGxs
IGRldmljZXMgd2l0aA0KPmRpZmZlcmVudCBleHBlY3RhdGlvbnMgb24gcGhhc2UgYWRqdXN0bWVu
dHMsIHJpZ2h0PyBBbmQgaWYgb25lIG9mIHRoZW0NCj53b24ndCBiZSBhYmxlIHRvIGFkanVzdCBw
aGFzZSAob3Igd2lsbCBmYWlsIGluIHRoZSBuZXh0IGxpbmUpLCB0aGVuDQo+bmV0bGluayB3aWxs
IHJldHVybiBFT1BOT1RTVVBQIHdoaWxlIF9zb21lXyBvZiB0aGUgZGV2aWNlcyB3aWxsIGJlDQo+
YWRqdXN0ZWQuIERvZXNuJ3QgbG9vayBncmVhdC4gQ2FuIHdlIHRoaW5rIGFib3V0IGRpZmZlcmVu
dCB3YXkgdG8gYXBwbHkNCj50aGUgY2hhbmdlPw0KPg0KDQpXZWxsIG1ha2VzIHNlbnNlIHRvIG1l
Lg0KDQpEb2VzIGZvbGxvd2luZyBtYWtlcyBzZW5zZSBhcyBhIGZpeD8NCldlIHdvdWxkIGNhbGwg
b3AgZm9yIGFsbCBkZXZpY2VzIHdoaWNoIGhhcyBiZWVuIHByb3ZpZGVkIHdpdGggdGhlIG9wLg0K
SWYgZGV2aWNlIGhhcyBubyBvcCAtPiBhZGQgZXh0YWNrIGVycm9yLCBjb250aW51ZQ0KSWYgZGV2
aWNlIGZhaWxzIHRvIHNldCAtPiBhZGQgZXh0YWNrIGVycm9yLCBjb250aW51ZQ0KRnVuY3Rpb24g
YWx3YXlzIHJldHVybnMgMC4NCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6DQoNCj4NCj4+ICsJCXJl
dCA9IG9wcy0+cGhhc2VfYWRqdXN0X3NldChwaW4sDQo+PiArCQkJCQkgICAgZHBsbF9waW5fb25f
ZHBsbF9wcml2KGRwbGwsIHBpbiksDQo+PiArCQkJCQkgICAgZHBsbCwgZHBsbF9wcml2KGRwbGwp
LCBwaGFzZV9hZGosDQo+PiArCQkJCQkgICAgZXh0YWNrKTsNCj4+ICsJCWlmIChyZXQpDQo+PiAr
CQkJcmV0dXJuIHJldDsNCj4+ICsJfQ0KPj4gKwlfX2RwbGxfcGluX2NoYW5nZV9udGYocGluKTsN
Cj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0K

