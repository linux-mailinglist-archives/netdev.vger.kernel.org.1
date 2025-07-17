Return-Path: <netdev+bounces-207921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE966B09055
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CD43B6479
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF33E1E1A3B;
	Thu, 17 Jul 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TO1DZwCf"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156BC26AE4;
	Thu, 17 Jul 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765342; cv=fail; b=L8p+/z5d/0UBsUJMmGePUPk6Ms53Dp+XM4mCRgoT+zJxDGzf5MyDngn+3yNE+dnJSXfahp1oAMp/xNNpTdQAt4oC7SjdVj64autF2b0tJGm4w9kRb1DvHO4OK1llcsERgEUxaZlg+fiTTOcpzdi/usnwPk2Bf6ufrezM8Cpec8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765342; c=relaxed/simple;
	bh=09tj5L3uLa3VZUANMikxOnQrBiHiEPaPPeAnZq2F97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmnoQCXxo8fW22pfrgIdYKcymdH9LM05icOLluO2k/sB+bNyFVtLXEfrD+TK/cKssv4mP1w3FiQ3MQCRj9bXuP5GtSszmYcwueJQcd1CW2hUCAGBFF8+jdxRnoDZ3Yow8BvKnNftXhERMI6oPiBvbL9uCTEltzEqCLdbDGa0T5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TO1DZwCf; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4NjDU4JBJplMVl5/icGnyRdhGtDWGh5DBNnVcf96Tg1FlkWgb89Y1OzzohEZ5pckCu7f2d1Eya89QNa/SUNS6+FtWmHE9CmPbky4bXp5Ov5jy/hyqrJEp1Hl44a6hljU6n2z1eQyWXpuWQ6EtfbNy6hog6MXpXxGq2iFKMQve1Hx5UdFiHBY0TCsMUD6oDfC9cmXqgkywg18cPqYHYVwhzNZ2ceOwJz+Byj0/9PD0wlJewxRQW2ZrJp2+vQ9tjDp+comU906IP/B+aP/+qmDFNWWN9qtViOoTAqGK8GqHfdwvzyhUsGZw20F4StahGWNAEoy1+FzB7b9nIi32P2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ub4Ro9x0C1CUplnWPXdDSitQXfSOS9xwJfI1Ug/ls=;
 b=deJKYOUUtp7mF912YT8NS81UtXVZqplsm8F/gI7bzzPItPRNiCJKZMzg7N2LYI6LcU13+vh5jG185NZywOiYqy+OEaNZZRuuA1jCgR84ID+PwXPS+W1VQjwckaaAnB1tK8hKn25eWfwBoCXtuRj4htrMg15VSSf8MjHBcvVzebLfcUjFG2Ff2YpnD/0WNjTCiRIIBoaR+/Sz9HaH7r7Vn7QYt6eSqEN6LB2TJDxQy2CGfcLDftMPSNDAMIjOWFvtn6D/FP5WiK/wKdRxzNtsS3gbWoX21nXmsMB4XB5/PzhflXEgGuFRGdwLfzxrHPxS2h4Wwamh75i06Yf1OZIdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ub4Ro9x0C1CUplnWPXdDSitQXfSOS9xwJfI1Ug/ls=;
 b=TO1DZwCfekk2TzEKkTh6CM+hgD/315ZuHxwtLqafLD7k8iJcYh4+GEkEgpdd7JEQIOFaW8FIJnLNoxgaWcZPMm8xtRqon7kSYXfgpNK6L+uaDy7CliK/DMYT3FKje8SJGaKVXJM+dH4EZjHnkZehnVvO97AOKKJ3bii+3YhKPqCNLRof61u0Z1w0AuhVBN8faQe0a4gn7t0/k7mVFijP+KtaT0LZJjmhJRD3JU3MXRcRa1AlncmdiRK/BextTWlkyRn+9tTpfaSj/qJEOgMhksDIbR1vzeu/GWRgV6e5sV+mE4nWr795QCFC9FVbhD0Z0Crtxb/lEIeGUvgW7/Xymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV2PR04MB11167.eurprd04.prod.outlook.com (2603:10a6:150:27b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:15:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:15:37 +0000
Date: Thu, 17 Jul 2025 11:15:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Message-ID: <aHkTkdFaYd8IOkpG@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-5-wei.fang@nxp.com>
 <aHgGJ6sia5Xe7AA9@lizhi-Precision-Tower-5810>
 <PAXPR04MB85101A40D9D866083BA88E6B8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85101A40D9D866083BA88E6B8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: AS4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV2PR04MB11167:EE_
X-MS-Office365-Filtering-Correlation-Id: f45d50b9-7efc-4a7b-6999-08ddc544c86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMFtT1oUQSexB/U9Q6h/Rc399/OM9qZNRHcfpBJZeyrhh3k25GDUhVHiMzNE?=
 =?us-ascii?Q?r0GkFk6j0OYswlYrmaEb94wuXUEI68Qy+ZdYMSFLJyALGQQuX/r7niol7WeB?=
 =?us-ascii?Q?fAZQ/m3IXPkpPLy+jj6J9eKAMja2tbFUVz4ixpBOa+uZ10gAtbbl5H07cuL7?=
 =?us-ascii?Q?YfgIQlHI4aCPm1f03gcJONq3/LvNRb5NvTSGC/c+VzKbocIeoiDOL+AyP7dd?=
 =?us-ascii?Q?H+qBLKf0IzdaikqLT6fE5lQL0zjSzMDhdVBi3Rd9JqDCcVTBYtLw0cRPfmbs?=
 =?us-ascii?Q?NgHuEaMbMWm98bz0ub+hisBrbdj0IXZDW4F99OPZ2K6yll34w7AnyPwOfodG?=
 =?us-ascii?Q?wvdkYRUUXmJNHUL2xL1EhhqJtHnv3rp46Nz5h8qTj8ofIM41Qt1nStsFxTAn?=
 =?us-ascii?Q?zQt/OxuRoSiO3WGgJMgrHJrAx8WaO4UF8LiMoV3/iCnT4LmVcFyzlwNTXt+G?=
 =?us-ascii?Q?0dYciVMV/5xYRJ5uoD7AO7MhkOvvwRwbCVHo4Y97C7ukd2ABOR5X9q9uz4C+?=
 =?us-ascii?Q?aSh4YIDqQyVfgrEA53gdLqiWgFNyX/izET9maMR/ZiFnmk+VzJzw0ozSaP22?=
 =?us-ascii?Q?sCWbAGXHPevvE5/8S+PUKk3B6PBrwzHvvDSSDUfzfPZQmhfJeCpgEvMuvLSo?=
 =?us-ascii?Q?SAuZrh4Hswjj9eyyvPus22ZBMKwmaBYsp3gj5umFdykx8RSlWvxdWwQEpB5f?=
 =?us-ascii?Q?Xr/IB9snqb5nCB8o2K2TVjVTy5V2rJ/4AU8yipRSMfcsLdQWvvpaiNoB5QJy?=
 =?us-ascii?Q?l0aUOSIlDZz/MtBreU89z7pAHfWegJ23VE55mIELeU/uHFWyJHP7e+N084Q1?=
 =?us-ascii?Q?SDwZnzLp27I/iBiv4nQzpkNnl3pjsvEs1WafzrBHSOSlkn/Xv+d1lqjMboAx?=
 =?us-ascii?Q?IUlcoYKlOjfePKXpIy0c9iJojkEWrA3lDhT6G563jrjvIR+y2um7zaycninn?=
 =?us-ascii?Q?FBUSU0S4Xayhafa7Stb7CuGKlrGp+VTkNGcpev//BWD1TqHKBfxdg0CKdAn8?=
 =?us-ascii?Q?9iqhiMWT+9emOnm/IpEsBlKRtKkxWZFzZDVEAyZBdS2x64sGI2E7Eg2gHz3d?=
 =?us-ascii?Q?7njuEl+37T6+t5c98lr8CNeKRJR57h0RDLNBAgcBcPUJPH5BEzXAsYfERRAX?=
 =?us-ascii?Q?vxZcNwg6TKVxuG8sCCX/UIX03J111CteyAkCwBlruusmUB/9ba/HZzFbvEkV?=
 =?us-ascii?Q?z9enmZer32DITwATgLX1okTxc+kDhww1rGv5vYBBEaRsLtELiA2H3u1jdv/C?=
 =?us-ascii?Q?Kr9x0LLPzNEEXfi6fWKmUiNVmhVyG86+Zwc+/PQEqR7Y+nvVKKjFDUL5sq1D?=
 =?us-ascii?Q?Ai8quZixfmNyOmWneBgNbcCXmqGbd1IgvK6Iq8Kw/pRR7CkIATXuXa1aBpH9?=
 =?us-ascii?Q?Y6lFbWm6cGyzpnrp8TsKD0fQuFfskQAc8ZOoV4vYgfk7bIYgThHWOTybC2Ln?=
 =?us-ascii?Q?lBq8C5IkiEApiEXs4pRswHxOj10bp5NxEn0ImWyhcyiFQ61w0no5Cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYNvDPsEi0iRv/Ny2GLCkXUC1azrpFgEnthmQ7s6+chs5ecMiP1yGTEn9LjD?=
 =?us-ascii?Q?2snL+R4PrjEKFH8IiTG3kKOAJX4jUmIq/vmXwL1XnWTyyE8MGfTqGTtiC2FC?=
 =?us-ascii?Q?PEmElZvWjWPTXwk0cbvmNjnWfDd0F0SSiPnEjF6ZpX4Eam5nbe8DJxnxwhG7?=
 =?us-ascii?Q?m8K9Uo0rv6AVzYbGEoUtNj56eOqIdrUrd9Hv9F/RKSfxd+Y3VsfhIbXSIUyK?=
 =?us-ascii?Q?jBnt9Sy2qJNKBKC2MgXsKqBGIVoT+hBWIqukq0oRdRw0PUTDfv7cOcpZHDv+?=
 =?us-ascii?Q?g54kB3xhOMIQGIAwRBeAAPBuseE8JQhvw7kXuzXUQIu8k1SOg7q1oP0ENjJt?=
 =?us-ascii?Q?yiK945d1K1Q/d5RrGUGl2k3fpkANFq4TWPFDkO/insrm+R6pFgY2D1RaUyfa?=
 =?us-ascii?Q?L+vfK83ciLpxDU1BWanHdXlI/0Bo0mB+xjCwkxVdhhu9z0v0zLQZVcTIHW+u?=
 =?us-ascii?Q?ZxAdisL5RckaMOQGWKQPxvBY6YCWvqgPdQKVntNls6OWEHK3wpykAKYcrmmL?=
 =?us-ascii?Q?we1xIynASxk/WNHckOftqlFJ46/HpibDR88wgEKUVyPl5cKyTBce2ctLj4Dq?=
 =?us-ascii?Q?JO4LtKPYJ6GCEWjU6YTUP02CMj3iMQFG3xaY/ik3QEUBBe+Ufom5/jND+Qvt?=
 =?us-ascii?Q?opkyeTU8rA4Vn9sZghWsDzAGEtAzYpvE0zCJVjGsXk5G2+k7D5+AreL7ut0o?=
 =?us-ascii?Q?FhYdtOvW3UL5vhCijlQyhDQdlYA1jowNgL98COezTm8LzEyhPrLqBDk8Qw6l?=
 =?us-ascii?Q?/fIBfkvmmzO2mJ0tbodcpBBEh01086NoPQx5nPGE8RwzPK9mGIRS7BsiPajj?=
 =?us-ascii?Q?y5pKROq43fj6JbqlHMQPhKKeXg4Hrb2rmFJi5ClSRLXSOvb9em98FOY5yFNn?=
 =?us-ascii?Q?XhMJAX830layzO3dVQfaoNNcV4MWrkbeTM19g1lC3KNr+GzkKVzFfnwyRv+y?=
 =?us-ascii?Q?/KYJWpC/DgtI9RhHmPQC9aiePPDQ1bVmOJ5SWnenDDDFCIWmtu6gJMpvP+g0?=
 =?us-ascii?Q?JLf+v+9t9zwEchCwni9GEWgyfc0E9FC+IT1oqfplGP8ZWyDe56R/NZiB2sT0?=
 =?us-ascii?Q?8BeCXCJ2xZ4F/5bnUYvFkUVay6L02XxTAoV072kW96SudyIGdHAAbttrvlpv?=
 =?us-ascii?Q?WUp6dvJZkYxGqG1328Wd0fEjAoLvUFWBErVNYax/5SXg9avCKqmy5++XXBlS?=
 =?us-ascii?Q?+a6UXcKcZmdb0ILY7NAYu7O5i4BMTwGip+ZEYPNZN2I3LM1pcEsq4E/CTqzp?=
 =?us-ascii?Q?WY04x/5c5Pas4FnUcJrWgZlfYLbrnSxMRmooABNAsiA4ryqkTd/S3wwv3YMT?=
 =?us-ascii?Q?zwfo6zrnxY6WKJgDj21rlYOY7z+6pkHVCT/wmY6bI61hwQr+s6/74fxhEO4D?=
 =?us-ascii?Q?R88mre8ekGDHANxQo3ajTT10nzVFeS0/LA8QfK8EZjTwCyiH6Ilk40SZov+/?=
 =?us-ascii?Q?adjqF+TZXclFDjMj/7HvzIovEhYJdyHrs/e7/Rp8V9ctXASYA/2jWYgIPUn0?=
 =?us-ascii?Q?Ld4NCADFeAGG7kRtrfbcI71HHj3gmUKC0WXCPpFfIXh1cJG/y/wVCAM+Ppe/?=
 =?us-ascii?Q?2wgG+7CwpCCvltkIUeHS0FXcQ6NJ5UDroW+QX5iZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d50b9-7efc-4a7b-6999-08ddc544c86e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:15:37.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L413q26fRZWjOQwQgzUh3bD2UFUTrSrgwmxmSddS6WtIgHxkvBAay5GJbOkuaswValRh+MEDc+Q6hQu4k3Jllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11167

On Thu, Jul 17, 2025 at 11:59:30AM +0000, Wei Fang wrote:
> > > +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> > > +					 u32 fiper)
> > > +{
> > > +	u64 divisor, pulse_width;
> > > +
> > > +	/* Set the FIPER pulse width to half FIPER interval by default.
> > > +	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
> > > +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
> > > +	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
> > > +	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
> > > +	 */
> > > +	divisor = mul_u32_u32(2000000000U, priv->oclk_prsc);
> >
> > is it 2*PSEC_PER_SEC ?
> >
>
> No, it is 2 * NSEC_PER_SEC, NSEC_PER_SEC is 1000000000.

Use 2 * NSEC_PER_SEC, instead of hardcode number.

Frank

>

