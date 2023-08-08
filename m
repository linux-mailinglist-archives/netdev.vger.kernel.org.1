Return-Path: <netdev+bounces-25367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDEA773CDE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9861C21073
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C213FEC;
	Tue,  8 Aug 2023 15:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6341C29
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:55:08 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE415B8C;
	Tue,  8 Aug 2023 08:54:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qTP2U-0001Au-Qj; Tue, 08 Aug 2023 17:54:30 +0200
Date: Tue, 8 Aug 2023 17:54:30 +0200
From: Florian Westphal <fw@strlen.de>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH] netfilter: ebtables: fix fortify warnings
Message-ID: <20230808155430.GB9741@breakpoint.cc>
References: <20230808014821.241688-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808014821.241688-1-gongruiqi@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GONG, Ruiqi <gongruiqi@huaweicloud.com> wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy
> {watchers,target,next}_offset altogether into offsets[]. Silence the
> warning by wrapping these three up via struct_group().
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
>  net/bridge/netfilter/ebtables.c                |  3 +--
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
> index a494cf43a755..e634da196d08 100644
> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
> @@ -182,12 +182,14 @@ struct ebt_entry {
>  	unsigned char sourcemsk[ETH_ALEN];
>  	unsigned char destmac[ETH_ALEN];
>  	unsigned char destmsk[ETH_ALEN];
> -	/* sizeof ebt_entry + matches */
> -	unsigned int watchers_offset;
> -	/* sizeof ebt_entry + matches + watchers */
> -	unsigned int target_offset;
> -	/* sizeof ebt_entry + matches + watchers + target */
> -	unsigned int next_offset;
> +	struct_group(offsets,
> +		/* sizeof ebt_entry + matches */

This is an UAPI header, I think you need to use __struct_group here.

