Return-Path: <netdev+bounces-305005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tF3gKgG4S2qkZAEAu9opvQ
	(envelope-from <netdev+bounces-305005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:13:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167F711CD5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:13:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RplYSY6d;
	dkim=pass header.d=redhat.com header.s=google header.b=ntPaucDN;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305005-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305005-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F16F33A09AF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748542CAF7;
	Mon,  6 Jul 2026 12:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138842CAF4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 12:38:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341507; cv=none; b=IpXpr5IkdpymDPBW22AwX3ZAvODvfoG8ij3voRHogf5RQ4EKtVBpRGJBNfJ9UW42s7yVPUcLQwhZ0QSXM7j7t0B+xgub0KMyQPHbiWcB2qTMyismO5BfvDFlYWhAGXr3RFBGiaKno4UlW6NMsJp2WYj7Y+Ld7KgHooG6ughUvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341507; c=relaxed/simple;
	bh=hCPDHhPwY7eBV10/bdUAEaC72nbOOeiIO1RuPkeO/T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8ZaKeK/j+NGBd/j3ceZ4LAWHXrHHxZxqZwEF/ZCaIucVrf7S30mLlvSpXNF9ZXWxSo2sMcKwW93gyKFcs7K0/j36UG+amDzIgJuEekX5oId9JPqILvUgYbenM4/wcjrZKgax9LnKZVSVPIUyfuqfPI3dGkZoz1Ox8mdB6lDbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RplYSY6d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ntPaucDN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783341502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzGosQ0aZkrtstjBVQ1bx1uU/9xoCj7x84hi92ZCHDY=;
	b=RplYSY6dNV77Kl6oxY3PlJF4sibKulpHn67+dLZp++H5JR5686RuKUJXQIkhply0C4RWdT
	ueytJXf+FMTgNCEziNOO1vXIJ9Mwo7BPz2iC4BKub2C+jJs1GGpt2BE2wVAKyBsMu1c84/
	2IDS2W9aDmirDLDRFD+l2TuUaMSK7Uw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-aroMiOPmP2Ck-UaK8aRuDQ-1; Mon, 06 Jul 2026 08:38:20 -0400
X-MC-Unique: aroMiOPmP2Ck-UaK8aRuDQ-1
X-Mimecast-MFC-AGG-ID: aroMiOPmP2Ck-UaK8aRuDQ_1783341499
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so2456194f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783341499; x=1783946299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzGosQ0aZkrtstjBVQ1bx1uU/9xoCj7x84hi92ZCHDY=;
        b=ntPaucDNUozbyo9clfYPmrKGfJuJ0xUBSnhTCk7iJKT6wNnXc7G+bWLNkn6jrozkM3
         m3W5cb3Aa6rF6zIgks/g16OnHuLDlvTi/6YUne+f/6JkpZRjWpyhX6ppgZgiJmewoWhm
         k7vFNFvErhGFhmAPiIYwkARVJN7He3tPBPVa2B9vbP0RUIdaDtO+3EHj+ft9EvWhYRm7
         FFrzxLCjonpNhOH4lhhrMuYZ5QvSGcKfX9qOkhMK3UtWCSaNRUIykrSFS/guIBQfK56p
         Kozn2bnNswDqsWn9Os7UjzyAaAzgN5dop89bhRw30R95RISAaNYNUuu1oMNHHKVL4OB0
         Ki+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341499; x=1783946299;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzGosQ0aZkrtstjBVQ1bx1uU/9xoCj7x84hi92ZCHDY=;
        b=tBtLloct6HwC2RMI/4f3cVyh/k3tQ8GCxj1I5FpmWfcy+1HnzliH8NBJIhsOj2FXHb
         9e3Qo3wBpGHNE+hx89N8sNFzkOy8NzjYDkiR0a+CnPA+xtTJE6pVbQ4wZf5wGKXrF/x2
         IGvLmsSUa2dS8C0qTU0HRVucI4s/PNj70owtN7dI7ct9ZpeCkHIQuvm/6gmpXjKQ0Fy4
         T8VZeDHIsGhAa//3+H25W35dfUzSlscTn8JdBxyPg7ll+buTHzAV1K97yFJEkqAPeIKh
         4hKruxJwVD3Fsg/ze+4bkQm3zGfj4V3S7pFd6lvEdPiqy/qs7tjCPNIX82LRW2jwL2rg
         RUpg==
X-Forwarded-Encrypted: i=1; AHgh+RrfR8vHAWfW7Li3Sn7IHAUKT6OCB/gvmUj/v5vM8vHZIdfJDA7pxIvU41/DuH1Qx1bSebiQoGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIGbsOaA+cn08aTbnaVM0jPrHti0iL9LIfzdqjBLbUBbv8Qpy
	McmwaLHeAmMoxuWjv6vFW92N6vR0AupzyNOhjYR13fjHcrChssp2dYUgHJLqvXrJFWc4CmuqtBy
	Phrb24G5apiGb5pLgxSn/8rrtIyoWuI9OdoEmJL9xljG0vKyIyZQxv5yqRQ==
X-Gm-Gg: AfdE7cmEvlGeQMXz4IOBuGfMIRdGF3LtAVR0ycU3hJTld+bIRANpEskkegwT/5jjM6q
	51sBHSaFP1yVhCYX/x6WtcDqty1gctTeJ6PqL20d7ZQKriQ+AEHSAeIHanuWWEq0xBaa8ubzBiY
	0EBwNWWzeyyw0sM6jwRUEFU5HJDT5x2ZhJ/FpYUWh8XCR4gfKCpmijjudgFmXaGS3ii6gc5gBjE
	UWNfKgDbEq9IfcmSrnKEpi2p2uJGoP7qXM2743ezLXxZ1Rbc7nc5tYc/upyx08X8IB4hx5GvWoT
	PuNr4690suchYkMmiLzqOaQNu6vXj5cq8F7Os0jKYOjsf3cwJHWZiy0/crhy8TVIxnnS1bmTIGD
	i/BqZp08q2yVTE4s+Bl2KlTXQG+obMACc1rBw7wV9yMUesyeeDaaJBUkdZ/f5knHDmaq9CBTUTz
	O9pZjpRWXvTZC2
X-Received: by 2002:adf:f5c5:0:b0:475:f0d1:eb5a with SMTP id ffacd0b85a97d-47aace8f2b8mr9066930f8f.53.1783341499107;
        Mon, 06 Jul 2026 05:38:19 -0700 (PDT)
X-Received: by 2002:adf:f5c5:0:b0:475:f0d1:eb5a with SMTP id ffacd0b85a97d-47aace8f2b8mr9066898f8f.53.1783341498673;
        Mon, 06 Jul 2026 05:38:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm23738499f8f.14.2026.07.06.05.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:38:18 -0700 (PDT)
Message-ID: <0926f373-4e0b-494f-8364-51bb14feaf20@redhat.com>
Date: Mon, 6 Jul 2026 14:38:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/sched: sch_fq_pie: add per-flow
 statistics via class ops
To: "Hemendra M. Naik" <hemendranaik@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, jiri@resnulli.us, jhs@mojatatu.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 vishy0777@gmail.com, tahiliani@nitk.edu.in
References: <20260630183702.170798-1-hemendranaik@gmail.com>
 <20260630183702.170798-2-hemendranaik@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630183702.170798-2-hemendranaik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:hemendranaik@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0167F711CD5

On 6/30/26 8:37 PM, Hemendra M. Naik wrote:
> diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
> index 72f48fa4010b..60e85c002ae7 100644
> --- a/net/sched/sch_fq_pie.c
> +++ b/net/sched/sch_fq_pie.c
> @@ -330,7 +330,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
>  	/* tupdate is in jiffies */
>  	if (tb[TCA_FQ_PIE_TUPDATE])
>  		WRITE_ONCE(q->p_params.tupdate,
> -			usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE])));
> +			   usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE])));

Minor nit, only if a repost is needed for other reasons: unrelated
formatting changes should go in a separate patch.

> @@ -517,10 +519,10 @@ static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
>  	st.packets_in	= q->stats.packets_in;
>  	st.overlimit	= q->stats.overlimit;
>  	st.overmemory	= q->overmemory;
> -	st.dropped	= q->stats.dropped;
> -	st.ecn_mark	= q->stats.ecn_mark;
> -	st.new_flow_count = q->new_flow_count;
> -	st.memory_usage   = q->memory_usage;
> +	st.dropped		= q->stats.dropped;
> +	st.ecn_mark		= q->stats.ecn_mark;
> +	st.new_flow_count	= q->new_flow_count;
> +	st.memory_usage	= q->memory_usage;

Same here.

@Jamal: the patch LGTM, and I think that the alignment concern raised by
sashiko is not relevant:

https://sashiko.dev/#/patchset/20260630183702.170798-1-hemendranaik%40gmail.com

as user-space already has to deal with 64-bit aligned fields in tc stats.

WDYT?

Thanks,

Paolo


