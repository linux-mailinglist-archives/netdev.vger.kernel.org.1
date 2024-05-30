Return-Path: <netdev+bounces-99222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20388D4267
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290DDB22C46
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376378814;
	Thu, 30 May 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CT7eowDE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AEFBE8;
	Thu, 30 May 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717029215; cv=fail; b=MFWi8bprzCIh4I+72+sKtpPygpnARuAkKsJUzK7iNvqAlXchnQWZ9olkBOfEd/p7SutldRMSQhy5xnYeQadhOv5FEWJdOuB5iq0D6HXYd+lXKeSf68J0DYQR+2hzM+u/JNbAZjIn9/NlhhJGY2quqifqOzvp/crt9QxGeqMbybE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717029215; c=relaxed/simple;
	bh=eGP0U/BLVPv/wWSZd8EEVeg6zjTvn4sUdJeEYCCXqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SBvvjoXAhJ0TKWsnGJojJMbEIaPpBhGqjFa9fpAQtbXXjLJgR52RPckHhtrc0GHDzwfyYj0wqma6TBL1KLrW+dFiVirjpDYkhgSroAuUznAAdH5lIOUWhGhGade9N0KuO7z/zwdLHkWK0qDzI3VR8ctO4P/U3lejDlmITsC+C6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CT7eowDE; arc=fail smtp.client-ip=40.107.7.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx6r3HQeL1Ye6XjeCxyOl3xo/GIX9D45jduyaHSFv7/PzCJlNINShR1wM/kSMXe4XbiL2bepa+1sAjTO6/Qc3SIo5Gr3X9hRJPtqCwQYQPWUXvoE7REiqC2YEGinbUX+MsJ4+rhQDYRneR1rCfC9krl/TYrmmH2fxFNBFzX0VHmWzzZYmnXcnF8xWkWOs2GuBh7wTSTYyO82xDj51Kwoo30TS9sb7MNEm1NaOXimGT6523i5kVoA+XVKtW8Gz2DQXvUGWDtAMsusddnR1DE/GUiMoIFvV0wBbg+V/XhXB75b8+U0i7OwDR9jsTf8p8JoXuHoAcHtheUwRigVNFqnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKX/PEfDU1dMLFy4n4Mg7Vv616ZjpXnB8h5hxVWE5P4=;
 b=VO5bS0qan1WQI+2jhBeVZL84NafcIZYXZO+nWRQZPKrQJidEhsQTDuOqtn1PbVX469Z1eHeD8EMIa6mc9HOAwmLUVSntaQEzvRxtA/C00rPhR+fKTVWNXgLAVSaGT6BDVc4LIgO/fYsG5quyhPQihHj0FAhBZS0UxbzhgDjJFSEIbIQsjeOYFr1/RM1BBq4ZoalItBSC+H84klPltPiCgPxjG7D5mH95z+DLmJb1xmvEH40yLU6yy6G0yoBhmX80FcRas7bsMaKB2615bi5I/OfCgCcPuVlEy0x7mIgX0Vy5R1V40FSa/v3YfwlIhAmvTKRRkT+qr1qg5O4a195PLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKX/PEfDU1dMLFy4n4Mg7Vv616ZjpXnB8h5hxVWE5P4=;
 b=CT7eowDEvSn24ADVsm7Jc06ew0Ay96IvwBU0qtyuQefHSFQ9sdQA1dGNoUPsZmAj5KSWH45xNHdEG71EyoghAyMdh/JixfQizkY3Kibi22lewz+P/TGpyUNJmXMvRkYJ0nvHBBbA3o73vMgBPdjKixuXRVc49GzUy4bcNixt1i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Thu, 30 May 2024 00:33:29 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 00:33:29 +0000
Date: Thu, 30 May 2024 03:33:25 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, radoslaw.zielonek@gmail.com,
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Message-ID: <20240530003325.h35jkwdm7mifcnc2@skbuf>
References: <000000000000ae4d6e06199fd917@google.com>
 <20240529234745.3023-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529234745.3023-1-hdanton@sina.com>
X-ClientProxiedBy: VI1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::42) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 83137d90-5a98-44ee-4d17-08dc8040205b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kv9hcf/Y6tDM+uf8aQ0NQwaZCkWguYtHj/f0b1qzbZl8eIQf/aBb2HBwZTIh?=
 =?us-ascii?Q?VosoKf2q2rZOOj6R8chc9mKgkhEWgl3WPaaNoBtGKhk0XsSiHv3PT0JBQRP5?=
 =?us-ascii?Q?cnVCwZ+b7JlsQQW/pSUEE+7S19rJ1Pjf4edXsD4zrm/fG/cMfsCMb5vgNjQL?=
 =?us-ascii?Q?nMOfGxyrYFMFx50bSPJC9xPfR02NmNOgyVUr4ENi3VF3C06VHtpysAH0Jf4F?=
 =?us-ascii?Q?OM75gIeH9oZ+yAq4zCNtv+YkQhXRhFe82QzJ6++TAfz89Ou8DsBmgZIRxAq4?=
 =?us-ascii?Q?W2URN8aBS/8R9Qha7z8HpDWMwQiBbp1bHvzF2RksPHiP7r4TYTXsDHdQB0FF?=
 =?us-ascii?Q?/HPKWv3JkdwVUZYxCdIiGQlWT2j3sBi3s86SZZmYIVUwT9Xb2FFbzYnjGAbO?=
 =?us-ascii?Q?sRtOl+qiwvSx/RgMn5dkVGckDGx/G5koiJL4haAkN3uxJOCDKugycvOfTWbu?=
 =?us-ascii?Q?OLn/xC/Dqg9pMbe43jgfxO3kL0OUXNspBVYaf9yLK3P7+s2V1NWewfsWotDB?=
 =?us-ascii?Q?c+TWPV1uvmit0d8RaVKns2rMBBqvQ9Cib/meFna3EeV387LvjCTCsknOwWjG?=
 =?us-ascii?Q?idPhUFZ8JvxvDGXGrIJ0H1/euIIvC7sgj46EopmmR+iQBOKAyJgwFPgy47zk?=
 =?us-ascii?Q?o+wLk+bVPAQXsg66baHFqhfQq3JM2iYK9IbOW5oJtrSQGSSLow3i70rLVSUx?=
 =?us-ascii?Q?3AU46JPRuAehOwHucWmkKnNV/yJl0sB2/yVur3121z5GxbtDc+3T5gnw7sUE?=
 =?us-ascii?Q?7HXadeQYOzK0KBbr6LtTv42wy3ketGhNMVcY9BNSBbVJPrhp6bHCY994fTRo?=
 =?us-ascii?Q?paWsTIoRIbI7UDFEGA06VAGR8GUGi5ZcDR7VzP37u/Dic/va6KDjCCGydiXQ?=
 =?us-ascii?Q?58INlnaco8zkupOn7CSdbwACR/ca8eZN76ahDZDoszoU3JbBQ9Q2b7fanNil?=
 =?us-ascii?Q?9come4iYS4t7Md8Dx+8Wq22M4sRxeWZ9hrNYfyJTCPPTw3Obqx32lHquyLM6?=
 =?us-ascii?Q?fSGy7lMgJmojYPP06Iw58kr8EDN2bwybxbLxuYbKjuH08dvOpjHJtfu3QZbs?=
 =?us-ascii?Q?DeM2ztZOAODQoSi1HjuMMNWW7AEPheINRk8LZ7TYpSQtEe5eJZzeAiYrSXwl?=
 =?us-ascii?Q?mlby8FQyJ7/WZav7UGUfjF72/aasfWKWeeGMEREJvxuvHnqx4+mBoC7btPJC?=
 =?us-ascii?Q?8BHZep5x3zBi3h16ZDFQETHujNnNWWx0axXi7k+1o+kYU2ditFTcdf5cwk0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5ntdQTEATdJk80Xr5wG1G4F2xGOXqO8wQCnvLqNl7h9aHkwftLK8omDwMWa?=
 =?us-ascii?Q?G6rvwyxA6+WColYCMB0bLbJ5lr+GIjSnuLuU1/OMciFPosiz+ra8WCrn96Fg?=
 =?us-ascii?Q?hpF6JPaeHsoqTNBRonh37A+ETufh2dg10L88bWDi2RwV0NydUFapgpNJhFao?=
 =?us-ascii?Q?Xy67hyPFzrsn71VqDeFMDmY1HjZttEVNNu42XgiNZKU5/czeJG6+XtKUALoy?=
 =?us-ascii?Q?7RyybGk8G96SxWxseJqQWJhZFGu8/F09QBmX5sGSUDheW5od9dLqFd5kRabm?=
 =?us-ascii?Q?qm52HtAGzrtJX2J8B7rNopxqf5FaY5r+rWhL6uo7tYE3IYEIEjvrAcKcSdnS?=
 =?us-ascii?Q?8jIjmI8PwFZ9K87Q3MUcx9DMIEoiiRqMggUrKhV/hH5lPQ3U+a6XMrq95k9j?=
 =?us-ascii?Q?/bSKt838odxQn8aWvoIf0VCVsV/3HafmVPfdm1K5Su7Y34vZMZuGsUA5eBvZ?=
 =?us-ascii?Q?O/1smrNty/QXK8Na0f6Izs4D8upxlAbBT30UaCGpMFU88uH/xDgjxquwrSzL?=
 =?us-ascii?Q?gXa6wAibJmJQckUyV4Y0QNMHrZ2x/HrjqX2B8IVCruP2kDi9fYpkUSuVOTHv?=
 =?us-ascii?Q?hH6lp1RK8YNkugv5FtkIOKoK+LWfpr3tEGKuxu1ZPLAO9WApaKHjgtzFGBt1?=
 =?us-ascii?Q?HVPcXfAcHQwkGWbOtH7quit19ifSoRaYC+CytwWXJd4tvZj8FegawHWhFYIR?=
 =?us-ascii?Q?cym5Uy+qWXoLhm0S77RVH4UWCnfgRAnKDWF99paPwZtG9lmy07IWuFpI8giJ?=
 =?us-ascii?Q?B1bCOxGNbFtCpLhg5xoip2t5y6I/IwhseD3ttTEwnOCSPXjRjyrAMEz1tHDY?=
 =?us-ascii?Q?bW1BfSzPDhJNT80g/q4t96odLaj8vokqYuqqoGx/Qne8y+niu+5Pr4um9BBT?=
 =?us-ascii?Q?jYgD8WZY7H4XGd3C0F/mGmxZTX1UUcYa/BBSa/ezLiRrK65LpCIyGaikPE9y?=
 =?us-ascii?Q?IICI+RqGRprXQnYvFJ2vik37B5sv4WoYeepHgf0D4gXDpTsD3K3kvl/mMeZy?=
 =?us-ascii?Q?fHa60kjUN4Q7gyCoBuRtCOg4VEvpUO6+nV8LGCAYt5e5YQka0nFyLnSrnGc9?=
 =?us-ascii?Q?R/Skw/6n/hBiu7mbvZEfl78KEM/x0SwzE7dnzpmXI0gbgh4SkTs6pyUYGRO3?=
 =?us-ascii?Q?AW5rQBzkB8sEh842ROA8veIEuLUwogthQvd/FDw8QdYj9yJY8c5gcsrYv53/?=
 =?us-ascii?Q?TWbsBivSaDaE00MAB1wIVBbue3jWls9IWqC1yI729usu/afsNAclXnB1iIhD?=
 =?us-ascii?Q?kWfZUHgrA97jJaMHAV2vZU7C3Q9uh9CdgAizNzvR14j2uUsU6y1QMWYGp5Hm?=
 =?us-ascii?Q?KkCQXowbeRMvzQW1qMcjuVNBvvnmHiCV5SGfYwB73IimVq43NY0eJcu2vxHq?=
 =?us-ascii?Q?umeyPHDIkRJQpwwxnfF8vNDZBozG9M61st9ZWWle0+1Sv/bSnqkQwU3LPekl?=
 =?us-ascii?Q?4zxKMFlBkn0KndjvTvnWqf1GQlByK4VRcZDf4uvBaQAeckZO/V5Y7kesdU3d?=
 =?us-ascii?Q?ct7TKlBCK1pao9vz0llT5qGbJiyTzapsms4lT183IeRLzmou3awfAjGuPALR?=
 =?us-ascii?Q?MFVWI9LjLolaLuEBSIDIn2GWGUfHrs506Xn+/MQxlsdXVOdVjXEilKHMqwP8?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83137d90-5a98-44ee-4d17-08dc8040205b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 00:33:29.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD+fcn8xynVT7sj8Uf6GDnMckTv05RMp3dz6TI85IJMqpbQKBcelUix16wHmDyO2hBisC8ZpWRAk6G6obFktfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

On Thu, May 30, 2024 at 07:47:45AM +0800, Hillf Danton wrote:
> On Wed, 29 May 2024 16:10:02 -0700
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > INFO: rcu detected stall in sctp_addr_wq_timeout_handler
> 
> Feel free to read again the root cause [1] Vlad.
> 
> [1] https://lore.kernel.org/lkml/20240528122610.21393-2-radoslaw.zielonek@gmail.com/
> 
> Adding the tested patch in the net tree now looks like a case of blind landing.

What is the fact that you submitted only my patch 1/2 for syzbot testing
supposed to prove? It is the second patch (2/2) that addresses what has
been reported here; I thought the tags made that clear:
https://lore.kernel.org/netdev/20240527153955.553333-2-vladimir.oltean@nxp.com/
Patch 2/2 has patch 1/2 as a dependency, which is why they were
submitted that way.

