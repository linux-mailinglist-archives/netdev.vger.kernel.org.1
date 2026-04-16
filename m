Return-Path: <netdev+bounces-279058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOMoNQ7l4GlhnAAAu9opvQ
	(envelope-from <netdev+bounces-279058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D604040EDDA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F140302B727
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954CA3A6B9E;
	Thu, 16 Apr 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOeiFbrU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKrWW7SJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC923932E7
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345946; cv=none; b=h+HlipaH9XWaCkToNHxTDKGWku0DHwuLSWt3ZiT1ypbknawIfa8lM6JIwj6B8p29S2mCavHblzytwxY37tF0rySntJU4mN1KuNwzXcvtTeDK9P0d4+aFVRSSVTn8oObdkLsCAkiPYkoj2YG+7bZxpwdaVkAraM+L93BvesrUa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345946; c=relaxed/simple;
	bh=Ks9Lh9sXM3NHLG5RlrbfioY0KnQFqSIq3pvt4kyDJFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CQlLuSBpqQjAUBW8NbBmAvZeaY4pyvYluQmltUv50FH233gNEZ9kPQh4EbQq2UG+3ji+K5L7THcHHFON211jiAvpVBKEj0iQmF7VsSPNH/wZmxN2O5llq4drqvnauKJu3B0G+19fP+IlRxzsWlsfaj6nZyAFQjQW8eXOTS5HdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOeiFbrU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKrWW7SJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776345944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXZK7Wy94J2sz6DnNYsgQgumJpWskcv2kpLOs6mdi4E=;
	b=LOeiFbrUEyHdRUb0XxW6ebIifgb8CZ3gI4BlI/HVdn013UO3BgNQ2LTFl4SvA6ws7Fl2kn
	4IHfbsRwxz31tN2zE5tamM/ideQ04QLghiMrk4iC6Vd/1BeDjCAR+d1MXc7Vhc4cFR1gnX
	2S0jelQXo+QCznVoCU5V1V+15FqfRQQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-L8r2HtOFOUSF4Yoankw3pg-1; Thu, 16 Apr 2026 09:25:42 -0400
X-MC-Unique: L8r2HtOFOUSF4Yoankw3pg-1
X-Mimecast-MFC-AGG-ID: L8r2HtOFOUSF4Yoankw3pg_1776345941
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d780757eeso410162f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776345941; x=1776950741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wXZK7Wy94J2sz6DnNYsgQgumJpWskcv2kpLOs6mdi4E=;
        b=bKrWW7SJCBpGFPaqynvJJAAq1c9xi7wJEZTNdRpwfBRLO1lZIWArKqq7pyQYq3Ismh
         VW0zhu+xTyWBrt9QTH6dXVRGtQUz0cD+UWaZqGYb9embXkQeKbqPKDPByt5OS7gBNtdp
         0Fe5OacbMOlBkyxjIjZMmnbbSA3ZxoRNeP0ya4Uj80gwphrQQ1O95QoBd7NLyH6xiaxj
         bHMne5F6P03albtZcREyJbQw1BzCiI+A6OOzo0HrIjjKKld5fVKoq5spF4i91snrxko6
         WUMZdUSQXWqRwnEr1zRYjXrStl3d3qUKzHOHwXQ5XzCL9QhSUhFP3euowvkSeNOCwNC3
         WNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345941; x=1776950741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXZK7Wy94J2sz6DnNYsgQgumJpWskcv2kpLOs6mdi4E=;
        b=la+kqYYWbGvbQhRecernFU1Q+t7Z1JtBLQTsqhumgraGGctXe3+N30hUdZaFIGuqTe
         zSfTx4icpE2z8bLMWLvxkXfJwWHbFXYF2yI4fNHYuZgZ8b3Pl3Y03Bb18MuPLxRQzmSA
         Z28TSGgyiwP3m6u53fhRnaiwgQRXrFedqdwwGrTIeJrGA8KP25rL8Ilxi4xb9cWTYDj6
         Apt14XCppMPO/NFl27wlVDGPXflqSBQ4Ma1penQMINaOFntFr251aBpIyTiY4GF89yGa
         pAhSeltkGzst3l5/dBmCKqAwd+uUwa989/RXuLvUuF1GLXDNxJUzO3KompnlUeyWxCP1
         0AEA==
X-Forwarded-Encrypted: i=1; AFNElJ8pUp0SQ1sxhMlWVnhhPt0AKxjX5vam2o8h2tjDdeP/TsLO6afY3V+wjx2Bz2/X8+vDPJkklmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4F3nUM1BO9BKWnoyTutMLLHZs5h7eqq7BjC8JILNiASrMwQv
	GLVQ+KrYcvZedm+NeCTzLulhHFK1qXrhOB2iYduAYdpPNI8If+CR8zgWRoZsglQHtJk0wOupYkz
	j7d7YpS5F3V7PuZWyoj75v6c1jOtOaSk0yIn7gE7Mt/nTqlWoJ1KJtA42t1GDxuJLbQ==
X-Gm-Gg: AeBDievl7PkpdI0qjGDQHtPsciZrEF4eEhcmvuT4WqXFbS+0LWsKuXSuY0CyuuD/BWf
	WDmnTLglmGdcmODEhu/cDjZyZc8FyxwZTUQq99uC4oWFxTDGbrWosDUcthM8JQdRGz1/Dl6o/6x
	VWsmtfag4JWnI2YC1DKdKiKRzpDYIxeXV2kVgdUwg0AfqBiI6KRkr3MKPxdyGHvq3KqEV8C2M19
	zyWLsc6dpqmQJQLbblj7RWpkGvnvHjnpbA9qbo/4D2aQIfckhhJw5JCLBlcdB1o8dWJqAg1IvOn
	3T1P1qMvQyb8V8WiDQm/xUxJY34LUkzt1QGjgF8Qo3JkMOfPPiH41Fhayh3oXEf2sB3a777wCO1
	xbJuHLBB+NMLAvHiFDIm7mQL7Fd3EgaaedidW3rvyCVdEs/4mhg/6Cy62RgSlyocSBWc=
X-Received: by 2002:a05:6000:1889:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-43fdbb4cd6emr3233679f8f.17.1776345940524;
        Thu, 16 Apr 2026 06:25:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:43d:2d34:8963 with SMTP id ffacd0b85a97d-43fdbb4cd6emr3233578f8f.17.1776345939959;
        Thu, 16 Apr 2026 06:25:39 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fd6sm14487794f8f.24.2026.04.16.06.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:25:39 -0700 (PDT)
Message-ID: <9ff2df3e-08cf-4f61-8a58-cac0a6980b2d@redhat.com>
Date: Thu, 16 Apr 2026 15:25:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
To: chia-yu.chang@nokia-bell-labs.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-279058-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,vger.kernel.org,kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D604040EDDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 6:37 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Fix dualpi2_change() to correctly enforce updated limit and memlimit values
> after a configuration change of the dualpi2 qdisc.
> 
> Before this patch, dualpi2_change() always attempted to dequeue packets via
> the root qdisc (C-queue) when reducing backlog or memory usage, and
> unconditionally assumed that a valid skb will be returned. When traffic
> classification results in packets being queued in the L-queue while the
> C-queue is empty, this leads to a NULL skb dereference during limit or
> memlimit enforcement.
> 
> This is fixed by first dequeuing from the C-queue path if it is non-empty.
> Once the C-queue is empty, packets are dequeued directly from the L-queue.
> Return values from qdisc_dequeue_internal() are checked for both queues. When
> dequeuing from the L-queue, the parent qdisc qlen and backlog counters are
> updated explicitly to keep overall qdisc statistics consistent.
> 
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/sched/sch_dualpi2.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index 6d7e6389758d..56d4422970b6 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -872,11 +872,25 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
>  	old_backlog = sch->qstats.backlog;
>  	while (qdisc_qlen(sch) > sch->limit ||
>  	       q->memory_used > q->memory_limit) {
> -		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
> -
> -		q->memory_used -= skb->truesize;
> -		qdisc_qstats_backlog_dec(sch, skb);
> -		rtnl_qdisc_drop(skb, sch);
> +		int c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
> +		struct sk_buff *skb = NULL;
> +
> +		if (c_len) {
> +			skb = qdisc_dequeue_internal(sch, true);
> +			if (!skb)
> +				break;
> +			q->memory_used -= skb->truesize;
> +			rtnl_qdisc_drop(skb, sch);
> +		} else if (qdisc_qlen(q->l_queue)) {
> +			skb = qdisc_dequeue_internal(q->l_queue, true);
> +			if (!skb)
> +				break;
> +			q->memory_used -= skb->truesize;
> +			rtnl_qdisc_drop(skb, q->l_queue);
> +			/* Keep the overall qdisc stats consistent */
> +			--sch->q.qlen;
> +			qdisc_qstats_backlog_dec(sch, skb);

Sashiko says:
---
The drop counter is incremented for the L-queue via rtnl_qdisc_drop(),
but it appears the drop counter for the parent qdisc (sch) is not updated.
Will this cause user-facing statistics for the overall dualpi2 qdisc to
underreport drops?
---


