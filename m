Return-Path: <netdev+bounces-195110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750BBACE0C2
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0541B3A2473
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB1290098;
	Wed,  4 Jun 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="RCFtnDYQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2081.outbound.protection.outlook.com [40.107.249.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC26244676;
	Wed,  4 Jun 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048823; cv=fail; b=n+0A6Yxv22AoOyIQ/Rk22OSEydKAyTesu35AUpAE0F6Zgk4B0LNFiYASxGGFLY+0NCDMP0XT1BM8svYETBqVgAkokV6iTpcw/SNDPn40GZ1AfrSuBlUblg2NUKtmu/JamKO62oVPzAshUMC5qSCMTGl1NVDWwOW3tzJI8OwNdo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048823; c=relaxed/simple;
	bh=/rmhwoBz7/wWG4D2gzzP43QBzyUwpx0B4AwZYCpCOPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5/IqiQo7mdByRR6RNG6Jpi5HUw8i1D/Sek4ZcXq19HpAo7DePrH5dZy95GH9hD2V6MRt4uEK3GUCgOijzk4FZj7N5dfKnjS4inMrlfo3KzdZdefQ+tx6btGueP/jTY7Nds4TCu5TcE1ZkZV8F/qE968kwTtAy2EwBP5TvyL/o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RCFtnDYQ; arc=fail smtp.client-ip=40.107.249.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaYuQbIRq2mamGYERt8kwgZI+m4fqJ2+MDZEsNDKFW1A69fSUbdPwE45O8itMV0rWDnwCuYovGT+yMVdqGvt/XIpQtppxcOKn7GZuzaVJobj1NJR+dIaudxq8Df1wd6eSJa05UEp1UvR68Fnz5/L3BkD1J6ajjrxqEh2nOs6hE7ltZgOrnsTLTV/pIANREMUsz69uVA90BL6hd0O3lM+KA3qOY2IBgnhozBWAbrAA8di0tJv7fWJcHwfueJ9ykWsye31ROhb60ryicASvunhJLmILD6mADzDC4cU/uMaPPodp1cKBK50EUI+AsH3DibGHTntN4ETz2OS6cUYCzcvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsHwxfnQSX9KSjtn+0dEVGhYSb419GK95EGNlnYh28s=;
 b=YCOfz2fUg9sjXM7bwWk56hGaXp3ycmvnCTuo/oHm12tutstwGoF6RXxpfGuYsa4mQCjPgICvwywHx1arpkqFB5HhfMg5CLPat2dSEtRJhzV04ju4xuyH3sd/uuGaMm4+aTqOy+Dp3DIohwjIDD8qRhfsvD+NxlsVnK4s6C3SALfBTi/Ad5TuoJRJR1eZ/1FZ4J2d3Tqr/v3UJCHqvymMYMJxiequdWuHuFVs6bL5qO9KXGfCRycHVIgqatCtAZCVt2Zt2NN9CzkkrYo5FI6qyYMMQK8ueIwmBHTKcGsJSQEy6Q3Iu+wDJqR9ikfz4ar1cjINIAXTOP7ZqA+ArRGvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsHwxfnQSX9KSjtn+0dEVGhYSb419GK95EGNlnYh28s=;
 b=RCFtnDYQMOZL9jQnGW/2HbCz39lxPb4XiBHo7+hbdHIOOMcYt8aeobXPWo2ql/iqzTJ398gNPsPPochMAEJsS2lVSlKgX+WNkFSOfgpZuZaSCTmD0P9py2ccff0AqsDuEyh5C1CEkVLrrz4uKgZJo0bd5UyWXlGYUccVEdgcNgjJTQaHx3Q0GLifW2tkgFGB5kWdrfByRYFi8dmG0VrqgVRAWSiqSILCSzUGRGXzEzzVcwvxWWKgDo5r1ZskqNhN6am07AKysIoRDdG+NyV9t4o/YTe3m2p6spw1cZn4xiyX218+kLaTtWp72QKb4S6FkfxXXR08MdtZnx50lscZ9A==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GV1P189MB2146.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 14:53:36 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 14:53:36 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: pse-pd: Describe the
 LTC4266 PSE chipset
Thread-Topic: [RFC PATCH net-next 1/2] dt-bindings: net: pse-pd: Describe the
 LTC4266 PSE chipset
Thread-Index: AQHb1NvgFhkGlGOpI0eq40hKzpfY+7PytlAAgABg2IA=
Date: Wed, 4 Jun 2025 14:53:36 +0000
Message-ID: <aEBd4SMbfFOx4YHE@p620>
References: <20250603230422.2553046-1-kyle.swenson@est.tech>
 <20250603230422.2553046-2-kyle.swenson@est.tech>
 <20250604110654.52dd736b@kmaincent-XPS-13-7390>
In-Reply-To: <20250604110654.52dd736b@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GV1P189MB2146:EE_
x-ms-office365-filtering-correlation-id: 7697afb3-6046-4738-6092-08dda37795c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/s3zxEQ32N4FNMyR1OKg4mRv20OpUMgk0FXIpzjDBzQG/MkSokPeq3Tm/c?=
 =?iso-8859-1?Q?fnQTb1TZTwI9xq3GEp2vMrQvL+4jT47S72RD6eDE7dVyYGiO/4ujypssLj?=
 =?iso-8859-1?Q?j0KWszFY+l6ngDVXg34hQ8I95NtRwEfRLKSdng/7B9TMSBm7aYhqdz+DTb?=
 =?iso-8859-1?Q?JPBHNxz88a6ERH3zkTIV/ZnQ6uUXarq27YkaAfBJ4p3DRdex9SON+Qx6b5?=
 =?iso-8859-1?Q?d89nX8lkLrIucW5KH6rtEH9VXR0AWNEp03R7XdyMqBq6crWI7+wTvyzxEU?=
 =?iso-8859-1?Q?MvitFf4SA47q5Jenahsdrgip4nN1e8oxLKumFo+VvEQj61Nj8qj/9Nt66z?=
 =?iso-8859-1?Q?EiFiHQWo4Ex6cmzaASPi/chG9JMDjdIp8r+MfrvxDzX5PUS3mJJRzGe9c4?=
 =?iso-8859-1?Q?LgbMBqiy2YprdE94H75VLuXw7I+8oAWXK6afmAhRh6Xvec+wH+JMe46w1H?=
 =?iso-8859-1?Q?zzjJusLtOpIurKBcfe6IW/97Gz6xNQmDpUlzmg8VLwU+7smyy3GqlQpCrl?=
 =?iso-8859-1?Q?crwG+wEqBPrjZP12Zvv1e6DCxnRvOBGM8Kby2An6Gm2Pe81+ZAmkSepkEB?=
 =?iso-8859-1?Q?Rdlb1hC10RS5fvmjGM95IgrnHwr5FdCAhG8gOjtAJ4IeAJMcM0N74sQvn3?=
 =?iso-8859-1?Q?D7+EczbnLXv2go2Oji2uGlkfHjMxLNi0XFXIpjfERx5ayNcX5g3E8GfXXj?=
 =?iso-8859-1?Q?ZR9HLP5R4zFCsxbyH+RZMii+dd3m6GYDjGhmFx/xnVLqCOsd2+6xTPl/Cn?=
 =?iso-8859-1?Q?o00qUUnIk3nLhMfMalwc+PEfjzvMa64EhsbR46y4nTb8nREOPjYmRWgybU?=
 =?iso-8859-1?Q?gjz2VvI8ul3KkMQA22qn1jOiVqqYRHUYXHRVqu6g32oBWnjZu6TdhlKYXt?=
 =?iso-8859-1?Q?7VyUX5uFOgp/z3vrUxkFMox4uSo87GXsS4NGsdgKaRt6cT27CIeRdJzjIO?=
 =?iso-8859-1?Q?OKoR0xbsBy+BDNOhNFDj7+Qa/gYkKLDf9FUqLS91f751nex9V6ow6U4nXr?=
 =?iso-8859-1?Q?8o+SdnNblU9l3vPRtGa/C1/MqAE6fbMfFtoObb6MP0kou3Fo5UlhN3Nw7G?=
 =?iso-8859-1?Q?shsEYAWq8uLQLvkDhtnFVao8BBVO4LxFZ93dZu/M3dcfokijBctYoDMI6E?=
 =?iso-8859-1?Q?uzQeAQh0IV9+uD+0/HJeIsVGTuVuJ9eBcKZcAiKNdyliXQk8RkNra+9LN4?=
 =?iso-8859-1?Q?yCcNc9jC0lm1xfiG7A9reTthqTLXeQopiiCLvxhx/VyWvz+NkqfpQBYcF3?=
 =?iso-8859-1?Q?5nD75KU+k+mHP9o3OIM93EGGgyvMIgqYGurWPp8vdooYClQLTQIWMoITyf?=
 =?iso-8859-1?Q?OT2bLRTFTBMwodVx6y0vXaXv3tyfEtMInT914bB1MsBZCAZ9qY5fvVKdc/?=
 =?iso-8859-1?Q?Qx2ccIEISxJJF4X+NJvjTY/0cBjX6Zy2vvgoViOyCqeT9YOtRP2uFOAK+d?=
 =?iso-8859-1?Q?BlenIW2QHQRDZvqyDY6qJXldNWnKRX1XkMOg+sH+n8rTSHKZBPgqwUv98z?=
 =?iso-8859-1?Q?Z11Y527BcPq6NoQXbfcvXjhPfQx3YAyFVNDmL779CWDg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fJU7MxLWkmURSNpg66pE322rQMBxQI0jPujsuIzb86NvAhRXbLohX9R8GV?=
 =?iso-8859-1?Q?5hq3x5l9bhXU4aGLZVvOy0JgXFsJT6l78OoQy5yqszkp4ljhnUfLWHpzCn?=
 =?iso-8859-1?Q?ymNhIWvKYjH9ZF+W90Bqz3mNNS4ntorznImZe15LVtKdTV+A5iAezR9w6n?=
 =?iso-8859-1?Q?R6rhxWAArVR98JYANQPr4s6S+6C6kCNa/n0fubBaB7ps1MoO/ObkOr3jNm?=
 =?iso-8859-1?Q?8ezBVk7VDgGryMRU16jbqZuphQtEVjlRcZS4j4Z7ID/GD2oKx0BdCT9Cbm?=
 =?iso-8859-1?Q?nCJBkbI4SMLKSa6PRxg9E5nL3MkfdNAiAObvHRIpjPO4Ab4gnc3ZM+WMWC?=
 =?iso-8859-1?Q?6PGXZe1zRYDMkwPpS8LoVCJscanwXMCyemriyohffM1Wbeo/J8vBV/ILsq?=
 =?iso-8859-1?Q?76rqSrlFC/h5NZeDv40d+ce8fFimRRpuL1+0QR3tLtqHfD9E3S559WbKSH?=
 =?iso-8859-1?Q?FDw4l3Db1Eeli3gLtFHqAWKpbvJ9e0vBgMfpmhVldZ9KMJayaeyNO87cXB?=
 =?iso-8859-1?Q?KDhizkDWrVSt0belyLDNM2eKxVfvUhGRXRnK7KTrEiv3tVZMMQjXWndCOa?=
 =?iso-8859-1?Q?6q9gDrNua7MNO0XBj6FPYWJyG9aWCnJJ3Z4XRu6QfE4ZqOvQmGrneLSaJv?=
 =?iso-8859-1?Q?PDFfe45uhsbrum7TpT2YkNlSdWVOxf5No67KuyvHSVD83xOwrU5/lgTTiW?=
 =?iso-8859-1?Q?hIqCQdQgvScWeCbT2HZyTF5Cy6hWlv59H5vgqmZTNutU0PPZ5B8dy04rLa?=
 =?iso-8859-1?Q?Zk0XAExtn1nHP9G6lY8we3bCRkUvybywcw9tvF0zNVSXsEGvNl89i+FXxm?=
 =?iso-8859-1?Q?720u3O2WQntR0WJLtGUPSQ39VFcNGkunhlD0dOfzfkdwUK6+O5s9zfx2TX?=
 =?iso-8859-1?Q?dhDC1KfrOPuqg9zCSoV9aYE+qhWffAZ6ak1aJH9joog2nWbtng65ZLb1xT?=
 =?iso-8859-1?Q?u5qsqbDkhx7dEs3ArKybfzd1Z+6svOuKhOmwygA1CEZKk4bztL78JICvFR?=
 =?iso-8859-1?Q?iQ38bDAHghdn6ATFaix8EqArKo9hvmKnc3p1OxTdpo7MN07tC4oNNvezsd?=
 =?iso-8859-1?Q?5PlRLJy79MiISbUK+lKAqM4HK9xLO8+Aq4strcibS3iVfH7Vcrj5E1yTp5?=
 =?iso-8859-1?Q?TOlnqDeFHXc6AmUVk5YA0DIjKRm2+KGHt4WEzrK9Dqd53LGlV1DX/RJvND?=
 =?iso-8859-1?Q?3Uifq2e+TvweKoks1MhyDw6bB+Lo1BY/NtHgnxH6izF6Tx5FM63bIHEJaa?=
 =?iso-8859-1?Q?nt5ClOfrjryv/UYvoeVmL898AkVRUhAQL5jGFOwx4LObXZ7dLpJgC+GH/f?=
 =?iso-8859-1?Q?/CPI6M3bDmO1D9O/QtYcDFf9OqbSmxGFT5wA4mYyWCwCsRY8QQLdTNLEGT?=
 =?iso-8859-1?Q?SDPUDQKJxxuLe93s3yc3jVWi2gi1DuPwI48yTBFLhy7FeQKEBvOX5vsRKE?=
 =?iso-8859-1?Q?hQA1GQhwfyh6YSVNV8vsZZoWuRd7HbkQ32DgQDtpJIHOltoRchErMg9IjF?=
 =?iso-8859-1?Q?dgiPxvi+HlxUCRDcuIK08V1NjB8NuPZYjJRsHG6lQ6GIahsXaMgOuj3vqH?=
 =?iso-8859-1?Q?aYrP+a9TlDEYg8dvbzirErOlVRcm50V17medNJSD4443NlfgAYXV3P0JYC?=
 =?iso-8859-1?Q?qczSXYx+Lk9YfUrE2EER7rtPZIUzr/CVmfP1pjQzDInGJTMXpo8+BSfQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9B086D1A48E79B46AB28635CBF02FFF9@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7697afb3-6046-4738-6092-08dda37795c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 14:53:36.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gr9VXYZMB2EnCKmNiY/xBtpSwKnC2wCg9Oa9ff6oZkQSEQscTWQ+VlQ+K5GHOlQAOtFRL43aLRys/JRcSyYE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2146

On Wed, Jun 04, 2025 at 11:06:54AM +0200, Kory Maincent wrote:
> Le Tue, 3 Jun 2025 23:04:37 +0000,
> Kyle Swenson <kyle.swenson@est.tech> a =E9crit :
>=20
> Hello Kyle,
>=20
> Nice to see your patch!

Thanks!  A bit later than I had intended but late is better than never I
guess.

>=20
> Your Sign-off-by tag is missing on all your patches.

My mistake.  I had intended to add that but evidently didn't.

> > +  channels:
> > +
> > +    description: This parameter describes the mapping between the logi=
cal
> > ports
> > +      on the PSE controller and the physical ports.
>=20
> The channels parameter is not describing the mapping but only the channel=
s
> list. I also have to change the tps23881 binding doc similarly.
> We discussed about this here
> https://lore.kernel.org/netdev/20250517003525.2f6a5005@kmaincent-XPS-13-7=
390/

Oh, thanks for the link.  I'll fix this (and all the other issues in the
binding) in v2.

Thanks,
Kyle=

