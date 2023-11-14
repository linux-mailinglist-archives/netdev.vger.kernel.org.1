Return-Path: <netdev+bounces-47701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E07EB005
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24601F247B8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321F3FB12;
	Tue, 14 Nov 2023 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TpY6a0QB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4718B18
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:43:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165EB130
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXf4SnvpD9aa8SY62CTWtRSLVZAIyAYiv/3pH6mvuZRTvQzS2ty2jqUUTYjlKRFXx2Dx23DQlTWYqQFNxXInDWgBwW9HCKzm6wXGCxdGjDSUa/wSjAKoW0W94o7K3old153zMemWIxB6V/e59m3IYuFlFZnd8Qhw2aWWIeNX7RqhHoFo0ccTXo9okwDko8csp3Nc8UthTWhS2aL3OvdT8Me5bLsvDxSx29hqxB8157SOMzhG9wlNTms56KGNMNAdwYXfiixB1RSkBbPiOLUmJCvKbTWWSUT13OQuxJ7NSgTR0qwdlsm0+gZHpERNrVqPI/vMEj5YnBCp+yKeI9XQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=;
 b=KmJA50ybAPuN4lQtcMLZoGNwwE4mQEHrLvxEXmus3cwNfaNy9ZcyLag949gENiN+hI5kIWPpvEVD1748e1p+qEbrCmVoEXsOEoYCf9nGb//GUzgdMRx/CJDI5YCDEc6t3EJ0Igc8Kk+Oj08SICT2tUqRdAG8BBelet+/zcqIReKj5XA3mCq4+R8Dqeg1y3WwYipHdTr3CsyMqIpGpLJILV/AumFv0nIXW6+5gPDVoUd0eOKYvBM6Ma01xz73T8inYS6THU4FiN/Xt852SOX6c99zMetE1QV0Hu2JZSWNDfxpcb7OzvzDhyzgcTrKkWD1gwXqVoOup4qEl3ulW6Wp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBWhjRMWENmzbh8QLanUB2GQj5WfzKlPq9b/jB1l1QU=;
 b=TpY6a0QBA9NLjqf0rlor0uq9TO9gDVlHsajc22hVhru/mvG/9mGrrPmg7n5k476nRCfnAiaw4t7jpxBD/DkUKVUo4jm/PW/MfoRY2idlTDbRW8vVInWAT4FmofV0Tli0PCD4E0aUe7q9+rXhoZ188t0TtKdfGVtwdR2S+KphS++00rkTRnUFEEwMWLNLqo+u6d9UXczQkqNxdnkeTyXsPn11duszmdmIFEA3SALproh6E+OirUsKzDnWv7ntatM635kSSlKJ+ha6XufuYXBaHHJQmhKUT/tOj1HPNgxf8gw5ymnuZGctg+B0Vpt3hwwIYFmRcZQU8xW6f6vK6xIVhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:43:24 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:43:24 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v19 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Tue, 14 Nov 2023 12:42:37 +0000
Message-Id: <20231114124255.765473-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114124255.765473-1-aaptel@nvidia.com>
References: <20231114124255.765473-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0237.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::33) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9ea449-88e9-4244-14a4-08dbe50f4ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mRe78zGkXt4Rf3fynwF2dWVIzxxkObEP1OlTYwaWs02gfexKNtUP/gBMBxDluDu5UBDhJr0F/lOW9XL7ZueGx3gisCFLBIMcoa/GpkoToI/e3KKr/Y3mjQY2j26YNYBHgilz1/XuViJxcJ8mGLZPAxwQDsuqIZ71q895Lwi1k0nDWOKQYnD/oAqRfzLGdL2lmTmZiZPAebC58vIx1fjwJCZJNSqVBok+IXALLZ+5wOmVEp5L/y/Dl3pz3hH6Y5NTQtJx8vMtBqY+iHUalqyF8kzw3LkEo+2FL+wbRmA/pt85akGM3MC4UcYJ32d+qlhYtk9GqUje+TCQeV0YJnNZYOObCXatsytu4/vyz+2mdXpdxZ1349yxsB29iPBOl9++C50wQFiXFG4zHdGUK8Zzz6L8+oWinGzg35sszRPMiwiLl48zwabQ8s+79ztycFWKf5ZXSSI50HcMCfv/a+ofrR+bTWA/ZZ0pSRCu/RkYOhJj8r7f4NEYbedJwSaFJg+MNAhAzEPnLJR52T5hbyM5/B8E6pLonNpZaL3tnJODP4WVxirr6H4rMj4gHzdSspkn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(86362001)(1076003)(2616005)(2906002)(6506007)(6666004)(6512007)(83380400001)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(6486002)(316002)(478600001)(66946007)(66476007)(66556008)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2BUKVA+MUzZ2NZFlGApiRqQxvqgGjIdOYSW5RzzV1c810lh/I913rZo6bia?=
 =?us-ascii?Q?07PTQhtPJveokLobwGkhdSRcqf6KaPIl0fS6m56V9o7WsaaTY7mKR4Rlw7nM?=
 =?us-ascii?Q?uOg44JloAtq4HPZF73m7boCONLTOPRV7152CPNw9IYgL4tkLWUofJNDQ6ZlC?=
 =?us-ascii?Q?GwXAP5pRR3wTvMojBzDG7BV6qBbktMya6oWNOKSJlrH56HwU/we+1B8CSVQv?=
 =?us-ascii?Q?QkcA87oRsOAqJ3kZPuak+Dbyy0HZE35Ho8FxE98/0+ElD04wy2Ijo4oE7+8T?=
 =?us-ascii?Q?/epGeFOtHLBQm5F976qFqFnIw6k8yoGUUPLWgKB0qEtkL+R+vNRmR7s5vjfZ?=
 =?us-ascii?Q?vAQzjuQ0URzRFuluf4yiqwMt0pQs9PFhseBMPiMD7QcX4mXekBOnMaLqOWps?=
 =?us-ascii?Q?HCvcUHo3FcgcHyRQ9Vpp4bfIobJngk8r5iowausV25ccB3fMBhJM/rN538UF?=
 =?us-ascii?Q?tDUANkQCo/fVBKpdxU1XSyxKLA11GDAk8bdefWTSD0EiATQWvLRcDAlHXZMl?=
 =?us-ascii?Q?OJ7mWUnqIG2XHPXdiKsUk12YskwIrh5OTnsUZ9cWdMj1T1cU3WYzfnobzUoE?=
 =?us-ascii?Q?QR8MDhCvwsjr4MuXSBKMpvSNZ2w2QifGYQdA3AXar9MgKBGcdGzT+bDywnp+?=
 =?us-ascii?Q?j84OowUiaVJOg6IvXQRof90N6cDCfdAc5IR7ezl1TNzt0J894tXkhz5PL29P?=
 =?us-ascii?Q?YGFv3RxtjqpuneVpyctRKJ+m81VofKPkWnctdWnt7xdSQ/6/Gwkb4B7ZgOI/?=
 =?us-ascii?Q?kAjFmHneQoWuooAnOcK19rMnpISwa6mo/NHug3FQeqR/VzTKMKS5S2AFq9Jq?=
 =?us-ascii?Q?G5ZsrdHYGiq+BGTVdsy6TKj0iB5UqzLX4eybcPIigGnIktnuJrJKtwms/PC2?=
 =?us-ascii?Q?puKLE3mcTytM/ZGZ7ph4nQpIN6NTOHVHZ9R+jDBKfRUp6zglQQ3WUJSD4KuX?=
 =?us-ascii?Q?uhes6eTEXVvl8TZ5wN4uEKkqmsT7cE0UJnwxq2I7JrkVmbK76pIoiz9Q81XX?=
 =?us-ascii?Q?5AYfAHTRUnwkky/ZN7heS942BeIjrXZtuB4IiGdj1jhO37GPfPObhEEBo3Dw?=
 =?us-ascii?Q?eUu6OqLxFWyLzTvcELmX51S7Mmsqj2L43n2QzSeNLwZjEsSouZyzHZR9qv7T?=
 =?us-ascii?Q?7GSV1dPo+r9Di7rCHCwDizNOcs8k7Om0kcLDkUigHZud2eQx72MhIbq2iPby?=
 =?us-ascii?Q?e4QesSsolR5AShvnv0DSG2pK7sRyi60fkpztJi6Tv0HkaRyAZQp+c3jK96af?=
 =?us-ascii?Q?Wd1e/ZJkrLPz8FGGvIgDHOKgvqSCOHymjPNMly3gUGnIQfLZz7dQr3bC88/j?=
 =?us-ascii?Q?OiHB+F3hnmPCAtu4iLH2XI6EzjnvJNl3FhHG0hcm5i1ycssjUxoPV+SCrcsH?=
 =?us-ascii?Q?2bKNr/isqaDraDhZiWRq0nlLvds3nDdYw477H8IyEe/5KL7Ueb3kymS5evpI?=
 =?us-ascii?Q?RRKHS+QcdavDEjTl1qHy0fWkK3sLQbDfrGgbTgQXpyMYKIXjmkAQ158KP1Mp?=
 =?us-ascii?Q?1v5flrWbfmw9DuV6YlfKca4bQzP3qrEQfWdcOUj+JSAKTKjV8J4QvSuo/BlZ?=
 =?us-ascii?Q?NGE5/kcj3jhOzgDNQRKMmaoyKn+QMzpsZQAhvgy6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9ea449-88e9-4244-14a4-08dbe50f4ac0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:43:24.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H84ZBpCoTdHUJmo/oFxt+RbWkt0u2T95xCPbH9cndRELfQYVJ2XuMSzdi5hRPuvfu3pz/SDOBvN6gRaLVMrMvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index de7d11cf4c63..72049621aaa1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (iter_to != from + progress)
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


