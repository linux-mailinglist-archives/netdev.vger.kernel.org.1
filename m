Return-Path: <netdev+bounces-212299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB64B1F03B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F49656356A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163528934D;
	Fri,  8 Aug 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iee8MpQ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6B288C33
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754688467; cv=none; b=U04F6yui9dVrdyqaTf5iP08KiqwLRUuEsgUBMFpJCm1bLfZlDYDRP72B8SJr53P1l4kJYONfcSPMu1/mMTwKhHypRfj3qk4iHOh7127hbnf/I97yGSSlrAkE9iz3xSpcjWxSUckNWIoxXEXlyhFQySLvUINqH79ZG/Ho3rayL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754688467; c=relaxed/simple;
	bh=5Glh8oUPVFGMn/iG5XH/bkyb8EKbs15Myhy4Dn8Yxqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+hHJKbqo54dmc+6ELqu2UlA6vvF5ZutNUUzU/9eNzzEBCFARD1sQ7W7rxndiWNsm6LZkusWE22DA44Gax4PXrgxiCqc90kcWeGtdqqC2P1dcRJ7sSdZP4ggUfbXn6G0Vcjjt02cIXi/jJm/pXm25IcAkKVycyfbkX+xCph1U6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iee8MpQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2DAC4CEED;
	Fri,  8 Aug 2025 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754688467;
	bh=5Glh8oUPVFGMn/iG5XH/bkyb8EKbs15Myhy4Dn8Yxqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iee8MpQ2p5a5ryT2oJ3kGbz6yNvx0vl1IBamSvbeLPIoQ13t2dmjr4JNPaXAehyG6
	 kFRNYzNBn3X8TLIN83ETZuTBVYknZsa9jh3F8X9/z765PGSLVx0CnuxjmlomfW5PLu
	 RwtT3NFVDeLm9JpoPLS9lTuQIqKH5RR9gQa09DPAGpmP5Znn7KcZcE7PWw6u+4wEk3
	 UNeg5QBYPH2Coludy9LUiabz89bmIr0/S89/TOG3lYm1YkzQi41QZW6czqpnNNXfY0
	 4U0hoabELniDbBCHhw0MmTzDwNgqGOdZ+f37MwH0MeV7FgaAF7PZ0iW6jRfIsKn+0o
	 eCQE0qhJILfKg==
Date: Fri, 8 Aug 2025 14:27:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
 victor@mojatatu.com
Subject: Re: [PATCH net v4 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
Message-ID: <20250808142746.6b76eae1@kernel.org>
In-Reply-To: <20250727235602.216450-1-will@willsroot.io>
References: <20250727235602.216450-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 23:56:32 +0000 William Liu wrote:
> Special care is taken for fq_codel_dequeue to account for the
> qdisc_tree_reduce_backlog call in its dequeue handler. The
> cstats reset is moved from the end to the beginning of
> fq_codel_dequeue, so the change handler can use cstats for
> proper backlog reduction accounting purposes. The drop_len and
> drop_count fields are not used elsewhere so this reordering in
> fq_codel_dequeue is ok.

Using local variables like we do in other qdiscs will not work?
I think your change will break drop accounting during normal dequeue?

> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 638948be4c50..a24094a638dc 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -1038,10 +1038,15 @@ static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool dir
>  	skb = __skb_dequeue(&sch->gso_skb);
>  	if (skb) {
>  		sch->q.qlen--;
> +		qdisc_qstats_backlog_dec(sch, skb);
> +		return skb;
> +	}
> +	if (direct) {
> +		skb = __qdisc_dequeue_head(&sch->q);
> +		if (skb)
> +			qdisc_qstats_backlog_dec(sch, skb);
>  		return skb;
>  	}
> -	if (direct)
> -		return __qdisc_dequeue_head(&sch->q);
>  	else

sorry for a late nit, it wasn't very clear from the diff but
we end up with

	if (direct) {
		...
	}
	else
		return ..;

Please reformat:

	if (direct) {
		...
	} else {
		...
	}

>  		return sch->dequeue(sch);
>  }

> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 902ff5470607..986e71e3362c 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -1014,10 +1014,10 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
>  		     struct netlink_ext_ack *extack)
>  {
>  	struct fq_sched_data *q = qdisc_priv(sch);
> +	unsigned int prev_qlen, prev_backlog;
>  	struct nlattr *tb[TCA_FQ_MAX + 1];
> -	int err, drop_count = 0;
> -	unsigned drop_len = 0;
>  	u32 fq_log;
> +	int err;
>  
>  	err = nla_parse_nested_deprecated(tb, TCA_FQ_MAX, opt, fq_policy,
>  					  NULL);
> @@ -1135,16 +1135,16 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
>  		err = fq_resize(sch, fq_log);
>  		sch_tree_lock(sch);
>  	}
> +
> +	prev_qlen = sch->q.qlen;
> +	prev_backlog = sch->qstats.backlog;
>  	while (sch->q.qlen > sch->limit) {
>  		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
>  
> -		if (!skb)
> -			break;

The break conditions is removed to align the code across the qdiscs?

> -		drop_len += qdisc_pkt_len(skb);
>  		rtnl_kfree_skbs(skb, skb);
> -		drop_count++;
>  	}
> -	qdisc_tree_reduce_backlog(sch, drop_count, drop_len);
> +	qdisc_tree_reduce_backlog(sch, prev_qlen - sch->q.qlen,
> +				  prev_backlog - sch->qstats.backlog);

There is no real change in the math here, right?
Again, you're just changing this to align across the qdiscs?
-- 
pw-bot: cr

