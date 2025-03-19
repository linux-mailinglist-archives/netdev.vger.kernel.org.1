Return-Path: <netdev+bounces-176161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7ECA69369
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608E316A569
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7FE1CCEF0;
	Wed, 19 Mar 2025 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckfDbRGA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E101C726D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398005; cv=fail; b=tqteN5+2tnppeYUg6DTftW6skDFoZ1YgJKA45lmZsSbCw6y4UhKtPzaKeoMTxXsOuE8EOfU1rYXpNH88fyofecEwOyW4uXyaOGr+EOL/DIb2I7R4AsEeTjEZKSCQ9pgE4/aJmqsnURvPnEVxHfLUZY7dvZgCw1IXT90aFvzRnOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398005; c=relaxed/simple;
	bh=ReSFiik3aHz6PHumEZgTUTgjVEk1AguUMUvYLtIJCCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ns04ymPww3vROAbXaYqoSvd0S2pAiDGq8Jx0gRWHDsjQgl1vP8i3k3xWOcEGMnnIDrXlRYlcQ3tO1CEbAhCWdlFbCtLucS96111NeL0NptSMx6FXNklc8hD1tMfSgGEaRkjrn7tkBk5Y4IwgRu0lrRSSY13Y2rzszTvZ6s7gI7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckfDbRGA; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742398003; x=1773934003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ReSFiik3aHz6PHumEZgTUTgjVEk1AguUMUvYLtIJCCs=;
  b=ckfDbRGANo9oUUYcAUZdHGxbVE41NYVrYAiT7SM/vFOPn5zov4NoMr9C
   rrG/a+xkw7L+5fUq8wr1xcUwTrb0qAIKb32A1SzlDfU5zyNQaDt+VEeWT
   I3uynZwp4hAuSnUYVaim19nKbVq9Igvai1GI9YofcYPP7GS/ZCncrHxzI
   MYUBlKOauzQn80W4V2Qy/AMLfnO50ve+sGLxgZE7gVynuV1pIr45w0Vz0
   lYZ2gtFzZrKUK8nxshJohZZY6IfqKSJviMoRlBkHy4wBc42uu7g7yKpcE
   DE2+lNTe8Fl7yCqvpPCOd+14Qli8Mz5Xg3SultpgpEpDNniVw95XMhSn0
   w==;
X-CSE-ConnectionGUID: aWkjtdOoQMa9A7RCcTNBrw==
X-CSE-MsgGUID: rxTlxxq1RoS22e6Rgw57EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="53807617"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53807617"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:26:43 -0700
X-CSE-ConnectionGUID: 0XMVQQiKTC+aCG6+1Jksgg==
X-CSE-MsgGUID: okPrlMxWTGKB7nujKkj9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127356236"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:26:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Mar 2025 08:26:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Mar 2025 08:26:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 08:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVhbhj+bOruYX10w8xmyfzaVpTSTvvVKs1aL6QnQW2PeJXFxLtrL424hHNqxIzuuGWR+shVAsRKV0gaET3kZyQh4N0BhdEAc8g0wJds1zilNGxslFt5UW9wQppBuYGU82GfRKoQctkbyCmTCZDAt8X3J42HvQ5yJ7WUMDKobWLQPExFP9pyykQ41BUmTwjtvthfsYx0QN+KcuVtCKaOIJd/P+0YGZDgB4uQGjYGZpZBP78YZ1iyOqGUBw87tfGTNWYLtchAsAkkqEUOYQldO1X2SBTaTBvSUwc44HE/S1EpsPDunAo+glpUBXYGGxbWeB7RJij9Ck7zOIpfxfnFiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18r/U3qPxWt0/K2MEw0Y6VOY6RfQjzH3EhBhWQ4fTI8=;
 b=CMhRsJ3RRMGaPy27LhZkhoJjOlASV9hgdTjgnYW4mjA4/kwknGMVa8CMQCTWLQHZK2tQ1WFrCCinQXtPtNo3Of4uZYKc/UVQ2OwkIMF5XHD1ohgYBpSxDuPRQbTzKbvGQXJVFCa96vkyBrqHnGUMVN/RQsmQgsv/XNRyjrHsUk41RHzVS/OMgQaMrBmANAyg3orkANnRQZjCftjSTbACTo9/vDV+hERGfrsqQUx9oMYyhI9OYXCXK19t1tzvihPcqER8Ns9Wrd0d79a39vMl4uaujSVrrPrySMxNwNmCSxnkPxj3TA/TcLdbE0Fa5Ks7Gc9iDyIc0NRUumraofGGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 19 Mar
 2025 15:25:50 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 15:25:50 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 13/15] ixgbe: add FW API
 version check
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 13/15] ixgbe: add FW API
 version check
Thread-Index: AQHblCtAtQmCWckhNEizc9WdGcyACLN6ncLg
Date: Wed, 19 Mar 2025 15:25:50 +0000
Message-ID: <PH8PR11MB796535F9D4EF68F547CA4FCCF7D92@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250313150346.356612-1-jedrzej.jagielski@intel.com>
 <20250313150346.356612-14-jedrzej.jagielski@intel.com>
In-Reply-To: <20250313150346.356612-14-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|SJ0PR11MB5769:EE_
x-ms-office365-filtering-correlation-id: f2ad2432-6728-47f2-a134-08dd66fa549b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?hSV9ohyphTSvmnsM5SM+KIoDspg0z48jBohGgdCE71E9KhvWJnJIIcI1GXOM?=
 =?us-ascii?Q?wV90mHu36rMng+PNd8CirFF9tKJ2CUkCshqbaDjlwk/d8QIjAIlDvgsF/Dnw?=
 =?us-ascii?Q?DpXzQ0Zbgqi/YOr8hnTbN/LR+FJAhcUfIJDKKXWC3Tut9uNYLS0pyavNWJ48?=
 =?us-ascii?Q?eosJMJaG7pORvqkfW4tagESQXcFee8Xex4h8M5cLH+T5vLZ6CJY7RN+N1DiU?=
 =?us-ascii?Q?QXv0AAcrihaUrhFahM7K0VwvNcsc0iaR4f8r2vsQU/WxQ45R16GnsY+HwrSh?=
 =?us-ascii?Q?gMnFis4sDv1tm//6DU64cnoD0hRWGHqIZxJMzuRzlH89WMpjw6SsBu7CxZCv?=
 =?us-ascii?Q?I1wyBBdy31lEYmI1OhAxsryNgqzOmmQ/eKiLQvfNu2gLgGQB7K3GTL/BVezp?=
 =?us-ascii?Q?fnXSBNxUH83meoeD7WW2A0qgsXusiHDgjDHopNpn25L1OqKX4vNCja64hoBv?=
 =?us-ascii?Q?Mtj1IDjmgeJEZLEbyNpDJSQOEpybR0/2U/Ik+9nW0LbbNyES9tevxmiQtxOa?=
 =?us-ascii?Q?jGWX/FmXcB8z7n13MBcx9dkhx9DbtLA37p9YQ5SxpJuhiyPzbRfohPPGex/p?=
 =?us-ascii?Q?ugjE42BskM47DwwP2Is3/RC9QeiuSyUA8u9xmgDqMHsk+c97JOIlDuMgXr1b?=
 =?us-ascii?Q?krxQpq5PYovmQx1HczqsLjyfe7qQmKvHBbWpBDMycTLD3d8yXcihCNLZv/W5?=
 =?us-ascii?Q?Oc8ZtbAXJi+4X7nWRAYB0nBkdC2HYU8lUhWZrhXU0Uvxbb1Y9J2E5WURcMc0?=
 =?us-ascii?Q?ooP1j/JlRB0yE8pcogv3rcO/Xdpo+ebAvGSMyzxiI2kUhJHCEh84NB+CrdPV?=
 =?us-ascii?Q?8akk7pYwbMksyXvGiGt8zWWAvuaO9zfNpk2njUE1qwOKUBE0IQ2/YJUZKlhd?=
 =?us-ascii?Q?EvmSFjkC6FxWqMr7zCloiN4yUA77FbmzJ/JsRu/Xk4H4OiGsZXYQyTJkftco?=
 =?us-ascii?Q?9mnEyNSSYO1/M9g8SaqQyRCgh3IGScfv7RX/MJznZMiYRoaNaeqdG/2YA6KU?=
 =?us-ascii?Q?3MzRScvk3Wo0zO/EASHn2BPIwkGnDSNbcE81O/WNPnkTzPrmj9xX6PZQDNsj?=
 =?us-ascii?Q?iXe95Z2n9lntvXu2zhNZeeRDPfx2XmTbpRxPkIPUwWUxNpLrdxVF0CdZ6m4e?=
 =?us-ascii?Q?HG7eKRilv9YQHqCEfpl/vF4wPpFGaTTEec5T9MjjA2cni+ViTYa8u0K59BU/?=
 =?us-ascii?Q?ySHX8MKcBBgplrjBg9mZpbA7Gz0ry1gcQZEnUeK2T1PkjbkJctk8qlp4H6wp?=
 =?us-ascii?Q?bJX++sxavM8/9Kwy84qANYAwp5XIR6Eju9gtdwJNZokQ45V2py/E001io8wX?=
 =?us-ascii?Q?RSCq67xa8KBkvQ3Rl/mVvZp6LlcyUL5RjYsbmzWz5jH8jPZQwFQpxPOdlV95?=
 =?us-ascii?Q?CncNuHEtAol9T2dHKBnHbh4w3ckdB2XT2aK0YiDL++tUgfonnlRORwc+rcil?=
 =?us-ascii?Q?6y/PR6W+EpoKpe7vz2fKQIw+1+PYiNLv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RN8WADXKj5DzROMC/ivVBgOXIkJjsIFIkpYrW0BAmyZa6KcCCVvPiMM/Xe7u?=
 =?us-ascii?Q?8zKag1eKm3Jw6DEeXF67zsWTFY/O+qq+r4GWgDzG2OGSvy/KMOsKf1bdzpu7?=
 =?us-ascii?Q?zgKPNpcP5x/ZbZI/S1c648T+uhYA2REHA+V8odWR21RWl/ZcL5WfLa4k6syn?=
 =?us-ascii?Q?7Jklo6nQYtR/DOPuCB2acBEblBW6RjB0F69FlXAaxWTkhcnchbih+zpmkExF?=
 =?us-ascii?Q?hPVYVc8QXxES4Q5Vned7rjpKCnwMM6SLbjFIhbyKA3r80rrBopzYbBQY8JJl?=
 =?us-ascii?Q?+Mh/j89NOJ2ZyWBub7tPD7UUSdya3oQ5ElGvKWH7zZidLYk3fMX2ejKwvUos?=
 =?us-ascii?Q?kmjHmQXZv8miiqr5ISJWDLygtYXwdgwP2yHGSlZTqNdJu+1eelUQ6tUb3gSt?=
 =?us-ascii?Q?n7Sb+6CYSgU50gQsEOD86oprGYUZoThrEsYEhFoQhLC+IhC/9VSuSfuzH23X?=
 =?us-ascii?Q?hHW7kxuiaCdAtl2MYAcs+EKJuLQhBmO8CxK2OcEvVDpq9LAhselXBlad9/je?=
 =?us-ascii?Q?+j/PkDXKLAUroIaUfm55VmjFMInU8UN8xezrrnjwXFXF1Vv0X9MMTKGXHGC+?=
 =?us-ascii?Q?uwpvV0erqpjdy3LIsPTz+4gB7GBIqltcfuxOukRX5uNHgVOFd0nilJWogSlj?=
 =?us-ascii?Q?ow0P3MBXR4nGifJsrgrYwaY1wLMpoeATMGmexpHsGl3/JHN/pq9iNlcMR+M6?=
 =?us-ascii?Q?F7ArlT2FpL+/zOgmn2SZBLAHWsy8P29j32Tc8dTEQwVSB4VaS4w4hFPz7ap/?=
 =?us-ascii?Q?LpeLCedw8p5/jvZ5nizTaeFEtaTrHQ/mIpEUFEsNIL65Dv31mrLBCT+K9mCe?=
 =?us-ascii?Q?mGc1BUysoUmQi5or1oUDHSiLR4J1mBriXIaMM6RGR6P1wEpW+zmXHrHp3h98?=
 =?us-ascii?Q?a0xHEwHkWGAMcyQTLzjTrz40pUIrHsKcyHxBdE7VeQqbGR4b4nOTy2fFtOVN?=
 =?us-ascii?Q?lHNbuuixTtBwuEimKRwKYVVo/EgijC6m7KozoEBzLFWF6MyqJ+FK778K78Nb?=
 =?us-ascii?Q?YbLAmltb/ueGIaWm6GkkFd8HUdMBxhT6zd5KkLiriZBvd+9jmPBU6inE5YU9?=
 =?us-ascii?Q?n+MVyyjFk/zFKKoqiH3RV32uDoLlYlIYA7CwQbwdsk4bOTxM3XFeDTkpeEtL?=
 =?us-ascii?Q?b5GVpuIqbuJuFlI40whQk/eG+6lIZp3Uk41E+LXUhSgAiiJL+STNJf3mHd3w?=
 =?us-ascii?Q?x4uDbFECgZSdZSFmJ+pJ1knQx1HhD/tcLcdBCLZsmrCcyIoU2xYW/Rl98/hh?=
 =?us-ascii?Q?ntUQj3QeP15suKEWhaA8Nnwck8VCunUiFmK6ZYJDOaOnDMisTDlRfw64bz5k?=
 =?us-ascii?Q?z+MgW+qY9OtHPNGKFf3z+88iEbpjG4zy626L78hEDWT2LigDkY45os98dsy+?=
 =?us-ascii?Q?bjufP2A4x0udVQNg6CExDBegS3oFepkPJCQIApk7PGHybtsf0ZatgHVvAUhO?=
 =?us-ascii?Q?bAS2LEUsc3q1EoDvpUBEFTiQz9HOY17QGUUM8Lam6VAa8oqUpXq4KCrPJV+9?=
 =?us-ascii?Q?VUi3lwZr0b2qgTHySWa6vbr/zVUuteRBprdRyKEHnQezULeaFwFhXFSeo0vt?=
 =?us-ascii?Q?qp9P23wbpJuRSZ7ykbMMJGjBiheMP4A2CFSFORKF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ad2432-6728-47f2-a134-08dd66fa549b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 15:25:50.3287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Rk1wpBu9/EaS8FcTOIFQw6Yf2T/6H3Eo1COwzm0yJsTkGzbFGGf/3Kgzmc/B8sF/te7vjLbWHvNX2ZOjOdwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Thursday, March 13, 2025 8:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>;
> horms@kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 13/15] ixgbe: add FW API ve=
rsion
> check
>=20
> Add E610 specific function checking whether the FW API version is compati=
ble
> with the driver expectations.
>=20
> The major API version should be less than or equal to the expected API
> version. If not the driver won't be fully operational.
>=20
> Check the minor version, and if it is more than two versions lesser or gr=
eater
> than the expected version, print a message indicating that the NVM or dri=
ver
> should be updated respectively.
>=20
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v5: add get_fw_ver
> ---
>  .../ethernet/intel/ixgbe/devlink/devlink.c    |  2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 +++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
>  .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  4 +++
>  6 files changed, 43 insertions(+)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

