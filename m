Return-Path: <netdev+bounces-134129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A49981C5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D591C23239
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF151BDA9A;
	Thu, 10 Oct 2024 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="onWY8W0J"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FAA1B5337;
	Thu, 10 Oct 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551535; cv=fail; b=oKMGMFYN7Dxe5lRSsILOcN94/1dn0QM0ZJCgx0tPRPSOMHPfP/QH3Ya9NCI88QgR3YSCDjmf/hvDLWfaARvjDMNp2lwqxjG97kkVHHBmodp+PZv3VTlf4pXyNoI7lKIEaVI/u4pMfNSN/J8Gr/A24+2ucToPuadCtacom+3th6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551535; c=relaxed/simple;
	bh=HGtka4HLM6n8ER8CwfiJfSkKXmuw1ZiOGTCJnElYHxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayMdF6EMV2QbWa6MrxhaSQIfeWRBy9m4B/56BXD2YVOTd5bG3nTKqz11M8WJDh+xp+lubqOvC54xby9kLQVNqiPQn6OooL146HB+doeZxf9CzNZtoSw8BeZ6wFYKhaZGgtDDUSRnLkaJ061jDNt6MTU3NFJBDt2kb2xZW1dvfh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=onWY8W0J; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0/LQ+IuV1uZMdnsRQKS1T+LV4kR2tcS9mwK99fQj8m6QmknGt/lq4WdxFWk4EaJP896OCAawWGQlXKQ9IDLlYertsWLkDs/P0UuPSHn6b8G6Jkyxp5+V77SXEn7T9gW6f29yvf/srjNA/7eOjLPwxoILHF0eW3z/KP+ygw3YWvkzCKjwM8PezBLPtfLK97sLxqx9VjjLoDH2SxycXesw9emX83IBWh6uM0TQvV9quB6EQPu/GQ4zWuL08BK1Em79IQGtHNeh1nhDbO2z31KMl2NbLKviyBHgo+XLIKBavTxhXZoKKbXAJEr4u1vxNUIN69Ne0HZEFqbBUPq6vrt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EE9j6S/0qGV93YmOkgse62HQd3fdQyz/hUR6ip68DM=;
 b=qRKx9Jqe0UMSRImfi4oJ+bsdOKWqAIZM38vof6//+p+XXsvgeVPK5T2IO5UwmdwUGnt3Bxh8jXABR5rIm5tJYsKDaOoI9e9GxybSfWVQlNa/aV2Jp1tNiw9dFWKZAUZjDGAL1g0xVqZ1ektVwWFl8F4wj4MLX2tp+8xPkc1evggSmwStTZL/+07K51tD7RbRn5JWNpXHw+gJW86YeEsyBcsTsMEQJWp6TViMxyAZKDdvkO7MtJrNcSQj5K+xYemQTUCeWaokqdDSp1HkdmlYLMv2mW66TS6ZWAWJuiLnxO69J9SZqFfKSGqXfk8zPaSIZ7T1PLE524L1fCK4OfY9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EE9j6S/0qGV93YmOkgse62HQd3fdQyz/hUR6ip68DM=;
 b=onWY8W0JWp/vHFVwopWgpg4aDPC9Yskw/TrOKvVgip8fQOd7/iV+pWH5NOW4W3Pcq9OkCcFGZuCtCWJMIHVA9jK92zB6+zaZxA9wZJTNrK5BvzEpjv41llAVOkPBi0262APCV9CeMSx/6SErguLQ19kY6WPThiYi6jWsaawDY+UsWGuFAhQ0Bun715xiJgOxGZspqm53vIHcRUoaoWvmgzf1W56zuiZC1y2DHrmTEWl/2RK244WXVKbUY84bgcZ640pE7x7K/6AlB34eUstF9kfnHyoLjUNE7wXFqWZL1XNIo7AOCkwKcesuzbEcbooZZSAIV/oTKBv0eU4jz2eO8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS4PR07MB9630.eurprd07.prod.outlook.com (2603:10a6:20b:4fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 09:12:09 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 09:12:09 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v3 3/4] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_compat_ioctl()
Date: Thu, 10 Oct 2024 11:07:44 +0200
Message-ID: <20241010090741.1980100-7-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS4PR07MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a522fa2-29cd-438c-108c-08dce90b9e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yrtgoShKAsdjX8i07MGKfREKCzI+Rms31yBtlMkDh7PtAyoaMCkf96VlygX+?=
 =?us-ascii?Q?5WB5ntyChzUfYqZsHJhHOFBNILJe5qsMxcdPw0E3GAkEokxXy504Gi7VNYhy?=
 =?us-ascii?Q?wSPMVscJuIOv05wZijX7acBkHa+FfEpvlpDIuz4o2iQvjG5GXlkE1PpWfYRo?=
 =?us-ascii?Q?Y/zsHNbub2apnasR9aR3TecDuMRuTtBjVC/5vtaM+ZBgQ48Bd3OyN7q5GgwG?=
 =?us-ascii?Q?6Vy0V0w87YNmaTFtvkf36CZLzXMG4Cuk4dZIQOrOeMaDlfSjIJPMN107qWP9?=
 =?us-ascii?Q?haExEShIbyjG4wkfhTReL90e9EQrZSauMgZ4xfJH7bV/9paghJIiyHRlgXWx?=
 =?us-ascii?Q?sAa61tG6Z8t9XK8Ie5x4hkwPxOA6Z367YSSd+wWQOB0Hz4P/tlNu6p2w1Rm5?=
 =?us-ascii?Q?I/Yd0sU0GtrLMFfGO1+jOyhB1FnWRBNDxNxiVIUia3nJJOCeDJxDHx040V7N?=
 =?us-ascii?Q?V8kZgLlUsMzx8IwRbhKq5v658GowxqoeulBBN1ei8jUECLkWgd417ja9K6jI?=
 =?us-ascii?Q?gKx+RkfxwB3mKqKBU5YaFQBkQf0evMMnjWYX2OJYwQYLYFrJqoTrAititbI+?=
 =?us-ascii?Q?WHCKjAXGPD1uHP4eCb0YBX7hNGN3H6lk5Afk5OV/Cl/g+L2GdStJJk0rBHRL?=
 =?us-ascii?Q?ESoGJ1NYFX9K9BGVF77v5SpNUFbzKN18RIwHtM+f66C6RZcqhTbQrQFmR/zZ?=
 =?us-ascii?Q?GSRTCn62RuoXi2AR8NH1lkgN5H24hoRBUqTUKAwiROQ4qkLAxz0lzg96ENBc?=
 =?us-ascii?Q?U48CqoSaV5qJCo31jpP/xGS2Khp845IKPaoX+n8mKNxoJ0/Al/Apu2O6V2Pu?=
 =?us-ascii?Q?J44uinUq0kaH4QYlu6JMkkDVhl4cv4+QRVcJ4oRGHVR2ZUjjIPH7tfrmHiVc?=
 =?us-ascii?Q?ZrtHhdSugo54n35GM5DsFRINHftAECtIKdZNsA6WtL/+Fs1aaCgBG+R8RJsg?=
 =?us-ascii?Q?Y8khCVhwvavYDw7t+Z7PQh8EvyVrZUe4JUPTQMveXCkyCZC11jm95hDckjO5?=
 =?us-ascii?Q?xUy0h0n0xk1zsiAIr0ARYsEFvm4HQuDeSuHYHBbQD7H9QbkT+Fto3GyevuPT?=
 =?us-ascii?Q?sna6dg/chmvusyfE6fXxBse3BrX8dxmDDNMM2Z34CXwOQXVbGSuG58jsAP9D?=
 =?us-ascii?Q?UpB+3DjLjmsY8u38ChyfXKl4hTmIw1AsaorbA7nQfshCqe6x//c74zhNooh0?=
 =?us-ascii?Q?mA1q+GyNPOPw+xHCBPWiQIeoGvqldaKSft4jbc7WNoJ5Yzr3ypibr5v22hCK?=
 =?us-ascii?Q?8C0eR+NUS7NzY/pOuLTV9mCnKU1b8f71H+4bG+GIiWPMtcp/qJ1j7H5atZ6E?=
 =?us-ascii?Q?xXyjISdORgSsELLT8d2iFTI4w5TbZfPkcoKh+BE4dh9LJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?msykVHLB/M0fW5FOt9iE82wYzjtmuLGyXOvU6JC6YwaA0dsAnh6g2ak1GwMI?=
 =?us-ascii?Q?7GzkboDoA0b6+htlIX0c+IE3LUgLVGqme5UzdlBQX+5JUfmj/hoVFxvS8YoY?=
 =?us-ascii?Q?OwVREve4H6rpEu019Nr5xsYDWn//w7cs1AG955Fybcwn5fnoR+c0JhFwrD4t?=
 =?us-ascii?Q?4T9txMg2FJx0g9EKHU3c/faCeD+x/jlEi1/Vc5pnXtCE+ChrUTR0oBXhH4MX?=
 =?us-ascii?Q?x1CcNQrasNOvtjUu/uc2sV0mbWmWTZ45n4FIdF8MatIc5nPLZxkbzESsJVuK?=
 =?us-ascii?Q?N8HddsTA0wyrXArdyULMSM0EwHvT2VbDyR/lW29htNakXlsnYoKuCydqtjF2?=
 =?us-ascii?Q?HW5nG3I0pG+CJS6810HpWw5OJAKlwSp0JhJJmK2b9JyTO3YhPR/zr8s5rLrj?=
 =?us-ascii?Q?LuAauxrwh6rhXmwsysXYSqVGfiyAMWChOlsi5ehAlY3m20tpYUF0woImPAnf?=
 =?us-ascii?Q?hUECBvAmRFFXQs1NAR4Yoim593ZY/hfvVDaVWUSngOmlespSCEf5Vghe0NAR?=
 =?us-ascii?Q?1ONe8Sy5lKQmq+3Q7Sv4xjmGXRtQ0qf9phaglA1feZPxgpHkYjMzBmW64IZp?=
 =?us-ascii?Q?ehNsO4oOgc0oHRoZ1Oq3p6Osr0MvDZ1p7+y35hQaGlH/D18bHXtR0s5ecVHB?=
 =?us-ascii?Q?d/Vf4x+hoITuBXRirqNMVrzVHPSxEiBP5Y2Vnwuj9sJ5SSXCfFdAT94as9pY?=
 =?us-ascii?Q?PxrJK6nlr4HJZwl9QNOmwNnoZpyRvFVXO1vq4K8hXBKHRV7kiljlzMvPT/te?=
 =?us-ascii?Q?fKxs0iER8rSrWq3pAtbHk3jefGIjyt58zeEIRdfRu0fQHVfSoGFfFu+Yc2qP?=
 =?us-ascii?Q?4WeGQs36MxMoMW/qOz8HXS87avaV75VnKJdssGbWMaWN1sjY8gY/387NJCZb?=
 =?us-ascii?Q?ifKq4sKSPYrLcuMQuhw1tnPzYchaCSqrfc646Q4T1wcB5AzPXiNQBx1BOd+N?=
 =?us-ascii?Q?If72wH0vSUVTZZjFmyjNWYK24Zp//Qq4CQ3X2IbFGGTrjSmwTFJgxLOyf3zg?=
 =?us-ascii?Q?M6ai2CZVQThxsOhGRQ+Np1siNdduD9PGFYDgMFs/5LEvJlySpSduKiXOaNfx?=
 =?us-ascii?Q?G6s7Ea18DyBtLOCgQBaPLn1IbfpB+ic/VfPGt37rCCqRdHxv3pDvyvUWLpxb?=
 =?us-ascii?Q?Kk5WQXCJXkvKDMMIv8MXQCivFgtU4+I67JApQN6BHHpp4zti+QmLK+aNizZ5?=
 =?us-ascii?Q?I0reI5fAe3FbIkBPxZLn3BEqUGK65GNlFP1PZD1nk7onZlPQU0cbHhw8ns/o?=
 =?us-ascii?Q?GbYdNEJLZGxnYssj8PSw96JYn+bmSE2N+/Y4X4JRDZNk5KUh4F7y28ViNQhn?=
 =?us-ascii?Q?y/GL1Ne00DSlHaBSoYbLhBpOwiNdG+NGIrA0dnw9tKCoXa81lqVQhaE6az7E?=
 =?us-ascii?Q?Zbnf8k0giTY0Ft5P1XsvMigNgVsl0CP43VgZSit9YcrqVW484MHrdepUE7sa?=
 =?us-ascii?Q?/ofVSedkJMw8KJsV9G9kFwpdXUYdBpO0huidWDTMXutxaqI1nouoM5oEJtv0?=
 =?us-ascii?Q?jWH6bQmc+yj5jYYH0IVT1qmqNKhvtN9TNDnHpmaCJl9/2KMoMo232ldaZ+r4?=
 =?us-ascii?Q?h8qjhQUzYvCPiSKEDiusMIuhP/685gs7bWXay0ttLMDCeV5MQTqIxaW0mJFj?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a522fa2-29cd-438c-108c-08dce90b9e97
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:12:09.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2483V1JeKd65J4cb9q1wlhXsLAhl5D7dnoeO48cwp18uJZbeQCGc9/xyS0l/owqqpCQa+6MiQ9GwRK6HFlpwzh5SjcxZHxU5RVu2RDS34Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9630

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
must be done under RCU or RTNL lock. Copy from user space must be
performed beforehand as we are not allowed to sleep under RCU lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
v3:
  - split into separate patches
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
---
 net/ipv6/ip6mr.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b18eb4ad21e4..415ba6f55a44 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1961,10 +1961,7 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct mfc6_cache *c;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
-
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	int err;
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
@@ -1972,8 +1969,30 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			return -EFAULT;
 		if (vr.mifi >= mrt->maxvif)
 			return -EINVAL;
+		break;
+	case SIOCGETSGCNT_IN6:
+		if (copy_from_user(&sr, arg, sizeof(sr)))
+			return -EFAULT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+
+	rcu_read_lock();
+	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	switch (cmd) {
+	case SIOCGETMIFCNT_IN6:
+		if (vr.mifi >= mrt->maxvif) {
+			err = -EINVAL;
+			goto out;
+		}
 		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr.mifi];
 		if (VIF_EXISTS(mrt, vr.mifi)) {
 			vr.icount = READ_ONCE(vif->pkt_in);
@@ -1987,12 +2006,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 			return 0;
 		}
 		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	case SIOCGETSGCNT_IN6:
-		if (copy_from_user(&sr, arg, sizeof(sr)))
-			return -EFAULT;
-
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
 			sr.pktcnt = c->_c.mfc_un.res.pkt;
@@ -2004,11 +2020,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 				return -EFAULT;
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
-	default:
-		return -ENOIOCTLCMD;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	}
+
+out:
+	rcu_read_unlock();
+	return err;
 }
 #endif
 
-- 
2.42.0


