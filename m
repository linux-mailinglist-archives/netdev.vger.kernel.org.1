Return-Path: <netdev+bounces-133132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA5995162
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCF3B26458
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96F1DF985;
	Tue,  8 Oct 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaNL9cxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD541DF25E
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396954; cv=none; b=W7iFveHyNs8fvdhrHoLS43CLS0HZn801lvvzC1FjyHWj9tgzLsckrEFtRhBQ4UbLdyEGA8YDmQERfaDhEUifMaLVO7kyIY6EXLWD4HWVLHbCLGeBaikAAAIUrSptYohHKwmccuQeFidc+b7RIIcS6TuxO3U5JPYEGyk9k4JC/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396954; c=relaxed/simple;
	bh=gkeeqDTDDubVJYRwtdiPdEysGDVPCBeFN0D6UddIiJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfTrS9axNIlpR7iGSYixsPLqUOcc78NsGGdTYltTMIpoXMyRDLkdrEOg6Cnlec0e30+mRcnMW+VAKlp7CfIsYIF2J0hA/ZyZrci4+q6/fSc4MtG5gZzg6X7TJwL+4gLEo5GwaSrN19ZYb3uK7ZnOYHT/odCk2fHiEYS3uk2rW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaNL9cxv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53992157528so6070196e87.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728396951; x=1729001751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iodlSeFvKO9O9lc2vubxBeazS52YJzq6TJTLiQpLA28=;
        b=kaNL9cxvGS62DZ31csoImPqpaykkWMhZZPyTNLbmGvMLarHXBBJDZI18d7C0ptd5Cx
         JCOEjN4QAFLyy743c29J86T/qGY+xcjAM0aZ/L4O1MFsdz7FKLBKibBgKIWj+E0RKMFe
         stpszTjXh2sFW/nFzwnt4FtI1sfhCV516+xUq5gJf7G7jPl928za9u3FvWnXzavOw7vY
         74yukO27yZwU14r/QToIcpquTXHInxz1sVCON+RcpYM8hzPzMLfyFWvGiwiOuuuW/RZY
         tOJe6gI9/3Tml5FkN2t2oGjwmFwxx/CQzDG/Jkt/CWF/vEXV8GpfKBAipnW9yK8vk9Zv
         /PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396951; x=1729001751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iodlSeFvKO9O9lc2vubxBeazS52YJzq6TJTLiQpLA28=;
        b=UD+Y2Qbti0SB4McZ2ktmmh9pDILcPC4GRiiu9UsqZ1QGWY22jU9HowK1qe5Xv58sZV
         whDOISlLN17qzFoCa6B++5UYW01aaYEVYN//BffS44+aSgtQS/sXmsnCkVOkRuk5SOP7
         7EltyXUZdHSSkC7FZXZ/5WNena9HTd1EPjVHIQyUusx1aj3NfJzDKeGZ8hYdP6dbAmUG
         RT5C5/hlFxxE7tR+7khL3DaXLy4QiMOl/FZFzkoST5uGGavV/9YtSWNUXMRB4Bmqc3w9
         f/Uys1DxpdtvQOkjBqgJceFvSpMaanmXx6IU4a4miNTMnWvDj5diUUIn8OEdoAW+peqV
         dM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXH06Q3oCjmA01aTZC7I0Rf1DZJUoMsQH8iGiTS3Mbtnw7vktjruhIBWqzqv5/yJVPiocakaeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vWox0po1e1VPcOsGfPZPppceGv18bnxeuiX9RlT2qaXxD3QZ
	YutGn8KNnF/mu3qec2Q2QrwZ6E6qToD7puTlD9sRxMVbIqahX9dEYmG/Z1fvS7TYGQZdmVWcMl4
	EC2rpZ2lINeRIPmnuxjJx2GPnOXIf77uGs9+I
X-Google-Smtp-Source: AGHT+IF3JZ0aU7P3DH+wfLO5j082Jriq88QMvx27KyZ0zh69K7klO4Qc/o+LBXdGIVCAlvjZnmQ0NSdIIQFlIkL0EE0=
X-Received: by 2002:a05:6512:33d0:b0:533:cf5a:eb32 with SMTP id
 2adb3069b0e04-539ab8741c0mr8296779e87.19.1728396950549; Tue, 08 Oct 2024
 07:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004162720.66649-1-leitao@debian.org> <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>
 <20241004-straight-prompt-auk-ada09a@leitao> <759f82f0-0498-466c-a4c2-a87a86e06315@redhat.com>
 <ZwU8l8KSnVPIC5yU@gmail.com>
In-Reply-To: <ZwU8l8KSnVPIC5yU@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 16:15:37 +0200
Message-ID: <CANn89iKBzOOMSQv5U8vpRcNtEYmPtOzqOWLxNgyjAnGOC=Bx+A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
To: Breno Leitao <leitao@debian.org>
Cc: Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, rmikey@meta.com, 
	kernel-team@meta.com, horms@kernel.org, 
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 4:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Hello Paolo,
>
> On Tue, Oct 08, 2024 at 12:51:05PM +0200, Paolo Abeni wrote:
> > On 10/4/24 19:37, Breno Leitao wrote:
> > > On Fri, Oct 04, 2024 at 11:01:29AM -0600, David Ahern wrote:
> > > > On 10/4/24 10:27 AM, Breno Leitao wrote:
> > > > > Branch annotation traces from approximately 200 IPv6-enabled host=
s
> > > > > revealed that the 'likely' branch in ip_neigh_for_gw() was consis=
tently
> > > > > mispredicted. Given the increasing prevalence of IPv6 in modern n=
etworks,
> > > > > this commit adjusts the function to favor the IPv6 path.
> > > > >
> > > > > Swap the order of the conditional statements and move the 'likely=
'
> > > > > annotation to the IPv6 case. This change aims to improve performa=
nce in
> > > > > IPv6-dominant environments by reducing branch mispredictions.
> > > > >
> > > > > This optimization aligns with the trend of IPv6 becoming the defa=
ult IP
> > > > > version in many deployments, and should benefit modern network
> > > > > configurations.
> > > > >
> > > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > > ---
> > > > >   include/net/route.h | 6 +++---
> > > > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/include/net/route.h b/include/net/route.h
> > > > > index 1789f1e6640b..b90b7b1effb8 100644
> > > > > --- a/include/net/route.h
> > > > > +++ b/include/net/route.h
> > > > > @@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_fo=
r_gw(struct rtable *rt,
> > > > >         struct net_device *dev =3D rt->dst.dev;
> > > > >         struct neighbour *neigh;
> > > > > -       if (likely(rt->rt_gw_family =3D=3D AF_INET)) {
> > > > > -               neigh =3D ip_neigh_gw4(dev, rt->rt_gw4);
> > > > > -       } else if (rt->rt_gw_family =3D=3D AF_INET6) {
> > > > > +       if (likely(rt->rt_gw_family =3D=3D AF_INET6)) {
> > > > >                 neigh =3D ip_neigh_gw6(dev, &rt->rt_gw6);
> > > > >                 *is_v6gw =3D true;
> > > > > +       } else if (rt->rt_gw_family =3D=3D AF_INET) {
> > > > > +               neigh =3D ip_neigh_gw4(dev, rt->rt_gw4);
> > > > >         } else {
> > > > >                 neigh =3D ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
> > > > >         }
> > > >
> > > > This is an IPv4 function allowing support for IPv6 addresses as a
> > > > nexthop. It is appropriate for IPv4 family checks to be first.
> > >
> > > Right. In which case is this called on IPv6 only systems?
> > >
> > > On my IPv6-only 200 systems, the annotated branch predictor is showin=
g
> > > it is mispredicted 100% of the time.
> >
> > perf probe -a ip_neigh_for_gw; perf record -e probe:ip_neigh_for_gw -ag=
;
> > perf script
> >
> > should give you an hint.
>
> Thanks. That proved to be very useful.
>
> As I said above, all the hosts I have a webserver running, I see this
> that likely mispredicted. Same for this server:
>
>         # cat /sys/kernel/tracing/trace_stat/branch_annotated | grep ip_n=
eigh_for_gw
>          correct incorrect  %        Function                  File      =
        Line
>                0    17127 100 ip_neigh_for_gw                route.h     =
         393
>
> It is mostly coming from ip_finish_output2() and tcp_v4. Important to
> say that these machine has no IPv4 configured, except 127.0.0.1
> (localhost).

Now run the experiment on a typical server using IPv4 ?

I would advise removing the likely() if it really bothers you.
(I doubt this has any impact)

But assuming everything is IPv6 is too soon.

There are more obvious changes like :

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index b6e7d4921309741193a8c096aeb278255ec56794..445f4fe712603e8c14b1006ad4c=
baac278bae4ea
100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -462,7 +462,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff
*skb, struct net *net)
        /* When the interface is in promisc. mode, drop all the crap
         * that it receives, do not try to analyse it.
         */
-       if (skb->pkt_type =3D=3D PACKET_OTHERHOST) {
+       if (unlikely(skb->pkt_type =3D=3D PACKET_OTHERHOST)) {
                dev_core_stats_rx_otherhost_dropped_inc(skb->dev);
                drop_reason =3D SKB_DROP_REASON_OTHERHOST;
                goto drop;
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 70c0e16c0ae6837d1c64d0036829c8b61799578b..3d0797afa499fa880eb5452a0de=
a8a23505b3e60
100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -153,7 +153,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff
*skb, struct net_device *dev,
        u32 pkt_len;
        struct inet6_dev *idev;

-       if (skb->pkt_type =3D=3D PACKET_OTHERHOST) {
+       if (unlikely(skb->pkt_type =3D=3D PACKET_OTHERHOST)) {
                dev_core_stats_rx_otherhost_dropped_inc(skb->dev);
                kfree_skb_reason(skb, SKB_DROP_REASON_OTHERHOST);
                return NULL;

