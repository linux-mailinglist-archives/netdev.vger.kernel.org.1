Return-Path: <netdev+bounces-37458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF77B56E1
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 66C902824BF
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0221D525;
	Mon,  2 Oct 2023 15:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADDC1A5B4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:47:49 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5AAB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:47:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a65f9147ccso2299149466b.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696261666; x=1696866466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Dr0/aNiQI4Em1ZrorNwt0/u5p8fndiqo3UFJMunHNk=;
        b=ay22t8zQnfcJNe/X2txz/MI8uXj+sIr0f0gkEFqbyw5rxF2Lin0TQ6+KJv+hLGVzbf
         B+gsDrqCfYS/h0dm2gB30Zun6R653l56usMT4OPi2M8Tf+URPqc8enYpnbketG9g/+OB
         uUYzIkMFw8Gh50lceHv+4gIuz+iVKl3dQCFOt5C9g9JZRxSsuhoneYpVVkbPYJ/4V7b7
         2q0cFfQeL1BybIbdSCw0q6wUdTBP98rrTVCC2KAb3KKpx1o2zVaLLFFWLSZQWklwNPlg
         pcM9flgDAYX0gVQGZaMqogUzhJJSuliYcNrndKz+YMX7JmJ2rAJK5rEm/Tj8GkPcnGtw
         ZN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261666; x=1696866466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Dr0/aNiQI4Em1ZrorNwt0/u5p8fndiqo3UFJMunHNk=;
        b=lC4YZfEkjhdgU0GBixx+NPkHgp212AJiUyhZ0R8NXB6sky/yoeQK1LWJHL9WNtoxCw
         wczsVS+XL9Lm9yb/0MqDqTpPZr9I9x9rH6s8JL1F3OA8sXjRZGSp+e3qCp7o10aoIr0u
         0OrkI+45Ywh0v8khhmyr5bpAwayeMH9/DVEUImkpn/fawBhQ2wG4DloP0iWJp1TtMYJm
         Xeckz5QpTJNPQMgTHErhqtahe6hZtjIhLUnZQ9QRFH5kKzSValz7e3L3OnWq8y1mANHv
         ZDy4P+6UEJrQFej0j1ok42avznvH9YBgaxIsELxXGNr+JvnLsjNQLhbnMPHHdCMCYjLz
         l1pQ==
X-Gm-Message-State: AOJu0YxRVPXKzGPHvXWiWBfXI79Be7T8huOHF6GheqjD8bweTGDSgxVM
	x0VfPMzE2cKqtYL1viaaUZvvzQn/9jN6wp5Xc37YCQ==
X-Google-Smtp-Source: AGHT+IFYw9Ja7M6CghpqmVO82gargoGnbUAp66cbbj1VCMqa7HGn8uqDVxGHv0oSInaQoq+SOZ42MiPAt+qVkyed4ls=
X-Received: by 2002:a17:906:29e:b0:9b0:552c:b36c with SMTP id
 30-20020a170906029e00b009b0552cb36cmr11383660ejf.21.1696261666152; Mon, 02
 Oct 2023 08:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZRcOXJ0pkuph6fko@debian.debian> <20230930110854.GA13787@breakpoint.cc>
In-Reply-To: <20230930110854.GA13787@breakpoint.cc>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 2 Oct 2023 10:47:35 -0500
Message-ID: <CAO3-Pbp2onn+EUhKRrB5an_tyzLcaH+1FUqrThsxXqqpBAxshA@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 6:09=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Yan Zhai <yan@cloudflare.com> wrote:
> > GSO packets can contain a trailing segment that is smaller than
> > gso_size. When examining the dst MTU for such packet, if its gso_size
> > is too large, then all segments would be fragmented. However, there is =
a
> > good chance the trailing segment has smaller actual size than both
> > gso_size as well as the MTU, which leads to an "atomic fragment".
> > RFC-8021 explicitly recommend to deprecate such use case. An Existing
> > report from APNIC also shows that atomic fragments can be dropped
> > unexpectedly along the path [1].
> >
> > Add an extra check in ip6_fragment to catch all possible generation of
> > atomic fragments. Skip atomic header if it is called on a packet no
> > larger than MTU.
> >
> > Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1=
]
> > Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 pr=
ocessing")
> > Reported-by: David Wragg <dwragg@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/ipv6/ip6_output.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index 951ba8089b5b..42f5f68a6e24 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -854,6 +854,13 @@ int ip6_fragment(struct net *net, struct sock *sk,=
 struct sk_buff *skb,
> >       __be32 frag_id;
> >       u8 *prevhdr, nexthdr =3D 0;
> >
> > +     /* RFC-8021 recommended atomic fragments to be deprecated. Double=
 check
> > +      * the actual packet size before fragment it.
> > +      */
> > +     mtu =3D ip6_skb_dst_mtu(skb);
> > +     if (unlikely(skb->len <=3D mtu))
> > +             return output(net, sk, skb);
> > +
>
> This helper is also called for skbs where IP6CB(skb)->frag_max_size
> exceeds the MTU, so this check looks wrong to me.
>
> Same remark for dst_allfrag() check in __ip6_finish_output(),
> after this patch, it would be ignored.
>
Thanks for covering my carelessness. I was just considering the GSO
case so frag_max_size was overlooked. dst_allfrag is indeed a case
based on the code logic. But just out of curiosity, do we still see
any use of this feature? From commit messages it is set when PMTU
values signals smaller than min IPv6 MTU. But such PMTU values are
just dropped in __ip6_rt_update_pmtu now. Iproute2 code also does not
provide this route feature anymore. So it might be actually a dead
check?

> I think you should consider to first refactor __ip6_finish_output to make
> the existing checks more readable (e.g. handle gso vs. non-gso in separat=
e
> branches) and then add the check to last seg in
> ip6_finish_output_gso_slowpath_drop().
>
Agree with refactoring to mirror what IPv4 code is doing. It might not
hurt if we check every segments in this case, since it is already the
slowpath and it will make code more compact.

> Alternatively you might be able to pass more info down to
> ip6_fragment and move decisions there.
>
> In any case we should make same frag-or-no-frag decisions,
> regardless of this being the orig skb or a segmented one,

