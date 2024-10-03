Return-Path: <netdev+bounces-131620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7498F0CE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474B8B21D2D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A92186E3C;
	Thu,  3 Oct 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mdn8xMEW"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B88C07
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963371; cv=fail; b=PKJDOUNKT2I3vmT/JLIGoD1eTm2X5FrUbDkrb/9s+rZB5rp06ToLkcPR/drKOEKjhuizUh9u2goG8WMTcCCSUwQBboM4AjqeQcovcxzOoU28DXf6YhJMSTbhkQ6oRULMVs1xcp0MYgpE+tCCfFZ8bJAgaZjqs2YVCXbAsWCYXGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963371; c=relaxed/simple;
	bh=uSzHeWEfr2DkP/FQtOzqktL1hzs/Szm0Vth/vcnaUNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHrklBOOMivbuDln9U2eFE2EjBMkM0oPKeCJwI9DYP5VF8dcI0b6h4ilpJf/cFpvewLAtzumGM7/6IVB7NCgEH1ms+VK+74dpbqsR/3cNJjPAozoUTndIfEFGbElEoJ0ZepygcC7XHEkClHcfpPp/zxfeqyT0xnH4EBkRMjCfEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mdn8xMEW; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/+o/ASCkygiVV+FT8+l4MCNWVYyFhyZYMgO3EZfUhj7ByDGQOQraPz+4Qsf645UgyVcsxMZNNGQVIcfFEd6KUlM0eGuCoIbAnfM827jRfahaIMD3NgQX3He0qGHGRHEO26zhQSIL5gL7QrxGSbc4oeQFcrYnIWeu99Hyd/zfTWOTteNZhQrWKdrr+Yn+FzGOa73nwAUJd+ERUE+vwjXjh5INdR/WNxBHLmpL1bxCtcPZBzQPe1mF1gDssj8VtIGZC0mIte4uYdH6MR6uMcLjJgaWQ/efLog091Ue5BGB29SSHtA2jh6/eViVxhgZN3GtzStkUqE1LO4Tsz1Qbawlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uc3DJP0vutF5vXQp5eJ/LJjNTe9nKbTLSGpH0XRtssM=;
 b=yME64TZnvqEucYPVrXdJNDkpCyJUlEELJBC6RLtTjg0tr76YaP4HoPfWCSOHuiHYZ4nNrXC5tckPFjIkIy5svVO8Kcs/clK1HhXUTYlIjtOwYKVlvAkwb0vQ2KskMkFZvAV4g/54T4/jDSbAUNPvBQvabl0aAti3kaRNhVbuZS51J5nfsB8DKuvwakPJVgZrilncqHaVLv9rqF1iChon/c43iZdBxuCBMtQkKlkmSmdUaHkaZ0WlNbqkI+IIUQOXYnjeMNU/KYmM+zVyy9RBFJ+uNCBCdgdHZNhiIrGjRaF1iw45+efbW1dUpgpkbz1ixfZ949sDpsuQh7hCuKQfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uc3DJP0vutF5vXQp5eJ/LJjNTe9nKbTLSGpH0XRtssM=;
 b=Mdn8xMEWnB87T5KmyGQQqt//ixg6fuMq/ZChRvGkWKQRPuOP3FJGwwiW9dqlWZBoJDDW2iwu0ZuLP2O51lKrYQRDu3KZkPbBsp32jUYkjfp8Z6u/afI/Y6SJRv7QXFwBS3Wvy+FFP6Rt5rpS8z1H3bSOm10wt/u95GE66RflVap2hAaQBEdAB95PpbHQkyMZaBUtMDZtz6fIHfiaRN9saWt/MTm1Vvwl9wZi5IKHTSycDndgT2csvKzQv5maDi6EYcSyWhBbgDJMdKS7Qp8M+mrXA+MUWhbTSwSM3vaB0n4FM2ujTUEQj3+cYOloh9g/ZK/GCX4fclIC22GCv2CkDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 13:49:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 13:49:18 +0000
Date: Thu, 3 Oct 2024 16:49:16 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <20241003134916.q6m7i3qkancqjnvr@skbuf>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
 <20241003091810.2zbbvod4jqq246lq@skbuf>
 <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
X-ClientProxiedBy: VI1PR02CA0057.eurprd02.prod.outlook.com
 (2603:10a6:802:14::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f91759-c765-49e4-12cd-08dce3b22d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Rw9wUuGosIa7mtutiGYEi0pBYcX58qvOOXQeDOwo2yvtadDETST1CQJhDas?=
 =?us-ascii?Q?mi8zVKX5Eijc3+5bPw2b7hnRFT4sycNs8MOAYosW/Xf5+AClc0Aw4UbI57Yk?=
 =?us-ascii?Q?41j5SdP7Jd9hiLCGkyPf8ImIKFPBEKhyqsRl5tG2sY3IKkDJFq7Rm5D/Aq/z?=
 =?us-ascii?Q?bMSnJwrRVqK423T93gHV8mNE6805pBd9iH9Iz+hmXXqRqOyXeeCAHD9h3yKg?=
 =?us-ascii?Q?6eT1YckCBYUx6nw/Ab0MLm4ruPM2yuFLASVwJTaOJohsYiw3sw69h2Z/5Bsh?=
 =?us-ascii?Q?Wy9M5W2fd2hi2+OfHEe680xvpBG1J7qejA5M30PfTQFLtSzra4VR6sf0gWQq?=
 =?us-ascii?Q?Q74Rb22yFuwGVM6JTesAvVLWhzWWZXTDdmsIBi85vJl8QkUwh7tqepUvCr02?=
 =?us-ascii?Q?hiNXxAv95oXreiVLBdHkHlIgLOlsQzr0JdPI1ZWTkxteDFfVAnPQ7kiy0FOe?=
 =?us-ascii?Q?gSOMVamG7uqsQsgALeotrndeMr3YoQrZly4vGY+sa3QNKjbEX7Cff960LVbp?=
 =?us-ascii?Q?aVfc0Xg8A3tYsn2KA2Rd/G+Fuqx+oyJElYfPQfGqveB0gsOi3lntDTn99WOj?=
 =?us-ascii?Q?DVLowikLRDQ4MaEbsekykOOI+pf3qu6amKTNBAEF6IVTrIg5zMhtRiN7wWJl?=
 =?us-ascii?Q?HYxueSQN74V3CxSl3026pcDpHAHaY35cg/huRqSQmTLTmR5SkzFPk8aJNQVt?=
 =?us-ascii?Q?A1R1as2DRUvUZkYL3A3AN1MQD8azIcYuyAgP88oqseffDh6dkuBdjCSXW3PL?=
 =?us-ascii?Q?7ZU3O35/1R05l4XKunpcbg99Ghv+jXV+wTGUsCZtOyRSOyU4gOLD3uVvBd5r?=
 =?us-ascii?Q?EGv6DJIXUJu66t7FXqsFnZCWaRBLP22O6/3CWJpZ6R+qtQ1VWBnPRnMa4dn7?=
 =?us-ascii?Q?MLXwHocoFT4GtpZ8lx+RqIUUc1H0Z5rNyfaQ3HsvWxEDbT3470mOyFUCp0mn?=
 =?us-ascii?Q?ojw0enVXieSWMUN7U665GEkqOFsqt5+hxXFaVX073cH/otx5H3CZK7dGnaMx?=
 =?us-ascii?Q?x6MMG8WuO2l3gHsY8KxBGfcurpYcQfIWokS+ZZBpE4VVnJ8UnBQLAl8VummH?=
 =?us-ascii?Q?8thUmzaGTumh9YBNiqk2NrmRftobft0QollydeUCOdj4zAxXAA7KjwfUbT2u?=
 =?us-ascii?Q?dqXjqqZnLQhRc6lTbey64yNU/eliK9gNWAmBXVVAV7vet3TK+LEQwpkBtFp6?=
 =?us-ascii?Q?DQGIs6QHWxRq0Av8XCc46sxXHTdiUZ0/5IvimgMlIU1RXwOhzDlnn6WiCsLt?=
 =?us-ascii?Q?wU9x2a3KCVhSj/2uTaUnBkZPhU3o76+RhbPqkK5ekA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DA77eY/iNxRJRCYZu4pwZaBW3PeDoDvFFHMoyH4E9CiB4Zw8jsVaX+SSj/Xy?=
 =?us-ascii?Q?UQdLQI+XBNLY+2CHPqCk2jA2Eynet4iQNlXF/c7MONmf5LMxowtmECsw91gl?=
 =?us-ascii?Q?8o2Wo0BTuw4nApfjeh/6iuMUxqCWo0YaW52gm/5lhXi2eHM8xcArkHnikJNh?=
 =?us-ascii?Q?DRaT6CckxaN1ITuWiw3zD6d6CwQ1M/SchpG4UsS/WSRLeTnNime66e6m5uKX?=
 =?us-ascii?Q?L5WOIIgKQ69buSbxTErzxZ6tSEfstzqRnd15I1PFxIL7+mDThmIzy0QBCLP4?=
 =?us-ascii?Q?nSVY9z6v5Ioa2I3gHx6cRZVphceewrqCCU8sD+eUIohkQic+3kLJ6cZP6Z4T?=
 =?us-ascii?Q?KgyUT408DucQgr8D2zfMS6ZsJzRGTU9jN3nJWUvRLEmpsMOlka99ou6zPoFt?=
 =?us-ascii?Q?hdXNm8dKDPf1Fb3XD1zd0esYoSY6/ieG8O5Yey2fMd3NFOUbEgBA2oS7jQLJ?=
 =?us-ascii?Q?/zqjpI0HMw/Xme61iu0IVANKXYZCj5XSlzXJ7nu95yk6cfuu4t9EFy+79J46?=
 =?us-ascii?Q?gOg1RPd77dTwPqxHT0g66OUPA+9un9P3v6WUCtd0OgjwPrIzGxXoC3BrMb5s?=
 =?us-ascii?Q?YnZSt4Eb0Lqmz+fGUYeKPO8/2JO+6dS5TLz+ZHigu2YjlrCkeYBUAOE45rpX?=
 =?us-ascii?Q?SNjYmCSS5Gz60qoX25swdHJbjVME/YmzAj6zN3BJINEj3y3b1H8M2dkNEXlp?=
 =?us-ascii?Q?BaqUZqVXCBVhiVBLg0fmKxRQlXZu478WdG3uklxGP8JgT6E5TuIlBmGK/wiS?=
 =?us-ascii?Q?b9+JwGZWi7qRIXYxfwlL+0LSMh6NoZRHXlzzxbWUi6sKdnmBhVs44U3uIIHc?=
 =?us-ascii?Q?GWWl+0Nhc7ELMAQarZCM64CLCmBO6mj1Yur1bs795uqMt9aPCibHUcOZRxs/?=
 =?us-ascii?Q?pszIRPsssv8bS3qtRjhzL/pkHIF/wqqtbuqsdllBZ6qmm2lSCEbFrO4yXxZD?=
 =?us-ascii?Q?mOeptPFumR205lembUgJgQ+8c//SPZJ1MdgHuF6tOoTD452J3Fk5vC7bbrEJ?=
 =?us-ascii?Q?MZFkMR0SCDi2KRj2xMhbJcEmhqD7WwT6XWMcJwphm7BhFafikH/3SMTcuttk?=
 =?us-ascii?Q?mHsxRwvwSk9fAeD4+Pa2hLk2jVYnwA7pgANFjuUbklcCGXIb9Z4wSpWxZcit?=
 =?us-ascii?Q?BWnesUyziZcUW4TzAZHmRwNeWp98ijKjKi4lFknD1+PFMTw4yRbtgrwR2qwn?=
 =?us-ascii?Q?fqaOF6ywmhVPcfBhcOyrmpxyIjtc1edeIzF5g3w2oilM6wAXn79ItcLMsf/S?=
 =?us-ascii?Q?AQmFN0xy1N44AG0FBEv4NzBArEbB7JEzKMuD55zyVNGaGA2nv4HHgU9N6XB/?=
 =?us-ascii?Q?sWIzVePap4puwRDeK+x54FiQov43BmyV63Wog689mDFyUhgFabXcWLKneuJQ?=
 =?us-ascii?Q?2WOc3yHhiKdhGoHcgrL5Jlxrh4XOofOrGlcA2z7bAPFfhzXJzMBJZn4/v8C/?=
 =?us-ascii?Q?PYVZHEFlVQluYzDGUhHjRvcYbIPDXx7EmIdDUnfA+BfuPNF9TbdmxNT2LgqP?=
 =?us-ascii?Q?3cOmgO5NzyviKgfNLiASmawtsB+jPJq4xI6esG4l24Me5QMTzGGnkjnh6PML?=
 =?us-ascii?Q?91pT2cmCmAfrIPAC4UCag4T8p5sxVJ0/61/IPcJ8dPaS2OW6f1o4uOvP7DtU?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f91759-c765-49e4-12cd-08dce3b22d86
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 13:49:18.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/2SFn7d8HlD/+RFLr+6lEdgl+fXpQj3cBhzJAy0xa0NzxQUEPgT7hW6pdpZskgh9Qa9kZ5/MMAtvQlZ6ySoPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

On Thu, Oct 03, 2024 at 01:09:47PM +0200, Michal Kubecek wrote:
> I'm afraid we will have to keep the unfortunate ioctl fallback for quite
> long. The only other option would be to only use netlink for RSS against
> kernel which provides full information and use only ioctl against those
> which don't.
> 
> Michal

So, then, is there anything blocking this patch?

