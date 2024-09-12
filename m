Return-Path: <netdev+bounces-127920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C049770EF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C31C214E9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2741C0DC9;
	Thu, 12 Sep 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BdbR+jhB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38E1BFE1A;
	Thu, 12 Sep 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167108; cv=fail; b=AZ3XwXcz17m0PHOY7SlAUBkpH/0SJ2ei6Wh561uC67218Pulx4ngSZKygb3xPSmE5WhNLE/mdkunFsvVOTZ8rd72F+iC6MC3xiQrjyrX24UuicIi2/j2/FYA29njqHrbfI1aQn1RjlLqsxgPMO+PTcKkLbIw2ogFOwiehWqddDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167108; c=relaxed/simple;
	bh=Laz3guaiE0iSzqip3aOXX+D9WUN4Oo/C7Q2zO+8bJEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=unY47DHdOnx4FMeujOlnnHQONCNfYfSqU3UPL1l65KwtP+TelvCTWVmj3C83QeeQfZ7mI9GwoYU4J1pGcZ+pVfBNChe++/xBQrlKQJweft4PmYnSTyeifEzK2rB0ukNlVUdi6mG/+hW8cjsh4043F/sn/AEbLGaXHmnfp7P80eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BdbR+jhB; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgSthWkkcPxm7Yc5G6eW4nB91L2pbeVJ511wk7Ye3nJdSzS+zFMFliSJDqtfXqZeJZEz/oMqN9xVWTILsEESwua4i5+XAE3oE3DMIPdSXHivuv2QPaRjzNObgQ1eSDho1k43K4thjTZ2zVrHLC3AaoQXi5u0Kl+XhpciANKs56XFgp2ijPfvsKnGaugXnobdoNKn56IgWigvLXZaGKcJIyond6YBP9n3nD77nxvolaAbPbi5hDa/iErSNY8dBP+j/gIL8Ypfy1hya4uLTb6fFv/RD9u+YbltnF5CUF7DjM+XSeW3zdtgFFocMHN6n9VRAHRof8Af8Q8DbRNKFIvhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhkDpimyIKbPnnqTzz8FUfmXNCTyt3POhQMLAvn4TsA=;
 b=PVfoqFWHwb+9Ss8btdUIKiHUj4Hia4Px9XTpAPafa7OmYoC6fIDSVT63xSxBvh1dr7NqaYYQmAOHBEK+qi6CQnHROQCHYrkXXYA5N5l8KF9iJv/1mrGorE04MTMt59UX0HA55tlnDWrdvvdHfC1M9wNuhAl2CFjBMTvr32ylmSaOFjSkTHhZJVbRUhqwjwfFz7/KN89a3R8PSJA3oWYB8oivk542eRzyOHSmHuygEvx1hbxb5bYPAosfIW+DngC5u9ALYUbwJNSlWRf9WFvTZq6t4ldmh+qClBi+4+Idr0mzyCt4FMH1SKV8Y0pF5R4Bagw67Sc7x80lYLZYnktf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhkDpimyIKbPnnqTzz8FUfmXNCTyt3POhQMLAvn4TsA=;
 b=BdbR+jhBObDqobuVOCx5m0olZMAXtvgNsFMr65Jkzzg/TF1oaObYDI2uUklVS2kfXMRoDHZSj1fEZGAzJe4AGvIS3INAoAdCPjEgRhCpw/DMoVVHbkwCI5oy6zNwKF/BaxD2oIfSFuYwTHrfD9yWg3vfAKyzxsL6fJJW6MOL6NO1NVoBAruDVui+zEFoxqJO4E7W0UIG1B7eKcdO73Nf/Ll+dFqTI9q33t+E9aYWt9qzgS+/h/xBmyMWcZPFfy40YzX7rQZTCW9Y98WxVlqvO/lyonPgU/hmMVerj3KM6UaSXQ9Sghe1JXGPFRrc5WcdWy8k1/mi91VW4iaiqLi/Lg==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26; Thu, 12 Sep
 2024 18:51:40 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 18:51:40 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>
CC: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Topic: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Index:
 AQHbBGX8VAfW8KWmWUiadZFQXqJr/rJS1qaAgADhgICAAI/DAIAAAwnwgAAJmoCAAAqK4A==
Date: Thu, 12 Sep 2024 18:51:40 +0000
Message-ID:
 <PH8PR11MB79651E0A10963CD805666D9295642@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <100f9c30-f6cc-4995-a6e9-2856dd3a029f@lunn.ch>
In-Reply-To: <100f9c30-f6cc-4995-a6e9-2856dd3a029f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|PH7PR11MB6883:EE_
x-ms-office365-filtering-correlation-id: f0f6d4cc-7602-4e69-7552-08dcd35bf042
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qWPO2Ue2FPdhiyiG6MRYgN6zHL6mmCXk14JjPfk3w1JTVvGmcmAvP7ZXBVdq?=
 =?us-ascii?Q?3owlSI/Wk7p8DNw+DLwEGxeCeruKL9HemlX0zA3feLoRQXZwpffp5qGCW5FG?=
 =?us-ascii?Q?JxXKqCRK4EvvpdCpnRn8SHm+vnwOsM2n5oyjPOnQJzDJYiunp/tBrAnwjz0F?=
 =?us-ascii?Q?IYQ56UUqaVXNwA1gqOj9FBnJIWwF4WVOrUXxRdd4HPQ5ODFn+7kprbGcj1U+?=
 =?us-ascii?Q?OK97iZOB1C1KrPORR9cKW56+bGH4BAfMfvLRXhoodG64owjip/iQvcTGN+88?=
 =?us-ascii?Q?Sl02owHWmMvO4kNWmC1BYsIL/do5PIpikCB/IouNADyl/kGUnZmlL8/Th8ub?=
 =?us-ascii?Q?aSkU3HuIma277UivRO2QjZ6Ckg/DpQQDiFnmTHZCFAiCKs6OKiILpM8SMVKt?=
 =?us-ascii?Q?Cz0GxtK4IId7r4HwIR1K/Pm4b063z2t4dlmomaGY/WVIqxdQv/0VlbCYpsyl?=
 =?us-ascii?Q?fovXBZxdW8hwzbEL3vgSnXRWK6t5TXHLVw0Bn0UNwqTaS2oF///JPZSWdZ4n?=
 =?us-ascii?Q?bVsfStZbii+jfXQzMb8QDxZEEeEyHHHV5VCh4fmmMceZgrRQi+xB07g3etyf?=
 =?us-ascii?Q?CuoXVjeTTY9k+lAz75mJJEPLca5sT7ijIjTAYvWD7rCOIceTLCBfsnwMlXKp?=
 =?us-ascii?Q?QZurNTW77FwAKnIJ5oyBLq7WSU8PGQZBHMa/x0BqlUPow2SSkUzkLrY8l2gG?=
 =?us-ascii?Q?NWJKyC5B3MS/R1Z24kqkvllag6SVPbcjqukhXoClKRA5R0NVKyOCxYSSGdHI?=
 =?us-ascii?Q?gLhmLaTyHWUht0x+5VUomo2Op5fl9iTMWdolcSr32HxcFOHlO9cevuCW0fPd?=
 =?us-ascii?Q?d4L0feAhGPc6aELrDncXo/V2EsR1BQO4EBdtmxZucJQuo2pN1947DsgvgnEL?=
 =?us-ascii?Q?L7UUNpt5sjkiNuPrSIqCV+GfU/gvsG0Bz6ospa3Z3EyeG4FwjUsIH1ZjL0Xb?=
 =?us-ascii?Q?wLjovwjgdSFTGFgTCPqhgcjtnQRJwLocf+Z4ZCrqFij72kWawxbnc1umng0Q?=
 =?us-ascii?Q?Hq7YtSoVeuSKJNUh+Bi0whlWyT+vkZv3Hq0XfVtgyHNFK2qz5wsuiCZymW3H?=
 =?us-ascii?Q?7SBK/V5j6+5+GtWbc0GMtp6EX5962mfitxSpIUaaQRKNAdM51QNcXRnFtabG?=
 =?us-ascii?Q?plYxfrwWnTVAyfCubuR57HxwwhmDOS0IwVlaAehkRko1P67om3VxKtHpEdWK?=
 =?us-ascii?Q?f//l/D7O40Hb8cz0XEEO5Kw3u7CrVWBfevDpG6Xg9ebhEFI4I2l6OXCRVRy9?=
 =?us-ascii?Q?/dyMuDIIB9RV+NjUFh/p9PkedwLZ65h0R7jnuVG9sX4JgHmaKYJY7fNk5EdS?=
 =?us-ascii?Q?NZ66whnA5pjnzRpSeDEgmXfASDZ1/9D2tNrLVrh+TYINHAvWe99ZgYgMewHF?=
 =?us-ascii?Q?fAm1L9HNOkCGK4FC4nnnvue09o/lRc8fk0Kxdk7Id4wvgR1ftg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QCT3R9U53ehmWukyNyC1AB0fFNP7pjyvHrN+81+cLEqA1ZsPvXdOpAmT4Eku?=
 =?us-ascii?Q?8FaLdZN2FAxJadJQjt8NzaJ6HfdFBYa5UZ0s3s65SJHCrnJtlQ4mJeXlIGcw?=
 =?us-ascii?Q?MsftsGIDljtxKRN1pHWzpx8p1QE0ZmCOJpCwOOgc4YdlsXw7cLn46e28xRyl?=
 =?us-ascii?Q?5wB0XinG93lzRet/GuBgMzYb6YdQ+eO56PjrumrVRR3cyZayw8QTcij6jN3W?=
 =?us-ascii?Q?0m8waMbQkq283nZ6nUbIgf6tQDosfsc3DmnXFtUmRfrACofNVMl1pem92NZj?=
 =?us-ascii?Q?c/yjA9cycm78SzNlR34Jx9wcoPTVp5x7WxTuARRXiWsVInSZiq3GujgCXuq7?=
 =?us-ascii?Q?QBob0uk0oRdKpLD4hKnmnXbtOVz6NX6LKOzHFhqyebvUXNxTbu0GwwD+K5A1?=
 =?us-ascii?Q?luPpA1YoQvYHbKNhA2v9vFVfKF4Gacu/rtEnF5Qk6JPNM5gNED4VNLQ5D+8s?=
 =?us-ascii?Q?pXfS0D+SDA3UsflvnFzV0EiJp2rWRr/L/Y6eAYQzQgiebmd01UeZh/8nnGq3?=
 =?us-ascii?Q?xbll2h294nA476zTWwo8MeC+iRX7p5Zt9STb1L5BR75ZJwroFM5/JwM3ramu?=
 =?us-ascii?Q?pj5CB7VQ+/1cpSki0LjwAW4uBdZVPolLG0jcjX3/h2QBdXCUQqMm0uRuM1lU?=
 =?us-ascii?Q?5vYumfOCN2evWxivVmWUbYAasI2h18rROPFw6k83p0kFSLp0n4lHH7p7WxNK?=
 =?us-ascii?Q?lR47mwPop1qcRkIrS14u8q+9o3QLSBgDvI0cKnB3IV8M9nXKYyXGuwRkGLHL?=
 =?us-ascii?Q?9DP2cNjE9WplEHff6It6enX/6J7jSKm6odktDTp3QgLoX/ZsW9SrGO2PgFIW?=
 =?us-ascii?Q?e3i2fiQxkT3oXgUSp141+hHUqcbdlMv1AsQ9EI9rdo8B+et2Hge9bbpSxXvC?=
 =?us-ascii?Q?cO7Gj8xnwvyi8GRnGdCcWimMGv4aKHetlH55Ril0t5T7Ais2qDInNj+WXsvA?=
 =?us-ascii?Q?MKqYTfx+G1lDmHjPn+SS6y/Bugik6f9RGA+s66x1Jr036JVQlPKYWDpXuZwj?=
 =?us-ascii?Q?0XE0XektL9cLw0ywIgZv2LG3ybZmHIkeJ9WOvkZAcw4icztHrls6uVPPd/vO?=
 =?us-ascii?Q?CJcvrKPcT/CIKSBdsJs6yy3VnAEcshN/1AKoo++rCVPvqWbfviXBZnsiuHvF?=
 =?us-ascii?Q?DRy6vfTCgsPnKsLupelLzVDejGNky/GWolwTuavrZkY+mrfYWLxncKjX4yDx?=
 =?us-ascii?Q?8qa/X1PgBbiWhHthp6emtH28q0L9EiV2ypL0GwilcWOTMNirt8Nt12h1KdSV?=
 =?us-ascii?Q?C4lUEeQ7k3DCn9NknfLlgaLo1X3QODuNvpewx3TVGDpeXG+5EkRv5fXVupRn?=
 =?us-ascii?Q?MfoCKibX9e0rNT+Pvt7VOjkScVOVIuEdssAXUt7Bzb/lIdnzCXr2QbcIEm2f?=
 =?us-ascii?Q?hxD36iD8ogdz6DcfXZUAUfwyoW5Ah8kh/vPa1wYYxlo4pzXmF7N/WI00kxXF?=
 =?us-ascii?Q?1gND0rYhiLeUYd0MsZRnAfUjbB3NxpFZfEebzms5p5oZ2OaOuXXVLxQnEBO+?=
 =?us-ascii?Q?bORshlxAL2L+pVtQd2yy7XqHw13ME5Z5FNxz3SscEplu1fVr9+fFaTqv7qnX?=
 =?us-ascii?Q?YpiKF1mQIRG4NhoFCjKeAGToDg/1Ocavs4ZSq/ti?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f6d4cc-7602-4e69-7552-08dcd35bf042
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 18:51:40.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h486QVrGtE+8DbrilVqsSuweryPA8kd5dtgU7M7JwnIJ8hTEDVIfuRBY25xHvf2TB2iVOJawAMJtZCj+QdZGfQr6nooVigCU0A8/9u+Xwzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, September 12, 2024 12:13 PM
> To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
> Cc: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>; netdev@vger.k=
ernel.org;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.=
com; Bryan
> Whitehead - C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; maxime.chevallier@=
bootlin.com;
> rdunlap@infradead.org; Steen Hegelund - M31857 <Steen.Hegelund@microchip.=
com>; Daniel Machon -
> M70577 <Daniel.Machon@microchip.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > Our PCI11x1x hardware has a single MDIO controller that gets used
> > regardless of whether the chip interface is set to RGMII or to
> > SGMII/BASE-X.
>=20
> That would be the external MDIO bus.
>=20
> But where is the PCS connected?

For SGMII/BASE-X support the PCI11010 uses Synopsys IP which is all interna=
l to the device. The registers of this Synopsys block are accessible indire=
ctly using a couple of registers (called SGMII_ACCESS and SGMII_DATA) that =
are mapped into the PCI11010 PCIe BAR.

>=20
> > When we are using an SFP, the MDIO lines from our controller are not
> > used / connected at all to the SFP.
>=20
> Correct. The SFP cage does not have MDIO pins. There are two commonly use=
d protocols for MDIO over
> I2C, which phylink supports. The MAC driver is not involved. All it needs=
 to report to phylink is when the
> PCS transitions up/down.
>=20
>     Andrew

