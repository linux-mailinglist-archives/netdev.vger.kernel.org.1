Return-Path: <netdev+bounces-135886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE599F80E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4820CB2280B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351D1F6697;
	Tue, 15 Oct 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LcXZeEG2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A201EC006
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023922; cv=fail; b=X1fQS18iArjgsOK9dsHNfKfEA138A0w0gYDY+2QLv19s1KXx54bCDlYI2nGIY06MsJ32QtsDkSnQY6lar/q1RffX1xqan5xv38dyPzQgINQ1k+Ni+B6OcI9dSt4p1ZYNj5JamBG+DtFf4mw9gWEstlsj7WTx9SS1y5BZ0ggC+SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023922; c=relaxed/simple;
	bh=tXFFquw1VVLKdAazygH4i0PMJ2BiQrrxlfuLEnytA3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gcIZw5+HA3fW/8ck5zxeZH0Elv8QzDi14LRE/USjGbMd0KvtJf4FMMrpc19sbELOkc66/uILuI6oseeRFj9/m8XHc/Bgqj9UAaXFhHg2Egr07bWQnHQpARlGzJZA7azlRvN8hYtiG2yH7ekI6IaEnxCz/LBKiAhYNNj7DKydljM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LcXZeEG2; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c39MgPkSgji+8UFMLg/LsDHDyychkDbXmCEhw7n+LE1SSRWH0BrZmAb7zx4E/DOX1tyz2m/8VDWRBvR/GjHt66X3LPZgjiKwkobqSnY5WydzEx55I5yl5nOevNE2RXaCfd1eEyGlUGhhBSBPEjWEGBc3fVZQAYLnTopQlObmDI2FBMayBcvFrQx6uh8TVGhUVBPiJ5vdnswnIx4vJ1xNUFVPRNPvBnbpE9y8CkfBb3CaFg/l8ZRRE3qJwisfM4xEaEQNbjGm6Y1TG8bQXoh3k3TzqIlI1Ol1QgzuVa6MqzJKe7POaLFYcz3jFYkgvrp1dft5w0l+JNxVx5wg+ww0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7OBMKFCQIZIVPWzeG7ACKtGMdomZ0mP2lnmhdgM1IY=;
 b=hx6SqxjKU7qK60GbYkFoA5OGNwNDLI5jPO4s5sKjrERKUzbdGv18BXdfswUK/T7MLCcdub89ZBok8n5RNyQawzbBUh88c+x+wqcqWymXjAKfHGUHIa3+4cHTZL8otI5y6sfVyrq6oFgW+q/KfG55sRJ8ChYUdOVKBy6YnYJ5kxwXOc6Sk1EGiJKhvx7djXxwgJUQ2Ws10R85cd2MtG6CrOTFqtqvdJlS6+N1n/rWlynO2OBQPrIvvUdB+fFRdnA4TAP+01L4hX+krPIbWomAv+ELAvCqUGlvB6bz8ROIadIIurfHoPYqyZjKm3dzYIH/L8fg4sThqMdzirM1JklFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7OBMKFCQIZIVPWzeG7ACKtGMdomZ0mP2lnmhdgM1IY=;
 b=LcXZeEG2SwnBbjlkNGS54aPB6Yf7iMo/QflVa6NbPW8FpRAAKL2Z6hl//VeAgLz/6F+omYUGWnZ5bk+Bl9UDANtGxptVcbr28x5ebZHuU5H76RrTdOiCdybYG6rew2b1259viMqbGBTz4y2xW7WIAPbGlx5MEoqyO3Si5W0N1WQgmtIBnFSKaXQunG7XT2aZiymRbTXS0NNwDI7HZb5deb/egitfVxcYYu0+mxF0r1CeHlWnM8zPsY/0ymWMOw04Q07+NtsjliEsnCFg8kUA+DOWKehF73RfR4pBToKv1hBG79vViuGpfJQlabluZ8/7by1F4+dJ8nn60TNDJiLMMg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM7PR07MB6673.eurprd07.prod.outlook.com (2603:10a6:20b:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 20:25:16 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 20:25:16 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ij@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@CableLabs.com"
	<g.white@CableLabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	"Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH net-next 17/44] tcp: accecn: AccECN negotiation
Thread-Topic: [PATCH net-next 17/44] tcp: accecn: AccECN negotiation
Thread-Index: AQHbHu1B8unU7cZU3UCJTvhKRmPfxrKIONuAgAAH9bA=
Date: Tue, 15 Oct 2024 20:25:16 +0000
Message-ID:
 <PAXPR07MB7984AD495ACF09289D78AA96A3452@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
 <20241015102940.26157-18-chia-yu.chang@nokia-bell-labs.com>
 <4eb02755-8061-6cf7-3fea-5b645e371caa@kernel.org>
In-Reply-To: <4eb02755-8061-6cf7-3fea-5b645e371caa@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM7PR07MB6673:EE_
x-ms-office365-filtering-correlation-id: dde104be-ff62-4167-3b57-08dced577b4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5RTAogxIw/1FCWksqi2eMZNLA4NVpMAkeGpvhKUu5R12PIyBRrzTVSGUiW?=
 =?iso-8859-1?Q?RpIxW5KGEENtn/IY0ACaDsGlzizVFZot02x+7ZtSbaom11O95NMTUEmqdn?=
 =?iso-8859-1?Q?lLl203eTLYalkZ6dmDbhywfjCZtxFwrA0e4uOk3EiBzL3v1rq4KQm4pxfw?=
 =?iso-8859-1?Q?mhycZBsbJ7JxIGHdN//pfgGyTCCP476K5/kDutlN9RQcNV3jIW3IKWAQ1D?=
 =?iso-8859-1?Q?39au69HomYkU/iRnGk1ZUheCfohRvEu8bL1dZ5/ETfRK/5jmemRv9iSkM5?=
 =?iso-8859-1?Q?cq5M5qJvPl+PXlSadKtB3BDUvJ82UZM2ND3JDlRe0E6TSVr4PQXxA17L60?=
 =?iso-8859-1?Q?O+V+/FEOsslV7l6mD8j+zrCz2RmKw6E5JkVdcqJpjOrA/l6CW/J8F5TeSf?=
 =?iso-8859-1?Q?TNilKWjHU2F2lSX+4ZVlVZ9GelVyZSnxD7wD91g3viuH6o+uknyAqvQoGm?=
 =?iso-8859-1?Q?Kp5Q1noADOH2Z/2/7/YIIZxnzoFlVmvkx3t1pLG2YQPlSQcN3A2QGEVkBE?=
 =?iso-8859-1?Q?Zq2qBdQAadbp9kLSDdEta2+l4A9sZAyJuyzE5FnS3JXGznTL1M9TDNrbJO?=
 =?iso-8859-1?Q?u7NxofMv/5//BjPRBJnvOVuzvSgwjgoG3rVUtbOwsDwIuY2ikjd/c1IpPP?=
 =?iso-8859-1?Q?3fs8Tmya3BTmj+yWgfrI4K2Vx4q14D7+Nx+o+c4AZR7fxQ7xnKHB73To9A?=
 =?iso-8859-1?Q?x7HVr9EeNNmLiZ1+/TzwwlLn4sObHjAvt7cOxaMC+51nrqxoueaLccXIK6?=
 =?iso-8859-1?Q?rBfOA7pkLyFOSAOqqH54OY36kAxFoDiXhSUEOKngpP02vhL2sZIraTYJdD?=
 =?iso-8859-1?Q?QKnvIx0l6HHkp5CSMDi7wQnRx8ZT5aAmHuevFSMPiUcjMPHU1ltEnP5s/M?=
 =?iso-8859-1?Q?rPsd8jN3XCG/Wr3iCS3yL26heVDWrn/1GWGn8vEEfN945xeF/NOX2+w3BQ?=
 =?iso-8859-1?Q?XW3CyTF5ECkNckMvuIAcehQ5LPsFeCegu8Srn4ZXrnco5mKYRzsgHqUy94?=
 =?iso-8859-1?Q?4QP6DPin6tpw9qChk5qgDKXAS7ykEtJewTA6vtVR9GfqAGex0wa0gBl0N/?=
 =?iso-8859-1?Q?BQr6oJhPFthrj2/lfAUHydrAY4WGZioCeZTjXLhvBxbokBek+SBGnJGqSD?=
 =?iso-8859-1?Q?QzeMYuddHAQbm7HsB71Ya4X9yjd9NntG/I+BS5X4RcgoU1hHnG0zAR8ZeM?=
 =?iso-8859-1?Q?tUvbRW0THR81H6L5FrdoqplQCK1TdxTmSJrVXl7sN9X0kHobXMmdvYK687?=
 =?iso-8859-1?Q?8ovSfoMnzaoByy8vq90nTUspyeOeXbzm/ztSl7pvowkdc5ZeFKvvuuf+LH?=
 =?iso-8859-1?Q?OJH7HhMqVAlLWuRIaf2/oH40qXr1d2F6LevQM0FRMiCLtaQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o2N3OjJ4L6C4wXWWk4ztGNRNETnvcRmACixfhf+ZeFiVzpi/2RwWzT/ZvP?=
 =?iso-8859-1?Q?5IlCvHOxBEZrJHGiUh5sGd89Gw+vMy5SlBvNLkPFs41Ri5WjCwSasiPMwd?=
 =?iso-8859-1?Q?ygaF3Xb7EHguz5bCandEusuXm1vpmWdyxoyiCb6zXPgJ8e5sjbVmgLWzTW?=
 =?iso-8859-1?Q?Yv28sElOBbe8A4d7pJ6e3tAKHRoz64xX/XOdc4YcN0PiVQ55PoGHJvX/tb?=
 =?iso-8859-1?Q?Eb86drW4ZrTtrY9v7wwcqi+sL7PcwARXInA6bVvjvvjLJQfAII54wvDRtH?=
 =?iso-8859-1?Q?BLdcv0zw/m4h5elXkTJrdNQU7Q9xEC+EV6xj2H4RRibnFgn0VOeYurLKvh?=
 =?iso-8859-1?Q?IVSj6nPgAlbolEnFdRQh99C8uiyDYrNxto4Uq+jOedTTZp4NF3fzohFbjH?=
 =?iso-8859-1?Q?/jr3BHwcYFBtP5QNNp42ZiH2S2IooR0uXJ6Rsr/3RDYC106WA1I116AZr1?=
 =?iso-8859-1?Q?PeYlcGLPyb1PaEahvtfCdoGnXcV0gNWFM3Gtk3gCpetoImVJBctvCeCL6N?=
 =?iso-8859-1?Q?fnubenfVNpYGtU+95KFsvFIJUEnQNhmp5IuCWLebuje91vUqYklUJxbf5A?=
 =?iso-8859-1?Q?Ynd8GUTGsG1zYnUoDiqQOl9EFRloB+/iOsKKSH701A8ADGRuEZSaNpNr4T?=
 =?iso-8859-1?Q?jyKommQGUV25/NNttbgM2IqV/aNf/ipLWvpaJROmVwKFgikqxXvBjM9d+K?=
 =?iso-8859-1?Q?180fTar7WvloAz2HpreSebdu5ooo+owkUIij+A78IwDYMuApzbLvbVgRZ9?=
 =?iso-8859-1?Q?7mA/OsQAkCOVrq7eZQTPS4tYr5ika1D5S0MHshIsXGCQTCTM4nq32OGsTV?=
 =?iso-8859-1?Q?8TzbWIfmeweOuSwpadjUq4CbO4XQfSsI+bJBzeeXw3/H1jkU1Osoy5RZbY?=
 =?iso-8859-1?Q?F1ruEgV2LaddH9KLByRLNj1FhEk2BvqI87X4I7i6X/rzTUnbdM0YO02oGz?=
 =?iso-8859-1?Q?EftbAViUt847pyAwbqWBby1oe4zcCO7bfhCpy9MKqUlQas892NfAxtnjU6?=
 =?iso-8859-1?Q?tk1eJZG3R+6pgMjh7yBh8X7RLLonGdK2yyqJtJdng/CV6BMhQFWZzGqSvV?=
 =?iso-8859-1?Q?3roa+2C+WZOmKoyc4O34daA+l5y2R9wPejg1hzhSdRB6hOqutr78wU6gkz?=
 =?iso-8859-1?Q?1XqHUF3OrWN9MhUupylhvFjNPGcuGIWyUKnPGW+3dnU0LRGMwCLWq/kDWB?=
 =?iso-8859-1?Q?T3FQSbghpY92wSnzkbBPzj0wB5cVCo9o20p/soFJhKJbFnHadSCIR0HWqz?=
 =?iso-8859-1?Q?mRt/fM53STQ8MEV0I3keLvh5v438nrDTChYJd/7km7oEtCos2GDYCXGqhj?=
 =?iso-8859-1?Q?s4VA869eb8IIG858IICXCaR/R3QOJtqKsWcImOAkFWZ5vGTImkrgRpu0N0?=
 =?iso-8859-1?Q?I/qoa+SALhYEOfjBH1CEc0qLaGzuQOLlpUXtoFKcjmsgY7+7y7B7+i704+?=
 =?iso-8859-1?Q?PCCjz7pIhHWnrIwHaMin8YBgXBmNze1UyDlEsU+KVCTY/R397jKe4hSZ/3?=
 =?iso-8859-1?Q?l86WNmB9wksdxmPmHIuF8hsa2/jjqaYRq56kTToDgjo0TPgVZPpf8KDW5k?=
 =?iso-8859-1?Q?4M4hccNq31NzxjBOVzObGiHSrLidSDnNtGoPwFJMxNYZ8kP4bjKT2PQZ3G?=
 =?iso-8859-1?Q?+gCUC1/8KwBypNdtya2ks4CU49lsP+sHZEbmp+o3QxzEp+oCe/rw2+WA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde104be-ff62-4167-3b57-08dced577b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 20:25:16.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e42Ye/i22GFvu1noDh7dpZkCA9vey1V5jr0gVMdXi+0qxE/iynRBoCp4z4VAVynrHF2gueyHjFmIdSahUe8TiH61cdaSZITjtgAumVKFHFro6UKvePhpyQZVQmyCGaX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6673

-----Original Message-----
From: Ilpo J=E4rvinen <ij@kernel.org>=20
Sent: Tuesday, October 15, 2024 9:50 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) =
<koen.de_schepper@nokia-bell-labs.com>; g.white@CableLabs.com; ingemar.s.jo=
hansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs=
.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com; Olivier Ti=
lmans (Nokia) <olivier.tilmans@nokia.com>
Subject: Re: [PATCH net-next 17/44] tcp: accecn: AccECN negotiation


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Tue, 15 Oct 2024, chia-yu.chang@nokia-bell-labs.com wrote:

> From: Ilpo J=E4rvinen <ij@kernel.org>
>
> Accurate ECN negotiation parts based on the specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Accurate ECN is negotiated using ECE, CWR and AE flags in the TCP=20
> header. TCP falls back into using RFC3168 ECN if one of the ends=20
> supports only RFC3168-style ECN.
>
> The AccECN negotiation includes reflecting IP ECN field value seen in=20
> SYN and SYNACK back using the same bits as negotiation to allow=20
> responding to SYN CE marks and to detect ECN field mangling. CE marks=20
> should not occur currently because SYN=3D1 segments are sent with=20
> Non-ECT in IP ECN field (but proposal exists to remove this=20
> restriction).
>
> Reflecting SYN IP ECN field in SYNACK is relatively simple.
> Reflecting SYNACK IP ECN field in the final/third ACK of the handshake=20
> is more challenging. Linux TCP code is not well prepared for using the=20
> final/third ACK a signalling channel which makes things somewhat=20
> complicated here.
>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Ilpo J=E4rvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h        |   9 ++-
>  include/net/tcp.h          |  80 +++++++++++++++++++-
>  net/ipv4/syncookies.c      |   3 +
>  net/ipv4/sysctl_net_ipv4.c |   2 +-
>  net/ipv4/tcp.c             |   2 +
>  net/ipv4/tcp_input.c       | 149 +++++++++++++++++++++++++++++++++----
>  net/ipv4/tcp_ipv4.c        |   3 +-
>  net/ipv4/tcp_minisocks.c   |  51 +++++++++++--
>  net/ipv4/tcp_output.c      |  77 +++++++++++++++----
>  net/ipv6/syncookies.c      |   1 +
>  net/ipv6/tcp_ipv6.c        |   1 +
>  11 files changed, 336 insertions(+), 42 deletions(-)
>

> @@ -6358,6 +6446,13 @@ void tcp_rcv_established(struct sock *sk, struct s=
k_buff *skb)
>               return;
>
>  step5:
> +     if (unlikely(tp->wait_third_ack)) {
> +             if (!tcp_ecn_disabled(tp))
> +                     tp->wait_third_ack =3D 0;

I don't think !tcp_ecn_disabled(tp) condition is necessary and is harmful (=
I think I tried to explain this earlier but it seems there was a misunderst=
anding).

A third ACK is third ACK regardless of ECN mode and this entire code block =
should be skipped on subsequent ACKs after the third ACK. By adding that EC=
N mode condition, ->wait_third_ack cannot be set to zero if ECN mode get di=
sabled which is harmful because then this code can never be skipped.

--
 i.

If you read the only place I set this flag as 1 is with the same condition =
if (!tcp_ecn_disabled(tp)), the original idea is to make it symmetric when =
setting back to 0.
Of course it might create problem if in future we change the condition when=
 set this flag as TRUE, then we need to change also here to set this flag b=
ack to FALSE. But if this confusing, I can remove this if condition in the =
next patches

Chia-Yu

