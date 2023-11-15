Return-Path: <netdev+bounces-47944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498707EC0E0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30E0280CE2
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CDBFBFC;
	Wed, 15 Nov 2023 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJMML6nN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A537156CB
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:42:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD859F5
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 02:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqJuCJbCCBNcDBiKji1mTadCpGPNVKFv9ESC35ez/kDiIiVG+wovZGqvOCmH6zfY5YZaw2trIC4hon72BunuI4Xf1gS+6UpMeOGn7LlhAovURM+DL9x6075tIXeZqyK+5LHnySVqjJyX+O7Kie/UWz4XfP+Mg5kwpEzjOSu/SXFxcjqOTt+MdqA3Qk/kk4G0fqxBd85qVPaflPgy+qepu0NIoAtam0j86cfG2fU8fKwNBZ1+bNfAt3c9scGtmDqZ39LmdnsTYvc6/AznxP/8T84fvhOkTmlT7mprfHmTUXYdja5XjdfgupEz/Y7LUzdpEPUc/Sw0ahFWOgPUrnD2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzjDSNIzRkVNe5F0v/5y0THXZ/XDkJXF4o2BFWv0eXE=;
 b=OindPSGFALoBiBHgVQJM46A3HutQP0zlOZpdmY5zeQFWOo/V3cQP6ynlgeL845TsNXyI0l3qGLYGfnSkV8KGSEy7vymU/YJ6u5pnDU4E63siiPY2pk7jSJR8tzcBLBoRoBJA4OsQx46R4NUIWgtX6tJQe/DL2c26VoTw0ZEWFwmaIwe1qp/9+lsMKALbLm4qJEIOTN5OB9JIycAOZLJn0vTk2m5pBLqiMnvSCJjSdODoB1zekUAQZrNJP8n+Mklis954q8AyP9a44rxaA3iUOD4nLxvuJqbHHT3o6/DFXCwT6XFUO7yRqWmmEHQCBvilqyt20tyWR46nfvBGihLkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzjDSNIzRkVNe5F0v/5y0THXZ/XDkJXF4o2BFWv0eXE=;
 b=MJMML6nNLB9lSTzPhSsW2iNfH6/+G7Nj9FYG5xFSITLz2jBtqwr0vSMs2vsr+QwTheiJmoNHaudn70ADUAyssnH53e6QbAwgqWJgjhOAyqPYTbZudtcFfT1SaiN8s43GTZ3dNTgoRu21h3GawidnYFxqppLiYKx8/2NQ6tSVcw1FEqTo+ila79g28KqRR9DMLE+TiEAZWgJTu+sSvSzsd5L7Fvk3FpXW2Cs3c3DYu6vhFFGMoWkJzeLdgPWD6LfY5riQ7KpNBB88CqKlruJQavIOU6c69rxKcbRiPfi0Pu16HV6etesjdv6oqV+RulQUWPhU5Bc4SjEFwE9o4LzrMA==
Received: from PA7P264CA0014.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::20)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 10:42:32 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10a6:102:2d3:cafe::72) by PA7P264CA0014.outlook.office365.com
 (2603:10a6:102:2d3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Wed, 15 Nov 2023 10:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 10:42:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 02:42:15 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 02:42:14 -0800
References: <20231114081307.36926-1-heminhong@kylinos.cn>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: heminhong <heminhong@kylinos.cn>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] iproute2: prevent memory leak on error return
Date: Wed, 15 Nov 2023 11:37:16 +0100
In-Reply-To: <20231114081307.36926-1-heminhong@kylinos.cn>
Message-ID: <87ttpnwb5o.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3f12bc-0ef3-40f7-ed1b-08dbe5c79197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RzL/rT+sDUDtnQhvXgWT4AmGdOlXdRQb2adk7iP8ZD3B5VMVbjqXauoKf1BWn1Y/gM38OGNe9jkm6OQBgz7CPnLpLQWll9E+fg3ihy5k7vu8zBo8ChFJwmrvw208jEF/ksqPBBXnlKh3fs3fmYYgO8MqHCHHy132K4ee79Ei/sEvjAUdQPeN1FWzKaRHaaGmfKPGPS0Riykj56/8S9taEPyfLwaJ1ApL63c5jjUOpcYTLShXysPmfXSwmOQzydx6x6SBhKROvm7DgJoUa5Ya98yAzPHxxs/3AS0VTZ2RVlrpZJ61xIPhc93i1P0dm7D7/bOO9W19ZNcVUqQnIsSuBTKnV0b8rNqkP3kUCVHAN6WuiGayNorXQGG+HKXPAgjgptU602aaCjTC0OgUkD7yBHr5XFBt5eX74uX1dEjV+wcAaKpblRUow0q5C5nGZVxlzBbMX2dH+hkcAhbwStN+1L5oPFpbFTwq+2rUQ3h+wdY50Cb/TIvDsTKyzoXCPUXsGVBOuyaE+3In5LEGvg5m6DoKtszEzL1tvlIAC7BFQLmdCZONgr3DX+7AjlGe3Zqg09Bjmcpk7Dw+7tTKFkr4wXqAPyIJp8QCsSSP1ytObdNvuf6SCVX0laeKQfD6mQ27P5LrkRSuoNdAtbxEL0tNu3jb6K9zOkrdlTSRSZRHE9+RblhiPmfZ/KPtbom6V27dakIVDUPBSsUbKsfskcR70aWzrqFiagIiTP2/aofhVgYICHPUmyda4ZOopN2lcMG4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(2616005)(426003)(336012)(82740400003)(40460700003)(16526019)(26005)(478600001)(86362001)(8936002)(8676002)(5660300002)(41300700001)(36756003)(2906002)(4326008)(558084003)(70206006)(70586007)(54906003)(6916009)(316002)(47076005)(36860700001)(40480700001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 10:42:30.4462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3f12bc-0ef3-40f7-ed1b-08dbe5c79197
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682


heminhong <heminhong@kylinos.cn> writes:

> When rtnl_statsdump_req_filter() or rtnl_dump_filter() failed to process,
> just return will cause memory leak.
>
> Signed-off-by: heminhong <heminhong@kylinos.cn>

Reviewed-by: Petr Machata <petrm@nvidia.com>

