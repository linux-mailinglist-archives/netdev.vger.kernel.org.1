Return-Path: <netdev+bounces-142868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E479C0826
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10562B22EAA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5621262C;
	Thu,  7 Nov 2024 13:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733920FA81;
	Thu,  7 Nov 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987506; cv=none; b=Lnr/wmKBQluIk//xiVgJECzrqhw6LRR+WKwb/kkAHzW6QFfSeVvrwO2QiV4RI2Zf7PRl6r1evLCjFZw9ID65J1uaWTjA2CxLszAbXOGqxo4+eou2KcyoD3sMWZUNrcVkpH6tb2oy7zE7NY3y6PHOWGnfM8k5NAHWaDhjJ7KOQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987506; c=relaxed/simple;
	bh=LgDglSd2Tl30/NhTA8ahbONVX/UT2nPSjobAt9t/8TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jyoxnld3JtN0kbLEW1oXFZQwxMkctyZsHpeeFgtZ0GlEnS58pGw/2u1OlnABzpb9cE5lxTuuAAv0y39V/7XKXmxlAkwc3HgPgRk1HsMr7iE8DwtofiRouC+7oEn/XHCbXKCufWgtQeJYwtjk9MiVBfUW9MRzadstkLzOFyLgbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso152513366b.1;
        Thu, 07 Nov 2024 05:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987503; x=1731592303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rQJA6TLiur9Q4EwskLjUkkQv1x5PCBZE3Fan5TuCjs=;
        b=keECATEFSvteiowvuSiPiKaDX3hYBfIQ4Ax0hzfsghQttoXFFyleIgPgQD5OndXE7W
         tXKSYOTHWelGGT3y2Ob5KaYHARbr80I/seYQRbzK7awN7ffqv7FdEvkurA79tra4pQad
         J5Ze3u0HZXDisADKKuGZjrRmkkdn6/wnKxzXb8pGJI5nvGbaeyXkdp1cUM5Kt08z5pQd
         SEJANMHn3MEvP+zE6fOTewJ1Z0qBTRsfxrUn6Do8x5JYbRJW9P60bnnAjarXD5Pel8SO
         ubrPHC84CafnGus18MGoOcZfty3xCNqxQIXbymrW9LMCHG+R9of4PhtEJ+udB9em3Aqm
         ynmA==
X-Forwarded-Encrypted: i=1; AJvYcCUT6u13lJksB6NApNghpXgQOo+o30miCTpjKiWnIb5cxbEsAQ/0N7hHIW4FwNXB3tvCqKz3MIyI@vger.kernel.org, AJvYcCWTdpo1j0YoLPL0O1qQMNwF/FZkH+/C2apKmOHMyS2jJncNT0p4/tEkDeG4juAvy0ri5pksXoZwk/kwB5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1pAH75O+k92OstGD2gjDFppuNitZTugidFYZahNq0a6eAKDh
	dz5yjc25yL1sHKpfUM/RZzJyVm1KnT1cPnJlXJP5YLNI/7syMVIH
X-Google-Smtp-Source: AGHT+IGoo8F9F3Fjhf8nh9EXZc/ifYsGipeFQIjD1SpfFQkyRYvZ/6GIfr8uzn9KVXziCfUUTrLe6w==
X-Received: by 2002:a17:907:31cb:b0:a9a:296:b501 with SMTP id a640c23a62f3a-a9de5f660a2mr4356554466b.26.1730987502953;
        Thu, 07 Nov 2024 05:51:42 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e92esm96786266b.182.2024.11.07.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:51:42 -0800 (PST)
Date: Thu, 7 Nov 2024 05:51:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] ipmr: Fix access to mfc_cache_list without lock held
Message-ID: <20241107-invisible-skylark-of-attack-e44be1@leitao>
References: <20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org>
 <CANn89iL-L8iBwp=rq-YwAeeoUY2MTjr5akWm=S=k7ckpkaEy+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL-L8iBwp=rq-YwAeeoUY2MTjr5akWm=S=k7ckpkaEy+Q@mail.gmail.com>

Hello Eric,

On Thu, Nov 07, 2024 at 02:13:14PM +0100, Eric Dumazet wrote:
> On Thu, Nov 7, 2024 at 12:03 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> > following code flow, the lock is not held, causing the following error
> > when `RCU_PROVE` is not held.
> >
> >         6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G            E    N
> >         -----------------------------
> >         net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader section!!
> >
> >         rcu_scheduler_active = 2, debug_locks = 1
> >                    2 locks held by RetransmitAggre/3519:
> >                     #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x8a/0x290
> >                     #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x6b/0x90
> >
> >         stack backtrace:
> >                     lockdep_rcu_suspicious
> >                     mr_table_dump
> >                     ipmr_rtm_dumproute
> >                     rtnl_dump_all
> >                     rtnl_dumpit
> >                     netlink_dump
> >                     __netlink_dump_start
> >                     rtnetlink_rcv_msg
> >                     netlink_rcv_skb
> >                     netlink_unicast
> >                     netlink_sendmsg
> >
> > Fix accessing `mfc_cache_list` without holding the RCU read lock. Adds
> > `rcu_read_lock()` and `rcu_read_unlock()` around `mr_table_dump()` to
> > prevent RCU-list traversal in non-reader section.
> >
> > Since `mr_table_dump()` is the only function that touches the list, that
> > might be the only critical section in `ipmr_rtm_dumproute()` that needs
> > to be protected in ipmr_rtm_dumproute().
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: cb167893f41e ("net: Plumb support for filtering ipv4 and ipv6 multicast route dumps")
> > ---
> >  net/ipv4/ipmr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 089864c6a35eec146a1ba90c22d79245f8e48158..bb855f32f328024f384a2fa58f42fc227705206e 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
> > @@ -2612,8 +2612,10 @@ static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
> >                         NL_SET_ERR_MSG(cb->extack, "ipv4: MR table does not exist");
> >                         return -ENOENT;
> >                 }
> > +               rcu_read_lock();
> >                 err = mr_table_dump(mrt, skb, cb, _ipmr_fill_mroute,
> >                                     &mfc_unres_lock, &filter);
> > +               rcu_read_unlock();
> >                 return skb->len ? : err;
> >         }
> >
> >
> 
> What about net/ipv6/ip6mr.c ip6mr_rtm_dumproute() ?

That one might require as well.

> In my opinion, since we still hold RTNL in these paths, we should
> change the lockdep annotation.

I don't have much experience mixing locks like this. Is it safe to mix
and match rtnl and RCUs like this?

I have the impression that, when iterating a RCU protected list *without* being in the read-side
critical sections, the RCU doesn't know that someone might be traversing
the list, and remove the element mid air (mroute_clean_tables()?). Is
this model incorrect?

> Then later we can remove RTNL from these dump operations.

Do you mean that, execute the dump operation without holding the RTNL,
thus, relying solely on RCU?

> diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
> index 271dc03fc6dbd9b35db4d5782716679134f225e4..f0af12a2f70bcdf5ba54321bf7ebebe798318abb
> 100644
> --- a/net/ipv4/ipmr_base.c
> +++ b/net/ipv4/ipmr_base.c
> @@ -310,7 +310,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
>         if (filter->filter_set)
>                 flags |= NLM_F_DUMP_FILTERED;
> 
> -       list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list) {
> +       list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
> +                               lockdep_rtnl_is_held()) {
>                 if (e < s_e)
>                         goto next_entry;
>                 if (filter->dev &&

Clarifying next steps: Would you like me to review/test and submit, or
are you planning to send it officially?

Thanks for your feedback,
--breno

