Return-Path: <netdev+bounces-143946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BA9C4CEB
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73F61F21191
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9920492E;
	Tue, 12 Nov 2024 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GSJtYoHK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731312F2E;
	Tue, 12 Nov 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380307; cv=fail; b=Py00g6voNHm4iLIe/TUjhF8yWHJ2YsJLJnAhYmfGYbOfcgHXOC9zcXKpIVrkXTB20tsbaDhnRW+cvL4kwZ5xuuKklUHSAZD5ojoQYZk79rx9GIwF7kSNP6UMvpNFAILyORyyO+XuBycSL2S1U0j4pBAHMUV9pJqUCl4gsT/Quuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380307; c=relaxed/simple;
	bh=fO2Z3wLiXRZtN+jBdZA809vzDIeybJ2HM4GmbI9bGoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9om6JWx8zSuCsCTXBHAqhth1zmB4WtUEWgqoLWQ7z5nOD+65aGbKB1D9UZyPlTHoGLGTWfWdVGOXx0a3tYZHrax0Lylb6pYK/P7ssTFkaAptzZfuNV3lKZs6itq/e4LaSq8U7wRC+1IF8KNHbPFnTkOfmSjGxjFIHOGwcmb6Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GSJtYoHK; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8VxSrkkBYkzRa/VGo3PjbG0XIB/GSQb6dRfTbStGwzZpLfG/V9O3AsvdNuzuq+iUb1XTSCmXVji4WrUKBWI1z7XSwro/zVaH7z+UsRkAVyUvf2hWoJeOWNY/vV2XdbSSeO4RhZDd7wE97dmKbd4zbdzV3X/+lF4enfV5O2ZmtlW8axS1JsMOz1cNPc6wvq9cdG33IhjJ/R+kjbv4S0F3elrJguQFT4NwuSH4T9eHEBihTGHqQL9kmFs7ILYT+tD4MtET7/iVo3ACpfHSU90FFDFyg4oKwTGhMWNYMUHNH0jnvv72pwICgsyCz3MEDmu+Mgw51AJcxeQpNxE8FER5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy4yX6mq6bAfRIh4o4Xl0CkRgnNWiZahXu+lGq3qR6k=;
 b=hU35Nxg8VkrufEfaX0koTRKVhU7GZeutNdfAnU3dCMQDpMwVwbjQbxfxSVcs8sPg2yir8vfs3YByz7lm9zd/Lhz8RNndK75Q6+boXOoeXyszoiBJ+d2Q5Z89QXIB813JZ/5iFOc0hIyWQnEuzGdv4A1blVopYhSIazhvl2y9B21X+V1qSs3jAzK3bXuST7Dij4tx66ay9WkhvxOXfhtGfp7HC5UlaFfkLNPEOtnnRYEQj3inTAiqLC6bwM6x2W5ozsg+Rj7AFVn7DeNBvHuY3Kb8W+gs+WaGPJN2mDn9MR/q14bai4CcA5zcoiMNzg4X6r14hWxulBOTEfRkUT1CgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy4yX6mq6bAfRIh4o4Xl0CkRgnNWiZahXu+lGq3qR6k=;
 b=GSJtYoHKWLgTJQUhrcYnlNeA7tfaQFFvd5/8xdMm8W9a0AcORCRFsTB3IkEoUTQBEy9ojl/uZTGp5oPqxqBlgiLpvK6SmxPCQ6PHHrulxAEeIcaCyG4YN97WYsrxZWtCQ8OFj0MaviC6uu6MR4WHyR563mGVyGgTxIuM/P9/0WjqjyqIjzDgaZfHMVbsLvyUCMN1Ih5MB/YgGCxKMDvtGTqvEDY4VvWC+loGLHe/MIW5cxWHvU0roX6FpsJZprzuU4lVkuvJIgWOsIXm7EwwvKf5dP25Xf1AlCyJuBE0ISRowo8qrpjDx/GV7qeVAT2eYdsDYY5LQMo4HtS4Nl9YYw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 02:58:22 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8114.028; Tue, 12 Nov 2024
 02:58:22 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <olteanv@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbMkqiYUyxAMrEtEGHh8l2mClPuLKvF7WAgAPg0WA=
Date: Tue, 12 Nov 2024 02:58:22 +0000
Message-ID:
 <DM3PR11MB8736DCA5402CFA0C27DDB182EC592@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <d912d397-38b4-4bdb-ac38-ac45206b4af8@lunn.ch>
In-Reply-To: <d912d397-38b4-4bdb-ac38-ac45206b4af8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|LV2PR11MB6024:EE_
x-ms-office365-filtering-correlation-id: 2047765e-ad89-4bab-cfc8-08dd02c5de91
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6jAaFGh9Iki2W7ItL+xiAGisBMYY0kfzMEpuBJWjdIMB5RcZRFe9BCrtZnQc?=
 =?us-ascii?Q?9L8YfrEX/F5JWlgrkEaICZXL4QZKvVFeNmFyfYjN7rPm/b4RBan/vwBwS0t/?=
 =?us-ascii?Q?9KRyNYzq7yyDVq/7cFOphg8WuWnVzGdQiHz+ikMtoaTt4pUN/K6MA6PDvXGy?=
 =?us-ascii?Q?QGWW3znboQvIlHUnKdtzl2reK6Vnq8cyXed/qjbosZBirnNtyiSDb4XBbooy?=
 =?us-ascii?Q?mSIrq0W5JZucZ+M/fmuYY2rYPnnoUHjEatn6ZL5Wzx2633maIQTut0uOVRH0?=
 =?us-ascii?Q?QQSZuFdGjRngktT4mp4U43kKS3EwHuacOJP+VbXpIJbwEQvnz4kmUMLfhEEa?=
 =?us-ascii?Q?BC1PjcPvD4o09/Z6Qci0+fB492VOflXa6gXnyBsGrlb8ZWUEesclvfXo5QIw?=
 =?us-ascii?Q?70Ktv9Eg1Gt1s1/U2vsQmgOSncVGLkimHb+vjufLkm1AlBMJ3Q5Ysz1wjBj4?=
 =?us-ascii?Q?Ukd+9aRMPPtQgNquifokOV1hdjO/R1XURnpVqZiwDFmBLMqMTbSKFa9s5jZ5?=
 =?us-ascii?Q?Lyy7pIb60hFkOdHEcE/TRBR60rPLEbZdh+u6dcli5FKSwlpnezIAUXIKm7Jj?=
 =?us-ascii?Q?5BuMiat6eVK+doji/D60z8l53QanBNI01NQKX208ZNzx94aDxMadpx3fh7/a?=
 =?us-ascii?Q?lwvZi4uUQ5PsnNMy9QgNa2Gp+jJUsi/IgkRP0ZRSZBYwz79kQUYthMRxFjF1?=
 =?us-ascii?Q?hc+s5WPmwFPNecslO548sJlfY1gQrxoKh2BVxZo/Wiqn8K5sM+C6bdbpp5jY?=
 =?us-ascii?Q?N6Nf+yNHm19CQQR6Z8U5kkdtPiFi7w6S3S+FJnxY9Ir6JUpDF0f4CYmhK5Ts?=
 =?us-ascii?Q?oEF2MNUph32dgUUu/7d/l91rrVgnwIcpZ6hcnft6ukamIer5+rYX+xjZGhkA?=
 =?us-ascii?Q?jtDW2cP7Je62LI2YPLJt5UhFU1PBT4NC4o7hrVrSNHjXEm4GqDQ5LIHFdlgz?=
 =?us-ascii?Q?qidXsNnxsMIPdYuT+QVxUFRi5xkYSk++7zTBWNcqZTdiH8MvjscM+jj9rPOk?=
 =?us-ascii?Q?oPiHTgdM5JaBQDu6532VFx3V8T7xES5hUpGotaVOBLySDepRMbDak2fQsixh?=
 =?us-ascii?Q?rRKs4arh+2d/wu7UUoQ8nLlgOtsv89A+jVe74M/Lg4lJHM5wQj4nW6wc5bOS?=
 =?us-ascii?Q?cmntyWBBKmpkeZfwhZgCH9BVU65erCWtPWENKYXJNpwNwbGcfJdh5hlO58Wq?=
 =?us-ascii?Q?aIoFItIKMBIsWY2Panh8XRbrp9T9K5aNp7CtIebWQ7P5NnFZaC7UUDMJMPFq?=
 =?us-ascii?Q?chn0Lu2oJrIvw+cbfPG+BPsFb0yE1LYhmvPEqOhLe5ldYujfUEf2cN0IftdG?=
 =?us-ascii?Q?apUTg7zDg6qqZPYT8/NqBpRvu+XaQ7nur0J6h90OK8UMmSofDyv/PxSZtLRb?=
 =?us-ascii?Q?ftWY1Zw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9aJnCioBhG0VKiwUuns9r/Umd1WZ+JSROyvCjOxwJlG5Fqs12SzSvr1sL78b?=
 =?us-ascii?Q?n+Yv8IT5ofWICqZh8eRB/vQWu/oNy/AJyyQ7cqKWNS4V5gD6IDV2OpzxSiv/?=
 =?us-ascii?Q?+2PVADSNNGRWiePRZVi3kiusfAZEI+9788xNJpowipLGwYh6pfRu2RN7Njin?=
 =?us-ascii?Q?5wvGrR3AkJ7jT1y8tesd8gG8jFEVuYjTvCrkxMm+wLshGZczZQm8WzT+9+hi?=
 =?us-ascii?Q?pr+6H9H44KKziwuqlGN9q+49yLEzvAEh5LkvouYMJ/5Ez1noJeEBgiJbMUEM?=
 =?us-ascii?Q?quBZ9ynqw+vt+tdiZ+7bqq9OY9tB3CdWc+Vn3OLnVyQVDDgN0+fQkRZWN6y8?=
 =?us-ascii?Q?TjtzEooi1ilgZPutaeI5uFoYVimyEcfWjXBqf9aoHOuVOAeKmZ5FHnJLf0fj?=
 =?us-ascii?Q?LnX2Vndkwzgfe6+5zn5zqwKpnyiR7NhvRG0wF4YwK3GQLlDbbh/jdmvkBzVy?=
 =?us-ascii?Q?FWt+BChT7iJ9Ye+1MdLIa1f60eG3enjURCObMSK3JHtVmiEbJGY48KyTlDSo?=
 =?us-ascii?Q?xQWgIjJ3UJ6r/2J5P2JF/afhQvYmZrKpdrXHkyFX4BBtSYr6L18ssj79Z5pi?=
 =?us-ascii?Q?VU9r5ErSHfPaItxXVoqS6uWkMo/iaUEOdPd9ZBsQ7YIr1zGDjd4y2PXaH42d?=
 =?us-ascii?Q?ZtdC2+GQaMMyXaN0NPl9aItlfRg/puOq7csWuMeFSBVTTRN9XjzMEsGMFDDe?=
 =?us-ascii?Q?dw6uowVIRWA5rHSu0N1zpSoiYEn1EcofL6apK234w6jJtpeiedfaTnjuSUfH?=
 =?us-ascii?Q?qPmofWvgnZUFUMprpC4hzxgERZL2a+4XIg/7Hyh+L5GQb1cuMXlg3Bx2oeSa?=
 =?us-ascii?Q?2NXLIvLqGpp91X4QAAg04/gT4fAni9cNQMpjlhgQdkH5u//2beMBlCVAb4UX?=
 =?us-ascii?Q?5kHZeH+F1EFG449u/N3sroAY5GCgC2x7eG1e3qF2G3PqCOXf+g6EkIbSYWfa?=
 =?us-ascii?Q?VsQwez+9T3B9p9wwdtU4s4DS8l9ikoIxj+IroB6xndXkinvuXVFG1lQi/G3/?=
 =?us-ascii?Q?4JlIH4P4E74x92fKNrYJM/fUQJuv6fP6XLMK61zxjS9x7mYPR5iUobF2JeVH?=
 =?us-ascii?Q?1JfUyrKZT4IlQhtnzqH4DBVRwotVytoeMo14W6J/o0zqyjpQAQ1Yoed8c6yc?=
 =?us-ascii?Q?A/FC6hW5dC6MrG0sZh9pBTuyCxPKjHbFkSyDn8c6l/n5K0F2nyoY/DfklRwG?=
 =?us-ascii?Q?YRiShKvWH0Hk09AlSB1KWzy+beFrwYhBdI8N39vtM9LckkQQsd02I3hUcoba?=
 =?us-ascii?Q?oFmDA40ERNvvuOTl5gcm/uZOnwHNuitMF52XjesPELewzaS6ghXFZJeG6+iJ?=
 =?us-ascii?Q?5zus8wzocY5KjPm8ktfNkC8+WouJuNUtXfnD5wJn1V4NpTYFVn6aBxd6LP1V?=
 =?us-ascii?Q?MHpsJbT8zW93GNxhHfQzvYs3lGdRnIzaCgpPclcekTEVu/PCqSY6uH0aZK3g?=
 =?us-ascii?Q?CAwP8IfOhF/Pqs8TG8ho6R5jy99PUU74QfnmGwqUF2dzJZ2XU29gLfuNKJd2?=
 =?us-ascii?Q?j5pgJAxq57N9tBPL5hHkzIgU6gXqtr9esQQDt4c1Lo9LHCQs0JHUumPF3OJR?=
 =?us-ascii?Q?o/Q/MiAhyRt8L69cfbmbPUp7/Lj0znuZXYarGTFp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2047765e-ad89-4bab-cfc8-08dd02c5de91
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 02:58:22.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATEp3WlyoHsvcU2h88qJKFs0FCXDmriTUsPNPNqQkNRFpRREt3mI0NMgpXpCR0uyk85Nhs7wTo3h7t3PWQB5EQex+BHT7hOd+yq46Pfd9JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024

> > +static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid,=
 u16 reg,
> > +                      u16 *buf, u16 len)
> > +{
> > +     u32 data;
> > +
> > +     port_sgmii_s(dev, port, devid, reg, len);
> > +     while (len) {
> > +             ksz_pread32(dev, port, REG_PORT_SGMII_DATA__4, &data);
> > +             *buf++ =3D (u16)data;
> > +             len--;
> > +     }
> > +}
> > +
> > +static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid,=
 u16 reg,
> > +                      u16 *buf, u16 len)
> > +{
> > +     u32 data;
> > +
> > +     port_sgmii_s(dev, port, devid, reg, len);
> > +     while (len) {
> > +             data =3D *buf++;
> > +             ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, data);
> > +             len--;
> > +     }
> > +}
>=20
> This kind of looks like a C45 only MDIO bus.
>=20
> #define MMD_DEVICE_ID_VENDOR_MII        0x1F
>=20
> #define SR_MII                          MMD_DEVICE_ID_VENDOR_MII
>=20
> This is identical to MDIO_MMD_VEND2.
>=20
> #define SR_MII_RESET                    BIT(15)
> #define SR_MII_LOOPBACK                 BIT(14)
> #define SR_MII_SPEED_100MBIT            BIT(13)
> #define SR_MII_AUTO_NEG_ENABLE          BIT(12)
> #define SR_MII_POWER_DOWN               BIT(11)
> #define SR_MII_AUTO_NEG_RESTART         BIT(9)
> #define SR_MII_FULL_DUPLEX              BIT(8)
> #define SR_MII_SPEED_1000MBIT           BIT(6)
>=20
> A standard BMCR.
>=20
> #define MMD_SR_MII_STATUS               0x0001
> #define MMD_SR_MII_ID_1                 0x0002
> #define MMD_SR_MII_ID_2                 0x0003
> #define MMD_SR_MII_AUTO_NEGOTIATION     0x0004
>=20
> Same as:
>=20
> #define MII_BMSR                0x01    /* Basic mode status register  */
> #define MII_PHYSID1             0x02    /* PHYS ID 1                   */
> #define MII_PHYSID2             0x03    /* PHYS ID 2                   */
> #define MII_ADVERTISE           0x04    /* Advertisement control reg   */
>=20
> So i think your first patch should be to replace all these with the
> standard macros.
>=20
> That will then help make it clearer how much is generic, could the
> existing helpers be used, probably with a wrapper to make your C22
> device mapped to C45 MDIO_MMD_VEND2 look like a C22 device?

I just realize there are already 1000BASEX definitions in mii.h that can
be used.  I will try to use generic names as much as possible.


