Return-Path: <netdev+bounces-55887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB380CB26
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80B2281B8B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE773F8D1;
	Mon, 11 Dec 2023 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exadUWhc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67381F60B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE30CC433C9;
	Mon, 11 Dec 2023 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702301864;
	bh=qlCi/i5ZtFO1V/UD7klRCv102FsIAb4RVquJmLbmht4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exadUWhcCCxY79D+MTvmvv9ipeXSLpbHLc9t6pog8kd1GU5ZhXVaja6Z7UOnlZdfj
	 YD1h4EkXDM8ZevhPPr4NvUFeqQ+MIqr7y6k9e0Kv0eP73Ot5EYG8G6X48/HbB8NRk+
	 kdzmIedxiejhkCXprMC89T4VUx/GP96q+LjZo90sxD/Gwk9mkOUUFS4hdFtCnSPaub
	 L0UPXzOVn7qP76BOjc0FPq8pvgPlymewiFxCpa//X2uNeLzbHZSjTxO4gsuTQHh8Lq
	 xpLsjhb/3RChq2ViuUZ6i4t/aASXJ5V5pYRNOj7DLZ1iDicVA2TaD4c1UzN8hnLJwY
	 +ZAvP3mIItPoQ==
Date: Mon, 11 Dec 2023 13:37:38 +0000
From: Simon Horman <horms@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v3 1/3] net: sched: Move drop_reason to struct
 tc_skb_cb
Message-ID: <20231211133738.GL5817@kernel.org>
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205205030.3119672-2-victor@mojatatu.com>

On Tue, Dec 05, 2023 at 05:50:28PM -0300, Victor Nogueira wrote:
> Move drop_reason from struct tcf_result to skb cb - more specifically to
> struct tc_skb_cb. With that, we'll be able to also set the drop reason for
> the remaining qdiscs (aside from clsact) that do not have access to
> tcf_result when time comes to set the skb drop reason.
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Hi Victor,

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  include/net/pkt_cls.h     | 14 ++++++++++++--
>  include/net/pkt_sched.h   |  3 ++-
>  include/net/sch_generic.h |  1 -
>  net/core/dev.c            |  4 ++--
>  net/sched/act_api.c       |  2 +-
>  net/sched/cls_api.c       | 23 ++++++++---------------
>  6 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..761e4500cca0 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -154,10 +154,20 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
>  	return xchg(clp, cl);
>  }
>  
> -static inline void tcf_set_drop_reason(struct tcf_result *res,
> +struct tc_skb_cb;
> +
> +static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
> +

nit: It's not very important, as this code disappears in the next patch,
     but FWIIW I don't think the forward declarations of
     tc_skb_cb (struct or function) are needed.

> +static inline enum skb_drop_reason
> +tcf_get_drop_reason(const struct sk_buff *skb)
> +{
> +	return tc_skb_cb(skb)->drop_reason;
> +}
> +
> +static inline void tcf_set_drop_reason(const struct sk_buff *skb,
>  				       enum skb_drop_reason reason)
>  {
> -	res->drop_reason = reason;
> +	tc_skb_cb(skb)->drop_reason = reason;
>  }
>  
>  static inline void

...

