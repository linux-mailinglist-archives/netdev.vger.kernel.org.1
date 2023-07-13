Return-Path: <netdev+bounces-17458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75F751B8F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF731C21318
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9179E4;
	Thu, 13 Jul 2023 08:31:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50346F9F3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:31:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20700.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::700])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501B84ECB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGacmoafy43fMO6sLJo+kNx52pTTLBHNiSXmLmpAbcE9q52VTYxVCDMR5wxZJaxazBZ4Jv7gogwbZ6+YRMJj4Uq6YRPoks/2w1ljEXZjDHIXmOgBDmVh0hyQJNjMYnkMg/A1S0J0V6T6OffFR4AE7R2ljI9q5wDpzHVLqdykEYGbUqoB9WbqtRA5i3/uQ8YHabxqg3oUU8fpd3WcI/Ei8OXhDq5LbUBimomcCVG4gm6SL6wDaASOk3zdKndva8y/utiNVyoSywA48Z5KIxOJJkSwujRGkoU04bWHskFHmNPQt8euZDAh6F4X1M1iw85A8SzaEOb9AJCp6qZHFSsvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIWjw1YhZ+3WaQimSSGfZxyvP37D1XR9kyrEllHqMIM=;
 b=MHBWAsX5UV2RUeq2q2Vgxv8eUUzvWWm7mi4yB/ztbUyZOl/eKSpIIEJXA4ja6VVpZ+NHO8NA5gjAfB8TUOCOcFR3fjQLwFaWmGy1mg35QpMKnyK8+wgPMgVJl/uy291bm9zjARRliNUXeO91g80ZnVpnMDeR1bprzaThXTSDQfZOw31sT/cEDVDETVkndva7nCjtYjKMNSBsxyh/0ie53l+qJkA00H8VVRdhEHygUudDbP4IKPXSTk+90Jm70csrdo5zCmluVXI+iiNyrpSAyfF+wlxNBxLtHr2BETeGQdoaQzid7wIZhFJDMtK1lx0m0T8hiAwxcWmXP8/zu5pVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIWjw1YhZ+3WaQimSSGfZxyvP37D1XR9kyrEllHqMIM=;
 b=qTz+QVd8kwzAniiWcsXNTm7588CNv4TFU0PinfwRwyymRc7+HyAKGyoCia7u+RiQ2OPgKTC2ukCBFQ4tEkYEIlJnZ84uV/Pwb/L/vf366AbfalXK3415e7CPaFaVXzZMp2R+i/pErHZyhurTrd6a0WTT2nmgpMfFb6auxOpRGhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6241.namprd13.prod.outlook.com (2603:10b6:510:248::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:31:44 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:31:44 +0000
Date: Thu, 13 Jul 2023 09:31:37 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	shaozhengchao@huawei.com, victor@mojatatu.com,
	paolo.valente@unimore.it
Subject: Re: [PATCH net v3 1/4] net/sched: sch_qfq: reintroduce lmax bound
 check for MTU
Message-ID: <ZK+2aWTsWIKnJ9FX@corigine.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
 <20230711210103.597831-2-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711210103.597831-2-pctammela@mojatatu.com>
X-ClientProxiedBy: LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d2d0d6-7962-4dd5-40f2-08db837b970c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nx5A4EWwyPr3stYNNhYN8AMNoxuRoJzz2Ls4AdiptNpZ3ScW/j69L2Hqw426pJk9bx4Pt98u0LserGPzGH4YYjtijkZh4FhIMMa+GdUSzQ/NuIv+/iNyBgNqBx225CGFyNlwfKD+z56dh+j8cwXthDh2PkvhdDQOp804y3G08oARy9jOxhHtnGbLa/ArpP3RuemUWAivI5S+s+ckuUTSaMGST+WzbC3tdNphFFfcMu/E2r8g53GZeb4oN0l3WQ9aWPqmJ2e0zBygVBtoti56YAP5ayGbS9BNiyrnM+vDFXZ+eQVlqBKK549v4c7cUlNBGA49l1/47adC6rbM4O68Q6wTyrTV01rlo+3j+XKwVSbDy7Xjoedn8gHIM6rurEmyen3dLNI3hK9CakP31g2Y64eeqV6Pm3yXvgBkJl+UE108TlE2JCh0LT5TnCpoCj2Mc/YK3dtWJBv3E1GF6O+pOaJMgT5pddHAhOq908l9iBkIS14cgTaG9ao1D2cmCvtlY33ZwJsMB0eDqU/I+w08AGB2grYRK0uQx5lDO/J1QfneyxfsYOBTOWWby7Qb9rHcjt6ZIn/52pUjJuRKm0pSryvzRHAiE8NbSX925zV+KZValPBRaPK064Aw38DMy3049Z2rcXWAJ6eVqp/k1xDgdGNlMAudqRIDer/bs1s1S8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(451199021)(66946007)(6916009)(66556008)(66476007)(4326008)(478600001)(86362001)(6506007)(26005)(186003)(36756003)(6666004)(6512007)(6486002)(83380400001)(41300700001)(38100700002)(2616005)(7416002)(8936002)(8676002)(44832011)(4744005)(316002)(2906002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NUz6wKGD39bpVlOwdYnqFi9F3MZsC9K5Hh1LYcg8rcz1w4iA/rD+R2x/V8yY?=
 =?us-ascii?Q?uRwlPoQagnqfMzRggPBNmTuRCztIOgaAkZHEL5AUwJ7z4l8s8FwS4OxlaNMx?=
 =?us-ascii?Q?Ws7YrXC8IGWSeoYb0b9/9l7vmZTrgN2Cw9UuQop6iHGpFXxWmej07jGFrwnm?=
 =?us-ascii?Q?jrkZn8B/C6ii0rlz99cuwCzKx64o9XU6YJLgUR0DA8F8PgJVJx4hzczORo2h?=
 =?us-ascii?Q?Wc/7229MnW0KTypbNg81xZsUM4m9yNEYI+6YtIyhe83HgxD0elPKQ/9hHtY5?=
 =?us-ascii?Q?Jf37AnaXSGFrJ1K90ltYj6tGNdLrDtaqQyrAHYHFISYlAhlPEXp+s59mv7+x?=
 =?us-ascii?Q?V/eRYYoHFKoYLTJkXX0CgQXmeGs9WQnxrjoRaVB+495ZXXElD/cKbHdQU7mE?=
 =?us-ascii?Q?1VWIL8xlN6l9K00FUVx4yQrbjI8b77viTvgOhCjE0gkHD28GI2DjY4tkAi3l?=
 =?us-ascii?Q?HdjZybyrEEWu42UaAs09zs+eZNu4fdl8QQkhmHCWKr880bCXRav/OPsB8K4I?=
 =?us-ascii?Q?/NbGM+Ih6vYiameknLxHgg/WV5UjL9FEib2fFYq/p9edaznfus3OT8Ax6c1D?=
 =?us-ascii?Q?EGuRn0rHDfrYVPJlcIl75w5cJnwkqokFC2/kLPomUBLuARU3MIigxU56X2xT?=
 =?us-ascii?Q?EW4/84t6Y254on4H059RPquxGrPDYy1EYbaP34RE4AIiR/2xpht1ia2JL528?=
 =?us-ascii?Q?ProhdazCqeWje2/3RY/KWun3NlXbywa166JPmmrCTZUJ/FqRrGmr9raj9pEF?=
 =?us-ascii?Q?qz6mR46joL99HCW1vdlsFMsbIkVhicsHjUyrHOewxlaPuGwCKOmOZ5HsmoCX?=
 =?us-ascii?Q?3EN/XxJc8yl5T36tZdeX5JUebt30qMJLQeYr+ObtrI7CzkwZs/EV6Fqs/9ow?=
 =?us-ascii?Q?ZmmohJhilRj+Q+7w4C3LJey9sw+5odbe+EIBZN5XGKozrGQLsRPQD+oZe/BC?=
 =?us-ascii?Q?IXPJdK2yug/Wk0c39XTb+jLsbYMdWqn8jUIspKMmqA2ED6nXLZokXpGgITox?=
 =?us-ascii?Q?ePfn2ZmRJzKWf1W+lNK3jbHXyNtiEn7fFke91DkRX9TLxjhLhq6YasotHk6H?=
 =?us-ascii?Q?VZglT1JP5H8nD6cx9xDEEfAaSnPLez6pcFOlZU8JLL19PB/+VcX0pPPGKig1?=
 =?us-ascii?Q?+QzHA7EH+FmqsCz+z4VpVhvyWlRNaHsRNC8q+iRv0YGWSWe3GMIGowXz5+Yp?=
 =?us-ascii?Q?1d00k++pJ+bdCSBbPkuSkzYyYXu2eLrRtq82oX55BxnayYoWFlhlk8frjGj/?=
 =?us-ascii?Q?3Ah+3igNe6GlclssXuQeWcgAQKYNvNrXLB3JKL2UsLOceiqJ4+EJkKIeQTv2?=
 =?us-ascii?Q?YS9Kxg0An8sXKDK1/FJPJxsta6kfVSF8EwzIvXzxWPhgfD1HgUP6s+giRMMw?=
 =?us-ascii?Q?GsWGDgs82uPoQF1CJifrl9JazFOnhYs0iLbKLtP1N8tnXxQvm0RuGSwZ/KIk?=
 =?us-ascii?Q?I6JGQ6R015pG4daqJUD+juXyMnSScmRZvnNi6mg38q+t6hkCQV7YvJo98YZa?=
 =?us-ascii?Q?6ByZO8a+cStsttLaLyfT5uEzmiCxdTtzrmz8PXOdQDB4qwDeKa1rm3+LPNjk?=
 =?us-ascii?Q?Izy7R5YOAjgEoT8E+dPNZ+AnvJdj8iDQ/Az6VL0MB4YZ9MBRpXtPxKVbkFry?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d2d0d6-7962-4dd5-40f2-08db837b970c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:31:44.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCF+/lqVuzv65O0Owolb8p/QsYCrC89wAqZxN2nYKPnCPHjIu5XiQgTN+oiB+4pURSr996ZMxJvZwcz0PSI52VpWGxrL9zbgLMyPSfr4wBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6241
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 06:01:00PM -0300, Pedro Tammela wrote:
> 25369891fcef deletes a check for the case where no 'lmax' is
> specified which 3037933448f6 previously fixed as 'lmax'
> could be set to the device's MTU without any bound checking
> for QFQ_LMAX_MIN and QFQ_LMAX_MAX. Therefore, reintroduce the check.
> 
> Fixes: 25369891fcef ("net/sched: sch_qfq: refactor parsing of netlink parameters")
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


