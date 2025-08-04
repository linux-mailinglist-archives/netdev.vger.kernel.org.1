Return-Path: <netdev+bounces-211541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68098B1A004
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2C07A7042
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C96252292;
	Mon,  4 Aug 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISxpXfW5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331B22D7B6;
	Mon,  4 Aug 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304655; cv=fail; b=QT2IoUCfhOsMhQ2y8BJEbIJHXqL92entuA1WpcGhlQf7jDccyY6qK+qTVDEeNe3UZU8/LiZ+lIBQOJ4PLQflY3NuX+jeSxh9c3HAQrog7SmFxQWnbU8DjnCmf2FuMmRM720U3+EJbjAu/mDJ2os65k3Ly5AeTHmfVI5WWjP2yQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304655; c=relaxed/simple;
	bh=NObFMcyBi0i7rgzeDtl4+AsdBkUc14lmksicOjM1Jxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRRcCRgkAtvzaNSJ7ohVXkrPvJh411Mt+i3E45B5Q1yREEeOO4iQ/NGMEZqs4Lz8gCo13uO0MteCuO6nR+xGsZNv43G3G99qOafwttbumMr8kKMKvEWVo12t0gzr1AKqREiHOfspEkl9Z9Hx/LofQzx0rs0Xrbw9GXG3U1WDSzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ISxpXfW5; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK+srqWR7bWCu5in7I1hSywhtlQs3I3M/ZSci8f0jq6mK7UelASkyNVZom5rsJUET1lHbq7U1Yi3ApBjZqNPEFzFtNkc4Fl9HlWUMXZtvAbBYuqeCsD0Nx/pcqU3P7/WgFBrmunuKT96Ja4iFCePuSd9LgaRW3s9u6kfeqx0rPmVjY249IGeG2KqnyrGS8wPutmlNZhS1/jrMQ4K8o9G6nEV2fHCkKENm3MMcK9DQYVGYWGear6jGnMKWEu1wYx+fCVMiwRyahfvDrx9itfT95DMUlw+iuzRLkab4sQfFG+f/rHRa2rrPrt0qHMjZRfG/QqWzjjD35Uc9wluowHBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfeCN8EMj4PI4cpGmuDxRh4amHe+cfTjYNZasADEK8w=;
 b=AW33zMqM/DWvCIwE7sEgpze4fgdSk4nVdVHwAwTCHwpoV7Mnnyyu4Q55I5phdpoXng2yVHs2zEgsiM2YoqN+fRPY9VqaN9HLtxhQvGZcglOsWZdmuUDT0dC/aQVn733/3cZePbC3220MKLF3n88be7YJcfZzQ3Av6pR/RXtW4GLenoVgSHQgf3ge+4/zFBUXgCUraXDeENv8zc/YGsaEOY+tRozHX9vWRje6dEg0u3wtWg01irpI2oLgl3cSLUBJEalbliFt2e8hcI5Z8dpAzxKek9Zl+rYn3DwxqrHzJKphj0Mg8+gZ0WEDf75GXvJTeohLP8nnKJwRFbyno8a+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfeCN8EMj4PI4cpGmuDxRh4amHe+cfTjYNZasADEK8w=;
 b=ISxpXfW5gdQytYayIWkT4eKzpf+soxmDgMsjANaRwFI7ycBZbQaeXl/BSEJMau+7BciMXtvcr+loOzAh2APPsOYSJwy3kROhtA+X/gr94WQYtEUNjZFRO/Yidf6aipOME6sYF3xHyIW2Pm14f6e6Duci3MMU7l85Ac4UIpWGfpliS6xAiT1+d2uGylz83nuHnDc3ZOb6HdyH0gmLUfZBBjilxuffHIp1TjmLmZWliMUTjNMeIZWsWWFtCa1vbPe6aQUYOw7xTnVheB+34IrtJVKIrBk79loUs1KRf0kt8BONcReYEWiCv/g6FfStDlz/P1IB4TONVc9EVCsTd/wL0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB9926.eurprd04.prod.outlook.com (2603:10a6:150:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:50:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 10:50:49 +0000
Date: Mon, 4 Aug 2025 13:50:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: maher azz <maherazz04@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	pabeni@redhat.com, Ferenc Fejes <fejes@inf.elte.hu>
Subject: Re: [PATCH v2 net] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
Message-ID: <20250804105046.mqllcspkookc7uu6@skbuf>
References: <CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com>
 <20250801150651.54969a4e@kernel.org>
 <CAFQ-Uc-15B7eiE9uFWFzPDhj1sfbuzwmWMEA61UXbumybJ=yzw@mail.gmail.com>
 <20250804104937.GR8494@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804104937.GR8494@horms.kernel.org>
X-ClientProxiedBy: BE1P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB9926:EE_
X-MS-Office365-Filtering-Correlation-Id: ba87b3dd-d959-462c-4a91-08ddd344c64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bi101gm8TPbMfJRoAkyMLRJCuQEZIdPVwqwFMtPAQeUAK/6Q56QoSEXZ3BmI?=
 =?us-ascii?Q?c9LZYxx9VYQ26/+XLdk95b5ul6HQXS23mfTTIPCr9VJcCYLCEMQKpL+g7HL5?=
 =?us-ascii?Q?vTEKQgex22kktx4j22ZR1vdOP3HQXrIbgwiKE3f4AewQLtmVFzbIHoPbu7Kd?=
 =?us-ascii?Q?+++U+sPYRhzJOfV/NK2glUlUrheMfaeANkrNAehbNd4u2kNICtS0L7KKSFlW?=
 =?us-ascii?Q?Mfy8gqKiLIuhL1wKO2wUdGAIlUyR4+datwTYiFuINPaeyNSnauuguVHY4nqb?=
 =?us-ascii?Q?+9e2QmKZjJfXHG4wNMRCc2fti22MuFtVzWu3fssqjxlscsQJWzl8CrUjlJbt?=
 =?us-ascii?Q?T3LxNZ3KYTaa8XGf3wgHS2RN2xw0nv2hephxODG7zaHpyXBNqTgGFtsQb5yi?=
 =?us-ascii?Q?pQp1Tf44+MT3jPoi/3mHOh1gI938JKiRvrL8vs1ohKOW0GIM/2i40Uc0R8Vp?=
 =?us-ascii?Q?SDxmp7ml+CjgLc94sDV0W0gl3v9gzlXp/rOC2ZX7PSmgOtvbxCM9rvOwTULu?=
 =?us-ascii?Q?5AFIWNlYzhvjx3+WSJjvYZQ4565x1XId6ycAGaK/pC4hA4AAVM/RxhhBgQWQ?=
 =?us-ascii?Q?8YIfOS4OigVudH3xjeBDoB0BiCccj9a4DCS0kUZMtAMOqS035A1fU2wAAUq9?=
 =?us-ascii?Q?VQctNRm3rimX9YZZUk4UTlL8ZfuCK25s19yPGJI7XD4j50bmYiQcCySeqNBe?=
 =?us-ascii?Q?nBP2/kx2f4ondg9nsBGvxdgJ57ocqcVmyW8MAl0leJjUv+hGAguaBSb3bS0P?=
 =?us-ascii?Q?k1r2rlCmIUh27Pp2ErXyypEl4shtRU2La7lQxvI4nmSG8L47ajzuDWw6cZg0?=
 =?us-ascii?Q?xHbXG08Ic4n4mHHAOI8FeSPTDyoq3fQX6BnXsSKhzLvUeAHbWwcM8uM6LKUW?=
 =?us-ascii?Q?EmaP/mI2VnwZiCkQxMb7e6d20dXqwF/z050yVX87XBk9oK+1nBkstd8iecpI?=
 =?us-ascii?Q?4VoP6whlHTd+p4XZpixmrVxdE26YOkKHJP6sAmDMxitzZ0YtjAsh42958Imv?=
 =?us-ascii?Q?aQtRvIn6dp5qnbJTzEvNBmpNCT+Lw1NMDJjtUV/leXMLXaFN8ldO979qGmZf?=
 =?us-ascii?Q?RxTK4J8RsT6KICAhMltyFHchDaPjeEP5xNyjJ1ibfElwabTFgkeAYwuVyXYO?=
 =?us-ascii?Q?pOSY1deJAjxMmWYO1P81FiBfSXUP6xmCpbR6e4PNt3qFaUvTp5K2RfeVerlC?=
 =?us-ascii?Q?gPVt0h8C/OAUYq5pQBf412/pbxxD04+5IZ60E3B3tZDZPAtlawZ6JQpurGG3?=
 =?us-ascii?Q?JRrqYsXB2FvPP5Nswst5XORvb82b1ycBSY0TZcMYp3pL6tcXt9W9vl5R1PDo?=
 =?us-ascii?Q?L7puQhLGAzO+o6woMUxvDb2UAO5fA+S1izYpAjxFIf42S6AROX/ALqwdIFd5?=
 =?us-ascii?Q?pytFBp5WdEAoNSdueUxaAHCeCT0jh8lCntQamIQ3+1N9YYa5wVYsuZ053/id?=
 =?us-ascii?Q?MHrfuw6I2ig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/jYnqU+pk2XqSGHPA5W0oAgGmw7kaTnHiNO0hHQzPPUcOXcvS52nwsyazWXh?=
 =?us-ascii?Q?M1BA0I8tq+kLRAXU6aXTdrGg6dxG5yiHubBBuk/xDZwyLyR7vrbqQY+gI5a7?=
 =?us-ascii?Q?ITgOnQHIKzGSyACNZN2fxVKUeTGgVBVZ32mtUadQ+TORdvhiD+ahv4FSvQr5?=
 =?us-ascii?Q?N6iD36jvBKAeZqtF/olBxOTjkilB2ggvcU5FNFusz5DvFZeJWQEEOPNMW909?=
 =?us-ascii?Q?Gn4LgEKEGW8dBWMXN3SOAJIoIAKwXPBFbtC+H4tGaSIwhxcg9EKqyXtGLlsD?=
 =?us-ascii?Q?GxgvKEM/AfTf+Wfl1ibrF3gMgiDLkZejXzX9zf62lF7Dnugvjj8JgbfWyNU0?=
 =?us-ascii?Q?5Qdn8+3xTEW6nLwDN53Gdmi6dlJ3N3D6/eDIX7ixu4RbxTucRfC2P2WTSYUj?=
 =?us-ascii?Q?jyZe1R4VDPYIqSugsCyA4h5iF4VOmzUmnNVeEtqBIO5ZjBel0pd4D3JckI3W?=
 =?us-ascii?Q?m7+SuW5S0Umx34C474iY8FaIPOuxket2a+6oBh+6XS5O1viWozaiMNd6W6Rr?=
 =?us-ascii?Q?lCCmj1RD+1TZCB7ZwoX5OOozuqAseL+xX6JBWmgMWRLOPe7e5oJ8ewpBzMXW?=
 =?us-ascii?Q?YhA8mUEo3R5kGzwiBqaGyuXH0yDHxDYGD4Qh0UopEotYw/NEA2lluFSf04/d?=
 =?us-ascii?Q?BjbYVLhiBVbrfa3AZ6BG9aF4DFI+t/XorFUrBuguqg4kYYB6fmFmVW9AtJtU?=
 =?us-ascii?Q?MFdQCFmhrn+ho79DO9IRIZYe5dcVJ4X54BOk9o2XOERIUcSJwERm2C+lU77m?=
 =?us-ascii?Q?lm2dOen36UoV4cx+On9ldmUDbcmtTeySKtPqA+Nmf5S+4FsITRudGFp3TJ/a?=
 =?us-ascii?Q?jRWIgTmq8L6Ms3a6yuigkHxt+0S1gPNwmTUnoAkyQhHh8FmUcbedNAjNgjTu?=
 =?us-ascii?Q?z3a5LzftDfVPtoL2A5noejXnCLQXwMJf2nHLI8JOhG+jAHi6+trOObD8iV1k?=
 =?us-ascii?Q?2SUX/YGRhN/wwKMZqt5Oo9MkiT0Uh4gFrSio1qDkjCwEDoI3t5KZVr4wrhG4?=
 =?us-ascii?Q?1qGfv2gcZ5Gb04zyXUd/eBh9cpV5JUQ1gUlOwAVcaN0h56Uax8/xIPluA9kJ?=
 =?us-ascii?Q?6CBiHf739JqClrmugozpMqLTNC/i3xHX2ojgBv8XFAeYAToV9QNCmSL9Vvnw?=
 =?us-ascii?Q?SXaLqhAZx6Fh/MnS/Q61Zi0zegWrrHHqG7ARt2wbWcNKOl21Mx8s4tDF6q7h?=
 =?us-ascii?Q?YT0FVomobWKnoZPwZdg8rL/Hrx4Q2rb6UXl3qBkmNpeoral/64v4fuSdNFrv?=
 =?us-ascii?Q?zRrEJOH+4ZJtNlsET3AUiNx+lBXJmE8fgAOsdYyOdoB9vLHt8IE2RPKPg04x?=
 =?us-ascii?Q?2Xaw6utATbzzFt4a0/ZbwbR5EzgOMW6l6+uNOrN0DquB1ocKzTTvusxIDZJ0?=
 =?us-ascii?Q?zWmmw7JsLznAebKjwl6IQkrhVVfDnLCnMffDr5zkQOGTkLElWqXwC8tnmdGH?=
 =?us-ascii?Q?RsmuJTbHeZlt+gtg/H65Eu9K5O4udqtOETN1gE9YUla/myT+wCskYduToJaf?=
 =?us-ascii?Q?g5ySPp82bdS7yOz3r09jSWisT+uKfjeiTzrRfcIpxLZ18LXIo6vvueRFTeZs?=
 =?us-ascii?Q?xB17eavmYTRALjlkgOOkJZzkL+Uyl33aRS29Vrl684Se8wu1pJuqRPE72+4B?=
 =?us-ascii?Q?22gjQX4LyCCuCNhH8bS3+gkbls/pHaYiBUGli8I9wNbrI3fK1jOflKpeuDsV?=
 =?us-ascii?Q?PJLxpQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba87b3dd-d959-462c-4a91-08ddd344c64e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:50:49.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSktTJdVTfQp0R3rTStAnOpGHJlYgxrYAqLdTvBfbr9b52/pJJvkiMCejDtfoe4Jl4XxRlOWsuD5Gva4WQT1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9926

On Mon, Aug 04, 2025 at 11:49:37AM +0100, Simon Horman wrote:
> On Sat, Aug 02, 2025 at 12:25:24AM +0100, maher azz wrote:
> > Can someone please do it instead of me just keep me as the reporter please?
> > this is too complicated, it gets rejected even if im missing a space or a
> > newline
> > 
> > Thanks for your help and time to review this.
> 
> Sure, will do.

Jakub already sent MessageID 20250802001857.2702497-1-kuba@kernel.org.

