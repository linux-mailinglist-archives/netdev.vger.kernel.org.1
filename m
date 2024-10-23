Return-Path: <netdev+bounces-138380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822E9AD349
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 19:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028F3283664
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2D1CEAD8;
	Wed, 23 Oct 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Igrm17If"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A481CF5C4
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705860; cv=fail; b=CdpGlaeKhfKGdyYGmSnZaE8+XW27JxgkNwjNAdXnFoRNc4jCG3kUHUN0e36Kzcr3hToLFwqnSAVEe20ypnCXakAh1eyQ48JgFP7XcTQXawcatUB8n3c/WVs3xxIR7m8fJNwcgumL2zJSaOrKl1j99aESr+GvO/DJmWmADZw7Wfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705860; c=relaxed/simple;
	bh=jlK56n9g/A1OQLxMr+HgY3i6e/xFzk9Tbl5BkFMdQho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HMsm4z1oWrVdf3o3hpFosq3/zMnfK3I7LUBN/EQO8mvfXwFcO141/lVJKJq+0rs/17Tp6AQoyYal73f/gUE3vfyGF1DTl3PUBsDkjqHT0QqdUmfEyimuzNvPMnPfXFY/N4Wi/pINSxWH7ZLhXr0QpnmiLADCGagslHogXeg7XFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Igrm17If; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0LXMNcmfR5q9Pyil1msm4ZOxekGFSlXWeZD1wWEynCwSnZpP/tyXBinL1JQowxgShc4IaF/bg5Gv9mAT9edYZBymsuP27HAEQiNIRvuUOsb6CI5IsNBLJFkYo+jV6IzyHAPBEOM3oNFnyFP6H/uxncAewy3BPRt20oAv5zglNDEZCJzuoRMxDnfC96ZcZQTRsHh30MxTBKGYrzBm9MnBwncrX0HHYkf7SisMQbAqVUToRaZ7ybpW8utx1mKjRNKyW998QVVymdo/9dEABviD+QIOv9XhnbLBC6OzVbviW7tH/U+0nbR9wan/Pic5u/23vpOVItQ+styLIA1wi2ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqzn3jUW/UIoYgsxqAgj3PyjqXixG6XiJts/JVkOFkA=;
 b=ph1/Z6OQMvw6dFVVH8E1Du5uD3VHn4AGe5+yDWB8ZINpQYACEzJr9JjvsBq76wrlHmlOx4LOkY65+j1E03auaZDobdrfivWfuOsCdRLjMDjq5HbVRH+OI56zfgQQx+DWWix8NlhoGRMLN8Xme0/v1Ir4eeGIUxwf/Sr07O89X2Apb6pkXL3VW2MtO4CM/Vq0AH6zzd6cJLiOyyd6uBBZZT9/Hm5DXJ63PUVtsUMJtvf99wT+L/Tg3AvaPrf6IKolGi8+jViGB8n5fHa/lAdPt83L2v+TdJI65GEnlJRc0eV4LLl2GTnfcCS7V0rq9mCsKwsA8U9lmGaYhIWOrD6lbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqzn3jUW/UIoYgsxqAgj3PyjqXixG6XiJts/JVkOFkA=;
 b=Igrm17IfCuwUrlE7fj5BevX4+4de0aQl36I0MIPory7KMtmt2F3WDYRi2h/wekhGDkjPE+nQz3BTd5HGtZxeZZspM//fqiIlzvdc0EUKQticn2t9V7xczy9e7cQEJywbv0/PINlkaT+YOdOTLKprl4OeMyHt+6OJO0M9DO4QFeG6KCaCwCzBB2Iv/Epm89e0QBjsm+/RjJDXxsYZL5uLHEyzwLigudMsXrrXn0mCxUp/C1Kygtnti8dZCJmhdakvJDlwac9ru/ydYc6dKKJ6X8JPMO++6tB8ZR7xlUYmLy/GXMR3iVizCKsmBsnq2rKM3YqqXuMSscdErWSXFgdeog==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU2PR07MB9450.eurprd07.prod.outlook.com (2603:10a6:10:49c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:50:55 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 17:50:54 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dsahern@gmail.com"
	<dsahern@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@CableLabs.com"
	<g.white@CableLabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: RE: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Topic: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Index: AQHbJTticBa5P6qOSEWwIm8LY6oIrbKUfJuAgAAeloA=
Date: Wed, 23 Oct 2024 17:50:54 +0000
Message-ID:
 <PAXPR07MB79846CAD5665BAF46699C20BA34D2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20241023110434.65194-1-chia-yu.chang@nokia-bell-labs.com>
	<20241023110434.65194-2-chia-yu.chang@nokia-bell-labs.com>
 <20241023085217.5ae0ea40@hermes.local>
In-Reply-To: <20241023085217.5ae0ea40@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU2PR07MB9450:EE_
x-ms-office365-filtering-correlation-id: fff530ab-fc0b-4172-b31d-08dcf38b3e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c+BetjcIJoYPb2TK2fbQnLLHkxWtzvU3+iXstdRM4Kmwvw71L/ZzKdEmvUz6?=
 =?us-ascii?Q?AL9jGehqOp5W9Of3tqfeN0/xOFefskLSP2F+Tr2+/nIFDLbh1zRQ7A2rVjdK?=
 =?us-ascii?Q?5VTbFtBNq8bzZ4LHPlH/9Pb9BKVLvBhmn5bz4rHcCGV75sKgaq8H4PfvT/A6?=
 =?us-ascii?Q?e3lBzhUaFwJGKf2PVRgFn0KZa+AWBo5YSVmS1XJa7Nre975ojxcTeoyAzoqt?=
 =?us-ascii?Q?i5RZK/rX3Kd1RQT+gHrtplRNGh3FeA9jkkqiIJqhdDTNIuWI8KViEgjyAT87?=
 =?us-ascii?Q?qCIqbyppt+ymSUvwOY4FzxpumLFmamVVFswujiXaGVVHxKcNVY2hKKsn1/zq?=
 =?us-ascii?Q?7Y+xsDafF/Kfj+JPjahfLMyJ93n0fxamHcNt6HPa5LaYkb11S3BxYbotPXla?=
 =?us-ascii?Q?9PdcBGUWRlTCxz84mCbjIZu7qWQi0SUpDdy3S5ezJ4Y94QD6ja3z0uFeFkiy?=
 =?us-ascii?Q?wIcF5J/zXGN2d+X7GwpbqhGEnwyuBgRQP+P7OhJ/bp0qJmFttWd3UWCZ/2c/?=
 =?us-ascii?Q?oRAmqOc0p2Ywxj/vcvIp/693LR3aZ0EtU1RHBdCiXERIhNp3D7D0/QLZXKWg?=
 =?us-ascii?Q?Nk3ylym9T5bI5iyyoDfYx+jVous7RM/N5uM31vx6l1fkqzxj+dsjLNVvH7f3?=
 =?us-ascii?Q?kD4W11jq6dJ9AT8J7mD/iDFS9ePVf7VBfSG0qTtyu8jp3Kf1i6tWzyl6aTCp?=
 =?us-ascii?Q?lwlMo+xo8WlrfHyPJ5YcpJEtPawCAbpRqr8W2dd+ZhBKcJCZQDdbmFxnwBXj?=
 =?us-ascii?Q?N6N/uu5e/nnie1PdpyHnbxZHeTrLQzY3gSNJaJb1nMk/zI5XVoHKpt1wTiwm?=
 =?us-ascii?Q?UYkgNwUE9wqa2ivwmS8kxUGmgDK46jnvYXr25fKkWMIStCXKikHHWHiU+LuH?=
 =?us-ascii?Q?FgwMV0eCDTrhwyykoYZGj1k72HbEoNBj2QGAKn8tsYDlpwwn9rXE1qw6VvLx?=
 =?us-ascii?Q?QlgXxP6llplF4q4xnLAkXLy/FbRoPRtXoW1jwR/gvNBivxaM5CbP3F4U+D38?=
 =?us-ascii?Q?7Q166dWRGyF6G6lPLZWF87LoC7gO2gWV4Xt1NZZgvoqKptOca83Nj2RKOv2b?=
 =?us-ascii?Q?z3898K6+TxofF1PX3ZYw8oLeP9E1zGU8tj3tDB+iErrheM2sE7MErFiVYFpF?=
 =?us-ascii?Q?DvRuzRc1OMeavGdYQQQWEWctI/xL+HC4SKOHbb3z7J8pTnp6NuECKzsCFENA?=
 =?us-ascii?Q?Y2ADlvxNL9sA5ERRIrdCayuItroHJ0441gClsCf2tQSCWbUbFuoz8ThgJ9AH?=
 =?us-ascii?Q?a+UttEljIxCKtOjuZTCEWK31VUZtN1viEpwfZLdURsWRNc2GOS3BeDQMneGt?=
 =?us-ascii?Q?MVpVI03Pe2WTMr/IZnMJ7iCQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z51IjnluTftpmWMMxg7Ml/D0Z579HZ4JJZlNIKvf5Iah20f7c676ow2vGbRu?=
 =?us-ascii?Q?X79jDo3CBbon7HJjA4jTJXP0yeDz3149wT49zUpw8UW53YXjtnTJFzvSzvNx?=
 =?us-ascii?Q?SR9lLxnRUy9QIh5iMDpr3AbtK4FHEU+ijdxTs72y7Puu1WsA6Jj9qj/L6VXm?=
 =?us-ascii?Q?lDTlusAgiqpvmWfW+d0V79PMCrhenpdgJfhh5sqov2dhgbT5uWATUVB78HDF?=
 =?us-ascii?Q?sIYbrzl575aAp5KTGdzdn0UMRtatvbHNLeb/tO2PZOsyyEOKo7bfzbE9tD2f?=
 =?us-ascii?Q?Zc565SahF+hlfHqQ957s756791DlM9Qyu5tFnCngprwz9a8ani1UMANnfTz0?=
 =?us-ascii?Q?Qk32900RDCB5wh8Fsin0cRxCgeMEkQjINAkEphdVsi52ZkoMd44qcemt2eRg?=
 =?us-ascii?Q?vDM1RQx+mGcEXzF/NZ/Xr50Jkhe9gtabEzVjXXBwo+bENeD9Tvi5KrBySzV4?=
 =?us-ascii?Q?Dq8y54vMJ6wndiFL+PkLkEKkmb2JLAexA+VDwnj+FT1841cuywPLGk4OWFuc?=
 =?us-ascii?Q?3KLhhoj95zGUSXbSgFDYEx1J4934hnoM7DpM6tE8/ZTAQynGBFsjXMhu1HZf?=
 =?us-ascii?Q?R7kMNiCeRMDpsjKDFBAnK8f38KHVg/lkhst5hym7d/OsKI3GJ5dA2vpEF+Ax?=
 =?us-ascii?Q?aYGI8Ot8fMzdDhG1+TCGTF3zwx2i00wumlCqs7BRNN3PXXVDGdReUJcSGC6c?=
 =?us-ascii?Q?6W9dZWVsd59FYhT226Omdn+uc2PDNk2Wwhf4rZrpnPLtCdV0erMxAQjf0DgJ?=
 =?us-ascii?Q?t1W+7yTrNAU3dz+UKcdXe3TJv5FUQJ7yc90EPddytUfRavYJHGQcvxXanPob?=
 =?us-ascii?Q?mMzs3iyvmt8gesFUIlUxPlr85drgL+aEvjNlo0j93bGjeppZA3Ud9L2HR2gR?=
 =?us-ascii?Q?u8hA7f8fQ0aHCDVnLI/D3nJgXvmX/oxHmnSAZvtTmwOFZLWj8sfgkUyfidRm?=
 =?us-ascii?Q?pk5wCmdKWzRxCfqNvH+oB5Pg/k7XoeTPK0/16p/rnLxNpp1wiRf4bsPsBOmy?=
 =?us-ascii?Q?9eJnutmB0swTbTckKb9+MEY63F6cvD2eGZqC9diRgfrKpPP/lmLFeUu7f8Ec?=
 =?us-ascii?Q?4HBjHJWwBafu4Dp4xXIECoxWQDwmc46DwDF+o3ttVZG6CGwpO9fmx2X1Iu3k?=
 =?us-ascii?Q?2ZmCnSArGboLP+0lsUnutUXFBLm1UBDskwpIQWO0c+EVx/xqZbXjZlKMSQ08?=
 =?us-ascii?Q?Pb4pjabYQirhBkkTGaxlhwxqcJQGkSLk3eO8LWYH7Tck4FMTlXg0wpiFeeq7?=
 =?us-ascii?Q?dBTuVXH90Sp5MdBU9dT/xtUO1t4IeaWiNI9SvqQP7ZJ7K2+mcbjbNPkPHFRx?=
 =?us-ascii?Q?kONi7XROhW/6kNoCAON1M34Iffh4pAWFu6BsZKNyHqQTHWm8JfWDQExBdYze?=
 =?us-ascii?Q?upqbakyJwZA63a1UEJX8ezqECTFopUhuQfZmIiqXj6hhNhXAk7gkkM3bZsOz?=
 =?us-ascii?Q?5Cu1cNyexkS4PB9NGB8hr9N5knszn5nafS+tg0qrG2cUnuGsnVJHfuhI3rPO?=
 =?us-ascii?Q?odTpRhPzzWgdNJnpGECbwn2uQwxtKy4FyUeYq10u9uqxRF29ezox+027QEw4?=
 =?us-ascii?Q?Ii+JBpEtIb23qofadOwOdNjmIwMgYjauGyjaL2OUxhEc/yBLsy3Q7ZQ3iQAS?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fff530ab-fc0b-4172-b31d-08dcf38b3e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 17:50:54.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cboE1JD9pWlAiyavacs06dLiWtR4wXSOU3igvyhk7UzPQbL0avhoUUBb1UlXeBk0MJDjGNyQl68IQlHTOX8meQ8nzp3ak7pxhHxCzL3n+K4aaOPEOj+11CgwDalbJEMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9450

Hi Stephen,

	DualPI2 is independent from TCP Prague, so I will rephrase the description=
 to make it more clear.
	Related to TCP Prague, it will be submitted in another patch series and ca=
n work without DualPI2.

Brs,
Chia-Yu

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: Wednesday, October 23, 2024 5:52 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; dsahern@gmail.com; davem@davemloft.net; jhs@moj=
atatu.com; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; dsahern=
@kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) =
<koen.de_schepper@nokia-bell-labs.com>; g.white@CableLabs.com; ingemar.s.jo=
hansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs=
.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com; Olga Albis=
ser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com=
>; Bob Briscoe <research@bobbriscoe.net>; Henrik Steen <henrist@henrist.net=
>
Subject: Re: [PATCH v2 iproute2-next 1/1] tc: add dualpi2 scheduler module

[You don't often get email from stephen@networkplumber.org. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Wed, 23 Oct 2024 13:04:34 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> + * DualPI Improved with a Square (dualpi2):
> + * - Supports congestion controls that comply with the Prague requiremen=
ts
> + *   in RFC9331 (e.g. TCP-Prague)
> + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> + * -

It is awkward that dualPI is referencing a variant of TCP congestion contro=
l that is not supported by Linux. Why has Nokia not upstreamed TCP Prague?

I would say if dualpi2 only makes sense with TCP Prague then the congestion=
 control must be upstreamed first?

