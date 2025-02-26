Return-Path: <netdev+bounces-169796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F7A45BBC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900C51887189
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD97238171;
	Wed, 26 Feb 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b="J6jHYp2k";
	dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b="J6jHYp2k"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD120ADF8
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565722; cv=fail; b=GFPBJaaF3y2EgrD7t6i5w2V2B0eXd2+paGtiat7gD2YxrAHZTvWpG3ebabETQHqpvHZmuUENz9nbEtK12iIHrwwwEqs38kaOk/gOuIl4YV8/mQ2O3Ca5M+r1NPq/pWPanj3On7Sy0WuyYXQORnNMYeNiIICCkkZDzKN7Uy0hE18=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565722; c=relaxed/simple;
	bh=a6Ct7pXkGD+E8MrZaoSdrqDeOJ+Wy7gm8dn2cfrqvx8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=C6OvjOehYJsYjUKaC4K+cYuQGIPbJatou7sduSuXLespAzU/X+Qj2yBCZgtr3EBttxXvjV0mwtwjTu38/tNPXkfjpkr9DD2fEZdomo+pS7IoI+YoQaBNgfiRNLtb50KOl30Nz+sXEegjCZIWTqlYdTTho/mtqKLeQQ9GOKOEAzc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stackit.cloud; spf=pass smtp.mailfrom=stackit.cloud; dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b=J6jHYp2k; dkim=pass (2048-bit key) header.d=stackit.cloud header.i=@stackit.cloud header.b=J6jHYp2k; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stackit.cloud
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackit.cloud
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aLehRFZVNKzuGZ7QfYA7c77r6TVUZpXkJP+hvDXJaIR0f0PlIMM1f9FFZmQpsfzWdgzlf3xXuejY0a9dKw4ebOElXsL3Gpc3zLazXf27oDvmv9YaJExFuoS0DhYxwLISEIeRljjlUFc2dCkyGscGWlQxWw7e8E9kRMSmy2gP++nLh524LwCu61HCYPLqISLzsvdS4gBtGl3LKBEFymB53wzSCZfb0jsZo+Zyfic+dsogZhcBP6tpXtHTzb3mqCUa+DJY38MAYfC2l1ELb1pW5Rv/jLkPFIRmLvXT8H5t/KeMnkyl2J8M9tOZArMjHCvh65sxlz4MAoUlYldhsfaIBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zbKDBYMz5XRcEST/L6wEj4tBjj0mposTjLxC2A5pRY=;
 b=jMBZLeUuWauGyLHLBW8Y7zLq5FJOYDdfYI63xltLsUKmpae1hGtQ/t/gs+u2NtW7xT0C2BCUrkiFl0sRjxdp/hLoJSC6P5iUN90ZfTCs0bQ4fT9VkBAJK9y47uIP5Hlf6inx1BCrnT7ejC5O3q4wzkwev9ArndAVN7QK91aqLgMVPRtcI2mKfwpDFyMtpkcmjAsjILAhbxm+DIJTtM7EZaQ+sL/+JAU9f8qgsfPqNKx9cQCAHEOHry0//OfCLgJ7hKeZVK0Mzz7aQYnCpSev4BM7IdpvsAT2/bGFLM962m9QFFu+B/JhbJ1yHsCN8Ah8ho5x7N26TIZ9S5V6qI+58w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.169.0.179) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=stackit.cloud;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=stackit.cloud;
 dkim=pass (signature was verified) header.d=stackit.cloud; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=stackit.cloud]
 dkim=[1,1,header.d=stackit.cloud] dmarc=[1,1,header.from=stackit.cloud])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stackit.cloud;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbKDBYMz5XRcEST/L6wEj4tBjj0mposTjLxC2A5pRY=;
 b=J6jHYp2kvaCK2hJusp9sd7gtdlnPfhVnnSVpZBXTlz6+IgWTirR7V1GxFDNI/+ilJn8sbjvlDCDMAAPkvyAeZY2f3QBVO5lvBbKb031RfUuXPzfA2Gk/71Ur6+ONFxFSbdNJm1cZ4LuQebwL1BpsOAbtVQeF5hpAYozwtw8kwhrV2dFvbefCuf3BkNSBPvEkCufGC71RlxeQWmbRDJwz317Y+iR9IWS7WG+yL7LMdsUyi/MKWK3qc2+ezA1hLz7U4ErlsJd4pEI6MMOUkuU6EfJfqYy9ImXGVwi4aAtoAmkNGQI1engyOENJzLrI4ttDkrNuwija6G7AIg8GD+f7AQ==
Received: from PAZP264CA0152.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::10)
 by DU0PR10MB6653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 10:28:32 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:102:1f9:cafe::b0) by PAZP264CA0152.outlook.office365.com
 (2603:10a6:102:1f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 10:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=stackit.cloud; dkim=pass (signature was verified)
 header.d=stackit.cloud;dmarc=pass action=none header.from=stackit.cloud;
Received-SPF: Fail (protection.outlook.com: domain of stackit.cloud does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 10:28:31 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.104)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Wed, 26 Feb 2025 10:28:31
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 8963373
X-ExclaimerImprintLatency: 3505033
X-ExclaimerImprintAction: 6dd1a5f05c784cab87f728f7bbbd4ef4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7ipllAP8D5P++6ktjvoueI+lrEI8/saK6WWy5xifzl03SEuyR1Lfh/lUBGH+OmZJZvmdO9fTEkQR2cz9zVynSdvP9oR4X7J2jghEx43nBcklH7tg25L9fnOMck784lOaOSHBB9bg0jOCHwnOaK+Ng28RoWq5DYoUkNYxAGXHFyUaRCpHBfJSSMNze6wvUW0L4gm6b48lGy2hO14gG6HrtAUlbgw3ImVqbLShaHci9H45fJfN6QBTYFZinkgnfTSkL6A8DI/ItaXUCAGBCspIAp0HIsM6q4IBZIa6HS3ZP4JMz5dDBhk1IEnbGWXZ3JOBYfGcUktQ7buX/EYPrExiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zbKDBYMz5XRcEST/L6wEj4tBjj0mposTjLxC2A5pRY=;
 b=IU4+Ftknir4qssdCBums7K75iUiYEWqWm8h0w1zt5qAja8ugQPyxbwKin4VAfRMo10M5BNBLTDqyIN24lycBgph/fFsdFJFJyDUGNS/5YGiDTQRSZsBID0SANFaidFMIveTT2S9JSs1mdrMh944+vYnBPs/+qP6Wzgso8UsLGXxd/i7pauEvJN/HeKSPJnbgbPY7aBhKxgapW9NlD1rb+hlYW1YTryxtBSwF1sV9Qs3bBgpJbXnX1JAqlPItMxPdP7N4EFuIeyzilEmBvBFk5LtjmqCuwARuST/ZCzJLGb5ns0GXB4akofOC95FhwErlywYd/zooA4d2nfXxKbOJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stackit.cloud; dmarc=pass action=none
 header.from=stackit.cloud; dkim=pass header.d=stackit.cloud; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stackit.cloud;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbKDBYMz5XRcEST/L6wEj4tBjj0mposTjLxC2A5pRY=;
 b=J6jHYp2kvaCK2hJusp9sd7gtdlnPfhVnnSVpZBXTlz6+IgWTirR7V1GxFDNI/+ilJn8sbjvlDCDMAAPkvyAeZY2f3QBVO5lvBbKb031RfUuXPzfA2Gk/71Ur6+ONFxFSbdNJm1cZ4LuQebwL1BpsOAbtVQeF5hpAYozwtw8kwhrV2dFvbefCuf3BkNSBPvEkCufGC71RlxeQWmbRDJwz317Y+iR9IWS7WG+yL7LMdsUyi/MKWK3qc2+ezA1hLz7U4ErlsJd4pEI6MMOUkuU6EfJfqYy9ImXGVwi4aAtoAmkNGQI1engyOENJzLrI4ttDkrNuwija6G7AIg8GD+f7AQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=stackit.cloud;
Received: from PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::9)
 by AS4PR10MB5248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Wed, 26 Feb
 2025 10:28:30 +0000
Received: from PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f00d:feeb:e45e:54f8]) by PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f00d:feeb:e45e:54f8%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:28:30 +0000
Date: Wed, 26 Feb 2025 11:28:28 +0100
From: Felix Huettner <felix.huettner@stackit.cloud>
To: netdev@vger.kernel.org
Cc: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
Subject: [PATCH iproute2-next] Add OVN to rt_protos
Message-ID: <Z77szIaLjeMSNJP3@SIT-SDELAP4051.int.lidl.net>
Mail-Followup-To: netdev@vger.kernel.org,
	Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-please-dont-add-a-signature: thanks
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:30d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR10MB6914:EE_|AS4PR10MB5248:EE_|AM2PEPF0001C70F:EE_|DU0PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 598a31ff-8dfc-49ab-ed06-08dd5650516b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?lqCj4ggCLdSmG/HD2fYu+Kx5qXzUPetW8yZttyXC5qgxLo1CepG3Y1XDq9iI?=
 =?us-ascii?Q?JkYPxRz1D4dwFUjRwC5MNsw4YU16eI3CFEH9D6JNHdjVGYSOxYwbcvZWyAJb?=
 =?us-ascii?Q?oqD/5dolMSU2vPpqacxVkWYVSiKsK+NaZWiLzkwY//VSMy7v6ybEhmDhpA4V?=
 =?us-ascii?Q?4fu16nk2FfAgmIJid4EAhgTK9iCDPQzBxTVgjCDFTqWB1vcS2YjPHKF1QsZh?=
 =?us-ascii?Q?I6eaohvBr+9Xn592h2I4zH3ybr6DWLvGq8Ql0SMDwrOnquuOMQrvZn9vq8rn?=
 =?us-ascii?Q?DrGTxA/Cu6JEheFTdvN6NGOkiGj6tVDKUNOalS//+8GVHKpWzSdS3R7+SGt5?=
 =?us-ascii?Q?EXc0nxTTYhoL6XJM5uYdTTgLcgajWs4AlaV21xQoYPpEGQwa1LJTafY6d+H1?=
 =?us-ascii?Q?JNO2dTL6K9atQ2VDmNe0YtTSLhB6yY0u1VgMu2hfiBrPOoRp6W3w9hObKhTq?=
 =?us-ascii?Q?Cj4HUFxTcjJK/v0YQCnSP4hQm2REcTXiTaazJaTIEdxkKICeu+ufL5l07BIb?=
 =?us-ascii?Q?w62RQTJOIc5SHllHNXw1lnA+ZkqWUHU1DNv6XFYkrZPUOA6ohbwk4WYeaKEX?=
 =?us-ascii?Q?M1xiTPAznxhe+xEmrBo3/r156lDxS1v0AamBHn/XrOpnyNKyu2HC80p4bvea?=
 =?us-ascii?Q?26Slue/Gt2ZUOhHa1xyBFjle/sjlS8Drm/x8dwM9RSgTK8F63EWbwmeZoQU2?=
 =?us-ascii?Q?iLAyBa50ozzF/TTPLthA3uDeO3eLgSffIzVcMy83pxBbsPOxjxfsWxwgPvlc?=
 =?us-ascii?Q?H94NZL5IFfzYNUmcUqjFUB+/e2IyXqbTbjgogYRGaGFybdCQnXI6n7T7tU/h?=
 =?us-ascii?Q?3bg+reGOaMKek7tDsuA6rJMn2luPESIxIvtE5JiMxR6GN+SliNSvD5UtMrCg?=
 =?us-ascii?Q?8u85ZB80oY3JmnELwwbOWc7+fPJvCQKFe7QmbA4ZccjobHxiGEQ6yLLILBqp?=
 =?us-ascii?Q?chVZGxcP8he2wt8NqEuv0EoWLh38ONT+E02h/Du6nEHi2mjBzTZHETS9vVC6?=
 =?us-ascii?Q?DXLtL0mumCP5ucNUD60J1JVM0vphmfX3tzjI3q6qfi1SMYW0gahH6oKV4wsE?=
 =?us-ascii?Q?CWJBgqtmqrPOZCQilZroQ3PeBFobgS/M7F/kku7S2XBeTZfD3pBEU+d8ZA6s?=
 =?us-ascii?Q?Io24vHqFE36CpVU1+bzCdl+e7AHJFw1SfIgQYhDIgG2PC2Hgic0e5eQmEsY/?=
 =?us-ascii?Q?EWk6QnVWhxhnT3DL5d1iv9b3VKzUiHRAYUQfCl2IXyfTKnAq0UVxRlKE+1Jd?=
 =?us-ascii?Q?xatQRYBsUJ3cGwWyhtJeRPQ4SAQLzMguD388j4iOKd550Ppy0yCaVCn7NHub?=
 =?us-ascii?Q?2vlkBYd2dAcFCoVHSHvypWXSsMmPChg4AOp26A4rPhRcKoAt6E0c1ER41DyH?=
 =?us-ascii?Q?NaZrSRTKdNgXw0Da1punGt7D5F7Z?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5248
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	93bef39a-a18d-41fb-cf5a-08dd5650503c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|376014|1800799024|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QldwX6o0PuNYGOb0eHwSWuUuHbd5ZJez6b4UnB7Fr26Qvjg1hp+Asj82Ypcv?=
 =?us-ascii?Q?EwLzhvoD9oSHJplNQRYnRQm6AbmpxAQMn8F7/ABNwuRrR/lpLpqDDyx5lRDD?=
 =?us-ascii?Q?kOgAjBf6e16i1IOJGJKjW6zbd4VPBM+UAXRD6kZcejuxt4H1P0ZzP4nECfRg?=
 =?us-ascii?Q?SfkJni+V2UBOPygzq2BqS0wAIst7jH7kzw7bdvsSLA8SZ0SNGO8BQC9YMe0X?=
 =?us-ascii?Q?/w9QyMuk2DhObnrHtcve4Ed1htNp6WUZUxrdHMBs/Pd0JkhfOkDUZYQIqHAH?=
 =?us-ascii?Q?K9VR3YCgKVIY2iQX8l5+5JzunwYU6X+hV1RVRKCeyHJ7kd22LkW09z1sSpLn?=
 =?us-ascii?Q?Ul834+2+We6jtc0lX4vNWEoJzXakndrXcBqTwvDpvP2o3dAzC4Xo/iyXnF45?=
 =?us-ascii?Q?Ha3UFxlVEGDzjiyWx4MifNJu0eCO5GpWt62PVe49aRzL0UGPwYJ46GD6ZgeW?=
 =?us-ascii?Q?nvCU/BhgmK4BAurofjmuAhztZUjectYR2PY2XGPQffj0n8/TtEpEG5a05+f/?=
 =?us-ascii?Q?znV+om6s7zKA4BcnwLsrdKrFhqqZ2xOsYJuIBJf1Xx6hDQHjLmNzo9Vnv+ZE?=
 =?us-ascii?Q?BqujnqJ5J52uiy3wEqQLXA6mHp/Sqr2JrPwRt+bZHJ94ctgKgAjMRBa7KIrx?=
 =?us-ascii?Q?waybVhbOp9H5YurDUrjC4NMAMdgOfo/T1/rliaiRdO+aOb9UO8L5FTQROZgD?=
 =?us-ascii?Q?FWuhonz8zOk19Ofibrr+oiu7S9vJgCcLzJhg/SUJyFoATmYxHiU/n37HswGq?=
 =?us-ascii?Q?tlUrZyjv5d6MTlyr9UrO6HWzbox8Y6P6iSGJxji38/PrkPmWmSDuZwP8u3MJ?=
 =?us-ascii?Q?5O7MbanvAK1SODoQCt9Z1yxCZgZshj4nHr6lUoM0/criyHFlJiw1Mrp37Otk?=
 =?us-ascii?Q?JdnwiVTnrJKuO8uVWUu6m9yCZBFPER/cmaejn44vX34HgMSw9oa/+upM0kRn?=
 =?us-ascii?Q?VEE0D7R8+FlGex6IMzQtxuvKFPcSS3vxXSD8pRVf1jqq/Jtfl7vaxnOg5HEA?=
 =?us-ascii?Q?6dxCURGYTeKXmZvmV2t4PEncOKi+HGaL5Ei/Zs3liHbNVtGEigv3ojY+OSG+?=
 =?us-ascii?Q?L5LecE/uu3nZBivnMiJY07VUkNBEfkwP/Jw3HhvvQRm2hYNKPDyEMpxU7Y9r?=
 =?us-ascii?Q?UvpUlZSI0YHzp8QtuALrEijiBIwnmd3Vjk3sV9lsx8WHm89Nv7nrxhnrVHfr?=
 =?us-ascii?Q?srJRrG87zhN8qVNTknfRW7U3adhqSbAvf8mePCKR8WuyosWPDoa6IKMDE3ja?=
 =?us-ascii?Q?oQnp3CvDrS56DcF07WwCBGzbl1B7h0lS1Sh7Pc7hAz0bLNLw+ohkVtqzTMYu?=
 =?us-ascii?Q?KSRdaBkICjBLS0hpOQmwgnkmnipRMB9zjKYnoJ0At71PmlVLiwVFYM8r3F+F?=
 =?us-ascii?Q?AhOSOhnIagS+Tjb4/ZoXr3jZUCPVXvhwcMir2bvA02c2vRkLuo3MX5l6At5/?=
 =?us-ascii?Q?PWx0pt8ap9nfqQfb7s51SlpzdtAA82GhM0348svNQSnjcmiD4nzAa4z473h2?=
 =?us-ascii?Q?JkUt2uHO/hIvJMI=3D?=
X-Forefront-Antispam-Report:
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(376014)(1800799024)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: stackit.cloud
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:28:31.5503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598a31ff-8dfc-49ab-ed06-08dd5650516b
X-MS-Exchange-CrossTenant-Id: d04f4717-5a6e-4b98-b3f9-6918e0385f4c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d04f4717-5a6e-4b98-b3f9-6918e0385f4c;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6653

From: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>

- OVN is using ID 84 for routes it installs
- Kernel has accepted 84 in `rtnetlink.h`
- For more information: https://github.com/ovn-org/ovn

Signed-off-by: Jonas Gottlieb <jonas.gottlieb@stackit.cloud>
---
 etc/iproute2/rt_protos | 1 +
 1 file changed, 1 insertion(+)

diff --git a/etc/iproute2/rt_protos b/etc/iproute2/rt_protos
index 0f98609f..48ab9746 100644
--- a/etc/iproute2/rt_protos
+++ b/etc/iproute2/rt_protos
@@ -17,6 +17,7 @@
 16	dhcp
 18	keepalived
 42	babel
+84	ovn
 99	openr
 186	bgp
 187	isis

base-commit: aca230f0f567e407372f2a5f724f9cd6ec373dec
-- 
2.48.1


