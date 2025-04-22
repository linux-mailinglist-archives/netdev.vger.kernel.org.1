Return-Path: <netdev+bounces-184547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B5A9626A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA508188626C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82F29898C;
	Tue, 22 Apr 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="DY0Xm/Cd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE742980D1;
	Tue, 22 Apr 2025 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310646; cv=fail; b=uoQaP0TfF/q7hXG7tbwaWf68U7AVtM2pBn/vzbmqQrqFFFob+DwApx0C7fV/xyjtpjBMQJv56OgWjZPBYo1Jf/wIKQuYJ3B6qB/tdl7hX59MTrAWxrK8Mo2c8mrcgjlGfydgWVvJ+dOUQtjNtATt/Q8oAqbvDghqblC6T7raly4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310646; c=relaxed/simple;
	bh=VPGJnyPFaYpJPVGnFdIJCCOV5qHhP+yqqKpXxno0ZEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBJfHMit84jZARWqembS0IeAbSS4ieOgS4KMwfvtIYWV0SsFKKIGrCIAwh0ZzKSCcnly8dKuXEMlVeVosfmqJa+QyL6DXWb7oFuQoZyvM2xl3SVGVsy5POCt2oDS3hRdmtHCn2HPIwfCBEcmgkq6QicY9RuviDSOw6Inr4N/8qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=DY0Xm/Cd; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J91g4Mgbx+4OI4BQ8RSoY0cQw6xW572ASXlt00M2Dl6niH8uFWAJT+mrDizCcldlMMBJFdFo8dhxfazbkKqNDUg80nGbwrESf+AooTDTAKmIUSnj/ZpI8SaAMsjiNPo1nBdgIJKlgVPqXA0ud+XoEJadya9V7SNDOYjRbBSh6kob0yJ7pDzmFBkUu0vQiKZ0A1VJOYWyYpewb8HzNyJ8Doug8lkgiunDc8KLyDzt2xUTfThlLlRAvCCHXBl98Qe4FSAdyTyNV+DMVXrlC5l2e0Rdx4ONNvFut66gfn6lzctlbvYGQn+h6VV9Bq3I8me6pVXLjMOC+j7HK92N1gjz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPGJnyPFaYpJPVGnFdIJCCOV5qHhP+yqqKpXxno0ZEY=;
 b=ZgXF1sI4zNmua6aNszO3M7sobrnugmndu5kAM/mD0G5OnJJTVQyXeOPOH4U75PcsRQkTnf/a7p+1LAIZPmHrHcnHfZp0qj13L/ZNDlCxmz3FkcNHyxStnZe/GyWfThpw2otUMgkh7Q++ms04H4J9mpfIOe4Ox+P8jikFHRz8+LnBBz/1cVovN1KJ7orvtzNF9UxpKrDQjIOt6BBDA3wFG/Indiu8kzdA2+S8IXO/wScSO6HQYebScGOs4Mnf139Ah1hk6koHoH8rYwxtVMVzrNbLXlzc5XKKSjOTXzmOKSVOtm8qQcWCdDonsYkYSVKED6F4FHcl75XNLYbett0+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPGJnyPFaYpJPVGnFdIJCCOV5qHhP+yqqKpXxno0ZEY=;
 b=DY0Xm/CdcOgfX0qQ9rtMdcsgkmLDxIg2a1Lo/XRzOMVfFNdCsfHMpSoAxipNP3PVWJoJYnRgvyF4VisugRqnKs0yQ5G3NOtBqGiZ3kofEa0MK9xhr5I7KqvUqunr8M/KKC6BlWGGqM8BJUmGgjtkpbPsoxsbSp0GD7S2W3qS+HM=
Received: from AM8PR06MB7521.eurprd06.prod.outlook.com (2603:10a6:20b:355::8)
 by VI1PR06MB8926.eurprd06.prod.outlook.com (2603:10a6:800:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 08:30:39 +0000
Received: from AM8PR06MB7521.eurprd06.prod.outlook.com
 ([fe80::570d:8853:c13b:c7d3]) by AM8PR06MB7521.eurprd06.prod.outlook.com
 ([fe80::570d:8853:c13b:c7d3%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:30:39 +0000
From: SCHNEIDER Johannes <johannes.schneider@leica-geosystems.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "dmurphy@ti.com" <dmurphy@ti.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "michael@walle.cc" <michael@walle.cc>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH net] net: dp83822: Fix OF_MDIO config check
Thread-Topic: [PATCH net] net: dp83822: Fix OF_MDIO config check
Thread-Index: AQHbs1DvM4M+ls1LDESK0RNB9qSHpLOvVqCAgAAD6iQ=
Date: Tue, 22 Apr 2025 08:30:39 +0000
Message-ID:
 <AM8PR06MB7521A0F0650D07ECCCC013E7BCBB2@AM8PR06MB7521.eurprd06.prod.outlook.com>
References: <20250422063638.3091321-1-johannes.schneider@leica-geosystems.com>
 <20250422101455.08c8883c@device-24.home>
In-Reply-To: <20250422101455.08c8883c@device-24.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7521:EE_|VI1PR06MB8926:EE_
x-ms-office365-filtering-correlation-id: 0e3c1d69-b0eb-44a0-bdab-08dd8177f69f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1lzfcossVpOUSlplUWLNtSIrUsYL6kJSiRiy5SxgCNIrR2Ou3dTquOKaDG?=
 =?iso-8859-1?Q?b2zk5rp8ykxyfKMy3MGJFGqs9qnH3b6JZNTBuaaO2MGmo4Eewd6Fw+viyT?=
 =?iso-8859-1?Q?ZT3JRASUXyYKE6my722HbHzJ/b+5sRx+ShQeLpty2weNBzUzEfCCApcHYG?=
 =?iso-8859-1?Q?D1UMHSRKII/UVU5ABy4uFohP9pNCuY3ee0hu7ACzSAHlikgUfnzPOrIbMj?=
 =?iso-8859-1?Q?1ON6vQA8faFP7e6EWl4GftaFzrzeSPdQdTADmxchIOpTnSsJxuBfFKyvPk?=
 =?iso-8859-1?Q?OR4ftOZ7v7P0XmiOfqNaVR7cK+tLeCJrB9qqNecIXS+/wHxnVJOMD0mttC?=
 =?iso-8859-1?Q?Idec8NR4j3v2w8xIaYDQhGuypKKRcKPlXBcTFVj3sdDzqpbOmkIS5SJWn8?=
 =?iso-8859-1?Q?f/wi4YMksuHHq+W2p8ndEjrrb5X/pfYvQbCpfMYgoFDiC7xsBG9M1jJ+qz?=
 =?iso-8859-1?Q?r3E6NVOTjX0DqOQWFaI2/x5q+cPQfl6uaptRVGelbntOGYtZh4A1CI0zxV?=
 =?iso-8859-1?Q?Dg7wA3uhtHszQryDHzcPY8AaTIjx+2JDHFw5B89eiSBEwBK/JeLf3MRxGI?=
 =?iso-8859-1?Q?vBlmIUEA/7WOQesA3DND9PIzmiNqajW+XKHDUMRpwszAa8js2jecvUgkGP?=
 =?iso-8859-1?Q?M5WLLBNBsnTEVCLfDunUI0tda8uknwz3V47EijBaTVDnPQxt58MM28Dpms?=
 =?iso-8859-1?Q?SHTQERY6DA0TQzH9Jlm6g0llxQe0fNu/P8Zxtp8CxWHOHqGondSOSOVC41?=
 =?iso-8859-1?Q?zi5GXHmKWHjMg/Bs6qWOQcuK4vIK1hK64EgNZpLofR9lB4M2skB/txWcaD?=
 =?iso-8859-1?Q?ZSg3vXqcadRbpH1f3hwuFWVVI7JdC3MxrKmRzdp6kG4Xa2oPZps/WEg6a7?=
 =?iso-8859-1?Q?ThXHoIQqzkpHQLz3TTN2e+wBQw9q0hcDMJxqt2XO4JZ/Wkmn5hCenhLcNX?=
 =?iso-8859-1?Q?OVn+x682JltTKBWfUsiIAqYAlBPzdW1WAbjcMHVTjHEPQZIMPnsCoymjxY?=
 =?iso-8859-1?Q?Bqsf65bcETXhLophhn4NRg248Djw2e7PjW3W20wh3bB9V6wAac5J0cXC6b?=
 =?iso-8859-1?Q?XjOPrdqjWIpiYIIMky4FIZYEvwNBeIAGmWHyzWC5tcqWRKJp2v6yBjqdLe?=
 =?iso-8859-1?Q?RQhRSZ7XgEJ2UXs27NZ71iOeE5k16KTx2yHRF739OEUZa/UO7BzNqZrrAT?=
 =?iso-8859-1?Q?W7pnFyvDCr/MqpJiBz2+fS9uF+g5Gn+jvGjd9MAJ/BTobJnY7dAF6UIle8?=
 =?iso-8859-1?Q?ju0/hJ9IWDoSyrGvIocxZnfcXKbqf2qMfTq699k3eUGu9enOzYpdBI7GT+?=
 =?iso-8859-1?Q?Tb6oITw8rHxSXuw8dbikwtf2X62r4eapW+ZrzWs3BOPQHOmm7fI1HAro9o?=
 =?iso-8859-1?Q?zvAPRwPceEhe2kwqAXkF0kd3PNqZxkYfZHRYqlXSHLAvsX5MqOmjjO3FCl?=
 =?iso-8859-1?Q?Hz9Ab9G/Osg0zgX2XGXIaE6Vjr5ow137AxkxeCdASV0Lhr8alnHAinypGv?=
 =?iso-8859-1?Q?tC5m3dkDq4KwHqPYnubDzIK2LOFfwy4DUP8F+CHI+pQw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7521.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vaYngZfqznm4PabWX9WYvYDWwPC+X10tQXu64Xb5UghugZQ91uAFprr6lk?=
 =?iso-8859-1?Q?TsfUnRIqT/DzbDWNoe5PBff/R1NFEYDBBvvBUrO+HQBDlfeP1Mn9k1vRmT?=
 =?iso-8859-1?Q?DARIAYD6tXX3jITUo3GFkd/5OxvuWjrG7AHTvZnkIqwTHNAQuzp6Qqbp+p?=
 =?iso-8859-1?Q?M+Iz2Y4siFJ9GvZwNkzwpHBTJ/LBpWyRZkSrtf/mB6+mJy7n41EWY5+3vg?=
 =?iso-8859-1?Q?7oqBonvvRbO7FQ5KxzXJZ3lVco+ZCJLYSYYe/s1MRzROZrkwkQEBnaCi/u?=
 =?iso-8859-1?Q?RlwG8+W6lF9ETPOz6tQ3gaO9Bkvq2NNbP28tyzzblOi/PrKmuQ/IEsElAX?=
 =?iso-8859-1?Q?o6BHg0/u7rgD11u6LO5dAPwbv1fAUb67G+4gMTKh7YIBRpnoTpRjWpWX96?=
 =?iso-8859-1?Q?LZ9OlZLgXMfiUnTv2ZBPoNSqiWIWAj8yq+A3N5YRHaEh5hgmSVWxeojaFw?=
 =?iso-8859-1?Q?hcr26TsXg9D9K9GMQRjqm+nrtOR39Qit2Uy+9n2SvgopA+/Q/c8JHAy+q3?=
 =?iso-8859-1?Q?V2tah/t/wagiIBKssvRu4ut0eMPl/OW3rCsOcO8ngrnrwm3EW130MSHDHl?=
 =?iso-8859-1?Q?oySc+a4IyPLCkgDfbNwaLQyC1wqbLM0T40b80aHTF3FtMR+PHEsLKTc24M?=
 =?iso-8859-1?Q?oB5bjxeaseETdrPrGceJQzrhz1VWwkuy7nEBBaJL9pdH6i7BdxMelc/px/?=
 =?iso-8859-1?Q?F+dI82bLZD7SphoTyU1FxKQUCIqH0a9hFAYDEwsZDQZUn5lilpzMIm4HV8?=
 =?iso-8859-1?Q?4wNpEyVGwnLOisGNZcetquGAFOaf4UsVgenTnMNf7U2D7LAhssfOnLuFEx?=
 =?iso-8859-1?Q?lvOXcRfnV4TAEccM6YsNoDCywuUnM0uxVrtzpQM+M7/Xd+HL5g/z2GfYDE?=
 =?iso-8859-1?Q?IyGAv62675vjUT3zFs8ihTTgQB5Vf1XHW7G78N55ZtNhRe5yAJMf4Yyd3B?=
 =?iso-8859-1?Q?MupSLkKJsiM1cGo9AzvQ29T+3B8Q59JFISaPVDUppSMNGwww4N1QbpiV/n?=
 =?iso-8859-1?Q?2SUNtJNvVT1DkqhCjSmlhKG0E1fKWcaWpyS90NIuh3HchLC4RLl7dve4Sg?=
 =?iso-8859-1?Q?nnDF5NMTPR+blcJrEnnL1jmtcQCwNdI6vq83DVPtDBF6z1+vsUsLlwOFBA?=
 =?iso-8859-1?Q?1/zsNsZIRrj/qVvnGHiFpnrwbuqx/NK9B2NGqBdI4Yg8R6Bo/AwuMFbIA+?=
 =?iso-8859-1?Q?n0s2s66yipCr/a1jSdfV2/XsY4sI2VnZgzt7PfYrPB9GtsBcaEndTiNrfA?=
 =?iso-8859-1?Q?CWBuZHmprn+LtlqWeV2Lyyy2vbDutDf3XCpC/4e+GalGkhiZgdmKbR94xW?=
 =?iso-8859-1?Q?RQAM3FGCqGwvaq3pdpxIj1vP1wku1XCedcmzs20mWl+c4C4UptKp0g+8S9?=
 =?iso-8859-1?Q?b1/6CfxFZjSCyN69ZJ5G/PfOwEZvrcX8nZvKfc1SIkuyMXHCaSyyKoQt61?=
 =?iso-8859-1?Q?H7D46MZY+BYHHnYa4AdPw9xoW/sfCiD3JgcZjFV/y5Zhzve9Ve9hF/n1T5?=
 =?iso-8859-1?Q?mC3rF1BkeskMlCq5bNYPuXsia6f3fmcaqfGCo+6fiIkJj6Fq8r0TuXES5P?=
 =?iso-8859-1?Q?kll4l6UtM+z64Qe+cmJ+DFN4YZ/XetzDE8gxanfvSo6OaEY8EKPKZ0OChE?=
 =?iso-8859-1?Q?7HAeZteJWWeTLgLD2tUG6U5qw9Ffk7CW7eJk/sfga2oBxxdYuybnGFz1fE?=
 =?iso-8859-1?Q?8Cg1sGBtNsqxgsOV2wg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7521.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3c1d69-b0eb-44a0-bdab-08dd8177f69f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 08:30:39.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IegEMdrV/L16UAf5EIw3CokD8FrWcJMxQC/bbOG3msqHMSeLQK0J0C0hOOA/qHYQNnu2oJyxecSy2MAs7boex8qysuIrEjDmW3yvPSdTa6Yizt7zZDPfUbHR+JxmZf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8926

Hoi,=0A=
=0A=
> =0A=
> Hello Johannes,=0A=
> =0A=
> On Tue, 22 Apr 2025 08:36:38 +0200=0A=
> Johannes Schneider <johannes.schneider@leica-geosystems.com> wrote:=0A=
> =0A=
> > When CONFIG_OF_MDIO is set to be a module the code block is not=0A=
> > compiled. Use the IS_ENABLED macro that checks for both built in as=0A=
> > well as module.=0A=
> >=0A=
> > Fixes: 5dc39fd ("net: phy: DP83822: Add ability to advertise Fiber conn=
ection")=0A=
> > Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.=
com>=0A=
> > ---=0A=
> =0A=
> The patch looks correct, but doesn't apply. Have you correctly rebased=0A=
> it on the latest net tree ?=0A=
>=0A=
=0A=
ah, merde! i was still on "our" kernel: 6.14.0 =0A=
I'll rebase and send out an updated version=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Maxime=0A=
> =0A=
=0A=
gru=DF=0A=
Johannes=

