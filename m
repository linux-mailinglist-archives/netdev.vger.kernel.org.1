Return-Path: <netdev+bounces-139357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217699B19DA
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B77B216EA
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604657CF16;
	Sat, 26 Oct 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UntYJ+LM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618A757EA
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961389; cv=fail; b=I3ekphzXPWiNGC1xjf9RFAB5gPcBoWyrMOG1AkvLa481viiCVRIaL0hnhCIwOdhytSXWWDZdx3Eonl8hjnZhdJEIakix3xbt5oahfJkmW5mbVqoiuQqpYAusUVtn/Tajz9YgU0RmWvBgR/RaCxdRRhnuZRr80xTR1BfXfAeaiZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961389; c=relaxed/simple;
	bh=UDlgXEbpYjy7VKGXadITl2bYCQyo4SGZha2CsySdAKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SL4jRTwrHdtTNm2NiguqLZA1Nu/BmImaCfFrSNyeQOLS72mofQ4HtHWy9x4UM8ZXrcAEFKmMztjnOxgE3iTUpoIcnxpsSd9Q6uQLpUogaqmoHRHYQqI+1vz2/ZZdLh/u4tdZVz2Frf/4vKJMY+i4npVpq1jq1ooQJpOcYRkHXLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UntYJ+LM; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yexxydUBN1MTqJXeewpdEqED0yfWb4RJp0mlQRaFcuP4pDFw19yGDma/u5hzE+Ms9gVu6q3S4hSof/D/MsiSGXSi601LOT/+9NLTTXd6Ap/EyHOUcSHPWodlRVIdEAruXdLsCaxBMz1EH0I+ydGSk9byZetJnc/4gbn0K9xc5zWeZbg/zSJpwSevD4mtwk0/X8utGgPuBeAv+Xzwg1Ns2o0DSKHuWitngPX3LNfnlmft9NH3EcVwby/AqAU6y57ZzL9d7v0noAlfDamv18/GJXcLoPoEbO0keZLgalLecU9CSK8rRo9+y0fW5ii99p8a1hFlibQNSMH2VI3nERFHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id+qmz/8ScqWdPGCp+ycBuahR3Xw+N2i3+ybhNjcgIk=;
 b=g9jaQRjMIbdNUkterFj6wxz4B66YviEsRMHaPKk/fC6wm89YZs29ImF9VoiQXYsjUXRE0PlV1WkPvndE+0ED9Rjm3W9n3AMBWSFGurdd1MyZMhL8Z8Qo4jCbcGn+Ufv7XfZkLXcKGcvIbxyrG+nK6wtIpCt3LkJu5pn68CESLI7haKgZwZOoOe3cXaTm5VCYhzkUQt3nWXPFE9aAZY4R7CGfeUyElR+6q3/DJmHHeWO973iCqywVJXF9ljzWTRB30BybTjgLlZYmKL9pGQlOVzRVOmiyj6RxljW6UbWlayfCEq/QhfGL78YXMjl7pyWHoWoR4KR45p0wCZVjy/qHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id+qmz/8ScqWdPGCp+ycBuahR3Xw+N2i3+ybhNjcgIk=;
 b=UntYJ+LMda0NgwEXJGpqycdSW6uHhBBcQa2L86ZYa4sSYP0v72hc3Eu6FmMmDFpsLmysAA1R5xYjUco/nJOFArkKs49oMlHuvdIlkILKzgA0S/fHj4XupLUMEaNtrbSuEtrABKDqqBvKPNrbP/LgVcNVSCQpDEaG/il575nDinWIFhTTzbBJC72pzKNXJH4L0yTPEj5o0JpMU2H1ymYe6239YzjJ+MRyQ82o9HM510lrnRTxHhbwenkYa2+oYunKYLrQSH2lXb73SKjg5lRNt7uiFKG2a50GbqyRRyhf0HS7CdQJWSgQIpl/0vR0I6RvMMPMY+Iuj1fbESETy6OdAA==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by VI1PR07MB6477.eurprd07.prod.outlook.com (2603:10a6:800:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 16:49:43 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%7]) with mapi id 15.20.8093.021; Sat, 26 Oct 2024
 16:49:43 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob Briscoe
	<research@bobbriscoe.net>
Subject: RE: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbIQLqPhLmGHvpbkmCHXhwCviP5rKYM0oAgAEXrcA=
Date: Sat, 26 Oct 2024 16:49:43 +0000
Message-ID:
 <AS8PR07MB7973A341F91E4247C2111816A3482@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20241018021004.39258-1-chia-yu.chang@nokia-bell-labs.com>
 <20241018021004.39258-2-chia-yu.chang@nokia-bell-labs.com>
 <ZxwyGtt2V6w3WIIp@pop-os.localdomain>
In-Reply-To: <ZxwyGtt2V6w3WIIp@pop-os.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|VI1PR07MB6477:EE_
x-ms-office365-filtering-correlation-id: 51f56954-fca7-4000-0c91-08dcf5de30d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vtoVgeOvKd2iN5pMRDhuzpj6C8ZvQgkSzUonko+Rn4wTBOjukw88+UyOHW4j?=
 =?us-ascii?Q?CrhFu8Gb3A6xTntLx8IttUS+gKd5dYGhpHtw3RSN81L2IT8Y0Q6GEMjdt6Bq?=
 =?us-ascii?Q?Ezt6kYk0Huf6wJcQ/q7UYJ20sCcYP3y8jbH2gZDufoAzxpbo5WU42k7q2uqP?=
 =?us-ascii?Q?+fN226emHIy2D9blaTBr5p0nC69wWhu0ubnTahgyufKS0K8BtjWFv9ZyAX2w?=
 =?us-ascii?Q?gTVFdtgJe4TAkdif0MlNovsidMYEN9j6Y3oAt82FW7QbSeydzxHkOXx6ImN1?=
 =?us-ascii?Q?dJyXrRvy9kchZtHYcwuKta0wBxhPfF/kLX1xsl2MR22AkC5Qd0iIRrLQT2YH?=
 =?us-ascii?Q?qllG7f/k/RKqFCjJV93j4ObfpPfkrTXqJyvk4TOgbfG1qn4Wo3G/V0+oa9wW?=
 =?us-ascii?Q?1miHif2/fs7l9/muMNLmoQdav68oegdnoTSJNNXZLqDnAPGyI+e+2cY1kQ/P?=
 =?us-ascii?Q?ORBBeV42/BIq2G/tY2QqabTAXMZYZcY8i177XIZF/AluRveBvRb/mXolfiXv?=
 =?us-ascii?Q?5R7n2rhbLaEWC1DcsbG8cqFiHIOz1NY/fLhtdh1YiGHeeKBWUqDuK9LC9lIp?=
 =?us-ascii?Q?YTcFmaB2SlM9liVQvnBUn0Q4JNK36+o4/faslGOo0XmBCVdqx22WWVF7WZs3?=
 =?us-ascii?Q?PfjNnsSYZgzENyT/m6u8E6I0ATJrdV6uW+oTabNdPl0myjupPmKsSqwxgBxh?=
 =?us-ascii?Q?IJiP8+ql1vm+jarNfW7zua2GugSo7AX1tYZNr6S+WhWfqRtvgXWpsRJp18sQ?=
 =?us-ascii?Q?DaXFCcgcXLuupxjfQIyWqmiJxxQxTYoHOJ5ozvxtkV0c3bkQa/eDBG0vgZa/?=
 =?us-ascii?Q?grmAbM3N9nXpK4O9lQmUXQ3xnicEUhUTCSRBy0ygTw0b5YEkM/rRyDuess3a?=
 =?us-ascii?Q?GakoCEh6Kf18v8n1pU3SV3/P6V+lt5/9Zh6+DwVCYVzFUH1yQddXZtg1E9jS?=
 =?us-ascii?Q?y4K0LPgPkX5jBWxvTn8Qr7vYT5Pp4+GmzA2N+Y9JYAtUxkMRaflG93nibn4E?=
 =?us-ascii?Q?MnH0KWRlh+7KdX//o4LqsMe5g+HQbjpJbJrmg2beaCwwgr8095tQdquML+8E?=
 =?us-ascii?Q?0cDZcte+v+lcv8CpixEMDYSIsIqFlHeb6BZkmbtzQwOAWiWpSwMuXeh6RxcA?=
 =?us-ascii?Q?8AdMPziWezQGyYScXF0LGqR+DH9MzTlY2chAVhtks6wbjfaFIu4xCZNbkhOu?=
 =?us-ascii?Q?eHq/LiwKeK4ZxPfRaWlUs4qZYeDJu51SIBewf0ekVSzQ7lzFUSqkuCFgXW0k?=
 =?us-ascii?Q?+Cl3a4CDhbo3UGADQItJ0wQhl8hJrsSWsJlG8vh/KmdLg8c0ealay4sXlpF1?=
 =?us-ascii?Q?zmFd+CVQ0Xde+fJWlSmnSjkA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qBjwi+xsgvewm34Bug0ZAMeSr+PdseJLu3dO5WbbLBe19F59CwCmNRaVJE/Y?=
 =?us-ascii?Q?iF2n/xw689yzYJW6uq8O5QeJ+gqPyFJvrmCoHim8tH2qHi8k+Lk8ZQsLmPlW?=
 =?us-ascii?Q?xIkfzWt+C7ni/JqSyWL3DtZGY6IlXVrPMqbgoVXl6rUhzm3oisowzJhofrl0?=
 =?us-ascii?Q?xss800nDuzradxEx5Q/4uc4im85F60qukBKThs+7euiyo1+YNTNk7YNrHtGM?=
 =?us-ascii?Q?gd3AiPRKDqk+mp8xq4C6Bif9FYPxUY/15mPv6LEkRQAK4y2epln0GtPM7fWB?=
 =?us-ascii?Q?etBy9Dm2Th2MYK0zqtkVlaGfbmz1fv8MzghnmKlJznKpGW/PqkPzpn/RX2xq?=
 =?us-ascii?Q?gUgymAWrC/Zy9mhdVYY3Fml6vNHVTT5GwkNmpyL0wUBVqeIC+r8jSkUSoTlW?=
 =?us-ascii?Q?6qrqhWLA8rv/tyTPOUZwBpF/RGBOgTbsekfkzTAwS+FZuX66IlQ7JAmT5M4N?=
 =?us-ascii?Q?6qLcU6+JOvGsJi10aNZ1QONv0FrevSzlEprrrgK6ScQuoVb66yIrx8sPtRIS?=
 =?us-ascii?Q?TXJ1OEU3VF9TjgvYElvxwLMMDNJJW8uN/ct0VEXLVZljFuHunBfMTJUkUMuI?=
 =?us-ascii?Q?eBRrys/uc1ozb74s4IpQqHxolQvxFqDIqKnanGMW/DqADw0enji7XWyXYH5F?=
 =?us-ascii?Q?5pAr3uJg9GNrY2q2MSrc6aLyHGpMqZMb8fuO/aGybtZhibdW5tjIO959Oy6R?=
 =?us-ascii?Q?Lw0s6mWp88/mXyY6sHQhJDeCBNVgIFYASkU9d3iIEn+nTjGYXTD8yr7qN4Jq?=
 =?us-ascii?Q?doVKgr+ynRrMsl31mB1TY4ttJ5SvQiT+nrgVCqfuj/ESEzjVxsycwx56SLz9?=
 =?us-ascii?Q?mbQVmo+aCt8eDsKbwZgCP3V7kbT29rMK3UNd4Au+oLNFI9rzfAU1WRBY40JS?=
 =?us-ascii?Q?We9t7rcsWYlKsfDpgYO9YLvgF8SUr9h8pnvIV9pxeAPLYmLpdkFRPJY/Xigp?=
 =?us-ascii?Q?IQVYKF0egqaQCcLaRPToEqSQqKQDn0JQLArS2AX/W5fry6HXD8YJaGaWr7R4?=
 =?us-ascii?Q?8v/MIS2IAeUmanDOSd/uCRtiT3Ed8YqY53tzcw9Ln2MkOjmhMCa2PZLPeBzr?=
 =?us-ascii?Q?9VxSoyD83C8vpVacXbr8rxxyoxhZML4823inIjmnMkbUqn3OTVI9OCMgOyKA?=
 =?us-ascii?Q?zeyFF/14OYXe1fMNHqs25JZpQ6SMhxXE0esqiPQmcaA7bgDhDjjAPoAf4nCN?=
 =?us-ascii?Q?ozW+L6b5A1zNr6dzPJAj+pYmAdobWGLtAwMne7DTP1IZQLU78lt4XdIQdJy8?=
 =?us-ascii?Q?nwSjRe24ZNfT5D+f8oEXEaSeBtX3VMCDOFYwcgpnqhFr30f+vbNS1Ksnk6By?=
 =?us-ascii?Q?6/iD3gn/G7mCNSxet3pNSYMGlmgTbcJxdOOkDmAyOI6O22QkygnYB0O92Wpc?=
 =?us-ascii?Q?u/uKp+jSkKvtoSKBQ3JXw71K4F3HdSyoGNQYsIRP1d9Vk500pSz7kB9mmPmE?=
 =?us-ascii?Q?RoJFQg/Bto4WQnZE/OftMBNhG1rztFwj4vpmXRdFlZb/6RF4IzDi4YW1MwBN?=
 =?us-ascii?Q?vSeesZHyTw4YBlo8qJP0eK/0Ec8fI3rYPKvnsC/GGTaYJMml45QO86Oj0EdH?=
 =?us-ascii?Q?kOGuai54s37O1bExcc497XLaMQjXi3Sc0sZ5XyBycZlxehRiYguakGYbaWgu?=
 =?us-ascii?Q?OQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f56954-fca7-4000-0c91-08dcf5de30d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:49:43.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NT5GVYH0N1ci8vuc7taDupPUHiGlq9HwA0kKc3E8e2URjOLZbQCThi4dbuo95dIJJajG4Di+mC/OEJGBqOb7cNeaGKTP0JpkDQS/KkNbbdhH3VxGRma2RsFFxWzp0Cs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6477

I will add selftest in the tc-testing for DualPI2
But the implementation of DualPI2 with eBPF Qdisc is not planned so far.

Brs,
Chia-Yu

-----Original Message-----
From: Cong Wang <xiyou.wangcong@gmail.com>=20
Sent: Saturday, October 26, 2024 2:05 AM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@=
kernel.org; pabeni@redhat.com; dsahern@kernel.org; ij@kernel.org; ncardwell=
@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com=
>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewin=
d@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast=
.com; vidhi_goel@apple.com; Olga Albisser <olga@albisser.org>; Olivier Tilm=
ans (Nokia) <olivier.tilmans@nokia.com>; Henrik Steen <henrist@henrist.net>=
; Bob Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH net-next 1/1] sched: Add dualpi2 qdisc

[You don't often get email from xiyou.wangcong@gmail.com. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Fri, Oct 18, 2024 at 04:10:04AM +0200, chia-yu.chang@nokia-bell-labs.com=
 wrote:
>  Documentation/netlink/specs/tc.yaml |  108 +++
>  include/linux/netdevice.h           |    1 +
>  include/uapi/linux/pkt_sched.h      |   34 +
>  net/sched/Kconfig                   |   20 +
>  net/sched/Makefile                  |    1 +
>  net/sched/sch_dualpi2.c             | 1045 +++++++++++++++++++++++++++

Please also add selftests under tools/testing/selftests/tc-testing/ while y=
ou are on it.

BTW, could it be implemented with eBPF Qdisc?

Thanks.

