Return-Path: <netdev+bounces-131985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230C990165
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AFA1C202E2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97C15535B;
	Fri,  4 Oct 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qq7sLrMQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E226146017;
	Fri,  4 Oct 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037973; cv=fail; b=mgiyyTkfRUMDxeQ3j7Nw7dUuI5QcSLsA5N0PY/WOl1RF2kK5IVEULudIKNCaBDadGInRjaQoc/SOzTwVyMHmtdNieUzPq0GBqSEGw3K3+6bckO9ls+W6BQYSe17JZggsQimtbi8N0KfTYgHe3+svOAaMbi6N2NM5m+4QNHvU/dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037973; c=relaxed/simple;
	bh=U0qqPIH2WC5GFE+KvhxWvOmq4Ly1CiujAVDFfOoAiPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OajS8JpMw9Ug/KVFyExR3MEjyiTynOXRUth8RUw5om7JNnry7BDenim3G3Hr4g3McHna+E9L/EliPKz0MCK//9mMk1LrFaW9r2wltU2RifAvVtOtv2Xt0AfcvPfUrsbVGV41WeeDC+X6TA0f05OmIJv0BFAvg4u42eXhU7Nyqqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qq7sLrMQ; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAAt9fvIvV6qh5O/dMdBz4IE4ebl7CgOi9P7YAaWgYvF7my7rwi3f3UfZxIcidveBrbFd4MAsysiaefoxHMhimSVydHjrGI5wyaLdEyNQwVDIkmzIV/aRsukE0EKe0938rT57Ol7JZcxC+R+l5QX7u1YXTteOVF/J1lQfW1xRXRk8ZYEP3teD4tVI9bfADLIaNPWaW6v0U3BoPn4aGjTxBpr9WXz8mfnaQAhmG5s8xA4jENpUArUs4wnwusO+Z6B7+juHJfohpkz2xw4kQRsLC6VRSgO2NeT3ph+sgu9o+TSi/cEt2Tqqv4eDXB5r/FBOKlRKZqpZGjBqWdEnu3kkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0qqPIH2WC5GFE+KvhxWvOmq4Ly1CiujAVDFfOoAiPA=;
 b=NciP6LkuQ8SZJqLVsWye38dUz3hUlaNLKSKyvQsfUNZ8hTGvAMpuriybEYXuy/i4cpkJGarFB5H9rFYF7SBho6VGlyCkcl2u5t21boXKPm613usexGahq8w2BHCq5BOTcFHsRzTLISIuAPuz9OorSCWgGs9vjLrAzfE6hl+WPytWxpVT3DMD3bq9lPK19X5lSuTPGPryhdQtZBFfGQu9UsTUJMN/Y2+YToVOvNKcgKzcYCMSV2Lh+uNtI5MUxVk4gVl8bvouZglGuBnrsROZFlI9g6aFAsZbd5AE+3DtMiiHTgim+t1FWRSJjhX/pzt/KmX9EciNTJCAEHHN6j2yLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0qqPIH2WC5GFE+KvhxWvOmq4Ly1CiujAVDFfOoAiPA=;
 b=Qq7sLrMQH6pYPzNm6CNi7NgYOXogxICmXEf84XlhDN24QKMrX+1Lr+uGtSBaENfivM4tLx8rG6qaSxPLifmX2I7V+XToC64h4bKmThtqY3LupyTFgARaKVqHCqsf9arHZsejq75U1Yl4UimpRJefEBAteCmc3aVx3Gc4hi9Qm1DR5SpiT8y2NXfQj5LR0tTOpCc8yKaL0JwzO0qwexYbwuf1TPdx7Eiq5G9waNVQif/p8mH8KL62i7kpiKr0zJbB5f4SsspHwTXQZDS8bNAPm0/Kk9TzUDevypfz8HBgB9PqLSiFF+LuZBSEWHujMQjnKMsGSopMXyrA7D/lqO1rDA==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SA0PR11MB4734.namprd11.prod.outlook.com (2603:10b6:806:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 10:32:46 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 10:32:46 +0000
From: <Divya.Koppera@microchip.com>
To: <o.rempel@pengutronix.de>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>
CC: <rmk+kernel@armlinux.org.uk>, <florian.fainelli@broadcom.com>,
	<kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v5 2/2] net: phy: Add support for PHY timing-role
 configuration via device tree
Thread-Topic: [PATCH net-next v5 2/2] net: phy: Add support for PHY
 timing-role configuration via device tree
Thread-Index: AQHbFjxOtVCSTOxujEyjgnxCZy0qiLJ2ZJuA
Date: Fri, 4 Oct 2024 10:32:45 +0000
Message-ID:
 <CO1PR11MB477111B424E9435AD318D09EE2722@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241004090100.1654353-1-o.rempel@pengutronix.de>
 <20241004090100.1654353-3-o.rempel@pengutronix.de>
In-Reply-To: <20241004090100.1654353-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SA0PR11MB4734:EE_
x-ms-office365-filtering-correlation-id: b0083d8c-bb13-4db2-13f8-08dce45fe328
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GNJXXg00kgNw3QIHNFzjH8AKH+GyO4m+3PKoF6wH2aMD/TaBKgyWAa1DEt5a?=
 =?us-ascii?Q?G0JXXw5uzrsUiGFRxt+YncMrkaDed1ZNviWs7hXNt8foXXyFbWl7z8TNvRyP?=
 =?us-ascii?Q?ST7J6/SCwEcjZJ8Zc7i2OaQpIP2DJcsfWWVJHmJKJdr2AvSCAHCXav+ScxIL?=
 =?us-ascii?Q?jYFqOy0T/Tl7AVlLrRIP3MlrHgX5j30X3SJAAwCyk//Z+cunndU+L+f4/maX?=
 =?us-ascii?Q?Ge3NMUI6p5DKayj1pFwBqbHa5OKD1DQRDWRLHYojpMjqDq9pRGZloP4mD9Cp?=
 =?us-ascii?Q?CDMKdVYcfxvShufm9wcVmU7UClhQ8jlx00GdI2zZe4fWrr3Oi2Dm/D3fB2gF?=
 =?us-ascii?Q?yFZxB/hb07BoxxxYwn3QwHMnIVWPEclCqEyhgDf2O+QUzwvwlfXYJjkEmaJb?=
 =?us-ascii?Q?7pYVO4IdlGPCzbjK9t1MvX1h/SzyTbt9yGEMmzu2zFj+sur0EJUbwBsuyJWm?=
 =?us-ascii?Q?Ya8ji9d1FsYYLIouDeY63f4/DOV9tHc4PxOMnNkQBIHZlA5C8D4XTcyBoJ6L?=
 =?us-ascii?Q?1l0A5OvbbmiEx1slMTqKc7yP/M4YujD6FYnCXFmQh6sPQ3M8YSDtdMwbp34h?=
 =?us-ascii?Q?WBg1cEwvFvFzMVl7ysMx082aJ4AgmcltuN9mMOYiZbVWXsmxYUJulGyGPCsH?=
 =?us-ascii?Q?ypUmpuTZpSqZKlOLm2RdcwPCKvSCA13hMLxGSftYKO06lMARd0HCrEml6gtG?=
 =?us-ascii?Q?uwS9ZFhv8FM701tqUlKQPhFexQR/BL1PPYUShPGQs30bnbXuY+ePERTalI3P?=
 =?us-ascii?Q?jbfvE4NOvZdmyNdyj4VNMYarfep1WlDvGjy3kGbRZ1HqkLHTejoYbQ6Md/wk?=
 =?us-ascii?Q?YsQtjWuf0nigSltTTtXujs5Ieos7CMacGiDsT/1/VrOD5uoyN4KE0vXAn3x3?=
 =?us-ascii?Q?fVl6+WSiKt2K84YsLMErWKncvYzQbnPuR9gRYO8KoyDQ/N8mqcnHhPWRHKQv?=
 =?us-ascii?Q?Gcxky8tEbNnL+RRZqyNhynBLAe0R44g/rdd+eXptA4jhDWT68leXFrz4kM8j?=
 =?us-ascii?Q?e0t0+62+ADhwb+h602IInsZ5ldQUObqX3VTsUDAYYkaxhgUxpuPvEseUSfDy?=
 =?us-ascii?Q?C2mUY9PBVitLflSsiOgAHam9adZK3OMBwbREXUAxYmuC3M8GfLS+/0EItWr5?=
 =?us-ascii?Q?6NNqBZMKhOgBjqFx9U81JV+ka2lLpUW7darUlVC2Vn+XT3XiaYpVjeAWBRnk?=
 =?us-ascii?Q?TRMKvNDQgaf2Knz83MW4ME8VH7r0pKhtW3MB+3QLrDimhhZCPG9ngzmqGtKp?=
 =?us-ascii?Q?m8el7z2A9XV+8EfEmTT0l1KBbEUDqRUUoLU0/W4Z1nh6xCoG1DtJ0vECaXiu?=
 =?us-ascii?Q?0Y6DoMrrrBOc99iWS1XVFZsls0aYddEJg1TmBR0rGADZ4ZSPwd+RfrgRYczT?=
 =?us-ascii?Q?Lyx3MnA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SMfQfk+pPND/y5DSV6hFpQr3KFLirmyPWpbw8O0GZtmwWc6Ygbb8l4nFX+qv?=
 =?us-ascii?Q?W1gmT2guv9Xz/xyyE2CT1u89kJMYTQ33NTcM5S7KPSrfCH7F2OJYuQ+andBn?=
 =?us-ascii?Q?fI5Q/ezHrNi5N0sWRQCB7y7/rXwxSvOJQO76/9faGQDx9wpPD/OBCmrSZd7L?=
 =?us-ascii?Q?3A5IO5fQY8FQZ8GZTYDH40h7sGalYUvBg63UkCvRc5xnJlBGMhrZsJR2/Lhk?=
 =?us-ascii?Q?nHgbMe4BMbZ+oxCjMTj7YIkaDLyd2oe0hY1MB7o7jN4lnxhSD2zSl+UllhMF?=
 =?us-ascii?Q?5xxyTBMtoT5iTg8DeVWMPqljBYlyVt89Bsk9sjG07D6AXz3q7RqkgacpLB42?=
 =?us-ascii?Q?hnqu0ePgvvakpmBquVOTTUsTO/Zxha8+eQkwrR6GxpRekX30OpiT1qtiI5xx?=
 =?us-ascii?Q?cQZjoA9dUcPHDBFzkwVXr8KnEHudBoqSTDpXBU5tb6a2w3CfBtuHzFhm+YGx?=
 =?us-ascii?Q?zsg2EebxruVmW3StatfW08pBB8d1TXIXDxxjmDoftup6uAmvy8lvC0w4Qipb?=
 =?us-ascii?Q?R9Gn5i/+sWOz35S8qmzovcUMPjUo1begsCW6XwF4YQ82IGnQuQT8fxlNWKN4?=
 =?us-ascii?Q?KoL3UeFsxepMhA/WTzR15vZsReFy8bopaAQ36Kn8mYxAt08u9+PZeTLaE9PJ?=
 =?us-ascii?Q?K1Nwu6eF1XqVnfS9estUAuN1hGSdGtnckaYZKCLJZsiqr4kmvcXNeFY5rs1E?=
 =?us-ascii?Q?CVLlLkQyPI0+yBpzLXy5RzDxbrUbGHRs2rVDc654CnyaCvdoFfwqEKB2A9Gj?=
 =?us-ascii?Q?FEgh43j/4kBRKG4BF5NIG5KCTwjTZv2HrhF9cqkAJrxvvG2uRNw25Oiq8XlG?=
 =?us-ascii?Q?S+IGPe4HxtPY+DP2HPW92N3+EfmWORCsQxxUJXIKN7uBJw/6OHM2V+7ga6fP?=
 =?us-ascii?Q?XEPI9Df+yAAJOFv8b2h/Ou+vpfjcVR9giaOgj+1jkKliHwxR/ZSKf6OJ0vQn?=
 =?us-ascii?Q?76E8aA7i7QDVeHeQxSfcoaqROP28pqMA20gHlhUNCLd23M97eCiSOhOjrapl?=
 =?us-ascii?Q?pbLwJzjVy92WuJWQ9HBVvVGrSMYWcuE3EH0N1g1cOORbZTNgqObBdnUX8vUo?=
 =?us-ascii?Q?mKzbUpLOStz/8Si/BnIxG8MnEfFK0IzYVQDM90R+kCB4i8+UVZhuxDT2r5eY?=
 =?us-ascii?Q?2wZqeBjCDXfWvtzpqg/TFZq8dgKo+cts6iY6FyUpnzaoVZpvZf2rIMJxQYhM?=
 =?us-ascii?Q?0GsGAUTIimwYLAVZpARxxouIn/G+6H3hj5Loj/JGX3Hym4w0f9Ldh9V0+cPU?=
 =?us-ascii?Q?h2IKyxM3FzSNCMJ9kaeAujrNSgsVBRxBNAhkrb53d04ywegLuuE3Ycz7ry+B?=
 =?us-ascii?Q?+ZT4QvqfrcRJQ47MQ0vrqtFaHDJPykwM1vP5O9Xytq31V7K9iIy4Agq13X9U?=
 =?us-ascii?Q?sxH2zMq5qhOpNGyQAm2SqVvtOyiDSGuxo9MY4VGD3/BmGQ+2jw+pslFILOPX?=
 =?us-ascii?Q?Z4XXBq8VnOv9HMhzW+DcJALj1LpuGqXAYlzVRojloWMTcVNtongsBBcGLvrD?=
 =?us-ascii?Q?MRO8jUuPFaQcPBe2JXsLRgmjydvkqE/xbhCim+iFK/9Wy+E8yc3MgWHV++0k?=
 =?us-ascii?Q?i+peHF3wtJmU4iZTJ9mrtCMraVj12ojZrvp02L8G6rvs8jCaa6icdwaUwpsv?=
 =?us-ascii?Q?hA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0083d8c-bb13-4db2-13f8-08dce45fe328
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 10:32:46.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFU2MluF6/b/FR64Fk76xYyowXAVsRzLv3Q7BjpNnPeltObBWLRgS/0l7hkPOzxhHCVW0ugsh5eeVxgzxzfXL5vShCSrJYA+JMTZ8XlAFNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4734

> Introduce support for configuring the master/slave role of PHYs based on =
the
> `timing-role` property in the device tree. While this functionality is ne=
cessary
> for Single Pair Ethernet (SPE) PHYs (1000/100/10Base-T1) where hardware
> strap pins may be unavailable or incorrectly set, it works for any PHY ty=
pe.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> changes v5:
> - s/force-/forced-/
> - s/prefer-/preferred-/

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

