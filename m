Return-Path: <netdev+bounces-181601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC85A85A67
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2390B189B239
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563EC278E6D;
	Fri, 11 Apr 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="wr1CcXNZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47916278E63;
	Fri, 11 Apr 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368400; cv=fail; b=M6sa2pdlSuU9x2WDl32HApGcmqEC69HCN2Q6bahDgoDt0jIjIsDYSicMhhpXDzQXuZYqNu8ETeMay1mvVBKpVmWCYp/8Wg9HHY787bgUK22sWOEah8RDZauHuPBnaxxq+toDgMAA573uNnXztf1gjkBROaneGZb85jZo+vREfL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368400; c=relaxed/simple;
	bh=XXqIo80dL82WhVaUgKdOSqN1JOJtM/1VrlJSBvjq1Ww=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d6lnhBMShIX00OAchI/aFDH39briOxXWe72+oNrTiKvIqKPu/N6aXYcUxohEtZFzSK3VddgowlQ8lzKfH50NJTyHSonlLYanUu1sRJ6tVQk/dYJIy/YwyiXFY07P8QOo4uVY+SPt3nYHoj3bi37tcNl1XbZ+FslQQETCkNi8Zv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=wr1CcXNZ; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1cfhHZcqFpLAVWIv/13MR1aetbGpe8KbiQJjhCgK9eUa9cSBm3UlgV9UzkdQfek8mZr2Sxf3o2AhG5GIKYzAZ9oO4yExmidU/gUbAunIKFpDNHCVBJIQAvU5sSbkNE64A4EWoqed0Q/hu4mUBzoAHOYbY5PFW2cq1vmXvxdmk6EfryULU8wK/8aGQLUnzHy10u6L8+yEe8NHZQXDkAgRRo011E5LIrt31F3dc1ND90bh+7xDlnNc7321WDpJd0h/Lc9SdUsKedPia9xRmGayEbSZKwCqlElebFZ6YFZj84Y54hC2SXqtCp4nW0/vHmX2oISGO+NM68CNfdHot6Nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8UVaF0TKk8y7WIXdy84OQUiqGEiSgC4+HhN1CUoVmo=;
 b=WqMFYIl65XqmkgdV4JeExdTE/6SzFBeTKs3e2RmNsRmdLIqlV+9DfPctRECm1PZajJT2Cp67hh4yYI3MCmb9rDwoQFQw6vKwtkSwfEfdqvsZu6I1wdj+5QdfDoabsj7PbLcAyKp+uBPMAqQuS+nU9POK2Iz8jqDV+vMdPt2CuDGHPsmaOWEnbKRhdJDn7LLbMr1OxiEhIVWJBiIw41XB08yDKI0xGoFETG5O5KagAGtWxVIN5KHi610sMTHxLyrmFTNCfbYafxBQCr2PHGgF1lDpUgyyFSlJ19kSnVGCZc0SyACjAJ7EJlJcoaYZ1McKn16/1MvxCCQRIY6LOJsRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8UVaF0TKk8y7WIXdy84OQUiqGEiSgC4+HhN1CUoVmo=;
 b=wr1CcXNZBRZNFJCB9pwIWd2BNWEkD/aCjZa2j0rJYZxcBb59XMMs/u9Urd0N9Ol+EcTV6GqIGUOq78wji301pb0fQGZbEhea/iJNrcTnueT+g7Nsp2/5nrE48NsWCCksyEyQJezrgfhQiAqFXHLgB1PDxzROQ1t7v1Na4YZTcsqEYw11FsB5TPg2PqlHYBg6+tCFloen36rg4Moo/U4qpnWHHUPm+uMEMqWxvKbbCi51ZY1SvX/TUjNBuhY78rFeXMyyM3n5G5DCODnLYU9d4+KRmVCi83B1LibNcYKt9GwyABm36ZllpFdJKmX7K/hxdKaXf+HNxQY+PgxeSiN8sw==
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:290::22)
 by AS4P189MB1991.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:506::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 10:46:33 +0000
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4]) by PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 10:46:33 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] tipc: Removing deprecated strncpy()
Thread-Topic: [PATCH net-next] tipc: Removing deprecated strncpy()
Thread-Index: AQHbqr7NeiJH9CFBbUW+jREhfYw45bOeSFSg
Date: Fri, 11 Apr 2025 10:46:32 +0000
Message-ID:
 <PRAP189MB1897EE07B01E866F0C757156C6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
References: <20250411085010.6249-1-kevinpaul468@gmail.com>
In-Reply-To: <20250411085010.6249-1-kevinpaul468@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1897:EE_|AS4P189MB1991:EE_
x-ms-office365-filtering-correlation-id: 87e1cdfa-ec7b-4c18-779e-08dd78e61fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cbqc/6HqJ/74yBkkH3//4EJt4HhHkBH/IjnzlNbqQFSw1ZDSFzsm0tvm2SQc?=
 =?us-ascii?Q?l4E3fT8FFLkrbPVGjsdyKEezIAozIPb76t7OKymW8Q9jKFG9ZTDEvVY+2cQN?=
 =?us-ascii?Q?7gTjCY7VN4oZrVWkL7v0RbEBgInsIe2CD+OWhkLytYlcTwQTM81tfJwrD1jI?=
 =?us-ascii?Q?rnbs3EjomUNDs6GHDZq9IdxzZmByFH2nBnmbbTqRw7aTtchBvlFmhNtfIANf?=
 =?us-ascii?Q?qvZwOzIkqGD8j7GF/CSjOn/AKWD+ivvMGf/zMkLrO7CjsuJzwtGzvZvDYId2?=
 =?us-ascii?Q?KSgayyHvaX4yukZK/JPNhXcRIyY3TWe6HY5NkTiHn03QIXDPkrsjsHh7dc0J?=
 =?us-ascii?Q?1jGCEU6ilQr3Z3mSL87zz0KlNTQb4PK2Dr8ews5k9giR6UvGbV2aVGyP/rzw?=
 =?us-ascii?Q?noPl77T4NBmnl4WIAiZfjI3+b2K03Inkmz1OMtW9WQaq4WOC3+mEkRer8WvI?=
 =?us-ascii?Q?UkOdMClGiruRK4oUMUgby6zSPsDatnVjkE5XVcmgo/IgM0WWOWINWfXLeG9n?=
 =?us-ascii?Q?hG4aqttVap9TY8cTQaNzBdZD2nOdeZB3ipH22KtwjT7pq0cqaHQ/OBQpPAHa?=
 =?us-ascii?Q?+cmyHzIvqc7nOQrEwjHbSNVNJ2vCHG7lncP4dGhK0PPgXU1nN4FKnR6EBj4b?=
 =?us-ascii?Q?uRq1XyahLsQT+29EWwMDtipCpmQgvw/S7bp2NPlMfNjuD6tAZYtmWYHNkD9F?=
 =?us-ascii?Q?tAlIXMd9kCxnU9C9zMIfs5jZOT4vBhiA8WgvR86sxImmjjWX3JszT+jHLFDD?=
 =?us-ascii?Q?S0TlcxdhZDzTtwy4jzfjJyLhbFGSMmb1KyqEGmJV5n3W1eSSkqpBfjqlgQiG?=
 =?us-ascii?Q?2DpzfUTSH2Bbv7qJZUT2fn+qEfLPOs0JeRi+CApnF2CpPharBit36lYBWpge?=
 =?us-ascii?Q?QHE7z7uyw9OxGVEd1JlBBLye/KN0ejUk7jBMo/0UVC3kkdbm1BBii9+XtUDd?=
 =?us-ascii?Q?4qbW+IZus03TIimAFZ/yEvF9qodWfLCKyQmTf/u3B/tj3VLmKTJiaAxtNzCc?=
 =?us-ascii?Q?A9yvn3Ob7sB2HwA5JuFWL2Zhb8Mxljfq22DU2Qp2uxs2G2B2kIS4topkyypN?=
 =?us-ascii?Q?vvDnU5Egc1CQL0oqHBj/MyJRhttVMizOM6QwesI5k7++20aMbgIJw0C5fw2H?=
 =?us-ascii?Q?xrJgC5DNQ9K1UIPid7bLlhRtK3R/YSo/hRX2dA6V4k9Lwc6w6MmW95Xq/luX?=
 =?us-ascii?Q?Y+cLR5ySbz1oQ1GL5R403CjasBfKli2TkKX8gmJvoU93IAEq50dVj7/oIsAB?=
 =?us-ascii?Q?X+pA3JeODVvSMxOwJ5MDD8wqcCavd3Y6jZavMmlkhpr2mbnBP9zQwFJUvLmu?=
 =?us-ascii?Q?WPBOhDoqWsYHnndpb/K3O5dgKslWrBjCkeEjnCpdnnqI3UF9Sm0UcrkWllPG?=
 =?us-ascii?Q?yJi0FUScbbDqgTHACG71mfaonAFliqBG9Z/C+wuc/dZPMMo/ZOEN26aSVNXb?=
 =?us-ascii?Q?iaeAM+92XJFXk2i50/vbYIVhDYVBKOQ7b906DlXLTjVSgf7c+hZBb7QJcnyu?=
 =?us-ascii?Q?Qe7Z5xYSiLjEFMU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1897.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V5fXlH0EeTY1WIIayqqVT530FiKkTFU1USl8JOSC6PfblL+1HFLpww0PeUql?=
 =?us-ascii?Q?qaKOYov5pzCjHf95rpgp5M+po2DB+PeKKWOWbO5wT9UpohBGaGmBzZGfdvud?=
 =?us-ascii?Q?mqjxXOS/FycZYBPePQxJUwoweIxiCDmDs6cxfatl9UF9K2zWwANXP6BxuZQy?=
 =?us-ascii?Q?RohcbdII/O2t/KuG676n+IS9Gn3xj6dwVPLrUFdVDdYMmb/3/qFAyR09wPvT?=
 =?us-ascii?Q?NIJr/du/YBE8YdP0ZZjutBWjQhze0z4bq1PTuXV7aCirHelPZUZkeCyMKOZb?=
 =?us-ascii?Q?jhdYfkPNmHqp9G7fbQGERBFECnxC/KQ71OUVgkTFCDcQ/UktENdaMJd2Ts1T?=
 =?us-ascii?Q?4sbqGYm6lTebUq/utlvSsWtiNiWzNkltJO0014JMpFNKcr/Z4laaM7Ak09VS?=
 =?us-ascii?Q?DtXFdr4DUz6lIx/GySrzcNXOQk4bPVOR7xEVjM4sp/kjoeqEBiRt2ToH3tKr?=
 =?us-ascii?Q?XRL1THBe2c1gZ+umDuD/O+TuxLbpmPnIE8seLq3hFwOdW+rLfm/Lnvbn7q3I?=
 =?us-ascii?Q?WqGOaXgjsXKTUEc0mEsM37yGTLnnYG+I4KgQOBooCdUxLT5ahOv52OhC8sMF?=
 =?us-ascii?Q?KC7/ZFbD2x0r1Ze7Hg9jT6jqP3gFetpvzddR4kjUU2XL6Zcddwaq7mip53pE?=
 =?us-ascii?Q?yBUf72viGL7im0btRVT9CwGOOXA8//XBzS/8HxpBht81gO7047npTpMnzijj?=
 =?us-ascii?Q?HoSGnmSAX/iNAOb43HFgQTUv5QebTvQyXrW7e4V/Wh8IifsTPMzCbtqzzi1T?=
 =?us-ascii?Q?X/vaAAQW2KY01F7i54CjwXTX9JM+xAl6MGgpEpcz2RWklFFm7ykBBnCCVkoe?=
 =?us-ascii?Q?t4Ie0soIICinTvLRN1ZQC/WzKfScz+9xj/NYD1I1mX0C2qhyDuQpW0H7LW5P?=
 =?us-ascii?Q?1nIp3FjoUxQOH10x3oEu9up3s1tzWEq4fGwKY8VYng5GxXlA+5opQqv+7WUs?=
 =?us-ascii?Q?dKFCbuiXSYzfU4AabatZksFp4bOKlQKSw6DbUPQFbXHqNaHDmkupecpE34Cs?=
 =?us-ascii?Q?7EJ6BWHL5a9w9QwDBQ0H3oVJzJAbzAso8Z7TcaPFPb428LXFQ9raWLfNW0VO?=
 =?us-ascii?Q?BpS/dSJsLVg4Aao036XdWI1xEC27zXPtAZOCCkcqWTsliDW9yVvuYok0rtfY?=
 =?us-ascii?Q?tYHQsmo3xq6WLXAOvQDFJghqcJt3w8JXzvYdNhcigvW9qrS2q+UZ40AvMDWq?=
 =?us-ascii?Q?bC0jGeStFUoyHpxflQwFemkkCLEDoTeo3H1VTv/Js+uq/2FBQRLLbB/Lbqys?=
 =?us-ascii?Q?W9AV68bWpXUun2HWaNQzXczqqviiX3WyJcCSy5u8duEfYNb3MuMVkHROy0d2?=
 =?us-ascii?Q?hRFqcgEooVRID+k2ePgmYjeTdIiV/vZecdBjHQgE0vf9InszDvecKE0jrhv0?=
 =?us-ascii?Q?y1hdkYp+s15r1ZKnkbpgiV6OnKVN/+5ObofbGJC+7g2kms0C5Pzay1ojfkOF?=
 =?us-ascii?Q?68+zIWmH93jgUlFuFFUiyNpnCcGGm2NcUxTEeKmaZNNa9uUztScCqAGBWEmB?=
 =?us-ascii?Q?OAui/wJM70x3lb+toOoBD+JZ5HmW2otiJV64Mp/PbpuTiyWX76U5btr8gcEC?=
 =?us-ascii?Q?qdpGMvqqc+j6DLW0CdlsRaGmO3HzHqfZSgTz+Alp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e1cdfa-ec7b-4c18-779e-08dd78e61fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 10:46:32.9697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqFqMfCSrjBQRRNiF3uirQoVvd2T40/iGkMIM/mZtiGFQ+kYhrciZVtJv1CdpVSdIQB+ysuwrilSIDcRc0jp+IISWio2deJ+R7WYnTI/K3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1991

>This patch suggests the replacement of strncpy with strscpy as per
>Documentation/process/deprecated.
>The strncpy() fails to guarantee NULL termination, The function adds zero =
pads
>which isn't really convenient for short strings as it may cause performanc=
e
>issues.
>
>strscpy() is a preferred replacement because it overcomes the limitations =
of
>strncpy mentioned above.
>
>Compile Tested
>
>Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
>---
> net/tipc/link.c | 2 +-
> net/tipc/node.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 18be6ff4c3db..3ee44d7=
31700
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -2228,7 +2228,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, =
struct
>sk_buff *skb,
> 			break;
> 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
> 			break;
>-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
>+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
>
> 		/* Update own tolerance if peer indicates a non-zero value */
> 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL,
>TIPC_MAX_LINK_TOL)) { diff --git a/net/tipc/node.c b/net/tipc/node.c index
>ccf5e427f43e..cb43f2016a70 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1581,7 +1581,7 @@ int tipc_node_get_linkname(struct net *net, u32
>bearer_id, u32 addr,
> 	tipc_node_read_lock(node);
> 	link =3D node->links[bearer_id].link;
> 	if (link) {
>-		strncpy(linkname, tipc_link_name(link), len);
>+		strscpy(linkname, tipc_link_name(link), len);
> 		err =3D 0;
> 	}
> 	tipc_node_read_unlock(node);
>--
>2.39.5
Reviewed-and-tested-by: Tung Nguyen <tung.quang.nguyen@est.tech>

