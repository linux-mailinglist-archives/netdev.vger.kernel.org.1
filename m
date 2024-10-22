Return-Path: <netdev+bounces-137975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA189AB52D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C4E1F2165F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB81A4F01;
	Tue, 22 Oct 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFCTk/0J"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F21EB48;
	Tue, 22 Oct 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618574; cv=fail; b=MmtW5FOoV6X4kL7fMGx1SfrR/6DDyXXWfy5t5a4z4gq+orax+bfO9lWSnj2D57WOY3OdG2Z6ylzQnNdoqokhGKzUlzSN90bhSsnIzAcXbW4qUy0PCrizVxguK+zDg5sgXrAGDcJNLOvZZX3X/JgjxBPptfA+yS83ElZG+5wjSeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618574; c=relaxed/simple;
	bh=zGiFIpmjy7wFAp3GqcgaJ96A2zQlhj+VNwKo8Jr2bxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QExYQVPV6CcVLOFjYE9aoSGeYO+S/FEE6maG4KErjZTNZH5FrMtVFd2NXtuWn57g9vjV03bhAbyeEiqh/PqcsS1WeZ52a0+ZPgjGaHko617jQQ3T7yG8IdOKbG7ymubjKq8YPaXqjsRUTtj9e6WC7y7I/xQVs3jBRbb/tGy1Gq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TFCTk/0J; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FINoWu9RNDhmxJdO1XoGdwI5hv/1PEVSSEY79DInWMn/4IS2AX5HrqXuIpLR4y+bTVklaBqG4PqlEhhju4AQAPrCwMTtteskKh01DMHvkZnqPuiXG+IEP1ZKYsqAmV5JlJ/2VwDBEjVXVW3v/lo6LKWdw8yne46EpgryHtEUrz2p8U6yz5nP5eVePjkutmOgNtyWCbSc8/aXFmfD4z5AsfE2YOGpaxLkleVHgQBxwvRsb8ZnQcry68wBJECKUJ1i/ugBP6A4VX9vTDIAUehPCpTUrfLaL/Go8xWjEYYeXWqEMS4C6zFMGZEwAgyBtzWjiugf5Tkpe8PDjkY8mJFHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d56vrc4UWB2paQYd6qHnBuQWJKMmNmLVAx2Fy6A/xK0=;
 b=mfUKWPITocMNbzZ0iLOEBlzEcHX/pTy8OC0HEPGr84/dWIgZUUhM6FamPKCge294g+sUsk7yyy9dcc4OwM4WF7hLlucnLyWtIHBcBpFqLSbi2ZIV5t5bDpoW4895ip3fhg09WAb+f4kz7eZY+eUvig2s/je4VYzyP5qvHKvAYMyhUy+BECPyB6MA5YkZAzFzqwj/pyaX5TuNbcYCv/fsH8yMCcdVhLjtdgtsOvc/GrlmbCS4Ur+YseylpT9+62/ZLGzglfiKIEa9GZ7gwvbgEFWLwi+7cNJsJXhQHp0j54Yh7++4wupo3d7QwaNGTSYUioGvNAJ+m8TgCR/D/+inwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d56vrc4UWB2paQYd6qHnBuQWJKMmNmLVAx2Fy6A/xK0=;
 b=TFCTk/0JmmNsDTxwdbI76m8XPOjDao2asl9ElhqT1ebe3M3CaZPTe5wDjQx8yJg9Aqyp6CXnvUhGlCuRye/oqZdngFyw48XaRddfkT63IwA5VnuGPqYXQMzrf+BUXxYKxb5UTmRZfm+0xIn7vwJzQUnZClp/1M2UToeaX+UQ8HNiZYsZWG9Dzn2PPUk52E1ZSlzCLbDWoTFL5AhQwoozXK9NGTBffYXhqEUfS8xv3WwY9CDuZvMlC+JZhCbFlmloRsBIrg1n2xb4UA+tNkdRD2alO1j9LakcaMBbp4CZsHtfVFLTlgzkJ3U82u+CCVbrYTE0f8MwccYfKJEBjMRlAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 17:36:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 17:36:09 +0000
Date: Tue, 22 Oct 2024 20:36:05 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/6] net: sched: propagate "skip_sw" flag to
 offload for flower and matchall
Message-ID: <20241022173605.qg4lfkwfqi4zju5m@skbuf>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
 <20241017165215.3709000-2-vladimir.oltean@nxp.com>
 <ZxUo0Dc0M5Y6l9qF@shredder.mtl.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxUo0Dc0M5Y6l9qF@shredder.mtl.com>
X-ClientProxiedBy: VI1PR09CA0119.eurprd09.prod.outlook.com
 (2603:10a6:803:78::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4d448f-fd8d-4631-48eb-08dcf2c003ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krZF78gNEgKqoE58miETS03puuFOPS48C7rLUf6ijtKiyOCyq9owIPBu6SdM?=
 =?us-ascii?Q?4D3xW5lyTr77sG68FuBiKtteTWV7a/3T0rT44nU7B6qv9usyXbqbBPbPo7Ve?=
 =?us-ascii?Q?Ty2NB2wPndzE8ku3x1QFNLRny0sxiQqCMlmoSWfDt2ZZnQVNT4CDYfTiqUG0?=
 =?us-ascii?Q?fXEpdqpaTNmr3hhbLsZzW8xRQNz7/DR/orPayDJQi6Fz48DPp8KxWM9+CHKw?=
 =?us-ascii?Q?XVYZsEVuFKw1bOc1WcjKcCOwyZiKjYFj1NsfP6gesfRVqT8xepnSq1LGsu9x?=
 =?us-ascii?Q?arR4GWa9S7qDtjxSY9JauR/MVuuxwsmJDTOxGBAXvv672lgGOzn8gK5bSwAj?=
 =?us-ascii?Q?4u2Piby3uJ6UcoFfy1CcfxNvyacVGKJLkBfJ4721sxeaT0MKsDjqL9i4keaB?=
 =?us-ascii?Q?xmzZNQy8aZZ+ef3trRIvhwTCakwfxK0+UwLFYYTELeNTK4erPMhRZX1erHqh?=
 =?us-ascii?Q?y1k89Q/EoimSUqBIUf/+RMju0QGWhv6LdrMMackg4JacwoWvNfpEAuHKbFXG?=
 =?us-ascii?Q?t/VLHzGVx43QaU9leTuiE/2NeOMLaz2G/NssMIKuN1iPjVJeavIANGIlZfh9?=
 =?us-ascii?Q?wUoz1i9V5T49lgFah1uGP0eH1t9RV7V83ez7vy4t6QlerpIIzyPRFERnaqZ8?=
 =?us-ascii?Q?ANFNKKFuB8ZsawCjD+CPMyi1hL0tM1wrwClXJwmmTzUmtIjFlyVXtCSLedIp?=
 =?us-ascii?Q?5iiQhx9s66RG3LcUaz7O2dhJfgSmW99s/27bxqHQ4bxjkSMF01FHYbfq9EES?=
 =?us-ascii?Q?ebf6mkimGSGbojia65qCfBZGLCSfUYADPDoBDJoilypTZMY0Z9TzKjwTU8qv?=
 =?us-ascii?Q?iQOZ1Fh5m2vFtUEvZ7szPw1IWKH81rinjmqHPrDGx6sqp1vLLVENsdZdrwb1?=
 =?us-ascii?Q?z4smHQvGYeFuLAWJcFXjNI1BCOV+2BGyEbENNKrWGqAfX0yHO8dsDm/XRUs0?=
 =?us-ascii?Q?pnbMkSILgH9rlX3mt+YNhKH3d1KXRYa0skI+/Tz+odl9BC9+icq0SF5KWR8Y?=
 =?us-ascii?Q?kLr8AEQ7Wtx+GznqdOepoCdpWmYZ/zy+bHoRhRLYISYwYuFo4kJwKWNIYaPG?=
 =?us-ascii?Q?8vkE2dNIaDsLJqS2uwa2JUpklS979mHoz31e4GSuVZCrgwdAF7LMspKY8M89?=
 =?us-ascii?Q?YgyiRxxnfOLSgZ1hPXdKxsj8tsIZjM+3fJniyn0sR9QLXTUiSId2qpu7/Piu?=
 =?us-ascii?Q?Hy3yTx7nHbp3yYsyzyioX9eSJmlarcRW0qEBybstLJ8uhzcJLlJGydk33FyL?=
 =?us-ascii?Q?f9f9PsY/v0SyC1kLGEkrWi/dYuV3UflZvL/bCd/HHY6jc+N8V1YMC+ELiBzV?=
 =?us-ascii?Q?H6yLd84elqJWr0Vkhk2i1xab?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JD+DOfoggXMZtA5wbNUuKB0aDO+rVr4hw+4TLWMNReTV8f+sbZvjJAy4Ml8E?=
 =?us-ascii?Q?2jItmv1jznXdQ2lUBpEMgCnsuvk77zNKaveJHD1GC4XJ887/zKzwK8GeLHL1?=
 =?us-ascii?Q?AK9aQ+M8/Lc1mdhwlohpcHNizooJ/SAmkqGUKpCOUGpbXSQ/0z/TLuRpSovs?=
 =?us-ascii?Q?t/3McQDXl5912QIOKM9JpoqHwEQXlyZKdXnnw+ft2Z6h/EKQFZSyT6Wc/mVH?=
 =?us-ascii?Q?0BIvJRYVVm2ZTekCkuMDp+IEKuXj2lKWor7ScvkycsA8SncWbImYnQ1cE+Ig?=
 =?us-ascii?Q?D251eknr02AjqylfG2JsmBnGfk+dJ6UY+akWHWQPFPq0yDgsKl2MdBcHUs60?=
 =?us-ascii?Q?PcgO/r8+xrlZC9wiWuHBelnDIcNIjwqlyUooVrGca2kB0JcqkblbvERihHb0?=
 =?us-ascii?Q?zrqy34wLIovnungOkVNLjSdlS1Rl3izqtsuUy7qYr9vWBOPDt7Ai3DH+WNWX?=
 =?us-ascii?Q?IBPWsZ9Nafg8m73XjdyO+VjC+OC4T5+gvL9gw5k5BzeAvhd2mLmxl0Clwcoa?=
 =?us-ascii?Q?xGA/yWRCajGJVEeFTWfZxjXeCeI+mV3HV+zom5IrCzzNdyB3YMUT0JVbCRJQ?=
 =?us-ascii?Q?szLTVGPOzqdtldw8d/gpHbbRz8ubgS5SR4jC4OjvRXa8/M6R9a3wFaaKoKrY?=
 =?us-ascii?Q?l98CrJDaXeNgjC8DeAM8eL221mLfMM0aQHxH7Pj8pwMlTU0jyPwYU2hVroDK?=
 =?us-ascii?Q?j9mYrgLUvFy1yKMP0R6X7zfTblFfIajVfYLY07j/GF1xUu6GES2LVE1jX6L9?=
 =?us-ascii?Q?iq5wB6g/EIlTKSHfFNmTh39LU5GUt+BvKPAOdE2YNYzMYCCzv8oVctmWaM40?=
 =?us-ascii?Q?5+4Cu+0521O4708yoK7l2ULfgLjYpN0HxF4nsGRgT3N3QYAaRRQRb7pQXW22?=
 =?us-ascii?Q?vhEsIxOSYogJBp+1e64OaktIp+QTqTca8cqOjoNDtMnc/4cmL0CQKBBdXkc8?=
 =?us-ascii?Q?4qOpDWhY1ZJOYVcDWzK6+IaaOL7J/ymAteH0aimHN6r6vBSXQs7w5OZ0PV6Y?=
 =?us-ascii?Q?O5717MEWqkq2RZjvfbu9kmcrZ2XbN+7/inEa1N8/AyFaIecrFjLUFpgYJoWy?=
 =?us-ascii?Q?jDNGdZ0p0H87RLsDG8UG3jiI7mo6GVHY/x7h7kD2orb7w+P4chKi4zUYoz7f?=
 =?us-ascii?Q?5+Tgij8aRf+oTBusUgOsi/zE83fNvLkwR0lNVc4xlzum4cYpo3Ei//Cm95YX?=
 =?us-ascii?Q?bRduh5qoZ2SSf/PB6JyyT4e5ZdyjQM1QGPDRkdH+A2fgaxi5Ea0goUJ8zrMf?=
 =?us-ascii?Q?G/QLPTdFZrhUYh0shFVAP8p4qF8whtvr5mvLZMFql3ZPOz+4sBpujNBReijQ?=
 =?us-ascii?Q?FwmarVa3LldUMGFfwzFqBI0VjJ43S/RQ/KLDtepTmYTrRtF4stbGntxLqxgA?=
 =?us-ascii?Q?EXtaSrJGu+t2m8Ic0XRPfPWIthC2o9DcxmiWiRm79xw4UJ1+fbkiCxgzrNT6?=
 =?us-ascii?Q?Kmjshvk1ZWNicCdFi5Oofrg/GSCUdHbu6UAVqeIpb1m8AhO9XCvlXbB2pC67?=
 =?us-ascii?Q?d0mZk6ZlGsOfsvV9FHRSBSoop3b6C/UmhbKUMNl5T4f8U3VotOHaD5IB4D6z?=
 =?us-ascii?Q?/B/c4Evu2k8MR0ypy32G+tbdQWBQefHoEDWna6gDgK36iLJ9zcR5SiHn9W8Q?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4d448f-fd8d-4631-48eb-08dcf2c003ed
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 17:36:09.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY9YMwjMZDHtyo508j2o9Oc8Ya0STtG4JwDlLE+IrgJHTRnBedg4ILeQZerU9YtA/4zehR3UCXZwfk4NzcIRLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344

On Sun, Oct 20, 2024 at 06:59:12PM +0300, Ido Schimmel wrote:
> Possibly a stupid question given I don't remember all the details of the
> TC offload, but is there a reason not to put the 'skip_sw' indication in
> 'struct flow_cls_common_offload' and initialize the new field as part of
> tc_cls_common_offload_init()?
> 
> Seems like it won't require patching every classifier and will also work
> for the re-offload case (e.g., fl_reoffload())?

I think you forgot more about tc than I ever knew. The answer isn't
more complicated than "I didn't think about it". I've tested this
simpler proposal and will send v3 using it. Thanks.

