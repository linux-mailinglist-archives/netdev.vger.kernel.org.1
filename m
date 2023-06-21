Return-Path: <netdev+bounces-12692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE35E738832
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D17A2815FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C118C2E;
	Wed, 21 Jun 2023 14:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E718B1C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:58:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::71b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403554C34
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 07:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYBil9HaZSKTZM6DeCmy6CGNfHPxAOHR6aP4id2mEEX1e/DjLULQevKmXSXk/UCAeaN35t6x/Y0O82ZykWnqs57WTAHSIcNMxd80jQc3HIp0g73psrgY4mRRBW8I0iAZo0l/avMAuOKcLa9eM8lZbe5Cs53uz+kJl2nKMhNYjY0SPcsyVW73tSQhXLmjuq3wW7tsGtZmeWrnzCIyiYUQQJOk+HzEo+3vCr/SrA9X/VRmEAngnULlAy10XDI3mwbgDK7dzvVTGmYBq25LmQdBT4zk1cIeffECopiCeTmx+9VZf2uZ231EU+adFOimRKzm0nzkWy6b4C4e4BefnsyZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kSmuhDE+CNywKaFGdIWBt6+q/IKiP/ccxjJrE9qkt4=;
 b=XO4r/xFYxtiKcsBqKbdd7vCPAwRJDxKuj3SD3g8qexIxHuYwsPJuzUU28X8TnaSYFGsmyg6nD/h4qKgqj8na8sIRo43Q8TdILrXSKKND9qzaKarJmAmB4Wy0jx9t5DACfXU2ZQgP63YkY88yxz4KckLuc5qccoodDlxRyfzzgpiYBopQxG2N7CD6uO3wr81GZwHYjAkfGhcj4d33wVfO696Rc2gzzsBEQXkuLy73Cb0cjzTekrd5RArqWTUbREmOWSqFqq9nJhVVyu2SH0uMeUah9pZ6rpXa9oJiKlMopk+RMgo096+NIPq33Z1is/JpcYVh90jXNgNPvRb0fbbSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kSmuhDE+CNywKaFGdIWBt6+q/IKiP/ccxjJrE9qkt4=;
 b=iuSIbxLicx4zvxTCGL3J3zN//zfVOps0tudWqiI+zY33uJVrxgknybqqqLTHhGRzVuCUbzenPqL0ZbpW7cNO6v9KU57rc0fSNloaEjqlnKq8FLcc6/fPFnQsToPb2oYWi1qkeZzfAL1LGG8Qf+F0DfyZe6yIlfESqd+KWlA3MPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5888.namprd13.prod.outlook.com (2603:10b6:303:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:51:36 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:51:36 +0000
Date: Wed, 21 Jun 2023 16:51:29 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net] sch_netem: acquire qdisc lock in netem_change()
Message-ID: <ZJMOcaNLa8uGUWsL@corigine.com>
References: <20230620184425.1179809-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620184425.1179809-1-edumazet@google.com>
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9760e7-45de-4f18-2f2c-08db726702fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zahu/OqjBfRTABrGsccRimW5ccSUj38qlAVaB5zmxKYKJk+Wt0zaU5k2pcsoO87JnK2uyBwnAKMp4mGF2bK8nqH1pZqMhJ3C5TEThVBminY9P2F5b7nJaThvzMFS44k7iDlv3t+qs+oBzxihKUalsos0YIkCdangKMCHbkW1Iw+CLQ2wY2XMx2m/SqC1XKbn1VNdNwBNZ/yhwuVT4aHk4f+YxslTu9VX8bwrMf12frb14HJAbjmxkMEciwDnRUvfVCegu5T9NBuj8oKZ1PoMH4xkddJiFBbI23sZcyfjOG9CIom4NoB0A2UJnrg50Ik6UBw0dgFI5WLNKvHB8HfArGvJ+DRhbVoyn+o8PobuN0wMgWkSVNiOQdVnbFx3h7icaCkV/e4U9veXBlzY+0EjsEwYUeZBENPd5fbDSdIjEjjtq7HK8ztLdDeTovgGKbJx8WmwG05qgHyYxFOpo2UHXPB4Q+EEg622IOP8Dhcet3roQkKXRV8csPC4Qf9uEEqU6DifhKy8SM11Iv3j7C9ZZZLfnZvNRdn0kfoPOGQWpspmU19QezKidnvT6zRuOidHTzkN/FQZDRe5XOohq7QOdhtt3uT+UO/GnXanXRDyQFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(346002)(366004)(136003)(451199021)(4326008)(2906002)(478600001)(54906003)(86362001)(6486002)(38100700002)(6666004)(41300700001)(83380400001)(316002)(36756003)(6916009)(66946007)(66556008)(66476007)(2616005)(6512007)(6506007)(8676002)(8936002)(7416002)(44832011)(186003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EO1Ucnro8CYxD+DsGcbt76DPSUlLUI2DMHMZA1iuE6DmRPN7dFtREFbk2Tv0?=
 =?us-ascii?Q?b0bztpIU+nsoxATfmqLaj32jSIUN/TVfVdTIZnQPu5O3eQqFStW6gCB9xrPF?=
 =?us-ascii?Q?KaMpK0bxMxajwl4EZ9eTyFnuyDWyJCDAIB9J4nfShS1Cnh+lsDCYzuMhlXe8?=
 =?us-ascii?Q?dCw4/bplAeHL5+5OY5NAYAjF4uDeP/NpA4aLn2Gq/Dgbwc8aHdMnHDwJPQIp?=
 =?us-ascii?Q?E0/kjUISaFvAkhQRclwGlJ2wzf4AGKd4K3SugMzBVDJhew+vq0USUt/ked5X?=
 =?us-ascii?Q?ZOinKkAmWoG6q1MFLoyytCs1815xLRTuTAcSgWTkJEShFhfxRAYVjUUBakY9?=
 =?us-ascii?Q?YeNsveklh6YqWa+VDWQFIJqATobK12C8aNMyfmGkMfekvgd/9yz1wVhRqqGA?=
 =?us-ascii?Q?YlcX9YQJL66fdhzixNegCOH4o7TfDDDjF+6EHfDl/HnFIboSYleAUH0qNJf8?=
 =?us-ascii?Q?297wk3dWB5DJnWVHZA1nRERlsyUmlw3Wb9ZnH/4P9yZKxceRav8Skgw0glrj?=
 =?us-ascii?Q?aNNJkeIDl49aKY3BcRt2TQnhHvzOcU4I1letObCPFsHRVjfzI3dlqm6MSBl2?=
 =?us-ascii?Q?snTYoCat3Q1ugIYAvC70DHn8m+2vW+axAAYryMUhFzx2lFNvm+/MBiNNHv4w?=
 =?us-ascii?Q?3B0G48ntUHCzFpHVQ/wJbfz3x99q4acj2YVbLoNNG1etxHyq44ka3Q92cB+u?=
 =?us-ascii?Q?HaKx/6Vnv3VZFqvt7efqUv9lD7AR4mOnsYqLMqLQ2+a5cjff9UDsXwFBeeZe?=
 =?us-ascii?Q?69fMGGeEsYNnBwMSJ8RYqI7Y4Za8Tj72Yh4IhQwIqZSz6lTBfQMx4O77L9HY?=
 =?us-ascii?Q?rilCU7ENMNSTKMZCQiwgXEpwAaCitiWZA9ZEuRMvW0ckAJlF0FlpqKIJwu+y?=
 =?us-ascii?Q?SIrHLI9jsXZPorYMKUWYOp7IXWmF5BXU00zaH5tZeytoNEQ3oG2NW0H4HJC1?=
 =?us-ascii?Q?oVnU6DVa0VbAv7MAiQnp+x8GKDn5rw9MvGKng5saqdjXEuPqZ6wiow5erm3i?=
 =?us-ascii?Q?IvmrgwHFHd4uR80mVMv5QxFKgVFw2HVgxHctOcCXzvV7OMLiOEZi8fbIjkvb?=
 =?us-ascii?Q?bNALWBntnPAshIfpu4lifB4j+bE+0MtI5klpCgNTBalDHZYSHjDAO8eX6KZZ?=
 =?us-ascii?Q?Hh2nw7njDNW4IWAm04CJJKgA2LJDpthg/jwBPnfPHbd8Fts2poPHx815Degr?=
 =?us-ascii?Q?6dHgsXrRggpSuGxg0dVirx8zBAhJExcq9y7eo4r5sYh9KpSve1Igy3GskIjT?=
 =?us-ascii?Q?oW9h4WcrKQ/1vVfNPoGhODCBUYndSk5hHVcRFNzglzQEVps1ifNlhZVwGvlF?=
 =?us-ascii?Q?xSH4cgyrg27PazmWZ9KyFp/IO0H0tgomH1YareiPD7XsvqD9Ggpxyck1F2FH?=
 =?us-ascii?Q?VqqN07QnI0K1+zbnsymlWDR9wdwqSTj4U2SOx9eYqMHDm2lSaf9t4a3760qQ?=
 =?us-ascii?Q?7y/1v7GPK2+H/J2wPoUu0+PoygstWOZhnV5fMeqpylm7ZEj45O22DPx63qGQ?=
 =?us-ascii?Q?SkU7rWDygIC4WTMxdmPErMzhoRQLABxrzvKf/lvsrKXDzl5tGz4cYpkbpS+p?=
 =?us-ascii?Q?Pem1Sg7mMusrP59RIhh0wGDNE2GuRoJquKcF1kVal56hsLN+5aZSX+039HAp?=
 =?us-ascii?Q?ZVtABimToBdHX6TmMFcypC95WPCpspbA7DV8CN81n7eTgXEsOgFdRXm2E9Lt?=
 =?us-ascii?Q?ul0jkw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9760e7-45de-4f18-2f2c-08db726702fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:51:36.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVQtyTuwGepGp+tmgga/2KbvIwcGBzK4lOJrwnR3o3/6e3Rz/wx2C7vr5w9Ut5U7C2npb7pHKaZrHLsvK53tQffjfSE7fge2ScqU7gE8T0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5888
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 06:44:25PM +0000, Eric Dumazet wrote:
> syzbot managed to trigger a divide error [1] in netem.
> 
> It could happen if q->rate changes while netem_enqueue()
> is running, since q->rate is read twice.
> 
> It turns out netem_change() always lacked proper synchronization.
> 
> [1]
> divide error: 0000 [#1] SMP KASAN
> CPU: 1 PID: 7867 Comm: syz-executor.1 Not tainted 6.1.30-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
> RIP: 0010:packet_time_ns net/sched/sch_netem.c:357 [inline]
> RIP: 0010:netem_enqueue+0x2067/0x36d0 net/sched/sch_netem.c:576
> Code: 89 e2 48 69 da 00 ca 9a 3b 42 80 3c 28 00 4c 8b a4 24 88 00 00 00 74 0d 4c 89 e7 e8 c3 4f 3b fd 48 8b 4c 24 18 48 89 d8 31 d2 <49> f7 34 24 49 01 c7 4c 8b 64 24 48 4d 01 f7 4c 89 e3 48 c1 eb 03
> RSP: 0018:ffffc9000dccea60 EFLAGS: 00010246
> RAX: 000001a442624200 RBX: 000001a442624200 RCX: ffff888108a4f000
> RDX: 0000000000000000 RSI: 000000000000070d RDI: 000000000000070d
> RBP: ffffc9000dcceb90 R08: ffffffff849c5e26 R09: fffffbfff10e1297
> R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888108a4f358
> R13: dffffc0000000000 R14: 0000001a8cd9a7ec R15: 0000000000000000
> FS: 00007fa73fe18700(0000) GS:ffff8881f6b00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa73fdf7718 CR3: 000000011d36e000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> [<ffffffff84714385>] __dev_xmit_skb net/core/dev.c:3931 [inline]
> [<ffffffff84714385>] __dev_queue_xmit+0xcf5/0x3370 net/core/dev.c:4290
> [<ffffffff84d22df2>] dev_queue_xmit include/linux/netdevice.h:3030 [inline]
> [<ffffffff84d22df2>] neigh_hh_output include/net/neighbour.h:531 [inline]
> [<ffffffff84d22df2>] neigh_output include/net/neighbour.h:545 [inline]
> [<ffffffff84d22df2>] ip_finish_output2+0xb92/0x10d0 net/ipv4/ip_output.c:235
> [<ffffffff84d21e63>] __ip_finish_output+0xc3/0x2b0
> [<ffffffff84d10a81>] ip_finish_output+0x31/0x2a0 net/ipv4/ip_output.c:323
> [<ffffffff84d10f14>] NF_HOOK_COND include/linux/netfilter.h:298 [inline]
> [<ffffffff84d10f14>] ip_output+0x224/0x2a0 net/ipv4/ip_output.c:437
> [<ffffffff84d123b5>] dst_output include/net/dst.h:444 [inline]
> [<ffffffff84d123b5>] ip_local_out net/ipv4/ip_output.c:127 [inline]
> [<ffffffff84d123b5>] __ip_queue_xmit+0x1425/0x2000 net/ipv4/ip_output.c:542
> [<ffffffff84d12fdc>] ip_queue_xmit+0x4c/0x70 net/ipv4/ip_output.c:556
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> ---
>  net/sched/sch_netem.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>


