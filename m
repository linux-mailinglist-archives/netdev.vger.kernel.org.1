Return-Path: <netdev+bounces-213843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A98E3B27090
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C2C1CC80EB
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F326D4DD;
	Thu, 14 Aug 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNosmvel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146B481DD;
	Thu, 14 Aug 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205532; cv=none; b=VfEhAR9kMNyh+3XqxAK7t7jCNXqIQisjGGa5ySPbxGIVkpi9AjnuNk1o1apqo0UznFAnm3rXROisgs+pfuG+ejHaYo2aR3+rfgpeka7EIcsU50rskljSGlcDV/rKtGjgF86fjxLzkI427SLA6z0fRvTFraxwh6qo70SzG3iy4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205532; c=relaxed/simple;
	bh=ZCIl/bch8Z+EnJqYBHhA4O86LR5t1lBHn52rRfKa2AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcsl1bRQHa6nkebWzVVXu0D3kLz5t6lu+kyC8NgtnisZohl96CMWPN2NQiXpXIreHm3SfocalIDPpDY5AZcmloSplfWF8sQgqEkd0DMUpKIzVnEqW/ZTal4FteRXgL6DqhrueXQxri2mefCttViHPnQPccv+UlVdArhjIV2hPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNosmvel; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323266d6f57so1609682a91.0;
        Thu, 14 Aug 2025 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755205530; x=1755810330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2T2PoMsudVCZDZVP5aXgBiKlpVA7csNpTl7e1h8I1g=;
        b=UNosmvelLXY0j+HpYTdzFL3QasUlCs4NtPgiInAiqo1dDDMepqUzUEP/DwWrWKqkrS
         zDDoAHqbTb30Oorm+Za5oug0cnH2fbi38e8Ma9pIOU3paDhpn1IPTpNhSUp9JIPSXQDG
         UEO4mv0HOCjyafhnXmcNkjL0jafDb9gMrCicQqaiTzOW1ulQQmXKMzQW6s2jXdxA3oqd
         g5QCL0cewGg+MXOunLAjLSHB0H9JhEAi/xdjXvksi3K0+pcaQAyXIMOeeV72wdZ8ctAR
         8tS7Lrpp8tMAzig1mSyn6nuY7z/NGEpK2DwWZpk5cxJpxXjC82V4GEy+VA399VpuBu0A
         1GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755205530; x=1755810330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2T2PoMsudVCZDZVP5aXgBiKlpVA7csNpTl7e1h8I1g=;
        b=sqKZaAdIVp21jyqULy+ML2TlYIMwhLaqvPpAOVmoaPivcgcmSud7E3U8ePB1tRQD+K
         IGk8LfUEdHjwqRzMs4eHlwqz3Jv0k8mAaubaXcoMCfzvIFAe0WaGhEBomBRaknmwfYCC
         5h3SyoPT43IY6UCi4ilhzD3NYoa06dE3aX9tXx4BxaI470/NR3s9Hq5BaSvwmkt/D9GI
         WVwDR9FaXnohdMq81qXpXOPp5ih8Yv5mdTcDab+Q6UbGTF+q3dYGXMFX0v26xopf+IZe
         hEufYkcXMikY8n1rJ5WYXfyrefK6QEnLfyZZluQHZnVylLEcYeIRTcGXjWP9DJzA9RjY
         Q29Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0mk89OtyVRo4MIEzfCA7Okr/fYq1GZO+a5l6kR2zW4+7QNf86d/3/xbaGfA0yFH5LJ34z9yRDxcaMcfk=@vger.kernel.org, AJvYcCWfz9GutM2SPyum/spJjw1PihnkH/M5QCAzaPcxki87CnsImTp9sdqmG8NCpMn7DI0F2zmpQodP@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6jVSyXFHXQe+neUWVGw73lJj5jWXyuvGSya4YkVPgd/TvA6J
	8y95p6AmAX597eOURM5pllAiru7wsI+fYpQZzWV5LTbEH8Vj8QhRbU/S
X-Gm-Gg: ASbGncsZQMfpa3uqdFfEATI0IinMtF2YX6AqZCaWuIl4KUoN5+/lpJ7ipqr88owmRId
	h62DYsQMBfXvsnID1OspzeIwbUeq1n1uYxNMVYNAkPkGRQ8AoENtPTtVeTej+NJ29Qh6YbgDU8H
	Gi4lSPv5yX9GP4pi5a5OnUnj9+tLV6Ieh/zbIKeLT0GXpWF9N48drv/MTNtU0+v+HHEgHUsPJZH
	ALaRmoCtCW/O51UeobbFs0f/srJ2CpnXmw2Yno2Lzcs9MzhGVSVGWJGJrWbGVqXT+ZzajUaeTH3
	KegD7Vo4lpeSANNOA2oF5HxqOUNbxxhsq9qSnCbaiLTuvNplaQAW+fm5Jn/XwqZVEDWNnhlezf8
	R96z68te7kJg++qm1oOHDdA==
X-Google-Smtp-Source: AGHT+IF38DQIT8miVnC99y7ONcHPClHfyWEuPfhP5Okjv5gjZagJcD4NNDaRehygybwdY0lCOtBdiQ==
X-Received: by 2002:a17:90b:1d50:b0:31f:3cfd:d334 with SMTP id 98e67ed59e1d1-32327b09c1amr6796298a91.4.1755205529869;
        Thu, 14 Aug 2025 14:05:29 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233116f46fsm2823419a91.28.2025.08.14.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:05:29 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:05:27 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu_from() where
 appropriate
Message-ID: <aJ5Pl1i0RczgaHyI@yury>
References: <20250814195838.388693-1-yury.norov@gmail.com>
 <c5b583a8-65da-4adb-8cf1-73bf679c0593@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b583a8-65da-4adb-8cf1-73bf679c0593@ovn.org>

On Thu, Aug 14, 2025 at 10:49:30PM +0200, Ilya Maximets wrote:
> On 8/14/25 9:58 PM, Yury Norov wrote:
> > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > 
> > Openvswitch opencodes for_each_cpu_from(). Fix it and drop some
> > housekeeping code.
> > 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  net/openvswitch/flow.c       | 14 ++++++--------
> >  net/openvswitch/flow_table.c |  8 ++++----
> >  2 files changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> > index b80bd3a90773..b464ab120731 100644
> > --- a/net/openvswitch/flow.c
> > +++ b/net/openvswitch/flow.c
> > @@ -129,15 +129,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
> >  			struct ovs_flow_stats *ovs_stats,
> >  			unsigned long *used, __be16 *tcp_flags)
> >  {
> > -	int cpu;
> > +	/* CPU 0 is always considered */
> > +	unsigned int cpu = 1;
> 
> Hmm.  I'm a bit confused here.  Where is CPU 0 considered if we start
> iteration from 1?

I didn't touch this part of the original comment, as you see, and I'm
not a domain expert, so don't know what does this wording mean.

Most likely 'always considered' means that CPU0 is not accounted in this
statistics.
  
> >  	*used = 0;
> >  	*tcp_flags = 0;
> >  	memset(ovs_stats, 0, sizeof(*ovs_stats));
> >  
> > -	/* We open code this to make sure cpu 0 is always considered */
> > -	for (cpu = 0; cpu < nr_cpu_ids;
> > -	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
> > +	for_each_cpu_from(cpu, flow->cpu_used_mask) {
> 
> And why it needs to be a for_each_cpu_from() and not just for_each_cpu() ?

The original code explicitly ignores CPU0. If we use for_each_cpu(),
it would ignore initial value in 'cpu'. Contrary, for_each_cpu_from()
does respect it.

> Note: the original logic here came from using for_each_node() back when
> stats were collected per numa, and it was important to check node 0 when
> the system didn't have it, so the loop was open-coded, see commit:
>   40773966ccf1 ("openvswitch: fix flow stats accounting when node 0 is not possible")
> 
> Later the stats collection was changed to be per-CPU instead of per-NUMA,
> th eloop was adjusted to CPUs, but remained open-coded, even though it
> was probbaly safe to use for_each_cpu() macro here, as it accepts the
> mask and doesn't limit it to available CPUs, unlike the for_each_node()
> macro that only iterates over possible NUMA node numbers and will skip
> the zero.  The zero is importnat, because it is used as long as only one
> core updates the stats, regardless of the number of that core, AFAIU.
> 
> So, the comments in the code do not really make a lot of sense, especially
> in this patch.

I can include CPU0 and iterate over it, but it would break the existing
logic. The intention of my work is to minimize direct cpumask_next()
usage over the kernel, and as I said I'm not a domain expert here.

Let's wait for more comments. If it's indeed a bug in current logic,
I'll happily send v2.

Thanks,
Yury

