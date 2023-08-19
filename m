Return-Path: <netdev+bounces-29095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED07819AE
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2040B1C20A22
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2356AB1;
	Sat, 19 Aug 2023 13:23:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD846AAD
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:23:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449774EF3
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692451329; x=1723987329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=62SRyuocz0wcn7TkAkVBBHLl50A5456NwQ39eZGIKLU=;
  b=iQiK5eATDhwCWnKYsDgkVggwAuY0ZM369QZi5JbROTHhzqpNFxpgwW4F
   jxvCQu39YfNQHDAQKux2GRc+s+QaDJjqY/7A8oC+3hZecYq1ELfQ5HRaw
   mImsAdBN+U6Al40szAJWhhy+xEhSBT2zSHRqToZCO4V5xE14LZpIrmxF7
   DiNxMrVqPEJn/ELEDviMsBvYBuUGDjfMNGjaEq4gN2q6HwUSECy6ImbYq
   TIbIDWdpxvPGshlO8EBl3zwW0XBHV2d+K7tvcgrDYYtKHNQpW/ECfP2rH
   wi9oS/kM6mdFSNZGCfGeGggRZ38upDBSfEhk7w0bHjrvr1+zVpL7KChYY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="358266412"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="358266412"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 06:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="858996329"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="858996329"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 19 Aug 2023 06:22:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 19 Aug 2023 06:22:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 19 Aug 2023 06:22:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 19 Aug 2023 06:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZwT94fAO7lEsyTH09sIYq49qDM0BzMBg0M0hI8kk8M2rwS7kH2RYq2ZIC05nqPNKVL7lwlAjzPLmeY6PQENUcjWWN/sWz0TbuotRFzT5P5l1lkNcRh+WiiHGsIwRPvvhOaF/dYWOoByoAJSSuEtntaA20porCoU4LAvyAFW1Ivpuh/o4P/SvsGA12xV1mFkChSxIQti5Cua0ojd0k20k8eY7509hv0nIoGy9j8iZlyznvvdtSFjERH5MOnYEsnJWOTu5vG7JvwOCiTC14HMbwKjA8wdjTK4pe7TU0DkV1A7pNM+sNuCtlLO6Yup/bv9KwvsNvCvdofCQZULUDbYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62SRyuocz0wcn7TkAkVBBHLl50A5456NwQ39eZGIKLU=;
 b=NyLaYoHjr0ySOruk0fbgI9BJv355dPFE4gkAvqmIy/dxNRKvwRESM1QeJodGu0Tjizkm/4FS8vgulaKKAo2XrbQCVHqyLWXuIjSOAR+rHr3H9MfeCkA6Y39p8EjSehxk7H3qjVMUxtYVk65Q/Ppug4Cz3PHEhUA+Yy6W+YNTiktSVvU0NyY4SPAK7iol8/+bqQ2XFYGWMJkVoYpFE1FDm+eIFg4WSArfRM07FtFcm8E16q7bN6a/rQAvzzZKNLWDINEGcsoexAhsxiVyark9gREpHGmhLUd0q8Lus5XIeSgO2kV0cXl6jS2myzx1y+K5fRsYNoDo2mPFaIuZmRucGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Sat, 19 Aug
 2023 13:21:59 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 13:21:59 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Brett Creeley <bcreeley@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v2 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Topic: [PATCH net v2 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Index: AQHZxJ5eB27D1dxtQUig6DyeiGt/wa/Vv9MAgBv2WtA=
Date: Sat, 19 Aug 2023 13:21:58 +0000
Message-ID: <SJ1PR11MB61801A9E39A77D8D89349FF4B818A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
 <20230801172742.3625719-3-anthony.l.nguyen@intel.com>
 <178679d2-938f-3d7d-f03c-2c0210288099@amd.com>
In-Reply-To: <178679d2-938f-3d7d-f03c-2c0210288099@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|SN7PR11MB8111:EE_
x-ms-office365-filtering-correlation-id: a044ad48-8860-4c21-bcbe-08dba0b7446b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E81QjPygfuED1SGIYOn6VBk7J/HQwFhJJRj0IXdx83UE/JJtUshiYlRkRgI/O72Z2FdNnYvNVpsi1ZqtbrkII7n2DIoCdkvatDYW//ko94e+LW2nqQCCtXXjlMw+p6Gy95ArtsJQ+S9AkwVxCKmpppoAz2q8i8Pu3QX5vBdz0o1H1ggErAIzTTRUrh9X0OYFOlknLRpskcCrIQrp4QApC6Ih6PGiUmxn/f1Vfjah2YEUKA9g2fIh0RcRhKU3fUXVAbN96aAudlkqsms+lXDmFK+ZDedhuvm7JtazlG47eq8BRhNCurzgb3vqe+qVAfvMl++yEvFZY6wulk4cj40qjNjJV15H4eU5FZJyVGmx8h2aDBHS1MmK0ApFoZsQoETqM07+dirwe7P99ir4Urr3MVwiiKldduDVdE9eQhFEO7D+AfYLxes0mK3brlLOm5GHkZRL27jRk0aVYUCdCzfUSkEg5yN0Hos/dAvsxcebOhc7vahxvDhH332hZpL8AzTGzuEZakCEjikqOSB9cRsOsVBT3zPRtXdQlBBeSKFH21st+qUdovDxiuXm4cnPEjnpI1qJ7OtNi3LLKAYMT71eV/etoWmc0YHsgGJc0/WPto1cVRQIiSNdJ/qDgKqryKqI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199024)(186009)(1800799009)(86362001)(33656002)(122000001)(82960400001)(38070700005)(38100700002)(55016003)(52536014)(110136005)(76116006)(66446008)(66556008)(7696005)(64756008)(66476007)(53546011)(316002)(71200400001)(54906003)(6506007)(5660300002)(4326008)(41300700001)(9686003)(8936002)(26005)(8676002)(478600001)(66946007)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlI4UDN1WkkxVUdJLzB5TXBwQXJtbG9LNXBSMUY4R1B3ajVKYStiMnFJVTV6?=
 =?utf-8?B?MkVzcnBuS3VaTHo1TFBsOC9IVTB5bGROS0VLeGI0M3VOTGdpS0ZYSGtPbjFt?=
 =?utf-8?B?U0x2bndrRStQeWJoaTIwSGVsSWhLR2F4SkoxTm9qZXNvM1RQWTlIN0ZrcFRJ?=
 =?utf-8?B?VmNaR0t5N01xV0hTWmcvV1FjWnRRMXIrL3BPQk9mRWJCZmkrcEtVV2tmTlcv?=
 =?utf-8?B?R1FCV2VJVFlxekRuKzloL3BldUU3a3VIbGpiQVVKMzV1RkRyc1hyRnhZcnFF?=
 =?utf-8?B?V3dxZG5CZ25UQzNLdGxMSzlNQnBQWldBMFVRbnA4NFBBMGJ0bE9VWVdHdDZY?=
 =?utf-8?B?K3J0RHhMdW1KLzMzcmtrOHVYRXJtV2hKY2twVUc4VXdXZ0xlajZNOVJzb01l?=
 =?utf-8?B?QTZqdFlHTnZOS2IrcXJ0ZlVMc2ZITnBpTEFQWjNHN09TUG56Q09QNUdPT1h6?=
 =?utf-8?B?ZFM4eENjelM2eDduZDNTc09DS2RtV1RDOGczYWhWbnpkSk11WGU2ei9YNG5k?=
 =?utf-8?B?WjgzbmRtOGRQdlFPZ3VYaUJuaUduQkFMSGlBWlVMKytFdEJyNVF0VzhVUHJq?=
 =?utf-8?B?ZDZJM2Z1MkRtVE1iQVVhT0lDdFJIckhzTnhWYXIwdWlJUWlXOEJ6SXNwT3lJ?=
 =?utf-8?B?L2w4blZOYzdISlhqbmk3RWs1dTBRU1IxUnU1TlFzMDlwbVIvRzQvSHZyRy9L?=
 =?utf-8?B?TGc1Tk5paGpZSGxDakEvdGdFNzNNWnkwQWpNcUhzK2hPWWQ4djRTemZFanhI?=
 =?utf-8?B?QmozUHBPSDdkQStsVVd6eWlTdk83ajRhbHczZ3RNdGp3UHFYQ2hNbzM0MXdD?=
 =?utf-8?B?RGVmVURGWXIyK1ZDbUEzYllNRmFudElBNEhwRGtyczk3Z1hrSzQvL0laRWVW?=
 =?utf-8?B?OVpDWXVON3pFZkpmVmdweDc1RFFrY2V5MmQrSS9ReC8waUJseXdta2tONkU4?=
 =?utf-8?B?ck0yaGoyMU5yRTRxQkJoVlhEeFowcDRCdG5YV05rMzA4QXFQVDliVWM2OWdX?=
 =?utf-8?B?YmNMdGJrcXRzb3VQdkFGWmkxTUxydG5WOFI4emI3aTUxc0tVUG01YnFKTHAr?=
 =?utf-8?B?OGtRdjFJWEJxaUVaUFBwWlgxRGdkV0s3UkZpKzFBbEpYa2lkR3FyRGNwZnlp?=
 =?utf-8?B?Y3RqWHlPWGxEWXQ0VHQ5aEMxdm4yTGVERzNzek15UTdwRUtZZzc2QjJwVU0x?=
 =?utf-8?B?cEZzZkJ2c0p3SGZaYmdmTTM4NjhXc2gyRGpXcjRZNEJldTk5UVRrQUhMUmdj?=
 =?utf-8?B?L21oY0dadkVQODlLZEVrZmZ0MTMwMXRWMHJJa1FIejd0Qi9pUU1uTW8yRW4r?=
 =?utf-8?B?WWgyVU1vby9neldPdk9Wa0VtUmxxSGNaakwvVWI2Z0ZxTjcrYmZHNnMydnhL?=
 =?utf-8?B?NGJEV1hEUmU5eVZqeGRXRThXRkd3bm0rdGowd2xJc3lpTzM0bm53TG4rWkVL?=
 =?utf-8?B?YXV6Ny8yTGowYmR5ZDc5d0M5ZlNHV2xEM21IOEFGQmlVQjFHWVR1NWh1Tlph?=
 =?utf-8?B?WGtFclZWVTlMbno2djRocmxoWUpnYmF1RlNKejhHSmpGaklURERFOTFYRnVa?=
 =?utf-8?B?alh1YUhvM2o0NXN4R2FQQXJjUTg4WG5sKzJ1NytpR0sxQjNBNHlHVFJXVWts?=
 =?utf-8?B?cWVZQmFraVhWanpEdFhwOFBKM2dPSFRETmovcG41TEVXalBaUm9QOGpGSWlk?=
 =?utf-8?B?WElkOUJGLy9tOWlEa3R4ZFVtb09Zb1U0TE9hMnEvMVdQTDFOMVE0b2pDTUVT?=
 =?utf-8?B?NmY3cThHNmVmdkRNcWRRRytRT2c5UjRHWTZTMCtmNWFFZlNqMDYvSW93MXJa?=
 =?utf-8?B?YXdrNStpVFEyQWNQRXRKR3h1eXdReDBaVlJSUVI0RXdTdlVkWk9CbEdKVnlX?=
 =?utf-8?B?UHNveU9IaWhRUXArak9BUDd2cVVOdm5mMXdnVmt0TDhsNjhzUzhURlQxNXY3?=
 =?utf-8?B?WSt6Wm5WNXk0aStzbnYwemhFY0hReWJPRG01ZkdUM1pDUWN5OElTbC9TZEU0?=
 =?utf-8?B?NGtPKzZwRXhldjhYRTRPWVdQOGRNS0RlSmhBWFErZkJhV1JMTzhqQkJmeTVx?=
 =?utf-8?B?aHh3YVUvWmkzdHA2NTdEYXRlelFEMVJoanZIZlAyYys0Tk1xR29xOFU2bnZq?=
 =?utf-8?B?MUJoalAreTJiZStlWER3ZkwwSnh1QWVNSGhZRERhNGh6RDRpWUVSZk1HcXVL?=
 =?utf-8?Q?6h2eU5p68AP2BHW8cT22FI8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a044ad48-8860-4c21-bcbe-08dba0b7446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 13:21:59.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxL7YQY6a8C4a8BEUn1nznLs7jU8RpbjftQS8ZpFgFg8VQMHC4vZsYoC272zBLIWRtg1gMgh3lzn66XGjjw/8AFaqWJiYVFWkBmbDuSUSzUx+rb1KmCLKwSLiemN/J9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RGVhciBCcmV0dCwNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LiBJIHRydWx5IG1pc3MgdGhl
c2UgZmVlZGJhY2tzLiBNeSBiYWQg4pi5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQnJldHQgQ3JlZWxleSA8YmNyZWVsZXlAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCAyIEF1Z3VzdCwgMjAyMyAyOjE4IEFNDQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBrdWJhQGtl
cm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOw0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVo
YW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+Ow0KPiBOZWZ0aW4sIFNhc2hhIDxzYXNo
YS5uZWZ0aW5AaW50ZWwuY29tPjsgTmFhbWEgTWVpcg0KPiA8bmFhbWF4Lm1laXJAbGludXguaW50
ZWwuY29tPjsgU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIG5ldCB2MiAyLzJdIGlnYzogTW9kaWZ5IHRoZSB0eC11c2VjcyBjb2FsZXNjZSBzZXR0
aW5nDQo+IA0KPiBPbiA4LzEvMjAyMyAxMDoyNyBBTSwgVG9ueSBOZ3V5ZW4gd3JvdGU6DQo+ID4g
Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2Uu
IFVzZSBwcm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5n
IGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiA+DQo+ID4NCj4gPiBGcm9tOiBNdWhhbW1hZCBIdXNh
aW5pIFp1bGtpZmxpIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggZW5hYmxlcyB1c2VycyB0byBtb2RpZnkgdGhlIHR4LXVzZWNzIHBhcmFt
ZXRlci4NCj4gPiBUaGUgcngtdXNlY3MgdmFsdWUgd2lsbCBhZGhlcmUgdG8gdGhlIHNhbWUgdmFs
dWUgYXMgdHgtdXNlY3MgaWYgdGhlDQo+ID4gcXVldWUgcGFpciBzZXR0aW5nIGlzIGVuYWJsZWQu
DQo+ID4NCj4gPiBIb3cgdG8gdGVzdDoNCj4gPiBVc2VyIGNhbiBzZXQgdGhlIGNvYWxlc2NlIHZh
bHVlIHVzaW5nIGV0aHRvb2wgY29tbWFuZC4NCj4gPg0KPiA+IEV4YW1wbGUgY29tbWFuZDoNCj4g
PiBTZXQ6IGV0aHRvb2wgLUMgPGludGVyZmFjZT4NCj4gPg0KPiA+IFByZXZpb3VzIG91dHB1dDoN
Cj4gPg0KPiA+IHJvb3RAUDEyRFlIVVNBSU5JOn4jIGV0aHRvb2wgLUMgZW5wMTcwczAgdHgtdXNl
Y3MgMTAgbmV0bGluayBlcnJvcjoNCj4gPiBJbnZhbGlkIGFyZ3VtZW50DQo+ID4NCj4gPiBOZXcg
b3V0cHV0Og0KPiA+DQo+ID4gcm9vdEBQMTJEWUhVU0FJTkk6fiMgZXRodG9vbCAtQyBlbnAxNzBz
MCB0eC11c2VjcyAxMA0KPiA+IHJ4LXVzZWNzOiAxMA0KPiA+IHJ4LWZyYW1lczogbi9hDQo+ID4g
cngtdXNlY3MtaXJxOiBuL2ENCj4gPiByeC1mcmFtZXMtaXJxOiBuL2ENCj4gPg0KPiA+IHR4LXVz
ZWNzOiAxMA0KPiA+IHR4LWZyYW1lczogbi9hDQo+ID4gdHgtdXNlY3MtaXJxOiBuL2ENCj4gPiB0
eC1mcmFtZXMtaXJxOiBuL2ENCj4gPg0KPiA+IEZpeGVzOiA4YzVhZDBkYWU5M2MgKCJpZ2M6IEFk
ZCBldGh0b29sIHN1cHBvcnQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIEh1c2Fpbmkg
WnVsa2lmbGkNCj4gPiA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+ID4g
VGVzdGVkLWJ5OiBOYWFtYSBNZWlyIDxuYWFtYXgubWVpckBsaW51eC5pbnRlbC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBUb255IE5ndXllbiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2V0aHRvb2wuYyB8IDQ5
ICsrKysrKysrKysrKysrKy0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19ldGh0b29sLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jDQo+ID4gaW5kZXggNjJkOTI1YjI2ZjJjLi5lZDY3
ZDkwNjE0NTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdj
L2lnY19ldGh0b29sLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2Mv
aWdjX2V0aHRvb2wuYw0KPiA+IEBAIC05MTQsMTkgKzkxNCw0NCBAQCBzdGF0aWMgaW50IGlnY19l
dGh0b29sX3NldF9jb2FsZXNjZShzdHJ1Y3QNCj4gbmV0X2RldmljZSAqbmV0ZGV2LA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGFwdGVyLT5mbGFncyAmPSB+SUdDX0ZMQUdfRE1BQzsN
Cj4gPiAgICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgIC8qIGNvbnZlcnQgdG8gcmF0ZSBvZiBp
cnEncyBwZXIgc2Vjb25kICovDQo+ID4gLSAgICAgICBpZiAoZWMtPnJ4X2NvYWxlc2NlX3VzZWNz
ICYmIGVjLT5yeF9jb2FsZXNjZV91c2VjcyA8PSAzKQ0KPiA+IC0gICAgICAgICAgICAgICBhZGFw
dGVyLT5yeF9pdHJfc2V0dGluZyA9IGVjLT5yeF9jb2FsZXNjZV91c2VjczsNCj4gPiAtICAgICAg
IGVsc2UNCj4gPiAtICAgICAgICAgICAgICAgYWRhcHRlci0+cnhfaXRyX3NldHRpbmcgPSBlYy0+
cnhfY29hbGVzY2VfdXNlY3MgPDwgMjsNCj4gPiArICAgICAgIGlmIChhZGFwdGVyLT5mbGFncyAm
IElHQ19GTEFHX1FVRVVFX1BBSVJTKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHUzMiBvbGRfdHhf
aXRyLCBvbGRfcnhfaXRyOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgLyogVGhpcyBpcyB0
byBnZXQgYmFjayB0aGUgb3JpZ2luYWwgdmFsdWUgYmVmb3JlIGJ5dGUgc2hpZnRpbmcgKi8NCj4g
PiArICAgICAgICAgICAgICAgb2xkX3R4X2l0ciA9IChhZGFwdGVyLT50eF9pdHJfc2V0dGluZyA8
PSAzKSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRhcHRlci0+dHhfaXRy
X3NldHRpbmcgOg0KPiA+ICsgYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPj4gMjsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgIG9sZF9yeF9pdHIgPSAoYWRhcHRlci0+cnhfaXRyX3NldHRpbmcg
PD0gMykgPw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkYXB0ZXItPnJ4X2l0
cl9zZXR0aW5nIDoNCj4gPiArIGFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nID4+IDI7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICBpZiAob2xkX3R4X2l0ciAhPSBlYy0+dHhfY29hbGVzY2VfdXNl
Y3MpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoZWMtPnR4X2NvYWxlc2NlX3Vz
ZWNzICYmIGVjLT50eF9jb2FsZXNjZV91c2VjcyA8PSAzKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPSBlYy0+dHhfY29hbGVzY2Vf
dXNlY3M7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPQ0KPiA+ICsgZWMt
PnR4X2NvYWxlc2NlX3VzZWNzIDw8IDI7DQo+IA0KPiBJdCBzZWVtcyBsaWtlIHRoaXMgaWYvZWxz
ZSBmbG93IGlzIGR1cGxpY2F0ZWQgbXVsdGlwbGUgdGltZXMgdGhyb3VnaG91dCB0aGlzDQo+IHBh
dGNoLiBNYXliZSBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gaW50cm9kdWNlIGEgaGVscGVyIGZ1bmN0
aW9uIHNvIHlvdSBjYW4NCj4ganVzdCBkbyB0aGUgZm9sbG93aW5nOg0KDQpZZWFoIHRoYXQgaXMg
YSBncmVhdCBzdWdnZXN0aW9uLiBXaWxsIGRvIHRoYXQuDQoNCj4gDQo+IGFkYXB0ZXItPnR4X2l0
cl9zZXR0aW5nID0NCj4gCWlnY19ldGh0b29sX2NvYWxlc2NlX3RvX2l0cl9zZXR0aW5nKGVjLT50
eF9jb2FsZXNjZSk7DQo+IA0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBhZGFw
dGVyLT5yeF9pdHJfc2V0dGluZyA9IGFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nOw0KPiA+ICsgICAg
ICAgICAgICAgICB9IGVsc2UgaWYgKG9sZF9yeF9pdHIgIT0gZWMtPnJ4X2NvYWxlc2NlX3VzZWNz
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVjLT5yeF9jb2FsZXNjZV91c2Vj
cyAmJiBlYy0+cnhfY29hbGVzY2VfdXNlY3MgPD0gMykNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nID0gZWMtPnJ4X2NvYWxlc2NlX3Vz
ZWNzOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nID0NCj4gPiArIGVjLT5y
eF9jb2FsZXNjZV91c2VjcyA8PCAyOw0KPiANCj4gU2VlbXMgbGlrZSB0aGUgaGVscGVyIGZ1bmN0
aW9uIGNvdWxkIHdvcmsgZm9yIGJvdGggdHgvcng6DQogDQpZdXAuIEJvdGggYXJlIHVzaW5nIHNh
bWUgY29uZGl0aW9uLiANCg0KPiANCj4gYWRhcHRlci0+cnhfaXRyX3NldHRpbmcgPQ0KPiAJaWdj
X2V0aHRvb2xfY29hbHNlY2VfdG9faXRyX3NldHRpbmcoZWMtPnJ4X2NvYWxlc2NlKTsNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPSBh
ZGFwdGVyLT5yeF9pdHJfc2V0dGluZzsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAg
ICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgLyogY29udmVydCB0byByYXRlIG9mIGly
cSdzIHBlciBzZWNvbmQgKi8NCj4gPiArICAgICAgICAgICAgICAgaWYgKGVjLT5yeF9jb2FsZXNj
ZV91c2VjcyAmJiBlYy0+cnhfY29hbGVzY2VfdXNlY3MgPD0gMykNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBhZGFwdGVyLT5yeF9pdHJfc2V0dGluZyA9IGVjLT5yeF9jb2FsZXNjZV91c2Vj
czsNCj4gPiArICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nID0NCj4gPiArIGVjLT5yeF9jb2FsZXNjZV91c2VjcyA8
PCAyOw0KPiANCj4gYWRhcHRlci0+cnhfaXRyX3NldHRpbmcgPQ0KPiAJaWdjX2V0aHRvb2xfY29h
bHNlY2VfdG9faXRyX3NldHRpbmcoZWMtPnJ4X2NvYWxlc2NlKTsNCg0KTm90ZWQuDQoNCj4gDQo+
ID4NCj4gPiAtICAgICAgIC8qIGNvbnZlcnQgdG8gcmF0ZSBvZiBpcnEncyBwZXIgc2Vjb25kICov
DQo+ID4gLSAgICAgICBpZiAoYWRhcHRlci0+ZmxhZ3MgJiBJR0NfRkxBR19RVUVVRV9QQUlSUykN
Cj4gPiAtICAgICAgICAgICAgICAgYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPSBhZGFwdGVyLT5y
eF9pdHJfc2V0dGluZzsNCj4gPiAtICAgICAgIGVsc2UgaWYgKGVjLT50eF9jb2FsZXNjZV91c2Vj
cyAmJiBlYy0+dHhfY29hbGVzY2VfdXNlY3MgPD0gMykNCj4gPiAtICAgICAgICAgICAgICAgYWRh
cHRlci0+dHhfaXRyX3NldHRpbmcgPSBlYy0+dHhfY29hbGVzY2VfdXNlY3M7DQo+ID4gLSAgICAg
ICBlbHNlDQo+ID4gLSAgICAgICAgICAgICAgIGFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nID0gZWMt
PnR4X2NvYWxlc2NlX3VzZWNzIDw8IDI7DQo+ID4gKyAgICAgICAgICAgICAgIC8qIGNvbnZlcnQg
dG8gcmF0ZSBvZiBpcnEncyBwZXIgc2Vjb25kICovDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChl
Yy0+dHhfY29hbGVzY2VfdXNlY3MgJiYgZWMtPnR4X2NvYWxlc2NlX3VzZWNzIDw9IDMpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPSBlYy0+dHhf
Y29hbGVzY2VfdXNlY3M7DQo+ID4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBhZGFwdGVyLT50eF9pdHJfc2V0dGluZyA9DQo+ID4gKyBlYy0+dHhfY29h
bGVzY2VfdXNlY3MgPDwgMjsNCj4gDQo+IGFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nID0NCj4gCWln
Y19ldGh0b29sX2NvYWxlc2NlX3RvX2l0cl9zZXR0aW5nKGVjLT50eF9jb2FsZXNjZSk7DQoNClN1
cmUuIPCfmIoNCg0KPiANCj4gDQo+ID4gKyAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgYWRhcHRlci0+bnVtX3FfdmVjdG9yczsgaSsrKSB7DQo+ID4gICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgaWdjX3FfdmVjdG9yICpxX3ZlY3RvciA9IGFkYXB0ZXItPnFfdmVjdG9y
W2ldOw0KPiA+IC0tDQo+ID4gMi4zOC4xDQo+ID4NCj4gPg0K

