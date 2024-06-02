Return-Path: <netdev+bounces-99979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA98D74E3
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 13:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9877D281FDC
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393A381BE;
	Sun,  2 Jun 2024 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SPg7HO2U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A122C2C694;
	Sun,  2 Jun 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717326986; cv=fail; b=ocnbw7JwRCLf7q0rw0q9GtBJRFpopGPQZLFKOSuOxO81Qp+9ZprfPAQt4wurpjlOuXWzHBalkexepv2nuQZBm6sduJbzGOZp24KKNjc4xFSOXaXp2roEvQDFRYfvYj9AFmt5MRsXXt5imYUu3s8s8QQ+6kt5zeImfCyNDcPfNuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717326986; c=relaxed/simple;
	bh=/qKs9VN04V3lMgRDcR7SY9Us821/Yd+Wf4T3hz045kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRTBH6CaUu6KJgCMx8umUfLzp+EARsadCGeDDuEBnctksDM6cUExd0M2lC+hbSX7yKLxUd/rTFOmCvC3x/imIuvCuoMU2aXcUtPSdj2nH2ZdbyStw1d7KRTzroKISJPuQWsYLM/nns1H4vsN5RXJfNLsCr5nAM81Xle9+SlFZSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SPg7HO2U; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j84OZ1GBG0CX8v4VF6ML5rJ/cNobVCQPC37NsGVQ21NNRMsVl7esWRQrbdaZoO5G5p0syPcj+wQePIJNy5u1h08FlFBOh5x+ufbN+nP28+f+c15Y+0m0gAU5eSn0BIFbEi/3A0t6h9n7X5VxD3Cyb4xH6ng9g4w6Hx88ZnvIUb5fJKBDWWslc1nm1GxAVz+LIwW0e+VZsqteXiaXlOnBcBRmzGXvote5cMmKVrmcxm4yK7V8kHaLngM2ZdiVCXgv7X6wVJXgEtlYKYuctmBPj/A4UKUG/ZGG9nsx+gNDXWO+9eMxNd5Xr26swCKlyfGnQy3X+L7jQNWnfp9DyzKzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L4jHrKPSMZo38rJ1tB5hkG2kBAnCrhxe72bG1ZduE4=;
 b=YZxQXBf2zSTpBE181kUB4JnGALpAqDKKG31bsWFRutawOGmlUXw9gqB8TlwT9cAoZjkWsKhrZq5M6oWaS1ZV0vjmfYY/W420CR4o/k9JfuHW7/lPFbrmUtbR1mVm/3vpmPogLjvtf2M+IDOTM6cPQDcerDQYJsDRI9Nqy8+pArOVSQzO58RbiGz+GVv2j514b1TLMc+N8E1FKeYmG7NLdr5J6yU2Adh8TF0quYaquGBnwYj60y3Y83H1kZhTH0CJ8nvwbS31ri5e0i9r2Artan4Aa7z/L6/K/VNJ/l92DZiXp+rZ14yhNdh+jUZsoE7UwIcY4+8FuARTNIWxCIwLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L4jHrKPSMZo38rJ1tB5hkG2kBAnCrhxe72bG1ZduE4=;
 b=SPg7HO2UWzsJnQi0F3k6ZWQUKimp31KfnyPvgzEs23apP1lfukCdaDEWhBOQl3P3fux1qoTD+mSP2rTwcmXuCBYB95jupYVVQGd7aQ9RCkcGdcerwHcze7Y57Nsy90XWOcGzmJIRRSrqoWNXCNkA6qllEnZgpow+EC3tZ40PGI3Q1hF4n03wm3/JH4er6fnqhnlwH51VUvvh1bI55SW+FFrlsVT2owxOkxt5+j5mSy7OGGiDtCnw8gwe/XemcMch10YS/AmMU8/9VOKcOcTkyKBdN8AqvpqCq6DgBzYjvbtsmQjfKV4MQ9BCH2le5XaC2F1f6l2P9ZW/cUs33gOegA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Sun, 2 Jun
 2024 11:16:21 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%3]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 11:16:20 +0000
Date: Sun, 2 Jun 2024 14:15:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
Message-ID: <ZlxUZcDdLanjcGAb@shredder>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <20240530180034.307318fd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530180034.307318fd@kernel.org>
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aab9766-04f2-4e8f-bf42-08dc82f56e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R8pkIMqz7LtylMju8b85AoBtBHZZEl7/Oap0ECwqcOH8/JA4l9g6XZkDQ8kz?=
 =?us-ascii?Q?s1Ih9i4M4WxPk/FvKn3/CS5Q6xww2AvvgTbvaX57cLkmkpO7EaF0RUiICtNO?=
 =?us-ascii?Q?FL/KPS61h7lxIXCRiurth/dUKPQ2eXCdMZ/UUgUFrdELJg7dqAQxsZW8fFuF?=
 =?us-ascii?Q?ErGgJVxSILcYYGnaIOtAahaAmji6EQ4xXxQODSc91T9KsrTUgkOOCAZkDc8V?=
 =?us-ascii?Q?2eLaQs2DAUvDixvKdWCNO0+yJaetKbQiFKwV3bJLbz/L98DPEOt35p2fXoJH?=
 =?us-ascii?Q?w43D4lWt3pA+gP0lUo2NltGI5eKdrAyP7aDr4guXnLYiBW/r0g5HQBPWZ7bm?=
 =?us-ascii?Q?ALynGeljCOttGtP3oEJPgba9OXEdJtjeLvYPCCESB+kxTl5qKw1hXNd3Ojei?=
 =?us-ascii?Q?Rwkf1wBmmcdG6cEhoO/2D1e3a2smH/7bRof/NFrj9NbedTJYHqabxTu5XT5+?=
 =?us-ascii?Q?947Ses6wSBKCYH99X1iSHMthq2aPg4rJmV7NVF9224q3J5mOG1grjsoCU92x?=
 =?us-ascii?Q?bu4/jh6qJq72Ff45JzgHsjem83zzGsgznqlBZIiGH3wr61I1jgExCkNPClik?=
 =?us-ascii?Q?F+78NJ9lk4tVPZFedTJRhLAXdZuSs3pZ1YT8GxO8le3kLHkrgS6MJZTMHt8J?=
 =?us-ascii?Q?xCQrPjP5d16yVkLwnd/0ZODWqCuKHMN+7x1rtYS+mvbHLibu65T4smaoI8ec?=
 =?us-ascii?Q?DB+ObQUOOxSSqp2PRwbmcVSjkAWSazHk7ZA+EIKqgRiCxZRr8CeXIVvmLo4k?=
 =?us-ascii?Q?DkXmc5ofIpIe0AznWyLbwlrpXIDAKd9s6STBATC+ssrE4dG4BKHqKY3BgcDq?=
 =?us-ascii?Q?uE2guq1wfSLiLphfTxR22CMQz/Ha7Sock+ZchKAsQOs/9KIUBUfaQ5yoOAL6?=
 =?us-ascii?Q?80cettm4GD6KAxNrGMhG9TAgPej3uurAVf6n1BpmTfAoe20OIN63aCV8Axd/?=
 =?us-ascii?Q?6XX4SWILrFz7pE6Td0+BlyDgLceZywAK7fYMS5kZOQ1PyLR1SnP5TFfJKBJp?=
 =?us-ascii?Q?qKkI+akjttdQn/wfvFUILeKxoMvpXWMyHc1LDngd11lwQktkwJEFk/RG6+gI?=
 =?us-ascii?Q?f/1F7jRwoMyOtN4dCeVeTyBh5MRAym4+UPV8TDGbjlQXAqz9drtF6IEOpvXl?=
 =?us-ascii?Q?bf6I+VA0XjwyYcwYcVROaPJdR0WRokKPcf089wkEMqAm3IRA0fAsipBdtY3p?=
 =?us-ascii?Q?uCpPsI7/Xwq2ahoEUT1Xhj0C/orOY1nsGSRQDAh1VDqaGMnwauoZnk9fP8yq?=
 =?us-ascii?Q?P+ZjtBM8D/uhB/a93riGN0OrSyKWBWCQasujBWC2CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXakhHc9jmgKe7JxCQp3/j8xoXJJlzYWq8Rzt9912tAfxx9j6mA2iqEFjs6V?=
 =?us-ascii?Q?H8mNAr3WRJCXpZ6Y53hhJ40+m6SlXdu/PYjqS4bG13Yck0BZ+UDaY32S4Q5L?=
 =?us-ascii?Q?An9qqDKVv8FtkWA4C993UhdEo5YAEktmZXPBwm/fBevstr7LONR7uEAOM7xT?=
 =?us-ascii?Q?HSvvkwxhizGesJ37vOxMZmulN8tuaR3Za2fT7m7oQFrA2k+y4ma4UdpfOZmc?=
 =?us-ascii?Q?SUTgsopqnYjh15hX/5du91ifw96sU+88r87YODZWGPqjQ2he/eInZJ0pkrEK?=
 =?us-ascii?Q?gAfBPvsnSTQJ+Ul6+o4XxqR9YsQL9gOEnS6PR5o4qok/Nsyi5MhNyxxxHQdc?=
 =?us-ascii?Q?vZVeYLx485A1cyI4lo8kGTFpo486LT27kqMkoWITbng6o5S14G0UWb4syUBr?=
 =?us-ascii?Q?dG3GWLdZhIYCcnhREoRUSC0swqzzgEEw83qX+QjgfgAxaR1VF81owsBqgBLn?=
 =?us-ascii?Q?1xGi7IhjIuIiqs4t6L/Jp4sFbPnULilUivHI9P1NbzKfjVhgXO0VGlA46/Pq?=
 =?us-ascii?Q?qgcV8cD5WktOR4SHJ56/8XS1FtHdKbzrT/yyz2mjGj7bJ6C4y7+AbeNwrw/B?=
 =?us-ascii?Q?xzu1ImduS0Q/O+bgr0RCoVUTK+Ee1KA0V5VfKYzcbeQoMyV9a5yvqlhfINER?=
 =?us-ascii?Q?6LvmYdspcu12/6051IjY6hym4UNq/g/2W2ENqKlr+4RQcBpqGwhY26QbiE6T?=
 =?us-ascii?Q?U3+nx5R93rryI5Xk2TLMoxoLihIFB0Dhmx+5Oo0UJxIVCu5Kwbayz7I9r3lv?=
 =?us-ascii?Q?Ie6mC4nKob/P3wbcZUqt/GhRqlFEPe6BKyiAoY7xY7KQS+nAbVFWZJAYA6yb?=
 =?us-ascii?Q?QfrbtA5zOKHLvaFghF26hjrUevowwygt6NfHMAshwxdk4QT887LDISntFK6L?=
 =?us-ascii?Q?eqI6cjb17D2mYp/UT5EdhL457mFcIRDIyCqIxeWFDHi+B9UK4ZMeI5eEkPGm?=
 =?us-ascii?Q?7SH4f2/6ngpz+kYDoTzatEV9ZcC3hJcPwysOZVS2RSI7rUN5KNwJYEla4GLe?=
 =?us-ascii?Q?CWjdU5v3nlmUJ+9fOK6aePOfh5DaBCFZnNiSvwu4gP4ofH1cWpMZ+BNRr3VT?=
 =?us-ascii?Q?pm4akIaVefIMkaXrP83kbrc+sGueyMoeUY+1Q7TbucKiMdeJDdJmfkPKUL5C?=
 =?us-ascii?Q?k8wy0FpY+6VKlB/JJL8OXcGHssDW8SeeM01ROL0YYM+sN8lK77gCa5e6tsfU?=
 =?us-ascii?Q?3q0ybK+9J7hc7930Vc+UVy2hsJY6gK26VRINTvu+bLn630lAzmXW53fwNYvK?=
 =?us-ascii?Q?nXINQJJhGHx6iE4HzByJklqFovgwkNLXfmgNshH0ZMMiiQH5FlDNus7Dr7Vz?=
 =?us-ascii?Q?RtNsTvG2zCbdyUAX27+2cqi0F8dymJMiADZ9KWy/P5zTzZdDArQ5+gKsc5X+?=
 =?us-ascii?Q?dQAX+aXdl4CV9qQgBuJN649AnxapaswVRXKxSN+FiGQc/2z7DB7yj4gOaiHp?=
 =?us-ascii?Q?l/6CYmv4R7APgdjg+oa+a5a/4F6p8oL362AHfw+9ATV5yiHjKk8KwIJE3g7L?=
 =?us-ascii?Q?GScRnQeIkvRB4hrkjVpFiddrWLOt3jEOXiUDgcr+dOyhIE7Zk5Ph9vqUWBbF?=
 =?us-ascii?Q?euf0iRU7Q/vsbCeZIrkUtZ62++VZlDqgY2bPO+lE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aab9766-04f2-4e8f-bf42-08dc82f56e04
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 11:16:20.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1o2EXWB23r2mhsowGYjih3vG7R2qXOe2U/z5v4EJwztL+1kV7EJN8SWFFhqaorzsfycn/26cMK9v89FDpX3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Thu, May 30, 2024 at 06:00:34PM -0700, Jakub Kicinski wrote:
> On Wed, 29 May 2024 13:18:42 +0200 Petr Machata wrote:
> > +fib_multipath_hash_seed - UNSIGNED INTEGER
> > +	The seed value used when calculating hash for multipath routes. Applies
> 
> nits..
> 
> For RSS we call it key rather than seed, is calling it seed well
> established for ECMP?

I have only seen documentation where it is called "seed". Examples:

Cumulus:
https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-59/Layer-3/Routing/Equal-Cost-Multipath-Load-Sharing/#unique-hash-seed

Arista:
https://arista.my.site.com/AristaCommunity/s/article/hashing-for-l2-port-channels-and-l3-ecmp

Research from Fastly around load balancing (Section 6.3):
https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf

