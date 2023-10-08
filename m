Return-Path: <netdev+bounces-38899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769F7BCF1A
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59534281724
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E71111BF;
	Sun,  8 Oct 2023 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i7KpsdSI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9B33E5
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:34:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8821FC6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 08:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leUxtOdn0IE07wKi1/EKFwDtaHvmltkuyYJMmVup2L6KfLzjOs5r3Z9TO1QENv0XlG33PqUspSFvr38eCfwHAcp3sFhhxQr1/0huEM1iT+mvRAbcgWyosxbfJziKrZrAUn9IcSzwiClQ533cxRVKhy+Xi41Bln9bsgg58Cx1SBCp+TaYPGF0c9S4Qi3PTROsc7XXdsVvpo0XpjpYaAcTgP3MGw5lrkKHUiSwaAKGh0/A20o1NCNTUncibl2XcKGaZpX8Ryfj0GmzDKBHVTDU8O6Ft3x5cx1wFgQGYaOL1nxGiX4jS0Qid3ItDi0JjA7KE4QURw6rNUuRknTkSfAmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdj3MGgNIZpOLb7Y6KtEfgD2wzv4CxteOSMmJii+AH0=;
 b=PO8ZwTI99KKloy1mOmIg2PD4r+k5EX4UihB8rZK6iO3uxq0azBbOWavVfC6h/cIelYxWGYw+5PtFajvk3heNx7fgdynAT0Kbh1HrNPb8vR2ZlmXAVi1FEncLPRkCQb/8jakx/32zsPopHcwEWm7bHxWx/F2/Qm9U3bvRPcO6+0eXelWGeLluWl3K2lUkfAzfYD2WgOnBjGXjlke6/CoSQfzDPa2PBx/Xp2jjwP/cGcPy1aReo+5YAbOwMHRYuOHNxhZ0tu8LRVkc4nHDEkUq4zY1WO0qB5nw08GdfBskrp9/LQb8XUm70nKxstz2Wb9rlQtLoAXs33LWuH6/3YYAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdj3MGgNIZpOLb7Y6KtEfgD2wzv4CxteOSMmJii+AH0=;
 b=i7KpsdSIc5J8cMJYgtMIEPZsjVNUgoTLfZZxz+FC6AbaFsHOFBfTvpq+vknAFr30IKLp7rAsH5aZrbdyMXhwoMHbmuY22oWiQt1yGi5hkJOLSLyyJHQbQunA5Ym7i87cTncnzKMVI6+g39RUpzsD8uZZGnpiFSCVRSWz7C+M7JfHhHqfhYwuCjsdQcHjVqEZD4Bw790l8HKkU8pc693yQVM5yR8ISaQzjLFfU7g7T5UzVk4F15uNDRrNbb1jWQXl5Sp4N6f2bUWUl8CMALz4uzuThUM8+0bwEaBdKZYK6+00X3bwTXQU0sVeiZ3TPJb6jt0u2LD4kp1ut3uMz9dmMA==
Received: from BLAPR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:36e::18)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.38; Sun, 8 Oct 2023 15:34:02 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::9f) by BLAPR05CA0014.outlook.office365.com
 (2603:10b6:208:36e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Sun, 8 Oct 2023 15:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Sun, 8 Oct 2023 15:34:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 08:33:52 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 08:33:47 -0700
References: <20230930143542.101000-1-jhs@mojatatu.com>
 <20230930143542.101000-6-jhs@mojatatu.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: <netdev@vger.kernel.org>, <deb.chatterjee@intel.com>,
	<anjali.singhai@intel.com>, <namrata.limaye@intel.com>, <tom@sipanda.io>,
	<mleitner@redhat.com>, <Mahesh.Shirshyad@amd.com>,
	<tomasz.osinski@intel.com>, <jiri@resnulli.us>, <xiyou.wangcong@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kernel@mojatatu.com>,
	<khalidm@nvidia.com>, <toke@redhat.com>, <mattyk@nvidia.com>
Subject: Re: [PATCH RFC v6 net-next 05/17] net: sched: act_api: Add support
 for preallocated dynamic action instances
Date: Sun, 8 Oct 2023 18:26:58 +0300
In-Reply-To: <20230930143542.101000-6-jhs@mojatatu.com>
Message-ID: <87il7hyvqf.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: e8081d8f-81ff-40a4-69bf-08dbc813ff7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xK9xHMNBvBXRxr1XZzAJNOqgM2YHtdYFqXTEi0y1+ZFiIHTH/ajljhlsQRdCR9lkRZvm4vw4XvSSGbloQM3UKI5pv4aRBa8fGoAeTVwwLfWtBb2csHXExUvQ2g86grWIu7RbetQ/hoqi3cG2ifh2xPqkuYs6+7gM0fGs//CeknCdVBDgbu7WKD/PGyJa//Ek0vgUPJEFCXVK6Cjka/cB//c+8VLwmvRnZ49a334dEYGcCy2JGwCVYK6nWAzhUY46Jy5RyC+AqkLgXNaaHdoz8185NInh77B19HyCmg+4cVQeOZBZIM6DX2vnxsFUobY4loIU1nrkotfYaz+ca6FMiG2sTizP1mHdSg8NrOalh3HiAogavCWiSJAzXN6eC36IZ36YCmowOSh/LAP3CiK5tLRPGth4F45A1rDzbaamW1rIFBsaFxX7lVRlIok6Y2aM3Ip12AqVt7SfWNG/TsxSs5e1ymAaCol4YqKHk4aJqufX2/aCbTMj78vodgJNHjO1RRRrsKo2CJOtfbZQt101H20jIxcFxBino3ss+Q2lOgIdhyZ0+Hue4Gm4uo26uJz82O2rBw6veWJ/iiViS/ZEwLRxpzCnC5l/7BodZfTJjE4Sk/JbuRJR7pHw1tI4iSIxawrfiITrQg3toGe7l2CLI4JcbsVOg4arqUpFRBLiX98Q77x0m/zQqq/x2PLFoQGRBHdReAX0uBKefr73aX1D9bXy1wPyfD73Z9786u98p3xbLk1HdJTKNpN+ujIYqV7E
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(107886003)(7696005)(2616005)(478600001)(6666004)(47076005)(336012)(426003)(26005)(16526019)(83380400001)(7416002)(2906002)(8936002)(5660300002)(54906003)(70206006)(4326008)(8676002)(41300700001)(70586007)(316002)(6916009)(82740400003)(356005)(7636003)(36860700001)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 15:34:01.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8081d8f-81ff-40a4-69bf-08dbc813ff7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat 30 Sep 2023 at 10:35, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> In P4, actions are assumed to pre exist and have an upper bound number of
> instances. Typically if you have 1M table entries you want to allocate
> enough action instances to cover the 1M entries. However, this is a big
> waste of memory if the action instances are not in use. So for our case,
> we allow the user to specify a minimal amount of actions in the template
> and then if more dynamic action instances are needed then they will be
> added on demand as in the current approach with tc filter-action
> relationship.
>
> Add the necessary code to preallocate actions instances for dynamic
> actions.
>
> We add 2 new actions flags:
> - TCA_ACT_FLAGS_PREALLOC: Indicates the action instance is a dynamic action
>   and was preallocated for future use the templating phase of P4TC
> - TCA_ACT_FLAGS_UNREFERENCED: Indicates the action instance was
>   preallocated and is currently not being referenced by any other object.
>   Which means it won't show up in an action instance dump.
>
> Once an action instance is created we don't free it when the last table
> entry referring to it is deleted.
> Instead we add it to the pool/cache of action instances for
> that specific action i.e it counts as if it is preallocated.
> Preallocated actions can't be deleted by the tc actions runtime commands
> and a dump or a get will only show preallocated actions
> instances which are being used (TCA_ACT_FLAGS_UNREFERENCED == false).
>
> The preallocated actions will be deleted once the pipeline is deleted
> (which will purge the dynamic action kind and its instances).
>
> For example, if we were to create a dynamic action that preallocates 128
> elements and dumped:
>
> $ tc -j p4template get action/myprog/send_nh | jq .
>
> We'd see the following:
>
> [
>   {
>     "obj": "action template",
>     "pname": "myprog",
>     "pipeid": 1
>   },
>   {
>     "templates": [
>       {
>         "aname": "myprog/send_nh",
>         "actid": 1,
>         "params": [
>           {
>             "name": "port",
>             "type": "dev",
>             "id": 1
>           }
>         ],
>         "prealloc": 128
>       }
>     ]
>   }
> ]
>
> If we try to dump the dynamic action instances, we won't see any:
>
> $ tc -j actions ls action myprog/send_nh | jq .
>
> []
>
> However, if we create a table entry which references this action kind:
>
> $ tc p4ctrl create myprog/table/cb/FDB \
>    dstAddr d2:96:91:5d:02:86 action myprog/send_nh \
>    param port type dev dummy0
>
> Dumping the action instance will now show this one instance which is
> associated with the table entry:
>
> $ tc -j actions ls action myprog/send_nh | jq .
>
> [
>   {
>     "total acts": 1
>   },
>   {
>     "actions": [
>       {
>         "order": 0,
>         "kind": "myprog/send_nh",
>         "index": 1,
>         "ref": 1,
>         "bind": 1,
>         "params": [
>           {
>             "name": "port",
>             "type": "dev",
>             "value": "dummy0",
>             "id": 1
>           }
>         ],
>         "not_in_hw": true
>       }
>     ]
>   }
> ]
>
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

act_api part looks good to me.

[...]


