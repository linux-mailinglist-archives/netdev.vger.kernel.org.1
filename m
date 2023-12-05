Return-Path: <netdev+bounces-53894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168480518F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87392B20A46
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0254789;
	Tue,  5 Dec 2023 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qBr0Rtkm"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A8C134
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qI4PWlwKZMNnrMsf9kD/N2v+iTZyEqYMvi86Bid7+u4=; b=qBr0RtkmL1BwsX92yaCUKlorWD
	P9A3bCWNNe3YiJD++OHQWuHQVRczUB3XlxuKbcThLjYjGFpsOQgFc4fC7fqWiWQ66UimdWYlw2x9S
	/iVCIGvUiG5XLXyGgcYALVVqa8kcJJEgcvOVMYZ7HhTY0j52Kt83v5wHR5p1jqxuodMzAvTggOD8p
	8KdQj8mi6FZXpRUbObKWIxsntykJnhKc8EbEgIRvLDGjXjpq+UPoDUKtY4o4DqmDnxiCN4HBcvWwp
	jIjgTj1SyoBrAQWOveajvtJx26sc2rCQZospc7fNcFv86TLl5B8W/pSpW6LVwoJhxHpMshXotC39S
	sM1m5PVg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rATG9-0000qc-N7; Tue, 05 Dec 2023 12:06:37 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rATG8-000UP2-PH; Tue, 05 Dec 2023 12:06:36 +0100
Subject: Re: [PATCH net-next v2 1/3] net: sched: Move drop_reason to struct
 tc_skb_cb
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231201230011.2925305-1-victor@mojatatu.com>
 <20231201230011.2925305-2-victor@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7315d962-0911-81b9-7e60-452ab71e3193@iogearbox.net>
Date: Tue, 5 Dec 2023 12:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231201230011.2925305-2-victor@mojatatu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

On 12/2/23 12:00 AM, Victor Nogueira wrote:
> Move drop_reason from struct tcf_result to skb cb - more specifically to
> struct tc_skb_cb. With that, we'll be able to also set the drop reason for
> the remaining qdiscs (aside from clsact) that do not have access to
> tcf_result when time comes to set the skb drop reason.
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>   include/net/pkt_cls.h     | 14 ++++++++++++--
>   include/net/pkt_sched.h   |  1 +
>   include/net/sch_generic.h |  1 -
>   net/core/dev.c            |  5 +++--
>   net/sched/act_api.c       |  2 +-
>   net/sched/cls_api.c       | 23 ++++++++---------------
>   6 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..7bd7ea511100 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -154,10 +154,20 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
>   	return xchg(clp, cl);
>   }
>   
> -static inline void tcf_set_drop_reason(struct tcf_result *res,
> +struct tc_skb_cb;
> +
> +static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
> +
> +static inline enum skb_drop_reason
> +tc_skb_cb_drop_reason(const struct sk_buff *skb)
> +{
> +	return tc_skb_cb(skb)->drop_reason;
> +}
> +
> +static inline void tcf_set_drop_reason(const struct sk_buff *skb,
>   				       enum skb_drop_reason reason)
>   {
> -	res->drop_reason = reason;
> +	tc_skb_cb(skb)->drop_reason = reason;
>   }
>   
>   static inline void
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 9fa1d0794dfa..f09bfa1efed0 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -277,6 +277,7 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
>   
>   struct tc_skb_cb {
>   	struct qdisc_skb_cb qdisc_cb;
> +	u32 drop_reason;
>   
>   	u16 mru;

Probably also makes sense to reorder zone below mru.

>   	u8 post_ct:1;
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index dcb9160e6467..c499b56bb215 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -332,7 +332,6 @@ struct tcf_result {
>   		};
>   		const struct tcf_proto *goto_tp;
>   	};
> -	enum skb_drop_reason		drop_reason;
>   };
>   
>   struct tcf_chain;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3950ced396b5..323496ca0dc3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3924,14 +3924,15 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>   
>   	tc_skb_cb(skb)->mru = 0;
>   	tc_skb_cb(skb)->post_ct = false;
> -	res.drop_reason = *drop_reason;
> +	tc_skb_cb(skb)->post_ct = false;

Why the double assignment ?

> +	tcf_set_drop_reason(skb, *drop_reason);
>   
>   	mini_qdisc_bstats_cpu_update(miniq, skb);
>   	ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
>   	/* Only tcf related quirks below. */
>   	switch (ret) {
>   	case TC_ACT_SHOT:
> -		*drop_reason = res.drop_reason;
> +		*drop_reason = tc_skb_cb_drop_reason(skb);

nit: I'd rename into tcf_get_drop_reason() so it aligns with the tcf_set_drop_reason().
It's weird to name the getter tc_skb_cb_drop_reason() instead.

>   		mini_qdisc_qstats_cpu_drop(miniq);
>   		break;
>   	case TC_ACT_OK:
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index c39252d61ebb..12ac05857045 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1098,7 +1098,7 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
>   			}
>   		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
>   			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
> -				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   				return TC_ACT_SHOT;
>   			}
>   			tcf_action_goto_chain_exec(a, res);
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..32457a236d77 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1658,7 +1658,6 @@ static inline int __tcf_classify(struct sk_buff *skb,
>   				 int act_index,
>   				 u32 *last_executed_chain)
>   {
> -	u32 orig_reason = res->drop_reason;
>   #ifdef CONFIG_NET_CLS_ACT
>   	const int max_reclassify_loop = 16;
>   	const struct tcf_proto *first_tp;
> @@ -1683,13 +1682,13 @@ static inline int __tcf_classify(struct sk_buff *skb,
>   			 */
>   			if (unlikely(n->tp != tp || n->tp->chain != n->chain ||
>   				     !tp->ops->get_exts)) {
> -				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   				return TC_ACT_SHOT;
>   			}
>   
>   			exts = tp->ops->get_exts(tp, n->handle);
>   			if (unlikely(!exts || n->exts != exts)) {
> -				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   				return TC_ACT_SHOT;
>   			}
>   
> @@ -1713,18 +1712,12 @@ static inline int __tcf_classify(struct sk_buff *skb,
>   			goto reset;
>   		}
>   #endif
> -		if (err >= 0) {
> -			/* Policy drop or drop reason is over-written by
> -			 * classifiers with a bogus value(0) */
> -			if (err == TC_ACT_SHOT &&
> -			    res->drop_reason == SKB_NOT_DROPPED_YET)
> -				tcf_set_drop_reason(res, orig_reason);
> +		if (err >= 0)
>   			return err;
> -		}
>   	}
>   
>   	if (unlikely(n)) {
> -		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   		return TC_ACT_SHOT;
>   	}
>   
> @@ -1736,7 +1729,7 @@ static inline int __tcf_classify(struct sk_buff *skb,
>   				       tp->chain->block->index,
>   				       tp->prio & 0xffff,
>   				       ntohs(tp->protocol));
> -		tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +		tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   		return TC_ACT_SHOT;
>   	}
>   
> @@ -1774,7 +1767,7 @@ int tcf_classify(struct sk_buff *skb,
>   				n = tcf_exts_miss_cookie_lookup(ext->act_miss_cookie,
>   								&act_index);
>   				if (!n) {
> -					tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +					tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   					return TC_ACT_SHOT;
>   				}
>   
> @@ -1785,7 +1778,7 @@ int tcf_classify(struct sk_buff *skb,
>   
>   			fchain = tcf_chain_lookup_rcu(block, chain);
>   			if (!fchain) {
> -				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   				return TC_ACT_SHOT;
>   			}
>   
> @@ -1807,7 +1800,7 @@ int tcf_classify(struct sk_buff *skb,
>   
>   			ext = tc_skb_ext_alloc(skb);
>   			if (WARN_ON_ONCE(!ext)) {
> -				tcf_set_drop_reason(res, SKB_DROP_REASON_TC_ERROR);
> +				tcf_set_drop_reason(skb, SKB_DROP_REASON_TC_ERROR);
>   				return TC_ACT_SHOT;
>   			}
>   
> 


