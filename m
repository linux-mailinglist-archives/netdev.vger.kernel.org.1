Return-Path: <netdev+bounces-177149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E32A6E126
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E261720FD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCCE267F7F;
	Mon, 24 Mar 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="UzVzCao8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5E267F48;
	Mon, 24 Mar 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837605; cv=fail; b=VR6JW5tMP4Lvdxr3vn6fibscabIsumZOd5gudMNqwYNXTM+aELnQ5b/cBCVAW/wK/vNvT5xCkBEUlMLoJGQAO9rXweHkvwqxwpUDwaGglhKWOB6AHNX65467OgRXUpuVFASxj7uqNBQ+W90bikiJgmsgncrq8+OvWDFvcAmcI4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837605; c=relaxed/simple;
	bh=y2zRnjMit8EzZUrVrd0TVhyleMyUSu+R2+RKsInd/3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hQmaMldXFKOrkH2SAlNmRrwWSBREn2y6Noc0XiHSvqg31KBzO0Wjcv/oesFUs/nSYE+eQjsJSJFxTac0/5bDUZpjhSEObvsU+7Uhs+PY4CswQjvdUmGlTz9NB0XE7OEkmN2OUtDIGch2+Sk1jAASiL26Wt22LK28t2eSQR+BoIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=UzVzCao8; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ5jHdSyQNbVEH0rJpyrMnfSxVKf3ZNlBPVvyijzq6OL6z1lGpgZCZQd2O5ueB33bbrN9I3GLoWwYaHw5UkWLL6evx2E7Zsrmu5xb9Dpg6/B7tRVL07gsA/Ua+HeWMNw2unRl95pbsbJWtX7tSpO4F+6V5Tt9qHsZzCJ+OrJDTsZ27mzsVjFgHAwjsZuRyVIeKZArd0Y6VqeGroecN3ld/i2bSZ1BUYdQXUWQHv0cpfi8HwsXeJcC8kNv0AUB6S0PNjrNz8YR//OarCvdCUWAPcm8w6LbYfpxhUd/Ht4AVr1TSTNvjQvo4mNFBDAeVHVTdcMpWgw+PdGTkPXmFlfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvE10IwudV6H0iEtr1T70/lYAIqDa2cPyCXFvRvdO3Q=;
 b=xsZ/g8DFEtRW8QP+4kGmDc2J+fd91D/sF7mdpuwnLEm239ZhwYXqfeFz01pHYs9qsBi0uwMjBjq/C4aFkqqu5fbI4m0zxuFDqGGjqGVeIFQCDaNYalhFDHxw7VvxJh2ApsGxYjijl3KSRcxenT9ATLy5PO06qFkRQ0M3v0IyJDY9hBPy9KH43QSU0Zndks6TTNJdB8z1XW1/9huUAYayPAhdRQMAgNVtJC08VcfI93X/0isq2GkL7zzHmdz079jJl+m4w2+koWaghyrMdlzUpKYzLxXMBwspLeMdGUmCHUYPYafr8/b9obFkriI+soI6Dndst26gQXEmqGpv+TJuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvE10IwudV6H0iEtr1T70/lYAIqDa2cPyCXFvRvdO3Q=;
 b=UzVzCao8/MjPhu0NOVCpmlIa55FzKNEs1IMK9V7d/Q7UuKmesxSHQKWRadJ+eZFYWOGVGPI5Hnv+s3+7tQAwgOT+eOHI+mnWtT3fgeMYK+G3JoL1hbcAIeIpPRi6RJ/UJdwpS62W1oPVbuPl3L5OKhAXNR3JYlyvcH+Jppi9Rk2YW+E8FnqOB/ZiDZedW/hkw7w053Rx7JAve00f1AOyMYIBI2kvsLQABfXMpSK51um0F6Yq3xaxFMQt+NdOntrFF3NQEvwNnKWmlbPqY7f2e2uxwBb13DAWePHQqa5/SRq85I3cqRb8gW7q/qAGzdoiOBveioznu4THtJvHTJoHoA==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB8P189MB0952.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:162::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:33:18 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:33:18 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
	<robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Dent Project
	<dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Thread-Topic: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Thread-Index: AQHbjO8caskJTxThsESplQo7JHQUoLN3WbyAgAT4m4CABkpQgIAADxwA
Date: Mon, 24 Mar 2025 17:33:18 +0000
Message-ID: <Z-GXROTptwg3jh4J@p620>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
 <Z9gYTRgH-b1fXJRQ@pengutronix.de>
 <20250320173535.75e6419e@kmaincent-XPS-13-7390>
 <20250324173907.3afa58d2@kmaincent-XPS-13-7390>
In-Reply-To: <20250324173907.3afa58d2@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB8P189MB0952:EE_
x-ms-office365-filtering-correlation-id: 3fbe56ed-a52e-42a8-af0b-08dd6af9f71f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wfJ4FPzR1r+MWTI/9LSJLD4yNYGffQRFQq3YJ4L/oWgZMkDullLq3eSUarQ3?=
 =?us-ascii?Q?H7xECwA4fktnar7SDbBbTdxWWo98DIH7di5YUl4fG4tC1VDKNr7KMdwwNqfr?=
 =?us-ascii?Q?CKNgcMTD+h2oI6FLdFTVRYomHvp8tjKcXAjQoC1pFFsH6HVVChU74vky9YHg?=
 =?us-ascii?Q?h1o5FJ9TE3T0KWvgl7Jls13J2SpEtHa6lVBEpHpAqcZmQ0xvhs4RHfNDvIE4?=
 =?us-ascii?Q?IKXfQ9uEri5Ybm2ALFatzi9wtY9Mj1QZST20+aCMs4AN5ClJwA3Hz22LyHgJ?=
 =?us-ascii?Q?3yKdsO8xDVekPP5DSOJzylKB0LOA0uZAsXJDZAUOhVeXgTGuifmaJ5gz2DrI?=
 =?us-ascii?Q?PgPa7xr87ygHIQjPP0t2w98dL+FDrEfSYCBfU3AR5WUmIcV1eOda+6sXXktm?=
 =?us-ascii?Q?J/pcBVqa4aMXaaMIyeXBaNC4X90uWjBpE+3bsQd21/HEWrIkhpFdHXJlIS7C?=
 =?us-ascii?Q?PQxS6qkP5tenQH2InknWVYZunOsnxJ/oOLsEBthiGJhFrI60fHUwggOP6mAB?=
 =?us-ascii?Q?76JulrAbq+MZxICWdAgcuAxGlD5APAKT+XI5NdEbvGvoSLJoMjyZzBnotfOH?=
 =?us-ascii?Q?+tRRDTzqMMK343iMx2SbM8iJ9uVvO7Y9TvT5JP3sEgCF4j3JjN75hgCV9lHb?=
 =?us-ascii?Q?DcrZjiW6XnkQSfYPbUwUBw+SLUmXZtrIoDtA/5C/CA+bdJ3hjwDCw4T3p0yI?=
 =?us-ascii?Q?/X6XSkuPNA7bL36UqxiODeF71aORh6ivIobQiHlObYha/mNl/Z++t3XH3iJv?=
 =?us-ascii?Q?TUehSQPjqYfRwhTF4/bWNmcW5SrJiIV2yneMaIdq0vk+2Y8tf8jQk3k1DKnM?=
 =?us-ascii?Q?/FQNPaDbMHJkb1ywWgUY6r9aHrB9RZEBGAi/OpfdtzrIXVSAxxkVE76qdSja?=
 =?us-ascii?Q?zJIq83USAIKkJxjvawblbgBgg83A2m4XgQj772qtWri1AMOKjFflRKQUE2Hi?=
 =?us-ascii?Q?Z2URLgPe+i04IvGCrrWuJCWf4qM34tiRB+fdhaQIGtQ7v0IEs0exAcw9hQIe?=
 =?us-ascii?Q?vOET+iu7cU0bpNSQcZbZf80Hm4eRkEhN5iwLuxn9Xqpa76K1xMyyw5DktLr+?=
 =?us-ascii?Q?7e8GNX+uDuMBj+f8v2I4GHo++fJTPhqbrWAkU/3y0P1CCxk37ZEXJedvj4Kc?=
 =?us-ascii?Q?Zrq3ah7KeNg3mKbx0UuK74QsYTIaacc15tcjmvOiO2gg0+RgSePOs9hMAQWZ?=
 =?us-ascii?Q?UasMGxwTrV9+7xQ7/XBfghK5ePHFcKaL3m5pFnQ7jeD1rAreiQieqH/ieU39?=
 =?us-ascii?Q?SqanyPRXxZoQO/t+9iALow8ThJeqsGtTgR/zOW+wRe7i9YgOlCgrrAJwbbeD?=
 =?us-ascii?Q?qdhU8ViuruB/AcHU0PyNG4CNwZDbhi6JBsgYzqWsX4BTTPW0IGDaiiKdoI8/?=
 =?us-ascii?Q?P1kzIr4QQnLEQGvhC4kN4DgQ5Y+ijcPwHhhTyB/Xgvcr/MbDgnUdvsXAk93K?=
 =?us-ascii?Q?Gy+a3Op5INKQPZDpJSCoZucnOVd8UXsW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1iKPQ5CA9C5aSTMBbZtWXqbVM7YYRpzQzuj10nt5v9xWH9o94fe/HRlDpVT9?=
 =?us-ascii?Q?o7h/jfKZaeEuUL35zX+h9KNkTpb3cTJUfPzFBPhtOB203V8qGw2E8fsHbTk/?=
 =?us-ascii?Q?i5OAvKS6ABckt+sNDv+00wEcVhjq7FaiqTNSO128Ds4Ayn/z3XDdakIqMwyV?=
 =?us-ascii?Q?1caRCSVxQx7M3B+EZHWR/UeccnQpoy9zXXEGFmOKsxjB3cP/OubmghnApNAM?=
 =?us-ascii?Q?nDKuRhvnqpHcIdWy8YJIcYnaXBJghyonqJuuEAESYQDjtui83ZFmYovJJrjr?=
 =?us-ascii?Q?ViwW4hDipUIs6DOF5ONN5AOIwKnMWEmgVtftZ9byUFo5BIjilJ9zy/BZuxOb?=
 =?us-ascii?Q?lWuhYX8Sw2fZxCRshxtgCEW722OzFXsFqb3Ni9XKPXuBU6nG3GKbbSpG/GU6?=
 =?us-ascii?Q?i3TQja+tawW+F3ezf7sKQa5xe4qTDblSIldge+HEbeQAhjE57UjeG2wzZRBD?=
 =?us-ascii?Q?tHENmiHxTN+cBIYhAJsU0/Vg3VWijScNw7BzVgz76zwd1jYylpxj7HrWT19R?=
 =?us-ascii?Q?cSJm7VBRX+x5uz++BJqJGybgdopx4DyqSTONXHYvX4Tou8TyQ14GQTAlyGwj?=
 =?us-ascii?Q?/0gDkhi8v1pTdGL3644GR641wHdf76E48nGzeXWGyBTxr8wep8Agl9MI2WH5?=
 =?us-ascii?Q?fxsqYL7wuXR2IE2PPJ8bjDMbQb82BNPcNcqZM55xFQGado+kcIgw9Smg+0wH?=
 =?us-ascii?Q?4kJp66zruRsBKaNhnCD6WhHXfdJHHtX5twSHW9+Fly5mzv3//CCFO3WZDWjS?=
 =?us-ascii?Q?b5YnGN9djH/78M7B8MU6RlzvNIIi93ZG47X2XnrbRHxzE2gE2OGGeB/TcP44?=
 =?us-ascii?Q?OuZhaFxI+15Q6Z8+uIVndfk6My6+bKaoxnW2FzeNhDj1y0K/h14JhzfnutVD?=
 =?us-ascii?Q?eB+rYw+W2FMEhnd8QxMn17busoLAWLooJgo15zSlm1+J6r1CmxCNFMHPcoAQ?=
 =?us-ascii?Q?JXM8kQjySA5uTktFhVECH/xr8bk+jGZGFelUlTKv5kPY7MqtBP/1lLm3iWir?=
 =?us-ascii?Q?kuoTlHduNFPYOrEH9QvgaiE9yTh5O11AtiffjtoGQsHdxw/JyfIegzM15sOY?=
 =?us-ascii?Q?qGqGQPkbPy9CgfpsrNys/WeeUtDHVNfvoNVf+pyd1vZherL8rRD230RmYbv1?=
 =?us-ascii?Q?xxQ2zRQNHP5QsrU6VbjamnMLe3nTh5gVZrpbxlX9yEh+WF6Qx9QaDjKmuWU/?=
 =?us-ascii?Q?C3uslNFChe495IHSW2M2eyZ4Sg+jeKQpi8Pt3Rm+RYJ+A9IHLp+XY01OIJeL?=
 =?us-ascii?Q?7qLbjP6SRKj4qFx3QKD9q2W02WXnfE7XfEQIcfaPEJZqaMllF0LWZuuClcOS?=
 =?us-ascii?Q?BrmcsoCToXcIWe7bpCaajZiXk3wbFECqcm8qYXnQJ3viUeIV4bFMvbemBTGW?=
 =?us-ascii?Q?x1LmMZ7EShOS7Yw9Fsn13MTfnE3WdQ4HkDEjVEC05QTZSRGCHBXbhO/DD2Hn?=
 =?us-ascii?Q?PclGDw85H3TI4wSJg8aDsm+V1018KA0VN6k82XCZro+Q1iRge4U+1A97hYXQ?=
 =?us-ascii?Q?pjsXbdj1w9RySwxEGrL9DHAW/cnZt/D/fV5nsvvkfgAjaGPCluO4yrblg3p9?=
 =?us-ascii?Q?RuTFUbwi9Ndce0V7Y99OubIQLcqTGM0SyQ5FKhc/m6GNK4ViBYaUkwnNZpd8?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45C82789750E704396717BD19C2F7D23@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbe56ed-a52e-42a8-af0b-08dd6af9f71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 17:33:18.1577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8jVENFCB09QX6zJ13H59pTpVSh5TPzkgDnmkG9GePIdTjlNxzMlrcg7e0yXH8YLZntuWntE0P36LIFdrt74Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0952

Hello Kory,

On Mon, Mar 24, 2025 at 05:39:07PM +0100, Kory Maincent wrote:
> Hello Kyle, Oleksij,
...
>=20
> Small question on PSE core behavior for PoE users.
>=20
> If we want to enable a port but we can't due to over budget.
> Should we :
> - Report an error (or not) and save the enable action from userspace. On =
that
>   case, if enough budget is available later due to priority change or por=
t
>   disconnected the PSE core will try automatically to re enable the PoE p=
ort.
>   The port will then be enabled without any action from the user.
> - Report an error but do nothing. The user will need to rerun the enable
>   command later to try to enable the port again.
>=20
> How is it currently managed in PoE poprietary userspace tools?

So in our implementation, we're using the first option you've presented.
That is, we save the enable action from the user and if we can't power
the device due to insufficient budget remaining, we'll indicate that status=
 to the
user.  If enough power budget becomes available later, we'll power up
the device automatically.

Hope this helps,
Kyle

