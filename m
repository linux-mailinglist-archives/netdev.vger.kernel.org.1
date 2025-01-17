Return-Path: <netdev+bounces-159118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3751A14731
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5F7A485B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56C9476;
	Fri, 17 Jan 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1eWCdH5s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DF70813;
	Fri, 17 Jan 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075380; cv=fail; b=RAKetgshlpm27GP35IjjYxEak2GfxjamMRHJYKxBFvsbLJgTVEQauq3Jhafw30RmSQIzENMIG6JBJCUrvbjrDDSRdGajGdHm3NysQzs6CkpVzdcoOBYnUQZD7zqhEWd7OMWoYgidFRGi/eeUwaJKDKi8302dcRyu3EEjeSeCGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075380; c=relaxed/simple;
	bh=eLYIG0R4jyxErEuW4g//+m2oO3QrY+wEnGQEdsT9vr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LEIWukoghg1WFXalb6q+by8bgRCJTaB/vBcPQwsdUNQlIU8pYCLcv2wv1VEZlGfuIMIEJTDXEvt4OOK4l9aAmkKUM44tox9cEjswYOeLpRaXuDuUFkRKX/NfsmZfdViyGvXQsA5htY17UrRDrfgnbsXKDd33dmM+KKKs5BfAWVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1eWCdH5s; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR2Snlm1aS4dENLcGuWH/fAf/1FNSqKQ0wtxRHZYzRC+Kca5WmHpk+YsejKxFv9B9ijDzLuijy3rDkzIXPRXDw5AuKnjQoNUAYNLoH34RpmGw6JViMUTwZPUnypzcPbw8EuQUj4xOMrd8GP7J+uWDCG9/AMLz+EmU8rhdS1Sr0t4wg3PtcM3XLKnKRvH9NBhHoLHlbqbddFM3LbI9sR3CHLgNsKtCq52hukzGffMXVKYc68DvgWPqdiEkdf4A/JaSyubM5HwrqbY0Xql+jM8hD0gusC02a4bCiS9M8eHlXdSw0lkuuXiVVWjQlPy/j+M/dsRfsyVxAfShlF7uDGLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2WrW7Fv2sICWxAoFi38M7q2SbTcnT/jggD7sRaz48c=;
 b=Lfl1kEGo3q0NGGIqgCnKC3B/GaQ60Kx+LxElvWfHaQKMi3dJ8HkznswTSRGztRsdD2C6/ppJDbYbrOHhZXgDEOVD4qI1VyUL9boUkiNdloLXBqQ2rB9VH4pP1OWrYsTkPbCFBIkjPdxit0CFCFJVBGqePRvLSakzDlG0v1vAPYD6hvf3SZzjV8cieeaCKVr+zNQO4Dn1pTg5YMGntoNBQ1eXoElrWHvKL97fjmo275xDQQS9HIkjcpwHpttVkCdtgQmoh12JT4KDuBB3m3UqO2vRwp4UIdNBnT0jirJSN414QuepPZrunt5FT012eUgAXoCgXtpsLNkD0y5n4WhQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2WrW7Fv2sICWxAoFi38M7q2SbTcnT/jggD7sRaz48c=;
 b=1eWCdH5sHIHbKWKDHAPviBiN+yoHd8tTE4M0zZgS5jnPfvRrZUiKGA0W5L8addwVMDoCELl/L1URvSvVBHkeAKa2Zg66v3gB1jInS/GCZeeg9ltN+H9u8jU8lDCGWShAkCCZw90sYlMCZJnwcHHUYv2rxUFswK1BQtlwDZh1da7wltx7hJBlf0CXlN7sSTc5dVg76kpr37CVJqPZSNxwvOfz03Fi7iDINBa8XOI1XW/IhkwGmJnhT1latjmaW/hG8qc41ZVYB9O2J4ZO0necBR4yWR8UObXB8qGo97Wq1StmpsQulpVsQVEQ58QmX1W49FCDoz4QxjBJxQUaOiDEmw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 00:56:14 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 00:56:14 +0000
From: <Tristram.Ha@microchip.com>
To: <maxime.chevallier@bootlin.com>, <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbZi6jUsb5OQZHf0qguVy2R8e1urMWcOoAgAEuMACAAohtsA==
Date: Fri, 17 Jan 2025 00:56:14 +0000
Message-ID:
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
	<20250114160908.les2vsq42ivtrvqe@skbuf> <20250115111042.2bf22b61@fedora.home>
In-Reply-To: <20250115111042.2bf22b61@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SN7PR11MB6679:EE_
x-ms-office365-filtering-correlation-id: f3aa3c23-e0dc-4246-f806-08dd3691be00
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nVMbUj5cCU1A8Nu4+A1vAQXRUUKzNEQzt7C3ZzIekR/oBRTQxevjdIdNB+NT?=
 =?us-ascii?Q?TQsGr4ZN4Qn5cG3+5v+b412xtZETp/FO9s+s5AoF2kQph+YrqTk+k3em+Cy6?=
 =?us-ascii?Q?f0neeZsPiG3nZfJAzi+KQFGxeIrG44simFoLt39xB68jTmB67LsOmt+OCRdp?=
 =?us-ascii?Q?fGchi0OuwWiGu7rsLfmwtSYlD6ijH1/tOZgRiF7KU/bszFwiY/YUx5VGKbQH?=
 =?us-ascii?Q?M+77tREuSj61axifAf/dcBaCdG43eCmw4sZkMgBqJovLqwl2jZgSF3iifQTd?=
 =?us-ascii?Q?cy5maiQ1zG5bq5GoEpuyPUoP5TbEq5joeWMAy5yBq0ImwfZuKhhZW6HSl5sD?=
 =?us-ascii?Q?p44SgQECypMbiaXj+Wg+Xu3TqjgrtU6qB6yylvCPB39NQ47IbZ4W8By3bwDz?=
 =?us-ascii?Q?7LV1Wakm1XuOlIXpwYcGf/hoAjaaqraz9ZHOuWAzwBxAmVN4wwdp64V9HCEn?=
 =?us-ascii?Q?Huv4PS3zdBF4cCYVITHubvVnD1kU3ARy9RfJ0+mXYCuJlR2j9JRqW4wvPFZd?=
 =?us-ascii?Q?GpPUWUITWf49RGcpJh7/1AXEDQuXAoTqdx432qhXF4mNwz6y45DcVMnxVhFA?=
 =?us-ascii?Q?WyBpPN1bQqqBipMVzfI5yTNN3gNjF3OZqDmBp1zKfKUDVYM/zgx7Nc5XRBh6?=
 =?us-ascii?Q?/6MiAwybXaWkTRj28J6x56RZcZFfr/UCGi9LRFfN9iWNghhh4DGmM9ftjf9A?=
 =?us-ascii?Q?XFhw2bAeQzSxbrJZd5U0BfS/ydFd5pBc4HoAQ4WP1sVY/aLhRmm1llIS+3Tk?=
 =?us-ascii?Q?lulVb2J79a1QZuuCP5Kzoir6x+I+6ewHycb6GjDHReOzUWYHHlt4h9bVTM94?=
 =?us-ascii?Q?Rl5e6grl2PCuKSH20vzNDnU+nYH4cwaOC1ekvPqLqyXRFJTihSUcWd8ZR0TH?=
 =?us-ascii?Q?VlqvU+EK+3rzcIy3KMEHRxPkHrM8Qrmx52Da+muiEdVfUhROUWXZxrceiEUI?=
 =?us-ascii?Q?oHdJg/2AuTd0eEP6aCbtDTBepiJARmsttvNMLBGTWY+/Lbmso6qG8kvSFXRl?=
 =?us-ascii?Q?BgoTnvQYLnwKOXsd/EEQZkXRTyFkGl/Dgi/my0stBP4bTe3BnHKx6ED/tg+8?=
 =?us-ascii?Q?Ts4It0T3ttnJvJ8c6jgMC4gCJL6cdxWtTwBQ9dRAm/Awky4iqTt5w5dw53H/?=
 =?us-ascii?Q?LmB/GPGWlYoI/KvEQ4xv406KR3Y8f/B1MB0nJ8+p6BVBjBDDWDdckua/u/7Q?=
 =?us-ascii?Q?UdL2wehibXxuBTig/HwjfC6ehOJx+51vYQkjNEcOg+Bt2tAw44reoIKJn11x?=
 =?us-ascii?Q?02B67jXxQTwZBrmklf9lIclz51AmR8kIyA+3tjBnFYCmFCZIQv1W/8Nt+YgD?=
 =?us-ascii?Q?T1yZOTVOignasNr6JSyy601pPzsy2oeUT173cFjziQm2eGdBLiROcgapA/ZC?=
 =?us-ascii?Q?lfDIaKbt7Lu+aexJJ0sF2OhfKpVPfuwatg43FtnaOrPbc3xmfxaUaVAC27pQ?=
 =?us-ascii?Q?4B11xsCkgXaUvEwgurOA9YYnZv75FA5T?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGL5AEHDWCWadlf8IL7umXMdzSHGNr8zqL623rBiQYDqwEmibG51/VVSZY0V?=
 =?us-ascii?Q?4N0zjC/TevuZXOWXNb9JNVsEZ/ZjT6oiGLrQKH971i5NS7edcFuKSgA3JLkU?=
 =?us-ascii?Q?n4UhS3Nfh8oTfPtvdx/4ncj5ODqF6NiYHk3UY1M4x9ZPUYKut3Amz2EnkRZC?=
 =?us-ascii?Q?Ws+ISSmsqUb0M1FUnUSKkqjz1EyPruKdag8xfx0maD8/ujHX3SgW1X8lG4DB?=
 =?us-ascii?Q?4RKKrGc6Qc+w+ruiNjQEWwUXnR5wHPiF4fIiW9kzl/StQsaeJBJB5M29DemR?=
 =?us-ascii?Q?35MQtePIHd2/fVzYhk+jFR3LkfSJUpU2woQH/Xir9qbDd21c+BG4DhdLkMZy?=
 =?us-ascii?Q?Ruea5/u17PwE4g00FIZRkrHiEUT8retVnlxFOH68B+QnjdxpbxvOOnMWw5CS?=
 =?us-ascii?Q?XAeUwQEVXKLut49hMMxNYR2q5h1FvLyuZgyONp9K28zgpWZy+yLGku7CWLRA?=
 =?us-ascii?Q?IzDMnVzAMyoNLPGwrQpv4OaG88irWKrP7biJpeeKI7zFB2F279rIJagOIPKe?=
 =?us-ascii?Q?m1RtRixY0IXUmcEfYTCyhGmAfYl/eqL2vkvhJlRHcZWWhCAMTQHGHulB02N/?=
 =?us-ascii?Q?Bb0dMk5JP2h/zXxkhmocRl1ihfa/O3hR0HIDLLDd07uTNK2ZnYrJ7Pkd4TmK?=
 =?us-ascii?Q?4kqQtW5RV25gd6948Rx+dLgjSwT7DGCfTfKUJXG8RQNYPi2NhgI8AcOI59q7?=
 =?us-ascii?Q?BskBGOuATvayk6xw8Fkcbq1Q5vym2ru4nqLxupFwf9k55KAuLq0Ef1/VfakQ?=
 =?us-ascii?Q?tPo/qr096L1dQtjLJg5FPVcplHyaY5Ec7N3DCbzGcmUD5slzaBhrlK2CgQq3?=
 =?us-ascii?Q?pWSJy+XzwigYCRL9M6fKRm5ueCTobhfmi71DTqC01pgm57MU4tMNwuVl+J+d?=
 =?us-ascii?Q?PO/QXFONky6/AJgIsj4GL543blWypqwVoMKRUnaqSOUQRk5w0juJYjAo1huM?=
 =?us-ascii?Q?WnjVGnvlHqI96VVsxaxVfHnsA2BGB0SKDevHbubvdLuMnuJ8dV1gpJ26rLd2?=
 =?us-ascii?Q?Y7AROLf1PGuxXs4Xcw4XWKDWDB8XeTaaiYQlgKYVGGYRcVke+LgZLn3nKXDr?=
 =?us-ascii?Q?JNo2T1Ff5gmUu8201gi74YCYuJaIBkUdu+VictekV8XybaBCypDz8o7kyRjO?=
 =?us-ascii?Q?EHzO0/3UqAhE4KJfP4TH1mFRI3xihPwZzSxyv23IYXyCMAyyWSonDT9Sgq3G?=
 =?us-ascii?Q?2NCNcRhjZrf2O4KDdVZ8eI9JAkiI/nSdj3+R0quGWP/5x62RZlDF78EvjiGN?=
 =?us-ascii?Q?MJyFOc9PE4R5TEPFK5KoSQZLVQ9dK1zCDa9V7aAoqyvGjVJ7mT92tSNJKB6R?=
 =?us-ascii?Q?Vgm3VSWxVfhGwxP48OBmQw+b1gYKWW9BxPhJprQlZ7dMCldaY6CfCfu2sWLl?=
 =?us-ascii?Q?j5i33oNeXTYaFhlIbsWXLIsh5cu79DZp8y+iap29n14I1WlFaLBcddopLskr?=
 =?us-ascii?Q?KyfbMjZV9VilPccE0yf0ZBUKjVUiR2J4SMo7lcGyVcFhlSCEVUUHKgOrTmVv?=
 =?us-ascii?Q?9bihFIBlVsLxTHAP+OI4mAwkCmbDiZDR8vw7ooRgkCaXtvnluuhVL/4ndqap?=
 =?us-ascii?Q?PooemjS1xgmlRioCWXwuWuJEHENUQQETGSNY1Oe0?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aa3c23-e0dc-4246-f806-08dd3691be00
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 00:56:14.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zsj6mVG+g9nnXKY9cQVWQ23lqhAw22REkPViO3JR5v8fvr3/HpmBupm1HLQWYOnB+bWn4YD1uSLEyrfLc6dxI4i67qFVn9ZJpPdFHaedChI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679

> Hello Vlad, Tristram,
>=20
> I'm replying to Vlad's review as he correctly points that this looks
> very much like XPCS :)

> I mentionned on the previous iteration that there's indeed a DW XPCS in
> there :
> https://lore.kernel.org/netdev/20241129135919.57d59c90@fedora.home/
>=20
> I have access to a platform with a KSZ9477, and indeed the PHY id
> register for the PCS mdio device show the DW XPCS id.
>=20
> I've been able to get this serdes port working with the XPCS driver
> (although on 6.1 due to project constraints), although I couldn't get
> 1000BaseX autoneg to work.
>=20
> So all in all I agree with Vlad's comments here, there's a lot of logic
> in this series to detect the phy_interface_mode, detect SFP or not,
> most of which isn't needed.
>=20
> The logic should boil down to :
>=20
>  - Create some helpers to access the PCS through a virtual mdio bus
> (basically the current port_sgmii_w/r)
>=20
>  - Register a virtual mdio bus to access the PCS, hooked in
> ksz9477_port_setup() for the serdes port. That would look something
> like this :
>=20
> +       bus =3D devm_mdiobus_alloc(ds->dev);
> (...)
> +       bus->read_c45 =3D ksz9477_sgmii_read;
> +       bus->write_c45 =3D ksz9477_sgmii_write;
> (...)
> +       ret =3D devm_mdiobus_register(ds->dev, bus);
> +       if (ret)
> +               (...)
> +
> +       port->xpcs =3D xpcs_create_mdiodev(bus, 0, <iface>);
>=20
> - Make sure that .phylink_select_pcs() returns a ref to that xpcs
>=20
> - Write the necessary ksz9477-specific glue logic (adjust the phylink cap=
abilities,
> make sure the virual MDIO registers are un the regmap area, etc.)
>=20
> I will be happy to test any further iterations :)

The KSZ9477 SGMII module does use DesignWare IP, but its implementation
is probably too old as some registers do not match.  When using XPCS
driver link detection works but the SGMII port does not pass traffic for
some SFPs.  It is probably doable to update the XPCS driver to work in
KSZ9477, but there is no way to submit that patch as that may affect
other hardware implementation.

One thing that is strange is that driver enables interrupt for 1000BaseX
mode but not SGMII mode, but in KSZ9477 SGMII mode can trigger link up
and link down interrupt but 1000BaseX can only trigger link up interrupt.


