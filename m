Return-Path: <netdev+bounces-37377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01D7B51AF
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D18A6283E92
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E251428F;
	Mon,  2 Oct 2023 11:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E007111A5
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:47:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4CD3
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696247264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1QLTTuLPRBNsMkNHYVj+2VxFvxVzYGvYd05kFIjRh8=;
	b=OcgXA57TQSBbpB2WCloHxnVyp5xkc4I3tvAvFD9b61lF8L5Yksqxab0XrIC/SyxotApKRQ
	NcORjQa1YAgMgr2SB6swq/VK1YuI0e7Vmw0mB+B0BGxFntqfqIK1JhE3d5wE5Hpa2Fm0oW
	K6v8pgjU0K4ZpT/0tPTPH0iU6kH54Uk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-opyZoZ59OHauqDbGGNPyxg-1; Mon, 02 Oct 2023 07:47:33 -0400
X-MC-Unique: opyZoZ59OHauqDbGGNPyxg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae0601d689so1381273266b.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 04:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247252; x=1696852052;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1QLTTuLPRBNsMkNHYVj+2VxFvxVzYGvYd05kFIjRh8=;
        b=JJaihzbbCt0/a8oq7b9ESiliTYxBY08w2DSwUfdFybEhA7pwd8noHUa6WK9eh9HtZh
         TCp+NkhpSLPo+f98JoazRwOwlhg+Nc1qWpnTRVJHfm+mu/LlmCVTAgOWS4VJ6pQ2PT79
         nIj1fUxEbK0pp86l6LEdrX8DCOwWCD/7a1WkN6C38PtNrArCGdSeIx3Aq+G0RKwClo9j
         pMFi1UDm9Js+DPmf7OXPAjtFHn5OhjZsVCK/jxA03/o6mMHHJn2cU+jKanljD9pCisl8
         qIlu6DxASGegptBiypIyFiAA/X8uSsbbWsf6fPTc5MYn50ORskxpXsWtzwTBGseHfzNO
         4WXA==
X-Gm-Message-State: AOJu0YyVE/Sj5Xy1NoudLujSpldiv8/uMo9zT9l12Kg6Sj+a5z5kQB0p
	HOjnjROg8vgLowymRL4Tw95M3GMeUYZqVFQ8rExtQXcKUr3JO01mjQqYhyE0npvK/2fhP7dEIm2
	xxmKj1LGLw29QPpZM
X-Received: by 2002:a17:906:2189:b0:9ae:5523:3f8e with SMTP id 9-20020a170906218900b009ae55233f8emr10609971eju.63.1696247252578;
        Mon, 02 Oct 2023 04:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpCQIjDihAqRtkx9d2ZJ/nW/mGWeQ2d7Lu0AN5AWKrzT+9O7jAMUlm0y+t3AZ1QglAYelHEw==
X-Received: by 2002:a17:906:2189:b0:9ae:5523:3f8e with SMTP id 9-20020a170906218900b009ae55233f8emr10609954eju.63.1696247252267;
        Mon, 02 Oct 2023 04:47:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090614c400b00992b510089asm16839424ejc.84.2023.10.02.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:47:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 44DADE573D9; Mon,  2 Oct 2023 13:47:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh
 <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 4/4] net_sched: sch_fq: add TCA_FQ_WEIGHTS
 attribute
In-Reply-To: <20231001145102.733450-5-edumazet@google.com>
References: <20231001145102.733450-1-edumazet@google.com>
 <20231001145102.733450-5-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 02 Oct 2023 13:47:31 +0200
Message-ID: <87bkdhgsa4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> writes:

> This attribute can be used to tune the per band weight
> and report them in "tc qdisc show" output:
>
> qdisc fq 802f: parent 1:9 limit 100000p flow_limit 500p buckets 1024 orphan_mask 1023
>  quantum 8364b initial_quantum 41820b low_rate_threshold 550Kbit
>  refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
>  bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 65536
>  Sent 236460814 bytes 792991 pkt (dropped 0, overlimits 0 requeues 0)
>  rate 25816bit 10pps backlog 0b 0p requeues 0
>   flows 4 (inactive 4 throttled 0)
>   gc 0 throttled 19 latency 17.6us fastpath 773882
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/uapi/linux/pkt_sched.h |  3 +++
>  net/sched/sch_fq.c             | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index ec5ab44d41a2493130670870dc9e68c71187740f..f762a10bfb78ed896d8a5b936045a956d97b3831 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -943,12 +943,15 @@ enum {
>  
>  	TCA_FQ_PRIOMAP,		/* prio2band */
>  
> +	TCA_FQ_WEIGHTS,		/* Weights for each band */
> +
>  	__TCA_FQ_MAX
>  };
>  
>  #define TCA_FQ_MAX	(__TCA_FQ_MAX - 1)
>  
>  #define FQ_BANDS 3
> +#define FQ_MIN_WEIGHT 16384
>  
>  struct tc_fq_qd_stats {
>  	__u64	gc_flows;
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 1bae145750a66f769bd30f1db09203f725801249..1a411fe36c79a86635f319c230a045d653571700 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -919,6 +919,10 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
>  			.type = NLA_BINARY,
>  			.len = sizeof(struct tc_prio_qopt),
>  		},
> +	[TCA_FQ_WEIGHTS]		= {
> +			.type = NLA_BINARY,
> +			.len = FQ_BANDS * sizeof(s32),
> +		},
>  };
>  
>  /* compress a u8 array with all elems <= 3 to an array of 2-bit fields */
> @@ -941,6 +945,24 @@ static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
>  		out[i] = fq_prio2band(in, i);
>  }
>  
> +static int fq_load_weights(struct fq_sched_data *q,
> +			   const struct nlattr *attr,
> +			   struct netlink_ext_ack *extack)
> +{
> +	s32 *weights = nla_data(attr);
> +	int i;
> +
> +	for (i = 0; i < FQ_BANDS; i++) {
> +		if (weights[i] < FQ_MIN_WEIGHT) {
> +			NL_SET_ERR_MSG_MOD(extack, "Incorrect weight");

As in the previous patch, can we be a bit more specific here? "Weight %d
less that minimum allowed %d"?

-Toke


