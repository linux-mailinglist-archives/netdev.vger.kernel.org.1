Return-Path: <netdev+bounces-185976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A47A9C7F4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E899E173F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EA248879;
	Fri, 25 Apr 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PzPxjuz9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746E23D2BA;
	Fri, 25 Apr 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581354; cv=fail; b=JcpcLwWOZ5xWT53QLpRrFvTIAvwSujFC2wikRBFkOFv5bwmTUFaIaIMZEuHsCCj0SaQB2AXWbmATRmG8vMWuFFGU1pmbC7v9uo4N6YVzh8vDJFS5vp6kNwXh7FSSeWHEiqUmw6xz0C0QvzDFnigFdaQDlRcTaXP486QVgaMG39I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581354; c=relaxed/simple;
	bh=RlPX2ffyeOMULC9CtOlX0nWOfjjbxwoQzwwd4v+tY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLPBhv2xG7h41zX6t1jaSEIAuvqrhlCwyvfnBuGdSZQ6QsbCgWrZppKZH8Eup7P+Wlix2OBDFTXmJpLl5NTKVDIWo+B84B0fxQO82ryJA4WEst5Bs88qel8i9r1d8Dg/+v6d5JQtvbUYNkYZbnYSIKyb/WGlr9Lq5YKCnFFYqXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PzPxjuz9; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQSidmQ9i5OH+c5qD+S8SBjun9jgy9PdEbZIyjbNL6n4ogDlrvN/LVcYpZvIgLdY9XJIoQsd1NbrkDR/p4SwagfwtbHpTvpSROZPg9ygyWYKoCX3LJ2knSLZPL3eS0cUWvDV2Ix+mj6TUs7u5C7k1+MbBI4vA9vetJTYlZE3uuxHA6u8mtejhORqDx1438QvRNhtjHqoDTPj7WfLTIyDrsNUAei6xGKXGdlFR2aNpaWXgyhMlawQGFZhbfbm69c9W7mDYnTQwLeXyknJ3TYBM0YCnsqML+VRL+VZZmheWcvRssyiJU0D1HnNSOf8LxWS8AmOz3iO0KoFOHmuV35Vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6TdBJ7ZbVjkBR9F+baGqUhnQ48pWZ1dblzJOGYeqAw=;
 b=XKgRMFyx6uM/w/18ivKJt4fESXLhsU9j7CoAkuWW2gDsgFmVae4J/b8ls13XwN34pFn4WCWrN7Rio2wVDv/yYNjQFWSZeNqmWyaYZUmZKntfTj0DP03uibY/ARtUZqAKWyNy9hvNBDmvmi/78pPCXes812JIQDNLjBH4pgEo2W0zmILMn6UQGb3bfoHzJrclDcXCznJ1G+ly5HiNyTrVDbRTyo8r9MgLCB/llfm0Sts1mH2SZGMt/JGRAOO5PZbYIC9De3yKW2Med2BGnarxFYsmIbWb3GfgNthKpuLN4jM13VkQoECzhmvT70Fkg/nK/oPab/ungBLER7QAOgXEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6TdBJ7ZbVjkBR9F+baGqUhnQ48pWZ1dblzJOGYeqAw=;
 b=PzPxjuz9KSl71hw84pdsIUS1qC3X7cClsqoQNFfmN4Ca6dbXrP3XcsycguuN7qPpY3nYRZeRgLY1YWofrHoolgSxaob76VyOx3w8wo60yLYjH34NX7Zw19C1ctoDtK0sQt+dSxJlHGhxlnrN2YhBC8Z8tVEOwMo8mSH315m0h6HaqFwFsLk8ijP/q2KCzYl9gHkKMCdgwURRnuX8BddQbNl3Y4H00Tc/ByGRsYNL34Tpt8srhNCrimZdnoBGe1br1CzXeQci5ODDgAMpm6J306YSZ85Wy1Xq0ue2Ycf7xxAZZdD4ErZyBUAqmLDv51peL9vb47eAmeAWMMmgfqM8lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10686.eurprd04.prod.outlook.com (2603:10a6:800:25d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 11:42:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:42:28 +0000
Date: Fri, 25 Apr 2025 14:42:25 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
Message-ID: <20250425114225.w24quv7gnp5vlcyd@skbuf>
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf>
 <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
 <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com>
 <20250424225738.7xr36vll3vg4irzf@skbuf>
 <CAOiHx=m0nkxczOHQycCjsXcRvs-eP+wGgrUDDuB5UpSnMBSLkw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=m0nkxczOHQycCjsXcRvs-eP+wGgrUDDuB5UpSnMBSLkw@mail.gmail.com>
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10686:EE_
X-MS-Office365-Filtering-Correlation-Id: 685649dc-0800-40f6-5905-08dd83ee4196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XhZIkyT88J3Bpjxk5lYX579xy3rvEWDFHX2w+xWudZPobwjOpGMTy2JRNewZ?=
 =?us-ascii?Q?1SWtpYrADxM1rQn0mVFOMNIVrpbuNKmw68KcF0ez3/+b3VxBsl+jbuVWOvw9?=
 =?us-ascii?Q?vswvtgg2ZeAXreA1c+khYEZEPHkeYoeER7qiUNh/lY+1XNo2R9n2JvXNZ69P?=
 =?us-ascii?Q?EW5PpVnsaI39hu2yHzWMRoot88GQfdUvm/NiD9ap43LjSrY4wDi2qzty/3Ja?=
 =?us-ascii?Q?ta/SNecnkfz2z2u9Xp/Z67P4Znq61aUwzR3csuAvqHkGvoHiskzt+izXQ5TG?=
 =?us-ascii?Q?IXtuDF/4ckYGtuhifZGA2AhbbT0Vjp0fJTga6yUV0XQDRMZkPU6m2HKaTHKO?=
 =?us-ascii?Q?crf3VkTxLp2QCIqfgW3AD4K4M/FplI1is+0f37tz1sUoOYzafsrxCTs4ZC7i?=
 =?us-ascii?Q?s3JK9mYTnE2J7bb5eS+wrW2n9vYYtmT9V6/ejyROjPgo2SHitFpYDoYrn7bq?=
 =?us-ascii?Q?t4ns+EpT+RsNX9IyzmUAn1mPDJruPnLPoE9sdKwp0yVehxv36//IBKjkM6LC?=
 =?us-ascii?Q?EcqQ8SQb2l57PdQRcqJfqCza+9uVEKzlu8XsW4SuRlOYUaC1swZ26Peq9xnr?=
 =?us-ascii?Q?B7d1E0P7kzmM1NZIVMTMUhFouR1FNfvCKYmC9m67RRSBoCTCf5DuplexLxH0?=
 =?us-ascii?Q?6DHPxL3gD/eh+sUNSqZsSmUolkhNvaL7uc3L6C8A7Hs4LIZ11SPLJq9MXzpx?=
 =?us-ascii?Q?r/Jd8Ma5mUdzLCbqk+3We5J+i/mK16s4oCd+iW7HPDr/62nqI/1laJag0Zpg?=
 =?us-ascii?Q?XiWd9RxAQXyx6uBAuCptb0ELBkSZDKdy1lfk9N4tho1ukTHqapXE4+BDnAwF?=
 =?us-ascii?Q?2ucD1zgy12LJUwvPQmIl4TICky1oYMNRwGOW5s+ftAo3pw9QKoimI/ytnuAJ?=
 =?us-ascii?Q?6QHSiRrlJx1uGI+88/QRBKoBxP4kNBDGTA1E/hDbzvS6dfKHh3LhkvxdWxtd?=
 =?us-ascii?Q?rj8seE89culeLiKJe+HOQ0ploGUt7dv/8Fq9xOXltKGokLeFJxH7Ul/lpcsi?=
 =?us-ascii?Q?kZMOqyiBIjHTW1tiTb77eKFXZnhgPMiKmsbflGdRdqemy1HHcseIvI+l0tGt?=
 =?us-ascii?Q?djCxTemMkr73MjvbSfTQm8Fw4cHONyjbrC5elnGE/BfQQmc4P2FPK613JzwV?=
 =?us-ascii?Q?sa8zIcVfoIt8y1XrPCmQ6I2wPXfevul3gwFR7MKzCyJla2eTE3ocKAU1O/0y?=
 =?us-ascii?Q?IMRwTPTxWjE1EgfKaIlCiyDHuucapQSxOdqPvr6b163O29zP1LSHKWNpziMc?=
 =?us-ascii?Q?S+dwwSWYMrbbLPLiHWefRZO/ee+sw80gCDbD7oP6f9XlbW7Y0RMR9KVCgYAT?=
 =?us-ascii?Q?ncuJHPMVuAuPmnucXdDzdjaDC9E7N4m7oOYexAh8XQ18ALfbuzJ8injKBeba?=
 =?us-ascii?Q?MgW2Bx6Zo9TD0pXnMbtKEUcWdGjcAToE2nfZqLi7lfaGiUA0tW1WzuJvy6PX?=
 =?us-ascii?Q?Q5bKgm3zThk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S+18MlIqZf0uOmi/GqpwTZJVmbHhE/7fVoaCkZkh1e5vX9WFSN/XaIzAf04+?=
 =?us-ascii?Q?CzNm4kaE6VZ6hk04j5yPlPigmLk+wQMBUBT+/B+C/TseW/IxfSY8n1GbVR+y?=
 =?us-ascii?Q?muArDUCE5TUcrQDbrDr2i4IcoTAusO+4MLCIHcMFURclbCeZ1Y94KHUswK8i?=
 =?us-ascii?Q?FRQQGEIfB9I0qmlEVGRpTYwOpAAiq6P/Kdor2AWMT80kQszPyn6mGou3xTof?=
 =?us-ascii?Q?GLn6n0BMlQgr1Pd47xQMZcvq0sxB1kffoDysR+7aP1Hfv6960H2IZxjsRlvU?=
 =?us-ascii?Q?b4qiG9acNspXYJlysoH8giAhzKQ0jrwJ6VzlEqRoCXjw/mRcn0EjyprxEV1y?=
 =?us-ascii?Q?RnnK50MBnv/zOIciBrr7pB+b8NNVsVBtVTPTsoI1EgTcINXIxuk9uiVcg4Lq?=
 =?us-ascii?Q?7myNPU7NuWUZFsgcVqqcspsRZSWeCxjN3ZEtYWGE/PGDGywUpzEhWd0SiT27?=
 =?us-ascii?Q?llmRSWcmkv4/rlOZsKzhIoxdeUBTtonwHdIaqtKsaCwUgdY4Mt3dgMk2P4iP?=
 =?us-ascii?Q?WspQ8ZjrerSy4fLkwIvzTGmppFHUCzPmtdu7a/UFBXvYeOiCljrTyMsODh4Y?=
 =?us-ascii?Q?pdj0KyyYZQ7PKsIfyyPutC6AZu/xeIvcbWpJ+vrTAE2cyG0sB+vdMIyZy1kv?=
 =?us-ascii?Q?o8whuTrwXV4MxIu3nCyodqET4zJ9XuP88P9yOJ42fkaDyxyCRzM62fpLFN1f?=
 =?us-ascii?Q?/hTbQjQiNBeQ/182bZ5M/WkC5Dx7FgKy3PZJ4Ui2Kzq1VM4mqkYMm+uatV2p?=
 =?us-ascii?Q?jYHDDfMEjqNXHt3KIo3JpUVVOl0R2caapt8CJy3KkkTDiyaB8PHIR/sf5RR7?=
 =?us-ascii?Q?kFVwuw08IiJcLnwOzIVcH4tCj9kvkRq2RVJk7OUcy0KHXyTWSARlKHfb6SCf?=
 =?us-ascii?Q?/LW6bN67S0jVPRBnfpCshWcbXvX5JuXi526m3ap/ZRIVvGX/eytx6M+hhwxW?=
 =?us-ascii?Q?mnmzRVdgy4L5QDesBpbW1XeWjlfNJ01XRuTeIPrQBpCHdCOZga+lDPHGCmt9?=
 =?us-ascii?Q?EScp5vnds5zabdz/LXXsiN59eSLFuUPyANtwubWkwcRG2JqmcWDXt2qrOd5h?=
 =?us-ascii?Q?AtO9J1i6CSUtWcuT34RAW4Tvm6vmVltKBbq3kldnXzfe2l6WRpQMdTOZbzGF?=
 =?us-ascii?Q?Se+oZegusTCLWU5qAL2y6r2hmAuMtQ/jgHQsbaTo6b4bAPYhw3a6k8NRQd2m?=
 =?us-ascii?Q?j5XYu9eK/Hi0vOXNBk4GbdQ/KeyD48TPPTh3jU2hsrjswm5eJnvnq4G1XWBz?=
 =?us-ascii?Q?fTsPU06IdJ/de3qLkeSPBJpGPeLGwklS6CPQBQoYKMFCTzwl47ZXHlqulpJs?=
 =?us-ascii?Q?KE2GAnry3SQwYE1RQv/rAiGrWGHkLdK64NQTCxw515Gp+OZxyEfmC+ofpRf4?=
 =?us-ascii?Q?qEX4IKpR7qBN+XTxg+N7qaRZoo+5R+fa/Z/H+0ZC50CDXDsVrjkzVyPBhQMS?=
 =?us-ascii?Q?LCehrUR+UddT93vpKj5Kp7pRvua3jW4x9dtc8wG0t/r8n1JI6RnXCC0eAnRK?=
 =?us-ascii?Q?tpD3wW73+FI1aPOJBe2TIjZN1NUDXTjgrZcS8AbtOT7SI6JnohDwEwMREYIV?=
 =?us-ascii?Q?4ZUR7KMnY2luwCPfJh9+LThQKjbnje12gwC5m7eY1zqNwEUeydFFOppkj1Rf?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685649dc-0800-40f6-5905-08dd83ee4196
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:42:28.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1EHlvTzWPpFspgHm8wmKbYVvBH7rvalY+2dpF+ouxJC0GbzQp/TY+34hNz+W1pQQBflnmO9eg5u8ftOvx6aUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10686

On Fri, Apr 25, 2025 at 09:52:13AM +0200, Jonas Gorski wrote:
> I gave it a test with a vlan_filtering bridge with no PVID / egress
> untagged vlan defined on a pure software bridge, and STP continued to
> work fine.

STP is not part of the bridge data path, it is control path. The PVID
rules don't apply to it.
In software terms, br_handle_frame() returns RX_HANDLER_PASS for it, it
doesn't go through br_handle_vlan().

> So in a sense, VLAN 0 is needed, as we still need to allow
> untagged traffic to be received regardless of a PVID egress untagged
> VLAN being defined.

When we are talking about the hardware data path of a switchdev port,
that is debatable as well, since many switchdevs have built-in packet
traps which again bypass the VLAN table (a function specific to the
switching layer, like learning, STP state etc). I would argue that the
presence of VID 0 in the RX filtering table is irrelevant for STP as far
as switchdevs are concerned.

> But we shouldn't forward it (except to the cpu port) unless it is part
> of a PVID egress untagged VLAN. This is the tricky part. If (dsa)
> switch drivers ensure that untagged traffic always reaches the cpu
> port, then we can ignore VLAN 0.
> 
> So I think this boils down to that dsa needs a way to pass on to
> drivers whether a VLAN should be forwarded to other members or not
> when adding it to a port.

That can be done (add a struct dsa_db argument to port_vlan_add(),
signifying whether it is a port VLAN or a bridge VLAN), but I haven't
come across switches which can make the distinction. It would require
mapping the same VID, coming from different ports, to different hardware
FIDs.

> Currently, from a dsa driver perspective, the following two scenarios
> would be indistinguishable:
> 
> $ ip link add br0 type bridge vlan_filtering 1
> $ ip link set sw1p1 master br0
> $ ip link set sw1p2 master br0
> $ bridge vlan add dev sw1p1 vid 10
> $ bridge vlan add dev sw2p1 vid 10
> 
> and
> 
> $ ip link add br0 type bridge vlan_filtering 1
> $ ip link set sw1p1 master br0
> $ ip link set sw1p2 master br0
> $ ip link add sw1p1.10 link sw1p1 type vlan id 10
> $ ip link add sw1p2.10 link sw1p2 type vlan id 10
> 
> But in the second case, swp1p1 and sw1p2 should be isolated.
> 
> This is because vlan filters and bridge vlans result in the same
> port_vlan_add() call, with no way of the driver to tell from where the
> call comes from.
> 
> And yes, this is something that is probably hard to configure for many
> smaller embedded switch chips. E.g. b53 supported switches do not have
> forward/flood/etc masks per VLAN, so some cheating/workaround is
> needed here. switchdev.rst says to fall back to software forwarding if
> there is no other way. I have some ideas, but I will first need to
> verify that they work ... .

We have insufficient coverage in dsa_user_prechangeupper_sanity_check()
and dsa_port_can_apply_vlan_filtering(), but we should add another
restriction for this: 8021q uppers with the same VID should not be
installed to ports spanning the same VLAN-aware bridge. And there should
be a new test for it in tools/testing/selftests/net/forwarding/no_forwarding.sh.

The restriction can be selectively lifted if there ever appear drivers
which can make the distinction you are talking about, but I don't think
that any of them can, at the moment.

