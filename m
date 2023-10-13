Return-Path: <netdev+bounces-40713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0787C860A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC18CB2094B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C013ADA;
	Fri, 13 Oct 2023 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tvxtlm4M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34037A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:48:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C64BE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd780qu9Qu9pjR0xoz3I/NP0BIw6f9f3uNkctAZ1ebXix8QVVELxu850+80AeaLG/lP9kjlhIm0mpHwkIyyk+QjMbJRr5nB+jnlFjyJFzwTsk76+SnHmJkILu9gs1BKNTM96zF1YXkjm00CCSs3ep7lAkVsWJcaoXYWKKAUr13mA/qcTPNJB1lbDg+jxjI3liTT6MMp/gBMoFKV4Fz7IOlC04Kixz+CvngOl4DrwSoQWguhBJtNk5pgxJXc/fjy/a0qyexTCuFZqNcosdZ6hQygATrBSH8JYLiGD5lUbnbFwxjgDRhvUXdsDtKtWI7Q/MiuYm2qkAeFhgMv8K3wJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mC+s1P2nvGgqhTLSXHs1lw6Bz8yjsk6HgQ1wybizNE=;
 b=jU2z1MKmV/bRdT+XUo0a5Y+1OhdEQavScGpjQzq+NqfFei6EE4pKOi0kQaStO1x0S3qwKMxdPJxl9gx80R0I2SP4adOm8ImFZseFULtHfCtU3sdB4Gf+y3E9a4lsHtTlS3c3gRrc6WNNwpsP3oEv0hFYBe29WMZLTnxNmk2daOhdChKWMC02b+o6L6y1/pBPrIN6iOd7yUoIXC03G1rMMI7dKm877UWXp+lll+q8rBsAyhXskJ/xAX8eG0ISEKmaCQKOqVePQzlFBpE/1pYYQbxPuu8iUjFM08f/bUZvMv+Fxv/EyNZDwW2CsbgO+WopF9DWFatDRVJ5kWXY+oao+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mC+s1P2nvGgqhTLSXHs1lw6Bz8yjsk6HgQ1wybizNE=;
 b=Tvxtlm4MruhGMAem6q1cHahnJobAvHr7ggbo2f7TojJBK1rHgblMM68/xkr489Li9Qu4ELfLrDB1qzjdWZVus7pvR/cpN7f/QBopRYBVE4ZVRomqHq1zBkDzDZAPp1LFvvCnQDUIgbc4DWEbUcdxHVhq/SGQmtAqgGU5Ps+Akngv4iyIkHa6XhSh1yx61wwAViBRvMobkgsvRi22I1FWYkP5aDodGDxztS9VgVvg/FS+FRsBuGJXKglaEEUM/Dl7gW0yzkozEwMtfIzC0OXGi6QD/fr5Ec1ijDGHeIaJ0x34992e0ktoeAdwiyigZKGcEOg5EbpUnikwdbpeKapFlA==
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 12:47:52 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::7e) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Fri, 13 Oct 2023 12:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 12:47:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 05:47:43 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 05:47:40 -0700
References: <20231013041448.8229-1-cpaasch@apple.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Christoph Paasch <cpaasch@apple.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Petr Machata
	<petrm@nvidia.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] netlink: Correct offload_xstats size
Date: Fri, 13 Oct 2023 14:43:05 +0200
In-Reply-To: <20231013041448.8229-1-cpaasch@apple.com>
Message-ID: <87zg0mofiv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: f6529a8c-087f-4a9a-e3b2-08dbcbea9d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kw/m5yBVoSvvoMr2UkhYfvZqsECG6MU3ZEFg17RAZINhZUJBhgF0XOchdmJdBt4tXu+uRSYisGA2tDzvMHnl1za7tHUGjfkNDEELjUNNDWQbIhRMUYsLWIbsFvfU5e9IbGSZrXXJFx8rdfJo8Tk22AwPkI3EChf2oZJlZ6N9qCIFSQqQ2RitoBCKywhOhQ9ZY256mxHW1v4xJmhEp+VpPRNxfcrbYfLNNuKakBTWGzsxqokou7Zo8HVA5AM9oIpYPgyUfVucI2PVcMqakKkbT4/NwntneIuNgg9gZnQEjCQiyCLHhss7CpZYIhDjQbd/s3Eq1nAW+/AZ084cUfwnpq7Ar9qgHR+GR8f1vS8xYwYO1TSkTM1giOq3qeOhlxqrfRXgf18r7UpjSHrB2T8nCo4fpxENjOs09Nd+a69tQryDlzusbVZ4OFZ+8qpgVtdvmKi4v6HF8K4w/ShXHjukxKnxvXP2CJ+F6Ht2H+mF+fggBwmKCkwC6x5HhKpHwxlaIQolseg/iFH0o7MNQgdpLeR5ezSKc+zcd+NjoXdpU7jN21X2dNbyQck8T8ScMnS0tzEidCi3981KVqOw9ttdhY8dbo//7TEmZ7mUItm2EqGKZ9hwhUFKJk78z9Di0Otet9t761yvdVTSCM1t0JoUR2atG3KhiOzwr2O0Iszc6GkfxbFpMu0Krw4vMRLEUTwV2ZOip4dNBpdnOI0aZfpIJB9z1sDg1dKsTuPNohtagWmQxUP8pErxCPN1PwRqR9yu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(36840700001)(46966006)(478600001)(16526019)(82740400003)(316002)(6916009)(6666004)(54906003)(70206006)(70586007)(4326008)(41300700001)(8676002)(8936002)(7636003)(356005)(36860700001)(426003)(26005)(40480700001)(2616005)(336012)(83380400001)(2906002)(5660300002)(40460700003)(36756003)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:47:52.3660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6529a8c-087f-4a9a-e3b2-08dbcbea9d58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Christoph Paasch <cpaasch@apple.com> writes:

> rtnl_offload_xstats_get_size_hw_s_info_one() conditionalizes the
> size-computation for IFLA_OFFLOAD_XSTATS_HW_S_INFO_USED based on whether
> or not the device has offload_xstats enabled.
>
> However, rtnl_offload_xstats_fill_hw_s_info_one() is adding the u8 for
> that field uncondtionally.

> Which didn't happen prior to commit bf9f1baa279f ("net: add dedicated
> kmem_cache for typical/small skb->head") as the skb always was large
> enough.
>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Fixes: 0e7788fd7622 ("net: rtnetlink: Add UAPI for obtaining L3 offload xstats")
> Signed-off-by: Christoph Paasch <cpaasch@apple.com>
> ---
>
> Notes:
>     Another fix would be to make rtnl_offload_xstats_fill_hw_s_info_one()
>     check whether the device has offload_xstats enabled. Let me know if that
>     is a preferred route.

I think I decided that it's going to be useful to get the info always,
but then neglected to update the size computation. So this fix looks
good to me. Also, it maintains the same behavior as before, minus the
size computation bug.

Reviewed-by: Petr Machata <petrm@nvidia.com>

>
>  net/core/rtnetlink.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 4a2ec33bfb51..53c377d054f0 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5503,13 +5503,11 @@ static unsigned int
>  rtnl_offload_xstats_get_size_hw_s_info_one(const struct net_device *dev,
>  					   enum netdev_offload_xstats_type type)
>  {
> -	bool enabled = netdev_offload_xstats_enabled(dev, type);
> -
>  	return nla_total_size(0) +
>  		/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_REQUEST */
>  		nla_total_size(sizeof(u8)) +
>  		/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_USED */
> -		(enabled ? nla_total_size(sizeof(u8)) : 0) +
> +		nla_total_size(sizeof(u8)) +
>  		0;
>  }


