Return-Path: <netdev+bounces-81266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFA886C44
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B291F267BE
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3745022;
	Fri, 22 Mar 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o6BMOPuM"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2064.outbound.protection.outlook.com [40.92.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C95446D5
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111189; cv=fail; b=F8tTWLGPPyNEK1vbs63RryQI8a9FqR8DZVU9R0me2WtGhpiYa1t43cnjGSBAm2bEyrRKmPTwvjRgA7xAVZ/UUAjvMBe0tG53RKxfJ9OWK3TBVQa9Xk5wSqa3J0dJYjKHJTZbWgxnT1QaKA1nNzOnyXf8BhB9kz9HBCeimMybAqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111189; c=relaxed/simple;
	bh=VvV4S45s/GmwWjiRO1Z7nw3gzUxjrkfb9pzfBLM5+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ixFlkTrDweUwJGDjBFPHmytq0+y5LhJQXzdmTkjK/p6TSyZ8aGaoJGVi+kPnljle5uklDb3faDJ7icEPZxGZ93XeAAYc70O6Bblbqy66if1nJl7ocWnY2KHHVIauQNp1v0O/xgv9t4h+aGvAV+6C8shGXkEJ8LFjA1zI4LHVih0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=o6BMOPuM; arc=fail smtp.client-ip=40.92.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqQ04L8EfmIgubCHMFVvDEkVSKvgpzIt1DNGIw1Q3w/iuEZ2U4njjjj1jt4YpOvrBBVg1ctLmtSxYSc8zYmnhBnus2nUItre++a/CGebha/anQZJmyfq9PKHO+mNYjnBZ1ODf/BixtdY6bR8/chJQZ62M1x4k1BkmxQk0tk7RFWWb6uRLOzecRahJ4tc1LcsHBcC3gt5KMA7XMmSX8HL86IL1X1YS7SIXy7VMuNNzuUWF6VaVimb7OJuANcgzlsWY5n29D3JTy0pP8QGSKr4Hb2DxdA1W+QQe29SwyW70bJ8Y+WOypo48ahaPOC/KECzBz/syMdyenpaRM8P9UTvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F5eZ/WalZV7sOyhD89vOHhfdMg2TSY62rk+sz2ANl0=;
 b=oBflLCKosqZWxRJ4bwAhCyAGu+N3mtzOQccxz92YNZFXyv6+QYcpWTkrELE8ykSRHwVzHU7Wo4NG+MdxLZgHHhchFRAlUZ/gbDVd1LUVx3c+4fDDT13wF3vReNwngxZFxDNvqYgZaFtSm9j17Q4M5b4xnirSuLSH6aI1/YHxLwfOxcBrYj6Ub0dxNImm+bXWtQhirFPJXSVaDr1e7krCKSmyRMaChXtemjGnIom6qKuQlCBnueoxEIAZTSBSi7bxrGPW9d7sdKw0trQH8gpNm8JYWZn+CXXYlWWLaBbS5gz5ucQjpOMbrYaBlXLtBPz8fjEqOkMJVQuM7ftMejRUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F5eZ/WalZV7sOyhD89vOHhfdMg2TSY62rk+sz2ANl0=;
 b=o6BMOPuMY4goH/4b2JJYYF0hEDbPfLdCgmqOYhEB+ehlPDfgj5eUfhTjRRm/H0XFZ3G0vVlr3wzpIj0V+65VEqcP0xfH1gh1TUTNa242ghyMsdatLk+3em8rJGoeyQNywPUGJ/3Sbpg22iryUoYLepp6eL6U2azty8FMDAzEU42DrKwiC6uuYh5SRaPmRYnUMPzXEzetbBCZTgyDvAJTBK3xRSMDJ7pYUygFdHRV3HYpwT74FjQPUY449j2bb+sUSUQlukRzIZ3Hf0ypcGW3AMz13+T2gYPXufaedgO5EsUN2372LNNwFShghgPyd5zdXB28PJ5epPGlSFAb2HtUwA==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB0832.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.35; Fri, 22 Mar 2024 12:39:39 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 12:39:39 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com,
	razor@blackwall.org,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH iproute2-next v2 2/2] bridge: vlan: fix compressvlans usage
Date: Fri, 22 Mar 2024 20:39:23 +0800
Message-ID:
 <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322123923.16346-1-tjjh89017@hotmail.com>
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RC+TXMQ3TyKSIlM8esdPrlqcECcXRc/yI0bDfUzfejWB6QvjwwnpbRnqZjIdS3Tc]
X-ClientProxiedBy: TYCPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:405:2::18) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240322123923.16346-3-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB0832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7bfb4d-81ee-4ee0-4dd0-08dc4a6d238b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IVYxcqX5l+uA5KwpCWu8geYHKi2GC1e6pU9Xx3TXa1uttzL1XL9i5sGUxSz6sEqLC35d8W5Ek5fi+125V4c5F8RRhrC/E77siUXD6KlbJyL6ct71Ds8rFl4m0s1ixxixdSjKpivacX95PE0VeZSOb/IbEs3w+Skgots/YWu6lp3f/QwiGc8sQ4WoZVQQHNllx+3JiY2lW7T9gC2ONclb9MPKPGdoQ3ExXX4ATpD5w4FRcNOjYOqdu6qYSFKwxGgz+mpcBzhoeR/L90CTc9L1a5PdelhAkqMRZYpHk88waeFMvAcRAGCIVH161jTdzjwxfRVLpR3EZgjQggIRZCDpkqyZ2fdxOnVYovdzll8sMtx5rrBXVP5/zW0EQb5Sx/GZ/R9NkfXdntra1O2i6pD/gnC651xBwp7AXRtuZUW700B2cwU2gLCwqKwSyvQMwYM+/+8+7ZvDhOyQqFXyLo2ZEYAUFoyq2YeHknmeunS8+J1yxPO7Bt/nnf08pGEQwe2wiNEzhJ7AN94OM6jRB/Kib5WNC7jBdM94PlVpCPfzCDumGvicbSK3q49bSwTO7vhJ30ezWfrJbit91zsBAzLuOSJJTlVFtWywqQaXTprTK2JRgIyQ1D4eb4S84yj6bkeo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oc489GcDB64nUbt9UxDZ8gMygEWkenThXxZZrLk/4kcT3xP4MF6QJPPfjowM?=
 =?us-ascii?Q?PBRvOATxCsdgs/oYmW5zcfgCfwLF9k+MLfv4S+6BfTxtZpV+grbIZcBZoVOW?=
 =?us-ascii?Q?itg7fcEQxpoIMuh1IaFH8nXYMlNjsdNx8vUguwKnMq1ZBrOWDXmFiMcT0X2Z?=
 =?us-ascii?Q?jZzLIpwJ2sdYtdmpn+T07HOyKrHAjtWMbjVSN0K/QV1AlfTNkfh1AkMO8mbq?=
 =?us-ascii?Q?EhvHxSdQF4uq4/y95vFx2NFsSrrwuY0g4jvvVHOcoF16zN73B+rIPjfOS2YT?=
 =?us-ascii?Q?zRIKSeq2rCczYfKvcCaOKdUPw3EFR7OybmXv547ARekIgT40E0YGjsI2gpk4?=
 =?us-ascii?Q?tCjfR4n6I9RZ4xS6Z5EGTR96VwEHvEE7nMP/qoMx3cTMuhGpGVnzcmzAsYO1?=
 =?us-ascii?Q?7vQVvb3zrWJXf9a0UuBc3EipjWSzi69FTk8XOumDGoY6LEzD2whWiP4S3P+g?=
 =?us-ascii?Q?BsGwRnzsElG5Ey3QYvexgz6aKtGSwzusAor9VYACIWb994uHdTQA1CYRnVgj?=
 =?us-ascii?Q?TTUu5P36EmuNsogOLe7r8ALPxk56aCU8DzI/MojN/u2zRnwb2i/g0jbFbNil?=
 =?us-ascii?Q?fvFlvhB8tbli1Ls/s/7eVjIjeIE4WxsFz7XZF2IcAmYGUeG6q/+yYezX7+Fg?=
 =?us-ascii?Q?SOAS5kLe9y+BHip8ykQXR1Yf4taBgHJSCDsVBkYIACL82wizYOoJ2KFBe9Fk?=
 =?us-ascii?Q?pCAeVL38bZqlN7JPxOgkz8j3U2IPsPacDfXRYBMctE0vBQGblgVh3c7U5y1h?=
 =?us-ascii?Q?UUlzoHJFqYWaK2vvjlB/bgaCu3DSF6J5/0sI6aDLblk3cY8ABv7Rpp5Y6qNA?=
 =?us-ascii?Q?OUgKo9M96uzTlENTYjcH6LF1BQ15ielLxXK/fS51eHmtW7+KXE/ROiqsHvwg?=
 =?us-ascii?Q?JUbZ7uSastJGwY2XUAjFzjb8JCsVx+G/C1yIxilanFcpgnrfYDgAZqvkUSHn?=
 =?us-ascii?Q?AvIztQThlb2f7uxYV8gYS/Kjbx3TVX/y/8wseG4JcgWCPLo/kTg8P5LXBxP2?=
 =?us-ascii?Q?7jZHLO/QBz3tMm9DOMsFfvURUvL/d12YIbg5KqzTalMxtQN9mRtMHZCGSnpM?=
 =?us-ascii?Q?GLdhOdwPMVyninTxibtUQEhZ1pzCfA2pi0VJxps924EgF+yOotm67oF5AOxn?=
 =?us-ascii?Q?vJ8BXAS7lfcYcI1nCF4SdvwGvgZ90IWx0zZNnCUW0AxhJ4RwIoss5vsR/zdh?=
 =?us-ascii?Q?aAX9srNUn3w7jHu2FnS1VyuEPYlwkZ0DwjZZrWUdRphvM7a+dQYnubL0M8l9?=
 =?us-ascii?Q?jFYve7Sz7+TV2RylZmt7tFxVBLzZx3sisTSRwzz40Tc4kEb9XdIORkdRHq6/?=
 =?us-ascii?Q?TbE=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7bfb4d-81ee-4ee0-4dd0-08dc4a6d238b
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:39:39.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0832

Add the missing 'compressvlans' to man page

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
 man/man8/bridge.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index eeea4073..bb02bd27 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
 \fB\-s\fR[\fItatistics\fR] |
 \fB\-n\fR[\fIetns\fR] name |
 \fB\-b\fR[\fIatch\fR] filename |
+\fB\-com\fR[\fIpressvlans\fR] |
 \fB\-c\fR[\fIolor\fR] |
 \fB\-p\fR[\fIretty\fR] |
 \fB\-j\fR[\fIson\fR] |
@@ -345,6 +346,11 @@ Don't terminate bridge command on errors in batch mode.
 If there were any errors during execution of the commands, the application
 return code will be non zero.
 
+.TP
+.BR "\-com", " \-compressvlans"
+Show compressed VLAN list. It will show continuous VLANs with the range instead
+of separated VLANs. Default is off.
+
 .TP
 .BR \-c [ color ][ = { always | auto | never }
 Configure color output. If parameter is omitted or
-- 
2.34.1


