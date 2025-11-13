Return-Path: <netdev+bounces-238227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB87FC562AE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC414E2F59
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7A330D27;
	Thu, 13 Nov 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1fF6Eh+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF8330B32
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021316; cv=fail; b=bya650cuCbIVT9jHEOAk9SE8H+i9OTEH3ExhHCJO5GmTSFlEliVafnbDGPqwCbnRKEwa2s2gzREm1tqpIz86hq2lpDvUe7uNcEdHq86q+U4rdZ0Pc+QnEqxipTufdpW4tG4a5MAIeM8DiR+HQ/BlWSaoJnMkrsG+4RbG0k9jsFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021316; c=relaxed/simple;
	bh=daOk/nwqBHGagxvk3Q4yQVNiSU3o987zWdVoPGz8lRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbmzQisQ7V/mpxSu38b6H8V0zKR5xsRkiCHxWCfSkW49xyDbrv4ukvgpJ+npR6hVQRBE7J2tfQqAGAzVegdo0Hc87+7b//uW/BYIN0ZaVkGw1iqIt9jE8l4hn4ZWeIhAf45Hnub8pnWi+/YbQsjsQoIPaMecT64slYZYcJz3bA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1fF6Eh+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763021316; x=1794557316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=daOk/nwqBHGagxvk3Q4yQVNiSU3o987zWdVoPGz8lRk=;
  b=m1fF6Eh+PDPL72L0fIxoCJNd7E+gypcigm9WCqvtg6ifyexuvHg4uFwR
   sQznC84PYWZxNYJnJ5Fe2E1hdy4+LOyqeXSGT21T6zsxlMRVijsiF4E5i
   ILWxLnD5oLDTCn+GjDJOsZ14/MNuwmqtnaaskVkij+c1HDLkGFOL6NPUH
   AfUH7+d9sO/8nszKdQ0rvI80fV9QA4qaZtEwRAG12p4FtqSSPWhKmWqo8
   6m/+5bu8gokekhynw0rAlU/Zmz+QCdF5tHPyEkOjzaMzW5h8S4NeBwtBP
   7tpdFFOH2+rFrkpPP5fXYXxwxU69SCK4/v0wKxIMpwYVwQLWh2hgU1Xjv
   w==;
X-CSE-ConnectionGUID: T+qtQ40DR6GzGln43FvmZA==
X-CSE-MsgGUID: quUDZqITQh2HZqif7xs/9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82491894"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="82491894"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:08:35 -0800
X-CSE-ConnectionGUID: 72/4bKrKRhipJr+3gdAC3Q==
X-CSE-MsgGUID: dk/7fcK4S7iNz0YNyPfLDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="220094815"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 00:08:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:08:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:08:33 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSRbZZOuzADlSU5TJRDiInyjLdjKNoxQ6fX++yLgaj6+xmDiuvBBvWaWc4LthOYXeWLKDfaQg/qzpnClha3F8FmJvCGe8VbzuV//LpUJw6wa7TLvafYiGTRfNZQAJuUJC0eBkW/sDSijC0OkFW4U3Q10mxihxWdZtnIYJ5Ux8RWdfPzZ/GlqqQIzac2kYEF4SLUqMfmMVy5hCeanBAeW0RPIfwn8jhnC/HkIDaQMjlk/Vk8bv7lv2+gOnUkqYk3KAbzlTEeYnTHq0kKTfXKnKH/56gPpRBHhEC0A12KLChyXTfyjhV7NQCIaZQLxV9O9AsaxAP7S7dLNouOwoazymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNQm2gHDVGrsNxEeo8eIQXncScvQ9PQk7JNRGnes4x0=;
 b=YhY/MNihCKrZc6PtQDMKAcNiJmUNFbHdN7cH8F9N5ruHbIcipXs3o3uIZT/+wri1ro5/edIsw43hUsbkOwqUizeSPTsb2oDSomU8r5gUac/MT7ahmS+rGF6zk7LKp8nZZgBjVrwfL1mMl9IVk7wSx8p1wycSFDLhk50eR45fa+K8TlfMnuomppHrfumhm4j8XWtX9k3IO3PoT35CyaOBGORJl4GvQwVBnDmirUdJx5gLSPtGtLSat2xM8uWSKiU3jlpSGitLd+qv4Yb/jxQr1nQtIT2S4jYeNs3KmPxNTldtrOS/50x44172kJFfYUXWyIyEyqhP5BgZF7LAEqpWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:08:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:08:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generalize
 send virtchnl message API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generalize
 send virtchnl message API
Thread-Index: AQHcVDTamPV5dfrWkEa8HtdiGmgtqbTwP10Q
Date: Thu, 13 Nov 2025 08:08:28 +0000
Message-ID: <IA3PR11MB898642FDBE8D123704A7CD82E5CDA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-9-joshua.a.hay@intel.com>
In-Reply-To: <20251113004143.2924761-9-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB6984:EE_
x-ms-office365-filtering-correlation-id: 994107a0-c4bd-4ff4-15e7-08de228bd3fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?DHlGngq/xfO9KIGbfmY+GY9/uxO1Zs37DS/1E7GygS5O7sFUzjralY0bN1pH?=
 =?us-ascii?Q?P7QjDe2t7ycxjXPGTmrmxjv2QWEj2jA6b0Ie87rs8IvTx+d2Z6ZO8CsM88Kr?=
 =?us-ascii?Q?OhiTycM4PG0ZRr2VUZL33GaKHly3oh1kCvXnWHMNTxjeJWdnBYx2/at2Ye5/?=
 =?us-ascii?Q?lMrdnCAVp7B+7wHEGymMbe/tg+vls86W8u4vOC29xa3zHHL9crluPTQUwRZv?=
 =?us-ascii?Q?lB1btzYRZIFW6q7suOnUEYG3CyN+DLI/PQnUFMTGmvW4dVnwzaDlWzLNZRQR?=
 =?us-ascii?Q?EaO4y9cuxXzLijGa8nRA5gRuhq+JZOlOq2kVfzTfSRZ1GCIkDseHVpg38PKH?=
 =?us-ascii?Q?vZlUqkajJYhQgmrstmGQo8220SIZyllsga4nOIlPIuDTwfpVT1Nc3MGZFI+0?=
 =?us-ascii?Q?Ct2SJtgUssNbcxGikIu0Qro1xI44Ac6cztTafOOWSDZOb4RT3SdfXL2HFaC3?=
 =?us-ascii?Q?3/QzP/FvbWyf2+I3ZJJu48ipHdyatOu4zUTb+vpLXKj194q96dnueKwKyoxU?=
 =?us-ascii?Q?NN6pyzLjx8MSqNUQTaWeBe62npgkwEnmMCaAvPjk80QefkSBIaT5TisdYSl8?=
 =?us-ascii?Q?DurOOHbbnCXUcZ6ZzAh8B56pRrCftgbnaOOkxLybjoaaYDrf01sYjVyg2Irs?=
 =?us-ascii?Q?/Azu3SaEZmN6cbvVnXFFR+JV3CNhNZMJmgYBEeXaFIev5VcIEZpMEuy24Bbw?=
 =?us-ascii?Q?paw0kFLQT/5iEKerpQMkzpZcfbKf9rbGiB9UCaHgdqkeXkf9r8QLO+r0cKOE?=
 =?us-ascii?Q?3W++T7Z78BYVPsuYh81D0KtVzthPFY1Qgop8MTEPb2XZ8OGWh8t+T3cULJaF?=
 =?us-ascii?Q?JMiDfG8IpciABbBlj43rVykIIGJsEgub1cyzfP2544v6eyHWFOvlUitVpg8z?=
 =?us-ascii?Q?grzd5Qh9LlOY0+OkppMMxm3pF4QEBuWVdpZPaVxQlQjO+i/KwmtgfyJZ48Pp?=
 =?us-ascii?Q?uQAyQvdy3gQHYSQCN5q94PpHSvk9ixH3qdWR1556/04Pv9IYGJMDTjeHLoao?=
 =?us-ascii?Q?YMXDkNXTaynWz5z2od1c+jdQH3R69EB8a8Td2CH9mkfZ6MU1//rYC3FUPlAG?=
 =?us-ascii?Q?apPad5KXuMJ6BYCEx87tGa5ey24vvQjauKQUO6epYEjMIi4nUGqHFAbvtg4a?=
 =?us-ascii?Q?Rxhf1wMF1A7dHmEYwJKKOXCfabz21CFczU+eX2QMW0Hn/cOGTXobBIuDbGhI?=
 =?us-ascii?Q?tv24xnjX3e/XKNWqzS85YGbcCoNBanrAzOlg3lvcV66orDOaflHCbccsCk3X?=
 =?us-ascii?Q?PV/wiTCPkdTgXACCfq9MT/oFCmobXztzCD6vq1Ef9VROiILX4ewri3lhtSCm?=
 =?us-ascii?Q?59rZwxHu+4pH5di1AUhiuukWnweAP2fYCOam/Gnln8vahVzRIk077djf8CIp?=
 =?us-ascii?Q?PodkOWJAt06DMTlp7lTaIkDTpCBW4+nbBJJ3nXMztS/fRsMfGJJpBWhKrfRL?=
 =?us-ascii?Q?dux8WC4pSrnV5VS/HHixaw7cCZT1D9ernZl+iTOsZmx3Q8+1q+PQOYTjbdhh?=
 =?us-ascii?Q?9ZB8j7KBG/H0ZuTD/LefzrSlNjBAZ9KgxBiN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GP8PJlsAzonvDDQBK1RTA2Z0d7eBE/q6yi/4GnxvuKR/AN4gjbQR26ihZVoo?=
 =?us-ascii?Q?EtnbKsqPTCezZf9RQMcJhDWndVoql09hLdYoxT7NxazFhri/jW6g0bsM3sMU?=
 =?us-ascii?Q?w5lO0yUgyE2nQaSiDZ+wjxrSCZefbLs/EM56VnO6CVKNr4NEUAkOej9mR16i?=
 =?us-ascii?Q?NDJDF5Oh/V13e72GhxSKa7nSKiAGHgZo0rXcOX6VlpKxlfFVHvQksOYiXyIp?=
 =?us-ascii?Q?lxjJ/F45wD648Spw+GQBaxchO0s5yDvGosVxGPbCcVDa7gg7+xZ6Oy8Vrg6b?=
 =?us-ascii?Q?B7NVedsPgQqLDREKiUBi64a6V40P6vl4IYqrJYF8z2KWbZP30m6X9xoBB8/R?=
 =?us-ascii?Q?buRzkpsEI2UE0wWsmphOltF064kHz3tqbdSoFleWGaY9yd/xNlctWjbdwtmT?=
 =?us-ascii?Q?gClaBVzhlkecqGgBSh9C0Q5Q9Es/9ac76fC+9R18I5UKgWtcEFsurfXK+G2+?=
 =?us-ascii?Q?VCjPg4V24xIcOGcP7bV2zAuyUFyOE2+dwABtOgdk4vpldcw0KsidallWsd4N?=
 =?us-ascii?Q?keREZAFlbdSadYS0UC8Wg5l+5/dgZggaKB/dvJDn9gLNn/26K48R0Ro35kcx?=
 =?us-ascii?Q?EfGF+3ur8XQ/+nS7TJWOgJjqkYLf8y5RAyK12HuaIqmZmtGXEw8IZAlpRZMT?=
 =?us-ascii?Q?7+Vcj/WxIVeuBqaLouSCfcx6eIXxXih2toEJtz8EpXvHlGx+N4oadNRDRkfQ?=
 =?us-ascii?Q?Og9fk66u8z9zAu5C6EkqEE8vrFMUz/7mp/hkpktS60kELy4vB5gAYPgwP4XA?=
 =?us-ascii?Q?xVm9X4akWE1SG/qMWOHAy80WeE6lBOV+5tY3/S6C9G4KYcNb9YOLddOnLMWs?=
 =?us-ascii?Q?ya8ywKZzcGw6G5Psj3U79zZFlvj0zcJO7TkrqHho8h021d7HjN/CThFcDqOR?=
 =?us-ascii?Q?lpQVPocGGoAOZPB1+AjVktM/N+BeyjDGB1PyVWI7/PDB5SkehEDX1+vqsrMv?=
 =?us-ascii?Q?5geaF+G6PYUKaRuEAzQSWY0zpug764UIvlvKfF6i+W+/wMEBNhQAUbKftE47?=
 =?us-ascii?Q?bpImxlCy4rcqYGChkvPDJ29VPCr8I+B7PskdsYJINyyOVGmDqG701zv5r4Pu?=
 =?us-ascii?Q?mqx98jD5CxO0cFGJLmBzilhwuMlDmCsn7PcboD90Tx1/6X+seoOlME5fXn5a?=
 =?us-ascii?Q?GboPq1gVGINmZchobUrnx/TpekqtPYSUql3Fbnw/Q6GeDIDUOvnuNKf3iKIF?=
 =?us-ascii?Q?dDuZsuiHNMBLJ1tIw3xsdtKqolemKQXYZDQV8srdM6zGzQam2Yj1qj0xwh7X?=
 =?us-ascii?Q?x656WbkaqKBE63z/noj6DCNNjMwOL5QjdwmagI9/AowioU7YZafuy+/wycZK?=
 =?us-ascii?Q?uFCKEOt9rl1Ax8Q1FgmPOR8HFAh71UxBfFsFZWLFvMEtI57BtKaE1U2ZomwO?=
 =?us-ascii?Q?ZMUx08UJ8mOsdzXkwQlHBA0juRDrVe/F3b7qo1FCs4OPE+n3EhhVEGaLebTO?=
 =?us-ascii?Q?bwZi5qNAwWj6py5MAk2rM3WqoI35NbOwnSJIjYXBZ6B1LAyMTB2eWZKuwGrE?=
 =?us-ascii?Q?2KrGnpgbcClcuRqMTgK3MMJZLols0t1VggteWEJHOJNZPxfsGAtX/f1Q/MVy?=
 =?us-ascii?Q?khiCWI5tgAJt/sjfz2XxKspsW++PC+1Xz14mb9Np7Eesa37DRNwy0tjicvZh?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994107a0-c4bd-4ff4-15e7-08de228bd3fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 08:08:28.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SshXbX4MyiyXPx8aTBmsHfDsZ9ahgHkqaXqNjF8Agwzp0iC8DJVQgP7PDHgHcimCNTQVuMAADvB5rTit0AdlnSfxxiQCuZyRiaQEAlYoVsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6984
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Thursday, November 13, 2025 1:42 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v10 08/10] idpf: generalize
> send virtchnl message API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> With the previous refactor of passing idpf resource pointer, all of
> the
> virtchnl send message functions do not require full vport structure.
> Those functions can be generalized to be able to use for configuring
> vport independent queues.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---

...

>  /**
>   * idpf_send_destroy_vport_msg - Send virtchnl destroy vport message
> - * @vport: virtual port data structure
> + * @adapter: adapter pointer used to send virtchnl message
> + * @vport_id: vport identifier used while preparing the virtchnl
> message
>   *
>   * Send virtchnl destroy vport message.  Returns 0 on success,
> negative on
Kdoc format violation
Put Return: on last line.

>   * failure.
>   */
> -int idpf_send_destroy_vport_msg(struct idpf_vport *vport)
> +int idpf_send_destroy_vport_msg(struct idpf_adapter *adapter, u32
> vport_id)
>  {

...

> --
> 2.39.2


