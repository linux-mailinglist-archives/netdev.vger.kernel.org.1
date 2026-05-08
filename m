Return-Path: <netdev+bounces-285903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LDUOFIE/mlYmAAAu9opvQ
	(envelope-from <netdev+bounces-285903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:42:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B97B74F8E5D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7F64304CCC1
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9C3F7A91;
	Fri,  8 May 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6oyhxTq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7052E62B5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254505; cv=fail; b=qLA37fquE4MmW5U64/HhzlWw9GqwYBDVXpwKwkCzi2yiOXK5mvaxC1fseBH7cqayxZB45q23NhhFkOleMLG1/fZfykGdJ31dFSpL6E0txxbD2kzBavM5BTcvO0934gedagfO/rJsROadnuFsxhgsiYrl4v/1doGIQcM1VnCVhhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254505; c=relaxed/simple;
	bh=GNKtywnWCSXJXBOjmt5bTTcVeOKc+kRLZ4ifCNJtZy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFVcX/iX5jLY20DqsBdrn9k5OPZ/8ZQ0mEackqOT9uhG+A8TBvGU8jlXS24IzBEXIfO/x5vNvSwtgCBnowxY9e3lSDnMPLGuUdX3hKhhO5McBCfvZoi0EHTJrIkXIycBo9sqyka5CMfkebcsM0GF9GKmhTz9MUdDUOyrmlaDec0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6oyhxTq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778254504; x=1809790504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GNKtywnWCSXJXBOjmt5bTTcVeOKc+kRLZ4ifCNJtZy4=;
  b=Z6oyhxTq9B3QIFnxdSfAzbZ0SSORo+gPY8miUm/17U1HjgV8wDw9a7Ib
   Zsek7P8UCIIDf87kpgorib4D6CDRHjvheAV82JUnDJ+uPqqi5ttM0nku5
   iR4mj+hb0+a+Zdlp1fJhJPkcI0bPt/FGzlOrCpdmKlReUK4pkbt+I8Itr
   siIDLfWiRmAc8kvx1vRsn/CdKmTHLzEcXhVGt/tdBXmcYioaQXu9jeqTt
   p2QIt8sMwufJhHwq1mqB6Ov1o3SdiuEVmo88/Z5ogCIGqwHoe/OGLm8+j
   lzazMggdEcWAmbdG88kUFVndsziHnUB6AgMme/hzUtbJnHt+oF67MoWwK
   Q==;
X-CSE-ConnectionGUID: 6R7Gw/tqT/eWh8N8GY/RNA==
X-CSE-MsgGUID: t2CNJ9lnSxi6Eny8Nkxejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="81791106"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81791106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:35:03 -0700
X-CSE-ConnectionGUID: P1Glkz/tQmaUgnE+olrB2A==
X-CSE-MsgGUID: jAMsJUdnQKyWfXhaeTLDOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260527950"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:35:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:35:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 08:35:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:35:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCASg7vhNBBrtQPvubpq0QZYorNG2AWSuwZB9QetE2DAqAMGb+Gg+oB3qMrWN+KrocOk2aQFAY3U2pMPLDKyCaEXOEleIvDvN8sNcaMmO+iMzCFsJv6GhSNk5Dz5xscimuebYXmacxcnKb6rGOdilUmDpR3KS/JBd1hyrVbIa6TTAOUkTIya+PGskdkiYHP2rrKd/1k+9OfFE3fiDMFgxIeZ9hEfmJoRmi8mnV49g3h1PuxSsTvsukzph3fdYU6BG8INE84TnsiVYDNl6FoYHJP8xmxXzSLNCtmKoZH7jenu7FMA6UAw/TcwJuokRhHBolas0WI+rTmDFgYVC9XyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE3i/9ha7va3WnCxX6W4pfJ52QJS9rKc1F+6fDRcITI=;
 b=KE5p1rZW1eWM8UNBYVxxCQzkxUw7DO/R5MADMHnPQHe6kFEk61D6yl539zcT8wwbNyhFutzleXewyLfoZrj0iX40Z1gmIj5lA6xQ+Ffuehhs0viJgV+cn/5rwgciCMoyNtFZcaZ0lwiP+GM+1azc79FzGphFKAZkON1G7pRQOecu6iovyD0tSS1qoU/reI6KHWE5Q0gUZS/SZGWUX16V/XuIaHi2vlrzMPS7nWPMlDgU4XNaMd9zT1kl3kJ9nzlS33pHdHqeFWFqg7p1h5IxyP6BUUeVBmBflO6peynj3chFHeB019gXU+5FkqS9LZgWUus+0CB4n0Qeo4I6ZusQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 15:34:57 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:34:57 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 5/10] ice: improve Add/Update
 VSI error messages in ice_vsi_init()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 5/10] ice: improve Add/Update
 VSI error messages in ice_vsi_init()
Thread-Index: AQHcyL6lPDuetExkPEK1/2IddLeLuLYEbtcg
Date: Fri, 8 May 2026 15:34:57 +0000
Message-ID: <LV1PR11MB87903D7899563615F8FAA930903D2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-6-aleksandr.loktionov@intel.com>
In-Reply-To: <20260410074921.1254213-6-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS0PR11MB6544:EE_
x-ms-office365-filtering-correlation-id: f96467fd-d874-4780-dfd2-08dead175c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|56012099003|22082099003|3023799003;
x-microsoft-antispam-message-info: TNVyJ4oC6Hz/d9D367n4ABXkCEyUvxiLQriN7uNFtlb6AgcYzKGl7r1LG6NBY1EhbAgBNu7qeU8+6TK4s28KgAGohtjfjKt1Gd7r+8+4zxSUjqSxXs3UWHjfMpsGmIiiBJJq1srQAoOnr2qL78D3nOsAK+J5dfqtId1hQz7xnZzpm3DTDO/S/zcMC2EpdWProN3q1abEMp06cN0ZwiwcmW1S3QnsthFNdTLwXol+BLz/lD6hNndJSsc7qArp7YH+TiS/PoeGkuRC/9FZ2U1QO4ddYAVpDtpciUlj8IoC0oMj79FVEE1stmUSK6dYGo15f4h8UN39LkwaAJ5GLPR2XnZDYhdMcJzLkgggE6N/7t0HQj2NqszXETjo7bWFxHjpUnlm9IEkLN0XMQtTWbZQB3unzfjdhECQb5aL/NX5TrEitU6rCMzz+iVfcPeTXwFjy52gChqPBkWG6YL+HLg2nEgm4kjsicV4OPVlR9ZiyN6jnoK27FzeDAqqZGlymRhu6153EddiV/mh8wuyKeUg1D7JnxXom240XYzlPsXcaiGX6R8nr68EBrmwa+m4aIPIow/8ZcPcbapciUnU+swDmaCrZLhB4O9aOibG9WB0Ew745Sr/Ydo2is2/HSsqMwL6Ei1wvc5GGJ6reYA6QlHZ96c2JSCxOmRApOe2ykw/UsqAfMEMS3L9sdCuxxaVVJEGhSz+RgrICAgFLGGY1yfmHh6GvCS++vU/cu8/lcaxo0uL/ynsN4L0Vgu+uSxzKKID
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZ+1diefXJJQ2SWD6cjr88rIVSX3pbQLrQ+F1LHMto7TQOWpCIJFjTVTPapW?=
 =?us-ascii?Q?tO9bGGLKv5mT8A3r9sVYIfvgAx0xHZtljZTaVDJtcGWq/s0VKLSjHaGZ+eAA?=
 =?us-ascii?Q?0bwUDgml5mn9M3wZyjZR26v4kLpxd5vmgbyTwmsTTzAcVDSqoij6TGgQ2t9k?=
 =?us-ascii?Q?L0rYesG7ZtIKrmBydDg/jaM4z1jZw4jIynC0vRkPloo/sPsdswGMZqolvxCo?=
 =?us-ascii?Q?xw0e/8ZxNuxfx9boEJx0BTckts+DhzOGPwJhV6yPPow2/SRBQcxKMra3rOwN?=
 =?us-ascii?Q?s/eVLw5uCVOE7HwG0esPnPMqYSHlBqpctdKQpVNwdzOVMcc2BJLlzcqXJuZC?=
 =?us-ascii?Q?czAuhAPuCJVoytYIGk/dW6AwTZak7kBNU16JQJ1Cjx3Dm6uh0kQdnH2OfpXL?=
 =?us-ascii?Q?pJF06bPbBswfVy7c7A337fv6r5OvftlgnrRRK63OZlCqZeafcP88tq+rqvwv?=
 =?us-ascii?Q?YGO2AwSvgLlbP2CnvRG4Sfbp/KQPRgDJx1t4xl6oJseRuP4eeRO3lJDe3ma7?=
 =?us-ascii?Q?8nnzWMoHR7kJwFzX0LQC+HUdWf1OrXaUl3ZtDUFuYmBKlTheUOWJrf7/uMOW?=
 =?us-ascii?Q?GZvKbAib5PTS9sQHChYO1PB5G88qf4Q+GrCAks61GmVInpyaW1Xf34ED6UJT?=
 =?us-ascii?Q?KHMxhTWcsieuB1fq11nMfKnpgVaWtdqR4Ce5YTAuXImq3ZSkh28fU7ECqsnb?=
 =?us-ascii?Q?iNYp1HsQt4kAUpKnHa7XjDpBpD2OwWBhqdY0kiLr18zKjYNxejolXqtKv9+5?=
 =?us-ascii?Q?p71N1qwxsBGMDGS8NM9LLXsb9n29lhayWtxD7W0CUAXB5MnoAj1JAN5NJxLi?=
 =?us-ascii?Q?I0bNJP4d2V8m24sI7eAFjjojt3snO8Spdn//H7EHilT546MFJFqvNbodAXg7?=
 =?us-ascii?Q?FteMdlgU2nHISYxzaB2j+YBIImPYxNarglZBiBozkj0EtFwYvasn3dz+JUuh?=
 =?us-ascii?Q?yjC/Fmc1U1J/rFZUZiL2M54HrRLelvj58WbUw41icxLUVgCOyEFqH16QDTOC?=
 =?us-ascii?Q?FzGWHlFR/D2oHjXT5IomLjaOFvU1+DzKPf0jJUD61+VAJn0vUB9riWiiCvn0?=
 =?us-ascii?Q?4gES2593s6XfYWMWi6ZaA4uVo6gZda0V14l0YQqczPW8v9ftqkbxlLnlYz4J?=
 =?us-ascii?Q?58bGDM8RCnJNRDLamAAHe2q5/whhvBoIBAn/oLRROrFoYqMMLFLqw9F7j4Cm?=
 =?us-ascii?Q?nUbmjU+HBBSEeP9KJ2MI1qB4E5MlYD1X8PQgaIC2Avk0nO7ps1LuQVEirqtv?=
 =?us-ascii?Q?etr1u5QmwmCX6zAeDlRMTyeUGQNoaNSLDkHz8w1H14+84FnXfqlGDCWMgmVM?=
 =?us-ascii?Q?oPVT9WPP0i+inX7SvwNWtvFpP1c3RjpgK7jU49p75h742sIwZ3KlztLrBBGT?=
 =?us-ascii?Q?xxLwOUyUhssXEzOWP/ntMIPVChs9ovnHapsprPOdfbC38YiLVh8Y0MP0Lm9N?=
 =?us-ascii?Q?/bsT4JCdHvAVyLQOGuoKxLUeJT4oxDhqjmFqYumpNQJ/oNg4hn2bdz65V0Ok?=
 =?us-ascii?Q?rtNygIpwRi2xGGNSwc6YKDK8z3PF1rhK6ukzB0loZdOUdOThWc+Pr6q9CD69?=
 =?us-ascii?Q?OxwLoxrrSA4pomo9Rr5z+zZtb6br7Gl3GSc9dGqzWWABliKDvJjBYVN8mxkN?=
 =?us-ascii?Q?8eY/XNVFDjfV+2ixsrEqAFg6kAjUMr80pzdSQPmTl17VD69j9T1Uexh2nh/L?=
 =?us-ascii?Q?HOk7ETHUxFCggpqfUL3OQRx4GcXf1arudfuw+Ma7mpJlhnokodKN6ubomT75?=
 =?us-ascii?Q?Q3uMBxEMjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HVyrUzdmpiAf8Xbl6TQYRKWL3ea78N+EeVLW8Q+JI357JxamvahqpvhGkLlTGUISBy+fsfMfaQeNtb2cU2KdttuRrUyPMMnhl0MM7T+a7P6d+phLQ2JA2c0cMzdFnvrMqj91/MrLl4usXxrPLuDDzyQNvcfkdLyooVdLIipQCfs5CZ8duZbxPVlnipw+oHacUAEcHiREh9+mP7P9MSmZvuUgYikPvUkB1ylDFmusXimLwTwbn+HPorUpoTLrBDOo0BzPjP6+7TpZfdD2bkFWjS0aTUY7sjhRsGtGp2sqLPLFl57/uIqSu6Ohd6IaBxppZzkKBPoMCMwjsL0UZBtkcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96467fd-d874-4780-dfd2-08dead175c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 15:34:57.5109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQCwKzZRZZT2gU8Y8lf43o2qgDbjtzmMCBJ1XtB54yL0lDyvauLcKKk8RTrQuDgFs87l3XtTR6tZMgjI4ypIt8jtdS62lUMVjyNkWXMG7PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B97B74F8E5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285903-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Friday, April 10, 2026 12:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next 5/10] ice: improve Add/Update =
VSI error messages in ice_vsi_init()
>=20
> The error messages emitted when Add VSI or Update VSI Admin Queue command=
s fail are missing the VSI index and the last AQ error code. Add both to ma=
tch the pattern used elsewhere in the driver for AQ-
> command failures, which helps narrow down firmware issues without requiri=
ng debug logs.
>=20
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

