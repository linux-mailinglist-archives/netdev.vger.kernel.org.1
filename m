Return-Path: <netdev+bounces-139535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B59B2F91
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300D41C22119
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670821D7E4C;
	Mon, 28 Oct 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bNZJhfTt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE191D5CE0;
	Mon, 28 Oct 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116872; cv=fail; b=T7QBTYy88Y6NJwX0nF5tjXXTOl2fPk2BI9MCx4+TmMDVDPm9q9Q5WqWPNw3oAQmGVpCivKeq0CiowkwxmrSw7T9PZrFPJMBsGzgQUPajj8zur1NiRzIvMWnSeoQYDi6nP89jOy+gHBSpMG9hlyz831hgpZTnbBNz6b37SAeT+BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116872; c=relaxed/simple;
	bh=Prq/f4OJ06AtXTAjnRB1IUiDe3/YHpWFAGqzJEAsGKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPS9yN1hjk7o/5Kw4xX9+yrRUjAXh6VJsZgJGXaeE7UZrlT6f8f1sW03n+j5BX33UfFRfSUQgwdWtcFDCSkFrsmAGsPEG7VRZ19lQg+67/4ilrkC8nIqoC9w+awvLMwMeeOjcUDL+hQzNcYX/jGQPA8qQx3F7cZk7SVBvQD5zTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bNZJhfTt; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dariacgZlEmpwhVrpf4M2qA0EapdsZiEIONEgdYT972ONdiLWDY8d0WQdbdzJ4G4Wgj3sRMg58UB+6KBZzKm0Dkx7ZPsstfuLj/84VtS1ji4LRnSPyrUColK/fXgNpP8vnnjeiyUgvtDCz5xtug5ndsIEuapsOxjNj6Je1rkJw9Tiaq5hhkeiS7WmeRwn3nYEWyPIbT5JO0ef03rmSVdMVD4CKXfzCVNjrN4kM4GMNfq2JUHj03exwZJk74JNS8h2NvoMrGQczxlHrFRugJ0RfisRB0KBMAFnIKJGwpDdJZJb/Cdipbl/94QtEt/IzgLpkSP0qPWBcAxPvrSv9QIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1YvSSEmubRAfqmi34WwK1WhStOGY7SgRq+fthSIqDU=;
 b=ZaIg/1Kkmzn/bhAeJn0AMsv8XNW4WiTkn2VXaudIa/0+39kYLDoevbrE9TgrJy5b/ZS8ENYStfCFnhPZoLGL9alkOJyl0IBJfBJfUf0X3DeQa9QAIGD65oqsTGjjBSXXOsHQoD+LjM/KSwPX0CpVj0AJjRhtYKUHCMNjsw0NcZTI07606dbRb+QPk58wEDsgYTZwYTpYgXXL1pqrCabzRIvcKMoxmhEfTop/Cw7bvacNB8x2HOVR4zSqrd3wosiwiMTa/f9U3bMODrbHdpfC7pvaQ7vcIWtZE/gwJXer5iTxhcYhhUhjjmVW8caPFhIFLzwttgUA9AvsG/VAHatTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1YvSSEmubRAfqmi34WwK1WhStOGY7SgRq+fthSIqDU=;
 b=bNZJhfTtNZLsu+mG0Y21Ju2Ssn9nMglgsPhS6RvkWzNmD3MBNaJOM1XDx6A3vuBM24JLsvfA8UXR/AO4EwB0NOjstRly4M+SkI2EIjKEE8IlmY33Sd9/vx2LQF5pVq6Nu2dsR345Y1z8SQYEMRNOJonBCcTAvImYF0JyLRuNEo4tcK/KBY7K+fu81kaCInzab5TVVlC/oqvw+f2C5s8yEMR9JLRZ/2K5fdB9jG9ObgNYMdTow1VaUfIaHgAg26QgpgEivpLfH13e62RecyH8+caPZW0F8LL1h7HQo9BCr5PzsXFnQgDoF8C76LYikvZKROHwdnI+aE3yS1ZFishnvQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 12:01:07 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 12:01:06 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: set MAC address to the VF net_device
Thread-Topic: [PATCH net] net: enetc: set MAC address to the VF net_device
Thread-Index: AQHbKRjn9BBue9hR+EiETJY+EX3OULKcD4Bg
Date: Mon, 28 Oct 2024 12:01:06 +0000
Message-ID:
 <AS8PR04MB8849BA43CF5F6296E2D254C7964A2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241028085242.710250-1-wei.fang@nxp.com>
In-Reply-To: <20241028085242.710250-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM9PR04MB8275:EE_
x-ms-office365-filtering-correlation-id: de428dcf-7fe5-4675-d1a6-08dcf748345a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?a1YI31zLI5OiVt9EMsHlEtTu6YRiJXc5n/Qrj2FNb6piPLWLEJ/5tg0xaBSw?=
 =?us-ascii?Q?ayEQkW51TN8Kjj5zwWlO4Q8HWp2Yr+jBZRyyDbQEP4pbvDf/xg8uMu8ih0JA?=
 =?us-ascii?Q?yc0Qyvkpp/qkSdoSjgSjs8Np0Aw1D6C5FGkE+iZSNOM1wifsUKHupCRvi1gS?=
 =?us-ascii?Q?5uC/B458Loz3UkclCroUQAN8AAoVEsNltKeGq4fJdFHr4RvdAzVidWDi1bts?=
 =?us-ascii?Q?JcIZi4k8SxRhXiA9bAqnwtIH+OQsFuvORH/hnXGtnWi2axCRMZxWBA05O9ir?=
 =?us-ascii?Q?h0RzVUSXU2lXgwTKW8Ki3CrnyJZMrePsNjCfg5Pt8X7ZdG4of2JnzcBAN4YN?=
 =?us-ascii?Q?qRLbeOkDyEWJzCEoZcyoV9ogKT6y5uPnb4733s9CvpUPSK1KBJlHfBvAGFa+?=
 =?us-ascii?Q?Ui0tkZDSFy8ex1CS4Ihxuo9E7ebqvJJzmWRhyLE0TkkzDVV8+JSK23ghhv9u?=
 =?us-ascii?Q?ZSx0WBw7y+JeEZDXJEUYkHhSazK124iNxrIvlW3W9PBYXGeAHW/jrKXS6Yds?=
 =?us-ascii?Q?dap1oHF0O8svHop9JsgvZMmaKdeU3WO0qedZniAbYNYKem1zjjiSltA62zN7?=
 =?us-ascii?Q?i31wXdWEQ+4FFZpTbmHy1Wf3Q372A35uacs5NP8qlL7L70N912o2O/JT20AG?=
 =?us-ascii?Q?M2tRdW5t5cuXz5UG+MKFZ2TeevcSkS7kZT0MFDEz+QyVNeEm4OmFOHyIo9mu?=
 =?us-ascii?Q?U8qy+VpF9D8fxOS80X4X4r6GuVQlMEipK4zThVq1Mt/TAls8UP5BFk51WEjT?=
 =?us-ascii?Q?ZnrdjEwr0xdyURZaA8kYUVffzUgcz2DisQPzKSVXx33RMduaGt2f8CfcS8+F?=
 =?us-ascii?Q?bAoKJXs7LL7T/uyavvZas+DOpoguEuGm7BiCX2b1O2ANryxMExgJgke9ejNt?=
 =?us-ascii?Q?0EfWw7oyQjxsY2+73b3/ngBesKrBWv2wnaUq+/jT/ktRuJ1hYOCpADM3hncA?=
 =?us-ascii?Q?UDJqoCpZKxRkRSQypMLIhDHlb3OYc8TlzPEzEHIuij6ibN7fgXyrf55uGKFm?=
 =?us-ascii?Q?rKZu/WzWUvjmVAzAvMROpICpZ+1hdGUeKRCpnBCx5PWxMmp3OIal03afoEqW?=
 =?us-ascii?Q?g7DJoGJD2E0QhrYblsZnXSAbVnyTu53DKmmxxmfcE0kUINRF+s8wONVCfrQx?=
 =?us-ascii?Q?GFZThw5O1b2esg79ofzsgu+IRJ831DafntbAaIN/QGaHe9lhtuccTMFry976?=
 =?us-ascii?Q?TsiyUYLt0C/tmTQmTiKhzO0Av0Ak8HcV0cBhCYnmAi3NyS39NyYZBKt4osMI?=
 =?us-ascii?Q?5OFNfeaGKqA316yP9LYP0xkpjRsRdCO+Bjl/3V496UzyzINDle1tUM2VBpN6?=
 =?us-ascii?Q?3KGqoSuGpNDy2eYw7UAH3LijQyM4iM4AOI2PRMqfdnQYjjPaGZ086Zi241Ss?=
 =?us-ascii?Q?ljMFRXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dKFdCTehM9RLzdVyoTmLfsvn0HxVhHFC1TaHsmybkT9jMcu1wLZFoUtcyVI3?=
 =?us-ascii?Q?PLn8/0gwD6VdDpXT/MwW7eEpJ0EZQXCTRv8xdersC4HI4cY/MLp0vW8aMnjZ?=
 =?us-ascii?Q?8Uij4xTVnOTdPvWgej2SdMLZ6iWvpMdsXq69r/n0eUu3CCxIVJuJvtNASaU4?=
 =?us-ascii?Q?22qCs6RJwQ/z6Qae0wBp2uk5/VP0fV5sfpDtONPK3bZ28KzyRZoTQuIJF+jF?=
 =?us-ascii?Q?aKyMZNLGk08t6tnGpP6g3VkslFc1PSO7Bcyr4+3RoPJQFD0cAJBJbQmOgIPO?=
 =?us-ascii?Q?/uxRPJzNJvBr+T4cuk2cYIdTHuWtigp9smhU2hJlAN6VWU2EZY3mVyozFcp8?=
 =?us-ascii?Q?lncup5/Xz6t6SLUT9/nmCeWgjOfK9ZUhgyVu/GJAs8zOSpqgZvEv0HPiJNmL?=
 =?us-ascii?Q?gfo5SnP0WZ0M5OjdQnvD8g3GQXewUGLPqj1hmHgljl8Iyq50UJade+D18HQT?=
 =?us-ascii?Q?DWkcV1LFTNiNoHYQZTwd6XDeJckD70GJLqh1pVT287dB4rPZovK3XUVV4QV+?=
 =?us-ascii?Q?GkLB8WL66NUwDJq4yntqvXXOVMS0f7irRa3JqzCFamuncjvMzn8Cp/AkImhJ?=
 =?us-ascii?Q?NwRlRyNn3p5Nx1FC5wGAyBv3ZIZA+HdW9l/Q/5SsTrP9s7oZAoEyfIfobjaq?=
 =?us-ascii?Q?2cvaZqq1BklH9a3LKTHqYZEEvEMoo2h73toIB7wm/9kGibMYMCPGponsCC3e?=
 =?us-ascii?Q?P1QEkfqrIifoo8k0vUwZE8dVryvHWiLB9HheDe90jxSCIlRTi9rAxRzWNxHI?=
 =?us-ascii?Q?fEvnVYO9xRx6r+PS4OA/WxXTTe8b0D7Bm57JG4x63e99ZqKY/SzHpLpb1ZaY?=
 =?us-ascii?Q?wYCi0fSkkLGUp/tUTXcT9zmtsR0MdkeX/KfSDnaotuEZ6blgTlNXJnYIyZ71?=
 =?us-ascii?Q?see+izsWGmKFIaYZcaosuutUtrqXLfMtoJeijWKc9ZaN/8UUx4qUnGkO1L5P?=
 =?us-ascii?Q?9ISZBbq1jl7OcA74I145RMb+wIfwdl8wcT4OGeEAGSi9rtQ00gZItwoludDi?=
 =?us-ascii?Q?qVtH4Cv+B+yqhENHCyWZm1uPulnhUIHbS88T2WjW8+UItG8JlbWKHp6V5yZs?=
 =?us-ascii?Q?O5EgVRzySxz031W1UmdAa3oco0+OvAdKfVSnHT7/1kDrSZ92uzaibzhcm3K+?=
 =?us-ascii?Q?LynfShRcOk0Mswb78sZSQbUi0HuoMAj14okJBx0GOfr/GkZRtmla6Va0UFtC?=
 =?us-ascii?Q?ouEccxtAQLc0Fyq15yCOaNj61R9zl0u4XWvxyTgai6LGBnPEst7p6A1fl4Y5?=
 =?us-ascii?Q?ENJ6whDy2vbn+Sf/t+yWH+oi4/EOgXls8NuUezWiB+lYVp1tMNx7CR7sy0PI?=
 =?us-ascii?Q?I8mtxQlFfJkOGqyt7VjEh6EVbRGst4tj1HALmzpcXk/dh02UMY0naytws74g?=
 =?us-ascii?Q?8sCNNCwctmoUG76+BIwHgpHRI4NY4AATL3ndnbS5mrctCZe3Y++dnjHuuwhX?=
 =?us-ascii?Q?MbLOR0RhIJdSs/fykRNRUSXp5N51bHooqRYCixovz9YQ/2glZhQWfW8UeVu7?=
 =?us-ascii?Q?kaTlZ8ekp1WLfkkk/WVLIAO+IjkFg0EQzG84oaYjZH6FNk1MR0IJWPD92JAN?=
 =?us-ascii?Q?QO+xwiGoNqywtYJxK4bGqij4W/qtL8I2DxjTK5eI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de428dcf-7fe5-4675-d1a6-08dcf748345a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 12:01:06.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRjVzeyBa34QBtpZe2F7lqfYWhIGpBki4D56uNdBMHXiwr5PiuUD9nra9delRdzhGzmiaPbcdsdc5WN03wTLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, October 28, 2024 10:53 AM
[...]
> Subject: [PATCH net] net: enetc: set MAC address to the VF net_device
>=20
> The MAC address of VF can be configured through the mailbox mechanism of
> ENETC, but the previous implementation forgot to set the MAC address in
> net_device, resulting in the SMAC of the sent frames still being the old
> MAC address. Since the MAC address in the hardware has been changed, Rx
> cannot receive frames with the DMAC address as the new MAC address. The
> most obvious phenomenon is that after changing the MAC address, we can
> see that the MAC address of eno0vf0 has not changed through the "ifconfig
> eno0vf0" commandand the IP address cannot be obtained .
>=20
> root@ls1028ardb:~# ifconfig eno0vf0 down
> root@ls1028ardb:~# ifconfig eno0vf0 hw ether 00:04:9f:3a:4d:56 up
> root@ls1028ardb:~# ifconfig eno0vf0
> eno0vf0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         ether 66:36:2c:3b:87:76  txqueuelen 1000  (Ethernet)
>         RX packets 794  bytes 69239 (69.2 KB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 11  bytes 2226 (2.2 KB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>=20
> Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

