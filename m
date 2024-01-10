Return-Path: <netdev+bounces-62822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C1829817
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CFC1C219B3
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44D47783;
	Wed, 10 Jan 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WHNLC54E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE441773
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6+rECa+TFxNSU8yuV1WJ5kW6NpMZWdcC7glQ8eqWzRTJDUa8f3XUDtSwwrqrh5yA3B08xxHas4ultx4n8NCGy3blcua6taRaCXE6w5efHaaTC7lmXfE/ajCO6wr23JSVKWvSX0Tm/S26TQ+14A1Qz1DbKNPjByt190UuVC9mTboNFhF8p1l2kX9vIqiTnxUnolQ5tJDhKn9ouTX9ONHTUhRTAPa9346hGP9YeoGO4u9T1DWDMji25ZrEtfi2IQDS5NmDtI00nb8d2iEk88sAK/J15EEFvv1f/XBoo8oKDnAFcJf7/M7NCDyExtrVTp4cB/dl3e6KbhbWKM6VyFTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m4I7WlXAyQlNIXxWX5E6ERvCum2L90iOjg8duIGxGE=;
 b=TW5HwZLkcqZlRe9rGWA6AWusA9Gzmbdv7nAeO0GdtZY95C339hG65PJeIhcetHKCu6qCdsXlEqOXSvJf8PPDHqlH0+b9DBBK/7xJdwXrvrZT22nsDAEf6lNLSbJ1Vk3q75jSvmrmB+i96M899gfGevS0H9oF7LeHxrRarLorfNbN2DwzlQ66hudVRUAInEQG5ltIn7qsgJL/tMtbGnG1RS4xQFd7SDmUxpwnYedB6j5ME+i30GOnRDpy5AnCLQ/KHR6lpyUjaO6rUuIPMW7KKrvX/iZfVaBnh/FTqgVl0Cg0pfqIIxDHmsGRM7V+euvKRU4DUT8kLlypcRZcO4fnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m4I7WlXAyQlNIXxWX5E6ERvCum2L90iOjg8duIGxGE=;
 b=WHNLC54EGsMZsVFZxWTbeqNYfiAkML8l9k4bnwXJ23gBIwhjz4w3oW6UEk8XAk+VMwIp++gDnA5Iunaz0XsPoSAJfi7pVgjabzoU4jTKSpciFaoe+M6x7w4q8zH2epcuklfwRfxQT4b99E2rqEvpw2ChDXfWckWCVpKdGqZgUTE0lfLdE6R1ouVMonl8h0GTGWmDZmKvt67v7Yr35LXN3kjgj54q4HTVdRzEal9zmuGNAquKgBSmn/ksLT156iin1PENyGzC0ctJ1RhIzBRQHAqTY8mrv1tdfqCZMedVmDjiroJ6egF+pEdL0DjjLLXkTAUYgZlPaZK6fRceEic1Zg==
Received: from MN2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:d4::24)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 10:54:43 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::18) by MN2PR04CA0011.outlook.office365.com
 (2603:10b6:208:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 10:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 10:54:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 02:54:31 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 02:54:29 -0800
References: <cover.1704816744.git.aclaudi@redhat.com>
 <cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Andrea Claudi <aclaudi@redhat.com>
CC: <netdev@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Jon Maloy <jmaloy@redhat.com>, Stephen Hemminger
	<stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 1/2] docs, man: fix some typos
Date: Wed, 10 Jan 2024 11:35:38 +0100
In-Reply-To: <cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
Message-ID: <87ttnlo3vh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c21038-aa9f-4e78-6086-08dc11ca8c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pl+5xDe5JgrTSsSOjinudgGukN5V6YWNkKM8p+1gSxI+NzWbRPdZ6Jd8oeG/borA96Fqq8UDsgewcfRUo/OMzDmBBxeZdRmbFBXsq7h0/zj0qZDut0Z9hoe9TVcmiipsfzoWBZ7tjSbX9LHHodGRlHPmv4dapsk3TkN2qnQsUYIImflffMFNEqnlmvB5ArYXNCQB9YXTZrt3vWHyGeLCeqg0anpBow295Jr7c3L6wGI0fdn0WREH5IgsK70e+MMvdY6nLSvqqjhf3nRXKSFm72eVtMeo913XUe34m9HjqczvGHWSp9JX5Xiuo+gkP2HoZ0yx9QBu0ijqcY8bykeIAj6/Mv3xV/MBWYYSWrbigOcE/6LrGU6T7RBVvCtVCo9Pa8e9VfSSqSTu3C8LdjmORUhgaomeXUFfSPVHW2gP+x7MIQb5jr5sbwYi4IZRECIsLjbrqvaHuTqZvNo/riIxg/TSknz7sz6KscPEpZHq5HAeX6iPN3Swfz2aMuB//ruk0ukXUfi/Hrtm6Hv32Bh2Xzm+YGQL0mUfmTnIhO+d0LREUL3S7JMIOIXa4qdlBQ9ZWaCAtLuU9fWe7Vm9I1+YyNKT4t3vFoqKLpIITVrnmiWOVrmbkkUlY04VBltu90gBlX7Z5bMoN8m6ACmUJIGPvLIlHcoPQy9gMUIakBa6aeKGKOuoNOSLu/rH0mYmPY3rbeuP1Np+b4YoZWsGK2MelvxKi64rQ3mvTwFr2tmgeFgeiXoCg3ZFlQWgTGAQ7hua
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(4326008)(478600001)(6916009)(6666004)(54906003)(70586007)(70206006)(8676002)(36860700001)(8936002)(16526019)(83380400001)(26005)(426003)(47076005)(336012)(316002)(5660300002)(2906002)(41300700001)(36756003)(82740400003)(2616005)(356005)(7636003)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 10:54:41.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c21038-aa9f-4e78-6086-08dc11ca8c8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650


Andrea Claudi <aclaudi@redhat.com> writes:

> Fix some typos and spelling errors in iproute2 documentation.
>
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> --- a/doc/actions/actions-general
> +++ b/doc/actions/actions-general
> @@ -116,7 +116,7 @@ The script below does the following:
>  - If it does exceed its rate, its "color" changes to a mark of 2 and it is
>  then passed through a second meter.
>  
> --The second meter is shared across all flows on that device [i am surpised
> +-The second meter is shared across all flows on that device [i am surprised
>  that this seems to be not a well know feature of the policer; Bert was telling
>  me that someone was writing a qdisc just to do sharing across multiple devices;
>  it must be the summer heat again; weve had someone doing that every year around

This document reads more like a newsgroup article or something from a
zine than a formal piece of documentation. Even in this excerpt we see
an uncapitalized "i" and a "weve", and there are many issues like this
elsewhere. Fixing it feels a bit futile, plus I kinda like the
slice-of-history nature of the document :) But yeah, the fix is correct.

