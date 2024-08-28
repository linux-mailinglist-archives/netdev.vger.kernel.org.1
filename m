Return-Path: <netdev+bounces-122671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDED96226A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C5AB23C14
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE82158557;
	Wed, 28 Aug 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SDEJBGjt"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753A1C69C;
	Wed, 28 Aug 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834491; cv=fail; b=cuEEKzKvgM1V2XzdirLDvSywrZGj1Srs4CPp13kOKdyqj5GXmsFykloT5EmdaOCPArwIiBlid4JGdUk7fd+ffII/lfJgys3McJlHuwO27wwutdIkS041lPAvnL0ZChKTJsZ6w+BnFIGQWqvDVacifmFBpi6C5ahrRT51QkWzbmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834491; c=relaxed/simple;
	bh=giVGE6It9i3CEdoQ1yU76PFnEJzdYOtqSquWZAwp/Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kFH86Fe400epEoNWCsHad2nIHxcCZBz7nht5ZHgk7Gl30l9GdVUoUQgQf6/AHo2b+T+DbQl/qXaSgdkjDkjP+/16bAxgSlNaShlmcjid2b9zxSMC+zLVJgyvXZCaXipXpNHF2iSMq5CCfIt1BMIzYDjTNltbeDSPJd/PZvvTVEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SDEJBGjt; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBGN1/Y4aeLCwNJ91+06Tao9dPcqwgBx4v0XamllvAJK3pvM6X/0n2mId0RWBP4exmz3kk1h0tf+UL4EfLYDzhNArEjbV47rrTfilC6QL6PAukbECt88KPQ7cK72KEtlc2Jiwn9ubyQtfQWoRX/sFCgegmWL4KCvHB0gtUy6BlmMaswgOlGgb/WRmCldxL91XcQCy/05/52TZEYlY9uEkCl30hiqQ6wsSJpbcmdNjBXPo5371FR+0xk8I0qlBteeT7jZ6MEf7yf8Beg1Hjyku8mhP65ZwgOjQBEAz+UjCe5NHwS2NZ4U8Vgo826znGdGqMmTjp27c+wly37X0eiMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wby1px28gDpbyo5RkcU3q4Ibefk+NVUMgPF6ezZw5Sg=;
 b=G33VrEd3H8BeYQ2j040U7EiF/S4P/LRCV38ayWHL4PlNPyUSB8tzd74I6qS326g33PiXjKycPMG/7gXUI86iTHGdsuIqaJ8gZzE+qgu52JzQtvrFW82JTuulMpP88ISyoRuv8j9otsqXWOTTU8lggSIdFiQSGnOC16clfbp1uTBLrrPMOM942OitTJ7FngbDx30yWyNMlhIQBlEYqes6AIvAgcYB7HPMCfe107DmMclfaYMTohNOGGTh4LX3DQSOZe8pn8irNrxfQPTQkKISniYnw4CK2fvXF1XB+tURytjnExjy5ryu64hMAK/s0JnzqZtCc1/E1Oo8wt3W0Bxsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wby1px28gDpbyo5RkcU3q4Ibefk+NVUMgPF6ezZw5Sg=;
 b=SDEJBGjtcuMcNl36o0Jnj3e2m/hen4R7U6sQVhuKQjpdTHm8DCRuGY4UoKsf7mNqhL2w5AJaF3EsYBB6Qy1b+t1sXfxOD+sdP+Ve4IMYdlqla/J6utBMsAoBYQKg0kx/kLXcbZE+R1BSi5tkTIb9iQH/bU3msVcW2wyiOVtsKcg0g+CGPysicT82seNpVbbwlzhWapr5BMn3sP1c8AW65uffM+z2UYKgbuaV10E9FXH1Q3bfL0vUn011y4kVuh9XxIDyU/jlIPNlM0AU1d8tDdvdPELhXZ3TXMmspUNJmVVb4bX/Y8e+W9HzsPeuZu60Jr30kIkpa1nQFM144p0J2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SEZPR06MB5763.apcprd06.prod.outlook.com (2603:1096:101:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 08:41:24 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 08:41:24 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: elder@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] net: ipa: make use of dev_err_cast_probe()
Date: Wed, 28 Aug 2024 16:41:15 +0800
Message-Id: <20240828084115.967960-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:405::35)
 To TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SEZPR06MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 511d2a35-ab0c-4a86-9b7a-08dcc73d32c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H9t9RxJfRzHk1cBAxTJpbfAUBDLwTlDniiLUPndqxK0da36GN9TEI39Ms4Y2?=
 =?us-ascii?Q?ctMFCkbKh5NorfpoxSiTtrqLnnABA5qSmUYlQs7Z3GO8rfb/6nIs2ZxzuGZ1?=
 =?us-ascii?Q?LPdV9ulynceZuouaT9K8XY+xxeLyRQ1as1gb4mtT96r4Df/zpMs7bH0gqKnT?=
 =?us-ascii?Q?5bkZkaHeyOLG8jH88LdlCiopFdkMmlApgC0TRMOvIGB7E20+46Sw/RR7bi91?=
 =?us-ascii?Q?ZDlw0b5nSbx717xEbrGX3DRdHBgCgP8s4eZEUE8Pw6+NRPkNNk2AOC7qPyBN?=
 =?us-ascii?Q?zx9GW5ALw0/2D1ukpDovF9IA56XHtoNZZFu3NqRZXpACOjWYbko20n/a78kD?=
 =?us-ascii?Q?qmCLbEsYnb4zBEdpdPV7U9SgXZL9KT8b7kJbEqs+ZfM1hwRG90YwpC+S3QvC?=
 =?us-ascii?Q?2+HnArCA0FE8C4osJz5OpSLcnIkoVj9ceckO1JkoCME4KtVeIxsQEotzAXIb?=
 =?us-ascii?Q?TkpvKGnaY3FiXc8js+2RzxeX9YQBkb2A23eH1HZxrWHOthjbJQd9WQ/GHRnh?=
 =?us-ascii?Q?7phq+keIQQ6qtuMSV/eAMX/sdYSUpMHVCMcfsn8JSvrPS5QQexLPb7W7/J6Z?=
 =?us-ascii?Q?qTV+Y4FwfYlyMjqUejQsKHeWwNrQC+7G+jv37INshmREPz9otAD7jBXuLG7M?=
 =?us-ascii?Q?dqM4gAZ835KkGwhkNRVcCMoo/AdHYaCKgfzHpcG2hhdcEzNagqMew3L3qwpN?=
 =?us-ascii?Q?lIS5WXoZZNs7EHcdHmsda2FSUkrpq6ehCmTVIay9LvUKlu634qQuASjJ3Iw8?=
 =?us-ascii?Q?KjidlcL6mb/r1k49X8KmglHumrqxOKvbKSoA6MDvAvuKbktFiHTJ7gyrBgFy?=
 =?us-ascii?Q?+VqaoRl9ueutGdVsKAoqir4M+TYNHjSvUHy5Wi9jC6ykAph3UcWYMtdApJjD?=
 =?us-ascii?Q?XJYELg3zZ064cAoKLzJ3l2/CocU6uPE8qoeCDrDAfh1qxXuSQMIVjtYmMKvr?=
 =?us-ascii?Q?kZCsMbPBq/G6sA0d1W/NfNmjV7dT9/VsW/airQLK9bznJn1wJJhmtaLn4wsg?=
 =?us-ascii?Q?IWxTSeAd1tnJmA+dL4Qe47rEA1MC+yXTdbEfiXCVvlATLNUQUYmhuRzqsfVS?=
 =?us-ascii?Q?9XNOAOVWkaR0QO2+W4sRtoa/rGzEfjrILyb1ORZFVhXbpgEo9rtUk6nnPVCf?=
 =?us-ascii?Q?agrFdkUfYKq1AW2AYs0hYfkpk3vxwP7kHgV9sE9xTj3LW/RF8BeE1pRPx9hq?=
 =?us-ascii?Q?FockWGLjnGoAs9oiJkQ19PjxTt0Ed5bJB9OqgatQusYuFiytCjjaXjTHpa2O?=
 =?us-ascii?Q?DsNQxbJdKZ4NsHPe+BFCunhRqnG/Ni3kJuu7SV3yMf9eeDKIdPSdSwswcTrs?=
 =?us-ascii?Q?iBMUWEYHYWIIM5sGxkPIBZ2SqVRSsANTH9aXp67w0TSs5T1t+PX8EXMXnps8?=
 =?us-ascii?Q?YlF9fp7OOx7yjbQ51vE6+C6TVSOsqCHsKQhUh9NY0izYgZekKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWKC4jRNTX8Q7yX1m6E4ERbup6460s3cLlbrjXl6cnhyqdInvF0uKUqLebpF?=
 =?us-ascii?Q?rlXSpZ6xiRnWNjq2FBnP7v4iG7RCeF2FNEFfJkfSUFoN7fXQDfoiq0mlgFBj?=
 =?us-ascii?Q?imHvwEXTnN+ixHnVNU+vbm40HszM7yrPN++z2nVgk1Eyj5cGwHdY7h3W1AoI?=
 =?us-ascii?Q?smMJrZeH18VeoSkWtTejitwbPzZ9bjLFWCfRpZrPbIh85bozjLfGy/mNHOTt?=
 =?us-ascii?Q?iN5TYCGGlESJwL5pr4kpkqugrOjZNLx1xUuwnM0pXbMvAmMR/ilRwrMx608I?=
 =?us-ascii?Q?T1qdtnp8lx5J31CgJPGlTx+++NW8LtEyvE66h1OYxZE197CjWHwCwhg0Az7m?=
 =?us-ascii?Q?kg0HKunlkCK4mIOGNA0evcKXnG0HjT4ZOR/8RsGfKzr1CIRoStiiSjTya76/?=
 =?us-ascii?Q?+u4xsA1uaLjROoqiid1F/KUG+yaSSsBAOYYS8KOFE73njEo1dRICoFXgh1I3?=
 =?us-ascii?Q?rPcYARYB8NEHlao/VAoSBJ2EwWZsvZqJhWMDMYAE+CBonumdm0Fh44+2fCxc?=
 =?us-ascii?Q?Y3zRhpwMQW2uWCRdp9Q6exL8bojodsaTWStxBysKUHjjpTJU53Mk7fA/Kyc4?=
 =?us-ascii?Q?4+syuUtFLWXipjQ6g+tkQmsA1T6gyKo3tje0Tz23mAclJoMmA8kRs/FsjVYT?=
 =?us-ascii?Q?99KjCVt5WxPO3qTX6Ncz20OSWPnpM/I0CoOcHLV8iuC4INUuoMTof4myTlVf?=
 =?us-ascii?Q?fHV8f5fq9xbKDMgh8hjGobaHSYM75zZrku0ovU1QLjfZ4VOvGsq6kT2ujk1P?=
 =?us-ascii?Q?D1oj5uBDM8Hl65pRUkIoMOIqfU3oyu9zKyOwyIAgx1Xx7Typj481Cs95pv0D?=
 =?us-ascii?Q?vdNdcLUMXBhPNj6NCQI/9H5Pq7rbO/d9kZ+tCJEIoC6ptW+j/XreKoJcw6xs?=
 =?us-ascii?Q?vlrvkWD3vYkgVIwGYUb9Qk+n5rchhOyxxDozQCimOHi9AaZ/O94c7maXQnYF?=
 =?us-ascii?Q?CYQFzr6H+KYJ4lAFhJtULKROUtU39xoqUw8dW3bOd3TPZyIhrRCUnDfqVdXu?=
 =?us-ascii?Q?RXArHKVEknfslLmA8XYBjYQhWqwDLkCLT1oORgxra38iPdSXapGy8X4m1J0T?=
 =?us-ascii?Q?/1yJYU/9SYW5mXo7p3tU6lMC7p4qwSb17j4tGNk0wESga1bDCD0PTERsD6W/?=
 =?us-ascii?Q?rQi5ysVcNe3lcX0dOkvCM6pdmGhoeNg2U+IV3dIJdn00REj2G7LuL30sN+Oa?=
 =?us-ascii?Q?j4GZgjQFohRmiU/jd5biysqTNnJ0BJRBDPvGLoU9OwchHc1aMZ3jta1zthun?=
 =?us-ascii?Q?4NmSIZqx7oesYmo9+msFOyZy+/yKTOT4ENpwHKH6Vq7QhQqfhgJTzMupyXLt?=
 =?us-ascii?Q?WWtqmtOsMWE6DOoqJppRSUatHmqJgAacrpLYoWZoiCUdHMKjbdTOQMcjTiLT?=
 =?us-ascii?Q?AYRz4VMYRFE1KnRFbmaKMRix1QcOmYJfMUPSGzLx4dPgLoEyzT06BMOCArMh?=
 =?us-ascii?Q?Trmcsda0TRIbPNJWHKEf+2xASkp76xPa/ENYOezoT4lMFx1AelMiN5jmDUMG?=
 =?us-ascii?Q?wiqtb056kq06b0DoKDuXi8Nx7usqoyapX2qZoqYcs5NKEfxivjZmFRxrgWdw?=
 =?us-ascii?Q?VZaQnEkNCZdT9mTyK9A0PAG2rzBVsRauSiHCycnF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511d2a35-ab0c-4a86-9b7a-08dcc73d32c0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:41:24.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjWoNkZxRDDHSHzLfc9X5aTBzcqvGVMRu4f1GADbHBO+/e47QQI1Rd7nkZesum8hsXY2xp7rx8A5oLsiVar03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5763

Using dev_err_cast_probe() to simplify the code.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/ipa/ipa_power.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 65fd14da0f86..248bcc0b661e 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -243,9 +243,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
 
 	clk = clk_get(dev, "core");
 	if (IS_ERR(clk)) {
-		dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
-
-		return ERR_CAST(clk);
+		return dev_err_cast_probe(dev, clk,
+				"error getting core clock\n");
 	}
 
 	ret = clk_set_rate(clk, data->core_clock_rate);
-- 
2.34.1


