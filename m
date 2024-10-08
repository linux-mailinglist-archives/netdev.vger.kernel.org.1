Return-Path: <netdev+bounces-133163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7A995255
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B04E1F26148
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914321DFE36;
	Tue,  8 Oct 2024 14:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F38A18CBED;
	Tue,  8 Oct 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398945; cv=none; b=ZmwTpLDww2J55lDQBXib+zzHrFjysCgzAyjAG0wNqvB/nXIFpN2Sz9QQz1mIVICses4Qi2IWw+16ZmGxbPOhEXICgig6CWdnhEzIpLMPbARvnk2KV9dJDSuBB+G7KTtM3+AlStDuwvbc/3RH5CtPa6RSgW2NH1geiiQ1E82VH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398945; c=relaxed/simple;
	bh=XKowxwTPMI21GpoEJnctf3c/oGvqsrrVGpbwFNyfq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcs0DxUJ5L0RUfPis5Oh3VT/mpLJz/0O5xsU1h3iWZ29t9A6WaM8hVYtO3WtcLDxlUhGZcQcy/rO/yPmiz1yeRdxMN9HE0uVxvF0TfUAQsJ4VGW5SfFLF5LdRFqcnljJXjTL5+b3J0st+ZqVVmhy2bnemiQwBEHgroR24cuiI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c91756c9easo571110a12.1;
        Tue, 08 Oct 2024 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398942; x=1729003742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxVRdComUo2k6leQZfyiZWZY58sZ35wB+q5/Ll7FGvE=;
        b=YRo6/ramJPrMQipRp5MG9utorKaGOfRwGk9riqMNXhBDQc8zHnzD+KmCRKUEpMeTgX
         It7+qgzUTzULfv/8qLCfIxpABsKqlawKxy8luWJoC3yMV1tIZeJvbU39Zeb11DDluits
         vt/Ez9N2dvebgMqXQ3+XKRb60kSJPOpw0g3Wb4CYUwg3Xo3ZfbryyLoibYSygUELqZMl
         IxNtbX73XegyKGzMH+a/37PB4ZSreOum0Dg33DfJcFtGjg3UzcUtWplejITcMIngWGDy
         OxTpMK4Y2QXLhvyWdiiRMSN+LwRmDFKV/aAfocE4mCCaY6GHzoSQ5tTjgjyMV+c0Wc6o
         1C6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiqSPbrV4l76+nrdYD+4z9F8aRgUB/Q18nXhAja6EYwiM+Dl5RjpZY8EtogS3m+W+Joqkx858MNOn5g8Y=@vger.kernel.org, AJvYcCVXhsHYbPpU2S/iC7iO1SxKrvG1QNxWNJIMiNMmQj1D2FCRa5NFDMKzA13zMD623+oIQEQDDdTN@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmEg5cSfxidfohS8Uoe/PlY2V59w8YJYeLAr9gdjntr4d2pAL
	uLuibuqhdC/E50ulUzI2xR0u75oB5YqStpMFx3o2eYqadm/9dwO1
X-Google-Smtp-Source: AGHT+IGmhSJudwI/2rA5wyGGws8Vw5QBROVXlUHYPBQ0FsaXq/rDvfF4EhmocfeynIL42e4sg0wsMA==
X-Received: by 2002:a17:907:7ba1:b0:a77:ca3b:996c with SMTP id a640c23a62f3a-a99847176e5mr42406666b.16.1728398941606;
        Tue, 08 Oct 2024 07:49:01 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::7:e36b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7e18a2sm516190966b.188.2024.10.08.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:49:01 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:48:59 +0100
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, rmikey@meta.com,
	kernel-team@meta.com, horms@kernel.org,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
Message-ID: <ZwVGW7FexXBNm_8F@gmail.com>
References: <20241004162720.66649-1-leitao@debian.org>
 <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>
 <20241004-straight-prompt-auk-ada09a@leitao>
 <759f82f0-0498-466c-a4c2-a87a86e06315@redhat.com>
 <ZwU8l8KSnVPIC5yU@gmail.com>
 <CANn89iKBzOOMSQv5U8vpRcNtEYmPtOzqOWLxNgyjAnGOC=Bx+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKBzOOMSQv5U8vpRcNtEYmPtOzqOWLxNgyjAnGOC=Bx+A@mail.gmail.com>

Hello Eric,

On Tue, Oct 08, 2024 at 04:15:37PM +0200, Eric Dumazet wrote:
> On Tue, Oct 8, 2024 at 4:07 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Paolo,
> >
> > On Tue, Oct 08, 2024 at 12:51:05PM +0200, Paolo Abeni wrote:
> > > On 10/4/24 19:37, Breno Leitao wrote:
> > > > On Fri, Oct 04, 2024 at 11:01:29AM -0600, David Ahern wrote:
> > > > > On 10/4/24 10:27 AM, Breno Leitao wrote:
> > > > > > Branch annotation traces from approximately 200 IPv6-enabled hosts
> > > > > > revealed that the 'likely' branch in ip_neigh_for_gw() was consistently
> > > > > > mispredicted. Given the increasing prevalence of IPv6 in modern networks,
> > > > > > this commit adjusts the function to favor the IPv6 path.
> > > > > >
> > > > > > Swap the order of the conditional statements and move the 'likely'
> > > > > > annotation to the IPv6 case. This change aims to improve performance in
> > > > > > IPv6-dominant environments by reducing branch mispredictions.
> > > > > >
> > > > > > This optimization aligns with the trend of IPv6 becoming the default IP
> > > > > > version in many deployments, and should benefit modern network
> > > > > > configurations.
> > > > > >
> > > > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > > > ---
> > > > > >   include/net/route.h | 6 +++---
> > > > > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/include/net/route.h b/include/net/route.h
> > > > > > index 1789f1e6640b..b90b7b1effb8 100644
> > > > > > --- a/include/net/route.h
> > > > > > +++ b/include/net/route.h
> > > > > > @@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_for_gw(struct rtable *rt,
> > > > > >         struct net_device *dev = rt->dst.dev;
> > > > > >         struct neighbour *neigh;
> > > > > > -       if (likely(rt->rt_gw_family == AF_INET)) {
> > > > > > -               neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> > > > > > -       } else if (rt->rt_gw_family == AF_INET6) {
> > > > > > +       if (likely(rt->rt_gw_family == AF_INET6)) {
> > > > > >                 neigh = ip_neigh_gw6(dev, &rt->rt_gw6);
> > > > > >                 *is_v6gw = true;
> > > > > > +       } else if (rt->rt_gw_family == AF_INET) {
> > > > > > +               neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> > > > > >         } else {
> > > > > >                 neigh = ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
> > > > > >         }
> > > > >
> > > > > This is an IPv4 function allowing support for IPv6 addresses as a
> > > > > nexthop. It is appropriate for IPv4 family checks to be first.
> > > >
> > > > Right. In which case is this called on IPv6 only systems?
> > > >
> > > > On my IPv6-only 200 systems, the annotated branch predictor is showing
> > > > it is mispredicted 100% of the time.
> > >
> > > perf probe -a ip_neigh_for_gw; perf record -e probe:ip_neigh_for_gw -ag;
> > > perf script
> > >
> > > should give you an hint.
> >
> > Thanks. That proved to be very useful.
> >
> > As I said above, all the hosts I have a webserver running, I see this
> > that likely mispredicted. Same for this server:
> >
> >         # cat /sys/kernel/tracing/trace_stat/branch_annotated | grep ip_neigh_for_gw
> >          correct incorrect  %        Function                  File              Line
> >                0    17127 100 ip_neigh_for_gw                route.h              393
> >
> > It is mostly coming from ip_finish_output2() and tcp_v4. Important to
> > say that these machine has no IPv4 configured, except 127.0.0.1
> > (localhost).
> 
> Now run the experiment on a typical server using IPv4 ?
> 
> I would advise removing the likely() if it really bothers you.
> (I doubt this has any impact)

Thanks. I am mostly concerned about likely/unlikely() that are wrong
100% the time when running production workloads in modern hardware.

I just got a few hundreds host to able to run annotated
branches enabled, and I am looking on how it can help us to understand
our code flow better.

Regarding performance impact, I agree with you that performance is
minimal (at least on x86). On other architectures, such as powerpc
things can be more evident, given that the branch hint is encoded in the
instruction itself, so, the hardware knows where to predict.

That said, I think the best approach is just to remove the likely() from
that code path.

> But assuming everything is IPv6 is too soon.
> 
> There are more obvious changes like :
> 
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index b6e7d4921309741193a8c096aeb278255ec56794..445f4fe712603e8c14b1006ad4cbaac278bae4ea
> 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -462,7 +462,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff
> *skb, struct net *net)
>         /* When the interface is in promisc. mode, drop all the crap
>          * that it receives, do not try to analyse it.
>          */
> -       if (skb->pkt_type == PACKET_OTHERHOST) {
> +       if (unlikely(skb->pkt_type == PACKET_OTHERHOST)) {
>                 dev_core_stats_rx_otherhost_dropped_inc(skb->dev);
>                 drop_reason = SKB_DROP_REASON_OTHERHOST;
>                 goto drop;
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index 70c0e16c0ae6837d1c64d0036829c8b61799578b..3d0797afa499fa880eb5452a0dea8a23505b3e60
> 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -153,7 +153,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff
> *skb, struct net_device *dev,
>         u32 pkt_len;
>         struct inet6_dev *idev;
> 
> -       if (skb->pkt_type == PACKET_OTHERHOST) {
> +       if (unlikely(skb->pkt_type == PACKET_OTHERHOST)) {
>                 dev_core_stats_rx_otherhost_dropped_inc(skb->dev);
>                 kfree_skb_reason(skb, SKB_DROP_REASON_OTHERHOST);
>                 return NULL;

Agree, that would be obvious changes also.

