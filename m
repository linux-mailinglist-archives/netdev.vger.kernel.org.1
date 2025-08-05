Return-Path: <netdev+bounces-211676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE29B1B1D5
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF53189D40D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A9259CB2;
	Tue,  5 Aug 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BSS2KsAF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42ED1C6FE8;
	Tue,  5 Aug 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389267; cv=fail; b=bTyNH6PMGonRYtUXaClopgMWx/SFjZWqqghg2nHqYDvb34KtysjL0jPT1vhmpDRyTChS4KtO1WVegox86Ad8OAll7+Qp5kVG1tT3yTCE5i1eCXuW3rg993qgm1Uo3v+ZPc9TOwGoP2x72xOcG1Gdy6jyTTGyGSRoSlvnACPCojA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389267; c=relaxed/simple;
	bh=AUVq9s9QO7cOGzKQyT99eILQ8tjqTV2WIsn9c+C/f9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USWWQnqsF3CQidlq0HyU6suOKQwu3Jm9UJ4NfTJns0OFHM52EHVDHuxOmc6VSU2xLBa2CRH1lwDb0cXfzR6U9/gF/13xiIfYe8yjKFZgeSQWihbLqCQy3vvtyn44Yrvuc8PBBhe37VZvW8ygYGDGZtmMkgnkKASPCmOe4x50rOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BSS2KsAF; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZl3/XbNiA1GqGcyc83Gb8HpryJ2PxMrM6Bm5ZehMuVI38dIAmttIJV21C2g6vVnSPl4hlLqOe9crSFDkuMpeNekmkroyjRDU7X8uV1hgtrSf4mLvR8rZcbWuXIp+3c9S8wKuPEQPM7ZY8m80c5DlgwT3izOsRNngh7Sj9aE0+Fjw1sRGIlCl4YK6lcbHhkteN0m9xKfUGv+g36yWvHK9LB6Xox906LMQpgL0rg4lmdR14jsWazPJLj2GXsq3cfrp9BQPVMvnKQgiqiBM5UDgns1xZiy2H3GSKWz8coIh/3MMMCla3DXjiY/+Z/cwoNQoF+PgGFE9odgqvkm7yLonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMzo9UFnzOZr07YqJxahYRXxCtnI0EME1HaponcRdNs=;
 b=n7OcElUA85bONewSyItlILmPB8PUYA0ILR6obUDQ5qtKfOMOnR2rN811ypmHSOV+jz3S5oOqbHpLYMhdFiX7OXhKSEVh3ow7yAl7ivBjoMpQxPeN4aW/v5PnsGJE7lLOXwOteF+XSeQSkH1mY9EMeDKNbh3Qy1uX8YG8YAiAfEvXgUexEzhDsd6MZ3Lx/XX1bw0Wecd8qS+OlqOjLFwPTNzqIfiQ+ps/96VvNdPoSrj74Lhsdx/EYD6QY4I3Je4Q718kjRE2n0x3fowQxd6L0iTHCfvdmoko40X5hY7zARl5LnBzGTkUrA3qi51FFAiPBTB5LgURsJaiZsZlQdtQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMzo9UFnzOZr07YqJxahYRXxCtnI0EME1HaponcRdNs=;
 b=BSS2KsAFxcfiAzU3Dg9z1M1FMa9N5v7WlglxTqhOxfOPo4TIzj1NGWnLOSsgX5wegJHjPNTz6+yNIBSXVVDAWDAPfErmT+CtYBLevR5RSc/YjGQedQMTDNFmYh6zG2SWZ3EVRyVfSzEgBDI3kpINbarD8QePoLCixC92jWcvvg7hOVjqFTBesYK3kXPVbX2iLN9z8JTXAv97te8NsT3/5Gb2x0hX+uJS5AnqHwdH+VdUcSeAoAG5lMUcmNI7C7YM0mLzTVaSkubsgfga2ba5ffDgowvYEyB2uFomHsZ7ndDvfgRAPQRkfxpBHTJeCDYF0KhvT/9NxANz5VzS7TEayw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 10:21:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 10:21:00 +0000
Date: Tue, 5 Aug 2025 13:20:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
Content-Type: multipart/mixed; boundary="x7cxeh2vlmult2i4"
Content-Disposition: inline
In-Reply-To: <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR09CA0163.eurprd09.prod.outlook.com
 (2603:10a6:800:120::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: d9844ca2-7a6d-4d04-35a8-08ddd409c62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|10070799003|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmaNAkAV397VhtBU47ePkhN3ec3xpfRYwaVmzLBrmV8C8xHWpzPJRzU0oHN3?=
 =?us-ascii?Q?jTeKsBDMaMpOsFjgavi6VrnrXRb+HkR/dd9VrZeQkKKfDuwFFsM/TgXUH2L9?=
 =?us-ascii?Q?J2zOwzln0qJj5KocoYjGKMZkvDbCUHJG/rb9VhiLxiMcB7EKNWtpJDNglJTU?=
 =?us-ascii?Q?d31Zaj3h5mOQaVk8aKZKcvgQmEINoFwBRY1hrSpC76/RoDTikqn8VsIdduJz?=
 =?us-ascii?Q?86i9NyUJuC/4dApQ/Diry2u44Aywm/6/SMNu0/pz/PJ4V9LNAmi6yGNSvUEe?=
 =?us-ascii?Q?u73BN8ue+7RUJthuvEs371TfX+C6UMEblj0eKRcYGLafRRLsQVP6mboJ4eMK?=
 =?us-ascii?Q?L5vGJtkv6485hgYf1jMTsG0ZOhLQzugdeXzGENrIYzXKaq9VDnYiHvHu9dE6?=
 =?us-ascii?Q?KuqGBLZ7lGIgElnHVNjIOnH8iuwGYIR4OSnIdoxVWF5Ls6PvRL5ufSYfeJ5I?=
 =?us-ascii?Q?ry1C2LRThJWumzA69v0BZKhTjgJkAjKIipIij/G0XIUIC+LT0ric34qi20UX?=
 =?us-ascii?Q?6kc7+SFP9ohnmyXAMN/904hjgql0+SVJgNs5jr6dI9mmzpoJBcAUDZWlyn2+?=
 =?us-ascii?Q?RAHjEsdjUscpDINX4REKyQdDxoqKVo2bTq3lpp19LnsAaRqHP5LhJJl+IySR?=
 =?us-ascii?Q?wjmIb+01TPqn35efFfvoNgGKlFieSVnKwZcuF8GMh76iQnq5KJ4LHGJRCeAD?=
 =?us-ascii?Q?Vy3t2s2SyjLCfB+xwYw3ruYVyZNlgTk0O+9fvjwjADFKxNFtiuzI8/fBQyJE?=
 =?us-ascii?Q?PD05k4cgsYetdGKyZziJcwoRBRG38bE/MZMHLw2s+qebWOftsZokmNNcUZIK?=
 =?us-ascii?Q?BAAkIsHgyShvWpXSbyPwt9wXU+REg1SvOrXvXV/zt5x+ww6rZ/nCZ1ZbWVrZ?=
 =?us-ascii?Q?zNuXvSmmNlBmUYPzgrXtrYosCs7J3kWATjleYS7wqbW2YEW8LAD3QBCY9YMa?=
 =?us-ascii?Q?gKUCVDgXXHOw5R0p7G8kOlBa+aKhD2yYjHTmS0o1EE6q4lyaEQ8T+jgCl78z?=
 =?us-ascii?Q?81erOn1tPwBsXlASvwRKep424iKFOTFRYgmMjlzJyYHMFYLj56Etn0pUCbVY?=
 =?us-ascii?Q?eJJziaz8nJ5WLg1LhcixJuCn5X0GB9RMhH90jagkfRmO41F5k3KHDPkLqBCx?=
 =?us-ascii?Q?EJ8hn1KzNIu52QlbDOG9qyUa2IwQZIdKgnYhxIPBbpR6FD/BEPksBTBt9xJZ?=
 =?us-ascii?Q?b7jGg0ET7y4moEj+9xykJ5olVl1UPokdyNPVGKAGNL5HDMzb/CIqdJ6qTwaM?=
 =?us-ascii?Q?OGo2S+2oEYYYOPqbj5BtdVLHQ3zSnkkySmSjdb7S0SiIwPxJX/Xw+xqxHuq7?=
 =?us-ascii?Q?VWHMtB+HtJbgZpQKLNZ6Mn9QSmJQNvK5CdctX4hS5qO2QXvxmxdJyKQOm+iL?=
 =?us-ascii?Q?ZeIxhKZVpS7JOVel29tyxHYE6wCAPnYPdcMWzU1Or/d+y1Je75iJ1xcnbcm/?=
 =?us-ascii?Q?mPc0I10UgWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(10070799003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqYK1+ot4u/ove4UQKxoWtLnG/PQtFFrWdU//lwpq5A5ANiiQtrqjBgTZXUq?=
 =?us-ascii?Q?eka5PhKBQPAoqqgVRjR8SpUVJxi0z8AsxcaQes8BwptczWY39z+JCmx3vgJq?=
 =?us-ascii?Q?zyjEDXHWwldm0AV9m+7ENxXFfhQxvr+RGbtUcIyQRJklihlRvAYuu+wcz9Vk?=
 =?us-ascii?Q?zNzzKj117p+7qKY7HB3I6z415MJnfqqxlcN4r7HMF0shks2i3RuzE2spFaqP?=
 =?us-ascii?Q?AaT+6yM9LBDch7wgr8E7dCD79mMhDsj9Rh6v4V1Gqbayizi/k1OanGuDxbOr?=
 =?us-ascii?Q?n+yxrsbL3cQ0fguO6+88RBrjseieAw5/xOBPLKhoPgeAFnjkKGldA5SV99yZ?=
 =?us-ascii?Q?zv31q7wttoUBnAYAVAnAllbq/2AK9reENGGIZZbf+A6jZ5s7g/WBxtLZ5izh?=
 =?us-ascii?Q?4PjvEYcUUNLZJKUSxfE2IULuaHLOY3suH+hDVWa/cclApMcoNy3YykkZh0KM?=
 =?us-ascii?Q?RK7yd7J8SNyc8McsBLkS8del/y2bDtoVDxeeM+peYfCeCgZElH6iqunMM6c1?=
 =?us-ascii?Q?q7m8+g0e+SlIZknscUU1srPQdyaoe4Zu7l74m+VCj2OvsPLarxBPUL0j9/Bn?=
 =?us-ascii?Q?COwvVKbwFLlOVFTBfyiW8KR6apLWvi23mVzGi4W+MDk7Z8ZDlAo46pfGaMZv?=
 =?us-ascii?Q?bJDw1VaGbdgk2OSg88QPf73fUogXmsV8kzguZF09d9z9Mbf1bzIjHq5YpwBD?=
 =?us-ascii?Q?7S72j03kybJdZ2zoqhMv8pJLUgq9rtG6dE1l4ZQaDoFLzfH+rOje6dNeK1VG?=
 =?us-ascii?Q?ceZJawIvdsegHDmupVBxdhxD1hmbQPZJXqfsYqundzJFlEiXclVstg56XJq4?=
 =?us-ascii?Q?BS76PBheS1ZEGr6sMskgpoBc5kPwxujfVG5Cwr57HZQBvw0Z4vEkG6rfPNGz?=
 =?us-ascii?Q?BuosSw9oGVlLnBkZNRysVXKJ0hHHyP4EXDrVbYlTqHKeZ9mdZljXKMZoaQpu?=
 =?us-ascii?Q?4sDFBdrvn6XDtobWew1KU0K1e3bzja+S3jJRIaW6xuY6qm2N/k4dEmYnFuUo?=
 =?us-ascii?Q?oLH5HFooNdsCZzj+SUkv2/d0c9W4QD0/DDzxkgaTZD2l2InJisk//0TPjVX9?=
 =?us-ascii?Q?4Vj5qBgd6cNGc8Yn2Nl+Mn4e53K5r8CmYhWHEP1Ytnydk1O7L+lUd2rJDIWb?=
 =?us-ascii?Q?nt2gQ9T3Yf+9H2CbwjLL8mUhEWPDAmVWFmfXOCCLbmWinZi9uqER80g9nt7N?=
 =?us-ascii?Q?7tbj1PapECsXcx4053zkJK+nYFanqU0qTYEVSC1np/ezX5i9qQ/GVQWF/1y1?=
 =?us-ascii?Q?E9hBp1wxaz1+VxIp/6NAwa4uk6U+6Cr+8hJNqNitthotdgjUjTfV5GIBFHHK?=
 =?us-ascii?Q?0BxEV5YHMVD4u1mQSFS4ZY9IcELo8wmg76W3IOAoalV8d2BAvvkMpzKa7ATe?=
 =?us-ascii?Q?GEV+YNc4FZnZ5Uv6opw2+JgwyKjgn4RitIvqZqx+9XLOS4gQEY95EyKXZbuY?=
 =?us-ascii?Q?7m/vwVLW4HO00KhnvMRCgkoos4eSkxXWtrYJxVCIPjrCtaRDaaZs5kXm+tSS?=
 =?us-ascii?Q?MHr53C/K9EEGJ9KOVkztI+Lr4Gh4xfoYzwK2WN8VGjOj5YFqWW2llWcdzxVs?=
 =?us-ascii?Q?Lk1qKVZR/JS8VCAeGM48YCkDds0MoodlJxYDsIoWMyzuDL59gRWc6UfOcrKk?=
 =?us-ascii?Q?wVWOKD+TgCUFmzbMituR4yhyapuCdkv8X/HAxcRxUvG84ZEoOdJGNp4JBQyG?=
 =?us-ascii?Q?sT87Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9844ca2-7a6d-4d04-35a8-08ddd409c62e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:21:00.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v4gT6bM+iAMNgZM5GaNImMYoqO+diF5XZNfDn3TDp4r6OLkiUEGMb7qBlSmeZ8obw2PCXLzqAxn4teswQbavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545

--x7cxeh2vlmult2i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 05, 2025 at 09:59:57AM +0200, Alexander Wilhelm wrote:
> I have a ping running in the background and can observe that MAC frames and
> TX-RMON packets are continuously increasing. However, the PHY statistics remain
> unchanged. I suspect the current SGMII frames originate from U-Boot, as I load
> the firmware image via `netboot`. These statistics were recorded at 2.5G speed,
> but the same behavior is also visible at 1G.
> 
> Do you think the issue still lies within the MAC driver, or could it be related
> to the Aquantia driver or firmware?

So the claim is that in U-Boot, the exact same link with the exact same
PHY firmware works, right? Yet in Linux, MAC transmit counters increase,
but nothing comes across on the PHY side of the MII link? What about
packets sent from the link partner (the remote board connected to the PHY)?
Do packets sent from that board result in an increase of PHY counters,
and MAC RX counters?

For sure this is the correct port ("ffe4e6000.ethernet" corresponds to fm1-mac4,
port name in U-Boot would be "FM1@DTSEC4")? What SoC is this on? T1 something?
What SRDS_PRTCL_S1 value is in the RCW? I'd like to trace back the steps
in order to establish that the link works at 2.5G with autoneg disabled
on both ends. It seems to me there is either a lack of connectivity
between the MAC used in Linux and the PHY, or a protocol mismatch.

Could you please also apply this PHY debugging patch and let us know
what the Global System Configuration registers contain after the
firmware applies the provisioning?

--x7cxeh2vlmult2i4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phy-aquantia-dump-Global-System-Configuration-re.patch"

From 17b74539f4f1fe2c335505443d797a9e2ae1fab8 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 5 Aug 2025 12:54:01 +0300
Subject: [PATCH] net: phy: aquantia: dump Global System Configuration
 registers

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia.h      |  5 +++++
 drivers/net/phy/aquantia/aquantia_main.c | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 0c78bfabace5..9d02f9f0b8b7 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -55,10 +55,15 @@
 #define VEND1_GLOBAL_CFG_SERDES_MODE_SGMII	3
 #define VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII	4
 #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G	6
+#define VEND1_GLOBAL_CFG_AUTONEG_ENA		BIT(3)
+#define VEND1_GLOBAL_CFG_TRAINING_ENA		BIT(4)
+#define VEND1_GLOBAL_CFG_RESET_ON_TRANSITION	BIT(5)
+#define VEND1_GLOBAL_CFG_SERDES_SILENCE		BIT(6)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE	2
+#define VEND1_GLOBAL_CFG_MACSEC_ENABLE		BIT(9)
 
 /* Vendor specific 1, MDIO_MMD_VEND2 */
 #define VEND1_GLOBAL_CONTROL2			0xc001
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 77a48635d7bf..72329e328f27 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -987,6 +987,15 @@ static const u16 aqr_global_cfg_regs[] = {
 	VEND1_GLOBAL_CFG_10G
 };
 
+static const int aqr_global_cfg_speeds[] = {
+	SPEED_10,
+	SPEED_100,
+	SPEED_1000,
+	SPEED_2500,
+	SPEED_5000,
+	SPEED_10000,
+};
+
 static int aqr107_fill_interface_modes(struct phy_device *phydev)
 {
 	unsigned long *possible = phydev->possible_interfaces;
@@ -1007,6 +1016,15 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 		serdes_mode = FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val);
 		rate_adapt = FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val);
 
+		phydev_info(phydev, "Speed %d SerDes mode %d autoneg %d training %d reset on transition %d silence %d rate adapt %d macsec %d\n",
+			    aqr_global_cfg_speeds[i], serdes_mode,
+			    !!(val & VEND1_GLOBAL_CFG_AUTONEG_ENA),
+			    !!(val & VEND1_GLOBAL_CFG_TRAINING_ENA),
+			    !!(val & VEND1_GLOBAL_CFG_RESET_ON_TRANSITION),
+			    !!(val & VEND1_GLOBAL_CFG_SERDES_SILENCE),
+			    rate_adapt,
+			    !!(val & VEND1_GLOBAL_CFG_MACSEC_ENABLE));
+
 		switch (serdes_mode) {
 		case VEND1_GLOBAL_CFG_SERDES_MODE_XFI:
 			if (rate_adapt == VEND1_GLOBAL_CFG_RATE_ADAPT_USX)
-- 
2.43.0


--x7cxeh2vlmult2i4--

