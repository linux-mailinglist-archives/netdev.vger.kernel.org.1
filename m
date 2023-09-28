Return-Path: <netdev+bounces-36829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE27B1EC8
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0A8CA28218D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27463B7A7;
	Thu, 28 Sep 2023 13:43:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4F3AC3D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:43:44 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729CC136;
	Thu, 28 Sep 2023 06:43:42 -0700 (PDT)
Received: from [78.30.34.192] (port=35962 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qlrIm-002BVs-Ok; Thu, 28 Sep 2023 15:43:39 +0200
Date: Thu, 28 Sep 2023 15:43:36 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: joao@overdrivepizza.com
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rkannoth@marvell.com, wojciech.drewek@intel.com,
	steen.hegenlund@microhip.com, keescook@chromium.org,
	Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH v3 2/2] Make num_actions unsigned
Message-ID: <ZRWDCGG5/dP12YEs@calendula>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
 <20230927164715.76744-3-joao@overdrivepizza.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927164715.76744-3-joao@overdrivepizza.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 09:47:15AM -0700, joao@overdrivepizza.com wrote:
> From: Joao Moreira <joao.moreira@intel.com>
> 
> Currently, in nft_flow_rule_create function, num_actions is a signed
> integer. Yet, it is processed within a loop which increments its
> value. To prevent an overflow from occurring, make it unsigned and
> also check if it reaches 256 when being incremented.
> 
> Accordingly to discussions around v2, 256 actions are more than enough
> for the frontend actions.
> 
> After checking with maintainers, it was mentioned that front-end will
> cap the num_actions value and that it is not possible to reach such
> condition for an overflow. Yet, for correctness, it is still better to
> fix this.
> 
> This issue was observed by the commit author while reviewing a write-up
> regarding a CVE within the same subsystem [1].
> 
> 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Yes, but this is not related to the netfilter subsystem itself, this
harderning is good to have for the flow offload infrastructure in
general.

> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
> ---
>  net/netfilter/nf_tables_offload.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index 12ab78fa5d84..9a86db1f0e07 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  {
>  	struct nft_offload_ctx *ctx;
>  	struct nft_flow_rule *flow;
> -	int num_actions = 0, err;
> +	unsigned int num_actions = 0;
> +	int err;

reverse xmas tree.

>  	struct nft_expr *expr;
>  
>  	expr = nft_expr_first(rule);
> @@ -99,6 +100,10 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  		    expr->ops->offload_action(expr))
>  			num_actions++;
>  
> +		/* 2^8 is enough for frontend actions, avoid overflow */
> +		if (num_actions == 256)

This cap is not specific of nf_tables, it should apply to all other
subsystems. This is the wrong spot.

Moreover, please, add a definition for this, no hardcoded values.

> +			return ERR_PTR(-ENOMEM);

Better E2BIG or similar, otherwise this propagates to userspace as
ENOMEM.

> +
>  		expr = nft_expr_next(expr);
>  	}
>  
> -- 
> 2.42.0
> 

