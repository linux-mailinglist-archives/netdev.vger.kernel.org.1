Return-Path: <netdev+bounces-258220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPZBOIM/jGlyjwAAu9opvQ
	(envelope-from <netdev+bounces-258220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:36:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 444F91224BC
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A8D3014C30
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCA34FF77;
	Wed, 11 Feb 2026 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO5lrx70";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sifV4Du8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073C34EEE8
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798977; cv=none; b=hSVZNfP0yACgWZS/CPfvVJa8wQO74HPasjHXCTDNA2Sib4ANW36fn0h6DsHuUqY0k0DXFeZc8V1xgtZv/zngVpaYkq0ZRe3JfoOXrngfLzLmG+arffZIORtStK/Dl59ZuDdRxZzLTmVx6hOirnScJ0Xdv6iSauMispNKrcGxucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798977; c=relaxed/simple;
	bh=Fgvn9NdUJ0UaqEQPHTgceBx/VxXDZhrgOmsYdU2E9zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcMGh/b5Owe34qZzN+nwJTTdhX3glVfkXNdJpZV8qmx3TzSbKYfwGnavGjNnwDmievPy7rhkKoh5Tof3H72Eyc8GF+toOb8jwMnHJglr3Rek4yVMe/ENDCbTxQIR3qGuDyValWkx3HJnl/AUxvJpnbOyFQ9BQsNrS1Y9WmJDGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fO5lrx70; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sifV4Du8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4UPaFgD/UBEaEuWdchd9bGdGxA6y7+fT4fa1mU+DAk=;
	b=fO5lrx70ZsY+wgKimFe7weI1TzC7qfic8aFO6MktVzkYkpnyZV5l5VeaSU022TaFYdhsmc
	z1sZWmBXmiXZThf0crrfx7Lyf/ObKZRNsN/7R8uL+wcFanmhp1eWfr51HGGbJqT9G1LioE
	kwOG6Ve+2++9NrzDXlqwto3KOtEW/Hs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-TvpbuTNmNu2T9YShtO0Mzg-1; Wed, 11 Feb 2026 03:36:13 -0500
X-MC-Unique: TvpbuTNmNu2T9YShtO0Mzg-1
X-Mimecast-MFC-AGG-ID: TvpbuTNmNu2T9YShtO0Mzg_1770798972
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso3204770f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770798972; x=1771403772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4UPaFgD/UBEaEuWdchd9bGdGxA6y7+fT4fa1mU+DAk=;
        b=sifV4Du8xBCRmYhx6TEnLbgIHaOAiXa6wRjFgvsWeNsIKwlM+BcFtCUM/Js90pDVil
         vuqlJxanZeIUsDAmy2U1J5goHSVqpEWJa3Uux88h1v1kst8wi70L/5te7raKFsbyw9m3
         jyvg6QM0Luik+LUlkfFe1x1Gh9NVY+3BV72hoPze0ABrxEcYQmu9eR3uAEXYA+9rrEKm
         v+RQYBlYFeJ+0e4tG/BvcrQkLgxCvdq+8ciV4GnoJXgXuxKrdXunAeoWmq0qMb0r1UaS
         uCvsHMmVsLO/IprzrDeOtmsMzWlxiEJVaLH59S4ghjQKZvCWptfgUzpqi1azXWTda+hO
         2ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798972; x=1771403772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4UPaFgD/UBEaEuWdchd9bGdGxA6y7+fT4fa1mU+DAk=;
        b=LJgGU1T5fXmFfeIYojeLV7mk21FdlCkzbgu9gmJw3KzGDKAK5mguqmyeU+fmfSwTNp
         gJfxVCwaq20uq3fZN3h9YbCWW0+2mLZr7THg6LaUzKacSm+bNGgM/Tn8RKoDThbVEDzZ
         oKyzrKT0iXnJsLc656Qac3rPaRIvwyhc1wKemHOgTzIacac2rp1CexjRu6UuOSEJWFQP
         /Pe/u1LtGEaVYSvhnrpLWmeDVgIcUdH3kgdMiJl9L0OXmAH488cPWNx/ske6IJG1efRt
         +xgJHzf1Ri3w022EfU40yw08vUbjycvSyeCkVqtLDrOPavFWNUTNWf+eHYbZ9mJXPu5m
         Nc1w==
X-Forwarded-Encrypted: i=1; AJvYcCXAeYr+2IHNf8Ug54RNI0KI++7t8m9BPu8mxuU8P/OisJ9rqorC6wOp1u4UV+0MLWIkDqHhKpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrROVNCEWv1QIBlAqJyzlVlDJ9lBoDFxKgpW+ECC2nlcZp0sTm
	7+cjiS4qoZyLSNKodsCBM8xSo/izz2caHZbogqIO5jIlS5lrXzqQ0ZDLWiQn1j46XzvtDSWA7TO
	sdz/eWpQlsf3/pfCYafrM4AmvweKaI+NM/czC2ALie3KUSpQUBSjEXm0+hvBnEuJU3A==
X-Gm-Gg: AZuq6aL7UWmg6yRYLeeJ08xioyT0FbllwkcyiwnDNn+PmFG3CjynstbmXy0MtGsgoxW
	UEq1amS130TxLqnIJSlVU5cbxYVq412QLN5hUhPm6Onu+OotKTSilCR4h0cKHWEPMn4p3PRfIJL
	RMwZK9qRRRf2g/fYSLiJkoP4aDI6B+ojs8v5drbVBKlHjw0rWzxnmjv28/h74mowYzUebRkE2Rj
	9NzFcVYuB0DX9ffbSq6ZpWdbpmAy4LHUsmkKAZ213jwNPFOug2ZKLx00opCGO2TG4Mee+ia3auz
	CecizbkZU4RRWZAplhEJjvBRy5H0+oNlm12NLIeUUbghwWYI9qMhoswXJYHNDHcUnLwuti71J+L
	6eXb1fOK2m826fWJValCVEacayw==
X-Received: by 2002:a05:6000:220d:b0:435:9e32:2b78 with SMTP id ffacd0b85a97d-43782b1b383mr2152002f8f.1.1770798972233;
        Wed, 11 Feb 2026 00:36:12 -0800 (PST)
X-Received: by 2002:a05:6000:220d:b0:435:9e32:2b78 with SMTP id ffacd0b85a97d-43782b1b383mr2151970f8f.1.1770798971748;
        Wed, 11 Feb 2026 00:36:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d48954sm2895544f8f.12.2026.02.11.00.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:36:11 -0800 (PST)
Message-ID: <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
Date: Wed, 11 Feb 2026 09:36:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258220-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,toke.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 444F91224BC
X-Rspamd-Action: no action

On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index fd56b7d88301..a2d1b292600d 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -548,7 +548,7 @@ static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
>  	if (next_due && vars->dropping) {
>  		/* Use ECN mark if possible, otherwise drop */
>  		if (!(vars->ecn_marked = INET_ECN_set_ce(skb)))
> -			reason = SKB_DROP_REASON_QDISC_CONGESTED;
> +			reason = QDISC_DROP_CONGESTED;

FTR I think an explicit cast here should be better than changing the
cobalt_should_drop() return type.

> @@ -593,7 +591,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
>  	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
>  		if (!q->drop_early && must_drop(sch, q, skb)) {
>  			drop_and_retry(q, skb, sch,
> -				       SKB_DROP_REASON_QDISC_CONGESTED);
> +				       QDISC_DROP_CONGESTED);

An explicit cast is needed above to avoid compiler warning (or you can
change drop_and_retry() signature).

Also a few lines below there is another drop_and_retry() calls that is
not converted.

> @@ -37,6 +37,31 @@
>  const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
>  EXPORT_SYMBOL(default_qdisc_ops);
>  
> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
> +			struct netdev_queue *txq, struct net_device *dev)
> +{
> +	while (unlikely(skb)) {

AFAICS tcf_kfree_skb_list() is invoked in the fastpath even when skb is
likely NULL. I guess it would be better to split it an inline helper and
an exported symbol:

// in sch_generic.h
static inline void
tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
		   struct netdev_queue *txq, struct net_device *dev)
{
	if (unlikely(skb))
		__tcf_kfree_skb_list(skb, q, txq, dev);
}

// in sch_generic.c
void __tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
		   struct netdev_queue *txq, struct net_device *dev)
{
	while (skb) {
		//...

Hopefully the above should fit the recent compiler oriented optimization
done by Eric.

/P


