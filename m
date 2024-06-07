Return-Path: <netdev+bounces-101666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5DE8FFC60
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82271F23FA5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7548152530;
	Fri,  7 Jun 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPljE4sR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BF4315F
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742623; cv=none; b=Q+4gpD7nOzm96ixw/y4opL8SnErpBEkCHinibwIHEZWiQZIhWDGjVET1+LcCTrOyXhqmg9GoZbqxPLan6SRmFvpEnjlyikWfb2TOh1MpaXQWe5/SveORWW4CbkxplTubkterS8KXh8TJ9Iuo1U67LdPgVMuFAMM50dDq0cLR5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742623; c=relaxed/simple;
	bh=/xdYMfcVV9jovDn+g8CmRv9oBT+5S/BDQQ3k7pb9crI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNAunQW2UjxmscVZ7Y7GARW8UXXqS4vsIZUgbA4a0X+qKKpuyE6wJMrNZFIiVRyfY4tRf7J4ykqkJ+YqSscgi3eZhNJ9FdD1QjiXjXHBToTcvfMJ6RxBfB/VET0T+iWBoNg6hCLEKsc8K8qZY2KXGtxI18OwpLUq8OQ3izgF65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPljE4sR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rL5WzBeZZQ0tho6qsKfq0awo3sDUhxqbwzK5xndnSDY=;
	b=iPljE4sRg6SmCOWkxjRg79RDjuDoX1qEqouDPvY03DpiERAjPQZAaFT3OzU6bRUBwTeCiM
	RyvGtb5ExINIPICKoh1MTQtrDbiMtyxHedkfmydzc6pKdiMhzVFCI3YAGduM66sCQjR+j1
	tJhIdMIoetF0nsdmOYKe/RAfj7ZhD2A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-z9cbjf_4Pl-pGh3rmSA2Zg-1; Fri, 07 Jun 2024 02:43:36 -0400
X-MC-Unique: z9cbjf_4Pl-pGh3rmSA2Zg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57a33a589b3so834450a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742615; x=1718347415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL5WzBeZZQ0tho6qsKfq0awo3sDUhxqbwzK5xndnSDY=;
        b=XjgGIpi3JdhDEMwUjK2tghjCo9lmFjn75lD6ypDLQw1HsqAN2tb0ko9J1F9zrpPQXK
         fhU8UqvTAIGxlHE77j28ISX0c3LmrJLrAPIkIIpIdFSRhgU8MoPT0YsvNVchWRe97wGe
         F3AwnQs7xYg6v4r6ODwZkDfyv2UmERUMpkekaZh16PBemPtO9gVRY712R+IRTSnKasX3
         9ySPbl8SmRVzuaKPOE0IINx+TqfOAjGu4WIXreXUVhVTxLl6EGBoWmRaRUK3xyEXXazX
         xuONtjXsACUMk9M1vesMZG6VS2t44uciqfA+frHBE5Yz123RpnLkHsmGpteguR2Ih8Jr
         h+gw==
X-Forwarded-Encrypted: i=1; AJvYcCXKSU2UqRY9uE9NCbqxBcA5ftephvWnrtEfiIaQ9bf369HeBEmqkgfY6VfSZhn9klE3WkNbhxt8KRKv9G1Nni337Pnqu2m8
X-Gm-Message-State: AOJu0YyXWP9LFYrX//vDQq5CLWhYdgAzEzBQba03M82TeadCX2viMxA0
	2GRJqPNhksSpwsi1xAmy1c+oOL+l5eyopjtSULRi9mzew1yyd1ED+mjNyW4VMpGdxD9hDofegm4
	nO2M0rUi0aT3+35mADxYmq8QoJRmIiKnknWg7kYgOgIVkiaCYN0Ryjg==
X-Received: by 2002:a50:a68e:0:b0:57a:3424:b36e with SMTP id 4fb4d7f45d1cf-57c508eeee7mr876440a12.13.1717742614771;
        Thu, 06 Jun 2024 23:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmnJhQeO92KUlefgY2U2zoUjx1WCCNehyRAvLNjZi3NHcq2+9YWY/j/rrHZp93GT2w5IFl8A==
X-Received: by 2002:a50:a68e:0:b0:57a:3424:b36e with SMTP id 4fb4d7f45d1cf-57c508eeee7mr876422a12.13.1717742614192;
        Thu, 06 Jun 2024 23:43:34 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae20243esm2224517a12.68.2024.06.06.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:43:33 -0700 (PDT)
Date: Fri, 7 Jun 2024 02:43:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240607024057-mutt-send-email-mst@kernel.org>
References: <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>

On Fri, Jun 07, 2024 at 08:39:20AM +0200, Jiri Pirko wrote:
> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 9:45 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >>
> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >> >On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>
> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> >> > > If the codes of orphan mode don't have an impact when you enable
> >> >> > > napi_tx mode, please keep it if you can.
> >> >> >
> >> >> > For example, it complicates BQL implementation.
> >> >> >
> >> >> > Thanks
> >> >>
> >> >> I very much doubt sending interrupts to a VM can
> >> >> *on all benchmarks* compete with not sending interrupts.
> >> >
> >> >It should not differ too much from the physical NIC. We can have one
> >> >more round of benchmarks to see the difference.
> >> >
> >> >But if NAPI mode needs to win all of the benchmarks in order to get
> >> >rid of orphan, that would be very difficult. Considering various bugs
> >> >will be fixed by dropping skb_orphan(), it would be sufficient if most
> >> >of the benchmark doesn't show obvious differences.
> >> >
> >> >Looking at git history, there're commits that removes skb_orphan(), for example:
> >> >
> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >> >Author: Eric Dumazet <edumazet@google.com>
> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >> >
> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >> >
> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
> >> >    since skb wont stay a long time in TX ring before their release.
> >> >
> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
> >> >    possible, since it breaks TCP Small Queue or other flow control
> >> >    mechanisms (per socket limits)
> >> >
> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >> >
> >> >>
> >> >> So yea, it's great if napi and hardware are advanced enough
> >> >> that the default can be changed, since this way virtio
> >> >> is closer to a regular nic and more or standard
> >> >> infrastructure can be used.
> >> >>
> >> >> But dropping it will go against *no breaking userspace* rule.
> >> >> Complicated? Tough.
> >> >
> >> >I don't know what kind of userspace is broken by this. Or why it is
> >> >not broken since the day we enable NAPI mode by default.
> >>
> >> There is a module option that explicitly allows user to set
> >> napi_tx=false
> >> or
> >> napi_weight=0
> >>
> >> So if you remove this option or ignore it, both breaks the user
> >> expectation.
> >
> >We can keep them, but I wonder what's the expectation of the user
> >here? The only thing so far I can imagine is the performance
> >difference.
> 
> True.
> 
> >
> >> I personally would vote for this breakage. To carry ancient
> >> things like this one forever does not make sense to me.
> >
> >Exactly.
> >
> >> While at it,
> >> let's remove all virtio net module params. Thoughts?
> >
> >I tend to
> >
> >1) drop the orphan mode, but we can have some benchmarks first
> 
> Any idea which? That would be really tricky to find the ones where
> orphan mode makes difference I assume.

Exactly. We are kind of stuck with it I think.
I would just do this:

void orphan_destructor(struct sk_buff *skb)
{
}

	skb_orphan(skb);
	skb->destructor = orphan_destructor;
	/* skip BQL */
	return;


and then later
	/* skip BQL accounting if we orphaned on xmit path */
	if (skb->destructor == orphan_destructor)
		return;



Hmm?


> 
> >2) keep the module parameters
> 
> and ignore them, correct? Perhaps a warning would be good.
> 
> 
> >
> >Thanks
> >
> >>
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> --
> >> >> MST
> >> >>
> >> >
> >>
> >


