Return-Path: <netdev+bounces-150933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D359EC21B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8AD283735
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9911BD9E6;
	Wed, 11 Dec 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCLgBeEH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F318EAD
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884064; cv=fail; b=BcA/Nvb2XxeqzGcM+zKZyYQqOKCTdf+Uocd4OoslrOUpm72lX1FOzUbG0PfsbxD6zMMznQsY5OZqWFcMhfB/0FQqxq83sNb2K8G5jUYmc/6AowHRn0LMGhcOCkodv+qR4FnPg8062tST/YjyeNyZu/c/EmU57i0XTm8K70pUDWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884064; c=relaxed/simple;
	bh=vdbthnm2LRkwXK+wkriBe65IZ3Rncselz7Du+6KJtTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJmZiMruttrPvO3miJVggniyUI2qfuiZA4dx3CbKW/zjVR9qrvG7IT7+uhxIGQDp4Qon4TIjl0r1pT9/PTJgmf500RTEYQAVSeF6SLuhJFIhSxYoYnaChdaJlVk86MJNP+p+Uh55q6Syw1+DolemqV0gBH1oB6wUvSUZqh8QJuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cCLgBeEH; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE2Ml6Q1DzWi8Mh3M8mP1T/oBI+seBgqdFM0GdoKjswU0siFHVRK0g5Iz6bw+zGIL4puc58zScyAbPLUPUILMbnvWkDsOTcKeMOJzL1YLdMtECQzLIX2ykyBaCO7pnZYAkck5y8ERqcwhTl6mIzwGP9jUYE7obV10rIwAgebb7gk4MlSqDTDfYeYCHBLogED7+8p9+sdjrWR0D4hnxOFRbYMkEzqUYl7/t8cBpa3ufjRjN0fbffOzyLRgEXerRk0TSKWRjrviTHUEfuSL7XH6IBQSrHQRe8cOLCe8amlcaJ1800onfZaMRuplnRiate6gei2i3+ttxyh/g3YFIVmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwOuWfP/J642fqJgfMIJ+UFVdyOAGkWIRXkgKQfNyZU=;
 b=L9XtW9WRRqNfqwn79u5OrKfhbFEhrYHLB391tBxL/5DT/g96oX1RUmeJPewnYeCN6B5V7TtWQE/6rOAT1A4XWODJReMMgsFLPJHRXQCR3ofiBcyRR9XhuNbImuZMVYAtNesoyk88kI+0UVvD/5D3Kwb6ujeC9eyzAnB2NvPcW+nohxqY2K1/q7o3cULGPy0eNIDLqv42kak+B+B2hM78jklSoh09/KfzRNXtkdiMVv66mT5vuxQtSK19rslz7vYWH4CKExGZAalLN4CFKfXuwHYn5vPBnM56nhjCxxatE3Bv4lV8AD+44cmMyqEcVbTJ5bGCbX5Cf8H4Vz9XN0cqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwOuWfP/J642fqJgfMIJ+UFVdyOAGkWIRXkgKQfNyZU=;
 b=cCLgBeEHT+4D7EfEinzWuHzSk89X9UpMJOJAcucnZtkC0XGc7eNwP0zpDrGvMxF90Jh1KgK3SFrX8HeLzaJ2hmBpVgn8nDmUnj/VxOqKge33s25v37R66KBhf6GiWcfR38AAGo4MOrVxVwwkxg2gaRnAb5w/Qh/Rf1/yrgULmL27k+xdoaZLQilf+VY0McUQDzKyQyZ/QJLLEgXQw/9Yfh3kHdFuzfltVTVUIi1VYNpqz2J3B58n/9HGl1fyHZC/qGl3Q9L+BnoYCV6ca3/JjWyCA0ff9ejmwhElfiMwiBLWbz0xs61WDTDuPCcdZFt0nd7mK/VbF37QrZ0aNE/s6g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10476.eurprd04.prod.outlook.com (2603:10a6:150:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 02:27:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 02:27:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: RE: [PATCH net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
Thread-Topic: [PATCH net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
Thread-Index: AQHbSwBu90gqLxiNO0Kv1vsV9fl59bLfazeAgADlz3A=
Date: Wed, 11 Dec 2024 02:27:38 +0000
Message-ID:
 <PAXPR04MB8510B101C282B0CAE430FC76883E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
 <Z1g2md_S1kEjOKQH@shell.armlinux.org.uk>
In-Reply-To: <Z1g2md_S1kEjOKQH@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10476:EE_
x-ms-office365-filtering-correlation-id: 629e8c67-80a6-4e22-908a-08dd198b6190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7/FW/oDUTZ6+B4NLqXkGvcEITHTaqT612/u6s99qvZ5PVaXNhW6fFZmM4P96?=
 =?us-ascii?Q?kAZ3xC81H84yY4Mif9K/Fsywa/Lu2TyZ8X6XxnE26a4gaUvzVWjhcZdbjewv?=
 =?us-ascii?Q?J7335xLC+qrnVKdOAfN5vmosu0szM/3oGb1LZwpQtIRyw3F99I6ZTcKax5ey?=
 =?us-ascii?Q?Ye73BorrCnrKMXbxJi71SPIL1jr5/Kbs8r/0O3xn7W4+iNzsRsKF537gVQK9?=
 =?us-ascii?Q?xVJmY3Uew+nsDXvg4S7M/33JOrnHKAxgxXV5Xma6at/3+4ktcTA/bT888ebt?=
 =?us-ascii?Q?GVkLUUSNmoxYG+v4+iZi8kyaxvpi5u4n7CMUMuLqRU1YRYu3uQX2zrD3PQU7?=
 =?us-ascii?Q?nb9N5f8u48waCIlibfnRIVg46iDjAT+cBwD+5ZzAdlKpbHvwaavTUkz5dCyz?=
 =?us-ascii?Q?/1xTvKW3YCyY+U/Ky/9tHmNT2sHK52cdH6RD8GvGZcHwKSHSBM7e9JgFfjJH?=
 =?us-ascii?Q?QlCemAJ9A4UB70XbyJhGcMYLuexLUHVElgNCGM25/BYM4wH+uvW2URfK3+6+?=
 =?us-ascii?Q?ojY7vxYoUVFOZkL0hawJiuci9vtiEOGXAcVkUcqItAWzXmcLtqvoG5d4olZX?=
 =?us-ascii?Q?5Q8Fr6fylKGSolmTPBFYAcfDC3PQfIcn++K+fZbtFGQfuSdW7eRKvdC1+KU0?=
 =?us-ascii?Q?p4UckTnsWrl7TyNRyUQJvrwADMrCR8gqpGOpY96JCI1XZlPN5d/wKXXNE6BQ?=
 =?us-ascii?Q?OfAv+Cd5Z7sImy2fc7LYLyODAHiGBayW1dEwVt1o6ASVKLChignyw/8z7+8X?=
 =?us-ascii?Q?nYVTQyqM9JPpeYvjqXQWfdkBa+EF/nyENABOrBfRVaerdQnN5zAIBIUOyT+F?=
 =?us-ascii?Q?p2JpqbI6+p6dG4AiD382dsKZU27YbHIdFWH/ZcoQeVbVIOUlVWn3dw3McFT1?=
 =?us-ascii?Q?rivqGUVmJPxHUBiMnmp/lq/YsOUrOMzcvn6ueivpAPCTFKrPGMzyaGdW/dCx?=
 =?us-ascii?Q?zJY4xCwWSe7vChKphJM2W5SCYeDDTJzXFviUnq3ACcLH6pF+0yZDO//jKpC2?=
 =?us-ascii?Q?fHEhgWW3+XTCoYD+KpiRcZYdYYHyA+WwOqFPKjKbpXph6/fzb4J3mqDOhYfy?=
 =?us-ascii?Q?RHgXqBEfW+DrwmXb8/+Ht/2uyg1WphDCtOZiloHK62UVAM23wuPy0qTEnHKW?=
 =?us-ascii?Q?40kFoHMKCI+nbUXSxLIAj4DT1dLMqSbH+hDHZLX/UJjxHKBt9cIxWoWDsPBP?=
 =?us-ascii?Q?lQnBZtddCMReirPU4I8U7XcbpWBW9VZDpiJwflmmQZN7aayILZJV1qPRXcbc?=
 =?us-ascii?Q?bTvd3nQRaej9wJ36WPxV247yf3W7m9aFPn3UEsrRNksqUZOyM1YJTnoy6dwa?=
 =?us-ascii?Q?+53GYNHnckUua7EDAWYQpccMISH37eZtnyOnRfFwyIiNn0Myx3mdOeXuSfe1?=
 =?us-ascii?Q?2/Uwx0NbXwy94JWEMeFUqgFyH1wqQDKWFYhrdQBsPGmF9jn/FA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w3nXO/LW37TvowkH3cQtxJNGhmmWz1unkw7VUOm7pcoIfwla82aOvBVY5j0w?=
 =?us-ascii?Q?UcN74d7+C1Jh4jkiMAe24RHRBcAXzjflUOiBLl6Kg2rXYc5GagAKuuOa/FAD?=
 =?us-ascii?Q?/rQ1rPJjr0QLV24WWNsE46bIHP0qh36mOM8CjOBZMyTQAIXYE6C2lvZnZaUx?=
 =?us-ascii?Q?aykg9fhY5GzdeHN2S3GwKu8qeS2D2Po/Y/3YLQS9QbI8bw6QeNapbgJAdBB3?=
 =?us-ascii?Q?qsOBDWG+DRJNU3Qvj01M1+IGITWv8IPB70iAmYKW5mmhpgj/106SzLXVUlzt?=
 =?us-ascii?Q?/kXLxdUyguHC/hg/agNBY3vDzqxU14FJlYCzIuWpDhHo6IZqpXlW+QcJNpPZ?=
 =?us-ascii?Q?VvlwWIQpbqOg3GLp3SyWCzfSSRCVjnMcgIe3Xgyvx3hK7mak+jgZHC6Yw2mT?=
 =?us-ascii?Q?5dluLOHSkwRzUfr/yim+q3VWaXL29eXLZc7JwMUPhMVB8FIsfXsGy+IiNFoG?=
 =?us-ascii?Q?Y0IaxTtqJQ2I3ND66Col/pahQ/OMej4/ikJl15tpfMSqYdcX/9sDiGPPVwA3?=
 =?us-ascii?Q?vGvhvCCPE1npDTE9y71YsCobDE5rPrNxAKgF7SEAdqYqVm4RQ77J9//6kuup?=
 =?us-ascii?Q?bdjdgzjXfQfGFb9S4CCXVNcaMB8qTK02ARAeRGJ2bd/30IyCV2LQsUyBNs2U?=
 =?us-ascii?Q?BSLoZbOAdctfeU9ALqGcoPEo3rjW3ZOplwnIm3Vbcuj5TIrTsQAwMYh8F9r6?=
 =?us-ascii?Q?PKmtDax+oxvX636Iqbj1lBolA6nGLykBYELMjua+njAJ4Qwa3W7dK9a0myST?=
 =?us-ascii?Q?qg1xHJI0rPrn+K6VyvTinM/R7mQRU4IUYX8ef7/xs5/ffOIljizp+43P5zIM?=
 =?us-ascii?Q?ikOHkFbeVwSf8MxidXH58KU4pg6WMAEu9t+D5Quohad7TLrukGIDvoJyPndi?=
 =?us-ascii?Q?zTDxouumDVLdCE5FdMOduI6H/kQms0FXz+rGoQkRdJ+0l9Os++TTeLPLmdhe?=
 =?us-ascii?Q?4prN8+cxOdwN2q2MSGUWkYqozDhC7bYCMBNUdQDUAYgYz/n5KYjb8SePaTkT?=
 =?us-ascii?Q?vaz8gXef4FC8Fb1opFPdcpGeq991vrElRgfKVgY2QYqwFggaDJbvhC4f7OEI?=
 =?us-ascii?Q?KVkrTWVLfN8tFFKH2L8SuXpBlVRVCA1Ol7cy9DYC53zhmLWYkGjvc3NmiDBb?=
 =?us-ascii?Q?/kx0Kn/IKihCfHhjDg5gmya2WPS+/MNi6X36od+uZnumnrW12pceV8thEIpX?=
 =?us-ascii?Q?Ry14Y09XhaYsFNp/WhKxL6Q/m90rZLL5xj8Gk//ZJyRGpdAJ955njYeAPoYm?=
 =?us-ascii?Q?W6Pazsx7QOJQQQhCGGiFk/GvhSiHC9WxrCtMkfc8maEkH+u1gC1F/5TGx1Mv?=
 =?us-ascii?Q?oXbGrK5WPHaexkSYW7onfcpchLA+lw2u19T6Xe8F7tmMNlgy+EELgrLCvQUB?=
 =?us-ascii?Q?o/N8f+/mnwJZP6Tdvx4NNrdfxsXcnxIWFVquPWUnK+HdcUzH+b61k9PcBC6L?=
 =?us-ascii?Q?MZ6oyvOry8SiYeuj+Dl+gGlDJkvZUVlsDf1lDu0/GnR6b4qCPi2D3QfwZA7E?=
 =?us-ascii?Q?iWIym6b4K9t35v/e49KG7myF3GFr478o+KHlnfuzfMRNUKRbJ9qr94GFw4is?=
 =?us-ascii?Q?dg5swOJDQmxvH1LHJMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629e8c67-80a6-4e22-908a-08dd198b6190
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:27:38.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rk/GCyyYjKHEwO36ZkIzsC0vlzRFt+6e5gZhKboIz4NTEICjA5LYPDhst/FoWTrYBkNCfaNWwfWH+BSbgV6K+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10476

> On Tue, Dec 10, 2024 at 12:38:26PM +0000, Russell King (Oracle) wrote:
> > Rather than maintaining a private copy of the LPI timer, make use of
> > the LPI timer maintained by phylib. In any case, phylib overwrites the
> > value of tx_lpi_timer set by the driver in phy_ethtool_get_eee().
> >
> > Note that feb->eee.tx_lpi_timer is initialised to zero, which is just
> > the same with phylib's copy, so there should be no functional change.
> >
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>=20
> Note that this need testing on compatible hardware - I only have iMX6 whi=
ch
> doesn't have EEE support in FEC.
>=20
> I'm particularly interested in any change of output from
>=20
> 	# ethtool --show-eee $if
>=20
> with/without this patch. Also testing that it doesn't cause any regressio=
n.
>=20
> Thanks.
>=20
Hi Russell,

There are no changes after applying this patch.

Before:
root@imx8mqevk:~# ethtool --show-eee eth0
EEE settings for eth0:
        EEE status: enabled - active
        Tx LPI: 0 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
root@imx8mqevk:~# ethtool --set-eee eth0 eee on tx-lpi on tx-timer 5000
root@imx8mqevk:~# ethtool --show-eee eth0
EEE settings for eth0:
        EEE status: enabled - active
        Tx LPI: 5000 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

After applying the patch:
root@imx8mqevk:~# ethtool --show-eee eth0
EEE settings for eth0:
        EEE status: enabled - active
        Tx LPI: 0 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full
root@imx8mqevk:~# ethtool --set-eee eth0 eee on tx-lpi on tx-timer 5000
root@imx8mqevk:~# ethtool --show-eee eth0
EEE settings for eth0:
        EEE status: enabled - active
        Tx LPI: 5000 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

So,
Tested-by: Wei Fang <wei.fang@nxp.com>

