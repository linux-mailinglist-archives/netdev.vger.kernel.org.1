Return-Path: <netdev+bounces-127227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC1D974ACA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0ED1C218C5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF2136338;
	Wed, 11 Sep 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q/YCeaGM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190A7EEFD;
	Wed, 11 Sep 2024 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037980; cv=fail; b=rTWw3eONPVw4PZxoPWg3RPsnyflsZaqushxIQued1DqjKfTxB/EpzEsQutpPUwZr8M7r+MR7RSAF7XIMVkGPx3DaSglK4vyOmW86bszUZvyE8FjB6U4fTN0n1+cfZuXJ+DUHIGRCwV2P/LVC5VxckQjtSGKmp9+egUVP7tZEER0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037980; c=relaxed/simple;
	bh=eMsJxZV7DtTISs2kdh1rYH+unmgERvoHfCEEehouezs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAZ/gyzPVDUFk890EfvLyO7OMjrK7+FCqOxOKwRg5MCi9wiwS5F+RppBe2yeFh972Z2wUYnLGBW1aYdDWDFSfd8TuyRkBdidktvxl0yi2GFjDrtjAgWJMgs13EpXaPscNnOUtpxEp95U8EaP5RmF8isD+Mg/dtnzJA0qmX0usTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q/YCeaGM; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si8BkkVBNNffEjIBncHTXUo4GS3K1by+8tdAq9SU5ulo318j2gNsYmYJbluOlOxfedi/Y/8FOOhVOhzfsXh2QoySd5it2oGgz0NMJ7kCkLKXQ4cQa659MiO04jNITiG16zZPuj9KTLs9IPELDPYjr8OV7vIWuq2TX5IL6x51JL/WJqCRx6NNAMK1Yn36UGi2DRFZ1Vdlw5hp5IOOFCFdZXMZoiAaqjyBuyqx5yLOvwmaJbGjRupAYLcd5HB85fkTBhBzPDHg4m8jv6haz1Wk3o1G2LOb/EVGQmVY05IECoDbkrfvPl0Brm77qOsObadfbTKlE8XWAIK8oXsTYUfd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt9AmWO7dVpsHm8PvuCdIi5biXENgssCFNRI0ERmfS8=;
 b=DOtKZ4Tmt9sL29K8oLDzUJIGwknouzI2DFfmwxszxNviUN9JHCvwiDlKAbHL6mrRdyeIlP7RuIenlRnVtWePh8bhxspznIJrCTSRX3EUbexhs6BZg4ST6spm+fZkUdN2I3qImAGR5lHYYHl+aTE9mgTJYzR2PRXliml9D0l6z2Wzz+U9w7HxrBbRkc6DJhg54tYfiwwe+wNB26r/hBZor2cYARwQaWchRedJMIudLNtHr9XPSioLRF0Srsivd/x0JGxr9Q08fkRj4zezzml2g5SxulYS+Km3VsSXqYVsOMVF7iErw4JPk8pdGg0mMY+BFDCXlzYsOUXZVE3+DbEFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt9AmWO7dVpsHm8PvuCdIi5biXENgssCFNRI0ERmfS8=;
 b=q/YCeaGMqbk0ecUW1CHOq21ibDkbeFoeCYzu233FLdGUsxYxsK619hW6W0D38zm09DCghbi9B+S9mkKebsAYitmCAgfqrVVvr/2b+bfmYD/nbJyVtww1ydxdqHOqEFi41q2bKq04yCBzFTeEoTc3sES1yCdyqbitExFWNZ5gQ8r646vEE9PtTdZj/NHDRCGT2YI16tecvh5LwR5i+OYQN/Sbo2MaxhROWp+Y/m9JkNnCZQQC1HgBx0YiBSd6QtJavj28V7j/OsH1kx3hkriX7A9rPlt/uGL9wHF/lsnuwrsfpYlXLFYb7kQk5CCf8MDroi0kvr5TMuMVzOqtx5aBoQ==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Wed, 11 Sep 2024 06:59:35 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%3]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 06:59:35 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2] net: phy: microchip_t1: SQI support for
 LAN887x
Thread-Topic: [PATCH net-next V2] net: phy: microchip_t1: SQI support for
 LAN887x
Thread-Index: AQHbAtNvc64O+86IcEGjLD/P7WhC+rJQ7JWAgAE8w6A=
Date: Wed, 11 Sep 2024 06:59:35 +0000
Message-ID:
 <DM4PR11MB6239909262BA13511B49873C8B9B2@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20240909161005.185122-1-tarun.alle@microchip.com>
 <67481e1d-e0bd-4629-bbe9-4fe03fb1920d@lunn.ch>
In-Reply-To: <67481e1d-e0bd-4629-bbe9-4fe03fb1920d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|CH3PR11MB8436:EE_
x-ms-office365-filtering-correlation-id: 7f68b066-5016-4882-e93d-08dcd22f4b6f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ss3RmmeyddOk6razD4j8ZPLrXJ3wWBbF/ZVGQj5Brtl2kYXbmEuExGSrl5OU?=
 =?us-ascii?Q?mN7KF0N3n+buQcYJgN/K9cE9McWAPrq876o4qpk+neGoUPuqoJKs7ILbzSyt?=
 =?us-ascii?Q?YzTd9nMFYpbJEeDXpGQyJtQIuqaSJsjSqyUpOX5pkjzeEEl/fYP2SGq1i8uM?=
 =?us-ascii?Q?0uWm0k2xq0U8Yd6QqGADoHnuaF3QLDGW6YKQ9LpG3S6G+SrGmNSOFuEN4cgA?=
 =?us-ascii?Q?8qmynTMqBgfeIPJ105SibxbgHoOcbbSfA+7rgP8b/iEYhtHAmb09XiHbNWeY?=
 =?us-ascii?Q?VDHUbpY/odK4Mpt9fUUUYk5BlwgmKM3Hm1NQWkkGULnboNh1kmzhNxloqjl/?=
 =?us-ascii?Q?voWzkgrmpVx3OyYfGgB8v67ZggPdPLURlR0X/zj+xoQDc0oSEEX61LR2fbfK?=
 =?us-ascii?Q?oFTDytrSPpM6sYjGedv3mAzGTtkJnfEy1yme4Sq2AQ8PJYnFeN0T6qp/eiKk?=
 =?us-ascii?Q?VTE8Rjazlfp0geNFV8XnZE4lIOzMV+haHG/HK8PCkBLm0aUS1/vJ5yJUnTxw?=
 =?us-ascii?Q?fJ2+y6I5ScKjigBLfAoI91HcbgPh2JddYlOdmDRMxJPBkq6csETVvFCDaOjj?=
 =?us-ascii?Q?H9coa31wtbBDYQdYszoP2h1CTtzzmFqkUB+9ptO+1DefSrs6NU6KZEkkcNG2?=
 =?us-ascii?Q?UqAGCukOJcCrtu5lfXR0AYnG73DVGZU2hnGV7J0V4gEVWUjiUJ1tT8VPSvEW?=
 =?us-ascii?Q?1A1p/bPhvpdyveNVAmqdSgkzXXkDUrUSPqIz/JHFYWt0PqeEYpICLN4tHtS9?=
 =?us-ascii?Q?BG54UVRbeWiZn/oFgKs7IzSX+ZUYRSuIr4TEaclkJ+qi9KG+ZDth5ZLinZoa?=
 =?us-ascii?Q?+bQ+9PzDXH6dcXXN2RfF1syZUBhVkUSptSLGX1QiWGjQO5xhREH8vzKRpTb8?=
 =?us-ascii?Q?80pJtkPPTCLAW/2Z9kU424XpFMlzRa7u+FtkjXXd2TMBfNKSyZstc/BOI5Al?=
 =?us-ascii?Q?+vzEeZ7gitXQdTC8THrjrndS3GPdQG75sy1nJlYlUq22ZuA5QKedFIscOUfJ?=
 =?us-ascii?Q?b3oQDqiadOWuazeq3TQFwFJF7VwWR0NFRHegNNN3BYb1/YqEbDsO2pGQSUuR?=
 =?us-ascii?Q?PYi12BD8Sb46HO0gX23TDvV7OeUQ3t8MVl+7oDIBlV8NxBFSJFm2x1UJjy6K?=
 =?us-ascii?Q?fXhEU/GGm0Bt2txMxwv8xqFu1tAS8JGmWiow/i30nb5StKY8l9niTPK+Jn+o?=
 =?us-ascii?Q?V/IUG8kBPgIu7wD+3098fJXe4Htry1m7iMj9qbqlyKo1Hc6tVW8mvoWPQrWW?=
 =?us-ascii?Q?8iTUT/L3FtNx9D9WbQzQ1pgUdrf6OTzlWJTIYf6+GDLp8KkbvyvgBgGKE1ry?=
 =?us-ascii?Q?Kuv/Mn2kBZjsLXJDusYKVL9Zvljg1yFBTNw5McLn89HFBVYoJVbnqQtmpLS8?=
 =?us-ascii?Q?cNEoUrUTgQYZy429/d1OsyWcE+1hOrBfPQM79XCj8VOsmsWoHQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DMOP4qmVTstMig6IIAzw5n9vA8h1UolapJUrxATbol1rbLtCkE1Lp3rfl8rS?=
 =?us-ascii?Q?o/behDiBcgjywjrBXjQ4CPuzNGznqFq9GmwAYSpkFxsPQ7KMjVlLhSZT+/Oz?=
 =?us-ascii?Q?dl59Pl0OiBMYb2UZzKOrC9wr42pS9Z9ywNAqJCXiEF64QN0IGwYwXORoQFqQ?=
 =?us-ascii?Q?4BhNg5qSHAlVXEe9KboYB2xCVAkge27ENy7PQTeMh9exlDuvhrur7a4mw2Sc?=
 =?us-ascii?Q?SsCv0Yq3xoseD0AlKmbeesgpk6UDXzPiU5ji330fxfvOlwx8BohghDGK5yeY?=
 =?us-ascii?Q?exUYwXAXyuclF5MXzqmsvQPW0Y/lXXhbl8/Fb3szayeBcQac0kiEZhQYTOoE?=
 =?us-ascii?Q?MBm78dVsLd7nWq+hF6YNWqgtku1CoP/Dn5Ckay/jc6nz5TmtTL1UDQZbz2Ub?=
 =?us-ascii?Q?2Eo1UcH9UrCdRAqCSjieBaXvLKhWZYBJbJPzMmAvkC1GnbxKc9Ww0BYx3uVu?=
 =?us-ascii?Q?GEjjDdsXosYC2A8DvT+E0RYR6QKBGsXKjvfDtIM26IM7kdOOqZhQtxWVa1lC?=
 =?us-ascii?Q?/GhA4VLNvIfd5QfJik9ONbUZy9hx6wOTisg7uGW67TMm861A+DAAu2rtGf9h?=
 =?us-ascii?Q?k3VsrhO/vOwL23uQvvubMTbVMguN0OCuecQgAQxvS40pZ2Wt3m/MvQdDUNSU?=
 =?us-ascii?Q?1t07LJWzm2WGe2EIbW2hHUW3i9jeekmlV+MJjRRy6HBR4i/b33Wx5AOYIa9x?=
 =?us-ascii?Q?onLM6sm5WZr7BcIEsEYwPzJhlXsoO81ROLjEmqAd++mI1Zci1M1T2LFI7Uny?=
 =?us-ascii?Q?mT1ad5Dyj7VALN04IdvcJexHfl/TY1hMWMnNCa+x+85XBqVUpCXT8vXOIdMh?=
 =?us-ascii?Q?zcewsyRqZm0IOlm+fS9gpKQ99imghKyvxZiG18yAQfWKQdi4wilvkJePHqaz?=
 =?us-ascii?Q?jAe55YvN/jPYE3j3+/X7H2348T/dHH55olVAEDoTtfyNI4r1+UjlxMxeo5S6?=
 =?us-ascii?Q?PfbPElwlWCTha1p4qb455cy7KfWYEqo8JLCNM511stAslPbrHB/cT/Gwt7GB?=
 =?us-ascii?Q?45f3XrD5M8IRsbkGoRsouqBCZzqmO/MBebQV/+QFT5fkZJR+RWCLcZLkMVBC?=
 =?us-ascii?Q?6L3Mo6DDNa5hR6k+jv1CbRAUaTODRWxFNqcYctAWKXQm4N1q4mCv50eZaJEt?=
 =?us-ascii?Q?Xm45OjZLqB2mV6BOX0+HchfQ4LUJULSbgUgFZvDB0x0HpNeKPePpOziFaTue?=
 =?us-ascii?Q?fuBi8v906j9cfuLm7TmHyi/MN9pc3ojPLdEO+lGAUvOHbDzAjktZC6vSs6z4?=
 =?us-ascii?Q?6CXAOhGz44lshkHd/+HSW3bag2vRqNJ3AdYfV4ssNASa2ResG2AV1ylv3yAO?=
 =?us-ascii?Q?6chej1VxhqHMSWfqLBklZSmQ/zuFj55uNr0BxnIl0qYGY2M1S+vYARF5qPPY?=
 =?us-ascii?Q?pwy+c7G8pTg/9Gsq/ZYHZqQ4HzwV/SJBwOZGDG1cFGhqmJMllyd13NDIQhhl?=
 =?us-ascii?Q?h+q0HsltZYCcVu/7c5OskFwqsEL9/xIYMKu8+3OHee8jc/Z62Ozgc+Nn5f05?=
 =?us-ascii?Q?Zs8/2bfSwXsJ0lmUx4n0WUKlXjZKE8Fb3nSO8JzMk5wIuH2F2VLE0X/x6k2o?=
 =?us-ascii?Q?P+LD3lPnqOkiI6U83oJ+fH9mD8Hv1oE8gPPY8LOr?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f68b066-5016-4882-e93d-08dcd22f4b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:59:35.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9koUNLMiHA4Az0k7Cc5ymm86GhNsyDfQT7HcMTHCWN/VdMXtnBdQqo7Unv9ckDMqzU3SusfzItdVH3k6PLu6UEporc6nAawLuNZnlg6Nh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436

Hi Andrew,
Thanks for the review comment.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, September 10, 2024 5:31 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V2] net: phy: microchip_t1: SQI support for
> LAN887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     /* Keep inliers and discard outliers */
> > +     for (int i =3D 40; i < 160; i++)
> > +             sqiavg +=3D rawtable[i];
>=20
>         for (int i =3D ARRAY_SIZE(rawtable) / 5 ; i < ARRAY_SIZE(rawtable=
) / 5 * 4;
> i++) {
>=20
> You don't want to hard code the size of the array anywhere except for whe=
n
> actually declaring it. It then becomes easy to change the size of it.
>=20

Will fix in next version.

>         Andrew

Thanks,
Tarun Alle.

