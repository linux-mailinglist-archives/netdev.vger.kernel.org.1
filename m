Return-Path: <netdev+bounces-150243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607019E98EE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEFD161688
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC115575F;
	Mon,  9 Dec 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktpgUpdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4C23313D
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754715; cv=none; b=qMbXbhvAl4fCVxFiNF5RU4aS2e7reKTj+u4v+tdQZGcSveUAyryuw39PwlXxgWrET3Crt604RozD8gAxbtWoVi0qPzHt9psM9qELhGdzLV7GCvXiUpb+9exl77CXbTKKY/QlBo/kqpef2RoCiKwMs/xNvYUUdBjtdtCwb91yAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754715; c=relaxed/simple;
	bh=MhfealCDqySBLn5juGHahWuXd8EMRr5usCna+BuLTus=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UGfVvUjj8N1/nN5iBN84QhTe2q/CUE3SMiGPr4UivgAlc2xDQ5wVlk2oD16hIRv+72Gs15euo/MyVGyEN5owzHqtMHrV8s7v2KmQ2sFXEZiXBfaADKBMVURjdIVtfHYwN1H6jDCYP1iaAN8bwfowL2zvCpgCgdkD/Dy6c6lDew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktpgUpdm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8918ec243so45389046d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 06:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733754711; x=1734359511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=140AQ21XBNJ98TnkcQ9rCEV1zMN+f2SiZ+g0BtoRiaA=;
        b=ktpgUpdmoZd7sf9EzzIja58v9yAQL5++f4+TuCInMZthUlAlO/7g3kaGYQ940FbZhH
         2gxGDipAZRZbtzbZ+NjXpJ8+XYdRnlMN0IPYejnBH0XuZ+WA6nlJJyGyqcv5DGOa9yGt
         lEOzXwainRhj6W7AkUM0DV/43LCixrWUZ+WIFOB57Crqm3/Akqjy9C+kBXYq2B98TDjm
         pqK5ijWRboJ0JOI9xNvjQM0hotM9U0lOR3LH6jFyRvrY3eqAW0uCHjlgKJRopIpyPA7V
         v/KzlWRc2lwac2sdD+yW/D/oynji8OMju9swTQ2n/Ib9YSq2coBMnw22ayv0+9DbUKv5
         zVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754711; x=1734359511;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=140AQ21XBNJ98TnkcQ9rCEV1zMN+f2SiZ+g0BtoRiaA=;
        b=MATjn38XnhFWkYpqv1wEBPZ1vjMWHMM9AANDHmx3KLjIiEeneUGru9RDWcpRW0rZKu
         H/7kTnge4C/dgl8c54+FHRPE2j/1U5U+7bW+6sJ08J7shysnSVBZSyarMlZZAVXcfLlW
         bR/7IJxiUc0t4HYxd4tgkdCzQCfaDg0tcvAf3bFdRH+F7KSYCCT+DWVUeqzniPav4sD8
         esArxcl0wTg+DJqHXmD1PUol/ZIj3B2h6TgDdAIiSadoLtVa8mUB2C7vbru6ZBIsFKfg
         28Es3Oet7uL++TB0dpoifAziWtozEmHEifsV89ABlOOnabNgTPo5l1k8FaYWUIZtSvdi
         vIvg==
X-Gm-Message-State: AOJu0YyRe/xi9r/ttWK8+HLYs2EXk9ABxz2BlsYj6upXYo1roEdH9sfC
	GHGjvnF0kGFlas0Nkr9z4V7T+JWbmjir4O7CrQdXwEs/srgY1lmmsB8Ovg==
X-Gm-Gg: ASbGncvW6/yp5TLtciHxxlnv858ir1uBxgF4SM/vc/JDxXpDvKTs9bxAiJrlUqQcsXk
	IGLHOm/rowpMxHPy+jb4ABq9d8Fvgvsv+Wwyu98oxFE3n1iFIMPWB7WrU09f56JcF34q1IJnML+
	2sObWrxUhhOnI1PqPRyHzmotBGFdJBSw4fRXAjS2OiXgaFs3iFxDzAWLrRrEz1Zoku1wx6o8lvM
	VIzZxSzoKZ2Hx5898vFCmBh0HUW8bBjM4ONk+NCUZKtAmaX3d4FIJdi9hsytRRxgZlVXjtKaZt2
	zkPckz/S0uuhBOl88nmv3w==
X-Google-Smtp-Source: AGHT+IHBLM1SpvZ6ybYs9QOjsiDXHF/aH6fACmLpDGtZ2ALlzXzrpEkXLXj46wYQXgfl2Rexx7lsYQ==
X-Received: by 2002:a05:6214:d6e:b0:6d8:9a85:5b4d with SMTP id 6a1803df08f44-6d91e2d378cmr13015736d6.5.1733754711491;
        Mon, 09 Dec 2024 06:31:51 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d801632esm76852585a.7.2024.12.09.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:31:50 -0800 (PST)
Date: Mon, 09 Dec 2024 09:31:50 -0500
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
Message-ID: <6756ff5651ba1_31657c2948a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAKm6_Rtc8YPFk9QQQZ2p5aiY1zodqy7i484gb=Yq=qrSQaYSoA@mail.gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
 <20241205133112.17903-4-annaemesenyiri@gmail.com>
 <6751cb5f3c7d3_119ae629480@willemb.c.googlers.com.notmuch>
 <CAKm6_Rtc8YPFk9QQQZ2p5aiY1zodqy7i484gb=Yq=qrSQaYSoA@mail.gmail.com>
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
> =

> Did you mean something like this?
> =

> #!/bin/bash
> # SPDX-License-Identifier: GPL-2.0
> =

> source lib.sh
> =

> DIR=3D"$(dirname $(readlink -f "$0"))"
> source "${DIR}"/../kselftest/ktap_helpers.sh
> =

> if ! command -v jq &> /dev/null; then
>     echo "SKIP cmsg_so_priroity.sh test: jq is not installed." >&2
>     exit "$KSFT_SKIP"
> fi

Yes, similar to ksft_runner.sh

It's helpful to differentiate skip from fail. Especially on external
system tool dependencies.

> Is a simple echo enough, or should I use ktap_skip_all instead?

The exit code should suffice. Your test does not generate ktap output.

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

Ack on FILTER_COUNTER btw.

