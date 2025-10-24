Return-Path: <netdev+bounces-232564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E5C069B9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB061C20226
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C7319862;
	Fri, 24 Oct 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfUoF9ra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B522F83C9
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314631; cv=none; b=FaOg+N2ysdtm5UalAIaB0BAk/FTmqYxk+a9rJ/aaUN+0XedlKOFOrHd0DR714/0XLZryKk/apOUFOuuw6X6obhEta8VGED8Kn7/jzWGNP+ELA9wi/HfSm5CHP92Qh39ggvEzbtufMDON1xA3AfAFM4QVmci2U3ZMJu1w66iLums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314631; c=relaxed/simple;
	bh=sMJ1PmkqYrp6vR2wu1Lbm8ZzYUGtsCQD36kz0G6LniA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Rhqs6CA5nivNkVDO8jAcSQNxTef/GWcJF+bQLMRxbAAZWL8kQfFa6xCWYdo1EYkk6W3N51c8PPKlqjCas2X+dE+YEt45sj/fuw20YEqI6Sdn1pc4Hnm+oH3E1fDHf1HoN/dfDwHx+f9x2UzLwH6eXtWIPzzZThoRjcQCE+38+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfUoF9ra; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db3ec75828so337859137.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761314627; x=1761919427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX50h9CSTv1UzJrPKfKwquNCbEH3ys3tWym5NXMYo3s=;
        b=JfUoF9raH3+iUhZWRuAznKWO+1ZvyoaEvk+0sz+l50p0rlyiac6ecfRg4TS06GP3o3
         GMPLHDRURuSZQAMuLxULNHHwHrR2Ywk1H/8yeHJ/seqzGfL1677F0VzJXcgAyEAhUDWB
         0qY4QAkHQ3ax8kxjVK2gv+mo0cdyKELh0dloDParfroFXRx5gdruBkjxsWV4bQZNtN+j
         NON5VGpyQDcROP0idJGk7WqLyu8a3iHlhEg5xDlNXaKwas0xW1qwveclqeTEnP/9f/r1
         ezNB4wBCWu9SvQoJN6Z8yWLnxutxGOhMPL1/SVJzU71v7FGwqujdc81DCkO/z+92uQ7d
         jq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314627; x=1761919427;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mX50h9CSTv1UzJrPKfKwquNCbEH3ys3tWym5NXMYo3s=;
        b=mWfozGAZktWmaubgeSGvS2CTojtsICiCwO2gavG/RWPY7EfTa+3A3JvZV3tE/WpjFT
         7Da/Vh+0nv7O2N+Qe0bMh3HlX0td6+jrTskNsLDUkG0MMVSuAuy3oxdmwKpJiaAWYjxz
         w2mkuwqXwWHNaCptc5CkVauqp13gX6MfQKOeZRuhdhsrnsH12muthoxBmBpXm3olbkdY
         OQksO1C4s6hkXRA5M2mrljWWS6QzuSpx73WZWhtEwnPb5TzfU2LOUc8P2VMedEb08y/F
         T6MG+QFaCSQvJ1+YlzCHcPjaGgfBAoq4/7yeeoT6lb2cVBEJr9OOriBgnS8eydZiMB6d
         cDbA==
X-Forwarded-Encrypted: i=1; AJvYcCX/jL6pzjIIk34/Fze95FWz5Pkzthh3CwhdPHowy/bt26T7qnHGIGP0q07Bm8a7hK3oBuKruVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCjhwnI1xMItBtv5W7o5F+5EXYpAzLvWv92qeZUjn4UKZJ9YE
	ki7izO7CiWvGRU/jmRhw4BOhllAoOe2gb1NHU5JZDFUQEGpUSbeHnmo+
X-Gm-Gg: ASbGncs28RKwWV9tkYH0p8pYqMHxT7jCcJgCHMFzjOwL9GMTU8XD5o1+rAv927ptayg
	ItzEs0MVxmpifLlCYoeW5Fo9reZcBvJzxrnNxJ4eplrqZidPr66Zq2CFlS+3BZuTt9erN3/gpyf
	bKh68RnB9P3N+Fr/w5AP0BF9PNKtuVFoqWCT56HuEQ1zzFXzupnI6hwpy5uwq2w2gfTibfdbTjU
	V4rr4BKdTpRSOOlejtgOjHnOinSr5SSxkzFQVMHJqyIEp3ZJ/PlTIYaavO1dBqVdP3AyUODIo94
	rNfnMc9t94I1wlCIaU8V/mcU5odOrbADk2irZZlopoZ0pIPZxeFnhgLyhQnfP+u/6q6LXVKpt2q
	a+MIdhboC+TXMz538yHfHQZ0r7a1yKdpRza3p21qSqrrk9X29quaM0woP/rUOwYaUPdlXciX6Sv
	nkV4PyQ7emLOLVLDuwrH0MZE2kKtdbH/8CojET/GSCvh0HTrtM34p/
X-Google-Smtp-Source: AGHT+IEx4TZT6fxNhmpkgY0F0jSopvkG1C/Rk2fgoj4MKkxlUaKV3OyZGEaNw5Q7voNNWQPv4R5H3w==
X-Received: by 2002:a05:6102:160e:b0:5db:2301:aa03 with SMTP id ada2fe7eead31-5db2301ac3emr3488133137.34.1761314625784;
        Fri, 24 Oct 2025 07:03:45 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5db2c77bc89sm2116978137.3.2025.10.24.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:03:45 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:03:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.249e3b8331c2c@gmail.com>
In-Reply-To: <20251024090517.3289181-1-edumazet@google.com>
References: <20251024090517.3289181-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: optimize enqueue_to_backlog() for the fast
 path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Add likely() and unlikely() clauses for the common cases:
> 
> Device is running.
> Queue is not full.
> Queue is less than half capacity.
> 
> Add max_backlog parameter to skb_flow_limit() to avoid
> a second READ_ONCE(net_hotdata.max_backlog).
> 
> skb_flow_limit() does not need the backlog_lock protection,
> and can be called before we acquire the lock, for even better
> resistance to attacks.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> ---
>  net/core/dev.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 378c2d010faf251ffd874ebf0cc3dd6968eee447..d32f0b0c03bbd069d3651f5a6b772c8029baf96c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5249,14 +5249,15 @@ void kick_defer_list_purge(unsigned int cpu)
>  int netdev_flow_limit_table_len __read_mostly = (1 << 12);
>  #endif
>  
> -static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
> +static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen,
> +			   int max_backlog)
>  {
>  #ifdef CONFIG_NET_FLOW_LIMIT
> -	struct sd_flow_limit *fl;
> -	struct softnet_data *sd;
>  	unsigned int old_flow, new_flow;
> +	const struct softnet_data *sd;
> +	struct sd_flow_limit *fl;
>  
> -	if (qlen < (READ_ONCE(net_hotdata.max_backlog) >> 1))
> +	if (likely(qlen < (max_backlog >> 1)))
>  		return false;
>  
>  	sd = this_cpu_ptr(&softnet_data);

I assume sd is warm here. Else we could even move skb_flow_limit
behind a static_branch seeing how rarely it is likely used.

> @@ -5301,19 +5302,19 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
>  	u32 tail;
>  
>  	reason = SKB_DROP_REASON_DEV_READY;
> -	if (!netif_running(skb->dev))
> +	if (unlikely(!netif_running(skb->dev)))
>  		goto bad_dev;

Isn't unlikely usually predicted for branches without an else?

And that is ignoring both FDO and actual branch prediction hardware
improving on the simple compiler heuristic.

No immediately concerns. Just want to avoid precedence for others
to sprinkle code with likely/unlikely with abandon. As is sometimes
seen.

>  
> -	reason = SKB_DROP_REASON_CPU_BACKLOG;
>  	sd = &per_cpu(softnet_data, cpu);
>  
>  	qlen = skb_queue_len_lockless(&sd->input_pkt_queue);
>  	max_backlog = READ_ONCE(net_hotdata.max_backlog);
> -	if (unlikely(qlen > max_backlog))
> +	if (unlikely(qlen > max_backlog) ||
> +	    skb_flow_limit(skb, qlen, max_backlog))
>  		goto cpu_backlog_drop;
>  	backlog_lock_irq_save(sd, &flags);
>  	qlen = skb_queue_len(&sd->input_pkt_queue);
> -	if (qlen <= max_backlog && !skb_flow_limit(skb, qlen)) {
> +	if (likely(qlen <= max_backlog)) {
>  		if (!qlen) {
>  			/* Schedule NAPI for backlog device. We can use
>  			 * non atomic operation as we own the queue lock.
> @@ -5334,6 +5335,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
>  	backlog_unlock_irq_restore(sd, &flags);
>  
>  cpu_backlog_drop:
> +	reason = SKB_DROP_REASON_CPU_BACKLOG;
>  	numa_drop_add(&sd->drop_counters, 1);
>  bad_dev:
>  	dev_core_stats_rx_dropped_inc(skb->dev);
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 



