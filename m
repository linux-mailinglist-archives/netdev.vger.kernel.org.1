Return-Path: <netdev+bounces-149050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE09E3EA2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96731280C5E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46E18E76F;
	Wed,  4 Dec 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DgFLAGSM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C71F708F;
	Wed,  4 Dec 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327259; cv=fail; b=rr9EQLQTkLMjQeYNV0lxIoeoaZ0cfna0WQ0UWecUc6U4Wl8ZNYKiWBPh5PLnTvpoiyZX9sAVQKrI9geWQ07X/gYMvadAF2h4ib2mdtyJs3hpJ5OE5PCHl+WTzacQTk8uxFTGm/YrzRgLg/GpFBoBLRrIz2p9gnEEcO2ZMug5O1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327259; c=relaxed/simple;
	bh=CI4RJCPkUqpLnlr6Fcy2+P/Vnxoux8i4c1h3o0tpMyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkTqkCxgMmpCeKdkdrqepHh/MjJIK7tMxz5ypsAWNB9RxSYc3FLXE5FQ0O6IdwAv5vRATD5QJOvhpLMjW55vKyLFXIAJy/RUyy1A1pF7CmZMoVZfmmEXg6dh+5dcBLZb1LlpHT+IaxVNjAzbiNaszMxTuf0Gz/KioGfqKn0bxnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DgFLAGSM; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLjXrua7JfAgVTPgCdmvtdxgr2BN0LePUZiNBLpzzx5Y05baruNhtTPr/DgS8Wg9nEsfs+8SKdJ87bE/8IU+u4MMrsFIC6oj3Ft6qAxhWBaucmo6qUUrGTSoOMgi439VGUnmS7bqlxz1H8wsuxXL5mPYCJkJW7TfcIcxGEiO9wPZBJWR9fRotHaJsEkJgKJryxcL4AQGXUf7caS7NwOL8ItxGZvR41RhlU/iKG5n55j4rc20xs50sG7aWkvrojN0K0RWy66rwDw/OCBn0LHU37j8YjG/7DiQ+SCs1xPOiBfo8nivwTMD8LcRPMKIF+83YC8dcjoBT/Pl7NJRK/10Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhV9CJDgJgnOpAsYdq3QC5rRLJR+OIeDEM5bCwVaGaE=;
 b=BewsgIKVG0x7+uAYa05yJEl5UkWFGdTGSLY1z/wKhyV5UPH7DoATIaxyjOtEnMniYgfygCCAYnXrxtKnUPKs46wgXg4eb5VB0FD7g0twg68K6WGxpWfG0XR98vQ4YX8wAZ7jXe26MJ751Wcuym1p03OBZtpSsIRqQHtK7/YfCLAk79V0WLnmUYFTmO1Qk7sM7X53lYDBMY69VUigXZnqQqDGLfpwyssJ9yXbZpGFmEUiSk58WKdLLz/D3aOPDW8T6mcj6vH9JN/CyxRh5FeyaeigIf7PiF5vXTFLCFsMJt48/XbdbQK0h2XttRakMWTuiKDIxLgojn2Hs1zFzVkLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhV9CJDgJgnOpAsYdq3QC5rRLJR+OIeDEM5bCwVaGaE=;
 b=DgFLAGSMQmxcO8pThNpCT2H4ay+GFKzR2GD4RqQxGleZAkdnKuJ4By+xKuBUV52risCwlh+ApzAdjVvYpxsZo9V/UdcV/sYQCytcljpl+9O6qWqlyuZYMsopmeanELW4GMQiwSDxJklg0Rwu5z6JTUblzTsaqENjt0mkQV0JCwUxAQNgqFYierHWQXXtfCK8TmFDRTBBxx4Qqa3RAzGYOiQEtEQ+pcn9WNGg/F5KTYFb0AwlxQpRxOhnC3OrFTcKvxNhswDOAXY83BH1ANCgDm37YdbptY88rd3JjJoJoUBvwDxaRqo4X+c4x3zYjHDNws3nl/ys5lvIp0Bjszi01Q==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 15:47:31 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 15:47:31 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Topic: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Index: AQHbRWDdzNo+Cnt01kOqIfdpKniGbLLVUBQAgADphTA=
Date: Wed, 4 Dec 2024 15:47:30 +0000
Message-ID:
 <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
 <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
In-Reply-To: <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SJ0PR11MB5152:EE_
x-ms-office365-filtering-correlation-id: 9a8e9f4b-459e-46a7-017a-08dd147af671
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4QFt+0nRSCTFulKgOD78tbdu7JkgAeP1+FyGCHSVKlglHkG5IT4sgYJx6F+Z?=
 =?us-ascii?Q?gC285ACbulQ1gJl2RU8O2SFI5YJBDepGGknAzt0c0ymmAAENFV32PDrAhZdM?=
 =?us-ascii?Q?6DLqdUBRjgPx72lVdcei5C8BXwNAYyTf/LtIGCgjscFAHIaS58zY/Ejs/7kN?=
 =?us-ascii?Q?VrtkYemu3ArJOLSTjBG6r5pocI/wZT2JgcNPQwipxLuPl22inOWlGKCQhZSd?=
 =?us-ascii?Q?vp6dAdWUJz9m3ZkUGn19WEriluVROoz6Ax6te1hF/prlIoibr9r9G6Z42oFE?=
 =?us-ascii?Q?c+An+eHhw/17yDhIiYrJEC6ZxetPg4Fi+pG9KfSbKlwm2F7uNo8lFTrUT9QH?=
 =?us-ascii?Q?th71rIRgNSiis5EnqLGRzXF6nhwtS2RnIuodTICKctZv4YHkCUzBNQ3f6GHM?=
 =?us-ascii?Q?y7dI3yrb3TFY2i8+JpUgvWQukiPD3AyC1bMKOuhrdNOSP3qj83Uiz0ZuF2L/?=
 =?us-ascii?Q?13D8wPJAIw6Qu4VSG7bXkgz346HTBPvioVXy0qSOo8zWIZ3dxBsxJL1lHpK1?=
 =?us-ascii?Q?ATwVITwRCWLFdMi7a28bq9SmnRz8Vhnpt0b0eYEvzFbsFCfXYBOSnu8NDIzR?=
 =?us-ascii?Q?EaoBCvWmOc1vxdzNt1kHxFcAJuVu39E67wqZzzCpEapHrL5eKJ9tfeeV7VOI?=
 =?us-ascii?Q?jwWRZSmR0kWlUUK/+4TLRu6H/hIof1w1VImFVfidcoFR6ZGPbNS5tY8M/Jks?=
 =?us-ascii?Q?vvqEkkIONXks/hFIvazMrylOnl7SsXtnTmXFLs27UNXasDAx0cOa2NuVyUo4?=
 =?us-ascii?Q?HFUJqISnj1kDXQzSE+rzIxQRmIapNm8dYmPwDndvHV8JXyqkfc5//9PpC/iV?=
 =?us-ascii?Q?hksV7InFV4cYAv5rB5/Pf6J0NTYpGUBYFXzLPu/40EO2vScs8F5EpOQCCC4F?=
 =?us-ascii?Q?5DFn//FnpXaUcR72DziBgCe0J2yRfNq9sZElkdmd2CkfuByMiS3PSATEIvia?=
 =?us-ascii?Q?Q5kvUNy60I+/6qXEgImcKzqkFkOtYiKHDp9htJqOPYuiSStoA9uV7WJzxmmW?=
 =?us-ascii?Q?NWAwSEj/u8mKqjuBKmxYTky0bsigs4VcyqBj7soh+fPLXhyQJ6L2KbsXufj+?=
 =?us-ascii?Q?Ao1MQgGsw6MV+11BmLxGLgEAaxAGeDaHz0HncihHuj9YU4o5U3BtSqhQv553?=
 =?us-ascii?Q?lAtaZ/pCua4HCo9ZKjXjgCZjp0wN0QybB3ZLSv6JlJFO1iaLmxJjBLX4BjBA?=
 =?us-ascii?Q?s5X+1az57vXAZR2zQzcbZHlamEQUx7s8F7D3uWBEPjnN4aGbS0y/LImrv8a6?=
 =?us-ascii?Q?ra60xGly3hCidSP/Oz1Xq+LY2bldbaizIk5N26EaE2JvJOVnyi0pAQuHz88B?=
 =?us-ascii?Q?wRDiuvJONNiwBIvH96r4s87ErjwLRCWPcIAMDlHqPO6e9wJY5QLA3a5C/k8g?=
 =?us-ascii?Q?Hy6pGBDaVRwNN7763GnHPFtiCYRw3YutE9+QEHPXq1B1MOOEHQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w0WB0BVxbkjoKYdi7lbNiKRspD69qsK6MFE72Xi2FntrGe3ogofe4/Ys4X4W?=
 =?us-ascii?Q?zeW9fxICBpPi1nlkuQK/1lk/zlPmn+X8rXjgWJWZMBOiM7ej74nBFfV8r0y1?=
 =?us-ascii?Q?c8ihL8wHY6sm4/pf4IMTDp/tF6215V8DbaZq78s6B1X5pD/K9RUJNFQdS0cJ?=
 =?us-ascii?Q?qKxHSp/Tf0T/R0c28SZe9yFZGuRhe/VZuR3kb2Pe2wZFpR/sy0tHV4BbZNPl?=
 =?us-ascii?Q?56lMPbVXXryMd1Fi7w9pVrjcOkkg2F73KAJH5plR6aPPciYgRloIQuYRdE72?=
 =?us-ascii?Q?LvkZw0G5PwOmvXQqpSrRGe6Sn6QzqBtFBlGVtKYuvFiVGspFw/4xDjyAfoG6?=
 =?us-ascii?Q?oV/D+9PkqIrrzWOB1ViAekVxfZXSJYQtSSZmzephsP4KT8I2hJpbs2GO2/sx?=
 =?us-ascii?Q?bvOuypf9DPxkWqADB/D1P0YkVxxt662rJErGiDYZl/9g4FSHSChMwj7Xfp5V?=
 =?us-ascii?Q?yHKWTdd4E5SoJ7WYg39hg37iND9hiYVFOVL/Eg1233JX5J3GNAUMFrkRQPGZ?=
 =?us-ascii?Q?3uoQm8fUViNGhhxoaWCuqq5SKyenITtCRr1jB3Aretjbgz/3Nwc5hraPnb1P?=
 =?us-ascii?Q?xpUq1HWPl3uNhweCjhq8LQCprXMNzY84iQT7Zt4nx8Kqk8pCK1twpMDiN41a?=
 =?us-ascii?Q?V/J9WzKgdreBkPBjsvcwth+RwwE8+rtLhKLLRnY+i1tBVO2trQ5rUUo663QH?=
 =?us-ascii?Q?oVChfWvZkA1mQQbMHf6J+6N9+NzBNIEnLW4vPyZKDhzoZxU4g9sZMQQwXNRD?=
 =?us-ascii?Q?d8i6VxW5kawtNJ3dOxl6zeZ/wsGYWnes3omkNMxxvze5bfEzM/PD6fcbzel7?=
 =?us-ascii?Q?e7MTZBW5JKKFeVZXypPlEAjeN+5j0JA0y0CjIwT68CNhMM/ESMQZgEMNNHvl?=
 =?us-ascii?Q?Wh16829NGbH30PdE2RTeJqtFAZyiPZwwPDL176GfbbADB1p1yKh8ittx4/NR?=
 =?us-ascii?Q?pky8oEHVM9Z4mU2VGpx1tpln3goKxLGDRrJrf8ehoFDCyrD1u367CZxJm8sY?=
 =?us-ascii?Q?5N/8Pk3dHjN1ozLFgQ+5CcNOadGgSutMjYSkTwz0Wq4M0Pj+RRBy844aSS9U?=
 =?us-ascii?Q?nFNWPZPwI60Bk4CNfcMfhwgZ2skQ1OWpO1ppIpFZmA1t/X6ZP8g3SMSPAbFW?=
 =?us-ascii?Q?z7ag6IgdEjovjWG+2kZvDFuCehXZdgvLlXGf7GRkjo8J2lBEgQiBdQO3TJg2?=
 =?us-ascii?Q?JrE4KaxlGXnV3IY9FqCSEBZ34YbWtxatNEaZ+8x6WdaJu72rxyWf3lLCLELH?=
 =?us-ascii?Q?SlvJgcT6wJRUVum6eTkeprcRCmVSlPpMUFtnet4sHE0TFbQ2SFijKK0fvShy?=
 =?us-ascii?Q?oLaEZtyJRD5JEZALZDSqP9WrlwIvKgLgZJ0TuLZjZnVU0Q8Bri1ZyDEUbak8?=
 =?us-ascii?Q?ANl7aIQs75ZTTUNgI03WO2havDFAwmXxmiUWG7oaIQ3n+UNd5n52LZ+95Iao?=
 =?us-ascii?Q?R4jp5RGtbPMjTWlTx9EI3HSZjFc716cCKcQFaWhbgia7IeJ8u216Iy9lgQ9K?=
 =?us-ascii?Q?avM77J+5cDMbpP+pW9qWeIy6U32oAd+w1vKzxZQoSn0cycoPgiEtqYdODgiY?=
 =?us-ascii?Q?0Ja/DPvnuypra6VfLXIQMi7ucM6nd7L9Ftk8q2pu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e9f4b-459e-46a7-017a-08dd147af671
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 15:47:30.9098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvkM0xp9UEaszj7VQTr8Y4g9pTrN/b8CfXg2XCaTed4FVMe90jYZ7EXQkH42WeLn/xCvFvrCOZd1EDS0VjjWjNQDi1EzMqAteC6ejC37ueQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, December 4, 2024 7:10 AM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; richardcochran@gmail.com;
> vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library s=
upport
> and 1588 optional flag in Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Tue, Dec 03, 2024 at 02:22:46PM +0530, Divya Koppera wrote:
> > Add ptp library support in Kconfig
> > As some of Microchip T1 phys support ptp, add dependency of 1588
> > optional flag in Kconfig
> >
> > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> > ---
> > v4 -> v5
> > Addressed below review comments.
> > - Indentation fix
> > - Changed dependency check to if check for PTP_1588_CLOCK_OPTIONAL
> >
> > v1 -> v2 -> v3 -> v4
> > - No changes
> > ---
> >  drivers/net/phy/Kconfig | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig index
> > 15828f4710a9..e97d389bb250 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -287,8 +287,15 @@ config MICROCHIP_PHY
> >
> >  config MICROCHIP_T1_PHY
> >       tristate "Microchip T1 PHYs"
> > +     select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING && \
> > +                               PTP_1588_CLOCK_OPTIONAL
> >       help
> > -       Supports the LAN87XX PHYs.
> > +       Supports the LAN8XXX PHYs.
> > +
> > +config MICROCHIP_PHYPTP
> > +     tristate "Microchip PHY PTP"
> > +     help
> > +       Currently supports LAN887X T1 PHY
>=20
> How many different PTP implementations does Microchip have?
>=20
> I see mscc_ptp.c, lan743x_ptp.c, lan966x_ptp.c and sparx5_ptp.c. Plus thi=
s
> one.
>=20

These are MAC specific PTP. The library that we implemented is for PHYs.

> Does Microchip keep reinventing the wheel? Or can this library be used in
> place of any of these?=20

As there are no register similarities between these implementations, we can=
not use this library for the above mentioned MAC PTPs.

>And how many more ptp implementations will
> microchip have in the future? Maybe MICROCHIP_PHYPTP is too generic,
> maybe you should leave space for the next PTP implementation?
>

Microchip plan is to use this PTP IP in future PHYs. Hence this phy library=
 will be reused in future PHYs.

>         Andrew

Thanks,
Divya

