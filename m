Return-Path: <netdev+bounces-175744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9BDA675BC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303DF3B02CF
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70020D4FE;
	Tue, 18 Mar 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N+aciL01"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F620DD5C;
	Tue, 18 Mar 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306283; cv=fail; b=fexsPxOztvq5E6IggdKF2VZ+rHDYkRoj8OyYZtyigwYgvQbPD5M4tS2aTgwdepU8YZX6HHZnsLVuWmFIUrRKUJ2/Z1RX6w9sjyIAdOlpaHlhwP49C8bDBysdJgK0BznTQ46+YG8O6llmRn82WxopwDItkhYztplayQEz4lrqUF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306283; c=relaxed/simple;
	bh=4nbFtz1YjVIByACs/TnUxALLW0iwj7MDlsiUXWAkqMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9rdCAoy++wwny8k6lO6Ya6GyxW6CJZEjdgoO+6EQ4RmEmXbVO4pZoyG5RmRsCx7+8X8LBldNRbO9DlIb6W63cXgAj5k5fBGh4OaBDMzeMi0x5paqQnwm2ukjBM/7fULhIV8FYOEkEo59BEII6vAs3GizcxSRbXaHpgUqWNsiQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N+aciL01; arc=fail smtp.client-ip=40.107.103.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXAcb/2vEU9Lv+rHJSKG9F+7vM9/iVlv07v2hacNj8WrV0AlJjP2MuyTBcZ0xDGwhevXfq/M1mrA6G43hbvHBuQ2fk7KkAuWuDrsBO5/Z/aNrqqOdRee64GbITV90S43ldPRTplzEkWaUtgMIGN6gzjX44S69szQh/nz/JyO1vnpprvQ1aXzBndyVA24uW9UhoUI/VpIvNlyWTs2q2MznHVntlSRaosJch0dqUm8LetA+dlqYNDiCmOdDMGN1G4oLoCsSWGq9vqvzJGXINhl1DRzzhlarGvFSt5PEVOXsqquR5NGO+gl6yw+JGf2Z7wAEzby9Y+yBUvs04F8eydeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nbFtz1YjVIByACs/TnUxALLW0iwj7MDlsiUXWAkqMo=;
 b=glQjin/uw+NBrH3p0Owf1+2f7UGz5BmjauhnbebQSgPsOB0Y8RrL0nN0DI+e6qal5h0xNZGFbH6ENcVJnWeQLvSMq+/OBSiA3veZLbK54qQHrS0ptiotGwxdpSCkudzUaB5xUm0WGarREDPUH7P6CxUXr+JmiVOGfww4hbcOIfuSKlApd7+VT1cKxnQgGicFM1038S67SO8CP91ulNii0adI1EqQe7HtDlbzLxHtFpUE88BvABIFQBukHjOkR7q6lI6DmT5+4ybuongM+0JibuUw+GxzL89gPYcuhopez6XsESVf1tSeACj0Ar9TJdzE8gJTQ99eaNQa0rHUnwgurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nbFtz1YjVIByACs/TnUxALLW0iwj7MDlsiUXWAkqMo=;
 b=N+aciL01nvRJili32HRImwZFWl8Yt7TXqcOf62bUUP9D2wTOBG7s2ccVMm1j5gac0REowj8DH1fMBEHTnSly3DkrEK80v570FkmIzJmly89VxDgg/o6IEKYF3k9QHaOO5ru4SWqwW+q8B9L7M+5JTkbUJuf0OzME4ZY1dSLwLLY4OjYR1L02DgrnsJ6o2uug1I4+rA2DQJ9iRnB299DdEWh3Hl7L6VM47kvaXJmbk9vvMa4hm6RJzrf2X+uwEZnpfw269OUUk0TXAXWmEnb9UeIL8SbFAE6ezpMIj9gUkYomV4nn6qJrAZ1SBz6KuBQbCuXVW7noMGLdN6FINds3Ig==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:57:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:57:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 11/14] net: enetc: move generic VLAN hash
 filter functions to enetc_pf_common.c
Thread-Topic: [PATCH v4 net-next 11/14] net: enetc: move generic VLAN hash
 filter functions to enetc_pf_common.c
Thread-Index: AQHbkkpjqqWSAAAOAEKKZWKjEY8LSLN4umeAgAAryxA=
Date: Tue, 18 Mar 2025 13:57:54 +0000
Message-ID:
 <PAXPR04MB8510E831836A28A00C5CC76988DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-12-wei.fang@nxp.com>
 <20250318102121.5vmv4x6qs32x2y5s@skbuf>
In-Reply-To: <20250318102121.5vmv4x6qs32x2y5s@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8820:EE_
x-ms-office365-filtering-correlation-id: f38a1aad-7fb0-4276-4220-08dd6624e177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EvirBjNEjKa7Lrn3sR/N1nRFbD4Z3uiU61FSTY30N2RwAUTWCcTc8gwhy5F+?=
 =?us-ascii?Q?nPOmgRr1WFx6ofZW5F5keeeUwfCc0hWgovnlRAz1IPq4wXMY/4NJbJtBIibR?=
 =?us-ascii?Q?i8MBOONW70wIHcxXwP4qd35qnQvfP4GhU8kxaSCZypK6k2/u22lP6puekaTk?=
 =?us-ascii?Q?DTZ7M4XkRP/jJVceoGgOW/PJP3C3WGkNP+n8Y4e/rK0+Pg2Jj0QGG9enV6+F?=
 =?us-ascii?Q?EQBDAQOvQHN9FCAr1dSmfs6+kNLhXj/p9jMDYBAFgGE4/2Xfp7cPlYCPJ5Ap?=
 =?us-ascii?Q?JhxSWkxmEQVcTYyMwufwDD9OfMrt0ft/OqMTchIzlr8dvooZUz2BA6xG4XnV?=
 =?us-ascii?Q?o0kPMe6TbuTYV16ALE9F8F5CH4tuZ/hL+ivtLf+vsfLfkaxAv5e+5iuDjJFd?=
 =?us-ascii?Q?bwdbKU+QK/SyRrgucHEarqIOFIOU6WxlF8OIPQQVQbsBC9IXT43BZQInpgNu?=
 =?us-ascii?Q?m5CH1lUjJsqlz2to4rAzKe/PKcnr4BcR10RB5w7W+U+ZzT/UgFu1UlyLx1yk?=
 =?us-ascii?Q?1OL/TOLME+3FyZtwWWfkZVqofBwefU6KRoC+Kn72Fof4odcjquNMvCd61dPN?=
 =?us-ascii?Q?pM9xU++bNlBWVLH+0jBDmBIOHWMixo8h7v6ybuYyzmgG6ldDQioyK9F6s0Z9?=
 =?us-ascii?Q?CO+LsmwQCCybJml/xS9q+NUur9JQQGtccQ4Ed5e0uVLszmrq3CXkIvER9N9A?=
 =?us-ascii?Q?SrStnwZDYxbDPB+1RyLOejOiiRxfiUL03FpRHcDn1YjuPo2i+xkkthWSuaFH?=
 =?us-ascii?Q?HcCJJNJjjNMnpaA0QiCKkpceng+iLfuDpde300fNsAoG+q1qZwas+dZs2Yjp?=
 =?us-ascii?Q?QS7NJVnOPOa/GBptqQNV6vDqsG2i4fw5pUgtA+A0gIEL6vlgaNiysrGE49ND?=
 =?us-ascii?Q?C+QURqkcMFa0G+yYLE2/Ka1m884E7xy/ikl21enOcVfAgVLg+aOOfwKK9aEn?=
 =?us-ascii?Q?iQhIr6Czv41LRzDMBQADyjEFQcMoRKmpNH0WaGy5p5luPEELcjA/SH4SbnXt?=
 =?us-ascii?Q?YPpc7sW62aPEalGjLsgrqxFqix09qjpJbbBICpDJETrcJbwbUo9GRmGEnfs1?=
 =?us-ascii?Q?xj8X9lIKyCABD+Hwn2n8EU0XzVoL3olZkl6xJ8oVcQafaNY36LL9sb4z3aol?=
 =?us-ascii?Q?S+p/uXsYEKrY48UozNa77PKzRplfkuL4ig51VclbqBeNNMGyMeMUdGXg43Fa?=
 =?us-ascii?Q?c/INocBbaDeHNWp//Bfz7vahQ8CbqbxnzxtnFYfLnrs+NNy6YnuYY57bBpOq?=
 =?us-ascii?Q?4jz4pxSeNC/bv5qlhl2B06rvSbIb+ml8Y7HcdgUh0eLETQgewJ4p0wHaNIIT?=
 =?us-ascii?Q?pXE3EodnLWmVb+2LQqGRdZ2ksK1I/jN5iy3exhHHCI30jcCZQGcmVfQB+HMO?=
 =?us-ascii?Q?Rvt4PctUHgZvtVB/eYTfQTzi2wQyn8/mdwr+wBrfR6M9Zwqh8lIrM/GQoAwV?=
 =?us-ascii?Q?dm4zqfVDvfbZeUr5dLdSokCj80cgGsGF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WZvayS75+dePGVDqQHL/3HxHM5+fio2EmA6Dv6JTmNN9vXoVGS+SqejC3zqL?=
 =?us-ascii?Q?FUTzC5joRZCqYAXWjWAz7SUNu5aqnlVUPOloIeGGmSUGtsJEwOKzSWCBlsIQ?=
 =?us-ascii?Q?UN3nZ2ecXPvs/QndVZmFRiDrrjggGUGMzMWD0m4K2Lc5b0GC5cbhlj4/d16X?=
 =?us-ascii?Q?+4xXfJdDor6WN20w/05XEclPulODAzAvAnITCKBHkBzHQFftNu7OlJtQhXWD?=
 =?us-ascii?Q?oE7+8gagTDTkSdAwld7XQnzYc19mFkk9kSOZOBT181fY+M+lkEe3AJ6cusc+?=
 =?us-ascii?Q?xRU8si+BNkoUHx9LEy6v8StXAfpUrSlrc41gX+rutxBP6ABQTBXace3tnFUE?=
 =?us-ascii?Q?laq4vRUoHVDODLuCbO/tW7uTtCBWdGR+J0BWY9M8+P0/relk50/a8bBPwzmQ?=
 =?us-ascii?Q?2DZbppb8ACzjvBSPZiyV6N+1J+uKtFzD7xppskGyiKRQL5UKwSIY4kJiZ0tw?=
 =?us-ascii?Q?pg3EbzvN7ifEnN5kSUeS3cypwGy7k/Cl6SJ0x/U7gF11MXeYgF4isxPBmCeY?=
 =?us-ascii?Q?1NELGwlmxS0v+lfBATy8b7wPO+VMax7h4o/DK3hh0EUdVUacEn5aGyVlzUaY?=
 =?us-ascii?Q?mIH3InmORT2awL5iqKQT6spyKJoBDM9Nm/UgWpvwh5I1rr7KJzWZ0s9106nI?=
 =?us-ascii?Q?P0AGVC4tgMyoXdvojr4BJM96IMwC5G/9xpPNjEK4QUJ6Qic3XRZetK7AKS4X?=
 =?us-ascii?Q?m664qCYSrLZ97GEm8Mhs7zg5h+7eYJhcrqwyhTGWHNMWUmR6YyAP4x0N/Dny?=
 =?us-ascii?Q?Jm0r5LOLk9mW040E/HR7glEK/Aj9EUMmQvuJ1gkZxu/CsREFdCLfLXST0DR9?=
 =?us-ascii?Q?QOwlkvlL89+S5f3uz5eQO5V4V+IQl2P4FIEWfh0dtVhfQsbQeovY4vpGaWui?=
 =?us-ascii?Q?XQQ7fqagA8OJHz1wmkmAISPe0xltIFrpOMabOwzaQyGe3T6onPguLx/CQM8A?=
 =?us-ascii?Q?Z3rlmG0lVp6kVBBJGHmMHeGvbJJsAWe507YR9GT+Q8qsITEY8NZYBHBexfkz?=
 =?us-ascii?Q?yXfpfitYVsiD39avtCCI4VbPwypo/DYG1boDhnthIF7SXMVXItnWyIcioxEJ?=
 =?us-ascii?Q?6ZVAS4OGLm/LqN1cEEiokmszjUb2CdPa0yd4gPbcltfPKHGiJ1X8a2hyl7wY?=
 =?us-ascii?Q?6v/0axC/TQFaAnnmTDPPhhqCnTwV6ni7e46K7/OI6YFn3Qtg0gmkzOR8MFYH?=
 =?us-ascii?Q?2MnEIOuiMLLkC6D6Y5xjB759xMGlLmhzT9/kO+iy7h9aRvxZSCvV60xWmyH8?=
 =?us-ascii?Q?jxbAK44vG5iowRWJBPnEp4yrKel+QErx0Dle+eJDw5tYt7SLLx34t0/QQ6Ny?=
 =?us-ascii?Q?n0j305au0DdZ5wX4DmI8G9t5VqdPu6ZrUuxCgAWWb+kEUdSflSmFXMJLSEPq?=
 =?us-ascii?Q?UAfOdUToLbgj9QtCgm/xBsebCBECURLMHkGu3Y8NmBVxGV4YhGOj4oUqWvuE?=
 =?us-ascii?Q?plf+Qe/sNBeEZ5J+2QV7KRwNjfiHhi3KDdOpJy7FMk+ncF0OVrSjKRIZji+y?=
 =?us-ascii?Q?cF1AKGBsGAUiZ5jv3ZAPBwUXG9AaQruu2nzlvrmHV6voxRZ8qocooPuy7d6I?=
 =?us-ascii?Q?0TXDw5mV/j+wRd22Z0Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38a1aad-7fb0-4276-4220-08dd6624e177
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 13:57:54.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z10zoQAM0aWO8M9N6JWDz1Rr/HHGmL7zpbaM1BEj5snPPlS8v5PmLWRyeyV62JcoGRbKg+hpENS8b646A9Vk3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

> On Tue, Mar 11, 2025 at 01:38:27PM +0800, Wei Fang wrote:
> > Since the VLAN hash filter of ENETC v1 and v4 is the basically same, th=
e
> > only difference is the offset of the VLAN hash filter registers. So, th=
e
> > .set_si_vlan_hash_filter() hook is added to struct enetc_pf_ops to set
> > the registers of the corresponding platform.
>=20
> For the RSS hash key register, you added a function which retrieves the
> register base. For the VLAN hash filter, you add ops. Same problem,
> different solutions?

I thought it was a bit different, because we have a 'si' parameter, anyway,
I think it is fine to remove this ops and use the same way as RSS.


