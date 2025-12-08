Return-Path: <netdev+bounces-243992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2953CACE66
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959D03047457
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C02DF155;
	Mon,  8 Dec 2025 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qx7NuJ69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2C2F6915
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765190291; cv=none; b=IO00xwp3oYxfpGluZWdFQseZ/p8SnVU6AQg+w1Q4bhlponBr+YGCudlyjwtkG3bg7G38G/27mPxj8/OA6KVHB3PDr4/TB8Nu84q64DyqZZxZFx5w48UBeKERLJpYbxwEZmCOfIsXJ4siJUMyyf0E0KMDN4ZZOTXh7atvelUfybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765190291; c=relaxed/simple;
	bh=veqoeCg7pVkorIg9OECr4gZHueRPK5IwXUab5L1yh0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxAvNRjhfrgXjfs7cOmzmOm+Ut2ZniekRe+745/Q19dTugZQJ2Tl0aX3WosIhwZshM+aNmNxOCjPO6SfgMv8/gHeqaeV6KdldTrKgdXzwsSAe7oBdkJPf5sXDJxenHHtnSMNeyBv5Tic/SbBvUqOMabpYYmyXBbVPg8vlUQcgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qx7NuJ69; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6492e7891d2so1298413a12.2
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765190286; x=1765795086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mji8B84md8nQtZ3oth8B3djhu6SmcjWH/vP4wK2iA2U=;
        b=Qx7NuJ6972DL2ZAJWf+m1dWQKGDyHpgHf+h/RiTBcX0l/sw5bs0MsCJPo4dYj54oNQ
         XLvhFLL7+iBx+EZgQTuVry9Dj8q0+OyEC76APg0QpQvMIuNdlI5M/1M5d8L/eudP8qXl
         xzRQqH67kf/MHCR6uB9q1ontoChQXoXUWhiPCEIsbYlVD1EstwIkIfq8oW6k6mxkEkus
         5ZhEQmfpAVgrpOzsbqfRmbua1ccFTF7inMjfTBuJ8B693DKxG9H3+JRBBALhoQfLmmSK
         Si8tQpekRjNhkHIVio3cU+vkWto1cDvOkEuNA2GphXf2Idk+pkUTJscYT0zK5aP6lRdy
         SJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765190286; x=1765795086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mji8B84md8nQtZ3oth8B3djhu6SmcjWH/vP4wK2iA2U=;
        b=aquPnVI/End6uIYh0YtcY4gU5X+7qqs68OoLgB5LdmyDYvTMHTUqaig+JEqx93iAC6
         joOY+miqsCMI9VBJ0wl6IQfqQMRqe3I5p7JpvIuxAYiNSuuehkeZCce0chVfggReWQsd
         wzc8DTw5sYwRb4DWGg2NZSX7uxGCTgTz0HylacF+OJGThqIzvISD6rYbm0ZH3dnka69r
         cJn14uZ0ad8fFOS9tSNag3dxdxJh3sME4Q+OYvO0kXHPU2U1pLv5lUtbz4zlF9sKMcLO
         fmEwVvx0MnLw2QWcLTpzRUqPfn3r0uHNsemdZ9lCZqQTQWR1+FtuHqfORtX5PM4S3uYF
         pcmg==
X-Forwarded-Encrypted: i=1; AJvYcCX8/3GhU+bvYFNpSWErUIK0iuMJFkmB+7sDLujUN3aSKDDc/z7DzilYMBmYu1GXcQ4zDhXbc9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1DVcB/SsCdXYkbbcYrubL9uYHMcJvuFUR8HeREy6J5cahojJ
	vJndkWO0TtxZ7Sm46SNZxNs/Hz6zrpH7y3MqAxiHRQbeWch4pIXs7anKK89M5xLvu4IjCNR8BlC
	Kw+GZGMcIZeyhoK1WP//H6OXW1HXbzB+0S59NcPuIFw==
X-Gm-Gg: ASbGncspn+j2b5HY4RpSSeQKiu4Sb1qdepUScTIcE7dBkbE3ggKFcLXma4EpIxNRwXW
	5JctDLA5jtCbbw+Dtkofoubu5o9kdERyQHvdoN+zgwtSf7dSsTh/m/lDu5ELk08JLJHZDcZNoKa
	ykSPxyVBNwATR27cBTxIvRHVNDxkZFP9vlDIJjunFV0XlIbsZJEi67ZweOAqvJL8RzG+O+ObMog
	k201CmdLfrpIE6PuuQuDc//lQTTjrnooMwM2HaqYEGcVQpRgdNsqoBq8Y5Qa0xjXMGK57fmPcv+
	V4wMPDLsvABQBQ==
X-Google-Smtp-Source: AGHT+IGxwvSUGmJHPUxT24x5fgUZGSwKKUkn5y3lOfJpm21ddF9v4ZhjA7/iaoybt5YY+uNYMcEqFB7V2eYmkQDhn0c=
X-Received: by 2002:a05:6402:518b:b0:641:3492:723d with SMTP id
 4fb4d7f45d1cf-6491a3f1ca9mr5638006a12.11.1765190284264; Mon, 08 Dec 2025
 02:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176424680115.194326.6611149743733067162.stgit@firesoul>
 <176424683595.194326.16910514346485415528.stgit@firesoul> <aShi608hEPxDLvsr@strlen.de>
 <c38966ab-4a3c-4a72-a3c1-5c0301408609@kernel.org>
In-Reply-To: <c38966ab-4a3c-4a72-a3c1-5c0301408609@kernel.org>
From: Nick Wood <nwood@cloudflare.com>
Date: Mon, 8 Dec 2025 10:37:48 +0000
X-Gm-Features: AQt7F2rlo4k5DLNhf8oqS3gglGN7Mr-5s6gZckXxXt0yQO5Qc7Cgj73Tf-EJfGI
Message-ID: <CACrpuLQGj70xCi8wDH4HeKzkA=d-9+eOYkkQ47M2Tw8MA65kzQ@mail.gmail.com>
Subject: Re: [PATCH nf-next RFC 1/3] xt_statistic: taking GRO/GSO into account
 for nth-match
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org, phil@nwl.cc, 
	Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
	mfleming@cloudflare.com, matt@readmodwrite.com, aforster@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 16:23, Jesper Dangaard Brouer <hawk@kernel.org> wrote:

> > So the existing algorithm works correctly even when considering
> > aggregation because on average the correct amount of segments gets
> > matched (logged).
> >
>
> No, this is where the "on average" assumption fails.  Packets with many
> segments gets statistically under-represented. As far as I'm told people
> noticed that the bandwidth estimate based on sampled packets were too
> far off (from other correlating stats like interface stats).

On-average is technically correct here; the issue is more subtle than
simple undercounting. To understand, consider a 50pps flow (without
GRO/GSO) with a sampling rate of 1/100. With 1 in k sampling we take a
sample every other second, and to estimate total flow we multiply by
the sample rate so we get a sawtooth looking wave that alternates
between 100pps and 0 every second. This is not 'correct', it's an
estimate as we'd expect, the absolute error here alternates between
+/-50 with the same frequency.

Now let's encapsulate these 50pps in a single GSO packet every second,
with 1-in-k is sampling on an all or nothing basis. For 99 seconds out
of every hundred we sample no packets -this is the under-sampling
you're referencing. But, for 1 second in 100 we sample the whole
GRO/GSO, and capture 50 samples. Causing our pps estimate for that
instant spikes to 5,000pps - so for an instant our absolute error
spikes by 2 orders of magnitude ('true' pps is 50 remember).

If you average the single spike into the 99 seconds of undersampling,
the figures do 'average out', but for very short flows this
amplification of error makes it impossible to accurately estimate the
true packet rate.
>
> I'm told (Cc Nick Wood) the statistically correct way with --probability
> setting would be doing a Bernoulli trial[1] or a "binomial experiment".
>   This is how our userspace code (that gets all GRO/GSO packets) does
> statistical sampling based on the number of segments (to get the correct
> statistical probability):
>
> The Rust code does this:
>   let probability = 1.0 / sample_interval as f64;
>   let adjusted_probability = nr_packets * probability * (1.0 -
> probability).powf(nr_packets - 1.0);
>
>   [1] https://en.wikipedia.org/wiki/Bernoulli_trial
>
> We could (also) update the kernel code for --probability to do this, but
> as you can see the Rust code uses floating point calculations.
>
> It was easier to change the nth code (and easier for me to reason about)
> than dealing with converting the the formula to use an integer
> approximation (given we don't have floating point calc in kernel).

with s = integer sample rate (i.e s=100 if we're sampling 1/100)
and n = nr_packets:

sample_threshold = [ 2**32 //s //s ] * [n*(s - (n-1))] ;

if get_random_u32 < sample_threshold {
    sample_single_subpacket
}*

Is an equivalent integer calculation for a Bernoulli trial treatment.
It undersamples by about 1 in 1/100k for s=100 and n=50 which is good
enough for most purposes. Error is smaller for smaller n. For smaller
s it may warrant an additional (cubic) term in n
*I'm a mathematician, not a kernel developer


> > With this proposed new algo, we can now match 100% of skbs / aggregated
> > segments, even for something like '--every 10'.  And that seems fishy to
> > me.
> >
> > As far as I understood its only 'more correct' in your case because the
> > logging backend picks one individual segment out from the NFLOG'd
> > superpacket.
> >
> > But if it would NOT do that, then you now sample (almost) all segments
> > seen on wire.  Did I misunderstand something here?
>
> See above explanation about Bernoulli trial[1].
>
> --Jesper
>

