Return-Path: <netdev+bounces-257988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALjNM8xRimmmJQAAu9opvQ
	(envelope-from <netdev+bounces-257988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:29:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31400114CFA
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54033018753
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4A30EF83;
	Mon,  9 Feb 2026 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb6Vheax"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6725DB12
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672586; cv=fail; b=kIHh5wAPDFJlFK2CSabgu8RMLNi/i/TLTs+G5bhxO0F1gUgry9mVW+4jFeyFOK9TrIVh9/neyoT0aJQjNt6Ax6qfzt9B3Y1VAKk5LgUlU73klwaetkD92h6iYs84e/CwgtUA50Xu8u/nybgUeqtf5qHW/WDZbb4vc+P2aJnq+BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672586; c=relaxed/simple;
	bh=/apdLWmBHgL9mxUiZXyOwlQgCqTL3SO9JTNckYTolI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HBBfyLEVyw4ZqQvkWOsTtBMxuWhkFGKiOEAo2t5XUDA6s9CFq6bgwWtedbxWzFeE7mVd9FBwM6NdFFrx8ekaM4aDT3tP6svR8ZPrhZ07LnV8H9SxjHUxRLVbgxpGfcR+PgAhsy5/atk0T7WcdIS7kj1+ehURfRVcIG8Gg1Lpr/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb6Vheax; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770672585; x=1802208585;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/apdLWmBHgL9mxUiZXyOwlQgCqTL3SO9JTNckYTolI8=;
  b=Lb6VheaxGLRr6RfBlkukpndt0+80MII02l1Tx7sBzE5+0NQ5xVlZDIrE
   usly++9i8dxZJ3cEXk3JiFSmpn8F2p88muEGifp/uQyGF6+KJiQq/KKuU
   L8MV5y1v8Oo9cHF+3LnPdltpdNyNcHqVNdlodlg+HySLlnK5V6pkF+7xT
   1yW5Tm3XnBLtYI4p3seRCT1WuJUotdwFr20GTb54mDy4BCMA4Md1zaWFz
   3VaSI270mXxfi5cyyt/n4KSkGx+ndKplyAYJOwg2sB4F+xKnQaKtBo6aG
   +0NAN7Hw82JX/c1DaWK24TD18QMsm+z4fadEmN1bYp28sKxqES+5P5aXk
   Q==;
X-CSE-ConnectionGUID: gY+aKwUeQAmQnkkqsKOT5g==
X-CSE-MsgGUID: L9kmHXB+T/KeSzCa2ZAOpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82115533"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="82115533"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 13:29:44 -0800
X-CSE-ConnectionGUID: mZblqSTuSPes/xLxGtUwnA==
X-CSE-MsgGUID: AsUD4SG2S5SHN1VwTLFC4w==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 13:29:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 13:29:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 13:29:43 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 13:29:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU1npAsarJ0hHRCxMmk0AgQK8ew/JeUbj8+r6WPBTk3v0qcgKwCu1Qc0xpLhSIC61SSYXctarL8h/3ucNYWpm47lxiPxobf19TtecKsHgED9cGYP+zPPw8c3/RB8Kwj4cg8QRcb7/PlWS37/VqtBHYYgDw5F6gbhL1wO9dwJcN7KL1GVDlrcTpLU2Ogq6DkyJI4wCF7AkPSvaux6tRaqyCWWy3142BLovEF9zYyrE+6y71H8+ioTd2smo3uIaajJ6NXgu7o7cFms5eIma9+gsw0xd1ObRJ7hiyrsOa+ndIYkpdOlxnDEoquEQMyZ0wUlizSuj+JNOebnvwTgOSZjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1GIGXHDIioDeUlHlHgNyGQCxoIQ2G+cXcVvQxxruGY=;
 b=UH6LyX+0eyMOS+pQC6+VxYPLjB2eBr5LYZmzXgfB/lSaFbJgaq9I61VCopgN8JYi+aHwVtXloDxsgoFr0bYx1NBa5ofih+Z84WiXjGWvsKBtu9EcypAXjw5fypZZ5FKHDHWV4QrwDvbs4eFIiO2RNWhRkuYeyD7FQbgVvfVowJQ1QJFxNjT6Gbl0UAigafKZeoJR3rKCguCkcS2J79rfhF9pOmrddZBJP1OGPkpOgPVQbyrV+IRJ+OmAvR9N5U1097Uj9nP3VGU6wz7jjjMOzXlQrd6fy0rflKYKJPlrSrDGT0Y+LjGtjXRgeRfgGcBV2aBu8UAzzdX8LIIRtJEnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 21:29:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 21:29:38 +0000
Date: Mon, 9 Feb 2026 22:29:30 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <sdf@fomichev.me>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: Fix fragment node deletion to prevent
 buffer leak
Message-ID: <aYpRusvnFvzCmtpG@boxer>
References: <20260209182642.237904-1-nikhil.rao@amd.com>
 <20260209182642.237904-2-nikhil.rao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209182642.237904-2-nikhil.rao@amd.com>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 534072f1-2c42-49da-a161-08de6822544e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MpgFDaN6sFwJbMJ545QNp2d2vhQG6DBX0fKwfpcejeiiD9rDSHXB9oXHbCY5?=
 =?us-ascii?Q?vmT0w5WBNNpzQmRDf+mupctlqGDf5X0QZUQ/GCaUIZOizj81Iwzw6I01lAPC?=
 =?us-ascii?Q?mqGEDCo58uf2gpAQt8xIdAEztKUudnC3lVCC8YylKE2qUf83ZjZhOp1rSgse?=
 =?us-ascii?Q?7V1lqe3ngNtkiv6X8rVvpsDjiM7+x0zT9HcxhrF5Xmg5jJOlKxnDSRfIHFTe?=
 =?us-ascii?Q?uqIz+IezKFQiA2dBppJXBkVk9mihN26uvKC1Go8FK64LRPXeSj/VLpjpnzv7?=
 =?us-ascii?Q?cpDFaOKnBdQ0AjWKEi9V23tlflyiUDlrfoJ+1BIg9E0Ir2CEFPqMIWHjGrTV?=
 =?us-ascii?Q?Efw4vkbo8HaYuIrNz+S8LibraCw/6dFIBfm8btwSnROMAglhNyiEevn8Q5bZ?=
 =?us-ascii?Q?J+RLnEG61Vx6b1keIg+AgBFr9Q29PT0QYmViKZmt57GwoQZShDxPZvzdK9Mw?=
 =?us-ascii?Q?QwoEbafZN9mi2A2865TkTAHCDXsNYgq9mFS+vFhfhj1/WtbqDSI8OYwD5Tx8?=
 =?us-ascii?Q?5aDLWkwqTO0FP3LEDG2em16q22u/Um9J+01FLADTcErEepQFdJ6aAyQncQA7?=
 =?us-ascii?Q?5/I8KLWbPwhSIg+YNUn9EkTNaaFCglHMybgISXwR4qik+mILTTnawfdZfRnr?=
 =?us-ascii?Q?uusnnTrQGz0gpZG0X0ylHOUw8NhFZp4hbS5heeTdtKO+m2D7jM+Vummk7djQ?=
 =?us-ascii?Q?BJAvFNLEs3GxxEDC8FzeqG+UpN2Pl4IQX328SguazKV/ho/HXLmVPAA7aY83?=
 =?us-ascii?Q?f9YYvd6rwGz5I1Q8G9HJ2Sz898qcsbHSF7VI2j9sO7QlDsRobJU4Nf0w3k0R?=
 =?us-ascii?Q?A9z+yb5BO6OIPndfnXn7yApWfkwFs7C5TwlUzje+AkDtrRCouO5f5FUXwoIo?=
 =?us-ascii?Q?ElhYVi8lvVhLu5dEjd3nURuLAh2eTSRQdbOxUZ38f38C+9c1jJBqElpbfP5k?=
 =?us-ascii?Q?pkPt8P8OoBLTN02KpCSldePDRYntGG9QifrAp7MKnQsUsWDQHVCNNVNSZmQF?=
 =?us-ascii?Q?r4pNFhrJdyoIl1PtF3XHuezIBRbczY93IdisCJHVEs8TwS4lxdXRxYyCoWwv?=
 =?us-ascii?Q?7uVCVyCjomOhxXCvx4VXqbbC6uZupVly3ocjoSDjLZ4NuC+0pVrFZmm+8J4c?=
 =?us-ascii?Q?oracsbO9a9WjKbQVS1xTQFl112ZXhuB7A+3cQGVPHBbe42Npzn9mcgY4n4nl?=
 =?us-ascii?Q?nH7D/e769qa+RqAcQZzR3IpPwYKes6mpM+TpPo2O0+d5UcbvWuz0oYmq01SA?=
 =?us-ascii?Q?PQshj8FCUmzASOCmD9tbvsACwXyzSLefFnRgd+elrDifPHb3sjMM//t8CkmH?=
 =?us-ascii?Q?U2khwopyJR3B5Jyse1KKA0Xmrx0L+GPbnasMITCs3CkVPhoXv+wH2RWCxSKy?=
 =?us-ascii?Q?pqqA5xSZr79H34mccwsWJ+5ooutYcmmkTO5jdGbfalqgppo5dVpu5d5VW85t?=
 =?us-ascii?Q?u8kxSDIpa6NE/NlK4hklF2ILvyPjMzAr1cO488n9eO2ry9D3WHRZf0RiomM8?=
 =?us-ascii?Q?F+kHFdOvWFGv4ewqAgJZHzLfticW1rw3X7Dljqd2s16gvwlXVOsP5WLe4iEG?=
 =?us-ascii?Q?a8cz2Ze+UZMGylmAFsY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpTMKlI4VWmhlFCrWftr83FLxI3MJ0x1SN+OpkukXI0ME8M1+dcgq7y/HrfC?=
 =?us-ascii?Q?D++hHmR/AvYcQHSwgwge4SoQs8moLyspLXp8c53JLrFsmuDck4xGG7SY4KK8?=
 =?us-ascii?Q?bwZIXxh3nDas7W7wDbzepf3wK/e5SV5NL5R0ChN068pEN0xG7EGaB13znxw3?=
 =?us-ascii?Q?Pntop9ylLNKMMWzjWbdzKo/HfZJsN6uu5bP+W0lIgu26HB2UbaEyhdygl4rF?=
 =?us-ascii?Q?4L6YAebk1t0mypSjV6i2AL7nSNDPNDKgwmqEnK/daQHHfQcjya9ukIhNNfYM?=
 =?us-ascii?Q?YPKpaHPtLi5Kztz4MEoCouz6TJ9liCTOLDF/AATVYzWo7EpqXZXZ9TyFq5wx?=
 =?us-ascii?Q?llaiQ23Wc6vfeiBQU8BOPafrya5qX69c1OGZDGasgvUbSec9kzubNVrAwWw5?=
 =?us-ascii?Q?iwesZUmeE9A5wh/7e7vbmEMhnHsRmrAbqbgSCVOu8EIs0UGt7UkSYYjN5ZbH?=
 =?us-ascii?Q?zMD4jc+dcG+XcIMjt4j06kPPIPPeDiz2fjzNvgM0WPwDiEKplj3hDVgxR9my?=
 =?us-ascii?Q?bxJ1jQIEPzxUgX5Eke5mUGOLvLUZrUwoqD+aKLC4mYKAX01KGkDLtoAFMX2I?=
 =?us-ascii?Q?6lYuHPLN7c4dxAU6ixYKUVmFaVrTvru8vRZE7qME1UwQxwAijW7t/n5+jfNO?=
 =?us-ascii?Q?HRSQznNDkh0GlNDy4IQRU1g9eWXIjczemMUa9xJp8c9JcRdnZG5IkBAELLmt?=
 =?us-ascii?Q?TPJfd0I7mNiwB/CZTHQ5u9+kHgZ75I7y2kvcQE4GXxumpYYEIUyTNycLZB6S?=
 =?us-ascii?Q?X/W/ltsyuR8i51sKdcqiFGEDbzewCJtWz8yJ7o/Dg7kYzQ/Ms2Q7dOdS4s1+?=
 =?us-ascii?Q?FTA0T4XQr6+xZdYDE+BYpooA7cN9iGEprVstmhIaU6J4kbVnAkk2a9QKTfPN?=
 =?us-ascii?Q?Mlm2A07nxosDB1hDXsff95e+mR3AdyQJRLBbEzq5pr5OAmpL69w/KAimcPlO?=
 =?us-ascii?Q?yrgt0LKsqa5yUncHrjvzpUsndC5e9HvrXZS1hRW8zkP8YwqjoK4u8VICca/N?=
 =?us-ascii?Q?3PMNdiLs5SSTfxM1Uim/twxqjDQf6goK+k+sE9B0ZSCWw2FwxczC7C8odfTJ?=
 =?us-ascii?Q?oUtWO4pqJzlzztYjLcKfnwag9Ey/7X3SgjgwhE45FMc3hYi5MvSdKiwDYm9m?=
 =?us-ascii?Q?z5h2kLTOe2mUhTPgX85NwAvCdkvDRBgMEQe8rLKUCm3tlphAN3PVAiv5q0eV?=
 =?us-ascii?Q?dqEMJGrmqBDn4EeJVNlENISXoDr7w5s+XPq8gnW5kPXTwTjZ7fWzB5yofEBa?=
 =?us-ascii?Q?MB6ODN7tle+SDoT2AArTHc0bpv312MCtwMMqjDJ/yvkIQGeznZXKMy171DaO?=
 =?us-ascii?Q?nNTcBIqvb2KOSb2RkPVv9fSutQGnoyiMB0ZGj4O0qytbN0kADC5ZbDrJpUvC?=
 =?us-ascii?Q?oXEOpmLocRGUkFaWWJwC/Y6m1DhZn2uGF/S01GVCHDiWEuyWcY4PmJSEBDDi?=
 =?us-ascii?Q?52mza+EUU00JwpslfP2fuKk6ZUSYay+zkpa/slkMEb7BA0GMQQhr/z5dQlUB?=
 =?us-ascii?Q?u8ZqKcqVduECBp3q6ynsoqS1/zHsb18QYvDlxrPh6dlQvJAkX6ny1AMVU0yN?=
 =?us-ascii?Q?NCPYKAASmCEXd6YGkcDmaSBFunrtw6XuKF3NjKNOtPhdJar/C8zQ25IfMdor?=
 =?us-ascii?Q?Yg1txexu863GHJZis8cNLhlZFiPgEgyl8sE8wQricwIOUgb9dyejAdfZheIL?=
 =?us-ascii?Q?38JqmTQKlyT0E0Y7P47tUgPt5b6QRkmVMxCjUC4CcI2DjIuJo5JYWxVUFzRm?=
 =?us-ascii?Q?USQeKcozPXz854Svf5doYH0FzKD8yus=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 534072f1-2c42-49da-a161-08de6822544e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 21:29:38.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/mmhAMbmuodd7i132JB6DoPu6KQVUgbppYN0LpZKqqGmpdGEopOlLIEVY84MvYCLdzTg0Jphfn0j3a96KODNBvV6g9hymwcMfC+fWW7EE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257988-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 31400114CFA
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 06:24:50PM +0000, Nikhil P. Rao wrote:
> After commit b692bf9a7543 ("xsk: Get rid of xdp_buff_xsk::xskb_list_node"),
> the list_node field is reused for both the xskb pool list and the buffer
> free list, this causes a buffer leak as described below.
> 
> xp_free() checks if a buffer is already on the free list using
> list_empty(&xskb->list_node). When list_del() is used to remove a node
> from the xskb pool list, it doesn't reinitialize the node pointers.
> This means list_empty() will return false even after the node has been
> removed, causing xp_free() to incorrectly skip adding the buffer to the
> free list.
> 
> Fix this by using list_del_init() instead of list_del() in all fragment
> handling paths, this ensures the list node is reinitialized after removal,
> allowing the list_empty() to work correctly.
> 
> Fixes: b692bf9a7543 ("xsk: Get rid of xdp_buff_xsk::xskb_list_node")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Nice catch!

I'm curious how did you spot this. I assume it was a mix of XDP_DROP/PASS
action returned by your program in data path with mbuf as that's the path
that was affected. I wonder if we need to come up with a test case for
xskxceiver to cover this?

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  include/net/xdp_sock_drv.h | 6 +++---
>  net/xdp/xsk.c              | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 242e34f771cc..aefc368449d5 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -122,7 +122,7 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
>  		goto out;
>  
>  	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
> -		list_del(&pos->list_node);
> +		list_del_init(&pos->list_node);
>  		xp_free(pos);
>  	}
>  
> @@ -157,7 +157,7 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
>  	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
>  					struct xdp_buff_xsk, list_node);
>  	if (frag) {
> -		list_del(&frag->list_node);
> +		list_del_init(&frag->list_node);
>  		ret = &frag->xdp;
>  	}
>  
> @@ -168,7 +168,7 @@ static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
>  {
>  	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
>  
> -	list_del(&xskb->list_node);
> +	list_del_init(&xskb->list_node);
>  }
>  
>  static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..f2ec4f78bbb6 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -186,7 +186,7 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		err = __xsk_rcv_zc(xs, pos, len, contd);
>  		if (err)
>  			goto err;
> -		list_del(&pos->list_node);
> +		list_del_init(&pos->list_node);
>  	}
>  
>  	return 0;
> -- 
> 2.43.0
> 

