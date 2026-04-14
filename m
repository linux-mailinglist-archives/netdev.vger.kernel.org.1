Return-Path: <netdev+bounces-278555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOepHU+C3ml+FQAAu9opvQ
	(envelope-from <netdev+bounces-278555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:07:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2A3FD73E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58DFC3004D22
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4B30EF64;
	Tue, 14 Apr 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ja69sEBh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5C29DB9A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190028; cv=fail; b=iBhknlAFZZqtv6CzoyMqdzC9ACXWE3b95kS19ao/UGj1/A9raJMTKLvllUm/AhTYXLm6aXquNzJ18v80FMSOWSrk+6SKkg3M+ptk2MbcxftIW6bgWaS6770dTjGv1zaZpN2FI/RaP3RFzofIhrA3Ae81EufiIEvqSGkoANAvvM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190028; c=relaxed/simple;
	bh=3eNP5HvqFtZixweFqtSnBgzAkW0g+Qkv8NSF7i/3OlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQ33jJoyVcLzu028wCtUh98XJ0Vv+GM/gEvJaSe68UpMtMeOtJbM/8yvC2uWoHJ3pHbyy4jm8VGEHIx//+FjSISZ6BgkSb+WxIz2niVit3BtXOlRNo/K9ZNiBGQosxjzpN6HFu69Sn2RdcsSJqwkgO2Q1qGTdlZ3ZQCUdv8cSac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ja69sEBh; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776190027; x=1807726027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3eNP5HvqFtZixweFqtSnBgzAkW0g+Qkv8NSF7i/3OlU=;
  b=Ja69sEBhyw9+EfDx0/OnpziPxqmMag198e1huJRR3yMLdVvyjcPbBPdx
   WEAt3RpSXtRPl3OS67D3Beferv+vwst6leMyRRMbqrTpaZo9Ss5y8Ihoa
   bVvNk+TcPZsNbClDyzfMDw0qYidwhYof4UnzInzAgpAFLlmpvsMevgday
   QEe3+T4rxkFlKxWUSMFBrvWX1o5MBm4AYrTrNV/ked5+A7pcOL/GM3/oR
   QpdyiYXOCxTmKeqgzeUBDlZFM8S8VMQkbcmxbQ9ok8IE1mWTDTJx2pD3C
   seOdV0seHytS4HbIIy1q7o1RqDlJ/GbGx2/bynAK7IxeGXIa8VvuNTpRW
   Q==;
X-CSE-ConnectionGUID: U6SDhD44SW+0zJPEKW+AaA==
X-CSE-MsgGUID: IDIGRUGBQy2b8yOJ51N1SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77034153"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77034153"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:07:07 -0700
X-CSE-ConnectionGUID: tfSs/D4ITCyM3UcqEhb4yQ==
X-CSE-MsgGUID: qXToM1usTviKh48L8ZMWZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235103780"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 11:07:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 11:07:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 11:07:06 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 11:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRw3vC2HIs5IPLnY0MAuZMo+Lw9k6+UdGSzasOQ3I7gPP9RbOmApS1upSDBrIiLgIyaYX6RiEG/GTX+yYYF40/qvAsOTcLbAJR6cQ+fvvwz5LVFyDfHRQhP969khPAoAGaonpTBTL55Y79h/NJSFPuKUzsO93zuRk1uQ9O2KRoM69RkdYvsxxEjf+Z+cuIGEomLk9GpbbqajJZ8MBjL7tsQpUQhpmNSvOcThyvT+8bfhhqhL2y9skCcHZXENGS5bxj1D07Wi6hsWjPeE7aJwNfU+Jxt1fCsxoDi7O8glwKHh+tZUio9++skOznHnKh/gqJHM+YeACO9tbuQOCv6eLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTGix8DcTNvFbznTLoIZ9fsm/hKiCz2Uw/pxp1xzcLo=;
 b=ZQ39GQonGpTgWkeMFdbI5Yg+CSG55yLjCP8p8pWnSdk/S6SApOIS+h4i7VhhZAdwp9MIHSHjNPh3tc8KKDdV4UaS8U6APRQmOL5B6u8g7v9j58JFYiCr41C7wmE5OOwqKO/rivrEadPRj4QU1W7t+lwHNrU9sz5UQLKjoBM1mtTWhXOBAHAPE95KxIsGG4jnYX0RcwUO/LZ58h95XSxTOZKGUkmHQAa3xDc6IS791v+hTWEpNVCp8L6JgIKvYbHmbvRCEKwCEkSNG5wmm0aVSXgZFxj1SFqPAJ632ilnFuPlKgrR2GLEVD3kBZkQNjl2PyQ/2AhH8017/OXFOyt8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Tue, 14 Apr
 2026 18:07:02 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 18:07:02 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shannon Nelson
	<sln@onemain.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise
 IFF_SUPP_NOFCS
Thread-Index: AQHcvJk24h4qT97iA0Sw6A8+JuMzxrXe+BXw
Date: Tue, 14 Apr 2026 18:07:02 +0000
Message-ID: <PH0PR11MB752220A0CE30349AF2A783F1A0252@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260325205054.109822-1-kohei@enjuk.jp>
In-Reply-To: <20260325205054.109822-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 84a9a205-5a76-4223-7975-08de9a50a12d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ykHsOPIxk+FlY4ExNKtbPP9BHmRNrx68tz/5wQq5SBh2WunK8eZLkgNvUBGXYPmBeGyVQYCiCD18Ix9PD8K6EnzSVQDYNG+unBcQD4ZjSxwhE1t74N+WZhsTvfUAIndJieW2FVSRmNhySoGJ3jud+zpAvbqq1f2QMTEqhDwzFZ0KfJYkljkXRKO/XPYmDbICfpMvCpX3m+Mrm6QbnL6YbvCKMtTDvv210kT0LqY+vYYhz0zhJ8I9xkDLvDPiwGAKG47pSLbv2k63vTQyRclkDbNfcAg9T7Q1/onuVVNt26v+m57CijAxgIEJkWpJHC2nE537A4eG8zVtbB743nilC/EoBhuUh6Tpk3kUYYe4BQiq1/W0aNylpvT8TyKq95beXyGqaj+bcjkgppfnGOSiqyPdl5GEmKD7UkJQd5jX3qmeLAGrz0ooBfLvcJRTtm4LmFkkdqDYfBLLK/fClqEjt52WcgbkirGrOP7O3McKXo18/Hs9n0DNQXm1fS2eZZNIBeYDhWLaHzJS8NI4oNif40p6zBIs/oVtZFFP/IWAYDTMneOch3UDOAbxuBAPbiyKWAORHTMim1YXLtfarmdDCxakim80menniw3RS8gIlEAHTlM8Iapxnt9TkTIRaf2paxGknU09adHjQVSCQWaqyoTGgBsdCv0To29a25xE9MZuBHfmmOzxLI0GY3rHN6L4jLOPJZWucojEwTIJKyCDwMDv7Wi/ULlyt1+tTvhFnYRbYEHo6Y3jRrwoKLCaggOKtROP9WKZjPB8HTpIdM1LYERPm0WlUViYEbA2elUBAAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlgY6RphbqFaULfyxPoxCubn6bT/Fgv2H7NrMpn/6KeHvGe52M8K3Ur3/m2D?=
 =?us-ascii?Q?R5XJ2LHApPB3uxee2fvOElQbKYB31Vl2SgTA4AVnyJdg8kj2b20nBd7d4115?=
 =?us-ascii?Q?Bs+XhBEX1wWPnwtiYi+aBz3Vif6Qv1kIWHN7T7tn+P8Innp7fE/0CXHWSaxs?=
 =?us-ascii?Q?Eo+Narlm8xHaW2rxEnQPuLHHSXffgN9WKaHqjVbUI477ELg3ABsV4/+dKoS6?=
 =?us-ascii?Q?+ODmrmdEmDGpTsLyF0gJeSLJP62QEEBjLiHw1MudONAH1MDj0Zd0XNIx9BYF?=
 =?us-ascii?Q?m9/qxY5EAlMblzFvQqNXIC006pwAiBsBwfURuE2cgFcu+nHiX/F2u2NLnXqs?=
 =?us-ascii?Q?kCuLVeXNHqIbGMBQXqiATXg+0VSfX7TBWPcO1yyLIsWINce/Z70nlX/+OmNe?=
 =?us-ascii?Q?o4yvZ0j8bPFKyPq7tqQcI7kENOibg53plFQh/Tx+dgbRKaXz6Wx0G63LkMuc?=
 =?us-ascii?Q?o2Znnai6x5SdCVl8Sp4r1xVWG57BpbxyAkEr5mcuDS/0/VkkCPcSjlSDdtw9?=
 =?us-ascii?Q?FPBtlUv5abiMydK/DhHs36E+MPEywlWuFlQd2t3MPcaA3f4vapvghVkVCFSG?=
 =?us-ascii?Q?E/kpHe/nO5D4AlP8pvY5dU2xonFxvAtsn+pn9jc4NOjyEdY9+FedWSeASvQ4?=
 =?us-ascii?Q?HZij2uabrLv7vJOztr1+6o1GC9uGnRH3daGaxCfZV3H0jisQwmFVwh5OYYGt?=
 =?us-ascii?Q?zwzo8cTVwg7lxVQRRauPGrjx3MrIWC+QmGDgvArXFArpJv/tSsMb5kMHstD9?=
 =?us-ascii?Q?c8+hZnLZi4QyY2KxDj3CRIqYZ8bBaH/N1xA084dbXgsQvFUoV29/JLRJuVko?=
 =?us-ascii?Q?+MjKMyxtWmEsJJYZ0sDPiPmGmQmpY1OI9bgFguCg6nRxlFDcO+4douMjGuXX?=
 =?us-ascii?Q?E/KV3gNWomhcXKnoV/F7qplfpra0Q1cGGjDetVT+BjBYXPrzwLcLLOgrWohY?=
 =?us-ascii?Q?1aSLzsD5uRHdcM8m3uN6yuBgdN1CvQ48fP2q1nP4DO4gH8nfoFdrFZ2dr2Y5?=
 =?us-ascii?Q?r7anCs/GFi6IdW+QkROqbB5gEBgLhWaMoKaElt5bjQtia/szzzhDFUvxUL88?=
 =?us-ascii?Q?fDGo/lI1YU8VLFLbHx0zBNJdptnqNMb1gn3DC1qR9BmJL1skk++RK+FsK6l/?=
 =?us-ascii?Q?AVZkE5/kdb43f0It6ZBUBnmgGge2zacj/HzRE5DMNNtw39xO7FAUBIeg40+I?=
 =?us-ascii?Q?NX0ERkR7dEnfUWgP3BN/AMOEIfV/DIpEXC+EJz74I4dP9JOaqKlN4mu1RJjp?=
 =?us-ascii?Q?o/NB7zVAZ6FaOGsz0hRSWeR0gTjokh9ykSqqvUbSbizyt2krkS9xwqPET5aE?=
 =?us-ascii?Q?OmR2jtIKQJtWdw8XB9B+mA2A5b6GooU/uf1kPNiOCrB6Aw+1JZ4eYyyfork1?=
 =?us-ascii?Q?ld7rvIlol8HU2wS5PHw9Z+NNI+F2hof1G4EbW/tQ6THheyM7mNQs1OjIs4CD?=
 =?us-ascii?Q?m7pqPI4+5KdZnpEy3eRD2jvOW1Rhq+QHvmc+JYALCwTFIWH8ksDCDUAbLnmI?=
 =?us-ascii?Q?G/22FFYI1FglUzKwmCEJ077OgeRX1TmR9BBgj7oRLk+/Cu9u4Dwl0wACjKWT?=
 =?us-ascii?Q?2y4XGSnIyPTWoX8irsGt1WSM2KVIEqkVTQIFXJnpJBRpnKGiaiX7bis5cipm?=
 =?us-ascii?Q?2WwUSH5jD2Cv8zK8L+tzPn9FdZ9R9OWHoJcJnEq5zyo+VLTnUVB9vadnlIjz?=
 =?us-ascii?Q?T/NLF9Re5RoEBzL8PwZd8t6yeRwJiuKguH3mnneo2TA3H2RzQorFjbF9CV+x?=
 =?us-ascii?Q?e+xmmxNkyTi2IkXSWIe/K9OzkwCZktg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W4HxOw/ybd+hclv7GODzBidPZXu2X6+2eG05PMC31kCXfeDcETBfG+1jGlgOmt2ImcNNpM5lJQWA+mlrZUJ6AyJGaQC3b0fbyid7/CU9omTzsBfYbP3p9qfzyokjnJy24hNqpTuJFtG1+gd6DRbsnLboc8bhYabEHxqAi8QGD5ebh/tlZiXipqiSsZdxMkJ2hjZBySeh9zcLqFO/iIpQxfkj3bBKo+H8c1BiExAbBQRnMnENveeVEmvyD7N3IzB1JErTOESsSCrGQ+HtMIGG6z0+gByR1vAcMSO8I6xvocq5cnGDZqmeJhEybKfiUjWj2h6eNsTFksWLTT9S0bW+LA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a9a205-5a76-4223-7975-08de9a50a12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 18:07:02.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/9iHuWnL73F4MrojEJiJeEkoiruyt8KXuAV8kKmDZAIKoFX+ZYiUR8DGKsUhpN7mVYdHfGfhhnKFrfhpsyOmNMw+H5EkxyaUQwV+70oOjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278555-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,onemain.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,PH0PR11MB7522.namprd11.prod.outlook.com:mid,onemain.com:email,davemloft.net:email,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 04F2A3FD73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
ohei Enju
> Sent: Wednesday, March 25, 2026 1:50 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; > Shannon Nelso=
n <sln@onemain.com>; Jesse Brandeburg <jesse.brandeburg@intel.com>; kohei.e=
nju@gmail.com; Kohei Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] i40e: don't advertise IFF_S=
UPP_NOFCS
>
> i40e advertises IFF_SUPP_NOFCS, allowing users to use the SO_NOFCS
> socket option. However, this option is silently ignored, as the driver
> does not check skb->no_fcs, and always enables FCS insertion offload.
>
> Fix this by removing the advertisement of IFF_SUPP_NOFCS.
>
> This behavior can be reproduced with a simple AF_PACKET socket:
>
>  import socket
>   s =3D socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
>   s.setsockopt(socket.SOL_SOCKET, 43, 1) # SO_NOFCS
>   s.bind(("eth0", 0))
>   s.send(b'\xff' * 64)
>
> Previously, send() succeeds but the driver ignores SO_NOFCS.
> With this change, send() fails with -EPROTONOSUPPORT, as expected.
>
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

