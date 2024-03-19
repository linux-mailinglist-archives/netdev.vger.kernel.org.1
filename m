Return-Path: <netdev+bounces-80512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5887F7BA
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 07:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79D41F21850
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 06:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238814F898;
	Tue, 19 Mar 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbR0hdYc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC794438A;
	Tue, 19 Mar 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830831; cv=fail; b=u3WV5mIdKdVshJXRnOpfzze5oJgRd0cRmIo6aIEdpQSmrkingdUMiNIirO+LDCvw0F7A9c1FONyavjNAOSiuQcdPYeKSbxJOwUX5CCBhAulk6OWUYptOqtdMcncr4Rar/kboScP0YSfl8OYjxp6JposFpPrk6qOFXdeggyxdd40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830831; c=relaxed/simple;
	bh=yL9KfEFtBimDrqK6UzWrNNPSyQNQi8LNbenaB0PsqrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c+PyV5SFrwhq2I7CxVZi3YbjI63jGuUbXnPqgui2NeL+qd9guTGnng70+vjj38RpmsTO29Q8k9bud9EqXJtISrReYm/h4/2Ti7EaCazPs5Z/MvP31EJHes+aBSEEjpn9pEGT2Bn1x56be6Kgfba8QL29QPsUgGtiLNwuMjP97UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbR0hdYc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710830829; x=1742366829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yL9KfEFtBimDrqK6UzWrNNPSyQNQi8LNbenaB0PsqrI=;
  b=QbR0hdYckUHz+XNhUAv7t+NvoZC35G/xu+qB4zI8s2D1w4TILWZquiLN
   JlhMqyQbAa9DXSaj1GmfI12EidJlFrbXT8OJTcfl3uzUjNTYEVE9aapE1
   h0HM49nZwCs+gkGjbfgp6Y+DLybKmc7L22O8UR2rkAqU3OPopo8KuYqiC
   QIyfamqsCIUl9RTusFVApSEPOFjMo9WBf8buGHitWeZ4jkD1oGOAZNmEb
   b/+hWR9J+hVk9nDZcIePc9w0j9UKu0V2cBhloMIG3XeW+CZPbcQIy+6wd
   yOswgkG//awQym7xnpweryGTCcXULPURBzRPfzigTOY+0H25L+8GbyyNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16222532"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="16222532"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="13745223"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 23:47:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:47:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:47:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBIPsaBfx8o3e0QqYvGn3GLaOZJ8LjBSXxRUaZVc1U01H6PLMYhh3oRZvRwWF9GYvkOXF5UebslBWCq0QYr7TjaFubczDfXvB3EckmxRJLUQilsTvQ//ikVs2P3twfNEaqOvn5PXXNBFgpOW82zGbUPa/8184znOK0RPi5KqULrvrfZ7VlgZ8ab+vNPshan+2jFducd+Fz1/vnLhEI6yjmCzoZFevq7qavXHHAvPPsbteXteeUsfvVsa7DvO2HHs18E1ryohF0+nLXVXOlVI2N+2V4sJUVSFaPnvLBj8isnyIugiDms1AXjRozsjl0fCPLGoXmENPCVgIWTogI3kJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL9KfEFtBimDrqK6UzWrNNPSyQNQi8LNbenaB0PsqrI=;
 b=R0O6fzOgCS0jnhOx1gz6AOO/hecWdrkEDVxKOGVMfwfFjyn9rae7YDtWBg0aihTNl2RT0Qmqzyw/iY3Wta5+IQO9slx1O0Qqt/MYKPQ5WOcYG+xWsi/McrvW8bH6S3SdMnJAB8tCevuf+DJA3drOZ3crKoGsu2KKDtMZ0fcq4zt9on64ehWYJ37/FKfuUZyM4xksL9t83A/34PeLPZAZeNpqRvBxJo/DWM8zbsbHc+fHOC9pj3Uf/Fa9E9ZHtnc/UZGcmyvsZArGDCWqZcqfY2mFbeF4uQ7N7vv7q5SCQiI5N+0D/G4Lw++Yb7qWuPO39CdHS+yDuzY+mdlGdga7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) by
 MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.12; Tue, 19 Mar 2024 06:47:00 +0000
Received: from DM4PR11MB6526.namprd11.prod.outlook.com
 ([fe80::18b2:7397:cbff:b3e1]) by DM4PR11MB6526.namprd11.prod.outlook.com
 ([fe80::18b2:7397:cbff:b3e1%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:47:00 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next 3/6] selftests/xsk: implement get_hw_ring_size
 function to retrieve current and max interface size
Thread-Topic: [PATCH bpf-next 3/6] selftests/xsk: implement get_hw_ring_size
 function to retrieve current and max interface size
Thread-Index: AQHaduRlSA8pvuDau0ezB8Neq+bHtLE5EgqAgAWR9NA=
Date: Tue, 19 Mar 2024 06:47:00 +0000
Message-ID: <DM4PR11MB652630E5B9B56532FA0121EC8F2C2@DM4PR11MB6526.namprd11.prod.outlook.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
 <20240315140726.22291-4-tushar.vyavahare@intel.com>
 <ZfSIH07rCk3mjjWc@google.com>
In-Reply-To: <ZfSIH07rCk3mjjWc@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6526:EE_|MN0PR11MB6088:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MuQ0wC5str+Up0f+Axv6HA8qCgxsI/vmhcdv5aBZe9317nQfhGxLEKOJ32MYaKwsUsSCSuxU/O0XX1HKqRXBz2gGpnFjpcf9uQjH25Vdave+VaODtDym9zu1r/vNotuMK98u6OAoFl2aw9kM+PB9Q90+eASJCf5+fKIXcrAkcR8GMetacgYvY4f3h72akuYrgEy21NBO+UOUuYfnSABg3YyMbX5+xTBjEd1FLMee009qVKKi31B+OI1q9y1w72LsrXgz0PpK0L3vW1aN8IlZINjvfsOs8MBqVH0CzToYzkUc4JfMCmxr6aRDM3PPciDKBrlnY9ysJrh/LnGrgLsoR9EhqX6VVwrVEU8Gufzemrfb+CWUpxbFf4xVQpPam5bWmk8ngi3w9xhofqZuWhrsf/g93N797niqajLrnHC3x1WiHzyk1lgzADfl/ogg3AEHP06+SmXkVRRM/K/PGje/XGQOdw2CB2Gynq+GKf0UpioZ+JNw/FIph5lTNn/uXD1LquJ/H6IjO3CbUNyN34Si1NzHJ66FRdi9Txl9ZEkv/dlmhXV+S/z5W+QHkbPEVpBzh3hP08f9hiO+JWLHYdeeazlV9yueBni03fhg152Lix8qEKfpPe5aZNOOlajK7usb6YaimxkdTAx3ZFklUD3uaSV6BtlezjK4MZ15Odg5tn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDIyUWVmSk1lRG9ZK0FDZGxqUUN3bG9NbHVOVDZwdWErQTdkNU1SYk1ndURV?=
 =?utf-8?B?SkFnYjlEdXBIWklNU0NOWDF5VnNNSUhPSHNZd2pIaXhtN0VsUTBwUHVyblln?=
 =?utf-8?B?Q0FyMGZrNEZEY1VlS0cvbkpmbUpwcVhhbWFyQ1p3NGZsVmxZTmJ6dW1JMVBh?=
 =?utf-8?B?U2sxMkRmU2tyVTlPWlR1MStKRThOaTEwVENEWlVJNGpnVEoxN3BEN1d4QlN2?=
 =?utf-8?B?MG5VeXZKUWJSVDUwaVNLbUNlUlhHZDk1S2YrM1JFL0ZyMThWa2dTMFlDR3VZ?=
 =?utf-8?B?di9ueU1uanErZHJabG9JdHVRQVB6RTNkV1VsL05LenNVaFd1bTBHOTk3Z01j?=
 =?utf-8?B?eENxeXF2UCtkUzFQdVdWVndKRnFJUG5oUWRYQkxWKyszYzV4cmFkeURVTVBG?=
 =?utf-8?B?NWZ4b2hueU1vUVczRGIrcTJrVldVdFh0cnZCSXIxS2JmSzhkdDd5UUtpN3FC?=
 =?utf-8?B?d2FyenBaclkweDJzOXBMdmROWnFZd1Y0OTZVTm1qdjVxOFNGMXpDVEtMbmpZ?=
 =?utf-8?B?THc2Vno5NG1CekI1aS85NktaK2dTcEwvV2hTdUl4dTRMUTFnck1CMFczR0xS?=
 =?utf-8?B?b0FIZ1oySmRZbWx5ZWEzSEdqZnNkNkdERU01SnM3ODEwei8rNHJwQVdGTzZC?=
 =?utf-8?B?YmJrSkNqSFF5V2JPOUhkZFhwWGFHVWJjN3VjanczL3Y1TGZNT3pVR0xEVzFq?=
 =?utf-8?B?UzN6OGxtSUFNSGRjNFllamUzSlZXOHpJZ01sRE1QQkkwMFh3Y0xvTUhYMEd4?=
 =?utf-8?B?aDQwam01ZFQxcFBmS3BLUUVmSWZCYkRLS0ZBR0hnNTI0djFoRUYxMEhWdlhz?=
 =?utf-8?B?UW03bHlITXI0dmhlUThBREFWQUZ5K24yUGhPaGpPVUE3b2dId3pQZkpvUjJ2?=
 =?utf-8?B?SkoxUVBYYlpQTlFudmRZNGtjQmd1RkE2UjNWSEFrNDRxdmRFblF4M0RpWStG?=
 =?utf-8?B?NTMzaGlTZFdLOGtDTEl6WHByNGNpNnVUMzFLaXpzeW5LNEZDKyswNEhROGh0?=
 =?utf-8?B?MVlObVRBdjlPYkNwQ1JHODN1UDcreVdxWlBWaVRqNU5oZjUwWU96YkF4UllV?=
 =?utf-8?B?NE5lZzdNbE5TVnQycllWQkkzd2VIWFQ2dDNqSjQyTDVoY2QwZm9qbDN1M2lq?=
 =?utf-8?B?VWhVcGtMRk9EaFp5eWdUa0I0MDNUVWJJTGRybjMycFU3WGE2U0h0TTRTeFhF?=
 =?utf-8?B?VTRqTTA1Z0VpT3hqMkgwNkVxZjlyZWtSZE4rcWQyOGNwKzhkM2FtSzl1R21R?=
 =?utf-8?B?SENVRjd1Zm1TWHR2NU5CcTJ0WUpLalNpL0paR2ZVWFdFb0NxdmVwYjBrV1hK?=
 =?utf-8?B?Q0swb0h3VmJWWUliaDJKcTEzQ0JGTzhuYjcvN054SWFtZlNSZXRVQ0h4WjFS?=
 =?utf-8?B?dndUMThFS1BCSEFGL2pqR2tmN1drYkVzUlJLWTh2MDBnMUFvdmxyNXppQzZx?=
 =?utf-8?B?UG8yMzVZa1lyN2dxbFZWSm9UYWlMOHJqdW9ha2dpTk9QTHlzcXZ6L3N4SWJN?=
 =?utf-8?B?Vmw3VTZXdnY0bHBGWE9ZRjYvbGZPZFZXUnZuRi93MXAzdUYya3VKeUgvLy8r?=
 =?utf-8?B?SnJlN0N5bW5XbitXVDlCR3gzWkc5TURveDJVbXZSVzJrcWpuc0Rjem05UWgx?=
 =?utf-8?B?YVNoRmo2eGZuZW8xWThiYjZpVWdqMjBXZUtYUHZ4TWR4cnd0anNQbmJsMTNG?=
 =?utf-8?B?d2M3QksxWDJRQjJnQ3drU2N2N3JzMG5KOWZpTGI5ZWVaUDNvUVl5KzU0M05l?=
 =?utf-8?B?cFN2M0hUUHhUWmlrQjlOR2REaDhUQUhCdWhRMHk1d1c3S1JQQUlocHR2Rkxv?=
 =?utf-8?B?V3RsMXJqM3ZtdTVGY2JEYkNKdTBNenNWRzNPNS9oRzhTK3dOdlFIL0gyRWFE?=
 =?utf-8?B?czJJKzM3V2pNTU9NK2Y3RUhLaENuZGRYRTljTTdWZHJ0cFIzMDZGN3Rad2tw?=
 =?utf-8?B?bDBGUStkV3BrOGNBZWl0V09DNDh6ZEFKNjhvMU04SkpiVHVKNGQ0L01hOWRj?=
 =?utf-8?B?QkswTTBMRldLcVA5QVVzcEFBQTZ1dW1zTXczMzdtUHg1NFJIM3lKMEU4bmVt?=
 =?utf-8?B?bS8zdTJSbHpjS0NvN1h5RGJjWldGdEZaZzJTb1NVaGZVWHdHb0NpRG1rb0pa?=
 =?utf-8?B?TkJFWC9uU3RRc2pjWTJVQ0tsdExNbWdnQTVjeDkyWjErUGFvSXcyZWlHcEh1?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4bcc46-c586-4106-6c4f-08dc47e060ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:47:00.0665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQ89a86t087j1jmhH3UjAFMwidWxHso1fGwXG1cO/aDAEqmL9Lh8kDQ4Ul8lf9KrIde0iAn4CIFc6stNYJLkwK72siq31RgNBnvtU4cNxdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzZGZAZ29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxNSwgMjAyNCAxMTox
MSBQTQ0KPiBUbzogVnlhdmFoYXJlLCBUdXNoYXIgPHR1c2hhci52eWF2YWhhcmVAaW50ZWwuY29t
Pg0KPiBDYzogYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYmpv
cm5Aa2VybmVsLm9yZzsgS2FybHNzb24sDQo+IE1hZ251cyA8bWFnbnVzLmthcmxzc29uQGludGVs
LmNvbT47IEZpamFsa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5j
b20+OyBqb25hdGhhbi5sZW1vbkBnbWFpbC5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1
YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFzdEBrZXJuZWwub3JnOyBkYW5p
ZWxAaW9nZWFyYm94Lm5ldDsgU2Fya2FyLCBUaXJ0aGVuZHUNCj4gPHRpcnRoZW5kdS5zYXJrYXJA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGJwZi1uZXh0IDMvNl0gc2VsZnRlc3Rz
L3hzazogaW1wbGVtZW50IGdldF9od19yaW5nX3NpemUNCj4gZnVuY3Rpb24gdG8gcmV0cmlldmUg
Y3VycmVudCBhbmQgbWF4IGludGVyZmFjZSBzaXplDQo+IA0KPiBPbiAwMy8xNSwgVHVzaGFyIFZ5
YXZhaGFyZSB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgYSBuZXcgZnVuY3Rpb24gY2FsbGVkIGdldF9o
d19zaXplIHRoYXQgcmV0cmlldmVzIGJvdGggdGhlDQo+ID4gY3VycmVudCBhbmQgbWF4aW11bSBz
aXplIG9mIHRoZSBpbnRlcmZhY2UgYW5kIHN0b3JlcyB0aGlzIGluZm9ybWF0aW9uDQo+ID4gaW4g
dGhlICdod19yaW5nJyBzdHJ1Y3R1cmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUdXNoYXIg
VnlhdmFoYXJlIDx0dXNoYXIudnlhdmFoYXJlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuYyB8IDMyDQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5o
IHwNCj4gPiA4ICsrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNl
aXZlci5jDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5jDQo+
ID4gaW5kZXggZWFhMTAyYzgwOThiLi4zMjAwNWJmYjljOWYgMTAwNjQ0DQo+ID4gLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi94c2t4Y2VpdmVyLmMNCj4gPiBAQCAtODEsNiArODEsOCBAQA0K
PiA+ICAjaW5jbHVkZSA8bGludXgvbW1hbi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbmV0ZGV2
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9iaXRtYXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L3NvY2tpb3MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2V0aHRvb2wuaD4NCj4gPiAgI2luY2x1
ZGUgPGFycGEvaW5ldC5oPg0KPiA+ICAjaW5jbHVkZSA8bmV0L2lmLmg+DQo+ID4gICNpbmNsdWRl
IDxsb2NhbGUuaD4NCj4gPiBAQCAtOTUsNiArOTcsNyBAQA0KPiA+ICAjaW5jbHVkZSA8c3lzL3Nv
Y2tldC5oPg0KPiA+ICAjaW5jbHVkZSA8c3lzL3RpbWUuaD4NCj4gPiAgI2luY2x1ZGUgPHN5cy90
eXBlcy5oPg0KPiA+ICsjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ID4gICNpbmNsdWRlIDx1bmlz
dGQuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAieHNrX3hkcF9wcm9ncy5za2VsLmgiDQo+ID4gQEAg
LTQwOSw2ICs0MTIsMzUgQEAgc3RhdGljIHZvaWQgcGFyc2VfY29tbWFuZF9saW5lKHN0cnVjdCBp
Zm9iamVjdA0KPiAqaWZvYmpfdHgsIHN0cnVjdCBpZm9iamVjdCAqaWZvYmoNCj4gPiAgCX0NCj4g
PiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgZ2V0X2h3X3Jpbmdfc2l6ZShzdHJ1Y3QgaWZvYmpl
Y3QgKmlmb2JqKSB7DQo+ID4gKwlzdHJ1Y3QgZXRodG9vbF9yaW5ncGFyYW0gcmluZ19wYXJhbSA9
IHswfTsNCj4gPiArCXN0cnVjdCBpZnJlcSBpZnIgPSB7MH07DQo+ID4gKwlpbnQgc29ja2ZkOw0K
PiA+ICsNCj4gPiArCXNvY2tmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsNCj4g
PiArCWlmIChzb2NrZmQgPCAwKQ0KPiA+ICsJCXJldHVybiBlcnJubzsNCj4gPiArDQo+ID4gKwlt
ZW1jcHkoaWZyLmlmcl9uYW1lLCBpZm9iai0+aWZuYW1lLCBzaXplb2YoaWZyLmlmcl9uYW1lKSk7
DQo+ID4gKw0KPiA+ICsJcmluZ19wYXJhbS5jbWQgPSBFVEhUT09MX0dSSU5HUEFSQU07DQo+ID4g
KwlpZnIuaWZyX2RhdGEgPSAoY2hhciAqKSZyaW5nX3BhcmFtOw0KPiA+ICsNCj4gPiArCWlmIChp
b2N0bChzb2NrZmQsIFNJT0NFVEhUT09MLCAmaWZyKSA8IDApIHsNCj4gPiArCQljbG9zZShzb2Nr
ZmQpOw0KPiA+ICsJCXJldHVybiBlcnJubzsNCj4gDQo+IGNsb3NlKHNvY2tmZCkgY2FuIHBvdGVu
dGlhbGx5IG92ZXJyaWRlIHRoZSBlcnJuby4gQWxzbywgcmV0dXJuIC1lcnJubyB0byBtYXRjaA0K
PiB0aGUgb3RoZXIgY2FzZXMgd2hlcmUgZXJyb3JzIGFyZSA8IDAuDQo+IA0KDQpJIHdpbGwgZG8g
aXQuDQoNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZm9iai0+cmluZy5kZWZhdWx0X3R4ID0gcmlu
Z19wYXJhbS50eF9wZW5kaW5nOw0KPiA+ICsJaWZvYmotPnJpbmcuZGVmYXVsdF9yeCA9IHJpbmdf
cGFyYW0ucnhfcGVuZGluZzsNCj4gPiArCWlmb2JqLT5yaW5nLm1heF90eCA9IHJpbmdfcGFyYW0u
dHhfbWF4X3BlbmRpbmc7DQo+ID4gKwlpZm9iai0+cmluZy5tYXhfcnggPSByaW5nX3BhcmFtLnJ4
X21heF9wZW5kaW5nOw0KPiA+ICsNCj4gPiArCWNsb3NlKHNvY2tmZCk7DQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgX190ZXN0X3NwZWNfaW5pdChzdHJ1
Y3QgdGVzdF9zcGVjICp0ZXN0LCBzdHJ1Y3QgaWZvYmplY3QgKmlmb2JqX3R4LA0KPiA+ICAJCQkg
ICAgIHN0cnVjdCBpZm9iamVjdCAqaWZvYmpfcngpDQo+ID4gIHsNCj4gPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuaA0KPiA+IGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuaA0KPiA+IGluZGV4IDQyNTMwNGU1MmYzNS4u
NGY1OGI3MGZhNzgxIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi94c2t4Y2VpdmVyLmgNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNr
eGNlaXZlci5oDQo+ID4gQEAgLTExNCw2ICsxMTQsMTMgQEAgc3RydWN0IHBrdF9zdHJlYW0gew0K
PiA+ICAJYm9vbCB2ZXJiYXRpbTsNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdHJ1Y3QgaHdfcmluZyB7
DQo+ID4gKwl1MzIgZGVmYXVsdF90eDsNCj4gPiArCXUzMiBkZWZhdWx0X3J4Ow0KPiA+ICsJdTMy
IG1heF90eDsNCj4gPiArCXUzMiBtYXhfcng7DQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdHJ1Y3Qg
aWZvYmplY3Q7DQo+ID4gIHN0cnVjdCB0ZXN0X3NwZWM7DQo+ID4gIHR5cGVkZWYgaW50ICgqdmFs
aWRhdGlvbl9mdW5jX3QpKHN0cnVjdCBpZm9iamVjdCAqaWZvYmopOyBAQCAtMTMwLDYNCj4gPiAr
MTM3LDcgQEAgc3RydWN0IGlmb2JqZWN0IHsNCj4gPiAgCXN0cnVjdCB4c2tfeGRwX3Byb2dzICp4
ZHBfcHJvZ3M7DQo+ID4gIAlzdHJ1Y3QgYnBmX21hcCAqeHNrbWFwOw0KPiA+ICAJc3RydWN0IGJw
Zl9wcm9ncmFtICp4ZHBfcHJvZzsNCj4gPiArCXN0cnVjdCBod19yaW5nIHJpbmc7DQo+IA0KPiBB
bnkgcmVhc29uIG5vdCB0byBzdG9yZSBldGh0b29sX3JpbmdwYXJhbSBkaXJlY3RseSBoZXJlPyBO
byBuZWVkIHRvDQo+IGludHJvZHVjZSBuZXcgaHdfcmluZy4NCg0KSSB3aWxsIHVzZSBldGh0b29s
X3JpbmdwYXJhbSBkaXJlY3RseSBmb3IgZ2V0X2h3X3Jpbmdfc2l6ZSgpLg0K

