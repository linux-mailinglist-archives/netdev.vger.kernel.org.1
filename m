Return-Path: <netdev+bounces-129187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2026997E27F
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF0AB20B00
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5202224CF;
	Sun, 22 Sep 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fscYTD1a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C351A276;
	Sun, 22 Sep 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023030; cv=none; b=eg0UDlCTDBD+SNAWpjnT79fa7b0G38pWJTR/al48UIzc0wsXKF4eTK7pltcctutZeItM+6EeZzP9Q+Xx2ltpnBFeITHwZukGXpb2hMbUGO55MCNv0ib6SoDGJXVZnZ02GMdKfh3S+dHI1zNCDyJoEwefCCDbMLBaAV2la19e9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023030; c=relaxed/simple;
	bh=2h3ei6zftQuBmQ0I+E0cKBnkAQjaBy7aTusBzbkRH6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFvAMYpy7TH4hn1JSWNHcEIaZGs+y8vbjfacWTM37AFWastSDwVcs3SV2/JfIIXO+pm1SwtWVWOk9rTkpMQFmtbu8xMg0sL50e4voYMEgV7/aJL5x+WVT2HEW6SnynzJLScUbhyrgBtMs7G0IryuAVos67HmlkKx4TaOQLj9mlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fscYTD1a; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dfff346a83so14845697b3.2;
        Sun, 22 Sep 2024 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727023028; x=1727627828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk4nn0/HyHG6Gk+EntBjrDOYb01okZCkmJxS19ZjQ9I=;
        b=fscYTD1a2Z0EPxdprCev/g3ALhc2hfQBCHZBZ+KlwkIzE3AeIajkfBKnsSoZutvUDC
         qjvI4N1tDkVPFo/nzuzylzodttQ2zDXdt+qwtRa6j7ATJYA0MfoH79CVvVyY41JX6ZrT
         KstdA9YwNXZ3o2l3uWpT0VcFFeN3663N3NhxeWiuVuF9n+pX35+9XwWTzc1ycc1Mdq0/
         t93ac2WdXsL0rrIzv0dGaEdudmQrlUhKDgi4e5NaWNtdxbk9Y0yKfGZUHpjwMVlADCAE
         gSM4M4caqnNyfHUvHw3v0T2vt26IPx2lcgAqeGivrKeLiN6410YvGbd66wEDRXYQH12o
         ngag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727023028; x=1727627828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dk4nn0/HyHG6Gk+EntBjrDOYb01okZCkmJxS19ZjQ9I=;
        b=wtRr4kfVFSubaS92T5F79RuffCx4XhwpD4NX2+b8+7hZeAIf/gwmH/8l2eoGQr/Y63
         yDCCjdWOecS4Eu05CKH1Mzhiskmm2qrXVF7S2WGJt4pAE8nb4EW+zN10aBam/H/qPNdg
         yoOqmq5EflYtbexeycf62qgaG3WUyn+BGE7hSEoan2YxWq0wptznUl/rWdVwzVuIszDO
         n2vzt9kG4uHZlEbaVk3iY6CRPaXutGsmmtRrUD4A/PnbbEiVj7EctUturRKG24OJNPhN
         alKgW+y83UZS9fiRwnqobddYbIOaB9dPVra5fMJ54qvVNMPxbRTZgq7bOC6X/t4Ywfd5
         tf6A==
X-Forwarded-Encrypted: i=1; AJvYcCWENyl9bUBdLgfjI4I5XTtNX/aDRfilLSEqE+/UZNBi7UNxxGK0Li4/umQsTGBm4HyDtWui/sA3@vger.kernel.org, AJvYcCWQOhhHtQwPvNyBzf35rr76cXZ9iopvflC6S/nLtkFSl4FH5BHxT1D+V283jObrRC48fIxPQdgZMgkJSGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XuZDppbOm0gBAHZqGymONvs9TKN//q1xhohgiLeKl/dk5U4s
	fTID/2l2eq+/YiRwqNFjKZCmq+mro+rqSeqPwO4kmL5yYY/4zeqpZQjiUu6mmuCbJiufn3MWqOn
	pPAI8VQ5jV1fW6bej/wAbSalkh3A=
X-Google-Smtp-Source: AGHT+IFqnHGUJF1Nyj7wVZKVezpjSeBoZSQx/lJIE7+rg0Kzv64e+g2HfXTZUtL+YChlO08/yKNgu/v1cjlr2KxGx+0=
X-Received: by 2002:a05:6902:2e0d:b0:e1a:8857:96dd with SMTP id
 3f1490d57ef6-e2250c47473mr6815609276.31.1727023027888; Sun, 22 Sep 2024
 09:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912141440.314005-1-guyavrah1986@gmail.com> <49d32698-e226-46b5-bee8-46e9aad5754b@redhat.com>
In-Reply-To: <49d32698-e226-46b5-bee8-46e9aad5754b@redhat.com>
From: Guy Avraham <guyavrah1986@gmail.com>
Date: Sun, 22 Sep 2024 19:36:57 +0300
Message-ID: <CAM95viENqpHeyVmTZ9TgBZgw7eG7Ox8GE6ybARny659+PVPPmw@mail.gmail.com>
Subject: Re: [PATCH net] net:ipv4:ip_route_input_slow: Change behaviour of
 routing decision when IP router alert option is present
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your response and inputs!

Please consider the following:

1. Regarding the  check  of IP forwarding enabled - totally agree, I
forgot to add it.

2. About the validation that someone has registered to receive router
alerts - as
far as I understand, this check is done in the ip_call_ra_chain
function - if indeed
there is no one interested in receiving IP packets with the IP router
alert option, then
this function will return false (and do nothing essentially), so
calling it directly should
be OK.

3. About calling the ip_call_ra_chain function directly in place - I
also agree but what
I am missing is how to set the rth->dst.input in this case?
- ip_forward is not relevant (we eliminated, wisely, the need to call
it once the ip_call_ra_chain
is to be invoked directly).
- ip_local_deliver is not needed (the packet was already
consumed by the relevant recipient - the socket that registered for
the IP router alert).
- ip_error is also not needed because sending an ICMP error packet is
not exactly what is needed in this case (at least not for the use case
I refer to in which the IP packet holds an RSVP message).
It leaves the "option" of (whether or not the ip_call_ra_chain was
successful or not, i.e. -
it returned true/false) returning NET_RX_DROP --> this way when the
flow unfolds all the
way back to the ip_rcv_finish function, the dst.input function pointer
won't be invoked (in the line
ret =3D dst_input(skb);)
One thing about it, is whether or not it is "fine" for the function
further back in the flow
of the packet reception (netif_rx,etc...) to receive this value
(NET_RX_DROP and not NET_RX_SUCCESS), even though the packet was
consumed eventually.

4. In the specific use case I am talking about the host is a router
which is not an AS border router.
About the blackhole - it is not what I need to achieve. In my case I
do wish that the IP packet will
arrive to the relevant socket (of the RSVP daemon), but because the
host that received the IP packet with the IP router alert does not
have a route to the destination IP, the flow terminates without going
through the ip_call_ra_chain (which is done only in the ip_forward
function later on).
I can elaborate more on this specific use case if needed (it has to do
with the way OSPF and RSVP work).

Appreciate your response,
Guy.


On Thu, Sep 19, 2024 at 1:06=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 9/12/24 16:14, Guy Avraham wrote:
> > When an IP packet with the IP router alert (RFC 2113) field arrives
> > to some host who is not the destination of that packet (i.e - non of
> > its interfaces is the address in the destination IP address field of th=
at
> > packet) and, for whatever reason, it does not have a route to this
> > destination address, it drops this packet during the "routing decision"
> > flow even though it should potentially pass it to the relevant
> > application(s) that are interested in this packet's content - which hap=
pens
> > in the "forwarding decision" flow. The suggested fix changes this behav=
iour
> > by setting the ip_forward as the next "step" in the flow of the packet,
> > just before it (previously was) is dropped, so that later the ip_forwar=
d,
> > as usual, will pass it on to its relevant recipient (socket), by
> > invoking the ip_call_ra_chain.
> >
> > Signed-off-by: Guy Avraham <guyavrah1986@gmail.com>
> > ---
> > The fix was tested and verified on Linux hosts that act as routers in w=
hich
> > there are kerenls 3.10 and 5.2. The verification was done by simulating
> > a scenario in which an RSVP (RFC 2205) Path message (that has the IP
> > router alert option set) arrives to a transit RSVP node, and this host
> > passes on the RSVP Path message to the relevant socket (of the RSVP
> > deamon) even though upon arrival of this packet it does NOT have route
> > to the destination IP address of the IP packet (that encapsulates the
> > RSVP Path message).
> >
> >   net/ipv4/route.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index 13c0f1d455f3..7c416eca84f8 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2360,8 +2360,12 @@ out:   return err;
> >
> >       RT_CACHE_STAT_INC(in_slow_tot);
> >       if (res->type =3D=3D RTN_UNREACHABLE) {
> > -             rth->dst.input=3D ip_error;
> > -             rth->dst.error=3D -err;
> > +             if (IPCB(skb)->opt.router_alert)
> > +                     rth->dst.input =3D ip_forward;
> > +             else
> > +                     rth->dst.input =3D ip_error;
> > +
> > +             rth->dst.error =3D -err;
> >               rth->rt_flags   &=3D ~RTCF_LOCAL;
> >       }
> >
>
> I think this is not the correct solution. At very least you should check
> the host is actually a router (forwarding is enabled) and someone has
> registered to receive router alerts. At that point you will be better
> off processing the router alert in place directly calling
> ip_call_ra_chain().
>
> However I'm unsure all the above is actually required. It can be argued
> your host has a bad configuration.
>
> If it's a AS border router, and there is no route for the destination,
> the packet not matching any route is invalid and should be indeed
> dropped/not processed.
>
> Otherwise you should have/add a catch-up default route - at very least
> to handle this cases. If you really want to forward packets only to
> known destination, you could make such route as blackhole one.
>
> Cheers,
>
> Paolo
>

