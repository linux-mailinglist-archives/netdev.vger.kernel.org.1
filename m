Return-Path: <netdev+bounces-113243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ACD93D4AB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE676283225
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A917B4FF;
	Fri, 26 Jul 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPmAUBSS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121A1E529
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002358; cv=none; b=P5D8c0lSmPwinXaz6NHtDL7xxY2WiVY7AtvvSxlZYGAvknHKbwaT219ZpdbwjBTnkx1Ffg2RevHRDAbqMzshj6KjvJuHgxJMNW3iU1vxB6SinmfZnBwzoAxQMSjTU6R6iQCD4kTbFTijEOEGYIleKd4McH3KjS3e93pccUMCkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002358; c=relaxed/simple;
	bh=tr0CfA9wa/7wB5J1NAIQw/4kNS5WaKogVwi+P3O5DbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeaJv9vtp2wQFwSVD+8DuvDmwuGttMhRPv4z3LhZTRD/Q7FRvNo7nI1UwC0SEza5WW+a9yWa9s9NEiwutM+HbjkvDwnlDrSwDOuom62iDjty9bqX/EazFvj17R7UWkP/ktF/vrgrTicGk9gBCIfoNDsJUfMTIKAfIiTayH/Da0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPmAUBSS; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4929754aee9so557906137.1
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722002355; x=1722607155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9mS0yRl9NBJAseJFOOKw3B8AeqfXdRDVc4vpDh0OD8=;
        b=dPmAUBSSNx39VLKARfCgapV0wMVSx5yqvyZ5dPUf2Wly5vnUGbALG3Tzq7ElaSbPjm
         BfORpZSroHZoxo6Uum5obMXwfJCRbkdquR1ReMnbQqxJ3omPY+qVOZSsNfC3zhWO216t
         OROtAuBonYgR9kozZ6OCPMVdLEdtdaUcizrJNSpw877+Bb/foNKa+iOaBMG0xU217SXZ
         2ZZ0KWBOxKvXNXcWOWPN98RPStEp1Hx+fSLfAd4iZen+WgozkyjzUP8i+n0CwhENXxsN
         EvDDdSuBd1gc9MpArKqHHRzEd9gZ+vc1di7db6Z//Dk+8nOABikpPTpLVdLH4TKwdcbl
         OJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722002355; x=1722607155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9mS0yRl9NBJAseJFOOKw3B8AeqfXdRDVc4vpDh0OD8=;
        b=X91KsZwEnE2QKEIKNcrPh7Wl07YkELiMMiqJBYz1k6Nia334L99px0XdGbO2dR6aJf
         SMpLWBY7xwbEt4hY1mKna2IVSLN2u5ACFzeBpOooTJSqbtyC9k2WwVTN59lm4f2wdgJO
         o4YAnsPHWyvegF8dM6tEKbMoHmMeeW7SXZ5haj9KC3dD2c29OH2SNOZRQKHkJQCbgXFb
         Me5dpC/1gzb8PNlvOzfFBm5qHU54ORWJaa+sej7bi7UUaGO+sAOFJxmQAuUTBnLkrYJW
         wmOR0SLTkSxx0Y2d31OkXcYn9c69A0sFRT9MLFf2JKjrwWfgJYdkQoZRBEqTVXtzDcgI
         qGDQ==
X-Gm-Message-State: AOJu0YyxoR2M9vsmiclKRS+TRDttB4KUYhdogTf6Z25gS2i+02yLJTVp
	luwL2DGXcPdnw7JKG8EUn+WOJJF8m5MvAe0HBJPXpYAdWWQELI/UDVqOz/EmQwBDVjDpp0M2k1D
	Aa0/4MrFm1TVUQjM6JGZXdsuDGIL6tEhl
X-Google-Smtp-Source: AGHT+IEoUdZwLpee+QRuczggo2HS3RyWMHkF1tQGGcRZEGRvmSPJVS63qrDE9zGRMt4vQDFPgGP5jGmKcWOUK5twqhs=
X-Received: by 2002:a05:6102:3e29:b0:493:c028:bee0 with SMTP id
 ada2fe7eead31-493d6417fdemr7585812137.15.1722002355208; Fri, 26 Jul 2024
 06:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-udp-gso-egress-from-tunnel-v1-0-5e5530ead524@cloudflare.com>
 <20240725-udp-gso-egress-from-tunnel-v1-1-5e5530ead524@cloudflare.com>
 <CAF=yD-LLPPg77MUhdXrHUVJj4o2+rnOC_qsHc_8tKurTsAGkYw@mail.gmail.com> <87h6ccl7mm.fsf@cloudflare.com>
In-Reply-To: <87h6ccl7mm.fsf@cloudflare.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 26 Jul 2024 09:58:38 -0400
Message-ID: <CAF=yD-JK+Jnjb5_r3rk+PMwV3cWHTHQHau8CQJ27aSaEQLZxQQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] udp: Mark GSO packets as CHECKSUM_UNNECESSARY
 early on on output
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, kernel-team@cloudflare.com, 
	syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 7:23=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Thu, Jul 25, 2024 at 10:21 AM -04, Willem de Bruijn wrote:
> > On Thu, Jul 25, 2024 at 5:56=E2=80=AFAM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>
> >> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
> >> checksum offload") we have added a tweak in the UDP GSO code to mark G=
SO
> >> packets being sent out as CHECKSUM_UNNECESSARY when the egress device
> >> doesn't support checksum offload. This was done to satisfy the offload
> >> checks in the gso stack.
> >>
> >> However, when sending a UDP GSO packet from a tunnel device, we will g=
o
> >> through the TX path and the GSO offload twice. Once for the tunnel dev=
ice,
> >> which acts as a passthru for GSO packets, and once for the underlying
> >> egress device.
> >>
> >> Even though a tunnel device acts as a passthru for a UDP GSO packet, G=
SO
> >> offload checks still happen on transmit from a tunnel device. So if th=
e skb
> >> is not marked as CHECKSUM_UNNECESSARY or CHECKSUM_PARTIAL, we will get=
 a
> >> warning from the gso stack.
> >
> > I don't entirely understand. The check should not hit on pass through,
> > where segs =3D=3D skb:
> >
> >         if (segs !=3D skb && unlikely(skb_needs_check(skb, tx_path) &&
> > !IS_ERR(segs)))
> >                 skb_warn_bad_offload(skb);
> >
>
> That's something I should have explained better. Let me try to shed some
> light on it now. We're hitting the skb_warn_bad_offload warning because
> skb_mac_gso_segment doesn't return any segments (segs =3D=3D NULL).
>
> And that's because we bail out early out of __udp_gso_segment when we
> detect that the tunnel device is capable of tx-udp-segmentation
> (GSO_UDP_L4):
>
>         if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
>                 /* Packet is from an untrusted source, reset gso_segs. */
>                 skb_shinfo(gso_skb)->gso_segs =3D DIV_ROUND_UP(gso_skb->l=
en - sizeof(*uh),
>                                                              mss);
>                 return NULL;
>         }

Oh I see. Thanks.

> It has not occurred to me before, but in the spirit of commit
> 8d74e9f88d65 "net: avoid skb_warn_bad_offload on IS_ERR" [1], we could
> tighten the check to exclude cases when segs =3D=3D NULL. I'm thinking of=
:
>
>         if (segs !=3D skb && !IS_ERR_OR_NULL(segs) && unlikely(skb_needs_=
check(skb, tx_path)))
>                 skb_warn_bad_offload(skb);

That looks sensible to me. And nicer than the ip_summed conversion in
udp_send_skb.

> That would be an alternative. Though I'm not sure I understand the
> consequences of such change fully yet. Namely if we're wouldn't be
> losing some diagnostics from the bad offload warning.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8d74e9f88d65af8bb2e095aff506aa6eac755ada
>
> >> Today this can occur in two situations, which we check for in
> >> __ip_append_data() and __ip6_append_data():
> >>
> >> 1) when the tunnel device does not advertise checksum offload, or
> >> 2) when there are IPv6 extension headers present.
> >>
> >> To fix it mark UDP_GSO packets as CHECKSUM_UNNECESSARY early on the TX
> >> path, when still in the udp layer, since we need to have ip_summed set=
 up
> >> correctly for GSO processing by tunnel devices.
> >
> > The previous patch converted segments post segmentation to
> > CHECKSUM_UNNECESSARY, which is fine as they had
> > already been checksummed in software, and CHECKSUM_NONE
> > packets on egress are common.
> >
> > This creates GSO packets without CHECKSUM_PARTIAL.
> > Segmentation offload always requires checksum offload. So these
> > would be weird new packets. And having CHECKSUM_NONE (or
> > equivalent), but entering software checksumming is also confusing.
>
> I agree this is confusing to reason about. That is a GSO packet with
> CHECKSUM_UNNECESSARY which has not undergone segmentation and csum
> offload in software.

I was mistaken earlier. Was looking at this code just yesterday too for

https://lore.kernel.org/netdev/20240726023359.879166-1-willemdebruijn.kerne=
l@gmail.com/

We do set the GSO skb already skb CHECKSUM_NONE. So your suggestion is
not a significant change.

> Kind of related, I noticed that turning off tx-checksum-ip-generic with
> ethtool doesn't disable tx-udp-segmentation. That looks like a bug.

I saw the same :)

> > The crux is that I don't understand why the warning fires on tunnel
> > exit when no segmentation takes place there. Hopefully we can fix
> > in a way that does not introduce these weird GSO packets (but if
> > not, so be it).
>
> Attaching a self contained repro which I've been using to trace and
> understand the GSO code:
>
> ---8<---
>
> sh# cat repro-full.py
> #!/bin/env python
> #
> # `modprobe ip6_tunnel` might be needed.
> #
>
> import os
> import subprocess
> import shutil
> from socket import *
>
> UDP_SEGMENT =3D 103
>
> cmd =3D [shutil.which("ip"), "-batch", "/dev/stdin"]
> script =3D b"""
> link set dev lo up
>
> link add name sink mtu 1540 type dummy
> addr add dev sink fd11::2/48 nodad
> link set dev sink up
>
> tunnel add iptnl mode ip6ip6 remote fd11::1 local fd11::2 dev sink
> link set dev iptnl mtu 1500
> addr add dev iptnl fd00::2/48 nodad
> link set dev iptnl up
> """
> proc =3D subprocess.Popen(cmd, stdin=3Dsubprocess.PIPE)
> proc.communicate(input=3Dscript)
>
> os.system("ethtool -K sink tx-udp-segmentation off > /dev/null")
> os.system("ethtool -K sink tx-checksum-ip-generic off > /dev/null")
>
> # Alternatively to hopopts:
> # os.system("ethtool -K iptnl tx-checksum-ip-generic off")
>
> hopopts =3D b"\x00" * 8
> s =3D socket(AF_INET6, SOCK_DGRAM)
> s.setsockopt(IPPROTO_IPV6, IPV6_HOPOPTS, hopopts)
> s.setsockopt(SOL_UDP, UDP_SEGMENT, 145)
> s.sendto(b"x" * 3000, ("fd00::1", 9))
> sh# perf ftrace -G __skb_gso_segment --graph-opts noirqs,depth=3D5 -- uns=
hare -n python repro-full.py
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>  16)               |  __skb_gso_segment() {
>  16)   0.288 us    |    irq_enter_rcu(); /* =3D 0xffffa00c03d89ac0 */
>  16)   0.172 us    |    idle_cpu(); /* =3D 0x0 */
>  16)               |    skb_mac_gso_segment() {
>  16)   0.184 us    |      skb_network_protocol(); /* =3D 0xdd86 */
>  16)   0.161 us    |      __rcu_read_lock(); /* =3D 0x2 */
>  16)               |      ipv6_gso_segment() {
>  16)               |        rcu_read_lock_held() {
>  16)   0.151 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x=
1 */
>  16)   0.514 us    |        } /* rcu_read_lock_held =3D 0x1 */
>  16)               |        rcu_read_lock_held() {
>  16)   0.152 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x=
1 */
>  16)   0.459 us    |        } /* rcu_read_lock_held =3D 0x1 */
>  16)               |        rcu_read_lock_held() {
>  16)   0.151 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x=
1 */
>  16)   0.459 us    |        } /* rcu_read_lock_held =3D 0x1 */
>  16)               |        udp6_ufo_fragment() {
>  16)   0.237 us    |          __udp_gso_segment(); /* =3D 0x0 */
>  16)   0.727 us    |        } /* udp6_ufo_fragment =3D 0x0 */
>  16)   3.049 us    |      } /* ipv6_gso_segment =3D 0x0 */
>  16)   0.171 us    |      __rcu_read_unlock(); /* =3D 0x1 */
>  16)   4.748 us    |    } /* skb_mac_gso_segment =3D 0x0 */
>  16)               |    skb_warn_bad_offload() {
>  [...]
>  16) ! 785.215 us  |    } /* skb_warn_bad_offload =3D 0x0 */
>  16) ! 800.986 us  |  } /* __skb_gso_segment =3D 0x0 */
>  16)               |  __skb_gso_segment() {
>  16)   0.394 us    |    irq_enter_rcu(); /* =3D 0xffffa00c03d89ac0 */
>  16)   0.181 us    |    idle_cpu(); /* =3D 0x0 */
>  16)               |    skb_mac_gso_segment() {
>  16)   0.182 us    |      skb_network_protocol(); /* =3D 0xdd86 */
>  16)   0.178 us    |      __rcu_read_lock(); /* =3D 0x3 */
>  16)               |      ipv6_gso_segment() {
>  16)               |        rcu_read_lock_held() {
>  16)   0.155 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x=
1 */
>  16)   0.556 us    |        } /* rcu_read_lock_held =3D 0x1 */
>  16)               |        rcu_read_lock_held() {
>  16)   0.159 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x=
1 */
>  16)   0.480 us    |        } /* rcu_read_lock_held =3D 0x1 */
>  16)               |        rcu_read_lock_held() {
>  16)   0.159 us    |          rcu_lockdep_current_cpu_online(); /* =3D 0x=
1 */
>  16)   0.480 us    |        } /* rcu_read_lock_held =3D 0x1 */
>  16)               |        ip6ip6_gso_segment() {
>  16) + 22.176 us   |          ipv6_gso_segment(); /* =3D 0xffffa00c03018c=
00 */
>  16) + 24.875 us   |        } /* ip6ip6_gso_segment =3D 0xffffa00c03018c0=
0 */
>  16) + 27.416 us   |      } /* ipv6_gso_segment =3D 0xffffa00c03018c00 */
>  16)   0.230 us    |      __rcu_read_unlock(); /* =3D 0x2 */
>  16) + 29.065 us   |    } /* skb_mac_gso_segment =3D 0xffffa00c03018c00 *=
/
>  16) + 32.828 us   |  } /* __skb_gso_segment =3D 0xffffa00c03018c00 */
> sh#

