Return-Path: <netdev+bounces-165176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB267A30D64
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BC816539A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9624C669;
	Tue, 11 Feb 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgYIdW9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9A230D0E;
	Tue, 11 Feb 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282146; cv=none; b=G/7WsRr0l21XcXamZTlNrC7CxHOenNAl9MMDNDsgq2oOYhwFitrn/d6eMwsgSk0vP7vlalPJc3nJHTFRjdJTDAOu2GnXsu+tHfYYrFBITuOOwT0JL71N3BgmAEv7xzwmTdXAXrKodptWY4EQth88KpSrkd4O6+0JD5pH16Y2rrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282146; c=relaxed/simple;
	bh=y7YayNRV4hH9s4wGZvK6fVWRl8LnwHkoEGP4InwFH68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqa2ne9qS0f7+Mj3Yv+9CLhf2qNOYqyw3pGRxz7pAYHUyTTPASdeXW/cVdl9nOFVq9CeQFt4KSnidlHyiwqgp7ZHIw1BGqCZxPzcNf0KkYY14+gOor3jAzrlgP4N6OUb1pTn/coW086EeKvB5qaZl5kUbd4y2ZAVlKBFVgxYuo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgYIdW9H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f49837d36so63407025ad.3;
        Tue, 11 Feb 2025 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739282144; x=1739886944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe7Pjgx0u2jo3N4C797eHAMKjNj56h5zdwjXJ9xQddk=;
        b=DgYIdW9H/T7vDMUQvnkzNb3/3aYfmDpzefW7xlCfdheGHoECIPCnXtiDeFX75A+l/1
         W5QG9oo5toc5U7D+Wr3PYVVvRcUMGaDG0NOqhdito0NWaDfEPAueHoh8UzkvJ7MAImH3
         ph1rrxWKK2PYxV0x57WInOVhn+reh09hSzMxExP8nPuXhTXoE4cR14O7d6IgWB9rNgUz
         byYxp7q+m2iKbCWtjkT17BfYYOoJrKt8GIF4Q9pHTboucXbxedQs5MyE8B0kFprp2O93
         3pou8kGNnxvezZx8DkH0+1yeX3cCUciirsxX8eUhQH66xwF7P0cr2rqxtTb+e+ImzmId
         llxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739282144; x=1739886944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe7Pjgx0u2jo3N4C797eHAMKjNj56h5zdwjXJ9xQddk=;
        b=BukGxyWsQw7pWiNheCe3nBy2er3//C/8TDsHGvRcrQKYe+0yqCTkFwX6xmh6+u3RgT
         B1Kv6y+F3XvXhVtrE/u5yY2E5wWCmTSK4TWvhfiXRoJs62g5qBL7qZCq/gNC1ek01iQY
         K+i0jgm0z5JiIhnvETWwBKhmI5LPO+b87Q/4AREELxLrZyhjAdfpQNOiHAVLZQJR6kNV
         a0Uvakes17nruCHwz8J36XkOfad6P0nLmrbvzVbrswTwxPZQFIopjqWjXF5Ob6kVHg8k
         NUwLlGEkv/aq1I4AicUN07n9Um4oxBcEdfI1i2ixctons5JbU9b7oXbbFI1fAABh+VOG
         /qHw==
X-Forwarded-Encrypted: i=1; AJvYcCVY3iiczoZF68oPHFapQz67Fn5ohWCqtLQsWanvE/6k0LkS3McQVDLmQzGPSQ3RBeZNzO/jaso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpuLNAXoHCTwKMNsd5HwAyH46Z4yYnm4pL1wQ5KOlh33kn8etT
	FuLSIvbOEOwHEX7apxySI4Rm5dfjQ475u0+shes2DXIODb8ww4Bt
X-Gm-Gg: ASbGnct+sZ5DYU0cowypwqjiVUKq+kzaRjv3y9zcYPcBkl3gdJJPI0f7crCb3dk/iQ8
	JERWACV0deUfKmYvjwSF5FbTAFvhXFO34rE7mi2cEJuG4SYKAHkCnEqFwQG3mqtHkGTlAIcbH3D
	C09rWuwbzB5TtUMytL4NiD+dt1XMV3P2H+cKOYheAQHm8wCfl0ti3wXItn74spvNjZKhrvGzvJ8
	64BB/E5pnqlOhX1N4B1+OBITxwTNIYEoYH9ziSPfwmj4HvZnQney+zwfgLpMvXW23AgjKrjNAde
	VD8iYTMG8JXArkY=
X-Google-Smtp-Source: AGHT+IGybmRTzGld1TJo5gAB8g3kZ8JmcrDOdKn90fdDr4CK+9X7m1Buo5kLQopA+emGVc4tEKr7fg==
X-Received: by 2002:a17:903:2f91:b0:21f:90ae:bf83 with SMTP id d9443c01a7336-21f90aec1bcmr172463245ad.44.1739282144270;
        Tue, 11 Feb 2025 05:55:44 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368bb4bdsm95429665ad.235.2025.02.11.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:55:43 -0800 (PST)
Date: Tue, 11 Feb 2025 08:55:41 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 02/13] virtio_net: simplify virtnet_set_affinity()
Message-ID: <Z6tW1VleHcUQ_9p3@thinkpad>
References: <20250128164646.4009-1-yury.norov@gmail.com>
 <20250128164646.4009-3-yury.norov@gmail.com>
 <Z6PthznH5Tp-ZdHw@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6PthznH5Tp-ZdHw@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>

Thanks for review and testing, Nick!

On Wed, Feb 05, 2025 at 05:00:23PM -0600, Nick Child wrote:
> On Tue, Jan 28, 2025 at 11:46:31AM -0500, Yury Norov wrote:
> > The inner loop may be replaced with the dedicated for_each_online_cpu_wrap.
> > It helps to avoid setting the same bits in the @mask more than once, in
> > case of group_size is greater than number of online CPUs.
> 
> nit: Looking at the previous logic of how group_stride is calculated, I don't
> think there is possibility of "setting the same bits in the @mask more
> than once". group_stride = n_cpu / n_queues
> 
> nit: I see this more as 2 patches. The introduction of a new core
> helper function is a bit buried.
> 
> > 
> > CC: Nick Child <nnac123@linux.ibm.com>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> Don't know if my comments alone merit a v3 and I think the patch
> does simplify the codebase so:
> Reviewed-by: Nick Child <nnac123@linux.ibm.com>

I fixed the comments to #2 and #3 as you suggested and split-out new
for_each() loops to the new patch.

I also think those are trivial changes not worth v3. So it's in
bitmap-for-next:

https://github.com/norov/linux/tree/bitmap-for-next

Thanks for review, Nick!

Thanks,
Yury
 
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++-----
> >  include/linux/cpumask.h  |  4 ++++
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7646ddd9bef7..9d7c37e968b5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3826,7 +3826,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
> >  	cpumask_var_t mask;
> >  	int stragglers;
> >  	int group_size;
> > -	int i, j, cpu;
> > +	int i, start = 0, cpu;
> >  	int num_cpu;
> >  	int stride;
> >  
> > @@ -3840,16 +3840,18 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
> >  	stragglers = num_cpu >= vi->curr_queue_pairs ?
> >  			num_cpu % vi->curr_queue_pairs :
> >  			0;
> > -	cpu = cpumask_first(cpu_online_mask);
> >  
> >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> >  		group_size = stride + (i < stragglers ? 1 : 0);
> >  
> > -		for (j = 0; j < group_size; j++) {
> > +		for_each_online_cpu_wrap(cpu, start) {
> > +			if (!group_size--) {
> > +				start = cpu;
> > +				break;
> > +			}
> >  			cpumask_set_cpu(cpu, mask);
> > -			cpu = cpumask_next_wrap(cpu, cpu_online_mask,
> > -						nr_cpu_ids, false);
> >  		}
> > +
> >  		virtqueue_set_affinity(vi->rq[i].vq, mask);
> >  		virtqueue_set_affinity(vi->sq[i].vq, mask);
> >  		__netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 5cf69a110c1c..30042351f15f 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -1036,6 +1036,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
> >  
> >  #define for_each_possible_cpu_wrap(cpu, start)	\
> >  	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
> > +#define for_each_online_cpu_wrap(cpu, start)	\
> > +	for ((void)(start), (cpu) = 0; (cpu) < 1; (cpu)++)
> >  #else
> >  #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
> >  #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
> > @@ -1044,6 +1046,8 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
> >  
> >  #define for_each_possible_cpu_wrap(cpu, start)	\
> >  	for_each_cpu_wrap((cpu), cpu_possible_mask, (start))
> > +#define for_each_online_cpu_wrap(cpu, start)	\
> > +	for_each_cpu_wrap((cpu), cpu_online_mask, (start))
> >  #endif
> >  
> >  /* Wrappers for arch boot code to manipulate normally-constant masks */
> > -- 
> > 2.43.0
> > 

