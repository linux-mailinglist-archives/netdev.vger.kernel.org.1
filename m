Return-Path: <netdev+bounces-127846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1065976DDC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D430B1C2361A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E501B5808;
	Thu, 12 Sep 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4FXiYU8v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66521A2567;
	Thu, 12 Sep 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155405; cv=fail; b=KfJ007w0xvzMJa9jDGaHQNnHcbjbpI1LlkcauRggIhdySQlUSDIc6EeN916vrphtKh3SM6UbpsD45J7CBu+yswVViO1nlAhbsD7ihAvBg7x32AEIQbZqACsz1cfZhgCQ6+hGX2y9evPMhcH+0H2PKX6YVKelOoIsjdGb62IwTWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155405; c=relaxed/simple;
	bh=zcoUIXGe9mzEY3PII/9QIb5Wr//gddnj6KC6+qFNBYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JezAmeNbXSXkV2h0oloqpsKhkOwmkundomsPPqmhB3Mz66xhGmvJ5FPTCqFZ2IMnA3G0T1VTg5CwnyrQypNyMZF1XKD0OfInOOcI/BhIRkuxLOJUbrXPb9LggqAMFdoWOAuBoweGEUBw6blgOdK6qwkdEggBgdQ6pgtVyFwHaF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4FXiYU8v; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vytRtKUDbQUYlZVZOAtsoNvwrQKL1QiScGx6J8Y0O39bkLJDtk/XwBoX7TVcf0daFzRfC/oSEwUcnAPYnLgfxFdc2vrIDqck1BZ28HRyZ71vdZ2XBpDejuIuJiYfr/WVKIr30g2Ff0gy3nDEopehSraZMd64pX0/QPkl6gxAjEHQDndiqqKc/o6vMbmqT/Cmc6HNhWWp5DLCoZAxUCYzOSbQ7AU3ao+6BvoTmCF/x9H1rmd/zje9nBPcXUKbG8SWyRZnCdN9mGjbg+3OR1Kr6o/RpuuEDVrsAJEVPo16GxBXMCjhhZrOwgj6I9JullvzCmsIKU7+lkJfqb82gE/Xaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ9doYDlgOChVZwEAVnx6raCSG/aWSFCylDGj1R5EBw=;
 b=SzWps/rR+S6jrospPwlwqknbUdlOE0eA1fkWNpVqA+pnmnVJ97/glIvIPc/FTuYTTCDWSzVnj5LkRjmiBcEkVyQDY9vQfd8aWUJ7QpsYSHQWq0pdmVUFh13A8AS/JBLLZM6IU46bY4bKbjcFECcuD8jw3+/yhQA34v3fvfKeRQ+UYaiZbIdmOJa83Ri3Rta6pLP1RdoKYXBn0v2iqUJci4ibd6hT5Hf0b11Ftoqu+M4xrXK9ikR53rGgmPAFdjNZa16yV6CFRulQ7iHXL7ZpLWfwHl6L+F4j9oACmVwtyMWftP3+2iYwFJpls++PTgqydN7B18tcISEbWRc1S7Zn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ9doYDlgOChVZwEAVnx6raCSG/aWSFCylDGj1R5EBw=;
 b=4FXiYU8vw6wVSFxddagxyGfAa3BIE0EPoTtY0Pfb9c11DGxP1fAaBrCBiM0qp51RfR6h8tOHIyEkFaVV61Q+O8wo4Q5uePR73Qr0Oz99DFQQ/WqU0mNXNOIkG0AqPF9+hILTooxlwrU021sESIiJJP81p1NCE/jpcifczNtWexGNYV96vZvKQ9vkPTXchexpsR+Rk1NIvIFj04iBKBT2ZqdFM3DWFM6Fv4PYcoX3fOHG0Vo2wQalu/kNBOQw33A/oiIIYOBgw2V6o02VQdcR23QrSDHy6F1OVzcCQOuNBIqiAaMICSLtk3yUkh33EM0IEU1DOvnor/bcA1eMJvQKdQ==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by IA0PR11MB7884.namprd11.prod.outlook.com (2603:10b6:208:3dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 15:36:40 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 15:36:39 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Thread-Topic: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Thread-Index: AQHbBGXGELjLauDUqEuTABaTIHCmgrJS0SWAgADgLwCAAIyPgIAACRTw
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Thu, 12 Sep 2024 15:36:39 +0000
Message-ID:
 <PH8PR11MB7965848234A8DF14466E49C095642@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
 <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>
 <e5e4659c-a9e2-472b-957b-9eee80741ccf@lunn.ch>
In-Reply-To: <e5e4659c-a9e2-472b-957b-9eee80741ccf@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|IA0PR11MB7884:EE_
x-ms-office365-filtering-correlation-id: c0392982-502b-4a98-799c-08dcd340b210
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rkjBGnxXE/41IKbaphJzO2kuAJsvKjrFSnzvDrUZBADEMzD3Rh1/QWvZUqbp?=
 =?us-ascii?Q?Hbo1j1se2tpQdGOXEXTKYIOrwGn8lG6uowq0m5GQhZMVaL+T+fi+7iI2ieyz?=
 =?us-ascii?Q?NezNOcrT5zup2CzTmoaVgquwEU1nmSaOv0hJzHnTZuu2fyQP70NW+vccWODN?=
 =?us-ascii?Q?CTthCnWyR9G5HjksT78ZWpAXHwqhlrTyb57gTbZMSrCm/LOadKExlU3Wkh+y?=
 =?us-ascii?Q?a/OvaH9kBcJCSCqVI5kbSuNZuQN1x7sbnzdOgDNZDeHK1c8C2RUXCN7MKDCY?=
 =?us-ascii?Q?7MPo9Z9dIYPcIVH5kqcF+Ag29ws1d9Q4UT6LgIJbZ3nEleAYffm3XWVvCIa9?=
 =?us-ascii?Q?rrpTlIqd8H7Hh0PKUHL78uunu4boFKHiSdl86lksxFwNbqCB3RrWi+XEAfA8?=
 =?us-ascii?Q?0SnCFmKIIpxsokgXsPPWg0wAR0qIPcBJZnWHj5w3Jqb9mBD5e8qrWuVDXP3a?=
 =?us-ascii?Q?2e6lPbRO7a/1hbieSfovDDlIAZs8bntxrHdhC163I4aj81QXydlTyU+5UrTo?=
 =?us-ascii?Q?IZf3SoaBfLoQ3KYhQq1gypiptTzC4wLutSN1Bx4nkPgu/5GbKGZJO7tJjuuj?=
 =?us-ascii?Q?Op0cDRGoyzkmEHmciBEDgMf5FElRCALdGkIyto0GBqHi8516cKZJ2yDQdsW5?=
 =?us-ascii?Q?3hYs1fl6BdWiohvcG1FD0SUaTWDS6gkhnVV0AQCX++xOzV0Eji2zd7dXlZoM?=
 =?us-ascii?Q?Vkn5MYt3XU1r4cdCnRt8Tv8+zlweYTf9GLDbyYiKHhygz1SZaUJvyyZMwpQG?=
 =?us-ascii?Q?83piZtBcmKVDLvL08Jhcsutkillhaa94P5coIlawt4yhBV6yeL+2eGiXEzM9?=
 =?us-ascii?Q?i6fOzqQHGYRI/SF44D5W7frlYwL8rx7Y0yUILsijOE+DBDwfPIb2ZZ0zmaqQ?=
 =?us-ascii?Q?NtjJQBJNwsF63bgSVllRgC2zgI8jJjC3T42+oFIkk6PDqdPgN6AUoXz9Q2Jy?=
 =?us-ascii?Q?7iFhL4h0jXnV82i+CfAE3L6wym2JRatVKQ/oJAtGm2UFj3XCqzMNkdMA//XP?=
 =?us-ascii?Q?Gb4N4fZqN75hlskyc47r22rvb1TZyF3Z+rCHb/BF0BHlSex+oS6o/LCSMSOy?=
 =?us-ascii?Q?TFJwlTz4vvkPU14Q3XmnP7ldglcBfT4IPBavtt7ywxogBujKU4Psp/WKfZKF?=
 =?us-ascii?Q?u7SIniFD7jHiNnFoaae6sH4t+nVAlbWYAtcxP/icx7ARO/ZOkj7kjPslU647?=
 =?us-ascii?Q?aihwIlr6z5iW8364QDGQLY6EoHbr06S4qi91MTIpifi7GZKAqNPaGI7QLrYJ?=
 =?us-ascii?Q?PAU7yjyIaXaNVaqx8g01bTJezLIFJBcg4D1eRxF57RB6DQAEpH96HuMLwz9s?=
 =?us-ascii?Q?/WAb1xMvTe+LPw/qSoI/uk4Whi+HpYDaEjXWPPv2FgOknBViQNscP8pvZ5dR?=
 =?us-ascii?Q?v5yal4Ex21M5ND+rqPwFTlbsDPAkX8lNOnCEhcdTNEzXgoHseg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7tha4cXkFONjc2/MvewyAe1Gu/E4w8rqBa/qgdzccaGOE9YXC1lR/4WeaMW0?=
 =?us-ascii?Q?vSA5lRwxRpNXqdA35hk/7JM3sVJAqEo+qyzpDaMP0BHwqjTQ7JIa2XCY0llH?=
 =?us-ascii?Q?oYD8A0EW7nM73H/S3y7HFgZvUB4vbzb4gRRIV6mlCQnFxbQ+WZihfOUQUb3R?=
 =?us-ascii?Q?adqFBzPL8ivQVtEiKwWGT7ezwVpdFuLXqoziUdYW9gWr/3OPu8NV0UAtNFek?=
 =?us-ascii?Q?IwZ4o5dsZuOJOe54f2Fumx0H0AbVABM6lDsjrDo6q+1OBcjpQWS/nYTmbhWN?=
 =?us-ascii?Q?ltzqn7RHdRFZSRcKYb9FSK0tENMCr2GBRFrhfcw5ow259p5Wz/ux92FadvSI?=
 =?us-ascii?Q?md8w9OWY1YetrBmhdCnD/QA5Lz9S8FB7cXRi7G5DWF2gaxhhkmScMwbkBmRr?=
 =?us-ascii?Q?hYAV2dg8i/f1jOnF2/O5XEeGvfVQwftkVfKEoFP5riKPFL8Au+zRVe7iPNeD?=
 =?us-ascii?Q?WpAHiUOZVzqQFFC9CPOltf54IB/C3ySCOEkoa0hHl6bWVuUhp/rSvKGTqwFt?=
 =?us-ascii?Q?FU5yHkApv0PBDu/yQrz78n1858/aEPYNSXpV8ngDAb8VCEpv3KZkvnAr8gKX?=
 =?us-ascii?Q?SjPHNAUxtrt5azu9Lcf4X1Nt6IhTRU1PpV8Ua4sVWuxUh4O1roEO8NqrtSSP?=
 =?us-ascii?Q?pXKbeCsHXUo9gYe0/10/QxeGg7WtNO4GZyuo5zeh+Y+NkBr7cV1Jy2zJeY/p?=
 =?us-ascii?Q?yISdfewWLjp0rHXWerdTwgqqzJXS3ciZ1mmeItjHQfq7xlhspxkFK8mxYaQM?=
 =?us-ascii?Q?ajvVIp/sNSWBpdJL9F0W9Fpvajvg7ODnylpupbHGw5lqgVW5/qBDy6c6kZrd?=
 =?us-ascii?Q?Z1l60UUXRBs1DHgu1szQx3r4z9d2+04rtD9NUKxvs/F0EDymkEsVzq6pjUw6?=
 =?us-ascii?Q?SjnhAOBFNe9tcIc/hTJnw0wzbYGESZIm3EtbW+CD/GFwssuG6CsuRoYqVWEY?=
 =?us-ascii?Q?nFSTgBlHY9Ia5Y99loqCkVvKdZkE2N95q3JODMbCo58aZWtvyPMWl5bCmzWu?=
 =?us-ascii?Q?0Bz+6DfXW/M9PzXbCSWyaigqDKU6yZI86rES7Kl/6aUUi1tVrvZmVtMRORKR?=
 =?us-ascii?Q?jP7MiClPiklSB3trdaFRi60NVWjdlN5FVzlyRxmGtiu1xesw+SXw0797fN4D?=
 =?us-ascii?Q?F9rl4+T+i59mCF/hRXpcBZpTPL/1+OuXolwE5ePL3yKj1Uw6RC5dL3oSZw9j?=
 =?us-ascii?Q?enGyNnq+JGJcZcJAZUyFM4QKMbvL/pbhh2lp53EMlhy64a4v9zFUVfwm8Mui?=
 =?us-ascii?Q?Hrs8jqZh3Eny0ASmxuZuHDAXfrmV5VlSI6x/pI+n/uY9naJ3C3SJg1Sbbu/E?=
 =?us-ascii?Q?z7PCKTa65jnSDsdPMfvuEQBS/Dv12n7Aoj/qZqQ/BDenh74ivo00aq4J+BAE?=
 =?us-ascii?Q?d4mfzMZbh3hRavvjKEJgdjELAGd0Ps4jzOZvcbrUlghVrlyQRClhTihqQAcL?=
 =?us-ascii?Q?wG5Zv1MvoC/xBeqLQeDR3wwM1bYM7DPy7YrvrZth1trnpt1sMaGcBfVH2jif?=
 =?us-ascii?Q?JitRDRVPUjdFzFGSAkKG2SY/Ww4jnuSKmLTLN8Wm4phR8njXBqj+31yUbnRX?=
 =?us-ascii?Q?Ki8sibUDr2ocWeUosNq0LUJow7zOVzdCzoax9RIU?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0392982-502b-4a98-799c-08dcd340b210
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 15:36:39.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoUY7ifGmpwRxf4r0ZKon4mMKYuBS9AtNedwhz+PiiTH7zvTHvbxU7V4y1140JwbS5zkc4I3YSK/STvmGu2nPlLm/QNMli2poIh5h0UOZ2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7884

Hi Andrew, thanks very much for your comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, September 12, 2024 10:52 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kub=
a@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.co=
m>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; maxime.chevallier@=
bootlin.com;
> rdunlap@infradead.org; Steen Hegelund - M31857 <Steen.Hegelund@microchip.=
com>; Daniel Machon -
> M70577 <Daniel.Machon@microchip.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check =
flag
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Thu, Sep 12, 2024 at 11:59:04AM +0530, Raju Lakkaraju wrote:
> > Hi Andrew,
> >
> > Thank you for review the patches.
> >
> > The 09/11/2024 19:06, Andrew Lunn wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >
> > > > +     if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> > > > +         adapter->is_sfp_support_en) {
> > > > +             netif_err(adapter, drv, adapter->netdev,
> > > > +                       "Invalid eeprom cfg: sfp enabled with sgmii=
 disabled");
> > > > +             return -EINVAL;
> > >
> > > is_sgmii_en actually means PCS? An SFP might need 1000BaseX or
> > > SGMII,
> >
> > No, not really.
> > The PCI11010/PCI1414 chip can support either an RGMII interface or an
> > SGMII/1000Base-X/2500Base-X interface.
>=20
> A generic name for SGMII/1000Base-X/2500Base-X would be PCS, or maybe SER=
DES. To me, is_sgmii_en
> means SGMII is enabled, but in fact it actually means SGMII/1000Base-X/25=
00Base-X is enabled. I just
> think this is badly named. It would be more understandable if it was is_p=
cs_en.
>=20
> > According to the datasheet,
> > the "Strap Register (STRAP)" bit 6 is described as "SGMII_EN_STRAP"
> > Therefore, the flag is named "is_sgmii_en".
>=20
> Just because the datasheet uses a bad name does not mean the driver has t=
o also use it.
>=20
>         Andrew

The hardware architect, who is a very bright guy (it's not me :-), just cal=
led the strap SGMII_EN in order not to make the name too long and to contra=
st it with the opposite polarity of the bit which means the interface is se=
t to RGMII; but in the description of the strap he clearly stated what it i=
s:
	SGMII_EN_STRAP
	0 =3D RGMII
	1 =3D SGMII / 1000/2500BASE-X

I don't think PCS or Serdes (both of which get used in other technologies -=
 some of which are also included in this chip and are therefore bound to cr=
eate even more confusion if used) are good choices either.

That being said, if it makes it more we can certainly call this flag "is_sg=
mii_basex_en". How's that sound ?

Ronnie


