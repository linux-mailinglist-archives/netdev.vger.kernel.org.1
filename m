Return-Path: <netdev+bounces-119012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D72953CF8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5448286D8A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD54115443F;
	Thu, 15 Aug 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EOyNvun0";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6FVivr05"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A5153820;
	Thu, 15 Aug 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758930; cv=fail; b=qCx22Ypy0iKxSF0jPJwjcUgFYGyvYGtZugtkrDDMEJkLw7kB+YeJs/++JJBqvtOKb3YDSEJu3BIn68XQW1qxLhkrJzTpQIVMtug7oSmU1oXTxnW+vPwVpqpJmKSQwjVo6+mvOqQGQ75ZMxirxGPRShP3zVmAZs+j0pwUHDUbNJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758930; c=relaxed/simple;
	bh=eC8q7viVzTtgb1pFEFiGdpWGn3/ga5nByD48li7wwp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kx1NT/xnYvKKO6tliYXxt7qRGg10MSfQIaklJ0krHJ8ueXHiHV7hXzXeqjL7Gb5lt2zXKRj2by0IUyMg+H0G//GvZPTyS/0tnAnAP3CZyO4u3EN0utoh3YzyzF+e//zKCwm5jTVxk2L2CMems7QnKggx9UcgkI1pHDqrIhffSh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EOyNvun0; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6FVivr05; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723758928; x=1755294928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eC8q7viVzTtgb1pFEFiGdpWGn3/ga5nByD48li7wwp4=;
  b=EOyNvun0M84dmeDNo1QneycHUqieo4QMtE77zHGcTLKVqJE9wAZOuN85
   hb/ByYy12c0wZ96OwUjdKZGrTqDBzF6GMOqEtfyekFNy+NZtkjhH5Fsj5
   jJauHPZ7VZDIB+ygEIfYleiD+fsk+vrRIJyg2cJzEd98jPfgSFxT5jLgU
   mlQBA7cTwTd9khf/7Uco3I/xFBKXiRj+xxhSmRj36K7WknfqT5WainFpN
   u9DpZa9nPx7lb0AMIZBEXlZmY9MkpOzWNUtzaD5qR4lCnGSyYSEsLatTI
   ki+eUrhKaQeN3bSFN4sfLsnrDpYFG3LYDMSRbTzDTwq7Lcy+HeDcwY2P3
   g==;
X-CSE-ConnectionGUID: qEoyvxpUQwufr99wSjNVEQ==
X-CSE-MsgGUID: QiSrm5dJSYakKOURt92w8A==
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="261466597"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2024 14:55:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Aug 2024 14:54:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Aug 2024 14:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZMywJp7AxoymwtgtBQfSdHDOMU3DObu9ZO+DPtU9MsPsRp0k0w3BwNv877v0HHg0P7WgEbLBUDI0aZQqpeqQoGOt7iu/d6JV62s+B8GwyoFNTXflL14LVSDl0kfUYNqIq5GLVix4CZ1aDFne8NA9ZOZb9lp68fIZ6eYLnyvOf5vleV2JAD7Gft5qTLx/NrGqROo7rHasJVWY36qYfqsID8XWi5foVok8ZnFlTrnHx17Jxmp9V9YLvnDeIGPSDJfJNiaT3uqeINJKbOMbDt1ORiJuiliYuli6v8gWFl9KiK8LzCmzdrUORT8Fe/UR+nFFPiDmAynkY7JEXmI3NFZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNDvFIuWaKPbZOR4/QRrngt9xvPNBkkQuhvW2X7Frto=;
 b=pzKMfCMc6zRjbRsdwCR7BnktaJGu81Aw4h3jI7GM7Ehs3IH7M8fTZE4D44a6JgHIy04WeNN8/aCIKGkBOxd6xelUdzwrjn7rfkcH2u9Y/h7HJjlI2yG12yR8wAR2G49q3/ctso7XrGgKAFC3Gx2qfKYlRDTmQPt2Gf2Qo6Hx+l6BmWu1GQGXaZ3vZKsNh1sr5Sc6ga3g/DLrRX2MOSYFFq0P1oLnmZ3u7ohDMbPwMfbkMSqNcxPZ5NuFynyyXYsdDPCxdE1qPJ43ou2ANAzCPSaNw72mncPI+QcU/Nh1wEF4Z9PHKIwdaTNLdQ3yewV3eSsSVkfm0yVqy4UoiudB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNDvFIuWaKPbZOR4/QRrngt9xvPNBkkQuhvW2X7Frto=;
 b=6FVivr05HgZhPlMukVqqFlwqZ+NXZ2vnLEZC5+5IJ2U0rFgxFDiTVtCNV4jj19TJIdgqGq+ML0kUB9Cozu2WPdQCpWfkxluEMFSjJlslMDvRQnqnoPuJQNGXrzI++zmI8fkCCmkv4TS+Twwk2D03Rn7H6Vi8uqs0OBkqlKxvpWvV1pBz6+ve1Ttjql4w2H1gIIBEkV1v9Hiv4C1pX+yNp65yxLld7oS5MyT/TqwxhBi3AyiF4tFdwobxS+C01AEP5U3/3M5TrZPTcG4WYVqFeghBkPqWZChIaIj6GG2hY6TKPLh+eFuWut0KZFyzaYyb9/9qt7Is6a9ajlb8mLeF1w==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 21:54:48 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Thu, 15 Aug 2024
 21:54:48 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Topic: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Thread-Index: AQHa6rVb6R5b4khOr0216lt4AbdkW7Igv2QAgAT0oCCAAAcxgIAACFyQgAEI1ACAAJA2MIAAA+yAgAGEwnA=
Date: Thu, 15 Aug 2024 21:54:47 +0000
Message-ID: <BYAPR11MB355843A853269A3EA5C50D47EC802@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
 <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <9b960383-6f6c-4a8c-85bb-5ccba96abb01@lunn.ch>
 <MN2PR11MB3566A463C897A7967F4FCB09EC872@MN2PR11MB3566.namprd11.prod.outlook.com>
 <4d4d06e9-c0b4-4b49-a892-11efd07faf9a@lunn.ch>
In-Reply-To: <4d4d06e9-c0b4-4b49-a892-11efd07faf9a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SA0PR11MB4640:EE_
x-ms-office365-filtering-correlation-id: a0917909-82c4-4b39-f746-08dcbd74e1b9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?87J8/sKDIxR4tb6Ao/hU0v+4xyJu6ukGu67gTq5g8KKiQ2OqHP3uO8YAwmmg?=
 =?us-ascii?Q?HY4efvgfzPJpTFQQJp4BoYUMYUO7V+woV7/fvAD6B0uEOX0hZh7FpUrgRNUq?=
 =?us-ascii?Q?eif5o4CGl9tlTWXHh1iSGV2Gu2qSIG0bRrXcuanPMMayOmHDIaaAJ7fsQ0AR?=
 =?us-ascii?Q?VE/KL86i5ceEAUM9WGV++iY2/m6ZOZ4B1R2VXPAvpv/t2kHmPLpwHgZxZ6R3?=
 =?us-ascii?Q?K75jAMaBtLD09239+d2qeZhjt2volmhVZ8XsDTGJxLrp7CLt1LVpYhYCTdyV?=
 =?us-ascii?Q?yyPJiTMFtGXt4HDs8tcmtMm6S90+GFytxSX5xLsQpoTEavZaBd05MJEfMLXp?=
 =?us-ascii?Q?6ZRkkgt9/lJWQ+i2yeFRAuYeY45NHV+RVf0pE5u8Ho/czIlmLFbQ4UIqPEK/?=
 =?us-ascii?Q?QwUCtX45DK4twFyGf7zx37mI+X+TpaKJM6GeMGk7XlRieB/PaenoYWFLQm5A?=
 =?us-ascii?Q?HparOTU4c9ZP43WCfirWOhroQ1j2l9jSSvSzRgYrHmd4DZ6ZfUjLRM9F1X7L?=
 =?us-ascii?Q?TR6noI+IXuM+pnJLOE1SI0HiMqnw39wf0/lU4Wkjy/xTBxHMz3CD37aGR9ZM?=
 =?us-ascii?Q?cdC/GsNZV2LNkLsyf2RBaT3LQ2xlpdXtUJK4Jbhx40/QOOZdUZlw7PBu+vQV?=
 =?us-ascii?Q?lrtCZpdJqTZYwYRApW82dj6E85o6p9vbPFOMjW70fxGQzT2bKdYYavnHqIs2?=
 =?us-ascii?Q?k/ahu6sHvxU1XIstGbHsKfVMF1Ino7ujtz0YUqPe9GCYklNX7Zlm+V9D7WWb?=
 =?us-ascii?Q?osgBikg4xwleyx8cKCxZfmefvYKWGkxc67BvQyruKw2bZ2S9MATn+qhBuByY?=
 =?us-ascii?Q?2g4Sm8eGrmGNyRo1cUPO/nCUgfDPuiWOcK3WL4YQNgiq9ho8BTa7jnq//qqE?=
 =?us-ascii?Q?Pe+BDX6InnkcTw/nQf4+cv4Gzm67Pdj4hCGkPVh+5yd2e4Me8Ci3mqm53pUi?=
 =?us-ascii?Q?vdDahRn7Ji6sUxgNBQ7N0rCw8ibHqku+eMSQVWFqyXJZV/fHd28WoJDQw9xK?=
 =?us-ascii?Q?Sa5w/7hT4sGzQrqpmoWd8zwYThjmUvFJIC2MmhPI6m8bPz0mUF6/YU6C5ZDm?=
 =?us-ascii?Q?pVojKTOl/Z+4AhbqcHITFtlKKJyfjjGdWbOWZelvSAxMl71WDNxaThDbvkKa?=
 =?us-ascii?Q?6XCvRIU1V4bBrWWG2prHAzVmU8i02t6nlTfGZ0ucLcvxT2qBpkL529jCe6wt?=
 =?us-ascii?Q?q9Ri1IATLlgErW+LZYJmIuu2/PIgWJZBN74GAR6K3NdOO9Y6v7XYEunPLczx?=
 =?us-ascii?Q?8QGSfvcwpS/EqGr9U/h6lv/hizE1Fb4gLGoI48Qa92smZlJ3LlSfyy5sltiU?=
 =?us-ascii?Q?nU1S9sUgBbFGoyP3ybyZUMj31GTAc1hS5zUXTz4LuHPOs+aaWvo1CbD77qdg?=
 =?us-ascii?Q?8Fr4VrC01TcNX1KkSAxYzLdkTDSKaeyNIS05EO3fPXtBGpvkzw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zW+zmemFWw3ax+BjtvqnT43K2WVc7EUB2PljuEgiFkaQzOQrXQl4uWL4Vn+l?=
 =?us-ascii?Q?SUmoVgO6wrKvkQdr8RljjW39fDuJ1S6nK5bXo4KPp8XJnsxl8FeJgM0OOVae?=
 =?us-ascii?Q?o92bRWrzeZPCR2LRA+cvEiundqF8uP/+I5yme+/DGjUWcsCzvw9TpDqobrgR?=
 =?us-ascii?Q?XoKlT+8yuZ7J4SqmfWbj9270flnMQzh+tOheeNeGwOUErcAdfn99kQaG0cXP?=
 =?us-ascii?Q?ha13HU66Yt5gykvYZJvhKkzEl27xP2eH3i88hLG5wpNK6U0FxZ/aYXptZPyd?=
 =?us-ascii?Q?MCs1RGD/0r2eb8GegQYV5yXFAPoabX0y11h+4jM45WS4eXGe5a4Ey9s+ZbCc?=
 =?us-ascii?Q?5F5/ZkTkS5Ptj6WBz0Nzbm0IlZfqKBQznZDeRYbWYattZC1qNuXSzK05KiDB?=
 =?us-ascii?Q?TfDpRWg0MDKTEpQyV5yB0jcZYxcG/2ohtZjNdZ3smE50sCEAYqMDJ/cw1cn4?=
 =?us-ascii?Q?j15CHFLhMnKFD/hAtZl/GJO2WsKksgqfhMZZFw0M4lJeqlODIzsdsnZVFUQZ?=
 =?us-ascii?Q?H6EEbqkN/F6qEEcfCXsq0LcjHBs2XHQltrWLWPorHe0hWIG5eTrZe+7nScGf?=
 =?us-ascii?Q?5RGHq9tvsCELOAkjJPJO9eQ4nKaX3rksn3KCxDDNv0hD6UpJKQCdXqBP4fR7?=
 =?us-ascii?Q?4I+qFGSakCFCKXevHElO0a5yylNWScyAVxkkWDo/GO9CCB6ajqZ507WIvmGE?=
 =?us-ascii?Q?jZ063l25GF5UonmZNEnlRvMmdpayta4kHBguCwUekGveN4gEHG78N8KOyXn0?=
 =?us-ascii?Q?KQPZLL5B3f7c3Kx4SNZ0smV2KWMjMD6QtfsYvDIDWzlf5e9nKMPgXX64/hfv?=
 =?us-ascii?Q?TDyKmuIQK4ku0D2jNwAzc4g41gAFr1+s0uQ9XP6mdcF/moPFcfsrMAL2qPP4?=
 =?us-ascii?Q?kLUUsGtFEXKKK/cFAF5ztsPavibQXt4bW3OrIsEE2/F+Q1+K2b2Ejsp8ZwZM?=
 =?us-ascii?Q?i+8KTZuDkXxI94s2V9JEA0Mw+wHyluJSj8nUm0YuJZkszdhYiyLXt5GmHuIl?=
 =?us-ascii?Q?o7O7DPxJ3TINaG+5LOWFnILrp8kb+SsB+b/y6rFRh0kdYLd361dOJ7DYFs5u?=
 =?us-ascii?Q?s/OBeO4zjumvSnldLGbDApLLAECxqg/Pnc0DRmsm4QT+BvhcsDaOlsuc5xfR?=
 =?us-ascii?Q?BW3oVOnqXjwq6xIO8OZyOMEJ8LFJbjEF3T/E4OkZD4PCRUsmZz0T+g8s6VR9?=
 =?us-ascii?Q?iSF+oJ522bKAzsc4PAnyb6dNGLneTd4enOS5IrGRV+qk/dc11KA2/b3scc/k?=
 =?us-ascii?Q?RCLIiacA6vUzS+oiZhsMxUnERy6QG/OMlciA3DByW8uSdI5ykd9yW+wjhKkO?=
 =?us-ascii?Q?WcAoMVLfSFoNqEU1AJaoOYAlExZAlbg32m1wKNBetcbacgm2cUOhjuMCjGam?=
 =?us-ascii?Q?B6aGZND3/yf5ICJgeEelgZSoANxeq3+HSk9VO66xy50mkbiALLtS6HNPG6JR?=
 =?us-ascii?Q?I+Zbg8K5h3KJeGhcJAggorl9ij/Evwizodz4rTPTwF3CFf0G3YDdZiq73IX/?=
 =?us-ascii?Q?1vfGK0WkAhR9w8evFOU6hrfUsqkaY85V6pWnVFLb79T3qBWdnoHRADS4m8Me?=
 =?us-ascii?Q?aiduNynLFE5Qa10TPkEOhjibT/kbbr3XwFMQ4YlI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0917909-82c4-4b39-f746-08dcbd74e1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 21:54:48.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBwp1B/48aAas1DvOoDyiUA7kthNhAtjDeq0uspFu/02zPd6arZVWS5Rd+mLOUDha5WnwurlfAvKlMaDsHRKIgkOiKyoDZu0yxJgLl5MGtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640

> > > The board should be designed such that the I2C bus pins of the SFP
> > > cage are connected to an I2C controller. There are also a few pins
> > > which ideally should be connected to GPIOs, LOS, Tx disable etc. You
> > > can then put a node in DT describing the SFP cage:
> > >
> > > Documentation/devicetree/bindings/net/sff,sfp.yaml
> > >
> > >     sfp2: sfp {
> > >       compatible =3D "sff,sfp";
> > >       i2c-bus =3D <&sfp_i2c>;
> > >       los-gpios =3D <&cps_gpio1 28 GPIO_ACTIVE_HIGH>;
> > >       mod-def0-gpios =3D <&cps_gpio1 27 GPIO_ACTIVE_LOW>;
> > >       pinctrl-names =3D "default";
> > >       pinctrl-0 =3D <&cps_sfpp0_pins>;
> > >       tx-disable-gpios =3D <&cps_gpio1 29 GPIO_ACTIVE_HIGH>;
> > >       tx-fault-gpios =3D <&cps_gpio1 26 GPIO_ACTIVE_HIGH>;
> > >     };
> > >
> > > and then the ethernet node has a link to it:
> > >
> > >     ethernet {
> > >       phy-names =3D "comphy";
> > >       phys =3D <&cps_comphy5 0>;
> > >       sfp =3D <&sfp1>;
> > >     };
> > >
> > > Phylink will then driver the SFP and tell the MAC what to do.
> >
> > I do not think the KSZ9477 switch design allows I2C access to the SFP
> > EEPROM.
>=20
> This is not a switch design issue, it is a board design issue. Plenty
> of Marvell switches have a PCR which do SGMII and 1000BaseX. Only the
> SFP SERDES data lines are connected to the switch. The I2C bus and
> other lines are connected to the SoC, not the switch.
>=20
> Do you have the schematics for the board you are testing on? Is it
> open? Can you give us a link?

My KSZ9477 board does not have that I2C connection, so I cannot
implement the change as suggested.  I am getting a new design board that
needs verification of this connection.  After I make it work I will
re-submit the patch.

Thanks for your help.


