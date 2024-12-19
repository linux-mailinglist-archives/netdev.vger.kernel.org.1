Return-Path: <netdev+bounces-153405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AC9F7DAE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496EC1893A09
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7C22616A;
	Thu, 19 Dec 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aY+0b2k3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2084.outbound.protection.outlook.com [40.107.103.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96822616C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620871; cv=fail; b=tU9TGE+9ISfBfZjL4XM765+X54xStokMHAfa5iiAO3S3mCAh7AJUocCnxa/AJTnkUGUyZZnLYNF5dHQfkZfoo+1a44HX1LixMe2X1Tb5HEzg7wRsJ7S2hGc7LiXpDEvxj2Q+u/TrAATNsFwLS8DDKYMFhGnYJpW8/Xq+aUz/elM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620871; c=relaxed/simple;
	bh=eB7TveDip9BKygsOMgv4an36P98gWH6MRPNEwSPJkpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sIPI6tOF627x3D2senw0jcp3T4Md50dzI3F0B0Cc2id3ClOxQIDMnJiZL6slwA/XZVWRXEiGq4hp4OfUMejTCl7jGmnfyVWsyBspYoYXRZVXDh8fdeDx5Czv+z8pe9P/97S5TzT+cIgjiKLUY17bJa/Ivzc7C/D+9VBfBEW+XSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aY+0b2k3; arc=fail smtp.client-ip=40.107.103.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHfjKZOzuDTsCjhjPfoWQl2aZVrdlSvh4uqvmsQ9wKHsIO4yteOFle18m0Cs9e+5pd4/h9i5XT49RRf/hZkOYzBDSieXVimLswzHPQkWmHq4YnBB1stz/zf4PYSXziiAqugmQlYgeFkm3GH85zAHd6mAOOldHQpLZgaGhsMGKzTrNqoxekqqGNcOORACmVp+sh+gM5hbLOAm0AywtoFkY+bo4XY/mlb0/4TuHzrjOBMC/Wr7h6TekoHvRuoEnnbwiiPrCfZRQteejsMwjilC38G86cSDShvLQ4qeGsq5RCQ2OYdNgSd0HnMz8yQzWjVgOJP8KZc80zcf6HE+WAhxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRpRVMFUR4fW7scP06bdaKKR0sslSRYfoxqRmh0A2BI=;
 b=wYlaHLM2Y3350laNZz+ZtH5IK+2AtCf8gQ/S65X0PT23ByL8RoRs+5nv281C1eAwKZneYdX9AKtZ+vWxU5b3ym1bCgxABef/91SrOuQMwwecXsN62V6mra9Z68HEA61aYujBy+VSCuXX0lYurMLd+w2WlSN5yTfw/mNeOsMWb+edKfC05Wee4S91VlPd4TQx0zd7YfqAeC1edoEhYKhKWoLcedjzLGG3nXxjOsmtjrstPaK/NYaUL0/DjPW5IOJ/q4o7AATuLWPrhEPUu8FtTQX4BJOnEP4wYRljWgYnmY8sCNguwat3fpEutrKcbIYnxqkBw77bj+ZnDaZdA1qV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRpRVMFUR4fW7scP06bdaKKR0sslSRYfoxqRmh0A2BI=;
 b=aY+0b2k35F8A9RmfUv3cf9f6rwxpUwLtFSUuK8duCq3MvVXqYA/RmAHI1d1DoLb48oKFQUJSt1gBXGigczBQc4AeKfDvgglIVHOVxH3VbTluaxsy3odE82JQ2mh7M6J2PLFWRLnYjLsMCGCaJiUo3RntaVHJCv6b8kJcx10eplxncebG/VW4kAkVm7tzW0F76RxF6gvhD1QojM95BWK6NuPVZlOfDF4NF+P8Pe1EnX0JIhgOErpmzgxhEcmlg3IQylcjbp3XLKiFUPlaWOqDy+IrSd5H+NhAvGaxPcEN3I+ruJ0hGIZGbFPT2IYniE6TaJvDudfGNsFQFVPq9MsfgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 15:07:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:07:46 +0000
Date: Thu, 19 Dec 2024 17:07:43 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: robert.hodaszi@digi.com
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: dsa: restore dsa_software_vlan_untag() ability
 to operate on VLAN-untagged traffic
Message-ID: <20241219150743.rhw2nv3fysplysrf@skbuf>
References: <20241216135059.1258266-1-vladimir.oltean@nxp.com>
 <173457903151.1807897.16925032481407031771.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173457903151.1807897.16925032481407031771.git-patchwork-notify@kernel.org>
X-ClientProxiedBy: VI1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:803:14::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 744b4d08-078a-4147-cd56-08dd203ee532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/5PcvH+vhWre12zboyBrdRnofUBcMremMCTaYzQa6JEUgaTwUI5vXavXZwV?=
 =?us-ascii?Q?hdKAd1S6xAXvBywxazF0KAUJCF6sv1w4ZBAQvAZe6DVw7aJKMfOlySZzp6m2?=
 =?us-ascii?Q?B/NEKd8XHBVSC6Z+M7r4e7mUA8hQBTs9f6XvzATpvzMt/tKKvDJOt1i0LIG8?=
 =?us-ascii?Q?9yTeOo3VF2icN6ecLo21w+nK1N+Q4DAkt5yC6D/0gW/Wpb1XnqhrUjXkwwmA?=
 =?us-ascii?Q?DlikGrhsEyqy60U+C5ru52V04mFSAqKhbgF9LhONblgF6KUTQ+W9eTEWK064?=
 =?us-ascii?Q?MDTmSsgVMo1WBEROQp477uWBvuZ/mVQc7l5rcDNiikdhYVkC3yl1v1rY0zRa?=
 =?us-ascii?Q?QWm4dp1vS6nH2sI1O74uisIz70p1ea/Eh5K2OioS1OqYqRnTUgwjrFdqyh6v?=
 =?us-ascii?Q?L2BX6DGkCn3mc27pIYlB11F3wj5efkZfq+Ln7oFhEdVlZ1Jd42VOiJyzrKha?=
 =?us-ascii?Q?FMpsomkRs2WPLMQlNQt8CPrh1xJZM7sMTL/kec7afjHnqJvTc4YU+0YIhidm?=
 =?us-ascii?Q?pPqFUK9ieuyTiGogp+NqKvdcly2q0mtX6dT7FFKjUUGz/PRnScWDZUgZ2SMn?=
 =?us-ascii?Q?U9sTP8I4mktaZ9d5VMECRwz5LTKaj0v+4plHe2a8UTfe5SnahMF+HF8pvZwL?=
 =?us-ascii?Q?7PtV2h1nbxNDJUu3inKw606Gsjbgtp6rAeGrX7sO6eex2jMU+u3AM4GhHOwL?=
 =?us-ascii?Q?JulLT5Xon4jgQ2LkrTIHcmXkk9eyp6HcDDBjs9RCGyxjd1crUa5pz2689bCg?=
 =?us-ascii?Q?pDvtVl45P6jlZMykngrGXOZUM+XkfNYPpHv88ghHjbL4Vp1i6gkOqdBhyoMb?=
 =?us-ascii?Q?hYRP+KlWQQrQ7a7XB/zB7j3qoeLfEHuH5UNglGAQifco6g8AlSqgTQ9rcqF6?=
 =?us-ascii?Q?ScYkj3IL8JJtoToxhI30t71SzfzDYc6bpdhEru+IPg3ETMJY1yG6vdZRJjK8?=
 =?us-ascii?Q?PJA+yN7qWZZJ6YimU9tUBne26vlGsI8X3W4tyhY195r/FomlRW8tZGRjgQAt?=
 =?us-ascii?Q?RBaqL3Znh8uPPbiUEr9c4062Zsb9banRCan7aI9YeniMa/XT+0nN98kKc/q2?=
 =?us-ascii?Q?wblwRxau6dGrCPOTjbQzCrxvf/XVO2kWMFNEZo53jD1Gg1NNRUXTKIytdVM+?=
 =?us-ascii?Q?sVMus/Za//IQ1CRQuATGo5+IS4cGefJtAQ2LzKVvAHO4/Jqt+sz9qnnQ50OR?=
 =?us-ascii?Q?7shYJ2eu3HQaE1LzIi8iyZMZUqJuIB1RIgctGamBUaB9VoFRfRwF5ORNr//j?=
 =?us-ascii?Q?64+CKQjSIN22dV8nAvoqo/2BsLRnhr210b6zA7W8FeFl7GLwctG3IX5Tw+xK?=
 =?us-ascii?Q?TTJLa9Dz+2gyBcqTxo4VT2jhRaihuD9/hCHLxkwyP6YfeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbeEjBB6bxU+FOF1sgpQxHdMmRCP9EDeTMtUrEjedkToui2KB3qFvM0SN254?=
 =?us-ascii?Q?y7gIxMfIJBWBbUJy7S3zN9Mh5U+p2Zw4X0KiHD67aYYy3gUpuH8qH4a0flv/?=
 =?us-ascii?Q?oVDkv5mujJvWtqgQ0xO+7HgAcHFnANL5IAcjT9t6fZD3+vZ81zd2/pUk6Urq?=
 =?us-ascii?Q?3VXlOrMf7/XxSSrfxyl/CexR7IKuzkyP3jxNkjJp29k0SxNPUzpiotI2J35M?=
 =?us-ascii?Q?Fi8r8eAYrvGFfS9BpetgIRDPmxmL0h+8DtCDkv3CmIdyXZfgNF5KC3Ck2/rf?=
 =?us-ascii?Q?uyHtvh1fEbYoxRANRyHw54JAFemz3cxEMIJoexbfIWtdVeNuUW+tZHFoYKNS?=
 =?us-ascii?Q?fPkT5RFqKdgs+TjwamlQw+YPe+LAKleVIMol4p4Uorj8Np85CT10WQfZwf2n?=
 =?us-ascii?Q?+eYCQZR6UOr52dhXO4X7OS+z2lsJ6QrpT9Y7AmbAnKl78ojma36xDR2ngaIG?=
 =?us-ascii?Q?PPA3sFFGrdMPXwNvoaisxbVpPbFdA5rZTjQ6vr8YU6pu/IRiMdsOQFajf9KY?=
 =?us-ascii?Q?rP8m8eWOceLjPt41I/jZroGfZSP7KJ6cEPP8KVU2vsI4bDNhpAm27w7tuajH?=
 =?us-ascii?Q?HviV2qY217neKqauLA8RWfRa9cI6BZ+hQYeRkHYyoDH1utxy53LF/+tuFxf8?=
 =?us-ascii?Q?s/2TPIegNfqxGTkqd6AUQKkoI8oO7uNibByjF/3ocnpTWOT7jYa+2qVMRQXH?=
 =?us-ascii?Q?jpW/raA1T4MP88oT1ZTnCUvwUROtzQdR4I2qlgK2WZdP3K7GcgKefvEV73xT?=
 =?us-ascii?Q?I9uR5QqQnijCUFccNxmg6lsEnl66c5F6+CF94PGEXg4BOryKu0dr/Ev6/iI8?=
 =?us-ascii?Q?QNk5/k4ml48O1/+51nEhJUNReY/+V99GY2riJfcPWIOlkmDCQDX4lhOXfE64?=
 =?us-ascii?Q?Vae8E1DY/UZOPOnsjNs1TO2NcAele5U7CFGt9+ztzUjLwVHXRf+eQjfXDDmO?=
 =?us-ascii?Q?J8cu4ZaS5XP35RZrXxgMvc5DFZrOjxo2Xfo0hU1KzmKpqcPOUN829zhz60UV?=
 =?us-ascii?Q?QIPWWpn5DemvA0oPn6hG9IOHyhONsfDDUuQPG37m8grNVOM5KZV8UNyiTNiu?=
 =?us-ascii?Q?PPf1LDlMpyFJrmGOdSbV2DSQV97lx4cTmvrYiKNkId9TjbHvt120Z8RbGTMR?=
 =?us-ascii?Q?Olx2w5fiX4S3PVBQKXCGfOKA5ozxTf9bdpVnxtMgvWFtGb50As8sjFF0vNi9?=
 =?us-ascii?Q?YM7pPGUtLUkA2MVkIvTiMG91vGuP9Yd6o14yZIApxaD1eqTojqqP7iA77wsH?=
 =?us-ascii?Q?WKz3hVuV9BMUGbmLDw7KF7ypEfoy/u9Dqp65Z8Xv8KbMSPHeG9iL0ADsvH01?=
 =?us-ascii?Q?BdBKJOr0LaHG6fKoa6hngH+m+VYh0nKsiSaMRk7ORyS6qsXCf66InPZdlB4G?=
 =?us-ascii?Q?5BC8GoM7qWm33rCux38kvpaCYYj+0ChLBAVfsnyvUEXpNdiGLQdbbssA1y2s?=
 =?us-ascii?Q?NvnTtWVVA5zFSR6+tjbbf/i4qpeZ9mP74BvGjFFCCSnu53oFSHR7UBrVVyY8?=
 =?us-ascii?Q?vwgw5OPkYYQWPb4PxT9MqgcLouKskqGeywVhc/tFpIGSKPBZEgTN3TrruYaL?=
 =?us-ascii?Q?6wf/Zxuy++fsD12a2K63E6d3osLq7N2Veo8cY8PLzH/afyjr5S2gBKoi+Cys?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744b4d08-078a-4147-cd56-08dd203ee532
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:07:46.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB9EOJ1pailb3LFLvqM0BepCjL3Ya0d1nUZnkm+TeDRALCZHWUycI/xJsNTse2yl8/Mb6ISB//7o3cSguxcwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539

On Thu, Dec 19, 2024 at 03:30:31AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 16 Dec 2024 15:50:59 +0200 you wrote:
> > Robert Hodaszi reports that locally terminated traffic towards
> > VLAN-unaware bridge ports is broken with ocelot-8021q. He is describing
> > the same symptoms as for commit 1f9fc48fd302 ("net: dsa: sja1105: fix
> > reception from VLAN-unaware bridges").
> > 
> > For context, the set merged as "VLAN fixes for Ocelot driver":
> > https://lore.kernel.org/netdev/20240815000707.2006121-1-vladimir.oltean@nxp.com/
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net] net: dsa: restore dsa_software_vlan_untag() ability to operate on VLAN-untagged traffic
>     https://git.kernel.org/netdev/net/c/16f027cd40ee
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
>

This is on me, sorry. I should have marked this patch as "changes requested",
(https://lore.kernel.org/netdev/49d10bde-6257-4cc0-abaf-3bffb3a812c0@digi.com/)
but I had other urgent priorities. I will send the requested removal of
the duplicate br_vlan_get_proto() calls in net-next once the main branch
gets reintegrated into it.

To Robert, and not meant as an accusation at all, because I could have
done something about it too, earlier: when you have comments for an
already-posted patch, please make them _on that patch_ and not somewhere else.

