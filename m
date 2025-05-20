Return-Path: <netdev+bounces-191829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB84ABD78A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A691BA2A63
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4B27CCE4;
	Tue, 20 May 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXKytEYl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14621C9F2
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742349; cv=none; b=bTzwRV2OUM1HuLM9mqfqcGTpaTTqklo22jI/+Oo/0qaBSmaOk4c18TLYEMyb4WBuyeTT/cewprHjnSuWOItFxY9CzfRwewdB1E9CoPNeQWwLuXba633rcRfudSEDSqvhxKVZvtMqRUTIC7J9+B0vO9OZweMP6K4kN4WAxqbPfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742349; c=relaxed/simple;
	bh=nXWSIhyU39QRKt6WQ0laW5mj88qmkU/jRLeC/v8jbzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mz5s30ogoxLk9ggNxRd1oNgt/WlSq/stml9A9/WycKhCG5iUlDT0fwMUWJZdM+D7wG8eMAh1Dlq9IuQMqn7HNWvSSMj82YluK/OzrXiAWr2z5KZxsLrCNf8Jmji9glvsK69z7cJM3ak5M8spnuFdaQJYeX6REWwia2D4tdEPtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXKytEYl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747742347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiDrqUHrJ5RRFmJ9shg+DFH2qBY04+xmY0waWetIyb0=;
	b=FXKytEYlBtaapXuORnZ3uct5CxGqY7PiCP6muyqrVvf3rf765YYkk63oW1TyMVaOEtOnq3
	QBSI4BtK7mVS/YXH4JcbmNlhG4UQBiS44Evku7WBi3aF2Ty7aW5zq4JSr1wlZSw7GC7R+B
	8idMdxFTq5QtZIJA7J6zs6kx+LvKkX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-9-yn7qehP-Gp_Q-0_tQBqg-1; Tue, 20 May 2025 07:59:01 -0400
X-MC-Unique: 9-yn7qehP-Gp_Q-0_tQBqg-1
X-Mimecast-MFC-AGG-ID: 9-yn7qehP-Gp_Q-0_tQBqg_1747742340
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a362dcc86fso1525405f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 04:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742340; x=1748347140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiDrqUHrJ5RRFmJ9shg+DFH2qBY04+xmY0waWetIyb0=;
        b=ReggaZF0a5FYqOYD5nEoMo8GVpSs1KvDkTkhpZQxP3osztYfSf4fTPUVtMloExN7VW
         Vptt79GrBYnr+1LpSj1XsC31YFmXtRRCz64xfVNt8P6lXl/jKdjM45s7ndaZrnNZBEIJ
         2JvSAhsnlsnlLSv6Gs9KIR+ctpeMpLPDBUlLmMr24a/Gh4CIVpvHfrew0sOpPlqN2fYz
         4NoUiPBWN0KKzxcuo9pOKfHjmB7iVuavINZG6qNgM4l3cJZKSgQ+cPTyR9Fp2RIk0Agv
         RqyEgtFIK2IeZ9VNvv+I6l+JvnzuN64UKX2jKQcdom+lSZ9Ollv5h3qqtyDSImTo5p48
         wwsw==
X-Forwarded-Encrypted: i=1; AJvYcCVpnVXGhO41UKFfvafdram4sgJe8eNGhwlfVNmFdX2Om+eLDQ1VselWYzXm6lqzQhrRqw45JRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlelkIJh5fIsJAn45MGOD0I97iuWK9QM2e2dRg/S9x8MRLO9o
	j/HhhBKTqZ9xwGXarxpP68dLcJcUELKjGk7A9ns2BF3Fkpz9C03I7YaiWJvYTVSDQwgFmQiBx5k
	QXE2VB2EpQYB58xQsz3r5jUtQ60VKIMe30JcruHB4QaZIxLCA9aZ00Uwsig==
X-Gm-Gg: ASbGnctyBrwUT4tbcxIgNRevES591ouT5lFNNq7VrnBuugKGd5+v+ky8634Ke/azg3P
	RIQ7ijSBHq7Xy8peHMownVCNGrZlfBSyStkwfQCP4gFd+oeqwhn9L4rypciCj6l19EA5PB5o1Fe
	FenUG4zqKnIKZcIe8mBWyZ5QjD3KbW9+Ml1AEw5U1UCB/1DHrju12g983xhyZ9muuVsmnIruuay
	uJYWSR2EyMKfdFeuE334zI8mNXBzvNn776rBuZB3PZbU6qc2Xm9MI8oo3FMK5FP+IFBMyF2nwrd
	5SLnnmDRpGy0UnbU+Io=
X-Received: by 2002:a5d:5846:0:b0:3a3:6ac3:fae2 with SMTP id ffacd0b85a97d-3a36ac3fd1dmr8011186f8f.4.1747742340288;
        Tue, 20 May 2025 04:59:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYfPr30NAX1g8x8Lo/HkiGqx5uMKfUlxTT6/hqjHQ+Vbin1NVN6yBQP3+UXU+zD3oY0eItGQ==
X-Received: by 2002:a5d:5846:0:b0:3a3:6ac3:fae2 with SMTP id ffacd0b85a97d-3a36ac3fd1dmr8011156f8f.4.1747742339775;
        Tue, 20 May 2025 04:58:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a365bc0b5esm12478708f8f.9.2025.05.20.04.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:58:59 -0700 (PDT)
Message-ID: <2454d982-feaf-49b5-8a17-a79c66cba5b6@redhat.com>
Date: Tue, 20 May 2025 13:58:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 2/5] sched: Dump configuration and statistics
 of dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
 <20250516000201.18008-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250516000201.18008-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 2:01 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> The configuration and statistics dump of the DualPI2 Qdisc provides
> information related to both queues, such as packet numbers and queuing
> delays in the L-queue and C-queue, as well as general information such as
> probability value, WRR credits, memory usage, packet marking counters, max
> queue size, etc.
> 
> The following patch includes enqueue/dequeue for DualPI2.
> 
> v16:
> - Update convert_ns_to_usec() to avoid overflow

The changelog should come after the SoB and a '---' separator.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/uapi/linux/pkt_sched.h | 15 ++++++
>  net/sched/sch_dualpi2.c        | 89 ++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index ae8af0e8d479..a7243f32ff0f 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1264,4 +1264,19 @@ enum {
>  
>  #define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
>  
> +struct tc_dualpi2_xstats {
> +	__u32 prob;		/* current probability */
> +	__u32 delay_c;		/* current delay in C queue */
> +	__u32 delay_l;		/* current delay in L queue */
> +	__u32 packets_in_c;	/* number of packets enqueued in C queue */
> +	__u32 packets_in_l;	/* number of packets enqueued in L queue */
> +	__u32 maxq;		/* maximum queue size */
> +	__u32 ecn_mark;		/* packets marked with ecn*/
> +	__u32 step_marks;	/* ECN marks due to the step AQM */
> +	__s32 credit;		/* current c_protection credit */
> +	__u32 memory_used;	/* Memory used of both queues */
> +	__u32 max_memory_used;	/* Maximum used memory */
> +	__u32 memory_limit;	/* Memory limit of both queues */
> +};
> +
>  #endif
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index ffdfb7803e1f..97986c754e47 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -123,6 +123,14 @@ static u32 dualpi2_scale_alpha_beta(u32 param)
>  	return tmp;
>  }
>  
> +static u32 dualpi2_unscale_alpha_beta(u32 param)
> +{
> +	u64 tmp = ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
> +
> +	do_div(tmp, MAX_PROB);
> +	return tmp;
> +}
> +
>  static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
>  {
>  	return ktime_add_ns(ktime_get_ns(), q->pi2_tupdate);
> @@ -223,6 +231,15 @@ static u32 convert_us_to_nsec(u32 us)
>  		return lower_32_bits(ns);
>  }
>  
> +static u32 convert_ns_to_usec(u64 ns)
> +{
> +	do_div(ns, NSEC_PER_USEC);
> +	if (upper_32_bits(ns))
> +		return 0xffffffff;

U32_MAX

> +	else
> +		return lower_32_bits(ns);
> +}
> +
>  static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
>  {
>  	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
> @@ -458,6 +475,76 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
>  	return 0;
>  }
>  
> +static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct nlattr *opts;
> +
> +	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
> +	if (!opts)
> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_MEMORY_LIMIT,
> +			READ_ONCE(q->memory_limit)) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_TARGET,
> +			convert_ns_to_usec(READ_ONCE(q->pi2_target))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
> +			convert_ns_to_usec(READ_ONCE(q->pi2_tupdate))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
> +			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2_alpha))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_BETA,
> +			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2_beta))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH,
> +			READ_ONCE(q->step_in_packets) ?
> +			READ_ONCE(q->step_thresh) :
> +			convert_ns_to_usec(READ_ONCE(q->step_thresh))) ||
> +	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
> +			READ_ONCE(q->min_qlen_step)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
> +		       READ_ONCE(q->coupling_factor)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
> +		       READ_ONCE(q->drop_overload)) ||
> +	    (READ_ONCE(q->step_in_packets) &&
> +	     nla_put_flag(skb, TCA_DUALPI2_STEP_PACKETS)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
> +		       READ_ONCE(q->drop_early)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
> +		       READ_ONCE(q->c_protection_wc)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
> +	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso)))
> +		goto nla_put_failure;
> +
> +	return nla_nest_end(skb, opts);
> +
> +nla_put_failure:
> +	nla_nest_cancel(skb, opts);
> +	return -1;
> +}
> +
> +static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
> +{
> +	struct dualpi2_sched_data *q = qdisc_priv(sch);
> +	struct tc_dualpi2_xstats st = {
> +		.prob			= READ_ONCE(q->pi2_prob),
> +		.packets_in_c		= q->packets_in_c,
> +		.packets_in_l		= q->packets_in_l,
> +		.maxq			= q->maxq,
> +		.ecn_mark		= q->ecn_mark,
> +		.credit			= q->c_protection_credit,
> +		.step_marks		= q->step_marks,
> +		.memory_used		= q->memory_used,
> +		.max_memory_used	= q->max_memory_used,
> +		.memory_limit		= q->memory_limit,
> +	};

I *think* you either need READ_ONCE() annotation for the above lockless
read, or add a  sch_tree_lock(sch)/sch_tree_unlock(sch) pair.

/P


