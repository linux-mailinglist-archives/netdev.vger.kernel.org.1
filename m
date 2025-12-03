Return-Path: <netdev+bounces-243358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28CC9DCD4
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 06:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE233A1D7D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A472882D7;
	Wed,  3 Dec 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="POYci4yi"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022127.outbound.protection.outlook.com [52.101.126.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D732874E4;
	Wed,  3 Dec 2025 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764739809; cv=fail; b=hhSA0d+vzE8rhUtN6fhV28JAsgzvb2hpmAUC5vypYXFAUoKIIjt1Ymq7r6qk0Ywf5aSyrojZghlJNFucwi1DXD6RDJpN5jGbxtFjcYR/IJzII3vTkTYWCOUe7N8pVYgj7+sM9nKe4/GIA332Uka3NCt69t/Ely6/xsWwI7tWhSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764739809; c=relaxed/simple;
	bh=Gn2H98/zokZHbs7bduBwb6CosAnMTh6U7UL4EzlDSnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYWLZT1lF498o6q8DZwgcLcHosTfByoQI2azHJpPDtguLXh1YbTsjsYQtjk4CZ1LZFZ6t9pan79S/9gpyoMZQlZ94FkY65RJ1rSVYHm1NcLxqgbidcCEsYIoIxyoNJVPFtm2Gmq46gyDaz1ucLbtBGtnTxXU91Igd78eNOCyjo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=POYci4yi; arc=fail smtp.client-ip=52.101.126.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFIYP6dyunnNWsqPxCGkLm+EsB3J1YwQCH9MkALTyKXlrSz5kKuQFk8188AuvOf8/slGVoVRDBJsJIKWS1/V0HnM+IMp00SwR2E2h/cy9jZcmzT7FwDjsZREoqHPwMo3GgO0msnCSh4IEzkmwJ6Xuoy8aGuQTjHYOdoSiweQE+6VKESTNhicpz/YIFgoDmRYbikDTF+NQQyYVufrCnyP6Dxj8B2+rE2EbWQqfkDBi1gq5n/sIk7V/WP6vFYtNPQT7GMspiX2oKO51huoZgrEEgTnwS0uTpZRzFk7nLGykCqhIc2Ade32oQqlZOixmN9rUFTW/h1fX7PeDD/QoCGJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn2H98/zokZHbs7bduBwb6CosAnMTh6U7UL4EzlDSnU=;
 b=Xk0FkZpP8YDXYxuNO6wcHsjr7Je5Wq/75bU7YGweTEHrBD2NoBLAOFb8v73sYDJ7ys4biHB2bJx/8ZAp3OWzeQmAfIKyLvRCDZTL9kmKm/5oRH7SRvw9K3fHoyqrXdBkSLlGg9W3yPxFdabdAslP93sTLuDVVNdZLkFW4rlurItQuulUFGDmJAkvGXRJE5ctMmzx7gqkl5orfNZdlSoZVxtf71A2yR6YZk7+0i2DvJnjjqMtix26NcDveOuCi+YpnadMFs6ujCMDTcym6tkf5dYfmhno73drS2Gi2ESX/NEpucuA6Qi2pA2BJvYTmnlX35ONViL9mLQCaEsMwkWCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn2H98/zokZHbs7bduBwb6CosAnMTh6U7UL4EzlDSnU=;
 b=POYci4yiFIdFmIUZVam7DisNDdBPdILsGTfMlBa/VgBKZdZjPCF+cDTn8xmviKpFeUr23iTLBC86DDJiNU2q5gGIESLIOqdc5A4G2YVvsOl84FvHpE9BtYfPRGKd62zphk++CVMHzr8X+pCc/w5TuC6VpUVnAKblaDJzSml6n77IhJWMnLntgDTxJgB/+8J7KaUUnkLHoWcwk9vaEcDYSTbkvjtanzVUJQbnHGbnopZYhqZRpMHm5D/bBgKm2zYJtOCSBtnjo70t4dXuj3uOVMcmqLFl5FEPiZBuSimf0roBGbhD6emEWOG02ZTiUO7bSstf3mWZ5TAbT3um/wLEtA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6737.apcprd06.prod.outlook.com (2603:1096:990:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 05:30:02 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 05:30:02 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Tao Ren <rentao.bupt@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index:
 AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpCAAKBqgIABWbLAgAPq3QCADnQYkIABZcyAgACY8gCAAYfhoIAHwL3AgABzRoCAAQkkcA==
Date: Wed, 3 Dec 2025 05:30:01 +0000
Message-ID:
 <SEYPR06MB51347C9924E32731478BBDAB9DD9A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <1c2ace4e-f3bb-4efa-a621-53c3711f46cb@lunn.ch> <aSbA8i5S36GeryXc@fedora>
 <SEYPR06MB513424DDB2D32ADB9C30B5119DDFA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <SEYPR06MB5134A5D1603F39E6025629A19DD8A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <4f0e4aa0-166d-4a7f-b91e-42dbc6b832e5@lunn.ch>
In-Reply-To: <4f0e4aa0-166d-4a7f-b91e-42dbc6b832e5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6737:EE_
x-ms-office365-filtering-correlation-id: 2fc3cb4f-dc5b-4d67-f2d3-08de322d01ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z/SZq5GdzalR6YF0A1UASsq3gqU4FiBzZwcp+mP7romUbRQ6Zn/FZoE3qmAz?=
 =?us-ascii?Q?0mbMtNzPE6Zy/HiQcHn1AGsqU46FPJ13tK2antQQ7txIfssAwLB/FJbuoE6d?=
 =?us-ascii?Q?RonLxUAx9FiITqpi0MtZfUfmd0Km+M1Ok/KseIz/XPnXyXEjKoxgo5JXDouY?=
 =?us-ascii?Q?xwBVODOZQw/CTy1Vb831dxHemwXIhbltXroI8SBufYa/x+BbNGD3FuuQIiL0?=
 =?us-ascii?Q?g6F0AomsxWhczXEsM7TtdpD0MGH+OY/UCA7zRRfZVuH5PpV4+1QpaKyqIy5k?=
 =?us-ascii?Q?CYgNt5Dgo+4ZW5BBazRA2iaStYHiNRruq8OT24dznu/fcKkdtaLuBHEeioCv?=
 =?us-ascii?Q?frmoGbDHzyi5meA3XB2QCGpE8mdtCeNs42rzWtHmK1D9YC52AyZcKNrGiYLZ?=
 =?us-ascii?Q?Rv01By581a0IKenmadv/0Yhj55PcGxMjI5uDvjKAfh5/Oa7CMFvQhIAdhw6v?=
 =?us-ascii?Q?kaZdSPxX3OyXjf0UL8bJs/vNjgP8HStarydbHOyI6nPV8+JAvSVYt2WPRb9o?=
 =?us-ascii?Q?ebHPM0iWsiYs9rVjR1KnruotA80N8NRwWl5LTSamrOUh/lQ2Dj7e0YSpNE5s?=
 =?us-ascii?Q?/kejVYBRyjGgt71JaHOPOLpVfsOgyGlYpJ3FaOaOJ/M1keTlbxkG65z8ayfJ?=
 =?us-ascii?Q?IT2AbBEMDpVLttoDzPVsEwcGC335AOa2TqPU5BuydtJuJAvnRAQ7DbdoX9sf?=
 =?us-ascii?Q?7xKGgVH7yl7Y/aaQdOBShw8RK8BDrz7xRYdaN1tgmYWOwZVQAZMswVdaZMO3?=
 =?us-ascii?Q?x70keKX5Z85KLA5mbNZYA0Q/JMsFsM6w2B5jy4usq3xH3dBOJV+afrF7N+V1?=
 =?us-ascii?Q?LqC5wZ3tD6mmrkr/4XtrxS/0Tw/ksbqsd+0WMxXIo01Md9E6KMHkG3Hv2S7b?=
 =?us-ascii?Q?Wl1vST/pEXj2+6X/9/uggT0142jeBW/+YEoHDa+F2nyO1pz/TqctwZ5fZT1c?=
 =?us-ascii?Q?bolbZeQosPTXKnW1f5x31lIjVIrV0328LF2qSdFu527ypFywiSyUjvv5FNYA?=
 =?us-ascii?Q?ESfrMb5wqxTwGXjbF719zzsdhyNysdMSqJ/mBny6pW/RvJNbRpbXE+tlV0sM?=
 =?us-ascii?Q?l66k8IS5NgH4T8lmhyBotM4oHGDLEWg+hNBOIDdcXRVNTYU7HgpB6sdsi8uM?=
 =?us-ascii?Q?Ze6czYaNvYn4gUFmYQXsY2LMR7x9eGiruiFm2qxFroawkP3ln8VDNs/ug8Xi?=
 =?us-ascii?Q?kAAbgrHdaGvnTRYqs0eSKAS/kg7LmUuOXBr1TnKAnwW4jlMmmV9B0uPBXNbg?=
 =?us-ascii?Q?E0ViAC1hJ1TXfuY5Q2w7taRQTNEE5KQ+ZYm7TdiCYa3UA4V1vqub3YnhoOYZ?=
 =?us-ascii?Q?/X6tMrLq+rw+nVX2vNx/cZ+nl5IaGsE4p55/e8Me9dr3CZpR9sCz6c5/jOc6?=
 =?us-ascii?Q?6J1m704Fn6R0EPhSJbGkA3yHZ7Cen/xoj0UidvLWoYo93uvsrGsa1CwaG79r?=
 =?us-ascii?Q?BWVGrwW3/QOwmh6/ZOFPQadb+bZK/vS+mTYi+PZyGAFW01opMMvhaZmqQcpT?=
 =?us-ascii?Q?//z8zMzKGj2ohC5EXlPqZHq9mas9+oqwF76Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FdjK46irx7VjpFL8bGTkUK62p5ejrsWonaWibigEFKzq7FQe53a9icpyfyAt?=
 =?us-ascii?Q?eNmEiS7N185TxvTs0T40yUbqoE/fiISWbwqPVTnrajqqyHRk8LPH5RMr21qk?=
 =?us-ascii?Q?6LWcon7gtFX4RzT/We5X+/BOpE3uA/YCe998kfVYQgDJCuxYVyIDQjHhnCXQ?=
 =?us-ascii?Q?EFvsN1sLrxrVvAWSbQQynqyNZMILMuQ8dVnPnWRFeFqAqnLda/kjTe7KLwru?=
 =?us-ascii?Q?ZO+AB9RrSRexeXQzEicNIeYOMMlKBVW90iRwTeaPHrtGEdDhfD+g8dWGd8Eu?=
 =?us-ascii?Q?g0LJf+UFbeK9d6xn8Op6b5sB1ZU5uadbpcxYVYJgLgdslLq4eK/e2JFdiOGC?=
 =?us-ascii?Q?BQQwftjzGaoTjf+5o0MNIk5DC7u8Phrc4An79wdvRpUOuzKfL3JOMCGe8lWP?=
 =?us-ascii?Q?sEgQwVQwH4TuN7LedNEMM56xeBNOxckxs87G/UsaMYgJWrzvfNbHgfJbcs4u?=
 =?us-ascii?Q?Ft+SUZN+Fvj9z1kx1V1EBJouEHekewFTNowLkJA4CJMWHp2tbye4yaMoZq3o?=
 =?us-ascii?Q?1nyMxKXmjwxbTsMcTrFhMWaN9KLb3370oROyLLci+780E8loLAICZd+V4vqw?=
 =?us-ascii?Q?7RXoumLNN3LHpmcsQ2xu1iFVes+dXoaTOVXxIRSyJL63EeQIhXFi9OSmGuhL?=
 =?us-ascii?Q?FXvj4nVhNC7gZNPMd5TtUWdG8hzFlo1Ou+3ejGQX3FQz8VWR0o3hecGjrP1a?=
 =?us-ascii?Q?vK3rrC4xzT4spK3+7fa3w7kbvDOSnNsaj8vBLLbU0PaFIOueRSacEewYW/2V?=
 =?us-ascii?Q?fciagrGZycoBokc9Pc+E9DkgSN7rnmblbqboS3s728JjugGzflOPpy+eeu60?=
 =?us-ascii?Q?FefWXJLOvGehoTvoSwbGQouSpv1rAo10v6tvpPISe1CFOC0m5wNV35mu2g5U?=
 =?us-ascii?Q?OGkCf6P1i3ZCy4Tk6exXofkNbKguMHjtec0rDpj90C0rDSdH7298SnSSkfCn?=
 =?us-ascii?Q?fn3vNHa8vq4EaPgyztHgj1Hc3hJq3k+VEDKAAkQ2z0iYCSGlE9+eV6gBUmsd?=
 =?us-ascii?Q?IGyLIB9Cb4/bJlkvtHFyNo8zEjX3TuGypmlEFOz7n2GdKpXSt8IGiMC+JSC8?=
 =?us-ascii?Q?gMy9Q0cQZ2aAGo7dtVb0kjua8nlt/8ULuO+4XeO4CyRHuZPDFBEErXmjM5Kp?=
 =?us-ascii?Q?tdTtQDA/9HUMdtX8XmCjnvGpqqp92RPOBKMMYtCFFuFtZSJOAL09WpPVheaG?=
 =?us-ascii?Q?mL025alXNXLfFgFkZ5LmMYn/WLRR6gtrPOaeM7DWPYCpojXd6iGABUFgsrwd?=
 =?us-ascii?Q?DMnF1JEc9b3gOc7B3SiH1OEURrBNeH8OUzxibNgKFQaGMUniO6PZix0+hEcL?=
 =?us-ascii?Q?EAcA9kla9bmFHACl6Jpxc9f6aQcExoZP6yJUrhUe3wcWFqlBlUzqDeTGPdL0?=
 =?us-ascii?Q?f2/3WzTo0N/f65PT/nOINahTJjOVt/Jzd07PAZiC3j0LXx3X/Nv2gJveBP06?=
 =?us-ascii?Q?sLiYYp4NLmp/ny6R1ikzFCyv19SdqnphIc6Sis5SIidtnoEuwTk6K7sHiD3C?=
 =?us-ascii?Q?GYWaBky3wU1UCc07FAPwqOsu7cBvGixRZI253n6WJmMiO3kHGODP1sgQHgha?=
 =?us-ascii?Q?fDJlToDq1Je9aVNV6MOz36Rvr5ScyI28wyOCvcF+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc3cb4f-dc5b-4d67-f2d3-08de322d01ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 05:30:01.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5+9jvGVf3+K4cXTRYUs/H05xGqFTXgUuM2s80Q0/0LRvYVg0/F3alMTROc4jE1NPzoIuyQ7HfaV/PZBvuozh0wtthpIBSMKsaidEOMCkvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6737

> > I miss one condition is using fixed-link property.
> > In ftgmac100, there are RGMII, NC-SI and fixed-link property.
> > On RGMII, we have solution on dedicated PHY, but there is an issue on
> > fixed-link property.
> >
> > Example on dedicated PHY.
> > The driver can pass the "rgmii-id" to tell PHY driver to enable the
> > internal delay on PHY side. Therefore, we can force to disable RGMII de=
lay on
> MAC side.
> > But there is not any driver when using fixed-link property, which
> > means no body can tell the outside device, like switch or MAC-to-MAC,
> > to enable the internal delay on them. Also mean the phy-mode in fixed-l=
ink
> case is not used.
> >
> > Therefore, could we ignore the RGMII delay on MAC side when the
> > ftgmac100 driver gets the fixed-link property? Just keep the original d=
elay
> value?
>=20
> MAC to MAC is one of the edge cases where phy-mode is not great. What is
> generally accepted it to use rx-internal-delay-ps and tx-internal-delay-p=
s with
> 2ns and a comment explaining it is a MAC to MAC link, with this MAC addin=
g
> the delays.
>=20
> I suggest you see how messy it is to implement this for 2600. If the code=
 looks
> horrible, keep the bootloader delays. For 2700 you have a clean slate, yo=
u can
> implement all this correctly from the start.
>=20

Thank you for your suggestion.
We will discuss internally how to implement for these cases and prepare in =
next
version.

Thanks,
Jacky


