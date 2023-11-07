Return-Path: <netdev+bounces-46474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893E7E4651
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A83B1C2042B
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719C30FA9;
	Tue,  7 Nov 2023 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEo+jKW8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D16168BC
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 16:42:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5293
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9TRakAdfO4WwDuxHhMwHhweYvVJPUkNLHvS2jECU5QRj3SGkB3Q+a0CtUavBpiTm0wL6ucx55akyY8vp2OyWSqf9DbaTKGSF841G+xVwSPrkMecfYQ0h3Oao3OSVpTwtBcTmZnIonHv7asPfLHqv77W8krQ+XDWmKWXrw+ffM9q8FsJMeIupRbi8hyYjBwiX0r8Fnh0zpQagWSUVR3E19gnM196Gf6lO0oSwGwE2xkgfHqNX8g1BYsAswyDBBJNCDOgeQmTL2latOH+eCFV9FQ7CgjhH8TX3GzJv6Hfimm7uWf/veEmxnWGWf4RzK0c0mSomuQA2d7dncEuHHhJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuEC6T7c6ez1wmzJbkwQpZsZ2NQAcnCEAKXRPokdBSI=;
 b=DaUrwjtaRl1vWd5n7dVWRviZsDR3lwBav5Xp/F/hyJuWbMi8cku7zpcUCydrr4SuA08YgSwXy24KRn5OZ24/uNKa5Qrrg2XNi01z1jGJZtQ9+tOL+/WGnLX39YN1zGFqnklkGPl0V4SeV32ABaTmgRDfIan7QBbDJ0B/r6s72aDd4baoLx5fNrBx/G4t5hILMB7JpCzJl1zssh8+v5cYNJZoieLw9So6rzAuwkjF7p9S6VdeHQtby5jtJ6L0xeZwWLQmvb/44924J+qtHlvbePVXB5JCOFpU+jCo6tMdMIL1cqgjDCPLnmaF2sP0WQGn00Lj81RuSpxcl825DEoEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=netfilter.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuEC6T7c6ez1wmzJbkwQpZsZ2NQAcnCEAKXRPokdBSI=;
 b=DEo+jKW8UqWfTD9JTLV7w4djZkVBlz167AC6P3HLTeRjDggEE8KG3ncHdWWMA1f3kTmrPVuxddFVMjEdZsatl5mRwC25kxjVLIO3uL83RuD/2vi+qO8cT+gKvWraAp9b9wPcvkE/rlpcjLpIuj/W7UkV2lnhlvMqieR+GG64yMp1drmCzrTydhXNYLSx1+ObAMM0zbyciGszoG0i+ypPgEh9M9HLDPLkeImVS8vIfPO6jVF2+4Mu4f2phqTJ9TRroEGeg5Xcx6lE+DdKEJNmdNndRh3AKQdbOS2fvGdqiOgU47xV9q5DYH8guCgw6FRNA65othNymayLpKoR6tTrrw==
Received: from SN6PR16CA0047.namprd16.prod.outlook.com (2603:10b6:805:ca::24)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 16:42:33 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::fc) by SN6PR16CA0047.outlook.office365.com
 (2603:10b6:805:ca::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 16:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:42:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 08:42:16 -0800
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 08:42:13 -0800
References: <20231103151410.764271-1-vladbu@nvidia.com>
 <20231107162754.GB173253@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Vlad Buslov <vladbu@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
	<jiri@resnulli.us>, <pablo@netfilter.org>, Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net] net/sched: act_ct: Always fill offloading tuple iifidx
Date: Tue, 7 Nov 2023 18:30:24 +0200
In-Reply-To: <20231107162754.GB173253@kernel.org>
Message-ID: <87il6dldlp.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: b18ec94e-e724-4899-a91e-08dbdfb089df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mH6/62doqlLRKB8V7LdazHm7ydtoNH+ij5YoRARVOXcQg9VzF/j3sRu16V0y3a8RLuQM08Rmj8DGtb1Z5/88RYJT1VyD66V+Lt1e7EXAPdlgu9URhX7ytP4ZmMXbj4hTfIB50BZ3g1aZjjk3lFpxw6xoSHzUHgrv0Uc+9fQkD1gESWSpE4h2mAZqrTuI/w/Z0jcSRHqCwelTMQJCDU2Ypw3RPQR4aoVt8gxeEjjXPnNyddKXJke1ZY/mBQVDn0plmyQmXgWzQwDEGoTxDrGEZi6KAoMR6UaGxod3IU0e4IWYSX5YWbt43fWoUjNIkNLucaf3KZVokOjCIqof+BJw/8r+t6YGsh2w73IhOGQWfvo+of/bzcrstngJuM16osG3fLF0lbjBPdWddPj/DFGfnV3l4Z2+jOG0O1Wak5OuvqmGHg5HS6ZhkmiSt/FFBvBUKJqZ/7YRK89N972GqYYNlvEEwDI+VNkbbQNRCXxbux3GlRjkZlczrTTlLph5CksCOrCPSILz2stq7ahqSnLUVRnqANTWiEB9YZkdvmHKBSMf+kMrJtM4rIwg5Ia3iB4NKj6potUl5nScI/eOlSC/BZ69z1PN346iQ7MjYx4oZfbb7iqgn4HNHBpSD0yGG5lr3UXPVn+lzMZwSkXLSowgNYGlr2jmLAgvZtuAAGXZpGxuaimTCmniVPStTyNi+8UkxYVCz0826Uwn4rlqmPjei4ZlnX5vPt18QHIewYOjxoibP2ip0O2l8KY8Rek+NVJt
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(2616005)(40460700003)(336012)(426003)(107886003)(26005)(82740400003)(16526019)(478600001)(5660300002)(8936002)(8676002)(36756003)(4326008)(86362001)(41300700001)(2906002)(54906003)(6916009)(316002)(70586007)(70206006)(6666004)(7696005)(36860700001)(356005)(7636003)(40480700001)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:42:32.1869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18ec94e-e724-4899-a91e-08dbdfb089df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388


On Tue 07 Nov 2023 at 11:27, Simon Horman <horms@kernel.org> wrote:
> On Fri, Nov 03, 2023 at 04:14:10PM +0100, Vlad Buslov wrote:
>> Referenced commit doesn't always set iifidx when offloading the flow to
>> hardware. Fix the following cases:
>> 
>> - nf_conn_act_ct_ext_fill() is called before extension is created with
>> nf_conn_act_ct_ext_add() in tcf_ct_act(). This can cause rule offload with
>> unspecified iifidx when connection is offloaded after only single
>> original-direction packet has been processed by tc data path. Always fill
>> the new nf_conn_act_ct_ext instance after creating it in
>> nf_conn_act_ct_ext_add().
>> 
>> - Offloading of unidirectional UDP NEW connections is now supported, but ct
>> flow iifidx field is not updated when connection is promoted to
>> bidirectional which can result reply-direction iifidx to be zero when
>> refreshing the connection. Fill in the extension and update flow iifidx
>> before calling flow_offload_refresh().
>
> Hi Vlad,
>
> these changes look good to me. However, I do wonder if the changes for each
> of the two points above should be split into two patches, and
> if the fixes tag for the second point should be.
>
> Fixes: 6a9bad0069cf ("net/sched: act_ct: offload UDP NEW connections")

Hi Simon,

I considered this but decided to send as single patch because
connections 'refresh' mechanism has already existed before the UDP NEW
offload and it didn't update the iifidx. While yes, it wasn't
technically necessary because only established connections were
considered for offloading I'm still leaning more towards considering it
a flow in original implementation since UDP NEW support wasn't the first
change modifying the offload behavior (43332cf97425 ("net/sched: act_ct:
Offload only ASSURED connections") was before that), so further changes
should have been anticipated. Hope this clarifies my motivation.

Note that I don't have strong opinion about it and willing to split the
patch, if necessary but to me it appears as just more trouble for
maintainers without any benefits...

>
>> Fixes: 9795ded7f924 ("net/sched: act_ct: Fill offloading tuple iifidx")
>> Reviewed-by: Paul Blakey <paulb@nvidia.com>
>> Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
>
> ...


