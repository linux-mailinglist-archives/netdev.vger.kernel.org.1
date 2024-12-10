Return-Path: <netdev+bounces-150719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62F9EB40D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4E418812CD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2F61A9B4C;
	Tue, 10 Dec 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jf5YEDZ3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCED1A01D4;
	Tue, 10 Dec 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842543; cv=fail; b=mWLrsXZsOF2UFSmXxjKZbTHTa/GX1bHe/cpUiAOKYrsmcmcG0kmRRHM/kIlloXQzkbr3N88upEylgTTbqyG31GnzHQcXKCAQ7gdV6J3YQdu3yX1yra50ftvTrLvbTTQotz8L9IaVOdgVWamXT6wQdmhCY8RPRtwdnngb3iRjZ04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842543; c=relaxed/simple;
	bh=YioX1xGJAxnaxXms3nkWbqIYgC1zYVz4medXEExk7lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=utpP5yyt8vE5n8lHL3gimxIT3lVf7AH1kNrfXcv86SpMGMMXZZ7yPhEyzuQqPpaw0fLZ1Ijf0geZO6xhXknzXYbsEUSMnqiJMnKiz+7ZGa5zsvVXnXQsTOhMHd1josdXsB7Cp6a/zJ7If50VyeG3LqXU7Alq6rC5MgDJF1KcCYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jf5YEDZ3; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqdkPY3g43DUfByZjvz+KWizaKL3+47NEHj8wf4PMOXn32FjBk4TxNytWNYE0neNdXi+PbIrIRtVMIAVjaorTf/3C2NUzTJ3S0Bm+W23WVV28C1tl9O6Dg9wqZBRQhfmdZbZp9IWopUPEC9tyTYLhYEH77kU/BUoDEZ12QzGBSKiUuunuB4J7OZIoaRO5w8lydvfbfVsUbY2i5PpjuI7bZVVtuUSb/7ZuOyuxGCiUjsyBOTJRu4QLT2VN+302k0GqwJ2wHv5FQmOZ5PGcweel/Y3yTZljeM0eSQ5Bdolqazg10vdWeoo5bmoR9qy+ga2lvc0Lly9pX1gMBceXrLn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDtNTvzSKmv0BY9UVC9PANJdBxngFSkvVn6+9Fk+/PI=;
 b=GJCwd5C3cOsQIgykfJTJOuVG9+Ci3rXkNdv4iwUghJSf2Rv3Qm7qYenlm7oPE3M9dl0OTtfg1Eyj0NeDKrajy0clzBYYSImAxfo5SlZRL4KYTuSTio5xiXHxdV3V9kGmzvVp3IEo3VRwsZxOl68/TFkxVwdqnY4G45glpw27XwDIlEmz5jM8fzq4wWnB7EtRiHeM1XWJJV8j3wMCZKAWIEx5/qQmc40nIvcOWa5/ks2ZRKQnBLoLp8dDnMtRlQ14cg/sNqwJqGM7XSBM1kLaSDkqD1yw4migJt/inHCTiWOwkzOFfr2xNM5D6MmTBV7I6d501BhiFc2iz3LbKFd+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDtNTvzSKmv0BY9UVC9PANJdBxngFSkvVn6+9Fk+/PI=;
 b=Jf5YEDZ3N96mqn6th4YhcUEzcBKkfJgZqXmjDEF6E2JY6tGSlwqxriiFQHG7jT3/GxdDmdw0CTa5a+5iLS3Cog3eXaDP9wkMe4xdHTFOT8vVNGTT+NyQxjkEx+RgnEVpb+8QgCDSCbMGP+/6atD+tUbZYlvowBlijJl0GAolBn7N5Nk74BOr5OUa/pi6gsPhmKQ7NNxiuZUnF4yoAifAtGkD5nx/gow5rPr/pGmhcsyEPmn/q5+8bCHV1IDR61P8tftBXBb+4RiRoYyy83749k1FS1Cc68Rd/ZZjOQEUckBbHbel+JdxcmPj7dXLopl4b7gmYmBcqaFr1cnovVevVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 14:55:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 14:55:32 +0000
Date: Tue, 10 Dec 2024 16:55:24 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
Message-ID: <20241210145524.nnj43m23qe5sbski@skbuf>
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
X-ClientProxiedBy: VE1PR08CA0008.eurprd08.prod.outlook.com
 (2603:10a6:803:104::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 3447b0e3-838b-4aec-55d1-08dd192ab1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zt5U2EmpQzPLX1HBWtvyhg80qIwvhxHfEQPDQ5z/y5UKUJhfCOrocseRAcIv?=
 =?us-ascii?Q?VEgfjv6D3NY4DhI1nqOntFGujP3/R/2zVjYiBc2s+SHq1Imm1BWDvY2lNblD?=
 =?us-ascii?Q?9dm9qeUHWsCFg4XQo7PmOF7gLHx9FmEjCnIHes5QghoOoI7pocapa+ELCxTY?=
 =?us-ascii?Q?pEkJFuf9AxZZnKXEPZsIHGfrZBu6DWnO3jSu6vd+LICL4lTKCtpIDCP+4wnq?=
 =?us-ascii?Q?mf043Z0JJqcTJRwMM8GOG6E/El8SMrc0hm6iwuHh5JWhzAXah9e2483a+Kob?=
 =?us-ascii?Q?Kp9w5akVnwsM4czLvVgPibJ1InnC57uwN7rCI8X3i6ziAvrSNHuT3M+k5emn?=
 =?us-ascii?Q?Pp3k4zvjLT4wLkzClJ9CENT1QsHz/83zjNUyyGKaoAcLxhrKy+kVQk4+XPml?=
 =?us-ascii?Q?xK9s/iprVNmYEMNkPVrkxUmJpYOpsfCm9K8SzNo8YOXSQmOySEhSOhqQgadK?=
 =?us-ascii?Q?RE/pTh/rtWgIkLymOh9lElY9KAQQQw5zFaEPTNEi0bIFtfifu2krhaS/eLgJ?=
 =?us-ascii?Q?4BE++PY+3BSp6Ym6k7SM/qNYgRnuPSrTqUrTTKALec3cjKj64HNIHLl3LfAu?=
 =?us-ascii?Q?Q0qGVLY+pL3wBSR6vnooF8dPQeWRgjjrVxLs/OzBnQtSqFduhz9+/tTu/GWh?=
 =?us-ascii?Q?kI6RLZmB2cuRQMPjWcMU/Ol+8emXQI9MNTbbwZTnOmcas6g2od5MZKIMg/Oe?=
 =?us-ascii?Q?+SVBddbFoDuIW4TaN168GGNIC2+4JppufAHE9+PmJDCgOI2MsJdQCxUjY+NV?=
 =?us-ascii?Q?Mt9QalLLe75i9586TtjBjTAioSIO4/IleCYz7TKLEGMngwmviyK7gaFxDM7t?=
 =?us-ascii?Q?uTC4mvMrn6n3sKhpiycWG+MqjrI9Ldgfc+iJ15PL7a4n2KFXA8BJ+tNrG33p?=
 =?us-ascii?Q?YE2/KuiQrfnI//BMBa+vziRBJ/JoAm75I4HIi+iYn9Og27sf81gJh4cGCXMp?=
 =?us-ascii?Q?jyDs8zLK+0X4Y3nBfpwhIiKVyJNvBqdNyxk1CgZiEUFwXm53k+j1ItC7uvKM?=
 =?us-ascii?Q?Jm9D/3OkexU149NZ9pLCN4HUiBZROJxDnkXuL28PNJD878d3RhXc18ro/wlp?=
 =?us-ascii?Q?yKft98j6ERmw2WD3ByjBXGbiZuz+vMDL0C/7K2zdts0Dvamb+civmwZrWpvX?=
 =?us-ascii?Q?VYkQOXqk5jbqhD0s6z2JxIWDO1uWbi1Ac0ZUx4Fm3cJZ3zz1qf9GHLcVKQst?=
 =?us-ascii?Q?lHRVt3kTv5uMsbGxvSVq0dtM0xvYLe7KUzS9oSuYE2MsCPJdMJXLkfIDwjj2?=
 =?us-ascii?Q?QQZ78aXeJvSSD5DYOU0IbNA4VIW1kNTmluGen7jI8/0ohpQR3RJCXEdnp7wv?=
 =?us-ascii?Q?AOVTT0rduTquA09q+BoQ1x/lB1QN0YTH3adPRvrm6m6V16ulz7+UlxjykUK9?=
 =?us-ascii?Q?s7LTMVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RQuvnljd2QGapcyzQAbzl3TxDk5ZBhLn5OGOD4tyvs60jikQXT92i9D9tqyH?=
 =?us-ascii?Q?kNuNF3Kk3ATxFEDrfXzFArwQ9IjoTtBDYZatuNzIGk4RvDDakp+ldtIc0E7F?=
 =?us-ascii?Q?PCq3HAXQ5ZWDHYdykTQrQGYSDRkRFqBG01n0z4/U7BjhYoyHAYHdnDXfbwMI?=
 =?us-ascii?Q?5arrPdEqYf1xHtUpsYG5OExTYWaIiv3dfavtbsVG+2seL7vwdI9mkgV8bTOv?=
 =?us-ascii?Q?l9RLC/JeAmgXi4oamBdYt8EW2P3ObxKwSlr/gZMogK2o6vukehUxrMC86GUR?=
 =?us-ascii?Q?SIZYFHNEZVoOnMdVLSquCSx6qexvO4C9Cy2NuRE5YU0sVKyWNyCO5b+Et8r3?=
 =?us-ascii?Q?kBIZfXgclx/UFC8kY3IdF5nbpLgQWMnAFLBuOr8RjsylIu5Kw/FV8+845WQk?=
 =?us-ascii?Q?EuJhJXhhlnSYjaI2vmtNwFQWFS2ZeDSfvVhN/ySTemzoHvgw4vCnFXOzPBDE?=
 =?us-ascii?Q?csurDIXO/gqHG46rqx6GAz5cKS83HgYAD8EztwplN6BziJkan48/ZoXblhAx?=
 =?us-ascii?Q?qy3LLxnq29Eh5l633UGO07+E2GfjHA42AMLJWgwdzRSd1jsXx77SgVSL6hN6?=
 =?us-ascii?Q?VDnztMivYqgr47soFU0r7i0xwa3KywfPnE3dXH3S4cqafqGXtZ7HgNCjJ7Va?=
 =?us-ascii?Q?XPMIFW/bilDWKiRnyfDKLRQ3QquPk8s+v4kphHof8xAYY6eZl7ZY0LaHsfY0?=
 =?us-ascii?Q?CXES5QavpsKCfHIMESghwBsB6n/q0KXUs+ac8kqWiCNS8XckFAqJKFgJi+wC?=
 =?us-ascii?Q?JKuieN3XDgV3/sNrL37xIzIKj9ycmOHtGPDlMuVYPzLeGzmEg992Xs3xJC+/?=
 =?us-ascii?Q?PKitZoP3QIk7HjBVV9iQEMzLHHfm1wWYvnQyV8j7krcKQuSANGOK3RKf26aj?=
 =?us-ascii?Q?luav/pFGWVxiEszF88FQi7ugzPsX1wef4FmHskjn5kbvcNQ8mQGjlj6L9gmH?=
 =?us-ascii?Q?tXo/D64edGwGgXvjzgJyJxN94wBOMaA5nIFf7g+WtPIZG4hhdiOtBeGv+RSp?=
 =?us-ascii?Q?MIzYoLmFErpccuMBFGlKbCas1FH0/FRpB+CvvoSJffFuHYw7gzT/ex93UIdn?=
 =?us-ascii?Q?752xrfz19YhFOjea36Yps/eWgmoZUYlcYn2KpJtxwcOOSCxBWRDAw8yrn0aG?=
 =?us-ascii?Q?ZgmXsvCadyK1zkY9NZtBm7Zde1CincRepxgEOBrd/0+6qm5sg2lJzj5xHAfe?=
 =?us-ascii?Q?MHRlryXcUsio7E/KTkOMvzYCYRgo/vmuLlCyidHwCGTF6JrmiNKyCjD4tq2S?=
 =?us-ascii?Q?zWtrmASewuf78HceMNukk7suonzQbfZYO1uOt343NYcSPYfwKsyWyrATUY64?=
 =?us-ascii?Q?wMxZgJzrgsWhRxZR9ftlR0cWaKhQnhhi5GJEOX8mFRFwhPCiWjImhExOId2R?=
 =?us-ascii?Q?/5AOhKprYmrjdQM2G3vzprwQXccusUBHfljyIb2ajhaFqMOX2k9HMCdVf/AP?=
 =?us-ascii?Q?BT59D+7kdkqe8AinxhrOKpPMEXm60ddWwdznGt0Gjp/fRJFWLgwHpSXtQTaU?=
 =?us-ascii?Q?RxdX6PEMcM/kq5xVXhPToBTOb4f/G/gNYKyXAM/YXsjJ4rlHOZmwK6xb1NWC?=
 =?us-ascii?Q?1gS4fw8BAs4rbfqOkz488jMsqo+YqYBHabQYKacryypWnMSjCdi6ZgaVhRIX?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3447b0e3-838b-4aec-55d1-08dd192ab1d8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:55:32.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXg3ERwWNGVjyjdzYKp40kc2BOrXFsVeJDRrblG+Id1oP+eol2jJ8PXh5Cxse4aysWb+CZ3B4sLDddc3Py3lhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9071

On Tue, Dec 10, 2024 at 03:47:11PM +0100, Jonas Gorski wrote:
> Huh, indeed. Unexpected decision, didn't think that this was
> intentional. I wonder what the use case for that is.
> 
> Ah well, then disregard my patch.

The discussion was here, I don't remember the details:
https://lore.kernel.org/all/20220630111634.610320-1-hans@kapio-technology.com/

