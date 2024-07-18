Return-Path: <netdev+bounces-112080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F797934DE1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822E91C20F2A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534613D2BB;
	Thu, 18 Jul 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQhYJIvp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B154645
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308476; cv=fail; b=saEeJWbf0BSY1VyyIrkAhLF7E7m341EerSoTijK9cyKkvc4BuObQaQDGQzgSJARY+K1eO5DbpePmzuOYSBFHFHWCcc33AhUmuyf5XU1sspvgTAAfhRui4i+W5HM8p6GDxl6L54Opf+YYijYualzI8GIwfMrpLZfEDJa69sTqdKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308476; c=relaxed/simple;
	bh=8XmptK6ATj8eUi36QTjemzfHSvD8wli0bTl2V0hqvsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pNfMlhF0a/84Y0Dh3LrGPReniUKun7xCOKknWH5yoevDBcjbivHR2w10kMt/BJbDfSB/qOcynu1ay13XCCo0xgLcgg7bLXapyUYvgbq12GCXR6tQDVFFvg8DnQ7ShsqfOXt9nIjzDiaqZ7kj4bDwT65/4JMfOKN7SrgnZOuwdTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQhYJIvp; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wev6kruLlrc0ia6msUOEkUogluAu6xKEkt3UHtWRGprYkbMlZ1VII2WZAtsSNyL+E3PDeWwgUXxYtiTijkm8FEZ8dnLnNV7oULArRJl0oyz0KZOBP19INkAw1HykfnugcL/B2vmgIfNfD+eJG2Z/NqkDTV/mRxqhVqTKSR/niKhhHLkf/eNeSdxoe/6NWt59bdaRtoT0qSEGJEY/ax9t5GcPwahmQg2c5Cn2fFjlViqX38BfGybMQZgNHi17jegTl7pcZS9Qgk5UVjWu0WO9MPwp+W7Emg41vzroFSVrNde8+GIB+RgAxjJD2c6TpgmSkho1SfUclKD9WYQpiFIzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb3Aed/E1ODLf8oFeCT+oC+fb56L2h0ZNxn1JWqWpqo=;
 b=gfcCH3bIMerubYHYfxBGYr42eGmSig32s7qC5sLnyyTC1yItiu9Fh3cXEccRh3xY3WqX7c+aaycGQNxYE23QceZMIjzYjfrYXm4uAkOTx0DXSAfrhzbvxE3oOj+NhLJKcr2r8d5cxc+Ypfkjo1eNssPQsezbPXnHFkDqNuMsZ+9kN9DfDUsWyUL8k0LqLVA9qiVZuFDROeNghERVJVggdVY2Amm1o3VXE8F9Y1ftM1/Ry73LMjO4sOtOxWeDB5yjVrBH8bnkL5p2PcOniqx8DG+K5dDqRy7gnbhwOIb0+I42mvGiiWW69OmUiQhzmLf+yPBdub7iwBYW1G9eBVuQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb3Aed/E1ODLf8oFeCT+oC+fb56L2h0ZNxn1JWqWpqo=;
 b=XQhYJIvpR+6dQPtl+033lL4lKEwZCR1GbYIoXhmKNd6zS5N+4y7D4dMyMyfCHNv8AHct+4EDU9yIgBv0I9b4fRMkZIvpC7jdphbPkLV8Koo0ZEO1G0NnMbQvOWtWpR5svPEND6sAFPTdGfyFb6ZsPloT+cmz1oLXsgs846KZMmjwUPnJfNNbOjKZYkxADFWfviPRxueR6fixJDFIwp5LCZGNWaqhwKSTcZjDWMamYZPqWvyA+KwcNkXfTgcDDY9TVRdgObVnRBrULytTdn7tfM44R0yN2E/lF7vesLJiBZXPPfuBEZQEau2EjqaoOrNMcaX0Z7c80ueHqxYKB2JS9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 13:14:28 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 13:14:28 +0000
Date: Thu, 18 Jul 2024 16:14:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: Matching on DSCP with IPv4 FIB rules
Message-ID: <ZpkVIE1Pod1jrgsc@shredder.mtl.com>
References: <ZnwCWejSuOTqriJc@shredder.mtl.com>
 <ZnypieBfn3CxCGDq@debian>
 <Zn3DdfGZIVBxN0DR@shredder.lan>
 <Zobnma+cQPMhIlSy@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zobnma+cQPMhIlSy@debian>
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: f596fba0-73b5-4ea5-d4cb-08dca72b8db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tmsiQCtFPtvbdRCivr5j7m1EZ/XQOhPM4T3D2wp4NAtlq7qhx4gE/9JwOLtM?=
 =?us-ascii?Q?/luXPRDF8QIc26SVWSLqHuBBvbcK2Bo8zg19rVTfO8CdSUvHR3mBlVGezecL?=
 =?us-ascii?Q?RS0bYnsgSryWTbdMcIccySBsDpHfJa1QEE8zqlShWxTeiUycTRdxH70sWmFK?=
 =?us-ascii?Q?pJaONe2QmL8QSrej2Nff1oqv9dFS+bqLT+NdH+MZZbqYNi2qDeKX+TbrOQkd?=
 =?us-ascii?Q?P792/FSWyoIJZFJMA+WCDVH4FcF+JuNmZVfsdwPBkCmnBL116MbrFvQsD9AA?=
 =?us-ascii?Q?RPPMQnV3d3Y1lGQ8xd3hxJI8jnbrCdqbKRw6jR/gSq5rd1Js9M95zXRE1EK5?=
 =?us-ascii?Q?hBwlHqPHTachJy/odhqcgVNIq7owDf2pJsDZmYSbOVIRYiP7tmcsiIlm7Nei?=
 =?us-ascii?Q?l0o5zeSPk79iJB/ioNSfx9fK8q66xZHH5vFDv5ZXSfBulPCanSeLaKOE1CN+?=
 =?us-ascii?Q?4PgklejZCN1zRJg1AOUShGHTzuAazJbhnohacw6AyV55aKh4h+HkplGn5bPj?=
 =?us-ascii?Q?t3jO8zmwcjytnGhj2z1lu1beXzf7H7dVuCeMMhK3CptkeDJPBJh/JthUavOz?=
 =?us-ascii?Q?82G6/r1mNF84tducJl/mzsJ+juXbbTGvSqjTdQMAPY+Ap/qT4X2SkxiOmpkd?=
 =?us-ascii?Q?I8Ue+0wDonavCYXqWI/RFwwj+WlEA393xngkiOP7jbutcWndNxePmzTCo2vG?=
 =?us-ascii?Q?5oB4J3p+0A8FKcgTT2lte9SvXG7rwTuhed2QWdWQmTZCGeK3xCI4VXFKTmSq?=
 =?us-ascii?Q?skS3OrqgFIE50c9212VT4WQESG5BeTv4aRq9WYdZ5tzJihjUVJWtZVJA6i1p?=
 =?us-ascii?Q?faRrnsBrm+juEFyiGo6/V8kAP/siWLWsak1+luv2HN2h9DvDbjc+7guwzwXd?=
 =?us-ascii?Q?vOrOAPMJMAoRe4ollBx52QU1WOL+QzEHFePktUUmQbKMLo0qWi1toSwVdIdk?=
 =?us-ascii?Q?MzvNOmJyqakNYUaGcNGbiRuCNzA+ekx8/bwvcEni5OfmNiNmGToejMSYxXNB?=
 =?us-ascii?Q?NTlnqghn5fU5CW85tmZXvjWkdqjS7afT4/tftaqfsULthbnwAMwliAozoQZZ?=
 =?us-ascii?Q?KQC+vzkOF3Qtn6FDE7+S2mtZwUdIX7jJMK5ADtnGS93Kw5G+bKo4tryuhn40?=
 =?us-ascii?Q?oPVUSIiUDp6Gfo+3V28AgI/ivl5IBXmSzdDsqJVhhSv7kLAfjYoH+tzzupKN?=
 =?us-ascii?Q?F0sDmmKVO5u3mEMq47+QAISXqvcsvtBjOfS6B8xktHpyRKOC/wrilAUxWCyN?=
 =?us-ascii?Q?zbppmnUUJjzrkxdWX75oKvhmq+3vAv1wLl8gQGTtZVJhQqf3bm8DXhVu3JWA?=
 =?us-ascii?Q?AoqxsFqHWFxlgjQZX86cslMSL0jrBJB1ebWHIpwgC593gWUJCYIDqjBA5yyo?=
 =?us-ascii?Q?eL3zD0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8ARTLE68P05tVuQyCjQjRfAASR41Woarvw6GkTgWfSU8CQReDtgLre7cJ3j?=
 =?us-ascii?Q?m8N8706FpBCK7hAwZ7y+CT2Te4bMeOUM8x3oGg4iW9wqKRt4xvxtLJpSySuD?=
 =?us-ascii?Q?fUuGnx1DVcVrOgHo5xGk8zpLNZ8HkRuKnScCq60/TcJaPkA7mKwkaHw5bNEH?=
 =?us-ascii?Q?AutaSO+VvvDMQmt+EHXJgRh/MzcYJPhIdt7U21tlwh2p+YpIO6HGenHQhcCa?=
 =?us-ascii?Q?fSpeLykbxgestCH1rbueVTiosZrHP8YEV5S4R0Se1FuHJAp3xbMtlQTQqaWj?=
 =?us-ascii?Q?3EwYZk/5eAOmx2SgcgtiT0cqWA5a4IzZAmr9UC838VZFfU+CyAFHQoLHqaZJ?=
 =?us-ascii?Q?OkaYF0lc0yYeRm1pkD/Cl+b/z+eAS7FjuyxlrrD0u3H9lXi4WyeMmQEQ1LYJ?=
 =?us-ascii?Q?HE75H57GgEUEPrYA1MbRhRQQSoXoVOnC+ZqrgzYohOZ67e9T7E0WqedbvSQt?=
 =?us-ascii?Q?FtWjahxVaBm+V4BhgMPeScMQdx0Y1op0CKmhYTYoM8FebUMZRjDnnO82xtoY?=
 =?us-ascii?Q?M/CD0p72ccdrXUuIMLU3TCXB7fN911daM09a9SsiVqyQgMoWY60x112RWslQ?=
 =?us-ascii?Q?iQal5w6/AIS4hi0joScG0l+BvgrWSwZSCw1BuX8YqgYV2hTw/pPLXtWm28MD?=
 =?us-ascii?Q?pf3p+iOe12rOTam9kOnJzUElk8vJwn92qDORd6N2h6kwkkm+hfVnwIsXlB3q?=
 =?us-ascii?Q?4WUwH/SeKX3yZ/yjHfpHfvoeVU80UJnEc+ooISkFwx2mEfQbZghq4hJ7/Txj?=
 =?us-ascii?Q?30HUaRROBxftbTwNdyF0wVXC7Ye9NimUTv6N+a188geOccO984+JPnbE3UPP?=
 =?us-ascii?Q?B7zubM9LqtxIDGCBWIbXAnvw44r3AxbyAszdE6M3FCM47zZN68OAceHQRNrP?=
 =?us-ascii?Q?triOMsDLAEpzlNiaRuvwwaW964e4j4kuu+h/LmhnP1Ye7Ooze8GAiigEVz6v?=
 =?us-ascii?Q?Z33nZ/UuuE+bDEl7mHGp/0d8pRROCFLN1WiMiqsH9egkjYGPcuwSa83rOEIf?=
 =?us-ascii?Q?T0OyYle3zEkcLW1h8jK8Yznr0EKkKZKGmUS5ZI5lyzkkfRSuNQUU8BvqhMzP?=
 =?us-ascii?Q?HlWJ8uxqpku0LTZ7dRXoYchv5ptjwL7F0S/KnLt2nhyL8CzChVx71H/cc8gB?=
 =?us-ascii?Q?mSpneZmUz1qRFa6m5JVU5iidZ5dSNNArCMVTIMNtufNf+iBzsSPmc6n4qAoS?=
 =?us-ascii?Q?0yT5L6NtdRt5nE1N8pRnlHoNVRfWbgZPLzqLwHmaxuh/4eYasQCYTMqGds/2?=
 =?us-ascii?Q?ku+LTghcEuIg+WVvyf1LLZoy+xyg7agvh0XHdh8Jjn809doUUNuCdpRg2sNa?=
 =?us-ascii?Q?IcCzFaXnrsR6DzZv8C0oHg1nsWA+t7oywvAJOuec+mrSvypZRtbuJJumGqnv?=
 =?us-ascii?Q?hQm6uRClLNJkP0qo+QwRy65tFg4psKimFJYHdLhJR9eWfYkc5CokuOsyXqDE?=
 =?us-ascii?Q?DMlDeInq0MwhAu9/VNY99TyOMkvlJ7br70pbgovE6n0arMOkfCuFAb3gTf4R?=
 =?us-ascii?Q?CvB5UlqdtKHIKRhqW57vh2BLqaYu2bH0vkpVHQokvxBT52l5O1GUlZy/fWm0?=
 =?us-ascii?Q?0a9YQqibJ4u0Huf1rp+Ekppu9vu10vTw/hb/Tx7E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f596fba0-73b5-4ea5-d4cb-08dca72b8db6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 13:14:28.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PzlnoUbzHBtD6nQPkSg4jiOlHYaAvQvO16w5XBNNSxbXoNCYaF45iuhPg4tamH3wutOje1YGgr9Ov9NxoY3gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292

On Thu, Jul 04, 2024 at 08:19:05PM +0200, Guillaume Nault wrote:
> On Thu, Jun 27, 2024 at 10:54:29PM +0300, Ido Schimmel wrote:
> > Hi Guillaume, thanks for the detailed response!
> > 
> > On Thu, Jun 27, 2024 at 01:51:37AM +0200, Guillaume Nault wrote:
> > > 
> > > Could removing the high order bits mask actually _be_ an option? I was
> > > worried about behaviour change when I started looking into this. But,
> > > with time, I'm more and more thinking about just removing the mask.
> > > 
> > > Here are the reasons why:
> > > 
> > >   * DSCP deprecated the Precedence/TOS bits separation more than
> > >     25 years ago. I've never heard of anyone trying to use the high
> > >     order bits as Preference, while we've had several reports of people
> > >     using (or trying to use) the full DSCP bit range.
> > >     Also, I far as I know, Linux never offered any way to interpret the
> > >     high order bits as Precedence (apart from parsing these bits
> > >     manually with u32 or BPF, but these use cases wouldn't be affected
> > >     if we decided to use the full DSCP bit range in core IPv4 code).
> > > 
> > >   * Ignoring the high order bits creates useless inconsistencies
> > >     between the IPv4 and IPv6 code, while current RFCs make no such
> > >     distinction.
> > > 
> > >   * Even the IPv4 implementation isn't self consistent. While most
> > >     route lookups are done with the high order bits cleared, some parts
> > >     of the code explicitly use the full DSCP bit range.
> > > 
> > >   * In the past, people have sent patches to mask the high order DSCP
> > >     bits and created regressions because of that. People seem to use
> > 
> > By "patches" you mean IPv6 patches?
> 
> Not necessarily. I had the following case in mind:
> https://lore.kernel.org/netdev/20200805024131.2091206-1-liuhangbin@gmail.com/
> 
> I'm pretty sure this revert came after someone complained that setting
> the high order DSCP bits stopped working in VXLAN. But I haven't
> managed to find the original report.
> 
> But there has been fixes for IPv6 too:
> https://lore.kernel.org/netdev/20220805191906.9323-1-matthias.may@westermo.com/
> 
> > >   * It would indeed be a behaviour change to make "tos 0x1c" exactly
> > >     match "0x1c". But I'd be surprised if people really expected "0x1c"
> > >     to actually match "0xfc". Also currently one can set "tos 0x1f" in
> > >     routes, but no packet will ever match. That's probably not
> > >     something anyone would expect. Making "0x1c" mean "0x1c" and "0x1f"
> > >     mean "0x1f" would simplify everyone's life I believe.
> > 
> > Did you mean "0xfc" instead of "0x1f"? The kernel rejects routes with
> > "tos 0x1f" due to ECN bits being set.
> 
> Yes, 0xfc. I don't know what I had in mind when I wrote 0x1f. That
> value clearly doesn't make any sense in this context.
> 
> > I agree with everything you wrote except the assumption about users'
> > expectations. I honestly do not know if some users are relying on "tos
> > 0x1c" to also match "0xfc", but I am not really interested in finding
> > out especially when undoing the change is not that easy. However, I have
> > another suggestion that might work which seems like a middle ground
> > between both approaches:
> > 
> > 1. Extending the IPv4 flow information structure with a new 'dscp_t'
> > field (e.g., 'struct flowi4::dscp') and initializing it with the full
> > DSCP value throughout the stack. Already did this for all the places
> > where 'flowi4_tos' initialized other than flowi4_init_output() which is
> > next on my list.
> > 
> > 2. Keeping the existing semantics of the "tos" keyword in ip-rule and
> > ip-route to match on the three lower DSCP bits, but changing the IPv4
> > functions that match on 'flowi4_tos' (fib_select_default,
> > fib4_rule_match, fib_table_lookup) to instead match on the new DSCP
> > field with a mask. For example, in fib4_rule_match(), instead of:
> > 
> > if (r->dscp && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
> > 
> > We will have:
> > 
> > if (r->dscp && r->dscp != (fl4->dscp & IPTOS_RT_MASK))
> 
> So, do you mean to centralise the effect of all the current RT_TOS()
> calls inside a few functions? So that we can eventually remove all
> those RT_TOS() calls later?

Yes. See this patch:

https://github.com/idosch/linux/commit/80f536f629c4dccdb6c015a10ca25d7743233208.patch

I can send it when net-next opens. It should allow us to start removing
the masking of the high order DSCP bits without introducing regressions
as the masking now happens at the core and not at individual call sites
or along the path to the core.

> 
> > I was only able to find two call paths that can reach these functions
> > with a TOS value that does not have its three upper DSCP bits masked:
> > 
> > nl_fib_input()
> > 	nl_fib_lookup()
> > 		flowi4_tos = frn->fl_tos	// Directly from user space
> > 		fib_table_lookup()
> > 
> > nft_fib4_eval()
> > 	flowi4_tos = iph->tos & DSCP_BITS
> > 	fib_lookup()
> > 
> > The first belongs to an ancient "NETLINK_FIB_LOOKUP" family which I am
> > quite certain nobody is using and the second belongs to netfilter's fib
> > expression.
> 
> I agree that nl_fib_input() probably doesn't matter.
> 
> For nft_fib4_eval() it really looks like the current behaviour is
> intended. And even though it's possible that nobody currently relies on
> it, I think it's the correct one. So I don't really feel like changing
> it.

Yes, I agree. The patch I mentioned takes care of that by setting the
new 'FLOWI_FLAG_MATCH_FULL_DSCP' in nft_fib4_eval().

> 
> > If regressions are reported for any of them (unlikely, IMO), we can add
> > a new flow information flag (e.g., 'FLOWI_FLAG_DSCP_NO_MASK') which will
> > tell the core routing functions to not apply the 'IPTOS_RT_MASK' mask.
> > 
> > 3. Removing 'struct flowi4::flowi4_tos'.
> > 
> > 4. Adding a new DSCP FIB rule attribute (e.g., 'FRA_DSCP') with a
> > matching "dscp" keyword in iproute2 that accepts values in the range of
> > [0, 63] which both address families will support. IPv4 will support it
> > via the new DSCP field ('struct flowi4::dscp') and IPv6 will support it
> > using the existing flow label field ('struct flowi6::flowlabel').
> 
> I'm sorry, something isn't clear to me. Since masking the high order
> bits has been centralised at step 2, how will you match them?
> 
> If we continue to take fib4_rule_match() as an example; do you mean to
> extend struct fib4_rule to store the extra information, so that
> fib4_rule_match() knows how to test fl4->dscp? For example:

Yes. See these patches:

https://github.com/idosch/linux/commit/1a79fb59f66731cfc891e3fecb3b08cda6bb0170.patch
https://github.com/idosch/linux/commit/a4990aab8ee4866b9f853777a50de09537255d67.patch
https://github.com/idosch/linux/commit/7328d60b7cfe2b07b2d565c9af36f650e96552a5.patch
https://github.com/idosch/linux/commit/73a739735d27bef613813f0ac0a9280e6427264d.patch

Specifically these hunks from the second patch:

@@ -37,6 +37,7 @@ struct fib4_rule {
 	u8			dst_len;
 	u8			src_len;
 	dscp_t			dscp;
+	u8			is_dscp_sel:1;	/* DSCP or TOS selector */
 	__be32			src;
 	__be32			srcmask;
 	__be32			dst;
@@ -186,7 +187,14 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	    ((daddr ^ r->dst) & r->dstmask))
 		return 0;
 
-	if (r->dscp && !fib_dscp_match(r->dscp, fl4))
+	/* When DSCP selector is used we need to match on the entire DSCP field
+	 * in the flow information structure. When TOS selector is used we need
+	 * to mask the upper three DSCP bits prior to matching to maintain
+	 * legacy behavior.
+	 */
+	if (r->is_dscp_sel && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
+		return 0;
+	else if (!r->is_dscp_sel && r->dscp && !fib_dscp_match(r->dscp, fl4))
 		return 0;
 
 	if (rule->ip_proto && (rule->ip_proto != fl4->flowi4_proto))

Note that it is just an RFC. I first need to remove the masking of the
high order DSCP bits before I can send it.

> 
>     /* Assuming FRA_DSCP sets ->dscp_mask to 0xff while the default
>      * would be 0x1c to keep the old behaviour.
>      */
>     if (r->dscp && r->dscp != (fl4->dscp & r->dscp_mask))

It's a bit more involved. Even if the old TOS selector is used, we don't
always want to mask using 0x1c. If nft_fib4_eval() filled 0xfc in
'flowi4_tos', then by masking using 0x1c it will now match a FIB rule
that was configured with 'tos 0x1c' whereas previously it didn't. The
new 'FLOWI_FLAG_MATCH_FULL_DSCP' takes care of that, but it only applies
to rules configured with the TOS selector. The new DSCP selector will
always match against the entire DSCP field.

>         return 0;
> 
> > The kernel will reject rules that are configured with both "tos" and
> > "dscp".
> > 
> > I do not want to add a similar keyword to ip-route because I have no use
> > case for it and if we add it now we will never be able to remove it. It
> > can always be added later without too much effort.
> > 
> > > 
> > > > Instead, I was thinking of extending the IPv4 flow information structure
> > > > with a new 'dscp_t' field (e.g., 'struct flowi4::dscp') and adding a new
> > > > DSCP FIB rule attribute (e.g., 'FRA_DSCP') that accepts values in the
> > > > range of [0, 63] which both address families will support. This will
> > > > allow user space to get a consistent behavior between IPv4 and IPv6 with
> > > > regards to DSCP matching, without affecting existing use cases.
> > > 
> > > If removing the high order bits mask really isn't feasible, then yes,
> > > that'd probably be our best option. But this would make both the code
> > > and the UAPI more complex. Also we'd have to take care of corner cases
> > > (when both TOS and DSCP are set) and make the same changes to IPv4
> > > routes, to keep TOS/DSCP consistent between ip-rule and ip-route.
> > > 
> > > Dropping the high order bits mask, on the other hand, would make
> > > everything consistent and would simplifies both the code and the user
> > > experience. The only drawback is that "tos 0x1c" would only match "0x1c"
> > > (and not "0x1f" anymore). But, as I said earlier, I doubt if such a use
> > > case really exist.
> > 
> > Whether use cases like that exist or not is the main issue I have with
> > the removal of the high order bits mask. The advantage of this approach
> > is that no new uAPI is required, but the disadvantage is that there is a
> > potential for regressions without an easy mitigation.
> > 
> > I believe that with the approach I outlined above the potential for
> > regressions is lower and we should have a way to mitigate them if/when
> > reported. The disadvantage is that we need to introduce a new "dscp"
> > keyword and a new netlink attribute.
> 
> What I'd really like is to stop the proliferation of RT_TOS() and to
> get consistent behaviour. If the new "dscp" option allows that, while
> still allowing to simplify the implementation, then I'm fine with it.

Yes, I believe the new "dscp" option gets us there.

> 
> > > Side note: I'm actually working on a series to start converting
> > > flowi4_tos to dscp_t. I should have a first patch set ready soon
> > > (converting only a few places). But, I'm keeping the old behaviour of
> > > clearing the 3 high order bits for now (these are just two separate
> > > topics).
> > 
> > I will be happy to review, but I'm not sure what you mean by "converting
> > only a few places". How does it work?
> 
> My idea is to go through the functions that uses ->flowi4_tos one by
> one. I convert their u8 variables to dscp_t, but keep ->flowi4_tos a
> __u8 field for the moment. For example:
> 
> -void my_func(__u8 tos, ...)
> -void my_func(dscp_t dscp, ...)
>  {
>      ...
> -    fl4.flowi4_tos = tos;
> -    fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
>      ...
>  }
> 
> Of course, the whole call chain should be converted, until the function
> that reads the value from a packet header or from user space:
> 
>  void another_func(const struct iphdr *ip4h)
>  {
> -    __u8 tos = ip4h->tos;
> +    dscp_t dscp = inet_dsfield_to_dscp(ip4h->tos);
>      ...
> -    my_func(tos, ...);
> +    my_func(dscp, ...);
>      ...
>  }
> 
> Depending on how complex is the call chain, I introduce intermediate
> u8/dscp_t conversions, to keep patches simple.
> 
> The idea is to eventually have inet_dsfield_to_dscp() conversions at
> the boundaries of the kernel, and to have temporary internal
> inet_dscp_to_dsfield() calls when interacting with ->flowi4_tos.
> 
> Once all ->flowi4_tos users will actually use a dscp_t value, then
> I'll convert this field from __u8 to dscp_t and remove all the extra
> inet_dscp_to_dsfield() calls. That last patch will have to touch many
> places at once, but, by renaming ->flowi4_tos to ->flowi4_dscp, we can
> rely on the compiler and on sparse to ensure that every place has been
> taken care of. Also, that final patch should be easy to review as it
> should mostly consist of chunks like:
> 
> -    fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
> +    fl4->flowi4_dscp = dscp;
> 
> But I'm not there yet ;).

OK, I see, thanks for explaining.

Are you OK with the approach that I outlined above? Basically:

1. Submitting the patch that centralizes TOS matching
2. Removing the masking of the high order DSCP bits
3. Adding new DSCP selector for FIB rules

If you already have some patches that convert to 'dscp_t', then I can
work on top of them to avoid conflicts.

> 
> Note that I'm going to be offline for a bit more than a week. I'll
> catch up on this topic after I get back online.
> 
> > > I can allocate more time on the dscp_t conversion and work/help with
> > > removing the high order bits mask if there's interest in this option.
> > > 
> > > > Thanks
> > > > 
> > > > [1] https://lpc.events/event/11/contributions/943/attachments/901/1780/inet_tos_lpc2021.pdf
> > > > 
> > > 
> > 
> 

