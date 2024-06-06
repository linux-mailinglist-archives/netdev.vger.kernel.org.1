Return-Path: <netdev+bounces-101351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 049178FE3B2
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C90281C37
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86C1850AC;
	Thu,  6 Jun 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvZuN0kt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AD4D108
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668076; cv=none; b=A3WcMyyDw7N6LKGhC6Z49vMeVFhEcOZTO9pkiujwhJZ8Av3HRRhnSkVtbLGkkfO8+gV+Mh7/2kKY/OWvwWIXvaz2UuM8RO7rN6FJ0TevCzDIu1b2pStuAie+NuyYZK1Tp79JJJtiJR9FZSJOYqiuu3wo2+KD17lfGmjoIq5ZXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668076; c=relaxed/simple;
	bh=qhtj98DulXupXFPLE2+v6wDfWsted4J2rirbP066f1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IRntxlJw6F7eR87q92tGmBVkvlabcAuCt50XWKnE1EufiF0qmn0Yzgkdh6UxycBm+LbfrHZKWv5jCUdTo7rQwP71GncxiZg9/wPn8yBkAL8o/O8aqguoB+6TJ/0AiiCcD0DloyNZx1TfJTFcY1A8fgZpBE/iGEExvThY0aLs7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvZuN0kt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717668074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsH3tNOIuODIUEamDiRQYHxksj2DiTRgjnBF+09PrHc=;
	b=WvZuN0kt0wJDJqQIYlJASiaAvYVb1AN6oBybJ+d/FZPaWQGivf91QKnAnxiCrIoKojEZlL
	pkVy6Hor87WETQc92QVx0jwz01yMIDM+WwTwMvEWB5xz1AnkhVEj3Q0KgP0W+I947HCuns
	P1O499tEYGRf50dXJYF89Ce7veHkPBM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-lYm3LTRfPv2GfOaiw_5acQ-1; Thu, 06 Jun 2024 06:01:12 -0400
X-MC-Unique: lYm3LTRfPv2GfOaiw_5acQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421292df2adso6392235e9.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 03:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668072; x=1718272872;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsH3tNOIuODIUEamDiRQYHxksj2DiTRgjnBF+09PrHc=;
        b=SF8151V45A1jfbCs9lGrODBVe9nTX97a+eOWCRvMlqfdSko2dvY65VJuXufcO/5dpA
         EY29QshwCtA+jn9uK3a50WmJzxtw5bZaTC65HHD0qqV2ck9U5G2dWsnJqZiqtjrKD283
         mj5nKgzWJa8eUe8d6ym5042vsy5Cnh6NCXOkHOswm/EFMikoZEW6xbUnljIJx2/E2hxd
         JSdHFeQqYBTI43y1lfdpEK7R5ZFR26nmkyF6MAX165Y2WwPFlG7iJ3H8h6AGaHxQuyNV
         L71xV11DrUqH7mMwcn2vjkfUKRDjjAMespG0YzBF3sJ9+5EmpDUOMghDSmJHEpPhxmKp
         8xIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5YG+IPhNdJyl56aqPfqzI9ijX42PqrvaCQRN5hkS7fv8BQ+vuNEkNUVo+OlHE4KILJjoASTXLFqESV51VHSyjCsPm4ib2
X-Gm-Message-State: AOJu0YzgcPb9TyR7oUvV9w0+LkMjzfkjFuXvxZSP4VRzJPgzYBUoGyOb
	+D9l8Ln619zfaZyrwidTuv+YiSnkoY9RGquc2povWEf+QCUIzA5pTPxSIHEBaO2CN+55rTqYkfa
	rwGGeexFjAqeSUEILceQoNwnXMflN7/Aggnn0LVD1NW/iuU9/vYYcBA==
X-Received: by 2002:a05:600c:5492:b0:418:fe93:22d0 with SMTP id 5b1f17b1804b1-421562cf4dcmr44816735e9.11.1717668071845;
        Thu, 06 Jun 2024 03:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHTq6cYuI3qPuB0P8B6+hoDbLnxrDPv6zjkWxnhv1PU5ZTIRPzjHWfw2oBhGIaDyxYBvTVMg==
X-Received: by 2002:a05:600c:5492:b0:418:fe93:22d0 with SMTP id 5b1f17b1804b1-421562cf4dcmr44816535e9.11.1717668071499;
        Thu, 06 Jun 2024 03:01:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d6970asm1113858f8f.54.2024.06.06.03.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:01:10 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, tglozar@redhat.com, bigeasy@linutronix.de, Florian
 Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next v7 1/3] net: tcp/dccp: prepare for tw_timer
 un-pinning
In-Reply-To: <20240604140903.31939-2-fw@strlen.de>
References: <20240604140903.31939-1-fw@strlen.de>
 <20240604140903.31939-2-fw@strlen.de>
Date: Thu, 06 Jun 2024 12:01:09 +0200
Message-ID: <xhsmhwmn2e6fu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/06/24 16:08, Florian Westphal wrote:
> @@ -217,7 +228,34 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
>   */
>  void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
>  {
> -	if (del_timer_sync(&tw->tw_timer))
> +	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
> +	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
> +
> +	/* inet_twsk_purge() walks over all sockets, including tw ones,
> +	 * and removes them via inet_twsk_deschedule_put() after a
> +	 * refcount_inc_not_zero().
> +	 *
> +	 * inet_twsk_hashdance_schedule() must (re)init the refcount before
> +	 * arming the timer, i.e. inet_twsk_purge can obtain a reference to
> +	 * a twsk that did not yet schedule the timer.
> +	 *
> +	 * The ehash lock synchronizes these two:
> +	 * After acquiring the lock, the timer is always scheduled (else
> +	 * timer_shutdown returns false), because hashdance_schedule releases
> +	 * the ehash lock only after completing the timer initialization.
> +	 *
> +	 * Without grabbing the ehash lock, we get:
> +	 * 1) cpu x sets twsk refcount to 3
> +	 * 2) cpu y bumps refcount to 4
> +	 * 3) cpu y calls inet_twsk_deschedule_put() and shuts timer down
> +	 * 4) cpu x tries to start timer, but mod_timer is a noop post-shutdown
> +	 * -> timer refcount is never decremented.
> +	 */
> +	spin_lock(lock);
> +	/*  Makes sure hashdance_schedule() has completed */
> +	spin_unlock(lock);

Ah, this is clever! Thanks a ton for finding a way to get this to work!


