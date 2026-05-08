Return-Path: <netdev+bounces-285677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPFPDaWI/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:54:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45E4F2A81
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A72D5300599F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02837883E;
	Fri,  8 May 2026 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZPnqHql"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3136B07E
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223264; cv=fail; b=Xwn2G8uhcKMuKj98HBNEayJm+TpnAFUsowTX126867G16Ub7SbHcUpOWoMi9ChEru1EeRaouwoZ23zDzpN3reBwKm0T4R/GYZ1Tdwo7HJe3oIQCzpD5CqyN7D8PkaeGTXQRcVjjC9Z4nnKkFAUZ74X0JCPfx9INHua0SfpCdt84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223264; c=relaxed/simple;
	bh=uhJ6ik3mMhpl1K/IfZaqlWCRDckfW/uXUByMhtwaG1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6bwko22TadwFXnZSiEiPj+P0Q/88vV7kqmnZRS9ntNzFREONRVmsoRHNFPdXVvz4xqTtMj55DuEvv1ndSN26ioTGvigTk+1syIWjREQhthYkUSlV870aEhLn0aHDZHNX59is/x2GNI8kiORa1njNu0muZpqRYSZL6QTAeJBUHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZPnqHql; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778223261; x=1809759261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uhJ6ik3mMhpl1K/IfZaqlWCRDckfW/uXUByMhtwaG1E=;
  b=BZPnqHqlEshraVj22xvHOsj9lTz/Dah81CNjSwt/6oIjajrtfUr5cWKu
   ogy9zb/tYA+BVAqZBcQGSfnz6vwBx7jHaUsjfKtUwfMLJWXvL/FC+qmQd
   R6sHG0+DU876Af2q89Jse1OPvbJ0razUqK+EZDpQ9bahNfACOoMXCM10F
   vxBYMno/nDJNcUyNVf89JjONUnfXYGP63FUzul2ji3HvzkTnosyEWDUy/
   TCCdZuDv4Knua/D6eLRBLVFRShp3zebK8fjA1ajZYWzCbrom1aM81nT5c
   t3tKmNs5dnZ+dCmI3qqMgE2PIGnHP2KtpR2AbWwlEAS1S7TOylWQkYkc0
   Q==;
X-CSE-ConnectionGUID: p09dVLUpTvS8H2rOqEmBHA==
X-CSE-MsgGUID: NwMZMgzZQgyvCb6I3T/iZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89493818"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="89493818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:54:19 -0700
X-CSE-ConnectionGUID: f7zNAO2GTJqu1bjd6F2Ezw==
X-CSE-MsgGUID: mUa05n03SBi3rntBsutJUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236625182"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:54:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 23:54:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 23:54:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 23:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvTcR1k9in6b106vViHFu4WmSIcIebr9uaw8qWmPpaGNVMmheLW5B14XHfercFB6lA8AioQnBBH6X6/0hQabiGMZCvSj+38MRPLi1kPiInoTrlHAM2BoQxPiGhX4JOjpF61+1dpEd4znu5zst4jKlS8lsXcdow7zHs+kzA0KnbwXx4PKoVgQL2/jYVIka5Xuss6+QKunhoSW4AhBonX+qPXmLczHzGkIaPjPq+6ZGA0KY4ApmRZfFo+mWOdGEz9iZel9v6ODtXGLteF7rlgyJaXiiJTg6NKJZ1w88l6e4fPibrbzi6GEWdh/F8Em3GLhk+X78ug2VhjDYNHUVtUf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CWIhAESsXXYOk0mDymTOEFow2UMVR+IvUizDn+VBRU=;
 b=iRQc/asspyG4VpxifZeTKLrXpIVWMiMOCpvBJwRjFb+FSbEQkvzP6/qXxWLSABUhAqiZMJlPmeTCCmWPSu+5j305baqwgjtnmVFIVnEVJdAyrUNLCtnRSXCYK26dQSfhn2zA0Uo3klA2UAWu0myuJsWriSrokOsS57VQHrWVoS2RqLXnkI6X8krhUox1KPOhJAJSSlLAbJ6u2TEUhuUQdZo1HniM2Me5V+WsgMXjrW7Y9mVBgFxy5OfB75cipIII45hrE2vAIXZCvwUozY+wJbBj0zbqlCgHRBDWNS+q7oyNDiD7x/kxhdoNaQQdOHYPPX0S0dI1pYF/KfVVJ8nuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) by
 SJ5PPF64191BB3C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 06:54:10 +0000
Received: from DM4PR11MB6261.namprd11.prod.outlook.com
 ([fe80::66c7:4013:fead:be53]) by DM4PR11MB6261.namprd11.prod.outlook.com
 ([fe80::66c7:4013:fead:be53%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 06:54:10 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Czapnik, Lukasz"
	<lukasz.czapnik@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: prevent integer overflow
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: prevent integer overflow
Thread-Index: AQHcuCdCiNoo5CXh80OZSI5BsOf3/rYD/E1Q
Date: Fri, 8 May 2026 06:54:10 +0000
Message-ID: <DM4PR11MB62612FD9BA3F36CD37318CCD8B3D2@DM4PR11MB6261.namprd11.prod.outlook.com>
References: <20260320050544.422640-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260320050544.422640-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6261:EE_|SJ5PPF64191BB3C:EE_
x-ms-office365-filtering-correlation-id: fac15610-ee1d-4da7-cb77-08deacce9b96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: xfQFUDnII9XDxF9wuVlvJKrjoCUNugAokXP1ZYG2g77SY9y0OveCGDu16jZgip9fN42A2nNDHh77hDwhmAoCXfwFe57El8G3ZNufW4823bq6HadB9We93WoWADJZ30A2qaefNODblu5CKi0PO+JcFxwDmLNxXZ4lSJ00G1fOxWBIwp1V8LSNLwS/gut0sDiomJLVjPvLIgW5/OzxtbS+8lxVu/S2YQIwWBwoLiYLOFxqYy1vUl35UZvnZjdEjGE9gpwedCE0/gZZtuTP7KJOAaqHsXhehezCdSJPlUPrdf3dwg5/Xm0pHjrZX7b5d6zodCQgJ1bTqP6Uk94DeZgSuY9xEKEWEEjAC4l/uSNc+RI1w4tJu6C0WRYoYvB5QkObincffpz9VMt708I5hbQe8SsK2ry48wj6TbJ+xZQoXDFaf8G3TtSM4Qk7PU00oB6cnPHf7HNdHL2AmPkWNmxtWwmzREmctXhwCLSYCddCWnEwrX5Sgmr7YMsdh5+UkTmmQjvp6wDF7tLw7NueZK7lvDWFNVFB0RoyOHe7cU4/+bXO+eFkc868F/n/dbqSkaz4lhT7xTrK7XEuIwXUMQeenQ46/Qx/9GPnl3V8yK2QHtbIPvrzJxVMqMxMZKKuZnmLE0aqxtLjZ4RHpa/Fa1WPKbU1kIPFg7inJKGTfhzP2u20ZmiI+6t4oxj/J5ScqMVVcJhbq+/hUFy9oS3m0lNjfnBrPrs1mDqu+3u56FS8hby4HwQOexg6FXeGOaZRAmq6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6261.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/iwZNwBFlRf/cHbGcJwTFOE4lQ9MexUp25clzj4gEEbXYty0qC9sEBCvdlPe?=
 =?us-ascii?Q?tA71giGQtOerM//ATzli0O8wLoUWJR2oxX7ICR+k/UQ5z36O3nqFZD/RuZoh?=
 =?us-ascii?Q?o0x2BHqOxj0fNbmkqBBIsk74Iy7h/dli4hBAJdK2PFClUpg+/Ala/Zw4RQPB?=
 =?us-ascii?Q?eZFdWHO1pfUm3RspeeNizqVXOEOqoL47l/Jlnb/MUMv3UMn5rODbKXdGZX7p?=
 =?us-ascii?Q?WqIHydVaBGbiAUplE14DzygmeUsYVhCHX3AxG19FrL7HkDh6UNvS3m6uw16j?=
 =?us-ascii?Q?1duu+FKrhD7uJ0vgQ6A1UjSq4tKgwKE3ZRIAn2EcVWm+Qd6pc852txKVheVM?=
 =?us-ascii?Q?QWbLvxPzbSD/hrYkmmbu1ekuMkfqjjRHwdq02k+ZsZUxKhqHrp6SWsqsmJyX?=
 =?us-ascii?Q?ypFYvtRRWEIaB0NYqvHpXk+uaQE2WeQuIGpKUXjtwWwg3w5kzj2UJzeUmGXA?=
 =?us-ascii?Q?vRnwMJhm/3wBKT//K0hiLYvOAqS33MjO5stBa2SyleLsSWB2ReiSxKi7IzCu?=
 =?us-ascii?Q?W2Y0xPpG84kjthIEzsixe+yenXIfEUkbugiLYmBlrNtH3+vwN2ih312ytq4h?=
 =?us-ascii?Q?vbp0B3f811Zit+iYwTqdlPzxor1XfGhldC4RxZhoyUwjxsv7glh+Zv5C49kK?=
 =?us-ascii?Q?8l24A9wD9YiivgrY7bikUx0ow0t44FaGqRicK0Ln1AOY4OaZkzsF/lzY8erR?=
 =?us-ascii?Q?ltifwn2hs6Zz/2P/P7E097bRJkyBhb0BHIPwxK933KlEVlKMiJ4520vHN7fY?=
 =?us-ascii?Q?OarineGAyefBD9sxfc7FkTCMN0hb9y9rCTpPk+/HTQxwLsVOKVi7mvqJ3qEM?=
 =?us-ascii?Q?8e721ncWAIdY/oM2mf/07rc6xALBNNLJ9rleu7sato9RWCZB6E7IeLwUXpMs?=
 =?us-ascii?Q?gHPN1ei0ZCgWDkGH8Oa+tk8KeybYDlqVi9K7t9PNHo5H4m1RIU6xutU4O47F?=
 =?us-ascii?Q?iWjFVkkMxkZrmsflmTsIcl8DabdW673kInlGrPEtzWPHemZAGY/e8zIGbrx0?=
 =?us-ascii?Q?f73JvnOCsxT4LrVRHtUtn2GJrnOV2jyL7S8Sx5qUI2Vm6/34FCPvcL0Ev/+Z?=
 =?us-ascii?Q?+TTEXk6RID5V5RCcbYYGwgna69/+ii8Ci1FqVcP5rBXTUXagXRmqsp5tV11h?=
 =?us-ascii?Q?tx0byp6tkzl2WSGsaAehgAlPuhddv7/UKAZ+ZRK49TdU2V4GtUDKf+KJNC8N?=
 =?us-ascii?Q?wOlPdjal989yu4eILsudChRAeqqOsRo0+uwjgZka7okwHBZf81mf6A4kv7gM?=
 =?us-ascii?Q?b7ZrqRa1I6n3yiQnmzqjTtepuCgJgqbxl82ffYXaSPBqDtK15vbdPd74iMTP?=
 =?us-ascii?Q?y8GUQgJMFpsh8L0h+Tj+jenQnMMUziN5UbXwRqwBVgCxy3LX1ARcPPvcujCh?=
 =?us-ascii?Q?XaEMiemebV5CX+hCuyo5/7wnSZPsJSu3bVWu/cBnAvvY2uD0lechnAlOsYP8?=
 =?us-ascii?Q?AV9IuVJarD2dVDMv+Js14vWtqxUk8Yi5lNvyom7Cf6OTrJGiOLBLUUpqsk3z?=
 =?us-ascii?Q?D8JHjJBiXmal/ZxWCXZzfxOd/6MiOvEFwPdyrk+PB7vg7gaWDKcORxYgWJWw?=
 =?us-ascii?Q?EW80XDrTGXyMDkpUs+iA7kcj4ur3I7TO0vN6SGs5zAoOmGED0HloRnNWG6bz?=
 =?us-ascii?Q?vuCKm+HyOx19jGUywFMDkDdI1lVZLoUM0ljj8nj8Xe2W6x2dJZSZMoaU3m+L?=
 =?us-ascii?Q?HdKHpj/g7VAjrz7xbgHMnWITm44Na0Lx6pyMOm/YC1Ob2OhX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c8nWDTmO/j71F0HhhAu63CO77C8blyCIeyMp5JHN1itkf8u4DElD3+abkB+ZJW3g+MJ8YUXXleon5JZCvIcnGleIJCNjRN2DTS1juUE9O2zTYuJefYRHE/AWiIpVLbg+6R7Co5hil1yNKy7p75MKx9CBEpJ/QDoMVFDUzq6/EvTJdUkcBGAuaQ3I6PkoR8e43fWgD/pJBGZYMgpEVlmuvI2qMQkDNZHMXBVNerM4ewQ9CEfchyb5TVmcP1ntNxJuWrd+ES5hFy9erQZRa/Q0SwIZfPpHVaIGrGWccyTH9EP9JXzEbbSl75uGQd6TFtQLD2LJNnCAbr7fjdmHOy8PbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6261.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac15610-ee1d-4da7-cb77-08deacce9b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 06:54:10.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxrLGc3XWXI0mkdYh80wICI5PceR4NAeHcFfCfSaOb6zsI5RC1UhSAHGLGtS2A1fMRQIfk4W8PN/2M7dxB3CXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF64191BB3C
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6A45E4F2A81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285677-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,osuosl.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 20 March 2026 10:36
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: prevent integer overflow
>
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>
> In ice_sched_bw_to_rl_profile(), the loop over 64 bits computes the sched=
uler timestamp rate as:
>
>  ts_rate =3D div64_long((s64)hw->psm_clk_freq,
>                       pow_result * ICE_RL_PROF_TS_MULTIPLIER);
>
> where pow_result =3D BIT_ULL(i). For large values of i, the product pow_r=
esult * ICE_RL_PROF_TS_MULTIPLIER overflows u64 before being used as the di=
visor, producing incorrect ts_rate values and potentially undefined behavio=
ur.
>
> Fix this by pre-computing ts_freq =3D hw->psm_clk_freq / ICE_RL_PROF_TS_M=
ULTIPLIER once before the loop and then dividing only by pow_result inside =
the loop. The division order avoids the overflow while preserving the same =
mathematical result. Declare ts_freq as s64 to match the type domain of the=
 surrounding arithmetic and avoid a redundant cast at the use site.
>
> While at it, scope the loop variable i to the for statement itself.
>
> Fixes: 1ddef455f4a8 ("ice: Add NDO callback to set the maximum per-queue =
bitrate")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_sched.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

