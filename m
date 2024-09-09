Return-Path: <netdev+bounces-126578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B538C971E66
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00FDB239BF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4673514;
	Mon,  9 Sep 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="WtWlOOY+"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022075.outbound.protection.outlook.com [52.101.66.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C098A945;
	Mon,  9 Sep 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896772; cv=fail; b=oVEzW8lwrxmEzvHjJkumQ1pFLimHV2hpelDs0HQHGzfaTxmu9C0LPp8UHG+GCyk/nzVGxo6FjZAq+adhwkCFPXUVTR/pAyKniGQPcuVZ3Kb/y/7hvWzhskdtuAJ/UUm3s3jehCtlLqicgN20Kj+ySbSjVJXKlzZbpmod7/h1ALc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896772; c=relaxed/simple;
	bh=pPuIk3khDqwnIM/SUoS6UhDVCg+DYAKZkXjVSvmyixk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=us7frW44IXMWawxblqwwdXL9YYr/kPmO3lL8KfJPNjfV+WtBmq8bS5itSigPQ9rxmN6Up3B1El8+SQPXkwE8KO9PzSYAXjyXc2lWVmnR/OnEgl9IbGI5xVRa/adTIpvbaSA0xFc9bwoi/3IC8ifWfJ4V+ubpJnyl7X/8ye8DWxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com; spf=pass smtp.mailfrom=silicom-usa.com; dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b=WtWlOOY+; arc=fail smtp.client-ip=52.101.66.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silicom-usa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/22p9Iv46S4XvYLj8jObefdxmblSm7cIShCP8HfScOyEJ8lIA+fEavYnzbY0pkhklpdPNoy15IWar/pz91rtzHy8IW37IcaZy3jskktvnEDULAnJlbecenKZiXCzINPNlxflLgn7H5BA1LWsK19Cf1P43vvIcCLQ/5I0cQ+KsI79yyygFJeoLGwfrIg0iUNKKOo7Xk9hdWXirwT4suKv4KzV7tktHAOFjugM+L6047WW4aKRatHyrdDjrnKeYSHI6eku3k6xszj018AT3u2anbVNt6fY+L2nFt8ScHatlubQxJ29nATUkVZLImzZM+0ijHh2PrTCWTc99zr3KYWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kuUTBiomU2S7uyJpP3UTtCkDfd8KiIibh8kfXnV978=;
 b=oyEiJaVHlebEEb3gQo9GSTGQ68Wle6okSQVecV+2xUhjb5iKEg6GQJU9Tjn3+h6dVlHsFepUsDeEY2HhFABas5jaXTRtPVs+tTKyMLw6dgxfxb0xiEOnbFfz3Qj6oFdBQewgJ7HvSbvQJqZJeLI9Elh7uI612wZstJR3gbSllJDXKfYDwOlbHkxAllDHnHfT4/vAXrhAuzVi00jIB6SDYh0Aeqkw5VLQv6pUvJpecCsKrpifY4Vp/6Isbzt6HsXFlFqeytgCVYoklJkC55eXoOyU99Foevl/pjCxMApCruLNR9tmcIKGhHFvjSOLkXoFIv60JfJectzGl3za4zjBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kuUTBiomU2S7uyJpP3UTtCkDfd8KiIibh8kfXnV978=;
 b=WtWlOOY+FLgNeA6nIRXogU/PJoSWkzNoyo6QMrH3xHH0VAYoqHwwCBFDN0VNTArbVqK54Y35Xvdag/Y4F/EtFazeDQZFMczPyLCxQbkAji5+nqKhCCjyTXbPha74Tqix/jKCttusWmJwZm5/uVnyyQyTq246NtjtZBYFicygpPw=
Received: from VI1PR04MB5501.eurprd04.prod.outlook.com (2603:10a6:803:d3::11)
 by PA2PR04MB10448.eurprd04.prod.outlook.com (2603:10a6:102:414::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 15:46:06 +0000
Received: from VI1PR04MB5501.eurprd04.prod.outlook.com
 ([fe80::610a:d9da:7bd3:b918]) by VI1PR04MB5501.eurprd04.prod.outlook.com
 ([fe80::610a:d9da:7bd3:b918%5]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 15:46:06 +0000
From: Jeff Daly <jeffd@silicom-usa.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ixgbe: Manual AN-37 for troublesome link partners for
 X550 SFI
Thread-Topic: [PATCH] ixgbe: Manual AN-37 for troublesome link partners for
 X550 SFI
Thread-Index: AQHbAElnQB6kTGxClkGw2bZQ9JRTDLJK6aGAgABP6cCAAAn6AIAEVoKg
Date: Mon, 9 Sep 2024 15:46:05 +0000
Message-ID:
 <VI1PR04MB5501658A227BFC1A832B2627EA992@VI1PR04MB5501.eurprd04.prod.outlook.com>
References: <20240906104145.9587-1-jeffd@silicom-usa.com>
 <becaaeaf-e76a-43d2-b6e1-e7cc330d8cae@lunn.ch>
 <VI1PR04MB5501C2A00D658115EF4E7845EA9E2@VI1PR04MB5501.eurprd04.prod.outlook.com>
 <ac2faac2-a946-4052-9f61-b0c1c644ee59@lunn.ch>
In-Reply-To: <ac2faac2-a946-4052-9f61-b0c1c644ee59@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5501:EE_|PA2PR04MB10448:EE_
x-ms-office365-filtering-correlation-id: a4e3f78e-3b91-47c1-c4f9-08dcd0e68459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1xFSWZ1OM1tu9DtAn5THQtRRAnC/AUmwzb+BjsIi0ez8t1M6ktuqQa1Duf8g?=
 =?us-ascii?Q?TLj2AUL96VPhIXTp+J9FaCY4LbsoYgnHbJjNEav9KtCB/qzEhjVUOsD9pfm2?=
 =?us-ascii?Q?MBYohyuqWqFjFnwGZMMhgvhlW4C+Yidg4LSuHF5rWqtfF4gXPtIXH+u0X2ts?=
 =?us-ascii?Q?jMhStZTdrOKaa+SPOKRdDOQuOYwydyj/S1aAQlvXYUBsRjUSYqd5vpkvjipX?=
 =?us-ascii?Q?7hhwTfOrbMqXUXYbH6W09zUI15ZF32F+yWkkpTPK4x/p4fSa1/HAbBWVFivk?=
 =?us-ascii?Q?ruZd4wCTWqlWPewDFDSMgiuEnPl91lIkrrXmMPXReJMLJNE+/M9iuoSNG/8Y?=
 =?us-ascii?Q?It+N43GVCFn5tXb6W/p0alHYpRoHn8NEw304d3kZLmKL7laNWMyjNWcss5EW?=
 =?us-ascii?Q?+7ykOjdwVcR35JrukXr+XNpgf3tBA2cjCqjE3pC04jF7h3+t790aQeedBHSq?=
 =?us-ascii?Q?CTNy5yYxA0t8SOKYifbaP8TSFeWkq00q1odIjBOdyGx86QG+yfrUqM1CzFq4?=
 =?us-ascii?Q?JsFS9rBB9O1mHrDu3rS4e70QPMIK0trVfJaEgq8qgRBpK8gry+Xnj3Nxggu8?=
 =?us-ascii?Q?DPBQyV6uIB+mhM90W3B51ZahX9PlM+8fRacNKtkxo6rD5CQNBRUuky4egOvP?=
 =?us-ascii?Q?JD6DIsLNa0Yv2cba2Uv+KThh6dwIk5t5pbbP9sSdGpqVyoVdFSpXQd2kVOk+?=
 =?us-ascii?Q?jrdIa42AOUvsbyJb/TrFTp/3Oxt5kagnGtw6DgUAAdhcDCfDCqtBQLnOmAju?=
 =?us-ascii?Q?hVr+nyjy4P26ftEzfC8yefRrC/BgRRiyFV/lyAZ+io6EryF/D7tnpAONulYD?=
 =?us-ascii?Q?I9wfXjlD+xB8nENE2F0kso+V0ToYzPG36C3mIbj2KhmwSblbKZ3p/3hKBz84?=
 =?us-ascii?Q?noGIUsW1e/1UbQp3RGHuoDRJdEpkhhMBwF7iYN1spY9S4KcVldEO2Ns8bN63?=
 =?us-ascii?Q?nXwVAIHVLN+CX8ZlSFxuvms9YnasrGoiXbIm4WEgwTFC79uuYiqFzt8tJAwv?=
 =?us-ascii?Q?4Fjx8uVVdOMqlxyWo/g+BM1CXVf056OGA5K2u/V1Lw/wfpCo9l1Uyd6PYYTJ?=
 =?us-ascii?Q?o7/PFUaNisN5sev/tgkrk1VOMz5p3Iu55yx5SXDWddUgj/UzMDuFWz0iBCNm?=
 =?us-ascii?Q?7wCcK/CG0apTO1SzTnaVYJ503LomV2fV5zPBQ7l9Ja1pDkLIMvWHbQraMyxI?=
 =?us-ascii?Q?FJsWRiuXXH2Mzjh5Pd2npgEwlQ9OCP1bq53IcOOjNVasuRMgX5fY/XrlBMbh?=
 =?us-ascii?Q?fJ8CGAYYCyOlAM/mHl0m9l8jEQ3LRXNSnPLeozxODjiAfz3YlQzQ33d13dp3?=
 =?us-ascii?Q?uMLNc8wZPyYC4Bw1YqmM6OywyTycFAWzzFZPZJaBJnTem8a3jV+xJRgTtqtf?=
 =?us-ascii?Q?bQC/bi244qNme2eFzg/f0l+sfzuPRUcTFP0J9WYHUUlJ+mJ2eg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5501.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v15H5cF33Ml7LrVuZ4yhWdmxQGKGW3LHq7mLDoga1ceChzrmvQqJWXXorPHw?=
 =?us-ascii?Q?NLAVpW3QihLDkUFQOW5T9I6ZCZ6rUJAgtjn8+PEPS8h8SkxkRiDHBom6r+KU?=
 =?us-ascii?Q?gq7plwHbscmIN+YfF3E3Y+SpnGSoSHfPbQPI93rcj4pSr6blsZSSAjBGB25C?=
 =?us-ascii?Q?UwSDO+O3rLmE5PbzDFJpIdTJPejtzgx2LzC1pI7PCMN5rLadZ7ZbIqb3K7Of?=
 =?us-ascii?Q?b1Gg482MsetsK3J9fZ7DcDZYWU1Pa85VeQL12KgkCVkODRGqzscqti8Ok8EF?=
 =?us-ascii?Q?Lnmva+zgD8paZyOFejLnyobrdUAdhx+96Bbo6ukyX+5RXFd5pgZ1dEVXIZ9i?=
 =?us-ascii?Q?3ZNTPhHB6zO0Y9JVjYXMyKYEF/IYu6PiOKGujj0LZhHMhUZSVsXWt560pU+P?=
 =?us-ascii?Q?CnrgdDRaSVwcyVGGfSPlh9c97bRbgMf+anVeNOL7OAoYvdTFblaIaIvUZKW9?=
 =?us-ascii?Q?tfi8y53osrKgAKU7aDB7pKatL6htc7rd5CmXBlTmdpMtfNyF71BJV+QzsLYb?=
 =?us-ascii?Q?Pn3v5doT4CLE32EzB55rokkDGW1v40Ad4o4TcVdMi1ZXZcAXQrE4dAEPd7xZ?=
 =?us-ascii?Q?QHbr8mRiyqiFKXA66a2pM6HAus8IShCW8u0pVL+DALMWTS6IacReGSv7HbAp?=
 =?us-ascii?Q?vJNxei7EqdfTgpv9uV0j0yn9D/MLmotTGXD/Vfc3zeyG7hSwkt7ziQXy4lOl?=
 =?us-ascii?Q?vjHj0Y8IbaoJm/V00hVY5wh+5hPG55ntoj1dVshFnDKW5v3X6WUtDAQnAfFv?=
 =?us-ascii?Q?dWz4bwIwHGom4cfPjYvam08UspciS2CQ2FRMqbeRRZrGrw0LHbJHpcNZjUI5?=
 =?us-ascii?Q?ua5V4AjISRLqYwaRl/O4ooS5H3USq/vO28egw0AnKm5Fz+4se+uGyKUq6O6a?=
 =?us-ascii?Q?w9UdeSLvRxSonMrdgMf7uNoptudPFyVjFwFIt2eg27HxUD3UXSmEcnyyoXkC?=
 =?us-ascii?Q?K98jJrkRKv2Or1s6RoEgJNoyILwb59jxn7K2sRJH+NoaxILzG2BYwUndjjnO?=
 =?us-ascii?Q?DOYI8FTrB6UXaus8GiSWvb4qeMP9lLijNi7lpoyfcmtX+wpql9zNEArWVaBB?=
 =?us-ascii?Q?Gj3H8mDX32GNvOlnZr3fZxNRMya2bxTckvtw5C9a/0doVuNjDElcSZazi0f7?=
 =?us-ascii?Q?C5MKx01RU5CxEcm4HnrDj1/pHpemA7sCTcUkS0OrGt6DDgDCbtFh3iPXimvH?=
 =?us-ascii?Q?dwzgG5QAMPnEjA9y0awWpLprQ/JdflOQUxaFo4UVF1zZckDzyoMdXW/ioxQI?=
 =?us-ascii?Q?7VWcle2Py/U3v0M1kWE9hHV8Q84vf+l32tl3yDvdr/ZRdVUqw+Tm5CDcZKOl?=
 =?us-ascii?Q?Di/Mg5MDg/rFAmTygE2+38ZEOHgaBML6MWiGjwTCHjlKGOmH4J+cGHaxOImz?=
 =?us-ascii?Q?d3Cs6fqUm2IOe9svyrbH1ktTAKwNpz/a97a6YvmzeRLUj+atEe/1Vx6xObP7?=
 =?us-ascii?Q?dAou0viu0TaSjrtwrsxgG9QRcYwXyJzK/jUmMtdygQSG81BtN6VDJ8Xzouzf?=
 =?us-ascii?Q?Mlfz6CVahTs58CmdF1GlKM0DqzvWQ5rLMtSdORT5US7YAgnpLSIzVzFk5joN?=
 =?us-ascii?Q?4btzCRI+aobV+jCHQCyNyYC5dREzbXhb+p96BTWF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5501.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e3f78e-3b91-47c1-c4f9-08dcd0e68459
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 15:46:06.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK+7NJpQnCVGuQm+Mmw9MUK1J+IJvRChqyip5s9heNqPtzQEXVS6PNjR/Yll5izbZBUPivdMzAdEdESNTtdwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10448

>=20
> > It turns out that the patch works fine for the specific issue it's
> > trying to address (Juniper switch), but for (seemingly all) other devic=
es it breaks
> the autonegotiation.
>=20
> So it sounds like you need to figure out the nitty-gritty details of what=
 is going
> on with the Juniper switch. Once you understand that, you might be able t=
o find
> a workaround which works for all systems.
>=20
>     Andrew

This was originally worked out by Doug Boom at Intel.  It had to do with au=
tonegotiation not being the part of the SFP optics when the Denverton X550 =
Si was released and was thus not POR for DNV.   The Juniper switches howeve=
r won't exit their AN sequence unless an AN37 transaction is seen.  Other s=
witch vendors recover gracefully when the right encoding is discovered, not=
 using AN37 transactions, but not Juniper.  Since DNV doesn't do AN37 in SF=
P auto mode, there's an endless loop.   (Technically, the switches *could* =
be updated to new firmware that should have this capability, but apparently=
 a logistical issue for at least one of our customers.) =20

Going back through my emails, Doug did mention that it would possibly cause=
 issues with other switches, but it wasn't anything we, or (until just rece=
ntly) anyone else had observed.  A quote from Doug: =20

"that AN37 fix pretty much only works with the Juniper switches, and can ca=
use problems with other switches."

Initially I wanted to have this patch wrapped in a module parameter to avoi=
d any potential issues, but that was shot down for the same reasons you ini=
tially commented about.  The unwrapped patch was accepted however.  It was =
a couple years before the potential other switch issue actually showed up a=
nd the patch was reverted.  Our customer still wants the code in the mainli=
ne kernel driver, maintaining a separate patch was not something that was a=
cceptable to them, so we are.  This was all gone around with Intel a couple=
 of years before and the solution for a non-updated Juniper MX5T switch is =
orthogonal to other switch support, thus the patch with the module paramete=
r.

