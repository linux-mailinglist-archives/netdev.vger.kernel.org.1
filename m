Return-Path: <netdev+bounces-169466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D30A44113
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F35C165C45
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA582690DB;
	Tue, 25 Feb 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bopm7g3s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58678268FF8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490500; cv=fail; b=aIdgqoBzTTR4E4wXlLe2k2C8S00X8OSQeirNhWA/TPfHAdeTJDryCLPE9OTuXNUXjh7VPvHdgVwrl6sojnn/dCWEtiisC8ZCd+EYwpA3XX5gvJSnd9zdkPEXEZ6mzQGPEy5fZJpUWhr2iCout/xXtg4yZDCykvC3rC+AWDZ4ZKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490500; c=relaxed/simple;
	bh=kx6pGpKnocUT876q75KeR4YLWF9V9VbmUfRK4WcRRgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QeOe/DWEsnw95BUYlFZTm9rv2LwrqLOnBPsc1yzVasdu0C/P4rHqK12H5gqsy86QCv9zZloiLS0zqc0oYL6LFlzBiHspmkJXi0RrKIHjb80AYMzkI7VuvdOtJLovdjFP/dZ0F/yMVahFpGhD6RxAHD2Q31+K2kz38YA4pisCWHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bopm7g3s; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5Te3MsdtXejDFChJ2CruxsSET4A+nyUeQlsrROmdd+O/pr7OuG2+7tstY3L4cwwiFjmb5uVU8aOkHd6KVRvHj9/4cg3ZbvIHDqw0DQGC2mpWg02x0VyWNB0vwZUvMEiWkiaPt+3gp4N1hUhIZemmJ0O7+EtzpQ4B5gii4UvVdTATAo7yPovkFRMT56/W8qh081NHm1oIhJlUgFVPe7r7tY2kuqqqJID+HWoeeQMN6xjXhqOPZRORHyxfAxPKmQJ45qgtT+8KeLBYJeIuPD8hDHLa33pFMRdRYG4c3jKdFbCESjUZAnKEf1k49I0GGAeptAg3VT5HLXEWGT4MN9tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx6pGpKnocUT876q75KeR4YLWF9V9VbmUfRK4WcRRgo=;
 b=FdrTnOL3zmPyg1Fotsz24grusVGkiOIeM6g9xM/RbSgX6VFZSwRkNIgOlvHRfvOz/ox9UVOCOvTkD+iQc2vXVk5pC8PHRVcvo+cjuNMAEvFwfW7zbO3/xWAdf4vwhq5Xl6r4XIlR+hFFL8iKMggcyczYDXL/oubR0uRvA59ZPiXQBngiH4IL683L2Yci/a3gZ7xk+5Sq3SZA46jKLsHMdW/v5p3H/eC4MVZZXEUTMbnq34m2qIARb8DlHgL7GdfJ1m4tWx6iQnaGTsrkrENbq1CFiJ5q9XH/b5ea4Zdj0+hGM848e8AIu8hPh7rU/cw1zeB6b6LqVdraVxgPhPx4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx6pGpKnocUT876q75KeR4YLWF9V9VbmUfRK4WcRRgo=;
 b=Bopm7g3saP02qa8ReFiIOxvetCdRyeohaWroO07QTS6yLro9r5+OrDfa5KECYpI7FiNJ5sZ2D9cc1+TH2m9bmOhHggmmvish3ZNl74djgkOs9hD43jQltDbRDwVGCWiMTWpajO5tf++S5pwYZpR/KWi5OgN7FJ924SSU7GDdvWSeL58R1gVazK8sLZqN9yna87p1yzsUP3CaKwIyrMHjuskis9vT5MYWXqeUKMfCCtqfc9AoAyz/4dbYWBMKSbIuy/ol7C16APonsleeFwIgop2+8rYvXkudl1wdbb5ajAr3+GoreWtNYq7e3I0juMmc4Xlb0gCNOyXZWimnSHIGKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 13:34:56 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:34:56 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v26 07/20] nvme-tcp: RX DDGST offload
In-Reply-To: <5d9340b1-02a5-4fa1-971e-a2a4baf77ef7@redhat.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-8-aaptel@nvidia.com>
 <5d9340b1-02a5-4fa1-971e-a2a4baf77ef7@redhat.com>
Date: Tue, 25 Feb 2025 15:34:52 +0200
Message-ID: <253plj6ywoz.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 23630ef3-ceeb-4e8e-e0b4-08dd55a13165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQuBzScCAfzs/LXupcGO2clL+kpSzWyDcnQwR8eii8KLCc1Evt6GLtC6StOo?=
 =?us-ascii?Q?KSuAsYVCleamf8AyGkYocK5shKVQ8IAFHeXYNcHoR3Tp9rtdAs0LchwO9DCR?=
 =?us-ascii?Q?pUhh/PqCJlIMVTVvuT6c4a/3xZOYUa1+ep+mISm6eSRR+gcpEFMu6iS93xnf?=
 =?us-ascii?Q?l/2L0LfZOh1QZo6a44VYALE1yhDuFmXgJ8blXvmVZhq5fZQI8cfER9ldovh/?=
 =?us-ascii?Q?7SkgpDHsYMQnFedZ72LHXZni5AiR9BhRxJvppOXrl9nPSmpv0z5tmygMTCsh?=
 =?us-ascii?Q?aHN91hX/JoF74PBbvFV0SxsglqDWQBM8vnfT879Ftl2oz3Ozd+VowtOPqf3S?=
 =?us-ascii?Q?PB9IfieqbzHLJolvCCSHLDyhERXGVt7k/TMflLx4CWleaIdzOmHFHbhoCPd9?=
 =?us-ascii?Q?s+SnrnR+YLXLrFJp4bSUkfS6xFvIlEfZ246BwDJsm9A0x91W+OJ4T8Ed1a2S?=
 =?us-ascii?Q?5TSkqJPHdkdvMt5kMhI86n/991Yeab3uWVrZSNutfke3w1A9ddwlTgXRA3cT?=
 =?us-ascii?Q?JsT+itRM2DY76xo4nB6yndRy0W2b/fvu9jfymiaRiVZrrsH/x3kpvcrGAdQK?=
 =?us-ascii?Q?GjK+D9ZdDwYX1DUdix+XnUVvKXql5QcCIBHrmIXwIfGcr8OXwsITfJjBCS+F?=
 =?us-ascii?Q?C1KZYPXZHHqBFa0++uTakiEwTKqf2ozkGlWSuBDhTpYNfbR7JEQJ8hBzZvTR?=
 =?us-ascii?Q?894mnlaJaLvOG9T8lC5pUKnCpmHioYzCGzAXG7Wz1H8HlutYQOsR+SS4ZzJm?=
 =?us-ascii?Q?+5ubDdA7Q5yyfhV2RAF1bD/pobXAATPSts0bhkyapyd3v9NDrw0ZCAoqtCpO?=
 =?us-ascii?Q?mGvfz9nR1GIqxdvAnTqpJcZXwdROswH+uDvzPXWyjOL52k+nfN2luZBRclEP?=
 =?us-ascii?Q?GkDFM8QJHvkzqS6ob1YuXboQgPvaGS4SxpT6xzUI6e6rxalctla1Yrhl5wOc?=
 =?us-ascii?Q?R+Vld7DgW3ObZCh48sMhqSKFR94+XkmCB2fXvzTcUrLCQgXE47ypK01603b/?=
 =?us-ascii?Q?adBIeRK+OHlpubMoCd4lsqP72Hg9QHRDDBVwOHX1hB+5YOZCTDEpjT1YRdAa?=
 =?us-ascii?Q?y6uxnVTIMkDtedpNRmJzJtpajHX+Dyz/aXMX3kO5+Wm263JkP+UfqnaTBbuM?=
 =?us-ascii?Q?R9amrPKlGJfM1OJyqkopItKmRAaS7CBa3Pr0ff0p7lUwpxEDV3f02M2Z0Dmt?=
 =?us-ascii?Q?dvnc60vhhauwCLCGr383vQQj4j/S1IU3AMvsZLLRRL4PSIgiEpcgdOJgkmMQ?=
 =?us-ascii?Q?9msBcmrNwWtuitPlqDwKj/ohrr6qEz9Jsy+c/1dHOStkN/tLlihSigYT+yQ6?=
 =?us-ascii?Q?Vr7vvD36mYFAa5EX3izw/7BUy0rMIcQ7QqZor3D6RfbzMzAdWMHuib0WyKoJ?=
 =?us-ascii?Q?b5nIIxgQNKeyMA1hav22WQA6yUVdPjRBuO9zTSeOHMtgvPl0t9w+V0Fjy6q5?=
 =?us-ascii?Q?SgOf4SuqMYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gepReLbMxMf/yyeRxMDwTwHgnBvraTMtjdTWc7et/6Uwe9n0BN8Zo5OG/qTW?=
 =?us-ascii?Q?2MWGKAyh5rzpLDkYzt8wPglw+gEteFjMmw9iai4KE2tW+x4X/b5YByzxIO4Z?=
 =?us-ascii?Q?VGwnQi3m5l777fYPmBwgFvz6C0bIQA8bb0vCcOFeNtO54VuYuz+P4caNeZBb?=
 =?us-ascii?Q?e4ttiBUCuEMlrvClXAkrif8YwaKxvSu4TtMCKjm1jnCrJk5PH4WR69FvOgpR?=
 =?us-ascii?Q?SDOQ0YAeOFvJNK+KyWbptjALGvi4iD9TjvSd+dGuYZkwLYl9mXE040TBMM71?=
 =?us-ascii?Q?4BcIklduS6QvmKiGnYqm3bwrI3zTFuO75Sq/zaKdLAbTPRFlJ8k8IVGrp7Uc?=
 =?us-ascii?Q?8mY3lmZ7nWdEihL9zDO+r/BbNZ89dFq/cD9Ffn5UoiQbmkNY2IIP7YSBtUyt?=
 =?us-ascii?Q?hUB/yjKVxOhYX1xvdMIQaZADvpWuZOfB9qhGpOr3QRRr77QmCA6pWuZMS7GE?=
 =?us-ascii?Q?0crq/9ZHjb3aCxHxSC2TTIFTPfGNnKq0FWg03LLue/bX8D/sXxAEE5k2cBFj?=
 =?us-ascii?Q?++zdEFWOKhWS1K2oH9htj6LQLRlxg+T3EQnrl0GD7Ypx2k/v4msa7ujNLxIv?=
 =?us-ascii?Q?xuUpGGs7oCs+xFG5DCxIkNW7AAfeTdmx6LlE+MUjjb7w66gdWJxvgORBqYjT?=
 =?us-ascii?Q?2LjafvgQwgtuhjzNT85MUfb6zjAl5jjFKqBRVLtsLjRmzNPyR+aU+1qb3Rhx?=
 =?us-ascii?Q?DNeVWYtDGClKE9deH3yxhqaoXKMSkyJIgks147fAnX6PEXFYffY/x+Z5pZSQ?=
 =?us-ascii?Q?lC3GD7yMLetsEHJ+ChXOuio5pB8on409JxX0VKDvwfTpwJA0oTGMGSL4SdTS?=
 =?us-ascii?Q?IiqJr7/iL1JS+No/4nU5+qtcokMthelx+knkfF8DhMiF+DNPtsbz/rMyB9Pa?=
 =?us-ascii?Q?IlFFeCNt2s+TwHJLagrmju0gpI+o8pUpiBbleBogMM0a7bqh4lFol6YvF43+?=
 =?us-ascii?Q?Zh3LVFhJ1piBM6XaVUPa7tkIRGJ54+devQtUqiGn6IvewlUcm6Qi6jfDMHzB?=
 =?us-ascii?Q?w/9uRTtunUfY9guXvgewkcOxhqI97b3ASo3VpEe7ONYlNkAy35pEhhFoh1BT?=
 =?us-ascii?Q?ItxXCTFupaOurlcceHvZjQv/tPd3B02PhqFAMmIgvCFXGYFZq2nKIIBR2n1I?=
 =?us-ascii?Q?JjI/ysy2nJ7zlqathmc0c4Sb+8tzQxuDSDdPENT6ZwFTEdwCtbBa74R81CX9?=
 =?us-ascii?Q?InpcLzPJTDKZ/VQWJcclp7EabavMZkLm00FZSwMMDFJhaaUcm2EAspDn65j1?=
 =?us-ascii?Q?1TdcnE+IPf3ikhmwKy9gq3aYjBykiVdQk57P9QTBg9pJ1paWBYeiJXxLP/hp?=
 =?us-ascii?Q?xI2q2bJ5x6etG/RQa0FKByzYi6niC0EhRk5qDt1lBR5eFWbFpmEYxpprLveP?=
 =?us-ascii?Q?wwtBx44AGUXirUxa+k2uuj64rSHeijvFUHiKyyRhtJLRtqiVo15xtEjArTLs?=
 =?us-ascii?Q?/6PsTHpKkeApNOFYUwHFGl556KdM6MKZcLsLmrZZJAGzfNDtnUq4BKpoYkmT?=
 =?us-ascii?Q?uWp3baIQBuSSZLU0ih1rtEd7L1YyIep5FUId/eduugyCCKHY2CcFjwC27FEs?=
 =?us-ascii?Q?HjpOVoJRhViMuQLy7LZuoow8XRyACLlJGbVWo7m2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23630ef3-ceeb-4e8e-e0b4-08dd55a13165
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:34:56.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0XiYIp+GHNLoWdnFpOzOT2Qe9p1w8vmJKJt+BWMYCrwAtcdHi+s+2o/Dst8z6+wixwLqAsfPkYv5fy6EmYclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

Paolo Abeni <pabeni@redhat.com> writes:
>> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
>
> 'inline' functions should be avoided in c files. Either drop the inline
> keyword or move the definition to a (local) include file.

Ok, we will drop the inline.

Thanks

