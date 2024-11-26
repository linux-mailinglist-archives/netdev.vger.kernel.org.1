Return-Path: <netdev+bounces-147524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D98C9D9EEA
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A6BB24353
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155C1DFD8C;
	Tue, 26 Nov 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCz8kx1m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12351DEFC2
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656851; cv=fail; b=nTx/DnrPPUYGUhlEpOTcAp508p8l2QlMgKuRRPClO2iEbW4rvTPTzZ8ctFogNZ/yc7Vev2rOa71xj50DChmtYIdmQ1AlXEgeRvvXwwz3Io++imeygLp8EPXnFlXQC0/Qu7R1Px3qhHHO5fwm7n1arX5IgCZ6UIr9jERSP000pLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656851; c=relaxed/simple;
	bh=NK44iHdiaSKCV8Fc1HFEji1389NgNQRY1s4MrSeAmvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5YJf6nqAf77Q6VbqKFqOM+/bmjzxMEBo7dZxuJSquXZvchmX2IHc1VXvgRpGWqE2u2MPIu5cxLWgV/oTadamoAN0h2ImIXe2B2SJYOuMO3glAh4iax9MjzOR6TftTwNgQHUYoPbYxxdu23nVtFWS1znHre75kmjn5NF9X+6aRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SCz8kx1m; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVF8GQ4fqiwg1/+q4wOExduk9MHEy+e4Uk77jKONSw3RcxEXKSz2jznMEG5y9dO50cGdCUh/gzlGHp81V549Ubkdkup5wvDI5aLvHB3J+2OCZjZpfxKr5boq39RJS/llqUjTOKDDog//u1n7lDabghqQLTavPlgCT/VsTIlUcUDxjW5UXmxiIqUnvWw7NfYFk00ongW35EG6+anZhg79fIujoI8iA7XE425Z/V1l3ah9Pc2q3PN8hZSiofjfWdlBz025UwGnBUAtCYbJ16Su8vflkkzKwLye9T2HX6tDDjVAfJPGCsK1wmJcpz6o22dosPccfkKLBOjN8wz9qh9TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLbD8pAehF9i+kNgm0yShNYN0hnOQEzQtRyjkptixkk=;
 b=TOTO1xYk0giZFhEfD2v/oinfUAFo5TEtvmDlcquuTYY47BBrNSI7mvXd/8i1b2p5gGXfDyCOpL6esxI1N2nm00KaP4fKolmBMORghFg2XVUWHRIZobJvC5KJnpd7LRbFRsVFLaAAtGdDMNoCTO9iSg3jg9DINu97E3ubnO64eYwo4ko0IJXMGCwyD8nN6RZMmoqGopWaMQdZ3y9OD87Y5kldO1SD/s1bUn0ZKM3cTj6mcw2FsnOo0ZIpEs2VDF04A37FuQriAEohDupo8f7Y1KJmXH4/vX70Sblp6VNthkgO84nxaruyY4wSF3iJev3D03qjWaba5tSLo5fCcuOQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLbD8pAehF9i+kNgm0yShNYN0hnOQEzQtRyjkptixkk=;
 b=SCz8kx1mrfZmArSEysLb0ry9ziu24HkGATq/lbRKaATc5q+VEPkIXVQiQlh3ev5aqnITcaHRoEhWX9RAoxMUdOmjDRTiZJvn7/8dyINLm+MT5+ww3o0Yw72oZCCwQQrNzy+EJRRz2ijUlQuizfhtuz3U/kBxv1cHyBYlFV2YNlUA/nJ+PrrbieASzjSIt6EQuvBgVvhpiq1alLnG9rpLT5sOhc6bBjrCdW8BnEqT/dAGAVS/Gmt7ZdXkOJ24hwdZMaesh39+ldugxdQCw+vAgvKYkGKgmyrxj6H/OfyjHMNKAP2h4xgk3BnfemQuT3dY8riMj1PSpVCiy5O7lvB3Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 21:34:06 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 21:34:06 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	ndhar@nvidia.com
Subject: [RFC net-next 2/2] net: bridge: multicast: update multicast contex when vlan state gets changed
Date: Tue, 26 Nov 2024 13:34:01 -0800
Message-Id: <20241126213401.3211801-3-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126213401.3211801-1-yongwang@nvidia.com>
References: <20241126213401.3211801-1-yongwang@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17)
 To CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: a28fa249-4af8-4b28-0805-08dd0e620e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bCSsCMvjvGDBpc/cst/nOfV34BQuEZThDGt97TtNScFKG0BxBrBlpNd6mVRm?=
 =?us-ascii?Q?Jbc3rDwmvj0Zkwa8YCweTwwGdpHIxtTrYpkbobrKCzj0iT1WLNu7zjOOVU2r?=
 =?us-ascii?Q?9eCzrJwE4njB3M0NUnPRKddPRZoCj3yL0rqq1g/4ZSwWM17WxPSFV1v6LL1W?=
 =?us-ascii?Q?CdshGDxBhcC34VgODEZG3WIX46mpV42vlQzuDRaK7ehpKxFPNx6/Pkfysldj?=
 =?us-ascii?Q?Yw0d5Mv/TUCBsJ6zduyIdOQFV1f8k7cWA44IvrtSsfL/jC/UYXKH0wcEbTrZ?=
 =?us-ascii?Q?BkmfsNiMWAYX9OdX1lcb7QbLw+LJplL6gak8vkzNmF95IlSLqBRKIDSDnCuK?=
 =?us-ascii?Q?Ea+k9Y5nVhf2P9TUKO96XvoPAnOccYa5BCTAJqX+I2e7RC9xCF+RtRY6vsPP?=
 =?us-ascii?Q?ksQgJOwn7nheZMGIgWBMqBQ5DitcVwRm75fw7zQ/tReVUwSE1NNB95jikoYM?=
 =?us-ascii?Q?a97VGWCOJr727XhjNnDGlw2BPl4Tdjyt9pO47XTk1FaCnSq0+7/OkGyHsqtC?=
 =?us-ascii?Q?ZVlTMKGkKvFRo1urm0aCbh5OLAK6mnFMOI1ModHZW7eqDm6xcZGJaoCf+QJr?=
 =?us-ascii?Q?AQa6TMByBX9Ch1eg9n6QnPcogV0H3Zk8dogpRsMAEQnty7sYKcGaT1Pj7ubn?=
 =?us-ascii?Q?Jc/txm8cyClo4F58OSc1srPAhrbRm37Mltl3QkAeOSEOe0PFxjqdT8ONBWEt?=
 =?us-ascii?Q?bHuyOxaszTCa6KMX+ij7QYjgoRg8Md3JIvsr/mLYBp1kIYiOw8AOFe15NLgv?=
 =?us-ascii?Q?IIHmbFtqciPN70gitLzjPjNvrQVGcotoaU7SxI78/WPOkncY4RDCSc229n3J?=
 =?us-ascii?Q?DK2NRtuw9R4LVwrTL65brGPxRaBkmoS7hSdRY33T1EjfVQfBhGm3v5fYRI0u?=
 =?us-ascii?Q?2Qky799rHT6iQED8a+cZirntrPJIMB2r0trvp4LfXrh3Bmxsf7s5vIuotaIZ?=
 =?us-ascii?Q?2t4urUD7p10hw7Cd1daJTnsMygSzoZkmQbvLvNAl04AkmWsxUVYLINkAb/3A?=
 =?us-ascii?Q?voPHE8cNR7NWfzo6x0GobySVYYzAeIq0Aei/pLfA2d9u41QSiG5tglrg3HCM?=
 =?us-ascii?Q?XEBTFfACLw0I3ZJ8+n7/u+Cp2BkjR1/75Fvmb9PpLAAuS03LTTdhAT/T2dO6?=
 =?us-ascii?Q?VlbZbrWuJmKgPNL/wvWfv2pp4ZZhqBPFd3H0bIjc9P0y7VqYMHxqZGJM9BYA?=
 =?us-ascii?Q?pM9Jar+9Sy2d6HvFzLdqovvpMSW5drXmWD42I4emwaK/f2fu0zyRN+LvCnMz?=
 =?us-ascii?Q?9cItAigxCSc5/Qt4yCf2KMEyIPhB6ZAcw39WXh/ClsypHGbUPEaFSE6/N831?=
 =?us-ascii?Q?TqFH1VLZ0QrPsy5FxxcY5RppBaV46bA0lw+QcWZjvRimqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbnQqmoSTq7i0QBnS837tcVfpHtizMjDgnzqKIouNjCjm0TjPn25BssrRni3?=
 =?us-ascii?Q?U3HiUB7SJIFevuJ6AgAgSQJKzh5LMnqFKYahjc9xJ3kTVyG+GLPrwVUN/gvI?=
 =?us-ascii?Q?NKJ1SAgsUuJcUR6iAD4IGo52cya9FYjhk4LA0vL30yCH1jWjRd9f/Vez0+IP?=
 =?us-ascii?Q?ajBsoxFPyiRIYwfKgN1gXIiFy1jCid/X+bmkuZYXGruKPFMPjGgJ4Vw19s55?=
 =?us-ascii?Q?Zz98mWzZd3kl2m+xgWruTZBlGIIfnUks1VyFDEnfrPKvh0GHou7nRabmmngb?=
 =?us-ascii?Q?7Ar+PzqcfdRdt1O7/a0ZI7jmdpsdxvW9M9xhGZ2gyexsLFOptLmSqLH3oOH8?=
 =?us-ascii?Q?3LiwqaqjmZ3hqXT+a8lKBNRIHwE/ojvoWTFk8fUiEMQIzAlzAQc6gf0y7tbP?=
 =?us-ascii?Q?cEV1TFkgceHT8XBvVFW+LJgmKP/ZCmQpfVjvNaHY+WP1nmRcF2j6UwxLsmxG?=
 =?us-ascii?Q?SWmhMXGMEPj3afIVU76G1cE4E1mSkZzLR3chRjFpBuR+kWw0B4O0TuxacgGx?=
 =?us-ascii?Q?DWqahsXHygbCuC7GZQF8YIUw1b1h7zKN3YPXuiKsdZ1zhJ8ZD2NZOlSLB0ya?=
 =?us-ascii?Q?86XcpnNu4UNG4cpZYR71QQElWjOIQwjzSNnkINVyPhk1Iss4+EOlovSe812t?=
 =?us-ascii?Q?4779jf0Chh97WOPBFSyzTl3laEwj984CLlqxzyk+WdS75HCi8soKgOnTzTE+?=
 =?us-ascii?Q?W5boG4ZGesP4bWbYZNhfTdP7SYSievClN4PcCqQM8jxrBpkQkZ44zDLUWUqh?=
 =?us-ascii?Q?RcI5wjccZvfVhOxdTuTlplFBDP9XE00ubot7JB7Cd3AlcIz8Kit5oFhrqG4x?=
 =?us-ascii?Q?iI3ngKvKwSTkdegAQ2i7lpnhbmYi4qd2YuFxl6GjG9AL9B8GrDXq+cuzOByJ?=
 =?us-ascii?Q?2k8ToMfYcL2VL3j7LG//3tzu+slkl+xZiQwvlbIUbMS3n7mKs76dB6IlJOFR?=
 =?us-ascii?Q?Grz9E9FjyYe+TvoO/p4Hu72ivs8XHUTF2DfYNPKmezDoEKscgVuMsAkKulr0?=
 =?us-ascii?Q?/+sufB9cUpSQhoC9OgmM4L4IiCReaEwesKnWRP6+87aC0vD1oDKgD3OynwDY?=
 =?us-ascii?Q?Ch/oMgZwx7bIlZbx5suwBrKediYjarwsd3Pp9DYtYPpOstxrT6YUILdV70r8?=
 =?us-ascii?Q?IPc4xvZl1GHmmvL0xNktvU1d3CzPNO/SVnUw4NmcX9nOYm7h7h4XtU08nk7n?=
 =?us-ascii?Q?xej/nB8gRwptFHl5IyVRXBOvfvmQojM+rlo633AfQarXt55QtYZO9cuBEUL6?=
 =?us-ascii?Q?+tzwfyDVeKRQzCDvtRBvJZw/f3J518FjKi2wv70e3ar8h4jA5sQZL9uouJ51?=
 =?us-ascii?Q?LhcwcUS0wA63LkbjZ1hQ0RjDJYUIdDIFhypNsuFqjWsoVIqiklb4+xfVWrUK?=
 =?us-ascii?Q?WIc/87/1AEkxafNVPP/2CgHFWhl1psgiv5jX8Zeq5XroOWDR8hN5E2K3JvbR?=
 =?us-ascii?Q?DBG+d6Sr5cBBylhq3Nuptl9w6aQVSkOOYt1mPM/7AvE0ffHCZJnCXEdJoWOw?=
 =?us-ascii?Q?1DUZwmGwURHQ7X1MXoBtUWuIE4hRuQ6I0AOTRWvztJhGu2H4W7YyXwD8l2+l?=
 =?us-ascii?Q?EI3sIXiNyCPzBWgFzW5E55Vil8Xfme2NfJlkT13r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28fa249-4af8-4b28-0805-08dd0e620e19
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 21:34:06.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvucSdtoahXkb3zqoz6YY7wbfJDFk0HZbtrB4ysYMfLCYmGWDu3WQuwJ5g3aNe2kO3vs9sukqjQwljofLANnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102

Add br_vlan_set_state_finish() helper function to be executed right after
br_vlan_set_state() when vlan state gets changed, similar to port state,
vlan state could impact multicast behaviors as well such as igmp query.
When bridge is running with userspace STP, vlan state can be manipulated by
"bridge vlan" commands. Updating the corresponding multicast context
will ensure the port query timer to continue when vlan state gets changed
to those "allowed" states like "forwarding" etc.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_mst.c          |  5 +++--
 net/bridge/br_multicast.c    | 18 ++++++++++++++++++
 net/bridge/br_private.h      | 11 +++++++++++
 net/bridge/br_vlan_options.c |  2 ++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1820f09ff59c..b77c31a24257 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -80,10 +80,11 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	br_vlan_set_state(v, state);
-
 	if (v->vid == vg->pvid)
 		br_vlan_set_pvid_state(vg, state);
+
+	br_vlan_set_state(v, state);
+	br_vlan_set_state_finish(v, state);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 8b23b0dc6129..3a3b63c97c92 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4270,6 +4270,24 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 #endif
 }
 
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+	struct net_bridge *br;
+
+	if (!br_vlan_should_use(v))
+		return;
+
+	if (br_vlan_is_master(v))
+		return;
+
+	br = v->port->br;
+
+	if (br_vlan_state_allowed(state, true) &&
+	    (v->priv_flags & BR_VLFLAG_MCAST_ENABLED) &&
+	    br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		br_multicast_enable_port_ctx(&v->port_mcast_ctx);
+}
+
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge *br;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9853cfbb9d14..9c72070956e3 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1052,6 +1052,7 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 				struct net_bridge_vlan *vlan,
 				struct net_bridge_mcast_port *pmctx);
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state);
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 				      struct netlink_ext_ack *extack);
@@ -1502,6 +1503,10 @@ static inline void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pm
 {
 }
 
+static inline void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+}
+
 static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
 						bool on)
 {
@@ -1853,6 +1858,12 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
+/* helper function to be called right after br_vlan_set_state() when vlan state gets changed */
+static inline void br_vlan_set_state_finish(struct net_bridge_vlan *v, u8 state)
+{
+	br_multicast_update_vlan_mcast_ctx(v, state);
+}
+
 /* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 {
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 8fa89b04ee94..bad187c4f16d 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -123,6 +123,8 @@ static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
 		br_vlan_set_pvid_state(vg, state);
 
 	br_vlan_set_state(v, state);
+	br_vlan_set_state_finish(v, state);
+
 	*changed = true;
 
 	return 0;
-- 
2.39.5


