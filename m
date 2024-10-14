Return-Path: <netdev+bounces-135241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1E99D162
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6071C214DF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210501C75ED;
	Mon, 14 Oct 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="k5bl4O6n"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500971C2335;
	Mon, 14 Oct 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918804; cv=fail; b=n2rD8+IfkSfPS+bJ8F61sbDtat75j6HxvjJIe8yR70+WWYj6n62n9muHvV62acg8lny89YTm5euc/2EjNUihMjlHIyuqeUwRUgGN+1Fv2Pu/kUBWbQZE6SKSI/sZgQTIku84So+NtGdwnGeI4guG1tat077disyuoKoinrVPsqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918804; c=relaxed/simple;
	bh=IvbnZYuAbIJmfRjKsGI9i/M5B4xWewtEeTJCldFB2J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uc0G149GWjJBTmsTto2B7lXyAfMbisBYIb93/rWkZiX8UO9RmcJ5hfc3emQZQcVUeWpKr0mUfGx3xgwSROPFQZqg4O3iDH6bChy357ZUhnbjtPwmvYL1FQl9TqgArzDUidEEBuNDeCgKH3JYDp2HHOhYvpiwuU65FH+pxh2875g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=k5bl4O6n; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzLuowu8ANfYXFEPxEuiK0+NG1n2MP8Otv2VhOjk15ZgJvPkpE+9mLnYBqchWmMk2PWvgnfXJmUgJslr3P5r94fdFUaJYJWZJgqPVjThHR+hmANG63WzuxTqZcs7wJNqrk62k8KQgmS2rjgdTYT9YOC7fmSWklcx/hOfmc6loC2q7c2/2FIoxvDFeQ2lWZLbZqwH6j2CLFDdGlLOvSgySVIcBXUmDHFDH/9Da5rNC7SBdz4ZVr92tkHZgBJ4RYCmhNvRaoUiCoMd+ERrZVk6BvSsU5o5zM111TINeAOcgQCsUZPxlwr7ifR8GQuphzCoS75PqEzH9MbGSY9k4Q1L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/AABujRAVW/xTdIs+1sSIkUsS4ZGj00n5APkd0C1Kc=;
 b=y+VyMzZnbs5COlzAxlT4iHU7T8t4C4KkigRGadkjZdRjzq3InWOMlDUU6af8nCT5fmSTyfqYTDNhhEDCyYIYSJ8ChlZrsXIS6mTtIQuqSkMI9omdrNfiH+yyZfi+904OjYdmkry90oMhep7tjgCkhkHXXegEYXb1VmYLsdzKucKaOGwakJwJqynULgIXR0ZeUVEI28gnZ+8zA7MCRyrv2Tdk1DAELrhLcBTy+LyR+vGvKNf2L0QcbTW0fTDMB3DQQsl6o3ID2vpyslah40FXw9gitOjUiO+HZc5lDZPpXK2Sxo6k4BuAl79JQfl4hoYQrylHxxkbu2/+4LPjwrpHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/AABujRAVW/xTdIs+1sSIkUsS4ZGj00n5APkd0C1Kc=;
 b=k5bl4O6nQKp0Li/U52QNTBxnSqi8EDp5hzkqnDNhgsYpdZ+kXdNxJ3AH34MVklkoedNYC9a4IbWjdbxkecOnBDScFQAArXJGzlVPuqTI4sFmt5i6Nd/p5a6SSUQFdo5RtIHUhxBL15JovsXwK/j+/yqGA/WoOqCc3DA+iXuLVSW4Ybf7lnc1WI6GQWrFxG5/y3Q25RIXMu4yA0r2OSHLoAxcLmk58uHLZ8D6dZ6yR1qe+ZE5tvQBp8iiZ4Q67vJN7xdSNkylgF+FJaWuhi7NVSW731vIPu6HeYsUjp9AM0QUpIt2OF4msC+8s32UoUlPK6VWWVwwNNtx2aGKbtOssQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB8905.eurprd07.prod.outlook.com (2603:10a6:10:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:14 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:14 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 08/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6_mroute_getsockopt()
Date: Mon, 14 Oct 2024 17:05:54 +0200
Message-ID: <20241014151247.1902637-9-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 187f0187-9bab-404a-1622-08dcec62b9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ySFriV4mNcBUjUUpT76OplMON4VUBluHtLnYpuW3PZl8ATRXRNbjmobQmBMn?=
 =?us-ascii?Q?OzkRGc3DArQq4XUoou0mrKi9pvZNu2cmjDmmSlu+hfJUBgp/+vFB38fN5wWO?=
 =?us-ascii?Q?Y6tyAQRp0jPTrz5k31Yrj9VkATT9dUch+mYpEh/EFIBueHiyFJFRXDSG2zT8?=
 =?us-ascii?Q?nzgi/wwbTjhoGhxn62ZhOUT0FK0IiwDbEbz1m3wty6pHfDl9NiWMCDR/vUaa?=
 =?us-ascii?Q?a3jXoKxNL+6U7OluueLvKfCvQQB11C3yMa0W7V11TP1G69itkd8mIeL0/vb6?=
 =?us-ascii?Q?m/D7FY85pfilMNcYKdXWUTCa19vak9nch7XjUcSNyYB2NmCmJ1f1HR6RBG62?=
 =?us-ascii?Q?gtEhb43jhCgOVbq2mjfJ9u20vEso5MJCShRc+Bzag384Ow2W4mB+RU+yOwuh?=
 =?us-ascii?Q?mijILL5ILEzhCHB9Vd6LiPU7444Ft4xqzkEfmYPHQK8+vWh0ONMYOHJ2FOaK?=
 =?us-ascii?Q?X48Gnl+3gsa0CYAQlUhnontcPw+LMXKwXyWwsiAUiMc1U6K1D+JdWS2tepTk?=
 =?us-ascii?Q?s9rcXUSB6Z+CSm0JajwPu0/FAulI5kDIK9I7fAozZYxjGBBS9VPSl8sS74qg?=
 =?us-ascii?Q?D5dTqDonQa3wHpuLaqNEK86XA5LJpVeLuoI4lT/FlXclbkozAm7hYa0w3CYu?=
 =?us-ascii?Q?287NFJrKw5ws5WIYB7DHgi9rjgbZrq9G1WlwFNH6Es7srzZ3PE/Ir3Ajxfq9?=
 =?us-ascii?Q?R0qJZlNTNvgfSM318hx/1nVJMU2ZLc/TpxkaHQletwK8qPWyH63w9xuOAVu4?=
 =?us-ascii?Q?/zW2srQXpn3V1+sLnHQUAK+X5CdJi4rTEXwachVzpfAWrQlAd4H2mJIp4mrM?=
 =?us-ascii?Q?0Z2zbYPoX5Kl230vsD4lEgDMe3bC0MyTEqCRUC3kPRV2BBJZtT7s00iUM23p?=
 =?us-ascii?Q?E03Ay5oLGE3WKDLIoaxYI9+q7JQxG3RvuYwn6lDmYwcB4hysbZB+w9d2FG7K?=
 =?us-ascii?Q?zIBad+B15oAb6IJGvcLY8AgtFzbr3bN/UyWKxRPBH2XDKMP0uV84to5XU7YY?=
 =?us-ascii?Q?1nOvfIjysyjzu+plkCpItgZGqRBz8JwnkxGIbJMZkVgdjPEv8k5mi9yC7Drz?=
 =?us-ascii?Q?SIkzEuhbOgC3pn4Td6UrxSubCXOzJi7ASGe1JqTADFBA5S/Q5E7DuAOY/m7f?=
 =?us-ascii?Q?ggC/LcjBHeZtvvew7Udab5onwxWeg46tJKK/kcg5YhbmGiJU/QVWPvjVz762?=
 =?us-ascii?Q?WfbCAALv3luQohweL0ZEcdXSaMY06e0AEoM0TSGpH2w8R8ipK0H86JANZtL0?=
 =?us-ascii?Q?I6u2YP7it/tIwwwAsBarI+jvinI3Bp2ELyQlktEMeAz8qBq9+vN56RGkscYV?=
 =?us-ascii?Q?RMzcUZrPFdtmHZFMsw1MNInIiTuOJ4UHUB5GRgkVsnajYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNoUk/A7jRYY8HssvO0y16C5owZUWti1kEfXbMv+LgiQ0XGIAc9CVAjvG5w2?=
 =?us-ascii?Q?fmHv8MFvdteHW9eVh3NrRcxSGvg/M4SOwh+GxDykymcdbwVtk/LPORG91sUE?=
 =?us-ascii?Q?VGImsbCdiRVQ8AIQSQltAOtpANDDWKkdZseYAbjtQ8PO7J2/SMJbYiFScG+B?=
 =?us-ascii?Q?VPVIhrSOKz94YB8yBRKY6E4b/QXi6onZp4BbpTgOvVErJkyt3sntdr/Q303n?=
 =?us-ascii?Q?yTEDRJzGmpofMcS25Ma8+I79XUWmuCyA58VnX/Bl9Ur6BWL39/RhEwxotW8w?=
 =?us-ascii?Q?MgMLsyj3OE15fEhk11OAYnb6SR70LUHzt0SGqedJYbxbgqlYUyA4SWMpmbdn?=
 =?us-ascii?Q?hiyAH0GjKvgJCcbJ0vCsPT8and9PbC8qLF64YqGDa+EDN738Ys0Fmuhi/GbK?=
 =?us-ascii?Q?oEe+H5oWue7qn2FskP4smJGvnPkWIzOm3UcnDCKFzuaeQGkubaqFeNoWTCtz?=
 =?us-ascii?Q?cm/0J3qd2fp/3wvgt7k4RFTIb+vSXYg0OMNyD3ZFoL/tn9n4DwIA1LFoJ9I+?=
 =?us-ascii?Q?tl9W8jzO7VC4/ydyLv6PRCnzIKP56SNOK2f4HojjH/EqoFDTB0PO1/CmsgUl?=
 =?us-ascii?Q?5OBMPAYIX4ZVUJxFWgF3xrELMnjZyhWuFt3xgLW8xxouFjfPsSdnH3OTHZEW?=
 =?us-ascii?Q?6I6IVzfHTfg2W/iwCjpb73t2z/3y7IEM11IVgbHP6fbttIEFuP0OcdIwHUxD?=
 =?us-ascii?Q?aWUTJ5898Cj0i+xJ/rQ3+3ecG4wP//85ExzL4KoUsCQ414L/fgCr4kHU+SMc?=
 =?us-ascii?Q?OELSh8OVhvEio0uJFsFOYsCNAzKzs7uwA3quSxIFh33YtlPz0RmlkgEsJ3Oq?=
 =?us-ascii?Q?sc+kqEnf7bdYcQg1idfu/o23O6QSh1rctut+btchBi76QZDSuIM+btEOsW9F?=
 =?us-ascii?Q?gvxK7YmtzeDBd63eihfcOUUyFgSdtxzltuvgCMde2ZctxhFMBlzNh24NFTsZ?=
 =?us-ascii?Q?DJ8+AL6/bcC40JYC6wOrmSxNiOFqCqOyfMUMkG7MloPBAyFePlazqUg06Y0S?=
 =?us-ascii?Q?qxq6AC6ZG/QZabFDEkeyFobtpW1haVjdqbkDgt9gczeJV4pZWIcze1OOwwR0?=
 =?us-ascii?Q?tx8/v8Fr+nwgvOq9uuJf2BJHrfrNwOovy8NtpE6nChx/xu+cGSTgoYel461b?=
 =?us-ascii?Q?VNCfSgavN29N3srm/zYvZwEHLv8zfTI9IjbPVPzAqXTEefdqQQwM8uV+Lo67?=
 =?us-ascii?Q?Pc5soTC4n6TjLGedFlaSYnFjo3oefhOZZgB07TVa40hIhVLga0tvP9n6bXd/?=
 =?us-ascii?Q?neQ2ZI2MFN+LIWlEjPQyC1fN2e/NC8n2i6pJ8glmHERBuyrhdXENveZIIP6H?=
 =?us-ascii?Q?0+FHHp1xy9uify7BpMvaqa9gltGR29GcdGpzZM9PBwaoaqS/kpSMOeqy7+9u?=
 =?us-ascii?Q?gfOGYiQY+3/JZLrwwy3SuSWmHWkvykzG2VmmMMIhend97rCUq/RnBMgA3bcx?=
 =?us-ascii?Q?jbsVVE2RgpZeOjZ8fMvcofffc4EMyx4wvyOHxmHSfalTKZZWQnWEK7b+NJ0+?=
 =?us-ascii?Q?XyVocoh3gf0tGhH0QJoiXGkEtfUnjIbNT6+152mP6f7zOxErJAdSExw+9seq?=
 =?us-ascii?Q?Dhzyh+S34J3Obs4zN/eM1t7WGvuVQYR9u0lWUOznf/gyr9xn8sMwUXlOtbsx?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187f0187-9bab-404a-1622-08dcec62b9a0
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:14.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHLEevHPCFohHz50W4twuuQhw7n+vZLF9eXpk1TuJ1z3NUEUJOa6+oKbh7UpGyDhe0y/FQB8Sq2LR+reFK8dB7PiGxzdBPOm+NIzgru4jXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8905

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b54353bee2f8..af921e9731ec 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1845,7 +1845,9 @@ int ip6_mroute_getsockopt(struct sock *sk, int optname, sockptr_t optval,
 	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
 		return -EOPNOTSUPP;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	rcu_read_unlock();
 	if (!mrt)
 		return -ENOENT;
 
-- 
2.42.0


