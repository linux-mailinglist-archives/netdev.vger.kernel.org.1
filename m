Return-Path: <netdev+bounces-240997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D68C7D403
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F94E1822
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D862248BD;
	Sat, 22 Nov 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="JXx1JhkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992312222A9
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830105; cv=none; b=qeI8fwc4nzlcbVkPZ9tSmxbzHObuFoKK30DCwFdw37qr6bmQ0MNNMOh8NycgCzRuhsTKNdFFKMibLwBHNtVxC8hwKyOvQ8WWpnyO428/kkphFBLCrt+S84TV8p9cCQCYKzpeFAk3/PzFLgoFwPFYizKHa/IlyKds8/shyCanBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830105; c=relaxed/simple;
	bh=nDxogkDitLXzp5n/FgPWJOMZ0c9WFiskeaIzVxY5o4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhM8pkIR4/XjvaY9cSObdo5sHpWMnsVquIsJAE+XPucDUK0eYO06SPweN8f93aYK3p2e0U8nHkUm0H44wDXUq/HrT0dv8tBf1WJ8d+FzBqlW0yLrXQD4RiWcEghXuTWB1U9AuJ/YvYahaojDnsVKX8way0qsTMCiyNmUt/iO41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=JXx1JhkU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a3d86b773so26584181fa.0
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1763830101; x=1764434901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xToa3ufzkbbLCmDAtlqJd2dlSSQW7UjEItJ+rdjBX0=;
        b=JXx1JhkUlKuS76RfgFZHKZp/IA1EB8eqr+3k7Sdu71sI7JvrwD8aFRc1nknxnx3hKd
         yXKyFVTt+BTF66B7gCZknNWn6XaH6OXr0uC1/IMc4BM4seB2eRHtWLUnDNnHXnWAcBVR
         7YPMrKZibfIG1vqcVlphyq8JOGlSbK35VEYSe798bhprHe+LaXr/CJqIqfSBTzkCE5Qk
         jFPKsFWlS5PYP0MqE6IAj9oPU4dTE+xOkgw/jRCPWq6dgO81hgG1fBRT1f9x6Bc0Yzgk
         DSWnloGQ1xSTIWV4dt9mATWw0brjmQH6+KbDD/J+ktFAtkhwNA6zCVMnbYqIXcmfPpJr
         uIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763830101; x=1764434901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xToa3ufzkbbLCmDAtlqJd2dlSSQW7UjEItJ+rdjBX0=;
        b=qKkZYumoEBR7TxdU0hXuEpcXBBmlIwIn30RvdVO33v3UiQGmzMsyYk3h+uI4JfEfbJ
         dL/1KqHXp8uOCiGyjAqIYm5yaN9MAYpxo3EIZinkwb5kea8VSLvqE/Pu2e/bJ4wAT3YX
         GXJLIhOWH3vTbZJJC/QsqIzaC7Hl/kyokk2nUhZs8w6mpl/ISJRESrYFJ1TFRUfGe5Lz
         QRDmkd49DslgRvgAS3jkJa12QKDTpMY6agqWnbjPTXcU3gwztzqxgKSkBeiT+iDXTHuU
         H34qzL4NQWXk6y6ae0mRlAgQzPYldwrzu8WPC9D7fOfi01U7DLeoBVd9s+oiL036YelY
         wNNA==
X-Forwarded-Encrypted: i=1; AJvYcCUHvmpRuwUO3Sh6OXHN3ZXmziHhgWCzK7k2DLLZ/MjcZgPqA1VtAQE8LNUT2cjm8sHLx0ovAN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9gRS45S6yGKxV8dmmIXebjm3f+Py84tupomRJiRTP+5rygDA
	DErmCXFBIjNSZCQWuszqszy3CN/urwdgM/uuqXEFnjgfjVmaVmQ+IBIdN0V1LoHUeYXzrjullnq
	bIThawBC6A56A/NT7sa3g14rthkP8oU1H60BvJOkTD1okHAlEWxE8Q9js
X-Gm-Gg: ASbGncvKea3oBoTmtEOGJfw9spkiuIGEKhAxkxHPQQ08wMrb8Jt0A7IRUh5K5YU1r/H
	Qn+t5Wi6gpL1pHcOTytqaH+8bztIpqP+riYOD7ehRNpEqzNrT9kS3SqR07hZ3KLb9Bog4V3JDer
	iKTt0jcYZdku+iQJYpTPS9I0QfEvKJTNJPrYpwqDYBYlBZL6OJJ8G4verJ29OyiAjcLNBeJNdUM
	qqbgjNPka4nv0B6PwENPFtqMHH+Z/V3Q9jJcqlGWUuVJXl3691PgpAxtjCPyQwPv7t4jcnunqhB
	iUTEhuPo75vaugGhOtB+X9vNC0pYA2HKCIcM5PYNnM/SCbx7GpzPe5YpqBo1+askcH55sq0=
X-Google-Smtp-Source: AGHT+IES8vQejkESo6SE8CpWsGk1C+ENODLSpV3QGa0a+GCcIHjkTYYJBgFVzYy/fmW3hrraUZk1wDBoo4wpnt+q/zQ=
X-Received: by 2002:a2e:a446:0:b0:37a:45fb:d42f with SMTP id
 38308e7fff4ca-37cd91e564dmr12064401fa.19.1763830100416; Sat, 22 Nov 2025
 08:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112001744.24479-1-tom@herbertland.com> <20251112001744.24479-3-tom@herbertland.com>
 <d7793ec7-7d34-4a46-8f17-c4ff1152e232@uliege.be> <CALx6S369Cb-9mtD3hSS0udTHZ_4r5d+2UD8zfsonjfM7QrHhAA@mail.gmail.com>
 <edb1d889-480d-4ef0-ae96-fa99d00aaaad@uliege.be>
In-Reply-To: <edb1d889-480d-4ef0-ae96-fa99d00aaaad@uliege.be>
From: Tom Herbert <tom@herbertland.com>
Date: Sat, 22 Nov 2025 08:48:09 -0800
X-Gm-Features: AWmQ_bk3CcNb7FLWvFktbwN5eD4TFXGBxgc8aHilJ8SuWBPgrdZApYlBjBoWTeU
Message-ID: <CALx6S34SjAvoidT+vjWA=U3GezP39hT2v3LuaFtLid_sMY7+dA@mail.gmail.com>
Subject: Re: [RFC net-next 2/3] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Justin Iurman <justin.iurman@uliege.be>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 1:53=E2=80=AFAM Justin Iurman <justin.iurman@uliege=
.be> wrote:
>
> On 11/21/25 22:23, Tom Herbert wrote:
> > On Thu, Nov 13, 2025 at 5:17=E2=80=AFAM Justin Iurman <justin.iurman@ul=
iege.be> wrote:
> >>
> >> On 11/12/25 01:16, Tom Herbert wrote:
> >>> Set IP6_DEFAULT_MAX_HBH_OPTS_CNT to zero. This disables
> >>
> >> s/IP6_DEFAULT_MAX_HBH_OPTS_CNT/IP6_DEFAULT_MAX_DST_OPTS_CNT
> >>
> >>> processing of Destinations Options extension headers by default.
> >>> Processing can be enabled by setting the net.ipv6.max_dst_opts_number
> >>> to a non-zero value.
> >>>
> >>> The rationale for this is that Destination Options pose a serious ris=
k
> >>> of Denial off Service attack. The problem is that even if the
> >>> default limit is set to a small number (previously it was eight) ther=
e
> >>> is still the possibility of a DoS attack. All an attacker needs to do
> >>> is create and MTU size packet filled  with 8 bytes Destination Option=
s
> >>> Extension Headers. Each Destination EH simply contains a single
> >>> padding option with six bytes of zeroes.
> >>>
> >>> In a 1500 byte MTU size packet, 182 of these dummy Destination
> >>> Options headers can be placed in a packet. Per RFC8200, a host must
> >>> accept and process a packet with any number of Destination Options
> >>> extension headers. So when the stack processes such a packet it is
> >>> a lot of work and CPU cycles that provide zero benefit. The packet
> >>> can be designed such that every byte after the IP header requires
> >>> a conditional check and branch prediction can be rendered useless
> >>> for that. This also may mean over twenty cache misses per packet.
> >>> In other words, these packets filled with dummy Destination Options
> >>> extension headers are the basis for what would be an effective DoS
> >>> attack.
> >>
> >> How about a new document to update RFC8200 Sec. 4.1.? Maybe we can get
> >> 6man consensus to enforce only one occurrence (vs. 2 for the Dest) for
> >> each extension header. Let alone the recommended order (without
> >> normative language), we could...
> >
> > Hi Justin,
>
> Hi Tom,
>
> > It's a nice idea, but given the turnaround times for the IETF process
>
> Indeed, but I think we'll need that at some point. I'll craft something
> and send it to 6man to get feedback.
>
> > it would take years. Also to implement that in the stack isn't
>
> I don't think it would be difficult thanks to struct inet6_skb_parm that
> is stored in the control buffer of skb's. We already have some flags
> that are set, and offsets defined.

Justin,

A patch for that would be good regardless of whether you take it to IETF :-=
).

>
> > particularly trivial. Avoiding the potential DoS attack is the higher
> > priority problem IMO, and disabling DestOpts by default will have
> > little impact since almost no one is using them..
>
> Agree, but both issues are linked. If we don't explicitly limit (funny,
> in this case, I'd be OK to use that term ;-) the number of Destination
> Options header to 2 (as it should be), then the attack surface increases.

Yes, but it doesn't eliminate the potential for attack.

>
> >>
> >> OLD:
> >>      Each extension header should occur at most once, except for the
> >>      Destination Options header, which should occur at most twice (onc=
e
> >>      before a Routing header and once before the upper-layer header).
> >>
> >> NEW:
> >>      Each extension header MUST occur at most once, except for the
> >>      Destination Options header, which MUST occur at most twice (once
> >>      before a Routing header and once before the upper-layer header).
> >>
> >> ...and...
> >>
> >> OLD:
> >>      IPv6 nodes must accept and attempt to process extension headers i=
n
> >>      any order and occurring any number of times in the same packet,
> >>      except for the Hop-by-Hop Options header, which is restricted to
> >>      appear immediately after an IPv6 header only.  Nonetheless, it is
> >>      strongly advised that sources of IPv6 packets adhere to the above
> >>      recommended order until and unless subsequent specifications revi=
se
> >>      that recommendation.
> >>
> >> NEW:
> >>      IPv6 nodes must accept and attempt to process extension headers i=
n
> >>      any order in the same packet,
> >>      except for the Hop-by-Hop Options header, which is restricted to
> >>      appear immediately after an IPv6 header only.  Nonetheless, it is
> >>      strongly advised that sources of IPv6 packets adhere to the above
> >>      recommended order until and unless subsequent specifications revi=
se
> >>      that recommendation.
> >>
> >>> Disabling Destination Options is not a major issue for the following
> >>> reasons:
> >>>
> >>> * Linux kernel only supports one Destination Option (Home Address
> >>>     Option). There is no evidence this has seen any real world use
> >>
> >> IMO, this is precisely the one designed for such real world end-to-end
> >> use cases (e.g., PDM [RFC8250] and PDMv2 [draft-ietf-ippm-encrypted-pd=
mv2]).
> >
> > Sure, but  where is the Linux implementation? Deployment?
>
> Maybe they'll send it upstream one day, who knows.
>
> >>
> >>> * On the Internet packets with Destination Options are dropped with
> >>>     a high enough rate such that use of Destination Options is not
> >>>     feasible
> >>
> >> I wouldn't say that a 10-20% drop is *that* bad (i.e., "not feasible")
> >> for sizes < 64 bytes. But anyway...
> >
> > The drop rates for Destination Options vary by size of the extension
> > header. AP NIC data shows that 32 bytes options have about a 30% drop
> > rate, 64 byte options have about a 40% drop rate, but 128 byte options
> > have over 80% drop rate. The drops are coming from routers and not
> > hosts, Linux has no problem with different sizes. As you know from the
> > 6man list discussions, I proposed a minimum level of support that
> > routers must forward packets with up to 64 bytes of extension headers,
> > but that draft was rejected because of concerns that it would ossify
> > an already ossified protocol :-(. Even if a 40% drop rate isn't "that
> > bad" the 80% drop rate of 128 bytes EH would seem to qualify as "bad".
> > In any case, no one in IETF has offered an alternative plan to address
> > the high loss rates and without a solution I believe it's fair to say
> > that use of Destination Options is not feasible.
>
> The difference with APNIC's measurements lies in the fact that they
> reach end-users located behind ISPs, where EHs are heavily filtered. So
> their measurements are worst case scenarios (not saying they are not
> representative, just that it's a different location in networks). This
> becomes "less" problematic (don't get me wrong, there are still EH
> filters) if you remain at the core/edge (e.g., cloud providers, etc).
>

That's exactly the point though. The vast majority of our users, i.e.
billions of laptops and SmartPhones, live behind ISPs and packets sent
to them with EH are commonly being filtered by ISPs. IMO we need to
set the defaults for the benefit of _them_, not for the relative
handful of nodes that remain at the core/edge. For the latter group if
they really want to use extension headers they can easily configure
their devices accordingly. As contrary as it is to the end-to-end
principle, it may actually be a good thing that ISPs have been
filtering all along since that saves hosts from DoS attacks involving
EH, but it's time to close this security hole in Linux itself.

Also we need to be honest here. The whole idea of extension headers
was ill conceived from the get go. Even if we didn't know any better
in the first design of IPv6 thirty years ago, I really wished the
problems would have been addressed when IPv6 was promoted to Standard.
Destination Options are particularly problematic since they have no
security to speak of. If someone wants to send end-to-end information
wouldn't they wrap this in an encrypted transport layer, I mean why
expose end-to-end information in plain text for all the world to see
and muck with?

In the end, the most likely future of extension headers is that they
will be relegated to use in limited domains. And that's fine, in a
limited domain any issues of router compatibility can be managed and
security can be enforced. But on the Internet, I don't believe we'll
ever see EH used. And that's why I think we should disable Destination
Options by default for the greater good of humanity! ;-)

Tom

> >>
> >>> * It is unknown however quite possible that no one anywhere is using
> >>>     Destination Options for anything but experiments, class projects,
> >>>     or DoS. If someone is using them in their private network thentha=
tit
> >>>     it's easy enough to configure a non-zero limit for their use case
> >>> ---
> >>>    include/net/ipv6.h | 7 +++++--
> >>>    1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> >>> index 74fbf1ad8065..723a254c0b90 100644
> >>> --- a/include/net/ipv6.h
> >>> +++ b/include/net/ipv6.h
> >>> @@ -86,8 +86,11 @@ struct ip_tunnel_info;
> >>>     * silently discarded.
> >>>     */
> >>>
> >>> -/* Default limits for Hop-by-Hop and Destination options */
> >>> -#define IP6_DEFAULT_MAX_DST_OPTS_CNT  8
> >>> +/* Default limits for Hop-by-Hop and Destination options. By default
> >>> + * packets received with Destination Options headers are dropped to =
thwart
> >>> + * Denial of Service attacks (see sysctl documention)
> >>> + */
> >>> +#define IP6_DEFAULT_MAX_DST_OPTS_CNT  0
> >>>    #define IP6_DEFAULT_MAX_HBH_OPTS_CNT         8
> >>>    #define IP6_DEFAULT_MAX_DST_OPTS_LEN         INT_MAX /* No limit *=
/
> >>>    #define IP6_DEFAULT_MAX_HBH_OPTS_LEN         INT_MAX /* No limit *=
/
> >>
> >> I'd rather prefer to update RFC8200 and enforce a maximum of 2
> >> occurrences for the Dest, and keep the default limit of 8 options.
> >>
> >> Also, regardless of what we do here (and this remark also applies to t=
he
> >> Hop-by-Hop), I think it's reasonable for a *host* to drop packets with=
 a
> >> number of Hbh or Dest options that exceeds the configured limit.
> >> However, for a router (i.e., forwarding mode), I'd prefer to skip the =
EH
> >> chain rather than drop packets (for obvious reasons).
> >
> > I considered that, but there is a problem in that when we process HBH
> > options we don't know if we're a host (i.e. the final destination) or
> > a router (i.e. the packet will be forwarded). I would prefer to keep
>
> Correct. We may consider calling ip6_route_input() earlier (this is what
> IOAM does already), for example before calling ipv6_parse_hopopts() in
> ip6_rcv_core(), instead of doing it in ip6_rcv_finish_core(). Otherwise,
> we'd need to rely on ipv6_chk_addr_ret(). Maybe something like (not teste=
d):
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index a23eb8734e15..0351b7fc58ee 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -119,6 +119,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
>         const unsigned char *nh =3D skb_network_header(skb);
>         int off =3D skb_network_header_len(skb);
>         bool disallow_unknowns =3D false;
> +       int ipv6_chk_addr_ret =3D -1;
>         int tlv_count =3D 0;
>         int padlen =3D 0;
>
> @@ -166,8 +167,30 @@ static bool ip6_parse_tlv(bool hopbyhop,
>                         }
>                 } else {
>                         tlv_count++;
> -                       if (tlv_count > max_count)
> -                               goto bad;
> +                       if (tlv_count > max_count) {
> +                               /* Drop a Destination Options header when=
 its
> +                                * number of options exceeds the configur=
ed
> +                                * limit.
> +                                */
> +                               if (!hopbyhop)
> +                                       goto bad;
> +
> +                               /* Drop a Hop-by-Hop Options header when =
its
> +                                * number of options exceeds the configur=
ed
> +                                * limit IF we're the destination. Otherw=
ise,
> +                                * just skip it.
> +                                */
> +                               if (ipv6_chk_addr_ret =3D=3D -1)
> +                                       ipv6_chk_addr_ret =3D ipv6_chk_ad=
dr(
> +                                                       dev_net(skb->dev)=
,
> +                                                       &ipv6_hdr(skb)->d=
addr,
> +                                                       skb->dev, 0);
> +
> +                               if (ipv6_chk_addr_ret)
> +                                       goto bad;
> +
> +                               goto skip;
> +                       }
>
>                         if (hopbyhop) {
>                                 switch (nh[off]) {
> @@ -210,6 +233,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
>                                         break;
>                                 }
>                         }
> +skip:
>                         padlen =3D 0;
>                 }
>                 off +=3D optlen;
>
> > it simple and drop whenever a limit is exceeded. RFC9673 does allow a
> > host to skip over HBH options, but IMO it's too risky to blindly
> > accept a packet without verifying all the headers.
>
> For a host, I agree. But as a router, I really don't think we should
> drop packets if the limit is exceeded. In that case, we just don't care,
> we're routers, it's not our job to decide if we drop a packet because of
> EHs. Otherwise, we'd be doing the same as operators' policies and
> hardware limitation in transit ASs, and we'd be exacerbating the
> ossification.
>
> Justin
>
> > Tom
>

