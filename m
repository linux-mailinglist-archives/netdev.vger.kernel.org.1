Return-Path: <netdev+bounces-151996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9ED9F24E0
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469DC161BFB
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C61B2186;
	Sun, 15 Dec 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jMbOaA8+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC21758B;
	Sun, 15 Dec 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734282570; cv=fail; b=klNmWsPrGFdq99MHpTnMdcUK9QQTrEhHkrLUyOgBXFnc3JEeqEZJbj/bAuJOcuqWxfHnUxOjXHSd2/HMPGm7eTu9Uqebj4TPEKS5knsZ3o2z25ytZAjrNoQR4hSHnlhs+i1GAplaz4l1i5Dy6zSgzOTg70Pkc80fJmNRmgvLFnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734282570; c=relaxed/simple;
	bh=I3I++nTYFXRPrQ80dtKA0AejRZBh2+jIpWyhEwVpF/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bT/CD+jLqREOqCjR3l4HTAo4/UFCHzmaHG0SfaB15sV4Klq3YTEcW91zMNv/GZqLpI/SVuu0D5BGm6p0H1l6QtzwaGLDwwKkHCtbG1kR7ZuwpACaaSZHTxCJ3jKdFmZatDwQBmNqH1t6xOq9L6/+l0oKe3sk0mvK9TVF/C6oXNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jMbOaA8+; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO96/JZUrUm5zP/UL/xXwjQy3idraVvlF8CrMS/17Cnmu4KXEA407VIKnKeBrf6rPpui/UnOztexLxzSh50NQcNmB31e00Qj5IVUQBhLoFLyItkGgQp58GeY7ctf04Gi0ZJ+XoloG/bbBt2M8TOn69NVi9QTkAbOvCy62iW91aEVk4ZAc76LLVFQGScuYx/sXb2Zhz9bchyV9SrdaLxsWxrHCcVtRlX83RVhgaXq0z/Mg9gRwmdrY8bC3uO+2tdkCvBV6gWi7ICT9K0b12zMB99vDxX84Lc2gyoJBOYoS5CtY+ySKnJH5TcirubDwBXbq/RaJFyaLkOVFcd0zc10uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3sYiZrghfHSvSRw/9XAtKObiPOb8NnumEhcpDw8Njo=;
 b=t/IJwciRC7+Bck0nQyUhAf5MD7Ld/M4thrGGNlfBxbY/A2wPgZB+AQieL+y6COm3/2oe1mQfv9ZGUfCXw+vxxMVzalLmhMyHluTSc9wmwZVblOfM36OPyY/Kti90CGZ78LY0jJtowec3vig2kBvllPKBpwI6hs1GbiBomgRnXnt403ze8DIF+WgttfZjlti9zkGoRPpHlkT9SVc2EY+2n1EQ6HQJemV5pMhEZr7GV24wwbSZrntD7+96Q5Ho9JioYtKhXFW3nI/j9AmORjQf3kZ/TBef4J2CdF2+P6tb0JwAlpDBRi/9NTdcNsMzYwSYFxmpya9a6P/5yuIk5cioVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3sYiZrghfHSvSRw/9XAtKObiPOb8NnumEhcpDw8Njo=;
 b=jMbOaA8+gXJIjnoyEZ5u1YXxMGmwiJhMv2IFYitgqRT2HcBox4iMmZzIcwz0boYQamxaY7F/PBnJyXI4WVDnPD3ORRoFeHjWE+cywSMNY7tehUeZ0RFY90eRs1nLSlNLAr/OBMTl03iFTnyreaEoFPJCh6OO4XOXhL4PCRUuX+FW81v+2SgSjmnTXoe7TuHQjeqQfmhgl7MGTf0dtX4anAUWdgz577abPer8RgYO1YCFy460Bv1zSrrrH6KptSUIY3NgsQ42XwrYYZBDVm//hGA81pwjFomDtbaUr+MX0X8tiX4jLHz5uPdZswvaqVfKBWN1gH0C/wllxxKGYc6ieQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Sun, 15 Dec
 2024 17:09:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 17:09:24 +0000
Date: Sun, 15 Dec 2024 19:09:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] net: dsa: felix: fix VLAN-unaware reception
Message-ID: <20241215170921.5qlundy4jzutvze7@skbuf>
References: <20241215163334.615427-1-robert.hodaszi@digi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215163334.615427-1-robert.hodaszi@digi.com>
X-ClientProxiedBy: VE1PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 2967b536-3e24-4f6c-a88b-08dd1d2b39ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vO7lPu51zZ1+3Tvwi7Fs4OW8LTGW2ncmlHNzdGb3tSW/dMpmdjghx9fQ/LiP?=
 =?us-ascii?Q?e1gmJbPYQcgl7HTPQkb3+ILhr4iBmePDXRLk3Cjipxy8Jke1prqzk+Cunq/4?=
 =?us-ascii?Q?vPMxT472Ens6nopOoqVCCZ3mj0Ewd0RQSD+C3Hmv/IiaH9GZ7v3zJd7xZz71?=
 =?us-ascii?Q?FvmkXox84rMVzM7nAtRPmbnUmf38yawo0ERMOaYWSB3hz2RKJd2F9kt0QQPl?=
 =?us-ascii?Q?zYHf9IuWXHysYYVnKDfmuwrKCDIamfASziE2ToN6eBKRfqtWKoFm4LcrNaOk?=
 =?us-ascii?Q?wm4TiLYjSutnJIht6u36R8noNbZ4MRpB9bzJX5a9ZpCWhardU2MV0qhNrpGK?=
 =?us-ascii?Q?HRo5GQaT+iMB12ptZfhq/MVJDKc9w4p/kvbF/SZYkBgf5OvJd4Xbm0U4SoCo?=
 =?us-ascii?Q?0TAtf3JArrLfMJF3jr6sfumRTHCc9GsZoikynvsKw41LIZnkm1IbicLuRn4y?=
 =?us-ascii?Q?Q/0jWyakVUhQEYF4ohX1NkEsXMdWEzeCEoQ0E7HOlK9iDOtfX7qmmLNS2688?=
 =?us-ascii?Q?2pYEG/iFjWCykoTjMgWDBdpY6wZ0WgBsYGUdN64TR31twtzohrVGd2gyb8rt?=
 =?us-ascii?Q?75yR0qSFV7YaSIAyYz4TaCzFTzi5v4bNCdUW3ihvM2iNDc5fitldbq4YJmcd?=
 =?us-ascii?Q?WN8gyMUz6PkzfTC+ESBW34KEugNfUkikgoq/u3i6VvUHE8jMGKgurvIzMBBr?=
 =?us-ascii?Q?oQwlmxBqRR5GLmsmogbRFfdE4tOdv8/JseSVIuZAwqsDCAleN5A6cve1GHs2?=
 =?us-ascii?Q?zPEiyJuySUDBBFQfXnk2VX4nB9RdFqQebDUYKUfBv0B6CBNXfa4h4f3+Cgnv?=
 =?us-ascii?Q?C1Ol+7hEoYvwnDQ1QRIvu6hiCj1pSoTqzKMtsExCONqJcYpIRg+ENWpEcz9y?=
 =?us-ascii?Q?+4sMk6+8kX1nJ8/Tg1cYUVilZCs04YgcaJDHyvggxTXpuDNZYXy14m2MyIMA?=
 =?us-ascii?Q?y+xccSwArGvIRAU43agF4Wf8GvcCWt1bA5vz8ssnQD9A852HCGdL7yVuQXhy?=
 =?us-ascii?Q?OvxDFpI+xhys0J52ooF5RHbCjOFG7wm7teqGyopmzslDFZNwzc/piZ9sexWN?=
 =?us-ascii?Q?28YPgJvolqpJNbgf1M+/w18QqAHeDLzVo1k2vI8DQeTBHr6aaX/HwzuLcPMY?=
 =?us-ascii?Q?920gAigBoi5MmdrbnHEu/MpFLdcw1popuSoXmfwxLyIhV18CEM0O2dtmx8b3?=
 =?us-ascii?Q?FxN6WR9BOG2dvzQwXQJlHKIyNdKx0P4wIMAnpVmkEWNVF8RtK2g5jazDo6cZ?=
 =?us-ascii?Q?NwvBqSFmrYrP9270/sSSPlwFwpv0eiQbvJVHf/rDoLgRRnV4vz1nvN19swyU?=
 =?us-ascii?Q?ogDeInOBFNv/+epcjkPhJUyZ7OREkwLGnGxIlGkNybB/KqMRfhAvaqB+oMwy?=
 =?us-ascii?Q?YT3a0ZmgazWjsNkbSU/yLcJ/UkDh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LU1Bxl7jjQlaUEksUxwNma+0vnOMbvazAGgT/s1IpYdyYA2Kt2kdS0GTHw2G?=
 =?us-ascii?Q?axMYDxEZQmowcOle0pkaAhgqhQ+v+1rjUQY8nkXt7H9IutPUVVHXEBogl+a6?=
 =?us-ascii?Q?fcVp3JUO8Xrz56vRwEXY+YDKdwgdOpSPm0uKFFj3UtZoraULHqr47wxn5cnt?=
 =?us-ascii?Q?aV2FoTQVF1HBnvV6a/AIEvUpUFzhHRVZE98zXgfONJVe6gKPzn9MkHFB28Ef?=
 =?us-ascii?Q?fU2h4AIIvtAlnQjbRbr+YQGgiqnWVmN7TvFvnWIuyqq9V0vvBtKyke7cUq3B?=
 =?us-ascii?Q?YLcOssN4jI57LFeZc5iYJtVB49MRIQ6BJoI04pf40RpjRaVc7F0nfFFzG7w7?=
 =?us-ascii?Q?93CqQetnR0x0xnJWOcqsgDA5RhMQlhCvWySPUd3HU4JgEZYqz5hMSqVSmX74?=
 =?us-ascii?Q?8HfgMT/Co51OX+XDTvdQyf33pKP5E+Gecriplk5fVbI57+fKqX9rfy1KzVgL?=
 =?us-ascii?Q?krHzodQLunVp7A2dWsnBZfd6RiptYS5VEcrh8tW+0fmTPcYf3Uw4LdO2z93H?=
 =?us-ascii?Q?jaGLu3iTN1P07EhMYoiyyngs7bSRpFHhrBKwBdiHTXqizEtFu1B3OxJs9ctF?=
 =?us-ascii?Q?OJKOoYlm2GzkiPhkNpbT73W0KSWpd4ubIpdp5WSphVgrBL50l4Z0YBwWncVk?=
 =?us-ascii?Q?wIl1DZhlVXP1FmqOUaNV/KChU21jdg1j1bDIJlWrnY2/nPxPSKV1MP8PZHGK?=
 =?us-ascii?Q?yz+4oxQ968cvQq65BtvJfp7hXfSSQHj0J0wTl3FWknQ2FYKZ3G5vSu39UMF5?=
 =?us-ascii?Q?UYqCnDK5jlrsNvhxP1o2/0yS/QqiyUsmJZPpl0fgN7iHkl47qonRMLmsOy0n?=
 =?us-ascii?Q?TvXCE8IApjFKd87fYHlU6l59TeJWbRVliCS3YKjviC4bkg0rBqroM33vR8Ft?=
 =?us-ascii?Q?EEkiAFsrO/IoKdFmGdUnk3XzZ6UgpswW73TkgyzZa9diAt3U3XiFR70kYmzY?=
 =?us-ascii?Q?z04oGno386Kgx8jUm4xax9I7gR2nG/R0REweE5/rEto/3x3IgWK/Slja/VzN?=
 =?us-ascii?Q?jPsWOpZl6zrPnD6tNqUw6Bt5C1g1lP4+0rOc2N3wmKaf0PVycNlDTegtVJcR?=
 =?us-ascii?Q?6MrfxdQubc9hmPw9vbWluG7itHV4DaoB++B4Xo5H8o34AQqZhnKQs4RYEvcv?=
 =?us-ascii?Q?BeLSpilDcyjC9MlTQcMki3x3fyvvpKuON0v9qXs2xrp4MK5bH63z1tzRndhw?=
 =?us-ascii?Q?2uEudG40P0rcP0GCIx9Hs5pyTxx1QXAJUEHPFCgUCp4dFK/wVTMDXCEbwS2I?=
 =?us-ascii?Q?c2NJbg6qovM5uZzIRdkHjUlktEd8aZNsyatsX+EGATI3fbGAtEhtlQ7uf/Nj?=
 =?us-ascii?Q?jlUf0rOWdt1SoYVSVodU9EIWzKZl5vVtT1WghMBNW2FD99mSnoO+8vNdClB3?=
 =?us-ascii?Q?uLxFcaCIj8T2AnnSCkJLARqo9TbqSnXnFSI/IvbfQVbo5j1O9Ms1xtEIGEeK?=
 =?us-ascii?Q?Lib08q3rlFLTS3INLw8ggnPgXB/15Sw9BYAvYElJHQFwI4DST5Ezl9W3zQXW?=
 =?us-ascii?Q?ClyCuS9wPshzXEZnf4yK9oVdsIoDQr8K+Obn6anfSUfTRr3L4yAqqkPH+iyI?=
 =?us-ascii?Q?hnK1rCgdwuPcuHKnFLlfpajHzYjydkQmhrwJLQzNadDOkX8qLs657Wa9HuGR?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2967b536-3e24-4f6c-a88b-08dd1d2b39ba
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 17:09:24.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgqMBd+qi+/YHutr1cMS6nVhpeyFIE/mcW7RYZUu4YebgPfhndbCg9BztsXTOWxjiD5I8ELLi0B7e+rdIdLZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6802

On Sun, Dec 15, 2024 at 05:33:32PM +0100, Robert Hodaszi wrote:
> Hello,
> 
> This patchset supposed to fix the currently non-working ocelot-8021q
> mode of the Felix driver if bridge is VLAN-unaware.
> 
> As can see in the commit messages, the driver enables
> 'untag_vlan_aware_bridge_pvid' to software VLAN untag all packets, but
> tagging is only enabled if VLAN-filtering is enabled
> (push_inner_tag=1).
> 
> Untagging packets from VLAN-unaware bridge ports is wrong, and corrupts
> the packets.
> 
> It was tempting to simply restore dsa_software_vlan_untag()'s checking
> as it was before:
> 
>   /* Move VLAN tag from data to hwaccel **
>   if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
>     skb = skb_vlan_untag(skb);
>     if (!skb)
>       return NULL;
>   }
> 
> And so untagging only VLAN packets, but that's not really a solution,
> VLAN-tagged packets may arrive on VLAN-unaware ports, and those would
> get untagged incorrectly.
> 
> So I added a way to mark ports as untagged when untagging is enabled,
> and return without altering the packet.

Give me an example traffic pattern, Linux configuration and corruption,
please. I spent a lot of time trying to make sure I am not introducing
regressions, and I have no idea what you are seeing that is wrong.
Please don't try to make assumptions, just let me see what you see.

