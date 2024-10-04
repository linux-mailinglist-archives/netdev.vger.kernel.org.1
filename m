Return-Path: <netdev+bounces-131986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F310990167
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA7B282098
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB71553AF;
	Fri,  4 Oct 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ilu4rJys"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5851487E9;
	Fri,  4 Oct 2024 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038021; cv=fail; b=aGAdLqTQ2Sgxqd/IJDxO1cuTqI/4k7qnf5Jr14yJOGn0GSRDYtt61x/tcxOLww/OkwEJDAOMBgTCIpxVP2ai/fjHe/lJNJSWvYtCAop0enG3tTYQJtpb8V/THILLO6rwRHWO8i0xGWGwFF4EAwg9H2P0UMTl1NsUiOmr+mDdE2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038021; c=relaxed/simple;
	bh=c7V7/0vmJoab5MCQDRK9MIUGn+Q5ZX1kpl6VgdfUkpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iXg5EMqmWc6efcQWaySd7OoXjRVg27qWlFdGBYA0pCd29rH+uajtHwmGgt4APY2BPC2ldQHuGRsumg6434PyfQj4YA6uJJRWpsnmPUFrD+xkn9/eUVPvQssGT4oi//dlId5Qet+c/S96Raw/t6wPNJkdARVFesN/N1Q3vQ4hxws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ilu4rJys; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaCq3nHDtUz1zFxI+EAiCU1bKaaofUn/XHoFR7yPK9XHVPljeSxHyMtVVgzLg1n6QvmaIfuScipBxQTNeqGLxYKI4X5DJ8Mq5BRRPpO6P3z+4IJqq8heSqRxlIZRUqFnDvKzbj/mGExGS4arhj+geZHLQun0YDIG04cX9jffpeLwMkVy3GqLQKGYKVEObZocXLO4xANKAyQ2cYi5Q5+PKImUj6+KJVq+wwzqXPOSspcd6Gu9kmlOD9KhNrK0cPG1KVCm9M1XvmFVPfpt2qv6Mgu+pwWdkjc6i8LhA1ZFwW5bKM2t+ud9rhMJM1Yq4e+LIZn/wesb68zojGly/agH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7V7/0vmJoab5MCQDRK9MIUGn+Q5ZX1kpl6VgdfUkpE=;
 b=PdqBLqmICvE1N9qoY2iD2K/NCw+TVR7nKbCwVC5vcal6i1/IHZJ2Mv5a7DEJST2EqGiq4olVVh4sPp8wrw8u7DDK0YFtb9r3/ayAFLjfeacQCbn9QTvh1Mw/YsUBRXQeuf0PMlVYmATMDHXRD5jba0YAUDA5JpGd4YFGYAAKP5HVMQtEhnmPjibbINR9SHKzuFc7kmtF8quyNXsVAUPYnhL8DGSYMqmakYMYltLAWNH1Cu2VYdSLHGsUjHxgNkyQhJXMXLy4u1UTKGpq2SzkjYkKpu52ZlQYoS/K4emZDXFPhsLc0lz22t3s97eNBfr6ytlLkf1EPfExo0DJXgKZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7V7/0vmJoab5MCQDRK9MIUGn+Q5ZX1kpl6VgdfUkpE=;
 b=ilu4rJysGCvB2moVEwfE8UhwwsXRN+0+EmCcUupwO2XViKUXFW4qfB5vPfR0X1fSla5YYtHQ10aEMeKt/URqYwwuvYxxI2cADd6tTHasfkoocl2ZP9nznzJKPnkshUp5CxyAtGNQTG1pqyZNwesa2ofqKuTujWDMGqRTKXVYJsMZl898KYWbCKQJF1OYwoqiqvQ/2rEFk94L6WbuoFG3VJacWcL6M/whX6gKMDPByYnOTRK5DW37wHy1CZk7+N8Id6YdOWhvLHsV6OdNMwWoAVonkq7gcwCRNofW2em94nZeu/By63Rmu4wQMIRP825HOgOaS9YOW/twIppQLz80TA==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SA0PR11MB4734.namprd11.prod.outlook.com (2603:10b6:806:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 10:33:36 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 10:33:36 +0000
From: <Divya.Koppera@microchip.com>
To: <o.rempel@pengutronix.de>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>
CC: <florian.fainelli@broadcom.com>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux@armlinux.org.uk>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Thread-Topic: [PATCH net-next v5 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Thread-Index: AQHbFjwHeEqE6dnMWkKCx44uMgSVO7J2ZQrw
Date: Fri, 4 Oct 2024 10:33:36 +0000
Message-ID:
 <CO1PR11MB4771BFEB270D7F3210744C21E2722@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241004090100.1654353-1-o.rempel@pengutronix.de>
 <20241004090100.1654353-2-o.rempel@pengutronix.de>
In-Reply-To: <20241004090100.1654353-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SA0PR11MB4734:EE_
x-ms-office365-filtering-correlation-id: 3f853837-5f78-4230-4c6f-08dce460011e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZeWXCn8C+DlOZLW8oytkZ+MiU4TKxracOPSW7bP1BPNQje4uyWq+ojP1+vZ3?=
 =?us-ascii?Q?BG1PzuETw3wmyBpVSnRsDsjmakwnY68/o/MRITOYNrqs/cU7m3tRerOuExK2?=
 =?us-ascii?Q?pQUoP4clfqwL8vTwTBgKHBa1kmXbDcb40y6JWBic0dVv0NP6kbxnV+vSvBHN?=
 =?us-ascii?Q?jMEXejhbJZsA6E33vVraonERLpVzf6Tg+gapKG/XipXM9ZovaaTFbOt2c+WU?=
 =?us-ascii?Q?wq7h20au9QLGJBz9mCB5Bmg2gXOleZD4ymNt+uU7jrpmzPNIo3F99hUPAaW5?=
 =?us-ascii?Q?5B0u3z3cAMkRBwgrrnWRi0vYNMNL12+E3c3hztEN+LN7IlQOvIN6Wky96TQS?=
 =?us-ascii?Q?Qu8q6rg8Bug/l39ktaZqGmlhOAYPbdeuoG9TelbbzIa/SkSVhygWtArknmJb?=
 =?us-ascii?Q?PZpb3Kh8iJ6FEKqFRcq8c0CQiv9EeB+Xonh4JN5cwN48ggm9cpm6Vo5EISE0?=
 =?us-ascii?Q?XgFfD9dT6s8U4wq6fgUhOtZVIpSR3L/SkBGW2hzUf+azJgd7tWYcMKLw7Lme?=
 =?us-ascii?Q?Py7oKtwu1c7xRNLFwp+2wjbnmLcPEjsRJkHRi5Do0W4bmRqyH1u3c6oA8zZf?=
 =?us-ascii?Q?t66xPSjY4f7u52Uobw1XViHBmGAW0pHauH6pbQoN8EBycj8ASrpvXSSg/QSA?=
 =?us-ascii?Q?tbdax3zhY61WVpbrzz37XHzZrsLKJEouj0qbVGu9mbLoViuxNlWYxq1Py/Yq?=
 =?us-ascii?Q?SwTHz97ZJymVwrXf2Z1zfsJbUlyfqYbnvTman2oOXHqBodX++UuSrvsLm82e?=
 =?us-ascii?Q?xZB/bsE/JzlLHmMHtOadzXA6UrkwvaqC5Jw68/2aD5yWb0GbyjjU/n25hV+5?=
 =?us-ascii?Q?aG7PXct4HxDEu2jXpi4OBIudFyxHgCxhHz3j3tNID5eCsDChkJISmTtvws1i?=
 =?us-ascii?Q?pB+7lm/gv0H7fuq1OWrAyUGzrw5387DZM+pCKN4/BH9kXQl7zEZ6lf5g2bKR?=
 =?us-ascii?Q?2TJPxfajl8eEx6RBT4jt+2m7likRaZUZbYhhCbFWFz0Q8iMTTYjtt5niIMps?=
 =?us-ascii?Q?6Vv4LGwcMR5hp/Am9MQw8P9WPOmKNoCTvTA6FupgDKd0bU8fobc8HaTwmiBO?=
 =?us-ascii?Q?yNy1ap8vtQ5zXxJmgrbkIecLF//Dm531HhFt+p4k0bsUfXD890XLq8Yvo8yO?=
 =?us-ascii?Q?TC2Yihwlgd32au1WzUVXR0S7PfwI53VgJLjl5x4fp6jL4zSCvZXX7mZAEBDY?=
 =?us-ascii?Q?HUqaV9RWrHEtfj5pra7gifMcpOTP9N1LVR1lBofFNogQ5v1qNk3Aug6nz6J6?=
 =?us-ascii?Q?u3YnbTQ7+slEdgEYirNeskt5H1KeqwVZasQroZ4PcW91mSq/DQapDPrHqBP4?=
 =?us-ascii?Q?PWfu8KaFX7KGaDAfKLwgZzgcNfzbzdNVLqiq79AzaHyNzBrFVka8dmgzpjhV?=
 =?us-ascii?Q?sfOK+6o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2aVDaBQtmbbGSY4jiKMw7HmLIKT25WSeuObI6IMUM2RA5LywGtMuEXXD3Gec?=
 =?us-ascii?Q?13c+wGOCjYOrCva+xUiKnUHqjPU3JN9IOnYz64ITRyTx2675tKhxXev/aZbG?=
 =?us-ascii?Q?/Y+0u4ZVx6eF/+2J3ESo3r4ffuOBTv6nv6uaGa2v5bl3MRsG6O2Ytl/8E+nq?=
 =?us-ascii?Q?xXSC+jeUFhs/6OI7zHUEV147V8cUrpZ/qWYlFo27QbKHtahgfCIvbinmqY6L?=
 =?us-ascii?Q?hmPEUEoflVi1ZWHMyGcRGFeiaWDzJmewOVzxWZnmhoewPXNLSgFwcky9NLpq?=
 =?us-ascii?Q?ZfTWAH/oFYUM/z6/B04yG3eY+1mtvf7g2KZSPEKec12+5/EZxFlq7GdXnW89?=
 =?us-ascii?Q?g4LUTB9F8+OFynLMHdoAGZQ9p+MaqMnL/BWEHFRdIan4Q+TBIv7jKR+dnpr5?=
 =?us-ascii?Q?uzPyq6d5N8ZVYiZmeY901UlCvBwKm9HL23vbOEvxeZsIxGfvc/U4Y6UDdWx9?=
 =?us-ascii?Q?97v2JSqmmGFFbmd5PYv+2cB7PVHb8RkFIM2V+CUc3dIHP0scJKnlCpcuZ+Jd?=
 =?us-ascii?Q?Z5j2IRax1LWPfHAboSlv+PbtA7iiXGaZFlwkZGTqaeunrH2p3QLPNk7BbOzF?=
 =?us-ascii?Q?MNbaUZtGrjR02xGUVX6CgJiwr1NqH07Rx6mfxaG22Arh0cwSwNnn01nwQfgl?=
 =?us-ascii?Q?JHOiiw/Tn9k7GNrFng9vCi6jW1MI38kQofyYZyLd4XpHHMrs+UvJ6g6iQp5h?=
 =?us-ascii?Q?9BDms6f+CVv9pLEwu8VmtZUaHN08oIAed+PS97XNU9UgQczeZIHUjV0wge4i?=
 =?us-ascii?Q?M1osUfSR3F26Vf3Xmdv4AVj9Wb6w5jTJAtahQhbi5AmpSUCct2YOSieQ/B8D?=
 =?us-ascii?Q?y8F5t+7v+OUxtUfhvwI1xT5dn8oQ64uOAWKs0gpHk3weQ9pJ9v8w70mhHpy9?=
 =?us-ascii?Q?fcs1eKreG/vyTJ6CD8U0NqgtoG9vn4RV7YaRDGtcZHf1EoaOMXf9+YpkCUrR?=
 =?us-ascii?Q?HyhlyUUccNHOGymGdHq8/3xFTMSsWZkNOFv7t7LTdFm0l3tj08mLAC3qXZij?=
 =?us-ascii?Q?KCF9Iqwro1tmONaqKtP/zqHtBSO2a7O08DDnDij9Z8ebfAHZHINt5O4HkyLZ?=
 =?us-ascii?Q?PBeZtnfm3Qev2U6gx0MzXxXlhI5I6N/Hgfsh9xUYcwLnps84E76LLbnvbAa0?=
 =?us-ascii?Q?+lSM/2XDT2hpB5a0e5/6lsnFBKzKJV+hMZfGrq3YaWTqMUJZ5prokJBWYnxy?=
 =?us-ascii?Q?MjQeXFDtuJI1yH1LrjZ5EMxDlHwMyWykb2NT0bEFy25O66vXGEqp74dWUdRr?=
 =?us-ascii?Q?zv6z7tfDgXjTcFz/pq9xw7UjMzcxiCUI1/RAqfPY0csRzctqdOdKLq/DWuFF?=
 =?us-ascii?Q?hNTj8AKlP8TrOCOaQfgfZPPiU4g7GVk98VVeGPtX6WhpDz3VQm0ZpwrXGmoV?=
 =?us-ascii?Q?9ryj1O81m21uyitAb75ZkgUHQLSJrnfxpiGZpNxZqKFW2dOR5YZI81si3L4u?=
 =?us-ascii?Q?Dn9Ghhci3RAxUCUUidHdV1JXIOPPxe5K2/kdXrKz2kzlUGf1TgZ0XFMK9KMg?=
 =?us-ascii?Q?0kGBvfMwgj5HyKWbCSFfieq5SuDC5ZDGVp6qyYjqUd8/JvQFtzRxZOkjakDF?=
 =?us-ascii?Q?4kxW41SAT6CgQ2qOFSkgWh8UbEyix3gGh3azIqRnxC74rWFnTJvhXlK56T03?=
 =?us-ascii?Q?tg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f853837-5f78-4230-4c6f-08dce460011e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 10:33:36.6297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/fDCPvkqet1gVRol+TD8r4D7viAzEbgelMjYtgSif3gnxaWijxAOG2h0XWUiw9UM1rTPx22NElbGpNL1uWLNO+fPFEY3eX5BsyRqvCmH9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4734

> This patch introduces a new `timing-role` property in the device tree bin=
dings
> for configuring the master/slave role of PHYs. This is essential for scen=
arios
> where hardware strap pins are unavailable or incorrectly configured.
>=20
> The `timing-role` property supports the following values:
> - `forced-master`: Forces the PHY to operate as a master (clock source).
> - `forced-slave`: Forces the PHY to operate as a slave (clock receiver).
> - `preferred-master`: Prefers the PHY to be master but allows negotiation=
.
> - `preferred-slave`: Prefers the PHY to be slave but allows negotiation.
>=20
> The terms "master" and "slave" are retained in this context to align with=
 the
> IEEE 802.3 standards, where they are used to describe the roles of PHY de=
vices
> in managing clock signals for data transmission. In particular, the terms=
 are
> used in specifications for 1000Base-T and MultiGBASE-T PHYs, among others=
.
> Although there is an effort to adopt more inclusive terminology, replacin=
g
> these terms could create discrepancies between the Linux kernel and the
> established standards, documentation, and existing hardware interfaces.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> changes v5:
> - s/force-/forced-(/g
> - s/prefer-/preferred-/g
> changes v4:
> - add "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>"
> changes v3:
> - rename "master-slave" to "timing-role"
> changes v2:
> - use string property instead of multiple flags
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>

