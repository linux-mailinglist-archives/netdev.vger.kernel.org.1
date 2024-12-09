Return-Path: <netdev+bounces-150159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AA09E93E5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88E0162366
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAA21B1A7;
	Mon,  9 Dec 2024 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxVN93HB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28633215182
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747305; cv=none; b=K5IrBGkv3Z3jCTeys89NMPmciwA4uLK7opMxV010NLWvJnAYSPklzw2R9Ok4bh7fMxL/S1/qJr/TezhTrhOMH/llZGm3bvdMx2RelZRpSoKSerZ/JbLO4qtyXxTQ5/q1o3Os+hAYNCN+UZVd2D86CrgKdG0nm43T/4U97s87WxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747305; c=relaxed/simple;
	bh=hmXLtA1smA0K0wtLSiqaYSOhAE/eV0v/Ag+3Jygq9ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyut+xVSMS9nlUCHtwqAD+FfjfHimBEp5K2aZP1XlWqIYzuj1c81YbJR5o40Hxd7kYGxtzRAHkhMK3LKcuvV7M1bEbOzbIWRdKeFko3en6F285Cd+vEyEB1ZwkGr9gmv8ww1WlF3E1uQKgrrmFLwfZg+lfVhZQaClgxzmMMOw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxVN93HB; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-841acc8151aso310548139f.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733747302; x=1734352102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lCuEM83ol0ZJfSecXBMplgbkzx5CJUV7rQb64FJDno=;
        b=FxVN93HB+eB6Hr7i70cLHwzJgcsN5LbSCfWce+xCc5Jjc/Ct1r7n9lqpRNNvfvVhoo
         mg5Iwu8F9XX228qxczD5xX5zYGSEfp23EoKjhLEFjY54OzCfJ8teBeD42zqnBtmkrBc/
         SizFHdNwRSyDVBiTHftaj3OH29uVkgj/r1+gfR3iHy7A1w+IzcUumzJzu90zCT3OcIID
         3feMcZ1L2hSeeizb9Klc8d4eIxpL6lABdX7JGfyBRN5voY4INqY3OohpZukIEp+HN1Fy
         WvO3N/jpUptwkWAnjEshRs45du3kXl2oXhXiOhYqMThdNO3Azj2BpSOY2LL65UeJja36
         zs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747302; x=1734352102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lCuEM83ol0ZJfSecXBMplgbkzx5CJUV7rQb64FJDno=;
        b=rgYPt/bQQwPu3I2QoDvGh4XdCtDbUv1yxy/GfkTqwAnrTzd/MUDj0nxhDHXwyA/xly
         jKhlh8/Od5NEOgNmFJpAYstR76jxHT1FpTvEeTQQf60ri5bqo3pmkBhxCaWx1TSKCv9Y
         7HF+cDY2Z31M2zNN8IB7pg1UdNFot3TnZ5jJc5ZDy8e0hkagkXabgWb4iyNbQ87ppF5w
         CNhQ89o4xSrjciw+f5ft7WBIsFKLaBNAQymfLwGYjWPY9lXGepl3m5wYjSjDJTGIGd4I
         irzSmAi285kQjapS2RwU04cE216UAbAHM0lPmOy8RU+QQs6OWcSbFphrjv/Vlikn/9UL
         uU+g==
X-Gm-Message-State: AOJu0YzdGT/8Xio8aSISb5lGHK2e+lP3BC2gyo1+imF7OpjNEb/wbz5T
	NlInPk/XSg/Enp+kVLSO/vyvoJLCJI8ErCmMHR3M5eaGYVjUlKY/DLLBlhVpO4HztkvHX6zSDwM
	E5yxN+mjEDp6K3NKqwLVHipvY5Rk=
X-Gm-Gg: ASbGncvc984fiJn9HTDFVDcPdHGEVpA/IpVbYWctjbMZ79A0QwUNMuTHKeeekdmtLml
	RyLeBnDvPwxo22wbFB15KSVUiaZI3xfJPMQACS1PKhT2uRpYTgiYz1U1wzBB4FgQK
X-Google-Smtp-Source: AGHT+IHvRJkyMwb2dP1j5l84qM2y0qvkKP23ex9rmNXjrRXR+gOoWV3bNCuG8ON9yH5ZNup0KkkrHuZ8e8b3GK2qxQ0=
X-Received: by 2002:a05:6e02:18c7:b0:3a7:955e:1cc5 with SMTP id
 e9e14a558f8ab-3a9dbaba390mr2155885ab.1.1733747302149; Mon, 09 Dec 2024
 04:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
 <20241205133112.17903-4-annaemesenyiri@gmail.com> <6751cb5f3c7d3_119ae629480@willemb.c.googlers.com.notmuch>
 <CAKm6_RvGMvd6L5_xwtVtrR+To05xv7nQF2J7i-Xy8sthhfirdQ@mail.gmail.com> <6753241fe3a64_19948329459@willemb.c.googlers.com.notmuch>
In-Reply-To: <6753241fe3a64_19948329459@willemb.c.googlers.com.notmuch>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Mon, 9 Dec 2024 13:28:11 +0100
Message-ID: <CAKm6_Rvhvmdfd4ZrGvSqhUKEm5yg6ynb6oNcsBQwKchOnLfzhw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, idosch@idosch.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=91p=
ont:
2024. dec. 6., P, 17:19):
>
> Anna Nyiri wrote:
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=
=91pont:
> > 2024. dec. 5., Cs, 16:48):
> > >
> > > Anna Emese Nyiri wrote:
> > > > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > > > ancillary data.
> > > >
> > > > cmsg_so_priority.sh script added to validate SO_PRIORITY behavior
> > > > by creating VLAN device with egress QoS mapping and testing packet
> > > > priorities using flower filters. Verify that packets with different
> > > > priorities are correctly matched and counted by filters for multipl=
e
> > > > protocols and IP versions.
> > > >
> > > > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/net/Makefile          |   1 +
> > > >  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
> > > >  .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++=
++++
> > > >  3 files changed, 162 insertions(+), 1 deletion(-)
> > > >  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
> > > >
> > > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/s=
elftests/net/Makefile
> > > > index cb2fc601de66..f09bd96cc978 100644
> > > > --- a/tools/testing/selftests/net/Makefile
> > > > +++ b/tools/testing/selftests/net/Makefile
> > > > @@ -32,6 +32,7 @@ TEST_PROGS +=3D ioam6.sh
> > > >  TEST_PROGS +=3D gro.sh
> > > >  TEST_PROGS +=3D gre_gso.sh
> > > >  TEST_PROGS +=3D cmsg_so_mark.sh
> > > > +TEST_PROGS +=3D cmsg_so_priority.sh
> > > >  TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
> > > >  TEST_PROGS +=3D netns-name.sh
> > > >  TEST_PROGS +=3D nl_netdev.py
> > > > diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/test=
ing/selftests/net/cmsg_sender.c
> > > > index 876c2db02a63..99b0788f6f0c 100644
> > > > --- a/tools/testing/selftests/net/cmsg_sender.c
> > > > +++ b/tools/testing/selftests/net/cmsg_sender.c
> > > > @@ -59,6 +59,7 @@ struct options {
> > > >               unsigned int proto;
> > > >       } sock;
> > > >       struct option_cmsg_u32 mark;
> > > > +     struct option_cmsg_u32 priority;
> > > >       struct {
> > > >               bool ena;
> > > >               unsigned int delay;
> > > > @@ -97,6 +98,8 @@ static void __attribute__((noreturn)) cs_usage(co=
nst char *bin)
> > > >              "\n"
> > > >              "\t\t-m val  Set SO_MARK with given value\n"
> > > >              "\t\t-M val  Set SO_MARK via setsockopt\n"
> > > > +            "\t\t-P val  Set SO_PRIORITY via setsockopt\n"
> > >
> > > Not in the actual code
> >
> > I added the -P option only to the documentation. The -P option was
> > already present in the code, but it was missing from the
> > documentation. In the previous patch, Ido requested that I include it
> > in the documentation.
>
> Oh sorry. Missed that. Sounds good.
>
> > >
> > > > +            "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
> > > >              "\t\t-d val  Set SO_TXTIME with given delay (usec)\n"
> > > >              "\t\t-t      Enable time stamp reporting\n"
> > > >              "\t\t-f val  Set don't fragment via cmsg\n"
> > > > @@ -115,7 +118,7 @@ static void cs_parse_args(int argc, char *argv[=
])
> > > >  {
> > > >       int o;
> > > >
> > > > -     while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l=
:L:H:")) !=3D -1) {
> > > > +     while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l=
:L:H:Q:")) !=3D -1) {
> > > >               switch (o) {
> > > >               case 's':
> > > >                       opt.silent_send =3D true;
> > > > @@ -148,6 +151,10 @@ static void cs_parse_args(int argc, char *argv=
[])
> > > >                       opt.mark.ena =3D true;
> > > >                       opt.mark.val =3D atoi(optarg);
> > > >                       break;
> > > > +             case 'Q':
> > > > +                     opt.priority.ena =3D true;
> > > > +                     opt.priority.val =3D atoi(optarg);
> > > > +                     break;
> > > >               case 'M':
> > > >                       opt.sockopt.mark =3D atoi(optarg);
> > > >                       break;
> > > > @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char =
*cbuf, size_t cbuf_sz)
> > > >
> > > >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > > >                         SOL_SOCKET, SO_MARK, &opt.mark);
> > > > +     ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > > > +                     SOL_SOCKET, SO_PRIORITY, &opt.priority);
> > > >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > > >                         SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
> > > >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > > > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tool=
s/testing/selftests/net/cmsg_so_priority.sh
> > > > new file mode 100755
> > > > index 000000000000..016458b219ba
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > @@ -0,0 +1,151 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +source lib.sh
> > > > +
> > > > +IP4=3D192.0.2.1/24
> > > > +TGT4=3D192.0.2.2
> > > > +TGT4_RAW=3D192.0.2.3
> > > > +IP6=3D2001:db8::1/64
> > > > +TGT6=3D2001:db8::2
> > > > +TGT6_RAW=3D2001:db8::3
> > > > +PORT=3D1234
> > > > +DELAY=3D4000
> > > > +TOTAL_TESTS=3D0
> > > > +FAILED_TESTS=3D0
> > > > +
> > > > +if ! command -v jq &> /dev/null; then
> > > > +    echo "Error: jq is not installed." >&2
> > > > +    exit 1
> > >
> > > use KSFT_ and in these cases skip rather than fail.
> > >
> > > > +fi
> > > > +
> > > > +check_result() {
> > > > +    ((TOTAL_TESTS++))
> > > > +    if [ "$1" -ne 0 ]; then
> > > > +        ((FAILED_TESTS++))
> > > > +    fi
> > > > +}
> > > > +
> > > > +cleanup()
> > > > +{
> > > > +    cleanup_ns $NS
> > > > +}
> > > > +
> > > > +trap cleanup EXIT
> > > > +
> > > > +setup_ns NS
> > > > +
> > > > +create_filter() {
> > > > +    local handle=3D$1
> > > > +    local vlan_prio=3D$2
> > > > +    local ip_type=3D$3
> > > > +    local proto=3D$4
> > > > +    local dst_ip=3D$5
> > > > +    local ip_proto
> > > > +
> > > > +    if [[ "$proto" =3D=3D "u" ]]; then
> > > > +        ip_proto=3D"udp"
> > > > +    elif [[ "$ip_type" =3D=3D "ipv4" && "$proto" =3D=3D "i" ]]; th=
en
> > > > +        ip_proto=3D"icmp"
> > > > +    elif [[ "$ip_type" =3D=3D "ipv6" && "$proto" =3D=3D "i" ]]; th=
en
> > > > +        ip_proto=3D"icmpv6"
> > > > +    fi
> > > > +
> > > > +    tc -n $NS filter add dev dummy1 \
> > > > +        egress pref 1 handle "$handle" proto 802.1q \
> > > > +        flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
> > > > +        dst_ip "$dst_ip" ${ip_proto:+ip_proto $ip_proto} \
> > > > +        action pass
> > > > +}
> > > > +
> > > > +ip -n $NS link set dev lo up
> > > > +ip -n $NS link add name dummy1 up type dummy
> > > > +
> > > > +ip -n $NS link add link dummy1 name dummy1.10 up type vlan id 10 \
> > > > +    egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> > > > +
> > > > +ip -n $NS address add $IP4 dev dummy1.10
> > > > +ip -n $NS address add $IP6 dev dummy1.10
> > > > +
> > > > +ip netns exec $NS sysctl -wq net.ipv4.ping_group_range=3D'0 214748=
3647'
> > > > +
> > > > +ip -n $NS neigh add $TGT4 lladdr 00:11:22:33:44:55 nud permanent \
> > > > +    dev dummy1.10
> > > > +ip -n $NS neigh add $TGT6 lladdr 00:11:22:33:44:55 nud permanent \
> > > > +    dev dummy1.10
> > > > +ip -n $NS neigh add $TGT4_RAW lladdr 00:11:22:33:44:66 nud permane=
nt \
> > > > +    dev dummy1.10
> > > > +ip -n $NS neigh add $TGT6_RAW lladdr 00:11:22:33:44:66 nud permane=
nt \
> > > > +    dev dummy1.10
> > > > +
> > > > +tc -n $NS qdisc add dev dummy1 clsact
> > > > +
> > > > +FILTER_COUNTER=3D10
> > > > +
> > > > +for i in 4 6; do
> > > > +    for proto in u i r; do
> > > > +        echo "Test IPV$i, prot: $proto"
> > > > +        for priority in {0..7}; do
> > > > +            if [[ $i =3D=3D 4 && $proto =3D=3D "r" ]]; then
> > > > +                TGT=3D$TGT4_RAW
> > > > +            elif [[ $i =3D=3D 6 && $proto =3D=3D "r" ]]; then
> > > > +                TGT=3D$TGT6_RAW
> > > > +            elif [ $i =3D=3D 4 ]; then
> > > > +                TGT=3D$TGT4
> > > > +            else
> > > > +                TGT=3D$TGT6
> > > > +            fi
> > > > +
> > > > +            handle=3D"${FILTER_COUNTER}${priority}"
> > > > +
> > > > +            create_filter $handle $priority ipv$i $proto $TGT
> > > > +
> > > > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress=
 \
> > > > +                | jq ".[] | select(.options.handle =3D=3D ${handle=
}) | \
> > > > +                .options.actions[0].stats.packets")
> > > > +
> > > > +            if [[ $pkts =3D=3D 0 ]]; then
> > > > +                check_result 0
>
> Is there any chance for background traffic, for instance IPv6
> duplicate address detection if not passing nodad.
>
> > > > +            else
> > > > +                echo "prio $priority: expected 0, got $pkts"
> > > > +                check_result 1
> > > > +            fi
> > > > +
> > > > +            ip netns exec $NS ./cmsg_sender -$i -Q $priority -d "$=
{DELAY}" \
> > > > +                 -p $proto $TGT $PORT
> > > > +
> > > > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress=
 \
> > > > +                | jq ".[] | select(.options.handle =3D=3D ${handle=
}) | \
> > > > +                .options.actions[0].stats.packets")
> > > > +            if [[ $pkts =3D=3D 1 ]]; then
> > > > +                check_result 0
> > > > +            else
> > > > +                echo "prio $priority -Q: expected 1, got $pkts"
> > > > +                check_result 1
> > > > +            fi
> > > > +
> > > > +            ip netns exec $NS ./cmsg_sender -$i -P $priority -d "$=
{DELAY}" \
> > > > +                 -p $proto $TGT $PORT
> > > > +
> > > > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress=
 \
> > > > +                | jq ".[] | select(.options.handle =3D=3D ${handle=
}) | \
> > > > +                .options.actions[0].stats.packets")
> > > > +            if [[ $pkts =3D=3D 2 ]]; then
> > > > +                check_result 0
> > > > +            else
> > > > +                echo "prio $priority -P: expected 2, got $pkts"
> > > > +                check_result 1
> > > > +            fi
> > > > +        done
> > > > +        FILTER_COUNTER=3D$((FILTER_COUNTER + 10))
>
> Why does the handle go up in steps of ten for each L3 and L4 protocol?

For me, this numbering made the testing and debugging process more
straightforward. If it's an issue, I can adjust it.

> > > > +    done
> > > > +done
> > > > +
> > > > +if [ $FAILED_TESTS -ne 0 ]; then
> > > > +    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> > > > +    exit 1
> > > > +else
> > > > +    echo "OK - All $TOTAL_TESTS tests passed"
> > > > +    exit 0
> > > > +fi
> > > > +
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
>
>

