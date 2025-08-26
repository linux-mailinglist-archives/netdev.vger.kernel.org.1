Return-Path: <netdev+bounces-216764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D70FB3511E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BB43AF919
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B81F0E3E;
	Tue, 26 Aug 2025 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iNl3J0M6"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB21F956;
	Tue, 26 Aug 2025 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172643; cv=fail; b=REgEP2SDG2ztq4Dmi1iF7y3HbLv+NVnfOCZpPpf4SeLM1jai+6q1nYYLtGxfm6CXaBlxOZ8y1trZXxbq1fIqLAUqI/DUBXHePdtXJdrvzne7k3zkeHztBsntW3X7g5gq02jW8GIcSyNRLrBRM/zRVdS3X81fG8vSXM+j9K5ral8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172643; c=relaxed/simple;
	bh=v2CQ3DbtLp8u07XyTRncKz9cG+86wRMkEd2bHL86phk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fTss3CcGUJdhv2P8Y7TofjOk6LaYghv7qBDpj9Oelx8xabEAJv5CyURrBfKnLr/zeTxXJjD6Vk9MmIptB19Y3JBKoSt+041WK+08L1JupiehObPnIuZZavZp0VNmWjSECJnGYWJh+2OI3iTvcTFVnAJlnI4nJaBrSRBrJqiP9Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iNl3J0M6; arc=fail smtp.client-ip=40.107.130.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpzjXUvUN/C3S9B7W3IoNVSt7/NdAh5UXHMOSoaA0l44OudmUwkzD5QTGlOaDEPVPTl0N0GXpfD21UvF/WF2CVf8+EZbxggEfOz9JeLZ8AeAqxekBQJoQMhuRk6LFM/GuyN0KLXG8cci7yemTJQqg82NbdvXtWxYScVc1UP91q31SIOcmvx8XyQh1VThL+UJrb7vBM6LtEaKtiwqRd0fJNigbhMp4xbC88UKFLrDmHCl6xZwUmCn0o6VneHoz+5811OzNAEKjp5nkoNe0zdUt/igHTdnlHYoEW2ba2KYg45gyzhpzil9p1jUU+r23dFnnAj66aQhnoym7znCyukeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxQgIXf2MAPNy0cyS00INeRmsn6w4Gp4h0BvNAKXH4Y=;
 b=icEdGLng57sMMp5Osbbyhev3dheyZ2Gtm00dV85tCHJ3NK5/WPCifEd2FFbQLCP1h5yKauqOGSgcNbH0pr+yqMcYA/E5Wu9XHVqD9Wdv+MYbhlEA/52vBwFFSwn4pVm83EJhufeQ4tj0uSqTrrEmpHLKY0OTGrjwX0kKlZzFlsTDXN5X6fzy/YakrXXxyYBx7pOKp19sekdLMXPoF9wym3gXIx1WnM2qVG1q0NFZJU2n6DMMs40JONeEsaI6s3AU/62UlapzpTsb8PqaLb/UpayoERk7zmu+Raeyh02q30vT9m9EPVKkD3FjRXkI+o2d3eVE/GepHw1A/HxmZRhSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxQgIXf2MAPNy0cyS00INeRmsn6w4Gp4h0BvNAKXH4Y=;
 b=iNl3J0M6adtlV8shdoFHSuyvs2VAw2DD0TnYoGQgiJ9QxfBxt9qgXzK3MugSWpk3fuuOMGjAr0fSaD4QP7FztsVjniNTgCJygHT/o6UKovrhHrPAQrS6mBATweXgeViJF0xUYHM0NOmsU8f6YiuNVyYv1iLUEUT+REx+lpNohgCkFKtcw2gA9OwcfMztXwOc5ksAm8a4e0Fhu2pXFcrP1k14v3oAWOyN2BXWvEk6NrCEonDnOkAA0HSIBND0ncqQDO/HYkkpUPNJS3KFnD1ASECegG+1a9eVIw0PZWOJAZt6pv5kemgZnmAPcYErphdyOCmCD1TANYJbe4EyV+oCXw==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by GVXPR04MB10612.eurprd04.prod.outlook.com (2603:10a6:150:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 01:43:56 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.9052.011; Tue, 26 Aug 2025
 01:43:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcEsoyoJ7sYfSghkG8db/Gx4Jg+bRucgcQgAA6/YCAA/kJ0IAArpIAgADa5qA=
Date: Tue, 26 Aug 2025 01:43:56 +0000
Message-ID:
 <AM9PR04MB850566622D29C9EBB70B69188839A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-4-shenwei.wang@nxp.com>
 <PAXPR04MB85106B9BAA426968D0C08678883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB918588241A96C60E7E7E4FE2893DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <PAXPR04MB851035376B94859B359C3A05883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB9185FC62D5928E5B265F41DC893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185FC62D5928E5B265F41DC893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|GVXPR04MB10612:EE_
x-ms-office365-filtering-correlation-id: 0c8cbb16-87a0-4087-405f-08dde4420524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Dj11jM/KEh6qM8CRvrmHmxCuoIkXSL/CHRg31Nch/bd3eC0BjAO/9fdlmCoc?=
 =?us-ascii?Q?kZTdb/2LVVz6MgeZ4DGkvRC9f8vhTPg/kDtqS3N3H4DgIUQPS4F8JaRs33lM?=
 =?us-ascii?Q?GlYqF6/4EPjOJC/uaOv4t0sweOee2aEZwZIFOPhYj6vk4zoLCyNsCkPI4nmz?=
 =?us-ascii?Q?QgLWrqH6jDZBN0xsDdKujPG/GyT4DRsq+3aSu6UXv98Nt6sgS3HT2ngDdXrg?=
 =?us-ascii?Q?c+tzcQp6z2PVhWyPLMG3ditcQV9T8/uJW+Hida2QEWaUzjw6vTPEaS0soKCW?=
 =?us-ascii?Q?rqBQeDxCapkIgmT26tsNt6Eae7FqYXFfQkxyRyz+rW1J0me9i6TiJPZ1WtQ0?=
 =?us-ascii?Q?NvmFOKcpWDcjNt+yUI/i2u8aLYqrVAVWfK5ueJhHjtZ2VGzhIVzWU6XVqDsJ?=
 =?us-ascii?Q?B6zPmFLqJTfjp3/3/udd4vAsZWYrKMFo2kEalXj92NpHHul5FLXI/DGw7KYz?=
 =?us-ascii?Q?cBx9mtxLCFt1NQIwUgwMu7In4BijZCmeX5ZmAt5nKepEoFndr5tspsSTTdyq?=
 =?us-ascii?Q?DbcaSb73G7RIsPtlREHO/M9peDq8h5+YxHOdfm2XKzSHVS2JMh2lY0HI9N8s?=
 =?us-ascii?Q?oDq1+7yeLxkZUFQ2aEnOZwWElSZEoZ7HQn1CPx7IliPTpSMjfnQVAn4V/o16?=
 =?us-ascii?Q?D+g9HwbpLs2Qgbv3ToezxyrCoZNb8OVhK/x6ZC8J+LUWHFmkcACzErvl3UZC?=
 =?us-ascii?Q?9jufZ7BAxMsXmakgGdsdlzGPyjpegXJeUffX4I/P3L/qWAolasfyDYVaXO6S?=
 =?us-ascii?Q?pKSVOOmay/VgxC9FB88Ejgku8FrhjDIbP5mwXsT2QtmoH+yiU/7lOGc1d3YS?=
 =?us-ascii?Q?xc8U/DIj2uvA1WV7yuLhg9ULqYVDJPkMGmEpTpAaOUjkY6to+pTqQKYIkgNF?=
 =?us-ascii?Q?nN7MFQW9eVgGARWLTqVSeyE9oyqM8AW8Fht7tuxgP8YZmiR1V3KvpKg/tgnJ?=
 =?us-ascii?Q?PlISd/KFiTWTvzSr4GPYJJEtdvSpuOI6wqzNMtbVIWOp+vAnh/WetWxXArdq?=
 =?us-ascii?Q?7eQM0JFsdx8+GVkSGZ+3p+GXaaBgklefaDH/lGIyY5yqWwkQwdOkDKXEy+L4?=
 =?us-ascii?Q?6fbsPbOUcf/iBk32A5l/09+S+b4IUy9V44XLmuNLfGLL/97sMqfaf/jbGzfw?=
 =?us-ascii?Q?p4rmE2lDaB2rMtGEwLB4E4RlJofSa5XM8HCatclUUdqZ7B6J1zhvZx0Iss/7?=
 =?us-ascii?Q?PkPa9QqFBKzZx0kHfm+8TDpgbuD1gRWb2Iz1PZGj1gyY3QyswKl7HnfwCw/8?=
 =?us-ascii?Q?ed07y87fO+5PqyWWedtpHCh/x0vYDa2hIbaP+fBK4yhY2nJOWecnDgZM3EJ0?=
 =?us-ascii?Q?72ItYLV2hq3OnJwT4NHpZjCrfsr5oAWNb2ljri94mtguehnI0Mm263ydWJCB?=
 =?us-ascii?Q?AFmFdtfVs5wMo13Bchh1eI/JAinaUgUID0X+ZoA4K5yyZoMMN+9Zk1kI0KW1?=
 =?us-ascii?Q?iQxczU7/6NAQpyMOopjcd3sJCFua6BD4zo4gFlc6SdnRU0W2w6WrqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BHlp5FppqJ6wh3GaEQ/GQW+4OrfDEmfD0iw45kIso9eqBk+O0Vpfc3L8ItJ2?=
 =?us-ascii?Q?1b14/Q10gZX6dgeAUh2PcFhaCsG+tDmR1xlZE/6RkincZ/Vdpk8lUvST1d3v?=
 =?us-ascii?Q?QWJy7WgQKoRRiSme0hyqAM63bqLd+dsSOH18SIdn59mKXcOsViGpa27b32xK?=
 =?us-ascii?Q?6y/wP+N2MJ8XC4i++zsp2zOSJQY67bDhHAnVuxjaw2Tay7RDMFU6RJxNWlIF?=
 =?us-ascii?Q?IOIrBY2c3RrzBV20JJtCpvBWw2NXv8fAAkxlc8Hw+VQHb8VlSgx/9v6mU9lz?=
 =?us-ascii?Q?dNPXxrB1b748YW0wKbT6425C36yJ0e4b6TpKjQn460DqRuVFDAZNatFhKv41?=
 =?us-ascii?Q?/4l5FK/gX80oO3PtGVSNHSsweHf1lbAJkdkb/mpecF84SsoOKEpdWXp5g/tl?=
 =?us-ascii?Q?b5zX0ETd4y76Fq6nuTRnmx8UClfpwAla2/mw7yzbdkQ32Qn9VCG3UXRuoKLY?=
 =?us-ascii?Q?T9sZk+qT5Fl+I7fU53bnaSzqw/wT9HGXb7u6dv4dd5jPMrpg2kT/5L7awm4A?=
 =?us-ascii?Q?ZGHvOExMvZ+ZZsDV0ptwHpm8Z2WyjDBj2cJZbV0NYhkzIBxBtvlq/dN0T3rb?=
 =?us-ascii?Q?JVDTir5Qf3gyMJc/THYVq9cuoksJk7/pcyTvsMPAezEcwkdaLe6hyDYr3iB6?=
 =?us-ascii?Q?h70zqJDuI81+SynK1cMGKrYTo9lyUPbUFPt243VSE/4lyN4CoAqVb0wKKMn5?=
 =?us-ascii?Q?NAzCjrTcqmPSey85H2xTUaE/rxY37JytShCdWBmdNNaE82xUPvOJmSPC0jWb?=
 =?us-ascii?Q?dsbs+Pt2QIjPSiPSpeLy3Wo7BGg5k/UWZmE1/HKPNgPEh1qnC9SatrQ+vFvw?=
 =?us-ascii?Q?zd5ZIHvK73P4WQRrQyG7NLqM2LPHFy9had5NuGmAQ1Gr4C6KVYQc7QblXyWr?=
 =?us-ascii?Q?m3Cg7i4rKzP7poWcLN96cdB6kIF9B3WpWUwbkJpUX28HsffcXU3Ok2U/aWQ6?=
 =?us-ascii?Q?x0B3QXQ6gSeIHdB5P6YBUvO47Mei/BWhgqHJrQv07Lo3to13HVo6qXCnTEZT?=
 =?us-ascii?Q?kftj5xQtayOY2AfK7sr6c6zMf+CtwXzbhUFkBoC/2NUOJom8fm+IR9CZk4v0?=
 =?us-ascii?Q?djCpN+v0AEyEwf1/yU2QYBskvrJX27ynw/XUJmfWCLADZJdIPIq2n8/8Wsqk?=
 =?us-ascii?Q?Hhpg1+QDUjjY3zrsEIXp9pi5VyWl+Wd/tcQg7S3yqmhXnGbny4Y7p+qJEgeF?=
 =?us-ascii?Q?c40XmB/y8BEas/CQugoruHEpryEwuzdNLvjtIvcipxz0EPcZyYo6SsFI18Qh?=
 =?us-ascii?Q?LMaqd2IDhNA73FCT0kRQ7dVjPqppWkmpOiJzRIlC36bhlE9nZegfqvhmdCTZ?=
 =?us-ascii?Q?2RHDXSVaB1a0CiPGOPuPPEPsG5g4FJcUEs+X13UU5donH4OU0vS+V0pdFA6M?=
 =?us-ascii?Q?ymm0ZISscOjH6kOrujnL0LnQIDsHEabaaAnoaRjSTuwNmd7PI/9bfNA+z9Ip?=
 =?us-ascii?Q?B2gXpsQno+zCsc4xseZnWAg3MkpDFQG3/diXS+IxBgko4nCtSo9udd97EPB/?=
 =?us-ascii?Q?GHTsGI6f3IHv/k8gdnj3hnupN6TRSGpc3tzzwcAGOmNisTp5HqfEi85OMNwC?=
 =?us-ascii?Q?lSEqOhjbs67NRB3tguU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8cbb16-87a0-4087-405f-08dde4420524
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 01:43:56.1455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW7Qbv2HFGkmSB6frN0E5gBCE4+gaV5YTha4iIrbMNNj20v1k6zoAcuLuo+wry2Cq5VuzcvcKcyTjqkU1ZGeTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10612

> > > > > @@ -4563,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
> > > > >  	pinctrl_pm_select_sleep_state(&pdev->dev);
> > > > >
> > > > >  	fep->pagepool_order =3D 0;
> > > > > +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
> > > >
> > > > According to the RM, to allow one maximum size frame per buffer,
> > > > FEC_R_BUFF_SIZE must be set to FEC_R_CNTRL [MAX_FL] or larger.
> > > > FEC_ENET_RX_FRSIZE is greater than PKT_MAXBUF_SIZE, I'm not sure
> > > whether it
> > > > will cause some unknown issues.
> > >
> > > MAX_FL defines the maximum allowable frame length, while TRUNC_FL
> > > specifies the threshold beyond which frames are truncated. Based on
> > > this logic, the documentation appears to be incorrect-TRUNC_FL should
> > > never exceed MAX_FL, as doing so would make the truncation mechanism
> > > ineffective.
> > >
> > > This has been confirmed through testing data.
> > >
> >
> > One obvious issue I can see is that the Rx error statistic would be dou=
bled the
> > actual number when the FEC receives jumbo frames.
> >
> > For example, the sender sends 1000 jumbo frames (8000 bytes) to the FEC
> port,
> > without this patch set, the Rx error statistic of FEC should be 1000, h=
owever,
> after
> > applying this patch set (rx_frame_size is 3520, max_buf_size is 1984), =
I can see
> > the Rx error statistic is 2000.
>=20
> I don't think there is a case that rx_frame_size is 3520 while the max_bu=
f_size is
> 1984.
> With the patch, the rx_frame_size should always less than the max_buf_siz=
e.
> Otherwise,
> the implementation might have a logic bug.
>=20

Actually, I have tested this patch set, that is the problem I'm seeing. You=
 can also
have a try, do not enable jumbo frame, just use the default configuration.



