Return-Path: <netdev+bounces-42542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03287CF46E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75DDB20F8D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA01772E;
	Thu, 19 Oct 2023 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B0Ie6D8s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C81772F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:51:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEAB8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 02:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHXcU1ejJULAy5E2IZOkzlJh7mLyQKpCxh6aT1SdkehiGgUQyvk4eRlOzaxqtEbGApzFWBgWYmvfOhNmAQ3YTTJuGXIUEZcw+t03ayb7cjJlky0wKB7FrpRe8qqWJSR7UWodK6OboihJGtDkeE+GDG8Xsl760yH6NepFZCTxigHoaEYAcX8nGSANFgHLk4pf548fs2K0Fsw0W8dXxBYFQ0XOGwC1FmQmatO1Q+pJHcpLUF3hIvyP4lrJw7kb4njiENVPAD38VMv9ajcdmlq32IAgVTQePoov3leySSCf23+/ex/qG2Tt3zU5ddQ3F2RRCpG/XFg/+CLUDmEYghiGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkQljl9YXTzUNjyCU+BBoU8goswv4g544fi0YEtVCWI=;
 b=gm2nytoseIEJhKswZS6mP5dxeSaCBcrA2z1fCpT6dxw4BP16+dOMmvItezKLWJsoOfZJJAaKdU+oHg/aAkNzoa8TwGnPWuGiTWbeBnCqFXQfJxZIEBmOieWuC0ZtQ9Z5WUGPnv6xlhzT/5AbGVn2OK9de4Ass+RWUKBKgnslwQDdCYnlg8UrNnsOl79DiC8L8HDhKYPDXuSW9TEbgiqA5YTZfWwo5QZhO2mHY531lF3dmpLJ0XjzWtmf0gkcoVWGPVx85IO8h7uwdOZWs5Cw8azfpOQQ3+nGXmaZCSSiSD8zEBR4W5QqzqefQIt3n9ZD+4dv0ka0rLA3S1ndhrqwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkQljl9YXTzUNjyCU+BBoU8goswv4g544fi0YEtVCWI=;
 b=B0Ie6D8s7F3WGLT8vNY0aSdn75ddJYQ2Nrg327r0K7lWwZyPGotQ+3Lcu3+SxXclRASQwFX/c41A4WVwMiImBzoVVTlgXFodNRZ5S0agRCimTxa1qrSYlSVRWL813ktLw/lLi7TIWZ2A4D4cJYYZOsH+3k3jjxcWe3G6NfE1EVrrQxLbwg9jlWfSazqnszQAbrRVXImjxun1LPzYB2klRLHmz6C27HJFP0B032YhOhJByZJumVWos65QOK2p2dNqBzybq85gkh2JUm8cko5MkE56FyHyAQNlkZbc/met9eXg6O0jfLzpEUADkm9FFNWnrJQRzgeQjEL1i+fJ8m2nEQ==
Received: from CYXPR03CA0071.namprd03.prod.outlook.com (2603:10b6:930:d1::12)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 09:51:25 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:d1:cafe::4f) by CYXPR03CA0071.outlook.office365.com
 (2603:10b6:930:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 09:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 09:51:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 02:51:15 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 02:51:12 -0700
References: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
CC: David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <bridge@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2-next v5] iplink: bridge: Add support for bridge
 FDB learning limits
Date: Thu, 19 Oct 2023 11:50:21 +0200
In-Reply-To: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
Message-ID: <87il730wkx.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4636702d-2a52-4353-d695-08dbd088f4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eDOYL4ke8FRE5VVUGRtXECL1lu6hcZj5FrOiXWEzLGKHFT6YNuL3bklYA0PCKTXZhJ2PqKDbKznf8y0YhVferO77z/CwaqUQYAh0yKRr4C+/yGL5WMaiYk1xDqJ344pxUHUb62UjIghH1gWebdssbuvMvq4FtyWS+UUoitwnj2t6srKRBooCHwcPuqegu7jbRFXxfnp95XU9yJNYNttpaLhF1h9cxVI5adlhKMQnt9T7MzZXwPlZ4tlFIE6zswE37FCUqVVGB7bMla6Cr5C4s8ObLrQXTl+d5VbwjUb/I65pLsouZm3r+YI4FbpxFazP51/EWrQWI1GcX38Tk1il4O/f0KHfAHVXXx1yUGLXNEPA08pwGiMJSAugj+pQEYT2Zz1rMc4M+KwOGdYEf1Bjw2R5O0RXFT9Xnzw+jQSztctflobNs+sSHAao/Les8SZg7sIKamHHUOrePe9cAON29OE51dZk9YbHkx/vN3XsZv1b+2Orzc4YPw8dL2oa03gykBHbC4ipE3q07R+5zxFTTtrEYm3U6zS03fx5Na8I1fzoOP9iz0pAUlm4Dsy7qrX5ZFvD+orbqiSC4PC5udA+DKPFi6bPR4oiFQB8uN2/wRFv2MwlaU4DdRPzmJw1CJTIwv07OOtN8hgsLppOAms2+apgHDZTjY2Z2P1tPRAZyg4HSOAzLtwZRRAOHYo/lUzpVrNBD39pbHw2VV8YIFZipXv8NucQZkKm+/z4FuGnJpowb/gaXn0hr5R50PWtJqkS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(478600001)(40460700003)(70206006)(70586007)(54906003)(6916009)(336012)(47076005)(16526019)(356005)(82740400003)(7636003)(2616005)(26005)(86362001)(83380400001)(426003)(316002)(36860700001)(2906002)(6666004)(40480700001)(41300700001)(8676002)(5660300002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:51:24.5376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4636702d-2a52-4353-d695-08dbd088f4f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062


Johannes Nixdorf <jnixdorf-oss@avm.de> writes:

> Support setting the FDB limit through ip link. The arguments is:
>  - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
>                     number of learned FDB entries, with 0 disabling
>                     the limit.
>
> Also support reading back the current number of learned FDB entries in
> the bridge by this count. The returned value's name is:
>  - fdb_n_learned: A 32-bit unsigned integer specifying the current number
>                   of learned FDB entries.
>
> Example:
>
>  # ip -d -j -p link show br0
> [ {
> ...
>         "linkinfo": {
>             "info_kind": "bridge",
>             "info_data": {
> ...
>                 "fdb_n_learned": 2,
>                 "fdb_max_learned": 0,
> ...
>             }
>         },
> ...
>     } ]
>  # ip link set br0 type bridge fdb_max_learned 1024
>  # ip -d -j -p link show br0
> [ {
> ...
>         "linkinfo": {
>             "info_kind": "bridge",
>             "info_data": {
> ...
>                 "fdb_n_learned": 2,
>                 "fdb_max_learned": 1024,
> ...
>             }
>         },
> ...
>     } ]
>
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Petr Machata <petrm@nvidia.com>

