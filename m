Return-Path: <netdev+bounces-214097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38786B2843C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A921884DB6
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B330EF90;
	Fri, 15 Aug 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjOtX6kE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620430E0F7;
	Fri, 15 Aug 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276273; cv=fail; b=RDMzsGloYahuZmN2Ez8Bzver+JpNHJUHgI8CxfXibVGte/qOXpxlhg7uIuqsK/VvNTsh/+ZXnep1pnfZBoofHUHlTn6HmTDBJvVrUFqELysJxcb4O9FInpO7Hbu/6edDkM3f69PZi9GWlceNux9cfeTXYsI0x3/IcRUTO92AW+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276273; c=relaxed/simple;
	bh=qUClWci+BCrK8O8JGN+OBvXI0iU/RharO4L8ESVv1v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivtgKUJ2cnjwmQPADDs0UAQKgPZkXGoEy6ikOMC7jiXiwqNgFXrFtkz58ymKJbzUFUzPyw1rF5fkySrY2AD2L3Kb6fJfvh+GLSQKqH+O6dnGV+6wgluf51VuTU7tNdgJEbBzHkDMmLX8ryirGIrkDFJs+ezmgFsVxto4L2/r728=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjOtX6kE; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs7MDDEGp+84822Y5wv22CagqNQgChd8xGbzD778RXTAJ2DVEb0Ht5VHfFNcltzQ3lWaxqJldOzrnNc1EYITegZeR8qI4qd9sVnqFwbrVSBXQSXfiqPFdxD8uSy8LEh4t8MEakoUPuYtjarL5923hyiJGN+OJIe5LQisf5RLeehPbpK9jYHB4IvAks8jh5Lbg+XBRSH+P0B/TJQlYlko/x0cXyQv65XMLiKVgrLwB64Z7Ac6tBYO7diF99WeTVCwWDC1hfGy1/RjAabnu9Hqr7Mi8U78q4YWm5BB/b9Tu6tPqJsMu+RyDtgtuTDp9X3c0Gb9VCTwDs9FGB9hnQI1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1PdPO28/oEDDeLPoAEYsidITH00i6DDaEUwj1JRBnE=;
 b=Q7c1DUh/gr+/WGvvebDDdqdfvnTB96ru//oURsIaeXEsFrk7ird8/APWb+bg3jYodIMF7O6ZDV88IQE4Irr4LWCbNyJBbDSvNAl+vJTe+lapzdeOqtqwLvOtnYCRDeC5Ahz207tqLKoOPR66GnVyeAmjV/naO+K8rk9Y7JPozLkWq5p/KDwotHtVB730LQLOnChfEtIaJpJY3Fz3TmND4Rq2jnU0N9P3CcLIjwbbff6rIxqEZMAZpCs2dj5XYJFWgfKooyR/OZeatVaS+qIv/2tkl8u8i8n79gE+GBBITTcjCEXXVc/k1XKXpgE7a7doQiR9Y0wssvL4CqftP0cQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1PdPO28/oEDDeLPoAEYsidITH00i6DDaEUwj1JRBnE=;
 b=cjOtX6kEOuCYc5pWyzwrVFbtVbDYMbjEa4oNqDXJMQ1QNJg4oLT34bU57rru38qZKehNL7+KCmLOkbgUyWcAyENuaqVpDp3jPfDkInL52kI8NTEoVsmsT3obJGMTIWAbFt9REmJwDBQx+49AdISzwKochi8JWiG5AmEgNf5GSF85OiXp3nhUsmzmv2r3bg3vrLadPv2KgvuIEWODOVmp0V+0uxLqhpeh4p8no4Sk2NIAqAxn6DG4Ln1PvfrWZ9Kx57WrUZ3oPecZ72epc1wxGfl/GhlaZ5XAUX9GI3b+lXIrtxPG3aqroR6SdSa/XaGBWrDnlAaE1REAOx9z9Nd8cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 16:44:28 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 16:44:28 +0000
Date: Fri, 15 Aug 2025 16:44:20 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me, almasrymina@google.com, 
	dw@davidwei.uk, michael.chan@broadcom.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 00/24] Per queue configs and large rx buffer support for
 zcrx
Message-ID: <rekaw6n6fsfkh46tbkyms47wjf7cdllwsihpsvp46bcrhxsxp4@ytymllzp72u6>
References: <cover.1754657711.git.asml.silence@gmail.com>
 <ul2vfq7upoqwoyop7mhznjmsjau7e4ei2t643gx7t7egoez3vn@lhnf5h2dpeb5>
 <dbd3784b-2704-4628-9e48-43b17b4980b1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd3784b-2704-4628-9e48-43b17b4980b1@gmail.com>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d89751b-1d36-46dd-7816-08dddc1b002f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9XTaA/1yx8KSbHGpyQnUX5Htgy6h8TkJyNTg6b+qdNMTXK2cv9sr0MCSeOxD?=
 =?us-ascii?Q?VEL868vfGOWT+bga8Zg+IiT3bWUh5C89ZYF2T/VPzN0X/b2zqnNAfhqhebFL?=
 =?us-ascii?Q?nmfA5x8DLl3ZhvDvM4NtOd/1ereU+AL+C9npByyn9XkXNNsBbRcO5giOAHoq?=
 =?us-ascii?Q?QTJiHiED3npcasOZjsRj2CT4ydJXa/kycwIQymEkLeSr4KQGIbjuOyw32rDi?=
 =?us-ascii?Q?33jxmjPkRa4Fwc/EnZA+8c9VbuW6GCyF+s6aQYmBVeW+N1YBEUHevmBfKNCO?=
 =?us-ascii?Q?7uNCJNgzCYcMnotqryoiuzzELnua37yZ11O8nGjqxRxAzVDJh13YsUkMU5yU?=
 =?us-ascii?Q?mjODar5qwNo9gQLw8b2pBnhd6SMnTM61jsxoG/oJM2TBuhvF0F2TEUOYaMON?=
 =?us-ascii?Q?xp2kA93zkwzOZYmMPaR0T/csup4GdqgekXMKEyXc1XGbnfK5URhk8g4TMdAC?=
 =?us-ascii?Q?SHwN0kbURHJKTBh7ox2pQ/P/OM7BRToX3md98zkMvhvv1IbFNvBqKGi9zQg1?=
 =?us-ascii?Q?HLkzebYa0FhLeMmHNw7na49Fg8ICcXBM4j1pVxVYznMgv7WMOdf9bcCft+J2?=
 =?us-ascii?Q?4r8wsmdy8yafQtVM9AEy9hn5X8enMy6pVFlbkOwyNjdngqwGXJwa30K0HL0a?=
 =?us-ascii?Q?sdvaWN+BH3tL30VkRplt2GdsNlymZuw0+E2JpADe+LCrOMSie+uOoI4CZ08N?=
 =?us-ascii?Q?NUa014BlAvV4VMWXDmVLjhXwr09Kye5JMl2F9uwn2+1qAbTZSXs7vaqce8TN?=
 =?us-ascii?Q?AF30ViEKjOSkmB3n+1kmfrBqhnGdUdJRyaXzDDlDkIxSdBIDkBRaG0t51CBs?=
 =?us-ascii?Q?IOcuKQ6d/hqgClc2jlNt0+Z+GyU/5d28H0LRKXyyiim6dNGmXTlchVj9YHyY?=
 =?us-ascii?Q?H504eHkSn2JGuFkZgcIyvN8DcW1RBAR8TlDGk2dTLud4/DmrgCmsbUP3ehUz?=
 =?us-ascii?Q?EXqRjXEAE24ZCF1cSjEXvKe8+hYGC+J3pHo7jB/Uzce+leQgDhXPXVO7AdTu?=
 =?us-ascii?Q?MnBqm26fB/clctrKAOVPI5eRj2dJPe/lnwCk6QtQsC4jvIGj1bolya6lBDAP?=
 =?us-ascii?Q?CO4dUumSdrMb6R/CipgKOfEnLr3AWriA7PKl0BMypOr10SK2qtGUqWbQ/cB9?=
 =?us-ascii?Q?bXVb408exrpFnhm35yXrVLMM/tRGTwyukcUvMLHIALYIj3wlZkLtIgB/t4oX?=
 =?us-ascii?Q?JQ+DjYSJ9k62YdMPJDVhcSnjF0yXp2TEHVzpgAIrkqWqfa/LLDZ3coWdDJKk?=
 =?us-ascii?Q?pdAGrbaL+Vt0B7z8IOqktmXH8wCYeDjocXxEXutlDcpnEtOMIbOxn+e2QCDB?=
 =?us-ascii?Q?UBPLubhWQL4ZowVBwtYXKL5/q1nriAvH6prqT95bI4foLT/wJGV+l6G7GT73?=
 =?us-ascii?Q?V2nnlSPFiBf1WevA/H4l6MPtpPmmasLgtijiYMg2koKuFQdLErngLPKAgwdR?=
 =?us-ascii?Q?ZG8/h6w+h7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iUsY5AqA2Wl7hJ5Z+EhUurJJ6psXtOvYv6GtXmnoXRY13N2gnVEFdPrL6ZcT?=
 =?us-ascii?Q?J2qjMZKSkwbDSpac3uOWgoNngemN9b6crC8sMi3uWKGZT2MYTywqR6FzQTIJ?=
 =?us-ascii?Q?9sqP6x3UiyfCeYYKl1gCkvwfzG4bfwYlfYrHH1JREYOz38jpN6rzmtPnuTW/?=
 =?us-ascii?Q?5JA+7pNZmfpf+j9TXz9nmct5L7Go9WUKfxnTA1MRszUKZKXnqPhxd84FBBLc?=
 =?us-ascii?Q?//Yqv9XQ9eQQhBV4qTb8WntKoBJgjHnZM7Rb0zw1d6lG7+QF5/ZBSYgDKCWh?=
 =?us-ascii?Q?Nv1gdC0VMncDWWeqnJN7xmDelUTe45CyUxROrB1FTaIaA4tsMK2iT17+7rX8?=
 =?us-ascii?Q?UKeKM2CIMfX0FO0/s2Fk8yHJ60I3gS++GFEv36XbLzkc8a/qGwAWsOCne4NI?=
 =?us-ascii?Q?faMkgnU3bACZYw274MzzjC063EEDDO0N8TLdF6UR6a24KabOjBixvtb93IRe?=
 =?us-ascii?Q?XmPJkEV2BNjlCNh93JbkZuBQ2gv+WoaaOCZgeK5h7Xu/3oTkepXEEgMQbr3L?=
 =?us-ascii?Q?D018HgGBo03RVlCbVPTn8WpccB0SYQvVKlCGWDag9dlRDhazEa7GWNyfOnfC?=
 =?us-ascii?Q?RA+zQ6VZucnb3D5xe+3zMsq8THbU39gX5KPTfyRHDZ6BmncrBuDYuV2xf0i9?=
 =?us-ascii?Q?QH/u9qZCBQX7vDkyOCj9LqUybvKAcQutCi69mJVz/fs49Yp1fhAMLeoG/je4?=
 =?us-ascii?Q?yjCpsoiRz0lLhkIS+5f3ylQ96myNOVDCQgyooAkX2f5jIRfB01wnkYFaOjq9?=
 =?us-ascii?Q?8PFVAeg1GeoozqxV8vNWL3/qcE0VyJbU6SgeGU8Zdjb9M01mk5k+G8GoiB/V?=
 =?us-ascii?Q?B8F365m1oQN2FQ+ynwkTJkQLsmWfhzu5JzvJUgDxnEmsdkWMrEZfoFYdmulW?=
 =?us-ascii?Q?6JAN5OKUQhFoCqdyihD93aieoZtjwfBh6vKsQhTY4W3ouHW+EBDzucSXSnep?=
 =?us-ascii?Q?5hV+UJPXcuioRiZKBvx5neW26Ogv43n1y4vmcp8ASrabLU+wlaUsjUOTvGnP?=
 =?us-ascii?Q?NK0/ay8Oxg8/h6q61uhZvnR7qTwzQCNeMN8X1lNuv16lu9J0SoIH7CXrVc0X?=
 =?us-ascii?Q?yGhi5vOn0gY90liHGIhTmm7U1/rhq0qcYcO4MecdyGVWurQkrEW7tZyPmDP4?=
 =?us-ascii?Q?WOSTO7QGMd0KWguHLJ9VGbd75MtrXXfCmN1zz6vqPbN2Vs0xQFN7VAcZKRzD?=
 =?us-ascii?Q?uplqyUYmOXTFcaLnmFfOvzT9amA83g8HeC/hjanEH/rT+atZl7BXaiPj2pQ+?=
 =?us-ascii?Q?uaeLTPs0/dJ7/joyqUEmoRLl6nVTc77Ni7klgcEdYEc53kheu1vZ/JiFwESa?=
 =?us-ascii?Q?98naaRs/vMqKptZ1hG59+HDqyCfdINZmHNDGvPslYD1PCYB0xtaLyqWfwl8g?=
 =?us-ascii?Q?t9ANmrP+2GJrF3ICg9PzaddFXMbYEUfaZudPk+/3A3/fmz5VNWnswQqm7ePX?=
 =?us-ascii?Q?/B7JLZmfwBLt1U7ipZY4Lap4fCRk+UYu8L2sgFKqCw6sojn1zKPDhd5AawfA?=
 =?us-ascii?Q?qTzjBPUjv1ObMpByzEWF9LnEol1v3SvsTZi1PmZi2joRPWUfuciLh55d55tJ?=
 =?us-ascii?Q?rjsARt4hYbmFxhuZYPJJFgLV3QroB9jS+KJXeOJV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d89751b-1d36-46dd-7816-08dddc1b002f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:44:28.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHt46EoHch5ESnHlOZgtus6BysryWBdYw2jXfQDYF/8AmzeRq13c10cWW/cVCrQUeJf5eiKeXqW54iM41ct3hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152

On Thu, Aug 14, 2025 at 11:46:35AM +0100, Pavel Begunkov wrote:
> On 8/13/25 16:39, Dragos Tatulea wrote:
> > Hi Pavel,
> > 
> > On Fri, Aug 08, 2025 at 03:54:23PM +0100, Pavel Begunkov wrote:
> > > [...]
> > > For example, for 200Gbit broadcom NIC, 4K vs 32K buffers, and napi and
> > > userspace pinned to the same CPU:
> > > 
> > > packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
> > > CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
> > >    0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
> > > packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
> > > CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
> > >    0    0.69    0.00    8.26   31.65    1.83   57.00    0.57
> > > 
> > > And for napi and userspace on different CPUs:
> > > 
> > > packets=10725082 (MB=1227388), rps=198285 (MB/s=22692)
> > > CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
> > >    0    0.10    0.00    0.50    0.00    0.50   74.50    24.40
> > >    1    4.51    0.00   44.33   47.22    2.08    1.85    0.00
> > > packets=14026235 (MB=1605175), rps=198388 (MB/s=22703)
> > > CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
> > >    0    0.10    0.00    0.70    0.00    1.00   43.78   54.42
> > >    1    1.09    0.00   31.95   62.91    1.42    2.63    0.00
> > > 
I forgot to ask: what is the MTU here?

> > What did you use for this benchmark, send-zerocopy? Could you share a
> > branch and how you ran it please?
> > 
> > I have added some initial support to mlx5 for rx-buf-len and would like
> > to benchmark it and compare it to what you posted.
> 
> You can use this branch:
> https://github.com/isilence/liburing.git zcrx/rx-buf-len
> 
> # server
> examples/zcrx -p <port> -q <queue_idx> -i <interface_name> -A1 \
>              -B <rx_buf_len> -S <area size / memory provided>
>
> "-A1" here is for using huge pages, so don't forget to configure
> /proc/sys/vm/nr_hugepages.
> 
> # client
> examples/send-zerocopy -6 tcp -D <ip addr> -p <port>
>                        -t <runtime secs>
>                        -l -b1 -n1 -z1 -d -s<send size>
>
Thanks a lot for the branch and the instructions Pavel! I am playing
with them now and seeing some preliminary good results. Will post
them once we share the patches.

> I had to play with the client a bit for it to keep up with
> the server. "-l" enables huge pages, and had to bump up the
> send size. You can also add -v to both for a basic payload
> verification.
>
I see what you mean. I also had to make the rx memory larger once
rx-buf-len >= 32K. Otherwise the traffic was hanging after a second or
so. This is probably related to the currently known issue where if a
page_pool is too small due to incorrect sizing of the buffer, mlx5 hangs
on first refill. That still needs fixing.

Thanks,
Dragos

