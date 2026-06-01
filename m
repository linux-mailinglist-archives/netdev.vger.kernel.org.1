Return-Path: <netdev+bounces-293624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB8NOJdMHWphYgkAu9opvQ
	(envelope-from <netdev+bounces-293624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:10:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C661C28A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D30EC3019116
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30038D416;
	Mon,  1 Jun 2026 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpho8FFu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1C38D3EC
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304748; cv=fail; b=M8Sbu62XYzxqbOjn35/4k5LzcSuKTYK1Yoje5BAz3LuaFPywdWeJQilPfulA+xKajj5Iw9u66w3lsvbz+4xtHC4XDm8Gab0+SsxZpaAK8RIRuqv1Tz2wjD/WolnFyfsNW8jgqZK6iQa7nPMOFvQXKgl74YlqasFL62zYyEN4c3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304748; c=relaxed/simple;
	bh=nBFC69G1YqmZl+n/lpU2QDVFWtAa37Foy81KvYZj5Hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YmYjUPo3BfpgtYLsy4+jRT8xASwIquSB09hVskXGgjWvdHeuQCWZnQUNju3CtZmS8cTsxuzaXOYNmSDY4mE+GlEIr4HlA7wHpLUV3GTLdVEOP+60c5ofDpuyp1QLOilsYMNAOpL2Zc3G93lJpoNy3y4bQVm/MNYgPNYeITN5l/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpho8FFu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780304748; x=1811840748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nBFC69G1YqmZl+n/lpU2QDVFWtAa37Foy81KvYZj5Hc=;
  b=kpho8FFu7d4Y4o7DHtr+4OU6LWflWr1zh6rrhjODpVOTbdky5D+NRVLQ
   9Y9V6rHj5wXfY2bW8/mqv4whM1hPIo2yKOIDO+iDVwmzI15jYzU6Vzs4O
   3qT5lmI8fV6LU2VZe0MDb+YbWDUR+rq+NEqfkNOiWReWurhfSP9ANLo73
   QWLS5N+/a2whFi/dCxZSVkj02gt+TpzDmQgmmu1p6hO47fz0hwu9eroaR
   AIxhmb5CY0Q7D+SAfP3MwaAd2AP3QXZL9QqE70XtJbrjTs4lQgodHDLoo
   H5ub13sNVexjgM1Xz9IkpIRkK7tAKemBlzs2n4UFpi4NtFQ3iH18+FWVD
   A==;
X-CSE-ConnectionGUID: uSOwD44FQs6gIJ2RhtU+eg==
X-CSE-MsgGUID: UQJeHyTJSvunPidg1uDL/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92535193"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="92535193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:05:47 -0700
X-CSE-ConnectionGUID: NXphJpEvTPOOVVYS0jcOdg==
X-CSE-MsgGUID: via19F38TAmHBRCWOaNLog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243634118"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:05:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:05:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 02:05:45 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 02:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkfGaP7RQ27k6Tyz8hsDQ4RBizqpTcFCQ+jsGgakRUH9HZwzb4uKL4cNbuvuqjc+X0ntBH1TeFen8x3D+VIzOCZidS5kMHiT4Wm3b4wZMQax1A9yAkQgulYI8L8GwfYx/1JDkZIquSrruJx+XlyP8FsNhNZns02j9Do+9NHUHzBtXUwPhqQlpIJRfeeXn4ucHJeW+6wHNGdSSeex/Igsut5sP+OQ3lELzncC5awMr81+hkojpYDkJZiFozd1NeIgW4SVjmZ5435lUOvEHgbPCvpLiCebQybAv1VvrtRaSwXmX7n8xvCeYXaSP/PnLo7MqOT5LCWFzeVFb1B5Ovc/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOxZnw18s6Xsr28Im7ORyeRr7bSAiU2h8Z49giGzZtQ=;
 b=bn/2Plkev+LDfWEXDYkLN1cljp9eT6kaXHTcoFk7KmcYhxe3rj/7XHCq9b06Kvsp5INTSJrVyMDikhEVXRmIGtiKXB3FuUefQ2AvT+nRCgODYZPKJQ9niVK0EpDgVB3kT92Ok1lca4vlSDeriv22ueH64QZffwgj9SHlQVkD+JZtSvvK+zIFCMP7sHdQrE2VkyIrkkNeSa5huZy6unD4aD01SNkaeXaVlj4Kp7C5CjalAJMiIguwd72uL+d6yu7GSgGET9FdJhlJ1ZHcFXsUbQmZi/Y5kk9CqAtO/6lvOHNd/y2BpjkVeuxQoIJsNuNHw/q5p9P3Bx3yBfOTDEtM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 09:05:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 09:05:43 +0000
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
Subject: RE: [PATCH net-next v4 3/5] net: wangxun: add reinit parameter to
 wx->do_reset callback
Thread-Topic: [PATCH net-next v4 3/5] net: wangxun: add reinit parameter to
 wx->do_reset callback
Thread-Index: AQHc8ZenygriWldPrkWMGOTOB3xICrYpaElQ
Date: Mon, 1 Jun 2026 09:05:43 +0000
Message-ID: <IA3PR11MB8986062CA3C032004AF055F5E5152@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com>
 <20260601072221.2952-4-jiawenwu@trustnetic.com>
In-Reply-To: <20260601072221.2952-4-jiawenwu@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB5327:EE_
x-ms-office365-filtering-correlation-id: 965fd025-5f22-4cd6-dde2-08debfbcf603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|5023799004|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: Po7QeqRGljY+U5XJ+imTaaiSxjN3+jFz765rRCo1nH4oKA2rB5cuPjYxwK9DsdgTFQqWouZlO+KID4ZqOo/F0R6uDqhyJkIuUe1ybpfbBdfcoc+d/hlxHdFRnq1w3n0ptSjlWXtboU56BLpkrf32e2wMH6ETTYuMKYhmlZVGJaVNtUpyddcXSePVBT3tSJJl90gxWfmn+dA3Sr97AVU4baphIwCnX0imU26fwIwSlhEPf5FO/TDAFYyg2EhfA/sKrFPfOG9949eJ+OlJ92t7TGP6iB0UuZ1wz1lUeWl4ipXMEICO3ptJ6oYuKNze/qsoJrtAxMVZY2cHB43Nix+cFRDLGatxh4Edi8SG1qS1f441Zy4iYSpem8jmhuXlcxrVVkIYXKjb5e8EsoZtospmaDe1riTNqNZjo3JtK/bFT0CETvGKYUeRzxJw8DmfxeWzSEBQrZTPEVGuyava0UYEkOND9BUg7EIsboCdW2111jGdV51cFeE7yJZTrjK4GJPDScXw75m7P4CKyybDMx1z1MKxJAqm9J0XayprLAYx5FDx8PJt9bKgnNltF1iUX+DxK1cfScbz1ut1+J+6hJFP85ioWt4GZCopyklNgV4yvgAMduJxvfN7BlnamkSxCos99GcWiEEdvg6VULn8kLzxclZgrprLJVO+c1Teg0MagYEaum0tRGyb2mzw46oEYrz7FfOtf26tZ7eiLdappI1J3vi1sdSdlXcGXkTCoNTph+b7ahaa9Rm2GNrtNLiENAaw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(5023799004)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fEEgAUyWo4swBN2KbIrq/wIHrIAWyM+JMH7Q+39PoXz2U3/yOf+WBCupux?=
 =?iso-8859-1?Q?E+hWjK0LtI7yflLk3HkOZZ5Wr8ItRPpVBQ2nSUl+xtSoXBrysXM0XaP6zW?=
 =?iso-8859-1?Q?Xo4UPNYE5iPZdrz2+qmfcjcOGqrUBnmawRadTgPPgMTOyXaONqP3vt3mQ6?=
 =?iso-8859-1?Q?3St2nWS0ijPBuA1gNiJPir4rSG3jig2UFVLzG0BiiwkFEWo7Hon9YwBZTJ?=
 =?iso-8859-1?Q?xsjtqKLSEiQGhaUl6qUiNgjz702Oj57vf/QtazXx0pmjcG25rG2FHk8Ljz?=
 =?iso-8859-1?Q?hQZ9pHQ/0Zct0bD0K6i0HvxBvewPrJzG4ONsP7GlnXxdSbHZ0GXuDb4La+?=
 =?iso-8859-1?Q?QOizyw2/yC7DsHe5b+YB9fkjSnOs6RMIdqv5D6QhzCOrb1CP5lIdb8RTed?=
 =?iso-8859-1?Q?IISMh9QSGwZP3d0sIumnX3t5yKKW4xiBKRB8vdK9w9aEccKppRBZw3KYym?=
 =?iso-8859-1?Q?yszR+RGFpn0z2pwsYeTzPHVz5pW3/CcDLoWJRl+3r5LbAXJQXeIZtsAyFc?=
 =?iso-8859-1?Q?JwRm8im7nDZFQya1FE3FqrLyD1z/9QT2bSr7b4XEVfRthcc0Telcu9DnF/?=
 =?iso-8859-1?Q?qRwuZgdC56CVwWsPnebT/RgWoUQM1o0B7W94udZT6X+SU/ZhXuf2H1XFqe?=
 =?iso-8859-1?Q?/jjGawwGP40cfpV4SatKb0xpiUoay3F4DvlRQwBs2owAOhik34Vd7o9Q1a?=
 =?iso-8859-1?Q?yhKptE6j2DLDDD7ghW4vQesel4An9uvBGMyhtEJZruDltj1ql8g/GQXKh4?=
 =?iso-8859-1?Q?ZLte78IfITBWV9/ZrvrY/5Yue0/3TyxykgLbmHO4g7ALfZm2DNzb4Rp2mC?=
 =?iso-8859-1?Q?pHmf7lylrJP3aJ2Q6qGVIffMjEEvbGTgtqAvO3yEAbyJPhSmCof2zSQmQx?=
 =?iso-8859-1?Q?DDjBhgm5eFMw2nSqb+ByUXuzYzIcx5TyYkEadd0EUAYSes0JK3A9svqafE?=
 =?iso-8859-1?Q?4LbIsD2sfkZ0qc+3yYSXao0cMDDuWv3aduTbl7YXMSlx+HYNLnEmX9fBBq?=
 =?iso-8859-1?Q?uN6onRdFZ5jkIP5a1QQSDL5RhSHhixV7t5rlOcIW0+xeDYiBNCKyhkegwF?=
 =?iso-8859-1?Q?wPwXaKMgIR4GaFMz/vUf73ZbgOGt2gYA5OJHcATjYuz1cfhn6iGoZUw2MW?=
 =?iso-8859-1?Q?LBYR6QcP5z7O6tN3FOFWKkj6eIrgriussJHWfUXo+X0HK219Ut6sljFPQV?=
 =?iso-8859-1?Q?QBsdNaN4b0/9CUDHWxhrC1Ej/Qf1hT8CkJIQLe9vYk3QBT+zBoEXQTadVj?=
 =?iso-8859-1?Q?79yPYlgbJ7yLAFa8ashksdr1PiwbmJBdC8Cue/i0ogehcFHa2mExlkuawX?=
 =?iso-8859-1?Q?LGBjQdQ+pDOYtat2S2Gi+2RDbcZSojai8U0AfGmiNj+fi8fk1UJqjxbGJL?=
 =?iso-8859-1?Q?ka1RDIBYAeJuwDzt+3TEwLXJFF7l8ebjlJYrJhUO2sArInEvZtBiN255Zp?=
 =?iso-8859-1?Q?PEnEj/pZSAWacpppkOjhD6pENi2LRNrCUAsjeK3ceRoUDU8YiyMzdiVh8R?=
 =?iso-8859-1?Q?hykIErNDCM9g5b6lFMqqbhFDJ3bMdeiBwEmpeUqaoMxd31kMPvSFL2aR99?=
 =?iso-8859-1?Q?Fxh2KnZzgBs5znbi6s9z5JAKoNkURnQJghqstB5RFOkgVQ6NX6FvWCdmAc?=
 =?iso-8859-1?Q?HnfrKDJZIQoEBeEIM7OLwvbrEi4NZTYijfjkpogCdfUVNMMk6re1ZSC8jq?=
 =?iso-8859-1?Q?/n7hw13SLcANrRwsiDAR6qZ0DIl3fslGUr34IFD4HyrXOn5WS9vss450ED?=
 =?iso-8859-1?Q?v5IdiB+THUvx1DTpj55GGTQ4UUXEHE5DaK+h4gTvn3ip87B2EsFKGqRkcT?=
 =?iso-8859-1?Q?hB5kvKyK2/45baGlD2spN3+RMLUPdzM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g0Un3++4/k1l4KGh7AIAm8/87cCX5OqNNzwc5kdX7qKbWu5/6GNMBVupBJoETQCusCga1NoVmBOW1eEJtYXSJozvbUUWlpLdpky5WFKhubYWrdy6GZTYnB6E9s34ADmlXM5g2y+Jj/qsEd9r+sKQvM5gl1jrjZ1Ah9Fs3HjOCTUcycZcDmcuCPSYmu0N/kdSwOGtduRUrtTlx2DUqVfJQV8EExYlQI4UkORWze03Ve3/3H6O+P8CV4HItE8HfuopjQAFCyECkSDNvnEnlMahYNOgmIuwdMG6UED15vZncbL0wYzGaVPn03x9u+yU5EwLdBA5iR39/GvxWi6anqjBbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965fd025-5f22-4cd6-dde2-08debfbcf603
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:05:43.5093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qay/I+bBL19dCnPSuGuBs224vgJ7uIrXhJh3ZAhFXBU5LB2uYkIgyUV14aXgOKif7m6nBwcSuMWsUiBJD6JSxhymH4pcpKFUKRYt36WWO5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293624-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6B5C661C28A
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
> Subject: [PATCH net-next v4 3/5] net: wangxun: add reinit parameter to
> wx->do_reset callback
>=20
> To implement a simple hardware reset without tearing down the network
> interface state, introduce a boolean 'reinit' parameter to wx-
> >do_reset callback.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_err.c     | 2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 4 ++--
>  drivers/net/ethernet/wangxun/libwx/wx_type.h    | 2 +-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 4 ++--
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h   | 2 +-
>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 4 ++--
> drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index 982a438d009e..e249cea874be 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> @@ -16,7 +16,7 @@ static void wx_pf_reset_subtask(struct wx *wx)
>=20
>  	wx_warn(wx, "Reset adapter.\n");
>  	if (wx->do_reset)
> -		wx->do_reset(wx->netdev);
> +		wx->do_reset(wx->netdev, true);
>  }
>=20


...

>  		txgbe_reinit_locked(wx);
>  	else
>  		txgbe_reset(wx);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 6b05f32b4a01..1e373f7fd9b5 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -313,7 +313,7 @@ extern char txgbe_driver_name[];  void
> txgbe_down(struct wx *wx);  void txgbe_up(struct wx *wx);  int
> txgbe_setup_tc(struct net_device *dev, u8 tc); -void
> txgbe_do_reset(struct net_device *netdev);
> +void txgbe_do_reset(struct net_device *netdev, bool reinit);
>=20
>  #define TXGBE_LINK_SPEED_UNKNOWN        0
>  #define TXGBE_LINK_SPEED_10GB_FULL      4
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

