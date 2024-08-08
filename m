Return-Path: <netdev+bounces-116644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A194B4E0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31945B22C94
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7B8C1F;
	Thu,  8 Aug 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayltXs3f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCFD528;
	Thu,  8 Aug 2024 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083099; cv=none; b=pgE03S4yUph/+byhPfPomMom4l6MJTntMUdFP/rf5D5rfFzWR6u9PkRKzOtQYFFBWKgzO7oX36EmTlPEMxRGHjPl7AtfBwNvjCAafWd/UEzHvNAWqqe8lDeZ/WUA8UcT0UAZbeLoKYJ6p40Zmypt4dqz36Isgp9hwyb+oB93wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083099; c=relaxed/simple;
	bh=z+EViZNV79VB4O8ziUlmq6Dl+gQYNPEHQDlMMj3Dcgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKCDphxOhS57ja8f3Yv1XA9dzCFHGitkh+UHA9X+vAsLYmBCUCOKmzZgc1ojNk9NcRh5P6lxPcTqE+8fkEifR+jDI5VAJhSk9EcbK+mqrQZrZvgG6bn0W2lpDqlXyvniNfyGf3lNn0QKlO4QhhaOmUX//uVL3wOMIVXsDpj8eo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayltXs3f; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0e86974172so395718276.2;
        Wed, 07 Aug 2024 19:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723083097; x=1723687897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ayuCxxzou3rjkAIxd0SiAGa/p1U9ai3VeQLbkYZyQ0=;
        b=ayltXs3fcOaL8uVqb3RMGdkERKLmwXlKRAz5j9Ux9UuMJbNc3JBMASpDsbCDO2XVcT
         kjyn2TeUCuwkSLtDNdCo1hj7TxdNhFAFOpkUUIH8dF1UgCWCBsFVyUkp3HhWRjGDE5GC
         hlrEwAiC7je4Z29tatsKtD6zwPrdLHD6CRf71pob2lwNjq35Fe62iXfZ1oVt9k2au43x
         wGgSL/pOly30Pg8GkyUklDqrJKRtXCw98L2KCA0JH2cCF2l+0ctVsUDA5XDrh81j2vYJ
         zkwsepeE9iqgqp1auolWbus3kmav61/OyAbQRC9FMtTsYAdu1NuMYe//Xs1/HN0OdSbW
         nocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723083097; x=1723687897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ayuCxxzou3rjkAIxd0SiAGa/p1U9ai3VeQLbkYZyQ0=;
        b=UlLWoc017fbeQ7+d+NHdLsDZmJUj/2d9hDGoMwnM0PT3A0oiWjpMfwsTY48lXThHoM
         rIBUgLrVTZZVyxax4Ewmk2zeL0wopSIOnqV/2FOvN9hPkU5JKeZ/5U2ZpCsXQLeT3jiK
         T2gPiMtn/g28VBKKVnwvLP2iCectucwr2eThLZGpqALntNCZ246UTli+vjuAIo8AREfj
         i5ZM5sCSqPfPWYMIfq0F5KjoSe3VE7qDbbJxfg+Bnq1URZ7LXpw5NKE369VymCb0rpcK
         ySAk7riStfTJsancD14f0B9gwnIQ14oiIU5LH6cm7WS61BQXFffsS6T4+toafoIjiDRF
         YnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkt3ELPkvTTGWvj/WAOkhpu5IPehMmbv4ts+4nGLWNvaHOBbgMCp7gv+quZEUu/oXmgASy0PJpc+vFhB+X4O2SCll6vhSQm/ehppVl
X-Gm-Message-State: AOJu0Ywm1PScGjGAzJT7G19CECXKOMjmpoq6GTDpaN86z3GxWjU7LzOZ
	m3SRbXpMBlLJF7cS6S/hEx+t9+xaCb4OLTBsmY43dJF1x5rueuYGjxNBTKXTPvEbNOPperLlqEy
	sAhEX/sHNO+ZUKaB1++/gWRazPyw=
X-Google-Smtp-Source: AGHT+IFgyYRQZ0T+crlRbvXmISDuqo7qHyO7d2SIq+Im3nOTgzA7sQVUzIdByO5Rx+pb6VTN58XUXIo+sJjYZ8XC6yc=
X-Received: by 2002:a05:6902:2b0c:b0:e0d:71a7:5973 with SMTP id
 3f1490d57ef6-e0e9dbf3dd2mr544251276.40.1723083096542; Wed, 07 Aug 2024
 19:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731111940.8383-1-ayaka@soulik.info> <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info> <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info> <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
 <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info> <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
 <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info> <66acf6cc551a0_2751b6294bf@willemb.c.googlers.com.notmuch>
 <3a3695a1-367c-4868-b6e1-1190b927b8e7@soulik.info>
In-Reply-To: <3a3695a1-367c-4868-b6e1-1190b927b8e7@soulik.info>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Aug 2024 22:10:58 -0400
Message-ID: <CAF=yD-+9HUkzDnfhOgpVkGyeMEJPhzabebt3bdzUHmpEPR1New@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Randy Li <ayaka@soulik.info>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >> I think this question is about why I do the filter in the kernel not the
> >> userspace?
> >>
> >> It would be much more easy to the dispatch work in kernel, I only need
> >> to watch the established peer with the help of epoll(). Kernel could
> >> drop all the unwanted packets. Besides, if I do the filter/dispatcher
> >> work in the userspace, it would need to copy the packet's data to the
> >> userspace first, even decide its fate by reading a few bytes from its
> >> beginning offset. I think we can avoid such a cost.
> > A custom mapping function is exactly the purpose of TUNSETSTEERINGEBPF.
> >
> > Please take a look at that. It's a lot more elegant than going through
> > userspace and then inserting individual tc skbedit filters.
>
> I checked how this socket filter works, I think we still need this
> serial of patch.
>
> If I was right, this eBPF doesn't work like a regular socket filter. The
> eBPF's return value here means the target queue index not the size of
> the data that we want to keep from the sk_buf parameter's buf.

TUNSETSTEERINGEBPF is a queue selection mechanism for multi-queue tun devices.

It replaces the need to set skb->queue_mapping.

See also

"
commit 96f84061620c6325a2ca9a9a05b410e6461d03c3
Author: Jason Wang <jasowang@redhat.com>
Date:   Mon Dec 4 17:31:23 2017 +0800

    tun: add eBPF based queue selection method
"

> Besides, according to
> https://ebpf-docs.dylanreimerink.nl/linux/program-type/BPF_PROG_TYPE_SOCKET_FILTER/
>
> I think the eBPF here can modify neither queue_mapping field nor hash
> field here.
>
> > See SKF_AD_QUEUE for classic BPF and __sk_buff queue_mapping for eBPF.
>
> Is it a map type BPF_MAP_TYPE_QUEUE?
>
> Besides, I think the eBPF in TUNSETSTEERINGEBPF would NOT take
> queue_mapping.

It obviates the need.

It sounds like you want to both filter and steer to a specific queue. Why?

In that case, a tc egress tc_bpf program may be able to do both.
Again, by writing to __sk_buff queue_mapping. Instead of u32 +
skbedit.

See also

"
commit 74e31ca850c1cddeca03503171dd145b6ce293b6
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue Feb 19 19:53:02 2019 +0100

    bpf: add skb->queue_mapping write access from tc clsact
"

But I suppose you could prefer u32 + skbedit.

Either way, the pertinent point is that you want to map some flow
match to a specific queue id.

This is straightforward if all queues are opened and none are closed.
But it is not if queues can get detached and attached dynamically.
Which I guess you encounter in practice?

I'm actually not sure how the current `tfile->queue_index =
tun->numqueues;` works in that case. As __tun_detach will do decrement
`--tun->numqueues;`. So multiple tfiles could end up with the same
queue_index. Unless dynamic detach + attach is not possible. But it
seems it is. Jason, if you're following, do you know this?

> If I want to drop packets for unwanted destination, I think
> TUNSETFILTEREBPF is what I need?
>
> That would lead to lookup the same mapping table twice, is there a
> better way for the CPU cache?

I agree that two programs should not be needed.

