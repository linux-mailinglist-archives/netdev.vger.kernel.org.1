Return-Path: <netdev+bounces-238211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD99C55FFE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A6874E1C24
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B83043BD;
	Thu, 13 Nov 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5dtzBSl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AB26CE39
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763017670; cv=fail; b=njumlVXXfD3OfPFu9f1ZhBHOp0LileoI+jNfIFW9WCAh4l3UVCU1wY/mTkRiynpc+iYKhWbPTFxpdakx55eH2ou8+vferKW3z2d5/0Ez/1TfjqcJFP4rp2JXzNYoaT+2hzAxWPcbpbhZg0ObBa+0A/1HUPphHureKzFEDcKwrqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763017670; c=relaxed/simple;
	bh=T3TS43f0nIGbAwe96XfeHBRgIahrokBBcLOSprVSGC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odz1aqjsIACtRZsB8Bw94uZX5jefxFydTtkTQ8U1y4Q+H73PpDq/0Ix7KLn9udzpiS+PZC8ZfG3gxD58CgaA+K3cKwUVCnw9YPom4bgzMyE7tlJ7uwuqXJ1d3z8mE+/Ne7FA1LBazxq8vWvVLRkZ+015ErjyvZqIojAVYLr1rTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5dtzBSl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763017670; x=1794553670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T3TS43f0nIGbAwe96XfeHBRgIahrokBBcLOSprVSGC4=;
  b=M5dtzBSlDjaERoSEKwkhHqrjSIvukd9wjMICvhr3MDN1H6Rrp2aGQAs5
   HbUrAIk6ChRc57KBHkbGpRzhpaRkAYtAwBswM8lzKOsxpXQZspCuzXYMT
   IIteCbFRFM/Ep+hhZXBfe1XMlL7s2gG8Xa5VJl+EIniAB2WIsRfNxIAnY
   KMxLnJyNM9r8a7Py38ibVB7RSCvubhNbFZaKFYZZ3+Jsnkn5PntLjKhZS
   2UC11zDK8Um2VPbrTJN1aj6AGu5tVpReBg/XvKlZ5o+nVPKYjkQjFmHUO
   RZK4JjdIbj1ASzcBtPe5PBwTjwIo4sSq3NeD/7WTmD9Ji49dHOQEtQd+8
   Q==;
X-CSE-ConnectionGUID: RaB6U7YuQDOmYbN0rq6Mdg==
X-CSE-MsgGUID: 1PfY7idyR+SJyHgYnzRVgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64976067"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="64976067"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 23:07:49 -0800
X-CSE-ConnectionGUID: nA7ecJobQsOMLk/pnpI+Mg==
X-CSE-MsgGUID: lEq1nmyKQ0mCWk2/JoF6+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="188713200"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 23:07:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 23:07:47 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 23:07:47 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 23:07:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAk6AEy0bl7CZp1Fetk5J88ft81q8N+aVP8CBjgppqFeJoh9KSfIQPyPEAjS6KxC/KDMUXIhx66X0cOjhRA8BwAEMIF3HeH+RpGKD1UpNJIf7ybpa4Lwp9tYpwe3BKdtRFRyxSEBh27bJVp0QIX7Wp/6rS5C+mBFnU4KWPTiaptGA2XJddC8X/7TNQ35mSkWqQvftkdqUtdddpbbxGqLqreH0G5DJ8ECOKr1jKnFTzWxMqQqcW3mFrDSzurE3hSkMX6v9/s3dwv2FLHoxpKe4Ox/mUomf4OFW5uDCLDbOumE2PamaY7R/ZhiVDlWdm3U2rl56ekTeD2m3Tb8MNSRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+ch+iKIuJi1PfxGBCihyBruQTyDfFpJJ0mfYjMAjWw=;
 b=HAiSIk7NCiMGOG/SclfUYkKIK15GEmADdm1Dv7kb/1fgtcFuBGI6Eno/Ggth3dKUIEggcrvAk3GbUkGl+cCmxlGHbeFutthzhvRhjK0nCgr2fJrnmwWjTBB4G7PTj+Wg72UOyrY80e7iKDlU5LZqMisqBaYMYR8FrAy7iX3A2zdknn2rOj10OKXm7uFmKaUlZFWt1IbEUjhJUuNYd92P/EJ7yFmgYjrvFDMwovOSeJ2xt74oXd04jnOky/IBz/NNEPAUJu1lgQy/F8GBhEDzuPvX1NZoBPThfvK2HI6vRiX3kuYQVqcNgsHn8DVVG7Olpqnz/yZxCBQy5Y7J3Tmjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:07:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:07:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove vport
 pointer from queue sets
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove vport
 pointer from queue sets
Thread-Index: AQHcVDTkLmAEh/2jYUWqTL5yMYBHQrTwL4lA
Date: Thu, 13 Nov 2025 07:07:43 +0000
Message-ID: <IA3PR11MB898661799F6FAA57927D1A45E5CDA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-8-joshua.a.hay@intel.com>
In-Reply-To: <20251113004143.2924761-8-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8363:EE_
x-ms-office365-filtering-correlation-id: 930185da-c82d-466c-fea2-08de2283578a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?kD3l4kvA25yOaL5pJRTb4cYy6EKdWQrQWyEOHjxXrlmEs/cKEwDM43UlCLv1?=
 =?us-ascii?Q?K0fYJILNjdpasUk6vKl8C62uNTpSU6bgnCkl0xuq8p5iq+GgIXw2OndtY2ts?=
 =?us-ascii?Q?rMeGw3uGqjbO6I1TQwfy57cysQboHT/N5u2kmOKKw2uA6Fnwy4aOXjf9gJnj?=
 =?us-ascii?Q?s5IcQ5D74WAVkoFetDOPuuyhpLLru/SuU+ctmTOWM87AEUgSTxjP7A4mkqA5?=
 =?us-ascii?Q?tasqFUtccwhdEls6qE3DI/U7ee3qLb4I8e7hXFrljT7FoeS5nWsDxyJsZrcf?=
 =?us-ascii?Q?eLFkBWEnfyg1mRZ9n0qnOKz+qnNX5QGH1I9s9a2XBkHoTWbwBCog4DeljgMF?=
 =?us-ascii?Q?bgQCpqW006I2SkMBREUGOzcivxF0UGoGVdl7rWaZbz3s/yoYVHUAKRFyEmoE?=
 =?us-ascii?Q?U1CVnUA94wBZGBWgP6iSuAuZnW3ZQuPduVL5SjuAdHVN3AXmoz7DbBTlxi1b?=
 =?us-ascii?Q?0gc9esF9Qw5d7toPUljR9Lc5FHoBgDZKgiyDYpSJeFFinKqta06+vEPrpxQ3?=
 =?us-ascii?Q?RUU8OAcfl1eb53IT9aPv6KByXcUqLS+Jv6f3cteQRl5LP7SsVFGnNAFwcwFa?=
 =?us-ascii?Q?JPcX+2Md8/tM12ck/d7MSnuo3+n254XdLRR/R5//BUAWaZCUQEzaZVZoD2nt?=
 =?us-ascii?Q?lqWSJJfJBF+km67ima8X1+88vtB1XFZnXg/zNHw61zkt+F8jOkdMfdIt0khx?=
 =?us-ascii?Q?G7fkxldt0C/TkN8U+7qzM4K2TtoJrbbTXIFHBasQb+aWKbVd91v1LrvgHk4k?=
 =?us-ascii?Q?6g1ruCnIBkW4cOn89Ol1NUQAG6KWRZDKgyRMKsXQjdtOKtST0JhcULPdxK+G?=
 =?us-ascii?Q?RizS6JkVyjyAYMCKn+75bCjCr2m2WRoSd25mTH1qipLgFXsZaGWXOluLVXEc?=
 =?us-ascii?Q?no0SzWKXl7OollrTPpwNc/LMf+nf/WWi2hXIoUMWj9O0c4mXiShWg5CIGj+B?=
 =?us-ascii?Q?iXdWeld7U0fwr8dqhPX3rM0M+lWELIcW3kfFJFODAWSV2jS+F+Ml7WrC/Rum?=
 =?us-ascii?Q?1pkLnHISjO9rWMyoiUjexOpKnUfIE0egrgokLy43VIrnKE01/n5359cOYgmp?=
 =?us-ascii?Q?hnIzsGnbuwZDpnK2s+DcrEHrSiy3ISbCc9QCDjReYY3Mw3nkzp6uFwgmwypZ?=
 =?us-ascii?Q?x/IK7on/RaZosTTlwRzKD+xfx1hdELsW3/c2kITCSNLF4Wvy3x5At9A5E07i?=
 =?us-ascii?Q?7EfXQpY2gHz2klvxizsRrEpYHxTDOuqQtFPPHFn+hkEF/wawsgyS8vUp5xxe?=
 =?us-ascii?Q?jCQxyn+9zIgOuJb6+Uc6J9fHfZFAz4rM6tIQ9cwevM663wrQSzikhG6bnJy2?=
 =?us-ascii?Q?/g+ovjGkbzaa5F9J3f+l3+3axDOY/vQTpR6pu5uXYpwe/4zlqGx8OCU4Ym5y?=
 =?us-ascii?Q?R/Kj1RRTqZ9r/Tm33TGKUj4pH7pmIW6tKTVTPDPUMfz9SwCjtDT5Az8wypVm?=
 =?us-ascii?Q?HhuvNFRtVr/7hDaXOjUYGyMIff8AkhGqm2N/L6DZolljPEAW4yCcYfVsyJf1?=
 =?us-ascii?Q?QHiiUUK4Rua98aGo5BVLVuCNlAcHBZP+5Tv4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5YZbuqynLHWbtuSxIQCZxhk6eIPe9EMQ7PkR7C7KhC+mda1H9k5ZpjjonRYw?=
 =?us-ascii?Q?25d64QQoRZbH5Gdw3DCCFV8Ubs84VrhuRSlwG4Yh68fLJSpmmPCzqtOLPOOJ?=
 =?us-ascii?Q?1RXPFoUg7YbmRCUlzY7SGiQCJcKo7QB6F0BQHk74L7Ba1F52AR5CWjTX1gZr?=
 =?us-ascii?Q?J00NM/qoQxJKZzRA8DEJbutRn5xiGMi4DNL2eUhX5T5F4KkZ+twZDCnn12/r?=
 =?us-ascii?Q?nGfyvP2I2ZSsM2FVFtFL1w3LsJ6nKt4aEdCZLWSIsXoyIm/rglINZdVvH44y?=
 =?us-ascii?Q?lkNcjhu+IUQ3MOXSmS0L2BkVA6CP9RcBuuWVyHKSZ99cDWmu5bB6kLybKvOj?=
 =?us-ascii?Q?s7ZmwVblaA8Pq8g7Q9otDd+lGQfohe6HfrjIi1qhNumdKb9xB5dBflHxN24x?=
 =?us-ascii?Q?RhmTZPOMaIe5pg81X54mq14z7Zhkd0d3FAD926jkNPSJnxQxn2mfHgPSiNMU?=
 =?us-ascii?Q?hkhxtEawwEKKYZ3L4OsEUm3aWShLL0EOwgabQL3z5bdbMKkDHpZmnrJhjxDS?=
 =?us-ascii?Q?L8alJAsjUFTnVBwnxeVkatpyyekew5ZKy+B7/Uzcg+UtA9OB9bIBGsd3VSS0?=
 =?us-ascii?Q?r9RjTOsM0GodAxkgDBs5waEokSFVtaYl6S0a1roOAMR4r1m5/7/FvRskXWhS?=
 =?us-ascii?Q?RpEnIxba3giB+5CTuWYlvDpbdGkxYMbgw1isbpPVQVqOgIZGEMRR2TL4M2Bn?=
 =?us-ascii?Q?HQ6CqYrmQBOKvAk1NRwwtKiv/Mr/42nkMf703iQ58KEOpoYKnUEJyQZUmHAz?=
 =?us-ascii?Q?b+tTGiQswyIYwvgmg+LS+ytaS/INGvAeUeDP2J3a0aX31mHapw48VKFoZfJU?=
 =?us-ascii?Q?jqkoqwuQqxJioTeoOnDwNvfURYjeP1xfcJkjJBkCdY9Loclf9i/9HUsMGkGK?=
 =?us-ascii?Q?9lTiUF0J4LV0Lnvd2ERbJ908KiP2eLEpUaNtbLCsK8bMWkosL5GNX4ulQ4im?=
 =?us-ascii?Q?gQEcfOUZvcWajQDRpLuMjQ3eql8j1P2Mq7o8qbyjSCZ4parQm+pYrab+279D?=
 =?us-ascii?Q?vbKcPtgtCdj5LnsWWtRVq0cKStolQUoKRmTcgWiCm0o1phst8girZghkcg+F?=
 =?us-ascii?Q?tbjj40ekZ++pLE2BMDlxCBK9OSojoi2mvWzl50AbzlQjujTI7rs+S9i9yTCr?=
 =?us-ascii?Q?8f3yR14RsjuFakD7c0iaoQ4vr/M003nLfrgRZMeDnszAXjBaU2VUQdQ6CxFq?=
 =?us-ascii?Q?oFsnU2RMSj4UIOOnaZiBpN6CMz5Ccj90p/NJw74twiS3/+haroT3qPpGI/xi?=
 =?us-ascii?Q?1FC28jCsD5RtxjeIHnT1O+nXQLj82F9wPbXLxqTCKk3RBNSyP9MFl1Wz3cjs?=
 =?us-ascii?Q?N5P/jks3DYfKHGr7xbOIeQ+1S9Q2izM7X4b8vatrUmahF0brfnyw/pMqDtBV?=
 =?us-ascii?Q?wraWbL3pk/fFq+B6qIm4LThrKZIKouAP3Vhz28As5iewClnmtq3nCtQud91Y?=
 =?us-ascii?Q?Ko+2IEWrn9k+YKaq0m/uIv4YaIOHpUIEJBX2T6ZMjwahHoTWFoHovzlJ6i1c?=
 =?us-ascii?Q?TRgjEeO8MZzwuzF9FpmxB6Kajg+Io/xwsFdOYmmfVdYw8YtJnwdW/3mrmPTT?=
 =?us-ascii?Q?Qts6wZuEwuG0N34v6FGsKAFiGaOibmxCCzwD1kXhUtdawx5I7kfduvXvt8CI?=
 =?us-ascii?Q?rQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 930185da-c82d-466c-fea2-08de2283578a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 07:07:43.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hu32B7lR9IwojqMF6VZlfgLrIv6gTDnH9IRYKQ0KL6K228Jh7/KAR+9aRb+ao6Q9BL1FUHA3YFv8v7aJjIE87M2rjw5OBwR3OZY2gwVZ4qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Thursday, November 13, 2025 1:42 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v10 07/10] idpf: remove
> vport pointer from queue sets
>=20
> Replace vport pointer in queue sets struct with adapter backpointer
> and vport_id as those are the primary fields necessary for virtchnl
> communication. Otherwise, pass the vport pointer as a separate
> parameter where available. Also move xdp_txq_offset to queue vector
> resource struct since we no longer have the vport pointer.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  4 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 41 +++++-----
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 78 ++++++++++--------
> -
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  7 +-
>  drivers/net/ethernet/intel/idpf/xdp.c         | 11 ++-
>  drivers/net/ethernet/intel/idpf/xsk.c         |  5 +-
>  6 files changed, 80 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index a86791b0ca2c..9fafe294f5f5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -305,6 +305,7 @@ struct idpf_fsteer_fltr {

...

>  /**
>   * idpf_prepare_cfg_txqs_msg - prepare message to configure selected
> Tx queues
> - * @vport: virtual port data structure
> + * @vport_id: ID of virtual port queues are associatd with
associatd -> associated

Otherwise looks good for me.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

...

> --
> 2.39.2


