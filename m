Return-Path: <netdev+bounces-80514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C587F7CE
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 07:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35BA1C21903
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711750A68;
	Tue, 19 Mar 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWhQEyLA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CA4438A;
	Tue, 19 Mar 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831279; cv=fail; b=bfATU+qSHrHi4XOBcQNeAlEBhs/eCEO2FPI9ffVOp+CescO5BpKkI7LWX91wbb1rZHE8hIPhPtRlwCHiTt+9mIag1BaRaAeih0UsUGqe9fY8O07eq/j5YMe6nORPbKEti5Wl7JptXFTrU55hLP3MuvxGbSZWmQacY+9tC3yxd3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831279; c=relaxed/simple;
	bh=LQdtK/nUkiPz7fb5Cw0R6p8RFv2oMwnNPGwSulyPsLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXcdla+BSS93wwnYi8caRK0QDCBaxKDBaocp3712M/mQRwIBfI8UKktPCfs0ZjaY5ud+zGJ8YNS6Z5Lt66i3Umu9fw5ULMkEKQVWpTfBRggQX/jM1/41ZelKFeSIwhjMkgAFCwnkHZTalFayNVa/510++bdMIWVAfYZ6bV5RZ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWhQEyLA; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710831278; x=1742367278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LQdtK/nUkiPz7fb5Cw0R6p8RFv2oMwnNPGwSulyPsLc=;
  b=aWhQEyLAnmgC3AckMGOL29vNqIkbDfoeeNr45ZN10HdyzHQ5TJe6KpzA
   b8zZae9LWm4+a+acyjTfz6KDwwhiB/16c4iSzEfoadkJXknm9jqxcqQi5
   rhEd607oSt7FOmtYmVT5sOBG3Sc4sNg3f9dSsiDzvLD2GbleZl2VbqZdI
   z+MIFjxY3z6Cbfp0QxqR9zEz0h9T7mfjcUFkASzis10/A7DViiEVQZZQD
   4JNSoXZzlzFUQm5kJOVpPONquUhKzb19G/HZisAblIY6QdD3a0XyPvg2J
   /ZGjTRolAkL49hTrJTDg4TO9631wPbDr/V+gzPy7PtukJkTsu7wdi0MGT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="8623363"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="8623363"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="44780463"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 23:54:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:54:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:54:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8Ni0n0xns5OPOHfa37ecdddBJUYHwaVfCHiZMOznZfeNoyi9PwxMiOoUMMlBd+MgytzntjEz/Lax3kDtdc6qgZW2g2foMLBe7gLEelp+tcrlMtXvOD88P9gsm+kOH0XIJyj9pjHBtBHeQzR6rbcnAZabnqBr3nmXgbVwYptQx4BXRT32h+QQlrUlrGdM/uZ5d3Fox9ZT+HNHKzEIcdw25Ni0u9aUtgdlRmkvYCheXZ4Zri8DuJH5YzXOKWXT1t3DxQIgIk2LMbL19xrJz7Ao+9iVTAIJD4XsAs3a5KfBj57icKraiyP8fuM7OxDzilX3/0a2D4Tp10RDR5V5hDHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQdtK/nUkiPz7fb5Cw0R6p8RFv2oMwnNPGwSulyPsLc=;
 b=ThTfABvhhAn5faFay6xfnTnZd3oDfsOoVzTElpxqp9p+esYcd2EbIKYK77iz4Y38L1D/75oKnUv7SJtG6PLrssKD4GUB5E0bMs/e6cST3OgBe7PgbGXbCMRXw3yQB27iH13hwgV7gWSab4q5Tlnre0ZubmG9C1tRYdH0NwsvJrIXEC8ms4gKJW3KA6nC5j+V9vqLXX13Qzx0RJpMkpjvTsySTsTLLm6QfIJKzs8kAhkEM9hYN1qklu4bVM4OiKCnSX3hdFeEHe387MyiqdJy1xqhocTmK+7L23zju3KTA55AMtH3887J4vGSwQ8bjOyj2dxRkt0+fqbwseioHl9L8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 06:54:28 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8d5:f5fa:18e4:fd1]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8d5:f5fa:18e4:fd1%6]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:54:28 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Sarkar, Tirthendu"
	<tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size
 function to configure interface ring size
Thread-Topic: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size
 function to configure interface ring size
Thread-Index: AQHaduRmdUwk1meuFk68ui9MiNeTALE48oGAgAWzv4A=
Date: Tue, 19 Mar 2024 06:54:28 +0000
Message-ID: <IA1PR11MB65149E15E6CC2E0C8110B7E48F2C2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
 <20240315140726.22291-5-tushar.vyavahare@intel.com>
 <CAADnVQ+BxiKDC2HyztsoFdOLh8ECgnmG2UMH_+741CdBjDx0ZQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+BxiKDC2HyztsoFdOLh8ECgnmG2UMH_+741CdBjDx0ZQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SJ0PR11MB6791:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcodA4ILBNQqaiwCcomjns1FfmrxmvTWtQmlTlQHVGjExhlrbSbraAJ1Uf/eeYxs6h40zrda8Sc+Nus2ykn7rbZLKFOCQB56UvnBV7DScehTiv3lwi2MndDGARuVsbpdpFwe4gRuK2zgmSt4kM4dgGX6DNAPo41EjjQNcfhaOaqAP4GntCb14yqJz0TobrqJkdMzBag9W/NutUq8ezXfx8OXdR+xiHU61Jicpze+0QMNM8+eg5YyfrAVF8gdC39mb9Fr2G6K+t/D6tRwj0ooQ598Cdr0XROArt/Lx19fVMbsvGP34LpJUwnlP/lgh1ZOz9jf7yyhM2Wqi822geyHadaUJ8YETY/HeqquAcnApNEwIxdbp5wytACkJFqJDp3B22UWvejQ0JINlXexexu8ek9h8U2+4NCLq9Iz526J+2OyvQ9hNj0EB8/lYSj0Enn4OAaufaCQ/mHU7FiI/iQ1MUAcCoDQiK/WUIzGryOuvcRoXTYKYVKEd3KipqX46EysvY3mzubq5XRMEdY2e7LxBEppI4300AV+8K/FmZ2ty3w+nFvsqRgrfAqK7wy3QnZWc/Tv/CuzjBtC6+QFComczAHkCW6s2VAHlg5xSCQK/uvmoRJcj3SIpzdXt1iB+ba4JohZmWUXurweDh40VQnDBBUxNZg1IsLO5g0ufLvAtnY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWdlWnlwcmsza0FidU05ZnBYeFpHN3lLd2N5RTFwUWdpUEpPMlNITnJRTWsy?=
 =?utf-8?B?ZzE2NU9yM3djdnNQZzFSOU12cG9KMWFBQmt5bjY4bzJEQ01HZy92YVFQY2Q0?=
 =?utf-8?B?dm1Bd050alFJUHJkVkxZTkI5cm94UnFWZUUvUUkyRGJlVFZoeUVEQW12eUQ3?=
 =?utf-8?B?MHpKVi9KOXZ5aEZoWndUTHl4cGppTmFVTXVGU096aGNhWlV5VEd1Q3RjK2ZC?=
 =?utf-8?B?cDBFb2FjVXFaYXY3N0lnQ3hrVU9zdUdIZmZPanhZck8va2JHSEQrQzJ1dCtG?=
 =?utf-8?B?SzRVY2k3UDFub3ZkZzh2c005Ui94QWU1cmZPNE9qQTFmaHVmQTg2citteDdP?=
 =?utf-8?B?UlpIN2gvL3hLVWVnbFErZWQzTWlVeDdHZ3pWaFQxUnU1QmROYzE0aVFOL1pk?=
 =?utf-8?B?OStkdklhT0Y0amN6a0s0RzlWdXZVVG45azMwSVZnaEFCSEhkRXhJTDErOGlJ?=
 =?utf-8?B?RDc4UjBZMERmZm82bnNjNENTWXB3NmdYUk1wUXdFNlE1OHR2ejFrWFNWSXBR?=
 =?utf-8?B?WkgyelRTeEZsWEQvcnJneUlrWEk3RG1RRVlSK3pHcTRnS3lzYmtRRS9KREhL?=
 =?utf-8?B?K2NqTFh4TnhKNzNYeUFmbGR2a1RpQmVHdy94QlUrclN4TUw3Ykp3b1hDNTVO?=
 =?utf-8?B?MzRZVUdDOWxtWUQzT211VUJSVk00TjArc0NxMHZkWEJ2MmxjSEV0VTFNN0Z3?=
 =?utf-8?B?RnBqSVV1Zkh5cGg4Q1dUSkUzcWhiVzgzbzE1dlRCeGNXVzUzYmh1OWNOdG5E?=
 =?utf-8?B?K25Oc0RxNVVtWk16Z1VjdHRCTU9ERFRtN1FZNGdLWktSb29zQndLQk0xTWt0?=
 =?utf-8?B?MURSVmNDWWh2dXdDN2ZZblJodG9yU3dwY0FONGtzOGUrZ3I2WXI0S1gxL1ln?=
 =?utf-8?B?ZUpkRHJ5Q3hpZ0Y3QkljaUZZZ2JGUDNxY0JUUzYrak1wOTg3YUNVU0ZsV01I?=
 =?utf-8?B?Zk5yQzI2anJwdFV3cTA1VHIwV2xEclVzTjllQ0JQN085MXd3ZnRnTVYvQy9n?=
 =?utf-8?B?ZDlSQ2UwaERhVit3bVJDMS9NNmVjU2FEazR2d3hOVmVWbTg3a3RPb0Fxbjcv?=
 =?utf-8?B?RWdzSjN3UjE5YTVMblJrbEQwZ1o4SE5pQ1M0TExDc24wSWJ0eGRGaWhVcmZv?=
 =?utf-8?B?ZldUYzNDR1YvL1Fwd3p3K1VLekE4eVRHbzFudUl1cGNlNmFjdm1QbEo4dXEz?=
 =?utf-8?B?UjN1Z1g0MHc0aUF6d1NmRVN1MlFYUWZHcUxvVWxpbjF1YXU1VEw4Z3hrejMv?=
 =?utf-8?B?NVY4NXI2bUhTcVFSeENIOHRCOU8zRFVoTmFnS3VWYXE1MzFIbzB5ZE04QnJG?=
 =?utf-8?B?c0t6OHRpNDM1cWExcTExc2lFTkJ5b0xTK29LU3UvSE1PWHkwcnB3ZDdFNDEr?=
 =?utf-8?B?a1JwM0pKNU1Bbk9MK2tOc0IwQUg3MGk3dmt4QnRiRDBvbGl2bTR0dFh3QVpu?=
 =?utf-8?B?dmVNTEpUK1ZYWmhKSmN5ejhQaUVzSkJpYVhSL3ZHeE9JVmNsS1UvdW9ub3FH?=
 =?utf-8?B?S2ptcjJMUUk0MS9MamtOT3BEdndSK0Z2WVplSjNET3QwZkpmNmtTNGY5alMr?=
 =?utf-8?B?UUpCVVMxUFBrcEpyL09ranl3U2pUSmNmSGYzVEMzZlBNQUJnTVJFTHRPYm4w?=
 =?utf-8?B?cTBBcWExZkowRWx0QmI2cUk2azVzY3hiWHR5N2VaaW9YUE1WQWpqTzhReFFI?=
 =?utf-8?B?LzNJNHJ5UURMdDRzc1E2Uk5mRHc0elBKa3AvUGxjdHFDZTFmeWtUNTEwNVR4?=
 =?utf-8?B?NG95YlhTMVlEYnordUI3eE9vZmNTRU13NVh0Z29yN3I0VzBJbkFHUjZjRldk?=
 =?utf-8?B?akVVRk13UWZ0cVU0TXQ1Vm1CL2MvQ1VPNEU3QzhpREczeGs3R2ZGWTlJLzds?=
 =?utf-8?B?eHMrUE5RdXRJaHU4Nzc3ajh1ZlpaQi8rQkRnQ1ZtQ094VVFQMXVDNmN6RG1t?=
 =?utf-8?B?YVA3T0t1WjRjWWVvZTdnbDhVWnZYRmxNQ0RxZ3VZelNwYWhvWlI5R2dKMm43?=
 =?utf-8?B?T01qUXo1enY5ZmlTbEw5RnJta2wyUmplQXcyWFBPZSt2SHErWXZQNVp5dTlF?=
 =?utf-8?B?QzNlK0w1MWhRVkVXVFpnMEhOUlduT3BvVU80TGlLNXdEeVRKR2lCTkhUcklP?=
 =?utf-8?B?dkdHN1ExNWtFTm9zNWREaGhETkxMakFreUxQS1NkRG11bDBESFdIa0NTK21X?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be367cd-329a-48bf-115f-08dc47e16bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:54:28.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrS/xEv6SWAasHYpJk1+9xEh+M3Xd2ZVDNUkFZYe5C5PFQSC9cR3YM9LrhyQG+ckRIYdIfEGhNWPnaTrFg5fK1xWf6Z2aPEJ6gpgUqVYF4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGVpIFN0YXJvdm9p
dG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNo
IDE1LCAyMDI0IDk6MTggUE0NCj4gVG86IFZ5YXZhaGFyZSwgVHVzaGFyIDx0dXNoYXIudnlhdmFo
YXJlQGludGVsLmNvbT4NCj4gQ2M6IGJwZiA8YnBmQHZnZXIua2VybmVsLm9yZz47IE5ldHdvcmsg
RGV2ZWxvcG1lbnQNCj4gPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBCasO2cm4gVMO2cGVsIDxi
am9ybkBrZXJuZWwub3JnPjsgS2FybHNzb24sIE1hZ251cw0KPiA8bWFnbnVzLmthcmxzc29uQGlu
dGVsLmNvbT47IEZpamFsa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5maWphbGtvd3NraUBpbnRl
bC5jb20+OyBKb25hdGhhbiBMZW1vbg0KPiA8am9uYXRoYW4ubGVtb25AZ21haWwuY29tPjsgRGF2
aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgSmFrdWINCj4gS2ljaW5za2kgPGt1
YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEFsZXhlaQ0K
PiBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBp
b2dlYXJib3gubmV0PjsNCj4gU2Fya2FyLCBUaXJ0aGVuZHUgPHRpcnRoZW5kdS5zYXJrYXJAaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGJwZi1uZXh0IDQvNl0gc2VsZnRlc3RzL3hz
azogaW1wbGVtZW50IHNldF9od19yaW5nX3NpemUNCj4gZnVuY3Rpb24gdG8gY29uZmlndXJlIGlu
dGVyZmFjZSByaW5nIHNpemUNCj4gDQo+IE9uIEZyaSwgTWFyIDE1LCAyMDI0IGF0IDc6MjPigK9B
TSBUdXNoYXIgVnlhdmFoYXJlDQo+IDx0dXNoYXIudnlhdmFoYXJlQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBJbnRyb2R1Y2UgYSBuZXcgZnVuY3Rpb24gY2FsbGVkIHNldF9od19yaW5nX3Np
emUgdGhhdCBhbGxvd3MgZm9yIHRoZQ0KPiA+IGR5bmFtaWMgY29uZmlndXJhdGlvbiBvZiB0aGUg
cmluZyBzaXplIHdpdGhpbiB0aGUgaW50ZXJmYWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
VHVzaGFyIFZ5YXZhaGFyZSA8dHVzaGFyLnZ5YXZhaGFyZUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+
ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94c2t4Y2VpdmVyLmMgfCAzNQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94
c2t4Y2VpdmVyLmMNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94c2t4Y2VpdmVy
LmMNCj4gPiBpbmRleCAzMjAwNWJmYjljOWYuLmFhZmE3ODMwNzU4NiAxMDA2NDQNCj4gPiAtLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5jDQo+ID4gKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuYw0KPiA+IEBAIC00NDEsNiArNDQx
LDQxIEBAIHN0YXRpYyBpbnQgZ2V0X2h3X3Jpbmdfc2l6ZShzdHJ1Y3QgaWZvYmplY3QgKmlmb2Jq
KQ0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IHNl
dF9od19yaW5nX3NpemUoc3RydWN0IGlmb2JqZWN0ICppZm9iaiwgdTMyIHR4LCB1MzIgcngpIHsN
Cj4gPiArICAgICAgIHN0cnVjdCBldGh0b29sX3JpbmdwYXJhbSByaW5nX3BhcmFtID0gezB9Ow0K
PiA+ICsgICAgICAgc3RydWN0IGlmcmVxIGlmciA9IHswfTsNCj4gPiArICAgICAgIGludCBzb2Nr
ZmQsIHJldDsNCj4gPiArICAgICAgIHUzMiBjdHIgPSAwOw0KPiA+ICsNCj4gPiArICAgICAgIHNv
Y2tmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsNCj4gPiArICAgICAgIGlmIChz
b2NrZmQgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJybm87DQo+ID4gKw0KPiA+
ICsgICAgICAgbWVtY3B5KGlmci5pZnJfbmFtZSwgaWZvYmotPmlmbmFtZSwgc2l6ZW9mKGlmci5p
ZnJfbmFtZSkpOw0KPiA+ICsNCj4gPiArICAgICAgIHJpbmdfcGFyYW0udHhfcGVuZGluZyA9IHR4
Ow0KPiA+ICsgICAgICAgcmluZ19wYXJhbS5yeF9wZW5kaW5nID0gcng7DQo+ID4gKw0KPiA+ICsg
ICAgICAgcmluZ19wYXJhbS5jbWQgPSBFVEhUT09MX1NSSU5HUEFSQU07DQo+ID4gKyAgICAgICBp
ZnIuaWZyX2RhdGEgPSAoY2hhciAqKSZyaW5nX3BhcmFtOw0KPiA+ICsNCj4gPiArICAgICAgIHdo
aWxlIChjdHIrKyA8IFNPQ0tfUkVDT05GX0NUUikgew0KPiA+ICsgICAgICAgICAgICAgICByZXQg
PSBpb2N0bChzb2NrZmQsIFNJT0NFVEhUT09MLCAmaWZyKTsNCj4gPiArICAgICAgICAgICAgICAg
aWYgKCFyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAg
ICAgICAgICAgIC8qIFJldHJ5IGlmIGl0IGZhaWxzICovDQo+ID4gKyAgICAgICAgICAgICAgIGlm
IChjdHIgPj0gU09DS19SRUNPTkZfQ1RSKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y2xvc2Uoc29ja2ZkKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJybm87
DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgdXNsZWVwKFVTTEVF
UF9NQVgpOw0KPiANCj4gRG9lcyBpdCByZWFsbHkgaGF2ZSB0byBzbGVlcCBvciBjb3B5IHBhc3Rl
IGZyb20gb3RoZXIgcGxhY2VzPw0KPiBUaGlzIGlvY3RsKCkgaXMgc3VwcG9zZWQgdG8gZG8gc3lu
Y2hyb25vdXMgY29uZmlnLCBubz8NCg0KUmVzcG9uc2UgaW4gdGhlIHByZXZpb3VzIG1haWwgIHRv
IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGdvb2dsZS5jb20+DQoNCg==

