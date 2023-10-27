Return-Path: <netdev+bounces-44741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD677D9810
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E50FB21321
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886501CFB8;
	Fri, 27 Oct 2023 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z29ELNSZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377821A715
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC0FA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzjjC67U3C2c3rCeyjo/KGoQOwYCREY5yg6scfrQ3MeWZ6hp2d16XK/xgFtZiu3yKKu++DXwPb+N8eoTvTRziRIkzrtXKl8pnuzbNzEUfAKBuW1CNehJU49y2niDQ+CmO7bx8XCSRofbcVYgJvJR20L0dQMg3QgA5EAjCQbT4BhInSPZGQg5bPQX4nkUTdmWbERnCbIqysfUIMFnVeOlvlg2/zm1xnQVLHD83IiV/sQrutA8I+/dXwjrnMSGa+CWUiuG6NyAFYc7Hzx85Lv0CskcIjbZ18Z8fKjdbWFJt/Dw9XUxFJP5D/jfIVWSrbZPoOFdZvg8NcPu0ABtGxKueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=;
 b=BTM7CbDOrJmQD+NYz3CvOCoqa4zmmwAdexCzLDCigq9e4oq5UpsmxaSqv5HamuBubMyZP/QF4f83B0+5gJCMUuNnfqv9GLwpk3tgfGos/3VsjUBK26TMuqZ2Nr7nbVzTmszFe6mq9f/YSr+3K9/kml2NL8LAXbYeS3abzqWp5i8DcPzwxgxWJyTaAxLDC7K1eCj8Z9wiaZ885cCiF40CXkJpPyAtr6DeoS+LTWtfx3a5N7b9QgGsLOYHPLbVTI61QaHhJkQGEHe0wZ33CoRHtwUCsVMYKUWH+15IBSG81e4zDkLCnYrgRd5lP16SXSl/JpIVABOZZo2/ArezrRAeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVhYgmoQQgwNGg70Yd/OYeT/fhog1Ihoa6b4xYGf9ms=;
 b=Z29ELNSZInVgGeGC+84XId6BdQKyJEFnxt1JZLLEC+M6vv7gecId4vNk3a1cuUVAcKnV8/1tdqZMR08OkBXnUCr2KbV5A7CQ07oTMWLBB/j5xcXVfoUVZ1jodheF0UqjvkLjoXxqeC7tzsus14mAT5vdoM6qtuMNYZOIjQ6nKLch6cuNHaqlbhuYHxnplXpxgMvMpQ8f1mKF42jww8Mo1lLp4Vw6HlHNvw6MaLQnBZEs/aqd6SacTKKt/LpKLpUXEBYuLc/zPJXEOe7Nsm4mMOZSWA4NEHST8Pjqm8jxzLwXWP7DjUyzkPfx9QyHPG8k/xDmUY/ykVymCfdPw/fSGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 12:28:17 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:16 +0000
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
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v18 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Fri, 27 Oct 2023 12:27:38 +0000
Message-Id: <20231027122755.205334-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: c06a443d-07a1-495d-f5c6-08dbd6e831f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	83WXFs9rElFqUIlAWO9eFJcKBU5Hr4Rr0ySUcqlAi6EpCO7Qq1pDRFnjJsv+hhlvW85qdG9RNqzvzq6pI0/T2xZg/gmtbOEA/8Uqp0o29RS288Li1l4Glj6oWnZSMMoUcxnH5FD1V924VoIlPGVKHTSV/OxacSaefVoqU+CxjaE/B5DuSAS1jqF2z2t0YcJw/BT8aUTw5N8je+l8tKRwM+4Du9SxJNk+zatCz2qszan1UOp+89szH7m/YJ1HKHqrs6OvCB4J5jJuRVOsl96K657K1x4NYDNFIn+GwJo2SgVGjNokW+wwdi7y4rLGvT6O6J+m2ZzmNbx/ult9slJuBPKsbt+yjRMX1rzz9gxt0mysefZp7Rh66vaTFV8+UVpBAVprhSV7kWlYIlZ9kkzQR2+Zko2bim7E64JvZlOs92YPgvafBZNlpRsCNc31VnNh3fHm24oipBYhARIYeP8ZUUmWP1M10i24utJ6U+urgqFRCAwd5ElXtDz3e+kj5wafnOTaygarqbIndt51C8aIi9H18JP9U9Z8wnEZJTtdgggpADC93sxGFXFEN7Dvo76U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(1076003)(83380400001)(26005)(2616005)(6512007)(6506007)(6666004)(38100700002)(478600001)(2906002)(7416002)(6486002)(4326008)(41300700001)(8676002)(8936002)(66556008)(66946007)(316002)(66476007)(36756003)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLyi13elm9WvpBtYew2ZZy2MNpisT+gUY/NHCR5WS/3tnq7wwUPgbxAaOCfv?=
 =?us-ascii?Q?jkeLbJoejBKgbISXd1lvWqFnubDPnL6sy2YT5+Tc4BcW4ePqS9oW14G9g/8r?=
 =?us-ascii?Q?VR4G4o2d5MPbxx50XsKOXW1ieAx12Hb4pih6dYm0OrUJ4Se7gW4dPrHl+Tk+?=
 =?us-ascii?Q?uJ2BErRjDxl70QK3ob+khIskO2u5QVLrq70m8E4yKTFXt8fxa8IbXDU9i40w?=
 =?us-ascii?Q?LrOp6ANzoFpAe3raX0czgzNq3bm/mOP2u7y2+BFDo0mT9udO64Vk8lv4PTf6?=
 =?us-ascii?Q?xuLNabwSr4QLrPxRAjC84Ax9dCXhFcb0z/pl9Gt2EGzXLxquEzAAB7SFYX5R?=
 =?us-ascii?Q?YYHACcvePaQdRoBIRK4PlILYAFmCG+a6DRTa0NDXf8rvek3bOqn7dEg6fn1S?=
 =?us-ascii?Q?PsYakktBy1y1HywVF5a/3flpBozXBYPGVlw+RXd0X9xyG5R4fRze3VJNIafl?=
 =?us-ascii?Q?LTCKnvB/B2LDBRp8cgNs4ZV8/sqIzJig3xC79i5cLhvopdVii+chs8t0Zuvf?=
 =?us-ascii?Q?2LaO2VOYJbnoauKfQIO/smeWPfSl+wC07TxQhoCXCRpSztpgkjNPYwWB60jK?=
 =?us-ascii?Q?nMNaDWpiOwvxmzdS9C1vFEfIIf8bz21atECADMKDrzX3T711CCcrU16bFOr6?=
 =?us-ascii?Q?aqwaPC/pnCjodhaDjtWtvmB9Ql/na/ueYnGe5uclL5xTViC1uL0F5+ixKZNM?=
 =?us-ascii?Q?G4/Bd2Bb5/CNVpRzSxafSLUIUNQDl9u0hTG1sMsvBmOJeazEvt/fXPglKmaq?=
 =?us-ascii?Q?oHeqNnFQ23wbCl9AJhgKt6b6Qa0rWGWE5yxDCSYX5aAo4FQr1irTO623mj3N?=
 =?us-ascii?Q?17RGsAkQTehrUJXMfliNY4oq+W9M1uORDelEuMUfaFby0roiItUunsj/4Aah?=
 =?us-ascii?Q?+tOZfuPk+9XNB/BuqYaczvsDRwHbHsS5b0msup21ALAIYZm4Qh7l4S2wUr5P?=
 =?us-ascii?Q?r788vReSEouRg7WW3EDFgaEIVta5KqAumJcB8X1AUG9r9doGRmzOzY3jL67j?=
 =?us-ascii?Q?0MYCxR9cS6uzsYYFiS/kCKLF5cEhNm0eGoq5D88dsDkbbQZf4Yp5Eje8jGTR?=
 =?us-ascii?Q?QxiC7H5BOSjMAhvCvsl1WQp0+g6na64TwYfbvsE7F4FIydWxgzjGF1sVKFcH?=
 =?us-ascii?Q?qe1ultII/HapQbxXKTeyIIzfpaeNe+ay7hvxaZZESMXV1Diec2I8lFGre4/7?=
 =?us-ascii?Q?NSi7xinYSxSzYjEyCvRQhHinoBKq51RXNufjxwHWtvvQ76ofxNvUhpq5f8VR?=
 =?us-ascii?Q?+rkaTjOu481rIrQCV8qTsVLsNjQashPPUqZa5MQwtSw37STRFk6WGuVxGoLO?=
 =?us-ascii?Q?ETe+35uDcqrfiaieS61nSp/tIgKHlWlxxk9nXmEesYNK7Gmka6PWu+tKWf8c?=
 =?us-ascii?Q?KMJvsirDN3mWsJpUEtEpWAfA+g4GObQU1GzesDeK4bJsvLwnQUbEt5Clvev6?=
 =?us-ascii?Q?IemXg+Rln7pkjJPVE1AONIRsCl0m1LlIkdGt6HmyT+YddusONli5Kwoc5edW?=
 =?us-ascii?Q?zUHYCYVPQRU2WLlQn6GvyBuCJb1GPfzMeN6Rr2zyxF5JM06ikePSS3RKvmHk?=
 =?us-ascii?Q?r0fqEETZl1PdvXwCbCeCoIJsPsKDdcZqu7BpOZA2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06a443d-07a1-495d-f5c6-08dbd6e831f5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:16.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU9RFlr2yp9mNEodyXv9tWuZgLrVZwwRUWg0mragKAL+DTFqV0Y8dPpVRbhQQ307c7bAi10ouwEYNoWp2Haxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
 lib/iov_iter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..279b2c5b1936 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -313,9 +313,15 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return 0;
 	if (user_backed_iter(i))
 		might_fault();
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
 	iterate_and_advance(i, bytes, base, len, off,
 		copyout(base, addr + off, len),
-		memcpy(base, addr + off, len)
+		(base != addr + off) && memcpy(base, addr + off, len)
 	)
 
 	return bytes;
-- 
2.34.1


