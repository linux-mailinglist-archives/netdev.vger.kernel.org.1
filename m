Return-Path: <netdev+bounces-31409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D6878D68E
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CA71C203A1
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE025226;
	Wed, 30 Aug 2023 14:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94C3D7C
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:32:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566B193
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693405963; x=1724941963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b0/1EkAib4jTO+Ic/LUewB/UCkF58ksUv7Fm5qvBE4o=;
  b=GTRNZrva+4RGjq6Hnamjl0g0/m+/nV5QPycDm/W5w/KZWdpSMizWBVSC
   TQX9iU669qlXqNGBzd8hGh2bx+JElTXvsEg5yqqlUKpF7XkEtucwfZOLz
   elG4N8rCzLyMp39E2nOTZTggQxKIHqYnXXEpTg9QNjsBFrkfp5rg3EgCr
   TEGXAvYdXQngjob9V21gmcVtLeva5hAzzwFLNVth1783/HhCzIMdzUU2K
   Mvif3WTP6JzvNG4gYZ+locY2TTXZ6X93SYB3ofhqVoe0HJkbQn3hr0KPb
   rCo8BzlW8oca+5eqaUhhXHwgwS3mp8KTBfn+gT4X/JQgkqclAffXmP/C7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365865297"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="365865297"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 07:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="985761575"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="985761575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 07:23:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 07:23:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 07:23:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 07:23:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 07:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqzdV+aIw/jBxEAaNhE/Y1SdB8r2gu5AqMDlG79zF3btH/S8/OOzsGHZyOZSKvxstKYMUuTaWgF8qBVaNN5FQP2HcFhLPk8zq8j8chCKCB5Vy9HG1moYDot6nqlSGu27eWOdibHgwkj/aFbm+ugxDKV95cstp29R2B5jvF2SP5nSxv6jLifEo3oX3PjAEFn5/Nt4+priHCg1ph8Dta90aufFUpNL+NgguIbG+b8gpjR5CHRS0iOsoZ0U9NgLI6rU82hxJqPMY56myEBf+8TQa0lQlI4Z8CTEOGkBu16yjvJfoQL1/S1MYRL7dy+btjrEc4SmNz2h9HNp1LsMCqyYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQN4mXAg44wAfT28mTBFUy+zbYttPx/2CuOMvQsIQok=;
 b=jNYyYDp+wNadKPSJEmwYCUjFXeid0jiPS9SBJNCZlm1qwvE1G792H+CTvnVvV0j3pqZO0Em/h3aSQpRprjPOcRFunIEII21QntdIccvWSnYB+Htn7EN+FQC9MiVkwThuMcAd1HXL1aEgAsQpUucHyihQ/Kf7j3cENFWf3NuLNu6t1JLls/adwq4bj5HNeLIMbHSNj+I9gqK91I0P5/xFEATCs51n40lP/RYK/waf0EmZNyhQPgIQhTiseFe1SeXH/VAamXIvMruUhxxp+6lIIG17mq3zgA9cl3AaR/kn0rmn/VgGpZhgW5WrGF/BHNLpMosl4oEu8zBDXpubZFdi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Wed, 30 Aug 2023 14:23:26 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::4c4b:8eeb:f41b:7220]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::4c4b:8eeb:f41b:7220%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 14:23:25 +0000
Date: Wed, 30 Aug 2023 16:23:14 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net/sched: fq_pie: avoid stalls in fq_pie_timer()
Message-ID: <ZO9Q0ih6OQhq7sio@localhost.localdomain>
References: <20230829123541.3745013-1-edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829123541.3745013-1-edumazet@google.com>
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|SJ2PR11MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aefb2d6-e3e5-4023-f55e-08dba964ac49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TQgmRJjwcl4ymiAnTt+1wivXHuk5ZkE8ll1hjdQrWw+k3pfz7obO9kg/GuetU0tuC5BrVlmrzguMxr38wv8kTl1umGP/ONNVRGbWiuBoxiRn2/hSdlsdg/1sfDVYuAktt1TzbVPVMqMt2588DbEiwwrKKKjzAU9IDcKDHt6bf7IvMuhOkJ1GTE+K6fGHMjDUAz/xcg3s2CMfWq1reoUCdHAaS+zszNrXSIQutK5L5a/xVN1WMxUwYD/bN1pFRzUzOOtQJ/y97ilmnSvmV1YHOU7ZC8bFKOO6lTwv4izMoo9YK/I8IO8P8CDdjpJpSJDV4zGg94TBczk9lYi8tBqn2U36SL2IH+BFqMkWM3nnh8XzGO70EXyPRWumVtF5NQbu4h7fdZJvXbNXawz6/dpgxGbCkFMR0Jr8ps3HqtsetD07nv94RVx5Ktt2ZDjZy2sjvNFr3uavxODpBLHBG40x6U5II1kJfG4UY1IC5Pz+mcru2VQY7+PZinY2s0zU1rMUhGXwOMmVS9iAue/OwlqVcNv3Nbpcq0+un67Z/+M3po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(2906002)(5660300002)(7416002)(86362001)(44832011)(82960400001)(38100700002)(8676002)(4326008)(41300700001)(8936002)(83380400001)(66556008)(26005)(316002)(9686003)(6512007)(6916009)(6506007)(6486002)(54906003)(6666004)(966005)(66476007)(478600001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t48f0TArN/yDKkZbG45MTiN4jYvHjHYtuzBqwz65lN0mZgueisT+6JqAbs8w?=
 =?us-ascii?Q?1T5kWqIMXbF+TVuZgD/59v3v2NCKrALze5Y0ZWDZXO0KEu4rGj5xA9MdDSCo?=
 =?us-ascii?Q?rE7LJ+qz6AbulRNAM0bZJoaNGSH3plP+eJXnzpUim7zHWSEwJyPoJuszqIhj?=
 =?us-ascii?Q?zNDLv2JGigbu9pkGTsp1TqFIJZnkZrtQgzsFzWwhQTnrBh9OdrMJRvJPqCR5?=
 =?us-ascii?Q?YyjZwiQsDdQ36mbUCubaXGpo4Sd67EPMST6N6wp3+2tl7kMVYCUfWpKVFbOP?=
 =?us-ascii?Q?Atd/Y1bLcQQ4kNYjVDtyrbrzZiz9Ygi9xUj9KlMuofWqtc/Csl5Yh1cighpA?=
 =?us-ascii?Q?MNb1NUT6poilOw5E2DPm6keOgHihfBsEZPYwfNVg+2ypSlbTrA21QzFu9M84?=
 =?us-ascii?Q?29N5P3cYM0QbIN0vNxwOO/H91Do7S4ea+0J/G6O5BW4Sfd9v8htqunOWkPFN?=
 =?us-ascii?Q?IJ785pYu+lUM4m+oyazLMdCOOi5WfHiwSYIwsQ99fAxEdZPZhpUEYB1NLk8H?=
 =?us-ascii?Q?7Hc1rduGARP5G9IAskD/jZMXJ0tAv6fhqwqu5v0BwIY//J4/DrTq6r/mT5yr?=
 =?us-ascii?Q?SLtvIa5TiRi3j2wp+VZkDcJrHWv9w9CaoMOczbQfmuE68CLY/90M/HuDtp1H?=
 =?us-ascii?Q?DE4kCX5+RtOU14R4eE2XNb54FvgjZ42WFnHrMJSpd+E15kSMKyArNR82BFhY?=
 =?us-ascii?Q?TOCgfjRiLoNBpN5VfXyikxm2m/8pfdidbAx3rPbFnf06rJnL1inNi0j/TBR/?=
 =?us-ascii?Q?6Ylb/gvaLV61L68b5BBEU49pqZB6fS+PDUwuK/VTtQHJU3am5OGP4vUzbnik?=
 =?us-ascii?Q?WzRvfvG8rn14HZwmVC7OADhyArI/skyjjRJ06l3Opvpd5h0x+E8ksIqvQBS2?=
 =?us-ascii?Q?aiE1uur/ppvQIHyaM2PEj0FURxb7Uiw9QAjkPsOtIT7WksayRGcBO+tWIACP?=
 =?us-ascii?Q?H0n7ZbzevW9HK7ujC3miX+BSBJhRn1Hhh57tdV1Q1Lj3Az+gUBrUDzcIRcfu?=
 =?us-ascii?Q?FyKiDfo/qq2FlVavii75eDjGemXfVhAZOaavDPGPQmORKvGX+/deukWEpAXm?=
 =?us-ascii?Q?uU/sf840auyOK6IYOLkaaSeM97/LmtE2iQBLuf+AYZ1qLVWLuu32ZRO5GMm9?=
 =?us-ascii?Q?RYipebbwlR8JsBpVzynWtg/+Sx0gb3buWP9n44TIFz9q2lE7jzRVEPVcNqJL?=
 =?us-ascii?Q?FO2Km0YWfIY7IFZE9DhVMFwWvMQmu5AnKLIC7JHsx7KCjBH3cjJYeGCUF4jV?=
 =?us-ascii?Q?r1y7vP2DD4uo/NSAe16rnZJ2QS1l2pvHYGbWTrD/N5gZZj82PP544+r+Q/6k?=
 =?us-ascii?Q?lLqbKrKnsiOfMYvE8AxAhf3FYoIpBa6teu8m/95wJD52cLjnf2FUXa5q6tEc?=
 =?us-ascii?Q?suinQnt8euCQUfYBF69txjhNDEsaBOpg4w5J1GJa4943NHFVMe1ahxgU+2dg?=
 =?us-ascii?Q?fyVK2XLVDhUv4pbmCQK8kRvrzJJSXLAxi1hL344HxhqwKzh12lwMihInAsvV?=
 =?us-ascii?Q?OFyWQAnZZI6GbYZPfN504vEFQTpHK6RgLOSNT0l3rrf4APc8+e9Wt4dS6gyE?=
 =?us-ascii?Q?NQIXJPmRkdZSZ5Bcal1Npj8O8ymE2qP7R0ZULkIo8q/NSFsTh1OifzJ98tTy?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aefb2d6-e3e5-4023-f55e-08dba964ac49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:23:25.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhjFY3kcpFa/ydEKBkWbQRZy7tDJpZEY4fOT3XEHKLgx1zKjwGWjteNiLf91XpFor7Tyh9NGpW716X5AZtcWlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 12:35:41PM +0000, Eric Dumazet wrote:
> When setting a high number of flows (limit being 65536),
> fq_pie_timer() is currently using too much time as syzbot reported.
> 
> Add logic to yield the cpu every 2048 flows (less than 150 usec
> on debug kernels).
> It should also help by not blocking qdisc fast paths for too long.
> Worst case (65536 flows) would need 31 jiffies for a complete scan.
> 
> Relevant extract from syzbot report:
> 
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2663 jiffies s: 873 root: 0x1/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 5177 Comm: syz-executor273 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> RIP: 0010:write_comp_data+0x21/0x90 kernel/kcov.c:236
> Code: 2e 0f 1f 84 00 00 00 00 00 65 8b 05 01 b2 7d 7e 49 89 f1 89 c6 49 89 d2 81 e6 00 01 00 00 49 89 f8 65 48 8b 14 25 80 b9 03 00 <a9> 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b
> RSP: 0018:ffffc90000007bb8 EFLAGS: 00000206
> RAX: 0000000000000101 RBX: ffffc9000dc0d140 RCX: ffffffff885893b0
> RDX: ffff88807c075940 RSI: 0000000000000100 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000dc0d178
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000555555d54380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b442f6130 CR3: 000000006fe1c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  pie_calculate_probability+0x480/0x850 net/sched/sch_pie.c:415
>  fq_pie_timer+0x1da/0x4f0 net/sched/sch_fq_pie.c:387
>  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
> 
> Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
> Link: https://lore.kernel.org/lkml/00000000000017ad3f06040bf394@google.com/
> Reported-by: syzbot+e46fbd5289363464bc13@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>

The code logic and style looks good to me.
However, I don't have experience with that code to estimate if 2048
flows per round is enough to avoid stalls for all normal circumstances,
so I guess someone else should take a look.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


