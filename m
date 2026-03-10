Return-Path: <netdev+bounces-265908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IKKFSLMr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:45:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D2246941
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FD230AEBD8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D727E074;
	Tue, 10 Mar 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHbnIgrq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E83E8C58
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128614; cv=fail; b=ex09jaZCVvoC0lewbAxxWIfZLvfwlPeYVxWrAk8VzYamDunhZqGGCnE2fClZzhOFH/GUbQsC1ZSIrgdW0FTSuXnHhnoHFMAT3EJNmfruXYuETBlxollAeqmFlmYC1+H7Eahr//p16m0Nh5J2b0TYxX1NdXH0YdFuo9z44a667q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128614; c=relaxed/simple;
	bh=L7qz4OJXSTCouUUsV/ict6/02So3ybydez7Gx5xYxaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOfJx/ke26jUdt+PzfDqUdBhDsroE9uNqxxdHiudbKJN6Q3EhADnlCNipPEhrJVCaRiAd5Opn0I7bpCk9hJIqHjOWxJAp6iWDvbapcmevsqtQzUGJ4UKEl4sfW6C1V+aeYI15esZmsZnSlMbPXdeRa4aObqRTwu1xDYuAIUqVm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHbnIgrq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773128610; x=1804664610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L7qz4OJXSTCouUUsV/ict6/02So3ybydez7Gx5xYxaU=;
  b=mHbnIgrqDfbZm62o8CMH4VWZ62sf3yAF2r/XMFn7t/Kjr7g71G2Ec7WR
   TbdeniwR7av7/i63fHWsK0GkKzeqdxkXyO3HR2+PIOo0ILm9cLTIQWM5U
   T35vdBsJa332UPwY7Rfcp8bGQ3O1X55WmJe2+FLCeYvpVeDW2j5OpWl/4
   8Xa7uV3sjTQTKF8vBdz3HWhQ1g091J/tr3o14u9XDugPiVLkZquzWv1QJ
   WEaWe54jdqTrZW1c2Ns8ACE+Kxgk1nDupS8yqYsL72kDunGTT8v9CIrNw
   g53miXR5yH0oCnpM+IvMfwdIZUAvp1ronKHBvy25/i1MIk76qjUxQRiPI
   w==;
X-CSE-ConnectionGUID: DZzXyncERjWDabtcIzJMdQ==
X-CSE-MsgGUID: IZKJX/LUQPO75I/ZnqNRQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="76772982"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="76772982"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:43:29 -0700
X-CSE-ConnectionGUID: iPZb62FXR9m1efbemk+lUg==
X-CSE-MsgGUID: LYHW7gvMRSOEfi3b30RL9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="219151061"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:43:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:43:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 00:43:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHaTNlHH4y49ouiNxnXHTbXKvd74RE5L/qasowY+lc17p9NvwGYzJXrcqcWdqNq9W8Ce/uFh/WrTjG0ohNxkmfVFJn18TigKs88HQVG5sFKkygEx6Z/ExjslC8hllaFjcBejGxEJr7FJdXJs4kYNBS9ju/mbGhi9j49rQWsJSS12A7usrArOZd3UXU0FTT4m2Y7emeQ2Uvqm9OCyOCnQwtzja9ZPt/CZzoR3JKYct53rh+IMRnpYfqf98zmORv9hgTTEtrUdDV86kdejocMvSGrwfXSDkTMpm47NruLUAgqSFAPU0CxpRyW0nRwOnF4s/3N4CEJnfeZLpvoIoS+cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH63S799Y5I1oghzV1Wus9oOftmqB+uubIiyVB8YdiE=;
 b=R3r2qefZ+Qq8v9e7P5/xG4sowKO1oMceENAf2M5x5FpYayEp/eqvvf4c+x0MN1Y2azx+no0l2s4BfMZ9eGeudFVXC2Ot4XWtz/3SOQ4sKFjFkedzwNBr0bmEFTgqrDgH4vKoTG6Vk5HtXz0HXZA+TKEn5jUV1mY9hLpaaw0mVRSZdRAYCXDv4LNEO1GKNqYe3GLzaw582aUu1LjCqhxDbNrWNQdA6JilBpC4ura2c9/JkAL/w0IMFIPClw8sZV/FterjsGaWzXZqH8/XPOusItM68bhKMhFdT2b2b+Pa8uokMatIfu/ooWDHKnjvdAFhAd+thBysmQ9Q3tNBABsePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:43:19 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:43:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX hardware
 timestamps in igc_build_skb()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX hardware
 timestamps in igc_build_skb()
Thread-Index: AQHcrmBLsgTU2s0kwka3C9hijCWhCbWnZktQ
Date: Tue, 10 Mar 2026 07:43:19 +0000
Message-ID: <IA3PR11MB89862987ED725ABA6AFC2199E546A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260307182808.155027-1-kohei@enjuk.jp>
 <20260307182808.155027-2-kohei@enjuk.jp>
In-Reply-To: <20260307182808.155027-2-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: f155c2d4-f8ec-4d83-150c-08de7e78b2d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: Rs80uTGuhjbSnwx82bXDGwvLJV2+Bd5L35YrX5ScnFXeRx3NB3eHM1WYfckQTUEQh9kjXC8x71ILqSDiviSIBNk3hxshhaeNsTjQ9NOJvJqBbXkqRpJL8WAWSWxsloCGscPSsRhqM0INopHpX8/omiOAuijdcCwcuiVnYmsglLJ74pfuUkoGPOmEwVbYfzHbjF943s4ttdF/VAPGNMK4A/HQHaQgDWZnZImVoI8C/vjS7cKpDHPIkwKWwBER1JIGFR6jAvr8+Nkd7J4HFMePiW0BXhCVYIyZSbNpFpL3+E5AHyqTx6/kyBrTf3MJIBY3tQd7bb4teDoUEItj8N0PMyaRslA54tiEezDGM29HM6eiafiCdEy051nJmAaoHaRJbh/vgPVMumUFT8BLYQPV8tn6PWPQWBQuzn0I48Ma1YrUKiVc7tfOsIPXALgI0wIkjvKIrO+DhRdXQfVyWMHOgllXH/QbHg1HjCa5vtyyl4rWx1Ad8rzPJ9le9PtRrz4InLLzKD0Iwmqz/JhA/xMzH+5rpPRHnV78XRGpIo4sAWjCP3UeaONp7ibZjMgJg2zvLgGYkH2PX/GBRytGVpB7v1tcOgBYHMi/1fW8yNmN9h47Fx6961z21VVWsWpu20Vg7XF9GC9ESKQITnVEaloSg+xfjsWW1VUxneX/8Q8doPjJAeHGQWaC3Qsbc90edcP2IdvIQEaQllPcxqTtFwiLIFkhfVac+oMIpX8y8xRhsCJ90KVbEcgcfOlDkCymN7LYrRLWENE2C1FI3iw66Cdd3hNhYJcxL7L/7S85YZoCBuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nl9kDwPXPbuMh0FvnYSMVhZHBZ1FIWEvpqVccXziHz+tSw9okYUZ2ztOV6Fe?=
 =?us-ascii?Q?aqVoG42roxDOZwjp2cdb5Ln76ht1/6TJmqxKmtE4r5EPamw+4up3t8oe4Oua?=
 =?us-ascii?Q?/VQUPqaEGBJ1lOGCIvJHPnZZSf5/wZ+fxgcCpEaqQhC6j+bribdXGsqqloO8?=
 =?us-ascii?Q?BgQbuPAVuUkFGu/pnhkMCQKSZXx1mwezbGMyL8VvO0cQ+TfJ/3M8jv/FmYh0?=
 =?us-ascii?Q?FA7+WtR3BtcfjkePaIltrLtP9vapRQs8ZZqCX0BOWuNirAsaIcx+sC8m3/DM?=
 =?us-ascii?Q?8FXCVPWAmPRsQzPs6UwXyU/bmHRG5ihdLcFD3A/cPXCMo61Xme5JqHlHyUYI?=
 =?us-ascii?Q?lNQ06nAnbYgHcAA4F2nmvz+Dvxe+JI728C9Pewh/fALa9ZhdlzJkUW+KF2JC?=
 =?us-ascii?Q?zi0J5whohgOGeFQlNsM6fZzouzT0ZELCCgfFgAsH48Tg8BlBHBta4qtJSF8j?=
 =?us-ascii?Q?wmVbHXSnn0n5Y/X1KTCutvU54OxxBrAUG7qIsP6wkaJpXTdt2mzN+1jtlLe5?=
 =?us-ascii?Q?t6Hdudm5SjNFg/oAzhD4FIMlt3bW0+4P2OEppHbtGpyRWLFAIg4RIcQpOYy2?=
 =?us-ascii?Q?VWjrRNtYmhp3zPpv1TWS8IgR/YZltK80qoXvJpGDlDXg00he0C4UZRO1BZkB?=
 =?us-ascii?Q?JtgCKne3vUUGuV56+8Iz83FBjWJk6lyDM9ZOC7HmQR1/HaswQZqEgnBzCuJ2?=
 =?us-ascii?Q?K7IzjyiSt89hED6uQ/xnqd+vr480FGxADLuHF0RY8yeYDv0/FjvesWiPNnCC?=
 =?us-ascii?Q?YtlGGGChV3g+1yqHER9EbNRQpSPfheN5ecDGauTihIf3pw6wf10AK2VwLJl4?=
 =?us-ascii?Q?hsQSqX78G3vpA2lnhfY+BYY8HAM5ZlvwAvtAUQGn6+SWsK6OZ7AHZp5TVvHA?=
 =?us-ascii?Q?dnpDJKEKJCg/IMkf+gdI3etGVArm8gSyvULNXqOQ0TvmbdFlwzsGbAEItXHR?=
 =?us-ascii?Q?HBnJB3z7gQMVhKMGWNPsValoaRYQhZXA7Tgw8zp6GmzUjrXbxHg1z74IL5th?=
 =?us-ascii?Q?qmryCet4C+HZyiE4iZHG03oOyMqcQ+a/URUbu6uSKPYKpBwDiuPy4UAyMe0p?=
 =?us-ascii?Q?1cVfKeAVIdKhtByDJKcRbGOdcZZwFB9LlWdfekSH/u+ZFw9WKkRW8ymm+Z9A?=
 =?us-ascii?Q?KB4xWcbosFuFppR6JfDLo0G3ER/DH6vb6zl5fY6CIWP18xkErGrU9V+eapNK?=
 =?us-ascii?Q?jVorjl0SAamh/Nbc8iuZU780C7NkV4PeHAWS+9ADLkAihK4b5YOF12K51Ovz?=
 =?us-ascii?Q?MsZx0kGO6E5OAmTyTIkBwFQFlWE70HIUaujgHBtSCyzuSEg4JD5gJhKZGk2r?=
 =?us-ascii?Q?10SyEQCzwfEFwB4VGBbm34BC7Xxbxjhk0/hFmpvPODeUONkUg0MlkY18jWw6?=
 =?us-ascii?Q?3s07Zp0sQnF81hQM7XADKdNBnMIXU/kbtEHv0kV64TSbpj2BNwQoLW++6LZw?=
 =?us-ascii?Q?CU2e+D2p8L2WbDAzWJf9dT/m/fu7ASWHMs63ErDXX07fbzbLUjbPTZb7KqSC?=
 =?us-ascii?Q?O2zkXBLE4f0l/0G4NVsOlBQ6rM/OhnJ5o3k0aoDEzI51CWAx7ghnEzag3kyN?=
 =?us-ascii?Q?apOkXFqKtr3QDf9pVYoeNP929gre2+eHMq2fpJRwTV1Afzi55jmxsTTnohzz?=
 =?us-ascii?Q?cAQamuVe1II/6CE3FqgcEmGYvQt0I7yhoaNguzQyPsrVvfJYtJEMUflqscCs?=
 =?us-ascii?Q?lQz0+cyg8zo/tZKRPwugcZGFMrg84kj+cYkF6WKnB1oeHe6pQBWi63HUyn5d?=
 =?us-ascii?Q?WLK8E7LlOqWYBr/HCWxHJ9gHvGRKMFg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wlXiHCOk6Btcf3CfGBHZneQeoICWcwdwVaUDLZIycaegiwJHBUvSN/Vmk8dZRKbnU27KryQt61uLnb8sR3Qi0PLFMuIkckYwDZK+T5lw77VQYCaqVOEvK7fiPX8adkPXH1aTrYko7yH/yOV8UGfbb27nIKaYoX7V+66h3ozZ87NBcGc8uzHODRCPAwTkncOf1g627x+CPQVkDCbTmP2kC0oi5FXqzJxMwgKubT2dgyk+FcKPGhaKzeUvYxI1tYEHG3kXs9uwt6inamftx5vD9gWESAeMfVcgYtRr6sVman+EWKhf1ORRSPLyaTyVwbyPys/tSdKQMSayA8753T1htw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f155c2d4-f8ec-4d83-150c-08de7e78b2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 07:43:19.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySUs4vcJo5OI/0SmIX1FXvK0VbqQsk9Tom6OVMWx9DQZ4DPB6YDoJaVsY1xKIih3HWBAkIIH/9elb3Gfo9p9mbHCOhoJsfKN5DzxDa3HiEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AE5D2246941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265908-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Saturday, March 7, 2026 7:28 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
> <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX
> hardware timestamps in igc_build_skb()
>=20
> igc_construct_skb() sets RX hardware timestamps, but igc_build_skb()
> does not. This has not been observable so far since igc currently does
> not enable the build_skb RX path.
>=20
> Set RX hardware timestamps in igc_build_skb() as well so that both skb
> construction paths provide the same behavior.
>=20
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index ebd831a4ff53..3a4c1ebe4faa 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1964,13 +1964,16 @@ static void igc_add_rx_frag(struct igc_ring
> *rx_ring,
>=20
>  static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>  				     struct igc_rx_buffer *rx_buffer,
> -				     struct xdp_buff *xdp)
> +				     struct igc_xdp_buff *ctx)
>  {
> -	unsigned int size =3D xdp->data_end - xdp->data;
> -	unsigned int truesize =3D igc_get_rx_frame_truesize(rx_ring,
> size);
> -	unsigned int metasize =3D xdp->data - xdp->data_meta;
> +	unsigned int size, truesize, metasize;
> +	struct xdp_buff *xdp =3D &ctx->xdp;
>  	struct sk_buff *skb;
>=20
> +	size =3D xdp->data_end - xdp->data;
> +	truesize =3D igc_get_rx_frame_truesize(rx_ring, size);
> +	metasize =3D xdp->data - xdp->data_meta;
> +
>  	/* prefetch first cache line of first page */
>  	net_prefetch(xdp->data_meta);
>=20
> @@ -1979,6 +1982,11 @@ static struct sk_buff *igc_build_skb(struct
> igc_ring *rx_ring,
>  	if (unlikely(!skb))
>  		return NULL;
>=20
> +	if (ctx->rx_ts) {
> +		skb_shinfo(skb)->tx_flags |=3D SKBTX_HW_TSTAMP_NETDEV;
> +		skb_hwtstamps(skb)->netdev_data =3D ctx->rx_ts;
> +	}
> +
>  	/* update pointers within the skb to store the data */
>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>  	__skb_put(skb, size);
> @@ -2681,7 +2689,7 @@ static int igc_clean_rx_irq(struct igc_q_vector
> *q_vector, const int budget)
>  		} else if (skb)
>  			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
>  		else if (ring_uses_build_skb(rx_ring))
> -			skb =3D igc_build_skb(rx_ring, rx_buffer,
> &ctx.xdp);
> +			skb =3D igc_build_skb(rx_ring, rx_buffer, &ctx);
>  		else
>  			skb =3D igc_construct_skb(rx_ring, rx_buffer,
> &ctx);
>=20
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

