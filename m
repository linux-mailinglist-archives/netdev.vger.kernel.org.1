Return-Path: <netdev+bounces-76542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8286E172
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 14:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D461F22030
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC53FB88;
	Fri,  1 Mar 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXCtkj7E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FDF1EB3B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298125; cv=fail; b=qjaYo9EI8/PHDIDNkUSQKAe991UX66i1u59AcvDDt44sV1Yv4nF8NXxJpvTfdhxMAhK+VY/vOjlhmKgtud6buu96zat+z23qVVvJ9u660pZ7RgTNSFWe2F1SnxPR6ugDFqIydkhLjNxqdA+FKjE5mA9aBQ8aEmH/OBEX6eHppAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298125; c=relaxed/simple;
	bh=E6myxPWn0DsdmsANil4fRk9+dO78wRzSFhmTs8i05sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOnMtnrCPOy9a4qxaaX+UzqFonow0olsPp2ludQi51OjRKlIcz/hMRpbQBZ0QbkpdhFkeo7uvXbfYSp3m6YUIj8unlFZd7gJ3YtG6sFLa/UE6Zatqv4fpa/XvGMRZGsIZJXSn+szDodgtriOaOHfaeVTx/sPpMDF4cJU+Fjezhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXCtkj7E; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709298123; x=1740834123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6myxPWn0DsdmsANil4fRk9+dO78wRzSFhmTs8i05sk=;
  b=LXCtkj7EHxd6Cte+338+MW7g4efFfKY6L2JaJiF2sFawCL/8NySn7s/R
   vO2NedHiR4OCvsljNX2QLLFEWuOjAW+d135f4OaH1jmp5Q1UlDnCmsbLT
   v67AALNZuJGCcLS1JwOfeIS8Pn20QTNPaAVEFZ7O5IQ8kyB/SLXbQEEyC
   VMzpnwFE7ANQB21r4ULhAn0tvsT3wewM47IEXVQHAZ08elD8GKCdTqqML
   ZH3RmpCRx/bthbwqb+1m+ueNsjghvpNyxP4g1Gbj7dA84vhnlF+70Y8C7
   b6k1W433hSCEC9OE+gGmPfUED+Culiink+DRV1S6848JLs4YjFAUA4+xz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3698087"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3698087"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 05:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8598122"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 05:01:53 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 05:01:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 05:01:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 05:01:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMhLAn1ShRwrS9PvbQMmjpidfkksGlAyexMDutrPV7aJT7l0dEEfThXtNXyFK3gddPVxDQFC4sDAwvmJrOI3IY0nAS+mOsDS6l16qpYdmcPRVlEF8ya8hPr4xtyJvWNInTmvEfir09jrYHKsr4+lA/UH2OZNKtWpgbIuCc1eWWXpGFFIiIXthlS95B30CoVVSvzvt2LE2xT60jfBAYL/hO9T7foJQ3SqwirZlD5AuzeQqd8W52/loDNFEIyANKqOdlFDFLQJFR/zbS66HRf7ipnQQ0AXK31IA71CVVQrrpocP/xuzWk1AweOo5LHPQ2u3CmcSv6LV1gp4DFe/AvXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6myxPWn0DsdmsANil4fRk9+dO78wRzSFhmTs8i05sk=;
 b=XkO2qfkuPRIQRw9nAxCk/A17o5djsx77RII6jBpIF1AWZFwOqKXVovD6N0ZorAErzevBFMLHSdSkwwYkMYMdllJlapXUJJR3l8X9lxqiO2ne+saW/Ybx3Bb+O+D+L3kTlMmThys+xwbHBSckNY3gXFGXYq9iCB6xXWv/67te3UK0UyrcMA5xh0GX73wVUV59zCbzU+HV/uHhZKHe6B8w0pn23mfkJTUY35htJL5a2BoAyn/2a2fZJ9XOl4FrpzUM9qOb9zd5KWZtJ88xu18xOPgPodmbh/+P3C2gaRBKZU8ln8D25A895nhBurnrQHLsTxBe2c6N76OEiW5PTDEvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 13:01:46 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::d738:fa64:675d:8dbb]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::d738:fa64:675d:8dbb%7]) with mapi id 15.20.7362.017; Fri, 1 Mar 2024
 13:01:46 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Pavel Vazharov <pavel@x3me.net>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/3] ixgbe: {dis, en}able irqs
 in ixgbe_txrx_ring_{dis, en}able
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/3] ixgbe: {dis, en}able irqs
 in ixgbe_txrx_ring_{dis, en}able
Thread-Index: AQHaZEZYN+U8CZqVzUWdULwGAEEz+LEi6Czw
Date: Fri, 1 Mar 2024 13:01:46 +0000
Message-ID: <CH3PR11MB831312319FD15E1F1D839525EA5E2@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
 <20240220214553.714243-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20240220214553.714243-2-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|MW4PR11MB6888:EE_
x-ms-office365-filtering-correlation-id: c308b73d-d614-41fe-2ba9-08dc39efc03e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8N0+rvl/EjHUskZtCP8w3xqo+9opNzY67XFBE8sQd1iWoZdRXWBV+w6dPCOjkc93kQ38lpyA9PM680Wu3MDd4INcXYspF2HBX+8WiqGe4pu5AznZWZOQhL7x17dTQxuCTrZe2E/4TYsT5bvhiurjZbyXKiduaw4QdiA7Vo4TI+tQdwmpHHz999/h0JoOJD2g012m42tyxmouMGDACxivHYYzH44soNWiVgTEeAn3TVGIkzxQp6667jFU5R3Vch86m6tSemAPbmizrDLETiHXrWx+he7yw1HfZb2aJ7WmNWesnXHrSJZK/0/wADbQ9O2QRCxkLyXv3jith8Hbkt2JHeqxCLvhg9Oz4tpSTFeWIZbGw0uAYZPXKDZjJz7dzVc0FCAWceUEfgALY2b++b2dyNRxDlb4wOcGy8Mo+zGriQpGC3tfZLDBqC8Voa289GInVneRY/P3hYv4/Z9zcNcST+azb82wih/hwwk4mVuzx7+5CwL2uVXMEIt5J+EVHgp8gpOxSZ9XGAjqXik/XYuLl1M++o5jQog8ZPdXct05aUOghG7UT+9+IvXb2ZplHT+XnDsayAeVtnmEYcGfxNkn1vmoRb8sJwM81ahp7aEKcyy85zwIcSqKJxRaNoqioHJDy5mIMpC5Ve+DYdx44tZLgYSoBouvKAT7aifhXLX1UZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oJOxPfmgR5lM5LSjLKaYmIPrkpliFaU0xuCqIXYSh04YzpARf1HOorFSSsiJ?=
 =?us-ascii?Q?UnL0xHPIEnxlwZmYwhuFwbaDRx80EGL5zrtRWoiAMwcN9fkkX0cVuevEaaEw?=
 =?us-ascii?Q?HUnos49eXCoGnfIR9PbAtzm1FefkGMVctyG0honmNXKyDev5frPgfez0xMGq?=
 =?us-ascii?Q?vTyHI2v5/2K7ffqPK/2A+6ADuNqRsThZ8KS9SaSJNfnM7SlgUnaleJn7M7IV?=
 =?us-ascii?Q?YwBRJDQY2SH1nXMknkk7AwvJu4pJO2ttRhjIYLrXYK0Q7eav2dpFgtX37Izd?=
 =?us-ascii?Q?iqS4nO1iGJMVgsjq2+5PqFAgaSpBLb2En1soqxxIfZExyjPubBdwnRMp3fPP?=
 =?us-ascii?Q?RT4U5b8yW8WqnHnodMNevprxB98Qt8BfbEOPBDujYozUOUA0pR6Xdi2rtI8Q?=
 =?us-ascii?Q?dV49CzT6FiOGqgCxO2NhLdZaDK/yNJPAF/7nELUhcYrDUZ5S+JNFzEqD78Dz?=
 =?us-ascii?Q?kc4StEs200n2LCztkhrQanNwIUk1KudVJdZnQSlFsGnM8/8vZHZwxfALyWzm?=
 =?us-ascii?Q?Y4IZ+HQvU39tpXu13T7+mxLk6umzdqJruZsAQ4pSiTKSPR+ot2f7PGfUhcMX?=
 =?us-ascii?Q?S0Bo0MycdrrDtH7rQ3GOs7KuskXA1yuHef9QiND80dzeOe1ZjiO8FS7s0eB3?=
 =?us-ascii?Q?MuewmP93+xk0tr+nxPWBMILPI6M9OO44YsKvHl7nQoQgSSz9DeimW7JYZmG7?=
 =?us-ascii?Q?Ibw5O45KbbSmjDto9Vq+iNxN6WOmbHveYY73r4zei9MijYov7hKiPziPwQ7v?=
 =?us-ascii?Q?6cqCacI06dHtIPdMUrHvRQfQaS4vuQFEuN2mgaLryNmPA5u+7eI0Nu850q+w?=
 =?us-ascii?Q?3Jub5GEKrdB06wSAb0091DK0+gilTwC0H7VYr2mUPxkNXCqiWGB+/SVZFu7O?=
 =?us-ascii?Q?R/ShAGkkI/JUgK1obux4Uo4YKRL967hxU3qwDxwLdFfVSK4PukYeZeqkfkvd?=
 =?us-ascii?Q?ANlpbiQVtVzmA8SunOdziAHoBYYfNIGEnajuI0zcm+MnPVKNL3+/QJZwP9Zn?=
 =?us-ascii?Q?3LwOxjhMDosFPpj9AFBI6jVaqq74RXmS3SI15nQETDsGet+dhWHup9fy98Ok?=
 =?us-ascii?Q?qTiowbhh59pfk+JEas5rA9jHevAZGvETeahDW+Ke+FxnGjiExYSQxZYtZOt9?=
 =?us-ascii?Q?JKsqqaxHvOXCYV8+NZcs56Hu6a7BVYUysm4eCSMuDksN+Z4hQXl2eEFTC2oP?=
 =?us-ascii?Q?bVgtPYbHvey9jr+CWBVUtJn7uNX69Ha2skEtpbhTbr+hUZhWT5rgSYtfDrMs?=
 =?us-ascii?Q?Lz6bbOyf9RAv9DZIMoVAvjp+2dvzO8A+6Qf0Y4hoyWf3YlrjWNg8cqipOxb8?=
 =?us-ascii?Q?b4pYkPn7hJKiTOGQ9zdXpB7VdKTHC5qyvcr6tySrTeT3M/PaEouHX77eqHYA?=
 =?us-ascii?Q?DCebgZt8jASSPYUtgv6LcBt48+p8ozoLwOjSo8eJKS6DAmyGae7G7URzVvys?=
 =?us-ascii?Q?WxJdVe5QjK6AfTq+tdlUJtt6usZM17A5ZBrHZ7Vvxv8VIBJkX958XHuZfPGL?=
 =?us-ascii?Q?1OwMFbVegcjf9ZjP0x7LSSlxzJVyJGAE/dpVVTFNk3Q5EcQS83ePzomWAQey?=
 =?us-ascii?Q?NILl653EokpUeiWdVms0ooJPMRntlnHSQZHMT011?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c308b73d-d614-41fe-2ba9-08dc39efc03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 13:01:46.4848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JQLs0X7ObA1xrERl7YEG8XaWj5plKucyiCfOiNtL+fW62I8OIHCJ1bXCZXS3atTlsElNTAaYK0IzpffM7ZpKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: Wednesday, February 21, 2024 3:16 AM
>To: intel-wired-lan@lists.osuosl.org
>Cc: netdev@vger.kernel.org; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Pavel Vazharov <pavel@x3me.net>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH iwl-net 1/3] ixgbe: {dis, en}able irqs i=
n
>ixgbe_txrx_ring_{dis, en}able
>
>Currently routines that are supposed to toggle state of ring pair do not t=
ake
>care of associated interrupt with queue vector that these rings belong to.=
 This
>causes funky issues such as dead interface due to irq misconfiguration, as=
 per
>Pavel's report from Closes: tag.
>
>Add a function responsible for disabling single IRQ in EIMC register and c=
all this
>as a very first thing when disabling ring pair during xsk_pool setup. For =
enable
>let's reuse ixgbe_irq_enable_queues(). Besides this, disable/enable NAPI a=
s
>first/last thing when dealing with closing or opening ring pair that xsk_p=
ool is
>being configured on.
>
>Reported-by: Pavel Vazharov <pavel@x3me.net>
>Closes:
>https://lore.kernel.org/netdev/CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu
>_3jFFVXzZQ4NA@mail.gmail.com/
>Fixes: 024aa5800f32 ("ixgbe: added Rx/Tx ring disable/enable functions")
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
> 1 file changed, 49 insertions(+), 7 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

