Return-Path: <netdev+bounces-193543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38543AC462A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 04:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF1E1752D1
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021A155A30;
	Tue, 27 May 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="kOM58GKt"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023131.outbound.protection.outlook.com [52.101.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B91E49F;
	Tue, 27 May 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748312459; cv=fail; b=r8OOgZIJ6n8UHsrXSn7x04EbICIy4K2hjzbQjEXdDrMZ+LqEy2A0eHHEcXsfC419bYINRw+21DjVLWWSFuTi1ATBjXmscRJuF9u3iZWGm7YHHpXEI+MlP2xbLmKAf+2nrgmbM4f7Ka3/6kAleyRMvloQ1cguYndeI5Hg87CLxRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748312459; c=relaxed/simple;
	bh=fKjbWQppezvWHVjX6r3UqbC6U3AEabQpZ8GBw+Ly22I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iv3mawa8nwH95KOEaUF1gWCnBaHLCP7/oySkEChYokPEkEQ9/HkK5GYpWOgpWQo+w+1vsU1bOwG07JIsqvNmhcAosEKIXIvE1hXZeXEqQyKQv5k18GRWtuEq7GbC7vOX2XIkN7M4A7rsEqi37JZ3yXu5a7FAPZgH7mlQY/sAre0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=kOM58GKt; arc=fail smtp.client-ip=52.101.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf+8RULmEzU9az82xbdyN48um0VTZEZRGG6ps2Vn8aUWxzRtlghKrxfvHTvyfwchHzU/ILBfbqTMuUMID8xMfPC6Qb+9e8BvHdffQogaRJ4fGSU4kXHtIRiIWC1AWnXJlrecp9anzt7Gia1Gguci4jnDGX5dTHGN+RFGXIjSK27e303bkoAmEmLwkB5bNnZFg233DGOvq4WShU0XmJE+QnTLoEVho5PNPHozfHj2ODr7X5TiVflQuV2cRZ+/JTSL9P2uF174q3xmdUCDVPV4qmQWnVuiJ2n9PSe1r1geWnnkdG/2s/F2sx1hDPJxrzAuHudWOkE5MytjYQ8TmnqBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZVVzEwODpaFBmhiv1h6tALtPNcD/EeCMMJVXgSnJ54=;
 b=c6LG74/ul8gILTIKCUrVKB6yZMqZi5sNQK0JkzbwFo5Ti5KL8yxQ/h6Gy2nnc9GNRBBtNkHwLeyMDV5gIqBnsRM79/Tsks20VI7+nhxuyP4zc6E43UjWr8DzON4kEaJe1mTP8FJ+nGis6n6SbC36Zosx+Addhua0nEkX7tmgRB6lvc6htOndmryaPG59WZKuiHs5XtUko+okbLre8el9ucuZr4ypT4plAGCau1BNn2YQlkriUETM5LUnUq5/q3qnOxPHgAATT/XMphCdUJfGUH/V+ZOSPY+y7uuwSLVHy6KdmgWObH2eAD2QOfJ/FxUT4nWml7uiWYuhgqQ1cDIisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZVVzEwODpaFBmhiv1h6tALtPNcD/EeCMMJVXgSnJ54=;
 b=kOM58GKtvleHa5NmLg8zlNvw8z2WlJyKWFlIZcttyIcZTR7hBzZIQieOeLiVdXlXRKGkPfCnLrZTUAF/O5Kr29RhhFhdFRYTNEe4ev1jEFWKUJJW5mY/zZLQDUd0KDw9leQENR8kW/Y/a8jPG7m7jQE8bJKUbTbbsLE+KSIkejRb9StoW+WTOQ3w1OG9C+WxRPD+YbiumOp+B2itphqdvUTMZ7TXe4d3xZUj6TnuLm0OWmEP2IBT9PKyiEwJMDins0YElkJi9mlq+O1i7WtrZ1gmkLT/MfPBOHPdbnKg2gqLWK9piH2Ss8TM4a3YP/imMZTzeeVXCaNUoAs7v+rzFg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR0601MB5599.apcprd06.prod.outlook.com (2603:1096:820:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 02:20:49 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 02:20:49 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, BMC-SW
	<BMC-SW@aspeedtech.com>
Subject: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Thread-Topic: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Thread-Index: AQHbyWmbzc4DO9TZvEidHe0NP79ULbPbqjGAgAod+ZA=
Date: Tue, 27 May 2025 02:20:48 +0000
Message-ID:
 <SEYPR06MB51346A27CD1C50C2922FE30C9D64A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-2-jacky_chou@aspeedtech.com>
 <20250520-creature-strenuous-e8b1f36ab82d@spud>
In-Reply-To: <20250520-creature-strenuous-e8b1f36ab82d@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR0601MB5599:EE_
x-ms-office365-filtering-correlation-id: 672e2e4d-0a47-4c34-c58d-08dd9cc51885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0XpD+2GKyNMGDxDlqF1L04tch3RLDy4zqKOrNlJ6sMZCTNbYJA3DWPBIf63t?=
 =?us-ascii?Q?IheNmdDlAwqdDJmEQbeDK5Z9x8UJZRVtWYcTYho5aJAsGfTxjVAVNIGzN6T/?=
 =?us-ascii?Q?T8/MdyqPpwao7VzEYsDMQ5GlZtNg7x1iMg6+o2PQMV4occ17ECN0BgmMzp1r?=
 =?us-ascii?Q?5pHmCK45rLjTEPvOXstqgIIfH9+C3Spx7qYr8TP2HMtV+7vp1NCQr3N0z1oe?=
 =?us-ascii?Q?VO2GvjTtiXSBrmB04qEUPK5CtT2yUuVWmFcHRemBn81EyjOSZMzSZREezHnf?=
 =?us-ascii?Q?+tPjNME0nu8TtrzTOclYsqU6498fy5M1tLo8U7G4M2kXhEF+v716HEG2o6IA?=
 =?us-ascii?Q?e0AQ632ubDPpYgDux1DP7H4EtE0q2iL8VdLlWEqNIobuBnAOtqFGx5YFmZZ4?=
 =?us-ascii?Q?74675vic2QiyfNKn6RlTRFA2WYLxRZT2Bhuxcb/ELj8Zw6mWSJXdvgOddt3M?=
 =?us-ascii?Q?NKJMVbdzhFGABRCcjIv99XYNM5Cbv67g1LLoV30QqSyiSxLWrkEF/cyO4F1k?=
 =?us-ascii?Q?8DobGmIjOHzbJOIHcr1qN/JpHUjn22FnCLcxR50kmU0iq9eFoi6RMM7belVR?=
 =?us-ascii?Q?YG05I/nSmzZhxBU5RK+cr491XJ9Ae0XuxmU7Nk7EelBCyWSn+Wjii7JF4Tk6?=
 =?us-ascii?Q?rFkfaS79NPH9nNxsYwOZrMI5On6Fase1ATHStK1QBkqGJINuNWX5fiV6mmej?=
 =?us-ascii?Q?9f9wF/rREm+SukeRE45FZ6KK4QHFDGRoDR6ZOBP27bzKbyyqp7eQtefmAfkQ?=
 =?us-ascii?Q?g/wXjfWd1gl5T1cAiiivNDKynpy/bNYJ0KsugET6JInHbt7U11+u06RCDl0o?=
 =?us-ascii?Q?TyJ4lDjh8torVhU5x9NrExBla1DPJOfcGKWQwFodDirlDo+rgEGKj4VZcWoB?=
 =?us-ascii?Q?MI8Pza5HhXwg3rLdnK3o/gv63IGum/ipWj3DDYnujZE6TenLsBPwUtGiJa4a?=
 =?us-ascii?Q?rGE+eybuQWqKtoZLJsOmEKmQDbTSXWVWSoIdC7WTT5yssDBAbL63sYw82fg/?=
 =?us-ascii?Q?xfW7pFReUX4T2SPoSl+zvrenpSo9+SdAdwAFIW0PqLRk/d6F8iD77HDs0u5p?=
 =?us-ascii?Q?XOIjiokmlE/dTvUEAkF9hBqjM2pFXRQiAZ8XEZdeqw8j6WBcpjkSWykRBUXk?=
 =?us-ascii?Q?zQw4er1vFLFaCql/tYREKbkXyv5f0lPZjQ9eRNKnAs9OjMWBbNcuCXvDTYTu?=
 =?us-ascii?Q?ntGETBjaAk44ksI8zBM4ZcVTYZG/bu7VpLQ873wDJr8J0vRWEXTEEm4NGvuJ?=
 =?us-ascii?Q?wzxsLKUTvRGUQiWER/Lyt5AWCRN0Zvn4DwoTBoia+7suyNPRrLQO/U2hBYDz?=
 =?us-ascii?Q?+saRonV5F+rEqUdagaFWZUOgXSaLBviGIJKLSP1/ZGry32xrHM7RxQsvZtZr?=
 =?us-ascii?Q?/Uhhi6ZthoV1DZV8qXOWDQOBI9pR5H6E++10+P8tc71v3bA9Vi3tFyMtzM9P?=
 =?us-ascii?Q?7wIIc4CTV/+WjDxMVW0b0Jv43k9m5Cw4AQjmsfi4FbiNQGmQtMvhpA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MA+07sGUQL8nI4MsJHHOZKIM7J1LbwGJtBnpPIAJqxctHGLtu6RlpM1oTjMK?=
 =?us-ascii?Q?36FVVQwZP57QiU/iWuEv9Vb1Ol38vQTGWeLGJ+/3rw/9UxAtg/Z8p9XiUG1+?=
 =?us-ascii?Q?hJ5Ooaed0kVWOIYr27flgvjlcPQX1SghI7s9cy1A/Dm666fH6wpV1S28GGSw?=
 =?us-ascii?Q?YBbwy5iprLJNNUdpwPMO/TsSubPukVjajDklDnMwtpvhkcJ6M3zVFqXWcfZX?=
 =?us-ascii?Q?BupfLp9MhcZRTeDyXi2tmzX2nozAigR+neD33stxYlP+K2ypQecFn0k8lQWA?=
 =?us-ascii?Q?9ghuclc+ZGcMtBXoXxot8QwWLwUGajN0XyCvxDLehsPhqM/CH4Ijy72b/zDN?=
 =?us-ascii?Q?IrorM7mVDbRkQACiaFVJ3AqPwITJ1B7bThLWQa0igFBojmrIamopfOqw9gQw?=
 =?us-ascii?Q?ny89lEs4i3iPX2grxcIJxDsoyaEbF0CB4FVWE/v1HDyFuuDuhnES8TWrCfTl?=
 =?us-ascii?Q?Z29FxX6hOlL76aC+B1UXc0I5UyKdVrgCj2gp2ycEEP929dl5A8NpWVIiuym0?=
 =?us-ascii?Q?yiHGncx2CQzmImw5e20OIV5853tmG7hpIgZEBvcViLzFoDvhEpuVM5wYaIUJ?=
 =?us-ascii?Q?E/p2Cu8vRPQAMnXUAbhiMwscX7jUi3zHcF0RG4SD9hKIRbbr7wbJ4ocrFZ7X?=
 =?us-ascii?Q?0Rs/v5IQ1Esanc85TfCRSxB187iEGVOL+i/d3PThsL2d00sq6gQ4ZSjVARUA?=
 =?us-ascii?Q?oToN9Chrk5JK/n5cYiXF3cNAp6eOVdmh8L9nYQAXGCDUIvNsQ0A34a0SKThs?=
 =?us-ascii?Q?FdyoiXf4/2JGDb7fbuOibletI+delJgn2hnftqQyKeIasZnG9AZMfPqhDBs8?=
 =?us-ascii?Q?mvLYpQF8276mJGsgrBKLTFm7Yxy0S+Pvqs7MvcSxgvXAzdKZUglXjxcwMYMU?=
 =?us-ascii?Q?HkEreCeDuqxyIHE73T5adN+U5x5q4AzX5/7CSgsLyrWsjlzO81MOjeD+Ly8p?=
 =?us-ascii?Q?/3R0WLlStrKNhxusNFDNzwzn7sRBp+zGnTNloF7UsH1XEh57FefQVOGw5GCE?=
 =?us-ascii?Q?D1chGFeFRDpSQxEjm5T92eg5u3KqXqwrrok/9yAGkCG0F5j2+j/iK6dpS+ra?=
 =?us-ascii?Q?wlD+EQ49DKTzM1OnVdD4J7eR9MksrTpNGJ1mGACRc4itS3p4r6eQIlRuq4rM?=
 =?us-ascii?Q?yKFQ0cdygQ9pfST0UXYVj+16YtOFreiV4FCNARMUbAsnFfWaahWG3UA43V0N?=
 =?us-ascii?Q?n6CkyqXmau/NVyqASNetEW57HSY5rc9XTbx29cPsmKhmV4iVk8KZcZeZcBQT?=
 =?us-ascii?Q?GvnZqBVtDeSZzdPowscSUxDZsSAdsS77y4PJr59GVt/iUZUBHxf1NBiKWRA2?=
 =?us-ascii?Q?x1qKn6zoNFlZ1vMfjIdzPuDr1m+NRMMuZIMX9O4JnqMJYY+x1DzLKnUu+FXg?=
 =?us-ascii?Q?+rxvxlxZLSCN5FyxdyOmrjjLrdcByO80xogcjP9ZKI4KdJLJS2IZ+QM29y2C?=
 =?us-ascii?Q?bc9ISY8X2QYD/az0tdPYIJw5cxDgrZSNKmmaPPnoVLkR9yo/pTQ97v3Cr0Dj?=
 =?us-ascii?Q?TPrM9+r866XZkehadPPIbYQ/pZU4c1HyMJ+lW0u4K3q4TS4FAmMC+oSmjkzE?=
 =?us-ascii?Q?QfMZzvnDGrjSi2fJyKnufhcqXUdOb+lFAuWC3p+U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 672e2e4d-0a47-4c34-c58d-08dd9cc51885
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:20:48.9592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQ1o4uVrVPgUqBwBhi3hpNfbSy1m53pct6dpVwO+Mc2AyJR5EIyI9cdGn4d6kko3oAJlDzzBHfLiUiaRV3XB8m2jlMhSN92g/dzSp2uvNU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5599

Hi Conor Dooley,

Thank you for your reply

> > +  resets:
> > +    maxItems: 1
> > +    description:
> > +      Optional reset control for the MAC controller (e.g. Aspeed
> > + SoCs)
>=20
> If only aspeed socs support this, then please restrict to just your produ=
cts.
>=20

The reset function is optional in driver.
If there is reset function in the other SoC, it can also uses the reset pro=
perty in their SoC.

Thanks,
Jacky

