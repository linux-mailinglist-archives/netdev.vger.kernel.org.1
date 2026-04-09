Return-Path: <netdev+bounces-276923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOhEKmh712mXOggAu9opvQ
	(envelope-from <netdev+bounces-276923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EFF3C902C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EF96300E29B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2843A4536;
	Thu,  9 Apr 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ3uFZLS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B93B7756;
	Thu,  9 Apr 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729497; cv=fail; b=J1edAZ5QDgNr2z59zvjmUv3uBjuwb4kxhkZbQSqs6k50DX5Nv/oPZ+eQ6F7g6hQFCDTWXmcDwK3KlvuDz64A1aOXne48uzQlbtm48Bh9S1hCQ3E4j4TVFFKj196OMzMPi9Z/a2ohfQ6Mym15WKT0vhWOU9rqYP2SmRaAPRs9knw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729497; c=relaxed/simple;
	bh=7BaHMBNNbiqmb8b6t0zzGIssphnBgMazWmQLYOx63EM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DOHrhZGJrYBJl+1ADm6gY+P7WslH5iaO2Pzvu9tM78tpqlF66oSv4z21V0Qc33w/ihwGKjWJjDTB2fXzViU5NVYDJG2rsW2ayP1KIeIXdpqS99MT86+NhFlkGOEW381qGwNCv+u/oRgNd0yDzAEaoAo7nJwysLk6ISLkUsJmeyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ3uFZLS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775729494; x=1807265494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7BaHMBNNbiqmb8b6t0zzGIssphnBgMazWmQLYOx63EM=;
  b=EZ3uFZLSUyc7oVG8MfqlrFYdR/PFGk+A1BzHROA3XWOOlSovPCzjE2bB
   /QLkd4g+2IJa3YUCWHrCWVRJL7rge2VbLcYupcRvnIbGRINiiYgqgWgSL
   WQtSIm0Dqrkww7t/80pdeEZhULMn0FA04SIqqMBUN0uluQsbsWHXBmdb4
   5cNL56+jUJt2voBlXB9j9MeA6a4ScUUcvlHStDYUbF8J8gklwxYij8Ut6
   o4mMBFFB5znBA9iv3aSSWtbdQNlMxXPaHuUaGy9UEmaQqTxOqbuyhDPjq
   E45tjiv6uep8dTGNF1xzqfCfowZbFDLyOebmzgIrKukff5JRTdoA9n8Vv
   Q==;
X-CSE-ConnectionGUID: h1HtcpXhQHqDLa5jzcqpOg==
X-CSE-MsgGUID: VYAgykNZRdS45KKTJE9mGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80591034"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="80591034"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 03:11:33 -0700
X-CSE-ConnectionGUID: sR87eMPLTh2RG27gRfdfrw==
X-CSE-MsgGUID: f6yilnzrTnu2ip7QhQu7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="223979954"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 03:11:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:11:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 03:11:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQNSK+vzfRluqSuz7cmYQIsERN9yqkLkgb2vYYJvmzXGkKPCk94Amx5kzulhG9+9AI5199dEcYGjJj28aZ7To8v7cNuXQWJU0wkf5Xv7P90cP8mWqeYI9u2kBVmyZKpQux915xrlz3nydKGXgaLk6/ogflHB85Dya1Lk27S+hyZKHUnPlvENeknDYdAZkMuZQuKPwKEBB6TzVeJvQk8cw09ld0CELKaYUVvcgCPG4gHj7DItK+1wFUFiW+SJPFgOxOSdluDBRYBwnzjxOC5wWQV/61TUW1i9NT0JTMXYj3DjN8MIeucD1xl5kR9TnqH/Eou1Y/64qhXfEXEpXllXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ+vbofgnNUper1jmrI4uOQ53HrX3P1x3WEtH8w7OlY=;
 b=J7mGXfUDYE8U4v/TxfJPmIwt/EcEFD1bY05FVoKLhXQnLgOi42kBlUXleZYG2ovIxEsTl4Q95A2vcrGdFE3nAYbSzOrHTeTwXTa9sikmVMt8pMXXQHAci1ROWNgonwOYfb+X9Nkq7gZ7pZ8jWe5NBveVa3d1SriuCBGyMLLRUX6Yf4AQg2PaWwB0/1P9p0SihTY9cCyeYs7OIfHX0SHbqQr6KCyExZTNhgKvsrbD3nVmk87XXVAeVAVz+R+L3C8ZFi6tPF9z6l9ICQdjJNeyf5ydsthI+NMVFk0K/kOrK7tRTU5VqNJLHk7MeWS7RzZb+fAwYRsgXpeTMuxx6H9gKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DM4PR11MB7184.namprd11.prod.outlook.com (2603:10b6:8:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 10:11:25 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9745.012; Thu, 9 Apr 2026
 10:11:24 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/4] iavf: wait for PF
 confirmation before removing VLAN filters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/4] iavf: wait for PF
 confirmation before removing VLAN filters
Thread-Index: AQHctTGqizjli7geXECy7j1oWU5U67XWp/tg
Date: Thu, 9 Apr 2026 10:11:24 +0000
Message-ID: <IA3PR11MB8985350D9E991B05E6F70D818F582@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260316104209.1285962-1-poros@redhat.com>
 <20260316104209.1285962-4-poros@redhat.com>
In-Reply-To: <20260316104209.1285962-4-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: 3d500081-284e-4df5-611e-08de96205b18
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: MMN32PTQGT58EST6u0KrcVcrJ2g0HlhsvXZ8KAPdpD+ftboQhbwhiPACwFSBPDv/HNnwLSIrKYPIg73+HnUzMz97ZpNXQrs43bZgClY5HWYsIXGLw9Pm9/2vQNgDty83BYrW2Qf0IWBfa8tghV1E/ZWDP4tl9hRJ1z0En7llQKZoT2yfnMEI6x7GP8zqdwaDhTU/1Y4S8F10FsFaRnqO9RReBIdwu2jDIz/iJKgr+zl312XeyHprLCk9R+Ayf4PjbV3f4dLTdjt7qUc0WWKG9MeEtXm9zYd0iq2AODKEsgwbyafyA0V64Gnpk0mxDS9cJHYOowOcKRY4GK/4ptbTi/h6NyoBfPAepm1Cp8+ovLZxghnZ6gxiNZZJ2JkB8i7TZAyI86E1ZuAGo/TGUxbs+ccyUzoGDPoxfVnzdd0yG2SqcAa/r76Q3fY98eAr6RUpVLlf+twZSk2SIkuFLMq/oSt1IbflwEp9iRWdRUXUW74XFMeSZNur9j+XxE/fVdzbh+nzBNc6pzZU5j23+ekxArH1qFqn3rX4VdYYaLRqjBJB1GX2qkzIlPXM2p2I8Xg27I7xhz3eQrbEGLpW/s6FQWIdsJOUgEXKTJV8C+b+lncxIDGxx9VVLeQOheDt7IXKSpds4q+PCioFhPoXH58SNKF+j5v8wligYtmaFojUZ/aNVoRjY4uwQiRhnnvTqX0ZdYy7Mvea1GVlRYPz/RogDxTi695leyc7jjdKXiXJ3TIwJY0KkIKhFtkQp2TDIb13BLwZTvIzb/L3nPp4XImgFW54czqO1qFGRuVrNMsierE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IB1amR7aDM4lHA/Ko57c5uFhjt48exnOFtSk6kGy9krKR2IsS85BcI4yFBqW?=
 =?us-ascii?Q?HEkS8FtUWdjHmzTx+vS3FSoC0ZtQZcT7ebIqKvmpY0UFXN0zelC6Xtrmb0sw?=
 =?us-ascii?Q?7OE1P++iYRDClHdwv9T7Il3UoS+3AycQJYHE+d8PufKviuvPZHYAQP5nDION?=
 =?us-ascii?Q?F37VPvIBNGQZItYT21NhZNpMB+GaB/1K7Ql6huYoVFF2j4m4H2XyjbK+UE6G?=
 =?us-ascii?Q?Q96E9olk0IVG4ZPNsbwo32E+jAgHaXtdMetdTBLRnJCRZoYLpBKzv0Dpvp15?=
 =?us-ascii?Q?Z2spcvUStI73rs9qk9iFd4K1XFU1qWrlOcw1OkuC0D50V9b0F6XNURZWO+51?=
 =?us-ascii?Q?PXjZxTUyo4ykTjEm8jTcOjdoxKLbvlQfYLOXUkO/ehPT8ivWkL9d5z39Gb5a?=
 =?us-ascii?Q?3SfsodrmNlrkAhFdzKBfu6RRNLwz/o0TcnEfYfrKovDXRCRpLnX4eJgIprwb?=
 =?us-ascii?Q?Eur7+xy465xOfmtwAJwALX+3fweOxt4Uxh+7JFrqCyTCoRGRSaxupz+C5q88?=
 =?us-ascii?Q?LDwnKEi2yv2nz0kipKUnCZG3d42CToSnK5HD40Wjxkxijs+3zp7eAvSDI5QT?=
 =?us-ascii?Q?+++K6UWzLN3cW3D9kz7zP/oznRV0wdGBVmEJMdoJAgl43NfLBETRCaO7gnRJ?=
 =?us-ascii?Q?vMCIJvoDQhT9SWEa3hNxdp4Pxumq8fR+En7O7vIFmQcePlS6BXzGc1dMjPbP?=
 =?us-ascii?Q?l1wX5aISgLpCiHr5WKYbwRvwhE4eUf+2eisujEUsBCVb/7KZJnEXTAMC3qcT?=
 =?us-ascii?Q?PCHgAvpsr/Ff/sp41W+L9atP5+zbkZioNJQEoqly4JWvavmovrPwtVN/IKL2?=
 =?us-ascii?Q?S3qewmAw+9VVW2nzM2cm6vizl5kk1kPhfvCTUY91hNRtqwPtmAAKYm9qBx2M?=
 =?us-ascii?Q?J9/l0m43QbPuxHATDElHAr6Tr4QNPKQB1+7RLyuT0lLqnf2/aFjrveMELr42?=
 =?us-ascii?Q?vBMzFBVoVpfNORiG9O3xfhaYDhotehq+QQb+SA6JOKpHvtimrxAFP5MBI/2k?=
 =?us-ascii?Q?vHT1oC5hgoz5SuW59XWt+TMmBrxE1AbsfmDOXAyXFU1Q6I+93m2OVYj98ak9?=
 =?us-ascii?Q?fRR3fTALyD4UzztAqT3e0kUjUryiu55b4kfwZj78cgsqo03rOrBWodUy+zm9?=
 =?us-ascii?Q?WP3FtJ75GPJyp+G4aW0zNnjU1p+REvZdrnKmu+pH1/IXdVqTL8zkjJAxDyWK?=
 =?us-ascii?Q?lZEvSW8k5JbJo36dqCyZ9vBWoy5tbfYWjxgZHLEqdHGdRZoB4RZU574+Vv4u?=
 =?us-ascii?Q?Bv2NJwMGio1qfSRRGr3pgNGy0GkrXjVXh/MqeUrYkIOfmzWjtiLwn2JN0ee0?=
 =?us-ascii?Q?6K6hsiQj4suLfQxa8x0pHhSp9jAZ4cNssF9aH8ngDw5rnw3BT8NG7xBIAgii?=
 =?us-ascii?Q?xNJdB6oCHls1iRjdNgc+/JEdcE0IG3D2jCnwvxEi3j356IEJHn7MUcv5kjvI?=
 =?us-ascii?Q?mFf/6+WHNX61uvbeDbACZNCcu+29OK1jE0EVINqzRrQ+BS9sHM9bATJpVsHl?=
 =?us-ascii?Q?UQ4BoAbEsMfFWPkn0NwIC/MvQWXOZdi6Bpo1Qtoc0fz9D/xXo2rLqEDUsx21?=
 =?us-ascii?Q?aAsvyL5zTtzTcMTtxQTDopWkR7KUnnYIK4nkSbgixx5M4Lsd86uTiOrl/V19?=
 =?us-ascii?Q?HvF4sbxukydXRJSx/nC8y8m36X6m6V/rNfAnKBZkZwo7w+tZTOxGnK0BJbgK?=
 =?us-ascii?Q?1SEmIb86vfdmo+hRirr8GeAJcX+tnyGcaZjibhUEqYCNLw1xWg7x1yrQT4tf?=
 =?us-ascii?Q?E6X3wvTzPQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PIb13FBvk8N9HPNdOA8sLwT6LbIXFKFre9bLRR3H3IGJvxOXstR1GdL5eGug28C0d5dYh2OCxa8ppmzbtK/TKuBNa8tr6ckFfohuar6MyUyI69rxCtaWTiqZZqr7HCqbJO+RGoGaUvBEjJjzm5ugbo7pHtaOnlBSxg/RG1s2W+BKHV954vx1mdAgMwoY08inew7c4zVbG1Rxeyc7768nilMQQLj59YaXMwh5v+jI1TpgloLRXu0HI12Q21fJOAmVcSXaV9wIdeipQ15Foi4MEZjZEHnU5Ks6PggprvkvAOQLNLk9++FNTX2ZXUxUlQT6DsAuExyBceCFz45YdOQh4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d500081-284e-4df5-611e-08de96205b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 10:11:24.4266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0tAUGyRNckoHmP+uQXn7cMHb+YdEOn16wNl2VenZkQd7JELuTOl6lHc2vfcVma+TTFBuVKwYZ1ZQNahIg4Le32NlTtl4r9e6h3IYrASehs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
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
	TAGGED_FROM(0.00)[bounces-276923-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,lunn.ch:email,IA3PR11MB8985.namprd11.prod.outlook.com:mid,davemloft.net:email,intel.com:dkim,intel.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 44EFF3C902C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr
> Oros
> Sent: Monday, March 16, 2026 11:42 AM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> <edumazet@google.com>; linux-kernel@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> intel-wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.c=
om>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David =
S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/4] iavf: wait for PF confirm=
ation
> before removing VLAN filters
>=20
> The VLAN filter DELETE path was asymmetric with the ADD path: ADD waits f=
or
> PF confirmation (ADD -> ADDING -> ACTIVE), but DELETE immediately frees t=
he
> filter struct after sending the DEL message without waiting for the PF re=
sponse.
>=20
> This is problematic because:
>  - If the PF rejects the DEL, the filter remains in HW but the driver
>    has already freed the tracking structure, losing sync.
>  - Race conditions between DEL pending and other operations
>    (add, reset) cannot be properly resolved if the filter struct
>    is already gone.
>=20
> Add IAVF_VLAN_REMOVING state to make the DELETE path symmetric:
>=20
>   REMOVE -> REMOVING (send DEL) -> PF confirms -> kfree
>                                 -> PF rejects  -> ACTIVE
>=20
> In iavf_del_vlans(), transition filters from REMOVE to REMOVING instead o=
f
> immediately freeing them. The new DEL completion handler in
> iavf_virtchnl_completion() frees filters on success or reverts them to AC=
TIVE on
> error.
>=20
> Update iavf_add_vlan() to handle the REMOVING state: if a DEL is pending =
and
> the user re-adds the same VLAN, queue it for ADD so it gets re-programmed=
 after
> the PF processes the DEL.
>=20
> The !VLAN_FILTERING_ALLOWED early-exit path still frees filters directly =
since no
> PF message is sent in that case.
>=20
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  9 +++--
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 37 +++++++++++++------
>  3 files changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 1ad00690622c8e..f9ad814d18b1da 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -161,6 +161,7 @@ enum iavf_vlan_state_t {


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


