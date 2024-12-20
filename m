Return-Path: <netdev+bounces-153828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F39F9C96
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E851893AC9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F192288C6;
	Fri, 20 Dec 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZ/HhLHD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657422144B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732375; cv=fail; b=BdZrvzbiWT7rkRdQUFWwnt+V4ptnlUTWCb3TMO3VeCGLPDKMuafqrbjsp7AyqKsy/ZmQjq6axNZZ/bwWBMXQ6jNGyIxsi95DBTBs41RavWk2MnkVSX81aCq8c2L+F1lmSDlBZUmxhTnWQyCDKptQLxt3AKKVGCZYgOo7N219ynA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732375; c=relaxed/simple;
	bh=QqyjineTYiiguChvmECROkYu2v4UPENXfgJ74JPd13U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBS3V2J8vIwvQqe0ZfjXKuYvyx9MwanQMUmf6QoU6nuIZ0Q2+HMQvQfTzu95QkJ3uO8WanNg9H7hjksa1/JHi56aA7USK7E9CLt2xIUMBb+ZE1VBjxWUHEeackPuIdhtmDNyrnKoEIXFY/RWqeeRgUeJTKybrCFxPpyWsuwJi2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZ/HhLHD; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnA6c6l4LMx8At09o5qpNiSVyq4C/SWYJjf3A4W83Oemzu+SAIxZCcwhsceC6fy8W5fQrPHoJvzpg+p0Ds3cmndKKnh+4TsPSjdUFdGeBHAujZ6wgNk2UkIVHBGVYPqnFwv9N47AV1xtqDYCCqAnr0QMiTdQsVUiOLEUyEOAU52XYsOCIR1l1vEjB1tR7wXvS3ue+b9pWAD4yoNBpQrtWoCha7Y5QKkfGmKJrT9btxnWIxadmmiAuZ1TQ4GeTDyu/H0T7Q4XxMcBvofxhqEVADnJYMsNyWUauP0O5DJo90RWEpZIDK178/WuCGkTbHenAeHZ4NeFYQL4lMi3I9jUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz9JbI1OL9bUTAHhWYWwXKLCjuoD7v6Esp58gyVdZh8=;
 b=YR4nPC2W5GwPNlwqEtTW7yzA5OzVwWDT3U4r8b2rIPtjsn3Pnw3ssuh+fBsuFkBOFrt+zWXWDXuArKSfnpN7eESjO1VPKtAVsXy3cmabZp0dFfoKF8LRsn5w2fQ1nvxVSSRcIY4v+KaIBZb2WioKcf1VBZEaDomJaORKf+KD2uEmexmuJxMNlG8/LKG+VfpJhds7arCYaQAmfVhZnikm9Ipdpk2eMBiY3FSKc01hB0T4QWcSfvo9I/b5eLdrngDYHgGGtysaYgdceRON50LOkafZ5S46/XBklJEwa/Abg86wTEcReHM3+K4MvYGagq492nbHfaYuABMkTBhJqz29XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz9JbI1OL9bUTAHhWYWwXKLCjuoD7v6Esp58gyVdZh8=;
 b=tZ/HhLHDF28wRDVx+rt6JKir8e+NAeh+J7NN5TGMULCFrOwoq+ZQcCPa7N2QbicoT1/2EAjyD7wjKFIzRVB+mbNv70XK9HhvTpgw30vGVI9bSSNS6p+yI1RAf6S4LuuHWy0S/bHq1VgRYWE5OcbXJ8oggXy8KsFzR7nRBsLSZ5o8nu4llbyDuuTWwuf0yiRI9PnlWKyvb5y35FOJXNV10X89mOV9bOmmxav7dEASdsIPOWu0pHKVSCsm+jc0JyuCifPtJG5NuXsiR1iS4b8bvCjMd/NU/WTkiSw2sm6cu1wkSC/jpHr9Mv7NmZBJYvTMfZ1tc9zceHCg+8bkQMh2Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 22:06:08 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 22:06:08 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: [PATCH net-next 2/2] net: bridge: multicast: update multicast contex when vlan state gets changed
Date: Fri, 20 Dec 2024 14:06:04 -0800
Message-Id: <20241220220604.1430728-3-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220220604.1430728-1-yongwang@nvidia.com>
References: <20241220220604.1430728-1-yongwang@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b45bba5-4347-4612-7990-08dd214281eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EZAtOEwxuPETwMGYPq0ronqNT9kre5k1Isc8KXhhW/1fURlFh/1zUyG6BFF5?=
 =?us-ascii?Q?zjtDrvrlwG4v2jU0Epl8Hk7c+ZY6+pbOu8++U3ZS8LiufJMxjJVrwEkK7NTf?=
 =?us-ascii?Q?ZNIgdGFlhuAB+EAPpLTVc2EUt6EyIQiK9LErRWouwXKEDu/2k+zNb9ADn+bS?=
 =?us-ascii?Q?AiWgIb8xa+sea5v9IjWMdC18LoB/3iDzUNeasWxyi2Gxuf7AW5mHYVnCqlJT?=
 =?us-ascii?Q?U9vdCh5qdI2GmGq/imnbyh4DPrY9cLJv1DKdDVh2UMmjH9ug+tUVqIbtMNmx?=
 =?us-ascii?Q?r+BYKC3Mb2vMsxiz4NO/xP+3PhaoRxNh/ffu2QJamK74sLHJKEtwX1GP9gAl?=
 =?us-ascii?Q?3IYxAdmL+0DbW3pWTRrH5efM/vTaKVq6kdwRykhBxhm6M994ezFoNQfFf9/G?=
 =?us-ascii?Q?vxBlhP34KffvsbHTVVAd574KjuYU/LLIaRTTgUqSit6mjGyM5FbL4JPlhaWR?=
 =?us-ascii?Q?HPVkL+DSUC+nq19V64e8Xgdiq2cPMLhqv+BO1MT3I2BalPBOpyfKX8/44AAs?=
 =?us-ascii?Q?Y0yUs+2rmtnsKfzFOaJtEAL0KVHvPOpQv26y16bgAeNKD7HvgiQgpgeW1q3U?=
 =?us-ascii?Q?jwTfZScO1WMpsf/reAmyfTSEkcPUb8SbxxMgoPyvv8X+9cbTQYxxOZsnqEHr?=
 =?us-ascii?Q?yRIdl2Yzu9d3dXEtmyEBvD04pACnzSqQlJMnTIU69BwIEF4zl8YjUVJ2Cfer?=
 =?us-ascii?Q?xPBa438U1FHqaUrl02sW+M9eaGltNPK8wSVEgTdwZyh1kmcH+e/goxqHtVPR?=
 =?us-ascii?Q?3l4uJPqK+nxoA7E6FPo4gb/nCzrTHJjkP/4bYPYlDXxMRAk8LIEuuvDWajyJ?=
 =?us-ascii?Q?53v/9RZiCgqNuvmbf61tDaKCbFO9QiiZ28Q+M/4ZEYN6xLPJIT1oA8rNnH1t?=
 =?us-ascii?Q?b/jpgviCATGAaOZfLWDBGg98PEf+EqI4hZHTAKWEb/8HgR/zKOnFVj+nkCFm?=
 =?us-ascii?Q?Vx0MXgl8t2MMfJLMSa9Yo1oK+elAgqsp9/vjnTAzsoYXHL6cglwUufzKN8M1?=
 =?us-ascii?Q?BEO9U6kiVsMhqErovc54KE8y5PB5FTy5Zo1FfxvYxMCYRqmbKVMXx6XscXBl?=
 =?us-ascii?Q?hTQ/xglZ7+sB+tM1X3zIu0DvE2o1E7eNGzzLAJ8n0FQg3X5SoMATGyl5TwRJ?=
 =?us-ascii?Q?6LQR7cpJMBcAFgIHqlmFh8+5cbm91JZ9HoQHK4cpe68OeI+kJKA/OdJOQ7YF?=
 =?us-ascii?Q?iuVW61WyMCfY7testDOAvqs2NYj00WjanS+Tg9CHFLmxC+t5rfPxKCsIEbYU?=
 =?us-ascii?Q?1BsHG4xcQM+QOFKde6TQ/rwdh1ZOxOLnWrA+eEL8gD7V0VBgFk5ySMghtWPl?=
 =?us-ascii?Q?f/nGMIYtNE0koGs25uFpmsDbCEmcjG52CCQrCtrevQHLGCB/N0KlRMkzv1og?=
 =?us-ascii?Q?Iq7MCIUcFcfXxzBoBCUDx+7cLRMR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RE3ptAFry6qBJwoouREIfQVvnfcNf0JPjcoLmitYEmn3B82CjPXPYPDnBeXg?=
 =?us-ascii?Q?G7A1Tmc0JDMaOY39tGWrkdE2//Ho0s6Dsa/3kaFtKfHgNeIbbjF9SfY+TYgQ?=
 =?us-ascii?Q?iJ327VRxAMC+dIo+EVGRwhC0dRQ4mn/c0LTpmmkhfZ5AyBSTM8nTzVB5NKeQ?=
 =?us-ascii?Q?WBO6VWVoVAVtBP/Yq9zXgK15Bv3u3vcgAHAbV1dSgMb3oeOqmX50lEWdUPu2?=
 =?us-ascii?Q?vZ4CUdh8B8ShBZ4g9YaEaFDzWDAv6mCLYXLG3SueZlhXZpvrwUohKonGR9dV?=
 =?us-ascii?Q?fzxe0QlK+Z2AifqBiITziWuw8ivU4xVNM280fxowuutPIbCwotBUDhCnW4XW?=
 =?us-ascii?Q?5C4xMPWTn0RKlqTRtZ5Mn+SvGBk6eOwN4OKlWdv6MJzly37zpoLfPag1nXur?=
 =?us-ascii?Q?HwL8yuiygRFG93OUb/pcDtE1JdYIXQHkogxEydJE4+MiI17cDQE9NNNJK31i?=
 =?us-ascii?Q?ZnCFYyFkujjxDgkrjIOrVS0nSD7XGYQ33rrXmTvgl4GP4dRbO8ZGkxV+IY8P?=
 =?us-ascii?Q?188m5VnPFJo7p/C4C5bA4z1Cjt6fLRKhmQS9SybydcjKD/FcAt2/GuCd0p94?=
 =?us-ascii?Q?3WLgYE5TBDOyoJjzaM3vEohrIeOvtoxaFI/XrAX9JJOn5rqti9GhGj4t/rts?=
 =?us-ascii?Q?uMtIWX+JQlocF945fAjSYumZB6M6BeoidLnvYeci4mMbOqXfDZBLyRxDfavk?=
 =?us-ascii?Q?haLi1IoDV9ki2/5A+FbiBdd9evdUa/zDiuo2nyDuczznNvcRc7qh/n5pgRzm?=
 =?us-ascii?Q?YB18CKQugP9hFEKeVj+HiBgJEEtiS+qRxSMOjcaesnANWmD3o23ThicZ3KS3?=
 =?us-ascii?Q?8T/NH95yoIxqDdo831XPGAiUeZhEjEV6Z06xCFsZD+mdtgxK+60yMHjkCIZ6?=
 =?us-ascii?Q?pucpvuDK0ryL2OZuDZxUrqi/R+KY6GwnKK9vLdpsF3NISUlUz+Ydl2RHssgP?=
 =?us-ascii?Q?Frfz2CyP9bhIqJyAkGn7xPVNjwybzxFxvJHyzUQZIyUSENG1ArDUZN9nnNGX?=
 =?us-ascii?Q?vUaw2Wpr/QVGFeGrPFEzgOzQg42iHUJivFekPHCdO2uPjTxtJpmlS0zKnAXD?=
 =?us-ascii?Q?I5MRTYN79mX9X13zhqJogjJ2tmUtyNxNZX+0fHup/b7DXMck+vtpj++YRiDr?=
 =?us-ascii?Q?4kEqAQiN3UVxtKh2l+keWci724ZSjx2pwNpd9Hiyuc1BkAQ1zx7CDoqrhnJA?=
 =?us-ascii?Q?Gwcy4cCCOigBWb+MsjF+Tgh6AmyfDW8QTlEhr6uWBTr6jZlQcehODBnYvt5H?=
 =?us-ascii?Q?YIhQHPJv0ZXYQMdVGE1lj+u47TWHotGMElaNkQ8aoGAnbsMcl0ojGKuVfkZ8?=
 =?us-ascii?Q?hPReGa0Mw3w4g6C0BZAW/T4jbnr/sV91YpjMj3IbOHyR7ippTWEUX4snD+gP?=
 =?us-ascii?Q?/Pqtc9HpKS9IO7GCK3mPYxtkgTuRCkqwfCUvL9YJb0XHdnsnDh3MNTdWgQFF?=
 =?us-ascii?Q?XpANJngqm5BelmMwWxhzP80w9IDAh+iag5hqkTZXKh0c4002nvqaeVsK+w7N?=
 =?us-ascii?Q?OGHSmxQljRACP/UmVZjGbzmkCgUEJrhLvCaz6iHqjE0DT3EDl3hGLF5bHEbb?=
 =?us-ascii?Q?+QxMn702sOi5ybuOgQfm+BLaAIMniOjQHdRlFY72?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b45bba5-4347-4612-7990-08dd214281eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 22:06:08.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMFCPZ/65XnUhSfOFM4ezin4+qaxpfH7XGg9/PD2KMlf5MqJM8mWGV7sM9VWuVkwOOKvnwGiFSRe+bp/lvsQRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

Update br_vlan_set_state() function to enable the corresponding multicast
context when vlan state gets changed. Similar to port state, vlan state
could impact multicast behaviors such as igmp query. In the scenario,
when bridge is running with userspace STP, vlan state could be manipulated
by "bridge vlan" commands. There's the need to update the corresponding
multicast context to ensure the port query timer to continue when vlan
state gets changed to those "allowed" values like "forwarding" etc.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_mst.c       |  4 ++--
 net/bridge/br_multicast.c | 24 ++++++++++++++++++++++++
 net/bridge/br_private.h   | 10 +++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1820f09ff59c..3f24b4ee49c2 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -80,10 +80,10 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	br_vlan_set_state(v, state);
-
 	if (v->vid == vg->pvid)
 		br_vlan_set_pvid_state(vg, state);
+
+	br_vlan_set_state(v, state);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 969a68a64a7b..9da798e8c755 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4267,6 +4267,30 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
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
+	if (!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
+	if (br_vlan_state_allowed(state, true))
+		br_multicast_enable_port_ctx(&v->port_mcast_ctx);
+
+	/* Multicast is not disabled for the vlan when it goes in
+	 * blocking state because the timers will expire and stop by
+	 * themselves without sending more queries.
+	 */
+}
+
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge *br;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 29d6ec45cf41..213c910faaf0 100644
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
@@ -1862,7 +1867,9 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
+/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
+ * while br_vlan_set_state() may access data protected by multicast_lock.
+ */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 {
 	return READ_ONCE(v->state);
@@ -1871,6 +1878,7 @@ static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
+	br_multicast_update_vlan_mcast_ctx(v, state);
 }
 
 static inline u8 br_vlan_get_pvid_state(const struct net_bridge_vlan_group *vg)
-- 
2.34.1


