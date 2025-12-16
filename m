Return-Path: <netdev+bounces-244863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FECC05A0
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 01:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF8E3016ED0
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785F524A06A;
	Tue, 16 Dec 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JeCg3XvD"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763B23B62B;
	Tue, 16 Dec 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765845005; cv=fail; b=jKtB87e3XGlj2XAdNh1wnBKG0BsxX97y0hPFfmyOL4eG45TLGbQ/5JcsBDPrjUaauGq0XOEIACZUVbXep2F57SwzyxkDx/lllUjf5sT3JMkR81+/sJ5XVY1IkU9rG53xYA3dAYh+5mxryJXVD1np+sbslVj6KIqSB95+sloeOZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765845005; c=relaxed/simple;
	bh=SKKeF0u/BtjY2GBcoG4WILun1VmnOB2J2mQjH9QERM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wne31c/NVx991/89HoPPfaqWsiT0OkOdp9HPXy5BQPQhEM4Nq9cNL0kt7cjsbIdNA2zZkQFC25UohpEI25RD0ywoVvbZV78v5uRJsyAvEPuPC4H3I9TGFzfAC/9+aa2BcKvL+F08dFE3idLfc3k7eD92zkXrJyqob8JNB2+XfcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JeCg3XvD; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgFBKposkDulri0Bd5iwFMcZghopWaO0FELWYUtHgCD6n4y1MukdqncHzzIM3zuHaGimQqEp0xsGt8sCMTBpeO1GNZizQ7sQbGNMNlNWpFPmJIXvYyc6/H+Tv6MC1I69vUJI5FRGa8m+EbLnB0QGMrp4y+QBbEvgD8sspJ/2gxfkzLwu/r4a+7DGLznOK5/dL/DpY7F/AqDJObrFo1Mmq50pO9fIgvenhW+f2ZZ91C4SxBXe+BQMopGKmTKn/B+4Yjm4UQ7bGqYmQ+hWFHvpbIqz5e1JE85nbD++oYhrtGKKMb/wnpSuiE3Q+q1+ipsy/ckza2kLnfeH1IGNfxmLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uORw+3sV9PRkX6iXNMFKmgfVXJcOhFMqRuVHmOwCTjs=;
 b=TeVouVuu8XxBWGMowlDi/UGpldV/jPzlfnGDs6GHFgqOit+/6ReWqFtszC8Hek15hRpG/gI0EwoyiDIfOhdNaC3eRjNWNYrtcbVMRvaiHzOpf9f4WM2plfR0qIa4xj8VQ0Rllxk5ZO+pBj50w0veCb38w1Jrl6tqOJ2mQKWMe2Vv5c0YSWERQhVIV2Zu+iZxQEt8FPri7K76zk5L582ozvqW8X/CjQWDzZC683nBOl836IyShrvjlRQPX7Zvs781C9AfNwA1zZzlzkeDDLf+YQ7YKa0c5kchWzXIJrW7Xqt+SQiwHBpZOde+JONCHTrBCL/9B3cWTWl8gMoQe1KgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uORw+3sV9PRkX6iXNMFKmgfVXJcOhFMqRuVHmOwCTjs=;
 b=JeCg3XvDO1d5yvFdKACbWmcszskfXCcUcnwy4tt9pGUhIh9Dd5Pj4rTrJti25c1uJph1vaHgi+kNKtrH/WoWFoAMa/jCTq8WGY+gWUcYa2jx9Sq0P/b4YLgygiO+Q7saW4Ijl+LMy2kXoSR9wMLN7zYwQSRXROGw1PpvpbjYuiudgtlXein+Syca5P0V1o/3VemQSqatHWpjNHPnXRgeH9yz3OM9KRfi0T6MHasv2X1GgbLBXq+/UH7/Rf5AYJ9lECVwGRFo1b+Z/eZAtMvoxLqBsVmjYA1cmJ3YYtmxgmdnKp3pPh9JfZJawBUTdNK1yV2eIHw0E5ud1+S/3QmWaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM6PR04MB11265.eurprd04.prod.outlook.com (2603:10a6:20b:6d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 00:29:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 00:29:58 +0000
Date: Tue, 16 Dec 2025 02:29:55 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20251216002955.bgjy52s4stn2eo4r@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
 <20251120153622.p6sy77coa3de6srw@skbuf>
 <20251121120646.GB1117685@google.com>
 <20251121170308.tntvl2mcp2qwx6qz@skbuf>
 <20251215155028.GF9275@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215155028.GF9275@google.com>
X-ClientProxiedBy: VI1PR07CA0252.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM6PR04MB11265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4d040a-e833-4530-65a9-08de3c3a3e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1m0PaCPdO0+9H+kwGHpJn4yluJSD1xSUEdpyDUZx7hL/FUW1vPhfvILLIRG0?=
 =?us-ascii?Q?AisXns6AeWC35GwQde5rdc3EfqRzaTL84etmSBuQx5q6aI4U6oANFycbv95X?=
 =?us-ascii?Q?nfrmtfzJJGKvWhs/06WDKT0kmz7fP/xULlgu1hucf/9zlqiZE/0hsYC4YcvU?=
 =?us-ascii?Q?GFCeNNZ9hyeb/R59PZlXB4R2uq4pdMAvpn5mRLHZq/3NNTSRt6b/QCkDhjWl?=
 =?us-ascii?Q?LTrDeM0MyjjkkCLks9odh/rm1R1sv2q/Nt5HdaTpR2UpB4L2sbsJ4PrqUcr3?=
 =?us-ascii?Q?RTL6FuqCQyAZRUM0iR3qlGDbpECl8Ee2Ak/l3QrqGsBzBiQtZmIkc0KwDGfO?=
 =?us-ascii?Q?3XD0+m9ktoDJCpfd+lCUFoe4tLHBVy8+UfK2vas8PjUBUEHLcLlNIyvmz5ZL?=
 =?us-ascii?Q?IkQI1p+8sOYDdw0ksWUT6NgIuEvEETWa9gfuI++81nlBaBHYtcibr4NcrKr6?=
 =?us-ascii?Q?VYaMrDeVbyms0PsB/MYImv3yNeGV/7fbzeXQarN+JNZRRrPiPL9O+zmGO3YP?=
 =?us-ascii?Q?HwONtvFnGOeT3Fhrt/FTDfS0xaYI0EWpVH34D03URi182RW3d6fYSm7fmlKF?=
 =?us-ascii?Q?vJKgGKURqRZcM+I4WGaEeO2DKea3s1HkNzK7wvF2s/ueM9VqbklYkgCYN0Zc?=
 =?us-ascii?Q?dviuxerAoz6cqQv0YSaeJyxWxCC4Ohy1wUH3G0biJ3KxL0jrK6ZWg3PWZyTI?=
 =?us-ascii?Q?dzQQMqKomHAZQkJF1EOxZ483WG2SYCFxQ5EXXB1mc5xv2/a9YzKM7apouEGa?=
 =?us-ascii?Q?OTA4YXHU3jkUs3w2XMS4l/oY7VEBI4AGud2/2tukIcAmv06HY4Ujln1rf675?=
 =?us-ascii?Q?OAULe8OPiHRdYoFW/ByDycebQNGWGp4HnOu55FKuczGJUjjvJxAnRYfBZJvO?=
 =?us-ascii?Q?WToXUSTkqVy09WCvS7Xu6lHq8CvWZHhYCSG+cWkxPLZDRxqHbFWpjmclw+Bk?=
 =?us-ascii?Q?N8oY1BCyPRSgRI7EkEhAlWAW8LYpe8ikWpnrVNsp/K4indg35VYyJaUSkc21?=
 =?us-ascii?Q?aXJPblR0NJYXdNkA0a6ji+c/239JCc2gk8C2QyxHBYSjCVjImZohFKKMkh3k?=
 =?us-ascii?Q?2SqibMS/Mk3S/WX5xMEX/uHEMVGtqvXwy8+yKfM8xNsOkl2FMQFFUwqXqgFI?=
 =?us-ascii?Q?+Rqppzjr28HazmKNRscYTGQJvDWYBimToYm0C0yw4VrXnGo8Al9JEmKsFSRl?=
 =?us-ascii?Q?tbc10P0BeoJrSOkJhcoqn9wJvHbfoKoTKYjYAK8SmJJnhGDEu2DpR9PL53yY?=
 =?us-ascii?Q?xYqZQMF8PoQESDQgfkJMxx/BxOTRXkmiEDEQwdhZJjn9Uw6uOneDtdTMY+1h?=
 =?us-ascii?Q?LtoGLk4vcdZYpFyGstvPQyrmZL9d6JZFvdxXb76JOoKADmM1PZMeAYhVkjnj?=
 =?us-ascii?Q?+E4GS6P1l2lcMbhIa1mPag2UOffhqCjTuvLwAMMfiso/EC1IVRnSZ5nPcpUE?=
 =?us-ascii?Q?Ovq9wJRiUyb3hUabK0jdFTUFQRbmYdrhCclBNu8JRbnVnePN/MO2eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKhrQ5R5fW/YltXQNNtWg2Uy/tTm2zl2rGiD4St1uLDisBVKRuaU7oaFKw4n?=
 =?us-ascii?Q?lcrb6k7352hUxCS3TauLQWFI9PqI82g/tphElcyugojfxRtPcCDLPWviYyXI?=
 =?us-ascii?Q?P+8HpuTlZoIWJeMy/u5hHjx1Si8fnSdgcFBMw7rjIsiqZQscjkSuIUSP6VbH?=
 =?us-ascii?Q?yVD7s0j3qY6xST1GykfOXq5h+y7vGQqHPoGz7S7QGyT7eOSSUjlHHrgCA4JO?=
 =?us-ascii?Q?4Lxm5+moNjIZyandmS8/6myysla2vzQwD05OiRN3MgZhrVLqziFFBRBSXbd9?=
 =?us-ascii?Q?MCeLd3LreZsp03yYkhqgeuklP4JPTvTEadd2HVzE8eoHny8++f5EYtz1Uklf?=
 =?us-ascii?Q?yFVmuD8U4iYpgmLlBwEx7KAbvqTah8mEHn/hkSwpSICvV63S6CXlKnVFousv?=
 =?us-ascii?Q?G6z1H6dsTLdVkjsIQlkDDYrOkhc2Op639PtuHvRZSkemYa1oJyIEvbBudfKL?=
 =?us-ascii?Q?HO5gdU0XP2HrgAs04MLNgDqDMNPC49ZVmjROHkLDtBhMi/V0EgYlFy7OVk/h?=
 =?us-ascii?Q?9tax9d3Mb6c6cTpv/qAF1hnyqFbRgEPuHE/xeAr6vYfevpfElDJKV77L8GDB?=
 =?us-ascii?Q?rNRCSj7wrEsUZ+3UDSlVrZoLl3v+UKNugPO9jd9Y38kax7Z50RN1mbiImg/9?=
 =?us-ascii?Q?osodOiEFBdvVlMmplm9cuhDmivO7sRZDzNcICVkwYRY40TCVhSWt8sEj/Yuh?=
 =?us-ascii?Q?ScVt5e2WpB7Aj+KkQ/ISFn9mUIrSDwYWCEZ/QgznTsVDH4hXfUm8TyaSO27p?=
 =?us-ascii?Q?HEl5Pw7Y/5Y8YW62Rgny5NwoaFLLzrZPgHG10/gnBUEFcV6g4wv4IH8HfLnf?=
 =?us-ascii?Q?pWx6nr95ASObj5Ukq628DSGdu3/xiXLuzfsHa6u835LnUTh74VwsKLuIB2kg?=
 =?us-ascii?Q?PYBhaDDy0XwNkZtQElfJztqf1yLkYTsvq1NOqIhaMBhvUbKyNAnh0c4Mvr5U?=
 =?us-ascii?Q?svxka7dxN3HvIzfbs7g1s+TFljQdL7o752nnLwGPFsZSsoJ9mSuPPgtuPF35?=
 =?us-ascii?Q?1L97dqZTo4N6TV6Aj/FVnr5rTNo5U4l+xsw+J+L4cWuyCCiZa9TBFJ5tCzr1?=
 =?us-ascii?Q?Fs/skU8Kon4jGepIk7FCDVYL7WFrxjfW91uVHGKQY605iKKEfutTQ+NllKBE?=
 =?us-ascii?Q?E/MKdlVSKDqDhUBoq+9NLGNvUp/wOYEjBrYYL7VMGzRAGGWshSVHu+RQ2rUK?=
 =?us-ascii?Q?NV4YlEKCNt11+xvpSjMB47PBJYQQukBxXGsYye9KYo5C1lLv8+oNKqo4NtjV?=
 =?us-ascii?Q?6BbNOAkDJ9xdFbtU0CI9S1RI5GE7AcZ3TjZukNfbC/l8jx9HGxdFdUGb7IGh?=
 =?us-ascii?Q?CinM9pqClE96yHJstxrFipUDKMZ4fF4RjjU6kxhLK2vK1G9traScqO40sOT6?=
 =?us-ascii?Q?RJbsq+6GqYWmeWVkJoWdlJBDb4qXA7rPSuP0w8Nh/lodtqpyuv+nO1ZvmAO/?=
 =?us-ascii?Q?55KjygRe29u86Zh82vtrF2wYh7p38NbPBtWu0XOYLbQrJlVSdHL6pgfdd8mo?=
 =?us-ascii?Q?IadWyUt56/lc5JCxW3sN9/lJPyJ3/QvWflkgHeqyDqoqQevMmMjf9bYMr6+r?=
 =?us-ascii?Q?GRiDtslFIBs9RoadcpxzCwuJNgiwXM0tKeKmxdqK3xsX0xaptvKPEuaXvSAb?=
 =?us-ascii?Q?+TzrrKY2bFh4WXKpZIjhzlezdfZrc61OtZjIJtL8qDhZuKhSI8ozhJI7p/V6?=
 =?us-ascii?Q?cCkUVg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4d040a-e833-4530-65a9-08de3c3a3e55
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 00:29:58.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sibo9GzDTWNeaac7Kx686S3nQYIv+21nVqjxGB9yjJm9ixHaIpstbXxvbznQGZcPCM7QofSByb3sFWOZjwilzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB11265

Hello Lee,

On Mon, Dec 15, 2025 at 03:50:28PM +0000, Lee Jones wrote:
> Thanks for drafting all of this.  It's not an ideal level of verboseness
> for a busy maintainer with 50+ of reviews to do, but I appreciate your
> depth of knowledge and the eloquence of the writing.

Thanks for coming back and I hope your time at LPC was spent usefully.
I will try to reorder your messages to group the replies in the way that
is most efficient.

> Side note: The implementation is also janky.

Yes, this is why it's up for review, so I can learn why it's janky and
fix it.

> There does appear to be at least some level of misunderstanding between
> us.  I'm not for one moment suggesting that a switch can't be an MFD. If
> it contains probe-able components that need to be split-up across
> multiple different subsystems, then by all means, move the core driver
> into drivers/mfd/ and register child devices 'till your heart's content.

Are you still speaking generically here, or have you actually looked at
any "nxp,sja1105q" or "nxp,sja1110a" device trees to see what it would
mean for these compatible strings to be probed by a driver in drivers/mfd?
What OF node would remain for the DSA switch (child) device driver? The same?
Or are you suggesting that the entire drivers/net/dsa/sja1105/ would
move to drivers/mfd/? Or?

> What I am saying, however, is that from what I can see in front of me,
> there doesn't appear to be any evidence that this device belongs there.
> 
> Unless there's something I'm missing, it looks awfully like you're
> simply trying to register a couple of platform deices devices and you've
> chosen to use the MFD API as a convenient way to do so.  That is not
> what MFD is for.

I may be just uneducated here, but I'm genuinely perplexed. Isn't the
MFD API a convenient way to instantiate resources of a device into
platform sub-devices for _everyone_ who uses it? Is it more than that?
I don't know how to defend this.

> > Fact of the matter is, we will always clash with the MFD maintainer in
> > this process, and it simply doesn't scale for us to keep repeating the
> > same stuff over and over. It is just too much friction. We went through
> > this once, with Colin Foster who added the Microchip VSC7512 as MFD
> > through your tree, and that marked the first time when a DSA driver over
> > a SPI device concerned itself with just the switching IP, using MFD as
> > the abstraction layer.
> 
> I don't recall those discussions from 3 years ago, but the Ocelot
> platform, whatever it may be, seems to have quite a lot more
> cross-subsystem device support requirements going on than I see here:
> 
> drivers/i2c/busses/i2c-designware-platdrv.c
> drivers/irqchip/irq-mscc-ocelot.c
> drivers/mfd/ocelot-*
> drivers/net/dsa/ocelot/*
> drivers/net/ethernet/mscc/ocelot*
> drivers/net/mdio/mdio-mscc-miim.c
> drivers/phy/mscc/phy-ocelot-serdes.c
> drivers/pinctrl/pinctrl-microchip-sgpio.c
> drivers/pinctrl/pinctrl-ocelot.c
> drivers/power/reset/ocelot-reset.c
> drivers/spi/spi-dw-mmio.c
> net/dsa/tag_ocelot_8021q.c

This is a natural effect of Ocelot being "whatever it may be". It is a
family of networking SoCs, of which VSC7514 has a MIPS CPU and Linux
port, where the above drivers are used. The VSC7512 is then a simplified
variant with the MIPS CPU removed, and the internal components controlled
externally over SPI. Hence MFD to reuse the same drivers as Linux on
MIPS (using MMIO) did. This is all that matters, not the quantity.

> > - We've had the exact same discussions with Colin Foster's VSC7512
> >   work, which you ended up accepting
> 
> Quick update: After doing a little searching for Colin's original
> patch-set, I've managed to find as far back as v5 (v16 was merged),
> which I believe was the first version that proposed using MFD.  There
> were lots of review comments and an insistence to add more than one
> device (rather than adding them subsequently) to make it a true MFD,
> however, I don't see any suggestion that MFD wasn't the right place for
> it.
> 
> > Then you start to want to develop these further. You want to avoid
> > polling PHYs for link status every second.. well, you find there's an
> > interrupt controller in that chip too, that you should be using with
> > irqchip. You want to read the chip's temperature to prevent it from
> > overheating - you find temperature sensors too, for which you register
> > with hwmon. You find reset blocks, clock generation blocks, power
> > management blocks, GPIO controllers, what have you.
> 
> Absolutely!  MFD would be perfect for that.
> 
> My point is, you don't seem to have have any of that here.

What do you want to see exactly which is not here?

I have converted three classes of sub-devices on the NXP SJA1110 to MFD
children in this patch set. Two MDIO buses and an Ethernet PCS for SGMII.

In the SJA1110 memory map, the important resources look something like this:

Name         Description                                         Start      End
SWITCH       Ethernet Switch Subsystem                           0x000000   0x3ffffc
100BASE-T1   Internal MDIO bus for 100BASE-T1 PHY (port 5 - 10)  0x704000   0x704ffc
SGMII1       SGMII Port 1                                        0x705000   0x705ffc
SGMII2       SGMII Port 2                                        0x706000   0x706ffc
SGMII3       SGMII Port 3                                        0x707000   0x707ffc
SGMII4       SGMII Port 4                                        0x708000   0x708ffc
100BASE-TX   Internal MDIO bus for 100BASE-TX PHY                0x709000   0x709ffc
ACU          Auxiliary Control Unit                              0x711000   0x711ffc
GPIO         General Purpose Input/Output                        0x712000   0x712ffc

I need to remind you that my purpose here is not to add drivers in
breadth for all SJA1110 sub-devices now.

But rather, a concrete use case (SGMII polarity inversion) has appeared
which requires the SGMII1..SGMII4 blocks to appear in the device tree
(so far, the SJA1110 driver has happily programmed these blocks based on
hardcoded SPI addresses in the driver, and there hasn't existed a reason
to describe them in the DT).

The SGMII blocks are highly reusable IPs licensed from Synopsys, and
Linux already has DT bindings and a corresponding platform driver for
the case where their registers are viewed using MMIO.

So my proposal in patch 14/15 is to create the following DT sub-nodes of
the DSA switch:
- regs/ethernet-pcs@705000 for SGMII1
- regs/ethernet-pcs@706000 for SGMII2
- regs/ethernet-pcs@707000 for SGMII3
- regs/ethernet-pcs@708000 for SGMII4

and to use MFD so that the xpcs-plat driver currently used for the MMIO
case "just works" for the "register view over SPI" case, and the SPI DT
node inherits the same bindings. In this sense, it is exactly the same
problem and solution as Colin Foster's ocelot set, at a smaller scale
(just one sub-device of this switch already had an established MMIO driver).
https://lore.kernel.org/netdev/20251118190530.580267-15-vladimir.oltean@nxp.com/

Furthermore, I also finalized the split of region handling that started
with the aforementioned SGMII blocks, by making the DSA driver stop
accessing the 100BASE-T1 and 100BASE-TX regions directly, and use MFD to
probe separate drivers for these resources.

I did not _have_ to do this for 100BASE-T1 and 100BASE-TX, but the
intention behind doing it was to solidify the argument that this device
has multiple regions for which the MFD model is suitable, rather than
impair it.

In the upstream DT bindings of the switch, the 100BASE-T1 region has a
corresponding mdios/mdio@0 child node, and the resource is hardcoded in
the driver. Similarly, the 100BASE-TX region is described as the
mdios/mdio@1 child. This is what I need this patch (07/15) for.

The intention is for all future sub-devices of the switch to live under
the "regs" sub-node, with the exception of "mdios/mdio@0" and "mdios/mdio@1"
which are already established somewhere else via a stable ABI. This
makes the SJA1110 a hybrid DSA+MFD driver, due to the impossibility of
getting rid of current DT bindings (this, plus the fact that I don't
necessarily see a problem with them).

In my opinion I do not need to add handling for any other sub-device,
for the support to be more "cross-system" like for Ocelot. What is here
is enough for you to decide if this is adequate for MFD or not.

The driver for SJA1110 needs a path forward from point A (where it
handles some resources internally which are outside the SWITCH region)
to point B (where those resources are handled by their correct reusable
drivers with specific DT bindings which we need). At the very least, I
expect you to clarify what are the problems you perceive in MFD being
part of this transition. I'd rather not speculate, and your previous
response is not sufficiently applied to the problem at hand.

