Return-Path: <netdev+bounces-131526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5C98EC29
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DBDB21C80
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62F8145A03;
	Thu,  3 Oct 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCvVgN7D"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825879CC
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947099; cv=fail; b=kc0e7PubZd9F+slM4ChV18h4QY/3xDbdpS7b5ie8siVTi56OErFrJUv2H89/tYFhmtmUFqP5PQWXyZJsuRrxK+bOryKINs/5Rc4EGIYJ/rnz0melskrL7v1qdXp64e0U8k8yB/fBo4BCeZmamLCJq+4XmahZD53v0B/jdPyQqHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947099; c=relaxed/simple;
	bh=c8lW357oa/wJuis0mpymYVfVwJ2Kq7NEzDfcy1eee4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DO8aUq40q5O7dmJ1MKFBPXJygqc1dB6kEi3cc46pmYecpakTbGhT6thbVCfWAw8qM1Fk/0CcMmhogkf4VewOHcJClBrlnd82Mm4X21e+gnLt261LyiDt/3d7sOzDh4g9B7r6JJSaBkOktLh6B1vt8tFYdoG0mzRF3FtzkVlLKuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LCvVgN7D; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuk1FZqvZGSmpn+mtsMCL/o4l2Q2eLaKFJ0/35g40ulDcw/ToEUuZUz1vW8wAu+c87PJdGXoLytH8pc3OXv6X15KWB0U4gKkfQWgzXmqD1ty9M8UQZYtnfvf2e88ApyGjd8eGtHnAHmbE/6AQBW20nJbm2hTBn+zqzSgrq7xKRA4BSIaoFWmlmQ0d0pLOPlrDM4i4g6GuEc46TVh5HRHOY5kN6irZ41kHW9pbk90674MGvcsd0+yWJBfO9DkWONrk7TPbWOKrXh1HG4/wSRbcJnwjYbDEIaCrbBcHs2SOefyv8GOfZzba3lC1eeA4hRNh2Z2RQCBgWkJkPlkYk6YnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8lW357oa/wJuis0mpymYVfVwJ2Kq7NEzDfcy1eee4c=;
 b=kVS+0U8zmVAaYJHw8KSBeqVyy059C5qqlYRcyflR7RDRuTZkBR84ZGnru2W590a7DcZ1B671rBN+CVUUtH8zDExksOFtdRfsT2xWbD6dEbicf17FMramdVX4diz4KJSqeyViStI6q4kITBclYdKEjt9CpcfeW4iEAutsFRkiHXsKoj+gDn9rzkk5bf5HidcTanznZfvNL2JwsvMg11mAMN6aN49m8mHcKdT+aUMWWgtvpX8Owl+LliDcBy1X1ZA+WzVpR5uRg4aunoaXeE4ATrETaU5CD8CbN5uXHi3mvSLNJEShRLiNL1ZQY/C1THEfDTVXPfkXazplJbrL/U58pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8lW357oa/wJuis0mpymYVfVwJ2Kq7NEzDfcy1eee4c=;
 b=LCvVgN7D9xLyceRZmOjLFBFyptlmC+7d0SJieuc8WvHje4zzNonxhRABDIfXI7eAzm4grX/St0Efw+mrfkFa9aMyTU0aPbKXwpOrHJkKk0mTRmblGCYvLMP1l7p6XA1DqyE319AtC3q9+LbWnDGQh6QqSDVc7pVSN3ED/fQ/Wtax7u5KmKY71aLmLqJTxQuBOBaA3ZOW0532JTH9QPs25U3tqmJjaKMGgCJ/NTDpLbHWzbq5pFU5F1XWsWuW6E6yeL7c11ttVzI5wJu3JRdBL0uObgOycB6w2dlKTGeGXjxS4oRC1aaUh2vrH2V+RQSPYYHDGwbaGdVBI9v6Yh7c3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10787.eurprd04.prod.outlook.com (2603:10a6:800:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 09:18:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Thu, 3 Oct 2024
 09:18:13 +0000
Date: Thu, 3 Oct 2024 12:18:10 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <20241003091810.2zbbvod4jqq246lq@skbuf>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
X-ClientProxiedBy: VI1PR07CA0297.eurprd07.prod.outlook.com
 (2603:10a6:800:130::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10787:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c0d7f1-fd52-4e6d-e8c0-08dce38c4e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38Qe8hP8ApigWvvUrT8Lxw32eFHPp7TQ0h1qX93hp87skEfTg1+LSzNUwK/L?=
 =?us-ascii?Q?QT25xr/pT1ieuAjjIwk2a2LCkRxmjtAWqt9vqeErhPCxhDVuQQhBInlhsu0F?=
 =?us-ascii?Q?InhcAprisdk+1wKaqOItvAMW5NWQuRkdRqPCKU4MpbkhIqKnt83hWUSjGZp+?=
 =?us-ascii?Q?GnwDPXRCvs04Q2E8pv0r9E7fsww22OQ7Vp1ajjLrfLAT/H9gm0jAk5eR5mAU?=
 =?us-ascii?Q?0bQh8MLG2BKIY2NOd3Agy9jvX0eYPF1GLxOw4IvsEiUEhaDdbz+WGQSJRDWZ?=
 =?us-ascii?Q?6c6XDyqrp0bj+Xs6XJ9Ck8oXH7PUgvay5V0td/uxFO5ZQyGscZPYCD9KFObK?=
 =?us-ascii?Q?Uitep2gfR9neXHw1j3wJc7yys9mAxSZFlyU+rN3iqPwIu2W+5hnfjYUnXHKH?=
 =?us-ascii?Q?WFnhwf+m0JYngqPUI/qW5aAHOyWMxLvPdYg144mx4EqTsXGoKhP8y1lUv2rv?=
 =?us-ascii?Q?cR97OZ+KzTwj+KUy375+P9G5rM10zB7sqPA9+thPHB282ekNh0MDGA7QQd6h?=
 =?us-ascii?Q?DpMAsM9VIUP8izcfnmVEdKL9NipWEZRqB2DOyZ3k0n2ONmV0jzHyg6yyesiy?=
 =?us-ascii?Q?T76aWvYO/x2ZGxA0Awb5AlEZAw1/+HInHFb2pbo0TheemOPA2JROVcBnUzjy?=
 =?us-ascii?Q?Ni51Fg5lo8nwjsn2lJilobB1ilvpCCEtxkcgwyaz1yzUZ5pNnaPCzGr5Oyh5?=
 =?us-ascii?Q?nrSmp9Y18qyX00BbRy6wLSvG227hkC/OffrEMicQANYi06eaZI6s3aCEBDfM?=
 =?us-ascii?Q?TOAFwzesgwZKdV+l9bm7uPqssOLh6Q44qqJgwDJAT3nYDz82i76wnTm/bB5K?=
 =?us-ascii?Q?O+N4d3pjew6rOaSvPHNOcs578UTWnuGLT3U+Jjc0j2SjZLcWI0IbWGmHY3Vf?=
 =?us-ascii?Q?mwM4YEkbXcU3HFM8VZXfYlvjnsFpePZ+VnL6x7RQ5Yng9x3H94g7VBu5TGyF?=
 =?us-ascii?Q?kB2PRee2+SVNJ2UUytNqA06Lf6HBM9JjCx3AMUBp5aQ6fiSSgSpWEg6aM9uL?=
 =?us-ascii?Q?Kn/wqUDL8iPcWFatfYBhc8bidQ7VMmrABaqOez8avugq/k9icg+QZsbvSj/n?=
 =?us-ascii?Q?vBAjQ8NcZRzp87YorYx79nwJEUP+T4QGarwyNtwQSdJIqa3YMfi3rgBj0ewO?=
 =?us-ascii?Q?ptXkDM80pZSjI1wM4KKfm2YLI6QStR4K2v74IGSAVpcsaBVb1atOThEDrpIS?=
 =?us-ascii?Q?1hRUFRn/yttH/sCNiVr6/nW8R/6S/PpSMQn4CJJMqM/eRA15LVBzrUaZ+LBf?=
 =?us-ascii?Q?49SB/bx3WYBwbmkVxjud/TDcybs3F3m37dSU8vbPZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sktYcRcPtHSLsXLLhMxvfPivI8aPqiYKRPGe0OmkcEX4/17kGHSphdMfoCPw?=
 =?us-ascii?Q?5B3NvD6rOkWgTsBH1bGoIwuZZZweZN3YGCpmjLYsJaqq8MV77iNpYTYOC2NK?=
 =?us-ascii?Q?UzWf6VHolZpkgGaAOTQiSxp9LiJIUPxr6Pp8sdbWxIH5xXpTY2iy5mf92m+0?=
 =?us-ascii?Q?nLPy/4Uuu1RHWkgZxfdD5CqBJgAf4/pfzrahJN6K+BzJEjDjS2MizBr22gYa?=
 =?us-ascii?Q?nkUf2jiJdRHzuUzrerUTBgFaY+LcC53BPudf+cHb/9I1h4MgulOKXAsE0v4u?=
 =?us-ascii?Q?oBXG+IcSCX8Qt0LhTuPaFuoWB31CRnQb8W7AfkfJNoEJTN/l3FurdDZ/ezSC?=
 =?us-ascii?Q?GGW9RgBRkqOQtS+5gacn+tPj4SSjqdyGXT+qU5jkEjPAp8qLeQfrI3FEBeCB?=
 =?us-ascii?Q?KfUtr6zeIHuAd3IHv2LWsj2EAQdTE/G8V1k0sJQy1kKU8U7+Bo0oP3mAq1q0?=
 =?us-ascii?Q?mTBSFWuSGY2azSP1CjgL7N0fGjInAR/DJntWIl0iEkvhBFmoYBJLRWpRvFQk?=
 =?us-ascii?Q?4gOgYuVzLPFGH4uSbDK7XGO7sCFK+xa18beeZ8wESYN6ayW0xKCgaxyrPIhg?=
 =?us-ascii?Q?oW+jl4/jzTXtKl8aDDqGNaiRZVr6GtGx0HpX56M+xcwtJbzm4lOhQ4PVbve7?=
 =?us-ascii?Q?5PkL8hswnrs9fUAXApyP+91d81k9TWV4dSLkEOjUppxUWCfyV9nqTfVjY3po?=
 =?us-ascii?Q?8ysKoOP8K7Zx/CBL0EHsMtbjAY1E3e7BaIhJkdXR2U1SkJ7xxfjeLRcJod3G?=
 =?us-ascii?Q?imZSrvqpmAMade4QC/Rff+Zqm/fs64+VPkAxFYAXeAALxl32t3O42QqrUxEO?=
 =?us-ascii?Q?7+cHNVFwykg9sRx7XlJFyqWS5jd+S3woN1JfnZ35VfUBtnv9tgx+pfAdEl0b?=
 =?us-ascii?Q?jU0RefnWG25ulztrGfHKYdjpFHoLkPrY756eKbjgOZUQxA2RCfcYBrIH5KsE?=
 =?us-ascii?Q?5lvvm4ZNIPk15AruzTDKSXZz3lrEUjvulzOURsskg23nSVUt5GPFjAZqSOBN?=
 =?us-ascii?Q?GQEBTfdY0vbz6wuGztCh9CPxIqGvEt9JfmKBcQ7VVs1gOSaT2ac8m9OyT/AU?=
 =?us-ascii?Q?sxi24I420eql5axVS/sxF27/dns2749dvCf8M45Tu/v5/98Ax7sMz9Fsswkf?=
 =?us-ascii?Q?8Pq1vLx/mzw2kYZjwAux00a+UIgzSrj5UOVvanO1hST1Ocs4OebEsp5tyDq5?=
 =?us-ascii?Q?8VRX8YUoO36sxgL+RPxBNdKZnu8hdx5lwj0faKHBMr/va7SGFL4ZCFZ1aVU/?=
 =?us-ascii?Q?jRyaWGnceEgHtzcHBp25jlb2hvWd5DWIGip3X2L91W9LUHFRjFYPPPsgYKTv?=
 =?us-ascii?Q?tA2Qaaly7Ximbb1AqR63siAOve9uzD/5jS/jvpT3/+VBjc7kEXQoQJqhpiNr?=
 =?us-ascii?Q?V1gPsf/apEWC4j4zDfjm+J5UKOnnmyXrHS9BAXektV8HI2SS5ZIu+mc+LN/o?=
 =?us-ascii?Q?p33WLIOaD/nNS8BCWThKHxQs1mZLmO6+CQsjRXSjPeLkSP6NwXRkISW75CUK?=
 =?us-ascii?Q?SoxZlSyASZVTnm6vPooVwYPxvSxWjaerdD5GHDj//DsT2NDS5vLtCQG/wHSg?=
 =?us-ascii?Q?WZ/AV5pfs2UqmzKZui6m1ga9EZw1LkiC0eFoyhUnI5NC4fvcVv07I06bibHh?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c0d7f1-fd52-4e6d-e8c0-08dce38c4e7e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 09:18:13.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIocSVbbJ5QjkJo+Zc51TKRktuh/CFSONxod5MEXJqMnr+p/DDhdd0mDypfximayJuaBvvxdMwZc80aZ0206wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10787

Hello Jake,

On Thu, Sep 19, 2024 at 10:58:48AM -0700, Jacob Keller wrote:
> We could extend the netlink interface to add this over netlink instead
> of ioctl, but that hasn't been done yet.

Let me understand how this will play out. So you're proposing that we
add a new netlink attribute in ETHTOOL_MSG_RSS_GET_REPLY, with Fixes:
7112a04664bf ("ethtool: add netlink based get rss support"), and this
gets backported to all stable kernels which include this commit?

And then also 'fix' ethtool to parse this new netlink attribute instead
of ETHTOOL_A_CHANNELS_RX_COUNT? Thus introducing another breakage: when
the new ethtool program runs with the old (aka unpatched stable) kernel?

