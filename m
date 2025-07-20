Return-Path: <netdev+bounces-208430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3843B0B656
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D7B1896C0F
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D61A23BD;
	Sun, 20 Jul 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLjokySf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AEF15A8;
	Sun, 20 Jul 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753020622; cv=fail; b=EcfaBFy97Qcv8rBlQM0v7kFJDJGeK3PzBhgEPh70am2G/LkuXY/CwrbaTr3T3W5+VPgWoB1CKzNC5vAKOLBB5oOCOrxbpT/IyybTFIyXQ8aiZRxRFOdRO+3Tn60xObSp5aCimqgfym3m1l4Hqxqc3He0yy/5eXjGZGGQ4BynKzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753020622; c=relaxed/simple;
	bh=S91cOa5Hs3Wg/nAko/+/ovJj+6+Q03wRn6tQlZyAdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgGo0lv+AyqAJi+103qcYXTbuMCNFtdCmeRPiZF6+rbi5kaCZ8SwW/Z7bh+FWxd31TWM2i9oUmHYb8uhJNflY9d8EOKLF8BPLPOC8a9ogcZEM6QFha8C33/xASOhaxs/CB6MC3bNsAdi0aC76zIgjkNKf5hjicBE7DQjkcwJzWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lLjokySf; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdIDRmn8rQFWtJGhau81llvfGOTbm4n+CvNXtFcnUiV6Tf8Ysc2ubMboCQv4h5lAnXneruFHQDvMzGLm8wJuSZqbmtmAAiw2isNTZiIJZMIqY3LeHl1oWXaEXvOTQ1OscqJgv/2nrIZSLYIMzWC1+NeQ0I09Js7SomnJPrWHC7CLDZ7eUcwq8KRmlflxnVJFKZ9GFm6BJWS6BFVP7DlQm7mryKdkPUL8fe09jyQ3ohfl8gb0ju0zQEllvpTSks+tpjQ5NECStR8/qVyCGui9YwFsz/PmlVZP6oyc7QOCwSsYXKMUm5hV9JlJU+apABcZ2eE5UzN6sK1taCTNpFEBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9B7gFqDxuh5rd0OTJg0y3aT1ILZhDbaCxENew8y/yQ=;
 b=gnBpAE+ZUnz52UJKvgiliDR1+BG5LRGLlSi887u87FjeGtlDt7FnZxGyqcB0WFftzaLYQHdifvLuNxyak7ewd/Ic7m2jFrUn7nP11Smr2NPsuMCy9y9kv14i7gjQrlFJLTYyfkv4IcuaupQTtG0p8j5qOfmWiA6z5dIV2HSk7P+NW4uroMPP044priNTtsxjnOGLCWljwxI4okENnSEyI+lxIJy/Zyq735k/PaAsHA2dvqUfQhNlMA181Gq5OtOVaWawO+dxLtxLcCHtZKHev/PPbW1C8QmKNb9cGgfo/zIApBF+tjRBwspcRVky+iZijGgeV2wDvRQnoG4NluyuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9B7gFqDxuh5rd0OTJg0y3aT1ILZhDbaCxENew8y/yQ=;
 b=lLjokySfk/1uZ0jeIXxeyj8zZMKck3PXLjR8zQMgLW9rSwO7u2Yx3DUNqvQtXGanPeD4YXy2+ANOUcXhpswth4VGPW57fdqyGtjbkBgz8F0cNKaGBIrvNMc4XFBmb8JLuXBCK4FCW7RfZUksyQr+foqkL9lbupq5L9yy16c0gDHZiTKv7hmnsYERW6rqcbAqWtSgT3XByRMyfOi0WsHu80BsNKS8yOCv7J1RFxDOZFPfoMz32hpCUYMb2Oxil6z2lhniUyB07wWHpqdzMvliYxa9hnvG8Bq+U2R1FkCs17e7sXJZPevYrS+j//1OcIANQTZTrhdanZ8KgLfpSSZk5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 14:10:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8943.029; Sun, 20 Jul 2025
 14:10:15 +0000
Date: Sun, 20 Jul 2025 17:10:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/4] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
Message-ID: <aHz4vvDSbi8GhbhU@shredder>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <20250717115412.11424-3-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115412.11424-3-richardbgobert@gmail.com>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: f2175075-5bbc-4a67-0e8a-08ddc797267c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ui2aZ+5VFYnO5DewpKxSfWZhFp2MkQvCxZMmD76ULfuaXGXpA5OuICcGW/96?=
 =?us-ascii?Q?8zynyKawDQ+CwRQYjgeftOtlV2rZBpbBGkAsEoKG2mPLYGzoYJJON93VnGHd?=
 =?us-ascii?Q?Ksj5b/UphFhlZROi+8HH4RG4YrxCOK38Z6BZI+j6xPq47oxOcc69WW80ysE+?=
 =?us-ascii?Q?ETKncLSjeA4sclUP9U9HWifluszYQuMBgbRTXG/Hp+lLF6kcm0f64R3/g/yx?=
 =?us-ascii?Q?xkC84DdmdKRCWznvclWk46LIIbhBbPt4MHx5HeXKeSrC5INuU4sTbfVZLLae?=
 =?us-ascii?Q?sGplYAuuO2QG+aPxu5cBBGeaqr7/p8qz0DofCcFMG4b8RX8MTMC6YYgHdUqE?=
 =?us-ascii?Q?eap90bq+3uxZmZPr/OcaLexLFwzgvAznRBrf/sQ+nbD7Yzp8koMEGTo0r6zw?=
 =?us-ascii?Q?7Z9UVItH0AQDVvn6Fzc9EQpCNujb/yEmqMe+VoQSyHD5HQvX+cwpJcXy+u5c?=
 =?us-ascii?Q?r/5vZazZGpy9LOJaKq5T7OqbY8qKS+ly/4F7xRoC615q7PMm0b9tHvohQswf?=
 =?us-ascii?Q?ghiFrBKZzmvUhruwUc2h92atXqo/eirLruE/xEz42g74lgTOrgZpXrsrh0jW?=
 =?us-ascii?Q?hQnJfhUc/mKfwLDZa9zcBdBspPbMOxm4lLEA6MTFYCnEFHz13aW7BcK6YyCR?=
 =?us-ascii?Q?W4i2qhaVpPgaJSGhkJBBCCbjJ1d0e6XCSeXZZMLyzqRwIEl3QsnmAcCOXUpY?=
 =?us-ascii?Q?vdGQ2LbvhFaZySXqF+H2GpL0VDSzfnlGZ0mgSdEmU4yKfIYbFh07hkuedEe6?=
 =?us-ascii?Q?BQCdoQvcxCi2AFn2GaHh1aqjxWcybfUabofTDMzQQjvrBxuNYeTw/sWsLHW6?=
 =?us-ascii?Q?f6EE2Uqp/fcojLmWoQfA3TOGiSfxfIqWWwiAJ2iJDvOY8MwV/CwgSW50PKu9?=
 =?us-ascii?Q?9Dg7qedDi1kJydx2UuA1BLViVZDBNz4A4OQmjW5WTRs0ft2lqeeiYtFXPwLr?=
 =?us-ascii?Q?swvC08rJ1R7q1jCC4ytmUuWmcRicAxQ4X40KUWV77HI1W0TWZd868GTP/54T?=
 =?us-ascii?Q?DtqEN/lVKkTBcFMwnyT1lyx7qJCv6YbpTnWQ8YAeRETQW6ejMJXJoIkkmeE8?=
 =?us-ascii?Q?l3d2q4UrgtAgIZ9CxNRLp+lAA9lE83ceXokcFxlff1uZevaKQ3aHm1APZ9dt?=
 =?us-ascii?Q?6PERUToMnjLOF7K9VwW2FNL5we3lynogkusDtPGzLV8rtroiyX7t42+i3UTk?=
 =?us-ascii?Q?hwoNBWd/sB7Gpr56rEV45mtLOyrXPlohTZQa7LEKDwg+LljQWIewNhioc2yZ?=
 =?us-ascii?Q?JATpsqlBdW0e+5+GOIRR39mHXiImBCYDuNJUubrdkl42UiffUUr6eU24rC5N?=
 =?us-ascii?Q?9+t0QakOoN6GdfgqzC3Y8RfQJZim/vMn5j1a9hBHD1RNSekALkw+jFWDOGZB?=
 =?us-ascii?Q?4lyRgASHTxTctzVNqGkbUMIVTM5ShFRUwhi+2lxm/VAjlVBh4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xq2SOKNaKuswmIthWIQcM3l4OtOKM3o3NUbOwUhRAnJr8AMWGuKmU1a1Z02b?=
 =?us-ascii?Q?geXNMEEqC7Dqz2vPbb8AoF0lc4COKXfLSWaj5anYe56QeJmmnnhagQasD1YE?=
 =?us-ascii?Q?Ax2+Ak83d5I6A1PTQuX42ufjwA3MuYixTdRD9usjn2pZoKkQ9vMhtVvdbBBE?=
 =?us-ascii?Q?lc1NmwO6Tm4U4Cfra1LyqB9ijb5D9+kycSCPexf9Wa+ST+jjDYRCPn/xLWgz?=
 =?us-ascii?Q?7jVpfkj7aBEEsFrj3QoJcJ2t8ezbtB2CAkIeOIefhSpNX16f5u7EIDywwpEb?=
 =?us-ascii?Q?YmH2tHrC27BikDxcSGNA4eXmF3fE28wntTMZ2ZU3VIZw4J0rO6Bz6zWVHqFF?=
 =?us-ascii?Q?iAOiH8lM507bFTJCJTmpyGjPOxv3xUuCNzLhc8lzSn+8p9k1BABk5M6+qSEJ?=
 =?us-ascii?Q?NA1P130+tBkt1O+N7YYZtP+YQSvIMBMnakXhgjqyuAskFGSkVrK9uyIDUdfJ?=
 =?us-ascii?Q?ljC7mMa6aWDy0is/PRUpcex1+1WKW1o6QbZZp7s+X2mON/uhKOvxMbPEBsUT?=
 =?us-ascii?Q?a2OIpw8BtIhjYNubceWhAHbRG4WTiGYDqgzm6jQh+ZeydzN3b9U/UeeUHkkW?=
 =?us-ascii?Q?ePKM28ACDJeZK4R90H7rToPvbKNPcIHDKfbess6jDeLoswGijCZEi6gGQI1W?=
 =?us-ascii?Q?uPdNzbZNk66DBLj7XkTN50gcCfRbCxNdPzlYVicihQSSvXhpYFMxB/gGlkCF?=
 =?us-ascii?Q?m1PH8OZli+Uz9J+bU5Qu1O84tbNXfoeBFAShl8v4HFydS0Lj+1b2C5O7JcJf?=
 =?us-ascii?Q?CUSKgl8FjhyXMGlIGo3caOBcVhSX353U6XFPVC/QPdf7Aih7aUu6u7rksZmk?=
 =?us-ascii?Q?8QEEUWLVsqPtsUD0Du81Pl69xiJf6FYGvMAqFIJVY3Rkw7OKlFmr+mSkwqOg?=
 =?us-ascii?Q?xkpTuqMOokVSJcRahOVs2mclFVUG07v2dYUysp+SKoNjRiwK//9rgwmL8RFS?=
 =?us-ascii?Q?DXnixBkO8Kh1WMMB2rFw8y+rrkge81bHtqcKS5XJPKOpmla6kKTkbVEUyJqe?=
 =?us-ascii?Q?e08LJnnwxPoI8ckDbS3sUe6OKa8pfIyB55Wv0rq3buL7htrp3990l6hjoFr/?=
 =?us-ascii?Q?XhRXL8IIyhRQoAgUi73daXpY52Y/rJ0o+GCk1uNyR3kDNmQRNA8ZXijmHAH2?=
 =?us-ascii?Q?BYQUkaHxJq9gIkryS+WVTYrhR1qYu8O6FU7+ulR4WsGd0jFMyl6iMlzso9lB?=
 =?us-ascii?Q?bNuT2kr28BQR0CoTZknulL2rvVbGbxDC1CwYmflcKvgDukNMcHl8rhMgp3Qt?=
 =?us-ascii?Q?ciLuv2Cp50mxXRQjQJvdrf5K35Y1NiTUWhh4QrPd7xSaTFBpnY1vFkWRei1e?=
 =?us-ascii?Q?POF8juT+pheJManTEVtEhpGPU+Dmme9eJmOMGbILN4RYI++m4HY+TyuagiCw?=
 =?us-ascii?Q?jeCMe4pU4WVk/zWWDGVPekZM6osa7BnOI1AbchBQ91nrl+/fOHNizwdnqNnf?=
 =?us-ascii?Q?6gznTOp42eTJ8bMx4vJ8yctcVSS30YzRtoJ+EthuLg5VDfxq10vN61FVzDeL?=
 =?us-ascii?Q?roST9YTHK/3Fvfmr+x/j8pFESutdl9nqUcJYu1gXxsbnbKuFh9hnUr69cdB3?=
 =?us-ascii?Q?pcC637c3VsWoiQqcHbm4XQN7XOPH/+ZjjOmxWydu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2175075-5bbc-4a67-0e8a-08ddc797267c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 14:10:15.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bu1XorEG2bbcWpKorMoCx41MqofZ7yBK7882h1oOMBWYixnx2qmDJ4Hl4U+pJXiPUPUqPz/ZrQqU7j8xpS7THw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

On Thu, Jul 17, 2025 at 01:54:10PM +0200, Richard Gobert wrote:
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index bcde95cb2a2e..667ff17c4569 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -3406,6 +3406,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
>  	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
>  	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
>  	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
> +	[IFLA_VXLAN_LOCALBIND]	= { .type = NLA_U8 },

NLA_POLICY_MAX(NLA_U8, 1) is more future proof in the unlikely case that
we would want to assign different meanings to values greater than 1.

>  };

