Return-Path: <netdev+bounces-147919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214289DF1ED
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A07B2174B
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C891A08AF;
	Sat, 30 Nov 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A62ZsQP9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BD19AA5F;
	Sat, 30 Nov 2024 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982905; cv=fail; b=fzfMIYaT6DLLL4g8J5Jr4p7q7VUaHL2EpyfKtqwsCwRSLveB4dYo8qrMHbvsLS3Q2UtaZVexAaSCHIcsCDWg5OtxupDvtoKjp7O9yH5sBs9agqD3ZmHAPIyWeFHSVpZwWmKujH8KyhUTH00i+BEADCZYPS91fAH1dudp2ldXCjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982905; c=relaxed/simple;
	bh=/1Db/24w53TXcvVbJzAFrY3lG+uyKwhhG8xM/XyXpNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A7wNSxkMmwoHHeZ5AJAGKkSCMEr9FacJfNNkFmsNKTepjz3chcrfBOHapUYcBR3DwWAguNm8o5HrowReDMaLJB9Rp3de948tnfj7kxTHmag117mkazw5RJbnDlQmVbNDphoKUIkzi1shLn/L1TnzD3HtiC7Txowm/c8g6LZJH8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A62ZsQP9; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmKbFyYAywVggJy9u1erV3upbJKtykdgAYcjGN8Py9EuJLG4otyd600pl8deHIFtNaGF+WSi8bUsPXzM33eAJB9SAZZ/OY20Ep9Md6pQQuhu/+QKqoJ9u8lvcDOmCmW4qSAMUCI6KZFOQGJdmUE1Zce57bqISlqrIHTkmqaRAvnl3b6aRQ2ytewyYziVHyBu1eRMveeFCVwXvGHbe8Uw4Pbt46TFdkEVRzYPZmBK77u3DLelOpDdCqvdK5OF8fCC3bEZtWx9HzvSC3DV78LQbiPPfgUGa1pPEIBBdr2eXnjZ3CDQDOWXIuc3zglEqGLHj8wN5JS5Uztw+TqrmSi/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQnAV9ciNVpSQs1aLyGbW3u8bpvwKMWP9G257k4h8lI=;
 b=h0nDa9OTA2zHGw5lMZOAeGlQn69mn0gJeoY3uYeqKnxMeY0c+dIQo7JW7fTkiappsT5J+9gAZmi4IkcNVqomvRxZGSIOxpjG9fv/sQH6Z7KTspez3B0mKJQnicaL2IGQs3FH7pQW/yE6lMMeWf+EagEcEOiIkaE0i+Tqkub0IkdcyNYF2zrW+MG4Ddj7kg40egT92ZGQo0DF+EibhsH0ciw1VV09Rn81iVwSVms8jfA9sOQcdMcckAHJlqSrg/82gtm1JB4wZgnEy8LHfWIBC5Zhbc9EBpMTmpfyqt/bM/HnmtXOmGZsIqP0jgN7GdGaPn0j1Gb2Q/2ikObplLvTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQnAV9ciNVpSQs1aLyGbW3u8bpvwKMWP9G257k4h8lI=;
 b=A62ZsQP9oQlOubY4pKeAgfqVSctHJliLbxqfhl8bW7Gq11kcJ2+8d1jb+oOn1QWSxwQg/VMTV8p+5Ph0XTn6XSzH96DycAqsRs7Fn5NEzuJ+KX4KxlMrn703e4D+BbPXaGaWQsJF5KvebiNwoMwNRHJe5T6jhmxL1hOS6CYMZ5SGZJs3iDCTu1+zGB8/dQC/suycXtrqPROSXPPMvQoJUhkSkIKMoZYvga4Zl1to8ztBQWkWpxDjLLzTQ5nL7Ze20j9ryrPvgShApxi4Zszf8VKaSmpYvnCfM+V/fEXBdcj8cF8YbYGI97wbBO9avNtCPWQWXxtimheUmH27m76ApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 16:08:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8207.017; Sat, 30 Nov 2024
 16:08:19 +0000
Date: Sat, 30 Nov 2024 18:08:15 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Andy Strohman <andrew@andrewstrohman.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for
 Q-in-Q
Message-ID: <20241130160815.4n5hnr44v6ea3m44@skbuf>
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0s3pDGGE0zXq0UE@penguin>
X-ClientProxiedBy: VI1P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 947dd67c-c642-48c5-6e68-08dd11593505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JB8XYRkOfEA4X+Fx9LV4Q94pfBgyS+p3teDfcTesRLO12g/wlLlzuNFVErEC?=
 =?us-ascii?Q?ApjWGM3eyxa/J6jvwkwg+1wY7uyUmYpAeqBgJCmYIeUtNfJuFEthawegMnmY?=
 =?us-ascii?Q?gcWahVqueimApfilJ3fpdmrjyhLdbdVtZi7Or0mCYib5C0pgepcOQtcKXu5h?=
 =?us-ascii?Q?8RaRWFAfD8DjjWyVk8WQFSgObkxPzo6NdtivOqtMxvXV9Ap+v3+7RyAxJjLR?=
 =?us-ascii?Q?CkmUUSbgS7PJ4KoK/P9YIRedhzCp5UrBrnBcqvV7ZjBqYDMLP4iVUqQDDBVS?=
 =?us-ascii?Q?NVc3Bw843fiiL3nlLSAVwaWU0BjKwkUMURF/KjBnTzF8PPWSCq5NAsh3ABoj?=
 =?us-ascii?Q?DrDS5SVchpqDe5LdIjpwaYod7DuMm89GUIY8W71EKP2uECoFBp3WJmRAmZyt?=
 =?us-ascii?Q?4IMc7BY9lwjHByg8ATvUMmQ+dUNLF4JRrzAoBN0m/OQjscRguemhNzMHj5tH?=
 =?us-ascii?Q?SxfgPSCX0JFmvjHoD4fyMwZ+kkDhb4bRtfRnGt1+1ZxYMQGy9Qx8N7kFI9zc?=
 =?us-ascii?Q?32BbS2gH4x2iAvl0j6N0HNjWhst6izDPi6Li8SrJS3M+itc2maNieC38Y1zX?=
 =?us-ascii?Q?/MDROtHYbPGGa+XmwuNcPbFfwDLrA6GRyB5f410ufl82FSxqWv8GI2yWjhh4?=
 =?us-ascii?Q?N+2o6G/cQbARgCldBiQNqPOWs3drh8o6qFBGZpBDzSrWnEEomMjZva5S9T1d?=
 =?us-ascii?Q?tsl6uhvEORj7XYELyxYYnkm/CcdQoS/uWAnyhCjzq+0DlHQoNfjquOK2mSi3?=
 =?us-ascii?Q?gp5dpBBuvUVhGf/Iftu19AkNjhgh6HrUJGCU7klaEzy78NSv49u2sfLj7d/7?=
 =?us-ascii?Q?dFbxWJHBj+MG/a81dj/rHNBdAk+bZGyf7Hl+j12qrMhnoT/aV/pBvfckuKS+?=
 =?us-ascii?Q?qZXqNhs39yX/MyJcKltPQCEb+INlJ9POFyxEmtR18cBAoPfx6lAFcIXGo/NX?=
 =?us-ascii?Q?1t11e7LE4qXBIAtJglI7oYU67Vp92PO/l80/C6rOig/IBQFLDa90pHN9cYMn?=
 =?us-ascii?Q?gfGGxbLEHxkpaDZvXnTS9C2yL32Mvr6Erc9AKEc1/+IZ+RJajR4r9RrSuUEF?=
 =?us-ascii?Q?Y9Uc0TCxFrABWnaOhvcV1UpsUE5NU3ZmEM1VK0Z13n9ULu98VDqOe59zZK1p?=
 =?us-ascii?Q?rCetuQ+5epVFRNtJJJMPX8Apnf88JcspURhKD/jI7H94amhM9w1Mt0aI/8VK?=
 =?us-ascii?Q?zEx4ZnnK1G3ZEX1u1sxKFcOrQrHR+a7RIy96KPkh6AiDvpZcCx6jzFTq8AYd?=
 =?us-ascii?Q?5rTEHrHJBTUMiEKFJP1FlKvKo9PpRgxSJGzrwAQ74LCAtGlNigPxnlESYaRQ?=
 =?us-ascii?Q?63kXaiJjmGFQN1JJZLu54KX5PET/dJvwFSjeHybeMKmAqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dgz0qwOh0ZmqNL1B+RW+C8yQL9Wgzu3mB8drSd+RosEdq90izVJokpHRWpP?=
 =?us-ascii?Q?2R1kWWI5zonq6F8Bn+lSkFvmU8VuwNX+LLLmbYlYlfPcd39ND6MAoo9s/wkD?=
 =?us-ascii?Q?bsKlDxRyneTS0Hd+dyb9td5m3GO8SP4ddyWYffR7BbGjDhJBZGuk4Ezvk29H?=
 =?us-ascii?Q?ufTXrZ+bwKv8mCHRfFiiGhtsUxBy3oWFeGIIzpyE6CzHeZ2CgmnAjRVE+K5C?=
 =?us-ascii?Q?HnG195N/qELUnwInI3mOhDPNn3JWH4bAiEAWw4sN9DlySW9p4PyGQ/xGfqQ1?=
 =?us-ascii?Q?5jwJdsTcXJo420UiZRlC6pQJXAzk8NKFnWM7iDsjpU4kbbsxNnfiim8a8G5T?=
 =?us-ascii?Q?iKRIkc1/2xxVqQSgOd9elfh5cXZS0B/mwNsteePZtUzQrFY9IvpQxzCNeXyH?=
 =?us-ascii?Q?k62CpyiFM2fR6j2vJ6esw7FEJlBxKfQmWZDI5yw1psVvhoA006iMTWbFqIR8?=
 =?us-ascii?Q?jb7vSpgsk1kL4j8Nl/n3Hp1Uil369vusa/DoLKNE2xUACpuLbj5DnEYx1j4H?=
 =?us-ascii?Q?zggJWXDGPxrV/8Q8tZrXdbbLlP6aTV/a0uq+jsnt2wXo8LB4dAp3y3eIOpIs?=
 =?us-ascii?Q?0gYbk58BU/8yzNf32BY1Lm7G39kXkD1TBtmWvO2yAyvLADjC6rDkMd7LRtET?=
 =?us-ascii?Q?eOawPegyyhsGz213OfSLCqNItPsCGK9pD6NghqHNxSuMc7+vMyhqZRXKuJln?=
 =?us-ascii?Q?Pz3IL3/e/8xK/vTfhFQysv90SZMsHEj2pPU0bxtuJMzHt6tDJ9QMg14udEmI?=
 =?us-ascii?Q?RCNFvOdrP2sGgBHc4zjewEACAEsHzwsVyq0AvjsHE8cNHYR18Z8TopPacmx6?=
 =?us-ascii?Q?av4gEiZ+2GTMclm4gQOAmkykjNAVYuWVfEmG7nUYzjGKIWNjaOStEhWLOXlg?=
 =?us-ascii?Q?UF6sClZxfRl+oU5Mh1w2MDD+PWp5MUibwXC5a6aB02nwrzhxHRJyOCC7hZ4i?=
 =?us-ascii?Q?tXqMnkNY2kre8eHi38cpybFEr49n80U8oldf6hKVxBNm9WbIJezlHwWO0Qzp?=
 =?us-ascii?Q?HTpXHvyZMArp1QVVrccUmg8bzPD8QM+N7VYqj51fB4x9GvUhRYmMLu8xo9MW?=
 =?us-ascii?Q?90jrPiAKz/Gu6xz2gruj6YDIzYsNpqK8zTz+Xz5VOh7+sHyZMZ6ze66Mjbga?=
 =?us-ascii?Q?X4cVgq7mFB3ZjWivonEWfSDiNyUDiwgxhO5S/kDttmSG4sApuR4WEtrt3KP5?=
 =?us-ascii?Q?Gim5N20ZXtapdneYdQ7uLdmbNnw5v0Z/JzWFWkb32kjCjMCCdTn26tiR7zpi?=
 =?us-ascii?Q?i2BIER6zGliQj9QIO9Az8QATVG+v41xGR/Jsmiy9sf9ZN1CZ4Bklm7NJNzuw?=
 =?us-ascii?Q?brwYp9amh7QxkOSk2c4SfhE94ncVsLmQ2YA1CcT+EY0u5KS2+XPV0thJhKbg?=
 =?us-ascii?Q?+Reh40rC74GLh7XiUQVfDoDt4b3dQJvpSZUyfoiVJz/vHrdldlLVhGfU4evS?=
 =?us-ascii?Q?A1W40RyWo60x71/xpqevdDNKUzelksbwx2lmo3WTGJe86/fKdgKzcYJ0gawc?=
 =?us-ascii?Q?sI9avDffPZRNSmRF/wQoQ/eo3W0H6o7ULMSYSZj6chXOvJyFELhhWOyOgI1V?=
 =?us-ascii?Q?5B6faC2ZiW8TT/Cs+/KD2n6EEXWsqsj47kRDYdZVQqbUYXTY6j99roXWzviX?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947dd67c-c642-48c5-6e68-08dd11593505
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 16:08:19.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxPTX63rVHMRM9o+6maucdUDReXuKu/y0tXzM2noKXkcJgiPEndb8vlT85IPElQAfyvLJHPgxHjiugD19jfuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497

On Sat, Nov 30, 2024 at 06:04:52PM +0200, Nikolay Aleksandrov wrote:
> Hi,
> This patch makes fdb lookups slower for everybody, ruins the nice key alignment,
> increases the key memory usage and adds more complexity for a corner case, especially
> having 2 different hosts with identical macs sounds weird. Fdb matching on both tags
> isn't a feature I've heard of, I don't know if there are switches that support it.
> Could you point to anywhere in the specs that such support is mentioned?
> Also could you please give more details about the use case? Maybe we can help you solve
> your problem without impacting everyone. Perhaps we can mix vlan-aware bridge and tc
> to solve it. As it stands I'm against adding such matching, but I'd love to hear what
> other people think.
> 
> Cheers,
>  Nik

Correct, I was also going to plan asking Andy what is his plan on making
switchdev digest this. The switch ASICs I'm most familiar with can learn
on inner VID or outer VID, but not both. Like you, I'm also not sure
what 802.1Q says about FDB entries with 2 associated VIDs.

