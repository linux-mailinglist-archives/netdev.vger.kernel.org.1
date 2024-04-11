Return-Path: <netdev+bounces-86817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C358A05DA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C040F1F23D8C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E234513AD0C;
	Thu, 11 Apr 2024 02:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTYrMM5B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027E1F5FA
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802775; cv=fail; b=DxsP96VvK5Fn/6Wc1yLqk1v/nga8iE1KDpGN3MsoFISRqToStAsw0qQ0XoqXJrzfJpAU8CWdUr9df5uXsD2sJGDjKE0njUd/F8u/uSEOoKhWMZ/sz/nwj+1psu5fUuwCOnqCrcvAQmHiiZ4nA+Jlf6puebVS4WhQBwgjdyqeX88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802775; c=relaxed/simple;
	bh=wS9BedaFj48bKR1NLgDmVfyiFC5c9GWww4QY/D8Nh+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PF37iz8dIZndloTuXURqdwf5USAZYr0ocxrmBPXzxNuxR4s3K9havkMdy3m7ONgeONhMQSJlbQDDgYi7rNe+yPzgJ4fXpZpbm0y4O93Algrt4c+SnKNMIGi/OsbjV0+MAGi0AvnlHSgopGR8+4l44ovBf5rIXhgGm9UzR9kGszg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTYrMM5B; arc=fail smtp.client-ip=40.107.244.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGOFPPfkquPc/51eBmh/KX4/qcWjVr0PxJZlxlGQGX02Rht1+oa6BVWnqxCEgGhJRo+3TYXg1TK9y/Wh12qH8zemKiknvaLzSpER0Hfu5IpF6F/64le+QA45h3Ci1P+NIfb79WoPPKHuQmbfN1D32mhWCo6mVPdSzfRRwk930f5CmjBnPo+b7jDPARJIUlR8dKtHBGtLeIlW1Cnw3pjwNq58Fi5o3ywlOfDsB57u0dv3Q7n6A1j2XfsFQFn2hE//EGMsRGPFoPyKGr7I/kyGsthuAcA2h8n3qFxS1wR3SV51cBoj7CWeNWyBZjAv3BrJ0RYYUzk1YIidNA56cmjaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS9BedaFj48bKR1NLgDmVfyiFC5c9GWww4QY/D8Nh+0=;
 b=XSjmam4qkKFITEOLQGIFLMEYmuv6rAUh0lEFpSsmz9yB8W+LA89Z6I28jQYcuXXfeckdlmWalJRNYEGBSZd+JwVVr/+FA6PcwENa0XLDtTR/sIHT5MM5wdJlOopXhpDABzm3+h0x5InidseEPYRyTKN9rZk7krslUsyIsOEVKhCLNmA2Bnw7hMhRxcNd+/O0mP+9f1yyEDzmlKHSS6a8kx8qeKIbjfIVuhrNI4WO2pRgiKV9pO6qITzAShtnsjjPtNncE7HwQmihv0jz667NfM27hQZyhsh8oEvg4M01fRkegfz57bgQDIEH6OsWh2X6ehgKiDntLGaogSn6Tpz8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS9BedaFj48bKR1NLgDmVfyiFC5c9GWww4QY/D8Nh+0=;
 b=JTYrMM5Ba6gQGFBzjxvF7kiGCwEQl/HtaEMPcMarqL5w80MpKEXlB7F+vvYIbgyQf9l+O5O30F0rI/lrEKz/2DsDkY4PI7uwt7XdRmFAidXs6Lzml69pVG2ouCS9TcHYkBklO2WTvTW5UNJt2yfOs8hb41x/DVa9QjowwCh2uTT5TgVId72eTqdBV+C2CEyrM9I5HQNlkjB1qZpXRx8gOKV5xjGkeKAuDj3X9zQp4t1ObO2CwDBi6A2Hzw2NA2TUPxfsg0bxEZS4z7OyXmdCGBH7ZWwTG05lO6sN3E+GZyjDfR9B2vUnqk8G9jjE5WhDBrY7ZHInXm2yVLCZXcYFig==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 02:32:51 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Thu, 11 Apr 2024
 02:32:49 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: RE: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Topic: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Index: AQHaiz6PozPVAHS/rUiy5XxYWBlFb7FiJW0AgAAz45A=
Date: Thu, 11 Apr 2024 02:32:49 +0000
Message-ID:
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
In-Reply-To: <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB9276:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b8ZAth8sjc6J1RZh31+AM8SZmvE0LMUXJTlv5dvXo30YxaXy8bXrfbrLKS0mQmdv8OnwMRzhLOSIiQqZu+kws1lVq/ZjJrWHx17vSHI4wYivz7gDKD8aYn+CxrS3KpMP0QImEl2Z+Xut4DGNAE5A0fWXD+bWFV5OKfTJrxeViN0I+Nt/19iykCJIzfYMkaT6PIOhL566usU/Zg+d+xGGs/jp02512h6hzikIAusgHoZsuFbf8DVXURqflMrDU9CSlgfVVp1BVXuv+zp9Tw7ssJhjc9eZQTKoH8hLkkrVO1bw4irHue5o14n7cl9UejPF4SZ/yghLfyQvxqpsNI2CibjNAkqbaUz7A+Tlax5TPasS3duAiHgD1bnum9iSeaMFQN9iey0GbeFdzaJ64GBb+y1bZtoiUtjdzvPUu+dEAADoqEu5ZuVfK3s6p11rBmGrdSIh6E8pLJzyRI+FPJlr3Y1tnSDD587S041l9xsrZ3xw9Jap1c6B++SVPM9j/qnUAiMnd2nV7VsVkExrdJg6lcuCy96BExUYW6nSyN3jj8fx069bjoKJuq7nMikdwusoVjNVAF9XHFiRCnAz+kqfuQKPFg8b06NPotJD09upZ8UBafAwRMlJe66WHiBBkZDCHdcijQYGRT3dBZVJlOOmMUJG5q48TkqMNM7md6DRR8A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0l1cGJDQXdVREJDeFF5NWpvNGljV3dCcjU2MG83NSt2Z0pwRmw5Uld0aHlC?=
 =?utf-8?B?N204Yyt2cFMyWDliYzdFWHFKbHRodVZORTZjY1dsdE5pQ2ZaVnJIcHE2ZzF3?=
 =?utf-8?B?M3BFaSt5YVZjNlA1N1o5OVl0UWhESktXekJWcFpzbWsyTVhHZDlRaGpyRkts?=
 =?utf-8?B?N09nRXB4R21XVE50Z2NBcnBSYndOR0ZqbHJDNVE5U0lFQng4QmhWL0tNQXpK?=
 =?utf-8?B?ZGowZVNGdUFTWjJ2dExTNzBsS0F1Z2t4M3pCM0x2a0N0L1crMXRDQmMvWXBt?=
 =?utf-8?B?VG50L1pkU2lSOE9qeU1uWnpqS2NoZVp1VGttYVNDS1FsajBrTUZSREhtTVRm?=
 =?utf-8?B?WUdpS3lIVWZJNmg5ZGYxL2V1OWZIb0JmcWIxRHZZTElMbjgra254Vk1MUTNq?=
 =?utf-8?B?ZWMvNXJBV045Uno5WFZSNWxqV3ZqVWkvUkpYVjAzenc3MG9qd1Y2ZEYzUFJG?=
 =?utf-8?B?Sm1nNCsrdGNJYzMxT2dhVU9WN0hwYzVVSllqMVFOZVlzYUxKbHMvaUVwMjR4?=
 =?utf-8?B?eDNRQm1IekcrOURHRHdGbGx1SkhYVHhScVZXYVkvY1RROGsrcVlhdDd5M2wy?=
 =?utf-8?B?SmM4emxSa1NUbHJBMHVONnA4WStNZ1hQYkNrbTFMTHY2amlHc0Nob1BvdkIv?=
 =?utf-8?B?SE5WT0VqVnBvQ2k0clBzdG9IM3BHM2JIT3ZJWUhHbVFOYWw0WE5KUlhjNmtQ?=
 =?utf-8?B?QzdwTjBLaXVveVlKZnRCSVE2SVJlM1d5SFhlZG5yS1B5QVJ2Z3BUdSsrRnRi?=
 =?utf-8?B?Qm94RG92MTdwTjdnVHBWbzh5Q0hFZGhqS3dPcWRaTUNHY1BlMDJkcUgwNnpm?=
 =?utf-8?B?U1BnTVBqRU9YL3NUeXM4aTBtZmxPSkVXT2M4djIyUit6U01uMUZZRUp5UjN3?=
 =?utf-8?B?cWFlNU92a1FCU2hseUNpNHlSMGdIUE1ES0N5STJSdFBGUzgwYi92UTR2UWh6?=
 =?utf-8?B?cER2S1NadFUxeUxvZk9hY1dyK1ZManhPSWZXSSszS0ZCMnN6U0FaT0ljWEJI?=
 =?utf-8?B?dG4rUVMzQjJZeUYrRVhhL092R3IwU0d1ZDE0cDRYOEplRW9HMEg0OGJ3amZ0?=
 =?utf-8?B?UGltMldTZGNhZkdOT3BoZFpRaTE0aTQyYW42Z25wd3RHRFpqVHZlR2djSzls?=
 =?utf-8?B?amZQeGlLMjcya3RsR09CZ0w1bjkxODk5Z1dtVk13UEptc29WblpkODhtT1My?=
 =?utf-8?B?akdaWExGNTZ5L3gwb1FiVWF4Z3dRNkVYUGxROElJMjNNbDliNFNiOW81YUx6?=
 =?utf-8?B?eDRPbitnb0tjbnpxUGlyOVdNM0FiaC9nYi8xeHg5WDE4YXpVbWk1ekxDalBq?=
 =?utf-8?B?cHFGbXEwaEQzM1MwTjljMWpkeGVLN3N1RGpMKzRlR0ZLVlhScGhueG1kQlpN?=
 =?utf-8?B?Z0Z0UTV4blNqbVdpWHEvY2xGWDJkTkd5dHVUVzdudmUyc243dys4NG56UzNk?=
 =?utf-8?B?WklpeHBpZHhqUWEvOE8rbUV2YWRRNnpoWkpPSCszWVRGeHl3aW1vWlBFa29V?=
 =?utf-8?B?WWQzUk5EZzFCVXQweGFvbVo3bHhwSVBQallOdTBIMFpHSDZTOXhRSkxobzZ0?=
 =?utf-8?B?MGlMaHprbWFKNGx1RGYxWk8za0ZMOW1PLzYrbkZmTWdWTHg0SEFOdm9haXZC?=
 =?utf-8?B?YUFVcGE4TEVvWFZ5emFtM1JTbUtZcWNGMW5GZjRZQ3Awa1hsSlZoK0FFZysw?=
 =?utf-8?B?T0h3Q21FTkw1SWthVmZqcEcwM1RjRkRMeU1URzFaTThZNEFlOHdBVThWaHJ6?=
 =?utf-8?B?NHYzNXFsUkg1a3F0SktIZnJCNFlIc0VRWENHRXhWTTRiQkkrUS9GRy83QzhC?=
 =?utf-8?B?UllVMkwwa2hZaXdkVjU0R1ZncVhQWFZHdFB3VU1RTjlySW4yNERlRE5GcHN0?=
 =?utf-8?B?QUVqRUllTlpMeThPVXBSaW9ydGxQYXZDcm0yQ283TE5uTmtoK3Y4QkM0OXhF?=
 =?utf-8?B?UXJ5V0hOYi9MTXoxK2phalRLMlBpTGRqb1ZEaU4yMHRKMWxndzdiOUZjUFQx?=
 =?utf-8?B?QndFU3ZOT0xWNVc4ZmRBZFo5b2hMWDQybmVyaC9LQUFpY04wSGhNUmljQTBY?=
 =?utf-8?B?c2piUXgxYnQ0bHVSODZLakdOOWp6RlRqL1VkVktJMVZqR3dsMmhiSGY2ZnNR?=
 =?utf-8?Q?Ndp0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2205f4d2-8192-4f64-eb92-08dc59cfae1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 02:32:49.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPmtdoMuPgiFVxh9r3miIKiznllVWkvAuloO4ugMeIHrBT4VripyTdWS8oZ34AE0VzTp5+Rv+SgxBFy4Q5KosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

SGkgU3JpZGhhciwNCg0KPiBGcm9tOiBTYW11ZHJhbGEsIFNyaWRoYXIgPHNyaWRoYXIuc2FtdWRy
YWxhQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDExLCAyMDI0IDQ6NTMgQU0N
Cj4gDQo+IA0KPiBPbiA0LzEwLzIwMjQgNjo1OCBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+
IERldmljZXMgc2VuZCBldmVudCBub3RpZmljYXRpb25zIGZvciB0aGUgSU8gcXVldWVzLCBzdWNo
IGFzIHR4IGFuZCByeA0KPiA+IHF1ZXVlcywgdGhyb3VnaCBldmVudCBxdWV1ZXMuDQo+ID4NCj4g
PiBFbmFibGUgYSBwcml2aWxlZ2VkIG93bmVyLCBzdWNoIGFzIGEgaHlwZXJ2aXNvciBQRiwgdG8g
c2V0IHRoZSBudW1iZXINCj4gPiBvZiBJTyBldmVudCBxdWV1ZXMgZm9yIHRoZSBWRiBhbmQgU0Yg
ZHVyaW5nIHRoZSBwcm92aXNpb25pbmcgc3RhZ2UuDQo+IA0KPiBIb3cgZG8geW91IHByb3Zpc2lv
biB0eC9yeCBxdWV1ZXMgZm9yIFZGcyAmIFNGcz8NCj4gRG9uJ3QgeW91IG5lZWQgc2ltaWxhciBt
ZWNoYW5pc20gdG8gc2V0dXAgbWF4IHR4L3J4IHF1ZXVlcyB0b28/DQoNCkN1cnJlbnRseSB3ZSBk
b27igJl0LiBUaGV5IGFyZSBkZXJpdmVkIGZyb20gdGhlIElPIGV2ZW50IHF1ZXVlcy4NCkFzIHlv
dSBrbm93LCBzb21ldGltZXMgbW9yZSB0eHFzIHRoYW4gSU8gZXZlbnQgcXVldWVzIG5lZWRlZCBm
b3IgWERQLCB0aW1lc3RhbXAsIG11bHRpcGxlIFRDcy4NCklmIG5lZWRlZCwgcHJvYmFibHkgYWRk
aXRpb25hbCBrbm9iIGZvciB0eHEsIHJ4cSBjYW4gYmUgYWRkZWQgdG8gcmVzdHJpY3QgZGV2aWNl
IHJlc291cmNlcy4NCg0KPiANCj4gDQo+ID4NCj4gPiBleGFtcGxlOg0KPiA+IEdldCBtYXhpbXVt
IElPIGV2ZW50IHF1ZXVlcyBvZiB0aGUgVkYgZGV2aWNlOjoNCj4gPg0KPiA+ICAgICQgZGV2bGlu
ayBwb3J0IHNob3cgcGNpLzAwMDA6MDY6MDAuMC8yDQo+ID4gICAgcGNpLzAwMDA6MDY6MDAuMC8y
OiB0eXBlIGV0aCBuZXRkZXYgZW5wNnMwcGYwdmYxIGZsYXZvdXIgcGNpdmYgcGZudW0gMA0KPiB2
Zm51bSAxDQo+ID4gICAgICAgIGZ1bmN0aW9uOg0KPiA+ICAgICAgICAgICAgaHdfYWRkciAwMDow
MDowMDowMDowMDowMCBpcHNlY19wYWNrZXQgZGlzYWJsZWQgbWF4X2lvX2Vxcw0KPiA+IDEwDQo+
ID4NCj4gPiBTZXQgbWF4aW11bSBJTyBldmVudCBxdWV1ZXMgb2YgdGhlIFZGIGRldmljZTo6DQo+
ID4NCj4gPiAgICAkIGRldmxpbmsgcG9ydCBmdW5jdGlvbiBzZXQgcGNpLzAwMDA6MDY6MDAuMC8y
IG1heF9pb19lcXMgMzINCj4gPg0KPiA+ICAgICQgZGV2bGluayBwb3J0IHNob3cgcGNpLzAwMDA6
MDY6MDAuMC8yDQo+ID4gICAgcGNpLzAwMDA6MDY6MDAuMC8yOiB0eXBlIGV0aCBuZXRkZXYgZW5w
NnMwcGYwdmYxIGZsYXZvdXIgcGNpdmYgcGZudW0gMA0KPiB2Zm51bSAxDQo+ID4gICAgICAgIGZ1
bmN0aW9uOg0KPiA+ICAgICAgICAgICAgaHdfYWRkciAwMDowMDowMDowMDowMDowMCBpcHNlY19w
YWNrZXQgZGlzYWJsZWQgbWF4X2lvX2Vxcw0KPiA+IDMyDQo+ID4NCj4gPiBwYXRjaCBzdW1tYXJ5
Og0KPiA+IHBhdGNoLTEgdXBkYXRlcyBkZXZsaW5rIHVhcGkNCj4gPiBwYXRjaC0yIGFkZHMgcHJp
bnQsIGdldCBhbmQgc2V0IHJvdXRpbmVzIGZvciBtYXhfaW9fZXFzIGZpZWxkDQo+ID4NCj4gPiBj
aGFuZ2Vsb2c6DQo+ID4gdjEtPnYyOg0KPiA+IC0gYWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gSmly
aQ0KPiA+IC0gdXBkYXRlZCBtYW4gcGFnZSBmb3IgdGhlIG5ldyBwYXJhbWV0ZXINCj4gPiAtIGNv
cnJlY3RlZCBwcmludCB0byBub3QgaGF2ZSBFUXMgdmFsdWUgYXMgb3B0aW9uYWwNCj4gPiAtIHJl
cGxhY2VkICd2YWx1ZScgd2l0aCAnRVFzJw0KPiA+DQo+ID4gUGFyYXYgUGFuZGl0ICgyKToNCj4g
PiAgICB1YXBpOiBVcGRhdGUgZGV2bGluayBrZXJuZWwgaGVhZGVycw0KPiA+ICAgIGRldmxpbms6
IFN1cHBvcnQgc2V0dGluZyBtYXhfaW9fZXFzDQo+ID4NCj4gPiAgIGRldmxpbmsvZGV2bGluay5j
ICAgICAgICAgICAgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgaW5j
bHVkZS91YXBpL2xpbnV4L2RldmxpbmsuaCB8ICAxICsNCj4gPiAgIG1hbi9tYW44L2Rldmxpbmst
cG9ydC44ICAgICAgfCAxMiArKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDEg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo=

