Return-Path: <netdev+bounces-167111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780CA38F17
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DF5169C1F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05831A4F21;
	Mon, 17 Feb 2025 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtQPRkCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6513AA5D
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831489; cv=none; b=BeFBTP36oEvAU7dNZr7c0/INt3BGhvN/ierCHF9p6uvXOG0HKwfR6boDXVKfdwdVpTYsfap+JpzMaLx2vwDb/JpxeCn7Amefi9MZ3E8KkiZJ6W3nkdW0WzboPAL5PAS/AHmU7+ihkw1KYG+bXUm1glapSLBnxeyyAnRzHSbcnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831489; c=relaxed/simple;
	bh=dMTCQMHUPvfW4pOs2oc6T+Ngk91XWZWi1MWsPhYZOXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzCBa/GiIjityhIpWj1hnioVc/DLoLIktaMTYX3sVy+OWmEWjNBBIydwiR25RKIS78bmJBmYz8ZFAtsXQ7DgHT0ApZwvBBgiiskEkczsacBDeyzfn3zcdrS8Q0FZjECmQsqdc+bxJY15HnDedCNTu3Gad8KI6fAdn4gA89jGwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtQPRkCp; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so43133135ab.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739831487; x=1740436287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1uHvJ2XiE0FmNxWkplkyl/jMusgvkvIOmgFcURuoSg=;
        b=GtQPRkCpgCES2ivrqwdobBUS/dT+pKRLLIcwSaNDQuKizitweIy1ReHD+ERJRLDXXI
         00pwqsm9IyWOdUMWSwniucUVZdAST/cQqd+9HZddixetUrVYGGpojHOdndGzJkBwgy5Z
         A9CbJhCWR1ARKcgAA00u4u8wepKSifLtKFmk+bdOI1z0z3sM92ZhelK9Yta1OOTuI4MI
         +OU/Siu26CooGFlHOpFbaGfAXZETo6HRiUehO87TniX82ADKsE67fguTp+WcGePZi6Ok
         e3yjMRy0G6bLdPFWU7azvuL59wLU/V6j4i+2QJipbKJTnfl/kyOR0GqUGVgy/hsbiPz/
         YxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739831487; x=1740436287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1uHvJ2XiE0FmNxWkplkyl/jMusgvkvIOmgFcURuoSg=;
        b=dPcvekYIcyeruTJ6MbD4Rm/wLCNRAvKGuu8/ZYRl2/DE2mcrHqHu6m12D7HiHTmDXC
         wysHACI2KmhlerNDLtr8c6CR27b7u2uLGdMzWjbxFYUIc4qxLcmEBCyjMEIQv84xP/UW
         9JX660b1on9yl79u7YotGwSQX8MTDwRoYHIWN26yI+JYVUgVaWHKJ6mB5eDCN1x8k7Z7
         DcOSb9Z/R+ST9gZ/oaULILBrCPBcq6i6Z/h2JUTGafct6IA1VluR75KupHfE6P3PCFb8
         fP0L+gTma+wXMB1I1U8vUKTdBLWUay0y94aG2S4wYTWaRAEht/5RHcLlAIW4np/ESR3X
         yPVg==
X-Forwarded-Encrypted: i=1; AJvYcCWNc9jiX4QJfP/qjurM0sckbJBRiGPfgPkXEg5s9tzov20gphYPS7biHCxX7Oro5UwFxZbVljw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ElXjTyOblQJT7au0zjOLNnKQtNWd1GgnyuZzsGcJVG0J6C38
	JjXJUObSaROrB5ipKuiGp+xopvq+YzrkerrRpgvHDB2MV+Pb6PhxhKmSjiTEW38WO5iQdQSW+JK
	6PPC5fea4BuNU1AW22R/8gJtDfhm98vLK
X-Gm-Gg: ASbGncs2ahiX4PJfnxUS+ZfVNl7bOTHCuCtOzeKCBEo3W8divsIyXCjFnJVhgY3fz5O
	1yUBHUhaIslrv7tdJbEbRjYDjeySRrRRfYDVKBwqMduJSWc5060YYMOchU/eKl8XaVYUH+qU=
X-Google-Smtp-Source: AGHT+IF2F5AA/tVsYPtI4kg4vczdHLY1dNrRSkcYEs8r2x/9tW1mwYdNGZuzxB8iPSGc/d2HGdoz4X00H5yPTYWwVNU=
X-Received: by 2002:a92:c548:0:b0:3d0:24c0:bd45 with SMTP id
 e9e14a558f8ab-3d28092cd46mr100008935ab.20.1739831486854; Mon, 17 Feb 2025
 14:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210084931.23a5c2e4@hermes.local> <Z7D9cR22BDPN7WSJ@shredder>
In-Reply-To: <Z7D9cR22BDPN7WSJ@shredder>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 17 Feb 2025 17:31:16 -0500
X-Gm-Features: AWEUYZkMZ42WIu3ji2jnpMdSTZ9kDnX5KNtWDl4JlKpKMDw-kbMlmjdWwNA2m8A
Message-ID: <CADvbK_eZp5ikahxH4wvPm5_PuK1khvVKpGnY5LUd9nwHgS96Cw@mail.gmail.com>
Subject: Re: Fw: [Bug 219766] New: Garbage Ethernet Frames
To: Ido Schimmel <idosch@idosch.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, edumazet@google.com, netdev@vger.kernel.org, 
	fmei@sfs.com, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:47=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Mon, Feb 10, 2025 at 08:49:31AM -0800, Stephen Hemminger wrote:
> > Not really enough information to do any deep analysis but forwarding to=
 netdev
> > anyway as it is not junk.
> >
> > Begin forwarded message:
> >
> > Date: Sun, 09 Feb 2025 12:24:32 +0000
> > From: bugzilla-daemon@kernel.org
> > To: stephen@networkplumber.org
> > Subject: [Bug 219766] New: Garbage Ethernet Frames
> >
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219766
> >
> >             Bug ID: 219766
> >            Summary: Garbage Ethernet Frames
> >            Product: Networking
> >            Version: 2.5
> >           Hardware: All
> >                 OS: Linux
> >             Status: NEW
> >           Severity: normal
> >           Priority: P3
> >          Component: Other
> >           Assignee: stephen@networkplumber.org
> >           Reporter: fmei@sfs.com
> >         Regression: No
> >
> > I am currently troubleshooting a very strange problem which appears whe=
n
> > upgrading Kernel 6.6.58 to 6.6.60. The kernel version change is part of=
 a
> > change of talos linux (www.talos.dev) from 1.8.2 to 1.8.3.
> >
> > We are running this machines at hetzner - a company which is providing =
server
> > hosting. they complain that we are using mac addresses which are not al=
lowed
> > (are not the mac addresses of the physical nic)
> >
> > In the investigation of the problem I did tcpdumps on the physical adap=
ters and
> > captured this suspicious ethernet frames. The frames do neither have a =
known
> > ethertype, nor do they have a mac address of a known vendor or a known =
virtual
> > mac address range. They seem garbage to me. Below an example. More can =
be found
> > in the github issue. This frames are not emitted very often and the sys=
tems are
> > operating normally. If I would not be informed by the hosting provider =
I would
> > not have noticed it at all.
> >
> > I also tried to track it down to a specific hardware (r8169), but we ha=
ve the
> > same problem with e1000e.
> >
> > I checked the changelogs of the two kernel versions (6.6.59 & 6.6.60) a=
nd
> > noticed there were some changes which could be the problem, but I simpl=
y do not
> > have the experience for it.
> >
> > Can anybody check the changelog of the 2 versions and see if there is a=
 change
> > which might cause the problem? Can anybody give me a hint how to track =
it down
> > further?
> >
> > tcpdump: verbose output suppressed, use -v[v]... for full protocol deco=
de
> > listening on enp9s0, link-type EN10MB (Ethernet), snapshot length 26214=
4 bytes
> > 22:07:02.329668 20:00:40:11:18:fb > 45:00:00:44:f4:94, ethertype Unknow=
n
> > (0x58c6), length 68:
> >         0x0000:  8dda 74ca f1ae ca6c ca6c 0098 969c 0400  ..t....l.l...=
...
> >         0x0010:  0000 4730 3f18 6800 0000 0000 0000 9971  ..G0?.h......=
..q
> >         0x0020:  c4c9 9055 a157 0a70 9ead bf83 38ca ab38  ...U.W.p....8=
..8
> >         0x0030:  8add ab96 e052                           .....R
> >
> >
> > Issue with more information: https://github.com/siderolabs/talos/issues=
/9837
>
> Adding Xin and Eric as I believe this is caused by commit 22600596b675
> ("ipv4: give an IPv4 dev to blackhole_netdev"). It's present in v6.6.59,
> but not in v6.6.58 which fits the report.
>
> The Ethernet headers of all the captured packets start with 0x45, so
> it's quite apparent that these are IPv4 packets that are transmitted
> without an Ethernet header. Specifically, these seem to be UDP packets
> (10th byte is always 0x11).
>
> After 22600596b675 neighbours can be constructed on the blackhole device
> and they are constructed with an output function (neigh_direct_output())
> that simply calls dev_queue_xmit(). The latter will transmit packets via
> skb->dev which might not be the blackhole device if dst_dev_put()
> switched dst->dev to the blackhole device when another CPU was using
> this dst entry in ip_output().
>
> I verified this using these hackish scripts [1][2]. They create a
> nexthop exception where a dst entry is cached. Two UDP applications use
> this dst entry, but a background process continuously bumps the IPv4
> generation ID so as to force these applications to perform a route
> lookup instead of using the dst entry that they previously resolved.
>
> After creating a new dst entry, one application will try to cache it in
> the nexthop exception by calling rt_bind_exception() which will call
> dst_dev_put() on the previously cached dst entry that might still be
> used by the other application on a different CPU.
>
> There's a counter at the end of the test that counts the number of
> packets that were transmitted without an Ethernet header. The problem
> does not reproduce with 22600596b675 reverted.
>
> One possible solution is to add the dst entry to the uncached list by
> converting dst_dev_put() to rt_add_uncached_list() [3]. The dst entry
> will be eventually removed from this list when the dst entry is
> destroyed or when dst->dev is unregistered. However, I am not sure it
> will solve this report as rt_bind_exception() is not the only caller of
> dst_dev_put().
With dst_dev_put(), the next dst_ops->check() call will fail. Sending a
packet on a socket typically performs routing only if sk_dst_check() fails.
I'm concerned that using rt_add_uncached_list() might delay other sockets
from acquiring the new dst as quickly as before.

(Adding Wei Wang, who introduced dst_dev_put())

>
> Another possible solution is to have the blackhole device consume the
> packets instead of letting them go out without an Ethernet header [4].
> Doesn't seem great as the packets disappear without telling anyone
> (before 22600596b675 an error was returned).
This looks fine to me. The fix in commit 22600596b675 was specifically
intended to prevent an error from being returned in these cases, as it
would break userspace UDP applications.

If you prefer to avoid silent drops, you could add a warning like:

  net_warn_ratelimited("%s(): Dropping skb.\n", __func__);

similar to how blackhole_netdev_xmit() handles it.

Thanks.

>
> Let me know what you think. Especially if you have a better fix.
>
> Thanks
>
> [1]
> #!/bin/bash
> # blackhole.sh
>
> for ns in client router server; do
>         ip netns add $ns
>         ip -n $ns link set dev lo up
> done
>
> ip -n client link add name veth0 type veth peer name veth1 netns router
> ip -n router link add name veth2 type veth peer name veth3 netns server
>
> # Client
> ip -n client link set dev veth0 up
> ip -n client address add 192.0.2.1/28 dev veth0
> ip -n client route add default via 192.0.2.2
> tc -n client qdisc add dev veth0 clsact
> tc -n client filter add dev veth0 egress pref 1 proto all \
>         flower dst_mac 45:00:00:00:00:00/ff:ff:00:00:00:00 action pass
>
> # Router
> ip netns exec router sysctl -wq net.ipv4.conf.all.forwarding=3D1
> ip -n router link set dev veth1 up
> ip -n router address add 192.0.2.2/28 dev veth1
> ip -n router link set dev veth2 up mtu 1300
> ip -n router address add 192.0.2.17/28 dev veth2
>
> # Server
> ip -n server link set dev veth3 up mtu 1300
> ip -n server address add 192.0.2.18/28 dev veth3
> ip -n server route add default via 192.0.2.17
>
> sleep 1
>
> # Create a nexthop exception where the dst entry will be cached.
> ip netns exec client ping 192.0.2.18 -c 1 -M want -s 1400 -q &> /dev/null
>
> # Continuously invalidate cached dst entries by bumping the IPv4 generati=
on ID.
> # When replacing the cached dst entry in the nexthop exception,
> # rt_bind_exception() will call dst_dev_put(), thereby setting the dst en=
try's
> # device to the blackhole device.
> ./bump_genid.sh &
>
> ip netns exec server iperf3 -s -p 6000 -D
> ip netns exec server iperf3 -s -p 7000 -D
> ip netns exec client iperf3 -c 192.0.2.18 -p 6000 -u -b 0 -t 60 &> /dev/n=
ull &
> ip netns exec client iperf3 -c 192.0.2.18 -p 7000 -u -b 0 -t 60 &> /dev/n=
ull
>
> tc -n client -s filter show dev veth0 egress
>
> ip netns pids server | xargs kill
> pkill bump_genid.sh
> ip -all netns delete
>
> [2]
> #!/bin/bash
> # bump_genid.sh
>
> while true; do
>         ip -n client route add 198.51.100.1/32 dev lo
>         ip -n client route del 198.51.100.1/32 dev lo
> done
>
> [3]
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 753704f75b2c..f40f860c0bec 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1461,7 +1461,7 @@ static bool rt_bind_exception(struct rtable *rt, st=
ruct fib_nh_exception *fnhe,
>                         dst_hold(&rt->dst);
>                         rcu_assign_pointer(*porig, rt);
>                         if (orig) {
> -                               dst_dev_put(&orig->dst);
> +                               rt_add_uncached_list(orig);
>                                 dst_release(&orig->dst);
>                         }
>                         ret =3D true;
>
> [4]
> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> index c8840c3b9a1b..448f352c3c92 100644
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -244,8 +244,22 @@ static netdev_tx_t blackhole_netdev_xmit(struct sk_b=
uff *skb,
>         return NETDEV_TX_OK;
>  }
>
> +static int blackhole_neigh_output(struct neighbour *n, struct sk_buff * =
skb)
> +{
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int blackhole_neigh_construct(struct net_device *dev,
> +                                    struct neighbour *n)
> +{
> +       n->output =3D blackhole_neigh_output;
> +       return 0;
> +}
> +
>  static const struct net_device_ops blackhole_netdev_ops =3D {
>         .ndo_start_xmit =3D blackhole_netdev_xmit,
> +       .ndo_neigh_construct =3D blackhole_neigh_construct,
>  };
>
>  /* This is a dst-dummy device used specifically for invalidated

