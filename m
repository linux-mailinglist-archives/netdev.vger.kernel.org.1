Return-Path: <netdev+bounces-267004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGXGFy6SsmnJNgAAu9opvQ
	(envelope-from <netdev+bounces-267004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:15:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9B2270375
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7560D30DACD6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFF388E64;
	Thu, 12 Mar 2026 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqebVBtF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D23B3881
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310303; cv=fail; b=ADSCyO2CbxlzlMuS2R+gO8xYE34ja5Qyy2LuDvIcDmXlaxKPKeEBlBlb0O+znNMnnVl1iKrCcobGHSB5SS78wkf7rlLDgyw9uC0TI2IF2xlz2mHXroOeiaKNH0BNvWQJ+X7ikIc60IyvSyKTmDfD4pb7zEevTGJJlxAws1iQkOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310303; c=relaxed/simple;
	bh=6M1cxPHe1dQw/Qbf39eQCHJEDG0UU8IwLbl7Qwn5orc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eF//axiHLOG1g6CZHGlQyf5nCTLkVlGX9IPjZvt2pCdbvAb2vV7jabF7sctORTTvoTuoLeFrc9jlITYcng7srcu9KBjQru4buCcYhOpCk2xygZTo8wLBftXe6xXrzBoCUKSpsXXTW9HmKDJzNVaDXhMTaKKfz+qSdMr/NIRsl0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqebVBtF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773310301; x=1804846301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6M1cxPHe1dQw/Qbf39eQCHJEDG0UU8IwLbl7Qwn5orc=;
  b=AqebVBtFvJj0X0o8hNFhXibKbpXj7Wsc6uRwvubI8+HJ+HHX+g5UfOrk
   j9yHocTcXlHHNeI1sKxqlQjM0h4awRnjR9JIxe3iQdfbwRMK+LjCwg8fv
   wmNDMj1vHeaZD2jRqWfjVALtpq4E/k6Wc4pC9i9sbPYFopr12OZ0KQ3UT
   jxQaNKS16UkDRIt8uAg5P9pRnt+55mZBJr0V+nPntY6pu+P3FF82jnJid
   6acrUDF9ZTuGTA8ha8pfwXg45gBNfMLoxAmnZ67MgMjrWOCNS52rHhL2g
   rxYa7N2eJjZH7MsPQxGd19RmALLR60mXEn0RPjZV7vEGN10+QMBBWziRB
   A==;
X-CSE-ConnectionGUID: vAHf0cLRQdq+dy1fKj9FFA==
X-CSE-MsgGUID: QJ97z4+ySKagrSHRAEYd+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85024270"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85024270"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:11:40 -0700
X-CSE-ConnectionGUID: IyT692VPSZaGWtN4uVVf5w==
X-CSE-MsgGUID: i2w7Odj/QCKROgrMc+6jMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220034983"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:11:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 03:11:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 03:11:39 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 03:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVsy/XpRT/9pIHqPmucBbbgiD0pd33DpXOFebHy4e1nymw7P0ZrZx0AG3vlf9RgUTTpajbH4v9GspMw4CTb4q6F8LRKZWHzxGSddHg0yzRVGjWwtaW7vSBBvSw/gOP0Jwo8jgL8gfDna2EoxfwZYSnS3wAlDW6t/CxWsNgPHsZqWhc2ucwY35vQflDxQt9Fnn14FHMpWpL3FOxveVShXwwzY1WZ1CuXaflydNvRGk+FMEas8weODJA76rVIrPI8hmt21TFPQVXx4cwhpjREm5gf4hOaTPue6Ye1sWykHJFXat0fPV0cEth7fdrISLCLe3+imO7eu3v7EErzrTMumWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4jggVDC2uCwlQIUSWl60pbMbRGfojuN3HJSPBAOIX8=;
 b=Xy4pbC3HZStUuWa/mv1OXsZXgmWJuHq1uB4mXWbAVOxAnbgNV7I+DVGwrHmPoO+qiUyn4MwpDbbPPPCP78oYwXx9fOgJN6BumZ4TTL5MHp9IHvr3h4aIRASRtcoczgTyrC75kutgoFB+O16ke+Ac78XpRXuTAQxRVNoNcqVp5zfNI2R0GWwsE/4u7b3X8jfj5y0x2dlS4t6WPh/UQi422P4wbPxDC+6U92ksfXeQ9dWTblDjGAdHsk11pl/pv6yFbPhZmvdLDtQ7LTLVtcsVq2S5zYVXoN6IkfwOM9xCMEZXvN2ET7DU1gaSXCSmS+WAUJHIcwDI4TPIGr1phu0d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 10:11:36 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:11:36 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] libie: prevent memleak in
 fwlog code
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] libie: prevent memleak in
 fwlog code
Thread-Index: AQHcmzq+Fv+LIo4JR0CxfA6Q+l6/ibWqzRJA
Date: Thu, 12 Mar 2026 10:11:36 +0000
Message-ID: <IA1PR11MB624182245202ED6FB33FDB6C8B44A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260211091008.236185-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260211091008.236185-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW3PR11MB4730:EE_
x-ms-office365-filtering-correlation-id: b589203e-002d-403d-da76-08de801fbea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: vXGNZZDKpwzdKxh7FgigVKkxlH6dPJY5o+EZWME6eF3+vEfpxTLaTtAfYPUjNJ/GS0QiifdH9fcRxOezlTQC11IJ/RKcQWx7HFbdq1SmgZ5dZGrstMhUJ4k7PM+VbD/GLQp8McEsUXy8sZ/6wO3C30S9i3XAhI/T43PhAHHCoGPgifd8UGPI7IJxbng+F39J1jaSgIxLWDvXo7OCaHhnXW78AOBT+2LC53DF4cnudsYWRWXLEyZFFRb2ihQfhi0wuOAwcczqWC1f7tYMTvftD1pxocXlejCgF8ds7bMu2ir9W51nIvw+mEuS+5Lkw66y2XFcmNttFpgK5gBC7DjEJBaYZH44TCL0+HpabB4b6oJ16Orx5vLChOMaWmDmNk4jg3FfczkzbTUnUl9N6l5dkKW+G4KyryMybbpOIIgBvDlMVOZnELnpXioX9MF8CwmnF5tA2jQshe32PVFwG77RH3jghmKViXll1QONV77RDJRHJeyPDWz/V1VxgT9vEpYvsfVbrPLfdiXFGCed4nBi1qFQ1Xthbfnmb+IpUZX6SsigQ+l6pD2kJOAujl1JKdC0FLMUrwwi4+JEhgrj6nspN94hTWSUKFadFNK+ZSdnPWeWZyHFa3F7/rM7VKauJ95XLLzWC7l79GvwLQN8k3KT0txhwkg9qOVZab6nDDtgSYDeaYhtGBVkFaKfmq9juIS3JPEsT7Qf2jm6EZwgC7Biq3LtG0QnjRjrgPx7MqPb1g0gYr3KHgn8dJFuJ3yKTP7jOcOh852OV+M0XMoC+/YL9uHXnsFYCQyOfC1WYoyuPSA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nL6kUlTAk5bI+N4Xayo+XH5aPAb7VoX9Pmvx6nCk9pHB0fcMa7zircOuajq3?=
 =?us-ascii?Q?bIaGm4l/wYvLnvCOwqH9xcnMYbqOJXeXgYkDDSSd34fILe574I0524zcb8Zr?=
 =?us-ascii?Q?tOUgUHX3vvtn6ZLK9RO1pzD56GiSbcvfPpo62sI1L/nTWmBeSp7v4mt//RfP?=
 =?us-ascii?Q?ZIYbdF2ygsIbztM5t4UisJr9tBGwDZjRSdbP0pGhK7XIKpxC8bL+IYSNNN/t?=
 =?us-ascii?Q?Dh5ZGTtd+sp43V6Mn5QHQefh+iNsYVxc9rru0WFPX7NC6FgcadUJ+TYSOlcV?=
 =?us-ascii?Q?cE9j5uMG+gHfgF5Rhkbp5SkTQiI6gQ3RHwNAMnPX3Mb3lQ57ZWJFq5XroWN4?=
 =?us-ascii?Q?14OcAINRfGESy61l+l00r0KnY+euie33/h5IEb1jKvFya3P9Yoy8ieZ5w7xa?=
 =?us-ascii?Q?gw2AStkfCbXU5gVDIC3IUXaLSE52aDc7iEWIYZaHkP5IVgsDyhqKhaJVstgu?=
 =?us-ascii?Q?ZkT+QbMFlu1/Ho6sxeG2ZUBw7seIYUEknE6erPH1lAEYLd7Sabm77koFGdv6?=
 =?us-ascii?Q?nks2SN73OMrtaAVA9YsIoe9d452B406F1tjNzVEBbazyHBRPiXC/ZInIL+NV?=
 =?us-ascii?Q?zmu60dG5bX9Ufsj1i3FkPQXJz/AvAz6oIVgEdSr5aGkjzwT3jnvgxJm/JKvW?=
 =?us-ascii?Q?MTebzARBDlW1yj2W4Den6pGX07VaMXu/3Z0LNsYxU/UV8+W4OFVqjo1SIorW?=
 =?us-ascii?Q?5TNbzdaK/Poz2gVPedsAQfpmpGE3gfbwVHLAE2EvTXQQrKbp5ERvJIU1VBFk?=
 =?us-ascii?Q?7HXs7QuVoxPzY7Sv4MH205oOPmK8JDnSCx9H0lIH33bLYlMeJIUk3Ws/N/B4?=
 =?us-ascii?Q?NC4JXYSMhFxEKBkGRqaFnXzb3Xd22uT874DbaJ2SypbmhWiD6hPj7jOr2QTo?=
 =?us-ascii?Q?OMb4/0SPsaWpsDtPCB1ndtVO+cCx857Tqz91Q5eO/Qttjaqxy93H1tE4rU3Q?=
 =?us-ascii?Q?Xe9s5/qz5pHI/AbyelsSQnw3E1WnDlKql/NA8X9RgzFHYNXJtD4CdmLWelsP?=
 =?us-ascii?Q?5EmQfk7ooFe4yqLt+AJKUgP2mmExiVyEUH8yHQZ3R2KluLlW+xllluKGXlJv?=
 =?us-ascii?Q?cfBz197HJRjJ/RSYEPcKoWdPTMRwdciowI1Z+SOlD65o6WA3Cw/dogmaXUsI?=
 =?us-ascii?Q?UTJ1S9APDgT8mUBA1cTGz2J/mEMn/P7gEJCk1fXTxtz5Nrc87TDONDRVuhTS?=
 =?us-ascii?Q?l9MrldotaK3HqfhbXYloUGwLiUIwkpfw+lTmAwbvzd+INn46FjIptNRGDx+A?=
 =?us-ascii?Q?weieX85i4Dktmo+q0gltjdE1NA1lmRxnZH60x312uG+/StFc6wIxp8TF0XEg?=
 =?us-ascii?Q?7lTRt9jic10gDfJ1qCk1OzxRzWauTOtFXHdInIGolC7Aoj/iRZOJr4KQUqi/?=
 =?us-ascii?Q?6ogOAF6K0OGXCIUJVfOCl+vP8fASfh7kEjKh88F6k3idWIKzt8eD2E7sma8e?=
 =?us-ascii?Q?yS588RNMNeB3gNeHphy0921cah224mA/ngi08Ls+myR/iNXV5J0lBqtOEFu9?=
 =?us-ascii?Q?IEisEvhTzTqFQ5e8+rI8Kzy5H+wv36PSS4lOUa1c4B1Ozv/a7RVgRJ4FyrFe?=
 =?us-ascii?Q?O6NeaOqj7VOuheq/CFFkv+zbij7Y5SNc2UrbLu7Vh0XZYBlWd/GXmmLIl88F?=
 =?us-ascii?Q?3oRCgbNKV0Dp7Uq5t1P0sI7mLnQLt8ldFdKlesgYFVDkKHiY+mI9GlDlhox1?=
 =?us-ascii?Q?ucgTu7yzHEmqeyU0hr66rj9cfJaaEQWvty4yIq4gFwP/QzWl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aCUOCt69Dz+blQ2T/YD/4zp3wxZz7Aeoycl0ryVjtFHCEmSntO5NMuGQKe623Nzg9nDT/OFQzLUdlrXXt6yV35Wk2iQMasditQmQQEHQAMU5KgIxWgMOcgQjfa3R+6FKzO5NeoXn/eILoN/oMduuv5d2RcaSsHHc8xMjfU6K3RLWMkYlW4NWsPHfYyMVjnHaSK4qOhEu1iAlTpXv7XZJ9Cz7FI0/E5NrvIH7YlXEHjAferkCqgJt7dvdyLej8J438iK7Ou+7uEXSEYnDPqfDQdEjbSsZDw9eS7tzoJZrMsgXLm0Kda8jfGrCGVL59f2RLaOWBBTDQfavRMmEmHWTRg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b589203e-002d-403d-da76-08de801fbea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 10:11:36.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zis/vGL8d+suC/ABO9PgK0PGsqQZU22TABtEbwvKUJ45LZmNMSBGGLAEFeGWAO5tjmbeQj9MGdOuL9CY3HQuAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267004-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BE9B2270375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 11 February 2026 14:40
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski <michal.swiatkowski@linux.=
intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] libie: prevent memleak in f=
wlog code
>
> All cmd_buf buffers are allocated and need to be freed after usage.
> Add an error unwinding path that properly frees these buffers.
>
> The memory leak  happens whenever fwlog configuration is changed. For
> example:
>
> $echo 256K > /sys/kernel/debug/ixgbe/0000\:32\:00.0/fwlog/log_size
>
> Fixes: 96a9a9341cda ("ice: configure FW logging")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> drivers/net/ethernet/intel/libie/fwlog.c | 49 +++++++++++++++++-------
> 1 file changed, 36 insertions(+), 13 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

