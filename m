Return-Path: <netdev+bounces-190253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465CCAB5D88
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941461B470FD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F52C032E;
	Tue, 13 May 2025 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iThJB6gX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F411E833E
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166819; cv=fail; b=ANJ0khO7BOrSbzyP2hB783Lm/uecxq+OWyz0Gr3wNiMKKz4syQokqxOyaAH2DJlq/uYGkOna6I4YdECrbPo60KPDKNlDbsPSXB1ZKeFx7mqZKzastfOCbOBKwPWkILDoQepuglF2W2rO7I3k6zOxjThggyMsL8y9YDQwUbe2SVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166819; c=relaxed/simple;
	bh=MBKcCKdsm95k0/u5tMmdTMDgF6gZGR66IG/E24RlHhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aD7wJKvTbh7+DRLrbQ0USWuQtRB+tskaFxAcD3Eubu9nFD5zak4Kulvm1PmF8Y9voIr+LBqTtKg5SQ71r21ev8T/226+JQw8VAeR8OIct76YH97TReCErl19aG7zFPyn6ma4uk0M1FMOyIxFUgKJUmCBOYE2yd4vJpr+FE0LIQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iThJB6gX; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvK06/uV9F9x5GwOm/s3BEV8F081bfVf3ylSax6wEVm+belG1JdsWiNxrt11yJrJKQCDifjq6hXy/UV7ObzBg3iJBX/fgfFEik3nYyu942nNIMMjecSpPP3jHcd5RH6sVRJckY9YIFlHiok8dTtfSDOc3qID6GUEwoCwzA7TxgGzu/gVSaYt4bxr+a10jr3Ay0n6rDCsAQFgBAad9zsRVU/a1sWxg5reWJv2D+zbzJnQtQjzM2timqW+ULliNMPmm+FBRrYAycIl1R3aMSyx0Zh9YLBdHFOgI7fJDecooSQV03W7NBx7O+2jeMcJazBUInvmYffdiuVafmLOuOW2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMpqFgmIYggW9IKkR0yLmHcTvc031I4NfR4usm19Zoc=;
 b=g5ATJJ6zJX45M480QFonAwagrRMApc91i1tZc5CDuIAW8Gj3J0I4tU9cFDDojo66em3E8cRzcC62hVUEcJaKcfYKXn8hJE9jN5TVtA+/IX5nt5fO59wZVt3SjIRga+DHlSaD1OMXrWOA7GJDVlAiNHs5mM4HCD6Mk2ocpxM8nEW97xu2a4P6Nrq9/fEUplLWjxhPFwshBqXAleVJI2ifjFWihbt+wKCLnvckj1bS37lsCZTPVzYjDKShF9ZthaGGn94xarih7GDnQ978EsvDr4zXV36oxm9mxpv5628tvMKiG8k0ixeWg5Ge5ttkfsDzY4EhWTCcKXBvh8j3/2lc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMpqFgmIYggW9IKkR0yLmHcTvc031I4NfR4usm19Zoc=;
 b=iThJB6gXvkXfZls1FqM7/VnfadrP4ZjPoytRr0td/8ZkG9QKk3Gr4htbh1Brq78g9gdAGN9S4haEjP1uLLN1GHBfBwqFDZ/CmZJymJQ+rhTZz8CC8N+Ne33NKnSBX9L+Vp28/vUdcnkB6BuQqt2N5akghs9WN4gklKTOLiLgzbwNNTjlY8bnBy44RjQEHODOI5PoSuBRjuezNnCAQsuGDlgH7D6AQqijSETxvTOTQT4EuZAFEY+H5M/aUje54D5QVlUEvTEkrwvrnE3/bnwwBL1Y8AVtGgruPCqY888zSQt1zDfUPLjlbEkOp0PvaYzEg88hEDTJE5LHfsJz5LceLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8804.eurprd04.prod.outlook.com (2603:10a6:20b:42f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 20:06:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 20:06:48 +0000
Date: Tue, 13 May 2025 23:06:45 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: tsnep: fix timestamping with a stacked DSA
 driver
Message-ID: <20250513200645.vxuevzz3hdtd56sc@skbuf>
References: <20250512132430.344473-1-vladimir.oltean@nxp.com>
 <532276c5-0c5f-41dd-add9-487f39ec1b3a@engleder-embedded.com>
 <20250512210942.2bvv466abjdswhay@skbuf>
 <76ce9b02-d809-4ccb-8f59-cb8f201e4496@engleder-embedded.com>
Content-Type: multipart/mixed; boundary="trunbzg2abdkgq3c"
Content-Disposition: inline
In-Reply-To: <76ce9b02-d809-4ccb-8f59-cb8f201e4496@engleder-embedded.com>
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a29e91-80e1-4d84-fa00-08dd9259b15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/msVRRd0PXM5gQVmJ5ALaZANIvBWe9NoVaxhCEGqcxYPNzaSlsAblTXlfQw?=
 =?us-ascii?Q?YVCogkWpZSNBdYS3TrNcCOBg2SFZEC1PPSNKyMebnLygClQGb7Rn88rLs/ua?=
 =?us-ascii?Q?Ap6SUp5aivqZnZt7w7Ljovd0XNfIL0WtNc0NeNIhHF1tX0A6qIL2SLnX/Rk6?=
 =?us-ascii?Q?6hMkBO+pHxdxQQGJwLb1PzFmvR1xK0HXLiDFxklNWvGmpi8BICHwMT/4hNMM?=
 =?us-ascii?Q?jmzM7wVR2FiyHADAcPouKJArE+FnyYvK/hDkyIgDRG4JRTTATYjhrdjEvYXQ?=
 =?us-ascii?Q?sYpTlvLakDLapsEvVXC1Sat1rXEXbVhg6WfmptBfmz6Sz4sOV7UxJ2jprf8v?=
 =?us-ascii?Q?4+DkgyUJWxvjEM8UhSH4mFTxEezWCtBDMG9SkiljwAr+JPc03CX+PFK0Wq+j?=
 =?us-ascii?Q?rtwlstukRxFmEH2GLXwhQMJh4f5XMXnYs2OckLM5G/yuzOs+h5xBpopPVs9n?=
 =?us-ascii?Q?x7HzNoY/sRh9VYeQJUn0V0f9Gt6AIfncw05fQ7NUtRsIUydUwa1oH3zhAA6y?=
 =?us-ascii?Q?daLFU4VbgIXUhea4DAFiLx6KDUaVQ7abtLTkVHbBpXp+oKIUzx7mx/76hlXG?=
 =?us-ascii?Q?XIHTQWatTao9YmCuqorIGdOjH3nxZCmPZv9QISSmux3g6xVuVj66DnPOECLk?=
 =?us-ascii?Q?gt1MUSVS05FY6mmizG689Flqbsw7lcTDiBS6S/ppWdSOUWv5dbYcx6h+qtE9?=
 =?us-ascii?Q?I8ywfkK7rk6naon56tYhFgbCXIIQolgl2/A4zW/wTiKerTFilsIaCayjSTgB?=
 =?us-ascii?Q?umkG4dMyKA2fkJ/IHq2tvFbPuhHsOLRR1kGqkH3bbr4gFPsd42YB7T1cpaid?=
 =?us-ascii?Q?5KoUNi6r++rQxsW6GgdXD4Lx4EGbG+nzXBuq7zuf8uCt9Lhr1bcHqm/4XDTO?=
 =?us-ascii?Q?sS89S5nz7gLeeas7+BAPLd/lMGBQ4+ScmBKwd7OYlXMNsiuo0a1vNRWEbIg0?=
 =?us-ascii?Q?VQmc1OsNJzNAsw8AnR3QROOzAHfnlHMLJbNNmIhIV1vdmS7ywhtZCVR73mv8?=
 =?us-ascii?Q?CjtpowQ7h/7uogg74DG/cKQ5XKVEbpVQic9rhqMn2bww+f20L35oesZtTbCM?=
 =?us-ascii?Q?9J7Vycn5WqKi0lX4nNw7zol+1TURqk9LkK7s4XztFdQIB8QXidVA9a1UMsIL?=
 =?us-ascii?Q?gDG6VjQNBplHyWj7GJDZA0q60Z9noLSv91KJ+2hcp+GE9NJHYpCPeHfIOnNj?=
 =?us-ascii?Q?L1AXAVuDkx8oaFXxFVMeBRU07sLVJXDwTnUkGIIaPF0GwG+hk9tko21i5PeO?=
 =?us-ascii?Q?qfGc07loVLjwSBEgZYfUc/8x4m6nPQDf4Un9h0Hyx228X5WIB0JnxcTZpvUx?=
 =?us-ascii?Q?2EteSSf4odNTn8DNK1yw0BAxOHbeUF+RYIY+STi6pJy6ThsL5RRw1GHUanA4?=
 =?us-ascii?Q?J62YEBSwSN+uBF732MJ/yiEsgSf3AuHVKKrrL8XJQrVFJJ10Bkupm+KM+yEr?=
 =?us-ascii?Q?On4tCr4wEwI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rDf9XZLZ8Vn8fycNBJIL7FNLyKbIvSneGeqJETvNvaOZryPyy+AjmZoZSJq?=
 =?us-ascii?Q?XMxWvR8LMjwg00dChZFRqTT4YgMBTu4jCTRfv1/p8MPV31urahSd8lzUUkYy?=
 =?us-ascii?Q?5ES9vrY/hqfrJoevrUkdSmYJAseoaliL0Uja8WT8ezwimB3xvLQJcjRXtD2u?=
 =?us-ascii?Q?9CtkjN3i4rJpPQHj0hALRyXvAXXFKRxrYHa2iWsJUBsQKz0eJev9M5wH37yu?=
 =?us-ascii?Q?gPBVXyMloK5hRIRRl6DWbE6lHBIyArUHuTnY4BqEtldFeD0BsvfGG2i6Nto6?=
 =?us-ascii?Q?8BNOmtiDOz8scicbgkxpTa8ziqzYNfUBUQCXWIDLuehg4FqH4k7Y7AZBoELH?=
 =?us-ascii?Q?qsIzQG+bU1HKKJobThbUrh/MYa7/SG+onVR/7SXciHbHfmo1tQVM9MrwwuGS?=
 =?us-ascii?Q?vDvOSb20L1f63LBPM89sW+JQMOY+UvM3ANSElg9cSBlzcVhQw7/4OCwrDKvp?=
 =?us-ascii?Q?gKlpzHsRn9IucKZnmucpL7kGueijdjzHVC0kGC4ZLkVM/8OE5F4vUxO8aPQV?=
 =?us-ascii?Q?tMNgoDFVy4W5c6JkjWf/yrtoL90ZU6hb27nC4OVC+GMawnng+mMf9xlgT9R8?=
 =?us-ascii?Q?NoDkEK6eWqmsr4UKnyS5wFnbObSEgTh3qByujkBGpN3DUcC5x6kD1FSK9j1g?=
 =?us-ascii?Q?BXIIGsBQsPjuP010cw9OU7AYepAhxXUFSSgEwB2jRi4NOTq2emT67HqgvG4v?=
 =?us-ascii?Q?ZpvjC/UNkolu9F1d58IVCRgac302Oxse2QCXs2/3vWI6aiFEz+6h8ptp+OFv?=
 =?us-ascii?Q?WOnIdC4McoOEXygrl7MUc7sHEq4Kv9Iw5d3E2/tSTI/PZEfrV8SpAzCxNdSf?=
 =?us-ascii?Q?4ONFT3BADEH2/xYlEYTmp0Uy/RtRqk4irAjhXk6n3fD1tXpLImK4Ggaf2rfb?=
 =?us-ascii?Q?gGdNdDlu79XuNZF+NkxcfnpHU1Zll+UC+acwkHJfJy1FvTgHkqqlVIl1V9C2?=
 =?us-ascii?Q?2BD3nQTFdNKRyMvhPoil+tDv1FRSXYb338PWHT6LTgL8Ux0pwaxccJuGCuyV?=
 =?us-ascii?Q?PI/gM8GvasSz89L3EQNYuGsV6akEcYLNhqT2C6xSLvEM2mi5aFa/b1CUSSgf?=
 =?us-ascii?Q?nB9tQYbgnRrlGoo6NIx4UeVyCzkAfwxe6PzeWjfUCKWsTxiLoDJm7FPHX2ud?=
 =?us-ascii?Q?NgGFMXFYNPA29RFuubTT7D7iem7X/ZRXXLpdnSXWpZCJzFRTVYZr0nPrv7ec?=
 =?us-ascii?Q?wQ7pTfXcetdMNQORGh1YxbuRnrLYCA5M09d0VzCBtN5gXx5NLkC4ZlZsXajP?=
 =?us-ascii?Q?5NbULPiR/L1jgOp621EYUsoFSzX/kN75U+24t1Phu9UqrcykvW7GgmVhWq/6?=
 =?us-ascii?Q?GKgsMwgDHiNkePL3eEpwtXhS0S7mjNT9rabwGy5XMuVJVyLJfbuvLQFNAK9o?=
 =?us-ascii?Q?B1McStzqFl9fongzjyQmrB/ocp+31sagnuFD3EGp/LJ6Zz8sftOawh70qTk0?=
 =?us-ascii?Q?1uvKqGug5YgooEQUYoO4+ExtKJ5B0zRJUZKUO/dnrMWGzZKRwnMfpvbJ16tE?=
 =?us-ascii?Q?ZXJaqxnGh3mVRJyomw291tXP2pzd2zNwYNmdNjvp5/1qEKRGtb7E+2PBkMyN?=
 =?us-ascii?Q?9kEBtGGFbMClS2jmpVFJQ1QThUVqt/VvMKff2URT2C+M6f4jeWaw3sd7D4Nw?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a29e91-80e1-4d84-fa00-08dd9259b15f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 20:06:48.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+pDYNF0MLP1oOHbsdcv2sm9cCmRsptMWHTlZAwaQsI4uDT9meD7gh6CpDeaKdCjLxpOj/T8O200Clk+ttWHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

--trunbzg2abdkgq3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2025 at 08:34:17PM +0200, Gerhard Engleder wrote:
> On 12.05.25 23:09, Vladimir Oltean wrote:
> > On Mon, May 12, 2025 at 10:07:52PM +0200, Gerhard Engleder wrote:
> > > On 12.05.25 15:24, Vladimir Oltean wrote:
> > > > This driver seems susceptible to a form of the bug explained in commit
> > > > c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
> > > > and in Documentation/networking/timestamping.rst section "Other caveats
> > > > for MAC drivers", specifically it timestamps any skb which has
> > > > SKBTX_HW_TSTAMP, and does not consider adapter->hwtstamp_config.tx_type.
> > > 
> > > Is it necessary in general to check adapter->hwtstamp_config.tx_type for
> > > HWTSTAMP_TX_ON or only to fix this bug?
> > 
> > I'll start with the problem description and work my way towards an answer.
> 
> (...)
> 
> > > I can take over this patch and test it when I understand more clearly
> > > what needs to be done.
> > > 
> > > Gerhard
> > 
> > It would be great if you could take over this patch. After the net ->
> > net-next merge I can then submit the ndo_hwtstamp_get()/ndo_hwtstamp_set()
> > conversion patch for tsnep, the one which initially prompted me to look
> > into how this driver uses the provided configuration.
> 
> I will post a new patch version in the next days. You can send me the
> ndo_hwtstamp_get()/ndo_hwtstamp_set() conversion patch for testing. I
> have it on my list, but nothing done so far, so I feel responsible
> for that too.
> 
> Gerhard

See attached. It applies on top of this patch ("do_tstamp" is present in
the context).

Thanks!

--trunbzg2abdkgq3c
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-tsnep-convert-to-ndo_hwtstamp_get-and-ndo_hwtsta.patch"

From 0539bea821d67c25a3d628c12ffd1c458cd38bb6 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 4 Jul 2023 21:09:50 +0300
Subject: [PATCH net-next] net: tsnep: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the tsnep driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl()
path completely.

I don't think the driver needs the interface to be down in order for
timestamping to be changed. The netif_running() restriction is there
in tsnep_netdev_ioctl() - I haven't migrated it to the new API. There
is no interaction with hardware registers for either operation, just a
concurrency with the data path which should be fine.

After removing the PHY timestamping logic from tsnep_netdev_ioctl(),
the rest is almost equivalent to phy_do_ioctl_running(), except for the
return code on the !netif_running() condition: -EINVAL vs -ENODEV.
I'm making the conversion to phy_do_ioctl_running() anyway, on the
premise that a return code standardized tree-wide is less complex.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/engleder/tsnep.h      |  8 +-
 drivers/net/ethernet/engleder/tsnep_main.c | 14 +---
 drivers/net/ethernet/engleder/tsnep_ptp.c  | 90 +++++++++++-----------
 3 files changed, 53 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
index f188fba021a6..452ab982afbe 100644
--- a/drivers/net/ethernet/engleder/tsnep.h
+++ b/drivers/net/ethernet/engleder/tsnep.h
@@ -176,7 +176,7 @@ struct tsnep_adapter {
 	struct tsnep_gcl gcl[2];
 	int next_gcl;
 
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
 	/* ptp clock lock */
@@ -203,7 +203,11 @@ extern const struct ethtool_ops tsnep_ethtool_ops;
 
 int tsnep_ptp_init(struct tsnep_adapter *adapter);
 void tsnep_ptp_cleanup(struct tsnep_adapter *adapter);
-int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
+int tsnep_hwtstamp_get(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config);
+int tsnep_hwtstamp_set(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
 
 int tsnep_tc_init(struct tsnep_adapter *adapter);
 void tsnep_tc_cleanup(struct tsnep_adapter *adapter);
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 00eb570e026e..b880efddaaea 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2167,16 +2167,6 @@ static netdev_tx_t tsnep_netdev_xmit_frame(struct sk_buff *skb,
 				     do_tstamp);
 }
 
-static int tsnep_netdev_ioctl(struct net_device *netdev, struct ifreq *ifr,
-			      int cmd)
-{
-	if (!netif_running(netdev))
-		return -EINVAL;
-	if (cmd == SIOCSHWTSTAMP || cmd == SIOCGHWTSTAMP)
-		return tsnep_ptp_ioctl(netdev, ifr, cmd);
-	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
-}
-
 static void tsnep_netdev_set_multicast(struct net_device *netdev)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
@@ -2383,7 +2373,7 @@ static const struct net_device_ops tsnep_netdev_ops = {
 	.ndo_open = tsnep_netdev_open,
 	.ndo_stop = tsnep_netdev_close,
 	.ndo_start_xmit = tsnep_netdev_xmit_frame,
-	.ndo_eth_ioctl = tsnep_netdev_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl_running,
 	.ndo_set_rx_mode = tsnep_netdev_set_multicast,
 	.ndo_get_stats64 = tsnep_netdev_get_stats64,
 	.ndo_set_mac_address = tsnep_netdev_set_mac_address,
@@ -2393,6 +2383,8 @@ static const struct net_device_ops tsnep_netdev_ops = {
 	.ndo_bpf = tsnep_netdev_bpf,
 	.ndo_xdp_xmit = tsnep_netdev_xdp_xmit,
 	.ndo_xsk_wakeup = tsnep_netdev_xsk_wakeup,
+	.ndo_hwtstamp_get = tsnep_hwtstamp_get,
+	.ndo_hwtstamp_set = tsnep_hwtstamp_set,
 };
 
 static int tsnep_mac_init(struct tsnep_adapter *adapter)
diff --git a/drivers/net/ethernet/engleder/tsnep_ptp.c b/drivers/net/ethernet/engleder/tsnep_ptp.c
index 54fbf0126815..f2d001f58017 100644
--- a/drivers/net/ethernet/engleder/tsnep_ptp.c
+++ b/drivers/net/ethernet/engleder/tsnep_ptp.c
@@ -19,56 +19,54 @@ void tsnep_get_system_time(struct tsnep_adapter *adapter, u64 *time)
 	*time = (((u64)high) << 32) | ((u64)low);
 }
 
-int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+int tsnep_hwtstamp_get(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config config;
-
-	if (!ifr)
-		return -EINVAL;
-
-	if (cmd == SIOCSHWTSTAMP) {
-		if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-			return -EFAULT;
-
-		switch (config.tx_type) {
-		case HWTSTAMP_TX_OFF:
-		case HWTSTAMP_TX_ON:
-			break;
-		default:
-			return -ERANGE;
-		}
-
-		switch (config.rx_filter) {
-		case HWTSTAMP_FILTER_NONE:
-			break;
-		case HWTSTAMP_FILTER_ALL:
-		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
-		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
-		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
-		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
-		case HWTSTAMP_FILTER_PTP_V2_EVENT:
-		case HWTSTAMP_FILTER_PTP_V2_SYNC:
-		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		case HWTSTAMP_FILTER_NTP_ALL:
-			config.rx_filter = HWTSTAMP_FILTER_ALL;
-			break;
-		default:
-			return -ERANGE;
-		}
-
-		memcpy(&adapter->hwtstamp_config, &config,
-		       sizeof(adapter->hwtstamp_config));
+
+	*config = adapter->hwtstamp_config;
+
+	return 0;
+}
+
+int tsnep_hwtstamp_set(struct net_device *netdev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
+{
+	struct tsnep_adapter *adapter = netdev_priv(netdev);
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_NTP_ALL:
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
 	}
 
-	if (copy_to_user(ifr->ifr_data, &adapter->hwtstamp_config,
-			 sizeof(adapter->hwtstamp_config)))
-		return -EFAULT;
+	adapter->hwtstamp_config = *config;
 
 	return 0;
 }
-- 
2.43.0


--trunbzg2abdkgq3c--

