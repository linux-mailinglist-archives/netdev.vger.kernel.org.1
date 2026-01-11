Return-Path: <netdev+bounces-248802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F5D0ED0F
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFFDA301225B
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5C333451;
	Sun, 11 Jan 2026 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R93tC2bH"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8053339863
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133359; cv=fail; b=ap/sNRVmlQb98Oz96MTwSQbrVvVPqyWZlZ7s9ILe9EKCB7WOVS+xw6iWHeh+/FnUrven97FtUStRcKb6C6oI/EXiY53D00+hW7OrYWn0rFfM0Chw9+Y1znp6i31Tr3S+yCi2PHmtNZl++nn5cqm4JyVySopXIJQjaFm1bWkI1dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133359; c=relaxed/simple;
	bh=yl069gG1yR9KoLv0FDnEPckwWZum+Cbp+5o4B89C8Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q079uMo9Md7LcVdVUbHJ5qrjRzDPnL0XXykwjX5dynEUkOZaASpJfCOyqKL6YXMARDbnkpmcVJkGJpQS66r9UlcdzxprtMwpJThHdVemHSThqk9sYHXYo6CBc3nwrWd2KOxnOxmqPtnJ3SPKn+x0xPzfUWweXmlZTtfWMa3Ssx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R93tC2bH; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekqoIljLMP8k22FVhnI1FeCF86eqJNcTDMUyO8QSbYabRdwlKUsd0yg2zi51ONTFSQcTRErGIhwL5KbMpWNYeaGSM2fTWorI7m+UMVJnm2FOUMhtNcTJOgbXsNrlFg9zhDC3pDbYSkiorhRgHhj9ttJoUwWtkLNo321TKDbiXGpMznYacADfo2SdNed+H8rieT98ZBBgF5mr36FgvSPMcERCFFejSlZeCpEGKHHWGKtVmzu9ZtbVyjBehjw/BNwqkbU8DZaSIiZGVSeWsmbkfTuS8aQDTLOXBEYo6/ggofyrqWpXBg6A4D5AS28O+SzIc5Ldm+BuEU8n/jvalMBolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx4ySHj4mo2nH/AYQgVcJJ4ywusNsoC/NIuvCo5sW7A=;
 b=EdcZtqyjAa3oL3nkzD1NVtWara1Cw18RWPanHY4f75Pib5VNMsrZW7to0XyRnLyD4oXsH1DmQx70FHBiNJYSrnzsANIz4yN/GAZfHuD1TvbfFnKiEzcuLFqDgQTR07ufzEBKWBSwYEH1gwviqK2x1sBWcgPiTauMYmk01BMgNO44SkedAFOGtkIncQdFRq+BdCec4sbquSzAzTr9dFv4TGid5cmd3cXRRD9gwtkdRE2qp8/ADfPFPkhsQWya4mTB8UqGkYvdNk/mCqtA3t0YfOhLZTn7YlP5F/QtPFSLXxEbmsUrAJZny6LP28ElMrbA9BWlIcuoMFrEKpDotI2lkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx4ySHj4mo2nH/AYQgVcJJ4ywusNsoC/NIuvCo5sW7A=;
 b=R93tC2bHhatOWuIRrw+W1OGFiXU5MSw04iuY8O8P+ibZWtvkLxrby9dSVTZ4N6eGsNSSZCTiP6SBaZ9vE66befu2gzfoPdOi4ypqzQ/4wmThN7Idwsmq1y6l9b/Z7Oys/hyvpmfagAZFp9efQ4FH6ZJwlzu0Nc374P98Lhm1ItGhB3QXxEyl/zgIj6XUE4OOe6Sh9yoq/ceJGaoZWZIxtu4fg1CvO9fGkB3IgafDo10rMUZ+R5Y/IeisDEwTwanGu7trJZW/hXJrKL2DBxEscpjx/TJEZPwRk2RkfodU/eRsHqlda/nCZFomTCyeTp0KhMY76lMpCst5tbfbS0REcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 12:09:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:09:14 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/5] selftests: fib-onlink: Add a test case for IPv4 multicast gateway
Date: Sun, 11 Jan 2026 14:08:11 +0200
Message-ID: <20260111120813.159799-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111120813.159799-1-idosch@nvidia.com>
References: <20260111120813.159799-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f1b071-de54-4d30-aea0-08de510a3c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49yp/+2bX1igh322J07RDN9P3stGIRuaIDmMy4gab8+RGCuabn+Z6VpnfuNN?=
 =?us-ascii?Q?bEMGdh9aNotWR0lWf2mVhrk7AtOxrq1ZpxO3oqlSoC18STbiL3JshP5qWt2D?=
 =?us-ascii?Q?+FeR/JXAZV0KyftDSxo2co/BrPcE/3KreO55IBv2N2l8MzYZL+oTmPtpTKWs?=
 =?us-ascii?Q?BwiVzPronHSuTYZzV8vx+E5Xv0yp/sJk8WoUag8xt/s5A6kw1sdeQG6F5B/0?=
 =?us-ascii?Q?JV8w8j8TbeaRD/rx8te78kT7pdcdCecZLltBp5mVvcjldvd01vajuif6Syaz?=
 =?us-ascii?Q?Vk0pe+QK5aa+dSyZAL/ecnh+JV3X8moVeDxpiq3+h4KwlLefuzUemqlUaj/k?=
 =?us-ascii?Q?S4cctZEYNXjuv/3UlGKEhlbbe7CgNjG9j4pai5m0gZQ+m7MtDzuym9XcNSF0?=
 =?us-ascii?Q?uikhB+JaVCYMIhC46jiX69GVq4fPz66IFFpCHkIEGhABGTSlaf6GdoyTLw3j?=
 =?us-ascii?Q?hsJiRlGqL/wdYT5sTyjRHEpl+dJFF7Cg5PolP4wDVPKKKE80fYm+uxXaVSjR?=
 =?us-ascii?Q?7T6N+0brjZgXn6uF1/UdbMsioDuxQDyxB1/iu1ikx48dRHBVKY+1ytOJDLZp?=
 =?us-ascii?Q?jG4rJmQYFngi1+3gSuxj2TTnRbSbkfrd+2D0K10Jb7rwX3k9ov6U0qwp4vIV?=
 =?us-ascii?Q?9KgfngEqHm81BgWQkDaNKz/vjKDmMRx6p6lKFNWS4QIBey0mKeJjz57QOpVF?=
 =?us-ascii?Q?21v/e2ckVCAf46cB3J3zDhU+GnlOQSAxFZuU35Buk0+YG+j3v0CrLFXXDeF1?=
 =?us-ascii?Q?Gr2wAG3N9+NcT8Ykwfr2AjoBQt/zU7WmhlsLKd3LLBmJcsUOZQTftVdOkDGT?=
 =?us-ascii?Q?8IsbNE/JQAxuk9L/7a50EPLGYJPv+fHTbFrVDIojzIM6oWQnLIYIagdyn6qY?=
 =?us-ascii?Q?maxXD3TikjcpACsZH5tIqF9j5k8hXQQSEcFjNa8LSrIQnp1GaDzGqBSQZaKm?=
 =?us-ascii?Q?fDH1/qoTwXfRx3DlWPEPCQl6m99fKkf3Gpa2lsmPY80t7LlT9+Jxhtn+ST/F?=
 =?us-ascii?Q?SF0Fp74dlewWKlW5LsC68SdSmopXvB3gIbyTBNn6Lp54mh97XMS5kcktl5M+?=
 =?us-ascii?Q?EKIMjc/KlPObdmtnBnku/O6FuimCOrJIsGA/fUoWPcdyJUWZ619seIXoSVbQ?=
 =?us-ascii?Q?x+y8abDXESmtLgWG0qz4Al4vY+XJGFhpwK5pea/kwZ68LOvHuXQjOGv58gC7?=
 =?us-ascii?Q?Wc67XIIrSCKdvn2LTWBcdYJL8MabvvbQ6Vl3LhPVc+W8iwvEAVyXAuNH9SYf?=
 =?us-ascii?Q?RC6q1gEzuZozfMMqQxsQEpR5+YxUxeA9G4H2ocuRVdbPM9Rv5uHwQ+YOQWjt?=
 =?us-ascii?Q?OynuW9wLFzv/mqDgJpqmuD+OnU3PR1+STNNav8VFXRDsXcCLrI9QCnWbEpFh?=
 =?us-ascii?Q?ipKOgsELFyO3VGxq73J8xKn4n65TPIzy2zQda/wZ37AthporvN5v7fJ8OSlX?=
 =?us-ascii?Q?hhabORETFWuFfF3ThLzn3Nbl3EktzXIm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENsBn7jonsBJGalAF20JEUYymextR/01X1q+cwVk1PPlwpy1UzTdkPRj3/Rt?=
 =?us-ascii?Q?WUA2tvzkbbvqsR0BmekBycBMmXITwG3rgF0aNyELlpOKXFkr5BXKs0fqXZHs?=
 =?us-ascii?Q?GWMtlbpKt9rfal5KXpYAUKcfZlydjBzFCKcNDjgUB+8qVhZfppsM3qbOBUAN?=
 =?us-ascii?Q?F9VmMuSqXt5MYx55boG7bw382jaCKP8mOs9z/KsVu1duoN3tWS/5xi1XXi7h?=
 =?us-ascii?Q?XrAvg8+FD8QK+VuVKDzqREw9KEjPVTgZqG2uqKdPuL3r7KaqXNVLaq9jvT43?=
 =?us-ascii?Q?o9rpCvoOv2qvowEyDCly7FXLI5wdnNJ7mEqDhXOCGGHkyBuUYlr48IW9NFlH?=
 =?us-ascii?Q?CUOgGeWOR0jP7UscGHGIz5WP5FtIeSj1jYmlAM9s39mC4r7QjOLAbbNCXMxU?=
 =?us-ascii?Q?p5EOGkc61OKZ6FjjSZp8XYNAVb8QNIBnSdjUuiNx3l8Mulg+bdQ1L/IVIHnk?=
 =?us-ascii?Q?qHuULU58yZWppMFSQJta28Bz3Ia9VBnZgiGJeZumzAfOayGvkFXWOqlHzCtp?=
 =?us-ascii?Q?aZp0EXq/JKfnayPpP+yOYR9bmjkkqqhKjagdmVAaJA6Wmio1NN6uD5RNH7er?=
 =?us-ascii?Q?0kCLmoXGWs2A8zWIOymV62zAIl161rBaqVxwDlGpHP2s2zQVfj7iFUzlqeFk?=
 =?us-ascii?Q?j0a21bto0f2tRm2V+RdkZRBWsB3zJMa24ZSAKXBi2nxj6mYZ2fW1q/MN/x6I?=
 =?us-ascii?Q?bgg+mMwucP5RCmqwwa3xyaZj+/O0cjY97XNxu+GCSCxiZiiQTh0mRmR6Wzej?=
 =?us-ascii?Q?2pqHmAUO91arPSbg8CAb9YeUgWgsNazsnY+5fAweftYszGeCoCvIWa6IOvEd?=
 =?us-ascii?Q?x+vG0SGl0w2nJFNSs8m1Tvr39kkpXrjDtXb6WEhkfHTnStFd3TLGu/zpX50e?=
 =?us-ascii?Q?PtiYKx3QLHvNXypMRcxRVq4rzMscvND78607DLg9s4BZd1X1bkoUE0rWUCng?=
 =?us-ascii?Q?nuGYCgyvuNlRmmX1raGLLl5XCHdeG8xXjVfUzkKX/P3R1snQHCxoDxZ665xA?=
 =?us-ascii?Q?9U2aZv4garsnxQyYrsoxLojuXbI6YL8pdDKabb3qXYR4r1bU8E4OoEVLip5W?=
 =?us-ascii?Q?jgyGcUBr0Fbv7bqX0C0S9Y1P5xK7C99Z8DHKANXWZMU5Vhu4yX9olh/X3lUL?=
 =?us-ascii?Q?g5IWaX7bGlagnR1fkG3FGvNRh3QhuXKgKgidD/B6doZED68bg6SdTrM9rCF3?=
 =?us-ascii?Q?bmFmI/g+6APOH8mBgzTRtDfjg2PkEihUFRRz5EQBeWkK4q+COe5w7QtzyBCo?=
 =?us-ascii?Q?wrHY0Di2X12/eMeFKm6p4fPlQ03oMWuMiCP+OK3Ru0tZEpKvc7HFxjc8mHig?=
 =?us-ascii?Q?XQNGxSb438kb91T0f9/qn8NypGvALynV8a4qJ+z6BnC5/ox8TWSOz2kQB9ZM?=
 =?us-ascii?Q?VHa7aEAiXlj4KtKn/SNVJODDATVFpVQ1Dmi6qIqKFMcso6CWuNLHqPXDM9Wj?=
 =?us-ascii?Q?M7gx4PAnyaKw7M4MGwriaWijSGdlWkAMkSDN8hAPEcQ3qOC933/3q0nGhR4K?=
 =?us-ascii?Q?EJybyaaCQ3zR1YzX9mF9xqv0wSAtl7JVj11AU4HKGNyozw6M9Fb2daROPUp8?=
 =?us-ascii?Q?KcXkRlBExqI1/Pn4ZGGE+eu5TLTSBM3026KHC6OVF04afJ4bwgiFhVByRijA?=
 =?us-ascii?Q?2qbC2CQJkUCjfKHe6wqvt3SEBH3oD9VlqD366wmtk/EBZ136hVYpxzG131gk?=
 =?us-ascii?Q?O35zNxa4NJ9VZzITjUez7bDU90lNvVZOSBQnOODErgnftgQA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f1b071-de54-4d30-aea0-08de510a3c9e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 12:09:14.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjZAMZK8bZN0D/0WRlqx9BY0ZRDf7QfDmFvLjuwg4MNCmdQjAPKtANDrl4GZQZVfBEseAuA5XUBtIXQ9JZqxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

A multicast gateway address should be rejected when "onlink" is
specified, but it is only tested as part of the IPv6 tests. Add an
equivalent IPv4 test.

 # ./fib-onlink-tests.sh -v
 [...]
 COMMAND: ip ro add table 254 169.254.101.12/32 via 233.252.0.1 dev veth1 onlink
 Error: Nexthop has invalid gateway.

 TEST: Invalid gw - multicast address                      [ OK ]
 [...]
 COMMAND: ip ro add table 1101 169.254.102.12/32 via 233.252.0.1 dev veth5 onlink
 Error: Nexthop has invalid gateway.

 TEST: Invalid gw - multicast address, VRF                 [ OK ]
 [...]
 Tests passed:  37
 Tests failed:   0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index 63477be859e3..7a0fd7a91e4e 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -72,7 +72,8 @@ declare -A TEST_NET4IN6IN6
 TEST_NET4IN6[1]=10.1.1.254
 TEST_NET4IN6[2]=10.2.1.254
 
-# mcast address
+# mcast addresses
+MCAST4=233.252.0.1
 MCAST6=ff02::1
 
 VRF=lisa
@@ -310,9 +311,13 @@ invalid_onlink_ipv4()
 {
 	run_ip 254 ${TEST_NET4[1]}.11 ${V4ADDRS[p1]} ${NETIFS[p1]} 2 \
 		"Invalid gw - local unicast address"
+	run_ip 254 ${TEST_NET4[1]}.12 ${MCAST4} ${NETIFS[p1]} 2 \
+		"Invalid gw - multicast address"
 
 	run_ip ${VRF_TABLE} ${TEST_NET4[2]}.11 ${V4ADDRS[p5]} ${NETIFS[p5]} 2 \
 		"Invalid gw - local unicast address, VRF"
+	run_ip ${VRF_TABLE} ${TEST_NET4[2]}.12 ${MCAST4} ${NETIFS[p5]} 2 \
+		"Invalid gw - multicast address, VRF"
 
 	run_ip 254 ${TEST_NET4[1]}.101 ${V4ADDRS[p1]} "" 2 "No nexthop device given"
 }
-- 
2.52.0


