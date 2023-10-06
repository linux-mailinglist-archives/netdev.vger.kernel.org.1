Return-Path: <netdev+bounces-38564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DF7BB6E9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D47E1C209B7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327A01CA91;
	Fri,  6 Oct 2023 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873471CA88
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:48:07 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ADCCA;
	Fri,  6 Oct 2023 04:48:05 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qojJ9-0008Nn-Kd; Fri, 06 Oct 2023 13:47:51 +0200
Date: Fri, 6 Oct 2023 13:47:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Ma Ke <make_ruc2021@163.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xfrm: fix return value check in ipcomp_compress
Message-ID: <20231006114751.GA29258@breakpoint.cc>
References: <20231006114106.3982925-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006114106.3982925-1-make_ruc2021@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ma Ke <make_ruc2021@163.com> wrote:
> In ipcomp_compress, to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/xfrm/xfrm_ipcomp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
> index 9c0fa0e1786a..5f2e6edadf48 100644
> --- a/net/xfrm/xfrm_ipcomp.c
> +++ b/net/xfrm/xfrm_ipcomp.c
> @@ -144,7 +144,9 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
>  	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
>  	local_bh_enable();
>  
> -	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
> +	err = pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
> +	if (unlikely(err))
> +		goto out;

This can't be right, this now calls local_bh_enable() twice.

