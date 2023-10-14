Return-Path: <netdev+bounces-41053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E647C9743
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC8D1C20949
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C526E10;
	Sat, 14 Oct 2023 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WH8+PCb3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9C1BDE3
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 23:24:45 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC4A9
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 16:24:43 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49d6bd360f8so1251103e0c.2
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697325882; x=1697930682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QymbZNWpmbl/raHak0OJz+WddUQqbHocqL5JbQ7z2YA=;
        b=WH8+PCb3zudqeL4RRXY4OlXVwoNaRc5IwjFHX7/JjX5W3+xyS/G26W7kZEZBr5gwVz
         Lkq9KMtzQDtTHdtSeu3p1ywub3aPu1Wy9DYCtpMKUmzUuGT7PGYsHLwlZjeuAkn382JN
         hcmcuTvwyPIBciM47LO4a+md1qIHh1PaTUk5GcRdPdY7+i1W0lgD8GMiFFKVitZi0OeO
         uiPtCKCEqkxpegYNRSh0W6dWP0A2mmk7lLflcjAbHiL5D/fvaSN/lw7VvwcDhV7IAWS4
         re+9SsrnjestTe+y+XcBzlZ4c+/8mOr/XuwesFeVhqX7puko9Fv06NflBtzaHWkjTzLS
         agGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697325882; x=1697930682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QymbZNWpmbl/raHak0OJz+WddUQqbHocqL5JbQ7z2YA=;
        b=A7EGR45YFk7dU7ucjQ2OuxC+Ez50HXarjMkhfrckBDhp5RwKW6b7Staw0RPxBeSmR8
         SML9/r/+3hAvu251kb3AhN7OFCmATVZejLhawshuYvn9ZMRLDOEPvm7+TIuhS/EJFYbW
         NIoucT+3O86tkaOZPwY1+AnQghHxIMBVhi2FhqKw2g1EDxHq0UMkRmYS8kWt+alONcFs
         uZNGm0FxWeTr9KCujmxZrteC+tXofojHG/38Fe7nzItKFyzufGH2bIJzPqrvINH80Kcg
         34+pGs0LABhccucbrPA0qQY3lZpmtKYWk1aodvhth9ivWKC0WML9lB8oB1NVEh7NR22I
         YM4Q==
X-Gm-Message-State: AOJu0YwvR2rj2exaJhSPoZU6qoBX1KxhL9S412z/lOV18c5J1GtAZJDI
	F14kMbBIqfErjTPiVM6aSf6FijPYnjIPdV6WRnVshA==
X-Google-Smtp-Source: AGHT+IGy/MlXkk29aTma+Z6ph7MSgIKjf/Kh1s/WqfZxboyac46udpXAxlTy+IpfVJufy7WINC0+iMkt2JpfdzhhPJ0=
X-Received: by 2002:a05:6102:3909:b0:457:a915:5e85 with SMTP id
 e9-20020a056102390900b00457a9155e85mr11387034vsu.28.1697325882386; Sat, 14
 Oct 2023 16:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net> <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
 <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
In-Reply-To: <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 14 Oct 2023 19:24:25 -0400
Message-ID: <CADVnQymFXvfG8=aj80RsqhnoaeYBxm-qscfcr1jcGNyYUf-icA@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Eric Dumazet <edumazet@google.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 6:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Fri, Oct 13, 2023 at 9:37=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net=
> wrote:
> > >
> > > Hi,
> > >
> > > Am 09.10.23 um 21:19 schrieb Neal Cardwell:
> > > > On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx=
.net> wrote:
> > > >>> Hi,
> > > >>> we recently switched on our ARM NXP i.MX6ULL based embedded devic=
e
> > > >>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. =
After
> > > >>> that we noticed a measurable performance regression on the Ethern=
et
> > > >>> interface (driver: fec, 100 Mbit link) while running iperf client=
 on the
> > > >>> device:
> > > >>>
> > > >>> BAD
> > > >>>
> > > >>> # iperf -t 10 -i 1 -c 192.168.1.129
> > > >>> ------------------------------------------------------------
> > > >>> Client connecting to 192.168.1.129, TCP port 5001
> > > >>> TCP window size: 96.2 KByte (default)
> > > >>> ------------------------------------------------------------
> > > >>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 =
port 5001
> > > >>> [ ID] Interval       Transfer     Bandwidth
> > > >>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
> > > >>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
> > > >>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
> > > >>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
> > > >>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
> > > >>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
> > > >>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
> > > >>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
> > > >>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
> > > >>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
> > > >>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
> > > >>>
> > > >>> GOOD
> > > >>>
> > > >>> # iperf -t 10 -i 1 -c 192.168.1.129
> > > >>> ------------------------------------------------------------
> > > >>> Client connecting to 192.168.1.129, TCP port 5001
> > > >>> TCP window size: 96.2 KByte (default)
> > > >>> ------------------------------------------------------------
> > > >>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 =
port 5001
> > > >>> [ ID] Interval       Transfer     Bandwidth
> > > >>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
> > > >>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
> > > >>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
> > > >>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
> > > >>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
> > > >>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
> > > >>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
> > > >>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
> > > >>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
> > > >>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
> > > >>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
> > > >>>
> > > >>> We were able to bisect this down to this commit:
> > > >>>
> > > >>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp:=
 adjust
> > > >>> TSO packet sizes based on min_rtt
> > > >>>
> > > >>> Disabling this new setting via:
> > > >>>
> > > >>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
> > > >>>
> > > >>> confirm that this was the cause of the performance regression.
> > > >>>
> > > >>> Is it expected that the new default setting has such a performanc=
e impact?
> > > > Indeed, thanks for the report.
> > > >
> > > > In addition to the "ss" output Eric mentioned, could you please gra=
b
> > > > "nstat" output, which should allow us to calculate the average TSO/=
GSO
> > > > and LRO/GRO burst sizes, which is the key thing tuned with the
> > > > tcp_tso_rtt_log knob.
> > > >
> > > > So it would be great to have the following from both data sender an=
d
> > > > data receiver, for both the good case and bad case, if you could st=
art
> > > > these before your test and kill them after the test stops:
> > > >
> > > > (while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
> > > > nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nsta=
t.txt
> > > i upload everything here:
> > > https://github.com/lategoodbye/tcp_tso_rtt_log_regress
> > >
> > > The server part is a Ubuntu installation connected to the internet. A=
t
> > > first i logged the good case, then i continued with the bad case.
> > > Accidentally i delete a log file of bad case, so i repeated the whole
> > > bad case again. So the uploaded bad case files are from the third run=
.
> >
> > Thanks for the detailed data!
> >
> > Here are some notes from looking at this data:
> >
> > + bad client: avg TSO burst size is roughly:
> > https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_=
client_bad.log
> > IpOutRequests                   308               44.7
> > IpExtOutOctets                  10050656        1403181.0
> > est bytes   per TSO burst: 10050656 / 308 =3D 32632
> > est packets per TSO burst: 32632 / 1448 ~=3D 22.5
> >
> > + good client: avg TSO burst size is roughly:
> > https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_=
client_good.log
> > IpOutRequests                   529               62.0
> > IpExtOutOctets                  11502992        1288711.5
> > est bytes   per TSO burst: 11502992 / 529 ~=3D 21745
> > est packets per TSO burst: 21745 / 1448 ~=3D 15.0
> >
> > + bad client ss data:
> > https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_cli=
ent_bad.log
> > State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> > ESTAB 0      236024  192.168.1.12:39228 192.168.1.129:5001
> > timer:(on,030ms,0) ino:25876 sk:414f52af rto:0.21 cwnd:68 ssthresh:20
> > reordering:0
> > Mbits/sec allowed by cwnd: 68 * 1448 * 8 / .0018 / 1000000.0 ~=3D 437.6
> >
> > + good client ss data:
> > https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_cli=
ent_good.log
> > Fri Oct 13 15:04:36 CEST 2023
> > State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> > ESTAB 0      425712  192.168.1.12:33284 192.168.1.129:5001
> > timer:(on,020ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
> > reordering:0
> > Mbits/sec allowed by cwnd: 106 * 1448 * 8 / .0028 / 1000000.0 =3D 438.5
> >
> > So it seems indeed like cwnd is not the limiting factor, and instead
> > there is something about the larger TSO/GSO bursts (roughly 22.5
> > packets per burst on average) in the "bad" case that is causing
> > problems, and preventing the sender from keeping the pipe fully
> > utilized.
> >
> > So perhaps the details of the tcp_tso_should_defer() logic are hurting
> > performance?
> >
> > The default value of tcp_tso_win_divisor is 3, and in the bad case the
> > cwnd / tcp_tso_win_divisor =3D 68 / 3 =3D 22.7 packets, which is
> > suspiciously close to the average TSO burst size of 22.5. So my guess
> > is that the tcp_tso_win_divisor of 3 is the dominant factor here, and
> > perhaps if we raise it to 5, then 68/5 ~=3D 13.60 will approximate the
> > TSO burst size in the "good" case, and fully utilize the pipe. So it
> > seems worth an experiment, to see what we can learn.
> >
> > To test that theory, could you please try running the following as
> > root on the data sender machine, and then re-running the "bad" test
> > with tcp_tso_rtt_log at the default value of 9?
> >
> >    sysctl net.ipv4.tcp_tso_win_divisor=3D5
> >
> > Thanks!
> > neal
>
> Hmm, we receive ~3200 acks per second, I am not sure the
> tcp_tso_should_defer() logic
> would hurt ?
>
> Also the ss binary on the client seems very old, or its output has
> been mangled perhaps ?
>
> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> ESTAB 0      492320  192.168.1.12:33284 192.168.1.129:5001
> timer:(on,030ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
> reordering:0

Yes, agreed, it would be super-useful if the next run could have both
a packet capture and newer/fuller ss output; perhaps something like:

(a) to run tcpdump on the data sender:

tcpdump -w /root/dump.pcap -n -s 116 -c 1000000 host $REMOTE_HOST -i
$INTERFACE &

(b) to build a newer ss:

git clone git://git.kernel.org/pub/scm/network/iproute2/iproute2.git
cd iproute2/
./configure
make

Thanks!
neal

