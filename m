Return-Path: <netdev+bounces-145794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C3E9D0ED7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D11F21AE5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0D19413B;
	Mon, 18 Nov 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ssdWFzAv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CD17C98;
	Mon, 18 Nov 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926808; cv=fail; b=nBK4kPjxOSFKJvnYnTXreF157maEY6xrGhwTrJCD9mtS8bLpy9rq4Nth/Rf7XabdTu9MJdk+voFcRy/PcKPQ+u2vbQqeDC62pLZDDQ6BwVm46dDwSaEhhh/gVqZhClUUpoB0YK+ZUJ7FF9GkL/VACYo8xZsCjBM5ybqFbiv8Oy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926808; c=relaxed/simple;
	bh=sQG0Jxwq3YHQw8qcH7SW4AwE5fUSraM2KWyNKyNsIx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bp9JDJi/SAK40XZ8nZ11lxEcAIdgxT9ELSeyppD7NxzzfYgq02f/jD6fZ2jDL7cknQsqUWCcKjZ1pOrRf3f9qthBdYULex/FXbUzZWghlbN3n7frIGGMePlBqccpHBoh8w10XrcDxGPVt++FQnB+Mbw5+eQibjleXp+btoE4dFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ssdWFzAv; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXNWoTTcj7zSD7QvGRYGF9it1pttQXYK5Nal8R37s1lAvizclr42OSU6vbEMKOGUIg0LPKfMINvEz/3j5wPrT5h70MsL2p882TUjpKDo0kO9aofeg7KMIJZuoGQqxm4XgmLL2jHJde9UWdHMVqTeo77B0BXQWRLbU9DR7XTfKxPGwr5BRYLl90ta6Sbsf05NU06y7xH228xSS6IJYtw/HAKEFuU+XobmXXwHceEnRfaLlELPG0ij8jdczIFJpza/bV50VdXHoJI9ubxRIs5b9MMi+IbxTEX8o3TIkmswpvDa/FqXglyWEa0kvjgmykML/jnxgzNQjikQVhXe1zJzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joMqb6H4b46PlNf0GfXob+47vUW0WKeyX1I6JGwyCBI=;
 b=C9nVRSK7ycTVrtFs2eurBCDPysQkHszlEUhyjfbmsbn842L/fTOPkkz9N3X+QRC62NPQAwioTnklCa8y5V++Jnu7QB/Ta5YWiz7qJ5dIYHeo61mkkCz8wy+cNvc7wwpbuA00U1gOr0EHtw0Jg6YN7A+N+lH2rzdkb8xzKfR2EaWZ0MqqIfu19mxOeaaCSyiaHdwWM+1k5FuAay1ew/Ix9FpigfCqtp4LvGRq3Y4xGgMM9dKZiGQBkfcNhuX5m0dpUIx5rd9/Slu7bhSf7kt7M/ZBUVkAwhSPTHSbhT1QY9L00rVGyJM+042gsLNxRzhuKs1BlOiiVhUR0E7rf519vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joMqb6H4b46PlNf0GfXob+47vUW0WKeyX1I6JGwyCBI=;
 b=ssdWFzAvEL2+cfG49RWFX60mYj0a0Xjc+nHLpkWBZRaMrRfEPvQcO+h5flSYhsoe+n34851bjjL3YQY7g5E0i5WBZeqF+BSu/miXBPp4kTi9ALxr3NeHSQeZk6OMwLby79SX4nN0IHMvu2z03VvGXwqMyD537OypMRAQP7OEo67Bd5e7Bbfh6mUk/jQQXq3v8l1Mdg2d9U0ZDMeDCIi/pacxMEDk+zgVQBg8ks+zWVrBgj1EH0xBRSkr3VG2hJjOjMcpIZdx800hje1LPvt7CzbkFz7rubdBbMn9z+xQxqjhWqPwuIhnO63hjc0iE04ca5Pi/dsc/ndITE2MFZQo0A==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 10:46:43 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 10:46:43 +0000
From: <Divya.Koppera@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v4 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Topic: [PATCH net-next v4 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Index: AQHbNo1XweRlbyluz0uIrfBFPG46Y7K5Eg6AgAPLqVA=
Date: Mon, 18 Nov 2024 10:46:42 +0000
Message-ID:
 <CO1PR11MB4771DCD038853AC26BF9BDF2E2272@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241114120455.5413-1-divya.koppera@microchip.com>
	<20241114120455.5413-4-divya.koppera@microchip.com>
 <20241115163631.636927b0@kernel.org>
In-Reply-To: <20241115163631.636927b0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|MW5PR11MB5859:EE_
x-ms-office365-filtering-correlation-id: f7655cef-6faf-4a94-34de-08dd07be4a6b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zveYwjL/1k85n/R0xk/8Vgdj7rTYtFnU4KtfmfG2Or8GAGXOfBPw8gh07eQX?=
 =?us-ascii?Q?DbRO/T9f7/bM45RWld+wWgP6IF2PFFhOruiPFyBLBcx7hUxsOcxETfJTJY8F?=
 =?us-ascii?Q?Qtcsjh3FaDditalqbcoD6aN8Tz++BEQ+RObWGvZgA/a3lVtKnjElH2mtMbTz?=
 =?us-ascii?Q?wzgaQ0rEAotKrCFnZ5h8LTYW+Ul1zOX7QpRHE4ebHdbpxVxeukYs/E0pEUGB?=
 =?us-ascii?Q?kpsxmFr97h14VtiRMVcyVUxshL0LBY2EEd/GKcVfc4pv4e9IdiVuTy3RVH7W?=
 =?us-ascii?Q?qv7SvB09wgT2LHJyds/9viKsIKiEJNVU2ADxtKxO6sTwQyDreaa5ID7Ne+vx?=
 =?us-ascii?Q?c98CJ2yklbOXDPz9N9OD3oFDaRYa6OtR0Yp9qai++/qqk7wgn8AnLVQu9tje?=
 =?us-ascii?Q?nc7vDMfMw2oO0EcMuTLykxmdfCNWwfdcVquXVLanV+77B7O7IWrfqY1I/kXH?=
 =?us-ascii?Q?TuifNkECWglCic63KEmQiazhyWpk7ASMz2535wsjgVVDvMEuTVySkyf/pvdH?=
 =?us-ascii?Q?MBk0iRGvw1kx4dT3L6pBMTzf5WO3uahkUK+QLQPqLvS6FU4vDWTR5qsoNOgx?=
 =?us-ascii?Q?QYP0qFa+wYuuH7H7s9wxGQX7YPB2/u6XrCdmT/oyZMfk6SOEEwztC353ZjrR?=
 =?us-ascii?Q?+0v9gsaFowOG0QYHotTRl6HdY4UtSTlVMdqeyYZFjEFAJPKl209Bfp6+Gkb/?=
 =?us-ascii?Q?9WD8R0Ln8/smbLreKSl6w7lgipdEDRVY26gyFowQkQRBFBdYF1FFiTfPg8ao?=
 =?us-ascii?Q?BqFPS9VZE2BV4iFJ7/dE+fdXobKOR0kEqKa5oldPDOdZS3yTQGyH1XBqELzW?=
 =?us-ascii?Q?rMWy4WSXt6X44UEfxPL1E0CY7z7jUho8TxHC3GNInFYswAaYKZpi9wmulQ7m?=
 =?us-ascii?Q?DXBqNFJKMiR7hteR0DbhJ4x0aAghoUcX/UmExq4g5UDyh2jxiaiu7sPqQcsm?=
 =?us-ascii?Q?9ogq02R9JWl7XvB2Xy1QR4bvleHUEX9UGAGP8oDHTQD0Owha2T4C3s+V6pda?=
 =?us-ascii?Q?yMCPy9ZmNq7152eDObrDLcxmpDBmW0RyjDEwvpJ6uzILuOoD9r4sQma36NwH?=
 =?us-ascii?Q?MTMCvO3LofgQhGFf5KKfNmge9LMaa+fadpAMhxszKZZuzcvxkaQreg1HQgWL?=
 =?us-ascii?Q?Q282DRIZktcHIjmmt48mbDutZXGYaq+Q3efQF7IjgvgPDG4AEAne9MKzBr3Q?=
 =?us-ascii?Q?0imlN7qJY5AEJ2VC7dMmXJSfmV+A9E4mjmeboDcal86FkrUW4ygEr5CX1hKw?=
 =?us-ascii?Q?a0z1CULZpjohZfnJY48DbFjDDsNZ7vZgWpaX7hcFOD2VHFYgHeRER+dVvfiP?=
 =?us-ascii?Q?zKHvqgQVKR8xL7u+pjpMgkqD/6sHg20KZ74uY5XrC3bqgi3HthfsXPcTVLvd?=
 =?us-ascii?Q?gCFZs4E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bA+jJ7L5nvdoQRyBnWQACGaK1X1DMySLxRXzdESU2H2e6Z187hjOHBHwh1Zt?=
 =?us-ascii?Q?5ynJWp7TchnaTwtGMVrurB0Jze2XvtRFTTlvqlMQP750w8PbX7sy0wVtWJpe?=
 =?us-ascii?Q?73FQQevO+Dn5yEpYq0YeHBhXtjwOr+8uaxSNAQsYR0ZJsPMXa3uGOO+u5iJe?=
 =?us-ascii?Q?fjGv7yA2fP/RM7rmdI/Maj20KbnBil4K0DMH9MkrTWdrlcIWO0IbNYu0ScjM?=
 =?us-ascii?Q?jGUKpkFmPVjEL2QazSUokpYIFK2oY/byQ9dM6jLbFCTFypp/GyJnuGNloLPM?=
 =?us-ascii?Q?qJ4E4hW1qCkXvh/QMbXeOKygJb9rtcO8YVeGFCDMgWnduy+fgbfHgAOClMYN?=
 =?us-ascii?Q?hbQ8nzazqWfzKOGXcQy6GbyE9YnA4AL2rl1BZ2rKTSLHx5ietWpgQitFRz0S?=
 =?us-ascii?Q?k6HFoP6E06xtYVewkEjgBobF+Ox3TYjcP47gecfdLCqz6ONLsbpcDoJJLZan?=
 =?us-ascii?Q?cc6i6dyFx7PANuT1JR+eP3VFEzCeYc/DWkISQbz7M3GVs/9YO4Lz08y+tPGA?=
 =?us-ascii?Q?n3DCXe62qNbOnFJepY6FS5qju4Klt6xeH+0ti+C0385RxeZtXvYU/hu5cvYu?=
 =?us-ascii?Q?cMs5+t/B3tm6o44vwKuRA3yq6NFLbDJJst/27A/2mBLVGlXQ+o2A4hycilvk?=
 =?us-ascii?Q?EtGw6PPUkGB8rxOEesEZ1Y06EmA6NQVq9Sgw1ukoLNdqAfj22g0TtGv1NFnx?=
 =?us-ascii?Q?eXeJXtlOtWD0CUvs+UXq1zT4e2qPmlYLOfJBj0OXax2y3S1OQVQRHV0UH77i?=
 =?us-ascii?Q?W7BAtrIM3LmrHH5pNwsS/kQ4mll0x0DU/IRUSBYEX+LG3XGMTa8ioeAMp/m5?=
 =?us-ascii?Q?VWN/4FTwXNo7RESFWgEqmmz/TzeWKXmFBVbCNtGrkY1VtTw1ZlEhw+V7omor?=
 =?us-ascii?Q?qZ39PF/pOBFk2WOwf5YL71A9HJlHVPX2RKFctfUiU2IoUlHV3VTDDHI0QtIG?=
 =?us-ascii?Q?HG7cNaCUG1CPeZzrZ6HblGMgxloLdezUQ98ef5jpBWleiW+ru7uvXXKSiIlZ?=
 =?us-ascii?Q?LM+o+CC/KLZf8l6LuIDI9H3/VOSk8Plaz28W/BpiJ4LrHr21GuXmId3CCbyL?=
 =?us-ascii?Q?E6qj7hUu93eQWmd905n5OEwQ82SwawiYIThAiz0JBCm4fKQimcihI/RqUTz2?=
 =?us-ascii?Q?ii3VvVSi8Rtjn+OEcRJ46NLgOaS+fotYzll5ptRC+bUKFLiBakSjZRc3mSxO?=
 =?us-ascii?Q?/Afm49RgX+JHc4dZCSSpimLzcElL5mc89XI2UiypxdEGs3bC10w10TL6lWRB?=
 =?us-ascii?Q?LW6EakMkXtPHgXnwtCahMQyhrJGuTS605i4J21LY10N7qavTLPoCC9r3aO6p?=
 =?us-ascii?Q?AHbcApsjdS4Pz+U/fJ0tJ9haEDPf9C2c7gFCSON+hMWLcYUMYpPnCKWbYP9M?=
 =?us-ascii?Q?OMq+hDBE1Wm+Z/fZpC40YapYEme9DUHzpmyWWajCTqUcwQD3aufi6S8kaDkI?=
 =?us-ascii?Q?U9V/pT0IMeqhBX4A7ZvcxZWRzgje0w3dSrUM9JyjsHCYkEFuRMPbwASm3tid?=
 =?us-ascii?Q?aqAgLgpzmAS12/hdVhq3giAqboZrPGJ5zzNzXsopuJx9W/UOZYp07kCdKh+v?=
 =?us-ascii?Q?Pm1o+vIQlIJn8rkHNcpfsZk0Ec52rS0byfjcVuhZxCxAfC48t03u8DqGJ6hM?=
 =?us-ascii?Q?kw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7655cef-6faf-4a94-34de-08dd07be4a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 10:46:42.9923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0eGlIjACgeZH7BjsOzk/dHk7G15/IfTXhsSHJFPsMakESGMmhUEeMwJDB5CidnweGVA3xpM0F+C0+hy4+l4bbKsG7bFsUxdQbDqU4ofAHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, November 16, 2024 6:07 AM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: andrew@lunn.ch; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v4 3/5] net: phy: Kconfig: Add ptp library
> support and 1588 optional flag in Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, 14 Nov 2024 17:34:53 +0530 Divya Koppera wrote:
> >  config MICROCHIP_T1_PHY
> >       tristate "Microchip T1 PHYs"
> > +     select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING
> > +     depends on PTP_1588_CLOCK_OPTIONAL
>=20
> I presume the dependency is because select doesn't obey dependencies, but
> you only select PHYPTP if NETWORK_PHY_TIMESTAMPING.
> Maybe it's possible to create a intermediate meta-symbol which is
> NETWORK_PHY_TIMESTAMPING && PTP_1588_CLOCK_OPTIONAL and use
> that in the select.. if ... clause?
>=20

This way is not harmful as it is clock optional.=20

Suggestion is good as it will be more efficient. Will apply this in next re=
vision.

> > +     help
> > +       Supports the LAN8XXX PHYs.
> > +
> > +config MICROCHIP_PHYPTP
> > +        tristate "Microchip PHY PTP"
> >       help
>=20
> nit: tabs vs spaces
>=20

Oh.. This didn't caught in check patch. Will change in next revision.

> > -       Supports the LAN87XX PHYs.
> > +       Currently supports LAN887X T1 PHY
>=20
> This Kconfig is likely unsafe.
> You have to make sure PHYPTP is not a module when T1_PHY is built in.

I tried changing options in make menuconfig, PHYPTP takes the option from T=
1_PHY.

If T1_PHY chosen m or y, PHYPTP takes m or y accordingly.

Also tried modifying .config with t1_phy as y and PHYPTP as m, it automates=
 and changed PHYPTP to y.

Thanks,
Divya

> --
> pw-bot: cr

