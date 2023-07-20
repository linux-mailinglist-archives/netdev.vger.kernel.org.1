Return-Path: <netdev+bounces-19534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0B75B1F5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429CE281EC3
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0218AF9;
	Thu, 20 Jul 2023 15:03:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F518AF2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:03:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436042710
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxwcQlQhDgK7Rttu2Yiwpw6cZnoKEXX/k6nhW1RqpDOeYU9p92HxofPQ3uO894tTpuCK6PzP83urb+VCQePHwuX/6UzNM4MR5bXyLkDkUcBLmAfGy6rs+z2JjsHeiVrTClcLXLb8H/4CsyiyA8LN8QcynB1B4/9BdhDy0rvNmhQXbqEwkf0yCBEmWtpfMtdcj9aSLdVZRosW5jpeC0m4KTd1ZnJZhL3/64Uyg1aoklQmT5llp17Pqk4MWQjkU8bZF3GueURxxUustfJ4/xgo1NjRhmW82cBsnqwNcP1fDmEXjzJM8p2DrDpHhFiKwGwy1ayZCOO8betkNgvzv6NMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOE5MttH3xzwxTx9El6daHb5huJM1dJEPbnF9Lfdkhk=;
 b=Lk+WCjpF9BQMVgTnmpqMqgVS4eFdTnKhLKatGE6w+09CfvzDcn/IMtiIYgtvzJYZHyWTO7JmDnOcyC2SbHXlapWvqb/b5Sqf3WP2xaX0t+EahHJpGN6xMXuUKBRTRrRcHCcfb4UWMN9xr56xPsGaq/JqyFiw4B9oWAOKYeJ4UNt+qQJckaI6cAxX2YyUcDE8p1UpzhkRLuJO1/IXizFDBHidlxz+SHD89UlBJ+ZdRoj8zp3wAEBqoPQjHpLMieiUwHidBaelFx7Tp8yMMpRzMIPjmItho68qMkI5v8ZOU/Rd8jAqsNyjqvP2xEY7fNvkAoR6usv0oaG/DkB0n8SvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOE5MttH3xzwxTx9El6daHb5huJM1dJEPbnF9Lfdkhk=;
 b=Km4qHi6hbdcB52G3mnj4VNnpn+/FjavS3G6lTTqjxsA+rtchN11AQN0C8FXaRE916DIvqqRnRGOZmGFTFSMFmJtcxEY0avlUWCW8GYgHFuUBRruY5YybA9QYsFgqJq5KKrX52RvC8DQq4Lm4TOx/SL2p/08moFAj/+OvlMga1o1yRPRSIAxbwuPyIfqmnIyLw7vQm3IdiuzvzxRVTZ2dZLPK4G9Ai/lTCXX6+09Dw9ZjC8VCzy+6AmHRuqyDwwXFAMbk1bWi4P6uiujPHEtZJWV1wZcFbIqdy9JKAd87nKXF0RdZVn5ZA/4vOT/aoMI+yF+L4guycCE3AIXsn2XAVQ==
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 15:03:02 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::e3) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 15:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 15:03:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Jul 2023
 08:02:43 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 20 Jul
 2023 08:02:41 -0700
References: <20230720121829.566974-1-jiri@resnulli.us>
 <87r0p27ki7.fsf@nvidia.com> <ZLlEYdFXJIAd5q4c@nanopsycho>
User-agent: mu4e 1.8.11; emacs 28.2
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <moshe@nvidia.com>, <saeedm@nvidia.com>,
	<idosch@nvidia.com>
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Date: Thu, 20 Jul 2023 16:51:40 +0200
In-Reply-To: <ZLlEYdFXJIAd5q4c@nanopsycho>
Message-ID: <87mszq7hio.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 211d5b4b-a84a-4262-58e9-08db89326a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wg9k1ffujrvXfTlXvjsU5euVYU8VcDrsiKwHL16iItdocwO8xvmxPdL2am1yFsSjn3riBxha0tnJvqvHFzcO5foqtU0uz92jYdZ6iW7V11rYGxtTRK09TGLNRRg7MZBtIKH/aR3YyK/0chtaSOnzQLY6btnXtL8A5R2ka/8QEksBtuCuKCYzIL7LM/dXFWNXUTVEZtwQWI6kTh6dRyKKfLcePHMs4M+B6ptyQ4HJOJTiEl1cUdPCLCIV0btMdwsgq4sCK67MkMaFbmPWK3iGUX663Jz6ii9AUHZ8MTEN8SGru7vX+v7Nsig8S6B+1on5lKKskywU0Yy2vuwj/d6owzYahin72PHo8J3uNaP1yASxmxeN1RUZl0bx47Yi3TgEFdf5HmhcmBELytJQjejJKOOM5MJ/yvqBAbts56S9sfnhO4x5TTyKpLwDoI3INszUEjUJDbsl8LdBqVhBW4loI0fllBU14u0yEAOA2D/v7qv2X7aPkaPwBd4G6PanE31ukUtl8ouj5iGlAm4BDZexaaFm/NeiEOxNEjLJNRj1W6e0drPO7jUOhtae/px9FN+awPqZDJnE/+JQTSIFxQ4dGuxQGGqDJUWRhjTu8YghC2UW+B72HHMxwNu8bK9qRO5BCvsZbBQxJmzXfWLq+XIo85VJoGS7kTBXeEFi1D3D25ahw4ZzbgSaxzLBMPjc8AnjJLQUE/6fHlI6Bg148b+tjYm+vS2eZRkCWJgGMCWvu889iqQ3jfYlQ20CLjWOYgWowg2PStOR3RE+erCn9VMsOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(2616005)(47076005)(426003)(2906002)(36860700001)(82740400003)(7636003)(356005)(40480700001)(26005)(6916009)(70206006)(70586007)(4326008)(316002)(186003)(5660300002)(336012)(16526019)(107886003)(41300700001)(54906003)(478600001)(86362001)(8936002)(36756003)(8676002)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:03:02.4080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211d5b4b-a84a-4262-58e9-08db89326a32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Jiri Pirko <jiri@resnulli.us> writes:

> Thu, Jul 20, 2023 at 03:55:00PM CEST, petrm@nvidia.com wrote:
>
>>I'll take this through our nightly and will report back tomorrow.
>
> Sure. I ran mlxsw regression with this already, no issues.

You started it on one machine and it went well for a while. But it's
getting a stream of these splats right now:

INFO       - INFO       - [ 4155.564670] rcu: INFO: rcu_preempt self-detected stall on CPU 
INFO       - INFO       - [ 4155.571093] rcu: 	7-....: (99998 ticks this GP) idle=ac7c/1/0x4000000000000000 softirq=86447/86447 fqs=25001 
INFO       - INFO       - [ 4155.582077] rcu: 	(t=100015 jiffies g=289809 q=1459 ncpus=8) 
INFO       - INFO       - [ 4155.588398] CPU: 7 PID: 38940 Comm: ip Not tainted 6.5.0-rc1jiri+ #1 
INFO       - INFO       - [ 4155.595497] Hardware name: Mellanox Technologies Ltd. MSN4700/VMOD0010, BIOS 5.11 01/06/2019 
INFO       - INFO       - [ 4155.604915] RIP: 0010:__netlink_lookup+0xca/0x150 
INFO       - INFO       - [ 4155.610171] Code: 00 00 48 89 c7 48 83 cf 01 48 8b 10 48 83 e2 fe 48 0f 44 d7 f6 c2 01 75 5a 0f b7 4b 16 44 8b 44 24 08 49 89 c9 49 f7 d9 eb 08 <48> 8b 12 f6 c2 01 75 41 4a 8d 34 0a 44 39 86 e8 02 00 00 75 eb 48 
INFO       - INFO       - [ 4155.631156] RSP: 0018:ffffbea7ca41b760 EFLAGS: 00000213 
INFO       - INFO       - [ 4155.636992] RAX: ffffa048c25120b0 RBX: ffffa048c01e4000 RCX: 0000000000000400 
INFO       - INFO       - [ 4155.644964] RDX: ffffa048c6d4b400 RSI: ffffa048c6d4b000 RDI: ffffa048c25120b1 
INFO       - INFO       - [ 4155.652935] RBP: ffffa048c2512000 R08: 00000000888fe595 R09: fffffffffffffc00 
INFO       - INFO       - [ 4155.660906] R10: 00000000302e3030 R11: 0000006900030008 R12: ffffa048c9205900 
INFO       - INFO       - [ 4155.668879] R13: 00000000888fe595 R14: 0000000000000001 R15: ffffa048c01e4000 
INFO       - INFO       - [ 4155.676850] FS:  00007f2155bcf800(0000) GS:ffffa04c2fdc0000(0000) knlGS:0000000000000000 
INFO       - INFO       - [ 4155.685890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
INFO       - INFO       - [ 4155.692307] CR2: 00000000004e4140 CR3: 000000014c919005 CR4: 00000000003706e0 
INFO       - INFO       - [ 4155.700279] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
INFO       - INFO       - [ 4155.708249] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 
INFO       - INFO       - [ 4155.716220] Call Trace: 
INFO       - INFO       - [ 4155.718948]  <IRQ> 
INFO       - INFO       - [ 4155.721190]  ? rcu_dump_cpu_stacks+0xea/0x170 
INFO       - INFO       - [ 4155.726057]  ? rcu_sched_clock_irq+0x53b/0x10b0 
INFO       - INFO       - [ 4155.731116]  ? update_load_avg+0x54/0x280 
INFO       - INFO       - [ 4155.735593]  ? notifier_call_chain+0x5a/0xc0 
INFO       - INFO       - [ 4155.740361]  ? timekeeping_update+0xaf/0x280 
INFO       - INFO       - [ 4155.745130]  ? timekeeping_advance+0x374/0x590 
INFO       - INFO       - [ 4155.750093]  ? update_process_times+0x74/0xb0 
INFO       - INFO       - [ 4155.754957]  ? tick_sched_handle+0x33/0x50 
INFO       - INFO       - [ 4155.759529]  ? tick_sched_timer+0x6b/0x80 
INFO       - INFO       - [ 4155.763995]  ? tick_sched_do_timer+0x80/0x80 
INFO       - INFO       - [ 4155.768762]  ? __hrtimer_run_queues+0x10f/0x2a0 
INFO       - INFO       - [ 4155.773820]  ? hrtimer_interrupt+0xf8/0x230 
INFO       - INFO       - [ 4155.778492]  ? __sysvec_apic_timer_interrupt+0x52/0x120 
INFO       - INFO       - [ 4155.784327]  ? sysvec_apic_timer_interrupt+0x6d/0x90 
INFO       - INFO       - [ 4155.789874]  </IRQ> 
INFO       - INFO       - [ 4155.792211]  <TASK> 
INFO       - INFO       - [ 4155.794549]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20 
INFO       - INFO       - [ 4155.800485]  ? __netlink_lookup+0xca/0x150 
INFO       - INFO       - [ 4155.805059]  netlink_unicast+0x132/0x390 
INFO       - INFO       - [ 4155.809437]  rtnl_getlink+0x36d/0x410 
INFO       - INFO       - [ 4155.813532]  rtnetlink_rcv_msg+0x14f/0x3b0 
INFO       - INFO       - [ 4155.818106]  ? __alloc_pages+0x17c/0x290 
INFO       - INFO       - [ 4155.822485]  ? rtnl_calcit.isra.0+0x140/0x140 
INFO       - INFO       - [ 4155.827348]  netlink_rcv_skb+0x58/0x100 
INFO       - INFO       - [ 4155.831631]  netlink_unicast+0x23c/0x390 
INFO       - INFO       - [ 4155.836010]  netlink_sendmsg+0x214/0x470 
INFO       - INFO       - [ 4155.840390]  ? netlink_unicast+0x390/0x390 
INFO       - INFO       - [ 4155.844963]  ____sys_sendmsg+0x16a/0x260 
INFO       - INFO       - [ 4155.849345]  ___sys_sendmsg+0x9a/0xe0 
INFO       - INFO       - [ 4155.853437]  __sys_sendmsg+0x7a/0xc0 
INFO       - INFO       - [ 4155.857428]  do_syscall_64+0x38/0x80 
INFO       - INFO       - [ 4155.861419]  entry_SYSCALL_64_after_hwframe+0x63/0xcd 

BTW, while for core patches, any machine pass is usually a good
predictor of full regression pass, that's not always the case. There's
a reason we run on about 15 machines plus simulation. Even if this had
"no issues", there would be value in getting full regression run.

I'm pulling this from the nightly again.

