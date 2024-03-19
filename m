Return-Path: <netdev+bounces-80513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC987F7C8
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 07:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D71F21CD8
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1CC50276;
	Tue, 19 Mar 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBMssf1g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAB40853;
	Tue, 19 Mar 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831146; cv=fail; b=KIiQ1UvDIKERsS92LVWhHwilEAEcykOfDh2uiuRVx2uYoFNg5H0lb7fLLwozZBYJgtYQtO3H0dl4eSi+KsPhAmtiUFsOqBXtRkmLne7c7561b8qNCn7WorlfgOgQyG9jxw6nB0jp46VW9inAh0jUE8CocDbz+Kj4jczgMuPpmr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831146; c=relaxed/simple;
	bh=31Gk/708vjNGHWGzqkpP8aE5lFVsPc/IW9NnzBHrVyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfDHNpsmRGItdSF6rSaTjQIaqZLz8Eur8P9lTUPqmId/dvPk1SgGku4OtwPhfAE2WYc6lAjNkbiYJw62t5bncIakeFZlZLBWvo6A80TJTtxn3c8oGPJ2KsRXL2HgMOH/K5+H24KZsN9ESaSyeLdLELE9Xw2Juu2fE99SgW5/yIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBMssf1g; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710831145; x=1742367145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=31Gk/708vjNGHWGzqkpP8aE5lFVsPc/IW9NnzBHrVyY=;
  b=dBMssf1gpzp91EQkVa4875xbSXD8dtX2YwKLhMTCOfp0sg7H/II5Pzc9
   +2PBOIsUpasHIMtT0h2gPUL4HjSyyncS+Zr/UGf3yvCu8n+GiPdJjx917
   wCQHO+bDkj2aA01kRqkFyOXGplYjckuVFnA+guhaPpNI6iHY6NwdztpXm
   q80QHWdxGoR4+u6WRLo3/n6a8d4Xbrs4EKGETHZ1fwGOxgrn5nzPZkxu4
   CACwGnaReYcVN8qxibCo7H2RKYgZtmyVEZtVFUcKV41ArxCeOdEgmF1KW
   LiyYrIAwxDcDqKi3H+PahR64KkrpejuvohLrf84urvtoZyP7q00mTLo1G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9481887"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="9481887"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="13602992"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 23:52:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:52:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:52:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:52:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGgpbj5dh0wO+VfEtuv9v0Hot6yE1mNzjvMpMeyg7ogRUDBzksggPT2B8OBw4fghU3Yu5ZqzKZG6PHFYoYUuDIGxW7PxSA7AN7fphlMkCWtxbLgH5W8b8hb6M/dVf1ItsSO+COUPWKgIL961QgiInYk0umYJ917zUIt4SKZObWAeJaK8V9h71bxNnEkRm5F9ZuoULcvb94LZqIOkhYY6/fd89PjIUYSDetFEaU+Cr13V5zUtjlT9WuFNq+qi/I1bNp3TfiPUNCSxBhjuWOUqY6gMVqgNeeA0dC2bqlljwmv4ZUDKbkjfP0b3VV5NA6bp4eVpX92bCJD1s+VV5CeSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31Gk/708vjNGHWGzqkpP8aE5lFVsPc/IW9NnzBHrVyY=;
 b=iodOnjicwrsHdAP2ez8qqp5W1UbZ7cKTRUmaPb0PMIxfDORSxPAJZ+9Wjue0x2Sf1mvGjhD6QYfhjN1ayC10mHaPPK49E2MMVn29S7zPEu9YBAzdFUH2Ci2v7D5oLNx71j569gxqZ2LmcZVw7/AAh+62diDjmfxVrYwu/2eA3Jhg43sPuyf4pg1wXPbw7YnYNzEun5+GyT9L0O9ObumG58JPJU/dsn3xhwppwM/dN/DkZv6Y4uNgsPHhGhJwT97eYDt+1bLQVtyEoh1iVyUR9JFQCyuQ+0SjXHPpHTUgoWVm7NH11e8IZ/QJM2KpjZCxTlfzo3mtFRQH6bAP3NriIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 06:52:21 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8d5:f5fa:18e4:fd1]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::8d5:f5fa:18e4:fd1%6]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:52:21 +0000
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
Subject: RE: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size
 function to configure interface ring size
Thread-Topic: [PATCH bpf-next 4/6] selftests/xsk: implement set_hw_ring_size
 function to configure interface ring size
Thread-Index: AQHaduRmdUwk1meuFk68ui9MiNeTALE5EwSAgAWRvtA=
Date: Tue, 19 Mar 2024 06:52:21 +0000
Message-ID: <IA1PR11MB65147B9C7D6FF5BF3A526EF38F2C2@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
 <20240315140726.22291-5-tushar.vyavahare@intel.com>
 <ZfSI8UftKDGWTgUC@google.com>
In-Reply-To: <ZfSI8UftKDGWTgUC@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|SJ0PR11MB6791:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qi+cyBHVM7GvuOUYlUy4QbhM9r2LnN1UWHmhEPtIDgWNzn7d4JH/p8xyCy90r4bMqhaJMJoMNoRVJYK9nIwS+wQ04n64eoncdBt41yRa9TvltwlcYOKZMK0KkMVhDmKEEDlJzUKh+2AFGOt8dFNEWjf58kAi5zLPVO+5Y4J4dcNDZGZqVLSgIe6pX0K1xgBW6coA4a+GzOGUbqMhMHHrpVIXEFJGB08Zcj2b6qS7PRriAwPStDi6MyF4wQW4kcI5uKoxBlbFEcgE3nGJjOj9mNT2HsyxJpAjFg97BsupUczXBnS1VXHE5YelZHOpSionT4X1Gizfn0BMDvQXvsvXHV4X1iO/w8DlRJ8b7fbd23YyJY2vJPuBNZ9QPxFQ05qYTPAzEci+6SbLKVM/zh3OVEK5oGmJi8hhIAzPBn5LeaE3VYr/oJ06H9fk9mydpl5dKHi+RhimHOHUan2IFbmUcBm9d0OL5ICvgIIttqp/arf2Vt9YHaNTxf9a7Eoj48c8hqiHCPD+H7TExmuFIOXJobqzEnKVIlKsK4wOWDtamquB4Uez8Xelzo33z6xyOipA5OSJWf+QqEo1+WcpizijMcdZ9wLs+hbwwuGyufrcIcHKDyOpPaUHLHo6WuWWGeLBvDrJKTlXxvg0gzVjqJXVBkK1hyjfGbydM/Ct6GF3OMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFA1aDhIbisrdmxpZjRRUUVtU21kS21Ed0VZVm1XUTlJNnRrenUvRWRYdEdC?=
 =?utf-8?B?OVRLUVkzNmtmazVUQmRZNFJNbm4wWU1kNlFPSDg3SVc3UkVUR1l3NS9saGlq?=
 =?utf-8?B?aGtxU3RVSDNWZERZZitJNUVoOVpZdUFGdWZhaGZqMVNiMjhDN2lvN1F0UWxa?=
 =?utf-8?B?SXhXVGJTU0pIMjFMdE5JWWlmNTZGSEI3QnlTelUzeFZsaUQxYkRVNi9OUitm?=
 =?utf-8?B?dXhRT1hUTUxmelFlZkw2WEJZRHBOR2k3WjA3elVvaW4xR0w4L3BSRXRhVjVG?=
 =?utf-8?B?RFByUVZJSzBOSWovOWtyRk84OEJ5TWsxMEIybXRVcGI0K3hkNFdJcG5yMHF3?=
 =?utf-8?B?YUV2WjVNK1lnNjJFOVdpU0x1OWhDWUdJQzI5bS9KU29BR2I0QnlVMmh3UFVh?=
 =?utf-8?B?ZmMzWVlMc21VRnhvOFhvRlEwRXN4UGFlN3hnN1J3Q1YxWXl6aVZPTkk4NnNJ?=
 =?utf-8?B?UjF3a2g1SlV1clVuTHpCYW1xZjR5bkY0Mkk4Mm12SEUwNTEySHZEaFQ4RVcv?=
 =?utf-8?B?NkdZL0UwbG1QYkNVN0c0WnZleXg3TTZYRS9zVU90eWx3NTVzc3ZwRHRCZlZF?=
 =?utf-8?B?RnVielFvUWRqdEgvSDl4a2NkOFNMSldZMHZkZHZHejZkS0grVW1BeXl3dkha?=
 =?utf-8?B?YzBWRTVucTJJZ1BLTVhXellwNWJpMTd4QTJ5VXNlcG5vSE1nbEJpVkFvaVlC?=
 =?utf-8?B?L0NLTnVmdVMwcXZtcVd6TlJBbnROZXNMR2Q4bnhqaDg2Y3BBbm9kRmcwcWNW?=
 =?utf-8?B?Z1pSRlcwNk5hQzFIUi9hekJFdHJiMlB4eWZhREExWlNQckRjeFZWc0R5TDcr?=
 =?utf-8?B?QnlXOEd2KzlSMnFMd2UvaURadDFTazlUQjNYT1dGaGl6SlNxUnV2aXZqUXVx?=
 =?utf-8?B?cFl0NjBSK0Y4WmRjZERiVGgzQXd3aklKT0pNTWlOOCt4RllJTFpqWjVqNlRS?=
 =?utf-8?B?YlpjdGt3UExuS1VQaWJ6enZ1T3RydWJBZVlHemVRSUNZamhOdTZvK1A4WW41?=
 =?utf-8?B?Vm9NdkowRDNpMEZTQzNaRGZkd3k0Vk1xdFhCQ09XaFJRaVNoSkRaeGROUTdV?=
 =?utf-8?B?WWQ1M21kYk1abXBtSUlTTmdrVFRmazBKTUNDMHJzL25oc3hkaUhuNWFBS3RC?=
 =?utf-8?B?K2N1KzNML014ZkRRdDkwL29wT2YrU2xNeXhsK1NCdHRIYlR3dEdqTjdpZE9K?=
 =?utf-8?B?UWJvclNzRXdZbmJveEtUZFRLZmpjcU9OWXI4ak53YitTaWJONmJCM3VHT2hR?=
 =?utf-8?B?dHMzOTJaSWg0QVBWa3JsbVZZVmZIcHNlK3NkK0gwTXdFUHFDWmxsVms1ZERQ?=
 =?utf-8?B?aXBFNytZdy9lWXpqY1k3ZEtXazVYWTZad3FGckFickM1Mms4dVNveGU2aTU3?=
 =?utf-8?B?aHU0anViSTRzd3hoN0ttWDZGMkF6MlpQOXFzZjh2c3lYb2hNY3EzeFp6cnZq?=
 =?utf-8?B?OEV5NHlrTHJ4N2lkYzFXc0F1RUU4ZW4zMS9ZcnZ6UlNNM2hneU9wUUpubkJl?=
 =?utf-8?B?S0x1eHpUd3pHVkIvS1VVNm5FVll2UmRCcjVnMlNnTXVqdEg1bDV0NG5RSzJV?=
 =?utf-8?B?WTY4ODE4Z3RTY3ZOTThFRlMzWG45eTVxU0k0SzF2WUhDNU1Kcis1K1VPSlA1?=
 =?utf-8?B?QjZ5ZFVESEpTejlCZHdKajR6Wi9rU3laeUZtQnBVYmM4dDFRRS9SRlRVTDkx?=
 =?utf-8?B?QXN2N1lpVnNNQWV3Vmlka2d3aWtMbHd2UGZjK2d1aFB2c3dWWDRXVzdFUnRB?=
 =?utf-8?B?c2syQ0crYUc5K010SmNySktMdWZCUWJ5UG8vLzloYlMxcE9WNWhOL3l4R1Y4?=
 =?utf-8?B?MHNYdlBBdG9aM0hYTC96RVhjN0pObGdMdVcxdFVnckljR1l3OUJKaFhGMDJY?=
 =?utf-8?B?dE9vRHJaUWJsK0JybGV4L2J0aTVpaksydjZMZGZ4b1R3N3hxVnJwRjNIaFo0?=
 =?utf-8?B?L1lSVVBNSFJxZ0hNM1NVc0RnWHUrbXZGbFh3K2pxbnYrekdrMXEvalk1bWhG?=
 =?utf-8?B?ZGtxNC9LSEtoVUNqVmU0UmdEOFhPNE1menVQeXdPbHd0TFd3REJMN2gxem1R?=
 =?utf-8?B?NWVtYnIvOXNjUDRLdlpOL0ZMbUUyWEgrMDFreEtBL3ROZWhkT2lzdkhZU0Ur?=
 =?utf-8?B?VTUrWEh4S1BQakRPdFEwRUdGYXZ5RStnR05YdUxrdDFmL2hGS2JyMGhLOU1S?=
 =?utf-8?B?Y3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: deedc825-cb18-449b-72aa-08dc47e12012
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:52:21.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7oK++Qji3myinHpJVDeYdKXm/ZDsnkaXqNVBOnq8xpt/48FxmlByVksW4PEOJMWql8T107Vbri0QNEiwoGQ6SgEBC0VcejnepNQzkxQ5Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzZGZAZ29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxNSwgMjAyNCAxMTox
NCBQTQ0KPiBUbzogVnlhdmFoYXJlLCBUdXNoYXIgPHR1c2hhci52eWF2YWhhcmVAaW50ZWwuY29t
Pg0KPiBDYzogYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYmpv
cm5Aa2VybmVsLm9yZzsgS2FybHNzb24sDQo+IE1hZ251cyA8bWFnbnVzLmthcmxzc29uQGludGVs
LmNvbT47IEZpamFsa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5j
b20+OyBqb25hdGhhbi5sZW1vbkBnbWFpbC5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1
YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFzdEBrZXJuZWwub3JnOyBkYW5p
ZWxAaW9nZWFyYm94Lm5ldDsgU2Fya2FyLCBUaXJ0aGVuZHUNCj4gPHRpcnRoZW5kdS5zYXJrYXJA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGJwZi1uZXh0IDQvNl0gc2VsZnRlc3Rz
L3hzazogaW1wbGVtZW50IHNldF9od19yaW5nX3NpemUNCj4gZnVuY3Rpb24gdG8gY29uZmlndXJl
IGludGVyZmFjZSByaW5nIHNpemUNCj4gDQo+IE9uIDAzLzE1LCBUdXNoYXIgVnlhdmFoYXJlIHdy
b3RlOg0KPiA+IEludHJvZHVjZSBhIG5ldyBmdW5jdGlvbiBjYWxsZWQgc2V0X2h3X3Jpbmdfc2l6
ZSB0aGF0IGFsbG93cyBmb3IgdGhlDQo+ID4gZHluYW1pYyBjb25maWd1cmF0aW9uIG9mIHRoZSBy
aW5nIHNpemUgd2l0aGluIHRoZSBpbnRlcmZhY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBU
dXNoYXIgVnlhdmFoYXJlIDx0dXNoYXIudnlhdmFoYXJlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIuYyB8IDM1DQo+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hz
a3hjZWl2ZXIuYw0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3hza3hjZWl2ZXIu
Yw0KPiA+IGluZGV4IDMyMDA1YmZiOWM5Zi4uYWFmYTc4MzA3NTg2IDEwMDY0NA0KPiA+IC0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94c2t4Y2VpdmVyLmMNCj4gPiArKysgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveHNreGNlaXZlci5jDQo+ID4gQEAgLTQ0MSw2ICs0NDEs
NDEgQEAgc3RhdGljIGludCBnZXRfaHdfcmluZ19zaXplKHN0cnVjdCBpZm9iamVjdCAqaWZvYmop
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc2V0X2h3X3Jp
bmdfc2l6ZShzdHJ1Y3QgaWZvYmplY3QgKmlmb2JqLCB1MzIgdHgsIHUzMiByeCkNCj4gDQo+IEht
bSwgbm93IHRoYXQgd2UgaGF2ZSBzZXQvZ2V0LCBzaG91bGQgd2UgcHV0IHRoZW0gaW50byBuZXR3
b3JrX2hlbHBlcnMuYz8NCj4gVGhlc2Ugc2VlbSBwcmV0dHkgZ2VuZXJpYyBpZiB5b3UgYWNjZXB0
IGlmYWNlX25hbWUgKyBldGh0b29sX3JpbmdwYXJhbSBpbg0KPiB0aGUgYXBpLg0KPiANCg0KQ2xl
YW4gdmVyc2lvbiBvZiBnZXRfaHdfcmluZ19zaXplKCkgYW5kIHNldF9od19yaW5nX3NpemUoKSBi
b3RoIGFyZSBtb3ZlZCB0byBuZXR3b3JrX2hlbHBlcnMuYw0KDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBldGh0b29sX3JpbmdwYXJhbSByaW5nX3BhcmFtID0gezB9Ow0KPiA+ICsJc3RydWN0IGlmcmVx
IGlmciA9IHswfTsNCj4gPiArCWludCBzb2NrZmQsIHJldDsNCj4gPiArCXUzMiBjdHIgPSAwOw0K
PiA+ICsNCj4gPiArCXNvY2tmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsNCj4g
PiArCWlmIChzb2NrZmQgPCAwKQ0KPiA+ICsJCXJldHVybiBlcnJubzsNCj4gPiArDQo+ID4gKwlt
ZW1jcHkoaWZyLmlmcl9uYW1lLCBpZm9iai0+aWZuYW1lLCBzaXplb2YoaWZyLmlmcl9uYW1lKSk7
DQo+ID4gKw0KPiA+ICsJcmluZ19wYXJhbS50eF9wZW5kaW5nID0gdHg7DQo+ID4gKwlyaW5nX3Bh
cmFtLnJ4X3BlbmRpbmcgPSByeDsNCj4gPiArDQo+ID4gKwlyaW5nX3BhcmFtLmNtZCA9IEVUSFRP
T0xfU1JJTkdQQVJBTTsNCj4gPiArCWlmci5pZnJfZGF0YSA9IChjaGFyICopJnJpbmdfcGFyYW07
DQo+ID4gKw0KPiANCj4gWy4uXQ0KPiANCj4gPiArCXdoaWxlIChjdHIrKyA8IFNPQ0tfUkVDT05G
X0NUUikgew0KPiANCj4gSXMgaXQgdG8gcmV0cnkgRUlOVFI/IFJldHJ5aW5nIHNvbWV0aGluZyBl
bHNlIGRvZXNuJ3QgbWFrZSBzZW5zZSBwcm9iYWJseT8gU28NCj4gbWF5YmUgZG8gb25seSBlcnJu
bz09RUlOVFIgY2FzZXM/IFdpbGwgbWFrZSBpdCBtb3JlIGdlbmVyaWMgYW5kIG5vdA0KPiBkZXBl
bmRlbnQgb24gU09DS19SRUNPTkZfQ1RSLg0KPiANCj4gDQoNClRoZSBjbG9zZSBvZiBhbiBBRl9Y
RFAgc29ja2V0IGlzIGFuIGFzeW5jaHJvbm91cyBvcGVyYXRpb24uIFdoZW4gYW4gQUZfWERQIHNv
Y2tldCBpcyBhY3RpdmUsIGNoYW5naW5nIHRoZSByaW5nIHNpemUgaXMgZm9yYmlkZGVuLiBUaGVy
ZWZvcmUsIHdoZW4gd2UgY2FsbCBzZXRfaHdfcmluZ19zaXplKCksIGEgcHJldmlvdXMgQUZfWERQ
IHNvY2tldCBtaWdodCBzdGlsbCBiZSBpbiB0aGUgcHJvY2VzcyBvZiBiZWluZyBjbG9zZWQgYW5k
IHRoZSBpb2N0KCkgd2lsbCB0aGVuIGZhaWwsIGFzIGl0IGlzIGZvcmJpZGRlbiB0byBjaGFuZ2Ug
dGhlIHJpbmcgc2l6ZSB3aGVuIHRoZXJlIGlzIGFuIGFjdGl2ZSBBRl9YRFAgc29ja2V0Lg0KDQpX
aGVuIHRoZSBBRl9YRFAgc29ja2V0IGlzIGFjdGl2ZSwgd2UgYXJlIGdldHRpbmcgYW4gRUJVU1kg
ZXJyb3IuIEkgd2lsbCBoYW5kbGUgdGhlIHJldHJ5IGxvZ2ljIGZvciB0aGlzIGluIGEgc2VwYXJh
dGUgcGF0Y2ggZm9yIHhza3hjZWl2ZXIuYy4NCg0KPiA+ICsJCXJldCA9IGlvY3RsKHNvY2tmZCwg
U0lPQ0VUSFRPT0wsICZpZnIpOw0KPiA+ICsJCWlmICghcmV0KQ0KPiA+ICsJCQlicmVhazsNCj4g
PiArCQkvKiBSZXRyeSBpZiBpdCBmYWlscyAqLw0KPiA+ICsJCWlmIChjdHIgPj0gU09DS19SRUNP
TkZfQ1RSKSB7DQo+ID4gKwkJCWNsb3NlKHNvY2tmZCk7DQo+ID4gKwkJCXJldHVybiBlcnJubzsN
Cj4gPiArCQl9DQo+IA0KPiBbLi5dDQo+IA0KPiA+ICsJCXVzbGVlcChVU0xFRVBfTUFYKTsNCj4g
DQo+IFNhbWUgaGVyZS4gTm90IHN1cmUgd2hhdCdzIHRoZSBwdXJwb3NlIG9mIHNsZWVwPyBBbHRl
cm5hdGl2ZWx5LCBtYXliZSBjbGFyaWZ5DQo+IGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24gd2hh
dCBwYXJ0aWN1bGFyIGVycm9yIGNhc2Ugd2Ugd2FudCB0byByZXRyeS4NCg0KUmVtb3ZlZCB0aGlz
IHJldHJ5IGxvZ2ljIGZyb20gc2V0X2h3X3Jpbmdfc2l6ZSgpICwgd2hpY2ggbW92ZWQgdG8gbmV0
d29ya3NfaGVscGVycy5jLg0KSSB3aWxsIGhhbmRsZSB0aGUgcmV0cnkgbG9naWMgd2l0aCBzbGVl
cCBmb3IgdGhpcyBpbiBhIHNlcGFyYXRlIHBhdGNoIGZvciB4c2t4Y2VpdmVyLmMgYW5kIEkgd2ls
bCBwdXQgdGhpcyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo=

