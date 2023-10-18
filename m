Return-Path: <netdev+bounces-42257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F707CDE20
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CA1C20B08
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD1D36B14;
	Wed, 18 Oct 2023 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uxrQqCfF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E536B00
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:59:26 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0510E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 06:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPbV7VAg3+X7SphIi3gkhM6m/cDZ5gb3XLzRY4CLuFWq1E6Zjk1lQZhQfbnjyA+5beIaJHOEfumEI+tlZi05NpcBpM7j2z7sTjI+vAJwuIXfSZ7VQng9IyNVMNgACvD7SgWgKl9zlR6k7up+/HzL9KmxcEsGRLehq8SYO1oga1FrbkiFVc+lhgZLtlGEKbPP5dTjQ8sbP6mF2cGSp3RgTllSHDrFZFdlhW9FNhtMooi7KpFWVp8pv+ADXjuk7Eu8KWv4J75bshrpk6kKthpmlz0Zbgg7+FJYSkJAJyoHv58MmtNEwf5MJ2LfjNEbXJyvPbukm9Qvlx5czk9LwVgOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LunXvujmjnmvjRxjR45ygt5hdsNnfa46n2bBP8CNmqA=;
 b=ZWYqacpAtGToILADfqzCMprgXJ5ccCNpoabtAAyy5t8Q8APxwrDi4W/R2ODbYLXld+PdLCF0HsHYXNuiuGzqUmsBhLsB9OIK8l6VpHvj254+MAnDPh4EZ5RyANDSsX3Gbr9Ps3vjpmYFrFDhHNOpdL1yaLzSQpQMGId2lbB5HS1NnIoUbidl6v1D3Zm7Ew9tdyt3mQT+US6T3kR6/j7cTwlx8jrroIqXoKODj2ErC0ptK7aNl5F7EukjT6Po/Tf5k60iXT7o+iaxt0Mb4yjxzwG1CAiF2p7Yq14/WLPpZD1GpO6GlU9uf6O2VYVNxtLbAgUIVoVtXBYxzchRrtYR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LunXvujmjnmvjRxjR45ygt5hdsNnfa46n2bBP8CNmqA=;
 b=uxrQqCfFVM6t/t9W02ubB3ygTqvDv8TpjMqEs0HyjZ5xJpeHm9Ysas7djynPZopJWa+quOOkeo8a2vUGSfRemAd5uDz84Vi18zel1zsqCN+Yfg07sdDESaeLzTU6ZMBxdCheUEjlY4xw9SvUHbZuDsdS6rYzBxc91V1JoGMhM01gPtVd3ykuORYjHS48sZqQSt0Z5ot9YkXZIIzyvlDt7DIeeD33HN2XHhbpv3PvP/hqEkaMLgnpzios53MPLz4qXyFhAOEM4IqM+eeX6+mxpVpywuQcy7fUgk5bVuslcJfYywMmroRpP8cRL0ZmPvCka4jQnC2uogbylD50qzmvKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 13:59:22 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 13:59:22 +0000
Date: Wed, 18 Oct 2023 21:59:11 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH iproute2-next 0/2] Increase BPF verifier verbosity when
 in verbose mode
Message-ID: <ZS_kr7X5Jwo4x360@u94a>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018062234.20492-1-shung-hsi.yu@suse.com>
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d446ada-4fb4-488d-9f6b-08dbcfe26e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ik3KyGeKxjevVNJ3RO6PBz7Nf3I6RSWRwDKbJrxYQtcQo/2eMy3DfQxopuzLDt0So1Qd1GyoYtzkcdahzNC7DzaKlonhbgDe9ogXA0MqhXQcbdtLYzsrImPOxpLrqKSjQUpReHDZz8XDNWZrRDw++J3Ug+cevOVfwGHzrcL4bCGWn+OPQN21GMqMk/iKmscgjuXe6FZT0yO48qiQAmviOLMLqgEfvd8ja7rTTjLLYZSO5F35su/KDqr07qoyvK4faWnX8c4V1oGauuqSqX38E8UIeyjLpQn0R6NtTL1n4ZX4KUK4B9a2Y3DRgUIyHbpsTB1EvRvGpBC6y+dCA7vKkoYtz0wpyUWsKBIrrfcAvWpNG1HR4sAOeCY3J6h7sZCS6sr3l7GoIYrhW+3qWai48Fzwc8OcLMTSrnagb8Rv6fDct2VuDc3MXWmOgo4RJHE4IYMx8sCNbdys4Ah1SghE3hMl3k2FI0HRIqqaPKChnO7jqQ1gcBt/N+HWcABbHiwnqbHMH89GkT3PzJVNADqV9fp79dh1GmEoDWSJy747U0K99mgnThlDEWkb1mtYnEsO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(26005)(6506007)(8936002)(83380400001)(41300700001)(5660300002)(4326008)(2906002)(8676002)(6486002)(33716001)(478600001)(316002)(66556008)(66476007)(54906003)(38100700002)(6916009)(66946007)(86362001)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEpScHNNL2tDU3Z3bnAwMzhLamRvdExudTdiNTgwVlB1RHl4eFZHN2NQZXdn?=
 =?utf-8?B?REtoNEhqeUZJbjdQMEhNMXFaUFNGeTEzM0RSSjZsOWNxdGk4SDlNQmErU2VM?=
 =?utf-8?B?N0RqZzlBRExYOXNCSmxNYlQ1SExkWUJOUEVQRnJKQlEvamVyT05KYms3dVMy?=
 =?utf-8?B?elZwQ3ZFMUNLR1IxZDFGblAzUzJNQUZxekRyK0lFazg1T3pFMHRhTitRUDBS?=
 =?utf-8?B?VEFKaGZwN2w4WTIzWUFOaXF2Q1hiT3JGYm9kbnVQaDJBVkR1WWlGTjYwSHNa?=
 =?utf-8?B?cnNrcENXSjVBT0xNYkNUS1BYdTZtS3VYNDRmNGFzdythRU80aUFoM0pqY3dS?=
 =?utf-8?B?UkpQV3dRR1FjU3F2SGptUjkwdkxNWVVENzJOU1JQenByVGd3d2NYMkcybmk3?=
 =?utf-8?B?VmdkdHphd0RvZUhnL3FmaFN3clZwSk1XVHpMRUsydHJrQjNObXJPM3I2RFFa?=
 =?utf-8?B?aUtrYjhnMU9FVkZTWWs2MGJDUzladzV5Vll3c1ZiY09KbVhjZGZkZ3VUZUhM?=
 =?utf-8?B?cHlZaEUyUElCUkp5c3VGZ3FacE5qSERWYlR1VlRwT1c0bWQwODAySm1OcDZG?=
 =?utf-8?B?OUU3UnVlVGtmNXlLSjEwODBsN2RqVXljQXNMS1MzRVRzcGcwdlBoRUZEWWo5?=
 =?utf-8?B?bFZXaXB4UU9JcktQODBHMUdMbzJHc2R6VnlhV0FaQXl5Ky9La2k4azh4UUR0?=
 =?utf-8?B?akExelhsdHAvT3QxMGdUVEhrRFE5dmlsNS9Xak9abVRWSEpSRVM1Q3dwNStq?=
 =?utf-8?B?SEROOUNuT1huTDU5dzBoUS92Yk9td1Y0WVd4bVI5WnRnVFh2VDc3U1VxeWQ0?=
 =?utf-8?B?SnVKWUpWdFpodG1yRUlYNFNDY2phR3JqVnRpbk1TT1JEb3d6UHBmbTVwd0dS?=
 =?utf-8?B?SFNRWW5pR21tUTBVVHZ2NDRTb29XdVVMbEFhTDZmTTRJVFcyU2VzZTFsYWhw?=
 =?utf-8?B?ejNtUVN2dUV6Z0p6RFA1cFBLc0t2UFlUZ3M3V1lseERHUEhtV1l2QUJMV0Zu?=
 =?utf-8?B?K0xDZWJVVGVFdWJnMVJFZFZieW5DNjY5Rng3L2t0QTRnQjJTaFdsbERDRDdt?=
 =?utf-8?B?dTBNdTNvY25TQXQ4d1p6Q0E1eDBWSnpuTUVzUnNBR1FFN0lWM2NqTFEzSDFo?=
 =?utf-8?B?SU5IcEkwRGhEMEY5bFFVQXp1RjFxYTNQTU5IUkppV0FuZi8xTGx4bFE5Um5u?=
 =?utf-8?B?WFVSTWR4TURGOFUvTVlEZS96Q1ZkMnVMNFI0c0Zla0NtTjk4UWlsNGRtZ3dF?=
 =?utf-8?B?UTF4Qk1iclc3ZlRSTmo2M3J2dW1mWmVOV0JtMXRjdUdmbXJ0VndrSkJ1MWlC?=
 =?utf-8?B?OFFINVJpQVM5dTBndlVtSkdLQlpRdUFTaFUxNTFMY09IazF2cUdSMGVtOWhJ?=
 =?utf-8?B?eTYwY3VDckJkc0xJMHNsamhVenZSdDVyVkw4azZrZTAybWh1UlhsbkNiT1h3?=
 =?utf-8?B?YVpuaFdIaUtwWXlsb3YyZ3ZBUWd4WTZhZFhCOHhMdTgwVWw4WnQ5a09oK0U4?=
 =?utf-8?B?NkNxWFFSa0ZlQTlXNmh2KzZZWnJXWUtiS2JrWEk4clBYTk1sZDR3M3lmdkda?=
 =?utf-8?B?L1ZKejNKZVpRUEFsUFhLbzVLdlQzN0JNUGpoWGcyL2IyM2RJWEVvR093Wmli?=
 =?utf-8?B?SytYN2hobXBpWUovamMrTWRWUlNJNUhZU2RRemkyUXpBS000bFN2dWxhMG14?=
 =?utf-8?B?Vm51N0JkWC9LUFNIQ1ZRRjlka0hMSkhjcS9vNEVmYXNyWDhaSUd0ZFVZNkJ0?=
 =?utf-8?B?Z0VCWHVDVEt5LzU3anB2VUNQTUpLN3IwY2VBRTJJN05Bb2t6WWhkK0ZRL3V5?=
 =?utf-8?B?M1dvcUdhNVdXOWd1cy9jb0F0M3U3Y3N5TTJnODhXMDRoTkRqSm1UQi93dEtL?=
 =?utf-8?B?VnVEM0FtaU54eXp4OXBBY055cGdzQjgzdk4rVDNhRUpjajlsNEZhSlBmbHg5?=
 =?utf-8?B?WjVWSytZY0dyL3FFc0lkaGNtMDhQeVRjbUFvL2o3UzYxbEowSUZQc1FjNFVS?=
 =?utf-8?B?NHU1WCs2THgxQmVvOG1OMFQyMFlVWWZneVVzVlVVYm92V2xsdEhQVEFiQXVz?=
 =?utf-8?B?cFIyWmJjYnFvbUVZZUo2eXlSU0RvRzh4R01pRXhQMHBOY2hCVzFTdldHRFEy?=
 =?utf-8?Q?ljMjkse3abLbmjMCMa+2krcVD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d446ada-4fb4-488d-9f6b-08dbcfe26e38
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:59:22.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXwDGCiz87ggEronLS5KsVeb5o4Ufx7nmFqSlbuF89CUqGBI9dc5KxwSdnkLze3CfNw48QeV8QUu6bhqc3n8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 02:22:32PM +0800, Shung-Hsi Yu wrote:
> When debugging BPF verifier issue, it is useful get as much information
> out of the verifier as possible to help diagnostic, but right now that
> is not possible because load_bpf_object() does not set the
> kernel_log_level in bpf_open_opts, which is addressed in patch 1.
> 
> Patch 2 further allows increasing the log level in verbose mode, so even
> more information can be retrieved out of the verifier, and most
> importlantly, show verifier log even on successful BPF program load.

Got some typos in patch 2, and bpf_open_opts should be bpf_object_open_opts.
Will send v2 to correct these mistakes.

> Shung-Hsi Yu (2):
>   libbpf: set kernel_log_level when available
>   bpf: increase verifier verbosity when in verbose mode
> 
>  include/bpf_util.h |  4 ++--
>  ip/ipvrf.c         |  3 ++-
>  lib/bpf_legacy.c   | 10 ++++++----
>  lib/bpf_libbpf.c   |  6 ++++++
>  4 files changed, 16 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 575322b09c3c6bc1806f2faa31edcfb64df302bb
> -- 
> 2.42.0
> 

