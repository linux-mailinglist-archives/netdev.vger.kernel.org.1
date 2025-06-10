Return-Path: <netdev+bounces-196144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0EAD3B3F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579603A52D8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869071A4E70;
	Tue, 10 Jun 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="SMWeMS5N";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="SMWeMS5N"
X-Original-To: netdev@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022095.outbound.protection.outlook.com [40.107.168.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1819B3CB;
	Tue, 10 Jun 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566122; cv=fail; b=VLJ4UaIHQpOSuLEuWb6+QeKXfHPXukN1QZYZHtos+gg2pyrS9aVRJBANKiZykQAainvbNVXJlsrXFlDbwaf4QxIyFS1Va8r823b2OxKhRfOmE0r25HBxd6eW6HZDlLlZe073sN0zhX+ZUpNHNmLfG7pSkIgOkc7n5Offu8D7hW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566122; c=relaxed/simple;
	bh=THuRUf/XXaDYvY9H7MecLZ7oEXJ8DpAo9CuwLdwj0SU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pC1zlRoisTfFlCw13hNSEGCwc6jvFLxRM8Izyq7LcaevWRW+m1hBazLzsKdD0Qzpju4qWO4utUWua1bfVHqoQ7MwA79+xIgu4sWMxqTxFUe4ypW6sqAYMicZQr1doS+KXnodNmGp6paO7nJze1nBTaBBXSeFcRPua21wwHTniyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=SMWeMS5N; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=SMWeMS5N; arc=fail smtp.client-ip=40.107.168.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkwcMxAIIyvJggpXPtu1XFWKN+uB3A00wju2ZpPSEJSBMiFihiRvD2pRsgdZoLIRnm4lbP2gUiPaEAXZfEBFGdR3NyvtV8qIjdrMyQNn3utGSZ8tZtcOl0op/AXl3loKFIs6uuqGDmMo0GkUxxGaDkJcbxh1g/tZzWGl/IW2CXBTbtjjSzQsJpndD3Vilfp3x06J2Lp9QEXYxd4jPseS6vrG0D2yKtuEA6Rc7ilPdC4wq3yw38VLwA4vDLndE8KlLHl/QYIbSo+LJ9jWIedg/Pq0115MNTJUcrTTcPm1TzUU85OC4m+x32F2TY2gHKf5KbZLPq//gGszarwt2HgSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5erEqAJiH55ZhEYur4vpuW3hHu2HJ5bVoDrEeJjqLJ8=;
 b=xxdex9aUkNKpO3v0CNafyIcLqhsOKQmttNKzaMQMY414wng81xBgEbsqB0TL11AbBOz7ZQ8KFpj8aPZg/Uv+zaJOExQBps7KgRsaOEDcQPbQzzcLbwqXvoLCMrjlNTG40rT9bajEFWEGTZG4QjfIP0VQ7xIXKhEacNVoIM5YLTIe/fRJ0tM7oRyrnK6apSGBri4QS2HZ82gV1FRrxeKaqTvGjwjbDTpnXS/En8y5u9cYTtC9X5DZJ1765sdbTxGP9XIjzah6KPWcsvFe8z1qx/kmdlEW6+2D+biFdYeLyWQ91jSmMALTpo+NydTO+Oc7BWExQPB+OUs9s8s1r++bEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=davemloft.net smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5erEqAJiH55ZhEYur4vpuW3hHu2HJ5bVoDrEeJjqLJ8=;
 b=SMWeMS5NPbv531gx/yVdGew5plamSCA+Mctm+Pa2XHq0uRpa1KaIS0/S21AzwX4wVW2l41cymwi2qkEprnrPKeUtkHLOvV8iPL/Y4OvfuqKxOsA9+E3PoxfltF2yReMnoGPUAh1E73QAvjxr1zJAr6kqe/ShBJgKxGvXun47qrA=
Received: from PR3P193CA0006.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::11)
 by ZR1P278MB1151.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 14:35:15 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:102:50:cafe::17) by PR3P193CA0006.outlook.office365.com
 (2603:10a6:102:50::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 14:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 14:35:12 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=SMWeMS5N
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id E691D808C2;
	Tue, 10 Jun 2025 16:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5erEqAJiH55ZhEYur4vpuW3hHu2HJ5bVoDrEeJjqLJ8=;
 b=SMWeMS5NPbv531gx/yVdGew5plamSCA+Mctm+Pa2XHq0uRpa1KaIS0/S21AzwX4wVW2l41cymwi2qkEprnrPKeUtkHLOvV8iPL/Y4OvfuqKxOsA9+E3PoxfltF2yReMnoGPUAh1E73QAvjxr1zJAr6kqe/ShBJgKxGvXun47qrA=
Received: from AM8P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::34)
 by GV1PPF84DEB8E9B.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::21d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 14:35:10 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::29) by AM8P191CA0029.outlook.office365.com
 (2603:10a6:20b:21a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 14:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=neutral (sender IP is
 2001:1458:d00:65::100:ac) smtp.mailfrom=cern.ch; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine header.from=cern.ch;
Received-SPF: Neutral (protection.outlook.com: 2001:1458:d00:65::100:ac is
 neither permitted nor denied by domain of cern.ch)
Received: from exonpremqa.cern.ch (2001:1458:d00:65::100:ac) by
 AM2PEPF0001C70E.mail.protection.outlook.com (2603:10a6:20f:fff4:0:12:0:a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.15 via Frontend
 Transport; Tue, 10 Jun 2025 14:35:08 +0000
Received: from cernxchg92.cern.ch (2001:1458:d00:6f::100:187) by
 exonpremqa.cern.ch (2001:1458:d00:65::100:ac) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 10 Jun 2025 16:35:08 +0200
Received: from cernxchg92.cern.ch (2001:1458:d00:6f::100:187) by
 cernxchg92.cern.ch (2001:1458:d00:6f::100:187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 10 Jun 2025 16:35:08 +0200
Received: from srv-b1b07-12-01.localdomain (128.141.22.62) by cernmx.cern.ch
 (188.184.78.238) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Tue, 10 Jun 2025 16:35:08 +0200
Received: by srv-b1b07-12-01.localdomain (Postfix, from userid 35189)
	id 1F8D744D5AC1C; Tue, 10 Jun 2025 16:35:08 +0200 (CEST)
From: Petr Zejdl <petr.zejdl@cern.ch>
To: <petr.zejdl@cern.ch>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ipv4: ipconfig: Support RFC 4361/3315 DHCP client ID in hex format
Date: Tue, 10 Jun 2025 16:35:03 +0200
Message-ID: <20250610143504.731114-1-petr.zejdl@cern.ch>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM2PEPF0001C70E:EE_|GV1PPF84DEB8E9B:EE_|AMS0EPF000001A7:EE_|ZR1P278MB1151:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c31d0f2-a300-493f-ad88-08dda82c0273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|10070799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?HawScXVq1GyJmzQVRx07w9CUe3wbyoi4VxyYHLqAwvqlgxwC181/j6+eP+Wu?=
 =?us-ascii?Q?1px2IZlAgWn4ct90MdzpdATFdySKhQjVDSyFu66QEYCs1vXXg+POAuWlo5bC?=
 =?us-ascii?Q?W8OFUB/WxcZEF0y8BtVQTJ0KwMRJ5WxC1Y0tDCpBNHbpWv1nPr+x+wfHmo0+?=
 =?us-ascii?Q?AAtdRW6qLPcAp11U2PV0aHSsYho9ZmHV8zyw97ghbDgCPY/szlTVeZYah5XF?=
 =?us-ascii?Q?FbmQzPUwHfNIJU0qmeKhtVoZ0LKbBi//iGk/PU46gZE9xC35WsPeTSa2WwdY?=
 =?us-ascii?Q?4GcUFueLILEjO2ZHe5zvmUetI+Hyvrvf3HJ15HRthDGVAtuMjhYSR6GunLXz?=
 =?us-ascii?Q?FJOewmvTlfHh+WlXC6hzBkJWIBwE3T+BTzP6Hs3Ye9DEOzeqvEsLqrqWu4FL?=
 =?us-ascii?Q?Dcp1QPUrea3n8aoehr2nYH3k8CBCBTnMmDfMKuY8rKGYQX+hL1BGZu2Kqk4W?=
 =?us-ascii?Q?DWLUXBFtX/150TZlvogl8FAPP/Auu/m0xjemlwlY/5r+MTgNT1EZsbosgZ9q?=
 =?us-ascii?Q?Qkp4yuRvaYNt7yBSWaTPLV2JPombZ8Vv5iAxeNKnMJQjrizjdU53ALj+9ph0?=
 =?us-ascii?Q?IIMypT95qpqb53R2eAwZiEh6CDVCtDkmbXUnerhYhrL+EmIAw35gvrVUbjbJ?=
 =?us-ascii?Q?7/wNjgPgLeCZ8lo7GR5uvGjGzKCqEWjuwg8z0Mc+z3a1naRfRwoxePvFlFS2?=
 =?us-ascii?Q?N0tAxagFKuH3nNMXpcS4GYODy1PqDp+xxWnv0/+5i9ncoOgk+n1wSZ+AmiG9?=
 =?us-ascii?Q?eYfgIFtkttlw0ExKH0dq0md4qVUKgxrKU0vMGnD7lvXLb4QmEkXRHRRs3FQE?=
 =?us-ascii?Q?Tjuruc50e/DvUDTBP7tQcPNTHh8VjlD6ixz1/FqZH6AOOWwyWzOV1Dbo7bzC?=
 =?us-ascii?Q?EA7d6g4R0u59Q2YVYO64xzGzoO7OAl/hrvSeLL/ikm0d5CQ+j3y5YaR+1w2t?=
 =?us-ascii?Q?AMXswVCJ/K3fDSJpD1E/Abft8m+7hTpgtPBSfHbNx7wSGODXGrk8WsPNhyDk?=
 =?us-ascii?Q?t8gh4V0rkTIv/jEvFBvK2b9+jyEqrME5xgjrHashGDuQjokn+x6/n+m25nSz?=
 =?us-ascii?Q?p2am6Ilrp4Hs5AexGVQ8uZC6LQhFzxvh3mA7hl/q60vSXSzl9mNkuxvQo4lk?=
 =?us-ascii?Q?ND/NrrBtE/d3gSKfE4+KsSBJ6u7ddvnENlvIYrvpG8jI9CFC+//eKGdUXEwx?=
 =?us-ascii?Q?sOwOr0L0zZ7iJ64co8bKUGGMiytg2RBJzcKQuWc9pEIwrMG/+wrRgI6Cgm/R?=
 =?us-ascii?Q?wcpLE5D6ZTb+tYuQ5GnkzipAlfyf4wlilTSud28kuecV1GyHCYUThzC4ziY9?=
 =?us-ascii?Q?+JRl3ZVSRK8/n+NvE7B5J6QvJ7V4neYnshOGs/TVyQ48hbRPf20hbuxUqWjT?=
 =?us-ascii?Q?dpADTp8XqxUKoZ0VJT9xcUF2Alz5s+pNuoC6ihaQ069/Qjn4hbzUE2yZf8yV?=
 =?us-ascii?Q?N4Z0CdyL2XpZaRVYPUH60ehA/036jVbH2liojw6BYNiVDTroktp0Yym95G9T?=
 =?us-ascii?Q?8x7eso4xEBP130aMgvAvVu9At7GpP8gMLbVV?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:2001:1458:d00:65::100:ac;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:exonpremqa.cern.ch;PTR:cernmx22.cern.ch;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF84DEB8E9B
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f095286d-832a-4c1b-ed8b-08dda82c001d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XkFv5T+uc3bj9bxQenCNYlb8BDlyR/xPIOxsbf9Ktdac0mbxzMOJ+cyFU5WT?=
 =?us-ascii?Q?o7G97GJh6xMelTTBoEldnn8aaAM2fEUmN/DXtjd7pAuoL8bndKp7p1f0DrIB?=
 =?us-ascii?Q?IYGmiEwmDFf/6y2THm9BwgI9vLY55L3jpEMArnfcsES4sKZ4moxkrpP6rwiD?=
 =?us-ascii?Q?4lVcW5onVeFTlNRhB9xHeq3HCB/kL0ghUYwXM/meTvSPcZdJlBVW8Thq+kip?=
 =?us-ascii?Q?LdARnFGupPXgpKCX1vwDH9+KgonINQ8egdYTbwBPnZ6k+sy84kMCM9FajNWn?=
 =?us-ascii?Q?MBVa+x+noW4lE4YOgTcAfhbfLHkbZ9KCDP2KUXcRPREH6loRlF9HRtFqznXp?=
 =?us-ascii?Q?DO59L1KeBHrDXl6PF0Sev0s1XaUEj1BM1rSKFJ/0wiNQcoUc8NPrFVnMJt72?=
 =?us-ascii?Q?eWnGaYRlX6Ynn6mSWCK9t5nrQLygy78PObLvrOLTVObNhX8Fr7so7geir0YW?=
 =?us-ascii?Q?xRWaYMpEVunzEFGbCokhr5ap1w2WZHBbejvaFSYmY69imNoqybA5IJ0K+jnO?=
 =?us-ascii?Q?KKCZWSo6caSkAnl1+4sYbMsXfC/wJB+g+I6fB4XZYocVs3VXwNIyg194S2Gx?=
 =?us-ascii?Q?JOPugTjL7W/pQtEFe9KfH/ofgRN1HNbA1a0zoLWzoS64Cy3oKgRh0IQmF7Sf?=
 =?us-ascii?Q?bEtgJhPMjF/MVvYFDKfGplyKKeo6h7X8MIUnwXiBcaLPSFiXcyd+dn3SkLuj?=
 =?us-ascii?Q?pp4rcEg58lOaLBprK6fIbJQcROE5Xog1ZX6CN3ME2fwNsbzBhv/aRcJ7DUB8?=
 =?us-ascii?Q?wWvgqQ75IlYCO0tA9wAcXE5fjR/YAvX1d3ChogxEEXQQaHICeUov1bVpqjDV?=
 =?us-ascii?Q?+eGRa/JUUs+hh3dDdTtoQXBX/NVAVlophC9g7684LYHZ01tDToDRfV+j7t8T?=
 =?us-ascii?Q?6hbTp912uNXae+Z8sPqU/M1lSBooUMHxg7fj3yt879A1h01Hwg0oBdkOp8fk?=
 =?us-ascii?Q?GrbQ/YThNBOgqqXDygt6XsheT8RQHWUl39c8ilU/tAW20OnCWoyafjFQJO8W?=
 =?us-ascii?Q?+GsLZYON2/WUveBrpxPmTuMmeOITckvfioCiYhVbWmF/zKQRg8AK80++1XBM?=
 =?us-ascii?Q?RKWZbHEDlD+2zzZ3oMj55HIaN3iPxJ3M5iqQfkVmQpyJk6ewgHOfEmiEY50V?=
 =?us-ascii?Q?ukZHhxuCd9Ql+m3UW/aB6aBbRlySMKLYl1DoUwt4UtStk3k9JH4mXygLrFAL?=
 =?us-ascii?Q?f78TD8/rvsIT9bt8yzoFh8EWJGR3dSD4ixwFxSoMSyspCfWkPZd+ER8VOsCI?=
 =?us-ascii?Q?yqAiwMP3WtVulNW/zGM/4Ah0FW3/1RHYqfdLPoFkg1yRzXGRYbxFN5e4FpXF?=
 =?us-ascii?Q?oNK1CZf8e3uzeqDOkN/kjf5gWAEA07XbwxBFCdN+cEWSaMQhW/xBXQxQU0Ci?=
 =?us-ascii?Q?tMTM8TF1Je/JutC2aSprs6nHvM0GC0vBu9zcVVmga/lfFqKFXBs0CQT8RZHm?=
 =?us-ascii?Q?1Lyjrs45Ein8Y6gDQcWquXLgLtB2ruqW+AyHCIREy1oGCu40r5bxYGo5var4?=
 =?us-ascii?Q?VWq/uVUyWjfi5GEBaMPz1Rj857o6MT3V2J9J?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:35:12.8777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c31d0f2-a300-493f-ad88-08dda82c0273
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1151

Allow specifying a DHCP client ID in the hexadecimal format resembling
MAC address format (e.g., "01:23:45:67:89:ab .. ef").

The client ID can now be passed on the kernel command line using:
  ip=dhcp,<hex-client-id>

This format is the same as that used in ISC-DHCP server configuration,
allowing compatibility with widely used user-space tooling.

This is a backward-compatible extension to the existing:
  ip=dhcp,<client-id-type>,<client-id-value>

The existing format expects a text string as the client-id-value,
which is not compatible with binary client IDs. This adds support
for binary client IDs as specified in RFC 4361 and RFC 3315.
Binary client IDs are used in embedded systems, including geographical
addressing schemes (e.g., HPM-3-style client IDs in ATCA crates).

Signed-off-by: Petr Zejdl <petr.zejdl@cern.ch>
---
 net/ipv4/ipconfig.c | 63 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..000d918cc811 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -146,7 +146,8 @@ u8 root_server_path[256] = { 0, };	/* Path to mount as root */
 static char vendor_class_identifier[253] __initdata;
 
 #if defined(CONFIG_IP_PNP_DHCP)
-static char dhcp_client_identifier[253] __initdata;
+static u8 dhcp_client_identifier[253] __initdata;
+static int dhcp_client_identifier_len __initdata;
 #endif
 
 /* Persistent data: */
@@ -740,15 +741,22 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 			memcpy(e, vendor_class_identifier, len);
 			e += len;
 		}
-		len = strlen(dhcp_client_identifier + 1);
 		/* the minimum length of identifier is 2, include 1 byte type,
 		 * and can not be larger than the length of options
 		 */
-		if (len >= 1 && len < 312 - (e - options) - 1) {
-			*e++ = 61;
-			*e++ = len + 1;
-			memcpy(e, dhcp_client_identifier, len + 1);
-			e += len + 1;
+		if (dhcp_client_identifier_len >= 2) {
+			if (dhcp_client_identifier_len <= 312 - (e - options) - 3) {
+				pr_debug("DHCP: sending client identifier %*phC\n",
+					 dhcp_client_identifier_len,
+					 dhcp_client_identifier);
+				*e++ = 61;
+				*e++ = dhcp_client_identifier_len;
+				memcpy(e, dhcp_client_identifier,
+				       dhcp_client_identifier_len);
+				e += dhcp_client_identifier_len;
+			} else {
+				pr_warn("DHCP: client identifier doesn't fit in the packet\n");
+			}
 		}
 	}
 
@@ -1661,6 +1669,33 @@ static int __init ip_auto_config(void)
 
 late_initcall(ip_auto_config);
 
+#ifdef CONFIG_IP_PNP_DHCP
+/*
+ *  Parses DHCP Client ID in the hex form "XX:XX ... :XX" (like MAC address).
+ *  Returns the length (min 2, max 253) or -EINVAL on parsing error.
+ */
+static int __init parse_client_id(const char *s, u8 *buf)
+{
+	int slen = strlen(s);
+	int len = (slen + 1) / 3;
+	int i;
+
+	/* Format: XX:XX ... :XX */
+	if (len * 3 - 1 != slen || len < 2 || len > 253)
+		return -EINVAL;
+
+	for (i = 0; i < len; i++) {
+		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
+			return -EINVAL;
+		if (i != len - 1 && s[i * 3 + 2] != ':')
+			return -EINVAL;
+
+		buf[i] = (hex_to_bin(s[i * 3]) << 4) | hex_to_bin(s[i * 3 + 1]);
+	}
+
+	return i;
+}
+#endif
 
 /*
  *  Decode any IP configuration options in the "ip=" or "nfsaddrs=" kernel
@@ -1685,12 +1720,22 @@ static int __init ic_proto_name(char *name)
 
 			client_id = client_id + 5;
 			v = strchr(client_id, ',');
-			if (!v)
+			if (!v) {
+				int len = parse_client_id(client_id,
+							  dhcp_client_identifier);
+				if (len < 0)
+					pr_warn("DHCP: Invalid client identifier \"%s\"\n",
+						client_id);
+				else
+					dhcp_client_identifier_len = len;
 				return 1;
+			}
+			/* Client ID in the text form */
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
-				pr_debug("DHCP: Invalid client identifier type\n");
+				pr_warn("DHCP: Invalid client identifier type\n");
 			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			dhcp_client_identifier_len = strlen(dhcp_client_identifier + 1) + 1;
 			*v = ',';
 		}
 		return 1;
-- 
2.43.0


