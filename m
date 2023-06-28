Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12D74193C
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 22:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjF1UFX (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 16:05:23 -0400
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:56106
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229626AbjF1UFW (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 16:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX8sOBQVP9GyhS1bIgEjSfDvkKA7qkY80z3jBZuJfauJVAVDKz4TFLUt4ibdXQ7AyPVSCm1U7Rhd6xAOlC0uWIQaA6Z5kNNQHqc3HCwavVbhAPP8Ws5u3mFLYomkxGUmx+zodXSlh8zgtboHCKnJpqrFrwRWapyKlc/dIJHY/T2cyIdqu44isSCqgoS3GLcf6UctEMNQ8AsMwS6t6GKCntUYYRH6DNC1DY+hugVlYWThTZ2L4uRqYS83zPM6WDWLHmIDFmIJOTTvxmr4kt5YgE4Ju8leEHy1mhBs6O8rCqb9BD3tkF0vhlLN5F8J0EqektWRUWTthOrr2zJYcoa0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FmiIeuQwg5Pu3vbVZO9va0wVOEB/lFLIfxR+3c9G48=;
 b=V6Ape2YI7kJdVo2AOz0S9SsVx8qymMz0498WIyc9U9obDXqEnjyZ36VeIg4dsH9oUx2uTM4icba23/6uiqLg+UIGdtB19Bv+/eSvniZ9lsWRTK5hQzRj3RG53Tj3BoOTJdqhtSEpnOZ4ApXMysskzh/fp1MD3zbNYL/gvF8/gMVLZXPfN39lbYu38yM8jyzOrnFi+MN3PA5rMC8wbp+9Z9xbrZXpZVJlJ2WKB6snfnTOxbZzFgi4ivoLq2sXgp+erOAiqzacOn/bbF9bkjKNHwo6EZSnMQwilTsbZAr0R0OSi41Akgnenezd0wDq2nUzi8UxeOkor9Cx5uZM88suiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FmiIeuQwg5Pu3vbVZO9va0wVOEB/lFLIfxR+3c9G48=;
 b=wX7rNkXPbvuMA+J3VWtKYkc0Ui3J4SY0yvDY9dzGWfhYH0uZTRUBg6Md2bDyLZgnPsiZVLf249FggQyTJbeTA12bKFdypsqdOntDQMCdHistvTTkGGX9Wo+TSHuwlpHcNj1yJ6sZA+APwCulxc8wXGYuV105O8SIg+nij+9Nd50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4041.namprd13.prod.outlook.com (2603:10b6:303:5e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 20:05:18 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 20:05:17 +0000
Date:   Wed, 28 Jun 2023 22:05:11 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     ilias.apalodimas@linaro.org, hawk@kernel.org, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linyunsheng@huawei.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool
 case
Message-ID: <ZJySdw+RTl5CHSEy@corigine.com>
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628121150.47778-1-liangchen.linux@gmail.com>
X-ClientProxiedBy: AM0PR02CA0103.eurprd02.prod.outlook.com
 (2603:10a6:208:154::44) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc3d512-6ead-46b4-abed-08db7812fe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaVsXUvRiKQkHW7VPgl8j/eXbWL+ow1PI3rhdkVBi6cnk9Bl5jH1AwBy/1Gn3c69gHqAiKW1Ow//c60xm65CM3V4p+9K5HosljH4Q0erce3WwyLKDOw2Nx6p2HN09VrSPF8fFdSQhu03VOBVWislC7tEU1g2KOoEejfNu8GyvSIwFGM0T+4a1UKEj2SXyOHLrb/0Jqd5Jj6dakm3dcNtq4tl5C47MIoxHgGRTYDPGvEydFZn1HUXJSEUaxcH+JxtW36MMGl5fDbrfRUZ81j70CAj+QsaYxuGZa8MM2JSziXku+uVdXYVPJRSJfeIfdNTza5WuCccA9tQA3jybCqcQxsf7DP4re2yNXy1L6Luv57d1C0vz0X4OTsIaE73HjaQ3r00Dw9I95OXQOC+VnQ7m7KZ4jXarSW/dgusWkhoiu3BHNyYtvQaVhe3kK/QrTTwVlgV9odecuWViKUksma4SSoviQZppvaZP59H2Gbw8Nxom5YgnIdGWSiheifJt8zw1XA0nfEyHyXC1l9plzNh97aZziXRAgcSUulSj7y4dHPy2hfa8X3YC+uqJqc+CIQiNEIgOh/maqSCdqHChHxpzW2sdhB1xSGWsrVVwZMTyYO5B7Twp/gyVnseE/23QNFay7Wy/KkXK62U++hH+936fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39840400004)(346002)(451199021)(2906002)(186003)(6486002)(83380400001)(2616005)(38100700002)(6506007)(6512007)(6666004)(86362001)(966005)(41300700001)(478600001)(316002)(36756003)(66556008)(66946007)(4326008)(66476007)(6916009)(44832011)(5660300002)(8676002)(8936002)(66899021)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dixPd5+IQEIKlMr4AYKsd+BLzQQD8341+Lp38zcyso8ij3cCHhR3nkwFxEju?=
 =?us-ascii?Q?DCwE0S70glw2Nz7aNkcAeFA+rNx8sSCIVSigDZb3LSh1CxMJptGfZOzG3ZT+?=
 =?us-ascii?Q?tKl3+nD0inzOt+BDqIXKz76E6d63Gq+kpenzXuktVhXd0OJErM967dPPQSkI?=
 =?us-ascii?Q?0o6o7mdT3EzhRKukPRW1KXXmzjo+44A4QGk9ujlt1l5CrVpgAwl3kJmks7xm?=
 =?us-ascii?Q?CQjnRHXT5UxDThPcc/mx9fPp6RJi1ntojAwPLgYTrZwzhebF8keb23+TcdcX?=
 =?us-ascii?Q?jlRst/dkPtnIBa0nOobLvd1Ir+inb8VYPVHUd63Zf5raVxeYbTfya23CWhzv?=
 =?us-ascii?Q?XnSlWCQRFPy0T2DK+WPt0Wv+wlIe2LB5GI25jDMl0aSHSGPgSbuGzpJ9lqUe?=
 =?us-ascii?Q?XNmnCwco+fHnoGAxTie6cTvqsYRVI9yl5TvC8kajjU6eDrUuh1iI/pX6xOv1?=
 =?us-ascii?Q?OM3h9x4wI7TYYEigG47rigKaDh0FQ7CIlvUg0SIt/n5xKo9vJmjg9EfKog0Q?=
 =?us-ascii?Q?7E9OrU0KRC8UXe1ggL7moXO9YfatJBgGUVdIfKL2RxjOyjX816Kt9tKW+Lhw?=
 =?us-ascii?Q?PrSv7hmGhmHosVPfguefClMqBDQGjspFyV4cAVzYZFeDyLGvDV1rETDaIYea?=
 =?us-ascii?Q?P0j0QOBa6KoZbtbRKQWNRWH6kHhuRhJ5woq2p/Co/BstZcmBrtCTblo0K7se?=
 =?us-ascii?Q?tMwlOqxM8Ia2T5JZEWPbxClU/9vYbRx1k1+9iTkBy7CINOrVoHbDbWdq45D+?=
 =?us-ascii?Q?IZJxNaZOVEnkPBNbhvJ+U5jDMUVxFCj+rNb6MxeWFcTFZZiaxk4jVdPbBRQG?=
 =?us-ascii?Q?pURho7RcVJIEx9mO6mmUBd9UyisWgvqMq8j/eqdAwClHuYWo9SKdXTYRVT4d?=
 =?us-ascii?Q?pRsNGgLfPkolTS36EgABD4wn1SXhuJmQ1FSfid2a1E/LNVutVqR3SXlsFqVa?=
 =?us-ascii?Q?sMep6GQmktnt7DEfncmYvcspR8pa9J4bldemqCNqR6HU5aAvw9UjHn1Xs9Yk?=
 =?us-ascii?Q?ieMaujJSvt/7JnZEAPDon8l6oXRlY4PemaPcywNlL15Od2koG112/hSrAlJb?=
 =?us-ascii?Q?jsE070ou2XkakYWhGOHlyLs/frx5/+qvqFsnkzi2slGe3+qIUoY50EAn5BBa?=
 =?us-ascii?Q?Al0kkAnlAyRPWgTdnF+E4Uuu1q4auNUyHkyPcGtpBWgbp7nyGnGa+6BSlxVK?=
 =?us-ascii?Q?PNO0cZydDi8eoDOZLW7TWqM5GEwDFeGndM6qEbqXPYUexEJt/ei7MDl264aY?=
 =?us-ascii?Q?QdnQz7yUVPEsoQ8hazJxb5NM3nY2b9hJx6S2b44DUu22HvaCh2HKxqAuv8zX?=
 =?us-ascii?Q?LoroUSjCLGMvzXFpvWX26RMN9ZcTCqgkZ3qBjKIyUg6J0dsVTjPhAoiR2AdX?=
 =?us-ascii?Q?BNGSC6RMMtKaCKkT9p1io4VCsV1ntpZbEn/516dqm39HbFvkGObiqs27DSSp?=
 =?us-ascii?Q?xKmYp4M/EGmx+ETOYUhWliOsYbC/RjA8R4Fpli3BveApd4TKj+qlOjqXut/X?=
 =?us-ascii?Q?UnPrhYuiblX/raZ3wRhPKF31eomFqm91Pu8csamn8yncGulnPq45HUHdMaK0?=
 =?us-ascii?Q?e9CwVrcFhSsr1JvGQYfnLc+PSP6+1yRM5v4iOwGj68HnY+8mn2KJLGtr/Q/j?=
 =?us-ascii?Q?BMhYj9rFjG4x5dD3tltvpfRadWq3OuMCNRbuvfZ+4vdJUVQ1CH0uRGR3oGa+?=
 =?us-ascii?Q?jd9iSg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc3d512-6ead-46b4-abed-08db7812fe6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 20:05:17.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0vQiGouR8igj4P65ey76WwRJFe1RTP2mxasSNUM21HZcr9IjPMIf9nQMXK0K15+/3GkQvrX+c/AMYbTI+zXSKc4er+Xc11GWzCuzsC/Yms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4041
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 08:11:50PM +0800, Liang Chen wrote:
> In order to address the issues encountered with commit 1effe8ca4e34
> ("skbuff: fix coalescing for page_pool fragment recycling"), the
> combination of the following condition was excluded from skb coalescing:
> 
> from->pp_recycle = 1
> from->cloned = 1
> to->pp_recycle = 1
> 
> However, with page pool environments, the aforementioned combination can
> be quite common. In scenarios with a higher number of small packets, it
> can significantly affect the success rate of coalescing. For example,
> when considering packets of 256 bytes size, our comparison of coalescing
> success rate is as follows:
> 
> Without page pool: 70%
> With page pool: 13%
> 
> Consequently, this has an impact on performance:
> 
> Without page pool: 2.64 Gbits/sec
> With page pool: 2.41 Gbits/sec
> 
> Therefore, it seems worthwhile to optimize this scenario and enable
> coalescing of this particular combination. To achieve this, we need to
> ensure the correct increment of the "from" SKB page's page pool fragment
> count (pp_frag_count).
> 
> Following this optimization, the success rate of coalescing measured in our
> environment has improved as follows:
> 
> With page pool: 60%
> 
> This success rate is approaching the rate achieved without using page pool,
> and the performance has also been improved:
> 
> With page pool: 2.61 Gbits/sec
> 
> Below is the performance comparison for small packets before and after this
> optimization. We observe no impact to packets larger than 4K.
> 
> without page pool fragment(PP_FLAG_PAGE_FRAG)
> packet size     before      after
> (bytes)         (Gbits/sec) (Gbits/sec)
> 128             1.28        1.37
> 256             2.41        2.61
> 512             4.56        4.87
> 1024            7.69        8.21
> 2048            12.85       13.41
> 
> with page pool fragment(PP_FLAG_PAGE_FRAG)
> packet size     before      after
> (bytes)         (Gbits/sec) (Gbits/sec)
> 128             1.28        1.37
> 256             2.35        2.62
> 512             4.37        4.86
> 1024            7.62        8.41
> 2048            13.07       13.53
> 
> with page pool fragment(PP_FLAG_PAGE_FRAG) and high order(order = 3)
> packet size     before      after
> (bytes)         (Gbits/sec) (Gbits/sec)
> 128             1.28        1.41
> 256             2.41        2.74
> 512             4.57        5.25
> 1024            8.61        9.71
> 2048            14.81       16.78
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

Hi Liang Chen,

Please consider running checkpatch.pl --strict over this patch.

But, more importantly:

[text from Jakub]

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
