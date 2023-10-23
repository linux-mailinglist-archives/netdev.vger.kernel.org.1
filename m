Return-Path: <netdev+bounces-43430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8277D2FBD
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0589D281498
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070814295;
	Mon, 23 Oct 2023 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2617314266
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 10:24:24 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9295DD68;
	Mon, 23 Oct 2023 03:24:22 -0700 (PDT)
Received: from [78.30.35.151] (port=33190 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qus6b-00F1fA-Sl; Mon, 23 Oct 2023 12:24:19 +0200
Date: Mon, 23 Oct 2023 12:24:17 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Blakey <paulb@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH netfilter] Fix hw flow offload from nftables
Message-ID: <ZTZJ0WGBHRBvoDca@calendula>
References: <20231023101347.564898-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023101347.564898-1-donald.hunter@gmail.com>
X-Spam-Score: -1.9 (-)

On Mon, Oct 23, 2023 at 11:13:47AM +0100, Donald Hunter wrote:
> The NF_FLOW_HW_ESTABLISHED bit was not getting set in any nftables code
> paths. It seems that the state was never correctly maintained but there
> was no negative side-effect until commit 41f2c7c342d3 ("net/sched:
> act_ct: Fix promotion of offloaded unreplied tuple") which uses it as
> part of a flow outdated check. The net result is repeated cycles of
> FLOW_CLS_REPLACE / FLOW_CLS_DESTROY commands and never getting any
> FLOW_CLS_STATS commands for a flow.
> 
> This patch sets and clears the NF_FLOW_HW_ESTABLISHED bit for nftables.
> 
> Note that I don't have hardware to test this with. I have observed
> the behaviour and verified the fix with modified veth code.

Very strange, this bit did not exists before:

commit 1a441a9b8be8849957a01413a144f84932c324cb
Author: Vlad Buslov <vladbu@nvidia.com>
Date:   Wed Feb 1 17:30:57 2023 +0100

    netfilter: flowtable: cache info of last offload

I have no idea why this is needed.

> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Fixes: 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded unreplied tuple")
> ---
>  net/netfilter/nf_flow_table_offload.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
> index 1c26f03fc661..1d017191af80 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -918,6 +918,7 @@ static void flow_offload_work_add(struct flow_offload_work *offload)
>  		goto out;
>  
>  	set_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
> +	set_bit(NF_FLOW_HW_ESTABLISHED, &offload->flow->flags);
>  
>  out:
>  	nf_flow_offload_destroy(flow_rule);
> @@ -925,6 +926,7 @@ static void flow_offload_work_add(struct flow_offload_work *offload)
>  
>  static void flow_offload_work_del(struct flow_offload_work *offload)
>  {
> +	clear_bit(NF_FLOW_HW_ESTABLISHED, &offload->flow->flags);
>  	clear_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
>  	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_ORIGINAL);
>  	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
> -- 
> 2.41.0
> 

