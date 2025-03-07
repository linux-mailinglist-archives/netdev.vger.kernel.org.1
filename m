Return-Path: <netdev+bounces-172810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC46A56291
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931117A96EA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89811494D8;
	Fri,  7 Mar 2025 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SwZDzSt3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156D664C6
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336241; cv=fail; b=LQ3KesmVhxiEz/w1hh3vu+M+gf0zYUypFtwnasCMOvx1SsCEyeyUw7MRO2YDIxkXL+FQTQlRYiiSl89Yw/+KR67XqmNgcA/Tj6Wj2g1/hYmHUi1xYEfuSkfKFCJL5MuqLsnGIQ2pWL/W109KU1zhgSFfYuMuj4zSZxGcpJJpDZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336241; c=relaxed/simple;
	bh=s4dJEdmNr7+rOR0Rd3L+LIhubidSTs3Tfvf/qDRo5ww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJ4eOJaG4eJmwhAJTnMTBCX7iY26FZcNvFSEefFmcu/6KZCO2DgOI4pl6pdSvrd/6bZUHsdqGv7yNPdt4uC5ZOQd6N+5d29zYXQBgJyz3tYNT+RcJ3uhjGad0EmguJFV83awFIaBqtAClAbKYBXfvosR86J7Hil18PKaytwf4fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SwZDzSt3; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKvBiGnFGkJej9MY7VCigoc6V1Y1aTx+PkqDUO+AzKkluf+qW5ociRyKQyAoeAMHD5koIqaGObFcXE0UpA9nXXgQ4gYg5xR5fSBJCsY3OP4ajt/VS2pHjO4xKe4Yz/yYhCh1g7PE4aof1URWD4EPzwWWSGujSViIEtRzZ4ZGFOdBNoo2UAjYKsWM8KVIdlteuYO5a+3R4MQpwQO3TwtLa80x/eklGgqcMY2l/XVRqaHobKKJ0aI0qZIVCWFvfxgK4xMxwxkjBBU0Ggwge9PjNjcjTcHJsmVa0xx3LBT7eHWSkdYUBlWQwf+DL8Q/DDFo+GRf2CYuGRJ3eiRSmeDxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR62itW95aImeDszU4v7EXtp3ViFPMBoHz7suxGtZVc=;
 b=nCFHgEOr7DwUKr7Ed52eSp/9IbICHnJWn9gL27vZmDK9CBwdseoQDcE4r7geymfMxuj3+YyPb+TcDtzpR0Vb533pjJ5YlPJE7cV2paB6NVFyu9WvNPF9CHFDnCpUZ2gXq4AtD6bAHS4CSUlwjAeBA1w24LP3LGvd/Nk7FgZn2JdGHbqflcaB7dMxmS6FqO51UwJ689rYaB1Gy/b6WdlNAfh37n+AvpbuleEgYMXWX/FJHsJwlKIs9WMDJmAQ+IB4YP6RFLOrGXu/E6KsrFbWexo1ZFO8sTNQVfdbKJ3Oaxau1TGoLIWrNRILbrAP18BF4+AzxObb5dIAkL8mFxUt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR62itW95aImeDszU4v7EXtp3ViFPMBoHz7suxGtZVc=;
 b=SwZDzSt3Szh2p4xYETwtIHxtggzBS++6vdTu1XLkHgqSy32Bjhfvpqux1vpIrqd611290JIAMrcKRqjlW2V6DChz8/56KhkWlqqRyVt9R3JauHseLg0aAq3E2CwOOZEf1G0NkTMSAQ2Tj9zzHVWrG94dUZfyLfcLsoZBO0RnbJ1pJD3zvUHjkXk5pM7c0DnVstjFZhObJO51HnrvdhiMwtQr/+eC2rnQ4DsrHFFvBXmN4MDMNPxTH3o/Bx7yIqE0bZ3xMBihAMI1Pt2JZhfh2F4sQO75uDUpgX8OMCIHb/rue39v+v5dQUJu2h3L+KqXOv1V2h/7J4jxmtjuw1YCIQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR0701MB6896.eurprd07.prod.outlook.com (2603:10a6:800:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 08:30:36 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:30:36 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>, Olga Albisser
	<olga@albisser.org>, "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
Subject: RE: [PATCH v6 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v6 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbjRhAnoxHunIR0kGbEWAw431Tu7Nmxt8AgACU5+A=
Date: Fri, 7 Mar 2025 08:30:36 +0000
Message-ID:
 <PAXPR07MB79840984680ECC850D7C775EA3D52@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250304151503.77919-1-chia-yu.chang@nokia-bell-labs.com>
 <20250304151503.77919-2-chia-yu.chang@nokia-bell-labs.com>
 <Z8oxZk3yqiYxXJ6C@pop-os.localdomain>
In-Reply-To: <Z8oxZk3yqiYxXJ6C@pop-os.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR0701MB6896:EE_
x-ms-office365-filtering-correlation-id: 57a304c5-b844-42b1-64d6-08dd5d52559d
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mssawVYYDCUemHzjWP+ROW2hW8zNLy4Ca18EgVkoEtNYGe45Jhy/nTNcM7h9?=
 =?us-ascii?Q?/nmlyiNJ887AcuztC9mkkACgdPhy5s82YzhhaEJNroCspnTwDURGlmd+EOxC?=
 =?us-ascii?Q?k+9+A41NwDsPL+ARSnA5+NE77hOMbnT8W7dcs4eE4G4vwFnxPz0I+9UY1yGX?=
 =?us-ascii?Q?Mi2rdB20avngyc7bVCtK+Q9q5x2fInKwJKGCoOy7n6E5MqtD2ZLkiU54Khg1?=
 =?us-ascii?Q?flOV1k5YmyhskZp2h56w6z9fTAAkF4T+7z9/jNkJDwBOGfDwS1sCh/ykw3ke?=
 =?us-ascii?Q?YqBfpUJWV+RzmEll05OcWUsvVDYFm4WinpBZ84GMg7hK6sfq8J+QgkVcQpuE?=
 =?us-ascii?Q?HOkCCUZbbBh3LxwZwTiHz+1AzM4So51JfNvmf3HZT/0lRvwZJG9OhlNaIxPA?=
 =?us-ascii?Q?CjN5PTJDtTeAZT/Ucl1akkzoMZzVbpdPoCbWeItB+B+SnDs/IzO1brrkJwOU?=
 =?us-ascii?Q?qnYMtMCitYnZVnGYOmEhReyD2LbWAVdjZmE8eVIpIh5uNc/M071O35tgAa47?=
 =?us-ascii?Q?HIRYTCbrlQIuF0GFMIR7vWPu5d/VTVyvrbPL/lJQ3tfjXNxIUhmZG5dZetRA?=
 =?us-ascii?Q?QHIjUhqpXGKecPhE8WLfOEJ5XTqNe+wz0bKQjxYOT7AXDHqxzajwiOlRnDJF?=
 =?us-ascii?Q?U9TyXjF2HwXM6bu/h+ibJc/dxsPvWQfAHT9rHMPXLye5QjcZ1Ftf1RVJQKrR?=
 =?us-ascii?Q?VnlMKAqEJj55O7z0tbavFB4Y+/MEt+N9DEnGmAqraVc8h9yNZgsVWPt3AHzv?=
 =?us-ascii?Q?uGmg8ECdqP29+uJWypigxkjXu1AkPId1yGoL7jph93wZkYFAcu+M/ULIEfas?=
 =?us-ascii?Q?sgQe8FRDxuyKVkzTDscW6w/9eedEJXnnTvucDZCCfUnHP9QuGcqY3LTixt5n?=
 =?us-ascii?Q?S1O37zrNtGoPiyeZ3wkzvRjJxtFzcHbnQMluVL/NRn4wxzmlaGuJrPansoDv?=
 =?us-ascii?Q?rSFz7ZF83nigWgx/V8uDoCD6XaRHsCyMEhAaCH7gd17UD6gHx22y5p8yK4Ny?=
 =?us-ascii?Q?QzBH0DbR2ZFbMsH1/9zwCoZLmv4/Z6sx+6DSDfGuekyYLCRfy6xkrGZkOz71?=
 =?us-ascii?Q?YtlTpb/uUdDFsoCge+2p3mc9IbsViUFTeEAIJtuc3awqBaadO5cBeVzUEuLD?=
 =?us-ascii?Q?n8JpWOMh7HTF6cIMXr/Ob0+G3lH2CR1SItZJ1XMBS2HGa9ysOgtNc9zV7tVj?=
 =?us-ascii?Q?MFzq3wbSdOuuuADKJe3NK8qzgCieLAhHjgqBZLC7ogTRa+x7F/6Mt3q9Caiz?=
 =?us-ascii?Q?x2auPxAJcD1AUu0KNOqB4fpxCagMC0dWOkR3632FMOuKHf+pS0sVw8/dHkH3?=
 =?us-ascii?Q?pTg/Z7HQmjUp7naki/8jzyLOJsxJfrQHAsZZ8Xa8TzhlAovdKVDfhGBtFDud?=
 =?us-ascii?Q?xRuO9poz8crhpLYaPuAD9x60VMLt09i8cC7JlLb0izqLnITtdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G0lQ3F9ibCEGGMkxoR3/Ur5FRsIV46vuQKWyqlM0aO+JJL/2/ghwTApgMxDN?=
 =?us-ascii?Q?MTb/zz2jHlcQzoXBc2SGfxoM1qBPJbwmgMqxkk92b8phhTY4qH5GJHwyu1EM?=
 =?us-ascii?Q?VxxpY2rehsK7xUgF61iOJsF+RzcQgt1UixRNZXC2UO055f+JDKuLzOC0wbS8?=
 =?us-ascii?Q?grpxw3Qr5Cvpqv1SZHtZunO7pj4ryLzP3d3vfwIHpEUqHu/PCyqIgcMlyOrx?=
 =?us-ascii?Q?3aMIUZpFpL84tjBjvBGh4cG5OurQh5jaehwrB64iRCZYyhvgNC+2jOJEgbQv?=
 =?us-ascii?Q?1c5UAbbVy4J9JGC6VHVHi3O9pPpK1jTlIrJ+0OBeRxncBAklbOBErsVgGQa7?=
 =?us-ascii?Q?PmIO3at+mok1rLYhFaSZXvBVbxM875cGGSKOW2+33vWGw2LgcqXyoryYnGkb?=
 =?us-ascii?Q?LHEByYIu7HBlmT3FTo+N/wZ9tjVFV9rZQGge+bzjxsO92ps5+SLdgake0psM?=
 =?us-ascii?Q?0H/1cWrBGOgi6nSLCSJj2gEdvytZPG18YNfDF10iG/1jpoKN0DqmXelIRHqk?=
 =?us-ascii?Q?8NahrnWwVmGf5GFT+MjyDDBIvAYIBF/zbhdWzxiUH7z/oseWIHg5N07DLH1o?=
 =?us-ascii?Q?kjf19jKZccabwm8RHfnYwGdVhIxjBu23C8Ly1HJ31VuXYAlvv8NyLMH8fGfD?=
 =?us-ascii?Q?72B+YB3FnnpiQdLiLX6gzC6BFHyGrlo/Fgm38v0DZowa42iJXb9LxK3jun39?=
 =?us-ascii?Q?0HzJPqmmF6pdysgK5EfpyK38pkOKWkdJ4LqstRHNKyePbdUr3x1Y//wcFel5?=
 =?us-ascii?Q?rxGLm5ZvwyqDK1bTA5DNJYAWiXhVBfN9h35MT0VC8vB9OBg6BdGfFoysUDud?=
 =?us-ascii?Q?RHPKIcogdOVTrK1PX0oZNnBKTurmeREiNqE9bl5ffm2tl9Ngnq7TquBLHIDU?=
 =?us-ascii?Q?06a/b6nVCaEvGh+5ODuu0tnrcrDlEwfYk4NIoWiVKdQ5ozg6/yiEhloLz77q?=
 =?us-ascii?Q?NJ+gGV+NEcMW+5gXBv2NTzczGaVBdOX6dixXGAXY5UANe89OyfIBtn8MDuVP?=
 =?us-ascii?Q?CqnIDbQa++vYE8uxC9ZyI4Tmy1pvx0CYrMlycPXJ22bshL1sOIYqXYh8kA4j?=
 =?us-ascii?Q?7FjIL+LJRr6J4J275x7a0+gRDUeSDFbB4qSngaTPf7KjP+MOvPjae8YKLcXl?=
 =?us-ascii?Q?Fw2CivyLxb8vWMUTsbloXfuqyInTC+SIoiDv+L3Fq24wDc8sRTViCM44jtKX?=
 =?us-ascii?Q?IJDlbTURi82cRBS8ThHj4J3NCGzmaEX+njwax1O0sMu4d22ZtH7bzlLiCx8s?=
 =?us-ascii?Q?XxK4w3xNo4RTHU0cLe8UGpLRhWeqLhMqrKLBKT4Nvlyp0456mAtATYyzEyWg?=
 =?us-ascii?Q?W7ks9fg7uQr9/TuhfItK01d9emi0UzKKqUiDoCM9oBugc5ugRg99Szx9o5gT?=
 =?us-ascii?Q?YsKvo3hp2ANvu83568HjxCXdvDh+hs58nuGeMEJdAAASlV92RFNJ50nlPSEb?=
 =?us-ascii?Q?6JfGaD/YPXXcg3CE+ufF5P/MMFrf0yF9gwWaqoIMvvIfAHjoTaWcsVuKHguV?=
 =?us-ascii?Q?enO+dvWsr1O7ZvB5AXHaYDaJiBiBrfrIS2lVzY01iAY31fOyLONQ+DU9ayQf?=
 =?us-ascii?Q?BJE8LM2GD77Tbs86ng15fumhLzy9QxhryjhFuqBLjIAWYbu7ka2BBxdTRnsw?=
 =?us-ascii?Q?2A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a304c5-b844-42b1-64d6-08dd5d52559d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 08:30:36.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JFcqOBp7karfUD6wCpu+1XdMUsD4wfSBKzrF/sIsCXgInupCUVXKGMs035AlGZ4ioYKz9BMMYj0S9WKS7yzhepbvkVv7k9LQqw4GT3z33VhHbR6ZcQZpD/mo5Njmfch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6896

-----Original Message-----
From: Cong Wang <xiyou.wangcong@gmail.com>=20
Sent: Friday, March 7, 2025 12:36 AM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@moj=
atatu.com; kuba@kernel.org; stephen@networkplumber.org; jiri@resnulli.us; d=
avem@davemloft.net; edumazet@google.com; horms@kernel.org; andrew+netdev@lu=
nn.ch; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.=
de_schepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.=
s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com=
; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com; Olga A=
lbisser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.tilmans@nokia=
.com>; Henrik Steen <henrist@henrist.net>; Bob Briscoe <research@bobbriscoe=
.net>
Subject: Re: [PATCH v6 net-next 1/1] sched: Add dualpi2 qdisc


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



> On Tue, Mar 04, 2025 at 04:15:03PM +0100, chia-yu.chang@nokia-bell-labs.c=
om wrote:
> >  Documentation/netlink/specs/tc.yaml           |  140 +++
> >  include/linux/netdevice.h                     |    1 +
> >  include/uapi/linux/pkt_sched.h                |   38 +
> >  net/sched/Kconfig                             |   12 +
> >  net/sched/Makefile                            |    1 +
> >  net/sched/sch_dualpi2.c                       | 1081 +++++++++++++++++
> >  tools/testing/selftests/tc-testing/config     |    1 +
> >  .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  149 +++
> >  tools/testing/selftests/tc-testing/tdc.sh     |    1 +
>=20
> Please split this big patch into 3 patches:
> 1. Documentation, changes in Documentation/netlink/specs/tc.yaml
> 2. Selftest, changes under tools/testing/selftests/tc-testing/
> 3. The rest, which is the actual dualpi2 qdisc code
>=20
> As Jakub mentioned, "mixing code changes and test changes in a single com=
mit is discouraged."
>=20
> Also, this would give reviewers a break between reviewing smaller patches=
.
>=20
> Thanks!

Thanks for feedback.
I will provide v7 with three separated patches.

Brs,
Chia-Yu

