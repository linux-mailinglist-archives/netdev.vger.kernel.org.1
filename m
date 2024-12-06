Return-Path: <netdev+bounces-149618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509B9E67EA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2F6160F46
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886EC1D89F8;
	Fri,  6 Dec 2024 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adio0qkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637D3D6B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469913; cv=none; b=MJFTn/nvf6agEuFP5/t0VOffm3sEQniygZeFIzANAD3DFjy/Fwq3VobZW/2x+WbGSPJvr87hVwyGLSER9K5ixwEj3L/MCevAS6GaKl6aLOATngxmCczmqqM7h+g8LG/Rni7oiqIIXDn4boMdtccfuz3MSMVMx40CdIRsI1y3vFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469913; c=relaxed/simple;
	bh=Bse29Fd1fYRo8QYsTAvJBEeOeThMAadTOTuFle0nFZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua8I9eUjUy5V8PBF4oMIhwQjxmdLQk0w/GL+uLBOHbWezacsO9kQ6XD/VbHhx41HW/q5JYHGU0MA4LjVD5icX01YgMcOBEnpQjp0Z9mIoGfsfRHdC8lDheYT1SRj1CJYVR23Y86h1vBsKt0FCfNVeYLG/r4lqyBN1VKkWUWRHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adio0qkq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a7def51c9cso4776615ab.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 23:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733469910; x=1734074710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQOktejdcf72p7/W3RQrrUHUnwzpcanYKI885nppsuM=;
        b=adio0qkqB0/XeOi59PmTly7d/QKwKQsCKOnwrFzYWoZz9j2aGMmo39M0cr/5cM5DDS
         7t1SBvS6eaFd+1W6+FeJHuS9l3NnXTKeaKIH3L7VkWWjazBNNpjKLh6KDzFquNohlhQ5
         iqrF8UqDTBY1h4WiIUe6q0yT+1A9UgnxDDcuQ7UJaJS2CipbEwvh67n+UnfALQSD+U64
         zbnegPTLAjt4SYs2ic09bGsEY/S86tvYEf4w+6ahw7f8iXZ452GaWHt8OosdpadgJic9
         jpdHvLdztwil2JKX0DYwo0r4i1whMpreoeHRNDqBNcRPBlhLMf1lI8GbE/uU2OEuN8wN
         1bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733469910; x=1734074710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQOktejdcf72p7/W3RQrrUHUnwzpcanYKI885nppsuM=;
        b=ErzOvoFA98sU764POFX8MV784+yOvolVO4RwaR1+HmOO+0+DsSMGB+PhtJVzLYmtKT
         YXo7ON+oEVLXM9CJ/MkbaUeNHIXQoPGl0RjcxFeNJCIJo+bC6es2OAyxO19v84+mI3du
         L3EBFQ8zTTJDGQZ5EdWWGRmf8ZlUTPRY1ylnezpUgwAx0LQd+enalkDAN/83T5JjFoj/
         tIm+NIN7WKRmP5BdTDCzeiHXEGJ3bvL5WBKXtwOqjyGQuHTEpGq7uffj+gni28D1Gtm8
         KogDf4iuBr5dgqu2K8Lj0hVJhrvhs18+x9soYr1mbYyIkcrW+m0Y09S1i2ie2Zom6GkE
         xIjg==
X-Gm-Message-State: AOJu0YzXHvahF+N/gGapz5ozkkgKP9mNVLuQxW5n70tH9WMwrBIFO+Zr
	8JPaF/ishx5CgDWrU2aDzcg3LFSI5eH6oCxaMdJECoZZ/C9T8qnmAJMPANdDZOmQ7x7lQd07zaj
	lxPXWOXAM1/YavhLqCirO3MoMUEc=
X-Gm-Gg: ASbGncuDbIJmNr463n8sXbmeGgk3VvacdqIHjZAOXGz2tFd7JVEadGhiy1Lz5lU2yuy
	n0mRRxl1R8NB/RKEnIlv0xQgN4l+yHQlpTyWw0RG/U9j2O+EzgAcyRuMKIzTJJuFeig==
X-Google-Smtp-Source: AGHT+IHyDm3a+2o+hdOBFhetRleE9U7lIxMCIFUX8S4gSHbKl8EWDdRrN3qsO/17OFJ/MY4K2U4E4JePQZrS26ZH2zI=
X-Received: by 2002:a05:6e02:1d05:b0:3a7:c5ff:e60b with SMTP id
 e9e14a558f8ab-3a811d99194mr27506515ab.6.1733469910616; Thu, 05 Dec 2024
 23:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
 <20241205133112.17903-4-annaemesenyiri@gmail.com> <6751cb5f3c7d3_119ae629480@willemb.c.googlers.com.notmuch>
In-Reply-To: <6751cb5f3c7d3_119ae629480@willemb.c.googlers.com.notmuch>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Fri, 6 Dec 2024 08:24:59 +0100
Message-ID: <CAKm6_RvGMvd6L5_xwtVtrR+To05xv7nQF2J7i-Xy8sthhfirdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, idosch@idosch.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=91p=
ont:
2024. dec. 5., Cs, 16:48):
>
> Anna Emese Nyiri wrote:
> > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > ancillary data.
> >
> > cmsg_so_priority.sh script added to validate SO_PRIORITY behavior
> > by creating VLAN device with egress QoS mapping and testing packet
> > priorities using flower filters. Verify that packets with different
> > priorities are correctly matched and counted by filters for multiple
> > protocols and IP versions.
> >
> > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > ---
> >  tools/testing/selftests/net/Makefile          |   1 +
> >  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
> >  .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++++++
> >  3 files changed, 162 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index cb2fc601de66..f09bd96cc978 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -32,6 +32,7 @@ TEST_PROGS +=3D ioam6.sh
> >  TEST_PROGS +=3D gro.sh
> >  TEST_PROGS +=3D gre_gso.sh
> >  TEST_PROGS +=3D cmsg_so_mark.sh
> > +TEST_PROGS +=3D cmsg_so_priority.sh
> >  TEST_PROGS +=3D cmsg_time.sh cmsg_ipv6.sh
> >  TEST_PROGS +=3D netns-name.sh
> >  TEST_PROGS +=3D nl_netdev.py
> > diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/=
selftests/net/cmsg_sender.c
> > index 876c2db02a63..99b0788f6f0c 100644
> > --- a/tools/testing/selftests/net/cmsg_sender.c
> > +++ b/tools/testing/selftests/net/cmsg_sender.c
> > @@ -59,6 +59,7 @@ struct options {
> >               unsigned int proto;
> >       } sock;
> >       struct option_cmsg_u32 mark;
> > +     struct option_cmsg_u32 priority;
> >       struct {
> >               bool ena;
> >               unsigned int delay;
> > @@ -97,6 +98,8 @@ static void __attribute__((noreturn)) cs_usage(const =
char *bin)
> >              "\n"
> >              "\t\t-m val  Set SO_MARK with given value\n"
> >              "\t\t-M val  Set SO_MARK via setsockopt\n"
> > +            "\t\t-P val  Set SO_PRIORITY via setsockopt\n"
>
> Not in the actual code

I added the -P option only to the documentation. The -P option was
already present in the code, but it was missing from the
documentation. In the previous patch, Ido requested that I include it
in the documentation.

>
> > +            "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
> >              "\t\t-d val  Set SO_TXTIME with given delay (usec)\n"
> >              "\t\t-t      Enable time stamp reporting\n"
> >              "\t\t-f val  Set don't fragment via cmsg\n"
> > @@ -115,7 +118,7 @@ static void cs_parse_args(int argc, char *argv[])
> >  {
> >       int o;
> >
> > -     while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H=
:")) !=3D -1) {
> > +     while ((o =3D getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H=
:Q:")) !=3D -1) {
> >               switch (o) {
> >               case 's':
> >                       opt.silent_send =3D true;
> > @@ -148,6 +151,10 @@ static void cs_parse_args(int argc, char *argv[])
> >                       opt.mark.ena =3D true;
> >                       opt.mark.val =3D atoi(optarg);
> >                       break;
> > +             case 'Q':
> > +                     opt.priority.ena =3D true;
> > +                     opt.priority.val =3D atoi(optarg);
> > +                     break;
> >               case 'M':
> >                       opt.sockopt.mark =3D atoi(optarg);
> >                       break;
> > @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbu=
f, size_t cbuf_sz)
> >
> >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> >                         SOL_SOCKET, SO_MARK, &opt.mark);
> > +     ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > +                     SOL_SOCKET, SO_PRIORITY, &opt.priority);
> >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> >                         SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
> >       ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/te=
sting/selftests/net/cmsg_so_priority.sh
> > new file mode 100755
> > index 000000000000..016458b219ba
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > @@ -0,0 +1,151 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +source lib.sh
> > +
> > +IP4=3D192.0.2.1/24
> > +TGT4=3D192.0.2.2
> > +TGT4_RAW=3D192.0.2.3
> > +IP6=3D2001:db8::1/64
> > +TGT6=3D2001:db8::2
> > +TGT6_RAW=3D2001:db8::3
> > +PORT=3D1234
> > +DELAY=3D4000
> > +TOTAL_TESTS=3D0
> > +FAILED_TESTS=3D0
> > +
> > +if ! command -v jq &> /dev/null; then
> > +    echo "Error: jq is not installed." >&2
> > +    exit 1
>
> use KSFT_ and in these cases skip rather than fail.
>
> > +fi
> > +
> > +check_result() {
> > +    ((TOTAL_TESTS++))
> > +    if [ "$1" -ne 0 ]; then
> > +        ((FAILED_TESTS++))
> > +    fi
> > +}
> > +
> > +cleanup()
> > +{
> > +    cleanup_ns $NS
> > +}
> > +
> > +trap cleanup EXIT
> > +
> > +setup_ns NS
> > +
> > +create_filter() {
> > +    local handle=3D$1
> > +    local vlan_prio=3D$2
> > +    local ip_type=3D$3
> > +    local proto=3D$4
> > +    local dst_ip=3D$5
> > +    local ip_proto
> > +
> > +    if [[ "$proto" =3D=3D "u" ]]; then
> > +        ip_proto=3D"udp"
> > +    elif [[ "$ip_type" =3D=3D "ipv4" && "$proto" =3D=3D "i" ]]; then
> > +        ip_proto=3D"icmp"
> > +    elif [[ "$ip_type" =3D=3D "ipv6" && "$proto" =3D=3D "i" ]]; then
> > +        ip_proto=3D"icmpv6"
> > +    fi
> > +
> > +    tc -n $NS filter add dev dummy1 \
> > +        egress pref 1 handle "$handle" proto 802.1q \
> > +        flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
> > +        dst_ip "$dst_ip" ${ip_proto:+ip_proto $ip_proto} \
> > +        action pass
> > +}
> > +
> > +ip -n $NS link set dev lo up
> > +ip -n $NS link add name dummy1 up type dummy
> > +
> > +ip -n $NS link add link dummy1 name dummy1.10 up type vlan id 10 \
> > +    egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> > +
> > +ip -n $NS address add $IP4 dev dummy1.10
> > +ip -n $NS address add $IP6 dev dummy1.10
> > +
> > +ip netns exec $NS sysctl -wq net.ipv4.ping_group_range=3D'0 2147483647=
'
> > +
> > +ip -n $NS neigh add $TGT4 lladdr 00:11:22:33:44:55 nud permanent \
> > +    dev dummy1.10
> > +ip -n $NS neigh add $TGT6 lladdr 00:11:22:33:44:55 nud permanent \
> > +    dev dummy1.10
> > +ip -n $NS neigh add $TGT4_RAW lladdr 00:11:22:33:44:66 nud permanent \
> > +    dev dummy1.10
> > +ip -n $NS neigh add $TGT6_RAW lladdr 00:11:22:33:44:66 nud permanent \
> > +    dev dummy1.10
> > +
> > +tc -n $NS qdisc add dev dummy1 clsact
> > +
> > +FILTER_COUNTER=3D10
> > +
> > +for i in 4 6; do
> > +    for proto in u i r; do
> > +        echo "Test IPV$i, prot: $proto"
> > +        for priority in {0..7}; do
> > +            if [[ $i =3D=3D 4 && $proto =3D=3D "r" ]]; then
> > +                TGT=3D$TGT4_RAW
> > +            elif [[ $i =3D=3D 6 && $proto =3D=3D "r" ]]; then
> > +                TGT=3D$TGT6_RAW
> > +            elif [ $i =3D=3D 4 ]; then
> > +                TGT=3D$TGT4
> > +            else
> > +                TGT=3D$TGT6
> > +            fi
> > +
> > +            handle=3D"${FILTER_COUNTER}${priority}"
> > +
> > +            create_filter $handle $priority ipv$i $proto $TGT
> > +
> > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress \
> > +                | jq ".[] | select(.options.handle =3D=3D ${handle}) |=
 \
> > +                .options.actions[0].stats.packets")
> > +
> > +            if [[ $pkts =3D=3D 0 ]]; then
> > +                check_result 0
> > +            else
> > +                echo "prio $priority: expected 0, got $pkts"
> > +                check_result 1
> > +            fi
> > +
> > +            ip netns exec $NS ./cmsg_sender -$i -Q $priority -d "${DEL=
AY}" \
> > +                 -p $proto $TGT $PORT
> > +
> > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress \
> > +                | jq ".[] | select(.options.handle =3D=3D ${handle}) |=
 \
> > +                .options.actions[0].stats.packets")
> > +            if [[ $pkts =3D=3D 1 ]]; then
> > +                check_result 0
> > +            else
> > +                echo "prio $priority -Q: expected 1, got $pkts"
> > +                check_result 1
> > +            fi
> > +
> > +            ip netns exec $NS ./cmsg_sender -$i -P $priority -d "${DEL=
AY}" \
> > +                 -p $proto $TGT $PORT
> > +
> > +            pkts=3D$(tc -n $NS -j -s filter show dev dummy1 egress \
> > +                | jq ".[] | select(.options.handle =3D=3D ${handle}) |=
 \
> > +                .options.actions[0].stats.packets")
> > +            if [[ $pkts =3D=3D 2 ]]; then
> > +                check_result 0
> > +            else
> > +                echo "prio $priority -P: expected 2, got $pkts"
> > +                check_result 1
> > +            fi
> > +        done
> > +        FILTER_COUNTER=3D$((FILTER_COUNTER + 10))
> > +    done
> > +done
> > +
> > +if [ $FAILED_TESTS -ne 0 ]; then
> > +    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> > +    exit 1
> > +else
> > +    echo "OK - All $TOTAL_TESTS tests passed"
> > +    exit 0
> > +fi
> > +
> > --
> > 2.43.0
> >
>
>

