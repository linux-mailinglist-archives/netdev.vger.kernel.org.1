Return-Path: <netdev+bounces-293657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKuBBbZSHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:36:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88261C8EC
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09CCF300C03A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56C3911B6;
	Mon,  1 Jun 2026 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+Gxe9TB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BE390CB9
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306380; cv=fail; b=c4S2AaVmTL9ENlV0BAEjuE53BRrvgWWUIh1JvSNkNC3K4XFe5NcUdZ5F+S+DCMlTOyz45R0y8gDRDDF3Falp/EK/3hQg7+OXKSVxwxg3SwK/9VokKe1ADDHCnfzzuBXoCPXHhEAx++DZ7GCwVP0OgiMPu43ZcSy5pY+bsy5UrTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306380; c=relaxed/simple;
	bh=Ky7MK7XIcDqzeemnkhQwDth5JiCJAr+/KnxAYoL6FbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ckh18g1F/nYZATyfbJQRNHsfLzcBno3AELptXf9ELxe+hoL+FrQHu8NwviVjSUSYN9ywtmwDqzrk+mOIk6dcdFxBzVq4Zqo8asEcqoC0GtLe6SZjL/YAmOdWlOdOs3Qv9jg94niMDxekcLS0zwmUXTAkbgrDoGuA7pbH0QB9XD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+Gxe9TB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780306379; x=1811842379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ky7MK7XIcDqzeemnkhQwDth5JiCJAr+/KnxAYoL6FbI=;
  b=T+Gxe9TBndh0eqI045bkBtB4Dbwia5OfvrpX7QImqTGWztb77iuMCLA8
   YVBX5keEidOq4/0KJAnyhHHTqWloiT0Rkq3jSR1Kh/rKfuFG2QiOkHyt7
   Bes2PyAHdyreneSdsNOM/ZBO2b/kJWmwOl+5WUND9hsGJFulawJAHkFN9
   wKfM4rqRhMmIPL2zL/Fxr2OzATSSWB+o2gJZeyJsVv/wxxcgHaHRWwg7e
   coyDvpD/0yu2jUGqfGwg2ud6xAC3ypaQFKpIwBaTlZIHX3cEtxwz3EQFX
   cY+BeGD41AguMRvJpbhywo3WiNAykid9e5yC8yyMT/G7NJaz8Tk3o6fxE
   Q==;
X-CSE-ConnectionGUID: 91O6EiZGTgWy+XLYwGJ+Mw==
X-CSE-MsgGUID: wp6Dpz8zRVm5LnOX2Sm5lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="83638089"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="83638089"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:32:58 -0700
X-CSE-ConnectionGUID: 92cRXo7IQ8OO0gZkSYOmog==
X-CSE-MsgGUID: d4PKPjGnTuKkW082Vam7VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="240533721"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:32:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:32:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:32:57 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsyzZGPpFAe4Z5MADd8UV6aHS+fsMj9c+LVoh99uuV9/Dlln0PERjjONGGV82IdIx++ocitHUENvbQ30f/Hcv4XIkM1IIHdvXvb4/38QvFD/hM4Q+PrFvbHJ3Q7S8lNz7btLViNBbd9q6p9X/1mS3dCXJ5Iqcam55IuuP0k95gflDRMoLvQJExuGoOeLkqvdaECo8M4JSc8X2XILno5qJqhP9NCMdNgUiIkMrxKh5zrgirhitkPdIu9BOBom9LuugRS0hLWjjvpeYGwz4s7FmaIsrwbjm4roS8LrAJpydQ5Y9EfRNE19RbovXQa4U3A0IDwbSKgJdE6ivHAtg7YEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQrpFOZnXyRfmrULturDjSZ0+rewuWNTHjQB1hsAWPQ=;
 b=xgbFdX0RJWmxjiioPClJCiuESSDIEDteSDK+JbuMV3aAd83QOFcigKFAV25w4ZRpQX5CilkeVrJEWKXsUkP/AU1vkjR4UkFaHaLXVrQEeiUIf3t2KFjAtnZTsKxHztu7aJEP6rpRooG3AxWPJ2a0vESO8jpbqTsaRixN6JeLk2dN8PKTeMdAt5eUtgRuscAuBYFnVTPpeLvn53okjC9VfwuOz76W6+1p05i8bHf2PkOiRNuYhTcjX3xLTDZiRnVPfIVHf/LMfIfVTWFKfDKz6kDksmAdSSHXhHzVQsIYr+A5RfixBDwHtzuFuu4krCD7QCQn1ZR9oE2lNgq8RWLDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:32:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:32:53 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Ingo Molnar <mingo@kernel.org>, Joe Damato
	<joe@dama.to>, Breno Leitao <leitao@debian.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Johannes Berg <johannes@sipsolutions.net>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: RE: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
 callbacks for AER recovery
Thread-Topic: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
 callbacks for AER recovery
Thread-Index: AQHc8Ze5MGzF2VeuykKv6d+uDATdtrYpb35A
Date: Mon, 1 Jun 2026 09:32:53 +0000
Message-ID: <IA3PR11MB89865C937E3065CD6390FFBCE5152@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-5-jiawenwu@trustnetic.com>
In-Reply-To: <20260601072221.2952-5-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY5PR11MB6534:EE_
x-ms-office365-filtering-correlation-id: f1d8376e-ea35-476b-97dd-08debfc0c16e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|38070700021;
x-microsoft-antispam-message-info: WrhrWbtQiJRwfZhdlOd87aa7dPiQAC2kTv5B5ro4OY8cRiDajWKM1PvJIYp3WuMA2CNFxOlK0Wy8x5n/hQ/nAF+mVettByUS/MOxjyJBiq0moQai1HGAt34kq2J5LYSt6HOxIJqO1Q4uxQPkI1PrqQLUyVby83WUtX9Vq77zfFA4XOceVmyHHuCsnFobung3ihHQYuKZWhzwGj+8PZ0MUS9eXDKTWeev+s8e12e05Y0NYTP87jkMVjwc/LBojTBw+RQThLGkxhasuwBLUiau8yB18BRHyi17qaCSDpV8Q1Gsio5K31KtTbQXHC6JJz/0UAa7/akXcKXU7VXsF/xQ2+PQxx4FVEj9hz43DvgqmXyN8L43V2KL8awYHvXn1TSoCJA+gpR3V5PZajMEUXcbf8CxAa0mX0bce0+IITv3bR1c14sHa66JW6GWrWxD/4GbraSy4ktLUYIcaYLcqELUYI1iBP1Xt+8b7TSyBd/2UugO3/8yZ6I6c+ej/M6dL8U/wlyeoNarXSONVhaFYdgMZvFP3QAXe8cio9TvPIr4lkVF8VYkVllcwr21g8B70i2FVa5iBVLD0flbETdreOAKCwlSzxHnY2hoQQIGbqdDl3c4b/urBSrv2iqmbSO6yVfQNZeytkFNSRDv83jFAFKIpgmhQGfhOwhVVhmemmLXGRmivCL7/mtSN0xuhjGHOoxD649y8h/dLKkIgPDTZZ+MkMYP2uQnqLeZN13zCabUs2KkB9x/Y7qT451YTLaIax2T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wg5F5AvjKQIBoc+jAYWwoQdNUHK4BSqCqSIUt2wdW+JROwlzKGShINLVHu?=
 =?iso-8859-1?Q?LkRdUk3N0OMpAouFA9PqyIe1mYRdrFHMybqkBuYCzp4kaUDEOtpFX4lFAJ?=
 =?iso-8859-1?Q?LJ2/FicdAIEtLK26gP5iQ16kKBUMbLo2fOPKBvciVEY9Q/QYVyacsskqaw?=
 =?iso-8859-1?Q?Ytr8tO3yf4nH6vmydiRhK+uX9OdKSMj2btxOf5I4jyI2MSL5BopLdGOPxj?=
 =?iso-8859-1?Q?5Bl+1+RjvddlSxKOphRf6rVAyJH1is3Je5orushUV39FlHuzxlDCf6zasq?=
 =?iso-8859-1?Q?0puL6Dczck0E/F5N2ds+CpeJhQXGc+gfziPTA2CEqsVqYF8Rz/nfHV9So2?=
 =?iso-8859-1?Q?88ehFw4NTKo6N6hrNwzzahOv7824gp6QjeKMyYr5GXp4RxU2Kncjdy47zI?=
 =?iso-8859-1?Q?AfszcfA6n1pz2ZUNOKnsnhxSUXcOmYdg20Fpv6VmKpCEhoFBuX9g6i04aS?=
 =?iso-8859-1?Q?sUo9C3XqLLHx2GRzlrgOr2qnjyow91lsTR1HzTMD20DbI+Sy6VpNafrgf4?=
 =?iso-8859-1?Q?dK+UVGQNcK8e2PJVHdXpfhQN1WRKNxL8HAyxo4PkK699gKmkxQM3STj9S/?=
 =?iso-8859-1?Q?qlW1eW4Z6wSVCddHHUI+CSNKTl8GCdEwb+nPwstDwJr/wkaz4b1Iq3pl7R?=
 =?iso-8859-1?Q?GfHDno0YFynY5135GffOZ6O1stijLr+G/oiAIjaML4YniKuZfxfkqOzMNm?=
 =?iso-8859-1?Q?uqiPMPvyRFa7kFnM4GsV+/Z/v4XHyKVzbIBXwiyLsW+9KOeN+3dNy8lPjR?=
 =?iso-8859-1?Q?0hq73dRlxQshvfLsExUrukRGXuF5ptjg0y5ZvocvzaSVdSVAuETRy68/yz?=
 =?iso-8859-1?Q?pHD5gY3xJGjf7WrXcyga9DV4uTzMtUdPLSKK6ctpwJlhISU6+GNqXtueiP?=
 =?iso-8859-1?Q?FBSDYE1PK+P7QQtv0f1sU/S/Mha6Q85Y5ip+ufA2xhGMXC4RvRNWYGIXP2?=
 =?iso-8859-1?Q?BFjJSIh2nqVXAviPNTMehxOU9nHuZmQwAxRQQJiaYsdTtLiJGW2i2i1ORh?=
 =?iso-8859-1?Q?UfN0dkecFhO8xXn7WKqF5Xabip4IIz8x4eLaRKbAKlWAp1OnNFsiYgZzOB?=
 =?iso-8859-1?Q?wtHT0NQ0tc8U9DLL2lG8StEGCLu+wX83ZJCvumtdbFOcgTduRX6FO8ldxj?=
 =?iso-8859-1?Q?ip95e6mVSCbZx47j6wJSbyxV9dGKUtTMypiv7eBeQwcOBg6zJBvLkXYYI+?=
 =?iso-8859-1?Q?ltV9YutbzsPonAi2TN7RGz9hbdKa//5q9fqRp3pBNafd7ns+x122S//ggO?=
 =?iso-8859-1?Q?92Dc9ZN8j+vYJDVUPte/6tlqCIbN6wT4np3Charu1iMbGIdC+eFKyep5en?=
 =?iso-8859-1?Q?k73RSnmNp6Zso+PbdMeJOgh+oSRcy4xe7hHHf/aH55W5h04bez5xTKfZ0H?=
 =?iso-8859-1?Q?vEJooFy42E5aR7Vx++zIppkS2CRdvj5qVazG4ER0VVg8SW0hRm7ifEmFxW?=
 =?iso-8859-1?Q?MjddKk/OVd262nOOp3k9I0Aydq7zePNEMQaQdX5I2DRmhkbzjI94IHnvu5?=
 =?iso-8859-1?Q?qU/Y580d1n5ErV+oZ3uYBkXXJ7DM/3awZMqY0wL8fcmJdAmVvkS6kUy9xS?=
 =?iso-8859-1?Q?wjhpMc3/tEpg/CE+0wRaRBgS+gsEvdCJtox7JzqyDSYLECbHJc/aF/+m7q?=
 =?iso-8859-1?Q?nragRhyJ4xoXmjknNyq3reXtKQXmFeut4vOvR2Hbh0rfcD1cn7mgZr1n2b?=
 =?iso-8859-1?Q?ZhYgofr7dv4/axENOcxB/Ir4Yu219N3u94+WoFAWW35Q3ot3pvC2EL/LkC?=
 =?iso-8859-1?Q?DRKhBMMEzm7Ysx1GaSAoV4YrU4nkH/h0chuO5BFFNcFpX5sip9fZDtd2iq?=
 =?iso-8859-1?Q?QaOkim7zf+FQ5vn9p1Qm8fKYX9NSZY8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sqy49gGOR4nBYspEPuxCvI6cCh0bgjIUzq4x7NYiWD8BY4oY78RY8WiP3SblbWEE+S3wTfcwbd2c4OMTXqrnySXlD5vLPaar4Wa/4Mo5SHh21+BhwdK6Gs76MplB5qvPCsscB3ZD9mdW2yg9xqWWhZ1ar6iA8neihaT60+8yO/OoQFCYWiI33XhlJbzU7kZl4Z/pYDpCEP0YGUmVfOqy42TMadJ2F8MbWig2qKH9PnxZxYGLZ5aGQjam809bjs8sAU+cx2+AnnrFbSAViBl2J+YPR/DY5RKONc6WEewt6kxXYlaLvMpy4TD/6Vs4U0AInPHJap0R39hNXIPKS1Vrlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d8376e-ea35-476b-97dd-08debfc0c16e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:32:53.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+NXWy1Akb8ItHh467365q5PU8zr08jQ7QC3PjHFF5mRzvizW/HLpJ+o8JD5XMkz9rzjWTe22pRTg7PwHsrq8KUdv8n9KBHYn6GLe129O88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293657-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AA88261C8EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, June 1, 2026 9:22 AM
> To: netdev@vger.kernel.org
> Cc: Mengyuan Lou <mengyuanlou@net-swift.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Simon Horman <horms@kernel.org>;
> Kees Cook <kees@kernel.org>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Ingo Molnar <mingo@kernel.org>; Joe Damato
> <joe@dama.to>; Breno Leitao <leitao@debian.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Uwe Kleine-K=F6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com>; Johannes Berg
> <johannes@sipsolutions.net>; Fabio Baltieri
> <fabio.baltieri@gmail.com>; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH net-next v4 4/5] net: wangxun: introduce soft quiesce
> callbacks for AER recovery
>=20
> Introduce device-specific soft quiesce callbacks for ngbe and txgbe to
> provide a lightweight shutdown path during PCI error recovery. It
> avoids MMIO-dependent operations in PCI error status, for the later
> implementation of PCIe error callback function in libwx.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
> drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 23 +++++++++++++++++++
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 ++++++++++++++++++
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index a8b4e84787f4..1b25a52188f7 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1409,6 +1409,7 @@ struct wx {
>  	void (*configure_fdir)(struct wx *wx);
>  	int (*setup_tc)(struct net_device *netdev, u8 tc);
>  	void (*do_reset)(struct net_device *netdev, bool reinit);
> +	void (*soft_quiesce)(struct wx *wx);
>  	int (*ptp_setup_sdp)(struct wx *wx);
>  	void (*set_num_queues)(struct wx *wx);
>=20
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 3dc8342dd3a7..2484d3177034 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -47,6 +47,28 @@ static const struct pci_device_id ngbe_pci_tbl[] =3D
> {
>  	{ }
>  };
>=20
> +static void ngbe_soft_quiesce(struct wx *wx) {
> +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> +		return;
> +
> +	wx_ptp_stop(wx);
> +	phylink_stop(wx->phylink);
> +	pci_clear_master(wx->pdev);
> +	wx_napi_disable_all(wx);
> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	timer_delete_sync(&wx->service_timer);
> +
> +	wx_clean_all_tx_rings(wx);
> +	wx_clean_all_rx_rings(wx);
> +
> +	wx_free_irq(wx);
> +	wx_free_isb_resources(wx);
> +	wx_free_resources(wx);
> +	phylink_disconnect_phy(wx->phylink);
> +}
> +
>  /**
>   *  ngbe_init_type_code - Initialize the shared code
>   *  @wx: pointer to hardware structure
> @@ -135,6 +157,7 @@ static int ngbe_sw_init(struct wx *wx)
>  	wx->mbx.size =3D WX_VXMAILBOX_SIZE;
>  	wx->setup_tc =3D ngbe_setup_tc;
>  	wx->do_reset =3D ngbe_do_reset;
> +	wx->soft_quiesce =3D ngbe_soft_quiesce;
>  	set_bit(0, &wx->fwd_bitmask);
>=20
>  	return 0;
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index b37c9ed57cf7..816aba4a9099 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -296,6 +296,27 @@ void txgbe_up(struct wx *wx)
>  	txgbe_up_complete(wx);
>  }
>=20
> +static void txgbe_soft_quiesce(struct wx *wx) {
> +	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> +		return;
> +
> +	wx_ptp_stop(wx);
> +	phylink_stop(wx->phylink);
> +	pci_clear_master(wx->pdev);
> +	wx_napi_disable_all(wx);
> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	timer_delete_sync(&wx->service_timer);
> +
> +	wx_clean_all_tx_rings(wx);
> +	wx_clean_all_rx_rings(wx);
> +
> +	wx_free_irq(wx);
> +	txgbe_free_misc_irq(wx->priv);
I think wx_free_isb_resources(wx) is missed here, what Sashiko says?
I fill like phylink_disconnect_phy() too.

Can you prove there is no ISB resources leak?

> +	wx_free_resources(wx);
> +}
> +
>  /**
>   *  txgbe_init_type_code - Initialize the shared code
>   *  @wx: pointer to hardware structure
> @@ -412,6 +433,7 @@ static int txgbe_sw_init(struct wx *wx)
>=20
>  	wx->setup_tc =3D txgbe_setup_tc;
>  	wx->do_reset =3D txgbe_do_reset;
> +	wx->soft_quiesce =3D txgbe_soft_quiesce;
>  	set_bit(0, &wx->fwd_bitmask);
>=20
>  	switch (wx->mac.type) {
> --
> 2.51.0


