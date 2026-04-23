Return-Path: <netdev+bounces-280571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMUKIah36WkBagIAu9opvQ
	(envelope-from <netdev+bounces-280571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:36:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CEB44C235
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E21B7304753D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BA314D1F;
	Thu, 23 Apr 2026 01:35:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53121CC71;
	Thu, 23 Apr 2026 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908148; cv=fail; b=rALmUw/93px0hJ9h5w7/+0UE/f6I8DxXASb54ldudcnKt9t67TgjF9owT0VragoNRL13lFOuvppkrSNSzvec8UOGuleYdgEBk6vouqB4KaBhuqKpU9KWu9mPz5Ep6K+6FLEAg9oP34Av6RkFGZKwuJGz3gsFk+ucnHgPfc5XmMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908148; c=relaxed/simple;
	bh=4L/t7wsidp1PHQ0xB8bgFUwx0zp3pEN3G6frufnMlig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYIun4sMINIupzT0lra+aOvoetatRJKH5PLkcjRPVM1LiK/3J+KQTvkKntJBF0KmYShRIQjpuce7nCaAmvkaWmTmXpnBZNYjSFNMX2Rb3esQFJK5PC05xaT9w8VeeIqGm2RKOdm8KD+enJl8voHDMp4jMbTOb8qHiC0+4RlA1+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAe41QcrldmtNyV4FOtHeHcQZ8Ft+Hr4/s+9y/1AdbcbSDRxg7Q1MYOmE/at3H6vtEuLWQ8fd90lC0BCGLZmHpv3fvVxs9bFN2JeFartQ+IjrYbnGDd8Sz/yueAWlSuGrjEWRfkAisIFsxHVfn2Z+AFpp7Y/vURRDoQmEYLihqVd2GTDjY30si+txs5Z+om0CWTEsv35rP6w/4+cC5SkpNv86GJEr/r3EKzRF7ud21BhEiHPvSBWLLvbn5Olt9vEQ1dj95/pEcR14nfzjB2eeHrghY9W2U6eSOtUJXw/Ws4eTiaB1APSN8MkJFX+1vMrX1LzFaLzUrQ7fCoqALilPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwmiqaygApm041HGYkr7y1nAQJnFmSu4NMJUoJ36ctA=;
 b=gI3jy8JU6M/AcVLSwyp/M3CdKFCOGLWF3VvMUob6tIbK09Aua2VVBdjA72WAKAXRWlF6rFr5bdJiOAUaO6YVVT08iIQU55urnmPkXJjQc2x6SSl8RDndWFZ0c3VnlDymMp+sO0aZhxcJ7BF2MrlmE+b/aiu3rO6hTVyREzaUYKqUiU+03Vsvn0rEeBNTakn4y6N11mkzaIqF8BOmRYF0wXHWo8XwFGn1S/Su7lPBw/MJNWo/u8q0blKH6Rk+0gk1KilJmU24pdYr4gvUWglr3/hdsN8zzV3Joy92BSS8C0fgGThCUwd0e5ONDgfjVNhFymF8hOW9ldSIKy4je2Bp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0808.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Thu, 23 Apr
 2026 01:20:03 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.017; Thu, 23 Apr 2026 01:20:03 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [net-next v2 0/3] Add motorcomm 8531s set ds func and 8522 driver
Thread-Topic: [net-next v2 0/3] Add motorcomm 8531s set ds func and 8522
 driver
Thread-Index: AQHc0jKj7LLlbKXJQkCOhBsLzCBIc7XrEwcAgADHMoA=
Date: Thu, 23 Apr 2026 01:20:03 +0000
Message-ID:
 <BJXPR01MB08553693DD4C48ACA6CFA181E62A2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260422083255.29692-1-minda.chen@starfivetech.com>
 <eea18d2f-5294-40e4-9ea1-87aa55f8ea28@lunn.ch>
In-Reply-To: <eea18d2f-5294-40e4-9ea1-87aa55f8ea28@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0808:EE_
x-ms-office365-filtering-correlation-id: c6daa873-e12c-4d5a-c606-08dea0d67263
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 dvis1xFnlSOFgXANbG0VjJkaa+BJjyW0cX3qWkIuz+6wISdC56Rtvnvx7f0EMHNZYTg0NAUqOlh0NbecL197dW7f6orQHPH/16d4xWg7zg5MPex6l4mxe3qXZ9Sd23OI6VfFcBQdaRmoRn8dbAJbP8MDCrPEA4x2YZ2twhBjK2R/p6ZZ14jJrRK21NSJjMHVQ1Mf5AnWJW78BFZCIKCVbRRmw77vZPQYoNaaGSOaYOnGASkw//IfxYoF1DpPyuQJL2C+Qvxphgikn6ifjfGA47OyNRrCj0Zj4tipYJIF4hDdiXPpUOoVRbaPoBeQHMgYweb9cExpx1QRVDAO3jTcjhZMX4qjuyCLl3P2vYdZb+SLDjFiKFw1txnfA/JF4L682GAKCV4cJ8DU2XrsA/IW7WOFOCFg7UdPG1hjIs0Jfn1USd0Zcb2lNuZbOsxYc9zHKODGe4bqfekSoGKzkVHDS3FLY4eXNlK8GnWUctHlMP+3S+ZGgHbk+xkzfblL4hGfddg7XA8y4yhzHnAe/Tyf+SVaA5bpZR404+FbHQfuhGffl4lfBcQnbfracW/XXgl8+GhMkRbQy+YAH9gK3yNUJg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OfNbrwMEuFb74M4zQGp2jupIg6bx8d9obmEg6UDBdtbArsosVX2kOpVR+Na1?=
 =?us-ascii?Q?ka6vtAvyG5DbDy+27Q8kSQUB4gAkSsJRduzD6wrWqEPc/u9xYQEA2X67bGiF?=
 =?us-ascii?Q?WkSNVJZE12RosbD63moI7ov+vIwFftALaEF3fBIIsAwj5XN6cftbtZLZ8hle?=
 =?us-ascii?Q?baq7UYMVkvOoFfNMrYmGZkDIzPdP9ye8pXanwRLp2HDpYN+PIM9x/am1AZI8?=
 =?us-ascii?Q?R5HvGbj6vNiob3ubJy/FAyn30f/AbzY5OjQX8+A7BsTH1Tfs5I5vK59vP9c0?=
 =?us-ascii?Q?0RhyTebiGQ4DDe9BQE1okyl3XpVfgR2pESlaGnuSjetgA/Fs+1el4oWsAB22?=
 =?us-ascii?Q?waYqy5VqLHD4F8eamkYm7w06KcmiR+skwzGRB3CaVJCL36QXPPLRc7scXWIL?=
 =?us-ascii?Q?jDz4+HmtzCF2tlnF93XBpJBO68UYjWzZXb2uO+F4h01O27kTvya4CT8pDLBk?=
 =?us-ascii?Q?W5pSUFQPxPW3jqosiG4S+1quPCFzRdj+CGymg/ZJyims47iiYBJrIs2XGaMS?=
 =?us-ascii?Q?vanUTjLIchwJYXMj4SAF9meXQlIAqM8qit4aLwOGdoNOxw67l5fho/EBSSec?=
 =?us-ascii?Q?B1Zev/dAUtJlnjfXmL7toU4THkNx/VJUKGKGZrzfTsjYP0D7JuXk6Wdx73KG?=
 =?us-ascii?Q?IY6xUk+IP36fJIVbj1RiJoOroBBho7wQJ0dLr/2Rfa7QylqTME1RVXXHOrBQ?=
 =?us-ascii?Q?2JlXuhXm0X3o3TNHt0NULt/LjO4colJHPjj3sIy5MrQU12NekbrL4zxH550s?=
 =?us-ascii?Q?dkU4j5C07Koi7RHr2v525ZFlWcz6yWJl9Bdu3b8HRHSNYTNQCHDaTjQS13UH?=
 =?us-ascii?Q?HCj7dI0ZlcOYVrGVIQt1XgkZ7Gtue+S8JhSFZDOG+Tr2jcaL5G/SbBiB1ozO?=
 =?us-ascii?Q?L3Qumh7HNSSUkbXl8gq2pP+pnGiRHcR65VT+83PIdTabiqkGLRgLXPhVg6Ur?=
 =?us-ascii?Q?jbOI/CvQzqv6zUw/aEQ0ENr+eaVNEHwt7isrnZFLWuluFkePmXlYr3UZYowi?=
 =?us-ascii?Q?5U2UTRgX07E9oxmY79ZSNGI8uUPz+T3uf2994wY5jiugPm5/qBjfyXTvqsmH?=
 =?us-ascii?Q?j5HAm0hQw4uP+b8O/f+t8PZgcHm/T5wDchdhi2D0m9DSUADYxMB0+A/gynMm?=
 =?us-ascii?Q?pCeThrLhLTul1yl58sXhp3DQU7kZ4fqw+t1v8aFEMgXHprJdrGEZIYCSCPCM?=
 =?us-ascii?Q?ICBvi10V2R+1bVyypyEZp7FDGJPAPSrhA1qFxXuNaOeE8zIR9QarjwDP2PbN?=
 =?us-ascii?Q?s7Aon9xCHFWhNffdsDG2lalWMZATa78Mhqu/FcjV5GmPBTXopdYWHcEeQZkH?=
 =?us-ascii?Q?sEmlCu58aVXv23uc3N3UgRUKZo8qXrlKtrwOMlkbdUTfGrfW8zPznVTpammc?=
 =?us-ascii?Q?7nU3mdGNmV4jCY8Na2eb0VAFpM8Jj2e0I1mJ2ppW6d6j+b+qGIVkvD+ah0ce?=
 =?us-ascii?Q?TQ2/4hAbOIJSQqjhLylTlQbCoPwLoAQhM6qM9QPt61YXo2pCMbg+dzd/nUvi?=
 =?us-ascii?Q?mDObccnlTe/7Ap7zMU/JQrp7bHws0KxtIh1E3J3AfPmgIPHtL2hDeqi/YF0C?=
 =?us-ascii?Q?kjLrnq7/sJWXDnzvsiSbMqa7xnYA64/FzaU+jxRIMko+V+0X3DVJeFNXM4XD?=
 =?us-ascii?Q?K6mSTqFNeaRU02pCXUPG4ZTfRk0JLf03XopqLzMqhmQVt9hS2jHrp0pIwfdg?=
 =?us-ascii?Q?ZBlJg18siZh+UmOpNNvDueZsej/jooJCMj8a04lZ84TFPzxHhQfbuYt65l/B?=
 =?us-ascii?Q?OqX3+wy7GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c6daa873-e12c-4d5a-c606-08dea0d67263
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 01:20:03.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iy+tXrj4FWewf3+uTB5TpHIb5khpoRb/vCGQBer0MOtEq4DBzIoH/+L83Yz9RcHvESbwEj1OToPGPHWcIxiBP8v838N6s7ycr7A6D5dX/LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0808
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: B6CEB44C235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>=20
> On Wed, Apr 22, 2026 at 04:32:52PM +0800, Minda Chen wrote:
> > This patch is for Starfive JHB100 EVB board. JHB100  contain
> > 1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
> > interface connect with YT8531s Ethernet PHY. RMII interface connect
> > with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface patch 3
> > is RMII is for RMII interface.
> >
> > JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
> > Managent Controller). Similar with Aspeed 27x0.
> >
> > The JHB100 minimal system upstream is in progress:
> > https://patchwork.kernel.org/project/linux-riscv/cover/20260403054945.
> > 467700-1-changhuang.liang@starfivetech.com/
>=20
> Please take a read of sections 1.3 and 1.4 of:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

I am sorry about the "net-next" in merge window

