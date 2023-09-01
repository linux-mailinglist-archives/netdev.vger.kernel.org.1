Return-Path: <netdev+bounces-31698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1678FA0F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 10:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BB3281333
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED663C8;
	Fri,  1 Sep 2023 08:39:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C08EBE
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 08:39:57 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4910CF;
	Fri,  1 Sep 2023 01:39:56 -0700 (PDT)
Received: from [78.30.34.192] (port=57334 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qbzh1-00AIpi-NY; Fri, 01 Sep 2023 10:39:54 +0200
Date: Fri, 1 Sep 2023 10:39:50 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] netfilter: nf_tables: ignore -EOPNOTSUPP on flowtable
 device offload setup
Message-ID: <ZPGjVl7jmLhMhgBP@calendula>
References: <20230831201420.63178-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831201420.63178-1-nbd@nbd.name>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Felix,

On Thu, Aug 31, 2023 at 10:14:20PM +0200, Felix Fietkau wrote:
> On many embedded devices, it is common to configure flowtable offloading for
> a mix of different devices, some of which have hardware offload support and
> some of which don't.
> The current code limits the ability of user space to properly set up such a
> configuration by only allowing adding devices with hardware offload support to
> a offload-enabled flowtable.
> Given that offload-enabled flowtables also imply fallback to pure software
> offloading, this limitation makes little sense.
> Fix it by not bailing out when the offload setup returns -EOPNOTSUPP

Would you send a v2 to untoggle the offload flag when listing the
ruleset if EOPNOTSUPP is reported? Thus, the user knows that no
hardware offload is being used.

> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/netfilter/nf_tables_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 41b826dff6f5..dfa2ea98088b 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -8103,7 +8103,7 @@ static int nft_register_flowtable_net_hooks(struct net *net,
>  		err = flowtable->data.type->setup(&flowtable->data,
>  						  hook->ops.dev,
>  						  FLOW_BLOCK_BIND);
> -		if (err < 0)
> +		if (err < 0 && err != -EOPNOTSUPP)
>  			goto err_unregister_net_hooks;
>  
>  		err = nf_register_net_hook(net, &hook->ops);
> -- 
> 2.41.0
> 

