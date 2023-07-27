Return-Path: <netdev+bounces-22077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2123765E46
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 23:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A502824B9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DB1CA15;
	Thu, 27 Jul 2023 21:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFE17AC4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 21:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22F6C433C7;
	Thu, 27 Jul 2023 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690493558;
	bh=LFiOuKaV4mYQNVWY6/YSUjVKfAWsifUjllsJxEWkg8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3h/UWMhwQ4HJv0OU0SmB484+Mafgk/jk4xS+WlpXnP+79zKugFJ0W00kXfqOMUb1
	 V12jq8z7gzm+9/LDbIrDUUgD0o68nv+G//zyM5RiNm8OldUYjrw0vf+K/WRP8Xc9JA
	 trmz3jisE21oeOqtLnSi2ABih/sVEOTC+P81D32c2u4+DX0q/9vJhnmC7ORaY/Inxn
	 911c5GEXmYs12kMkBXi1f3ViZN9/45PPH0P+yrvqH+IB4Dr2P6xMuqfp3/JRoZKYAr
	 lt9F+PKsw876bbfX5mygCil62jIQn8Vr9iX769LeyZVyChHBym8Bc58XQIi72H7UTS
	 jsNI8ZItJ5trQ==
From: SeongJae Park <sj@kernel.org>
To: Rishabh Bhatnagar <risbhat@amazon.com>
Cc: gregkh@linuxfoundation.org,
	lee@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"Jamal Hadi Salim" <jhs@mojatatu.com>,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 4.14] net/sched: cls_u32: Fix reference counter leak leading to overflow
Date: Thu, 27 Jul 2023 21:32:36 +0000
Message-Id: <20230727213236.49413-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727191554.21333-1-risbhat@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Jul 2023 19:15:54 +0000 Rishabh Bhatnagar <risbhat@amazon.com> wrote:

> From: Lee Jones <lee@kernel.org>
> 
> Upstream commit 04c55383fa5689357bcdd2c8036725a55ed632bc.
> 
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
> 
> In order to prevent this, move the point of possible failure above the
> point where the reference counter is incremented.  Also save any
> meaningful return values to be applied to the return data at the
> appropriate point in time.
> 
> This issue was caught with KASAN.
> 
> Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>

Acked-by: SeongJae Park <sj@kernel.org>

> ---
>  net/sched/cls_u32.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index fdbdcba44917..a4e01220a53a 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -774,11 +774,22 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
>  			 struct nlattr *est, bool ovr)
>  {
>  	int err;
> +#ifdef CONFIG_NET_CLS_IND
> +	int ifindex = -1;
> +#endif
>  
>  	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr);
>  	if (err < 0)
>  		return err;
>  
> +#ifdef CONFIG_NET_CLS_IND
> +	if (tb[TCA_U32_INDEV]) {
> +		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV]);
> +		if (ifindex < 0)
> +			return -EINVAL;
> +	}
> +#endif
> +
>  	if (tb[TCA_U32_LINK]) {
>  		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
>  		struct tc_u_hnode *ht_down = NULL, *ht_old;
> @@ -806,14 +817,10 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
>  	}
>  
>  #ifdef CONFIG_NET_CLS_IND
> -	if (tb[TCA_U32_INDEV]) {
> -		int ret;
> -		ret = tcf_change_indev(net, tb[TCA_U32_INDEV]);
> -		if (ret < 0)
> -			return -EINVAL;
> -		n->ifindex = ret;
> -	}
> +	if (ifindex >= 0)
> +		n->ifindex = ifindex;
>  #endif
> +
>  	return 0;

Very trivial nit: Someone might think the above new line is better not to be
added?  I don't really care, though.

>  }
>  
> -- 
> 2.40.1
> 

Thanks,
SJ

