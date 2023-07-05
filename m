Return-Path: <netdev+bounces-15642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A364F748EA4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 22:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2F228104A
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33314156C8;
	Wed,  5 Jul 2023 20:12:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E811CA4
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 20:12:41 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA06173B;
	Wed,  5 Jul 2023 13:12:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qH8rY-0000L4-6w; Wed, 05 Jul 2023 22:12:32 +0200
Date: Wed, 5 Jul 2023 22:12:32 +0200
From: Florian Westphal <fw@strlen.de>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH] netfilter: nf_tables: prevent OOB access in
 nft_byteorder_eval
Message-ID: <20230705201232.GG3751@breakpoint.cc>
References: <20230705121515.747251-1-cascardo@canonical.com>
 <20230705130336.GD3751@breakpoint.cc>
 <ZKWzx3e6frpSs8bN@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKWzx3e6frpSs8bN@quatroqueijos.cascardo.eti.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> > > @@ -74,11 +77,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
> > >  		switch (priv->op) {
> > >  		case NFT_BYTEORDER_NTOH:
> > >  			for (i = 0; i < priv->len / 2; i++)
> > > -				d[i].u16 = ntohs((__force __be16)s[i].u16);
> > > +				d16[i] = ntohs((__force __be16)s16[i]);
> > 
> > This on the other hand... I'd say this should mimic what the 64bit
> > case is doing and use nft_reg_store16() nft_reg_load16() helpers for
> > the register accesses.
> > 
> > something like:
> > 
> > for (i = 0; i < priv->len / 2; i++) {
> >      v16 = nft_reg_load16(&src[i]);
> >      nft_reg_store16(&dst[i], + ntohs((__force __be16)v16));
> > }
> > 
> 
> The problem here is that we cannot index the 32-bit dst and src pointers as if
> they were 16-bit pointers. We will end up with the exact same problem we are
> trying to fix here.
> 
> I can change the code to use the accessors, but they use u32 pointers, so it
> would end up looking like:
> 
>  		case NFT_BYTEORDER_NTOH:
>  			for (i = 0; i < priv->len / 4; i++)
> -				d[i].u32 = ntohl((__force __be32)s[i].u32);
> +				dst[i] = ntohl((__force __be32)src[i]);
>  			break;
>  		case NFT_BYTEORDER_HTON:
>  			for (i = 0; i < priv->len / 4; i++)
> -				d[i].u32 = (__force __u32)htonl(s[i].u32);
> +				dst[i] = (__force __u32)htonl(src[i]);

Ack, thanks.

>  		case NFT_BYTEORDER_NTOH:
> -			for (i = 0; i < priv->len / 2; i++)
> -				d[i].u16 = ntohs((__force __be16)s[i].u16);
> +			for (i = 0; i < priv->len / 2; i++) {
> +				__be16 src16;
> +				src16 = nft_reg_load_be16((u32 *)&s16[i]);
> +				nft_reg_store_be16((u32 *)&d16[i], ntohs(src16));
> +			}

These accessors take a registers' address, not something in-between.

I think your original was better after all and we need to rely on whatever
expression filled the register to have done the right thing.


