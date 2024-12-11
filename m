Return-Path: <netdev+bounces-150926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B549EC1D7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1E1667BA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ADA1DF970;
	Wed, 11 Dec 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="suz7peHI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A71DF756
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882384; cv=none; b=Pl8H1cCat9HIKn+QRghkjEOoNKG7oggaZRjZsXLUr1AHL2XRTGr6mlJphMCMU/dFMSWnXBrB2Y/D3Swkwmp1SZqvVn0PO2RYSFWX2QCg1wLj4pOCs04PKVVDZP8Xq2rg9pMaEoeBkzz30Y4fAefV/7uqDtr6oDKxjLB/ek44w68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882384; c=relaxed/simple;
	bh=LD88v82QkfCwggk5okcRi5JtUxFix0jHDIZBmNPDA88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoxZMoO9OwE3iWVPpx5sSUtz2IETSYk21qWCC5OiBlsQrpnIQKYbh0IttV10t7wPdMyIXGztqV/emK/uK/rEmyczWzVHFUh9lY6Qe07Gpz+UPA1TIQ+IVwiOQWsBFyyIe+JWNem4I033Oqvs5uACkemscXXZz3SYwfOzhnTT/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=suz7peHI; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gOyrZ9mqW6KEpPZEJkgYCk0k8RhPxuOQizgG9bciupM=; t=1733882382; x=1734746382; 
	b=suz7peHIGERuNHS4dPO6XHN4+b/4Y6+E8JiqBbAjlx6Wl80K4j3BdMjZGtfePHwf51MfcUABtLY
	aoeylVUJwI/HuV3Cm2xBNUNauySwELpXMuCBUjhmtIHMuOMELe3LUhtqY/v5KIV+BJo7/JjfSviY5
	3Q41Pugo/e+KFhJOnXZyCi3pPGzf6k4/2JDidVYEuuqD6NGIVhYZruaphddPHDXhQYFEbUm2q+K+P
	pp4BNuMWXCJEu3XOCklxKYDfGcfwavUAOQUdIlqms0iaPXxgZyALmaRQK0XhfwYrP7S8w+SdgwGtY
	1DubKNORfG5DM+oud8Wm4MxEexKq0/sdY5FQ==;
Received: from mail-ot1-f44.google.com ([209.85.210.44]:50598)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tLC0l-0003n6-SQ
	for netdev@vger.kernel.org; Tue, 10 Dec 2024 17:59:36 -0800
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e15d9629bso196347a34.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:59:35 -0800 (PST)
X-Gm-Message-State: AOJu0Yw7q8U1BLOu8IrYEPakuQecSCe3U4Ae9O+mJSM2IIbB0OX2rnqk
	/ARQCpQQSyg1q6dILztsjyTNMcqvzyJH3Lm2D06daDVFgwDE4+7lmAFJceLch/N+1Pxf+9fh9B0
	Jf7RylwTXmRwrrag9dBx0UGFw5Jw=
X-Google-Smtp-Source: AGHT+IFIxI8C6qY7rhofgrQhdWTHYPFwrVOQccaFBWFpiMFa9XoIsGJATiv3FV27rcrrV0/yqA6OjPpte6ZONg+O2gA=
X-Received: by 2002:a05:6870:d1c1:b0:29e:6547:bffa with SMTP id
 586e51a60fabf-2a012e22863mr724290fac.21.1733882375184; Tue, 10 Dec 2024
 17:59:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-13-ouster@cs.stanford.edu>
 <20241210060834.GB83318@j66a10360.sqa.eu95>
In-Reply-To: <20241210060834.GB83318@j66a10360.sqa.eu95>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 10 Dec 2024 17:59:00 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxbv=0Aw61cfOg+mtcrheV7y3db7xYcwTOfjvLYT61P7g@mail.gmail.com>
Message-ID: <CAGXJAmxbv=0Aw61cfOg+mtcrheV7y3db7xYcwTOfjvLYT61P7g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 3c26e552a1044023835a40b863ebedfd

On Mon, Dec 9, 2024 at 10:08=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> > +             if (first_packet)
> > +                     first_packet =3D 0;
> Looks useless.

In the full GitHub version of Homa there is diagnostic code that
executes when first_packet is true; I have a script that automatically
strips out the diagnostic code, but it isn't smart enough to optimize
out the check (and the variable declaration). I refactored the code to
work around the limitations of the stripper, so this code won't appear
in future versions of the patch series.

> > +
> > +             /* Process the packet now if it is a control packet or
> > +              * if it contains an entire short message.
> > +              */
> > +             if (h->type !=3D DATA || ntohl(((struct data_header *)h)
> > +                             ->message_length) < 1400) {
>
> Why 1400? Maybe compare with skb->len?

1400 is a somewhat arbitrary constant to separate short messages from
longer ones; it's roughly one packet. skb->len isn't exactly one
packet either (a packet can't hold quite skb->len of message data, so
this would allow messages longer than one packet to get the fast
path). I could compute *exactly* one packet's worth of data, but
that's a nontrivial calculation and I don't think it's worth either
the code complexity or the runtime. The exact value of the constant
doesn't really matter...

> > +                     if (h2->sender_id =3D=3D h->sender_id) {
> > +                             saddr2 =3D skb_canonical_ipv6_saddr(skb2)=
;
> > +                             if (ipv6_addr_equal(&saddr, &saddr2)) {
>
> Does two skbs with the same ID and source address must come from the
> same RPC? if so, why is there an additional check for dport in
> homa_find_server_rpc().

It used to be that RPC ids were only unique to a port, not to a node;
when I changed Homa to make ids unique within a client node I somehow
forgot to remove the dport argument from homa_find_server_rpc. I have
now removed that argument.

> Anyway, the judgment of whether the skb comes from the same RPC
> should be consistent, using a unified function or macro definition.

I agree with this in principle, but this case is a bit special: it's
on the fast path, and I'd like to not  invoke skb_canonical_ipv6_saddr
if the ids don't match; if I move this code to a shared function, I'll
have to pass in the canonical address which will require the
conversion even when the ids don't match. I don't think there are any
other places in the code that compare packets for "same RPC" except
the lookup code in homa_rpc.c, so a shared function would probably
only be used in this one place. Thus, I'm inclined to leave this code
as is. If you still feel that I should take the more expensive but
more modular path let me know and I'll bite the bullet. Another option
would be to write a special-case inline function that does this check
efficiently, but move it to homa_rpc.h so that it's grouped with other
RPC-related code; would that mitigate your concern (its interface will
be a bit awkward)?

> > +                                     *prev_link =3D skb2;
> > +                                     prev_link =3D &skb2->next;
> > +                                     continue;
> > +                             }
> > +                     }
> > +                     *other_link =3D skb2;
> > +                     other_link =3D &skb2->next;
> > +             }
> > +             *prev_link =3D NULL;
> > +             *other_link =3D NULL;
> > +             homa_dispatch_pkts(packets, homa);
> Is it really necessary to gather packets belonging to the same RPC for
> processing together, just to save some time finding the RPC ?
>
> If each packet is independent, it instead introduces a lot of
> unnecessary cycles.

Grouping the packets for an RPC doesn't matter in this stripped-down
version of Homa, but when the grant mechanism gets added in later
patches it will make a significant difference. Batching the packets
for an RPC allows Homa to invoke homa_grant_check_rpc (which checks to
see whether additional grants need to be sent out) only once, after
all of the packets for the RPC have been processed.  This is a
significant optimization because (a) home_grant_check_rpc is fairly
expensive and (b) we can often just send a single grant packet,
whereas calling homa_grant_check_rpc after each individual packet
could result in multiple grants being sent. I have added a short
comment to motivate the batching.

> > +int homa_err_handler_v4(struct sk_buff *skb, u32 info)
> > +{
> > +     const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> > +     const struct iphdr *iph =3D ip_hdr(skb);
> What's this for? only used in ICMP_PORT_UNREACH with re-assignment.

This is another case where diagnostic code in the GitHub version
caused ugliness after stripping. I've refactored to eliminate the
problem.

> > +
> > +             iph =3D (struct iphdr *)(icmp + sizeof(struct icmphdr));
> > +             h =3D (struct common_header *)(icmp + sizeof(struct icmph=
dr)
> > +                             + iph->ihl * 4);
>
> You need to ensure that the comm_header can be accessed linearly. The
> icmp_socket_deliver() only guarantees that the full IP header plus 8 byte=
s
> can be accessed linearly.

This code only accesses the destination port, which is within the
first 4 bytes of the common_header (the same position as in a TCP
header). Thus I think it's safe without calling pskb_may_pull?

> > +int homa_err_handler_v6(struct sk_buff *skb, struct inet6_skb_parm *op=
t,
> > +                     u8 type,  u8 code,  int offset,  __be32 info)
> > +{
> > +     const struct ipv6hdr *iph =3D (const struct ipv6hdr *)skb->data;
> > +     struct homa *homa =3D global_homa;
> > +
> > +     if (type =3D=3D ICMPV6_DEST_UNREACH && code =3D=3D ICMPV6_PORT_UN=
REACH) {
> > +             char *icmp =3D (char *)icmp_hdr(skb);
> > +             struct common_header *h;
> > +
> > +             iph =3D (struct ipv6hdr *)(icmp + sizeof(struct icmphdr))=
;
> > +             h =3D (struct common_header *)(icmp + sizeof(struct icmph=
dr)
> > +                             + HOMA_IPV6_HEADER_LENGTH);
> > +             homa_abort_rpcs(homa, &iph->daddr, ntohs(h->dport), -ENOT=
CONN);
>
> This cannot be right; ICMPv6 and ICMP are differ. At this point,
> there is no icmphdr anymore, you should obtain the common header from
> skb->data + offset.

Yow, you're right. I've completely refactored this (and tested it more
thoroughly...).

> Also need to ensure that the comm_header can be accessed linearly, only
> 8 bytes of common_header was checked in icmpv6_notify().

Same situation as for IPv4: only the destination port is used.

> > +__poll_t homa_poll(struct file *file, struct socket *sock,
> > +                struct poll_table_struct *wait)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +     __u32 mask;
> > +
> > +     /* It seems to be standard practice for poll functions *not* to
> > +      * acquire the socket lock, so we don't do it here; not sure
> > +      * why...
> > +      */
> > +
> That's true. sock_poll_wait will first add the socket to a waiting
> queue, so that even if an incomplete state is read subsequently, once
> the complete state is updated, wake_up_interruptible_sync_poll() will
> notify the socket to poll again. (From sk_data_ready .etc)

Thanks for the explanation; I have now removed the comment.

> > +     sock_poll_wait(file, sock, wait);
> > +     mask =3D POLLOUT | POLLWRNORM;
> > +
> > +     if (!list_empty(&homa_sk(sk)->ready_requests) ||
> > +         !list_empty(&homa_sk(sk)->ready_responses))
> > +             mask |=3D POLLIN | POLLRDNORM;
> > +     return (__poll_t)mask;
> > +}
>
>  Always writable? At least, you should check the state of the
>  socket. For example, is a socket that has already been shutdown still
>  writable? Alternatively, how does Homa notify the user when it
>  receives an ICMP error? You need to carefully consider the return
>  value of this poll. This is very important for the behavior of the
>  application.

I think it's OK for Homa sockets to be writable always. If the socket
has been shut down and an application attempts to write to it, it will
get ESHUTDOWN then. Message sends in Homa are always asynchronous, so
there is no notion of them blocking. ICMP errors are reflected at the
level of RPCs (on the server side, the RPC is discarded if an ICMP
error occurs; on the client side, an error will be returned as
response, which will make the socket "readable").

However, your comment makes me wonder about polling for read on a
socket that has been shutdown. If I don't return -ESHUTDOWN from
homa_poll in this case, I believe the application could block waiting
for reads on a socket that has been shutdown? Of course this will
never complete. So, should I check for shutdown and return -ESHUTDOWN
immediately in homa_poll, before invoking sock_poll_wait?

-John-

