Return-Path: <netdev+bounces-142832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A181C9C0701
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C22282C8F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC6120FAA1;
	Thu,  7 Nov 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzMhYrP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D25201034
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985209; cv=none; b=s3vqPz9cIzq/nohA3rY74AtP6yhb/lrJwuFPdIDxX2o8F3VMzYEj6/toxmugPe65HDKKfQx7LTliC9XvrLh66AE4Mm1bhYdH7BNmoV9DOzTBXJiy0mudCFhLuUp46VhL6Mph7XIGexyusUAdjp00XYhuOyCZrLgKrPcCtFNmOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985209; c=relaxed/simple;
	bh=uWk5CDbKBE+0Upzlu5L9d69lbRYzU7Rb2/U6YK53UL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQgz8ia5rWHixqvCjoLvTCqI4DoXxe3Mvdfkl10Z4bckOwPv/8l7d1h67dusNT3RuKdxoQ/T3+52DVQ7lavXXCK+S5b7TRxHSap8boZgWCBCjsC4C3AS121Fd+3Xt5Kg6sYZWB/W+/njUgT4SutWi1BMWEIg/KOHCaRXykdsd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzMhYrP/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso3567438a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730985206; x=1731590006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkRFP/ItFb5WDAzbU2gxOOSb/gxt1VwIrm9lhX+SPlw=;
        b=IzMhYrP/ygaHO6m6xVpnUWuu2EwnPxEUp5AQic6syq52AsYX2ELRjPJo4ZojE3gSxJ
         cMgKGl6OXRZz1dnCpwgRiVEc/9hFhnrRcmBlWK5DJ5EPwFtUxvG7Cfoshp1+wWmUhSb6
         qH09dL/cCsPxiVgX9C5+mVt9ZA/Dxv2EYZyyo8QQP9dXA4j71DYDJ+EbQxejmynOZM+1
         Vgh1R6wKsQACgA+iMJPU9H6FAGyu1dhllwMwaFr7tH5HAI6aInmKAfupH0ZZYj38h3Ul
         ebqEBh/p05eGAgpWhXHeM0uiCdqj1WdpHRmjId38GNoNnloHzrg+5UESBowAOjTwopG3
         dg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985206; x=1731590006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkRFP/ItFb5WDAzbU2gxOOSb/gxt1VwIrm9lhX+SPlw=;
        b=QP69qUhoy/M8bfyDsrt3JkViFGiwxm7z1Ho56+Ab4uVCmyHAhy+3bgZrWYVVVA0LoW
         w0RtB1yStV9KYHNpx50xtHrqxmaxZHwkjbZ3/reFxPnmTevnlOa8HhQp4F+LJ+Mh0Pfq
         7ICTpzyRZuI0+MIeD4YfNRlJlMabYM0+RVtwcEIGHVDfwlDYc4GrzOzC7ENg2jOkdi1w
         mxMWuUk8qHFtH9xDAH/lUs42Gmdo9BdAqS9wW0euTBhES3UuSjR8sRUwtgygy2UxeAJb
         frgvnsCMw5jJaMkQIMhInADTxDWYzOTv3U4rmJQt7+p28ac6GEtZPPLvdtfGsB5TMvYT
         QEHw==
X-Forwarded-Encrypted: i=1; AJvYcCUJdEJaogTR5QRthVWys6Qe9C3+Z7KyAiXXFT4xJD1p7R34ag4kmNeOA+6Ty9B3S98vz7JkPEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uYogVGGpzEOyH8GrYVI8Q3UvGsdKZmBLJeirRjyUeJFIrdQP
	Lz7jCj12gk2j4wzWUD5MRhvFzpFYo+sv24lUezRlo+WPtza5GdL2V+4nTJCMgeBTDEZyUo5tmUg
	98mwMVrSbylaA8vVk/eT9fjdL2uE6pojAgqKS
X-Google-Smtp-Source: AGHT+IHGLBexlZAWpgdsFS22YeIWuGJCQgULOCsTd82+PRJkPntMbA/+HK9VSU+CXKZJE9w3KwQbyR4uRXuPPEPh9MQ=
X-Received: by 2002:a50:fa91:0:b0:5cf:6b5:ea29 with SMTP id
 4fb4d7f45d1cf-5cf06b5ea8bmr730455a12.0.1730985205646; Thu, 07 Nov 2024
 05:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org>
In-Reply-To: <20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 14:13:14 +0100
Message-ID: <CANn89iL-L8iBwp=rq-YwAeeoUY2MTjr5akWm=S=k7ckpkaEy+Q@mail.gmail.com>
Subject: Re: [PATCH net] ipmr: Fix access to mfc_cache_list without lock held
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:03=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> following code flow, the lock is not held, causing the following error
> when `RCU_PROVE` is not held.
>
>         6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G           =
 E    N
>         -----------------------------
>         net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader section=
!!
>
>         rcu_scheduler_active =3D 2, debug_locks =3D 1
>                    2 locks held by RetransmitAggre/3519:
>                     #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}=
, at: __netlink_dump_start+0x8a/0x290
>                     #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at: rt=
nl_dumpit+0x6b/0x90
>
>         stack backtrace:
>                     lockdep_rcu_suspicious
>                     mr_table_dump
>                     ipmr_rtm_dumproute
>                     rtnl_dump_all
>                     rtnl_dumpit
>                     netlink_dump
>                     __netlink_dump_start
>                     rtnetlink_rcv_msg
>                     netlink_rcv_skb
>                     netlink_unicast
>                     netlink_sendmsg
>
> Fix accessing `mfc_cache_list` without holding the RCU read lock. Adds
> `rcu_read_lock()` and `rcu_read_unlock()` around `mr_table_dump()` to
> prevent RCU-list traversal in non-reader section.
>
> Since `mr_table_dump()` is the only function that touches the list, that
> might be the only critical section in `ipmr_rtm_dumproute()` that needs
> to be protected in ipmr_rtm_dumproute().
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: cb167893f41e ("net: Plumb support for filtering ipv4 and ipv6 mult=
icast route dumps")
> ---
>  net/ipv4/ipmr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 089864c6a35eec146a1ba90c22d79245f8e48158..bb855f32f328024f384a2fa58=
f42fc227705206e 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2612,8 +2612,10 @@ static int ipmr_rtm_dumproute(struct sk_buff *skb,=
 struct netlink_callback *cb)
>                         NL_SET_ERR_MSG(cb->extack, "ipv4: MR table does n=
ot exist");
>                         return -ENOENT;
>                 }
> +               rcu_read_lock();
>                 err =3D mr_table_dump(mrt, skb, cb, _ipmr_fill_mroute,
>                                     &mfc_unres_lock, &filter);
> +               rcu_read_unlock();
>                 return skb->len ? : err;
>         }
>
>

What about net/ipv6/ip6mr.c ip6mr_rtm_dumproute() ?

In my opinion, since we still hold RTNL in these paths, we should
change the lockdep annotation.

Then later we can remove RTNL from these dump operations.

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 271dc03fc6dbd9b35db4d5782716679134f225e4..f0af12a2f70bcdf5ba54321bf7e=
bebe798318abb
100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -310,7 +310,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff =
*skb,
        if (filter->filter_set)
                flags |=3D NLM_F_DUMP_FILTERED;

-       list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list) {
+       list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
+                               lockdep_rtnl_is_held()) {
                if (e < s_e)
                        goto next_entry;
                if (filter->dev &&

