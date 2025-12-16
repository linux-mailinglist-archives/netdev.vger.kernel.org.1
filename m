Return-Path: <netdev+bounces-244953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25226CC411F
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58727308ABA9
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55934B678;
	Tue, 16 Dec 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PWLTLr1U";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PWLTLr1U"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4972701B6;
	Tue, 16 Dec 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897466; cv=fail; b=gSsa9jmZ7OXWZYFjUb+WRysJzMmgRlKq+WMrLJ26BZCTwi9Uk6trff6WCeBqnPwN9UoO5NWmnYuJ47qqgBC7TN1L6q2/YDVMGiWlI0k1t/ISWIJIW/smR0+s2oVPdS3vqeeQFysP50FBtsQifh8XAIQjt4ke80hh1/zBe1F9W4E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897466; c=relaxed/simple;
	bh=tBuqAh5/JnBcaUxXkgNG4p0XA/og5WiLR+SvIHo6B7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=foHspTV9FOxCFq0OMLs7ezVLbySqoMxUr0LFiwG52QVEB+d1J+U2G0v2tSQ+qxh0yxvoiUhjrpFTZljZ5rg4JxhKer6qU2yeW3TLPeN2brKZwGEgP5UPihnnhJiGd5IR4oU5gkU8JEPUlkTGkoQqR4kWIGlnJvkWcx8ZNOmmybs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PWLTLr1U; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PWLTLr1U; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AJxrbnnuGhrAlZLvBI30piSNCxLFsJwItrSv0GtYOy+ipdkD6CqzsIQI72V3hQKy+uPw1VE49MRCODM/sr8u7dfFox2oWqNajCQnrqxOEzCpkm9KjRCPlyI4ECFrUq1ADsFr14VS251wo/hN7RfA1mTZucMl4kUC0lON7iHfKrKcn5xvTfsq2xEE+Lo0ts060gYyv2NzYG0kQqokh/wEGaDd5bub5R2LQ+B9wFSrmrT0WBDU66oHF0ckIkYBR6Cn4GGAX2FPYhuT+n171DqQaiu+Smw0RTFhazUYvojl6fdrTp+A0kl9oaaBXJFJ8gF+Hh0oUTpDM+kzUmpcyCXqtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJAYU8ttVhoGbCKWfsETBcplte8WbrF0t9DRHzs0cw0=;
 b=aNuwdxALRT6Ke8qQN6gX/mZ4nZK+TZd8am1TTchrCKS5o29Bq67zPKIh2OeZJJRQVB5+YmlIhAWP40h7OoG0vlmJN72ZO9+XzCQwozWFIgbGaZJjioq8yEHNgg9Bfcew56lbcP3NQStryBnD0zWkzOPlvZLGFyTiLF9NEHdIumBmfmJW3ll8dA21o5JpcV5R1Y5BOFaIPJSaNVTuWgM5VmZCjN6xbRR8SW2iv0We35S0gEz0QxUAHfw4O0dfJND1Fwl871rWuQx9efhZnGN702f3vFF7fJP8Moo9a/V2GdaidK6gzlMbKG9sWPZUervksPyCA40Vs3b+NCIqLf5oqg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJAYU8ttVhoGbCKWfsETBcplte8WbrF0t9DRHzs0cw0=;
 b=PWLTLr1UdZXt8jzhVWg0tvkT9X+XHoNN+B1OzhGoZAd7noiyBbl65rvuqfeaFB6GClg+oyHdoi+AWegEQkQu9hAd70XUIVnzmJXZNi1lYtHtH2tpvVoJpQJcj+p1DvS6tQ8j5xDwru7U8VFFT4iF61BpixH2kXtk0s0SbDM77Uw=
Received: from DU2PR04CA0339.eurprd04.prod.outlook.com (2603:10a6:10:2b4::18)
 by VE1PR08MB5741.eurprd08.prod.outlook.com (2603:10a6:800:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:04:15 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::6b) by DU2PR04CA0339.outlook.office365.com
 (2603:10a6:10:2b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 15:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4
 via Frontend Transport; Tue, 16 Dec 2025 15:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD0h7pLq0P1qyacxDk3hbmt2G5F5UM0pYi8fxLmanytx2W8OTTRqZUm2AEOE3QIrBWBZvus8zYjhcrFhCOcsKI6Sp2o1IXGxxtdkrCF0ZGbOdRQ9d/+MBbMMPQQLCGS4v202csvy1INgJrv8qaD5bwS00TYOywh6xetMDwcdmGUnKr9cDsCIFt3OcziNCb57iZkOPkVsB/Muz4NxF/QWSzWhyCD+s8RSjLQaxTp/9mBMQJpxpLHaNvmerzX5rocwROHsyqDfdJDMoH9ovhCa5KKZP99zxDQPr8J29DYoY2gAqZRZqDOy7RsTj75yGFv2Es6RfsHVOjOceIi2WS7iOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJAYU8ttVhoGbCKWfsETBcplte8WbrF0t9DRHzs0cw0=;
 b=h2Q9CQEkcB7dK7J+SI0xJafSWARuEW+bXozyZJhiUalz1g3wnJDXU71CrxNA7AF68shMQSleOU8pa+EUjg+gZoNN0w9pGmU1oDoEF2U7xQLZ3qt8KAIVPbYtfh0sizlqS4ns9I68deiUMPMxBvZfQnpgo7dCHpWPgkEfHPiRa7F2ajj7uPeLCwEiazBPYwZjUr8peOU//10XfqO5fYqsKQKUVOMhxdviZ04t0a+mrne3p/+MVAyipJ/MkjKplhUxxKnQZnmpAU60SdS6/tCwjeEVJqY47RxgmeaHSa2vrPLFSQhRHRuiimWK2aXJ4nNtRtGo4ezq3raDMQ6Prn4lEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJAYU8ttVhoGbCKWfsETBcplte8WbrF0t9DRHzs0cw0=;
 b=PWLTLr1UdZXt8jzhVWg0tvkT9X+XHoNN+B1OzhGoZAd7noiyBbl65rvuqfeaFB6GClg+oyHdoi+AWegEQkQu9hAd70XUIVnzmJXZNi1lYtHtH2tpvVoJpQJcj+p1DvS6tQ8j5xDwru7U8VFFT4iF61BpixH2kXtk0s0SbDM77Uw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5777.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 15:03:11 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:03:10 +0000
Date: Tue, 16 Dec 2025 15:03:07 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Simon Horman <horms@kernel.org>
Cc: nico@fluxnic.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	dongdong.deng@windriver.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] smc91x: fix broken irq-context in PREEMPT_RT
Message-ID: <aUF0q6ERtXNbYPdw@e129823.arm.com>
References: <20251212190338.2318843-1-yeoreum.yun@arm.com>
 <aUBBE-W4kwQbsp9t@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBBE-W4kwQbsp9t@horms.kernel.org>
X-ClientProxiedBy: LO2P265CA0299.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::23) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5777:EE_|DB1PEPF00039231:EE_|VE1PR08MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 308bca0d-2f22-4330-d3bf-08de3cb46025
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?EujEMoHdyaAQsdJeSZZ/emmQmyC9DPmy4p568J9x4HTB6qyaMrDAYw++5x0r?=
 =?us-ascii?Q?qm2Fe8jXTX34MUt3rADqZYjcyNxV2jlf22fo6bNgAlqCTsxTwoaZCH2woLlF?=
 =?us-ascii?Q?1a+EjQHNF5zHNOect1e8UlGwr96bdljtu+FLJLYufbYvuQ+DFQ9clJg4OHl0?=
 =?us-ascii?Q?hB3T0TJZ9ws18RwlKIC6VMpkXILfdlCFmClcszjyIzlBwNHADnt+1xP7bXGp?=
 =?us-ascii?Q?giokbV6yfrkVu2zh83KgTcgbI9w1nKxN2JRCr3FTuFVya65yMrp7N46UtXJ0?=
 =?us-ascii?Q?4DYVlEKYbY3el3d8YTnJfE9uU4BFkIOQT/7rQRHTvqEI4zcDkCefOPkiT0Ed?=
 =?us-ascii?Q?ZQrtlzZHUd9j2aGyonnlBjsjrim4VsKbycjvj2x7ildjMwgJitlzZtXtEDH9?=
 =?us-ascii?Q?+x1ebEJ+XcwI+mMQ4o0rBnbI2Q76HlZxQ3PY6hKdfnV0J1KFsNCseBUIzmVV?=
 =?us-ascii?Q?R6U4l4ljEzNmEYBTIsZ5Gg5xpcRg4MPinzZt/TxxUjlR9uDujY2XkR6OlhLS?=
 =?us-ascii?Q?4UOfncaMGAohX4qc3WJDigYbUNUF+h+MsZalWcHtyoUc/9Whc8eb18cfuelG?=
 =?us-ascii?Q?gRRD6/lUf+6BnjZqfAwImqxpFPVNRv0PWy5PkzUxlSMvja5S8zvThH5uwARh?=
 =?us-ascii?Q?5J+ebOjfMOUctEizVp2C1bBq1ZZTY5Osxno1DB2f/Ixqb7OC8fk7CMgYiU3B?=
 =?us-ascii?Q?GCWUA6/0SQYmuqXocPDIx+tjRcDamK1dAbmCBGdj602A5ANBPdmf/abtK9VZ?=
 =?us-ascii?Q?GlAt/i3dAeUpefix1u4C2f3sbIEyktBbIEn2Lequ2FYhoqvs9346YSADJsik?=
 =?us-ascii?Q?d8LbhIw5tmSHviY6eeLNV1U02O1Ytj6l72Rfr3Ee6eJwMhpJX6uFT0iB95Ln?=
 =?us-ascii?Q?bM9ty3f5TI8vEzlHH3IXXHYmGWQWJb1bJsGOnZmR2BBtIxmaTekJZOp9shob?=
 =?us-ascii?Q?NIUfmgrEObKNDTeIm+EkrsMX7LHWtdfC4mf+yAiwyXtTRDQKoeNLwXzbydXd?=
 =?us-ascii?Q?8MwH2VRhD5ZN0020q+zIbNMGK+I6R+T0DzIrphYtOS8uIln7uOeTwdvTVeHA?=
 =?us-ascii?Q?t18IhDz9gokogVN8Vqzkr281AjIITLR2GdEs8cvpTuxz+fDEyUOQUUqWSqDN?=
 =?us-ascii?Q?i/8NgELUuZm/Zqs8B093Gs7/lrGHiOqbQ7dhPIhJFwecigIEb8v2rLFzxXYQ?=
 =?us-ascii?Q?kupoxhrYNDgKDCCM4xS3qj911SELOaN9wSF7SodheLmydZeDut/cW9dfIZGo?=
 =?us-ascii?Q?9TEkffXz2CXpHSPOo8m6e7nQXcYEGDSiVBQPGnoZqfbrbzIKb1YWyB3hFR7S?=
 =?us-ascii?Q?d11l1vc5GGgrU8YpcNqGEnShKK8kVLp1QONHJa6BjIjj39ex71u34lWXaels?=
 =?us-ascii?Q?uJcfUIYIDg2G1U7G2X7KpG4z4SUlyJ0Let34hTjqux5O7hKeSwpACGWpjDAf?=
 =?us-ascii?Q?n5fxcbDMN8mVszCu4orZJEdejALmEryHi5Rlczdf8ru3sg8882jDhg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5777
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1f19c3cb-be26-4085-f975-08de3cb43a77
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|35042699022|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+QKmoo1k80rjEpZuUsP5CMDQLXD6rm2dHQQ4Kcj48ctzAeVNm5oeiSgi5ZD?=
 =?us-ascii?Q?S4aZd3IhbPhbAo+1wRwu4xyVs/YaVEuU18BcTwrOn19B1zVmfNDb2RmwtwsF?=
 =?us-ascii?Q?ZXhWzksDMw4kmAz9DQGKF9lQKaPz9hC08jn/XLZo1mgx80i8J41R1kOmAIJn?=
 =?us-ascii?Q?f31cP6CKvhW0u7UkeHkKQH0r8SO/hEUeN19ghroLqIeRV2MEBjR4SPa9wHdI?=
 =?us-ascii?Q?RAvAr1sLkLAiJOvoBvAs2F2O4XkPXRx21sgr0vJBDXC45i1aClLX3Q7tztqm?=
 =?us-ascii?Q?c7SOTyavx6P+AEGqDVX2dPyAgqLGnQDr6OaUgjqR1CG5cPTMdna7yOwftRz2?=
 =?us-ascii?Q?yVuGTYQGFzAHlRb2JERVx7OLRWwVp3stjc1OqsONV1EoNr37DaLxu+EGGS72?=
 =?us-ascii?Q?O4wrcdGIs94iUiUPhQLyG0JrCxzICJQlrjvBPSKQnJhjtE8AdFew0TdKt3+I?=
 =?us-ascii?Q?XlbuIhR7l7+RjbBA27LKcoZ6RZezkVapYF//XRdGho2TYSMM3jqzG+DvoR48?=
 =?us-ascii?Q?w2I7l4p6/gE+ZRzw/YBdqj+m3wVzv99yrw6rHHM204mz7c/qTYTl+AclYQH6?=
 =?us-ascii?Q?D8TxlCOorLEL7GB2xEMS7uJ9Mv5eGb5t7nxWmh3spcwXLiDRjlYWMClmYvzx?=
 =?us-ascii?Q?Xv60kZVKSrwk7JiPquHh2WwoShCy6UDJLdOPatfGhEFWVeqIefh7tJDGgaCz?=
 =?us-ascii?Q?66+sEvJZ2sZxb202XcyOOhYum/khB2YJAnBDKSMRnf24iMx45WH95Qq0cU4r?=
 =?us-ascii?Q?GMNBiWJQEsSob8TJdhee0RSJTTTaPY6Z/P9vT9vYhdMs+6qruaLa0aieCuJW?=
 =?us-ascii?Q?BvdjqxjfKLUTaQP6NeEDYqrKvuH8kBnISCh7I2AxuWVGzTENOgmdGYqycrkm?=
 =?us-ascii?Q?H5Hcs+eMFV42bEK+Awow9FxutslwVbIjMpDkCVO1iM7s2Ok4qwQEveRwQWLl?=
 =?us-ascii?Q?sS0ysv3OYd4AcVr2Wmn9M6zor6fQxfMLuR0e8gAmDuHrQYPRgXMLGfcPmrr8?=
 =?us-ascii?Q?lwEve9H5pvww49U7stzXUfIog88pRv4ouvKjkPbxahj6Lavqli6VL1NMfVLQ?=
 =?us-ascii?Q?ZaXNT4mYtgLAahepe00TLFutfn51Xc+8VfII1EvV2dcCEcE0VRiKcirFMX8r?=
 =?us-ascii?Q?67nqpeACuPsE9rJR+K1QjkGICa4d/B3pS/Rxf+y6ANbTLZFbORlE1y2qIuZZ?=
 =?us-ascii?Q?wC3LCD0+Mey1XDhgnvusJ4TTMpQuguePytYziU/gP7Ht9IXYrfVM4Vg7HmIN?=
 =?us-ascii?Q?dSRKMdPMDhk1P8+p7DjxouupROcd/dgoLX4JPZ1SUYx1wGKSAwHE2CErxVz9?=
 =?us-ascii?Q?TfsJMLQn0g/4MWyLf1pr8iQMJgj+nW8bLYpB4/Uvb+CQLWBmg2tCy1AItl/k?=
 =?us-ascii?Q?4O7IgefQOdMDprPnn5kscpz+EJL0J7zU2ACnxklpfZean6ylCBz96ysHXynb?=
 =?us-ascii?Q?dY3iIuMR5hfkxqWFMy5Xtne4DrJyYMoYm3m1o9nAt4ZsA3T3xuHOVxEiJZ1J?=
 =?us-ascii?Q?Ac/8kftwqMg3bxpK1927gdfjKH0lzr2T7soJAcRTt4b8tv//asKTZL43Ds/d?=
 =?us-ascii?Q?wDGHBsG+X1sU10uQJzFpaQqvfup9kfadkf1muUWF?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(376014)(35042699022)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:04:13.7073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308bca0d-2f22-4330-d3bf-08de3cb46025
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5741

Hi Simon,

> On Fri, Dec 12, 2025 at 07:03:38PM +0000, Yeoreum Yun wrote:
> > When smc91x.c is built with PREEMPT_RT, the following splat occurs
> > in FVP_RevC:
> >
> > [   13.055000] smc91x LNRO0003:00 eth0: link up, 10Mbps, half-duplex, lpa 0x0000
> > [   13.062137] BUG: workqueue leaked atomic, lock or RCU: kworker/2:1[106]
> > [   13.062137]      preempt=0x00000000 lock=0->0 RCU=0->1 workfn=mld_ifc_work
> > [   13.062266] C
> > ** replaying previous printk message **
> > [   13.062266] CPU: 2 UID: 0 PID: 106 Comm: kworker/2:1 Not tainted 6.18.0-dirty #179 PREEMPT_{RT,(full)}
> > [   13.062353] Hardware name:  , BIOS
> > [   13.062382] Workqueue: mld mld_ifc_work
> > [   13.062469] Call trace:
> > [   13.062494]  show_stack+0x24/0x40 (C)
> > [   13.062602]  __dump_stack+0x28/0x48
> > [   13.062710]  dump_stack_lvl+0x7c/0xb0
> > [   13.062818]  dump_stack+0x18/0x34
> > [   13.062926]  process_scheduled_works+0x294/0x450
> > [   13.063043]  worker_thread+0x260/0x3d8
> > [   13.063124]  kthread+0x1c4/0x228
> > [   13.063235]  ret_from_fork+0x10/0x20
> >
> > This happens because smc_special_trylock() disables IRQs even on PREEMPT_RT,
> > but smc_special_unlock() does not restore IRQs on PREEMPT_RT.
> > The reason is that smc_special_unlock() calls spin_unlock_irqrestore(),
> > and rcu_read_unlock_bh() in __dev_queue_xmit() cannot invoke
> > rcu_read_unlock() through __local_bh_enable_ip() when current->softirq_disable_cnt becomes zero.
> >
> > To address this issue, replace smc_special_trylock() with spin_trylock_irqsave().
> >
> > Fixes: 8ff499e43c53 ("smc91x: let smc91x work well under netpoll")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> > This patch based on v6.18.
> >
> > History
> > ========
> >
> > >From v1 to v2:
> >   - remove debug log.
> >   - https://lore.kernel.org/all/20251212185818.2209573-1-yeoreum.yun@arm.com/
> >
>
> Firstly, I'd like to note that it seems to me that the last
> non-trivial update to this driver seems to have occurred back in 2016.
> Do you know if it is still actively used?

Unfortunately, I don't know whether it is still actively used in real.
AFAIK it could be used in qemu or arm FVP...

>
> I agree that this patch seems appropriate as a bug fix.
> But I do wonder if, as a follow-up for net-next when it re-opens,
> smc_special_*lock could be removed entirely.
> Other than being the source of this bug (which I guess is special),
> they don't seem very special anymore. Perhaps they were once,
> but that time seems to have passed.

IIUC, remove smc_special*_lock() and replace them with "spin_*lock_*" right?
If so, It seems good.
Even UP case, I think it seems better to protect
critical section in smc_hardware_send_pkt() and smc_hard_start_xmit()
with spin_lock_irqsave() from interrupt handler.
>
> Regarding the Fixes tag. I wonder if this one, which post-dates the
> currently cited commit is correct. It seems to be when RT variants of
> these locks was introduced.
>
> Fixes: 342a93247e08 ("locking/spinlock: Provide RT variant header: <linux/spinlock_rt.h>")

Yes that's would be better.

>
> Lastly, for reference, when posting fixes for Networking code, please:
>
> * Target the patches at net like this:
>
>   [PATCH net] ...

Thanks to let me know for this.

>
> * Allow at least 24h to pass before posting updated patch versions
>
> More can be found here: https://docs.kernel.org/process/maintainer-netdev.html
>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for review :).
In next patch, I'll reformat the title,
change the fix tag and includes your R-b tag.

--
Sincerely,
Yeoreum Yun

