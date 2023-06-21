Return-Path: <netdev+bounces-12675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D580E73873F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD971C20D1F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737F154A7;
	Wed, 21 Jun 2023 14:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0432F39
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:39:32 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74510EC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687358370; x=1718894370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JgLdW9xBDsyNKvW6a29/eMqopoeBrN/t2DIrTgUhg+o=;
  b=ROUMCdMvq8eWCr7Ulb/dmiB2gmY8aO8jdRnV7m17lJJvpeQHEMbd8ODg
   2g2iSp5M5UU9AesFvq0RO3Aryz9jCRDXhtU7kvU1mHrXQ4J+VAh3qGj0c
   imh6MFLiOxeh2H3vGt5RQl9zelNR0HnAYSAv4tQJ7hS+XaQ1OnQbXBz4i
   2Qa8tXIe2UpJPDExP0VhLafg4JQWkTr6ZjgyLx0kx1skcJCEGsnxZqaCT
   oDwarpeDYiaEBtrX0fYiSDSpZ2EBPOHBgh9rkmu5KViFwy28WOLcqG+hr
   qIujkwctv8IVr9F1WK7pyevxXZGM074HpO9QNR1DwllwVPfnpWpGqVVAk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389707735"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="389707735"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691874130"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="691874130"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 07:39:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 07:39:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 07:39:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 07:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbItY505mXccWrb2yPKhUs92g3c0SbIYTjpZ7FzX5CpJbGdOUanyIVkTWC4ex0KT/so6XuX65s7RlsCGsy97HHE9Q7tXgjZWlVRTKnmN4dkqJ2i0kKDg3jLkb6vQf8ZLQ5blPq93XlObZhOsAk5K0yNa2Pw8oEIKV4z4Jxa0SjIUDFKHMirmzGG2M33poju++PKFq+kbxn0i3YfBkCvGLrYUT4zfqfbfPIP78juG5fBknDXWunMDcaGS+ogyrj94nRcd3gVemMCrduBLh5N0zqQCPN+drHOD/NGGzAvkNULo7lT+ABOrVj3Ddr2iv2VtRLzIP3TzO+39XoA3YMNqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgLdW9xBDsyNKvW6a29/eMqopoeBrN/t2DIrTgUhg+o=;
 b=NtoP3Pr+GFNMYID4/selXSJmC+EmkZ8Y7qWzCamp6qIYD32LyfseBr4VnXb3FMG6tYBvCTqk/+YxWafpeeJctpiYensZiSrwSnhxqW6n/iqT3e8MrnitxfHWQ5Ghwn2KLrT0C1NtDUKQB8d4CacS5gWAGwRwRy8wT6dJ86M8qcqPTAQjDFgZ2vOVBIXtQIF0CFdeci2XuhG5vbqJ5IVIRBAnzk7Kt/S/7r3hs1BVa3mXL1mFZi7rnhaYylIyVL2wK2MIqD1wqv0DOHrWxu6dObQlJXdQ44FsdGurJJMhbrOoiGCnfHZ4ayTsMFQwN6Vs4MWGR7bLEZEMCV/NGfkdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Wed, 21 Jun
 2023 14:39:00 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::5e37:38f7:33d2:137a]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::5e37:38f7:33d2:137a%7]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 14:39:00 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"daniel.machon@microchip.com" <daniel.machon@microchip.com>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [PATCH iwl-next v6 00/10] Implement support for SRIOV + LAG
Thread-Topic: [PATCH iwl-next v6 00/10] Implement support for SRIOV + LAG
Thread-Index: AQHZo8UQ2b2jUqU4gEm1FskdOkL/16+UhfmAgADM9sA=
Date: Wed, 21 Jun 2023 14:39:00 +0000
Message-ID: <MW5PR11MB581140622B33E82BC694C7FDDD5DA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
 <20230620191907.3a812399@kernel.org>
In-Reply-To: <20230620191907.3a812399@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|IA0PR11MB8334:EE_
x-ms-office365-filtering-correlation-id: 050b119f-f898-4069-6ee9-08db726540dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Oe5UQUiSVOp1EfwZnnrJ+EZ6mRMM25Und6GxVYGjUeJ9Ycyt5YLv9bJTiK86UprpwuL4D304A+Dnz4k0edoUFJuxgHYPZSb+vlphp99rL0Dw+wFzxcejQnyzqtEPlsZBktbXs/X7qBhjY0AaRb0tyODkBYVQ1tvjjwa+Q9QhMB8Vx64oeDzsZMoE86Ko0s3GzPyLteTMq1w+zjjML4WeHj71nblaL/+cGcCHzdsL98J9JPX2PdG7tDRyeSzAlMV8CFYnqPSVd5Wgigz5d/AOJCHBBttFjfkmLqu12X0P1JPedNlWXhuHgX2Z0YG03Ih6Wg7dMeu0AzTWmya4AgDm82zO1JHLTiBTL0iqTD4Ju+5VRDwbHmMzYVaa0aw6abDnpFR+g0l2WTdzGR1ERpMyjNdq3vHt6DXueu2i6VjS1w0fR58SvVLNqqnQGITuojeE8BtXm53PXXaLI76Kh57JmDHeFyvti8bIIt5KRJR6QYeF2+ik256Sbzvyx79qH5LX4mD2pgFlB8ZfTEUlAukJBtZUY76pDUeUqrTroOow2Z6QlRKA3P36FJAVofSLTI8v3tJMOISmKPinbp5oVRfAf0tSTXJsLcSDgZmtsta+ik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(83380400001)(107886003)(186003)(6506007)(53546011)(26005)(9686003)(71200400001)(54906003)(7696005)(38100700002)(478600001)(82960400001)(38070700005)(122000001)(86362001)(8676002)(52536014)(55016003)(76116006)(66476007)(316002)(66946007)(8936002)(4326008)(5660300002)(66556008)(66446008)(6916009)(41300700001)(966005)(2906002)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVsYkY1NnFiWjkxQXpKb05mOVJFMFY3QVh4U1NjdUc2VjVPeDNrbXB6Nmow?=
 =?utf-8?B?ZVdOc0UyYnA4ZjYvYjRNcFdzemRya3ViK0EvY1RZbnA3VDN2c3VxRTE2LzVU?=
 =?utf-8?B?QUhhT05iTWpyRkJoczUwbDByZlBGVnE0cXFzRWVHY0FNL3dWUHM4b1JIbHFT?=
 =?utf-8?B?ODdMVUhzRzlUWEtYNEZHUHpTNGJ0a0JnZUw4cG43UG1EOFlPOVQ5TDhlTHc1?=
 =?utf-8?B?cElWM3BQc0tPcm5UcDJOSVErQm9DRERsUlZpRnZObXB3MFV5K3R2Y2hiV3BF?=
 =?utf-8?B?djdaeENaYkRSclphN2ZVU013TlBOQ2NZczFqeklMQ1JrRDc1VlFLSDR4amVp?=
 =?utf-8?B?Q0dEK0NYM1U5M1JMMXBXOE03bXJmQTN5TzlXZU5ieEMyRnVKS3U4ZS93Uk1S?=
 =?utf-8?B?N21GR1lMaVBkcVB0NmdLemp2ckFZVHlrUGpDR1hlSit2cGUxR1NHQ3h0dkJZ?=
 =?utf-8?B?TDRJUktPbUhRWDBaQzJTaGtoTmVsTUE4TGx0c1pkOUZScWE5RHM3R2ducUdB?=
 =?utf-8?B?OXhTb25hWVdlYWFaVS9rT29xRE1vYUVJZnlwV2lYekJBbmRHc0xnc25yNTJX?=
 =?utf-8?B?aURuQ1hnR3NsKzMxMWw3SmhuRHJyU1crZWxzem1PZWhDTGp4Y2hGMWJlb2Vl?=
 =?utf-8?B?VkVjcjc3WTU0QW9ORTRhMFdWVmpSY21jNHJ3NHlCTG1qK0xMaU4yN1NLalA3?=
 =?utf-8?B?ZmRicnRVTVhTOXUyZjZmcWJ4SldrVkhFeU0rS3JmelUrMVlEbjV2a1BkMitV?=
 =?utf-8?B?VC9lMys0MFJBODE3dW1uN0ptRzhFQzFEOEtSaEdZOU4waEdZSXAxdDMrZjQ1?=
 =?utf-8?B?UVZUb0UvSFdPcExOQkI2NXJTU0JjZk1vakxOd3RYZ21jR1VXSDQzZE9LRTZL?=
 =?utf-8?B?MkdZZkxEQ1Z6K0VTa2kvZFdPK2xLQkt4c1pIbFV3dmF2RWVWRnVIcE15NXFv?=
 =?utf-8?B?UmxVc281eVR4T29uWG4wdW44U1BOYmthRTZHanhQbjRjQURGZjQ0R2ErOUdv?=
 =?utf-8?B?U3lSN2xoVkQ2R3ZPdnlMeDJTeGxOaXpWellBM255RTNZTmNTOGtzNUx5K3A5?=
 =?utf-8?B?dnQ1Z3JZdG1FQXg0VmUzVnIxS0JtQlFhQVFlRVNDY2VIQXFWYkQ3ak55MTd0?=
 =?utf-8?B?S0p0b0c0ckhEaFFlNDE0TUcwbmRDSWhOQ3YyZjJUOWZNdk1ka21aTEptM0tE?=
 =?utf-8?B?dGhzcnY3UGR0OG5iVHAyVW94dU1ONjliN0x4eGVnNVBqdStEUWxLaTlGOXJv?=
 =?utf-8?B?eGpoT2FSU2xyWTMrYlh6YlkyclJLM21ZOXlnd0c1NWtpYXN5VEJ0cHdNSXRu?=
 =?utf-8?B?TTdtZ3VOckRhakt2ZEt4MHFseU1hRzllK1lmaWoxdE1rMU9hODlkSkFiL0Qw?=
 =?utf-8?B?MExaNVRKL3hXNlZlbWt5aUJLTk5xNG95YmxKOTZFSEFCc3hoUmhQN0p6eXA3?=
 =?utf-8?B?OVBpUjh3YnRsVzcrSlBMUEdWR1FvNWhjRVF4b3hPSlFRTGFHRllRZk4yWTZ3?=
 =?utf-8?B?YUV6cytsSWlwcjI4WWQzemIyMDdtNW95T1ZoS1lJaEhsaCtFdTNiLzZxUThk?=
 =?utf-8?B?NUpzL1NXVko4T2RPaDhPU0M5ZnJ5RXlNRFlOZFNEQ2RXaCt0VFlKZ20vM2or?=
 =?utf-8?B?RGp0aXMwKzBJdzRvaFNub0c4ZGhCSmZ2NUphRWpmdlBNd0piT2JoTUFiN3BP?=
 =?utf-8?B?K2ZrNWM2a0l4aldMY2pFdjdKZDRWZks4SUg2MUt6U01CL3hnbVByZytQSDhZ?=
 =?utf-8?B?aVpiVnZMbE9tclkrNWp2RllacmJ3dXRDNVNuWkxpckJQK3NaUGR3MlhlQ1hx?=
 =?utf-8?B?clZ5cmRxY096Zy9LY3RabUZkOWUxaTQ3WUt4c2oweFV6ekNzVUpUUW91MUpY?=
 =?utf-8?B?K3J3VXpGTVF0OVlZN0pSbGhWTXRxalhEbHpGMFErT29ycHpSV3N6bUxrUG5C?=
 =?utf-8?B?TVEycWQzNEpFQTBQc3hsRlhMZ2V4S3hhTUMwNmpjemlabFpPdDNuWUlmeTN0?=
 =?utf-8?B?QzdVNEl5VnY4TnZWK1V6SWlWVXoyV2owOFczVmlnT2N2OHRhRjlDZGZxVzNo?=
 =?utf-8?B?eVFTUWVPK1pmMStXbnBJWEpWMzRMMThOUjIyOUNIYnVib1E4NkNVd2h6N2RK?=
 =?utf-8?Q?8qb8Eol7s9a3CM84i1rdzRTax?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5811.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050b119f-f898-4069-6ee9-08db726540dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 14:39:00.7919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwhfEiXMHk0GpY6xy1jQ0DMiDhBZVpfsH9PsUolLM9w6m2rZGrbhQrYyI8UjiHR28NztKNnnN43BDiJbYZWKpG4OvooOd90y6UmzB6pFrlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDIwLCAyMDIzIDc6MTkgUE0NCj4g
VG86IEVydG1hbiwgRGF2aWQgTSA8ZGF2aWQubS5lcnRtYW5AaW50ZWwuY29tPg0KPiBDYzogaW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGRhbmllbC5tYWNob25AbWljcm9jaGlwLmNvbTsgc2ltb24uaG9ybWFuQGNvcmlnaW5lLmNvbTsN
Cj4gYmNyZWVsZXlAYW1kLmNvbTsgTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5A
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGl3bC1uZXh0IHY2IDAwLzEwXSBJbXBs
ZW1lbnQgc3VwcG9ydCBmb3IgU1JJT1YgKyBMQUcNCj4gDQo+IE9uIFR1ZSwgMjAgSnVuIDIwMjMg
MTU6MTg6NDQgLTA3MDAgRGF2ZSBFcnRtYW4gd3JvdGU6DQo+ID4gSW1wbGVtZW50IHN1cHBvcnQg
Zm9yIFNSSU9WIFZGJ3Mgb24gaW50ZXJmYWNlcyB0aGF0IGFyZSBpbiBhbg0KPiA+IGFnZ3JlZ2F0
ZSBpbnRlcmZhY2UuDQo+ID4NCj4gPiBUaGUgZmlyc3QgaW50ZXJmYWNlIGFkZGVkIGludG8gdGhl
IGFnZ3JlZ2F0ZSB3aWxsIGJlIGZsYWdnZWQgYXMNCj4gPiB0aGUgcHJpbWFyeSBpbnRlcmZhY2Us
IGFuZCB0aGlzIHByaW1hcnkgaW50ZXJmYWNlIHdpbGwgYmUNCj4gPiByZXNwb25zaWJsZSBmb3Ig
bWFuYWdpbmcgdGhlIFZGJ3MgcmVzb3VyY2VzLiAgVkYncyBjcmVhdGVkIG9uIHRoZQ0KPiA+IHBy
aW1hcnkgYXJlIHRoZSBvbmx5IFZGcyB0aGF0IHdpbGwgYmUgc3VwcG9ydGVkIG9uIHRoZSBhZ2dy
ZWdhdGUuDQo+ID4gT25seSBBY3RpdmUtQmFja3VwIG1vZGUgd2lsbCBiZSBzdXBwb3J0ZWQgYW5k
IG9ubHkgYWdncmVnYXRlcyB3aG9zZQ0KPiA+IHByaW1hcnkgaW50ZXJmYWNlIGlzIGluIHN3aXRj
aGRldiBtb2RlIHdpbGwgYmUgc3VwcG9ydGVkLg0KPiANCj4gSWYgeW91J3JlIENDaW5nIG5ldGRl
diB5b3UgbmVlZCB0byBvYmV5IG5ldGRldiBydWxlczoNCj4gDQo+IGh0dHBzOi8vd3d3Lmtlcm5l
bC5vcmcvZG9jL2h0bWwvbmV4dC9wcm9jZXNzL21haW50YWluZXItDQo+IG5ldGRldi5odG1sI3Jl
c2VuZGluZy1hZnRlci1yZXZpZXcNCj4gDQo+IFlvdSBoYXZlIHNlbnQgdHdvIHZlcnNpb24gb2Yg
dGhpcyB0b2RheSAoYW5kIHRoZXJlIHdlcmVuJ3QgZXZlbg0KPiBhbnkgcmVwbGllcykuDQoNCkkg
YXBvbG9naXplIGZvciB0aGF0ISAgVjUgd2FzIGFuIGFjY2lkZW50YWwgcmVzZW5kIGZyb20gdGhl
IHBhdGNoLXNldCBmcm9tIGxhc3Qgd2VlaywgdjYgaXMgdGhlDQpyZXZpc2lvbiAgYWZ0ZXIgcmVz
cG9uZGluZyB0byB0aGUgZmVlZGJhY2sgb3ZlciB0aGUgd2Vla2VuZC4NCg0KTmV2ZXIgdHJ5IHNl
bmRpbmcgYSBwYXRjaCBzZXQgaW4gdGhlIG1vcm5pbmcgb2YgY29taW5nIGJhY2sgZnJvbSBhIGxv
bmcgd2Vla2VuZCAtIGxlc3NvbiBsZWFybmVkIQ0KDQpEYXZlRQ0K

