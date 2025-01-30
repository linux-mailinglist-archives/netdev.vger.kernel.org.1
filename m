Return-Path: <netdev+bounces-161595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18CA2284E
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 05:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FC61887130
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858A3B19A;
	Thu, 30 Jan 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YuSUnHy0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0608831;
	Thu, 30 Jan 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738212620; cv=fail; b=RdHu8e04/bGKGZlnXvhO1qO/Y4YEwmaVrjX+lFVLW4lRbQPQ03uAYAZu1KDXlbKoeOSgv1VX3m+C38SJ+7hdjwW7gwSjY4Wgl1kBVqQp3L1wOOQn6UmaZjD6YtYcPvzSGJ4Eo/8MTON67JKhsywouMjpOdc79gLVi+ms9AUWj/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738212620; c=relaxed/simple;
	bh=/gS5i28XrPiSbNBPL50zPNuLCnSs1wcZfV53dek3UPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBdNBwUR5Q1gh4aDxPw2+OJ44E/bXGCiOR3OQnNt12XpqCSc9fTLsZOjoDbm+xoyNsxpk4fJ2xMT1Bq3MBt66kSeW64jDt9zJWZUzpNI0CCTFPh5F4wJ0F3xDvIF00E2xdxCnl5kRi+MD4o+5LcO6DvY/DPAUGjTO6RWbZA1lJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YuSUnHy0; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR4mtumq2JCvMW1I/q4iSf23HWso+PTl/OVoDXvZAj43g5HKfAJIq+F7UHKjhRuo9ab9zI7UzeRDVy7ui9bq571fuhC1TkUwJe0glzWP42aQPFCxqwxiTRsAs1xD4TEZcW1WVz9XN/tXlf9tXcDRHn/NgfO3eYH/fDmgzY1WBkoxNaZCpNMm5e1VLRr83fx4fSA6RK4TQiapaGHm6ouzAfWIRnf0haBSMT6Utv+cjZ4mWbkGLRaV9SkGVziQ9YGbwDfS2cTVKwQfqdmQI0Er9FDtnCz1Cm7ErEKKf1O4jhw2vii+Q0g+WcnoL2p4JvGLAOs6ucpRphfw4kGSNYuxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEvquV1D5BgdGugL/hCOLb0m4VseKr3ywjMkeFRWAE=;
 b=raPx7SlBp0AnuFutkfMmpfjqb0iqnF9h/Q8o6tXtL5Y7Z7mqKAoWlgNX3VPSZrcG1ENJVhYOGMtueTXkQZRSx3VqiXRoSVpDTlnUqHsxGzeTubZxOsEmuop/l/ygwta3VsAGlw7RK8J9a1jON7wAK5SBM5Z8L3iO1NdJkbrUKf8UK6AK+TWnlsrDdcl5lh2RuR7qZ2NqcGqXj0N+IRxkiQllqnPmT4KFV9nmD0TP53WuMb6Lop4Jb2FfqfFFBcqWYeGWW3v9NVEulRnvdDDO0fjRLYMazMmsEoxdnRW9aqclv+vhsFFPMZVW2X7oUCBU/tq413AUBxSyp2Dkwo9q1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEEvquV1D5BgdGugL/hCOLb0m4VseKr3ywjMkeFRWAE=;
 b=YuSUnHy0PSzqGogEc5nibPEqr3MPbKoQg4bvt/tMWxJW8yyS0fQC/anwscRXpcbIdK0bQfc4SVoSO5nI96YgimhJ5H7l3U/3rZ0Dt7wBdW5GYz20CzxBTGAXgh808b8Qov/+qDQ+F8XyMSx2qSo212M8F8kEijhvQvevGaBjwtwHRJ6OEbmLSdUaNCJXt3LpAlbaGRPE33Cexi2ORJVHP+8So/SPuFKYX4KrM2vw9ffsVgIkPgSnX6CxhQNJN67gKNxN5HgozyDqHYg+u5UyNlYMtAgS2J27g4Vjmqgd5Q6CITRzEqUpVXRTIRxhQ7y+A3I6Ytmp+YI7fVyEbqJ2SA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 04:50:14 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 04:50:14 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Topic: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAAa21w
Date: Thu, 30 Jan 2025 04:50:14 +0000
Message-ID:
 <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
In-Reply-To: <20250129211226.cfrhv4nn3jomooxc@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: 81739411-cc61-42e5-fb54-08dd40e995df
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DkWcr46Whsm7q4FIxAVPrnnwp9bZ0AIgl/cuKTrwjU+p79G4BFR9/2PRwJmK?=
 =?us-ascii?Q?8xRG8wmWdVGdB5ycN+7Eu4hm1ZT2sgAxWvprpu5ClQXIXaE3g7PRmWA4v+ya?=
 =?us-ascii?Q?jZrvEPPqBZn8wOWKfOgO3+l5qPTo3Ag58WoSE/hXtGDj9OPWAOkIW48u7gss?=
 =?us-ascii?Q?KvS1YWIiNSK4WkcOcBHlrBGxEH2dYhjajp4dPXPQw3oHg7utOfSiuGOiqJ+6?=
 =?us-ascii?Q?HdNEBsqensy2ksdzexpjKqS1t6wwhFg+mzzHWNW6bA75RBU6kQXZ2u8djdMG?=
 =?us-ascii?Q?xSpvjCqnD5iofxyioVSQqw2CKWcK37gnwRRpovquibTZRLrp7Dx3pSx0BXeY?=
 =?us-ascii?Q?RuNJv/IUInOI4yjbQi83ockTkSGi5QIhTTnJ/9T/lebPsi59YHST+VgptL3g?=
 =?us-ascii?Q?ye8K4dbmiuRuPwcm4q7I72PDKxOWdvPdbKzebx3pOOHX8/6pm60+gHRciHMz?=
 =?us-ascii?Q?Vr3Zi91XJwRLHKEGYdCdimf4HhDihgNLqKCLWSfkgcdW2Q4E0wObUSO9jrlr?=
 =?us-ascii?Q?9dZDfC4Ag/GA25+oW2KcrLTiJUICRN099Ns3nAGroN4HOv6Ri8ChP8x7riFR?=
 =?us-ascii?Q?/WjuXDkAsRJXwy6I49R7ScPxXFzXcgyAGxyDVFIUHGdgmgmm64+0vIj0TM6Y?=
 =?us-ascii?Q?iApKd34dUycDiV6x0gYZiHfLiwoHJQqSiUcfGG8y1Mg3G4E0uSyhwqmfmF4U?=
 =?us-ascii?Q?H9y6NEizVFkz1ZF+/dG9vD9jbMfQKClKpzzaJJFw1XoUUu+GKUk1GjIObBRj?=
 =?us-ascii?Q?Gw5jLEInisWgIAshkwkxx2fBdPpRmjdeTH/Q9fAwejg1BxYyXApc9aRFHaps?=
 =?us-ascii?Q?2zic0wY2/OINCWWv8PhpCVOAp1RTAIIfm8CzvPtVXqQr7OQ17gGQQIrzJwn+?=
 =?us-ascii?Q?2Nt5lcqUYqw644niOT5CiqOlq5hkIKTitfckmDbfAYL8syeQpqszmDmcQj8Q?=
 =?us-ascii?Q?jkMKbYHBR9I/uKerdwZj0/Xhm7pfkSeFcM71bS4bN5rjrcwbtdCNTBCEfI7G?=
 =?us-ascii?Q?ZLqXXOHLRc8nk8NbU6KMl8ouSncokenhIHPqbZ5qa/1cTBRdoulc1hasWVvc?=
 =?us-ascii?Q?W20Bq50kT2dB9LLpLfFobhx9AvLmz6JZxbHycTAGwxhhUtNDomryTlIljIl0?=
 =?us-ascii?Q?iu3H55UqvP/Z71AO+1men19P4hx3vx5xXilt3vq99zZzr5jWEjXSZAGgWyM2?=
 =?us-ascii?Q?O4HrCI7qm0brGkC4P9cjg8NWUD/u1OI81yh9ULVZl0Wmu+HrSFtRB1BSZaqR?=
 =?us-ascii?Q?ndzODcLWUGrLwdVzOsgSJ8SCrUX1CosyUFmue8JkbhGePTyc6X5q0CDtZa1y?=
 =?us-ascii?Q?TvBwIvRqmFeWSqoPHYlgFVXQtoK8sB2T4pqo2J/bDgemt5uaupf1aJsRLAnn?=
 =?us-ascii?Q?LzBWXX6vSbdl+7xuMHnl2Mwnzbuz4psZlL85eK4nJN9wRxrmBKW52Qf/zjD0?=
 =?us-ascii?Q?DojJhSzxv+vQgr/GeV6YMPWIk2WMH+Wn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CU7JsthdxsBt62a4BoUb4xeza1yGha39vpURcjxW690FZIFsdsvN9xjV6XdL?=
 =?us-ascii?Q?2bkreDywW715+FT80I1CoCQu8L6rIDVIZ4SD6Cgzu2k8U05cDdwSpbYXOF1J?=
 =?us-ascii?Q?t4MxZKE/yIof8Y+Nbexz5j3RwVzFhqwSmaxcYiPX1ydmWz8oyg4jULZNY7fm?=
 =?us-ascii?Q?H/7eBXyAwwYE4ynWAcEG5moaI6yaUbO5zGT63HrtuV1k5lU7IWrsvCkgxMIV?=
 =?us-ascii?Q?/bb4YaG/EeykNlhtveG0v3wL2s7YUD5NeaW3OQs5kxYmVbaUE7fJfW2+I4/q?=
 =?us-ascii?Q?NnwrL/vIB48LwmSTmnBANQcjXxx6sZFpczHZqG37zvTShzfStJq4bDTc59zf?=
 =?us-ascii?Q?OOXRPNKY5yYj6ITAVhddbNEZwmssUgo+eu52Q3OtM7dTwV5MiNfqV22G3Ogp?=
 =?us-ascii?Q?NHV0ZYQxXQXvhMYIe0TFhzqBm0AEqi+2TWGGfniuKAqPL6sWlVnDouK3O4hF?=
 =?us-ascii?Q?nNEvtaC1hBf4EKsSyEgLNDLmPWzpo5ZN//q5rOoReJmPeVqcvvDGoLGji02s?=
 =?us-ascii?Q?FxC+oD2H3Jtvu3kPN3zeYKbHTk5ZGWYzANA11K1owybGbcB7DkwrLRnLYVKg?=
 =?us-ascii?Q?0gUMj55tTOm9Ku1Uxyt2ojLE+KpeJi7l44TgXtB8z1OUCnYEYiS6yR5ThdRW?=
 =?us-ascii?Q?z3OtR4VcCOq8gZ23axs6T6WSaCLti3usNz/mEuZcSlcpnIMih9+u7oEw+jAV?=
 =?us-ascii?Q?M7sF0fZSNEo5EUnSaV3yHH75WyOFRPdhKmZV+aBLO1hXGi62pDSfNU+WePLP?=
 =?us-ascii?Q?M/0gvNZBvlnzcRbAuVA77Hcvh8Y1OSm01a7bXdZLGiQMcMrVSO2HI85Y8wrw?=
 =?us-ascii?Q?v4yWyLplqLWsU4cWoJsAwvsp9ZnSi9LWzadgQ6U5eysm6eYuowG6x8iAduqk?=
 =?us-ascii?Q?ZkPYZhv1iW5h2KssRYb0MdVMcDMeoIV9gEo1s1GkWqDqpNQq7vfywwq65FEu?=
 =?us-ascii?Q?kha/3ZCXma+TRvRE6J+bSBqHgzIQmXA0ICcShOvhVRZRh0eP0t8t7HY8e4Jb?=
 =?us-ascii?Q?YiuWTfr75RKQwuneJ2usKJmVEBevqxXQdKzHiV/hJqr87j4rsjQmZBKJowek?=
 =?us-ascii?Q?xKnLtylscFcX595pOg1J7BSTtc52rwcPRdrVFNZurYfDrX5UFFjnI4WlItU9?=
 =?us-ascii?Q?R/U5ADHooQsepGPMFLroHOwBuwRnnB+XO5hyrVIYCYCkBX0i80WGGJaxVSix?=
 =?us-ascii?Q?dAsGpKIItHdSu6469eS0qEDlBtcxmJopKhVj/QitNQepN9UIuibYhmLBQftJ?=
 =?us-ascii?Q?2eT94V57H7+kFfKgyycyzgxYBzdK7yhZvd6rOeexVJsP4Wzd7db0QgDEy/gy?=
 =?us-ascii?Q?ekfgqqeAmzIzE9UM3WpZbtlwRn1bmAgck/Uzp/tQyexrp7z3n7/xoF99RILv?=
 =?us-ascii?Q?7L0QCGut8R+6AjB/JwjtAY8ouFudOcN8SYmO3oQmMgoBoxgxNDUsl0561pLe?=
 =?us-ascii?Q?u38N9AZGx1nJKYFtt8e6akqt+puef391EduIxV3P/y4UPuEs4tylP96OojCY?=
 =?us-ascii?Q?xVMciLXQvcNKniCfBA7PFQ6Gdp22kNZ4DTC8FAX50EfSdONRkCPPwA1g7tZ9?=
 =?us-ascii?Q?x5q4C2FpsDOwXqUNwcN6m5u7rLe36D5YRy02N9vj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81739411-cc61-42e5-fb54-08dd40e995df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 04:50:14.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bL0Bj/i+ELCvLqA5iM/xrrbNJL0ech2mO0fY31t+hszfvFbA2l7eDEJsrv/sX4IlJfQa74Jq05tH5qlcRccNxIpI4UTWBJWX3CoBFRcGNjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292

> On Wed, Jan 29, 2025 at 12:31:09AM +0000, Tristram.Ha@microchip.com wrote=
:
> > The default value of DW_VR_MII_AN_CTRL is DW_VR_MII_PCS_MODE_C37_SGMII
> > (0x04).  When a SGMII SFP is used the SGMII port works without any
> > programming.  So for example network communication can be done in U-Boo=
t
> > through the SGMII port.  When a 1000BaseX SFP is used that register nee=
ds
> > to be programmed (DW_VR_MII_SGMII_LINK_STS |
> > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII |
> DW_VR_MII_PCS_MODE_C37_1000BASEX)
> > (0x18) for it to work.
>=20
> Can it be that DW_VR_MII_PCS_MODE_C37_1000BASEX is the important setting
> when writing 0x18, and the rest is just irrelevant and bogus? If not,
> could you please explain what is the role of DW_VR_MII_SGMII_LINK_STS |
> DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII for 1000Base-X? The XPCS data book
> does not suggest they would be considered for 1000Base-X operation. Are
> you suggesting for KSZ9477 that is different? If so, please back that
> statement up.

As I mentioned before, the IP used in KSZ9477 is old and so may not match
the behavior in current DesignWare specifications.  I experimented with
different settings and observed these behaviors.

DW_VR_MII_DIG_CTRL1 has default value 0x2200.  Setting MAC_AUTO_SW (9)
has no effect as the value read back does not retain the bit.  Setting
PHY_MODE_CTRL (0) retains the bit but does not seem to have any effect
and it is not required for operation.  So we can ignore this register
for KSZ9477.

DW_VR_MII_AN_CTRL has default value 0x0004, which means C37_SGMII is
enabled.  Plugging in a 10/100/1000Base-T SFP will work without doing
anything.

Setting TX_CONFIG_PHY_SIDE_SGMII (3) requires auto-negotiation to be
disabled in MII_BMCR for the port to work.

SGMII_LINK_STS (4) depends on TX_CONFIG_PHY_SIDE_SGMII.  If that bit is
not set then this bit has no effect.  The result of setting this bit is
auto-negotiation can be enabled in MII_BMCR.

So C37_SGMII mode can still work with TX_CONFIG_PHY_SIDE_SGMII on and
auto-negotiation disabled.  But the problem is when the cable is
unplugged and plugged the port does not work as the module cannot detect
the link.  Enabling auto-negotiation and then disabling it will cause
the port to work again.

Now for 1000BaseX mode C37_1000BASEX is used and when auto-negotiation
is disabled the port works.  For the XPCS driver this can be done by
setting neg_mode to false at the beginning.  Problem is this flag can
only be set once at driver initialization.  When auto-negotiation is not
used then SFP using SGMII mode does not work properly.

So for 1000BaseX mode TX_CONFIG_PHY_SIDE_SGMII can be turned on and then
SGMII_LINK_STS allows auto-negotiation to be enabled all the time for
both SGMII and 1000BaseX modes to work.

C37_SGMII working:

Auto-negotiation enabled

Auto-negotiation disabled
TX_CONFIG_PHY_SIDE_SGMII on
(stop working after cable is unplugged and re-plugged)

C37_1000BASEX working:

Auto-negotiation disabled

Auto-negotiation disabled
TX_CONFIG_PHY_SIDE_SGMII on

Auto-negotiation enabled
TX_CONFIG_PHY_SIDE_SGMII on
SGMII_LINK_STS on

Note this behavior for 1000BaseX mode only occurs in KSZ9477, so we can
stop finding the reasons with current specs.

Microchip has another chip with newer IP version that does not have this
behavior for 1000BaseX mode.  That is, it does not require
auto-negotiation to be disabled for the port to work.  However, that chip
has major issues when using 2.5G mode so I do not know how reliable it is
when using 1G mode.

> > (DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII has to be used together with
> > DW_VR_MII_TX_CONFIG_MASK to mean 0x08.  Likewise for
> > DW_VR_MII_PCS_MODE_C37_SGMII and DW_VR_MII_PCS_MODE_MASK to mean
> 0x04.
> > It is a little difficult to just use those names to indicate the actual
> > value.)
> >
> > DW_VR_MII_DIG_CTRL1 is never touched.
> DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW
> > does not exist in KSZ9477 implementation.  As setting that bit does not
> > have any effect I did not do anything about it.
>=20
> Never touched by whom? xpcs_config_aneg_c37_sgmii() surely tries to
> touch it... Don't you think that the absence of this bit from the
> KSZ9477 implementation might have something to do with KSZ9477's unique
> need to force the link speed when in in-band mode?
>=20
> Here's a paragraph about this from the data book:
>=20
> DWC_xpcs supports automatic reconfiguration of SGMII speed/duplex mode
> based on the outcome of auto-negotiation. This feature can be enabled by
> programming bit[9] (MAC_AUTO_SW) of VR_MII_DIG_CTRL1 when operating in
> SGMII MAC mode. DWC_xpcs is initially configured in the speed/duplex
> mode as programmed in the SR_MII_CTRL. If MAC_AUTO_SW bit is enabled,
> DWC_xpcs automatically switches to the negotiated speed mode after the
> completion of CL37 Auto-negotiation. This eliminates the software
> overhead of reading CL37 AN SGMII Status from VR_MII_AN_INTR_STS and
> then programming SS13 and SS6 speed-selection bits of SR_MII_CTRL
> appropriately.
>=20
> > It does have the intended effect of separating SGMII and 1000BaseX mode=
s
> > in later versions.  And DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is used along
> > with it.  They are mutually exclusive.  For SGMII SFP
> > DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW is set; for 1000BaseX SFP
> > DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL is set.
>=20
> It's difficult for me to understand what you are trying to communicate he=
re.

The new chip has MAC_AUTO_SW bit in DIG_CTRL1 register and PHY_MODE_CTRL
is required to operate the port.  However I am not sure about the
MAC_AUTO_SW bit as it is not required for SGMII operation.  When it is on
PHY_MODE_CTRL becomes don't care and can be turned off.  It is primarily
used to detect the type of SFPs at the beginning.  Note this chip does
not use Linux so I cannot verify its function with the XPCS driver, but
the 2.5G code in that driver is so simple I wonder if it is complete.

One major difference is the 2G5_EN bit, which seems to be just to enable
2.5G mode, but it is not so in Microchip implementation as the bit means
2.5G mode is being used and so hardware needs to do something special to
manage the bandwidth.  This bit is not required to be turned off for 1G
mode.  There are other registers to set to change to 2.5G or 1G mode.
This is a little out of topic.

> > Note the evaluation board never has SFP cage logic so I never knew ther=
e
> > is a PHY inside the SGMII SFP.
>=20
> What kind of SFP cage logic does the evaluation board have?

The original KSZ9477 evaluation board never has this SFP cage logic and
during development we never used that to verify SGMII function.  There is
a way to detect which type of SFP is used so reading its EEPROM is never
required.  There may be exceptions.

Microchip had to build a new board to submit this DSA driver patch for
SGMII support.


