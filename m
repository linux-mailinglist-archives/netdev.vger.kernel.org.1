Return-Path: <netdev+bounces-149768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8BC9E75B5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F71E28B68C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C61FC11F;
	Fri,  6 Dec 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ/1ceHB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED93B2BB
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501988; cv=none; b=a3BPuT68ZKoZNe4HsdyDwjHz1E5OnVLOPltZWLJSG21+OxTTxx0aKNGTtRv6cXSxY7dwClIvRWKT9WkrxWT/MX1gPAzYBDV7HBf/41IImOZAxLsbaw9jKZF7x53U87b7ayomsMajPtPKmyCFwRdqPig2b09tYaw//xgSc/NDGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501988; c=relaxed/simple;
	bh=OTpSCHN4u2zjU3TPbMvovAlL/+L6tD9BQ4Q4CmG43l0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lHe+lTCKstbFEOUDpmUyNvSDNTpKETrN4/viSQX3YstzpZU7Do70I4nK1hj1H4XyXvjNYQ5zj0o4p3okaPDQFKeqZQKUvYRxeFc95TWDIAA2CxSglI0D7CgylLJjixXbMXfxENBRCDLDawgBmX53kQwED9PpinSCxyr70hafvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ/1ceHB; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b66d08d529so200649985a.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501985; x=1734106785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9JskLGsz+h5OW4OAOvNPih63fh1INRPhLW2Tw8ntXo=;
        b=XJ/1ceHBcYH65Crh6ijNqK32n19oot6d+06g7mu+r2bUbo/tBjyvqlfNXtxUz9FXgb
         WYiU7ABE14W9xezHudyPX9Q5E45P8hun3lLi4jIleZWolHsxMIj6muo7OZisPG+i8T88
         5NOVBHprz3yd14o579NEhcJu7/0N4psiuISyEDD31LI3Kf9/+SmR+Rt8U8vUht/X2+1K
         AfNVdfDTIhyZ/5mL+d3w24nRqAXvembU1TdfrYoZ/TmGCaatM7ylhb03p7b+0pz9mXX8
         fWPx1iwbaBAIkRhXKJC1UIZxCJzk12QxehynE+x6fzBx/W7aRk2CweYwhtzWhIwCzSOW
         do6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501985; x=1734106785;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w9JskLGsz+h5OW4OAOvNPih63fh1INRPhLW2Tw8ntXo=;
        b=u2pysZt5db/LRXiKtoa2tinOK8Z9b1tUp2L9cfYt3+na3g8M3wk+Sw6857iUF7/u7s
         yJWayWhTOEmCrZjphJ6vZzNt0aT0TR3DcZq9B6vvgDTKxu1dQKmWzG8A5EsKprDIlL8P
         89HQFfX/Of5dc38b5nKUMbG4hHdxGZkO8/TqxduDUtXzV8d0ypACxQPSVsSBwGYkwN2Y
         G2hv7kXJ5HCq5ULYf/aSfQmVmnNIa6u2Gl3MXA/vcMnHERM4DVDkqmKmo9S2G6eVY/NJ
         tL5aTGFtb0YZQAGZNP0s9q18jlddl86DiElQLhmAEXoyhr5j+Au94S+L+8ITHq21l10O
         XgIg==
X-Gm-Message-State: AOJu0YwxtqEIjanT5TVieV1fP7duvI4DNdozMzoCbO+o7jMJBCyBJyYT
	b+4HBSedw+2klDTMqJHcJ5xRT5CrqI3fCkIULjIzTJyQjTKy6jkX
X-Gm-Gg: ASbGncvALlp1F/x7FAy6PvUbKl5SHFTisRZUIjJ7ebAh2aeL4nPuAoKUZaVKgBH6726
	7HgAwRQ2cFEZAozcGQEEA+ZQsleN20qHsZ0a8T7jRuWAsjZgb7+IeJojqh8Uq6eVvAomkn6JT4d
	CIt1k5gBhEbfxzU5wdsC2DOnLKh+R5rVdtR1s+P7ERDmTPFJFIxooantdNmNGVCiCXPMPJzbN4T
	D8+OQHLS1lvEqK6kNzXv/6A0mdw5oqRU+xN7NTrBJ+8GFZFoNi/MFbo4nCf5GbBcfjIOY7w8uFo
	MAbgEGQTHYZDPr8wbxYWQw==
X-Google-Smtp-Source: AGHT+IGuqPccthg2jKJvXKQ7DVHI8XJdJH73C6qv44mSz2ZRM0S5WL4RMfT0FFklAlK5Zw2BZ4Zwxg==
X-Received: by 2002:a05:620a:2682:b0:7b3:5c6d:9625 with SMTP id af79cd13be357-7b6bc9301f4mr465791485a.16.1733501985133;
        Fri, 06 Dec 2024 08:19:45 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a4660esm187646485a.12.2024.12.06.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:19:44 -0800 (PST)
Date: Fri, 06 Dec 2024 11:19:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Nyiri <annaemesenyiri@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org
Message-ID: <6753241fe3a64_19948329459@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_RvGMvd6L5_xwtVtrR+To05xv7nQF2J7i-Xy8sthhfirdQ@mail.gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
 <20241205133112.17903-4-annaemesenyiri@gmail.com>
 <6751cb5f3c7d3_119ae629480@willemb.c.googlers.com.notmuch>
 <CAKm6_RvGMvd6L5_xwtVtrR+To05xv7nQF2J7i-Xy8sthhfirdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anna Nyiri wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=
=91pont:
> 2024. dec. 5., Cs, 16:48):
> >
> > Anna Emese Nyiri wrote:
> > > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > > ancillary data.
> > >
> > > cmsg_so_priority.sh script added to validate SO_PRIORITY behavior
> > > by creating VLAN device with egress QoS mapping and testing packet
> > > priorities using flower filters. Verify that packets with different=

> > > priorities are correctly matched and counted by filters for multipl=
e
> > > protocols and IP versions.
> > >
> > > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > ---
> > >  tools/testing/selftests/net/Makefile          |   1 +
> > >  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
> > >  .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++=
++++
> > >  3 files changed, 162 insertions(+), 1 deletion(-)
> > >  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh=

> > >
> > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/s=
elftests/net/Makefile
> > > index cb2fc601de66..f09bd96cc978 100644
> > > --- a/tools/testing/selftests/net/Makefile
> > > +++ b/tools/testing/selftests/net/Makefile
> > > @@ -32,6 +32,7 @@ TEST_PROGS +=3D ioam6.sh
> > >  TEST_PROGS +=3D gro.sh
> > >  TEST_PROGS +=3D gre_gso.sh
> > >  TEST_PROGS +=3D cmsg_so_mark.sh
> > > +TEST_PROGS +=3D cmsg_so_priority.sh
> > >  TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
> > >  TEST_PROGS +=3D netns-name.sh
> > >  TEST_PROGS +=3D nl_netdev.py
> > > diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/test=
ing/selftests/net/cmsg_sender.c
> > > index 876c2db02a63..99b0788f6f0c 100644
> > > --- a/tools/testing/selftests/net/cmsg_sender.c
> > > +++ b/tools/testing/selftests/net/cmsg_sender.c
> > > @@ -59,6 +59,7 @@ struct options {
> > >               unsigned int proto;
> > >       } sock;
> > >       struct option_cmsg_u32 mark;
> > > +     struct option_cmsg_u32 priority;
> > >       struct {
> > >               bool ena;
> > >               unsigned int delay;
> > > @@ -97,6 +98,8 @@ static void __attribute__((noreturn)) cs_usage(co=
nst char *bin)
> > >              "\n"
> > >              "\t\t-m val  Set SO_MARK with given value\n"
> > >              "\t\t-M val  Set SO_MARK via setsockopt\n"
> > > +            "\t\t-P val  Set SO_PRIORITY via setsockopt\n"
> >
> > Not in the actual code
> =

> I added the -P option only to the documentation. The -P option was
> already present in the code, but it was missing from the
> documentation. In the previous patch, Ido requested that I include it
> in the documentation.

Oh sorry. Missed that. Sounds good.
 =

> >
> > > +            "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
> > >              "\t\t-d val  Set SO_TXTIME with given delay (usec)\n"
> > >              "\t\t-t      Enable time stamp reporting\n"
> > >              "\t\t-f val  Set don't fragment via cmsg\n"
> > > @@ -115,7 +118,7 @@ static void cs_parse_args(int argc, char *argv[=
])
> > >  {
> > >       int o;
> > >
> > > -     while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l=
:L:H:")) !=3D -1) {
> > > +     while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l=
:L:H:Q:")) !=3D -1) {
> > >               switch (o) {
> > >               case 's':
> > >                       opt.silent_send =3D true;
> > > @@ -148,6 +151,10 @@ static void cs_parse_args(int argc, char *argv=
[])
> > >                       opt.mark.ena =3D true;
> > >                       opt.mark.val =3D atoi(optarg);
> > >                       break;
> > > +             case 'Q':
> > > +                     opt.priority.ena =3D true;
> > > +                     opt.priority.val =3D atoi(optarg);
> > > +                     break;
> > >               case 'M':
> > >                       opt.sockopt.mark =3D atoi(optarg);
> > >                       break;
> > > @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char =
*cbuf, size_t cbuf_sz)
> > >
> > >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > >                         SOL_SOCKET, SO_MARK, &opt.mark);
> > > +     ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > > +                     SOL_SOCKET, SO_PRIORITY, &opt.priority);
> > >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > >                         SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);=

> > >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tool=
s/testing/selftests/net/cmsg_so_priority.sh
> > > new file mode 100755
> > > index 000000000000..016458b219ba
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > @@ -0,0 +1,151 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +source lib.sh
> > > +
> > > +IP4=3D192.0.2.1/24
> > > +TGT4=3D192.0.2.2
> > > +TGT4_RAW=3D192.0.2.3
> > > +IP6=3D2001:db8::1/64
> > > +TGT6=3D2001:db8::2
> > > +TGT6_RAW=3D2001:db8::3
> > > +PORT=3D1234
> > > +DELAY=3D4000
> > > +TOTAL_TESTS=3D0
> > > +FAILED_TESTS=3D0
> > > +
> > > +if ! command -v jq &> /dev/null; then
> > > +    echo "Error: jq is not installed." >&2
> > > +    exit 1
> >
> > use KSFT_ and in these cases skip rather than fail.
> >
> > > +fi
> > > +
> > > +check_result() {
> > > +    ((TOTAL_TESTS++))
> > > +    if [ "$1" -ne 0 ]; then
> > > +        ((FAILED_TESTS++))
> > > +    fi
> > > +}
> > > +
> > > +cleanup()
> > > +{
> > > +    cleanup_ns $NS
> > > +}
> > > +
> > > +trap cleanup EXIT
> > > +
> > > +setup_ns NS
> > > +
> > > +create_filter() {
> > > +    local handle=3D$1
> > > +    local vlan_prio=3D$2
> > > +    local ip_type=3D$3
> > > +    local proto=3D$4
> > > +    local dst_ip=3D$5
> > > +    local ip_proto
> > > +
> > > +    if [[ "$proto" =3D=3D "u" ]]; then
> > > +        ip_proto=3D"udp"
> > > +    elif [[ "$ip_type" =3D=3D "ipv4" && "$proto" =3D=3D "i" ]]; th=
en
> > > +        ip_proto=3D"icmp"
> > > +    elif [[ "$ip_type" =3D=3D "ipv6" && "$proto" =3D=3D "i" ]]; th=
en
> > > +        ip_proto=3D"icmpv6"
> > > +    fi
> > > +
> > > +    tc -n $NS filter add dev dummy1 \
> > > +        egress pref 1 handle "$handle" proto 802.1q \
> > > +        flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
> > > +        dst_ip "$dst_ip" ${ip_proto:+ip_proto $ip_proto} \
> > > +        action pass
> > > +}
> > > +
> > > +ip -n $NS link set dev lo up
> > > +ip -n $NS link add name dummy1 up type dummy
> > > +
> > > +ip -n $NS link add link dummy1 name dummy1.10 up type vlan id 10 \=

> > > +    egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> > > +
> > > +ip -n $NS address add $IP4 dev dummy1.10
> > > +ip -n $NS address add $IP6 dev dummy1.10
> > > +
> > > +ip netns exec $NS sysctl -wq net.ipv4.ping_group_range=3D'0 214748=
3647'
> > > +
> > > +ip -n $NS neigh add $TGT4 lladdr 00:11:22:33:44:55 nud permanent \=

> > > +    dev dummy1.10
> > > +ip -n $NS neigh add $TGT6 lladdr 00:11:22:33:44:55 nud permanent \=

> > > +    dev dummy1.10
> > > +ip -n $NS neigh add $TGT4_RAW lladdr 00:11:22:33:44:66 nud permane=
nt \
> > > +    dev dummy1.10
> > > +ip -n $NS neigh add $TGT6_RAW lladdr 00:11:22:33:44:66 nud permane=
nt \
> > > +    dev dummy1.10
> > > +
> > > +tc -n $NS qdisc add dev dummy1 clsact
> > > +
> > > +FILTER_COUNTER=3D10
> > > +
> > > +for i in 4 6; do
> > > +    for proto in u i r; do
> > > +        echo "Test IPV$i, prot: $proto"
> > > +        for priority in {0..7}; do
> > > +            if [[ $i =3D=3D 4 && $proto =3D=3D "r" ]]; then
> > > +                TGT=3D$TGT4_RAW
> > > +            elif [[ $i =3D=3D 6 && $proto =3D=3D "r" ]]; then
> > > +                TGT=3D$TGT6_RAW
> > > +            elif [ $i =3D=3D 4 ]; then
> > > +                TGT=3D$TGT4
> > > +            else
> > > +                TGT=3D$TGT6
> > > +            fi
> > > +
> > > +            handle=3D"${FILTER_COUNTER}${priority}"
> > > +
> > > +            create_filter $handle $priority ipv$i $proto $TGT
> > > +
> > > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress=
 \
> > > +                | jq ".[] | select(.options.handle =3D=3D ${handle=
}) | \
> > > +                .options.actions[0].stats.packets")
> > > +
> > > +            if [[ $pkts =3D=3D 0 ]]; then
> > > +                check_result 0

Is there any chance for background traffic, for instance IPv6
duplicate address detection if not passing nodad.

> > > +            else
> > > +                echo "prio $priority: expected 0, got $pkts"
> > > +                check_result 1
> > > +            fi
> > > +
> > > +            ip netns exec $NS ./cmsg_sender -$i -Q $priority -d "$=
{DELAY}" \
> > > +                 -p $proto $TGT $PORT
> > > +
> > > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress=
 \
> > > +                | jq ".[] | select(.options.handle =3D=3D ${handle=
}) | \
> > > +                .options.actions[0].stats.packets")
> > > +            if [[ $pkts =3D=3D 1 ]]; then
> > > +                check_result 0
> > > +            else
> > > +                echo "prio $priority -Q: expected 1, got $pkts"
> > > +                check_result 1
> > > +            fi
> > > +
> > > +            ip netns exec $NS ./cmsg_sender -$i -P $priority -d "$=
{DELAY}" \
> > > +                 -p $proto $TGT $PORT
> > > +
> > > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress=
 \
> > > +                | jq ".[] | select(.options.handle =3D=3D ${handle=
}) | \
> > > +                .options.actions[0].stats.packets")
> > > +            if [[ $pkts =3D=3D 2 ]]; then
> > > +                check_result 0
> > > +            else
> > > +                echo "prio $priority -P: expected 2, got $pkts"
> > > +                check_result 1
> > > +            fi
> > > +        done
> > > +        FILTER_COUNTER=3D$((FILTER_COUNTER + 10))

Why does the handle go up in steps of ten for each L3 and L4 protocol?

> > > +    done
> > > +done
> > > +
> > > +if [ $FAILED_TESTS -ne 0 ]; then
> > > +    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> > > +    exit 1
> > > +else
> > > +    echo "OK - All $TOTAL_TESTS tests passed"
> > > +    exit 0
> > > +fi
> > > +
> > > --
> > > 2.43.0
> > >
> >
> >



