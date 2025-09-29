Return-Path: <netdev+bounces-227149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FBBA931D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F301F7A415E
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F43054CB;
	Mon, 29 Sep 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPuDKDxp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997F30596E
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148766; cv=fail; b=SjhLELh+8S81ezomyJmdWFgfwoC6D4YXvL09qIIMsChAEnsQXO2Bs4zr1W7OLC2OFwjWMa0soaBg+wnWd0G0EjLfqtdy9ayBaBmY0zpEKCI57C3cFnkSOTvWoh9xVUrSTpmhCr//gDL0irxviDAmgYEp07o1bysBEhUFtCR5dRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148766; c=relaxed/simple;
	bh=ngD9NIx1/fHsCO9ekb46bbOXvaruS+wPQgqPVzT9yN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fCzbjpq3xdgmUPlwyuoQcZca76hMpmjvEOQqEKKUOKkJl0x6hwSPosWWg7JXY8uqf1U8Ioeo6Wt4nuL8lsqI34euooPx4t3Hp7H/JfjKufPD0Hs0rew3CzW9R1rtlpy3fcxdHNNn3f84AVS3bu1cAkaYMxFMWDBme9b96ucP+5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPuDKDxp; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759148762; x=1790684762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ngD9NIx1/fHsCO9ekb46bbOXvaruS+wPQgqPVzT9yN4=;
  b=cPuDKDxp0+GLFjrRDDDEbXvi2hr8j2aMTgENojzFlKuH4Rh58vKd3tDP
   q1y3PNYEumXVL/kOadQEy2gIAZuwULmwKf1O6ooU31kVsDs1JDsz+MYXK
   ldk/M3ybiljkHjbMbKoltEywws6Q8RXWkDT0oY8MXFo69zWHS+WSqEEka
   RR8OuDx6B4uppE9Okhkkr+28Rx78qP9zyHQwd6XSB8mNOWWaNl33rc4Ar
   V3sz4ReGptj02ha+EcJwvpbLORXP3QClgC69aghZAzCSnLmoL8MThg1d1
   utipkiN+Ezpeed8zQK3f0K4EhiVNV4gEKv3gcLLQx8YrIxXUxQyvyqncW
   w==;
X-CSE-ConnectionGUID: tdM2uQfdTwuTmqLOkDO/rw==
X-CSE-MsgGUID: eFSwMDJzQrOeyPSooLr56g==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="64013330"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="64013330"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:26:01 -0700
X-CSE-ConnectionGUID: 6ZVZFX4yQZ+jtmrWZEAqhQ==
X-CSE-MsgGUID: CuN9jOs7RYGZ7OzeN1RnoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182640414"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:26:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:26:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 05:26:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXhZSfo8aMKMuYDLuaR8T9uZ+LfzI8NDiI/aJtoM6cJHFfTQesdd3hAiB76pgRKY3nwOakeOXYxfUJgjHjt3znXemzB8m+qzP1WA3A0JEf0cUkA1mweGo4/AByz7HAjLMFAthTlOQxE0nRpoSGJI+KJEhF51yLbkOcRtOeKW9+pT+ibcBQgtqY/VXmm/PIzkoIWFg68Uj/fcQ8GsGcVFglOWJQ7FP35ej0nc+xKr5nLiJH39iUgfG7SpCAd2GeBhvTGLto4Kuf/myVIIHcZcs4sWjKIGrmyePDgk/AQ2OhwInh2MQ+5NIv4O4n1uUCF/MiPTQSVOILbQn2ePUFsfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngD9NIx1/fHsCO9ekb46bbOXvaruS+wPQgqPVzT9yN4=;
 b=C3CF6AVuvozyjgP8YQ2yjbOCLf4pvYo+m2nGOH4uznrijqidrhkE5+B1OwSDZOlAZ0uGplNLEo8plQOLIU3pv6gmOkMUYNifBozzZwt2sgi3MbmHoeimvsW0Lp6LJIA7ugEpcKmyUtKiNwscAQMYBlZb0fQKQmCkTx84OZMGDTXkKrZAcmBkokOVUWNToStJ6MOvmjxNWY0nWH/k5MThH1vvLIndIaMP+uX0SiUNizBhzNggEauaU8Aa47EilOJ+C1N3vr+iZaUdDzOwdEJ8zJEVTNykM06nuTB4qIZZRbVDf3azcyJuStFqI8NHfr1SiPKMJMiWz7NUZOpNQ0snSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:25:50 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 12:25:50 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/9] ice: move
 ice_init_interrupt_scheme() prior ice_init_pf()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/9] ice: move
 ice_init_interrupt_scheme() prior ice_init_pf()
Thread-Index: AQHcI+ecKpj/iIh0R0C52YSXCQKoWLSqLbqg
Date: Mon, 29 Sep 2025 12:25:50 +0000
Message-ID: <IA1PR11MB6241E2916E86771B5BE39C0D8B1BA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-4-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250912130627.5015-4-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CYXPR11MB8729:EE_
x-ms-office365-filtering-correlation-id: 656957d2-319a-410c-a728-08ddff535365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PHF66hRSxgIkbUmEY3+OsTAji77ZMm19/YPTXsg8VcK0jtUlru0NETC7OywU?=
 =?us-ascii?Q?mSbTliDey0whxIEJhBvzRFwDOYaaw/fr3JumZ01enrghfcc8SPULdQBLT7Vi?=
 =?us-ascii?Q?x0oLLNX0afMiSgNX8pHjckFgSjGahEbkTQ286quc75wjI7t1d1BfB3bv4G5E?=
 =?us-ascii?Q?V4KKmzd4Gs33QcNOMAPNxLP4PwjN/3ihIFmj6CQeTD9r37o0bjO9ej5qifb7?=
 =?us-ascii?Q?v+nVZJPCsym515oito9s7trIfRsYWmZL0gdTr7BBCsuwqeu3Ok8rep5liuCk?=
 =?us-ascii?Q?9TGM6ZdokLBIjCGJW8P8fU6H2Tdn217gorkRg2yEhDJnuYvThJNZWSUjV7lO?=
 =?us-ascii?Q?/5HPXKO8HdM65YvbPDSMKV9sNZ52Q3RgQZXsJyMxzC8ORm/FkeihIaDLpnYZ?=
 =?us-ascii?Q?wUuN1KJvjep4nIjsM+duaF7K7IG7EPgGmCmPS9ccEOkE8oO/qTBzMDZMhtYD?=
 =?us-ascii?Q?C2TtgkQ1viHBjXA+z1LiWClZEOEerYA87BAaaTraWTTZKhmHu89jU1q9pOih?=
 =?us-ascii?Q?Tim6q9eW3b62laM0KBfrLnmt3j6iZpJP8IYeeeii5iIEPrpkfKUy8kwDAv4i?=
 =?us-ascii?Q?qS0hU54LjTa/k46sfRTZranUQ+/LG33cXiPS9pzngjKWqIkK6K5FhhYuU3aB?=
 =?us-ascii?Q?GXDUANtKp1POQvc0bfVeCiIhCzgqlZsR8jomuckQp9cgxGoeqGZ45j1rj3LJ?=
 =?us-ascii?Q?KqhVcNp+J0DUKIj4vZNIkexZO2RHXL1TMEzXsQXRqDT3L3c5JBRNMwMR7+n7?=
 =?us-ascii?Q?phMOHx1yAIO2YRZ8CWCy+tcSVMXVVC57k8VtTuV+DSiuLgF7sHIT0btpBGmW?=
 =?us-ascii?Q?Sio5BXDjsRA+g7eozrsq27P97ny3g9mGHywm4wUYx0bV5AizXBpSgApMsWW8?=
 =?us-ascii?Q?X9u5xGbi2HYY7Ksi3Tk76AUEy2K1jNkeugIO8xdoB5K3HHSRQs3XUJTrFnE3?=
 =?us-ascii?Q?/wDskaqpvXdwdxIV4acg3ZyWcafIeujp9eL5nJslE1m8tnei2/cTeksgVucL?=
 =?us-ascii?Q?iSkUoCv2tI8AgXrMTL3OFaOOHmFFBf///iYrX/k0HuAHd6Omdg0b8ayaaVwf?=
 =?us-ascii?Q?fHidZkha+n2Vo9fOi16rmqmFFIF/WyYE86kwPUFUMDxDQS8Wp/VcZnmuH53v?=
 =?us-ascii?Q?hhZne/ZS+sStUQgGjYENGuPQ6xxRbgHTIvfst1kU32Y56bJwmuJOnN+uqily?=
 =?us-ascii?Q?4zRIbjaWDKGcU9spAxGO67FdTk/mSEwYCHobkqeMoT8tbPIk1yVldjw1KJPI?=
 =?us-ascii?Q?VZbt+bf+uwcnwNnmi0EAQIb+VRF5mAUAD8bQ6RN0dRzddszLk8Vaoz0sO6dV?=
 =?us-ascii?Q?icB18B9s6UT3NC9J3jzGQ1Qw4tbuXB0svVgSLRqRDYn/zQZdgJVvz/LGyri9?=
 =?us-ascii?Q?8qmH+ac6wKf/Jr2WVbVXy7DJpvY8ypjA6x6NJTK3ZKMEzc9utsAjha3Cm3O/?=
 =?us-ascii?Q?fRCgSIGpbJfJn8PHqTQ9YJ7jiFyVwIx1tY/jKCaIyNR2ypVxgtqpF2eYRZgO?=
 =?us-ascii?Q?hIOwK3LobhvE2F4yOxvuKyAlguej+w85KeI4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wJTpJlxRlopjV+UK64gVAPOICjGjfWnDdfbCnTfo1DN5TB/poe216Z+7XliR?=
 =?us-ascii?Q?CSiWc25mA12za8/d2lSuGJxtGS5OdLDJ+CUdxHoGwo35tl5Rxws5pDZf42Un?=
 =?us-ascii?Q?cx7jQ9x0ZewHGyqA8ZS9/GmDeEMDFGR31BZ/JKYJlP0bwH+Ok1vh4k4o/YDB?=
 =?us-ascii?Q?2q4HxNx8KZbLq0zxzocaiBkZOCCJig4B0U1SKwwew5RfocbtbIwVtpyv4JPe?=
 =?us-ascii?Q?Z30cEsT/5hE55PCBHjPje/z0FgaCP6jwgWF8HJZEWpXDxecNpC3YyNxYrltn?=
 =?us-ascii?Q?681X4pUdwvxKTwMDAXKY6q9z5rEFoYVqTg3cDJi0La6x2lP4MnSNLJfH+pxL?=
 =?us-ascii?Q?FffcLAdrKcFWWw4eNDd7DsE8olYB01gipmYbBTekBQtUlt6a61wCpNyKaXnz?=
 =?us-ascii?Q?islvU2ggdxukHHnuNhyrlUjXoUn7QLm0EznZ3tgaU+71Jo5DHtr9MdCRByzR?=
 =?us-ascii?Q?niIOahdJkcgEAys3P9omIub9gTd16y2C8xXCn+ts5g5p8zotcDKcXQHhL71B?=
 =?us-ascii?Q?Hq0W6T+nSyntWoW08ljJuFehFNhIrW6/VFIySkKDyOBQy+y2f0XSDTfGY3Nn?=
 =?us-ascii?Q?pF+F+wEMRSXnVbDfixgVTTWXLUKACU1R+fVkZw73UdHz3qJF06ecypn7pMKk?=
 =?us-ascii?Q?VT4OE5bAAkZCwJ1hLuy5JNsIMqEPptRobXzaaXkpM6NOt+qVvJBO6KvS63G7?=
 =?us-ascii?Q?TFhxqVY20fpwSAD9szRqCx5Vf+ZklvgbmGLr9oYIv7ReNTqsd6qcr4sJxMBR?=
 =?us-ascii?Q?WCzW3qMRUAOw07VqdvxYXoUeGZTkXTf7IDPaB6WXHUnvmz2r7thhQk++uYTC?=
 =?us-ascii?Q?ms36aMrHmjycouUWvI/77oh65RHxWIU4NyuIIiQXiYruDzxvOkh70akI8ox2?=
 =?us-ascii?Q?1Yu1gbAlWH0kXcZYdZ+El4sXxF/nQdUQMJ7II11lJqMNv6lo3H+fkACzaK6A?=
 =?us-ascii?Q?bSvgoi//oOp3USbSQObhFz1yOgyPn9Bxf2v9Bd2YzeqQj9OtYqNFfuYEystm?=
 =?us-ascii?Q?jLD+a1Z04uAGF2y1lhUD8jRXMt5W57GX9OCXVg5bVhT8th09qAM+KYOQQZMT?=
 =?us-ascii?Q?JuOcVD+H7SlgiC+O/zWykwuTBkQpl7OlEqIGVrH0rmioan+uQLFLE1ZQ071O?=
 =?us-ascii?Q?wOpdNZwCpV0VVy2bX+UBfTDErdvQZ3bHQ1NSD0joKL+rGNRtJXf0JOZgU5Uf?=
 =?us-ascii?Q?kHenMQKzhANwTjAXsBe1drUzOXQjYFRiGJk89Zxge6ImtJBO18qdN5igANap?=
 =?us-ascii?Q?8jtj7z404yHkTl0geh/pKi17ywotMTJp4i819rh5Sy7RtwdRW/6JAXTyRONl?=
 =?us-ascii?Q?taeWV0i4bZd93H7xVe64JZuGrt01gey4KY4f4iD364e0O8LBYOFxT+eYi4+7?=
 =?us-ascii?Q?xM11/NBSFZ276bd5faN/pJEWdF4J61hRZ4iF88syKbqp+X0N9YJxPq8w9478?=
 =?us-ascii?Q?BNXhli1PI4mzGdVjnyXmMskIT4nDActn8h9Vkyvr+dAolVoZnbQySY913D4k?=
 =?us-ascii?Q?QL6EZ4/XPcpwove/0SVf/ujARCdwpUOWLENvrorq7TrsfBDmUulCc/Kuywjp?=
 =?us-ascii?Q?UNdyfN+/6XPD4sfncvZ1+r4dfOOAqIY5p8+L2Nw1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656957d2-319a-410c-a728-08ddff535365
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 12:25:50.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qOzFhgmwmDLd0vXGFkoEqA+qMwvLVDC6eu0mPh/uTEB+LJ/GMj8E3SuStkCG8S043fVPsKC2DAeT7t2FaYDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8729
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: 12 September 2025 18:36
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Kitszel, Prz=
emyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@int=
el.com>; Jakub Kicinski <kuba@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/9] ice: move ice_init_interr=
upt_scheme() prior ice_init_pf()
>
> Move ice_init_interrupt_scheme() prior ice_init_pf().
> To enable the move ice_set_pf_caps() was moved out from ice_init_pf() to =
the caller (ice_init_dev()), and placed prior to the irq scheme init.
>
> The move makes deinit order of ice_deinit_dev() and failure-path of
> ice_init_pf() match (at least in terms of not calling
> ice_clear_interrupt_scheme() and ice_deinit_pf() in opposite ways).
>
> The new order aligns with findings made by Jakub Buchocki in the commit 2=
4b454bc354a ("ice: Fix ice module unload").
>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> CC: Jakub Kicinski <kuba@kernel.org>
> ---
> drivers/net/ethernet/intel/ice/ice_main.c | 25 ++++++++++-------------
> 1 file changed, 11 insertions(+), 14 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

