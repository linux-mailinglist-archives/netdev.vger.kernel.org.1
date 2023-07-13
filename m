Return-Path: <netdev+bounces-17461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17A751BBC
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA731C212FD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D163F8460;
	Thu, 13 Jul 2023 08:36:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7379DD
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:36:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56426A8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dplrqxqq5AilBSn4bXhbTgMJTpAwAvibUKRd/zFY/vvABHNOYUHC5pbthsHpMCBMD5rEfEys1FJd9Ms0Hbb3jtv3OI5Mh13eWblv1nPEOBSBkkaJPpB0cvS3WJraSm0NI6j0+bgyE6s3Ha5P62SdlAaz4hKmoU/1we4vLt+MCUS1te4cepjIdPjkYYmoL8CxTAGzofCeITVKjuoSx2OpujtvW/YCKRn+lcb2pGAfG5ZhOv0ndAiXuWWPJQK/Qm1orijPFS4qpZ3clMQYGWo3zqM0dIosJekz6Z+ySMyp5+xKcnJnmetk2uX7BWABKeR9DAXOsWW6XeEpD1eWUO9cyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6Pwx1Z3Zao4ua91sEYV6PcA+HhvCq1LvS+hOtoC+vs=;
 b=OSLeR4G1QCr8G7cx/9VoMP6kDLhw4zBMm7zaBesVLVdOXGgMCit11P9aq5tLgwfHptk4MTZnUxZsMdB6BV7ovnoAZluMI7MEGSAvKEDWkX7n7rDT4TJg5j5UT+hbtNMhvkafrHIsmZOeyQ4R3LN4PevIm0FMwtKMY6CuKbnsSw1WAPX9b4ucUsdUBb+Ir2Dl356AbQEcEOKph+XYpgY4A+pl9cZ1PY52VzYhlrJtIdYshLlJffDDd3iS8XmK2cW096jV1T92H4KkwGSyiq1/BwuskeS5PkwXqdeoD8a7Q+VLj6cfWXI8GwuivtWRSVGAgoLPqtzEawBs36ETfnAYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6Pwx1Z3Zao4ua91sEYV6PcA+HhvCq1LvS+hOtoC+vs=;
 b=kjwib9y2yjRb1R3EsZE/1rdtc9d7Ngb5PTQQByyh/lv3SgtPLpX8G4osCxvGVEDS1Q5D8TVffXVH3/CWhKoHPjAb8eeLRgSmi510ZwPRt9Brk7e2lyPde1XEXSqj0Hap01gOozAJb3NcP3ReFQBh19NLQdg+Gi/MMpZoXuUlgwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5866.namprd13.prod.outlook.com (2603:10b6:510:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:35:52 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:35:51 +0000
Date: Thu, 13 Jul 2023 09:35:44 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	shaozhengchao@huawei.com, victor@mojatatu.com,
	paolo.valente@unimore.it, Lion <nnamrec@gmail.com>
Subject: Re: [PATCH net v3 3/4] net/sched: sch_qfq: account for stab overhead
 in qfq_enqueue
Message-ID: <ZK+3YNwKySg9o6Uw@corigine.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
 <20230711210103.597831-4-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711210103.597831-4-pctammela@mojatatu.com>
X-ClientProxiedBy: LO6P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 45532fce-5ee7-4d5f-ba03-08db837c2a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W7YCgQgL477igGiSrdUQUmKRw/wu8FNo0DirnrqBm6X3NvrS3RCFqU8QlTCPiIrCfnDVVOlyZOglCksCtkJu+sM8Et1cNG6pwdBh8vzUMvWXmTZiIQZwXJyPXDI6swQRMCA63UlHHRNU1ikn51NK+rAR/uZNcx7pZ4EOpZpbhnpIJvy4u3wN4ipL3xH2Fp8aHBItItk0tlb/8vYDFIHciLnEO0AmvTor8rJPu44HJLFFh7hPwXUnicqiE6YriB9kLieO0cuMSkoY9QDBcoRZ8AI0UpO2tamABwouQv+ZlVREhDzKpjHyLR7DhVhFaoUUSbellvuQ7r/ERbWKOi4hShA3Es3X/xCyPn53rG2A5jAlcRKYr4gTSzlsWoW2wgD4T2EXfuptpHwx0th+wIFjnhnmDkJozjNtVvUwvIQGG/4EWh5gyxeiPgn28JXPZmdL9HmDNfg8Qsb6AT3A2oF1M+P3NyLu39TN/ZxD2w6FmIUvTIs3y/jTrMTPKU2QAjLHITtDmJK2ghPc51Eolp0eg3sqUnb1jCyf93XO/lfvV7jER0RQAHBpvmsg7wEn2LZ4Zyh3gDP9eoM8L80aE8efx3vtu3kXT1tmw6wVa6MjVJCAaqEWSEjg8AYtpgjfOyi+ZScG7avXRIeZOudNOT02RdCOz4RErwd5HpFYEeTcZQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(451199021)(44832011)(41300700001)(2906002)(316002)(7416002)(8936002)(8676002)(5660300002)(66556008)(66476007)(6916009)(4326008)(66946007)(26005)(6506007)(86362001)(38100700002)(83380400001)(6512007)(6666004)(6486002)(2616005)(36756003)(478600001)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?itSp74ZtdjVYDqLqUFZkRAUTOR9OpEvSq17aWixGo00TSmrAivGy1rEOut3s?=
 =?us-ascii?Q?2kl+m3ogIfNAUOoQ94FvaETU1uOlxmOdXExRQKtl5l8GHuw+0jdc+aPCgLkE?=
 =?us-ascii?Q?vYcEWOfm6Uf0fE3LvEdwtGqYKgLDQ/bJlkB78i4AF+QDWXzLyYamShSj00ju?=
 =?us-ascii?Q?jjBRKDUZ4ZpPjNqESV3KvMNHvvUYIG050aqTp+2T7zvyChcSOJz4SFbDuTVa?=
 =?us-ascii?Q?P5BQxxvDFNTVoDMUbVE+s3Pe5gTSkKeXlSlrbdxw0x3x15E+WbpyY5Q6MiNI?=
 =?us-ascii?Q?Y8vEFwibm23I2YrQOId4GDAjImECNNtn+v3+YGZYJmbCeBA2YYDhcSOFFRDu?=
 =?us-ascii?Q?Nq8myOvQFtpENrGqOBab8TSIyBD5JOu6gLf5wG6hffepTS6zCm0QtuXJTPIV?=
 =?us-ascii?Q?uYKFZSraoaePctWoy/hxd29y97bni9VyrSJXXAPKGNIi6FYMAGUKozGqeAJr?=
 =?us-ascii?Q?Yxsr1SDP9n2OymLHv9937JAL11s+cb2m0l69h5FAmRA+i01ixxWwdsS9V8BH?=
 =?us-ascii?Q?UEC/kMSVZVmLrYrxS7oWCXqB69uMeORjGN7K44p9emjXhDBqdljDpma+D3lR?=
 =?us-ascii?Q?tfJf91nmvNeaYDPQ4F/cViVFwJw99KpqECkfj4NJSY6ajJydjCRBzQj8ToRd?=
 =?us-ascii?Q?+epb7owv2XdVVnET3rXvVSrcxppnDA/DKoFxjuHfBKXnejfAv7bTCL9YVt3G?=
 =?us-ascii?Q?eDG7ukFYQ3rQiEmlaPZwqe5kis0+5BO6I31gQD00A/aArVM33Om+rzOHQVd+?=
 =?us-ascii?Q?2IH+VOKogC6SvSuCh+4YcUxdwaFu1WdthnNy8dfkqOScB0Xy2tgyU6DtcSHa?=
 =?us-ascii?Q?m+pNVkpEES99iHFeiTvoR+7NWxooEKT5pi7PvAvnYhDyGi3R91SDLr8ep/gc?=
 =?us-ascii?Q?PGnr4CAq+rQmRiF7nPCYAzh/8BdsyRFG3HY6kOAGolazPbvMATKon6qQYXP4?=
 =?us-ascii?Q?YcqtU8r5NB8XqkhtEby7NlOzqmnvBIrlH/4IZjDhGecidVxPsoLJAzXPwTkx?=
 =?us-ascii?Q?D7LRypj1qkipgTqf16jQCYtdyGTpuSU2fNemAmCFVa+6tRyPe7NKXSN9KUec?=
 =?us-ascii?Q?rCwL/PCxL5vVvlJyn/0ylQya/HUOBOIcegA60IQVXfr5nAsV8QNBJcC7JE9p?=
 =?us-ascii?Q?l0vzKPoznL9QttahTH/Scte3GKsYtT2mLSdLBW8JZNyGUSfCcfDtkeQrPQ45?=
 =?us-ascii?Q?zDuDnPrdffVuVmbaR/DogFtgAa+vx2LcdvM+T0XV/bEEqxLLeuyzJG4sC5W6?=
 =?us-ascii?Q?qwEeTTkxJSvt2F1m+APxTdWanWdbrlEf/+T7+ri44MbPOLPLo0iC6k4J31eR?=
 =?us-ascii?Q?0XiDwwiRhkOXznccxB3jfTkz9NoW7htQztPO86VWLYujffK3hEmfkjMjVjON?=
 =?us-ascii?Q?hxaWqAAxeFa+nrbCs/gyo69jgvhgjvV7gHEmur42TcMPbyj/Qq8HbyZTtWm5?=
 =?us-ascii?Q?YgXZ7wLFivOXDWmgf7flH+fQPhkLlTL575rNfF/pObbsgiX7f07bn06R5qUY?=
 =?us-ascii?Q?EYhTJxh+vUP15xkn11cEYuUs5YGzjMsZQPyroNJc78vUncOlyWn2ofrxC3kT?=
 =?us-ascii?Q?D7GC40Ty0PnrXa/NcKIiqdu5g4ooFCWgpZcDbtOATH7yv2fyc+ORCiXuN6fD?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45532fce-5ee7-4d5f-ba03-08db837c2a9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:35:51.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2/6AR83Z9+dszCA8PKY7fdXfF+HwtFU/NA7E/s5aIfi7DjqVKL0qdjBMU9U1q/tWKmsJiMhdu9rmL8Iqi/MgUuGeiruVgQHTQLhBfyxIdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 06:01:02PM -0300, Pedro Tammela wrote:
> Lion says:
> -------
> In the QFQ scheduler a similar issue to CVE-2023-31436
> persists.
> 
> Consider the following code in net/sched/sch_qfq.c:
> 
> static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>                 struct sk_buff **to_free)
> {
>      unsigned int len = qdisc_pkt_len(skb), gso_segs;
> 
>     // ...
> 
>      if (unlikely(cl->agg->lmax < len)) {
>          pr_debug("qfq: increasing maxpkt from %u to %u for class %u",
>               cl->agg->lmax, len, cl->common.classid);
>          err = qfq_change_agg(sch, cl, cl->agg->class_weight, len);
>          if (err) {
>              cl->qstats.drops++;
>              return qdisc_drop(skb, sch, to_free);
>          }
> 
>     // ...
> 
>      }
> 
> Similarly to CVE-2023-31436, "lmax" is increased without any bounds
> checks according to the packet length "len". Usually this would not
> impose a problem because packet sizes are naturally limited.
> 
> This is however not the actual packet length, rather the
> "qdisc_pkt_len(skb)" which might apply size transformations according to
> "struct qdisc_size_table" as created by "qdisc_get_stab()" in
> net/sched/sch_api.c if the TCA_STAB option was set when modifying the qdisc.
> 
> A user may choose virtually any size using such a table.
> 
> As a result the same issue as in CVE-2023-31436 can occur, allowing heap
> out-of-bounds read / writes in the kmalloc-8192 cache.
> -------
> 
> We can create the issue with the following commands:
> 
> tc qdisc add dev $DEV root handle 1: stab mtu 2048 tsize 512 mpu 0 \
> overhead 999999999 linklayer ethernet qfq
> tc class add dev $DEV parent 1: classid 1:1 htb rate 6mbit burst 15k
> tc filter add dev $DEV parent 1: matchall classid 1:1
> ping -I $DEV 1.1.1.2
> 
> This is caused by incorrectly assuming that qdisc_pkt_len() returns a
> length within the QFQ_MIN_LMAX < len < QFQ_MAX_LMAX.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Reported-by: Lion <nnamrec@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


