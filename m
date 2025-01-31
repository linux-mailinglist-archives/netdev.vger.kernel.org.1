Return-Path: <netdev+bounces-161719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FDFA238F5
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 03:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15A93A4C25
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 02:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448A1F95E;
	Fri, 31 Jan 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ByYpyOzG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C4819;
	Fri, 31 Jan 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738290268; cv=fail; b=cHkGysVvBRhS91FrY0LD1GTmFz4dsOstHK/tG+8ElrxVT1XhX4mdiOKjMu9PVwYL0ya4CJTg/SxRi76UMK3dPC2/PMwP4bB1giW/O03M6Ra3cgf+0RIi+TWtXFMP7G97lhMgkiIcIinY9KMMaBT/441L7NO+oVyZgCC5vJmTGC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738290268; c=relaxed/simple;
	bh=bgxpj1a3Bs4R4a3PxosjxwXZxJQepb+SJrSJ1gwAzdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qeBKoGtulpsxw/Ra4VlQ3SLksSRhZh7Rr/SGOl/2L4Wrzg0FHieHMxfmDFhbqXD8W8fRyyx6Bj/XcPFjwBqjKqAGekjmdemF8E1wPWhFrWZ9nHqNUojDNDIyPKM2GBPKTo/ZaQl1OzFWKRogP2/ul47S6edJMzmcYPM1YCNMj4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ByYpyOzG; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8+v3ehH9tKpygX0MwdKRMzr5tGBC62R6xstU95KoDzuFqirEszKqB0TJ0ybjiWUa5n/EdfE3fYinZFJqjabPj4I27k/UsBDTYvCMeNHX0e134koayBr1guorax7uidRHUq/Kw0YpIjIT9sxQH4LsfcogR6SaIAI+C0VxbAsSK7xZsqxUsZzJaf7pJG9cy/SN2z2YyDkCoCYLty4OJA35U2Yvhvh1v5Wq3sSHD0eLnSnCaen6ic/3kh8vxhYl2ksKUqiKJOIHCZwjHB20ygXUfiSwL85aADEECGGzAHn1KH+KH5IAevvTIlEJiSCP9JEK+2OLVGMCHWFDMoDNLEV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHntNKxFM3/KOwwvt9zaYupaYsxOym4u5XLLs+kTxJY=;
 b=sFCzPPJcJa84X9xmTTQ//+EiClalTqLgkDx3ZL+qNqaY76661SGe2vEAYh2Mfum7jIrQMpGofoVSHCVBoNGEViFRAx3Pi4d2QgNKSi9RN16x2Yu0ws9eopm7ihGm890OLkDvvSsM4Q/pGJ9kCZjQnk1eOPgKGkdFjc0j1WCm0eS0XHHV24bjoOXTOFiqf2OtF7btj9FpYFO6cd8gvBL1nO5YIYPr2GGNCVI+9pmX56DCQbi+N5UjDdDO2cuEkxRY63o0ky0YykUNVLLH6e7zF72SGjN3tmX9z29+CnOi+TQvLIjcs3PbAW/ZeyXgV24raaB3kHb0HSZyznj8cB9tRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHntNKxFM3/KOwwvt9zaYupaYsxOym4u5XLLs+kTxJY=;
 b=ByYpyOzGD5Odmwkw4mSHkFRFzENePrXM069GCnJrC9Vx90Gu+AZIz0nCntyV1H9Bp4GmgOgnQ+R0bhIEqE27KCJjyVpCxYDY0Z2jLIQakJHxql//HOgC1Ee2ArTFWoUwCxGc/35mI7xH9rxaOiahMlJPlRc34LfPuwjYwoYa+nQ/78r6mwKF8a5I96c66KcSVYpi5HpJJsSmixCOZeTRNSdOYE7mj8BswQmlZ47tPkc+1mg9Yqh3iMQbK/07aZ4kxwXHsGTbFT7LywaVQ4q1kD9FAHCjxtSXDL8ju27P4lbhhTVk7UGhyTnGTBEJpa/CDCiSRlrAc8kab5iLidnEHQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Fri, 31 Jan 2025 02:24:23 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 02:24:23 +0000
From: <Tristram.Ha@microchip.com>
To: <linux@armlinux.org.uk>
CC: <olteanv@gmail.com>, <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Topic: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAAa21wgABqvgCAAP7b4A==
Date: Fri, 31 Jan 2025 02:24:23 +0000
Message-ID:
 <DM3PR11MB8736B524E983153188A531ADECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <Z5tNcNINk1CMDBeo@shell.armlinux.org.uk>
In-Reply-To: <Z5tNcNINk1CMDBeo@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DM6PR11MB4706:EE_
x-ms-office365-filtering-correlation-id: 37d3f0ca-7264-4fb5-97a1-08dd419e6073
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3O7qTmnZ8hVy0sFgN/vv0/t5ypOptNdeDFBvHboqQhBak0MRI+Bf6DmpKK6b?=
 =?us-ascii?Q?0ja3NuK2TmVzjVwVoKoJAaDxy98YmzAus0EAHppFy+q8pf9mJ+ATHKUxtEVA?=
 =?us-ascii?Q?mwv6BNIcHUnpO9J3wLen3R8pyPxvdihcJGVQKQpYRRDNCyu77jj++P9ydbIy?=
 =?us-ascii?Q?3DV6FZ+TIH7cVZ4cdc2fombQxJcNUflBkCglmi4LyY9/qp513Co42vSlM/Ra?=
 =?us-ascii?Q?5jfDkitVYHzNwxKHnyGkOJLYYs96Khq6qttkLLNX6yucdLBVWemDsW+pjEu8?=
 =?us-ascii?Q?5Xz+3XZt/P5gpieDRl6y+4XY06/m4ya7HAm3keuUExF3CVsXDErSjtVOd3he?=
 =?us-ascii?Q?02wWnHLUB45moAxXe3C0VFH7CbGpvhZJqGKaCYW0hJy9xqYndAon54O9nIS3?=
 =?us-ascii?Q?M6NR9jH9xpVO+TMH3k2Ac0HfCPPkcyaJsPiwX+jRC/X2cla3fWVe1O6/C0eu?=
 =?us-ascii?Q?Y9DJnQiJDUAzvdwr3WJa81S1N2Qq4UgbH96boKThLeOQu6REatIVxTykQuCg?=
 =?us-ascii?Q?NJfcRx4yz2Dw6bFcwI5Iyo8/lwfE791jNlhgS47vI7IvQGHQtfbE1VeNaTF5?=
 =?us-ascii?Q?hNCYkxumt/fS2FRFEIE/19JFtg/OETRLiSn+N9uj29TZGRAuw2tf5Cs9JDnA?=
 =?us-ascii?Q?6zaO420YR7BUXDzl4OozI/bqSdE/SPY4BP0dOZYMRunQAeM46YfeWlN4B76g?=
 =?us-ascii?Q?RxiyN2Owe5SLY5kESOpTNDzkExr6vJS1dBkcnqD6THEnHHqlOpajxQooPvQk?=
 =?us-ascii?Q?8C0ubD+jrgA7qejKsOn+XXs3+7ioIJWZKR0F3KDIhNSy0GZxCygF5VrB9209?=
 =?us-ascii?Q?H/d/c3AnJ+AjiH9dF4QXbE8RJqOHkoJrcwhEAH2HWFZ0APyt0l+bVNZvGMMA?=
 =?us-ascii?Q?q0LgCJSw9Zqr0VIyuP5Nxn1KB4757cmhuJJk1DQzFsBNkKgmpUf7o9zeAMpI?=
 =?us-ascii?Q?1oxrGSyGlHeaBi7BjwoecHve9EZkKVP9F2Vmi/2eoAj2bg5mcRCqyflKFTJR?=
 =?us-ascii?Q?+9/000Wj3Er+3xjOoc71UwSbYx1zIXioUh2kMJT6+lrLq4K6NRv7StZSmZC5?=
 =?us-ascii?Q?jI2fj8SJf5ZrkNEWGxmW9tXYF3BM9vPQcDofd5RYI35AYcpgTMU863Dh9Nfy?=
 =?us-ascii?Q?LwdYMxuSx6jLyuBBN3Rwo9ywCnmQruxkaV3UiaF0bdwmRBoY3ixqP7V/pR1r?=
 =?us-ascii?Q?UsHlvhFKihx3/cT8iMQIUaSKEITspypp3u4BwH4qpuoLEh8uCjIr+SKGqQIU?=
 =?us-ascii?Q?xOKbAZlOrv5VrwOC2X7vNxW7pJ/YU8s68qNI0l6HBA1OWbZLEHR1lwEqwFJj?=
 =?us-ascii?Q?xCNF6UmsplXwFODyKUhfU8pXq3Fjlxdq/rUpg/K2RRsdCok+8mJ432rZ/2LH?=
 =?us-ascii?Q?Dsl5pTr9coE9D2u+WUUJ4y9Fcn75Gm7o04EBIzO7vRFtod/f9O0YVh2v3QmG?=
 =?us-ascii?Q?komUOpQ+bH2vl/3LKZVHL9xWkBX+jAO9?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C5uNuzNABVi25gb2krdlZTLLZN4WdsjuN6ZmJKfc+Ki0HdkDct4zIz+RBiGa?=
 =?us-ascii?Q?FugNl4g1QEoaCXaGixAsoNd3SfqXLUiW15anJmZ+1gU94LXH+lUdD32oSlkn?=
 =?us-ascii?Q?+8SMfBJmz+D5wn/0ZKhtYCQ+Fil8cVHkMiKp8AM+HqdLhNq7SrznVF+IAje6?=
 =?us-ascii?Q?MA/XC7CkBf7gXXw/Tk8bqlOYyok66KjAnsttw0X87yTDhOVjpg3FRgpGay6o?=
 =?us-ascii?Q?VysnSQ1PHaZ71b8qNj1CGk4/PN5dhRzePyMccfm8cgUpzh2WWLndpj52fFck?=
 =?us-ascii?Q?a06XWBzh8NyFLzoebxx1XMN2pQ1AFhW6bI6njIyG4QklEG72hVljV1xKOC6n?=
 =?us-ascii?Q?nSGgc606yR6dmqv+eVOaW9ZV0u+XfZLAk0ejFMs+OnCgbMtF0EkEAJXYYWlG?=
 =?us-ascii?Q?rGHTLvVfslYDFXzUrpfr5HwVfZ9k7bzdsYOZmqNDRnFUi08BPFY0z6kixeZV?=
 =?us-ascii?Q?WHc7Mn6yiPvC2VS9f1vsWK9Rg0XPlS22RxfBYEH/klNmsqQ3MC1BSMKEPHP5?=
 =?us-ascii?Q?Sw7BwHTo+5NW780q630ztcWw/4aLxECIB2wVa/2nGz+yZ/s/IULN8s5Pta4u?=
 =?us-ascii?Q?shosPaTuoOOQ4mH7wrS7yx/4FXz2f7NS32w+inHSYRtR/GqjlXbcQZLHVEn2?=
 =?us-ascii?Q?D8vr9YgxuIo5cAJjr9Iv+EVGNUH7AK3osZ34+cJxGBZTCTKa8HeMCR6Uj+Rd?=
 =?us-ascii?Q?WZ8DHsus4XI/gGgj11kHhcz7tLf1npf0HFVBg0e2wZm2XRSEEie8RW0Kli1t?=
 =?us-ascii?Q?XhKiq7xCNCPtkoGXJMhbIKcQJ5/8FLW06DgIH58uGIUWOiNTLARgbkc5R3w1?=
 =?us-ascii?Q?Bh3VhkbGcG9SG8hELUvHW9a9K95S8mEhQMKxINGZLOtwk6md4YGF4hOb85vY?=
 =?us-ascii?Q?doVdPJfKy3yz8UAKjy/q5Ppw6KsyvNHeDhvlrF4JidbsrJqJOXX0szAXwRgg?=
 =?us-ascii?Q?wrcYPA/Ju0n+hCsHxiCV3Se87GU0jYPvBm3Bo3aOr8u1AhFwggCx2X8tjW7z?=
 =?us-ascii?Q?z3a8tzk/EY4DbIOKO2ajoe6y2EcdjaC/72rRNmySa1BLpiZrY8GllCtkU88r?=
 =?us-ascii?Q?greWRBzcDt3sAOgZaL52tjRa6Xq12VD2J3gCAt3FA1WXz4+Y20JUpYKGhLma?=
 =?us-ascii?Q?cIbtN7DG23btUdOwsVYrj3Z2RlCKtiXWKgx6uQMuXZLt7u7GGK0kK6uPYx2q?=
 =?us-ascii?Q?fEC97y8AaABn4av9Seie+Xql5+qwJil+kwRlT0EoP1wejBhFykATJlReN5bd?=
 =?us-ascii?Q?dfGgnh+xRjg8GsS36nU48XetUYLtkFv720fmlx+aV6CWKcHLvohsVV8Pneb1?=
 =?us-ascii?Q?wEXgRB9IyBfp0zwOKxsYLA7JiSBbTRPp7GQgwRgOgvxk3UKUP3M04U0fr0Tp?=
 =?us-ascii?Q?hmWYOAa7Xa7y1tgQaRHvIOPdptbYBu0DVNkmEQEPg8DmNTAeXKLX91v3Jzp/?=
 =?us-ascii?Q?3fLci/TOaTaNV5rHEx/2rnZngnSk7jxZcZ5yhI3xebQRmCaTRchFjHWI0Zp9?=
 =?us-ascii?Q?JOd2jsOvWvYZoOQunAy3u6l8heY4YRS0JN1jVR7w2c07xGlW9xDpxXKTtnlM?=
 =?us-ascii?Q?sSX+q6y2q0D9MkqalzVLiqsB5K0jLUXImXM2rUA9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3f0ca-7264-4fb5-97a1-08dd419e6073
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 02:24:23.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1Wa//SAhZBfoEZIF5WFXJnzqJ+7MT4m09fnHS6Z01nGuVsCsuFoGIYoh6p10B74utf0ZLwuexK4+drGkLSWneH9WWSs2TPZUDlnKr6G/LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706

> > As I mentioned before, the IP used in KSZ9477 is old and so may not mat=
ch
> > the behavior in current DesignWare specifications.  I experimented with
> > different settings and observed these behaviors.
> >
> > DW_VR_MII_DIG_CTRL1 has default value 0x2200.  Setting MAC_AUTO_SW (9)
> > has no effect as the value read back does not retain the bit.  Setting
> > PHY_MODE_CTRL (0) retains the bit but does not seem to have any effect
> > and it is not required for operation.  So we can ignore this register
> > for KSZ9477.
>=20
> So the value of 0x2200 for DIG_CTRL1 means that bits 13 and 9 are both
> set, which are the EN_VSMMD1 and MAC_AUTO_SW bits. So, are you saying
> that MAC_AUTO_SW can't be cleared in KSZ9477? This is key information
> that we need.
>=20
> PHY_MODE_CTRL only has an effect when:
>         DW_VR_MII_PCS_MODE_C37_SGMII
>         DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII
> are both set.
>=20
> are set, and it determines the source for the bits in the configuration
> word to be sent to the _MAC_ (since XPCS is acting as a PHY with both
> these bits set.)

Sorry, my mistake.  The default value is 0x2400.  XPCS driver tries to
write 0x2600 and the value stays at 0x2400.

> > DW_VR_MII_AN_CTRL has default value 0x0004, which means C37_SGMII is
> > enabled.  Plugging in a 10/100/1000Base-T SFP will work without doing
> > anything.
> >
> > Setting TX_CONFIG_PHY_SIDE_SGMII (3) requires auto-negotiation to be
> > disabled in MII_BMCR for the port to work.
>=20
> If you have a SFP plugged in, then setting PHY-side on the XPCS is
> wrong. TX_CONFIG_MAC_SIDE_SGMII should be used, and thus PHY_MODE_CTRL
> is irrelevant as we are not generating a PHY-side Cisco SGMII config
> word (as I detailed when I described the Cisco SGMII config words which
> are asymmetric in nature.)
>=20
> > SGMII_LINK_STS (4) depends on TX_CONFIG_PHY_SIDE_SGMII.  If that bit is
> > not set then this bit has no effect.  The result of setting this bit is
> > auto-negotiation can be enabled in MII_BMCR.
>=20
> "that bit" and "this bit" makes this difficult to follow as I'm not
> sure which of SGMII_LINK_STS or TX_CONFIG_PHY_SIDE_SGMII that "this"
> and "that" are referring to. Please be explicit to avoid confusion.
>=20
> Since in later documentation, SGMII_LINK_STS is used to populate bit
> 15 of the Cisco SGMII configuration word when operating in PHY mode
> when these bits are set:
>=20
>         TX_CONFIG_PHY_SIDE_SGMII
>         PHY_MODE_CTRL
>=20
> then, as PHY_MODE_CTRL is not supported by your hardware (it's marked
> as reserved) I suggest that this older version of XPCS either has this
> PHY_MODE_CTRL as an integration-time option, or the logic of taking
> the values from registers was not implemented in that revision. Thus
> why it only depends on TX_CONFIG_PHY_SIDE_SGMII in your case.
>=20
> > So C37_SGMII mode can still work with TX_CONFIG_PHY_SIDE_SGMII on and
> > auto-negotiation disabled.
>=20
> That's because if the XPCS acts as a PHY and is talking to another PHY,
> the only then that the remote PHY (in the SFP module) is looking for is
> an acknowledgement (bit 14 set.) It's possible that XPCS does this
> despite operating as a PHY. However, there is another (remote)
> possibility.
>=20
> > But the problem is when the cable is
> > unplugged and plugged the port does not work as the module cannot detec=
t
> > the link.  Enabling auto-negotiation and then disabling it will cause
> > the port to work again.
>=20
> ... because the XPCS is operating in the wrong mode, and when operating
> as a PHY does not expect the other end "the MAC" to be signalling link
> status to it. One end of a Cisco SGMII link must operate as a PHY and
> the other end must operate as a MAC to be correct. Other configurations
> may sort-of work but are incorrect to the Cisco SGMII documentation.
>=20
> > Now for 1000BaseX mode C37_1000BASEX is used and when auto-negotiation
> > is disabled the port works.
>=20
> There's something which can complicate "works" - some implementations
> have a "bypass" mode for negotiation. If they only receive idles
> without any sign of negotiation, after a timeout expires, they enter
> "bypass" mode and bring the data link up anyway.

I do not have the knowledge to check that all PHY register bits like
acknowledgment and next-page happen as should be during negotiation. =20
I can only verify the link status is correct and the SGMII port can send
traffic.  If that works then the setup works, isn't it?

The only concern is there may be corruption in the data line or it
completely breaks other IP.

> > For the XPCS driver this can be done by setting neg_mode to false at
> > the beginning. Problem is this flag can > only be set once at driver
> > initialization.
>=20
> Sigh. So you are referring to struct phylink_pcs's boolean neg_mode
> member here, and fiddling with that is _wrong_. This flag is a
> property of the driver code. It's "this driver code wants to see the
> PHYLINK_PCS_NEG_* constants passed into its functions" when set,
> as opposed to the MLO_AN_* constants that legacy drivers had. This
> flag _must_ match the driver. It is _not_ to be fiddled with depending
> on IP versions or other crap like that. It's purely about the code in
> the driver. Do not touch this boolean. Do not change it in the XPCS
> driver. It is correct. Setting it to false is incorrect. Am I clear?

I noticed when neg_mode =3D=3D NEG_INBAND_ENABLED then auto-negotiation is
not enabled.  And in the link_up function the code is skipped when this
is the case.  I wanted to manipulate neg_mode so that it does not equal
to NEG_INBAND_ENABLED and found it can be done by setting pcs->neg_mode
to false.  I know the phylink code changes neg_mode to different values
when pcs->neg_mode is true.  So if pcs->neg_mode is always set to true
then is there a situation when neg_node is not equal to
NEG_INBAND_ENABLED?

After executing this code it was the first time I realized that
1000BASEX mode works with auto-negotiation disabled.

This was my observation during experimentation with the XPCS driver and I
am not trying to change neg_mode.

> > Note this behavior for 1000BaseX mode only occurs in KSZ9477, so we can
> > stop finding the reasons with current specs.
>=20
> Right, and its as documented in the KSZ9477 documentation. 1000base-X
> mode requires TX_CONFIG_PHY_SIDE_SGMII and SGMII_LINK_STS. Likely
> because of the older IP version.
>=20
> Let me get back to what I said in my previous email - but word it
> differently:
>=20
>    Can we think that setting both TX_CONFIG_PHY_SIDE_SGMII and
>    SGMII_LINK_STS unconditionally in the 1000base-X path with will
>    not have any deterimental effects on newer IP versions?

Using this SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII combination does not
have any side effect on the new IP even though it is no longer required
for 1000BASEX mode.

Note SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII | C37_SGMII setting even
works for SGMII mode.  It seems this combination SGMII_LINK_STS |
TX_CONFIG_PHY_SIDE_SGMII reverts the effect of setting
TX_CONFIG_PHY_SIDE_SGMII so the SGMII module still acts as a MAC.

So even though you said not to setup the module as a PHY it may not have
that effect.


