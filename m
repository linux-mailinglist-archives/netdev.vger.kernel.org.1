Return-Path: <netdev+bounces-198539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E2ADC9A0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B5D188CE0F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38562DF3F0;
	Tue, 17 Jun 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MRmYZ6YK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F3D2DF3CF
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160389; cv=none; b=ls+ek8NWXGJGEzjHaiVcRkrARLAHnxXAsBOYfXs5m7RtuPp7uOTDxwR8guPBVUKYEtQ2WmhIQUUR50VgxgwrqKcBIri9iLDhFmEgo+FrH/CsTSfKNQm1YCJ4cv5HUQE9tOQ1D0QANVMAM/uXc1A5ksDJdpcw0bwiPFxAwfpbrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160389; c=relaxed/simple;
	bh=uBYkXCuQ9GPuR838kEKZEznJMLtfKtXvjt/ijlersb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVu+9APgfGFji/iBjSOev94XAs3IkmWG/BrR9dqK1OgbYQcspwBH4vlLJHI9VRMZH64ttw1muPq75dZQvxEreVcxuVNwO2X5ZsKyqdHXNCO++m6igmsFLgvkrcl8x0v6JNhzWP0IEUBgSuereCBiO0VmdMS3bQgAj1WLDaaeZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MRmYZ6YK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a52878d37aso1051356f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750160385; x=1750765185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DxsziclowNGPfRWwm7RNdYqFFkdoOFIz/PY09f+zkA=;
        b=MRmYZ6YKg5X0DsT+indsu8E85O0pQ8S3rfM52ob2Q2qPdkjHtcEWE9slYfXxvM9OXz
         G+yn8OMqEmdqxva/bC7UsIOLV+oDfUl8J8nxYfGQB0HESMuoRQH33+HSql6zSCKzWhxo
         Ov7E/vjLxCSKEt8lqRrxwGABUc/kG7b73bLw56+3gNvQPyBrZB+kTpAhraDWR4YKaaIM
         zQKsb1G3T94yLxTxBp3rQ0pFa06pZfaqPeHecm4lBOrMdkx5CFClhbpn3olGnwMbQAuo
         QAC4J5i4hky6D4eHSLHx98gNU5+7tlUmznMcgSt9Qe4l92bEp2pjXS1jI7s59gat3oaV
         ADYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750160385; x=1750765185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DxsziclowNGPfRWwm7RNdYqFFkdoOFIz/PY09f+zkA=;
        b=U0e39sdjJbk1N8S/sx7MHgWJRvIGvll6b/SQ3rM6YgRkOy5VeviySkEACZxo3C8WV4
         bDTSbZeN+oZrq5km9Hl4xC7NV1pSR2QUPdHbhSzSU93/VxIxA5tMwLY6Ro3jup6fzQMA
         Ct8k7odNZonwYiwh1tN/LUFN+rIrVSZssOEodZ50OMo5KPyt0U+lgEzzYtIjfHfTl84Y
         ktCRivVUNXi0ZXhr3nqZQZs6kg99VWVUYUWNx4cCKnF7SIYbPeAT0E92TEHpmkKSmUSr
         TyT0Bm4UeZZ36ju6a3hEpS4dXz1k//JO5idRSTQre2mxALqTrAUWqodccQirKL54+V/f
         b/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUViwf/atb317bHrUpoh+y5YsSbruEp0gFtHsDhz1QwyJe/47AgXiR5UJwu0vyxVFkUCEuyZ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTeWrQRy2p01iPSYAgjFjR+lMuZLHkUTCeUpR7HeeGbthX2Hp
	tWGSWSem8KFqaO5DV4voRHEi9ctHWOOmZKqJLGHYP7wXmS8sPyGTsCkDk2T9JZ+VGCE=
X-Gm-Gg: ASbGncsXoNwcjr1siT1grDNKbG77zHsBOWVtfIlreTX2ocWxI1aUtvnhOu8zSYZk2zA
	AhhQUWvUQAc2BkzXvzJbv+oN1n4bf7zzQt2Ma1B5+L7AX2UORyZaldCHQjnLLYI62RSuT4v4ajp
	/1Keu2We9ntyxI5yRaVfDXqmX/WCHAqm6q6nwVUA80GyMlIxLj7J0Thhfr3+mJmlaTTBSHTXCYR
	WO9Bwv2hc/FnmmmJhePlAMzGREQfpZNUM30DX2JQTDKo+V+GkuOkYYReTIoCGGfnorIWNuvVR4C
	vdjPOxHJ9zC6Cv9h45Rf1CsG43dw99pXPNtE63x/21kk1S9e3wQk2eFBDSw0kqfaOe0x4x/waI2
	sRfx/E3L1Jb+ufE4d/xNYXjo3JqQr4yctKB0R7HheG3u1F5d/gEG5pTjCFVMJA4szj1hv7n/Ard
	Synw==
X-Google-Smtp-Source: AGHT+IFz2TELEpwQcNHi8Big5gdYlVAna1EaFTngQhDTZ9V9P9v+M+A7dI/QxYGajqOZu85nOYax3A==
X-Received: by 2002:a05:600c:500d:b0:442:e608:12a6 with SMTP id 5b1f17b1804b1-4533ca468d3mr46445835e9.1.1750160385015;
        Tue, 17 Jun 2025 04:39:45 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45320562afbsm173008185e9.1.2025.06.17.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 04:39:44 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:39:35 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "open list:NETWORKING [TCP]"
 <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] tcp_metrics: set maximum cwnd from the dst
 entry
Message-ID: <20250617133935.60f621db@mordecai.tesarici.cz>
In-Reply-To: <da990565-b8ec-4d34-9739-cf13a2a7d2b3@redhat.com>
References: <20250613102012.724405-1-ptesarik@suse.com>
	<20250613102012.724405-2-ptesarik@suse.com>
	<da990565-b8ec-4d34-9739-cf13a2a7d2b3@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 13:00:53 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 6/13/25 12:20 PM, Petr Tesarik wrote:
> > diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> > index 4251670e328c8..dd8f3457bd72e 100644
> > --- a/net/ipv4/tcp_metrics.c
> > +++ b/net/ipv4/tcp_metrics.c
> > @@ -477,6 +477,9 @@ void tcp_init_metrics(struct sock *sk)
> >  	if (!dst)
> >  		goto reset;
> >  
> > +	if (dst_metric_locked(dst, RTAX_CWND))
> > +		tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);
> > +
> >  	rcu_read_lock();
> >  	tm = tcp_get_metrics(sk, dst, false);
> >  	if (!tm) {
> > @@ -484,9 +487,6 @@ void tcp_init_metrics(struct sock *sk)
> >  		goto reset;
> >  	}
> >  
> > -	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> > -		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
> > -
> >  	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
> >  	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
> >  	if (val) {  
> 
> It's unclear to me why you drop the tcp_metric_get() here. It looks like
> the above will cause a functional regression, with unlocked cached
> metrics no longer taking effects?

Unlocked cached TCP_METRIC_CWND has never taken effects. As you can
see, tcp_metric_get() was executed only if the metric was locked. 

In fact, the cwnd parameter in the route does not have any effect
either. It's even documented in the manual page of ip-route(8):

              cwnd NUMBER (Linux 2.3.15+ only)
                     the clamp for congestion window. It is ignored if
                     the lock flag is not used.

Note that here is also an initcwnd parameter, and I'm not changing
anything about the handling of that one.

Now, if you think that this TCP_METRIC_CWND is quite useless, then I
wholeheartedly agree with you, but we cannot simply remove it, as it
has become part of uapi, defined in include/uapi/linux/tcp_metrics.h.

Petr T

